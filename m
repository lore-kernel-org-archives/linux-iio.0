Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DC2EDD53;
	Tue,  6 Oct 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310596; cv=none; b=keNBSU7ETi3mUoY0Sjk2svp6KdYGcFcA1RVIIFx28++QNEn3KVzMPYzISrzt4aCjxFW6vCuQ/mMWsuyKUAiDBy5TdrTCpSIofXSKv4IUV162MZJ5ThZczeTPg5koMQilAlrd1vXRko19RdmcqjUr1cuZdYgX4gov1mCoZQN/XzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310596; c=relaxed/simple;
	bh=AVxH2/N0/PRvuYPYDqdeJiSoMSc4NNoGb+ptrEjtu24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZfsAbr1Q3m8L/QPvP9p2SNNgxV+McGrfz2M0OlViKAnfcj9/GL+H/mHLOFJdhsgs5QOKnIEnMhz+81M6xetcFtrKnBwi1ofXPeaHXdOUi7lfJg2WGaIoClMogxza+HkLq6YXLcAsrDfzwPTUiZjmJ/vt3ApBOtcFgyQlhomJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=MCTORzgH; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O6oqilTa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="MCTORzgH";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O6oqilTa"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HgaIG1610022;
	Tue, 6 Oct 2026 14:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ZA8dUIu0Mv0gyFMZ4bDh67pqwF7MgUsbSQj82RmLL1c=; b=MCTORzg
	H3TLkkdA/XnuncrvoaCV7Bvcp7rFCcM8QMyQlqDe2WR4XVI0QKsz/nHw/FalBze+
	uPUOnaH0CUYLCcF5//NgQMEScAx4X1RWvSrzckyoFuwhapT9HT3j+01i+OtUrfy7
	/oR1sd0ryplwFK0nT1695SB8PTCfYHLOiOyr3FbAKmSe9BrQ9kLoYK6jDFYvdvpZ
	JMUkhnDMrm2XND6datOnkFhrHZM+QFCfxgRJoX6L/odgLa53kimYLWlk1CTnDVQ9
	bzcznNX8URraR2Z/lZohorD/o5BCvOItBMXOAFOkig2nGgqCrc3AVb8t91IsMhfd
	etxIE5S05Wq9kzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZA8dU
	Iu0Mv0gyFMZ4bDh67pqwF7MgUsbSQj82RmLL1c=; b=O6oqilTavO5yBlshXsAeO
	RDloWK63U6HtEmHm0+MHDG4DJHNC7e181g9GYPkZ5Rp6ujZkEFDZU/oO+F65Zy/U
	alRXzuc4PIFwHI72REFTBrlGRrQhL+c6jk3e9TbTtLGKWDHWUPt1+ihqHMy//oYz
	m3Qfn21tMZIH/kRNtc7k/IMVqsSUsi8DjHMfOTC/Fgd6f8PFQLZJzAoSNXnljqfC
	I0Q7rNYKnUE7xlwAdDUugkP4nL0Qm5bxmqHOzPQ0Z9xQfHp7SIlaT4YavRqmdMaU
	s9D4t84CxQgf14N31LSqLgNw9eVD/IjW0yfC1gQZGy/gG861bBeaYo/n1+OTXqLy
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h4ub43s8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:16:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 696IGPB8009966
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:16:25 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 6 Oct 2026 14:16:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 6 Oct 2026 14:16:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:16:25 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IGBXp000976;
	Tue, 6 Oct 2026 14:16:13 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 01/13] iio: adc: ad4134: Adjust register map range
Date: Tue, 6 Oct 2026 15:16:06 -0300
Message-ID: <5c03ec5e764a5fed7bbeb6ed625d5b044b76ad2b.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 3VjmcHPcuhMOUD0hz6AuUOkMJyEQJlHs
X-Proofpoint-GUID: 3VjmcHPcuhMOUD0hz6AuUOkMJyEQJlHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX3rFsFQs1VKQS
 WfEKklfuvzDOpyXoOojEIWMoIz3oIrKw6XASm/pNqRvGqZVT7JWvpOl/LwCoUEkNZzzbIgirtg4
 9Td+cE2aYbG6MhfwxK9QleruvwUloifcW4X7UxlExWdR69GnT3/wUnR6Jr2+B1QpOjKYsLYFupX
 PqkEIUs6fLCsXVLfrb/pQPmWm0nQQtIYUwvCGBdOPzg7hr+zfnxcZiMj/jZwWdZoks2o/vGc7bX
 lpgEqLWo0i3CM1t/wQxIf2bAAOR4OTwk7VftrhHb+y7NM4mwzD0ClEVNLISv4tNqMTpGNwijCpp
 SEZ0hVntJP7S+pYi1PEW5nquzkNtjP7vs/58RxqFNSkUDfZAF+lweHZVJV9tXDGJAwJx2WCCq2l
 UV96fZgsGQCPMrnnU1LhHEyJml2xsTVZ0HVbEZyfea+RpwHuWap/8hLUdwmust9EOZh3y0yO1DF
 x5dlGK/uCemQVdwYAkA==
X-Authority-Analysis: v=2.4 cv=O46sLx9W c=1 sm=1 tr=0 ts=6ac53afa cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=xatGmy-HaK2A-VLG5J8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX33pH/AgteGJZ
 +IUOOgj1zEMtfcpEwcmXGYfdGLyyZEDLJgThp+NwLh/7zpjLTtKWS7svCNSN1VpYHCgm4MDbnVS
 xTTx9W5MHcqCKfVfVK+ZBO64SKRtgDBzA0OTcmJfzVw0nm7l8AWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060072

Due to a off-by-one mistake, privileged users would be able to read from an
unsupported register address when reading device registers through a debug
interface. Correct the off-by-one mistake at the high register map range to
prevent access of unsupported addresses.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v4.

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

