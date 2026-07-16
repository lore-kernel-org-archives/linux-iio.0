Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9030C360
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163477; cv=none; b=bZ9XpVtiAeRacG/zVb0wkzDmolBUbNr47+IeXAHh2boeThb2rpseqq5TvxW/IF59nMIrr9nuMbLjYbge0PZE7iRY6EdZjxDFqAJl48FHFNz/z6QQNRpUKJrYIPTwd1jYeE80b3Ne/l/w1vDx+rZiAjtm9VdIfk+btwFCChf3nmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163477; c=relaxed/simple;
	bh=8knMdhht013hDVovR2rDKq/pWJeyPrqiv14PyP7GwxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3n+kRnsKOm6kC9p/ZaqAzM/zzxwEG3FvKYvaApfwa5XvKagj4tlXBewKJdv+oV7baBpuu1YGky2CxQsqEo4UglIcd/fvVpn7JZGp4lLJh+FJiObeR+XAJl9w8a8CMIq1cOlQjPVRteRL4rFPT6p1of9h7KJmRdnxmEzBr/NfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARuwv8B1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARuwv8B1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XZ551005040;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=P1n9F0BxjfmNs3w05AdwgDrUfIDjMbnQ8cI
	GWG5fig4=; b=ARuwv8B1WLhuhsu2DAeG6xfgZXpSFJEwB4ZeFxCa/ZFAPncY6JO
	S473umZF+dt3GKWlkKvCbjDSgtk6GN9r7q59d8vBfaf2oHcGVua22LMvhqrQOSLI
	iF3jBwp0y2mjJ8cngZC1whW1WZFTnxN6ia2V5gmzVCQSvbqJPSO/TsLaW6BFbrZt
	XESX81wv75OEkn0HIds5JJG0Sk7KEZia62GOfEpFT3sXKQAJTPe8ubK7oiaZ4qzo
	M/nsj3CGPVOJ4HfX1DiZ2mgjivyVS1TiR3xAcw58yoP7I8UH2sfLYLzCm3VAUKnQ
	pBQ3ko7M8wNGa9YFftusun+tvjERAPDx0rQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecny9ybb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vku7024328;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fekujghv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vj1r024307;
	Thu, 16 Jul 2026 00:57:45 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 66G0vjCo024303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:45 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id C0C0F22173; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for single transfers
Date: Wed, 15 Jul 2026 17:57:15 -0700
Message-ID: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfXycJERCSZZFp2
 75ZcnUwlxr1OAOZvBKcn9mF9sjAbYWw9i/lSh4D49ZkmGB50Ay6MKbVb2e6T2VqyfZtz42uu7dg
 cpQuDCIRyODc/qTK6zAaVxdB1e1VYwA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX6cofP5Em2/Ux
 wBMwaPcTPSjrN8AOdNvN6IXAq9Q8d03z10XbjebBn4kLytp4IUP2R6DIL1tIrs4UuyS+7mZHj7F
 TZIsdUkZJeATgt3Uv4bKt18fFqIMHN6E300870doZiSBjdJ2vs1mJHdlMfyWrz86Fg0Q69azvyA
 JS3BD7x/uEWNH4Y3gZpqwRnill++3tVNY0FOzVBUNehZSRbnDs/562eRKa/VWkkm2r+v7oJ3oEU
 T1PI3YyjTA9NBGOnOAYBynBWKF+lkgoo5XDVkMJhuIMOLhFiBMXnR81gVRg4QR4n82T66V4pJIE
 YcFE/hdWWaImRgYRgBVTlUmRjeqMZJ8IU6xSKz51bA2/ZarsW7cFtpUJlm3fwZ5lU/zVrSEV1fG
 qFB6TZxH2vlsVCaT6tUmCwzB0+OQVK3sl95GhDd0pqecRh0XEUa+l0yax3dBYra/awz90GFFgTk
 xkSuLYcAep+f3oI9BMA==
X-Proofpoint-ORIG-GUID: -n7LBxApvK2OIOAQvY87oJk5Fx4Anfuy
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=8QjTjfFf38wHmLEJvXoA:9
X-Proofpoint-GUID: -n7LBxApvK2OIOAQvY87oJk5Fx4Anfuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160005

