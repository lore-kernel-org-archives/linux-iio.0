Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45A2F6577;
	Sun,  6 Sep 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716644; cv=none; b=S8d6FNpX79lgq+//RNXzDwac003iFJD3yCE3mY9QBNJGHLwBvXeTEeX+butQ0lWLoeGPKjOEo2BNFe9sL0wGlZGwyIBvJIMH4jEc29YvadJcu3N6qOT9in0kjRCycCcozDj+N8+CV1XknCD/LCPgXchqKtbFEw2sZstXL87J3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716644; c=relaxed/simple;
	bh=rlbNMxgTUaDD6bf687rnBUAv7HhNcMjmkhtUT52MFCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLMbxYGwOoH6MdzgKNnR5y2eOWNK3eXBdpdJcKO74TC0VLJw5H8RvEewVTGr6RNXSNdmt1BRBDl88gH+kfIVy9uH0kdafLtKe2MKoaG9Fyr2dsRsp/pEoBIi136yuN+081flajTJ8rvI9OVl6aTg6leT8ouUhgM0a9OatJbDpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijyORkb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijyORkb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F4C1F00A3A;
	Sun,  6 Sep 2026 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788716642;
	bh=keiAoqR5rJkp+AiTZOHRWjSY4QoqdnXHZ+SJ0IPTUYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ijyORkb0DKNyG+v7B0dd4dcvDNSsJvsXeGJBnBsHRu5LVan2c8v/BNxuNWT0Fkbsw
	 bBI/KQJnCMHbNhvIdpEmltPzJFsxBt+uD/7hpZNVqy7V22cIN+7tpiQ56jCWpZBoaV
	 Q3qrt/X7nsxeu4HFxIRl+YzDK3h4Ht7S73Eb2Wnq3M8I2DHUuCtl7K23hijHMdPHr1
	 h1UU7x2FNY6mvWqydUM0qFXftfp7qKIQWZ7AbyUILG+8VL7M8m//9WoM3Lzs9Bc7in
	 16+MoGFpVirw90HQkmm0x04BPUdWzfSSMGC6rO5cSQ1s1mcygjdxCSVL6gyerWDM4F
	 FdUf9q5TQl7MQ==
Date: Sun, 6 Sep 2026 18:43:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Cesari <fabio.cesari@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Brian Masney
 <bmasney@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29028: fix runtime PM reference leak on
 error paths
Message-ID: <20260906184358.398f3f1d@jic23-huawei>
In-Reply-To: <20260906131203.125407-1-fabio.cesari@gmail.com>
References: <20260906131203.125407-1-fabio.cesari@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 15:11:40 +0200
Fabio Cesari <fabio.cesari@gmail.com> wrote:

> Both isl29028_read_raw() and isl29028_write_raw() take a runtime PM
> reference with pm_runtime_resume_and_get() and are supposed to drop it
> again with pm_runtime_put_autosuspend() before returning. On their error
> paths they return directly instead, leaking the reference.
> 
> The usage count is then never balanced, so the device stops entering
> autosuspend for the rest of its lifetime. The effect accumulates: every
> failed access leaks another reference.
> 
> In isl29028_write_raw() this is reachable from userspace with a single
> rejected sysfs write, for example
> 
>   echo 200 > in_proximity_sampling_frequency
> 
> which is outside the accepted [1:100] range, or
> 
>   echo 999 > in_illuminance_scale
> 
> which is not one of the two accepted scales. Both return -EINVAL with
> the reference still held. In isl29028_read_raw() the leak is reached
> when the underlying regmap access fails.
> 
> Drop the reference before checking the error, reusing the pm_ret
> pattern already present in isl29028_read_raw().
> 
> Found by auditing IIO drivers for runtime PM acquire/release imbalances
> with a Coccinelle semantic patch that models pm_runtime_resume_and_get()
> and pm_runtime_put_autosuspend() along the control flow graph, flagging
> functions that take a reference and then reach a return without dropping
> it.
> 
> Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 coccinelle
> Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
> ---
> 
> Compile-tested only: arm64 (native) and x86_64 (cross), defconfig plus
> CONFIG_SENSORS_ISL29028=m, with gcc 15.2.0, W=1 and sparse v0.6.5-rc1:
> no warnings. I have no isl29028 hardware, so this is untested at
> runtime.
> 
> I also have a version that takes the runtime PM reference only where it
> is needed: isl29028_write_raw() validates its arguments first, and
> isl29028_read_raw() acquires it only for the reads that reach the
> hardware, the sampling frequency and lux scale being cached. It also
> stops propagating the pm_runtime_put_autosuspend() return value to
> userspace, which fixes a second problem: with CONFIG_PM=n that call
> returns -ENOSYS, so every read and write fails today even when the
> access itself succeeded.
> 
> I kept this patch to the one bug, since the rest changes what userspace
> sees. Happy to send that version on top once this lands, or instead of
> this one if you would rather have it that way.
> 
>  drivers/iio/light/isl29028.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 33deb1726689..c5146c1d9f39 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -340,7 +340,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct isl29028_chip *chip = iio_priv(indio_dev);
>  	struct device *dev = regmap_get_device(chip->regmap);
> -	int ret;
> +	int ret, pm_ret;
>  
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
> @@ -392,12 +392,11 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&chip->lock);
>  
> +	pm_ret = pm_runtime_put_autosuspend(dev);
>  	if (ret < 0)
>  		return ret;

Whilst perhaps not best practice as such, it is pretty
common to just not bother checking the return of pm_runtime_put_autosuspend()
at least partly because of that annoying -ENOSYS result if runtime pm isn't
enabled.  That is what happens with the ACQUIRE macros for instance.

Do we have any particular reason to thing it is more likely to fail i this
case than any other?

> -
> -	ret = pm_runtime_put_autosuspend(dev);
> -	if (ret < 0)
> -		return ret;
> +	if (pm_ret < 0)
> +		return pm_ret;
>  
>  	return 0;
>  }
> @@ -461,15 +460,14 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&chip->lock);
>  
> -	if (ret < 0)
> -		return ret;
> -
>  	/**
>  	 * Preserve the ret variable if the call to
>  	 * pm_runtime_put_autosuspend() is successful so the reading
>  	 * (if applicable) is returned to user space.
>  	 */
>  	pm_ret = pm_runtime_put_autosuspend(dev);
> +	if (ret < 0)
> +		return ret;
>  	if (pm_ret < 0)
>  		return pm_ret;
>  
Similar applies here.

> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

