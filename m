Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765494BC009;
	Fri, 21 Aug 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321290; cv=none; b=X17Nt9nS2or2fj8+Zaf1y1hWj1cPEy2d1pV46zR/U6GQPPZXATUiuxbYRV8qRdW9NZa5j8IMXajpzxcw/VQ4YgL2joiGwusRGB9gcStuA9dZqbcs65DWk9looTJ8/B2hwDmRz1dF/2nxB/mSs3FGSVxtnijb3wtW36/E7PeXTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321290; c=relaxed/simple;
	bh=Ia5cdUwhQp5bspVUqQ3iF/ZRqYMDFIcD31k3fE8TCuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Gg9P/QSrsb009AjGQu+o07pzDzGwT0dcAa4H1keyGA/Z5rcJMai0V5Egjsb45yICYisncNu3Yvc8Dm8CFffYfjq/eZpY0SM1hZ9zRoKU/HyuFhAFSlyOnhP5UGfvv4sDmrQESqFg44ZZzA2Fi9mmH7AEPdxJirZ+hyFkZQa8edE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UCVCgcPb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UCVCgcPb"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpQt03387853;
	Fri, 21 Aug 2026 10:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=isQfr
	O1kOgift38KlUFUSiekVqhdQPQpvCxC62CsfNk=; b=UCVCgcPbJH3k6LSAPby0f
	7lmgWH8bVCfSiDfnsdHDbSf5PeMyv7S409AkzO3d5J8nK5iEbKa/vZ+SKtQlkgFt
	Cz5xT5EQnfLdCBRPaJiueUGiqdKT8HYnZQGivub8wipQ0UJ/gws95KZ0c2c5glHn
	ZT3UDIR+JH10J3O8NeYR4TLrOb4uFBZszzbW3Cu1WE/62zPr57DrSZROt8ugdI/f
	2hveXrE+mIrJhnjH73qwgUkijeZdgOldlmy4kBMydr1WyKBILp/Gbnsb1CF4Mio6
	OFCzLekmIhfs2uMuEYwZAypiATf208UqqU5fmduYU/qaV3IQRVO5LvSRMxZeKUPK
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g66m6m0dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:07:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE7lt5032862
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:07:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Aug
 2026 10:07:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:07:47 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkk024319;
	Fri, 21 Aug 2026 10:07:37 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:06:54 +0200
Subject: [PATCH v4 01/14] iio: adc: adi-axi-adc: Initialize state mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-1-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=880;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Ia5cdUwhQp5bspVUqQ3iF/ZRqYMDFIcD31k3fE8TCuc=;
 b=aBjT0t14v0z9vmtwBEXQjJZhOZY2AOCxddV74l+8kzK3mM0NRoXOSGyHFFgyBLvosOrv5Gej8
 fzIwMvwUGoqDOgHpOoKEEgCFUBPwQVNg3A0hiCYKuHEXfGVqRheiWQO
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX3RPIezyF3C+4
 ilOJDfRKuyXHTqrOg9VEnMRLVodRmpL4TiCaguiS41Y7P2iFsPzqmUIQ4yKyRQ7J7Kw995q0N4U
 XWbvSswZbWRdUGBxgZu8HKfQZZhS0bMG2LqUYiwKsi7yg5QD6ZuT
X-Proofpoint-ORIG-GUID: 01F9rvbhM1gQiuK_7eHJf9u6r4gT5VuU
X-Proofpoint-GUID: 01F9rvbhM1gQiuK_7eHJf9u6r4gT5VuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX2PFzXiOhf0+g
 P2jbTi1IKTn2BuZ+Al6gRw+JpEFmwPMyAaB8qZ2H5LiYXZNpyKrLNc8sHrhP2UVXXQveVCZFX5h
 udJQNAvJ8u5LN8OcRi6XX4U+/0cOr/iqXUrka6480QZ85mZaJTbKH/i0EXv2hIC9IfOFGBMmh+I
 HPix3DvTNOBMXImyqaTUYsXlR0P67uUSZBXtUvyJB22iaa8d8zrFJ2ZHrBoeLLMngoB6G7lD8YW
 7FjX2ojv5yd4A4hgicDVjXI3zL5faN9UQb5AXg06BDi372nwlJ6v1CwwOyoru7pcebWlfB3/3EQ
 fq5wEt5NtdBUxLuZXzAJ4BbSRefL6kNSDqGaDlOgrIt68zHcsm8OiJqmNenLcCreFxQKwYiq4w9
 QXzdn/Axu54Ow44QQZ1W+JKA7n9ZCu9d5vCSzf2UzUFdHu+avlLhqJ9FrZT1PYDWd5uaBxmSrtj
 b7iT8X66vl7czuIDi0Q==
X-Authority-Analysis: v=2.4 cv=baVbluPB c=1 sm=1 tr=0 ts=6a885bb4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=_ljTvifiVFBlT2kRk7cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

The AXI ADC register access paths serialize transactions with st->lock,
but probe does not initialize it. Initialize the mutex before registering
the backend.

Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 26b9c75bd4d8..b5e59b1871b6 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -684,6 +684,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.43.0

