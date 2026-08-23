Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8825B0AB;
	Sun, 23 Aug 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512589; cv=none; b=S/ixwIxWhk12FOGvzZ5TvundXqDbGsT94pinsHtbTcG6ZX1oGRokDQRzy9hfdRWLTv/fDJM+7UMk4l7vknoPfvdxZ9pZ+FG0F/vGMeVvPFAx4+f82HRbA/G5LmaVbB9GJoF2LwXNe2FntXDgSrhOOvZsTrr6/mjKRj3eKT11jC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512589; c=relaxed/simple;
	bh=HitVmPDdsG8UY8dfdtG5maTrCWeDlV78E6z6wm3gml4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcaYSmN2DcgI29Wlgf16yzHaThtBZLI+CjnmJf4/jY/Sb5OVnMR/w/wIqKk8pcCAD7FN7yswKZM3SSOduCXAEyqD1cQt5vi/I341H6hl7fac0P+SIwbgLs+YvD7PbqnvJfWH2AjIwySkmh/0DV+kAo1MtLdX+1buujSWWj+ldJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHwBFmCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHwBFmCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964361F000E9;
	Sun, 23 Aug 2026 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787512587;
	bh=E5OUqh1+qSm9rJFRVmbzMVKh0abe5gVrA2unU77qjZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CHwBFmCDyd1yLTTN86SICwxu0sGx8e0X78LqGIuZTu7yCEm7/oBQIe+Z1p3IkQGBZ
	 5mduwSxdWVTwuy8JmIMoMF2zgcaSiWzjL2KptE6BMx0ykG7TNle2iNc1wg6IkJXBBt
	 YVNySNQzCH/IseCebjaxNBp/GI+6yIg1IHqAkyD0Q7sf5Hh6QbPk3r+ROti2BX/0HV
	 6NCMc6qLmk6F7gFn3+nhBs2fNfFmtfvQYqgGga1A2lTyyot79iq1nhr3+EJMiq/4HK
	 0QcTWDLng4zQpe2MaWk1P+KymPHxn4W+SAPsGmnGNmau6uFPLIqwb5BUGzACDxHGRq
	 3UNXCnY2hxc+g==
Date: Sun, 23 Aug 2026 20:16:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 05/14] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <20260823201622.79ab691b@jic23-huawei>
In-Reply-To: <20260821-ad7768-driver-v4-5-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
	<20260821-ad7768-driver-v4-5-bb8fbd06d4eb@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 16:06:58 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

One trivial thing from me. In general this is coming together nicely.


> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> new file mode 100644
> index 000000000000..34233ad6cfca
> --- /dev/null
> +++ b/drivers/iio/adc/ad7768.c

> +static int ad7768_reset(struct ad7768_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct reset_control *reset_ctrl;
> +	unsigned long reset_low_us;
> +	unsigned long mclk;
> +	int ret;
> +
> +	reset_ctrl = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset_ctrl))
> +		return PTR_ERR(reset_ctrl);
> +
> +	if (reset_ctrl) {
> +		mclk = clk_get_rate(st->mclk);
> +		if (!mclk)
> +			return -EINVAL;
> +
> +		/*
> +		 * Minimum RESET low pulse width: 2 x tMCLK
> +		 * (datasheet Table 1).
> +		 */
> +		reset_low_us = DIV_ROUND_UP_ULL(2ULL * USEC_PER_SEC, mclk);
> +
> +		ret = reset_control_assert(reset_ctrl);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(max_t(unsigned long, 1, reset_low_us));

David covered this I think.  We should very rarely see the _t
variants in use in modern code.

> +
> +		ret = reset_control_deassert(reset_ctrl);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
> +				   AD7768_DATA_CONTROL_SPI_RESET_1);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
> +				   AD7768_DATA_CONTROL_SPI_RESET_2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* ADC start-up time after reset: 1.66 ms max (datasheet Table 1) */
> +	fsleep(2000);

If it's 1.66 ms why not
	fsleep(1660);
?

> +
> +	return 0;
> +}



