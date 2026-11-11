Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379972;
	b=n95NrWNOffzGQEFD1jJlaLXuoPmTW3C20vfqTKX9jUphILx3YKGWiIyGl11ZQBLcsK3i
	 AIQOiPkae50c626ey4YvBbXx89814PEBTHUzGLUvE99TZWzOE3PFTct4q/nfljcsVu86X
	 KuuRmH0oMEwOE824Pcf9Y6OnbSEfuXcritfKErorvAABZADUVqaREtMwI+a0P6NAPBf/Y
	 L0d47Peqa4Rt/Y4y1DfZ5e1+gQEre4BZNBNnPjYLan29fQ5DwynhysctlEZ2xHVKreO7L
	 bxxMFqKkIFSwbJcTSdVEZj1ux91hBIISw3dQ4N7M7JMXmstlHcXzJcE67igwTj8FDCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379972;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HoW2S3qODYNFsPuLH7g4ByB0FMG1OvwPNnRs8ajNsfA=;
	b=PjWZGVn+BEypikwl7U8i3MWA3Rjzz9DE23+4OH3Cfj4gMvvIfM+P+ReCX9rDH3xrJhOy
	 Wd+fvdX665vl/5uB7/hL8lMxCDdaDr6X9oGh5B1uHIs/da9x61ahGUMMvW2BVCmfv+Zfo
	 xtfMAzcq6+0FXBbHiBVoi8RObu8uZP4gVHGGwdSWYgWegVUkr2k5uZCiWW8NzVJsLgwz6
	 4so68LDLB4LxMQmYtwcusQZawGe3IT4RimnyKgP0URKwMIniPfgYcxAOrRBWKqQx4+awY
	 Yl+jl7i2djytc6TZwYVabHnXuV2lLTUqDx7vSQ81kwCbHxmy9a54hJdbWi9gmrCxjKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cryspen.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC40606A332
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 06:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC40606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryspen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so32195515e9.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 22:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379970; x=1794984770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HoW2S3qODYNFsPuLH7g4ByB0FMG1OvwPNnRs8ajNsfA=;
        b=TwO7hI6CfhBJT+voSKTkqS4iGpDOlkJ13et3TxXkV+CDFAVl1TJ3Hsx3cwWd4Habb+
         E9LP8FvWJQ5fet5KkidK6gApxTsztjQnPLvEe6yIx8HEmOXsCl5aYyBzNkcmdgL12qxQ
         nvjUoYLzb2Phg9ZwV3EupLHczUhwlAr5M0BmWG+alP/rpK8GE98szjfOg6ooA9zGN9MK
         q23GzfeOvxX1X1Am6kN3Rt6zgdz/89KqXVsYxZRI4kR4UQXH4z7sLZm+mgm8GbykL6n4
         b48oMOd6kgYN6Br0+cPDE3ntnkpat6zMYm8N4gXTcHfE4iG3Mdv9j2Qzh0fzbY8kOiag
         1a+A==
X-Forwarded-Encrypted: i=1; AL+hErGYSPZ9BuOqbN92g3F+0c86RUf6qfr/VMrwdkDxSDpXyPmafpr+m8iR/EyI/NqQWwj5KwOmC4jgv1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UMv0jlPtlSbNqyFt0rkjFcZST7uiP8CmNkPjY2Da2O7ASlwKX
	l9PZEHjZG9Adb2nMi3rOfDPxpa2uzcFw2/R2uAFsjIQJiZUccgbvVptO
X-Gm-Gg: AYBFou1FYu40kiou+DNCg0fMq2NgcqZ7OaJa6hzK3QQa+aCE4rwA5iSZDt/VT+yvi+3
	4vj2H35c3akJPLeWwltssIP1MwfbeBmGGW8DUBP0/m4IxG7865xXfQKCzOOTzejYSnSITCt2L27
	BHgB/Z57kX3JWCe2hxVhMlYrkvmejVCtWMwZJy3JUfJPDwdp3HFngTTKQsfGjNqyYdnTnReMM6z
	ITZC5E/yd3HW3YiDhIa2QPPELRrtkynlZT/MI4qRGOMsCFE3kYI2nodsH187WgHUD51m3bk+PU/
	6TUmdM3EiFG9ZDTy30cpN79WuNDhdit8tq+VJifDY0a8rEK62Cmfwpt9nY7/UCGFy/fdyaRcf9/
	K/OAOD/LKESpEs1DUclQkdbyM4xw0vbUoK5nfMVeWzolD+mjzpyuPG+b/HD9tRuizs/vtYcA6v5
	38wq5RLvCLGh9jaQDU7RzFMou2rPueHRhkXO7E/bk7rnFKyqB/IBKKBwUAu7T/dE9wVbXAn6D7v
	8JSwz7kNmPfmKzgn3UH/nqhS4hUpC+V0TzuH+KcKsdPYq6GHlsFgz9EANc/tTfzfT8J0e52RpGM
	cWXaPcD7PsrztN4MYd80/kW+7/Y/oKZ/8dmvaCh+tT4+68h/7wBIQKT1b4JCQOPVmLc3iGqS/KN
	BBr5z/K7w/Mz9Ld3sQ7i8wRNwlfu0akNW1cITHfOQR6ZDZKrxKrfLScpfwsOLhaQH
X-Received: by 2002:a05:600c:a00d:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4ba093b7ffcmr22597675e9.35.1794379969657;
        Tue, 10 Nov 2026 22:52:49 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a763sm116775375e9.4.2026.11.10.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:52:48 -0800 (PST)
Date: Wed, 11 Nov 2026 09:52:44 +0300
From: Dan Carpenter <dan@cryspen.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832: use guard(mutex)
Message-ID: <avQQvHuDsW8XTfgj@stanley.mountain>
References: <20261110164711.552-1-mnithishvelan@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110164711.552-1-mnithishvelan@gmail.com>

On Tue, Nov 10, 2026 at 04:47:11PM +0000, Nithishvelan M wrote:
> Use guard(mutex) to automatically manage the state lock in
> ad9832_write(). This simplifies error handling by allowing direct
> returns from each switch case and error branch, eliminating the
> manual mutex_unlock() calls and the goto error label.
> 
> Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 47 +++++++++++++++++---------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 35f823f24..227dcd739 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -8,6 +8,7 @@
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/dev_printk.h>
>  #include <linux/err.h>
> @@ -188,52 +189,65 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  
>  	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
>  
> -	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9832_FREQ0HM:
>  	case AD9832_FREQ1HM:
>  		ret = ad9832_write_frequency(st, this_attr->address, val);
> +		if (ret)
> +			return ret;
> +
>  		break;
>  	case AD9832_PHASE0H:
>  	case AD9832_PHASE1H:
>  	case AD9832_PHASE2H:
>  	case AD9832_PHASE3H:
>  		ret = ad9832_write_phase(st, this_attr->address, val);
> +		if (ret)
> +			return ret;
> +
>  		break;
>  	case AD9832_PINCTRL_EN:
>  		st->ctrl_ss &= ~AD9832_SELSRC;
>  		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
>  
>  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> -						  st->ctrl_ss);
> +				       st->ctrl_ss);

Please don't make these sorts of unrelated white space changes.  They
just make the review more complicated.

regards,
dan carpenter

