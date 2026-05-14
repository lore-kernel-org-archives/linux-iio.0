Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A69428466;
	Thu, 14 May 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770178; cv=none; b=VhGWERFhudeDOzh12OQzSnEUu1B4fxnBfWf906Ea9wmJVR3P3TXJFBXJlzoWChNq9HkiFqOh1FlV3VU7tBd86R9JQfvk9Ij1/XAY7I96EHqgiZwu4k4uh6aQDdjTelBh9gOegnlJguPggIAlw8gW+50ivrwEFIUd77YkJEboOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770178; c=relaxed/simple;
	bh=0TuhVxB7/xPmMhg1SqRR9zFlXJBycwAnu6/HE8v3rwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3m7iy9ajGgUzABXCkUeq2TbW6f2ZdLGRCuO3HU+hYB8aD20e5L+Yak8kG4VGofnqge3/I69tqJUroilMzufzA8oSG2GgiukIqg3AAjofMBw3gafBaMagnhIo5PrWUBO6KCPWMIjMBw+rjaE7JocGuQgS+gBqV9ttfa5AwXHuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GnFMo0wa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GnFMo0wa"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EDgIHn2904955;
	Thu, 14 May 2026 10:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qD8kP
	qKi7OObWJCQ1wBXR9VmgTR0BQr5v6X54K070lI=; b=GnFMo0waU4pIc8IEoyH1T
	iWNAx1YIIN4O0CD00nMu1BjdS41m67bVYDphrr69gRPgvM+IfBDrbo4ovvTdP4mK
	m3UdC0oAqrvamhsSY0inDP79NWvW6cYgOqTfvdJezCYOIZFxKGo395lmWSljP9Jf
	a1qVUWmOetdUxW9E7cJSja/10G1ISTCW3RLvBQGlNIeZBWYq1bMlk5s7iP8qA7zy
	Xo9ix7mvdXvLZg/UebaBBew9zOnziaticLW6m8B9uhIOjuRDFcnaGNjlwf7Z3Trv
	oeLTab0OdwL8aEgaUebhNO3V2bwKXfBfdhiYxByPOWYpD5/H4XcntJm1M1lFadq3
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e4t1xvwbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:49:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64EEnWMv041749
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2026 10:49:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 14 May
 2026 10:49:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 14 May 2026 10:49:32 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64EEmjAc014051;
	Thu, 14 May 2026 10:49:25 -0400
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
Subject: [PATCH v2 5/7] iio: core: Add IIO_COVERAGE_PERCENT channel type
Date: Thu, 14 May 2026 17:46:52 +0300
Message-ID: <20260514144712.64374-6-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514144712.64374-1-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TtXMEw6UOW4lPRD_hTty5jnp5VGjRlWh
X-Authority-Analysis: v=2.4 cv=Wbo8rUhX c=1 sm=1 tr=0 ts=6a05e0fd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=_UJtBQoUge9VAAk3jXkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MCBTYWx0ZWRfX2Jg1JyTbI2kc
 F0SCnMZbEaHanKImj6Wr1CdlGG9gzIKC3JIOY1FVxlMjkYdL8/+D18ULw9lUZ2O28Uv5SCSdPLJ
 JRgt5epSW2g5KTLCKtlGOaGWW7qq9Zit+R6DFvTEyZ/LjbMVoSb4eDqKs4gAiWYCPT/v6XuUu9k
 8k5fjcwGWLwqkAcRFO9LJVJEb+hM5MG0ax4Wb91ZXxhMtRM9ms48Hn3j0Jd9JM2W6ibebMx5sJW
 LK10grAl+V3nfLdcenB5fGc+9191qDTRrppYhfr2HoE+BlETdLYHAcKCj+FUOP4uk6OtSWJ2OI9
 JkXwKu6dQiNOmeIcQAzQZYAabDdvQ6dJrFpmtW+T+HMebhH+K5ktXl8mX2L49BIgz51Rtv1xFCv
 nLF1eVkPDFV32ywDsPdtiSIoRYIWiFLS35qJ4ZBFuNrXfIvGUju2sBb+M/W39qNmW8qAeGAtkaS
 ILj5W5I604N91Wyu+Cw==
X-Proofpoint-GUID: TtXMEw6UOW4lPRD_hTty5jnp5VGjRlWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140150

Add a new channel type for sensors that report fractional coverage as
a percentage. The first user is the ADT7604 leak detector, where the
value represents the portion of the sensing element that is wetted.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v2:
- New patch.

 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 925a33fd309a..0570e8b8f5e5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1980,6 +1980,16 @@ Description:
 		Raw (unscaled no offset etc.) resistance reading.
 		Units after application of scale and offset are ohms.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_coveragepercentX_raw
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) coverage reading. Used for sensors
+		that report fractional coverage as a percentage, such as leak
+		detectors where the value represents what portion of the sensing
+		element is wetted. Units after application of scale and offset are
+		percent.
+
 What:		/sys/bus/iio/devices/iio:deviceX/heater_enable
 KernelVersion:	4.1.0
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd6f4f9f4533..ee8ffa2cfbc5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -98,6 +98,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
+	[IIO_COVERAGE_PERCENT] = "coveragepercent",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index d7c2bb223651..39830dc0cfb1 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -53,6 +53,7 @@ enum iio_chan_type {
 	IIO_CHROMATICITY,
 	IIO_ATTENTION,
 	IIO_ALTCURRENT,
+	IIO_COVERAGE_PERCENT,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index df6c43d7738d..3339be7fe32c 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
+	[IIO_COVERAGE_PERCENT] = "coveragepercent",
 };
 
 static const char * const iio_ev_type_text[] = {
-- 
2.43.0

