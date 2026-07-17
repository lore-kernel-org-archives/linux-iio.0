Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012031.outbound.protection.outlook.com [52.101.126.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7A370AFD;
	Fri, 17 Jul 2026 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281668; cv=fail; b=jxx+3v1UvYO1SUpgTLkGa9V/kIz72zRKdQm0GfUAPQLV/JtsSymrcOq2H05tEXVqrP5qY3/1NUCSfeNsk2ZfSXY08BeJRg9wNP4Y4NoxtPTf2Pkg441Jm3Yy7KScrvfQz1lEV0OhWm/LhKoJfnXvqv4UIA1ADexG/Mg6BckeoCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281668; c=relaxed/simple;
	bh=H8/HnybCrOrAyGWof5yZH9NY9uetE8KGWra94ocUWKI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Di75s81tISyVLgC9SUDQomCjC+PFo5JxXOHWglRwnLwg7ua8fsbLEIzTOdWMS9osIDqdR9zcdzh/osXB90TPVgb3HJih7zFUxoa30/GpynelLhCULw7x9fgIdf9NKvTipZrrc15HWsYVBVVbJbdOxJj4XmJITNGhgIDlb3ZieLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=A2gw6LIW; arc=fail smtp.client-ip=52.101.126.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="A2gw6LIW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGzA/7JdmmSX6sTC2+Z9yjssXkhtp9KmyXAJY2Vvwo0WqGLawfiRF4unTxqy1KT8MIoaVV0iD3pmd2E3rs1/vaKWS0Vos5q9TSr67DfWbtBo6Svr6U4EZOTRraYv6hCazyUuVogY8Wkp5sr8y0e4XDOLi61wSwCeagrGO8gLPC1RVTqb1juP1cMlEZyxxbYavtUMy8SxkcZFE11l9EaL/uxInsyj345N+Q6I7pOduz5v0h7ToKnNEoORfIyq9P37/TErV163NEW58VGRcy4QwzoD6ryECC0Z1mMFh5h5gkC4GxUZd24P8cU9/1Ib49vrj2qW+VSiVKStOf0zC5uy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5An8BsbEFEfDY6gCxRPSWEVvPXpFAkOfiZmnpPZTP0o=;
 b=nhQPWa3WTQAITXy2ujXdF4yBVTzwpvAalJ+40+Br6KY1qQfvJ4iHzTquUn0y6FUquOiumkncMVZoiRWKpt16uJkBxO6ZkoMnp6sOVXKHHq8aJYevZhfr8kH74Yse5nE8ABbSOir7LTpkcJbaVFFsr5gl9s/ECUm4cABi2jf/LCMLxOfaUPSNk17PHlOXS0+DY/AuufsLBE7bUPWKZUydt4XnoJoJcQcdYkAKNBnMMMld/H9TthkxS3mL1oeb0OhJoCqKV0j4/dGAf9PGN/dGpNE/QYU+HI+0N8TT29th/OQX2b09h3nQR9QkD0Aas95MAQIllg6EHbDdewWGMOqo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5An8BsbEFEfDY6gCxRPSWEVvPXpFAkOfiZmnpPZTP0o=;
 b=A2gw6LIWIgr93L1s6uj3nXpBePHGpqJcOYCq5hbCVdN0x9jKEiPNfrMCiDLYMLOtSoubm4kLHNTx8E1iTyDe5ahSo473Eb3N1lewPvd+9o9J2d1HZqGtAq7g9pi0KMolRu8HNbW3qJqY5bSUEojGHAl6/7NRKQbGF2qGtUCGd31w1rLCaP2BSHTfGPvBXRPFnXWGpFtBRENTIgpe6elL+Yz1x0HguTBkuTD2RHbOBk7nBFC/EDnQLImKYaX8SXTo1k4u45sRNQ1IcHuHvUOZHydAS2KHxS7lzT/mSgY6nB4ts8U4hyfOcZZUOgl0E9+nusOBHM8rsTV/oHNFFSXL+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:47:40 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:47:40 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Linus Walleij <linusw@kernel.org>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Siratul Islam <email@sirat.me>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Miao Li <limiao@kylinos.cn>,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Felipe Khoury Dayoub <felipedayoub@usp.br>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/13] iio: light: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:35 +0800
