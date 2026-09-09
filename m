Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACF3A7F45;
	Wed,  9 Sep 2026 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934791; cv=none; b=hr399CHqtuvAVAPwNbMJfooLljacGFbpV3ajWIqIESNi1v+FYOUNxgXqObsNlNow3Lx/vdEGfx/KGIs5c+UhHjN+wIOiDkWPMPikS3W6Y8XeUKZfN2F+2bu58gatXodj7bbN+aXpb713UsCXDkR5xwYpejFRocYmrBuy3mBYff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934791; c=relaxed/simple;
	bh=DdkhrJz088Y42mOGiZke2jPS+a0M45HsBLmGaZRwd8E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nysAdItxy0NsubZ+qTefvu3vvC8UhAk172wTWfGMhOqgjoEHNz/1dTFrqy1jlXQgtRcfVreINXMmRU3pO3h4eAoiheDtDdFKH3hE2mzZAvOftI8fNuhOsazqnfZC4CoPz/9nhgmkvEnuXeKPjlTPONDRNRh8Wyr8oJXAow0X3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FYQ5tRg1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FYQ5tRg1"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6892klNC2763506;
	Wed, 9 Sep 2026 02:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pNdgAVXDOL0BvLX0EVXIRmmMXNB
	AiUhmNCTEzTHpCbA=; b=FYQ5tRg1wpvsZ3Fx2iCMahSBjObOL5Vv+EnV9E9U5hb
	PBi4xPdSoVfH/vCsbCLHPz5Xva0dUhlbZA0GHt+FHK+tTvG49jNx6DI7/eIWe61K
	RGk/f+dyYu/4MqtTxB+XccoVicy6gMPqZSBsneGsnpfis6SA1ovgat+wrq1eHAcc
	kJ1G+9DQ1Hw9TlfSsqZ0Ur72p5jFDBTv2clakd3rz/Q/NTpv1AGcoeuDwYftIOD0
	c5nPggyKRInPvaSM7oFrTqKzVNQIr7uMKO7jnZUbJ2dpK2KLXJ5ose+fH3nqnsg3
	85dmcYAr8S6ZAIqz+FPoUaSyjyhq0sgloFpbAnFrbWw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gh1dc5mfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 02:19:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6896JTcl044524
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 02:19:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 9 Sep
 2026 02:19:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 9 Sep 2026 02:19:29 -0400
Received: from 10.98.41.145 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6896JFq5015040;
	Wed, 9 Sep 2026 02:19:18 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH 0/2] Add support for AD3536R DAC
Date: Wed, 9 Sep 2026 14:19:08 +0800
Message-ID: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFz6oGoC/yXMQQ6CMBBA0auQWTtJS7WxXsW4KGWqYyKQGTAkp
 He34PIt/t9ASZgUbs0GQl9WHocKe2ogveLwJOS+GlrTehNMQOYRY+8uzgsuk85C8YNXH1J2zpI
 9G6jpJJR5Pbb3x9+6dG9K8/6CUn4jwnHmeAAAAA==
X-Change-ID: 20260909-iio-ad3536r-upstream-869cf331e140
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
 Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788934755; l=1110;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=DdkhrJz088Y42mOGiZke2jPS+a0M45HsBLmGaZRwd8E=;
 b=BtTqivgeqgARMvyZ34ZMD6HLZ76Z5zLwhx0GAgQUlssTDStvT+ws05f7hMPkF5v+ITA753VNS
 D88yLcVW5vlCn0syg4NGucLx/pTALGiHYwmtbfSw9Tr9y+csvQFeq6Z
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XOsAjwhE c=1 sm=1 tr=0 ts=6aa0fa72 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=74-Zdgd0EFUuAABUam4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA3MCBTYWx0ZWRfX9XXFDsetwgF7
 aOzFokmIHDO90cpZOzE/D5dYGfBLPYENhT79rWkrR+FBll74JjIEVSDeJZUjC5dkNUgBPv+1yfi
 Is9v7hU5kv8Zotm29Fj9pBc7rrWpTdN+Iw0yyBpp+TeIiVqZXhO0
X-Proofpoint-ORIG-GUID: E449tdp78IsHttZSU5E7g9mXfX_ozvg3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA3MCBTYWx0ZWRfXwQr6jaX1ajHv
 /d6WTBRghltEPb9NOdoJB4b2irrR3SdCyGSCa0/v94EoP7vGmvoCi2XKbBAcJyDhkWrXTbKoxXq
 /kS8aQzF9BCmlfy2dbtEs6+LMq8MJFh2rOMavkCybyPVkcoijw7U2kR2xK2Gq2vfhMuv1owANMa
 Dj8wQBuRNUqUcA6vComOMQyu9SG1QGFZM6Fj7/uxKmvv5GAitsHb1gtDoG0LzPXfHnnkIDrf0kw
 b2Vn19GfHR2sxhb/gBmIVuP7EOSQkBtowiyMy6sJ3/uI0jqdH9/LSHG1V9fA1INSjfX+r2jydjF
 2AJU1wgVvauHoeDwZvs4tzFEPbZ7Pvs+4h/ScnR1lSMnRW6CvY8xtNl70MTNcjFC9aJqdCA14oS
 ca2dPqpHuy8oYFKCB1zBNExLfDWzSCfhfi/1eukdZyjQRLl9A6Mkv/Qvj7OuZRYVK+jzif2pnQ8
 CShmdfdwzjFIPipU1iA==
X-Proofpoint-GUID: E449tdp78IsHttZSU5E7g9mXfX_ozvg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090070

The AD3536R is a 16-channel, 12-bit, buffered voltage output DAC with an
on-chip 2.5V reference. It is the 12-bit variant of the AD3532R and
shares the same register map, so support is folded into the existing
ad3530r driver.

This series:
 - adds the compatible string to the ad3530r binding
 - adds an ad3530r driver chip_info entry and SPI/OF ID table entries

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad3532r.pdf

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Kim Seer Paller (2):
      dt-bindings: iio: dac: ad3530r: add AD3536R
      iio: dac: ad3530r: add support for AD3536R

 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml    | 15 ++++++++-------
 drivers/iio/dac/Kconfig                             |  1 +
 drivers/iio/dac/ad3530r.c                           | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 7 deletions(-)
---
base-commit: 42a9b823307844dc9f496df67d11ec3691317c67
change-id: 20260909-iio-ad3536r-upstream-869cf331e140

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

