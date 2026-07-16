Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90253F6C24;
	Thu, 16 Jul 2026 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195603; cv=none; b=sJxGs+TF+kS3lkVPKdl/Fx0xovD2tmdolQ4DpB6TbaBY7Hbc92xcv9uzFhJx3G/QDWl5r9kojvq3Zz8kc/aFmb8X8VuZBJQACErcA3xXkJj5ZhByoHQLpCnU9KZNuduZgZELVhcpzoAObjACHyAOAG7ahmMn01aELQCJ5YYdzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195603; c=relaxed/simple;
	bh=OpLF7pWQL7VDB2yMoTwf5EK9cIOaLfYYnSk/+Br8u68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFQ+jPH51ETMc4o1jpGwgv9FMcwe54wx3z+fGinBCnxe7p5PueR2q2uKhq8b150m2DgoEP0LXOdP+WvwxesxUtKJxFgvRwQTWA7PwN+bDO2rGCPnTQUu6rGFUMPtP4BqT12SiMUlXwabXVkv2OABo309GHfyZcDWSdYUJh77QHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F+2fCUgp; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F+2fCUgp"
Message-ID: <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784195588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSXuBPNk9mW3KmoEcg1AiFdMCNVCJbICqbxkP0CgUEU=;
	b=F+2fCUgpxgrVqH2XylkeRJNuzZl9II4OVakZq752wevGxrOuzIXTLZSfvQutdSOG+3EBOm
	qeA+FL6qZ2WlLaHywc6D9PH3A93SpcwQQzLuq38Y5ATfRLprXcnzeUR4uAa4jpwWA97xFZ
	NcH8fLh4sYQdV+D9vzvbz9wdCALhPTA=
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 16 Jul 2026 15:52:51 +0600
In-Reply-To: <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
		 <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Tue, 2026-07-14 at 22:28 +0200, Jorijn van der Graaf wrote:
> ...
>=20
Hi! the driver looks clean overall. I see you have followed ;
>=20
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Support for QST QMC6308 3-Axis Magnetic Sensor on I2C bus.
> + *
> + * Copyright (C) 2026 Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> + *
> + * Datasheet available at
> + * <https://qstcorp.com/upload/pdf/202202/13-52-15%20QMC6308%20Datasheet=
%20Rev.%20F(1).pdf>
> + */
> +
>=20
...
> + #define QMC6308_OSR2_MASK GENMASK(7, 6)
This is never used so it's dead code. Are you supposed to use it somewhere?
> +
> +/*
> + * Power-on completion time (datasheet Table 7), also used as a
> + * conservative bound after soft reset, for which the datasheet
> + * gives no figure.
> + */
> +#define QMC6308_POR_US 250
Describe what this value is here, and explain in call sites why you are=C2=
=A0
using it for something else too. i.e.,

/* Power-on completion time (datasheet Table 7) */
#define QMC6308_POR_US 250

And then in call sites,
"reusing por time because..."

