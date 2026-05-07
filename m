Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACC3E9295
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171067; cv=none; b=TRebk/PccblrVcrHnPWogIW+352IaoXxTAKzAvMzyEOkfuB1E27lmKnZ738yR5RVmDNzoxGVhPokwp6XKnwA29iF9FyxhspLD81pP3MGu6dr3mDibSWNYgoggWl8aFfcPqv7aEqIAk4aX7my356NJ84siNe7OLPyxOn5QqVDrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171067; c=relaxed/simple;
	bh=X9yYqlWI5SeImxElCHURSfPHWQvcYKbZB3+sq+23AeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksl7cpOP8dUwzZEU9thAMzrHhv0MObUqNlTDH5Ggy7aXQ9T5xpRr8KxLYZMoYmkp+m1E9b5siwclUQv88wjnEc/vXS7Vn65SsJWKUv2eZWUHdS6CR0OEenGfMY+/T31VJ8o/UZ/VNJkEZDSbsYbGw/WuGeu/49RL7qlyor7DPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJiWizZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJiWizZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4F0C2BCB2;
	Thu,  7 May 2026 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778171067;
	bh=X9yYqlWI5SeImxElCHURSfPHWQvcYKbZB3+sq+23AeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJiWizZAXpvAlJVg0fi7Hq8D8ix5/PjG13q7X7hBwfIGXr1JZL7sYdbyKVWsR79L5
	 aHaylsTA+NOUKbxKn7rU4oOi45zEwzxjfADRhUsAJz1odh6N16ChBRvT2Q4lvSCQlH
	 CGU83vZM13V70OpxWLPaeBNwZaVkd9X/gv6JHWZHNz16bwQZ9MyViE22b+MIquFEkF
	 dii4Hhq2e+RPw2NpgXbq0pesc5LKxzg7wHxaYuQCE71+MQTCW14TycIv6rqt8ac04e
	 u3rJNKQ7kOEhqaj5v8irjEQ/NmxRGZDtXpZoED/DCz+lzmIVvRo8p+Hs1wUgFybQlg
	 vbN5u9D/pHzdg==
Date: Thu, 7 May 2026 17:24:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Educg550 <educg550@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 antoniu.miclaus@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Lucca Ciriac <luccaciriac@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4377: replace mutex_lock/unlock with
 guard and scoped_guard
Message-ID: <20260507172420.527469b8@jic23-huawei>
In-Reply-To: <20260506144359.16744-1-educg550@usp.br>
References: <20260506144359.16744-1-educg550@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 11:43:59 -0300
Educg550 <educg550@usp.br> wrote:

> From: Eduardo Guedes <educg550@usp.br>

Read submitting patches, particularly about how to send a v2.
Should be [PATCH V2]
> 
> Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex) and
> scoped_guard(mutex) from cleanup.h.
> 
> Using guard(mutex) and scoped_guard(mutex) from cleanup.h allows the
Andy pointed out in another review earlier that it would be clearer to
refer to guard(mutex)()

For scoped_guard() if it were used I'd use scoped_guard(mutex, ...)
to refer to it.

> compiler to enforce lock release on every exit path, eliminating the
> error-prone manual lock/unlock pattern and the goto-based exit labels
> that existed in adf4377_get_freq() and adf4377_set_freq(). This reduces
> the chance of lock imbalance bugs.
> 
> Signed-off-by: Eduardo Guedes <educg550@usp.br>
> Co-developed-by: Lucca Ciriac <luccaciriac@usp.br>
> Signed-off-by: Lucca Ciriac <luccaciriac@usp.br>
> ---

There should be a change log here.  Otherwise just one trivial
request inline for v3.

>  drivers/iio/frequency/adf4377.c | 80 +++++++++++++++------------------
>  1 file changed, 35 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> index ff6077e29..f91b9c6e2 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c

>  static void adf4377_gpio_init(struct adf4377_state *st)
> @@ -919,13 +912,10 @@ static int adf4377_properties_parse(struct adf4377_state *st)
>  static int adf4377_freq_change(struct notifier_block *nb, unsigned long action, void *data)
>  {
>  	struct adf4377_state *st = container_of(nb, struct adf4377_state, nb);
> -	int ret;
>  
>  	if (action == POST_RATE_CHANGE) {
> -		mutex_lock(&st->lock);
> -		ret = notifier_from_errno(adf4377_init(st));
> -		mutex_unlock(&st->lock);
> -		return ret;
> +		guard(mutex)(&st->lock);

Slight preference for a blank line here as the we don't have the same need
for closely associating lock and action as we did with the original code.

> +		return notifier_from_errno(adf4377_init(st));
>  	}
>  
>  	return NOTIFY_OK;

