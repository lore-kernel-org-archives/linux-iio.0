Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54127331EB9;
	Sun, 12 Jul 2026 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783821520; cv=none; b=c4V/ta2tUAEutuR8EsE7SNY9gEU3xdLum507ADZxJ5gKFr/rYwpC+M5TKC+/kK6HAigwGN4G6ZTUFy0izsfKsHLujGA9ydykGCUgbzozS4wQ9qM+2m96QtLh4ATkHu93IhFLZdt4IW1eVI44XN9MY8J6KEs+cFtVbrZw7FPi3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783821520; c=relaxed/simple;
	bh=eUF0oV5XG3l0ShZSZjf5tw/rlieMAWyFg9EaSn4TXr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3l+PDOCjJhPEon9SgIarSBmUtIU/AcMvlrNDXUzVQnF/KQw5ur6w6VwbfJ22KJn9bdXAl+2yvCsBY6vjc+g0kjDPxYEUhDbubdm0+qelN0AO76V33FTNZZwQVpJDruz/L1yjHogoCI3SlAUUpGcwPuS+30W9QOj7SZg3y1eTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjmma+fM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjmma+fM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C131F000E9;
	Sun, 12 Jul 2026 01:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783821518;
	bh=IzIeqLPdPpTwSkVc2B5Zp7Mp8K4Fe7m4ANGAioWA8gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rjmma+fMD2YkGOveP8pbQAyTDuAO5SELxegb0EwzF9Yid32G5PsDZivc8J7WWkw1E
	 cSbxtM8VxTS4vmal+G4h5KLKrNukqb82Lz/1budXv8l2fdseImkxeF3F2zUMyv18E3
	 N2oeBQqyd+AgGtCxvd0UJVKI3RuIR3+XfKrf7dCG2vSJykB9fvsUvbFHsMGsDv8yf0
	 ZMOPxnQuLtgg6/0sHIVFWqgQJNF3xfdtHOOwGdACL3gJQGibmagbqBBPsG4to7MNBH
	 eoOrsJyOQqb2BKVnAf2x3Zh/vugV9wOODguA22/mRBW0jc/YC8gx3qzgYRxFNG4mNk
	 ApSQIIx7U8Flg==
Date: Sun, 12 Jul 2026 02:58:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] iio: dac: ad5696: properly check i2c_transfer()
 return value
Message-ID: <20260712025832.707cf448@jic23-huawei>
In-Reply-To: <20260710-ad5686-new-features-v7-1-1bcc8c280e4d@analog.com>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
	<20260710-ad5686-new-features-v7-1-1bcc8c280e4d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 12:20:45 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Verify that the expected number of i2c messages were transferred when
> ad5686_i2c_read() is called. This issue exists since the support for I2C
> devices where first introduced.
> 
> Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260705114746.1485F1F000E9@smtp.kernel.org/
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
FWIW, as I understand it, these are vanishingly rare unless the device is
doing something unusual so I'll leave this for merge with the rest of the series. 

Jonathan

> ---
>  drivers/iio/dac/ad5696-i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index 279309329b64..6f726e6301a6 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -40,8 +40,8 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
>  				      0x00);
>  
>  	ret = i2c_transfer(i2c->adapter, msg, 2);
> -	if (ret < 0)
> -		return ret;
> +	if (ret != 2)
> +		return ret < 0 ? ret : -EIO;
>  
>  	return be16_to_cpu(st->data[0].d16);
>  }
> 

