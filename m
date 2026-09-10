Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8968503BCF;
	Thu, 10 Sep 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061857; cv=none; b=Q9f+ftyiEgqkxgWiDEhfwRiuBOnIshLmQ8Mjlw20DHp37gNOx0MgWzZndeOf4Ei1xgq6Us2UQ4m1z6n0rG8IJxQ30/EhbmzSFPAgzKao4wXAW0vG1HfEED80Kn3sol4H3BqWFQoc+27opJQ/Bonjj9TIoUqc0j3kRQEj7jCHA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061857; c=relaxed/simple;
	bh=h8rpUQCVfSyFWZ0W5MDo7rp1yKN/O8pCD8GN49kfEBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uJEObK1YMFyFP8d8A5h6WHohKMUNcOdVbD9/wtxrj0zJQ1y0RAcxcHs4GhJxm26NTv0ANo3FFM+AH8wDpXd/blvWnQETOHPJEBqionxBYLSLIxPRHCRDN7DYbYqsYq8BUbd6JHWQ9Wb2YPEiQ1wzF7u0CoVDzgKbk0D91T4THJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=krU9emvF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="krU9emvF"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF80xW3830389;
	Thu, 10 Sep 2026 13:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HaZi5
	4XuvSGwwXAOvLRMGXBSqS/rduiS4tFlnN5D9gU=; b=krU9emvFdwxWZ9TwT0X0u
	LVmLqwyEgGGMKtfU9v0kqobGjwVpTsNJixJGqov6C6hQKxUTrGBBgIpdRhavoq7B
	LFfFjGAofb31WNJqGCIUBhc88sFGxGAKZVJsNDg9mzObwWx5mbvhmfnljA9piX84
	+2ljCgl9hPVlGUspMeWYvwCuAFwOkAxl+EPG+1PdoHFw3MoWlXes3sG2Ii9ZxiZv
	3IwTiRoWWzUxzbBi4lOqfdGwp8dgIcntV5yOoJruDinQai8ATBYqqRcBV60MUrEu
	dChlKiXpA2Ad0RGF8CvCCA/2dBXvQv5Sg+c1quU9vmG4x3d0smNe96l//dZS8uXu
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxad2cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHb6pZ038770
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:06 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:06 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSZ018832;
	Thu, 10 Sep 2026 13:37:00 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:21 +0200
Subject: [PATCH v7 03/17] iio: backend: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-3-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
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
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=3821;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=h8rpUQCVfSyFWZ0W5MDo7rp1yKN/O8pCD8GN49kfEBA=;
 b=IF6o5ZHZVBNGG9RIMjL0nKvFMTrnN5gZcCvqKOyTMHMd16s5aHCriCaomTcwgIxkUXNY6MLzg
 OhjiS3BSl/wBukE0/OAKkCJgMXQSZWbX7jkCs/wIXzoMAZ4RskMwcNt
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX5wgg1DlnXUni
 a7tc0s9/2ftrTFc99CKs/2z2iGqUGy+Rkvb8jxXFdmCTJM/i/OCMI2sbw4ZEGYgghJWgfpu7Ypl
 2xnSYfGp71s8Qr8Eabi9yM+611KcLUhukppn+bfNTfW9OEpmXlAm
X-Authority-Analysis: v=2.4 cv=Ao17T+9P c=1 sm=1 tr=0 ts=6aa2eac3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=O6R5dNVUA00TSld12QQA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: MKDThIqtr7XmxGEUvr9pt0L3pv_phg4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX3jBzA4ZRuQqg
 9PBJuOilokVcVtFx1vae7W9Q+crufKGuhqGX0YO2q9sRxjnEKpCmMQKgJglZanmTwXsiAEFpyJ3
 ty+9A8oNpFGw1SEOBLXoISbo00tQ4qoDUEoHzaW1AkiP2K69Zpc2/wjj7/XGfki/O3ZI07HRiA4
 ryd3LuBauMQ8mXqq+rgexVQ/oE7eoQBBVcd4ChUKsqMRQjqriIYSx3SilzCnKDbPhNsMBWGmk8Q
 xX+7hCmEnl5R0ctrkgyFSJVc2zuJOJWgv7camhcrYqzPdIdkQ7QK+zTOJOc2KAdNyjx15nM2J3d
 emHmjrloxCT3UUSTDWBBSlJ6iEsRJeGDqOVPfL1nJSOXpK1n9D00m6y6kb1OPz2ma5b97HXlmVW
 WyWoagbNe8bgWDFWDghMNwFAODhJClVRnJbIzjew3GZXeC74da9zul+0k9u/eQN9ZmtQeaAh3An
 1PkhqzeMBaGMm2ihJkw==
X-Proofpoint-ORIG-GUID: MKDThIqtr7XmxGEUvr9pt0L3pv_phg4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Add a backend operation to enable or disable direction-specific CRC
handling. On input data paths, the backend handles CRC data generated by
the frontend. On output data paths, the backend generates CRC data for
the frontend to verify.

Reviewed-by: David Lechner <dlechner@baylibre.com>
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

