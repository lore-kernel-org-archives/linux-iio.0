Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BB40F8F1
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907014; cv=none; b=UeWYdS2pkwdNVcsIc2YlTk7RaxT6HxxN2/iR/oZa80AfYkfGKT2W/QK6IlV8B/PDmRKMOYS2QXqLaT74nDzvDTUqiQI+eyrBSGhzxLUU7uZBhZyBGv/gw1VvgBFV76rbRl6gHcp/q5OUH8Pj9mCfLm75zwIJupfJ4ImPKgO+EeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907014; c=relaxed/simple;
	bh=mtsPTsLVD96QSs7WS2fzwTcLKDOpeQY5sktuXGChUH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSdwwMYbfA64MK9FIR1go/I3/S4T5Ks6ZVVnprZUR/+bKm8mcfrUsduyuOmTWw3eW5+qZTHzFY5ex5a8Mpn2+5lZpNEKJbuCEhFIRT7E9TKYWSx17FMWpQpZnnFCRXUcEqFeFD0FhtfRmDXnKA+Sjdz0VlTZncrrK+yaSkoX/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLWGENni; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EsvFBj7l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLWGENni";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EsvFBj7l"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K71ZmC1408477
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 11:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DyA1fH2htzdyzQNcxYwhjEsKldEhukBQeTM4OwMWwXA=; b=ZLWGENniSDL5KkvB
	gIl17NgV/3KgkolMtNR+QRNJfBamwuET86OHqF578h1yy1+IeJJSG9erPZZ33qoD
	B7fAeY+ckfOCBXsP6HGW2MIDBHXuR2erGJpEEANMp6XqLvyaJ58iA0ZpHkmnQMzp
	PHMRjg0AeCuZLLIKYMjTU0CGJBB/V3IY2X1c5CMxFxF82i/sglEiffCSmU3Zpb3/
	4t1fYxQbfmfaEr4d9Km5mgKReq1BLnDxf7pyOVHpU8pKoGiqjObRe4RcerHx9hKP
	vf7VH86d1tf4LCDdPCiZTJuLtL3pvc1jhih3ao/mw6cwfVXqZsPLQkx/nXdsE0EL
	taWCuQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4y2rr1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 11:03:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6b48c08deso28071185a.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 03:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768907010; x=1769511810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyA1fH2htzdyzQNcxYwhjEsKldEhukBQeTM4OwMWwXA=;
        b=EsvFBj7l8PFMz47rSaIbGg9H2LX5R90uV+viJ/wAsr8ahUQC9l/xLjh2RtFwBBSgdX
         C15uJiRe+mZDSdkGDtye9gnPMif2dsSdmRVXVbq5q3cJuNUrdzg83CViFNzeQVospQuT
         PJvTJhzroPGZj7pg5pWcAajNF5XQea7IRvk0v1/RKrK8xAXppCXYwmbfd/wIzzDwFlz0
         cOeySbvDWaClM3xswYArD5J9RI7UAQAoGYYXmbdBHAiHLZtn3On7vdM1vDjoqdAL3Sq0
         SjfOVqKIy1Zpd3EFRDzkX5jAarmA4iva6XUxqWe59xhmk1S1Pe3LF5H7yNWrjNnqnrMk
         OOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907010; x=1769511810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyA1fH2htzdyzQNcxYwhjEsKldEhukBQeTM4OwMWwXA=;
        b=wK6p0I0Ts5jwrY4a6dGHDKHoZgiLLvyEgWVjd7JW3aUlg4+nPZpnBpD6N0CpRtn1V2
         0faF472wNzeLC3KN7KPdp6G8BCKdnY+xYpqH6RDYeQSiyR9PvAdBRgyiDHlIY1iu342H
         AHoSG6iWB3y62UAxiLLVixBD9FYX46dRf6LzPcWD42TyZ5vIRp7HI8uJv/KoJ99DLm/L
         Yza+CpFGs2Z3CL0XzlydFZ74syDahKlQRTYWKuy5RyT15G7gEqMzCa30a7kVDyJ8BWkm
         oWhbKSRKPRUAlv7hIQ4d5acbSrTlnPUw10762XyLgCENlj++ZRNDttIwXceTZAles5Bw
         76Pw==
X-Gm-Message-State: AOJu0YwPLY10KYVl1xoZLKfw1TiH2hGGUuVDE4flznKh/mJTvigoMrjL
	5B/yi8mancOis/ogTv4/xoBVvbcv/8Qf85KPTlovwg87Uz+npeEVOD/m97V/CQG+ZH/OsRdtIwi
	svhx7F8Hxm27D+N9Te2R0ifqrzy2updpLCO3QaHLPzTaIu1ZYGd02K1E/SpkP2rs=
