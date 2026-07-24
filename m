Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013039.outbound.protection.outlook.com [52.101.127.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB031A07B;
	Fri, 24 Jul 2026 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862356; cv=fail; b=Zw9nBrg4pYg3boWac7zy5saCUBGNRvMTQ/EyDVhYiUhjNKoGKdUGjf/Gjul9wjVXR7DGWFmbghYPzGjwcz+Vhd4E+dRTRyy4ikDn328YRJi2P8b+7phOR8COLyE9B9XL2RwUGlK4d/SbP4ZN1LnH/se3z/0vL44PcY03+CKwDh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862356; c=relaxed/simple;
	bh=QHNZoI6s35BqUUeDwl3qczXZ9vPtydwQG/rwf7m4KzQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VeLnI+ToPx+KosAjuxHimPM7qtPuEo2O5Uq0FYxdF7s9eYFiVt6uiMfwN5V+gMlGkLV0oBXSRggzVRamadzT11OPPJgVct9fSp1ZMyYu6ya8r/XihfLnDQVDEvYesYXGgMrRPZ/uVuWxj7gX4f6vaFXxU84kjJ5qFli9/dqFlzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M9p18r26; arc=fail smtp.client-ip=52.101.127.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M9p18r26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILZlpQvYRxdAX8x91j5KyWVzjo9o9cUwpupMtRWWXewx0yYkujzZxy/m9/zar2S5ZCRaxfE4NTbQhcy5pL23H6GEk1MV7nP5Y96edVVwd7iJJfHaXCGXiGyGpv9ENSJBwq7p5RQzCgaqa/4wLk/qNhebPNklB3N7nA/H1fmUtJHjpHYut32OvSTOI0G4Bc13hwBaazkrzCgR/530/DQpC3s1mKQCXdzyxJ9LpWFBbw/y1BBk0rb7POlV6KKpWcmjdDYziQTwc9V+bRDeddytI/kTjLFdvDBnZcmUEE6AXdvnVMUF3MrHhCCj8LYDpNGat/WkyUrmq4uKCQY5xOemkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FbPWqMMZYCl+PGmjzgmDcEDdC3OSspKZhpOh2s3PCQ=;
 b=nC9d5dbvzA2f5g/Q6fZRO+TBgUj7hyvZn1P2GBG6K1XeQ/Jv/Bjbq6P4V0Bzp6dBi7DjFQV47507U5/g78TbJwLdku4MbCoARBnUFvmU2j/+2er9fhvB7LY9uXmEU0NRUK2wDB8ohk0RE/LwA9S+b77mO+o+psQzqlW9RhEiHiqj/ka+PjoIXH1k1cfPsTbCb32wQQZnMXNk/4KXl1+4x25T/PRHNwM21ThAcTj9kWCuSs8P8hX6zS2q2tBRrCY+RvRYl7DpZ6lLtw3qKSp2b/4O9EZu0lCmPDe3Zu47tf+yoFjTVK5XIhEN6GH6/JgaB5Ch2udmANIWva45Vn1BPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FbPWqMMZYCl+PGmjzgmDcEDdC3OSspKZhpOh2s3PCQ=;
 b=M9p18r26a40L99wATWmnsVfapNES+n77wiCKuvgASMtzGo9kzxbbnoTjhWBpCFodY2wbfaWmd+j8fmBK/LdARvaHxoAlXFkcWF/toSNq1TWztiPtu0Bn6cY+0zxP4mQ+qAOQlsQ8M6refeosP+0URx1uersu7X6yvnXh7/wVu4hiMS241HH3j+FVUacAc3WFHm58QU0soZ4hqI3WQKyNskfsD4h9YZ2beguOkg06Ef3OSwJeUozHFHIoTQYC4d73WxgJL2cXSAyiUIPioPI04X5AN/suXX3BKzcs/kHfJD1iyXyUV2rScjIcHO4JiiAFdVLxvqphRowuSau461Kw/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:05:48 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:05:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Linus Walleij <linusw@kernel.org>,
	Anshul Dalal <anshulusr@gmail.com>,
	Song Qiang <songqiang1304521@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Siratul Islam <email@sirat.me>,
	Pan Chuang <panchuang@vivo.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Miao Li <limiao@kylinos.cn>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Andrew Davis <afd@ti.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	Yury Norov <ynorov@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yash Suthar <yashsuthar983@gmail.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org (open list:ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER),
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 00/13] iio: Remove redundant error messages on IRQ request failure
Date: Fri, 24 Jul 2026 11:03:35 +0800
Message-Id: <20260724030524.607185-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: c52bcfa7-7019-45ff-7997-08dee93075d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|6133799003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	cwYpkwRjDDpPraWhLd/TkOIMTZe7Z9q4ZZkpMuB0WxovfS3Wa8+b+m5w+3wmG2L97txNPJS2oCvuxhR7Jjuh1Syw/Hbpk/jaW5m7Oshom0RA1tdc4FoB4cdjiRwdVdNJse2su5nVKE+l9nuzX/Js1En25AEzdj37kkaAHDwUdN3mrXyAHDpTUr1IcnIePVKZ7yzQ2qxHGEcZdE/F3Qr2fVz7rgnCQXTRzT4EVUaViJdyh549X9gHpP9OIcxULuB16pkMI4zE3KUhyH4O1bc3eCuQyZLBv5q/SYc0q4bAQPIJgwxWfXmncx9ipyh7iSel3jguYNWRjMSLiKv4v1hIDNGTtM68BKumyXdfYjmD5o8rFmSK7yf6fYSKVx16MFO8E1Az2cW/2EAb3XpjQl2vwuaEcESdkILRDyUkbLzjXeOB0KDLMTg/SWtOWmEiRLiRIyir5wkkWoJfib/fjBAgdhsQwTyjcpMhIt2rvymX0gPmGgG3Wh7frHuAVjMtW4WODTGprHNB9UvLzXR1/ab03ZwBwki4P9beVnUB3fPQFy2lBUenrSrx426qfPEEV+aavMhIUiIwkVayTJplBneeaSqxxILu3joPqZFY+JOKJzWonLHM/04P2pfwR7/tfGdWsWlhCv/+lhY8VhEPjihqM4ldO2UBc0CrXvtAAlZ+UPFbTTztM1SN6CsY4RHj1PTH8qR9+qizvu12+IZa76tuk1Txdi7kXKUtHfgAexp1gWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bm12chPwW7+Rv15Mlg+W2rEYBmkuZC857jxGgLRo8taHXP1Rt7XKY1ZTNeh7?=
 =?us-ascii?Q?pjhVyP+2CY1nrxPmutzvAe7i6e0BTU3Pu2ps4KY930IZoTSLTNpR2rG2r0Ou?=
 =?us-ascii?Q?/Qv7TUiSBd0slgB2IR/lOSdig0PhUCZFOABY4WUETsHKAM88XRgTHWvBvNjh?=
 =?us-ascii?Q?ao9FksSD1Oxt2JUIud1CZGCXYs8yRT0aol25FvvV9Lso45ZQKWHK6+teM66d?=
 =?us-ascii?Q?Q5t/4fuN7g6reEYxLwF5RdSgL83BCpkEpUbjqzux/3jd1UwHVB9VQjSdmhRW?=
 =?us-ascii?Q?WjW2rZvob53ptG5Nw2lDIcJeaOjeADzO6VfEzS4gsIH/7oUHAmFjTrz/dqWu?=
 =?us-ascii?Q?jFm0y0atGSsNZ6O/qtIJGDYNKYCyPrI541MX+H5LUWU1MYkdTL80Oz9+Wr2H?=
 =?us-ascii?Q?zSjTKoiU5cl/yEKUAtQl30kAdQJ578AwwB46dgRKbRDxyYN3A3ju1xrAZy2k?=
 =?us-ascii?Q?BLWu+X4MgeptX5tOj/XF/okyvp9YHF/d+5uxIX950QkjsAFvLNHzk42me91p?=
 =?us-ascii?Q?ASUGMJdldbBJK+eqDvOOCp3A8n8dfRqPiA/3ziNhd9He8lJddpwMA73Re4QG?=
 =?us-ascii?Q?hHrDpJCZO5Ug/udgi2FGurzdviRe2rx3FvAm7tjn5rDzIJ+TI/4J8FtwMe09?=
 =?us-ascii?Q?ccZ6OQmRy56v9AZTXeOcmW8wW5F3Mdo1qLMnJEe0Fd70krD0yoYJmL97a9DU?=
 =?us-ascii?Q?hGQBdZxdcG9mgbo7TLnITPiRLTHd+OQpuBHC9D37fXARsAMhfypwqByae9s7?=
 =?us-ascii?Q?ysKyxVJcSqFs7Zgo6pmiYCoiSyDkTkyqd6vAnUXpKF9Bad82KdhX+iiphw/W?=
 =?us-ascii?Q?OcE1LaXHlWiqUUkeBUT4eUtiM5cRNau9vsIt4B4tX48Y9lnFSB3DQljfeYzb?=
 =?us-ascii?Q?4SImKeHj9OJXiOZ15PBzNGochqCaKF/ebfy1RBgM6k3VAMWM61juAnEoV7JG?=
 =?us-ascii?Q?SkTh8+kBmpB84MAopcpxIQGFHX6SSVlcXG8idUgFtkdCK771CVdrn4Mhj0D+?=
 =?us-ascii?Q?pO2cNKSWwgFXFjJmVo47doqzcB87wZAJLSHoZgVrJ+sL0sR8HthigzSnGFJo?=
 =?us-ascii?Q?n5LcWA9FMheQegcV8y0mqXK3X6fo8TQ10OBUbhtEOoLzZznLoUEOwl55dHCf?=
 =?us-ascii?Q?VA6Cb5+lnbkIQCqSwx8AGOV0X37Z7nbUqZNFcWC+/v/358diWU20ehVB5kEy?=
 =?us-ascii?Q?jjN6xvele/IsZXVUtyiQg2TPsIj7XAjnPGqlSCJo4k/kTZ+c0eyMAxLcyySm?=
 =?us-ascii?Q?PPetQgUm2gv00tj5cPFFe4L94YxIUeKTLYYFuRn7PfprOXPOx5K4Ko2B6wci?=
 =?us-ascii?Q?zyyrIRmEZRwYK8vrpn2+WAmF3uFkPWVylik4k/pAK8suWe4W6DQDsttJdAsg?=
 =?us-ascii?Q?++73u/VnJh5Ab3cZYyBhN6AxaaSTSyJxloWq7Bq9t1/1odh0zWBdrNnLgDUv?=
 =?us-ascii?Q?qdOjRrpt0mTffTXq337d2SoIM/fgo/gz1Goppc56Ckldiz2LTYhL+6M2pcgd?=
 =?us-ascii?Q?a1XbHoEtXqFQj5ffjsCtNEzC2ZcCjvL8p9yl/Um5c3E7//Bj1z4sQOuq6eJV?=
 =?us-ascii?Q?YBPpk4viZAIYS0FErQv9BrO9erIjmr7mYGTazs+n9Z7hWnbMeZJQasGTE/Ku?=
 =?us-ascii?Q?BWuZqdFPcYe3JG1K3LZyjthiLhVTFThTzcAh4lfrwpciRDt+Di3KB+eA1khO?=
 =?us-ascii?Q?hB3Zlv3Ma1AOzuy0jc1BIa9WWSAdcpDzpjBwPdfoO503vuCyMG2MgViHdflV?=
 =?us-ascii?Q?9dKD6xcK4Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52bcfa7-7019-45ff-7997-08dee93075d5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:05:48.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjmjlW53trwPeyesjmFow5HjX7mM3P2mIhDRzNlnSqO5Q7lWuf08qsO9LtdSyFQ3bi9S8eWnwbrxZwkGenba7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
