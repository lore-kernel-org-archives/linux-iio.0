Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816331;
	b=3LgThUpGyrkfGB5Mtx/6WkDXV/i90QC3l5KuJ4y3FlRxy1J0/736masIlENGHk58FMAT
	 vDD1rM+dF+8tD/oKQUU/C8ou070BRU36a71XVYnowi2hn5JRUH07ariItsje6EzAeRZSr
	 W9jg1r7ior5A76cZwqbR9n1GMl3TG227QwiD/hzu1J3Z1/eAR8KIRYlDRcF35hXEwy6Kv
	 7KdoYvUTi8s3nZp+zzkgP/OSx5DxYTQBQnpQINrsjIs4Z62bPUuPoMNytviJsuIGUOTva
	 OD0xf+bP3Lf8i3sWwChjEbqOGH7TxCZxL9nOfgtinWMPJRXMT2cYxDutDq+KI1TyJIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816331;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nEVzYlx+Lk2dPBf9WjOTOxSVHzV+lgZMcux5bh/7iwI=;
	b=CdhAlwQ4/qwGkSOlG1IPxwhfGcAUIdp6kCMnLJ5bKy9a82P7LfLyU+90X9XRzQI3TgHA
	 BDEykYsHclLaB693a8bcwrSpBWzMCeGPdQUT1Tw/2/fX5lYaMlWobibKTzmzZL7tOOgMn
	 bwMSxFhDVpjFQl4Z6mrB6TdfHjYou7TV/v1wIT0OlZO568LbzO/OckfhVssdLgsXOHPIg
	 M08CDa8oV6pRoPOSfbnwlGu+h/OsJKddveddxOVX6HXssOp+9GOxeLqs0uyo+euEyf1yP
	 9SX0+Kl/CVUGZUQk3swX8o1SxMSArH6QKeflcZ78dkWaZ948kLcVfMDT2kAzS/mw+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Nw1nJFXk;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gBABFCeT;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2028606A31C;
	Fri, 27 Nov 2026 21:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2028606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Nw1nJFXk;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gBABFCeT
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJBeCq1737341;
	Fri, 27 Nov 2026 16:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=nEVzYlx+Lk2dPBf9
	WjOTOxSVHzV+lgZMcux5bh/7iwI=; b=Nw1nJFXkOz9a7GQahMrT86uyzukoQfnq
	wboiAjczZW+N3D44o25ziBlP2zxer76rPZos/mdU5AzQqqdeyS5Z3pqsrY3A+8Sq
	uqR5tO1nI4Wvn9DRyAE6YRPYIUuZ00S/5IGGaf3qQyicUQKp8lja8BMDkKU5/5Xr
	oN/TPwuzmkIFYI/PWZRkjPpTJcJ8dTme56cbTFhMSlxkNCyDuVqHlwTSzUXpS7OL
	QXIr1XjiCQBMeBT1uhhtTUpb4aPBaenoAstg7zUt8b+fEFC8TFlJdhqUZ6BJ03K3
	V6XSm4cNykFyo3/1QmN3bvhhv+3QcFHgeEt/5NQErP5PUO0TOPGQ6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=nEVzYlx+Lk2dPBf9WjOTOxSVHzV
	+lgZMcux5bh/7iwI=; b=gBABFCeTLaIzEMjUxh2AiIVyoeNVUX652j9Mevvb4eW
	l2xuHS6URsGeCR8Y9TW2v6EPLEn0w41i1CRQGvD4ELkEtF5UTX99WCKEIUap17Hj
	i0GouKHNtWLFEaWu4wo8VQhqtCAolKhWdeFN+iqDa0NXXoVkt97kNR9iPOS5yPJ8
	bC+VdjsotAdnzbNgu8lGl/yyPZJ/v7RepKUO/DgF+hLts4lH5wYZ5GpBmi8kRCUi
	d0q4meXKIJOq02lpACYXMo7XwJSAU/TmBr7QtHJ4wdXa82uZ7SEEdGDTaDQRi87j
	okZxJTATKBVfy9OT5VWghxv2FoOpYtnIvx2Ph4HfzRw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j63xubt9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 16:52:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6ARLpxL1056994
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Nov 2026 16:51:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 16:51:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 27 Nov 2026 16:51:59 -0500
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6ARLpiV6018618;
	Fri, 27 Nov 2026 16:51:47 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/5] Add support for ADA4355
