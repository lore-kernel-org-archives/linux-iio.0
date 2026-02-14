Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2B277C86
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086493; cv=none; b=uVQtBqahr8ruk/ailZgtHhM4Mt4DuHYVCnaf4x79I1yxYKXR5yB48BwlU+ZAxV1X8kYzxBTCE6iUKSrHgV/L3xJwlSUCI1cl67m+S0V4HT3JjmcWL7OUc3+VP/Tjad2zaNPxuNtJsYtvRn+msLYzJg0QvwUGjjPma2+CRbidoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086493; c=relaxed/simple;
	bh=PmDN7Am92anJ3w+2U6QHfhG7MjAie5xXtL2rRG62c+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5QDEO2t+0X3oh64KimCE3XQBHWOwdg3Bvho9xANL2RtjWXoCVnLOYpNGUl3DSD77yyId7EGnw+K+TnEt1kQYbcVmHy8IZsJU6Axn7Hl/lCEJgGtj2kCsF7dzimm5LAEYR3F/zASpG7DYVrQAdfC9mlBC/4O6AvaqUV7VN0RpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F+EgUh73; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F+EgUh73"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4c68f0e47so835919a34.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771086489; x=1771691289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+8pno1sBRzUIHg5L96yyIS/XItd6cwvwphuXPZkTb8=;
        b=F+EgUh7392wzMqvDX+7AIZf4JrKmuOq7vo/q/USjfC8LYhXQOxraA2GiUgMpdqwWWa
         w6wAuCOMeeWrEVAH/Iev2mws+jK2q6p+pdCt4I/XDzvomJzdAbTR24V7Cu3uHNqRfynU
         ZLnzIDBThoxH+c8ht0xJBcTXuCGlHpofFAsqA9nT7Y1HtDGuETbJkNDOZjKNIiHczBG+
         7Tf/0naDS0c2fp4ghTXpCcZShtNC4pLMAriRQjnL+f98fRfUoJWOnSgw2ETDPAOD075Z
         IF2e2LES2KxSI5BeAwV2450JpEs28tjF0QLjdef1ZqdB69cHrzTHYSFPLeSM3IXHUtV4
         /LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771086489; x=1771691289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+8pno1sBRzUIHg5L96yyIS/XItd6cwvwphuXPZkTb8=;
        b=oSZrhvan4u2Z1wA5KZIn239p73IsECkfIdid40/EBrwvSv6+rcglX5xP7IHBqI3s27
         x/wIjTXeWSWZm12RsMI6FwvVEDEZyWlZOHrC16/jbdqN+CIrASeLFCs3CLYQECiNJUXX
         tzT/xylSglvYq63raY4W5LZsmqU5uRoH3EhRc4sHqiU6pW/NrPF0X2ODpizK9VVCtVM0
         MS1vRx4/ihrUgGfMLutFSYO4uFpcWQQTAlFIfCpbNXyV0eKRN/gTWp2zEBdVDGnowgT4
         8G18GbDk3C85Gg2WbqUq9UPCm1Lwzjf0fvaqtSShOH6OdsmH3G1Wf4+7s130FSlrQ2ZW
         A+qA==
X-Forwarded-Encrypted: i=1; AJvYcCX/AVZcTvjz3F4U9DH5fYKbXKkN0ZDryuBXKmzs5Kw7+bXT7svWDtf4CjPADtjyhqw7otuskGtq/VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGrug+HcZMHqcWHB6sF196lY46A9cUwyfmK8/4hXz7BZ0djCJ
	NwsBFTeoJ25SeFuzG0N9pdO/T6qdzZU7k1oOZUfHCZQP8+joHEI+dJTV7r2FYHyXce/q+UUoIe7
	mIrNA
