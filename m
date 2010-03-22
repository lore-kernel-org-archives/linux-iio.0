Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:41872 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116Ab0CVUfJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2010 16:35:09 -0400
Message-ID: <4BA7D50D.2080202@cam.ac.uk>
Date: Mon, 22 Mar 2010 20:37:33 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio_trigger_find_by_name: Skip trailing newline if available
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D944F@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D944F@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/10 09:31, Hennerich, Michael wrote:
> Skip trailing newline if available.
>=20
> From: Michael Hennerich <Michael.Hennerich@analog.com>

Dear Michael,

Just found this one whilst trying to sort out a clean iio tree.
(sorry I completely failed to reply originally)

Anyhow, I agree with the principal that we should be ignoring the
newline.  Actually we should be ignoring whitespace before and after
the string we are actually after.  Perhaps a cleaner approach
is to use sscanf to pull out the string alone?  I don't think
we need to allow for whitespace in the trigger name (though obviously
it should be documented if we do not).  Technically I believe
(via the convenient lwn article last week on the topic) we should
ignore white space but return -EINVAL if there is say one word, some
white space and then another word...  Not sure if there is a particular=
ly
clean way to do that however.

What do you think?

Jonathan
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
>=20

