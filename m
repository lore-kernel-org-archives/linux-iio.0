Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590128CF5D
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513937; cv=none; b=SteLHxatGNlVBW3bxQZy6r/z6MBsaQM5A+ONHDFhp48axejW1UsjZi6GjDS0dRmT5CFK6hofQ/N0dB463UXbg2UBeCiboAEI90L2EL5jiZaezPu/zfZ9gEf5vcIQtVZPe8rpWSJd6F8Hh/v2BqrMAPGXciTzcuu7phMsDKdDLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513937; c=relaxed/simple;
	bh=0Ln+6SuMKmPJUbnKVRV0Q/oZKaFz84WW6Q6C3aI1qv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9iDNdCi+W2WzpH/O+FMXy/4vvKDeuLfejAskYKcSIXlCWsYiG+ykUQuqaYZ6Z/Wy+ARM7DX+TKqv0W5F6fepJogzVAZhLW01CYgDNyLhHM0kepCkm05Gxl2dLbnW9UR01tZO0iPtHApwzHG8/+T9fw46pOf6fMUa9WGqSALHn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VH2+hdDd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SYeqMAyG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VH2+hdDd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SYeqMAyG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt8M81021613
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V0y3gR/gN1/IKFYY2Gu0CPV/sbYNkQR9mimcuPatGCY=; b=VH2+hdDdkSWtpUdV
	GReDkxqQy4GO+yN88efuUApnF0X8/C8YGCal0GQV4sEXOJN6QhoML87d2E/me/B8
	FYuV5BN14YvHXvsTGrwTKbg1Sjwz9RaBuDjpkDcS58erYtbmQhKx96e42QcWYi+Q
	lBeETrB0fYgTvQiH4i5UR94/MFvb5qpQe908lB+b3f3ynZA9Fu71purTSkP1qXzP
	q7rIRHGPZbDeissLPZfiTQaqVk+8I0OxSL1bu/Cf7UYdX9nx+oC7iWTHxaNlRHky
	Zfek+0DkY4z79pouOdJqLHLN0zObhjt5+p1kOKcmFn6K2+X8fcpVV3JCjypFgI0d
	SJfnwQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d93ymq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:18:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cd01a14e81so140647355ad.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784513934; x=1785118734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0y3gR/gN1/IKFYY2Gu0CPV/sbYNkQR9mimcuPatGCY=;
        b=SYeqMAyGlgetAJxMs6j5YkU6xK4MHf0ZatrKvWu+mxXPAW3OO06SyUJg/zhyGC+hLk
         qE4/m3bxEkSPh0qhwBCHbS/Z8I+Zkm6u8BEGeiiKHclA+GjG8VZ9AFa/xJCGjQeN3QZ2
         ORK8eNNwRtxOxJ8HBJ1LNdPNCJezlngOq4Iw4pUAATkyw1Zj/wGTySSpssb6VaN6GtOj
         dekDYR8urPOUi7TH1d6oN1DeZvVHAC98eEVDBmn0s25zbeyQd0C5I+2qPzSucMh+dnwf
         D4j5/X+iwhsFBVUWEPnPRRb42fPqNgn+eD8MlSTNhrYvwdI2UJLFXYbbW/OyA3Tz9pW5
         KzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784513934; x=1785118734;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0y3gR/gN1/IKFYY2Gu0CPV/sbYNkQR9mimcuPatGCY=;
        b=f1VS0Z5v0nVynf/E90+4uk0LP0x1dmRS4srxCxzgp92WIP8F+Rq5C6LK7O8V5HMdaK
         C0fOYtZVaMjsIFFAXb0QELDdIdk/JBckJnPduUaTcKwEDgFCFnQM/vB77pxMzjhlq4wz
         Aoq1Uaa5GnrGkHGxgGOQ3F0MnIazn7kRcKCU5Y4oblUl/dmV86y4UTqKKCJx5a6TLebv
         6ATy0qsxPwx3xlZDZfSr3cUjF1OUggI8iKNCFZm/L0Ub8xXW1TE3fhN2tBo/XSO95fyC
         hPw9InCO2GTaqcrrtktpDt5aY5lLWwxZiyrDsZqkY+zzRDNgnUCpfALn0PuY8jQEjwJz
         2UIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYug1ckFp0E+Ol5FnEQKb6X0sulrkqHhEfFsnrNow1h+XFBZcUZg/gti+xlCrdmVYhq2SHs0oo5Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjk0wRrivq/hVBP0vpRY+dnNiKdlwLsPGtJxIcLRJ+h8GK4us
	KfurXBQv0DAu2EZkQ0mh7eG2tI7G1apKgkzM2ugwMP7GcCIiL8ClWvTrjE5tF9yHQuVxngtq4Ci
	RIuSfJikX+eFDNGW4s3W1p+Xpxl6d4xNJ3euVpTGiOa/mxMGkSBANYoHejW+itBY=
