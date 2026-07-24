Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91626372ECE;
	Fri, 24 Jul 2026 03:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862410; cv=fail; b=uX2hTfjKYv02SrufNnsNN6SVVPp9Ce3B2LrJgeaPhazWKwwjx3C1kY15GtNBF8X+V9B7IaPqOQb6Av2K6M1MxlRZdMqwQVCMup1Ro765hxZZQ0Wl7cGWjsiGEQ6wyLXMMGI8pyNZfUK8mSfXD2uSVn7agNSGIRNQg/MJrtOj4uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862410; c=relaxed/simple;
	bh=wXSmMFEYM+ra9vVA3YDv1LgabesMUGbIsghWUYkYEuw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djynhlU55F/gwCXJhFxzBm/rzfPv3BSjZwZnujg2l2i1MpZLQAhS7h8epCJVuzPJlbl8lFQMMOQaAccDabK3WwnK64GBF5pKTKfad0oUutVauLUfQtNhvekFj15WaKoOlvwkndhxuAuGKH5d+8oc+u1mNmvIJ7k0sJD46yAWavs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H+ny9aGK; arc=fail smtp.client-ip=40.107.44.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H+ny9aGK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6q3V8B27VCrH44aAT78IMfTo7rOjUeYu4ttBhX1XxnmaWUlR+HiDhgfiQ9bMVNEss1xb81brTbaB/B+oI603/uLQI/JNDHbAMj2sLPB+oRlL/FUkKZ7thBubqV6lgqWiMfWsGlmhMvrajC9Q5l0U2xBujraWJGDaGvGGITpGmNHTU5/0v6rKv61s3lErp0JURhGdII451Here35rq4ASPJ1xwLWpoagXJelUNEx/8xYa0pt3tayHo3f5nGZ9VXpFvyc3kWJxGRi9sAdYVYl39uteOtnsNNlFMFBpWt1V54F/EPVschtjHESeoxesDCxcpx3Nblj3GBzXaSfTpxPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gL+SvQKmSnsgvA5MfDlh5TTFM2EZJwJzig0RZ2vhUrI=;
 b=A++znhZ7tGjeh7jLVTdSqCkhkBtY4aIc7xATNO8nLEwKZrfb+rAwgQU6SCNUsw5a9kcF9ty40Uut8pJy+xqWMHpzdujbwV+dKe0JzA5y7dmpil+WFKux3bUXt6vXkwFsp8zlyuIRV1BJZC69YIPS86cqcix8Gmy/ukExw3HrbYRrYjeCICTd95ofooZ9pYd6Tnnyz1LE5smyJN58WUWFgJYF4J3g4IGiIKTGFH/Ts4qtBA0i7lZZPXlkM3CYYxdhjjQjMaGLmoQhF69FvMpGtglftCsly65sQNdKLXhZwJnC+f8mBQ7NGplEgKIJSGVFT+EYocnCJN4YFLCFO7hcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL+SvQKmSnsgvA5MfDlh5TTFM2EZJwJzig0RZ2vhUrI=;
 b=H+ny9aGKVAamV131EUYMnjjU0oNWFw6JWwKWUUDmXOM6LGcWX/wnV7ZW/uMMXVTZKn07zwQtJANksE0cEzMxHQmQ+ZN/tLv8ojJs0TdRn5Hm7m5oCPsUtv1+yqKXPbGW34VREyNklyCfyDgd7QwWXzeEg97BFuW5z4VpOg0LqlI9HaYF4qSvOyjRBFuOMRsfzAz0CVDY7W1xnI9sKHrLmWgyM7asUOFWmW2z/0nFFE6nuhZeZoHZvJLsh/IMPY6zIZ75IdC1Lb0FIqXMJp6gT46gId87yug4hUWHCbXK8yskBrPilkxzg+gpVP4a1n3AukKJuRRqsUA/m+1JtLOCuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:06:45 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:45 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pan Chuang <panchuang@vivo.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/13] iio: health: Remove redundant dev_err()
