Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013023.outbound.protection.outlook.com [40.107.44.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC6372ED5;
	Fri, 24 Jul 2026 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862388; cv=fail; b=N0j9sPKnpnMLMczgZUgplqAxlN4d2BjxoUMm/cYEx0PDcnInMUJNWzsO1CJ3iKGVi8B4ZBGhtO+DwLohNWF8qdPiOG4ifupm3TKb62xAEnuYsr4F4cNaxB2ZYhD4203lR0qSckQylvu7vTnWOK2VOBF1mrZSuBn750cF9J0YwHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862388; c=relaxed/simple;
	bh=aO3WbwdfL4Yvp4UXYNr/LwmeIqZ7KMLa0Y7huzdBJVo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIg6HDghhOb7p4jHAg0XW9LUEeImcfLiLp9kGxxO4g9N4jLgrkDUySXdQooIa+NLRHLCHz77SZXKNJ5L6dxDQALBqp2Ev3lLbDwIaW+U9xhjcyyyrzh2GDbHxRG54vLhzsJ1vNImcTkzFNcou2sNLMqk5co9DMyBwV3mcwgaxBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ncq9/S60; arc=fail smtp.client-ip=40.107.44.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ncq9/S60"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfEeqaufX9IHm0C1grXHCH1NhqY9w+HKK5WoMF+KlYbx/MmOQ09dgoupVum4GBXfl1RAoKcjNfg9tBdnlqRYagQO2Vo9dRoqMgVur+uK1VV9pncGCFOvsc9DScT3eHZPCsxtB5Vkn2mcO53/f2XbUBxHnUPUDqZFFYEXNYJDiuBvktKp34A07CsJ8vFh+aAOvMHKnXX7aBQpWbRBIUiWxfZXVxc+aMiB63xpLiQ++cp6Lv2Fn5/JbVhbyzMfDsdUwn2tutDDtjxD5giq7rPzz1oG1ahHqmRLv1ChoeGKAjDbe9IkehYedTlsqOILIVAxCu0bq9iOZkeCtjavTv0pVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7yhPBPT3pp84cZYHAmV1NebHJTypMKNbWTrflgU7+Y=;
 b=jiX4gbWhb6TsBZPBtAbD/ewX6tTYdLlFXgYpFhc+Ry+gRjNVAOUn5QcbXZVQx+yML6v9WsHdm+hrQnPM3OBnvXyBdsXxnZORHPovJBmXC9qBjtJ33IpHm5B1raW9rvWPNDllFplhDtTaBFrZFcuBeju3/oRSDyYfj+xmqXHQA4b4BkOJbta6xtj7XV4oh3zDiz0JHtmdY7qF+o4JtA+Id3kUGOL3N4JSVlaFXmR/9uf7nDIEkqDkccnA8oSGXZ4gRH/0NmpdwjEubnmobFkLGbw/xjtbWH0+OfEf8tUq0F5p9bsR5OuaUzesXW4hL3DuMxOxRufl4nkMDcPXDugCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7yhPBPT3pp84cZYHAmV1NebHJTypMKNbWTrflgU7+Y=;
 b=ncq9/S60rYVEGFJu/NClqhPTKxgYe4kD4PGM6hmAi2lLfDEbfF5opeuJcVBvdqDbaxZMMXp+kIA36zPwAFPIfzD4MprKh8IVq79F22KDjThtm1LY6qgo0wV08sdcl5ifcW343JNO51GPY3bU3nGRe2gd5EmverLrrYRPH5vgE1k78UkBBLK1EYxc2wNzNVZ1tDs/uxux66DSP5PjvWALmnUxlrtf3wKGYrsO+rNOUP+VVObL2xjAWN+coW/qiE4O5ZNBxGG17IZFsn6/L5OPHhVvNMQ4Dpy2m83xjGfsAuYiUsJYzsvhEy4pEZoSJ60MI3R0fxcaK54uDqHvPLdv8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:06:24 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:24 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Siratul Islam <email@sirat.me>,
	Pan Chuang <panchuang@vivo.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 03/13] iio: chemical: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:38 +0800
