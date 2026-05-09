Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB422541C;
	Sat,  9 May 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338688; cv=none; b=QUkvK9NZXPkllUkGyW4CXOMPqkW3irZWVhffvdbZ5uNTtQoN6/Uq4ueWtzXkV8Ry0wLlQgYtIe5N7x0Sj5iGl0kpXResqsOmbNuTr9L1k/SkjsH0pwPhUXG0EIGdTHbeP8IU5ciRcFTaY+7B4Dq2dgRzUt8e21cJDLuzTJY0I5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338688; c=relaxed/simple;
	bh=s0fbS1u+U/mSjyoe2ABwluVmPf3ZrNrdtWsRs2EvDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIiPbrNXfs7PmyD1MozuLpmSZihw0vgky1d4zjdTYfUnZYFQagoZr1pUo45U0B0Khcdz1v3Ab8+roabYEWDPJc7gqnTm5lmUBCbRfhdx/zVuoTv75+10V5NMhc5gGowWzT/N77wLA4uwz5uUA8Bi/z38qLt+/mg9r4n2oKbpoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a477C3iU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a477C3iU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCD3C2BCC9;
	Sat,  9 May 2026 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778338687;
	bh=s0fbS1u+U/mSjyoe2ABwluVmPf3ZrNrdtWsRs2EvDI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a477C3iU7VMb9Q+PxxVctZpyfsT9ZYva2FILxvdGtNZg5z2cUMOPe1WzPt7sq3kHL
	 isjODyBj0Ob4MuLXaYJM7sgqXWdnBpvbZGJw6drwpfCZLX8qLGYiNa0kZEA2v2OwQ9
	 Sp/LkZW71KChOFef6X1XTTwlgZ225bZ2MFgHPvLg8nmf8g4+a9y6slEQyYakdKzjT6
	 xfUvqam7jePRbW/E2VFhUt6uL6P8n4FS/YIn7LFGhSIwAikZmao8lTHwfCkgY09hp+
	 MYzTwcOYXcjfGt3jZStzN8wbFF5Y3Ox2DX9guJD1iMfrHCv4WxfMj73v0yBSDtubPt
	 7A3Pzsyhd/FIw==
Date: Sat, 9 May 2026 15:57:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: dac: ad5504: fix scale via
 output-range-microvolt
Message-ID: <20260509155757.79548c96@jic23-huawei>
In-Reply-To: <20260509142047.30302-6-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
	<20260509142047.30302-6-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 15:20:43 +0100
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> The AD5504 full-scale range is hardware-determined by the R_SEL pin,
> not the VCC supply voltage.
> 
> Fix the scaling logic by reading the standard 'output-range-microvolt'
> property from the device tree instead of querying the VCC regulator or
> relying on legacy platform data (pdata).
> 
> As a result of this transition:
> - The 'vcc' regulator is now only enabled, not read.
> - Legacy pdata support is removed, as it is no longer required for
>   fallback voltage calculations.
> - Strict array bounds checking is added for the DT property.
Hi Taha

These could have been broken up more.  Given this patch isn't suitable
for backporting anyway, you could have done a precursor ripping out
the pdata.

> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>

The datasheet is less clear than it might be but I'm far from
sure that the range is as simple as 0-30 vs 0-60.

See for example the output characteristics in table 2.
That lists Output Voltage Range as AGND + 0.5 to VDD - 0.5V
which is not surprising as VDD can be too low to support the fully
0-60V without any nasty things like step up convertors which
aren't present here. 

Now there is a footnote:
"The DAC architecture gives a fixed linear voltage output range
of 0 V to 30 V if R_SEL is held high and 0 V to 60 V if R_SEL is
held low. As the output voltage range is limited by output
amplifier compliance, VDD should be set to at least 0.5 V higher
than the maximum output voltage to ensure compliance."

So I guess we can 'assume' that footnote is obeyed and indeed
do things as you have here.

One other thing inline.

> ---
>  drivers/iio/dac/ad5504.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 9e95da6e49d6..040f580b8282 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -14,10 +14,12 @@
>  #include <linux/kstrtox.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/dac/ad5504.h>
>  #include <linux/iio/events.h>
> @@ -274,9 +276,9 @@ static const struct iio_chan_spec ad5504_channels[] = {
>  static int ad5504_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> -	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);

Last use of this - remove the header as well.

>  	struct iio_dev *indio_dev;
>  	struct ad5504_state *st;
> +	u32 range[2];
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -285,16 +287,19 @@ static int ad5504_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> -	if (ret < 0 && ret != -ENODEV)
> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret && ret != -ENODEV)
>  		return ret;
> -	if (ret == -ENODEV) {
> -		if (pdata->vref_mv)
> -			st->vref_mv = pdata->vref_mv;
> -		else
> -			dev_warn(dev, "reference voltage unspecified\n");
> -	} else {
> -		st->vref_mv = ret / 1000;
> +
> +	st->vref_mv = 60 * MILLI;
> +	ret = device_property_read_u32_array(dev, "output-range-microvolt",
> +					     range, ARRAY_SIZE(range));
> +	if (!ret) {
> +		if (range[0] != 0 || (range[1] != 30 * MICRO && range[1] != 60 * MICRO))
> +			return -EINVAL;
> +
> +		if (range[1] == 30 * MICRO)
> +			st->vref_mv = 30 * MILLI;
>  	}
>  
>  	st->spi = spi;

