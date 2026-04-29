Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0138A733;
	Wed, 29 Apr 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459323; cv=none; b=nZRtjPaHilp3ugEGHytJlqQK9kVTGKF6IZS4z7Tls6HbNDbs3TQDpAEu2NT5mLMgzln+1jgFanWujNWnu3fl2SUZpAXySLqOgDSfdTuQmfSUxhkOV/cWu/86035KlHDdEdlfLhTxRPPvJw6oKdQj1mzt3vmc3Bs58XrG87O0s68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459323; c=relaxed/simple;
	bh=Tf6+Uzfssxp80uDesm9s+S2d/u0HH6sMNvpDHDrSsjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeO4mLHR3DIHJzwvi/ieBRW+btKPiUYZ2WHv/16TroFHeY/9v+hqUBIIr1UNweH+KFztbqYfxXAMhed+ToJQPeeTWoRrEn320lHRvGqG1aKRt0DtGJZHiN0DefMuokhdBRRAYNo0X4NjR2NTBbpXd6HC5Ovngjwb49ROP66EIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZETgeQMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZETgeQMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCDAC2BCB3;
	Wed, 29 Apr 2026 10:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459322;
	bh=Tf6+Uzfssxp80uDesm9s+S2d/u0HH6sMNvpDHDrSsjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZETgeQMYqPflL9NXO6haPkUhYv1jhloimGXCFtFT1Mf2f8aTvYzucypiwiyScpNLZ
	 UxKDUKzirRTw8btgFWSvM2yV0lr3GFc0wvIXhDRSOtQ4BL6u4wTKH99ouCcsJu30a7
	 LHXhNeD7gDpNTBZ0veMuh4/l8NrGf5cYl3eFWjJqvGsTPRL/eXd67FA/QqYlaguQcs
	 CDilSgXQMFu2nEuOmNUhHDCQ0Ul8Yfx4mwr5/0W6DySl2fsJl5/00ZJHONJVlzD/Kr
	 NEMPy2Uc00tNndc2IOSabxwEsfHDpYt8cWKk73ClBIOnGfCCtkF8ZOdF03sqUyl2qT
	 qO6WBwA+ZrBhA==
Date: Wed, 29 Apr 2026 11:41:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <20260429114154.290e588d@jic23-huawei>
In-Reply-To: <20260428222600.91322-1-m32285159@gmail.com>
References: <20260428222600.91322-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 17:26:00 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Replace mutex_lock() and mutex_unlock() calls in rm3100-core.c with
> the more modern guard(mutex)() family. This will help modernize the
> driver and bring it up-to-date with modern available macros/functions.
> 
> While replacing mutex_lock() and mutex_unlock(), the critical sections
> of rm3100_read_mag() and rm3100_get_samp_freq() have been extended to
> include negligible operations for cleaner logic.
> 
> Add new helper-wrapper function rm3100_guarded_regmap_bulk_read() to
> help keep rm3100_trigger_handler() switch-cases clean while maintaining
> mutex locking and avoiding re-entrancy risks from potential callbacks.
> 
> While at it, remove redundant gotos where applicable, and use direct
> returns instead.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Hi Maxwell.

The use of the helper worked out well but it also made me look
at some existing code and wonder why it is so complex!

>  static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -468,11 +481,10 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>  	struct regmap *regmap = data->regmap;
>  	int ret, i, bit;
>  
> -	mutex_lock(&data->lock);
>  	switch (scan_mask) {

>  	default:
>  		for_each_set_bit(bit, &scan_mask, mask_len) {
> -			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
> -					       data->buffer, 3);
> -			if (ret < 0) {
> -				mutex_unlock(&data->lock);
> +			ret = rm3100_guarded_regmap_bulk_read(&data->lock, regmap,
> +							      RM3100_REG_MX2 + 3 * bit,
> +							      data->buffer, 3);

Hmm. Not one for this patch, but the only reason this doesn't
hammer the lock is the bitmap is one hot.  Which is why the read is always to the same
location in the buffer. That could have been a lot easier to spot if instead
of a loop find_first_bit() was used.

I don't think we can ever get here with no bits set but maybe check that as well
(it's not supposed to be possible as doesn't make any sense to measure nothing ;)
 




> +			if (ret < 0)
>  				goto done;
> -			}
>  		}
> -		mutex_unlock(&data->lock);
>  	}
>  	/*
>  	 * Always using the same buffer so that we wouldn't need to set the

