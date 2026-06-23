Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719442DF15C;
	Tue, 23 Jun 2026 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205691; cv=none; b=iK7lQIgB4VM72CerAAQUbiwKqu6G6N7Hun69qBhcHHkiowDYp7UzQLqimwPhrvsmGDT7KCpJFQ4H/Ztnlv6ptq3qhazlLlvjKoqd1gq/dRFPLrR/E6U068cNvAITYhJbEtIdlAMmPRWCrbRN03UhBJxl+iyt4jyihF99NCtlM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205691; c=relaxed/simple;
	bh=kN4ID2xS2iFRuhGBGzQLcijKccXTmdkdsGuQkN1dDmI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDSAbH/HzpS3c54ZkbZu2yhSKRuK1qBWNNafNPYc1R//jDK+b5l1rlRg7sRZh9UfoXpuZFc+TnrkHMv7788R6H80/NC4i8pjJQEgqnHULtc8Rm1o+f0lDsbU2p979X3Crt0vIoPV3ByAWe5Rth+QuTdw/Mw6gh/gSjzODNVxnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZK4jFoqB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZK4jFoqB"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6jbEU2205752;
	Tue, 23 Jun 2026 05:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jx0nZ
	mkF8X1XyoIQMk+tpw+ry4LKq6Y8ojUZ624nAGQ=; b=ZK4jFoqBrpueuf5B76dB8
	5b/9/9DQRZpt6Xc5kc5gGBM1pTx+hpw5rFqyeZr7yJbpBr39H4ta6cZTfOFV35Hl
	TxAeExsCIP3/PZ/qpHRCcBQprampnW8IsXsSQ4H+azOYEZe4fvJhSgBb1PtqSCVZ
	GHAjsinCuyW3Kz6yM4YbaX6BnGEumLYkCMntSHAP/rQtNv4ukWRnFI99kwvv9ejF
	pPw8LCN7etsKssgm/GaT3TaabXGk15BidqNHktX+HRpuMIPZ4XWc8it9qJx0dmwe
	h1oENx09SXbddO7nkouiTvRhwWKMCQ8wIQM6CLUn8qYq7wjbbNGniGhyxEcXcIW/
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4eyhsu9jq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 05:08:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65N9868q030661
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jun 2026 05:08:06 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 23 Jun
 2026 05:08:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 23 Jun 2026 05:08:06 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65N97Yot008608;
	Tue, 23 Jun 2026 05:07:55 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: ad4080: configure backend data size
Date: Tue, 23 Jun 2026 12:07:17 +0300
Message-ID: <20260623090717.3296-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623090717.3296-1-antoniu.miclaus@analog.com>
References: <20260623090717.3296-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfX8kvN3hyv2kMu
 wjtd5/Zv4Wc5EcaIsdfsDLUZojH0BX/Py/suJBaHF2jz2eoBCbhV14CF+4GSrPAP9r7Rp8fBJIb
 cM5ddO9WDdT1tsNPFnKoCpet7VDlppLpp2JeECk/DLaJTOMGavtj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfXxKVhClxiBYmn
 Su6cFD7dzHGxTFS2F8159jSucMEvbg2PUP7hXRv21Nv9ZtQCL8QFLOMBDf1ieq4l6iExslpROPr
 ZAWb2lYE0LoBOUABSHDYPEVpm9HhGply0iim4YGOgoIcf+ADFIHaQOkDEMwxd5U94OWiX78SUzE
 GEh/5cAQLLveE8PDG6a9VNMm7KCn0BJSJ+BfBUiPEMXOVM73/0KlSVfjmEPy5xn++VlIO6OIjkH
 Nv8lPsDucbXOGiYe3VUdoYhKLf/quag9Mgbk3+07z0jDAcDxsR1gU8QOwGLFVHzjiBqxSkOKkuO
 FGKvqe1YH7p93T3PzotkI8UPcmMp6/0kRuYL3Br/5ZiAbLcZXaLGsmnu2aiBhAkWDi2Xrpa8qqh
 YGvWfmA/7Z18pukFF9VEx2lKHyldjP1NsZwLWp2FzTXcc18Jt4HDMUBQI3kCJZejuyG7nLCmbdA
 1CI7RHmJfg09UzaF2Gw==
X-Proofpoint-ORIG-GUID: 82WfojugNh1LDBozYfDpJ4Tx5DgkY15w
X-Authority-Analysis: v=2.4 cv=JPgLdcKb c=1 sm=1 tr=0 ts=6a3a4cf7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=ms0HThmbWh2te8tSNK0A:9
X-Proofpoint-GUID: 82WfojugNh1LDBozYfDpJ4Tx5DgkY15w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230073

The AXI backend needs to know the ADC word width in order to pack the
sample data correctly on the bus. During channel setup, program the
backend packet format via iio_backend_data_size_set() using the channel
resolution, so the data is transferred according to the device's
realbits.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 8d2953341b15..8feb0c7f7fcb 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -698,6 +698,11 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 	if (ret)
 		return ret;
 
+	ret = iio_backend_data_size_set(st->back[ch],
+					st->info->channels[0].scan_type.realbits);
+	if (ret)
+		return ret;
+
 	if (!st->lvds_cnv_en)
 		return 0;
 
-- 
2.43.0