Date: Fri, 24 Jul 2026 11:03:41 +0800
Message-Id: <20260724030524.607185-7-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92fa1c7d-774d-4596-36ac-08dee9309819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	b4tfZbCzWXlQNI+wSoEIBmBY0wMzX/rCq30paHcEKGIw3o39g2+lnmGkwgPE60cUJzfxFPCEd/Xgprq8rIwlnpZvTTahaVPoATTb0c/fAfYSvARlUv49xF5IPeMtsXxMb1fSc2H3XAAWzO12XXkCGjTphxuhPGVIlium4dFZ1asCqeTMf/qay/6f1U35si+rlA57awqb41On/sAg6KVfL9yYFBABnyAVywIh4q1dObfCUKMtkuU2VjHerpnhoaNltE8hu5epBEsmeSZISXM2uAXvu9weJWCJghmA8LRlpjh8MHV3XcbCZr3tb1XguqE/LFd4v3z6yYCqtFA9ecgdp2qtxyyFfnNkQQffwiG11XbV0Pgf3iFNaJhtt3D0mn368i/HwE5bjft6j3NvjEeyF9XDnRVnii80W8OvZCys9m0M9NcBbjSG9CqnNniwvn3ia5Vl+O4i3eN18fafB1PlsQhHWsZMv3Iz08iKw7PnITX2kQsHDeVjABdlS118i2avB0/ytTehzTr5d3BGtJWn4EFFOOMxDG+QNMDOzEjbezQgljHqttu/6NoDnrKg4dCbAbHG/zpGKk6CTD3FIGib9fsPWGHyMC80/8qUO2krnnEAkA4NwFDR43w8mYglgxLe7/gaD+2P9UzEjPhGgKdJfF06M9oSzsTgtJ7d6AgRHIrXPNPYglmtNvWLeb/YD6YTO0DSqijNuNpkuzyUsjdqCmXKiM5F4ICrH50+bxDYlOmJYFu8ntPcaZGODCZby86t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZmSlc/Z8nXWI8E8bqjDN/NYnhc2IXNbZDQQVUuLJykfMFGkv0YJNGswfCxTj?=
 =?us-ascii?Q?JgomRW2Sk3XQ7bvU+HO4JKSWcR/RAr4TkVGG8Bub67I7CfZujGNVV9FHKsQ2?=
 =?us-ascii?Q?iM7hOmYYGHXW3iYaOjhGT5be7nWzfDmGoZ7TMyFdsu1l41w7LDYJ+P1Kg1MJ?=
 =?us-ascii?Q?8O3HnrR1tNHKH+Hfne6hA3HBnkLo6pb+3FKwemdBQBYO61x507zQOVAYjnqR?=
 =?us-ascii?Q?xmT9yR5mhH9qSdltmwpQNI5cSZ/KTMjVTyCfEnAS2vJGuYqXDUvB9rs4EIvW?=
 =?us-ascii?Q?ZjbOUg+mUd6VcTvbd8v452wKYvOXc+DrehAC1WQZzVlxGht5hrwlAzzl58iI?=
 =?us-ascii?Q?n5NUJr/Lo8uB4EeltICoTrbd/+1WslyaHPT7RhWUvZjU8NflyFQk4ijvaT8b?=
 =?us-ascii?Q?bgrPnOuErTKpJPNV8MGq5+rnbPis7x7YuBYmUxjJfKg5d0j7u+o+yQNSd/HK?=
 =?us-ascii?Q?k+jJdbQiQ50FJe7Cg7Xf+TSz+z7BEwPIWQg9undpIWTc4/posqCPmGkCksAw?=
 =?us-ascii?Q?wb6WZ19kXTMhSO327WcGW1tdzQuTtstQr+wBlt/e9HBN8RjW7Z2qOfMhBaCk?=
 =?us-ascii?Q?AZGTU3Cven6DIcCfynmoctyHPwY4bnBN69f45rYEgQ4kOACYqOt35KoePBEM?=
 =?us-ascii?Q?o24Ip2GXUOWuMjvxq6BVqM0ToAludF98hVHn6BQYf8qSpqcEqbz9F2ZvDCZ4?=
 =?us-ascii?Q?DbnWvoRlLfhGfwYAZIE5YGUSb5qxnqxwTOmlWQAseUcrXEo3h/DzPPaEG5j9?=
 =?us-ascii?Q?NvLmxA2SDyrOX1XttjV+7EyGa2JZN55KJUJ9tj/rWuFvlcFGx3i8kwx2E55R?=
 =?us-ascii?Q?HOzzO4F1oOJxVtRaNKaMXna4mQ4Q7WMYNS30VPt6uOuly5LMdNKKTnbtCHJc?=
 =?us-ascii?Q?ljZ0BlXZpJM4wXEofIkaPkaRJ0bsmkl50b0h87I1LD7M8XqLgZGJ0scU++jP?=
 =?us-ascii?Q?I967R86jkrd/i0HX7ETk+p9uMLNR+7mWyPr2s39QCBqLMBDHKjEe1uO+DUht?=
 =?us-ascii?Q?VLMG5GuG1QGb6W5c26xTNbsQ6EO8oF7AzWFX0MSE4CFSkXdW7xv9NJIt1zm/?=
 =?us-ascii?Q?F/GlbA5aOiPZkl618i/JSIvdYy9H/+irRN4msuqhBO1Efw/Ntb3OgFueCZBQ?=
 =?us-ascii?Q?nV9xmfDQKVI1wMt0nGzdIWKLwWMX4yqx1DATEnqVbVToaY43O/cpNfllnenS?=
 =?us-ascii?Q?hac1JFYjbJCvLljeMf1xIbIhpnLgkiIgs/PTmNpaGk0sS5GNeTCQPqu697li?=
 =?us-ascii?Q?nJcA9SpplLM8duuaFoTTudUk3+SDfoiswZh8VbpaA74ulhPXFyCplPF4x64i?=
 =?us-ascii?Q?MnxYf+xzMouXvj/UOUNGi1/uIJk3LXdzfz68GO8iMpvca1qDLskezDzlUH/6?=
 =?us-ascii?Q?2DvR2gnH1eXGLgebMJFtvI6YdR3+cvApQXh5nVIAL49WdwVYl7PdPMpUgxmk?=
 =?us-ascii?Q?oyslHTiamccHLc8F2WXtCYPsQh3mhxuIK+4c5hm9H0UltTJ17vZPc2wS9R8o?=
 =?us-ascii?Q?OyRiruguFFxjcX5uegLetO1LO/o8AbzqxCHOtPKROhJ4+hgyHR9vB0Sgswbn?=
 =?us-ascii?Q?FmAt1KcV1ERf26u2Qlr4REwx4qCZGDO8ffEt5L1D4jdbIy+7Aw5XgmQzmpVi?=
 =?us-ascii?Q?aEr2/U5dl2rY3b5TPSS6QU3H1xMwkmmLVy6EKY55lONDpuWxgtKdQbUptIJV?=
 =?us-ascii?Q?+EYRl11iClKZudRo4z1mXtvFYiJIYkbGZrXlWe74LwQSI0u+vnSO/DbXE/MH?=
 =?us-ascii?Q?L8o1HXE1BA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fa1c7d-774d-4596-36ac-08dee9309819
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:45.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sV9DYuXB3x2EnRBisLivSrvAaqRw069uss1aslMJdScbk78wRLyl/Rp0jRFmhr7tTvlXrsO78wQc+ncZw10AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/health/afe4403.c  | 4 +---
 drivers/iio/health/afe4404.c  | 4 +---
 drivers/iio/health/max30100.c | 4 +---
 drivers/iio/health/max30102.c | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 27e32707f089..2a648532242a 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -544,10 +544,8 @@ static int afe4403_probe(struct spi_device *spi)
 				       iio_trigger_generic_data_rdy_poll,
 				       IRQF_NO_THREAD, AFE4403_DRIVER_NAME,
 				       afe->trig);
-		if (ret) {
-			dev_err(dev, "Unable to request IRQ\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 2357e2dd7017..22cd46eca217 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -551,10 +551,8 @@ static int afe4404_probe(struct i2c_client *client)
 				       iio_trigger_generic_data_rdy_poll,
 				       IRQF_NO_THREAD, AFE4404_DRIVER_NAME,
 				       afe->trig);
-		if (ret) {
-			dev_err(dev, "Unable to request IRQ\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 97352485f5e2..191540e10c20 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -489,10 +489,8 @@ static int max30100_probe(struct i2c_client *client)
 					NULL, max30100_interrupt_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					"max30100_irq", indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+	if (ret)
 		return ret;
-	}
 
 	return iio_device_register(indio_dev);
 }
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 0eeaa378b10d..c37316c86f14 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -577,10 +577,8 @@ static int max30102_probe(struct i2c_client *client)
 					NULL, max30102_interrupt_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					"max30102_irq", indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+	if (ret)
 		return ret;
-	}
 
 	return iio_device_register(indio_dev);
 }
-- 
2.34.1

