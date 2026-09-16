Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62913A16B6;
	Wed, 16 Sep 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557338; cv=none; b=IdguL0OtHd1o2PkY9Cq9FDlcTmTji2q1fs0+vFyhES5sgptPl81uUeS0gy9AeX7k8nX/wo4tHSHnSl+t/xrwEd4gAV1Tchrypr62YToVhWfDRvWkyBQfpEXtVKMIayN0YRCQE0VQHGtcO1DkEQgHfPGG0zxDmRV0pal9XGwOe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557338; c=relaxed/simple;
	bh=AtIbg8slCRH224KZAN2MEN1GddYDCLINbqBt582jriI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fM42VBUK6/QUetrJu4drhn/3GEtAlC5bCbE4iDekjkkvDvKl6x+h5WgHzXo4iANsyP7RIv8yNEEWFYKNz1zDf7Ha8pQCJT9+cdMSwMJ0nH7Kt+CHlO96vW8AIlWs/AOvm814z2klDhjPYYjytYx8PJ+nL89t98gHpH0JbwInvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rto3Edzq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rto3Edzq"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GAV3p02061986;
	Wed, 16 Sep 2026 07:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9C6wH
	fWhFLIemLfk6ZSPXF6LgfciTrtZWASZ+Yy074w=; b=rto3EdzqP4hvud4/WeXfz
	EdylOBIqPzSa1QepUmHPbVfamcUk5e4avCc0DQR053OpFliOl304QsTMkKAhg5gr
	6wCNqsE0+Cd/y2UNXq4NzHyRVjb0p9TXaUvNgRDIat1bp7tgrSUls8R1P+61fCnf
	QHhcFjWEXrdNDVeU0pso0jZ8N1vDblXiiORj7VA0MmyRU7Ybc+KDL9Ps9u4VrBA/
	SiItN7YsNBcTRXjlAMF1bsJRaVWhEO1BaY4/p6MOXGno+F2r7T9XBnecdPHGMWDx
	rAYnFM69mL+iulmoo9p3wC1LYjXreT139JnECrPTkee9pNpfDINaoYytqhIY/2Q9
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq43rp8m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:14:57 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68GBEuvB015738
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:14:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:14:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:14:55 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENDt004263;
	Wed, 16 Sep 2026 07:14:50 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:13:52 +0200
Subject: [PATCH v8 03/17] iio: backend: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-3-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=3881;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=AtIbg8slCRH224KZAN2MEN1GddYDCLINbqBt582jriI=;
 b=Uj1Y1bzm2lqj4b+ymhykqfLmM+KOwHLXnWT+vfukNETn9ELnM/wbRbD3v960ud4l7hO0R/Mee
 ZFtejD6dUshBK8afwd4cwoiZSfw1ZvXKH+o5vIS5GCGT3Vc604kmEMV
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: WHkOzN1Kc2IiVoSVH2YqcO-LBIXymYj5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX3BtYBq0NF4i7
 QKopMBEuQGR+ADHyRZk6gE1vj6TsBMJQ+I8bHXCdPno0UZUyO32MrkuLlFv5mpaf23rncIj0TGR
 SgW0EcmWXj7HpUz4DTfFkeWoeLuj5b8YpB0j7TJHyRCRZj/z7Zfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX66moTjJKJEI1
 +sCNIB/ZEs9IzuWpwoXm8OgdEMGgKyiTNJP7sbiHX7HUBVbaZStTpZFCz2noX5HDOHm9uZTnEEm
 APSWTHFysoV06o2UI0DbFcwXtN6U5zSa7+pg8IxBg36kgNkrLSYVgZQRWlf0uEds+VD2O8tf8Hq
 lX2QJEjEV2Q3t7a5jnivCmbsQvLgQx+2CntLhxvGCMCsvYMQeHR2twhaT6Q/1Q9FrQ0giQZtYLQ
 ylHdJda05sWY5o5XZTavA8RKXJUEY+0MiGL7cCFW8TeFPU5RU+v8bIYG6ACLrjLppFGql/cDP2J
 icPrhDfgtKdxvOHEreGe1lO89TKaD0WkStWJiVEW5J03qRF8p4ymdJJU94ghR8kqATDktya29J2
 SBInnmEC+Fsk2qiEoc4ahl4RS4gtzp0EiC1m5FlZ8qJBqiqNyej7RvPx8AvyH8n7gSZeessdW5L
 /8FQhOFQu2MwrTDUk+A==
X-Authority-Analysis: v=2.4 cv=HZeB3SE8 c=1 sm=1 tr=0 ts=6aaa7a31 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=O6R5dNVUA00TSld12QQA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: WHkOzN1Kc2IiVoSVH2YqcO-LBIXymYj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Add a backend operation to enable or disable direction-specific CRC
handling. On input data paths, the backend handles CRC data generated by
the frontend. On output data paths, the backend generates CRC data for
the frontend to verify.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/industrialio-backend.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f7a4be8ec320..fbf5c39d7655 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -886,6 +886,39 @@ int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_num_lanes_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_crc_enable - Enable CRC handling
+ * @back: Backend device
+ *
+ * On input data paths, enable backend handling of CRC data generated by the
+ * frontend. On output data paths, enable the backend to generate CRC data for
+ * the frontend to verify.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_crc_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, crc_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_crc_enable, "IIO_BACKEND");
+
+/**
+ * iio_backend_crc_disable - Disable CRC handling
+ * @back: Backend device
+ *
+ * On input data paths, disable backend handling of CRC data generated by the
+ * frontend. On output data paths, disable CRC generation by the backend.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_crc_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, crc_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_crc_disable, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 3f95ed1fdf9e..9c16b695a602 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -133,6 +133,8 @@ enum iio_backend_capabilities {
  * @filter_type_set: Set filter type.
  * @interface_data_align: Perform the data alignment process.
  * @num_lanes_set: Set the number of lanes enabled.
+ * @crc_enable: Enable direction-specific CRC handling.
+ * @crc_disable: Disable direction-specific CRC handling.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -189,6 +191,8 @@ struct iio_backend_ops {
 			       enum iio_backend_filter_type type);
 	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
 	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
+	int (*crc_enable)(struct iio_backend *back);
+	int (*crc_disable)(struct iio_backend *back);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -237,6 +241,8 @@ int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
 int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us);
 int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
+int iio_backend_crc_enable(struct iio_backend *back);
+int iio_backend_crc_disable(struct iio_backend *back);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);

-- 
2.43.0

