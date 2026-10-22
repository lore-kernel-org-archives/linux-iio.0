Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676791;
	b=b5rM/bFr1DjDrGgmyUolDvb2zVX0RmwHvLB5Fxv2ChDGW+sF5WI535eU+8SxK9sr8NaK
	 uzBQfihIS+oD01CAM29RNxc+VXbTn/9NQrPwrkgrjgTs3BGDLXQ3kemLMeHDtnPA1oqUd
	 fDUSGCUMrGtBhCsQMjhieMuXfHVEs/43IsdjGw3PDF6Rnzd36nFexyUx8nXLGnoxHrcyl
	 1rES+nl3ZcV3f2a4FBsg5ILPmIHn4h1qgdqV2l+D3twjzzxMzXmVDeCWj58Xh5HDQX7Vu
	 8FL2EnubqIGCVV7MF75qEd0Yo8jcIhGNPbKTKgSIv70dxH/0B8L8lHnfuslWJ+osfFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676791;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=u3Gda1su23Ey/hn0j+qLFhPL93ioEvm9bzh55nNkACg=;
	b=rVjwzdw1cC65RRbGzin14+dTiO6paLKPQ4o978IncrJCkCriGfP+rpWAx9IsmZpd5McG
	 VkL4ZfnlzvMJep2cfskOgZYD5EvYg3YhSBO/FSKOHIHMITYsWgOFTvBrQYo9Wvr0iUoD9
	 8zvdhEUm1jvPa3xcXgWcNJ4PzsEwjTbNWOdstP6tzXr/jFpWIxKNi3is6uSAotsI/bUBk
	 +v++M7XKQhfMoe6BX62NOF5eS0dgM7gZQVQZGzuh3GXThbAD+7TmCVtHf/L99vyAZwZ5U
	 1p/lOGc6j2CdNZK36ZNmZ9F6sKHm2bwYwIRxCKES8pWsDalyA+Ce8KZoUyuCBQYyMpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TnHyVIPb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QlIU8GpW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D4606AF44
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 13:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE2D4606AF44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TnHyVIPb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QlIU8GpW
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xmS1317711
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 13:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u3Gda1su23Ey/hn0j+qLFhPL93ioEvm9bzh55nNkACg=; b=TnHyVIPbHvd9bZx9
	pBvv263KXsQOS18ga59I/Jz5ZtK3f5TMDysjv3rvSWUl+HE6SsMciXn1Nv+sFP3V
	7D2eHHujZhMNyt2ymsESg5STQO7tSsTFWGgN64quCzc5uYDQ93kJczMFRppyReth
	Wa6Hcb1EqoSoosP31bU9p/SyQM4S7d8vz1y6FOyHPDmE8cvJyYZfbH1lsJzvA5aR
	ei83ABHUOK0qKVyerIVaZ7hP+Zs/ccB2eW/pGsuZAoja6q7iEIJ7eqjqjqpyicet
	Qfln1gaAoSb6+EdWUTNmMgfQ9bLKgFfnkVOcYmjV9lOpAV7bNpnJmrGBcVrJwG/E
	hohGxw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93akw3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 13:46:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cac495d99so34363085a.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792676789; x=1793281589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3Gda1su23Ey/hn0j+qLFhPL93ioEvm9bzh55nNkACg=;
        b=QlIU8GpWYU7VsTIhBIZLgldpB20lZjm3hmu81j1hvA/N0L26HADj077t/y0hKVQc6w
         t8j9sBR4sP19Z3Uv3QwJ7nFEtHZ5Sb+8mZKy5pGNtffBNoTw3hoCTES5zgczvLeXam5c
         bO0Kn51ZFD715Qh7/XbVO1XAMZa5/a4rinpTmtqRLW96+iiNw+51T4dKgDduVgrHPMFt
         1TvntNThYW5Bh7wDGfkRhCt8+piDca8s8fCMUDkYsd1GKr6BYvkIK7SZ1sIrPSDCOFqE
         SIkPBfGd6mOYN2fjs7owQFmpjZn3j6bbzbO5fFKJadJdgcUjG+KgUjKbVqdJ4+Fdxh70
         Ltbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676789; x=1793281589;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3Gda1su23Ey/hn0j+qLFhPL93ioEvm9bzh55nNkACg=;
        b=NZ4xEoytqXf7HXgEefjhRDBoJqbgabuGFYLE7WSwiAtfbmUQzRneMyR1ykXaDz+Fgv
         Mg7ZR7Xxxr1ao+n9rBDtwJNuQnD7ozga8ZOzr61gqqoLSIJYcct1kj75DoSGepqVqacr
         aXT7GwEoLzGrRXk2I66t0PYTknz9aMxSqbk6AzRxmB/GQ9zikxyKvH2Nwe3eVasw6jFe
         hiuVxJK1rBFm7YqFn3Q/nPHjca1mJhY7kpGX5aRI7HhHU1ChUHg+BhnSzd4szrQZ+sXV
         YtbR6nD3ORzBDCiXA9qYjg7t/VzNd5n4xFHeiagWVvDyzWUIgJXT9zBuQ4mHqZgmcYdW
         rpeg==
