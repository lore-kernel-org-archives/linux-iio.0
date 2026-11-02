Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622241;
	b=SsXCG/Tihp61i+A27YzJgRyU9lw6k3+c0U5J0QsQe1TUr9IkwgbIVB38vXBHsGWkdjpe
	 0PfGjM39KrvFFZZwtDoX3ZhJk1jM4fj2K3KYDqxfm8+lhTvRbpQfK9wxasH29+mIrgsHm
	 CLS2Ax/xz7bn5h/GnyTerq93N6x0DrpWlcKTdIZd2TtD2+QlNo0IMhbo0tws7gFx/Xkad
	 oUJqavhIpUEW3h48lBYyxgzdtk/4Ka1lfI1xDttweVX0KZFdX+BVVP4VqgT0Go0WMj2xF
	 0xD3k95rKUhVQeWGX5L6rBOLWRFdbrPYqAYOtWOHMHFAyBnFkOcKTaYwEK/3rT0T1pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622241;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/Yvj0qxBUINh7wY4gdkTLWBNvQlQhWtLxMm1qk44RU8=;
	b=gsGuZ1/ReoMXNifzAutpZ6NIPmG2hkPbEUj8uQZUFmFhaq/220gc0a1+6JHD0iftdbib
	 8NGha7M2slDajR1i2zzeeglvwA7CFyEuoFfmWUQOxrmMQH4Twwpn67FoF/bwamOCmiTLn
	 wgGDKeSGrjuDsL3DMPeF89RgcUDs4n92svPWekMcugxFHfelDudpbFzYCHCpGPkMkRuS3
	 SoaJ5hJGQSp4xR8geUX8Ul0EAlXqc/CS3e0qbiNt+jM27QlQeoQbnUo2R2ntml5Dv+MXg
	 Hs6i2kMG5uYdPofCtcgbvohhYn0Acco1Y6HLfvAY9I/U6OynVzFJU44+XSEQ88kLqdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wp8DHLtU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PP68G5nh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE2606AA15
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 12:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67FE2606AA15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wp8DHLtU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PP68G5nh
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AIKp4039587
	for <linux-iio@vger.kernel.org>; Mon, 2 Nov 2026 12:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Yvj0qxBUINh7wY4gdkTLWBNvQlQhWtLxMm1qk44RU8=; b=Wp8DHLtUIYsr6dUr
	66N+TY9Htt6YRfP44vU9IbR+v3LGKMNdhONzUIAL6d5AP7CiSxaygGy1g5hJA0RE
	fkWYgh0iD6HiwK0KHIC1gvS4BIezf+c0MIJ9V7Ja5K+MtAWgQB0TNe/fTs5tbGdn
	g3MOyRAV4mciB/EzPhZsJCIGya1UHxP6oGjMo//wStsuMN63T0lTIf9pUpeYifzT
	hIVjEcb43+BPI/SpW508B8gKc/IX6GuSbeHHg72t+x/N3jubwViMQ7P9H6OyZh6w
	hM40nsAkIWOqY2MOkv0oAVrf9o4ULFPuNN947CkGU3cPVHWOkRYgzvjZ+K20beU1
	SkRHtg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph193gc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 12:24:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-945b0154705so205616385a.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 04:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793622239; x=1794227039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Yvj0qxBUINh7wY4gdkTLWBNvQlQhWtLxMm1qk44RU8=;
        b=PP68G5nhwxs2zpBO5kxwYyowq336LfDByPXk3np55htv6aY2Bi/jEcPqggX+N2GGlw
         0Y33+xcvmZ1y+VFOoAaRDLRIxikkDDGJkRXSsNJQIDIakNLoep9727JU7C/BoIhsXKPn
         30NLzQSYASUZ+sbaNFCcyPUTSm4eQvKKxCIB47Xt7anPOHf1HeinB4/oBaJM0aBjgzcQ
         La3JJKRF9R3nNgwvLMEWtPOX3b+spAkiwqJHlj2nZZC+wmozlL70JbG6IPdHM3/q5b/P
         XP2lq0QhgXJZpZoy7uTOCsXvFl0/s57grzodrREgWLP5jy3H7trs9QSLaVjksR/JxO9u
         e+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622239; x=1794227039;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Yvj0qxBUINh7wY4gdkTLWBNvQlQhWtLxMm1qk44RU8=;
        b=15E4rMcKk2m5l9H6bNvx7fOYIoEgfDelBVUp/8FrPJJ3Y8RDKYxzVgAVX2LTw2FJcB
         /4CpH//oclOvXJdlt3gbwDqKOA8JLz+FCtYd3Q3FzKvF7SfCMvwfRCWJCpqWKG2YdKSo
         kG3Jb5/XT9RdNs9qiM8cEs0JYfLL6NxuQC7FJQcCT9uqyLNKklH1jZcTeL3L4p1MFFQQ
         uIJGAMpsHV8LrKV710YURfwV39IoJA+/IvxmJasqdLDUMWo3wQuV1wks/uLkOmzD7Qa8
         WpAYQCjJih6jskaHn/GHwnVPwFn0CJjGaLae+6XSMex5JER39Jzvy5/OtxLNTrDBP4Mq
         qjow==