X-Gm-Gg: AZuq6aI2zckiqNbqW584K8eBXMt+SaBKa0V2yb0xfzzRue3ADifDPtS8o3SXRMrXtkA
	NlToGhkwXM4j8W6pk5f81ZKusFsCFcVVuvp0IGht7ztJrwAc1QTE4eUaHd+OSzB8D1inVUqN2ta
	vYYqEBJxdZ9Hf/IZgZzffdIKy6UbLfUmjYGgamwEQV25HuWcBJYFLSrjL/9CBsKOqBpR0NYcMMY
	Py3sGgjy5kyL09jSxM93f84RCP943oC3SrsSm/hXKj6grmZRjsh610Y7ysBBSBqkOlweGOtHXXs
	jkIfxHsMAPfL6/X7OEY4dnnQWbGGpj9mWElqpHEGpnG0q8xyg+PRObVKZ6qmT10WS9FFkIlSkQp
	1f/wgUVRAo2uIqKtnW5f6oZZ18AzVpVonKOTwZep6YPAbLW9gDGRnHKxrWBBfjlKSeJ4q8WZarm
	ett76Wra5qPexYc6Mqa/hBy9sQrkr2cLmWOIa1WzTTYSk7q3748fg91+tjT+fcsecYOKWijg==
X-Received: by 2002:a05:6830:82bd:b0:7cf:d742:9d79 with SMTP id 46e09a7af769-7d4d0c42385mr1394916a34.30.1771086488880;
        Sat, 14 Feb 2026 08:28:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:109:393c:254e:962e? ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a75309bcsm8614464a34.1.2026.02.14.08.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 08:28:08 -0800 (PST)
Message-ID: <39707e67-c184-47ef-9e42-fe322f237081@baylibre.com>
Date: Sat, 14 Feb 2026 10:28:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
To: Neel Bullywon <neelb2403@gmail.com>, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260210233945.40975-1-neelb2403@gmail.com>
 <20260210233945.40975-2-neelb2403@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260210233945.40975-2-neelb2403@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/26 5:39 PM, Neel Bullywon wrote:
> Use guard() and scoped_guard() to replace manual mutex lock/unlock
> calls. This simplifies error handling and ensures RAII-style cleanup.
> 
> scoped_guard() is used in read_raw IIO_CHAN_INFO_RAW case for a
> multi-statement mutex-protected block, as well as in remove,
> runtime_suspend, and suspend where a short mutex-protected scope
> is needed for a single function call.
> 
> guard() is used in write_raw and trig_reen where the mutex scope
> extends to the end of the function or case block. Case blocks in
> write_raw are wrapped in braces to ensure clear scope for the
> cleanup guards.
> 
> The trigger_handler function is left unchanged as mixing guard()
> with goto error paths can be fragile.
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 130 ++++++++++---------------
>  1 file changed, 52 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 6a73f6e2f1f0..5eb710eb020d 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> @@ -456,29 +457,22 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		if (iio_buffer_enabled(indio_dev))
>  			return -EBUSY;
> -		mutex_lock(&data->mutex);
> -
> -		ret = bmc150_magn_set_power_state(data, true);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			return ret;
> -		}
> +		scoped_guard(mutex, &data->mutex) {

I am very wary of scoped_guard(), especially in case statements.
There is a hidden for loop in the macro, so if `break;` is used
inside of the scoped_guard() {}, it will only break out of the
guard scope (for loop) and not the case.

It would be better if we could use `guard()` instead (in the style
that Andy suggested).


>  static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
> @@ -980,9 +961,8 @@ void bmc150_magn_remove(struct device *dev)
>  	if (data->dready_trig)
>  		iio_trigger_unregister(data->dready_trig);
>  
> -	mutex_lock(&data->mutex);
> -	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
> -	mutex_unlock(&data->mutex);
> +	scoped_guard(mutex, &data->mutex)
> +		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
>  
>  	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  }
> @@ -995,10 +975,9 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&data->mutex);
> -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> -					 true);
> -	mutex_unlock(&data->mutex);
> +	scoped_guard(mutex, &data->mutex)
> +		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> +						 true);


This way of using scoped_guard() is OK since there is no { }.


>  	if (ret < 0) {
>  		dev_err(dev, "powering off device failed\n");
>  		return ret;
> @@ -1026,10 +1005,9 @@ static int bmc150_magn_suspend(struct device *dev)
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&data->mutex);
> -	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> -					 true);
> -	mutex_unlock(&data->mutex);
> +	scoped_guard(mutex, &data->mutex)
> +		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
> +						 true);

This one can be regular guard() and return directly.

>  
>  	return ret;
>  }
