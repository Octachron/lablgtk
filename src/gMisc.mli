(* $Id$ *)

open Gtk
open GObj
open GContainer

(** Miscellaneous widgets *)

(** @gtkdoc gtk GtkSeparator
   @gtkdoc gtk GtkHSeparator
   @gtkdoc gtk GtkVSeparator *)
val separator :
  Tags.orientation ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> widget_full

(** {3 Statusbar} *)

class statusbar_context :
  Gtk.statusbar obj -> Gtk.statusbar_context ->
  object
    val context : Gtk.statusbar_context
    val obj : Gtk.statusbar obj
    method context : Gtk.statusbar_context
    method flash : ?delay:int -> string -> unit
    method pop : unit -> unit
    method push : string -> statusbar_message
    method remove : statusbar_message -> unit
  end

(** Report messages of minor importance to the user
   @gtkdoc gtk GtkStatusbar *)
class statusbar : Gtk.statusbar obj ->
  object
    inherit GContainer.container_full
    val obj : Gtk.statusbar obj
    method new_context : name:string -> statusbar_context
  end

(** @gtkdoc gtk GtkStatusbar *)
val statusbar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> statusbar

(** {3 Calendar} *)

(** @gtkdoc gtk GtkCalendar *)
class calendar_signals : 'a obj ->
  object
    inherit GObj.widget_signals
    constraint 'a = [> calendar]
    val obj : 'a obj
    method day_selected : callback:(unit -> unit) -> GtkSignal.id
    method day_selected_double_click :
      callback:(unit -> unit) -> GtkSignal.id
    method month_changed : callback:(unit -> unit) -> GtkSignal.id
    method next_month : callback:(unit -> unit) -> GtkSignal.id
    method next_year : callback:(unit -> unit) -> GtkSignal.id
    method prev_month : callback:(unit -> unit) -> GtkSignal.id
    method prev_year : callback:(unit -> unit) -> GtkSignal.id
  end

(** Display a calendar and/or allow the user to select a date
   @gtkdoc gtk GtkCalendar *)
class calendar : Gtk.calendar obj ->
  object
    inherit GObj.widget
    val obj : Gtk.calendar obj
    method event : event_ops
    method clear_marks : unit
    method connect : calendar_signals
    method date : int * int * int
    method display_options : Tags.calendar_display_options list -> unit
    method freeze : unit -> unit
    method mark_day : int -> unit
    method select_day : int -> unit
    method select_month : month:int -> year:int -> unit
    method thaw : unit -> unit
    method unmark_day : int -> unit
  end

(** @gtkdoc gtk GtkCalendar *)
val calendar :
  ?options:Tags.calendar_display_options list ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> calendar

(** {3 Drawing Area} *)

(** A widget for custom user interface elements
   @gtkdoc gtk GtkDrawingArea *)
class drawing_area : Gtk.drawing_area obj ->
  object
    inherit GObj.widget_full
    val obj : Gtk.drawing_area obj
    method event : event_ops
    method set_size : width:int -> height:int -> unit
  end

(** @gtkdoc gtk GtkDrawingArea *)
val drawing_area :
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> drawing_area

(** {3 Misc. Widgets} *)

(** A base class for widgets with alignments and padding
   @gtkdoc gtk GtkMisc *)
