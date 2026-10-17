Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C93822B7;
	Sat, 17 Oct 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202215; cv=none; b=NY9zGbv3Gr27XbUL2qXxlfIQl9VYK/KoywEj6E9QDFB9//Omd6tl/eNDr5oIt0WXprb4b3QJrf4MbAAqGu+pbOgdXyV5XEQdbtAB7yvQ/dBCYYArGi500jqoR0Su8Sk33nJ2qDLG+V9h+WtT1Qg3ZrYLkUXwvdFgOzWYoM7Jjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202215; c=relaxed/simple;
	bh=2m8RDs9O7ZVadMkC/uohZ5zYSsNQSedaj+xeDCfBdCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRo4XaAxvMUCbKUEa11Io92NjYAVvRu7ibWuJ5jj5pDF9gHPMSlUD5Z1pdw6FwmxUfbUpUl2iHkWKAHtswXZlWXgnNzn6GLsc89vaCME+s8Lu1VLllgeOQ4OFx0o2xy56ijXknjJ5Bru9hg/qKLUmnbA9J4AaJAXg+M9ktVwHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=bNlWmQo3; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OsOLsdM9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="bNlWmQo3";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OsOLsdM9"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHRPH2680399;
	Fri, 16 Oct 2026 21:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=F7akr4dX/TX1iA9nWTBz1DR4njHWFJXlkeRyefXq+oc=; b=bNlWmQo
	3Ffws/SDIF5OrJa+IHhDyFF2nRQBZ9tS3YHghVECcyfKqUTYcsHR+YROaC2+0F7R
	9sXYxyu3gKxg/ESSpvXycIhA17GzVSwiiHXEMBkbq2GJE8t0BhIsvUAHXVFeNbX/
	QRhHaYlw6DXkb5x8MZcpx3JC2DjtabD5N4hZV6aSGSJMRKpY77uoHKypbBVtT4dR
	avnFjbX9PcF6uPYWpsp7CQOfwNYLQRRdjG+RiLqFx5htVLLVvvsgwUZInNMjTk8e
	i4sp/PN1sqMC2E+QrbtuAxkgGRIgcnG0UjSOJ46c5WQSvJlzP9nXx19ghbQNcmFh
	zBq1jxjbyJxHgeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F7akr
	4dX/TX1iA9nWTBz1DR4njHWFJXlkeRyefXq+oc=; b=OsOLsdM9Z8R/14zFwLpw2
	HgvGlFN6hraNXoNub03ZXy/zvu4xryNLev++vNnSduGNp77yk7Bi4ROiZHEjzeBO
	gI69r6VRiGOCJT2ko0S9vI8qJisEIMx2izbRy1VtdhR5Wkb5WJADnER8CP0K1FGM
	WMhg14D7BfS+NE8xMrNzgGRVySj3EntFkBZLT080hCdG00HeX5LNQD3UQ52BlgE9
	D92Qi8z1Q+VhpgUAX7oum2NB59+ApZutbPG82Q6Vr4W8vDfF1Mmr5L4i6gm72sqC
	zuMHK4uJ1BLj8qltIUnPXEQ9CLV9i3ineXwQJaBhgzAzRbQXu21JUuWHdI6lO9ex
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4ua0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:56:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1um6a061377
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:56:48 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:56:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:56:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:56:48 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1uYOZ004285;
	Fri, 16 Oct 2026 21:56:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 01/15] iio: adc: ad4134: Adjust register map range
Date: Fri, 16 Oct 2026 22:56:27 -0300
Message-ID: <82020d559dc0759ad656da3b67919368daaeda90.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXx6brXBZzvuE3
 uQDAPVkqI/+TjuwMQMHPgaXB3+suaDX4ETNKOzJH+sX3ns14RE2fURrhxTHIlc1nB7RQ1QMY6mb
 9OCrJYZntQpajY4jh7eVG9pmWbNfYHy6fi5X98n12Ml6j4r2eUT/f6gb3nJAXA/a4zRloHg7jbO
 53WwUkZiNZPJJdF/V7GIJZhbfIVktvjY5MET77WKrP8QKPAWAHD42s2JQcFttVq+vA+oZeVtnhY
 jMk3N033L3Oyr2wfB4iCxbwYdTppNc+Zhd7N2Q0ClDeFE9NUfQZG8J7VSW9FkClau5KhknxLRz2
 jjyj/bh2eqJ8wdg9gXPLlKWD2kfDJzMzA+xeItUNKGUMsjXt+kU7aNCH0YONm8atpj/WsVFiO0A
 paV7XvOlqXHay8n5WGAP3Aw+vEaxAkSNrLpPFhTYBBNIkocig4fHdBMj0OlwvCYCkp6IKsE5ew4
 967QPH3mdv4nj+9iHQg==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad2d5e1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=xatGmy-HaK2A-VLG5J8A:9
X-Proofpoint-ORIG-GUID: EKGl3Y22DPnJ6QP3dfZsI3ACTGu6WFsS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX+flCCBQXTXbA
 f4WptKf1QZnWa3T+jOhhJi0nJEduXan3l0N5P2JDHEHQwqhpeLzbrk/jwU5szQ+uTa+7ihQoUwm
 Wd1fbttDzJK5pZt4ELNZmDQF4GUH3ecLEs929iNEKBcMOb7084cB
X-Proofpoint-GUID: EKGl3Y22DPnJ6QP3dfZsI3ACTGu6WFsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Due to a off-by-one mistake, privileged users would be able to read from an
unsupported register address when reading device registers through a debug
interface. Correct the off-by-one mistake at the high register map range to
prevent access of unsupported addresses.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Set max_register according to AD4134_NUM_CHANNELS.

 drivers/iio/adc/ad4134.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 70f80bf1825f..8400c3934925 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -111,7 +111,7 @@ static const struct regmap_range ad4134_regmap_rd_range[] = {
 	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
 	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
 	regmap_reg_range(AD4134_DEVICE_STATUS_REG, AD4134_AIN_OR_ERROR_REG),
-	regmap_reg_range(AD4134_CH_VREG(0), AD4134_CH_VREG(AD4134_NUM_CHANNELS)),
+	regmap_reg_range(AD4134_CH_VREG(0), AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1)),
 };
 
 static const struct regmap_range ad4134_regmap_wr_range[] = {
@@ -244,7 +244,7 @@ static const struct regmap_config ad4134_regmap_config = {
 	.reg_write = ad4134_reg_write,
 	.rd_table = &ad4134_regmap_rd_table,
 	.wr_table = &ad4134_regmap_wr_table,
-	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
+	.max_register = AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1),
 };
 
 static int ad4134_read_raw(struct iio_dev *indio_dev,
-- 
2.53.0

