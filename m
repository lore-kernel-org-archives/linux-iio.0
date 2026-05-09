Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653D382373
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317525; cv=none; b=Ybc3QKAZieuO2e60XtyRFbc4OHzHOUYBDSGqZPE1+8gQr4npr+W+fbB8KXNqgLilddj7BUl+V4BPawt02qCFNrFoSmok2lvUr0CbiOJq0zFEAU4M83TWqm8i4kQ+z48asg6ujaTnqgAL077nDCyYAcnGM/MUV0fg2FCReNtPAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317525; c=relaxed/simple;
	bh=95G7Rb6VBE/lS+Z8DRFEz1gO3+AXk5FH1AiOG8X9rTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXPFl/E0TzPdA7cHTmrPYJ2IK18lurjGDwXUB9Y1WUWYdJwulDHPhvt30Yiwnp8lnLjtws6iQEj5W4d8Qxdixx3SlWfLl75D1HvDwigK8iXUwjb7/ogAfB+//NwEeCnCNXRk2h0nqDLSz9B2eXtE1JxVrOwQwLZYXI3SD/oQdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6WO4MMC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6WO4MMC"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43eb05b1875so1617114f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317521; x=1778922321; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kRfWKLPTcBFzrkGwmRpgCleHfJj8IyROxbUvtdzq89w=;
        b=b6WO4MMCIDx3FilnX1wdPqmW9WLwr0RQ40syHzB4xzqnzJM3s8oJMwLbxhqh8QWQnK
         pfxtQS/2OevlxYplQaP06BNAjpufjt5ohLotjFBrbHieuxh1lKzaHoRSuguxtnVwLQir
         H//yl+XUcsH7GPo/2slkwrzqa9bp52i85NM8DCPEzmi6akkNbcmoah+87/KAJSXMcr9b
         /vPDesFIFGwtVjg0UVphVjpr3wxl25OtQjDrKthMWDV9wKLkLs7Ncghm1sbT4PkaRhS3
         PhAbO3trSqxg7UOg4zud6B9oNh8I+I+STLJtP7fkVqOzGWmuc+WPb9IJtmppjT3rpn4Q
         D8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317521; x=1778922321;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRfWKLPTcBFzrkGwmRpgCleHfJj8IyROxbUvtdzq89w=;
        b=DNXVMMDbhwCnDkK37h5MquLQKci1MiA1tw1867s6iie+GKm/5HBHbYk1ZEJi01ixHc
         eGbAS6Y1oNSuBk7eEXs+CzgR6XVOOrAb4gpUqbtHbTiTstb9q54bx/IWx9BQ5LyC+q2d
         TUW6ythWpdsB+ogqGwNFyrqax8BfOjZCa8IZs1RY6SfVCTq6MaECIVQE8K7dv3+9lpCN
         kyqh2AUOHZXBbjMUfJG9sOJt3cLlsIuXvRMGuLffa+97jtNKtHo6TFbdi2L3naxEJMeK
         Gp4gTBTfvgPOegr7HeSwIrpZJ8iNKyb0Foq85s555OpHgcVKzxhb3KpVHTDF1z1tSKf/
         MdAw==
X-Gm-Message-State: AOJu0YwAaqsmPv6bp/F/bz5mrW5vsL6UPpq7Ec+DbVIxuKDm+C1XmQev
	YijGb8FudK8pN/8QeiJ2TLGVzpdO24Qf8lGgpPY15FMfCw4ABq4CnjrM
