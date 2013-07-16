Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34741 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab3GPKaR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 06:30:17 -0400
Date: Tue, 16 Jul 2013 12:30:14 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com
Subject: Re: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
Message-ID: <20130716103014.GB3125@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
 <20130715130610.GD2962@lukather>
 <51E4FC70.3050207@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
In-Reply-To: <51E4FC70.3050207@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 03:55:28PM +0800, Josh Wu wrote:
> >On Sun, Jul 14, 2013 at 04:04:28PM +0800, Josh Wu wrote:
> >>diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> >>index e93a075..8f1386f 100644
> >>--- a/drivers/iio/adc/at91_adc.c
> >>+++ b/drivers/iio/adc/at91_adc.c
> >>@@ -47,6 +47,7 @@ struct at91_adc_caps {
> >>  struct at91_adc_state {
> >>  	struct clk		*adc_clk;
> >>+	u32			adc_clk_rate;
> >>  	u16			*buffer;
> >>  	unsigned long		channels_mask;
> >>  	struct clk		*clk;
> >>@@ -448,6 +449,10 @@ static int at91_adc_probe_dt(struct at91_adc_state=
 *st,
> >>  	if (!node)
> >>  		return -EINVAL;
> >>+	prop =3D 0;
> >>+	of_property_read_u32(node, "atmel,adc-clock-rate", &prop);
> >>+	st->adc_clk_rate =3D prop;
> >>+
> >>  	st->use_external =3D of_property_read_bool(node, "atmel,adc-use-exte=
rnal-triggers");
> >>  	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> >>@@ -723,7 +728,8 @@ static int at91_adc_probe(struct platform_device *p=
dev)
> >>  	 * specified by the electrical characteristics of the board.
> >>  	 */
> >>  	mstrclk =3D clk_get_rate(st->clk);
> >>-	adc_clk =3D clk_get_rate(st->adc_clk);
> >>+	adc_clk =3D st->adc_clk_rate ?
> >>+		st->adc_clk_rate : clk_get_rate(st->adc_clk);
> >Why is that needed? Isn't it completely redundant with the clocks
> >property?
>=20
> As st->adc_clk rate is specified in arch/arm/mach-at91/sama5d3.c
> (take sama5d3 for example), changing the clock rate should recompile
> the kernel binary.
> Use dt parameter will let us easily specify the clock rate instead
> of recompile the code.
>
> And yes, it is redundant that we can define the adc_op_clk rate in
> two places (clock property in .c and adc-clock-rate in dts). But
> this can be compatible with the non-dt platform.

Yet, it's not, while, like you pointed at, the common clock framework
actually *is* usable for both DT and non-DT platforms at no cost.

The fact that AT91 isn't using the DT to retrieve its clock tree yet is
another story (but I believe that it's a work in progress).

> After a further thinking of this, maybe remove the adc_op_clk is
> better since it is a fake clock, and only used to specify the clock
> rate.
> To specify the clock rate use a dt property or platform data
> parameter is better.

No, to specify *any* clock, the common clock framework is the better
solution.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5SC2AAoJEBx+YmzsjxAgcJgP/RCg1WcD+4upBAO42zkNIhgF
n05wQ4oAFyHmZ2D8E7qRefjd5rNkYNZdgTfqfOfkRocawTIoCzF2csl8Axk/pTgz
G/W3TMTiFB9Or4kPg9oWBvU1/iDIlEs6/4YehaK0xrUDTLSsfr/AFsk/3TwitIDW
7iBDUSTuqOpOurJ4Dl0HsXJyfnHLCf2+LG1QDSKuUaOq0AxAN1y3wOzJSc60uIbo
huH6dbVnGg5dO8A45fgERZtFkSqiepo437a16pnYpNJQXJoKphhR2WPsBHZ0HS+X
6ADpoq8XHWCczvqFJ3rePCcNi1YbWr4Mz/V2Ug+v5Bajec2EvIXbKWlrBYc1CtX4
wtDrtGCxnXBjpEy8F/LAqCGvbPivenvGgZiGXMg1hPubYkSu16ZmyaicKEeIfQfr
mOCyVSKsk0subOTAYEOfMaGmkQZbdUVCWHy3Uqtm58TN2oC0GKcYNmYrSlpUGALl
Nc/Kwt2kGRAjLn1f9aXuVEtyxXAYR0GjlwE07qm19NdtFRsDdzXW2G5aIrPCQjIk
hLe1jrumQto5xuSu9HPatSD6xm2QiCNDpFxF2I9Yj76UNOtij+rS5D4Ck3uI9H1M
NQvOvu8dnblyPzyM1d1citI/96emjTyzXYmVXspH2nqFcS61FK7sBN1uD35NLvWl
vSKCCniUD7BmQitMIp8z
=q5Ph
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
