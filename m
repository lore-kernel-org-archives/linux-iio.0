Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671C3D75B1;
	Wed, 20 May 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280093; cv=none; b=Y9vf7zlHbjjJLX9fSaEuyeolyf3OIqdpHFw5ZJwp4IWOTvPmJxIKWFjavnd3RvmwTNjD6yt7kdeEQJ8x1cKOK8h7P7DziQo/pbfryvHC+ro5I9GhN32eXcKPWS2PabzjYOO7d6Y0S50jdWz1pRTEHP9ewif1EVnupLWPZIKRZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280093; c=relaxed/simple;
	bh=ZCm6TVH1EnykLRTmX44A1fDteqYudVaq3akJ1iaAlRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeCXZUxhuZsNa5FJImvgzYre5wDa9nmbQ3BCSriUdrVPRZj/4+Lf9yuA5HHevvo8hznt/DN6b9juMJxuOnghNo6UXFtebZDVc9ajzURqo1Tx6sg1UmBlBJLtSffVR7jYzIdDlW9giKp5Bs2jqVderzh/rz+czVScBtvjQRRWd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlU5VnLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlU5VnLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CC61F000E9;
	Wed, 20 May 2026 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280089;
	bh=IGpfL+0LAynm3LQxvQNaGz2SBov7K1DeTo1uYTEfziY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nlU5VnLRtUsG67Eo3H3qpoXFPbhkqh+7so8QP/EEexkBFlXkMyQ2RetweS0NAV+eU
	 dDrs++y6pBZf5Z/6K4UVWEJNlWJKpAtTg35AT8WTlf6rOcr7o1j5LZeyYuEX/fJ3+B
	 2qh6QXliLtgC51xfligEzThyRK/iwL5PKK2cZM3N7oMM0Ko8la5orwzvCaSs/PhZ/j
	 siIy65lzZLAqFjYDghRFDVyHz7l9vVqj/GvGgWFhj7MJoT7/200QAfVDVPsMI/2zRl
	 RMaJvpTyKZwpTKMFb+uaihDINVr/QKFa2JtQQp92HOZ5m8gcGK/BPgP8BDEp69A5vn
	 yEVlYh/6Ed3dA==
Date: Wed, 20 May 2026 13:28:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <20260520132802.34d82ccd@jic23-huawei>
In-Reply-To: <20260519131944.25174-1-m32285159@gmail.com>
References: <20260519131944.25174-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 08:19:43 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
> 
> Add new helper function scd30_trigger_handler_helper_locked() containing
> the critical section for scd30_trigger_handler().
> 
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Hi Maxwell

One of those cases where it made us look at code for first time in a while.
The original handling merrily copied garbage data.  Let's clean that up whilst
we are here.

Thanks,

Jonathan
>  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> @@ -579,24 +587,34 @@ static irqreturn_t scd30_irq_thread_handler(int irq, void *priv)
>  	return IRQ_HANDLED;
>  }
>  
> +/* Meant ONLY for scd30_trigger_handler() */
> +static int scd30_trigger_handler_helper_locked(struct iio_dev *indio_dev,
> +					       int *scan_data, int arr_size)
> +{
> +	struct scd30_state *state = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&state->lock);
> +
> +	if (!iio_trigger_using_own(indio_dev))
> +		ret = scd30_read_poll(state);
> +	else
> +		ret = scd30_read_meas(state);
> +	memcpy(scan_data, state->meas, arr_size);

Why is that a good thing to do if we are in an error condition?
I've have thought the data wasn't valid.

	if (ret)
		return ret;

	memcpy()..

	return 0;

Or is there something useful in that data?
Looks like some less than ideal code in the original driver but
I think it makes sense to clean that up now. Just make sure to put
a note in the patch description.





> +	return ret;
> +}
> +
>  static irqreturn_t scd30_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> -	struct scd30_state *state = iio_priv(indio_dev);
>  	struct {
>  		int data[SCD30_MEAS_COUNT];
>  		aligned_s64 ts;
>  	} scan = { };
>  	int ret;
>  
> -	mutex_lock(&state->lock);
> -	if (!iio_trigger_using_own(indio_dev))
> -		ret = scd30_read_poll(state);
> -	else
> -		ret = scd30_read_meas(state);
> -	memcpy(scan.data, state->meas, sizeof(state->meas));
> -	mutex_unlock(&state->lock);
> +	ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
>  	if (ret)
>  		goto out;
>  

