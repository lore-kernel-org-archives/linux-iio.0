Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012034.outbound.protection.outlook.com [52.101.126.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009913B7B93;
	Mon, 20 Jul 2026 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555064; cv=fail; b=WknFwJvTWbr1qJ7D5a8ciXAkLJCgFC0+sdfZlyNxtsa/G37s8YdwV7kBNqJXJ91WsxeMwi6aOMqfttnjLVqy2PFm+ZlHFBHdE5qTqma79QSh6JUr66LyeTLas2Y5fd5RT8voZTW4x0tfktjbT0hCZZbRBrZTSQ/CsYXxFOgA8Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555064; c=relaxed/simple;
	bh=mN5WaPrWIhXtzNRPgRgn4ayc834UEKH/gjCdla10r10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kybjXjdaPl5iiNKFjIh4ZTFVfeIuhQuUwd1K1Jv5g9YPTNselpJb0aaXWo4BKXqPALDYhdlO6Oh744h4Lc81Zvm0fXzI9f/zbEhMuIrzkxJRRVMT7lrbD7pBiopLWYifHQYM6fX4t9K9b3P662H5Gdo2nynxpOPiIdyKzq0zKik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RBfNvjtK; arc=fail smtp.client-ip=52.101.126.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RBfNvjtK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvd3oemfLOlPrqLMV+LudH1AfgxhQ4H/kpQ5YXWe+FFWRvDe3Ke6iPyTGsMYF1ri7EKNyXoddO5Jzp40AHbV7anxbSL67RgwLm/yk1D12hnI+I2BkzTYjYQ1SX8rjgAV8K3fp5L2coSAgjdHx8lm+rPNochhe6bn8BOWrth7f0d2Hfnj9b6k8ABNAKa23bjbQbFNUKqH9JaT9k6FI+AxBzputvhdKHPxq5AljrNA69ta/dy3aIXQ18ALvUTjtzPAbCOeS5a4hyf6JBVVMYlRPjytGYZT+pOw7mjkET95arBo8h/5OHgyVGcg05plSMRdtNy/h1uz1TOeZTmOxUniEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elli8YEqPZeVfoSa/xCtCH2RT4vX2YdLKCein1cK3uA=;
 b=tYUXc3EF4NNZdB4LJs+qJYt4hJ7JEAABia7GHFxDTCiud5MnSuSPNx4g6oNN6tU+jc0vXSp+tefb5b52lq2VRwzABxq+kA5QQ1iOEh5rVx3+0tOs/rFc99vu8x4PlXwJ68M5XzTTleYhM57PjgSn9AfUYK+4GYCzx3lwpOyLGuhWHhq79RG7hlcLpGRbf2nySbk2TRLqQOpdvCtFMfew7A+KYFm7KPzr8+veHA5jtQJ9ZBk1cV0Wr0a65QApQdimVxecmIhWa1AD2L6g0o4cflF7sfM6EBysjvkD44SJIfJ899f+ZjBMgxBsRnqAwHgXbu+dbdoPD1SpZ2ggi7gPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elli8YEqPZeVfoSa/xCtCH2RT4vX2YdLKCein1cK3uA=;
 b=RBfNvjtKg2dRuj4Mw+CQxHCFYVfXuyZIYgeaJcjEKVfm8OMF/sDzlcQy3dculvlYF4A3r4uZTItrjs/PuY36FPU91M6re6naI0XOGcSABxtxQA5UyYoGOzP+Py7crIdyOYl+PkO7FHnZO4+sx4RfkD5GjphogxBNZXbR5hcn51uIUUs+hN3AUFrf2vLWNAwwiDryyByGWQWPbAe+zqKPmlF4Qr6w7xyEi/dl1T2TeXDK8B9vSrnGfA7Q+kvX87WpyimazqrBfS1NtL4/MdEgCajmfXllblxDCOWyBVO+AYuOMZ6jKnBKLGlIDGwlWbeNfQz/YCcAhFJMfPIRVKfA6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY0PR06MB5457.apcprd06.prod.outlook.com (2603:1096:400:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:44:00 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:44:00 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-iio@vger.kernel.org (open list:STAGING - INDUSTRIAL IO),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 4/7] staging: iio: adt7316: Remove redundant dev_err()
Date: Mon, 20 Jul 2026 21:43:10 +0800
Message-Id: <20260720134324.239391-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720134324.239391-1-panchuang@vivo.com>
References: <20260720134324.239391-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY0PR06MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f96fc4-0b6e-46b2-4dd4-08dee664f40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|52116014|7416014|376014|6133799003|10067099003|56012099006|11063799006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wY/nZEVKNR4MXDnxuRir2WpnzoCUgrgficRC152tRDRoiftwXSZ0/r0Cj9fo6iABCEMFeM3KsupO8tnizan85Vj7+8QbUWtzeWYSkhQEDjBXAqB6d+pAcWNF2YnUCfP2f/DDxBWpk/lyfKlf+9PZLOT6jGDByaeRvePdGlX7JlK5WjyM4ZFmoMWTmIjGwFlioRKLS5xb1rif0WMgmoWOmGW8vAodSNuv68VMv3RUHVTS5n2B1S8TcI0p8iOnYCatY3v6K73LLa5DP2n53MB87ztUV66okTme6CL42ynu02dApwRzfFb3YXSld7rZutcw3/dzWNBIXh7DwbkcTxkThV8jSI6KW2JKfXI/9RKF7BnjQY6VtkIvzKCR/Y3MCgVTMR1CH7GL6SDbeSeoII9BIjk4uARvunur0UcozAa5XcusKjnCEjZPfYb3LgwyOh0/hkpU0eF7hQBpgmrabfW6PA6v9RYR/MYtsmgd2Zrvbx0muO+eswW3tJLshIbTH/rdyByO0FiNKIzbTqnDumcJgZ4zeeWfqY9VpGYALHM1p5hxQbWJBYCZBRioL32CjANaA9QJZeL6n2o4P39VaoUXDNtraPymnIhQ7jmZeZ9CjsSZYFJB2zVuPIsGoFV0hN7P03Y+KyQqvq4MrIWnjueU+VI1EUJCeVb1bReGx1aGctR7o2Gfa/nKVEGgDM3LUC1oM8qhVplqfRz3aMMPPidXK1fgltZMWIJwTJoslI9yLiABCImKFVDCjnIerbFXETUC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(52116014)(7416014)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(921020)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9RA8sqPiMm4YLugWvee4YyeMXi3LLw0enjtp5eygPhQ+CH3pJbJnUajabkw?=
 =?us-ascii?Q?axawb/9wb3UhVfMRrnqybSbgGZoYSd3Tx61BQodBiwCg8z52I6n+OIa2CWky?=
 =?us-ascii?Q?5obQsFDkdwl6WJ/hcp7NBddwK9Y4oQ96d8YURX0w/P6A5zcYX6W9zJA45rMM?=
 =?us-ascii?Q?JCGvxsczC8qA4bm9C2gLjJ8oIVy+Lo86ycuer6YeLhgKW/SSyMmIp4/kRt/S?=
 =?us-ascii?Q?NhKkSAMX7toPYpbeLQ4cvIGRm/Kz4ljPZoI1dzH20mUSy5zb+nNPbgxImQIY?=
 =?us-ascii?Q?GzOBaBXaDwYaMdewDKRCn83MS95XbtmtmbEppS+9TuF0dzvK66Bxzsd8pXPJ?=
 =?us-ascii?Q?E5i/V3MsmE5t3X5x6mDqUA8rs6a0Uv2RTGICi9ESc2uGolwFsiIqM4vkMhOz?=
 =?us-ascii?Q?8pLous428eHX7l5CPv6v1fa/KjKtDfQGyKkcC/XY4ICTrgjg3y8QtVcig1BS?=
 =?us-ascii?Q?tfwpFtDvPpCuUXV2ZxLisuuRvPJNbqzqHKVUxI4qXOgIoxAYFxv4SAG0dU9p?=
 =?us-ascii?Q?8cBB+BcLQ8T7YTvOBg+1qsDNovYEcbk8l5s6TeiAUfFLJSqeu8+aWh14gNnD?=
 =?us-ascii?Q?KCm8enTlkpKPdexFHY0kBONSdFEEHJK5RSJHX7pCGj8sXWszjQ2jMGSgoM9I?=
 =?us-ascii?Q?FkhBNNi3ltyRRWolsHeiR3rmKUg6bD/fFRrz3qY/vznz/wHXtL5Z85Es7E2H?=
 =?us-ascii?Q?yBqQEajgJ5Um2Qzai29FTHUbVUap4xBJ2jZ7JMH8jLk1AfP2k1ezWiV2dR2V?=
 =?us-ascii?Q?377JMH7S64TjD+iguDHZ5qhGAqfQwKPZ1yPtAUbVKUbv9QKT1zp86ppxoDOH?=
 =?us-ascii?Q?XtQXRpqx/eGO7yHNhF/TJZ9sBa7qVs2Z9UQ6J5+WyLIH35wKWBg15YYwYho4?=
 =?us-ascii?Q?IW47+s7oWl9AUzPKcKf5PtMF26BvEw/Imy5h+ZUCBWR8MvKpXWYpGuhoKCrl?=
 =?us-ascii?Q?Qw2eF3zkxavDQI1LFuFOFGTkKnbzYelfXCKVr4bHUVnjtp7Dlv1I7msymhm9?=
 =?us-ascii?Q?VKujXFNxWCkVTDRScAqqzJxp4RZNo43KQMeNwq4zFZlbgSzXWJuo7YIVahiI?=
 =?us-ascii?Q?2ICt5jm5atQuDP7gEkgqbdnLI5abl7ulsbPRKbv17EmdyJkyHNoctOMbsVSF?=
 =?us-ascii?Q?piMLCWg+NAf2Xzxg/0PgcYtr2m80Gg5yB139JjTpMZEfhm/FGCENyILVnJJg?=
 =?us-ascii?Q?+FX4uuIxUcOh90YGm1R7Jo6YgDRQt2xUgmRPfeenDqkmxeZyuQrBeG9v5NQ6?=
 =?us-ascii?Q?Xtoj+Z46w4rwyY0uuTX+jGXnoamYUO1FlEn9v/MthjNRXFbIQ8EcrIjqPVCU?=
 =?us-ascii?Q?/xG9ejxMG1GE7qSAIl8NMb7yJUvt+Ecdp4wf5qIk/ecmYgyof8kzd7hTS7hl?=
 =?us-ascii?Q?d6CrtzPzLR+12L8ANsRLxksNTw8eVMGwMCy7JqurgLVNEcVTG1cwEZ4MSDR4?=
 =?us-ascii?Q?ac3aaYJJJIi1g80SGvSKdTNV2h6tmdDcXbTmjR+jKdS1hCQ5fsxPRpwjMqOi?=
 =?us-ascii?Q?F8b5U2uErRNHdjb+s4x/Gx3Mh2SLfJNH/g/4SscUpOU9Hg8RjB2JjgCjloM8?=
 =?us-ascii?Q?xrTV/xAnNi+R/N2tJHFV86VKu2fKxRSB6VosuGIw4xA4v7gwUvTUfn0HDWs0?=
 =?us-ascii?Q?K4nnOWUk5awUPL466a1mLUhiTxlHIJHfN41LF0Thy/BwvEHnccahWqtb/uZi?=
 =?us-ascii?Q?ZmyeIjXAOp7Dq0EKImlo2MAPab0Lg4A7cN8O9ERL9KQTwYHwojKawZDACDda?=
 =?us-ascii?Q?k7OTAmNQVg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f96fc4-0b6e-46b2-4dd4-08dee664f40e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:44:00.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra9bCTn5t5LLt0aVV6RPPEW9yWkRXDv9MEnOVGQQF2thWalKFbuDecJylCAavAI4Pvvu2g8LIBCVred+HPs7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5457

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages
on failure. Remove the now-redundant driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/staging/iio/addac/adt7316.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 59fb3bd26bc1..20f6052cc7fb 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1814,11 +1814,8 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
 					NULL, adt7316_event_handler,
 					irq_type | IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
-	if (ret) {
-		dev_err(&indio_dev->dev, "failed to request irq %d\n",
-			chip->bus.irq);
+	if (ret)
 		return ret;
-	}
 
 	if (irq_type & IRQF_TRIGGER_HIGH)
 		chip->config1 |= ADT7316_INT_POLARITY;
-- 
2.34.1

