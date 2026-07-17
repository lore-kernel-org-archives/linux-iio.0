Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013049.outbound.protection.outlook.com [40.107.44.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E2397B05;
	Fri, 17 Jul 2026 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281629; cv=fail; b=jFkUKXF7kCqaVke6nril8qyvbulEC+JhSdnMBAMhZxGh2XZqkBOmWEYFEU6Vq/XJaIAda0Kq3hAWB5OEj2uX9lxDi0ezbBCpOyhW2pzvNH1Rq6UT2YbQu6PwnOZO30stmifqkfwh44sa8HHE3/EElnfY2/8Tz7iXEVgLVYF2YqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281629; c=relaxed/simple;
	bh=rA9YxIb4Xlmi7Nu0L4JIWA01zWDqPnGCKmkHnCB1aE0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smD9VtXOiLbq4skF5d78Ka1jGDvLqW7JxAAUXUKx9fWFLpPFz8tXYjzlIVoA+eAHQnjfAHVvxlPiSFDLYynyqoBsuhXb3JGUfQlA6TtqbfTxhoXADaHtinflWJUmEJEWOb3pGTHZHw2HCZYSJ+ltTM4YS0s41JrnMib0Y2avt5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ilYo/2fG; arc=fail smtp.client-ip=40.107.44.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ilYo/2fG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHhjIAKWgjiAvee22Tn795rfzC/vFIplgOlhTYF1YDFO9+8EwdqscbTwix2c28vQDKOtnYfsiV6H4n/W244X1+GTt8iiieT3eGKh2w4tOU5IiwUtA5Nw5UUyP+sqv6ex6lI9Cz11UlafI7M5My8e64uffBtk8wDue/NsFwZuXTEruuUFhdJucTAsDW6+krveDkGbFUum6P7/NK0wj0OqeYreKxbfuMaprGgm+Y5Hk9JoYbwOVxMYKrKvOE9QwHoIdq05To6a4S8FT1IYkLKfir91CCtQWON2pERUyGfRHolklyhXFBxWQ6kjKnC8/H1uLPir1Hl0Re8Hh3Lex4UnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZzXQxPeLwed5HAeC4iMSI1TV5tDXof6MgXxFw4avVQ=;
 b=yv5tYwnzakcWL7XCqg/V7QrJXrQM8CwJtrTetV9M/JbeQFX09lhC4RfVackjFbrs6nwb8D6ruk0YJ3LR0B3hPsDHCx9VhC0Rm7CTrOo4lM9nYkBSQXgey/ZNOd9SXJ3VPJP/gaepLrbstkt2XeW9h/0lxinfTI2i2oKq0y47x2i2ZkZzMS1FcwFmjK4cCyLRbvI5OMRW1GWhxdutFYfGTD6mP2t1Aj8ccd+mKgZRkUT/UN+JCU4EEkBcTHbQlxJeaoB64lU77zuuoALT3ZKHqPKLbSySiR5CgVdc4mc70CgHcoN7gwb605O9x7/qhC4f0du0xM9IGgQqBHjDheGBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZzXQxPeLwed5HAeC4iMSI1TV5tDXof6MgXxFw4avVQ=;
 b=ilYo/2fGAIqfK5drjdB+fBzm9CdmMq3cghxgViCQeuhe8usadSH968W6IPOogM+07je6EC0yq9hej6PqxZCjM+lQUDSerm+mg/81zyMrC/pS2kbamoZnvgW8lK1RKeUGniCLxgdeV2f2g9eY8n4kmNPDBROwoodN7FjBz81jGy+NuLJvAd272M1FUoS9FNP0Yuimik6kH7SEaPIHui15spXSYEvV01LlyFXgydeL1WjtGZs+/2XSCVCVe5qhqVfKveh7l5JMpsVvQPYR2Zb0Kg7WGblYqjp8SYO72ofa1fbaQAijM0HSAtwmwHM5jxhxFkgkbi02Zi6ck18EWyCF4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:47:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:47:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Song Qiang <songqiang1304521@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pan Chuang <panchuang@vivo.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/13] iio: proximity: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:34 +0800
