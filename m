Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3F30F7EB
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784495930; cv=none; b=CpxmDEI3cAdtkA4YWAkd+mSz001RyitkH73jOtMNoLjqd5/ve4BrUGV2SzsRSf/rpf4wiCk/sE8ggzWwxRscyvsd76N2lmpS1L6M4eFiczqIUtzGLpo+AazhgigcdHADTiQ5INKuYpmfnDbrm3gLSYTqstvwGm1QFEl7yMeBKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784495930; c=relaxed/simple;
	bh=5XGjAEIPAFFHs8X4OPua/UqRJ496ky3R/V16qbOzb8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBKmHzFsrJsBRqgs/mvO2gNb5m8+nGZsLPER0Ftp0X2j8rGctQEf5NhtC4zY/mFJHwur92ipF0bPJq4nGxib2xTIwduZAWBWORSr3bnDeI5it4JCx49LWbKEXl6KXtvOvGlefWKdz5/9Y+tLcd0kgWpnHIPkfDe8BAQ+M94BuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMRWaoG7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L8pU2KQC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMRWaoG7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L8pU2KQC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKRFKF236911
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/rBC+CxZn4GlCYjW5P8YRIplF0bbqZaToAlF2Gujn0k=; b=HMRWaoG75gWYc4MS
	A4DJOPBUZ3i384SUWFyujWv8UEvjsauVj7NpqitS161qTz9VQSG9iXMe64aXfUI2
	YU9ZcLnJI3qABjhYd86dw3ZQlwXaCjQdz6XvRGZRNOW1x1id05wcyzDUYwuEP/MC
	YLJ3RpyA/ejb/MywQJWVN44iP/IwUzD3CaRiY2S24D50DipRbrIfaqGFbaJk0SzY
	l4FvpuQc+c7RNABKAAdgWnKFiwf1lZjzlkD8DQzIlwnaa5/stA/dM3SCJLPZ/7+e
	HBqyfgwnjHTyy6cf9vPvLOTV4uiZlROLWDgdkMHO6uJVhc+91sHgy3axTb6akGUR
	qoicOQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chker2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:18:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so3617693a91.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784495927; x=1785100727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/rBC+CxZn4GlCYjW5P8YRIplF0bbqZaToAlF2Gujn0k=;
        b=L8pU2KQCF/iWdAUTY42Z5hEzcOQmQ438sKmSGmnOFH3gCCphNogEv6R/s1fqekAuUA
         5anoxnVFm9iyZHtt2hKZb3fAG2wkkaKG2NJZrFa1XZ8JVyQVLyBlG41cPYb6TOer05Em
         SbHwVjGZ4HSiprHvKKNSGCX74xQOZyWapfOzCNQP76GQ1z0CvaNhxfMpaw3bS8MmCIZZ
         xkrpWx5xfQr8jtRADCesLvFmKsxL8MxYEVw0ueH4B+Rg3BUe9Bldx51J6SyaVYVj/vjO
         /wlkpS16rSY6SRbP9ilx24iIn3kIAFnX3R/mkzBxFBNSNhsoUKa2elSFBDgKHF8QhNXA
         n4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784495927; x=1785100727;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rBC+CxZn4GlCYjW5P8YRIplF0bbqZaToAlF2Gujn0k=;
        b=RAPDKzqGlRutCfKv+dXNgX5sxlX3mRB+2DjWsTlbRcLKRLEqJLiAKg5SD+pCfARwek
         1VzVRaL3PexgfGnkW2xo8aVxy5Q7poiAa7eUDI2GbhaQr+7K5GCu1WaAM6+cADDMGdvE
         PtYzQn063trNXV/IUW1SEuHzo1dqmDMCK+aH8EX4QDhVNHXEd+hIuCb16Lk7uXx2Btmv
         zSxZePgZYRRz/FGuSf2qfWmV5LTdinlSTTHLkRMV1XaP5aXtwh+FcAVhm5BHP/Dto7Hp
         cHuqwzULTvIqBym6IcbiyDvQjA7cm8MzWXkxlvUNW+rkmaQyThDu2fsCmaeaMlsa8dQi
         vDSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpjw3tZD9+rxeiy4QInLW+rUn3hd0FOp7x2xaTnEw9BM62/kI1stn9GKpzEab6FNepleE82mwlg+dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcIXsiVDZRf8rsrpmEREu7Cy+NQ+HBw+u0lsL5xQ3RD1qLeSK
	lhoKDvzZAYMoSXxwNglue5sbsboGuO/cHfHjkLk6VMwMANpQV53AWvhprq1D0LWBVMPERLuatso
	1q6MC/r1OgyuEYuP5DA0p3LNva2ICKkHODdSONaXH2wUeQi3RJPQfnHid47dYP58=
