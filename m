Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472F33D6D9;
	Fri, 20 Feb 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583678; cv=none; b=QrQIpVqjK0aMOfB35a++acVhaSqv9VgULJRfJLj7WfKxxRZelOcaJW1U95m2qR+cIgtdZzgrJQCxAzRxQ+EFFDFlqD9Nbaae1ANpFKmG8abuUFncJoYSwdiulUDyTL92WT/+N02God0pN2cZQwA/dzkvs4rJYuAVsyeogmNTlfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583678; c=relaxed/simple;
	bh=dilljmh9dxZAZlFk4CljcED6GqqwrUnU7lDGO7nV9Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8sIf9YDaM4hvVKqsOG67MGJHXKNiyiKoX9V8c9BEQemLCFGW04H0UgKMa5Rxtaq5NfeoOPxwCH8lEmMWCgWjGizCGQW2cN+A3pLDvvMemPlWfK3x9J4qCdlffG2P9w2uNHs38nSBM9ldE5+ZAg1teqKoRJuGSTVBe8iMQtTQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjTb4VFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjTb4VFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09ECC116C6;
	Fri, 20 Feb 2026 10:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771583678;
	bh=dilljmh9dxZAZlFk4CljcED6GqqwrUnU7lDGO7nV9Ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XjTb4VFYc8mNoUEOd8eMwmELvbae5hDpirpatOlZf0Ow6o30euNEogC5R2/zBSoHJ
	 rwUqL1/wSeu6UjS3OV0WQ1ze/eWllFESucOaIM5XxtlE2pypvHpUiG1fFiAqLKCTYK
	 wbuYa5SV3Fqq2V1cWiDJIb5Wd8UZGK4uwk+DSSRsLNG4TJcVsjxlF2Dp8BJJawAAiI
	 PIiIcoXUc3k6fliybcpCMeNcb6s4Rjz+0RrQrSiL1LtMom2PmSStEJTeCJriXwT5Jc
	 eBacBhI208QlSKge/zazBRHe3+2MPf0kqkSzCezAIjpjAS1WcFMQxqGRXf9KhfAz4i
	 VN2HLfKcezTJg==
Date: Fri, 20 Feb 2026 10:34:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <20260220103429.22c9eeca@jic23-huawei>
In-Reply-To: <aZLWVcdoKrI_ICD2@smile.fi.intel.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
	<20260216015454.61836-2-neelb2403@gmail.com>
	<aZLWVcdoKrI_ICD2@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 10:33:25 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Feb 15, 2026 at 08:54:52PM -0500, Neel Bullywon wrote:
> > Use guard() and scoped_guard() to replace manual mutex lock/unlock
> > calls. This simplifies error handling and ensures RAII-style cleanup.
> > 
> > guard() is used in read_raw, write_raw, trig_reen, trigger_set_state,
> > suspend, and resume. Case blocks using guard() in read_raw and
> > write_raw are wrapped in braces at the case label level to ensure
> > clear scope for the cleanup guards.
> > 
> > scoped_guard() is used in remove and runtime_suspend where a short
> > mutex-protected scope is needed for a single function call.
> > 
> > The trigger_handler function is left unchanged as mixing guard() with
> > goto error paths can be fragile.  
> 
> ...
> 
> > -	mutex_lock(&data->mutex);
> > -	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
> > -	mutex_unlock(&data->mutex);
> > +	scoped_guard(mutex, &data->mutex)
> > +		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);  
> 
> Wonder if we can move this to a helper:
> 
> static int bmc150_magn_set_power_mode_locked(data, mode) // locked or unlocked, dunno with proper naming
> {
> 	guard(mutex)(&data->mutex)
> 	return bmc150_magn_set_power_mode(data, mode, true);
> }
> 
> ...
Whilst it involves taking the mutex in probe() before it's strictly
necessary (as everything is serialized anyway until we register the
userspace interfaces, I wonder if a simpler option is to rely on the
mutex_init() being early enough and just put the guard unconditionally
in bmc150_magn_set_power_mode()?

The snag is in runtime PM.  The locking in there is really odd
(smells broken to me)
It requires the lock to already be held for resume, but must not
be held for runtime_suspend.  Superficially I suspect this only works
because the autosuspend delay gets us past the unlock in suspend path.

I think we can unwind that mess though by changing read_raw() to
not hold the lock across both power and reading phases (I don't think
it matters if we drop it and grab it again in quick succession as
read_raw is never really a fast path).

The usage of runtime pm in buffer_preenable / postdisable should be
fine but at this point I'm getting nervous.  Neel, do you have the
hardware for this one to check we don't break anything trying to clean
this up?  Or does anyone else who is willing to test any changes?

Jonathan



> 
> > -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> > -					 true);
> > -	mutex_unlock(&data->mutex);
> > +	scoped_guard(mutex, &data->mutex)
> > +		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> > +						 true);
> >  	if (ret < 0) {
> >  		dev_err(dev, "powering off device failed\n");
> >  		return ret;
> >  	}  
> 
> Ditto.
> 
> 
> ...
> 
> >  {
> >  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> > -	int ret;
> > -
> > -	mutex_lock(&data->mutex);
> > -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> > -					 true);
> > -	mutex_unlock(&data->mutex);
> >  
> > -	return ret;
> > +	guard(mutex)(&data->mutex);
> > +	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> > +					  true);  
> 
> Ditto.
> 
> >  }
> >  
> >  static int bmc150_magn_resume(struct device *dev)
> >  {
> >  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> > -	int ret;
> > -
> > -	mutex_lock(&data->mutex);
> > -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> > -					 true);
> > -	mutex_unlock(&data->mutex);
> >  
> > -	return ret;
> > +	guard(mutex)(&data->mutex);
> > +	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> > +					  true);  
> 
> Ditto.
> 
> >  }  
> 

