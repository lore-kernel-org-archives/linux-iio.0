Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013006.outbound.protection.outlook.com [40.107.44.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E602494F0;
	Fri, 24 Jul 2026 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862392; cv=fail; b=FEi04lTJIICyq0OnGtTGTuisJJoNiH5EppstdFpsfpB5osOuyRQVEk36eOJXw9jTHxepCgjsxDKLJzs3MKM8Dycmq8LnhdJukYdgRBEtpUctyM8XvE0z1xNxmR1V5+/eP/UJSxkZZ3hTX/vR1bJuSWAV+8st7B6+pUWfLlHK08M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862392; c=relaxed/simple;
	bh=pyQz+URGvQeKMZxN+KjWhXiol1jK0esrGDXarOY6j+w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lkI/QO5SSGslOdAmp2sQwCd6T55hrOsUdgT8KfWbg6smnOkzBII5iGCVbjXO2+3ZwBJ7Sc0SqQG8NC2XWT8gID6hHI8Ffg0BxnUZN/qcG7O9eprFbykBXk+5GYnSEQhpdTEtnIrWi4685GQRaMSm/8o+RyHg7ls3VyAyoSXaycQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=llXxC1wy; arc=fail smtp.client-ip=40.107.44.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="llXxC1wy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSZJXMNkosNBDyA8Gz580FWnCK7bYQmHIxXjseC/Yn73kcJqSuREo9+SpWfRKF+2//LIFJHeDP/Q4YgDbpjxuz9SkFKd508JtCYd6w2apBV/+yBMyKGNuB9MsOcKf3go5UuzrSwqxI9+ltjk5VV0xYPsTLqKAQ3G4NT61QEHc4YRNDADrQaNAfq1UYr97+sGOjWRXatMZ6g1XPA6q7SOLwdp7ylqbXHMkg8gg9RhdkunU23iQnWl4L9dH4/cquGTTn8bKVoBowWNbxgK4rT1SRASuOOP0X4K7/Fq8gaW9hcFB0nW29gdBK/DeePdPmVf6GmRLO08kvh5PuTZSQEPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr5W18JlGPn/T6NtUSBfSpfcFni72AO/QvgVrKf2SlY=;
 b=QpO5eMFpGuR/8edjBm2lQE7PLAWVZgsrCOHqzDJlJySrPfAD3m/52tG/023wuWqrZzaAjsfwIqAFh2AQgp9/c+O5rSIE3cEYhIHyyjdDqsbMZ4YTMuDCcTLelXi7tTyoo7jUe83LUP7wzY5nKEd7ptZMd5OtnoCfOTDLs6Btyw82kOkdU0UYA58ZiTTKxEv/qfb6j8lYqKUUdxjRNsFuiPXp7qEQOvdiKdYxOt2X2qJgPr8bnW3NITufhLoAgd0/V5NrEAnu2ULlOFUdcF+J4/8r6y9AiFCN/mcLHtGzuSrPW3BECFmIRNVKLBPs3rhEKY0p1f/hAmFrPez8UAj5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr5W18JlGPn/T6NtUSBfSpfcFni72AO/QvgVrKf2SlY=;
 b=llXxC1wytm+n2FSZbKb5ePArrQdH1fo/yNqhj06jTMj1zpjh5prjtxI+kV0mnhmEx3bC8ahjADcUovOO+puhy8ovs082LkbbFYdS9Y2HL9CdKcQGQTNKqFUkNemRIHbBuhN6hdGKbi9NN85oeNqXXUgy6NXLW+YOzdbV/iAUDQUpb6XOgDdyjLrMqM/47vCQ9DgPZ5xnrte0XWwOD4upPK99Tow/BzWdmJVZem3axGBnN4ltHXWRcebzZtx1Ql+Wf8XTXmXpGcTKnmo5h0H2vs87mxM0M3MqWVPtrKJK0X6YsUuMqSwdk/josZKWceXQ2OTckrpPxN5DoIYPiUgrOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:06:28 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:28 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/13] iio: st_sensors: Remove redundant dev_err()
