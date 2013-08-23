Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51477 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755769Ab3HWQ7m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Aug 2013 12:59:42 -0400
Date: Fri, 23 Aug 2013 18:59:36 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: ludovic.desroches@atmel.com, Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com
Subject: Re: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask in
 MR for different IP
Message-ID: <20130823165936.GC1230@lukather>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
 <20130815192044.GD12162@lukather>
 <5215DF2C.3050502@atmel.com>
 <5215DF7C.2020909@atmel.com>
 <20130823154603.GA7468@ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
In-Reply-To: <20130823154603.GA7468@ludovic.desroches@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ludovic, Josh,

On Fri, Aug 23, 2013 at 05:46:03PM +0200, Desroches, Ludovic wrote:
> On Thu, Aug 22, 2013 at 05:53:00PM +0800, Josh Wu wrote:
> > On 8/22/2013 5:51 PM, Josh Wu wrote:
> > >Hi, Maxime
> > >
> > >On 8/16/2013 3:20 AM, Maxime Ripard wrote:
> > >>Hi Josh,
> > >>
> > >>On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
> > >>>For at91 boards, there are different IPs for adc. Different IPs has
> > >>>different STARTUP & PRESCAL mask in ADC_MR.
> > >>>
> > >>>This patch introduce the multiple compatible string for those
> > >>>different IPs.
> > >>>
> > >>>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> > >>Overall it looks like the right ways, but I think we can take it a st=
ep
> > >>further.
> > >>
> > >>I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
> > >>atmel,adc-status-register, atmel,adc-trigger-register properties (and
> > >>probably the triggers as well description as well).
> > >
> > >yeah, right. Currently I want to drop following:
> > >
> > >atmel,adc-drdy-mask, atmel,adc-status-register,
> > >atmel,adc-trigger-register, atmel,adc-channel-base
> > >
> > >For the adc-num-channels, I'd like to leave it in dt parameters.
> > >It is a description for an adc capablity.
>=20
> About this parameter, I'll remove it too from the dt bindings. To set it =
you
> need to have a look to the datasheet and to copy a constant value into the
> dt. From my point of view, it means than this parameter should be managed=
 by
> the driver and by the dt.
>=20
> On the other side since there are some dynamic allocation depending on th=
is
> parameter maybe it makes sense to keep it in the dt. If the user wants to=
 use
> only 2 channels why doing allocation for max channel number. By the way, =
this
> case is only valid if he uses the two first channels.

I don't recall it very well, is there any reason to not have it in the
DT? Can the ADC channels be used for something else? Or is it just some
IP-specific number of channels?

> > >
> > >For the triggers, I am not decided. An obvious benifit to remove
> > >trigger in dt will save many lines of code.
> > >
> > >>
> > >>Maxime
> > >>
> > >
> > >Best Regards,
> > >Josh Wu
> >
>=20
> Since we are talking about reworking this binding I was thinking about
> resolution stuff. Filling atmel,adc-res is also copying constant value fr=
om
> the device datasheet, so if I was consistent I would say it has to be rem=
oved
> too. But I am not consistent! I mean by doing this the only thing the user
> will have to fill is the resolution value. He can't set the value he want=
s,
> there are only two choices. By keeping it into the dt then he will immedi=
ately
> see the choices he has.

But the resolution should probably be somehow user-defined, probably not
really related to the DT has well. I think some other IIO ADC drivers
are using sysfs files for this purpose, maybe that would be a better
fit?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSF5T4AAoJEBx+YmzsjxAg99sP/iWSLSTDGU0G8BlPdQ77bP5j
YLsNLSZFMOOxFqFanphR47RCsMCEStelX0/9WkncDoa+0sTg+QTpYnX9IdM62TX5
jNwY9/wrT5eVAyltRR0U0HcipTID7eKOqKPd6LBfAghWf6kFzQUwTXg0TD2VdLQR
YMN7C8wQZqWX1OOtMBwk58H7G29J+oJPxrKh7GMoW6Kte1Bi+XWCIcwlYUzHNVRH
Z0AockRF2eDNXjGTuV+3NoUuobHz7TD07eI0pxfaSClxDxFO1tA2PvYuYIizKpMx
9x7+4Z+w9V3o63vfy4VPhYk+NehPa9GZy82gF+e94PZvhAP0pkFIbkVZA8ozVc5o
dTzVq9RWvKhnRHPH2FEcGI1n/yTLpRP/0D79gtUYxSPX7zJkEfbcmd2zWCVZtpy4
54mb6vibaYlM3FU7z2O7KJzsO2WaYxYNNiohdr23dtMOhJawnL5bQdNKMa2H3D1s
/e0O3eOp49wwxUCTje1Q7chgFSA7DEO0Tv/jOJp6P4FRQAXQuRKEtQi9M/0uzx41
5cFZzD7+xw6sHgA2Mvw/KgRGY1gUAVuSNTnCz9fMMxferbtKJQbInTWDkg2MEGlX
ESvu9sqnWYMtnK19seeOtN5Iq5d5ikAlF+BGiSF1wIzQDxmG33s+tiUPPlijDYds
Uaj7I2DAKKqy+mGno3c8
=n9D2
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
