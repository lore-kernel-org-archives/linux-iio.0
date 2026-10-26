Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055972;
	b=xw4ND2MHmMN6O00TPxxg61kxQpp1wkpkk98GrXn994k4RITE6R2JzHnpDvlQNPX3LbTr
	 AZRAgMnXU+22F1ARGahYm9epBb7Yr8ke6E4kfsgbBxjkQ8FSMbFJ1eXolfcYWaBEUiGOG
	 g4ptIbth35piCk7xQ29B+sWHSB6B7com/c8sJo5GP5RWM6TG0sGJi0dwbgVlUaXRZB6ha
	 mZhGdQFstyb/bl7ng3j7yuG75mxbeRNAqVrfIE/PiuOPLvQ0lQNiAJTblxYZ/3cqgoFeL
	 RzJG0uqS+OJOuw0ZFNQHUw4wWbK3eKqIS3BXGbfYSkajlOuRbvXtGjoWtQPJ32j3kRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SM511iFv06Umax9DbwqIw5iBebYc5jgaQZQTtVzv1j4=;
	b=TrewpESGpx6uHdBcNcuZi6icfp3tK49zp3jeWgaxxMyZrficlGP6bvA5RwT30zOlrT+p
	 na8YemOmKCihIXl14KWwoh9WnEhHRxIWkBAUuCP2RHWPt0eybUhG7OiY45JqlvHx378Uk
	 XI98nCRK8wDeTxKX3w5V947DBFkjnR7V2d4JW3l/I7t6AlOC0HFFLnJBjFbULVLyXJTbT
	 RJdZYlFdWZrlNJRmtaJUFdY/gD/4ZI6v5On5ibeDIz0VMVVm2h4uCdFT6SkgOFh/KU71I
	 SY4ICTLT5QBBJ2mYJph4pAFaaRJmBHfl8Sctvg73/TpEDXb1cszoblZ4UJcmLeUuhew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bSoa7Kvm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817B606A323
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D817B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bSoa7Kvm
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOwIC1439528;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SM511iFv06Umax9DbwqIw5iBebYc5jgaQZQTtVzv1j4=; b=bSoa7KvmyoILk2gZ
	uZ2LYVkdvUpJJS6di0ZfFiw5gRKFRmwQEYsPr/ZE2hbmZN3ndeDPDlk17fi6NFC9
	wl5faNBDx0J84Bp4aJrJ+4qiLKBw9oM2bHSyyEjHSH2cYn0zWD9kpwp5ErhDDZ1y
	QpUxeysOjL47RO53Da4SiKed65fYZP0kDPy6Xw4TP5s1LJzaetXu9ISw9knC6uif
	uCxNDzUqzRNOIt4CEjahzg3W8liahhAyNcq1mhYKIumdAQg5vQli4xW6dY1ZI3Vo
	kLU33OMCYAyGxNDtmu4tH2etOm8ah2fBo3WdVVNxc9q3mEou5K6b0roeOr7S+dEI
	Oejk5Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2qns-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Mi120294;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69QN61EQ120256
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 0A1D52560C; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 11/39] iio: pressure: ms5611: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:29 -0700
Message-ID: <20261026-iio-v1-11-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXzmriWBIxMy5+
 2618WvHDod581H7T412Q6tJv9wSd+ereNDVXQLz3sUHfiDiv67SN24uC4CP5MNeFvlO9B/v+D1A
 6iBLZNi7eRj78/CBSizYSD4zzRbD9Ag=
X-Proofpoint-ORIG-GUID: 9ktAz3-otyiK2LAJGol3HnqN-yuj7DVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX5cx7uDfB8+1U
 00APM8RC2TJvkTyzqSQUR5alhajvN4gE6zG+eyTimvoaOKu7YwkJL9ujk0FbnGbV9JSj76o0PS4
 N4mQwtGFTByjGktNOIbjGGaQ2QMHBa79mmQUfx8SqcMsTHKNE005dqxEaOunTQawq/4RkxCdBC5
 xexIcimaSYzdKt0cvCO0RFmMvPJi/nLFuuAaAjYpn1aC9vydop0PEXN6rw1ac08356g8KDqye/R
 u+0aUjltG/9eFmkI9NDW+psDg4BxkHyABXTkQnTtRxykmNc9g8bOZWayzpEi7DIqE84n2PYkJHA
 S6Y9vFE+B6ex5roGAQtVu2wsjerRw//xErbQtNyufYqgnt2GeRGA5iId2B17PnwYo0WZtKeJ4/P
 TsPI4avosDNYA8e/+c//GPoIPKQCTrBYJDl1Iw7Y9URqZ0OMCCmr4J/pZ5NNOBYZjnkx45dXLfE
 sTj2Krn7FKEojXCMmOg==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=RmElZOpCYtFQgZITcGMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9ktAz3-otyiK2LAJGol3HnqN-yuj7DVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is on the stack and local to ms5611_trigger_handler().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/pressure/ms5611_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index bdac27bd5a5d..72c769f9b6ad 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -224,8 +224,8 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

