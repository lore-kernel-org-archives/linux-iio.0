Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087522;
	b=427Kw+A7v5MmOrVN3ZNE8OEJdDJ72buRn53kvGo/+Cl+d6cHkVyViRk9i95zXobDqLm3
	 +Z+FQ9gol0eNgXo9OgxmlBL7J5Rsdlib+xEwBA284Ae/rJ/Gr2w5YZkZQbpM9I0Plg+v9
	 e8DdUvDe7quPjO97HUo1sZFwZnWZ841OIbVlmGsBucdBkYjSl96974D7NqwpO6mVwcxj4
	 RlETepqrO7GcKVF/5lmzefaE0olp6OZgEUHBJhxSSn0VWXpGqPLNDbP/VAA4VmL3k3+vA
	 WMTOy6SkfKtq+OleBQi0BTFFSe4IFqBWsQ2Fuj/JHc4w7Psnb7oLc8HbwApoe2UDO9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087522;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jCIlz27aQr2y7uv63fCw/9v4jL+xU4DUf9Eee/T6VMw=;
	b=c7z4v6Nlflh6jGY4fmgwsG52oz6Bs3odZrpywk3mNxHxIf/t4uuXxTWdQcjv02ag8Z2l
	 9oZr2jZl+ootT3TYOXBKouuMVaOrlzS8WlRsMSMDqZ+KufYnTZB2a/eC1jcwl28LXks05
	 XmeBkVUlTXpl97yw2ikYSWidfqO8p07zjvVGuVKEDfaWNp+6q6VFOKGiRsiWd4Unhs15p
	 Mf8K1XR0BT+Vj8QPBUF4O2aULUQCPlw5iXpn2GIYumznAAZNiN2qD2piv0fNvCc+JQMba
	 dKtGQ+WWdFC7KyNvC+JPH7HQD90ufroPnnyO7SUYeLk/O6Xh4xEpaJ9JjQiLV1N6AdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tTj93iI4;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="1O/a816d";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE260A2613;
	Thu, 19 Nov 2026 11:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35CE260A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tTj93iI4;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1O/a816d
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJAxaoU3113113;
	Thu, 19 Nov 2026 06:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=jCIlz27aQr2y7uv63fCw/9v4jL+xU4DUf9Eee/T6VMw=; b=tTj93iI
	47dyT4tiv8CH7F/dTNdAKLJmUcDbRDD7INGZ9HOpQKqhCMHefu/+QLujszJo0Ru6
	hEMD9QNFyp9gr06Vehl0lWncFcV+cLNxwRXmdF0ln2awsG6tRmfMRpZ1jWu3rT3y
	E3tjHvGSpPTtcVDlP5UyzTxSdI7qQ1KsF5z2NFlqrPY3rZFw/jLHFtujJQf48iv3
	1G7LjyF+Gd6CS2prDYn07vGTB+eSHxmUGazMVtxufZqZdTiA/vYGbXpF+DLaDGmb
	9GI7vBY5aIz9GKYKwUasy3OVjJh5Y3EcBBpohRhJMnqMpdZouHc+tMOpCXSssBXs
	JYaN9NrlksvmBig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jCIlz
	27aQr2y7uv63fCw/9v4jL+xU4DUf9Eee/T6VMw=; b=1O/a816dY8D8q0LoAYwLO
	YLx907Q9EGNDt1XxKNKAxiEjTZWwXVEOKXgUhwM8BWXRPFfCcc/WK/hn4nWBgrwe
	ph/zPRNv464Vjqgu5aD0mfOGqoBWSc52QrYwWJACX4SRS095KyIWb9r3F4Fx/4Xd
	0UBxnNsCP1jvrW903ETRxtKOaAfNHku4UWZyA2ZKV+sx9giaHJ864wZPn2DqoHjt
	GkwNiQeJkfYXYgOzq/wosApUpb2pi563LhQPV8ybi3J5kgWFZ6G8a2k2pI3gLOR/
	s+qDTbSrd0hifHZCJLuDJNG8n0A9AUK8C2ADd5GDi1ufKA2wSizozboXPMW1ZqAc
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j1pbqb8b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:25:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AJBPIr7011124
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 06:25:18 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 06:25:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 06:25:17 -0500
Received: from arch ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AJBOocL010881;
	Thu, 19 Nov 2026 06:25:10 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolae-Daniel
 Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v4 4/6] iio: adc: ad7625: move initial mode setup
