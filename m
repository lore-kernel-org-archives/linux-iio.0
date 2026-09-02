Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518D4AA582;
	Wed,  2 Sep 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369697; cv=none; b=j84Qo7mgPcmLsqFvpasxOBP+5PeEWXSDjgtgY7K7g6XY8Q5G0522qvXpgp/tpxRMVcqgY3SfXU4G/2ePvS8wk4wEXGEj5UZSL4aCOXwAgCC/7SEKKRIvqcj6YoDAfLCm38qVQsXISPHN4pOIM7tQDJ4LsalPwY4AXWE7Q0WZ15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369697; c=relaxed/simple;
	bh=wDRrwiUV/kxXmBMc7Yr1SgmFiQbXY0610TVCv/PYfIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDq1I60pEeX7lbL/ixH+4vU2tmkQT1YtevE0a5A9lDnEsSMdCEueRf2qGusXJwJJfot3HDYqNuj0cB/cz6tXX6pKQa5t5dYET88SeRfl6dsgQnNzrXIfDkLxRYHyS9YAxPS2hFm2Dkdw5TZdKZBfde92+mAFxlGtpcsAyDkH/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=M6Mzq4/T; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="M6Mzq4/T"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HCwBU3525540;
	Wed, 2 Sep 2026 13:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=CSFd707lFcXmBBll+fUByaTyO03
	HpNpXAAGlQ6Gi2OY=; b=M6Mzq4/Tnrgs7d/VpgtzVPpT//dHgW8drtDuR1Vr9G8
	XnyyqySqef7OLVkVwR3YaVTrJ4WcZBlRqLHXG2HytAtM9r8sBl7mVH/Uy8zsVfDx
	OLLq0TJLykBiwC5cYNoLFZiZbrRO8780bKAZ6u8X8Unhkykw/dEZ80P1MmqkjpHE
	GshROPSeFSJxzW9RWgkM2a1PETuELbG7YOKVihgmXt0LzqMI/RBnXc19hYxDwQoa
	1YoLY6qn4jG5f23a7N0oXyB+9YzqOnSOgZTJQptLkM/ysB5BqFaJHB7luvDEiL7P
	IRNGZugwocwDQMZ3MXhp+By4t+KQZqE/1S9a6qBSI9w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ge0yqp6j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:21:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HLS8e041099
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:21:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 13:21:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 13:21:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:21:28 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HLEFx004195;
	Wed, 2 Sep 2026 13:21:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 00/13] iio: adc: ad4134: Enable greater sample rate data capture
Date: Wed, 2 Sep 2026 14:21:08 -0300
Message-ID: <cover.1788368334.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: E73GVjURCVQMCS_hAmSMbUs-6jH64gJd
X-Authority-Analysis: v=2.4 cv=S93pBosP c=1 sm=1 tr=0 ts=6a985b19 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=_HPMAmH9w-363B3F-6sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfXxP2Z/wlrq+QV
 J7EGCcY5ioS6jvxT8gOO6rX+Q9SM2acaOyC40s6N7RvzwG7u3oZGDEwcydPVAH3WBFPeRSN3mW8
 7VgDU3tad53ZjTUlzARt6HKESOARti08VFUiMgdsBJUl1oI8bNUBl/eI5cPujTq+ydc8IdYv62Q
 +K9MB/AYHH8vfMbgfzM0l4oEzoLRaS3CYzeW8JuFvzRZcYiD5fnFmzDEMQplHbhwm23fepofxmg
 3KHTBTCpolciFWeDAC//vP+PTq8GwbYzHNGV+bHlCwTEX5HqWvgBcRPEgWmDnNrDDy7iGmM3Gji
 8MznAucy0N6i6BDZ1P21LuL6FLJkAtOaUOuFMyLQlia1uz1BS7XuFCyPEWoZmjoOak+5cnypHW4
 h+dCyYERV+wCr/ohxLYo2ckMKDJEoxa5ifTvKQh7lmiI+qYtNsRL8oJhqKVExHh99gOmIc+NZCo
 F4wqkbc4lwvk/d2It5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX11uKUxgZSPcD
 1ABp3OTLlI8nS20JhZwXEQZVEyQd6lXV+pBPHNS0GhZkITYX+A376551ioGO6dEhITmyB7a75it
 c81IodTrb1VsKjxDxf2OEgt5qjphNDxAF4GAxuRuAbTfmPjaDgUG
X-Proofpoint-ORIG-GUID: E73GVjURCVQMCS_hAmSMbUs-6jH64gJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

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
- Device tree doc updates to reflect previously missing chip characteristics.

Minor improvements (introduced before the new features):
- Fix typo in vendor name.
- Drop import to empty name space.
- Update include list to comply with IWYU principles.
- Serialize single-read operations.
- Run shorter transfers when CRC is disabled.


