Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04804CA271
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690673; cv=none; b=P8ZMvOT83gnc1c6XX+kFcB65inN50SHUQp2bLvf2Grqo0iz/MR0C2Vkuz0s70pUmHLGL0Tm/W4B9iupTDkU1+Bbv2jwCNfcT8ZMDyoeZdQNGipKtg6IVygBZu/XOISrRedxV7o60f//AOCWr8SkO8msO21yX9gcJ30esSEwe0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690673; c=relaxed/simple;
	bh=hWTJ66ICrMMYPDEetoAigezffDe9LGu5ZAq3+pTYj0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W94xeqqZbjcsv4OQT5QVzxHRJ6k5hxSHsr65H2p8e7hENt+4hkVX6qZstNn0VnBWB+JH04aqDfhqrSoZwV5xnM1PV00ThvTMqM93qdi5TKSUduemBCoPPdglmnfGvEYRlqlKo1eQK78dl6xABJRax7F7aFq3NbzGrNuDFNoomyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WYPu6k/B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cB91NfRx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WYPu6k/B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cB91NfRx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DG9vNS3007206
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	znMu0JYE14eDzL4+1yCaxtsir2SCzQ58yUv1qQfzVrM=; b=WYPu6k/BQJNW8oOg
	bK051FHeGpoAigfOiAPGIvuNhcPXe0hQAIseeH7jeNpVOEiS1Mml8cee/9nyGzWs
	IKxTuDNZS45J/rydoe71x+OslrZTel6RCOzG+ENEc7AOAGV2yNPlvAb/4Jzd12Ed
	tDVLRDZ4ij38l1AoPgCyFlxdyfm/m+EVnwapvj1bRiuPue1ErB2uxk/M2HijhONY
	qTfN3altQ+N1146Lx9M02p+EIUIDqJRoFGAVxpRLQ9SCcoBsVFbNtPt8hNSOvQY4
	l+AbNFMikchb7/che9f+lgUe15nslDqkUbTYsD3iEvchcDlvy/sOBRqjQYiJ5htH
	FPyydQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0hm08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 16:44:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bda35eab74so5485502eec.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778690670; x=1779295470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znMu0JYE14eDzL4+1yCaxtsir2SCzQ58yUv1qQfzVrM=;
        b=cB91NfRxy1WY4M4S/QZitCKxLeV7Ymzedmpq7SS7PI9avFiuRnUqC1TV1j6izg/cpV
         msbKP4RFjj8eXQ+45rVzbfFouYEFEDmnEGP450zp4YrdNmZVk/1IyTxvNwm/GB1VdWK7
         6fvYjDQhJSLfVNUCIax7CqkWXOmAdxF+QdJg8VZPtdnefVsM0v3nOUyt1O7oTJveMqxk
         qCn9WEgdF+K7S1brs82d0e4veEY14Fs6QFcqQeQiQA9kiouA24fA+xTreY8Mgghl48Ea
         /jF5OqnfEo9PTswMISHfb7VKiSIGgOqIYcCZ8sN3YRWmJg2ikTe8+GA0Ga/YXbCegwyx
         prJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690670; x=1779295470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=znMu0JYE14eDzL4+1yCaxtsir2SCzQ58yUv1qQfzVrM=;
        b=LSs0raiGPYQMV06DKehQAWSjKWomFH33rfr1vYKa6qn+mLXc4lK2L6T+zy8l/5V+lQ
         lpRMvy2QVDTcdIfFmUmfeKg83X2aUi+nPtQmIOl86mgNkDMeYX0HuY3NNaz1hKBKyeI+
         SRqBu/5QK/cbv6U0Jv5W0hf+34IOjneQOVvmiSA1xkuIpwnrh5AnsV5sS+FcKtW3ak+R
         8V/GRMbLUOvnF88wGalu6LnBP7wN8Yr5nvdj5tZC5SPU9+S8xc50WLHvUcqvlTE6gkuE
         9A2NPxcUJ419Kw9zVm7076+KSjSfVSZI2laS1rROQJ6u0FtV1iWN0+EhcTu33COT6/Yy
         BBsw==
X-Gm-Message-State: AOJu0YwrH80djjFjcH2/020h8kEICn52HSobisXrD+YtBAcD4LkgPSvP
	jZZ3d7GUK6DsY9YBxb0EQ86w2cTwjHup9SI7JBE7t75l/wJFC8SHpJJJKn9AQAIqgZjDLtkRI3w
	+tF6vi7a/t6pSfuMHqG8sS70f4PU7cMkeUwWr6WJSv4Ft2Ktr7ML4oLEk7MjXX64=
