Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903F346A13
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411327; cv=none; b=TMXAxrhtKWce81zsPhg/L2BMISciskl1QivUOiRy7UWR3ZmRWldN+Q5jVfIi30Rtbs9XCh7ALIQN7tJAMyaqqBEE8hYCs9BmGhVAMX2NtFJXhJso1h1+XV7vAHdi7LmcsYY3Ca44zQRGshw2Ty0FLRWjgxI0BTkY3ayLQTQReHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411327; c=relaxed/simple;
	bh=ZGytYqEX2FjxI9WU1wyvr77fGx2W4rcnrtV9rogJmhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbtK4b7S/lD0nXaYgEh/6OR6NG//Uy2a5WEfaN9XUolHyNZOP1Zoii+sBOatwkJFBb5ZndmEcaeTcMnZd7jbKfonDIpDlFTVW8kxg4qbvT5mzFqvwtjVJ00WXUxRV7UbHFK0OO/eNr2MFz94boAlO1BTNtxo5o/Nz1nmc6Lqoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gUAGzC9u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Te0OqFx+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gUAGzC9u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Te0OqFx+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJpg5r1517889
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	avKXANQBGVgCgArhixN+M32W0hqymgfFtIpz7f8pBnE=; b=gUAGzC9uzgLd3pHH
	yaLE7iMFzzaCxUFwC+GQrqS04OLch6pkMpCXrgSoPjViN799e3ZZ1nuQ7a2Y1xls
	wx8QmWrFz6RFKdHrHMf4i9o29Atityr3ogVi/x2A97KIz5qMI1asWzyk7GTeJa4b
	GUtjzFBB6ZtyGY7GRI+dpGaIrsjBzRqgXq3i3tfyXW1pOJvBwMnYRe1g4K+p0P4x
	QTWQoQW/hw9Df3EwYdXnt0g8TjLg6wKVMpcB7yPm/4MqzzHCOGsNzIv0raMAIb6z
	tQlJEOpQP3TVTeXjLyuTT7CqLHjEIdZjtmnFAYp2XF2um/uGYI8P0DGwR5+7tm2S
	QWsf4g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnhkak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:48:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso158633865ad.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784411323; x=1785016123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avKXANQBGVgCgArhixN+M32W0hqymgfFtIpz7f8pBnE=;
        b=Te0OqFx+9QKP6pxtmZR22l+qIGco9Mhd17clD7e7/pu5+9teQyP1QhtfNOc89FRqin
         PPtghjii2UuwhHOi/lhztGQCpZdRJeOb61aunjBaomUv7p15l5YC87HW76084tHEtQyg
         fRELgITDDHW19sjF4GSSMTqv0tF0Pk9eb0eDKJxYZ3bNctHlK75OcTrYYhxHDtVMDhfb
         76e6HTFyKbV3UQaEQ8RdHNMqmVepWvLmuKpJS7qk6BWoWBwHWx+N5gxBOSsTA65xUWAH
         8tyUrGtOBInvTo+Va8UGkROgi75A2f7Ksw7LnqCTIjK7BFuFq0NL5RIWmgLSl9ivQisv
         bR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411323; x=1785016123;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avKXANQBGVgCgArhixN+M32W0hqymgfFtIpz7f8pBnE=;
        b=hzjI53leqit9awYeXN3bO9t4S0BYC6c+NQLbjSbbhlHrSx0vLpDKHzBVWHZNCrb2UO
         k8B1ysO4++2k2CmgS4PWunYf8srahrcqTqoATu6RNWKWiG+bkjHGtuFZjdO8se+9UNI9
         kfI7mZJj0KMp7JsqxGzQAu54SapqNx0DVTL2L9hcrbaBJ1MhaNWlLxum2VWKQLHifm6K
         wrWljoV1lg6U3VUwsSZJULWAre6OJ625jjQiCVBxLSH1y3bd8fmQ8184XxD67wRbj6s7
         WMSu+k8G/KgrkT/Tnac/oUUojOcmuE9QfUMcqBypts2I61N6ZAG2zTJqzJ6ozJ+GMivV
         ryig==
X-Forwarded-Encrypted: i=1; AHgh+RpBEtUPD/s1wu6aYZ+483kLBfTY64VlwVcWtbGIdAkkwouc5blm00rq+hhbuzeD028LX3MAWKhkYMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqX3U6X42Bctl1c1bRVEmtIp13xaZJ9dKS/iLtBy0ldTAZWNDa
	muGbsAsumsXhLClyNMlxG3QaBf1JOqdpPcZAFFG/hzqjjwlq0dPDit/RbCedIA4/c3QBT6BULrB
	6X25iH5EihV7BNnblep+FPRa1bvmPp4VAMD/xlwKESZqmKxiz7qy5bS1Efy0gahI=
X-Gm-Gg: AfdE7cm0gBMDRcYdBF2gZZCvs+gpqthmVVR1a7dWgFPNxJxAVrwADnGdyO2mVcW4Z20
	2yDEuega/u/QS/eTkMGMBhTFbpVAl+W9TrK9QmQsAMzs4ffwtihm6CSHloEq1OzYpPfFJY6ALfS
	sFF0WnRwWXmKicyauVJ0wiRc1rHAPa8svFNXtk7kWAOE56J6LZXrTpgECJ9ItUPZc01OJ0bgw1l
	o4NZmi/ngytxmSd7mV8vbhfuZik4NQ9VAIoGKypK4TP7hREB8e0RHLiFPQL2UI8gZ3EqhE520UW
	ZvJyoyg9s6KaV7GwvzkCh1FJh+r8Vo05w/EN3RPG5Dsv1SWVCMW3gPF4TUiLwm6jpEbWLvNKFQx
	VGx85qT6mc0yw9AoX
