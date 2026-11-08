Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794168627;
	b=KR1x4/XT0NlLoYtbB9sJumecM9JttXObSjVXldAOGNQKL7Jy8TveeKow1AZubJpEjkEz
	 6TryxKEUG6g5LzfBsajrDKA2TN9wdJ1aDukQFXsZEnzNWFfq+PFjcmSzhZawdsyNqdpTq
	 9luoF2r20vYZPegS+bnLFEyG80BbLQ4Wjb0MGCNWxBqBLSBDjGY1jNJBCJ9pkSPeVGI+n
	 HwZzXpH70cMLmARTOuSSFO9nVwVgNyHN9OZlJ9sjb0C/cKF8+UuPRdPKCsbhwDD1kpe6v
	 xctv/rJoPoUmtDL0NJhl5H2EbWUN6kT2WwSIGPnGr2P2wulvUbuN2bMAtvDxib3fFqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168627;
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
	bh=hPS/4farMvKEr/7pCUxGB5KIbG2h5mv2iwpsug4sSX4=;
	b=fe+wwqoBReTUYGqozDkiB5OKnHs48qySz8CHGBMiJuSPv+yn4LrsYL52L+ZiIbFeNT5V
	 Uz0nsS0bhBVMlUJQFpKcpddWW2dluSyxzASBb3VInmThCV//4CpX57gwtADd7h7usDpvb
	 3PIx+ZwsoukDLPciBDnavwbWVLx4JMyaCU07rIaJpeTHKw2F6iLTvyn8ZGoD2MovCj1Or
	 1e009B8uqYp0jGTfrnARcxPE8OZGCNqpXPWT7A6bC1qRV5m0MKrq/9kKXsAHmLLFxhDW6
	 XZBYZiL1HT/4KhHIci/Y5g1QTMh1G3THpgnq8Z7/QOJILF+Tb1O7J9dvLScEZ9HTLXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=GZVj4hjq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.7
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010007.outbound.protection.outlook.com [52.103.12.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3B606A31C;
	Sun,  8 Nov 2026 20:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1F3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=GZVj4hjq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpxfI9WDF5i3XbORn6spR8124rf8uMQQR+Ezps5AM8gQo1T/KSGeTkyG9d5V/bfeNh0B5BdCGDQMkJ2Ivy1Y2Y4lbPRkxcHPXG8kMJFBuKQwUFwwAKCrmMEDlHY9fh761XI2o1O25QO44gtM0kYk8ejlHBumIsKve6zHxUe+MsiZ9cAY1KwJTL7FeQWVVv+WrMHGz8DBSzjRbkzAkCzpWLlV4K/GnAa6/zwgGhNpP7V1oC0qfNDOQ7MDqE+VTSvJDzDIrlyFKID7aqwqBcBHGz2WSsS6zLPLJjShTEtrBVxWdJmw5RWXN1pT0B3VZbkh74lVFfG1eY/d+F5pBTaoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPS/4farMvKEr/7pCUxGB5KIbG2h5mv2iwpsug4sSX4=;
 b=yXVz3w5NZY16VA24YbxmWLG6uK4Tv6wePW8kkwnQ1Wpx6gOgIT7/cEJ3qlw28HHn0w4H5gR2MWZPF/rbzy85srFoVgVU0ukwz/0KryRV3gqx5sPXBKIPExv0GlWbS1bjVNbQylLda9pDmDir1s3Y7fVgSHiNF5NNbsxLGK47XfidsdI/abfvnpS5WmYBoIDOfvl8qxHCfD+Lgf4KK8EZD6k546FRuQX8ZK3EjnNnYSZUNFYyOceIdIAWb0gpNr5tkVRa0P76BWpcaAmCShRVh5FNMPL16+kPw+8yJEw+eWUYCtbbjSmN1L1EaZew5LlpmUt6mpcn26gjP2YBZQv9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPS/4farMvKEr/7pCUxGB5KIbG2h5mv2iwpsug4sSX4=;
 b=GZVj4hjq54tGVhXVIw4THk4c47XxWJvszuwANHrWvbEnpF4EE0V1iYE6lT1nQzZKAuXCQv1dCl7TGNp8wb7LLvdQclo6973rvlQEYRTfg0ejIfnnWGXGNsJH3RO4va+WLWLM+DYDvIMY5bRTLI2hF/OcAaWOGzpq/OBvLHqoD9AaTBc6MMVa2+er5y4hsXJC0C2ZehMytffewsme+jhY58SAL0xeHhlERL/ZFHzfdbc+Jg87eLBpK3pTZ++nZ+k0MNWITcB5gIXRGzWv++6Wgo1Lg1hS7qcc4hVjCD2RfFUudECSLmwJXKcFSbTsfN5jcwEAwvKR8dDCj9c5zfg50w==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 8 Nov
 2026 20:10:23 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 20:10:23 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: chernyakin.victor.j@outlook.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v6 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun,  8 Nov 2026 14:10:16 -0600
Message-ID:
 <SN1PR12MB2528B09DB6EFB6E464FD5557A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25285A6B0032A8A9CF3E9D63A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25285A6B0032A8A9CF3E9D63A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:610:60::18) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108201016.982509-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 210fc4fc-438e-4316-1f36-08df3dd4520e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|24021099003|704163111799003|2604032031799003|22091999003|24121999003|23021999003|8060799015|19110799012|16051099003|25010399006|260925184616899003|4140399003|3412199025|440099028|26121999007|40105399003|53005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ke/1+CwC0qfCj3fN2Y8CMdsFRS2C0rt9zJaVXcgtShPPXuAcUF4Un2SBBoxm?=
 =?us-ascii?Q?B3SAAbt8m37ofhZcDzdQiVKFgDV8rDgiPfkxkm+zEoDNAcUlqWJ8SM8r75dg?=
 =?us-ascii?Q?vLYs+KnLTrrglB7mfluxHJQoNaJ/78Xti7GlOyuqIkvOG0QN7SeEHraI+tw+?=
 =?us-ascii?Q?ZGp5xPMyeOjEpRtbNf5s5uJ6wzmioh/jizAEm033LsR34ED0j3KeONk/XHe9?=
 =?us-ascii?Q?eNfNWQcYm7hGOB3dS1OSz2VH5VLFxmvihOMXkshr8XXB4ayV6PtB9t46cqwX?=
 =?us-ascii?Q?+WCkD8OIe27r7TWwpkruP+0qKQVcZr5y7762LBsjsE0EARIbn4GjjFI7g1kW?=
 =?us-ascii?Q?Oxc40wubxpGQDf46TJYOycnnwwYwUufffPTeMXdj8PRuO/3j2FSP+Qq+XpyH?=
 =?us-ascii?Q?JJoSsWhFCyGou6R02pp5IAOb9Xb0HqrlZtffvxF5Kl9q/F5LevSjAqVnPNUx?=
 =?us-ascii?Q?C/Wf95gm9l+JVX75S7u7e1IL7MoFATEuQAC9Pd8TTFzvgmqrNlQpgMT4wky0?=
 =?us-ascii?Q?bPx5GkCytrivWY15BWyYZHedD+0NtIstYgs8XTAMHd2O8LvVjpOVAhrKVQFZ?=
 =?us-ascii?Q?WYW8+5THAGHptrbQFZf1zkLKQJDqI27hpG/M3mcN8l/bXed2qFSTHRFn129o?=
 =?us-ascii?Q?kYfsmfsGGQ+lfeLl2ioX5n9+oyk7/hZjF276yCzLOPGku3VAd8aQjbvHAYbJ?=
 =?us-ascii?Q?Li1SlbfTY67pm8AJggQjYe/Mg1Q9ilI7IrJaibD+VrVwNrfPR5ebb+GAlk6d?=
 =?us-ascii?Q?W2q21f+MPV3UMxO5/LtHtiUvLqdBZf2dVwLW5qTyfBPyRrap7UUGFBrpRrS+?=
 =?us-ascii?Q?ULydvQ4MGGae+1YiCzlrvM6XpB7Jx7Z8taDBYrPQWDQhQSmkGHedF8vzT11S?=
 =?us-ascii?Q?vqQm8vo0dbJC6oLYJXYC6jsjZH+E4l4hLNnHjfmifx+KE8rP17c2ehRpHLyy?=
 =?us-ascii?Q?nL4k2Q5H7hCm7HqhcuMGhpjVtQ8+rlMmX/ubT4Pw47Srqdk62ouek2LLVOBr?=
 =?us-ascii?Q?TnoOUuXjNoRoiXH+bAFiy2xWBLJ03fqUsO7ilTj+vzw/rtElSnSRWPQzNviS?=
 =?us-ascii?Q?mrsduWmB09t6o2VBE4SB5pIdkq7iLHmXlu7EaaA+OcLqEx8LL4wcQIxtwfo4?=
 =?us-ascii?Q?YuO1F/nsTUG49MAMK+JD0EsB/Vmq3ZQ0BV8tvTTqGTFQ8zDEoIv8QJTN+FeO?=
 =?us-ascii?Q?zLePSEoiWJkSAtin?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wV701P0I/p/blbtIOhrKVM6/RJAsCBjElEu5UnNMa+4YAFMd2DrPI6W7Cf4s?=
 =?us-ascii?Q?+jNSIfSZtQB/M9oU3rYfBMvjea9l7yfIKTgAiB1ITTXu1Ww1/FpC95RM8ilY?=
 =?us-ascii?Q?lA6PYXBgWiGspO7dV08gr6ZHInWTGbgp7j/khVHpCaI3Ge3zJAiMzhwBrVW3?=
 =?us-ascii?Q?S7wdMVKE1t8U5rgXQlOfCpCrBeNEOb7WOzRDwgjYWnPQeq1qmZrwGJ9GRoAs?=
 =?us-ascii?Q?aoD4abfzZl5tiBhWOgq+enHZru9amlgdX5Vn95Ih8pWo+sstlP5SEV2z89Vt?=
 =?us-ascii?Q?nfDCsLujbajj1cpmLgFEf+Ym0QPJQhDHjEphmUBhdzT/M6dc9BTc5uWE8vZJ?=
 =?us-ascii?Q?Fm3RnpECXDBz4vcvglPmKtu5qUjKPQnNDH8VRRux7T4V1eTNTsevZXsN+FNf?=
 =?us-ascii?Q?yUsBsCZNuhh58wRR/4ErQVHFOElze03i0+yz4svt+5PvKAPR5nLrPewpAqYl?=
 =?us-ascii?Q?tsTCNnDE+28R6hbMe0NEGI8ySzUDUdOfl4QiDN6Bty/gIi7wWMaFnLRcuTSu?=
 =?us-ascii?Q?9VgUwE7RE0HtGeWdE6aNQFg2E+dZuZLTPBSGkhWgGRXzgHOM0V3Wx1qqe2g6?=
 =?us-ascii?Q?/bTtW8/Ng9aBWjhYjKTsNZuoceBmMA4bmHTdOtEua+tVrRWAzDax7hCQuKjL?=
 =?us-ascii?Q?v9jtk8GgowMSVBa76LcZ/SoMzpkfb6iKzBtPuocuTitWsraTb5YDbWld2+hD?=
 =?us-ascii?Q?YabUBI4fmJ3NolXXHblhY5Us9KEZo28THf/OTf64S4ma0pQToC6FyzjPLzDH?=
 =?us-ascii?Q?RWoy/JcM31fLFUqsXfwil9vgD/4Qe7Pzs7x+OVmu5UyOQ1fpSJPFU4dCLolJ?=
 =?us-ascii?Q?Td98QU9N9+y2FJlnVLjRkGyXfdLmOtSXlN4x8PNPZr6dF4Oi49+VoXEovHJ7?=
 =?us-ascii?Q?XIYemlQECE6vPscMqrf9iYeUEZLtpfz8Klf3FN/q+T9PKbp36pBiy3jVKJLJ?=
 =?us-ascii?Q?CuPqL3baKQbDpnm2cDEh5pOYIUnM0fb9VbfZV29jm+jKSS5JqM71ZnWCPe3k?=
 =?us-ascii?Q?zA/H3xnqgMnh7498px+XRvXsRyFlMZuO9j0Q8YmFLacagBLTlmN1qM1gQOXT?=
 =?us-ascii?Q?93cXeWToL5JKTlChosNm4jVBC77QLU1BdiVtjyK7hU+BQYMPyLLhsRwKrbQB?=
 =?us-ascii?Q?ixq3yPjsW0CiHvT6ensVueJzNET753QDJwoXJxY5KIzkl9TJM3ZVmBandUCP?=
 =?us-ascii?Q?kQmuSR+oKBfa1zwszWJuTrXv+EL4XX+OPYxkmWa6MUOKwxKP6m9at5YgeP/V?=
 =?us-ascii?Q?g+63TtJFQY8fCmET1SkwFurHQYPqXnM3QnkibSAVOAaRxTMJQDGJLCg8hmLv?=
 =?us-ascii?Q?/Ta0g9QAs8bczIREdGuU2qtsVrIm7OoL6ieF2LoCt9uKC2o+tevhbaY5RnKb?=
 =?us-ascii?Q?qDw77ST+eZXYOFcUPpWRfwDj9bPmv+f3BUekh7Zd7MDfyugm4Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210fc4fc-438e-4316-1f36-08df3dd4520e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 20:10:23.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

I just realized I set use_single_write instead of use_single_read.
Fixed in v7. Sorry for the noise.
