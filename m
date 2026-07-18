Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249E2931C6
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411740; cv=none; b=r49Ii9hr6pSA03Vj2ywPdFgD0luR4WaqHOl/K5ZsZfA6sGePc7sTrjxRLrshdye3pnR+b4JuyXInCu9FKShOEM66FmeP530HpIlCgKgmV46ifw+6F9w4KBNZQwnIdrlISiNpoaueQCCeSbFNlTdv1sn/IJFEzjbTZFRVOP5+QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411740; c=relaxed/simple;
	bh=7d4SD29H4eCm2+c+O28KnjY1ObN+/d9GJbsZkR3a8YE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvWbjgMq49/niRK51+7Fr9U4KrYxySGv/Ohn+deiZB1bryeqc+teWpeIbzG0NQXI4h9WaqmX1WYjF60LT/oo6oXOLqnMR/WRvZBb9M6gTf1Iir1igPPFuUzrR/Tl1sx2sYQKJWAShD9y6jzMONfvgp5RN4i+Mh22YJVw0GO/a1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HKKXIDJ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c09ZDnW7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HKKXIDJ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c09ZDnW7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJqIhN1519841
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ASHWcBJN/1ikBOiz3cdVY+T9vPEaHVJ/+JaXYaW0mgU=; b=HKKXIDJ/bkTaw1yM
	KASYOGh0YRG2eg7qJMzLT8zUIkNBObT2MHEgq/djypfnro/KSGCg08FYXEZxDyUP
	kqewM/S4/vXw+6fCzQgwpKx3JzgiRFqPDRQD9lwdST0RiRVFNKYKO1lF0asOCOOT
	XrfpQr88JEv0t+tl7Cd2ROuNV+I7uiQxgpYjMrUNkdC5ENAb8CL4RXclC7tDB2NU
	VQ3EyCqK8B2IK5uhM7xn84IErKkv2JhL1lnaHdEdHEKQYtTvHMlmtyxph5eBithf
	oGu4lzu0WUWWAjrgvo5ly0NrTFc0YgHdCVaibE0Wx0uMOj6fCHPGTKPxBouB9919
	81Y84A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnhkk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:55:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84857446424so17087313b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784411736; x=1785016536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASHWcBJN/1ikBOiz3cdVY+T9vPEaHVJ/+JaXYaW0mgU=;
        b=c09ZDnW7baTaj7L7BuAb2/vm58+t7hHSuNumOh9m+Hydwq3miPWVlZSdkM/nirzALX
         XrNVQl3TN3jQ441cjThpYnb7UoxyKla/xHJTDBQQfMSB3eHJncomYTSgLCZlwjoBwBrT
         j9QKhLtA2FyjtrwvuwMGqAZcg7Tesm5xXZ0AKw9n4S0ckHJ64rnVisbSBNlLp6kyBK3w
         zGx+6IxBWiD9/UB2H/jAapg4I57zyiC+XxrJ5YpWmE8hEz59ME96PGkQB9bBSZyxss5A
         wgkMKWc3yQvQccg9pZszcP4M4zuKGzWXrWe4UJUdkM+NpkezmxZV6hfdc+hVpYLTLSuG
         /7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411736; x=1785016536;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASHWcBJN/1ikBOiz3cdVY+T9vPEaHVJ/+JaXYaW0mgU=;
        b=Nh6rFQjw69cAwv2U58GHJEqniu9EkhTIcm7zv8MXkZGemLa2k6GFPUTVGAYNPXHx0j
         wwdbZp6OcQqZg64sNHdB3VOQCM9TtchEM3wg6rQTjXqWSj3V+/RGcOTWO7uNSWU8JQZr
         tImszcP8yDEp01s6ce7F+D8WG6nDMTM0jDoeUl2vqd4zjgM8mGDF6/FJXUTElqZw20yn
         aOa3N/IT5FzRqr2XjSZygokFPlbkbeAh1GOCRiDqR3uQ09G25bIFXX0dFwMKk4SnbCzv
         zo1tjcvkXcbTXQUvWAWv8JAHyaa2mKjsZ4xRPasxbTFBD3IzAnZszlC6xH3Jtc4ud2IK
         3tGw==