Marcelo Schmitt (13):
  iio: Fix typo in vendor name
  iio: adc: ad4134: Drop import to empty name space
  iio: adc: ad4134: Update include list to comply with IWYU principles
  iio: adc: ad4134: Serialize single-read operations
  iio: adc: ad4134: Run shorter transfers when CRC is disabled
  iio: adc: ad4134: Add support for digital filter type selection
  iio: adc: ad4134: Support buffered data read
  dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
  iio: adc: ad4134: Support SPI 4-wire mode
  dt-bindings: iio: adc: adi,ad4134: Document PWM usage
  dt-bindings: iio: adc: adi,ad4134: Add high data throughput example
  iio: adc: ad4134: Support high-speed data capture
  Docs: iio: Add AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          |  68 ++
 Documentation/iio/ad4134.rst                  | 128 ++++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   1 +
 drivers/iio/adc/Kconfig                       |  20 +-
 drivers/iio/adc/ad4134.c                      | 698 +++++++++++++++++-
 drivers/iio/dac/ad3552r.c                     |   2 +-
 7 files changed, 893 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/iio/ad4134.rst


base-commit: 8992f32c57607bdfaf5de2a2cd26b3b71f3a9d55
prerequisite-patch-id: a509ef662def60ff7a33b7dd949f26cd0eb1b8b7
prerequisite-patch-id: 6b5e2a61b7363b24fa9b9d2f6b20de57550415df
prerequisite-patch-id: 8dcffa92e3d7686214eda37a00a7c58d969d1bbf
prerequisite-patch-id: f84fc98c5728b8a2d401aa97507bed57e4748c7c
prerequisite-patch-id: fc9dcff6eae8019f0e0c38409cfafe020d5aaa05
prerequisite-patch-id: 578583880ef301e0901be4b23d05de5a1ccca926
prerequisite-patch-id: a2a4b770f7b76b965a2eaac95a7d8d1b6c956a7c
prerequisite-patch-id: c42fead7b0d37866757d55679ec2252bc67e9679
prerequisite-patch-id: 851fddf35c3e7cf142a0274879f7bfe354c44b48
prerequisite-patch-id: bcbffeedc3004ae7c7d38e0968248379a2cc11d3
prerequisite-patch-id: 29da6bee42ad3a8a1c1ab3cfa7196e3da8c255a5
prerequisite-patch-id: 24b9fc5c9f8f5e39454a714b6119bcc66c68c332
prerequisite-patch-id: 17ef931c5e720671a4ad3d245c530c3b225a11d2
prerequisite-patch-id: d6c8f2b172bcdf33f3e26cce3aa257cd6abde8f3
prerequisite-patch-id: 5362999f38f6c7db8c232815719d62864cdf9bb4
prerequisite-patch-id: 3c45895d15347202dcb333f4b75589defda6c8bd
prerequisite-patch-id: aa612ba587be22841cbaf1e817afc037a53bdb6e
prerequisite-patch-id: abd9264f4a8ce712fc02a6759cd984591e080714
prerequisite-patch-id: 2305923b790db41e048b4eadd2751837ee356e0f
prerequisite-patch-id: 99eba606a73a31f9cd8edf9efe43f353fa4c6dc1
prerequisite-patch-id: a6821645307265ecb3e8a9192a7ca75ff4ef4c25
prerequisite-patch-id: 3d73401e6137ec3f4b9a2c74aa8bde5ac73c7f43
prerequisite-patch-id: 980b5343a5ed0d38dc3deb50168dffd9a3aa94e5
prerequisite-patch-id: b6ad0c491dffc778949b689a82ae881bd73a7e70
prerequisite-patch-id: a180b3ed7c48d6917291db69f2c737d5f0ae54ef
prerequisite-patch-id: 206d438356ef9752c5409ef2ad6c8abcb4561bfe
prerequisite-patch-id: 0c21540845530f357bd1f0ecd5acb6933396b011
prerequisite-patch-id: 83d82a4a7da474a2be230c938cd01a8654db4b76
prerequisite-patch-id: 7a7bbfcead00fbe85dbcc9717a322dd394c115ff
prerequisite-patch-id: 56fb22d293ed8d1f00446bab19ddd3eab5927a22
prerequisite-patch-id: a54d660597db7fb3f916e8a3c9cf7efa401ae7df
prerequisite-patch-id: b9520c10d63f34769b18ac2034dbfe86e21444aa
prerequisite-patch-id: 2d3f13c29a14be6612de58b0ff45de3f25fec6a2
prerequisite-patch-id: 04fc520dd6f9ab1cf21b50d9052fe42072481407
prerequisite-patch-id: 98aa7964283264e9fb272303f020d96e9d2a6b58
prerequisite-patch-id: a5affc1602a01d0591824a7d11411774fcd381e1
prerequisite-patch-id: 9d8e457f7f9922a6b966193f207332efce7a2259
prerequisite-patch-id: e242d91086a77f3405497a0aee5ddafa971e735e
prerequisite-patch-id: 54e443d84b2f92b602b98d4a0cb902fd83c86691
prerequisite-patch-id: 36db49f322d7859248ae7a51f48f6c9a9986c86e
prerequisite-patch-id: 7dd860477d9c68f12baf74013c7c9b217086ea52
prerequisite-patch-id: aacc247928434df5d0017b6e96e6e8ccab4fd98e
prerequisite-patch-id: 60ea842bf051438047cc6d4383de237bbd7d57a1
prerequisite-patch-id: 1bdde9ce22e6b2818245ab8441fc22a203c116d0
prerequisite-patch-id: 9013dbccb132763b987e40e41d0a2141a4732144
prerequisite-patch-id: fa77c324defdf995d708ab78b46d03e4c456a046
prerequisite-patch-id: fe533cbe9cf454eef8d50aa340b21e1052458f17
-- 
2.53.0

