Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F02264A7
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514870; cv=none; b=UAyrkWADKY3n6qLWoRRHY2Yqujr4W7F9Gc3FMFMT7XmUuqTH/yslgWgFaSmDOOXnxLHW/o+Lv1igT3VdcqIBRTnBqBwnSFuSgjm62rAMlYwbOLGZdvM2oZ/RKJtWSkjCsZio0X6IQ+bnnDVku+T326H96Uc4BZ4o3eGax8vMNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514870; c=relaxed/simple;
	bh=WQfU2Ba3Usx+tf7QLKml5N3nlYFUUH3ij6A1HtvuHFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIYBlbSbNdcmzE+9cMfB/S54bj2EcaqKVo5qC7YUbyR21rLq5L/MiixywIcHpW36cgCwUZhdd/6jKvLjxo9uDhEtJvW+xehy0ppH2RMfylqJ2F4O1N5JCwORxQ9m7mX70HXQ69clgQ3qAJKm0OrfhXVSfVEwu7BgKFpCHsFWFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjwNuzlX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JzZ4kNUN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CjwNuzlX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JzZ4kNUN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNu8bf759441
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x9+V0ni39rsbDbUb5FIXHW8BlkkNRr2cVHu7z9Hbm4M=; b=CjwNuzlX9z0nqljX
	3qs7if8I6KQA/O8QlwQPNecass1vlsR6ayzbxCogCL4/ooLt9nO9w7m0Izjz9yRR
	sfKuVkTMduqYmZwqYRKI25QMEjar03p2TPYu5q6l2pedBJXBGo6LowvS5Q/Z9DZz
	zEvTYqU6wZjeM/GtIMFP7JgvgyhrBDp5czpi+0QK2LAKEgTKJdM/nfaF2XzHtoBn
	wSvLoAFa51S3l3lzt6XSuCUoCTKl+hXNz4kEpI1WNqDjxV5kEtDDVcJ/ITt6a360
	fMIxaApId3LXGH/NWDNhly0OUOvimKrp7/TBlnFwhgzBI6BN+JU/dFO+/BoZZmHb
	qL8hTA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnm0pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:34:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccafc5e82cso86328155ad.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784514866; x=1785119666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x9+V0ni39rsbDbUb5FIXHW8BlkkNRr2cVHu7z9Hbm4M=;
        b=JzZ4kNUNCtA5B9v8+D9CKL2mR3HIsRfOhrfVxWNmLH3oB689Mht8iZ/SWvXYsyI4fW
         GpoCfHEmgie6v+PVrrVX2MDcwAnZxgLsafH6OMXNPs6pSyycYpGPsQaNaFsvNr+5f/O2
         TVhbhJL2GfeTcikzP0yMyf21BAry79tBpGLGVN0Zqt9XTyIV/YFo18DMQL2vwGazDj0w
         BmTgLwiz4n3AuXjkfp07GQTqgOzp2OLOBIAbX2iXpeTl04G8YuWcNlj+p1qRS2QRAG5F
         ZcDh8T6csq8HoahAscFHHZUUtNddqsurT6sMZ41MlHivxz55WHyE14U2kItlReq1l+Jf
         zVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514866; x=1785119666;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9+V0ni39rsbDbUb5FIXHW8BlkkNRr2cVHu7z9Hbm4M=;
        b=YWI3BFrppQL6RycFFDRu6urltA2UsWhR0Q5KALMFEXHjM2HnICKS5+3sQzs0t7nPoq
         sX+7kf2VE6ypjEU3LAZxZYTQjXMAQ10hFtOkyugIn0529PtlB6ODl7WSuI9zsQEN8P5a
         Z31cp191MjLce9CiTFwrvMsVssIdo1/dCzY0X9YckJu7QQnbYV/bVGBUamvO89D3249b
         rprfzH396kXiKMjuKq+VYP9sVMbLwXyh9kOEN6dMoMCjJTY2akWH1XH+s5J6pypwxbqE
         /08CbzhgrufAQlMV4aTXSsYQLL3vfISCnMS89u9iGNG0Efa3XBerYA/iMQiUZHUrKkWQ
         taHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGLwj8rvU+gSf0g2id9ULidscNmHVj4Ki8bZLIg8jbxC0jT8zZ5jCXE5LCDRQn9yIJjUfNFO8fdpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8twCFNy0HE8oQ1xLam/l46PkrEj7i+C8EF/qEX7pW9vTTEol
	fT9NvKGuqLYjxxPhmzlzP3y7KSQNvghTI0jR25+ZIXmC0/bmBYsYhe0e9miy0TvpX+YrSSVYOCC
	UelC/wSgIJr8/KLCgBsJJZ1Nj5gaLrSPqBYNnv95htueqj2NSPltGlJ8zQvIq8H8=
X-Gm-Gg: AfdE7cmbUZ+O8Rw93Gkj/+FE9hfe1OoRbOuXn/Cbn/Q3/OhLCypp+cLhFYDFkVFN7eZ
	bsIu+MMv+2L2y/lEVymY0vtsjR1LQ+x1gRdur2s48veUFnNwhzcP4hmJer5P0gIT6JhZnb9Gp3l
	pzIpszrT0cVqIu6hYmtsOFU9io+zwe2QcuwebI5vid4dVihpzubfB0+JbdY26oYsXCopWDbKmmP
	CNX/ImBQjtFl/zntvDaIkNiSt9tgjnI05RR6GmEJft5rd4Uqf7kRk1jX8x13AyRh6Piq2Ie8LOl
	/x5zYSOAFeFx1lhoD9/RIe13fRLsSYW4Cg2YtDZuhpWCQRCWqAmAv2dsCQv++/W18EFMIq4Pw5l
	uP6o3YYT+NP4qYz/p
