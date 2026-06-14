Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73121255A;
	Sun, 14 Jun 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457748; cv=none; b=R0GUR62Ot6aiX+96Vupx7WYOtv9icHDbbfDhfamcq+UgUAyQtqKuJQTYj/pycWCHrrPRD9xVZDjCmOh3Z/s6+QVSNJNFa9umttvO8VvMYlo9X+H1uUFXzV5JHRrRp+8g8ubsrD2G1ugxSEq1dhrOvSTq84VmyAGtcNYgWgzu8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457748; c=relaxed/simple;
	bh=a4zd/ZD+BFKS9kFX6yBByb9j4eBUlphJuk34BpZfhl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCp8/+5SC1SvKbO6LyIupZIJHwg6sgLkgYkJHdCJWkg0heSzaJwlNdqOn8VwXXuu/J5BAa23oLAUPg+FmavGhUR1y7KhBjIqoCPUoUDspC8xlOQWz1yOO/FWjh2/0b1YEE8Ull+LTxZXwXRvh+RABZSVUdvRFKi6Ezh7fCHr/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzBB+cHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzBB+cHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AAE1F000E9;
	Sun, 14 Jun 2026 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781457746;
	bh=XngdG5RDxiUaPAW60Fbuc3kdXpeCDkI72dsxTko1COA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GzBB+cHP64GVMiPoT4mM6i4Eh+vcwmIBG7hFodSqu0+n1kKpqdLhpmrFIQto1PncE
	 fjNGpZCkQhnCrw7I0RUqtyWxPIMysWxp6gCGqY4FELY6tXuKPW3qtRbePNrzi5Ccf3
	 uhUEDdWyNGIJL23B4jfkPyagAOOTLS/HUVBPDj2mmzFeHn0AF/YHrny7sf1ylJgdp+
	 IxqZ9s2ifyDtNQeDloF/44JfEd89gwOA4m8Ji4Kj855CYqF7aK7zZfLwwTzeBBY4Tf
	 zQpPnD5tiTrxUAxzSdf99ORl/Z5AbCrDZppzoW/vAqPDtk9iW4pzVgzT9fCm7Yt31o
	 RsQfybQ5CNbYg==
Date: Sun, 14 Jun 2026 18:22:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <20260614182214.65d052e4@jic23-huawei>
In-Reply-To: <20260609-mt6323-adc-v2-2-aa93a22309f9@protonmail.com>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
	<20260609-mt6323-adc-v2-2-aa93a22309f9@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 16:31:59 +0300
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
> 
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.
> 
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
Make sure to take a look at:
https://sashiko.dev/#/patchset/20260609-mt6323-adc-v2-0-aa93a22309f9%40protonmail.com

A few minor other comments inline.

> diff --git a/drivers/iio/adc/mt6323-auxadc.c b/drivers/iio/adc/mt6323-auxadc.c
> new file mode 100644
> index 000000000000..f2cef989d3ce
> --- /dev/null
> +++ b/drivers/iio/adc/mt6323-auxadc.c

