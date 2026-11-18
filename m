Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007024;
	b=A01yyziatGOtwj0KyrOI3PsUNgcK/9ervHAKzGsnpEycH/z71kjct5gv1zALqQw/bYYO
	 iRAGW2JltdU3i8XFjtA9xWl+TX7Q7YL1piK1nUxGLXMxCGZca/S8970rd+5nGTQg71bK7
	 +UBLgYndjhyZsuZSnOv2nkef6+0TcEkjW5BstkhZht3PRTu7g36fOrbepo2alwEKodA3z
	 6meC6oWh6MYt82/8h+K+AWNmGu6dPvee9DMiv8Qt7lRYIqLdTZnlocg1o604gEISPj+tI
	 kgfV+DesdmgIggMJqjKx0A9CFqRqgJUhKPHiOOVjhiYR0hhUpdXmVl0UQSAuPVJCbnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007024;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BdtK3pmgEsYr+oMRVlxCUqUt5esKP2ZMStpAYi1UU2I=;
	b=4tTaD9lERyoZHDsvmvPBVGu1dZ9lkWYpV2ASQxINIJz8Jf/TIyiSMrQ2Nohnm0MutpoR
	 TuiTixk5n7yvOJBslljtt/7zClAQyfx/YWeC1UX0QsAMrjw1jvG/tf72SG2V1HvuzF+Xd
	 UpycJC4wXcv51+xq+8XzlHDNsX5ejv0XlU3D7HuUfivf6G1tmVuz/QXefaw6sJfIrtIpa
	 EdEiz+4Y4CangnzvzpNXxV+Rr9BtvVcRz23Cnz42zEzdhAB2mwsZewCO2OErlfrsYWXU/
	 M+4XsIoo/MJlVoueYTXzDYudtLkMmmdCMiHJUwPi4Pim7YV+JM2/8aoYDVHF5bxLYmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=h4ps1FM3;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=rhwLN0UB;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E7606A320;
	Wed, 18 Nov 2026 13:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 773E7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=h4ps1FM3;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=rhwLN0UB
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBLF66900240;
	Wed, 18 Nov 2026 08:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=BdtK3pmgEsYr+oMRVlxCUqUt5esKP2ZMStpAYi1UU2I=; b=h4ps1FM
	3T8I6JOPA4nx4T2Ut9QFd43tzKApQKgVOifmf9RnmESt0K/Lnes74bnzEYz7iDTP
	dpl0R9LXOqhd1ruyUiUNH0265kQR25PjQh/N8FuZl0bYE+b6MppcvBcgbzlK5o8j
	w5DJgtrlEp28pA/Zw0wKlywCF4kzYnKyhM+a1JNqO0JFFkLTHeD+SWHN1nXFfWCv
	7gyNqtMXCHU0IRm9JUBvPkdoSYWPZM1l7i6GnRsM2/phlRhQKHRUZ/WzDNHALy8e
	5VBOZ5/4UXajsN8LBvezeo+euAYhsOVspR5AyKXYNvKn2wN9QXI7sYW8btfGOzfz
	sTBXTnlvl8sZ7iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BdtK3
	pmgEsYr+oMRVlxCUqUt5esKP2ZMStpAYi1UU2I=; b=rhwLN0UByI5YZ+TMDV0KH
	KU/+xiulhxWSEzxRaM0Y2S9aL1Uqv2yW2Tn3RIa6DALOKu5BTYnCl21uK7hIu4vS
	BGGAScghbOjbO7LfHEHwf5uB6obPs4uqrm/sidAj8AafAF6C+dHXuUpyrOKnsEe1
	A3Pm6z0JgrRtOHa4+cbnRjdxM3elI2kkrYAddcVt9oJpsumpCUs+bFkrDQvoL9pB
	v7pYqBQZdJv07/g7B6NtR9XsJds/Nj2+Uo5Y5Wl04V31gCCl/pRmOd8YpK34uAHp
	JTAyFbMezsQdjbH2MmHomkgTfp055oawI0mpyitUDkLH8nmGmuWXsQ429VeWHvQM
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j174g1nq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:03:38 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AID3bof057501
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 08:03:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 08:03:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 18 Nov 2026 08:03:36 -0500
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AID3NUD016537;
	Wed, 18 Nov 2026 08:03:25 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 1/5] iio: backend: Add calibration source interface
