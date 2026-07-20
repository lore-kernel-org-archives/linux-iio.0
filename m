Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DB1A23A4
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512881; cv=none; b=WeXb4jkum+7ttHVO/zJ3RtEjY8iMuXYAJMf+idACxerWLCdvGQnEMRAG8awsG1zwEdp/ZRdpjgpP6vDgkByoMAoGndPpyLv3CWw2MvZs+opPvFaygrOxGlLOILVjw8fjNbl8TODLM5YoJi/8wn7adR0nmmWAAmmh7SmbRbLlDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512881; c=relaxed/simple;
	bh=0bJudptEjGiVZiloqbKxE2BTVPF4214phaTiD1mXcgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbUEVISMaiAfPhddr0ZRNpmFVz//b95uSsBLcftWr3e5JCKo4AYu/DJQkjCL1uVaLJTKHSvm49U1x581cPmacwqsOm4kktkTlKL5ZwRm9+h1mUOJlJyPydiLmNA7VK/gW653kHPtDjo9A7KIxuI+dk1lzBGCVHRNce6ed87IGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bAAFJsfX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X/SFeSRn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bAAFJsfX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X/SFeSRn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNu8Xf759441
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0R1kUgNRvrTfo4Qx9jM/ore1lwtaChM3CnXraP7eeU=; b=bAAFJsfXELX5Aduf
	RrzwmPvvyeSKR0VW4pWpMMuCcm9Iid9y4k2bzAli5fz9qOX5BfFg04XvuxBaAwXa
	9Od7vLNDa69aMDojNVNR3I7Q+NKHkYL5C9wKnrdopDJ6QH3upMqGcXIullUcJZag
	l2juWV4TSrFHD7JjDgj1G2vz+rfhoMvfx/Nc8yIze7OAAM5P358WbIaUbKIT0KHc
	uBWKo0X5UJKC8ud94NOz3yuFfGT9zzv46WOH8jSmfk+WiTjamdHb8yCHjkkBYwtY
	c2NN9Cu85+DEDlytWkJLC4jPIBmIUQm3nbM32hDYAwTFyc+InuT5Zj3tz+jFRq3v
	dB19vA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnkx41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:01:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso5517339a91.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784512877; x=1785117677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g0R1kUgNRvrTfo4Qx9jM/ore1lwtaChM3CnXraP7eeU=;
        b=X/SFeSRngTmBrhsWiDv5775NgETujlioOHhOY4l+Y/MXTFuwO7pwtA45IhZUbWHmsW
         RXlhWpyntc7gkKfLoOWqoVAvVDfYf3UxGDT85hn6tokL6pkJ8yrX/pJ42MM3q9Eg7uHW
         La29+IE+iRkXpcwCwX2uuluqoxFRPjS2W/vp3cJXEk13qhPUv1rHMUkmR6eAOIQ8dXR+
         LlkC2SPSWvet+lzM3nvVqrfqp/Nxw5SfWbTS2TjCqDPQIUXwFOanAtVDC1mc4pW8rhWM
         cRbaj5+4UyH15khjuAB5eM0+OA188EtkjZtka2DjFMLIfkQyLGahoWBIIYbzuMeifegH
         hT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784512877; x=1785117677;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0R1kUgNRvrTfo4Qx9jM/ore1lwtaChM3CnXraP7eeU=;
        b=sz2HPkmxY3l2YdwYxHlcxjkZ21xLAGM1unKm+6u2LLMunQJBnkg074iGcrtKqxAoHp
         /+NmjdKqNEX7LQXTBPYdWLNJafLGE8CvnBL6DN7yimzIq1Qj+mf5l3zQaqg1sn3Rz+2w
         HuLuXI7fY/g9nJzjCdyMCJeGBekh/x4XbDeHa1HyZFXYSoU8Y3MiKcgFhW//51mt+DZM
         Wm6dtLMoSW2YcuU/lzzcEEIBU2w/OiRiupYP73uGnteyL+2miW2iOXytl8FOnoOr1ck0
         Sox92DennNrgIDbjYeKCcbJuy/IPPGaFvZyUxOkKbO358WkQJBil6ddOvO1YgVtT+zeT
         eLwA==
X-Forwarded-Encrypted: i=1; AHgh+RpV9T9M7q7PbbkihgeGQX8OvOGR+9o7GCOA0BCXev0WGzOGiAS/jTGFP3sEc27tHxNRe35fpNP4l7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcX9Nsf1wAfUuCgx5YKq2AdOhZCIhfRihABlrf0M71p4SrunZN
	v4gcw83Rm80kTUuV8Rm+JC7fPIIwCIKR/G54QmmPtPugrwqCr/1n7YiNZS/z/YPYnzoHkWBzun3
	WcVxPQXJpM8gosqjYEdwHbh81unIWXDlIAJfxnar9P2r7dtV58UbS+sfhYCVaCkOrBls1TkM=
X-Gm-Gg: AfdE7clUo0A9bFgrFP27ml2cdgeriHkCTOTXAE43Oc3tj3MbBYOKd0Al0/zrxrzq8se
	tx6k1D14DKPRbCVJEaOYBSw0V9+kL7CoUgnbB1IiopV47nwX1YGAH3LW/l1qmZ6BskIGrzwPXAE
	ird2mMGDoyC63A/FG79Qzu2UucepuL0Bt+kDnX0oQ9DEhFcAtR1DjIftLD5mzBvgFb6AnWdu9xQ
	q68/4cxXwrLSxsQvAoz/5x2xXnk2+snnbQbKJfgL0CyrJhH1d8eBDhtJwY7+Et6KPs0CdH8FTPS
	/ZUAVVTx9ezvOW92EqVOMq/QdDzS7DTxO0bDB5MWCLDqnPFRy/M0WnazBD/6W9Qu37WIT63PWZd
	eJHUO3/+mTp+u3inA
