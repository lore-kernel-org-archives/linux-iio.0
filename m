Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580383EAC95
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352513; cv=none; b=pDYiqZts4YFFqrLI2+xZ4iaM7cZVzsF177q/CZkrQ592seEHtqgV1CfybmYK3LAO2vjvI3V5F050ImwotBV7R8IKX3RWpYLiL7elDgdJ6+jcrcbMIsCb2tZvSVVIuRSAnQi/movuaEMIMi+FBGqfthFquLnoJherrd99i87+6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352513; c=relaxed/simple;
	bh=QY/EKtdGogqwkmlO2ZdAtnSp1pWgIoXuRktgGVtvQOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/cZE6UDg7bLRWenoP0nu55vD9UiTnKhgsB6AUNSK+9WlS2OmdOlE1mxFzhKAjIgq+hEaLWH5km6AkYtVpzBBfCBtDRxhK+xaaClG1dWI5YHm3VdZKwfVoM1X4YiT6dLvagZuIG6ZDrAnqMzE6+TFXDML2XvC+XnTU4VktNi5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li0pvTtL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li0pvTtL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b467dcf0bso3742521f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774352511; x=1774957311; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PTVv0MxjvBZlsIcafRVG9tp51epFA9vgJgoQG8z7Nzk=;
        b=Li0pvTtLvw4iUYDTyy7Itfu6zG9rs6ZvrMS1KdW4xosdKvoGUVPSGDenJu8UC6DDLO
         556V061cSgB7QYMQh9HJ7wQorLT3cc3hb72M/TmXNBXK7QLJngjogmkOSf33ss7eyotZ
         Smx826/1ENYHjwLETChGx0b1n6J0xGnhEPzmNYQIZgpfdpasCr9f3YxqPQOxCfmx+8PW
         QjRyG1PHGkVt1OnCbYuZNjlbCRb/ShbFo7SV2qLrxq0ZrdKfjB1skg84Qk16F8EQy3/v
         AbpSe5qexlsB8OP5X8JGJOT6vqHaNz9I22wlmjsT45oIe3PF3dpwALFc13QjMOMEcdpk
         9tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352511; x=1774957311;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTVv0MxjvBZlsIcafRVG9tp51epFA9vgJgoQG8z7Nzk=;
        b=BZ6w+6DqKzxluHDFL1YwN/ykOzoQD6RUIbkd1EcAklxVaScC80Jp73wR2ErbYKDgtc
         aJnRuu9VXUpRIFk5+M6Bm0WO259LF7aBROKUvdmx6rTufXoux5x/I/RntAKDr9EOFbBt
         QJtuFJyTydFp6HWOpC7ZG043DTk9HSnim3w7C6Y0VCHWF0AkCyV9quSsMpKcPeCNbSn9
         ibA9iGjMNKT4BmWGQgT/82fnGY4nJ1idKUyzG83LyFAq3YIjx4TYfPOaz1sGuyllRe3h
         fqgMH3ajJTjPL8ipYkgG7zW47FEVecCY4CIrbfZfWihONamRun9Q06nGrV3bPRHogIpe
         ozng==
X-Forwarded-Encrypted: i=1; AJvYcCV/iN5rpKrbrwSJCgV781sqc58g6Cvo2GroS5Y82n41YXkpESHv3W+13xohJL6xyzoE2DAXFcHSB7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNpEvY0j5HYiIa+qk/GKvckoHBktDs582CS6y01uEIAb6aTQ3
	S31hhjOCtBVKfo1jchziM5eES8BvytQqwpvcCk8NJOjcq5AAFjlCjUkb
X-Gm-Gg: ATEYQzwo8IMJnkBp+Koh0TeegkMAAvBw2cYW3GLwowG1hCdXSmUWpYsc8jarfehyGri
	Z0hFLhy3yguoSn4A6gNhkDwE9JyAk7cnpTY+mNTNDVKV8c7Z2Z41bE8IyOstykMe0aoWvd3Rnah
	F6ADbcwwg5oO4rh7elMXrTZrg9ldDMHf05KPFlbdJh6rR/mSJjCXjFbe8w+JX0UD/v4IPCyOoNM
	1uGb/aHVtqO5zi4tj8J0fvJUe/2fsopU+9dsZvHQpR1fYgbt8PaXz0rhbyEnzwIVP+2egvDu4he
	cDnpuQ/HijBR3CBwmNQjLDZD0Jxy53Z3Sj3Yh9Etp4sTTqh4Vev+yo3bZBmTZvpY10NIL+8b/qo
	u888Uul1AWnsTbJJaq/KGwDeQRU6g2p+Wu8t/KUTalluqHjtKoEw2Vg8H/nCFFHfvV8ZNYF4bSy
	y01X8XjyiAYvJYRSn1Jcz00UfSjwwu7h8=
X-Received: by 2002:a05:6000:2906:b0:437:7719:ca82 with SMTP id ffacd0b85a97d-43b805319b4mr5037338f8f.3.1774352510462;
        Tue, 24 Mar 2026 04:41:50 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644addfbsm38507259f8f.3.2026.03.24.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:41:50 -0700 (PDT)
Message-ID: <b980b8ad92cf560021a8b428ed0134ca582895c8.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads8688: use read_avail for available
 attributes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Gabriel Rondon <grondon@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Mar 2026 11:42:36 +0000
