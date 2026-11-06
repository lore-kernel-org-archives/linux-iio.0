Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981160;
	b=MaIVk8zgIljXuvdpGla9CItCRBpfB5wvA/mVHelmGnfynCMzeE38Tm7sZJ7AdiEAK4Zi
	 BOVQx+6wPSjdBtqu6SGUg/EmG19dh0SRygbXH4uuf6Deum4g8FnExU8YtXjCiWXIU/6Ci
	 oDtKedQfkHbchqLmMrq003sAojJa/MEJZ6W/JDAp25wacehOAPuvM0eF3LD4d0ibXf9q9
	 wGTeb4FX53oFBSzs4y6NnIMlUQ/Ud/b0veLNJuMpNffLvN7sdMkLfzzH/aZwUYGkHZ5Pl
	 x9MIDuuzL9pxrMoT37WPCbL1GOaeAQAH1YW3XaYi7KAMvmKWUOP9NfgHb9XWSz9QAsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981160;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tY0mVm6O9xO7BawWrhONFNvGhSusx8KB/Y3k5RrhliE=;
	b=eQQowN3wQ2OtgSyp1z79Stk49cc7EsVrzzOHaOk0ZL7G4FZMxY+EBHbQezmUosQ6tGXX
	 QXe0kyytM2kGDK5zZTe+rRakrVmdsuWmhiiRwDbeiNxzjRS+gxeAZRgYYU5xaX7t3NgpE
	 VWMSDQb95nTaCjY9hNeywDbqJak+nUQfvSSR5zPlLLsTSugjqugwyCrvzNq7e5BkWu1ME
	 wdMgSxSpwlwLNDeD7XZzLqsVXqlGrNu6AMK3bLXKHBI1MGNbTqMcEdqpMBRhsitNIrL4O
	 2gAPcdSxUw6zYCH03/+9SsXupwC/EVC6CxdHGNOvsnIBPJxGZNuHwbaOMqdqyf8CRyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NPLgX7OR;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=NyQMYTue;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C62606A32C;
	Fri,  6 Nov 2026 16:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31C62606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NPLgX7OR;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=NyQMYTue
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F3qqk1282654;
	Fri, 6 Nov 2026 11:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=tY0mVm6O9xO7BawWrhONFNvGhSusx8KB/Y3k5RrhliE=; b=NPLgX7O
	RrxDwZVyvvFGd2Vnt+0wYw7ho4HcGJFUEXdzL6mg9Fzq0G1oFfKlAvtDldRy/O9d
	b2f1lVaOJeR26hVzj+5hhrTqbtO9m5U0KuE/6zq2hQrhf8XYgyvg3v+FhW60bkFU
	0+y1VMgqaOXeUyHT9msZ3zbfVxNn2y7KOQibl/wERw802VhkHTQbH7DWpkPtWrNX
	/lcYCBA6LvymxPIDMAWUfWIYu6rMzMLeCXJmm1MfmFQjt/EE48i3RLyvzYv8xHQL
	7dFktqbWFLkcOkESfnqsPMCcN1KMNYNI1LGVdv/YuA1fKCBbCc8/uYGUeqbHp383
	Q42NZEBKoID/Fhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tY0mV
	m6O9xO7BawWrhONFNvGhSusx8KB/Y3k5RrhliE=; b=NyQMYTueQjL+ZzCiIRxu5
	SZOVhXctvrG2Kk3D/wNd2WB5ubBe8gF8DSlalSD0V5eIOrQDK2aZXDAZ0rjcB07y
	dWlmAB0CV1DL/e46pjqowG+ttOyXrp7AWZmKNRRM4UqMEKBE23v0z80xE4SYxCoq
	p4/VctZyqX2wVHj0wVDEhEO2k8QATpSiX+VoRm2kkt5h8pi0jxp8ZI9huFXFn2Uv
	9vwzP2/K6iQu3N0yCf8LtfAPDm3KNO4njQNJS4iXWhdt+iFW2Hha284M028Y3pbo
	32DDqFCiyXAZpMehJNeAtWhC7wkczZHimlKsh7kBrb5+GkNSWlGSP5b+kGMgpo2C
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q1d51d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:05:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G5uDd052485
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:05:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Nov
 2026 11:05:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:05:56 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDM016340;
	Fri, 6 Nov 2026 11:05:48 -0500
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
Subject: [PATCH v3 5/7] iio: adc: ad7625: move initial mode setup
Date: Fri, 6 Nov 2026 18:05:17 +0200
Message-ID: <20261106160529.876251-6-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: Hpr1XrjTgCMk9pFScYqlvxU2rvRNxNkC
X-Authority-Analysis: v=2.4 cv=EqNHPicA c=1 sm=1 tr=0 ts=6aedfae5 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=A3St65Md6WrJaiS9qTEA:9
X-Proofpoint-GUID: Hpr1XrjTgCMk9pFScYqlvxU2rvRNxNkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX+k4rLnwUjVoH
 NQAc9lMGWTZO0a5EhyYJNnB8zBuPbwnNViu4+jW3ffIwz7u7zPqD9a346rgw6TZY8GWKH0VBIHW
 6eZrJ72fPmljKXZKnH8M7qAjLuALc42PjLOxl5gqmS8TMxBipKJPE8HPtIjKLmwcLezBWWGkUcq
 SVwtIlCvkgvGPyWOhohtEmJKm+MSjc1GJBI9PE1oLj8tfs9Wg2s3c98fpF5a8c+GoQBEns3hWQM
 NGecFVkhjqBi7Gc9Vhr9ADkoFSBuIUCfehotINFLnmmSFiokWNa+Ny+YGrh7Oc41cYQ1wLkzj9T
 5K7bqvYDfop2BnNKfiSOkJnnQrdT5d7xyadXSd7ICV3x2Dv2wgD0CJGtfO/QkogSWHTVYeunVXI
 GBKJkXD6CWI0n7N5qI8an//0S4QIO87BMuJuF4eIRBz3S8neYLrmaBz4asbxjQfZotvRX6sdAl6
 kS3RmluyHfQZM8f2hKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX9oGJcSp5oSmL
 Oz5umHJSuCiCzZFaLQT9cVAY4Ehb2Z7c4ZdF8AAJzi3Zm9WtUQGMJn8OFJGxAwfqgwjoqfXlGCA
 hwESAiM60ukhWuXI7rueEbw7SUHp5NEDW4hMZaTt9jZA+L8xDXZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060063

