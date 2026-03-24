Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FF3C5DB6;
	Tue, 24 Mar 2026 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336485; cv=none; b=XKWOErindNqyQfae9nkjdkWMmQ2XPwK2I18Uxpw0zvLGisgSpZSdfXiojoT9BmFbgYd9394AJY38J76CYKM/eIIw0FXi1DMMO2eziUY8Q3erdyEVAGYeMv/+b7lPjINK4umhrw92RLPxWGbgsD93Q8bub/Qu/GzcOZ3gf3amWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336485; c=relaxed/simple;
	bh=+e6nOmqNX4Ruksbj+JmHXm1wd/Ny88rYcyaabwPylG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBIhBY1PXUihZrX/d0BYVnN9tr1K/cT/6mbR9Mzk6hEKnqUIzw2naSbZuiPV7WU2+r7TjpI/LosdGDaFbW1g+78zpk9o7L+rLh/YYfOo4Lv2tD9oLolMBMTkxUgNK97bhZVV55QOmyyEnlrYCKBf/0dJx0eO8cs8vQTFEv/DXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oM/yhCXC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oM/yhCXC"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O39MpO662586;
	Tue, 24 Mar 2026 03:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MusJI
	pNrc4l1O98qv/J+ypUbbx0xIbFFtj8uaAlNxgA=; b=oM/yhCXCbfdOdVG36xGR3
	j5i3qmsIGWvLbvD3ekKyrTPdonkqwVDO25efMOfqoCQIBvp6TK3FBYkVoj6WKlMG
	rs6qTvvpyIrVZEULWoNTLEeQwbxL4GWgKQjcvHXvlrZHuSa2JT+IjdY6j39caBrD
	qMjBHWYL42G26orCMHcQjwWz0/lgg/YDSWHKiIxNSH4HrG2+TCqVG7c6pBa5Qbcy
	QazqztzS4qxB9fZj741ezw9mnCeS7ZqeOAIg3+3oWEKEFCCX7XYMmsfLQuxXD1O+
	PR+w69ziKqlwPU2zsAuI9OyW0RONZT9I0K9DbARMkYo5Sl++xGXRkacN93hXrDCn
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1n6239a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 03:14:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62O7EAlJ020241
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Mar 2026 03:14:10 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 24 Mar 2026 03:14:10 -0400
Received: from CJONES7-T01.ad.analog.com (HYB-jCCu8MOWEgi.ad.analog.com [10.116.223.230] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62O7Dg0d003654;
	Tue, 24 Mar 2026 03:14:03 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Tobias Sperling
	<tobias.sperling@softing.com>,
        Jorge Marques <jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] iio: adc: ltc2309: Use i2c_get_match_data() helper
Date: Tue, 24 Mar 2026 15:13:29 +0800
Message-ID: <20260324071331.842-3-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324071331.842-1-carlosjr.jones@analog.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1NyBTYWx0ZWRfXy681p2lCrdto
 KLRouNpoIjPPn7GueGHlXxQq+Adk611F/eqP9zTqCt+HIxISx1HTD8AVighXETj2wSRt8FBR2yW
 e7d9U4gBb6uhdcYrmhcAn4Y9cSR6A+mtRc+qAA6lFLz5UtWz/PDIt5ONDrQpgxn9r94SPxtg/B3
 GKZ5aYsfqroI7lfDYqcSm7oAhT7lfKhGnj0ZaDr7ENsJxMvC6daRlSL1TR/fgdpUwtOyMuSdiKI
 uX5uRgLjD1p0YEpTNEmvuJGudPuXM8wtI+PnM9gybDMBqwivR72zwfVmJrm7aPvqHzEetJui5td
 sJAVx2ur88evA7dVRf8hc9M1YSxS9WCUDVE5DPyol9PFJdzonT2ClXJnc6Iln7q9tykXwB5zayR
 YicV6QBp2jUtHUJ2ZHD6iW6NtaWkhywbrSP5rro3DHsud9qsiwOXNwEJ0KMXXUAMvFuFRCv32wv
 e05N/Nrim3cif0v3S/Q==
X-Proofpoint-ORIG-GUID: 7dY5LN3GHV6mAJmf4aG-jjkJj9TmXOIz
X-Proofpoint-GUID: 7dY5LN3GHV6mAJmf4aG-jjkJj9TmXOIz
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=69c239c3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=QrCu5fVgqlF5A00fM60A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240057

Convert the driver to use the i2c_get_match_data() helper function
for retrieving chip-specific information. This simplifies device
identification and aligns with modern kernel practices.

Update both of_device_id and i2c_device_id tables to include
chip_info data pointers. The device name is now sourced from
chip_info to ensure proper identification in sysfs.

No functional changes to existing LTC2309 behavior.

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 drivers/iio/adc/ltc2309.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 0644b1f02568..475ecc21ebe9 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -191,7 +191,7 @@ static int ltc2309_probe(struct i2c_client *client)
 	ltc2309 = iio_priv(indio_dev);
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
-	chip_info = &ltc2309_chip_info;
+	chip_info = i2c_get_match_data(client);
 	ltc2309->read_delay_us = chip_info->read_delay_us;
 
 	indio_dev->name = chip_info->name;
@@ -213,13 +213,13 @@ static int ltc2309_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ltc2309_of_match[] = {
-	{ .compatible = "lltc,ltc2309" },
+	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
-	{ "ltc2309" },
+	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2309_id);
-- 
2.43.0

