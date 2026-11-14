Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794623675;
	b=dpTE1WzRJvNR5aw3BeAGn3TIdHUf15+QCxjaaBYnv+DN/ft1tg8JxI05H4nshe/spHcj
	 PwVUlLNtlvgIRM640DHY0RVprlrvZGxIyl3snEr058FU7CwkSXHVaZcV7vuNFHl2dLHq9
	 BEHnJoHiUL7c1Zi10PGVxHiKjclbsoQznU2KiF2Uc8SDEMEOTU0o6LcR36QLJnKMreKbX
	 AkQvMGVQONIFG/UTyhRooAr16QhDWBuF5y/MzJlezyTRLdAy0u7VSneDuZ3BpRczLjsAE
	 iEaQvSUa6J76gjWjrsh7XOhB1jo/h7nJSEoVNSdf+hdycKDm2d+rhxAlYg+k+EybyFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623675;
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
	bh=nMVugpJVmaGQOWeOhl4UBMatqcXTFXwvCmd+T6Vgo4w=;
	b=J1bm8BKDGit9+QZ3f1YTaU4KN1BdJ3STEpVz2znIuHAZqStsoVyq5pEZ0QlI2YPlsooH
	 PnRCxo0yIcy1CkFcjYEcHqQltTVvefuIpBst2P28NyehUtT9nuEn8h3X0QFqs/+YU/TUx
	 B49ZWvK2L6SJtN2ozRnvIFjKs4vUKHtPmaScan8ZkslrT/EF7I+NU/1Kp6tBy2WPN3JUF
	 3WXdrS+VI/2F61C/vwNcqRVe5Al+C8Zeumo9GHMhylDjuwTiW8Pm8kbKMHc0fE+g88sEA
	 54Yaq/ge7WJiKjMgOScPauZAt8fe5no/WzO1S7Yf7Biw3exVXjfff3mJP/gj01WHPww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=C3bRTP5F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.31
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011031.outbound.protection.outlook.com [52.103.12.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE7606A323;
	Sat, 14 Nov 2026 02:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FE7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=C3bRTP5F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UASkcbkC83rqzsVAoXEREUge4sDwAyHqupiNDXjBglODP0pxkDDHlofMDSTx0hSgubhbRIaR3sJQDdDXAhqNUgMn3nzZmp++AuIZD9huV/y9GJ2CsFJrYh/6yheDRGlSLhdgBoPlaEO00EYdnYinRMP+QjVIT2FwaWZyJ6tN0xakTREs3XJNFD3zMxGMgU/6x09NTs6ABdYeqGzObUn9iHoae0LLbaPB9UmweQZoS5Fm2sdr8OXbdXhlDZgjHQxjkXrcZ4zm8VGVKvjfa0W+ZSJh4Y5vIrTtJxfpjJEaxjLF0E7MqoFMamUEVuFHvJbdsQApoCB9AJwgNjQQ6fV7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMVugpJVmaGQOWeOhl4UBMatqcXTFXwvCmd+T6Vgo4w=;
 b=Y8EDnlMJ5gmK8j0px3dya0tqQ+EgsPSk4CBFvvg8YYcrxV/kzWZ0fLKgE7l2rrNT0oJo4O6URxhIWM/6a4Ub0okTC5g3XuU9b+YJGlyI4BGC7dWOykJGrF3d99jnOg0+Fj9OTuR9j69PeBlJXSlJA57Q+1PMoS+T247QIQw7vL6zirhX4x75YfErtJvQIRyVCmYzS5D3LxkaMOcD2czI0csdb5LP5YaaPESFz6NsmCbM8D88xwUkhw5KAwzfLgLtWXT/DgCF+nUnifIxgsznFprkYT4kDQPZyfCkZB7smjaRotxj7IHrfFHKpchjz2n/6HJTcdqnKHCDsWXe8I3mtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMVugpJVmaGQOWeOhl4UBMatqcXTFXwvCmd+T6Vgo4w=;
 b=C3bRTP5FW6AW2QOjSPipVWL0uQWvkX66z0PoJcpJUKLiJLrYF00/xKMhEw/H/4SjnbZ0Oj2wr3HQDoCS4125f4uwDvv5T7F0KXtGP3EMnxbrWL8to93aRXvrTDMsTTbf/weAYlHSbuZgLQC4jkJA9DL+yqivCIugiJnvooDJv+N4otpKfEQnq5gsKx7TfXtQr+H3inQmL9F1TZU0s7OFT4AIvkjq6LE16fwUo56G61ztMEZLUP+RByjt0iQb9wxCSKhM75tdAC5Mhn0xH1+Tsqupxp2lkqD2GoKR0gU8ydcb8wsvDXlnpwbAH6u7TCxGt/nUOgKtibHrRsBNJSG+Dw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sat, 14 Nov
 2026 02:33:30 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0615.008; Sat, 14 Nov 2026
 02:33:30 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v9 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Fri, 13 Nov 2026 20:33:21 -0600
Message-ID:
 <SN1PR12MB2528B9901C2150B1B89ED4DFA57E2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113014849.06ab464d@jic23-hlaptop>
References: <20261113014849.06ab464d@jic23-hlaptop>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::21) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261114023321.838275-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 647061f4-8d7b-4174-2cea-08df41f7ab2e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22091999003|22121099003|23021999003|24121999003|24021099003|260925184616899003|4140399003|25010399006|5072599009|39105399006|8060799015|15080799012|19110799012|40105399003|26121999007|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQU/souYr/BZyMTUXtUy4C/bxbX0UjQgRzvoT3nxRawHgRrb2PumNs5Zi5Lu?=
 =?us-ascii?Q?///7CggPXEFI3/y4WC4+uk8a8fgvoUvBYNgY0wXBVrB/yO/Mjxu16tIctG2E?=
 =?us-ascii?Q?jto7VJ6pUk+dnxe0iNjQYmO78+kCrfzbF1HwdBIlKGmDGNLrEOzaXKDIDuDN?=
 =?us-ascii?Q?PbnGbdLJs5+dCXSJcacDKJqt1m125FH1bNkg5STAgMYw3dAJQWJYpgZm8FeO?=
 =?us-ascii?Q?+t4P2+5F2zJAHOVP2imOukeiTjTb29C3WMGP5zRQHJr4JIHbhUjM8bMsGnZt?=
 =?us-ascii?Q?6mB1W1YdyzQOkHHNHk17NPw5ts0pLjJWUgN8ckzr37tGmVLMX7LOeyV0A/uU?=
 =?us-ascii?Q?Z904YwKzeq9KD20pldSQbHtWjYXARK+XmqFWnX9JI0o7Rs05jneWXIoKYEp9?=
 =?us-ascii?Q?5rY7aacP+Ix5+brk4KQFXk6jS1j+uu3YMS4SDnv8LJbI1R2oIoxTW24VcEZP?=
 =?us-ascii?Q?WBsCYs7G7S2xyEjh4DeSBCSnp2n8r7DuDFLYG/mUaYsQ1OR8CRBnsgVsZyLO?=
 =?us-ascii?Q?jCcmat2Mq5jJKIf2hm/eMF5eDrnZlAL8B+JaF0FcP9G9SFdeW+8Tc7wfjynd?=
 =?us-ascii?Q?jgTFV5cBMIn33GQuQ8yIrxYOd9g7Gy5D3aDkQmc17G1g2M1GAJh7S8WRgB93?=
 =?us-ascii?Q?AzrDpPQvwwmIuCfOjI8lZQYxVbNo4bt4MKO8T3iznn9DrkCz5ZS9kH5u0hD+?=
 =?us-ascii?Q?kTZNC2hGEE0T6ssa2Q+UJW6cYfNc01cb4SCDsw3nEm49fdQV3PLw2C5kPPAP?=
 =?us-ascii?Q?3V1/7pe/OdDEH33HCVCLlgS9O1fSyPqtvoAj34WvxKYMNAg7OBpeOM/hHXP7?=
 =?us-ascii?Q?h7YKjHq2PVg4fya7GtpROZ1deycEytX0hJJOzIETXuDYSdp9QE6bnYr3Bgn3?=
 =?us-ascii?Q?/t4pdGBvYA4xb+XS+LUyRVLVTRU91l4kfxKwkwyWHqjxHQV/f+KW8XLy0A00?=
 =?us-ascii?Q?OJHXHQHDQh/ZX1hXKL+IsBMHlEK5KgV13OYyyVqJu1rNwb4fsZoN4Z1QrIFW?=
 =?us-ascii?Q?PMDGy5LoWsNFH4JLt5nn3EbMIfwzdJHIBDGvDD8cG7fD5kmnxez05AGDCQHL?=
 =?us-ascii?Q?aXKLUy9QUeuvz/NMqvy1/8MLMcohgUhBqFExGyMqQhYEqEs24VU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wn6J16HP/TZ94Je8q+WXyqqzmEioodrgbN0NfkJkdlgjO/7nFynNpZ5wO13U?=
 =?us-ascii?Q?mouoqfo4pT+6R+Ljn2ricwQ8rcDyfgx5D5KiiX2m99Ac/dfDVumH2ORVjwD0?=
 =?us-ascii?Q?uod+Yiwj86l7KUSBBVYP0sWzhOsr+VsvWBs6cPt4bT6LOAjOqfrVnPojDyuY?=
 =?us-ascii?Q?TbIilq4RuNyNvaJ6dEw+gGO73ZZSKumMVA2arvV/AatZf1qF5FPkeAVOl1JR?=
 =?us-ascii?Q?WVEhzBwOCB7MIcl/+3i8OKBAY/8LLZyBhVFqcMLCO7G1nO9qQSv76GaonYr7?=
 =?us-ascii?Q?Nap0i91Eb1tBjPd2SnjdVhyFyJYDU7tIDoeBSNsMSTZCMrpNw9VLSaajcTaP?=
 =?us-ascii?Q?tYE6ncvSY7wgrkFZTuGnXKqykooYzAffw+ke/UHIuwSA+71uWVPUqdQ/ik//?=
 =?us-ascii?Q?GwXdJRyKDsC9XF0DM44yoGW1n/742XM3zBZZ4S8xPLDmb1btjGlQa0Ldb66J?=
 =?us-ascii?Q?sJTuOUeVR7s5e3TqlGpmGZDBTCla0ZdA8VW1OmtTRtJ18TmyGjFCTfEn6WUZ?=
 =?us-ascii?Q?p5gZxX1E776Ii/ZHnXxd1Dkv7ZOsf1VZzg02fPQWEC88SbyM6t+jclgfQBKi?=
 =?us-ascii?Q?YV8LwCCZ26PEmElNzF2SGl92qI+D+lAVC5mgOtOxhp0LsoZETx2W/JS/yDWL?=
 =?us-ascii?Q?91Bi94h8o9IXRZl6WUYQy+RTnTGQ1l7DNSZXHxCNj/ukAxQQyQ6aYiK+GLMq?=
 =?us-ascii?Q?EiuOQYST2kEt0Bq9+trVbBdzbmfB3ESGBqwWR6BfYzjjLvKmfNktLOZBOESx?=
 =?us-ascii?Q?UiSMO1oYMD6NfxOrrR/JFephmh47tgCqlG7Tma6SaMDJeO9SRpsvsXiDFUKq?=
 =?us-ascii?Q?6I0C/01pt9aLFk3tWBDjpa0XvmCenrY0HK4+ME+JvrvjMyZ5W4F5pMbklj5H?=
 =?us-ascii?Q?QgoEDA6Zo9VDvL+NKX4tXrjqzTwJWlwNX1fwb43RRgrO3RpesClMP6BYxA0X?=
 =?us-ascii?Q?/NE+wg2ZvMdxmkAs383z20UzDA2KyHmS42bOr6XHX/T2zmotfKb+1/qNWDT4?=
 =?us-ascii?Q?qt8BWUCf4pu6VLQxWuURUMIAMySEQP5+2W71HakZ7fVDtLcHvkOftgYMuvil?=
 =?us-ascii?Q?OmAzC2m/RdrzZEIrQ+LHZafvJxO3sz1TatsNoqWorWPyuyvq8TCjoLxK8O4Q?=
 =?us-ascii?Q?iUy4wgc1JiRja+FbUZbpV5cWG0rXFg/6hU3bw8U3uJ03TjH/Vn+5O+fGIvOJ?=
 =?us-ascii?Q?3EVMb0vGl1GmhM3IJQLQi4S/dyRYpp2fvGDi3QoIh1Bz9nZmTEvO/Yw/eHma?=
 =?us-ascii?Q?48o1HI68Bwwqb278NxvEpua/CCdaJ7OFQidi5X4t+oe+ZZKkcnQEFr34GKbl?=
 =?us-ascii?Q?b/cBpAzTe4BNRC9Qx/REukrlWCPLEpRw38rSmdP54La6izQ5Sdc7L0CPDT0u?=
 =?us-ascii?Q?bwNsVFW6AKAOQ/Nk7dGG5fVg3U3e8vHP9v0NsRdu5J/1HiJfNw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647061f4-8d7b-4174-2cea-08df41f7ab2e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 02:33:30.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

> Applied to the testing branch of iio.git.
> 
> I'll let the bots poke at that for a few days at least before
> pushing out as togreg which linux-next picks up.

Yay, first patch merged! (^_^)
Thank you and Andy for all the reviews!
