Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23E400E01;
	Wed,  3 Jun 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472839; cv=fail; b=S9mV+jaCJK4akiNjbBtXuuP8oX5XUTX+qzZGOXpdEFoT6VFg253jZcO38tkibB2ZtGOPZrT27vFSyrLq0zZSu6d7ZIEkSm86244zmGhF/dnQNJ4KvpRdlyGEMVOYCTLgCMbRZzl82f4w/sxYHfFQzreheGzpgzRCDah7t++z7us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472839; c=relaxed/simple;
	bh=k81d7VkLhHR5ZDDBxkMEBKGX4hPt5YBjrs4/XyVlZAY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qan6wLqwhe/VS7DOC3U38BzsdTVEC0s+E7ekUrMIplNunw+blf0g8FAEuUOc32N/nt7C3JHF5wy2bMM0EfjV+tc53zxRzOXsNgLpl7fPqg7g5NqtR/TbMuh+UB/AWaGoxkFpcOjJZufBah8pMWcj8GONYA1I/3fW6qkDozmCYqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AHAl52Y/; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AHAl52Y/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDGQjl9EJwdPRrp+77BLPttErYi/QFSrMUOCJ06Oa2/onYZtcJL2V+oFGp/pm81r04PC1dJhTrpiIkyh9ZIulqBSPmSOpQDhreYmeKWTTmUHdlpQ48H88ipy2u1Njga13GtYFn9wXyFmWmE6762L2DnO4ysi6mLNy5g2TEIK3BOW1LP+r5istQJCcj29IZ9KoK3cD75SVdqP6egs3qrZtp8M2nsChrVqxhzIyQtN5u0Edtbl/LMMcMNVv61k5/pRYcM5gQ/HaASozQYU2Aiq6Kaf271xdQnNpJALvEsOhF4bq6SiOHlRP0PfWn8N1mEzZqkV7/6fOEvQi44IhgiOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k81d7VkLhHR5ZDDBxkMEBKGX4hPt5YBjrs4/XyVlZAY=;
 b=hp7vS+Su5NbKOKmCfBSFOkudC9sheQ7p5GYHEUAeNm1yg/qh0rb1EOCObzf0J2Q+qTGfTWMeprCXbWNtDqqHU/X0u/6bUQTmUYiUKhP14VDGcNpGKXWTG5ePWIhkJN6SRhVM2+SAbLk2+Z/tYDpmWzTCa0237yqPjQyE4h/imTnzwQN+eRG1MziT/YlP3ohSk/eVLfLJKwbsQTtungc4nWKCWj66ip96KTkrdP0Y3Ff8/G6aBl0S2+tTN6oNH7tIAlGMWpINPyOLKoB2FxgXHkKNWTaXMyIEaHQI6LPc2ND/79/hZEUF4U+1SR/mF//+auzzymPTgR9OIgmw6h2aFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k81d7VkLhHR5ZDDBxkMEBKGX4hPt5YBjrs4/XyVlZAY=;
 b=AHAl52Y/mvZUmpyoViwx/pryNFoNnjyaNR6KHAErIoR44OuBh2JesWJujJSISvkOJ/ksThOyEZ9LnYoxJVrMlOqs1N3ddrobMFllKY9XAirWrwwxbyVlSJR2jkngz8BEftN/VTczHiKfneUB4i2l5mskDpW/VxIFwkFlOjWYT0o=
Received: from DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) by VI1PR02MB6462.eurprd02.prod.outlook.com
 (2603:10a6:800:17d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 07:47:07 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::8f) by DUZPR01CA0192.outlook.office365.com
 (2603:10a6:10:4b6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 07:47:06 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 3 Jun
 2026 09:47:06 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Miao Li <limiao870622@163.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<bigeasy@linutronix.de>, <marcus.folkesson@gmail.com>,
	<dixitparmar19@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <limiao@kylinos.cn>
Subject: Re: [PATCH] iio: accel: stk8ba50: Update includes to match IWYU
In-Reply-To: <ah_BL85vs88ynvQ2@ashevche-desk.local> (Andy Shevchenko's message
	of "Wed, 3 Jun 2026 08:52:47 +0300")
References: <20260603015033.187735-1-limiao870622@163.com>
	<ah_BL85vs88ynvQ2@ashevche-desk.local>
User-Agent: a.out
Date: Wed, 3 Jun 2026 09:47:06 +0200
Message-ID: <pnda4tc12x1.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|VI1PR02MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 052b4536-c23f-4663-3d55-08dec1444f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	pIKj4AjEb9Aoxa8s5rnYlERj87qKRKSX5cAh3KESBwegDRJj87e+WJU+KUX+gw19+e7+Jk3XF2OcmVNw133E3LSrXcHOAGMIMB/L9xI39oXHr2wCDNpq104C4FITprETk9Hr12qen7uwYUzFSLrpj0YPKUlAOxc7qiy1CHaiCqNV1Wx38xY2f5tDjGyq3ZWI7qr68vqYzAZXttmrFk7JXn1KDbwDyO5T7qMvbipb5UPg9KqrUUtJpw2Jy0h9PAbbVJt2yRd21C9JX6KxYeoL5GO1ZY3Oqe6ghuoY8ivwcn2gMuQmQAogRUdfTy3FGe1J1KNHt1hXFkxgQwpmfahAe7u5A4xRDgii59zNfaECd2VB8lyqCgbOaANarIopAu1Vk07RZ7nVBEjGtQbeFeZVsTOnkgdnoivEZWNwnxyq3vEv5XNCJ4oN8fAitvUm8rT6yZx8Qhap4Yiex/ui1JEK3iVyAduqofn0cvmQo3RYIZM+WlCZGQWSAddl9QClR5qD/+sVR3SUBbPaGDXybFQo14RuTmDjwmFld4+b+Xc6EI774G2PAJj8qvKtWUF1/Sa5MScdluSPyVpJ8rlYH+co9lJm1mgx55i1+PBKWYSmvTA6U7wTSGvD9zssGPXzzyigtkcM6PFTV8wTouluUrAKTwAhJzMBSIAsESeW0UsxR88nWOU+DuY4Flakeex2NOKMqUv0aC6C2jUEC/9uTs/frZ/CycntWaN46flZfoQTAOI=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XWwW4sYO6ffKyc0IRMmyINxUJFOcgDuckQRUY3pQsSA0rpYhuOEkyjKYfL45pbozaEvJ2nomiucbRBcGFSpISNX8K7i4iYYi61w9FoH4Lol4TfkPJDwyP0YB8ddVYG9Zo6uAIIwc6RA/egHlg1TOzOmqpJbL85KxZip0KK/9kEg4oynMaKfpQA/F76WxB9DuQIYFKNlBIC/ZND5VfM1cd8qmvF48L+us+rpioZng30rcHNopY/aqIfw/8Pw3rMOoKbthTPyJsDkWya6GwE7jUPZDsqZXkWeMKQIS/0mbFRDzl1Jezzz4UCAwv5Ec6UQ9r0SU+hcWougw+iMTfYSdHFLZ0Z0Aem1J+adQHGkaKRlP4apaXY6M41tGF+hJGckEDdGNydmSjrzZEOxg5yPDODWkflr/K1nTSqcZEGwGwyiKrifN9Rq7alrVSUNxYIvv
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:47:06.7729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052b4536-c23f-4663-3d55-08dec1444f75
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6462

On Wed, Jun 03, 2026 at 08:52 +0300 Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

[...]

>> +#include <linux/iio/types.h>
>
> Not sure if we need this one to be explicitly added when iio.h is included.

I would vote for removing this, to be consistent with most other drivers.
