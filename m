Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E93F5BD8;
	Mon, 25 May 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727291; cv=none; b=to8cm6xrkxeaapGcKzjnZIrLkef+8Cji8AfwD+LNL/0+G0ozT8iUHk53lzCGSXYHGhl4jW2G28pcdxjUQnx9nqU6SPC0wByRGDGA0fqg/VWnlCxwwm1VxOFgZK9940ZWJP7xYeuRPzqGLSO/gLd0974O+lI0LPFagkIXTlW4sEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727291; c=relaxed/simple;
	bh=ixLEFfGMNDvcyDVn3XjAPMI5yVm/JPO3wdn6NpACwQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioCZ3Qc5sWgpvGnpG9YAwQQi0BKiq63Q8atXEAJv2fcIs1+b+L2dZUfzQUHI95OHXXnwTLhgzIVUdfelJX8CF0T5YF4YQWAYwiteN0fubHTGw4LyhN+nhx/2hjrC71ikzsVwQXjAxw0upZaURKCG6k9lA7d6U8+fJqrpyaFy+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yHkKW0x6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yHkKW0x6"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PBi8tm3473088;
	Mon, 25 May 2026 12:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=R/eZX
	X/oOgktdTh4INy5g5mfQuzzHbbZojxb5GYx7bc=; b=yHkKW0x6pBrf7v6F0PB9O
	ixt1aG1l1X4UjFZ+iy7DJZn9gftiyFDifkiW2lnspodgM3J4JOUsJpfAgHpZ7uOq
	xucV39laBMcY9G4Nh6mP82woLRPzrezWmSHCEzedBXjDQaIB5hplr2S2owNFxxnL
	jorCmIS41sHZG9tw6UgIELxWOyk7qCH9LSXoxQD9faP5BWy+xZyQnJF2twhdB42V
	aMI5PuzDsf3h59O52ouxohvu8JzyR9npKiHGlUBhUWGJ/PDxDToR9vhYDgPAh/Cm
	rczG7ZhqQfV2H+do/doNRu/Ybc7toJe7Po7XaEcaotOKCoHaoKpFA/OnTK46FzoV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ebwje53v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfM8v022283
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 25 May
 2026 12:41:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:22 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevH1028845;
	Mon, 25 May 2026 12:41:12 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/9] iio: temperature: ltc2983: Fix reinit_completion() called after conversion start
Date: Mon, 25 May 2026 19:39:29 +0300
Message-ID: <20260525164013.118614-3-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525164013.118614-1-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfX3k30pddzPDTD
 fJyIgMHzj3yIeTUEPd7Gp7N/ybbvzNekOfFSKas6PHKznjc6Hfe1rvoEeez0hsI+0kLML5b9Ghj
 13L0GkHwAcmpecZEX7QOw13wwDWVMuftY8PvjtAWwHjEaZwQ8h+/vT6JHwHqN9w/vlpGM5NmFUz
 NbPMduhKbZ5YR29GTImh6U/dJhRkz0wHTrieJJfkxed2nLmQpWV3EBjUhE6DVfN8J9BOHsZK5kf
 YhOCu1SVU2JSidJJOieiJsMG5qQZtagN7HPGb/vKXVpEdbZzJLKXaKerEuo33s6FnlIR7x+x5Pc
 IvtdRwYGPeJiANdGdVM7PqIO3z1oNBFtM63er6AUKEUc1O4Q/U3dOdeSCAIT/1a77jiw9POjW90
 NgWmjHNEkvjnvhybiaS3TXkg/Hvkbqtog2r4xIaeRSR050Mf+W755cziEM0Wu7UILI3j/g4Idt3
 6dGltzqkJCV1XRr2tNw==
X-Proofpoint-GUID: 6n_df4fYt1tONc1ukKAjxB4NMqYESNKI
X-Proofpoint-ORIG-GUID: 6n_df4fYt1tONc1ukKAjxB4NMqYESNKI
X-Authority-Analysis: v=2.4 cv=fKEJG5ae c=1 sm=1 tr=0 ts=6a147bb3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=sADee9SCKmkYh09WN8oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250168

reinit_completion() was called after regmap_write() initiated the hardware
conversion, creating a race window where the interrupt could fire and call
complete() before reinit_completion() reset the completion.

Move reinit_completion() before the regmap_write() to close the race.
ltc2983_eeprom_cmd() already does it in the correct order.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v4:
- New patch

 drivers/iio/temperature/ltc2983.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 1f835e326b93..2bc5cd46a72f 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1177,12 +1177,11 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
 	dev_dbg(&st->spi->dev, "Start conversion on chan:%d, status:%02X\n",
 		sensor->chan, start_conversion);
+	reinit_completion(&st->completion);
 	/* start conversion */
 	ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
 	if (ret)
 		return ret;
-
-	reinit_completion(&st->completion);
 	/*
 	 * wait for conversion to complete.
 	 * 300 ms should be more than enough to complete the conversion.
-- 
2.43.0

