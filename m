Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055969;
	b=TWPydlrXdHolEMY80jO/iuYzjOOJgil6i7HeooNH0yXNnLXuGSYzNYDZ9QVS2AJPx85w
	 NJvqHXTaqnvC9qYu2FcVugl74Ngy/xfUoLBMGf/mBv60l+o+nuiN/HMIVtSX2Loy7WV8F
	 eW0OqtjvzlGnsrODvmyd1SBiF2UnZFNbOQ/tpMBOZYtokP5wbOcaT+BEb8WDzMshugVes
	 5OeEN+tmPzO4DRUC15EmsXjXpTrojqYQfFcsIz2IE0qafock3sFMB18fmqudV6Xf85Rtq
	 kgyMUfLHN+tLxysMxMu40T1OyYQ5vim7ZszYkpmHoee5bL3YCW2dEmKnA7aHpahVo5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055969;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nS15Q7D2kvS9e30itpNeDerEY/bjvFAF8d9Ck52DtYI=;
	b=lsh1tiTyUqoM9CY0NqBMoA0qyPaYfqEHxVIwfU/2D5yFPZcIE4ES5lxDiysfg0jiDTxm
	 ZIOUJ2MQSGYBkuS4g71oeMLvvxPLBwYPFq73Oxmx+u6LQ09uGQlnA8Dsh/i3yO1ep2Y45
	 Zd47AYsKplm+vTfvAh9hNb7Q0AcjxE2JHKAqzDKjFtOQWlnn4C6QtW9oa8+7qD8R2cChv
	 GiVABAoH6KfLb254dMnjeB9nrv+10lwY5Nyf40PvnNY1MJtzvc8Si+tm018fZ/MMfFbEf
	 cZosiaBWsKm56PXkR1pj8QYqKYpU74Cb/1qH27cnbDFpRhqxh/+ZdlgKxDrjKATokRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n4x7N5+V;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488F606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2488F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n4x7N5+V
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP2444037256;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nS15Q7D2kvS9e30itpNeDerEY/bjvFAF8d9Ck52DtYI=; b=n4x7N5+VCPxa/SlK
	0Wn5vchUZwLR2E0kHSIQDZhrGorPNs6AJ54C/fi5lj/1rbndASQJZ2AhLLHb2n9s
	F5nXslbh8rlUkARqH6ax7qj2vPF7ouipiN6iPYz/KI1/Wlq+9d2NCDt2kgl7GcZ4
	Bo8b5UkELL1aXXjRLJddLwOldZy7nK4l7DBG7bwlHtlzmJReLxnVS/e9mdQZigy8
	wROmikCXC+dAkIV92JS5BN0vN52Y/UAAOKbZBmmnpiyzJYDbMak5OZGV4e+BZxa6
	obs4GX4gIXC5uoR32x8bGVlo5XIHzBoF/J4PLwOGt1eeJTXMxc6i81NdFKghqpGQ
	5CFpjA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm8ysn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN00sg158309;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61mq168721
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 6469525630; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
Subject: [PATCH 26/39] iio: humidity: am2315: use iio_push_to_buffers_with_ts() with a scan struct on stack
Date: Mon, 26 Oct 2026 16:05:44 -0700
Message-ID: <20261026-iio-v1-26-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX2MT1AbA/T+Gw
 q30gjX/ryY9rrdJ2letHOfkqTTZI9x0Q3vtwJmESwLRP6jnh67U1+W19LqSTcgQekInUAV6YlVO
 4BWmUqZy866csjEiB2PJJ2fy2WsIWJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX0stFTWk8nODX
 zmXXOuou7hcA5yA0FVGBaMuLjdDV8dvKpkjgeS/GUZJyOYyIC3kdUdKWNtLxjw9/3jEW5cq2XhY
 wTdput56njP8gq13Rf6n+9PMmycjYA1mfBAIUIPuiDae1ZrRcQykXe+C75DwRBf+oJfrC0CBkKJ
 5lskKe1avgXj0OcK1BmMUMPAz/GGH2EzxrkXoJgQ3KUaEypHdo3B7WHOEx7IOQewwpoIYAv0n0B
 KJaekGVpHIxwvBWplbvvFyieV554X218BEmVU5wYPLn+pwI38kTz94P4vvYZ6T7+nKnqurW4rUk
 492M4HZKyl4aJMjDkeUcaCqXV5C6CSx7oPAjcsWc++JPa8ZKzy4DeuIRCSSgU0NRc0Y509Egun8
 NtcgXbvzk/yfsx+D9A580FaNW7C224qcxrjXLmRSzrujIuRexUlBA8v3VoWtAmyjvU1hOJ8hUCr
 ghknsGw74B6A6CPJMLg==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=PIsEPwTpx7L0SFnQURcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mb2BshekiO88a5iv1ycAvQclCoW9UrPG
X-Proofpoint-GUID: mb2BshekiO88a5iv1ycAvQclCoW9UrPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Move the scan buffer out of struct am2315_data and make it local to
am2315_trigger_handler(), as it has no need to persist between calls.
This also removes the need to hold data->lock while filling it in.

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc:  Nicolás Antinori <nico.antinori.7@gmail.com>
---
 drivers/iio/humidity/am2315.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 5c7582f3a4f9..1182b084fa84 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -42,11 +42,6 @@ static const struct am2315_chip_info am2320_chip_info = {
 struct am2315_data {
 	struct i2c_client *client;
 	struct mutex lock;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		s16 chans[2];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 struct am2315_sensor_data {
@@ -173,27 +168,29 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct am2315_data *data = iio_priv(indio_dev);
 	struct am2315_sensor_data sensor_data;
+	struct {
+		s16 chans[2];
+		aligned_s64 timestamp;
+	} scan = { };
 
 	ret = am2315_read_data(data, &sensor_data);
 	if (ret < 0)
 		goto err;
 
-	mutex_lock(&data->lock);
 	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
-		data->scan.chans[0] = sensor_data.hum_data;
-		data->scan.chans[1] = sensor_data.temp_data;
+		scan.chans[0] = sensor_data.hum_data;
+		scan.chans[1] = sensor_data.temp_data;
 	} else {
 		i = 0;
 		iio_for_each_active_channel(indio_dev, bit) {
-			data->scan.chans[i] = (bit ? sensor_data.temp_data :
-					       sensor_data.hum_data);
+			scan.chans[i] = (bit ? sensor_data.temp_data :
+					sensor_data.hum_data);
 			i++;
 		}
 	}
-	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;

-- 
2.43.0

