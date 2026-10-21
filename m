Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547810;
	b=YF8558Fdd7Tz5Jsoue0WJerzv5Cb1QlUSk5LEolrIq3j82MlnZasTnGZkKbmDXn3cig5
	 7OM94fmXDYyPKz4EuBfaMw9GFOIAJYro+0VT33IZBTmMQSZb5cbS6gDznKnibWh5lWjN9
	 qJXWtMcdYqTbM4R4TkrOyJU3OYDnDMJiXBGQFiyzsRUhqO/mHx+F5cBIB3dN6gm9q3QeS
	 uwEkWA/uM/utyX3hL9SxftF2szuksixm6UkkVoKJ2rqfr7p97MvRvkbEJOjJXfX+HQCGl
	 7VgOiG3ZMvOCP32k+5bLz8OTrtUWJLI8TRv3mv0Bqz1Ma14hBdvydMuuRYsvJIG2q5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547810;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6WqH+jPBUitz8VRD6x+db+FlO8TRcDj3VA1Cds0bDUE=;
	b=FbQ16E446J+ovEt77ovgCMaSKtvCIhPEMY5ac6qoBtuhdY7C2fJhY+dbgFmnKM3D8wym
	 12EUF7A+nSVEjeWXQNyw0vo60uM4i3KQqZSYeOL5ArCDvTBXhxrIBdcG7kS/FusbNa7bo
	 2IUnmFVWITX6XK+kWfYrVOY6fzrDbAk85+e2Tb4qCCb5Y+DrjVUE388mtDNUpybaRUdB9
	 uxmC/vhzNmAW1hf0WPLEXzCurKPAEH1k3cJziaQsq6/UovklYc0rQK0hHfZr+u+5AFhfk
	 gtV2ohRsD4u/8FWNgA4UrXf0uS1iroLLgHYQ56keaQbJRIfUY0tC7ozgYJcfznT5DOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GCNAuDPV;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jNGO2TDN;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E000606A323;
	Wed, 21 Oct 2026 01:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E000606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GCNAuDPV;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jNGO2TDN
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L12wnP2442078;
	Tue, 20 Oct 2026 21:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=6WqH+jPBUitz8VRD
	6x+db+FlO8TRcDj3VA1Cds0bDUE=; b=GCNAuDPVje1jEcIiCcsvocw94YaT7hUK
	pDRP2tEwzX4/IYbi4cWa1tWHh0+LvOpnKbjpoZIQjOb7+8VbBDwbtBG3EHZ7vECq
	Sz1nGxSofvX3E5rC4JPGEpv9LuMrr7wHRa6uAEOHvBIF8wU8mZg8Be9lHipwNNPr
	gq54GQuDVB6qBPt+zZrHtrMgBKhQiKp9slaSKbAYtgRxds2LIkJ+ZFKFLZcXNOoQ
	67rpmrZKo/uLwiVf1bglgI+Yk1PLZvt+8eKyCIIgu6F9m2sUk1/5K1jZXh2giL+Q
	RPa6YLvJA4hKzjR3kbLVAoKCrbY550d2lxMoVFN2S6LU2XCatEinMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=6WqH+jPBUitz8VRD6x+db+FlO8T
	RcDj3VA1Cds0bDUE=; b=jNGO2TDNm4bDA9JuzTeJP8OGI2fQWJeh4IupJDygmgJ
	QwcKTRnjmWJDqpTRWOfYY1gkvwe7xJGOKVUhp/o7tA/3aJ0EI7ME/JV4ZC+nqdLx
	SKFLOHVKNf+T5tbQthlGOmzaF6f0Ds4OG13Vst2kch+wj4Iz/WYoVG47xwy18wP3
	Ya6S900F46g7ylHMeoAa+lNJ4INNkEdULc83kdnYtx6npedYs/KAHaWwpZkBiGlE
	fiV5s34Wc77m5yGUseWbnhCE8pElDXCYYdfXdI5EqX9TcRIi0dQ6HqamY9hO9wZn
	0vcNWwyJIFAKIQFRMOg8Qj+KbGKM7PzbNer75sSfqdA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hef2khjev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:56:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69L1ugrl062266
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:56:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 20 Oct 2026 21:56:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 20 Oct 2026 21:56:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:56:42 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1uUvL029040;
	Tue, 20 Oct 2026 21:56:32 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 0/9] spi: add multi-CS and multi-chip aggregation support
