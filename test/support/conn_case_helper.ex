defmodule Todos.ConnCaseHelper do
    def render_json(view, template, assigns) do
        view.render(template, assigns) |> format_json
    end

    def response_body_to_map(resp_body, nest) do
        response_body = resp_body |> Poison.decode!

        Enum.reduce(Map.keys(response_body[nest]), %{}, fn(key, acc) ->
            Map.put(acc, String.to_atom(key), response_body[nest][key])
        end )
    end

    defp format_json(data) do
        data |> Poison.encode! |> Poison.decode!
    end
end
