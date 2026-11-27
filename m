Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816350;
	b=37eNKDS2uosW5RmjdahR1Z5zFeA4LEuo4avhtuUT/UVNM2xfTj+NVVg+ReaXNkv9S/4G
	 d5ByK4HZUgN/sejfVfBg0p6wLLzrcZgstMFRAPFXB0BNuupEzP05HGgLzGY386EzeENKi
	 KkA8yB6Ne7v6coaP1GhQDn2zaJf0cVFiIjlV81+0Ar+KicQdaAitLpQwQah3UaZ1Op4k5
	 2tY1a3nhE1cWby0Kp7YdJtooebRNu+p0OVrgwnTFkJR4o73+1e2KLKb/O9kRp4EB/Z74K
	 Md5X9QmARV11MEg/qgTOOy+SowKCoJrBDNN5+PNAoqKySQ/0kMsicUzJmiKiK9E9v2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816350;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yghUlVN/lGvM0Zy3uzxeXFkX0IrE/Z+z31G8P0LE9yU=;
	b=bf2/t0CsE+FOTPPFF0/0Fl0R9YJ5S87WxLHwQVLz2yGdUzK2YdARmNaZHzKd4Uys8DFD
	 KLFdcV/KEUOv1eAfdOdV5AZN3PU+kcObvTNkYdBQfCaDBEeZI35wqxW4UeRBNc4oj3vci
	 QFXZO57XJZMS7yuoFMu1PbSY6fyrL2EFypbnaxr2GOeOq+x8pTa1nvmRjZvx5UwpKHLoA
	 t9AQqxJ2dBBfP9EEsLC97Zbvo+d9dH6o3ny9I7NjJuZDQ48u3E6J5qQdPcSkDcyiomyPd
	 kRywwSZFNYBAcjaAh2UoH0HpNAw0ysrj9A+u4o58CpB6rfhKpPMtSj+952ErFLmp1Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MNLbXMSm;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BGEhHhNU;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915E606A31C;
	Fri, 27 Nov 2026 21:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5915E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MNLbXMSm;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BGEhHhNU
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJCl4F323456;
	Fri, 27 Nov 2026 16:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=yghUlVN/lGvM0Zy3uzxeXFkX0IrE/Z+z31G8P0LE9yU=; b=MNLbXMS
	mRFHSW0Guo35qK689BWryMkXRsz6NrCOtEQEAoHW39q9h78dbYqucmKveTBDeM9P
	3t7tlRAU6nbPucj5qRpBCgafJ3O0eEIos6QJJPqAVLLommqfJqk/mXO8Crbo4S5s
	d92sxjJbN4jY5tAprT4aN0EMgMTkEvu5p9Tnfv6FNsahGwUDjNTyOhJpKn+DoZGX
	yMBirz8mCk46wwCbSpETttm/yR4KX5ZC/x8QI5Xoydpt0bu1gZv2kNmGfWi+QaX6
	kpxi0o5vUywi1idY8JkpcT4BLKF+4oGA+cTOjra+UdN6wBgHo8eXwu3IAHUAkBhQ
	hBVXw7HXyt1Ow2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yghUl
	VN/lGvM0Zy3uzxeXFkX0IrE/Z+z31G8P0LE9yU=; b=BGEhHhNUTYEvXs1b78lU2
	T3FBzG25ECBILRoDL1mK+l76HDWMNLFBBJtgQAuPbIks73xO3IkE3girj6s2ody9
	0kyL9p/ECeym9qOpbRwlQO1NBvOdkPOR4MXqo3VA/MS0DFpa66kKIyIQNfwKBCZG
	goNDTt6UsVr5z8TSVQJyEpRh8nUM6aoc0SBzz6hYXv8k2pbyQVtUL2mGJIbYOCw4
	HFABNdt6dcKJbyH0USH0oefGuSTeBwRMq6iCNVO8KZpfdv/lEOacP+YoQesgDPI5
	YIc9mjhBjHrbSZFC9TdvWrSHJYFZQkVd4ixr8eT037F+oB3P4N/fPaPum6ksgRA7
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5uq96bj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 16:52:21 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6ARLqKUP057077
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Nov 2026 16:52:20 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 16:52:20 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 16:52:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 27 Nov 2026 16:52:20 -0500
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6ARLq5oM018627;
	Fri, 27 Nov 2026 16:52:08 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/5] iio: backend: Add calibration source interface
