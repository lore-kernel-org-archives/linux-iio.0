Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751650;
	b=h+uGJ1K6R4nw6W2ok0WIyQ42WDfe13dD/WyA5Ce4gq9MU3zTe43UvYIt43oCpQY4oCi+
	 jXmFDR/5S1n2fOp2ZoimA0z38EGRLO1Q55Wz39tLyneGzYxhnOIQrbSsXFBqLfoj4fY3U
	 Km8TAfM2rLIjVid92URMf2gO+GldS8HR7z5PMI6FcA+RVWUGJ2YGjvbHOX55FPp2AIRET
	 joiz6f9uTaTR1HCuRtkGASG2CUjREtJ5VWTkzzccV3c1XLt+Y6RDLpcbWyW+XeYo7fJuY
	 zv08Npedc2xEGo9LbV7BjXNI4fyRnI4LDnhnCl4SZGi1W3UQDE+KGwBzZ51/xSbD53A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751650;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=;
	b=Eg8R1KXumON+1/pBL7zcFuFW94+Ml5Dy6j/G1pmGzY/sAk8Uzfne9l6o8PZFga0vGLqD
	 CH/vEjjRSTPAkUuEc82HOsdFQ1CmikVtubocnY/Zj+8L6XFofp1ovLWrK7NbicpU2QoJc
	 NzJlRkt3QFc0h8EDbbKkYqiw0NjGSBNPymQ4ZRW//j3q1O9ZoqF4imqoMYMJ3Fq3JgJ58
	 7h99R1O5hSxAITJ884ch8Hf3NDtzTdJyOgdi+df7yMdIj8EqlGzg8jupMTEwEbYQwqeqO
	 04G8lpRXz5iODrK3VMVpqgNVtuzob5Xt0aF5ih3rTFh86x+PrlmKREcIalANwfsXaAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9aA2zlY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Y7G/sx/h";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5164606A326
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 00:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5164606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9aA2zlY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y7G/sx/h
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LKpEl415192
	for <linux-iio@vger.kernel.org>; Wed, 4 Nov 2026 00:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=; b=O9aA2zlY2c8+9sxr
	hXQL4F6wd2IkKQ+VwK7lMQzQ46GiOvIpxp91H2p0JDnpQL8YFnWTpiDbyrffdXu7
	ypY463gCS0OkSDzuxQzxK/Fbbir96u+n7p0fYBJeRuc9C875OBzhe9jDYuN2NPjL
	kvpKI4W6w90/l1N8jpg98FvxduvmBFocU8BHFyTU0S89lQLzNwifnlKqgytRaF6h
	mIYsWzV32M5cjjVSu7FDv46pqfrwr8BKkbkjOeqD7M8Vvy2X4rdwzkuJrz6tPmTT
	+4mKx6bfXbBsk9xVem0omadSRCKRthgz4+7mXvn7GJecdizYtWODemcR+ODHZpA3
	ou5kgw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqkgp9qgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 00:20:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso169634a91.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793751648; x=1794356448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=;
        b=Y7G/sx/hkyqa7plfa6wvCEbOgFJjXACTY/Q9dWAqr4XFbRQqx4RKWhNoHxtlKW6u0o
         ICRvbwMs6+XRgTMt8A8Ix5IPX5DKYBkDRLlhJO7d2/gKO2yMnRlcXLS7fDjIto9osA93
         eDhOgPR3fVpF3/J1yTwph/607e2A1Q5Gfh/1dVJSBMKm5OCMLc+zowF66ekVuXcvk3jr
         ARYpzIFR1okZb7AF8AEfazXOtF1S24DUhbO3s9jlyliLGtj0MlPObTgwzeJfByU0ye+P
         XQ6iNYOfXQCMNLnXlT34cIKG0dO+OUM+DbWUDDwpjx5LKpzLojgNYDoXT1ysnRkKtmI2
         rKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751648; x=1794356448;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfnNX61NtQ31WOejDUqbkK4HwJYzLMGKN6Wyl9m2oIs=;
        b=lPO7FNjcHqRTb3hHdv34SnZkiSO4bHJERwjUVy0/ai68awjrCoJpg5H3KLk81h3HZS
         oJi2g8awtdIB6XYjUHHlO3ihb0aJKcfA58t2g1cJIBdrCeQpWM4dzG9IrS3fO1c3oyEN
         0GyuVjw5LDEZiTjCWPI4dPFJwqKg2awPSQ5YHMjDc8BSGIrZsyFUl4SQCMkcJhENp8D2
         NkV21g12su0fpzDQAniG9c80ZG3vUM4KnzEX+/641xPs5c7PQkSkakCkWFdffScTdWmj
         Cbmu56ivR0llAxS3y9jrxA39YAZQss4/NniewdEKrePEc1yd77/l1AH0Q5leTowiAf9j
         WHWA==
