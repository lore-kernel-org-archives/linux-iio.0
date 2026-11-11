Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410184;
	b=0JdtfaohqzUP8cxWkAIa7lj9e2CM10c7VDuSLSBNuGQk0FqFqCX7bgN4A8yY08B5McEe
	 Va6OqwOCygIX2INCUUlrGicnGVX8J+rAz30JS8UutgZUZmNTTOTNt5mPk2F3rv4UPeOAc
	 vZpC7yG9nlGttfnEjuMq7q2siVtz7y4u7+V+rD9330qMe876rQQlDrwh7pTV+dHhLEvBl
	 FPQUnEMMsxq4SpD8OUlHssmjmnPDiHQ5q355FQGJb7HyGpDJogrQKUpiMfuw+aLvlF/Po
	 xII9pnvJjU7HEdvogoo82Umwh+QLAgnQeQth18nsjCbKdtR7jo0tK8v/ud+a7nmo9QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410184;
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
	bh=v3F4KuHTMYYNRQxXm6xhOlGfEZ/rfYIZpt1PkobXdlE=;
	b=twIOmoBRKZrxiR1OCI2NMnvdrX1p7B6GaGfu1SI5xhqAmaWiBiGetIqIN7hUKFeYPbM+
	 y1uIWjHWxRJVFi719lQ0zBMS7oOFdgYDRaZVuDIwcmr/0C0PRAY4v63fazw86HMU7XLsD
	 O2/pb6/lw537XPqrINeJuo72CvILzP3FWGy/SzsmjNmiLYsYK2Y0hfc8Q/kFF52oARR3c
	 J0mNaBoQrm6m3WU1j1SyOlZ9FTPhE2qLEQ+rbbni1e8CTQ1+/EUBVVkqMZRAVp0Dc0hGc
	 AzcYEnbeCI1qO7fJ37d2u6jFoJPZmvu/DT2tXABSDDnsjrLvYn0yvtJIVPzl8frijPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="A+Oj/UtW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.7
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010007.outbound.protection.outlook.com [52.103.20.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E72606A32E;
	Wed, 11 Nov 2026 15:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E72606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=A+Oj/UtW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfxopNq4PXmhvg8W2d8USw8sHJxZnY62MVY1SewIYyEb805zOTCLGO+SkiTDY9XTp13EaIkKX2iyxh51GZlINUf7jVPYFeJccep0pnkdVVKGNYsEqekbm+VEd1O6F03/egZqyiC0pOX1jEQdxNj9KPrwP1a/Uek5cry8guFqxiQ4H58h8kwk9gil22vBXWAhZYqZR9H1fiFoydNG3NnSy36sCftlIvQJ0tV+tVk3y9ukX5UgQbnRdx2me32vh/1QZnu4LHnpiQ6XKIdzmkeuuZHzwcZrsxSeMY+I9nq+Q5myLKdszHqJpamlYfpPBRLKOXR/TYdW7zsNSzaDoCar+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3F4KuHTMYYNRQxXm6xhOlGfEZ/rfYIZpt1PkobXdlE=;
 b=m+nAz2nqlvcPKu7yEzjC4MAQWsy6p+i00ARh4TD2zd6jVezjrLDTybhKXv+IbOPi4kUftAXEg2eyOGq0Yg+ap2bwLzA1sixtpAYJRyIpf9i/HX7orCIg5MqyfeJke4CSj4BSgb1THpEq+vbAbfvx4RSgXYcS1evw4m/R3X3OBz5gRq5kLsQDJNFw1RGwl79RksmLZbgINxPrduxkkN3EXlPGS8Mu4VW9HpaJ99wwQbwT27OJanqNc8fpB0tm9LnBCaulrXkvuLR7PYszDstCoSvSt8YVA2lHAqC+jNPJ87x5Zl2AJ6uOMfw3JHjUZeNgCxQqcO350YBDlZqAC3+MLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3F4KuHTMYYNRQxXm6xhOlGfEZ/rfYIZpt1PkobXdlE=;
 b=A+Oj/UtWC4lLLZb6GK00oOhW1mG/QDu9ffo6phAMapmuJGpgLhgrULOn6CDbCiX/IwIyoK5RQBNvR+yjsnLODu+hqTOc6+aNX5GNJsPZWTFUJHP0aOSVSjfoG1hLP4huwnAuF1deS0scF4UFvRYzEA8idCUhLxtttWHY1mfDriiqHqzuj/JneP7p5ky3cHfDZUIK5Bl9i0Rq7nfUnotf5IzuGrJIe4+q5Tvk8FSYer3pAc3TLQJfbobyWMWFpaUJYX7vGd0BY/Lhr774I6r3ZfNODUyYd5BsvhHphhHdcisqC2v1zcj7ekFi6vdLpPDKpEVN7VpkuNBPetZBkz7BVQ==
Received: from MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:16:21 +0000
Received: from MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352]) by MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 15:16:20 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v9 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Wed, 11 Nov 2026 09:16:12 -0600
Message-ID:
 <MW2PR12MB252344E62EC2FDEB8237D5DBA5712@MW2PR12MB2523.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avSBP7Ib1dYpu_Ek@ashevche-desk.local>
