Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792907351;
	b=N7VKwNE8gMZmhGdv2aKAUHeXMgxdnrSu3edDi5Xu0wxaqPP6TkOQE8C6w/t0WVFuGOSk
	 55x7GRR9UA3tBKf3u8/7lpuv7WsB3dWCmORNdVBx7IG4cW/HUnC2DJmFA6PslOoKriYbv
	 xzQHtHdUPbUqvkKjxBSCRSnLaitd5UrML60fNk8vWz+Vyy0nzcYoFK47fULwLmolooBwq
	 brruLvUck0FcGRU6yM5NIrujIBbPXxMIdfuybgGrTS7eMnFR9iDrm1D1tYbQ3k3YZBtc0
	 QVJFWdu6oGptYf4JyJMSCmPDXCIjSrxw8sCZKIHOFVcOgMGe+v67nM0/7bYb4E058Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907351;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=McvF9XPquzT8mlG1jiaU+KJmVB+EYFbhfQjvISdnVgM=;
	b=0pZdI49oGc3UP3OOtk7ANbsNpdRMBs2cDCHoO7bsct5jwReEBl95CxLNG8kpn7gsrQ/I
	 w13xvYFcdrZ/RLlxkdJkUx9p3op6Y9V87dHW6hHF4mnX5fCnjIWfkmO9bDbanXL8GwpxW
	 TtiWofMKZ+cHuhGT7Oz1LC8mGtFgoaazlY11vBT/mT7yd2JxY69FZM0E5dP8OWY5ZtB5z
	 tGSvo9jkjLRmEfC8VmZALJfpHeZw+pcKhiFy1nXs75KRvuYSeahoRvhrWfso6l7L2R9HH
	 xDsnzARQ4JPVlHkDi+hTw//0rwWCJZIFBDHx+tTf3pyuH8I5U5Ovfhte+K3IUFBMwiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pM6aZ7rY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.9
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012009.outbound.protection.outlook.com [52.103.23.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092C606A31B;
	Sun, 25 Oct 2026 05:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C092C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pM6aZ7rY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wto/5yjWWRbCvT1KAWiM94sHqEb6vBkVJfcIO/GJeWI2cqkXvAI9y26K1cd9GBCji4pn65f5cCJQkYS38y16zxVQccZin8l4O/xYEN/JJvFb8+iL0DYPjV8I1t09EhHLR8mgZG05WaR1LvcWwdP9X6Hh6qOE9Hz+5IlUgfsCNz/oiWAk4duXREIkG+cjZ5iZRdpd1ZhllDWg25Xr66Al41gUGdH+ZRWfm00iS/0Sbg/ClIXklawHobnljvMVU6X6TsRuib8jMyUmXSLCqiRHcl4yLOlGKM3wcF0OAZ5TgwpZtz/5T5ibKtpkTk7KUh1rZcGv6o761cR8yKVluulV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McvF9XPquzT8mlG1jiaU+KJmVB+EYFbhfQjvISdnVgM=;
 b=GOHOl9sLQ2iReDAdf6k2ib4462PyYJcfj4vPTENvgXMFOrV2evMPWmfXfTiVbhuiqydnSJObEWmqkTIW3J35wGXQPH0v254eHCd666WDDE5D+kStnIJj7AT1iBR8xyrGJ6YRerzQAa0hJBGDDQYlMT6axkao123dsx45Up0Gjha2W/XSlYel8IK5P/ZAtRQv+3xPLJQOpdEf5Bm6vC4cN1ACitUiNLUJAIXBKq/dbgWaBejyncZl+1IPsckb+YpHPHIhkytvrbA4m3n5W6+WkkJt52B7sYG6ugGBfdoqKopFXcDwbHPVRi34eFMLUbHqmS8qxAAFBd7as3iBvcxfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McvF9XPquzT8mlG1jiaU+KJmVB+EYFbhfQjvISdnVgM=;
 b=pM6aZ7rYmvrNSwgJcSqJ0C8vzAGFn0W4IsTULr937X1yNJukNyE+CV+mumHlYeVsPZBucvDcoN6dIgk1ALL8Xx1db/6f3S48vMbhmNPoaAiYzTWPIxZVHUY9Kwo/BzR12cDzrX4pdlb4K9F0KOB+cYrjtM/omKWsCc71/WIZ9yZ/ZHM/BEiNfQKMAtTjJY+qa4S6oKOzKSTrv2dM7bbKblLwCZM1QD4TWr9yBWFzDhgEPH0Mu48F8U2EPl61UiCOzImDKTcwwq+4MzceqrzMCIRlzK+JsXEcQ2I8q3qp7W4EmMblFpqioRqlO4PFZu9Qs7LhB9EqtfqldDUg0+69Uw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sun, 25 Oct
 2026 05:49:06 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 05:49:06 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v2 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun, 25 Oct 2026 00:48:03 -0500
Message-ID:
 <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025054850.33748-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e6220e-bbc0-40f4-4097-08df325bae69
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|51005399006|24021099003|24121999003|5062599005|22091999003|23021999003|25010399006|19110799012|8060799015|260925184616899003|440099028|3412199025|4302099013|1602099012|10035399007|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOEFphZzo3K//42w5qzHlWlT/idHfJ5vJkijdMUn7rBWI28ggMaeQvANkYmQ?=
 =?us-ascii?Q?Rmhqhj4THT89F/IZ9zTaEjEJeswWvP9WVfEf+e3V8rEZnT/BykZrjsaNkYTW?=
 =?us-ascii?Q?xbT217Ccpi4Z+KI7suG7IdhVYhTQAkjbVXlvlZ622LevjKlahHDP65LwoFGH?=
 =?us-ascii?Q?jAkcgY4tZoSq87LwzP4RazwII3S7DCsqsrEL+bslWC1jVX9K++1cBuScujYD?=
 =?us-ascii?Q?gayUpg6DWvXarHnGqoNL0HFnDg+pv2MbjcORohWclVA7sJgSK3Q62E1joGE5?=
 =?us-ascii?Q?IKVxgsjSZg7m9i7kPevguN7FyQSIzs70ZnHOerJQ9Mo7qPLDY0+/R+JZuIsq?=
 =?us-ascii?Q?vP4ZgmSuKMDAcOuaAgy2gujFPd1iySpiHghfsOJHG7iWv4wW25cckzR/+Ctd?=
 =?us-ascii?Q?T2Ia1QEMh7IraYK68UHM73c/nNefEEcbvdAzDp4UoU8ImAjwf9lj3rZ/B59M?=
 =?us-ascii?Q?iTBvQO4TXSIJUolD8SbXtqnJn3eA3EGXvTSbU86ZD3GAueexRaCEKgpguSv0?=
 =?us-ascii?Q?ATa5vDQG8V/YCJW82+YpMmArXhArRx7kcVLGopHNDxgmHH7WCBCTILb8q25c?=
 =?us-ascii?Q?V5eHCOnpSKPsov0KQallhOW5s6WM/Wl+egWIHmFI80kjeQDdY4HAkyvj17sG?=
 =?us-ascii?Q?gUbxXDOeT8xOnFX+PJd4OZHJOhep5FYQ0WK38/kCmr9Tog2KVaNDMeqpqSZB?=
 =?us-ascii?Q?sUS4n0ymNkoyfs2U8rDPTOS07BOlBtNaUOv3eyDhPQqOMAIfMX/tme7h8W63?=
 =?us-ascii?Q?h5fCAu0ytvXGeTXILDUnh90eoMttn4msLEdkrpsHirWxj88jdlHfD4LvVtD1?=
 =?us-ascii?Q?15IingP1czhJ2dsG+h+6m5/5vOpVHxNIaBGqGdWaVhKbI1mIBYZwE6tVIRnR?=
 =?us-ascii?Q?7vcMNvgYBY4Xbr9Etqd35nyS+SfZ2wqHtoDadLiMiyQVDGSz+yh0liNPCty6?=
 =?us-ascii?Q?ZqLxUkLYqOSn9THXwL56A8IOHVALu9Oi9jQeaXpFWBZHptYpNjPXDauubVHU?=
 =?us-ascii?Q?ldanrcpQA+6ItsXcwucwRjM2xmwGLi4v8l4PlC0PF8i7cKRYTl+6FJMDWjui?=
 =?us-ascii?Q?gevbh8z/ydhB/3zgomOat+VbRdEB/+PwHLKuD7di+4FnE5mBDVA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u8PUzdKgsmoaswF3Yclm9JwUnm755qieXrEnaoXLJzsdkOmJIOODz77H+xiS?=
 =?us-ascii?Q?4RWsKUy5lH+tzXOcDl9T8Oi2hTDrbXEM1kcrLogOgScdkmoZIZsQCL+oEmfp?=
 =?us-ascii?Q?L1uUD6o1fM/EK6Zq5+iSAz5hKWVMEQYG+/HWD903paoNDz0dXhUnkyEtSIez?=
 =?us-ascii?Q?8Xv0hwqu0p7/eWk3osGnVCudWfsq76TSlTRHOmfHDGBvOBe0OdS84NbseGsy?=
 =?us-ascii?Q?noVrKyiVweCIPeCwmD7vKX4rbT40p9/FVo0UxtnyCtAO8SuKEnxrEr04Qwh+?=
 =?us-ascii?Q?xWrR1L8pHWKQQbtXM2sQXodoF+v1/OQ949fMU3Sf1zEzDtsUfNQ5Efo1kSv3?=
 =?us-ascii?Q?c/Sn7xcMMogt0g9Mk8GxfShVqGprd/umxW23mIyzjslePJwsRIEBFEMeXrvv?=
 =?us-ascii?Q?L/sDUhcJaYg+MAQmm14+OX188a3nTLITE25CNHhznZACTIuZOyqOAmrieKnE?=
 =?us-ascii?Q?NaEatu73JzrSxdyIISfwD+tga62Q7XtWYWFwqdIeMvbqrK8jNAMg6/CuzpRn?=
 =?us-ascii?Q?J1BezAIFobEzR8ZpHaxbBNe6/hnDEHVQOMASmKbCabwMxyp/Yrc7SKinprWQ?=
 =?us-ascii?Q?x8JlUXaXdnIqlQiR+4ySaTPso4UYDzwbW/TE99xbQsPTpNsS7Kj1hW2JUms8?=
 =?us-ascii?Q?E644vV7nItlgN0UJDsuwv1PiV7KAw5YK4PTQWfe+sl4NcedzNEiz0hwW6Ps/?=
 =?us-ascii?Q?tAYKEX/N1b0d3KDUaLl/rhCh96e3vGy49kc4DrEPRuyaENHxsUxrqsuDkQTv?=
 =?us-ascii?Q?vh7c9n5e1mwhdZiW5EIksOakpYux9whtWwxP+CZQ6p++NreTcsWbxnRPGuJu?=
 =?us-ascii?Q?dJZDMqnQANTplW02RRy1h+NGACJlkJKIrFYP5ngtL7g1PuKoSOSwaU+1if9W?=
 =?us-ascii?Q?YYlWsdKDjilFfop4wfQyBkI8LEQOI2Q+uvV5bQQPvy5TLqKwN9CM/einoCiI?=
 =?us-ascii?Q?pR1p7Lr6zMrhzTTG+8FcNFQFstJmyIf3ltQtOrzLf3U6GS2g1TkevnW0Wgm1?=
 =?us-ascii?Q?/eNcDjctV10Ue0YVVIQUJXe3u0FxsWgRnwd0i0QqCXcrLznzAY22qSpy/FXS?=
 =?us-ascii?Q?h2q0dz50KkmQMhicLiYxdnA+mN4zw2xbqHMCRGoroREmsQUa8nxu7BNuCUsD?=
 =?us-ascii?Q?06xSnS+Q8dmbMgqXqlCiprow5M8LuS3G3C6Bye5GwCCB21XbGg/rir3HvOtB?=
 =?us-ascii?Q?GBvbpsvnaxcTCwuS9Rg21N8h2OsIMRVZmcb2Sgts3ycRoEyJkO/bY9Zr1FWz?=
 =?us-ascii?Q?yzExyLDFH+ZCfWKtDn9XY3eLXzaGtlc8XTutHTvBXCY1SHfBtZxuix4ao4Ps?=
 =?us-ascii?Q?slFgZehDHTTMupxYTgIf48vZcXJTARkkMj/PzA9YmszTgkeHl1anEXqGskSN?=
 =?us-ascii?Q?D2OnErQsakVmGRv0ZpN4QkRsqtOxhgRCFf6kvQyyl2JuvMRVHA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e6220e-bbc0-40f4-4097-08df325bae69
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 05:49:06.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

This series adds support for the FDC1004 4-channel I2C capacitive sensor.
This sensor can report single-ended measurements of any one of its
channels, as well as differential measurements between any pair
of them. It has a measurement range of +-15 pF and a resolution of 0.5 fF.

Patch 1 adds higher-precision IIO_VAL_DECIMAL64_* formats, used
in the driver.
Patch 2 adds the devicetree bindings.
Patch 3 adds the driver itself.

Tested with the sensor connected over an i2c-tiny-usb adapter.

---
Changes in v2:
- Patch 1
  - Added tests
  - Added a fix in iio_format_value
- Patch 2
  - Made the power supply mandatory
- Patch 3
  - Switched from direct I2C calls to regmap
  - Added of device table
  - Removed scan indexes
  - Build up complex values incrementally
  - Adjusted list of includes
  - More designed initializers
  - Various style/whitespace tweaks
- Link to v1: https://lore.kernel.org/SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com

---
Victor Chernyakin (3):
  iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
  dt-bindings: iio: cdc: add Texas Instruments FDC1004
  iio: cdc: add Texas Instruments FDC1004 driver

 .../bindings/iio/cdc/ti,fdc1004.yaml          |  46 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/cdc/Kconfig                       |  10 +
 drivers/iio/cdc/Makefile                      |   1 +
 drivers/iio/cdc/fdc1004.c                     | 486 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  28 +-
 drivers/iio/test/iio-test-format.c            |  16 +
 include/linux/iio/types.h                     |   3 +
 8 files changed, 592 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
 create mode 100644 drivers/iio/cdc/fdc1004.c

-- 
2.53.0