X-Received: by 2002:a17:902:f686:b0:2ca:281:27fd with SMTP id d9443c01a7336-2cf3499772bmr131842965ad.25.1784514866313;
        Sun, 19 Jul 2026 19:34:26 -0700 (PDT)
X-Received: by 2002:a17:902:f686:b0:2ca:281:27fd with SMTP id d9443c01a7336-2cf3499772bmr131842665ad.25.1784514865762;
        Sun, 19 Jul 2026 19:34:25 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf345111d5sm47988745ad.37.2026.07.19.19.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:34:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:34:21 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Balance runtime PM on trigger
 enable errors
Message-ID: <20260720033421.18796783@jic23-huawei>
In-Reply-To: <20260714093908.380804-1-lilinmao@kylinos.cn>
References: <20260714093908.380804-1-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n_5OUVgtVG2cKcftMMBrDII4UkWa-nNB
X-Proofpoint-ORIG-GUID: n_5OUVgtVG2cKcftMMBrDII4UkWa-nNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyNSBTYWx0ZWRfXz+cCqgPpBmAJ
 SVyvQM3d/GN/kdLg+mzZYKHFCqXSMNmYxwGHyGkNVdk52ZK4VuBRcpupSC5uR+ZYsFMnLmMgMBa
 YDBbN6lUBxL5S2mN0h5X1nndXOyFWk3KNeYlzIpP8jxRQINU2y+K6wYP4vx8hBPFFWnb33yBhFe
 DAi6IsGh/lZ084CH59c7UvYo9QoJ4+A6bUcB3IHwjWsGJOaQDMeNjyeQyqvcAwwch7MXadu5bL8
 GCV4EjnldCW/LWIFwkeZ6NyuaUNxkSzK1dG7qo20xK6oWvcNNBEDyOT5h8DS1bEJz/RL43E/Gvc
 p0YDTthjFpOFnipPyYpE/1zbMMuI/y6FDP40fta1KU6+amL8R0A++Ck1lFGTdZ8eOBLTMipQNRi
 yqrP2emauz9MLFL0jsl90vB5AbkvH1WEYYlMZ0UCDvv+4A1n7zbEOE9YTjxNJO+Sw/MrHB/QEXO
 datit05WtB/XXmfsRJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyNSBTYWx0ZWRfX9oOzlsWlG13s
 qxQyUS+jpEtCwkMnmab35+vgWy6/hhcTw8kJxPd8y8Co9wg61BIkpIe+8/zYAvnNyx7+Dmfa+bN
 TdnjP3I+pBCrOIYVxvH9a8HU8WGY9yw=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5d8933 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=qza3z6wo7qKxcvPQmsoA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200025

On Tue, 14 Jul 2026 17:39:08 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> mpu3050_drdy_trigger_set_state() takes a runtime PM reference before
> configuring the FIFO and data-ready interrupt. Five configuration failure
> paths return without dropping that reference. The IIO trigger core does not
> call the disable callback after a failed enable, so each failure increments
> the device usage counter permanently.
> 
> Use pm_runtime_resume_and_get() to handle resume failures without changing
> the usage counter, and drop the reference on subsequent configuration
> errors. Only mark the hardware trigger active immediately before enabling
> its interrupt, and clear the flag if that operation fails.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Hi.

Thanks for the patch.


There is another patch on list for this issue.
https://lore.kernel.org/all/20260714131426.4257-2-birenpandya@gmail.com/

(and another approach before that)

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..6bee1caadd81 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -988,20 +988,21 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  		return 0;
>  	} else {
>  		/* Else we're enabling the trigger from this point */
> -		pm_runtime_get_sync(mpu3050->dev);
> -		mpu3050->hw_irq_trigger = true;
> +		ret = pm_runtime_resume_and_get(mpu3050->dev);
> +		if (ret)
> +			return ret;
>  
>  		/* Disable all things in the FIFO */
>  		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Reset and enable the FIFO */
>  		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>  				      MPU3050_USR_CTRL_FIFO_EN |
>  				      MPU3050_USR_CTRL_FIFO_RST);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		mpu3050->pending_fifo_footer = false;
>  
> @@ -1013,12 +1014,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  				   MPU3050_FIFO_EN_GYRO_ZOUT |
>  				   MPU3050_FIFO_EN_FOOTER);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Configure the sample engine */
>  		ret = mpu3050_start_sampling(mpu3050);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Clear IRQ flag */
>  		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> @@ -1035,12 +1036,20 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  		if (mpu3050->irq_opendrain)
>  			val |= MPU3050_INT_OPEN;
>  
> +		mpu3050->hw_irq_trigger = true;
>  		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
>  		if (ret)
> -			return ret;
> +			goto err_clear_trigger;
>  	}
>  
>  	return 0;
> +
> +err_clear_trigger:
> +	mpu3050->hw_irq_trigger = false;
> +err_pm_put:
> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +
> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {

