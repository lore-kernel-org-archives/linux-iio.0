Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751D3D47B4;
	Mon, 31 Aug 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165126; cv=none; b=UZo7JaNUBGfg+iM9ZPTJxZgaPzzB48wocW2cAyxFOw3s7hTdvoXOc27M2OHkrLC+QYaBH8VOr/cUsxxxU6DzZXpPB7a8ztw1s8ZmGj1KCIVij7/TDAa358Xy0voflyS4t1sS18eIBvLsblVARYKy1cPsw00qlwujr369n+SBRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165126; c=relaxed/simple;
	bh=kAh6mt/dBiC6mAMzTpIaLE2iyJ+h4AZ2YUe5DSU8uBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXErim3knANPIYQan8DR+e+402pigRNvT8rrgjq6BRVztjhnXfc0LE1mdI9UNP+0B0hMmSEt/uMFJT8Wh3KZbLrXJrVAaA+ZpCPFeDUN6v2Zqj8Zmd4p2VtUw1VGHfdi/aYgn7iUeAnGiVVTR7rbjTRXyjPZSekXRsV9IZSKkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YRtYOB3Z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YRtYOB3Z"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82gXr146713;
	Mon, 31 Aug 2026 04:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4wkFi
	LKA1WBIOdFRdbx3zeFp3Lq+zCjH4DrbsYUztbE=; b=YRtYOB3ZGoN45T7LwFNS2
	RG2W7KvbTcEWHdPEvG70K5SSFqBiSbeoByqsWkqC5Bk3kpaeoWXbrIMUglrg19yt
	OeGKQ1r3Locf72YHoKGvwMrGiGv4gJfcbmGtFpW+Mkp+nNJh7QLIU6GoeCbyPdfq
	9yhK5BmFCLsyYDCl8t6iKaPPH+5Zu3CsNQBkAVksbUbcywhtIAeSel37HvUfl3NY
	xTgqWYrt113MBLDZdaVNqjonRodXkGsa8VU/XSsL3l9Lx9F7pVkjWQTTsysGxwAh
	80x5PfrZdjX2MuS8MapX1oLRsW6R6PWqs8hEQ+Ifbg9oJAQbQPIw2TxggejUhq62
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcdrdkw4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 04:31:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67V8VqTN012512
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 04:31:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 31 Aug 2026 04:31:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 31 Aug 2026 04:31:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 31 Aug 2026 04:31:52 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.222])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67V8VVai006721;
	Mon, 31 Aug 2026 04:31:45 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/4] iio: accel: adxl367: use regmap_assign_bits()
Date: Mon, 31 Aug 2026 11:31:21 +0300
Message-ID: <20260831083122.3486-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831083122.3486-1-antoniu.miclaus@analog.com>
References: <20260831083122.3486-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfX5a77seRAJVvp
 B21wRdaQBSaoWwzEKlPIuPatjTnS8PMlV/pCXbyzc+r1DCzg7LtVoJ3SEYrxbFlfpeZx217i9V0
 CE5lDevCHsUrZBibowVGqe4POaUt7sJDgmhDtWC3E8KSbDj7VdpJ
X-Authority-Analysis: v=2.4 cv=feSdDUQF c=1 sm=1 tr=0 ts=6a953bf9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=6G0qDAfybOyQFWdpEooA:9
X-Proofpoint-ORIG-GUID: kX4Svryz2Mv3y8lQZ2HwLu9U64aZAK9M
X-Proofpoint-GUID: kX4Svryz2Mv3y8lQZ2HwLu9U64aZAK9M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfX77oKDEE5A2Ru
 PdGnbMiZP2ydagOcY5W+wn79fvVQ3D15faXgYRe0y/5PQ9/Io3fbRtkkHGf6wEoe6ekZY2Hf6Hi
 /N/ThEbLWUBbUgGTlfKspr0rFlbFKnodDTSxXV+j5VElN2RSSXyFGGs/bNOhGIFfOSQPf/+UCzJ
 ytLLhmiJ62KoJ0IphIRO8HPl6IWWNaOWBUdBH/mCy9wnB8I48I7coXHNgUF5faxDyhMQiPcM9Tr
 tH5cMyCuBBP1IV7+daFURfHxCirqof1JBH1fixaeW+ioqA0iXjEtlK+PPF/XD8uGtbueYxrdzQB
 um46GE2ID4Pi+2FLl4XFF+s0W6A67qs63xWPvqxbw1yIbCV6NiJJpU172H3xqh/vFhWZ2n/iyyp
 kYL6gZDKK6xYLxiQZ2cUUNCoQxBOmEA+jZQ1tifsqhYLcdCryuGYgWOsXW8hp4IQKAN/pn9OYk5
 J0CyDrJJDrNr7X9DkNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310072

Several helpers set or clear a fixed set of bits based on a boolean using
the regmap_update_bits(reg, mask, en ? mask : 0) idiom. Replace these with
regmap_assign_bits(), which expresses the same intent more concisely.

No functional change intended.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Changes in v4:
- Collected Reviewed-by from Marcelo Schmitt.

 drivers/iio/accel/adxl367.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 4ff1c7a0988b..54c4d1226790 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -366,8 +366,7 @@ static int adxl367_set_act_interrupt_en(struct adxl367_state *st,
 {
 	unsigned int mask = adxl367_act_int_mask_tbl[act];
 
-	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
-				  mask, en ? mask : 0);
+	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP, mask, en);
 }
 
 static int adxl367_get_act_interrupt_en(struct adxl367_state *st,
@@ -401,9 +400,8 @@ static int adxl367_set_act_en(struct adxl367_state *st,
 static int adxl367_set_fifo_watermark_interrupt_en(struct adxl367_state *st,
 						   bool en)
 {
-	return regmap_update_bits(st->regmap, ADXL367_REG_INT1_MAP,
-				  ADXL367_INT_FIFO_WATERMARK_MASK,
-				  en ? ADXL367_INT_FIFO_WATERMARK_MASK : 0);
+	return regmap_assign_bits(st->regmap, ADXL367_REG_INT1_MAP,
+				  ADXL367_INT_FIFO_WATERMARK_MASK, en);
 }
 
 static int adxl367_get_fifo_mode(struct adxl367_state *st,
@@ -631,8 +629,7 @@ static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
 static int adxl367_set_temp_adc_en(struct adxl367_state *st, unsigned int reg,
 				   bool en)
 {
-	return regmap_update_bits(st->regmap, reg, ADXL367_ADC_EN_MASK,
-				  en ? ADXL367_ADC_EN_MASK : 0);
+	return regmap_assign_bits(st->regmap, reg, ADXL367_ADC_EN_MASK, en);
 }
 
 static int adxl367_set_temp_adc_reg_en(struct adxl367_state *st,
-- 
2.43.0

