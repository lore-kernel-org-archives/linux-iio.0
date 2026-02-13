Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE029992B
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000943; cv=none; b=Ol2UVAb2pwTcuzDEQ0XmB6a5/eUz59eGWNvp1W+vgxTp5EJSKhu98g2/crCnd9AAtwvbzCgE46W7cqOHGu17JB+ACUfrhRrPRGZLDWnRPEJHaxvnnGcFk0X68HmY4SIwfz2NtQUATCOF7zsV3oqCJyV9Q4Zfp3xImSNidK9TBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000943; c=relaxed/simple;
	bh=+rPJ8IGhcUaqVAqqa35kdQr+IXm7xCvJXMuXTiK4AlM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXQJu32G31cNOO4Z55J8ClDAB9mH4GfeBKkZVZd55TiibDnrI4ILUaR7SYAi4gBTzpeDoynR+67uA6S0eBRDOSvf/H2quQajCya3RauqPAQF9/GuC42cGk3QvjeBH4tDahte1OG3FZONzCQZIYgcEKcgOTwl1WjphpPBP0ZNlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPrZ7G5N; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPrZ7G5N"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4376acce52eso809850f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000939; x=1771605739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H508M25Ra11GxFQpKrqPgpHCnIkk142vasyCERWo7BE=;
        b=RPrZ7G5NhK1p4Xv/dHKNBwnuPcYTWGH7ffDWoJqXnDfj0XyJOMxOqn6dMgAI3ag+MW
         VRqpK9rqeg/cG48YK2WmfmJ9kpddKGXwpRLKLzgWRAo3M1A0Tp3Tv3XOHFxUpYEupJt6
         QLbLHQGmeykBIvMAXNc7YRhzcyNd33MvzuuNc9U4P3CZMmz+Kpq4MIOun58b1VgzLz4/
         ZqZWG6058y6Jq3DJhajzlIYHlrY1TMCxRP3C2Kk+peuJas1IuKOOTWvlb7lMD5/AWbcA
         ItvjO06l8w5tc/qvSNbbwOpkCvfFd+i7ZVDqpYqluH+aD/HIWLBLhsTLpByCpz/YOt3h
         JQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000939; x=1771605739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H508M25Ra11GxFQpKrqPgpHCnIkk142vasyCERWo7BE=;
        b=BzQIiN1Sax/G+C6pM78jDcnsm9HgcsnZVpOEE+mNCO2JzCU+ZE7xPA78k+zHErVNHM
         Z8FhTSWVDPWA3CDiR2lTCJyolAxPgeuaoqCLbR7OE5diqK0v9jaHJf500ZgM5fyAtTuF
         ruHiISwHmSKmYu1sUBpCJgrbAUHGiqI1Vo7soIAF5N/hag7J1Cdifcb/bCPQwZrSdEL/
         lKPXDIDjB9hQiamq56mNzA7VDvYHW8XQnrMI8V7FtRKiZt/8oitEzqZQbKFx95PCpf5n
         sDqrTe9ff46lFGTIXsvEtce2C2oi66/bRVWnUtX3Ecm9J9sNwQv8ah8TSU6lM0+3Ghn2
         +ORA==
X-Forwarded-Encrypted: i=1; AJvYcCV/MkSOlAdJDpGkIG48GW7IV/33oGqDKT8rpcmYhUsEcUNH5jxxomG2/SRH+5dK0mPGAoXe3s5OMro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiDpyXoTFXTFXyJ7Z5Zy+EnM12koA4m5InQM0NV7Tlcsc3dNZ
	QoiVIMMyIcDBfjho0Ttbntlc+VYEue0ad5kEyLQls2TaCy4jgTAT2Xk7
