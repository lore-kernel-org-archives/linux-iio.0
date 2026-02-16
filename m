Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0E313272;
	Mon, 16 Feb 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253958; cv=none; b=WYtkEp1qKbc+RJtvcHkcLiKhK98Miiz2XHQLQZKYze4E+hyD1NlKwZ/dI2jKJAV3942/VojGt2nK4SMT1NmjocC6t8OpUM6j1XGzgUM90/SknGRLl21o5gDk56bS03LtfwqI5KZnzOMJpRREhQljUcLCRFaWT6cb8MtPWhcjn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253958; c=relaxed/simple;
	bh=mwcRSWwfqOp4TWS/pNZt2R8xoraxRdEm2u/SUXYyDxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XlUCwMZuR+4AbMk/WoX+VRiWpBqOk9KL1DxZE18yKuAHXxXiCZqBJrRNtjXAS7MUezuMx2ReJL24lNiDfA4Rd3EGh4UQ50PiD1x1AtatRGxsjaYPohKT6otV2whWiGZkbGdb/B+YenLmXOCZ8Kg9kiXk4AB8y7PQnz+9CsOnqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KEXhPqJG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KEXhPqJG"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G9mhtc3758413;
	Mon, 16 Feb 2026 09:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=V4Tt6adLe1NSBmdxy2cFnH8KSLI
	ieYTLwZC3hfgVLa4=; b=KEXhPqJG/eIE5cObiMXJ0Y9k+qG6dNeDegJOmWDgFn6
	YDGt7DxpIJ6difswqbZ097toDuNpfMYVlJ70tpxi0EkVSTrhwbRDGayW39u6Xdl+
	umnEvboOWm2Cfu41S/i1lwZCKwi5WmPTyqFUS3cGI+ZQdAkITiMiPO4g5W9JlfZr
	wKLSD/VrMD0huwYLtR9s33lczEDP9eBkoKl0R61a1ithzPHQxSbfT8I6myyK+mTV
	6+AbqwxAn7MGj5AN3kOtREZgbjdxTAauWKyIuOpzXB7l9IGCBJEkRLqoEit0bg7H
	rAFN3ib5vr8lTOcAMAnyzIZXJ9vxS274ipgaOFcieIQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4capu4fawh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:59:12 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GExBeA019658
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 09:59:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 09:59:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 09:59:11 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GEwsNm016011;
	Mon, 16 Feb 2026 09:58:57 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v9 0/8] Add SPI offload support to AD4030
Date: Mon, 16 Feb 2026 11:58:54 -0300
Message-ID: <cover.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOCBTYWx0ZWRfX5pYHarEdnGAL
 YG9N83af2ZKwRtoHb3aby2U6mLyakVUDDXmWKFVXjj5eWPDlSzoR9wwtqE8jZgTmR7FwgUsk98S
 k/QM7sJud+MrYEXH3+5qFijMzFdugPZsiCi3TVSzlAAaN/Mpo6ljmO51rLdef7bqKmAOryEIV3s
 1rDQHpt3RRNI+h5U5w/zBeTunKmxWouREDjVbp1D1d9GRXSbDuDsCJMKJmppcVZmIMdYAop0N9A
 QGoElyO37Wq26Ld8g75LdjWol6nyln/t47FrAS2P3VTdFrlyaIn04PujYOGDOrZG9adeqSoJg19
 pas8DfAKwCr1KwaMO8lBqooujsl5bWfOA/ZrETcW7NznWnTEmSh1K/x9yyiz4df8Wh8UY73H6Fp
 T5wYpgiw8P4gl5LsCW8bvGIJGBzIoFKTs/OEFVRbr1N55djProu5PTotV3yQLADbUzvoya53SiV
 GcZclDw0eMH/TSXzZww==
X-Proofpoint-ORIG-GUID: O4EZYO3zGpFqC_t7CB7Z3DmxTSShf1ip
X-Proofpoint-GUID: O4EZYO3zGpFqC_t7CB7Z3DmxTSShf1ip
X-Authority-Analysis: v=2.4 cv=EZnFgfmC c=1 sm=1 tr=0 ts=699330c0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=8sbwDmDZewnIFtcHbR0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160128

This set adds high speed data capture with AD4030/AD4630 and similar ADCs. It
also adds support for ADAQ4216 and ADAQ4224.

Rebased on top of spi-multi-lane change set [1].
Requires ("units: Add HZ_PER_GHZ") patch to build [2].
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-multi-lane
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/units.h?h=next-20260204&id=5083dba0fde5446c00ee1a82a3911c8f88a2c72e

Change log v8 -> v9
[DT]
- No changes.
[IIO]
- Picked up David's review tag for offload common-mode channels.
- Added comment about potential side effects of PWM update over ADC conversion period.
- Use floats in ADAQ gain comments.

Link to v8: https://lore.kernel.org/linux-iio/cover.1770403407.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo

Marcelo Schmitt (8):
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Support common-mode channels with SPI offloading

 .../bindings/iio/adc/adi,ad4030.yaml          |  64 ++
 Documentation/iio/ad4030.rst                  |  39 ++
 drivers/iio/adc/Kconfig                       |   5 +
 drivers/iio/adc/ad4030.c                      | 647 +++++++++++++++++-
 4 files changed, 732 insertions(+), 23 deletions(-)


base-commit: 0ec5ed7c95d1ba6a74491928ff38abb351dbed36
prerequisite-patch-id: f3b2f63f86731322c9b10e1bae0952a12219258a
-- 
2.39.2

