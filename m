Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013037.outbound.protection.outlook.com [52.101.127.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6781A9F87;
	Fri, 24 Jul 2026 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862489; cv=fail; b=T9OoyOuvcimZk802OzufrZ2lxWrpJKM74Z+O2hwhQUt01ug4m5zkvfvJLsTaq+A9EjLqJItXPpuyD+OfhJs6T95LHKwe6CowvnzsipUtrv6omEGBGa2FksSZ51IpwMNRLUvWilLkx56OQ1zNTZSjAPUnOko+B+oTriP6XWu0kQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862489; c=relaxed/simple;
	bh=IxcEYjs6ATcpXYa5orVUGn0jr/D26Cs0L47FfEbldLY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHn5jIra3bLTuK+w5YOcrUki88aYGpeGYquxX3qhvGsK7DkIFKQR2FHBVQ4QbwmfVuYZ7LdCssdrpBuItpHY/qRcZdaqyibIJu0E4irMGZT9dEw3Vt9xCqyuiXr3DzHRRTG7kHDt3B6e2MOaqVOd0c12LFX0RH5s6G37hhcpW5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EfVpn38O; arc=fail smtp.client-ip=52.101.127.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EfVpn38O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRi8GWfbQGmjffk0AZVUYcXk347s9FILOsKslFSUj85k3+o4HHTVNgJgiC1j1GnlKXytHkWuAWSOZEzjp50MgbVRlnYF2HXDzIANC4QjCK9oAaQNQ/3OgDHATQK9qRXsMnZFC5gHN0H2sBcxnFh4DcpJv+hJonJzlV3Clejf8mUP4e2amarspUZJGn2vTE4KD48a4/hIIwu/4y0n1+CwRZmdXlFOMR7lnpiwOGtqkdOYpZxGFUEH6VPx/F4w9BiZkc50y5OAH/S/7lu3WtZ9fRuyY6UnSE0M2//XAN6EtV9c+bjAB/cywtst2dmvKfv//R92xJDGuHkaJ2lcExVoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i/hZYmggRlTkV75B7uBwV87/lRui+lwX9LcIYqfaIY=;
 b=QT+MabZb+RjLTKpRGw+VTVdHeGB0BPlL6xy7DoTWcLdJ4jDBQcBbuq19lBbv5km7Hj1ylPNVI0PtNYzjAoh5Ynl+h6h931gvjayqOVirdDYDx/JvWOdA0rcOVqwesqNuf4d1dvq2b0Lq0RBaUoxSQT8Sot39+8FyZICHnQ5DG8oN+FBQCFKRqStH8w4nz4F0PGiEa0iluymsipzEZZ++5+RzGVWGk41B1FOka+N1z5HTPimke7P3BkEASHd4ggUM810IqXz1vTIG8+psOJaVevu8efcVeWho+nkuuzmZZnotEPtRiymr0+AOpFxksLr+2A1XBi80boR+JXjPMrYpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i/hZYmggRlTkV75B7uBwV87/lRui+lwX9LcIYqfaIY=;
 b=EfVpn38OsOjldP+pRIl1ITS6B5IiCH0OL2R+TrtDAcaZ6oWkpS5nH+NsHJ6hAOZXDU8krsL/RnY09iiT28ntT5CixRzgULyW/H3zO/O+y7VmsSVPZTy/1Y2Ov82hptkI7RtCbUq9BD6WWgiCY9Ty0zWR4C3WogXHBcIf03ZDjuXqo2tGFscG3SazSB/IsI8vCsArA1C3di2DL4CfuQxFgklhpLvHUoOSHBUHRFpl8jccvB2H8wy4ru0Dr6/EK+UivYYY/oTIlUPIM/HtLe9TyxvXivwFnEwiWJoP2GkjQdLiiVhfndh+8aXqnR06tTMDIbmYispsUdeulGoK4N0CdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPFE340CD3DF.apcprd06.prod.outlook.com (2603:1096:408::92d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:08:02 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:08:02 +0000
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
	Pan Chuang <panchuang@vivo.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Siratul Islam <email@sirat.me>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Miao Li <limiao@kylinos.cn>,
	Felipe Khoury Dayoub <felipedayoub@usp.br>,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/13] iio: light: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:47 +0800
Message-Id: <20260724030524.607185-13-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY1PPFE340CD3DF:EE_
X-MS-Office365-Filtering-Correlation-Id: efca0334-ebfb-4572-5f01-08dee930c5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|23010399003|10067099003|11063799006|56012099006|921020|38350700014|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	goeYHo1jg5kATBCGTonaAgZrbRWvF2w+MY8VBLq3/Ps5aOXQrWybZBRJ1fknpck3ACF5jiEsu8s4RQLRSbPWvn8etIuOgr4KC5aT0PfnfKdn2qj5kK3mYpwuOgZ6Pd1tkU3kku67c10mJ6g7UEUQRkKw3gzqZyM3lap4Mqn3v5dvBLcxONbhj6J1NIGMUydOwa12MyUUxc/c7GYDEyXf5ji7Y1JDoVH84AXFF2lrQBv6UUs9aVixI1oHm9INKNDGf97EHFO7so68Lhy215CtnjtiI2wQL8TK2Pe3pfisE3PAp6KAL7WZZeBpLeSBIxwbZbP1iELuE98EBHT6hvMNFBpAMMwdHBY9aECpOBkhU/VxnS3g9OWeVAmqUKjNzwrjIbJcT25Ycof4Gi50Qxje3v8dKYZ6ovtb7oA0POWwTb1Wx+ikcu2Ld2LykmEGP/g9zQB2jL+QGYIZByD7IcYZZDRhWL4J4ONeB7saNtP50C/R4et9MuNDTfUh24cCdsCPGDw4pff6Tohxze6No9aJA1opvBZYNjvnDJweLFVwOByasrA0qZWASFBPzAz+vp7WZ8RP9d51zoTFedC7TdGA7uxLQwpbp65vJujwzAIZGNznD/I8mMA9Nlr58fANOrzNn52JBxiJbS5j/vGyTtntURUhQLKCN7zfN1fc9ojThlVfXhYHzuVWSncRkHFkqzvYwAsYxLiEwbuCD0LFlsF7haNlZbB0ufJbckt7/AoHZq6boCG15S7Rfh6jOCOkrmmr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9WTeXDW1+hBIf9sPg7ToljReDdq16fCkP56eOekZageI7RQ1QlCIzztYJuYT?=
 =?us-ascii?Q?TFR7vopAS0XmlnA0pyJkyOscPjNefcpFKE6LFPC1rWC4zUWMFyHLjthSpblv?=
 =?us-ascii?Q?kZEB+R7hVRBpfASvtbTLJXuUzA9r1dnss6R5YuPjAq6x0khudRjTq6pUqoAQ?=
 =?us-ascii?Q?9CfZ9E3MC1iErDVFK+9KEDEWVxrsfHUlRVGY8J5m4XsB8lFDzXySRbUErlZg?=
 =?us-ascii?Q?ZAKagIMaIbO6sflgCgMpO33wcm/wqpOTZTBI1jfARv8TiHccrStWe1sC850B?=
 =?us-ascii?Q?BCoCthyMxPXpDQacQgokWKnlsUTy/IEGxYVT3B39iuW31M0r5dsiDEGLAVPW?=
 =?us-ascii?Q?uqANwyPnk5Ej61phY+MrNiMnPH4HPYc9KyUZTy0GyaActqz5FNpcp+3WOD8e?=
 =?us-ascii?Q?xBJyRdv/IN516XC4bLttUP2txBfSJQ2XdYF46hPpawTmX1rrOJd5JDQTo9X4?=
 =?us-ascii?Q?23O91xrxMn0FY53nhAd6VU5VKxAAhoLfpFV4mCS3f4x4Epm5vbnTokuA4XUB?=
 =?us-ascii?Q?oBdz4Ak2SDb4P2EegBlMCO2zSVsXsoIo7jiHAnZdUnn+Rm3g1S+vAx9/4YDi?=
 =?us-ascii?Q?7+SM91v9DjbIPAc/8GsBNWeSynC3MOzvkA+877dDbghu8EpgIDxKJqm/i4TD?=
 =?us-ascii?Q?LPtNPNJo67jIYNcKC5cSMMfBiq+2wni1f57N4yh91/7mwTCgSDplCdWLR5jV?=
 =?us-ascii?Q?7RbVce2ARImvvlm/RrnV9HyjBm6lLRUgt/ux8Sm0YonhCKkBzeqf0Vr+NFjv?=
 =?us-ascii?Q?g5xwDfnUuC0Zt6eiv7QRUAP8dmmrOrO72nkz7U6WvUNOZQyAPCkt0qNeqCMr?=
 =?us-ascii?Q?ec0F3h5pPOVooK4Dg2fd61yhD96Yiph/U0M38pNw6ERC4vSI4GXuQEcqUaB2?=
 =?us-ascii?Q?iZq9FtUKjoL5xgiBJ4Mlbw4Ilq6HyMEFyG60m5v0xEQUsAifUgkyVHuY3gGk?=
 =?us-ascii?Q?cxeeVfn2QTaN0+RhvLq/EidA5D3RjjVW2e4smbYMCK77LgqKBba5MOOVKQUN?=
 =?us-ascii?Q?RRGlaVIxZY927BZzN5PmSUWNjJDKb8DvrChQv0NSOhBaS5JHuRK5vUL9eX0G?=
 =?us-ascii?Q?Pjx2lLwniNImh8jaF813ujlmg63G7Sj+94W2zJ8NSz2tts2XzuvXq/ai7iUN?=
 =?us-ascii?Q?Pc3lOOonaaRmouaCgCgnu9Aob/TrDl32pQRYIaWn/bLsbLaCyCgDMjAjMYiI?=
 =?us-ascii?Q?Kcg0ytDprzbUjQLzGNXaF1xFMUQyprDZhxWhaSu4QB9hYkX17NqbpkTM0FCQ?=
 =?us-ascii?Q?4+ft/dg70I9PW50TSZZhk+NtYcslxmepQWlK/13yPza1vz4pjVHn3Y/aFs3W?=
 =?us-ascii?Q?14icbHE9Zvr/l/+lQI3ixOXvVJtn+NuC8gTPa20RNI4Mw7dgTqnkYdZdGVFi?=
 =?us-ascii?Q?7jUrSTVIcCmDCxKmyftyePZVrgPPSN2LgdWfqH8zBkTkBHSZtjyfwxS/3oej?=
 =?us-ascii?Q?xQT8+PPxkmLmvV+GLElzMEjr+bR3eFRuOrf7cTcrF60/MDHMkzMO7K6jv/dW?=
 =?us-ascii?Q?R+QAYzn9cExpiFI9XYyTrIU6++W0Ma6yM4mEliLTk0mskTGnZW8wTnkTzgs3?=
 =?us-ascii?Q?f1Bja0TggenRov1RRkoDfVcmE1Nb2wBqSjhEyS66juDC+v/QJGSUVrwf3+l1?=
 =?us-ascii?Q?jcSS+cpWBLe1mIMOVtnH/SnkFx2Ccdf8i3AhTSJ1xRVESLuOif0QwNx6r0mr?=
 =?us-ascii?Q?xzS44CaVEEBBd/pfvYNWL2cETB6vXvZk2bcwGqWFTy2eMHslhGx0Ar3DrDVR?=
 =?us-ascii?Q?DOWwG0TWxQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efca0334-ebfb-4572-5f01-08dee930c5c1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:08:02.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jN3lVQO3UhyCv1btsSM0qU73Bc8dMcQ6keEvYWUKqYZ2qCc01vIBCeT7Cfdnmq0+t+SbXuYRaGGLs979I+onrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE340CD3DF

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

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
 drivers/iio/light/veml6030.c       | 4 +---
 drivers/iio/light/vl6180.c         | 2 +-
 19 files changed, 20 insertions(+), 55 deletions(-)

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
index f961973892f2..96de32cc255f 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -987,11 +987,8 @@ static int rpr0521_probe(struct i2c_client *client)
 			rpr0521_drdy_irq_handler, rpr0521_drdy_irq_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"rpr0521_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
-				client->irq);
+		if (ret)
 			goto err_pm_disable;
-			}
 
 		ret = devm_iio_trigger_register(indio_dev->dev.parent,
 						data->drdy_trigger0);
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 4601ae5d2009..bb7c99041819 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1251,10 +1251,8 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 			  IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			  "si1145_irq",
 			  trig);
-	if (ret < 0) {
-		dev_err(&client->dev, "irq request failed\n");
+	if (ret)
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
index e7ce6f32592b..7c8a1d2b2ed0 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -673,11 +673,8 @@ static int stk3310_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"stk3310_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret)
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

