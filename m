Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2A33ADA0
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976986; cv=none; b=lLCzBrwNfvcfsnCFjM992z6Y1Ye8os5tfXkIUSNZ0EEOJ38OciT5B7VlQwt66w9pSHQHzeEC8d7h0NHZldH4RHmMHfr0IWoQiSE0fV1tIEEZBKFWCBbcFU7OPRq3VrWspBmzKkzcL5qUGhRWN2KCRCAMqhhSrmIEpRcXk+rB/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976986; c=relaxed/simple;
	bh=jS089ELtm2QzfXSV8OfQ563Vgx5vPSjMlEw4JwzczPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmuIcjvSHjgY6WiDrJLP/zeCyq1ES7eLUOFFcLCrOEkzh52wbvpjLWQQWtp5PsrfOfIvcQpL2E5sq4wlf+4//gRPrQxHd0d0aGYJ7hzLiYoO9yOdqO9jjAvNAL9uKy12zf1L5vsIFll+tO9nAiS+Rx+xxrC+nf1GMCFoY4Lfwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PZJN1zhj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P2cfQiXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PZJN1zhj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P2cfQiXF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6458nUw51346361
	for <linux-iio@vger.kernel.org>; Tue, 5 May 2026 10:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=c8vs4sFAOKlAev1xa/BRBV4g8Jtl7V3EYc4
	+dJfCvf0=; b=PZJN1zhjME+yMGFudyLCmkHIS9H+LcJXTUr30Aisa4JjTDU568f
	UfCNoc938PxT2F2u4Hpwoo1xTNb2nOn+e/TQ3gh6JF4WWrhJ5R0tvrfEmijfo7aA
	guGIYTiKx88kdK0bO3qEATi1mydQ6xk04XZja++dI1WPQXCSrBqd0umFD/trt3d5
	IJZxvRAjM6nEwtg1sYSTBszgN93J2c1OtVI/8mz/7ynWBzjBzPpT9NMW9X0KFCKH
	WwtDxY/EktOQINzo2kZGLXh93ViOagyRV9pw1HEGR95Hnd15PfK7pnd70RHk3Owp
	ZrQbbs/e1nk7n5IgandcBmBx0fOoWJTF79w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2xbkyh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:29:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51306c1076dso19810691cf.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777976983; x=1778581783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8vs4sFAOKlAev1xa/BRBV4g8Jtl7V3EYc4+dJfCvf0=;
        b=P2cfQiXFf6crw1SHbF+qQ4ya08MHEIIJPluMSM9ou5hVOXVOtfOCE8mBenfyJb+5oc
         rw8voVZHBiiUAv3qTxnJ7g9ZAf5qPfEbcn9LnRbuXGgMQuJ6EwnIFBNQHEgc+XF4+CV7
         U4cYHT+X0O1hfvvZdT/cAYzvrArdU2QskrQ3XMNqxmPqu+WtDGn+FtJr9tQlqTw6PwDG
         UqCZWfTSehUeQuNjPPNR4sJeErpv0JDd5eDf/lqf2S4JaRlZzWYodODh0FNdZIteZvdq
         ayyKJziNgxG4lbzhofBPONVD4n/H/EkCEWbMLx1nib3k/T+xAlW9ayqaAD5vfdyABW/l
         uqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976983; x=1778581783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8vs4sFAOKlAev1xa/BRBV4g8Jtl7V3EYc4+dJfCvf0=;
        b=Hl1HY9SqRGCl3Cr0Mq1LEsbfU4USHMCJ+bRFaxMjVAScGTdejTtCozMfk/1POuuDk0
         5hcio3u03TIjE6bUbSNlbd0W18xCg9CV7jmoeawhvK21ulaGEHThQddRbiJKJE2O1Ax1
         RZWrPsCyb9F+L1M9FuLnEiRZa1eqpu4wot83/zth6QqQusYq9Bp0HNZpA9S2mWBGWC3Q
         BsMLCTtdgAECOZMrHl191/kbqITQ6IEoCI2uVDMfDNCsScIcASkLqqa8KgyRCGvatt6l
         qF62vqCAHwduGLYFzcXLcd2ywcC+ZbbH/vswBJ/XfIidRfxcn3GbWl6+yDZBU4oUkgjY
         DLHA==
