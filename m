Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547893;
	b=WwN9wuaRIPxUc8jceYmvnKdTXoy8UZC85AYUloXhZEscURBaufML9BN4RKOAid0uLzhf
	 v34edAslSLGr8TpQUGLYSol9o3ctMrooCQtGTxeAlW8eNUEsvfVoGHLgt2AuQ3/vG25S7
	 47NuDNSh/BWgi52FmZy7cPNh7ycKT/K8+zKpY2/lAhdpCyZMDeptule4HH9cnhCbVkFOc
	 3nro3/OAwnjWZD6LaSfwYGNP5Jb1pegJRxZ3dm3LDEwUx7HlNKw6clyL0eYZXou/ONkYR
	 9k270IXTC/lLVwl306cvZLhBMAmYDQDkN13Q8cV4TDf09L2iwjufcu7dmbcw/Ih4b8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547893;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3/OBwG1f5SHuii3cDG6nNE1aRK+4TLtJslwdVNgWbRU=;
	b=O31sooIURtmPRqg8j0xx/O/cHMJQ0qMGDSqHIrcK0++rAmZyKxxICHZwlLaSFmwJLLiZ
	 pOeEXgRrtkIhneFCFCJBFSOqzVLN405ou5IVXaG56IYgI8xz6gmSuGjlxbVP9B6fGM+FC
	 FzU9LMv1HA0vBpv/6mEGy+QlmaXq+6VQ+3+MlexuBKVJ2S5j3dIylXcJruyFvH0RFRx6x
	 Qinu1N7qthQ2ZEkK9Ec36o2JUUqXU6WhqEhLvF3/CXBOjU1lRZQJ7nlbGYCLe+C94OVgK
	 MJao2tcXq66ImnIY7rVh7dNpv9kPjPGyFG+pjOEhghUFDCz6tv2vDDYf8hdo969m07g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dYR5LPuM;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UQInvKWJ;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C5606A319;
	Wed, 21 Oct 2026 01:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 084C5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dYR5LPuM;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UQInvKWJ
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L1jFxn1183424;
	Tue, 20 Oct 2026 21:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=3/OBwG1f5SHuii3cDG6nNE1aRK+4TLtJslwdVNgWbRU=; b=dYR5LPu
	MoRi+pTb72GqoMmAPTbGDy9d4jwwb2ach0jVfA/+16q5gVkOYAMCsPpwE//H+F2v
	0m2tlKW+nzRL0+nrj7ch+K4oYVOFa3U4foXSvdHdxaock8Sz3+2J6ZPY8SFX010n
	qNJDkcby4hGB7nsK50hZckE31JXcOZomn24l6lzN9K5LL0RDdwBipt6rlZVLOsyN
	TdRQov1EY7VwtYugal3E1y8aUfbYCsaX/4AZyqgTPsrbLOoeT5If6ZbRUJx3ec0W
	k5OcLsaOvjBuvm9XAo6ZINSwsQsRGi4YRIAkZ0KJWKxn0bwZKAVEN/4YUiRZfW1d
	ghk+HBhR22M/xDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3/OBw
	G1f5SHuii3cDG6nNE1aRK+4TLtJslwdVNgWbRU=; b=UQInvKWJDn4cW1tCv3mWq
	ELTaDl8vAUHM5By6euNvu34wQM0GAJMXC3ME4p8jJ96nudlT6+ZDtHqPI+263o5y
	oBKRWx1GiJjqrREMlbO8fgo9VYOG3hSefwX9ec45vXf9on42DKUvxicO9esmRymD
	CkKovgmnUP1Xhtabmz+NoIYENHsB3UTTb5pQO7SR4U9k+VHoxE8mpk4st9/+ttZj
	kqZaZhyhv7OY7Jl92HBPoawvbKBYQEDhvQy7WZWFlrBBn0oNPAoKKJ8xOK9vrP8u
	x/O/Ti39ggLGIiDQaoI9Ls+eEjuAosI7IiQC9biu9n+MJFIXR8Bg5MiZp/9ep9eF
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hem0t828m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:58:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69L1w3bP006981
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:58:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:58:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:58:02 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1voNl029080;
	Tue, 20 Oct 2026 21:57:53 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 5/9] spi: expand device name to include enabled CS lines for multi-CS devices
