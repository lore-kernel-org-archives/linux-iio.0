Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E830E0F5;
	Mon, 23 Feb 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863785; cv=none; b=PDEWFGL1ucZjggB4LEk8KXHnsRorKM36mndUMSLvtdHkmslIvclzVClUpqd2FiGQTCgIW4xp52h73oCgioTZUs0ZkOXqmbXVITbwBheMpzk3P0RCfb/4AohcijVB/zkBOs7VrOB2EAwTvUSc3Jr92JdtU29Uq+4zjcIxIaAIjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863785; c=relaxed/simple;
	bh=lYp2/cg+kOvLJGjbg0xKDVtE1cRK1C/NgMicQN3K1UQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFeY/FJchslDLmXi27tOo8DiLwmZLi4Mt14pMtHcXOtHv47STXE2q98gMiBkBygKCNkwbCErkwHNdIp2vluvS09cZ8w/8f3KVBx3oPoPe/kXxw1Ycd7ZR2XJXDP0fVnf+1Fb3X7rbOpE/dhBDS+8G8+J4x2FZJ+wfXPndGmwrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BCAfkqjF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BCAfkqjF"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDxXR42668516;
	Mon, 23 Feb 2026 11:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=way3k
	9gfqlZm3D3nBh3+Typjj/TASv1er/RHfkEpR58=; b=BCAfkqjFO2Ea2agxguq9+
	yicRSo050kjn0VLFiO0bo86Q0lbAdVQiaNmrh7+uJMeJJMcCC0lIs8WgQn7JUCF9
	FAg7jyEHyIIJ8AkSkgitkFQH4Jpc2Fz90bn/lU+QL9LmIRihFHlRCZGVOiScvTyd
	9uUcJrwrGgjqL2/w6TqEa8QpxbApTOQgdGxssUnE7nf0ZgZKmWhBaFIMsfVU1v3/
	UwF12Gbtgx5c9EdFIshIeqkoAA0iiVDXvSLC14usNK9KHOhtdyExOmAnyfC7THtz
	auimSxFZ6oKEP+Sbe+AjCzsFh3UgcuPqCG0sl9SOxNuKA3sk7eZ828DeAiq8KuPy
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbbngj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:22:44 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NGMh9n031807
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 11:22:44 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 11:22:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 11:22:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 11:22:43 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NGMJUd015342;
	Mon, 23 Feb 2026 11:22:34 -0500
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
        Mark Brown <broonie@kernel.org>,
        "Sebastian
 Reichel" <sebastian.reichel@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 2/5] spi: add devm_spi_new_ancillary_device()
Date: Mon, 23 Feb 2026 18:21:01 +0200
Message-ID: <20260223162110.156746-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223162110.156746-1-antoniu.miclaus@analog.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: TvdlpOuPdYfz8Hd6-WkXS81e-O-cPPoU
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c7ed5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=8fGt7KVEpqQUrG_l--wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TvdlpOuPdYfz8Hd6-WkXS81e-O-cPPoU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0MCBTYWx0ZWRfX4WrH1N79a1W1
 dKwPGpeCYXAHAwvWTVVMoR5rAQ0FKBqtY+qjEFfn8jHW9G29BMV8NgA9LN8kSy+zuxzwPeS/3Z2
 eio05VQlw8rU3KGY38OQ0qg9cLQ2F6Hf7sThkdV5vw0IGNUuGIs6K0gz1kkQdi23cE6qYet2GX3
 P8ZDho0wVIppnVZ3TQ+zn+saHBTkAafS33dEun/pqXXC7VnXbL0mI2YZTkiCl6Ig1BKaij3gg5q
 +6VigVpWbdf0N0w9KaJhs0e4ETMP4q5BV0ga3k3aQFADj6jR76VTieWHnUSPT7z1bzpeU2bkyLB
 X3E2RnTxzljrEmiCDQpNtXhJRXuhsMj8a8YoxUgrBsElQEqmugsSosuI0xfaeNipWft0zTKu2/y
 GFKbrfnMyT3xC2b1xFHcu1Dhs0I3nzHwxCrQ15okRgLa6vJTDNYZQ5KQpl/lhGqubDM7FxBa4IO
 vmnCu9rUSnA76rr5UnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230140

Add a devres-managed version of spi_new_ancillary_device() that
automatically unregisters the ancillary SPI device when the parent
device is removed.

This follows the same devm_add_action_or_reset() pattern used by the
other managed SPI functions (devm_spi_optimize_message,
devm_spi_register_controller, etc.) and eliminates the need for drivers
to open-code their own devm cleanup callbacks for ancillary devices.

Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
  - Add Acked-by from Nuno Sá

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

