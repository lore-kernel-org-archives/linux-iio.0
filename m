Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979724;
	b=CDEM0cPe4ArpcEvHF/M2gHZSoECaFvE1oRuGh3kLRKOQxoTvcHxDoMIe9y8M0HOP3PDL
	 p0SPJin9xjyO4gzHt0mmXO1oHny3jbK53MXuxlhFUwB9G1b1+RfkTDy4mJNN7hpYhBhyT
	 9Yj6rKxyZfeiLtUtBfimrF0LuhJiKlNeblk3Cec5d0n0pg6bSuKr6f+1P3CjL1YnVRcGG
	 rwS06B3AGBTkZBsRkg7o5E8YC6a+6twVMawMd/1ig4K1W0nDrgOc61JMqj0okCVVKIeDE
	 SByvMJYu4BsLzcFrj53G8EsVT/IAtUpofl28dtZPRAcMcLlnsKyI2JXKKxHVyZ1ZxSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979724;
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
	bh=EVq9NkeNbf2BVon0DkB+sRZzgUh1/U8nKamsVvKqRtU=;
	b=sxKF2gnra7Pu45wL/tfhtIKEXxg7puJpuL1Pwyv8uGDCkZbhRyroQ+oEP8ahUTHfExip
	 RxSN980dg3CgrIvlHBCBkW0a/2Llbi4nEwZlK9Z86EOHf2iLFltHvgbZs+Q2qNMRaAzCd
	 GzCyxOZPqd3ln3ymcaRTUxCy99386apZ4/bsgIqDQkGVCgoTU967bC29TBiLHMP6Pu/zj
	 nWXpQLlHyfNPKulajkcWCN+ELS5OGDT2VKIoK/IK+TTyzc157GLkhbI8fKvn51NWtarz5
	 mFgahHIukZi5MJqNJm/hTnTlpjXJGntABTSxhtRZ6Npt9U/TCjw1KI05aJtTMzzTZdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Xkpk7d7H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010020.outbound.protection.outlook.com [52.103.13.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB14606A329;
	Fri,  6 Nov 2026 15:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB14606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Xkpk7d7H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbt7qlcDxLK61BcJxtAvtXpiPdcufqgqUrecLaSumVAaldQ8YISo/fx6jlCOfTFB0AIGRpzVA7J3cP5oxrm6h+ptS9w5ZylZRlwVZaa5hy5rlti+UBDhlGKGpoRleEz420XPPGC8sFmWXQlxLJcCx2DJkngfotRGou4PlAN0xK4oRLaNimR2HqgzrZ6GJrEVCR2f6Nc53jRck9lvjGEHxJIqQetq2/WYEUUua1jwalZEQnIvt6zVG1K9CJMh6GSHv+XrFuU1DeXjHJCNIRi/NZTcDTDLXgs2ZWBy33dugZcxHr3RwA1xz20ER8r87ik7iiXqPAyveUqPlBxd37Pk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVq9NkeNbf2BVon0DkB+sRZzgUh1/U8nKamsVvKqRtU=;
 b=UI7KcwZsleAA/URMNTXPiucXPeampY/3S64ysk2nvT5pJs2FGENEXbLQoKSIl5KVL3cVzCjnbgks3LKfNha3WIPG3iDvTNufUe0/uEXHujvIh5EVfGWFZhcsKBnS5i9Q4/DFv1WiqvaHr76hMPX6doBL1ljwIAO+Tl4ilRJb1JIXgCMxK7OhCO8+2BGY8Bk5Ck37gMzv/lfHz7jKq27oe1GokHGctx2DFrYhsD58M2KQwKF4Cw81ZCYjBETWljvBBG+2pA7ma7GxU+GHICMNv1E+3T8wLZ66wG+42xU3hVtETvb8tZuHq4oeG9eccm631ExdGKjtKB75tcnwRTkHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVq9NkeNbf2BVon0DkB+sRZzgUh1/U8nKamsVvKqRtU=;
 b=Xkpk7d7HJEbNU2SEbO3eRORhIiENnfs7llQu7o5uPL3eLvrtMui0st+8nTZx613vytmxN+F2lRVEJtdxcCJghlpyM5/xELpHq6vtS3iTl1sNSHXMJbLESxJpNddkvpm1aBMugcrbF98CsvGBb+dDDiGWdDLuR62gOR+l05aJjKD4rXF069XPkjKjPYb/c+3UmJ1Mctj4RDSiDei/ir8Pio1qq1gt1w+hGr7zVAn6p6oAVIumgeF4b9J6DMfD95FzUAmQliswBqxcyCsr8Z+N0o4SIreMIWhT6xYqkl/R/JL/eNIFv6jejpo0QHp7mzzglAGNcgThmE+U9yMp5BKH7Q==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:41:47 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 15:41:46 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v5 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Fri,  6 Nov 2026 09:40:25 -0600
Message-ID:
 <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261106154136.804370-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 072bb235-733a-4307-e4f3-08df3c1c7670
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|24121999003|5062599005|22091999003|24021099003|15080799012|260925184616899003|8060799015|19110799012|4140399003|25010399006|440099028|3412199025|4302099013|1602099012|10035399007|53005399003|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0LEWWxMj00MeP1svfcRCX+Nif0rSL/22981owSl3iyrHZa1HZS3L5Og4V6xf?=
 =?us-ascii?Q?oI5anEhU+0xzZkYm1DlutowW2Rj4QN2SKG1nkrnzEg0fCevl5fCmU6RxDGcZ?=
 =?us-ascii?Q?oOf5IotVQCoSZyIJMAN1OOrlDHMetK7jE31Wy0Hm2xCGAertuXxC7gtDjrAw?=
 =?us-ascii?Q?/poeNPfhpFrUfgyOMiRLk3CkcBOC4ceDwGq/8Are3R+Ac5HPdLPoooJrBp4S?=
 =?us-ascii?Q?KdGeq3pAk2LldrKJ0BZTqYNqMPA4vDpFDfoSVNgVEt9CVObujBU8xgeIAX4A?=
 =?us-ascii?Q?ts8lTtuaCRj/If1XscDJqgQFCbuXYwCOHVWCCkwErBYazMIBAOBQ/9Qwvst4?=
 =?us-ascii?Q?HHLvf6kmltgeG/TFR9QnILp3cwVfB6xz9v1bvVDwqK5fMAbUK0yBAld5W+s2?=
 =?us-ascii?Q?+I73tSucYTQkDs6G5ZMDXUSd4jLddpxtJ85MgB5u4W61BoXDk1mDZgJY1w9U?=
 =?us-ascii?Q?oEamjotIXcgBiY/KsQCGBDe5JxXmkX+wHvoS0+Tkze5K2L4JlqZUB4TXA11z?=
 =?us-ascii?Q?VDTe0dKrcjtFZrO5Lt9iyX9syLwro74TymJhOQcAaJi5syMRwzov28B312gb?=
 =?us-ascii?Q?rlg7jobXKKv3KazH9OkKPFGom3SocnNGbccnzvxSpFrj9VLTMyqfAlFb3EaC?=
 =?us-ascii?Q?RzBvLMmjHNc/liAYy0Il/ulTg0vWC9KrMjadldi38rfbeSHYeYtAU0hKX3Jr?=
 =?us-ascii?Q?k3QG66ERJylhKq64vZKcTyiCxEIdt0cDOjM2nxOPKAbMDEYpfKSrdLY/928h?=
 =?us-ascii?Q?K0YgbiXe9nmmadrR4C2qvPl5xEGvJNApfbtFJtFahxvqLOXcpJZhy60UIoyZ?=
 =?us-ascii?Q?OeCCKmX5PnZTDGvy5bVkghLLXAzqPJZbstwtzAefpm0uCB6hWa7UWsPLc2CB?=
 =?us-ascii?Q?i9iFn+NyXeiclYeqYu3vSdNzKpA03ZeEYOAVQbePG0gSIO0SuBamPJPlOT4W?=
 =?us-ascii?Q?jjcgRfEg6zvjBWeRc7mEM84VIF+qPMFN6NiiT/ZgZVZ2I5Ip11EootxKQ+oO?=
 =?us-ascii?Q?RgaNq4ZgwRzufnJvhSUkslAaL0IHRVKTPqobgx1JuxBM/QeNS2RKOXVBCUnf?=
 =?us-ascii?Q?XuxgvLYAczXtiQ0ITfQ0dGjKrJrVKhKVT4tqN+GSroRyp2TdUg95w8uSLFDo?=
 =?us-ascii?Q?sVdo2mgdYxBb?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FzHMQBvfNiREbIfmriNnSKoqEQEqR74fwnqxoAOEqpD9zuLu4Sr17pz60xb3?=
 =?us-ascii?Q?gnVf9hQ7KlBAaA7qu4Ke+gMk1qk2baWyMfM0vPhGq732XZCookoxvmeGIvq0?=
 =?us-ascii?Q?L7N23JiEhUMOFc/fCA3Qz8ZVl54S+yAaPVS6/ibwaWiDmHjVsG1ZCAmgE/GS?=
 =?us-ascii?Q?+pHmzlrMB/XxBztSugucchS3R+mPiLaHH2OSvkrwc53NBo8UiQoeQ53x/mpZ?=
 =?us-ascii?Q?19XwDQEgolV43h13NzcfiVH9qE3alToDPdr6dHj5hY4naQI2jSI2xnfdzieX?=
 =?us-ascii?Q?P1W67/nnmLGp7KxM2HYBe16R2jRPXRDvFSeoCPbadZMLfP/XvvFMMdQRP/rY?=
 =?us-ascii?Q?fLpnz/6UetJ4QpVrl4mI1oJEbel9baLUDSJ31zncVYpN6if0zz06pw+r50z8?=
 =?us-ascii?Q?C6174hPYFFd+aRS2g1g1+RGTrz7JhraGvoCy95s3gpoWrveN09ZPgqJfEcyg?=
 =?us-ascii?Q?kwxDyPOidtGuS14dq1ImGa/X1WEQcCw0RhD1E/sEVtNDBBcwM7KVRqNLFsan?=
 =?us-ascii?Q?KN7spfIc7ex/geYIgWu/dL+c06abvIDV8KKSqUKfOEu3C8Q3SDXPOHVrmm4V?=
 =?us-ascii?Q?TFeMgAg8dFUTt8tATu0v1MeatIuoOXYmRaGMzIAhlaphHBES5NIYBaiA5fwI?=
 =?us-ascii?Q?rm8PH7xBNTdvNH9N28sUrx85WoKhAWkVeC+l6Fl0v6BkIJ/BynuXdDFQulHZ?=
 =?us-ascii?Q?SjA2JFhGR0ZH7HSQoASFKmjNsUek1U6UDvknxr/+r+JzE2e5f2/uoO5rSuEk?=
 =?us-ascii?Q?BYPFqrmMGysZqHJy3mUEuAYYU9YLP4FtdcqL81QJwmCN3y6pRraePzNDwzyB?=
 =?us-ascii?Q?2Abimgf81cBKz99HUpcFTqYezMbM7sq5suDmfhJTkKu7GIAd6AONQSokCYLN?=
 =?us-ascii?Q?LYNrEJP82xPHsBzjF3WMMeLWSW3vxn18L9WzkGZsXVztQKiN9tBWLztYTjt8?=
 =?us-ascii?Q?sr+mv0U7p249PoGoAHXP5jWWx2nsRXxv9JLFghW33wVuzy1aA7Bj8IcHBOCO?=
 =?us-ascii?Q?VmM05XxiCJIUC946fSvuXjdC/VvJZu8aH7xwDyFn632MTE657tpGF+TqakAm?=
 =?us-ascii?Q?kTtSl9u5owuyAp7meO1fAKriW4/SMDk8wA1ip6r8GlDgSZ3KuCcuLoChsAUg?=
 =?us-ascii?Q?Q1scJT1J2ndw6IdM6T5DOc4hKOBLNm0/FmKeWHvR2gY8L+Z7AEB7d6H70PpL?=
 =?us-ascii?Q?/udnwxEzhLFNEvXiYNKgyJFpTyTO1Jp2KEgePZ4KS/rGZktz7H2MGbXxJR4Y?=
 =?us-ascii?Q?PtrGa80DX+Z+8S8mtx2tzs33X+DjWZOgOvlqFwNXHZgEUYoqhINYl5xC4+QL?=
 =?us-ascii?Q?7ynTKJcnk2xgUAzGHrFhv14WG2rBbE8R1TraAOMebtNLzdN0xnml/ZpSKH9W?=
 =?us-ascii?Q?fU109YzoVEJdJiHUuaFJNiNPBwLmayPvrgI+Xq56VSI6wd+eIA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072bb235-733a-4307-e4f3-08df3c1c7670
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:41:46.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

This series adds support for the FDC1004 4-channel I2C capacitive sensor.
This sensor can report single-ended measurements of any one of its
channels, as well as differential measurements between any pair
of them. It has a measurement range of +-15 pF and a resolution of 0.5 fF.

Patch 1 prepares iio_format_value to handle IIO_VAL_DECIMAL64_* formats
introduced in Patch 2.
Patch 2 adds higher-precision IIO_VAL_DECIMAL64_* formats, used
in the driver.
Patch 3 adds the devicetree bindings.
Patch 4 adds the driver itself.

Tested with the sensor connected over an i2c-tiny-usb adapter.

---
Changes in v5:
- Patch 4
  - Fixed 32-bit build failure by switching to math64.h division functions

- Link to v4: https://lore.kernel.org/SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v4:
- Patch 1
  - Moved the floor(log10(S64_MAX)) constant to iio.h, renamed it to IIO_INTLOG10_S64_MAX
  - Added corresponding floor(log10(U64_MAX)) constant

- Patch 4
  - Added "select REGMAP_I2C" to Kconfig
  - Style/whitespace tweaks

- Link to v3: https://lore.kernel.org/SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v3:

Split Patch 1 into two patches.

- Patch 1
  - Expanded the comment above abs_s64_no_overflow()

- Patch 4 (previously Patch 3)
  - Added comment on what a negative capacitance bias is used for
  - Reduced some line lengths by introducing a variable with a short name
  - Joined consecutive assignments into single ones
  - Fixed indentation

- Link to v2: https://lore.kernel.org/SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com/

---
Changes in v2:
- Patch 1
  - Added tests
  - Fixed overflow in iio_format_value on 10^scale and UB on abs(LLONG_MIN)
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
Victor Chernyakin (4):
  iio: prepare iio_format_value to handle higher-precision
    IIO_VAL_DECIMAL64_* formats
  iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
  dt-bindings: iio: cdc: add Texas Instruments FDC1004
  iio: cdc: add Texas Instruments FDC1004 driver

 .../bindings/iio/cdc/ti,fdc1004.yaml          |  46 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/cdc/Kconfig                       |  11 +
 drivers/iio/cdc/Makefile                      |   1 +
 drivers/iio/cdc/fdc1004.c                     | 490 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  30 +-
 drivers/iio/test/iio-test-format.c            |  16 +
 include/linux/iio/iio.h                       |   3 +
 include/linux/iio/types.h                     |   3 +
 9 files changed, 602 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
 create mode 100644 drivers/iio/cdc/fdc1004.c

-- 
2.53.0

