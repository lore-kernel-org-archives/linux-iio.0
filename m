Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0C3DA7D0;
	Mon, 16 Mar 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685192; cv=none; b=Co/DCNWAK7Odt2LOtI5QlbnMTWaH4bxFnTrqVEcJrXkieeZsVMj7zBfUnHSpX2Ui1ZSvEQOIgw8JNBc3Y0klOUMOr4L7OYIz3lGFml9gyIqOIUmzj1Q/jmm5n2IshgO2+IxxLSi5q04GyMZ4pXtinHwdxJcas1MsT2HsPyJ8F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685192; c=relaxed/simple;
	bh=JrJ9V8x3pv8ULIUDHCvmWXLQ4z8CDQitSJVVphqnrsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEi81JhX91MdyvcqYEW2jlPD9O9nXtWkRJ7sP1cX+Oli6KNz/AjG5hVKLi2q5JMm9eBJouU0gVvdBPzW0ORKZRXaMr9llswX8bb/JeJcLIg52fOsKUvrQ+qnnCadv/huqe9mO4v4fCJuO6oJ7KHHSf4eOsYVyuDfQpEqxgQAvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MujzlBp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MujzlBp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12529C19421;
	Mon, 16 Mar 2026 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773685191;
	bh=JrJ9V8x3pv8ULIUDHCvmWXLQ4z8CDQitSJVVphqnrsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MujzlBp790haGqgl1TrlG2xPIa0zcK8vaK4Ioi/noe/uHx4j0CYgQ5ApolCnyjijZ
	 JdA1rbBkMQiYPxY0+gqez+nzk7koNbuL/Nvjulshu0zWzvIU3t+w20jh6evhABF+6i
	 JYW12YOcNhcX+jq8HZIf90OZaUbMzH2thbHh3nfGPMZqrKUiht5DJa+SeQ+Lt5muMe
	 StQ6YvibGvIxpwgHLSTOZjn/Ep8gZSQD66DorfJvQK6yqDiVa+4o1UNWMkubBDHe6c
	 zUvhI86fgVFEK+HxmR4zH8+nEzh7YkwXDVunPapfrDOlJ7jK7otaR4W95cNZGomsw6
	 eexZWYkvDymkg==
Date: Mon, 16 Mar 2026 18:19:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Atharv Dubey <atharvd440@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iio: ad_sigma_delta: replace deprecated
 iio_push_to_buffers_with_timestamp()
Message-ID: <20260316181943.50acd1a3@jic23-huawei>
In-Reply-To: <20260316172735.11430-3-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
	<20260316172735.11430-3-atharvd440@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 22:57:27 +0530
Atharv Dubey <atharvd440@gmail.com> wrote:

> iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
> iio_push_to_buffers_with_ts(), which takes the buffer size as an
> argument and helps avoid potential buffer overflows.
> 
> Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
Hi Atharv,

Thank for you for your patch.


> ---
>  drivers/iio/adc/ad_sigma_delta.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 7852884703b0..73f3069da987 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -636,7 +636,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	 * once, there is no need for sample number tracking.
>  	 */
>  	if (sigma_delta->active_slots == 1) {
> -		iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev, data, sizeof(data), pf->timestamp);

What is sizeof(data) and why is that the right value to pass as the new parameter?

>  		goto irq_handled;
>  	}
>  
> @@ -662,8 +662,8 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  
>  	if (sigma_delta->current_slot == sigma_delta->active_slots) {
>  		sigma_delta->current_slot = 0;
> -		iio_push_to_buffers_with_timestamp(indio_dev, sigma_delta->samples_buf,
> -						   pf->timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev, sigma_delta->samples_buf,
> +				sizeof(sigma_delta->sampkes_buf), pf->timestamp);
Likewise. What value does the new parameter take?

I'm not going to review any more of this version of the series given these are
both incorrect in the first patch.

Jonathan

>  	}
>  
>  irq_handled:

