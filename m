Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56B3B05A9;
	Thu, 13 Aug 2026 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608933; cv=none; b=I2wLKtLNhmuasmdhRvZJvDbPjDco1C7KrgjVbSFjIwfW1IrQCCCR2Yla3rYFvTVTpP3bE9r+sudtYe6DBVI3mMynGRBlAkg4vY3G3feIk8kP60g6qqtftLpSrabqjiTfYRXo3hmxALVi6N+VtNyvUdxhZMfDbLRXlPf2bydcwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608933; c=relaxed/simple;
	bh=DmXPVXJD2HNsJSP2lzb1+rlOzuj1p6SEKVGEuc5tS7g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JfGxaUiV5HiYO88K0O0EgerkqdZwHUSBL1hewwKdCVqjGbg2ibc+Ysa2z74NgSktsqVgn8oDXcX17O4kLtH1w2I9ov2aT7aZ0WTSKlSlrScp5bbeodLqmgzvM1AyNc0ub60D1ZS/e9QxYTlpcvIlhgqcvoy7v9ct5YsXUAgGkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0uxBgUhh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0uxBgUhh"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D7pCd81789725;
	Thu, 13 Aug 2026 04:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=2BSaoXXxU4jZKjDhlVDsiv/CoLR
	9hMC412y54kMD31k=; b=0uxBgUhhzO9GICZ5tCOqRkwSREFrFxsDgFy0wyFXoBF
	YJZroakH+KCdpIQqQfoT7CHZv5isklzle5IbnhMp6ij9Xulu8vUmKeiCBl6zMEpf
	AFzSG466dxP7VHbbjN35DHbdji3b1KUFvl0xdpIK5gZJ5GeqA3NcFKXqkGChyuiW
	Ok2GsyNOFWu+kuHCJ9MV48cWV8H5TZbbsnoZaEOmOrgL4NNMHJZIqx+fZbz0hFh3
	17/VRS1CdzfGhZ+iHK/G5UD4wjSJTQfeh7OU7+qsLFmKp/ceiQxpQU+s8mzsfaJT
	EqQZx3OOmPQlVy7XtChdOMvmnH9xFQnY/88ChPg5JYQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g19w9g5qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 04:15:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67D8FLIY000769
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 04:15:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 04:15:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 04:15:21 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.182])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67D8FArs008160;
	Thu, 13 Aug 2026 04:15:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] iio: accel: adxl367: add INT2 interrupt pin support
Date: Thu, 13 Aug 2026 11:14:49 +0300
Message-ID: <20260813081452.4289-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfX0GeFVGsfRzqZ
 ytEGD8gCc9z91w0ndJlEYl2pCC6w4R4Nq7u9f5rc0/qlPz8Q2IuB0CpHRkwlOV9wOjmTkOkj6Yq
 DrrMtkBFS2CW4dSlYNytaH743Tj7HBm2KYEdxv9D5AX/VRIsBlIO9j647A8gizqyf710iDz/d6Y
 TQBvjceKms0PqMKEAuIjrLSZYlLVOy2vwKnba0SwMxwvf+vESwjksWbifooFt0xmqEUCkx186dw
 3jauL6d/sn6V1jERYh3GDXv7DUl3s//wQMY9ZwffXYw9KzawcRZfvCNHZ6meR0jTOvkY1u+lRlX
 XM0dk6flf384LI5iuXYhrdskfg8cCgl2WPBswxygd1V3/GTykwKFTgjplE4K8Sux9VoZY8gjmKb
 usm1PDJ0fCK7oNVtztoXsTsWMhztTRMqx6mboWmP1AryVTc/p4fLBBVtZWuDZZNdtiGRf/PM+Pk
 KvqSLV3L25ORfT4zTNQ==
X-Proofpoint-GUID: qT9tWpELUfS3UNWtU0woWuaYcAoREhOu
X-Proofpoint-ORIG-GUID: qT9tWpELUfS3UNWtU0woWuaYcAoREhOu
X-Authority-Analysis: v=2.4 cv=f/R4wuyM c=1 sm=1 tr=0 ts=6a7d7d1a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=utvJglgNXnJIbN7pM4IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfX/hdQZ/K4ZYJZ
 sH1ZqOyIiNAJJwyHUZCOvPnrU5IJ51JuSSIoa/ksosrIhHjwgKYJ09rIgQcG0nfqoZfRbyy1CZP
 nNeepW/EO57kEPJvZ9d32pQYBgencdpMBIdKcbX/9Z5iffwRO37Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130056

The ADXL367 exposes two independent interrupt output pins, INT1 and INT2,
each with its own event mapping register that shares an identical bit
layout. So far the driver has assumed the INT1 pin is the connected one.

This series adds an "interrupt-names" device tree property so a board can
describe which pin is wired, and teaches the driver to route the interrupt
mappings to the matching register. When no "interrupt-names" is present the
driver keeps defaulting to INT1, so existing device trees are unaffected.

Patch 1 refreshes the maintainer entries, since Cosmin's Analog Devices
address no longer exists.

Changes in v2:
- New patch 1/3 updating the binding maintainers field and MAINTAINERS.
- Propagate -EPROBE_DEFER from fwnode_irq_get_byname().
- Drop the redundant irq return; the helper now only selects the INT map
  register.
- Picked up Rob's Reviewed-by on the interrupt-names binding patch.

Antoniu Miclaus (3):
  iio: accel: adxl367: update maintainer entries
  dt-bindings: iio: accel: adi,adxl367: add interrupt-names
  iio: accel: adxl367: add support for INT2 interrupt pin

 .../bindings/iio/accel/adi,adxl367.yaml       | 13 ++++++-
 MAINTAINERS                                   |  1 +
 drivers/iio/accel/adxl367.c                   | 39 +++++++++++++++++--
 3 files changed, 48 insertions(+), 5 deletions(-)


base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470
-- 
2.43.0

