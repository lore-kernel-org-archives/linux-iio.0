Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500038399E;
	Sat, 17 Oct 2026 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202197; cv=none; b=kgsXLyy4lCzLFsntP+fnoLguxhJcoztbAfNirfrvBXy+pnPpAVl+0upLoYGH3U4yucMq/72Cwo7Fr9kLS8A/K3ugAIiWnCW5GVrHgEeK2BoAxH8wPBY8MpwEUbQufVpimIEZM1zXW6DCLJqlkNm7ykaLy3aSlFhfG2zc/hyj5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202197; c=relaxed/simple;
	bh=q2MGPrx8GO6ad1Cl5d2NSfjNXSrrboLG2FenAdA2f/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uLZaamcAU0ULAnlxVHfplcilLyisVvLsH5PHYjk76CZ+8mp4Tcja9XnQsdOadubnKytkIJwqQBPbKJQ99d1n90lRsygIUUPeoWbxBCzto0DLtD9XvJOK/cdLNQ3PlnpxkElx2NAezvNwu0wF5beWFxUIVqTLjGijkOIjF7vwA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=iDrshQ91; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HUX5hwc2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="iDrshQ91";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HUX5hwc2"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHErU2042920;
	Fri, 16 Oct 2026 21:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=A53dyKd5VGHh2d9x
	6km67uOdY0Gwa4YwjSqzGZvtC74=; b=iDrshQ91HpTzGj/QlNpAyuHcEpLQt/BA
	yLtsxC7zTJHuueQg4MiClfCDBrR1kr0rbtpc9D0yp8a4RQLES+3pJPg/Rj1dn7m7
	FNR77e3cX3PGOmKL7uPrQPczoqD0iFda6yEiUZR4+mNz60A3MH8muDjpdiZBFcP8
	RvSh6uwtpbjfg7X6R9kcet4qdfzUFzmhZqS2gsfyPIZDoRfj1dOrHpK0QiNvtNuY
	EomL7woxux/LZ57urmREvHPMZOoYQZy2E0mUvgZrwNnQ34Po06MiL2aaADm+LjiB
	qSMz0kokG++TSnJCahifcp1PziYVG3ClWbJ7qZ2za3LVtKSHODJj+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=A53dyKd5VGHh2d9x6km67uOdY0G
	wa4YwjSqzGZvtC74=; b=HUX5hwc2ymCvqcaBMQ9WR6YKbHBciHKWFCvyAT0cOb3
	iFmTeFbb5Ht/opE4UFTGN6kFtKbdTpky2MScHnd8ehqnS7x+dzj3sl0/QuyKQx28
	tvyGgdWQoJPiKMSjbnKR2NM+iRJOgu3VevJ8QEr7rAtmn1fYIIMdadleikctmfD/
	yFupy9nmeG+EUHENru8yt66OmNUdHi+oKVuyoIqChRM/AcNvh/kt7gnTlVD1fFxc
	5KkfvU9J18AO0GasidBGayRotlIsQaXXXCytys3v2Ma+coyFaykhQ8bwRi8Jnwf+
	bimfoEaks+DRL/hgRwHHvsn7mDtggZlwdue0gSKs+pA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hbajk6kr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:56:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69H1uQBx047561
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:56:26 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:56:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:56:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:56:25 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1u77q004277;
	Fri, 16 Oct 2026 21:56:10 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 00/15] iio: adc: ad4134: Enable greater sample rate data capture
Date: Fri, 16 Oct 2026 22:56:00 -0300
Message-ID: <cover.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX9s6Sl5UwuJs+
 rSRHhfF2o1XXQBNSLzg4DE0c4swq353r2XcV7Ith9zfeFarUrDgRRYlYn2EmXx6Acfwdk2gh3Kz
 uAOmx3lITxbE0mh9pxC2Vxt5YhoH6FJzD/yxY0uh1BRDJMK4vouf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX20v3oUolQuto
 cw1DyJa/AusdtvC9O4gxXPDd3+PIKqWeGfAD6f4bsfUdBsT4aLWJmA7/evkl3qWArfD1fzQMUUz
 S0cJ81n0BRLxlihpPO5UfrqxQ83aiMfhm97g3UbFp2wwoyEm1nqQvmqyit4+mnoVVWRthEHQ1JZ
 WtsGi91etCVaqhXTxQEouTHZAfRIcw6SpXiCkC+THyTb7n6Ue52b3REdWQulze2vbLxe7+0asQD
 4pC4I6uSNEHA1ogidsD2clLDaO9C+7h1jPnodNl8mVcuLq5iiskoKjQqFwmi+/pzIPBApYOzxRC
 DNSUFTRrmOd5c65Tpdy621RPSNxyfqLx86stUQ529sLxj7vPaYM1AFC4VjoyBAVvB4R/rYin7Cz
 olArx0M8KHdh9lpZOPyHNQikeoPGOsnR5kmLK0IGce2+2oFTgl8KnmugQGXAOg8O64w6kWRaCdW
 vrKPEzZs2dViiRwUCOA==
X-Proofpoint-GUID: cOVYSDd-OA-8Psu1b7VLAku33cxGsryA
X-Proofpoint-ORIG-GUID: cOVYSDd-OA-8Psu1b7VLAku33cxGsryA
X-Authority-Analysis: v=2.4 cv=eLqGH3p1 c=1 sm=1 tr=0 ts=6ad2d5cb cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=ij9GacxZUiyJ1JgV8RYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170007

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


Change log v4 -> v5:
[device tree]
- No changes in dt-doc.
[IIO]
- Initialized local variable with 0 to avoid build warns.
- Set max_register according to AD4134_NUM_CHANNELS.
- Apply reset recovery wait time. [NEW FIX PATCH]
- Protect conventional device access from debug accesses. [NEW PATCH]
- Re-arranged code so early function prototype declaration is no longer needed.
- Now using iio_for_each_active_channel() to iterate over IIO channels.
- Updated adi,spi-mode property handling.
- No longer selecting/deselecting multiplexer states when in minimum I/O mode.


Previous submissions:
  v1: https://lore.kernel.org/linux-iio/cover.1788368334.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1789494473.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1790719424.git.marcelo.schmitt@analog.com/
  v4: https://lore.kernel.org/linux-iio/cover.1791309733.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (15):
  iio: adc: ad4134: Adjust register map range
  iio: adc: ad4134: Sign extend sample data
  iio: adc: ad4134: Apply reset recovery wait time
  iio: adc: ad4134: Update include list to comply with IWYU principles
  iio: adc: ad4134: Serialize single-read operations
  iio: adc: ad4134: Protect conventional device access from debug
    accesses
  iio: adc: ad4134: Run shorter transfers when CRC is disabled
  iio: adc: ad4134: Add support for digital filter type selection
  iio: adc: ad4134: Support buffered data read
  dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
  dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
  iio: adc: ad4134: Support SPI 4-wire mode
  dt-bindings: iio: adc: adi,ad4134: Document PWM usage
  iio: adc: ad4134: Support high-speed data capture
  Docs: iio: Add AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          | 110 ++-
 Documentation/iio/ad4134.rst                  | 127 +++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   1 +
 drivers/iio/adc/Kconfig                       |   8 +
 drivers/iio/adc/ad4134.c                      | 793 +++++++++++++++++-
 6 files changed, 987 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/iio/ad4134.rst


base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
-- 
2.53.0

