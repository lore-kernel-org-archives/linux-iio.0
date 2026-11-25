Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626719;
	b=sotswBNVJvu4gp8lrZn6gwhHvIMTOM1i/LnudZHt+KpckSHEb1YID0U092HsVab6IPJy
	 wAVO5H6avc6X+fMtzxVBxUxySGY3KQA8LMRSO/7mr1TYjBs4/+XjBmMA9YRJl7zXwHElM
	 uNS/NeoOuLSRJqg6IkI0NIrwZjiQPjn0k8VqTh9GYkRx/v4RjLixV674lUdnwPjyQouFH
	 QqYa3/wiJ/ioS+2XeluumO/onh0dI33YS9nz4Zp0FYl71JUMUqCeUdUtImmaU1UMBiPi/
	 P5eSISX7vZa/UK8Iy08oDM2IyMOf0zmzCXYavD9Qd+EHiG1V3DDr9uejBKbimt97Ayw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626719;
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
	bh=5L/iaFssdhUU7yAD0BBBvV3TeNOBkXEWhs59SllU3uk=;
	b=lBhb8n3WLaNSdsxlQhAvE09a0OQCsL0C6i6nOOCkWm1PaxGbpja88X5g8lXnFmg8ZMNx
	 CsGxatJAagBtFSWnc0MoBuG5IzMTH0rPwWWnK9tiBvt6t/xK7zv8xhZggZaKBCENecC1g
	 krK26Vf2Ay/e1qZnsrhmsyNYDU1wC5SrjjiJZvGap2MmL21xLJoNcA3QtW2WijGjSKNSe
	 KGCKhMLBsErIeRgHEOpARQSKMOihAqahtz2xlsc1NdCYDjJgVz9ENpKUijXp1mPKa6zcc
	 jNB4iGb8OH7TtLuAOYZTK3Y0cOSx04dxsoqdHGL2E1KBuAzw3l8ErJKszX2wVxtoZyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z0wrvajT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.14
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6381606A31E;
	Wed, 25 Nov 2026 17:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6381606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z0wrvajT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFs9FaS1HGnmD+SZU5+/H+RwY8iaT5y4hg9aay2wsiJTgfYIsSSaMXbqvpREn/VVB47xAIm9nuLwhep5dLUWhTrBqftGPHKUnToZy51kW7pEgMtl1x/bwvNxjl6aYQU0PwEF/Ts20IgFVmMhSgsqBd4KpzEiu7qq8apb3hmi3SPFNCTWm6MrU65WdsEn7qAFVnRMq67ZXgt3bdCDDI7tML2KwISN1QzYyIK69HjyR8N2qAWeDEmUfSDAVaOtL43Tr0hi/e7Zsz99nf8FGKlBuo8BgFwfxm1ItOQqe3NGqfd+B/ef2WxTG4DFCtjwJ8OtXnUTai1ss5V19W5ePGqdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L/iaFssdhUU7yAD0BBBvV3TeNOBkXEWhs59SllU3uk=;
 b=EwkcGx12fbrHb0KiRG5hbWHOt1kEf+HFUT2IWxk/W0BL+55RIZP5KTfUUHd9EYUiDb/9WrPVBVO6uJubtQYDX4qxm4+cNTuoBnDf6HytPurIcao7yf/LJB32IRk6ew0juUZZWBYXaDRED+fFs0FTVIcAmlvTaU3D2kL61kDSI3Q4FibbReNK6EFZB+Va9Bzrhpl7+8BqR/pwpM36NXKBz+CvA2HHiyKZXov4Avdfd1sM09IOjvu/Pr1u4f4aWBCv4ZZD4Bxa3O7AgMwHV0LSRhNVd853/X6d26VZoNkCAyx2oTIT2O5D+3vyroR4fqbDAvOB5/UiYeRs+a4rGO1dSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L/iaFssdhUU7yAD0BBBvV3TeNOBkXEWhs59SllU3uk=;
 b=z0wrvajTTzop9MCoqsSQ5ScYVMw4r87gBfxxMdNp1+0MDeyKjGbXnJpp8ftn2L8b0nmVEwcnHZ1IaRFQSSP80TEUHEAQSmliFB90t/Emq7p1s+VbgTNdGou6i4unfjAKBnZKjHnME9XV9OVqtgnurhaT6HzWD0N5iFXXT+G0l1M=