Date: Wed, 18 Nov 2026 10:03:17 -0300
Message-ID: <67582938820d6f206006b16de71ad6bcdacfa863.1795003864.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1795003864.git.marcelo.schmitt@analog.com>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G+2JgNk5 c=1 sm=1 tr=0 ts=6afda22a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=6kKPvzhoR-5zQYP4gHoA:9
X-Proofpoint-GUID: T5XvYq-gULq7hc9vqkbQaCPhelByE1d7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfX14ue+p8Uwrv+
 6Am+ibkymB4Qo1V057q1Xv8x034tXoD6o3AQPmyjsvdmARwDiC+oLY41th/uvSFdB2pAR9OgNoB
 CNbzI0bqoOEnqEKImM7ABXhNtgeA5i7qDDdr9ns4GAT/08KAmRl7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfX0DXK5TzRPtG5
 J6ZxpOhGzommAH/xTeqkeW+JN76bLZl1qrKISODmF1bWsNvi9RnsLiesqtpX27BKg59tI74nMNQ
 oOkvYi+Go2msCjCjyEF8zJONjzwUKorcie8i1Yj+XhZ4DczR8SPncd6DKvepnjq4EJ7276QTvgC
 LzCcoh4qBaw38lx9dUWgD5Yrgmmgkbd/y1WjlZkklUG3/nXLR7uczmIHPB2NSriQkMm86lMEjr6
 Jc+TUpeMXNzxylphgyPknteX3DXhWIGyF4HCMChGtPWAnEfL7BJpoeFuYKTWITJdaodVviNEk1o
 eQC8qaVKZ3UqqKHqrtkZ0dS0Zs1nBdQBUvMlc5aWKdA0PLL4HrgHCNl5Bop10xefuwQGRl0fjm/
 bru9mjyRcZ6VMThJ3V9eNfJR848wixAXx6Wpm5UbWVGGaQqThjhREc8meN3S6xaZoI/ReaKBfdK
 c4jsY7jH+BxCES/ijdA==
X-Proofpoint-ORIG-GUID: T5XvYq-gULq7hc9vqkbQaCPhelByE1d7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180051

Some ADC front-ends send data over a configurable number of LVDS serial
lanes and may also need to have the data frame calibrated before capture
can start.

Add a backend operation for selecting the calibration source (data lane or
data frame) so that device drivers can perform the calibration of both the
data frame and data lanes.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/industrialio-backend.c | 23 +++++++++++++++++++++++
 include/linux/iio/backend.h        | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index fbf5c39d7655..682d5f735071 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -869,6 +869,29 @@ int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
 
+/**
+ * iio_backend_calibration_source_set - Select the monitored error source
+ * @back: Backend device
+ * @source: Error source to monitor.
+ * @lane: Data lane to monitor. Only meaningful for
+ *	  %IIO_BACKEND_CALIB_SOURCE_DATA_LANE.
+ *
+ * Restrict the error reported through iio_backend_chan_status() to a single
+ * source of the digital interface so that each lane can be calibrated
+ * independently. Backends are expected to report every error source again
+ * once %IIO_BACKEND_CALIB_SOURCE_NONE is selected.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_calibration_source_set(struct iio_backend *back,
+				       enum iio_backend_calib_source source,
+				       unsigned int lane)
+{
+	return iio_backend_op_call(back, calibration_source_set, source, lane);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_calibration_source_set, "IIO_BACKEND");
+
 /**
  * iio_backend_num_lanes_set - Number of lanes enabled.
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 9c16b695a602..6f28e2d016f7 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -76,6 +76,20 @@ enum iio_backend_interface_type {
 	IIO_BACKEND_INTERFACE_MAX
 };
 
+/**
+ * enum iio_backend_calib_source - Digital interface error source
+ * @IIO_BACKEND_CALIB_SOURCE_NONE: Report every error source.
+ * @IIO_BACKEND_CALIB_SOURCE_DATA_LANE: Report errors of a single data lane.
+ * @IIO_BACKEND_CALIB_SOURCE_FRAME: Report errors of the frame signal.
+ * @IIO_BACKEND_CALIB_SOURCE_MAX: Number of error sources.
+ */
+enum iio_backend_calib_source {
+	IIO_BACKEND_CALIB_SOURCE_NONE,
+	IIO_BACKEND_CALIB_SOURCE_DATA_LANE,
+	IIO_BACKEND_CALIB_SOURCE_FRAME,
+	IIO_BACKEND_CALIB_SOURCE_MAX
+};
+
 enum iio_backend_filter_type {
 	IIO_BACKEND_FILTER_TYPE_DISABLED,
 	IIO_BACKEND_FILTER_TYPE_SINC1,
@@ -132,6 +146,8 @@ enum iio_backend_capabilities {
  * @debugfs_reg_access: Read or write register value of backend.
  * @filter_type_set: Set filter type.
  * @interface_data_align: Perform the data alignment process.
+ * @calibration_source_set: Select the error source monitored during
+ *			    interface calibration.
  * @num_lanes_set: Set the number of lanes enabled.
  * @crc_enable: Enable direction-specific CRC handling.
  * @crc_disable: Disable direction-specific CRC handling.
@@ -190,6 +206,9 @@ struct iio_backend_ops {
 	int (*filter_type_set)(struct iio_backend *back,
 			       enum iio_backend_filter_type type);
 	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
+	int (*calibration_source_set)(struct iio_backend *back,
+				      enum iio_backend_calib_source source,
+				      unsigned int lane);
 	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
 	int (*crc_enable)(struct iio_backend *back);
 	int (*crc_disable)(struct iio_backend *back);
@@ -240,6 +259,9 @@ int devm_iio_backend_request_buffer(struct device *dev,
 int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
 int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us);
+int iio_backend_calibration_source_set(struct iio_backend *back,
+				       enum iio_backend_calib_source source,
+				       unsigned int lane);
 int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
 int iio_backend_crc_enable(struct iio_backend *back);
 int iio_backend_crc_disable(struct iio_backend *back);
-- 
2.39.2

