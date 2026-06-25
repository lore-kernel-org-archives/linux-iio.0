Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DE283C82;
	Thu, 25 Jun 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398093; cv=none; b=sWuJ1jL68sGNZcRO+c8RFFLmLKGIm0k3/8qH3RnUsOf2CQLbWCBLgIYrYX6cbQf7RIws87cVKFsDP2EZa+vcJJvFSy+lHAcMlOWtGAHI5yaaUd/rRl9Ga48h0LBmGuKF21l24x+RZDWbcwDFSnXaCrFGOns19odccN0EENHSrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398093; c=relaxed/simple;
	bh=EZTPqJxnv33ol2PgQpIJJMlpLqYX3uSn6r02EFN0jaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RpXAyGuqbcmZpu4BABSC4Mc53La8S3SbexlGV+dIa5qEi8AX2uEssgBCp8udFuzhm7/O7c+lSkUHil9yV6R5YnhRX/gkaHb/toyB3HdkgY8R5ZgB1s+7SK4z974bQ43nQZa1uvOK4Tg0FDSBVHcJMwEGIeEFCST5G8jxiHJbF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hq/azv/f; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hq/azv/f"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PD2iF12581872;
	Thu, 25 Jun 2026 10:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=jHSbJmiuw4dHgOjOCZYSA6Fhwop
	srMCgZrTPE051F9Q=; b=hq/azv/fak282ppTPWPZ67POcPVFcS5df6EFaaPj8Sd
	MsfW87y6uXNgJQ/GE6khn2fxmRmz0W8Ho0CaTyJvq5AdNqvdWOrN2sc7HH78glaS
	gseAzSAsRV4XlW2n4DWiVHT8HU9GXlvnksxVF6U9/t5fnCuP6Wq8qOutQUBzebMZ
	HoKHaRUiERzfz2/7oBSfs/r5u3HrRuutHUl+NOpzxegSq/tXRVlxbC8myzxZSqUW
	OrCYngHCjVwMRajzTFpa646rBMhrjOuckFAHCJxSMaZt8tyQtpXFx6PKTJzgqbti
	rYuEoNp1ClRW13EaPAepuEsj47R7BW7wPpuL7VhTzqw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f0qgvktu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 10:34:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65PEYjJa047960
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jun 2026 10:34:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 25 Jun 2026 10:34:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 25 Jun 2026 10:34:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 25 Jun 2026 10:34:44 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65PEYXLJ009871;
	Thu, 25 Jun 2026 10:34:35 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Date: Thu, 25 Jun 2026 11:34:26 -0300
Message-ID: <cover.1782397418.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3d3c86 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=XqN69BuZ7wOcV2cAv7kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfX1cVbDnLQCCv4
 Sd16EGytgbPCmqtY27XeSb0cNjtcOK58OdtLePb+jHj67+67jsGEp0ZhJWL1Jx7MascD2E5HW3w
 SgSTXm2rWp/Unwy+KlAOGO6Ic/xT5vjOAdGKQjpuViHQCabf/a4WIj4OONmAEGjtE04Cg4WbxO1
 jCvNjyL0WwCMu37ej/O6cwt4A3oTO9vCkZ4IJ3rW26SvvQ1o7YGD5dWK5+Auzya4MoYcYwmRzXW
 PSi5ZjT/qtoV+NwsWDB3KbjXMVQhQ1AAzyzDPys5FeFDZOpUKfjKDBp4IC52jm1TvnJ956u3le2
 n2/SgRdL+p/Vz6ULPOihaD5908kCc84wnmbLt21vPhoRwS1kf7Rf3IgEEst501dl02/IMn/ffDD
 9u4oTUbNrh9SEp0pc1NtMgBd8IleNA9crcPH4IHzE0Mdvv/MkzDS7WM36poLOrI4c8jWF5xUbTz
 dPKT1u7jTIPCnzJnI3A==
X-Proofpoint-ORIG-GUID: ZJmIJh5RMeerIyHaud76YNvFeTkIp-lB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfX1BqRsobXzHzo
 S8qDsadRHdYdanSIpnTnQowLFiyRm0op33wkOfzvgKhhmwudaqBB7+55eaXiPd4MDS+j2gQy1Ux
 nOHREuIsPrga9eLDaHck++0LbZcA25pJ5K5mOsWrXjW0832fmBl1
X-Proofpoint-GUID: ZJmIJh5RMeerIyHaud76YNvFeTkIp-lB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250125

This patch series adds support for LTC2378 and similar low noise, low power,
high speed, successive approximation register (SAR) ADCs. These ADCs are similar
among each other, varying mainly on the amount of precision bits, maximum sample
rate, and input configuration (either fully differential or pseudo-differential).

Patch 1 adds device tree documentation for LTC2378.

Patch 2 enables single-shot sample read with a GPIO connected to the LTC2378 CNV pin.

Patch 3 enables high-speed data captures with SPI offloading.
The setup is similar to AD4030, with a specialized PWM generator being used both
for SPI offload triggering and conversion start signaling.

Patch 4 enables running buffered data captures without SPI offloading.

Even though these parts are somewhat similar to AD4000, the wiring configuration
for LTC parts is different as well as the available HDL for high speed sample
rate mode. Because of that, I propose creating a new device driver for
supporting LTC2378-like devices.

Specifications can be found at:
https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf

Despite the initial version of the LTC2378 driver had been developed by
Ioan-Daniel. The current version has been greatly rewritten such that very
little remained from that initial version. Due to that, having Ioan-Daniel in
the author list now seems inaccurate.

Previous submissions:
  v3: https://lore.kernel.org/linux-iio/cover.1781661028.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1779976379.git.marcelo.schmitt@analog.com/
  v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v3 -> v4:
[DT]
- Added PWM property.
- Documented LTC2338-18 specific refin-supply.
- Picked up Conor's review tag.
[IIO]
- Dropped DMAengine buffer changes.
- Reworked the driver to make IIO channels static according to v3 feedback.
- Updated to use default 8 bits_per_word for non-offloaded transfers.
- Handled refin voltage reference supply for LTC2338.
- Used spi_bpw_to_bytes() where applicable.

With best regards,
Marcelo

Marcelo Schmitt (4):
  dt-bindings: iio: adc: Add ltc2378
  iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
  iio: adc: ltc2378: Enable high-speed data capture
  iio: adc: ltc2378: Enable triggered buffer data capture

 .../bindings/iio/adc/adi,ltc2378.yaml         | 185 +++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  19 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ltc2378.c                     | 778 ++++++++++++++++++
 5 files changed, 991 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378.c


base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
-- 
2.53.0

