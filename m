Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547940;
	b=UWJ15NoT9OpxXHownYoRD1HPEwwVw54n+1V/AICQX0xsPkkHy5aMbFlP5cDQgAbXnN4F
	 Bdrh72crNW1tP7G5pOBPdf++aYdCJL4khOKOuohEPFmy9I5f+nO7DEz7KyFjcnrCB3X/g
	 ufHEv9ceKtAvpDogNVGfZntjKT9kL7cGKoI64RdzEzeY+Y/Qg6c5QdGLb8ZsF/MQ7+xro
	 PpPYpwjEHucO5N+2s5rEfAVsG9Dfl3u7mWJ6VIfRGb0vw4xegD7ggDxTLi22NXRBOhD5Z
	 9oU6TDmLLYO+mXD7aE4SRrLC+nf5w6OC3WMFljVkH22WarqeXVpkqNu3DdC9O33D2OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547940;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OGird1GsdRfjX6m1YvIMaaDnGmyXQ11VKm7h0BG9A0o=;
	b=bESVVlUEzEnDijiHAGICIjmuBDwSwnDiCT6iYKm+9F5ePvHr5RxvdxPo+LVfyGyGQt7R
	 yN9JVViBdGfjquHZ01wmuNRc1BtqhadI1reSW5oNJPsAwXB9nehqQUlqLPiuH7an0DQH/
	 1SqSXRmhm57TIRFDE+u+KeeBOI/kCIUYTTZjjDcjp7p6TV0xSkNQpRsO2mz1sPLH49le+
	 7hYVhLtV5uLA5HiZjYVGUg6CLH6Ec+rpGpNwCYAzNtirlznzQPIHLN63gEDS9/TVTx566
	 iBCw6jYLaa92J11pZbKwt/opHcOHS6pNSrLj42vnUm/cBfkejM+i5+igkQhtigO4HpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="Vi+s/xkw";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Lk33fIUZ;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC728606A31A;
	Wed, 21 Oct 2026 01:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC728606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Vi+s/xkw;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Lk33fIUZ
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L10fIP2442269;
	Tue, 20 Oct 2026 21:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=OGird1GsdRfjX6m1YvIMaaDnGmyXQ11VKm7h0BG9A0o=; b=Vi+s/xk
	wjLwoVF5FwZF+XYJfSvQ8H+N+dbB+kUsX8LlSFKr/DIlttgk81dNF/2Xt5d7k4nj
	LN2CayxNOE/TfKyBiAgnuKxWYZE2Ki4oO2ZG/4LtsckSEZ3t1A2f17u3zcKsaRFT
	9VIrox3Ki2JWZG3LnInWICptY8pNCbgSTuLxefNem2m1vezyxkb3qDDFtA0L0P+K
	ja54YyN0rufPCALZ4cg2ZTlgfuFTEzPfI4sPRXZOmIZzOOlugU3zl/kj70Vx3coN
	N5UhC2mleJAFsJ8sn3AdNu+KsFvyteStgrrkPIF3CUBXhB65qgXuCvYKnuV0TRVd
	Dk5BkQEynKjuIqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OGird
	1GsdRfjX6m1YvIMaaDnGmyXQ11VKm7h0BG9A0o=; b=Lk33fIUZsOklSwKN+yu4x
	6bRzcSWKWG0GkdoZRrq2kBiXEPwPoosiu2YjKQLHRiWv1sEGpI+QhOTf6UHSI0NK
	87jH96gzm7F1tyeKs+WrXe85TjYD7989WrNqZLmhck90nb1N22rJOMNvn2Cyurut
	rtIkcieRh6wPCeYNhkMAQm7heo4z8nw4lCUgu2PVjQW+sJX8lvx9ll70//nKF00F
	u1/zlWzaG/irHfsc9MhPVeVpGqsFmlRwMB724SyaJcr3rEBXb9lbRpRwjhwiP8tm
	ONRhbMDIsGTGxivPQrd9sg6bvZG8dkpkWNtDgbM8x8Cu/aLs5w1mFKPbQx+aEv4j
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hef2khjpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:58:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69L1wtJg007078
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:58:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:58:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:58:55 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1wgnW029097;
	Tue, 20 Oct 2026 21:58:45 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 8/9] spi: spi-engine-ex: Add support for multi-CS devices
