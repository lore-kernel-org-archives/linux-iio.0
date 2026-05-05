Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41260309DCF
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978333; cv=none; b=pV6sEBY200IhMsHoKOsGUSe3LSAbM4UuED8CMolm/yUvbOnvs5HCWXzYcKNBN5MGPPVVNF3A2G/L5AXQ6Mk6DsxNBdmUKnc2XFpPN06lu8o4ywpaqCbogRqz55wvClVOPIibeI2nJXYb/Vv/jOjvUTeVelPTSBRK5CChe1h6tyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978333; c=relaxed/simple;
	bh=Nq5YWk7d47rn+zfpjBtf1BNx9BMbQdwuFRUGjR1TJZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaJBwfroUYs3zTaYy0NQcYcQxr9Iy3n36rlkwMapHwZXE5xMdPyPF9RQgjQtCuznQtkZobO8EbTrv0F7PDq09c1H8HDpX6ODdaL2zMMt8BmgxWQX7J3pJ5/duw6tK6hjN9XW2V7iaLeRmEK3p43gkpq32gw2G1cx89AXL86HI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kb3tMJMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UWcf6qes; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kb3tMJMY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWcf6qes"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456m2XH3187946
	for <linux-iio@vger.kernel.org>; Tue, 5 May 2026 10:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/tmh+pUwXuGBbClqdrxdMQ7+AXBXWGqM6LLLy/RqYmA=; b=Kb3tMJMY2+qf9H/a
	54whaIxR1c7ntHuoAWb/4A+JxEVz2FL6RNr/HO6tNEWRmapVFTTNxk5nY+UZ1xDP
	XVG91Hx8uqV7rpkmd1nKpQuOhFirErgpqK+CPf8aPiWAotFJVSNH/xZdHGciYiPG
	o7T+qodme6zI1CFFh6LfYOyi3sTkZ4JQJ0EdwfYvTh210qwoHI+acEAqauzf6Akd
	JFxvDAS8Tvl+Q75XW1mjhLgwzhv3VKTkUzYl64MIfChJUUKPbOzD7Rb8uZY3nMVG
	0CO2NYMbCC1yGl3jYeN1WySA6URInBR+q4bC0AY18hlMmahn8NSbDJPPRu2y0R8k
	WW4+Kw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk8x7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:52:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b5ceedb5c1so82483616d6.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777978330; x=1778583130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/tmh+pUwXuGBbClqdrxdMQ7+AXBXWGqM6LLLy/RqYmA=;
        b=UWcf6qesRwXU6WeoMChYMwOQzdiF/RK2k3KUp9Jc3SEPC1fCHfzw7tPOnvS6tySa5t
         eekuFYRGzQrI3XitGjvuzEpSF919ik0sSomhpIcccDS01dDx6OFI6z9U7CFBbcSOPLLL
         snE9qKTeFQTidNwaQ97wtJAvMer/608ciVbEXTXMoSnyKMK2w+wTMJIptVn8ifi/30pP
         Z1HHCIxYwLC7I3QLYoPB+Gzcfmsjbm6jbrx5+HtXy4tI1mgA3Krtmq0gieZNGWnJaihN
         PHXpmuKHPUDpEu9SboA/8Dzhj6grh174QE/+veGdO4jZDyUUIidFPTwFgwVqLXIffoYL
         26lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777978330; x=1778583130;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tmh+pUwXuGBbClqdrxdMQ7+AXBXWGqM6LLLy/RqYmA=;
        b=pyP3BA4UToH5QGcJfPia6VEyhilp/4yus0DvnaALsHti2LRfBPcxfxxQhDwUv/L4Iy
         z3f18Ynoh/xpkhKVpKqfFCp87XQoae9rnDAh5FdgkNLUBOGa8fVcUeXTc9xu2SpYtGbh
         nEZIFAXdeNZ+NhLj+5RAXOkNexMm0m6o3yyQQe8RtBHNbr7jRdA+DSNBjgGqZMT75k3w
         RtfdGPYvL1Q9NP36YLDKJiWdB95bwGVEdaaMEFzFxpRDwrgXx51Jc+nWQ5thcWk/0Dxc
         wG+fRr98saJIEUbRFfkIrM8sU4B5fNLZ0CV4cNb70i3/lsU5UHEr6s20HHEbb5sqrnJQ
         1TIA==
