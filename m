Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013022.outbound.protection.outlook.com [40.107.44.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4493ADB99;
	Fri, 17 Jul 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281556; cv=fail; b=V6Bhe2D4ukdkWSMHMTJ5Y286Yd9LbEktBxq6DjO7WYYgyl/+kLAnVUQNAmdPvxWcIXdH6N1WbXSJc2JfJSUyNbCtHyT1ZlENLwojGV+3qgrPNNpy6P6TYDU9smX3C17gcSOFLAiSvLslAxRf+DQy7h2uyYy0cCRVFQcQesr6vG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281556; c=relaxed/simple;
	bh=+ma9jYdQCyLJX+RiZiVfJSwNjr0dUgDR71Dk9Zae25E=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ln2SeJUnw9Klk+yqw5clddTRlRu5VoC5UNa5b5AUXc7ydatU4tpgs0dNsIMkkIbIRvY+f+/7JOaED2TEtlBLC+7UeJc6ty5DZgnLz//cMZPmn+faARWF8YuxfO766DStRzcSjcvhoi2LA7oLosvKK3GloXekOpL2RQCV55FYAK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PfFwoAOd; arc=fail smtp.client-ip=40.107.44.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PfFwoAOd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkkZ7/u4+mPqLrI3ZorJkIxNCtrJr+5xEMNzh/6kNDLwGCdcWeJUOhm7ismvSnjii0rBvvvsmbw39vuuNPKQJ12A3fgWJTtcPw5kLFRZ3iu7b/0152/rRg0zBvVjCK/MwvIDds/QV1XcTKvIiVfEiHLDunGpiuO/zLFtWbiIPI8BIxQjCrVIQ0hOX7LB9Ynq89xbMkwpRfbPyjXnML15Z3BF1Hul7cGh/QA9+mWgvZ5U/4uvsdX4FqYD+H36X5lz7iksiTqCLVoGTxfoBXRb+RQZuUgiwwKZOUTxdwYR1+iI3vbqo2Hy2jK2S7zbHplwwG7CIYriSN98duWWwove3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RfnwFfb7TR7rS1jVymq+eENBYwAzHmWRSM0aEW9RuQ=;
 b=o9ghrtPhpq8Q5b4zShu+55tXDPUrILpNjNLm8EpXIpUjX3i6ZM6UMfcZk0GdUwPYnBwFX2uR+JhuKuVQQbPP2MwSGaYSsN+Xzkb1ZGTg+MOtG8vUlkYjw6o1L2xd6eqmfg7Edh8u/Y7sRpq/T4cYPxQlhoDxjJ4Sy9GdGlQldBIws29m2zsBy+VAraP/ijekpbuYtrzBdrjjNcdIvigUmz+lMuSVblzQpoPjxJQZHiVHIEowOMwa4Klg2XDHHmJZKR9LSnRDpKohor1RHmW/KcL3Idz44uQMNjmL/vnZuqF0oXU0dOzBgxgNfmEC/5B1TjpQR9SjYNEdxctZJAI/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RfnwFfb7TR7rS1jVymq+eENBYwAzHmWRSM0aEW9RuQ=;
 b=PfFwoAOd1xClt9O+Y+iQou9hOL2pd7YNdnMjScbIyfgTD5vohBPa7/JQgpJqKAW5ANyin0Jvcfm825eGw37bGV/+84Av2TUHEgnLMm2IY81vNzCSvmyTfq3pkdRdjZioLzLMW0YoVhZL6GTSpE4usDyu78tVtQ8rVYMsvmYkAMGt9tYD2A1Nk1Djm6+etb4G3BHXXYiKLJeyPF0SAYUbMqtivNkxeDaRVNeWu8s3sEvikeYCCbtw4MKADAwAwU2VOcheKyb0xPp5ciaFvAdgNDsHniUSc3tjGyD+xuvx4cyu+rvFJs/9z7Pxb67aL2C0IewpZbzTAp2j1sQjd/1lBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:45:48 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:45:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
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
	Pan Chuang <panchuang@vivo.com>,
	Siratul Islam <email@sirat.me>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Miao Li <limiao@kylinos.cn>,
	Andrew Davis <afd@ti.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Felipe Khoury Dayoub <felipedayoub@usp.br>,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yash Suthar <yashsuthar983@gmail.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-iio@vger.kernel.org (open list:ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 00/13] iio: Remove redundant error messages on IRQ request failure
Date: Fri, 17 Jul 2026 17:42:23 +0800
Message-Id: <20260717094408.509583-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: c4c2bf90-fbf5-4a6d-adf8-08dee3e82e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	RgiH7Wt4049675AHodx8bwipquTooPsIvnVUTSwhqHvdTrihEnzRhI/+D0KdOdSGZdS5wlfSD6Fd29h+WTQq6GOjsjJoMMU2UOVSyVm/ZNpE3mXJG469SYHt9baanQhXW3l5E4iiOnw3zwDxFAHfPzl3FJ91HmT7uMJrMSpaAkY8LlpgRRUvVnA9bhJlgvzS+yrZhBWOXugIsldtgWY9jwUoFBdpOlxhgqdAFc5uO7KTJxp7IEc2N0My3RV9AH5wG0y6bwr9UY+gLsaMM7NuYfBqkEbFkknXUnCKcDOIoB+wRX05wIqtLAxvun2LvA430LUN/1pudL97fc6QuFKvo4Z91bWlWTKKELrh2L4p9cRxvN3yJlf8z/2MsXd3OMsXfxV//edeof0k31aY9pDLFOqadpzsFSmjNkkPs8LgWj5cam4TwGI2MZncnKUFWC4l59Sb/8I2JxBaGmZyaSg/yHQucNouSHZ6R8sxLwqRx7G9qsK+TpmKJRenRuYXpkUFpgaXFUopAk0fPO81Vhj09gBidDJXBjG/GGNWBOpaq+15MZDLTQ49Gzs+xjiA7YcKf+dQdE2RdygSgec8Kw0lMMKkOnCRJ9lhw7s/jT+B6Z5jYpGp5pqjBUDdEAnkv5hjDIOlDc3ysBLSajfbwxc4Rg/PKqxxucIbFXvQ1erSiBNfOGk44n8U90+Cvc6czocWrAJ4RM3k8dTZbEMJyo/wKnrb7wXbUKuWkx6LklNGjxk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PqF4cJ2kPEIejrJmvIF7EcXHMAy6g5+fmZAZq68k+jBBsfuO2sdmFvW0js0C?=
 =?us-ascii?Q?bzrQclB043rcUIXdOT2g6bSfJqrPEESgr5WJvfuDF/8zmz+ooBiBqnZpUURl?=
 =?us-ascii?Q?1nplFyq/PSUNd1P2aqJVUkLeKFVm5j0KBvph1FkygFvk3monjQeJXkO1oG8C?=
 =?us-ascii?Q?puFS0qa0ZeQBzft4pxZus/rTsGm/vRWGuBsg3/1mhUGDC96BRmk9S0zymEPv?=
 =?us-ascii?Q?jLAKiuHYvGvzu5B6ZWb6VKwZGyrmheXMpPAPPzhoE/h4J3bn9o/AFzotWgo8?=
 =?us-ascii?Q?lF2e96+htfJmpWHhOG7OvPWH1MW4WcmifBCuDiP/fl0ZSVq2MC/LrUSEOqJS?=
 =?us-ascii?Q?H00ItFyqwDAf342XA1o4J1Z0H3Tzu6zJkUV3DqvS0tUiBkZFi+hTUYWOq8qm?=
 =?us-ascii?Q?j1Afjx5ayg5Esvs+lUJG4B31maNJxlaWvR52ig4px3SJd1MGhPR1zJAU4yXn?=
 =?us-ascii?Q?ABo+w2n3kX638t5Uo0l0Dx+gbfzMbEaCOV2faKFaScQdhoInSua9mN4zveVe?=
 =?us-ascii?Q?cneUSELF7ZivBzluHchIPE/dNThmNs7GTCefJS/25uYlZfHIM2LxH9zWjH2B?=
 =?us-ascii?Q?sFaCCLqg5tOT5VX2vspSuGsK5n11GtkXKj9kcp+wjyeK2OC4N/LtxeM6nQvZ?=
 =?us-ascii?Q?zUJ0aBr8TzmTE6g5yMOl5jFFeztABMSZoWHxRFEjUfVSPOM/zhUXvq+R8w83?=
 =?us-ascii?Q?Btvl0RphEGHv6ODIMrhf74CZCenBJ7t4J8zO5sP2XhjungZ949IWpma4gwe9?=
 =?us-ascii?Q?zefEkry9JygadaXwWsPnOfPk5/LWnHt6jSlszgrXmyZzf336bVU7nr+KYi2d?=
 =?us-ascii?Q?tiWQM2NVvurVqXuXsub4goc5u/gIPTmRf0POpgdVaBq3j+ygqWKqVzHrvW//?=
 =?us-ascii?Q?O8tvn+4C/Jdxy5CrU3HLzpq0es1AJic3r7bdVexLJHrgn1WvJxN+cKHjxi67?=
 =?us-ascii?Q?naBEY0aD3mDNxIaF2kKsfThHzd/MFM+xhcgFYLnUMyYKsRUx9ZLsh4ZCXD6g?=
 =?us-ascii?Q?0y/uE65xypQfFaJFNTqjCUKUVEhPKdsLKBAEom/Fmtq+O5jlfrfV/ZeCnHFk?=
 =?us-ascii?Q?VxXzMVvkCiMW57nCvrd0crrys2DO0oMrT/wUWLfvRS8KYsRb+XwtDUmz5NQN?=
 =?us-ascii?Q?sIFRJpMS/LnFpgRWxPqmHO7XIHuScVaj5j1xAzxCsIKLSviYvLqaSnYOwa86?=
 =?us-ascii?Q?C6w1wO0YWwRS6SHe/IjsN0btgPbtYjVnGK+ish36m0CYemlI1dkKIeiPQkf4?=
 =?us-ascii?Q?JRnEiUsKr9m1RjXpbNk2GR9SExtfLMs4sMMG3RLp08j18es4Uma88dthF6zh?=
 =?us-ascii?Q?n2Ag73t9oOscbVFjIuv8wWlObIkfsnb3IssY3No9cnf8JXAMNiXXhTFfZGo6?=
 =?us-ascii?Q?NVN3ct8Gg6rQ6Lh67ZHEPIUKJ1o2/ZpmzZu9P00MjDiUMvlBaRy5gEgIfJrT?=
 =?us-ascii?Q?thFvPBC9KwJyXfmVhr/T1mOBRNPgP14pb0o7jZM6xrtFaYXXkjSKVdcjMz0y?=
 =?us-ascii?Q?SZJBA24hdDslpx+PLdouyGFrRWWlzrFjbdBmdNlxCmwpQVLjCAFvPaMjMnkF?=
 =?us-ascii?Q?cbTgPWzvB3d9HS9IJcICg1Mp2/XTOYoslVrgBchuj0qMF1HPQZA0KGp9qm8b?=
 =?us-ascii?Q?3vC+ReVAlZH63P72SR1IrcC7rSFQ59fDc5UwgHjvmFIMIfELWnMEosrZd7EE?=
 =?us-ascii?Q?3c92WKKmSpGjKLoa+adPsexQJAzeAtY7iXSSHqJFw/mzjRduyK1gXx607lgG?=
 =?us-ascii?Q?dTGupgKPAA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c2bf90-fbf5-4a6d-adf8-08dee3e82e3b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:45:48.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EwRuXNjJ9HT5ixTefyvZrZgAdQjJVORoFbBj1ZOp4cD8k31KyMRQ7oTvw5r4qfwr+zC22oQxW+ZWY3T+LUvFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in iio drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (13):
  iio: accel: Remove redundant dev_err()/dev_err_probe()
  iio: addac: Remove redundant dev_err_probe()
  iio: chemical: Remove redundant dev_err()/dev_err_probe()
  iio: common: Remove redundant dev_err()
  iio: gyro: Remove redundant dev_err_probe()
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
 drivers/iio/gyro/adxrs290.c                        | 3 +--
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
 drivers/iio/light/vcnl4035.c                       | 3 ---
 drivers/iio/light/veml6030.c                       | 4 +---
 drivers/iio/light/vl6180.c                         | 2 +-
 drivers/iio/magnetometer/ak8974.c                  | 5 +----
 drivers/iio/magnetometer/rm3100-core.c             | 4 +---
 drivers/iio/pressure/bmp280-core.c                 | 3 +--
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
 64 files changed, 64 insertions(+), 166 deletions(-)

-- 
2.34.1

