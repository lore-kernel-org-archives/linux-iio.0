Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013006.outbound.protection.outlook.com [40.107.44.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BE36F8EF;
	Fri, 24 Jul 2026 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862395; cv=fail; b=OW924pR5SVZrs48PEbmIvCW529Nf0yxHnCGmqcwdPY4xphcBZ6K/VVdEXCMfMSKWnf+sPwBR1NK8LzcL2scwEncaU+wKNTkLx0zPPFkw7JspiPzOoink0vdFZzH+5Xc2xRnpNGzfiAHEmCdxW+OL+92aX97KF6QfuCw0DiB1dOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862395; c=relaxed/simple;
	bh=AEaeekpjI4tCF9z58sIQShZPsa3VLLFMdYHvwt3Xhn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnsUFUf+OcU43M4+Cr/WlznV4P2oK5mIF80eIGGO9mN7rrACMIMw7WIF2bzZFX15gc+VRi/9UYLJrX4Uscj2QRx6aYCGdw4cR/hRlfIekOIdYc+iKn4akYjJJFqLm9DdWetjG+bInIDCSZC+s1VwLeoULVYjZ1te7tZsjhMkc64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QtvS6Ok0; arc=fail smtp.client-ip=40.107.44.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QtvS6Ok0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq8/E2sTejycd0h1aPm7m0kIpop8wnZtbRAk5CmY0Z2lkibav4+T5jGGQ8Nsd/TmXp/oFg0TnAz1jkGJfEAuWmXz/CZTz0E5f545i15NDoNB884Qg3/38l8DlVEiUaMgnK8D1lwRNxb94d8pqlMSjlM0DxcOw3cATH3bI3LEZGKBAo0N7/rjxPiW4aZa4QN198+zrYZxa7o6pJA9jpmmc76+dc6/oilA3GNZ8QzV/o+xhh/P45wi4GU8LhdaZeD8O37zBWLq/uf/Cnl9v7TfKNKsipF+t1qdrpscaDFqicEGWD60rfgtQMUp/0Xum9BbwlFeVeofteqLiar1tdBJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7upm5RaQ+XK+AcCS8EwN+dUvPnKEruB6DeFHa6Tsahk=;
 b=ckx/3PFNnsk4tx4wNx2pA2MB/oPi07q2Y/ZC1WYgQMq1pkRsgtc3wJOsm1VUDqZ9907V5XXXCh3SYbfxiTcGA9P5JXSMhGsfsSq29sIRHs3QTa0ZVuM2QM5EOZjpIKOiYhnFPOYW+mRu2NIJNJJguNEbGBOkh8OG6t03k9VNU+rgBPvDyDq8M+zfcEq/RlXI5hc1EiazwhAb3v5T5of6jKtluXv2uFHoTI2b/Bl9LKJpnXT+zHPNV8ijv4bievtKEcFbdGV3h4UHp+XYx8fdiNix9LUh65Is2qkuBM+gXJ7+va1i2xNoXPAI1OGsZCmhCy7tuLIZgo0tXXrAe1SiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7upm5RaQ+XK+AcCS8EwN+dUvPnKEruB6DeFHa6Tsahk=;
 b=QtvS6Ok07HgZu4f4HQjBIVV/t/z+fWMHV+XcwgAJqhHBqv3dH2wI/1HYpH5DLhjM5qqqiJfH7IPvW0KCzAtTVzGCm4J+2MZzFtjWS69BlBgYQOU/odDvc0EdZs3ztubfi/cQ6bowBhRwERjy5XZ3/yzdv1vGdwONd/qdFck0AsMPEpE7IeS3rbVetA/JlpBiSJyNG98Wx/4ybhIGDJfa4U6zKCGdwGQt6Gf1LlgaURE674cCqAaR7y1DYud/yjsIeklezMfzTwlzDLb3yaXY4SYexybITcnk0WknjiTbYgl0jvTcdhdq98DnpZDUlFEDfEi/P3o5vAgM9JH+RaiMcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:06:31 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:31 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Nishant Malpani <nish.malpani25@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:ANALOG DEVICES INC ADXRS290 DRIVER),
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 05/13] iio: gyro: adxrs290: Remove redundant dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:40 +0800
Message-Id: <20260724030524.607185-6-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d09f28c7-28f3-4141-a536-08dee9308fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	EJZIhJNM72Kgx3HdoGUkWrfmHVN3/SDfuw0iJuxRdU3u5mz+Y0BhsDjmjxSyV9EqvQcHJ54yHQ/J7l5ewgunyynSHWsJN5poONh00Qo6KU6UE9sZ/dbbezSOyoJhsS01GMxzWZ0bNA0zbAn8hioy3UauX5aoSAB0mmgdeuc3hHtjX+v7YNuHdKBK64hWV5eDw8CN1K6313dgl+eJwry5ayOa0rvcOUmib0OnLbxsfP5Ny34SwdQsx7sWaV0XWxGJvalQNi9yhexLR3oFK1ZQzV3hIZZLcIZ6ql2jcYiPYZKaUrYmWgoJUbUEXYfv8u74xN08aBWzo6y0IA6CHXytLWuWJQvU+D3biu1dbFK1m4sllChQhaf+rqGRw6eILVDwEbTcaNwgZ4wZOjJPTxG1cCGaLWjyBsTgsB4hJlCMOq3mtS+mISseQteJgfKpEyicQY5dSfOSL4rEUT+zStGkxstlLIfpGPQtMmNclo1p8g7L0pBk1l+xsaCL3nfME6SuIsWX9RWq2ZwydPUfSPryk3BGN10oe/gPYIPNCqJf0/N9K/JkWHZV/kzhd+v7NlGWub69t9MyiRyyIwF9Iq74cc4c/hZtiHVMv2num8+I06ptm6g15oG0zGh/6UgOlO5lrsQUqzRMyLHV79VmT6HmNkqEpGoN/I+jRjKLIND92EyofFxnTHEeE8U9/s5FVsBX6fQJsxmFPtArdkYjjlVjyOWj4sg5/6xiM3izBfvIWZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ij8qzUh4c01TGcpkMb3wwIzRXjklahIzV5mtRPCZXqmO8a3z+kWTQfhsZqyr?=
 =?us-ascii?Q?9qxWB/FWC/Ceg+8sRFW+GkduBSiozW+XzdBb96nQxMriRkCQe0q1jEvs9FGT?=
 =?us-ascii?Q?K+SzZvg13k7HYq4/eXcvW9t45JmBYtAthvqS+KS9/pNfYk7yDRDG17DL9Qtg?=
 =?us-ascii?Q?Wi/qivlLoWYErNXNAvfTJ4fnYdKDiakW+rUc+p7PmEQiSagaf/LEt3BunftU?=
 =?us-ascii?Q?VJlGVdWYyp1PDZFZ+h+/N62dfeW/qF7OLi0VI1sI1asKIIUVMTrh6Yt1wEHx?=
 =?us-ascii?Q?4S60cT1byvalqUdWD9mCKy3lcENI2gR1wby5EEh4hjqx49mUBZsWV4YTcWwg?=
 =?us-ascii?Q?0wX8/mBes/RL4cm7QsLiCvSBXUf1pCPGwJQJe7WAZPqU36ZinLNm9R2Mvaxz?=
 =?us-ascii?Q?0gf1l5UVGtxypA8Gw68kSG3vO+qsWJkazbWICAkAox1uJZv24nl6AOthET0Y?=
 =?us-ascii?Q?DGIzsPvUgttsGQwdzE/bRgdK3h2RT/UrmgIZgEB1hLdyF18VobcQyVBepzeK?=
 =?us-ascii?Q?eVaxVtUGVTsOOm/qaaqv1+bPVm+eSs2BeF+wtPI1ad52lC5JtWwThuXGz7tU?=
 =?us-ascii?Q?YV7FoTTe7cZ2VwYsawV+Rv61iU4hS0UoJaEA5wKT5WmMZlwRmCCJych3B9K7?=
 =?us-ascii?Q?nw5wXWDcn0S0YoOFygn86RncmgbrrIBsjt8tzxBZVvmDkMGI2sanWuPIpmUv?=
 =?us-ascii?Q?igEV7ewBdQQ9EOAVZP5FHmPBNaexQgNtiV67Gpc1PmsU7mYL7IJtCQ+hH4Ro?=
 =?us-ascii?Q?OKQKpXn02pvqbIvTudCyey4U9XJyBgcTGyqk1uIVc7JAOt49/ODTSPrXeGg6?=
 =?us-ascii?Q?U4/2lz1VBXynPmVaKAx5sThI8V4evcQ+3L93i4Pak/Y0D9jx0S1BYhzeqkBK?=
 =?us-ascii?Q?1K1WYnmc9P5d4iWg2vqjPPAW0aZt3lO+6O6xNC9+ieu0LO4GK2db0H5NFrgA?=
 =?us-ascii?Q?KB13fFjPygxtkk4e9WSHTxNcGBeMZstY5/BTCv0lR29BkjeKejKp0SkrbKqP?=
 =?us-ascii?Q?xF3EiwvGTbV2cBcj5BPm0Zbg+95YQD3x6+G8Zo09aLZ8SOyuCfo2LRMMDA0Y?=
 =?us-ascii?Q?+np/bi4HbOj+fQgPoqzZF9YNu2hezkO0xAOobCyfZj/BHiRpfq6E97DKA33x?=
 =?us-ascii?Q?DgPrfhAQP6DkFxNoA3iBdXT9p5TCNnZc8BF5bWAwlsD84JFlLGuLLcTS2E7c?=
 =?us-ascii?Q?AK18C7NhCAQ+oBoUMJi7M0SRdPZWv5ECtfnF7itIBjZYY3eDP8abWax6ozfm?=
 =?us-ascii?Q?cZS+QBX71hqiYf3F1ZVhVwvKf/o+XN7pWwgNM/Wp88BR2gKaNmdP4etIBWg4?=
 =?us-ascii?Q?2G6YQ904V69WSwlRbjnwAU9RRvIhqv5WHCZWuDo1GkeR036WvHrgmqdKsN3F?=
 =?us-ascii?Q?V3mJ1xhJybZRJ5Nu9OpVvx20kUPoPZjhedvrwJ6NqY56hEM3v7jONB7Q50Rb?=
 =?us-ascii?Q?bbJka7j5D/NfQ6lLnUYglLCv2BrggQMfXdjSt1DMiw4VDwHb4K2UE26W5qzJ?=
 =?us-ascii?Q?pxKpuq0oY6e5ZjplGSpLS76ZmJvlj6Z7qlcWbrdr3sJU4SK+gx2Hivt731Wj?=
 =?us-ascii?Q?iTy7I6KKAdLWLWPtlhEBAOPo2CJ38AJP2omYAPeYjX3g2bOZ5S/NaL/7sx5P?=
 =?us-ascii?Q?b+cYRdxA9G1viM4fnFOJEVTBQGzE4txRi3WZ9A8/jzenpdqd/ZyplMiZrHxj?=
 =?us-ascii?Q?zz7aEAumYlttP9dUMaTnqd85rzq+eZDQI7HW57MUrNWjkJOjzK0Rcs+299K8?=
 =?us-ascii?Q?78Z03YRwOg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09f28c7-28f3-4141-a536-08dee9308fc0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:31.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPRps5bIhu/HAnjdM5ZPHk0mDRcy0Gvy0BCdyY5YRDa8zZn7pz4RmhCtuB66V03XzzpRcg7XTYJlP0e9TIdrMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on failure.
Remove the now-redundant driver-specific dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/gyro/adxrs290.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 35928383d4f2..563de2724396 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -585,9 +585,8 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
 	ret = devm_request_irq(&st->spi->dev, st->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
 			       IRQF_NO_THREAD, "adxrs290_irq", st->dready_trig);
-	if (ret < 0)
-		return dev_err_probe(&st->spi->dev, ret,
-				     "request irq %d failed\n", st->spi->irq);
+	if (ret)
+		return ret;
 
 	ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
 	if (ret) {
-- 
2.34.1

