Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01F364EBD;
	Mon, 23 Feb 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848017; cv=none; b=qyPc1in+J2DLJhah99VjcEoC1D08xIsRsyiHCoZlALW6xJqIoqPrsLfekaUQnzY8IqC84kPILoxvzVUkzR9vUEyB1yaablkfqVaWD/sTy+azPIWHCE/67YRfofWuOTqEP9wu+CmsE2L51ESfLrMDatHpfTvIKGqpxgSG+UWLdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848017; c=relaxed/simple;
	bh=KhNou8ylLjGov58N8u/85/gX5GHEEpbh+3bYNl8Ijw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CezE5TcR8AtJLkqo0fLxm7G1WHTKDNMhCnMQXe0RWzOKAEFf0CdKJyegreKO7xHRy/gRKJoPc9sHx0UklWSfeVMG3k89sbvCwZV6C1SE8n+/hUTb0ibpcE59HiIveVbPv0De4X9carwlrxDXC5ddmUQYSZmZ7KTmNGuRUeiRffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RIRXsscP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RIRXsscP"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N5sqO91742937;
	Mon, 23 Feb 2026 07:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VharO
	nPKVkW3uF39fpdPNTpSKL53JTJCvSylw8rYqXs=; b=RIRXsscPgbOgjqdUcudfs
	T/H2GSU+naIUWjZj/wN5L2+JKC4SZ8BKfR/HEANB4mpTKsEXkY1uRxwQLs677Bcx
	jUOVophdKODrUiPM3ad0AtCoXfTVA1g8EMnWzSkNncDktT8gJYVgahMlU9qa0h/Y
	jqur9Dj2ihJHVG71RRHuKBd/Tyly1kD9bSfoNoSt4BPDgW6l7u/mLY/TrNw47GFq
	XFMhXEq6TdkSHTRr9k43RmD1S0ztcHFejEIw777Mhejh/+98pc6CYH571Km+LULR
	GaYy8YY/J9noqrQQz0StfGaw/5V7WlBRz02fYoNe7sek3g/9mVbfhvSgZNGaTAB+
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4jvbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 07:00:01 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NC00cM001001
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 07:00:00 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 07:00:00 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 07:00:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 07:00:00 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NBxjvO017977;
	Mon, 23 Feb 2026 06:59:47 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v2 3/4] iio: adc: ad7768-1: disable IRQ autoenable
Date: Mon, 23 Feb 2026 08:59:44 -0300
Message-ID: <5722c9ca8e3889459dfad1233f607d990aa7284d.1771362939.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1771362939.git.Jonathan.Santos@analog.com>
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMiBTYWx0ZWRfX4vaaqWuVlrrd
 dc+fJdcgpRjfW93el0x34CEg965aBPqi3WzHBYz1ciSTstqR00a5Cypx4JW2jriIfA4hQVVZawj
 kTOAw6KEBoiT2O1YOY7dN4hf8Wtbxjbf0xKTyqkha5CW8LG9/5KVokKF+WNArBWx+iIoz6j1cn6
 gEgaLjyaw1I0jEUhFU/qWpRNKdB5f696jUJTt8hr3z5AnIEK3ycRayyrZwpgVf2CX0XljSJGIpx
 OGAYkZBTYVvtvB5VuCaggRpRbbmxDI0TtK4ouWhM4nDXy4vvLlcsGvpHm3/C/hJRxJZbNQa/d+j
 OASkqnAgixnff1YlvuI91BvNl8jCydH/1mQGsCl1kUfPHr6c6Y6bDaxVGynPG4WcaVLty1ACxvi
 FhyF0zjkG3DX5u+4Q2+PtB+oYFRVZK/FDNfut5MDWxGx19V7FZcw3JzOo82h+9Ji1pBTsOKCUH1
 yKwpFLBhsbpj6wSdewg==
X-Proofpoint-ORIG-GUID: mKUi0z584sjZS5oTfxRDMtYqj3btG-cR
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c4141 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=gy7Ta6SMeDADBy3mfWkA:9
X-Proofpoint-GUID: mKUi0z584sjZS5oTfxRDMtYqj3btG-cR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230102

The device continuously converts data while powered up, generating
interrupts in the background. Configure the IRQ to be enabled and
disabled manually as needed to avoid unnecessary CPU load.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* New patch. It solves the excessive CPU load issue and addresses
  David's suggestion of having the interrupt disabled when using
  offload.
* This is a reproduction of and old patch sent last year. please refer 
  to the thread [1].

[1]: https://lore.kernel.org/linux-iio/20250718013307.153281-1-Jonathan.Santos@analog.com/T/#t/
---
 drivers/iio/adc/ad7768-1.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index a927ae288fbb..b77523393a18 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -464,9 +464,11 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	int readval, ret;
 
 	reinit_completion(&st->completion);
+	enable_irq(st->spi->irq);
 
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
+	disable_irq(st->spi->irq);
 	if (!ret)
 		return -ETIMEDOUT;
 
@@ -1339,8 +1341,22 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
 	.predisable = &ad7768_buffer_predisable,
 };
 
+static int ad7768_set_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (enable)
+		enable_irq(st->spi->irq);
+	else
+		disable_irq(st->spi->irq);
+
+	return 0;
+}
+
 static const struct iio_trigger_ops ad7768_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
+	.set_trigger_state = ad7768_set_trigger_state,
 };
 
 static int ad7768_set_channel_label(struct iio_dev *indio_dev,
@@ -1704,7 +1720,7 @@ static int ad7768_probe(struct spi_device *spi)
 		return ret;
 
 	ret = devm_request_irq(&spi->dev, spi->irq, &ad7768_interrupt,
-			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD | IRQF_NO_AUTOEN,
 			       indio_dev->name, indio_dev);
 	if (ret)
 		return ret;
-- 
2.34.1

