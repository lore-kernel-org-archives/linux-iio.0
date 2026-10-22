Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792712482;
	b=A+DAKcTiqsfxFFT+LCxiZ8O71PdxqwbOfLHWseXXtmXJtU9FT841WRhkCAS86HlXOdsa
	 v/h86OH6CbPDpInI94xhSEUKX/UQACW9ZAtoutPqNUk9q6oRnMTUtUJqgU4pKFFhZUrB0
	 dvn8DFbqRK3jjoUKsDBDju3LPY3OGE3384WSWzrJCZpGxJQ+qd42U/Quc0GA1CuEyxluq
	 NPXN816TsrSVcBEzaFb43KiqoyimO0zgjOculxAH8+u99Nu+OIEHCveTgxrYXSEPWmDq9
	 MGDyeIUNTciSqSx7U1xVjiL7+xGhihE9+naTCqEF+rAI2vUCtbAw/LCn8eCie6JTsYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712482;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iBMlJ+3jPq+Ui+3WGUbDXbCRhW3sMqO4f0LOCeOTBiY=;
	b=B+QHWRdsc8wYHldOmCuhErn1xKNDRuVz/+CFIlDGJRlrAJh51FkDZUemkCsISCDrcmXM
	 ZblBVYsYHCHPgVrC3rwvIGEHqIMNxvmleWATehAM0AQf1O2+QeG5LftDleB5oxx27spsW
	 vi8M93SbDE7iJ14yyBCnFocJeucbxcuwSENTj+JixtZLaTziwSwPvxx6X+Izdoo43iCBD
	 DxyoWx2z1736PgJOYKd6PL/lm8ZVkg7IbIQ5pZqy8j+c91lGalVZnH2hEp9Dxs+bvG75i
	 5rFD3o7ALtXaRcw5blntZaxRn6lQEqxzfP/e9QI9ZQRrH4nLGukLnbgUgPFxFPTj+hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fm+4wVIV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.24
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011024.outbound.protection.outlook.com [52.103.14.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D2606A31A;
	Thu, 22 Oct 2026 23:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fm+4wVIV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVmjMuW8Ka6BZpSIQ3VqCzvXSVPYi3az+o5Mpp3QRcakCH9F2/pr0+Zu1+cfRykzbDwnfgIMpwjSP1F7NsZ0W9IqmEF5XrLJbqTEbB99Dban1oAbm6o1OrDwy0nnqpGf48rmlSapaRt7/9CwzwxMexPhKd+3D5IAQEYiU8BNKOZqbBvv8UfcTIsgTdW/BqoEXszYs0NngdA6WCudb5+zLXU1xl6SCSSpWro5IPBzQMVr6V8/u/aPoKyP71suxb4FxGlzj6pzg3UYaJfI8ckwd9koSU1ON2yE7PHAlDJzvUZ4cQRT5jVyJcAY26ULj63xelDMXgC233Mr/57FdAa9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBMlJ+3jPq+Ui+3WGUbDXbCRhW3sMqO4f0LOCeOTBiY=;
 b=Wc8vWY55m/+pb1TdpTpmYC3nen6mGxHun4qXz1B/W5+Y+G6xHhI/Co7z9gjJ484s2IT7MJM+1+azCfP65JotBaAWGgm70zuiICP5qL7nEkldZULlCE3lC9o4I+hrHKZtCN+fFBdSU2TNLI670Z/uvip2bsstxnG1I7UKqfmoHmO7bdUbGa7LJP1EgQrAZH6G30p6llr1lYaBb7MC+UXbovb4SVBjlKmqrOaoG418IgsIh+UOZlJeIerZqk98AsFhNb7i/sVUn/MtANuC64uT9FF+JHgM3RnMPczPwlAMP36y1PkpS3U/cVuGn5b4HIg+rFipGd0Oy5z1TZjmWNu4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBMlJ+3jPq+Ui+3WGUbDXbCRhW3sMqO4f0LOCeOTBiY=;
 b=fm+4wVIVxpey9EB5jgkBg4ckB2Kydh+vaNX0aQeFB3kUZoDMv6e78n7QHkXCEtjFp2FpdPKyVb/K18OI+M/rt+vZwXHQMLNit7ieNeOpematZS1Z7Jhb7gzZkaIfyuxSBFUWZDqh8UVsA5uMAPjSv81N16skFV5FvBt6Mo352qzAgphPcPYwvdui/zkr/ISWfq6JcAuKOEW2kQ85eBxeJVOZLisj81RIbDkhV9k+K4W5KpHjyWYMBXMEscBWvlZmEsdbEyUkQ2jTxBM5rSBO1CKw8QX+kirq48FpfXtlVvW+0/sHn9M3EB9GEJCRGgptflE1OZKI+isy1Z3uWU25Mg==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 23:41:18 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 23:41:18 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Thu, 22 Oct 2026 18:40:29 -0500
Message-ID:
 <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261022234041.61995-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 830ce959-ef92-4a70-dcb2-08df3095f856
X-MS-Exchange-SLBlob-MailProps:
	quCBMN2EvO9RNZKwDrK2ljNngOCRvvNQtvi4PanRgu4DlZjWn92ZOpcLAD+pwhfJ9Fb06ICtwicVeGF8XTW06ROFTKoFi0Sd3LwdWV96/35+wK2O1N0gbVmFAaUDV2rzNtuv2YuzMFJ3RYqCFG1+6qtSjYnHOS8Ui+uoAUVjN7wLLhcTbIB0Pn8/37Sj9AUnQ9+hoUmazahU9SGBpVSkKCz4ErzMw4TcL0QT1I1ikeYNzo4ErbiBq1DrDgzOup7lqDOaLIUxW51fP98/DADWjWhMSKT1N3YgYgvl1APqj5w3MiAMDOCKkHY+kOJMbBGfW7JPzGbsd/vMfuuvgeSSPXfX1dhS9FHonBJdK7+V2sVmSWijRgLJn5GFY2l80w04FMqCpc6o5RKE8z+jv/KDcRclBsAnIYY4NbV2/V8ArIRgvzLyT4hRHqbps90RGGkCkauQVUJ5KuSSYIcW0GJ1INDTHti99+961s6hQllByVOF16hlgjM45s8XjdE3k8LRQm1Pnox0I+5yt8SsZ6HCO4EqrJTRSSrTcsFsDakRdMhZQLpCw2JV2tS5s+r7JnAH72Nk+SoGAOtMQ+maSQA+lD8o93HPSbzSkRybsXyKBZXoan67tbBxTU6CYsYmDJ1Gmby6dh4DKYn6IGBLlgVwRCU8bqbZKCmRNvyoVGj2e/zT1hupZ/iRjtZ2JJ58cWFYx8mmyVLX8Y07JL/lg/YEyA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|24021099003|22091999003|5072599009|23021999003|24121999003|19110799012|8060799015|260925184616899003|4140399003|25010399006|440099028|3412199025|53005399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ewxsiUgVY3s8PN8Cr3sJYfH6BavXP46pyJV85TnwlKK3KAOceIy3lSPzUdA4?=
 =?us-ascii?Q?w9ea+d5CuGnewGMtii0gkglaO8LceRPO83IUME+mZFYCA3O/IactcfjsBnJD?=
 =?us-ascii?Q?YOOUbn76I/2fTgyhCciA7tz3o5UsCfPxF/XsQ6qWq5AiIkuBzBzvlhZLQArX?=
 =?us-ascii?Q?+VW5p6b4oDn/Taks6hJnTfPkaTlBK4pwvzhFhwoJi2uOL8jsuIgXQc7ypeRZ?=
 =?us-ascii?Q?mkFz83P3DhxT0gthY7dyC5GnjpGRvr1NughA2D1vJfORSRy+Nh29GetH6h5c?=
 =?us-ascii?Q?DiD3D9e6Fx+wylW6U9T0EiSdL0ZKFvGF+jBSmLjelmfOGAdjJFvdNZnrcDrO?=
 =?us-ascii?Q?TwFTNLQCTUgCgDWisJsQbo7lECVRKVfGZjHcTSc6IFXAhOSiWBmrQQV57byI?=
 =?us-ascii?Q?gPhppEzwcISqWCIiApnpL+9GzXpdLa9CxhLSICgWDD/ih1Xmjht3zpepVLYd?=
 =?us-ascii?Q?OjGC8hXi8tOQDx1nV2O3An6Yxx98ImHh5ThbKPIv6wklZ8gQ/e8jmesMCbme?=
 =?us-ascii?Q?IA7VhGOR/uUYnYWTvwlcOEb4iIjXaeCDEKBki6A8GfcPmkTsb8NFW/n3SIrf?=
 =?us-ascii?Q?/fmtPXUMDFjs1gP+PHQMpmpwbM+o/rUHmC2uR5eVgznxwPsGXItUMwRixSdw?=
 =?us-ascii?Q?Peno419RkQI4Uh88cX5wHM0Z0PzFV1CUGWnmmI5h4pQ/bhWgJMRsVYLXDNgx?=
 =?us-ascii?Q?tIUJssXqNvwGwQorI14tsgc+sr6zHlee9JyuNj0j/IoVg821URB+qspBZg19?=
 =?us-ascii?Q?5dAv2D1westhp9qRB14FJBoo0W/0VkPvJdPd/Ult9iXZX4HyG2w5y2vDBhEq?=
 =?us-ascii?Q?3Jw0EYOoPQ4tkF8bT2TGfbsBKxtBjlsg06jo3OLyPJsnENz+430JAZo04wxc?=
 =?us-ascii?Q?Ij6Hr4TQL0eXNV+KvB02MtkSFTPAUvNZI1ghjUzuTN8HsIYuZq6PTftiGsH1?=
 =?us-ascii?Q?O2/Fm29iUGpLYo9NwUd+KHKVQuARCvSo1FF6kfy91BWn/msZajBqe00H3gOf?=
 =?us-ascii?Q?mZXGq17AmsIJ7e2Ay1NepzcPbg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oexWq6vvqVL/76dHMgmSkAkzSa/sGwub/nO/mpUDkeTZbST3wJ4SizSK1MDU?=
 =?us-ascii?Q?p+tJngZX6gASTOxfZPRmIreLuXX8GdVZzPapamdZgvxNYDjP5vVlWyewl1bs?=
 =?us-ascii?Q?HzEQS0ibcKrxNDFbr4yOAKeL1n7puVJsJIu1wpztKFAeBJTUDIlY5egfNY31?=
 =?us-ascii?Q?EH6w94CA1lo2i6gahcKGyhdyYTjWOPY/sUjVWd6ppWE7VTpX2EUzFdIYvkRm?=
 =?us-ascii?Q?s6D4qMykIBjYKz5aOBKzNYTAff1GhGXCKYf8M1By4+bE6rCEjX7utOWnw68M?=
 =?us-ascii?Q?cke6hrkw2g5uu9vDzmKHJ7IuLGKOYcr/DPAGfUQPMDiVUlS8ZmrCUwn5byv8?=
 =?us-ascii?Q?ziuJYaCKIZHzNvjLtswT/OZZ8pC5Isj/2EuT4x92Wre8tUd1S0CBzjTKcOL2?=
 =?us-ascii?Q?3l4fdimRl/gz+8bDQtks3+LRIkhVzybdTyGrI2XF1WavZoTVM7LgU6myEH8f?=
 =?us-ascii?Q?MH4mkyMNMHgv8z4mp1T3BLluMqG+VgiZttDg9YEkfcvZTSu6450wU5h+I3bJ?=
 =?us-ascii?Q?asD0fM9x9HhR8cpHQFlNjnt0w+oW0GceHFsO0ib3Xuk98z5KVOzTaMGHeNa7?=
 =?us-ascii?Q?byVJvgclj3YLXE/mLQkhn1+CknHSPBHf5zK4fXhxs65vp7K0RVeaSiPCoFB1?=
 =?us-ascii?Q?qcMBGb1S+PC2Gvf4HzUtVad7Er0cc3c4MAliBQ6NopcVN0BPYNIztpd3bZzb?=
 =?us-ascii?Q?WYYf5zYeIknjPUVx5LZToNh+bSzJN29yc75YYNZmfvNwdOf4pszM+oqtkyF6?=
 =?us-ascii?Q?W+YvcVUOu9BFzd0y9CkyfTGsbSSqD+Jbr6HL8XLCCtj2mS+Seh29qIR2cLwE?=
 =?us-ascii?Q?xDUzbAfkGy2GhqV7NSHp9CytY9bTIg9rxhEqCYUjz2uvStko4S1+UtNjHbAz?=
 =?us-ascii?Q?DvlbovvqkLnqjMs75OlHVM2sjVf9dzzelMXnhv1tb2QlwGzkEFJLdY+DAQ5m?=
 =?us-ascii?Q?cbMonstpJkAo4WLjIpT0wl8iCRCS4hcHNdAauQVqZbHaR+nSo5yebK/5uogi?=
 =?us-ascii?Q?6ZQab/GqnBOkpBS0Ls5pCYHS68AvO4al+3zcXe2Y6mZNzj1PTHHpgwuwdDhl?=
 =?us-ascii?Q?DgMwVGfX01K18aa4OpbkGPVU7IaA0t/G70roHRbUeXPTyVV2k+MtGZO1xG35?=
 =?us-ascii?Q?kJD+OXoyKdwN5NdlCqQaBXJR3Vw9D2z8iRYZA2kv2OisSHs50sHXnTmTXous?=
 =?us-ascii?Q?BWrycnWGPWz7pEYZL6iFzndy2mHGloqTNxJ8n0IOrdN4z+88uoCdMUGZ04no?=
 =?us-ascii?Q?L1K9vOkU47XEPj6KxULJBTuEH5p4B3a6bkC3HLIQC86jWr5IOp3cQGkN6SJh?=
 =?us-ascii?Q?FQR9YiHmQHBzZEczh1rgHb8gmSa5qSqlE8OjmUf86D62Xd5BoWl6COtxmman?=
 =?us-ascii?Q?jCQZSJcH8Yje/J9IdvyrN/exPpao67H7HwPXGfj52jbysAgGwA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830ce959-ef92-4a70-dcb2-08df3095f856
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 23:41:18.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

This series adds support for the FDC1004 I2C capacitive sensor.

Patch 1 adds higher-precision IIO_VAL_DECIMAL64_* formats,
        needed for the driver.
Patch 2 adds the devicetree bindings.
Patch 3 adds the driver itself.

Tested with the sensor connected over an i2c-tiny-usb adapter.

Victor Chernyakin (3):
  iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
  dt-bindings: iio: cdc: add Texas Instruments FDC1004
  iio: cdc: add Texas Instruments FDC1004 driver

 .../bindings/iio/cdc/ti,fdc1004.yaml          |  44 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/cdc/Kconfig                       |  10 +
 drivers/iio/cdc/Makefile                      |   1 +
 drivers/iio/cdc/fdc1004.c                     | 460 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   6 +
 include/linux/iio/types.h                     |   3 +
 7 files changed, 530 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
 create mode 100644 drivers/iio/cdc/fdc1004.c

-- 
2.53.0

