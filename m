Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055969;
	b=iEZ8fga37E+G6DjRG2uGlO3/Ul65ClqOKP9RjiS0cvgBSA4ZEbF67ijJe4d5iLOQd7h0
	 73VrqKCtVEae6MDdfUU9dM6PIl59qeTp1CMiCVDyuR9QgBVfRdtmMejPWaixxq2JMUQ1S
	 JjeGQHv9bWbmOWGPF1Rs+vRwrElu7UtgvwFnvMSUjCe62staxtt2kx9tbi1zUkKv2w8oQ
	 b5K8K6g/VvbaR8bM2JFWmgy8oCZ2OzPixcYxjP98Pw0dPyNORwullhuxjVi1gF16i3n9t
	 LXlKOJIbYXQcBxD/ZladwXxgDuwXqO8nw1z8r2hb27lJ3CnvvRY9Dyl1a/r4KE91DCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055969;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=m+QN4sR/9ck81aELHKUi1+rEudAhwJ4J2TYsaLSF5iA=;
	b=NL3ado/HAyvnAEjNUi6h1n9i9DalSy++JfRQfqqRHWph/BWm7JJN5DSOGfiN6Dff+bXw
	 u9ZB8zr90T/qRUysrN0rScPE91mHTOGYBFbPvsGFwaUz2Fi5GVHIHtdD2ZzwFqNAJISmx
	 X7+QPEvA1lA8VL6chN58F+7aUwl5zM5MKnKYeY9Nb1ggTf51yv5jM4Ga0LwEd1sTwMJTn
	 ssjY4bap0AJexfrh3EAs7Po+qAhIxYrkk2gzCNOTD38bWrlLigtS4jDHFDNrjv9fGhJD7
	 6EeiUL9R02bnNaiKQgs6TDbwWoXOobCJdFEFQ4CbRTNULxh75NmcNEBmdRPq1pBJVvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eUMkuijf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A236606A32F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A236606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eUMkuijf
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPFVS034820;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m+QN4sR/9ck81aELHKUi1+rEudAhwJ4J2TYsaLSF5iA=; b=eUMkuijf5Mgncp7L
	WOrS5XORo27xqrHY+li1qBILZyjLlDOTdFmylPjF1/ZfH16u6211YEgVrRv7M0JF
	+bPHrE8YrmQcS0/kMsDnSPBeRI7T8opM+MNrsaSY9E3I34tZIac0N7o8axpCVirU
	1vq+KO/rblzROrC3vjSsFBAx44UrJRcg2TVeakODBtSRRBiP/P5GMxwfeBEEIfbD
	yFz6dGhvJZvSV/pFB/hBtqsquWYwJCOdbqLY0JVNe1fdBRJIuEzNHTR6Deud8KXD
	xuJeDw8oCgf7OEDxGaknqD4Bb1FIRvpf/GDGikW/omsfj6aXoy2QvPUjMHMc7T88
	YhZHSw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cpawu9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61l5104604;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN61sR104547
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 7B0A32560B; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 30/39] iio: gyro: fxas21002c: use iio_push_to_buffers_with_ts() with explicit structure
Date: Mon, 26 Oct 2026 16:05:48 -0700
Message-ID: <20261026-iio-v1-30-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX3Y/d+kNCgSv7
 rAlL5q1b+iPUFFS/dOwofU8kXyJkSGDTzSaHextDwG+EIPIvWtk9siq0Ma/beRpfR3QZsRLs5Ur
 VYDe3WBLAEbCzmHiw3Uo1eE/KKutGcl8WbZTqV/ezLldveC8l0AYBqyF//SzYwivTZpVc7vbw21
 OjNvj//BHdNNYd73F/Crq+IoS2VWzQsj/qONAZbCL3b+YUbxKTlrPy0J5zTkNM8AoLu/PPeOTo9
 zGOYK9KKlPAhYehMfV+dLcTdQp0C8ZZBVhMVVgCBVoFJPwZNarcbaVzE7p+h+agUYuzZAJcai8i
 TzzJUe/EeiTva7IjDanXF1gvJeVyuyUM3Pw48itD2gOPias7WidQuFjLqiUfzAmPtbZ2xDR0qym
 vUE4rOe8rPcfly0Pd5cr0drK7vOnacCoQzjSo31TnUFBqREBQm/4xaoTlLyOIB3mm35+dneJ1R5
 pEKsREDkbFcyzK2SQww==
X-Proofpoint-GUID: I7rHzviAFn4isE0OdZRR4JcH_Nq0lQiX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9cHu9QGm5Nda
 GD0wODubzLhBNVD2MAsybCiYD+COytMaUN2bhTqpoKdzAFt1Sw8xAFkT9DYbtznXi5owiufnpr9
 NeLzy85hhZBjwWA0UszuBw8moK3petQ=
X-Proofpoint-ORIG-GUID: I7rHzviAFn4isE0OdZRR4JcH_Nq0lQiX
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=3YHo4wzFQ5SQEu7ghcoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the s16 buffer[8] with a struct containing the 3 channels
followed by an aligned_s64 timestamp, named scan.

Correct the channel array type to __be16 to match the declared
scan_type.

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is a structure within the iio_priv() data.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/gyro/fxas21002c_core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 6ef3ba2bd1f8..82379cd55b3f 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -134,6 +134,13 @@ static const int fxas21002c_range_values[] = {
 	4000, 2000, 1000, 500, 250
 };
 
+enum fxas21002c_channel_index {
+	CHANNEL_SCAN_INDEX_X,
+	CHANNEL_SCAN_INDEX_Y,
+	CHANNEL_SCAN_INDEX_Z,
+	CHANNEL_SCAN_MAX
+};
+
 struct fxas21002c_data {
 	u8 chip_id;
 	enum fxas21002c_mode_state mode;
@@ -153,14 +160,10 @@ struct fxas21002c_data {
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers live in their own cache lines.
 	 */
-	s16 buffer[8] __aligned(IIO_DMA_MINALIGN);
-};
-
-enum fxas21002c_channel_index {
-	CHANNEL_SCAN_INDEX_X,
-	CHANNEL_SCAN_INDEX_Y,
-	CHANNEL_SCAN_INDEX_Z,
-	CHANNEL_SCAN_MAX,
+	struct {
+		__be16 chans[CHANNEL_SCAN_MAX];
+		aligned_s64 ts;
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 static int fxas21002c_odr_hz_from_value(struct fxas21002c_data *data, u8 value)
@@ -738,12 +741,12 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
 		goto out_unlock;
 
 	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
-			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
+			       data->scan.chans, sizeof(data->scan.chans));
 	if (ret < 0)
 		goto out_pm_put;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   data->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+				    sizeof(data->scan), data->timestamp);
 
 out_pm_put:
 	fxas21002c_pm_put(data);

-- 
2.43.0

