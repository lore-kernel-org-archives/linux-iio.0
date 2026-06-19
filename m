Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A730DD2A
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880563; cv=none; b=qAW4+vsu4C3Eye75si9AK6szBv9HnruCYpGaUhQ43UQOkFZZrb4lS27A3vUFZWXYMpdrkwnUmr80xK7/g1sQCpeYxbehO5mzIY3Cu9sbTzI8MFwbK5bg9tb2W3OCcUrpKmlXfkllxCblNTj8+U/zXfdVTAZuKHWhMXfnlPK6zaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880563; c=relaxed/simple;
	bh=ahr9gjL10xCO8oFDY0Oj6FAo/ZXDiOV+kNRd9mQ/uyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hE84vWlEY5kX09PQKdZut/lHmnvAKURk3qazWo40E0ToV5bhXUu6nHVSfnJ4PAgJca//LDJlmbAbftTFrtH95Nn6gGJHmaSKj+teyTgLTAjidLjozboIsax4CvAB/amVAYT6oKbfbsB0vVO/ooPp9mGrI2FodVQniFktgjySdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hqy/m7h/; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hqy/m7h/"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-446f87b6de1so736808fac.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781880560; x=1782485360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0AEJhy8Iei0UXgcYX2IxIT2ZrOU4/mLL10zoywJDQk=;
        b=hqy/m7h/WABC1Dhi4Vg8r+6NT/WT7m9sOPjdagTdrVIVjNkHVwbquWz7H75mpz4m93
         pHxdoRCR7ArgUoXBMyFG1TBHFPFRHTfw/Vp/EHZXA7yLiUOpEXilELZe2EI2wLK4opAr
         849JZ1DscbGpeJmFlU48sIFKftdbnwZTItWVaQnPkj0AQ0fH8YGqVgq7nk0OQ+yZP82t
         JEpCtC8/G/o+6/LB7um4yEXk9rQ77EBaJgH8HZu/AOcY+WkkkatkEH8p+quwrXarj7OP
         mM1TiFpJ+SkeyzRpDUSsVnHLGi73s11uxjJ2/Pu8ZOhCACxlYAmZgMYeHR37qr+LbE0N
         Bw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880560; x=1782485360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0AEJhy8Iei0UXgcYX2IxIT2ZrOU4/mLL10zoywJDQk=;
        b=B2rJWW5tQZz4tAd/tPz3DUwpuXv14GPDOdqYzG264759uIANL7iIH0MNcmmAvvX9KX
         wrPFd6MJlYhvXzaWm7OrDg9bja+zZE9xk4zzcIZHEslpNo7pz7O9Yo8mXirHf35TMqL3
         ff4zlcHDdW7HPb8GC8seXr8n4v4m1AMJKt5xBCup5R/hLbR7PFHwiH8q7K1X2Iy2hr4a
         VPkDn/qC+oQuCfBJybdRemZc+KPtZ2PPeh2M4ebtkSjKpkhNBU2R6R7Grq6xYEo4QRvd
         ubKN1MQtPrRDb0SHyTt+imrrkiB+PL6Fu/zcd5LOlHaiCSaPDxlPOpda8hchmvH1lW0X
         xPtA==
X-Forwarded-Encrypted: i=1; AFNElJ+fZhSJhBxnCyo6zO5N75vdGotrgzRcVnt+QEBjeiO+r6trm1n3fA81AyQZAx5/pafksYj3gGfWw0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdZs3BKMA4duFl5FpfyCccQlcKiIKNc052pYZBnqlc7evzFYY
	wH4WyA+d/CKximmeI1wPWp1euvB0ieEFo17hXmrWbHKv0gf9sm93xQEFRRk6KC1OOQY=
X-Gm-Gg: AfdE7cmiccQeXUD56OlyEXiLEA5n3SL7EuJm1MiY2cB+FHzUzVRAz4MBGsrEK/ETbTM
	yhPweLzM8BCckN8/2OO1DPPIKzIub5uexJVvuQZkIEd1UvuHCdkVJ1KKtMlgEfHwMU1L07lJGVg
	3Lvi5RIlE+VRdpzRoDh4HQe+uh0Y1YzOSK94RgDijUaYdT2nwTvVxMeke+Txw2fpFX7SvTM8TYv
	s5PgrZMARRqnvXwXHajXnI15wnrx7tANzSpN6/IAg8wZEVBhSgNBjeiiqi2TIwZxREkBMPWPTiR
	JNasP4kjtRk3jj6cJ2/4SxI37qsCTSAgzIQVFR9t+pVgietY7eWfjFpUzXPumxqaZPu+aWYP7RW
	1U9+81IYAmYDQsS8+AhI2s4HgFS8LrrB54MSbuBDVrlFzSofDtPIGpbPj0GqY0omFh3Ev9yGwnX
	J/JKePNWmQ3fTYm2HmLWF1VDfRpiMZ6e/Hl80/GdXU9xMTASmxGQgN4EntMA==
X-Received: by 2002:a05:6871:2b1d:b0:430:b7d:f248 with SMTP id 586e51a60fabf-44716d9a11amr1829256fac.24.1781880560555;
        Fri, 19 Jun 2026 07:49:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472efb36b3sm29143fac.11.2026.06.19.07.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:49:20 -0700 (PDT)
Message-ID: <99507afa-6986-44f7-98c1-257c52a5dcd4@baylibre.com>
Date: Fri, 19 Jun 2026 09:49:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iio: adc: ti-adc084s021: use dev_err_probe for probe
 time error
To: Prashant Rahul <prashantrahul23@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.or
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <20260618231543.413771-1-prashantrahul23@gmail.com>
 <20260618231543.413771-3-prashantrahul23@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260618231543.413771-3-prashantrahul23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 6:14 PM, Prashant Rahul wrote:
> This simplifies error handling and ensures consistent error reporting.
> 
> Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
> ---
>  drivers/iio/adc/ti-adc084s021.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index a100f770fa1c..9c7ee09955ca 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -230,8 +230,7 @@ static int adc084s021_probe(struct spi_device *spi)
>  					    adc084s021_buffer_trigger_handler,
>  					    &adc084s021_buffer_setup_ops);
>  	if (ret) {
> -		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
> -		return ret;
> +		return dev_err_probe(&spi->dev, ret, "Failed to setup triggered buffer\n");
>  	}


Can drop the braces here

>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);

