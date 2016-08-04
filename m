Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38338 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754238AbcHDIl2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2016 04:41:28 -0400
Subject: Re: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160729071230.GB6215@lukather>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <bccb6739-4804-8c71-a120-2cb8672fb57e@free-electrons.com>
Date: Thu, 4 Aug 2016 10:41:00 +0200
MIME-Version: 1.0
In-Reply-To: <20160729071230.GB6215@lukather>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d8dGgL8cj1uDw9TlMvuNWPMoIrXhrMMJk"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8dGgL8cj1uDw9TlMvuNWPMoIrXhrMMJk
Content-Type: multipart/mixed; boundary="P3kaJFxlppeEDKL19GG9D584gPXtdduVe"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com
Message-ID: <bccb6739-4804-8c71-a120-2cb8672fb57e@free-electrons.com>
Subject: Re: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160729071230.GB6215@lukather>
In-Reply-To: <20160729071230.GB6215@lukather>

--P3kaJFxlppeEDKL19GG9D584gPXtdduVe
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 29/07/2016 09:12, Maxime Ripard wrote:
> On Tue, Jul 26, 2016 at 09:43:47AM +0200, Quentin Schulz wrote:
[...]
>> +static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channe=
l,
>> +				int *val)
>> +{
>> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
>> +	int ret =3D 0;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	mutex_lock(&info->mutex);
>> +
>> +	reinit_completion(&info->completion);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +		     info->soc_specific->tp_mode_en |
>> +		     info->soc_specific->tp_adc_select |
>> +		     info->soc_specific->adc_chan_select(channel));
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
>> +	enable_irq(info->fifo_data_irq);
>> +
>> +	if (!wait_for_completion_timeout(&info->completion,
>> +					 msecs_to_jiffies(100))) {
>> +		ret =3D -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	*val =3D info->adc_data;
>> +
>> +out:
>> +	disable_irq(info->fifo_data_irq);
>> +	mutex_unlock(&info->mutex);
>> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
>> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
>> +
>> +	return ret;
>> +}
>> +
>> +static int sunxi_gpadc_temp_read(struct iio_dev *indio_dev, int *val)=

>> +{
>> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
>> +	int ret =3D 0;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	mutex_lock(&info->mutex);
>> +
>> +	reinit_completion(&info->completion);
>> +
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
>> +	/*
>> +	 * The temperature sensor returns valid data only when the ADC opera=
tes
>> +	 * in touchscreen mode.
>> +	 */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +		     info->soc_specific->tp_mode_en);
>> +	enable_irq(info->temp_data_irq);
>> +
>> +	if (!wait_for_completion_timeout(&info->completion,
>> +					 msecs_to_jiffies(100))) {
>> +		ret =3D -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	*val =3D info->temp_data;
>> +
>> +out:
>> +	disable_irq(info->temp_data_irq);
>> +	mutex_unlock(&info->mutex);
>> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
>> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
>> +
>> +	return ret;
>> +}
>=20
> This looks like the exact same function than above, can't that be
> factored (for example by passing the interrupt number as argument, and
> giving it a way to know if it's going to be used for the ADC or
> temperature as an argument?)

Yes it can. I could use the interrupt number to know in which mode to
operate since each interrupt is only activated in one mode (temperature
or ADC).

[...]
>> +static int sunxi_gpadc_runtime_suspend(struct device *dev)
>> +{
>> +	struct sunxi_gpadc_dev *info =3D iio_priv(dev_get_drvdata(dev));
>> +
>> +	mutex_lock(&info->mutex);
>> +
>> +	/* Disable the ADC on IP */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
>> +	/* Disable temperature sensor on IP */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);
>> +
>> +	mutex_unlock(&info->mutex);
>=20
> Having some comments somewhere about what this mutex protects would be
> great (just like checkpatch tells you about).

ACK.

> However, I'm not sure this is even possible. Isn't the point of the
> runtime_pm precisely to not be called while you're using the device?

I agree on the principle but I am using runtime_pm functions (I am
mainly talking about the pm_runtime_put function) when probing or
removing the driver. Let's say we remove the mutex locks in runtime_pm
functions, what will happen if we are reading raw values from the ADC
when removing the ADC driver for example?

