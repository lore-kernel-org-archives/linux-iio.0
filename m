Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012046.outbound.protection.outlook.com [52.101.126.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E123E63A8;
	Fri, 17 Jul 2026 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281600; cv=fail; b=MXsQXU0+sKAWGo2jhVrSKbCsumWKkxmIDUvYTBCIWwb/VbQRxB5pXYN+sxxLoPa8d/3pqAOel+ZIX1grmmTHQgcdAb7dhTVBiS20Wt1LGhPL6R6nVpTf0VD9GT+B6qefLfAnai07YzXez/++pylHDFU9jJf/F5QX718qsdptxG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281600; c=relaxed/simple;
	bh=M6azsEloQlMVpA/CVc+PdYCvTdi10wwRIIpURd5MYr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8xL2IFIB1x3AhzNwvmny5ueN3CCeYJmEEmG7hmCWTxD0Ssf4VI/ASVCjZEf4w+csACGGwJEgvk/Ss4zKEZK0mXCuek8VieAv+w/RZBv3baQElNZNx5U7TlQ4T71U7CG6RXeZrx76W4v/umCGkk/wU5JM45Cc7nXFTX/y0AFOJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iiQMfnxC; arc=fail smtp.client-ip=52.101.126.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iiQMfnxC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY42cPJV10W+e3lrex+oL0RSbUXz9s3++G3RzWPagGghbwPdI4JSYc1S4bHaKS/juU2PUjs04r9oX30jetnDfEcXpWPcfTS07/pUSaV1uRlNar3stE/G4Dn4UYXBVvFVqRymv3WcHLzTBJ+pp3McEaJgsIBvyYcV+aQXLEBeKKLOl1lnQM/EG2qvU6UkFIjOD1w/mG8WobNEl9EEEeaRVz5FeiX1bc9ue+ZL+6Dj34QT+N+/ljM5m9BCM8U+Tv8PdNxt7eFys3cA0ScYFO3Rh90L396lVKWgvLxf5JMdmk3mBm+BwuVVCK5RvkpSvatprjgEE0y8Dzkxm6Pvrh74CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29FYeyc6iC/G+Yre50lyZgHjc/as5VwMrglKoEEvPtw=;
 b=Kb6AoOiSI39/L8B6tS4KgB7Hxjr4M+ZJ973s7Xue++5864PGWHmJcRzDK/5wM2CGZ1LgjZcgjbVbXfWbWZaWnfphn47ZicPsIlVUS0g+LfUjDjj0Sz2kFd/XbZ8/APZh8BYMqcEb33u6/Y2IqKFXscJAjenfh2pCIaQ1ZxJ4Ieek4FC2+vJ8YenWU4hISYh2orZ6hIV3yoyqju8ZVrIaFhKSaLq7M7DlOSCSP9YqdtB3Wnz8coDPn25mMJaNyyZnQEqQpK5o4XW3CHTNtTOqwYZJUVJYKs82qT9RIUvJS2RFJOC+HnM5tOIGVGgk+SjlENYDkuzugHCsUGleUInEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29FYeyc6iC/G+Yre50lyZgHjc/as5VwMrglKoEEvPtw=;
 b=iiQMfnxC1bSoBhktWcHscr3iHXF8n5NUMjPwlTYK1ilGmiKgA5wBbUBcr07ZPNcGWh6vNUzL7aCFabJ+iPEi4EfY7o6Eqtf4viBP1YBVR73LseZyWPM2eLAmS/HDvdK3HElQ1aV14tWqcnTfv6c5tsKL0sXiB2P+gfMri5ENQnbmTyQiQ88+xmhn48uJc24p/xByn+nZTpznvypxXZJMyS1BkS0A4eLVbLFPmVJrbxvqP2nnVb118E+mrgJ8ktWjZUciXRI/d0pSoP5RxLAEonkV10zJg++ZxWME/TlUlaZwW92F3n712aK/FS4fY8XwZLY4aAoAjCUjtZOCndBIYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:35 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:35 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org (open list:BOSCH SENSORTEC BMI270 IMU IIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 08/13] iio: imu: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:31 +0800
Message-Id: <20260717094408.509583-9-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78d3ab62-3dbc-4ed3-3ca6-08dee3e84a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	grZotzIkkYPyxnNqum8xAqaa/iV/JsXJEEWKr6MuHw0k3FZV9SnYeOL0+7Sqqi7EU3l4ZDD6HNGaEKsWT9nGZYl+53YqvFbPtINhB8eGF5G2LSDNY9FRZPOe1gZgNKV4OMnPu70vxdIz6wv58DYnxPbYzgyOtGdHBVZkDRJSj36IExXsuqMVCd7bfBRIwWUrOhKhALJJ8YcFd7DIvshw4z6lVStcgR0jYeM5TDnvKXVyqHull9evIdkv0VsMm52P7JGf9DZsCYRM+fGcxN6AOnt88keQyiVdmEfzLdrxTcA7bKEHBU1OI4dNlnieUhMQxpz/lzTD3BTQJeOl2mrRBPy/gKB8+fLXsgje0qLwqhhhTjx5wSGXuLKBL85Kbuo2cPCSyY00XL1zflQ8FB5z6ayBZMHXv5gL4G+bcgZBe0qt5CmtbjXinDAO7ektMD3lfUJZxp9i8kDi4IUXIlxsUcYbLH7vcCUZbBdN8UO1fJ8Chcy5WKlELuo04xYWXTh0daNy9DXuhWpS6ZtYTkTOjrAvNMcBx+GCzdA4qC+s28bC4ASm34Qh7HCnYoR8WFzPIYdbdTs2OIWhd00bUCn6a0YmgKANoz/vexilNuzurIG+HgehRr2x6Vo7c5Xn5pmDNbOyjHo+NaQZDOeL8YLZSGmfp61iMJxIOdCazjOemYdZtCa2nioEBZ7iWWPuAect1nFlptglBbZT4+Ar8ygIbz80MVVwhB7vps/LdJdgxl8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFOFl+UVkYCsWMNEO1J3o3pbNidmPl6ZLX/IHGqAtk6MLlvyIHr5P3dAWYEg?=
 =?us-ascii?Q?EsXBJ81zaGGt58ubW/qE6DG17APCsUnQS5MGDl6yiRTh1DOypwAsFBXrTNHX?=
 =?us-ascii?Q?LBRbIRj9O1+4Sw3DRj5egp96kINdZbh6krInVY5Ch/e7oT1eFM9Asr+HmToj?=
 =?us-ascii?Q?TXLdPQBq6NvMUwmOQnkTDMl0y828Kdws/ugkxwM7Mo4hnBo9IQLXScN+lE7B?=
 =?us-ascii?Q?IPjrFdXZeKRp/PpYz3JaZTk5dnj6o43OBbZYhj2G2t5OEt5/YosEY9PiF99v?=
 =?us-ascii?Q?Wn7lGCPFxLT5r1J3AuM6O90gRQZ0UWNkFrzfWzz2SA9QiZvHZicWdZKCFh17?=
 =?us-ascii?Q?352XVAENLm3Dq0iAwX3CYgQVealmMMqheZv4Dr57Brtt/nKXCuzwadgdFS9w?=
 =?us-ascii?Q?YDFZPjaCBnV4Mpe7DW1jzn9ZDPo4XtDUz0GMYAfWal7hEAS2bKWNPMtVZUij?=
 =?us-ascii?Q?HpUFLEDV3dc/WRsvia10Tn+athwTpzmSc6Pd9fRf9HHbeshb5XxdDqcnsFHs?=
 =?us-ascii?Q?ANC47wjJNwxcAvOFP2fBAHoYAEWw9zoFq3jqNnGLsQFHjSSLsNYgUycSBzvc?=
 =?us-ascii?Q?fn7XXr0YaKNIfM29rXlF71F/RI1A/Me2psn2XQzDJ0BedpZ21r7ue3oGSm0r?=
 =?us-ascii?Q?Ao0tdsZ/351QcHY1fFaOuSEyGtqfvAoHH9zGgMrKRCAqhFlcUjPySN8bKkJZ?=
 =?us-ascii?Q?Oq27bWhtOrjQkPQDsTMoc8RoMCzxOgMVotDskLnQhwHkcubgRh/bS/0Qev18?=
 =?us-ascii?Q?6r0QbybVoNdY4Tlx5SrycNKpLLLl3USc5qduN5Z1kCofi9GXzxRKnmKhXXSO?=
 =?us-ascii?Q?+Ix8tLkEomqexWhP7wNO1sWQ3rTmpj/3ws72GkPw9WJRXNcV4jBq9gXCF8zd?=
 =?us-ascii?Q?a++Vn+rrJqLw8yB4UpEc20rYtcw6XXVtp2QvUX3LIW/OqSj8aW8mtm4KU2JR?=
 =?us-ascii?Q?Ar8jlTbpRfJf6MbIM/0Cr2n/BOJVKgSGhnudyshpZJ/e2UZ8o7pH3cd1e5rM?=
 =?us-ascii?Q?DvO6ewz6/6U298MZFfGmWmtZ78mGn5u6x4MTZtVBa+9/UYOk01mXIvNy+keg?=
 =?us-ascii?Q?Bzky6Ggb3lZgtxMFC2rNLNxwtsG92jDUjh87vvv0lWbl+kbRI46wNy3RhUzU?=
 =?us-ascii?Q?pCV6geL7qsDWPby+rK2A/NF44pRxiQPkBXB6fOzsaJT0r89czU0PYFLQJfsw?=
 =?us-ascii?Q?Cpu1Kbo31QiFI0iM6y0SMShcfeKtrbPfiD5ClghLA3uaDW0gzz8XaUw1kCSw?=
 =?us-ascii?Q?nYEH64V5X/cwLnW0LbLYW0tBqt4LkY6/+S5h5j1F6JJy8fmwRWomIpwUrjKS?=
 =?us-ascii?Q?yvbXHrkUgHAZQau9LNRfi+ARBnR+8nUqmSOlespsHzV8HzqfEwH3mCzNb4il?=
 =?us-ascii?Q?bE0x283UNOo2zqFEdC+dJTLfqE0TmPKSAJ4dbLxUCSzYWQPfS+XE+s38kXG/?=
 =?us-ascii?Q?yS5RM1l2CFX2jnozohjQqqhIdLjZ+udbLWKOzE2kUxYzBN+nEWe8lBnyWTo3?=
 =?us-ascii?Q?4zDb5niu9CGLbeQAL43HQxy1Si7hN5T7lRRNvTI6HueRrgH4WgoaFhX+FKpK?=
 =?us-ascii?Q?ZHAywtks+AYUZHKcw6d9LBxgamECIunymh79XrtwVvWNJjlNlTONurp81Rx1?=
 =?us-ascii?Q?cvAxaAYEC+CyscVki5nbwCdqk3a5fcM4BxyHBmITwUQeKkrsL4uJ4s7y6I/+?=
 =?us-ascii?Q?7Q0mvWemBvs8F72O9KG1WgOgAFpY44h+bQ6B+aBdMBP97w1rMVfHIARFUt80?=
 =?us-ascii?Q?NvFoLgK2QQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d3ab62-3dbc-4ed3-3ca6-08dee3e84a3b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:35.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3R/kmNiJHtvYE2Ze6cJdjC3wV4VdnAZT12m0ZslwSTzmP8Oq7hvQBechXcwxtmrK7t3RXumqqn8Tx5CveSK1cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c         | 2 +-
 drivers/iio/imu/bmi323/bmi323_core.c         | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 2ad230788532..fbcf6bb87acc 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -1434,7 +1434,7 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
 					bmi270_irq_thread_handler,
 					IRQF_ONESHOT, "bmi270-int", indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Failed to request IRQ\n");
+		return ret;
 
 	ret = devm_iio_trigger_register(data->dev, data->trig);
 	if (ret)
diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 72955a697a93..ebeb1b10c38c 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1946,7 +1946,7 @@ static int bmi323_trigger_probe(struct bmi323_data *data,
 					bmi323_irq_thread_handler,
 					IRQF_ONESHOT, "bmi323-int", indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Failed to request IRQ\n");
+		return ret;
 
 	ret = devm_iio_trigger_register(data->dev, data->trig);
 	if (ret)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index f4edcb73ec8c..360f1365f892 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2852,11 +2852,8 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 					st_lsm6dsx_handler_thread,
 					irq_type | IRQF_ONESHOT,
 					"lsm6dsx", hw);
-	if (err) {
-		dev_err(hw->dev, "failed to request trigger irq %d\n",
-			hw->irq);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
-- 
2.34.1

