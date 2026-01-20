Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54933ECBCD
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907211; cv=none; b=PsYQVVZCcH95u93DmK8M6CTh+o4dztw//DuooLgy11KCU9DXDtHSfPFxKddx0s4JBk4EX6/fXHJ0aiNrlHndHPzwyBfNh1ExlYl13Q53vCgSFmCn3dIkQxTKxH1clC1E0PTaXeyeDLV54lOSEdSbDgsUQ/yFEBTEZWHhAXKdKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907211; c=relaxed/simple;
	bh=qd4+Th94V2aKdqVjG6D5LnNUS6XetozG8x9QcYx7qOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq5LL2XzxG5FyNuCuBKFOskfjGuZmGdH1lecKSGO0xnl1BGrPYgtYuPTjputIc5lpZBcYhPweQKCrIdk6aD3tV9Ls/vsDcbGTc8EeG753WBvvdQav8yk/qtdjViHDHJabNM6q8iS5YrA/fAFtwxNDUem3gWpva6nwehB7lJZMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M6vLZdgF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KV1ZJTh7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M6vLZdgF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KV1ZJTh7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K9Uuuu3177315
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 11:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4NSu8zTti4kQhYydByRV1dDUaviriPhETn1j+QujkUA=; b=M6vLZdgFwAqcFoBD
	hlcaT4gy7N8WBMC7wQxJUr95n6MqcjQCuPqZ89Vi9SzOpKxg1J+N6ti3WqW/ndXo
	KoUHjztUOzLH7LNxuNTsCgAs0JjBqtuuaHSZVOOmDn9NHXiDx76RfabXaQYMWH/J
	vbejeRw0pSf4hOWZdXiSrK0T54uatpLoJkJ3krK3bRUD7kGRZTp1IpsTiIVWJ1oF
	ljlYqoVfipBhwdeaGh30PIlVfpe2fn97xEHRuXDw1Mvha4sfEeXpxKWacbHa382f
	FxdZj7pLwMae/mofy1r2AfswstNeDOHYFe8uLxf1G6sjw8a49/6JgM5wgME0T2C6
	5IVrCg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt0p2hg7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 11:06:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c536c9d2f7so195149485a.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768907208; x=1769512008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NSu8zTti4kQhYydByRV1dDUaviriPhETn1j+QujkUA=;
        b=KV1ZJTh78EuHoWG4X+V6iyvX69DvUh5deHBmNXiC9+f7K3G+Khb3Zer40bPp/2zV1X
         RPu4X09tcxJTsNW6wMZUz287B6UDbxDkffkkBTsX+J8LGXaj344dRgzrvjtK3kq3NHvm
         uod84wge5DJqRbuVlfjeHDr3OgXlmNJ/GgZLFLoUL8Y4TGPzJ3ECo71BkLj3Z7UYpNHE
         aRvqeAmMRiogANjgaf7x9F69DQYADfAzq+gekNz7Kn+wfxFT4a9ekZbDIZ3KQoi36Xks
         zgOKSoThpq4AktJ5fTuwUclZKEWTlnnwRJEDG0v4IUCw3I7SXyMYX0Z8l63JjyxphtYn
         O66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907208; x=1769512008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NSu8zTti4kQhYydByRV1dDUaviriPhETn1j+QujkUA=;
        b=XM6T4LUu2jgUlzARsTuEbh5oyaSu8fYqnXidKNjH1/zd0IYNqmHsGiQyiKtd08cqJ5
         fJABDLWxmOfKrXctCM2mVcJhODx7CT4zWIQ45eKUUx4X8w3+nHT2Sg+YOYZtRK2RL+r3
         CTLHCaF/qPNjIh/WJewQlZKIcysp3acd5KZ2qO9ZKTsRujqx6q0AEJrVeyfoJ4alfMsp
         ohXK8PY0E7EZMuV23fQQuDFQtOliyZnxImiQp72PKn7tmKJ8Lq9Vpnq8ISG4YawrN4HI
         qvPTZQJK6H4xfBTSLWmfN317fKSpjdmSUPAG3uK+A3T9P9vyzq+6prGqw4TOtJwT6bup
         U0lQ==
X-Gm-Message-State: AOJu0YyE0b4rxpCoe5OnC3s70U9+t8pn5DuQe+828R3cdvMoQ6DPzYT1
	TTXrPu2EGOF44uRaU5LwcXUwBDGipJVUOaBxIIxbZrKvuNUFkVt9OgfxgQBlHhuQaomfqVdKLga
	Zz1X1XXoPTNAodARSB4EZ4/q0o2fMceHstQCMy4Yqww+KStiLZIiXgBC2NEaacDQcp9xzemY=
