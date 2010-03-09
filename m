Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:57369 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab0CIMkI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2010 07:40:08 -0500
Message-ID: <4B964227.4070806@cam.ac.uk>
Date: Tue, 09 Mar 2010 12:42:15 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "gregkh@suse.de" <gregkh@suse.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio_trigger_find_by_name: Skip trailing newline if available
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D96B3@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D96B3@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Michael,

You probably want to add your Signed-off-by to this.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>


> Skip trailing newline if available.
>=20
> From: Michael Hennerich <Michael.Hennerich@analog.com>
>=20
> Index: drivers/staging/iio/industrialio-trigger.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/industrialio-trigger.c  (revision 8368)
> +++ drivers/staging/iio/industrialio-trigger.c  (working copy)
> @@ -155,6 +155,9 @@
>         struct iio_trigger *trig;
>         bool found =3D false;
>=20
> +       if (len && name[len - 1] =3D=3D '\n')
> +               len--;
> +
>         mutex_lock(&iio_trigger_list_lock);
>         list_for_each_entry(trig, &iio_trigger_list, list) {
>                 if (strncmp(trig->name, name, len) =3D=3D 0) {
>=20
> ------------------------------------------------------------------
> ********* Analog Devices GmbH              Open Platform Solutions
> **  *****
> **     ** Wilhelm-Wagenfeld-Strasse 6
> **  ***** D-80807 Munich
> ********* Germany
> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wes=
sel, William A. Martin, Margaret K. Seif
>=20
>=20

