Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B918872A;
	Sat,  7 Mar 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880107; cv=none; b=PwMU4z96N3RXGeIKsAGt4AZ1gtDRmImwNHudUfuDVTBfuvp/DI1tZQsTCPG1xeSnxtWkfLs9x8QakOSKo3MXfeYLMvF96dduLrO6I8iKY3/aXfDv7muJSQxWyb5/pNQD6K4rD9OjxSnlKeR4wVY9zodYvyDD20V8jiGc3MknLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880107; c=relaxed/simple;
	bh=s+dYzVTnOuW632rJqhegb2n5rbZ8W5iZQVFPbSlP64U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eV+PqJRSiUliV2dhScQzNqn6VBV9nd16riLeUNDWHpaBOr3KrQAMNIN/iNZodZuFC1twBctMrXcQfcyXtC457O7JcEBwK9HirY5ed2NckCYXZGVwz5ldThuGGZ5Y9BKUXegTjj8rCMoCp92skMixE/4+qAwQIeKDgxBXDcDWgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGkC86c9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGkC86c9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAF1C19422;
	Sat,  7 Mar 2026 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772880107;
	bh=s+dYzVTnOuW632rJqhegb2n5rbZ8W5iZQVFPbSlP64U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jGkC86c9ZewqS+8h99xFMi2uGb7s+3jTVW3mKYgXKIPYze9hUGFYU4en3GSx+K050
	 ONIWgiNsBjKrjH24z8d66o3xdG1FVn4NcFKJvdBqE0lDMu1A2r7cahQLRkN4tbChPG
	 VVbIqz3zhXSvrdBps2/IwaLFjCM+E9NKtCB52+AmOIxltFG4Y936ybtG323jbqwOaa
	 sSfwmkrviYF9lBs8lfKOdutTIzkJdWzEcYIppDIKcrPnoevb6Raw8Lx0hGis2U0+V2
	 KvPMWAWdXB/ezEUnH7snjANq0OmCR9RUNMnzletH6mXFpG2qV8qIgiB4NCdgJPnSA7
	 gpFV2+XcOfX3A==
Date: Sat, 7 Mar 2026 10:41:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 puranjay@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: accel: adxl372: convert to guard(mutex)
Message-ID: <20260307104137.1d8e22a5@jic23-huawei>
In-Reply-To: <20260307101758.50091-4-rajveer.chaudhari.linux@gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-4-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 15:47:58 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> adxl372_write_threshold_value(). Remove goto label and return
> directly on error path.
> 
> v3: Return directly from error path without goto.
> v2: Split into separate patch per driver.
As in previous, this needs to move down.
Otherwise this patch is fine.

Thanks,

Jonathan

> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> ---
>  drivers/iio/accel/adxl372.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 28a8793a53b6..340433782cf2 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/module.h>
> @@ -334,20 +335,15 @@ static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev, unsigned
>  					     u16 threshold)
>  {
>  	struct adxl372_state *st = iio_priv(indio_dev);
> -	int ret;
>  
> -	mutex_lock(&st->threshold_m);
> -	ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
> +	guard(mutex)(&st->threshold_m);
> +	
> +	int ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
>  	if (ret < 0)
> -		goto unlock;
> +		return ret;
>  
> -	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
> +	return regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
>  				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
> -
> -unlock:
> -	mutex_unlock(&st->threshold_m);
> -
> -	return ret;
>  }
>  
>  static int adxl372_read_axis(struct adxl372_state *st, u8 addr)