> +
> +#define MTK_PMIC_IIO_CHAN(_name, _chan, _addr)                  \
> +{                                                               \
> +	.type = IIO_VOLTAGE,                                    \
> +	.indexed = 1,                                           \
> +	.channel = _chan,                                       \
> +	.address = _addr,                                       \
> +	.datasheet_name = __stringify(_name),                   \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> +			      BIT(IIO_CHAN_INFO_SCALE),         \
> +}
> +
> +static const struct iio_chan_spec mt6323_auxadc_channels[] = {
> +	MTK_PMIC_IIO_CHAN(baton2,    MT6323_AUXADC_BATON2,    MT6323_AUXADC_ADC6),
> +	MTK_PMIC_IIO_CHAN(ch6,       MT6323_AUXADC_CH6,       MT6323_AUXADC_ADC11),
> +	MTK_PMIC_IIO_CHAN(bat_temp,  MT6323_AUXADC_BAT_TEMP,  MT6323_AUXADC_ADC5),

Reasonable query from Sashiko on why temperature channels are presented as voltages.
If for some reason that is the right choice, then maybe a comment here.


> +	MTK_PMIC_IIO_CHAN(chip_temp, MT6323_AUXADC_CHIP_TEMP, MT6323_AUXADC_ADC4),
> +	MTK_PMIC_IIO_CHAN(vcdt,      MT6323_AUXADC_VCDT,      MT6323_AUXADC_ADC2),
> +	MTK_PMIC_IIO_CHAN(baton1,    MT6323_AUXADC_BATON1,    MT6323_AUXADC_ADC3),
> +	MTK_PMIC_IIO_CHAN(isense,    MT6323_AUXADC_ISENSE,    MT6323_AUXADC_ADC1),
> +	MTK_PMIC_IIO_CHAN(batsns,    MT6323_AUXADC_BATSNS,    MT6323_AUXADC_ADC0),
> +	MTK_PMIC_IIO_CHAN(accdet,    MT6323_AUXADC_ACCDET,    MT6323_AUXADC_ADC7),
> +};
> +
> +/*
> + * The MediaTek MT6323 (as well as a lot of other PMICs) has the following hierarchy:
> + * PMIC AUXADC <- PMIC MFD <- SoC PWRAP (wrapper for PWRAP FSM)
> + *
> + * Therefore, PWRAP regmap should be obtained using dev->parent->parent.
> + */
> +struct mt6323_auxadc {
> +	struct regmap *regmap;
> +	struct mutex lock;
Locks should always have a comment on what data they are protecting.
I think this one is about protecting the state of a device during a channel read
by serializing those reads.

> +};
>
> +
> +static int mt6323_auxadc_request(struct mt6323_auxadc *auxadc,
> +				 unsigned long channel)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	int ret;
> +
> +	ret = regmap_set_bits(map, MT6323_AUXADC_CON11, AUXADC_CON11_VBUF_EN);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(map, MT6323_AUXADC_CON22, BIT(channel));

I'm not sure whether the sashiko question on this is valid or not. Make sure to take
a look.

https://sashiko.dev/#/patchset/20260609-mt6323-adc-v2-0-aa93a22309f9%40protonmail.com
You may have carefully selected the numbering so the channel numbering matches
the bits in this register.  If so, it is probably worth a comment in the header
to provide a cross reference.  No idea if Sashiko will notice that, but at least
humans should!

> +}
> +

> +
> +static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  int *val, int *val2, long mask)
> +{
> +	struct mt6323_auxadc *auxadc = iio_priv(indio_dev);
> +	int ret, mult;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->channel == MT6323_AUXADC_ISENSE ||
> +		    chan->channel == MT6323_AUXADC_BATSNS)
> +			mult = 4;
> +		else
> +			mult = 1;
> +
> +		/* 1800mV full range with 15-bit resolution. */
> +		*val = mult * 1800;
> +		*val2 = 15;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_RAW:

What Andy suggested here is the preferred path in IIO at least.
Mainly because it reduced indent without hurting readability.
Just be careful to define the scope with { }


> +		scoped_guard(mutex, &auxadc->lock) {
> +			ret = mt6323_auxadc_prepare_channel(auxadc);
> +			if (ret)
> +				return ret;
> +
> +			ret = mt6323_auxadc_request(auxadc, chan->channel);
> +			if (ret)
> +				return ret;
> +
> +			/* Hardware limitation: the AUXADC needs a delay to become ready. */
> +			fsleep(300);
> +
> +			ret = mt6323_auxadc_read(auxadc, chan, val);
> +
> +			if (mt6323_auxadc_release(auxadc, chan->channel))
> +				dev_err(&indio_dev->dev,
> +					"failed to release channel %d\n", chan->channel);
> +
> +			if (ret)
> +				return ret;
> +		}
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