Move the EN pin mode setup from ad7625_probe() into
ad7625_set_initial_mode(). No behaviour change. A following patch adds
parts without EN pins that skip it.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/iio/adc/ad7625.c | 57 ++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index e699a7023b02..133c83df8a52 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -561,6 +561,37 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 	return 0;
 }
 
+static int ad7625_set_initial_mode(struct device *dev, struct ad7625_state *st)
+{
+	int ret;
+
+	/* Set the device mode based on detected EN configuration. */
+	if (!st->info->has_bandwidth_control) {
+		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mV);
+		return 0;
+	}
+
+	/*
+	 * If neither sampling mode is available, then report an error,
+	 * since the other modes are not useful defaults.
+	 */
+	if (st->can_wide_bandwidth) {
+		ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
+				      st->have_refin, st->vref_mV);
+	} else if (st->can_narrow_bandwidth) {
+		ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
+				      st->have_refin, st->vref_mV);
+	} else {
+		return dev_err_probe(dev, -EINVAL,
+			"couldn't set device to wide or narrow bandwidth modes\n");
+	}
+
+	if (ret)
+		return dev_err_probe(dev, -EINVAL, "failed to set EN pins\n");
+
+	return 0;
+}
+
 static int ad7625_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -595,29 +626,9 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Set the device mode based on detected EN configuration. */
-	if (!st->info->has_bandwidth_control) {
-		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mV);
-	} else {
-		/*
-		 * If neither sampling mode is available, then report an error,
-		 * since the other modes are not useful defaults.
-		 */
-		if (st->can_wide_bandwidth) {
-			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
-					      st->have_refin, st->vref_mV);
-		} else if (st->can_narrow_bandwidth) {
-			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
-					      st->have_refin, st->vref_mV);
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

