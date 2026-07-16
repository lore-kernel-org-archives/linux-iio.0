Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC02E5B2D
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163471; cv=none; b=RxFYeb6iYZV9r0QAapZTiN5DPXUlB4D6Mm9ptMkQ9ocb2nJvnBhS1ua4gC9C50aFnr2PCRNRAmLCuEJ6MEZseQHr+5U2WFRcLC+sPvhPLcS3/5nvVTpCbsSe88UCCeBb0tGKw2uvQKG4nt+UbIaFvFHEOCo3QN/92XToVoh4gYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163471; c=relaxed/simple;
	bh=/o3rKrSl0aVxk9Y4KskXkiell9de+DiLDolv9zTkYwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq5N6/mX69oKQSkoQtYWaOoJK8xSfiv6CQaTYlC0dnJwCo6ueFRRas0PA2/CdGc3Y1xgiZFTfYesH9WULsMm4x+Mue28sTPYrZxa3BBNXo1m3Ewm8quqlr0T49vCynQzi++R/5Vzmpph8+9Y9RMi7/kAqk02ghAQHtzmXiUEXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUWSMZ4m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUWSMZ4m"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XVNW2241512;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=U7IPQWtEZ+G
	OWUGBJ00wCSR9fhCwxzFQF5Tz+5qJ/X0=; b=GUWSMZ4mH32vCntuUpae7QL8Bk3
	MdRPVeLWl4f47hng2UQEAJLH29GLoeAuwZfkSgihpUZzAOD7b42zO9yIbzpfynHA
	m0h0vkhuMG0k4JyXxolu3AaTs+zdn/GLJCeo6xNC9sbcOcMUW/XDICEPw203oS+M
	GrCax8Cb7FJrxc6lt+HzwDQI/teBkzHjZqmqMOABUpLG2kWjsNL1i6mu4PBdt+Kg
	gQQSFu+ZmTXf2BHutIJL4B+1Cn9c3rkRq64UzQ+Anwt2ibQEIyDmI3J8aPqsZD0M
	M429a5xQnz94DSdN+AtIk1L8yrluuUxsu+GRJXG87yy3Bk/G/BKo9XTjddw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe68wusmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0q76B023540;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4fdygh38nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkXg029787;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 66G0vkmo029772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 28BC02313D; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 19/22] iio: pressure: adp810: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:34 -0700
Message-ID: <20260716005737.254577-20-jonathan.cameron@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: T1up7MCgRNxfq2HbdB4DqrqEkFve8oTU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX9g8jARjWO1IX
 AR8GxSJUqHyBqyhyW+Dq09RNr6TiuKbe8P8v/Xnbbv96j64D9lyCI3/wTXyJ1EvPQiEQLuQhsun
 KGBcduoAj2BhZw8iyrm+xceANgsHTsVkHtxINU+2NEGw+qVzW7j+krjogtfqBPMGsdITP1dDCVC
 EgQ/YAhLtCf1wAoAzlPCfpMeFnBRRkNGDcHg7Udzp7DxTHS6o3a1mAPjkVsT9ZPCh+kupDX9Qnr
 Zo/Cv/pC+xzlVxHBstrxJqdIVAgE+zLesnnVdIcT3SMAoL4FpyEjJPNQyZkAZZQt3wXOsd6kSHM
 XRCcv/9rdxV9AY0uVekrxoHtH2BhAvQOih/dnt4yGzCnfZf7QLszBs2QM+golglbRWh4pmAWCHd
 4sjo+JaVdeRUOaggiNqBERGf4uKxUx9yNGKQ+YCe9fvLXIrnK7QPEBwPsLwMx5YmvxajF+k9HBD
 iBidPIOJIZzo2LPT44w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX6YYdG1YPoHbh
 a8D0/Eoejj7cv2M/PbZmCn5JiCTrbwNfFm4sY7XASsHMFbA/rog7gXXtfDu2NxXbmNTelWdqYNQ
 KMQlDNsx0rVQaH+BqG1WkwpszCPS29Y=
X-Authority-Analysis: v=2.4 cv=LbgMLDfi c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=WT4h1V7r81csubEQFhoA:9
X-Proofpoint-GUID: T1up7MCgRNxfq2HbdB4DqrqEkFve8oTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/pressure/adp810.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
index 82aa433548d2..6c740a9383e5 100644
--- a/drivers/iio/pressure/adp810.c
+++ b/drivers/iio/pressure/adp810.c
@@ -64,8 +64,6 @@ static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
 		dev_err(dev, "Error sending trigger command\n");
 		return ret;
 	}
-	if (ret != sizeof(trig_cmd))
-		return -EIO;
 
 	/*
 	 * Wait for the sensor to acquire data. As per datasheet section 5.3.1,
@@ -81,8 +79,6 @@ static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
 		dev_err(dev, "Error reading from sensor\n");
 		return ret;
 	}
-	if (ret != sizeof(*buf))
-		return -EIO;
 
 	/* CRC checks */
 	crc8_populate_msb(crc_table, ADP810_CRC8_POLYNOMIAL);
-- 
2.43.0

