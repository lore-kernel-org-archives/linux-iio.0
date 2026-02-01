Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323A31985E;
	Wed,  4 Feb 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208395; cv=none; b=H5zk7NJDHYrEiAshISqYTRqNIbqNHldorxtpeOhUdmFvrTYikb/oOThlzfmWyZkWMxXnxtXDqJ76sndUU4wcOAvWCyIL3hJC8Gycz97MROnnIF9YjkSJdThCDrn/CfT3tPIf8nplDmV7W7YyGvHefZB/wV+3VqD2S2OqCc17CNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208395; c=relaxed/simple;
	bh=NzIqenfRF9MVbZqXge46guDJLTq/DND7bsDiUqlFO1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hp+JQhbHTpnXoXb9KDUy5xmR6a6V2ngjfVjSRZwpo0tQ+H9jcz8qzhOtkUfebWM+A/S8xGXV4w/JSw7lUGOYy1yxIVInoMNgX4hjnA1daiVxBEniWeKeZMrUtW/bW6FSRuFnCgYi2g6A/6fGmAhv9YmwRrzgrzfgAEPu7EwDrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HyO2tznt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HyO2tznt"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6147krvI1105346;
	Wed, 4 Feb 2026 07:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZMbwgCPL4OSGbZboM5BMFLb7Lra
	jTIql9Xne806CnbA=; b=HyO2tzntMFH6fELtI6umQxW7rcgJv+WLaIJ3vJhCAbO
	e3iZ9dHUu3vJKC36vp7J6Kcz1YbmyDdYTszzbrwoX0pzUH31hOktWWvtBEPK6H9C
	jiJuVCKO/avPd+7aH+Mcz9PV7SOY6KGGhmRP8aE1j6vE1Ma4X4O/WcrDazXIrfml
	zt7IHsbNVP2eVvhgFq+Fp9HUeQuDiZPCCgPe9Q2BfCYLkBDu6YfeiOqksGysqQjg
	utEb6kfIt/fSLm+34oIdKJI3T+jbHECjzIgIth1K5F8Eba1fCmWmbVxyBuMxIlkd
	2lbnPNwsA+C4/rFJYLHrBibzld7GncaFmSyHuRz3U9w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vyp23yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 07:32:52 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 614CWpfV055411
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Feb 2026 07:32:51 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Feb
 2026 07:32:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Feb 2026 07:32:51 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 614CWe2L007385;
	Wed, 4 Feb 2026 07:32:42 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
Subject: [PATCH 0/3] iio: adc: ad7768-1: add support for SPI offload
Date: Sat, 31 Jan 2026 22:35:07 -0300
Message-ID: <cover.1769889074.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: CkiR4bb2EKWW6aw0qI2jS_eP0lzZMLJq
X-Authority-Analysis: v=2.4 cv=RujI7SmK c=1 sm=1 tr=0 ts=69833c74 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u2j8JulxT5n8XN6WP7oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5NCBTYWx0ZWRfX4UVoTbhehSFk
 R9ht7uuh3Coe08UR6LMfTJkemGjvYThGy55hgBCUK9ZXvcW0jq/PC1SetcynTnQI+w3NC7zX49Q
 xJzUsDmf9Nnn/yA5JgtMuQOfAtL1qz0tUsjLpTS74kIS2zXb8+VeYSWRUIaLykWLevpPAhHMVPk
 yeS3LYLm+G7b5iLUG/BmpBsw1oq0M+q/QPGagEHFXoaYE1aTMuJGh87XCLu7VqegMKilRZJGbnV
 OpqgBXTq8gGuNJUJFUJ7+S/qb8cbCq3Wt7lLDLriwgwDfhS0hkKifaj3KCC/vJjxA57V50xeSgz
 hPIxHSR95EbbvEGxZpDe5SHl+hI1Bp7zezPQLQtM4APIRo1mSR1oLO7hU6gV7b5WrsEMi+v6ao7
 ZP/jc+idVEIq58cv0qpPSwvOQKHCKDrWymHmTVIQah7TfOMm+doPch2QIymjfdMpEU2iqGMSChT
 dv2oF/6t3hz+RtRH1Dg==
X-Proofpoint-GUID: CkiR4bb2EKWW6aw0qI2jS_eP0lzZMLJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040094

This series adds SPI offload support to the AD7768-1 driver and includes
two critical fixes for one-shot mode operation discovered during testing.

Jonathan Santos (3):
  iio: adc: ad7768-1: fix one-shot mode data acquisition
  iio: adc: ad7768-1: prevent one-shot mode with wideband filter
  iio: adc: ad7768-1: add support for SPI offload

 drivers/iio/adc/Kconfig    |   2 +
 drivers/iio/adc/ad7768-1.c | 211 +++++++++++++++++++++++++++++++++++--
 2 files changed, 202 insertions(+), 11 deletions(-)


base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
-- 
2.34.1