Date: Tue, 20 Oct 2026 22:58:37 -0300
Message-ID: <183539c950c013d472c6b46e3f1365b022e7c716.1792435248.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX9dSTzNeUApSw
 leKhk0dSDmc9cL5uE69pHmC2cHuEy/d7fqAXNcTJFOo9zaKQZQvhfx5mT7IvvvdRc68nfR8rKLM
 3GFNm1qLGW5GhmiviXA+7W1T47aXL5j31gAgz72r1z1hiqF58rYRCQwyo8OppsOBSrQQEh2ntb+
 JvaQRjOxpK5CrhD/hEwoxQzcYPEEzQl5TpLXa1C63fOgLMcbHCK3AcSb5zBvWfc3AQj5Khxb23p
 PEyUP3K682PXguPK1zvDylydgpDV0cFMsJi7D6sZ5P2zmlnLwKbWyom6EfpmXzUFvNIGgh94Bhj
 sIUd2z10P3OJ8O1TTxiIvgStnZDICm3aUi0WbN1PY3xrUA8okzhbf1XzOuOTcwMoMzcDzh8F5x6
 xW5i+tgEpFXAOudcui0Ny1woY+8/ULLThjc+nvjsPUm7y1v9zp4Osz80JkMQUcMfGGr0l1Fdqyo
 JAFnVuJqb7IwoRRg1nQ==
X-Proofpoint-GUID: Ep6RaPjssw8IUUTlDn9YBsQZK7wCRvub
X-Authority-Analysis: v=2.4 cv=KIHPn1Fo c=1 sm=1 tr=0 ts=6ad81c60 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=m8HNSDYCDbX-GGj12HkA:9
X-Proofpoint-ORIG-GUID: Ep6RaPjssw8IUUTlDn9YBsQZK7wCRvub
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX42uxN+Wb5wKp
 olxTDh23/Oyisz7Iu/Rxz8o++RS44ReYfhHF/CzyRZxdpY1/UQdXABvXjRACm6Kt92egmzmUWYw
 7s55QSbv8Qgm7cll82H7X6f3UiOhms+N4+Y7qJGtAZcQNYY/hJGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210007

The SPI Engine controller only handled the first chip select when
asserting CS lines and configuring CS polarity inversion, ignoring
additional CS indices present in cs_index_mask.

Update spi_engine_gen_cs() to iterate over all set bits in
cs_index_mask and toggle each corresponding CS line in the assert mask.
Update spi_engine_setup() likewise so that SPI_CS_HIGH polarity is
applied to every active CS index rather than only index 0.

Set SPI_CONTROLLER_MULTI_CS in the controller flags to reflect the
capability to the SPI core.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* Added the spi_engine_get_chipselect_bits() helper to reduce duplicated
  code.

Changes in v3:
* None.

Changes in v2:
* Adaptation of the patch
  "spi: spi-engine-ex: Add support for multi-CS devices" from v1,
  discarding the per transfer CS mask and keeping the Multi-CS support
  only.
---
 drivers/spi/spi-axi-spi-engine.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 02bbc5d0cfc5..e4c40059e583 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -278,13 +278,25 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
 	}
 }
 
+static unsigned long spi_engine_get_chipselect_bits(struct spi_device *spi,
+						    unsigned long index_mask)
+{
+	unsigned long bits = 0;
+	unsigned int idx;
+
+	for_each_set_bit(idx, &index_mask, SPI_DEVICE_CS_CNT_MAX)
+		bits |= BIT(spi_get_chipselect(spi, idx));
+
+	return bits;
+}
+
 static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 		struct spi_device *spi, bool assert)
 {
 	unsigned int mask = 0xff;
 
 	if (assert)
-		mask ^= BIT(spi_get_chipselect(spi, 0));
+		mask ^= spi_engine_get_chipselect_bits(spi, spi->cs_index_mask);
 
 	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(0, mask));
 }
@@ -886,12 +898,14 @@ static int spi_engine_setup(struct spi_device *device)
 {
 	struct spi_controller *host = device->controller;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	unsigned long cs_bits;
 	unsigned int reg;
 
+	cs_bits = spi_engine_get_chipselect_bits(device, device->cs_index_mask);
 	if (device->mode & SPI_CS_HIGH)
-		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
+		spi_engine->cs_inv |= cs_bits;
 	else
-		spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, 0));
+		spi_engine->cs_inv &= ~cs_bits;
 
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
@@ -1222,6 +1236,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->get_offload = spi_engine_get_offload;
 	host->put_offload = spi_engine_put_offload;
+	host->flags |= SPI_CONTROLLER_MULTI_CS;
 	host->num_chipselect = 8;
 
 	if (adi_axi_pcore_ver_gteq(version, 1, 2)) {
-- 
2.34.1

