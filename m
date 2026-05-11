Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BB37648F;
	Mon, 11 May 2026 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500817; cv=none; b=B9LbP5roa1Mes27Uu6LCf5cIVdc+GtRFWCCFEPUbsh8ICIaDKyEu9BS5UXL5jMyJS4vK6Wtye43k4RX1/FujiSCNx4lxBfKnSgCT/TzBKHJDV71L7R298MoQyHkDQf+1UNWD1AEHqylz3U8psLPRQLlNEmjvN36qDam8JZ6g2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500817; c=relaxed/simple;
	bh=lAzWVWlMy0NxLGmSi414Dzh4mPyMpyoHRCZEpOMVzjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsqAsM8EG/ffgnrDIhoEsd+Xc9HDrNMtlYbfuSoAunD8NHqXja8XqZ4I3WTgmxweBjvOuUuRGS3j6qYxyvANqEJnGwLq+CVslKCie5qUQwmtuSkV+Q/Pdw5XNB9Go4vqJ1R5FKHPQW9i4vCMw27FmExqhCV5EUeodVyzmQyUp4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFDIVCrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFDIVCrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B78FC2BCC9;
	Mon, 11 May 2026 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500817;
	bh=lAzWVWlMy0NxLGmSi414Dzh4mPyMpyoHRCZEpOMVzjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFDIVCrDdi1kuJh9Yx8xCep0HhCdneLbfgP/f4BoxdsAXU7kTV6rfOTgYKM1vDQEX
	 akCbFUbOBt4G2qykzrim5+RoJerX0Y1kPwqg96Zrr9pncL0j0FoJFGxVu0Rdy+bOQR
	 JOiyR/K35paPc3x+bn0IUqMlBSOsYSrlAgLehhZHsNMZTKVSc4IFKP2kIJAIXKDiGJ
	 O6iaAV6MU1IxqG66I42OWHR9mAJTnVwnXLlNWARw6uJbE3cRkf7akanPTsaHB6zN9O
	 pOvggVQZECFilyt8402umax50OJEC/vkfT+37sNWhvmfkxSTravuP5PyT0g+6CUhde
	 DbVkynQA1l3GQ==
Date: Mon, 11 May 2026 13:00:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: chemical: scd30: Cleanup initializations in
 scd30_float_to_fp()
Message-ID: <20260511130008.38592c5c@jic23-huawei>
In-Reply-To: <20260508225501.86448-1-m32285159@gmail.com>
References: <20260508225501.86448-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 17:55:00 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> The current variable declaration and initializations are barely readable
> and use comma separations across multiple lines. Refactor the
> initializations so that mantissa and exp have separate declarations and
> sign gets initialized later.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

This is good but we can take this opportunity to make it more
idiomatic - so more 'standard' for new kernel code.

> ---
>  ps:
>  Hi Jonathan, I noticed a potential divide-by-zero bug on line 241 in
>  scd30_read_raw(), where the value of tmp is dictated by hardware.
>  If the scd30_command_read() call on line 236 assigns 0 to tmp, then
>  when we run:
>  *val2 = 1000000000 / tmp;
>  we'll get a divide-by-zero. Will send a patch for this later.
Good to know but not sure why you'd put that comment in this patch.
Also as a fix, it should come first - ah so maybe you were indicating it
might cause a merge issue?
> 
>  best regards,
>  max
>  
>  drivers/iio/chemical/scd30_core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index a665fcb78806..be8c055be184 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -89,10 +89,15 @@ static int scd30_reset(struct scd30_state *state)
>  /* simplified float to fixed point conversion with a scaling factor of 0.01 */
>  static int scd30_float_to_fp(int float32)
>  {
> -	int fraction, shift,
> -	    mantissa = float32 & GENMASK(22, 0),
> -	    sign = (float32 & BIT(31)) ? -1 : 1,
> -	    exp = (float32 & ~BIT(31)) >> 23;
> +	int fraction, shift, sign;
> +	int mantissa = float32 & GENMASK(22, 0);
	int mantissa = FIELD_GET(GENMASK(22, 0), float32);

though maybe worth some field defines as well.
//up by defines at top of file.
#define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)

	int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);


> +	int exp = (float32 & ~BIT(31)) >> 23;
Again with a field define this can become something like:


//up by defines at top of file - and check carefully I got this right!
#define SCD30_FLOAT_EXPONENT_MSK GENMASK(30, 23)

	int exp = FIELD_GET(SCD30_FLOAT_EXPONENT_MSK, float32);
	
> +
> +	/* Determine sign of received float based on IEEE 754 standard */
> +	if (float32 & BIT(31))
	if (FIELD_GET(SCD30_FLOAT_SIGN, float32))
 
> +		sign = -1;
> +	else
> +		sign = 1;
> 
>  	/* special case 0 */
>  	if (!exp && !mantissa)
> --
> 2.54.0

