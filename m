Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337C225390;
	Thu, 29 Jan 2026 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710521; cv=none; b=KdRf5VyVIboDJZzIqaouuBzW5UbWDeFGhE4eVrHeJTjFN3s2D9uhRe3r8JNk+ttnqzeLQ0jTBQyT1id87k8hyomwTg/EvTRKf5eWhwteoHPtKwYk6bec0oBumVMFn1Y6oNHkPUlhmupkUjBjMYAyyoqeBVItEWvBUOJvfQT7wUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710521; c=relaxed/simple;
	bh=s8u98sPm1ExILr4yN3ZM0JLZXWdlzD3k1bgzVwYHDJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRGF3N9k5Qum8mA5Ukrm6xE3naGzLsuVdxSeZlHWwQKTrzaB0TBWVj7/famMKNngVdHYu1c1uG7BE1qS1PBBgGW8HZ2K0tZf53y77pOngYKAv5xa8zT6ImTNwb0vgSLRRlHOPzzxKAYD50+FnBKYYDZ21JALEsw01C5oLaMWkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GTSCclQJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GTSCclQJ"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60THkH0W2946343;
	Thu, 29 Jan 2026 13:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=517dUUOgFaeY8BMvrrJ5wfLWKk3
	jAi7XnNS5XCnLKXI=; b=GTSCclQJJL+yhvBPZbFIuHH8Ihi2piaJCTTnMVcL5n1
	0aoSMEjhwcb9pr9vVBy4ygUq46rLB3OKfLnn4JjihpEGToqr0ZGXt/aX5Z0ntEQn
	MQidhqSRRUc38zgD1imPRZ4u9mmMy82iWWeHKDnoYGwDfSIMD+spZyRMuGT0oMNN
	wGcvOUUKoPujN9fMCqDuIYscVvuFL6mBwzTEZ/Vj0+Y8sjroGMsyE5TEKapbfP6P
	UdJw6O7SSkSftq5WErbo6eFbOKWIBBHwTkVcron93upW9skQdMjjm5iDhBzDeopW
	3NbN9NbdG3I7krv83daZBZoLLBMUykcgn4I/yovLUiw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c0c8a034u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 13:15:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TIFBTn061131
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 13:15:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 13:15:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 13:15:11 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TIEwv5011036;
	Thu, 29 Jan 2026 13:15:01 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Petre Rodan <petre.rodan@subdimension.ro>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2] iio: pressure: hsc030pa: Improve i2c_transfer return value handling
Date: Thu, 29 Jan 2026 20:14:52 +0200
Message-ID: <20260129181452.57628-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=LPJrgZW9 c=1 sm=1 tr=0 ts=697ba3b0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=fp1qgPpjcrRE5sl1YSkA:9
X-Proofpoint-GUID: PzUNGbRToG1MipzqLj8dLjNfY0V_jRFw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyOSBTYWx0ZWRfX9iOck2GcUN7n
 Ud4XT/ROBbpkbYUPPfij86vCp4sTyxTQbegJL008zTHRr1puZq/UDGRIf4lrqwDoutWN6yvAcie
 riqzTMEIJwKISjqKvuF9uAh3Ty2n5WU7aQYYPeq+VskEZz5CcrgeAZApbZIGOrKvsqEkxinnR7i
 09K3/Os/S6f7oV7CdycY7HwogzP/tIg4OAe+mXUYZQwVK5HBsP3VkcZhj3vOoe5Q4Z+DdWxcCJw
 QWlKIajw/fusYs6E5iArrx0CcpUqHxawt07/PDNg+8zVxqwDnYa+EXLMrrU/gulFsD+KAFpHpBS
 Scgmtu6P83ksPB2/dBhrZDb4sWrrx+C5RpgZEZ+hESL8tHF8/YZ0fbsGL163Vaxg7n4ebLpzTRO
 JvtI5Zt2VTF8AjIobJT0KQumRaVUEd2LVk93ZcvtyhIphwZnX5j7k+r8pm+GRRI3QrCwvvdGp/P
 qz2QET62g/9Xipa4N0g==
X-Proofpoint-ORIG-GUID: PzUNGbRToG1MipzqLj8dLjNfY0V_jRFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290129

The i2c_transfer() function returns the number of messages
successfully transferred. The function sends 1 message but checks
for ret == 2, which can never be true.

In practice this has no impact since the caller checks ret < 0,
and the erroneous return value of 1 is not treated as an error.

Improve the return value handling to properly distinguish between
I2C errors and unexpected transfer counts.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
v2:
 - Changed subject from 'Fix' to 'Improve'
 - Clarified that the bug has no practical impact
 - Used explicit if/return pattern instead of ternary
 - Dropped Fixes tag

 drivers/iio/pressure/hsc030pa_i2c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index a34ef4653f34..3500bda03d75 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -34,8 +34,13 @@ static int hsc_i2c_recv(struct hsc_data *data)
 	msg.buf = data->buffer;
 
 	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret < 0)
+		return ret;
 
-	return (ret == 2) ? 0 : ret;
+	if (ret != 1)
+		return -EIO;
+
+	return 0;
 }
 
 static int hsc_i2c_probe(struct i2c_client *client)
-- 
2.43.0

