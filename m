Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055976;
	b=46J4bIb1atRpWsbo5Cuk6y8IO4OL7p2XPrEV+JN6dHJM/9UHtuVNkmR2uISmparQwhBW
	 WE5Qdt3NATcNjYwjbmoV8kY8Dj0/pVhO49NALrYSZfteb27/wCEjlakMoZk3RyR3slxf/
	 ju1+G0wW681NptpZGXWBjAxB1DW13OXNVSewVJIQHUDkMUUbkLoCTki9gFDidaPHX1bkz
	 jlp/nzOyS8xqj9M3kefqpVVtbwXP/basP/tXM2AV0s6XiggfNqgICdsf4ZCVSRV6Hfye7
	 70/XwEkTJHanG4CVe3VCuF/S7gYzhllCCtu3beoIz+RG+XGko3oISI6okoFadBZuIEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055976;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=A10mYn6LLLImB8GMNCM8f6LAb3vPO9GolOBQp50lHHo=;
	b=1PiilFMAthIa27qPlycVNhBjGwlK1G//zUnNJeKVDLURS5jOUs+s2Fu26FgnPtg6maJm
	 fKqnZIb1OWVMQYBd66lb06VWUjbB9ELnII6CcnwoADeuV8UFOqnoESzu3ozfEz4w8mkhV
	 1il0PEhOD7dO/EyrQnczPJ4HGmqi3TyOifsLR6oJo5znQ2daIiwSgP+dgCndvau8z5QBS
	 VJiKgBBH+PvGjdybyg9Z5SLNl64YMQ2a7qSsQxIrShsWKq7ig0aDARCu3e0ql9HU4nkww
	 aOpZjIZLzi2RlAJRHYjzHx1cNMimCnVxWmzk/2j/agtOBm8P5+4u4GbE/6TlLNsnHeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pwjJq2pa;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8F606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6C8F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pwjJq2pa
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP2o7388493;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A10mYn6LLLImB8GMNCM8f6LAb3vPO9GolOBQp50lHHo=; b=pwjJq2paDnToQ0OO
	k6+5MA/qTumrxzbz1nLfvXdW9dT7PXU1BOrpEROdIZoLP60X0V81rW0Clwq6wu6i
	MpbEdmFvimMyBKyviCn9HbJU8gFXM68BaEa12kxjz48Q5hEObCPQM18UzMaJvmJO
	Vp1dsY5hiUueP4elPmPNO6jm2ljnArCOGhhVLm6BA34ancEgXjbG4NUZl2ET4pbJ
	WhScoHGRffUt0lHYmhU0bkN4oKwdo81bazOIo3qEdkiWPVlh602S9wrNWtWzbY1i
	F7/CZonlh8WrttSLxXB9nOGtogTEYehmO9aZV1FDMsb8moR95pE4uVcYT8pocxax
	LoQZCA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xt6k6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMwxSn092992;
	Mon, 26 Oct 2026 23:06:02 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN616R104596
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id AFD69255CD; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 39/39] iio: imu: bmi160: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:57 -0700
Message-ID: <20261026-iio-v1-39-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: DgO0SPOOuuBEsQKqmox9llRR18lsmGMJ
X-Proofpoint-GUID: DgO0SPOOuuBEsQKqmox9llRR18lsmGMJ
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=s0QJy7DxEIfNetUbPr4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXzpn7CL+quRqE
 uxW4ZlzEKTtPBNycO94JY98vPmDfdRwOnRBqwWhGY2NCbR8p5JnwcWKnDIf9VdXHgcJsrCP6qkV
 98q68Pd6w0pnykiS1ZwhB1BKTzFfv0zdRA+NhpRKIiodHAN/HY7PNa9H9R1L80FiEOLqql0Tfh3
 ElEje/rhomw+NpGWuyc/pH4rXaX+an4WbiS7/SZgBQterFNOICyoGqcaaM6Z9gYh2KHy5kYfdap
 G6zUjHg+NKWnvZUoT9+5EuNTtDhKbGtemO2LXuT8UbapgQINdiCSO0BHpo8t/UxpuBasBWkXauc
 TzAiqm+UkCb97nX0xhodMC96Vi9NYd4+BBPkJE+W3Biz+qrCEzYW7RHhsMeRY4X06sXBIu+FyKJ
 Ol1w1TT2gxDxaJrMd8FBZf8HlQG5MUhcAsx1ykr8ZGQ3I+K9y9xWry4X5yvXmTxTGMWULwQHiBM
 qWuYTl+1eYSWatkehoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX0Tu5l9fdoDVq
 f/4W7O7fgrKWMmOCD+N96v1Q59m8UX1wSFpImZzGzP9VJ0xaXLv5ciRs/hqHvBekPO8SbXG5kuA
 6YfkjaE9Us9z1Kjz6blkd5/AnobM8qs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Move the scan buffer off struct bmi160_data and onto the stack of
bmi160_trigger_handler() as a zero-initialized IIO_DECLARE_BUFFER_WITH_TS()
array, since it is only ever used locally within that function.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/imu/bmi160/bmi160.h      | 7 -------
 drivers/iio/imu/bmi160/bmi160_core.c | 6 ++++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index ffbe8205e703..629844c34f1a 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -10,13 +10,6 @@ struct bmi160_data {
 	struct iio_trigger *trig;
 	struct regulator_bulk_data supplies[2];
 	struct iio_mount_matrix orientation;
-	/*
-	 * Ensure natural alignment for timestamp if present.
-	 * Max length needed: 2 * 3 channels + 4 bytes padding + 8 byte ts.
-	 * If fewer channels are enabled, less space may be needed, as
-	 * long as the timestamp is still aligned to 8 bytes.
-	 */
-	__le16 buf[12] __aligned(8);
 };
 
 extern const struct regmap_config bmi160_regmap_config;
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 1e73a7f1f017..1bbca85f9f14 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -432,6 +432,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi160_data *data = iio_priv(indio_dev);
+	IIO_DECLARE_BUFFER_WITH_TS(__le16, scan, 6) = { };
 	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
 	__le16 sample;
 
@@ -440,10 +441,11 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 				       &sample, sizeof(sample));
 		if (ret)
 			goto done;
-		data->buf[j++] = sample;
+		scan[j++] = sample;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
+				    pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;

-- 
2.43.0

