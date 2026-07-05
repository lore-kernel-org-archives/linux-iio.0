Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A8305687
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272290; cv=none; b=JI79JaR6A5bXRtDBOvIVzFYZjhXMoCbWRVP/y7ds9Vug7eaPlyB5WMF0ZH7uGF6OxVsEgGvYxpfIK9ytffp8taPxzOWmL0cfsiTivE1jYnMVD0OjAqj8U79jdwPLM+7Do7FqrJzyA3A82XyM5FqbfxlYs07Cb1qvX/QuJUo2ZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272290; c=relaxed/simple;
	bh=FkuNm/tvgDgcrJW75QqqTGjQXk7LjFWxZFm3qnsAsN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQj5BPVBe+vC1Fx4oxEgWQj+XPd7gWChpHG7eo+hQ5grsz/wzSnO6lvKeFNpuPuX2/1KW+MfPlTjmvn6thxjwdtJPOSIDOAwiN+pgUIash8+lRescD9tgIY7E5nFgjzyO7x3FMQmo+awAtbb5jMgQWKdW+4XTJyOuF85iyvI0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XiDn1qFA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L0EY1tqT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XiDn1qFA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L0EY1tqT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664KXcdD3950888
	for <linux-iio@vger.kernel.org>; Sun, 5 Jul 2026 17:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rWzXTnzdQLITJgAxpH70+OuDGNYLaDfzhhg
	yyQvlJuU=; b=XiDn1qFA25vmWMgTxblOQ9Sp1aK/6cCQFNfJAS8vNCc0bi++XR5
	5sOX4Xs/7kuE7iuRXLUOKsOoYBxRh5ja4Z8qbpec4N0Ie6V6L43dOv4jBnG3Jr/2
	Ppl7aPuD6uAvsfVn8GOieVVNs3qmlHBQQWMfbNnVZENFkH/CO3DfdZUIGXBU6eRU
	sua/8DlWL7n522bu7dkgGSHhGay8a3Ha60SP/Xxd1LLnWPei/net6w6qvYjdqAd0
	kdNrZpdx62jOxqDkHTIw2s5vjPOJcmwwM79CAYv603sXSISUoVQ1uGKDYUwXt8ag
	sxzxgbadSVtUdRP9QwU1giztWAfxheT/4vg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8uk2r2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 17:24:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e4f946461so228713785a.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272285; x=1783877085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWzXTnzdQLITJgAxpH70+OuDGNYLaDfzhhgyyQvlJuU=;
        b=L0EY1tqT1qczj2i0z88Olkiu7+mJHLv51XeNeWcweVrxve7o2pjKIEkBfYnaBDh3AV
         q10Y9D5wCsDYBj+JPTkzo1s0b+4WJ5zErtIAed/tdQMIjFuAQTpj3omRXmFmBvjHVd07
         ByxFEA5pncqHfJCYB1kAzHhgveYpIhP2S+g4oSeUQIoBMlpcWzLg/FCc6XqdvessFs6h
         CqUNdAYfzufTq0u/QWUZLkBMlgIKjzU14P+LIvP21uiXrPEWAaZzPPNvl3zPiLsJTC7h
         gCCZZih2keybaGeS4lnLptlJ+AmnpPO5f0IoS9hlPPd4c7Hb/3OuGsTw5bIG+l8Iab8/
         wwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272285; x=1783877085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWzXTnzdQLITJgAxpH70+OuDGNYLaDfzhhgyyQvlJuU=;
        b=Ffg+fAIombLTSX2xiSDFg9XKk55txCZfzMjatL9eErJJz3rsPjVX1qPj+p1M4tj1Ad
         Q7Ygb/rKt+QKlzxNesedF+/Bc2ikSzQ+75Z0zeYaqLz8DAO2cvlco6pqccdq9s7+PtSz
         vxpRAQ9WrjyxflFfDlkqaG634ATaX92a0EoG/xL4KVfF1GU+LIu3GjXUbc+KSBIDFxwX
         RoAURD7q2k6y3imxG1oB7uaR69GeYok75Tr5ha1RKVfkAKpm8R6ago1ubT6br4BiosP/
         nz9q2jNoiR1RWb2NxArguTQ/LxdbpI+6BbOtKRT/fyPsqK3wETM0f/x7M08Ps0CiSmz6
         +QVg==
X-Forwarded-Encrypted: i=1; AHgh+RpwjCm2ofNBbLyXXKt66VSuxX0gyjGMWb1SgBY/WT3bMvPTI0liqhX1TcKKYNi3RCuZWMkUv0hULSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63LVnyVKBYKnvEUeuVZMY7gQLQiWI/sj++FCwLelZolSBW6BN
	LQ6qLtR4XXcFEsgbI5y8S7cOQ5AFqQF36qypCLWFaT8iKVpYGhXU4chGEXCJH5Y2XcDhKelfpdk
	RsJFmVPqwocUJWMrCSkByR0YC7AKnIw93ertv3veISTZIPagEJAc88SB2QFyuozk=
X-Gm-Gg: AfdE7claLefgnE/RiqB4x3Nah1pS37X9KTw41d4dGhJZYTqrgwS9qOyjUa74LcZG3/H
	DFVRiv6LSIeR8uDPNgBCj+Crb6tW1JmmKiDYy44c2sDstR6cpR6xALEhR7Rt11f7z5b5kImwjgv
	iG/1uAcXwp4gvuww2Y/mstvrhOFNEwIq+0dO+MgvQATKVCF7B1CM60KY8tEIaaqo2a951TlOX7A
	ArbUEQsY9ZvluD8wVO94+OefihrlKUFiuhUs3qM/qx/Kb/ciydr1+PuPktWGTkb/sFZRAQ8eaV3
	A74mAQdHVMxyidz8JHv+iZqbNZNQLH6EH9Cfg0THgn03trm8Hp8bAVFsAA90JYIgZJm/eVTeqdU
	VZvg4SBkATKRYWycoQNvjRwAmhrc=