Message-Id: <20260717094408.509583-13-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf10086c-f256-4de3-aa23-08dee3e870ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	BVjASXZNSC9k+uMAiTH9FX5ayno+BCNVgqkpODjMvenM3yXrMenGl9xzSE41XSjeEmNRzf8XqJsvJUT2vUOrAEQfReOiGCtBdhylcYGMmPg3soEv6OZGWlMFTwSP0IAnfJludRnlaUPI7wqSvUvbfMF+WrxUP5Tx/ENRbB2uyC8WivnEIwTL63SlN1jM45/tRS9vRjGt0niAVFlVDeJZm8KQxEVMM5CRN4GStT+zeo9OUlYnosVIZJUxzJ2J03uWIONrursI1oyRd2wFIFUXBpboInzjf0xlCiitTNq/N/5s2PAuHXZ3Rmhb11NP+q8vSwJtyxxEX8FZ968lE/timlCVYuhrOi5Ii9uVmCq513KFj42p53mn6lMrZtxiLTR8f1rxudNmGMX7hXgOFdaZew0gI+Ib7FOgVyuDmemoR5DLeeJ4BGLHew8mOf2lVTeVEZPDfN3S6/BX/Vz2f/k7z1SQCM3xhrmY1HD/CTxOyiL3Ts1bIwV0COlsNb3iuf00p4atDrADJDMS9uSE1qKpI8Dkt9rZ95D6iFK5EHOHrjQXzE3kYgrRpH84Nh5VkpXfyEPtJKBV1IVtduVX0k2DqCVlrnGIe86gGM/dByu5AtOuyIIIJAXl4PB1Sn9K3kKqAMsVdg6bPzOzgVLPVY3RELysWCOb59ds/fC/4t4o8XXdLkwi8ST4kRYGAYvdmo3hsQxguhfP8NLcA8AhrxV0s5ebaCfa7pka7oJhJpRyaBAEdm72b86XEYxbk5diFXHE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iB/eKhqVfNgMziasMmjxcVLUFungkjWjUrBJGMgAFZAICZ5RhkmXDZJz7W3r?=
 =?us-ascii?Q?CJXQ+9o/kIK35l6BThgLp8MIIUFTUBSwWlzr089+cX+J+MdbYRJJzpg8gF9k?=
 =?us-ascii?Q?HSuDYj5+zTvIhpYMFZ1MLP0U0M8wFt/437RkSOmIe/HIYrMtecmAe21GYYey?=
 =?us-ascii?Q?CP6DVZEuWN51YqXOeWkdZIPqs3a54bqfQ71tvPmTHVqOyDMvpLWNVKakGz70?=
 =?us-ascii?Q?E5ROav3H3dmkVGQpLCyExfBKw/1/zUR/e2aPcxKpAXxc7/40WkfreaEP6HZF?=
 =?us-ascii?Q?8vb0LY6EDZlrjwPuvFHK+zrTSBO7CZcV2rutwZ99ka3RCLqkQZzi/o4r+NAY?=
 =?us-ascii?Q?z6Hq4KlQq1zWuYIKRKIdu9IR2xeDz29dkXbsRtWOXrhRjbQHWpprxoEqov1d?=
 =?us-ascii?Q?CLczXiM+jOMSoBxRWvnJZyw96Pth4lq4oqQu+VkSvSH5AOOP84ZvKC7ebZUJ?=
 =?us-ascii?Q?RfEkJAMO0f7a5KdZPbJEmTeFeOVkYEhsmAvndpKuROMS4TBO8w2aDqZJ9exm?=
 =?us-ascii?Q?LGCUTNbCUQ7pzEWAbzzELxrfVwugpT3bBDsHURNSGJ75kFZLG9Ytkc7yIADL?=
 =?us-ascii?Q?GMahvMb4Rdfk0ztQW0qBD45QE6LIifuUadhu3t5iCoArrUf9uCoqgfgk9ddY?=
 =?us-ascii?Q?9LDBcMNwHaRs7W0XI1w2TevoROhwa98bU+HEi0iKF9g9sov1YWonrWWWEAz9?=
 =?us-ascii?Q?QTwioxU7JHX/maWxO4IWm24AWUg8hk8FKQVxpzhICX/cPVeF5zhEqargVwW2?=
 =?us-ascii?Q?jsGkGpqLl1q8yHKda9n5nRbjEv1qRmmHraU0zu3nGV5cUFtDwLDpR6dxpUbN?=
 =?us-ascii?Q?JdE+ksqY1aQx3sAUUvOz8O+Yzx4n2T23j6386zS53zkEjxC4+quViMPm4fCd?=
 =?us-ascii?Q?XRrtdG3EhPNHR+JCSsdaXsEyfwZemjKpzgxquUHs9D3tt1O+Uw6tpnqMM8Tw?=
 =?us-ascii?Q?PdNJacU/xHB77KVHX+T5FSEx4MWWDSD10sktDcPiHGG8g3srSGndwoJmoViw?=
 =?us-ascii?Q?2MPbHQz40qpv229buHMGIca2MHoUO7mBIFjkctmVd8lYF8zxFCUIqyyZP3BJ?=
 =?us-ascii?Q?fjjtbdRKBW3Of56UIQCAnKeqqZHCDejGuQvcTbaFLIz4ZJbYSuz31+iM5TY2?=
 =?us-ascii?Q?redvUCLAGLGqA8OHc5+6SezWEg3n8Ae684quxxz71cZMeQxYuMoFzGsavuCI?=
 =?us-ascii?Q?L1tNSKjS8/qKZEhyf8yJ36Y4rmG/ZuUcKu+5F9ZV4VCCsvaAitQplmoXw/wQ?=
 =?us-ascii?Q?74nrgJGkxMJkDn/+I3aP1o37QRZDRvNeYQ/yHSN32iXSCx8K3r+kEHQ8tntG?=
 =?us-ascii?Q?0K3afnmU+Dq0KeRXOFQ0D2LwF+mwqlteC2SW1xOJinsVA8CdAWQ6JHZukSE4?=
 =?us-ascii?Q?kBDATHn7xp+ScSF8YzlMLxZobsjXE4gdLscAT6/AgbMc5/yzfIQW3KKj0CaJ?=
 =?us-ascii?Q?42X0AZzRFz1OnleYbNjAAKUnY59ERXMCzBwQUmlwesMzvXR7TlFmUZzTHyxN?=
 =?us-ascii?Q?r3mqanFgBhPsOSxKUg8fcXjzeOAHiUrh4XiRtH5BmtReGUTLZvki8Z4sWwk7?=
 =?us-ascii?Q?1BF5CjHusGahJC4JVj9kg3XpXibaJ2stL3vzbIzzd81KiexwUZO+B9d1Mcr8?=
 =?us-ascii?Q?6zUV9Fdd3TqPZ7OjPF40f4ZdU6+2xafVKydJvLVDQQie74E28BUZUzNm2Y/2?=
 =?us-ascii?Q?FIWWTtKigqzpMeatW8uXUNRcu/d4C++KDPu82fHI9HzHsO2C5PbApAH3HTHx?=
 =?us-ascii?Q?v+Zewsk7bA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf10086c-f256-4de3-aa23-08dee3e870ce
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:47:39.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4XYfuAJPsIyC55Tp4tkf/AIgAwNypxq1iefV/ZopOnMSruKhUzIXenU1CH0V7pVxADWbdBxfqXV2HESCXxnmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
automatically log detailed error messages on failure. Remove the
now-redundant driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/light/adux1020.c       | 4 +---
 drivers/iio/light/apds9160.c       | 7 ++-----
 drivers/iio/light/apds9300.c       | 4 +---
 drivers/iio/light/apds9306.c       | 3 +--
 drivers/iio/light/apds9960.c       | 4 +---
 drivers/iio/light/bh1745.c         | 3 +--
 drivers/iio/light/cm3605.c         | 4 +---
 drivers/iio/light/gp2ap002.c       | 4 +---
 drivers/iio/light/ltr390.c         | 3 +--
 drivers/iio/light/ltr501.c         | 5 +----
 drivers/iio/light/opt4060.c        | 2 +-
 drivers/iio/light/rpr0521.c        | 5 +----
 drivers/iio/light/si1145.c         | 4 +---
 drivers/iio/light/st_uvis25_core.c | 5 +----
 drivers/iio/light/stk3310.c        | 5 +----
 drivers/iio/light/tsl2563.c        | 2 +-
 drivers/iio/light/tsl2772.c        | 5 +----
 drivers/iio/light/vcnl4035.c       | 3 ---
 drivers/iio/light/veml6030.c       | 4 +---
 drivers/iio/light/vl6180.c         | 2 +-
 20 files changed, 20 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 633a105fd7f0..0ea282ecc99a 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -808,10 +808,8 @@ static int adux1020_probe(struct i2c_client *client)
 					NULL, adux1020_interrupt_handler,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					ADUX1020_DRV_NAME, indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "irq request error %d\n", -ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
