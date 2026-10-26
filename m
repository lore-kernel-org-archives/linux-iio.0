Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033496;
	b=Bl0LBJONBIxzjq0pitvl+uvK2Sw5WXd3K405bmGc8N8j5AkH25D9Nt1UTTHdYLSBbZ79
	 gfp6umivzOMb+/bj9TkOx2Fx6FCjZz1YzFq/+OhoBNkrJNEW29SjSu0akERsQZrKF9dFD
	 b74d35I9zU2xZLQDt5W76GiQIJOsrDLUt0qK37Cuc4xleO01mAPfIIgACEhNi9MpagfS+
	 I5DP1BYm6/sIsrwJg89Amru6Y/9orAuA6zkgrhRWO2OKFB83SgJ+fcKc1AWJXaBw+kdIw
	 Y+MkGlAVPMEiaO5FhlE8AE223SyChIKPfd3dXBVuRIHa+0UoxrFh9uJ4lXLK9M59/gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033496;
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
	bh=V1qf1GDldUV2QXtXzcILGfgIc7qChLoSqr0wPzWm1SA=;
	b=qPC570Jg+gjIfr9oqXvWjyvRkfTCxdxnyKeXt/dgy54I9v2xQatpqEA7mi4DNJnPnLsc
	 nQDjVkOCwaipKBtv67+rZDXHR5YarPBvqn38vRZPClfILSJ+7kuGD2ZQENaawOIZRqHCz
	 cw00oLlJXpbT451LuXJMYp7CyrYfqKerpbSVcUIVtBV0bSwBwuR6zEVQNt4ke4oWCWcqh
	 2CH8uZdVQ2JXtsYF5dWO+aDHW1BqyaqAiEjCqRTDC/owL8Pqu5KcGobUmL5hryKZ/48Ks
	 A0tmTbfIFYro2nAA/A1sijtMCNTQVgT+bHV6MXws+mKdpE3s+r1/1jPqdZsVOOoPY8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=aMkQB0KF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.44
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012044.outbound.protection.outlook.com [52.103.23.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDE606A31A;
	Mon, 26 Oct 2026 16:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCEDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=aMkQB0KF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXUu77mM5EM01rCjLxKPXdwb5WZD3fCUPSQtRxnbYTCP8IOCZJDq1uDemuaX9+Gc1ABXNx2QSwye2xvDBFQxVUOSZYrhbx4CHcX5qzWAFlYB/TKm2fO1QljTOXaQqy2TaL4010C9Qxa71EhkGMYNpuTrQmD0fnab4YPXSRuq+vDwr0VGxog0PfgLCufQYj/QLmwD6afhuc79PPcnnrqHFwXDwzpxJvA5UCTLps1fAhoKkQxUmsQ0rIy4Zdnm4GSh8uGRlzJiX3R1+lVKxyND5dflkJl0LofQp0/TZxzwEJjiXxu/D0e/CJZjQBJWypetlkaeTU1VSDD4RZwiZnTZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1qf1GDldUV2QXtXzcILGfgIc7qChLoSqr0wPzWm1SA=;
 b=YbQTpfBPnx4blFpGV4OVsd9w6gxxaP5jekNAMZ+y7lQgNQ87KbkHlZyxIC7mnhF+iC/Y6GtPnpLxom2MjpNu3PUrhJyRiEn+XWhykTtHJfzYmrLAS1mRb+fwvfh9ukBKw2udC4delJgxYHMuZhdsiVes16d5lkUspPZfyj6vChoicOsRDddvHyFUDgC3ObIXiSJnqcZj41SL1s4APrYgraWZi5ihG0c7oMBgHDnqErWT2WReyyEGynTo/BFdGR7GR5xnDQkF4tXOHyxp3j+svcItYmuUPpPnaiFe9440Or+W1usDgO+6fv2QyL0QfM04H/UGfQDpf3qggXygIitq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1qf1GDldUV2QXtXzcILGfgIc7qChLoSqr0wPzWm1SA=;
 b=aMkQB0KFyZ/YsSJS4GokrMyUvRanhrfn2GleOC51w9L3T/DwS/+bSyN3RF0rP8aWlLMS39tEhjRiYnSXDe7BFhAgqKwD1vj+ZhA5MTU1vaQuMpta1SbPQNK6e6ETZ6saqeiP5C3t/Hd0h+enPzYx+SRJ5QUpkgplqIlUn8qR5EpiLH5HJ4fDtmPs4zDbyXe1IoGnSwtdarL1yJjSZJ0z5AmhXWLOK+NpXxrlWtPihn6+g2esZ9Tfl8zhSN6u2Zmb2FxWlndeqwo6uwjdbUq0ks/YO9mcAI+0WSihGDAp0tQUGnZ69soi4ANuuM/Z81tnaqlWiYHy6mtALNvp7cRZCA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA3PR12MB389676.namprd12.prod.outlook.com (2603:10b6:208:713::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:51:33 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:51:33 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v3 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Mon, 26 Oct 2026 11:51:10 -0500
Message-ID:
 <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25a::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261026165124.119890-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|IA3PR12MB389676:EE_
X-MS-Office365-Filtering-Correlation-Id: b543894d-4932-4ea2-e762-08df338163b6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|24021099003|20031999006|22091999003|23021999003|24071999003|15080799012|24121999003|39105399006|5072599009|19110799012|8060799015|260925184616899003|4140399003|25010399006|3412199025|4302099013|440099028|1602099012|40105399003|261007181701699018|26121999007|11120399003|261005200801699003|23121099006|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xq1O7imvlbI7gYaB987xLhMkRE+C19rjhsp8j/3HHZXA5w5ag0KAC862DH6I?=
 =?us-ascii?Q?nRh1uLEeUztu5U5O2sMiw6HCl/80Z+mdJ9Bcg64VAJS5f5vo5dxwke1yUdja?=
 =?us-ascii?Q?tYtoup2wl/Ng4mngWgBVieCFvM/tveMALOorCLNs855+3pUQ7z4DYCDKvnan?=
 =?us-ascii?Q?WvaRLk6wuXk+wGh/dm+O043DmxkxyG29G70B3Gt4E4FPVVM1Fu5M3z4ei4+I?=
 =?us-ascii?Q?OGJB3kVSpIDSc35xKqPS7L0f4kblO1oILrmY352Eq/FXpl5SewmdOsKQzC+C?=
 =?us-ascii?Q?009hMGADrIBJe9b4hNASChVXm94CAvwqlKORi+hvoLh/TIZSGZiYhkjiClJi?=
 =?us-ascii?Q?jKPwKyMCkTwNi2a+p2ECL8pXzQ3i4aFeJBNKnGx3JJo1wXPs+ef8A5qSynlq?=
 =?us-ascii?Q?SOa2VjQ4yIx5wOsPz4RNWVqlLUdjeVxr5PAoOAyrnw70gL86kdWQQP+zLqVz?=
 =?us-ascii?Q?bGoBhVybmfU6C2CLPAeaWBNgEt5oHoLdI5NfpB9Dtz+kySjDLYrkcdZKbtcT?=
 =?us-ascii?Q?mPVCzrZYvwmXMxW/W/6np1eC7UCQIdSbWUa0Plixz8toZmAatdelhcoLJqWj?=
 =?us-ascii?Q?BkDk6WE3TtOIfrXuV8edCJmx7EfVIoa9zPPxkm4VfNAuFYYwv+CXyNHh6lwR?=
 =?us-ascii?Q?k3biQvpg5Wt6F35EkWAuXWPMd3Myz3+45g78ONnQ0M06SpWbG8xnZjnT53j8?=
 =?us-ascii?Q?bAANLMW3/S0t3YGzBr4Zmxk9vwygjBthEEjI4WTox5Z4Yn+YYHNgT8v8dMbL?=
 =?us-ascii?Q?RzEE3qfev9EdaACCcgJBzevaeFdSOHU0x9B+kKbBCIbVRyKe/1Lu8sUAZN6e?=
 =?us-ascii?Q?JZzPIgHo76PRb2Dxp8gNTdCqN22Euf7IgojFeNT1qKIDJIBt+w7U3Oh7rjU8?=
 =?us-ascii?Q?nz17eImzlgp+GflqAThQYnbh3eM9pRs0oYk3uZvHVtZG31ML99sNP5pnw6JI?=
 =?us-ascii?Q?VNy3MD/kHV8IAsHOJZD+IYHlgJvS+VjFRi20462ZrmXozUQ8J84Nv5LaquwY?=
 =?us-ascii?Q?7uHGDdl9AjyCQ63EN9L/e2U1MqGDTz+PX05Wz5j54b0V4WtCeJcNyDTchbuD?=
 =?us-ascii?Q?HMrwXoqxlJgf776I8PwGl7IMCldPZ6Dmc7gwrBkxbP4MJV79OOdsUGQCT2RI?=
 =?us-ascii?Q?ViwT+be8EM/56CeAs0ain2gB+MyTxRWivOPC8B+8k38DBKl2le6dDcHOF1eJ?=
 =?us-ascii?Q?itkwJoEG1nr9EPuoCvC2oP0bp+MWYEvyBK8uhBiohOgSaTh0YWz9oqEZRcjX?=
 =?us-ascii?Q?Oeu3iXcfCZSV5YC6u7HcnZWfo0ZZwdglgdT5QzKRpw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GRD1U/OpzEpZCSTsk0lhPWf5jUoA0mcBA+m4GXfNn6mufOrcbvhPKtY7kQDP?=
 =?us-ascii?Q?obiexhpMJVspSfMZjOq55679ZH9oxkW8DWBeqXxsxtZCSVkzUvfIoZWk26s5?=
 =?us-ascii?Q?mdA4bLXLB1hn25X4nCIgA+KN9gt3reHdcQ3gSFN8fqL1RJSFhH5jhWRg2q2E?=
 =?us-ascii?Q?Wrhkhif6k8LQyLokChiPbnr/+sXlKYPEGWqxTfpuNsVCEBFYxlpHk61oxQW9?=
 =?us-ascii?Q?vNbaHbSkEcNsamGkwgZ7GW23unh/Q31Qhet2LgG9YtDCHPwBKkGl9gPJi5I1?=
 =?us-ascii?Q?vcwbcTnLrBNqC73Rn+KJe3pGEvaVDowByBzkIzpAcSs9RO8LbfxK7UV5wjn5?=
 =?us-ascii?Q?ecDFDeqw/F7HDGKyhpF55nchJRmWSPNcsJYfW4CN/quY7ilvwDdP/D1OZqq4?=
 =?us-ascii?Q?zuW+d/Q2XiHauve2WlNm+j6OfVehAhnZn5rQFSQqTWE72wBxSKNdqRe/9A/t?=
 =?us-ascii?Q?vu/fDgDT5agQivI9CX5/y2vvo1VNnqq825pNXDDym3Jha+m7yRUZ2LODhGjm?=
 =?us-ascii?Q?Rn469N9g/LseJnPT12GElwYJmp0DU2uRM6XaMtrlRegIXlIZfHiRHImFaQ5k?=
 =?us-ascii?Q?HtHVN0HGXNwRMIVObL5eKQx3020ecIl14KfPY7APwtnxkXn7ir4YtRVprhgF?=
 =?us-ascii?Q?Dbv1BuZYkRq3aGuNRuPxuGXywDtf8a2X+R/w4Icj2re1zP/iXlVCTsBdUe5Z?=
 =?us-ascii?Q?nFNRMJZVSuzb8GSvB7eV0x5v0iH+ESLIIPw0/7cOsKxILUsUUxCajgEwV6s9?=
 =?us-ascii?Q?SD7kHM3bRSONXKrB+GuZ5iwbTDbBCc2fXVo1B3Gt0JSaFQ5rtNlCMMpaxyN5?=
 =?us-ascii?Q?YDeQ87VYcPo6J1ILU0j0VnkZc1xdXXUOQ/PP5USX3klgHV5+Gu7UpMyg9HQ/?=
 =?us-ascii?Q?8gxnJA4xcY5jwuZVsSbKdczo/IwPnd+ipl12uSatfciGytUjon9n3DoQYcL/?=
 =?us-ascii?Q?ZqB39doXF0GD3i1iJXrx5+rPGZ3ix1OL87IbLz4CqqvSKNaD5ynPc/DHY/25?=
 =?us-ascii?Q?1Ww+ByCa6hCwpHNPDdPE4FQehvRJKWB2t650rC5fvIKUCBd6130VJUdu8YW+?=
 =?us-ascii?Q?n/z+PF9JnoxyK3UbG3mewEQ6DgQ3JRCHHipwbQH5Ri3xuh2uQPW0kj9CpzTE?=
 =?us-ascii?Q?zdOW1jY67A0Dr2xQw89NzMIZ0CsZU/T6eAshN2jca8kiW/8yL1bJI1R0nYPx?=
 =?us-ascii?Q?tXqY7/bDZNQZ7sbUJqp3U4U6arAgzT8fhOKzGNobsHcwnR3qfg1I4KOpEei6?=
 =?us-ascii?Q?iegg32Ci/pcBKFp6mIkBpbzRg+JCNykmoX34Y1N4FqfDR7mj1leWMVXvgnDG?=
 =?us-ascii?Q?OkV9PTjBBGI2wenClCtvjfVnmpFRVxkGKKFD88P/9yQW0ErNnk0Piyc+TTBe?=
 =?us-ascii?Q?fkwwZnB8qdEWtXiVAGKSnJZXdwYf7+sXBPjjljRU+tnreKIpsw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b543894d-4932-4ea2-e762-08df338163b6
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:51:33.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB389676

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
 drivers/iio/cdc/Kconfig                       |  10 +
 drivers/iio/cdc/Makefile                      |   1 +
 drivers/iio/cdc/fdc1004.c                     | 488 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |  32 +-
 drivers/iio/test/iio-test-format.c            |  16 +
 include/linux/iio/types.h                     |   3 +
 8 files changed, 598 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
 create mode 100644 drivers/iio/cdc/fdc1004.c

-- 
2.53.0

