Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF212DA768;
	Fri, 21 Aug 2026 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335698; cv=none; b=ilIhFDpw3GnX1zqU6ht0hGAjLGBOMyw3ZfziDkoNdM9ZSB9UpQFImQgwLpDe8T0UzIKlK1RvYzweBI/CTNjAQOq7Bhd9G/QIi59v1Mjtse/3sQUgbljlx95AmLO+PLhdgc9C+pdWRQkw5kbfbgvg/N4c8XkS/HWZ0hNSVcmnxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335698; c=relaxed/simple;
	bh=EpuRcNeKWs2jtosGDHzsVHUH8iVRd/v8Ir8Xwf66k+s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fknwV7eTPkR7Tg111xp6bh0oLc6xZUKwVETXbsNl0Efm5VvrlNacub66uQIcRrLnh88W0JNTB0DF3GvEpv6m8duGwF6KIcjyt+Cc5LJofyctQ4zk39VQPXD6z1qms5d5b1b+Kme1RWm+twePINewtw8Tsyk+AmspzLRwrHjVIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UpAD+bd/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UpAD+bd/"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LI4JGe3253703;
	Fri, 21 Aug 2026 14:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=TihZS9sXHf8Pcg/gyqzk+5OJ0Ih
	JH+7Fuh4cT4bIhiI=; b=UpAD+bd/VMVY6amKTgqEWyRMaRzkilGFVwqoCtjhcQE
	F/VoXJ99U92WYOTEqH+paVWUlRZt5bXh5mqOH9qyRUcrJmaHE9eD4bq39TYmGdv0
	QwZln7qjSS7Rw8tz3rppBHtdvLOuJbmhjq2XGWn+DzysDuEqzGYQzSwnen5aD3vt
	pD4RFobSjRD6tcPa2wo7ps3jxSexrvd3PGWaYkZu/PIfn4cx3gyoA3NXdIk5UWKK
	wpwHnBwOiEdlxeYS4c0BdfzEaJX5PmzLQSIzndqbmWVBf+EkO8sLWJ+vQN7BzjNb
	5g6ePUwRlorExY/08MkdbNLUKq3TDAFWji+BdLZw83w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g6rga8qru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:08:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LI8BQb064931
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 14:08:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Aug
 2026 14:08:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 14:08:11 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LI80fK032181;
	Fri, 21 Aug 2026 14:08:02 -0400
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
Subject: [PATCH v3 0/4] iio: accel: adxl367: add INT2 interrupt pin support
Date: Fri, 21 Aug 2026 21:07:49 +0300
Message-ID: <20260821180753.4633-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: G7DrPL2g_jS71LPHl0pTIHkUTbfIdUW_
X-Proofpoint-GUID: G7DrPL2g_jS71LPHl0pTIHkUTbfIdUW_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX+SGOslq2FMrF
 4kYNRDJKKlK11G8p+Flrh3DODYSGVWw/31+EkoPPyOQq9i/m484kWcdd78tWu72Z7sFra8TNzly
 P3mnquozqjlAfchx7qQj+QS+Y+fAzaqciJvg+TLeqoZPGr6YyAXI
X-Authority-Analysis: v=2.4 cv=fcCdDUQF c=1 sm=1 tr=0 ts=6a88940c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=bGhLtI4Elc35aERHuvsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX1aQmuyS5AHtJ
 yzVm7iAl9e0iny0j+nhWJrlFvaLd9tbVxA1bBJvAL/ESLmv1IJEScc+LK8y/Ea2kviKJYFn+awj
 63AeAgRPo45Ts6AhUqIuSrqZH1t5nuA4pU+R2ODO0KFq7o+UqXAT8lhx2k2gdZOPXqPsGPCGY0I
 zHkgUYUguPFNTji6oMVKzKbmqGYLY9HsMb9haut4uCgrIADxvtQ8gbAA3xqxuVeUyaXWe6nXwQW
 +2BR9EYHUQd0lMz5ekV7xI5zblgNBw56hqiQ2dBL1uvV90U+GsqbTSF1gjjGE6sX8Zfuld6qlUM
 x8kaZwrPgx4zqhPvwcsSgij519mLCzTAVJvPmqyZFaPCKp1EFwxGRHpO25U6RfsMK+legS/0OtH
 rtr/sp1+uzVYLyAYtS28ellPXVdW9etzVZ94e3HApDiEwUnEwQMyuzZUKl0L2qWlBZ8UwIJCZpL
 CeKsJT0GcMWQQ+JhyaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210143

The ADXL367 exposes two independent interrupt output pins, INT1 and INT2,
each with its own event mapping register. The driver has always hardcoded
INT1, so a board that routes only INT2 to the host never receives
interrupts. This series lets the driver pick the interrupt map register
based on the interrupt-names device tree property.

v3 addresses review feedback on the driver patch: the interrupt number
returned by fwnode_irq_get_byname() is now used for the request, so the
requested line always matches the routed INTMAP register even if the
interrupts are listed in an unexpected order. A precursor patch converts
the existing regmap_update_bits(..., en ? mask : 0) helpers to
regmap_assign_bits() as suggested during review.

Changes in v3:
- New precursor patch converting the boolean regmap_update_bits() helpers
  to regmap_assign_bits().
- Use the fwnode_irq_get_byname() interrupt number for
  devm_request_threaded_irq() in the INT2 patch.
- Rebased on the latest togreg/testing.

Antoniu Miclaus (4):
  dt-bindings: iio: update unreachable maintainer entries
  dt-bindings: iio: accel: adi,adxl367: add interrupt-names
  iio: accel: adxl367: use regmap_assign_bits()
  iio: accel: adxl367: add support for INT2 interrupt pin

 .../bindings/iio/accel/adi,adxl367.yaml       | 13 ++++-
 .../bindings/iio/adc/adi,ad4130.yaml          |  3 +-
 .../bindings/iio/addac/adi,ad74115.yaml       |  3 +-
 .../bindings/iio/addac/adi,ad74413r.yaml      |  3 +-
 MAINTAINERS                                   |  4 ++
 drivers/iio/accel/adxl367.c                   | 47 +++++++++++++++----
 6 files changed, 60 insertions(+), 13 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.43.0

