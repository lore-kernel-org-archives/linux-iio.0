Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18371A275;
	Wed, 19 Aug 2026 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098146; cv=none; b=EaCmA2KwQtuVgS6bMIbAaAKZP3L/mMDlqrf5WAkZd7Y367+YpR3eIR8yzcgWTYcmh5cmEnecdimfPRKjgZ2GKyurT2EGh97kFncXqwxcx51h+8eTFBkygZMA3bLEcKwBzG+aNTqlycmgNlCnH6st6kz2vrJ8uGO90EuJtUOfivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098146; c=relaxed/simple;
	bh=Mnj6CWNgg87eVQ78goOXOZwg1Ro8eym9OrIfPAWKQ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThQ37hZCHkXVH1U4cq1rrr210NUOHhoxLFRZ41NDAnggDmgcFIsqT5yHtwxGPFyH0Z1ej2PFh64rzA8CE+97l61eYndMx/i4yDgC2ycsgqRU9KIFW2Ie3gaFR//FA+CV7c3du7gJq0tzaOkz5m/WxyNGJ0yfo23T5dKdZDCFplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVuVnpjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVuVnpjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E21F000E9;
	Wed, 19 Aug 2026 00:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787098145;
	bh=CbaJWh2tvFXxZ9q6aMHxqjQiIZO8WAh0EA/DsKDi9fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lVuVnpjqmufR6dQVeyD3sVHvsZl8qqe3WWSnYV4sMK1TYr+tjqk4l9mDpOZBwHMH9
	 /2WhUOtQ1bAiT3f0MN7otyt2MZAx+jX+epxc2h4dJNeCAjL0taMA/3FdoAI01dbT+V
	 Zig1M9AJazABzzcN3zRjUJR+kuf2yZUA/3bgoyjFyYYK6bxs7Ua2/3lnSpVL3tv8bh
	 RTf2MFdHWsxfSYNB/iXfmZmFvH8R2al1NF4KppqjSeHvmZzjaM6vwJTDHcxQqucDXF
	 TfUUz3THIniQQph38HP7TtbWqnsJQ80+YEKK55NvpCgeBbokp6EsS4wvnoewmQfGJ+
	 EuvrHmKLXqtRg==
Date: Wed, 19 Aug 2026 01:09:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: accel: kionix-kx022a: unify staging buffer
 and convert to iio_push_to_buffers_with_ts()
Message-ID: <20260819010900.7728cff8@jic23-huawei>
In-Reply-To: <20260818215122.52715-1-grondon@gmail.com>
References: <20260818215122.52715-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 22:51:20 +0100
Gabriel Rondon <grondon@gmail.com> wrote:

> v1 was a single patch converting the two push sites to
> iio_push_to_buffers_with_ts(). Reviewing it, Jonathan pointed out that
> the driver carries two separate staging areas holding the same thing
> (buffer[8] and the scan struct), and asked to fold the cleanup into this
> set.
> 
> So v2 is a two-patch series: patch 1 drops the redundant buffer and
> routes the one-shot read and the triggered handler through scan, and
> patch 2 does the deprecated-API conversion, now with a single buffer to
> push at both sites.
> 
> Changes in v2:
> - New patch 1: drop buffer[8], use scan for the one-shot read and the
>   triggered handler, move IIO_DMA_MINALIGN onto scan (Jonathan)
> - Patch 2 now pushes data->scan at both sites instead of data->buffer
> 
Nice.  All looks good to me, so I'll queue it up.

Applied to the testing branch of iio.git which will be rebased on rc1 once
available.

Note that there is plenty of time for additional feedback, tags or indeed
me to drop it again if someone spots something I missed.

Thanks,

Jonathan

> v1: https://lore.kernel.org/linux-iio/20260818155635.8367-1-grondon@gmail.com/
> 
> Gabriel Rondon (2):
>   iio: accel: kionix-kx022a: use scan struct for one-shot and trigger
>     reads
>   iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()
> 
>  drivers/iio/accel/kionix-kx022a.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 

