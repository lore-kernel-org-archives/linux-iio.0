Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D5396D16;
	Thu, 12 Mar 2026 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314479; cv=none; b=Z2/9SgLguWd/ufZQ7Sfd2ucIIaa+IeJr6hf4cMl/a6BQUJWIe48zpUZ9vHkuGlKy5w8i8g/UC12Csh7lLtuBoJo8PJahzIE6+2OG2cY5hVFgyaoMAOajS44O8LB4cIt3O6y4ENFaMU7pgAxISKFj9gelSdY3f61kxQBuVyQWj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314479; c=relaxed/simple;
	bh=0XTKkBuWxSzzBc/suMe4Rgc5thW2huIqCv645br4jcw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=om2kiKbZ0IydMS81ceDRWnbdupSrz07ieoJqRFq5vke0iwXfakQeXkoxJsAnm444/yuG9bX4hxXw2MBP3J7LTeuVsVxfIEEeUOf79JTAyy0WKh3IyTD5KBoagwpKk23G+VnraUpg6tw4Qpl0Pj0NwPzOeHO6ABa+ldM27R8ptjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cANLY2qL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cANLY2qL"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CBDZkl030488;
	Thu, 12 Mar 2026 07:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=BiRcMy7ZF2RW19jmaxoSCzwa7QU
	7o1CyFBijkFFDX8U=; b=cANLY2qLL1h1hKBQwBAjXUUm25V8YPlCFW5faCbBELP
	RRW3ORsBkfDj5DwgfCBmDp7WzTQ+Vo1BLdIn5kLhuIuWs1cZlbweQ2tTgOx4T/ou
	FYagKtl9rolMghGhJNadVM27fkSGQXQeiR4sZRxpK0fR+zh/7oFQt7XbIa0QLxcZ
	AuLn0BUUj1yB6aAYu2wGN78aTe0Y3cwM+/VYmvNkuu0T5JMuzZPKPoW/X25OVGJY
	/rcaV6JgrUPSiQgKK+jEVIQxhAS2VyT+AlLU/d1gMHmUN0D88g0c/cAeOEkQKjIN
	r6I0M4GmxCj5IsOdjLcB09PMy/6DZFWPcoChqq6cQIg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh762abu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 07:20:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62CBKqoU032439
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Mar 2026 07:20:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Mar 2026 07:20:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 12 Mar 2026 07:20:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 12 Mar 2026 07:20:52 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62CBKbhj021783;
	Thu, 12 Mar 2026 07:20:40 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Lothar Rubusch <l.rubusch@gmail.com>,
        Mircea Caprioru
	<mircea.caprioru@analog.com>,
        Alexandru Tachici
	<alexandru.tachici@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: accel: adxl313: add missing error check in predisable
Date: Thu, 12 Mar 2026 13:20:23 +0200
Message-ID: <20260312112025.57554-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: wj6ToirckPH5qpy-0s8KdrRRgbpOSTcw
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b2a196 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=b_bjaAc1jWhZYSGsEPgA:9
X-Proofpoint-GUID: wj6ToirckPH5qpy-0s8KdrRRgbpOSTcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA4OCBTYWx0ZWRfX5LrabnPVOAap
 M69VjB/8UQt/Z8oHN/Un5adSQgxtUxcET8B1SgPKnG0pGZxHuQJtxpYM/qbFpj32xvvlxHX4CgN
 VCp7Kf5izOoYQ9orx7zQ0tuRrzDj3+RRnwgQhRBlIHADn8IuDe4IcruDiKaxzQ3L+LtpCbgLF6F
 U6I28zS26ope0sHkkIrKz1bMfNSmAfYSMgIpM0otkyrplg3l2vV45+lC1eLdXjQyET+79yyqP3S
 IXrPMh7Y7EUTRcVBbGZ+32KJUFRYYtMA/iENwuRQ0U/raoBISEvANzqQ+bD1SdhiwgQMpVAZsUX
 IaEvrBP7+LcPeMwOe/3OQHTC5L25S8uDGQoSBirg6pzb9XUGYXGx+LT3kEjtMtBOf+qbnKEZcYj
 t2wlmk3dhQW8myoQUQ6/2gz76DFk4Ds/4e503FzeqKHdAa0fVLJBnrSW7HIZZ3zEaoIHzlWWXxd
 XuB8D22Xryxl3PG5qqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120088

Check the return value of the FIFO bypass regmap_write() before
proceeding to disable interrupts.

Fixes: ff8093fa6ba4 ("iio: accel: adxl313: add buffered FIFO watermark with interrupt handling")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/adxl313_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9f5d4d2cb325..83dcac17a042 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -998,6 +998,8 @@ static int adxl313_buffer_predisable(struct iio_dev *indio_dev)
 
 	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
 			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, ADXL313_FIFO_BYPASS));
+	if (ret)
+		return ret;
 
 	ret = regmap_write(data->regmap, ADXL313_REG_INT_ENABLE, 0);
 	if (ret)
-- 
2.43.0

