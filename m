Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A933508E
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782599491; cv=none; b=DX29opZF/T0g5s0dL3M5f7cfprcW0DKD9MT+T6UJ9kRRwzqzuL2OZUDa/UICpNOrYLAFQtym3D5uLGeGDRtTYmE9v4ZMV0WQ6K7om3u2+nwNTJROFc3/QZNfHoFMU98Bmxis4Bieyv9bduqbSoQUS7WHlWTSxJu7dxQzyPcfCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782599491; c=relaxed/simple;
	bh=tOP/ncqJR9tQ1Kpjwwjs1DsUnFQQsFsCKUquXTGz2FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzWKce90OpZ5dk6C303nhu0mF0+iGoTdxTgbY+I4xO4jBIu4uv1YvzxiRMsxw6o4gGbdDfXinhTO51jST7NqdhKsm+xoanuWgVmyP32XfoHj4iLwpVFOLG8d52/yDI4+/TRxNzfX9jurRFQ+1Iy9l60Seuy+tzCPlcq0jkbTQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LgYv+/Ym; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LgYv+/Ym"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2423870a34.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782599487; x=1783204287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/hsn5oXO1Y2F7PgZaWccBbIlkiaMD42rC1dxoRTlLw=;
        b=LgYv+/Ym15oHC//cSW2LfJNH1Ubfm3aUOwTB4okduiBf9SGpuKhaLgUz7Y36jtTkt+
         ezbp8ZrLhbIr1ImStGlUe9Tv4a+w82A3uzBwz2oOj0dSkpZaYHyq9t6ADlF21DjuX7+Q
         FYB2mzPljP1wCnCtqZIURZU8zj0AdrLRsWX6v+8ormaR5zWwmaZAN+FLdxP+/UNfLivM
         6DznYiwJTUX9+7/ntnRaB8p+HFaAScRWAB/lPM9SQiWQ9NIgrgj5NMwmX/6q/nyjeUeG
         eDILeng3rQg7kEOHCGWSB6iJeqdFJbYkNW+szDLyMsLRwbTTS/YlRSFAdZMCh1ARoO7G
         dzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782599487; x=1783204287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/hsn5oXO1Y2F7PgZaWccBbIlkiaMD42rC1dxoRTlLw=;
        b=ZT7WJiYrucro+JS/ER9I2Jcv3ANOfh6n3OZgVXeD63AMKN+fQ4axjtHJNEWQwpuoHy
         n44yd2SJoUM6LhjGJ2CbUStbjhfLi17xYkbqhUIKOQkKEtQWqN8s0r5ce/DQahGk/nei
         7JXcYjuRv4vob1z5c6mcVGXxsjZj5URDYo8sE8aQ+AzV0+iGif3BbOlbEgNXHkPrqDdt
         33kdJjFOkmBcK1x+0SNVfgX0oFtOaDnNq/+Gdu/PB6ZuljWo42k2qxEWTFP3w4RUr2oo
         zoBxNp3JRciGMG41XSpaP47ImeBbgYE0IbvXCCX4qAx0Z3ZIm5+bxOks32CMviWCDRdd
         tESA==
X-Forwarded-Encrypted: i=1; AFNElJ9uFQgRBVaTSZH1oo3Zapd2y9yhvVyCf+8h4UOxdLorS4A936C5PzYiCY0PMUON6RD7kI8/cK4tBKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6wOi1dsj7AeerFLK6UHSw0X/6rfS8VcI0K1NeW53uzqyOCl7
	T03nbZf9jAlzH+kW+sl8plrCncM3b/WVHPzpKeQwgzknTdHWNOdYBqFlFVCuEayD/zo=
X-Gm-Gg: AfdE7clEqAk6Vfn1JsBU2+MHpvBF7xyVGuuqwKVKSxqJLp0djIXEJlpim8990ftdrx7
	smntmxYw0dY8oTYM82PZHDHL0FPWFQ0WFN2auRcgWOA/1jZPmEUik6+CRkR1xEopBsG5ROx1/pM
	yXLTt+E81zinD/Sb+ozb1bgo62gL1ANlYWj4O5Ch93Ffiqp0rPyy+v+IKxOwUUkhvfvzIaDm4jl
	bG8vJChPR8Ke7s+z4Jh4SudQoPkeVq654N4GHNpjAHJhBUMhs0aJKPJ7luhRuppC5it+GwAgIYU
	7I2w6QiIlpoYp0IOxlT56H1JXS0E1PqmqoZBTiI1hJOjDL49ytzniswvp82JgxB9wDBg3Ptesss
	/ZfmH++QnvRBpmpsBuiiB8jQTD5Gt19oLSFjnSwEAH47VsqtYltia2W43UliYvPhSpH/4+kc5bt
	wD6KNbZ+9/y8K1jxlq8VKpEYxk0mNzqmzA3PniPdYo2CZeo1OvB6/WVLPs7n8rA6CLUe7NH+cXb
	A==
X-Received: by 2002:a05:6830:6d52:b0:7e6:ef1d:4aeb with SMTP id 46e09a7af769-7e99c208aabmr10277232a34.15.1782599486759;
        Sat, 27 Jun 2026 15:31:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9b292029dsm3805497a34.22.2026.06.27.15.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 15:31:25 -0700 (PDT)
Message-ID: <5e96801b-50dc-4752-8e00-1a80984ed997@baylibre.com>
Date: Sat, 27 Jun 2026 17:31:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz, jic23@kernel.org,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622221550.374235-2-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 5:15 PM, Jakub Szczudlo wrote:
> When device is suspended and it is in single mode then changing
> datarate doesn't make it actual wait for new measurement, so to
> be sure that read after change is correct functions that changes
> datarate and gain will wait for new data.
> 
> Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1100.c | 74 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index 9fe8d54cce83..e3c801381434 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/pm_runtime.h>
> @@ -43,6 +44,9 @@
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>  
> +/* Timeout based on the minimum sample rate of 8 SPS (7.5s) */
> +#define ADS1100_MAX_DRDY_TIMEOUT_US	7500000
> +
>  struct ads1100_data {
>  	struct i2c_client *client;
>  	struct regulator *reg_vdd;
> @@ -123,10 +127,49 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  	return 0;
>  }
>  
> +static bool ads1100_new_data_not_ready(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));

Do we actually need the cast here? char * is like void * and should not need it.

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return true;
> +	} else if (ret < 3) {

I don't think it is possible to return anything other than 3 or error.
In other words, short read without error is not possible.

> +		dev_err(&data->client->dev, "Short I2C read\n");
> +		return true;
> +	}
> +
> +	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> +}
> +
> +static int ads1100_poll_data_ready(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +	bool data_ready;
> +	int datarate = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +	/* To be sure we wait 5 times more than datarate */
> +	unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);

This is a bit dense making it hard to read.

Also, it's always helpful to include units in variable names. wait_time_us?
data_rate_hz?

> +
> +	/* To be sure that polled value will have value after config change */
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return read_poll_timeout(ads1100_new_data_not_ready, data_ready,
> +				 !data_ready, wait_time,
> +				 ADS1100_MAX_DRDY_TIMEOUT_US, false, data);
> +}
> +
