Return-Path: <rachna@ti.com>
From: "Patil, Rachna" <rachna@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Landley
	<rob@landley.net>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring
	<rob.herring@calxeda.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Jonathan
 Cameron <jic23@cam.ac.uk>
Subject: RE: [PATCH RESEND 6/7] input: ti_am335x_tsc: Add DT support
Date: Tue, 27 Nov 2012 07:11:32 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E96FBF1@DBDE01.ent.ti.com>
References: <1352271124-5513-1-git-send-email-rachna@ti.com>
 <1352271124-5513-7-git-send-email-rachna@ti.com>
 <20121121183223.GA18950@core.coreip.homeip.net>
In-Reply-To: <20121121183223.GA18950@core.coreip.homeip.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Dmitry,

On Thu, Nov 22, 2012 at 00:02:23, Dmitry Torokhov wrote:
> Hi Rachna,
>=20
> On Wed, Nov 07, 2012 at 12:22:03PM +0530, Patil, Rachna wrote:
> > Add DT support for client touchscreen driver
> >=20
> > Signed-off-by: Patil, Rachna <rachna@ti.com>
> > ---
> >  drivers/input/touchscreen/ti_am335x_tsc.c |   60 +++++++++++++++++++++=
+++-----
> >  1 files changed, 50 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c=20
> > b/drivers/input/touchscreen/ti_am335x_tsc.c
> > index 7a26810..c063cf6 100644
> > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > @@ -26,6 +26,8 @@
> >  #include <linux/io.h>
> >  #include <linux/input/ti_am335x_tsc.h>  #include <linux/delay.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > =20
> >  #include <linux/mfd/ti_am335x_tscadc.h>
> > =20
> > @@ -398,12 +400,18 @@ static int __devinit titsc_probe(struct platform_=
device *pdev)
> >  	struct titsc *ts_dev;
> >  	struct input_dev *input_dev;
> >  	struct ti_tscadc_dev *tscadc_dev =3D pdev->dev.platform_data;
> > -	struct mfd_tscadc_board	*pdata;
> > -	int err;
> > -
> > -	pdata =3D tscadc_dev->dev->platform_data;
> > -
> > -	if (!pdata) {
> > +	int err, i;
> > +	struct mfd_tscadc_board	*pdata =3D NULL;
> > +	struct device_node *node =3D NULL;
> > +	u32 val32, wires_conf[4];
> > +
> > +	if (tscadc_dev->dev->of_node) {
> > +		node =3D tscadc_dev->dev->of_node;
> > +		node =3D of_find_node_by_name(node, "tsc");
> > +	} else
> > +		pdata =3D tscadc_dev->dev->platform_data;
> > +
> > +	if (!pdata && !node) {
> >  		dev_err(&pdev->dev, "Could not find platform data\n");
> >  		return -EINVAL;
> >  	}
> > @@ -421,11 +429,43 @@ static int __devinit titsc_probe(struct platform_=
device *pdev)
> >  	ts_dev->mfd_tscadc =3D tscadc_dev;
> >  	ts_dev->input =3D input_dev;
> >  	ts_dev->irq =3D tscadc_dev->irq;
> > -	ts_dev->wires =3D pdata->tsc_init->wires;
> > -	ts_dev->x_plate_resistance =3D pdata->tsc_init->x_plate_resistance;
> > -	ts_dev->steps_to_configure =3D pdata->tsc_init->steps_to_configure;
> > -	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
> > +
> > +	if (node) {
> > +		err =3D of_property_read_u32(node, "wires", &val32);
> > +		if (err < 0)
> > +			goto err_free_mem;
> > +		else
> > +			ts_dev->wires =3D val32;
> > +
> > +		err =3D of_property_read_u32(node, "x-plate-resistance", &val32);
> > +		if (err < 0)
> > +			goto err_free_mem;
> > +		else
> > +			ts_dev->x_plate_resistance =3D val32;
> > +
> > +		err =3D of_property_read_u32(node, "steps-to-configure", &val32);
> > +		if (err < 0)
> > +			goto err_free_mem;
> > +		else
> > +			ts_dev->steps_to_configure =3D val32;
> > +
> > +		err =3D of_property_read_u32_array(node, "wire-config",
> > +				wires_conf, ARRAY_SIZE(wires_conf));
> > +		if (err < 0)
> > +			goto err_free_mem;
> > +		else {
> > +			for (i =3D 0; i < ARRAY_SIZE(wires_conf); i++)
> > +				ts_dev->config_inp[i] =3D wires_conf[i];
> > +		}
> > +	} else {
> > +		ts_dev->wires =3D pdata->tsc_init->wires;
> > +		ts_dev->x_plate_resistance =3D
> > +			pdata->tsc_init->x_plate_resistance;
> > +		ts_dev->steps_to_configure =3D
> > +			pdata->tsc_init->steps_to_configure;
> > +		memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
> >  			sizeof(pdata->tsc_init->wire_config));
>=20
> I believe if platform data is supplied it should take precedence over DT =
data so that parameters can be adjusted if really needed.

Ok. I will fix this is in v2.

Regards,
Rachna
