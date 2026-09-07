Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9345A284;
	Mon,  7 Sep 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776405; cv=none; b=lKbYFDMLInwTkEQFE2WcnGykY4RbejnpzvO+n2jXgvYrU9TFwm/NqQmRv5+kZU/AqqIq2CxLghzPmkjA8P/kCMjXk+FLgS0g2l/WUJUL5qvI32LccABI/DkgT+0Qz1kjip6/RT3lqHAW+1mi7sXImrKyBkKPAJQMGUb0BMHx9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776405; c=relaxed/simple;
	bh=nxtFcVDIrXhbFnNQLH2JELSgAiu1QkIdtJ494elGZVI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MugFsAx8Nmfg06BIqGBPDBTKny1Ivc3en+H0JRw2nWUdsuTy52EL2NsunifSjZjjpRkpp1dGsm+ZPppyKvdBwviwFAhrtdWYa9wDrrICFknVBWs8q/Dq5eEYTi7iQGAWPgifv76kS86+JRm6AoQDiV4gkjvNjPYQEsGvBX/zdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nNwBekum; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nNwBekum"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879YKII3967837;
	Mon, 7 Sep 2026 06:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3TT7U
	IX9PAtQmXv7T6OuUtnnqasnDx/xSiZgHz7QF5I=; b=nNwBekumrx00fWj/xPyIy
	pd+sWqEtNgOMPvYEMVNp4nrmnSLb00rMWBJCvB5ZB9qxS0aa0ToDT7YzkXCnkhnK
	BCONYv3I4QlL0uQnQNPJln2QkaVurbJh6msKQiyjaXTYlS50TZw/DIANXWMregUJ
	vyKfboCeF5jBrb88u3Dd1wmUBCzBB1Lzn7BdBDeeBl4kxa5Xj/rgqgTi6Go0v0Wp
	DrKpC8eYzJVgJvSPP9gHzs/q3EUFq1LOknsS/ZlggrPXmHExk08993++e8bvUsW6
	YLxLm5uQNVTlYcbbFsLXfv4dAMGZ+EWpCDFB3PK7/LKtMQZ0KoBl4zxhqGrFbw7F
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ggcx2r15g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:20:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AJxGV010663
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:19:59 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:19:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 7 Sep 2026 06:19:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:19:59 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AJkx5007440;
	Mon, 7 Sep 2026 06:19:52 -0400
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
Subject: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4885 support
Date: Mon, 7 Sep 2026 13:19:43 +0300
Message-ID: <20260907101944.9748-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907101944.9748-1-antoniu.miclaus@analog.com>
References: <20260907101944.9748-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfXwnuOZffmEtLJ
 LKZBxCJbuQahKyFzqrROOXiRL82OHVlQk4lvdXvnzEox7dF5hJ4DXfwh4WPtYrMjcc75ivIVMC9
 J73gupmfWzUEPQfEGDOneWUiS/yf+OL4ASU+21BIWehRpRkz/+T6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfX3CJIAxGJjUuK
 P2Wh4YPQPLgx0qbNUT7MEpDgzOtO4ULA9R2L9ewip1dyRgZOI3qkJiOPsiYk/LN5DQbJ6YxCCXT
 htoDayJGlZ7hNpKnSarQ+yxL2gOCAADw0ZYiRhiO9ehi5C74VMJ8jUCQj0v38IeYdXUtIPs0m7G
 AH9blkUU7fvR4v4asFkXGcFbh4hhbz+Uur7KtZxxYTslq1+WK0i98yn+yA4X67ems/vsx8UapJ+
 /usFmIGf4JsxbwNBdEc/M2v0ZzIKePzWIYcXlkK+lmMOHWzJ8zD/owArdXx2MmYt2FQhuEm9yJM
 cVe4oTSxCwpabgK+TJkUokufxkw1JQmqhJ45IP4tGm66H+FobK4LYN1rWRRMUiCILFPg4m82xF0
 QgjsnEXugPaFRR3MwAn6CZm/AQy0waSvxo2ZCFYB032uEMoYXMmRo0B8OQMEEksJaJrsY6sDy2+
 euaOm/FnDuOTrEo3LGA==
X-Proofpoint-ORIG-GUID: neeSgO_wCu9jIMT9zx3HKOSvoBhzj-Uv
X-Proofpoint-GUID: neeSgO_wCu9jIMT9zx3HKOSvoBhzj-Uv
X-Authority-Analysis: v=2.4 cv=SOdykuvH c=1 sm=1 tr=0 ts=6a9e8fd0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=V2QI8PVkUmR9KlRn6N4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070113

Add AD4885 compatible string to the AD4080 devicetree binding.

The AD4885 is a dual-channel, 16-bit, 10 MSPS SAR ADC, sharing the same
register map and interface as the AD4080 family. Like the AD4884, it
requires two SPI chip selects and two io-backends for its independent
ADC channels. The AD4885 is the dual-channel variant of the AD4085 and
differs from the AD4884 in its maximum throughput and LVDS conversion
clock count, which requires distinct chip configuration in the driver,
precluding a fallback compatible.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index db8467b98e67..07ac4e07f415 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -41,6 +41,7 @@ properties:
       - adi,ad4880
       - adi,ad4883
       - adi,ad4884
+      - adi,ad4885
 
   reg:
     minItems: 1
@@ -105,6 +106,7 @@ allOf:
               - adi,ad4880
               - adi,ad4883
               - adi,ad4884
+              - adi,ad4885
     then:
       properties:
         reg:
-- 
2.43.0

