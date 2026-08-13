Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944E48CD46;
	Thu, 13 Aug 2026 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636924; cv=none; b=q/dmwBwO//KrVC+lMxnCOFOCdsnqO6pAjyBtHCeKTMxHwQ8pX/Nd1maAJ0MYJuQxKRKQfculepuYctizvfaDLFIjEwU32uP5vhhQJRuGS/+Z2gZUEJydBijuvAcQ9R1DiPAqxWUEgDcAVWpVQZrTsExp3iX6+cRRhLeML2S2ors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636924; c=relaxed/simple;
	bh=F1NuQWbthRQd7QlfgrDzcdXnOGbCc6Sn+bndmDYT29Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CntD6JFnL6h6HnCRGUp7TQZAdRUx/f0Sc/lZel967IPORfY+KMgWbYBGyvOlFbfbo5/NVPh7nLgo8YLTfe6jduxt+pI3mgCzERoRxRsqL+vd16F/U4iLApjh5bDDWoi4rD3YYjb2O4GqOr0tGDUEyli/szGHTvTenUrK25foeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Q5TXbL+G; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Q5TXbL+G"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFbRWg2230541;
	Thu, 13 Aug 2026 12:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=KMCNhcmErho0mV/OTwWBxdC3xxZ
	795pr00HggtnrfXs=; b=Q5TXbL+GvK/AURn949mIMuRRHM9JsgoiEUmBcl4o4sc
	Am96lzo18wQxiBkq55u2hbzdH2wtHgUR8bZCaBNU1NNRaSwzozf+NEtJx1r2Uydb
	aTdRrPsQ/KPLOAav9TCfZsOVOzK1kgdIqfdhNEvUzZ/ngWY9rVek/89M/br9lJ3t
	PVMI8R+wkyp2qw/yLTjQfc6JohhIY9m3pu1KAheDcUs6C4Dxjk5YpmBw2WjaA1oS
	dQ1BQPhUJODXaGC8mnGucS69zOVXxxc9AaTW4ir4Rg9EJ1GJ6l2eCM/Dz5rUGmtl
	l74PI8ewf27f8pi/gYJv8bS9du4WKhMqG6gy30MLIAg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1fjagdtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 12:01:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DG1tmY043646
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 12:01:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 12:01:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 12:01:55 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DG1hSf011651;
	Thu, 13 Aug 2026 12:01:46 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH 0/3] iio: adc: add LTC2499 features support
Date: Thu, 13 Aug 2026 19:01:34 +0300
Message-ID: <20260813160139.70000-1-andrei.stancovici@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfXzy1qYBZiPuyb
 q1RRx2UE/r69chUyjkMj4V3CI2yPIVEcKt5Jcd25F40rsRF27YhQmjn7HzhHn2lK9u0fknx62x/
 SldzlxaPFBgEfAMCm0HTBqP6T2oAcR4fFRXoe/O43Ek7LSLcMLVK
X-Authority-Analysis: v=2.4 cv=JIELdcKb c=1 sm=1 tr=0 ts=6a7dea74 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=lkSsTaoaHbc0cFvKRegA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfXyi6VWQ2MEOix
 rlmCIB/x8P+72Ra39VzzNKpZ3i7Pk1MqBOrsl5i33D/AywUT9OEmIJEW7e1KKoo5T03356yut7k
 f6GwBWlbNuGqOGz9yfbxPR5KzcSCXx7KvRNeCGNGFRQ7Bvjr5eIQvs4W1G0rUEPdLHcBlRjkkzc
 kvlBPSFM9tfvVv8S/bGcP/P/Rm/cj2oa6+reREsltYqfZ66SXzz8gtgoYQHDdv1yZ/eboUK+EKl
 RJTH+3/DX3vumwbmls+9gu9h+3Ak5o7pfz9H0ipPlw/sNm4AudOS7VTR9PLLgK1H6eoObjISmEh
 ZJN4P5bELNMm2zSi5HfDau8hyPtJO52qEIWcnfCBYehsST8jG0ItAFIOnJyDFpFgrEM2EO+7FmH
 2fbB0vJkVzsEYjTbkznhO74eFPTndQwWtRC5XJgrwfvbqPQmG/U6Uua7PZUbt60zgBSoVQrAoQQ
 LaBR9vy1WL6cbDS+Dvg==
X-Proofpoint-GUID: uSo_y2a9PJKZimuV0uV0mDhVQ-vEJLE1
X-Proofpoint-ORIG-GUID: uSo_y2a9PJKZimuV0uV0mDhVQ-vEJLE1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130115

This series adds LTC2499 support on top of the existing LTC2497 driver.

It includes:
- a small binding title correction for LTC2499,
- the LTC2499 internal temperature channel,
- the LTC2499 2x conversion speed mode exposed via sampling_frequency.

Validation performed on Raspberry Pi 4 hardware with a DC1012A-A board:
- temperature raw/scale/offset read correctly,
- voltage channels remain sane after temperature reads,
- sampling_frequency 1x/2x switching works,
- pyadi-iio LTC2499 validation passed.

Changes in v2:
- guard against regulator_get_voltage() returning 0 in the temperature offset path,
- replace LTC2499 two-byte stack command buffers with a DMA-safe buffer,
- use ABSOLUTE_ZERO_MILLICELSIUS and standard SI unit multipliers,
- make channel-count handling explicit,
- clean up includes and iterator usage,
- update conversion-state handling for interrupted waits,
- clarify conversion-time rounding and LTC2499 configuration behavior.

Andrei Stancovici (3):
  dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
  iio: adc: ltc2497: add LTC2499 internal temperature channel
  iio: adc: ltc2497: add 2x conversion speed mode

 .../bindings/iio/adc/lltc,ltc2497.yaml        |   2 +-
 drivers/iio/adc/ltc2497-core.c                | 234 +++++++++++++++++-
 drivers/iio/adc/ltc2497.c                     |  41 +++
 drivers/iio/adc/ltc2497.h                     |  46 +++-
 4 files changed, 310 insertions(+), 13 deletions(-)

-- 
2.43.0

