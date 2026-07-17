Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013040.outbound.protection.outlook.com [40.107.44.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670B3E5A0B;
	Fri, 17 Jul 2026 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281578; cv=fail; b=FWzJAVjuMVFma+g44Rbw8x7sj6tn5NslUKqaHyztyX9KlmODcu6W03k/xHNCVGPp4qBHypeF6wqP9ycct5FZpJdKx0UaeO7STBjbNs8C3K5pquM7ZFO892TjcvjCTFpUAw2ok12MRxCSkkGrnaa34TJv5ihRwfYXXXTq4wEaoDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281578; c=relaxed/simple;
	bh=XPtc5W1jWgSbyz7mcFx60GZIbibl+Wtwb6ejhOiKv4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+rmqBauPZvmtRlaXzpf2PNCc/4i6dnGmK6fQbCb4TwpYpib1032twJIL3l3761jVDBoGJyCOJK/GYJb0VeCuYOgYchpN7MOnUmgWcz6yBpjSzN5eSlTTWy7VjekZnWNkl8En4bpK2L166jLGYwsKwv1pLFkh79+oI+I9lLmkJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ezcRygaI; arc=fail smtp.client-ip=40.107.44.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ezcRygaI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm+pCPR3B24Pqo8AIYFOwGDT0ytSsvf+mWWSVuCCG1LQsR+G7fb3eE4QeTo25606XMnxLP/Iy1yns+aoNyvOY/C4o2bKvy+0x2WyGz3sEflFwO6mVD4v79Sp2lo4cxuN0I+gUxBnWJ/Lhcf8aZKoYgf+3Y0k9MbCELCS9OtMztdYaAee77OjyEwQINBSB+cUSooZa0e6TXjvcKeG2ahvFl/oRXtDLhOeyXnL8TAsoMMnimMLwUeDezge40WyOMLbIRxMa/iJfL4mW4R0VI1TTrma8K/AQAZmKilbTU3hbCdZuqKsBW+ooD3nS6h6OZlPqTaoSJ/u4G+8HlTsa1pNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vXlkcyq1y9h86G76EhnINr+NSrHOCkYJ7AEse+dL4Q=;
 b=A9nFBYf3fIA8bOkoH3QFHsUyLxPOOYM4PZmb6mbDy0dZAbm3KqmXzy8HDeQmv3R6/zG2dkMxSYKzcXw6DHMfv0CDsqG89lhik5UWP5kBwW7XupeyJmdpZMAeUW/yGxSy3eUQNdfmQo8IZojaHWFDd693O4uPIJ/pUfwNKDMrGVt/NFQLtMdzkeK0L+M7C4/BRD8ZfCtuRVYIHO46yuRMnZZLWXxFmXGfPlT7CARlKyUSIP9e3zhu7Clk8IKzmfeP3Qom9xyxsz7bWbp48xh72eUFK1ruQIj4eLuasLOsFK7dzs6uhs2bdYhlgV30SdS0kwFFxchkypFl/66pPN4GdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vXlkcyq1y9h86G76EhnINr+NSrHOCkYJ7AEse+dL4Q=;
 b=ezcRygaIswNUxedIx2W9OhKo0cEkpG39nV85N8KPTeW4MzewKNpoDO2K3NE6bqasEX3kXp0f6KOOuTtq1NgEGSg9klHEM+1xvP3Z/Tk3h+jYHR18rHj+dF8QxzcS5/Bg6tuVP9Ra1NIw+tMseAjy4B5hnb/PFwPTYxqH1sm82i9t5pXcrHWxDEVw9g3fP4aszfMi3/080OzObgcdyavNUKpB1QDIYo6fVYoMa/XTc76arrussJG5ZMjVPFIorTXjXtxlGXfKLls9AI2Oys07vro/PTDjES/z9icq24arqgTIqvm/qUbwEq1g2J4iLDvp+PTR0I6gnf6WSs8rMi6JAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:11 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:11 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:ANALOG DEVICES INC AD74413R DRIVER),
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 02/13] iio: addac: Remove redundant dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:25 +0800
Message-Id: <20260717094408.509583-3-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f25ca93-e77d-49d2-a5e5-08dee3e83bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	MQIURmOv0HNByEp4YIO+hnMg5b5bLZRQOVGSmhp6p6KNnIB6thuvep9kCb0oXl/uIgkyrYfw/A13OGQ37q/bA71bksFlPjUHUl4pF1SEWoLzNzhnNfGSZ4DVDTRzDPGfMvW5s2U3US5Gv1wHB0Kx2hgBHVjsazCStrZow6KS7h9c+mHWyAlVHyyLc3XH/eLGuTOaHzjB4wJf7w+7y372wJDVkFOczC2Hk9f0qWr071hd2FSlTUExbxj0519nmyYplupOkHtu3XAPVV34oG7+3VqKaqbs14OrSzdZFi2vGZJKZOrmA1UlWpjvXFiu+GuPmoDuOFQVNpnH9z0RebXsOQcHazloPYO6E06kVWmerZ8Mx0U1wajnMneEyT5tkGt9LWxgFeOzbLD4FXKVUA3+luQrF41CNJZG6SHV6lnrdpT94/y+x035OPcD3Ac0oYcP7c/jOHDkdqE5kWaoxuijTWfXed9X8U6wGyJYJazNoR0v2oPBnVE+CF3JDwkblYBoaTBk7YHtGhLJ5BGbicxPaJXSA0xYT3+3aEpltwUDEaeX0yZB7NoH86nsfCdbEUKEvpt6LicAnBRvQ+Yci7Lt6Wx54uYugFC1YdE7VeS5u34bFkIYLqVbFXoeagmNI05m+LxboUIDNTf+7EL86ATwr2uFZCPD5iC6K5DK6i5DnhCWHZdbwGAoFCiaPjG3lDxGFvHqcZjafnerXmRL/UxEUH6KA7phdL81jXreW9K5oHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SiinDXNfQSgS2CHJlG2dkWw5q90KbPePLrhE4J+s4gh0h07Ot+KV1uGFHNzl?=
 =?us-ascii?Q?S/KbpGAer/22LdXsPS0PBLz6PX446BsYWFwiCwkkwuKYez6XVn8cwlghXkGC?=
 =?us-ascii?Q?npG72qjsiAzWkk8xUMe89xYeD2q5nAYXr3MfHxn04YFSxoU4Dgpd1cyYWwnn?=
 =?us-ascii?Q?yMCavycbcWMOJ8GDYD/Fa6ZBUZsz2StyJgMlnohPR0qx5c9mSBLuomlDgyPL?=
 =?us-ascii?Q?FBcPMlufB3KWmNC2d45mAanvz9P93WeKSEnnsnmLfgd7elv7CrUtxouzwGX/?=
 =?us-ascii?Q?8ug2Z9CIXujPZuOl2K/LIpwl+YAzJNimTwLz2ekfuS0MbkzPMy5c84zxtIPv?=
 =?us-ascii?Q?J+EAFuD74vNoWU1uzjjRL4T2EAgfudfaSxRV3nsjXPHpsgBJau29iYLBU7X9?=
 =?us-ascii?Q?1YHGXfFT9AhNqQd48LOX5hefPZPGAYX7+sgj/tmjfIySmeA2NUWG8yGaP9m7?=
 =?us-ascii?Q?YyioMRLWhVVvU68NJq0lQgL8JdD8k+g8ulFmJR/3qXHPe24dL1CuN8cmq224?=
 =?us-ascii?Q?VSW6Re2EifpLivTrgVcPW0YR/ilUQBHoJ2VZ/NLiqm+gAu5kpZrZmvJVZBe4?=
 =?us-ascii?Q?UPuCU5+VotIZUYC712L94wxjjKR2n/3on4IABXIloxVaElSthHilkgcEkHpo?=
 =?us-ascii?Q?Q9noumkqA9wyt6xAHhEaDbd7L5VG1Uu4PKYbSNSIEjetaXgTBVai9iZaaUK8?=
 =?us-ascii?Q?PN+mSUteSTJ4LnLBSfyYcnj4/tlCg973oWz0XojxL1NRuk+Gd/JNe0cZnv0T?=
 =?us-ascii?Q?zpwhBXRNafA2ar+TxagSZUstwQk93KA2XQjD+llyn7DRXYip9Ez9euCETs7Q?=
 =?us-ascii?Q?WpubhJkYxpA5xiloimUF0GciChBeSxHxK6Mv13uFUH34GSaPWku+VwHH+Jwx?=
 =?us-ascii?Q?cf0kVoBDAdFa4v/Lv693bs2I0Sepsrs8Nrn/zdXBYviJcycKeahouaPewGfg?=
 =?us-ascii?Q?YydY+fII6hd4vIcO9ywoOHCMChl49VsxftezC5Hew2IbByEVh07NltIsstGJ?=
 =?us-ascii?Q?P0dz/XahLEFNuI4ZcEdxw0k1KIzONzrpyzN2JlxZ0OrcQZPEs6OvQdHyEW6o?=
 =?us-ascii?Q?16iBLjRFAZ3TKdQ/ymQhufUfuosk2RK6W88UlyIbnygg/vYFlh3tr9i4uhG+?=
 =?us-ascii?Q?ErqgDyFvTb6R0Ear0rqZe68HwaechnOrTHy4qTwyqK67zCpHfuXvwlHU/fVM?=
 =?us-ascii?Q?9CgQaB5ZBYpUNOuBwiIC1tpp7Qz9AF4R2R3BWT+ykpmjuj3+HEtnQ9AmFfh+?=
 =?us-ascii?Q?EICwa4RDIs4hgOpdF5/8FY8v8ZuHFoKDH9+SThTsN4WFNNWsUJz3zZOfAgHS?=
 =?us-ascii?Q?7UHyjzArINJvD7N/m1jRGQy7yM24wcujbGIoNMj6ZPLhQ/cKsL4kAEhLGJkb?=
 =?us-ascii?Q?Pbdi9dM86nF0zFzHzmJzAS1zuSOrg4APxgxYEkySVop6An3jh1tD2vGM7Ys8?=
 =?us-ascii?Q?m7q/KutVhF6O6FLcoz0s+CKuOeLaUTLVpIXzx/Gp8/ueOsqgtflzgMZZA/C0?=
 =?us-ascii?Q?bhye2bOXPqqj4aC5+Rf8TLE3+CQYmhgqUoMzraC7Wc42UB3tHj49G/Q5t2fL?=
 =?us-ascii?Q?9iLRnGjSj2bEDrxWf1uKk0a4uzf0uNd0rMJ24vWU3prnzwzjSPYwXFQ+O+yt?=
 =?us-ascii?Q?0U7o5HM2/ZLVCvlvytdMbTuKrxAIZDHFmkJGP/z+GBTRpBfHtG1j3TtruZWx?=
 =?us-ascii?Q?8nv1bW0yWmWC05FA2+u574m7ihKKl5LLTxjuJy4aE2EMj4AEAl6sqUQgt0YY?=
 =?us-ascii?Q?3iRKyDXeYQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f25ca93-e77d-49d2-a5e5-08dee3e83bd0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:11.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrriNAjFhkmNGzpbXMMx0X+WBvpMxAqfJCeJGPDJ1Si6L40829LuEOxJvOwq23PIhweKX8IePKkQ5HbaYqud6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 43bd2079cf6d..2e5a58e48a89 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1457,7 +1457,7 @@ static int ad74413r_probe(struct spi_device *spi)
 	ret = devm_request_irq(st->dev, spi->irq, ad74413r_adc_data_interrupt,
 			       0, st->chip_info->name, indio_dev);
 	if (ret)
-		return dev_err_probe(st->dev, ret, "Failed to request irq\n");
+		return ret;
 
 	ret = devm_iio_triggered_buffer_setup(st->dev, indio_dev,
 					      &iio_pollfunc_store_time,
-- 
2.34.1

