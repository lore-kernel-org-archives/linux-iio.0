Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B41EE7B7
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338815; cv=none; b=Y/qREBLFERCVJ6wM9IOdmf5BiYecRHVIPDhPH2XiiFUrPlogPjDI3Mu8in4XJ1pEgoUCkrhY+VhUAObcZChQMJdaW3BWBs80+UZEBc2OqhLa9iuWlHJBvlaw3g32OLUyZBjhq2zGNa3jV/O4mKf37ASZkuGvW1hq7ppGXLMmj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338815; c=relaxed/simple;
	bh=D80olKqHpoW/xieZjPwzd9en8wqk7u7+sjkbkHWHx1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntEWK/nwbyhbAgVca1CjRbld019fkyeNRIwvtKR7YXhH6hD/zMVeiWTL6T9aHdYJ0abSpPESQ1fka7jPBnNTgCjOf4hJ8Gh6d1M2rMT0szpyrVZrvhtZ0KbmBwqxxxpkuLRZx7XtXEH8YYtN1Byss2NzyXcGBGyQbRbrNeRixIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MHawPBaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QdigBUJe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MHawPBaU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QdigBUJe"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNEPxO3335913
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S26ezyycOtOJJs/eO9LtmBbdx8jrwPqoD6H81PFFNZE=; b=MHawPBaUfTnwVOG7
	o+SmVpl5eFJPZ2WXCmraE9lW2gZFB1lQYiFwDBVktPQ2i95EZDExtLF5CId4OUCD
	5j9m0mnSQs8AeTby4bSwduGrqb92g4OX4ZWWGLNn/t/SHZK83qnZOjFltejMhigE
	rzEfX551lm6XUptgUjpIOL1SHt+pARg2pSvZKOJ1IpC02V6Jmcp0iFtsnXL0O5JN
	HmtzNFFLVhp7EY8kPCGxfhRJqb45eC+Hc6pFWwxyPksoMQh3jge5cXLV6lHDeBk0
	/sAnTahoFhxWiIK+3vrMXpG6Qc+QXkoO0sMfYRuTQ5nd64GZaosx/pinic1njspz
	0BSCVA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrsq9e5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:40:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso3036420a12.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784338811; x=1784943611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S26ezyycOtOJJs/eO9LtmBbdx8jrwPqoD6H81PFFNZE=;
        b=QdigBUJekqn9tD7PycUXQ4HNTZR7OkSmZyk4VvszfJyvLZus81mUsG3WeHiLQ436fV
         o7MOKhAryEaWToWNYyAVo1LMx0J5N11QXkD2wGJ9yis6QCjPPn30rdEFObBMOxVgfigB
         XyRuQHpkCWPiXRoieWSYbcQfg7ei9Re9+1vHJ3Dy7NXpTC4scEeU/i7ZctxJqc76UmHA
         XmJFY69gizbNLX/MmoJkElpoRjFeUGonW2Dapai3GewfcEoABfkAJ154ufHn93rXY/yy
         frxq3UAraI+d/+h/6B1v7tDpHx3KVjgXOg/hUrqxTgFPsrts5o7d3LB0lppKbqAuwlFp
         GfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784338811; x=1784943611;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S26ezyycOtOJJs/eO9LtmBbdx8jrwPqoD6H81PFFNZE=;
        b=aiF+MzV+YYzsd+oHQDwuUGRppsqbcytVr57/ymLcokmwrqNwQxv04gRsHePiVR51Kk
         CFLklzGV75v+J8e0BJt+Uo5EqWliKPt5cl7QPR7if8pomz8AGxp11fVmcKolo381094e
         CGql+6NvsLxSnOQOlJ6C1ZOeiaTv5prGxh7sHDQeljnM947psEtJYFS3Ly8Mi8e9/r5M
         yl9uVmjSBLStkTDAJO6gRTvRkHdJ4NToBV9PjPEleHZSoloV9aQmJlgagWKIHLYMKEbj
         V8bJrRPxndTg0lIBRMLIl0ZiOCO9/p/LrZT4H53uyKAoMCB8imlC5pMIfaEUZingi/yl
         McKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsHOtUmQEM3WWDDaHIrewtEGsFDrOmzFtruIIjit3iojGhLu4Vxpq9sQo83ECGcUvWkEuSlw/R9Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6y/4e3HKErdOJM1XYqB0yu075jHpC44FwcGC99oSOZDqbJ4Q4
	Xh2om01Q5m2oRsNdXZ+b/NtNe2WN5SO+rilWCxG5lxFyBvJu3N6alTlvPbxa4LbtCTg3XoFFGhj
	MlKKXg91aRICcE5hQDrX7az3QDxlCV91GT7fGU3AF6p6DzipRyFR9Yg4SmyXrkOM=
X-Gm-Gg: AfdE7clv6Oiw9HnRwT823KZp5jljdIMKRmzc97FCQgWgg7q8UmcmORsb9X+IpA/rHBR
	2fvm1FcyPrt59LKN64tPqFXBKT3mjrbRPNwTSPhpfBRhoARm8fFAHzxmAZn5aWhU+Jk6e7YpSxB
	f3U4RzOOSEqT35N2NDoJNyzbX/W7eomROHaJF3NdTMvYmguIwVu4x+sOy7Nm8vvKAF6MeoJVcS9
	84jSLJcX/yIndrK0/JGPAqdSmKY36WOgvtYR+sLqjf+owHMevVn+TBUsikVaUJTLNmAIAXPwE/w
	WzL2nxxETzIrxe1BduoCMi6Eb4A/0g/KBDmBH/2y2bbm6A8d2EUjR+GFMozYOtezUKHuazRIds0
	gSXhK1FRbvPDthuKx
