$pdf_mode                   = 1;
$pdflatex_silent_switch     = '-interaction=batchmode';
$silent                     = 0;

$biber                      = 'biber --isbn-normalise -u -U %O %S';

$pdf_previewer              = 'evince %O %S 2>/dev/null';
$preview_continuous_mode    = 0;

$out_dir                    = 'latex.out';
$always_view_file_via_temporary = 1;



# Notification settings
my $notify_id=-1;
$compiling_cmd='internal my_compilation_cmd';
$failure_cmd='internal my_failure_cmd';
$success_cmd='internal my_success_cmd';

sub my_compilation_cmd {
	$notify_id = `notify-send -p -t 2000 -i emblem-synchronizing -r $notify_id "latexmk" "compiling" 2>/dev/null`;
	chomp($notify_id);
}

sub my_failure_cmd {
	$notify_id = `notify-send -p -t 2000 -i emblem-important -r $notify_id "latexmk" "compilation failed" 2>/dev/null`;
	chomp($notify_id);
}

sub my_success_cmd {
	$notify_id = `notify-send -p -t 2000 -i emblem-default -r $notify_id "latexmk" "compilation successful" 2>/dev/null`;
	chomp($notify_id);
}

# vim: ft=perl syntax=on
