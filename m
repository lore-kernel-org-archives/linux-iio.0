Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC997329E55;
	Thu, 13 Aug 2026 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662309; cv=none; b=jEEz2nuvs30CHISX0zp3ujciM+nuIh5WV+lsPiUmj8iskAnoeoE6PMta8G89+gPl7gYLhGYfGRlu6joZxDCDwyvoDg888O/Gw/7/D5I67TQMIAHzI80vSTcZ/neporHn4IOuf0z67IFW9QxWtba9ZkHnETMj6d9EyfWs75HbO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662309; c=relaxed/simple;
	bh=bfaOgyh8wniwvroyd+wKFkStGlI0x7TmqoW1aMrnyRU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFVzwEfmP054NsG4lxTUwTHsBVj4Fr6ItYnfDT+0fQqAPO2dUZLe1uuKXK/vUs+I7EKZXe9twT+cfpKO58MlzSpajgzYEh0UwlTkWXphRlFBjKzUxyPiLBS4BsumRP9+Ua7WFy4EIJdosRp23/x+6tCSUfxrnGxFUSu0Isgv89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NqzAzjk4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NqzAzjk4"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DMlbuJ2667835;
	Thu, 13 Aug 2026 19:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vJi9t1Lo+SW4ngPLa6SgFZWrXnb
	vC3Ddg1Jz9vUPN3o=; b=NqzAzjk4uc66bUL1sc9IaMDvCBZ52SKC/JA/RtnexT0
	XOrzdK4t8peFDXhznRuOU4epWo+G/YEIVYIGSbxvNKGTmSVOJfSHlUScxqzOmUwU
	Hb2ExgnkFLvpY3mtqnnpmLfecGVxYTz4jlnBdzbG19Gr+KUjAXz5K6LdkLNZK9zh
	V4PPQZlSowvISf1tGMUJZDd5HHD0PVYi/WyRXoRN65lH53HdZluAxWaN2d/8wHc0
	DzuC++TkLYdThHDfdzOfwc1pal1b9UotAXszCRxTykX35P2zLU7q6JDrpCdEYzu8
	eQHYi8xzXYQC3PZfNgMomjd1lhtZVPY3CbJahK2/R+g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e1namq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 19:05:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DN51Gd031367
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 19:05:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 19:05:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 19:05:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 19:05:01 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DN4nMi025379;
	Thu, 13 Aug 2026 19:04:51 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v10 0/2] iio: adc: Add support for LTC2378 and similar ADCs
Date: Thu, 13 Aug 2026 20:04:40 -0300
Message-ID: <cover.1786661484.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE2OSBTYWx0ZWRfXy+YgTqoziEot
 tZH4pW4kyc2KGSShmAOHDqu0/8YBmfydexpFcse9CY2Bam3eT5AEvZI4g6x3aqqADzQ6I2x+yBY
 CFijC6neh9cbHJ0uZJgWqRCFQ9Wap5p1ZJuJIDNG00pjGyaKmv2fXY+DAIiIUku9xD8tssX0uoJ
 9xlcJ7Zn0mNjq7v+qpbmYJDxJLYfcyt3XFL1nRh+EgkTBqoueNlOgnnPIm2QEisPlbjThdXG/O4
 ZIIyxEJHZWjJUdX3LEjo3MqD3WCOeWYsMmkBaEnvYGWO0eA5GbBbQIna8NVex4TxH1MvL2e8hFp
 eNjDAxdqE7BifkJCCnjnNVKNgx1o2ZYozCb6rKRcM3XcCZVrat1KpOngqjY6q3+PVS/m/wYeYkh
 iVaGsLA0ScO/KqjLYl4p2Q7Q8wxVWwTipkAvl0qfoNFAQrpMYYUzBM84ppRuoYuv3HMLkPmg5Iu
 k+fdz0FM/CemcNTKUBA==
X-Proofpoint-ORIG-GUID: UrxGL9qlZlMvYA3rVmsDOunjN_CT5xMy
X-Proofpoint-GUID: UrxGL9qlZlMvYA3rVmsDOunjN_CT5xMy
X-Authority-Analysis: v=2.4 cv=fLoJG5ae c=1 sm=1 tr=0 ts=6a7e4d9e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=uZASs6rzk6PZwFqRxqQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE2OSBTYWx0ZWRfXwkwD5PhGW7jK
 C5RKJhjbeVMSN2209PRjGi1dzLikk1bg/HkhDKmIcMTqFv9VNajfuWlVd7HR5oe6D3Nvosbycnt
 Dlii8y2E9pJ2qUZky1kE0jH1dT3zVbIcHDvUckvWGgEIvmg/q1aA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130169

Improvementes to LTC2378 device driver according to v9 review.

Rebased on top of
54355e3b189c ("iio: adc: ltc2378: Enable triggered buffer data capture")
Will require rebasing testing and togreg branches.

Previous submissions:
  v9: https://lore.kernel.org/linux-iio/cover.1785186980.git.marcelo.schmitt@analog.com/
  v8: https://lore.kernel.org/linux-iio/cover.1784835663.git.marcelo.schmitt@analog.com/
  v7: https://lore.kernel.org/linux-iio/cover.1784235595.git.marcelo.schmitt@analog.com/
  v6: https://lore.kernel.org/linux-iio/cover.1783629101.git.marcelo.schmitt@analog.com/
  v5: https://lore.kernel.org/linux-iio/cover.1783028033.git.marcelo.schmitt@analog.com/
  v4: https://lore.kernel.org/linux-iio/cover.1782397418.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1781661028.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1779976379.git.marcelo.schmitt@analog.com/
  v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v9 -> v10:
[DT]
No changes in device tree doc.
[IIO]
- Added {} to make local variable at top of code block scope.
- if-else code neat.
- Mention the possibility of having same index for diff channels (e.g. voltageX-voltageX)
  in ABI doc.

With best regards,
Marcelo


Marcelo Schmitt (2):
  iio: adc: ltc2378: Add support for LTC2338-18
  iio: ABI: Encourage differential voltage ABI usage

 Documentation/ABI/testing/sysfs-bus-iio | 11 ++++---
 drivers/iio/adc/ltc2378.c               | 44 +++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 6 deletions(-)


base-commit: 54355e3b189c7015d4575ae04a3bc7b803975bd1
-- 
2.53.0

