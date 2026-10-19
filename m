Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84647ECCE
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389921; cv=none; b=eG+lOV20E1pgr8MEzk8EvSyspShhy1z0PKos+qwNQI8Dtb67Q6Sjg9koofed2quMGDy9gBjs8jDpuMyw0YVPOK/LNqItcUM+XhQVnoXKcdg8q10QUXO6eFz9rsmbj/gVDnv8dNbdK5PhCyvGm3j/Q+o0M59UbxshP6bzZEq8scY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389921; c=relaxed/simple;
	bh=eVz2kOkeYGqtTtls5Y5pxyYcXl8r5yMKB0Xmf7FiKNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVd0HOpEz32OPLxhPG9nMOiTiqp9Fh9vTFEDO09wY2M80xLbiGmQeiJ93DLbCmt1D4eQwOMLyA0AP65yoVTFvtTm5u5YATDrFFLWMx2YAmRJUWSJcVYiDB/f3q62MZmJDVHMxvCEPqnbDxZeZT6k+OYyLsvE5mqNZ1nJG+xN4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MRn2PdRK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwcz5ZTP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MRn2PdRK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwcz5ZTP"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4ixFZ1552881
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 06:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tB06UDpEriWVFySp15EJ7VgU
	Kt47g1OZ4M7wqg9CBMc=; b=MRn2PdRKSHF+PI/DJ8Vuoytz4ofplgtn766QFQ4V
	mMipqI1bIovjH5aX8IdO/is0fLqADjKaiMVkTmaL3Yv8kA7jCf31qNaUpzkO3LuH
	tG8h3W9BnayOuCpSwI9nkhtIMpp/bQW3XaHnEL8iT6iZ1XeaLb3PVo3OxZ7MIwdZ
	ARC6hxvNllK0ATcpMWjz4usXc7Mf63R2DPt9nAXPXdeoORBg8WtTODhsTifSDqbS
	5a2FruVl+611AQpBStzo1vquAxt0lyVz2eywYBVukCybhC4NETeFgBsTdVTNoAMQ
	HV5Rjxhrd4OqYdx6yLkWA7UuTNUtP94lbFIRRtvSY/cimg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur1742-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 06:05:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3592077eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792389918; x=1792994718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tB06UDpEriWVFySp15EJ7VgUKt47g1OZ4M7wqg9CBMc=;
        b=iwcz5ZTPNxfAsrhW9ZSt9u87tH5/kels4NCZMXl4n3oDl1g5Apk3Fb4zwi+nXm5bRw
         RJW8r7EmQiYbhR8iKatAeJwoQ0m+P1llzo8+h77a0uJsj5rieX4eya/qDW9FZVBEyRo/
         nK/GlMy80oOWptb8ZNrTPpIrnK5HUiYpQRhc/1Ke06TfY1Ee1Cacl9Ae32Ta0Yo9UisI
         HP/JCOAQ1/KR2Z3kdU0o8Il6kFls80SnTH46GCRYcjKCkLXfD55xilEBbrHlkoY7JI2j
         LORxbWya0TzpEr7kRV7B6MdoALNhI7pE3cNZgPcldd93LCWkcFIWhPhvHNnLVArGsAtp
         vuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792389918; x=1792994718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tB06UDpEriWVFySp15EJ7VgUKt47g1OZ4M7wqg9CBMc=;
        b=NOcomCwj1vwIGjpXeT3TIvmVmFYG6IRr/u9MvuSu0ymwl8ySdFg+bgqvhr8pHuv62i
         7z4Jw6hFgpdzWw3yc/Pm2sO7U74ApHH/r2b79Cq3PKed7K+fkk0kYHQoKZZqdkNOR9xd
         ZPx2iVvs5FTYV4ZhHFrlexwPI6+C5h/tsrMl5rDvkqppQ5yve5uJ38stTXBnb4JydDGj
         fIMCd3Z1TTx2ymgC3q28aSNUgg8pI2MvPcXpq6iVlRl1LdWAzLRYDu6prNZtBPlhtscc
         MohaEi/QnypAYd60bhhyCjdZtmKgCnNPueTNMtXeWQsqdIciJ7IL+k5uSWIXHMvTvgbC
         tlPQ==
X-Forwarded-Encrypted: i=1; AKwUvByasMjIhhaoY5jwp/TVKr+0vLugK7ZYt/kcDJJ+fiNMfu+9145T0R6BJIYxDUWRT/SxofUoLAGb4YA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzJqw9LBD7K3/K3uWAHA48mT4qbstDrNfIDnp/k+p3fQQujJ9h
	bgFYYt6DO1OvjLMdaRlq7BPNGXkaH0XY3y6LLWF/UeOCe+ujXRYUAK2ILfRMA19j3aG/5y8uQTU
	NewAsddqTHtoDgLCBuG9+GW8szGKXrVWh0u2zsWU+Xmqd430MFLdnH0b41GpH+ZU=
