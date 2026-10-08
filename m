Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC733A5E77
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429128; cv=none; b=FxcJjl0KOEAXhezgDbsETzXsGLatrB0Ws21dIMfHGifS46Q6g+UYAFMRxPJ+tc/Wf1bBnTLt5em76GlovORJ94k3piTgDjEMu34fEK9h4srtoqNYRH2K63IO3m92gvgzsP72LtNGQO2CdvvE3Gu6tzULXM9OG12OU4NXrKPk2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429128; c=relaxed/simple;
	bh=7ijS/TOAzTV5NWOFXokJRwAiAUu+gJlV37Lq2OGX2QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfxdtZmN8ofH0TxOJX4mk+924AxaYslWafsYDdRkkugeKsPH3eHLcGgxyojy3EcMXn0Bts6AVsMSGeRRUn3vGEmXd9l31LwKb79m0Y+cGzke4qNrvQx7wJX8kICaz7diNpjbgUvgWQ8aqTHy0cJXE5JTrrMGoJ7NI4E1fhbTAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/NmDDtE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E0nJVN/6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/NmDDtE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E0nJVN/6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hXtC434464
	for <linux-iio@vger.kernel.org>; Thu, 8 Oct 2026 03:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6wJnCzUlDD5MfrFRYrCj/LQYjXikZd2YnpB
	6KpaefGM=; b=I/NmDDtEfyXjHaRxIrJU2vf33OYKyNkTBTW27GDWbmlVrKjcJ+V
	SWC7cPerGYF0T7O2wFB9ExWunKDmnOtOm2Ep8UTr+3Fkm7db0OU5ISojhq/j1Slz
	fEHCNCtxzTG3NScs9nDLHFwN/cI4uzSxcfricN72tvPuEXkCD/m+ZKDnx3+TUI48
	9v18qIjV9tzkLXqNfNK6EPChMLnL10uUsuZNCByAdVn+QZnJTjNm3PkbSXCoMUT4
	6ch/M+LfuG3V4Mmdp/plj+alM879hKByjN0vZ9WgdfK1TTiAoYDH0CaEpXmwleEW
	jmUsOfCEPhNXLZuyflBTQdnMKe2ciwbLwVw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe38t8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 03:12:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso9100556eec.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2026 20:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791429125; x=1792033925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6wJnCzUlDD5MfrFRYrCj/LQYjXikZd2YnpB6KpaefGM=;
        b=E0nJVN/6be40qrA6j5FgczGsF83msKocRVGeZaaifk1f7cezKswO9skN9R1FXa0BO3
         yY8uOUVGMmJM8mgW7tfah60x5hozlWhvWexyuFvph0I9vaFRvQ8TDUoVwNYLOP4vhBdR
         4uR+zyQvdufaT6CfwuFDY0wb6WkdzzieSs+DlgqfEJ4Y38L+MjN4x/6weaNRQcId0J9q
         bDv4SHs+cqEwcinTxZDgojoZDMgw5c1J+KTgMbZAoxk68aHXfIsZCeQGQ8eC1jqXyQaR
         MkAsx7qPyTvEuQJGxsJ3fjkoTUbQjNGVMYRQwu1stGr5blbS5OaLYumx2mrhqnmvoT86
         auWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429125; x=1792033925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6wJnCzUlDD5MfrFRYrCj/LQYjXikZd2YnpB6KpaefGM=;
        b=tQWcfEC6IF7CmhZO3fTEyq9fXgOMZYZxsQnGva/IKYsCgRHpbClu9AUVh6HrKtMLX2
         96p2fI9zt67SIJWYBYXwQEJmPXXmoZ8sLfLnLfEs4jXw8XwXTC+WLvZHO8IQj3x6/qdh
         YVcXB6E1ABjQJy0VRzNZ5l7eus47e9/ZfCViHJi/dAdusjQo9OeI2tvMDjPq1Aq23JsK
         tjyrqIZh0Kkii7A/i21fUd0Bq/wG4sqtWF/iVG7i6/eYexX2xRlFMxMie0/wfNQojBve
         UxSgKhWqCWzLcbOZhsgeJYnnzcwl10VqBo1fs8VLIO0XPZFLjMM52Fo/uhLBBp4CA+Pv
         w2nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxW+D/kJSRpZt+2F/bgn1yZc4334FWjloxs1OsISiQ1jIvSgZQXrt+owsOgY8/dMFpqJeLL1QUQvto=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuHP11CoqaHlJbpXmWjpdcAgTDGNujdjMmACwv+/bfIWw+keRP
	IYQUPRnG5MOOKurL8H7+oleY5hpXSBvwODfJkg02oOL5J37iJs1YvgcO8WXlNVl/tcm6KvZwW9D
	vhi/ObJ/pq6FxBuA/WGvUzudwOoHQFTBIinTo80wgO+ZiJJ4bisEx1BFvf7ECTHA=
