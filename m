Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078857;
	b=n4v8TysTFErcN8Su0oybePdWoLXF2dWpC+mAri3anbZULsuBrwTIuJ9gbO47QGXD6Uqv
	 P9fSDmSrmesW4b/b3x3y/yGiX2hK8/dsXC1xLFxCvQvINPCauVsey78nJYLRbMIKv9eU/
	 nYPBwdnyvTZe0Ww6loS3pz5PxmxYFG3oIUq5Cfv5p8bXFxX4IAkG93IkACSCENYO4qsGo
	 k5d+EN63K+K+bkvPSWrCU9MEAhgLzrwBFSfwMnAgsKXdCARwvo1mJgGzsJc/y3AuF4yMN
	 dBF5ed25kUtnZCr5SYJarNW7jSKUMkTvYwM6+1huo8FCv4K/1KIABkW5WK1wYHpMc2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078857;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WL1Kog7EuPHk80hIIy3ijm37NziL2Dh7hPMB6VRxMXs=;
	b=YVdMVoyrHf2Ys1GG0AfQP6zYWIHby/7tyssKsYilpiiwND/QlelkeIY/yJVY+RlO7TMy
	 NqtLNOipH44+p25zzIlcPy6JkEMzjg1HNDk0NyKp9hUNB4McxtDfvdj/ipxXTUwLhzXWs
	 IxWt+RVMVh5zxxVcHcrhLeKwjfZebZB8OXmcF2A7ACKUbOSxB6yHRBWQsRKA8yWvl/mv/
	 WCunnTdEgVUgfwZDSfGSZIyfaLHPlRxUwLsHhSdkuk9QZxT8Nz/fzFnmj0JZ7BsRWR3wZ
	 Fwx4N3aKXl/6iD/iAXHfr31N+qikloqud5Lk4jEFaeCYLSV6KoaJGiDEuLvsf98OqYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVQLjI6z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E2606A335;
	Sat,  7 Nov 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVQLjI6z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A898C1F008A3;
	Sat,  7 Nov 2026 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078856;
	bh=WL1Kog7EuPHk80hIIy3ijm37NziL2Dh7hPMB6VRxMXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YVQLjI6znbPkC2CZnQHdAJGdU7ywdGuFFkoE8cximwB6IYy0XKxxvVYxJj3oB7LIr
	 nGb41dGVLdwHyU9fvJWVGkgJ8eRgcxAwVHj3/W1sc0nA4XX68dAAN5mq5AuheibTTN
	 w3OeLC8HTIgaX13Hq6IGajFNTohn0P7DqjT1MlfozoBKpORu+iwlLskkalDFkktvaC
	 RqI18ReEIt2OEqC+f6pHxq0Vng/xhZQPQjh+7Dt8ja3Gg8BKc3IhZ6ofR7yFQfpxX2
	 HlfVGFBIVP6b/X0J0JNGqHKxKrbqEuFUghWjg6BEwSC0BjO2jlFBLLscK+G8DPvQgl
	 rldT20mpIhFKQ==
Date: Sat, 7 Nov 2026 19:14:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iio: proximity: sx9360: fix hardware gain encoding
Message-ID: <20261107191409.0e4acaad@jic23-hlaptop>
In-Reply-To: <20261107112335.444813-1-kapoorarnav43@gmail.com>
References: <20261107112335.444813-1-kapoorarnav43@gmail.com>
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