X-Received: by 2002:a05:620a:2912:b0:92e:4867:95af with SMTP id af79cd13be357-92e9a527637mr1002359885a.73.1783272285382;
        Sun, 05 Jul 2026 10:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2912:b0:92e:4867:95af with SMTP id af79cd13be357-92e9a527637mr1002355885a.73.1783272284960;
        Sun, 05 Jul 2026 10:24:44 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm17638411f8f.32.2026.07.05.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 10:24:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check on devm_clk_get_enabled()
Date: Sun,  5 Jul 2026 19:24:39 +0200
Message-ID: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=FkuNm/tvgDgcrJW75QqqTGjQXk7LjFWxZFm3qnsAsN4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqSpNWr92yDgh4HHMfsFo6zxlt+K4pLwQmNqfjd
 cUYmTPliPGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakqTVgAKCRDBN2bmhouD
 14D4D/9i5vGKTZn3hrbisKiOTFp17NDyWkutXcbiy16uzttj8QDyLvLmexECBLSesnn281b/gV2
 UoL6zdSVrKe9tado9P9xPKl4BzGIKVbKogio9fKfLAmb9UoHRxZqLR5zOHaxHiGElBd/B6An3I4
 CR5nuF0kWXbHF4vQQvVw+kxL4kAUvsssZaRHdqEN01WDFXRSI+/WJN+cirk3V+/Fk96V7nYhh75
 cMhokhrT+JY/iodRtg13E8V+19JHeBnFnZYtSoB+2HPNnqZH45fg+pK9U/7tSrzpkkaZo4KBIwu
 RJ8DJbz9NRbvlG5dRhOZhkn5/BfOT5eH6U451p8eXQY51dpdhcYTDNQUdI24BV3azOcuYQUOtea
 QmM12fGFasKugXjxgdxXunANDlXh631CZTV2Spx30X1XnNEdWAcimRwTZN/NmL3NEtVUL0B/GRF
 eigM7CyoPjfc46BIrekxGmJnwTFGocU1CqHO+ZBBUI5ZqxvqcJybXycPdXGkAB6SVPyxsexYBnE
 YfSUlg0LEcr2T11ehI5AiH1XU2rvzPpxBwdVP8456PatE/vVebK3V38hKbFxfeXplyUHCsch+W1
 E75BQDptCi5vo6NjZlJ3aRVgEgEsmulmE3Odrz5kmsBKZnc3cfVZ6MZJTXytJ3Bn26wyeZc3ov3 HXAcKBFPU3nhxDw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VsZhLQUMXh7U3_1n9cfGD-qZns-C_DD1
X-Proofpoint-GUID: VsZhLQUMXh7U3_1n9cfGD-qZns-C_DD1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfXzuaguvGIaAZz
 ILysllS92wQPkJzi33CMeqAlO2Tz2l1C62FhsjiOclv7L5xHVioabd+OnmZFyTQK2zeXsVK3OCu
 CwzAudGhjqY7dBMTtY59n3wAbfjitNc=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4a935e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=U5DaUFgT7etW-95KYEMA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX6C7eLV4PQcZR
 Edxy1KCe/vfXmz0nGkP2yTXcn/fA6DCTSNzvXR3cUPaEYvFoai9VlpilCHc6UgT/hJchH9UJFPw
 KggYPAermWyAgAfITu/m5rLcacJfbLJ2Oa53dgDdubSEtsHeB59wZYBtX02sPkIbOqPHZLse4h9
 mYamM4zCtNxaqci5sMTfShU8FUt4LK8KSUfBAA+z416v70HN3YUj/tr9rtpq6Dnhvhn+0hiMW6k
 Ti9EssJleXegK7N9HAWkKYiqWPwhIVH6H2u3ef6KpZv6xGK+Qao7kVnugFnGlyxK/Z6boYfSw4K
 kGhHtGcg0UrqkBA1Nw/z4ENRvdiljuirf+L8uQBnAEIxd/hyYU26Gf16cNcnajRlFeBf7sdHGJ3
 CEDas71W9crVYYtlc9wv1bjCEXnQ6iZxJKX77VaQ02tO2g/9VhDcgctJeHtSXqMDS/avJd3iyeK
 1Z+PmYlvQP/YEndrhcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050187

devm_clk_get_enabled() does not return NULL (only valid clock or ERR
pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/ti-ads131m02.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131m02.c b/drivers/iio/adc/ti-ads131m02.c
index 2f8f75c8216b..27c8abff216b 100644
--- a/drivers/iio/adc/ti-ads131m02.c
+++ b/drivers/iio/adc/ti-ads131m02.c
@@ -848,14 +848,8 @@ static int ads131m_parse_clock(struct ads131m_priv *priv, bool *is_xtal)
 	int ret;
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR_OR_NULL(clk)) {
-		if (IS_ERR(clk))
-			ret = PTR_ERR(clk);
-		else
-			ret = -ENODEV;
-
-		return dev_err_probe(dev, ret, "clk get enabled failed\n");
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "clk get enabled failed\n");
 
 	ret = device_property_match_string(dev, "clock-names", "xtal");
 	if (ret > 0)
-- 
2.53.0

