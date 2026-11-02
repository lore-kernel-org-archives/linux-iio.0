Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793581051;
	b=ASQ8tmJDYb+G6u68hCrIhp1ODuuD6PQ6EIY1XuDGwDemQ/5gjYuzK2o/jFcO15ROiS1Z
	 U+sFTQVvdmgdAid6wz2tP0ckqFFmB48j6UngGIwnLP8weYdnzXhfAhyqirUlEFcW97qFZ
	 Thot9G2k5TR0lE8mbQWzHOqdKCEbwpjJ0+qNtT5nUGGdvibgklGRCuZzMEqDjjLNsCC2+
	 wIaNJmkhauqz9nrZ/R4J9mDgdGYEUd4Ep2/lYf3fuhiBwNOMUyJNvjLaAB2LAnZB7uTxi
	 FJHRb+/bSK1Skn9AxAAZU5wA9uIFkbv1wU5/ud7oAR+Fglbh7qSWbqWuXFGqzElmukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793581051;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=heLd+ss6C638cZhNDlPcqRa2CXDipccwemFIU44ENYk=;
	b=IuGgBavdYut2BhWZPgeloX28Q7HOA9mZmVYbVipZaJpwvO8JZ4EDVQT1l/EJbpcVrBGr
	 7EOSo9j3M3iU9i9gbBK1HwAWwQMiot/CzqJoA0RpAeqSeuINkdIChaonwd3kP0YiiP7dZ
	 39drUmSIo2IsMjUio4yaCvGD+yD0MHFZ3ImytEqYdv5hPM/mCq5e8MGjqxY0azM7ss1uO
	 9edCSwLS63jW3BY7lmvof3A8K5Gy7cvowfXm6gSINaBxONIunl9Fbolc+EoIraeIhh5Fi
	 1Cj5Kjr/JGg7GFq0Lj7FFrPxBoierBveh+sMDFO4WK8jFM/RX1K1pfyQYXaHI78QKuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bw6Cnh5y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8260A2609;
	Mon,  2 Nov 2026 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bw6Cnh5y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F00A1F0093A;
	Mon,  2 Nov 2026 00:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793581050;
	bh=heLd+ss6C638cZhNDlPcqRa2CXDipccwemFIU44ENYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bw6Cnh5ydtca/KTvBYmmvOycB4MNE8b73QA9kOyPQoFkmsAGIl16tNLJkIquJVUFF
	 L7hGlq6Wb8sjhULVaLDK9/uyNKmtG9cJQwotCC2weK5OMgS913xGK5I1MbuafFgBoe
	 NFTNkXH44bwKXlXn7gE/bZae/fzLyOcKyAksgE6eRqgHMYdPfWURrYEeSPGWlKhBk5
	 dYGBe8Y8uQbXVChMVW4XiNcVoU0VuxLfHBDmya9f3Da9ulJ+Us4dpKsHuTm27f/iT0
	 St6giEnY+kd6LGcIfeFaxRRTco+T/c6BMFuUIDBgAyAU678yMabPFNAQhrzWviCv6r
	 MvT7QJ3PiswFw==
Date: Mon, 2 Nov 2026 00:57:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrea Amer via B4 Relay <devnull+and.amer.gmail.com@kernel.org>
Cc: and.amer@gmail.com, Peter Rosin <peda@lysator.liu.se>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: afe: rescale: expose offset if rescaler or
 source has one
Message-ID: <20261102005722.3f455caf@jic23-hlaptop>
In-Reply-To: <20261026-iio-rescale-offset-v3-1-7cf6540111dc@gmail.com>
References: <20261026-iio-rescale-offset-v3-1-7cf6540111dc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 11:57:38 +0100
Andrea Amer via B4 Relay <devnull+and.amer.gmail.com@kernel.org> wrote:

> From: Andrea Amer <and.amer@gmail.com>
> 
> A rescale channel advertises IIO_CHAN_INFO_OFFSET only when its own
> offset is non-zero. A child rescale therefore hides a source offset,
> and consumers apply raw * scale and drop it, even though
> rescale_read_raw() folds the source offset in.
> 
> Expose the attribute when either the rescaler or the source channel
> provides an offset.
> 
> Fixes: a29c3283653b ("iio: afe: rescale: add offset support")
> Signed-off-by: Andrea Amer <and.amer@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stbale

thanks,

Jonathan

> ---
> Changes in v3:
> - Only expose offset if the rescaler or the source has one (Jonathan Cameron)
> - Link to v2: https://lore.kernel.org/r/20261016-iio-rescale-offset-v2-1-02c825967139@gmail.com
> 
> Changes in v2:
> - Keep the IIO_CHAN_INFO_SCALE line unchanged (Andy Shevchenko)
> - Link to v1: https://lore.kernel.org/r/20261012-iio-rescale-offset-v1-1-14ed15979ff2@gmail.com
> ---
>  drivers/iio/afe/iio-rescale.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 3a6a09ffa5267ddfd5131fbd04a5df928836589d..c01292a15a29d02afa8de80a778c2c2a2aeecd3f 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -303,7 +303,8 @@ static int rescale_configure_channel(struct device *dev,
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  		BIT(IIO_CHAN_INFO_SCALE);
>  
> -	if (rescale->offset)
> +	if (rescale->offset ||
> +	    iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))
>  		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
>  
>  	/*
> 
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261012-iio-rescale-offset-41254a33b6d6
> 
> Best regards,

