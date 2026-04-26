Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044931F9A7;
	Sun, 26 Apr 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212520; cv=none; b=pMy90RsnPu2sYvuISXdAaD2kFe08TLqGugV1tz43/JfxayURI12FoyVLH+JbniyWAY1cXZi1iI5Zf67jxfvNUtAZQps+To2KpW2Zu53P0ffXVwBVe34itplfD/JL67wE9sAlnPHJNyUF4hbXJvUHBPX7CFOzIncaYk31278DE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212520; c=relaxed/simple;
	bh=hurwK2WVxAlwBhat41jPPzeBCTbTj3PpHvqLeqkzPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOPwb3yt2AVI/WQSyhsiAUXTW/5h6spl5ol3/J0RbARKAVcEevHWbJ00yPjeWGk0vI9b/u6ctTqJbp1MAk4iUakzFJaoqKdnd5KjwG/Ye7kq1+yQZs3+TfIsy0I34Cihkhnh399NuMYo/AgXv3ZiersdrpFz12JDQ2LQgCx4KI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InrUKMMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InrUKMMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1845C2BCAF;
	Sun, 26 Apr 2026 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777212520;
	bh=hurwK2WVxAlwBhat41jPPzeBCTbTj3PpHvqLeqkzPd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InrUKMMH2OUFu1aat96H7mWnBdHqilaDZ+zR4S48VIHGFvTFsMnkLl0kHOniPfYiH
	 kfzw73xMik2+1QfNkGgMJTvmkWP0Dsc4y41QquVO3jC4TlNpoDwVikh5BSSx5IoAhC
	 RffKAYGOgKlwrgLCnd/Xt2rAXVG6AXHo5Ayc+ZxOHEr4eazeaJUBmavcSiXmfRapEF
	 JTsLmuOxxJr/0NnvSyyA9zq9YDfq5O9Kz3HjdQzsP65oNhdU6VUXShaMEeNwE4pOPJ
	 hQ17YeZybuYhBQKkgk97sqRp8JIMP2lm+M3XiyAMOUgumRFSanrvHVcbPTQ3fd+NHX
	 e06UqwfYuYuNA==
Date: Sun, 26 Apr 2026 15:08:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] iio: ssp_sensors: factor out pending list
 add/remove helper(s)
Message-ID: <20260426150830.7ab41ad3@jic23-huawei>
In-Reply-To: <20260426091710.3722035-3-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-3-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:03 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> The SSP SPI transfer path manipulates the pending message list in
> multiple places, each time open-coding the same locking and list
> operations.
> 
> Re-factor the pending list add and delete logic into small helper
> functions and drop use_no_irq variable to avoid duplication and
> simplify transfer flow to follow.
> 
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> Changes in v7:
> - Following suggestion from Andy, keep helper API definition in single
>   line and re-place the comment section
> - v6 change: https://lore.kernel.org/all/20260415050749.3858046-4-sanjayembedded@gmail.com/
> Changes in v6:
> - Include tag for the suggestion of helper functions
> - Drop completely use_no_irq variable with review comment from Andy
> - v5 change: https://lore.kernel.org/all/20260406080852.2727453-4-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 58 ++++++++++++++----------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 08ed92859be0..870214551f0b 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -174,15 +174,35 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
>  	return 0;
>  }
>  
> +static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg)
> +{
> +	/*
> +	 * Check if this is a short one way message or the whole transfer has
> +	 * second part after an interrupt.
> +	 */
> +	if (msg->length == 0)
> +		return;

I know Andy suggested your bring these into the helpers, but to me
it's obscuring flow as it looks at the caller like it was added
to the pending list when it wasn't..  And we end up with multiple
checks on msg_length where we had one before.

One option would be to have it return a bool to indicate whether
it was added to the pending list or not.

Andy, would that work for you?

> +
> +	mutex_lock(&data->pending_lock);
> +	list_add_tail(&msg->list, &data->pending_list);
> +	mutex_unlock(&data->pending_lock);
> +}
> +
> +static inline void ssp_pending_del(struct ssp_data *data, struct ssp_msg *msg)
> +{
> +	/* See ssp_pending_add() for transfer length logic */
> +	if (msg->length == 0)
Not useful to know if this happened at caller, so no need to return
bool from this.
> +		return;
> +
> +	mutex_lock(&data->pending_lock);
> +	list_del(&msg->list);
> +	mutex_unlock(&data->pending_lock);
> +}
> +
>  static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
>  			   struct completion *done, int timeout)
>  {
>  	int status;
> -	/*
> -	 * check if this is a short one way message or the whole transfer has
> -	 * second part after an interrupt
> -	 */
> -	const bool use_no_irq = msg->length == 0;
>  
>  	if (data->shut_down)
>  		return -EPERM;
> @@ -202,35 +222,23 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
>  		goto _error_locked;
>  	}
>  
> -	if (!use_no_irq) {
> -		mutex_lock(&data->pending_lock);
> -		list_add_tail(&msg->list, &data->pending_list);
> -		mutex_unlock(&data->pending_lock);
> -	}
> +	ssp_pending_add(data, msg);

With suggestion above this would become

	use_irq = ssp_pending_add(data, msg);
>  
>  	status = ssp_check_lines(data, true);
>  	if (status < 0) {
> -		if (!use_no_irq) {
> -			mutex_lock(&data->pending_lock);
> -			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
> -		}
> +		ssp_pending_del(data, msg);
>  		goto _error_locked;
>  	}
>  
>  	mutex_unlock(&data->comm_lock);
>  
> -	if (!use_no_irq && done)
> -		if (wait_for_completion_timeout(done,
> -						msecs_to_jiffies(timeout)) ==
> -		    0) {
> -			mutex_lock(&data->pending_lock);
> -			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
> +	if (msg->length && done &&
then
	if (use_irq && done &&
	    !wait_for_completion_timeout()
> +	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
> +		ssp_pending_del(data, msg);
>  
> -			data->timeout_cnt++;
> -			return -ETIMEDOUT;
> -		}
> +		data->timeout_cnt++;
> +		return -ETIMEDOUT;
> +	}
>  
>  	return 0;
>  
The mix of using a goto error handling block and not in here is not elegant but
it's would take quite a bit of reorganizing to tidy that up.  One option would be to
factor out this bit
	mutex_lock(&data->comm_lock);

	status = ssp_check_lines(data, false);
	if (status < 0)
		goto _error_locked;

	status = spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
	if (status < 0) {
		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
		goto _error_locked;
	}

	if (!use_no_irq) {
		mutex_lock(&data->pending_lock);
		list_add_tail(&msg->list, &data->pending_list);
		mutex_unlock(&data->pending_lock);
	}

	status = ssp_check_lines(data, true);
	if (status < 0) {
		if (!use_no_irq) {
			mutex_lock(&data->pending_lock);
			list_del(&msg->list);
			mutex_unlock(&data->pending_lock);
		}
		goto _error_locked;
	}

	mutex_unlock(&data->comm_lock);

into a helper, use guard() for the outer mutex and then direct returns.

Then we only have a simple check on return value from that to decide
to increment the counter and exit on error.

