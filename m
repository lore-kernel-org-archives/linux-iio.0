Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BDF3563F6;
	Sun, 27 Sep 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790537353; cv=none; b=FY0x1bqTnj2kLHPghiXO8S4kVw6kC138llxCn/4KEciUfpdUEeZHX6zIwwRItY4z4KOs+mbUXlBlePgnSgwgM9hndYEYiTJMpcHP7O0k7pAE4V5YIf5wqcHRr1i3ZXpmGf7nhyZehoW1vxYlxp0H7STNOtYP3bovP4p1kZDJbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790537353; c=relaxed/simple;
	bh=hRywFzO11iuOsbQB9TAnf9BuhqTUEl2ohF6qCmzYg+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqafK45rO6OaNpwiwbJcXZe5ME5JZ2yvv9zlsoTkXkp4vS/T2wd1hGWdZl2iBQa3kOTULACYSI4XbmqHxY+GitIE/vv40MJni+IZhtmZv4XlSLCor1iLk3ImTClEhQajVFK1iksLXXWX8ZTjEKA2k7aBZS3RTIBrQ2Yp+OYq9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtBcMInV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtBcMInV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C281F000FF;
	Sun, 27 Sep 2026 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790537352;
	bh=9/cmjC3IxqhPWq0YWNtKJqn+Hk0gHr3fLGoj7Pb7bGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jtBcMInVQ5V+CcLJ26ER+CBuPDicUMSYJWSsW7bmAEVhgHVHRNjFw4Y/MyR+8IVK5
	 vRlOZKYObYE6i1nr1bTb8aNxowL8j6SmHalvxqjA8bzGRq9BV5+P8/BfwQF+J6Plej
	 9DcZJ7g1544PBP3HBBb+rB3KETgGVlw16qJbS4AgZ7chhn6MDnJCLFP94EoYJb86K6
	 ZT7paAlBJbzVO+toz8kRCuhyr52Fwa1ON8j2L/PeS31R8HsBjRiV7vColjHgpHQJY3
	 p4FAGscJgGzcZyhefRxh8NuIErLZpoogJ4ZSBlcBdkBN8OpzWicS6+nALwdlm4xkpv
	 iAXVHUO0jEExQ==
Date: Sun, 27 Sep 2026 20:29:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v8 07/10] iio: pressure: dps310: read buffered samples
 from the hardware FIFO
Message-ID: <20260927202906.12a695be@jic23-hlaptop>
In-Reply-To: <20260921183132.233136-8-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
	<20260921183132.233136-8-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:29 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The DPS310 has a 32-entry FIFO shared by both measurements. Drain it from
> a work item and push what it held, so a buffered capture needs no
> trigger. Nothing in tree wires the interrupt pin, so the work rearms
> itself at half the time the FIFO takes to fill.
> 
> Entries carry one measurement each, so a pressure entry is compensated
> with the temperature ahead of it. Pressure read before the first
> temperature of a session is held until one arrives rather than dropped,
> so the first push can wait a temperature period.
> 
> FIFO entries are not timestamped, so postenable refuses the timestamp
> channel unless a trigger is attached.
> 
> Tested on a DPS310 on a BeagleBone Black.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Take a look at what Sashiko had for this patch.
It raises the question on whether we can ever have a value that
is out of range in the fifo and as such fail to flush it out.

https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com

It also correctly raises that guard() and gotos should never be mixed in a
function.  See the comments in cleanup.h on this.


> ---
>  drivers/iio/pressure/dps310.c | 364 +++++++++++++++++++++++++++++++++-
>  1 file changed, 354 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 85df58ac1809..ba59413d8e11 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c


> +
> +static int dps310_buffer_postenable(struct iio_dev *iio)
> +{
> +	struct dps310_data *data = iio_priv(iio);
> +	int rc, prs_rate, tmp_rate;
> +
> +	/* An attached trigger drives the capture instead, FIFO stays off */
> +	if (iio_device_get_current_mode(iio) == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	/* Entries are not timestamped and the drain timer is no substitute */
> +	if (iio_scan_timestamp_enabled(iio))
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);

Sashiko spotted this one.  The rules are no combining this
with a goto in the same function.  In this particular case I think it
isn't a bug as such, but it is fragile code.

Here I think best option is to do the mutex_lock()/unlock() by
hand.


> +
> +	rc = dps310_get_pres_samp_freq(data, &prs_rate);
> +	if (rc)
> +		return rc;
> +
> +	rc = dps310_get_temp_samp_freq(data, &tmp_rate);
> +	if (rc)
> +		return rc;
> +
> +	data->drain_interval_ms = dps310_fifo_interval(prs_rate, tmp_rate);
> +
> +	rc = dps310_fifo_hold_alloc(data, prs_rate, tmp_rate);
> +	if (rc)
> +		return rc;
> +
> +	/* Drop whatever accumulated before enable */
> +	rc = dps310_fifo_hw_flush(data);
> +	if (rc)
> +		goto err_hold;
> +
> +	rc = dps310_fifo_set_enable(data, true);
> +	if (rc)
> +		goto err_hold;
> +
> +	schedule_delayed_work(&data->fifo_work,
> +			      msecs_to_jiffies(data->drain_interval_ms));
> +
> +	return 0;
> +
> +err_hold:
> +	kfree(data->fifo_hold);
> +
> +	return rc;
> +}

