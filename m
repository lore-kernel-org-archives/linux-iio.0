Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "gregkh@suse.de" <gregkh@suse.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Tue, 9 Mar 2010 09:35:48 +0000
Subject: [PATCH] iio_trigger_find_by_name: Skip trailing newline if available
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712D6B1D96B3@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Skip trailing newline if available.

From: Michael Hennerich <Michael.Hennerich@analog.com>

Index: drivers/staging/iio/industrialio-trigger.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/industrialio-trigger.c  (revision 8368)
+++ drivers/staging/iio/industrialio-trigger.c  (working copy)
@@ -155,6 +155,9 @@
        struct iio_trigger *trig;
        bool found =3D false;

+       if (len && name[len - 1] =3D=3D '\n')
+               len--;
+
        mutex_lock(&iio_trigger_list_lock);
        list_for_each_entry(trig, &iio_trigger_list, list) {
                if (strncmp(trig->name, name, len) =3D=3D 0) {

------------------------------------------------------------------
********* Analog Devices GmbH              Open Platform Solutions
**  *****
**     ** Wilhelm-Wagenfeld-Strasse 6
**  ***** D-80807 Munich
********* Germany
Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel, W=
illiam A. Martin, Margaret K. Seif
