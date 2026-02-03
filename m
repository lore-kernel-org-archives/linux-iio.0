Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E13939AD;
	Tue,  3 Feb 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107910; cv=none; b=O3e69eTr6QSMZSg7EbnrgIDmNPLKFAxh1sLlbUoaUomnMuYnrMImolhhHyiDcBITTPqzvU0IjiFdpIEBSmBrZcLFJOT9WNvrLHf6mFjmtrNjOIaB2Uv4YxnCtVM0JddNjrf526XUcf2rdVaPKMh6F1w3is43p2NH2XpcL1ktnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107910; c=relaxed/simple;
	bh=O7q0p/stHJlGCwoY+Z+Ii+wd8alWE91E5KapukAsL3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFMkeqqzmrV35/m+erSJOvlOeldlKJW1caB5hK/nCuC8/BOAjLRPd0tKKAcw5u8A2Cr/4olFO2Yctlu3ADOsbRACHbM1MiwAZSeQq5Gfs6VbXY7IseEEejOoOx++EIrxtceAjjLbZjjZdKNlDTgXuQVVVCoyi+FnEVT4sQpW4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HveZUoK0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDEHbRdp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HveZUoK0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDEHbRdp"
Date: Tue, 3 Feb 2026 09:38:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770107907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AsnHZfxppy0eLXJWZx52zfVzn6o0YLk/JnQ+ImKdEI=;
	b=HveZUoK0D0J5XbvJEvQNFsShQa3ZIWzGpv2TKwLTzUwIjjbKNJntnTJmAsvceEY2s8zT2U
	8RmwZaMexEK/krZ+9aZ4xC0BPdaIwXVPeJIgU8q16cVuXx1wK7WqMfdkiUyUwrmvzu8keo
	wUS4elfoXcSsg6J4K0HAwQyNh3i/55JWjWy23wsfFBWFZziDJ44NQFIdVqXGzebkiIXdEW
	M+ZmnNVVeniKp7YIrU4gsVkp7SJnm0ug9Ebm58typA36agip/dvctBlH9CYOHuETqwBcoI
	0cgZfi27wur3qaJq6EKsHZEeVm2hq0Y9zJHaPGm4r79VMSNMV1uLyGe2ZXc4zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770107907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AsnHZfxppy0eLXJWZx52zfVzn6o0YLk/JnQ+ImKdEI=;
	b=LDEHbRdpm/vnYbmkMH4Grc856++CmZytBnzbOgsZiBoC7KoqtEcu5jEbNs+4jEzW/VL/3X
	RI4tmXNY25klf0DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
Message-ID: <20260203083826.1gOzxrwt@linutronix.de>
References: <20260113120541.YVf2vRA3@linutronix.de>
 <20260202232741.13380-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202232741.13380-1-spasswolf@web.de>

On 2026-02-03 00:27:40 [+0100], Bert Karwatzki wrote:
> 
> The warning appears because iio_triggered_buffer_setup_ext() (in 
> drivers/iio/buffer/industrialio-triggered-buffer.c) is called with thread = NULL
> during the probe of the iio device and calls iio_alloc_pollfunc()
> (in drivers/iio/industrialio-trigger.c) with thread = NULL and type = IRQF_ONESHOT.
> 
> A simple fix could be this:
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 9bf75dee7ff8..40eea3a44724 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
>  
>         indio_dev->pollfunc = iio_alloc_pollfunc(h,
>                                                  thread,
> -                                                IRQF_ONESHOT,
> +                                                thread ? IRQF_ONESHOT : 0,
>                                                  indio_dev,
>                                                  "%s_consumer%d",
>                                                  indio_dev->name,
> 
> 
> Are there any problems with this?

Urgh. Haven't seen those.

Looking at all the users of of *iio_triggered_buffer_setup*() the
primary handler is either NULL or iio_pollfunc_store_time(). 
So IRQF_ONESHOST should work all the time.

Then there is 
- drivers/iio/adc/vf610_adc.c 
- drivers/iio/common/hid-sensors/hid-sensor-trigger.c

They use iio_pollfunc_store_time() as primary and have no secondary.
This would trigger the warning but not having a secondary handler while
returning IRQF_WAKE_THREAD should create a warning of its own.
What did I miss?

> Bert Karwatzki

Sebastian
