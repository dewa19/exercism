defmodule RobotSimulator do
  @doc """
  source : https://exercism.org/tracks/elixir/exercises/robot-simulator
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  defmodule Robot do
    defstruct direction: nil,
              position: {0, 0}
  end

  @spec create(direction :: atom, position :: {integer, integer}) :: any

  def create(:north, position), do: %Robot{direction: :north, position: position}

  def create(:east, position), do: %Robot{direction: :east, position: position}

  def create(:south, position), do: %Robot{direction: :south, position: position}

  def create(:west, position), do: %Robot{direction: :west, position: position}

  def create(_, _position), do: {:error, "invalid direction"}

  def do_advance(robot, where_headed) do
    {initial_x, initial_y} = position(robot)

    new_position =
      case where_headed do
        :north ->
          {initial_x, initial_y + 1}

        :east ->
          {initial_x + 1, initial_y}

        :south ->
          {initial_x, initial_y - 1}

        :west ->
          {initial_x - 1, initial_y}

        _ ->
          {initial_x, initial_y}
      end

    new_position
  end

  def do_move(robot, "R") do
    head_to = direction(robot)

    new_direction =
      case head_to do
        :north ->
          :east

        :east ->
          :south

        :south ->
          :west

        :west ->
          :north
      end

    new_position = Map.put(robot, :direction, new_direction)

    new_position
  end

  def do_move(robot, "L") do
    head_to = direction(robot)

    new_direction =
      case head_to do
        :north ->
          :west

        :east ->
          :north

        :south ->
          :east

        :west ->
          :south
      end

    new_position = Map.put(robot, :direction, new_direction)

    new_position
  end

  def do_move(robot, "A") do
    head_to = direction(robot)
    {new_x, new_y} = do_advance(robot, head_to)

    new_robot_position = Map.put(robot, :position, {new_x, new_y})

    new_robot_position
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    %Robot{direction: direction} = robot
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    %Robot{position: {x, y}} = robot
    {x, y}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    list_of_instructions = String.split(instructions, "", trim: true)

    list_of_instructions
    |> Enum.reduce(robot, fn an_instruction, robot -> do_move(robot, an_instruction) end)
  end
end