Date: Tue, 20 Oct 2026 22:56:22 -0300
Message-ID: <cover.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfXwfHJZcMVzum3
 ajBNVP9yj8bNrR8FeBeMCyu8z33qcYddABPumlXNt9SQ/+tBcJot7xEEWP94W+zUabqAmgKoueN
 Seshoh3C5Ar8aN/ZKo6FDfqaUjm4hN4J7JDNYMT5mKDunbwbMvyxqCJAjAJDSKBbHJr2xVeazhS
 F0DwQAxwTxa6VTG5SVcTsatomXhhXFKFSAH2pGMZGt87bKjhRnoWXbybOahx/3lhpZf/OksXhv+
 AFkyBdzmNIYlUkbOnf4TlkbhUhHaurGDSbOAlk4R0VMBKb/d4ws4vk6s3B7OFCg3/F92AeEvcsI
 T+b3Zu4o6tIiwJP4wRlSsvmJcKIuV6OxpPDhkh3oqZcdMgzSy2jnkzv8EzvDBzxoKkuxfz62yJe
 zyDfIAs36yIfB0/X2CWIR7o2ZyBThmUdUnS8kFPLU4LoRGQhf/B/f6BXRzYTK0OJl1oQp9ZKUQE
 GuIyNfenTBLxbaUkUOw==
X-Proofpoint-GUID: IiuM_EC8ofg0LFlUnzDusziA9Mp2otRb
X-Authority-Analysis: v=2.4 cv=KIHPn1Fo c=1 sm=1 tr=0 ts=6ad81bdc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=sP3hys8OD1pSQKjoStgA:9
X-Proofpoint-ORIG-GUID: IiuM_EC8ofg0LFlUnzDusziA9Mp2otRb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfXzB+5d1BKeiMq
 TfSk/DmDM7/d8RBNjqsqY8rj7ODFmjeLJsdRQm0DI/D3CAmvvXrGfh1BMVg8pCnPGMsx4AM8b53
 KbCOToSEDPSTCy9rqgFW9d/mZrCTg7UbT9mUkuAvypxxrLKw2+Eq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210007

This series adds support for multi-CS devices and ancillary devices with
lanes, to enable the multi-device setup described in [1], where multiple
AD7768-1 ADCs are wired to the same controller in a synchronized sampling
configuration, and the limitation noted in [2], where no SPI controller 
completely handles logical chip selects beyond the first one.

The first part of the set addresses multi-CS support. Some SPI controllers
can assert multiple chip selects simultaneously, but the existing code
hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
preventing this from working. The spi device name pattern is modified to
include all active CS lines in range format, so multi-CS devices are 
distinguishable in sysfs.

The second part introduces spi_new_ancillary_device_with_lane() and its
devm variant, used here to create subdevices that bind the CS with a 
corresponding rx and tx lane from the parent device. With that we can 
handle each device individually when there are separate data lanes.

The last part uses the above infrastructure in the AD7768-1 driver to
support aggregating multiple chips as a single IIO device. The number of
sub-devices is derived from the number of CS lines. IIO channels are
allocated dynamically, buffered capture is restricted to the full-device
scan mask, and SPI offload mode enables SPI_MULTI_LANE_MODE_STRIPE to
interleave samples from all lanes into the DMA stream.

---
v4 summary:
* Included patch to add new spi-cs-composite property to the bindings,
  to allow multi-CS devices.
