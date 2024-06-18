defmodule HelloWeb.UserForgotPasswordLive do
  use HelloWeb, :live_view

  alias Hello.Accounts

  def render(assigns) do
    ~H"""
    <div
      class="mx-auto max-w-sm"
      style="background-color: white; border: 1px solid #77A0A4; border-radius: 15px; padding: 20px 30px; margin-top: 20px; margin-bottom: 20px"
    >
      <div class="mx-auto max-w-sm">
        <.header class="text-center">
          Забыли пароль?
          <:subtitle>Мы отправим ссылку для сброса пароля на вашу почту.</:subtitle>
        </.header>

        <.simple_form for={@form} id="reset_password_form" phx-submit="send_email">
          <.input field={@form[:email]} type="email" placeholder="Email" required />
          <:actions>
            <.button phx-disable-with="Отправляем..." class="w-full">
              Отправить инструкции по сбросу пароля
            </.button>
          </:actions>
        </.simple_form>
        <p class="text-center text-sm mt-4">
          <.link href={~p"/users/register"}>Зарегистрироваться</.link>
          | <.link href={~p"/users/log_in"}>Авторизироваться</.link>
        </p>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/users/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
