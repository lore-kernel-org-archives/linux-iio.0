Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794168674;
	b=bYXz1ehBmRwlRxsULIhlWH5oChg/c0X10NW6cbgUi4eDNydp5qW4Begk5nyRPtypDxDZ
	 Tr8ap7eJ3DCVw0VexXLCbsMXQTrkgUUiH/HgDJAuJ5EGxZB47IgR1dIMO9izG9exikBLz
	 Kd6JyS6R5ndfbahWZxqdPtPLW14iEPWNMg7BgEJidCPc+4Sd41WBHxZ9lGg2uSVjiPBzP
	 AzwIpopBkiCxyJHwk1mp1jMaZBM6rc5P29QT8qoHQYU39wO/zCzh14MsIROXJgHzWoHfj
	 d7TvevpUVupJF63gyy18Z/1pnihyluDR5WYWwBqghxbKIXrwu9Ya0zS3KX7D/pMsyEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168674;
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
	bh=m5QA+5LSE1CxmFcPuh9KOCDP6cfYf7Ewx0axxwTAt64=;
	b=QoXj6qRRQiNFxniJv3bkXWjCCVkHd57vsdBIPBNVlARR2cSeLCnMZmXph1DMwm1csO1J
	 NcSTh8oD8z4LqFGwzyZS6OpcIc3WFpQbHyLGwDh3gQk0doLdzYf/z/koIP563yzcUI1qf
	 c5TldcgJVnvSwoz0OIiD6Pas2DS5k+QLod8UyBzcs90YeOdRgS6+g7eosZCjaVc8WTa7B
	 t3QS19LX/fAyJ+CYWC5ZaHbiIH8lKANvig2ycqTHWP4ijFFfRBD9NP4CM1MzCCSrfs8iF
	 1b1bR1Sv3tg/XkMl68zq7Fh8nAE+HwYdSC8lSqmmOEFbkNY/edfx2AB1S2WqYlKwZbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Jx17jKUg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.2
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010002.outbound.protection.outlook.com [52.103.13.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDC606A31C;
	Sun,  8 Nov 2026 20:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7DDC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Jx17jKUg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCIIqvaUDXkxc0WK6Ght0YiR3gX9Mksudj57efK76DrBoN7/K3+JseHigKv87pGhoNdrF1MWKjiDjqFdhsXj6e1Q3X+xk51PzVGD4qb7A/ZUWayGJd9U5bBf9cEc6e3qX0KSsWj75VMkreaGueJCBs3rVMxOGilkuahYUzM8lmdv8lKkQcuwXbAwa3QYHOy1/ackiw0zdTHC4NiUaSJW05NnSBGYz9BemW5o8L81d/oNxfX/YiXSzfI7GzzElnmIiUOfVeSJsBrvwERmHWe0vQLe9LKoy4KBMT7Erc/c4Dq3XFUvyxFlBc2FuqkE0qoMQj+2K8NrwjK6/nK+/DGH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5QA+5LSE1CxmFcPuh9KOCDP6cfYf7Ewx0axxwTAt64=;
 b=T/T0XbyM8ApxH3ZG9vwS/Nl90vnW9S4MMGE2N7toCuKIprrnvXUVnNWkVR/1NDhWN/Rku1fzk9xwXap+ckNITbxk7hoS4oxybfYaEhk/JOePL+utfsRMkbo2n6NTBuRJTrd1UVIrSBNuMJ7AM+HK52lYG6ib2EeSKOAx3BznGFmQbOx77F8duWNYJCU1Y3fq97UBeGEkqk17XuLJ47ytmrsSabHzjvt74ugKdbDzaeAGP5MP9G+XNdvLiI/IPzsVTkiEFDYl/meFXR+l4zNTUN3SBdqJ+FhOzwBUvc4TfhGAUfWPqDiul0M986E8BSqHVTx0mB7eIYaVKUcNzeiWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5QA+5LSE1CxmFcPuh9KOCDP6cfYf7Ewx0axxwTAt64=;
 b=Jx17jKUgpdhscC1pqGA2DUurFTdBfnu7C5kbNcRmXQCRjJ46NWNowQxRUrTMWhhMWNOFw0J46CedGaR62cKSOJJMAnde2n4xfUNIcdz0uXJ7JQS+d5Gnqp0YtjhRrS3x5z7qdOJNiHholxx6BeautABNDvd0LAWBIyLp/JYaVYZ24+q4ks0xdZtYhjZC6HQMze+vJmde2wmXl11bV4s24digfRnfav2m5QqjT5tZCF++dJrtcXNsgqn1EuvzSOHVFJSh9+Xs+14VMLDYSapVrY6FdKhW27A9l6H5d+79HrRpd3iALt+y2srmG5fckEyKhLcT7UGAa4WQnwu/Tf+sxA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 20:08:45 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 20:08:44 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v7 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun,  8 Nov 2026 14:08:25 -0600
Message-ID:
 <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108200835.981970-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a07629-f415-4a48-0835-08df3dd41757
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|16051099003|25010399006|4140399003|24021099003|5062599005|24121999003|22091999003|23021999003|5072599009|15080799012|8060799015|19110799012|1602099012|10035399007|53005399003|40105399003|26121999007|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tc4C03jjebtFNyjZ1LBld9/3LnWqfTmor7yKJ9I1v+hd2VxHQefdL4Syn8Pd?=
 =?us-ascii?Q?IUiw3Tlui53FLys/9fVWZN5ymS+m5JHZxo/R/npbbdGGddaPEBJBh08r2i6W?=
 =?us-ascii?Q?o/YmUQJrkHFNm+rPF+gwp4AZ4MEenbGli4gU6K2WwfZyBPtnwAQN0gH34ZrS?=
 =?us-ascii?Q?nb75cYcMIRDFj4sZvyyRw12xJtAz6ETsAC4SHQ0Lugza+5NNxLjewfdwqQhI?=
 =?us-ascii?Q?x3b30sLp9jMC+G25wmLUIWFM0krxDcs7j6a33D2z39Z9S9XzbSqxSMmC/Hof?=
 =?us-ascii?Q?Z2H6MjiiA1NxeRExqR2tQeuRy5rZyqtMmkS8+BWWaOec86AVg+KIeaIZstnJ?=
 =?us-ascii?Q?ZBz4WzXgbQK5+pW5KzX7r4GJNYS4OCzPVFOKvwNyQBmDJi3iPfwq6O3igzS1?=
 =?us-ascii?Q?767evLYw6Vqk1lLVOtaJVqrGeeP6xCqaECwYdEVxhfzRJ448UfPEmgsesJY+?=
 =?us-ascii?Q?2/j1Os+MnKTvxBWh6QMmYaQq5gjdfvZQzWpI2se2e8cwwXBWrknAkyL3Y4dp?=
 =?us-ascii?Q?jiXxCdnOo738mWlmqgUWiCsXqknbd5z46T31icjBT8+Xk1WrSn8SKOS4irEm?=
 =?us-ascii?Q?Ext4BJg/QhDrvhBFPGG8fjFHDeEZrS8YbTP/5dvktNf45OnozzqIHjSiRJdA?=
 =?us-ascii?Q?+gXgwzaGH4kxJXmBJMjrPzTnwzPzo8Ix9YJrg1DpJiGyly8D86x8uQYlW23D?=
 =?us-ascii?Q?z1+o0gUjlLH3x7VKyLV8l3WMyn8jSqkaB/UdLan77IBqsnTiw5AzVkn8yeTw?=
 =?us-ascii?Q?qlc6LWkk113EWDCOLCL5j2N1nqW+BP+ZqN4JaMLG4sdLSuq73RCIn72CEvDr?=
 =?us-ascii?Q?O39RFM0bo11OTKE2GlA6jSAOQxu6PaN6TZlMqSqHCpkEoKpT2Bm+p6wZgnUP?=
 =?us-ascii?Q?NPW/tmxl7WFClfwbsEikY3taTJDHxuRjMvU4oZpJg7cXbrEutKQ89ZSe3PcY?=
 =?us-ascii?Q?OAJLgdWlR1vnrUkNSHYSKajlRikIK030aQY1miLOR7ZtbcDlKxrVjtePteyE?=
 =?us-ascii?Q?buA138F34iSBL12umVBcwmpbpQiJBmo7GbiJbSGS+7l/26uXUHEKQsgPr6uS?=
 =?us-ascii?Q?NmemPEuk+AYw0tH2dp8tdvIF+0WAP9dwl7g3M5/utozwvW8vyNyPUeRHVpTI?=
 =?us-ascii?Q?kna24kSpZUV5htfnCXcgjv91lZT+eSP4iMbyqcoOEJ48qJkXV1IQ5Vo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cqcboRQPW4KFciAjSG/3nyXg8mK0bgsHjJ5SbkDSZnoWtOLG/BDqxE+rTIDB?=
 =?us-ascii?Q?sTkIRaqSJ5OK734HOt4yfP9XR7mGVNZjB7CeXbXNyrG1ObkU7IqdVw3M3FV5?=
 =?us-ascii?Q?emGQMGflkyIvgFvgonkvYtbHrNrCU8J3AhUqRHakHcL5FV/Dh9kx/KvWh9ni?=
 =?us-ascii?Q?vyr4pie8AKMsT2Ty0ov0qwjpeDCbjUSgyLuid2ckhQ0wrVMjeZ09nUIwWgOw?=
 =?us-ascii?Q?CFZIF/lt71lD1B2LcvbnYje2a/s1apklQ/inLbsYDJnr9vVroW3wnVEa28ew?=
 =?us-ascii?Q?GdrXBJTnmoQAcQ1xtU/khdofb+aiJxrYEcApS8br2P+e6BUKfU+hc+apCqlT?=
 =?us-ascii?Q?G5UJ3gswMDAxPaZ/qAZXaGEMhTP8pdEUJMSdyWfmB6O+ggrrpat2oFSMVmzY?=
 =?us-ascii?Q?V+MnU1qXWdCy0bTXuIxIHAihL2rXvSUQzQVM72RkUNX0/kK6skuPG4T7DhSo?=
 =?us-ascii?Q?YowZbbdEV++tQ+jnEZIgbRPmfusx3Ds+QRxcLdLp/h1KjqGBoVTQZIhZVziE?=
 =?us-ascii?Q?j8b4/tIgiu9TG0j3xmnslhKANavpXBHdneXX30SFb4hNYvL3BshLBlg1AJ0g?=
 =?us-ascii?Q?cgj3Sh80Zw+sxue+yGmkADlIKbd+O1sg/wJDmm57aKD2OSuFQ+mPghSadd4T?=
 =?us-ascii?Q?z8uwOLItUBSLYEKRnYwNZjIZjvl2Ab8ueEfjNeP/xRQ1R3qqEAoHa96ZwnPt?=
 =?us-ascii?Q?T3T/5zdNXfbcHt92kg5MTKaj8eXR09h0yjiyXluWyDBhbIGoOFuknwRfJsv1?=
 =?us-ascii?Q?85DN9fwl1zWIMXoalgvZo7bROtd7JvD9wyazHPmKpfpEkgYCsE/fx6Ei/P4n?=
 =?us-ascii?Q?EGJas6FU8eV2yP8xP/iXVG39MLwXd3LeWmj9GGw7gzsBm+vboA9abaejq9Jz?=
 =?us-ascii?Q?WYhUIV2JiicE/0jvdmBIJJQgLWYh0dlSE4/mwQ2ODeV0HKq5bOlZlr1SU+zu?=
 =?us-ascii?Q?JFbywZlfOyGZGd+Ei/KMuvirlw8WKBULGXhmN0p39T9eJ3dJQCSm9z+BJMkk?=
 =?us-ascii?Q?elc+Pfd0UloIKpLP6PMkRBVN5vl/uEJA7QaAm1cMhdSCrE7fD2oNQJLw2lvR?=
 =?us-ascii?Q?f3PVY2H8STXcEHA/8m6b3MClZPWiSw3D7JmPpfe2hKQmziOLWnhLmbMe4YVl?=
 =?us-ascii?Q?xoi1MjebajlWXit2Lb43ItkJ64FCXqfu0mVEkS+4YE+dDHG8sCaJ0jtP+urK?=
 =?us-ascii?Q?ayZsN+RzAk9xKTebyTDnTaB2mzjy9KRPlk8a4tFN1YitVJlny8HazaootRFo?=
 =?us-ascii?Q?bn7Blzqq07D+WodYgVpwBj+eiu+OiBPZtmDgfRY9INjJSBA4wLTTT70tQIZl?=
 =?us-ascii?Q?NdohC23CdL9CFRIH/tMQNbdQHutPUzssDkKEMgC6/tFBfXcfHAzBFHMhsWJW?=
 =?us-ascii?Q?tWpUMIfNNRNQ4nlRcA/BJNQsrooWmkpW2ikR2xyvK29GLYF5Ew=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a07629-f415-4a48-0835-08df3dd41757
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 20:08:44.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

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
Changes in v7:
- Patch 4
  - Set use_single_read instead of use_single_write in regmap config

- Link to v6: https://lore.kernel.org/SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com

---
Changes in v6:
- Patch 4
  - Fixed 32-bit overflow due to assuming long is 64 bits
  - Fixed fdc1004_soft_reset testing 'ret' instead of 'reg_val'
  - Added .use_single_write = true to the regmap config
  - Added cast to (u16) when setting calibbias in fdc1004_write_raw

- Link to v5: https://lore.kernel.org/SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com

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
 drivers/iio/cdc/fdc1004.c                     | 491 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  30 +-
 drivers/iio/test/iio-test-format.c            |  16 +
 include/linux/iio/iio.h                       |   3 +
 include/linux/iio/types.h                     |   3 +
 9 files changed, 603 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
 create mode 100644 drivers/iio/cdc/fdc1004.c

-- 
2.53.0

