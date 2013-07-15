Return-Path: <maxime.ripard@free-electrons.com>
Date: Mon, 15 Jul 2013 15:15:07 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] iio: at91: introduce touch screen support in iio adc
 driver
Message-ID: <20130715131507.GE2962@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-6-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
In-Reply-To: <1373789069-11604-6-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sun, Jul 14, 2013 at 04:04:29PM +0800, Josh Wu wrote:
> AT91 ADC hardware integrate touch screen support. So this patch add touch
> screen support for at91 adc iio driver.
> To enable touch screen support in adc, you need to add the dt parameters:
>   which type of touch are used? (4 or 5 wires), sample period time,
>   pen detect debounce time, average samples and pen detect resistor.
>=20
> In the meantime, since touch screen will use a interal period trigger of =
adc,
> so it is conflict to other hardware triggers. Driver will disable the har=
dware
> trigger support if touch screen is enabled.
>=20
> This driver has been tested in AT91SAM9X5-EK and SAMA5D3x-EK.
>=20
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  .../devicetree/bindings/arm/atmel-adc.txt          |   13 +
>  arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
>  drivers/iio/adc/at91_adc.c                         |  389 ++++++++++++++=
++++--
>  3 files changed, 412 insertions(+), 24 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Docume=
ntation/devicetree/bindings/arm/atmel-adc.txt
> index 0db2945..925d656 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -29,6 +29,19 @@ Optional properties:
>    - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>    - atmel,adc-clock-rate: ADC clock rate. If not specified, use the defa=
ult
>  			  adc_op_clk.
> +  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only supp=
ort
> +				 4 and 5 wires touch screen.
> +    NOTE: when adc touch screen enabled, the adc hardware trigger will be
> +          disabled. Since touch screen will occupied the trigger registe=
r.
> +  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for touch=
 pen
> +				  detect.
> +  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond f=
or
> +				     touch screen
> +  - atmel,adc-ts-filter-average: Numbers of sampling data will be averag=
ed.
> +    0 means no average. 1 means average two samples. 2 means average four
> +    samples. 3 means average eight samples.
> +  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resisto=
r.
> +    It can be 0, 1, 2, 3.

Could you expand a bit on what are these properties for? Are they
board-specific? IP-specific?

[...]

> +#define DRIVER_NAME		"at91_adc"

This looks like this part doesn't belong to another cleanup patch.

> +#define MAX_POS_BITS		12
> +
> +#define ZTHRESHOLD		9000
> +
>  struct at91_adc_caps {
> +	bool	has_12bits_xy;	/* true means use 12 bits. Otherwise 10 bits */

Isn't that redundant with the low_res boolean?

>  	bool	has_tsmr;	/* only at91sam9x5, sama5d3 have TSMR reg */
>  	u32	mr_prescal_mask;
>  	u32	mr_startup_mask;
>  };
> =20
> +enum atmel_adc_ts_type {
> +	ATMEL_ADC_TOUCHSCREEN_NONE =3D 0,
> +	ATMEL_ADC_TOUCHSCREEN_4WIRE,
> +	ATMEL_ADC_TOUCHSCREEN_5WIRE,
> +};
> +
>  struct at91_adc_state {
>  	struct clk		*adc_clk;
>  	u32			adc_clk_rate;
> @@ -70,6 +83,29 @@ struct at91_adc_state {
>  	bool			low_res;	/* the resolution corresponds to the lowest one */
>  	wait_queue_head_t	wq_data_avail;
>  	struct at91_adc_caps	caps;
> +
> +	/*
> +	 * Following ADC channels are shared by touchscreen:
> +	 *
> +	 * CH0 -- Touch screen XP/UL
> +	 * CH1 -- Touch screen XM/UR
> +	 * CH2 -- Touch screen YP/LL
> +	 * CH3 -- Touch screen YM/Sense
> +	 * CH4 -- Touch screen LR(5-wire only)
> +	 *
> +	 * The bitfields below represents the reserved channel in the
> +	 * touchscreen mode.
> +	 */
> +#define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 0)
> +#define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 0)
> +	enum atmel_adc_ts_type	touchscreen_type;
> +	struct input_dev		*ts_input;
> +
> +	u8			ts_filter_average;
> +	u16			ts_pen_detect_debounce;
> +	u8			ts_pen_detect_sensitivity;
> +	u16			ts_sample_period_time;
> +	u16			ts_sample_period_val;
>  };
> =20
>  static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> @@ -104,14 +140,10 @@ static irqreturn_t at91_adc_trigger_handler(int irq=
, void *p)
>  	return IRQ_HANDLED;
>  }
> =20
> -static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
> +/* Handler for classic adc channel eoc trigger */
> +void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>  {
> -	struct iio_dev *idev =3D private;
>  	struct at91_adc_state *st =3D iio_priv(idev);
> -	u32 status =3D at91_adc_readl(st, st->registers->status_register);
> -
> -	if (!(status & st->registers->drdy_mask))
> -		return IRQ_HANDLED;

Why are you changing the prototype and remove most of the useful part
out of the handler?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR4/XbAAoJEBx+YmzsjxAgCeEQAK2D7QGdvtbacPSIsePq3BEu
rWFT0UmN/rit59YI2kw2t/OpM7GvxThjsE8IeUXGuYYwYYFkhpYSuPokcqSTfoe/
uRML2wrPkL+Vd9yq2ysgevIOzItFKcnSErzu/o/6Sxh2fV7Oq/BjTE0/sTo3iDT5
WWdzO9pL9Ke+q6LMO93hwOWFWp/O3DlguJxp+00p1vDr8byhh+yJW6VJyaBZNITQ
Wi6IEs9VwluD+zw/kT3XDewsdWhSGSybPNiFQXEcY7WNU2TpOkUin8CWExDDmQy8
ng6C96zA/9ByoA0yCC9PyBt72cQf691OvGAxp/XIPPx1xkKPZ/g9VlV/cRMQkaVA
pVBpturTfw/zNQlfoBByDN5p4tDex55MtdvqnMDcM/v7YG/o4T5OoZEai45JlhRf
KBuQn6nUjesmtiEP8VWo6rtxYj3JkMmyi3eYUEoulFazZ68P0gwQdSF0FbesbTOp
OibVGFK0vozwZbyADW6Mo/3RpWkjNlpc1Rhpr/+UngnIhzJDExoz1pXLNa4PpGfm
pm7THacJUuvg71y3VRJBAz8iWWCN0NF7cyoDixHLdguHxUtcsn/8yztpjKDaMap5
TuJSSLfbJOE9pF93BtdLQkFC9SqqChcbAxDdYkS4FWoOVw0cvj333faVqkjIT/fX
FQpSUhjxp/AMaWWgluwU
=4x4X
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
