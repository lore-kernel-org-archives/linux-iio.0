Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88747FAE8;
	Thu,  6 Aug 2026 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030950; cv=none; b=c41TSSxkRqmVjqsrLfpcR9ELEO8Qg2VtQymb/r5JLVUrB4iaf1ikxmfKbj8pUHU9OM8+5vDEuQMAbQAEgee/pAsvW8+t6n/XZk3XQRSZtVeK2lhMx/FusHQDU7GMcLPdVvdkcmYZzND3AMGXm/P4qQPoxCyuH5A5zqymITwQIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030950; c=relaxed/simple;
	bh=Ppp+RGxCEecjTpxXjCNm4l8VHRbYg8JEe6sv0mNQS5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cmbzq6NHlkZM3laNepaBV+42GkcwqN5bLHG1vASClHFu4ZAjYcJ6S54mVjk8jFRlIdsUDWC8Z1+MzdhHqJhRun+fucMQ03uo9T9hXJNgCndewtN+tdy1fGfY9yfoHUW4Cn9LMBn8n3+x3/WAfyAUmUWBTp4kN1uIsNPzbTdvxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=risK3yGN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="risK3yGN"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EposQ3853946;
	Thu, 6 Aug 2026 11:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7KDq9
	azkBxHmggf+i7QO8gZmXPtaA+gV7wWItUf68f0=; b=risK3yGNFQ+GmZWjiFDk1
	Ti8wTUDCXJFKri+1Q8+O9rNPXKyszZ1dIk4nRhLv6ll5nEWyHw+Damkx6ICjJD6R
	Q7TTjXsEPoRiAK/BmgNIuJ9C75Enbg0TwzmZmQGVRpbnhXE1WS4nVMBbx0LWBM8O
	Dgjd/MppL20ZDS3TukCz6e/Owy2H3BseOIwnUmQNLt6Zso71VTNnjtUU/MdzjHTq
	dXY2mt48bCKH8NUIBokUifW/dYG3TtbI9VSfUIweIerRsaxb3AwUgVepVM1s4SkZ
	DS9gmPaErEzj5PbrY+33MLL9mawjL590iLn7E4JIWQgQ8wELiNwDvQYMiRJQpBvK
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvrcpsf6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:42:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 676Fg8wZ007038
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Aug 2026 11:42:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 6 Aug
 2026 11:42:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:42:08 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 676FfcgZ008127;
	Thu, 6 Aug 2026 11:42:00 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 6 Aug 2026 17:41:21 +0200
Subject: [PATCH v2 2/7] iio: backend: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260806-ad7768-driver-v2-2-027ac5e2a641@analog.com>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786030898; l=3865;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Ppp+RGxCEecjTpxXjCNm4l8VHRbYg8JEe6sv0mNQS5I=;
 b=wOO24ZFDKCYTk6g99J39Q97icVxqaqa2MplgRqM4jsaNXq2IJcXy6k7ld4WXV30g5iBjWIirN
 aGKGwiGrniuB7SemufYNEOjl0mMCQowwMdzY3mQL83jSGl4xTLXk4oz
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: R8qWMSfG2MiJ1mYtiNv5IbmryTh0ZlGm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX382Qf2109h5I
 aU0NAzxVytJDUW1hws4jx+8HMz83tMljEDSyCQFjt5hqyruBGEEFUxbPpzTZcbcF/ODuXvc3czn
 s2nWGEIBVYECvLBZAxNt3oBeMIBaCgMVLHeKSF3IXtYqGThfoG5F
X-Proofpoint-ORIG-GUID: R8qWMSfG2MiJ1mYtiNv5IbmryTh0ZlGm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX5vDD6oSrySvr
 lzDbBfoFI1xY8rK8PJPkYFZxQIxoLLlmxtfDQOEadfQ0Pf8hb3pags7Die16pb4Gn6yBtg7FULI
 wnO8Prp03z+k9Z/vrDXTLwKEYUp3cm7C49uHV7Yha4yGOCgPBM2HOMp1/VCi3Nt1wDG1SHhkVMV
 VvcGDeXMwj26caiNmN44STl7flwQuDpKW+PBm1z0Fm8/+a7c+wLKmiXsJVxoWEut37afSaUA4iO
 IloJk6Up+M4QdC/AaYQoP+TPJoI81XWqxW8aBl8aa9nu2y6JYURf8ungYe5B2LK8RHWIQAKMvF6
 7p8UNNB2AN+8KKgVYxxKSEXacpF2t+PmYzK2TtIQRNndVlpRVosdbEBM2/s9cIGhIMdKa61vbAx
 hp5fsh/G1gotpE4Xd1x+ztuJgKSQgy11pZV8pI/nU7pV/VGpmmMudTFXsr7m9qJwAA7JWagDV2+
 W8psZjWxIw7ZaLX7WFw==
X-Authority-Analysis: v=2.4 cv=IPwyzAvG c=1 sm=1 tr=0 ts=6a74ab51 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=KKt7U01DjHU_5c1eSo8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060121

Add a backend operation to enable or disable Cyclic Redundancy Check
processing for data integrity verification. When enabled, the backend
will generate, verify, or process CRC information for data samples
transmitted over the interface, allowing the host to detect corrupted
samples.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/industrialio-backend.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f7a4be8ec320..792c2333b057 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -886,6 +886,39 @@ int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_num_lanes_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_crc_enable - Enable the CRC generation.
+ * @back: Backend device
+ *
+ * Enable Cyclic Redundancy Check processing for data integrity verification.
+ * When enabled, the backend will generate, verify, or process CRC information
+ * for data samples transmitted over the interface.
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
+ * iio_backend_crc_disable - Disable the CRC generation.
+ * @back: Backend device
+ *
+ * Disable Cyclic Redundancy Check processing. When disabled, the backend will
+ * stop generating, verifying, or processing CRC information for data samples.
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
index 3f95ed1fdf9e..eddaddb47bea 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -133,6 +133,8 @@ enum iio_backend_capabilities {
  * @filter_type_set: Set filter type.
  * @interface_data_align: Perform the data alignment process.
  * @num_lanes_set: Set the number of lanes enabled.
+ * @crc_enable: Enable CRC generation and verification.
+ * @crc_disable: Disable CRC generation and verification.
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

