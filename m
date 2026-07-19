Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187BC313E03
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784497440; cv=none; b=LWfRTEx7eL9WRAat9aWT/gT5b/YfgUApX+3Ywq990iU04o0jHidG1n7iGSTsNf6ft7acfIiG9DZ/kU0D2WWf7qYnfIAmShwR9I6XEuufJJsjoJrAElVT5mWGLFPlanqPFlngJ6JX/6B5BQIU99CrB7/oJN4gj5A+M8dYcBm8NKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784497440; c=relaxed/simple;
	bh=24Jq8jtvvNJ1q8WYV8dDG0Q4/VRFa7bxdszF2UUCwzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRP3VIYsGTAWw1rGMjuQ6cBKsYmkUpUqVV0EznWlaPsXIvkt39H1o53qWGTQA2fFpnlv6yZ0nxc0VCMEx8sJSLweUA+cck/HAboQb5VCjwy6gp+9GgAuRvoiwE6II7tTU3OTou83ZMCnMLE4dEfqWDqWdFt61E8tGgPvcbMHM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mk0UNqyM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y3jN3vXK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mk0UNqyM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y3jN3vXK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKvcn3297514
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xz9vn9jbKAN5VIgfGuTHDQTWGSX34z5WNTsanpBwUg0=; b=Mk0UNqyMTGXVg1MD
	FHHoMpqtWtW7UkIt7ktgqMlvyvhJ4JyxiMVh0qpV5HGmF08GgNTdMs8Y/Juhr7bj
	6jEjT2BybH/2UUif53H19e8gZQu6YIT8oiwRBiWJiWBqmJ2pBjcG+h/0pxTCnm+h
	m+ZoYfRs8cxOS4fl6Mi6raCGls0QCYE6F8Oq3MCIfNsbGm2QDA636CrbdG9aG9H9
	ILrGcesrQXFh8SDoJ+ekZ5JGhd4TAbp52VmOQOlqAmF0u6tum103fAIO27yD+iJi
	eFfjbJRXznrlYYRyx4cUczcwZRfP00xRG8nYrPwBwF/PPjwQrG8wMCdHKGblLR0t
	bHX/5Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chkfm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:43:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca3673560so171119655ad.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784497436; x=1785102236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xz9vn9jbKAN5VIgfGuTHDQTWGSX34z5WNTsanpBwUg0=;
        b=Y3jN3vXKS1tdtRk89e/OeFUNp4quE3dTuVsqOU4IZaONCmhO37r2btsYrUvi9wrnUr
         SoE2gL3YUn7Up4ZrwFw/X7hUe++e39E8UCXXz/3bf5gZ1wzrTH3iXhbPqDdU8OO5MgpS
         HPjHHxKfYeQBcpxzk88o36lihm7le0CsC5OV5QenAgjM+ThpfPSoKDz0bdYC4Cn8p6F3
         CbHGMWjEEmt9vsspgHtIgIgWQz75ls/Cz4G+pJxeb1+yDLCIeEjtwgxxA3RvW7pkp5Uz
         JEQ4i7JjQgE4UowGpvMggvohp2lG0j69lkb681HvGgI7bl7klpntERMJYFPpW8LEZQsb
         Yd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784497436; x=1785102236;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xz9vn9jbKAN5VIgfGuTHDQTWGSX34z5WNTsanpBwUg0=;
        b=siRmI4zC92TrF7hA7KE5o8hn9DOW0E0laSH8QLcjRm6TYuL6qeuczpCdYinodjLZWP
         1BVhzfI0Tuou0XhH2kocKaC1zwqCWqiMFTOsOogNuXWHJqElbI3TUPq0OwF0MDVMF++L
         V9BiiwdR6v8NxnTpGMsOpZ45OsLJEnyYY0+cOH1rzx+8HjeFZV/CugTxVebaiRBPqBy5
         zkutPGQN+Y86L0/KkG0LUbmyHVmNjO2N0yqdr4oHMdXxoSicJ7AInTTuveOWY50E8Fn7
         s6hxpFdKIqLelmENDKLKHU5jtKB/N26Yp3yf5+ks6Q1iXOv/jEiRpwSA9194JUYVrCVw
         lyow==
X-Forwarded-Encrypted: i=1; AHgh+RqF7KlQxVchfEcvBUbDZ3J4TB0Xn2TqtyUbGwvN+xR8jVp+WoqWSCwoUdjRjp5nIolctRLtiKDpnAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSMK/0gd3XSuO2ajLO2S+jq6UJGT5zohh/0qG5VE7QCn8U8hm
	OsECKI6tA0tRQzZXZPY7qwGbDzMIMSi0hZOy7B2KtzK60CcE0SZZEUXGmazhAA78ZxZ656dOREx
	JxHuCfTcwIB9k+xTFblitxGnpqJF5/K9EgT8CgFXiC3hD3O/YtjVHqnqB7yA+6Ds=
