Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D72D063E;
	Mon, 13 Jul 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908679; cv=none; b=ShBKAQvpGwMbJxFL36VU2+OnWN1+sk4rcA5zUrMMz/YihBDhdw4OL/9gP23MGhEZVTDz+pTVMzgJC/9pCWJR7/ROaer96FQpZT3DtmnKFYofE6fTZmVT/G0vNj3xF4Nq1FOLVdMJAA72kHoH5SBT97FcI4lGk2GpaGxO6fcyi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908679; c=relaxed/simple;
	bh=Y65vyKKPqSwtunyQSND5GNT5eyI+7e3QSBaOXwpAESk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsV8mcF2roB6mbEPd2+W1o1PdaRhXOcLbulkGA6ln+34vrcSqVBO4zcSw0G9Rcc8/1IHSYA0ov4+pn/FSQD520Lqki/GuQa2HWFA6+cYzrDLPB4Cc/KHrZ4tmyeZK+9dhtNXrQj1duUiGm3Og21UjPIXwrLeVOW7ucqC/wfbvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjtMwS5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjtMwS5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AFF1F000E9;
	Mon, 13 Jul 2026 02:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783908678;
	bh=csfg5GWJDpJGK1VZz/p5xspVkMO6iPcKcSEX815Qc8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HjtMwS5Kuk8hVuoASzXb5mEqSCC+XPLTZgkxig/nJr35fsAXN3MMrHmXxIklYGVls
	 FRw4j/EbtXtr6QHTTebs2XgVnBZXiA82wXt3MCvjv6bQGUwo+xQsALi+aVB2Vb6KV7
	 1EfT0LhJhSj7acrZB+YJh2mqtVo0fwH2DaipdwfjslSqjmPNw5zUSdiznfv211Ltyu
	 w/ixcMF3zscRWoZIjx6/mhjf3tIv8oQ377BvQy8KuMT4RqwWfY6imznN0QrM8n7I5U
	 570EkrkR9LTE0aCI3BPb36zU1Lqk2HB7E/hCOcHOZ0EvPlMgEMBGXQU0TMFAigTklS
	 J3v9p8LZFMoAQ==
Date: Mon, 13 Jul 2026 03:11:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] iio: adc: add ti-ads112c14 driver
Message-ID: <20260713031110.55ab2764@jic23-huawei>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-6-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
	<20260710-iio-adc-ti-ads122c14-v3-6-746d52cbf1d0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jul 2026 17:50:39 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.
>=20
> This first step is adding a very basic driver that only supports power
> on/reset and reading the system monitor channels.
>=20
> ADS112C14_SYS_MON_CHANNEL_SHORT is the last channel rather than being in
> logical order by address to keep the voltage channels together and in
> case we find we need to add variants of this channel with different
> voltage reference later.
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>=20
> A few other notes for review that didn't seem worth putting in the
> commit message:
> * I intentionally did not use bulk regmap because later we may need to
>   get the voltage of the avdd supply.
> * I left some comments in the code where the code might look funny (e.g.
>   to reduce future diff) or does not exactly match the datasheet, in
>   which case later changes will address that.
>=20

A couple of really minor comments from a fresh read.

> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c1=
4.c
> new file mode 100644
> index 000000000000..4d2e7d37be82
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads112c14.c

...

> +static int ads112c14_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)

I'd go with a logical split and bring val down a line.
Trivial however. I don't care much!

> +{
> +	struct ads112c14_data *data =3D iio_priv(indio_dev);

> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			/* TS_TC (typical) =3D 405 uV/=C2=B0C */
> +			*val =3D MILLI * vref_uV / 405;
> +			*val2 =3D fsr_bits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +
> +		*val =3D vref_uV / (MICRO / MILLI);
> +		/*
> +		 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to be
> +		 * multiplied by 8 to account for internal attenuation of / 8.
> +		 */

I'd be tempted to make it an explicit match on those 3 channels.  A greater=
 than
when other channels might turn up later for whatever reason seems flaky.

> +		*val2 =3D fsr_bits - (chan->address >=3D 3 ? 3 : 0);
> +		return IIO_VAL_FRACTIONAL_LOG2;

...

> +
> +static int ads112c14_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	const struct ads112c14_chip_info *info;

...
> +	/* Write magic reset value (0x16) to ensure known state. */
> +	ret =3D regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   FIELD_PREP(ADS112C14_CONVERSION_CTRL_RESET, 0x16));
> +	/*
> +	 * The reset may cause an -EREMOTEIO error because of failing to get the
> +	 * I2C ACK at the end of the message. The device still gets reset so it
> +	 * is safe to ignore this error.

Feels like a place where we might not always get the same error as it's sur=
facing
from each individual i2c controller.

I couldn't immediately spot anything in regmap or i2c function docs about t=
his.
Where is that guarantee coming from?  In other cases we've simply not
checked regmap_write() return values at all.

> +	 */
> +	if (ret =3D=3D -EREMOTEIO)
> +		ret =3D 0;
> +	if (ret)
> +		return ret;
> +
> +	fsleep(ADS112C14_DELAY_RESET_US);

...


> +	ret =3D regmap_read(data->regmap, ADS112C14_REG_DEVICE_ID, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(ADS112C14_DEVICE_ID_BITS, reg_val) !=3D info->device_id)
> +		dev_info(dev, "device ID mismatch, expected 0xX%X, got 0x%lX\n",
0xX%X?  (sashiko)

> +			 info->device_id,
> +			 FIELD_GET(ADS112C14_DEVICE_ID_BITS, reg_val));
> +
> +	/* Place in single-shot conversion mode to make ready for raw read. */
Writing a bit called conv mode puts it in single-shot?  (sashiko)=20

> +	ret =3D regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +			      ADS112C14_DEVICE_CFG_CONV_MODE);

Thanks,

Jonathan


