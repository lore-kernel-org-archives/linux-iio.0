Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9235AC01;
	Sat, 28 Mar 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774698220; cv=none; b=oWhJRW5TGOyQ4AIUz/UAqkXpg5EVEdq+yu9KYzXUZQXB+XkaSbmTkCv8ptoWumhd8CFHrT+U8TK8Ux/n6GOzC1fKLLf6zENEAo3+D/U9gLsa3KWkgrJFL3vb/OFusIxGf2unvBS+nUATZ2aVYFyCfcPvLLmD4EjmjXF2iuk4ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774698220; c=relaxed/simple;
	bh=6/2N7gytMy4vIjZnYfXwnNqwynZlF7fdO8MoTgX6iSU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwUJ3NqmYTTX5Bqx6qhpUvsWx6IN7LEONRV1vM2nDApI5LJhn+BJnJuHokfxNq0Hdg/plfKz2u8Fi63q8C03MXMajsNrhgXAFjyEgr6GbHnY1P/AV85bST/I6Ic4GdtmFGAf9Or8AsNEkIlnCYIZEz1B9QNlLwA2iDcxRZRkHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Av6RxnXq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Av6RxnXq"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S8sXaQ1544669;
	Sat, 28 Mar 2026 07:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZEH19m1DfMrUUoT+dgGk7QzrTj9
	i9I/MV88CqvlaPwI=; b=Av6RxnXq8ZhGR5AyDn87SAeM8TIaqQtl7M4FoQuSMmP
	ozOwe1lZWkeSS0S+w51Mt8IN24xIUTjOVb3EIyadbWDGZAUEYKNS501wzeA0ITfm
	CiGyIXA7SiS0MdrvpZ5b5vWSbbMwTuyqPDledP872ywNPCnhhBBUdbgNZoc8L7AD
	7bOOu8UJig1vmqB11nu/crWTqwbJv8oUIsdqJ2pYrBU3KsDu2E8h8KaQS/lp4mC3
	R+bL77MBu9sMGWgX7hbs4H1D/ANR+a76xSO7sBkmMm7XRcW4AKD4Foov3GEkVkHn
	JuaM/6jtkza8NU6yZIR2s+oUGOe+GGuer0d4MjtFxCg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bw0rasj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 07:43:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62SBh57K037546
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 28 Mar 2026 07:43:05 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 28 Mar 2026 07:43:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 28 Mar 2026 07:43:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 28 Mar 2026 07:43:05 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62SBgofu013745;
	Sat, 28 Mar 2026 07:42:53 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/3] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Sat, 28 Mar 2026 13:40:47 +0200
Message-ID: <20260328114050.46848-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jp6u2VRmsDcn_bGcdXR32YFS0N240eVW
X-Authority-Analysis: v=2.4 cv=BqyQAIX5 c=1 sm=1 tr=0 ts=69c7beca cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=ciXE-xoNQcI6FOVIPR4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jp6u2VRmsDcn_bGcdXR32YFS0N240eVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDA4NSBTYWx0ZWRfXxEG4l9f10H3j
 oe9ZI9usxD8XxeF3VRGMIWy4VW7C2hS38bVkIjs+SxhOoqsF8s7sv+mwbcCrwxze9DReHrtRkAn
 50k0DxrdiHxgDImLKkfaK9lahph2Vz+1i5bnDM35LtL6IlnMkPKyAyHBAzFghbVji+T92b29fzI
 lL/7k+mb1zN0IX5QyIf+sVdw9Q12SLCoAaZyb+p5DT1bSvVNoG7gbqGtPCoROOyTWJstuWvzh+p
 4sRZWtoBLnVyHEXq6bTQChyJDMwip9nVHk2TFE90Je8XA5Jz0Ey1UY++oQ98+Mb+91w/LJE/L7i
 qyjy52SpKi7Pg/SZIT5rcHRxxcek3zubZklIFIJ1SONYdLmdy9/gQ86kjrlMNRBLEgaH4aaGdNg
 rcpVnC9uKaaWvuLm0bYGe7WoatAITc7rZRnQoNTtSsZttXsPd/S5VPU6hr+aVOi2/3laAYI9+kF
 flwkEgtv0Nq5MkQcFkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603280085

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
integrated fully differential amplifiers (FDA).

Architecture notes:

The AD4880 is modeled as a single IIO device rather than two independent
devices because the channels share power supplies, a voltage reference,
the CNV conversion clock, and a single interleaved data output stream.
Splitting them into separate IIO devices would make synchronized
dual-channel capture impossible from userspace.

An MFD approach does not apply here either - the channels are not
functionally distinct sub-devices but identical ADC paths sharing a
common data interface.

Each channel has fully independent configuration registers accessible
through separate SPI chip selects, so per-channel regmaps are used with
no locking between them. The data path has no software involvement at
runtime: the CNV clock triggers simultaneous conversions and the device
outputs an interleaved bitstream captured directly by the IIO backend
(FPGA). spi_new_ancillary_device() handles the configuration path;
the IIO backend handles the data path.

The debugfs_reg_access callback is not exposed for the dual-channel
variant since the IIO framework provides a single (reg, val) interface
with no channel parameter, and exposing only one channel would be
misleading.

The AD4880 is a fairly unique part - having separate SPI config
interfaces per channel with a shared interleaved data output is not
a common pattern.

Changes in v8:
  - Drop fwnode_handle cleanup patch (now in jic23/testing)
  - Clarify backend buffer comment to describe FPGA architecture
    (two axi_ad408x IP instances with a packer block)
  - Make filter_type a per-channel array instead of a single variable
  - Restore debugfs_reg_access for AD4880 (uses channel 0 regmap),
    based on sashiko's review

Antoniu Miclaus (3):
  iio: backend: add devm_iio_backend_get_by_index()
  dt-bindings: iio: adc: ad4080: add AD4880 support
  iio: adc: ad4080: add support for AD4880 dual-channel ADC

 .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
 drivers/iio/adc/ad4080.c                      | 251 ++++++++++++++----
 drivers/iio/industrialio-backend.c            |  53 ++--
 include/linux/iio/backend.h                   |   1 +
 4 files changed, 282 insertions(+), 76 deletions(-)

-- 
2.43.0

