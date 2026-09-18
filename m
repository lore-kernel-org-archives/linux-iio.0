Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7F4A2E32;
	Fri, 18 Sep 2026 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717016; cv=none; b=iUZi6kxlhHOfV1txPeoNwdcjDv0gQXvRPc+X7/Ito5etDi1p0yUk2JmIWKUysfTWJX7KePkpdRQZwdccVKiEnuGwZv+0g7eYMuc0hGfwhxk245LAW9gjt5udzatvjwnQAJPN/Xm/Db46GxvI6GY2cBE5yS8hAMwn8Xj3aXSxLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717016; c=relaxed/simple;
	bh=BB1CWGAce8kzl2nNA7V8Mf2cWPWwnS69sdS81EWA3TM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EK1KnXl03vJ04ote+whRzD96cVScgG2VSOLptCAnAS0ca563rZ3MQVk7KbDEg+ICr3vhOpuaLg4h7bmqwEppa+HHKG1yEScng9ag/X+VmTOezAcmCRyL5uRPee6kpZ1bRsLmPn1ijBE/2EfeSvFZA+Msby2nLtuht8Pk9ZZq3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yXuPWvkn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yXuPWvkn"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5wRrL3969437;
	Fri, 18 Sep 2026 03:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pub59
	7Tt19iQNAUAhkbhqQ/yDDbDH1KhPbFPriZJEiY=; b=yXuPWvknlmZ74rJq9JDVf
	9ixbw2ALLp7iRXtTSL7dtGl7OTnWl5GtzyP5AnDHmbEJVNFznqLImvrRDfw4YFIf
	I6YAvS9VUx/y6smWh3GgRovUMVYnvqURpdiRIQOD3Z7djLp5yYxVDEW5AkpfoNim
	+PHVCthi5tjv2A9JaFrPfnZvgbOLLTqsRDzxdUmC+gelHac0NujUTV8seFADIdUo
	6lZd+cRsOUFuiw13tfUlV3onq28eojQywXUGg7fvR2miu35ZVsgPMzIWunp4uerc
	DV8GLcXONdYUscoSEkWKb3s+xAvfSj/KEHxn6RVfLVBNR8/J+OPt6nt5ItOHxB3/
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4grk0xktf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 03:36:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68I7aF2g011029
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 03:36:15 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 18 Sep 2026 03:36:15 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68I7ZjpU019677;
	Fri, 18 Sep 2026 03:36:09 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "Jakub Szczudlo" <jakubszczudlo40@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 2/6] iio: adc: ade9000: fix DIPC event never being handled or cleared
Date: Fri, 18 Sep 2026 10:35:31 +0300
Message-ID: <20260918073537.1572-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918073537.1572-1-antoniu.miclaus@analog.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -gkmVFXqn2LvykUChoaKkxncRoH_9aBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX4YMLN0YAQhDu
 tbYuMknz1NdmipcL4f1N4aQEIYopx2tK96P4a64b6MgTSnP7AEkSeKZOBA68LPxOqCeZcArmC0p
 5Yup82ZDXpEkUI/AV2kjWNpbGvDbfemjQ4f3FdTFUra86OL/aL79AoeM49crjDnpVD9DNU0sLKn
 zEuQWSQId6J5E8/1X/rSQGp6KRokCfwKHlBYP6oGWsQi9xGm+HRnbEkgOP2SV0Y0MnjO0vdChQi
 lYE5bBWcpcxGPyoa82a7NGKcHrHzw/FBVgeBM+uJcG367dgqaVw63q/otaKM8b1PzDOlD9dq02C
 5aFY4YAsDfp/WQFXmIuS9CgMRnqcHYPROua1AyYxfqPitQIKLihd1kkCLaidseqEYbsC3mVz8ef
 sITRe6SsjgvMfZceWoFqRftG738Bu2ZY1NlRUY46IKq6h7uNGWUK+IYA7OsF8TsBzNh/yXu8SDK
 9J24Bg3KeluyevhOGCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX1Xeac/kgMe1Z
 Kz03B2qarRFwXfAibVe8RBgNmZlWfw7XCHKUNrvCkOmNMAcGaFaViA1J2uQdgu0sD2Nqdp4/7UV
 IAkTLYN9HR5K2TdbRFlonMgFwyEi1qUhUXCKsd+NQjyCNPU79L/B
X-Proofpoint-ORIG-GUID: -gkmVFXqn2LvykUChoaKkxncRoH_9aBC
X-Authority-Analysis: v=2.4 cv=OtXaWC/t c=1 sm=1 tr=0 ts=6aace9f0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=UsWkN0LNHv3q8H0V0WkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180102

The STATUS1 interrupt handler scans the enabled interrupt bits using
ADE9000_ST1_CROSSING_DEPTH as both the bitmap size and the exclusive upper
bound of the for_each_set_bit_from() loop. ADE9000_ST1_CROSSING_DEPTH was
25, so the scan only covered bits 6..24 and never examined bit 25,
ADE9000_ST1_DIPC_BIT (phase C voltage dip).

As a result, when userspace enables the DIPC threshold event and it fires,
the handler neither pushes the IIO event nor sets bit 25 in handled_irq.
Since STATUS1 is write-1-to-clear, the DIPC status bit is never cleared and
the interrupt keeps re-asserting, causing an interrupt storm.

Bump ADE9000_ST1_CROSSING_DEPTH to 26 so the scan includes DIPC.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- new patch, found by the sashiko review of v1.

 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 0f64bfb221da..ce0317766698 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -219,7 +219,7 @@
 #define ADE9000_ST1_ERROR2_BIT		BIT(30)
 #define ADE9000_ST1_ERROR3_BIT		BIT(31)
 #define ADE9000_ST1_CROSSING_FIRST	6
-#define ADE9000_ST1_CROSSING_DEPTH	25
+#define ADE9000_ST1_CROSSING_DEPTH	26
 
 #define ADE9000_WFB_TRG_DIP_BIT		BIT(0)
 #define ADE9000_WFB_TRG_SWELL_BIT	BIT(1)
-- 
2.43.0

