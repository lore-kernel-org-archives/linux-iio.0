Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794166785;
	b=46n14Fk+m38oCcXBuLweLd0rOnNFk+rfBUHyrXpcBkYxet3DrEYshIvjIdCy0mpQYgQT
	 XaxLzH0fQ9vvpKSYCbI3JlcEOzESkTU4tlXIXiEdium1HGwDLiXk1dcw7+awWQtEhs0yg
	 zT6TzC30KmGxK3hbxXKNphS0qchBCN4p0sfOhKc+kv0sOa/jkpQsXPeR2gOVFa8Z8e8jA
	 n3dMKVWzy5N0xwiGtEMdwG9Z1/Y9UQc3rNk0VB+8MJK4l1xUqHyWH+Agwe2v7Z8ocW9Ue
	 /EfC8NvRzlgWKPTC+pPrzYtCqpzdxVceQnPr9089bZ+52tffFoK29ufijtlZN16y7kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166785;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
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
	bh=5Ve7DkInzgqDRoyX1U6JXgVZZVuaMUhrDMSvyIrTHSc=;
	b=hpsM6dE68U105bCHIY0wRYti2lOphzSVZ8/Yb5ghTZxQxIluyqkpNdc+akFM1BG3rr2V
	 eoeJ8xcFAsy+WVM8mmawHGjIWuMNi4VStfGiHvdFXyzEizqeB2SVNRBa3ukqi9mHgrU5z
	 4HPB3y8izwVjb2pNsdEXzDJJp44wvkYfsiIx4s7XSDQdUhrd+LkRLJDbKNmeuMWJLhTsd
	 WmKzQKTgK+thjO0ANG2XS26F5yjyGZZHWAGsY+rPNFo6PccdBPRHMstwu7bFFupSD6zP7
	 PhCa3uea/oTeC+bpQrC0txnnd9tDqBzf8R7a4ZqUKQd38a7NRHVxVJhjkO0KmdF0ZWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UO8AXPBs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F6606A33B;
	Sun,  8 Nov 2026 19:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22F6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UO8AXPBs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im/rHTxDKAWETHERPva0jH8xfAadje4zf8rRfGffR3AzZrj7Mgpc/8cM21mS9nsn+jF+DtPqImixOc8EDLQUcc5EMPCGiNCSnS+6ATrWHoS40KgOTWKZFoiyUnO6+BHGKmqkVVknQcI7vK5nsKwMwEDreoCYCG9rmDbDY7I2MYj/MUYHhMLmfW5fJV1b6/x6PasX/FNsjpmuOlZFqM5eHee4NYIp8RVAjAg0nnmBZSui8RpbmQ2XbTxwPw5gcD3KdDHF1+6AuycpXYlIQkYDhPlzevpuD2SNjXybhADTiLhxxYTNen2xGa+HGq31bPZxOHrkxNMKD114uVun4sijQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ve7DkInzgqDRoyX1U6JXgVZZVuaMUhrDMSvyIrTHSc=;
 b=RoqkbqL/5UedumHVuU0Y6IbdiHnZT3uIpYJIVgUmjS8pudaChMXykLixky/yoCr5SmGM5QxJEz4xtokboIa+1n41pHwvBI1dGG9LU+yjwRNRZZ7N1TT83A1hSZn1VPw2f/wpd01Qti7omNrnBsLJKMHpgoIiJ0qxvjO2FVYcAVP3T3DeZynodWlI2lN1l/tLdAtlvPYzt1wFpnielqNM4FC9CfswNkGUX4x+sqwjxZfRyAOS4f5OXiOFt3Wj5nJrGzBF58aK+43mVPc4eqdfsSUHcEXERZeQTOLNbiVRBmtf5JcBHYVCJQvsqHF1qYJKnla6xTT8VkQAYKeR2SWIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ve7DkInzgqDRoyX1U6JXgVZZVuaMUhrDMSvyIrTHSc=;
 b=UO8AXPBsrbdVBTEaB96ymJ5UnPZ4OEpxU0silRXuSz1hHx0wGeJgPqQgDuVkdTnjr+uE3v10OC3+NiNkyji7GtmE223rV3I+qASqYc4fANtlZkdvIDECAwhC+vCoitla8PNd8P7FSfyokjSkG1UlwNNrs7RLfSXim4taSksvV/iWsoIeQEaTXzVXlR7OXzxXwIdLVC15NvWEATuKQuSFXPUAu4CFwSFHCpgD/1toCHjzeoYIUU/g+F4mAetX28x340dCcNkVIl0VkYnQdRJ9ifaYQllJzTJ4cni9SCI+BYXQKBxL4BpQLtQWCHBbyuORSXIYMLF17MrzGKlo4S4KjQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 19:39:39 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 19:39:39 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v6 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun,  8 Nov 2026 13:39:23 -0600
