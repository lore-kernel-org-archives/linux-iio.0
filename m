Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6C1339B1;
	Sat, 21 Mar 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087370; cv=none; b=ffROjnqA0deP4W9MTcPNtK7FpxomHAvx2nEVXgo7mqnTAGj3F+8dKclC76K6jVUj7NBMGEUWBTE0Cn3FjQ8Et84hbo5YlfrH07pie5iY3gS1e6gJoehhrep9ixE8UyVVPKa7oqR5OeVIAVbR4hNcpBzFvT+C4wsl+900p/2Q7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087370; c=relaxed/simple;
	bh=XclwdClvcuDooBQd+jzjF+vaHEyMD7jBf0RBw+BIRhQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJjPe1z3kKOmBthkRl5ewIK4SJlR3EXGJF5rq+6peqje5owoVpxegk8ozyw8DMqEXWDK2BhkWpr0uETGEDid9vfYg83YWoPNLkdR+ii8azigIQTfdtYuSGqElqSa8Tky3VN0OBCJ/PLoRfZC/fzGHnva/BaPdmPgwxBIpQXN6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZeHTK8e+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZeHTK8e+"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L4qUE83520946;
	Sat, 21 Mar 2026 06:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=oxONm++xuomuzvf4ptoMK6qsvJJ
	jvS82s9yXDn8ipdM=; b=ZeHTK8e+jx3gm0caJ/rXLICyt3TuKkhkJagn8vrRJln
	3OA2feGpf38/RmUS6mVn2lGUUUYSPRqvU3V8lOMjwN/zQZIgmAIwsWiLXd/hClO4
	pewNxiIKRXYG9S6f2qS/SqwkWU2kqO+ON/HFTnLduc8WH58OEdGx06EiyVlz1Z9M
	F3hRvzxosd/ZIW8CXsZCCQoZXFUA4L5M/FP92i+nReHCprDevqTpZjWNxxws06X6
	RwkFREQWrBaPcKMp1hoXuuHtPozfIgawEGZ64MjSkYx3QPVhr63JOKatLNNzvM50
	4XAY81QJcMnn0YmeA8g/NiKKewx06vPQa4vY7FMZUMg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyx8m4s9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:02:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA2P1X041090
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:02:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:02:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:02:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:02:25 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA29Uq016218;
	Sat, 21 Mar 2026 06:02:11 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
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
Subject: [PATCH v7 0/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Sat, 21 Mar 2026 12:01:50 +0200
Message-ID: <20260321100154.1258-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 7hvh6mxlKoGrw2qZThjlPt2uG16Vs4vO
X-Proofpoint-GUID: 7hvh6mxlKoGrw2qZThjlPt2uG16Vs4vO
X-Authority-Analysis: v=2.4 cv=WfoBqkhX c=1 sm=1 tr=0 ts=69be6cb2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=iti6l8p0ZQHA_bzYsP0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MSBTYWx0ZWRfX6OHjGR+b5jLk
 asjEJhoqagTkuop+F6jKJ5JOq7aNN/4F9nRol4/exppwEH+hOos5YlbhTjV7E4KBBVzz7ZKRhQg
 UBwbh1x5jcFbbgicMoatq+rPPluV59JViobyiiwIKSazDQfAaEJq8KI6YmFxPoayKHYlKlB9vSa
 L2fQUs0kSjeb0zX8W+LGqqhhFqHrZAao8GlSWzOc2OVOKdq+Q49Oo3Fm7N/l7Ux1vg1LBusQzU0
 xmGP/ew7M/OfweX9LjCMbaWsFuKbazr8e8E+T72GbSbYfHkPGhcBH+QTO8InkQ9CbkdJchZbCgX
 5tsRyIND+SDK9v2NYARv+PHilXLouzlK7QqqTzSzyJRajIr9FJtYVab6bfoy2h06Uw+icSeZJNP
 2k77R2PV1GyOpg6PF/Eo1iNTaAi5f+d7NFO4s/Be7glNMKD2gU5vvrLgy63aghG94YAt57LwksF
 MemJQwv85O91iIQO/tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210081

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

Changes in v7:
  - Drop debugfs_reg_access for dual-channel AD4880 variant
  - Pass struct device * to ad4080_properties_parse() instead of
    using regmap_get_device(st->regmap[0])
  - Use 100-column limit consistently for function signatures
  - Add architecture summary to cover letter (per Andy's request)

Antoniu Miclaus (4):
  iio: backend: use __free(fwnode_handle) for automatic cleanup
  iio: backend: add devm_iio_backend_get_by_index()
  dt-bindings: iio: adc: ad4080: add AD4880 support
  iio: adc: ad4080: add support for AD4880 dual-channel ADC

 .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
 drivers/iio/adc/ad4080.c                      | 231 ++++++++++++++----
 drivers/iio/industrialio-backend.c            |  59 +++--
 include/linux/iio/backend.h                   |   1 +
 4 files changed, 273 insertions(+), 71 deletions(-)

-- 
2.43.0

