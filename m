Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013040.outbound.protection.outlook.com [40.107.44.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738C3E5A33;
	Fri, 17 Jul 2026 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281582; cv=fail; b=crdESiekABIo5cON0i8eBr86Rot0xDxcFDalMMkhSpMjHn89opZq88belGN2G6KGjtpCHXO9W3HNWxUzyzBYrpHhJwNGY8i3of5Z1/VIdFU7TRQ4ZPz28VV17VnOOG7HDs1utrEfoSsSG5+kpKBCmSg7xFGPLtNwBBoEWRrDADU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281582; c=relaxed/simple;
	bh=hQ+dG1rS9f8v7GNBOZkZHDWZ2S6neQt2y9QsyWbHZ+g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIXI1uH7QReaCiMk1jH/GjSusp+2LE27sm/CezY4Hk2GWNz9/pDdKU+4ZkOB0exBOZ2PfKZI9N5PGpvhHKaDtPvpdmkGG93idRZF4H2SG929Ta4BTsUzc6GTTj0CIFF480fOQ0bdoHk+cAG+INFQQPLZtkLoz2XaqyWYVTnLfYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XdlELA8C; arc=fail smtp.client-ip=40.107.44.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XdlELA8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NInurg6QknljmFaNwnyycU3rIQLDnLUSUfuZkleDlabg6oA1M4eldeDKj0kqd00kUT0g7sgI1CwIFKTdjb84zP4lO1pCUqVTA8icAg7IFtLZpemVCFiUnfZQU68rL1ZGBW7Lqc5in1yljQO/b/9fGUvO3lC+x9XsdQGdW9BpN6Gb9KFMIdCA0cwtEejyohwILyfL0Xq9XlEwgIwfTXWzLV5s2r348SCJ+BrQ2Xuz0f111FWwBIdGB5wLp2MjSdqQgYnVEeUL0CPm/F2UXSq4rF3+nyrvSNZ+Z9JYXuLSzbgOfPiWCyy0j57LR4Bw9NcgAJ4Eu1Dn89R2q7oShW/JaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8klfc32ugGZ0rOuUb+vEktoFZKjxUbEckxeANsOKR9M=;
 b=aigUgBrq5Bvzy3Y4n9F5NVgNgGfgnrrQdWaowJ4r8TDpR4V8eu0sM9HOp3zhgMwXvtLUCAGfjIeyUEE/kenMIWqBSBANlD+4sPEGcex0GYMOmxKYwVSutFweZjedlmpeT6lZh0SPjUtmkwlMP8jg9Q0CvcKKbZCWLlrZGPX9/cOq3OaBJwaBrgq/B+fVDBb7layX1DMoMVQr1XFWzv89nLxMNtxe7OTIeaRtJ0nkB+i+6ggQz163yhOeZXkb9kSIyDKtwQcxr7a62lkkBopwtopTf71FYupLJypuoswMfE/KMtMAZN52MN5oYoHxSFQvApAD13RsSFNQX+tPNC647Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8klfc32ugGZ0rOuUb+vEktoFZKjxUbEckxeANsOKR9M=;
 b=XdlELA8CKkrnu9ppKMoC0Pr00znuZm+0f4Eu0odw9kt3Pbt9E9q49SEk5pPPQIVkq1tVbdLBmqvDp6eI+OWzRPES3rCABfUyid5NwlJgi7PnkcuFngt7rPPvXTlOW7p1APmm4zQqRiz0XgeLC84CdlLv/VBXNoEuoe9iScXRM6Q8ynaqeOxJPIb7cZHSRU9/f4n3xE12RIjxG8RtChkZN3LqmcjY2pKwZ6qhYYgbPJYqkNikeVDX7EKJqd5XwZUWGKYeUqe32fPXVC76JyQi4ytzfB+/SROCGIT0cQrBnVM13G5xcvDb1WQr8UC/qj4T7EmuzWVjenJzl3nsZltA9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:18 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:18 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/13] iio: common: Remove redundant dev_err()
