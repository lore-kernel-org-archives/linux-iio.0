Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533683;
	b=RIzmEur17OhlPSUX2xE50nMdQl6rguFD3P1pNNf+A7AC4ICOb3slaRi1U4IbBoDVsdK2
	 XtUTkIQoMWQiInGgQWgZM7afnuWOrFvIPiJY+juize4iKcNp6TNr0XXRbCok7l6gtfrjJ
	 /PPm0C6m7UKFYUqKfCRDUQXUaydJYNhYLJk/TjE/t8Y6VNHCYcA+BJ/PcW8XEvH3+oS1f
	 SxViHV6znAUhV7vB3HQRDdzgD/oFlzVT2sz7G7zaa182m203FXV2c0ZqjidEHJZDFGNMK
	 s9fXXwlBcZrPXtrktyGlhWF6gIK+FVSBrdxu+MxoYp1MIO5M9UdlgSfPiewQ8yMJLFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533683;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XWWULNm4gDfaGx4HLrLcbbjJf4raoMm14Hd9VUJrj94=;
	b=DW/O9TGoqQdOqmPYMHAUacprfkdDGvthNP+bIB6OzjhzSABWGmjfNtaiOYNO46sxLXEh
	 yda7tC0v6pg1yRHTDyAHRrJ3X34j8JWyi4b3k84BMaWczt2ES6VZI1LoDY3CfQA8pT5sP
	 WScPzT7x2xPWKpLYprWyeANIj6OuUSN6WrQ0dYgdS26+Y4YfI8PoL5iVvUojsK0V6CwU7
	 gel4Z4FC2cFGhmyRZI7llXbqOySuVzM7/ykEhhVT5VJg7V/OAjSWladqjGethvmvGxFnw
	 eUjgnEm8doY/3di5tKgC1Hdi221lnxMJq2yVmnDL9qQXD5czU1sXq834sFkLpyXThbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8T6aPwo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C92606A31C;
	Fri, 13 Nov 2026 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8T6aPwo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7C71F000C4;
	Fri, 13 Nov 2026 01:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794533682;
	bh=XWWULNm4gDfaGx4HLrLcbbjJf4raoMm14Hd9VUJrj94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n8T6aPwodMDQ44RzkWNdXaZKFE20faCf6Y6wygm5TGygTsIsN4kbk3Lic4upTrRgf
	 xqs1lZRqnEfUjUzhCVBDtGqNjwTqkGBoQWEQq5WkVpKGuleyutG0PSkQmqRcOsQ1W9
	 H2Yu9jjCZa4v5PmE09tR6ny6Wpy86UAALWKc+3Kj42/xVz5lF1mIoMuqya6o/LYodl
	 UOU0+ZJhHZUXCq/OiWY/QDxw6UWXNy2HNcMKkeu2wYzwzZt4QFdjGvwvn/IkZk2HPr
	 xWKqSYsoJ1+gvRtLbc1XCPMhGTA+GnRRSVB2tVZdftSr2cjYrbqVZSphL6DCjBaxl8
	 P93g9ArCaTatA==
Date: Fri, 13 Nov 2026 01:34:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andriy.shevchenko@intel.com,
 crofts@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: temperature: mcp9600: Bound thresholds before
 scaling
Message-ID: <20261113013435.54514091@jic23-hlaptop>
In-Reply-To: <20261112015738.115833-1-zhujun2@cmss.chinamobile.com>
References: <20261112015738.115833-1-zhujun2@cmss.chinamobile.com>
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

On Thu, 12 Nov 2026 09:57:38 +0800
Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> mcp9600_write_thresh() multiplies the integer part by 1000000 before
> clamping to the supported temperature range. The multiplication can
> overflow int, so a request such as 3000 degrees can select the lower
> threshold instead of the upper threshold.
> 
> Clamp the integer part to the hot-junction range before scaling. Keep
> the existing final clamp for fractional values and the narrower cold-
> junction range.
> 
> Fixes: dea750f8015b ("iio: temperature: mcp9600: add threshold events support")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes in v3:
> - Use clamp() instead of clamp_val(); all operands are int (Andy Shevchenko).
> 
> Changes in v2:
> - Use MICRO from <linux/units.h>, cast to int to preserve
>   signed division for the negative temperature limit (Andy Shevchenko).
> 
>  drivers/iio/temperature/mcp9600.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index b0ff0c7b4891..00f1acb348a5 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -17,6 +17,7 @@
>  #include <linux/math.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> @@ -326,6 +327,8 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
>  	i = mcp9600_get_alert_index(chan->channel2, dir);
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> +		val = clamp(val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / (int)MICRO,
> +			    MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / (int)MICRO);

Using micro here.

>  		/* Scale value to include decimal part into calculations */
>  		s_val = (val < 0) ? ((val * 1000000) - val2) :
>  				    ((val * 1000000) + val2);

and not in these is less than obvious.

I also don't like the follow up of then clamping s_val to either similar bounds, or
tighter ones.  Whilst I understand the inclination to keep to the
current behavior of clamping, that is really for things that are just
outside the range allowed due to numerical errors or similar. But doing it twice
is less than ideal

Two options here.

1. Just use a bigger type so we don't overflow.  Then let the clamping that follows
do the work of dragging the massive value back down to sensible one.

2. Use the overflow checked add and mul from overflow.h  Probably overkill.

Thanks,

Jonathan

 