X-Gm-Gg: AY/fxX7/zJNdiYDnqXsuj/EeExUC3w6rMou7Hy5moc+wFsnpOEvZg3zuta8QuNIorZ7
	JeUHX/y9cgh1PnA1MAZS6nSQqGURkEwSVB+Yq2ntbhUss+OPsrSQIUOPlI6kWhbWDFsywqf7fIn
	QNeXOTo2BCe5J7v6Crb4XQCsRB0VgDkMO9B9IDLpTOTEORUn8CSsYTykfg6u36W4JMnGId29bzZ
	yoLdk4LvaQ7+4IEXnpR+aNiMQoBZIiQBm9pmG81CxuxEzRHWPOsgaFx0HITTSnZWp797oyaSsaD
	MtNKPS0fpDADAWFL7wkt0bDb8l15hqa/yMbrpfCBYuRMqh7L8MqDD26lpotuECLMGmnEUjtk2wh
	74LSqkmMiO8md6NS24O7Cg9zXuQRhYDqSLKLIPrNMXDkjoPKwgvjQFzjybdtnlZFhTkc=
X-Received: by 2002:a05:620a:28cd:b0:8c5:3699:97d9 with SMTP id af79cd13be357-8c6a6783a3dmr1456078085a.7.1768907010058;
        Tue, 20 Jan 2026 03:03:30 -0800 (PST)
X-Received: by 2002:a05:620a:28cd:b0:8c5:3699:97d9 with SMTP id af79cd13be357-8c6a6783a3dmr1456073685a.7.1768907009425;
        Tue, 20 Jan 2026 03:03:29 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795169dd6sm1450793866b.27.2026.01.20.03.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 03:03:28 -0800 (PST)
Message-ID: <6ad1855a-acf9-43e9-a8ab-303f553eae77@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 12:03:26 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: add AMS TCS3400 RGB and RGB-IR color
 sensor driver
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
 <20260119-tsc3400-v1-2-82a65c5417aa@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260119-tsc3400-v1-2-82a65c5417aa@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA5MSBTYWx0ZWRfX7C1mKv5h1oOl
 bFALlRDLgQRwK+PIFHhVHkY5t/8uK12tgg2g9UTpUEm/QTociza2iLKIzof8HRl7kdub3o7VwA6
 i2n18AHmucklM24kpLjIhnhx00DQZHpPyFUmbFz2w6+Mfae9Pg7sExJxjK2zewuiovv/fxFin8o
 Lu61eEjNLkm/oSg4R1aSh0GTSrdL7L2i73kivNyuipp7yfxsZlepSBrWKETPrNP3DDA44YraDAr
 0w1h28LXCA8F9lduIRjZna1PN8uO1kDPlMDS9VSOedFiefvW6n8bRX86UTSR1pY+mH1vlZ+Ilr6
 oTIAbFQ3UgKX0ELE1j1jPcvcu/rw4k4OFgpwLWzmkeNi8pvGWTcba00ztBbkC4+nN4NL8GI60Tb
 2qFDVvu/o8xYsnnu8uWRtsUUXVFLx7nczPvNkpytAbf6vQrBeSoBbYAoSKIzz4IxSXb4BLzho+z
 AWwCaW5/fJ/VpaIYN5A==
X-Authority-Analysis: v=2.4 cv=Ds1bOW/+ c=1 sm=1 tr=0 ts=696f6103 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OQN141zOAAAA:20 a=lLZmtIKjAAAA:8 a=sfOm8-O8AAAA:8
 a=5smShmgdzqjJoumddFwA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=q5Nj8NTjyn2D8kUwajRn:22 a=TvTJqdcANYtsRzA46cdi:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: MfyRvH4fIObodeZ692T_A1YDXnXkYr_k
X-Proofpoint-ORIG-GUID: MfyRvH4fIObodeZ692T_A1YDXnXkYr_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200091

On 1/19/26 6:19 PM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Add support for the AMS TCS3400 I2C color light-to-digital converter.
> The driver supports RGBC and RGB-IR modes, programmable integration
> time, optional interrupt-driven buffered capture, and regulator-based
> power control.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---

FYI this is the driver that shipped on Sony phones:

https://github.com/LineageOS/android_kernel_sony_sdm845/blob/lineage-23.0/drivers/misc/tcs3490.c

And it seems there's a datasheet available:

https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/897/TCS3490.pdf

Konrad