Message-Id: <20260724030524.607185-4-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb225345-509b-401b-5424-08dee9308b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	tzlfSmWUMWM5LV7vzfyfq9fwsl6ynO2qCEJumxMyJFp9e9yD8AMmqSbmWWXKDSB15t4UAwlnSd0dP6+x/Fx0d2vGsnYbcR7nK5OB7paO/t/F+XF7COPWJLyyPeUTVH3IZBEmQzaKzQV0zG01LsMosRxK3vKGzUwvhrR3qhY8bcs6kwHzjDA8//mKzeEXZWVQDo/OI8VwUQQpiAPJBkMhH+qZWyeTmPiJusiJG7gCvn2EM5KppBZAailHzsqmdb8MgcGoXSQ5gAu1km8CbMiiMDcujGjRA1+oWa5SW3RgyZ7659Xk+9B6fAtD7Dag6AaiE+Q8tB87VEtMPmm/tBueu1kFvsxVmeN+Ljp2SN2dinRNlpBbuu6qlsC5pZXdGU4iqjFIWGGXarj8OO2vNVjoFRQKopf+mw1t7M9RTA/xd1uWhzqBn2L6deYmi3lF6NxkSo5ge8wdRcv23e5+N7qYZGehW680x1Tac4YGCpYHb8ySpkfZWOx2v8dhK9KrffMSnX+NVjSmGpmaz9XkgdxDwXms5c3JTRjA0S3ertkDjHiZfnMMkBFp1J3b/w4ZV1xlKcyl9jiNuH9YWXZiMDYYVh0XQi9tsTCV9gTDEeFotJUftDV16rmEZqbYbzww7kUvbVOu7qoerTz1fuerFJhOKV+oM1m79wE+dDGoS0nkiEo6Xqk7SrC15iGUPu+Y8ZgE32jIs1zn+fIzFS92qPPgUSlxtfrv1vF31ayoT/Tnc1SbVnSRJiZSvD2AiuztK+pf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iRjqPnWzIkTT4I8U3fBaBcxkvUv86/yUglHOPxl3v0DmO/65JltweqNpBkYm?=
 =?us-ascii?Q?ADdo5izol7s58yRrmFLhJ0YqkJbF00jVgN6IJRQ4cQyBKB6g4NZK1UaGuYi9?=
 =?us-ascii?Q?0hki4fuxvSnG/cCL8WN0oIerQihS8VFhxBLNrqRT98SiHRTlHhW9/315zswm?=
 =?us-ascii?Q?5YWBArHL0uzwIf5vlUxCO/JoWuex7en8lEt4c/amump97CYfDzePPn8kC1MX?=
 =?us-ascii?Q?XyuJ4Au0uTGYnTcPV9zCo6JmRvNj3eymVsHWlSEJ+3ymLozPbF/dYW7ARRMy?=
 =?us-ascii?Q?sL8F28YyJ2ElfWi0WQF9noZtOYPtLNMMsWd+eu/S9S0J7RpLCPIuYQ7tOPys?=
 =?us-ascii?Q?OuNnKxdIihihGKQNpO4z2iDK8jbjHK18wYJCDsskNV5QlOo1WuDgpCJW9naZ?=
 =?us-ascii?Q?is7ISS/v7avaCguPY4qZfTrG4RPkyV3kOFe/QSQ57A8hVhzzLUPcxX8JLmh8?=
 =?us-ascii?Q?aDA5PUSr+h97huwohe9BTy+2tQzdj5lYYjht6MTe25c+CfXVPLxxSP7nFr9u?=
 =?us-ascii?Q?aM53vBPzXEGz3HBfxzoKJ8sc533uhGxeDsbvewVLjwLZlnPyIEhywJ/dK/jv?=
 =?us-ascii?Q?+XZLPTkqDbtAeefeIJeTgdrr+Sve8Z6f+kZWrpeBI2E0arnhJmuf4GRnuUvg?=
 =?us-ascii?Q?BJVMC0K+nyJFQO9/fZ6UWOThoiFz7s1eefq3EFEQ+vFfuqsi5xR7W24tT2Ds?=
 =?us-ascii?Q?5FgPGkodwVNR5cSR7cXqEomhcnjzDPOki3dNJma54RB6FAdIHPJtJc+OrEij?=
 =?us-ascii?Q?gWHjn07y+1hZ+noGAqUolL8mUBefgaNx/h5rwPCAuflK/28MrWb/0+//mRuO?=
 =?us-ascii?Q?oUqldKHfSzgb1MOZmCNLDWEUD5n2r0DBPjwFYSheESiaCIYYDQxDvsrSPhxR?=
 =?us-ascii?Q?Mjsgn7jy4+PUEbO5BAhrYfLKZsqNzxbXLK7Xiw0DPWewxZsTSnax8wXDUmtC?=
 =?us-ascii?Q?rjRklYN62q15TFTkeg388Hnrbu9uPGuA6kfpCP05H4aT8ZHm27zcrxErJXmO?=
 =?us-ascii?Q?v99jEmwbTmyaiP6rR5lEH1gX4QqKTjuvTDTGscrKnsu3QJ4KlAZVh2y645MH?=
 =?us-ascii?Q?6Jb70BX9NKb6hsSaHd6L0aycYbFv0sumI0a8YxpW21v2VIodkTgxwmDC+AbC?=
 =?us-ascii?Q?YlMnVey3ECJsYofxeutWX8RODuW5twaj7d3Wog/ao6fjKyIYDko8u9IumXwy?=
 =?us-ascii?Q?FnqgvQxRvkMo1E7kdoF7jgUPEKmu0/aNbUJ2x27vGl8Izy4opgk8e71jBB5U?=
 =?us-ascii?Q?lUtjdDs2bBhZX1+FPnGvcU+7SDIMPqbr4gYpuK3IYvCEeakaNqKMhAEDnFjt?=
 =?us-ascii?Q?ZRq6F2FdbbXotXv99hqMzvGk96BMPi0OmDu0VH3yZiHF7zvrfBGZaJ+vOPUB?=
 =?us-ascii?Q?yhJr2fMpWcESjIKTQAGewvjtHTwp5yblHgHjoGvtHW+xe5B35cp22iosxHyI?=
 =?us-ascii?Q?8gNhLGACAfwvFlD9EQd5eAAXMxqd3ZU02A/iDlE67ryDar15SnWcmkLU2D6V?=
 =?us-ascii?Q?Efw737yrNJPGdcloTC8yQMD9QVVmpUizfc77XNS8j+1yArgen/12FoD8eNUL?=
 =?us-ascii?Q?041mu+2kUtQp9wT7R8v6krqWQMl7Hw8WKTBwepYrxunZp54+mK67bGK94Fam?=
 =?us-ascii?Q?MGojQmRTvpZbTIdZfAyzyO/8hmdQUJNHW5NNWTbPp4od4xm5cLZlHa/aNQD1?=
 =?us-ascii?Q?E/N+hfhUV5fN0o7fpfwSRl2yGXqREU/AADQuubvvccmfKCN/jFsq2W4FpO1c?=
 =?us-ascii?Q?PCVNcp5L/Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb225345-509b-401b-5424-08dee9308b68
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:24.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBelGdICd6mf7lS5dWHNzQnWuil9FcCUfqlfSE/1B5YYLzSmmsykRvS7HgmaBDeqV0Rcge9MdDe9tssiLqhoGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/chemical/ccs811.c      | 4 +---
 drivers/iio/chemical/ens160_core.c | 2 +-
 drivers/iio/chemical/scd30_core.c  | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index ce7187ccd706..d126ee12ffe5 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -484,10 +484,8 @@ static int ccs811_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"ccs811_irq", indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "irq request error %d\n", -ret);
+		if (ret)
 			goto err_poweroff;
-		}
 
 		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
 							 "%s-dev%d",
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index bbc96c4c6283..7c1ffda38b99 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -320,7 +320,7 @@ static int ens160_setup_trigger(struct iio_dev *indio_dev, int irq)
 			       IRQF_NO_THREAD, indio_dev->name,
 			       indio_dev->trig);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request irq\n");
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index f85cdd8bd84f..770571c21521 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 					IRQF_NO_AUTOEN,
 					indio_dev->name, indio_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request irq\n");
+		return ret;
 
 	return 0;
 }
-- 
2.34.1

