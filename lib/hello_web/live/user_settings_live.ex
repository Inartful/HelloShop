defmodule HelloWeb.UserSettingsLive do
  use HelloWeb, :live_view

  alias Hello.Accounts

  def render(assigns) do
    ~H"""
    <div style="background-color: white; border: 1px solid #77A0A4; border-radius: 15px; padding: 20px 30px; margin: 50px">
      <.header class="text-center">
        Настройки учетной записи
        <:subtitle>
          Управляйте своей учетной записью, адресом электронной почты и паролем.
        </:subtitle>
      </.header>

      <.button><.link href={~p"/users/log_out"} method="delete">Выйти</.link></.button>

      <div class="space-y-12 divide-y">
        <div>
          <.simple_form
            for={@nickname_form}
            id="nickname_form"
            phx-submit="update_nickname"
            phx-change="validate_nickname"
          >
            <.input
              field={@nickname_form[:nickname]}
              type="text"
              label="Имя пользователя"
              required
            />
            <.input
              field={@nickname_form[:current_password]}
              name="current_password"
              id="current_password_for_nickname"
              type="password"
              label="Текущий пароль"
              value={@nickname_form_current_password}
              required
            />
            <:actions>
              <.button phx-disable-with="Меняем...">Изменить имя пользователя</.button>
            </:actions>
          </.simple_form>
        </div>
        <div>
          <.simple_form
            for={@email_form}
            id="email_form"
            phx-submit="update_email"
            phx-change="validate_email"
          >
            <.input field={@email_form[:email]} type="email" label="Email" required />
            <.input
              field={@email_form[:current_password]}
              name="current_password"
              id="current_password_for_email"
              type="password"
              label="Текущий пароль"
              value={@email_form_current_password}
              required
            />
            <:actions>
              <.button phx-disable-with="Меняем...">Изменить Email</.button>
            </:actions>
          </.simple_form>
        </div>
        <div>
          <.simple_form
            for={@password_form}
            id="password_form"
            action={~p"/users/log_in?_action=password_updated"}
            method="post"
            phx-change="validate_password"
            phx-submit="update_password"
            phx-trigger-action={@trigger_submit}
          >
            <input
              name={@password_form[:email].name}
              type="hidden"
              id="hidden_user_email"
              value={@current_email}
            />
            <.input
              field={@password_form[:password]}
              type="password"
              label="Новый пароль"
              required
            />
            <.input
              field={@password_form[:password_confirmation]}
              type="password"
              label="Подтвердите новый пароль"
            />
            <.input
              field={@password_form[:current_password]}
              name="current_password"
              type="password"
              label="Текущий пароль"
              id="current_password_for_password"
              value={@current_password}
              required
            />
            <:actions>
              <.button phx-disable-with="Меняем...">Изменить пароль</.button>
            </:actions>
          </.simple_form>
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"token" => token}, _session, socket) do
    socket =
      case Accounts.update_user_email(socket.assigns.current_user, token) do
        :ok ->
          put_flash(socket, :info, "Электронная почта успешно изменена.")

        :error ->
          put_flash(socket, :error, "Ссылка на изменение адреса электронной почты недействительна или срок ее действия истек..")
      end

    {:ok, push_navigate(socket, to: ~p"/users/settings")}
  end

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    email_changeset = Accounts.change_user_email(user)
    password_changeset = Accounts.change_user_password(user)
    username_changeset = Accounts.change_user_nickname(user)

    socket =
      socket
      |> assign(:current_password, nil)
      |> assign(:email_form_current_password, nil)
      |> assign(:nickname_form_current_password, nil)
      |> assign(:current_email, user.email)
      |> assign(:current_nickname, user.nickname)
      |> assign(:email_form, to_form(email_changeset))
      |> assign(:password_form, to_form(password_changeset))
      |> assign(:nickname_form, to_form(username_changeset))
      |> assign(:trigger_submit, false)

    {:ok, socket}
  end

  def handle_event("validate_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    email_form =
      socket.assigns.current_user
      |> Accounts.change_user_email(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, email_form: email_form, email_form_current_password: password)}
  end

  def handle_event("update_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.apply_user_email(user, password, user_params) do
      {:ok, applied_user} ->
        Accounts.deliver_user_update_email_instructions(
          applied_user,
          user.email,
          &url(~p"/users/settings/confirm_email/#{&1}")
        )

        info = "A link to confirm your email change has been sent to the new address."
        {:noreply, socket |> put_flash(:info, info) |> assign(email_form_current_password: nil)}

      {:error, changeset} ->
        {:noreply, assign(socket, :email_form, to_form(Map.put(changeset, :action, :insert)))}
    end
  end

  def handle_event("validate_password", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    password_form =
      socket.assigns.current_user
      |> Accounts.change_user_password(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, password_form: password_form, current_password: password)}
  end

  def handle_event("update_password", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.update_user_password(user, password, user_params) do
      {:ok, user} ->
        password_form =
          user
          |> Accounts.change_user_password(user_params)
          |> to_form()

        {:noreply, assign(socket, trigger_submit: true, password_form: password_form)}

      {:error, changeset} ->
        {:noreply, assign(socket, password_form: to_form(changeset))}
    end
  end

  def handle_event("validate_nickname", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    nickname_form =
      socket.assigns.current_user
      |> Accounts.change_user_nickname(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply,
     assign(socket, nickname_form: nickname_form, nickname_form_current_password: password)}
  end

  def handle_event("update_nickname", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.apply_user_nickname(user, password, user_params) do
      {:ok, _} ->
        info = "Your nickname has been updated successfully."

        {:noreply,
         socket |> put_flash(:info, info) |> assign(nickname_form_current_password: nil)}

      {:error, changeset} ->
        {:noreply, assign(socket, :nickname_form, to_form(Map.put(changeset, :action, :insert)))}

        #   info = "A link to confirm your email change has been sent to the new address."
        #   {:noreply, socket |> put_flash(:info, info) |> assign(email_form_current_password: nil)}

        # {:error, changeset} ->
        #   {:noreply, assign(socket, :email_form, to_form(Map.put(changeset, :action, :insert)))}
    end
  end
end