Message-ID:
 <SN1PR12MB25285A6B0032A8A9CF3E9D63A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108193925.977273-5-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3cd137-b340-4ab3-a0c1-08df3dd005da
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999013|23021999003|8060799015|19110799012|15080799012|41001999006|24121999003|22091999003|260925184616899003|4140399003|24021099003|25010399006|16051099003|3412199025|440099028|10035399007|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDbvHPyPg/ODE0R2V5/Kw1r2607aPkTrD2fMpWTNWHxr6q9uG3jMMz4LX4E6?=
 =?us-ascii?Q?i+ampwnYsjE0lum3/oI55VrfVvxZPKmnOXKAeBZPNO66gQza7GddHi+T3XUi?=
 =?us-ascii?Q?8iLZocTo/uHC2h8Jbv4LLyTune5P6yqRIeS6kaKaHf/AxJipx8BhSMlI6VTs?=
 =?us-ascii?Q?94zIK4ri5QtF7kxR2sQopRESgdOzAGxETUl3WZZ5+i960rr0HriqPZsZtcg0?=
 =?us-ascii?Q?lmS8XXEBxWYG4YwqO8EId+OhzbLmMJrIisvj3O42tzQy7Rq1iZMw/iab8Qpp?=
 =?us-ascii?Q?n9gOaC5yyT1siVyzBHtpG8sh9kQGvFmCEh1wMEWJKbUmiFpaxG8ZtFrN5g4Q?=
 =?us-ascii?Q?BUBet4k5mLh9eWFJ1H2MdhKONSuFJwC7mOA8i/dBXT08QyglhJw/kgS34cUi?=
 =?us-ascii?Q?Zjz2Ayxt4J487UkKDIpOKB0A+ryp01hMH21RHWfz2z2sjmUI+1Pj2zOT/eSh?=
 =?us-ascii?Q?F1lgCO8Xs0YW7vLf7bf0AZChIstYOxX7x8D7md4h/o0jGCsdqnKM9NJb7KcV?=
 =?us-ascii?Q?cXFDlHOXghy3C9tYCyFPwbt+bxJkDBpY34N5yzahGRZ0/5lbhU7lrrHv0y6y?=
 =?us-ascii?Q?agY2sTTqXAf/REiXCOwXJoLPQCANb8x62uaGKl1CGP+w3lbuFe+zBulMzaX6?=
 =?us-ascii?Q?qsU/5vLq4J6TnF+yUNePoGEdbR0fztFzXwD4mVPJIMHze2ZrURwGe6ZP/GZB?=
 =?us-ascii?Q?yu0+myOYkz+lG0aQHtzwhMKqx/mhq/OaAJ0oWNh28l3pkKLhWzLSl1q2vQv4?=
 =?us-ascii?Q?AVWDj+rwh7oNQ1c916qo66GqM56XegXBJhlcGVfq0XMbZTYdGuIl92t8wHiZ?=
 =?us-ascii?Q?v4X5qaNNMwLDb5OplreBi06JfBRsC6qJaB+3q16tiapjXkFyRQGL/ubWPfRQ?=
 =?us-ascii?Q?HinIWsQKfJ3aduwnoUAfMw9wnjFyt3vNPj36hroRGeBfZs8x4zXbV/OmlYH8?=
 =?us-ascii?Q?sevADJC7WwxmGDbtHIoDGopsvYvbiE7tzhUJUzVCCZJTEwZLjx4QrI6N+TsD?=
 =?us-ascii?Q?lyHIW1qTxJnKwBLJA0uix1inM1Bwc6ey+LRFJXrggWtOWr4YMB3CANbkBsaE?=
 =?us-ascii?Q?Cvzbh/fQYkkzzhZmF3w1PTkDDxnZgv3fkAlJIc8XMn4CxjohfajstAvYdyDM?=
 =?us-ascii?Q?6IW8G00OJePU0JZ1g7eX5TSRTW9gv2mC1oALf/ZNmLvFigYx1vnort3vNzOo?=
 =?us-ascii?Q?56lQsx+pFT4EIH1K?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CUp1iKddxRNyt6vVJgtrzaAqiosKtMh09cq8pyqF1g3k8qlyrn3y0HXd2EL?=
 =?us-ascii?Q?tza/qFQADGx3s+bDKrN0De3dhE3bcEfXsAeljXe8WnxZtK6vKWp5K6kfE2QJ?=
 =?us-ascii?Q?VZOS/CnTEazZIL/AEJpUdbrigbvLeuOxP7Pqkfg3Xoz01n5mVHnvyxUPWJAx?=
 =?us-ascii?Q?opFcNT7iBiK5JmxbJxXDUElyHKpuUtePc6FYdorVmu9+gCGSLgTxmtVKGmnu?=
 =?us-ascii?Q?c3XMyLJS2DYtNp76yH+ThnPf9N0W9LmDBqnY+v43ahU6hQBhorKUIvkCiJ6K?=
 =?us-ascii?Q?vllT1uVwE49l5iSzGlrQCkWbHwaBuKd68GW4E9pXMoxaRm7YMFkiUav0yuwH?=
 =?us-ascii?Q?qJUyZzo94bIAIXHHqrXqTmZL33A1un6mPBRa2Zbkb6tzBbUY9trJ8y5Ooomq?=
 =?us-ascii?Q?MQ0hNW4XQ8PAiGgzCvYfqnEFJ8BgmnE1k/FSZ9F9SMHTEFk4JB8+o2/xn+po?=
 =?us-ascii?Q?jjbkGUQgvjByvTmPKqjepNnpsSOpjRn9KWZUZB85fPvj8w/k2A2puWOE30PA?=
 =?us-ascii?Q?OMZ5E60Lk1o5hseOsxk1NdWk9g43RNoirTMDI+1HQw8lux96P05/Icreuq5U?=
 =?us-ascii?Q?u8/IXT1FZ/1GK2ZiE+KZ8HmMkY76EHdSf/nITE2weYHB6xNinpuDaxPmVFjy?=
 =?us-ascii?Q?bMDVyqAtnJA5/qS3IjJ+Y+4BN/JutVaixSr63O2X8BRkfcskmwkIPUZyj7Q7?=
 =?us-ascii?Q?lEAbVDvz77/dOp4s6F8q7M276/16L4qaiMRBpPcvn/ANk7BWxxfagFr9WEum?=
 =?us-ascii?Q?X50ii4p04S6SY7OheVkF4Tc12NLDNNGZTuLUgfJq2SELrf9NIQhLS1RmS0jT?=
 =?us-ascii?Q?ed6AMjAIqnLf1ZLkGH7CWiI7vQcDzwk6Jd9zSDYXVIn9tz1msr7MwQn6cEsn?=
 =?us-ascii?Q?NJHZMYd2++gjeqmYjAXi0MywcEcQGB6xSmRwwpjMDf6JDYlQ68/Ph7jF5P8x?=
 =?us-ascii?Q?g8vMV+gXCAVsDMOJ8TKQqKDEktCHdpwbf0oY0wYvnm7vtHhmaTJRR/hVil4L?=
 =?us-ascii?Q?USbQ2t1Ntsniq6pV9NSnFwwyqxu3aP2bea0co5pfZ5xE8wS9SQDdeMcHe9Jj?=
 =?us-ascii?Q?yn97YyxnjFp1IeXRpQmn+ocmbFs8ZNrj8PS1bslTO3xTzvmvnfomD+AMDzFd?=
 =?us-ascii?Q?Gk3B41gVZhDmLSsc1pcLM3FskzXYCk+wSn62kN0hfALavIXVFTdy4yRKLSUj?=
 =?us-ascii?Q?+RpnpcAMWC/628BF/EnLqru7rh8expFLlLmApMwRwCVUU9IOsUE5nJxr/Kt5?=
 =?us-ascii?Q?2uiGM+WdoZarRetkrDT+r9STH/ACfrd2Cy1ngcdi4SYGytJAGegqZThrQ55H?=
 =?us-ascii?Q?HFMVvHc8LwONNaIisWsDmLM9lDK1XlTaLW35kPXgUXKRes7AGgJmJFUs/KOu?=
 =?us-ascii?Q?LM5763KC+EIFbpDlAgnF3aOPxflW5sCSJO2KVl563f8oqhaPWA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3cd137-b340-4ab3-a0c1-08df3dd005da
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:39:37.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