X-Gm-Gg: AY/fxX5PAG7zNpThvfuETMk1anTQxveUyxcrQWBqbTAHtm4bhECbNipAA6FOj7xP0Uo
	Pu8RTAbv13O2Oob/e4O3KngliBVZghS/oN0cIOVYowML5ORmfj3LS6/CFJR/g6kZ9NiQg+WWmZb
	H5UzFBixlQSm6JMUuSRrrqcQ6TrWC4BiebFi+FghNCySkh46uPuB1I55zEJm/F6JIevgAarMe0r
	+h/PZuKeTRO8zZwKv9ShYbtekVQhOEQ3ptoj3vRzXwR190FN1Om8Zudh8lbj4cK7ReNyY9g/w/3
	VRK+fIGj/MH12TiRcCJOMv/KBGzRGtt6S2MLQLmM4s56wpoNNbgc96U5f5YqIRQJW746IMjhsk7
	7Fd4iI44ONcvLXpsy1Fco+OkoUjFNAhtMRTWcGW5SF8tAr9srPRtfBVLmjGss5XVeDRw=
X-Received: by 2002:a05:620a:1a1e:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c6a67d8224mr1384275985a.11.1768907207777;
        Tue, 20 Jan 2026 03:06:47 -0800 (PST)
X-Received: by 2002:a05:620a:1a1e:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c6a67d8224mr1384272185a.11.1768907207296;
        Tue, 20 Jan 2026 03:06:47 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959ca4d6sm1355982066b.39.2026.01.20.03.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 03:06:46 -0800 (PST)
Message-ID: <3c4b38a2-d526-4ac8-95ac-f4cc828d823d@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 12:06:44 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sdm845: tama: Add AMS TCS3400 ambient light sensor
To: petr.hodina@protonmail.com, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
 <20260119-tsc3400-v1-3-82a65c5417aa@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260119-tsc3400-v1-3-82a65c5417aa@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4il-EzugZ7WiMMNSn7sUO-6MO60xIqv7
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=696f61c8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=sfOm8-O8AAAA:8 a=oY6S75yeMliEVWA0OjEA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: 4il-EzugZ7WiMMNSn7sUO-6MO60xIqv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA5MiBTYWx0ZWRfX10O46wmwlHGx
 01ngpt4X7oI+uz/4THH6gVAxQrhOIE3nzoK54jJ5byG80x4Timklr1mohuUrwaSGiE76Y2oplQ6
 onYen+i7A3sWIqL54XMWG0EAEMDOtnvfTiuMvCH+KR62s+uyiLzs35BgpFg9VwfBwzDqiX/tioT
 QegcLxznGNFjLAtSe35KOPwT7qgIVbbqa6b1xVnHzXu7KKva18NikpNChzZDvN7+JuN53RqLSCb
 wdKS1a+wMBq7jOqrkUpaBSnKVgubjuwmasL+u9jUmMZJhhgOMVCt/X9f5bJF0vgP7yaD8/Oi+P/
 jgj4jzjjAyXEcXBg/GnLCW2As5qQWJM9BxF4cf9WLbL/ctu03H0S7zIwGslNVU2I/ucGO2R5Udw
 IVJ374mFYIcGY+Oiqrb9U37ou+ZXR9qWJgTGml9lXAZR7mXvpxruT2QiE5M8K+r/9uNCvnImw6m
 ujzhhMtatNm2jKVFUfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200092

On 1/19/26 6:19 PM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Add device tree node for TCS3400 ambient light sensor with
> power supplies, interrupt on GPIO11, and pinctrl states.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>  .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 36 +++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> index 7dc9349eedfd..15d56d6831c5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -485,7 +485,23 @@ &i2c14 {
>  	clock-frequency = <400000>;
>  
>  	/* SONY ToF sensor @ 52 */
> -	/* AMS TCS3490 RGB+IR color sensor @ 72 */
> +
> +	tcs3400_sensor: tcs3400_sensor@39 {

node names (between ':' and '@') must not contain underscores,
and should be generic where possible, let's call it sensor@,
rgb-ir@ or perhaps colorimeter@ (Krzysztof, opinions?)

> +		compatible = "ams,tcs3400";
> +		reg = <0x39>;

I can't find supporting evidence for this reg change

> +
> +		interrupts-extended = <&tlmm 11 IRQ_TYPE_EDGE_FALLING>;
> +
> +		vdd-supply = <&vreg_l22a_2p8>;
> +		vio-supply = <&cam_vio_vreg>;
> +
> +		pinctrl-0 = <&ams_sensor_default>;
> +		pinctrl-1 = <&ams_sensor_sleep>;
> +
> +		ams,rgbcir-vdd-supply = <1>;
> +		ams,rgbcir-gpio-vdd = <0>;
> +		ams,rgbcir-vio-supply = <1>;
> +	};
>  };
>  
>  &ibb {
> @@ -751,6 +767,24 @@ int-pins {
>  			bias-pull-down;
>  		};
>  	};
> +
> +	ams_sensor_default: ams-sensor-default-state {
> +		int-pins {

Drop this inner level, define the properties directly under the
-state node, both cases

Konrad
