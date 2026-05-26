Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA213CC7CD
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801156; cv=none; b=j3OG03/4o6BjvbixB5T9vdn0k1T2kQO5md01E4jVZhnhQla8KcnrAn3/MiC/6gJn9F260zyOfWebyZqostCRK/PqLn7SYhAPG22K1O2ldv4yUa44yE//NEGB9PaCEY43rfLMcAdRlqtLCN8EpXllY8mKYRUNkDLKNLMfa26bzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801156; c=relaxed/simple;
	bh=VhU5lAS4LQFsAitWBLKALDCa2KGV/IuRNjV2ufL1+Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1Ul2ZIgvIyeDw6akKJIYjPzQZMJn5sx45HpbeMwkNQSMtTtcfy4OegGeoaYRCRiBYC0aKlidy0rRPn6hXjjqkedOfrx/zCRarTKQwjsS0cnpk9M4vWYQMDIU1okBKKtJ8C++53Udk8FhxAIkrCfHngaBQRlIOZziDOMQKwQsjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pLPvP3SW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NUwASvem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pLPvP3SW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NUwASvem"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsXxQ1430496
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VOwFZ9kDwgjLO7jINUmrnJta/iSMqgv39m3ThSw3Gbw=; b=pLPvP3SWl7h1o8mM
	tOhqbnNrVM7bvHDo5Nxb4tCTfR/NEe6DsTx+sQiemiVOY7QT8yU+HLIl9L12Afnh
	TfN1i96lvlq5VThGo2TQmVgs3tgUWy5qxdVdys+xWhOZkrXQJp89dHeilGiLjNFt
	UfGjQkHiLw29M0/rthjODbl3CSffSQQ3BJ54YnFno6MFZ4IgUOO/G+BVFYMBtnM9
	0BmKjf8Zgb/fJyQoGazpgmhHk1vB2XRssXM1zTQcZHEjT9BFJFQZT93tdMEbIyTw
	EqfN9JARInHCTxtJ3sVTzW4uu7TMC8S54wIYPHEEBYjgAg9ClUiIMIsB7AH0F2+o
	b7fRnQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv52wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:12:34 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-63309595daeso16118000137.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801154; x=1780405954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOwFZ9kDwgjLO7jINUmrnJta/iSMqgv39m3ThSw3Gbw=;
        b=NUwASvemgzjMytpj+W1ZJDluDGmGUvg6zOMV9YZgjpbDSQn3rh9vzKSQkwdD5F4mZ9
         JpifiRTHMYQqzSzfBDRtMCh83mgK7K77mMF+WqQ5F6shSG0Oyuy4tWlX+1SClG+QFxiI
         TPEX/OBlXPVkiwKp6o8upqj8zR5wZ5G+H8kbFaVyA7y3DZYYlNalvCW51CKMuF9oZG+n
         xI7QSfhc2HaMQA5nJ3hZEtCFB8CwrMIll2twiK78h85Orm+jj0e12P1Y9hVVGrcAWRpp
         IcdYpcrm5FkikuB2WUpC4feqA+iZrDZVEb2IG4jj3oXxHIR4fk40N50pJmohd00pkAY/
         w2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801154; x=1780405954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOwFZ9kDwgjLO7jINUmrnJta/iSMqgv39m3ThSw3Gbw=;
        b=Hu/cs6iMmpe21FoorNV/ZOwQhnXIqEDYocWCPC684lvR8mDEQGHbu3c8gkreEiJHs9
         gpijiFajIUlApEiES8bmjpQx39S84ez1YdicGAHNbxyqm4DiGMC2eJzpCig/fS5qcYql
         sm5GaaBr3M9noAgNLSawiMTVyk5zJY3GABHjgFmoe/dDZIQHjeBlcD2RgrRasxOk4VYq
         7jcwsT/41Vp2fnyMJ38Cn5sKsKC8erKKyXQBFyG9Z8X8xEr7zJy2osGeyCfwzAuaB7zl
         W/qWZCDiojIKUo7zUelnSpxT6WbIx52jQbhPibx7FeKW32OUi3lksTdFxMrLaZW23/3k
         iD7A==
X-Forwarded-Encrypted: i=1; AFNElJ/i22VptZvo1D2AQ0ipGXJ63cwJrv5/18zRkME/ua6n9Wkrcn4KNYxP1x3RXYXj5zxPdGNr9AYyYYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjb3zepP5ob+Qjw5bJNf8IMwt8rZ5jHv7VT4ItJJwv54X9CPP
	bcYb8FH/ki8fymKM6K7UyJxftflEEEZzJuf2DOaN4nvnQOg/wPM5Gps5kdzMOmFzxXQYNSTBZC0
	A3JBzjEIXt1cIBWVWKa4P42MaYonfOAc3p0VVXi5c1EGpsfabkMec/3or82bBcMk=
