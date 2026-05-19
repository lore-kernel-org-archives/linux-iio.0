Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F82EE262;
	Tue, 19 May 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205451; cv=none; b=ocZC+SHx4Kr+ofyVXNMpMdE51iXT9536eRNweT5YqCSUC4O1G2zdb4Yvos2YJ7afJF8DQ6Qr+5Z0hbKAMnR/H8WIKMDQKXL7gs0ihgcAakZZNYAoTylDzCmiAh5CRZuc5BruwxkQ3LydXdn03NbgAfWGSi9zhodf4r1jzkADe9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205451; c=relaxed/simple;
	bh=1lJECM6aTdPT3ZZn9ovmgEZ0CeQO199AP9tZxcS2E94=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=sfHAQnhMNiHLGae3bNSD8K/1zFbRMncTxZ1IyIeiEEHncc3QCQh1J5OWNPOJx/YmYPtzwWS1fz4UMzS7ODksmqY38kkHGj7Pbool8N83H501g8XovaUAZ3OdBx4lKa3eawxvagLkkqTk71b4QYrIEjYNwoBAtewZSu9DvKg6UxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OXD9jV4P; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OXD9jV4P"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCX9Hu3483789;
	Tue, 19 May 2026 11:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=78lVwnN7ndokRBdj63Kw/xjfqJm
	x3MruMP4yCE4s5sI=; b=OXD9jV4PNn+SKrtR+XMp4am4ttB2jSkObgMkkKbfSs2
	OuMX3XihrB1xqLKtm0tpRKHFo9L8/sRYleMRXi2ZuoOI51dHQD68EkVKwTA6S1w2
	N17nv3l5fCnx4XFKAGyvR491bAQJKLq7uvq492lNwpdyzgLln4kmWD5xIhlltCzA
	sVet7ESllyTmCR05yqxK+l2JEp68kROqfAFDve/K468RSO3qSgqpXWqHa7DFitQ/
	aIEyP8nUif2PavBTHtl0pFeCP5yEEKYZQxPHnHtvZstnVQ87v6R42bidhD4rrveG
	FMPcValWxij523H9p8m/NGe/3nTSruq3S7qJC4zoQGQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6jdxutgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:43:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64JFhbfm019218
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 May 2026 11:43:37 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 19 May 2026 11:43:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 19 May 2026 11:43:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 19 May 2026 11:43:36 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64JFhKZ4024062;
	Tue, 19 May 2026 11:43:22 -0400
From: Janani Sunil <janani.sunil@analog.com>
Subject: [PATCH v3 0/2] iio: dac: Add support for AD5529R DAC
Date: Tue, 19 May 2026 17:42:57 +0200
Message-ID: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAGFDGoC/3WMwQrCMBAFf6Xs2UiSJmn05H+Ih7S7bQPaSCJBK
 f13054U8fSYBzMzJIqeEhyrGSJln3yYCtS7CrrRTQMxj4VBcmm45g1zqLU8RIbRZ4rMGtO2iNY
 oJCjSPVLvn1vwfCk8+vQI8bX1s1jfv6ksGGetUob3dVe2P7nJXcOw78IN1laWn7798WXxqRZaK
 WGsxubLX5blDYVzKuztAAAA
X-Change-ID: 20260507-ad5529r-driver-866bbdd864de
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779205400; l=3817;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=1lJECM6aTdPT3ZZn9ovmgEZ0CeQO199AP9tZxcS2E94=;
 b=3xeXd0Dzu4LLYG9s4VphDyU2u9Fb2KzVkCp5yI/jXIPrJjmME28xMUuch3EOZkP9EGWF9ExLt
 dNn1oE5lGXUCPDXRbLYUuoEmu1ofs/cMTdozcVdZ8YnddOgjIfiRsV0
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uuNQlnBgJufgUBTYMaOjrhr8DXHVKAst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1NiBTYWx0ZWRfX5GORHcySqk7z
 S9lmSZdAAfc7WUhZW/nW0rphkn6svbRwV0QvNXTuHHhFt3y8kBA20EmTWmBm5WInmzSwxCpJOK/
 p3OaUH8yXkJ6rkQDWaAPmnOURxt+/jHoo/KP7J1EwXJdcuKPdaqO3pqkZTaTZZjgi8zxA8nz0JP
 qzqWgDBVTtg7poHLGcH7wyMTTzDh1cfFwqOk/X7+5sx+TY/qMi5hszwzkUzn9oR+HaWAQ5F3Y2J
 miuxqEHxSL+IqpWzNN6/EsSewtjUXMrL9i8RgEUhbLoBfiWgYi0qwxJVg13dfg5uodnCb4W+ztW
 rXMhm2PHdEolQf2hXswt0TQEzQ91sUbK0lJ8iLTac6OgKdUZg4J2a2hOklOGRClEuG8Yo3uptwu
 VCJ7JuopqMSLLgEjcjYlT49xXqBhfGd50aKHT3SdMOmA2Px0wPjDTjQog6tE/cpjdnO1vqpthvO
 E2Bw/8cszYQJfbfG2Dg==
