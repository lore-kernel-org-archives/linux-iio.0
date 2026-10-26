Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055975;
	b=PEVz2Omxw6foOBq/hG2evk12w760Knqf4z/l+e5cuQSMd56shLG+qGkRPNsqhoVzxZ/R
	 RO/xvnBY6MYT94dJZ6BwXEHpFMlsZix9Er+87boMVruIppMmS2h7GmN5PsfHPeUDYXG05
	 M6jZC8gMCMe1b3BBPX3jRE2vRsFduRSLUhLJgfjlMemSKgGQYrk0jcoQa++1v3L7Vea+b
	 tmXc90SSWStY2LY5I3cnzbOKCUSowUqFoD2k4yAvwflPNPv2+rT8jxBakhmQCtVWKVZqQ
	 79wp5hto7cqHpvGSmrzJW65cYrjKRmJsQ3hQap9QoHY6LeNsuM8mlnUIxZO6VaggMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NXNXQS+4dbRpv8GvWqEnvYJzCZc9oCYqNPU+V5/wXkI=;
	b=Edu0n/g1aVd2i6JYzkBqoj7pp4BpjEPsdDHQxtn1rS+/XX6CwwJj01EOu4e63r/APZRp
	 /174jFxy/aAx5wnPAA3yV3ykTO1fQ3VWmMaLMiWqPjdDCoKKHGB0UnqFeZQn6rng1qQ4M
	 ygHPpNfdz/II3x1KUumkxsdPwaeiQEZX8kOnyxQYGKCLfUhsA8MWP4R6XiJ0IH15iRPqq
	 lMMb1BPdo2S4U/s6rFbndsa5Y2AQgwdG7DB/e0VSB8ydZMv8ClQDbJ6cPZwHcR2McHJuL
	 SlYH1nl/1vzMREmQakSnVSPw5TBeWgJ0X0Z/O7L1Arhw3es+uFW2J4F5+By2ib8HO9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NyzCHUiQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A2606A337
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61A2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NyzCHUiQ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOrol3670941;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXNXQS+4dbRpv8GvWqEnvYJzCZc9oCYqNPU+V5/wXkI=; b=NyzCHUiQLUv+M/YQ
	UgejFtBlqRm//mcOngTJVDmqJP1p+SuA9ekEWv2gDhafC6kcmfnB+eLZI+INw9b8
	nLovuyq6S7W6PdUiOeBLEXKePYwaTgF4OuIstqYpmsLgGzflkRC3OOUEuWvY32Zg
	vem7ujVImx0rR6HMpG5bAguq1Y1tXA0MDiK/N4qybtVMK1MiNEjpO3DEner7h1q2
	nEtrN/5snYfIOMvgYY90Wy5fpG/v19FfvkBTI/BbwUmAeQpQp4rEXlA6alBA2B75
	S/Tg0joxpTuW349ULb2IM/gr9GgGbh9FHD/jmImiDU07tvxi6GPZx3OLELqS08LG
	9rCZyQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u632e1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN21Ne099126;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN61Nw104494
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id EA4E2255FD; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Christian Eggers <ceggers@arri.de>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 08/39] iio: light: as73211: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:26 -0700
Message-ID: <20261026-iio-v1-8-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-GUID: SGszZl51lqeN0nPLEMpJlk4IKS4coNWt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX+Kpx6D2PPLwf
 eL98myadg39GZqFXz+NCJqWyqcSYUxBRErlJ+HFpck9/aY8ztGBPjuTuqBoah+uqz0KOqsIMwvt
 3+rNKgdNVYmJb13bZ8VIZC3Wfi1IjYyGRyxHiX3EzclM9VSXNYJ5mC2rmTnqzfmgCj1FvVSJQy4
 MFIBfsgD5XogntIqSx2ejkSMryCHcJV6Qq3jptuNpC1FuE2PUuPNHzhnc+m33Xnrwmk8un7qwCs
 xgyX/Ezq+nCfs/8eW8uZ0JPh/FgcfWBszd5d1Ss5Q+B6DEplDd2J86DzRszURCcZDZrtI7aF+ur
 v7II9QGEQnKZdz072xPOI/aO4Me3GiZjrneRuY0UjJDweGapYUz8rQ7XhsFvig7fkRrBueN9pUK
 IF3BUTtehR18vEHpg5DZTLhHfU+SL4COHWOQTQR1tyAGuDZZPQMtsiEXkADV6jcgfXfFiIIgnLS
 M5tIYStXMoCMXffHqwg==
X-Proofpoint-ORIG-GUID: SGszZl51lqeN0nPLEMpJlk4IKS4coNWt
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adfdcd9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=OCfo6LdnTK7-VkqIzwAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX5mPgRdOO0xjJ
 2zQKN7ftL7KxuD9Ku9UUQ11sDY795aYVGFTsCwq0DXA2h3Wa3fRRBRyU4yeYrMAkboQsnlPrH2j
 bCgJB1ivjmrhBcRXllA/1bnqHUdEqAE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is on the stack and local to as73211_trigger_handler().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc:  Christian Eggers <ceggers@arri.de>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/as73211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 67f33bbe1c13..675866029cd7 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -695,7 +695,8 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	mutex_unlock(&data->mutex);

-- 
2.43.0

