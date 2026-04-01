Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1F38945D;
	Wed,  1 Apr 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044701; cv=none; b=CRtiGVI7DgbwS99gQDD59wJJs3y8RjM3BYUTN9Dn6+zN0jP5NpohVC2gpidUYgmmbWpu3qDmB6dCAnlj6uo5sNIfQw6MTs5IdhDS8c23XI20++OvaiFSlkUu152n1dwzNvr/AEVJCTXZpWXXShepr0XuK67kOloSJ3XoMfz2OfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044701; c=relaxed/simple;
	bh=rR0lvU02yMlgGDBoR+/mcdfwYgMejb3xIrsdWzKc2eQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sToQPLsMy58yVl/E9nuvEY95E4c/ZP/6zt0gAiAwa1W0uj5qg5sncHYG14pfqN4KzPWsKmxpM1LcDPJHPWqjVqR1rG927lFPbnXargsFnzD3FuEafpuAhQAhYzxzCp1F4EkI27zMWjeMWoX7yVFylZjY8GuxJQUZY53I3FvaYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hM/ZhVEw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hM/ZhVEw"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6316mAhD048250;
	Wed, 1 Apr 2026 07:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ezEpVFrk5dBhp4p7SgHnNwujlpW
	u0J8j6vWXS1CQOmE=; b=hM/ZhVEwU0bNYD28GPl6637cyxSqm9e3Q7P+H6bGtYp
	L4tZOkYwoyoxpSnLVFVBSPDLlvgGUHPxh1Zs2b2GEMSWyLYyEw9SPQyaDjiFqX5r
	W2qpx8110uWuJVRWnMQEQLBtP9W6Ru5Uh+SMFVtY+1PKqSO9pbXuhz5nRHMrHTp3
	EYR2BPLAjF6PgRScan9Wk2JY4AAlzeJUunVs3Mz+8AtgfedRwFZfmHp/d0tk0vWT
	NPQxWRI761s5Max9tWKJec5IHH7uZK07s2e5Q0/4TENIgQh3MhB34hFM+gJwHlKa
	uQ7YZ222qHPmzzTpL/lPjmiWekUDEUyTpyfIbfPmV7w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d8xdsh5f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:58:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631Bw3oc005113
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 07:58:03 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 07:58:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 07:58:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 07:58:02 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631BvnLO011461;
	Wed, 1 Apr 2026 07:57:52 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v3 0/5] Add support for AD4129-4/8, AD4130-4, and AD4131-4/8
Date: Wed, 1 Apr 2026 08:57:47 -0300
Message-ID: <cover.1774996100.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExMCBTYWx0ZWRfX2EmAK1bsp3/C
 fjru4hKPpFfi9SzsEsrtkQvvlOtMYx/WZYM18mYzX5Ys31DV+BtZY04nu6EoOcvGsXIn+AyQhCi
 WwsYXHQSovhbVTmPbcd6nkZA3ODY2FTWzjTjOpR9HeBHBtr9sTDQXGrUTMKm0thzXwus3FDlCBt
 cUlgwBroO4RLweb/RJEloszF4IT9jxZ4snB5lpnrjMTIsLJVAtmgMNv9YfZvz/O247a6Dy3QqoM
 2NiGPo9c0PXCGQ9VRJpGnqfGeNGbnkVbo8d8xFDFuF1YHyv1fGFEmTtTR15YeTWBIzc//j51TPm
 bMlMtFV1Iw6aozV3uzMQd90Hnc+piHIWMBGfh3ccd37JqOxWSsX3zWEp0cPQmqn+Odw1+32hOPs
 bpRsObBSnn78zmdAVV2ox/aD0M7HwZ/oEuXeRKIu8TO6iKEyy6tIopeSsaIu6reJNa6z2S58SJU
 xyIABtJpqGqIHHi42YQ==
X-Proofpoint-ORIG-GUID: gMvZzzZBc7WdbSoP9U9Mlyd8xXorRBSG
X-Authority-Analysis: v=2.4 cv=cqiWUl4i c=1 sm=1 tr=0 ts=69cd084c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=r2fEcVj2N2yMaMJQ_G0A:9
X-Proofpoint-GUID: gMvZzzZBc7WdbSoP9U9Mlyd8xXorRBSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010110

This patch series extends the AD4130 driver to support additional variants
in the AD4130 family: AD4129-4/8, AD4130-4, and AD4131-4/8.

The series introduces a chip info architecture to handle device-specific
differences. The AD4129 series provides 16-bit resolution with FIFO
support, while the AD4131 series offers 24-bit resolution but without
FIFO capability, requiring triggered buffer implementation. The 4-channel
variants feature reduced analog inputs, fewer GPIOs, and sparse pin
mappings.

---
Changes in v3:
* Since we have either FIFO or triggered buffer configured, create
  a union struct with the FIFO buffers and the triggered buffer
  scan channel declaration to save memory.
* Some lines in the ad4130_trigger_handler() were ending in comma instead
  of a semicolon. Replaced the commas with semicolons for those cases.
* Inverted logic for wait_for_completion_timeout() check in
  ad4130_trigger_handler(). It was warning on success.
* Addressed other minor suggestions. See individual patches.
* Link to v2: https://lore.kernel.org/linux-iio/cover.1773311639.git.Jonathan.Santos@analog.com/T/#t/

Changes in v2:
* Add patch documenting the interrupts property.
* Add patch for the SPI id table, moving its content from the chip info 
  patch.
* Addressed other minor suggestions. See individual patches.
* Link to v1: https://lore.kernel.org/linux-iio/cover.1772078999.git.Jonathan.Santos@analog.com/T/#t/

Jonathan Santos (5):
  dt-bindings: iio: adc: ad4130: Document interrupts property
  dt-bindings: iio: adc: ad4130: Add new supported parts
  iio: adc: ad4130: Add SPI device ID table
  iio: adc: ad4130: introduce chip info for future multidevice support
  iio: adc: ad4130: add new supported parts

 .../bindings/iio/adc/adi,ad4130.yaml          |  19 +-
 drivers/iio/adc/ad4130.c                      | 493 +++++++++++++++---
 2 files changed, 427 insertions(+), 85 deletions(-)


base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
-- 
2.34.1

