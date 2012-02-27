module Make (O : Map.OrderedType) = 
struct
  include Map.Make (O)

  module Exceptionless = 
  struct
    let find k map = try Some (find k map) with Not_found -> None
  end

  let modify_def def k f map = 
    add k (match Exceptionless.find k map with
      | None -> f def
      | Some v -> f v) map

  let print ?(first="{") ?(last="}") ?(sep=",") f_k f_v oc map =
    BatList.print ~first ~last ~sep (fun oc (k, v) -> 
      begin
        f_k oc k;
        f_v oc v;
      end) oc (bindings map)
end