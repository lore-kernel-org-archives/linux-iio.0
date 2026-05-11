Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6A472791
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521846; cv=none; b=c6ezYc2kJoP1Pvvol+pWVCiXDXZjDHSNcHOiLaitgtUCEXOX/IkiS7C3mpWnnFsM7LMhg86Wbcb1Lt0oI6xLFqAR4KDrFfkkjsKWsbS5pOqPfVc42de0+PVujo9XsdL8Dz7tKe0hgSN2w+brNBSJclvNE+RyJZ6tdz06hfJkZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521846; c=relaxed/simple;
	bh=h+m6zjWVZFi9p3jLXbyfq5ZdJDVGDVVmpWMWxhZ9AL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GexCxcAQHNXCCCrW7f8ALX/TNKAlLOVxlhQXNZ8MwQTJWwK83KCylRNQSkJrADG6XMc1lJSgoTiWvrhWtUbwRycoxgyqvsvZZn4DuwSlidcxdG1jsIe4jt1B8XHjy4hJQ4g+pRsOARPylAFdn8GVr8U1q/CpjweDjwN8cqNm3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoH67Jgh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoH67Jgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7FAC2BCC9;
	Mon, 11 May 2026 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521845;
	bh=h+m6zjWVZFi9p3jLXbyfq5ZdJDVGDVVmpWMWxhZ9AL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hoH67JghO6YvKA54Ljoa+tnnx+xdeO0ik6ScJCJjCpuuL2ZNNpYNkzEE3ZMRCzM0t
	 RRuM/YtRJyGZ87hRxjJ/86IXv85HwOlNjZP7YusacJ5aYeILQbjH/SCk1INGdbn26l
	 uNRPz2IELuv4JSAgSqLAalKB/blZ9f6ikypz8Di/FBZvSzAJEsQQvtUSSlP3iiKb3y
	 2xfGXq/GfgnJ6HBp+tGeu2wD05NV+sFDxizr+d9OIeY8xYjqvDoMweTLTTwBx/E+ac
	 afNSz6L28Vnu+RN6wpD7ZFAkUFEnTIEG/atTJFziJasMtnI5YEelv6JCpJwXIBaKeP
	 tTHmXGzIMHKeg==
Date: Mon, 11 May 2026 18:50:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
 david.lechner@sifive.com, mike@mikelooijmans.nl
Subject: Re: [PATCH v4] iio: adc: ti-ads1298: Fix incorrect timeout comment
Message-ID: <20260511185038.2c367a9f@jic23-huawei>
In-Reply-To: <20260510193435.4602-1-shofiqtest@gmail.com>
References: <20260510123801.4066-1-shofiqtest@gmail.com>
	<20260510193435.4602-1-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 22:34:35 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> At the lowest supported data rate of 250Hz, one conversion period is
> 4ms, not 40ms. The 50ms timeout is deliberately conservative to allow
> for kernel scheduling latency, which can be significant under load or
> on slow machines.
> 
> Fix the comment to state the correct conversion time, use "lowest sample
> rate" for clarity, and explain that the extra margin exists to absorb
> scheduling latency so that no one is tempted to shrink the timeout to
> match the conversion period.
> 
> Also drop the redundant ret variable assignment by using the return value
> of wait_for_completion_timeout() directly in the if() condition.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
Hi. Please slow down a bit and perhaps more importantly be careful
with your various series numbers etc.  I see the same patch in a series
label v4 then as a patch on it's own labelled v2, one labelled v3 and
2 patches labeled v4 sent a few minute apart

I'm going to pick up the most recent one probably but that might
well be the wrong one!


> ---
> Changes in v4:
>  - Drop the ret assignment for wait_for_completion_timeout(); use the
>    return value directly in the if() condition (Andy Shevchenko)
> 
> Changes in v3:
>  - Fix multi-line comment style: move comment text to its own line
>    after '/*' (Andy Shevchenko)
> 
> Changes in v2:
>  - Correct conversion time to 4ms (was wrong 40ms), add scheduling
>    latency explanation, clarify "lowest sample rate" (David Lechner,
>    Andy Shevchenko)
> 
>  drivers/iio/adc/ti-ads1298.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index ae30b47e45..25261163d3 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -210,9 +210,11 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
>  		return ret;
>  	}
>  
> -	/* Cannot take longer than 40ms (250Hz) */
> -	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
> -	if (!ret)
> +	/*
> +	 * One conversion takes at most 4ms at the lowest sample rate (250Hz).
> +	 * Use 50ms to allow for kernel scheduling latency.
> +	 */
> +	if (!wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50)))
>  		return -ETIMEDOUT;
>  
>  	return 0;

