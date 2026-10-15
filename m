Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378E221DAE;
	Thu, 15 Oct 2026 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027347; cv=none; b=u2iGtSb5nnCt1avB8Qh8vo6nNxW11186A17Jm98GcM8L2YbpGcprCa/V9f5ij6bibOJ6X4sRICNzDXusvn6iasYZEkeINFx9VdAbyIomB6tXF7ZKtSXfZCoz0sxYM/yw7cS81Ac+QcpiVg/U6JivAD0/tffEJRSQvOmVmFuPOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027347; c=relaxed/simple;
	bh=PiXcmt2jls7CL+Z1fGnouiTM0kA+wVuw332fIPEoUSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dz/mXN7gnONrfcwa3NuF//ALWCgj0lnFhJjfIfAd1j+HTL2cZ4SE3MmWlGs8t6BJPEgiqJEOBONEvTHPaGg/WIixvm8vqjPY188D3D+J+EzIe9Pllbc5wRmAmGaPAOWkKSeXh6wXv0oVSmgmkRw3HqpziI3SsPf49f6dpDK2lh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=QdKQg+4h; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AY+3685j; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="QdKQg+4h";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AY+3685j"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F1LA2h1992657;
	Wed, 14 Oct 2026 21:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=Kvyy1hjreRwUgGia
	qZDazHH1XtXZLEwshcCI0xjYlsU=; b=QdKQg+4hpXqHrnJy4Ck7CRZF1xxRa9st
	ttk7tyiy36eAG9qreq6JbMHBMOIKpi9VeacnYZncouezTv9OE6magrXVJo6u4+Wj
	ZSmhgodSV8tKJvRCb/mx0GXIKlzlHaGQvlvfritzPXtvXqh6VdZu+2N0LCytfFj1
	rvfAEe3kMtav+rwODDJ3NTxe4AztqE3KjgAItAuymWfjAfgx4FvXiuLkErRkLWkb
	dUrOMCBPBrAekfMAf0E4fXvNC8LBkOrkNW3esWqZkyOpuilUss3s0d/3eBBio+4P
	zVKXgyVqe9w3m330Ublo+9N3nm5VOVDw8lHgo85Ps4qnLXcE/oSVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Kvyy1hjreRwUgGiaqZDazHH1XtX
	ZLEwshcCI0xjYlsU=; b=AY+3685j8bJsNmUSmAFRg9mDMjk8gbbGriQL5x6U/my
	PWf6PwxN2/kMOObpO9xx2YCRdR5Nz3VT7HwzhePslb9anAkuMAiP2C8QkZKQavIm
	/yQAT7Uf6tJbxsmOkJZPTcrhVeFgdu570P7i3OxvPH5HUeqFDJFT5Mhc3NP0P/bu
	gUKNf9t7zNhQRwLGvzfk9RGEobV0sqV3PfIXNU5c74lPR3s2aKBjV1W09FrlktFI
	PBUS3sA+5ME48pCnVQDtMIR+ZAh05Za4moIf8kvGrLBcjV7bmeaPfvUmSCq75G6x
	VFtVWQthXbG9RhCMfupSBh60JyKFlfZSUtMo81en7Ig==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4han3h8079-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 21:22:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69F1MKSV029721
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 21:22:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Oct 2026 21:22:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Oct 2026 21:22:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Oct 2026 21:22:20 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69F1M7j9003376;
	Wed, 14 Oct 2026 21:22:10 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v4 0/2] Add support for Analog Devices MAX30210
Date: Thu, 15 Oct 2026 09:21:57 +0800
Message-ID: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 0ajY7b4rZKWQDjP94zMhAmDReEhoxUoj
X-Proofpoint-ORIG-GUID: 0ajY7b4rZKWQDjP94zMhAmDReEhoxUoj
X-Authority-Analysis: v=2.4 cv=ZduIpcVA c=1 sm=1 tr=0 ts=6ad02acd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=mq-ZwdqjH7F0OScFwZYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNCBTYWx0ZWRfX55dD6C2WltiR
 sbXoB8rL+nIoOrFeCeFgrBeT18HJ/NbgQOs9mQXZl0brlKBi629846i9HrK+y7NYuQofnrJajv6
 M/ybGAAYROcCah3ad1OH7EPuda54vvvqbDC3gjEnHOhCs5id3HLw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNCBTYWx0ZWRfXxH+y76jM6B7W
 RJAWPASD9hot0vQZD/w3DItcUI4g3igX87b/nJtc7teueUNtLcTnKGL25Jmlf04/ql3jDvoUVIU
 Hda7QQpdU5OPnbihYNx8tWWzp4bZaRGyo184GdPT9V5X1DRfqjd8qDH6RJBoS0TC8ZDO6VEiSrT
 rgkiP3AS2w07mnwUAoM7pHEfJe0eVnmdF4wh7t1Zq/0LHEJShB5ZFEeIbwl984+X5Kai6r/cIm7
 BjyncHFegPr7AA+rcEXnFG4cM+QgVOTa4ZVxNM2ZV1WFSnCKuMrbLgPkWspt8yeM4Srt8RMdYlG
 AZDkCJzLvU3EjIvZergUNqA6TrcIxnjB/ReP/JklU7/1peXCGYKr5qIcclzOCeVcF/XHuwmCX9x
 Yy6WFSMcXU77KP02Ofd5iZA6EcYmouUjcwMrRhqhf6QrxOrE7Wx5gUK9ceD8rNFRD0+OCYiwSHf
 bXxTasC9o/5ALCd7PrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150004

