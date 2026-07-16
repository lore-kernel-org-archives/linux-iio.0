Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F98303C9C
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163472; cv=none; b=gUzxjNyQM2he37YrM0MhuZXzm5HhDLBhit9loc6A1km8gitbP2UKzZLhsKsPyz3anvDZQU+anNNPJWC4Rt1k9/89A9iYpcvc6FEvoAKzXfw85VGz+7prSFjjhJWNqvUOxj8M67AdtsIpPHRT4Jt6Dnhyd30VqOu5QryrBJpu3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163472; c=relaxed/simple;
	bh=bcbLcMCt7wE2FTGk/bjg6V0jmgdZaX1jslUjVeh0eOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blf7gMUTVCHqu4VgdACHP3zpC6FjMEOj//7czPUBo9E4uuhuNTsmW72ADIZ4kJbKXu4yQzwcXcNK9l6PiqXPmdb8C/tYGN+OngxMkQO8mUGew8Twmy3UdEw3g/5ngZBQrnqaDkIiWSqwingtNIEg5X6HAyRL2JgI4kfUc2FZ13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwVIhBB7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwVIhBB7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XaMv858365;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=q0v0bGTYCh6
	cfDRDUajspjb0EPstN9KLZ96kLepgHx8=; b=NwVIhBB7c39VvmcCJsS6EGbGyCu
	zwUU9cRPRvR6th88gRBHoIVx8+S8G7t7/cKVKqg/ZsqBZI8IdmvX53l5OBEboO+G
	yps3y8Ahw35icg2ym3Qs4TQ3037aB5YlAawklWCpCwLQz04suW630dloUZ7EHJpJ
	YXqswnrA+J83LGZGG4dcfoCQuhPa7Jw2USwzNYoBoeV7+vEfGDoNIOTX6qaus1zm
	sb3QyKls5Vi1jJclH9HKJVpe4B2EDc+rscAAuv507PdjX8YxJsXVr/QJC0K2tp1M
	zUGIy0DXrkp+BK6eux5VIqCaADmJAhXVQy86bwbaDiZcm6ZU+/O/xlCpI8Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed061xv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0sqUK026726;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4fdygh38nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkb5029753;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 66G0vkd0029751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id DDED2230E8; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 06/22] iio: chemical: sgp30: Remove redundant i2c_master_recv() length check
Date: Wed, 15 Jul 2026 17:57:21 -0700
Message-ID: <20260716005737.254577-7-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX3W2PWoMuMQgD
 q7vE9AAglVCT1PKFmtk50GswpUs9LxDnI6E+zeaz7OTEvBxKvQIiZvtvfNZdAINIXdyZQrmvEgd
 nhiG2gHyNrQMq1HGGnEnoAfJyiLeCbg=
X-Proofpoint-GUID: SV-Dy79cz671gote2JrN7DpH7hRHFnJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX7whF77OsNEyq
 jxK2xH6aLtZJ+CZuRCRm09L9+FDd/6Ih8W08sNeJzO+TKBZhV4AqTDkK6AKrsz4ohQpO37l8nBu
 RIZRxLoLAbZOWkURW0bRAr2t0QNoI2QxJBU2ftHXJRQ0+7DlkJ+5dQptd7e4C7FuxC2FAVOwanM
 xo16+2+qP3lM8ANvdEdxq7ZYpiBHEwGSo+kItF5f33CRAJiKU5K/mF1iJ4qxuOeEG4Rp0bXmcnj
 ix+CfN40YYavMhG5UTB9pgxGWa+zBtWKCh2db5PhmpISwjSFXyOmN27YE2epSgEX41K/6/Q4vHo
 g9KRhPD8XJqelkKwVInsPLGifdXg+p9fO2GrtwboUpr48meBhg6OXFT52MH7xMReq8rwsM29LfH
 B19/wkgGME2jRmPzFo6mzYeatgb7savpp+IWzgA45PUWzizuaqY36kEHVHjamB5hw4QimpLahTH
 9z7eaWTy5qIcY+qu27w==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a582c8a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=u3kl63a2LGnudDzMg2kA:9
X-Proofpoint-ORIG-GUID: SV-Dy79cz671gote2JrN7DpH7hRHFnJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_recv() returns either a negative errno or exactly the count
passed in, so the length check after the 'ret < 0' test can never be
true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/chemical/sgp30.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index f10bbebc29e4..8152606c6495 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -254,8 +254,6 @@ static int sgp_read_cmd(struct sgp_data *data, enum sgp_cmd cmd,
 	ret = i2c_master_recv(client, data_buf, size);
 	if (ret < 0)
 		return ret;
-	if (ret != size)
-		return -EIO;
 
 	return sgp_verify_buffer(data, buf, word_count);
 }
-- 
2.43.0

