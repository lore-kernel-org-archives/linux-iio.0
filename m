Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F813659E2;
	Mon, 23 Feb 2026 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847991; cv=none; b=u8hddRBXGrD30J1Wmt0/f9gtyAozaplrxRHLpCB2om1LTqSDtxwqwTH18JmEstyChCVBpYkz31PE62aeBvQwvUcaJP64weeJ8LOnUuE6uD9O3i7uRw0YOnHyG5VcPOXE34Jac0aQgpBDsNdpMmcDKhV7JNYRuSfFtulWKxNK2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847991; c=relaxed/simple;
	bh=4IsYKAyhEqS+4HvEM9CUKairztAiKm4QypqE1T9zV9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HWOKXHDAxjjRx1Z8nNLOjfxR2qd3k0gpOlA6u01rwHKUN8j8YkaXHchAvDZpKqPVwLplQlaA9dClrsaJXyfuvRI0FDxdkpCub6PiWrdUr3PWMuUbw1huWd11XiVf0PCgBR1MwyP7v0LLE6qhNukps4Hp3bMClbLjKDONDAxWKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EEXP5tnE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EEXP5tnE"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6f1IA1742941;
	Mon, 23 Feb 2026 06:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=juue72/q0tUrI3aKxhmxKOWqMyi
	7fB7G6RBTTogpWN8=; b=EEXP5tnEwMLAlT2U74eTiRp0FCNf/UTFj0A0sqEP/6q
	vUtqfwLUzy3Ppi1xQ2fESXxYyH1NfqHuZKhqimQA4IIxMjUMlTU9zSJBgzrFtO04
	vH21DMByhRXd8bPn90fuPY4bTist7vqrXk1jEKqf9y91AX7FD5pE5bqdLN4LCOGg
	iD/izJrPpzv8T7umQ/ae+3XbvyqVReY4cRhk/oFlXoYz4s8YBUqVYoduRWfAZHTJ
	dGstc9YpdbipzK08NnBUJXlXlxo7PE9welmB1mV6p6wNd5gaFHuIpn4Utrq+UpoV
	8rxigkhxsRC3hh4e9Os4C1BcFlBirvnzlLO0pmj9jBw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4jvaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 06:59:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NBxWrx000978
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 06:59:32 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 06:59:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 06:59:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 06:59:32 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NBxHV9017960;
	Mon, 23 Feb 2026 06:59:20 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v2 0/4] iio: adc: ad7768-1: add SPI offload support and fixes
Date: Mon, 23 Feb 2026 08:59:15 -0300
Message-ID: <cover.1771362939.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMiBTYWx0ZWRfX40QVKspA7+bx
 qgAgzP614XNvqfZVvj2JeJp3JNoefIYdRr0U44y679sVj0HsddgujxRsU/g3WOxT2UyitWI3w7b
 wd0wViXRPlSWQCnDCKX7ffVkZp3/Bw0QtZnF5cFSLihZP2UB+VKVXhdU6nyQLizSaitI/PuKLfM
 yTbzg6qwePSadenIdV6JDlJSjmbEgESnyTRKf9zya7mwsUikMROewvrtEMWJU370n86iKOZ6Ghb
 FmlqCMA9k3G24crlLZIU4ied1ea97Ufp/Orx/CQV2dKlOg87dwyYsHMEltPGyGj4YmwnSTlfEBS
 uKF4l/Nz9vrfS0Md/nOQfmNAIvfjyQinEToIX8WAo6nICkAX1O3sXTKEflA5DlItssCj6V2sS1z
 xOVw/h12mkqSk5mlbcrVI7GDS8xPa4fgSPoH7RXBhkW2XLt0BENZOIx2IWiDN/Wpd3MrEP4Kw+v
 tZj/LRQflWB0SEiqNfQ==
X-Proofpoint-ORIG-GUID: KgtnmsvOtdB_HMzKJSqE_Hy7zhTi3cdI
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c4125 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=nfH_GPNPbcGlSbho1cQA:9
X-Proofpoint-GUID: KgtnmsvOtdB_HMzKJSqE_Hy7zhTi3cdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230102

This series adds SPI offload support to the AD7768-1 driver and includes
fixes for one-shot mode operation and IRQ management discovered during
development and testing.

---
Changes in v2:
* Refactor "fix one-shot mode data acquisition" patch and keep it for backporting
  to older kernel versions.
* Instead of restricting the one-shot mode for some filter types, remove
  it completely and guarantee the device is always in continuous 
  conversion mode.
* Add "disable IRQ autoenable" patch to fix an old CPU usage issue and to avoid
  unnecessary interrupts when buffering data in offload mode.
* Addressed other review comments and kernel test robot reports, see individual patches.
* Link to v1: https://lore.kernel.org/linux-iio/cover.1769889074.git.Jonathan.Santos@analog.com/T/#t/

Jonathan Santos (4):
  iio: adc: ad7768-1: fix one-shot mode data acquisition
  iio: adc: ad7768-1: remove switch to one-shot mode
  iio: adc: ad7768-1: disable IRQ autoenable
  iio: adc: ad7768-1: add support for SPI offload

 drivers/iio/adc/Kconfig    |   2 +
 drivers/iio/adc/ad7768-1.c | 220 ++++++++++++++++++++++++++++++++++---
 2 files changed, 206 insertions(+), 16 deletions(-)


base-commit: 0713b26190addfa3a774b386c8658952ef9f7faf
-- 
2.34.1

