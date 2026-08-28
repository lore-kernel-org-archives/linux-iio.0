Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CF360EE2;
	Fri, 28 Aug 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931076; cv=none; b=SLmZACj/N2OIj2Dt9qtaEQ1JJAMx7wuJ5EocPEcf2pzWyLD/p16C0cdxF6+BMEanqvnvLrdCAwkaUIqDOawpXymdMOjvgaYpWToVZ4CW7KnhZa+R7S9WblIhcWtJzKJFVw7XvMcm5Vri9vJdUj6eozkimQ8ttJXJv2HudXkUsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931076; c=relaxed/simple;
	bh=h8rpUQCVfSyFWZ0W5MDo7rp1yKN/O8pCD8GN49kfEBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fIp/r8wuq02bO2Tkon8khErKk4hYQ5lDproMJavfJSb8LQS1TEL+GQjc5gkf7ZpU8PXLp0FhRUEMR84hOJPd/QtghkY15+pk42jCAFaf6NJNeVjqdgcjYf+Mh4wq15xK8NZypBk7EQ1FScWUEV//dMMHDihP0jEhfoLF0nInWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OpzYzV7J; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OpzYzV7J"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWNfI2013122;
	Fri, 28 Aug 2026 11:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HaZi5
	4XuvSGwwXAOvLRMGXBSqS/rduiS4tFlnN5D9gU=; b=OpzYzV7JI70prRLS84Ufv
	R+pA1y8Jo+ZrFYTkir6q9geZLhK6sUjl4UhLX3RuaRI4LrtPhxxA7AAPahouzEvU
	ROkyMUXiHIfzq5EPpW3RUxn8GnncZemNy5JbRtYz/r6hinUywomPNgVAAcIGHEbH
	FKiKrruy2pSq+e4w2OkLT8Dzgb/gORzuDBw1Ef8Q/GYVxqBc19SHDrP8j9dmYdVr
	cj0uCPOgI2ZWdyj1l8zpzd0qoFIOtDmlS06iYRrTveQfzAxOS+XIrYwiqrfla4JA
	PKZLAt+S6pqsh2R35caf7Vp2vcZQizboRaYhdCsU1fSWH3tdOE+/PfRz5FkA4UaR
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ga1m14ew2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:05 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFV4Fa012954
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:03 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3i031424;
	Fri, 28 Aug 2026 11:30:58 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:26 +0200
Subject: [PATCH v5 03/20] iio: backend: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-3-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=3821;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=h8rpUQCVfSyFWZ0W5MDo7rp1yKN/O8pCD8GN49kfEBA=;
 b=gWghRxv+Z6Ds8pghK1OVovh4aeqPAK79YgqUDjvj4/+nuBWv8GrH/CYy0Cs264hLwHW2FmpXU
 AQ8LF6WcSbmCfjHLhmHoXIxPICBWXxQmaJCRrPaFD5nijiBiiYzqd9j
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YH-bJM_o2RX1tOU6RwNpPkoxtGmwaiM5
X-Authority-Analysis: v=2.4 cv=NtLhtcdJ c=1 sm=1 tr=0 ts=6a91a9b9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=O6R5dNVUA00TSld12QQA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: YH-bJM_o2RX1tOU6RwNpPkoxtGmwaiM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX5CWYUyK1kdPU
 qd7gIr6KaG2ooXZAN0wQ/8KGrOaNX/LsGfTRK5TSvFqgGHOP6A/tPBHy/FAR7JdqLgFvwLXPVpT
 rHEOuiGZ6O7httbaNAjn+qfB+DfMxOSQYR7FCZNUPt/AdK053hhI8EZUslV3x/sYE4e3n2qF4NK
 FqSfWsDd2LMc1NB9fL3s5wijw5T0xw6mGH29X9SY8wY4royHqVjkOrmyA1R8VtyuBFcsNfcC04B
 QRFD60FYBXLFJ6970NHMrNfWAkvbxZkjgTDRQHXqkMNI0syDz4S88Ay4P12yk5DyLkVB5CI2hJ1
 LpSAYlJcGZn3u4hldrCH555QUXDgoBskXRkwuAwJexmIM8USbeQyYXM25Vq/hbN4UzZsAWccbXW
 RfiMIxiFVWtiNQwiJH9wDBj0IgGTnOP4jGo6YC3f92NiO+4/EouH/OUGDxISBUK09vkIVDLWtGh
 FE4rJs1vzD2xWO6MrTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXwy0wGvNACmNM
 1Xo3SX9lmINrvyWbS7BjMfpFYa2egSNoKHzMGCmkymh2b2TICKKWSTCf6TZmg+Z042/pacEyVBc
 gOJey/L71gXkR3zCxmI9obm4yW82euLoIpyE1TQkQX1Zvj+UWt1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

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