X-Forwarded-Encrypted: i=1; AFNElJ9A9Ju/5abD6nNezSrV8iSFywzF//40Cz+vZzlecf+/S9pxiBJDzXSfym4v+DpIcO0vKNh9+9USvqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjT2SD06cBMZXklSF+kunFeNxb+hWSvmpNanVZB/HdEw4xVMla
	SffneVrgD2RNEAnOmzmqCK1Qb+OQObpUiOM5rO8n4LMmo+jRsBpc3ZxkfR882Lx/e0Tsx+dzrHr
	Q2IM8FLFGY2aqTFyKGaEhgemU+eDaaD4yz6uHC/5sQmjH6TCrLHY3KPVabZ6FHXo=
X-Gm-Gg: AeBDietozXyXlkaoNnKKtuvfaaEnk51HWKyGtExnMAxCTmrtY7sVftkImU5td49CgaR
	Q/8JDRzDW8Pf05+2a1qvsEmWD41+BZJTPKcdQTKLsGtbZW1cbKyYvUMg1TaPbFqRw6E56VmCjDZ
	SEwfqZermygq6iXN//uC0FgPeKF7MB+46W6yU4G4ruxuL1boq4lGdY1Os4sO9DyQhHAA7It8jo6
	5xedgGGy2IaSKJceuvy0+E/ptCDzGepkLYFCzpGhG3dS5litsJIZhyiKwbKOn5Je9UTzzEAgrSy
	qh/X7tqul3aYiKCgdg9Rt742mIJKHD8Wmo4D6/mBFVcK8RgjgLEoqTPcKUu4cKsX1RFYwV74umj
	n+05nB37yfL6cNpm9S9E+Au4cPeIFNAtXw/V+zpWCD635bBM=
X-Received: by 2002:a05:622a:150:b0:50f:c26d:f314 with SMTP id d75a77b69052e-51306afd1cdmr33602091cf.57.1777976961541;
        Tue, 05 May 2026 03:29:21 -0700 (PDT)
X-Received: by 2002:a05:622a:150:b0:50f:c26d:f314 with SMTP id d75a77b69052e-51306afd1cdmr33594881cf.57.1777976949956;
        Tue, 05 May 2026 03:29:09 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm3577595f8f.27.2026.05.05.03.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:29:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] iio: Move MODULE_DEVICE_TABLE next to the table itself
Date: Tue,  5 May 2026 12:29:04 +0200
Message-ID: <20260505102903.187598-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=jS089ELtm2QzfXSV8OfQ563Vgx5vPSjMlEw4JwzczPU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+cZvUsy2gaKrlq76FtF2AJjLo3XgY75GPz7Go
 FgKlnXycgaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnGbwAKCRDBN2bmhouD
 1/CYD/9MA0ncvB6LdRFlc41J+ktDxHQAnkN9N0lnZBIibnzbdk7HKjnuzmFkDuxfmrMN/POFhKB
 buYyfU3SpxSGEO6mHUbSwkok9eU/W6/4TKVBSnhAnAejXhODroitNgyvzPVDHX4FrxOBlgkxXr/
 M+EL1b/yw4YEtd8EnG6A70UXYqVkXyZgYykFn3kqUpNuF3biz0A8G/9kHLHmpzHbpV+FVyj0MHO
 ChijaK9xFaSc+pCfaa2Xz43ovUWeVqaqddltiT7ibSCqpov+MR7pDveKBVmMqyfVcbcZTa6U5Kd
 5AGTwmdmLk9jqXioQgJCBKEttGJ20UNSZgabDLqStmraInrGG5M2x63SHlOwqwYGnpt3IN5ICK/
 shrgtxuxM9bOQjXgH9g/JwnYhPwGLCsE46Vd+43wh1NqtRA6kr50UFwKRBJZWQDmcq5layoUCUc
 7Q9Jls3i9Wn031Um6FKhlc5pmefuALwvmA81M3AqzgTZ4GAH+pJJtnkxfOZN4YPfCX9l8kA4y9H
 6LV4I/hbEXIOaL6VrxenHLJJVWslTLP0tna+3J9pdJyYX7577jFWGYyIJtI0oSkreEhrEFQXxC9
 0icgHMIlajBJCZ0vrYaBTEOFbT+6X3LAbEh5Dhv4FI79ewVaw3Kb+MC/nFRgXxivNzOBBYjqzbQ LlUusLES8TnBiEA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f9c698 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=BzP98TPolLMEYMmIy-QA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 8x4TN6HickJIstX04Sz9ho_hT7Hsw9BD
