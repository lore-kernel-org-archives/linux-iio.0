Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793467870;
	b=yizUc0vjj738eyExu++eXeQ5dj5lJf5rMNIZr4LNL1HVDOfgeAymGbeFxaCVo5K6TCkA
	 UMTD1eCx7vFTTCYnqBLrpa4/0/S1plozub9hwNdKlARrcbb4d28RBaOBpcp3AVzy2aOU9
	 VISSkRIYXG+qN2miEn9GdxLx8bMNuNSFk879gkygVVtSiS8joywHAE85peH9teN71gPUf
	 Q3jmo/QZVK6wXf660PsTTdt9Ycl5iAsCBy/ayqDBS31NsKKOTbii7Yv7LcXeuEtc7uqgT
	 Qw9APDym8XmpPXYWMFar1IHeGC4z//jHbBMVwuiHCn5+JPiSLvb/wrRSYkeyhOhqRaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467870;
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
	bh=whdGAol8dBd+AMCA6AtEhnRA4IQNxqQBd1oeuoBZgzE=;
	b=CUByk33DqNRPgGM64WG4uGqsFSHM6pVl+KoknyvspUEf9PqtJJdhXF8FgXKGV11Yerq+
	 j8RDDZkBKofTYqFOA50tGjz55xYwMISig02nCTj1udUrfYA+MxyiKT4fNK8q+wILIN7EO
	 LNwNQRLU2HpqZCnwJa1v2YC7G53tcJV0iqw7oXQo3ect8ssSn7rWcD0COigyGk1nh9GV5
	 weaOpAsrrFacc52DwVpDjLhDirPMke/SiVeXzBogz9new1GJImzrs6SeY5ktqBGnQHrI1
	 BmRTF1svDFAkipISaOwhfXfyqPh3+N/Swu3DFaUFxPZlTo+5XIavIg8XoNBKjNZ1wCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=k9sHmtp0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.77
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012077.outbound.protection.outlook.com [52.103.11.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E214B606A31A;
	Sat, 31 Oct 2026 17:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E214B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=k9sHmtp0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4ZpMF/OIkvWjEMKabRQt6eZ2LuW7ncKkvXNqLksbNYIZHbXlY8M05/3cQEQrU9c1mJLISyTKeieSofsuAr4DQ9jUuJU8vlPF18/iGJGb9IEvRGV7Y5l70HSPPwUKz0xXCRUiBh/wnc5G+Et4q6EezYJ24xtG9D/F6/X19LK7cSeCP5RALnwVHQt7VMFLPjg9zv4Wq2lj3TbZkxIq4vx/7lC0qOaeQlyekgFiPMuKvUirXTF0VAAbQV2Rkl00mn7gQvSsFCdd1Bd1PXLwjuRI8k5pXza2u39KbgjAA6FlWQwCo9NI2OKCgZi57qguKaL8hBiSrANc1q1pr5KzMq1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whdGAol8dBd+AMCA6AtEhnRA4IQNxqQBd1oeuoBZgzE=;
 b=asm4NUd6hAw5nz0tyNsr1Y5ttCXooxnyVsgllMrxTgQI2OKLNNpQ3Aa4rEyZDVFyqMkHHVLLFaAAB3LrkbXra/OeAbmR3ka1E2/UIy6VH23SWsNJvJAmOZHyRlK3U8BXcDp3kk76XTVxZKnHKzcAL0J3KilU80L1ag1LbDq7HOFOgJuYUHBAKIaHUmY6KRuFwKzrRyQ5b9uPA8+pWgr49U5BBk9pztc2T+R3nKnbX60oyOWLE2NADDYD04wWKnNd0vFkbNGYCGDJdmg8IVJ+cRes4/NZnxEuc/Z1c/yglto1RE2E69CiDVNlETbUMeu1ipWPJP+tMty3yyhtp6Lsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whdGAol8dBd+AMCA6AtEhnRA4IQNxqQBd1oeuoBZgzE=;
 b=k9sHmtp0JboVd/nwpyFGNa5c7RnQswC+jG+h5NTMTCDmCpRX+LB6CML+jDkZQnkNms1oo9UdJ2ygRhwI7fZS7hAw1ng8794EFVrcBQQFimBTuxFINc9WXn/TVTM2r8A19+WbJcdTHahzqTMZ3hH8RKxqNMlxsleOY3uny/w/mVDwj7fPmWioL40h4+bg1PKyr4EWlHS9+YCF3J3FAeN4qPbfKu1nbFd/l93ITb9ElvRH8LQpSL4wVxwKz7wH1krh3PQjHxqBAyE6k7lLGSuMFMtC0fH0JE7tdcMTNq92BmwMijgXk8aPuSq9kIEtCbVNMkhQGY7gSb2+Jpwi+OFKVg==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DS6PR12MB745092.namprd12.prod.outlook.com (2603:10b6:8:52c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 17:31:05 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 17:31:05 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: maxime.chevallier@bootlin.com
Cc: adureghello@baylibre.com,
	andy@kernel.org,
	antoniu.miclaus@analog.com,
	conor+dt@kernel.org,
	cosmin-gabriel.tanislav.xa@renesas.com,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	duje@dujemihanovic.xyz,
	giometti@enneenne.com,
	herve.codina@bootlin.com,
	j2anfernee@gmail.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	marilene.agarcia@gmail.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	thomas.petazzoni@bootlin.com,
	tobias.sperling@softing.com,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments TLA2528 adc
Date: Sat, 31 Oct 2026 12:30:44 -0500
Message-ID:
 <SN1PR12MB2528B5C1EE6C80914CF20297A56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030164705.297354-3-maxime.chevallier@bootlin.com>
References: <20261030164705.297354-3-maxime.chevallier@bootlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::19) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261031173044.150625-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DS6PR12MB745092:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ccacba-a13b-4953-f921-08df3774bbf6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22091999003|19110799012|23021999003|8060799015|15080799012|24121999003|39105399006|5072599009|24021099003|260925184616899003|25010399006|4140399003|22141099003|440099028|3412199025|26121999007|41105399003|40105399003|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xziV7WbtvU5NyLuBWC+5UHzALCvNKipHcSjR7X/uWjOFSUrKzsB4tfW3+5or?=
 =?us-ascii?Q?mC6FBHC4TVu23UCQ4s+dxVeJWgDiK0R/Q6/ydSuvylrmov4Wc/Wd9p/u7DBa?=
 =?us-ascii?Q?G+QPfpL2VFNZy9Ld4BoM4r5FFFsEtq1FT+VFcZR+b8uK//rH5eMoBP+MoQfe?=
 =?us-ascii?Q?Ap/akZmKQmo8o9wWOklCnM+eW/mjGKTlBvgMtYxCX+/J8rvYeDfU0fsf2uUw?=
 =?us-ascii?Q?Es1k1muN31TqW1RDt7rOymAGwEdSTU3eFvC3T9H9JCIdIF29qwZW+9/ArOy6?=
 =?us-ascii?Q?k9DAhxX2djqu2WgQV1mWxXxQHymEOuyoyfeMbtTodUxWrUkSojEeKuNpddeo?=
 =?us-ascii?Q?GHSYk9CHf/lZns7ML4Xa1OUX+FkMHw9K/cohmB6ix5pMkt1Q9bnBE7rVQ0bd?=
 =?us-ascii?Q?n8A0R0cTfdVeOeIIMuoU9uBCZnaNh6DhwzF8sDjS2+STO4zyNujABki66bvT?=
 =?us-ascii?Q?Ih7xERzv75KAflDngFzXdnZSr74fs0aYuUA1IxUX48nuorNc6exbKa79hCMb?=
 =?us-ascii?Q?6lreQk3RBj90aTo6CvrFWfUsC2+duuxnDTEfys9B4x2I4XmyCdzWU/iQkqzd?=
 =?us-ascii?Q?HySXJMKXrCxV4CMthaVlsgey7mnm7Fg+K1APA+xT3+AZDryR0STt7fZHQCZf?=
 =?us-ascii?Q?JNZkdQdDJM8rJv0M8Dp6hb/E/hik9VIUa6l3bLnTWXDYjA118Bx5+garsk3U?=
 =?us-ascii?Q?OVIZtbkPSFFBzYylE9BS7L8tHRRJrF1N11PBYC+JwO+fJ+mjKU7elP8AIfpP?=
 =?us-ascii?Q?KbqEk9j2Vlm2kmoKQmqhRU4I8FtNXDhkxcnKOiTS0BhORDfzV3F0tGiNgmP5?=
 =?us-ascii?Q?erWelCiTaAL+HWfTW0JnPiQLzj9OvZxBYdu27lvMYBgNjeVJcvXujdgw3ugq?=
 =?us-ascii?Q?GDIA3XD8QysYgFecBiwdbf+LaA9ZOLeqw0uZ8UC6rQxOAsXeI0zAYXkrsJdA?=
 =?us-ascii?Q?D2FKjEuThi3cL7RQguOpt2gV6SL2qnqQE9RFae1QGNsMlQg0DflVU5BiALNc?=
 =?us-ascii?Q?tt8oC8UF0eY7hAQ8LkgR8S8jQVU0eOD6V5fgSqAycvjkTTGlKJdgObjI5tmk?=
 =?us-ascii?Q?6ld1ROsKoytWWA1FzmKc+wzPy59sn7zAGLKmPY8kdUBB20C3pSRl7f1pmrwT?=
 =?us-ascii?Q?bcLF3h6cpWCquoRp+BgY6RvwT8YMWYmTBU7X9KlsaeyMFDpOGKg3isU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qt0yyJxJtoyPxCFsYRJVj2lV/1a2Ghcl94bGTIRawvi3lTwTqXsn+VCahHWx?=
 =?us-ascii?Q?OqL7TuLFw2QiT/g4j3F8iipv4zu8o7r2co7WCwbqqcrrDY8AilSUnZe9Q+zd?=
 =?us-ascii?Q?E72/gCSbgeLUx4d+LpxhQXlY+oHyMUAVwLO5ENhYZFnw0pniz95i8GCl8q2z?=
 =?us-ascii?Q?Ev/oyxZPGpCG9a4hSpM1SRokbR4lo2922SswLQvRPeYKAvr9qoXIQWVKQ0nq?=
 =?us-ascii?Q?GfFIEWmZXjRxwT/PSTDkg9m2hu4Y1wlxDZHC2O4CPoanz1xYhmSzCF0rmLWC?=
 =?us-ascii?Q?I2eCQAmDsvuWSjFzYAXThqutC9Ax6isY+HF3+m/Nz0t9c15KukvYhQQlnZrG?=
 =?us-ascii?Q?XFwUibxXAq4ZpSTGBmIEme+wn39mLDsBJkSv5xNNGkXAlKVE+nnB7s6hXMRW?=
 =?us-ascii?Q?1PNzE4nERSe+07kTUOjfoYmTnOR394W+geIQOft5f3A+sphmOUSkkKRF+vFu?=
 =?us-ascii?Q?WfE3QHchI+4tbhckLZdFcw3WkahRF3rNaBJ7vTF1Jj+wZQ+ekLjLhGfDqREq?=
 =?us-ascii?Q?zB95h9JgCHXJw3n8xOi+Tn22Ihi65ogpT2RkAf+WHu8b/H13bJppfVxQosJI?=
 =?us-ascii?Q?1PiO5ToXdLuRvEKxHh/hd8KIatNw5jHJQFFGw4OenX4+t+FudWer/sh6Vl9+?=
 =?us-ascii?Q?KpMx1mqT8KDrBb9yQbj/pFhdSHWGRmHQIBq/jcoM4AcvyWjYpt9tfuVKkFRI?=
 =?us-ascii?Q?CqNnmor71V+dcvrhTTaceLEYl+wLnyLWvowTHEybxHv50E0RHJzS5byvKXGV?=
 =?us-ascii?Q?ahlxPfHPMp6HPzoNZVMzUyZzFvzi2exT3KZbd8ileScZ4HBa7di9KE/WdHKp?=
 =?us-ascii?Q?RMajGIMDyqMeQhOeZVAN1GMr34G+pn7B5XBxPt56wAHV/o5yyQA6Z7w7odPj?=
 =?us-ascii?Q?gQKY8drdfYqwfGcMCmuCsP+nPaUpJq3F7k+tEXO78ywMhyQoEtqg1vAKDUkG?=
 =?us-ascii?Q?SBW35M2i3bimA5bY/GtdLJD8Q6Z01OTB1BwrNHwul1Sa8iwZIxDPMD0C9fMK?=
 =?us-ascii?Q?n5Xwer8siCy7c8IMwtO/RjTwBmRP6+iarwc9muBhQVIkHvKtP/4XB2163ZQc?=
 =?us-ascii?Q?dRgQElrsSpfP/OFx6nfl5yUmoOlNjClkLmJjrRt/4EGgj3C85mMNT+8UDp+A?=
 =?us-ascii?Q?eieoL8L8m8QqZs6HzsP4/KSLygo6sHphT/fBFPkvnxv1SbCT08ViBY6fRxwS?=
 =?us-ascii?Q?YzgTuFqfph+GtYRCjaCRNV/bPkOHe5Q4p5lp055wwVWp6v3hpgGTTpzKTRGy?=
 =?us-ascii?Q?YuJ7ILtZxrhYLp2VWSW736vVOuLQ8M33hXElGutjWQ5CDqNBVnOHhoAzesaD?=
 =?us-ascii?Q?gxsrlE/pGrWWBM2bRBKTpov2p8hde2Bf0GepkG+Kc+6Yx5i/6nxmXeSkuGcL?=
 =?us-ascii?Q?y1fS7jk6Kf/lrWZ5lynyl+Y9KjLptyOQwvRu+OVsS5g+m1wIHcsSjBu26LdV?=
 =?us-ascii?Q?Ppd2Jm3CA89Mgj1zyqsfa2k/S8kFUbCV09A14T49oi+cl+7GkkSqeg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ccacba-a13b-4953-f921-08df3774bbf6
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 17:31:04.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB745092

+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Texas Instruments TLA2528 ADC
+ *
+ * Copyright (C) 2020-2021 Rodolfo Giometti <giometti@enneenne.com>
+ * Copyright (C) 2025 Maxime Chevallier <maxime.chevallier@bootlin.com>
+ */

Add a "Datasheet: https://www.ti.com/lit/gpn/tla2528" line here.
