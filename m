Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAE384CCD;
	Sun,  6 Sep 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729892; cv=none; b=T9DsZngZ7DTx1CTvY32yNbSVBciPERWrwd3Lzj5/Y2r18LevivT9dFZW6Ora47uweO/quy3IP+bvf2qwonHsFhghqllMfZ4MEcWgFshn41MocvzH/6SMfMV3/5/J3JasfwY9Lj8NH4XF2mw2JZOwnPhchy7zDSqHMaaI8AVtlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729892; c=relaxed/simple;
	bh=ucpI8OMiOzTZK+SSKnb87ITojx70BzKowCD0X1TD668=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYEJw3uDSTf/A1Km/CB4CLrqfwMhY1bSYSCISYcF98gBpKcP8NtjbOwyo1b5QmC4UleBbGAJxABJ4je3eygp5co0ig92lMRWzI/nFLqaXaVfgwrVjw78y/yty39x7SPVdsCMEXG3rWEQQ3quu27M35PfUdoWqSepsfFQMwZK8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrEBvDhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrEBvDhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4EA1F00A3A;
	Sun,  6 Sep 2026 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788729891;
	bh=yI1ISZStHsI8HeOW6HBXC0E/onU4SL9A5+VALs2VukY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WrEBvDhqAxQXIPMonisjvp9LZh06k99gCdM8iXfvMH2ZZ5WTy3HVQIrp0lhjIlwrl
	 pLMzNLBdXNUFKSx5iE2vCf0l4rWbq9XV7b0MuzsylG8Ah+G8UkfHtRLXAKDbvonzHr
	 MaWT7ytX3uBeb1v2BnFD07xWtwxeJQPyqyaJQL+auRoTtsM9KbxkcU62KduldCAqKI
	 wQrq9qMqHvuUCzI+Ntz+tSJS3kYB8SYnyxAncENKbtqUyEm4ldxdkGgY8JVc4IANYF
	 jQH/WhqSPjF95KFUQ+102qfSK4TkEcgxIbp0eJJ42ot5/u1Af+ea3DmozWl5oe4Su6
	 EV9ZP1Dng9LJA==
Date: Sun, 6 Sep 2026 22:24:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mark Brown
 <broonie@kernel.org>, Marius Cristea <marius.cristea@microchip.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260906222442.01ff098d@jic23-huawei>
In-Reply-To: <apgdEf3pi_soGr3T@ashevche-desk.local>
References: <20260902-ad5529r-driver-v11-0-301c491a0719@analog.com>
	<20260902-ad5529r-driver-v11-3-301c491a0719@analog.com>
	<apgdEf3pi_soGr3T@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 15:56:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 02, 2026 at 11:26:17AM +0200, Janani Sunil wrote:
> > Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> > from Analog Devices.
> > 
> > The device communicates over SPI and supports per-channel output range
> > configuration. An optional external 4.096V reference can be used in
> > place of the internal reference.  
> 
> Since there might be a v12 (depends on Jonathan), a few more nit-picks.
> 
> ...
> 
> > +static const s32 ad5529r_output_ranges_mV[8][2] = {
> > +	[AD5529R_RANGE_0V_5V] = { 0, 5000 },
> > +	[AD5529R_RANGE_0V_10V] = { 0, 10000 },
> > +	[AD5529R_RANGE_0V_20V] = { 0, 20000 },
> > +	[AD5529R_RANGE_0V_40V] = { 0, 40000 },
> > +	[AD5529R_RANGE_M5V_5V] = { -5000, 5000 },
> > +	[AD5529R_RANGE_M10V_10V] = { -10000, 10000 },
> > +	[AD5529R_RANGE_M15V_15V] = { -15000, 15000 },
> > +	[AD5529R_RANGE_M20V_20V] = { -20000, 20000 },
> > +};  
> 
> Perhaps use MILLI multiplier?
I tried this and it looks pretty ugly so didn't adopt this one.
If it were many more zeros I'd agree.

> 
> ...
> 
> > +static int ad5529r_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct ad5529r_state *st = iio_priv(indio_dev);
> > +	unsigned int reg_addr, reg_val_h;
> > +	int ret, range_idx, span_mV;  
> 
> Why is 'range_idx' signed?

Why isn't it the enum like where it is coming from?
I changed it to the enum.

diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
index bc11d7671a76..8154b87ff831 100644
--- a/drivers/iio/dac/ad5529r.c
+++ b/drivers/iio/dac/ad5529r.c
@@ -228,8 +228,9 @@ static int ad5529r_read_raw(struct iio_dev *indio_dev,
                            int *val, int *val2, long mask)
 {
        struct ad5529r_state *st = iio_priv(indio_dev);
+       enum ad5529r_output_range range_idx;
        unsigned int reg_addr, reg_val_h;
-       int ret, range_idx, span_mV;
+       int ret, span_mV;
 
        switch (mask) {
        case IIO_CHAN_INFO_RAW:

> 
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		/*
> > +		 * Read from DAC_INPUT_A register rather than DAC_DATA_READBACK.
> > +		 * The DAC operates in transparent mode and directly reflects
> > +		 * whatever value is written to the INPUT_A register.
> > +		 */
> > +		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
> > +		ret = regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = reg_val_h;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		range_idx = st->output_range_idx[chan->channel];
> > +
> > +		/*
> > +		 * The datasheet specifies a 4.096 V external reference,
> > +		 * matching the nominal output voltage of the internal
> > +		 * reference.
> > +		 */
> > +		span_mV = ad5529r_output_ranges_mV[range_idx][1] -
> > +			  ad5529r_output_ranges_mV[range_idx][0];
> > +		*val = span_mV;
> > +		*val2 = st->model_data->resolution;
> > +
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		range_idx = st->output_range_idx[chan->channel];
> > +
> > +		if (ad5529r_output_ranges_mV[range_idx][0] < 0)
> > +			*val = -BIT(st->model_data->resolution - 1);
> > +		else
> > +			*val = 0;
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}  
> 