X-Gm-Gg: AZuq6aLGoEtP3w8Wc9mp7D3CbCmdHqo3VrkfPHZqIvzNiZ//4CfPNAVAYfqLYI/50DD
	/WQTFmguJnR6kOyPSmsrCPZgiMh2KWxsfH9hMf6ZkjWZZBzndjXpjnX45h7LVALKnpIx/1UUl3m
	i/a6IcOxTVxS7ReMF053BKXqZQuNS/FBj015JRaJRdlzA/8shkpW8tOK7jAYmVrGXiB3TFwRIW2
	X/JC3tzMpZE06tS4/oH8sLZ5ahNWy9DOSLYC8KWyY0tQQjD9iPD8blSuV2KHyxPjG7VuF1M07K3
	cfnyAFQWNyWAthwMYssRb3rWfhW03wnwBxIhKNGNuXIRW+3sd7rpR3DU1TDsS/aEt2jXLys+sv7
	HZkfSb79BqPENef7YM7DJJxnhPeEtsNi+ZUtlvu34v+8OqwdDXkCEPMlDRVle5K4bsYnNnLe5iZ
	DDVzz74tgs3vBOs86WhbhwIIDbz4Zecsg=
X-Received: by 2002:a05:6000:220d:b0:436:1d80:b663 with SMTP id ffacd0b85a97d-437979279dfmr4772760f8f.58.1771000938666;
        Fri, 13 Feb 2026 08:42:18 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm6910185f8f.0.2026.02.13.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:42:18 -0800 (PST)
Message-ID: <562d21574f46214cbb02433519e4e52b1520a916.camel@gmail.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown	 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Fri, 13 Feb 2026 16:43:01 +0000
In-Reply-To: <20260213144742.16394-6-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
	 <20260213144742.16394-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-13 at 16:47 +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
