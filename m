Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792712492;
	b=1MWNTP8069ZpZvZpouHmQabGm89zxCgikOxqsGwX3sR0mC6ADQh8SKdsNcvedX7w7s8h
	 6mHD+Orp4jEqXg7NBgtAyX/VrWvndAfRx8ItzIF/uOI7wTKlCJ6GTwPqYklNUDakPDBYC
	 iRmN2y3T+p+PXIrk+zG5FINJAw5gio6z3xZP5N4RV9SLtSPQhlgET/HpwpcUNKZB/8tli
	 1ZtB4wM5Y7nNlP/R1GFwIGZYaYwFou0fGFQp9V6ekRTCSLcJeTY9iwA1eB3MjitWGfh1h
	 fNf9MK0/RmSyH1OicEyvy3yAw8iCgNriULZoV/AVEQFajX2pYd3onttGrfi8AdLlMfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712492;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3uttIx0mi20cKTvlEzqz738PGUbzAXFMmNJaFFM6+aI=;
	b=VkzHOZxZ0eEMcJ8BPefru/tNii7u71cZNsLDH9v3z0DMglvOuQMwUlilkA4QPg/KE9qy
	 TcMdc4Lx2G/2jHAfEsryFiSnX+rjhhnO4p4WoUf6SgD6ylQuItWA4vpSUcBIcNonhbJLj
	 9oKRPoiw4JdhxY4HyiKhZieoTrxn98zWusbtmM2qALQ9pxt5umt4JlF+SgmzsXiCEjvjK
	 f0Beu35sgtYwI+Kjy3b61JYsA6N3TKJHV+JbjpR6soClBIWy+mAqYCuWQjlQ6yBjn+ZZ1
	 jFilQ+Jf4KbsndvtMbPY0VUIlYdrfRpB9WYmoK7z1RqEE1DsXvsRE+qs0QEcaegxgeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=lMY5l3Wa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.8
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012008.outbound.protection.outlook.com [52.103.23.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148D606A31B;
	Thu, 22 Oct 2026 23:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7148D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=lMY5l3Wa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPdgKogsoJYWI4OHJrk326AWf/M79uU4YIbygGPszyF97Cr0m1Em1wIdrTY1fzvKZjyfYqhyKI7/z95LkIOXDm/GjVYsEgNvaUiiYpB2CPvVcQiQ0c9q20ATVQokOaEABCCC7WQelGbAbxgf53M9eeugfJoQM5hBROKv4nangnGOdTexenipbtu6ZryBAy6zJpzuN9CnQP4UEttxAGxYS6YnGgNITGJsvoYNS6qRmdJSqcSWiqbZRvPxqh91TM9ezNvxlCCxV8umoKCSvY/01zQkVVL3yWJuWtfgTpJtRu/Rr3dRtQRBGDcMaaMwG8QIaN08lpa/QIRbQyEcIoxj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uttIx0mi20cKTvlEzqz738PGUbzAXFMmNJaFFM6+aI=;
 b=jy9jWTeVXybTkqRP/Bzpt0gTy2RE3Yew82rB6p1iFOd/iwMmPiAIX0PVaET3piO+l7cJCn8W/tr+f6vzC4ZojThokr9cIvw4o56j1z4lT9SsSEKoLZ3HZ7GNT1Hml//5qKiV6aWC2q4efn5a2hHfUZYG+w90JHXQ6bk2WRrz4o+dxz3MqnRcBmxiDXQtY0XhnKxChLF9vetdJbwqoerP8Z87RJei0teHyH8F0Z7LJYBHBbFuwl2i56sIvbjRhPm5HF9WYrhH2ie3sKjf2b/vcwsKxQJKirl40s9ClQsWtWfEcbUW6HKRjr1yB/v4rc/SsRlMHMb/W1rHQv9GG2u/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uttIx0mi20cKTvlEzqz738PGUbzAXFMmNJaFFM6+aI=;
 b=lMY5l3WaIsfVVF2a2DrlKt8vcnWmnqllemZjgkd9Z/6UN9YK5fVEnRIMiDjIP9z9QyEOAR/2PPsksZHkVIp2mqpqgCCmKdXt31nGjq+gVjJiBJtJo3mCmN9DIvU01imlzz6LPkqViN8Sjiw9WtCmL0oQTD1V22Tp/5DUiEoU4y270SXzZKhcyDVtMPcAkECmWBt+YV9sNKkiP4UHh3a926ww+Gd+qrv1Kd3kGE0VVzSOC2J/zR5NzDcut3MnDVLzx5AUzVmLDkUDUgWlJiBLLg6Z8qL2PY3iiy54t/1M684wbpookEvv7lSRQpuG8mNKL33ddKabFFkL1eHVIACSSw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 23:41:30 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 23:41:30 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Thu, 22 Oct 2026 18:40:30 -0500
Message-ID:
 <SN1PR12MB25287F63D68E82759D3A0FF5A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261022234041.61995-2-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 17520917-c490-421f-4b3a-08df3095ff22
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLSPhlJ95/U7v6W/AahuugGakVw4oVDm3nXewF1PwaoH5DCo6+5yoG2lRh4YfPIUFaK0BxkEkZce8LCAazyB80gyH6ur/z3btVvFYhoTh9BsfMF5BkSKCfNO9+OSD9wyVW+ed/R/eEJxyushNmNMtAtkgy3Yp1iAa4L/ZfuwOvWoFRTZDDgbOmfRkO9m41p93H3s7dOA9ZD5T3YCtOzfAKPY3GmshoOF1EHdO4QQvDp+IWZmhDS6gX1eis5EYhww7UyeyPgKHP5cOROmtJz7jHXIHdhMiw0BOS0qxpWFYo1CIDk1WtdFBr9fPGnHEt0MivL83C5dmrR/UzBrs/OoCTyhUm5eInP6vYPlFlR/j4JT0pKdLxcakB26RbexzcnP660K4YiONolu2GvhweaNqvJ4+2mybkr0Rs2ZmOY7UFJY3K7xzEx2dj1HmGkHfCBbh05HHWsx0PX19W+Qb1IofEiXY3xn6OqjscS2Mpp1+OXS3UotH2A4XOXQcc4BZybq/+OUoVILARhU26l0OUY1YDmdbH6VtcGeH82DEuOfPbIb794vZm6S2rCLXzRxbQDHQF2tDsZzJIdDPxxoW7bPkbc9BSCHlwKXXVI70ZRQ3kIXc0YbTDH17XMdhULxB1lm3PBNR7EAzaM0U3lkI7qy+nRH+pSxztHZKC8WJ/5NBlHO/VQJeRV53Rbpb1qNouFM2gBeFiMUwYjJe9E2ErVsgh9yTJAJVoFjzJFXa84Xe8ObclyYyBRli8/u+AamZfHSmwkSFLT53J7Xde3DPKCiOGCR
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|24021099003|22091999003|5072599009|23021999003|51005399006|24121999003|19110799012|8060799015|260925184616899003|25010399006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Udviw5mz95P7BwVAMTcAX81TUuvMG9kt7J+K9MZs68I1xvcbRYW2pfeN8Ap4?=
 =?us-ascii?Q?OGfEhg8nt+spmGbXFrQArF0T4XCA1H0lfGIGUL/0a8BN9Yo7kBALdV+V8Zcj?=
 =?us-ascii?Q?nNt4gw5kw0YgS4Hw7T4xrD7gV7ujwrXRycXlAnf6DIGXvQBZ+NhHVFiinD6Y?=
 =?us-ascii?Q?TN6IheYW+DypowcWXxuEFR3Vu9GqZx5icnrLAbSV4b8IHNeVglpFoR8Mcugf?=
 =?us-ascii?Q?AsHjsxeZ3KW7k22KpsbKiwsmz3k0s3e5Zy+wCfS11LWuRQLa2ba/YiOv+CdZ?=
 =?us-ascii?Q?Z3nlTLa2v6/bFhS2lqug0MIGYjtT8AOvLcsuNJ14JQCXhMab2UDiUJeLUsKF?=
 =?us-ascii?Q?5Hp1mJH0LbIWmeChxSYioRCbdWGGbQP4lnIXjbADC8jdh7CFXjVyqMg9yeOI?=
 =?us-ascii?Q?nXo+12HL/oQDfKbkx3MCkSrmBF/ks9zlnWTvg9/KJ84AJsONlxSV++BGZZ0i?=
 =?us-ascii?Q?epHeS01S+7iekrU0Y9BOC25dRUJEo0QLiZYECn2rEzAup40YWPN6yoPj7+ar?=
 =?us-ascii?Q?QK8lgBmqjpyZS+T6KwrUG8etw4WrKVCH3F27hk8JVTqryL/bAinSsPtaFAGt?=
 =?us-ascii?Q?scdVTdnyShmTtDo2Yk/w7/wVVo6FBVzL0BDHpdtd5h5mmUeVC6CK6NTyA5kX?=
 =?us-ascii?Q?cs6A1W+H/hQn1UQTYYUteAmJQTH2kGuAIRTmNMhTbuCFuqH9waBIyaphfhVO?=
 =?us-ascii?Q?yV4fL97oHtTeZz8lk2ZWg/MDwrZaSr0XV7NQ6Mj1U5YkuOJEuieKfRxpcCMa?=
 =?us-ascii?Q?QxZphXSmTyRe8JVTfqMmZvLyKcrz9hkqlqEteQWiGM2P4aTzrRDHmySu4TGa?=
 =?us-ascii?Q?w0t5CfPjL2FeFag6uB/s5zXdSeX4GiE4o2LAWV87K3K8Jt85mBT7Rz1+n5DB?=
 =?us-ascii?Q?dF/TGuTAZKXJ4jP9J5Y4HIYQNwswnMRqIrVocwgQdfIwV/PEBFVBGbRlMNiV?=
 =?us-ascii?Q?YqiO3OEGKwCH9WhkUbPvRFyhfzjZV+/fEIYNA5J0zNEhnTC5CAfToGCFO5iI?=
 =?us-ascii?Q?d3Kn1ZnMADy4/MVFEtK7rlUQEw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UhjAPyeiEBJmfrLBDOaq1Nt6+iHqWpOn9f80s26Eg3dHVbN/t+BBQvpwBj44?=
 =?us-ascii?Q?L3zFfhFjSIq9nuNH/m3dBGCPUms22IzzXDZB2/V9hvMnTasAPfVbszBTrMAv?=
 =?us-ascii?Q?j7k1RgphtEasuPL4bvEs6L74fGOefBVbrQPI9WWjkDoTnRstOdiuQNBOBoUn?=
 =?us-ascii?Q?qAedC0zpYtEKrYE+aJKNHVe3qQZYSz95MeBbfbkh2mo+nEM98b4b/l/Cvzpd?=
 =?us-ascii?Q?4QUVNdoR9i0HltiTIdPpF0Odooh5HTX1Ij6W1FU+wOfYf4HbDqtIx/ooxCK9?=
 =?us-ascii?Q?d3SOAD2MpzymYwIxTPr/l16EJVi3Seh56+yl/owBfZtkXwaJRjFBvHXtMm2r?=
 =?us-ascii?Q?jHumNlMtG9Tewrd8e7Y3bZ9UPxiKVHnJiLjmN7w+fDYcxwy4yvnGVBnBoe5y?=
 =?us-ascii?Q?Uixj5LMsMxmbOp3GqRvnQnedS39ThfV8aQw42bEb+osW/Amg4z86asmlBxu0?=
 =?us-ascii?Q?sUSbwrku4WnTd4WDfA2hgPgPlClT9K08GC5ftstpr+qrtaHqeFcVQw0eahRF?=
 =?us-ascii?Q?+IGl9wSZF/27CUVFbtU9KK78d0JnDMVXqPjjrOmc5dquG1SN4pPU4Hphr7+R?=
 =?us-ascii?Q?xLQoyQj32CnT5DdPsUJpwBVmoqS0RB+pKT35+ahEOOSl554KGZm1nzQ6bYCH?=
 =?us-ascii?Q?cShUGOfW+XM98U4ooPnJY6e0ifhOClim6qd2TW2jv3Iu/VhfGjRaELdeKAis?=
 =?us-ascii?Q?O1tX/Oqozh9/hNiwJmzTmSTNXahv21G4efByY6GbpFiNyvePu4xbnjtU3r0z?=
 =?us-ascii?Q?MBTc9ac5D02yLtaGbnK3Rm+cjPflFpqxdDeBitHA1VjvCIaAQ/YquWP4BSWm?=
 =?us-ascii?Q?IelnTNMjvQa/FESAyi7kzuTprN7xXlgYS1pDAEDD6mbX2FZdTr0T5XeT/O7a?=
 =?us-ascii?Q?mXT/d7NDeyHcRJB55LrtxITth458jeKjIYk1F6WrHhzs0X9bZQUpCE2hPUeo?=
 =?us-ascii?Q?G678bdSvjjwJFmt1NSLO+0RwK/7mChtoS9Venv5eROBJS2cjZRsxcYzBi4hc?=
 =?us-ascii?Q?GxeWsX97nGpbF7QTjGY8NszBEplTFs2KUanLnMy03I+lLeVRglwPSQJXL5Om?=
 =?us-ascii?Q?ysVIVe2FjiRKRazVEAakjvhfUoGE6U2OoGQhv65icy18Be/2cMXbmOzkJGql?=
 =?us-ascii?Q?fLNd1/Vy/6vP+PgNvUiA8LjfmRr0Z9vqZI7VKb/7QqBj/ttGGGoDcnA/0YBH?=
 =?us-ascii?Q?ERJEunCNDRFCs2Ouh/QBmjWRQQTW6nIcIm/VR3Rqj5ecQpX1e7jbnFsuH7+n?=
 =?us-ascii?Q?RjLVwuqNYCWthkv/DBwVtneSwwwxHcWlk6u74YDcn9loY8dUDoFX/kwEBCG1?=
 =?us-ascii?Q?A0VvyiiEbjGmlRrc67nrIkZoD1bcU8Crxzn1Bg+y1VYjpH8ULFox50Cma2yI?=
 =?us-ascii?Q?RCih2Bj0H291DNhSzzAvXYUz+tthh7FWoS/NZ48bQ6Kq2gGf9g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17520917-c490-421f-4b3a-08df3095ff22
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 23:41:30.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

The highest-precision format IIO has right now is IIO_VAL_DECIMAL64_FEMTO,
which gives 15 decimal digits of precision after the decimal point. This
is not enough for the upcoming TI FDC1004 driver, which needs 22 digits
of precision to exactly express its scale value. This patch adds higher-
precision formats, up to IIO_VAL_DECIMAL64_YOCTO (24 digits of precision).

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/industrialio-core.c | 6 ++++++
 include/linux/iio/types.h       | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a..008387efe96b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -716,6 +716,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_DECIMAL64_NANO:
 	case IIO_VAL_DECIMAL64_PICO:
 	case IIO_VAL_DECIMAL64_FEMTO:
+	case IIO_VAL_DECIMAL64_ATTO:
+	case IIO_VAL_DECIMAL64_ZEPTO:
+	case IIO_VAL_DECIMAL64_YOCTO:
 	{
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
@@ -1034,6 +1037,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_DECIMAL64_NANO:
 		case IIO_VAL_DECIMAL64_PICO:
 		case IIO_VAL_DECIMAL64_FEMTO:
+		case IIO_VAL_DECIMAL64_ATTO:
+		case IIO_VAL_DECIMAL64_ZEPTO:
+		case IIO_VAL_DECIMAL64_YOCTO:
 			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
 			fallthrough;
 		case IIO_VAL_INT_64:
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d8944c9e5e90..2ef9b2a8b119 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -43,6 +43,9 @@ enum iio_event_info {
 #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
 #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
 #define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
+#define IIO_VAL_DECIMAL64_ATTO		(IIO_VAL_DECIMAL64_BASE + 18)
+#define IIO_VAL_DECIMAL64_ZEPTO		(IIO_VAL_DECIMAL64_BASE + 21)
+#define IIO_VAL_DECIMAL64_YOCTO		(IIO_VAL_DECIMAL64_BASE + 24)
 
 static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
 {
-- 
2.53.0

