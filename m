Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DE263F44
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513670; cv=none; b=a82jWp7EC8DVtOCKoxygUB90bGAoKi/sPM+qN9FyRuiQM90z0j77kk9Jd+fxtUos0cvY72EUSZEh31LUHWYYRJFPGaq/bFzD0SsfTzydkuoT0o/RqeoM0HPDefLpo+ePfl2PZ4AzTpUFgCCqsqtAxZnYOvt1luv8FcpSC7a/JbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513670; c=relaxed/simple;
	bh=HFXm3OgvR61fwhvrmL1cVwAPMNBg/hJ1mWDNBEWvoug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKR/4C7dfCZqKAixAieztIfVzG2rZo81ovQEu/SGWBNz1PzZ5Z2xZeaKn75+lQh/nO+kHVjbQ43mAdccvP5aRc9hffNcBiqEJQE/+7QHCCFoclF8MFk4d+F7FLiX8OVGVgIAGZL1TPf9Q4gdT/ZeT8/X8pLQXVMD9ch+7Wv+tqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kRXqd+Zo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WGpDEju0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kRXqd+Zo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGpDEju0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNu74C851933
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cz2kbkjaChOgoQHcs2ZrFTmKt1BtekR/I/x8jioORdY=; b=kRXqd+ZoSDrb/pX5
	uby84pzskyI7yHixxOgH88I7cXUS8zw7kXWuvUcuiMMrB9RFErteA4zgFvFlIP05
	1XDLW9bOitQGjOdi3J1OuX7F8l9+JSFVpkQHeaEQnuHMkjdcTOg3pbKu9/a5YFw4
	tskhAGlTpbNtLcdCqBsR/waaUqJ93hhkm1onu6TkzBZYDmpz9MDnOw7licPBYr2w
	bED5H6k+QE8rvZg2MBgskwbEtl+kKCSFl2tABD18B88UeAeKAX5chDEgxAO3eHkd
	o/o038BtYUuCJwIoLwbq6bs7Z3wMTAKicodPsALHh0Dc88xedwfk+yR6s1CMp4Mv
	8mXs2Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc402c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:14:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cd01a14e81so140604255ad.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784513666; x=1785118466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cz2kbkjaChOgoQHcs2ZrFTmKt1BtekR/I/x8jioORdY=;
        b=WGpDEju027SHV+g/V895AHPpeDzf8Go2c5sPoGCW8qp0rEc3OwJ8QMMrmz2TOl882R
         EpeOISA7HvOpiFnmtH3qfnQ9o9UB6WdHuAk9o2d7gWfv/TY99vUQCMc/iXGYKXk0EJsd
         Jro4W/CencctIh3neXwsTdPulVBw1vjkKvPHKNcdXcg3EZbaUxFN21+w50exCnxMJyU0
         EBhnelg3aUVKpJetfxhh1N3byrNCPZSRr+yqUmBkj3ymBLkRfykUmNwR2AdyvUpwzUvP
         gZMNRz3iCXy7ZfcU18wAgwHM0oN1TJ47m2KbFUQL7DU9ct+j6Le9l2vRP4CdEPgEob8N
         JXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784513666; x=1785118466;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cz2kbkjaChOgoQHcs2ZrFTmKt1BtekR/I/x8jioORdY=;
        b=HaVH5jCT8WnF80I1uR27dRIjo8cg6rSImAOvbDJHhl+ZbiqyCaDtAbg4+VWyq2Q0h6
         Rdopt5KkZNvcnOJB+inAst7ItZu7nl2/cJLreNMuKjG7YOZQEcPYcE0h+8tCGy4R2owc
         VklpOfwGQDq2VU9HRzipNJogp3JB0qvq3M+Mcq7/VWVkjg2KusVgJk5bRaQGZi6uAV+U
         bxY2Bog5HzPPbMa2LZgkXscijemRv5MvjcHmcIkfnmu4gUhmKI0ApUn4phdJj5nl/JXj
         xzccuML8FmpkQqbD4SyQD9+rOknBB2bxV+WwFdTxyAgaorji8R13K8BmaAFMbDDDQGtf
         MVqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEgOoJsaboizUESwf/OU/arcK9BuEjLV1Hx3f7c0HHV55GuBii+GIIjq8HlUAWKQ7Zr502nVHRyfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAvIH+h2uBJOOLYraHhQi7v2UFJC7qgXN7jwSGgVbgw1tUDni
	oVezr6VhWiTiqhAve24/V7X5yMPlPTfSbelB7nAOtUHIgQP1D8p8GiYsOC6+3p1LFIcTzqg+Wdd
	P0/CGeCd8nn+gpdDbofI7GtVSs7dz5oi4SLnid1c6zHfyrbOn4oMfJqPWK4yzJ58=
