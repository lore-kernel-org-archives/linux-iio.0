Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FF4CCDF7;
	Tue, 15 Sep 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499511; cv=none; b=EqLoRx67Zm50HiT/1YG8oX9BZ3l1kBLt4AmawkEuC6L0nProX9NEzhgDTLNGy9JF9G6+lx4I7ns5zP0nnOeR5BJUFRtCIb8/U693lgtgtSgxeYL8XqT95OdV7BncHVawCbeg1zTnfARNEmxpFTCFxqYBo9DWLjcM3FFtvGtzkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499511; c=relaxed/simple;
	bh=90xPWqAdb/r9Jqg0b764vPjI8KHRN3w4U7wN92DvqZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y1rfCe1VSWEM9LfgEufHMzP0T8dkUiJcEw0SBIeDlzPix/MlEojqX652ENJ7HIwsmUyF9657I6cJ3Dw2/v44CTCc/R7ixKHC/PVvjW8d9Tiw7qYssssmx8RcLTnMJ7mbZ+N8AJ2BfaEZshPCjuGVnaUopJq7xqD6m0SlZ4u9St4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KiVfC53U; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KiVfC53U"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsrFZ1755525;
	Tue, 15 Sep 2026 15:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=PvnR9uqvPLxE+bne+9bG7RcIMwv
	tt+8dp5fE4ZXg0Wc=; b=KiVfC53UQlrllJP2q/LKR+ZSw6lW6ktiS7o+G/qNpsC
	RuDtjTrymVKU8eOI+vXs/pXCpZqbefH6DvdHrAQJochfVoMUQ3u+bkJNWVK8DDNR
	Ft57ygcCUTjdHsNwR1U55qXU3dvrmKsnwkHhCBdiL1652GRyMXWwkbXXUWmvm2PY
	k4WoKPEn2ettadgEj7G4qw5zGIo6UkPDM2Sgw8bwrJwhCNnHh9YSRZrpw+r+e5xQ
	ZP26ggv4uqpAyS80mi4NMdxOyYQ6+FhEXBXg/18kQO521VvrrsatkNVg90x4m8yP
	hqn7Ve1oShxr9vT0dOtwxiB1rphbNo2wPgAzphqCAig==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq43rjpv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:11:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJBerS018822
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:11:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:11:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:11:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:11:39 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJBPma028079;
	Tue, 15 Sep 2026 15:11:28 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 00/15] iio: adc: ad4134: Enable greater sample rate data capture
Date: Tue, 15 Sep 2026 16:11:19 -0300
Message-ID: <cover.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: mtUOAYmPB_IjGEix6dWPRCHxVogc5pDv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI3OSBTYWx0ZWRfX3Ksl3XXkIiUa
 0us4V1voh4b8Gxeas1Yn3HTJuuRlQJh1SQNv9iX2impFzVrlvqVrfYBxnGAwClXdtbQ6ahDeT4m
 mvfQq2IF58C1yOkeQt3UdltJQYj4JcsK5y7evZqrP3A1YGsjp02k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI3OSBTYWx0ZWRfXztL+CiyCMUYV
 tCRPc796EE7HmlHunRGuosnqvSvarQtyqPhYCt0bWW2YCj1o3xmDrGfFkrvji/UaB7H8Q5sqqkY
 uRWYMmRrwedCeGSqXGzb4M/rDIIpfGd2weqr+q7dYWHon2d1Cdt8AZGvZgW6JPF7HKpyfMmPens
 Lx5dqv3I9b3kJQH4frjBQjzlVJ3fifLavn9FPiOk0zMB2ie+kH07JlNw8rr0LBHnrTHGwslZ4OS
 jVktND8L44C+2HLOsUsuANY2np/tVSobXF0PzoHPE62xgFcxCVXr+R+FQa6QXX3MaWaHCp7L1b7
 5xWi1XSZzo/p9pa0mZr5nObgXggtzE9eNVqQANiRGCVqxBjIvKupTwBxXzUweIM7b71vWUyY2Rv
 7nE9gLjagdrXk7jdoKjS0zLT8JsnkdRgm+UbNC3n2tQjrOHL/kg1pr6jyVZyHSs84HIvoyXVf3l
 hZXV+HdurwG5s+UPaXQ==