Resend to include linux-iio. Sorry to all who get it twice.

This came up in a recent review and I realised I have been giving incorrect
review feedback for years. Both i2_master_send() and i2c_master_recv() plus
the dma safe variants only ever return either an error or the full buffer
size.  Short accesses do not occur.

This series (also my first upstream series prepared by poking claude)
removes the redundant checks from all IIO drivers.

Thanks,

Jonathan

Jonathan Cameron (22):
  iio: adc: ltc2471: Remove redundant i2c_master_recv() length check
  iio: adc: ti-ads7138: Remove redundant i2c_master_send() length checks
  iio: adc: versal-sysmon: Remove redundant i2c_master_{send,recv}()
    length checks
  iio: chemical: scd30: Remove redundant i2c_master_{send,recv}() length
    checks
  iio: chemical: scd4x: Remove redundant i2c_master_{send,recv}() length
    checks
  iio: chemical: sgp30: Remove redundant i2c_master_recv() length check
  iio: chemical: sgp40: Remove redundant i2c_master_recv() length check
  iio: chemical: sps30: Remove redundant i2c_master_{send,recv}() length
    checks
  iio: dac: ad5446: Remove redundant i2c_master_send() length check
  iio: dac: ad5696: Remove redundant i2c_master_send() length check
  iio: dac: m62332: Remove redundant i2c_master_send() length check
  iio: dac: max517: Remove redundant i2c_master_send() length check
  iio: dac: max5821: Remove redundant i2c_master_{send,recv}() length
    checks
  iio: dac: mcp4725: Remove redundant i2c_master_{send,recv}() length
    checks
  iio: dac: mcp4728: Remove redundant i2c_master_{send,recv}() length
    checks
  iio: light: lv0104cs: Remove redundant i2c_master_{send,recv}() length
    checks
  iio: potentiometer: ad5110: Remove redundant i2c_master_{send,recv}()
    length checks
  iio: pressure: abp2030pa: Remove redundant i2c_master_{send,recv}()
    length checks
  iio: pressure: adp810: Remove redundant i2c_master_{send,recv}()
    length checks
  iio: pressure: icp10100: Remove redundant i2c_master_send() length
    check
  iio: pressure: mprls0025pa: Remove redundant i2c_master_{send,recv}()
    length checks
  iio: pressure: sdp500: Remove redundant i2c_master_recv() length check

 drivers/iio/adc/ltc2471.c              |  2 --
 drivers/iio/adc/ti-ads7138.c           |  4 ----
 drivers/iio/adc/versal-sysmon-i2c.c    |  6 ------
 drivers/iio/chemical/scd30_i2c.c       |  4 ----
 drivers/iio/chemical/scd4x.c           |  8 --------
 drivers/iio/chemical/sgp30.c           |  2 --
 drivers/iio/chemical/sgp40.c           |  4 ----
 drivers/iio/chemical/sps30_i2c.c       |  4 ----
 drivers/iio/dac/ad5446-i2c.c           |  2 --
 drivers/iio/dac/ad5696-i2c.c           |  2 +-
 drivers/iio/dac/m62332.c               |  2 --
 drivers/iio/dac/max517.c               |  6 ++----
 drivers/iio/dac/max5821.c              | 14 ++------------
 drivers/iio/dac/mcp4725.c              | 22 ++++++----------------
 drivers/iio/dac/mcp4728.c              | 13 +------------
 drivers/iio/light/lv0104cs.c           |  4 ----
 drivers/iio/potentiometer/ad5110.c     | 18 +++---------------
 drivers/iio/pressure/abp2030pa_i2c.c   |  4 ----
 drivers/iio/pressure/adp810.c          |  4 ----
 drivers/iio/pressure/icp10100.c        |  2 --
 drivers/iio/pressure/mprls0025pa_i2c.c |  4 ----
 drivers/iio/pressure/sdp500.c          |  4 ----
 22 files changed, 15 insertions(+), 120 deletions(-)

-- 
2.43.0

