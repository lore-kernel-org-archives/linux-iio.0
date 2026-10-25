Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967242;
	b=ne/z+mtkdVNDPK0f749oGEeJfGchGk5TltpdMyk6hmeKP17xHiq3LSCyM2WTrglnJd8F
	 jvKAEY/+ANXmXBSfOkJivdFg0Dgm20iZOxfhlFqaC79t3CsHiRJMeQ1FF1LZ8bAyBLE8A
	 9KNNnpy4QJ+caWe8Jk9IAJofAyJapU3V+F7yQ3NCwawEvZF3nwUK4pTPSO/TUVn1QB3L3
	 EQOmz8mngSUkGzSivXi6/jHPXY2d3egGhZ7fqEZaWdfxAdCksL4ehhG5sJUOwPiQPJwXE
	 wYKojQy/eRzEAHZQKt34YHbZt/Co1UI7At4aP9BcNW81HQHTleTE7jglromvLfIwhBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967242;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3u6tMzs2BaMz2xr+JM0OyLqxKFNDH3+7g0VYaa+5A0s=;
	b=cHUMhT+kq8DfAxLvupGgTNVxN8+x3G+6Vky/NuWm8MKpXTI5i99vcOwHOrnwb83Vatnk
	 f2XTLUR1xDXKv9Yqke1mAJJO5/dRQafgzzRSXdpVHp3TWlXIpkdX8z0PT7zqUxLJi2Y+y
	 i9VywO+XHVZboaW4jbGLQbHg2AVbAHCthZKajZOztnXOBZ7f8j7rKSlpK2Rm/YEP9JkNN
	 3I7/XK2IBZyQfIYqv6w26IPKbRPgVOQ1kik1ZQs+GQ0Urd8XBMI4mPKZ6HELpqX7l7ecc
	 1HZEOd6Qe9YOyI/3Hi4Cnlb1kTRu7Vk2RljoD/F3tEzi/8TEy0JDZxDv4SddKjgJGcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqto1Sdv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E9606A31A;
	Sun, 25 Oct 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqto1Sdv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F951F01825;
	Sun, 25 Oct 2026 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792967241;
	bh=3u6tMzs2BaMz2xr+JM0OyLqxKFNDH3+7g0VYaa+5A0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lqto1Sdv6GNi5Or++MjJ2cySiojUrAm3eVGiupHwfWHRT5BZhRf9scv5VfaqPidJO
	 RVXzEfom8T8/Z9va/icKIPlj1SmAfode0cJvsMEJBlw701f5PsGJlPMNCRSVXyoSM0
	 1Z5Dy3eyfMQvsyrKe4UgYvhKYmwWGoey/u0l4EWNNnKUyLbOcYjn/0MrbvLioPEEqO
	 OlSPQmswAzJSYthdle6mKv7Qce2pcAeyAwAEQSW9GC1jEh8IvJcJ5TpPhMhQtTKGCh
	 QMojZg4K7wrmZ11504OFc3/qHzCxm/eOUWAP178BA5Lis3F349c8djemeo4c+64+5V
	 rpm/42MnAAKgQ==
Date: Sun, 25 Oct 2026 22:27:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx9360: fix sampling frequency write
 and available range