>> +
>> +	return 0;
>> +}
>> +
>> +static int sunxi_gpadc_runtime_resume(struct device *dev)
>> +{
>> +	struct sunxi_gpadc_dev *info =3D iio_priv(dev_get_drvdata(dev));
>> +
>> +	mutex_lock(&info->mutex);
>> +
>> +	/* clkin =3D 6MHz */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL0,
>> +		     SUNXI_GPADC_TP_CTRL0_ADC_CLK_DIVIDER(2) |
>> +		     SUNXI_GPADC_TP_CTRL0_FS_DIV(7) |
>> +		     SUNXI_GPADC_TP_CTRL0_T_ACQ(63));
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +		     info->soc_specific->tp_mode_en);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL3,
>> +		     SUNXI_GPADC_TP_CTRL3_FILTER_EN |
>> +		     SUNXI_GPADC_TP_CTRL3_FILTER_TYPE(1));
>> +	/* period =3D SUNXI_GPADC_TP_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~1.=
3s */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR,
>> +		     SUNXI_GPADC_TP_TPR_TEMP_ENABLE |
>> +		     SUNXI_GPADC_TP_TPR_TEMP_PERIOD(1953));
>> +
>> +	mutex_unlock(&info->mutex);
>> +
>> +	return 0;
>> +}
[...]
>> +	info->soc_specific =3D (struct sunxi_gpadc_soc_specific *)platform_g=
et_device_id(pdev)->driver_data;
>=20
> I'm not sure that cast is necessary (and you can probably shorten that
> structure name).

GCC warns about implicit pointer to integer cast in that case. ACK for
structure name.

[...]
>> +
>> +	irq =3D platform_get_irq_byname(pdev, "TEMP_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no TEMP_DATA_PENDING interrupt registered\n");
>> +		ret =3D irq;
>> +		goto err;
>> +	}
>> +
>> +	irq =3D regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_temp_data_irq_handler, 0,
>> +					   "temp_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request TEMP_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	disable_irq(irq);
>> +	info->temp_data_irq =3D irq;
>> +	atomic_set(&info->ignore_temp_data_irq, 0);
>> +
>> +	irq =3D platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no FIFO_DATA_PENDING interrupt registered\n");
>> +		ret =3D irq;
>> +		goto err;
>> +	}
>> +
>> +	irq =3D regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_fifo_data_irq_handler, 0,
>> +					   "fifo_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	disable_irq(irq);
>> +	info->fifo_data_irq =3D irq;
>> +	atomic_set(&info->ignore_fifo_data_irq, 0);
>=20
> These two blocks to handle the IRQs look very similar, you porbably
> want to factor them.

ACK.

[...]
>> +
>> +err:
>> +	pm_runtime_put(&pdev->dev);
>=20
> You're never disabling it?

ACK.

>> +	/* Disable all hardware interrupts */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
>=20
> This looks like the wrong place to do that. You'll disable the
> interrupts of all the devices of the MFD, which is probbaly not what
> you want to do (and if you do, you want to do it in the MFD driver).

Yes but all subdrivers of the MFD are using IIO channels from the ADC
driver so anyway they would not work at all.

[...]
>> +static const struct platform_device_id sunxi_gpadc_id[] =3D {
>> +	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_soc_specific }=
,
>> +	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_soc_specific }=
,
>> +	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_soc_specific }=
,
>=20
> kernel_ulong_t ? that's weird.

That's the type of the data field of platform_device_id
(http://lxr.free-electrons.com/source/include/linux/mod_devicetable.h#L49=
8).
Otherwise, GCC warns with implicit pointer to integer cast.

Quentin


--P3kaJFxlppeEDKL19GG9D584gPXtdduVe--

--d8dGgL8cj1uDw9TlMvuNWPMoIrXhrMMJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXov+gAAoJEIS4mnU+4PGjX4IQAJN30gFmngEOCbkkcNnYnrGO
B1jzbAR9OSf6QtuOSG06zYZKC04emxwFSP7OmEsUnLVxjNPufPOfDsFAdWPyPlUO
nrLrYlPslKvGKFOlSLLZkdg1N2aqAf7yl0uWJiT+DPMduZOWIA8jFyzcTKLVRSo9
cZeYV/Vl4OmyGZxFcjrTQ3o/a0Fuz3/KoSSMDjUOnNfF6WarJc5cMrLgRmMQKJHv
hVQrl2y9n85Apb4Tr59v4BFxkZaadDZ5DcoS13FQbgslqUz3A9ibuyQce22JEgr2
ArzS2oSl0BxdiUGJW+gaBZY3DlRW1eP+nGRFf6+GPoJ437n+m+pI9LeWsL2e8BrS
Lj8B2s/8tV6fgIXreRLyAmuv29anB8nTNLhWOuNv5q6V3CWTbk8L5GZ3eiqx/Jr7
yebSWbVbZOay/e3ppwLVAFVh/3o4XdeTpkzTobajX7wustlz1yKfigbGKDceiC92
HBN2BqvH3n/muclFjz85krf5p2lygkltukwJlIbv09KBqXcixcYbzpGCL12cf5w0
ETwza6PwquPfXgp+LoDIkmNhKB+b9PZwTc3AqDJz2zJndFkkcq0VYwLeeljkQ3Zs
XvZ0MkhSt+DkV8nR8byEe5c2PpyiE+Tm/Xr+mzLgpdv+mz4PpWmzNLfFUnQ3KROs
gf1LaLBrb3sYnZEGFGLC
=i9pr
-----END PGP SIGNATURE-----

--d8dGgL8cj1uDw9TlMvuNWPMoIrXhrMMJk--
