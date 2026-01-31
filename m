Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC731E1024
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769892050; cv=none; b=K/CTGGHbxSpPv2QEZmq8fL5FO9OpENYapI5BWWGCKo1clYzX9WCoAPmq8jSGMo3c8jVVQhEV2dkOHOMB01ryDhGSNYL0ygCj+TGGF2ErFTcVNAoMeNz3eQ7cZ+L5HFu8RKtWotUsc6fQjq4GY0/e6U9ijmA1RKyVjMW5BXF4z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769892050; c=relaxed/simple;
	bh=1sR6m7lQWjP34cMhy3ePFVRhFe5CzrPwIXD4sSs2XGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR39V5XEIgTk2D5RCBB2VN2DHu0uxPLSsVJf8pLRaXBWceDtXtHwp8vVH10z2dKw05w0P15uja+9T/KAFBvbfe+kcUBdrIk2cqf/qC1b+EHM5B/ogs7cQav1M6A3Box4+ZuUUQt5vFqiSO616Rf4CPEnLmar7881RNMR5wT+jXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lwnRszWP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lwnRszWP"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfccba483eso1156722a34.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769892046; x=1770496846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U06Yu+Oi/vmvg2l+s/ec/fGXhrwRx2Id6b4YW3/+WpU=;
        b=lwnRszWPZZK0qHfXq69+sQcjrl1Pz+zqyfxf5nFFfMYac5BGtlyi4qNr0IkRysmHRN
         gecTa5rJQS6YMlwJVibzCnE7pfcCqgQ245Vi94YoC1ZvFUgcLjSIeSSi/ZNKG9EZaiL4
         97Q1w1UG736hMQsC4jkhmX/MnLLcKYxIkje1EPeGgXSr0A3Gewkrax48yzCc9/6ccW6s
         Idu9CDeW2fm/bJLBWL9k+FT7r6xJRorH7G4WQmKwgt3FP22pKSNWQHluJrgc56biVkce
         jhuEec8RfsyX7r+aPaiGs5CcF/1GMVEX2kUPmB1DDhfN55Ym5ngXJ6SIWum3mFJPbiZl
         eP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769892046; x=1770496846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U06Yu+Oi/vmvg2l+s/ec/fGXhrwRx2Id6b4YW3/+WpU=;
        b=H0VBu2IIFxScrsyDCZSkbDX0L5Voof36p57Y3uFQPEHxEGyuNpeeZW32Qux2JvitcH
         eh4k/8Iqrihen+zSTtrIsOzdARpnvpUqpfjw/RUq8bHaQXlZlqriJ/09TBun0PrFb+Gs
         9vY/nqP46qXeWFw07ByzRr7kK1uLg1ElaHkBvVXDFdKNrX6v/Nav4PVWkyr0HOQZhI8F
         wImw32qSGh0OSPCnBRJBHTZu60xwTbQLcrtbOiPa0MCz6vKbhVva/YShDUc0YN6nA8wh
         6BmVyYPUGIaGcYBoWnXQWjxAY8zvxZF18NeuPY+lYMkSqqf8LCK7BOrEqkHYcelFQ3vk
         fD3g==
X-Gm-Message-State: AOJu0Yw8fIiZdIHkcRua4YXX8crpzTXEge51ta8V0beh0leAVXbMa+Y3
	0FSvS4KJn3XCHqgwZ7L9wbFcIC+LbG4KcynzfMomPVSFNs0XAxhxHqcXNdaRnxuVcvE=
X-Gm-Gg: AZuq6aIgO6LFx2cb+t4e9k14CBhDlt/ZTNC8gGEkoOoxSMCyB/0G87OvHRhlgbWgTC8
	Ml174S4ZBJdNj6c7q0m5zDyJ0yF0QUXbgf4/X/onwXnjaiJSGj396kveYuWmbjESBtsM5m2llRV
	yKnA6Fyc28a1jxcBmryCAP3kCoBWZmTraFeKzJvm6YeLZujonKbYFdyBEi3KKrDwtoVtBuLOpq4
	/igcXaQq7/TSd72TNoU0djhS6/u3sAeIh+tOaDjQrBquofpJZs8GYh528pzsjM2I0I10KXRBs1r
	zP7IZFjX4t6clyyBuqIt4PN5NkIyZDV/xnY6RDoFuQulxyr3aSjmz/JiQV4mvz4oi61Mw5/p8pS
	DhIOd3iMeEbbTmCaKUL1D3bwEPiCL31GnpmDmxwpnZ/KNj0ZpeeEf9cPZf0AoFU+YBy8V6sJI00
	YyMS9ztoSycZDNAzor308yaGjmcP/WgOwFjyn4Lranap/5BlQTs1kL2GbAW01fcAGGqvRwaf4=
