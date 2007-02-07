#!/usr/bin/perl


use Getopt::Std;
use Tk;


sub main_window
{
   $g_main = MainWindow->new;
   $g_main->title("Makefile Builder");

   $g_main->label("C Files");
   $g_main->Scrolled("Text", -height => 20, -width => 30,
                     -wrap => 'word')->pack(-side => 'top'));
}


main_window();

MainLoop;




