Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11713B9DBF;
	Thu, 21 May 2026 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381929; cv=none; b=TtJcSMqrimAHg0nFdBXelz3fAYtdMqs7oXm8SoDocOfIVU/NFqndNCOVWEOTzJo+D6ECA2mdoHyB9hkDxsIrp27qF/gSkYAugiHxzXRAsDe0Op8C8QUqg5QTddjJDrE8lUBepw4a9ADYv0riVyMt8rU+TaS+jiWhi7XoLzW2B3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381929; c=relaxed/simple;
	bh=pbw2XJiYNz9oNPHtRcciA2fM34IwD6GMPr8PS3ENjIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTbLeBJeOe7A11l4wsTN5FezoKW6coUg3WeJxSIgrpZMtEdk5IGVeAUm5iZchEP4URKqybgiEW6U7giczlc16wGbbjVaazctHQiKi/myxSA+YnQTPP6S56gki8UmCn1o11vC9cd9bNCb8lWU0LWHkse20ZpvWEw/IJePwVDClTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hc2UYzCX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hc2UYzCX"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFGskK602695;
	Thu, 21 May 2026 12:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CjvNJ
	wFrBzeUl2tZT4JHFxdtvmajDIm1C3As6XqkDdQ=; b=Hc2UYzCXf61rIISehj5zW
	xQ1mBOGtJxlzqBiYRMQ95zmfhXUKBuNMDKQUlwtIlgVHjQ1bYoZLwp8+qlVF9nAh
	KOF6tiGo7KmWzLDGQj7wBTKjZVclhWhmDkuJOfzgW8l3rr9g4fnNa5FhK5L6IyrU
	9A19BDNFZs2rL2cBTaNo/oGQ4SntmObh7Kv5UOkajgn5aClkneSA2e6u+1ykVq4C
	ndXDdRn+2pnJokopFRxYW/LvLXuCwwPss/TA6WKQWy7cikazevSoiIxaB+kXBR8K
	dC9HsM1DIitpep9HSdFzUnFIQlpnr3fzWCAhNhxCSZomBxjLxMz24YlrN4QdN/0e
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e96sry1ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGjOin000401
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 12:45:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:23 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0q024538;
	Thu, 21 May 2026 12:45:16 -0400
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
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 6/8] iio: core: Add IIO_COVERAGE channel type
Date: Thu, 21 May 2026 19:42:59 +0300
Message-ID: <20260521164323.770626-7-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521164323.770626-1-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hBOLzu9x37xlbQzvRrPqgGOhR7aXld2H
X-Proofpoint-GUID: hBOLzu9x37xlbQzvRrPqgGOhR7aXld2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX0+tOKx6akdFc
 isXArukXZn41HX/J4E668qz0gPzbMVm5ojzegKbdm4cEHI/Qazn06xCtsQ8XSlPQvsyV3KdL4v/
 NspzjTYoV/UlcvIyTGxtfaSKPXO9w2gkE8k1cafDHtbNbuaDwOnw3k2XpGjT+ln0x+Pwz2A2J3R
 ILbbEMR6Br8NIyzIL93RjbheXATca8UssH7X7QO60YwxSjb5b+IpIE7UkerHk+wgkV3NI9QGVnG
 8ZW/jZgDMpoxzSV3HS2lxHeBpP3kigeuom+n5dHpncU9Y5iHd1TuNmJD+eS1lA6TI8nOceUQsth
 VwK4Ldodss+7PvhWdSpuA/9D3BYZPMS4AktzX2LgCF4widjHsnf1wuseTdyX/wYNvBtpxEvgMS0
 K3Ix4wP1jcbVBIIrPPNz7pPDT0tqNN60Xg14Xl2tYtqfyDOkrdw+2zlOHXrRwFHUI5hOFklurpl
 BU0ZzgQEiXojUOb859g==
X-Authority-Analysis: v=2.4 cv=CZs4Irrl c=1 sm=1 tr=0 ts=6a0f36a5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=9xQ6YJnTFPUVikIS7p4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210168

Add a new channel type for sensors that report fractional coverage as
a percentage. The sysfs attribute is in_coverageX_raw; after applying
in_coverageX_scale the value is in percent. The first user is the
ADT7604 leak detector, where the value represents the portion of the
sensing element that is wetted.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- Renamed the sysfs attribute from in_coveragepercentX_raw to
  in_coverageX_raw
- Added a _scale ABI documentation entry
- Corrected KernelVersion in the ABI documentation from 6.15 to 7.2
- Added IIO_COVERAGE to the event_is_known() switch in
  tools/iio/iio_event_monitor.c

 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 925a33fd309a..ca20ad5860dc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1980,6 +1980,23 @@ Description:
 		Raw (unscaled no offset etc.) resistance reading.
 		Units after application of scale and offset are ohms.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_coverageX_raw
+KernelVersion:	7.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no offset etc.) coverage reading. Used for sensors
+		that report fractional coverage as a percentage, such as leak
+		detectors where the value represents what portion of the sensing
+		element is wetted. Units after application of scale and offset are
+		percent.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_coverageX_scale
+KernelVersion:	7.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scale to be applied to in_coverageX_raw to obtain coverage
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