Received: from PH7P220CA0096.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::25)
 by CHBPR12MB869915.namprd12.prod.outlook.com (2603:10b6:610:406::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:11:37 +0000
Received: from BY1PEPF00026968.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::8d) by PH7P220CA0096.outlook.office365.com
 (2603:10b6:510:32d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026968.mail.protection.outlook.com (10.167.244.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:31 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:28 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 09/16] iio: adc: xilinx-xadc: Simplify common coding patterns
Date: Wed, 25 Nov 2026 22:40:23 +0530
Message-ID: <20261125171045.1246381-10-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026968:EE_|CHBPR12MB869915:EE_
X-MS-Office365-Filtering-Correlation-Id: b3325808-9981-42ea-3186-08df4b1729ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|261009223027099003|18002099003|22082099003|261022075727099003|10067099003|261102123227099003|56012099006|11063799006|261021123027099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	TAHdIpxRFW7pWlWBoyDl2S8Kj4C7FiXzgk/p7bXBLaE8CIg3uu6iwd4SGqSiKmf9Dnfr9yBBlBB8nmy3N1iSG3sD0Bp61Ksw7j9V40leodxyNaScKSxkH2mwdmyE+G+tercPTQismx/NCn8MRSSrlXT2ObuVIoXDGsjlCTfRyDjBVkKsbSGOylWcX4HeIUF/oHtey2Wxv2QvYKLt2/vQSm/f2k4PaCH30g9//osN7lF/4EhFMP9QMUu/7BZ16NJH5TbDuVn+y8j/FIE1Y5kulzkBtGpZgSvIqG7dxI2dESSgj2omST936IFSiybZE5uscPgFDLWz27B0lwZgnHEKOySOAlZxYjhEC4OMsV8tYRRnD5x1ZAbNEdVe15YHpMRm7birHOVdVWEE5KOL5EdkLo/+JiDtCWeMrhsU45v+tHnWmLyR5ez7jwi/iQLhvcbjmOFZhw0slVg/jnmuuFH4toudb5S6F355RGJvPyf333yoYr6QAL463hy4YQY0xWaumWorXOxFRxTww/ZUnoi1sNc0rI9CAm4U6T9xsZoD5HRXV1c8EwHlNlZ9wqHeGTSqCZpjDx9BdbViln51U5YwUZKu+H3vrh8r4tFCfmghejdYL45K3yMTBzsYlw1OxuhMvMl3qUklwcmuuGjMIsbMAaAaeEfsanTwqgUlnT4CdIUyQasLVm86IK20EvelLwzTJj84fQhJXBFT508V9tQY4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(261009223027099003)(18002099003)(22082099003)(261022075727099003)(10067099003)(261102123227099003)(56012099006)(11063799006)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rZ2MgZaSl4Jzi1Mgtyn+bt1YR36GRcRGe3y9OlJkI/kXCBjN+ktqQJB8a+mB4xvf+jVW3bWZeb7CAJ+nXEk/BbwDi15sZY7OIBCXYTEi+3+MmuiI5A9AEl2UWrUHwObPFBI9yOEo5N9sbPHgTf60G4YCBSCPmaPZddpfE5sVK5/oJgRPy46ht+MT1eDappEef7clAHtkiWXBItpG+SABr/dxJzNc0qRog8eobx2hOj/SjsoUDulujb9xkbAz3J0n/AC4/TAJvM/G8xq1bBJLPZGiTeiPNfwZYoitVJbtTVxMlJz10Sy+mw6ailQbUY5FH+f69mc8yDCoyNxapTDDmyyHLGlKdY9zowgNkUpoPh5BdHUToHshxHz9413CC8H8aokwHzqX0LwbTxQ+00Es0kmv37a+iZ7s01glqAURGYo//FEwJL61wpvh4Jic3RAc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:36.9456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3325808-9981-42ea-3186-08df4b1729ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026968.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB869915

- Use pointers directly instead of comparing them against NULL.
- Declare loop counters within the scope of the for() loops.
- Replace the interrupt mask update expression with a
  simpler form that updates only the bits selected by the mask.

The last two items were bundled per Andy Shevchenko's suggestion
during upstream review.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 99c83b49f32c..8801bbc7431c 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -143,9 +143,7 @@ static void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
  */
 static void xadc_zynq_write_fifo(struct xadc *xadc, u32 *cmd, unsigned int n)
 {
-	unsigned int i;
-
-	for (i = 0; i < n; i++)
+	for (unsigned int i = 0; i < n; i++)
 		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
 }
 
@@ -163,8 +161,7 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 
 static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
 {
-	xadc->zynq_intmask &= ~mask;
-	xadc->zynq_intmask |= val;
+	xadc->zynq_intmask = (xadc->zynq_intmask & ~mask) | (val & mask);
 
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
 }
@@ -672,7 +669,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 
 	if (state) {
 		/* Only one of the two triggers can be active at a time. */
-		if (xadc->trigger != NULL) {
+		if (xadc->trigger) {
 			return -EBUSY;
 		} else {
 			xadc->trigger = trigger;
@@ -713,7 +710,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const c
 
 	trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
 				      iio_device_id(indio_dev), name);
-	if (trig == NULL)
+	if (!trig)
 		return ERR_PTR(-ENOMEM);
 
 	trig->ops = &xadc_trigger_ops;
-- 
2.34.1

