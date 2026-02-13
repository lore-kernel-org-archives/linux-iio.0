Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FC3624C4;
	Fri, 13 Feb 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994053; cv=none; b=GlpUboVuuNUWKuIWhHNFk/Z8Nexkq6JR9UiMJjbIuwwMCkMpywoY7rmu+zuI1gnqIBbwfixfX/axJxbjt4XgZdFDbxwyzBTNGqse3Dg0nrN//QqJfEQFRg9x5pg6fWbdP1KbePJRsNV1HFZ9rcFZkekSFchjv+4vv6X4A/ZG8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994053; c=relaxed/simple;
	bh=nh7dfWWprfhz+JXLogP6nMKfrg+GV9NOaJRlqkFqu2U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiJyk6AJnZUeKUD901HjA2mLSW2iwwFnsbsqG7UEq6VT0jBu+m5dtkxkBxLljPSESx5vigfyJSj4JgJsKqRy5VJCfagCdTEth2/SCwWH023Ksw62DoEyq/ArmsNVBe2FsxVaQCOYYFzOwbTs+bM4sfqg98AittIJE/6NxsqsLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T5fwcOKn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T5fwcOKn"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D8J97H861630;
	Fri, 13 Feb 2026 09:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YwvT+
	2Uu+CCsPoEwf+CpeUZiDo2piRorYXUe0vIpWcQ=; b=T5fwcOKnI85uUyquzFpZs
	T8mC1eCbU4kp4tMePtkG9zokeI7p0aBXrwYLrwe150BEKBqSHTb6xmTX0zdOI2zQ
	nKuRntb92IpCQfDh98nTJlMzssRe/eGLi9cZhdZPeWcilsWdAKk5Ndv4d9H49d0k
	D+hzuOZFwbYZ6C1I16j87GqVCUMu9CDiLzEra35SYhazIh3mNnvMA5GxRhtAuk0X
	ZpqZPQ62GxTL3TF+qzCR76k/RBP8du2klMM/uL5pEtqQzplt99idgRQsXSijsxJT
	LIip9TQazZSuMgTwld7T6nsiVPzFur2/E+a8mke9TOR6Lr5sA443XKlEIlso0gDQ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c8hn3420t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:47:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DElGWh041324
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:47:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Feb
 2026 09:47:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:47:15 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEkrH2018425;
	Fri, 13 Feb 2026 09:47:07 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4085
Date: Fri, 13 Feb 2026 16:46:24 +0200
Message-ID: <20260213144629.16001-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213144629.16001-1-antoniu.miclaus@analog.com>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xtfAlixYvrLK5BbWpsu6_Y4IpN1dj-vT
X-Authority-Analysis: v=2.4 cv=AdC83nXG c=1 sm=1 tr=0 ts=698f3975 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=g0LtDnNlmyec7r2dGFAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfXzkAOlpaj5+pg
 a3u0zUo8Y4FZvjiYK9RE07JcJDh/rNERzX5hN4HNDMKaRE4ecJqKCLsf4BKyULp3pgY2ae6t/n6
 BNClEbBzlrTMXge5+ursxoM1wh/zlcDlFBQ6czBuC2T+zSS5KRJbPX/m4BxCp87lgyvyhQyWItF
 l9cZeDm9xd2Qg1yTvT0YqbotRMzL+gtItn8rQhodcMgjYH2AGBU/OMs+RjBTl1xMGIv1/PWJQW5
 zb9OjgKea0JCU8VUQQSr+eDSmfY/PAWxyHOKpdPSZ2Kn+YKjbxjXnUQlM341KtQlJP5LinH9h1s
 BwyVpQRu21NKaq7jyf8ejzqBDwu+0mO6QjD4LQUXb3CBdw4IuQBiBHJQsdPq7G4mESrKMhI5qBg
 XhaFmPQxrLFqZs7ipHfi0fRu8CyCoGd8yqbh/UaYaEzo5fDddm5EwCs5ExngS/CZeCxT0ejfCWx
 bpy3TUuL/bkAU/8YSpQ==
X-Proofpoint-GUID: xtfAlixYvrLK5BbWpsu6_Y4IpN1dj-vT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130114

Add device tree binding support for the AD4085 16-bit SAR ADC.
Add adi,ad4085 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4085 has a different LVDS CNV clock count maximum (8 vs 7), requiring
different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
No changes since v1.

 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index eeabf99f9a12..106267aee195 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,ad4082
       - adi,ad4083
       - adi,ad4084
+      - adi,ad4085
       - adi,ad4086
       - adi,ad4087
 
-- 
2.43.0

