defmodule Omise.Customer do
  @moduledoc """
  Provides Customer API interfaces.

  https://www.omise.co/customers-api
  """

  defstruct [
    object:       "customer",
    id:           nil,
    livemode:     nil,
    location:     nil,
    default_card: nil,
    email:        nil,
    description:  nil,
    created:      nil,
    cards:        %Omise.List{data: [%Omise.Card{}]},
    deleted:      false
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    id:           String.t,
    livemode:     boolean,
    location:     String.t,
    default_card: String.t,
    email:        String.t,
    description:  String.t,
    created:      String.t,
    cards:        Omise.List.t,
    deleted:      boolean
  }

  @endpoint "customers"

  @doc """
  List all customers.

  Returns `{:ok, customers}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Customer.list

      Omise.Customer.list(limit: 5)

  """
  @spec list(Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.HTTP.make_request(:get, @endpoint, params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Customer.retrieve("cust_test_4xtrb759599jsxlhkrb")

  """
  @spec retrieve(String.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.HTTP.make_request(:get, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end

  @doc """
  Create a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `email` - (optional) Customer's email.
    * `description` - (optional) A custom description for the customer.
    * `card` - (optional) A card token in case you want to add a card to the customer.

  ## Examples

      # Create a customer without attaching a card
      Omise.Customer.create(
        email: "lucius@omise.co",
        description: "You know, it almost makes me wish for rain"
      )

      # Create a customer and attach a card
      Omise.Customer.create(
        email: "grouplove@omise.co",
        description: "Don't take me tongue tied",
        card: "tokn_test_51yer81s9aqqyktdoeh"
      )

  """
  @spec create(Keyword.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def create(params) do
    Omise.HTTP.make_request(:post, @endpoint, body: {:form, params}, as: %__MODULE__{})
  end

  @doc """
  Update a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `email` - (optional) Customer's email.
    * `description` - (optional) A custom description for the customer.
    * `card` - (optional) A card token in case you want to add a card to the customer.

  ## Examples

      # Update email and description.
      Omise.Customer.update("cust_test_51yerhn3ghztgv31n4p",
        email: "edward@omise.co",
        description: "Home is when I’m alone with you"
      )

      # Attach a card to a customer.
      Omise.Customer.update("cust_test_4xtrb759599jsxlhkrb",
        card: "tokn_test_4xs9408a642a1htto8z"
      )

  """
  @spec update(String.t, Keyword.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def update(id, params) do
    Omise.HTTP.make_request(:patch, "#{@endpoint}/#{id}", body: {:form, params}, as: %__MODULE__{})
  end

  @doc """
  Destroy a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Customers.destroy("cust_test_4xtrb759599jsxlhkrb")

  """
  @spec destroy(String.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def destroy(id) do
    Omise.HTTP.make_request(:delete, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end
end