X-Gm-Gg: AfdE7cn+HuvxkZWY5pmqq1RqgdfOdD/ybkX9g6spiYaSw6sEIUiiKBhfVZRmGEwaEA4
	fFJbXj/JKrP8p9tkKiOXC5OmwQqhN+ZMTCKxHfV1wDsByWeKG+wioZSXxg4s5ecdfx4Y9rJ5cEc
	sg7b8X0r306DIVdO7QD+l0LNO2/VeMGkN/B9kFhKUSLFNZAr0PsEvY4ZE0L4QmdxjIRVdCkLbjI
	9C6LW0QJHvE5xe8xSzxwGKvPjHXmwOkZWARK6B54wIntSOQ1DtSUveByONKtInZ4Oj9Tvl4O23C
	NXI9upUq1ZF0hHdWdo7SsVwLc6FvOofj/i2DamSNhZ48jebgf8M4hZwzjHbdo//c5ag5/CYAxbG
	1rQcGAPPnfBoRtzpI
X-Received: by 2002:a17:903:41ce:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2cf34a33fbfmr137140845ad.42.1784513666556;
        Sun, 19 Jul 2026 19:14:26 -0700 (PDT)
X-Received: by 2002:a17:903:41ce:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2cf34a33fbfmr137140445ad.42.1784513666081;
        Sun, 19 Jul 2026 19:14:26 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf41cbc0ccsm36703775ad.2.2026.07.19.19.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:14:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:14:21 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: kxsd9: validate input before acquiring
 runtime PM in write_raw runtime PM in write_raw
Message-ID: <20260720031421.445f2216@jic23-huawei>
In-Reply-To: <20260714122520.3201-6-birenpandya@gmail.com>
References: <20260714122520.3201-5-birenpandya@gmail.com>
	<20260714122520.3201-6-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyMSBTYWx0ZWRfX1rgBtM3hf/nm
 NSv5gqIoySafTobuxtL2R0VOuTSawT5h8/UctyEU8gcyMEoJTvZGSeQx5GHxtmJS2sHncPpDESl
 a0owPTgZcgVMRL3WHuoCPAcFrhfgk2Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyMSBTYWx0ZWRfX3AGkbMrazXT8
 5ze0KkxwbIvhbVWD6z6cMkm0BaKGcOmz3D6aGmudo5jHf4gPCj2MHsDiwa8tT2E/pOb2V8OxRnR
 dEX0Heay9dOzBnJYT52XeU4iHD2/dCjW0GIhcmGhYZf+wKq0mRkbRFmuodiFm4SPe+cqiBbABQT
 VZpp5PCPNQF7Bm0tOf9UfRi8aAeDTyp3OFRxu3j35dbSjbDZrSSSJKIpAHkjHbjchk2FGBL17hn
 +9IgdbmXbkrhprTcGISFn7whG8FTT9fvaTQvIAi0gOZ79G7LBmvaHMH0wCgrevi0bzi6IyeLJwW
 cwN4iHeQZD9PvkOl9+9l0ZCb5KTvoy/eIF/iykEvNE9zVChbEjML6Oo/lRf7eOlFEcOl1BIZ9hR
 YFR98N1hykIi9FfvEw2KcRRZILto+fckSnmyfXzCoOVpZeYoNYtFrqSwCpF6Z0ab7RPwfe0seWz
 YH95c5da0ZN3yqti+yw==
X-Proofpoint-ORIG-GUID: 89m9FQ_U7yaHhYCgm4ljhwpKA1W0TOyo
X-Proofpoint-GUID: 89m9FQ_U7yaHhYCgm4ljhwpKA1W0TOyo
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5d8483 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=f31TK4o0IvrSzcbg5oIA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200021

On Tue, 14 Jul 2026 17:55:21 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> Currently, kxsd9_write_raw() acquires a runtime PM reference at the very
> top of the function, before checking if the requested mask or value are
> actually supported. This causes unnecessary hardware wakeups for invalid
> inputs.
> 
> Refactor write_raw to validate inputs first. Additionally, modernize the
> PM runtime call by replacing pm_runtime_get_sync() with
> pm_runtime_resume_and_get() and adding the missing error check to
> prevent proceeding if power-on fails.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>

Hi Biren,

For a series there should always be a cover letter.

This patch looks fine but you may want to take the approaches
I'll suggest in review of patch 2 and apply them here for consistency.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/kxsd9.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 7ac885d94d7f4..b3acb20441d86 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -139,18 +139,21 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>  			   int val2,
>  			   long mask)
>  {
> -	int ret = -EINVAL;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
>  
> -	pm_runtime_get_sync(st->dev);
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
>  
> -	if (mask == IIO_CHAN_INFO_SCALE) {
> -		/* Check no integer component */
> -		if (val)
> -			ret = -EINVAL;
> -		else
> -			ret = kxsd9_write_scale(indio_dev, val2);
> -	}
> +	/* Check no integer component */
> +	if (val)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_resume_and_get(st->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = kxsd9_write_scale(indio_dev, val2);
>  
>  	pm_runtime_put_autosuspend(st->dev);
>  

