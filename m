Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67290364EAA
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931990; cv=none; b=cRn90/iGi7JNfjkye2x6s1CKYgSbaJKR6dLJkBFqzagnDIoIac0zCTS15Df5dN/2vwBKj892dPpH7kvfW8qvdbIIT34oahvt/Hn1d0m3kI5zd0miosJxB36H06ea4W46T41qpa9TpoDJ2EpzIggyFcUnKwUvz5tTrgAl5VsIZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931990; c=relaxed/simple;
	bh=LnSlgQumZUymdbffnu2vKTkuUg/jqjTtpU53P+tI4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ07KjUeYjjSP3YEQllqwLC+q73yVDlGTyqPRY6DNt4KbfWkaEPqVitYL+WLHXK1v1rx3xfui8dOpw+A0ttj8dTey7eLxXvqWkEslnFgaElb3ppY6mkfMpSG1otf6rDjrt1y1lFw2Ktu3ct7BE5v57eImjtvL5pRv0up3ea3dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzewHmE8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzewHmE8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so81567595e9.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776931984; x=1777536784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJ/DBvdc9fYsH91lLLkmQGITtRq+02I8omXtrs2jaHE=;
        b=HzewHmE88QfzJe5H8u7jpQ9L32urpkszkqUX7kZb83fDqw12zm3MQ5qRLHIkWFehkC
         b6JtwqSubFjuZAZCoZalERm03pCc2syyDbUwQg/CQJmgcZW4fNofqKBiUZDLD0AzvMfZ
         ZIiL1/36bZ3+jSD2Lsyp5OwzSf6Du9eGUw4KXevieTB1MrXEb3nEtt/424neKKaQHiHq
         g9HqqJsq464f1gs1twntie7bepbsyFIMtZqL8YAKS9Rcs4eWcB+67JLpPdfhKl1Ky7eM
         4uny3ylFz9R0ucfO0b63dC1RAgWgGub2zTlzlFPboIt00yHEwc3Q3qK1VL1QKs9klw1P
         W8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931984; x=1777536784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ/DBvdc9fYsH91lLLkmQGITtRq+02I8omXtrs2jaHE=;
        b=bq7vaOwC+gK09OD3WMoxOTuYxNEtndloAdWICY/bC5kh2tq0QRmCnh+N61AzjtW1EO
         HSYMPbIyoXXxoJzD8XaM0uXULhXj1hShH1XJzywSDTOYEe1WyX4b9+9Cl7EhGb2ZJzGj
         yruoiRqNJPv7nHqJuqF5VLOZdJdQlNJW9Qk/hoBtT6FX9ztseJof3XUFId/UHLMlazFm
         6v2iFs2XhwR7JVe2qwxgIjr375TNmCybEOE0wOul3bkcb3DSYfHcQhFbVXgoWdL9e2kL
         QK9TvJJ7OuPjHDJYRqe/ob+Jes7eV+Z6YtY/U0K8tgxrDpl2xuSjHykr6tYXhL2qttGp
         rhxg==
X-Forwarded-Encrypted: i=1; AFNElJ9NmgjorkDJ7a2yxlTRYs2w8hFyrzz5GI58iRGzDfUoIz3XMjIfwSqaL8XJOajyGXoUq71+DPLvhwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykkiJ9W0SupK2XRGxR7MnWfcQXFM5P+mGCEOaHSDnlVjm+AMtG
	KiIU2BBAu2567WUlQAzakAdGODLs/qvP8G+UW9HW0J6fLxoNiBqEoCP8
X-Gm-Gg: AeBDiettvpMp6vdj2tf9PjoUUJl78QnhhuMBoeoE+rjlUO+CfnTbviZF4/W4AiEj3M5
	5HvK6Q4sua8cC62egWxnoDpM48YgcDHEXuKdd2A0SyMEOhE1bI70dLFGFFxqDiZuvTVcUkoHrFK
	oBdNwrXK+6mA+LRLuZf0yK6wdjyG3+6qv0LfWZfwOTjnpbMSMv4W2RMGBi//OMxlCVfiZ1eXFgP
	seoT5sOLc7A+zMKXlAQM2Nali9LmEHHo3wdNYmdd4cvSuVJzbd5eBLDwWalQTdIyxq3eI1DQ6Mj
	pWY3CwX9MKdwQHV5cl2bwhNGmjcQZ9+sZMQl4PL39f+onjIJbshJyB7bySNeN2nX59iXqoDz9RM
	UtwZX9CKKk9jjp+DLAxd1oEXxiMpFMV2/LC05Dpf9uISCtM/wGLSd6azOWAbL5gWo81B/nMeXLc
	n3TaQjjioYQVEl5j7CQ1eaV0jc
X-Received: by 2002:a05:600d:10:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-4891b0c8c48mr201117645e9.1.1776931984093;
        Thu, 23 Apr 2026 01:13:04 -0700 (PDT)
Received: from nsa ([45.94.208.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm517098165e9.5.2026.04.23.01.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:13:03 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:13:54 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 13/22] iio: dac: ad5686: fix input raw value check
Message-ID: <aenUZEkeDGaovVir@nsa>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>

On Wed, Apr 22, 2026 at 03:45:47PM +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use in_range() to fix range check for input raw value, which is off by
> one, i.e., for a 10-bit DAC the max valid value is 1023, but 1 << 10
> equals 1024, which passes the previous check, allowing an out-of-range
> write.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

I'll reply just to this one but it seems to apply to all "fixes"
patches. They look like a real fix so I would expect to see a Fixes tag
(as Andy suggested) and see those commits coming first in the series.

Other than that, code looks good (for those patches)

- Nuno Sá
>  drivers/iio/dac/ad5686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 19d791c655b7..07a944311f0e 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -185,7 +185,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > (1 << chan->scan_type.realbits) || val < 0)
> +		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
>  			return -EINVAL;
>  
>  		mutex_lock(&st->lock);
> 
> -- 
> 2.43.0
> 
> 