X-Forwarded-Encrypted: i=1; AKwUvBweAf3cvh7GM3jRYO2/laJ7fx55ozTxX0ybsBmt3zw2GY7IePEnoId7RByHzryK7gRYHy77eybqEGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nCq5VFO434HUpLwBsI7NffW7y0aPTGNRQCxI4SAWx4QWlPpOq
	aXxyeo4Oj4yjxMxDtpLDxHQ9lqTeLPFhSMdC/nSxgAdsjyZQTaCyJ3ZY4HNsaIJVIbNI1PzVgzR
	MigwIlKDHgUdcwu+XBOFFcYXrgt/5iT1oebX1JeOIn/oAP4SmhbgJyumIGOGFMDs=
X-Gm-Gg: AYBFou12aPyQ9ksBKCXCMYRYqlnKvx5aFLjOmkS4kVf98Be0nKSJeo/HN7GMglFB5GA
	a5iFuKexQFlfYnVmD1th8HgS4stcl6dBHS6yt9qFMspcb5ErxdIY/RjghFlZkrrtKuvbb6dH4MW
	1Gj0h1yW+Gr9M2NKFE/ivFM+gHKo5Xn9JaAUXbHMC1dtmNA1bDAIJDrr4v/M7oFFGBBl7BacSEf
	bIZEP4QHYawWEnev6sCLgM3e/wrExgbdghylpsIFruESNE4Ys2jPqKHfjYeCCU+zw7MQo03CWGV
	3FL2rFZmofZcosPlyiKnRY4XB1FAdIGOdv5XGHhqnrmXSHXTwEXk9dhEzfPMeOupw1dLoUjN6ju
	khnETCJygBMqI76P7yGHn+S//F+ivGePO5YjP3Y1rHq906esaAt1uvTbXTrnIgVMACw==
X-Received: by 2002:a17:90b:4c12:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3ae8986e3bamr13180549a91.62.1793751647537;
        Tue, 03 Nov 2026 16:20:47 -0800 (PST)
X-Received: by 2002:a17:90b:4c12:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3ae8986e3bamr13180527a91.62.1793751647042;
        Tue, 03 Nov 2026 16:20:47 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094453532sm1090412a91.3.2026.11.03.16.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:20:46 -0800 (PST)
Date: Wed, 4 Nov 2026 00:20:42 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Olivier Moysan
 <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
 <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 01/10] iio: frequency: ad9910: powerdown fix
