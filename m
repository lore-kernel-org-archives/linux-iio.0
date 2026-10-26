Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055972;
	b=hNTDQIrGHWcMeLlusG2IFmn1ls/oxm1v5crFGg+egSE2UBbrCrWHEP/IVehLKh7Cgp33
	 2c+6zmRDDKXx7NRkhin2V5NTKic1Umy16IXcfrSpEXoUIpiGJvw/PV/m/p5i8MsEzs55e
	 KiMexZAefftthFM1tNGFlAPZaF1gJisnaswXZI2dk5yvLoeBTZLpggDnsfj90gXE+BCJz
	 1eNTbyOTfmEvGuSaV+zGsDB8yjlf8LhKt7uzABh/AohK+zVa3pg7GGL14F8X4ZFWvFBXm
	 oRpfiyzyyL6SwX6I0KGX4pzjxp3GHhC2FUIG9lZorwP5aW2MNxoCB2pgeK9ggcN0djQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mJb3JH6Es47CodMrchuscdCLNADedn+GeOUyw0KBtH8=;
	b=S3KzihkCFbWdR1dtDEAnSwH4v+aDthYw+lXMVuXosd9OQTH8cw0y1ywDOw88IU6GK75T
	 aT8/AWHpjT72uHnsnYNavwAZH5Xew+uB8BBNyRl5jnXLMGQZ1yM+/QkkxecR4wGrBI9y/
	 LBfG1O3QkILldS5xVBQxQvroVWFFAWIR5uf+8mK+4YQqHBCoxYNBK/iz8VukF6JTz4kt8
	 Gz+JdZVy5TnBn9wKAGVCxkeK7ipuDaHK3b3lzy5nOYLu7d5F+VavZeMqHwibr/sUZXQD3
	 MzR5eCVJSct/rhHUV0uM29ZAEeHzJQXlioJ+/054pQm7ce2GAiZLX2KVMSKBv6aLx8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FxL1nMxu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9B606A32F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB9B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FxL1nMxu
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPKrd3043075;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mJb3JH6Es47CodMrchuscdCLNADedn+GeOUyw0KBtH8=; b=FxL1nMxu4lAxHCGn
	A/03N9K1fuIM7uQqGSk7gVMVKiEgieG19FB4KW/gESm6oleUKy5kNxTcAkdNQAgC
	Ywg251stRbj1rJYVwhs5dh5Q4msSJTLmPgPxSVJ2y+jK8hJ9y3I752U2QQ101pKg
	9gaKThKdCeGSRzNVBpmKYc4rcZuLPIGaXoxM8Ri2jk9ROwPpgrYe/RaDUqYGn/4t
	J2Xsp/nsPM2T6w6m30uis7CB+KLYCBroqVdtM2cV/p9q2RR9ZjPCObDvsByn3pJ9
	HMNqpkPE5RZmjyJXtcE2MZpiTrsVye3qjfJZGP9A5d/Ip3082SnorlBMCZKCYdeP
	k7FvXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54h4hq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61LE104522;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN61KG104496
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 03C2E2560B; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH 10/39] iio: pressure: mprls0025pa: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:28 -0700
Message-ID: <20261026-iio-v1-10-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX0QFqXCcJBiGo
 1mq6dEepQcPlGKUusKey8der1TgKEKTBdtPxYRMnYRLUvKTZQo2UtTQtjvp2X+tN/PEIVXnU5gd
 wMMmxRqjBBafpON2j34IGL/uLErbSBI=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=hoZy84-OS2_SNqNIM5MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wDzgMGEjCL7AxCmsslNchocPb1GNOkGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX+849zyyotENG
 JpITQtungpGlPwMpwP/ubL0Nv6unMXWDxaB+/QaY2cStqbJZl27OJzZ8X5rypgIZfdy+FDmjj0w
 Eacej3hiTM41ejCZ42o3gSRpBB48dlXNH/CqSm3f5ELELLpjdA0K+H6KPObx81C10keKJJ45q+D
 RV5zRxUNr5NpbqwuQ/MsgJc7SkE2tz9hDgYqOfHlLEFmyrjDVdvjdkt7JgdarU9AiD6QG7YWhef
 eMPRVC3+q3ZA4SZyMLVsWA/L2Z4Nfe3LpdktX4PMrbVeq/NOYQTw8rLeXTRP3z7KSKSvOMKFc3O
 s1Utha+ONPF+Xfc/uPIRSK0TcvUP6IWl2+m/xV2M2wJgoQwt29gL3TcSEpyoGkOe18WsvJwC9Uj
 bYbR/V4Xhk+yjqaUTRsIgH2/zP6Ij4BrKu0Tkt+R4co9FJbwe4Ai1iIQ8v7kZCdkf3ypZZc63B8
 2Q8icd2ml2HKLIXu43A==
X-Proofpoint-GUID: wDzgMGEjCL7AxCmsslNchocPb1GNOkGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is a structure within the iio_priv() data.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index c21f0a050660..1454c2837077 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -277,8 +277,8 @@ static irqreturn_t mpr_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->chan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->chan, sizeof(data->chan),
+				    iio_get_time_ns(indio_dev));
 
 err:
 	mutex_unlock(&data->lock);

-- 
2.43.0

