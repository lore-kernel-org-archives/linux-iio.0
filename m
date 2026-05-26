Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002B3C583E;
	Tue, 26 May 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814334; cv=none; b=BeQntA0wnIw+wEQ+blnxkJO0+MAqnUZHIGgfWIOXdcnW5W4HHxqnerBSZHNFZRHhEdemJj/6GPXDRmcw3wyUGsmy4WYL4tNI16LtwqP6aH5hjyGX4Unn9ZdfXfd+jxSr4uiDsVLQ71oyZQ4SrxlOZ0vCY4vkiLNFHwtTCfX3XOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814334; c=relaxed/simple;
	bh=QZxeXeV3BvZM9v5CqXMzuMQa/YGAgyhkwcTk5zabydE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKS1QjvTsMGHMPClZYNTg/njzjIbAClUyDIN2sqw3QUXvEUj38HE95wJ7yksiJhfTXq13J/a9iVzzWvN51Pc+6cro0nuTbmxEYna6uhgGIQivwk8oRsRssMGubwd6N5AVetz/IBQrE8UkLjAcwtlr8FVi+AUPB9hucK+XhVXH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuU9UpAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuU9UpAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D2E1F000E9;
	Tue, 26 May 2026 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779814332;
	bh=pLp3hPUPx46n9wxCs/CAIxJS1Cwj7Ei3SenDynoQxzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PuU9UpASdQlcI3WHZFUgkRr8jLKhHeHGDIW+l2N3B1RcNuXFws8ZiDZ4xtyvp2V9v
	 0FSNC51RTdF8qT+vVvVEEXrxxNgjVP769WtzjJSNMHgRejhJged5Y6GnX6BX57LmDK
	 maNHgvEq6b6lkK0Y9hImdCQ3mFhoAqiqsAdUFzVdalWtxueVhLGM08ySyhcih4B6Pi
	 iW0G7whHnwO2QE2wquOMIM+z8xaEHX5nD1oZMK12Akh8BVHeHPXWwavbFH444WG3ZC
	 20jWRQJQatuBt4RpkczQ9gTYGB4yEYrtChd1hgaPTeRfIRReXmtRHkwb191r43iVZx
	 D7xVuqOK9HcZQ==
Date: Tue, 26 May 2026 17:52:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 8/8] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <20260526175203.63631d28@jic23-huawei>
In-Reply-To: <5557d9b9-9869-45ce-9c28-cb24cdb03cda@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-9-aldocontelk@gmail.com>
	<20260526141159.267d9623@jic23-huawei>
	<5557d9b9-9869-45ce-9c28-cb24cdb03cda@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> Hi Jonathan,
Hi Aldo,

Please crop away anything you aren't responding to to help us
focus on the important bits.

> 
> Thanks for the review. I'd like to ask a design
> question about Sashiko's finding on the cached data->enable.
> 
> Sashiko pointed out:
> 
>  > @@ -434,16 +611,15 @@ static const struct iio_info tcs3472_info = {
>  >  static int tcs3472_powerdown(struct tcs3472_data *data)
>  >  {
>  >  	int ret;
>  > -	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
>  >
>  >  	guard(mutex)(&data->lock);
>  >
>  >  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  > -					data->enable & ~enable_mask);
>  > +					data->enable & ~TCS3472_ENABLE_RUN);
>  >  	if (ret)
>  >  		return ret;
>  >
>  > -	data->enable &= ~enable_mask;
>  > +	data->enable &= ~TCS3472_ENABLE_RUN;  
> Does this permanently lose the WEN configuration after a suspend/resume cycle?
> Because TCS3472_ENABLE_WEN is part of the TCS3472_ENABLE_RUN mask, this clears
> the WEN bit in the cached data->enable. Upon resume, tcs3472_resume() attempts
> to restore the configuration by reading this cache:
>      value = data->enable | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
> But since the WEN bit was permanently cleared in the cache during suspend, the
> device always resumes with WEN disabled, discarding the user's sampling
> frequency configuration.
> 
> 
> 
> 
> I see two possible fixes:
> 
> 1.  In tcs3472_powerdown(), clear only PON and AEN from data->enable
>      (keeping WEN as the "user's last desired state"). This is minimal
>      but introduces a divergence between data->enable and the actual
>      hardware ENABLE register, which breaks the simple "cache of the
>      HW register" semantic.

Suspend / resume is one place where it's common to not cache the 'current'
value rather than the value we expect after coming back via resume().
If you do go this way that field should not be updated at all in suspend
because we will need it's full value in resume.

Sometimes people have a second cache for just this case though. Maybe
that works here. It would I think be the whole register rather than
just the flag you have in option 2.


> 2.  Add a separate field (e.g. bool target_wen) that holds the user's
>      desired WEN state, set in tcs3472_set_sampling_freq() and read
>      back in tcs3472_resume(). data->enable then strictly remains a
>      pure cache of the HW register.
> 
> 
> With solution2, the functions would behave as follows:
> 
>    - tcs3472_set_sampling_freq(): when activating wait state, sets
>      target_wen = true; when disabling it (frequency too high), sets
>      target_wen = false. data->enable is then updated to match what
>      is written to the chip.
> 
>    - tcs3472_cycle_time_us(): reads target_wen instead of
>      (data->enable & WEN) to decide whether to include wtime_us in
>      the cycle. This avoids reporting a stale wait time during a
>      suspended state.
> 
>    - tcs3472_powerdown(): unchanged in semantics clears PON, AEN
>      and WEN from both the chip and data->enable. target_wen is left
>      untouched, since it represents the user's wish, not the HW
>      state.
> 
>    - tcs3472_resume(): rebuilds the ENABLE value from
>      PON | AEN | (target_wen ? WEN : 0), writes it to the chip, then
>      updates data->enable to match.
> 
>    - tcs3472_probe(): initializes target_wen from the chip's current
>      WEN bit (read at probe time).
> 
> Solution 2 feels cleaner to me, but it adds a field and a bit of
> synchronization between target_wen and (data->enable & WEN). Do you
> have another approach in mind?

As long as it ends up easy to follow I'm not that fussed what solution
you use.  Both of these will work.  It does slightly feel like caching
the value we want on resume for the whole register might be the simplest
path but I haven't tried coding it up so may be missing something.

thanks,

Jonathan

> 
> Thanks,
> Aldo
> 
> 
> 
> 

