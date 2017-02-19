Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.176]:30641 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdBSRvd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 12:51:33 -0500
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20170219171518.GA12833@amd>
Date: Sun, 19 Feb 2017 18:51:00 +0100
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nick Dyer <nick@shmanahar.org>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Michel Verlaan <michel.verl@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Aaro Koskinen <aaro.koskinen@nokia.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
Message-Id: <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
References: <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd> <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com> <20170218180811.GB9377@amd> <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com> <20170218225435.GA4693@amd> <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com> <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd>
To: Pavel Machek <pavel@ucw.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,
I love discussions with you :)

> Am 19.02.2017 um 18:15 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
>=20
>>> Solve it properly. That means passing calibration
>>> data from kernel to userland.
>>=20
>> As written before, the really proper solution would be to provide =
floating
>> or fixed point subpixel input events. Not arbitrarily scaling up in =
kernel
>> and leaving downscaling to user space (where everybody can make it
>> worse).
>=20
> That has no advantages,

It has the advantage of providing you with the full precision of raw =
data (but
properly scaled) so that you don't loose any bit of information. This is =
what
you just asked for - one or two mails before.

And it provides me (and my users) with properly scaled touch =
coordinates, which
is what I (and they - compare e.g. comment by Andreas Kemnade) ask for.

So it would be a solution that fulfills both requirements. And =
fulfilling
requirements of two groups of people is advantageous to making only one =
happy.
Isn't it?

> and floating point in kernel is hard. Also
> you'd either have to invent new interface, or you'd break touchscreen
> for people that already have their touchscreens calibrated.

No, I don't break calibration for people using a different chip.

And since we just upstream a solution for devices (GTA04) which already =
use this
mechanism for years, we also won't break their calibration, because they =
are happy
with the non-calibration it provides.

We break it only for those, who use the same chip *and* upgrade to a =
kernel which
includes this patch. And even then, only if they update their device =
tree to use
it (the default without DT modifications is to provide raw data as =
before). If
they stay with an older kernel or older DT there is no change and action =
required.

So there are ca. 5 pre-conditions that others will notice a change at =
all.

Do you think user-space recalibration is such a difficult task compared =
to
upgrading a kernel that it must therefore be avoided? Compared to other
kernel-userland synchronization problems it has the good side that you
even will notice it immediately and will know what to do (recalibrate =
once
and it is done forever).

> Just
> pass calibration data to userland.

What is this good for if kernel can already do the calibration for =
userland?
If the kernel does it, it don't even waste efforts to pass calibration =
data
to userland.

And don't forget: if you need calibration data in userland, there are =
much
better mechanisms. The simplest one is a file (e.g. xorg.conf) which is
something the kernel and X11 already supports.

I.e. adding a new mechanism to pass calibration data from the kernel to
user-space doesn't make any sense, IMHO.

If the kernel knows about calibration it should use it directly and =
process it.
Like in iio where you can get raw and processed data, although =
processing could
also be done completely in user-space. So there seem to be good reasons =
to do
it in kernel...

And, citing your argument from above: "Also you'd either have to invent
new interface, or you'd break touchscreen for people that already have =
their
touchscreens calibrated."

>=20
>> But I don't think it is worth implementing subpixel touch events for =
real
>> world devices due to the jitter I mentioned.
>=20
> Yes, that's not really proper solution, that just overengineered. Not
> worth implementing. Pass calibration data to userland.

You seem to repeat yourself and just say which solution you prefer,
but I am missing the arguments why your solution (Pass calibration data
to userland) is right and the best one. Which problems does it solve?
Which one does it solve better than others? How can you implement it in
a stable and portable way? How can you make sure that all user-space GUI
systems can and will make use of this calibration data?

BR and thanks,
Nikolaus


--Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqdsFAAoJEIl79TGLgAm62U4P/jGEcfSPPjKQGtGkFihPgkYU
2vVwj8ZY1AXO73aIt96oLE48QlTFKG+BpgVZsnuZawdtsh1d7FCi8xr+hKQ5sQgC
jiLlfuenjCHEuUHRjKwvcSqJ3lD4oup23tI+qDh/6E61F3IRRh8sfB7IWRLNyycn
tJP6LTs6prbbRGoQe7aM8w36Y7OWigcKHaQnjRqP5iC0bcxty1/k0K6HztN8a7/H
FOaURDox60OPolG6YkvE9sY/rUoz92D0gdbpdS2yCxC/5z3ZPrtVStFQYh++9aIu
07ujnelBkr/oKKHm7VHevAM6IswtihzfT4eesISIJWaxq2F1X1QhZCZDe5OA4PjC
PQT16dCVrNqFFNG0AlG7D3wTwsajd7PaqBQqgh01cazCYgZBr6ZA94sZI8yAUjEl
gZW7L/Z1f+g7udsWZ3GkXDm1C3fsrXwyMsWb0HIWmctpKEpyPWCjZy3NQSNibIwR
fVc4z3OabmCKgJzxq5/6WpnB3qudp3wsN4bqGRqZGX8XAvPUqz4Y3BkEs9gEAAEG
A7YwqkNd/HPWTN5Q1RDBmzNSKY5qBAgoHDPWZWIJIHAW8Jbnw/IEa02SSlcixRaH
K0QGisfQSzHUgTG8UdObj3LSE4jCf/oEBUFPlBz79oIZ+FAE5SBAC8tdl0/Ka4t6
t1H2m7MLxYPcQGoL7kTt
=El0C
-----END PGP SIGNATURE-----

--Apple-Mail=_65E14360-50C9-4AB6-9828-855C434A1F75--
