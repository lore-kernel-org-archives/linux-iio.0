Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA530F924
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542942; cv=none; b=k+C4XcFW6eCgl9KOLSwKct80H+jTVJ0xfKUh0g/XOV7hRjh4X8/mUgd48KHnv0egHmchTQUfuzU4nJslkj6Pg8+6W9/r0itWYwDefRLWYx5rEXVmaimbJWRHTN9KNz0vEhAG9Wwh+gLmYc2sVRwbJaKg6J1E0yUxUFw5YnonBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542942; c=relaxed/simple;
	bh=6MRmg7TJJKOuasZ7OvCb3k+fyx6Wxm+AQcUJedDC5Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ngheovrrn3TssY6saD5fPwqvcJ9RcgT96Q7u9TslZzgLmjOwR7SYHSIZgwP0ZDsKmJcfr1R/BsU6WdTzDc7nvea4OMywWKq/LJWsClbVawOGXhMFZTQFQyt/MNqf9FncVw8WGgPYnh68yvR9ORy6PSmepqD6liGZ3OFx72+nMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WbJHK57V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GL99gx7s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WbJHK57V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GL99gx7s"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RHUkT0880291
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 21:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A+GSdpW7yBfyGaRyjGVl+CKeobMIXZVKjl5ykqCPPeo=; b=WbJHK57VxFDCbeSW
	UlPYowC9ghazJ9CPI5Mqg0RUR3QeSJm3536wODZB8abuF786xdLH6myoOSP332/O
	2Knf3fSqIFcAd9SdPh+Y6mItvramFK+cLyALEdTcb8GCdk7bbNO+ZBuWSIb+ZmwW
	crnn3vR0v/r+wvT47/L9330m0TUHFb4vW7k5KmAXoNaq42JufPBMVDkkZPm8ND5V
	MekxDTFkZ3tUky/Dwyd4lEZ5ml3g58IFuI3rD8SJ0hj0wcPLs5vXFQ0XRixCe5dX
	h9UZW1zPHnn6xNbXCVs19D1V48r9Ulq681Ocdr/oGGSi2KhAEKLKQU0tyhC6vbg1
	Q74/fQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwbqy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 21:02:20 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso1979537241.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790542940; x=1791147740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A+GSdpW7yBfyGaRyjGVl+CKeobMIXZVKjl5ykqCPPeo=;
        b=GL99gx7sB+n9crj+gLU6diHLhrK06bAP90+jw8ncW0kahJQXzNnlZXMmuk71sOTqtU
         AAtVVnbBPzP92qsqcy8Bx+ixeFF+BWWH139geSa5gRV9czjyNuw0FIbfME3ooG92I50Y
         KUwC2h3Ok/9x47DSCsJID4qwUBMDc4cag2g16aT4xvtc+NGta3kPGN9DFh4R7kXKgbg4
         BCng0jENx0HLVIu6bI+9KpS7+wyRwOQUzOkvFZsdUw3au1GCsGSz3S9c2vm0KsZ8ORLK
         dptq9/d8OwgjjphxVbVK97dfCZ+oCCkjXaEVMCO7/bh2jsYhN9ykJc8QdodZXaaro5M7
         XksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790542940; x=1791147740;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A+GSdpW7yBfyGaRyjGVl+CKeobMIXZVKjl5ykqCPPeo=;
        b=iIPkK2sqnusviglTtIHkGiMDsvZlmqSOltUsCdx/a1rxu5OaJL4kW0PLRqQuXTcU/H
         BNwKW+IUzWV7GIsN9YhnnFAC7+QzPgnO3B5bFCxffh4JMXt6pv9b7pMC2QY7RtR0W6Ak
         sj7Fmq4EO3O1HtRImtiJaW1ruOEHk/HEXE2v7n9y/C9/vjmBEZ8XDicEuM4w/DK4Z1xV
         TbmTjNKJnlugBHnMwRWp27u7Dhoq1/pX0UNtUebpuA6WtK+LH7sfElfa8+P6Auc8UVRY
         Zefenmz8RvoLBvj95ZRk/TwhjA86ka7w8MfSE7VWr/V9ILkrzYTtVV0sU3yNx9MtgDHq
         xmIQ==
X-Forwarded-Encrypted: i=1; AKwUvBykNPIuPWuI/joZByYpUW2bU3NsQOf8ED1XNu+PC0O5MhVNlpag+XOXzFYm2MclGn9/YjCJOtgyNnI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq7KyxWBuM/d9QQn3nsc4BAxJHOHYJ3hxflKU2dw3D8SeS8UnG
	pmzxpCqQgKPnLIrsGReN9az3N8A+VbU3LvtmaL/ElRy1BrpaKBH8l3P6Zy0O7KE6s6+ephkxwnI
	nnPtra4iJoTH8hEgGWyHv+ZU9PSYid7hs75zGIIk8eYhUdpgbYIaBlEujo5f0zPI=
