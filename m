Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE19371872;
	Sun, 15 Mar 2026 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773602021; cv=none; b=gALEsHgHKcn7czkuZh6v3ondhZrND7ImzDw98e5gchNVViZ3x3B8K5XmInMpZ/W2T8q+FwKYhBa74BmqopgnaVt6NjiKr/BLLDyZeLHstNXrCH1D2TYVxtP8MFHwJiEIvyi8jmL9rQQRLa7lHOTl/MC9G+T1qvPLrFNVj+MYdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773602021; c=relaxed/simple;
	bh=6y4V987sFf3g3BKrVUpehlZXVaawe8cmVcwN5ll4zAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNj3ptWjw7WfHM5SG+kc5FW7dRHffCtQnRqLVa4lGofT11qPUCsLBciylaodFqrxaO8hYIqmOyxjvJS5/ZKmw70R4sJa85SHOnTYssaU8AsLx3oTUFaxSIi5IbGmDdnRPkJ1TW/ZvbjMIzslGOyNsIrf2P/ysU7mKr6ppa8aJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNssOypK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNssOypK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1AAC4CEF7;
	Sun, 15 Mar 2026 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773602021;
	bh=6y4V987sFf3g3BKrVUpehlZXVaawe8cmVcwN5ll4zAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sNssOypKp6eM7bTdTikRkx5ts6ErCoPik1se0FMx589zTp5Mk8sM7bT2/ZwfmFQwB
	 iXlMN8Dqeg9JPcfuc8BTkPfMVEjXzfDdPRkmBzSigHQf4V2ATdAhM4H/+OgY8YpT30
	 4jrXDJddQDQGSffKzofKluVWjruEPcKD3bTSVwWPROw9/Mi1MpL5sNPY6i2NJeEIAL
	 ssEA/4rer5+oa+4SXs4boEYVHzSEzRBMA2CLJFXSG9YHyd/S/M4Tg36PHgTHisVSyN
	 I9OE/CvVMtueFruDGnmnFtfSzSVsh3c1vSYVpD1/ZHCjttFACCRzK/qfNeQW19UPRW
	 nWDpmPJ8CwKEg==
Date: Sun, 15 Mar 2026 19:13:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 waqar.hameed@axis.com, linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: accel: sca3000: convert to guard(mutex)
Message-ID: <20260315191331.7a604ce8@jic23-huawei>
In-Reply-To: <20260314170609.26827-9-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
	<20260314170609.26827-9-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 22:36:09 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> sca3000_print_rev(), sca3000_ring_int_process(),
> sca3000_read_event_config(), __sca3000_hw_ring_state_set(),
> sca3000_hw_ring_preenable(), sca3000_hw_ring_postdisable(),
> sca3000_clean_setup(), sca3000_stop_all_interrupts().
> This ensures the mutex is released on all return paths and
> allows returning directly without a goto label.
> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Hi Rajveer,

The discussion about time to review these is particularly relevant here.
Unless I'm missing something you introduce a deadlock and more radical
surgery is needed to avoid that.

Jonathan

>  
>  /**
> @@ -1313,26 +1304,20 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
>  	int ret;
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	/* Enable the 50% full interrupt */
>  	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>  	if (ret)
> -		goto error_unlock;
> +		return ret;
> +
>  	ret = sca3000_write_reg(st,
>  				SCA3000_REG_INT_MASK_ADDR,
>  				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
>  	if (ret)
> -		goto error_unlock;
> -
> -	mutex_unlock(&st->lock);
> +		return ret;
This smells interesting... The scope has expanded.

Deadlock I believe as the guard() hasn't released here before
the one in __sca3000_hw_ring_state_set) tries to grab the same
lock.

The obvious fix would be a precursor patch to update the locking
so that doesn't happen.  There is always a dance where the lock
is released before making that call (or taken after it) so just
make it __must_hold() for the lock and don't take it again internally.


>  
>  	return __sca3000_hw_ring_state_set(indio_dev, 1);
> -
> -error_unlock:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
>  }