X-Gm-Gg: Acq92OEs5v/n/iheZylSSSbOV7lZ2tVaQneiZQjudHIHv4fxNHSPaxGOZWOsVJe4vNC
	R4HYXW5oRvbNvEqwhMQ60ACAY+3xi5l6e82ep5NEJtqFXNHqphIZGqmJkaU+6sfspxprvl9LSq6
	snBcMr70J9MvNJi40RdwiQ7dDs5Qc+z5P6aU3UrfzQIDXfKnNv/TvfMLtHgFhT95MzTvQrs6p8x
	u0UPUabSXnrDouZo7BFprpuEcVHDIzUuXG3tv6une9CXijOxaU3MYaEItqtJ0q3Ou+lv+1Mp9yu
	3OS2XTq9WiF0lE5IrJCY84f0pTFisUnYcP8USvpBCYIA1X/zhwMzD1wRvFo3QFW6GVeqsEmX1Af
	0prPJluj+psFFZaOBDI6m1cORGzoH7WkCB+QKMX7Be4bNBwknJ7burvCjZk7gKTavBI0zITtLld
	af1FASPvSOzXgmwHEgmdtuLuRC5GOIQsNjYY/C4s+xySz0HSEDiCfB+5EDX6tXUGHE3S3NZ7gvA
	vZD8d34OIR0
X-Received: by 2002:a05:6000:2902:b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-4568c19b2b1mr2549313f8f.27.1778317521353;
        Sat, 09 May 2026 02:05:21 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm10246041f8f.16.2026.05.09.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:05:20 -0700 (PDT)
