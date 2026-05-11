Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532063ED132;
	Mon, 11 May 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506466; cv=none; b=lL/T0D3NqO6W+GWaXgcoVaIYoglOVDp7LxYSF0zEiZKXrSJuWgWpykxjdkzIyaVtgevijmHXutM+c1IzlpsuiDVJ2NkiYxl24RUXCO53ctnaEEa8N+zPW68iAwwktduyQERr314XcDCsh9+JnGPawovBZDkbs7FOUNtI3R/kYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506466; c=relaxed/simple;
	bh=oyonFvyhJCEjLycQc7Z8CWcHApR8XON1Ttn6XgAYzZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBbw7cLMPc/H8uVancNEqXov87EOiFzGwCsl3VOVkxpzlr7cCrmmQ1QX/ra7l4XGRSqXPA1pnpkVe0PZWQigDrqSz5oPLHt//mzOAwJQRaSbZwIqTZ8uloPNSTuWDXpNkQOyBX/WkLi5R2J9tOzE0bIg8fDaYinJGiv2ZP+avvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiXFXrV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiXFXrV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3544DC2BCC9;
	Mon, 11 May 2026 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778506466;
	bh=oyonFvyhJCEjLycQc7Z8CWcHApR8XON1Ttn6XgAYzZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LiXFXrV2VtLDoojjdNx+8n8t94YYccRmQmE6GK4EIaLfQM8pN5cQ9xPRu+VdXZB0j
	 bjgPuGSr1+QZEyRnXFC0SG7f2h9+RcN1ce4q9py2mcLWBoPnGtfLGZy9ZrCURlwu1s
	 rr1RKyQRSs3fV7T3oTbs+twVJKuZSLSk8sw5dlAtTKADk9xgeuwI7+8o6YLjBtcmgS
	 +cWWCKxMRzasltlutqtVoM4BShrmu9ZsRjfMLA//+JBxa1C6k7xt35RPhlCekbzUEW
	 RRz3ojS77sL1sswE/3RD+61hBFRSgQ5AKYsN4CoSdCWfShrfJj8fCos9zf78myILbh
	 ycNUg+50bk/uA==
Date: Mon, 11 May 2026 14:34:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7793: replace usleep_range() with fsleep()
Message-ID: <20260511143417.48392b07@jic23-huawei>
In-Reply-To: <20260511053043.229-1-sozdayvek@gmail.com>
References: <20260511053043.229-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 10:30:43 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> The AD7792/AD7793 datasheet (Rev. B, page 25, RESET section)
> says: "When a reset is initiated, the user must allow a period
> of 500 us before accessing any of the on-chip registers."
> 
> Use fsleep(500) instead of usleep_range(500, 2000). The 500 us
> minimum stays the same; fsleep() picks the upper slack itself
> (about +25% on a default config -- narrower than the original
> 2000 us).
> 
> Add a code comment with the datasheet reference so the "why"
> of the wait is visible at the call site.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Nice

Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7793.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 8ff7b70d6..dbc6b47b7 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -268,7 +268,12 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>  	ret = ad_sd_reset(&st->sd);
>  	if (ret < 0)
>  		goto out;
> -	usleep_range(500, 2000); /* Wait for at least 500us */
> +
> +	/*
> +	 * Per AD7792/AD7793 datasheet (Rev. B, page 25, RESET section),
> +	 * allow 500 us after a reset before accessing on-chip registers.
> +	 */
> +	fsleep(500);
>  
>  	/* write/read test for device presence */
>  	ret = ad_sd_read_reg(&st->sd, AD7793_REG_ID, 1, &id);

