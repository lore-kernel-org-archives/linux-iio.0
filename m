Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2383FD129;
	Tue, 29 Sep 2026 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721758; cv=none; b=AAKTSTrVGMc5drYpV350PaiV3OTwTe181jSOte8vZEVlxb/z+IX2aOmd32MR9ERVIX36ybXWV+m0E+JREGI2zKPgHncoAqyfdA+aWhH+nvPY0LfFZCwPSxzTD8ySGKXK68/Dh8yWVhvcJHcJFhsi4FE9xHvb4zyeOAvblbFzD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721758; c=relaxed/simple;
	bh=yosHs16lhdzzDy11919rX3gX1kk8wpUnvT6moWieb6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhQsCIBwh2tIQrmoVLZwRsgYkFfIcVURXFj8Wrs08DcolBZ15V8wLuU9gmk0Pl7UM7VPl2reyhZHu9ciftzczdQz/h+5Girydof87C64us4ixLItqQViBWEk+6cvGfF62yQXs5xlLeBaYuKlipzkU3CV8ne25jTXUtKNrH6DD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SMi+6Q+D; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SMi+6Q+D"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TMDtSe3743913;
	Tue, 29 Sep 2026 18:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1o16d
	0rz69d+vmM+1hpQptGGDeMloMsQHEEoBCc14hg=; b=SMi+6Q+DYvHl1DG1psL2C
	zYb115ammQFCbdJKaqYCRmQT1K/lHmIFX7eylavFQ2QJIyGue6YgsDasaMji4+Ka
	S9dkjq+MzSHfsx+/eBcie61sgmVG87ubRBF+na5ga9DPau53LrpHYr6rUyvXDsLQ
	jX/1+VTpRtnk2h3iV2ciMAMDWVQsoBbMNz19srD4Ywl+XN+pK9QE9bEcKed3V+Wu
	7xp/P6oOp15nhYgul7Ew76RPywmnSkiNgTezR4UtEfjiVmBHUUMPtI/uM5DLZ+Lf
	b95Y457JxUQ75rsMf8Fd5WYg5xVCWqsqtNpaVlzQVkOolvCpoIh8W7o/NmVWn/sF
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h0jhs93y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:42:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMgUXo041388
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:42:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 18:42:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:42:30 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMgHsk008166;
	Tue, 29 Sep 2026 18:42:19 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 01/13] iio: adc: ad4134: Adjust register map range
Date: Tue, 29 Sep 2026 19:42:11 -0300
Message-ID: <967ae30e3ce96485c565a4124c9a1d41ef84d0ba.1790719424.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ZbeIpcVA c=1 sm=1 tr=0 ts=6abc3ed7 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=xatGmy-HaK2A-VLG5J8A:9
X-Proofpoint-GUID: EKcE7_RuMFw1GtTGbnbDQLu-FTU4HONn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX2ilf6OTrSFXe
 /zMckLG9kqfaw3eTmRi3Q5GSdlmE7o/uDLdOWDdvfpLsDxemIV1tLg96wwcb8oe3naNqnwpUSLo
 gTjkld3TlQNM/cY1t7/KDBXWz6idjeoFSK68FstsOgz2VoGlJz1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX17z5Vz9SbTi3
 9XFU85yJ/rE96WRrWvLdqbENFvkzQxhdFXsBjgfA/qvd7qmJUiIX7QQTiO4qmfYDUQEzHhWVfZm
 9qLLi1ANIxb6cOClzJ5uTHm1BJ+cJbqA3QaeYKxwP16cNSWarPYONmT5DymHKwizksBbwaois42
 3HdEvjHnNEwQxCRTn3gDpjxR28QBiPghzrYXTgIAYAQCcTTDMTc6aiM4XF4iKrdvgGdM9y8n7Eb
 5YP8Z94JbNKtZACOtrc+NLgjzSFqt90n7z9X0sJ5ukPDiVmXjl+PzjHkm3itFP1YTrAilabG49X
 0Pbd43Ep0obOZ1wMInzoXksCuMTLbeeYiO2bhVYrUt2Qz6Ga3uP7AFlBaAAdQkmO6zrRYRx+uxp
 0cNlD94FBSDziu9lr0sQSlAmYveb1rJ1rsnD6SDmz51UMnrkt7/IyIQKKQ8gzeuzaxpdV4dhoxk
 3nwusdLBHnaJWoUBB4A==
X-Proofpoint-ORIG-GUID: EKcE7_RuMFw1GtTGbnbDQLu-FTU4HONn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290090

Due to a off-by-one mistake, privileged users would be able to read from an
unsupported register address when reading device registers through a debug
interface. Correct the off-by-one mistake at the high register map range to
prevent access of unsupported addresses.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch in v3.

 drivers/iio/adc/ad4134.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 70f80bf1825f..e53c10b9a44a 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -111,7 +111,7 @@ static const struct regmap_range ad4134_regmap_rd_range[] = {
 	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
 	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
 	regmap_reg_range(AD4134_DEVICE_STATUS_REG, AD4134_AIN_OR_ERROR_REG),
-	regmap_reg_range(AD4134_CH_VREG(0), AD4134_CH_VREG(AD4134_NUM_CHANNELS)),
+	regmap_reg_range(AD4134_CH_VREG(0), AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1)),
 };
 
 static const struct regmap_range ad4134_regmap_wr_range[] = {
@@ -244,7 +244,7 @@ static const struct regmap_config ad4134_regmap_config = {
 	.reg_write = ad4134_reg_write,
 	.rd_table = &ad4134_regmap_rd_table,
 	.wr_table = &ad4134_regmap_wr_table,
-	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
+	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set) - 1),
 };
 
 static int ad4134_read_raw(struct iio_dev *indio_dev,
-- 
2.53.0