>=20
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v3:
> =C2=A0 - Use devm_spi_new_ancillary_device() instead of manual
> =C2=A0=C2=A0=C2=A0 spi_new_ancillary_device() + devm_add_action_or_reset(=
)
> =C2=A0 - Remove ad4080_unregister_ancillary() cleanup function
> =C2=A0 - Generalize ancillary device setup with loop instead of
> =C2=A0=C2=A0=C2=A0 hardcoding channel 1
>=20
> =C2=A0drivers/iio/adc/ad4080.c | 248 +++++++++++++++++++++++++++++++-----=
---
> =C2=A01 file changed, 197 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 7cf3b6ed7940..36a265ded80d 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -16,6 +16,7 @@
> =C2=A0#include <linux/mod_devicetable.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mutex.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> @@ -131,6 +132,9 @@
> =C2=A0#define AD4084_CHIP_ID						0x0054
> =C2=A0#define AD4086_CHIP_ID						0x0056
> =C2=A0#define AD4087_CHIP_ID						0x0057
> +#define AD4880_CHIP_ID						0x0750
> +
> +#define AD4080_MAX_CHANNELS					2
> =C2=A0
> =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> =C2=A0
> @@ -176,8 +180,9 @@ struct ad4080_chip_info {
> =C2=A0};
> =C2=A0
> =C2=A0struct ad4080_state {
> -	struct regmap			*regmap;
> -	struct iio_backend		*back;
> +	struct spi_device		*spi[AD4080_MAX_CHANNELS];
> +	struct regmap			*regmap[AD4080_MAX_CHANNELS];
> +	struct iio_backend		*back[AD4080_MAX_CHANNELS];
> =C2=A0	const struct ad4080_chip_info	*info;
> =C2=A0	/*
> =C2=A0	 * Synchronize access to members the of driver state, and ensure
> @@ -203,10 +208,11 @@ static int ad4080_reg_access(struct iio_dev *indio_=
dev, unsigned int reg,
> =C2=A0{
> =C2=A0	struct ad4080_state *st =3D iio_priv(indio_dev);
> =C2=A0
> +	/* Use channel 0 regmap for debugfs access */
> =C2=A0	if (readval)
> -		return regmap_read(st->regmap, reg, readval);
> +		return regmap_read(st->regmap[0], reg, readval);
> =C2=A0
> -	return regmap_write(st->regmap, reg, writeval);
> +	return regmap_write(st->regmap[0], reg, writeval);
> =C2=A0}
> =C2=A0
> =C2=A0static int ad4080_get_scale(struct ad4080_state *st, int *val, int =
*val2)
> @@ -227,8 +233,9 @@ static unsigned int ad4080_get_dec_rate(struct iio_de=
v *dev,
> =C2=A0	struct ad4080_state *st =3D iio_priv(dev);
> =C2=A0	int ret;
> =C2=A0	unsigned int data;
> +	unsigned int ch =3D chan->channel;
> =C2=A0
> -	ret =3D regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	ret =3D regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -240,13 +247,14 @@ static int ad4080_set_dec_rate(struct iio_dev *dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mode)
> =C2=A0{
> =C2=A0	struct ad4080_state *st =3D iio_priv(dev);
> +	unsigned int ch =3D chan->channel;
> =C2=A0
> =C2=A0	guard(mutex)(&st->lock);
> =C2=A0
> =C2=A0	if ((st->filter_type >=3D SINC_5 && mode >=3D 512) || mode < 2)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	return regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +	return regmap_update_bits(st->regmap[ch], AD4080_REG_FILTER_CONFIG,
> =C2=A0				=C2=A0 AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> =C2=A0				=C2=A0 FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 (ilog2(mode) - 1)));
> @@ -304,23 +312,23 @@ static int ad4080_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +static int ad4080_lvds_sync_write(struct ad4080_state *st, unsigned int =
ch)
> =C2=A0{
> -	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct device *dev =3D regmap_get_device(st->regmap[ch]);
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +	ret =3D regmap_set_bits(st->regmap[ch], AD4080_REG_ADC_DATA_INTF_CONFIG=
_A,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_ADC_DATA_INTF_CONFIG_A_INT=
F_CHK_EN);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D iio_backend_interface_data_align(st->back, 10000);
> +	ret =3D iio_backend_interface_data_align(st->back[ch], 10000);
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Data alignment process failed\n");
> =C2=A0
> =C2=A0	dev_dbg(dev, "Success: Pattern correct and Locked!\n");
> -	return regmap_clear_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +	return regmap_clear_bits(st->regmap[ch], AD4080_REG_ADC_DATA_INTF_CONFI=
G_A,
> =C2=A0				 AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN);
> =C2=A0}
> =C2=A0
> @@ -329,9 +337,10 @@ static int ad4080_get_filter_type(struct iio_dev *de=
v,
> =C2=A0{
> =C2=A0	struct ad4080_state *st =3D iio_priv(dev);
> =C2=A0	unsigned int data;
> +	unsigned int ch =3D chan->channel;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	ret =3D regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -343,6 +352,7 @@ static int ad4080_set_filter_type(struct iio_dev *dev=
,
> =C2=A0				=C2=A0 unsigned int mode)
> =C2=A0{
> =C2=A0	struct ad4080_state *st =3D iio_priv(dev);
> +	unsigned int ch =3D chan->channel;
> =C2=A0	int dec_rate;
> =C2=A0	int ret;
> =C2=A0
> @@ -355,11 +365,11 @@ static int ad4080_set_filter_type(struct iio_dev *d=
ev,
> =C2=A0	if (mode >=3D SINC_5 && dec_rate >=3D 512)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	ret =3D iio_backend_filter_type_set(st->back, mode);
> +	ret =3D iio_backend_filter_type_set(st->back[ch], mode);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +	ret =3D regmap_update_bits(st->regmap[ch], AD4080_REG_FILTER_CONFIG,
> =C2=A0				 AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> =C2=A0				 FIELD_PREP(AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> =C2=A0					=C2=A0=C2=A0=C2=A0 mode));
> @@ -399,6 +409,29 @@ static int ad4080_read_avail(struct iio_dev *indio_d=
ev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int ad4880_update_scan_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 const unsigned long *scan_mask)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	unsigned int ch;
> +	int ret;
> +
> +	for (ch =3D 0; ch < st->info->num_channels; ch++) {
> +		/*
> +		 * Each backend has a single channel (channel 0 from the
> +		 * backend's perspective), so always use channel index 0.
> +		 */
> +		if (test_bit(ch, scan_mask))
> +			ret =3D iio_backend_chan_enable(st->back[ch], 0);
> +		else
> +			ret =3D iio_backend_chan_disable(st->back[ch], 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0static const struct iio_info ad4080_iio_info =3D {
> =C2=A0	.debugfs_reg_access =3D ad4080_reg_access,
> =C2=A0	.read_raw =3D ad4080_read_raw,
> @@ -406,6 +439,19 @@ static const struct iio_info ad4080_iio_info =3D {
> =C2=A0	.read_avail =3D ad4080_read_avail,
> =C2=A0};
> =C2=A0
> +/*
> + * AD4880 needs update_scan_mode to enable/disable individual backend ch=
annels.
> + * Single-channel devices don't need this as their backends may not impl=
ement
> + * chan_enable/chan_disable operations.
> + */
> +static const struct iio_info ad4880_iio_info =3D {
> +	.debugfs_reg_access =3D ad4080_reg_access,
> +	.read_raw =3D ad4080_read_raw,
> +	.write_raw =3D ad4080_write_raw,
> +	.read_avail =3D ad4080_read_avail,
> +	.update_scan_mode =3D ad4880_update_scan_mode,
> +};
> +
> =C2=A0static const struct iio_enum ad4080_filter_type_enum =3D {
> =C2=A0	.items =3D ad4080_filter_type_iio_enum,
> =C2=A0	.num_items =3D ARRAY_SIZE(ad4080_filter_type_iio_enum),
> @@ -420,17 +466,51 @@ static struct iio_chan_spec_ext_info ad4080_ext_inf=
o[] =3D {
> =C2=A0	{ }
> =C2=A0};
> =C2=A0
> -#define AD4080_CHANNEL_DEFINE(bits, storage) {				\
> +/*
> + * AD4880 needs per-channel filter configuration since each channel has
> + * its own independent ADC with separate SPI interface.
> + */
> +static struct iio_chan_spec_ext_info ad4880_ext_info[] =3D {
> +	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4080_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE,
> +			=C2=A0=C2=A0 &ad4080_filter_type_enum),
> +	{ }
> +};
> +
> +#define AD4080_CHANNEL_DEFINE(bits, storage, idx) {			\
> =C2=A0	.type =3D IIO_VOLTAGE,						\
> =C2=A0	.indexed =3D 1,							\
> -	.channel =3D 0,							\
> +	.channel =3D (idx),						\
> =C2=A0	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),			\
> =C2=A0	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> =C2=A0			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> =C2=A0	.info_mask_shared_by_all_available =3D				\
> =C2=A0			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> =C2=A0	.ext_info =3D ad4080_ext_info,					\
> -	.scan_index =3D 0,						\
> +	.scan_index =3D (idx),						\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D (bits),					\
> +		.storagebits =3D (storage),				\
> +	},								\
> +}
> +
> +/*
> + * AD4880 has per-channel attributes (filter_type, oversampling_ratio,
> + * sampling_frequency) since each channel has its own independent ADC
> + * with separate SPI configuration interface.
> + */
> +#define AD4880_CHANNEL_DEFINE(bits, storage, idx) {		\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D (idx),						\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE) |		\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_separate_available =3D					\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.ext_info =3D ad4880_ext_info,				\
> +	.scan_index =3D (idx),						\
> =C2=A0	.scan_type =3D {							\
> =C2=A0		.sign =3D 's',						\
> =C2=A0		.realbits =3D (bits),					\
> @@ -438,17 +518,22 @@ static struct iio_chan_spec_ext_info ad4080_ext_inf=
o[] =3D {
> =C2=A0	},								\
> =C2=A0}
> =C2=A0
> -static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL_DEFI=
NE(20, 32);
> +static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL_DEFI=
NE(20, 32, 0);
> =C2=A0
> -static const struct iio_chan_spec ad4081_channel =3D AD4080_CHANNEL_DEFI=
NE(20, 32);
> +static const struct iio_chan_spec ad4081_channel =3D AD4080_CHANNEL_DEFI=
NE(20, 32, 0);
> =C2=A0
> -static const struct iio_chan_spec ad4083_channel =3D AD4080_CHANNEL_DEFI=
NE(16, 16);
> +static const struct iio_chan_spec ad4083_channel =3D AD4080_CHANNEL_DEFI=
NE(16, 16, 0);
> =C2=A0
> -static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL_DEFI=
NE(16, 16);
> +static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL_DEFI=
NE(16, 16, 0);
> =C2=A0
> -static const struct iio_chan_spec ad4086_channel =3D AD4080_CHANNEL_DEFI=
NE(14, 16);
> +static const struct iio_chan_spec ad4086_channel =3D AD4080_CHANNEL_DEFI=
NE(14, 16, 0);
> =C2=A0
> -static const struct iio_chan_spec ad4087_channel =3D AD4080_CHANNEL_DEFI=
NE(14, 16);
> +static const struct iio_chan_spec ad4087_channel =3D AD4080_CHANNEL_DEFI=
NE(14, 16, 0);
> +
> +static const struct iio_chan_spec ad4880_channels[] =3D {
> +	AD4880_CHANNEL_DEFINE(20, 32, 0),
> +	AD4880_CHANNEL_DEFINE(20, 32, 1),
> +};
> =C2=A0
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> =C2=A0	.name =3D "ad4080",
> @@ -510,25 +595,34 @@ static const struct ad4080_chip_info ad4087_chip_in=
fo =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D 1,
> =C2=A0};
> =C2=A0
> -static int ad4080_setup(struct iio_dev *indio_dev)
> +static const struct ad4080_chip_info ad4880_chip_info =3D {
> +	.name =3D "ad4880",
> +	.product_id =3D AD4880_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 2,
> +	.channels =3D ad4880_channels,
> +	.lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
> +};
> +
> +static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch=
)
> =C2=A0{
> -	struct ad4080_state *st =3D iio_priv(indio_dev);
> -	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct device *dev =3D regmap_get_device(st->regmap[ch]);
> =C2=A0	__le16 id_le;
> =C2=A0	u16 id;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +	ret =3D regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
> =C2=A0			=C2=A0=C2=A0 AD4080_INTERFACE_CONFIG_A_SW_RESET);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +	ret =3D regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
> =C2=A0			=C2=A0=C2=A0 AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id_le,
> +	ret =3D regmap_bulk_read(st->regmap[ch], AD4080_REG_PRODUCT_ID_L, &id_l=
e,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(id_le));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> @@ -537,18 +631,18 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0	if (id !=3D st->info->product_id)
> =C2=A0		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> =C2=A0
> -	ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> +	ret =3D regmap_set_bits(st->regmap[ch], AD4080_REG_GPIO_CONFIG_A,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_GPIO_CONFIG_A_GPO_1_EN);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> +	ret =3D regmap_write(st->regmap[ch], AD4080_REG_GPIO_CONFIG_B,
> =C2=A0			=C2=A0=C2=A0 FIELD_PREP(AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_GPIO_CONFIG_B_GPIO_FILTER=
_RES_RDY));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	ret =3D iio_backend_num_lanes_set(st->back[ch], st->num_lanes);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -556,7 +650,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	/* Set maximum LVDS Data Transfer Latency */
> -	ret =3D regmap_update_bits(st->regmap,
> +	ret =3D regmap_update_bits(st->regmap[ch],
> =C2=A0				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> =C2=A0				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> =C2=A0				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> @@ -565,24 +659,39 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	if (st->num_lanes > 1) {
> -		ret =3D regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +		ret =3D regmap_set_bits(st->regmap[ch], AD4080_REG_ADC_DATA_INTF_CONFI=
G_A,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_ADC_DATA_INTF_CONFIG_A_SP=
I_LVDS_LANES);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> -	ret =3D regmap_set_bits(st->regmap,
> +	ret =3D regmap_set_bits(st->regmap[ch],
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_REG_ADC_DATA_INTF_CONFIG_B=
,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_ADC_DATA_INTF_CONFIG_B_LVD=
S_CNV_EN);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	return ad4080_lvds_sync_write(st);
> +	return ad4080_lvds_sync_write(st, ch);
> +}
> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	unsigned int ch;
> +	int ret;
> +
> +	for (ch =3D 0; ch < st->info->num_channels; ch++) {
> +		ret =3D ad4080_setup_channel(st, ch);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad4080_properties_parse(struct ad4080_state *st)
> =C2=A0{
> -	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct device *dev =3D regmap_get_device(st->regmap[0]);
> =C2=A0
> =C2=A0	st->lvds_cnv_en =3D device_property_read_bool(dev, "adi,lvds-cnv-e=
nable");
> =C2=A0
> @@ -602,6 +711,7 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0	struct device *dev =3D &spi->dev;
> =C2=A0	struct ad4080_state *st;
> =C2=A0	struct clk *clk;
> +	unsigned int ch;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -610,6 +720,10 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	st =3D iio_priv(indio_dev);
> =C2=A0
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> =C2=A0	ret =3D devm_regulator_bulk_get_enable(dev,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(ad4080_power_supplies),
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 ad4080_power_supplies);
> @@ -617,13 +731,34 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0		return dev_err_probe(dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable supplies\n")=
;
> =C2=A0
> -	st->regmap =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> -	if (IS_ERR(st->regmap))
> -		return PTR_ERR(st->regmap);
> +	/* Setup primary SPI device (channel 0) */
> +	st->spi[0] =3D spi;
> +	st->regmap[0] =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> +	if (IS_ERR(st->regmap[0]))
> +		return PTR_ERR(st->regmap[0]);
> =C2=A0
> -	st->info =3D spi_get_device_match_data(spi);
> -	if (!st->info)
> -		return -ENODEV;
> +	/* Setup ancillary SPI devices for additional channels */
> +	if (st->info->num_channels > 1) {
> +		u32 reg[AD4080_MAX_CHANNELS];
> +
> +		ret =3D device_property_read_u32_array(dev, "reg", reg,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 st->info->num_channels);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "missing reg entries for multi-channel dev=
ice\n");
> +
> +		for (int i =3D 1; i < st->info->num_channels; i++) {
> +			st->spi[i] =3D devm_spi_new_ancillary_device(spi, reg[i]);
> +			if (IS_ERR(st->spi[i]))
> +				return dev_err_probe(dev, PTR_ERR(st->spi[i]),
> +						=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register ancillary device\n");
> +
> +			st->regmap[i] =3D devm_regmap_init_spi(st->spi[i],
> +							=C2=A0=C2=A0=C2=A0=C2=A0 &ad4080_regmap_config);
> +			if (IS_ERR(st->regmap[i]))
> +				return PTR_ERR(st->regmap[i]);
> +		}
> +	}
> =C2=A0
> =C2=A0	ret =3D devm_mutex_init(dev, &st->lock);
> =C2=A0	if (ret)
> @@ -632,7 +767,8 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0	indio_dev->name =3D st->info->name;
> =C2=A0	indio_dev->channels =3D st->info->channels;
> =C2=A0	indio_dev->num_channels =3D st->info->num_channels;
> -	indio_dev->info =3D &ad4080_iio_info;
> +	indio_dev->info =3D st->info->num_channels > 1 ?
> +			=C2=A0 &ad4880_iio_info : &ad4080_iio_info;
> =C2=A0
> =C2=A0	ret =3D ad4080_properties_parse(st);
> =C2=A0	if (ret)
> @@ -644,15 +780,23 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	st->clk_rate =3D clk_get_rate(clk);
> =C2=A0
> -	st->back =3D devm_iio_backend_get(dev, NULL);
> -	if (IS_ERR(st->back))
> -		return PTR_ERR(st->back);
> +	/* Get backends for all channels */
> +	for (ch =3D 0; ch < st->info->num_channels; ch++) {
> +		st->back[ch] =3D devm_iio_backend_get_by_index(dev, ch);
> +		if (IS_ERR(st->back[ch]))
> +			return PTR_ERR(st->back[ch]);
> =C2=A0
> -	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> -	if (ret)
> -		return ret;
> +		ret =3D devm_iio_backend_enable(dev, st->back[ch]);
> +		if (ret)
> +			return ret;
> +	}
> =C2=A0
> -	ret =3D devm_iio_backend_enable(dev, st->back);
> +	/*
> +	 * Request buffer from the first backend only. For multi-channel
> +	 * devices (e.g., AD4880), all backends share a single IIO buffer
> +	 * as data from all ADC channels is interleaved into one stream.
> +	 */
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -670,6 +814,7 @@ static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
> =C2=A0	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
> =C2=A0	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
> +	{ "ad4880", (kernel_ulong_t)&ad4880_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(spi, ad4080_id);
> @@ -681,6 +826,7 @@ static const struct of_device_id ad4080_of_match[] =
=3D {
> =C2=A0	{ .compatible =3D "adi,ad4084", &ad4084_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4086", &ad4086_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4087", &ad4087_chip_info },
> +	{ .compatible =3D "adi,ad4880", &ad4880_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, ad4080_of_match);
