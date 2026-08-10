Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B279435516
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390115; cv=none; b=hug/oxUD6DAe53phF6Koan1RiZX/oeKYMI1w5DOyN5MnUK2UkvVhO5ynYXUKDgMPWcDlbR3tQK5xVdVFSbQpWHD5zdqwoM5fuQMl3jegw3wSlbrHljUIN+lQsr9UNxThQG5RlX2DHm/TAxam9d1gXOYAIjFWcUlIu1O7DLAL3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390115; c=relaxed/simple;
	bh=+sEsScIM2qAs6sSevujTtRTZbuA1fPGvSKnZmuUlN0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ0Vs46yIwgiTzJfZTYMQnxPo+Fh+Dql/JzcdxnYchYAj8PBq8rtx7Wq8YbxAOG9vwTMbiLBNji9Y5k0hbUxA5ytRsmQMybXGGIdSRiDwBN3GqshsI8ctvNrZS8MtqoGNrs/gbzu9voulx+eC7BvgPg1Cgv4VLvIyVexFdgZzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=djnV1KVU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="djnV1KVU"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43bf9548df4so1383309fac.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786390108; x=1786994908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgO72jJ70tMCTC4c4xhvVwaNiqswCBephsns35OjoNk=;
        b=djnV1KVUha+eAWHZucV38daFaVj4Z5bKkQSASbLABgazKggzIYw+760wFnllNMr3rU
         nDGqJQXq/hAW+zFlv7DuvyBhqkHBHLin9zVKafWix5FcbDRzl3qGYsXmpfay++B8r+Ji
         cB8gdRWOiWhrrqUfxj2FgEVfsafwylj+cPP0BjQxc1bsE0S0uXbvnXG6aZEoL+td+GfR
         HDBDsMXB/ZObrVxigWElp5OeHvaMb2SuZWloAKjYxiN/Tuhnt3lf0JLsEgwREKK2mQP8
         b5N6Z+PHXJxISnI1lc21iEXefNDgj10gVmLyXh2+j4OFjH9M4Wi0/NT/39ypJ7ynR6Gc
         UO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390108; x=1786994908;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NgO72jJ70tMCTC4c4xhvVwaNiqswCBephsns35OjoNk=;
        b=e/tkyNmFw7NT7cV/oS3UXJ8i9HDsgjIif9t0QdCl/dJD5SRUpeCDJRbrKf2CZc5VbH
         elXVNP9qtKi5QgIy5l3d3nktEdf9UWfMZpNXPmTCRY/M8E/coMVI86oQP4X/h2GjDt6O
         IJpwyppf0D2pUU93PXahKJoP3CHGT270atQ3GgylM+6nKY9St4v1xakff4Yl0VBSLuoU
         emoKsybju1dRgRazC2l3pCiUce/SmYDwN17YOrOVbx6p8fND4UV95FIWyiKrXn6r5MC4
         sz0pwP5QLBUWewXYZzCJofhlWrUv6EdGlgB74yDb/I8X9kzVSpeP+mI6hTrH4U31rhxG
         0p+g==
X-Forwarded-Encrypted: i=1; AHgh+RqxK7gmu5ELBihTPweKlxc//SkJ5XrF8j08ws1UoNXHc0S8/x+zSaGXHjmSYltDSetJLCH7/8iX86M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgb7o5VIpDylTATFJwIxk2Hp5pSm1ZIKXZ1kOeL7CTTwXjFYT1
	n9Q9edTdIpsdxQGjwgNbCwK+VVOaX6MtqAiANFzgOiCGQWmuk6Of4fM8nQ8dNxnAJjQ=
X-Gm-Gg: AR+sD12fA3oVfd2VMNBaYBZ475l95J9ewqeZ34UjrviU5BDFpbN8SiNJeDVnoOilnx0
	TgGH9mCtJsXyzsMwa6JU5wTuRPRCsydLlhV1RH5Cf1Io0uKPzdFLEq+KjzXkPHBOIEowPd95APQ
	ovn0NDpxX8UHuO/b3/fUxE9Af3awewsPjQaQ1ZounBE9JXPzFC5JpdL1YCJt05rUFErkcOfZ5Cq
	6fOMes/VZwvZCybw8d/MIF399WNrTm3soFGV1y7SWYg7Yls81eN8S74kUWu13iq822bHP5RWNXd
	w5AeEK55kcip2+Obv/9ICnxsdkdBwTSRU4qdEcUZrzjSKIJE+U9GhTzx13xZ8VTzJQv7PJVkEv4
	pZvNQM7FA2i1B8hL5FByoYoWQvmRbG4xzK05o9wt2lIrSS7NHEX+FK6HDTO9kGuX7eHHwbkWkjV
	SQ5JP69BvfuQQKmDRTMWph1LUcqUtlzStC9DP1RukelIasBliAP99jYqrdvUv6hxjYaB9BDvlKu
	DgRWedkpeZKAQmCiDl06EEy6OMc7NJhnSO0R5U=
X-Received: by 2002:a05:6870:3d96:b0:441:f3f6:622b with SMTP id 586e51a60fabf-45e0552f4d0mr2384263fac.5.1786390108284;
        Mon, 10 Aug 2026 12:28:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e05b:7923:cf50:e4cf? ([2600:8803:e7e4:500:e05b:7923:cf50:e4cf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1a76701sm8915038fac.5.2026.08.10.12.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 12:28:27 -0700 (PDT)
Message-ID: <ebca396e-1ff4-4723-b46c-de407b051767@baylibre.com>
Date: Mon, 10 Aug 2026 14:28:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260810183337.451812-1-nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/10/26 1:32 PM, Nicolás Antinori wrote:
> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
> 
> Add the "am2320" entry to the i2c_device_id table.

Interesting. No devicetree bindings for this one? What kind of
system is it on?

> 
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---
> v2:
> - Adapted KConfig text using the suggestions from v1 by Nuno Sá and Andy
>   Shevchenko
> 
> v1: https://lore.kernel.org/all/20260805183733.1000550-1-nico.antinori.7@gmail.com/T/#u
> 
>  drivers/iio/humidity/Kconfig  | 8 +++++---
>  drivers/iio/humidity/am2315.c | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 54f11f000b6f..10598a0b15bc 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -5,13 +5,15 @@
>  menu "Humidity sensors"
> 
>  config AM2315
> -	tristate "Aosong AM2315 relative humidity and temperature sensor"
> +	tristate "Aosong AM2315 and similar relative humidity and temperature sensor"
>  	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  If you say yes here you get support for the Aosong AM2315
> -	  relative humidity and ambient temperature sensor.
> +	  If you say yes here you get support for the Aosong relative
> +	  humidity and ambient temperature sensors:
> +	  - AM2315
> +	  - AM2320
> 
>  	  This driver can also be built as a module. If so, the module will
>  	  be called am2315.
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index f29baa251f9f..5bce5eec45cc 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Aosong AM2315 relative humidity and temperature
> + * Aosong AM2315 and similar relative humidity and temperature
>   *
>   * Copyright (c) 2016, Intel Corporation.
>   *
> @@ -251,6 +251,7 @@ static int am2315_probe(struct i2c_client *client)
> 
>  static const struct i2c_device_id am2315_i2c_id[] = {
>  	{ .name = "am2315" },
> +	{ .name = "am2320" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
> --
> 2.47.3
> 

Currently, the driver sets `indio_dev->name = AM2315_DRIVER_NAME;`
Usually, when there is more than one chip supported in a driver, we
want this to be the the name of the actual chip.

(And we usually try to avoid DRIVER_NAME macros so removing that
would be a welcome change.)


