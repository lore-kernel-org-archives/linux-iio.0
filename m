Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34998 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab3GPLnJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 07:43:09 -0400
Date: Tue, 16 Jul 2013 13:43:05 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] iio: at91: introduce touch screen support in iio adc
 driver
Message-ID: <20130716114305.GD3125@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-6-git-send-email-josh.wu@atmel.com>
 <20130715131507.GE2962@lukather>
 <51E50DCC.4010107@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
In-Reply-To: <51E50DCC.4010107@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Tue, Jul 16, 2013 at 05:09:32PM +0800, Josh Wu wrote:
> On 7/15/2013 9:15 PM, Maxime Ripard wrote:
> >Hi Josh,
> >
> >On Sun, Jul 14, 2013 at 04:04:29PM +0800, Josh Wu wrote:
> >>AT91 ADC hardware integrate touch screen support. So this patch add tou=
ch
> >>screen support for at91 adc iio driver.
> >>To enable touch screen support in adc, you need to add the dt parameter=
s:
> >>   which type of touch are used? (4 or 5 wires), sample period time,
> >>   pen detect debounce time, average samples and pen detect resistor.
> >>
> >>In the meantime, since touch screen will use a interal period trigger o=
f adc,
> >>so it is conflict to other hardware triggers. Driver will disable the h=
ardware
> >>trigger support if touch screen is enabled.
> >>
> >>This driver has been tested in AT91SAM9X5-EK and SAMA5D3x-EK.
> >>
> >>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>---
> >>  .../devicetree/bindings/arm/atmel-adc.txt          |   13 +
> >>  arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
> >>  drivers/iio/adc/at91_adc.c                         |  389 +++++++++++=
+++++++--
> >>  3 files changed, 412 insertions(+), 24 deletions(-)
> >>
> >>diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Docu=
mentation/devicetree/bindings/arm/atmel-adc.txt
> >>index 0db2945..925d656 100644
> >>--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> >>+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> >>@@ -29,6 +29,19 @@ Optional properties:
> >>    - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
> >>    - atmel,adc-clock-rate: ADC clock rate. If not specified, use the d=
efault
> >>  			  adc_op_clk.
> >>+  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only su=
pport
> >>+				 4 and 5 wires touch screen.
> >>+    NOTE: when adc touch screen enabled, the adc hardware trigger will=
 be
> >>+          disabled. Since touch screen will occupied the trigger regis=
ter.
> >>+  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for tou=
ch pen
> >>+				  detect.
> >>+  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond=
 for
> >>+				     touch screen
> >>+  - atmel,adc-ts-filter-average: Numbers of sampling data will be aver=
aged.
> >>+    0 means no average. 1 means average two samples. 2 means average f=
our
> >>+    samples. 3 means average eight samples.
> >>+  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resis=
tor.
> >>+    It can be 0, 1, 2, 3.
> >Could you expand a bit on what are these properties for? Are they
> >board-specific? IP-specific?
>=20
> +  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only supp=
ort
> +                 4 and 5 wires touch screen.
> +    NOTE: when adc touch screen enabled, the adc hardware trigger will be
> +          disabled. Since touch screen will occupied the trigger registe=
r.
>=20
> It is board specific. Currently in AT91SAM9M10G45EK, AT91SAM9X5-EK,
> SAMA5D3x-EK all use 4 wire touch.
> Now the driver not support 5 wire yet.

I see, maybe you should add this in the documentation then

> +  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for
> touch pen
> +                  detect.
>=20
> de-glitch time for pen detect. Board specific.
>=20
> +  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond f=
or
> +                     touch screen
>=20
> The period to sample a touch data after pen is touched. Board specific.
>=20
> +  - atmel,adc-ts-filter-average: Numbers of sampling data will be averag=
ed.
> +    0 means no average. 1 means average two samples. 2 means average four
> +    samples. 3 means average eight samples.
> +  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resisto=
r.
> +    It can be 0, 1, 2, 3.
>=20
> Above two properties only supported in SAM9X5, SAMA5D3 IP.

Ok, that should go to the documentation as well. What do the values of
atmel,adc-ts-pendet-sensitivity correspond to?