X-Gm-Gg: AfdE7clfhk9CY4AaOYUjtYX+rXXlciS9//DToUbdPlfQJOs5MsTrl2Bg+wZSVFBvAhU
	A2U+/YTaf6KvUJ0IBVuGK71OklEbUvWA57qnSIAc8Yf0UIpiX8bxcoTuMOnMdS9UvwsPVt+ioed
	9lp1u93ZgVb9y7njjNTV37gbnYbTngCGcyNs+tt83i63MdaWGpWtaUjkZ8wf9lRFywZwvcYXyID
	k3dtuWknP+ySSynrdL6uohSniWCvEx7/pVpd0jelzcFpe+IbHgvWpt2xrbD1tA7BY7kpFthoXWo
	bKDPDYBFD2kjcS/NErE/LMzckOFVNZcf2fcKv/DmfT7eJlitqr2dHcD+TvEjWahAU3E+EGCj+10
	cOFShrOtfw3BsXTL+
X-Received: by 2002:a17:903:1ae6:b0:2c9:d539:61e7 with SMTP id d9443c01a7336-2cf348b262bmr128635405ad.19.1784513934398;
        Sun, 19 Jul 2026 19:18:54 -0700 (PDT)
X-Received: by 2002:a17:903:1ae6:b0:2c9:d539:61e7 with SMTP id d9443c01a7336-2cf348b262bmr128635125ad.19.1784513933937;
        Sun, 19 Jul 2026 19:18:53 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344df393sm47068455ad.30.2026.07.19.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:18:53 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:18:49 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: kxsd9: use dev_err_probe()
Message-ID: <20260720031849.246d9276@jic23-huawei>
In-Reply-To: <20260714122520.3201-8-birenpandya@gmail.com>
References: <20260714122520.3201-5-birenpandya@gmail.com>
	<20260714122520.3201-8-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5d858f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=m3GwSf0BYBAmpaXh9ukA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: c1w_ES2DSQYvdXv_2xw1nn0c1DHP_VvZ
X-Proofpoint-ORIG-GUID: c1w_ES2DSQYvdXv_2xw1nn0c1DHP_VvZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyMiBTYWx0ZWRfX9hTwe3Yjt0ot
 s+BOAlo/1HE12PDYjvJk8QgIUVADnCW1+AlrKaKPCi7BfiLU1+xcslyh3vl2KLjMa6fD/2+DxGe
 Mzs4nZYuLkW6rAPU9lyohYN0F5Kiphtn5EEbvRrRM5LsLyof7Ga/B0/LwLgSXV/3Ua3VLUbn3gj
 aV4Ztu8WXV/eq91W3uDP8NTu6lNXppYwJW+PUCp27AOyEuMzG7+cBXPJWJ0IHQbXk2Nlc2T2H+X
 GPjA8CC0x32ShxtpRELooM/+L2y7bhVTzAd5wBnZX/sn9RQ3OxiyDBxBkGxLoTUB9OaaOn4AO+P
 z8MuqnD/0VknCtIl88MQ0NWtF9DzdfqHlKg+W4BDYKn+3wPdSoLMMJSyfekVJxYxoyUS8SjlnAv
 OWmCe4VRXr4T+0y+tmhh8t4mUnIKyz0zMWlBcpMlgJinUT9gS8VZf12RVgUHMA3BYjUDsgXJeEw
 LMilQmrgRygAqthkA3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyMiBTYWx0ZWRfXxUFyoyY2VE+N
 fs5cp8JfWTtohPoLWPqShBmplworH5oUHbr1t48oaY7qYM2osLCas5sEj89s/8KsX/HUz94jut7
 WtqhMGLaa+TnS3s870nPkm1PsiIrgXE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200022

On Tue, 14 Jul 2026 17:55:23 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> Modernize the error paths in kxsd9_common_probe() by using

Not sure we need the modernise bit of this.

> dev_err_probe() instead of dev_err() when handling failures from
> regulators and buffer setup.
> 
> This simplifies the error handling and properly suppresses annoying
> and unnecessary log spam during -EPROBE_DEFER cases when regulators
> are not yet available during boot.
Not sure we need to state too much about it here, but it does
some more useful stuff than suppressing the log.
Take a look at debug stuff for deferred probing.

Anyhow, this one looks fine to me though the true benefit only
comes when these all become direct returns with a full move to devm
based cleanup.

Jonathan

> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> ---
>  drivers/iio/accel/kxsd9.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 680d43135e617..ffbefd4576dd2 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -433,10 +433,9 @@ int kxsd9_common_probe(struct device *dev,
>  	ret = devm_regulator_bulk_get(dev,
>  				      ARRAY_SIZE(st->regs),
>  				      st->regs);
> -	if (ret) {
> -		dev_err(dev, "Cannot get regulators\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot get regulators\n");
> +
>  	/* Default scaling */
>  	st->scale = KXSD9_CTRL_C_FS_2G;
>  
> @@ -447,13 +446,15 @@ int kxsd9_common_probe(struct device *dev,
>  					 kxsd9_trigger_handler,
>  					 &kxsd9_buffer_setup_ops);
>  	if (ret) {
> -		dev_err(dev, "triggered buffer setup failed\n");
> +		dev_err_probe(dev, ret, "triggered buffer setup failed\n");
>  		goto err_power_down;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> -	if (ret)
> +	if (ret) {
> +		dev_err_probe(dev, ret, "device register failed\n");
>  		goto err_cleanup_buffer;
> +	}
>  
>  	dev_set_drvdata(dev, indio_dev);
>  