Date: Tue, 20 Oct 2026 22:57:44 -0300
Message-ID: <0bd7dfae5aa64066b8a3555cdcbd1b84de688f33.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX70s+LJ30KApB
 AoP4zY8SE7mnN7fbsLucpIDECXNe4q54E0bknGNluqXn291IGKam01TFtuqnM/PC/5mtzlysYjc
 7BXIlD9xVPtpcnTvA/Bv292Dt0ehK9cPupeu5UQT872LsQbvz81f
X-Proofpoint-GUID: NLshJ3EFW3vjZIJmhD-OCOUAxcoiDhq4
X-Proofpoint-ORIG-GUID: NLshJ3EFW3vjZIJmhD-OCOUAxcoiDhq4
X-Authority-Analysis: v=2.4 cv=HOdWhYtv c=1 sm=1 tr=0 ts=6ad81c2c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=iwQ4IeKVmTjpCgGwJXQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfXyUTV89szsfCR
 cEdXrlKX48W/c4oZveCO/0KMZKn18ZJCwklx5DJrE8kQo4uAQRmiA7r1StWwRO3FblxAOi9ACYc
 /z7AOxcL/U7AgpEhMKlT3XkcW/xUpE1eIRjpOR92LPiSyBw+1WktYEByLjH/IPxqNH9M39DZlGh
 Om8IOJzbgY92kPQABlFYhWTEixiTOa9hlDzEK/DHfdPdeFwvZ5pUuHJCzaZ49K6B5aohq7qo+G+
 ltoGhqNH/fEEZKKRjBASp7g75p8Wxky85/xHU5naVUDr13ThBArB5kfa32RT7HezoE0DMLhChEV
 /LK9l/IaqAsmx2VHl6uopxPcJco989yRl9PnEYvfK38YLwy2o85MkVPR5Zwt6GFP9nb7JZjmd+l
 Qi8X6NMsR0pcCArmPNgcQ6GS8q2PZ3peqVUKtwRHCKXTgfkiXHfxfRO6SbE+2w9FjhU8VTvIVO8
 mkAmvdf1hsCU5fhSBNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210007

The device name for SPI devices was formatted as <controller>.<cs0>,
always using only the first chip-select index, ignoring the remaining CS
lines.

Change the naming format to <controller>.<cs0>-<csN> for multi-cs
devices so that the range of active chip-selects is reflected in the
device name. Since we are not expecting sparse values for logical CS
values, adopt the range format.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* Opted for the range format, since we decide to limit logical CS values
  to a contiguous sequence.

Changes in v3:
* replaced `int idx = 1` by `unsigned int idx = 1` in the for loop.

Changes in v2:
* New patch.
---
 drivers/spi/spi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2b2eeaa4c15d..53d6ab4ce8a3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -782,6 +782,7 @@ static void spi_dev_set_name(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	u8 num_enabled_cs = hweight32(spi->cs_index_mask);
 
 	if (is_acpi_device_node(fwnode)) {
 		dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_node(fwnode)));
@@ -793,6 +794,19 @@ static void spi_dev_set_name(struct spi_device *spi)
 		return;
 	}
 
+	/*
+	 * In multi-CS arrangements, use num_enabled_cs (derived from
+	 * cs_index_mask) to determine which CS lines the device is actively
+	 * using. num_chipselect only reflects how many CS lines are assigned
+	 * to the device, not how many are actually enabled.
+	 */
+	if (num_enabled_cs > 1) {
+		dev_set_name(&spi->dev, "%s.%u-%u", dev_name(&spi->controller->dev),
+			     spi_get_chipselect(spi, 0),
+			     spi_get_chipselect(spi, num_enabled_cs - 1));
+		return;
+	}
+
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
 		     spi_get_chipselect(spi, 0));
 }
-- 
2.34.1