Date: Fri, 17 Jul 2026 17:42:27 +0800
Message-Id: <20260717094408.509583-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717094408.509583-1-panchuang@vivo.com>
References: <20260717094408.509583-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:405:379::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b49bc95-275b-499b-ccbd-08dee3e8405f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	9AYMqNjY5b0IRe+qKwjWan2dvWMa+PvFcfsTICEAYJH4X6Mj1bEjSufk1XLZd91fweZEsDVO8T97lWaaYQeI5fE399Mve7h99VikVfPtNpQ8QQ5BRuRaog+b0l4vzZn7Jmqfqdi6vbRLAKx/uxE7PfIpIQ4uP7+D4mksMsOr0bB8J62EIq/0Z6f0w46ctBTNfTHDir/JxqzQOrGVrtSQ+nib7ovB2x/zALDqr5s+Q1b4GPjqkRrVflKm/t5iSvd7x6WzTNUI816UXRuvgBNMcb4Rp+/0LVV/rmJP36OGZ+NuoPCLFDuOqgX+fb/1pkp0fpZRhWKxQPUFPw/vjNEbT3/ZERU0fxYfeJklFqXlJD0WVm2D7VGuqYmisGx3VHLVqHq6MVxSDtxDxfPNAUyl9LMXtiJ05Fbu5X2U/7wKYwDsP67ISXA+VBUHvSjHOv1qRElneWJYItgy/al392urYwkGotiXBXjjRAxYHRUuCmhoG1+vCTXIxxi1tjAs4nQocKF2r3kHpMI14sisS2cZ8zSzhk0NbTDxaaer5C7an2nNCQ9ndc6pVWc0aEfOCgf7xlGmCddxIQD2VpSmfZDoejFGtHKCHeYCpQKdxp/JoRfx7q3NzUX3wSqZW5IrulCzkROXGKzzWQRSAHHFI2SNkwINNEFwBXMYA8MKZO9JQ7DV16xTBe0utZF/Lij0gZ5NnFnVRPGtyVTXXTOee8Plz6drtXJpQiaJc09teLhIkXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDAXjyypTf+6/8drwazpfZBS3w82os/Oh6HWQ6ieRwS2Q9B0i/2PWZjbwbQS?=
 =?us-ascii?Q?Q4Ga6l5OGF6DeBZAJZyj0G4vLcX/T+ky2HDlQUhnNr9SyJh1Livx1sVwojtj?=
 =?us-ascii?Q?PQrYPJwjty7KUdu5Xv4uSQMa5dNO/6iezsVCyAJn0I91bHy1QRMFk94ciw9S?=
 =?us-ascii?Q?d8M0OuzEi6JLNf0d8Q/uf7YRWpU5Lf24Bi0NMNgpowzslsvxGQEUC/J9Z10J?=
 =?us-ascii?Q?JG6PmZWKNPSzrSIrJQuEL94f4kWZJ2SeYbCrW8erm4z2lambPNzQDEhfB2nM?=
 =?us-ascii?Q?N4VInqYJS00dTHhvVXvPF5q6sboPvk3HAeDdNwgBON3E4F+67b/oYpr/ZSFD?=
 =?us-ascii?Q?9KyD7Y0BtCkShdcHzqR3ryD9DQsQw3OYQNZqX+7X4W6mw3Qp7MIeh0g8gqdg?=
 =?us-ascii?Q?HK7RSbb8HAXIPUJZauwCrEoyR/pHwkLZEvLNbvRdi6vWvpEber8CrWglLjEj?=
 =?us-ascii?Q?iVcSJI74b+R18oCno9Y5nHlbE1xGr0tlujBhBL7W5FA7h5WIVWR3i1QPD+vz?=
 =?us-ascii?Q?4XVPnNuJ+90yOLqsM1KmHUewa3wG82GbdecJOm5ncpOv+IiWVCL8KYxa0iUL?=
 =?us-ascii?Q?h0MTipka8sr9McZ7RYcbx2jOwa9d5vLN/aZQhH8EKDE7yt1o604Svh++KpdM?=
 =?us-ascii?Q?+CJVLgTTZXpXjLH0LKIt5xg5bT8Ei39/BV2NZCIAZSxTohp31KwWAdv8vE9/?=
 =?us-ascii?Q?sYRhGSBvjXaWcQ4xOWGE1IC0mAFJnbuj/W1GhPMj9AQF8W/dPeES6XqObL62?=
 =?us-ascii?Q?y6K8rZednDV+z928/B37YFagWuSX52Kyx7qIYNCiIPoPbLahM8hMaEgos6pw?=
 =?us-ascii?Q?wod2j6vz6Qu9aCo8hulWcfz6mnoNzATTWYrWOFYx2eafmhBn/G/mOitgmBk2?=
 =?us-ascii?Q?9DRypQWccwBUBKnkjWIJRdbhnbIsPoDRv/XKMYoeGQjDIpK0Dd1pYZfioBRm?=
 =?us-ascii?Q?NIqDgbfQ+C+4E8To4ggScEAz2x8yUrC6ki94RAYbBayGfOYWRFDOtU6pvEW+?=
 =?us-ascii?Q?7C5qiuCP3fh/V0oiCPsnR6KXXxmmLaQbPIXgiiEXXw88Equ7RzzPgEhVVG4J?=
 =?us-ascii?Q?aGJcR9L3kl/xeYhMjFjPuhB3hbqTITN6GzEnTAWzycYCoweImJ9B8B3ok3kU?=
 =?us-ascii?Q?ynrxxU5hbZbu36MTnSr945IVh79O0kKsCjVj9XzKoedOQAZj3Py/mGbKh7Wd?=
 =?us-ascii?Q?frf6MZ2yRbtRAHuD+I1KyrW6cKRPXb89bSfkAP/UZQJXbIrYCpVe5UVTzCGQ?=
 =?us-ascii?Q?FKdZ7pke5q+7LmhZKqYLtzsAtWLOPGYkO4qG5THjjlnQi55R6TY980099ggK?=
 =?us-ascii?Q?xJx9UDNSzvOanSG3+Z/fRhYjBGsmqNBeAUZ39GOqnMpWZ7fgNjbpLmgyTt/E?=
 =?us-ascii?Q?y0rqFkMPgFBOp9hlgHqvJC+PhBPT5eb/NBPOX4QC/kqcQ2SIzpyQj5tqzv5m?=
 =?us-ascii?Q?JtMQLPxPLV39baXnSclk7yBB+hIinEPnWul4sivdUdyBfnK/FhitKknM8HhM?=
 =?us-ascii?Q?Mgbh+kKToFl6gqc4ia3MfdASwgj9IQblMQjA1eAX3/BydX4VmLiihnsPPoBr?=
 =?us-ascii?Q?J8Q8gHg2RMYe0YfeeMf/KRUWg99Yp9hsdgRqP+yhHwJFWuBwuBp4VEjKpUm+?=
 =?us-ascii?Q?fOYSu2W6fyIhKTm/xzLxyA669ec4Y0HkJmvLt2dttsyfZTCV4Zn6GCt1oyFK?=
 =?us-ascii?Q?h82YUjDqVD1ArBYs0Or0Hx2X4UlcVTgyFQBjvakjT2nJBrwOAz+w25qVmXuf?=
 =?us-ascii?Q?RLMf4vaa+Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b49bc95-275b-499b-ccbd-08dee3e8405f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:18.6618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJahW21mV4e9g21ssG3t+x4BBVHY8FECH4jtKiHm6zf/Ejrw/9OBS4vsTnRyPJ+2y9miy2JSv5Zw0kR1d2eVdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

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