X-Proofpoint-GUID: 8x4TN6HickJIstX04Sz9ho_hT7Hsw9BD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5NyBTYWx0ZWRfX6z3Q5vW2p4G+
 9pAiPNAWFlyfVSKaIbN3wa2Hm1Jm4QaqMJMoiQiKZXQjNi8V6rDfMVZuTNWjZt/kDRUwwyXYTXC
 fbKdQn4WTW9qTJJ80gZ+R5TMVAYFhtdE6dkF2cauFpTt/zg7TeZkaYJQRtIP5fXpcZP0d93pgW4
 BCqet/ecwdgWdA/oS0pidqLV2J9IQznFYmVDrsEyJjIz4Z5gj9iIgQg6vkgliKMU5VEpQgD7L9X
 ufhTqgQgtfmFtqqG6VEpoepbd7y8Z/uQBeEv7o1FLvOaLEHt1ixiv5JHgbKUraY3So/i2ypnwqP
 ica4VxINJo+2QuFXNuJuzbOMS9hnZ9vetBGGxz8YJ+da2CYVAp62Pc6de8+bVIskBzkO95M3jBx
 hRvZK7lTDn+9T7wWPeLvKhk6riYYahZb7+6ZbWKHwfeV43tNL6WILENoAL+UGo8zHaXqDAkhszj
 dOVpiM4qs2ruSf41sBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050097

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the privers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/chemical/sgp30.c | 3 +--
 drivers/iio/light/cm3232.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 21730d62b5c8..d42b62b7081e 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -498,6 +498,7 @@ static const struct of_device_id sgp_dt_ids[] = {
 	{ .compatible = "sensirion,sgpc3", .data = &sgp_devices[SGPC3] },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sgp_dt_ids);
 
 static int sgp_probe(struct i2c_client *client)
 {
@@ -566,9 +567,7 @@ static const struct i2c_device_id sgp_id[] = {
 	{ "sgpc3", (kernel_ulong_t)&sgp_devices[SGPC3] },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(i2c, sgp_id);
-MODULE_DEVICE_TABLE(of, sgp_dt_ids);
 
 static struct i2c_driver sgp_driver = {
 	.driver = {
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 3a3ad6b4c468..90aa77e3a03b 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -369,6 +369,7 @@ static const struct i2c_device_id cm3232_id[] = {
 	{ "cm3232" },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, cm3232_id);
 
 static int cm3232_suspend(struct device *dev)
 {
@@ -400,8 +401,6 @@ static int cm3232_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(cm3232_pm_ops, cm3232_suspend, cm3232_resume);
 
-MODULE_DEVICE_TABLE(i2c, cm3232_id);
-
 static const struct of_device_id cm3232_of_match[] = {
 	{.compatible = "capella,cm3232"},
 	{ }
-- 
2.51.0

