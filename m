Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794806;
	b=toJar0uJu71tO8tRl1ikqd0IIW90LddWI0l9RWUK9sstFnuwV0Er0sOhU4VxNRAkY8//
	 B6LyoDhmkYV6pq/mvKWTN5CirJsjYmBk4itWUWVp5FJAEUjH3R541NpK3Iz5YDGivsaV6
	 0ej5EOSYi1+FToqRe88zruxmuFydx4Vxsng7JZFrYwC+tzsFWSQVHhqGlmqaVVMz2cvIm
	 jwNidcCyJKG5+WPHT1WNUpYEXIXpT988XvmPhTuM72dPOHnCm0TjOeIl184KGIDqJ/DTy
	 LVi0M19GLDbfQO+ALD7foEmmBEZPZciCacMCXUAR7FCSJdQdzwNZAVb/P4VUelHCqLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794806;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Ic1khlmipz1FjgtPaiy4ZrqDft13v8QSYTaH6PaAm3k=;
	b=V3FaZd+Af09pykUX72HaU+QU09ePH+9Ieo4EAGs0/2ngFqBRxpEdg1yoAXl1tnQwGy+m
	 pW+CBT1Wr8bv/7BF5HyBTvJL7HHaT4t/8oCyL1QTv8dkeQBDev/e3xtp6fYooYVHXHyWQ
	 auhLvom8N4B8tEzJptwoCBqhSCWZPjaIVNBhVg6hllTEHZPHQTZDmMlD9vX5ARKDFnQ3a
	 owTdZM/R08A9n6N+F+DuyoGLtR3vTZMzAaRtJF5kM95MCxlIrYdYv/9HCEd725jPfR3JV
	 Yp/I9qNNFSsL6zI2TNSFEKRTSzoCfop2NqOqfrNwHkPigNKPjUX1JmBkS/TkZYcWgSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=LDxVn2g2;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UWXTCqNs;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE94606A31B;
	Fri, 23 Oct 2026 22:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FE94606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=LDxVn2g2;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UWXTCqNs
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLw3k41783191;
	Fri, 23 Oct 2026 18:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=Ic1khlmipz1FjgtP
	aiy4ZrqDft13v8QSYTaH6PaAm3k=; b=LDxVn2g2XLdkY36UpUj4BxaDyRzzpLg4
	JFJDb/lsY32nr7AVng5hW87R7rAc76ichLd9hZuIx4hP7yCjPdZzjAA4dvcXb7QF
	0gDfWp8Bbtgkbuai7mGCceczAJzdmBJG8hEKsvn66/NiwJv+YtXMTEtSvhrr0oM1
	WmEekXb8kfWqxHfqvJ7a7Ms+EJPy4hFyg4noP9VCmlXVL1vPS0Sxovo6INk6wZ8D
	jxfawk3mP4lQYQJHS/I1hjWltstYnzAABLK5ATqIIkwJSJVhwpVjNz5zyiyTlwYb
	aqskZIiAXaTIFFJvhtygdchSjNDPrQgO06lG/nJ3XhW757sZUfBT3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Ic1khlmipz1FjgtPaiy4ZrqDft1
	3v8QSYTaH6PaAm3k=; b=UWXTCqNsVuZrN2pqHmKpGYF0gjrzItSkcJsF1bFa6Qv
	yHCbkyG6CrOcfjYggOI9ueDpRvIWwtBbIJRjIHjYeWQPSVGZiNwf5s8mS9m+x604
	Z4t9OGNgnRlrNEc7CHMX75na/c03q23GUq1OPr43EE8zFZPnc8ybg2Z8wEnqjIHw
	CfuluBRCNui7/Ho3Sumuiw6YGIRTVxgIt43zLVkpAVQQp9VcTrsPREzU4Kiufsr4
	v8gOnN27UCPgiv991DPUVpMqkVXsQq7MNajAGEgYlDMzGA8iZLFYxHnNRmwOZwhk
	IvK9eXRCJam0DUJR779dyCcDzsjdQC+dZ7aR908oMSg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvmc7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:33:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMXIQG017448
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:33:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 23 Oct
 2026 18:33:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:33:17 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMX4lQ005794;
	Fri, 23 Oct 2026 18:33:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 00/16] iio: adc: ad4134: Enable greater sample rate data capture