X-Gm-Gg: AfdE7cm2TO89DFMJtc0k+m7FVpjyfR//3kLHTHu8WQ9/WncZc//X/nHN5br3CLXD9lS
	ApYtGRtIBlTZ5oA23m/yJufewMblN82NQYRKMYhPMoJQ/ona+J2C65o0bq5JlZMaVGGCGGcpc9X
	dShmEdQ4y8pPgPGL9BYlWkFNl1IRDTXVNCQmhoX+PbFOs59eHXcHLK8BvMjwoEE+sIzHO2qPRhU
	UfT/xam1aGDJB6wNfhiHuNpqYn0C+AMC0lRHl5Cz7JTIQ41ZT3UsuUf8WIhIT67xzdIH1fjiKPY
	DdctRK5MVOlJ7aOTw31Di9a7aMFC2BnSZfDSgSoHnRVZYifoA1gkRWW7VmagbB23a1Xov8n8olA
	UWoBZ/ZLe4N4cl20p
X-Received: by 2002:a17:902:d2d2:b0:2cc:fd6c:c5c9 with SMTP id d9443c01a7336-2cf348961ecmr134067355ad.4.1784497435891;
        Sun, 19 Jul 2026 14:43:55 -0700 (PDT)
X-Received: by 2002:a17:902:d2d2:b0:2cc:fd6c:c5c9 with SMTP id d9443c01a7336-2cf348961ecmr134067125ad.4.1784497435497;
        Sun, 19 Jul 2026 14:43:55 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf345110besm45330985ad.36.2026.07.19.14.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 14:43:55 -0700 (PDT)
Date: Sun, 19 Jul 2026 22:43:51 +0100
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
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/4] iio: dac: ad5686: extend device support with new
 parts
Message-ID: <20260719224351.1af8aef9@jic23-huawei>
In-Reply-To: <20260719-ad5686-extend-dev-support-v1-3-841ec75cf5d8@analog.com>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
	<20260719-ad5686-extend-dev-support-v1-3-841ec75cf5d8@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI0MyBTYWx0ZWRfX6hlY/ZfY1fP3
 Ke6y2eOnWq1rS98gEGQKMTgBKtPKV3z+E7JX+N2sG+gkYQi8Bm+v5zNJPlUgm/YmLVEd7J1tpKk
 dBRe/ys9XMaZAznQHI6NvR4xJXXJJFs=
X-Proofpoint-GUID: 89QzFAqnOC_Igjdoork8z2VF0BtANR54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI0MyBTYWx0ZWRfX54hKF05sPSRg
 l4WasX2+ukti+cvGBo1cd24VavmpxT0c+wHGG6zqacSiPZ/GjJaEznOe+qEQTAkj76pBB+2Zpz2
 ZQV3uV4zC3E2eygyx7QiBIv98MCdiI3FfuM9A6vypW/ApE/7/taKqd0KzQoMGaCPnXn7CObgBiW
 VRMzRLNHXzNrnAk8NTZ9zHyHNf6SCo8jgtlWWxQeDhrb550DD5AD38oZPJcATdkjADut0ew4QOa
 3szw8ijeX3gBBe8q+hkzVR3sGfay6GR36FkRMikO2KBTWCDu2p2IQqnCEQN9OT94MoIMZE4AeXg
 j38gb6RxonvzT2J1gOgbdFk132NjF5/nnP8higN6+LN4qYB08iQcoTDnwMK6hK9597n/t89aVBH
 DxCGkZIEmV1oE0/t2Vli08j8P3c5Y7b3zQidekYGxJ+xuPwnZSNTiLQOwCy9ahAdJ2iOHxQHnve
 bEulMAfpaMoELMeUQcQ==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5d451c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=2QJMpc5pe7ryNfTMuFQA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 89QzFAqnOC_Igjdoork8z2VF0BtANR54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190243

On Sun, 19 Jul 2026 10:51:59 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add support for AD5313R, AD5317R, AD5674, AD5679, AD5687, AD5687R, AD5689,
> AD5689R to the AD5686 SPI driver. Also adding support for AD5316R, AD5675,
> AD5697R to the AD5696 I2C driver. AD5673R and AD5677R were missing from
> the of_match table.

Given I'm asking for a v2 anyway, please break out the missing of_match
table entries as a precursor.

> This includes the creation of seven chip info struct
> instances and reuse of existing ones.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Thanks,

Jonathan

