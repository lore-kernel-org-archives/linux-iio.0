Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5C3CB573;
	Thu, 16 Jul 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188902; cv=none; b=AXLFWw3Xe1DNvssCvrnTBCqyOrtyuPX2LQmDYcEJ8UjQDRIOtuvkkAnSGe/IxQkCABmWM3q9xgmUw2k3H3Rl/eRTxhdu7pqCVHwT1vki+d0O35DZXxbp1pvUl58RqOZLu291IpEsN95rm9SMntQ681F7Jv+1CAkR2D6Ke/YWoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188902; c=relaxed/simple;
	bh=xx1VpezrU7LofqjsYPx7lG4sfAs8wJDFC7p4ml67qc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EmsBZdybpSJTbOiNDcVQboObmOShf5KoECHUmiFeq3cAERtsQLzwtzMZno2tGkEJfH5ZMumlJB8KHAyUOC4he/3BH4L6/k/Z4OGgXRrSBaZIB0zeXIxNQXjmdghFQEl+4F3m8p8HlKLUcx1oVG0nvnWsMlx/ecdTUNUbWjGrJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KcTrayiG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KcTrayiG"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7INPV3064266;
	Thu, 16 Jul 2026 04:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LF3rK
	5+sMDCa8y74GoIcG4rlJL9AB2EKQDMhkZGRVxw=; b=KcTrayiGFtucKIrPNuCiG
	ssn2v2xArH8/IgMwz0VTEAvEtPn98goQiKkySJUfeD2gJMe1LDLPo0XMdFEmLkDJ
	awLRxXLYVxXbB+xKs+TlJrtt1TrXdGIqA+DOm8EgctGlH0EMtExYm7cQ6QlD3VhX
	o5FmAkdsr6SU0W7SK4PnKt3JU1vXavND/RcvQre867E81ZGteb2KGQkearBJbflX
	vFPSlrVAeJ+vOy+TBYL5TfOFK+YvyXZMWXxYaEPk+m3Jm9QCtFaEHGHmgnE5YySh
	314jWDBYbAbxTA1ZKfy6QgDwnKT+iVX6iLWG7rqvtHJteK5OhGDI6/EygaQJqwUW
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe85wv7bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 04:01:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66G81Qlb058742
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 04:01:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 16 Jul
 2026 04:01:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 16 Jul 2026 04:01:26 -0400
Received: from analog.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66G7xo77012697;
	Thu, 16 Jul 2026 04:00:09 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 16 Jul 2026 15:59:25 +0800
Subject: [PATCH 1/3] iio: ABI: add DAC high_z powerdown mode and current
 output entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260716-iio-ad5710r-upstream-v1-1-e848a4bb701f@analog.com>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
In-Reply-To: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784188790; l=3026;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=xx1VpezrU7LofqjsYPx7lG4sfAs8wJDFC7p4ml67qc4=;
 b=zsclUWYxW3ZFsod16hn552Yw4axYLaKTjuP9uL8CTiVhT03TOMVaja+WizW97d8gI0JxBaMqE
 VXAh4MyVqQWA8iARd2139mpbc0G+ovVwvDCm98R0OsXxkwCnj66KaIQ
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=aLnAb79m c=1 sm=1 tr=0 ts=6a588fd8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=KBTNIbbX8C-C_7-zWX4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX85LTzarostx/
 aIs/dda/bZw5+4i+jLwxGnsZUXY6wpyaoBLCBp8DwFnwb72KTStwKzwwr1E/JQU7utzF+Vk9mpW
 KYct5/svmNGvlT8ycFwkYfkGgTmoDVl0d9rBexYN9hSDrT7U0vGBPvE1gGgZN3fyaU2Hu3XR8p1
 I4T/eOYpS6bu+7ImeiVTtdC9g96EdK/7nGgQ/8aPT360+CYkrWtivRuy/kHWwKaM2zRh0H61Dpl
 Wo8/BH6Xq98Losz++GanBWtiykk+UVp+yKoobSOV8t1Si45FJ5Kae4GXCY9/Zh33Z53WVgZfQLR
 Zw3+/pIzefWyRdcrXYNwxz/Q9nDTSXh2G9X6Jw5HNQN2lcAMv4zq2Z+CH+kcKRYK7sSirVUTnPq
 UpZD9O6TlaTHTU13kP7dkUL79jdXx7E01E4tsHEIlRf8IjvFeyxpuZTj6gxT5lpM9eNm8ud6uXP
 A3BuBOTUljh82ZIqQ6Q==
X-Proofpoint-GUID: UJhyLkFEJh5-7NBTnyOe2DJchzhTcQD0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX4QBUBhG3iZv+
 HbaSOsm3/rOC00EvtF5DGrTpWbw5b+UvUWO8fZ7mQ9JgXZFnt3bJLuWywciIC9TATOImqAtwcSS
 X/eDDH3G+hu3expdRvV1i6RsL+nZUi0b1Z2jZYejlaZ8+vYf8Kiz
X-Proofpoint-ORIG-GUID: UJhyLkFEJh5-7NBTnyOe2DJchzhTcQD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081

Add high_z powerdown mode for DACs with high impedance output in
current mode (IDAC) and 15kohm_to_gnd resistor to GND. Also add
out_currentY_powerdown_mode, out_currentY_powerdown_mode_available,
and out_currentY_powerdown entries to document current output
powerdown support.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5cc2e82c4997..acf920fb552b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -757,6 +757,8 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown_mode
 KernelVersion:	2.6.38
@@ -771,6 +773,7 @@ Description:
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
 		10kohm_to_gnd: connected to ground via a 10kOhm resistor,
+		15kohm_to_gnd: connected to ground via a 15kOhm resistor,
 		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		32kohm_to_gnd: connected to ground via a 32kOhm resistor,
@@ -780,13 +783,16 @@ Description:
 		125kohm_to_gnd: connected to ground via an 125kOhm resistor,
 		500kohm_to_gnd: connected to ground via a 500kOhm resistor,
 		640kohm_to_gnd: connected to ground via a 640kOhm resistor,
-		three_state: left floating.
+		three_state: left floating,
+		high_z: left floating.
 		For a list of available output power down options read
 		outX_powerdown_mode_available. If Y is not present the
 		mode is shared across all outputs.
 
 What:		/sys/.../iio:deviceX/out_voltageY_powerdown_mode_available
 What:		/sys/.../iio:deviceX/out_voltage_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_currentY_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_current_powerdown_mode_available
 What:		/sys/.../iio:deviceX/out_altvoltageY_powerdown_mode_available
 What:		/sys/.../iio:deviceX/out_altvoltage_powerdown_mode_available
 KernelVersion:	2.6.38
@@ -797,6 +803,8 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
 KernelVersion:	2.6.38

-- 
2.34.1

