#!/bin/bash
# A set of dialogs for manipulating PDFs
# Copyright (C) 2014  Steven Allen
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


file="$*"
case \
	$(zenity \
		--list \
		--title="PDF Tools" --text="Select tool" \
		--radiolist \
		--column=" " --column=Tool \
		--width="215" --height="330" \
		0 "Info" 1 "Font Info" 2 "Optimize PDF" 3 "Extract Images" \
		4 "Convert to HTML" 5 "Convert to Text" 6 "Convert to PPM" 7 "Convert to PS" \
	) in
	Info)
		pdfinfo "$file" \
		| zenity \
			--text-info \
			--width="500" --height="400" \
			--title="PDF Info"
		;;
	"Font Info")
		pdffonts "$file" \
		| zenity \
			--text-info \
			--width="675" --height="430" \
			--title="PDF Font Info"
		;;
	"Optimize PDF")
		pdfopt "$file" \
			$(zenity \
				--title="Save Optimized PDF to..." \
				--file-selection --save --confirm-overwrite \
			)
		;;
	"Extract Images")
		pdfimages "$file" \
			$(basename "$file" .pdf)
		;;
	"Convert to HTML")
		pdftohtml "$file" \
			$(zenity \
				--title="Save HTML file to..." \
				--file-selection --save --confirm-overwrite \
			)
		;;
	"Convert to Text")
		pdftotext "$file" \
			$(zenity \
				--title="Save Text file to..." \
				--file-selection --save --confirm-overwrite \
			)
		;;
	"Convert to PPM")
		pdftoppm "$file" \
			$(zenity \
				--title="Save PPM image to..." \
				--file-selection --save --confirm-overwrite \
			)
		;;
	"Convert to PS")
		pdftops "$file" \
			$(zenity \
				--title="Save PS file to..." \
				--file-selection --save --confirm-overwrite \
			)
		;;
	"")
		echo "No selection made"
		;;
	*)
		echo "ERROR: Invalid Choice"
		exit 1
		;;
esac
exit 0