Date: Fri, 27 Nov 2026 18:51:32 -0300
Message-ID: <cover.1795816065.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.47.3
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX0Ehgf5TdmNOB
 m9e73BjWLt5GhjNQKBljtTdtJEufRuT9XLlxtHL3bVLNsPlQIhVs8+Ia7nb/GLOzzHdJb5CU5oU
 fJSEhPbYnt98NL1fVat1ROpY3yjHW74ko4ug8KwZEcPq+L01fbu1
X-Proofpoint-GUID: 6e32RiOb0xxRBa3sbmypql6EqKmuDou3
X-Proofpoint-ORIG-GUID: 6e32RiOb0xxRBa3sbmypql6EqKmuDou3
X-Authority-Analysis: v=2.4 cv=Qt3LTlyd c=1 sm=1 tr=0 ts=6b09fb80 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=D3_y2mPxVdeFbr8-D3EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX6tOboBh+6jRv
 +7TGAShfgE3VKvMqQbs0WzP4fRPKBizFGOoMauqDgTq5efju050otLdfO6CrWgeG7ckCzIKHk7X
 bjq8i3Gk+Zjhw8SOzS/MgnpHWbdAc/aeq6VBzf58rt5O152QBMCdHr3Ol3hh+CwJr6DnZReh3tm
 orqQ+tlBkuuiNfQiUUFTxcGWsm4yDZYT/VlPp6O1XwKwsCYAWMKlh6+0pXDPxo589F5C3LLloJ7
 ThI58RxRZ6r82iCNSZuuCgEJgmvPFjVRy24OZAKLuF6/of2tk8dsCm8+z0gBlBOITtLMgKzykXz
 yoTxNJDbP5OdMzhnnI16tbdOPr5MWVrGvBkHEo/fyfhVA90xqPpKY+MNq+u7a80lea9QPWUhVYu
 FN6+DoO1fTjLHXhdqsFa6DaeDS5gGoHhaokR+1U45tRAARK8A32eRofaU8xXCeAyo0buhvBO/O4
 3g9ZJ0k7g659fWodZ+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270087

ADA4355 (and ADA4356) are programmable transimpedance, current to bits receivers.
ADA4356 main difference from ADA4355 is the set of configurable transimpedance
(Tz) options which result in different scaling to miliampere units.

Change log v1 -> v2:
[device tree]
- Added explanation about why the parts can have a fallback compatible.
[IIO]
- Improved backend interface documentation.
- Fixed mistake on the scale to mA.
- Made reads to the mA scale also synch with scale write operations.
- Set buffer setup ops to enable backend channel.
- Enabled vcc supply.
- Stop calibration on lane calibration error.
- Removed unneeded includes
- Alternative in_range check.
- Declaring loop counters within loop declaration.
- Unknown chip ID message update.
- No longer keeping extra IIO channel pointer in state struct.

Previous submissions:
  v1: https://lore.kernel.org/linux-iio/cover.1795003864.git.marcelo.schmitt@analog.com/


With best regards,
Marcelo


Marcelo Schmitt (5):
  iio: backend: Add calibration source interface
  dt-bindings: iio: adc: Add AXI ADA4355 IP CORE
  iio: adc: adi-axi-adc: Support AXI ADA4355 IP core
  dt-bindings: iio: adc: Add ADA4355
  iio: adc: Add support for ADA4355 and similar ADCs

 .../bindings/iio/adc/adi,ada4355.yaml         | 104 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   1 +
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ada4355.c                     | 822 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  66 ++
 drivers/iio/industrialio-backend.c            |  28 +
 include/linux/iio/backend.h                   |  22 +
 9 files changed, 1063 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
 create mode 100644 drivers/iio/adc/ada4355.c


base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d
-- 
2.53.0

