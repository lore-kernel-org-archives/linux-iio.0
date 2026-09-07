Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F644AB88;
	Mon,  7 Sep 2026 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776403; cv=none; b=OwLgGz+qItI7oVxsM0OH6j0hiI8N/D9tObpTBzrm5mZGOonxNPCuQow9+G9YBwkGwhNoQ+j/i1wzxEpIIG6CMg3fpqvsTikX1WuHkH8iv0Br8k+2q9WibWAuVt6vDRX1iDmmFbhfJRVD34psIMdKgbQUHtd2pHGGFnok2E50EfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776403; c=relaxed/simple;
	bh=J3WSUDUfubhACtKele2b/7Hx8AO4uU0Lzo2PQheRzoQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sHLprBQtPrARYgQmDhpAsNpRsWOIVdHJuVn9MVizC331wGhoSyL5Cqp14pvYNX6jPTAMNjBrURATBqpnFmRcRHKJfiKLVauR0sn/ZF0PIZ3/jA4EEm42Qs97ePORbijicRFV33rsKQYsA63FygTWgCs8KyGqXrb25/OR1ODh7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fsSmfZMZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fsSmfZMZ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879YXlh3717665;
	Mon, 7 Sep 2026 06:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=bbDO1GEfqyqz+duw5BGEdPjaqe0
	YyHHO1PUHjoEVQuw=; b=fsSmfZMZqfMNJhrn4Zzn+0OwBmSI76RxeQZowIukKDk
	wawlUFrAd9LgV/zAETUx/Va0XlBRSxSRPcibILngzuyjYEXu9frn2Nxtk7Bb8Tby
	qBr2PqQZyCQIdjg4vveOvKDhH284b3mVuzYIMGt716dd/7OYW1YOM22GXzWxawt5
	yaVjn2G+gvCklTxrfhYcgKMod1axt8g9paqFgYdqjhCKRJL80PVMgvTYYa2I0EhX
	npeg6qW4ajxnw4tV9HxqkERy+7hsxwXV2MWqYLawlmFvnHPToGxwIGjy9/P8UJXh
	yTIasIOExgHDOcDqqkcngROYytK+Nyzhe3jZjJaxYSw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gh4dg4dbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:19:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AJvgr010657
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:19:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:19:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:19:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:19:56 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AJkx4007440;
	Mon, 7 Sep 2026 06:19:48 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: ad4080: add support for AD4885
Date: Mon, 7 Sep 2026 13:19:42 +0300
Message-ID: <20260907101944.9748-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: Z3ypVx2_LNdvjPNtUwi49rPnfVe68u_-
X-Authority-Analysis: v=2.4 cv=f5N4wuyM c=1 sm=1 tr=0 ts=6a9e8fce cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=kudk5ht7C_W3O3D4LlkA:9
X-Proofpoint-GUID: Z3ypVx2_LNdvjPNtUwi49rPnfVe68u_-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfX6algcQ88fRUf
 NLKPMJgygft4F6s0BbKqveHXYCyohpLTotEpuV2ncbqFED4gSErZ7+DDwg2qhni83EA8ClbjAXh
 kcloBRvpi89zZ9vD7T6VGeHP1dclcAcOOE+mUHDAjg3VktwmvuoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfX36RRvxrsPykB
 e0O5OKu++udLWjgrBpt9gLcpc6eRai6Ad0EqRwOALnCMgPAKRP0sP2CvsObEUHwaEUwFlfAaOd9
 4IXSTQIQMIaEHloPOVJTpBk1Zce9KfhRgy6N4VJTA6q+FhHUWmnjp+zpREtWfCtE+imis1AfKmr
 y+kJegJ46okSkY6+NgBRY+pHQJrdOIycEhSvTRPcjODsciRuvB3AlCMpsHXHLElyHgjhirwRwUQ
 Rzarbh4O0vvAlxiVLjJ1vUjNQ9GIB5xna7fWPbg4qa7H0FjZXGoDEJh91sXvAR+UTWWjXQ1AIf9
 wLe2jb3l8JJxfyp8kGUSGjmJiOnx/OfNPAYDQlbFe22UTWQtMT4Gfg3GgPoI/vPKci5ldPL12yc
 kmwjsOcUc53rERrykdr+w+80J6Q0pfY8mkX5R4L8iGCCXSZX/Oa84jdF/yGg9XHjrlbq8TyWMXm
 Tu1gSkGnQ3Ux2cexUSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070113

Add support for the AD4885, a dual-channel, 16-bit, 10 MSPS SAR ADC in
the AD4080 family. The AD4885 is the dual-channel variant of the AD4085
and, like the AD4884, has two independent ADC channels, each with its
own SPI configuration interface, so the part requires two chip selects
and two io-backends. It runs at a lower maximum throughput than the
AD4884 and therefore uses the same maximum LVDS conversion clock count
as the AD4085.

The first patch adds the devicetree binding compatible string; the
second adds the driver support (chip ID, channel spec, chip info and
device-table entries).

Antoniu Miclaus (2):
  dt-bindings: iio: adc: ad4080: add AD4885 support
  iio: adc: ad4080: add support for AD4885

 .../bindings/iio/adc/adi,ad4080.yaml           |  2 ++
 drivers/iio/adc/ad4080.c                       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)


base-commit: edb91bc566576f6664a3efbad6bd4205aa1d5259
-- 
2.43.0

