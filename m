Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFAF3FE677
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337156; cv=none; b=cBAfOU4j7f9daaq+SG+wTuPHZ+BijoPSG+hmjIXb8C/os4QjtZ94bLK4FxRsRCdoSt2YFAp0q2/kzYTW7E0XGxMTcmkGtdFZQ73rJsP0KjggOBD7HzwCoCwh3efLdr5pgWA3cnaXMicqJ0qCNRAgqWbLPCix0IVtyqOMbvwJY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337156; c=relaxed/simple;
	bh=mZjpfXdg1eZgVj+gUu9XkiaycK799bI+POtKiloa1KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akipbbMGMLtk5HrmSRUTP6YNpkkXZ3enzHNO97vNOsGMUiJsMa3ZifOU/MObiFkj2a7+fnq/oatmg+Jaw1VN8wwoKNByfjo972Wl0TbwEgTNmhpHxsG55ftzC57O3u7wjVHQzE69FanrjbXaXr6ug7V6BfHjor90sxf09HS441A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NdgyLIho; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MmoJsIiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NdgyLIho";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmoJsIiS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax7N2245529
	for <linux-iio@vger.kernel.org>; Mon, 6 Jul 2026 11:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bKgKWQ+xIVE13CWGd/k7b98wHY3plb9noY75qci7lNY=; b=NdgyLIhogU2NCEYA
	yrKn37lesPgEkNl1ivWs5RCx64RhYy0A+MJrXtfOhHk/Ef+f+7zGpoTOjWqjMBWt
	96Rx67tfjsq6Z8C9Q0VPPolG2wz7T7fZoNWP30Jv+xIMt4kGxU+YCmeAr2VcNmWi
	CHV6TNiw+rOXOT9RJcwHelXr4sdppnWX1QIPmSZESerqAMq8yfIfSeUmzhm+ue49
	8qdUWN8GMLmijxhHtCqLZ1RcBGDLmYhtZ4bxo596x3fTpMsYrJMyxhqtUbMzwTDk
	aJ0UjilegkvvQFq/Wr+ABekVGsd5gekalEIXNQUGrGTeXrojpGLBH+oB+SJoRYYS
	k5l8bA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98g9r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 11:25:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfe75b7dbso9708101cf.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337152; x=1783941952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKgKWQ+xIVE13CWGd/k7b98wHY3plb9noY75qci7lNY=;
        b=MmoJsIiS6PrhxVTIryWrOfH3vadIOCwcjbIfxlRT3VRVdOoDNWomXslJ0mymNKNVtF
         bRmrseH8iMjRrTzK5OIaDC/SgQV/HnId2z2wGZozJyKMbxJugzmIdaLaPF32CL2+uoV5
         V42O3fAjmmG4wB6Xi8kneJYNfznrTfKXsARBomzvzo0aoqLLf68jrKQfgk0dCwVODvuK
         dY5/A2Yww+0yvEsjfcbpXxdj4WrydkNQlug/puHBt5St4Mxn7lAvAdTw4tqvPHGzJ+xb
         EMKVcqyKDS50c0uVNmSJelRYeGw3+9jbO/iT1459c/+jI+XyyTWe2p2YfUhcYFWcjTeU
         N8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337152; x=1783941952;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKgKWQ+xIVE13CWGd/k7b98wHY3plb9noY75qci7lNY=;
        b=Y8+H69+oHKj0pcX+NSjfnCQ+SoGQ0mgzP+bCM9lM/fuQk1UpOzzuIOZUjS3g27RY8e
         DVSOTEoSUxmEEo4e3vJ6/qDVeGxQcQzMVcKGM5p43dukfbFStJaTe96dQnEctfU/mWLt
         hbeJLFEQgo9NtspoN9MYrl8TDs1I7Wo0oixJzN2/jdxQw+6jpU2bgU7PiCLF9uxSaiwL
         yLr2MaDjw+4BJ/89OPFjhq83fXIvIIE3tpmcMkCGc7/ZVMw7MxhaCMEUmH3qdP7vtoSF
         SNzlxRCH6Xz097eqIrvbIujSua+bO+UMOEnA3l0GIWsF2z9KF1sj3pPWOx12Zw6tVm7l
         Hqpw==
X-Forwarded-Encrypted: i=1; AHgh+RqxK+PQCCmEv/uoKn3rCk/J9IjQGGKfHR8VKrCW3yIK2u6RDCX8/B4jbjkOVFIIFLsGNZ6mTlvIblU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoSALYMO25Une7zOYQtOr/87MnJrIt4ubeFnktxFsanmZ73DZ
	Qev1ajY1bIz0ieSmSelw9IJM8ePktICv5Aw1KQ0Qt3rQwF8lBh8GgBtVQPVJtFM/echaHRLQ3Zd
	ELze9CtlUvVcVetxMLFPPJlBHRb0VdDOC/lbpw5oZHmxNKUzu3CGNn1EmXa2QAYI=
