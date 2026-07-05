Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38523FC41
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270468; cv=none; b=tp6nsIW8Wx3brBm81mHpYGmgUxSrM0ZPpl6ZPXozHNfabgPlkyZ3dhBpq8vdYf4BqoH/QEPShNLc3KFF0kML+s8y0hVWnpWTjxtePYMEG1lnubH/HBt5D/3RdgIDLFpdU+ici23EzjdTVobYzRp3Nbz+sUQQI1/GKjXl39Eu3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270468; c=relaxed/simple;
	bh=+7wdWExKan4dBAAPMYMsUwIGbTDsI54vr+pKiGN8FWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAkGZ/qanhcvtuBZCR62W4fBgji782hs537nRgfUB9nrfyxQ+9ENBevWILKLZanL8KXzE0hLdJGIvAlpOUfNxjBvtqBXhltribU0OVYtmEgTT6d9TGJoqk1L498jSS44D5arBckntKDdI10wI2Fqb1XohLI9QqHsZWxcNpjoBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVBzlSZP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kRKpDK1L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVBzlSZP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kRKpDK1L"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6659tTPZ1248965
	for <linux-iio@vger.kernel.org>; Sun, 5 Jul 2026 16:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bcGL98DuA12zHO/juB09q70kHJyhbbXB7bS1RIzVhwo=; b=SVBzlSZPcHJtmA2h
	AXMDPJYu8HggWxUlwWr2KkcOV6S7y3kvSfoEgHhfxY/X3z0KJnYAIlIM2eAh62Fn
	Xv9Yrli4ZSmuxnN5D5cbWxjh7IVieA9BL5IqxIdoRyQ3pKq7RYm/iJchmWyb9Mgd
	LdfmJpY8GQ7TLUk/k/eVKaPwA5frKL8ZxVYpCBLvRgP0UdK9EA9p+bNkTRE0C2C3
	iHM5XYRo738p0w2cj5O5AWXdbBxSYtIR3q4QHy/6V6hco1HoXNvp6XvjHQekEEov
	iPFXuPfTtC2xibb6MyCPqLRfKWoSvCstLjeKX0ULg6T0IAtLNpju/dPofHJfTRL9
	kRET6w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txejy5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 16:54:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88da04b719so1475145a12.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783270466; x=1783875266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcGL98DuA12zHO/juB09q70kHJyhbbXB7bS1RIzVhwo=;
        b=kRKpDK1LnshMBqxn0iKVvkqByy3jj5OSyZZsbORBddDTVoIqa9dAEkygi7vup4UVVu
         qvx2M/SMB9/O3G8jhgzSTURW8aYiq3PzBIvyNswJ3LRhznqViG8h5VJM5RU/em0peKw6
         BCZYfYh4LqR6/yHqv3gKZp/WgfK3i8CSb0ijN8BxmL28MLa4bMsJfKQ/jPAe2dVsKV7A
         OljdnFEB7KGVYz4HuRlF1RwngpVEfAYrtBOzRI4c5zUFVBGSbEFUtkQxYIS79j6xLcFz
         Ueu6ImGAhyR6C1tCwSkaUR7R9FLuxY61VjG9P5xpoVhvzySBYtHS+ivD9IhFR5l4cX6c
         0Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783270466; x=1783875266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bcGL98DuA12zHO/juB09q70kHJyhbbXB7bS1RIzVhwo=;
        b=FCfJzOv+nUjmHo7y5sOD4e/6WjZM7HSmxWeVt7OkaidnKACFzh1ZZagKRBG2fKhUKy
         qZPpDhBoiV/nR2gsqtI2dBXq1pAsQIldAi6ffoaLKwdkjoe4VXTFTQnqvcTlHFJ3rLaz
         5t9KjwvHlTMippzhRvYLVnHtaNdohWFgp7jw49LtTzdKZg1EEZNnNU1EP/r+iYQj85h5
         8Zdwy5F3QhQxk8aaT1TQIc9ya95UrGIIpjz1rPGSBiKfDW60svSzmzdRH/bEbtvsbRH1
         emrQOn/Mbn42gR1Rddrwku4gxgY71ma0Llmdg0wLyfZzkOoeFC0CktGAoEJcG0SvTx8K
         wdcA==
X-Forwarded-Encrypted: i=1; AHgh+RquA6e5lRcDywHgXJo4UYe8aLQ3gRJtZh42jrLJ79fGsVS0LaTntYufPCgMXMz6xMcTP+77zpgJLZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYfqOrnrxfhoJSl+augDFwwgR/cCXsQvCIvg+3pkeIi7aOpuc
	5Od16phP+/oJcH7iYq7D/qSZZKK+OQ3T7q9p/6Vmdg9u5FVyyWcF8bQikIwDR2YomVgmHomtOhA
	YEWaVm5ozi1mhL2nZ70zBHj/V87UzuPCmsgMVzMu+ueX7PijkBTaRnmYq1gF+4Rw=
