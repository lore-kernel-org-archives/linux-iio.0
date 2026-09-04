Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBC3A7593;
	Fri,  4 Sep 2026 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510969; cv=none; b=ClGBE7otSTJwrv3KxgOguOXuvFAE9FZZ9vM6xMGwHhPs8TfjYPngjcxvHya/oB3m44InCpaYzGOTOIL+C4u8+M0gn5ndm1bgysrT6wSvbx2H7lyc/mMjWWQdnnD9kJvlGZe+sj17S31M65aGFPWNHIgGVX5tQhMR0YJWyizl2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510969; c=relaxed/simple;
	bh=g6Aw7BqGE55IOBDbcmJqnDzXjIjVBZF0EYfA1wqfdsc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OC+X6TcPJlrhmWGt8vJHnj0Ze5iSFm8XOSidqWlTwe6p4a/DW/PdusNZxck1ILt+nHetp+bBGMiRwFBC5OmhLypQZkKTY1j0SZE5ZuUOywPAivmGwPMuLOSnB1c1DOCUNFHArGt8sV2smAh8qGU7LsE+EiYnXGlJgXYtwth1rrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rSBCNVhu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rSBCNVhu"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68463fqk3811489;
	Fri, 4 Sep 2026 04:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=kcS7JqjQkoH0/eqR1lbQFSiUOyd
	TZVViYNULAVsaj9g=; b=rSBCNVhuG54oUIMrX47vzvAGs49Y6S8Td6ct5kh0OvD
	TKY/5PBFAiGeQIdAM34KrLRcspsc3k8DpXI7Huna6DpkO2+GHBuMcvorxYIpfJdD
	ammjPJWhUe92j73etqsOIC9yZY7RcNa1/WZz1Sr9Jkt0qfHUPn/lif5faiiZ+jej
	twPTpGriJuANoC227bOVBJpQL9aRi9lfbS4BiEGqUVvYawqIhYz3yhhZuV3OzBEW
	9D1PyUOpsNv/pvDtOBoSI2vAPkYk5YU6ivgLxbkG1MQxisLPm6QkXzCDNRCst83y
	3woy047MxZ3dyRVAqaxWxC8tBDZWjK5YiMlKOVHDj9w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gffk4tv8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 04:36:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6848ZxSw007166
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 04:35:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 4 Sep
 2026 04:35:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 04:35:59 -0400
Received: from 10.98.41.145 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6848Zjj2026621;
	Fri, 4 Sep 2026 04:35:48 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v5 0/4] Add support for AD5710R/AD5711R DAC
Date: Fri, 4 Sep 2026 16:35:23 +0800
Message-ID: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMuCmmoC/4XOTW7CMBAF4Ksgr+vKMzGxzar3qFj4ZwKuSozsE
 FGh3L02XZQKRV0+6c335sYK5UiF7TY3lmmOJaaxhu3LhvmjHQ/EY6iZocBeKOh5jInbsFUgMr+
 cy5TJnjhJ8Gh0D9L3rJ6eMw3xemff9z+5XNwH+alZrXGMZUr56747Q+v9MzEDF5y01FY6pwQMb
 3a0n+nw6tOJtY0ZHxSEFQWr0qE00gSvMNgnpftVNKgVpWtKfWRQznil3ZMiHxQ0K4qsirZDBwh
 eBYQ/yrIs38FF69WdAQAA
X-Change-ID: 20260716-iio-ad5710r-upstream-e41c298614c6
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788510945; l=4224;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=g6Aw7BqGE55IOBDbcmJqnDzXjIjVBZF0EYfA1wqfdsc=;
 b=rUstPSCWQy5p0lPqspgA8x5g8TW6q8xJSa8uDWewVuX5dyoW+XwNwapt/b0wqNv0UoyY0XScv
 DEjq4cLxhJwDOI7gN4fI0TVhke76LjJE8KMGdEVC2rE2FjOuVZSarHk
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfX1q1t/shVFCCB
 HeeiRgL6IPiytaVio4bYiZFMMemvwixPeo69NgDjY/FP+NmqP+zf4B+m3rif48tRtJZEPSMao8C
 ELsjHdSCEt8mVWhkGeoG4q/ddUpIh4pn6kWKE3WGx7zMYpO4q0hQyRim97IFAVFCdxRNlH2kPoZ
 pNWZ1/iMic6SopUDubbdrjjIIFhCZnC+W236i1TTEZ4uSdqVrIdCzzxp8CExcgzUjimQuqDfAGc
 auRUAvMVFHvDJ5GtoBvlXnF72R8ZfzR1IA9F7y3VS3kOsN11fFQukCNRk6M8H5qASoolsCiYx50
 Pzgj6MpkK+na/n67b4o3vT2j4jGeYPtEcgOhgkjaDVyzGP0jab7ZIiPFGIghTECVcMXxYEXC+Ry
 t6Ldhj5m83ZNK5sBzLpEQyJjPHnlZ53FomcyvwQFGIz3Y8fhPmgoUg6eqiuY0b73caP9G0u074G
 BshwoAnMQFV1crn2hxg==
