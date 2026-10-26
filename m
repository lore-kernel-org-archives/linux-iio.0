Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055971;
	b=tQVpy3tcmQGHphmpW6OihlpamC8OtPsbsO+GT8MMHcQGHI08hMBnMU/aRA7JAnAo7ocx
	 Acq/kGcPT4w9CsZCskfxJ+hru28QomkB+84PABg/eR999fvNmGojPXQUayN8/VjtcBq+z
	 HOwbUyYJl9m3L+eovBgSrEKbbw1lxuVThHMWlBrh54uWoUk+jz1OzFJsQbR/JNuwpkCcR
	 GSZSEwurNhJ4KiCmGsUdAVcnFe97bpD2eiMGnGovZ+F/qeggO/Oio+cJ7NnS/r2vbN8Rq
	 kgGWZ+NzjeGjVac4SiJJIRuU/VOwPkpX82jLGgsp6W3PQOnyZQCsaMsM99zdVtNX8Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055971;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6F++Rp7BnNiRejrdsqN0cdugVQ55rvyjIrbA114NiV4=;
	b=pA5mLWYFG0AdZsmZ/0MmejjJ6ee9ripnRKa1hNBEiQBuL71GiYvXXRrSPBTPY0uZHMsk
	 jm//OEML80B8aK6fUO0IVuWWYks/eyodMpWN4yny12KUAwNle8GtU4kVPe8dNS6YRpuSW
	 qg9rgTu7gBNUMwNj/TjFmdZGBCxXkHjvni2pU8OSl82gxEP9tJ8n/xUIaTlEVUrqaykW4
	 spgAdGHhL1wnIJozQdl7c6LjRcaT1qIeFVzUgX1PiA08tslfGcRphnyDyavb0FauEEfmq
	 zss/vhVj5e+x6Ul7on1P81VuLx1ipFUZ8/ddoqZG55c7Aa45K6/nq8rsuZRWEVENZww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VCRlJmfK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B7606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B45B7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VCRlJmfK
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOxTY1439554;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6F++Rp7BnNiRejrdsqN0cdugVQ55rvyjIrbA114NiV4=; b=VCRlJmfKo+ZB6DCR
	qIBqPRVl4/WPhGFxMgHfK41cB9vqj3r8b9eevr1yM2ZqekNzYYltd2clGoUdhNnj
	zwPMtwoo4Z+TkTnCIldI8bnmzw0V11akVCg7E9CdKkDSbBnO5Yp4322Tcr1myroP
	/orygjjZKbTkTh+LzNyX3NvH+PXEekmyCJG393LkAP27/80H9P8fHXFMouzvxcxB
	HD7TwpVjiyfVs0Rq+F/ON/hiC5CUBA/jjqWg+7kxKgh0TgBj23gXTXbFQC7YPinM
	9aW6VlG+lvsp4mxLKosHKhcdeVxMNjHD5hnPVYSGYsmDYbIrOlOtE0nFix8xnYO9
	7mCBaw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2qnx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN612b168708;
	Mon, 26 Oct 2026 23:06:02 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61Hu168705
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 2CE9C2561E; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 17/39] iio: health: afe4403: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:35 -0700
Message-ID: <20261026-iio-v1-17-8b136778eedf@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX4QRcNahMsdPs
 YGMELOFszG8s/RRHK56IdL9Zygz6ck9VYDIn7ToXgkP0n3Y3DDNiRcE/hT32n7iQKBENlvAcnT7
 XoRcvuVghcQps5C35dPy+LsoVl6V48U=
X-Proofpoint-ORIG-GUID: 9S6BM6KPYCNaHqEjthKve5PIOafE91kr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX1QT5Yh4DbxG4
 jlEaXlTGGLVF3XjotFD4qgLWxzKYJVVTr5nkrfXvrnDVskbB+wFM3C20Ysp75rbFT1xgBV7Uu8b
 hjX7XRY1m7oD5GpkzOwdrgDaY6enWTcvRJAu2P8g1PMN72k6yJsZDJ9CLFbbyoNLzjhnRNAz3EF
 ddCXEtRUtbLee8+Ng1hHwjQox+2W2LeoLzTl5TgaiLmNGQtnxAVe9X1LqO4My8DdPM09KMgBK1+
 ccLG7ENvcPXf/MxYOx8XUsmIe9kbzQ5lB29SZKqn08SN+t+AFwVT4xFmm9OtP83Bf68tJgTiLh2
 sW03J3NNzD9Nav2Mqt1YjsqTkJK0F992//3ubJEra5fgpCoHtPfXnq3ZFwK8BnjFv0TzGRq109r
 adpvQXnBp3C3Eo9jtxVDlp+IPuX9+GR4p3JPDQlkKwRiNsSEEAmzouOcumEUEjXyXjkblvrboFf
 iTHfdWkkYDzBIYTLGsQ==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=K6mKe0dInRxwhhYrx7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9S6BM6KPYCNaHqEjthKve5PIOafE91kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

The pushed buffer is never a direct SPI/DMA transfer target, so move
it from the per-device state to the stack. Use
IIO_DECLARE_BUFFER_WITH_TS() since the timestamp offset depends on the
number of enabled channels, and zero initialize it.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 2a648532242a..d35c00a2bafe 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -64,7 +64,6 @@ static const struct reg_field afe4403_reg_fields[] = {
  * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
- * @buffer: Used to construct data layout to push into IIO buffer.
  */
 struct afe4403_data {
 	struct spi_device *spi;
@@ -73,8 +72,6 @@ struct afe4403_data {
 	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
-	/* Ensure suitable alignment for timestamp */
-	s32 buffer[8] __aligned(8);
 };
 
 enum afe4403_chan_id {
@@ -313,6 +310,7 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	int ret, bit, i = 0;
 	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
 	u8 rx[3];
+	IIO_DECLARE_BUFFER_WITH_TS(s32, scan, 8) = { };
 
 	/* Enable reading from the device */
 	ret = spi_write_then_read(afe->spi, tx, 4, NULL, 0);
@@ -326,7 +324,7 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 		if (ret)
 			goto err;
 
-		afe->buffer[i++] = get_unaligned_be24(&rx[0]);
+		scan[i++] = get_unaligned_be24(&rx[0]);
 	}
 
 	/* Disable reading from the device */
@@ -335,8 +333,8 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
+				    pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.43.0

