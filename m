Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793622104;
	b=t7pRhRdanpVb70RRIIllmLF6OX0Qtl0F61EPHx+i1Ol/MSEcD54cIrm4CQEF0JgxwEr1
	 PVagBzatM0FUZhL1IedHufWnMk1mVnnkcu8wPqMgA56XRkI4+SR85+0EBNng0rfqBE+P7
	 AsgaWeddcDBMIu+8QJUUdN+JOeqjbqk1onHYkg7Ulp6pdy6Si2QJi6HIx3PBYfDea42q7
	 thrXS1863MpOwF6Cr2S1iTgbK2YSxIMDNLsRcKiqO5j6o6TFeva4ev8d0hAfNzP7vn8st
	 A/TlSnzGFP/aChKVxf1jwKoGxsSJbPFogWCgCBFwXUnOrYgCfDroyOLEGIL60d4k9Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622104;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eoTHRu+h/Ubhiu3DFCjbwLq9VOu6SOfH62CursHRbe4=;
	b=PckkthW1p/seo1BIJViNWYP3ieWiI8bn07XslMtmXsCKycDkSTC9RDYrgw7ZTEegafzm
	 AcYdgtIKStc0JOZly/Dk4Lv5Bun+rALEdnTvMHVKPtB/Mx8xTJTra7piAWv33Oiza3NWi
	 vlVSbGTxitXzTVW9XSbN8+RzIscwQTVGLf1+d4CFHNVg+sh5DvmWoOtCOHaYYafFjUtq8
	 OQxrMdTprpOC9fkZZDBXb83o5/bzFFdipjIlUF7Gak7hEjPMVUJIJwigD/Ph4bImgOi4H
	 VljBEBmTUnMWdPGU2w2neUfR2Pz2jubG6QWb2uawC1ViIaQ9tJiqqoEMIPosH5O8lLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1EkGI3Yw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.2
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205C60A3817;
	Mon,  2 Nov 2026 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1205C60A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1EkGI3Yw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/Vwxr56657RFHRRM1KNGLRfEItEZQ/WTAvg4kPo66txucMeiBMiSf8vAIKi2S6Z6+kSBaqv5ts6ywe0XZWxBKgWe5g+Igi+Rz3t6UnYiGwR0x1WxBTqRvJD1kYyy4dLwS+OHk1jwByJPm0l+ngNAfdboZcltCuch1RvpwctpdLIAshuG/o2Q1pDPytkW82XRWZmIyb0wjUERNrhPhXJYg//xskgerRO4lz52aMuJjex+3qWx8cq8LPukFonbPmkKCvBpHRp0k51wlwk1Z5RAwPqDSh5rJmEeUJKEpXC6HL4Zh/bNntrTqDMJBlYjjwDOKii6gF1OzaBP0kOy4f8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoTHRu+h/Ubhiu3DFCjbwLq9VOu6SOfH62CursHRbe4=;
 b=UH1xPl7TiSxflmmLmp9BjehhP/baG6skEKrQImmUCkdtHh+RKSnD8l/PvUwHS/VV4PZ4o/99pI8VF0BMvH945JR2Ao8MuOFWongC0z5QoylxNBG6BRG9+493+SWUKHxtAZDcPaM5SlOAuUldKR29yQAR7YzP+kqBOkNf3uJnec0aCYR7uc7JdKw0sx/zIPVwaanoKslc9VrjqHWEravjMmes1BXPJmau5u9VWTYp5HxopayfZ+qxaBUYqzVtpU+J54xW27n6SO0aEoy1KYXhLHeBW4cmKK16ceAaKMVUH2Uxvb266CQmWiaEGz8h0nGkaJlx9iWxa4dfrTONEtqqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoTHRu+h/Ubhiu3DFCjbwLq9VOu6SOfH62CursHRbe4=;
 b=1EkGI3YwfDQ1OgnoNa/orvUVpd9kPg2SxGCjkLBzEElzdz+inTaTTGHiXehuTsR+Xvzxf03y3x2yHrub+l0tS+gyO6+XF2I+nfWYy4gghtNUEowmnlOIXlxoTNkn5JfYwWd626FyqkG9rGLUmndXViPcGOhc2NzDeZDpfapNV0E=
