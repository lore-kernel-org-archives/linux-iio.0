Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793460288;
	b=jkKjiQkZKSx2VfosxnQg5N97YLEeJJnIGE3SNZQGGnzirJ/yXXOW0BhOrkaKv+ZyNKkq
	 7cv13xTE+avyMMaIp5TUazXURqStTMwhZ+paxJlvdN80aBwB6ODe38Vd3TsHfaK5y//Ay
	 4r8LSHcgp+M/mvfycaSdM5WJDiklnzVTNNI+SXg1HibUcX9yRZmZev4Uhm6U16A948VK4
	 CRAQmc327DulNer5H1dfG4jPUyRpqe0TqXc3SH4Wtq5g3ixijZ/krylA9hq2TcM48VD4F
	 BuLIsV54FzfdfvoOB0E8LeE8xtMQVBrR18uDpiVZDC0nz3tX6HefluXkZLC7KWDu1Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460288;
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
	bh=XVdpJerVDE97hnst6P25lNF2NtMkrt8bqUspjN0pX6w=;
	b=waKbqH0NGMyVKUnNmysiop6FVMB2E3BP/yuNSRHUIpjYorEVyF9bspssEBz32MKvx/pG
	 zJjkswfzoc0iZ/8FuPgr1qc3VWah6osdvB2KU/xqu6/7Q0ng/yxXCSJwMwGuIlxVVxVeC
	 ZdTmT0AjOMNQvp0pVdw/OOeG4pzc/TLWS7snhhtnzq/j2X3fAZsOMj71bHf/Cu4al+kj8
	 lnJl+yDjcqEF9NoAgOGuh/Fjif1HTcWubfKdS9RzwvGO6hG4EDyw9wd4CSL3YKfVGFQ6M
	 ZUpnzwR8aYRSVGRGT0gMP+3ainAl2XBN+10plhnkMT968OZc5bMKywOBkJANqSFn3Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=MEh93+6p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.20
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012020.outbound.protection.outlook.com [52.103.10.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582C606A31A;
	Sat, 31 Oct 2026 15:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D582C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=MEh93+6p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACHmk+VJTHDv8rKYHzsWREeiSVeIMi4nagTz2kNpK0FNJmHDKYcg+nevCecPbe4+jcgA1PX4Jc6YRTXifJZ9AbgMY9QVtBP/DzEjm8xIav3sedUqTt/h5XlNJMqKM0Qs5gTIpsDiJKC59RF55Bil0SVIYDud7hOSBQsuC0I1hCwW3eWO4oOsfyX47OXGZymkQr+zGES+3GB2dfJ5/6kM/MBAnvyIC4FR3AXeIT0Pv/T69KB24syPkCknM1JtwsojbIuIOc1enJqX1ugAlDKEfE5wseO701Yxmr8Wcmvo6S1mmN5ZRCkEtJeZGsIwTWSnU8wo0AFL+aOTdVGDMePqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVdpJerVDE97hnst6P25lNF2NtMkrt8bqUspjN0pX6w=;
 b=h39r16guz7oeVc83zTW8fNX5smQnDGRZvtQHTEstGIn49bw3T3JxmOBzJNytNBvCj5xnaeG/9Krc/4Lxk59zPwxmkTGtOTZ+sXpalFPsdP4myvkqVk5J6qHCziJkGUP8A6OHP7cveVeDPoM/NVnNsadf4u7d3lHTlXgB1F2+0e4SXeiKHGbVmEJrgXzl/263QIR9jmQW8A+aQK7qfad2kxLFcs0BgXRKf7oxDjPvsmxNfZc8heIUjOKx0MZNxKzOHVUVK8lmuOxVkjm9cCgW4jPxfiT2iDyduBDP2Gbzxg4qivb5oK16+iiLpdshasPJjgSpLLgaVoknJAnR7HrHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVdpJerVDE97hnst6P25lNF2NtMkrt8bqUspjN0pX6w=;
 b=MEh93+6pMBTfnd0fQonWc1jbvvcRwKW7j5VrVXcIPpOtDlYvOG2g64TQXV+X3cRgdThe9DfmxH7/76vvU+EtWqbUZpVd9eby1/OSdaT01Z4NI9fGlRu8pjSpvpM30VAzjFS1W2U3YYj3PnTACHw9ZMMCvJmTJSy6ZDqGSUdT1+JNwCXXoUctgF1XXESC9ykwxFe5DIwCmoGCy+SjMNTSHd4l1mwiyjdACzr4YqEhFu9nmr86tefRPaRafG+yEukXuc37RiNjZidwPunuXKrHJoGY0AA69ZRMB8jM5iaRe+waSJgHhiapoEsqhsaPcx3rjqwSjgFZvc478pRGVDnU7g==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LY0PR12MB331121.namprd12.prod.outlook.com (2603:10b6:404:226::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 15:22:45 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 15:22:44 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sat, 31 Oct 2026 10:22:34 -0500
Message-ID:
 <SN1PR12MB2528C775582FEF9B200A1FBCA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auBTxjakiTKn1LL_@ashevche-desk.local>
References: <auBTxjakiTKn1LL_@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:610:4d::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261031152234.142598-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LY0PR12MB331121:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fe9f9c-5038-470c-f9dc-08df3762cf94
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|12121999013|260925184616899003|4140399003|25010399006|5072599009|24121999003|15080799012|22091999003|19110799012|23021999003|8060799015|41001999006|52005399003|40105399003|26121999007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odqlTxZGgT8cat1N+NgpRZH9Q85vQrlbwM31RrXAFmA2lIYq2LY6ns+1YW8B?=
 =?us-ascii?Q?dNHLAWvo3eCGDk0ZWCjZ735sbVkJlLNi7GDWQw5UAQQm8DyLhE4MpaJQzBXo?=
 =?us-ascii?Q?7Suv5gBusjExU3cN3aW4rhfEI210InvZQNEXdycgG3dmnt/BukR+Wh41DCrd?=
 =?us-ascii?Q?OBl2AfVnJGG9gNofijkzqnPYAeLL+4lXcaFB/rmPnoEu+PiFpq6HBqHg3N4y?=
 =?us-ascii?Q?KAOPJNndxM++T0ISHO3upwv2M2DQHnPpYbsKpsimEDVrjDNHiXVCHYQ3qL3M?=
 =?us-ascii?Q?MxrU+UMFVk9MToqR+4S/78JnJsfTfiXEEfBH1/r3PphVxH8h3SjGYvbedbf+?=
 =?us-ascii?Q?E1QI670XI8+IK8cT3LucTYM1X7x8eRQMjt/r/9MLah9yQ/Gj78XHgKIPqgQJ?=
 =?us-ascii?Q?qZISDIVGFzVaYWG+id7uKqfC8w2Xrrka8GwKGKLv3p1AC23UfgRysAv3l1rq?=
 =?us-ascii?Q?+m6ml8W93uf22GVJ4KQEH2y3Wq1DBJmPvnfSunMeRsTbRyJA05yIBMij33n2?=
 =?us-ascii?Q?GS/Q3qBHrObCVPSrrxNOvejM+zxhX97o29NQgOuKjzORA9+rbp7xdSD4P3mO?=
 =?us-ascii?Q?5cEgTa2sowOleX3Q8hsi9khsntTVTxWuB0hJdI/RCzpCP30bbDusUIRsu2SH?=
 =?us-ascii?Q?oba8Ksd5exIWtSPsipC7cJTNGQhPqFh0p0YtZWM3xZfM2kffa0ovn1w65M4e?=
 =?us-ascii?Q?ANIFIDhaYXZ+8Q+SAY+qGMC5Sz1G0HdiTMEdPI3pt3WCzV9dMGhyiItt1EgM?=
 =?us-ascii?Q?ziiR6kVplO5QcAOuxSPlZJ1nAjIK3euHQHcweLPi7vAqHJCZB1xhK3VOqyYl?=
 =?us-ascii?Q?G4/oOxxoYAvIHlNQpq8ok1tUTmSZ4TM9pievG3uqY60VhjmnNEO7cnMA7nsD?=
 =?us-ascii?Q?Rz1/UL4d65/vfElkOE1S6mYAjSTPSi8Ye2dGQwAMw/vAo+MkShhAy39StwBV?=
 =?us-ascii?Q?76Hppq3DlrM1zUegvpFmI+zqUVDnCO3jIw1Wp+bmGX5yOZCj7TXjUf8Mula6?=
 =?us-ascii?Q?OdHx4oEMdbDirJsSmvq7j5vG52QvTfHPQKP9BVONm/NnjrYXYRStdIOE8II5?=
 =?us-ascii?Q?9arIeWK1T2IOqCDfcXRgQDao560JzDDVDlye7AuyhKnNQP959HUs4afjsYbI?=
 =?us-ascii?Q?7pvnpcQHHD/3?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAzNR4m8x7N8K+ho/PM8tS7Rc17uCRGzEMtbrO163duF6hvXlu8NB0QhBvwe?=
 =?us-ascii?Q?aW6TtCijjqnLcnEtuUayx/u5thq+VzgsQ4Nm4AoAKkMUjRB/+MOwlRTWbiCy?=
 =?us-ascii?Q?t/6pMQgk5xfckmYN4vhGt+bHiJC2KgJPFXyU1QcU+JwN//KXGfhfyr8I9e1C?=
 =?us-ascii?Q?+39xs3Az7bznXpWGKlW4w6YvkGuQNXv4M/SPCMvImgtI8rAOvBlVhAAJ2YoC?=
 =?us-ascii?Q?Zdo5X7FdYx9NOdLVN1sl25GugGUtAukRCh8bIqB0AR0OAjFqWt+7Ki0wehWb?=
 =?us-ascii?Q?kSNZk2H+fU5P3Wag8wc4FAqpe5W6+wy0PZCUptYTz6P/TETbvwLTklXDSJVc?=
 =?us-ascii?Q?Bk50Ao37DTtHvBjhz1yaI7IX1Wf+t7gtk8AyChia/bDSntG4EqK6AAL73fto?=
 =?us-ascii?Q?8SZJ0drOS24KaRZkERI0oKwxYocIi8Sfesno2OpToveNb+Y8ttBmnjztfM+u?=
 =?us-ascii?Q?YD2q/fdNPvJCHhJxZUt0Oo28Tmg8m0B8gBBg+x9+A7cQPJD9ekY4pfPrDoQ3?=
 =?us-ascii?Q?YdNJ2tE5iRBV2roiT7r0whTOuaoOnu3SFT1gCmU3zzora4jSYxmT3N0vzZ5E?=
 =?us-ascii?Q?8Wg95Sr4KE2zeTh3N+uUn0CP2lEA7N63kVbAqOep9z7pHEXspCBgv1PcQtv/?=
 =?us-ascii?Q?B4RGs0HWEUp6kobfGtZkRmHaqHtkfQQtQ3RGtFTB5Px0fAL+jbV74UJvZCWR?=
 =?us-ascii?Q?nXRlutrSgDFyjKAm8Gv3i9Qc/6nq2NQN/qjajud6anlRXmbkqfSfw/KAVB/G?=
 =?us-ascii?Q?K4SfONN4jrrT6XZuSLcgZY0nO9xujoKZ5LSCgutOe4bj5Rc46LHA0y6/DmX3?=
 =?us-ascii?Q?7V0t74KCqgI7r0LW3yPYBDpvfar5/epwZHAceBnmiPWgqKlIT2OXwjXt4QCE?=
 =?us-ascii?Q?DSHGD1aRSA6jeZDcNnlvjKJZZ0gV428AHtWkR7+ZqvA+s7uNTpeUbVS6Ej6y?=
 =?us-ascii?Q?YpReBqu7NONsBVQ4LyGR4kYtRHu2cXjfj5NLuVsJsNCSpB4OOKPGBQS7/BH4?=
 =?us-ascii?Q?9yoZ4lhXOdb+MXsCt6hY+4AYy024YNSfu91jAY/y/PzMc/T3ok8OYR89mJDQ?=
 =?us-ascii?Q?LUkDGEXYBOffbnZmICa73CHU70gI/r5M20Kvf7HGQH1vIFJTfmkgwmGMdPD3?=
 =?us-ascii?Q?sQOTITQYeSyT4mHmeucbQlekSye8ujKBUpPWWcR1XWL/TFZlRJhSNAQsbIEB?=
 =?us-ascii?Q?nPQ2LF/kRLRxBp7l8MGgusQ+E2eQoGM3Vo4UFGji6/tZK1XwL+lO/Q8Sz4rv?=
 =?us-ascii?Q?HEdtFdQvxylPruBV3e/N5HsCUy62LVq/pn2dCYLHpvCSeluw1+dMj16KDjLu?=
 =?us-ascii?Q?fnHgEC5WeLwV32Ub2rSO+EkcV+IjMYCYBXZD0K0OzE+H0gF58rQOFnuvi6mz?=
 =?us-ascii?Q?WFGea00X3ukItj7OBcNY5Z+x+gKafbPQCSqrJDn1/x9EcTKpsw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fe9f9c-5038-470c-f9dc-08df3762cf94
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 15:22:44.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB331121

> > > +     /*
> > > +		 * Now read the two registers making up the measurement.
> > > +		 * The datasheet says to read MSB first, LSB second.
> > > +		 */
> > > 		// also note in this case we don't need to have _MSB in the name
> > > 		ret = regmap_bulk_read(map, FDC1004_REG_MEASn(0), reg_val, sizeof(reg_val));
> > 
> > I agree we could drop the _MSB if this was the only use
> > of FDC1004_REG_MEASn_MSB, but we use both _MSB and _LSB macros in the
> > volatile register table definition, and it would be weird to have one
> > macro with _LSB but the other without _MSB.
> 
> You can have three!

I suppose, but I would prefer to avoid duplicating the macro, and
I think having _MSB here helps to confirm what the comment is saying,
that we should be reading MSB first.

> > > 		if (ret)
> > > 			return ret;
> > > 
> > > #ifdef __LITTLE_ENDIAN
> > > 		reg_val = swahw32(reg_val);
> > > #endif
> > > 
> > > 		*val = sign_extend32(reg_val >> 8, 23);
> > > 
> > > 		// I assume the following is also possible in this case
> > > 		// *val = (int)reg_val >> 8;
> > > 		// but usually we use sign_extend32() in IIO even when simple
> > > 		// casting is okay
> > >
> > > This also reduces stack usage.
> > 
> > AFAIK a good optimizer should be able to see that reg_val and reg_vals are
> > never live at the same time and reuse the same stack slot for both (whether
> > GCC or Clang actually do that for this function, I can't be bothered to check).
> > 
> > If you and Jonathan prefer that version for other reasons though, I can
> > switch to it.
> 
> I gave an idea, I would wait for Jonathan to judge on it.

Since we're waiting for an answer, I've posted v4 without this change
so that the other parts of the patch can move forward, but I can
always add it to v5, etc.
