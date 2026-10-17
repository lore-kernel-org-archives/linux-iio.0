Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89B339365;
	Sat, 17 Oct 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197836; cv=none; b=Y2FAF+WrgaxSSyo9Xcp8bnREfxsIyYLfE0tbZ7Eyc2DiWMXbls+S3lJ9IHmsAFXvwT+do8sZCAjLnxLA5EBoKjG/YinoetqZtxKxd9rYbxaluWGSWezc1LBH5DQ1erXuRC1H7X/GRROSpnCNEd95XF2hgS/jnOWDZqoBonzIcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197836; c=relaxed/simple;
	bh=S0I3+5/gHuryal2ZZA4WPGSDDxCd97Qm5f8HxhSzM94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egMGv2hhwF8y/FdawWmsCRbRMOjdAutQCl/79AsXif7aT4VH04A4iqexgRV4c2ojFd8O5MoshTD3hgg3/CYg6BdXzRunhfnwKqKN1e9goiD8lrq/hpcqatxXiFvR6dclkpvMH4AdnL6xxVDtM5PlibNSDaiJv4o25XqdbYY70nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3Q8LjxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Q8LjxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5F91F000C4;
	Sat, 17 Oct 2026 00:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792197835;
	bh=iwEEy+hiKMM2tEseS67iZSa0Vv64AiD5OGOhwck5SsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a3Q8LjxBCGy3pICSK/FOBWTB7Q+Y34yxVpmg+zMH9Aww13k0sTOIurmqeNpd5GHFw
	 NMwhHczlbwM3852LK7LooKeDzqtMeqX1LDXGRVLdJGJrgC+RW5xe5t7X0ruCtrljWg
	 llyZDsHiE+wv/FpgwbNtH86uqvapHV290cHKn+sfdVSJY+0WAj49bJrr5emZBIDunN
	 /+jk9nRR9uJdW6MxIHrTqMNStt8fNqpYfTVkYFvFuKczlzFWtsWKZJ/vHFaSiYLJzg
	 H2O6VyCGhKiAS+sPuW1KPZAu9g5bG+Sd+e2nf1yZYsmN1O8PU4ryPv9pEsxpIBfFm2
	 zJLyZKnar003w==
Date: Sat, 17 Oct 2026 01:43:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: HuskerMinion via B4 Relay
 <devnull+mocker-mug-unwoven.duck.com@kernel.org>
Cc: mocker-mug-unwoven@duck.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Arka Mondal <arka@arkamondal.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: tcs3472: Add TCS3400 support
Message-ID: <20261017014348.6dfa8d9a@jic23-hlaptop>
In-Reply-To: <20261016-tcs3400-v1-2-3d79d2a7f449@duck.com>
References: <20261016-tcs3400-v1-0-3d79d2a7f449@duck.com>
	<20261016-tcs3400-v1-2-3d79d2a7f449@duck.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 02:15:42 -0600
HuskerMinion via B4 Relay <devnull+mocker-mug-unwoven.duck.com@kernel.org> wrote:

> From: HuskerMinion <mocker-mug-unwoven@duck.com>
> 
> The AMS TCS3400 is the ambient light sensor of the Amazon Echo Show 8
> (2nd gen). It has the TCS3472 register map (ENABLE at 0x80 up to BDATAH
> at 0x9b, ID at 0x92, STATUS at 0x93 with the same bits), with these
> differences:
> 
> - There is no command type field. Addresses auto-increment on their
>   own, so word registers are read and written at their plain address
>   (CDATA at 0x94, AILT at 0x84). With the TCS3472 auto-increment bit
>   set the driver would address 0xb4 and 0xa4, which are not the data
>   and threshold registers on the TCS3400.
> - Interrupts are cleared by writing AICLEAR (0xe7).
> - The gains are 1x, 4x, 16x and 64x instead of 1x, 4x, 16x and 60x.
> - The ATIME step is 2.78 ms instead of 2.4 ms. The driver uses the
>   same step for WTIME and the RGBC init time, as on the TCS3472.
> - The ID register reads 0x90 (TCS34001, TCS34005) or 0x93 (TCS34003,
>   TCS34007).
> 
> Describe each family in a chip_info structure and pick it from the ID
> register, which the driver already reads to detect the part. The
> TCS3472 behavior does not change. The IIO device is named "tcs3400" on
> a TCS3400.
> 
> Add the "tcs3400" I2C ID and an OF match table with "ams,tcs3400" and
> "ams,tcs3472".
> 
> Tested on the Amazon Echo Show 8 (2nd gen), which has a TCS34003 or
> TCS34007 (ID 0x93) at 0x29: raw reads follow the light, and a hand over
> the sensor takes the clear channel from about 2100 to 35 counts. The
> threshold interrupt was not tested.
> 
> Signed-off-by: HuskerMinion <mocker-mug-unwoven@duck.com>
Hi,

