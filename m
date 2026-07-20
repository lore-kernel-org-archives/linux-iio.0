Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012034.outbound.protection.outlook.com [52.101.126.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CB3BBFB5;
	Mon, 20 Jul 2026 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555040; cv=fail; b=oUS4r6bZL4V9mhJJIWZqoQUpnhWN4Kh11vILhabZppgSCWLGhVW7pKXi6e1kZg0FgKqR1vvQSMeBsjdXt7Bo1NawNjyqTWfLP8j8kPMDwp2xnJstExjfRVSANSKT7ehhW1NhflwPzZFpyRH4GsystWxhacVcmC1rxFgAiCayC3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555040; c=relaxed/simple;
	bh=KSVxylB7xC81f7CONc18cQhi6TFTl3Qgq1LtPWdpZb4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xvs/EdRoFGoT/n/G5cIXnwLq040ShXbfq+g06gQJfqFWN+aF0ANdvmM112BMOkwVtrrQIP7sHufyT6p3urNwk49tOce5VLZDqbEM7vKZQy0Z0WHrlUyFxKIF9bFkfmrvS4NgusrN/GIkxhIfWa7JyiaUd/9w3S871NSgkp0YFEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BgcLdhIi; arc=fail smtp.client-ip=52.101.126.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BgcLdhIi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXrQi8fkXo8by9HgFuuy/LcquIrTdl0M2RHkje7KX111w6XVRvt3cNjTGYCizsjZ6v9//JcnLS4jPRWWq6gwHJelPQvSEYIXI0kQvFLzXwOZe4yuGo9gnu8vVrWeNFKu32YGMlrNV6CNTWAN3fMpg7X68gqmmsaAm4fGgV3jvUVfQ++zBrYoioY2LUdAtMqjO4ICybPuLAz2UhSd0m01vuWIM2ua4jcQfJCbRACZ44Sh3rZMjDKYU5PJ/MaV3X9XigV0SvJ2Dc17FVsqsqFsTYlchwST4yxebsQSYkEmXLKI2uE5FQov4mIBzFEAdWxZCd981ezwGB19DSaNa5tszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALDttZivWxmOZIL+ZHrZVHYTZdcZEObk3B199fjRsMU=;
 b=TFbKph5HfACJLmyufpbVgChwMaDfBtP6KDpPRkdJX8BHs5ZZUIequQV9BJpBMOQ/FWnI9jT6enIfQXrAh5xwKlCQ6NCVMpxjp2NeZs0PyRwey7g2bXMyiZQnapCN2Cp51j+v6EKSdrcLeAt0UMaYzDm+GsDbpr9UMjG/ZYe9JCypZHpHDgk3wt1CCulbQVDPnfJbvOSsdUi4CIDna+S/q7vRl9KlxFs+MVJR0rBonl91AOil74p+1a3YIgtYy8PeEfKLS/fCNJptxQLLGpdVQLNDi9aowBlPCa0r8xJVNJaQXbhLuak06yO+QysijomOyUlyhjRT09Yc/xlP8oBVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALDttZivWxmOZIL+ZHrZVHYTZdcZEObk3B199fjRsMU=;
 b=BgcLdhIi9fwUB1cxSpIpqHREMTDkhYqYs0K8+dx8R5wf6r0qPJ5DWLWlxputN+je23d9djJnoWl5QXusJB+BgnTVYIzTaePCbAWFOApZhIOQKiexRvq5JNPHEiC/NE21oBs9LHX5A23kbU3wmOWrkQKVzqrJvz+Wt788AgOFdj9E5y5HmUam6141CUDS0npsMSSobVSrnU4Fb3SsOt9q+PARZ+W2BT1CxC6NZrco7OWIIID/eR68GoMyatjZVLI6XzSrjHHk8oPzcU7oIFUfvQ7gMYskOHq3rltl5QaaXNZhfWSpTYIXWZXNMaOorA67h4YTDQRLDbmLhnM2ErBC5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY0PR06MB5457.apcprd06.prod.outlook.com (2603:1096:400:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:43:48 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:43:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	Marc Dietrich <marvin24@gmx.de>,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Gustavo Piaz da Silva <gustavopiazdasilva2102@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
	Gabriel Rondon <grondon@gmail.com>,
	Artem Lytkin <iprintercanon@gmail.com>,
	Zeeshan Ahmad <zeeshanahmad022019@gmail.com>,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Batu Ada Tutkun <batuadatutkun@gmail.com>,
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	dri-devel@lists.freedesktop.org (open list:FBTFT Framebuffer drivers),
	linux-fbdev@vger.kernel.org (open list:FBTFT Framebuffer drivers),
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-iio@vger.kernel.org (open list:STAGING - INDUSTRIAL IO),
	linux-media@vger.kernel.org (open list:STAGING - ATOMISP DRIVER),
	ac100@lists.launchpad.net (moderated list:STAGING - NVIDIA COMPLIANT EMBEDDED CONTROLLER...),
	linux-tegra@vger.kernel.org (open list:STAGING - NVIDIA COMPLIANT EMBEDDED CONTROLLER...)
Subject: [PATCH 0/7] staging: Remove redundant error messages on IRQ request failure
Date: Mon, 20 Jul 2026 21:43:06 +0800
Message-Id: <20260720134324.239391-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 81441a04-cfc5-469d-2d3a-08dee664ecfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|52116014|7416014|376014|6133799003|10067099003|56012099006|11063799006|921020|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	gxi76lH1d2v053sMnoagBqMtN1PZb7kh/Vl+IqoySmVNjINVBRS1mtBZYSgYnAfkaZKbP0PX4I7LFS6UyZ45BunYsXNbqOSu/nUQKEKRxob/FWZBocV5j5k8eQgMLVSJbeUOYepuPjuo5KKZTMLg57tJ6TroBmqDcWJtfNuLcoWSG+ZaEGuSI1RAgQaCNXfxqh1vXDJCLS5lKFymCUMIWwUxYe9cU4nYkCq3kMl6LnrWL7XW81BByDt0x1k6jvIDLo+Kt2jAECIk2zSKDwiBW6/a5jLYkhVqBeE2UlrZsy3LWYkKPa41Iha4urS46BJxdK+tvZIJQMPqJfHZYo69hUllVS7n48LQLsVFT//xBwMrIH//RxQU2gsH4dFIgSFWJ5juXSfpZgVGWSRMTzzdVx2gz98LJ2JhbK+7Um+91QvfJN6gf87UXZI+smhJhDQ6tslb+DjeJKy31Nu6o03Z8kR60TCPR0sg11Ej+AMCcmOlYCTZNotEie1Moxdm/9zbMFj9M/yAT3MqJZ0T0w2rh1Sdz6EKBpN1dUE3GiHFuvV19LnH/p0knsXBFqMB5yaaaFGz6GinILVrVFUf6GnPGuWx7rQlR6oPKVerzeDnRtASZc3P2fP+f5M4YeNe01t9Bh87ZKXE/lPgOWplorlkle/VDBonT0uhQAg8AkhBHkux8/vqb5rW60OmaW60Y1c8g2Zwse1I9rOLFrcIzwAvQ3yFPZOY0fyHnD1cCBXbhT8qInT5LPioMRGmRbVXO2B8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(52116014)(7416014)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(921020)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRsb34bav0IOQBAlF6AmyemAmAK2Jb7Gl21pxr4wilBDtFQzP97jAbus3h1b?=
 =?us-ascii?Q?Ps4UKYvhV5HdhknwTfSBcrTeXFZNE46I/RA0+jLRlJTtPlrVa9Sb2EpUJ+dg?=
 =?us-ascii?Q?g9UoaTgVhEpAiDTm6SakU5zwTc1tYTBSxoyCh83HBTm+Rk194OnBne6zTevs?=
 =?us-ascii?Q?c0TB+yKH07GLmjJeLZdp+0v+tyyciUGm0Ss1EpD5Nutbsaqaw+9iSNRtqswL?=
 =?us-ascii?Q?18vsgYB0C5K1sA9ik7Lr1os3EGejZh8Xam0ynhpT4P6GbXKt6gvwA1H45hTM?=
 =?us-ascii?Q?5Lae7jZVX7Ta02dl+gDcBcRws+UGArgW2bF87gvV9DrEa2ECMPKhDJRBaW8D?=
 =?us-ascii?Q?ljUYNOS7lpd1Ur960RtVy/4LVkDp/7LhF/tIEWB3jV0sNL9/v9JKMJMIktub?=
 =?us-ascii?Q?+4vNSS2NOL5H6lhn6S2EClzwm4AOhqv+qVlc4ts7YDokErHK/lMEjR3MHn5t?=
 =?us-ascii?Q?Cayj+9+RPdRrccRZmc2kYCZuOOn7N4KqVYhSHQflh9N01beLEesdJIonKTgI?=
 =?us-ascii?Q?p77FWDbGElfR7Q6736fLRONyZrk7NSd+1QQABIoXD2Vg6pCO1FfUmH00t9Zy?=
 =?us-ascii?Q?EcHTCzEQ6K8rJksqj0DPJjZfsu57rkoPz6J3SeVE2koaBeJ46RT1BMHCWitW?=
 =?us-ascii?Q?n/7//xUNKf8pUaK60KHAmgN216adtcicp6CDiN4OvBHQo1kSzzlUQUbxKU1W?=
 =?us-ascii?Q?J9GHJQCg5DbnCoyI6Uq/8Rs50BgrygA9LP6BodDCjm4k5jbWL3W1d4pPpv40?=
 =?us-ascii?Q?pTxKR/8fsnIPllnNQpzEOHqWuvyn6sm8AZiU7Cm3dYWSRquLbpfC08M8KfZF?=
 =?us-ascii?Q?kNeYTa6ON/Jxiu/W5GNCgBP1wUoyCcP/gq9Z+hwya70okJ6w6lV1kmV6kZdv?=
 =?us-ascii?Q?R03hwmq39EfVz4OosRiHniLgnkyzTem54iPouWhnUTm1lSKLS+nAFMFJK8Eh?=
 =?us-ascii?Q?emuJriZFNtOWv4xid/ap5zvnAps+X8hxjhm4ksL4nfAduPqej7AS9WbfqkCt?=
 =?us-ascii?Q?JolVCJHfJd142HNgxh/GB60iZLIeHOJVs6jHSpST51QgxsnEBMjGQKPrx0Ss?=
 =?us-ascii?Q?r9zYbWArZ77qAoaX5Q6tDpfIIbr9dfph2Upi7+0g7CFydIiLN5JPOFowmXah?=
 =?us-ascii?Q?xjjosFifja4WENz1TooyCpaS6VggDPKkBhD64uReGXeTYpbqOMCruaI97gJY?=
 =?us-ascii?Q?Si5unNmYhB9vw4skFFjEelAmdo0YY/b6lH8GzMF3+xu+WaqqtqVgnLLOsgdq?=
 =?us-ascii?Q?BjnhxyZ3mUmOoYlGseHpX4cQ/zkPhKQDFJukV3V8wxjhDdQfiQWDV9XlIpmp?=
 =?us-ascii?Q?IXULEfaB5xg+0RCWQDM4adt6FR+OhqxRtQLY/I3wIQn/LgUdKdXJq+ZeNyI9?=
 =?us-ascii?Q?jlUlf/2NxqlhPMxCb65+RnL7LWXLFn3vtAbTigAdwOP+oTlBviYrHPUbZz/l?=
 =?us-ascii?Q?uicSAWCH7lIOsTA6goMjU0mB4ZfDUhUiH3NDPUxsWo90b3SRJ6b0/ptGOUpG?=
 =?us-ascii?Q?llPiZ76DlBtU5yiMMLtVBjvYaLQ4kUH+NKnco9GyF7P2ZVXjmiYlAu1E1lg0?=
 =?us-ascii?Q?9wPdbWbzTPSP3RLeYG+WxpkgjdDNSXBGg/K3UwxvX+SkFH/1ySh1M9mdU0KT?=
 =?us-ascii?Q?lDeq7/GiI/9pemBrwUOwye11VGKzF9+JEYJ/5I2hqJnA3us64ecJirTS7Yyc?=
 =?us-ascii?Q?26y0PWXyBH+tvFu2QRnVHUNtw1JvEnxrBQBdG+0WnkNNFCBPUpGLJgLn1xm3?=
 =?us-ascii?Q?9ad88LimZg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81441a04-cfc5-469d-2d3a-08dee664ecfd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:43:48.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+xdQ6/p1ZVuxblzp+BggmP7+q1koUHNHGMMliUst2k4jzN+sZ0as6qStYVpmGuYPXjF/BwwGwF/yL8Whrra8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5457

devm_request_threaded_irq() and devm_request_any_context_irq()
automatically log detailed error messages on failure via
the devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in staging drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (7):
  staging: axis-fifo: Remove redundant dev_err()
  staging: fbtft: Remove redundant dev_err_probe()
  staging: greybus: arche-platform: Remove redundant dev_err()
  staging: iio: adt7316: Remove redundant dev_err()
  media: atomisp: Remove redundant dev_err()
  staging: most: dim2: Remove redundant dev_err()
  staging: nvec: Remove redundant dev_err_probe()

 drivers/staging/axis-fifo/axis-fifo.c            | 5 +----
 drivers/staging/fbtft/fb_st7789v.c               | 2 +-
 drivers/staging/greybus/arche-platform.c         | 4 +---
 drivers/staging/iio/addac/adt7316.c              | 5 +----
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c | 4 +---
 drivers/staging/most/dim2/dim2.c                 | 8 ++------
 drivers/staging/nvec/nvec.c                      | 2 +-
 7 files changed, 8 insertions(+), 22 deletions(-)

-- 
2.34.1

