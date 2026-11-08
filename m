Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794166061;
	b=MYqFjlIhcseS98Rh5zlvw1m1bfLph4N1s2tCLw64JKmsMlyYuky04P6O+pGKCpcnSRDP
	 QfXwre8r6SpmpxrL4NB9xegHcWycb8mBaJf0wlHwh4qyCYNVp2Yo2kSBlkxadchHbl8kK
	 W+t1sUNtCB9o4GjmAW7g8AUcPxz+W7ZOQ7+UB+z56gtATS8c/amsfJe2KZgn7DI8aCRjL
	 /VtATAjcL5Idsi+dv0rTUlgYniA7nm1lTUlKtHewg1MahqcOdrTHwq5oShQbi4zTFMPsw
	 2R7zGxVrK83Qow8sFi9ZMs6EMyGN8nFqZCOzGKYQUYrL3KaeM+h31q5dc4+v7Yxq6jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166061;
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
	bh=DBao8Y96EGDr/v6MJEwAJCQHJNdZxLdh5Kn1dD67cC4=;
	b=jUHVyVJRAZGlMCjudr+v/oQF3XHCEELwxP8sOeMe4mdbCTbZj8eaQBPjL1QJXFfNIxPJ
	 pX+qX70SiR9Cqsv2dSbGz2IAMGDBcZzZOuOmwdFwyt0nE31of6keuZwc57gw1TH9GnDRs
	 wmtJZ43nSb/LDVOEFWcG4bXkCbI7TagucowLsFbN/UcEa89AAZ/nbfATAHufumXvpPk0X
	 3eAKm95bIWhYQh7jfmUrqD3CQ+Yq42HmmNgbY0KU+7YYYPuff7AN6YZTl/97S4tqoZssB
	 5Vi0gSgWxe3Cgnnf4q31FOyDVgcJIG8wt/FKl48EOT5jQhD8IVUj+RuyxxXK5KxxSkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=J34GTDnk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.83
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012083.outbound.protection.outlook.com [52.103.20.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351ED606A31C;
	Sun,  8 Nov 2026 19:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=J34GTDnk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhjJzYj5QS3Ar9huXJe66bHuYJ+o+DIzyHRq3c4bm5L43QWjMGZD08ers8DtaSnpG7jmL2SX1JLa5gWUIjVJu5Vh0zXH2AUp3n5DLC74HXRvusa7hLKaAXzOhB5KDOEJIQHHR4oDC9vGjTNKtGW4TWeD1/s/VWQOXAZYssysX9p5/XB/SksCowxpPAcUhUzXGIsqMXJTkpWmFp15QNF4ZaWiqXwmhxeRAqATHQrUvAUgSsOxBJoascbZA5MYA8mQ//9gXaDrHXj85Y+ximeaf4S7B5fqs5AiWJzU8Ivs9pV7i2XfDhm7L8Wn3l1VPNTrGNr04Acs8SE76nsC7KoiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBao8Y96EGDr/v6MJEwAJCQHJNdZxLdh5Kn1dD67cC4=;
 b=G3Co66q5tkvEoYUw8m0CeBf3MiTSrxdlXidWrQuimj5IyPP2+WxwDipUMomKBOznDXcgpzuEsErg76vOAKKgKGHLd8/AdAIJPsy3q/5qTkcdRuGqQk0A0b7UO4w+TBdTS3ydalV0CzDJmfjuSDZuIHWvkKb9m+DSOaz58FMQVjv7KX7iFv93uILD1VR+nswUJslFSAWyVEegKsqcTIOg9D5rDorEs2zihZ12JrswLpSVk+PtlFftfFI126vJxZkPTTPBH/JbmzXXfQwo8JQYGOM73tVBESZcSDbz90tECnA72zOWS2gIeStyPYsHk56YS2Hs2Et/qc/ry24IONxlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBao8Y96EGDr/v6MJEwAJCQHJNdZxLdh5Kn1dD67cC4=;
 b=J34GTDnk/qavVr/hCa8lguU1vjHZo1nnEoExoUVslOuWV570g1objpa1dqs+q31+W0IXYTDAfkZwKr8CkBjXRB8MtY8yr4KoQFliOlx8c6DoGzryDE9d9rMPw5+/upoff1lssYzGM41VK5YN2WsXYjSgZR4HvySzra4sdsPEPQ8ah018PVT7O9Boim0E/B0XpbDyo32oF5Ae9YNE1QttRYV73ELWrlHTG+v3EYOwzrXFOnfpJ+2XgGeHBRjt4On0BPDSuE+0L4yUViRMlC/e6DDFSf0uLJY/294hdGk48W8xQytNOOgfb7e0BREFNkETKycA9RFDY9m4w8qQB10gSA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sun, 8 Nov
 2026 19:27:37 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 19:27:37 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: viral8854@gmail.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	robh@kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: add Infineon TLE493D-W2B6 driver
Date: Sun,  8 Nov 2026 13:27:29 -0600
Message-ID:
 <SN1PR12MB25284A7D4A3B1D41C92FF7FFA5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFkCdFzQBHMc1CvOJFQY+mtepU12UrEQfWyNdY+rWUYW5CG7tQ@mail.gmail.com>
References: <CAFkCdFzQBHMc1CvOJFQY+mtepU12UrEQfWyNdY+rWUYW5CG7tQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:610:57::36) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108192729.975056-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbdd495-a2b8-4258-96fa-08df3dce587a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|260925184616899003|24021099003|22091999003|23021999003|24121999003|8060799015|19110799012|41001999006|25010399006|4140399003|5072599009|16041099003|12091999003|53005399003|40105399003|440099028|3412199025|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQwt9o5N8IdGi9+wlXCpDXTxeCohM6rqqpw20o6ePbQKgvgqFDaGYi4WKUaU?=
 =?us-ascii?Q?WpvIqG/kYpcBRM1gWOEsooAgMz59iKu9V0FTnhephjEOct9CmAvrLAnkbkf2?=
 =?us-ascii?Q?kjXuozFb2tHfDxghjHdkzVZiYQd+2qnl5+vpH5workbi10aWfYrtsLV3VaE0?=
 =?us-ascii?Q?tTbh0EDqjXq8wvm2GhBSKEFDlizbGp+ZqQF7Rwghkk/dd8XKTFOHCnGITmPg?=
 =?us-ascii?Q?8cmLfTl/mPoX2txizkUTxS8SndQlnY3RtZeMPqj62kgYVBzeojaZWQvp6ZC2?=
 =?us-ascii?Q?e/AGEIhcDsTu8ZfI6KrqinHYkRitJlRfe3hwWVu2wPeewqNDRddw697UxvZx?=
 =?us-ascii?Q?eFYAj4N9LYDLrZ98MeHgqujP/JkdHMaeReDKZYtSYAi9zoAb4LekVRwE+OV6?=
 =?us-ascii?Q?AGumRLqtgbyeROitdKG2AaKZ3zdRHKmbJdEOvtx8yviA4NdmOabdyLbu0WTk?=
 =?us-ascii?Q?i8ea/Bu+DJMUMcuwO1b4DRRQcqHUfMaks+7GFPeF6AKr9qZ/QiXETTmFs4X1?=
 =?us-ascii?Q?JYcAapdYsnqYYsBmsqU1THjtS0E/q2URmt6mZLP/iEieBF/7Q3FtQf5V5stC?=
 =?us-ascii?Q?RQFAT/mF5LW/4Ig2U3DCMFyc0xfpwm0zwW5BJ6Iakh1fr+bjuSbpUsjvppG0?=
 =?us-ascii?Q?nANJAQ679pXjk2DrazHWpFoKSAgdvScaKAzH7XloxOQB3wX6s2K1KnMXV4je?=
 =?us-ascii?Q?BVd4H5AFJasugDaxKjqptlVvWXpUrQrIG9LczacNWeSXhEnsiFRdLOFzS9mH?=
 =?us-ascii?Q?m0+t/kCN8dVIRJsgH86/k4CaFBfGd7FJv1L+8P1l6nNH8BrqoUtvAHcIRoVN?=
 =?us-ascii?Q?+QgU7kGneFCNzihXpEPmPo6JEvA0quRKBfu/GAQ5vPew531Ml/Qyha+cN4Qv?=
 =?us-ascii?Q?djRunkDcT9DnWmwHw4TPA0R62FA+5Wtm8E9xTrrOeor0/PINxhanoF6GEGi9?=
 =?us-ascii?Q?9KZZX0pCwoXucZT50uiZ+iXMlg4iapBJ+iu7aNvOmuY2K6MMSuYx5QERVocF?=
 =?us-ascii?Q?66iif7GWFWDHTuNfGLoty0bvIymiE6KqFwmBOzAx6/RvfHv+B3z8ZhZgAGad?=
 =?us-ascii?Q?+UW4xMu7U4m7lrgKv0rE6JpIE96hM/CmO0gYRzmKbkF4e35SCKUSgVaqenNI?=
 =?us-ascii?Q?Z+Laa8CtrkK/GYA9ovcbX3pGEejGrvFviw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YlvTVedTiQrTasc2EPz34bAuxAqGaQhXJe9RhvAlSj6zc6ilFpIOHsE7g657?=
 =?us-ascii?Q?hs/VHad6MjoJwMUlRq+L+QEf3AKGm2/GtHASUdpVNIJrASrY6MgzWAd27zaL?=
 =?us-ascii?Q?0wFbaHp8SYvFH1NxiOZqS/0tdOMJj4IPYc1byEQW4GWpYkS28zzldkLEYAei?=
 =?us-ascii?Q?sXyVp6FoKNJfxUuyntxP1qhFhBwL5GHcuFaUiKngqucrnfZT7JWZEY/MwyK8?=
 =?us-ascii?Q?sFRUNAHJNmXGiuRy5czzcWRYgleuysA90vctOTbaHdNn2O54eJgVmxZxLzWF?=
 =?us-ascii?Q?aU1AmsnrXHzc8yBx+BUJ0yXMyw0FK1AefQ6TMnKhi1SR4lcnlElFFwp18gcJ?=
 =?us-ascii?Q?iEXsffGXrLoteYziwhhP0PMVs+4Vmz9aty75kzcuRiVf02I0N4M6HBy1yO6w?=
 =?us-ascii?Q?+/Uz/Uak2e07ngOvaZ95w/uAVzTowa38jPToLZmfgcBGDRFuN2yTBcxTRhd3?=
 =?us-ascii?Q?MszBLEVPLy+9P4Y7cTGkM8asfodArDGghrm1lcDhz2eaFKR+pOgXHyHUSFsX?=
 =?us-ascii?Q?ZQvj2b80CE5AUC62FyHt05VdgeMgh+y2Q+xGyCEAOLmHzzl61njnjjDJH/a8?=
 =?us-ascii?Q?uqitvZhwIQtxyvFipy+aEMW8ZjO2q/lbqZ95C0Yf1gqemI92PUmKUYJle+2Q?=
 =?us-ascii?Q?B286VBV48pvIwVb05BOHsHAyZteKCEi/cLDMBZT3ITeijOAQWPX0vPEms7wo?=
 =?us-ascii?Q?SztZJC/0efYBWkQWlbLuKkNjfs0VQbRAh0SRYhr2WPVUV7vfuWvBmZbbEfqD?=
 =?us-ascii?Q?+MgKJ6VfmPu0/Xl4TwscQ6zYXFjBlMsg5oXo7XHFIxf0boHTR4q8tD4ua/k6?=
 =?us-ascii?Q?TNVWJybz3X6kfKObRsaXrLwz2qYAsd5kxf5bfnupemqdXzmtjQIX+rs5m7Jo?=
 =?us-ascii?Q?PwqHVGv4j63oX1VvQVad8LLVil/cUdv5qRd4J1fTM1dvernFfxYQLoAHajB6?=
 =?us-ascii?Q?xz9aEOv3b08AvoeeZB0kib1sI0jsIAErRE1Wa7RVf34MVSRrKltTu+TqFuvS?=
 =?us-ascii?Q?iiuU2L2bd0syj8c+AyDfUsKyD6zK7Eb7PaBOtM4x50buyBiTr0t7twDD8xq9?=
 =?us-ascii?Q?V8GrtOnnf3xH2t+/jFPjMZ7ip642SKAKbvb1yixEi0nPr1sgeYkeS2+ItgWw?=
 =?us-ascii?Q?Qm/OmUrLXtZ1rqWGRU35Y8eqeNMbs+tmMRXhTN8CdQsT/Z4RmtQBi+xTFw2P?=
 =?us-ascii?Q?ecVQ/vP3jq58KFYD5EoO8Sl216vyBIX00C7AaFmkiBltTVRlI0QwQBFrxvFm?=
 =?us-ascii?Q?ke0c6Xixkf3AElDRTZWqFwj/yESzQDc2FLdwbDH/d3s3b06X+hCrY7e+kCa0?=
 =?us-ascii?Q?eF6QdKjdRmdUQQ4qt/B9hPZwRkf7CDKYLj8Mij3lgX9ITj30u6bD3IPr5y+9?=
 =?us-ascii?Q?ITmjCY6iHyM0GVD2XSkYCu4p/Qw863lBjNrpdkUH8rDXrPCbtA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbdd495-a2b8-4258-96fa-08df3dce587a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:27:36.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

> > > +/* I2C addresses selected by IICadr, i.e. the default of variants A0 to A3 */
> > > +static const u8 tle493d_i2c_addrs[] = { 0x35, 0x22, 0x78, 0x44 };
> >
> > The manual seems to list these addresses as 0x6A, 0x44, 0xF0, 0x88 (Table 4,
> > p. 14). Can you explain how you go from those values to the ones in
> > the code?
> 
> Table 4 gives the addresses in 8-bit form, that is, the 7-bit address
> shifted left by one with the R/W bit in bit 0. Linux uses 7-bit
> addresses, so 0x6A >> 1 = 0x35, 0x44 >> 1 = 0x22, 0xF0 >> 1 = 0x78
> and 0x88 >> 1 = 0x44. The hardware agrees: the driver probes my A0
> part at 0x35 on a Pi 5.
> 
> I'll add that to the comment in v2.

Okay, now that you've explained it I feel silly for not getting
it earlier :p
Feel free to add the comment, but it may be unnecessary, I think
the problem is that I'm just not very familiar with I2C.

