defmodule Sentimeter.Invitations do
  @doc """
  Send an invitation
  ## Examples

      iex> send_invitations(%{email: email, response_guid: response_guid})
      {:ok, %Bamboo.Email{}}

      iex> send_invitations(%{field: bad_value})
      {:error, %Ecto.Changeset}

  """
  @callback send_invitation(invitation_attrs :: Map.t()) ::
              {:ok, %Bamboo.Email{}} | {:error, %Ecto.Changeset{}}

  @doc """
  Send a reminder about an invitation
  ## Examples

      iex> send_reminder(%{email: email, response_guid: response_guid})
      {:ok, %Bamboo.Email{}}

      iex> send_reminder(%{field: bad_value})
      {:error, %Ecto.Changeset}

  """
  @callback send_reminder(invitation_attrs :: Map.t()) ::
              {:ok, %Bamboo.Email{}} | {:error, %Ecto.Changeset{}}
end
