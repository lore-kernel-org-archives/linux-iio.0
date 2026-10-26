Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055969;
	b=RyS94MwyPe+DYqtafSVoCG3XGxBuxRproKg9aie66LiynEtBv6nw3Ivc9Zcv8TGkzxW7
	 mejTA4K7DwS6c7SxfcafbkUUUXrFZjfzMC2JAyBQFJQBDMssQ4uNcSXI+r0QIpWL9QZ6B
	 /4TYSAkmdT0R0nF0gUP0lWs74z5C3KoJWzgWK6dkJAH4XXzFtZmWrBYGBvoMX/zds02ne
	 yFkqZS1thnerLqWxn0yW5NtCGUivVLfcjEomMzgSzaTtKcdMxZ1JC+YJTVL3wHZsMGw29
	 IBkPO+wwCXXtUFA9XyPKgky00Qh6S1DBpTlyEI8cW0wibBcsCNuJAeGfCVWiNnSuyJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055969;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nE92o3aVVeU9a2p1FRcEtepBik7LPlFci5bMwi1HUfo=;
	b=WeayEKXQxdbgEJE6ghRS9UxVCFfrwitE1+iTw2fPb7ax+EQLMjXXbpItNUFl9tUrw382
	 VOBLpzdJerysSCk6U5ATZDRS2iDEALeLGlFQNgCp1aHTOc82VToWry8oQHCC3EiwiXZ7m
	 /WEDMCkvsl9uluYzf3IJSFZNDWHAGVLpGenlBVbzwDTVpEcvdtR0feu8hQ1UMjcbgH6va
	 QdZixEBWFftuLqbiISKYJsxjkl200AHl7+kpVb1T0OrnN9s2Va9Brda0oj2AKYoWS/DtU
	 sgYJVLWYSXQdD8r+XEJDMyIvU3hB7gQjHIJlD5+tLkHJ5/ITvBL39LmJwLzgtwlHeIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n2i5yRWW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB62606A328
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB62606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n2i5yRWW
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP39p337835;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nE92o3aVVeU9a2p1FRcEtepBik7LPlFci5bMwi1HUfo=; b=n2i5yRWWlmaHKOQM
	lb59wyCf2ZYGPjqxz6wPpq3NzjCL6Xd2/gOSb0vuJt9cynIY/1UT/h8sfYE5qmnv
	cpf1DjCwLoQm6+ot/Bfm8oMt1r7Lyil9+W0wEK67BnvJDovHMLH8tVSOOeaN6HEk
	THydcse7xlOJ2Cog1xoWWGmtJXd6SZJlByqJBAa04BsGynX0lnk+UqaWIADNfG3f
	h+E/4LH0LUxDx71qKkK9BDdGs7bJbB9NqnAxFVRQe4hNmc+1tvI1oeeTROt3ge4T
	j8vvqWNMncvudf7K2j6ZYWqpKqSFv06IHMg23Xk1YfV47j/xKUml5p+NpyQwRD7e
	FbuKQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y2pen-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN619Q260028;
	Mon, 26 Oct 2026 23:06:02 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN61uX259949
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 91C6125613; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH 34/39] iio: humidity: hts221: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:52 -0700
Message-ID: <20261026-iio-v1-34-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX1HKetcRdtC+v
 1IcxPB8UC0YJkf1SZfp1aFIC7oVY0wVcCzgxqKqS6IdrGyC0G7vxQjK2FY5QayHewFQEMq27zVE
 Nyihdx4lIr/awCieb0RfEqReMBdh9Is=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=YpVTuPmpArgIEkHdFDAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX4kDJpAi3Y7Q7
 MZGnPLzSuWjoSdoCqE083iVnNqmnuQNDE6WDeTYgnZzAT1K3ehI8DypOwVHf2/2Cj8d9+rJUm/l
 dxluZoUuFxsUAlPSt28KqhwBqd9EKAGNYKT84F0Kofo7GFtvNJfZvSUJoNYfGV+sStxNOsB5ZDn
 BkD9p9FlTHKUHSl+HsjxBpkCEWTR4OM4Oqrp0Ha3KKytymyrWnJFPRULfc/zcNfc/TVm8ZONL9l
 RnDowcVvZJASLyPFMR+b+bOQmc5hVeXb99i9f3OaNinTAB7Jn1laVGyOVp6y4w1teIAFc+OjJ0D
 21AIMKrDE6yHbemDH08r+YXIk18Kz0PKEfTkvFR3lKszRTANr7Lti0WpXwwyWIOQsWRGvBqFgn6
 FEf4F6ZnyVdO9MIQe8dPoFgCACjmz58ckaWuWp+eUuiamNOWlCbkFZGm34lwTmslduP9WQwz5/u
 jH/D/AOmPKofXb7cZHA==
X-Proofpoint-GUID: Ls4gKgASuVo_FrsvyN3IJUQaO0_UySDi
X-Proofpoint-ORIG-GUID: Ls4gKgASuVo_FrsvyN3IJUQaO0_UySDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index df12c7a25b2e..25e7eff0436d 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -179,8 +179,8 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 	if (err < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
-					   iio_get_time_ns(iio_dev));
+	iio_push_to_buffers_with_ts(iio_dev, &hw->scan, sizeof(hw->scan),
+				    iio_get_time_ns(iio_dev));
 
 out:
 	iio_trigger_notify_done(hw->trig);

-- 
2.43.0

