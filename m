Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5ED3AE71D;
	Thu,  5 Feb 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310015; cv=none; b=ki2NGiCTFTMtmfFP/UukLWuw1AblJmhteZyXRb1QKOFVxBCYQTLsVgCbhEqXrByh31Xnc8MXK3SJmqct9cVXWtmfQTckaQ8Yfj9S22xpI4dCeYiGMOjrSLOlKgpCKHLlRwGRXuKiBr2bMcO1X5bLNZH/pBjdQi7QcsKHYXXd7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310015; c=relaxed/simple;
	bh=3ejJ7GZhlOB8ESWvMnhKthxwomeKCKyruo5NJZ+DbFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FeHwzzu89behrhFju1ZaAEVUal8GxtbLmdtqNr14FDm5xIYyPcTWbBb3EovtV/ADaZCYnhFOSj2MFPCjO5DX0nAhP3QhSlV1BZTi6OXpwbrH/97zFf8ypv6ryP4fNlIeb9Om9E5E7wYHZqzOUM4UEd8naVNJ9UY4twEarQHqMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zgS+7rEl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zgS+7rEl"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615AbtqW2446906;
	Thu, 5 Feb 2026 11:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=eCwUVWXWHlEDa7Qr/29m7PSYnMs
	5odPbdF0z60i6wGM=; b=zgS+7rElbwl93lFV3+IGxPBLmhIzjLBm1sMbOrBjaHj
	sQ++YWprc5XxZtfJFBJi8pa9vjm+BN4IftFIhp695SoyL/eLZlDLo6ZyEOvnrzwL
	XDAgqOhGRi7Ss7XZPFcMmi6c1nnGAnFY8RenAiMSTqYxhZ5Rk//dmu8/erDWZ+Uc
	KPTWsG/8pG2gywHVoNu44mMa5MgERt0ItscFpQijvp7Eco6Bv9bxIIa2jYJj6PLk
	TuAxfY7uHXtuplorVOthZL0dv2KL9DqFvcKOAui9Wktg058CQ9P4YZDclIR9+Uha
	kUTwD3JLfLfTwb2dhA4nvjlBT3/TMi2h90r9gNCVH2w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vxvg1w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:46:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GkgHw045089
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:46:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Feb
 2026 11:46:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:46:42 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615GkSmZ032748;
	Thu, 5 Feb 2026 11:46:31 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 0/8] Add SPI offload support to AD4030
Date: Thu, 5 Feb 2026 13:46:28 -0300
Message-ID: <cover.1770309522.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: ye-F2vpOnxpPLL82N4ajpC8q4ryYTnlT
X-Proofpoint-ORIG-GUID: ye-F2vpOnxpPLL82N4ajpC8q4ryYTnlT
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=6984c973 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=eXcsWpFgLpc5g5fiTO0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfX6snuwllMbZhz
 jsftl+4ciNz2sr14MbioOl0rIuFjbf3GqDK2XfVv/aMrg4i2to6lXcNlOb5I5+In+Itq8QPI6SA
 wAiqlygRVCJzsBJMnnshwITw5al6znAlq0HGsiPo1R/tnlrp6BJ727bhqFN0rsIJ+/z3KiRMNlh
 rP/gr1O+9WUDHTWAk0fnfY3m5F5xnO2sJkpfn25PW7ojGhVivexR59Z72Ri+4Q9XWdZYIKsvZ+N
 sxcAKWEcMhK+JCUb0679xpznlSUhj3KJ9u1l9v9HRNiRuF0GtPhUwCNpQhkt03HSsNqaYzipY2X
 toAZPiMKn6GmClr+pntlBGW2R3Bl9RCj5MSrkA1q0r2dh026GnEkRCfs7IxJITpHylUDY3gORdW
 7cn5IWGTdFLW+sUzEHtV5ANv3DEoBtaNlnP5FkUMBwdXBM3DJWZVoLpFRoQ1S5oIg2nt0gBfzbi
 scKazfjG7DZWL3n5R+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050127

Hi,

This set add high speed data capture with AD4030/AD4630 and similar ADCs. It
also adds support for ADAQ4216 and ADAQ4224.

Quick recap, this set was extensively reviewed but was put on hold due to the
need of updates to the HDL project associated with these devices. Now that the
HDL project has been updated and retested, I believe we can have the driver
updates added to the IIO tree.

Change log v6 -> v7
[DT]
- No changes. 
[IIO]
- Dropped unneeded enter/exit reg config mode, simplifying offload buffer setup procedures.

Tested with ADAQ4216 on ZedBoard.
https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad4030

Link to v6: https://lore.kernel.org/linux-iio/cover.1760984107.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo


Marcelo Schmitt (8):
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Support common-mode channels with SPI offloading

 .../bindings/iio/adc/adi,ad4030.yaml          |  76 ++-
 Documentation/iio/ad4030.rst                  |  39 ++
 drivers/iio/adc/Kconfig                       |   5 +
 drivers/iio/adc/ad4030.c                      | 640 +++++++++++++++++-
 4 files changed, 735 insertions(+), 25 deletions(-)


base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
-- 
2.39.2

