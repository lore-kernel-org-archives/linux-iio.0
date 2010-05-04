Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>, "Getz, Robin"
	<Robin.Getz@analog.com>
Date: Tue, 4 May 2010 10:48:06 +0100
Subject: IIO:ADC Scan Modes
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568A02D0@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The way available scan modes are handled in the max1363 driver doesn't
nicely equate to the AD7997, AD7997 or AD7991 series of ADCs.
These devices feature up to 8 Channels while each channel can be independen=
tly
included into the scan sequence.
(this would require up to 256 'named' modes)

A while ago we talked about this - and you said you would abandon the
'named' scan mode selection - and come up with something like a scan_elemen=
ts
directory with channel control files (enable/disable), and some sort of mec=
hanism
that rejects invalid combinations.

I noticed some additions ...
[PATCH 04/19] staging:iio: Support functions for scan mask matching

But the sysfs interface is not in place.
Is this something you're still planning to put into place?

Best regards,
Michael


------------------------------------------------------------------
********* Analog Devices GmbH              Open Platform Solutions
**  *****
**     ** Wilhelm-Wagenfeld-Strasse 6
**  ***** D-80807 Munich
********* Germany
Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel, W=
illiam A. Martin, Margaret K. Seif