X-Gm-Message-State: AFq9FYKn9bXFmr954JugfMW6et7Kq8Q5fl2IIfdfpOm1yev+eyAleMj5
	OxkRMSTrieK3fo63ryabDj3yCqk4x9yzjVk+G+FFVtREz9UQg7AkpnDAxcYLIbsV6b2p3WM+uPC
	zhw16IkQ0cQZzwOlhPlHC1uudJwTE0q+45XHE2FXIOjSGkJysy4SsSXgS7MZI+5A=
X-Gm-Gg: AYBFou2RwCAv4ETPH0H/yGghOAs1osPy9spj2mqEsoj2z0tWtDgW6RKNWO8najeZBk1
	FxFUnM2Ofevmnc0cf7tam0WRQH8OiT3JlZklJhUUpT0WFJf8QIoCcrO0vuPYCYXptHPn3knXLWH
	mTwnM1//VwF3qEBBDSNdYqQG7kBzqCycUIQsFpGaBn3TMEGn/I88ejrI3ZWUTEDsJUQZ9vRDATB
	gnvZjAI3bXafa/R2pM4V7YAH6SuVEQ2HXrwz9oEgXXyq6CZEu9+gBJR/U/jhwEMipCDjv+erdwq
	9Qx0p5Sm6ATtmLH2kIXhVNxlxBzQERWtKg6+rjUhuGZhsRH23WzaRHJtVdfTKSx1a0mxj4tiFQy
	6isyO5ETSpczmkYx9EgefTw==
X-Received: by 2002:a05:620a:2852:b0:93a:1312:ff19 with SMTP id af79cd13be357-93f57fd982amr1113275485a.5.1792676788796;
        Thu, 22 Oct 2026 06:46:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2852:b0:93a:1312:ff19 with SMTP id af79cd13be357-93f57fd982amr1113270585a.5.1792676788371;
        Thu, 22 Oct 2026 06:46:28 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a56082csm106605366b.40.2026.10.22.06.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 06:46:27 -0700 (PDT)
Message-ID: <a7114c6a-2ce4-4e16-8911-d5459d4bb362@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:46:19 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add proximity
 sensor
To: "chr[]" <chris@rudorff.com>, Linus Walleij <linusw@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
 <20261016-iio-light-gp2ap002-v1-3-7c93312fa8d5@rudorff.com>
 <5531e454-0d84-48f2-af0d-1ab34c149760@oss.qualcomm.com>
 <2b091dc3-9588-4042-8908-2fc3adba6cf5@rudorff.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2b091dc3-9588-4042-8908-2fc3adba6cf5@rudorff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1NCBTYWx0ZWRfX6ERA+c8gmqUq
 REimsQne4WPpdaYNYuN0i0aWvRQkWwsnQWLcqzxF92hGc8bNcSlAA0NRtmA5YfQCo7d3uwczqHU
 c5Rgy249cg3ieuX+cauB7/Dfr+OZ1tQavG7JGJtYZVwCy7uGcOIkaCJDjoXYzWVpCf6JZuTaQcY
 lpeZo4vnGwxPmWMgmMARkr+jMd/tfSCbdHhGOEN5xtsU9nwavC7Fc5gdHZRQCohdIbF4jfQbS7R
 6eAYouWrHUNirjbzgoROIIhBh1iJ7tbIaJFX5hHr+YR3SOQWLxPyqOpj4RnQlwPTOpvUnaPs+MX
 nUX6mDBXQHDB1Q9Y6+pKFARQ7LbQtWkcO/Npvsulo/AHGLzpI3SrghnNg19JzziItXj7LONkQZB
 ag/3Dldeo8td6BkWKCG0rAptKWG5zNrwnGvQVpwjstNng1MEE9bgYr6WqrOIYgXqWRWRrh7nigJ
 H02gIv5SnxyF6hGNh8A==
X-Authority-Analysis: v=2.4 cv=H7FOUOYi c=1 sm=1 tr=0 ts=6ada13b5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=qfT2Yf8mAAAA:8 a=WbbDG5xgrYMa7k-JMu8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=nKa2voRIl820JbUdVH2x:22
X-Proofpoint-ORIG-GUID: h64ARyg1zYAb8l3U_xN6zQc2-gmZOYwa
X-Proofpoint-GUID: h64ARyg1zYAb8l3U_xN6zQc2-gmZOYwa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1NCBTYWx0ZWRfX9bedJs2fKy0W
 TnbxMiiqSiRilWGGe982VrGmUXUMaP/hkXPHg6Lkptu9Z4YDPtR7WAdrculMCtXoLinYQaDZIJS
 12iQM0eke1BGGuVF3C0+Sr1Laqt0Z5I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220054

On 10/22/26 3:35 PM, chr[] wrote:
> Am 16.10.26 um 17:11 schrieb Konrad Dybcio:
>> On 10/16/26 4:43 PM, Christoph Rudorff wrote:
>>> J5 got a gp2ap002 sensor, add it and it's supplies to the device tree
>>>
>>> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
>>> ---
>>>   .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 19 ++++++++++
>>>   arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 40 ++++++++++++++++++++++
>>
>> It's odd for the regulator and pin setting to be common, but the
>> sensor to only be there for one of these devices
>>
>> Konrad
> 
> Hi Konrad,
> 
> in patchv3 I removed the settings from common
> and renamed some labels.
> 
> Is that ok?

I guess we'll see when you send it?

Konrad