added automatic error logging to devm_request_threaded_irq() and
devm_request_any_context_irq() via the new devm_request_result() helper,
which prints device name, IRQ number, handler functions, and error code
on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in iio drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

v2:
- Rewrap commit description to one line.
- Drop redundant "!= 0" and "< 0" comparisons.

Pan Chuang (13):
  iio: accel: Remove redundant dev_err()/dev_err_probe()
  iio: addac: ad74413r: Remove redundant dev_err_probe()
  iio: chemical: Remove redundant dev_err()/dev_err_probe()
  iio: st_sensors: Remove redundant dev_err()
  iio: gyro: adxrs290: Remove redundant dev_err_probe()
  iio: health: Remove redundant dev_err()
  iio: humidity: Remove redundant dev_err()/dev_err_probe()
  iio: imu: Remove redundant dev_err()/dev_err_probe()
  iio: magnetometer: Remove redundant dev_err()
  iio: pressure: Remove redundant dev_err()/dev_err_probe()
  iio: proximity: Remove redundant dev_err()/dev_err_probe()
  iio: light: Remove redundant dev_err()/dev_err_probe()
  iio: temperature: Remove redundant dev_err()/dev_err_probe()

 drivers/iio/accel/adxl355_core.c                   | 3 +--
 drivers/iio/accel/adxl367.c                        | 2 +-
 drivers/iio/accel/bma180.c                         | 4 +---
 drivers/iio/accel/bma220_core.c                    | 3 +--
 drivers/iio/accel/bma400_core.c                    | 3 +--
 drivers/iio/accel/kionix-kx022a.c                  | 2 +-
 drivers/iio/accel/mma9551.c                        | 4 +---
 drivers/iio/accel/mma9553.c                        | 5 +----
 drivers/iio/accel/msa311.c                         | 2 +-
 drivers/iio/accel/mxc4005.c                        | 5 +----
 drivers/iio/accel/stk8312.c                        | 5 +----
 drivers/iio/accel/stk8ba50.c                       | 5 +----
 drivers/iio/addac/ad74413r.c                       | 2 +-
 drivers/iio/chemical/ccs811.c                      | 4 +---
 drivers/iio/chemical/ens160_core.c                 | 2 +-
 drivers/iio/chemical/scd30_core.c                  | 2 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 +---
 drivers/iio/gyro/adxrs290.c                        | 5 ++---
 drivers/iio/health/afe4403.c                       | 4 +---
 drivers/iio/health/afe4404.c                       | 4 +---
 drivers/iio/health/max30100.c                      | 4 +---
 drivers/iio/health/max30102.c                      | 4 +---
 drivers/iio/humidity/hdc3020.c                     | 3 +--
 drivers/iio/humidity/hts221_buffer.c               | 5 +----
 drivers/iio/imu/bmi270/bmi270_core.c               | 2 +-
 drivers/iio/imu/bmi323/bmi323_core.c               | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 5 +----
 drivers/iio/light/adux1020.c                       | 4 +---
 drivers/iio/light/apds9160.c                       | 7 ++-----
 drivers/iio/light/apds9300.c                       | 4 +---
 drivers/iio/light/apds9306.c                       | 3 +--
 drivers/iio/light/apds9960.c                       | 4 +---
 drivers/iio/light/bh1745.c                         | 3 +--
 drivers/iio/light/cm3605.c                         | 4 +---
 drivers/iio/light/gp2ap002.c                       | 4 +---
 drivers/iio/light/ltr390.c                         | 3 +--
 drivers/iio/light/ltr501.c                         | 5 +----
 drivers/iio/light/opt4060.c                        | 2 +-
 drivers/iio/light/rpr0521.c                        | 5 +----
 drivers/iio/light/si1145.c                         | 4 +---
 drivers/iio/light/st_uvis25_core.c                 | 5 +----
 drivers/iio/light/stk3310.c                        | 5 +----
 drivers/iio/light/tsl2563.c                        | 2 +-
 drivers/iio/light/tsl2772.c                        | 5 +----
 drivers/iio/light/veml6030.c                       | 4 +---
 drivers/iio/light/vl6180.c                         | 2 +-
 drivers/iio/magnetometer/ak8974.c                  | 5 +----
 drivers/iio/magnetometer/rm3100-core.c             | 4 +---
 drivers/iio/pressure/bmp280-core.c                 | 2 +-
 drivers/iio/pressure/dlhl60d.c                     | 4 +---
 drivers/iio/pressure/rohm-bm1390.c                 | 2 +-
 drivers/iio/pressure/zpa2326.c                     | 5 +----
 drivers/iio/proximity/as3935.c                     | 4 +---
 drivers/iio/proximity/d3323aa.c                    | 2 +-
 drivers/iio/proximity/hx9023s.c                    | 2 +-
 drivers/iio/proximity/irsd200.c                    | 2 +-
 drivers/iio/proximity/mb1232.c                     | 4 +---
 drivers/iio/proximity/srf04.c                      | 4 +---
 drivers/iio/proximity/sx_common.c                  | 2 +-
 drivers/iio/proximity/vcnl3020.c                   | 6 +-----
 drivers/iio/proximity/vl53l0x-i2c.c                | 4 +---
 drivers/iio/temperature/ltc2983.c                  | 2 +-
 drivers/iio/temperature/tmp007.c                   | 4 +---
 63 files changed, 65 insertions(+), 163 deletions(-)

-- 
2.34.1

