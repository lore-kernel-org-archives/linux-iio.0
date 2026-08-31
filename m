Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0073D47D9;
	Mon, 31 Aug 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165126; cv=none; b=TyagT9iTzwmnID4HeHYA+Bzx323dSHX7Yk+CZ02i8b+xNyclH/XJcEWWf7cjf6/HjSatHTnDVqaM561hjbZF4bVzl3W/EZTVt4ZOtQaJ7RlNFYyip+EX+Ok/IOI8bp53jp1PRNHB8QJ8jutrNdzT00BLYinFkDVM8xal4G6LU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165126; c=relaxed/simple;
	bh=Wo4wunapZZkGAnPrU1cpaaLYZMv6fQWk8ILyc0v4RAQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lysbmI/S5AujsGTWHV4xTzQiq9cUPwCZ4HaTtQbGZLVxaWKmRzGK07ZpHkaqVACuVrC70sJK8UW+pv3UjCLloXLsuYwOILJt5+/MO6uVdO5ghZphZE0dbIzN1skNegULBn/uFBcrDJEq84yEQ9sbD9qED5UUjIg0/QMA82AhS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F7ert6TA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F7ert6TA"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82mQ5146733;
	Mon, 31 Aug 2026 04:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ktMmCbh5iWYon774sIOkqnUj+Bq
	HuaWYwiVtx0quQ2M=; b=F7ert6TA9bMBy2oFH1tzuPCsPHdB/q2UegCaOy735Oo
	0BGM/8mNN1LlGI9l9ePLF3wFapvOzbZLvo4bRN3feDeIZnR7u641Qt96szrNa1wK
	VUdy6ceOcnm0DUSgC8FgLo4TozdLk6tHJoFjf+M2HX40I0o0ZNTxHoN8xADo8fAa
	S4U9hDk4nUjuyjslMXlJEl3filPhAWOmuLkntfTsc9VPUU9Z3bmFj/CYAOACBBHR
	I1rueIQPuRTL+kD7OsUlmEWonwf9JWt2Jqa7sCMuRFctBHHl1qyzv3QdJ0GALBUZ
	5EvDjw7tMDFRv3kE5myDaYWtmLGPyH9MecHRPefWIuA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcdrdkw3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 04:31:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67V8VjpT012494
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 04:31:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 31 Aug
 2026 04:31:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 31 Aug 2026 04:31:45 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.222])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67V8VVaf006721;
	Mon, 31 Aug 2026 04:31:33 -0400
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
Subject: [PATCH v4 0/4] iio: accel: adxl367: add INT2 interrupt pin support
Date: Mon, 31 Aug 2026 11:31:18 +0300
Message-ID: <20260831083122.3486-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfXyfXuzi55g7xj
 +nG3CZK0zN3wbOInF7slrngHnd2SiSRixFoNt11md7UOvgbrSsRFJlX5D6wkjj73QeIZQKSEqTl
 2i7sFoL6X+Gj0zF7Zwvu+jiAmWUZSh8oH++hpO76+FjPbOKnEwxW
X-Authority-Analysis: v=2.4 cv=feSdDUQF c=1 sm=1 tr=0 ts=6a953bf3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=rBlJ7zr66XimYiw9IlEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _BhM7I1tIrmRlYIL0ehypYwcXMRRybkT
X-Proofpoint-GUID: _BhM7I1tIrmRlYIL0ehypYwcXMRRybkT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfX4ToHduO1oxS3
 4hSBcdLlujLBAKmM1oK+qcBJlG7fWlAbFZL4lMn1PhP6IGcy5EJ5QZQ2kkUiv8WiKhtH4MDBukx
 KnhNqsikknwmJobyUBDnY6qzo8IbPEmI6EsCOw78XWQZ0apliJ9JKhemitSqvgckdCFIqk6ZaRz
 TOM0nEeaDrV6ioCyWOzclI8P5Zzq6V4LgWlWqdJZmD0zhc19MpwB5ueV6Hhm9Oy/kzpY09T9Haf
 xzhN9fqIRZLytzLLEtCaBsCyjsVqlx3GAaW9lPiXuuMOQaprJqnqAR2fSc+M0xW76FrF1McBbJv
 YfshB2nlXwrx7baA+cNfG/PH2zQpIOEvjP2qanLTy8tnUzMdppAknNU47pUR38jnOW5lG0minHM
 av1dy8+pZimXuEm0HqXu/gbocfY7ptZkbwnE+1qMyGTPgR83rOw/SXzQQz4YO29HrALDN0bsGmz
 qimi/hPE37bFhXx7gWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310072

The ADXL367 exposes two independent interrupt output pins, INT1 and INT2,
each with its own event mapping register. The driver has always hardcoded
INT1, so a board that routes only INT2 to the host never receives
interrupts. This series lets the driver pick the interrupt map register
based on the interrupt-names device tree property.

Changes in v4:
- Collected Reviewed-by tags from Marcelo Schmitt on patches 1 and 3.
- Reworked the interrupt-name lookup in the INT2 patch to propagate errors
  from fwnode_irq_get_byname(): only -EINVAL (no interrupt-names) and
  -ENODATA (requested name not listed) fall back to the INT1 default, so
  -EPROBE_DEFER and other real errors are no longer swallowed.

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
 drivers/iio/accel/adxl367.c                   | 52 ++++++++++++++++---
 6 files changed, 65 insertions(+), 13 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.43.0

