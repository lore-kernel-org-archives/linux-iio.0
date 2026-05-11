Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03437BE89;
	Mon, 11 May 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521646; cv=none; b=sz/FMkklU2q+lXaSzDgUGTq/rTX6l/iDg0XVVxFsiE/4v+9lV8gyDsK8T09O0Rz8SJC+t/UX00anJcT9AqMsralfM/ca080xj81EwD16b4OD7khUqg/9nlpMVLB1nNpVX37Xn9mGjQXqP/75lyTN+DqLu883fcpeuQ/nFM3FP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521646; c=relaxed/simple;
	bh=QmRYWIMkg1MB8d9jDcohL4aT5ukaVYi60uXAtNhG2cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HstTHEUMl/tPU+tjLWZuZKkzqJs/fSNgNxFo6x1Zw3Gia0t8MBAQoLFiOWuPXzKGTneyyJNx6qOqbnGRrXM3JVvw7Mm8mCW90i9UuRtm3yHZ13jCCQF1Ktl7M0MbdzeIvWx+dSu95zCDa3xQTT8kCEe+taqPRWrqZ9N6lrYSPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om8J1lF2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om8J1lF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE963C2BCB0;
	Mon, 11 May 2026 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521646;
	bh=QmRYWIMkg1MB8d9jDcohL4aT5ukaVYi60uXAtNhG2cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=om8J1lF2QP8ZI05Bk+9cTWhDmaZvl9HN6kUREBpluMzORnMhYSe7cz3VdgZ6F1t5D
	 skeLnwybUhpr11CRWxfVad+aReb4W6YXNaqSwgsxmbNZ2M6ElZyi3bRutb0mK4pxHR
	 aNO1z8xreEexPpm29Zg8NsgIxNDvFtK853rWvgLw6YCQ0pqBEPz1RuYDnCNmzHgp0b
	 EBOakKk1wrozSEtrEwEHrhSs2rDVRTzeLyoRpBogQC4q89f/3KTLggRRSy6LueY4kA
	 4vd0tFabDWnr9b9y2o0UXlRPXL4P/bOG818N74hUA7gnCsfsI3LP1sTOG7tb+qybaL
	 8/wSNyWE2QvfQ==
Date: Mon, 11 May 2026 18:47:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V5 04/11] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <20260511184715.241be1f1@jic23-huawei>
In-Reply-To: <20260509191907.24734-5-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
	<20260509191907.24734-5-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 14:18:58 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add I2C and SPI driver support for InvenSense ICM-42607 devices.
> Add necessary Kconfig and Makefile to allow building of (incomplete)
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Sashiko got busy and found something that I now realize I didn't
understand at all :(


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index e84e84416dab..8ff51711ab1f 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -15,6 +15,57 @@
>  
>  #include "inv_icm42607.h"
>  
> +static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
> +	{
> +		.name = "user bank",
> +		.range_min = 0x0000,
> +		.range_max = 0x00FF,
> +		.window_start = 0,
> +		.window_len = 0x0100,

I'd never really looked at this bit of regmap before but sashiko
did suggest a possible issue and from the documentation it appears it
might be right. 
 * Registers, mapped to this virtual range, are accessed in two steps:
 *     1. page selector register update;
 *     2. access through data window registers.

So whether or not we want one the page selector infrastructure is
used.

So Sashiko suggested we'll get a bank setting write to register 0
with value 0.

Having dug around I found a 42607-c datasheet:
https://www.lcsc.com/datasheet/C2879807.pdf?spm=wm.sxq.inf.ggs&lcsc_vid=EVNXBlQAR1RZAwIHTwMLUVcEFgVcAQdQQgVeBlJSQAIxVlNRT1RcVldeQlZeVzsOAxUeFF5JWBYZEEoBGA4JCwFIFA4DSA%3D%3D

That suggests there is a bank select register but at 0x7c which isn't
documented for the 42607P :(

It also doesn't correspond to conventional window / bank arrangement so
this probably doesn't apply anyway.


> +	},
> +};
> +
> +const struct regmap_config inv_icm42607_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x00FF,
> +	.ranges = inv_icm42607_regmap_ranges,
> +	.num_ranges = ARRAY_SIZE(inv_icm42607_regmap_ranges),
> +	.cache_type = REGCACHE_NONE,
> +};
> +EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");