On Sat,  7 Nov 2026 16:53:34 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The sx9360 PROX_CTRL0 gain handling was copied from the original sx9324
> driver and has the same bugs that commit 108e4d4de2b5
> ("iio:proximity:sx9324: Fix hardware gain read/write") fixed there:
> 
>   - The gain field holds ilog2(<gain>) + 1, with 0 reserved, so a gain
>     of 1 is 0x1 and a gain of 8 is 0x4. read_gain() and write_gain()
>     use ilog2(<gain>) instead, so every gain is off by one: writing 1
>     programs the reserved code 0 and writing 8 programs a gain of 4.
>   - SX9360_REG_PROX_CTRL0_GAIN_1 is 0x80, which sets the reserved bit 7
>     and leaves the gain field at the reserved code 0, instead of
>     0x1 << 3.
> 
> Use the same encoding as sx9324: add one when writing, subtract one when
> reading, return -EINVAL for the reserved and out-of-range codes, and
> build the default with FIELD_PREP_CONST(). Use BIT() for the read value,
> as Andy suggested for the same code in 2022.
> 
> Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> RFC because I don't have the SX9360 datasheet. The only public copy I
> found (the one linked at the top of sx9360.c) is a short excerpt of the
> SX9324 datasheet without the register map, so this follows the sx9324
> fix by analogy: the sx9360 gain code is a copy of the pre-fix sx9324
> code, with the same mask, the same 0x80 default and the same missing +1.
> Gwendal, Stephen: could you confirm that SX9360 PROX_CTRL0 uses the same
> gain encoding as SX9324 (bits 5:3, ilog2(gain) + 1, 0 reserved, bit 7
> reserved)?

The default value is odd.  Do we have any idea what is in that top bit?
I'm going to guess something harmless and that perhaps the gain value
due to writing a 0 is either rejected, or actually mapped to same as 1.

You are correct that we really need someone with datasheet access to
sanity check this sone.

Thanks,

J

> 
> Xiaohui Zhang posted the same change in June 2022 ("iio:proximity:sx9360:
> Fix hardware gain read/write"); it had build errors and a dead-code
> read path and was not respun. The read path here uses the corrected
> check from the sx9324 read_gain() fix I sent on 2026-11-04.
> 
> Applies on top of my series "iio: proximity: sx9310/sx9360: reject
> unsupported hardware gain values":
> https://lore.kernel.org/all/20261107111710.442318-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have SX9360 hardware.
> 
>  drivers/iio/proximity/sx9360.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index c6e5b3e557bb..01a4a94219ec 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -67,7 +67,9 @@
>  #define SX9360_REG_PROX_CTRL0_PHR	0x40
>  #define SX9360_REG_PROX_CTRL0_PHM	0x41
>  #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
> -#define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
> +#define SX9360_REG_PROX_CTRL0_GAIN_RSVD		0x0
> +#define SX9360_REG_PROX_CTRL0_GAIN_1		0x1
> +#define SX9360_REG_PROX_CTRL0_GAIN_8		0x4
>  #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
>  #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
>  #define SX9360_REG_PROX_CTRL1		0x42
> @@ -291,7 +293,12 @@ static int sx9360_read_gain(struct sx_common_data *data,
>  	if (ret)
>  		return ret;
>  
> -	*val = 1 << FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
> +	regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
> +	if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
> +	    regval > SX9360_REG_PROX_CTRL0_GAIN_8)
> +		return -EINVAL;
> +
> +	*val = BIT(regval - 1);
>  
>  	return IIO_VAL_INT;
>  }
> @@ -628,7 +635,7 @@ static int sx9360_write_gain(struct sx_common_data *data,
>  	if (val <= 0 || val > 8 || !is_power_of_2(val))
>  		return -EINVAL;
>  
> -	gain = ilog2(val);
> +	gain = ilog2(val) + 1;
>  	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
>  	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
>  
> @@ -676,9 +683,11 @@ static const struct sx_common_reg_default sx9360_default_regs[] = {
>  	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
>  		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phm" },
>  
> -	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
> +	{ SX9360_REG_PROX_CTRL0_PHR,
> +		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
>  		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phr" },
> -	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
> +	{ SX9360_REG_PROX_CTRL0_PHM,
> +		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
>  		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phm" },
>  	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K, "prox_ctrl1" },
>  	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
> 
> base-commit: 509224d37ff169a02f388ab6e525d5517fb570dc

