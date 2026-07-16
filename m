Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A830DEB8
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163477; cv=none; b=iS0VSzZCtJbBbjhlMXnyFxgMelCTxE+larRRxUlRuRbYuuEhJ+/A4wsgFJpAc4aUtbHVB/KpqKt0aMDgSGmwv6jq5gViN+UU+OXS0t856Le9e7jivFprc6kWDiORovstKBeVUB0xdJG6aWNFL+ngEhNu3ZZvwzpTe1JQujiuvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163477; c=relaxed/simple;
	bh=0zBWysmDS3IpgC0EZsIUJFOoJuRpzCkT6uVnPCSv76c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaIJzjhvsbjPkycx4NZNTONT+rY7mScDsSIUFsFRY9TaC+y0F6rJsNZDXQ6Fq/pJ7ygZbqWNGygdENybBWX/bx/Q9Qi1mNLM5dHpCehSHrzMG0eUST8C+JNryAjY3BjMl6/axn+l0uzEJbAKwIR3BbMpGjyQX7wtVLYqK4EPIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dWT8SW/v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dWT8SW/v"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XapK1005044;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VbuXyQfpVe/
	t3AoBTPHey7XOtOLRpa+Lnl0k08fSGCw=; b=dWT8SW/v2eqwF0yq31dktgrftKc
	jTW4t/KMkWh+gWhces7WOF+uDHvOBNdqFZ1iA/KmUUCOVPKT/O5y5kSIEylxHWIX
	ncTjuWseuNmPxvvJy1Rce7Fz6RJxkxeWn0yOKdN79b9nfqeiEmzrk4zU9KZd9dNE
	0JVpmixAZa5f1BEEVyvM3ma5vNxkTULh9hBn1ApOeAivqVT0gxYYNDVdc043/4ot
	N6+eRNcmyRnmJ1FLBL1rtvccYjlk8HoqmDHVBSnbiKTTq4lJVz/dUgZBVMnVYpZM
	CEOnme7s34a4Q7GGsQcL4RDtxj/NpZTU4B6lckQUyqjrGqKgaDwP2CkqK0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecny9ybd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkox018879;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4fdxqmbjgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkxK018867;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 66G0vkRu018863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 0C0A7230A7; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 13/22] iio: dac: max5821: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:28 -0700
Message-ID: <20260716005737.254577-14-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX+LQHIe6XCDMt
 89nk3F1Mc8L1STx1QrTKlkzdMvCDeYGBSFcxkT1FkxIVR8iWRMhBTk1+4DwYTcubkeOLywsh5Co
 vfRX5abnBBUHyUD4kDc68csdfxQeEk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX5DM5XTxA4juI
 aai4F4VBSiK9/eCDG3Wcb2MLSbsWDkoQJyvLfcaBgk/MAbNdY138VM4JGTJZhcEtUxPf5C7YjTj
 nGuDAUNj2oZr6qUQ8/JpfYR6ZTXNeKvUfvhau56axB3nWd+z2SEq+9PnspovQEiqwP314YrwAGj
 ObjJkQ61SLOwogjB4w2tWQ0BX97mOuX97Sr2oHMdYvxIEI9tp3sh8MX88ZRc87EtcqgEs2KJLB0
 NBARds5Q5uNavgWJtrIhCCoiVtdmT/VuXasoqmx1azhdlnoaFe8sAQaTp1Hwq4xnJeHZd0s9huF
 WhXebAOJW2/48fWn0+Au9mk94vOx0paROhoWly2jgA5IbDDxLh+EP+ydreWCclNL1fjlmd2iOM2
 LDmfJVDrRoQBIbLH0ZuymhrBtS1gKW/L0h6ja6VwO4NzrhjA1brmsMAPEJAYCKe4xS9hktF2Tak
 dcXvvRVHJKhveiZ/yfg==
X-Proofpoint-ORIG-GUID: Y3owmKYJUVLTXXT8KxLBXP2tPWQG35jh
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=13e-U4lxJibRucAb1fcA:9
X-Proofpoint-GUID: Y3owmKYJUVLTXXT8KxLBXP2tPWQG35jh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/dac/max5821.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 45def245626b..fadc37eec999 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -103,8 +103,6 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 	ret = i2c_master_send(data->client, outbuf, sizeof(outbuf));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(outbuf))
-		return -EIO;
 
 	return 0;
 }
@@ -188,18 +186,12 @@ static int max5821_get_value(struct iio_dev *indio_dev,
 	if (ret < 0) {
 		mutex_unlock(&data->lock);
 		return ret;
-	} else if (ret != 1) {
-		mutex_unlock(&data->lock);
-		return -EIO;
 	}
 
 	ret = i2c_master_recv(client, inbuf, 2);
 	if (ret < 0) {
 		mutex_unlock(&data->lock);
 		return ret;
-	} else if (ret != 2) {
-		mutex_unlock(&data->lock);
-		return -EIO;
 	}
 
 	mutex_unlock(&data->lock);
@@ -230,10 +222,8 @@ static int max5821_set_value(struct iio_dev *indio_dev,
 	ret = i2c_master_send(client, outbuf, 2);
 	if (ret < 0)
 		return ret;
-	else if (ret != 2)
-		return -EIO;
-	else
-		return 0;
+
+	return 0;
 }
 
 static int max5821_read_raw(struct iio_dev *indio_dev,
-- 
2.43.0