class misc : ([> Gtk.misc] as 'a) obj ->
  object
    inherit GObj.widget
    val obj : 'a obj
    method set_xalign : float -> unit
    method set_yalign : float -> unit
    method set_xpad : int -> unit
    method set_ypad : int -> unit
    method xalign : float
    method yalign : float
    method xpad : int
    method ypad : int
  end

(** Produces an arrow pointing in one of the four cardinal directions
   @gtkdoc gtk GtkArrow *)
class arrow : ([> Gtk.arrow] as 'a) obj ->
  object
    inherit misc
    val obj : 'a obj
    method set_kind : Tags.arrow_type -> unit
    method set_shadow : Tags.shadow_type -> unit
    method kind : Tags.arrow_type
    method shadow : Tags.shadow_type
  end

(** @gtkdoc gtk GtkArrow *)
val arrow :
  ?kind:Tags.arrow_type ->
  ?shadow:Tags.shadow_type ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> arrow

type image_type = 
  [ `EMPTY | `PIXMAP | `IMAGE | `PIXBUF | `STOCK | `ICON_SET | `ANIMATION ]

(** A widget displaying an image
   @gtkdoc gtk GtkImage *)
class image : 'a obj ->
  object
    inherit misc
    constraint 'a = [> Gtk.image]
    val obj : 'a obj
    method storage_type : image_type
    method set_image : Gdk.image -> unit
    method set_pixmap : GDraw.pixmap -> unit
    method set_mask : Gdk.bitmap option -> unit
    method set_file : string -> unit
    method set_pixbuf : GdkPixbuf.pixbuf -> unit
    method set_stock : GtkStock.id -> unit
    method set_icon_set : icon_set -> unit
    method set_icon_size : Tags.icon_size -> unit
    method image : Gdk.image
    method pixmap : GDraw.pixmap
    method mask : Gdk.bitmap option
    method pixbuf : GdkPixbuf.pixbuf
    method stock : GtkStock.id
    method icon_set : icon_set
    method icon_size : Tags.icon_size
  end

(** @gtkdoc gtk GtkImage *)
val image :
  ?file:string ->
  ?image:Gdk.image ->
  ?pixbuf:GdkPixbuf.pixbuf ->
  ?pixmap:Gdk.pixmap ->
  ?mask:Gdk.bitmap ->
  ?stock:GtkStock.id ->
  ?icon_set:icon_set ->
  ?icon_size:Tags.icon_size ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> image

(* Use an image as a pixmap... *)
val pixmap :
  #GDraw.pixmap ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> image

(** {4 Labels} *)

(** @gtkdoc gtk GtkLabel *)
class label_skel : 'a obj ->
  object
    inherit misc
    constraint 'a = [> Gtk.label]
    val obj : 'a obj
    method cursor_position : int
    method selection_bound : int
    method set_justify : Tags.justification -> unit
    method set_label : string -> unit
    method set_line_wrap : bool -> unit
    method set_mnemonic_widget : widget option -> unit
    method set_pattern : string -> unit
    method set_selectable : bool -> unit
    method set_text : string -> unit
    method set_use_markup : bool -> unit
    method set_use_underline : bool -> unit
    method set_xalign : float -> unit
    method set_xpad : int -> unit
    method set_yalign : float -> unit
    method set_ypad : int -> unit
    method justify : Tags.justification
    method label : string
    method line_wrap : bool
    method mnemonic_keyval : int
    method mnemonic_widget : widget option
    method selectable : bool
    method text : string
    method use_markup : bool
    method use_underline : bool
  end

(** A widget that displays a small to medium amount of text
   @gtkdoc gtk GtkLabel *)
class label : Gtk.label obj ->
  object
    inherit label_skel
    val obj : Gtk.label obj
    method connect : widget_signals
  end

(** @gtkdoc gtk GtkLabel *)
val label :
  ?text:string ->
  ?markup:string ->     (* overrides ~text if present *)
  ?use_underline:bool ->
  ?mnemonic_widget:#widget ->
  ?justify:Tags.justification ->
  ?line_wrap:bool ->
  ?pattern:string ->
  ?selectable:bool ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> label
val label_cast : < as_widget : 'a obj ; .. > -> label

(** {4 Tips query} *)

(** @gtkdoc gtk GtkTipsQuery 
   @deprecated . *)
class tips_query_signals : Gtk.tips_query obj ->
  object
    inherit GObj.widget_signals
    method start_query : callback:(unit -> unit) -> GtkSignal.id
    method stop_query : callback:(unit -> unit) -> GtkSignal.id
    method widget_entered :
      callback:(widget option -> text:string -> privat:string -> unit) ->
      GtkSignal.id
    method widget_selected :
      callback:(widget option -> text:string -> privat:string ->
                GdkEvent.Button.t -> bool) ->
      GtkSignal.id
  end

(** Displays help about widgets in the user interface
   @gtkdoc gtk GtkTipsQuery
   @deprecated . *)
class tips_query : Gtk.tips_query obj ->
  object
    inherit label_skel
    val obj : Gtk.tips_query obj
    method connect : tips_query_signals
    method start : unit -> unit
    method stop : unit -> unit
    method set_caller : widget option -> unit
    method set_emit_always : bool -> unit
    method set_label_inactive : string -> unit
    method set_label_no_tip : string -> unit
    method caller : widget option
    method emit_always : bool
    method label_inactive : string
    method label_no_tip : string
  end

(** @gtkdoc gtk GtkTipsQuery
   @deprecated . *)
val tips_query :
  ?caller:#widget ->
  ?emit_always:bool ->
  ?label_inactive:string ->
  ?label_no_tip:string ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> tips_query

(** {3 Color and font selection} *)

(** A widget used to select a color
   @gtkdoc gtk GtkColorSelection *)
class color_selection : Gtk.color_selection obj ->
  object
    inherit GObj.widget_full
    val obj : Gtk.color_selection obj
    method alpha : int
    method color : Gdk.color
    method set_alpha : int -> unit
    method set_border_width : int -> unit
    method set_color : Gdk.color -> unit
    method set_has_opacity_control : bool -> unit
    method set_has_palette : bool -> unit
    method has_opacity_control : bool
    method has_palette : bool
  end

(** @gtkdoc gtk GtkColorSelection *)
val color_selection :
  ?alpha:int ->
  ?color:Gdk.color ->
  ?has_opacity_control:bool ->
  ?has_palette:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> color_selection

(** A widget for selecting fonts.
   @gtkdoc gtk GtkFontSelection *)
class font_selection : Gtk.font_selection obj ->
  object
    inherit GObj.widget_full
    val obj : Gtk.font_selection obj
    method event : event_ops
    method font_name : string
    method preview_text : string
    method set_border_width : int -> unit
    method set_font_name : string -> unit
    method set_preview_text : string -> unit
  end

(** @gtkdoc gtk GtkFontSelection *)
val font_selection :
  ?font_name:string ->
  ?preview_text:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> font_selection