Date: Thu, 19 Nov 2026 13:24:18 +0200
Message-ID: <20261119112437.197306-5-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jPkvxolqV5w8mBgvsL241D0IkSMWsjuH
X-Proofpoint-ORIG-GUID: jPkvxolqV5w8mBgvsL241D0IkSMWsjuH
X-Authority-Analysis: v=2.4 cv=LNzz05W9 c=1 sm=1 tr=0 ts=6afedc9f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=Mz35QEKVqf0_WHhjdWgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfXy8/cJjzpo9ay
 EP+kAOVzXRSZOneISNPghVkTJqND9kFttmCE4ex/d3Jfo15LtiWqxBIlU68Z9j8V7esexYKyDNb
 kcr1gpaG4TAS4+6+iqhJ7QWA7DctNAa/ook/FeY2sWCDA8q8y3qI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfXwlLAqSsCNkpD
 fqliU8fExcg6fCi/SQqqyDtTTQQCUZjwkzvsBw5+Q2ark0yM26cvgTQHyO1GZ4fk8N5+8/yGOTJ
 UMwEOocazjhT2JW8wiw1WgTAB4/vkrk8QGKu+EGmQj/xEFrtc1ZD9qDdoKwhDtxdJ6l77Jts1g2
 gyoNDThnjNANt3XF4Y0wsygH2WBhmjY6w+rohHLnLZvjDPTTrqwxzUZeDf0r39V1hPzVZ/bge8b
 xnE5pseHsAk7JfHbDoi417tXn9AueFVs7M6xmJ/zVvZTov0P8cWQJ0fAg0H87RQReI2lW4Llr2d
 +aHVulZeKc6rW3HMHDNynONTwyFKbIG9F4LGifeGp9Wj2RxPAKUoecn3MYm/kYQhBYqrGnBbKy1
 1NjyvV52ktgS4r5yeJCp9VoIBxBEpWi/8kgtZ0AEOyes0Nt1NUjZ3Xdlc55Fnzo/Jg1/bEzZrSG
 eXyRfW2Rq5mfcF1uhzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045

Move the EN pin mode setup from ad7625_probe() into
ad7625_set_initial_mode(). Pick the mode first and check the result of
setting it once, returning its error instead of -EINVAL. A following patch
adds parts without EN pins that skip it.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/iio/adc/ad7625.c | 52 ++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index ade2f2368bd8..127441050687 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -561,6 +561,32 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 	return 0;
 }
 
+static int ad7625_set_initial_mode(struct device *dev, struct ad7625_state *st)
+{
+	enum ad7960_mode mode;
+	int ret;
+
+	/* Set the device mode based on detected EN configuration. */
+	if (!st->info->has_bandwidth_control) {
+		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
+		return 0;
+	}
+
+	if (st->can_wide_bandwidth)
+		mode = AD7960_MODE_WIDE_BANDWIDTH;
+	else if (st->can_narrow_bandwidth)
+		mode = AD7960_MODE_NARROW_BANDWIDTH;
+	else
+		return dev_err_probe(dev, -EINVAL,
+			"couldn't set device to wide or narrow bandwidth modes\n");
+
+	ret = ad7960_set_mode(st, mode, st->have_refin, st->vref_mv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set EN pins\n");
+
+	return 0;
+}
+
 static int ad7625_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -595,29 +621,9 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Set the device mode based on detected EN configuration. */
-	if (!st->info->has_bandwidth_control) {
-		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
-	} else {
-		/*
-		 * If neither sampling mode is available, then report an error,
-		 * since the other modes are not useful defaults.
-		 */
-		if (st->can_wide_bandwidth) {
-			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
-					      st->have_refin, st->vref_mv);
-		} else if (st->can_narrow_bandwidth) {
-			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
-					      st->have_refin, st->vref_mv);
-		} else {
-			return dev_err_probe(dev, -EINVAL,
-				"couldn't set device to wide or narrow bandwidth modes\n");
-		}
-
-		if (ret)
-			return dev_err_probe(dev, -EINVAL,
-					     "failed to set EN pins\n");
-	}
+	ret = ad7625_set_initial_mode(dev, st);
+	if (ret)
+		return ret;
 
 	ret = devm_ad7625_pwm_get(dev, st);
 	if (ret)
-- 
2.56.0

