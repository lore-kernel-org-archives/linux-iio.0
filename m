Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86C43F4C2;
	Mon,  7 Sep 2026 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769435; cv=none; b=Q8l0QK7O5Y6XGSFfOUsIlchpQfPCcAEgWjh607Q3lJeGmLS7y1lh5njbIF6AsVuwysj4gxGrCLUSViNzQop9UbRP7m4cMm50L2WtdJWlHf8ubW8zaOdlFzw1WmjKXvwftRf7LllWixBlfMROBjAq6yHQaH9V0Fy7UUxKP1W6Feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769435; c=relaxed/simple;
	bh=5yJ8Y4RnVpPGLltjVO8cL2fBu2s7ocPsEot9SK9T8Fg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DmajgqqFkEUj+/CiY6eYEOHV3U4WFis79mxivEPwm6yLnkZqwkVWJlc0I7olpgNiyaAxHy9wvgHB7bnNJhlAQ2yHKcratX8yOekM65OXs/nnX82tfM/bF4LrB3yL4cQVyjLAUubBgjKIRI7c/4uVNf1Ec6iuGaIXycElHfCrAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NW7+67pH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NW7+67pH"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68779n6c3431817;
	Mon, 7 Sep 2026 04:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5fcUbGC5yh8IcKdVaWwN8l9PQHU
	VkmKhG3L0Nsohrm0=; b=NW7+67pHZAMhcSYPWdTd9bfJS5JR3aCcWxmf0H355tf
	5azA6vhWxptX/DNUfCiMJDFDWkmHBgRFHjBP9hNYUg0mJEncttKaCwfaUzFBTkH4
	RQyTyzUI/h0JC8bIv/w1ogzUS/cAmtoo0R504c6U1K1E8DDhLhcKptDVPPGwnXwC
	7GplKm0pWStkFicA6MWNbTrkkYaYucfVd0hdc5U616g4PRaPxMQNs420jHnsDFfS
	W05NiJRrjsZQRNes7Gx/5bEOL77Y6+wpQOnuYcWOMaVKIFAid+PdgEBnryq3V65o
	dgWa/aMMTvdHujKo4365g8wFZ0CWPIQhqb2jfpK9ZIw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gh4dg40g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 04:23:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6878NcAk052247
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 04:23:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 7 Sep
 2026 04:23:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 04:23:38 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6878NRPp003614;
	Mon, 7 Sep 2026 04:23:30 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: accel: adxl367: resolve interrupt mapping before device setup
Date: Mon, 7 Sep 2026 11:23:13 +0300
Message-ID: <20260907082313.3054-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: b3L9E3EnxZHa0Zgj_84gPympN19Rp0Sg
X-Authority-Analysis: v=2.4 cv=f5N4wuyM c=1 sm=1 tr=0 ts=6a9e748b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=cksQzrjOa0daint2JCUA:9
X-Proofpoint-GUID: b3L9E3EnxZHa0Zgj_84gPympN19Rp0Sg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfX2oX1nBSHjTx/
 JVL/0DH+LAUVZD/4UncRofFcA+QcLWr7PwdI3ki/hZhdE1pPy3mO7fGGx727etU+4P/tC+edZ3g
 NEsI1QeDPRMm97hjMKmlLjS7j5m4E6cfBmiwIbNtPoTcA+5jkPzF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfXzShU9Klrb0W3
 Kz4pDzScmVEi+77XbCpUIrMAGaQUuDiC9w1l2BWoKuXlY45vIAJBNJR6ngPaoNfna8vsGN/P2Qh
 qqDKp51/8kln7NbIgH9Qye+n7udU85c0nwdyhnaQ0HDKpARCrjDH+igvYELmjYPumkF8Jugb/Ep
 H1eNUgkskTvv9v++c7EAIz94WDPajBacqoYmKRygtsZ4TM4UAZGDpRFLxNr1/gRbwcw+Au/tTgK
 ylRAK0jv5zKWFVai9DktM7mNTi1CmxvOtKdpPUCtNVrwvUVwagoUFKGaryEmavTihNT9PTqU3Tf
 u8/5bDhGirtjBoZYEM8n4S6/kTd2Js2svSi6on0l3ArwqfeLz7MMmQ3EXVJy0+V4yj1+HAzTHYp
 frDC+2C9YAoquEIeeCO0mz4828rgs4EJHH8eYWs/mKHGIA1nIcaulmT+JQ9ZAbyqI47BknXfJRp
 qX3yDjTlKNHC1Tzo8Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070089

adxl367_set_int_map_reg() uses fwnode_irq_get_byname(), which can return
-EPROBE_DEFER. Running it after adxl367_setup() made every deferred probe
repeat the reset and power the device up needlessly.

Move it ahead of the regulator enable and reset; the lookup only reads
firmware properties, so a deferral now returns before any hardware access.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/adxl367.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 9b47e66c49ea..026db73057c5 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1493,6 +1493,11 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	indio_dev->info = &adxl367_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	ret = adxl367_set_int_map_reg(st, irq);
+	if (ret < 0)
+		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
+	irq = ret;
+
 	ret = devm_regulator_bulk_get_enable(st->dev,
 					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
@@ -1520,11 +1525,6 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	if (ret)
 		return ret;
 
-	ret = adxl367_set_int_map_reg(st, irq);
-	if (ret < 0)
-		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");
-	irq = ret;
-
 	ret = devm_request_threaded_irq(st->dev, irq, NULL,
 					adxl367_irq_handler, IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
-- 
2.43.0