X-Gm-Gg: AfdE7ckv4mMLkofskNTkmqoKTtsy3xC+UuIDt55sBlThGyTl8deImJTLWXKHQ3a3Y/K
	3wsgmbhD+ug1v7vbdQUrdRoUWstU2rfBZTNtY3sGgI9H5jXoSv/eA3Zl/fRWohwoA4g+CsgJt03
	+ERWy+GDNEq5KvAkfmMEBwt3+4nn9cYh5wW1bpxChJH8Ze6Jad6kcr2wgaHO4M5+DagI1KnkLnW
	E71jUb8lzlA8mIj8VfaePp0ZrhwMNxFeTs9IaxsaRdBIzKJMfpvweKykKSDAqtpzdD0ySyO0SB2
	AIDCYpaCKP5VuO+2snrKx6bRaycS0i+wtzaSNuNuiLkKD+grHsI+qnhMO2sF3tCV//lT/etNxFC
	Wm7RtUuGPj4nrsrexZ/a89UkODn3MMaCA+6o=
X-Received: by 2002:ac8:57c2:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-51c4be98625mr93371081cf.7.1783337152279;
        Mon, 06 Jul 2026 04:25:52 -0700 (PDT)
X-Received: by 2002:ac8:57c2:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-51c4be98625mr93370951cf.7.1783337151785;
        Mon, 06 Jul 2026 04:25:51 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b629a1d4sm711584966b.39.2026.07.06.04.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:25:50 -0700 (PDT)
Message-ID: <b8f7df64-3e1d-457c-9e8e-57e4d2bf7ca1@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on
 driver unbind
To: Jonathan Cameron <jic23@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        hcazarim@yahoo.com, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20260529095649.2452-1-sozdayvek@gmail.com>
 <20260704000415.2446940f@jic23-huawei>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260704000415.2446940f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4b90c1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FWEFCM-Gamp2U2xr488A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNCBTYWx0ZWRfX9pU3+3zmQ6fq
 O/z58eos2xDrJ3KWtcVHgvoRMLZ0hh0yUGKfkRA0RD1BD48WAdl+mCaXvZ/36aAy/2sqRzLNjie
 dQlOP8JDFYi6kyLFvSjPsvSvf1OqNpZvheW1TO+/xh4MJksf6zRdDaitGRjVq4q2hNhrIdMEgxd
 8OD6G1ICVawh9ViGOEziDyyLGmKwcOv8lWhZs5FeCo8AaVu1krXON7HO6xkoaM2u7315CoQIY4m
 TqtWxqGqt1Xo+dCZSqt5SGKmZcdoZ2JV112kKwyKDdxocNl3LW4xjixSxLys4qTvu1hTXz/I+cW
 wHTGgT3oGylY8VzdgrjuUx/qlE2L5bTMn8a+at6l3sQPMv0jO5BGmsV5RqhuZUe1mIGMkCwGtEw
 KwWUdbgjWAqQsw353b1m5e9luvkNGG6QvuDaoCskMCiwrYOKliaK7qvRKcnsKnh1uAWd1lFG03D
 5hrOxGlD95B/tBoUUMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNCBTYWx0ZWRfXwVAZXNt/Wkzq
 uAcQPpYyrRQbYlbpe8+egUEHXioy+TS8qfd9MJ62hrWqtEtK3gJWaV4oIgPKtizcjL71y74Gy3A
 vYnLdg6fN8h1df/wZZKI5LId9rgAPF8=
X-Proofpoint-GUID: 0v46TKn3wHyDqUj3Hy3eTAnaS9F-QMYu
X-Proofpoint-ORIG-GUID: 0v46TKn3wHyDqUj3Hy3eTAnaS9F-QMYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060114

On 7/4/26 1:04 AM, Jonathan Cameron wrote:
> On Fri, 29 May 2026 14:56:48 +0500
> Stepan Ionichev <sozdayvek@gmail.com> wrote:
> 
>> iadc_probe() calls enable_irq_wake() after a successful
>> devm_request_irq(), but the driver has no remove callback or
>> matching disable_irq_wake(), so the wake reference count on the
>> IRQ is leaked on module unload or driver unbind.
>>
>> Check the IRQ request error first, then register a devm action
>> that calls disable_irq_wake() so the wake reference is released
>> in the same scope as the enable. While here, drop the inverted
>> "if (!ret) ... else return ret" in favour of the standard
>> "if (ret) return ret;" pattern.
>>
>> Fixes: ce0694841ea6 ("iio: iadc: Qualcomm SPMI PMIC current ADC driver")
>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> 
> +CC Bjorn and Konrad as we don't seem to have a more specific
> maintainer for this driver.
> 
> Seems low risk, but nice to run it past them.

The robot pointed out to me that this makes probe fail if the
irqchip isn't wakeup-capable, but it seems like that's never the
case for the one that will be used (i.e. the QC SPMI bus arbiter)

so:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
 
Konrad