> >>@@ -104,14 +140,10 @@ static irqreturn_t at91_adc_trigger_handler(int i=
rq, void *p)
> >>  	return IRQ_HANDLED;
> >>  }
> >>-static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
> >>+/* Handler for classic adc channel eoc trigger */
> >>+void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
> >>  {
> >>-	struct iio_dev *idev =3D private;
> >>  	struct at91_adc_state *st =3D iio_priv(idev);
> >>-	u32 status =3D at91_adc_readl(st, st->registers->status_register);
> >>-
> >>-	if (!(status & st->registers->drdy_mask))
> >>-		return IRQ_HANDLED;
> >Why are you changing the prototype and remove most of the useful part
> >out of the handler?
>=20
> I change the protype because I make it as a sub interrupt handler.
> Since I just add a new interrupt handler which will check the
> interrupt type, if DRDY interrupt is coming, it will call your
> original handler.
> Otherwise use touch screen interrupt handler code.
>=20
> Following is the new interrupt handler code in this patch:
>=20
> +static irqreturn_t at91_adc_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *idev =3D private;
> +	struct at91_adc_state *st =3D iio_priv(idev);
> +	u32 status =3D at91_adc_readl(st, st->registers->status_register);
> +	const uint32_t ts_data_irq_mask =3D
> +		AT91_ADC_IER_XRDY |
> +		AT91_ADC_IER_YRDY |
> +		AT91_ADC_IER_PRDY;
> +
> +	if (status & st->registers->drdy_mask)
> +		handle_adc_eoc_trigger(irq, idev);
>=20
>                              ^
>                              |
> here we call original trigger handler.
>=20
> +
> +	if (status & AT91_ADC_IER_PEN) {
> +		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
> +		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_NOPEN |
> +			ts_data_irq_mask);
> +		/* Set up period trigger for sampling */
> +		at91_adc_writel(st, st->registers->trigger_register,
> +			AT91_ADC_TRGR_MOD_PERIOD_TRIG |
> +			AT91_ADC_TRGR_TRGPER_(st->ts_sample_period_val));
> +	} else if (status & AT91_ADC_IER_NOPEN) {
> +		at91_adc_writel(st, st->registers->trigger_register, 0);
> +		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_NOPEN |
> +			ts_data_irq_mask);
> +		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
> +
> +		input_report_key(st->ts_input, BTN_TOUCH, 0);
> +		input_sync(st->ts_input);
> +	} else if ((status & ts_data_irq_mask) =3D=3D ts_data_irq_mask) {
>=20
> Those code will handle for the Touch screen interrupt.

Ah, right.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5THJAAoJEBx+YmzsjxAgUAsP+QHJHroDatC+Ys7/2DFQKT4D
OgknQvJzK3WvgdWSMU78o0Lr0gyAJSYFOwzZncyaG6IpxkDyj8WNS+wHXJe7vom5
42jqWRp8PWnRWk57h1sxIzd5g+qxyNe/plEpkYAkOIYf5ZGKlxO4Uedbfbbrrf51
CnZeHKZGNd1g4s3CvckjTHY4qbwscm2ARSqqUVjsPHjYOT18HpcUHL2mJ9svOvoq
G7SuRa4Zv5L5RQkAdYjhbCXjn38bUNsjbajOTBurLqahzsyuWz9cW+pl+NZAMEta
FTKyy7c0MTrJYD8QFxIKgIHK6JRWGkOix9nvC3hCk+yWILLdaR9nD9t9Zr2OHPt1
panxK2Abglz7WC+/+M7MaPlS6HuhFEIXtxAyoFSYBV4ifG0Ixfysgh/kH5xTvG80
rxt8+PQV+NA+ZR580fW2L/Apyd67kaJr6HSGSDGjPoICt4cjXP3dX6XLs8lqaxTo
QEqL20aYHpM/5uaNIoTbddeT75IoymSwzv331bo8ISRHyJ0s2/+HqBd0eW3F5Quj
DWlmZpnWFe5W/81hp79cxjp+7JeUHi3zTn7bXhiSbwVfyCj1t53WaWesfsmICQL6
Adit7pW/2nqNCSpgwIUuAFwlPF3qm48fcHy7o2CuMx94LhGyl4u+kPeBGDVUW38n
DG3N1xtQdcVjSG5GMeno
=18Dt
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