Date: Fri, 24 Jul 2026 11:03:39 +0800
Message-Id: <20260724030524.607185-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030524.607185-1-panchuang@vivo.com>
References: <20260724030524.607185-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e8032a-ecd2-49d0-ee40-08dee9308e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	XgPVUjft0tdn5xeECD9SDX/9x7K26xowgeT506BTksT7EnE6YAE2G9AGNy0YZVObA2v4oo2ekIJrO8MmrBpEeT80hpS/RWcqPvNFYz+IJ7H3Yj0d4qukA7XhcLOcgqvI/I1ZrxG/S52orhoXVQybYtcH0LAgg/uufIPXyY3tdwGD/1ZPhhGUh+lqzDqRX9vwMngd//lSCAxoxURiSASQIisRoq0hGjviBt5AVth9pz10lS+h42xhEHIAxfDuEoUYhrDhH+DGhTdfc3fbp43b0c3524mwRyJg8ZioBCDkWAJ79dqUlVU7mYHjeFJLHjhQXA/z6pkqDWvyLZr2GNYlUGJB6KFPIbPLyTpRNylNgX9AtwtxMCmS1cCkCsEC8o7xsXItw2Z/o80SMuVIBnwC+i0lhrGHLE8K9dwsTPGFpJ8DuO1QC0aeT+MHOQ5lDJETk9cmvns+AhpIuLmTEwgrRsZc0/imLNm39t+MjRVE1ahWRSy4p/4jhDpOBwxX5U2aZO2Mg9qFZBUHU9N5Zkufiehwv/mYG7CtDzsOs9eQk/Q6GVzDwXKhn1G5KGK/BNf2heE1PchUc/b1ms0oAGKjrK7akR2TbQYl5WN26cWUIMYgLthU47rDoO5YPIuBIjOV2tMX1JfTs7e02hVjZa1JLKKzAL8GI1kPBMiajyYkQDv0eQLDL/KVEfPu4998VuP41JPEzaH4KKM8ATPnwsKY8iH8nOqRDGs37VTmXMTAaA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0t++WlZtFOP8wCS6D5qncVzG/pA8L9zXjaci6tSqxpAqxfh4wB2CVXif7Hk2?=
 =?us-ascii?Q?wzn+9bDpvA3iRyLFRZ713RhlXOZjOr+bcb0UUfORgjtHB30zQjJYLmce/WZ2?=
 =?us-ascii?Q?QLK+vyUXrEj01FY/oKe5S+9VuduBDt5Wb7dxK2xJrpRMjtS6U5x2GaXuhTCh?=
 =?us-ascii?Q?I4XFj1y9lyv9vYYw9aALC3+8K69dukh6U1rvazbHFks7WtfC+usO6QmGQv/L?=
 =?us-ascii?Q?YE8I8N1DZpAzJJzbClI3onp2mQtU7FyI9ArlRPU3w1WQG+SGMJG+tB/R7tiR?=
 =?us-ascii?Q?GGy9lmMropyWxuIzFLrYIMLMwBM4f/b9CeESy3WQqwfQAA351rEy8r/1dYYb?=
 =?us-ascii?Q?ffne9UvtI7IXWhYHPpDCgfqOkHxMtkYjcQDlog/W9kiVgOaW9fe8bagjDjz4?=
 =?us-ascii?Q?0qpAuel2aXXe63xN1tvdfwD1SEwyjylRCd/772SdDykPBJkcXrV8r/tgKPO0?=
 =?us-ascii?Q?CRgi10hLQ7EkWmE43JgfMMSi2ftFEyoz5E+nxN5aGoxlQsDhvP2TN810PGIz?=
 =?us-ascii?Q?mugJUztW9M3o41ZDsyRAEgnfNLG+98sfmPZKwwHSVViRwvTjwiFfQLD4x+wW?=
 =?us-ascii?Q?LlPdp2S+WUP1uq5AY0Mq/plGJjVqSzDCqDr8NMjvN9l0GLIMQcpwRw5adVyu?=
 =?us-ascii?Q?+kMhF/dxiwERnuYOVEGbjBeI3IIfaavPJqctoohElw/MeTUI1vuVqofzFUQL?=
 =?us-ascii?Q?E5lBa2xyFB/ur8xdd4IQ9MsYrAh6TRHG+q3jerS/15M2q1+QhxaBWS6r5Uh/?=
 =?us-ascii?Q?eWYMNzHZubQmjO5qAXmyBgbFOObaFcrKaw/UB0KPyoS9iZ7VEzzNjLdKwYin?=
 =?us-ascii?Q?wbHGVoFjAyKNsTVaVrol1GepQsJARphzqUhICCrIjDSvVpcGsgcI5tSZ1YHd?=
 =?us-ascii?Q?WUZ2rkwuhX6pVIL7sUS8uERFo6EPYXc3JxKJrQzdOsKiiYrOPhclHg1+Dlpt?=
 =?us-ascii?Q?uwtYGFXKI9M+SoLp6D9B0064+mh/LWEDDIn4jxrmw+HsO7CzNVRJI3PxPJ42?=
 =?us-ascii?Q?RMFK8+6qpdJ7306qPkcoS8CZLm3BKrplcEuI+ov2K2KkCQyC2dnowyihyXN6?=
 =?us-ascii?Q?Zb+rRVNI1eZBTuL09ocRzn2j+cnwYtKebMaFwXfuqJNLUZd/XzapY4Twct2z?=
 =?us-ascii?Q?D5e7MBLXBauJoCbE6JUch9RsvjjNUSixxjDbPANloFgSN3mOEI4f8H91vpzg?=
 =?us-ascii?Q?R6uDYH6KGRfkacy9LW/q1jCtl2vLEpy70W5eJeWjkC97RnFEoyzFugxv0NBD?=
 =?us-ascii?Q?OPiepLLw2zNV9DwORZSOwDvqxAvMvPTmA8e6HjgwF1Z0XGz+Ze8SivurNfSL?=
 =?us-ascii?Q?/SFHEdy2bOu0FEoFgkQBWOq7s9mjRqMEDYgs2EGpFsiWghWDyDbvlXvyIT9L?=
 =?us-ascii?Q?TNrKUBW0WVMn2K7jzJzRI9d9PYIAfHgb1O0FfrJtRK3vC6HNR7RlMi/Ym45s?=
 =?us-ascii?Q?MC0wKI4z05TDe6BI578RfOVdMyFtc/ado3nsbQVnxvTkaFClslFCbNP0o3g3?=
 =?us-ascii?Q?5dLOoG0lFwpYnNfHxa6A5D/+vVhSsw9tkNHnluByjjfaUWFQvJaWIjj958wY?=
 =?us-ascii?Q?s40NTOb396pMXwD3wCSs6bCvMsb/T9KWDmfgm1GlhuOsR3XcIvQa5M9jSWo4?=
 =?us-ascii?Q?DI73DQg+pb1VPHwB06yUWoMcYt/0jIvL5PjhD7j/+dAoDhlS1BxF/wtNx+2h?=
 =?us-ascii?Q?Lumey/T5EPj9Py4c7GOzMcHw2/UVz5O6I5OFzKtWLT22Q4akfZUIkbXZPaO7?=
 =?us-ascii?Q?W/CW6c5Wmg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e8032a-ecd2-49d0-ee40-08dee9308e29
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:28.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AX4xuawI7Tdu2sAnJXu3S0eZyOme2Tu/4OjlwT43WL4Wfs9YqgPLQyqt8JUYgn7dQk2EDjsid1NZLbe4dgIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 8a8ab688d798..7b3e9732cc3e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -211,10 +211,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 					irq_trig,
 					sdata->trig->name,
 					sdata->trig);
-	if (err) {
-		dev_err(parent, "failed to request trigger IRQ.\n");
+	if (err)
 		return err;
-	}
 
 	err = devm_iio_trigger_register(parent, sdata->trig);
 	if (err < 0) {
-- 
2.34.1

