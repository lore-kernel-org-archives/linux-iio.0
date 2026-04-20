Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26437F748;
	Mon, 20 Apr 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679990; cv=none; b=KLX/L/pq/dCy9NbsBKh4FS0q1rjeJFXxc+UOf/Vlz3nJ0RQ5vwqP9joi6HRyDh3mgP7Dh+OD9TAmygHSjwBjhv+16hkmivp3/6mA0l0IkhWfigTxY6DlnCwYQS2UCaEyeevzVxanfIBLWWgn6bA4YV8yA1bIktPzS81aHsswwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679990; c=relaxed/simple;
	bh=whvgWMUbU2FnO4TicRlQ9bO8ewp0EXAibTzT+03vwjo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g82hBufQcytMBfDk0b/eQO8kNSSz2an8qi63kpK1pFWrVNYCMkGl0Vb9NqnL7QBPjaj3rLb70W5f7eYi+exoI7auFV2Vu5pKYqZONIKuPd/8qeWCP9a/CoLy0G4l+4rHXdJuCRbZR4XLC99pbPurXysnn2AC4O2OFN2Q3pc0Go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NeH5cnPO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NeH5cnPO"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K4eDR0985219;
	Mon, 20 Apr 2026 06:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=s7MMB7hRfAiNa6ZxPYlhHXKVKbi
	HJmdZAUFvv/qXOlU=; b=NeH5cnPOzkK3EEjtBw/FFAp6JsQoE+dBBu9LdRK/ePC
	ayAfjbhumnathj0QccQb96Xv054fAMBecsqPJRahlIlLZoo/HQelwwmCFfB0oDH+
	ifNyr4dg5N7UIqayXR/LVP5W1nMl/NyAMk4Kf7xYoX9rKRPM2K6QrS5+6tl9HRhn
	n7w4Cu5mbWei6ecHPSmBy4wngwlN1/DhfUJ1YywhFDL+4yJqSd/ezvpIv+cw0gnd
	Zlyla5Ry2w/cgfmHWYSpPYQB0Kj8Af66rpwvQtY/r4wHyxg3ICemgM63GufuP242
	+wFLEK4SFv87mRu1fba7MnK4q9ZlBbRxN7hcWnEj6uw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dm3t1dq15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:12:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63KAChfe007695
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 06:12:43 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Apr 2026 06:12:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Apr 2026 06:12:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Apr 2026 06:12:43 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63KACUKN006189;
	Mon, 20 Apr 2026 06:12:32 -0400
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
Subject: [PATCH v9 0/3] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Mon, 20 Apr 2026 13:12:22 +0300
Message-ID: <20260420101225.4173-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=NKjlPU6g c=1 sm=1 tr=0 ts=69e5fc1c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=ZQL3YQjm8k6UoAkFqL0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5OSBTYWx0ZWRfX4du0c/GSXmDe
 kwvARPodbHF0z6s1nNvUkNw/+isgvMgA+GB5BLwTsFulpEhQW4B77J4oAV0iAHWU2VqL5rhV2ib
 fzw/0lURRCWZx0Sk0Q1LebvGfoF2OFp0BbdnTS9o6L1iHtUl/C2DWj1waWGVzHEqYYI3BCk83BK
 BoTO6CitfQQbK4lSX/uG1RMStn6y6ZGz/njRnbEwcIF/dxpIpTF/369VvLmqSnuhgpTTHry0xqk
 vDtBr1Pto/T+xFsCEXvX06XSSFdbEOFZNRtbkdIs5vL6Yjk+3sibI18MBVck+7qEvYShV0g2RGd
 H/3wkC3TUFbJeqmNn9Q4UI+EvcLiHPVKTjTWphQfZZINvcpk+zrirJrrPi2nLG46bqh8BW7lfgq
 TJeOFZrFjuCKKnGDInpMciv/QVHkfQLfWy0mVF3QVhXYnkT9lB5wkC+UOFpecESZFdRbH6FlQNk
 DPfYf/G7KJ9Y8loorAw==
X-Proofpoint-ORIG-GUID: 5pfGMVZFfkXuoSL_fH_Gu4VChPld7cJf
X-Proofpoint-GUID: 5pfGMVZFfkXuoSL_fH_Gu4VChPld7cJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200099

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

NOTE: The AD4880 driver has a cross-tree dependency on two SPI patches
that are queued in spi/for-7.1:

- ffef4123043c ("spi: allow ancillary devices to share parent's chip selects")
- 463279e58811 ("spi: add devm_spi_new_ancillary_device()")

Changes in v9:
  - Rebase on jic23/togreg
  - Add Conor's ack on dt-bindings patch

Antoniu Miclaus (3):
  iio: backend: add devm_iio_backend_get_by_index()
  dt-bindings: iio: adc: ad4080: add AD4880 support
  iio: adc: ad4080: add support for AD4880 dual-channel ADC

 .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
 drivers/iio/adc/ad4080.c                      | 257 +++++++++++++-----
 drivers/iio/industrialio-backend.c            |  53 +++-
 include/linux/iio/backend.h                   |   1 +
 4 files changed, 285 insertions(+), 79 deletions(-)


base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
-- 
2.43.0

