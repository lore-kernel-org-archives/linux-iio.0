Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35A26CE32;
	Thu, 29 Jan 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695984; cv=none; b=irRRa56mdgTGZEBZSPmgVKhPtx69lRMSijjeQ6lUgAzK9UBJvF/AMxhGbOEFPNWR8E0jx65LwePP9JYRoEWqw0fCXYWvIl5gVSE8EQ+cqYDCUIDEKogxvDjGrtPxxXkjmPhGAbkg8yNLSTdaJB8STF/p0MDXWRkebatU0XDZWJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695984; c=relaxed/simple;
	bh=ezgR2MtkiV8NJHxOHzi0NS6pC1M38PDJvpiWwd4pFl8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uc4wqyIpUJCbxx7cNJBt/I4OxPyf5nYW2ntreUgAZ1cbsmWv18nLJkCo3SJd6qYb7Se1ZaTJp+fqKYmIPJB1prfpo6m69uAJSfggX27zulRJ0viwu+1UXAXqxZqLveBgjvm7Bb+3PvvRqVV4doz5T/XcpDE77bLrgfOy1bw8KRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HVnfwny2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HVnfwny2"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TC5VXZ3783280;
	Thu, 29 Jan 2026 09:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=11wIM
	RPMo1mn8dZNf8uxIT+lKYPDJTy5FYcsV4jiDqA=; b=HVnfwny2bt/8qZ6W9JNZ7
	4clQRl7/i9MYrlNFRWQU5V18cQDtDel9ve/RR4jew5b+mfrNqxLA9KjxtZmzNvor
	xC1zfrJvvGuoYUZDmjJQkVq5CDFZ+k25pI7ycHTbdFe5H/2qoTRgHLdGcSBDZwbJ
	Hwzqhw16TXO8ZFDi+vzPc3iquU/MPBIBsCbZYxEmQlGvF/VURsWxGRUO5c5joPGn
	Hvt6pZZkmd7MUiiZm6CPSj/iOm4xaBFp9DClSu9C+wWWdjTrJ20/Z4xs7beCEpJi
	5VlRbnSR24f1+atC10raxgiYaAmaBub2PjVFho6uZR1A2RHBkK2Iqk4L1eYnYJcy
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bhs36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 09:12:41 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TECeRX033304
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 09:12:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 09:12:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 09:12:40 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TECNWJ031872;
	Thu, 29 Jan 2026 09:12:35 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] iio: accel: adxl380: remove unused odr field
Date: Thu, 29 Jan 2026 16:11:58 +0200
Message-ID: <20260129141205.106285-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129141205.106285-1-antoniu.miclaus@analog.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697b6ad9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-GUID: f_A_2JvaqicIoCKcun6AkkFFIdR4bZVw
X-Proofpoint-ORIG-GUID: f_A_2JvaqicIoCKcun6AkkFFIdR4bZVw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA5NiBTYWx0ZWRfX8ek7yMXrHWeb
 VvH6yD5ydCPittVAyclwhBc2/xaPk4+0UZmYMva3QHymzvpDyU+7qaqW0XGKhFg1aDuNZ7AItw2
 2BKkgg1XO1vafETJdFTFH8C1y/HtfrM7L3fsmNyPWTPYNSKk2SErcxgq3hAnlFjvCgJbL/sABF9
 FfXcpnLRUuWSBz2/1Svj9sgJDSzfN6p1lOHaYQENCtHfPk7ysibnZ93aIbvbPME57IUkDaqGRj0
 C4gZ8OwG/2X/ZcHZaL+sArt/Lv9UiKXd9idqVXHvKCegGbwmvAp4R54aQPrUy82jHM7Q2KNtx+q
 VjM4kSZ2j186/mgvWHGDJOVoB0sEMqJRvSlrSDSeHg01iCusQ6DJCIoAQHQaRXpQ55OfxPgrCje
 LpmmAmQHJE1aj8+IibF4i4PQpYn21MQT8W4FQDBtlI8oQXIM0u/9DiQ8yXa43M2UXLDAvPIFXQT
 37qVgIvlWxhCjXf8L1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290096

Remove unused odr field from adxl380_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/adxl380.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index aef5109c1ddd..4c584f6ec902 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -206,7 +206,6 @@ struct adxl380_state {
 	struct mutex lock;
 	enum adxl380_axis tap_axis_en;
 	u8 range;
-	u8 odr;
 	u8 fifo_set_size;
 	u8 transf_buf[3];
 	u16 watermark;
-- 
2.43.0