X-Received: by 2002:a05:6830:6508:b0:7c6:d001:afb2 with SMTP id 46e09a7af769-7d1a53366c0mr3520587a34.35.1769892046240;
        Sat, 31 Jan 2026 12:40:46 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c69ac16sm7890169a34.7.2026.01.31.12.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 12:40:45 -0800 (PST)
Message-ID: <9c674c11-56fd-4b49-96d6-01d8cd433003@baylibre.com>
Date: Sat, 31 Jan 2026 14:40:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iio: adc: ad9467: check for backend capabilities
To: Tomas Melin <tomas.melin@vaisala.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/26 3:17 AM, Tomas Melin wrote:
> Add capability checks for operation with backends that do not necessarily
> support full set of features, but are otherwise compatible with the device.
> This ensures a fully functional device, but with limited capabilities.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/adc/ad9467.c | 69 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 59c3fa3bcc9b..d768f7bf2a1c 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -913,7 +913,9 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
>  		return ret;
>  
>  	guard(mutex)(&st->lock);

I saw in the changelog that leaving the guard here was intentional, but I
don't see why.

> -	return ad9467_calibrate(st);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return ad9467_calibrate(st);
> +	return 0;
>  }
>  

...

>  static int ad9467_write_raw(struct iio_dev *indio_dev,
> @@ -1119,12 +1121,15 @@ static ssize_t ad9467_chan_test_mode_read(struct file *file,
>  		len = scnprintf(buf, sizeof(buf), "Running \"%s\" Test:\n\t",
>  				ad9467_test_modes[chan->mode]);
>  
> -		ret = iio_backend_debugfs_print_chan_status(st->back, chan->idx,
> -							    buf + len,
> -							    sizeof(buf) - len);
> -		if (ret < 0)
> -			return ret;
> -		len += ret;
> +		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +			ret = iio_backend_debugfs_print_chan_status(st->back,
> +								    chan->idx,
> +								    buf + len,
> +								    sizeof(buf) - len);
> +			if (ret < 0)
> +				return ret;
> +			len += ret;
> +		}
>  	} else if (chan->mode == AN877_ADC_TESTMODE_OFF) {
>  		len = scnprintf(buf, sizeof(buf), "No test Running...\n");
>  	} else {
> @@ -1188,16 +1193,19 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
>  			return ret;
>  
>  		/*  some patterns have a backend matching monitoring block */
> -		if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
> -			ret = ad9467_backend_testmode_on(st, chan->idx,
> +		if (iio_backend_has_caps(st->back,
> +					 IIO_BACKEND_CAP_CALIBRATION)) {
> +			if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>  							 IIO_BACKEND_ADI_PRBS_9A);
> -			if (ret)
> -				return ret;
> -		} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
> -			ret = ad9467_backend_testmode_on(st, chan->idx,
> +				if (ret)
> +					return ret;
> +			} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>  							 IIO_BACKEND_ADI_PRBS_23A);
> -			if (ret)
> -				return ret;
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  	}
>  
> @@ -1263,8 +1271,10 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
>  	if (!st->chan_test)
>  		return;
>  
> -	debugfs_create_file("calibration_table_dump", 0400, d, st,
> -			    &ad9467_calib_table_fops);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +		debugfs_create_file("calibration_table_dump", 0400, d, st,
> +				    &ad9467_calib_table_fops);
> +	}
>  
>  	for (chan = 0; chan < st->info->num_channels; chan++) {
>  		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",


Do we actually need to change these test mode/debugfs functions since
debugfs_create_file() is only callded if IIO_BACKEND_CAP_CALIBRATION
already?