Received: from BN9PR03CA0631.namprd03.prod.outlook.com (2603:10b6:408:13b::6)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:21:33 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::10) by BN9PR03CA0631.outlook.office365.com
 (2603:10b6:408:13b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:21:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:21:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:32 -0600
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 06:21:28 -0600
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH 3/6] iio: adc: versal-sysmon: disable interrupts on shutdown
Date: Mon, 2 Nov 2026 17:51:09 +0530
Message-ID: <20261102122112.1723130-4-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 73369430-6a4d-4724-d38a-08df38dbd4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|11063799006|5023799004|56012099006|261009223027099003|261009221227099003|261022075727099003|261021121427099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Dgf0wHY9OzUPkd9Ggjd8LNsaEHdPu0Z6AmVAmasxikhEvL4kf/3+cHo5IUThMfezljkGG+N5fwXA6o2HsTfaU9WFmjwJ7t813/CN48yOxJDneqbk6Hmh6dRgz6RlaC6/JdHo+c5S9vtd07H6O3udjwB/ClLTBGp8xd/U7Uaw44q9OFY8OkMTm7RIV3sWh1VSkc9tpurN47eNtJamDklCKNxlvUDw7LWcmR/DaQhadgBj9fhquBThovuAZ+3jzbr9xDMC4PAkU3nPbHodVUJ7pVD19J9HA6kX/i1epccz3f7huDr2FQDYCEyAYPfVKa8RFgrvxFJ7DLgIfH0UV6eCavJNdaWggBRMLtFIFvCyB86QOeNIZ40k+Xg3geLFFPQuNJ4b8SOqGM/6EzbXB2klph+EgR3hLsGQJITAG/KBKpNW20dLH5pRM/ULRzbfDVqR9rdaLAtnrJk3w5JR6YVeGVid1CgMPsosS35vytah1sHC5/MlgGA0q8UKDgsTZGleerrtjbuDr+lFq2juLF8G0ZhWqlSSgmssCRWTCGFlc8qZBD+vcvF+iFc2op9qPpRhCAnUc0AO2pf9XAdzM6zUWRsREfT/MsRg/cWKSo958H5bl88H3rMJv0olAy9dP2X0eru8dI70QrXzROFf708nnhetI4P6rtx+4VSTCnFm/3DoEfMLcpbDJ5FwxxYpFO/W0gg2kc40xeXgWeChPZFd2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(11063799006)(5023799004)(56012099006)(261009223027099003)(261009221227099003)(261022075727099003)(261021121427099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cWECBWIhU7wBKmgsDMraIRuQcKwx/N1gMbKYKBJRi1hGJeJdX4UAUPGTe+i/U3+Z2iPWuX2zeAcK+2tsf+ZveUsxdCzXoKOE9KCXo1sOJAp/n02NRfohpKll8d0z6gyuAQIAmFu44Z3dGJy8/w4DvfO8sX/KjgIOcinDN4BiHjL72pSSvJibHhGMuMrDraR3nNc1sWM6ngSdwfmOVoiVwCi/jHT+ZlLzaC7xBFxqFgy1Mn5eOsrgwzd7+LxDwVtj7A83SfAoEs++CChjLhe5vNdg/VT0sGqhCQU5mMgzRidb4zJWMd4wA+1veP/6eZtVlimj4I4YyeG7PeCoU3+ruJnHbgUOdxG/+u7Ym1TdHio1Z2zHOloRH8SdCIQE+PEpmNTY3XrXdS7AZfszGu7liX1prOIw93WPMIMbrd1kq3UFLEw4EBWbXjzy2R5AWn/X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:21:33.0880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73369430-6a4d-4724-d38a-08df38dbd4ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345

Interrupt teardown is registered with devm_add_action_or_reset(), so
sysmon_disable_interrupts() runs when the driver is unbound but not when
the system shuts down: device_shutdown() invokes only the driver's
.shutdown callback, which this driver does not implement.

The device is therefore left with its alarm interrupts enabled in
hardware once Linux has stopped servicing them.

Add a .shutdown callback performing the same teardown, so the device is
quiesced before control is handed on. The helper lives in the core
module, so it is exported for the platform front-end. It skips a
device described without an interrupt, which never set up interrupt
handling.

Disabling the interrupts at shutdown is safe to have and not a must have
requirement for shutdown.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/iio/adc/versal-sysmon-core.c | 19 +++++++++++++++++++
 drivers/iio/adc/versal-sysmon.c      |  6 ++++++
 drivers/iio/adc/versal-sysmon.h      |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 6595d07038c1..d39aaba9a8b6 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -1000,6 +1000,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, indio_dev);
+
 	sysmon = iio_priv(indio_dev);
 	sysmon->regmap = regmap;
 	sysmon->temp_oversampling = 1;
@@ -1050,6 +1052,23 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_NS_GPL(devm_versal_sysmon_core_probe, "VERSAL_SYSMON");
 
+/**
+ * versal_sysmon_shutdown() - Disable SysMon interrupts on system shutdown
+ * @dev: SysMon device
+ *
+ * Interrupt teardown is a devm action, which runs on driver unbind but not
+ * on system shutdown, so disable the interrupts here as well.
+ */
+void versal_sysmon_shutdown(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+
+	if (sysmon->irq > 0)
+		sysmon_disable_interrupts(sysmon);
+}
+EXPORT_SYMBOL_NS_GPL(versal_sysmon_shutdown, "VERSAL_SYSMON");
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("AMD Versal SysMon Core Driver");
 MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
index 529d0486c9f9..4d5e3d14cf15 100644
--- a/drivers/iio/adc/versal-sysmon.c
+++ b/drivers/iio/adc/versal-sysmon.c
@@ -71,6 +71,11 @@ static int sysmon_platform_probe(struct platform_device *pdev)
 	return devm_versal_sysmon_core_probe(dev, regmap);
 }
 
+static void sysmon_platform_shutdown(struct platform_device *pdev)
+{
+	versal_sysmon_shutdown(&pdev->dev);
+}
+
 static const struct of_device_id sysmon_of_match_table[] = {
 	{ .compatible = "xlnx,versal-sysmon" },
 	{ }
@@ -79,6 +84,7 @@ MODULE_DEVICE_TABLE(of, sysmon_of_match_table);
 
 static struct platform_driver sysmon_platform_driver = {
 	.probe = sysmon_platform_probe,
+	.shutdown = sysmon_platform_shutdown,
 	.driver = {
 		.name = "versal-sysmon",
 		.of_match_table = sysmon_of_match_table,
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index a1ac3289719c..a21dacc13471 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -122,5 +122,6 @@ struct sysmon {
 };
 
 int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap);
+void versal_sysmon_shutdown(struct device *dev);
 
 #endif /* _VERSAL_SYSMON_H_ */
-- 
2.34.1