X-Gm-Gg: AYBFou3YBBQMB1xZHSYX3FLBrHEm3Sdq3i8ujMABplge0oCYAacrLyLlhzlJzrznb9L
	8VK2Dyu/aUMjPsAFENRRhd+qeUwh5t8O6Eu2Hadjlgwueo5kvKl+ad9e7XqnJC9PXkuq0F1bRqP
	mH8zd7Q8+GiSq1ocztfI+NTQL+7vlksIzd3CcqQV2NMKqV7Yx7cMMTsdzG0EP6Xlk/Np1L9jCsr
	MfsSLWyyiZHrbMVMNNRf/y+MN4jYjQ5nZ8Lv5Yj9Beg2gx35na1gPyhBCqqrC8nU8n49OprfRyj
	lirN75X1j+kkxj8NlayklU0UD5n29Kl5Ar5aCdCOCE31Uz4UKov5d57EvKHYK0Xk3OxyX770etQ
	86h0cLRrR8of/aqcTwLZfqg6IAZN0X0z40nqorpkp+QMJnNFuD1XQddVSi3EDQg==
X-Received: by 2002:a05:6102:534a:b0:7a0:f7cc:5045 with SMTP id ada2fe7eead31-7af1be75fa3mr4656522137.9.1790542939806;
        Sun, 27 Sep 2026 14:02:19 -0700 (PDT)
X-Received: by 2002:a05:6102:534a:b0:7a0:f7cc:5045 with SMTP id ada2fe7eead31-7af1be75fa3mr4656514137.9.1790542939367;
        Sun, 27 Sep 2026 14:02:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a354c47sm23726209f8f.15.2026.09.27.14.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 14:02:18 -0700 (PDT)
Message-ID: <8b8f49c1-8d91-4808-9a51-5e02b3ad374f@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 23:02:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add Renesas RZ/G3L TSU support
To: Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 11yrOomgcouVIOb21iXUExd6mWSuQBqp
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab9845c cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=7_ijgtP9sPRt2fg7aQMA:9
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: 11yrOomgcouVIOb21iXUExd6mWSuQBqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA4MyBTYWx0ZWRfX3xefxlV6YSKr
 Jbhqkp98oTp4IiF3qHGzUS0KmVlNn+GrTY/SJ46UkO+LQ/cvcn1plAKsJxV4vknqSBtqiHRWvcz
 kwpxinAYcfX3iDoTL3/ly+k93/Je5ByPfkG2NZRG/xId6BpVkFPz1X8yw/Y2hMMWZBwoyOZuoGd
 Cq2UcNsgeKJEFBLtOYHdQ30GupNEAfzzTXZyD57dOWVA/qqRY75GTrhBSBuxXuHc2gzRHvzbDjA
 6240QEzyWqhxR23g62PciGaIrclSHbCOxIXRB+A/lXgSTikk8HqJu9Gba7xmeP5gHUfrp4SFQuy
 H6a1s+/711LwhOWbMhQO5PNggqSdj+Z89bzwAWoNyNHcNx/pKxslcZl2DdQXPTFsIAEBuxIWi2L
 RTDTn863aY04YxUwJ9piXZHuqOK4ysBZU1IU605dDlSeaAXdGeyjJLd0n5cksGedNJe9l6J7cYw
 oVielSWs4759O01XG+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA4MyBTYWx0ZWRfX3eOQ6h6bZTlA
 DIhMAzIBnNMxGs7frWSu+6C3cqP8J5WOiJOYefIK9mBKd9O/BaZjnkDWzYKaH8Xkl0uAeB7uet2
 E3z5TwbeHaSgXhD62nJxjMNf6gTDa8w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270083

On 9/25/26 08:15, Biju Das wrote:
> The Thermal sensor unit (a.k.a TSU) IP found on the RZ/G3L SoC is similar
> to the RZ/G3S, but it has different calibration constants. Moreover, the
> TSU is connected to A/D converter of TSU (a.k.a ADC1) on the RZ/G3L,
> whereas it is connected to ADC0 on the RZ/G3S.
> 
> Compared to ADC0, there are no A/D conversion result registers(ADCR0 to
> ADCR7) on the RZ/G3L, and the INTEN bits in the A/D converter interrupt
> control register(a.k.a ADINT)  are also different.
> 
> This patch series aims to add support for TSU along with ADC1.
> 
> Merge strategy:
>    * patch #1-#3 thermal subsystem

Applied, thanks

