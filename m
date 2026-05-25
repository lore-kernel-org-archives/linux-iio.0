Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCE38228F;
	Mon, 25 May 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727314; cv=none; b=e1SGvdv0rAwETz4jln8q3LdWevu6zs6Ruwy0gueAWgl0L3W0VtEZGTqO81/OwzrQWKktCIGEXyN0Oe9G/zJOqDu3CPomJvCwd3NBPQXLBchycgEhczP8qx7ta19RaR2FA5oYfXThMU7blOyb+BvaqEAt/NnEIBWLm8n9e+arj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727314; c=relaxed/simple;
	bh=cXCVjnbyfXe4ZS+Ubw3tfsLBFGAEFG5/iaWWs1CzHtM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DosndvvD0AgVMjzgny07kcwS8Ho1b8BfSg74339zUl8mEhLQjWfY8LHmYI1XTSe7ie6H9A0vmpCr/HowcTW+Qi69pgm4bxjhvMWXjbmm6c/ezMSjOFNStDm2N+bwkeEBiBiKHUqt5wEjtTov5MFvZWg5ai2iL7JkG9oZtKOrMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QXElbpTl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QXElbpTl"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PB1VUB753445;
	Mon, 25 May 2026 12:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PwlEi
	ASrwofKlu79R8sVCzOC6cnBY3mIKS/uaMJQwZw=; b=QXElbpTlp+5GGk469AhO0
	fpO/mRFVT00Gkz4nTCgWqh5tItwT4LJPPHSuSymt3K6vSMjRzQ4/TNJNXyet40Vg
	dUd+nm3M+sAzbqoH0nn5BrwUUappxElLyTJThrddd7WO3AJNS/MnG5wd6BziQR16
	4dGSpHfYNWRfx8aJ8Jbt2D2xTYqNe8v9s/u8byv2x6MlK2IjhfLjqr37eqCeBZ18
	jWYEIDz7mqNrtay0p/x3O638BkL6+8JvsxZ1KM3LYaqMM7Ap5cs4PBqjvbt4B3Mk
	eIMX2M59eNngxnvQwrFRFrSiZMEhq4j9vijeZuEnbAK8gmMzmyUhsqRIMySqM1z7
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ecbgtavbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfnLY022310
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 25 May
 2026 12:41:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:49 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevH6028845;
	Mon, 25 May 2026 12:41:41 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Liviu Stan <liviu.stan@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 7/9] iio: core: Add IIO_COVERAGE channel type
Date: Mon, 25 May 2026 19:39:34 +0300
Message-ID: <20260525164013.118614-8-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525164013.118614-1-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rYwTW4T7LklD1MCAP4vuJmV5Vmc4mvoV
X-Proofpoint-ORIG-GUID: rYwTW4T7LklD1MCAP4vuJmV5Vmc4mvoV
X-Authority-Analysis: v=2.4 cv=L5EtheT8 c=1 sm=1 tr=0 ts=6a147bce cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=GHF1qUwFPqcx3V-e3LwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfX5aFCBCUiTqRb
 7jVeZ/UH7Thga7JbrHwH0p2JQrBxn6tdJvt4Hkj2wPUyBiNDhbxYFuZuK6sKAZCiXLVgwaJy8Jq
 nBqJ3h7USq4rqm7A05sUcZwyXZ5zL2XrRYo/2VTKpU6gw+w9r/2kIkkxrzQd9iX9oXWh8bG+zIC
 1IMMEvpLQ6qavXEjbaV62I2eXjZ5rEBwgC+BCFCyzMHPsnVMAcH4FcAPffuMVnh366GF2NV9y8b
 SsDmqejT0VmxUHazrSwAL10/DxpIowM+7PAQvEOQrtpVFtxq5g8w1FXy4wbfs++NjBUhlmcBNh8
 jbxL5t7LgwZ1zCwu1ZwaFuh5ntpkHuk/GzkJizn5AInkK84y5rYN0CJIgTE3x8DwZXGa2UvALb7
 eI7V+ZlJh7I+fj3zGIG72xeZEQR7irTWFQUfHCwvdlIm0h1IHIY0ZeInDlXdjRb+U6Y/ZirdVCm
 lWwA9QsWObWr8gufNIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250168

Add a new channel type for sensors that report fractional coverage as
a percentage. The sysfs attribute is in_coverageY_raw; after applying
in_coverageY_scale the value is in percent. The first user is the
ADT7604 leak detector, where the value represents the portion of the
sensing element that is wetted.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v4:
- Renamed the sysfs attribute from in_coverageX_raw to in_coverageY_raw
  and in_coverageX_scale to in_coverageY_scale to follow ABI convention
- Updated commit message to reflect the rename

 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 925a33fd309a..d8d6d85235b0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1980,6 +1980,23 @@ Description:
 		Raw (unscaled no offset etc.) resistance reading.
 		Units after application of scale and offset are ohms.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_coverageY_raw
+KernelVersion:	7.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) coverage reading. Used for sensors
+		that report fractional coverage as a percentage, such as leak
+		detectors where the value represents what portion of the sensing
+		element is wetted. Units after application of scale and offset are
+		percent.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_coverageY_scale
+KernelVersion:	7.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scale to be applied to in_coverageY_raw to obtain coverage
+		in percent.
+
 What:		/sys/bus/iio/devices/iio:deviceX/heater_enable
 KernelVersion:	4.1.0
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..ffe0dc49c4b9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -98,6 +98,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
+	[IIO_COVERAGE] = "coverage",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index d7c2bb223651..c9295c707041 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -53,6 +53,7 @@ enum iio_chan_type {
 	IIO_CHROMATICITY,
 	IIO_ATTENTION,
 	IIO_ALTCURRENT,
+	IIO_COVERAGE,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index df6c43d7738d..bc3ef4c77c2b 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
+	[IIO_COVERAGE] = "coverage",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -194,6 +195,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_CHROMATICITY:
 	case IIO_ATTENTION:
 	case IIO_ALTCURRENT:
+	case IIO_COVERAGE:
 		break;
 	default:
 		return false;
-- 
2.43.0

