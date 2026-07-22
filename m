Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904103C8716
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719648; cv=none; b=sDUpKQVJ42aiGKoq38q64Ag+4Em3UL6XOBmY8kz4WRp5bk3qp52/DjXvxgWab4plNuY8rT+R4NAsf9YZEZOEFKlTH8TG08TMH54vFooNu92veEQ/najbQkdcfLkhEeR38Ho6CPXtPPZ7X4rjgcDt6931CDoloEOcuREAgWRzrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719648; c=relaxed/simple;
	bh=kmkGsqLClKltGgmx2ZFGSlei16yqugauZtjl778tICE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qurgFzxWlAyJNuBirUMwWsc1y9aQ23q/Eh08wfU+z7LDV2KFrYQPimkq/8GV5Jd0c1toAjqI+Y2jIQBEWNooPypuUF5z6uU59nQnXcItR3LeWRZLprkCMTIvCeL/bHlSnfHkp/sHKMfieWnX50TflEiyQuy68sMPDM5Djygb3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RtLGsSzB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GryaVWmU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RtLGsSzB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GryaVWmU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xCjk401256
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 11:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5M1LRmAykOX0G96PBHdB913frohKOxohz72tFSL1lVU=; b=RtLGsSzBYtJlpR2C
	wNJFdYffjmolVgjmeWSiqF+rDJTYEqvKQtsDLArAMH/jsntJ+3z6NUgsu3/axWaA
	GHUj2vQTi/d71NsYpoDrb9vOejwkvwg8aDNZ0E8390tRVkbihbpHVf6N2xzwT42B
	P1I7VW2SgaCidc4aWr3m6KYJfNJ1jfpO/iFd7NF8Ep19qS01E2eVZSqi3sE7AOsy
	sk8ATHNAKgx7mtu8E2NmWKAKDfBAmGwaLf0DBUhDdUJjle+F3zxJYWUOIm0NrKEs
	p1eX06jH296WbM7/bTO9+uUGQDxICz6St+fD2YOdgmFpS9yvpMa6sBldjf/HooZF
	0NGLvg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt798qtk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 11:27:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cd01a14e81so180622865ad.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 04:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784719640; x=1785324440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5M1LRmAykOX0G96PBHdB913frohKOxohz72tFSL1lVU=;
        b=GryaVWmUqIgOIPR1xYw6Cvp1vqNqSQpm6t7RWaGNZriFwm6RfPZvy3eTz3C81Vut0f
         4UF+2MhHhNkUa0khjBqDr5lCTI8KGRqLfLMrjME/WDOOe+g3lnYW6g9yieVgK9UFTbSt
         tLhCBS7sk7wtQDLPNGEGcXxG5G6aDHvQKQT4RMfnE/cVZ3o1vgwYZ45KFfC4XkJ7RhyR
         kyJCW5svQ7pI9sqMkJ7P3EL4EPQ57hRztpPuATcFjoDbBfa8Q1mEL1cBFR3dWqz7g33E
         dVV/45orfzb588WFasTjwHY+/9fm1ARMB8zzhzkJW3jDe/vRJaC14eFSlWwVMfN47RMS
         H50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719640; x=1785324440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5M1LRmAykOX0G96PBHdB913frohKOxohz72tFSL1lVU=;
        b=A/pPYyxRY6Sf3VGw7HxQjN8uK4g2zcZ9NJ7qzliM+Bzv7Dueh1I8TXqk8Nmyapbuej
         Wx4mzWURL7Z9Wl8Z+ecRS6k5pE8uIYVD+U0GpBfwyQciwQGKdhZvT8n0Ka9Hwz2VBbv1
         16NnK23yCMCAuM0rG/OxIg441r/NZFHQVlruw3z34frcQ/ZaB0+r4cNpwwJ1Uz34N+o+
         POKY9snkzKFisPjns41p6ua5LX9RY/tHlJFlW0SiPdZ7HdSq1qqKPRXO1mr7E8r+0fE1
         fmj84xP9IzdwmqcDLkdaqnwyZOyH3+TssppAFt1NXvNZeVT/pMnVt8ZvPTJp1Zp0j/H0
         FmVw==
X-Forwarded-Encrypted: i=1; AHgh+RrWPdk2hPFYqcz2Ppr6DdBYeYRFZCibciOd1BACZJYA1/XIwJytAFHw4mhrZmqjjenNuzuEb0mQKIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHahkhaoF2+1VsxTZyhtnzlclKdEBm8VagyN9ejXOQr0lOk+SR
	03nNEuuX2m2JQ+kfqV90G0VbRrQM8LmoXJ784qSYuoKG6huRs4THsGKlKhJnGESYMB5Ux3o9AB/
	INrNUE4E+58gv2Q4YInltk5+TnxoFHoZdRwxaWHthNxL7Zlnll/d+GAKq1+HQETg=
