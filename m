Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012046.outbound.protection.outlook.com [52.101.126.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB313E7BA8;
	Fri, 17 Jul 2026 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281602; cv=fail; b=fIP+RbsXa5m1lUYxBUAtHPuxKNq37e67p9AzS5855c22MKvYbWPnapU1WhGBHdm2DAwErCesMQw85x+4I8AXBo1Mhr7xiFR1PFFzxsfBjxWehYSpuMKKPOi6tLK6UkxTxhnT2a7ZhMe2AN4+gae1pDYXyjUP/BJiLjmvIET5EgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281602; c=relaxed/simple;
	bh=K34MtzPqlokt+RNvF6AxRvsP8hvCS4Qli9TNloP3rTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q96sfnhjnrqwexBHYglRFvOBcL6g4m/ee/dsuF3pwaoK4cj+0bXP8YsXESBvBD1nsgP5SfXCs4dfgqCy/yMJnErGma3zEqhir9NTTLn3dNRf6WGQHp5ScnDAfH1hxAUbxft+FlRKkO7V+mawCOlkqLASI0n765eqEG931w5m4pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OpqUAyLq; arc=fail smtp.client-ip=52.101.126.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OpqUAyLq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTbfMIXYLGoo1woPYUjUpM5qhEQM16wuHA6a6MTv1piGGj0BegZ4WGoDl30R8BCHqa5ls8e7mh4RL0+Tsi0OEumcN9EejIt78brdsYVNnf7Md/IEuocn4MIiUnW0U3BZwT7Ft6/mS5XsAB9YE8N3HjRy2hFoxSOzer/XkfzjvP7ztyOE2XY5J6SU8rgiad/JC4OCyhQlbr2gA8IWY4ZJt5n4KVigEKVWZog200yknV35fpTqU8clJE9CzTNEXMIsPmBPxiPtsfme+iT4DmUPA3jK5x3yGbCBxyTGHcu5EL6oKTNN8CAjvRxS9oGIeDXMYaNWDGvuWBKx0ISu2a8L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzaoVwLLSynZMiXGxwcxIr16EOdyuHnnyUQ1Rkch7Yw=;
 b=OZSeVpCgpreRb5nJs4pRYu17FOlVE5HBuGillX8bp3VsVMj9DRoZzoBzHgULbB53OuIxJ0U3+c5wzdmKW6LfCCNcUn8/McIt5HR2zF4VycRgx6EFFOhYCfeIDQzMJTqGJo8GEkl6Cd6mcE6BGxl+oUoedktPwny7pdHx/yETxT14NNLDnGPZS9tLus34YutvgiefsIMgFn66+Yl0bloaChjGeL2G8TJzRzVepppDWbwU1N6m+DN/cXK0mSeJjYAc2gQcgZq7zYH1OID9SHV1oXD6gjXxpT6m8a+BodlH+s1ccQlTCvDLhdu+8Ybj6PpWaRGPjF+nZi09BZYuF9fBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzaoVwLLSynZMiXGxwcxIr16EOdyuHnnyUQ1Rkch7Yw=;
 b=OpqUAyLqMLoWlTdSgST14LOOZ9u9I2jWg0IERd95+k6rIncKFllQf2JupuVBX+ShXkp+xglvn7JBh4+qvgVvdLKr5VywW//+vQaK5FtvKvHIOQ/gzMP1TViMztFZ+tndA5GgyUODD0FHYSIb5ymSJlqnckG1pdrLoQX27muTOkY0CxyJyJSEtuBhjgzAnbppwjPXczXf08hCgv4PI2pXRcyM0wNeiiM5GGPA4AkzmfJ+kvO5aUUbte5KdeBXswzUWmgHGw6vLrY0aF4p1o4tSHjCetNrCPTzi8SuzYsj6fByCApNh+4vuWRcaUCV8q0xWrSISD59NXQOkjVNpHL8Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:36 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:36 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Song Qiang <songqiang1304521@gmail.com>,
	linux-iio@vger.kernel.org (open list:ASAHI KASEI AK8974 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 09/13] iio: magnetometer: Remove redundant dev_err()
Date: Fri, 17 Jul 2026 17:42:32 +0800
Message-Id: <20260717094408.509583-10-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a8e8f04-e4b1-43a6-82a3-08dee3e84b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	FgvfslDrY/YnSxxMhfd5pPMOEtNCm+hT+c5rBsW5IQPD9V0TWRJuz5BgtYMhSAoLC2pfMK0RTvoAAkNY+HTrdAdH6YyD2GMiAdVmKiKV+ZvHMPEWkYT2BW5Vo0GFnwc9xFO9EoglxSRIqzWRqay9xrOHcqDFvQwoskubfvCUde1zh3GFx1bxf/HfsVOUza7Epk75ksI6+9n4kmYu2Flbgikd5rJpfq4jMNmL+qFA/EvTsBmBVN4zZpS5P5AYrA8Sh6fhSbDYr6QC3+EF1+UQaqJF/XKx1imD5eaTM0dCBIGyHf0M38mTvlp8fm85cay7DyZoun+hP83by15buWLdF1+qs9IgRiFPcr8KNjqp5KEenLufgmgVYq2IFCcZk1bnVofPTEZLlWRWgFYGMYaxHzXXQs/1JknTAyc4sykWYVpvi4dOoF9H7ahmtfY3Nxivk6TO2WlkAy2PnEScqqqY52JJdhg1EjR0+pBKWBG36gv2sJdsuEK3LI15p7ZcTFHHnrvhDmsg6veQMgOL/mBM4VeCvTMGwN/JvY5Mg+v8sL/Ayn+44TUCUHyxr/XCxhDGvMYxZ0kpMjgQbLQJuGC1qONWK7a26421Jt7X10bOsCeMEI1SX4gYfQ3QXPaewp6wSmcFQPO7a+tQtOte8shEZWoST5yIeGubI5COdXqjvT0UfWC/Si4xWbjbj7H9xVNCeV1KjLyvT6Vxf1lxYTqI23z8dqHG6QeJUFk8GwyNp4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SssCZ8Nm47jJfmFUPSN7h+LDJOhdy3hbCm6QXBs9EQnZ2fJe6lRhzoBccHxQ?=
 =?us-ascii?Q?Qs4w25TuyaNeMRckGim0sohS+g8jDaZbBr/Zp9JNIdQA3VIpiLXe2SOae24p?=
 =?us-ascii?Q?qZuMczBB/GlAUig8KXS33zxtLi/ibUgteUEzbk0B8lAH5y6IiF+8H8Eaff2O?=
 =?us-ascii?Q?P4N0SLAhvj/2YYTHhjTGdX9WMNZd0maFJdcodCi9wEWqKW7nfObMFZGlt+Hh?=
 =?us-ascii?Q?J71SLsr9DM44Ci227uYpDqyRrt3aa/Yx68NfpC9KiboS3UEZXAPDnIoY5Beh?=
 =?us-ascii?Q?tG94sL4PcFZAuLbI8d3bJnhxenpaHIUcF6U6oBxjUqlvZXJlC5K4QJRN9c1O?=
 =?us-ascii?Q?lw9sXThWJpZCK7/u0+z7QbxRgAkJmTWPxraKLnRvLMzq0I4bmfnM/14k23HS?=
 =?us-ascii?Q?RrC2Ta/VmSOyXD2Kx++rZAP1B4GEaiamH6glhhhQjiq+F7m64PheQs/1zlZG?=
 =?us-ascii?Q?MyAVYBgCTmbjQvzwwmBaIvmtED3eg9IvdqBqhoe6VmDEHEhbZIgANsSc49An?=
 =?us-ascii?Q?aInRAd+iPFVL8H+1P3JqRo2SEecVn9aDiHTk5hyX6hnM4pgHPN5i6jKzvdaK?=
 =?us-ascii?Q?LciNhg65Jp8P7afhK5ejMBJSkn6vi+GbTdpjSvr9r9aS/5oncK6PWjszh7YZ?=
 =?us-ascii?Q?HSKvQsTkhIlVKi6hrktk0yQtXnOrv0YKgX06ehGNhnflXxjY4V28h5aDjcSA?=
 =?us-ascii?Q?6bdPy0c+VpRMP9qGQCt9BUZTZw/lM8tQGdYN7Bcl8UKI5FJZbGyU31ZsJ6LR?=
 =?us-ascii?Q?qHdpmhrjyUJSX4ZTg7AeZd1ODkwsHeHasLkBH8+fSvLJD4DLMwgJrkphL5Fj?=
 =?us-ascii?Q?6PVu9dBnC04yqB9fY6yWprK+z/5CiMtO2ExXikuroLj77EY8d6LSb5WiYayc?=
 =?us-ascii?Q?2TDx8Wn72J9kSYc7GHNQvlyNPf74G1AupjFsNq+4VZWT94CnyBK5rX8f4/Yv?=
 =?us-ascii?Q?ASb/b7Es8tjEYvM5L/AgVgSPJLb0Lhvyw8s7OAfkSLYwfXpF97VL2gFLr634?=
 =?us-ascii?Q?bAl4U7jHYF/Xakk7ptlypMwQsoWqqMkxp2xCCUUd9OXrilVpUPJF14DlrfrZ?=
 =?us-ascii?Q?fMr1axY7vAEzkeBEuoPcm3GCKcx00AJs6jN5ahzWHWuk+x0Yfe6zODGJQdlr?=
 =?us-ascii?Q?09ZN0cXbbdVTR3EWOgaz3o1OlGquYOHPZ+VAmpnEzsSbpVrsJeWgwYQLLOTY?=
 =?us-ascii?Q?v1RMb9sgrHIbqiqXyDHmuvGE+ccA8wwMYe8jJI9IDnhYjtDVzXKxujbzQ4Of?=
 =?us-ascii?Q?Q6gcv3ezwcbWge+xaQ4JsU0ghaw4kDA6ynoeUpKd0HSGhDJNSNJnLzS3+tTz?=
 =?us-ascii?Q?31rjAyAC/nk1V5eNtmjgBX5yyafZnkf/Z+0YQfDb1yE7cCDndXESGaV+SXTX?=
 =?us-ascii?Q?bI8cICuc5gcB72a/QCIFxKSsEHCs9Rnzd+LQzn8twPgxO5BTKlPnsA+Zv64i?=
 =?us-ascii?Q?MleGyJnS+I8tn77XbQNCvgco2Avg8HFhGL6MDAPbx8UM5FW4hXJA/wzLlGBu?=
 =?us-ascii?Q?XUkPignb+6MQAROjNUYQGhLtl6EdEOaLdLxflDE5AIBvHDUTe/sMnBGA/xXe?=
 =?us-ascii?Q?DFwtGmS9NTO+k0cEZaENf87rlw2ZNzaflA2KiWtDWrJLfNOFvsd6cFxrMZbJ?=
 =?us-ascii?Q?XaXgxV2/6Qb73S0zYd81VfYfw1lki9qV8xStGU6PQ4toEdSkp5MO1uEYIrWA?=
 =?us-ascii?Q?10UlaQOtfUepqx8R1KDcKecJmX3vl3qQ1apLxAD/4k+eluWVX5jh9ZN1f7WF?=
 =?us-ascii?Q?yZe9QioOUA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8e8f04-e4b1-43a6-82a3-08dee3e84b27
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:36.7534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTPnIuw8CHrz3CoE0vURf7cO4uFaf7sE0KiY0rm2HgsRc2AUBuHLacSGVGGUfDGfBj88w6kcyr+gWdrYLuREIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/magnetometer/ak8974.c      | 5 +----
 drivers/iio/magnetometer/rm3100-core.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index c7fdb7c2f543..28d6cadfd9f8 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -926,11 +926,8 @@ static int ak8974_probe(struct i2c_client *i2c)
 						irq_trig,
 						ak8974->name,
 						ak8974);
-		if (ret) {
-			dev_err(&i2c->dev, "unable to request DRDY IRQ "
-				"- proceeding without IRQ\n");
+		if (ret)
 			goto no_irq;
-		}
 		ak8974->drdy_irq = true;
 	}
 
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index ac3f9f7fc808..54efb694748e 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -568,10 +568,8 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 						IRQF_ONESHOT,
 						indio_dev->name,
 						indio_dev);
-		if (ret < 0) {
-			dev_err(dev, "request irq line failed.\n");
+		if (ret < 0)
 			return ret;
-		}
 
 		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
 							 indio_dev->name,
-- 
2.34.1

