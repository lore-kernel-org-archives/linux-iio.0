Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FC376BD5;
	Wed, 20 May 2026 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273124; cv=none; b=MVVfMPV95+oACpY/CGQOZS0VIZqRKSOYat3CSFt8vco19HO2TpccZp3VpOWqQzFxMStx6WkcQIXbYjPk1vHDvBDpi6rxEl5oGzQTcFfxWuiIWAI9lXzxzp9/MbQUmKeGqiJ23x/Gfp9Jz8FETafI1JzrGS9IGN34Po3KNp9rwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273124; c=relaxed/simple;
	bh=T9TIhTNUPgaStMlnjTeuWOoiXFrPd4MLruXe1yjvmC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrs5fSRlPK4ehQOO0ZP06LHSanXX6U6BV9oAXMGjxjXVzoShaHzpEQRbJ4+MDYA4mCyVYs3Li8wD1UDIq7QxygqG/6EWVCYJVSI9NAaSxL4AoUatCzTUX0NfrT9PbA+oDr459ZpNF/7ZVaq9hrynM/+JwyctJazdw6kWDdHFV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpN5SZDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpN5SZDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888E51F00893;
	Wed, 20 May 2026 10:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779273118;
	bh=CnOeghXZiw9NYLC39USA8LXJJwZf4UdJ70R7KKSZyzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VpN5SZDaU/+mKtnVw6qVZAelFiY1ch2Q1uI6b0el3ZgDvwR7eJUatkF0vnHPJrqCv
	 GRQmDnms+IdL6cL/Ki5Wi4B4Z4bvoLK6xgpinnn60XnDYmXlCgD39l5gieh7uq1LlK
	 k6QHYEfxhwQXcfWC/28XWyhjd0J8gXpPj/3IbZwgYFQHmgOUXF5Am0MKtHQe6DkaXS
	 IzuZkRYfCrEa/kLgKRwCFkmPPtOPThOAght8V4+0HS5iGDxBg7gUPcnQr3bU1As6vZ
	 kY2qywIeSE3Dh4O/ZWc9efvysUArucnCdjZqDBjEkFFqI8xArdx8CRI7uCc5N8IZYD
	 x0ytMOJsLA2Vg==
Date: Wed, 20 May 2026 11:31:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <20260520113153.3e663a7c@jic23-huawei>
In-Reply-To: <20260518220228.63322-12-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
	<20260518220228.63322-12-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 03:32:27 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but uses trailing PD_SCK pulses to select the active mode.
>=20
> Model the HX710B with variant-specific channel tables and IIO info,
> track the active channel across conversions, and use the fixed gain
> value when computing scale.
>=20
> Also update the adjacent Kconfig text, file header, and module
> description so the driver text matches the newly supported variant.
>=20
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

The vast majority of sashiko feedback on this version is incorrect
or already something we've ruled out as needing handling.

However, very last point looks valid to me so I've highlighted that.

Otherwise, the main thing is it is better to keep the structure
for the buffer now we don't have variable numbers of channels between
the two devices.  That is the preferred route except when it becomes
misleading (which it did with 2 vs 3 channels).


> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 183568196d52..d5c977b4669b 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c

> =20
>  struct hx711_data {
> @@ -99,16 +105,12 @@ struct hx711_data {
>  	int			gain_set;	/* gain set on device */
>  	int			gain_chan_a;	/* gain for channel A */
>  	int			gain_scale[HX711_GAIN_MAX];
> +	int			channel_set;	/* HX710B active channel */
> +	unsigned int		samp_freq;	/* HX710B differential channel sample rate */
>  	const struct hx711_chip_info	*chip_info;
>  	struct mutex		lock;
> -	/*
> -	 * triggered buffer
> -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> -	 */
> -	struct {
> -		u32 channel[2];
> -		aligned_s64 timestamp;
> -	} buffer;
> +	/* 2x32-bit channels + 64-bit naturally aligned timestamp */
> +	IIO_DECLARE_BUFFER_WITH_TS(u32, buffer, 2);

Now we are back to fixed 2 channels, don't need this change. The structure
is easier to interpret so please go back to that.

>  	/*
>  	 * delay after a rising edge on SCK until the data is ready DOUT
>  	 * this is dependent on the hx711 where the datasheet tells a


> @@ -463,6 +527,50 @@ static const struct iio_info hx711_iio_info =3D {
>  	.attrs			=3D &hx711_attribute_group,
>  };
> =20
> +static const int hx710b_samp_freq_avail[] =3D { 10, 40 };
> +
> +static int hx710b_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals =3D hx710b_samp_freq_avail;
> +		*type =3D IIO_VAL_INT;
> +		*length =3D ARRAY_SIZE(hx710b_samp_freq_avail);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int hx710b_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct hx711_data *hx711_data =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val !=3D 10 && val !=3D 40)
> +			return -EINVAL;
> +		mutex_lock(&hx711_data->lock);
> +		hx711_data->samp_freq =3D val;
> +		hx711_data->channel_set =3D 0;
> +		mutex_unlock(&hx711_data->lock);
=46rom Sahiko:

  Does this implementation need to use iio_device_claim_direct_mode() to
  prevent concurrent hardware changes while a buffered capture is active?
  If userspace modifies the sampling frequency during an active IIO trigger=
ed
  buffer capture, it resets channel_set to 0. This could alter the hardware
  configuration (changing the trailing pulses) out from under the IIO captu=
re
  thread, which violates IIO concurrency semantics.

Two possible fixes:
- The one sashiko suggests around claiming direct mode.
- Maybe not set channel_set =3D 0?  Then it becomes a simple race for
  whether the value of samp_freq is updated or not.  Either is harmless.

I'd be tempted to go with direct mode claiming but also consider if you can
drop that channel_set =3D 0 - or add a comment on why it's there perhaps.


> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info hx710b_iio_info =3D {
> +	.read_raw		=3D hx711_read_raw,
> +	.write_raw		=3D hx710b_write_raw,
> +	.read_avail		=3D hx710b_read_avail,
> +};

>  static const struct hx711_chip_info hx711_chip =3D {
>  	.name		=3D "hx711",
>  	.channels	=3D hx711_chan_spec,
> @@ -502,6 +655,15 @@ static const struct hx711_chip_info hx711_chip =3D {
>  	.num_channels	=3D ARRAY_SIZE(hx711_chan_spec),
>  };

> @@ -608,6 +781,7 @@ static int hx711_probe(struct platform_device *pdev)
>  }
> =20
>  static const struct of_device_id of_hx711_match[] =3D {
> +	{ .compatible =3D "avia,hx710b", .data =3D &hx710b_chip },
>  	{ .compatible =3D "avia,hx711", .data =3D &hx711_chip },
>  	{ }
>  };
> @@ -625,7 +799,7 @@ static struct platform_driver hx711_driver =3D {
>  module_platform_driver(hx711_driver);
> =20
>  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> +MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");

Trivial but switch that to 'and similar' as they aren't quite compatible.
Sometimes vagueness is helpful :)

Anyhow, looking in pretty good shape so hopefully v10 is the lucky version.

If you have time, it would be nice to get rid of the custom available attri=
butes
for the hx711 as well - similar approach to you have done for the new part.


Jonathan


>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:hx711-gpio");
> =20