X-Gm-Gg: AYBFou3y5d9PdqFWIuNeszE5wi6UmR/Lex8N4Pj/WvxHMjyxwmKrrTjbRF6E5IoFhfv
	G/0UUzXIDlEoufI1h0lOfvyBNJjPNtELbERsLo+x6hiae9f1PU7nVVbjw1Kf14S0mo/lZHPRscj
	9+tf4kqUy8op+dsA/FmsqI/J6+LErtATDDPx3CPvcGoI779Cnv8R2kNfGYS+BQS/yditer8CKGR
	2A2LZGFSdKt6hLY/9qs6qlnJwa+92z6kdkXspCjIadXj1NIQ/8uFWBGWPqGMY7GNeBIkN6F1R1J
	r2eFH8qZ05LZQ1w3IkHVcjgtI7XG19AHWcrPE+uO0OmUkWOthYiI2X8zBEDRHSYxSon32vQ6/Cw
	2fWhkOyGPSeOAqCzxE6Y1+D4XS5OxYToNrNgZqfa51Q==
X-Received: by 2002:a05:693c:8353:b0:35e:fd8:3201 with SMTP id 5a478bee46e88-361a136eb6fmr8863397eec.14.1792389917767;
        Sun, 18 Oct 2026 23:05:17 -0700 (PDT)
X-Received: by 2002:a05:693c:8353:b0:35e:fd8:3201 with SMTP id 5a478bee46e88-361a136eb6fmr8863359eec.14.1792389917130;
        Sun, 18 Oct 2026 23:05:17 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm28638345eec.18.2026.10.18.23.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:05:16 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:05:10 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Dan Carpenter <error27@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM
 aux device IDs
Message-ID: <atWzFlOgRICAGM-R@QCOM-aGQu4IUr3Y>
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX25SqZfnX8oCr
 WmzwSKhMvy6NM6vLNnahr/M5X1s7Szv6PBFA+wfZZJcwu6/9RJ234RHKLw/c4GVBx1JBEvNMqy1
 bnE/TKB9auETMs2Mc3prVwSlbLWqZzQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfXxpwElQVHNbeE
 gm37q2Nt9Wzo+UugpBaeqx154elHsRqOseyA6uZLpSSug69LUNQwM8EYI8h8xafgEJG+L0rSjkQ
 WwbZEPv6QFHWwHDR5K6GEfYzV/9DX1wTk8Ff1jxxmuKw+fW9ux7KBoq0SUFhhQ+W41f7GKXLigC
 ooSl1MOfs52Jsb2zo2gbi6AcTkV8zxAzUrQmteXZEDTXjLPiyUR0YTlEhaoaTvEhNiIrlLioOs3
 i1rWMfSg5HgMyZPusdnIOIi0Nmp5a9zn7nh4439AK8eMRcFPM0lC5/sCyfLNtVco82EI7UUe865
 U7lcO6tV1BrblhHKgykuD+3W8E7ZD6lSyEEmpQaLNqA+877mwDGxJu8XmVsBSXFfpmPz6eJus5e
 iYrIkwtcq1JsqCI4L5+Qzjeuo8Ir1YMkIg3p7dxPzOgczeIVnSpXDQ3+8WZLI0rVi2nmRCPWGls
 VAunh/jK5nw+lFHjhmw==
X-Proofpoint-ORIG-GUID: TgQEU00WJIFwazMUB95gUFxQHe8X7wR6
X-Proofpoint-GUID: TgQEU00WJIFwazMUB95gUFxQHe8X7wR6
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5b31e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=sqrxk8c0NW8lVwhiI0QA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024

On Thu, Oct 08, 2026 at 11:11:54AM +0800, Shawn Guo wrote:
> adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
> every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
> to register the same device name. With ADC_TM channels on more than
> one PMIC, the second instance to probe fails:
> 
>   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
>   ...
>   auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
>   qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device
> 
> The ADC probe then fails as a whole, so that PMIC loses both its IIO
> channels and its thermal zones. This shows up on Nord, which has
> thermistor channels on two PMAU0102 PMICs.
> 
> Allocate the id from a driver-wide IDA and release it from the
> auxiliary device release callback. The ADC_TM driver matches on the
> device name only, so the instance number does not affect binding.
> 

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")

> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
