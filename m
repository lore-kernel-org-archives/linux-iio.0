Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808C308F15;
	Mon, 11 May 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510019; cv=none; b=mgyCak7pMIdkbKQslX14QeapimHdz2HT7MSSkHgr08EcLyPQRNF93mTzDuj4yjwmGf4BfrsM/aeOZyi2ETsR9oedXDclxV6c87EcqJ7tKcPIEgpYbgj1oHykJ6Z6yqqz7u29wL3TuPaW7j+RFXqNywDTxOKjMYdF5Scwh2JU5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510019; c=relaxed/simple;
	bh=NBCgubS6QiSJMV7x68tX/AQy1HLj65hfR5SgOZ/lS7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRVKDQqwS/yoLPuw3lDzPJuQA1UzVnGTaq2gUGXm84xK5z7a3kHGLWJ9ANLgJ/6T+sQcQtVQb5OZ/o0iUqokjs92cuvBwSfc62SeQbB2NlyIk5D+L8UjtBBEkL12DFGpKbDpweciO93RxYTGve/hc1wVswBsae4F4U026kH+E5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1p0IY+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1p0IY+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FD4C2BCB0;
	Mon, 11 May 2026 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510019;
	bh=NBCgubS6QiSJMV7x68tX/AQy1HLj65hfR5SgOZ/lS7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1p0IY+RLrwQjhFTiagbzK5Xecn9JeIp+t1KxqL3unskdK4frUKyhbcnmc+a2jTBy
	 fSxuR12ATB/KiauRE4Zn0adLxwfBgU8/ou0k5lkCWjC6ZuClvaGVw9m3QllmfLEXGC
	 2raJxkyqb4gPrN+kbDCOKfr573Ze/5Z15+h0lBHgWoJLNszuZ+hhLPo00Y9YD4pkRm
	 YVUX2AfcPTnLYCGRHPASThZlXESjLJzSceRVj0AOS25WipztSJ7GiEQR2CNXBAPzmW
	 lEwiI4ffVez//YRVRke8gZHu/iON2naz5wcZEQFynU0Mf5mpfJKYyBRQbrw0X4bGn8
	 CVwJM3M+1/yRg==
Date: Mon, 11 May 2026 15:33:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, andriy.shevchenko@intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/11] iio: adc: hx711: introduce hx711_chip_info
 structure
Message-ID: <20260511153329.1ddf41fe@jic23-huawei>
In-Reply-To: <20260510194947.31997-7-piyushpatle228@gmail.com>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
	<20260510194947.31997-7-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 01:19:28 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add a per-variant static configuration structure and populate the IIO
> device fields from it at probe time.
> 
> This is a preparatory change for adding support for more HX711-compatible
> hardware variants without duplicating the probe-time setup.
> 
> No functional change for existing HX711 users.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Really minor things inline but given you are doing a v8 for the buffer
thing might as well tidy them up!
> ---
>  drivers/iio/adc/hx711.c | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 01097e0fb848..331d47e1bbc4 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -4,6 +4,8 @@
>   *
>   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>   */
> +#include <linux/array_size.h>
> +#include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -74,6 +76,20 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
>  	return -EINVAL;
>  }
>  
> +/**
> + * struct hx711_chip_info - per-variant static configuration
> + * @name: IIO device name
> + * @channels: channel specification array
> + * @iio_info: IIO info ops for this variant
> + * @num_channels: number of entries in @channels
> + */
> +struct hx711_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels;

Trivial but can you swap this and iio_info so that we have channels and
num_channels near each other.  Won't change the structure size.
Can we also mark this __counted_by_ptr(num_channels)?
Lets analysis tools and compilers have a tiny bit more info that
can be helpful for detecting some types of bug.


> +	const struct iio_info		*iio_info;
> +	unsigned int			num_channels;
> +};
> +