> +
> +#define QMC6308_AUTOSUSPEND_DELAY_MS 500
You can call it QMC6308_SLEEP_DELAY_MS to align with other values.
> +
> +struct qmc6308_data {
> + struct regmap *regmap;
> + /*
> + * Protect data->range/odr/osr.
> + * Protect poll and read during measurement (reading the status
> + * register clears DRDY).
> + */
"reading the status register clears DRDY" - This bit of information is not
describing the mutex. Explain it at a call site. i.e, where you read STATUS=
 register
to clear DRDY.
> + struct mutex mutex;
> + struct iio_mount_matrix orientation;
> + u8 range;
> + u8 odr;
> + u8 osr;
> +};
> +
...
> +
> +static int qmc6308_take_measurement(struct iio_dev *indio_dev, int index=
,
> + =C2=A0=C2=A0=C2=A0 int *val)
> +{
> + struct qmc6308_data *data =3D iio_priv(indio_dev);
> + struct regmap *map =3D data->regmap;
> + struct device *dev =3D regmap_get_device(map);
> + unsigned int status;
> + __le16 buf[3];
> + int ret;
Use reverse x-mas tree order.
struct qmc6308_data *data =3D iio_priv(indio_dev);
struct device *dev =3D regmap_get_device(map);
struct regmap *map =3D data->regmap;
> +
>=20
...
> +static int qmc6308_write_raw(struct iio_dev *indio_dev,
> + =C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> + =C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> + struct qmc6308_data *data =3D iio_priv(indio_dev);
> + unsigned int status;
> + unsigned int i;
Why not use a switch here instead of depending on 'i'. In it's current form=
,
we would need to keep going back to check what the scales, odr, osr arrays =
look like.
I would suggest following the same pattern as the QMC5883L driver.

The arrays could also be flattened like this if you follow the above sugges=
tion.
+static const int qmc6308_odr_avail[] =3D { 10, 50, 100, 200 };
> + int ret;
> +
> + switch (mask) {
> + case IIO_CHAN_INFO_SCALE: {
> + if (val !=3D 0)
> + return -EINVAL;
> +
> + for (i =3D 0; i < ARRAY_SIZE(qmc6308_scales); i++) {
> + if (val2 =3D=3D qmc6308_scales[i][1])
> + break;
> + }
> + if (i =3D=3D ARRAY_SIZE(qmc6308_scales))
> + return -EINVAL;
This check won't be needed then.=20
> ...
>=20

> +		ret =3D regmap_update_bits(data->regmap, QMC6308_REG_CTRL2,
> +					 QMC6308_RNG_MASK,
> +					 FIELD_PREP(QMC6308_RNG_MASK, i));
>=20
> +		data->range =3D i;
Another issue I noticed, what happens if the update succeeds but the "statu=
s read to clear" below fails?
You are returning an incorrect error to the userspace even though the scale=
 change took effect.=C2=A0
I think a better approach here would be a=C2=A0log and continue instead of =
failing.
> +=20
> + 		return regmap_read(data->regmap, QMC6308_REG_STATUS,
> + 				&status);

...
> +}
> +
> +static int qmc6308_init(struct qmc6308_data *data)
> +{
> + struct regmap *map =3D data->regmap;
> + unsigned int reg;
> + int ret;
> +
> + ret =3D regmap_read(map, QMC6308_REG_ID, &reg);
> + if (ret)
> + return ret;
> +
> + /* Allow unknown IDs so that fallback compatibles work */
> + if (reg !=3D QMC6308_CHIP_ID)
> + dev_warn(regmap_get_device(map),
> + "Unknown chip id: 0x%02x, continuing\n", reg);
> +
> + /* The SOFT_RST bit is not auto-cleared and must be written back 0 */
> + ret =3D regmap_write(map, QMC6308_REG_CTRL2, QMC6308_SOFT_RST);
> + if (ret)
> + return ret;
> +
> + fsleep(QMC6308_POR_US);
> +
Add a comment why you are using this value here as I suggested above.
(i.e., as a conservative bound)
> + data->range =3D QMC6308_RNG_30G;
> +
> + ret =3D regmap_write(map, QMC6308_REG_CTRL2,
> + =C2=A0=C2=A0 FIELD_PREP(QMC6308_SET_RESET_MASK,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QMC6308_SET_RESET_ON) |
> + =C2=A0=C2=A0 FIELD_PREP(QMC6308_RNG_MASK, data->range));
> + if (ret)
> + return ret;
> +
> + data->odr =3D QMC6308_ODR_50HZ;
> + data->osr =3D QMC6308_OSR1_8;
Might as well assign the default values for data->{range, odr, osr} togethe=
r?
data->range =3D QMC6308_RNG_30G;
data->odr =3D QMC6308_ODR_50HZ;
data->osr =3D QMC6308_OSR1_8;

I find to easier to glance.
> +
> + return regmap_write(map, QMC6308_REG_CTRL1,
> + =C2=A0=C2=A0=C2=A0 FIELD_PREP(QMC6308_MODE_MASK,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QMC6308_MODE_NORMAL) |
> + =C2=A0=C2=A0=C2=A0 FIELD_PREP(QMC6308_ODR_MASK, data->odr) |
> + =C2=A0=C2=A0=C2=A0 FIELD_PREP(QMC6308_OSR1_MASK, data->osr));
> +}
> +
>=20
...
> +
> +MODULE_DESCRIPTION("QST QMC6308 3-Axis Magnetic Sensor driver");
> +MODULE_AUTHOR("Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>");
> +MODULE_LICENSE("Dual BSD/GPL");
--
Best regards,
Sirat