X-Authority-Analysis: v=2.4 cv=HZeB3SE8 c=1 sm=1 tr=0 ts=6aa9986d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=5ww8hBo5wzc8OBkiUfgA:9
X-Proofpoint-GUID: mtUOAYmPB_IjGEix6dWPRCHxVogc5pDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150279

Extend AD4134 support to enable greater sample rate data capture. To achieve
that, provide control of digital filter type selection. The default filter
type on device power up only supports sample rates up to 374 kSPS. In addition
to that, enable interfacing with AD4134 in SPI 4-wire mode that can support
reading ADC sample data through multiple wires. Finally, use SPI offloading
to speed up data transfers at up to 1.49 MSPS.

Features being added:
- Data filter type selection.
- Triggered buffer data read.
- SPI 4-wire mode.
- High speed data capture with SPI offloading.
- Device tree doc updates to reflect previously missing chip characteristics.

Minor improvements (introduced before the new features):
- Sign extend sample data. [NEW FIXES PATCH]
- Fix typo in vendor name.
- Drop import to empty name space.
- Update include list to comply with IWYU principles.
- Serialize single-read operations.
- Run shorter transfers when CRC is disabled.


The updates in v2 tackle all applicable suggestions from reviewers and from
automated tests/reviews/AI.

Change log v1 -> v2:
[device tree]
- Set default for adi,spi-mode property.
- Added '#daisy-chained-devices' property.
- Documented constraints for adi,spi-mode + #daisy-chained-devices combinations.
- Documented external multiplexer usage. [NEW PATCH]
[IIO]
- Sign extended ADC sample data for correct delivery of negative ADC input
  difference.
- Now also fixing Analog Devices possessive suffix usage.
- Added {} to delimit scoped mutex usage context in single-sample read.
- Tidy up code for filter select support. 
- Fixed IIO scan buffer size and single-read loop.
- No longer memcpy() with same pointer for source and destination.
- Always delimit guard()() with a blank line.
- Fail on unsupported adi,spi-mode.
- Now properly initializing access mode mutex.
- Highlighted usage of hardware external to AD4134 chip.
- Added comment about mux state switch logic.
- Suggestive name for auxiliary local variables.
- Updated preparation flow for ad4134_data_read().
- Error out on min I/O + offload config (currently not being supported).
- Preserved triggered buffer setup callbacks.
- Used pahole to reduce memory holes in ad4134_state struct.
- Improved PWM setup readability, update allowed scan_mask codestyle.
- Docs: Improved AD4134 connection diagrams.

Previous submissions:
  v1: https://lore.kernel.org/linux-iio/cover.1788368334.git.marcelo.schmitt@analog.com/


With best regards,
Marcelo

Marcelo Schmitt (15):
  iio: adc: ad4134: Sign extend sample data
  iio: Fix typo in vendor name
  iio: adc: ad4134: Drop import to empty name space
  iio: adc: ad4134: Update include list to comply with IWYU principles
  iio: adc: ad4134: Serialize single-read operations
  iio: adc: ad4134: Run shorter transfers when CRC is disabled
  iio: adc: ad4134: Add support for digital filter type selection
  iio: adc: ad4134: Support buffered data read
  dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
  dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
  iio: adc: ad4134: Support SPI 4-wire mode
  dt-bindings: iio: adc: adi,ad4134: Document PWM usage
  dt-bindings: iio: adc: adi,ad4134: Add high data throughput example
  iio: adc: ad4134: Support high-speed data capture
  Docs: iio: Add AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          | 111 ++-
 Documentation/iio/ad4134.rst                  | 130 +++
 Documentation/iio/ade9000.rst                 |   2 +-
 Documentation/iio/adis16475.rst               |   2 +-
 Documentation/iio/adis16480.rst               |   2 +-
 Documentation/iio/adis16550.rst               |   2 +-
 Documentation/iio/adxl313.rst                 |   2 +-
 Documentation/iio/adxl345.rst                 |   2 +-
 Documentation/iio/adxl380.rst                 |   2 +-
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   1 +
 drivers/iio/adc/Kconfig                       |  20 +-
 drivers/iio/adc/ad4134.c                      | 751 +++++++++++++++++-
 drivers/iio/dac/ad3552r.c                     |   2 +-
 14 files changed, 985 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/iio/ad4134.rst


base-commit: 9c464e7473f762cee4c031a09da04f65a1c65d49
-- 
2.53.0