index 8dacb1730429..d7e0924b8106 100644
--- a/drivers/iio/light/apds9160.c
+++ b/drivers/iio/light/apds9160.c
@@ -1545,11 +1545,8 @@ static int apds9160_probe(struct i2c_client *client)
 						apds9160_irq_handler,
 						IRQF_ONESHOT, "apds9160_event",
 						indio_dev);
-		if (ret) {
-			return dev_err_probe(dev, ret,
-					     "request irq (%d) failed\n",
-					     client->irq);
-		}
+		if (ret)
+			return ret;
 	} else {
 		indio_dev->info = &apds9160_info_no_events;
 		indio_dev->channels = apds9160_channels_without_events;
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index d60ade1209f3..f0abbc4a862a 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -432,10 +432,8 @@ static int apds9300_probe(struct i2c_client *client)
 				NULL, apds9300_interrupt_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"apds9300_event", indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "irq request error %d\n", -ret);
+		if (ret)
 			goto err;
-		}
 	}
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5ca4c87524fe..697cb36b975b 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -1286,8 +1286,7 @@ static int apds9306_probe(struct i2c_client *client)
 						apds9306_irq_handler, IRQF_ONESHOT,
 						"apds9306_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to assign interrupt.\n");
+			return ret;
 	} else {
 		indio_dev->info = &apds9306_info_no_events;
 		indio_dev->channels = apds9306_channels_without_events;
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 2686c3b0c03b..afe520de60e2 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1098,10 +1098,8 @@ static int apds9960_probe(struct i2c_client *client)
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					"apds9960_event",
 					indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+	if (ret)
 		goto error_power_down;
-	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 0aa8e5cc6c56..2b8ff36071b8 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -784,8 +784,7 @@ static int bh1745_setup_triggered_buffer(struct iio_dev *indio_dev,
 						IRQF_ONESHOT,
 						"bh1745_interrupt", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Request for IRQ failed\n");
+			return ret;
 	}
 
 	return 0;
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 9f799041edf9..34c127593947 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -232,10 +232,8 @@ static int cm3605_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, irq, cm3605_prox_irq,
 					NULL, 0, "cm3605", indio_dev);