Message-Id: <20260717094408.509583-12-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2a20d41-e7c5-4661-7dba-08dee3e85b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	6rHhoCBlUQgtel71kNklWeSLgAZuSoEqG4doJP477fdR9W7a4KAq34fmxw1iQOCxUFePlS68JrpdEoUfenWQbIhIL0CmffA5reFlT/lDLVnBB1QVceWXhfAqZ5H9gZ2SJnK7NM/+bhOHsUtcA2zj56vsNhYWmSkrqbWWpxm1258L1uUZvoRsLOth4M7VkLwE6i2qfOoYLG3jJPbn3hF7BIfRxcg81WhFm3LuZhfvAD6J5jNVVHOQSpxmihqt9LGpxcMyKLvcsZQK7Eb+8LpeFrkEWorj5nqH281XZnai6oV+hO0//ySkNGzc8VORtY/HxswAkT//1XxvY0KHS+UQZq4TglMv32p4zFnmrqcyoDV0Z0YdvZSxqYaSYN0EEHwNkUtJE3ZqL2n0VFeccQ0GkYHCHtDs3Os46Jjzzsw/Nixl+3ielQI5XjRM6B3MtmrmjL6mx1Oo1BiY0LVNZtDl1+kfbnX+McA+hvkGL9LnK7LKVPpQpn0zIA6BMG5TqFXysYcbelhxiYtrL5iaPCr7ANxrOVw3ZZjOJ1atIzc7l8i6KQwdAYltaO2PTlEGRscOwCNqf20P+f4mtsam046jupWtvZAFHEx0YZTVHSHsIWiGvlW7OTYWn7a1pmrcJFv92GFxyc988Ej5QsftDK5A8GMHyA6mMBer7VwifTHCg5IC3s5FyLGtahZLw85kIKHlnkbMyD/uTwgIl3Uoml6jIcN1sO6rr7bIFISKEwbP/fqBK5b82ee7aghS5q4bLg+8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fasIcQujgKkTJH8LrIL+tOT4SPzab1/RZU3E1MwoDQhy4ykTvW6UY+V0yIxV?=
 =?us-ascii?Q?7dPjXrYj/JcLGgCjk/ROyeMphjFbH3udx7gl+Wx7G+9bOj1CHRtY4kefmeF0?=
 =?us-ascii?Q?nOhkNgEYPr5m4f6aAwsL7X96SIwYmRNKaZuORR4uVbAoQm3F9zqL2RMzQNV4?=
 =?us-ascii?Q?Osz85y4TcvF2vrNjAdUVjLqEnyKdytuTS9cSE7NLqEF64GG4Hxrufw9jWSoh?=
 =?us-ascii?Q?9OrXYk/Qtr1jiWg2MxJYUn3cPlEzuqofkP/jGUf1Z+LGnzJ8y5t0D4jYMqjj?=
 =?us-ascii?Q?zQC2Hl90+4kdwg9LR041MlYHjveUSX91ywmarozLx67iKJHOJOKH2zdcSP/z?=
 =?us-ascii?Q?J+mSdG9UgRnXHELa8FwVpkz671WLQ2+Xm8rPQfhkBUTviklgydfuHm5+IGV5?=
 =?us-ascii?Q?Kk8xGAudUOuKUW+w8H0yVGKHezrjo/hPDpqHUycXVVbrsZSA1laB1hlys8Gl?=
 =?us-ascii?Q?zXF7/2yYSwcOvbRBIQZL/vwlYvmJefSSX0fz8Yu2smvyl4OZkv+cbMy/xRiq?=
 =?us-ascii?Q?rfSMm+iME5C7vfypeiVYHOZVqKODrTiDSQ3upOENW+UGySVxSSHOFXWL3oqe?=
 =?us-ascii?Q?W0rk4M2OUaS+b2DBRFhOhMnmoA9WszsoS7rzRtAqNqrk2IF8ONBHwwVpIF1T?=
 =?us-ascii?Q?wTKsFPWkU0zh/8mFpzp2KFoSAMYF1BHJL7pQVcCj+/fEsZDPjD6UPNEbIQSd?=
 =?us-ascii?Q?l91Lw1xItVZtkV9LJ903HNKp9/bdRnenP8b58cfXxKTkxb6IdiRKlvJaTfVy?=
 =?us-ascii?Q?H5gHfz49SxEeMQIk0xnA2ue19UNPMrHRee1iTsUYXHvRx/MAWdfR99b2jgyN?=
 =?us-ascii?Q?kptJpgFl1yHAeArWERaeILgxzX0xM3mss8+i9+pUoKdVxK/SZvBGG4ilEFaa?=
 =?us-ascii?Q?YHsEfV5jU6txPzarKLysGMRmvt2xxYEZYZhFMiSDE57ejqo+10JKJZYvqAC5?=
 =?us-ascii?Q?TizuO9MGtwpZPKj8Q5sNZpeBGKvOkKCHEd2PMB1ESsfyrVnohwi6PxaEAzBJ?=
 =?us-ascii?Q?cFFobsrReuWeM3d+ZktkX5wJPnbFSVhdNwGVfeOyS0Qjr5DX+r4bdgN6ywBz?=
 =?us-ascii?Q?aNHbcE5l+aASHJxp+bf41axn6e6TlrjC5jTucGTaphiLkl1viSQeS8taiaz8?=
 =?us-ascii?Q?KKagBsZyzJ+a4TkdbK89jSY2LKk4vm9GAy9bP+q/LSnMmYrM7KYGEgXQ5QGb?=
 =?us-ascii?Q?FDTBexV+Nw9dfbVyFaruxGAM+imZ4frpIrMEScMlzOUjJr3+yst9fS8nFGAX?=
 =?us-ascii?Q?iFaqBKZ1qj4hWY92f+vlfwjnU+LDJgLSua0xvMAl4FnE47aL4e5H6dqACUnk?=
 =?us-ascii?Q?PImZDxivq8kb/TAi7sIr2hYr3O3Jwrt3bEBWZcIhKshlc2ybzSDhQ5PhBsTH?=
 =?us-ascii?Q?1zzzMuCySXulCkO3aziGBtl8FRa516XpsHz2rrRCzDoaTPS0JNKQdUXRcjxe?=
 =?us-ascii?Q?JDgd2DYUKWBS2kuozz3oIiOb1YJC4+6t3QeJqz+18tCnW06/xoC7PJl1NIJX?=
 =?us-ascii?Q?q9djr8mLhj1/A2uHhx6L0K30dA7XwdZfx7AE2o9Lkfp6AGQvsaYq8txNrhKl?=
 =?us-ascii?Q?l5fyB1Jqk9VuGg7EQLyFUDBdVj10Z6T/NM27OMisWdW1a9mny07Kx2086hm/?=
 =?us-ascii?Q?rziUIytCAlXzOzmgDDB3t9n46zurJg5/TSj02UWRh8u3Pd83BssUgGvNsR78?=
 =?us-ascii?Q?A9a1xDyVgROiPoex4xzIiIIjQwxPbZYd1+dBPKHOs0EoWsrQq4g+RMXg5Ypt?=
 =?us-ascii?Q?4RGifI06Og=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a20d41-e7c5-4661-7dba-08dee3e85b97
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:47:04.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dUWpTYttwITIcfqajXUfTRKY+kuZhewW6VElDFvp/a3VI531jGPY5TbekQ1UITMD+zaVw/EH0CF8qywRo+8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
automatically log detailed error messages on failure. Remove the
now-redundant driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/proximity/as3935.c      | 4 +---
 drivers/iio/proximity/d3323aa.c     | 2 +-
 drivers/iio/proximity/hx9023s.c     | 2 +-
 drivers/iio/proximity/irsd200.c     | 2 +-
 drivers/iio/proximity/mb1232.c      | 4 +---
 drivers/iio/proximity/srf04.c       | 4 +---
 drivers/iio/proximity/sx_common.c   | 2 +-
 drivers/iio/proximity/vcnl3020.c    | 6 +-----
 drivers/iio/proximity/vl53l0x-i2c.c | 4 +---
 9 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 93833037bc94..d7f43c3af165 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -428,10 +428,8 @@ static int as3935_probe(struct spi_device *spi)
 				dev_name(dev),
 				indio_dev);
 
