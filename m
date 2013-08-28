Return-Path: <bigeasy@linutronix.de>
Date: Wed, 28 Aug 2013 18:43:08 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Message-ID: <20130828164308.GE14111@linutronix.de>
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
>@@ -231,28 +406,56 @@ static int tiadc_probe(struct platform_device *pdev)
=E2=80=A6
>+err_free_device:
>+	iio_device_free(indio_dev);

I am not sure about this one.

>+err_ret:
> 	return err;
> }
>=20
>@@ -262,11 +465,14 @@ static int tiadc_remove(struct platform_device *pdev)
> 	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> 	u32 step_en;
>=20
>+	free_irq(adc_dev->irq, indio_dev);
> 	iio_device_unregister(indio_dev);
>+	iio_buffer_unregister(indio_dev);
> 	tiadc_channels_remove(indio_dev);
>=20
> 	step_en =3D get_adc_step_mask(adc_dev);
> 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
>+	iio_device_free(indio_dev);

But this one is wrong. The will be removed via dev_res() and if you do
it here as well then dev_res() will decrement the reference of an unused
object.

>=20
> 	return 0;
> }

Sebastian