X-Forwarded-Encrypted: i=1; AHgh+RpO5eB4A+3dnp8ktW+WQP4nXsDc0zTwO/fwwbyKkngCUO3xgn1pd8KuZrX5xJffTUMjlamduX4yoVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJgJUX8L+UP9cXfKpVHCKZlB06xdtTH7EWm0HuPVyzRXePLty
	26oVhajrqCKnUWuHWJuxgAg02hM+GdZm1mHzU55DFStLmM7ojIEbanw/3yR8RSUYIae041HNGEc
	D+NI5+dth9rOiH8F8MR5Muj+fkXCpHBEZAPXQnsgbgoA274RosKHRQ/2SdglTqWI=
X-Gm-Gg: AfdE7cnHDF52UyWMHSDwDQZUuzb3alpyQrOfcifpKL5+mB+5DpEHMANMdGJgicKz/nL
	/hU3gtumDdyjvofv50LzNTqFFh4Rnn6OrALFS0QHfoLlnIoVJn7Uk12NN929vxhEoeqKhcfdf8K
	wtMcX0TKl4+OEDOBr1GaRp7bPtoxCGTOfr9L8gZZZ1xprqwkxwM7bZB4+CUjVDgZaxVvVcMVtal
	RXgcS6PyNn3WmcJNn/MlY/BI4gigLQZSP2PgRcaQHD+drIYyZJN9sYPOKurW/W3zSaimyrpDg6x
	dX2nAzsZraKQ5XE5polSTXmH7sjAYQy0/8BM3bzihdVrFQlthvNd4s3uJgReHm3o7gWCp8bnus/
	EIgwdplmyePrrZRly
X-Received: by 2002:a05:6a00:aa0b:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84c292ac538mr8112258b3a.25.1784411736006;
        Sat, 18 Jul 2026 14:55:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa0b:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84c292ac538mr8112235b3a.25.1784411735542;
        Sat, 18 Jul 2026 14:55:35 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2f1601d6sm3060523b3a.50.2026.07.18.14.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:55:34 -0700 (PDT)
Date: Sat, 18 Jul 2026 22:55:30 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
        u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ti-ads1015: convert to fully managed
 resources
Message-ID: <20260718225515.7e49a458@jic23-huawei>
In-Reply-To: <20260718075016.27750-4-architanant5@gmail.com>
References: <20260718075016.27750-1-architanant5@gmail.com>
	<20260718075016.27750-4-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LaNQwrFrDZR1lYPLhwvPI4IFCtLxtCPG
X-Proofpoint-ORIG-GUID: LaNQwrFrDZR1lYPLhwvPI4IFCtLxtCPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzMCBTYWx0ZWRfXy1eiWqsT5rBZ
 gmLHXxLE6aD1hOFDtfFrtM4Vmw0a4MDvC9f5zf5fEURzUgiiSt5wxBFIQSgtAEOpvLt6TDJvPrd
 S4HiAvA9z6F0Hc4t5PwQjgOE/HVctypYKLJHloXiuBg2paPxs9YJeITI2HJJzSxIIzBU2gcGH2O
 JeuYl5iKtRtANw8ddfo9gR+DQn1pSS++yeXHdYt0t3TB+qjOaUDBpDXj6AMukaFcas0QX1YFgYO
 5j2BNSnly7X1efNW8hfDnQppdr0v6nE6y+L16TqAwVnw+FfTHSZFtS0EqwMe+ro85ZxAYOCR+A/
 x66sOE3iE44oG3QVe9DSdr/N26WxY39Rr5zWS0paCvNSZUgT94g536/sF9v/0K8e86y0m8uxK9f
 NhkR0SBwjMs8vNpsHiLy170/r56xyc3GUueq/G+6jeKLjKAhlkpWoN2Y32BG2wwhkQQO1ks2qMF
 /OM1scF9fAS3cPq0LaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzMCBTYWx0ZWRfXw4zQfOEOgEqJ
 2nXyFh1TJ5PLlotK/9mQs+iChQxaCrgRWYwXIbJf4LTMMZ4B52Z69jTlSrkJWdLJ24CmspC+sSm
 E3Yhm2PJbOT0gI5kkcO2rEn9FFNTCR4=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5bf659 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=0kWMRCPL9c4H5K_DkQwA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180230