X-Gm-Gg: Acq92OG8Tr2tKbuPQkAOZ2HaeZ59UBwhhDl/NH+APOVKPaQmCqKobyiS7cEncR4ubtB
	h8xwIJn2F9yx/njAnhk1KHTwcBFGPcabUtaTxgacFf+zt6mLzOZ4Q2lRxp8PpeTzVKBqEHgvVvo
	CNRKLQtjLW5akb6Su7IbVK44exyv/fEwQXo/DPSE2IvliqpHv2g7jSiarOHSsDihJGjRlZiks0P
	vvW288MDytfWCOhJKaSWIcnBoTgn9HCGIMFirrZwV/BXz1V8tOHlwKaUpV3ztvNqVtMXk6pX+CM
	D5m736AiVSsq4H4QOh/7fHDdHa9NW6lPVcXVg6l/5ejhbsdRBs0rupsr2HBjj2qVq/fMKP88YfF
	HpMlFpYC/vGeUj+GuKeSXFer0zPbodESQMBB/DSoIpFjuYiu4kyepUHn2aeX2BC9dO7biuGqah5
	zK6eZ4xw==
X-Received: by 2002:a05:6102:2926:b0:632:eef7:4b7f with SMTP id ada2fe7eead31-67c8d071383mr9240029137.22.1779801153591;
        Tue, 26 May 2026 06:12:33 -0700 (PDT)
X-Received: by 2002:a05:6102:2926:b0:632:eef7:4b7f with SMTP id ada2fe7eead31-67c8d071383mr9239948137.22.1779801152945;
        Tue, 26 May 2026 06:12:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1? ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49059cc9a91sm70577445e9.1.2026.05.26.06.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:12:32 -0700 (PDT)
Message-ID: <3584c4eb-1d9e-468f-bd30-9b5d91c865af@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:12:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ
 with ADC_TM auxiliary driver
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX+wcqBzCYFgJK
 73CqKLYeaToSD6Pv36EBp7GLu+KekbKP5VT6Q2F8HeCKZtCqrlJIitHWrOQMog2S+WZh1QgHw/N
 NBlqKs9MbXhexZ/sbIWYyxE3H0BTPrwmzWcWY7BGyauJWv8r6sWoywThYzfy6foUQMJOlDg7/cI
 MpxTf0meEXXv4WMBuODbyH30epK7QauTs1osG7Sb2s3Fq64cddeinrOlxvgQt+hSOs3K2MxNXLV
 ToQuJZ6xkFDiUttJ8RKmadAY2/3oP5CP7yMfO3kGPY/DIBVLIY5cjYC1poa1o/MzwAeMpZF12Sg
 L3lQuyO4ABkVMWcJanLXdLi2QzcvhgSlKO2VCMcCbS0NMbSEmV81vaS5Z69QLIO7D54shVscea0
 JfRNLPuT8T5Uo7H+T0Br2oQkX/d8E8cSG+4SeIJn6Yvdd/A6CMaM9cfqqnfPUUGLhPIuaOcQmmW
 j2Jazs9gmXhdY0fdqJA==
X-Proofpoint-GUID: HYRKVTwgQGzcJtMVdAvwKQ4l9fGhQeZr
X-Proofpoint-ORIG-GUID: HYRKVTwgQGzcJtMVdAvwKQ4l9fGhQeZr
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a159c42 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=IW_paQoX8PhNCENOWI4A:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260114


Hi Andy, Johnathan,

On 5/26/26 12:56, Jishnu Prakash wrote:
> The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
> immediate ADC reads done in this driver and for threshold violation events,
> based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
> TM channels on the first SDAM.
> 
> At present, this interrupt is handled only in the ISR in the main ADC driver.
> When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
> driver by calling a notifier callback exposed from it for this purpose.
> 
> To simplify the interrupt handling in both drivers, share the interrupt between
> the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
> the ADC_TM driver, so remove the notifier callback and all TM interrupt
> handling in the main ADC ISR.

Given the nature of these changes reworking how is handled the interrupt 
to share it properly with the TM sensor and the dependency of patch 2 on 
this one, I think it makes sense to merge these two patches through the 
thermal tree. Are you fine with that ?