Message-ID: <20261104002042.10064e8b@jic23-hlaptop>
In-Reply-To: <20261103-ad9910-backend-support-v3-1-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
	<20261103-ad9910-backend-support-v3-1-0e9224ddf7b7@analog.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwMCBTYWx0ZWRfX7Q8B3uFPKJFV
 sLHVSfp1Hu/YwVSkvDs632Cez9C2PkGNvAcQDtnQxV89CPRKrx+PaJ/h129RW3n3pSBv+xU0rbD
 6rW1N5qA5s7u2nSJqXKFXlDfXD1Cxc2koSn7v8sr9FRRYoeJ//3mgltzycfDIP1q9g0GwLZBKJV
 uiVexIRef734VBg1h30fFs0DUbhlkZqUwvs84jrzm77iyP/qBKW1urFFIPjU/SB2Ez89BGPL7A0
 m/xrhpt4JH4a+iPrR16Jn5LizCGGKJTopkN2R9chZWZSZbJLR9YcDwwHtcTzviLX9hY0KzjBjvm
 IRphtjTYB2lT9f9pJtFGNrqkQ9Xz2ZBtVcxHT+z4dh0v2+3ckst4ghQPldzkP3InyDLG3B8/88m
 vAV34nQIvfeePPam41zRjGRryZHV5+t7eAgtgy8Ck05VY7rOro8gWMQK2b5bm9NBqKv7JjjXZDX
 dqP8Ma/EOFKw79IBJ2w==
X-Proofpoint-GUID: edLVlbpPHi1nWFBAsrbDA4YQgmz17ahS
X-Authority-Analysis: v=2.4 cv=Yoya1IYX c=1 sm=1 tr=0 ts=6aea7a60 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=Pob1JPmMRzAnXopCxDUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwMCBTYWx0ZWRfX5xcQAGx6T8B2
 tBSbB5oeKdaz1bxe2g3CO/Y66UfPyhOiGrfBBirp/59Lnle7bBv6Q2w7DJip8QrLBWphpuHjpwX
 HOha2NYjoY0+AJH9lxpXpsQ9i5WOTd4=
X-Proofpoint-ORIG-GUID: edLVlbpPHi1nWFBAsrbDA4YQgmz17ahS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040000

On Tue, 03 Nov 2026 11:52:57 -0300
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Enable the software powerdown on all the applicable CFR1 register bits at
> once with an IO update.
>=20
> It turns out that DIGITAL and REFCLK_INPUT powerdown do need an IO update
> when enabling the powerdown, but that is not the case when powering it up
> again. It is an asymmetric behavior, which was observed while profiling
> power consumption in the lab.

Just to be absolutely sure I understand this right... The bug today
wastes power but otherwise doesn't break using the device?

I'm just trying to judge urgency of applying this. Is it fine
to go with the changes that follow later in the series or do
I need to rush it in, potentially delaying the rest.

Thanks

Jonathan

>=20
> Fixes: 22452fe6cd08 ("iio: frequency: ad9910: initial driver implementati=
on")
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/frequency/ad9910.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad991=
0.c
> index 04a4e184b873..8bc24d0b7442 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c
> @@ -621,26 +621,16 @@ static int ad9910_sw_powerdown_set(struct ad9910_st=
ate *st, bool enable)
>  	if (ad9910_sw_powerdown_get(st) =3D=3D enable)
>  		return 0;
> =20
> -	/*
> -	 * When powering down, the DAC and AUX_DAC (SW1) must be powered down
> -	 * first, as they require an I/O update to take effect. The opposite is
> -	 * true when powering up, the DAC and AUX_DAC must be powered up last,
> -	 * i.e., after the DIGITAL and REFCLK_INPUT (SW0) power up.
> -	 */
> -	if (enable) {
> -		ret =3D ad9910_reg32_update(st, AD9910_REG_CFR1,
> -					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> -					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> -					  true);
> -		if (ret)
> -			return ret;
> -
> +	if (enable)
>  		return ad9910_reg32_update(st, AD9910_REG_CFR1,
> -					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> -					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> -					   false);
> -	}
> +					   AD9910_CFR1_SW_POWER_DOWN_MSK,
> +					   AD9910_CFR1_SW_POWER_DOWN_MSK,
> +					   true);
> =20
> +	/*
> +	 * When powering up, the DIGITAL and REFCLK_INPUT (SW0) must be powered
> +	 * up first, as they do not require an I/O update to take effect.
> +	 */
>  	ret =3D ad9910_reg32_update(st, AD9910_REG_CFR1,
>  				  AD9910_CFR1_SW0_POWER_DOWN_MSK, 0, false);
>  	if (ret)
>=20

