Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21E36680B;
	Mon, 23 Feb 2026 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852493; cv=none; b=R/NXhR4M5n/NDqKWRI+5jg1c0oaNwb2LEeXiOxWaeQ6cnNSjHK2c6PMYs7KLJ/M+5IZTxyBzMoOoYqY0O5qwWhB8eRGI2Sa4uzzOPQgOHXGmuVVGnZFblwaXRMXpU2Y3aTZRUMSankoaNJKfxCq/+kkD/MzYyfX+Gg5H13ZxZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852493; c=relaxed/simple;
	bh=3Nwrdi9xGML1C0bCqTLhF8uBNFWnLudDdj5ld1cOCdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evOJg4WRsJ/AkSE/h7NcuqdtDgUmzIf+LhvRvXEnnSVcbNB3Ca4AzXaYn+5xs/gUPLxetDYzr1C/sKN42AOFNDMj2yuWBthWDO/oKxUe64rAeEryX+4C3ieWq6+tLc7puseb6AQyUVZnwdm5ROISzs5bPonwKbP7j4MKiJYg/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZiOR6Mw4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZiOR6Mw4"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCsWw43320378;
	Mon, 23 Feb 2026 08:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4ve0z
	tLchl87o4rE+r0nzeJff2ZRaJxe7r8Zg5ZS8H0=; b=ZiOR6Mw4OJsTke3hCUjXd
	pJebbPaF2CwLcprOS4w7NjQkMZ6dngRDRM2lqbMG5UifaOHKHqcRTVV8CSaXZHhN
	LFgtd3AKDZ849BVaw+gZ6KggsFs1HyT4XD9reHXmVo7c5CFizVM3dV1zHxBI1t09
	ha3DCASH8cYRGN2hILKKjCjE09ATExJiH0VLtuqaeA9hRMZKJVuRH+DY5YWcXBWR
	CWiOqh9NOtYo+XbuGuu3GOsjVdDg1P5O/r+0bJ4gaPT2di7gXySSYgw87NneBRO5
	279Da00e3rmuhAQwoXXiEckSNv8HDMIZlgzwmhwTGsaAUQCu59VbSDdQ0yj3w6WB
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cf7e1y92s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEbJv009727
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 08:14:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:37 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXY006594;
	Mon, 23 Feb 2026 08:14:33 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/12] iio: frequency: adrf6780: use dev_err_probe in probe path
Date: Mon, 23 Feb 2026 15:13:53 +0200
Message-ID: <20260223131418.55414-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223131418.55414-1-antoniu.miclaus@analog.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=WsUm8Nfv c=1 sm=1 tr=0 ts=699c52be cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=3LiYLoh_h3RjBjQ2HpkA:9
X-Proofpoint-GUID: kL9MTNfiBhKaRj8qpji6hI17cZjDv-Wo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX0X2+zlrpuGJF
 hpofdcHlL7Ce3pXiPK+1quIppVn4hnhyC7XlddcZNEaD4ebNFDWJgLbhgmLbpPR0eHAUH5a2u3q
 N2kmj97+CAUZY63t5KyzherQxuoNQVsioXu0bBfun6GYMs5cA3hInkntCbNtdmedL1jNhdlxkS3
 FStaYpafv6nUUwLPk6EumUBEYLsZJbK+YaBz/p4XLYgOViJGAyEXkcvGj26Sk5A54fdeam4tsdo
 VclAbqzwbJyod1xvz5ewrtIuEEcT2NZwfVmr1W4HXN8k8GBgDllSKnoieNO2S2PJGZbS2qcYTvL
 wBDzW4G9pl4prnR1igdzogJXr7D9WFvRzOF1UZ+AT4lKPba5BSmz6PDgLDLvP9WTJr3usyAlAKm
 UQoJ0B7pFbAWJm24514dVlTw9Ti8TYYXiNah3uXSSG2FtdwemjiHmeqlEK+Fj5jktEV535ZzTuA
 2jANsNgLnhxXBY5VLrQ==
X-Proofpoint-ORIG-GUID: kL9MTNfiBhKaRj8qpji6hI17cZjDv-Wo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Replace dev_err() + return with dev_err_probe() in the probe path
to simplify error handling and to ensure the error code is logged.

Drop 'SPI' from error messages since the bus type is evident.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 918a7a511d09..be8838ab10fb 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -351,18 +351,16 @@ static int adrf6780_reset(struct adrf6780_state *st)
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(dev, "ADRF6780 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADRF6780 software reset failed.\n");
 
 	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
 					 ADRF6780_SOFT_RESET_MSK,
 					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(dev, "ADRF6780 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADRF6780 software reset disable failed.\n");
 
 	return 0;
 }
@@ -383,10 +381,9 @@ static int adrf6780_init(struct adrf6780_state *st)
 		return ret;
 
 	chip_id = FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
-	if (chip_id != ADRF6780_CHIP_ID) {
-		dev_err(dev, "ADRF6780 Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != ADRF6780_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "ADRF6780 Invalid Chip ID.\n");
 
 	enable_reg_msk = ADRF6780_VGA_BUFFER_EN_MSK |
 			ADRF6780_DETECTOR_EN_MSK |
-- 
2.43.0

