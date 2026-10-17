Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B084CF477;
	Sat, 17 Oct 2026 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196418; cv=none; b=SrzUOp0T3G5Ig0ZIrbj/tzYuwXNYCVpkYfVOoiGQwjfpGdQYk5czEVhxoJfybOZGAyF7MxVewf512hO+JAN4FGY+XThL/vzgWwD1qp15jNi58iMayIpPy/j0pVoSu3mTaz8y2ZxMb4pUA3rTCRYVe4jqBP8tURkx5cHeaEK7b3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196418; c=relaxed/simple;
	bh=0TAg9kwf3bBy6hz4ngcoqFMwcjlxEnjkj6ka1h5G9Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaV94YWOir1Cc22kMR1XCrKIfzoiTZdFsrYHsMhfGzo/wQlwH+1jZGy84sPk8f9T+h7k7fvDjv8HVj2i0aesPBLtuaG+ZdfCCJYXrClnAT9ABV4lM43nkEgVWLfGa3hgaXezO58PXn+v/uNgBi1rpU1lr8vl/13RUEQQDogEdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBH5faVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBH5faVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1501F000C4;
	Sat, 17 Oct 2026 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196417;
	bh=T7gCl+qVVVNj8BjUCLZNh4b3oW8uH2GR5hEhwUea7s8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lBH5faVCSPBlur4HNNtBz2Rz9iAlb5cimJsDa1iSOavVcmAot9t8RcyjYiKrggflB
	 6GjOXHZITslrQSnEeswSDYox5M9pIrsUQzzpQcOjgPNO+mT+J1vZLJr6fW+713tBYJ
	 Gw+uGSuYV+RkUY94PGhU9zY7pvFG5H4/+LjQ+PCcGJYnAw/luiDjNpF/n2/bt7mrvp
	 3RUQkduczhWfn191IWo6xtdgL03mhEF1oxaFwjOSMtBg5e3GW+bKjGlGKkhWw5aCxB
	 ciuWYevazih+c3bVOMKX/k+JI3ijTnUS9FZDYlOOfHQvPotAGcAL9CQTntTkPqQb3B
	 ltWwk68CphJKg==
Date: Sat, 17 Oct 2026 01:20:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrea Amer via B4 Relay <devnull+and.amer.gmail.com@kernel.org>
Cc: and.amer@gmail.com, Peter Rosin <peda@lysator.liu.se>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: afe: rescale: always expose offset
Message-ID: <20261017012012.3390a90a@jic23-hlaptop>
In-Reply-To: <20261016-iio-rescale-offset-v2-1-02c825967139@gmail.com>
References: <20261016-iio-rescale-offset-v2-1-02c825967139@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 13:00:20 +0200
Andrea Amer via B4 Relay <devnull+and.amer.gmail.com@kernel.org> wrote:

> From: Andrea Amer <and.amer@gmail.com>
> 
> A rescale channel advertises IIO_CHAN_INFO_OFFSET only when its own
> offset is non-zero. A child rescale therefore hides a source offset,
> and consumers apply raw * scale and drop it. rescale_read_raw() already
> folds the source offset in, so expose the attribute in every case.

Hi Andrea,

Why not check if there is either an offset in the rescaler or the underlying
device? iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET) is used just above
an should tell us that.

If neither are present I think we can continue to not present that attribute.

Thanks,

Jonathan


> 
> Fixes: a29c3283653b ("iio: afe: rescale: add offset support")
> Signed-off-by: Andrea Amer <and.amer@gmail.com>
> ---
> Changes in v2:
> - Keep the IIO_CHAN_INFO_SCALE line unchanged (Andy Shevchenko)
> - Link to v1: https://lore.kernel.org/r/20261012-iio-rescale-offset-v1-1-14ed15979ff2@gmail.com
> ---
>  drivers/iio/afe/iio-rescale.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 3a6a09ffa5267ddfd5131fbd04a5df928836589d..4639a67ea462bf5c29603783a6f230d769fb02b0 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -301,11 +301,9 @@ static int rescale_configure_channel(struct device *dev,
>  	}
>  
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_OFFSET) |
>  		BIT(IIO_CHAN_INFO_SCALE);
>  
> -	if (rescale->offset)
> -		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
> -
>  	/*
>  	 * Using .read_avail() is fringe to begin with and makes no sense
>  	 * whatsoever for processed channels, so we make sure that this cannot
> 
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261012-iio-rescale-offset-41254a33b6d6
> 
> Best regards,