X-Gm-Gg: AfdE7cl4EFVwZ0nmm2UJsPfu9lx5BfsxYroKNTD+ZU6D3EMh3ZzvVU+yyhOanJtpzDp
	TK85rjPoSjerv/dMRhlfDBUJWYL3fH1BsWRAraa/f8oasmZ7Kf6N5nBR5g/yCEgQpzkxTVtHyts
	iiWbUTy8lRT222VRh/j7QGmqLjtJVyGne5eQIWENPuCPBgwWtm8b9IQ3r5+wQNoWzTlKjGLdH3q
	qyH1h5rzOVRktxSkyMhP7EtD5JGHRltkPW4RhMviEgXarOII/R9ZYGg764cV7Zgfomwt4XZCGep
	BlubxzRKUDvXucOR1OPUUX342VCkXMRIB4kkoRKW9Stp0JSw0s4NLszo9mMBDac+P7F+nyJNZSm
	NSWRSqnaWgjnUuL3O+LMgefWiFbG+kA==
X-Received: by 2002:a05:6a21:4ccc:b0:3b5:52b4:87a7 with SMTP id adf61e73a8af0-3c03e1ff338mr7092204637.6.1783270466161;
        Sun, 05 Jul 2026 09:54:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:4ccc:b0:3b5:52b4:87a7 with SMTP id adf61e73a8af0-3c03e1ff338mr7092182637.6.1783270465702;
        Sun, 05 Jul 2026 09:54:25 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3a9341e0sm38253593eec.12.2026.07.05.09.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 09:54:25 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 22:23:34 +0530
Subject: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783270447; l=943;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=+7wdWExKan4dBAAPMYMsUwIGbTDsI54vr+pKiGN8FWo=;
 b=3RwmjgkTbbosm+RA9fwHMFB03JeleNEddXPrhgA5fuHKbu69n7qr/zoopsBgm7eXGUOZKOv77
 Mgz/+KLp3BLDgjT06jhQQVsUJ1DnafRaD8IPIxDURVA3RyuIVHh1DeK
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4MSBTYWx0ZWRfX867kIscfcA0t
 lrQNLD6/SmsH05hBxbRgt1XqvCV8b3PSSA4mrnbU2B5H45rhcWGBxY5y2PB5a5MQPS8gyIpaION
 5XxP6zL92MsDxgcqsCVFTTZkd7Zccv8=
X-Proofpoint-GUID: ZM6rccnItXPIfiKJcGNPhQusoOp78wR1
X-Proofpoint-ORIG-GUID: ZM6rccnItXPIfiKJcGNPhQusoOp78wR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4MSBTYWx0ZWRfXxvg2Wn5G5/BG
 7hbDBM9e9MPMg3/VMAsNEUrWAFNym0BfhUJC6xvP1AjWwYKw+lXgpaYxddt+blbZiSEyhl7JlSa
 +QpIewG0O+Nll1ksxL/MaXk6h0UFgD3tKjqrTMLFJCCI4JYHKJMX/xpQfM03IQIcueRIBExOuCW
 0yxLl7jh0gcLEXJt+0R3a+W6auK2irIU1DUDme/fRamdb22rD4Flo+ufvaiYqnblZbX5vVe798U
 d6WwhOSD/HVh/lmNyDe55DpV6yrgNChk0kpH+iR94m8dCvz+FsApo6HcLzLUM0fNKo1PENZONiU
 PcGfWAU4ini/cnFz/La3iT5s02AjwGQR6LPwgYDKA6TeHQsZSLBTASLrkItDPqcvcgsV149ITrW
 SQH/tQX2fwNnwb80BSMf218MtxMQLI5lAI7LjfIMZHvCtx1GLa7It5UhkswLMcFtk0gg2tG1qOD
 OA2fB6Za+Kr1UffU4yQ==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a8c42 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0GHOkdmGqssP-iJ1QkcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050181

devm_request_threaded_irq internally prints an error message using
dev_err_probe in case of any errors. Remove the error print in the
devm_request_threaded_irq failure path as it is not needed.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c1962312afcd..74988040e6e5 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -793,9 +793,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
 					adc);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to request SDAM%d irq\n",
-				     ADC5_GEN3_VADC_SDAM);
+		return ret;
 
 	ret = adc5_get_fw_data(adc);
 	if (ret)

-- 
2.43.0

