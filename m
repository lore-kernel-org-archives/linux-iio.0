Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862823081D6
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961758; cv=none; b=sERcwJPC81LHNOEFfIw0AOW84il7+gf47iTlfCUGxH4Ub0mPBbau+S5Fldv+LHyaKmTL0+v/D9qFE76c4KTWhz7BscghCiM8nAtRBZk1U8VuD8ogN8472HcJHjnbospkcKsYb1ja2k3bsqagFhTcjfjE/a1WdUbatdARwn1Ydh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961758; c=relaxed/simple;
	bh=3N0ABRarTdfq54f1BH3wC39dBAKNrx/Lg+8U/uI7/mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPzA5VyRNQ2L6OZrR2c3uiwQ/X3ENQLJRO3YFC68izDmpv5gP9+0V5vOJDIqn6xwnTSvpTFsLv18nWQE9QSA280l/KMSmxPyDNeqFFa0CEh7ZzWof5nEVglfrJbKJNODEfRq2Dy7pw7SwRoJZPfCImz53FuQGk9ENWorf2S3sNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqQgExBO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b3UsKqdY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqQgExBO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b3UsKqdY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DG5GnL2030798
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e2l5AlR95TaD7LKI1gelB+DwJJ4uQc1DBAVxbTpujtI=; b=VqQgExBO2ziP4XXl
	LxBo0E/0b747DcAle8B0dbc0WkvL8drMvHnEqh9Q3gKBKfaTEIrPCNGMpkaTfEKB
	OVeY064Nx3a2PkiqsMVVaSePwnK0TQx9YHyCCi/TH7304L0xolX1Sp7deLkiBSK/
	7IJEg+ktDj0SdU01Q8zOFAR/zgbO4b0dQDtEwnBgdylwbzLYYxMDe+DE4IGCFudl
	S9IbOmNEhUlzMR+0N4w73ZCboDFyUcKTBU606dlc4pMHKt6ryRpH942izoXhvxcO
	4ut/aWwQxIsEYbzmQqrGnQDRvK5+linr2e7qpo6Qr88VHyTWra/6QvpYT0Vq8mfw
	Zlx+qQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37x872d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:55:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso4164965a91.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961755; x=1784566555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2l5AlR95TaD7LKI1gelB+DwJJ4uQc1DBAVxbTpujtI=;
        b=b3UsKqdYy2TjBiShZaJzrBoCJgI+hyWRfaR+xe/87Kem74jAzuiFkSeKeJmzTmmGl+
         4VX2Y3dcPVi0uPM9mSBAUtz6sN7qdksrUFZTd2F+GpUXY1Ton1tpLcDgWqc1huL5Zyl9
         05hQjr9mu2qxnsxG7hKY9ZIqlMTa+V/KY47oCoAkyyqlKwDsVM8IiPKWS/TRmnPKQfA+
         vvdMnL1VfybOyhexBaGoD5gIiJqHU2IDTLGtxvfK/xgLI9lv/0wih7A0fPX6bq9XJXSU
         D4i8Wr4C+EHEFvFyX7fjGz1+ZzRH63C6tmZMXeLAjbuJItQX5dWFMSPO5iESiHsu4Yme
         8WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961755; x=1784566555;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2l5AlR95TaD7LKI1gelB+DwJJ4uQc1DBAVxbTpujtI=;
        b=YgeZZNHfXK9/oKu+Y70ZQT5f5RwFAPS4gPOQqeUeLOrThtGXkuJyGvYaOkpsxAQ96h
         wzQRAbujA+HvGZxADqwY/8nI9bM1O8o9GuXzCGV3hmDpL0Fm2/qk0CmSlVNJDarIHBux
         3y8bfc/LxAOnxq9xPAUlijyMPcTV3fGEeOmjRvc8F0hagXaME955K1E9Cn0RkttHE/Kn
         iVGo7hUJ3O+kGOmjxP+bamZLcja1fcKw6qAbXDrmFr1fnQx15IRV+AtSaUiketES7lZO
         hQQG/VL4aEohejYt/X35wUObU6yHOypSCPShYN3ssPZlM3ACE3nsnt7YPqfN3Cjn3+P1
         2pgQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8kXnnpg01Aw+CmAREeIwANmeofo+QIXinwE2wTWl9206Hrmd+k1B9fxeS7J5tGffH91L1DyUcmKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8fc0XeG0DwKYSiWNoERH0SCTdrGsoFcarz9Uh125qkZoDx64
	kw2Zp4BbRyOCvTPiBSWuciNTS802N7/FJPvk6NzhdizdRnISwber2g86UbVhs92r5PKhbBOcBIx
	lyp6LlbtF886UGuKhcXo1jp5rKB0sUKm33/1gq1UKNDbzmzfIguY0tLYnS7VG4KQ=