X-Authority-Analysis: v=2.4 cv=QI1YgALL c=1 sm=1 tr=0 ts=6a9a82f0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=IYqt8FPo4sdmH4kH8GUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: EuxUIKUK18fqghXsjBb9QgfMDQ1Tbmpo
X-Proofpoint-ORIG-GUID: EuxUIKUK18fqghXsjBb9QgfMDQ1Tbmpo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfXyFDvxcvZCOgi
 o2EzMqxHvcdt7NFsxr4xBp/paoFHMVVLkjxtetI+M2iYIqkqmRoDgGDAAHt+OBBp2Q7dLGQW2oj
 jS3It1zoXirSGKqhYtjVbhfYAKKiqVHicnBlz/pZiei+AJuVP9ZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040078

The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
configurable current/voltage output DACs with an on-chip 2.5V reference.
Each channel can be independently configured as a voltage output
(0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).

This series adds support for these parts:
 - ABI documentation for the high_z powerdown mode and the current-output
   powerdown attributes
 - device tree bindings for the AD5710R/AD5711R
 - basic IIO DAC driver, supporting per-channel voltage/current output
   selection, per-channel powerdown, software or hardware (LDAC) DAC
   updates, optional output range doubling, internal or external
   reference, and hardware reset (with a software-reset fallback).

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad5711r-ad5710r.pdf

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Changes in v5:
- ad3530r: make powerdown_mode read-only, dropping the _available list.
- ad3530r: rename the channel flag to configurable_ch_func.
- ad3530r: move the reg declaration into the child-node loop where it is
  used
- ad3530r: return -ECHRNG when the channel reg is out of range.
- ad3530r: update copyright year to 2025-2026.
- dt-bindings: spell out the adi,ch-func values and cite ad74413r.h.
- Link to v4: https://patch.msgid.link/20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com

Changes in v4:
- Use GENMASK() for the raw write bounds check.
- Add a comment explaining the AD5710R powerdown mode negation.
- Return -ENOENT instead of -ENODEV when no channels are found.
- Link to v3: https://patch.msgid.link/20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com

Changes in v3:
- ad3530r: factor the op-mode register/mask computation into a helper
  shared by the powerdown access and channel parsing.
- ad3530r: pass iio_dev into setup/parse and set channels/num_channels
  directly, dropping the duplicated pointers in driver state.
- ad3530r: use regmap_test_bits() for the powerdown reads and drop the
  unused AD5710R_NUM_CHANNELS macro.
- ad3530r: split the file header comment into separate AD5710R/AD5711R lines.
- dt-bindings: drop the redundant items wrapper on channel reg and tidy
  the 2 x Vref wording.
- Link to v2: https://patch.msgid.link/20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com

Changes in v2:
- Drop the standalone ad5710r driver and fold AD5710R/AD5711R support
  into the existing ad3530r driver.
- Add a preparatory patch parameterizing the DAC resolution in ad3530r
  so the 12-/16-bit AD5711R/AD5710R can reuse the raw/scale paths.
- ABI: drop the "high_z" powerdown mode, which is a synonym of the
  existing "three_state" and use "three_state" instead.
- Link to v1: https://patch.msgid.link/20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Michael Hennerich <Michael.Hennerich@analog.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux@analog.com
Cc: devicetree@vger.kernel.org

---
Kim Seer Paller (4):
      iio: ABI: Add DAC current powerdown attributes and 15kohm_to_gnd mode
      dt-bindings: iio: dac: add adi,ad5710r.yaml
      iio: dac: ad3530r: parameterize DAC resolution
      iio: dac: ad3530r: add support for AD5710R/AD5711R

 Documentation/ABI/testing/sysfs-bus-iio            |   5 +
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 145 ++++++++++
 MAINTAINERS                                        |   1 +
 drivers/iio/dac/Kconfig                            |   1 +
 drivers/iio/dac/ad3530r.c                          | 300 +++++++++++++++++++--
 5 files changed, 429 insertions(+), 23 deletions(-)
---
base-commit: c9f54ead57939ebe76b9b76a9ef17b4331766b97
change-id: 20260716-iio-ad5710r-upstream-e41c298614c6

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

