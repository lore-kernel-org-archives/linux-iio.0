Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2513ECBC3;
	Fri,  5 Jun 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663938; cv=none; b=SOsxQ3OAcRjKEwfuieoD9TB+Ke0SGP3vU06zc+4W8AlKYX5UuFaXVS3+wHql9fzUEwXpTost7NYJ7Cr+PMNbZAWuVyI88sk4Ocs6ngifq2iIvwwSVDwrrfh9K2X8AJHZwv3Raxh7x3FMAPzFApYyGAxo3dTMMlZm8TJPTSDfDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663938; c=relaxed/simple;
	bh=2wy0s0uSyxFiHS1sra+ea7XW2z2U4ebI+zkNoFaFA5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhDJCxzv9Akdgkv+MfnddIRnihHbIFszfq/aJRTrOlguz/9mpQgC2XWSef4tYs2jFYUP3oafwO7NcRAh1pSx+YZLjbiAYl1xQpZKmXeW+b6ILUdgnAnDSf2/7Lj4n8z+fp0u/7kcAUNRndcHlP8QAIG0HzCsLKKOYWVZc38we7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIMqAx3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIMqAx3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A681F00893;
	Fri,  5 Jun 2026 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780663937;
	bh=LVLEirNU44mUog9SK8v8/lLmbG0QgjEmknXgdugiTRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dIMqAx3oCH3DS30Wr319fzN+mlBRfVUoPxKlPs0Zcm5zbJAaS94J8R0G89sSWDRRk
	 g64UWR/uKAKFrkZdCDkjU4xurRhgdYyQe5hcBI+4Ad2CU6NVe3PUz8wMVqpgmJh0I8
	 0aClNH2IW8+xFyF5HV+yjeEQD+yBGF7HQbcmLcqckx4x1FKdqPppUFf2Da1ij+/vUT
	 pdQRi/04u1fBb7au5eJ44bLcnh9ApDsQqmNg2JSrr7aTvsqwdxXE9D5kn9CigIyeCS
	 DCA76Uqz5ZLedP5y9yur+yj9joJ9aaMjtvfSPP0vSD7SRGmjAGvC/mihBiWq/Dm4sm
	 wKCzYbs6lG98Q==
Date: Fri, 5 Jun 2026 13:52:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linusw@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: restore cached sample rate on
 runtime resume
Message-ID: <20260605135213.42a0c687@jic23-huawei>
In-Reply-To: <4622fa440f1686e06d0828a6abdbda3181fa385b.1780649212.git.github.com@herrie.org>
References: <4622fa440f1686e06d0828a6abdbda3181fa385b.1780649212.git.github.com@herrie.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 10:47:22 +0200
Herman van Hazendonk <github.com@herrie.org> wrote:

> mpu3050_runtime_resume() only calls mpu3050_power_up(), which clears
> the SLEEP bit and waits 200 ms for the chip's register file to come
> back. It does not reprogram the full-scale, low-pass filter or sample
> rate divisor, all of which return to the chip's power-on defaults
> across a power cycle.
> 
> The driver's cached state (mpu3050->fullscale, mpu3050->lpf,
> mpu3050->divisor) is the source of truth for what userspace observes
> through the IIO ABI: in_anglvel_sampling_frequency goes through
> mpu3050_get_freq() which reads the cached lpf and divisor, and
> in_anglvel_scale similarly reads cached fullscale. After the first
> autosuspend cycle the chip's actual sample rate diverges from what
> sysfs reports, until the next IIO_CHAN_INFO_RAW read incidentally
> reprograms the chip via mpu3050_set_8khz_samplerate() and the cached
> state restoration paths in mpu3050_fifo_read_one().
> 
> That incidental restoration is only triggered by direct sysfs raw
> reads, not by buffered/triggered mode. A user who configures the
> sample rate, starts buffered capture and then leaves the device idle
> long enough to autosuspend will see chip-default-rate samples after
> resume rather than the configured rate.
> 
> Reprogram the chip from the cached state in mpu3050_runtime_resume()
> by calling mpu3050_start_sampling() after mpu3050_power_up() succeeds.
> On failure power the chip back down to keep regulator and pm_runtime
> reference counts in sync with the error path.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
This one looks fine to me, but I'd like some more eyes on it so will leave
it on list for a little while.

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..ac041074cfdf 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1291,7 +1291,32 @@ static int mpu3050_runtime_suspend(struct device *dev)
>  
>  static int mpu3050_runtime_resume(struct device *dev)
>  {
> -	return mpu3050_power_up(iio_priv(dev_get_drvdata(dev)));
> +	struct mpu3050 *mpu3050 = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	ret = mpu3050_power_up(mpu3050);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * mpu3050_power_up() only clears the SLEEP bit; it leaves the
> +	 * full-scale, low-pass filter and sample rate divisor at the
> +	 * chip's power-on defaults. Restore them from the driver's
> +	 * cached state so the hardware matches what userspace observes
> +	 * via the IIO ABI (in_anglvel_sampling_frequency, in_anglvel_scale)
> +	 * across a suspend/resume cycle. Without this the chip continues
> +	 * to deliver samples at chip-default rate after the first
> +	 * autosuspend cycle, until the next IIO_CHAN_INFO_RAW read
> +	 * incidentally reprograms it.
> +	 */
> +	ret = mpu3050_start_sampling(mpu3050);
> +	if (ret) {
> +		dev_err(dev, "failed to restore sampling config on resume\n");
> +		mpu3050_power_down(mpu3050);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  DEFINE_RUNTIME_DEV_PM_OPS(mpu3050_dev_pm_ops, mpu3050_runtime_suspend,