Message-ID: <20261025222715.6526ae07@jic23-hlaptop>
In-Reply-To: <20261025221241.19596-1-kapoorarnav43@gmail.com>
References: <20261025221241.19596-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 03:42:38 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> GNRL_CTRL1/2 hold the scan period in units of 8192 / FOSC, but
> sx9360_set_samp_freq() computes freq * 8192 / FOSC and mis-scales val2,
> which is in micro units. Any integer frequency then programs a period
> of 0, and fractional parts above ~0.26 Hz overflow the int, writing
> 0x10 to GNRL_CTRL1 outside the SCANPERIOD field.
> 
> Compute FOSC / (freq * 8192), rounded to the closest value, and reject
> frequencies outside the 1..2047 period range.
> 
> The available range doesn't match the limits in the comments next to it
> either: 4 MHz / 8192 is 488.28125 Hz, not 448.28125 Hz,
> 4 MHz / (8192 * 2047) is 0.238535 Hz, and (max - min) / 2047 is
> 0.238419 Hz. Use those values.
> 
> Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Seems like you've addressed Andy's comments (except for the 'at some
point' one which is fine to leave for now).
Looks good to me, so rather than keep track of this one I'm
going to speculatively apply it to the fixes-togreg branch of iio.git
and mark it for stable.

Note that I'll be rebasing that tree anyway on rc1 when it is available
so there is still time for others to take a look

Thanks

Jonathan

> ---
> Changes in v2:
> - Rename period to period_ticks and say in the comment what a tick is (Andy)
> - Rename freq_uhz to freq_uHz and use MICROHZ_PER_HZ instead of MICRO (Andy)
> - Add a blank line before guard() (Andy)
> 
> Converting sx9360_samp_freq_interval[] to a plain int array is left for
> a separate cleanup.
> 
> Compile-tested only (W=1); I don't have SX9360 hardware.
> 
> v1: https://lore.kernel.org/all/20261024180149.144609-1-kapoorarnav43@gmail.com/
> 
>  drivers/iio/proximity/sx9360.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index ed83d809ecf5..2a9b37df8f62 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -14,10 +14,12 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/log2.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -43,6 +45,7 @@
>  #define SX9360_REG_GNRL_CTRL1_SCANPERIOD_MASK GENMASK(2, 0)
>  #define SX9360_REG_GNRL_CTRL2		0x12
>  #define SX9360_REG_GNRL_CTRL2_PERIOD_102MS	0x32
> +#define SX9360_REG_GNRL_SCANPERIOD_MAX		GENMASK(10, 0)
>  #define SX9360_REG_GNRL_REG_2_PERIOD_MS(_r)	\
>  	(((_r) * 8192) / (SX9360_FOSC_HZ / 1000))
>  #define SX9360_REG_GNRL_FREQ_2_REG(_f)  (((_f) * 8192) / SX9360_FOSC_HZ)
> @@ -182,9 +185,9 @@ static const struct {
>  	int val;
>  	int val2;
>  } sx9360_samp_freq_interval[] = {
> -	{ 0, 281250 },  /* 4MHz / (8192 * 2047) */
> -	{ 0, 281250 },
> -	{ 448, 281250 },  /* 4MHz / 8192 */
> +	{ 0, 238535 },  /* 4MHz / (8192 * 2047) */
> +	{ 0, 238419 },
> +	{ 488, 281250 },  /* 4MHz / 8192 */
>  };
>  
>  static const struct regmap_range sx9360_writable_reg_ranges[] = {
> @@ -383,11 +386,25 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
>  static int sx9360_set_samp_freq(struct sx_common_data *data,
>  				int val, int val2)
>  {
> -	int reg;
> +	unsigned int period_ticks;
> +	u64 freq_uHz;
>  	__be16 buf;
>  
> -	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
> -	buf = cpu_to_be16(reg);
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	freq_uHz = (u64)val * MICROHZ_PER_HZ + val2;
> +	if (!freq_uHz)
> +		return -EINVAL;
> +
> +	/* The register holds the scan period in ticks of 8192 FOSC cycles. */
> +	period_ticks = DIV64_U64_ROUND_CLOSEST((u64)SX9360_FOSC_HZ * MICROHZ_PER_HZ,
> +					       freq_uHz * 8192);
> +	if (!period_ticks || period_ticks > SX9360_REG_GNRL_SCANPERIOD_MAX)
> +		return -EINVAL;
> +
> +	buf = cpu_to_be16(period_ticks);
> +
>  	guard(mutex)(&data->mutex);
>  
>  	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
> 
> base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9