Date: Fri, 23 Oct 2026 19:32:58 -0300
Message-ID: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: lXvf_CJHvU1JIZdvDsSr1I-9SNxm8VfI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX2+KV3a27chR4
 PF9aBFgG01B1wtTgogFHodT8i8rFf+IbNUDB1Pd7hQcnWUsUqeKNKrMytb9qOt4YDK7Tl9eq3bI
 CwLcVgIn+MGNO64kcYYogceiVbsNrVVTrPP7oc0YX/5BXU4aMsEG
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adbe0af cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=ij9GacxZUiyJ1JgV8RYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX+iNZSZCrFJy1
 xMgXhtbrhnle4B83/otBtep1uHr79Fsj7jwmfCAYkBlwxE0j9F2O1kqCc6VSkh9FG0g2Hr7BVQI
 xJMNmvK/tA+uhHATQD1mv76Z/uVqGGQ7Bq5amvaByYdsqiEq8bXHz6TDtMecFIM+XPi86sRHblB
 eivlIWtJDNji3Bj0l7B9blcOt5uXGq/DUkkswPinvIZphsWA81c21JnsLr6DE2Uac7DcQSVpjXb
 EbMQigE2UJSjq/EltKqucPFwf+AImr0MlV2XOH4JkAHeE2mLUkX4KihNnsJabCPdEEHJJfCHx7o
 WUIVH19wo/buBgQlkMlgzUduBclfLNAkjPXnsVIQLGjEVMUC8eCt4qeGH9o1lGcFI3TQjAAvBNp
 eHYX7SFyK6f/NMwvykBLzi9Rx/qM/KcbAu3UQQ8MFLXayqYS5t+/6fXIge8uUQo+KBY6fGWlLxS
 2NqKDKbQOoveB9vr1Cg==
X-Proofpoint-GUID: lXvf_CJHvU1JIZdvDsSr1I-9SNxm8VfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230088

Extend AD4134 support to enable greater sample rate data capture. To achieve
that, provide control of digital filter type selection. The default filter
type on device power up only supports sample rates up to 374 kSPS. In addition
to that, enable interfacing with AD4134 in SPI 4-wire mode that can support
reading ADC sample data through multiple wires. Finally, use SPI offloading
to speed up data transfers at up to 1.49 MSPS.

Features being added:
- Data filter type selection.
- Triggered buffer data read.
- SPI 4-wire mode.
- High speed data capture with SPI offloading.
- Device tree doc updates.

Minor improvements (introduced before the new features):
- Sign extend sample data.
- Apply reset recovery wait time.
- Update include list to comply with IWYU principles.
- Serialize single-read operations.
- Run shorter transfers when CRC is disabled.
- Protect conventional device access from debug accesses [NEW PATCH]

Change log v5 -> v6:
[device tree]
- No changes in dt-doc.
[IIO]
- Correct reset time to microseconds.
- Added sinc6 filter_type to IIO ABI [NEW PATCH]
- Added Fixes tag to iio: adc: ad4134: Serialize single-read operations
- Better explanation for requiring debugfs synchronization.
- Lock sync_lock mutex to avoid filter type read interleaving with
  read/write/modify sequences.
- Now running bus preparation routines on IIO buffer preenable/postdisable.
- Put dev_err_probe() in a single line.
- Use mux_state local vaiable to improve readability.
- Restore SPI mode if spi_setup() fails.
- Use cleanup macros to handle claim/release pairs.
- Check the ODR to SCLK offset aginst the maximum ODR high time.
- Removed defensive offload support check on read_raw().
- Added comment explaining why single-shot reads are not supported in offload mode.
- No error out when pwm_round_waveform_might_sleep() return > 0.
- Adjusted intial ODR PWM target duty cycle to odr_high_time_ns.

Previous submissions:
  v1: https://lore.kernel.org/linux-iio/cover.1788368334.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1789494473.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1790719424.git.marcelo.schmitt@analog.com/
  v4: https://lore.kernel.org/linux-iio/cover.1791309733.git.marcelo.schmitt@analog.com/
  v5: https://lore.kernel.org/linux-iio/cover.1792200021.git.marcelo.schmitt@analog.com/

Marcelo Schmitt (16):
  iio: adc: ad4134: Adjust register map range
  iio: adc: ad4134: Sign extend sample data
  iio: adc: ad4134: Apply reset recovery wait time
  iio: adc: ad4134: Update include list to comply with IWYU principles
  iio: adc: ad4134: Serialize single-read operations
  iio: adc: ad4134: Protect conventional device access from debug
    accesses
  iio: adc: ad4134: Run shorter transfers when CRC is disabled
  iio: ABI: Add sinc6 filter_type
  iio: adc: ad4134: Add support for digital filter type selection
  iio: adc: ad4134: Support buffered data read
  dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
  dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
  iio: adc: ad4134: Support SPI 4-wire mode
  dt-bindings: iio: adc: adi,ad4134: Document PWM usage
  iio: adc: ad4134: Support high-speed data capture
  Docs: iio: Add AD4134

 Documentation/ABI/testing/sysfs-bus-iio       |   2 +
 .../bindings/iio/adc/adi,ad4134.yaml          | 110 ++-
 Documentation/iio/ad4134.rst                  | 127 +++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   1 +
 drivers/iio/adc/Kconfig                       |   8 +
 drivers/iio/adc/ad4134.c                      | 781 +++++++++++++++++-
 7 files changed, 985 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/iio/ad4134.rst


base-commit: 87e28db23d0384f3995c43ecc5ae2118b371edb5
-- 
2.53.0