X-Received: by 2002:a17:90b:5350:b0:38e:7a05:9c0a with SMTP id 98e67ed59e1d1-38e7a05a1ccmr3130739a91.18.1784512877307;
        Sun, 19 Jul 2026 19:01:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5350:b0:38e:7a05:9c0a with SMTP id 98e67ed59e1d1-38e7a05a1ccmr3130714a91.18.1784512876811;
        Sun, 19 Jul 2026 19:01:16 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4ae14a32sm4930972a91.0.2026.07.19.19.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:01:16 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:01:12 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Andy Shevchenko
 <andriy.shevchenko@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH v4] iio: gyro: mpu3050: fix runtime PM leak when
 enabling trigger fails
Message-ID: <20260720030100.10aefe50@jic23-huawei>
In-Reply-To: <20260717181047.72309-2-birenpandya@gmail.com>
References: <20260614071549.81920-3-birenpandya@gmail.com>
	<20260717181047.72309-2-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SGTEX92DS02vV0sMK9abDvHcgHdgQyGC
X-Proofpoint-ORIG-GUID: SGTEX92DS02vV0sMK9abDvHcgHdgQyGC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAxOSBTYWx0ZWRfX6BoQPYiqnKeO
 Hcqd0tI/lGvj1ufU9F7ixeGhEvKYgF6VwMystDItsOmEKca7j9TLvia15jrlt6pvVzPCXKJEcbY
 Q6ce2TN/zWnUeHkvSqjxa2aMy6FwxABFFyEdVtlbRUNWAPKenE+WBLhr2zlrFiKbnkuvkdZ7Es9
 pX6VI55jGtVcwimBPvESjKnoc906pyKuzFd1fiiEXsCLQh9H4ccwfB4PFpla/iCY7U6DvR8B7LO
 lIC2WA7Siltj5x7KRn5qjPMuGpKn4661X3zcdr0YWohJuwbQLTqg8qmAAeG0eImhyUtR4DOg/WH
 VWitvPIc36NsiJFr4N3prRUY3eK//dGorJRXvv8KhqRfcsDitodVoipTDtJKvxn1DbI5Uk+cdVa
 TgM45LtfESVJ5XjUjDkaPqm3MwqUhDE9wz9cB2Lu6fsMZdnwQ5VAMFfkZD9XPjrRN0j8Gfi2Jdp
 /WH7sbcXiqzQUW7Knog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAxOSBTYWx0ZWRfXyE3JnWdvQ4Hx
 CQ1sBfJAKK7w3/J2jF7yLlPDjkCcFXkeQIgeupYj2T4JaX+FGz3Wj380oFot91ViDEgmWJXlRIq
 C7peqPOZc8RZl0zI1AdTh4pe9tj07vA=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5d816e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=XRh40w5Bb-F-MT68L2QA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200019

On Fri, 17 Jul 2026 23:40:48 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when the
> trigger is enabled, but several error paths in the enable branch return
> directly without dropping the usage counter again. pm_runtime_get_sync()
> increments the usage counter, so every failed enable leaks a runtime PM
> reference and the device can no longer autosuspend. The driver state flag
> hw_irq_trigger is also left set after a failed enable.
> 
> Jump to a common error label that drops the reference and clears
> hw_irq_trigger, mirroring the disable path. The success path deliberately
> keeps the reference, as the device must stay resumed while the trigger is
> active.
> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Never send a new version in reply to an old one.  It both leads to confusing
threads and also generally increases the time before a reviewer or maintainer
will look at it. 

We mostly work backwards through our inboxes because old stuff is often
resolved in later threads!

> ---
> Changes in v4:
> - Reverted stray change converting `mpu3050_read_mem()` kernel-doc to a regular comment.
> - Dropped AI assistance tag from the commit message.
> Changes in v3:
> - Changed to a unified error label instead of individual drops.
> Changes in v2:
> - Fixed a missed PM release in the first error branch.
> 
>  drivers/iio/gyro/mpu3050-core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b4314..783be9a786df0 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -994,14 +994,14 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,

If touching this code, can we also check for errors from the pm_runtime_get_sync().

A number of paths were cleaned up in
acc3949aab3e ("iio: gyro: mpu3050-core: fix pm_runtime error handling")
but oddly not this one.  Antoniu any idea why you didn't address this one?


>  		/* Disable all things in the FIFO */
>  		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		/* Reset and enable the FIFO */
>  		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>  				      MPU3050_USR_CTRL_FIFO_EN |
>  				      MPU3050_USR_CTRL_FIFO_RST);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		mpu3050->pending_fifo_footer = false;
>  
> @@ -1013,12 +1013,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  				   MPU3050_FIFO_EN_GYRO_ZOUT |
>  				   MPU3050_FIFO_EN_FOOTER);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		/* Configure the sample engine */
>  		ret = mpu3050_start_sampling(mpu3050);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  
>  		/* Clear IRQ flag */
>  		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> @@ -1037,10 +1037,16 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  
>  		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
>  		if (ret)
> -			return ret;
> +			goto err_power_down;
>  	}
>  
>  	return 0;
> +
> +err_power_down:
> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = false;
> +
> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {

