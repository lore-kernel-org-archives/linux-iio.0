Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D83624C1;
	Fri, 13 Feb 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994290; cv=none; b=Hup3BdqI9toK05Hdt4eC0UlBjOzilSvn6qO3ReIriQ7poafOyYPzc9lYJnahLdgKMG7mW/gR1n4PAgj49SvS0SxyvV8bJLtCNr+noIBQ1+/Sl9dJCEzsw0rVh7ACHn2Zfja/hzub2HD3ekNh7h2kRkrDnMDJrtLZlXLQ7vWFQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994290; c=relaxed/simple;
	bh=ZT4ZAOqyIG30taFH9S9au4OBNbx3wEjgRXdc/PpyFs4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMpY4oYPEJuewhxK1+wf6Y31e3LN2oTxZxxeWrR9QW6DyPmaPYJOUGrNejAt0Feb+KggtrZalueG+P5XYXEHuEUJnPyzVXii7Ye28LDVTpRNgoO0ttHPKqz1247B/Wp93HDsjtkMpASGT+QQJ3VVag4pTGeIHCMvC3F7iG/Ia6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PTJTGhF0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PTJTGhF0"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DEEPLb2059642;
	Fri, 13 Feb 2026 09:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/v/Zo
	IRTTQ/8Px6ppUMgx+x7Mfdo7atR/p62S2i+eJc=; b=PTJTGhF0UJjg2T0Cjs/eG
	yY1/h3y24a0EeH41xdEQ+SjA0woodNGyLW1EioMnBFkba+i+d/gfmIqzbwXpxwx2
	40XKrauFz1wmgyj5X/uFqpj+jaBcqRQOW9KCDC5il+HPRQhKLnrNOiliybK1jLo9
	+UzxHwbJqck3PM6Wruy02KmJv+r0TCQwka7CKosb3Vl4VHU3AtjaaMI42v7TDIpP
	7sgqBtEt2KHt3SdLGqcpcp4nePpd9qf16W0c5tvZVyhIuUlS3+LjAMpQ2UB1Zc9T
	H6/BO/+XqF4XphK00xprcsXV9ObU7LiJ8SMllt7fwRbGQg9BXE7GywDtomOFomzK
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c9ss6atat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:51:12 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DEpBOw041662
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:51:11 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:51:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:51:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:51:11 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEop6I018676;
	Fri, 13 Feb 2026 09:51:06 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3 2/5] spi: add devm_spi_new_ancillary_device()
Date: Fri, 13 Feb 2026 16:47:34 +0200
Message-ID: <20260213144742.16394-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213144742.16394-1-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNSBTYWx0ZWRfX7yI8YGBXOw23
 j6lSMSIkBWmE4is7bgG0XjgagPPwyb2IJuKYVEhXJ9kJtSjjBaXpwKBgon41juv1s2IqJ7wnh1S
 9xa9L9N8lYdf3LZSMOX/Ez9HRAfpQL5RJrWAJH3u4dWTzyHAI/XvDmFu0+N6023HQUaFh9z+ojU
 gaz/VcFjKNV7QkZuJIilDuvqiMlKBHJXuIYG6r3XcGh7OjIy775kgsboamSzGVYEWpE5Fae7Iu6
 33SC2fQEjBIMsxux6QUnVxmxyLc4/oA+rnLBY/nP+ynn5fh6Zcrf+FXl3Ym5td3yKB9CVG67+0H
 cHbfzGxLwzTY7XZOTNA2nIPhmJFXidFN6p315rd9inT2IsYuY7rook+lFQN/frl/OAUdD8KJSR/
 nlC/Wf9+j3rEG8HXk3XyGmw36KMwnU1JP0FfQ5Jxa5IaEDeYNKFApHqJTWxV6DOHmJLXs1+A2Uq
 aCkrcl7B4LJrAGpexIw==
X-Proofpoint-ORIG-GUID: qpkNySJjeSSW96Q42z9JzUkF7tJLQLEn
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=698f3a60 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=8fGt7KVEpqQUrG_l--wA:9
X-Proofpoint-GUID: qpkNySJjeSSW96Q42z9JzUkF7tJLQLEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130115

Add a devres-managed version of spi_new_ancillary_device() that
automatically unregisters the ancillary SPI device when the parent
device is removed.

This follows the same devm_add_action_or_reset() pattern used by the
other managed SPI functions (devm_spi_optimize_message,
devm_spi_register_controller, etc.) and eliminates the need for drivers
to open-code their own devm cleanup callbacks for ancillary devices.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
  - New patch

 drivers/spi/spi.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 693bdcc5a12a..1b48ec67b8e0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2612,6 +2612,46 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(spi_new_ancillary_device);
 
+static void devm_spi_unregister_device(void *spi)
+{
+	spi_unregister_device(spi);
+}
+
+/**
+ * devm_spi_new_ancillary_device() - Register managed ancillary SPI device
+ * @spi:         Pointer to the main SPI device registering the ancillary device
+ * @chip_select: Chip Select of the ancillary device
+ *
+ * Register an ancillary SPI device; for example some chips have a chip-select
+ * for normal device usage and another one for setup/firmware upload.
+ *
+ * This is the managed version of spi_new_ancillary_device(). The ancillary
+ * device will be unregistered automatically when the parent SPI device is
+ * unregistered.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: Pointer to new ancillary device on success; ERR_PTR on failure
+ */
+struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
+						 u8 chip_select)
+{
+	struct spi_device *ancillary;
+	int ret;
+
+	ancillary = spi_new_ancillary_device(spi, chip_select);
+	if (IS_ERR(ancillary))
+		return ancillary;
+
+	ret = devm_add_action_or_reset(&spi->dev, devm_spi_unregister_device,
+				       ancillary);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ancillary;
+}
+EXPORT_SYMBOL_GPL(devm_spi_new_ancillary_device);
+
 #ifdef CONFIG_ACPI
 struct acpi_spi_lookup {
 	struct spi_controller 	*ctlr;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cb2c2df31089..9aef1987b12f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -374,6 +374,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 }
 
 extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
+extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
 
 /* Use a define to avoid include chaining to get THIS_MODULE */
 #define spi_register_driver(driver) \
-- 
2.43.0

