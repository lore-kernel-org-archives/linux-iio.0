Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29233343C;
	Sat,  7 Mar 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903514; cv=none; b=N8jbcMOqJpDpKH94U10o5bw0ZH5ooKLQJzUWa9brfrjMw88SD2Y1VAhLFc/hPYJaWw4HeSDuY5mnetAvgVYEPX4YqGfiIc7ghNX4b38BrD6KQyz43zzBRymcrn8Bm8gqACVouPIIlXH2DRKBrVfNmBYxlT1rlLFiHhMvE37BLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903514; c=relaxed/simple;
	bh=BvNDd1b5MKmcJPAGzg/yWIGtPouqJqU4qEm+cADjBsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exV8N1lj0OnNY1DU+w9B+2Nww8Y8+BHosPvEtBdfWj5X+MjqCHMUJzo1Hz3agnPr/oH5daLstTRWRNOZLNnWqgf9S/B/TcqtJ+Sx/aNUkgKeTUSexPHl99pXSgegz/rK30LGp3MwYWwVkrW4sbGByaTfbVIrcvjs0R0qXqa2mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idfmKf7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idfmKf7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E0BC19422;
	Sat,  7 Mar 2026 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772903513;
	bh=BvNDd1b5MKmcJPAGzg/yWIGtPouqJqU4qEm+cADjBsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idfmKf7mTHVE2czp5iaWkCWF8RvUyG8rL5RSkd/3hK7YR9Wc6ONDDWjndIM4jrAwA
	 KJy1Plg9z8DTiX5f7gOMALSKO/ZZlNiCdEQUTfSkwoqhYzOiPkSBpaToMSqY2RGZWq
	 LENPPPOMVKasza4hXsb7F1DGQehYCN321XJG6/MpmQyIXXQWHVBTPemDAa+6iC7/Bl
	 hhiXIkJwYu2yL1unil623s0GHttJ9Q1c2NeukCs49qtNFr1rSy1Mp+dnxAXiO+JHNy
	 vR00scKaH+bbWygi3rKv5uSBRjPZj3UcAU+pNjSXjDMXARQJettH0obgHx4Vxppquh
	 gL5hrxw8LEhFA==
Date: Sat, 7 Mar 2026 17:11:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 puranjay@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: accel: adxl372: convert to guard(mutex)
Message-ID: <20260307171144.46d42799@jic23-huawei>
In-Reply-To: <20260307114912.58062-3-rajveer.chaudhari.linux@gmail.com>
References: <20260307114912.58062-1-rajveer.chaudhari.linux@gmail.com>
	<20260307114912.58062-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 17:19:12 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> adxl372_write_threshold_value(). This ensures the mutex is released
> on all return paths and allows returning directly without a goto label.
> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Series applied. One small tweak mentioned below.

Applied to the testing branch of iio.git where the bots poke at it
briefly before I push it out as togreg which linux-next picks up.

Thanks,

Jonathan

> ---
> v4: Changelog moved below --- as requested by Jonathan Cameron.
> v3: Return directly from error path without goto.
> v2: Split into separate patch per driver.
> ---
>  drivers/iio/accel/adxl372.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 28a8793a53b6..4bf8656991ea 100644
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
> @@ -336,18 +337,14 @@ static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev, unsigned
>  	struct adxl372_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->threshold_m);
> +	guard(mutex)(&st->threshold_m);
> +
>  	ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
>  	if (ret < 0)
> -		goto unlock;
> +		return ret;
>  
> -	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
> +	return regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
>  				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);

I'd expect a minor indent update to be needed here.  1 more space.

> -
> -unlock:
> -	mutex_unlock(&st->threshold_m);
> -
> -	return ret;
>  }
>  
>  static int adxl372_read_axis(struct adxl372_state *st, u8 addr)