X-Gm-Gg: AfdE7ckfhRkkQi9aun4QUwTxIm5lBhOQpu4vEdowFhgWelullyTAyXKpFwZ+mjb9R99
	8wqe2awW9+Q4wfJqSmBWbOsKogkBUbM4yaj7WFWNZj/NXG841YmfGlJjQK+twZ9Ty89BXfaMZbh
	wKJit6xRm0ZUsYUiictFiaVE9AkAWPgyE8vHYBm8ekRxqoERmM2ETC53+YZ0ELTTA+PFW7uWZA3
	/1mdCJJrp8lWMYJqrwCVp9gA83hqpMDlipedYxWMIa0CV/Ec8H9zkOjrVCJ0WhCmzcvEhrG3ej9
	gm2Uip58ev1V+FjUwTdY0gC3H9G0UeUJ17HGNOyezFP9F1hiq/rJAFLes+ZXhDV4SoLL3EhrNpg
	zANp0wJrsAeooZSPBzUt8AZ2Q+106iEK/eoUU4iSqHq87Lw==
X-Received: by 2002:a17:90b:2750:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38dc75ebea3mr9509027a91.16.1783961754977;
        Mon, 13 Jul 2026 09:55:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2750:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38dc75ebea3mr9508992a91.16.1783961754510;
        Mon, 13 Jul 2026 09:55:54 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm71653953eec.18.2026.07.13.09.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:55:54 -0700 (PDT)
Message-ID: <d47c822a-8219-482e-921d-f129e6dc5c84@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:25:43 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
 <aktArynt5xftgij1@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aktArynt5xftgij1@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX0MqSs+MtzMqQ
 vRbm/Fwz/f66VScfB4sP6kjDoah0wBH/l/R0KTjilGgmDu3cdGQjCVSJSPbQzP/6K+VHU12zdvR
 yfhZdM1Ec8RBsBYAa5ZlFJ5TPVDgWAMhbBLNQ8iM3QuWtsHwLQrmJxYlTWeBE/Mb4aFD6Ueztcj
 lH/fcp3/ZmkGt6Jvc/JhI5rFxYFdZYGbOsML09LxEkkofRjvNwaRm/S4SkeWcCSGQP7s72yYROL
 lcrgiawKspsahU2hA643OEVBFzrowcqDajVLhflFXvWKc4i2A+j0+q5nIWtNUJvjMUQ8RrY5kvR
 TE1xD3wnL0RRKtIRFZ2/fyYQO8G6SErtTiHEeiP31di5J2mpZk45odTQKVd9er9ZcFk/O/mUX4e
 WQdw74PhnoMTdyRGf+yNtdF2PtLCxBVHW5o6Uxor0+hX4THzROZU/daXItHAYRZION57ALWA4Z1
 BUL3rPk+t5rapAlTCpQ==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a55189b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=aSuIdP_MvOpnUHuhdBcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: lGkXFdRaIdFxwg6EEGCSv7WtB4F37QoR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX6Jnn52p3H07G
 1hhPUxMdKkvqK/Je8IbzILoWB8D9lET48SA0ybY7HVXO+gR6zON7qds4sHMRCn+3orygbEarBaS
 8eaj8sMaLtdiPmH9nIWfgawyoHRFVUc=
X-Proofpoint-GUID: lGkXFdRaIdFxwg6EEGCSv7WtB4F37QoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130175

Hi Andy,

On 7/6/2026 11:14 AM, Andy Shevchenko wrote:
> On Sun, Jul 05, 2026 at 10:23:34PM +0530, Jishnu Prakash wrote:
>> devm_request_threaded_irq internally prints an error message using
> 
> devm_request_threaded_irq()
> 
>> dev_err_probe in case of any errors. Remove the error print in the
> 
> dev_err_probe()
> 
>> devm_request_threaded_irq failure path as it is not needed.
> devm_request_threaded_irq()
> 
> This patch should go first. The patch 1 is not marked as a fix and we don't
> need this message to be printed even before the patch 1 of your current version
> of the series.
> 
> With that being addressed,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Sure, I'll put this patch first and fix the function names when pushing the next
series. I'll also add the Suggested-by tag as you mentioned in another mail.

Thanks,
Jishnu


> Also note we refer to the functions as func(), id est mind the parentheses.
> 