In-Reply-To: <20260323215633.8140-1-grondon@gmail.com>
References: <20260323215633.8140-1-grondon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-23 at 21:56 +0000, Gabriel Rondon wrote:
> Convert the in_voltage_scale_available and in_voltage_offset_available
> attributes from legacy IIO_DEVICE_ATTR with custom show functions to the
> IIO framework's read_avail callback. This uses the framework's built-in
> support for _available attributes, removing the need for manual sysfs
> formatting.
>=20
> Precompute the available scale values at probe time since they depend on
> the reference voltage which does not change after initialization.
>=20
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
> ---

Hi Grabriel,

Thanks for your patch, just some minor nits from me. Anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ti-ads8688.c | 73 +++++++++++++++++++--------------=
---
> =C2=A01 file changed, 38 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index b0bf46cae..f37098db9 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -6,7 +6,6 @@
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/slab.h>
> -#include <linux/sysfs.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/err.h>
> @@ -17,7 +16,6 @@
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/sysfs.h>
> =C2=A0
> =C2=A0#define ADS8688_CMD_REG(x)		(x << 8)
> =C2=A0#define ADS8688_CMD_REG_NOOP		0x00
> @@ -66,6 +64,7 @@ struct ads8688_state {
> =C2=A0	const struct ads8688_chip_info	*chip_info;
> =C2=A0	struct spi_device		*spi;
> =C2=A0	unsigned int			vref_mv;
> +	int				scale_avail[3][2];
> =C2=A0	enum ads8688_range		range[8];
> =C2=A0	union {
> =C2=A0		__be32 d32;
> @@ -114,37 +113,9 @@ static const struct ads8688_ranges ads8688_range_def=
[5] =3D {
> =C2=A0	}
> =C2=A0};
> =C2=A0
> -static ssize_t ads8688_show_scales(struct device *dev,
> -				=C2=A0=C2=A0 struct device_attribute *attr, char *buf)
> -{
> -	struct ads8688_state *st =3D iio_priv(dev_to_iio_dev(dev));
> -
> -	return sprintf(buf, "0.%09u 0.%09u 0.%09u\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[0].scale * st->=
vref_mv,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[1].scale * st->=
vref_mv,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[2].scale * st->=
vref_mv);
> -}
> -
> -static ssize_t ads8688_show_offsets(struct device *dev,
> -				=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "%d %d\n", ads8688_range_def[0].offset,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[3].offset);
> -}
> -
> -static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_show_scales, NULL, 0);
> -static IIO_DEVICE_ATTR(in_voltage_offset_available, S_IRUGO,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_show_offsets, NULL, 0);
> -
> -static struct attribute *ads8688_attributes[] =3D {
> -	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> -	&iio_dev_attr_in_voltage_offset_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ads8688_attribute_group =3D {
> -	.attrs =3D ads8688_attributes,
> +static const int ads8688_offset_avail[] =3D {
> +	-(1 << (ADS8688_REALBITS - 1)),
> +	0,
> =C2=A0};
> =C2=A0
> =C2=A0#define ADS8688_CHAN(index)					\
> @@ -155,6 +126,9 @@ static const struct attribute_group ads8688_attribute=
_group =3D {
> =C2=A0	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)		\
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE)	\
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.info_mask_shared_by_type_available =3D			\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE)		\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET),	\
> =C2=A0	.scan_index =3D index,					\
> =C2=A0	.scan_type =3D {						\
> =C2=A0		.sign =3D 'u',					\
> @@ -369,11 +343,34 @@ static int ads8688_write_raw_get_fmt(struct iio_dev=
 *indio_dev,
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> +static int ads8688_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *leng=
th,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	struct ads8688_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D (const int *)st->scale_avail;
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		*length =3D ARRAY_SIZE(st->scale_avail) * 2;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*vals =3D ads8688_offset_avail;
> +		*type =3D IIO_VAL_INT;
> +		*length =3D ARRAY_SIZE(ads8688_offset_avail);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> =C2=A0static const struct iio_info ads8688_info =3D {
> =C2=A0	.read_raw =3D &ads8688_read_raw,
> +	.read_avail =3D &ads8688_read_avail,
> =C2=A0	.write_raw =3D &ads8688_write_raw,
> =C2=A0	.write_raw_get_fmt =3D &ads8688_write_raw_get_fmt,
> -	.attrs =3D &ads8688_attribute_group,
> =C2=A0};
> =C2=A0
> =C2=A0static irqreturn_t ads8688_trigger_handler(int irq, void *p)
> @@ -412,7 +409,7 @@ static int ads8688_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct ads8688_state *st;
> =C2=A0	struct iio_dev *indio_dev;
> -	int ret;
> +	int ret, i;

These days you could just declare i in the for() loop and make it
unsigned int.

> =C2=A0
> =C2=A0	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> =C2=A0	if (indio_dev =3D=3D NULL)
> @@ -426,6 +423,12 @@ static int ads8688_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	st->vref_mv =3D ret =3D=3D -ENODEV ? ADS8688_VREF_MV : ret / 1000;
> =C2=A0
> +	for (i =3D 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> +		st->scale_avail[i][0] =3D 0;
> +		st->scale_avail[i][1] =3D ads8688_range_def[i].scale *
> +					st->vref_mv;
> +	}

Even though the above crosses the column preferred limit, I don't think
the line break hurts readability.=20

- Nuno S=C3=A1
>=20