X-Received: by 2002:a05:6a00:278a:b0:845:d284:9e0a with SMTP id d2e1a72fcca58-84c294d4d65mr5211975b3a.49.1784338811351;
        Fri, 17 Jul 2026 18:40:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:278a:b0:845:d284:9e0a with SMTP id d2e1a72fcca58-84c294d4d65mr5211955b3a.49.1784338810876;
        Fri, 17 Jul 2026 18:40:10 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc3466sm2028562b3a.15.2026.07.17.18.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:40:10 -0700 (PDT)
Date: Sat, 18 Jul 2026 02:40:04 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petar Stepanovic <pstepanovic@axiado.com>, Akhila Kavi
 <akavi@axiado.com>,
        Prasad Bolisetty <pbolisetty@axiado.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Harshit
 Shah <hshah@axiado.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <20260718023952.5627abec@jic23-huawei>
In-Reply-To: <alnpMFK6_ZkdWlLi@ashevche-desk.local>
References: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
	<20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
	<alnpMFK6_ZkdWlLi@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAxMyBTYWx0ZWRfX2t5ShFewteUZ
 sO8o59gNbYutvRlVevYj2PvNodFtQhstjEssNev5Dl2gTGMkGYcOsmB5qTtX5txNYjlvIz9sauv
 /K2O9lsTHzt6+ss9sMNTUreA7kw7DxE=
X-Proofpoint-ORIG-GUID: -RsvLT1gRKYFXvXwz6yxp59vpnR_I_3f
X-Proofpoint-GUID: -RsvLT1gRKYFXvXwz6yxp59vpnR_I_3f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAxMyBTYWx0ZWRfX/8Zv0lGOVVcr
 egunH0o/lxFzRjkIkPs790NxHDe38NwIY+7wF/u1AwQRc7Bn7ik5xpbHolpkYUuTm4hMK2F3DKY
 3hnqcok3eBxCSyI2EpV65mI9T0FbAOEsj6YNMjpKRD5ikEOJ7e4Wjr5XInJ88nhnaoaDZ2hKh8B
 w7s/d5jLry3poyhj2A086btHnNTdYFuQ0LtQj6lWgCf/zGWAVuarZTKyiouWEdcnTJeOjRsNgD6
 +2gcPzFBbiJem9cSuG1gr511z3tBtOuk18JuFBi1XOB7yw1IGAOhy9MGA7xUb/bMo24cnuWNQqk
 q6WN5NCAiD9uNysRCXaeY5gwKeXx8OHHHm/F5JfOk1FSOXZzlqb5UW6KV5LmEeUA1bSkkJ4dEDk
 Kprs8BgKcqx+tMgP++sp+EuHMXhX1vBWo/bAKuoVgM2lQPAI1bvV9bBtKHg1TV5OkCWxKMyAU6z
 rL7QRWbtGBQLrtncuxg==
X-Authority-Analysis: v=2.4 cv=OJIXGyaB c=1 sm=1 tr=0 ts=6a5ad97c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=QyXUC8HyAAAA:8 a=JNnEj29XURRsWGGOtMsA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180013

On Fri, 17 Jul 2026 11:34:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 16, 2026 at 10:53:02PM -0700, Petar Stepanovic wrote:
> > Add support for the SARADC controller found on Axiado AX3000 and
> > AX3005 SoCs.
> > 
> > The driver supports single-shot voltage reads through the IIO
> > subsystem. The number of available input channels is selected from
> > the SoC match data, allowing AX3000 and AX3005 variants to use the
> > same driver.  
> 
Andy already commented everywhere I'd have said things, so just
a few places where I'd take a different approach to resolving stuff.

Thanks,

Jonathan

> 
> ...
> 
> > +/* GLOBAL_CTRL register values */
> > +#define AX_SARADC_GLOBAL_CTRL_SAMPLE_16	\
> > +	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_SAMPLE_MASK, 0)
> > +
> > +#define AX_SARADC_GLOBAL_CTRL_MODE_MANUAL	\
> > +	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_MODE_MASK, 1)  
> 
> FIELD_PREP_CONST() in both cases.
> 
For this second one I'd rather see defines for the values the
field takes and then FIELD_PREP only used inline.

#define AX_SARADC_GLOBAL_CTL_MODE_something 0
#define AX_SARADC_GLOBAL_CTL_MODE_MANUAL 1

To me that acts as clearer documentation of what is
going on at the point of the write.

Similar applies for the SAMPLE_MASK field where I'd define the
value 0 with a name then have the FIELD_PREP() inline.


> ...
> 
> > +#define AX_SARADC_MANUAL_CTRL_EN(ch)	\
> > +	(AX_SARADC_MANUAL_CTRL_ENABLE |	\
> > +	FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, ch))  
> 
> Missing parentheses for ch. Also wrong indentation of the second line, missing
> one space.
> 

I wonder if it would be more readable to just push that inline rather
than having this define at all.