X-Received: by 2002:a17:903:26c6:b0:2cc:864b:539 with SMTP id d9443c01a7336-2cf34819447mr89425125ad.6.1784411323162;
        Sat, 18 Jul 2026 14:48:43 -0700 (PDT)
X-Received: by 2002:a17:903:26c6:b0:2cc:864b:539 with SMTP id d9443c01a7336-2cf34819447mr89424925ad.6.1784411322720;
        Sat, 18 Jul 2026 14:48:42 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476e491sm31821105ad.76.2026.07.18.14.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:48:42 -0700 (PDT)
Date: Sat, 18 Jul 2026 22:48:37 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
        u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: ti-ads1015: use local device pointer in
 probe
Message-ID: <20260718224825.2dccc125@jic23-huawei>
In-Reply-To: <20260718075016.27750-3-architanant5@gmail.com>
References: <20260718075016.27750-1-architanant5@gmail.com>
	<20260718075016.27750-3-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OGEuTPCsdN-lAj_hNfGnvBlnG9RpphMr
X-Proofpoint-ORIG-GUID: OGEuTPCsdN-lAj_hNfGnvBlnG9RpphMr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIyOCBTYWx0ZWRfX7+hK0DvIDqyg
 yZT8mBDFBdvZUi4HRT5t8srORN7rkFNas9sM2BQLnETH89FdarxZwVoDOlqpq50oXGLRZ3b6Rba
 gNZ/CLg94FeomQdO/uUn/2gBecVQwV/u+sdx36zNUcy/RA8CYJJo8F4A/4S7BQr0dDvmxTp5RlY
 cojVd7YHeh3V1rZNJ6NOxGZ89LYmjCsMge3suL4lRMc98oGuFDEM/i9kPYCkXDC+SBrmtfAx1Pa
 MiREDEj5Av0O9Z9Sv5A6jGGRVhjiqDwCALEi8d9B5tTG8CVD/AfsGG/mPVhCrz46LuD2bz6pxu1
 xGKJPNBoFxbNZm6L9kusPVjXbBvrQwbK6bEw1o+JfNQsrHnoeQ5UARRflS/dfrMGqTmvYZ7OaGJ
 A44Ao/g0EgHX6PFP6JDQBGhwZQYNC0bkBdzPbqB96OStB9vkBmDHATWaezGdAp5V89ehFii/ESb
 MP0i2jvbAaSBUFvYqGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIyOCBTYWx0ZWRfX3pI45Vn663tE
 7oZGDia7AMJCCuh0YcOlYkawqtmH8fvckGBgW4hCmdLqQLOVDXcL0XgWCG9RteO7+7SjcjZjzIG
 i5PX8uVfpi2y+bW69WpaLxbcD63ohRo=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5bf4bc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=IFsNunPI7pI3NwfwLsYA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180228

On Sat, 18 Jul 2026 13:20:15 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Introduce a local device pointer 'dev' in ads1015_probe to
> avoid accessing &client->dev repeatedly.
> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index d95efb870bde..0232a4ca2d77 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -937,12 +937,13 @@ static int ads1015_probe(struct i2c_client *client)
>  	struct ads1015_data *data;
>  	int ret;
>  	int i;
> +	struct device *dev = &client->dev;
>  
>  	chip = i2c_get_match_data(client);
>  	if (!chip)
> -		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
> +		return dev_err_probe(dev, -EINVAL, "Unknown chip\n");
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -978,15 +979,15 @@ static int ads1015_probe(struct i2c_client *client)
>  					    &ads1015_regmap_config :
>  					    &tla2024_regmap_config);
>  	if (IS_ERR(data->regmap)) {
> -		dev_err(&client->dev, "Failed to allocate register map\n");
> +		dev_err(dev, "Failed to allocate register map\n");
Whilst touching this anyway please switch the cases like this one
1. In probe() or things only called from probe()
2. Return directly after dev_err() 
over to return dev_err_probe()


>  		return PTR_ERR(data->regmap);
>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      ads1015_trigger_handler,
>  					      &ads1015_buffer_setup_ops);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		dev_err(dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
>  
> @@ -1018,7 +1019,7 @@ static int ads1015_probe(struct i2c_client *client)
>  		if (ret)
>  			return ret;
>  
> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +		ret = devm_request_threaded_irq(dev, client->irq,
>  						NULL, ads1015_event_handler,
>  						irq_trig | IRQF_ONESHOT,
>  						client->name, indio_dev);
> @@ -1032,16 +1033,16 @@ static int ads1015_probe(struct i2c_client *client)
>  
>  	data->conv_invalid = true;
>  
> -	ret = pm_runtime_set_active(&client->dev);
> +	ret = pm_runtime_set_active(dev);
>  	if (ret)
>  		return ret;
> -	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
> -	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to register IIO device\n");
> +		dev_err(dev, "Failed to register IIO device\n");
>  		return ret;
>  	}
>  

