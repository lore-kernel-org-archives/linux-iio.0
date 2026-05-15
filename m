Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A43CC7C5;
	Fri, 15 May 2026 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854426; cv=none; b=ICj53wMeVF6/GVIlzBbSBm3t5vouSo84ezZ4XxmPVjN+30SYY/bstCJY7rvYtbHZDIQxakFQ82YKo9ck9WvxB6hbfEe+zftnDGQtvC3yYEVTALUZMCXbITaFoDOKlsYUo3ZmAoC/waWORxiKPMfJIUQPP4jVg3+2jbdbYAvxNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854426; c=relaxed/simple;
	bh=tS1kqdYdrQCmfjOyA0ydX6lOpFCcu4ctaNTGFnFAoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riat4KUGKnHuT1rMyWa+wSd8GVGVShFZmfaqysJEnW/88TYsK52BPAavDh6xsCjN9mW7iuyqV7QAhsw2VAfuMvR2pQ6SA37m0En0y6YKeM1igK6lzy/iW7+qprOQqoEHNkFJPMZhgdLbum4q3LGXQBs6xKR+qH7aZ16GwFoeT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUZt9v+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUZt9v+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0432C2BCB0;
	Fri, 15 May 2026 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778854425;
	bh=tS1kqdYdrQCmfjOyA0ydX6lOpFCcu4ctaNTGFnFAoMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BUZt9v+R6Zx0TPkBRa76ke7p9Qy8Phy2UHMVEJXcQTfmYHZ2snf7U5vhchL0LSeeh
	 pJdzLIMFrrrr2q577V/kApPKKbVXLroUbWtLH+ta1/DJq8c3XxXyUQ7nM0n+S9PZHM
	 b9V2UT5tzYbCaXVTAZA2K/a4dxzUXlBoVCSbFZtVeR54+IMSgpZVSWTg6BL+46Cv7z
	 tHxBtzu1dQaRx/4qfsFmZv6Xajijs1xGrB0o6Ru9YbLtk7TOzsrLtaUPvriJUigOZu
	 7mkC5W/QFFQk9PF816wmYbLQJ15RI9GcN+IhSbABPlX2JMEpuFT77heL+1cyY7GAbk
	 7V8GP6ed/10eQ==
Date: Fri, 15 May 2026 15:13:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: chemical: scd30: Replace manual locking with RAII
 locking
Message-ID: <20260515151338.74a1ce81@jic23-huawei>
In-Reply-To: <20260515002603.19240-1-m32285159@gmail.com>
References: <20260515002603.19240-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 19:26:03 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
> 
> In addition, minor refactors in control logic to remove gotos where the
> guard(mutex)() calls would be used, and replace the "?:" operator with
> regular if/else returns.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
https://sashiko.dev/#/patchset/20260515002603.19240-1-m32285159%40gmail.com

It caught the main issue. Given that is a fairly common bad pattern
I might have noticed it. But then maybe not. Another win to the bot ;)
> ---
>  drivers/iio/chemical/scd30_core.c | 53 +++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index a665fcb78806..a24c95874fd3 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c

>  
>  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> @@ -590,19 +598,16 @@ static irqreturn_t scd30_trigger_handler(int irq, void *p)
>  	} scan = { };
>  	int ret;
>  
> -	mutex_lock(&state->lock);
> +	guard(mutex)(&state->lock);

I agree with sashiko here (I might have noticed) that it is in appropriate
to extend the lock scope so far. In particular over the iio_trigger_notify_done().
Depending on exactly what happens in there we might end up with a deadlock.

For this one I'd factor out the reading code and memcpy + lock into a helper
- you can use guard() in that safely without expanding the scope and keep
to the goto pattern for the outer function.

Or just leave this one alone as too complex.

> +
>  	if (!iio_trigger_using_own(indio_dev))
>  		ret = scd30_read_poll(state);
>  	else
>  		ret = scd30_read_meas(state);
>  	memcpy(scan.data, state->meas, sizeof(state->meas));
> -	mutex_unlock(&state->lock);
> -	if (ret)
> -		goto out;
> -
> -	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> -				    iio_get_time_ns(indio_dev));
> -out:
> +	if (!ret)
Very rarely will I be happy with a change that flips from having the
error path out of line to one where the good path is out of line.
If you do decide to change this one via a helper, keep the goto pattern
for this error handling.


> +		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +					    iio_get_time_ns(indio_dev));
>  	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;
>  }

