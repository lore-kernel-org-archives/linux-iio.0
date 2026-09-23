Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0B1DC198
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150451; cv=none; b=R/OHBDNJAzAarMHkwtbUl2tI00Zz+t9Nayz6AYLg+kykY50j8wOzTedOP8IBseoNv7gYXOGURVhky6WOGl/M2EcXKoelYHD8GYehXUvYr+TRk0t9+nWSoNsMDhmiJtup9P2cJrY4QcNT6mJR+XzEeZ4z4wOQvqlNhGmKtJBIQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150451; c=relaxed/simple;
	bh=JwN6hTpQMoQFMwVkfyByUPHFjCGMZVwMl45a+afjvpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPPkr9SzPS7PUr1gFCjjDZHHh/8V6imZzoiQa2GzMWyQCezuDIvnMQjYtoM2Aq8Vc0npGJ1LhL87AFQLxhizbAAM8E9QwdZVpk6bPtIHbewdLF8eEzM6VN2X26vzZR/al30PWTeqCLNSW08DVsnI7s+3PSXf0B4ZoWAMb+6+az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LSn+6HK3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PsQRL5qF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LSn+6HK3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PsQRL5qF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N79kLA1232036
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 08:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbKWYqzhETMmr7i4688SV4iPCxXjaRS2goi1GtN4YHw=; b=LSn+6HK3iMvlf/8v
	2vGE28m8DpnxLe0zP7QeJOxg/CDxJ9LZFz8fRoUfug+UhvaY4RQnRcDxF4ygZ6mo
	eBCOkj8k+FvVzO5s6MmbvehNlRZkFUvImuPT1FVBKUR29QoRgq4C4yNO2NU6yUJG
	ayjiatt/of3JYKUCeuA203Cb+Ol9M2oG7iyudnNkNAz7OsrzrzJMGBgl51EPav6a
	l3Cxy1w7ZceleOiTAu9i0WGM0Ssh5pk8baya1d4MsTDkS79trxUMUf7msRHiy26T
	5XGQubQaeeE7QQ50toylZIDDSST/25DxG6Fw8mnlZErDWzirBc/aacpNYPtwMJzt
	Iim9uw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma2re4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 08:00:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a00c70d28so139489185a.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790150445; x=1790755245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbKWYqzhETMmr7i4688SV4iPCxXjaRS2goi1GtN4YHw=;
        b=PsQRL5qFCmE/loHsC97ocj3utn39DkLM/5YdtHTimQXaPDiVU10eXmEUUBOiWIpnKM
         4F1NC9ZxnYcK7ejDszE9vxbcOCLh9N43UxiaXreCnrVC8X+wtM0YEDjgVUaF+jFN3qcW
         kVfZa3i4fT4MEt+cpaQMNi1h/8/V96tJfuX8yvcxRYtsKyePxYkDAGme2mywlAxOT/bK
         K2dHc5lYXQJ9fHX57hXPX2bfMDPzecl45skt8KfXxhQBtnjLEimzOCmFk9gLCiTJdglv
         PuC3rbPS3HJQZ+beIOClbfw+Da1gfLuLzC+7ojVbtF94QqNo0Z6CxOxtpJq6v6ySzYIw
         uQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150445; x=1790755245;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kbKWYqzhETMmr7i4688SV4iPCxXjaRS2goi1GtN4YHw=;
        b=f38cBMogcU8VOhB7gIn2AkKFR5QUj7kLx5E7apN4eeVWKsrC+xaTTJ4izkbJmh7d4z
         PY+NOuTPE9njfkKkRr0tL7a2okO0cqUXMoMq1iZQrpsCFpd3c27m44Ryz3CqXcZvlt41
         +PH3sSD2G3bs9TS8FbntCIuhMLPRb4gVINEJ7C8oHtk95kn0KqJ3kfhhRnq1kBCxviOg
         px0tEHs0kuR9U+jkEET1rpkD7dJvZA2H4Ux1hJawj0dmtn3vzpwZHO2MXlyHL13B7Al1
         WfUd0102+j+ew2bNrDmplxOkxJMzt/3y9a2k46+hZfmNtikQ6MDnmr1/hExTrDkFvX3R
         hyeA==
X-Forwarded-Encrypted: i=1; AKwUvBzSwR7jZcHZQHuKMrxtxGgpil+7upzGv811MMngL06SyCSpz/d61IYhaqGojhJAR/H0GKW8LVCdbFA=@vger.kernel.org
X-Gm-Message-State: AFuF++kivsE+TPKcq3n+1I3WJjp/y2Sjv/mM1ceaYIngikKfnDsBmoMm
	7KJC6pourFWjlo5YMu/kts+RhmeQxcIDAJAMzLturoFlvr8cuOuYk/GSFLk+DxLZ8QhIan6wTvT
	uem5kP8Z2zrdNFznSmuCTShN6iJjl7PGU3d5kuDwkAsk4NEQPaCf/AJohCA9TSBQ=
