Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055968;
	b=Ma09hwnxuHP6CMQpGFs0fA9SXsCjPPQJP0OsGIiu6sIoBUc6Y9Q0tEuzPRizPxNATN36
	 eCUTU9nQCTycgKR/t0FrI6HgCgSxXomrKWLAt8WC/TtcMkB4EUTUpG+/nzZUKgJ6kYV15
	 xRjS2KNTkvgvz4mR4vf+jR/oges0IYVi40u2J8p8NDN9YVUNeahie1EaEMeTTN0XKyiUj
	 24erM0vhXEzxG17DkDnmJH1Msmm2lMVRZLMCbzT8vBCuOGi00PSFi5VlF9FTkZXncNlPL
	 4mRMxBqaoBH/aISRFCQ53eAp7eu/TCS1mhrwIxqam5caQRU5ybXJlYfax7cBzugcrdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=z5VctA2y5X560+lNMyaBO1rXP1o1cE8G3vmYadwaUMI=;
	b=CFNMye0FUT+4oIs6FwTJ/7HEVruUjsilLtg6TIsaXuW9ugzWZHIjS4f1I2oYF5v9k0uO
	 6cv73QrtL99+NTh/+0XtCP2UsyV1zpd8TaQ1R8pN/JEDPnK9X16E6IvnPto529z96ob7f
	 fjQHHAOguCYJDRuuemXIc7aqJI0seKlAQTacpZvIB3/Lghx0BTuqTwIDABvnEAT5cwEtT
	 TurWx9fP54Otfo21/hqPOVHEpw3jnpKB0EU/3oRVf23Y6TgaQ2itsulWYZ8g0AEcQHrvh
	 B3SdWNDJDXspxpp1Dw+m/F2hxkrnvv+nmqZJ4mGvqhC6s0UEIKs2US9bdR/d1cqF0Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="nT/l0uxj";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B75606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B75606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nT/l0uxj
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP659389098;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z5VctA2y5X560+lNMyaBO1rXP1o1cE8G3vmYadwaUMI=; b=nT/l0uxjPmVTMIMw
	WfAIWM5zpghStR3XsyZRDkY8e5yX3SA0ZZ9rBcSapbHRFSAOXM9dJjLnWn8psFTj
	piT7cipH5MZkwM5kHffxizqWtsT5uarBFwUKH3MjbEtn4SClA4PBygsKByVcXbhM
	2o6ZewMWVLqQADexOPOAQe5+hh/wEVr3VN372bLWDkxkCfMstxCznTy1zPRBqVaU
	s9ef6RCi0/22IWJAQsmHO3Pf+V4iOWMVU3L4Bz5VARp+n5FFrE+v0KNKx4EIFHt+
	IfVHbAYemsF1T6AFTd/rh6jbK47OBSz5ssLamhZuZiPKulJeZm5K4b/+ckZ7TeQ/
	kw6xTQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xt6k3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMx80P248647;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN6195259905
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 1679025612; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 13/39] iio: proximity: sx9500: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:31 -0700
Message-ID: <20261026-iio-v1-13-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wMBBQ6EBqOrRPZ6v2JQPF-W8PH-UvYb5
X-Proofpoint-GUID: wMBBQ6EBqOrRPZ6v2JQPF-W8PH-UvYb5
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=pEAQIDIrzM-qf0P1DKMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX+OWJayEHlbWP
 3e03Gd7y9gwqdJoNQHBfoEo5Bo8fkMeuCdFpu8dPWn+/5Y5wEQHB9djXFUuL2EwqIg2ndZjI6KI
 H0kgWl4BfmHG7H5jspBXaA85/u5enLv5VK/C0H0772omOebXkAgOlqI0uuTSwaXfqSYLEsVYn7u
 pd+ZNvTf+OhHgOZ8ARlbTLoQn21hjY4wrZ86bzOk1HkzkhTjVByw3plAZBO6/YxojZFFbDiNkun
 l12UzrXSBLR9g+l2ZD2qJsVhAAzchVmNA5+6XmAXmVizIKj2retPZ6Qe4gL/yoK9JWwR7E/0R2C
 BoGHGb9pTbMOIBgm8BsgLdnH3Hr+1UIXebNrb1xd3May9SwLKi5T/KyAGg8jmNQnYbNW8msOLBk
 7gw2X9MyVhEIH7Lx2Q3imHQ9SViEC2UsSjsy1Ffa7Q5/YYohZbjR3+hMIL9qYpy55CVKOQs7329
 8uSfUJOVR5b6iO+tHNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX7jxaBf6x8ImU
 PDP1ghjsJyZdEZCO6sXrWZFg8oxTo92OKPnJ3n6alfc/m97ru/EUPgOlYleZLkZ9+bEf9kcxrrV
 IlsKquqFuPo7TEfJdiGtqSbDknn1THk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is on the stack and local to sx9500_trigger_handler().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/proximity/sx9500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index cd67d88d2be4..a2709faa0106 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -647,8 +647,8 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 		scan.chan[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	mutex_unlock(&data->mutex);

-- 
2.43.0

