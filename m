Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794166777;
	b=3TBalQrqkSnEySWvp/cEleRvNmbl0LtiVYPgaV8f+7N6AAfQOPeGaQBW4/WWB2AQuSYR
	 UQ1eJte7fSOEpNUEbXCV/xjnuPyzcD4TgL0bPXo+HaBTdkKkaz6O29zBSoLJygwdx4iUI
	 VAq0XFwVjvSeBJDGcvWEwHJ1dwJW461/BZUqGzEkiQCVpjx7WyZAetQci7pmHT55ShoBG
	 pxjIEId951afw6ZPDtPWw6OWVDuL4W1QTIG4lxLp5oYZWQZQOxSdPdFv69H/HV+1YEax1
	 k3uzwlwpBaWtTfUWeHr4pBPKmA8fp2KOFajyIIrVwMbh9zg9gdokUdiPv3g/sC9mSJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166777;
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
	bh=zZAaR1PkuqrxkXPyM76dM8Kn16IVPVkTGy0JouYSh7o=;
	b=MYUBLkyGbC6nENH0qWNA5nnsXwUPbgjlt+gkOg10S13mDd5et4ZGWCasqKBMZhykHmOn
	 HDh4PtZzr1TsbObX6hsgP71w4jZ3DudHAfCmO8aJ0aabmM7CM9goeTtWDvf2k/UNoHEpU
	 I2CHBmG6/5i1Acx6UJRFIjBaEGDz5vD0T+ZFQrij9fRDjJDoQ23inSKfPfSUDzdbmEqoy
	 ximSx93IF2H5uL+Bs0f2ptPab6y1CV46DQJP9UU/9MT3rrhG9FHfrWusKgkbfDmaLpWnf
	 9gyxWO77g6zG+9UmNTxMi6fjBkMgbQJRJoQHhC/Sy4xmHoqoF3tO3qlwXKOiwtZQJpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=OdxyhOeV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B515606A31C;
	Sun,  8 Nov 2026 19:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B515606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=OdxyhOeV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JV1x6OQqaeA9OO4dZZuB88hLvGAq5cZGw62i6HIUQrfZQwz5EyH6MvnkemMUcXoAM8UAoBYIBTCH4lofh9L+Uk1DD3DkbZMesFStIyZMZg+9ojFN4uy8HnBDNpu3gkVTWuJBCgAVsZNh1x2I7kIBN4Q/HepX/WRA3AdhMl3OYLBPfzxcsv4ACN9/PFSoWCWKZAiLBv7oOPWIDgFl0RYGAAQQ1h+AetbZ0h6xyuv87CFpWVpsIhQHskYExj2AE2Z2668HXvxn3ZsSMhmwybHj4BKIziUSv3PFm+sz+Cvfk5Le+RLYpoM0alsQubjXfLFG5+etE/5xLOgvGuhN3nFJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZAaR1PkuqrxkXPyM76dM8Kn16IVPVkTGy0JouYSh7o=;
 b=dycvyYHRVJPzD9n6SACXEp06sfUbMeCEH2FlJ8wR2vp8NWXw6NuWypb+0zCbw1WsWhbK1/qAEYNxOuSkmByBnuL/cxD4PxRuRWMbsvZEyaZ7t68pm47R2KR612tj75EUrYg+0v5uYtAEa3Hny44AImXD8Yq60PIdzgtDrXnYJ489bK5otW0NDxDoVkUpe4kSr8Nkqrks0/GkIeqtgSMKSmpUcFUej1FE+bBBRY1B6FqDcJI0riGeLSh47gJMsq2qfamt8y9Trrp1Ef92Qw6vchIYVR0fxr3gtDt9wlTUoaXv3VupH5p9R2DJ5u5vpvVf7XGcYj8N88yK8WxMEkqTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZAaR1PkuqrxkXPyM76dM8Kn16IVPVkTGy0JouYSh7o=;
 b=OdxyhOeV0w0LKgV9UcpuOBAHaJc0caonLD32KbisAQ8PY8Lw/qNus2Wcz0kSpp67kLDeqXPfjl1XdovB6ta8WBjuQla6xF3j5sOlL1qEOkW74+cv6qQkt/vFs3MobNFPTY1Ev19x2p04QoBtjrCgYX+M006gaMf9cDPNVM837KWv5wSBjNVZRW6Wu6APHNg9dgaV2yKtbiS79Oz8E/yuvWnNA3QOTZWYQFeGVQqNvowhYCGMC8bY1TFejAEgc+QBKcUUzwQtKU7G0OrWaWWbhi9xeB1cD36j/iM/xMC6LVaXUPPlHAZnKKgfkQAbBvsZ4rCEI+8PoXMEMA2RDjWTpQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 19:39:34 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 19:39:33 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v6 0/4] [PATCH v5 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun,  8 Nov 2026 13:39:19 -0600
Message-ID:
 <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108193925.977273-1-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c055955-9119-45fb-0808-08df3dd003cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|8060799015|19110799012|15080799012|5062599005|24121999003|22091999003|260925184616899003|4140399003|24021099003|25010399006|3412199025|4302099013|440099028|1602099012|10035399007|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/W6xZ0UJ/zqtG2I3eV1Ows6aGy+3Baxtl+CJa3XYLKn5shFUvij2JSFelKAu?=
 =?us-ascii?Q?qszoe/W6YVyVdG+TAdCfpudqBbPnTkRoeuBz0+c+57z3QdX7Q7XIJdQrAU72?=
 =?us-ascii?Q?U+B7U2kl4JTyN4YeG6ouzHiJasolNAbizqQLVYMIgyjMCCjIbJLPGuK9rdWu?=
 =?us-ascii?Q?BrRT/YtaYdyFN+z3L6tI0k3+cBqVsFfUdmzJPrvg1igCBTvEeD0fluHV/ntx?=
 =?us-ascii?Q?JM6EBCvz6lxlO9Gb5R8GVLNgMkpnF2VbfiAEbvNHDjv8W12uKAyZ1WwIMG8+?=
 =?us-ascii?Q?F4dIG3GelhkszJz7o224D7bIHiw6CysT6Rf0LMa5tanUlZywJyhfgeJj5LXR?=
 =?us-ascii?Q?bL6kHu6zyTPqKJIDAXz/5+SN1npgKDFg0322ulMkK/y5iKLMhD+hRERvi/rI?=
 =?us-ascii?Q?clvVVcYYGkiNC3YK8YZ8FPaFv4kCnAbkzM/Y7sXUR6teO1VYyNkkj3rzaGID?=
 =?us-ascii?Q?MisfTI8tDAJfgtYNdFhwbKsHGSfTWpyAGhRkaDIsDhi6LVfr2bnP0rGcvqG6?=
 =?us-ascii?Q?TLt8XLzEtjrcOnPDzuxaGrNNLQaTrSa1R73i7vQGMfnMwvf2yambCv8mf/ij?=
 =?us-ascii?Q?pKmvqrfbBcz+lO+IyePh0V0MfTmEEtjHNh4Pxd+Xf5BDsPKgXT5RSpqCMI9/?=
 =?us-ascii?Q?twA5fARC3ro2DfNbzMD7xoKyh3YL1RDOeq4Ai1/KQriAjDRmZzOcraeBXzPZ?=
 =?us-ascii?Q?AdtW9p3edrrXCCpUdjpHDv3Wnv8vEcAX+Wn9+1cw5AQWGng2rt5V/NxsOacA?=
 =?us-ascii?Q?vYtWm9XeAiRN+6kIb4TdtP8gwPGgigZaKGPF4JP0kGJ1anmvsTTAGXzXZ71K?=
 =?us-ascii?Q?NYiWT21sdoJwts8I/p1U45m0/LjeAggXeFatjn9CPVc6969dg/RmEbNFPnEv?=
 =?us-ascii?Q?4skyDp9CQNXUIgmOX6TLxWGtr5B3ioEVpOc/VAUHWtTM7EE+AwnrkHkO5Ex5?=
 =?us-ascii?Q?ppGaJDSL0a2qT/n1Mnh9z1+lIBqWBQtg+fYZp3HAbzOkEG9+xu2XkSZxTiqR?=
 =?us-ascii?Q?sRCBk/chJk1zMOZi+Q3Jff7fQWjSWMnMvTIR2HtAhV3MdYtDkkfcZRj18cTz?=
 =?us-ascii?Q?CPMqFoVx4mgnwyih0BOBOCZEO+3sDpDD7R/JjH2txb6XfYXRgS0iTGqWJodZ?=
 =?us-ascii?Q?keCfcSNAmvuG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ImZ/JzbcSrIqkovlYG+8u83NhE+P1zi8YSa4LrAfQy7gIH6hT6Fq+08RvWei?=
 =?us-ascii?Q?bPj/jnOvawFuvivZCBm3SlUQoyNhxcbwuS/VxGrpMRYKdUheKZhaS2hqrLlu?=
 =?us-ascii?Q?MbL9QO8rkOSra3KO9/4ehDt63h2j77nh6tCES0iNYpfRLlVhWawqeujhziTl?=
 =?us-ascii?Q?8gGp+GgJvRs5daYpntJbEvgalx3qqdfEeZZTdyuyU9qBk8a9SzCQBmqUMFH5?=
 =?us-ascii?Q?Fd4Vg+bJdxKv4DlIxxJJS3Xp9zKP1OSI+BTSpfkrDMCkrDhjUQoB9ZwH/s6R?=
 =?us-ascii?Q?yPnaoTFPurthz/dWdRmuQT/BWGUJVzGxPCPn1U2rNR1ypXJUUkPHfK6ze1zD?=
 =?us-ascii?Q?KQ7k6665OQWJ4LKPmIBtt9KoAC895C3LBegmhJ7U0MnJHmD0EfeIgdpX2WgA?=
 =?us-ascii?Q?6Uo1kbGdSTwwq8TdgNGYHjtH1rYaWzkd7+VK+HZEYl2+t7iA307tM3GGiycX?=
 =?us-ascii?Q?HiDpwnDV9PksCo35UQoaGd8tSbIxnpB/MN13GOymgALdkQ5dIncXirnJWJOQ?=
 =?us-ascii?Q?9Ru0WinruwmB2sm7DSgHNojs99sYNLn34tNX/0wgMNcItxuMSKmDtFA3g0Je?=
 =?us-ascii?Q?+GKBgf+UxUzo6ivG/1zFTJLt5UiYUc2xH2wHmkrD2tcSzKqkkvyscqjhr2Tp?=
 =?us-ascii?Q?TjnFMjVNK/eVojl456TYePEKPGM0BzMPiUZHRQjPI51FNRLS8g8v0V3MNPsf?=
 =?us-ascii?Q?h9dnlvDRewRZvPP/TNWnN2lmO2MHvG4dIPLBKNHyp6lVKE9iSfrZ+nrrHK/6?=
 =?us-ascii?Q?o9ZsALWJOvhjjwFSwj3RaoctSkh3w2Mnw5Tvzwiu33SBK0LzT/x+UQQXcqV6?=
 =?us-ascii?Q?RDE392jlz8D7yta/poNJH6fmCDMBme1Of5FBAtR26O/ohBgsPR2B3WF/gBLv?=
 =?us-ascii?Q?HNExqeViAbwdsY9HFsjsgAL98TjouQzBFNgVJ58kAqnnOWjaAh679YEaV/dE?=
 =?us-ascii?Q?rNcCJ7eQnU46cAl312mITZxL1TcctNxbEXYHJAAd3yv2NDCV1ho1vXzWGZxH?=
 =?us-ascii?Q?t8cymJRQ5dkM3KkujA8RmHlTgarChEzKFDjRkq4C123pZJ9W3+3zEW3w68J/?=
 =?us-ascii?Q?giXe4Z2aeveloj1mlgO975jUUD+QaL2JTGEOsGuf5il5DLoGTyKIbZJnfm1U?=
 =?us-ascii?Q?vvt02YOXy+Cz28eRJOMYYx/FNybcU88pk/paeSatafFre+aWgKzhEbZC3IB8?=
 =?us-ascii?Q?6fdd3em3tyevFEjyHRHFqOOiKXV6gj+xye7DBCf5yKeHxxeISPxz7LkTBhda?=
 =?us-ascii?Q?xdanOnlrgN4F9+hw19DLhMBW6BmpnYa91dmPAKewpKoPPAwHo489jn/4iPUS?=
 =?us-ascii?Q?qSEFVdlj3L6E7oH/kXWzkuHfmLFP6XkM8r/Z1RPAWrd0PdIBpbr3UkChHsOS?=
 =?us-ascii?Q?G3OTiFHb1oFrSrdt9JZsusGksbbxoSx2Z96cYrva3mxwK546uQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c055955-9119-45fb-0808-08df3dd003cc
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:39:33.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

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

