Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16D448D1B;
	Fri, 18 Sep 2026 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717022; cv=none; b=TgAAPhyMe4qzNMm6YzWbu/ZjUttWpZPlZ1O3AbBth3M8UjLO+tVjk/BiNjZJgcYPEBTyoUTxIntzvTIvfAXLrpdsDSIbMZ2ZG8BGjOkhx9XwRxBjugU/FqZeWDj74w9qZVvSi4abVqqw1sGpJMd2b5ZviFyrHQkkRcNAgr1Shgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717022; c=relaxed/simple;
	bh=vIK9tFqNldIh2MUeaASdCi82xj7ri2Cg/iMCnZxw40Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXoqtj2ElBgWC0CmpQXAGSfUjPmD/5L9emHnjxC9cd7Kve4XSlEpzucNKw1vCuAWSPGSm2MgF892DIlxRNNlzbHGNGsq/vf6UsD+H95dJHjH3C+m4Ee6LcMbs21FEOXJEVNUE8JWpPc3ACur/6RPP5tEz4E5gJ2G1WKSdackWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0wOeyiDG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0wOeyiDG"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5w4d53358319;
	Fri, 18 Sep 2026 03:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=96mXbhErjRmF5+bMTXlt0F6VSVN
	+VXv/dxepbpkxjJM=; b=0wOeyiDG0Ii8lg9YZT8zWfqx6pJWsqviYaZIU/9WIc0
	3ghtJgWZPwfyG6AmwqQnIZitZkSB1nJdNcN+nGqJzhq7sqktP9zeN3g0IC4sY2hJ
	2COVuvaaRBdjT3RZIvR7mtvfKUnZbNhv2JCX8O07JXg1tzcuPAan+QIqGDkN2Hbd
	pkhdxm4JlyviAwJO5oCIn/+4OsTI5XT+13VD78bmTBprPzUi0VXW5/C6bzrPdY8S
	cFO5rdIO9zj9o/AqMBR7fp0fWgGZBRz888ntCb1/SlkEAXad6o+qC7gXw6zZ9EUI
	Zv8Yan3mFH80xTcu0iZofdxQEOVn8lmuXs0UyDjRHBA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gqj57vhun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 03:36:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68I7a9fa011015
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 03:36:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 18 Sep 2026 03:36:09 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68I7ZjpS019677;
	Fri, 18 Sep 2026 03:35:47 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "Jakub Szczudlo" <jakubszczudlo40@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 0/6] iio: adc: ade9000: add ADE9430 support
Date: Fri, 18 Sep 2026 10:35:29 +0300
Message-ID: <20260918073537.1572-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfXzBZ6LGwepfXb
 rHzHg2ec6EXOq58U1M1iaQ6AsH++NBdaimc3tc3hZYnveMCgEDD/sph3+tPIXcMTghbpNSMxE36
 kTPePbDgzRqLM9n7kt9RbFJFokIP84K8PDE6MAdDMyFVDilmAqtW
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6aace9ea cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=ZuvK8wOLsi7zVax-0MoA:9
X-Proofpoint-ORIG-GUID: NweDUqPZACobFN17CIWBfJXLHiXF3dDa
X-Proofpoint-GUID: NweDUqPZACobFN17CIWBfJXLHiXF3dDa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfXyGRMKBCTEmqW
 vMy7idkV2veh3K0mSmtrsB0zZn2mSHy4oUqigJjXMIa6La0YGMiNDe1knA6acS4VyScLECHNrTR
 XPTivaCB8MOKb6xoUyVdPGSM6I+SwYzmdQf5pgRXFt3O+guBJiY4S9h6Yd2AhlzA5yscQXRJ9Ou
 A/GKj+zL5LCoDyL1Dn35cFc6ky9wb8MMC+DUXofVmSpdZquqS8AkRzI4Ns0wE3OvsDQj4ax/AZM
 rzPA/HScKk5/Y48++U9pUhDX1VCOLbrZz5nkQIFVK4+qw6I2VjUGQC0Y8ya0ekidxgbrThF/o0s
 EJnV3JuQEfq5Q0Krk/I2Yk5KTyXOKKd+gQOk2oinVWgWSUez1fP3Ars276uUJ0btmhjIPkuULUy
 h31oWDdLTzFIYsv9KUiORskX2Fg+Un7IxtGXVEwU9+h7nhaZZB5qSS4jbWzdVYfa7z5P2xFR7wF
 z2Cd2VwFYedZ7d/Oblw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180102

The ADE9430 is a polyphase energy metering device from the same family as
the ADE9000. It is register-compatible with the ADE9000 but omits the
on-chip dip/swell detection and has no on-chip digital integrator; it
relies on an external analog integrator for Rogowski coil current sensors.

This series adds ADE9430 support to the existing ade9000 driver, reusing
the dip/swell-less channel table introduced for the ADE9078 and adding a
matching chip_info for the ADE9430 full-scale codes. A precursor patch
gates the DICOEFF register write behind a has_digital_integrator chip_info
flag so it is skipped on parts without an on-chip digital integrator.

Patches 1 and 2 are standalone fixes carried with this series. Patch 1
corrects the ADE9000 full-scale RMS/PCF codes to the same family-A values
the ADE9430 uses. Patch 2 fixes the DIPC event never being handled or
cleared, found by the sashiko review of v1. Both carry Fixes: tags and can
be applied independently of the rest of the series.

Changes in v2:
- new patch: fix the DIPC event never being handled or cleared, found by
  the sashiko review of v1 (patch 2).
- new precursor patch: gate the DICOEFF write behind a has_digital_integrator
  chip_info flag, split out of the ADE9430 support patch.
- reuse ade9078_channels for the ADE9430 instead of adding a duplicate
  channel table.
- reword the documentation intro to "The supported parts are..." so it does
  not need updating for each new part.

v1: https://lore.kernel.org/linux-iio/20260907101623.8730-1-antoniu.miclaus@analog.com/

Antoniu Miclaus (6):
  iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
  iio: adc: ade9000: fix DIPC event never being handled or cleared
  dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
  iio: adc: ade9000: gate the DICOEFF write behind a chip_info flag
  iio: adc: ade9000: add support for ADE9430
  docs: iio: ade9000: document ADE9430 support

 .../bindings/iio/adc/adi,ade9000.yaml         | 22 ++++++-----
 Documentation/iio/ade9000.rst                 | 36 +++++++++--------
 drivers/iio/adc/Kconfig                       |  1 +
 drivers/iio/adc/ade9000.c                     | 39 ++++++++++++++++---
 4 files changed, 67 insertions(+), 31 deletions(-)


base-commit: edb91bc566576f6664a3efbad6bd4205aa1d5259
-- 
2.43.0

