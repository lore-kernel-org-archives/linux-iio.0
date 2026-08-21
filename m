Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F7390998;
	Fri, 21 Aug 2026 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356608; cv=none; b=dfDZXCKYHPnYdgTV4EKZBi6t5T2N2qfkwz35lJfx5X+oi1GX3lYnatFReSaaw8Gw9X/ABIsTbFWFYWHDe6zXWcaX9TZwPZqFzpYq9nyxwu1xfmPzQu8RrAFMBCd5jOaR/smQpHMZtSXWpSrC1CWaENqa5gmQUJTUjV130pNsDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356608; c=relaxed/simple;
	bh=/ZZaHPJH1breKjbJyIPSbsojn9eFmqLhxvzfttSZ5Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+LY0Drzm0CqSdfQQyqJRV0rMfuSWznclVbPwzDETMLx3sAooX8bzjhIiMC46XnPV205Z9fnwbXH0mOzEb++aQv42AtM1VPnhkCiS+hwx6IFZneRUNJjmztE9zSYA0efxiwN3mDqjsWaCrZSnHztsgfa5W0iVkOqUZgdel7s1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dATDvDme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dATDvDme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262F91F000E9;
	Fri, 21 Aug 2026 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787356605;
	bh=IN1zS/DZj8U8f8gQQwP/X03x7w86btnpkE/R1mcRfk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dATDvDmelHBCX0M/N8Yc7x7iS5Bdt7iU5+yV3EXLSo3j/EOEyn8h6NmWvifImrAaB
	 w3o1xT7pOb9cfaMlIV7R4Pm6OuYzcFF77vLdoxH/FUbjx2la7/SVj7dpmDgflqZXyE
	 oPtM9EOlyPe036Ajn4Lcx+J6wYufBRd47VS6EEuFDJQVgUB/Qd+ZyFr91fHHo8g7KI
	 E7+j/hAm3j9SjyQ8nU0nRp+7ZhMb+NZGpQ6ezWK/bzz34TM+LV6uiZ3WLeROm7jRKz
	 1oP0bfJ+kEFzOZE6+kE77PvPAqnFk4YxMeTLglLlXSfFueeVXDaLz0RbnTsyFoyx6h
	 Ufslxi5aNXpmw==
Date: Sat, 22 Aug 2026 00:56:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: use iio_trigger_poll_nested()
Message-ID: <20260822005639.539ccf9f@jic23-huawei>
In-Reply-To: <20260817024023.291319-1-fanwu01@zju.edu.cn>
References: <20260816184602.2dd023f6@jic23-huawei>
	<20260817024023.291319-1-fanwu01@zju.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 02:40:23 +0000
Fan Wu <fanwu01@zju.edu.cn> wrote:


> The threaded IRQ handler queues an irq_work only so that
> iio_trigger_poll() can run from a hardirq-like context.  The driver's

A lot of spaces before that The!

> own buffer consumer does not need that context: the only thing a
> standard IIO pollfunc top half does is store a timestamp in

Call out what function is.  It isn't obviously a 'standard' even
though there is only one that anyone actually uses.

> pf->timestamp, and deferring through the per-CPU irq_work queue moves
> that timestamp further away from the actual event.

This should mention in passing the possibility that this trigger is
being used to trigger capture on another device that is relying on
that pollfunc timestamp.  Then add something about that being considered
unlikely because there are few uses for synchronising data capture
between a light sensor and any other sensors.  Something like

"Whilst in theory there can be other consumers of this trigger relying on
 the pollfunc top half running, given this is a light sensor those are
 considered unlikely to exist in practice."



> 
> The device IRQ handler is already threaded, so call
> iio_trigger_poll_nested() directly from
> gp2ap020a00f_thresh_event_handler() and drop the irq_work, its
> callback, its init and the irq_work_sync() drains added by the
> preceding use-after-free fix.

We don't need all this detail in the commit description. Something like
"
Switch from irq_work to direct call of iio_trigger_poll_nested().
Remove now unnecessary irq_work related infrastructure and ensure a
local time stamp is acquired.
"
Covers the key stuff from this paragraph and the next.

> 
> As the trigger is now dispatched via handle_nested_irq(), a consumer's
> top half no longer runs and its threaded handler executes
> synchronously in this device's IRQ thread.  For consumers still using
> iio_pollfunc_store_time() this means pf->timestamp is no longer
> populated; a consumer that needs a timestamp should take it locally,
> as this driver now does in gp2ap020a00f_trigger_handler().
This hints at the possibility of other consumers - I'd call that out
above.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

> ---

Down here add a note on the dependency so I don't forget about it!

Patch looks good to me. For v2, don't reply to the earlier patches.
That can rapidly get very confusing, so for IIO (and most / possibly
all of the rest of the kernel) separate threads preferred. Ideally
include a link instead to earlier versions as part of the change log.

Thanks for tidying this up!

Jonathan
