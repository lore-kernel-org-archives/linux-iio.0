Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342280;
	b=s/ElEfXcMfi7f/SCbw/AAYMn/l8GdXCcmqUk77+YMGjmYKWcj65O6TAow71hCMPwPg1o
	 +kLXn1rOIKpK2QJHGHc0I9ddeQwNongXGCY7NXd8JS7JNIhxNclUsL+BMkvAnrSkHRjNb
	 dXbkXqihqz4wOhlGkMwgk/ei/xabs1WcDt1CAB5xdXxI7Nrmkm3UjfmBJQT/Kjod8Vh5X
	 i/rv9k9xMdlSK0xujtdje1NJ46u8LWk94ZV90U0vQ8E9ULZo1y87jiDWgzrHC6cEPTVrY
	 Us02p/ct59JS+UAe305kOpspoGDSHfymBsA552obvFrwwdQ8IGOAnZk7p/GyX4dLHWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342280;
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
	bh=zJmuSfZxR3/C5WbTQ8bEiZT6vL+X6v5sFVsU8qp4eCQ=;
	b=24SuLTM0Be2ubJohlX/o7QkYJv7m3je8ZgdynZxFvH2tV1MaIlAw9uWRcQOS0A9FFtLE
	 O1EM5PKd7moB0UOq1MZ02QC9G9PVauvxnTVEJA6gCYMLMrfAvROE6SmyTlgN1Mo05Se3c
	 nrLxBHUplYcPzw0rRqneKfGhTilfu1yTkBZO3SnNxSV7wU0v0Ff9JxMPu/Ofr61pT+5Uh
	 fcpQgOjLO0igzbeWm4ieA++kPPC5hVvHjzxX+JqB1NjZJ3BbVxIAV8YNtbzooJxkBoYiw
	 ZlKSqvPl5yZh2+wfRRLU/Pn/xY6yGxw8CpataT0ievuAa+F4Inr7LC04TVNMbFPjtAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=PZ3Pobnw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.59
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012059.outbound.protection.outlook.com [52.103.10.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484A606A8B6;
	Tue, 10 Nov 2026 20:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9484A606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=PZ3Pobnw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kii6jdKGFpHsQQ1BPiMBIJ448bSwqIw/lskHv/1JOt1cOnoxlgMQcd8FOtxsYJr0mVyeQW0qQwzZGP8dzk0HmIxwivxIGgPA8Dwzmn6p/VH91BnYiE9Vt9QShzQ8gYxoaSOrbctPEYUulZ+74izWUmOpBbjeV9wNL8oTh69ves5DG1hikUXUOUq0iWIEjV51FNJhcFM0SDbj4MqJqy7W5Z07VTFLZUn0+QaU4M2LbE0B/duJhDE1NPU5eaul5a0SKnFT7y8fmSRZkUq6pleP6LVYJwmDnrQhkLlj8Ni7J32wUOK86pCIXRfaBZch1sPEf3cl1crhVHHaFeo9ISEb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJmuSfZxR3/C5WbTQ8bEiZT6vL+X6v5sFVsU8qp4eCQ=;
 b=DQX4bNoEuPRYGO5LdnFAoG20lAruF6gfd39TsOuYD/8YU+QTKlJThrwUwLdUGh/SwT3LlgIctfgTHubOv3M/cd389OJ6nVoqoEck9RKn4pCqG3p/k0e+ZmJqzdKaJGW6UrxSQdMb/JEin3AQnuhP4MI/sMtl6hTUUgORiEWQA3jxQ+Z7WT4VJjVV0w1ukpmpbekardCVZCMvUKPvRtTndRdPFDzW09nglL+q6sivGVOarUSoxFoCfIg0p4F0lIUMBJUZV0456nN808dajhqax0fH+Xukux1PHWWJTMbj4c0VwVCkq4mQ1iZOWWkuqFAgPEBrSgPNQNg/XE1hw4W6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJmuSfZxR3/C5WbTQ8bEiZT6vL+X6v5sFVsU8qp4eCQ=;
 b=PZ3PobnwT++U28u8P+GPtLDBxLSUle4QC2Vw5lpVexWcYVf8FcYYJHm6d6S6DJ0EwohzHo+JHE4dToYe+cDZ5O+XHZdwVhtN0GGctYfIUdh66JED7BHy2pTM4OQDG5mx8f/t2+4+kTrb3NohbxaaGnSSEvcH6z2m/lWWNwAfqU+7R6G6G19zvUHuE61ia+NwLX1tBOfmI1QTpIXY6lIJU5JycICu9hSoQ4hzwdflzVYnEtJuCGZA+uwKqR0aTsOTTGmt0Ht0m0DpovoKD2cqxA9m870Q0iqYx6FTouO0SoU4aAqUacYW9KRLbFFVguFHlfX125whMsfwqNU9GlIcSQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 20:24:36 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 20:24:33 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v8 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Tue, 10 Nov 2026 14:24:18 -0600
Message-ID:
 <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:8:44d::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261110202424.1100154-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DS4PR12MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: b015496a-b168-4e38-76d6-08df3f68a1cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|24121999003|22091999003|5062599005|5072599009|15080799012|23021999003|260925184616899003|4140399003|24021099003|25010399006|3412199025|440099028|4302099013|1602099012|10035399007|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZqD0lAPKJ8KwoTqO8MVmPykPG6Hd1g6mUB4yJDbJrewGt8m+KQSNHdlDyF9?=
 =?us-ascii?Q?E/LuaD/wmDLBut2mPwA170rH6To21N94vGDCNljDu2rT8u12SqDVwusg6I9j?=
 =?us-ascii?Q?ZSIitAXtkeyxCMScGoWyYUJdsx928DmeD7FEMEUMLmpUyWEuP1/VXl9tGzNo?=
 =?us-ascii?Q?YWUhVq9Q2/4fNG8A1Q4ddip/ivKRaqfg+WNwCKJTd464tvyANiamoif/dCjJ?=
 =?us-ascii?Q?n5UW1gJPARPf2rO+a1mIU9L7zUYaOqIM6DVN6iyTUODil1Ne4Vjm1bHfM9NA?=
 =?us-ascii?Q?icKRor0p8nhFjMtE+1gdZkp1H7zsQ4jRW6muDlVJrf38MRQ31wZRW8Vfgk0Z?=
 =?us-ascii?Q?evWMjYQZFwN9OAKwp+5oi/P/ZuPxo6Q2zGoICfAN21AmMARoXgO9F6ZAEkl+?=
 =?us-ascii?Q?/GEe5nGjDPdz6uxv+VJ0Okl73DUNWwMwdn95ZPvTr7/df+ihnQoWlyKr7UFG?=
 =?us-ascii?Q?5K5Y0ZAgfFgbi8c2GWfNfHJEhQwprTj/YvDfjwAdBTIFGc1ONeqh87cUQNrX?=
 =?us-ascii?Q?TwinX6selSUEa5IXNSb1qFWgVHtE4jOKqT5KF8+rk5MW3qs1NBTtfaj+UoP0?=
 =?us-ascii?Q?+x4pvIx52ugcVKcMoFS3kMW/lBjiWUiejT3wop9sIJAwORCERrMfirun3Yj5?=
 =?us-ascii?Q?Ma+BaW4JAFqpA+lALDZ8R74NTrQmbeOupBjNbVfSjWpaLZrLBc8yOhcSRja6?=
 =?us-ascii?Q?GXz7WTE/L4eA9B3fWQd1EtPXcHdB/aBSBQaUyCurm3ZGTj6y6c6ydXDjYlBp?=
 =?us-ascii?Q?5L2rKxwgtB+eNUhIADOfwFnb/lvYad+xsrMG86xb4RFCfijgd88+SlmFwZmK?=
 =?us-ascii?Q?qqJ8SnuiknCgwYzSwZKR5ziK9K2b6RZ2gyZy/YBWOnaLFISKZs7yVaTpfsBX?=
 =?us-ascii?Q?KlVoR5w3z6dYwcc5x+Lne9gD5K6QjzlN5dpMioyYtizEYAYiftwni9mUJht4?=
 =?us-ascii?Q?g1J/ArjMPwuqfNyCkFA7++Sckzf2Nm4R0W11j38gBlR5qfARPX6QV8wYCuvP?=
 =?us-ascii?Q?ifxCJil8qWXPk4Jpv61GYwnp2OmTlfJOq5O4OLba+SwSr6d/pAT1zAPOLDp5?=
 =?us-ascii?Q?yZC7AoWK0xTOPK+x19yFKX38Dgz2y6GbtNiLrEyrzaOqeV8dSGD9KdIHc2A/?=
 =?us-ascii?Q?SY8gpDsLI16f?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JcdC5KRorXP3dLp+0sY1K3YHXJxrl2F17mO8hnkq3XvAZOxfbOcNlx4N1510?=
 =?us-ascii?Q?Vp3hkA4XmUF+aStvIoaMtA1Qv1/vUtlj+DH5obtydYy7Alt+WfpzzovWKq58?=
 =?us-ascii?Q?t+jMgSeqsbGvV3e0Zv85nas9YOYIFAHDpjFFAimkg4y1/TIecjN8tw2166OL?=
 =?us-ascii?Q?NgCLf8SXKhudk56zhJkXkJ4jjhTtxiiESDcPh22rDw9NOurtRrGAzqaCpd2J?=
 =?us-ascii?Q?zbkpiX1gXQzn/9/gvBuelJwLDq+e6/g5KNf3faOxYbcWC0NlDjm/yF7K6YO4?=
 =?us-ascii?Q?xWHQE545j5KMDeIozJWV83awknsai/3ejzIUkk+Z/8KA+PWf9a+YvUT9fA+d?=
 =?us-ascii?Q?I8ZoTNKFjvaHRCYtcTYbZ6TsNlRgchuXujwoj1YxneoJ5NX/s94DGkcOrjJg?=
 =?us-ascii?Q?B9y13wte2GFfcnQVTSNZykiGgM5Vic6m2q1AVzQk++gY1GVaex3UrDe22JFk?=
 =?us-ascii?Q?Nzm6mUvtN9ZfA5D06CISlJB333dUTFaivd+NITpi9vScVPXYIwPCfGoSQbvu?=
 =?us-ascii?Q?z2xpMSNIyYe4Pu8SNuy93kBi3YRIwMKbiGg67gr85mWgmq19L4PR70ZlPbuJ?=
 =?us-ascii?Q?9e9ZjYk2uw3qKMcezLjsF90xeMQneX77GGq+5jgAeDXcgYVgCLjwj62qOfqW?=
 =?us-ascii?Q?f7pafdEvfJJGPFGWyx55czMIuaigDXQSmFSiwMMRTUGkL8H7PgGM11mzNA9O?=
 =?us-ascii?Q?JZOIC6hw1D9KtQUjMfLysVL6trO18LtNzOGRlIJSwTiiDwHrjCYOjdczFA/6?=
 =?us-ascii?Q?nhvsat2gtzzH6Mcl2eiOJ00VKWvHnAFS1H3OdYyMsDbfJWmWCH4qJi4JIE5k?=
 =?us-ascii?Q?p/NkDF0Dsfxm+A93oAC//d9GiyE+co9MSSIV7eNxwkeCFGO6l1sbYCEq58Q4?=
 =?us-ascii?Q?+Hp3XM970zbaOqjmi+JkidpzeFmu1qSfbth0LYI062PPUqbk3i0YRvWY0cir?=
 =?us-ascii?Q?wplzvZruvwEe5yZh74oqRGTk2Stj1SFYjg3XLZYSmKnzVD4x7v2NKkZG/k8T?=
 =?us-ascii?Q?os4ccS9RIJULBcmDi0Yl0HOqVCbKjXbJNh7LrkS02rZHRNavrKmTmqaDLaCh?=
 =?us-ascii?Q?/4VTWEutB5A3NZFtev4QOeUGSiMWTdn352Q7JHGTqfR9aMUVg4BCcMHJyczL?=
 =?us-ascii?Q?24XBumueyKaFC1+vhpTKIJDVR6LF7p66921bRri7jsuW/lCxPCOmS0IWKnM0?=
 =?us-ascii?Q?qDAqj6MEtL17KT8cGUaYpmBgD13szuk39bAei8FlaLjj6iYb6oAvvbURmiXD?=
 =?us-ascii?Q?7C9bWJRGM3EphfmFAMvThdXQdiC5gY3n9Rf9WXuHzu+4+nT9M62Kkz2heWys?=
 =?us-ascii?Q?9VStDX9bMbXYX7eHP/TDRTOQguKLrFq8XVDcnmJm/FDviTiAQ+4BAdCQ0D/U?=
 =?us-ascii?Q?O9ieJmyA3l7ZNQ/ULzNnjoVtEYwBWOu4k3VaGdARmeFeUqQ0/Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b015496a-b168-4e38-76d6-08df3f68a1cc
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:24:33.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587

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
Changes in v8:
- Patch 4
  - Reverted the cast to (u16) when setting calibbias. Consensus after
    discussion is that it's unnecessary, regmap handles it:
    https://lore.kernel.org/SN1PR12MB2528684E196432864FD48626A5722@SN1PR12MB2528.namprd12.prod.outlook.com

  - Allowed the user to pass an inexact offset value and made the driver
    round it to the closest step.
    Rationale: https://lore.kernel.org/SN1PR12MB2528754241E5C6271A02734FA5722@SN1PR12MB2528.namprd12.prod.outlook.com

- Link to v7: https://lore.kernel.org/SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com

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