-	if (ret) {
-		dev_err(dev, "unable to request irq\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0) {
diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
index d40e3dff9eb1..1f43c1fed342 100644
--- a/drivers/iio/proximity/d3323aa.c
+++ b/drivers/iio/proximity/d3323aa.c
@@ -771,7 +771,7 @@ static int d3323aa_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			       dev_name(dev), indio_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "Could not request IRQ\n");
+		return ret;
 
 	ret = d3323aa_setup(indio_dev, D3323AA_LP_FILTER_FREQ_DEFAULT_IDX,
 			    D3323AA_FILTER_GAIN_DEFAULT_IDX,
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index a6ff7cbe9e65..0199a6351a46 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1139,7 +1139,7 @@ static int hx9023s_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"hx9023s_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret, "irq request failed\n");
+			return ret;
 
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 65af31d43453..b3db7f3a49f6 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -910,7 +910,7 @@ static int irsd200_probe(struct i2c_client *client)
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					NULL, indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Could not request irq\n");
+		return ret;
 
 	trigger = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
 					 iio_device_id(indio_dev));
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index eab881b0cdc7..8b6cfe59508e 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -213,10 +213,8 @@ static int mb1232_probe(struct i2c_client *client)
 	if (data->irqnr > 0) {
 		ret = devm_request_irq(dev, data->irqnr, mb1232_handle_irq,
 				IRQF_TRIGGER_FALLING, id->name, indio_dev);
-		if (ret < 0) {
-			dev_err(dev, "request_irq: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 7be50bdebfcb..395185d770bf 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -303,10 +303,8 @@ static int srf04_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, data->irqnr, srf04_handle_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			pdev->name, indio_dev);
-	if (ret < 0) {
-		dev_err(data->dev, "request_irq: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 59b35e40739b..4d4937395d9a 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -517,7 +517,7 @@ int sx_common_probe(struct i2c_client *client,
 						IRQF_ONESHOT,
 						"sx_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret, "No IRQ\n");
+			return ret;
 
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 7f417372566a..6b0d7a9038d9 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -638,12 +638,8 @@ static int vcnl3020_probe(struct i2c_client *client)
 					       NULL, vcnl3020_handle_irq_thread,
 					       IRQF_ONESHOT, indio_dev->name,
 					       indio_dev);
-		if (rc) {
-			dev_err(&client->dev,
-				"Error (%d) irq request failed (%u)\n", rc,
-				client->irq);
+		if (rc)
 			return rc;
-		}
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index b7127c3c52d2..9fe14ceb8be7 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -127,10 +127,8 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
 	ret = devm_request_threaded_irq(&client->dev, client->irq,
 			NULL, vl53l0x_threaded_irq,
 			irq_flags | IRQF_ONESHOT, indio_dev->name, indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = i2c_smbus_write_byte_data(data->client,
 			VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
-- 
2.34.1