The FDC1004 is a high-precision 4-channel capacitive sensor that talks
over I2C. It can report the values of each of its 4 channels individually,
as well as the difference between any two of them.

This initial driver allows performing single reads and configuring
the sensor's various settings (sample frequency, calibration
gain/offset, etc.). It could be extended with support for triggered
buffers, repeated measurement mode, and/or power management.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/cdc/Kconfig   |  11 +
 drivers/iio/cdc/Makefile  |   1 +
 drivers/iio/cdc/fdc1004.c | 491 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 504 insertions(+)
 create mode 100644 drivers/iio/cdc/fdc1004.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 69c23ae21016..4d926c47ad8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27392,6 +27392,7 @@ TI FDC1004 DRIVER
 M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
+F:	drivers/iio/cdc/fdc1004.c
 
 TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
diff --git a/drivers/iio/cdc/Kconfig b/drivers/iio/cdc/Kconfig
index e0a5ce66a984..1e9015fb5ae6 100644
--- a/drivers/iio/cdc/Kconfig
+++ b/drivers/iio/cdc/Kconfig
@@ -24,4 +24,15 @@ config AD7746
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7746.
 
+config FDC1004
+	tristate "Texas Instruments FDC1004 capacitive sensor driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the Texas Instruments FDC1004
+	  capacitive sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called fdc1004.
+
 endmenu
diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
index 41db756d8020..88253f33c5a7 100644
--- a/drivers/iio/cdc/Makefile
+++ b/drivers/iio/cdc/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_AD7150) += ad7150.o
 obj-$(CONFIG_AD7746) += ad7746.o
+obj-$(CONFIG_FDC1004) += fdc1004.o
diff --git a/drivers/iio/cdc/fdc1004.c b/drivers/iio/cdc/fdc1004.c
new file mode 100644
index 000000000000..57bce00bd500
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments FDC1004 capacitive sensor driver
+ *
+ * Copyright (c) 2026 Victor Chernyakin <chernyakin.victor.j@outlook.com>
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/FDC1004
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define FDC1004_REG_MEASn_MSB(n)	(2 * (n))
+#define FDC1004_REG_MEASn_LSB(n)	(2 * (n) + 1)
+#define FDC1004_REG_CONF_MEASn(n)	(0x08 + (n))
+#define FDC1004_REG_FDC_CONF		0x0C
+#define FDC1004_REG_OFFSET_CAL_CINn(n)	(0x0D + (n))
+#define FDC1004_REG_GAIN_CAL_CINn(n)	(0x11 + (n))
+
+#define FDC1004_CONF_MEAS_CHA_MASK	GENMASK(15, 13)
+#define FDC1004_CONF_MEAS_CHB_MASK	GENMASK(12, 10)
+#define FDC1004_CONF_MEAS_CHB_CAPDAC	0b100
+#define FDC1004_CONF_MEAS_CAPDAC_MASK	GENMASK(9, 5)
+
+#define FDC1004_FDC_CONF_DONE_n_MASK(n)	BIT(3 - (n))
+#define FDC1004_FDC_CONF_MEAS_n_MASK(n)	BIT(7 - (n))
+#define FDC1004_FDC_CONF_RATE_MASK	GENMASK(11, 10)
+#define FDC1004_FDC_CONF_RST_MASK	BIT(15)
+
+static const int fdc1004_samp_freqs[] = { 100, 200, 400 };
+
+/*
+ * MEASn_{MSB,LSB}: 24 bits, signed. Format: IIO_VAL_DECIMAL64_YOCTO.
+ * 1 step = 1/(2^19) pF = 1/(1000 * 2^19) nF = 0.000000001907348632812500 nF.
+ */
+static const s64 fdc1004_scale = 1907348632812500;
+
+/*
+ * CAPDAC field: 5 bits, unsigned. Format: IIO_VAL_INT.
+ * 1 step = 3.125 pF = 3.125 / 1/(2^19) raw value steps = 1638400 raw value steps.
+ */
+static const int fdc1004_offset[] = {
+	0x00 * 1638400, /* min */
+	0x01 * 1638400, /* step */
+	0x1F * 1638400, /* max */
+};
+
+/*
+ * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
+ * Negative values are used to cancel out any parasitic capacitance
+ * of the sensor's external circuitry.
+ */
+static const s64 fdc1004_calibbias[] = {
+	-0x8000 * 488281250LL, /* min */
+	+0x0001 * 488281250LL, /* step */
+	+0x7FFF * 488281250LL, /* max */
+};
+
+/*
+ * GAIN_CAL_CINn: 16 bits, unsigned. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^14) pF/pF = 0.000061035156250 pF/pF.
+ */
+static const s64 fdc1004_calibscale[] = {
+	0x0000 * 61035156250LL, /* min */
+	0x0001 * 61035156250LL, /* step */
+	0xFFFF * 61035156250LL, /* max */
+};
+
+static const struct regmap_range fdc1004_readable_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_MEASn_MSB(0), FDC1004_REG_GAIN_CAL_CINn(3)),
+};
+
+static const struct regmap_access_table fdc1004_readable_reg_table = {
+	.yes_ranges = fdc1004_readable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_readable_reg_ranges),
+};
+
+static const struct regmap_range fdc1004_writeable_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_CONF_MEASn(0), FDC1004_REG_GAIN_CAL_CINn(3)),
+};
+
+static const struct regmap_access_table fdc1004_writeable_reg_table = {
+	.yes_ranges = fdc1004_writeable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_writeable_reg_ranges),
+};
+
+static const struct regmap_range fdc1004_volatile_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_MEASn_MSB(0), FDC1004_REG_MEASn_LSB(3)),
+	regmap_reg_range(FDC1004_REG_FDC_CONF, FDC1004_REG_FDC_CONF),
+};
+
+static const struct regmap_access_table fdc1004_volatile_reg_table = {
+	.yes_ranges = fdc1004_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_volatile_reg_ranges),
+};
+
+static const struct regmap_config fdc1004_regmap_config = {
+	.name = "fdc1004",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.use_single_write = true,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = FDC1004_REG_GAIN_CAL_CINn(3),
+	.rd_table = &fdc1004_readable_reg_table,
+	.wr_table = &fdc1004_writeable_reg_table,
+	.volatile_table = &fdc1004_volatile_reg_table,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+struct fdc1004_data {
+	struct regmap *regmap;
+
+	/*
+	 * Serializes accesses to the chip's measurement and config
+	 * registers, and to the other struct members below.
+	 */
+	struct mutex lock;
+
+	u8 offsets[4];
+	u8 samp_freq_index;
+};
+
+static int fdc1004_soft_reset(struct fdc1004_data *data)
+{
+	struct regmap *map = data->regmap;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_write(map, FDC1004_REG_FDC_CONF, FDC1004_FDC_CONF_RST_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
+					!(reg_val & FDC1004_FDC_CONF_RST_MASK),
+					1 * USEC_PER_MSEC, 200 * USEC_PER_MSEC);
+}
+
+static int fdc1004_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+	unsigned int reg_val;
+	u16 reg_vals[2];
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		iio_val_s64_decompose(fdc1004_scale, val, val2);
+		return IIO_VAL_DECIMAL64_YOCTO;
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
+
+		/* Configure the measurement we want. */
+		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel) |
+			  FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2) |
+			  FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
+				     data->offsets[chan->channel]);
+		ret = regmap_write(map, FDC1004_REG_CONF_MEASn(0), reg_val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Start the measurement. The "+ 1" is because the chip
+		 * wants a 1-indexed sampling frequency.
+		 */
+		reg_val = FDC1004_FDC_CONF_MEAS_n_MASK(0) |
+			  FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
+				     data->samp_freq_index + 1);
+		ret = regmap_write(map, FDC1004_REG_FDC_CONF, reg_val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Wait for the measurement to complete.
+		 * The slowest sampling frequency the chip supports is 100 SPS,
+		 * i.e. 1 sample every 10 ms, so our timeout can't be shorter
+		 * than that. Go with 40 ms to be safe.
+		 */
+		ret = regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
+					       reg_val & FDC1004_FDC_CONF_DONE_n_MASK(0),
+					       1 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+
+		/*
+		 * Now read the two registers making up the measurement.
+		 * The datasheet says to read MSB first, LSB second.
+		 */
+		ret = regmap_bulk_read(map, FDC1004_REG_MEASn_MSB(0),
+				       reg_vals, ARRAY_SIZE(reg_vals));
+		if (ret)
+			return ret;
+
+		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&data->lock);
+
+		*val = fdc1004_samp_freqs[data->samp_freq_index];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_OFFSET: {
+		guard(mutex)(&data->lock);
+
+		*val = data->offsets[chan->channel] * fdc1004_offset[1];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		iio_val_s64_decompose(sign_extend64(reg_val, 15) *
+				      fdc1004_calibbias[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = regmap_read(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		iio_val_s64_decompose(reg_val * fdc1004_calibscale[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const int fdc1004_calibbias_decomposed[] = {
+	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
+	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
+	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
+};
+
+static const int fdc1004_calibscale_decomposed[] = {
+	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
+	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
+	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
+};
+
+static int fdc1004_read_avail(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = fdc1004_samp_freqs;
+		*length = ARRAY_SIZE(fdc1004_samp_freqs);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = fdc1004_offset;
+		*length = ARRAY_SIZE(fdc1004_offset);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = fdc1004_calibbias_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibbias_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*vals = fdc1004_calibscale_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibscale_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_OFFSET:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+	s64 val64;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (unsigned int i = 0; i < ARRAY_SIZE(fdc1004_samp_freqs); i++) {
+			if (fdc1004_samp_freqs[i] == val) {
+				guard(mutex)(&data->lock);
+
+				data->samp_freq_index = i;
+				return 0;
+			}
+		}
+
+		return -EINVAL;
+	case IIO_CHAN_INFO_OFFSET: {
+		if (val < fdc1004_offset[0] || val > fdc1004_offset[2] ||
+		    val % fdc1004_offset[1])
+			return -EINVAL;
+
+		guard(mutex)(&data->lock);
+
+		data->offsets[chan->channel] = val / fdc1004_offset[1];
+		return 0;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
+			return -EINVAL;
+
+		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				    (u16)DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
+	case IIO_CHAN_INFO_CALIBSCALE:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
+			return -EINVAL;
+
+		return regmap_write(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+				    DIV64_U64_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_debugfs_reg_access(struct iio_dev *indio_dev,
+				      unsigned int reg, unsigned int writeval,
+				      unsigned int *readval)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+
+	return regmap_write(data->regmap, reg, writeval);
+}
+
+#define FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(_channel)		 \
+	{								 \
+		.type = IIO_CAPACITANCE,				 \
+		.indexed = true,					 \
+		.channel = _channel,					 \
+		.channel2 = FDC1004_CONF_MEAS_CHB_CAPDAC,		 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		 \
+				      BIT(IIO_CHAN_INFO_OFFSET) |	 \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |	 \
+				      BIT(IIO_CHAN_INFO_CALIBSCALE),	 \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	 \
+		.info_mask_shared_by_type_available =			 \
+			BIT(IIO_CHAN_INFO_OFFSET) |			 \
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |			 \
+			BIT(IIO_CHAN_INFO_CALIBSCALE),			 \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =			 \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
+	}
+
+#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_chan1, _chan2)	 \
+	{								 \
+		.type = IIO_CAPACITANCE,				 \
+		.indexed = true,					 \
+		.differential = true,					 \
+		.channel = _chan1,					 \
+		.channel2 = _chan2,					 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		 \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	 \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =			 \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
+	}
+
+static const struct iio_chan_spec fdc1004_channels[] = {
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(0),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(1),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(2),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(3),
+
+	/* The sensor only supports differential measurements where CHA < CHB. */
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 1),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(1, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(1, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(2, 3),
+};
+
+static const struct iio_info fdc1004_info = {
+	.read_raw = fdc1004_read_raw,
+	.read_avail = fdc1004_read_avail,
+	.write_raw = fdc1004_write_raw,
+	.write_raw_get_fmt = fdc1004_write_raw_get_fmt,
+	.debugfs_reg_access = fdc1004_debugfs_reg_access,
+};
+
+static int fdc1004_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct fdc1004_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &fdc1004_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return ret;
+
+	ret = fdc1004_soft_reset(data);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "fdc1004";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &fdc1004_info;
+	indio_dev->channels = fdc1004_channels;
+	indio_dev->num_channels = ARRAY_SIZE(fdc1004_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id fdc1004_id[] = {
+	{ .name = "fdc1004" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fdc1004_id);
+
+static const struct of_device_id fdc1004_of_match[] = {
+	{ .compatible = "ti,fdc1004" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fdc1004_of_match);
+
+static struct i2c_driver fdc1004_driver = {
+	.driver = {
+		.name = "fdc1004",
+		.of_match_table = fdc1004_of_match,
+	},
+	.probe = fdc1004_probe,
+	.id_table = fdc1004_id,
+};
+module_i2c_driver(fdc1004_driver);
+
+MODULE_AUTHOR("Victor Chernyakin <chernyakin.victor.j@outlook.com>");
+MODULE_DESCRIPTION("Texas Instruments FDC1004 capacitive sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