On Sat, 18 Jul 2026 13:20:16 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Refactor the driver to use devm_ allocations and power
> management, allowing for the complete removal of the
> ads1015_remove()
> 
> Key changes:
> - Use devm_add_action_or_reset() to ensure the ADC is safely powered
> down upon driver removal.
> - Move to devm_pm_runtime_set_active_enabled() to manage the runtime
> PM lifecycle.
> - Update the PM operations to use DEFINE_RUNTIME_DEV_PM_OPS and
> pm_ptr() for modern compiler saftey.
> - Convert iio_device_register() and mutex_init() to their devm_
> variants.
> - Remove the thus obsolete ads1015_remove() function.

See below. I'm fairly sure this is also fixing a bug.  Ideally you'd
fix that first at the start of the series then refactor it later.

Jonathan

> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 58 ++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 0232a4ca2d77..57e5fa593b31 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -930,6 +930,14 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
>  				  mode << ADS1015_CFG_MOD_SHIFT);
>  }
>  
> +static void ads1015_power_off(void *data)
> +{
> +	struct ads1015_data *st = data;
> +
> +	/* power down single shot mode */
> +	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
> +}
> +
>  static int ads1015_probe(struct i2c_client *client)
>  {
>  	const struct ads1015_chip_data *chip;
> @@ -950,7 +958,9 @@ static int ads1015_probe(struct i2c_client *client)
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  
> -	mutex_init(&data->lock);
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
>  
>  	indio_dev->name = ADS1015_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1033,38 +1043,23 @@ static int ads1015_probe(struct i2c_client *client)
>  
>  	data->conv_invalid = true;
>  
> -	ret = pm_runtime_set_active(dev);
> +	ret = devm_add_action_or_reset(dev, ads1015_power_off, data);
>  	if (ret)
>  		return ret;
> -	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
> -	pm_runtime_use_autosuspend(dev);
> -	pm_runtime_enable(dev);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to register IIO device\n");
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
>  		return ret;

Worth noting this was a bug as noting turned off the runtime
pm if we got an error in iio_device_register().  That is fixed
by this patch I think.

> -	}
>  
> -	return 0;
> -}
> -
> -static void ads1015_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ads1015_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	iio_device_unregister(indio_dev);
> -
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> +	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
>  
> -	/* power down single shot mode */
> -	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
> -		dev_warn(&client->dev, "Failed to power down (%pe)\n",
> -			 ERR_PTR(ret));
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register IIO device\n");
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM
> @@ -1090,10 +1085,10 @@ static int ads1015_runtime_resume(struct device *dev)
>  }
>  #endif
>  
> -static const struct dev_pm_ops ads1015_pm_ops = {
> -	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
> -			   ads1015_runtime_resume, NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,

Sashiko points this out.  Switching to this and leaving the CONFIG_PM
ifdef above is a bug.
https://sashiko.dev/#/patchset/20260718075016.27750-1-architanant5%40gmail.com

I didn't chase through whether you can also safely remove the other
one further up in the code.

> +				  ads1015_runtime_suspend,
> +				  ads1015_runtime_resume,
> +				  NULL);
>  
>  static const struct ads1015_chip_data ads1015_data = {
>  	.channels	= ads1015_channels,
> @@ -1148,10 +1143,9 @@ static struct i2c_driver ads1015_driver = {
>  	.driver = {
>  		.name = ADS1015_DRV_NAME,
>  		.of_match_table = ads1015_of_match,
> -		.pm = &ads1015_pm_ops,
> +		.pm = pm_ptr(&ads1015_pm_ops),
>  	},
>  	.probe		= ads1015_probe,
> -	.remove		= ads1015_remove,
>  	.id_table	= ads1015_id,
>  };
>  