-	if (ret) {
-		dev_err(dev, "unable to request IRQ\n");
+	if (ret)
 		goto out_disable_aset;
-	}
 
 	/* Just name the trigger the same as the driver */
 	led_trigger_register_simple("cm3605", &cm3605->led);
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 02818e2aed68..0f51cea28c09 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -573,10 +573,8 @@ static int gp2ap002_probe(struct i2c_client *client)
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					gp2ap002_prox_irq, IRQF_ONESHOT,
 					"gp2ap002", indio_dev);
-	if (ret) {
-		dev_err(dev, "unable to request IRQ\n");
+	if (ret)
 		goto out_put_pm;
-	}
 	gp2ap002->irq = client->irq;
 
 	/*
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index bdc74b8226c8..bc031f2c3141 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -838,8 +838,7 @@ static int ltr390_probe(struct i2c_client *client)
 						"ltr390_thresh_event",
 						indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "request irq (%d) failed\n", client->irq);
+			return ret;
 	}
 
 	ret = ltr390_pm_init(data);
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7d045be78c6d..fa0d16890c8b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1537,11 +1537,8 @@ static int ltr501_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"ltr501_thresh_event",
 						indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "request irq (%d) failed\n",
-				client->irq);
+		if (ret)
 			return ret;
-		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}
diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index c391ad3271c6..98e644192ce3 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -1200,7 +1200,7 @@ static int opt4060_setup_trigger(struct opt4060_chip *chip, struct iio_dev *idev
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					name, idev);
 	if (ret)
-		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
+		return ret;
 
 	init_completion(&chip->completion);
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index f961973892f2..aa5faa528b88 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -987,11 +987,8 @@ static int rpr0521_probe(struct i2c_client *client)
 			rpr0521_drdy_irq_handler, rpr0521_drdy_irq_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"rpr0521_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
-				client->irq);
+		if (ret < 0)
 			goto err_pm_disable;
-			}
 
 		ret = devm_iio_trigger_register(indio_dev->dev.parent,
 						data->drdy_trigger0);
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 4601ae5d2009..910a5a191cdc 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1251,10 +1251,8 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 			  IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			  "si1145_irq",
 			  trig);
-	if (ret < 0) {
-		dev_err(&client->dev, "irq request failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_iio_trigger_register(&client->dev, trig);
 	if (ret)
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index bcd729a9924e..94d5261b2663 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -196,11 +196,8 @@ static int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
 					st_uvis25_trigger_handler_thread,
 					irq_type | IRQF_ONESHOT,
 					iio_dev->name, hw);
-	if (err) {
-		dev_err(dev, "failed to request trigger irq %d\n",
-			hw->irq);
+	if (err)
 		return err;
-	}
 
 	hw->trig = devm_iio_trigger_alloc(dev, "%s-trigger",
 					  iio_dev->name);
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e7ce6f32592b..4cd705d98ee0 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -673,11 +673,8 @@ static int stk3310_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"stk3310_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret < 0)
 			goto err_standby;
-		}
 	}
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 45f3513d931e..7bef0c3118c2 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -754,7 +754,7 @@ static int tsl2563_probe(struct i2c_client *client)
 					   "tsl2563_event",
 					   indio_dev);
 		if (err)
-			return dev_err_probe(dev, err, "irq request error\n");
+			return err;
 	}
 
 	err = tsl2563_configure(chip);
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 244f44379c36..83ef7c665146 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1849,11 +1849,8 @@ static int tsl2772_probe(struct i2c_client *clientp)
 						IRQF_ONESHOT,
 						"TSL2772_event",
 						indio_dev);
-		if (ret) {
-			dev_err(&clientp->dev,
-				"%s: irq request failed\n", __func__);
+		if (ret)
 			return ret;
-		}
 	} else {
 		indio_dev->channels = chip->chip_info->channel_without_events;
 	}
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index bf3a49b4351d..8ed347a2dce4 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -545,9 +545,6 @@ static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
 			NULL, vcnl4035_drdy_irq_thread,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 			"vcnl4035_event", indio_dev);
-	if (ret < 0)
-		dev_err(&data->client->dev, "request irq %d for trigger0 failed\n",
-				data->client->irq);
 	return ret;
 }
 
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 7c837d60dad8..ec9c127e7d8a 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -921,9 +921,7 @@ static int veml6030_set_info(struct iio_dev *indio_dev)
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
 		if (ret < 0)
-			return dev_err_probe(&client->dev, ret,
-					     "irq %d request failed\n",
-					     client->irq);
+			return ret;
 
 		indio_dev->info = &veml6030_info;
 	} else {
diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 4f270f405b21..aef8a5333442 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -721,7 +721,7 @@ static int vl6180_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
 		if (ret)
-			return dev_err_probe(&client->dev, ret, "devm_request_irq error\n");
+			return ret;
 
 		init_completion(&data->completion);
 
-- 
2.34.1