X-Gm-Gg: AfdE7cl8iG75j+8QlYqKY0M9Y8uk8Stqtrn2MdNxaYvSTAKInBR4h3zRqQQJLs4FEzy
	jlWy6PMhaEFkDOa6TAD+XEUFVev6aLQV0zrLSbU5smCimYpUWquXjcki0JQIgExEUIAx1yk7T6f
	mbp1mPnr97DG1o+ef2a2NDnCK5G8HuQr5sseM2gO3RaC9pqZHwcbKS4DQ8tOU9LLrXfzFWUKY15
	DibX9sa0gyMUpmUA746iNcmASiRprLgMaE5Y7fymcum4Nf4VpuiqabkA/8h/WyFYxJ8Rr/ldTnL
	Pj8gfsmbjbTfgJC0kvrtKb5wOi+SiADRdva+U5LZm2zdGHd/ndsXIQ8tvJEyx8J075+1VZWdr2B
	e13adsO4MIZErhRnx
X-Received: by 2002:a17:90b:3886:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-38e4b3d27c3mr12329712a91.4.1784495926863;
        Sun, 19 Jul 2026 14:18:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3886:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-38e4b3d27c3mr12329678a91.4.1784495926161;
        Sun, 19 Jul 2026 14:18:46 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39deab2dsm6553192a91.1.2026.07.19.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 14:18:45 -0700 (PDT)
Date: Sun, 19 Jul 2026 22:18:40 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Conor
 Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: ad5696: extend device
 support
Message-ID: <20260719221840.625525a3@jic23-huawei>
In-Reply-To: <20260719-ad5686-extend-dev-support-v1-1-841ec75cf5d8@analog.com>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
	<20260719-ad5686-extend-dev-support-v1-1-841ec75cf5d8@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDIzOCBTYWx0ZWRfX14VazuMDjulN
 5v6DNhDBN6MVl3po8I39RQW/tQH9FImDQq1Os88NSBjgVRThDXlVjq07pZUL+e5Q1I8Y741jKU4
 MBl+u/9dI0B4YRv2t262VdS+LbkuR64=
X-Proofpoint-GUID: bdakFwZabxgB7rkiqPGXeM2n1Gf8XzWP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDIzOCBTYWx0ZWRfX24ZFiJbbxjGt
 WFge2EXdy1nrNswLPFl05xJkC+B1HGCxhcGuMIi/9a1zzaiUpEmXpSNwDEw2bDQbkfDP89KpYD+
 kHv8XAX+G6mrAdDGXIMjJT59t0PBzWviFZ2hBdAxtiQE3LrI9d/9kmEkihwQa0qTfCgi7K42Blx
 O2h/kgb51q5yb8LSHYcHthWZ230TM9GzRLYLQl067t4d9U/ah7SqyvNRDLfCy4ODml6Y9DORSU8
 23aSB38zujKIlVdObNmAz8BjkAuIIdGMdfXGYL06JpkbiL7LVlw8b1SwowObRMnWmTMgfvLeVAY
 XjXW8ia4CPHI5xd0xLGQ7rLuDfsekpAdmEyyiwt39sbGmykqpGVPs5dhsC0WcNLGwe3PLwmzRk5
 G/SOZVfkR++u7tqQ6M3HEsIehMFntKMPaREqFjL+f87xeS1gD2Zax4+6nEGchIJ1E6cGxn2XdAi
 KdiLvQLRozDp8QG0m4g==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5d3f37 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=HLCVoeTYkPwaNVPRpFcA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: bdakFwZabxgB7rkiqPGXeM2n1Gf8XzWP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190238

On Sun, 19 Jul 2026 10:51:57 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Support for AD5316R, AD5673R, AD5675, AD5677R and AD5697R missing from the

I'd drop the 'missing' given I think until this series they weren't used.

If nothing else comes up I'll just make that change whilst applying.


> device-tree bindings documentation. These devices have different bit
> resolutions or different number of channels so no fallback compatibles
> are used.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> index e10f8596f9d3..835fa21c474e 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> @@ -16,10 +16,14 @@ properties:
>    compatible:
>      enum:
>        - adi,ad5311r
> +      - adi,ad5316r
>        - adi,ad5337r
>        - adi,ad5338r
>        - adi,ad5671r
> +      - adi,ad5673r
> +      - adi,ad5675
>        - adi,ad5675r
> +      - adi,ad5677r
>        - adi,ad5691r
>        - adi,ad5692r
>        - adi,ad5693
> @@ -29,6 +33,7 @@ properties:
>        - adi,ad5695r
>        - adi,ad5696
>        - adi,ad5696r
> +      - adi,ad5697r
>  
>    reg:
>      maxItems: 1
> @@ -84,6 +89,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - adi,ad5675
>                - adi,ad5693
>                - adi,ad5694
>                - adi,ad5696
> 