Message-ID: <a73cd9f3c061b390a2ef661491f9b251db64d6c1.camel@gmail.com>
Subject: Re: [PATCH 6/8] iio: magnetometer: ak8975: use temporary variable
 for struct device
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Sat, 09 May 2026 10:06:21 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-6-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-6-37827ca68fb3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Use temporary variable for struct device to make code neater.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 63 +++++++++++++++++++---------=
-----------
> =C2=A01 file changed, 31 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> 394f930b862e82fd41c02d81bc6fdb3cfc8b729f..fde37cdcdd053bde1630c2f73ab717f=
9d008e2fa
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -433,18 +433,17 @@ struct ak8975_data {
> =C2=A0/* Enable attached power regulator if any. */
> =C2=A0static int ak8975_power_on(const struct ak8975_data *data)
> =C2=A0{
> +	struct device *dev =3D &data->client->dev;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	ret =3D regulator_enable(data->vdd);
> =C2=A0	if (ret) {
> -		dev_warn(&data->client->dev,
> -			 "Failed to enable specified Vdd supply\n");
> +		dev_warn(dev, "Failed to enable specified Vdd supply\n");
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0	ret =3D regulator_enable(data->vid);
> =C2=A0	if (ret) {
> -		dev_warn(&data->client->dev,
> -			 "Failed to enable specified Vid supply\n");
> +		dev_warn(dev, "Failed to enable specified Vid supply\n");
> =C2=A0		regulator_disable(data->vdd);
> =C2=A0		return ret;
> =C2=A0	}
> @@ -572,6 +571,7 @@ static irqreturn_t ak8975_irq_handler(int irq, void *=
data)
> =C2=A0static int ak8975_setup_irq(struct ak8975_data *data)
> =C2=A0{
> =C2=A0	struct i2c_client *client =3D data->client;
> +	struct device *dev =3D &client->dev;
> =C2=A0	int irq;
> =C2=A0	int ret;
> =C2=A0
> @@ -582,9 +582,8 @@ static int ak8975_setup_irq(struct ak8975_data *data)
> =C2=A0	else
> =C2=A0		irq =3D gpiod_to_irq(data->eoc_gpiod);
> =C2=A0
> -	ret =3D devm_request_irq(&client->dev, irq, ak8975_irq_handler,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&client->dev), data);
> +	ret =3D devm_request_irq(dev, irq, ak8975_irq_handler, IRQF_TRIGGER_RIS=
ING,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(dev), data);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -600,12 +599,13 @@ static int ak8975_setup_irq(struct ak8975_data *dat=
a)
> =C2=A0static int ak8975_setup(struct ak8975_data *data)
> =C2=A0{
> =C2=A0	struct i2c_client *client =3D data->client;
> +	struct device *dev =3D &client->dev;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	/* Write the fused rom access mode. */
> =C2=A0	ret =3D ak8975_set_mode(data, FUSE_ROM);
> =C2=A0	if (ret < 0) {
> -		dev_err(&client->dev, "Error in setting fuse access mode\n");
> +		dev_err(dev, "Error in setting fuse access mode\n");
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> @@ -615,22 +615,21 @@ static int ak8975_setup(struct ak8975_data *data)
> =C2=A0							sizeof(data->asa),
> =C2=A0							data->asa);
> =C2=A0	if (ret < 0) {
> -		dev_err(&client->dev, "Not able to read asa data\n");
> +		dev_err(dev, "Not able to read asa data\n");
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* After reading fuse ROM data set power-down mode */
> =C2=A0	ret =3D ak8975_set_mode(data, POWER_DOWN);
> =C2=A0	if (ret < 0) {
> -		dev_err(&client->dev, "Error in setting power-down mode\n");
> +		dev_err(dev, "Error in setting power-down mode\n");
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (data->eoc_gpiod || client->irq > 0) {
> =C2=A0		ret =3D ak8975_setup_irq(data);
> =C2=A0		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"Error setting data ready interrupt\n");
> +			dev_err(dev, "Error setting data ready interrupt\n");
> =C2=A0			return ret;
> =C2=A0		}
> =C2=A0	}
> @@ -736,10 +735,11 @@ static int ak8975_read_axis(struct iio_dev *indio_d=
ev, int
> index, int *val)
> =C2=A0	struct ak8975_data *data =3D iio_priv(indio_dev);
> =C2=A0	const struct i2c_client *client =3D data->client;
> =C2=A0	const struct ak_def *def =3D data->def;
> +	struct device *dev =3D &data->client->dev;
> =C2=A0	__le16 rval;
> =C2=A0	int ret;
> =C2=A0
> -	pm_runtime_get_sync(&data->client->dev);
> +	pm_runtime_get_sync(dev);
> =C2=A0
> =C2=A0	mutex_lock(&data->lock);
> =C2=A0
> @@ -757,20 +757,20 @@ static int ak8975_read_axis(struct iio_dev *indio_d=
ev, int
> index, int *val)
> =C2=A0	/* Read out ST2 for release lock on measurement data. */
> =C2=A0	ret =3D i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]=
);
> =C2=A0	if (ret < 0) {
> -		dev_err(&client->dev, "Error in reading ST2\n");
> +		dev_err(dev, "Error in reading ST2\n");
> =C2=A0		goto exit;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (ret & (data->def->ctrl_masks[ST2_DERR] |
> =C2=A0		=C2=A0=C2=A0 data->def->ctrl_masks[ST2_HOFL])) {
> -		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
> +		dev_err(dev, "ST2 status error 0x%x\n", ret);
> =C2=A0		ret =3D -EINVAL;
> =C2=A0		goto exit;
> =C2=A0	}
> =C2=A0
> =C2=A0	mutex_unlock(&data->lock);
> =C2=A0
> -	pm_runtime_put_autosuspend(&data->client->dev);
> +	pm_runtime_put_autosuspend(dev);
> =C2=A0
> =C2=A0	/* Swap bytes and convert to valid range. */
> =C2=A0	*val =3D clamp_t(s16, le16_to_cpu(rval), -def->range, def->range);
> @@ -779,8 +779,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev=
, int
> index, int *val)
> =C2=A0
> =C2=A0exit:
> =C2=A0	mutex_unlock(&data->lock);
> -	pm_runtime_put_autosuspend(&data->client->dev);
> -	dev_err(&client->dev, "Error in reading axis\n");
> +	pm_runtime_put_autosuspend(dev);
> +	dev_err(dev, "Error in reading axis\n");
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -927,7 +927,7 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	 * We may not have a GPIO based IRQ to scan, that is fine, we will
> =C2=A0	 * poll if so.
> =C2=A0	 */
> -	eoc_gpiod =3D devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
> +	eoc_gpiod =3D devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> =C2=A0	if (IS_ERR(eoc_gpiod))
> =C2=A0		return PTR_ERR(eoc_gpiod);
> =C2=A0	gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
> @@ -937,13 +937,12 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	 * deassert reset on ak8975_power_on() and assert reset on
> =C2=A0	 * ak8975_power_off().
> =C2=A0	 */
> -	reset_gpiod =3D devm_gpiod_get_optional(&client->dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "reset", GPIOD_OUT_HIGH);
> +	reset_gpiod =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> =C2=A0	if (IS_ERR(reset_gpiod))
> =C2=A0		return PTR_ERR(reset_gpiod);
> =C2=A0
> =C2=A0	/* Register with IIO */
> -	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> =C2=A0	if (indio_dev =3D=3D NULL)
> =C2=A0		return -ENOMEM;
> =C2=A0
> @@ -955,7 +954,7 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	data->reset_gpiod =3D reset_gpiod;
> =C2=A0	data->eoc_irq =3D 0;
> =C2=A0
> -	ret =3D iio_read_mount_matrix(&client->dev, &data->orientation);
> +	ret =3D iio_read_mount_matrix(dev, &data->orientation);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -965,16 +964,16 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0		return -ENODEV;
> =C2=A0
> =C2=A0	/* If enumerated via firmware node, fix the ABI */
> -	if (dev_fwnode(&client->dev))
> -		name =3D dev_name(&client->dev);
> +	if (dev_fwnode(dev))
> +		name =3D dev_name(dev);
> =C2=A0	else
> =C2=A0		name =3D id->name;
> =C2=A0
> =C2=A0	/* Fetch the regulators */
> -	data->vdd =3D devm_regulator_get(&client->dev, "vdd");
> +	data->vdd =3D devm_regulator_get(dev, "vdd");
> =C2=A0	if (IS_ERR(data->vdd))
> =C2=A0		return PTR_ERR(data->vdd);
> -	data->vid =3D devm_regulator_get(&client->dev, "vid");
> +	data->vid =3D devm_regulator_get(dev, "vid");
> =C2=A0	if (IS_ERR(data->vid))
> =C2=A0		return PTR_ERR(data->vid);
> =C2=A0
> @@ -996,7 +995,7 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	ret =3D ak8975_who_i_am(data, data->def->type);
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret, "Unexpected device\n");
> -	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> +	dev_dbg(dev, "Asahi compass chip %s\n", name);
> =C2=A0
> =C2=A0	/* Perform some basic start-of-day setup of the device. */
> =C2=A0	ret =3D ak8975_setup(data);
> @@ -1032,8 +1031,8 @@ static int ak8975_probe(struct i2c_client *client)
> =C2=A0	 * The device comes online in 500us, so add two orders of magnitud=
e
> =C2=A0	 * of delay before autosuspending: 50 ms.
> =C2=A0	 */
> -	pm_runtime_set_autosuspend_delay(&client->dev, 50);
> -	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -1048,7 +1047,7 @@ static int ak8975_runtime_suspend(struct device *de=
v)
> =C2=A0	/* Set the device in power down if it wasn't already */
> =C2=A0	ret =3D ak8975_set_mode(data, POWER_DOWN);
> =C2=A0	if (ret < 0) {
> -		dev_err(&client->dev, "Error in setting power-down mode\n");
> +		dev_err(dev, "Error in setting power-down mode\n");
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0	/* Next cut the regulators */
> @@ -1072,7 +1071,7 @@ static int ak8975_runtime_resume(struct device *dev=
)
> =C2=A0	 */
> =C2=A0	ret =3D ak8975_set_mode(data, POWER_DOWN);
> =C2=A0	if (ret < 0) {
> -		dev_err(&client->dev, "Error in setting power-down mode\n");
> +		dev_err(dev, "Error in setting power-down mode\n");
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
