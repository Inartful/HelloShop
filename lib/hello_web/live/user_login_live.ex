defmodule HelloWeb.UserLoginLive do
  use HelloWeb, :live_view

  def render(assigns) do
    ~H"""
    <div
      class="mx-auto max-w-sm"
      style="background-color: white; border: 1px solid #77A0A4; border-radius: 15px; padding: 20px 30px; margin-top: 20px; margin-bottom: 20px"
    >
      <div class="mx-auto max-w-sm">
        <.header class="text-center">
          Войдите в аккаунт
          <:subtitle>
            У вас нет учетной записи?
            <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
              Зарегистрируйтесь.
            </.link>
          </:subtitle>
        </.header>

        <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
          <.input field={@form[:email]} type="email" label="Email" required />
          <.input field={@form[:password]} type="password" label="Пароль" required />

          <:actions>
            <.input
              field={@form[:remember_me]}
              type="checkbox"
              label="Не выходить из системы"
            />
            <.link href={~p"/users/reset_password"} class="text-sm font-semibold">
              Забыли пароль?
            </.link>
          </:actions>
          <:actions>
            <.button phx-disable-with="Logging in..." class="w-full">
              Авторизоваться <span aria-hidden="true">→</span>
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
