Return-Path: <bigeasy@linutronix.de>
Date: Wed, 28 Aug 2013 16:18:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Message-ID: <20130828141835.GD14111@linutronix.de>
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com>
 <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

* Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:

>diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_a=
dc.c
>index a952538..ae2202b 100644
>--- a/drivers/iio/adc/ti_am335x_adc.c
>+++ b/drivers/iio/adc/ti_am335x_adc.c
=E2=80=A6

>+static struct iio_trigger *tiadc_iio_allocate_trigger(struct iio_dev *ind=
io_dev)
>+{
>+	struct iio_trigger *trig;
>+	int ret;
>+
>+	trig =3D iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);
>+	if (trig =3D=3D NULL)
>+		return NULL;
>+
>+	trig->dev.parent =3D indio_dev->dev.parent;
>+	trig->ops =3D &tiadc_trigger_ops;
>+	iio_trigger_set_drvdata(trig, indio_dev);
>+
>+	ret =3D iio_trigger_register(trig);
>+	if (ret)

shouldn't you free the trigger / undo iio_trigger_alloc() here?

>+		return NULL;
>+
>+	return trig;
> }

>=20
> static const char * const chan_name_ain[] =3D {
>@@ -220,7 +394,8 @@ static int tiadc_probe(struct platform_device *pdev)
> 					  sizeof(struct tiadc_device));
> 	if (indio_dev =3D=3D NULL) {
> 		dev_err(&pdev->dev, "failed to allocate iio device\n");
>-		return -ENOMEM;
>+		err =3D -ENOMEM;
>+		goto err_ret;
Why the jump instead of leave right away?

> 	}
> 	adc_dev =3D iio_priv(indio_dev);
>=20
>@@ -262,11 +465,14 @@ static int tiadc_remove(struct platform_device *pdev)
> 	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> 	u32 step_en;
>=20
>+	free_irq(adc_dev->irq, indio_dev);
> 	iio_device_unregister(indio_dev);
>+	iio_buffer_unregister(indio_dev);
> 	tiadc_channels_remove(indio_dev);

I think you need also to

	iio_trigger_unregister(adc_dev->trig);
	iio_trigger_free(adc_dev->trig);

here.
=20
> 	step_en =3D get_adc_step_mask(adc_dev);
> 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
>+	iio_device_free(indio_dev);
>=20
> 	return 0;
> }

Sebastian
