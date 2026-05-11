Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B1402BA0
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515435; cv=none; b=CdQWhF+l1lkcgYN88pGM9mtK4PMwXEb90hL3tQ7UBbHJvoxFdpXspHdcyNSkCZU88hsRZH2d64/56WhNEvaPPhMk8xzxkUZ2lAV+3XfViJ565+6uYrn9IYzHjDO40gC8wW7xFDOWxluNiyOtokDoOa0mTXgZNr1cFi6pMQeeraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515435; c=relaxed/simple;
	bh=IIRiUxZMZ99KdC1fuostfl0a2KSy8fRMOgeT+hPLW6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTPRNiwDB4m6FuAoq+31W/ZuYUs/KTaqtyz3c035YCwlQCaOslJDhiIFzaynKj7yZyIlYrnC159FWRwt3FnbsqB9Z1WUI2Lf1sGA+Hn04k9qkxh98h3MH7JhuxtYAHYSV1EvmSFzpV/6kPLyIQ2NqVE3UDBp0+HA4W6zLflBfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKUOIBdn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKUOIBdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681E1C2BCB0;
	Mon, 11 May 2026 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515434;
	bh=IIRiUxZMZ99KdC1fuostfl0a2KSy8fRMOgeT+hPLW6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LKUOIBdnQp7Hn57LqdK0RTXlqDMhsb0B5ydSMVQx2UWPccHgpJQB+ZbL4IatYftvU
	 CJuiVcXZ1sWdlCuAk00dDZVh0/UFLaT0NnKiSz8moOLDAzKPoVKQbt27fpuUlNIFzR
	 69Hsn5zvawD+Wi/qwXviHSz68qLhtatGuJTIurILZYoNZjCL8DzVugFK6DSfHThkth
	 lWtFayqm8+Kc9uCs29FxQMYiy+9tNzHuGlg+NSKL/HTFRCEyaSc7+91XDqBuF5pH/y
	 au02rpYjmZv3xcYy3myUMQRV7jYjTaa8OL+LTycp+DK8Hl5qjgxbryIwIkm1cxj/lE
	 qPyFGQUBEk9VA==
Date: Mon, 11 May 2026 17:03:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
 dlechner@baylibre.com, mike.looijmans@topic.nl
Subject: Re: [PATCH v4] iio: adc: ti-ads1298: Fix incorrect timeout comment
Message-ID: <20260511170346.2499e13a@jic23-huawei>
In-Reply-To: <20260510193645.4616-1-shofiqtest@gmail.com>
References: <20260510123801.4066-1-shofiqtest@gmail.com>
	<20260510193645.4616-1-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 22:36:45 +0300
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
Given the versioning mess - please check I got the right one on
the testing branch of iio.git.

Probably applied this one - it broke b4 btw as that picked up two
near identical patches as a single series.

Jonathan

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

