Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC0313267;
	Sun, 23 Aug 2026 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513136; cv=none; b=mo+T00Af6/sb/hRjcPW8IwS7mKMUKNYt+MQ+o/BGWBKzDEJdErgNvhln8j3YDH0ia+m80QL6DtOpcLjBP1yPFUYUWxDkbq8G316kbNWvBmnYKMVr4eOeAkOjdV2gGGk8HMIbm1gsGZoWersIUOfTqXPf1xO8YqSYwy9viTXDVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513136; c=relaxed/simple;
	bh=u7U4CAhCSXaMrVki6po0VO+G7qnMnr5lcvy2xyJhbTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFWaN8to2rPswVbEcZyY2VopPS6ngisfW/Vq+R98lWOkmfrnJWDf+N5NcUyTyHbIAm206bTOLfvnhRckQ28uGlQb5bGIBRlv6Sv3KjUq3Q5n1YBx9Ez4E5nlxLgc0QRnfKAaTt1n+jphPmP6+8pxo26nCLGja09cb4CnIAFv3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxyOi3GY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxyOi3GY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396DB1F000E9;
	Sun, 23 Aug 2026 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787513134;
	bh=j29QskVYdEiLxu4ve4piAcLrA6al4W9RQUnAtxaMrVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YxyOi3GYYqAUbll+k7OEV72OYqp0s7m5YK/napBESyfK+TmmuZzlap6bWrWIesI1b
	 +laQHDZ4LeFmkDHydGnwwUlrFXcq8Vk7vClUPmusmdTRbEkpA7ErwWCSnCgUCVASaa
	 88x+2v4ve9l8wT6itDYwXyPuN6jpnINuU7a7NbrdI19lU0gp9shB75OjF46PyHCO2N
	 OxrHU67Rs5yV00IVKVuAC807f9mkZhVyxiOw6Ro5T4sXsgDoZRLsPSWLCVJDL3HHnh
	 75Szuq4saQ6jIG+EZCohKVXs8OGHwdV7zr3NLR48zmDWWR7Xxd404/dr9aO9WprfRQ
	 31Fu2lvkqIDEQ==
Date: Sun, 23 Aug 2026 20:25:27 +0100
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
Subject: Re: [PATCH v4 06/14] iio: adc: ad7768: Add configurable sampling
 modes
Message-ID: <20260823202527.29881ee4@jic23-huawei>
In-Reply-To: <20260821-ad7768-driver-v4-6-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
	<20260821-ad7768-driver-v4-6-bb8fbd06d4eb@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 16:06:59 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Derive the available output data rates from MCLK and expose per-channel
> sampling frequency and filter controls.
> 
> Select the fastest compatible power mode for the enabled channels and
> map matching sampling frequency and filter combinations onto the two
> hardware channel profiles. Configure the data clock divider and wait for
> the selected filters to settle before capture.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
More minor stuff.

J
> ---
>  drivers/iio/adc/ad7768.c | 580 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 543 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> index 34233ad6cfca..08d8e97d58fc 100644
> --- a/drivers/iio/adc/ad7768.c
> +++ b/drivers/iio/adc/ad7768.c

> +static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES];
> +	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES];
> +	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	unsigned int channel_mask;
>  	unsigned int standby_mask;
> +	unsigned int max_freq = 0;
> +	struct device *dev;
> +	unsigned int c;
>  	int ret;
>  
> +	guard(mutex)(&st->lock);
> +	dev = regmap_get_device(st->regmap);

I can't see why this needs to be under the lock.  I'd just do
it at declaration above.

> +


> +
> +static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SEPARATE,
> +		 &ad7768_filter_types_enum),

	IIO_ENUM("filter_type", IIO_SEPARATE, &ad7768_filter_types_enum),
	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ad7768_filter_types_enum),

First line easily fits and second is only just over 80 chars. So i'd
do one line for each.


> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE,
> +			   &ad7768_filter_types_enum),
> +	{ }
> +};