References: <avSBP7Ib1dYpu_Ek@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::9) To MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22)
X-Microsoft-Original-Message-ID:
 <20261111151612.26691-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f695d6-bc07-4ae6-bbf6-08df4006bd0b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|4140399003|25010399006|22121099003|2604032031799003|8060799015|260925184616899003|23021999003|22091999003|39105399006|5072599009|24121999003|19110799012|15080799012|10035399007|1602099012|40105399003|26121999007|4302099013|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31NWSsApF0I8GmZ91jhpXRYfHdDCxvru/no64vpgPAjEF9I9Lgwn3XQg1/qW?=
 =?us-ascii?Q?0J7osJUn56my39bI0Oodc1lkRHaYMw/OxcJX5u3UeAMb5XQ3FblDVTYwABZh?=
 =?us-ascii?Q?X5yKjY9RfAtdhxRyy6ypYTUBbHMUdnOuXYt/IcNtYQo87zCb2JODWQ/WIw8E?=
 =?us-ascii?Q?1OZR2LIcvaRhUCgUABi/YvaKAhlx1dokbxPzuWYh/PKGQavdKYpgQpif656R?=
 =?us-ascii?Q?4CUa4+NEloR1hGp31H1SDYClTo0BeEqTklZV8lCEJXozSwQpgZL15DyI1LPi?=
 =?us-ascii?Q?EOUxKAMaAl+qpUyYcVE0M603+7WPmqUFKGEoBv/0ZqUR9wRYInIIHrf4x9sj?=
 =?us-ascii?Q?ITkOtYtcYPw7D0POHM4EmZOL9mFoeym2U2fUrdV+jMuCtlrYv6B7i8r8+yF6?=
 =?us-ascii?Q?gGsjA5v0VmJyBpgVhDN+UgkTh1SP56o/1Isy9Q9/4RWik1n/WblE2SMio6Tg?=
 =?us-ascii?Q?igDyidKFA+UbnmQki3WorsWVC/N/FOHLr7mPxWB3meOrvurHKDaMirSRYUAb?=
 =?us-ascii?Q?22nlVe9673nCnHkY7mNWi8utqtqEEf1CAqA6PMgsNTmPHkHdG0KPnw9nCh0Y?=
 =?us-ascii?Q?AdEo7tt0iSHbHSDJD7R+i/nrF3R5E41p/giKND2BBAyPMkD3iMczoTmi5QaG?=
 =?us-ascii?Q?5XZMsmR3zZvNOK3qPIP6XLP1Hq7IsUQVT+jkFfYKjjEMsfmn1qupT+ex8YTP?=
 =?us-ascii?Q?yzMTLATiZpqgEZOS8TYPsRlkC27NI8J2QGfh03JT8hw05+uziORZYqBG4mHw?=
 =?us-ascii?Q?AUU1T83lwc588LDUy2w4ObWTngXYSl9P2FwXC7/NMbfhtXjB3d7IpwCEwhVJ?=
 =?us-ascii?Q?ZOCc3B/wAwL3STFPa1ixe8hLUxHUxNMen/FCuGEqKLbM4JxxU4Ynr80ROMAJ?=
 =?us-ascii?Q?umbzPFodDLdfqR/zbeI0fi5RCZrIyIEvWDVtjeOa31pF1CA4Vz74agrxn9HV?=
 =?us-ascii?Q?KYRHB8xXfQJA59JDJ0wv3wv0p06en78u7hR+rYp5zQWDii22UokFeUK/b0nz?=
 =?us-ascii?Q?V6KXv7cNw+MDNcaNCj87iJ2nTi09AP0t5TOnQDGnKLv3luLJWUsXsiGdta9g?=
 =?us-ascii?Q?NPrw/MFrv1ZtGNwHvEOg1DvDHh7RjFb0UKpkc4kVxe+C6DBwsQwY4n784zwH?=
 =?us-ascii?Q?2dbpppFRiFHI0VP+0Tn97kVg40s9UU530ocLsXZhDzgTW1kR2y7+g5HmO32N?=
 =?us-ascii?Q?/3/0F9xVNDbUEzfG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4XWjfSYtyHKJR7/VCrJoIKVT6Ha6M5/kFFsXpHSbR9jr9l/372BhY6nSqAI?=
 =?us-ascii?Q?xUo+w6g/sqkfAWtOUH2wRipHI7tbXb8tIUyC5s4JWDjFNoqCnkPIY/0fRG2z?=
 =?us-ascii?Q?IxyBdd7VQ2g7h3Kj0sturtmo3O83R3QNEghEfNLBjcmfbUwFiqKFJQvq8niC?=
 =?us-ascii?Q?lPhMApPnvKmjnW1uoT4LN7EZyZXdCUPDhJyIfqmsxlOjiE7SD9uKjYs97bIW?=
 =?us-ascii?Q?rV/OATsDT1GfWyjqmCw13RpAubcCxA4gIiy5/86zz+3YPYR8SwimSDnKoF2F?=
 =?us-ascii?Q?3X218+zIDjKiBhseG7PpXd70gJPLzaJS2XIgje+BgRXpMdDoQldaplT1o26j?=
 =?us-ascii?Q?D6oAE1rMuFUySaId7vBmQy6yXRf3VU/44IKtir5ofzWkfrVviSQyQcRAnDtN?=
 =?us-ascii?Q?bR44mfEVdfNAKcV+JdZLm0BiCucLCUP0MNIF3XK3b96Mw39tHDLmK9trloBI?=
 =?us-ascii?Q?4/JCGgNQo58Otq2JkpBb03SfUu8GhMqvNNK8B0K8NcIND5PCF+b+LHJvjqnu?=
 =?us-ascii?Q?Jdn/R8b5aDB7xHzwP5VC2e5onKYZfjoKOuj5LJ45nVtKWMEpz5OyjxljUkZ1?=
 =?us-ascii?Q?IE7fCCQMVdfjE6PDx8A6ZE22gV1HGYtuvLPaT4E7/bJ+PSuW9nMISsMtq5Ni?=
 =?us-ascii?Q?xi2X/+wRUrp4OT0W2+qZJrl4ow2prgYe0ONzyolAqzLEGOlH+IOibeVKKQty?=
 =?us-ascii?Q?bRjGoqoVS3u4NENO68FvWo8Ze6rkyBxpvbqPiriRIp3tvR79esMeUQXZGgj2?=
 =?us-ascii?Q?nZ2zDXiZCn5xOtQ7JjfsmTeCQ/eHyZ3MDG4QDB8lxZNJt2ZfEBzjWqN4D23Z?=
 =?us-ascii?Q?miGYfcg2y0GVfVT4QLL0izYvID3nJ4jaX9YutL3DsfdYZ/98V6SitZqQHai5?=
 =?us-ascii?Q?Z5/GATLf3UK1tL2K4jGbiIMIuV56hpKiRjtlatwQ1z+hmF8Q05msUg8tCz/z?=
 =?us-ascii?Q?X7ByVvdxZxD3ecHE6kOxMjUitByBxkW2u7QaUKPLwbMu9Yn07qetoVPr7B2F?=
 =?us-ascii?Q?dLGl13NT5v1Y7+ogmQUamb0x7yk4OLu7EpWHuF48WH3NWimZTNG3rhXKsnd5?=
 =?us-ascii?Q?yptR3LhMIGPFw1wicWKDa2uGiAITQwYVTwj9G3ceOlafaujkIcIRj9KZRkNW?=
 =?us-ascii?Q?peE7/4SrdM7d83kS3vq7wyyhUPIFBoSqpwnC1vMA5+qCdKIXFiVLq2jK1kRz?=
 =?us-ascii?Q?4gi/oZe8jvE928l5cvwER3ecFaz1Rf0P9D0ZxrMdcQLWJXc1c0EoiNW9jBId?=
 =?us-ascii?Q?ZarDzZUqSak4ImhLCuae0wt20mKPke9NjQ1zUNJSZDT+k3K+khyyijMw1Vgk?=
 =?us-ascii?Q?6rVNuJQi+TeM328HkH+eicGE5YQBXg+i4+IthaZSkLbkjHaepQSChbmYZOgm?=
 =?us-ascii?Q?/QYCu3dcSb4hzJDJOEjf90JzBLU+kIPr8vyiqWbSgZXTxcseXA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f695d6-bc07-4ae6-bbf6-08df4006bd0b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:16:20.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

> > > Changes in v9:
> > > - Patch 4
> > >   - Added comment explaining why we set use_single_read = true
> > > 
> > > - Link to v8: https://lore.kernel.org/SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com
> > 
> > I think I gave a tag, why it's not here, please?
> 
> I meant for the patch 4/4.

I addressed your comments and then forgot to edit the patch description :(
Could you give it again under this version, so that it's picked
up if it's merged?