X-Proofpoint-ORIG-GUID: uuNQlnBgJufgUBTYMaOjrhr8DXHVKAst
X-Authority-Analysis: v=2.4 cv=FfwHAp+6 c=1 sm=1 tr=0 ts=6a0c852a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=BKGV3_hmQGrvrKQGupUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190156

This patch series adds support for Analog Devices AD5529R, a 16 channel
16 and 12 bit voltage Digital-to-Analog Converter (DAC) with integrated
precision reference. The AD5529R operates from both unipolar and
bipolar supplies. The device communicates via SPI interface.

**Device Overview:**
The AD5529R features 16 independent DAC channels, with 16 or 12 bit
resolution, allowing independently programmable output ranges. The
internal 4.096V precision reference sets the accuracy of the output
voltage.

**Features Implemented:**
- Automatic detection of 12/16 bit variant with product ID read.
- Reset support via GPIO.
- Dual regmap configuration to handle 8 and 16 bit registers.

**Patch Summary:**
1. **dt-bindings**: Binding documentation with channel configuration.
2. **driver**: Implement IIO DAC Driver with regmap support.

**Testing:**
The driver was compiled and tested on the EVAL-AD5529R-ARDZ using a
coraZ7 with a mainline v7.0 kernel.

**Driver Rationale:**
AD5529R introduces:
1. A unique register layout
2. Mixed 8-bit and 16-bit register accesses
3. Product ID based generic identification
4. Hardware specific features like function generators, multi-die
hotpath registers etc.

The device warrants its own drivers due to these fundamental
architectural differences, that would require substantial changes to
existing drivers without providing reusable benefits. The standalone
driver also allows future extensions for related devices in the same
family.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
Changes in v3:
- Split into adi,ad5529r-16 and adi,ad5529r-12 device tree compatibles
- Add DT-based output range configuration via adi,output-range-microvolt
- Expand DT binding: vref-supply, clear/tg GPIOs, interrupts, muxout
- Correct power supply voltage specifications as per datasheet
- Reduce SPI frequency limit to 25MHz as per datasheet specs
- Switch to autoincrement addressing mode, remove +1 register offsets
- Use DT match data instead of device ID detection for fallback support
- Implement dynamic scale/offset calculation per configured channel range
- Added explicit val_format_endian and reg_stride for 16-bit regmap bus
- Code cleanup: alphabetical includes, ARRAY_SIZE(), unused defines
- Minor: .sign→.format field, simplify read/write order, optional hvss-supply
- Remove redundant driver documentation ad5529r.rst
- Link to v2: https://lore.kernel.org/r/20260508-ad5529r-driver-v2-0-e315441685d7@analog.com

Changes in v2:
- Fix IIO scale to use millivolts per ABI requirement
- Fix documentation voltage calculations (2.5V not 2.048V)
- Fix bipolar ranges in documentation (±5V, ±10V, ±15V, ±20V)
- Fix alphabetical ordering in documentation index
- Add missing newline to documentation file
- Fix scale units description (millivolts not microvolts)
- Include a section for driver rationale in the cover letter
- Reword contents in cover letter 12/16 bit generic->variant
- Add dependency array for spi-cpha and spi-cpol properties
- Link to v1: https://lore.kernel.org/r/20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com

---
Janani Sunil (2):
      dt-bindings: iio: dac: Add AD5529R
      iio: dac: Add AD5529R DAC driver support

 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 217 +++++++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  17 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5529r.c                          | 527 +++++++++++++++++++++
 5 files changed, 770 insertions(+)
---
base-commit: 93df88612859e8e19dec93c69d563b4b73e9bd4b
change-id: 20260507-ad5529r-driver-866bbdd864de

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