X-Gm-Gg: AYBFou32oxtn+b1GdEpdRsgzFhmUlRme38bmyeQKvyR+itdBt8XGrt6MGLMilz76P/g
	RCs0nXiCq1dpK1OyKEBU/qspo4ucM77vmLxn1t3zpi2hrkS8jv68SkIciKr2gj6zUEqn7ZeEgt+
	hkj6MsjIMazPK1Pwad4VGBwHlpTLufVd8N9HOiHwLNjaqon0n/wzTTecYDjwn3rM3mEvYue6v2w
	yhqZiAu0D45geBnIvc1opAy4/3DE/rMYP02p2zv6/EzgkLIjB3tfZTSBu32A6+iikaQo30TmTk5
	purP99gVujc0IgCbDoO4madHDElL42ETYVZzMWgIxE0vaySx69PDMsOEbTOPG/b16IU94Qezy3d
	8wzXp3vNiGMJsmajyqDSg162cErdgG40JvnbMVV5qUPtVJBOl6jHHzz6+cPTeQA==
X-Received: by 2002:a05:620a:3910:b0:93a:252:705b with SMTP id af79cd13be357-93c2513e511mr295175885a.23.1790150444672;
        Wed, 23 Sep 2026 01:00:44 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:93a:252:705b with SMTP id af79cd13be357-93c2513e511mr295172185a.23.1790150444287;
        Wed, 23 Sep 2026 01:00:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a913:ba43:96d7:743c? ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1a3b46sm55135535e9.11.2026.09.23.01.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 01:00:43 -0700 (PDT)
Message-ID: <313f498d-a66f-4e38-ba9b-6393f42a3826@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 10:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct
 adc5_device_data with __counted_by_ptr
To: Bill Wendling <morbo@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        codemender-patching+linux@google.com
References: <20260922220950.2267270-1-morbo@google.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260922220950.2267270-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3EZXRsA2uId86QQz_edvBbQMLjFFr7rd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX7wTeXGMVe1xz
 MgkMq4q+0AvHIRdeRvSAsXSBfoCxvXUvu4bs0e+3UNzGecJMHUaeGtGozfvMR2THSvBYtkjl1Oq
 SCgsQVEdWLu099m7O3AAUssNp+wmdnw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX8gwlBWe2qr/a
 EMCtWHvSIRyyzQe1s/BtP2INiBD4YgMK6DoacYgF+AgIf/QBG+wzBl/k0xCQNwE0d2T/HDci2fM
 PAuCOEHSMPj4NAsOKPXrKYN+SgHZIRK1XnPMDIQj7T2b3+VQWkFQBY+bqTXPi26E5cvdbCnYaGU
 EUeojuOQYMhZC4rulLAgchn1tseh/KmNHClXBmjLlQnlYvV7narCvSXCpCvXS6vTucvbQRApWpO
 lqwSRtCK7HJFQYY4Gqm8C5fRR3b1/06VUMBXigg/8jLAl0D1ABSpfx2eUoBcT6CpjCUEuaCqPLv
 XB/56rXLUWPo4Df2gzwFfdCMQJjW24GJi0FMEUMVNN9HbkwgRbWhT16vQzbNOKlz8WY0IstPrBl
 4J+gJigO24lshHfXmVBn+2GekULqIe+n8+a7LuawGqZ1sHiHazbD8iDGA0+cLbaREuYg5c6k5zb
 ITa8RwPHSjL40JcrWbA==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab3872e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=4ffO35K8LLM2FldQJH0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 3EZXRsA2uId86QQz_edvBbQMLjFFr7rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230031

On 9/23/26 00:09, Bill Wendling wrote:
> Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
> fields inside structures can be annotated with the '__counted_by_ptr'
> attribute to specify which field in the same structure holds the element
> count. This enables the compiler to perform runtime bounds checking on
> the pointer.
> 
> Annotate the "base" pointer field in "struct adc5_device_data" with the
> "__counted_by_ptr" attribute pointing to "num_sdams". The number of
> SDAMs is determined from the device property and assigned to "num_sdams"
> which is then used to initialize "base" via "devm_kcalloc".
> 
> By ensuring "num_sdams" is set to the correct element count prior to
> the "base" pointer allocation, and since the size of "base" is never
> reallocated or changed, this annotation is safe and will not cause any
> false-positive runtime bounds check panics or KASAN issues.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