Date: Fri, 27 Nov 2026 18:51:57 -0300
Message-ID: <70219bef7a79a3e47fa80978d8007391dc317d95.1795816065.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795816065.git.marcelo.schmitt@analog.com>
References: <cover.1795816065.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: KOy4R8sRo1LnTbiJ9YwwQpD3OpSu9gnQ
X-Proofpoint-GUID: KOy4R8sRo1LnTbiJ9YwwQpD3OpSu9gnQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX00mX9YfNDHkK
 ZxUE1CHgnh1Bflkw0D+u2HSSp7HNNjl2iwQQZ3FBii7IECYDs4MYg+LW7bTjb0tgPrNOdq+PoST
 GMTP5Cuc9BiyneOzXAqX3BtLVlgh1dC64yaSmtgShRbu2h0lAOLQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX0krAU+P2j+pq
 +xrtgFgjfnzK4FypoRdk3pRLAT42+mhktVV09OefVCe7Ss+BtDqOeRHTMXuQGyCQOzu5G+Ws+Q1
 BO4eJzj/DAtk1cxzrvhFbBI7t3bdrJ36Mel+/pLasqIyIFurT3tvw/CZgsuhBHErWcDB6138S61
 zw6r+RiC1VITUYcViB16MHzLE7V3hKD9nlR3ha3JiHLoB7UNFrabBTFjefvuDVHfJGL9J3KuQYO
 yu8mPZ22MXMbwAJYmDrtXJXXKyf/km5Vhy6qrLQZ82h7aBcKlpDEkIoDZicVoFXnnEmA0c0Ghhw
 RrStMlQhmJVgtMtZXWykibDLFVdplyKRX9pDvnuRdx8NEcfdepK/8jNzAg6M61ajthFqSaVyPIG
 GR64MDUSIbeGZgtm4Zl+hz9LVcHhzRLzGOt5mx++cDyzdjhIe45imApxcxmIXOhWFBD6JnnNP7x
 PMOrngly1Ux+mJjZAuw==
X-Authority-Analysis: v=2.4 cv=OozaWC/t c=1 sm=1 tr=0 ts=6b09fb95 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=4lcdnP3jPRkKkMl-pv8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270087

Some ADC front-ends group and send data from a single channel over a
configurable number of LVDS serial lanes and may also need to perform a
data frame calibration before capture can start. During a channel interface
calibration, the front-end device driver usually requests the channel
status multiple times to find out the optimal calibration point.

However, the backend channel status interface doesn't provide which
specific serial lane or data frame flagged errors when they occur. The lack
of error source information prevents proper calibration of channels
comprised of multiple serial lanes.

Instead, the backend may have a separate error source mask configuration to
restrict which digital interface source will have its errors reported
through iio_backend_chan_status(). With that, each serial lane can be
calibrated independently, enabling multiple lane LVDS channels to be
properly calibrated and supported.

Add a backend operation for selecting the calibration source (data lane or
data frame) so that device drivers can perform the calibration of both the
data frame and data lanes. Backends are expected to report every error
source when IIO_BACKEND_CALIB_SOURCE_NONE is selected.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/industrialio-backend.c | 28 ++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 7cc227818618..aaf11cceb145 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -869,6 +869,34 @@ int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
 
+/**
+ * iio_backend_calibration_source_set - Select the monitored error source.
+ * @back: Backend device
+ * @source: Error source to monitor.
+ * @lane: Data lane to monitor. Only meaningful for when
+ *	  @source == IIO_BACKEND_CALIB_SOURCE_DATA_LANE.
+ *
+ * Some ADC front-ends group and send data from a single channel over a
+ * configurable number of LVDS serial lanes and may also need to perform a data
+ * frame calibration before capture can start. However, the backend channel
+ * status interface doesn't provide which specific serial lane or data frame has
+ * flagged errors when they occur. Instead, the backend may have an error mask
+ * setting to restrict which digital interface source may have errors reported
+ * through iio_backend_chan_status(). This is useful for channels that are made
+ * out of multiple physical data lanes so that each data lane can be calibrated
+ * individually.
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
index 93d5f2073cc3..5a59bc1025da 100644
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
2.53.0