Other than the well known name thing that was already pointed out, a few
comments inline.  Many of them are requests to make minor modernization
changes whilst you are touching this rather old and (recently) unloved driver!

Jonathan

> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index b392943e5..fbd9a1b34 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c

> +static const struct tcs3472_chip_info tcs3472_chip_info = {
> +	.name = "tcs3472",
> +	.calibscale_avail = "1 4 16 60",
> +	.agains = { 1, 4, 16, 60 },
> +	.step_us = 2400,
> +	.auto_incr = true,
> +};
> +
> +static const struct tcs3472_chip_info tcs3400_chip_info = {
> +	.name = "tcs3400",
> +	.calibscale_avail = "1 4 16 64",

Using read_avail() callback is probably just a case of passing it agains.

> +	.agains = { 1, 4, 16, 64 },
> +	.step_us = 2780,
> +	.aiclear = true,
> +};

> @@ -219,19 +267,20 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
>  			iio_device_release_direct(indio_dev);
>  			return ret;
>  		}
> -		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		ret = i2c_smbus_read_word_data(data->client,
> +					       tcs3472_word_reg(data, chan->address));
>  		iio_device_release_direct(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> -		*val = tcs3472_agains[data->control &
> +		*val = data->chip->agains[data->control &
>  			TCS3472_CONTROL_AGAIN_MASK];

Whilst here, just put that on a long line.
I've gotten more relaxed about the 80 char limit and that
is not nice to read at all!


> @@ -628,12 +686,13 @@ static ssize_t tcs3472_show_int_time_available(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> +	struct tcs3472_data *data = iio_priv(dev_to_iio_dev(dev));
>  	size_t len = 0;
>  	int i;
>  
>  	for (i = 1; i <= 256; i++)
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06d ",
> -			2400 * i);
> +			data->chip->step_us * i);
Hmm. It is sort of an ABI change but why is this using the full list of
values when it could be using the [start step end] form of available
attribute.

Maybe we take the risk that anyone notices (I doubt it as generic
code should support either) and jump to that simpler description?

Ideally you'd also use the read_avail() callback rather than
custom attributes.  Nice to modernize that bit whilst you are here.

>  
>  	/* replace trailing space by newline */
>  	buf[len - 1] = '\n';
> @@ -641,11 +700,21 @@ static ssize_t tcs3472_show_int_time_available(struct device *dev,
>  	return len;
>  }

> @@ -706,7 +775,6 @@ static int tcs3472_probe(struct i2c_client *client)
>  		return ret;
>  
>  	indio_dev->info = &tcs3472_info;
> -	indio_dev->name = TCS3472_DRV_NAME;
>  	indio_dev->channels = tcs3472_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(tcs3472_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -715,12 +783,27 @@ static int tcs3472_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret == 0x44)
> +	switch (ret) {
> +	case 0x44:
>  		dev_info(dev, "TCS34721/34725 found\n");
> -	else if (ret == 0x4d)
> +		data->chip = &tcs3472_chip_info;
> +		break;
> +	case 0x4d:
>  		dev_info(dev, "TCS34723/34727 found\n");
> -	else
> +		data->chip = &tcs3472_chip_info;
> +		break;
> +	case 0x90:
> +		dev_info(dev, "TCS34001/34005 found\n");
> +		data->chip = &tcs3400_chip_info;
> +		break;
> +	case 0x93:
> +		dev_info(dev, "TCS34003/34007 found\n");
> +		data->chip = &tcs3400_chip_info;
> +		break;
> +	default:
>  		return -ENODEV;

This is one of those ironic moments. We shouldn't
be rejecting devices based on ID as that breaks fallback compatibles
but in reality these new parts aren't actually compatible but
we pretend they are... I'd add the data to the match table
and if we fail to match use whatever comes from there rather
than this -ENODEV.

> +	}


