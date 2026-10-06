Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FE883F;
	Tue,  6 Oct 2026 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310573; cv=none; b=FEK/kKhKEdCQQYX0l1FSCKGnCH1X58pqyBFVBJLZH/4vbPqq7wnYr7l4ZnZ9Hfdprv83Ix2WyhCD/ViQQcnSfTgmnIhplgQrVpXMblYTM/meKmJMMpHL905bpGyPksBJBXMcHTp33zJIoj814BqEck3NK6/17qj9zEMV8gDyeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310573; c=relaxed/simple;
	bh=GVXrQoPUcc7WDsKwrmLz+KgdZSVGTNk9TcBrOvYe7N4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OMgNQhuS39ggpAb0JHhNyrOwwynJc9N5c0VgERh8FWYWMbaFnAwbnmNTZHFs9RkAfSBi/Crrmnq3gAVXMRImcL3EWbIHjDor7smUAwc3MwqQQ8g32kIGFnbUKVbftRnVxQ9qrVgOzAHnm2b41aSv5hZFKG3IhTquup1CGDdtMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=BAAdOqdv; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=duJio0fx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="BAAdOqdv";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="duJio0fx"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Hi4i33252028;
	Tue, 6 Oct 2026 14:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=IYiBbJwoGqD7WNr+
	I0Zm5NrUWdkzEJsNFHVTZHPICCs=; b=BAAdOqdv7Zcwzi8bxuoL/HSn2J8MDRsw
	f4Zf4Dd96Nt2CWlCKZbT7I996bysQ1KbGGb23MFG8pBiUXfBEe32lyR1LRo0vUk4
	5u7rEiyunTGRfUyNBs2Nu/f/B4cTC783QmNwnUewCcvzBxrZisfuCzxW5NdwcwSh
	UBuKL4WLHQpXPtUGEq9NvgBF0Rv0t9i6q3fRR2bFBqm4If2YBmnu2RYVj4Hhq8o1
	K4VeY3UtI8sCKwTwmu+uGrl799+IgXcI+PFg21/R2N+Y0mk62dIHWdab1c9GKOpg
	yVeK0xVC2gxlbHse/BoiPjXS9Rx/F0A3s/+cNmqRS/soVGHbdP/gkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=IYiBbJwoGqD7WNr+I0Zm5NrUWdk
	zEJsNFHVTZHPICCs=; b=duJio0fxMAqoRbDhhj9OuOMMNQ2BCgtyTZVtgsz1kgY
	IoM69doQB9LBxmh+4Y9EQwHIRjidRgrZwOjDxiQa8qOzIszv1Dq/C4axeFpxUMbt
	3OVMa8LUhIX7mhhk+QqoZhOIG6mbSTw8lfCryITihKEnWTTBb1B/1TuZAvZXlRa2
	++BHmhmU/BIV/EFGoetf5XGEV0N50MpEs5XlDTOz+eTEyX0/GHzF1H8Eiw2CM1LO
	eQYDjp38yh3XiwKh331MsjwbG6PbICEU+HFPWbL8+HX23hqvhXFfGDdJ2ab/DicR
	TbpyFC21NrRBPChmZ6Y3aEbtfT2qOljOiqR97j3pSFg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4y34jhfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:16:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 696IG4bP009938
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:16:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 6 Oct 2026 14:16:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 6 Oct 2026 14:16:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:16:04 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IFoYg000970;
	Tue, 6 Oct 2026 14:15:53 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 00/13] iio: adc: ad4134: Enable greater sample rate data capture
Date: Tue, 6 Oct 2026 15:15:44 -0300
Message-ID: <cover.1791309733.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: a-x5l2RiUcJ3qRxKF_oz4grqVoaLFSz0
X-Proofpoint-GUID: a-x5l2RiUcJ3qRxKF_oz4grqVoaLFSz0
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ac53ae5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=QfiHAWIskqYIEB46yxsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX5oIlA0fHRkUr
 wyo1B2SFaiKgAxBeOqQ/AvkR9fciQokR6p696Zf8q3+3g34WO0fCCC9jHUtbuZy5uOmYqJjOGT8
 YxA0N8H/lXsEuAAJkYkLxKsAg5TCTBeh8EvPNjvGmERypvFQtM69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX3+mE2T+i5g/C
 sNdoKZo0cSAiXYV2E01VrBQhvdG+tSFqhc57B1/sQl30Xc+vvvTd5zKHuHPO8bnwYBTA2SZBr+v
 fw8+eYE1QXtVkC31s19FM5uuwCGpThjnMF1orbxq5n4zn52MiZevGI6tP+DPCrb1TBxMoMYg/cu
 4AMCc2ttWpdmUL/kAnrka8Rw47XdRrG4tzL7VvCrT3qylaG3FX4KBImNuRbJl7pwgn/+eqfddhJ
 gVEN24ps30CyV3h65LK0QgNMOpYhJOJ+YwDHgKDqLnMO621RjiXnjCuf2zKj4TDLZ6CqEfEt2jG
 rfjl3WaH/RIhnCejVcun483ZhTo5XpL9dBi0vZSZZcVDjWyNg+fpDr0ivuKXCsrVr1JslxBxmVD
 x65CuFMTr23tEu1OrCvRJNYozXA3uBBGbBV2RhmhpaeNuabCcdtoX2uatXd7lIwc+nNjNU2svqK
 B8JdYERFr0EXlwoiGAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060072

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
- Update include list to comply with IWYU principles.
- Serialize single-read operations.
- Run shorter transfers when CRC is disabled.

The updates in v4 are tackles all applicable suggestions from reviewers and from
automated tests/reviews/AI.

Change log v3 -> v4:
[device tree]
- Properly specified vendor custom property, avoiding 'too few spaces after comma' warn.
- Correctly restrained the value/number of spi-rx-bus-width lanes for
  two-channel-chain use case.
- Improved the constraint to also prevent specifying one-channel-chain or
  two-channel-chain without #daisy-chained-devices.
[IIO]
- Fixed typo in code comment.
- Now grabbing the whole data scan with a single SPI transfer.
- Also request ODR GPIO for 4-wire mode when offload is not available.
- Dropped second driver state mutex (access_lock). Triggered buffer handler is
  already protected by IIO device mode lock.
- Adjusted PWM approximation loop counter decrement.
- No longer providing IIO channel separate INFO_RAW on offload setup.
- Adjusted in_range() check to not error on maximum sample rate.
- Minor adjust to AD4134 IIO Doc that made that 1 line shorter.

Previous submissions:
  v1: https://lore.kernel.org/linux-iio/cover.1788368334.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1789494473.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1790719424.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (13):
  iio: adc: ad4134: Adjust register map range
  iio: adc: ad4134: Sign extend sample data
  iio: adc: ad4134: Update include list to comply with IWYU principles
  iio: adc: ad4134: Serialize single-read operations
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
 drivers/iio/adc/ad4134.c                      | 773 +++++++++++++++++-
 6 files changed, 980 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/iio/ad4134.rst


base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
-- 
2.53.0