X-Gm-Gg: AR+sD12voEXybrftqSv1BkWbKkKPUmMqAFye8HONEoo97kUHm7mkyJLhM6sROzZ3kS4
	sz4VLsno8XGo7WrLjVA0MjTAUiDo73/J8H3EjHQkjTLBTuG9j2IidFz9goXE+ULLLI05v7SHXe0
	HdRWpDbkZ1/0j4ijdyerwlw99v2wk+5Nm7TRlMt974eH7a3LDwoTujkELTwpzbXv1R93CGyBCVz
	bmj+OpnviiKh163JCKQixFIMH5dmpAtLagy24Q+cUZmqKB6LtUSPiY6dyuqkSIA2HM2yj6G4Vvz
	yiIT399BmZsVNjXvyieEpIHHa4SuD8T19gYMDdMvul8hw4/SRVpi0rCXmDlwlW5qthAR5R/pSid
	jJaYG9OXmWugtcmHGELw=
X-Received: by 2002:a17:903:1b6f:b0:2c6:a172:55a6 with SMTP id d9443c01a7336-2cf3481df5bmr259252605ad.9.1784719639903;
        Wed, 22 Jul 2026 04:27:19 -0700 (PDT)
X-Received: by 2002:a17:903:1b6f:b0:2c6:a172:55a6 with SMTP id d9443c01a7336-2cf3481df5bmr259252265ad.9.1784719639474;
        Wed, 22 Jul 2026 04:27:19 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e65f3sm13143995ad.45.2026.07.22.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:27:19 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:56:37 +0530
Subject: [PATCH v4 1/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-gen3_adc_tm-v4-1-011981f756c8@oss.qualcomm.com>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
In-Reply-To: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
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
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Maxwell Doose <m32285159@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784719625; l=1235;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=kmkGsqLClKltGgmx2ZFGSlei16yqugauZtjl778tICE=;
 b=pUrAWjkvl6OeiuBC9hlzdFTTXKMvK7YjJQRMmcM/adHAc5PvrD+RWIO5SFKXzgV7XScvLjgk4
 LYh7y6QOF0eChmN8nEkRjkcfntzLNHrP6bz8kmzouKoQ+j9s/wuuALx
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a60a918 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=kIsQgyr_JZXbD0ExW-kA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: nltGD4V86p-DQi47NGDhs0FZU8wAWuG9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX4kahDNtDkqDW
 vnYy1/0x0dyysQ+3Jc+SsKJ1/Mr/YXXg3xLaY1cJOgiUPCcTVXoKqpSqd0GNrPkQ8ZGQA5VmqBP
 vhCnRiUeRG5z+2uh7pBKRzLkSbyGM9kVJvQFgWgqB2KWoQ/iKFXbdhIeUAYj/3bT6AvArVXxXNl
 flAm8drKp2gBvgrh98Gzw59Xau8/ja5u7aPKxoUDttwn2mqtQ0GErqzhhl03FOMByP9yqSaQg7B
 k/oZcbFF6CH5RJYAAuccuwW7k13V8BykDw54jKJfIFOjkxLuzqCBtz/0o7ppzn6eO46FZfziJ+k
 2o2ahIVDeQq0V5oEexDQJDra+zurzJNwtvh+DP22fKUViaFzfkVlJqKlau2EXVkh7CuG2OdI2dr
 j/6Kae3YKqUxARtV0/3FFdccLh2G0rrEmTBJWRz59AQAtCG3RhC81wt/uoxvlBTWAzYrbhNPdvZ
 joL8mkZ10VrOTp75ScA==
X-Proofpoint-GUID: nltGD4V86p-DQi47NGDhs0FZU8wAWuG9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX6vNsJhURSJ7I
 /m+adNxOraRSV6pjnrL4Qt7Jis6a6cHlttENe609uBK9iT3x9WR8l8wAm7WVSx9G5tJnMem2Fc0
 H8JmDWx52+SPfwiYzCorwEM01pnghtM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220111

devm_request_threaded_irq() internally prints an error message using
dev_err_probe() in case of any errors. Remove the error print in the
devm_request_threaded_irq() failure path as it is not needed.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c56b650fd8c0..2eaebf6b34e8 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -821,9 +821,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
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