X-Gm-Gg: Acq92OHg5zKu5acsj6naiSAIjPxpx7glumm3QhH8PlM124F9kjR3K/lYPPk/hH3OYNK
	a8lQE6e1SR6F1V+ydCDenuCkn+G7ChVy5/TMN8ROhxmNWMqwA2uDUgDaQaJtAjIaaOD/gTjb+NP
	ptXhEdt8oHYT2WXixGjWh1KUc/3St8W/96h9a0qEdhPgYuXw35rhP04qmSmQcJT/f1PtR+oSwOI
	g0uspgNf6ZSZq96DZZy1EaixRxUSoYPgVfLBi9+H7veL/PZ8qA/4/CjyPEvlO6it6L9n0yAMOg5
	xyyMXpf9jwV0DoV7NDgRFLcLt5esUE7qFc9JJ3mOjUD167yfvwSxPj6jy5lJW1eeCH2lndM9Cm1
	SSwJP8gG2mAlfdnxriX4qSeBOiKNivJ4Me9vOiO/h+277nLUbXsrpQOrA4W7vLQe/s3NpniU=
X-Received: by 2002:a05:7301:1294:b0:2ea:ea7:480e with SMTP id 5a478bee46e88-3025fc493admr144418eec.10.1778690669462;
        Wed, 13 May 2026 09:44:29 -0700 (PDT)
X-Received: by 2002:a05:7301:1294:b0:2ea:ea7:480e with SMTP id 5a478bee46e88-3025fc493admr144398eec.10.1778690668884;
        Wed, 13 May 2026 09:44:28 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm22570076eec.13.2026.05.13.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:44:28 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:44:20 -0700
Subject: [PATCH 2/5] cpufreq: scmi-cpufreq: Log number of perf domains
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v1-2-00b47b1be009@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com>
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778690665; l=1078;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=hWTJ66ICrMMYPDEetoAigezffDe9LGu5ZAq3+pTYj0U=;
 b=dKt2ltOsglRwirWV/VFgytLio3t+0trY/M1zjyG4lzrU8COWFCdYDtyNysYCuSfhoFQEYkG72
 wGdFMM1kbfEAUr+QPv0OImnPdu41r/pDiZbC4NCgA6VLy0lrdZgwyx2
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfXwLmKsXk9LRlA
 fhrbYY94dvj/u8IcOYDqlA1AZCurol3W26kE+hAO/kmwoWxYUoDHFbyumRGbm6pIvkS2Fz/GYEu
 E1J/QIea5MUJ6k1u2dsQGPmPYwXY1lAAybJbJlwF1zuU40JaW5GDnsr4QvQEhMwGdfXF18nrQZz
 ILr8yZ0UTSpnggakuc/lNMmoCActlZY45DXRghq191WWq3SWCIkm+6iK8QIJ+e4qPOiLQAmVWpB
 KwOofi9XW4aV7MoSdiB5Lj6q4a4mjeyQRhstcyU6GmDpMOUcHbyFqS59zcWj5mt9GKyAji3xKEg
 y6o2AuWEiK3V9230lWgYBg9hIOV/ODljj8NUxWJG/79XeckYAelKFMlV5dZgS7N15NYUacvmNR5
 eK1dT9QhxLuBkgnDzXI/5nuGB3j416/abpmpEclpMKb7VOsBcvu1brAYNskOA0f9JglsRb3TLpn
 Rnenx1f3kM02tApGQ5A==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a04aa6e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=xQYt0fwn8ryh7dGzGRYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: UOg70P7ttT2fu0hsoenIcG5SyKGgy1nf
X-Proofpoint-GUID: UOg70P7ttT2fu0hsoenIcG5SyKGgy1nf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130169

The SCMI cpufreq driver does not currently log the number of performance
domains discovered from firmware. This information is useful for
confirming the firmware exposed performance domains during debugging.

Log the domain count after a successful probe to align with the existing
SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4edb4f7a8aa9..d5c33eea2477 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -468,9 +468,12 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	if (ret) {
 		dev_err(dev, "%s: registering cpufreq failed, err: %d\n",
 			__func__, ret);
+		return ret;
 	}
 
-	return ret;
+	dev_info(dev, "Initialized %d performance domains\n",
+		 perf_ops->num_domains_get(ph));
+	return 0;
 }
 
 static void scmi_cpufreq_remove(struct scmi_device *sdev)

-- 
2.43.0

