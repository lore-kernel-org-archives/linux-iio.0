Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8E625;
	Thu, 23 Jul 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836332; cv=none; b=IJaYPl8BsfKz32+JLXOk8+GMgSOuVObVE9DbzPlLmg8tWs2cAgdcmFw9r2U8lqsSPgAKTxjat9mwjOd8G8KbL6pvzSS/gKCqGy4CH0IWlc6kr3nv+HTGiZDg0q2v62Hz66ziJW0aEytJAQ2i/6nR+Z5Pa1kRzYf8ZPCwOOxZSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836332; c=relaxed/simple;
	bh=gIYcICP4flzQpFnZDAMKluBR9JjsxtPahknImjM9bZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X0bgxnH/rXuSesMfWlavF/0xihtQmRzQKPydN3vc9530iaW+IF0UOw3Uptd7sEdGDiz4enLvN8Fl3Ry+J3J5PWC7LnX+yPUYOFfTLEKdlio/AfY7V8fPrIzEDyYZOfl+Nzndd/hz75GslzygNFfwEN9BZ6roVT/Lswq2oHQqVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a6EUh8A0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a6EUh8A0"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NImJ5I2703520;
	Thu, 23 Jul 2026 15:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=OaPnpQmCc6vVh5xVWIzviznmSld
	bScUpHOunLDNTpYM=; b=a6EUh8A00rZhphvUPIfFEjJqN+xR0M+jtvtM1djmz4E
	CTTat3+qHAjsDECkDFeBPEFpivkJqRur4fGYyoDjPN/n+uQGHkykZHEAdIlMmw3E
	F7r+Wb2HfSuzzvEa6hIizMA1kPS0e10o2pS52QV8uC6CRbIPrrGvvg/zia4Chmkc
	KrqP8Hb8IVtqCcw6aKZlijAalqeMu7xmYR98kJTUbz8TTlRH2202w5oxXuN0hdsX
	WJ6Wh8mbjJyLLk52hyGu5tnxSWWgFcHTTk6lidEQ1l6BVaLAmL9fN/VrpXrBwvvZ
	JNO0HDZLwrTZJox1pJkzhisDX5N0pQqw+2lTErx4qzw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fjgp0stuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:52:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66NJq40S049434
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 15:52:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 15:52:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 15:52:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Jul 2026 15:52:03 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66NJpqnv030707;
	Thu, 23 Jul 2026 15:51:55 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 0/5] iio: adc: Add support for LTC2378 and similar ADCs
Date: Thu, 23 Jul 2026 16:51:46 -0300
Message-ID: <cover.1784835663.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5MyBTYWx0ZWRfX4lwnf37k13Dn
 Ef1J+F+vYKSL2JVCb5fJb3CcKLXkQIQormcB6mZlo6L/eHVDo9golovcuDjw9S2nG2r1ZPKjdmr
 VHgT63kZIYGSeo3GQAy9Ph3Pexey0wgTwhjyZx/KsnnxHlP9rFPQ
X-Proofpoint-GUID: TpdFYfnbDRx04C8qQftgkrRVWsJApI0V
X-Proofpoint-ORIG-GUID: TpdFYfnbDRx04C8qQftgkrRVWsJApI0V
X-Authority-Analysis: v=2.4 cv=cPXQdFeN c=1 sm=1 tr=0 ts=6a6270e5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=XqN69BuZ7wOcV2cAv7kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5MyBTYWx0ZWRfX4xB5fKXaJm1c
 lwx3pvidnXDgjYYUGwBN3VkfGZhzDXvaRx5YTWm9fWvXkQAUAG/L5PBPDNDSSlJ5euT8S5sU/ym
 sAQoKmF+CbojFAQgawvFDa0Y4TgyS/GV6V80ydhFyIWo0rr3Hb61KM0huURRMQwQ1KZLDzJ2szY
 ikEzhxJqYOY6iYineted6dVDrDOOo91CYRmSbPSMcO2a0MNs1rcM3pPpbPIkx/FcJZ+ztpgR146
 vQLIi5NmO1XBWcfynyRqpBAiMQlsiOqbgIfi/j5twmCgDpnfYAyxB1AHV4uOjDwKqxkGGxiNoa9
 knwDQhrOahjt3z2ztKON2SUsWV4p9e1JI13RodY8/X3Cg7oq7CwP06st6SnwhFyAl0v6AbaZkFL
 h6treuHTOR5941v6kY9WE72ZzZWXkiXxHjv9yehyd1aXrrOtIBaoW7+K+yFHml2mvZ8jCll892D
 ooH0FrMUxTLlE4JB/aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230193

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

Patch 5 recommends using voltageY-voltageZ ABI for differential parts.

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

Previous submissions:
  v7: https://lore.kernel.org/linux-iio/cover.1784235595.git.marcelo.schmitt@analog.com/
  v6: https://lore.kernel.org/linux-iio/cover.1783629101.git.marcelo.schmitt@analog.com/
  v5: https://lore.kernel.org/linux-iio/cover.1783028033.git.marcelo.schmitt@analog.com/
  v4: https://lore.kernel.org/linux-iio/cover.1782397418.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1781661028.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1779976379.git.marcelo.schmitt@analog.com/
  v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v7 -> v8:
[DT]
No changes in device tree doc.
[IIO]
- Updated channel macros to make up indexed IIO channels.
- Encourage differential voltage ABI usage [NEW PATCH].
- Simplified if/else to consecutive if statements on ltc2378_refin_setup().
- Picked up review tags.

With best regards,
Marcelo


Marcelo Schmitt (5):
  dt-bindings: iio: adc: Add ltc2378
  iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
  iio: adc: ltc2378: Enable high-speed data capture
  iio: adc: ltc2378: Enable triggered buffer data capture
  iio: ABI: Encourage differential voltage ABI usage

 Documentation/ABI/testing/sysfs-bus-iio       |   9 +-
 .../bindings/iio/adc/adi,ltc2378.yaml         | 170 ++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  19 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ltc2378.c                     | 851 ++++++++++++++++++
 6 files changed, 1054 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378.c


base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
-- 
2.53.0

