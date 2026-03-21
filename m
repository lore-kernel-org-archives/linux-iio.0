Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E872D8796;
	Sat, 21 Mar 2026 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127144; cv=none; b=LvkunyoEzsmtJ5M9HSTBPDlXi9ZcRQYkjAAVAmRySQAl3bTfXsRz53HvPeEtnfWKrTLur2j1JwnbZ8fOzIk3sQA86dBl+7GIExA7/ziVQFSO//CF6Z4l/Qk4B9aVMEdZ2Wxksswj61RgTw+BnLO1YZ0OEaRDdy+0x4Ddj1deR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127144; c=relaxed/simple;
	bh=c43wMP72EcijoktlW8FW/EN+U+u3RwE+mMcfgnY3Tzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7U89gtNhWfMjuI/7xgv1Q+eNDdk0JRR5vmGMdtbDnFt8YVbxBdqBmIufwHi2dWpff9uALZI0O1LrX01mvCFEJF75JN4Fij3YPSi9ReCUAtumboPhsRK3H9dW65tmpZvlUdLFxrEVbtuiUiVQ7IaQjRilN8ykOK5XIbjr61TQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MobX0P2w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MobX0P2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C457C19421;
	Sat, 21 Mar 2026 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774127143;
	bh=c43wMP72EcijoktlW8FW/EN+U+u3RwE+mMcfgnY3Tzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MobX0P2wvKptWHut84Cc7x20zwo6vFj7P4o2mmAsdLuLLJt7m/HqnFupaJmTdfCJe
	 HF9DzqZPdbE2BCxrMuebZs/cCKcQGEzKlideq4AuNEjd/QOzGc/cAocrwtWYxa6DhF
	 JIXvgzwNBewj45Iemwzb5o1Huk37kGITwrJpsRDZDdBYUBfXwqR34a/+dwoZ2J+b4d
	 fbPpWX7ufvSImf3uU8i5dsCI4BgtZIPP+CFjZh5vmmcjU7bMmJjJ2Jwlxn2wCr3Umv
	 Z342F8hE+bnSq79b42Q42HiBR+kjB0EL6S/HKMUCOM8UWArKCLr/Fy0zYBuKv3hD3S
	 0Y9vnUlSLhmrQ==
Date: Sat, 21 Mar 2026 21:05:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Message-ID: <20260321210539.2de04bc0@jic23-huawei>
In-Reply-To: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
References: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 16:12:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
> when writing the timestamp in the rx_buf.
> 
> The previous implementation would have been fine on architectures that
> support 4-byte alignment of 64-bit integers but could cause issues on
> architectures that require 8-byte alignment.
> 
> Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Since we were looking at this driver, I was going to convert this to use
> IIO_DECLARE_DMA_BUFFER_WITH_TS() but then I noticed that we actually
> have an unaligned access problem with the timestamp since we are
> ignoring the first two elements in the rx_buf when pushing the data to
> the buffer.
> 
> Unfortunately, this will cause a merge conflict with the series Dmitry
> is working on. I don't think there is any rush to get this backported
> since no one has reported a crash from unaligned access. Since fixes
> should go before improvements, we could apply this to iio/togreg then
> Dmitry can rebase his series on top of it.
I've done that. Applied to the togreg branch of iio.git pushed out as
testing etc. I've also marked it for stable so it gets picked up in the long
run.

Thanks,

Jonathan


> ---
> Changes in v2:
> - use sizeof(*st->rx_buf)
> - Link to v1: https://patch.msgid.link/20260307-iio-adc-ti-ads7950-declare-dma-buffer-v1-1-79b1309338df@baylibre.com
> ---
>  drivers/iio/adc/ti-ads7950.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index cdc624889559..418452aaca81 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -47,8 +47,6 @@
>  #define TI_ADS7950_MAX_CHAN	16
>  #define TI_ADS7950_NUM_GPIOS	4
>  
> -#define TI_ADS7950_TIMESTAMP_SIZE (sizeof(int64_t) / sizeof(__be16))
> -
>  /* val = value, dec = left shift, bits = number of bits of the mask */
>  #define TI_ADS7950_EXTRACT(val, dec, bits) \
>  	(((val) >> (dec)) & ((1 << (bits)) - 1))
> @@ -105,8 +103,7 @@ struct ti_ads7950_state {
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
> -		__aligned(IIO_DMA_MINALIGN);
> +	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2] __aligned(IIO_DMA_MINALIGN);
>  	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
>  	u16 single_tx;
>  	u16 single_rx;
> @@ -313,8 +310,10 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
> +					      sizeof(*st->rx_buf) *
> +					      TI_ADS7950_MAX_CHAN,
> +					      iio_get_time_ns(indio_dev));
>  
>  out:
>  	mutex_unlock(&st->slock);
> 
> ---
> base-commit: 79a86a6cc3669416a21fef32d0767d39ba84b3aa
> change-id: 20260307-iio-adc-ti-ads7950-declare-dma-buffer-9d5269ffa8bb
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