This series adds support for the Analog Devices MAX30210 I2C
temperature sensor.

The device provides a 16-bit temperature output and includes
features such as a hardware FIFO, programmable sampling rate,
threshold alarms, and interrupt support. These capabilities map
naturally to the IIO subsystem, particularly the buffered interface
and event framework -- hwmon has no equivalent buffered-capture
framework, and its alarm attributes are polled rather than
interrupt-driven, so there is no path to supporting the FIFO or the
autonomous threshold comparators there.

Although the MAX30210 belongs to the same device family as the
MAX30208, it is implemented as a separate driver. The MAX30210 has
a significantly different feature set, including a 64-sample hardware
FIFO with configurable watermark interrupts, programmable sampling
rates, and event support. These features require buffered operation
and IRQ-driven data handling which are not present in the MAX30208
driver (which talks to the device directly via i2c_smbus_*() calls
with no regmap, and has no IIO buffer or event interface at all).

In addition, the MAX30210 uses a different register map and a more
flexible I2C address selection scheme. Supporting both devices in a
single driver would introduce substantial conditional logic, so a
separate driver keeps the implementation simpler and easier to
maintain.

Patch 1 adds the devicetree binding.
Patch 2 adds the IIO driver implementation.

Changes since v3:
https://lore.kernel.org/all/cover.1789032019.git.johnerasmusmari.geronimo@analog.com/
- regmap_noinc_read() for FIFO reads instead of regmap_bulk_read(),
  which (combined with regmap caching) could silently return stale
  cached values of unrelated registers instead of real FIFO data.
- Mark both bytes of TEMP_DATA_REG volatile for the same reason.
- Decouple threshold events from the buffer via a refcounted
  autoconv_get()/autoconv_put() pair, so either can be used
  independently or concurrently.
- Don't let a single-shot direct-mode read race with/clobber
  autonomous conversion mode if a threshold event or the buffer is
  already using it -- return -EBUSY instead.
- Don't hard-fail probe when there is no interrupt; fall back to
  direct-mode-only operation.
- Fix devm teardown ordering so an in-flight interrupt can't use a
  freed event interface on removal.
- Re-assert the powerdown GPIO on removal so the device reaches
  standby instead of staying powered indefinitely.
- Style/API fixes from review (register/field grouping, _MASK
  naming, FIELD_PREP/regmap_assign_bits usage, C99 initializers,
  dropped redundant i2c_check_functionality() check, comment
  cleanup).

All of the above have been verified on real MAX30210 hardware
(Raspberry Pi 4 test rig), including the no-IRQ fallback, buffer and
event refcounting (independently and concurrently), rmmod/insmod
under live interrupts, powerdown GPIO assertion on removal, and FIFO
flush correctness.

Changes since v2:
https://lore.kernel.org/all/20260304122509.67931-1-johnerasmusmari.geronimo@analog.com/
- Fix FIFO byte-count handling and sample decoding.
- Fix IIO debug register read/write access.
- Validate event threshold values and sampling-frequency register values.
- Return the correct sampling-frequency format and reject direct reads
  while buffered capture is enabled.
- Clean up the Kconfig entry and device-tree supply declaration.

John Erasmus Mari Geronimo (2):
  dt-bindings: iio: temperature: add ADI MAX30210
  iio: temperature: add support for Analog Devices MAX30210

 .../iio/temperature/adi,max30210.yaml         |  61 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/temperature/Kconfig               |  13 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/max30210.c            | 788 ++++++++++++++++++
 5 files changed, 871 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
 create mode 100644 drivers/iio/temperature/max30210.c

-- 
2.34.1

