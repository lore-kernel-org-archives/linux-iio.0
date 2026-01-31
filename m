Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D3332907
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895097; cv=none; b=ZsPMo/0XAVU2aeqW47VBkrh3m8jWZfF+T0Gqm1o4U1zNU7I/Bpc2OZDBi0j6AbF5ovQCcBUW2EfA8bIYc1m+Xpt9B5fm0G5qZP8RZzqJTYfzeeo0ZfJj9f351wZKHdkJ5YZHxeajGRxI3dVJNbDxmwKjcbqLsYmgE9eWW89VTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895097; c=relaxed/simple;
	bh=ERnv3otAcYg//bBxuwJmzFwm1JYlCphbavP5uFY2jcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lU+H+3+3JdDOGDEO866LVVVn1M/PXkfQlnt6C6O2j7WoGTPuCcc1v/606ylS0xRFdciQ0NK+XD14tC+6FejyrJVRUZPNet+V9Gf7d3bsnhcpXYIUvGVEl0f8f6Eyjql/EBBZfy1jLnLN176D/6vku7hxyBAFzobOSFFa6nGYmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wnDeEaXV; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wnDeEaXV"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c93313721so2158122b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769895094; x=1770499894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oN7nfsMLYgFLh50J5K6u/iWba/AywR5N7bpGoZqwJBw=;
        b=wnDeEaXVLQN+ycjBxkW6hwwuh7FHoCypHz1GXYVtdx/OFAFeGZs8pojxxU+Lo/48iY
         NR2ZVQbVSF6J6z8Ulw+JDhIo0VjXGAUIlPp1NfxHp15MQq46yalPPAQAE7wlaJctJd7i
         21OqRyiGnlSMIR9ISZpIRY5IYXglot7P0D8Tup2qSA2fBZpWhvBOhHQj6GmpwikF1k15
         DOwjw/TP/o5aPkcgD/vNmwRAIruyskVoqiIgAgUtzCPZPDMn6XgztlQkKfgUerjKbEPh
         15tEPBT4+0G3v7w0wNT2nT9P0QpQI+iMWAzPD2TTFPbjaSLyrd8251U6kr4LZNJVEdp4
         vYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769895094; x=1770499894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN7nfsMLYgFLh50J5K6u/iWba/AywR5N7bpGoZqwJBw=;
        b=t6q3F/diqxc8v3rjCRFfl/BhHD+nm38569Q7502NSqq6UEZ7womiSA+1YYTPwGRwJL
         gcwoONKQtVJ9XKo6B+P0XZS7wHxIg9HfhvlPj3fwoJl3c31tL3ZwcSA/ZqJijiWLa0xl
         OyLYqF+DOpxRPBaQhNQ4Q2AkJNRZ0+AzeNx2nvztMCrUR5yg47dz4aZe9hhruOJXRExg
         pVsLnaxS0cSyA4M/DOIOK5M/FqAU1sdJQHee6ZlU89UmAbAPm1jVNmrvmZX5zBwmMwBo
         HIx4AYo02YmIyB68ovCegjMdbAaXtnInGGuhN5l6zyuvdKnMvzJWHoMjvTLhrvMgXvFk
         Qlew==
X-Forwarded-Encrypted: i=1; AJvYcCUESUPZn5ceoMiIS//zjW+kv+XSJRCHdGaDEdmxGoHQaA9fGdN7oxZz3JiKPbbRgqp6I0Iaz1ypKOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8p1O6vJOpmZOf2nE+EQfe0ItwGCzMvwcPUkpHfRQ/HawMz2RZ
	pOmgPyxvEoVMgyKDh8UIk2Zer3DrJCtauRFYRrvu9bq6I+0znVGju04Pfgotk1Z8TUs=
X-Gm-Gg: AZuq6aLhSyexa8EUS5xWzDFuj4Qcq1hRCs05sxK7T23hol4MvqP4tJI+xwKUdd+Ei2J
	vJBElBjyrhqCwjxuCF9B4eFgB+cONGjqmaFlC9Hwsrs/BC0PgXxl5oHbUcA6U8q+1rsvHyxNsr3
	oJ7aP5zMlIDjUqo6uPshgKdr/3G6p5qldq0pSOkDbxq9+47wEbJOMit7zQjvr7UgewyICuy+abP
	MgjL8X5oWj+uMr6E/bsWPrJezHET8Vj6yK4fBG81/TZuFdkZhm6aEAKLHMeB/rCdsrToeNE3V2M
	bFpFUZSlm/s3OdDBUh4Kvp0KSoIZSrihJ+z4+kjPINNnWwOJNFL2kpptp2fW6pZ1Q5t1A4KtzzN
	eZQKblyByDVGSm6oCCQbPkPQglvlGpgI+R3K9BhkWHos3InoDtfNrj2UbzL5uNx/zDYARUI+YMF
	nAxDJQxGtVmmzf7o7wpciQ80yVCiniw7LB5tLsjuCGxGFlwvmPHcaDOL/6+iD5
X-Received: by 2002:a05:6808:1a19:b0:45e:e52c:8a9b with SMTP id 5614622812f47-45f34d98b5amr3091519b6e.59.1769895093915;
        Sat, 31 Jan 2026 13:31:33 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08d894f5sm7181770b6e.5.2026.01.31.13.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 13:31:33 -0800 (PST)
Message-ID: <629d8505-c4ba-4089-8dec-d627e3acd337@baylibre.com>
Date: Sat, 31 Jan 2026 15:31:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] iio: dac: ds4424: add DS4402/DS4404 device IDs
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: David Jander <david@protonic.nl>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
 <20260128153824.3679187-7-o.rempel@pengutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260128153824.3679187-7-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/26 9:38 AM, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Add I2C/OF IDs for DS4402 and DS4404 and set the correct channel count.
> Follow-up changes add per-variant scaling based on external Rfs.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
> changes v3:
> - Reset author to David Jander and added Co-developed-by tag for
>   Oleksij Rempel to clarify roles
> changes v2:
>   - No changes.
> ---
>  drivers/iio/dac/ds4424.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index c03051dc763e..f340d491fcc1 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -35,6 +35,8 @@
>  }
>  
>  enum ds4424_device_ids {
> +	ID_DS4402,
> +	ID_DS4404,
>  	ID_DS4422,
>  	ID_DS4424,
>  };

I suppose it was already suggested in previous reviews that we should
be dropping these IDs and using device info instead of expanding the
switch statement below.

> @@ -237,6 +239,12 @@ static int ds4424_probe(struct i2c_client *client)
>  		goto fail;
>  
>  	switch (id->driver_data) {
> +	case ID_DS4402:
> +		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
> +		break;
> +	case ID_DS4404:
> +		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
> +		break;
>  	case ID_DS4422:
>  		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
>  		break;
> @@ -278,6 +286,8 @@ static void ds4424_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id ds4424_id[] = {
> +	{ "ds4402", ID_DS4402 },
> +	{ "ds4404", ID_DS4404 },
>  	{ "ds4422", ID_DS4422 },
>  	{ "ds4424", ID_DS4424 },
>  	{ }
> @@ -286,6 +296,8 @@ static const struct i2c_device_id ds4424_id[] = {
>  MODULE_DEVICE_TABLE(i2c, ds4424_id);
>  
>  static const struct of_device_id ds4424_of_match[] = {
> +	{ .compatible = "maxim,ds4402" },
> +	{ .compatible = "maxim,ds4404" },
>  	{ .compatible = "maxim,ds4422" },
>  	{ .compatible = "maxim,ds4424" },
>  	{ }

