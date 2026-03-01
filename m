Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC70175A61;
	Sun,  1 Mar 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772366201; cv=none; b=CBZcmila+dPI9QOs8Im/v5BV5AnSBG+yDlIX6t5ds149D6sdhYoRhFL8NSnixKEUbrseyLJFCvPfllUaWh4ZfES4AS7U12iGpzTvQf6adnEfV0ZqvsZWXke+/aKap10kXRl1IUeUGnNkSqa0jlrsrO7VoU3kxO7o/vh26zIy1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772366201; c=relaxed/simple;
	bh=V+QKkGt2qPd4dqHoYPCwgZ4jlImMbxVdhogh6CZT5Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8dVoi0EXa5fdeSq6Xa8uGyT71BUf4b2X4zhWDPVnOtdOD2obMHk6KqbyHcNkVnNwBgUFTR5jDOH4ClOhKTkEaqssYwwsO94+9cCHPOSfHq4w5OVw00a6naa+TXCtfM0D/0QI6VZRnc/Atp8CMJcArNC24VyeXOh+yvoPFUy/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OODW6oJ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OODW6oJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D83C116C6;
	Sun,  1 Mar 2026 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772366201;
	bh=V+QKkGt2qPd4dqHoYPCwgZ4jlImMbxVdhogh6CZT5Fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OODW6oJ4PW9YGdsrZKP2qGGDiT6NCfedFryiAZKbo00g8RtIrfHYQFgAU8nhVp7cc
	 yMOYlakHnZN4TBaqAf3tYY7va0L/JmZ3yqkjYzYSJh7rq7D8eVXSe0Gn2WaMuHveot
	 5E0gOWE3LlGhW718fzKAM06XwvyUZY050+x/nRKi9Or0HatHOM7OKFWbtE+p8sHR7f
	 iOH0txSR8MF63O7AUTmgJWGgILs/6qDbu/V2Fwy8jOUmNFc62j6nxF6w5Bjp+5hBF5
	 zEMb0tMNFyPM1RKTJ9PsLXcPhxiVw5jy/dfDx8EFGQU/N72nfBxF3pipI06Rr7xIse
	 AmOX/KEgG01Fw==
Date: Sun, 1 Mar 2026 11:56:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <20260301115633.7529cbee@jic23-huawei>
In-Reply-To: <20260228172320.68144-1-neelb2403@gmail.com>
References: <20260228172320.68144-1-neelb2403@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 12:23:20 -0500
Neel Bullywon <neelb2403@gmail.com> wrote:

> Use guard() and scoped_guard() to replace manual mutex lock/unlock
> calls. This simplifies error handling and ensures RAII-style cleanup.
> 
> guard() is used in read_raw, write_raw, trig_reen, and
> trigger_set_state. Case blocks using guard() in read_raw and write_raw
> are wrapped in braces at the case label level to ensure clear scope for
> the cleanup guards.
> 
> A bmc150_magn_set_power_mode_locked() helper is added to deduplicate
> the lock-call-unlock pattern used by remove, runtime_suspend, suspend,
> and resume.
> 
> The trigger_handler function is left unchanged as mixing guard() with
> goto error paths can be fragile.
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
Hi Neel

LGTM, but I'll leave some time for Andy to take another look if he
wants to.

One comment inline on a possible follow up bit of driver cleanup.

Jonathan

> ---
> I don't have BMC150 hardware, so I went with Andy's _locked() helper
> approach rather than moving the guard into bmc150_magn_set_power_mode()
> itself, which would touch the runtime PM locking Jonathan flagged as
> suspicious. The deeper runtime PM cleanup can be done separately by
> someone who can test it.
> 
> v8:
>   - Add bmc150_magn_set_power_mode_locked() helper to deduplicate the
>     lock-call-unlock pattern in remove, runtime_suspend, suspend, and
>     resume (Andy Shevchenko)
> v7:
>   - Split into separate patches (Jonathan Cameron)
> v6:
>   - Remove scoped_guard() from runtime_suspend and use guard() in
>     suspend/resume (Jonathan Cameron)
> v5:
>   - Use scoped_guard() instead of guard() in remove and
>     runtime_suspend (Andy Shevchenko)
> 
>  drivers/iio/magnetometer/bmc150_magn.c | 112 ++++++++++---------------
>  1 file changed, 44 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 6a73f6e2f1f0..a4e2209f6ed4 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c

> @@ -794,32 +788,28 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
>  
> -	mutex_lock(&data->mutex);
>  	if (state == data->dready_trigger_on)
> -		goto err_unlock;
> +		return 0;
>  
>  	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
>  				 BMC150_MAGN_MASK_DRDY_EN,
>  				 state << BMC150_MAGN_SHIFT_DRDY_EN);
A nice follow up might be to look for all cases like this in this driver
and make them
	ret = regmap_assign_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
			      	 BMC150_MAGN_MASK_DRDY_EN, state);
And drop that shift define.


>  	if (ret < 0)
> -		goto err_unlock;
> +		return ret;
>  
>  	data->dready_trigger_on = state;
>  
>  	if (state) {
>  		ret = bmc150_magn_reset_intr(data);
>  		if (ret < 0)
> -			goto err_unlock;
> +			return ret;
>  	}
> -	mutex_unlock(&data->mutex);
>  
>  	return 0;
> -
> -err_unlock:
> -	mutex_unlock(&data->mutex);
> -	return ret;
>  }


