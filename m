Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D035B129;
	Thu, 12 Feb 2026 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900403; cv=none; b=eHSuKS9c9niOsGyfJ7TZi8vQ8RtxhIZkmTfoJbTMGvrBhJ9DW4wAsjE4HgFuuFxUsqos60gvJBVNYKP3zqZPZxfaR/Kfx2/jmcouBel9n9s1dYBId30koVqt6oabOl6jUiYwA592pIdWee8syAgasKe7eR9qrCCLys6Y2PfcTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900403; c=relaxed/simple;
	bh=FB3jZhc7Jccn5GA6ccCpbC62fQNVGAFXqJ9v9Y+LI8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h1DivzFFzaUN61tyBeP0T+kvNatm2Yh/LpIFdeBXNnpY1RQRbt+bv5jcApv9M2in2cfWxeotD8g1VPMziYTAC2qFFfW46HgjA5j+poPk5/dmYqeZlS3RvRvZCO4CkB/zptU+Y0z+TDXVCjbxQlMb9gxAFmvMeNqWL1GB/xv1tMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=odDxL54o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="odDxL54o"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C6Gf6S861630;
	Thu, 12 Feb 2026 07:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=6CUg3/6aFF+aVr/cMM8kjDoGkVw
	wyL548/FO8FzlJhI=; b=odDxL54ozC/G70+692uLB31isUa9fCLcFACzKwaVIfE
	0C0QHpMzGKGKOo2KUWdy/gGS0gKjWl1iOe4NClfGC5ORLEK8l7afJJSorpWMmL8X
	Bju+zlx5H9BbN2Xy3+8QQUIdfWWAusOqPBzn6Hk2OWdHPNp0VnCgK3m19WK9+YEv
	a3kDd1smCZo/lcct9jq/MB3iL5/8oK7GqgxXQmNkXm5UyH0RAOAmvuEYAujtu3dd
	YkwTcwlyK7jUaS7HCzvO/ZtcHujM5JKZ6LZhs0xfYUQ4xapbYx5psGp9GW+yb/o9
	hLxRUTntfAG/sbyjV3d4dDGYBwQw6sO0bkL2YZI1vvQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c8hn2xeh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 07:46:34 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61CCkX0P014028
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Feb 2026 07:46:33 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Feb 2026 07:46:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Feb 2026 07:46:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 12 Feb 2026 07:46:32 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61CCkKmS028003;
	Thu, 12 Feb 2026 07:46:23 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2] iio: chemical: sps30: fix buffer size calculations
Date: Thu, 12 Feb 2026 14:46:06 +0200
Message-ID: <20260212124609.24745-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: K43o_db0Z9txm_r22kZuF5C6ysGuruct
X-Authority-Analysis: v=2.4 cv=AdC83nXG c=1 sm=1 tr=0 ts=698dcbaa cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=SCAjDdKVs5Sq2ybQBYgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5NiBTYWx0ZWRfXzptj/9zhdA98
 B68YaQ/GqYzFneob4t4U8WAOGI8WnmLaxS7K0h14TVWBLHYrRIxNnJtrY0nevXtodxwZvMyFXJs
 3VbtCErLDBLkwRWMWn7b8jDibn4rYXFx8p/CD+YCBRIlEu7HvikAALG85033zDJBSD1GxjR1vTU
 ib5X2mY94ULdiwDM4qLgU/aMbP2nbTEQPsbDkSUILJoufzE5N9NxKi1JpCD/J748+hD6m3WI004
 aJATBZ9IXqfiXYg7FVRxKqKhoZCNSqLJhTXnt/t3Ijhhl3VI3WesHAH7+m+5kdJSrL8socsxGqg
 7RLu73AXWQ0GOik4Fju4tKLgBWpFjE8r4qtaIPPjGZIi7A+4TSvkR9Gg4f80Z7nw3OHnKXvhFtY
 Ric7FYZqIr1hByhSrXFenaugX6gverORzbcRIKqd6bI2HpuOF0/qITtlrXb3TjLvV7N4kH3Ec9q
 7jWngdMCX9tzE2oKHow==
X-Proofpoint-GUID: K43o_db0Z9txm_r22kZuF5C6ysGuruct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120096

Fix incorrect buffer size calculations in sps30_i2c_read_meas() and
sps30_serial_read_meas(). Both functions used sizeof(num) which
evaluates to sizeof(size_t) (8 bytes on 64-bit) instead of
sizeof(*meas) (4 bytes for __be32), leading to oversized buffer
requests.

Antoniu Miclaus (2):
  iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
  iio: chemical: sps30_serial: fix buffer size in
    sps30_serial_read_meas()

 drivers/iio/chemical/sps30_i2c.c    | 2 +-
 drivers/iio/chemical/sps30_serial.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