X-Gm-Gg: AYBFou1wfnE+pCpKnvQ+WNaQvXT4vUZMhO3b+1c1DWS01ZeyGsKJnkBhrlLGdFg282j
	AtndEr0amyN/RKyVxbuXrby7CvtSVCeR160TtfwCHlNDDUV3xOPVcOT7SmT4Suwx5QlsLMBhI6T
	gUoxksqY3+ctplVJ5uFNvM2YMChoKEOuOM02HbxmB4NxgS0+6sHaKYaCRCvbHdQIv0RnOjpHWvu
	/UDmFw5RnszMlIOzqdslRtfdYyDLRqdVO6m+UwgNSHMStGWxE3KODYEWq+oT+NqG/V/MFwBPX49
	+5E4bt0SygdDq1vZHKgEql+zU4kE2IHdv0+oZ4xkDxtxBiNIGVmPz2XVBa9hZF4kaOpNK6nrUP9
	Y8jULgIQ05CV9ulZEmhzgSxjc4MvlHoDHbGXgrQehbUpPBFM6YZgZSzSO61M=
X-Received: by 2002:a05:693c:6391:10b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-3515da5dd21mr4625781eec.4.1791429124738;
        Wed, 07 Oct 2026 20:12:04 -0700 (PDT)
X-Received: by 2002:a05:693c:6391:10b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-3515da5dd21mr4625725eec.4.1791429123893;
        Wed, 07 Oct 2026 20:12:03 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afd00e0sm12179530eec.23.2026.10.07.20.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:12:03 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Dan Carpenter <error27@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM aux device IDs
Date: Thu,  8 Oct 2026 11:11:54 +0800
Message-ID: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m2R7rPkXZf7_AoOGT-iS9DyJ5JkYDaQi
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac70a06 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=izmiiGAzHhnd4z7VojAA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMiBTYWx0ZWRfX3Z5dYwRvBqhn
 1oUgOX6Ym2OymAA+jypaP/eePyqFnJV2okn6sM/qcQK9hfl8VORgSj0QZiCnG6c8xJ0l9sVWWPV
 PuBaYXuQnSJYxFv6mpFEdTixO8LCyxY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMiBTYWx0ZWRfX3AFDR4FXrZfN
 /jl65O7+nPXkJxpw/qiqvwpVtpPHKPhiZ7EPH3btX+vqWjAZsHoO5o+bJk5Q7oh8Q+JRwIc5xGo
 W65LWQaO2DSjPNLQGTlsXuFxBHdDkRp3orsoZUPxaJM3/bW6H2njPplr3pOE2e8PVw/m9XoI51X
 +PpHjybxtURzP1ZR72E0iKfo6hJXGDmsfvRX3dOjc1N6oGwKWkS1zk9gEHCSmh9zeIk0gtu9j6U
 EIOpeaxz/cKDb47zQjOg2gbS1TWgn2Pqv81olAMHLMr74/jzC3XsxgiJHXViDNPPSBmDXOkBJiu
 CxVnyVHnmBRLru5ENSr0vSGoZemf2jBHHq+xwqa6cxJUBj42+N0fhfQaq0Zvv2nCNjS2MDeVtXX
 m8okyErQxryZJl+D8Wm+JTW0BerlgnfYfU7zV3tHVfzQ+EYNBFsrpFO1MIF/XCIXcV0B77l7Nk3
 dYSWXSf0bJMS91tY+Jw==
X-Proofpoint-ORIG-GUID: m2R7rPkXZf7_AoOGT-iS9DyJ5JkYDaQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080012

adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
to register the same device name. With ADC_TM channels on more than
one PMIC, the second instance to probe fails:

  sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
  ...
  auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
  qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device

The ADC probe then fails as a whole, so that PMIC loses both its IIO
channels and its thermal zones. This shows up on Nord, which has
thermistor channels on two PMAU0102 PMICs.

Allocate the id from a driver-wide IDA and release it from the
auxiliary device release callback. The ADC_TM driver matches on the
device name only, so the instance number does not affect binding.

Assisted-by: LLM
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c68c6c5f6aca..f0b2544c1632 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -15,6 +15,7 @@
 #include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/idr.h>
 #include <linux/iio/adc/qcom-adc5-gen3-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -608,7 +609,14 @@ static void adc5_gen3_delete_aux(void *data)
 	auxiliary_device_delete(data);
 }
 
-static void adc5_gen3_aux_device_release(struct device *dev) {}
+static DEFINE_IDA(adc5_gen3_aux_ida);
+
+static void adc5_gen3_aux_device_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	ida_free(&adc5_gen3_aux_ida, adev->id);
+}
 
 static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 {
@@ -642,9 +650,16 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 
 	aux_device->n_tm_channels = adc->n_tm_channels;
 
-	ret = auxiliary_device_init(&aux_device->aux_dev);
-	if (ret)
+	ret = ida_alloc(&adc5_gen3_aux_ida, GFP_KERNEL);
+	if (ret < 0)
 		return ret;
+	aux_device->aux_dev.id = ret;
+
+	ret = auxiliary_device_init(&aux_device->aux_dev);
+	if (ret) {
+		ida_free(&adc5_gen3_aux_ida, aux_device->aux_dev.id);
+		return ret;
+	}
 
 	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
 				       &aux_device->aux_dev);
-- 
2.43.0

