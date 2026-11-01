Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502919;
	b=oLxJIJHoQRCFpejHx6Q5L6/ERljPPIO43sLaTb6P+QR+yWEzgxJDI+TJPsxhoH/zQQyT
	 zvAPP7LWnuEdw+xah+6a+R343w4ZZ7zkZY867WB4qjTvcbqoNpKow4XfPF4xkYdrZlV0j
	 hmgjQYZkPvv4C0AFVnZRAtEf67In/+Ny36U73FmSKG9Y/vnfbeGpVtDiZgQbe3mvefvZn
	 q73QRnHI9zb1vs+ubtoRd6WnAPwbi8k7qyiYsK51HtnIQ8oLMUuhbb/YM6C9Jr6zprqqD
	 HsNltpJ6j6v47sypdVG6/B3sXvKm/tjDpF8KJRebibjpvyd5LxyexjqFROJvcllMPIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502919;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=s3S2uYM8/USFcnTV7atLvovkptZrXT0Iz5U3uf62RuE=;
	b=aaJajkgAw3WKzlIuB75NSK/pQRngVh6P6RuTufl+kh8+qvzjkkNDyvbZlgVetXJ+7Qiu
	 RftRXUTrIkSj4w4JbxuLJeXD/EwVYrp3wL1v8/zpYxoSLBKrONLi4PEHVTeO8Vhjb6SnR
	 Pu04fTMF8KfAHRNtw0Ax6eGJmALJbL6zTdKC+KLtnUH0OiMy2yZ2NFLuDWIWwOFDDczrD
	 ttjQKUeT55L6sz3qDBGa9+jowvNKn43rSokKElrn549WCulJbiGJGZvkCOwp0Cvpcwk0y
	 M0yAiRo4oLt0n6cMNa92ejN56cncnJvOi31Jhmbob6xsMd6gP3BhRjYfUF5dk63ZzOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOmd7CVG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CPgnXQW0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B168606A329
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 03:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B168606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOmd7CVG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CPgnXQW0
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1202x0151533
	for <linux-iio@vger.kernel.org>; Sun, 1 Nov 2026 03:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=s3S2uYM8/USFcnTV7atLvovk
	ptZrXT0Iz5U3uf62RuE=; b=OOmd7CVGBLeCB57Sp/8LeC+QukumjuXIMW6CxhyP
	k62nAyIiB1avXyDa/diLV8cPxscWiA0YPSmf3gdqWUASBcYLjrC8PfI3HvRuNCT8
	NuSiYBD7mljiSEfx67mErG8vCNQK4Zt2gfgnJK1WA8J911MLZbpUxPojXsHGn1WF
	00LmBeRjDcNcWbsnQ4amtLQsljh1Yce0LaKkBIidyxyuGalsRvUzhmxAYhyKj8+D
	a21QeDjwZhCxKr5FdlOfervxsMdut/MqdsxNNYOoXwmaqW5bcDcm73B610z8fVAu
	uvzQtxpaTmoVQYG0YkNg115Ul2sk+4L3s0AC8SCIKPb3Zg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6jpfu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 03:15:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so3151792eec.1
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793502917; x=1794107717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3S2uYM8/USFcnTV7atLvovkptZrXT0Iz5U3uf62RuE=;
        b=CPgnXQW0rWzOTwEeiWMqU3REIoxU1uyxLv8YMPgfHJm0lx5fNLNNbAymVvGqHCGN6q
         0wOk53H33SQ3U6JLLDE6IeuTLEZW0P++I0NFcFfs7MLiraenXI1pjeZvPY4HR1f9iCAU
         p5gbinmiQq3cRJUoOpZxXjNgftQO482Nzm+Q5NriOIIsOUY/ENhkn1o5wSsZx2KdCSEb
         QXDi+/Kl7z+JG4gGdq7eiZzVz2bq5rkXRgTMPhFz0E8v9ZwLn1KPD2QwPpEvru06yQvU
         Q92E4UXfKI4eszVkmmifzgdFpWSDG5/04XvhTHSbhmpS/DFg79XBIqDLqEr4UXbP/5r8
         A8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502917; x=1794107717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3S2uYM8/USFcnTV7atLvovkptZrXT0Iz5U3uf62RuE=;
        b=Hj2RecKg/SR5AWxHO+s1Dxygxqm7ouet7/UwRtzt9Lx9QWcRPOI8/5JlpH0MDWdL4B
         EGEZwrQp+CPDVnodLzqVQnAA8tEPmZzQNKOzEy0GvldSKAKwVRk2IgMjIboJvPypD/C4
         7H148iiE+xeCh378pjBF+ZOJ97rdMvwNQUMatpNiJBX7ncqVDtfJjhm0iY5HWTK1nFr9
         9jioHKx7mHQYsgmRfzffwbPfJj0V562AOZjsjvhTjj8NQG1FhMR0LHiCvxSD6j7ywLno
         Epw7OTErm5nT+JYiD2p/L90qWxManHhnCad93OkTqcXr4QIbVNBA0riTz1IOTc7BU/32
         93fA==
X-Forwarded-Encrypted: i=1; AKwUvBw97V8KhJMSIr7t6Ey/t17wNbHO8LsCdMbzDilZPI+uYR7oB0ZWmEYOX2yxb6Cpg10EkIhZPanbefo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KFZ5Sw85Gcgh9J4DgFOFCq9P/sJrTJAD7HfGPDjcgRzgCG/L/
	kbOcup1Y4I68ppfxt42P4iEPGo/gZqDahTNggcWEMdjo7pqjio4l0C3j9eSVS9LX1C+ZhbDWRQm
	SqOty9ibD1nb19BmqAVWGX1FUkP8FlwuPBsEJxiQlLGVClnMXN3NQDjmVAmhK47s=