* Added new patch restricting CS logical values to a contiguous sequence.
* Device name for multi-CS devices is now formatted as range (the 
  contiguous restriction makes it possible) instead of a list.
* Introduced KUnit tests for SPI core CS management, following the SPI DMA
  pattern.
* Addressed other minor suggestions, see individual patches. Please refer
  to "OBS For V4" section before proceeding.
* Link to v3: https://lore.kernel.org/linux-spi/cover.1786973376.git.Jonathan.Santos@analog.com/T/#t

v3 summary:
* Added new patch to document the properties for multidevice support on 
  ad7768-1 bindings.
* Refactored "spi: introduce SPI ancillary device with lanes" patch
  to reduce duplicated code using helper functions.
* Modified channel mask allocation on ad7768_parse_aaf_gain() to get 
  a static value, Since we assume the family is single channel. Added a 
  comment explaining.
* Addressed other minor suggestions, see individual patches. Please refer
  to "OBS For V3" section before proceeding.
* Link to v2: https://lore.kernel.org/linux-spi/cover.1785725359.git.Jonathan.Santos@analog.com/T/#t

v2 summary:
* Removed the per-transfer CS mask patches, the devices will be 
  individually handled by the ancillary device feature.
* Removed dynamic multilane selection patches. The lane is bound to the 
  CS using the new spi_new_ancillary_device_with_lane() feature.
* Included a use case patch modifying the AD7768-1 driver to support 
  multidevice aggregation.
* Link to v1: https://lore.kernel.org/linux-spi/cover.1783729282.git.Jonathan.Santos@analog.com/T/#t

OBS For V4: An alternative to the 'spi-cs-composite' property would be a
separate composite device holding all CS in its cs_index_mask (as suggested
by David), while the main device and the ancillaries are used for
individual access. That approach was dropped because the composite device
claims chip selects already taken by its siblings (the main device and the
ancillaries), and the CS conflict check only skips the parent device, not
siblings. Relaxing that check is not trivial, so the new property instead
lets the main device act as the composite while the ancillaries handle
individual access.

OBS For V3: The ancillary device approach was chosen over per-transfer CS
masks because it has better integration with regmap. Both approaches
require multiple regmap instances, but the CS mask approach would
additionally require custom read/write functions to route transfers to the
correct CS, while ancillary devices handle this more transparently.

David suggested adding an ancillary device field to spi_message, I guess to
enable dynamic CS-lane selection. For now, using one ancillary device per 
chip for individual access and the main SPI device for simultaneous access
seems to be sufficient. The dynamic approach can be implemented in the future
if needed.

---

[1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
[2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/

Jonathan Santos (9):
  spi: dt-bindings: Add spi-cs-composite property
  dt-bindings: iio: adc: ad7768-1: Document multidevice support
  spi: support simultaneous assertion of multiple CS
  spi: restrict CS logical values to a contiguous sequence
  spi: expand device name to include enabled CS lines for multi-CS
    devices
  spi: introduce SPI ancillary device with lanes
  spi: add KUnit tests for the multi-CS framework
  spi: spi-engine-ex: Add support for multi-CS devices
  iio: adc: ad7768-1: add support for multiple chip aggregation

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  80 +++-
 .../bindings/spi/spi-peripheral-props.yaml    |   8 +
 drivers/iio/adc/ad7768-1.c                    | 100 ++++-
 drivers/spi/.kunitconfig                      |   1 +
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   2 +-
 drivers/spi/internals.h                       |  16 +
 drivers/spi/spi-axi-spi-engine.c              |  21 +-
 drivers/spi/spi.c                             | 172 ++++++--
 drivers/spi/tests/Makefile                    |   3 +-
 drivers/spi/tests/spi-multi-cs-kunit.c        | 374 ++++++++++++++++++
 include/linux/spi/spi.h                       |   8 +
 12 files changed, 751 insertions(+), 45 deletions(-)
 create mode 100644 drivers/spi/tests/spi-multi-cs-kunit.c


base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.34.1

