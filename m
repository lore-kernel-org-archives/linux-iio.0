Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32A3009F6
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361913; cv=none; b=q2Il6D27Z22E07N66Da82n8KyaC6dxNWbReZhGX/+d8PsjAn/IF5Pgfs61V5V0EnRjE/sUUDLgOaOssW8m8bXIhQpnZ7JjoTZ0ABXnjGZS9IrkQ8TphTfM4zyf1Ez0D19WJgWDZOpW5ffdIMEbJCmqadYe4gm8JcAWbSayP9NyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361913; c=relaxed/simple;
	bh=+MMNG16ezoXTEVitqZLoCuq9Wv5fQv10zxhVNYHKL+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAzql6hKCCa0gujGQaU0PSc7yqBIBBaqQOm9ruR4LFi5D5x7LctqSQto51a4FvotmighgnLighR3P/rI7eobElVSS4tQ0XGs5WFT9vF+ZtNcMoT74cdC8TkXA/aYIRVIOCJ02UGyBgkzT+jOimEt1mvWEaOMvCMMpgKgD3JTnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=l8IuNCOn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="l8IuNCOn"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dccb8644c4so1665217a34.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778361911; x=1778966711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWhphwm1p0UDHAGm2TO98rY2AQVS4xVGvz+kuyX5dfg=;
        b=l8IuNCOn48/b06RIQajrLufhf62PMNGKBhE2+tn1QJfhFSLdFaOygHiujFOtHcgj0y
         eFHpnSAdzQwgHOV9BtBX0HqfThPXDCfwhBpTomaLWNoOmjwy2M5pQ96PPESuxSe7zrsj
         PI8QP5AVzAZ0yVCEg4XDUE/UdZSUUyeTv10OyA33gXb/1o3iEsdi6Jh/Esqxp1nUREAC
         uFkjMOCG1bnIdUtrYooSvKNT/kWyzVivmGRN5Aj/FuUcD7gJVqgjL/Z8gJuyBKWLrN7w
         lIb4Uchg1W7hvaixLmxgaZ01YTQcfSBVKeJcukmD9x7XPB5bkKPfrEge5sRMJAYc5VSS
         1qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361911; x=1778966711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWhphwm1p0UDHAGm2TO98rY2AQVS4xVGvz+kuyX5dfg=;
        b=Vcd6asxq0Vls6pkucNuLWo+p68cAEplqHrO9txRdklZ8i9Jgm5BY2QGtZbJLR865tV
         GJVC5mMhzsL7Rh5IEbCaDSYUQriH9FA7fcVDTXFKRref6GFwjc1V0N30jb9tG6Wdv1st
         uY67sd0D659o/nBdwgozlQRlEaToGTnkMnPxtYzf6tmcwaAWe44FrXN+YT0MnIPWSvbP
         KJlMFInOcfXlds7ItVwweHfTFo0v7/BcZiCqHemczaZBcuchNBRV4AkN9osBOPGGApYq
         DWqLBqotg6eYZWDp6Z1zgx+vBOcRIIuFtd7Ok65PmW6xmmrWNgWrwHqBJH2a/y9VnDtk
         YuWA==
X-Forwarded-Encrypted: i=1; AFNElJ/rvBcm0WbQB4ps87aegfs0kU/zb6qYyM9+8FgaGq2FPkIeu/E0Vo4s8KbYQTFXUjHlrlyVyNRl90w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyebUgefK/RPgtLHRp3r71dz5Tge9emv8WKilPMpBgA0Y7mf1ZE
	DjLZV2WrFN7QpZRb9FIOYeXu6VheC07FCbWU92auLCBdy75DG6JplvzAqtD+VOk74qM=
X-Gm-Gg: Acq92OHwJ0/xb/9pveZ2y3iG2KBht+0CQbeIqZAcfpKMQud0e8105pJZw8SnW5U4kBO
	lTqyOqjmH69Cw8S2Iqkz3tX9eSire0nR5IW1M9XQZ48gMXEr3pMX8KB0z3SixYNGa4apoG7lsiu
	1mw1or9+I6J+BEVJhbhk3X8awYZRHXDy9BR5UXghfRAQ3ks1P0rJyJLwQKZv7GMU+VqZ0+tiNvs
	7ZiQqBntytH4lcEMiuEZe7ToPo/VuQOYRty0kO8rqw6bBGK2ctygcJrjTjgFXCXbGsnT/GV9xa4
	K86g26RNngjKz6qhL4+AEwiLcfArRocH1nHEhtCkxwj1/h6+hfpKwjL03rNyo+wbONaZqtyYWYl
	Nr5v4yv9EJTK3QF4gFZF4iZYy2ttEGpmZgSR2suWRvfKosG/575Jyl169C96tDAR1XovD3gLm9B
	J2xNKYck0kMpJsV54TV/nMAfVhDSawgGNpj/b0R++EWOUhFp82SFdfAre//OnZHvJIEWdV6y5LX
	g==
X-Received: by 2002:a05:6830:83b7:b0:7d9:b189:d938 with SMTP id 46e09a7af769-7e1def6e976mr12105134a34.10.1778361911587;
        Sat, 09 May 2026 14:25:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d4fdf4sm3619324a34.14.2026.05.09.14.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:25:11 -0700 (PDT)
Message-ID: <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
Date: Sat, 9 May 2026 16:25:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero
 error
To: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260509211921.84969-1-m32285159@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509211921.84969-1-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 4:19 PM, Maxwell Doose wrote:
> In scd30_read_raw, the current value of tmp in the
> IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
> value we got was 0 to prevent a divide-by-zero error.
> 
> Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/chemical/scd30_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index be8c055be184..3e2bb6f4e42c 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -237,6 +237,13 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>  		if (ret)
>  			return ret;
>  
> +		/* Likely only taken if something really strange happens */

Instead of saying "strange" I would mention a possible hardware failure
to justify the EIO return. I'm assuming this is reading the value over
SPI or I2C?

> +		if (!tmp) {
> +			dev_err(&indio_dev->dev,
> +				"Invalid measurement interval 0 received\n");
> +			return -EIO;
> +		}
> +
>  		*val = 0;
>  		*val2 = 1000000000 / tmp;
>  		return IIO_VAL_INT_PLUS_NANO;