X-Forwarded-Encrypted: i=1; AFNElJ8c+1VZtvq2BOenrRjZ2pmMgKgcxFY7Xs64+NHPrEykmNCUlXEU+ul1vK0f92aF3PGR4UuTFeBJJV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZJpYUfyBQoeKTatWxG+cz8AQSGeVQTdhouHyIt2BqRqTqnPi
	RPPrWDcFaFhBwfX+3Y+CHg8WfXqlF+GQrA8ZhlKlOT+brQcWBIWAT+cQ1K4u8J0kXd5/fdCDiUr
	yUsQ5fADFm7YpWG2rPpTPX0KlaoR+aMhY0Yo//xS1zI+7ev82kUmtAhhSRC5ne7U=
X-Gm-Gg: AeBDievQxs9bBwXjJNyeHcyjdlflYRLQS+55CrHVz1hznEuxALjva0Hst3UmBl7kCm4
	UstacOAJFls3MsKM3pgbf2c1GY1LmXSORxsoyBsNdQXdrX4vJTtpI24mNDSPxvsb4u1oSouLdoV
	AJJnmrS0MEiG5ypiPVQy3uPyRyK3ZQQaNksvSCMaUfXFiWp9huchbM497+KpzxiaHaBv2HCvmvT
	wUDftgB6GDOIyYAyKlGAHz5Ts3dDfKIDMzA4vi552c6lZYWz7BuDs4x0R4z3My7My445CsFhTWx
	cELFouguI9RDGHSacdMmOK4nNZZ+o7T9LKavej06BX5Wia0oF98JEtv/LZ7JJ7ctMdnm2Ow2Atr
	9H42gGCN64AkoDMjVgNOMevOYE4eLXNhOyacXu9hamwhkIrLKsIbZQRIlSb4=
X-Received: by 2002:ac8:7dc3:0:b0:50e:fcbc:6b6d with SMTP id d75a77b69052e-5104be20b15mr210746261cf.19.1777978330160;
        Tue, 05 May 2026 03:52:10 -0700 (PDT)
X-Received: by 2002:ac8:7dc3:0:b0:50e:fcbc:6b6d with SMTP id d75a77b69052e-5104be20b15mr210729651cf.19.1777978296274;
        Tue, 05 May 2026 03:51:36 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm3613237f8f.0.2026.05.05.03.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:51:35 -0700 (PDT)
Message-ID: <40448286-826f-4141-9c8e-355aef74c2ca@oss.qualcomm.com>
Date: Tue, 5 May 2026 12:51:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Move MODULE_DEVICE_TABLE next to the table itself
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260505102903.187598-2-krzysztof.kozlowski@oss.qualcomm.com>
 <20260505114910.0488657f@jic23-huawei>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260505114910.0488657f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEwMiBTYWx0ZWRfX4qCKZu7Wbt2r
 GyzG6cDr/xszmolPt8V/QygzWNBIiagff308G2gUBhlYSRsaCEi5B8UqaAWTBboEBNcIBRnQLdb
 RYG3LPq+f6JmgrPFFmob+9VSpbZaFLd7A1z+NX6Oq5hDAC9HC6E0sgEOam7EO2KdmMOAmIKnRq/
 q+lhHYTon4LYpYornv0yvFXMdh7rFSoKyVUgcBu/9GlVp3Xgf0ebDUWwk2wsQmwKhSSAfOCpk1Z
 gAvNAbysnT5IMNWXOnd6e29GBfEqHHeMUX1wSoOztjaXIdcClibvOwi2dgAYi3ckPriarT/Q+Wl
 DJd59lDJY0GNHAEirM1UJPW9xIYCkt9QJsZ1yfAUVwvge9zG1/UozsaczzvIvGxhPKOsYR20oUY
 q7cLWBygzKqyF8jokNMpIKsavyBShGKwGXaHVuTREm22IctueiptD2028GMvRh59U7tC7JDLt9Y
 Gjn+m/4ZApBTMWyADxQ==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f9cbdb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qYkSto1fBwsbqW0a8ygA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: UsnoORdxSjClAS51hW1FEOSGmYenUSLy
X-Proofpoint-ORIG-GUID: UsnoORdxSjClAS51hW1FEOSGmYenUSLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050102

On 05/05/2026 12:49, Jonathan Cameron wrote:
> On Tue,  5 May 2026 12:29:04 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
>> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
>> exports, because this is easier to read and verify.  It also makes more
>> sense since #ifdef for ACPI or OF could hide both of them.
>>
>> Most of the privers already have this correctly placed, so adjust
> drivers
>> the missing ones.  No functional impact.

Oh, damn, I just sent 20 other patches like that with the typo. I did
spellcheck but earlier patch and then changed this and...

Best regards,
Krzysztof
