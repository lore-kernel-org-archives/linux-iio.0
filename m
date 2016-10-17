Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:14172 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932976AbcJQN6F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2016 09:58:05 -0400
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <29036A28-9997-4ED6-81FE-3ABC659EEEEB@goldelico.com>
Date: Mon, 17 Oct 2016 15:57:47 +0200
Cc: Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, linux-iio@vger.kernel.org
Message-Id: <FD41BC96-41B9-48B1-AB57-05B2DCAB4E17@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com> <20160923224726.GA4639@rob-hp-laptop> <20160924003133.htaaiphjrm7vy52t@earth> <E8C59C6C-23D4-4417-8A9E-3E9AE5D2D100@goldelico.com> <20160930141603.mlo5v75oy72j64d5@earth> <29036A28-9997-4ED6-81FE-3ABC659EEEEB@goldelico.com>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,
I did wait for the 4.9-rc1 merge window to be closed until I bring up =
this patch
set again.

> Am 30.09.2016 um 16:40 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>>=20
>> I do agree with Rob, that the ti,min/max-x/y should become common,
>> though. Also I would do s/minimum value/minimum raw value/g.
>=20
> Yes, that is a good idea!
>=20
> To me it seems as if "minimum-raw-value-x", "maximum-raw-value-y" =
could be good.
>=20
> Or is the string too long (then we can drop the "-value" or the =
"imum")? It
> might blow up the DTB and string constant for finding the property?
>=20
> If we come to some consensus on this, I can update the patch set.

Now when updating the patch set, I found that using ti,min/max-x/y was =
not really
a new invention. It is already upstream for a while for the ads7846/2046 =
driver!

This means: by introducing these properties to the tsc2007 as well we =
just extend the
already defined use of ti,min/max-x/y.

Simply changing that as well to use some minimum-raw-value-x etc. would =
break ads7846/2046
boards not in mainline or need ugly code to handle property alias names.

And since they are raw data and quite chip-specific, I think there is no =
urgent need
for harmonization of raw device data. While using the common bindings =
for output
scaling and fuzz, swap etc. is very important and helpful for board =
designers.

So I would prefer if we can keep it as is for the moment. And make =
property name
harmonization and evolution a separate task and discussion.

I will submit v4 in a couple of minutes. It contains some other small =
fixes as
suggested by the previous discussion.

BR and thanks,
Nikolaus


--Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBNjcAAoJEIl79TGLgAm6LdQP/3Rj7aocbqZQ2sAJeL2UJQpo
reT6eBsWslzmWFvYazF8NE7ZtMqFPpp7A23XbUn7gyy5mMOSKPue525GciddUNBI
YUAK8/Gkr69FlQJ6NQXt9Xc0wekHL4YzMR+1lD+UV40YB3cY347JW4laPP2feZOM
Y5BpPrmmSf39hZRtj+bZMdMb/uDwy35DQEHDVMmmKu/gOq+lne5Vp6xQ8GlBwLEF
51T8eGZfWyPI9xGYP8MBZBEdHEcobLguzCvoEdOyYqkbafu7hGqeCKwspAWMXAXu
1+9PsgTLRFUqlKZHZD0MR7wDIP2ml60xuZWuf/J/SlOdNO5c0CbTa7QvFmkSEtHL
EPu1OPZj20RrXMnW1TcYOmrRwIxZ+3dfWoLIh1ioTnjck8jA87poTPshC0Wn4Woy
fBoazzSI3fcftAqJRWB8YvGZPgmgGde9WNT0NVOa2FXhzsMnJrJGiuBmyTGUHH3Z
dZsFSKD/3VNiu7UKv5Az1euRnliln05ApDLblIB1Drqcg62JCWTlN+RvS8Mxblat
9wHsdNcgqN9LFINZuZO9jqczi7yRfM/5NeFnXUBiP2Qxjryj3dQ+3379EYC0PbzI
TI62eucZY8hh4xEvvKQlBhXz+ulNchBuI1/sWo1uYXe/Oh8oNjwYoDGALHErodV7
c67YXquFn+PKMsTm2lEt
=s6+4
-----END PGP SIGNATURE-----

--Apple-Mail=_C27A8AB6-3549-4267-BFA0-26B6FB31FF1B--