X-Gm-Gg: AYBFou2LaAXWMaeEgdJXArLl4vINVMa87bVtjnsQYUkn1xpIzDDfPDZ0oaluE8JSL5c
	cAmd4VFBGXXbql7RWXUWff08D9Q3bjTH2oYx/Mv4oEtUJmNZ1jesahsyFylLX2H9W5EOzmX+1Vi
	4ZVd1OMStfeaJ3AwK89S2gXlAyY/mC7onJNFA/85VbYvcmtYj+Qo+NVZqahOuN3DxVjW+q4XvQo
	8a3bzh6ehCJ2LOWHD12SFZmBauSPFo5jHMS8YV9mOONnDsenpxUqTYsPoUvTzINLvH6LK3xmdq+
	nt0hB6Bx20wjw5lkOYx8xTsprqNGBe6PTX7l4RetdtAfCX2QrQxGJQiMT8yEo4kIzioLH+BXDAv
	2s/viV1vufF2L7pIyU4egCY3YFVuJhDEWcaOaI+CZkKGECAwOtHqyu1/WCDvtLA7FlGyyfxhfhU
	O8zkmDh7y95TkQUg==
X-Received: by 2002:a05:7301:618b:20b0:35f:2858:aa4b with SMTP id 5a478bee46e88-36a4241b070mr8860789eec.30.1793502916847;
        Sat, 31 Oct 2026 20:15:16 -0700 (PDT)
X-Received: by 2002:a05:7301:618b:20b0:35f:2858:aa4b with SMTP id 5a478bee46e88-36a4241b070mr8860761eec.30.1793502916226;
        Sat, 31 Oct 2026 20:15:16 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm21725563eec.6.2026.10.31.20.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:15:15 -0700 (PDT)
Date: Sun, 1 Nov 2026 11:15:11 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Reuse IIO device ID for
 ADC_TM auxiliary device
Message-ID: <auauv3zAKPpYVxXl@QCOM-aGQu4IUr3Y>
References: <20261028-fix-adc5-tm-v1-1-0018aabc06c5@oss.qualcomm.com>
 <20261101020047.66034613@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101020047.66034613@jic23-hlaptop>
X-Proofpoint-ORIG-GUID: fQOhLTG3NKw-PiY6roUY6KM7jgepRzFt
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae6aec5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=icylPTNulc19Rdkzs_gA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: fQOhLTG3NKw-PiY6roUY6KM7jgepRzFt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAxMiBTYWx0ZWRfXyMlRQVJ+0GYq
 1Jq1063c8rRejpyb2AW4Bn1l9dixCUmkMv4ckHNgtx2wT18FY4k/qB3ymSRqn3IaaMr9JmwYoIn
 Dijjp18piIHF9Mjxt9iJi6iQbQmI+ic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAxMiBTYWx0ZWRfXwYiLgVtU9tUw
 VXWpYUl3x/E2Pb+dXDgvHnluF6TIH2cq8/3bqLMCNBvoplAcsw3N3HDvio+iP+rWqO5cLthJMO9
 rB0CWlm+AHvXohy1D1+6bWi9AIR1NrljiIGSbgN7Lpy0m42zzwHatblYOtg/ZYlmm/jyy7iqyZj
 jluK7oItLR4AbbC+9Q0XtqcCSNjBtBgst6ytM5lWGzl6VXHLujXRoUr25BxECpbaZxJ++pQRzYS
 LGhSemlyx4+VtNqYsLYBNmoQlofb3MOodIbJBe+hBPHZprKDuSU6bm9/DlsVQPFaKVBcVK5d8Sg
 RHicZxlhnceqBPIMbFmoNgG+27M+sGs4aLYPtxYvC9B5jHXwOYPLjKi4JaopgZIw1weAFAIRpy9
 ubwkRJLC3GkHiINwjlEKRZc+QKEwk3W9zzm0pcVH+INy/sNOSJ05OubpxuFnrwLxEGMs/J9yUvC
 VFm8hYbLiufLBco2APg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010012

On Sun, Nov 01, 2026 at 02:00:47AM +0000, Jonathan Cameron wrote:
> On Wed, 28 Oct 2026 15:09:47 +0100
> Loic Poulain <loic.poulain@oss.qualcomm.com> wrote:
> 
> Hi Loic,
> 
> > A recent fix in ADC5 Gen3 driver allocates a dedicated auxiliary-device
> > ID through an IDA to ensure that ADC_TM auxiliary devices receive unique
> > names on the auxiliary bus.
> When talking about another patch I'd refer to it by name and ideally
> also add a Link tag to the lore.kernel.org for it to the tags block.
> I think you mean:
> 
> iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM aux device IDs
> Link: https://lore.kernel.org/all/20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com/
> 
> > 
> > However, each ADC instance is already assigned a unique IIO device ID.
> > Reuse that existing identifier when registering the ADC_TM auxiliary
> > device instead of maintaining a separate IDA solely for auxiliary device
> > naming.
> > 
> > This removes the custom ID allocation and release handling while
> > preserving unique auxiliary device names across multiple ADC instances.
> 
> > 
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> 
> The fix hasn't gone upstream yet (assuming it is the patch I think
> it is!).  Would it be better to just squash this onto that patch
> and avoid having to care about a version of the intermediate code?
> 
> +CC Shawn. 

Thanks for looping me, Jonathan!

I agree with you on the squashing. I just sent you the squashed version
(with Loic being author) [1], so that you can just replace the one in
your queue.

Shawn

[1] https://lore.kernel.org/all/20261101030902.1387122-1-shengchao.guo@oss.qualcomm.com/