X-Forwarded-Encrypted: i=1; AKwUvByL+sx+eSGMr4x9QYSw9N1hKAqq/ZsRCF+p5mZLudDORKUySKtQZyfL8iamfXWHgob6xssNWza1gI8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhNw/0WxViymKVBlCyh5y6ng6QCkSrIuuuHWY/g+8t8TgYEuvp
	ghZc08yTWog/n6IfytYmuWSNZVLprc7kFFHFZL7uGg/EHu59hGXWo3bCst72g17qokvCkE25rNH
	lpBwV5mkv2k+sHd/lfgEK7/hVcF7tXHonRZ46FfuZZueLGL5Lzgf/GyHLHSP2uJI=
X-Gm-Gg: AYBFou1pDyJ9HWH3uIp8Orp9ABsG/bB97GAAyxM4q+FgcyVjBYk4GKFrAXdwo5pz8xh
	q4NSo4guawR5lNJKyqMO3KsO9towMpbAyovjK0bef4uJMyL0SqDdz7COiad/pgXKFlMdhky63j+
	N8IZ9MISuTaSSpbOhv01BnoaJlotwn0w/8qngSh4lqUdFB0V4NIZ5uPSHTeexUuy4fSTIzYY8Zs
	X1TmOETfEMnk3DKV4x8O6LsXPrd1HekG+grzl+HigtuNsTyVliPnzdGkU2jSVyN8igqYtMm9Z4d
	vwJQR2yfu+i37dKC4eTRdbQ86tWVwfld4ElRXop3gJWwVR/O7+QTEKmLobvQ6Ks9PBUF7Fk3efq
	yy1mgzw9a0CjZk+wNvf2WSi5/0TQD75MPbEfVRQbgMcjWeApCOb1XSlUnkMHPXpfDst+X8/2kyg
	==
X-Received: by 2002:a05:620a:2795:b0:93c:c538:2b23 with SMTP id af79cd13be357-9442156a038mr1545786985a.1.1793622239521;
        Mon, 02 Nov 2026 04:23:59 -0800 (PST)
X-Received: by 2002:a05:620a:2795:b0:93c:c538:2b23 with SMTP id af79cd13be357-9442156a038mr1545784385a.1.1793622239039;
        Mon, 02 Nov 2026 04:23:59 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc1915csm383627366b.7.2026.11.02.04.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:23:58 -0800 (PST)
Message-ID: <21b771dc-e9cd-46b9-a456-0950ae1270a3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:23:56 +0100
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
Subject: Re: [PATCH v2 0/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
To: Vidhu Sarwal <vidhu.linux@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
 <20261102-massive-busy-woodlouse-8d0bbb@quoll>
 <CAFqz8LJZQ+tw6wmLS-1FXvt6OxBESPEyz2-uK4D7B8X8epoKhg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFqz8LJZQ+tw6wmLS-1FXvt6OxBESPEyz2-uK4D7B8X8epoKhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n7T9M9c1DufalXYtQm2gUR3RTIPV8ENS
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae880e0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=JtIBhPYq3qQR5xcgr2gA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: n7T9M9c1DufalXYtQm2gUR3RTIPV8ENS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OSBTYWx0ZWRfX9AKUBVJjmvEe
 kMnmFKnj8ceVFFcln6MDQuc4m44ziXsubT8HB7PIM7ClXgQLTsWDSs7wL+EtEN9PqWvYFc0jK+O
 yCq5gm/qF7TeuUWMKyKdDq0BWPHYjsZHCna2F1R6ejuegNwEBx6MGgl54EzePEVONA2Pa1C+DjV
 pItvtpilwT01O5SD2FUGOI/LtUOhi9KIywCAKr0ckPFIt/jQCRVw1SD7Doy2Y+nypo166RykPNB
 /VzPnUkWTUtF0iuOjYH3sYxx953V9Uzc8LXOaS2Wi4GK+TS9X6qd7hhznIY2RkrLBguTrUVQSEF
 BaAmN/swm3lWVt/Wi4MmAwF+96IS7Ju5Vs48DL2Y7NcXPmrRbf4cyHJpwfR2y3YgNSp4+2rl6Fy
 QXru5Pq8D6V0KG0eHnSdiepdyyl+IQvuYMJnKFgz88x+2eVRSswg6UlyflXDn8cdQ2Q5C2nzQWj
 eKnfjfBS1+L/9eLvKmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OSBTYWx0ZWRfX8bJhq8W8QJnT
 TV5s8JyKE99EOsqJSLYz1LsQ8KtSUcwwH4xqacwenabbYNZlrAgJoDnrveGeVKnJ5bkOpWQ2c8h
 9WzHbE3uM9IM9Zll88WA/e7xZxFfIDE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020049

On 02/11/2026 12:48, Vidhu Sarwal wrote:
> On Mon, Nov 02, 2026 at 11:47:56AM +0100, Krzysztof Kozlowski wrote:
>> What changed exactly? b4 diff fails, the patchset cannot be applied on
>> any known upstream revision I tried.
> 
> I am really sorry for that, I didn't realise it was based on Jonathan's
> iio.git (testing branch) instead of linux-next. Patch 3 conflicts in the

That is fine in general, I'll wait for next linux-next.

Best regards,
Krzysztof
