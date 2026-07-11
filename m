Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFD2D0603
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783799513; cv=none; b=IU8oowmiluzMBhFyyzMxT0R4sl+tUGoUYFsCZs1evEs4JoRSMTjVvwGoBhvZo1Cz1Y3VpuiIx+W7/x8Nch1sllDec7N1kqavXmE3FWsxgFRvY5cQfiEmrOOKzzB3AxjuhBqSX/cfy9tO2UxH91usxwuoPKZdkAJKCp7RkrbCVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783799513; c=relaxed/simple;
	bh=4p0OwckIoK1pN5+1/GDFed8lvvfZBDCWEOIV0U5JO2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkladb25t8/aE8Pm/d0CfyWN5rFTkyQp5DKnwpve9CF0al1y5N8D0kz+wd7FgqYbVWxOEkstJa4lYo63YBg+FWpMySdLYtsVtf2vKFK6MN3C3acbdpGYx2ohtB0wAEIH1Q+qs7eK0wvSvTtmmUNA4ceSLw/3RTKB59JFCYi3Ui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZLrlG9U2; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZLrlG9U2"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-448cf99c133so2526750fac.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783799510; x=1784404310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAPzwDmfVpjdqQpz/jSP3klJkP4Fm9YGE/ryylhJqeg=;
        b=ZLrlG9U24rJa3MImVoJM5VPkRg03hKdqXsWv+BUiG/mw3REfzw20SwKraKLE+4zXdd
         N/3ME3JYLqvf7yd+rUAZ5EwEoorjt6BnDfLzm3XJRMPTEmQ3ciKByPy69QipKDsEFBYl
         lGaA+GWUMrRQAt7grwTKCt2Ks5pNzlHjS8vjHpo97xFAgTrhYaS6V0eRFyveZ8hKbbou
         rK9Ghv4DjegXibcxfOUsXcAhwmPRfMYTfFnOcdyLJ7DxNEoy5kBLfyVeac239uRIK52Z
         FuYPx+N5hKntoRBKGlzHnLHnqMjaYez1xWPqxZHK5OxXrL1lPJhP3ErV3DBIUhi8PqI7
         t2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783799510; x=1784404310;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAPzwDmfVpjdqQpz/jSP3klJkP4Fm9YGE/ryylhJqeg=;
        b=TyFnOGoSgZrGJj2AIKXEiM4ZYSPM+4lNNMQn3DFQFwoIc8vvZq5vSUWoAlyXvGYQgT
         rcylLq6rcxrFj6kt2y3Pub4u/2+RWnXYSK/pQAga5qNfJm4W3mIPEGB2QD5plR932Jtr
         oBNmUpHpVjr0m9Op/4sEm4Z+s9JzNN86X1+pVZJcYWsfBAnRhtEcDRxAIl4rF9pYFBWj
         +lTW2zKtiy2uFzpMvLSQQdgdMopCerUuqxxCrvh6d5mJxTPENbsyzQ1yH9nzcfljDZ45
         SMNLqrDqJZ2aAlCr5SIj7PsyvXPNiFd2hGsfq+tnuNX+EwGHtXvFwoHUdEDNed/nF/0I
         F5Tw==
X-Forwarded-Encrypted: i=1; AFNElJ805568ciVLuPgxhvSd7P9p4obpp7Z7226yXiqOdVWRX+J/rkUNRGfMqEtc8jfVQtW16g9DzUFOKfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VS6iUqGD+4ohdSS8rJT3u5vmeNkz7Gxwxp3qbjSielfqx9yu
	vcOlbHt5xZkfJ23T4bpHAuicvFB+FrU5YyJ9gu7wp+zvP4jqQOyumr7p2qofy0ZIv80=
X-Gm-Gg: AfdE7cnxBpAoYAQOH7mjuMJaMzwaTiK2KBS9ZdOLRcEFLF6HQvJrplTAcdNe1ZEGPgm
	0PpTQyXlRXdKQcTCYD2xC27lRoEm6dU/ABKJeyqyyB/Uat+5UzfermxFNvT5sH1MPI3iVQWOItS
	qKStDaSfg0EpsnHr8Ma8MFX/t1qzTYUVJnVDdBn+bemyW2Xg5q+Nm8bbwO4oQPgp2GTEqCDluB1
	CeMvAraE4MM6JU2hXTmDBDe+d5bguVrKrKOR/+rsbkDwypdo6bqW4kyBIDOYU/WEIrkzRz+E7fJ
	bmMeLiSpf5mT+MUnwFp3Jxh/qhZsr9tdZEiQHbmoNdozXV2t3ig/MxL4wmC7sP3LUgOAam+rmA/
	80JNUcatHP+Wgk7MbWRI3DvC6NzC9YUYS67x+loAnQUVX02krDwUbGmg9MF2ASfowFlwY+w06g1
	FgZx8ODIO/saUxaPZaURhJPesGvGgV9WJ8L88dK/K80gKH/8ySir26Yy8H6LEIrfk=
X-Received: by 2002:a05:6820:220f:b0:6a1:1ccd:d09d with SMTP id 006d021491bc7-6a38ba6522fmr4279988eaf.42.1783799509995;
        Sat, 11 Jul 2026 12:51:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4519d89f7desm7532770fac.7.2026.07.11.12.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 12:51:49 -0700 (PDT)
Message-ID: <76607231-351c-4730-90d4-c7944e458b97@baylibre.com>
Date: Sat, 11 Jul 2026 14:51:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz, jic23@kernel.org,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
 <20260711184414.1013686-2-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260711184414.1013686-2-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 1:44 PM, Jakub Szczudlo wrote:
> When device is suspended and it is in single mode then changing
> datarate doesn't make it actual wait for new measurement, so to

s/actual/actually/
s/for new/for a new/

> be sure that read after change is correct functions that changes
> datarate and gain will wait for new data.
> 
> Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1100.c | 67 +++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index 9fe8d54cce83..6ad80d42d390 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -15,10 +15,12 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/time.h>
>  #include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
> @@ -43,6 +45,9 @@
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>  
> +/* Timeout based on the minimum sample rate of 8 SPS (7500ms) */
> +#define ADS1100_MAX_DRDY_TIMEOUT_US	(7500 * USEC_PER_MSEC)
> +
>  struct ads1100_data {
>  	struct i2c_client *client;
>  	struct regulator *reg_vdd;
> @@ -123,10 +128,46 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  	return 0;
>  }
>  
> +static bool ads1100_new_data_not_ready(struct ads1100_data *data)
> +{
> +	u8 buffer[3];
> +	int ret;
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return true;
> +	}
> +
> +	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> +}
> +
> +static int ads1100_poll_data_ready(struct ads1100_data *data)
> +{
> +	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +	/* To be sure we wait 5 times more than data rate */
> +	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
> +	bool data_ready;
> +	u8 buffer[3];
> +	int ret;
> +
> +	/* To be sure that polled value will have value after config change */
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return readx_poll_timeout(ads1100_new_data_not_ready, data,
> +				 data_ready, data_ready != 0,

This is a bit confusing. The function says data_not_ready, but the variable
is data_ready, so when data_ready is true, is it ready or not? Also no need
to compare a bool to 0.

It would be easier to understand if the function was named
ads1100_new_data_is_ready() and returned true when data is ready.

> +				 wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);
> +}
> +
