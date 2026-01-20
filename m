Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011036.outbound.protection.outlook.com [52.103.39.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921C44A714;
	Tue, 20 Jan 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918059; cv=fail; b=Tm6CAswjwIcWbfSSS00ph/OuiV1XL5b7IhbibgeNtHnZ1rLmCxoby0MoOcafK2qA3onZZgNIGZl8ABelRKvqMOI1SbRk8NKb38MkLKdL5bUn3utC1IOe0VJfnkX2bHsBU+4kM5jikXOSpVRyNN4YpAVrQUpWFLPfFQKaBblg53Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918059; c=relaxed/simple;
	bh=Z+k4kmPBSgZnnTnV8BmkuVFIvfQiNnLk0Px5VFHjdck=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dnbMV0xVjyiKgfD9b1xzPCGdZHl7Q5Aar/Sq1WcoAA26omk8tTOTrYfQy60sjkjSn1YagKsFfLIFPYCkFsS1N7R/Aq5XmztYxAzeVu4spJVV5oHQEaC/A97vWqLP/z3WK3i0smj7IYb0WjPhyGZsrJtvFbk6YJgX+g1Lyr0Kuaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ajEO4QPM; arc=fail smtp.client-ip=52.103.39.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ajEO4QPM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rACWOTVA9pqeJcKi21NjGFzkCF3CT/lL8+q4+LUDs6leWanZD/njjipEmpbVeOaXBlSrK2QbGt+/2JDeQJj1RFYSBThL9uYn5CWiA2gENoCYTYEMpWmFUuFvxl8BomA/I6u+4tj7/c/5m+UdAPe4m25+iTybPOXa6UP8jMHdYpCR6XQmVEzoDDkoxlD/xagPxfQ3Lbvq3yzAckQGymQWzZj0Xf2mnK2+2edw7JQgMZ8hpI1NjdiGSqjX3kW1vLrO3AOBzm5FavERXh/qKJBpBiEvyQg7x4slAvf8l8cw542vynOwZcP7K4F/1WUs4O8Bu9W67EIWg2sHwknTUOM79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0u+jzCB3nLo8Y8kFl10e7nHPK8Fz3lSJb1l8uJl+aw=;
 b=Xo7P0hDnE40KtuZWq5Sq/taxqRrAcziy7dTe3gUj+eqPMmuWFtImU2/GXIHsS2d8M15IPi3yuVhJW0cGMf5Jh0owb+xLV8fVJgLJvSRHssxKMJd4kISueYVSfNbRTlfoIklAnP7OWHTTjL+1eTeEOVx5VlnREu4t+Te1zuLPT6EzZe6QOgXOFXDGHmB+aSrm1L9Ps99Sg1G2W3q5H/TL9FozKo8FmMpQMVcJBsgnFWzRr4iMd+oQ8PvgR9hGItUwzMIMBLlszVmQmw0O8HE3ES5GE+zVnKKCy+lnG9CljKmuoFpYjeiAOfSj9I48YuDNVQDebpglN9j1BwxkpWTVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0u+jzCB3nLo8Y8kFl10e7nHPK8Fz3lSJb1l8uJl+aw=;
 b=ajEO4QPMZpimdt1Ay4y9mliOYr4lahMjHgTCQiy4Ps5CA3CMQgLJGvlbZ0y2nGkk/tOOVLP/7yt9lUZ84HKuVx62QglZdMRAV23EzG8H++eG6ktb+wbomVtOSseHsiiZQC6QauOCpFSOFdpG5SYpm+SoTWrj2krs8r6xMl719T8rOTZd6xtLGE/yrsytpJA+lZtxk/fl/opNoFSIr5AE9PYvCGzJVjQh6Ymh9NMoQciO1LgfYm3pD6os/V/U4yocKDKuN/vV/uXOAcuBJ5z71zj5M/xqbyx7RY0Ox3iEByjYKED8bxysuOs4GudAB5QvZm+OdgbMukP8pW9yKTJNkQ==
Received: from PA1PR08MB11670.eurprd08.prod.outlook.com
 (2603:10a6:102:558::22) by PAXPR08MB6623.eurprd08.prod.outlook.com
 (2603:10a6:102:155::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 14:07:34 +0000
Received: from PA1PR08MB11670.eurprd08.prod.outlook.com
 ([fe80::8466:ae9e:cbec:fea2]) by PA1PR08MB11670.eurprd08.prod.outlook.com
 ([fe80::8466:ae9e:cbec:fea2%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 14:07:34 +0000
From: Viktor Karamanis <viktor.karamanis@outlook.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] ti-ads131e08: Driver optimizations
Thread-Topic: [PATCH 0/1] ti-ads131e08: Driver optimizations
Thread-Index: AQHcihXh3a3wTNFiVEaQiTOqUAf8Ig==
Date: Tue, 20 Jan 2026 14:07:34 +0000
Message-ID:
 <PA1PR08MB11670AA593D765D9F96A0053C8E89A@PA1PR08MB11670.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR08MB11670:EE_|PAXPR08MB6623:EE_
x-ms-office365-filtering-correlation-id: 9360d1c6-4195-43bc-86f7-08de582d428e
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQmnDmlsl/vneQbmorDq9Hf2FxGV92xA5m7diaPQFCLZbmpgMFGtjF4HFCtjg/9Zsi6KaDHt2Bbi+R7YifwtUUa3ISHbejR4/jwbcPD6WMqjuVt2DyMFAGn08Ufy4Q9pP0nf0BWZ2Xr8nzaPJfi/NuMKADIr2kI9X9lClNFpDDP7bZeIVPW+6ddeCEVqu5Yjc6J9cp8LpMyiHC2pUarbP3XNFTuFCJu1F3GkbgA1VP1mjUvz4ygrmo6P/ndXEodjC5WW6QYbcmBP+uZW4CDjXnrZ2MDOst81dRgUUNO2e1JoCX/Jos9JPAnnurbFev+0PuxzflJvxjKAVx1Nz7crlLnvF8SGTkhV0FuDcT5dW9H763H23EXFKObxcmJSwMAu64g8+S0yynFYYVN5g5P93+Y+gxLbqVTThxVtudyyIS7Muk3Y8aDmRWzhkwwRWiyPrLh5OP5tLhCgkCXv+dfsbftY4d0vjuIxHekbtAjWoWDGoo8FSzPXEl6KaImmfe1TxR1w30K0zVB4hljJMO2g08+4BOiAuuYZVaimEH432fW1t4v7+FraXuI7q2BSTu2YnNe0HHATS7Onwvww5oS56Jo/swHWIefNYlfdvP0nQ0uI9IePcfiBSqaewrxO4XGbBvPkBaPP0STcjpV+rXHh9h7ojz4pJJPMApm2X4WTIKlui1Pj1ZTOW3oM0gc8t7PRgdWMcPTaDVDlaSMOc6zc/JJVJ2i2FxlGkXs=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|15030799006|6092099016|31061999003|20031999003|55001999003|19110799012|8060799015|8062599012|39105399006|13031999003|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yqvmhZNt2DXlyJl+GrdZ2jDAOp/uiX0zmoxfc+OwobcNSEsLvNzBccOwpS?=
 =?iso-8859-1?Q?1GvXAMkJkWYz+oMVS9b72vmEgGUlxEZoKwKWR3dR58yM7BBRRnWbKozLK9?=
 =?iso-8859-1?Q?8KFqt2jCR2c7E0tcIiAfCsp0JCt/joWozpuqaAZ32MnIXxwGOFdl3S01E+?=
 =?iso-8859-1?Q?Ogs3/Q8y2jvt1sDn8incVf1k3k6w40sJ/rnf5KCys0ljO4sVCyRge7rWoU?=
 =?iso-8859-1?Q?mu5obq9126qi5c1e8h883wzCuXTOH/tStjg34/FifdH9FK2ur/YvpT7T8c?=
 =?iso-8859-1?Q?g7E7neIAUtpSGyse+YpV7fKXtFc2lgH0eKTiO5DkdQa4mRZvFvZdY6VZ08?=
 =?iso-8859-1?Q?DZD1PVWSMHGZOdcBOmn7fVCnkDolMP21/FMt8fBUgeR981Two30kDRYGfF?=
 =?iso-8859-1?Q?5xlG5AxBO09ynn295SCcQidARfCcZSBCiot98aa0mDmM770Ig7CxbTkgee?=
 =?iso-8859-1?Q?Sw1xBpRewm0TkFS1kESIU3GlKLoLU6KZclp7FSzCDObo7mOP1k4eFn5F9f?=
 =?iso-8859-1?Q?SpZ4vY4PMJWce/S+LdUmQDcZB9CUDq75ok9+Ea8loK/0/EuepifpsAS8Ps?=
 =?iso-8859-1?Q?p4mjrIomHklGn70bSEinH44kQjN4+wsR7sUohx3OXCYAGG8xuSAahjIko+?=
 =?iso-8859-1?Q?rJzptHb443b4GXggZYgPFN28ymCs2Y4ev9h/QCMtJv9blUuY2t6135H/7I?=
 =?iso-8859-1?Q?sFFod+Wa1u0CnJBjpVk6RE/Q60OWpHezn/8q53sgrF4OUZdm8uzqZ5cDow?=
 =?iso-8859-1?Q?MRFmDSikW/LqrX1S22jW2TS7A9+psiL6mQF0hYgPjwzLgosCl5DZCIIerT?=
 =?iso-8859-1?Q?K1EEE2VLf3EU+Y2UE5cLVganeqaAo8cy6pyBTFujdVJLSIUtkiNUhUjMze?=
 =?iso-8859-1?Q?Fzsh0EojfDRNFDeXNzi9rm0s63w4LcDuMwGARj9vAxK8+Kd1eui5TZxv0P?=
 =?iso-8859-1?Q?XVqYn527GYlXwjM5CAYEcDQgvCjNRogxpZU0+BzPja8b4V1WCOVQugnJcB?=
 =?iso-8859-1?Q?P8rYC2qPDavw9Muvm5vubHxu2/UomEDWHq4yjolWX50r/pkR2AvVpS1eiI?=
 =?iso-8859-1?Q?E2r4zu0Ae5PeJ9pMe19PyBYqBMJd/EUHBcP6hS+IPIT0lvlQKscp5TvIB1?=
 =?iso-8859-1?Q?83moHNwsgudOY+rS0JaqyDZdSNV9bPM2tEwXQCRl+bEopy1wp40Bwua0yr?=
 =?iso-8859-1?Q?SjYKSJ2sTkFi+aqma1SG+OKqDNiYPu0rWl5g5KQwRAKwUtTJAEqKC5O3Fi?=
 =?iso-8859-1?Q?n81rYYTNuGHV9f/1DiKVH3PRtGm2JAmP7HVZQStjzCpQuPvxO1TAxy8wzK?=
 =?iso-8859-1?Q?w/rjlnw+boqZiP3xbnKb3hnVLPd3ku4nEVYNmJPQnc0VFBHIQ6NWE+SiMJ?=
 =?iso-8859-1?Q?66TiRL5d8Lp6tU7LQeMyG6k/GCiWQjMQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fpG+20jTBvcHvIe96gtSWPhBzp4aQ1BArW5+AW0O/Cxluqv4KYo0YG0mtK?=
 =?iso-8859-1?Q?IBU4khUDzdcWVyfM5ZYI70sv91BPW0GwXQCs5G8cZKIkbNIr272c27HnXJ?=
 =?iso-8859-1?Q?JyH7dPTz+e5i+SV+CquM/X7CqbJhDW/E8aYvbaK37fXYpcBDpuGvAFNiVI?=
 =?iso-8859-1?Q?p2bnnzOe5pJXENsi/UsfOD6uxJBDhcjioMXRqcksKf25qZN7QyRZOIhWVI?=
 =?iso-8859-1?Q?icLqumkI6QCC2pBkEpo9sKIO6deMF7piAt4sD4ChWdLJbwt1qaCa9KvTXQ?=
 =?iso-8859-1?Q?8reZqcDGUQ/mc/mH20DZtbifQxK51RuEe9QmGbDrXe613dyJQ+76XICN5G?=
 =?iso-8859-1?Q?ipSCeBtOhfG+X3JjAx/IrMaNqkh3bICC4b15TraFDTW10be2LKM8lYDdSV?=
 =?iso-8859-1?Q?zpPp5BrTQesUe1ioInhvvp3b/WH9ldn2y88oLL4c4KtUXH/DzLBamWqno1?=
 =?iso-8859-1?Q?kkwA1Jo5QJDtG+6q+L5hEZ4/FsiS89u3N6uXOoE/2D0z2WTC3DfAtrIOZA?=
 =?iso-8859-1?Q?c7qZsvP7DFEyrLLzCi9qda8s8c2I35trBLOFromO+8yT6o6iefpL/++Ykl?=
 =?iso-8859-1?Q?6Pl33rPgkbq4RrmENTGKFCvK7rdGt0HHZ4EECS2ykUuP2o5oRWXAXU2Z8J?=
 =?iso-8859-1?Q?fhD0Oyo79HUMsFjDFGDZY68XVDB+F3wJuflVXxQ+nvLGvUcMWwbih9rduA?=
 =?iso-8859-1?Q?QDgK9ehg6IGBrCJFcSUbxGHKPrgszYABb7leNiWxd0Lx0HPXYdNXgv+r+/?=
 =?iso-8859-1?Q?V2O1wJWw7agX4gvsFGVEOPV8La3eIywD+TPlgpXuin9pPOs6/TfWfhN69n?=
 =?iso-8859-1?Q?M9ZZLkFShkw2PShhmuxFe1xBLDFZZOJYWz2FwCF3MwHiiIWYtkAwAyYaeN?=
 =?iso-8859-1?Q?lpKU5sMzknyHAKPKTuv2f3cKDTYRduJLRCYSNlVu7VBsd1ZAIuKFua1+x0?=
 =?iso-8859-1?Q?SphCo2iuwBlOTmfFweRmx9hJXi6A5rg6kebQXmPdP3EHiLcqvoEf8hY/h1?=
 =?iso-8859-1?Q?5YgZSB3GaiM0+CO6bm+I1R9Mm4PrRl2/aLvcO4U5XruFP3+HjmbIa5PPzm?=
 =?iso-8859-1?Q?8NjdVNdC+K3rJ9b2cgkV6Q9yik62PfukX3J//elHzJ51v5wspuTYavbvLZ?=
 =?iso-8859-1?Q?fYDPsccKjlGVWfenZRJ/vslvZyuiOqri7+v1xXUMNYf40OUFWjqPYGkZrx?=
 =?iso-8859-1?Q?b50PSQmkRrjq57AQj5ewYmWq5n5fhIR7dFfH1RbwjhZ+SjFUnMZOf++OiG?=
 =?iso-8859-1?Q?wcAPaIJR2LAH4razCZNKMhlQh78FwtSQ8mLANXvSh+f5z9BGs+2sA3wifU?=
 =?iso-8859-1?Q?Hioq4nK5Z0E18JpEqcg9IgpEeMdy6+1m+EhbYrRkr1sHr2Gik9ukH0RPPo?=
 =?iso-8859-1?Q?qiDacKqXUHP0agCZKxJHk00cPJ1Y5qfvHKCNso8RonPw4itTtRTBthzulD?=
 =?iso-8859-1?Q?fWYst6O77gfO9pSQZfXjw3vJQo0swPT/FD0ZsKXM/sI9p84h01FordpYQu?=
 =?iso-8859-1?Q?5rDND4spYLytu/nb98j6Ko?=
Content-Type: multipart/mixed;
	boundary="_004_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR08MB11670.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9360d1c6-4195-43bc-86f7-08de582d428e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 14:07:34.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6623

--_004_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_
Content-Type: multipart/alternative;
	boundary="_000_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_"

--_000_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This series optimizes the TI ADS131E08 ADC driver for better performance
and reliability.

Key improvements in the driver:
- Switch from RDATA polling to RDATAC continuous mode in buffer operations
for reduced SPI overhead during continuous data acquisition
- Add proper timing delays between SPI register writes to meet device
timing requirements
- Consolidate channel configuration functions to minimize unnecessary
SPI transactions
- Add status checking and proper cleanup functions
- Remove redundant code and improve overall code structure

Patch 1 contains the driver optimizations.

As a sidenote, I noticed that the driver is not present in MAINTAINERS file=
.

This is my first contribution to the Linux kernel,
hopefully I did everything correctly.
Please let me know if any changes are needed.

Viktor Karamanis (1):
iio: adc: ti-ads131e08: Optimize performance and fix timing

drivers/iio/adc/ti-ads131e08.c | 643 ++++++++++++++++++++-------------
1 file changed, 389 insertions(+), 254 deletions(-)

--
2.43.0




--_000_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof">
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
This series optimizes the TI ADS131E08 ADC driver for better performance</d=
iv>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
and reliability.</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Key improvements in the driver:</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
- Switch from RDATA polling to RDATAC continuous mode in buffer operations<=
/div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
for reduced SPI overhead during continuous data acquisition</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
- Add proper timing delays between SPI register writes to meet device</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
timing requirements</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
- Consolidate channel configuration functions to minimize unnecessary</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
SPI transactions</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
- Add status checking and proper cleanup functions</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
- Remove redundant code and improve overall code structure</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Patch 1 contains the driver optimizations.</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
As a sidenote, I noticed that the driver is not present in MAINTAINERS file=
.</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
This is my first contribution to the Linux kernel,</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
hopefully I did everything correctly.</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Please let me know if any changes are needed.</div>
</div>
<div class=3D"elementToProof">
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Viktor Karamanis (1):</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
iio: adc: ti-ads131e08: Optimize performance and fix timing</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
drivers/iio/adc/ti-ads131e08.c | 643 ++++++++++++++++++++-------------</div=
>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
1 file changed, 389 insertions(+), 254 deletions(-)</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
--</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
2.43.0</div>
<div style=3D"line-height: 18px; font-family: Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
<br>
</div>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_--

--_004_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_
Content-Type: application/octet-stream;
	name="0001-iio-adc-ti-ads131e08-Optimize-performance-and-fix-ti.patch"
Content-Description:
 0001-iio-adc-ti-ads131e08-Optimize-performance-and-fix-ti.patch
Content-Disposition: attachment;
	filename="0001-iio-adc-ti-ads131e08-Optimize-performance-and-fix-ti.patch";
	size=33281; creation-date="Tue, 20 Jan 2026 14:06:33 GMT";
	modification-date="Tue, 20 Jan 2026 14:06:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzN2JmMDBkYzg4MGU0Y2NhZTg1NzhmNjgyNGQ0NjJkMTkzY2M2Nzc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaWt0b3IgS2FyYW1hbmlzIDx2aWt0b3Iua2FyYW1hbmlzQG91
dGxvb2suY29tPgpEYXRlOiBUdWUsIDIwIEphbiAyMDI2IDE0OjQ2OjI4ICswMjAwClN1YmplY3Q6
IFtQQVRDSCAxLzFdIGlpbzogYWRjOiB0aS1hZHMxMzFlMDg6IE9wdGltaXplIHBlcmZvcm1hbmNl
IGFuZCBmaXgKIHRpbWluZwoKT3B0aW1pemUgdGhlIFRJIEFEUzEzMUUwOCBBREMgZHJpdmVyIGZv
ciBiZXR0ZXIgcGVyZm9ybWFuY2UgYW5kCnJlbGlhYmlsaXR5OgoKMS4gU3dpdGNoIGZyb20gUkRB
VEEgcG9sbGluZyB0byBSREFUQUMgY29udGludW91cyBtb2RlIGluIGJ1ZmZlcgogICB0cmlnZ2Vy
IG9wZXJhdGlvbnMuIFRoaXMgcmVkdWNlcyBTUEkgb3ZlcmhlYWQgZHVyaW5nIGNvbnRpbnVvdXMK
ICAgZGF0YSBhY3F1aXNpdGlvbiBieSBlbGltaW5hdGluZyB0aGUgbmVlZCB0byBzZW5kIFJEQVRB
IGNvbW1hbmRzCiAgIGZvciBlYWNoIHNhbXBsZS4KCjIuIEFkZCBwcm9wZXIgdGltaW5nIGRlbGF5
cyBiZXR3ZWVuIFNQSSByZWdpc3RlciB3cml0ZXMuIFRoZSBBRFMxMzFFMDgKICAgcmVxdWlyZXMg
c3BlY2lmaWMgZGVsYXlzIGFmdGVyIGNlcnRhaW4gY29tbWFuZHMgYW5kIHJlZ2lzdGVyIHdyaXRl
cywKICAgd2hpY2ggd2VyZSBub3QgY29uc2lzdGVudGx5IGltcGxlbWVudGVkLgoKMy4gQ29uc29s
aWRhdGUgY2hhbm5lbCBjb25maWd1cmF0aW9uIGZ1bmN0aW9ucy4gUHJldmlvdXNseSwgbXVsdGlw
bGUKICAgZnVuY3Rpb25zIG1vZGlmaWVkIGNoYW5uZWwgcmVnaXN0ZXJzIHNlcGFyYXRlbHksIGNh
dXNpbmcgdW5uZWNlc3NhcnkKICAgU1BJIHRyYW5zYWN0aW9ucy4gTm93IGEgc2luZ2xlIGZ1bmN0
aW9uIGhhbmRsZXMgYWxsIGNoYW5uZWwKICAgY29uZmlndXJhdGlvbiBjaGFuZ2VzLgoKNC4gQWRk
IGFkczEzMWUwOF9jaGVja19zdGF0dXMoKSBmdW5jdGlvbiB0byBjaGVjayBkZXZpY2Ugc3RhdHVz
IGJpdHMKICAgZm9yIGZhdWx0IGNvbmRpdGlvbnMsIGltcHJvdmluZyBlcnJvciBkZXRlY3Rpb24u
Cgo1LiBBZGQgYWRzMTMxZTA4X3N0b3BfcmVhZF9kYXRhX2NvbnRpbnVvdXMoKSBmdW5jdGlvbiBm
b3IgcHJvcGVyCiAgIGNsZWFudXAgd2hlbiBzdG9wcGluZyBjb250aW51b3VzIG1vZGUuCgo2LiBS
ZXBsYWNlIGFkczEzMWUwOF90cmlnZ2VyX29wcyB3aXRoIGFkczEzMWUwOF9idWZmZXJfcHJlZW5h
YmxlKCkgCiAgIGFuZCBhZHMxMzFlMDhfYnVmZmVyX3Bvc3RkaXNhYmxlKCkgZm9yIGJldHRlciBp
bnRlZ3JhdGlvbgogICB3aXRoIHRoZSBJSU8gYnVmZmVyIGZyYW1ld29yay4KCjcuIE1pbm9yIGNv
ZGUgY2xlYW51cCwgZm9ybWF0dGluZyBmaXhlcywgYW5kIGxpbnQgaW1wcm92ZW1lbnRzLgoKVGhl
IGRyaXZlcyBoYXMgYmVlbiB0ZXN0ZWQgb24gYSBSUEkgM2IrIHdpdGggMjVNaHogc3BpIHNwZWVk
CmFuZCBzYW1wbGUgcmF0ZXMgdXAgdG8gMTZrU1BTIHdpdGhvdXQgaXNzdWVzLgpBdCBzYW1wbGUg
cmF0ZXMgYWJvdmUgMTZrU1BTIG9jY2FzaW9uYWwgQ1JDIGVycm9ycyB3ZXJlIG9ic2VydmVkLAp3
aGljaCBtaWdodCBiZSByZWxhdGVkIHRvIGhhcmR3YXJlIGxpbWl0YXRpb25zLgoKU2lnbmVkLW9m
Zi1ieTogVmlrdG9yIEthcmFtYW5pcyA8dmlrdG9yLmthcmFtYW5pc0BvdXRsb29rLmNvbT4KLS0t
CiBkcml2ZXJzL2lpby9hZGMvdGktYWRzMTMxZTA4LmMgfCA2NDMgKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzg5IGluc2VydGlvbnMoKyksIDI1NCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvdGktYWRzMTMxZTA4LmMg
Yi9kcml2ZXJzL2lpby9hZGMvdGktYWRzMTMxZTA4LmMKaW5kZXggMDg1ZjBkNmZiMzllLi41MTI0
NjIyY2M1ODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaWlvL2FkYy90aS1hZHMxMzFlMDguYworKysg
Yi9kcml2ZXJzL2lpby9hZGMvdGktYWRzMTMxZTA4LmMKQEAgLTUsNiArNSw5IEBACiAgKiBDb3B5
cmlnaHQgKGMpIDIwMjAgQVZMIERpVEVTVCBHbWJICiAgKiAgIFRvbWlzbGF2IERlbmlzIDx0b21p
c2xhdi5kZW5pc0BhdmwuY29tPgogICoKKyAqIENvcHlyaWdodCAoYykgMjAyNiBWcnVtcCBJbmR1
c3RyaWFsIElPVCBTb2x1dGlvbnMgUC5DLgorICogICBWaWt0b3IgS2FyYW1hbmlzIDx2aWt0b3Iu
a2FyYW1hbmlzQG91dGxvb2suY29tPgorICoKICAqIERhdGFzaGVldDogaHR0cHM6Ly93d3cudGku
Y29tL2xpdC9kcy9zeW1saW5rL2FkczEzMWUwOC5wZGYKICAqLwogCkBAIC0yNiw1MCArMjksNTIg
QEAKICNpbmNsdWRlIDxsaW51eC91bmFsaWduZWQuaD4KIAogLyogQ29tbWFuZHMgKi8KLSNkZWZp
bmUgQURTMTMxRTA4X0NNRF9SRVNFVAkJMHgwNgotI2RlZmluZSBBRFMxMzFFMDhfQ01EX1NUQVJU
CQkweDA4Ci0jZGVmaW5lIEFEUzEzMUUwOF9DTURfU1RPUAkJMHgwQQotI2RlZmluZSBBRFMxMzFF
MDhfQ01EX09GRlNFVENBTAkJMHgxQQotI2RlZmluZSBBRFMxMzFFMDhfQ01EX1NEQVRBQwkJMHgx
MQotI2RlZmluZSBBRFMxMzFFMDhfQ01EX1JEQVRBCQkweDEyCi0jZGVmaW5lIEFEUzEzMUUwOF9D
TURfUlJFRyhyKQkJKEJJVCg1KSB8IChyICYgR0VOTUFTSyg0LCAwKSkpCi0jZGVmaW5lIEFEUzEz
MUUwOF9DTURfV1JFRyhyKQkJKEJJVCg2KSB8IChyICYgR0VOTUFTSyg0LCAwKSkpCisjZGVmaW5l
IEFEUzEzMUUwOF9DTURfUkVTRVQgMHgwNgorI2RlZmluZSBBRFMxMzFFMDhfQ01EX1NUQVJUIDB4
MDgKKyNkZWZpbmUgQURTMTMxRTA4X0NNRF9TVE9QIDB4MEEKKyNkZWZpbmUgQURTMTMxRTA4X0NN
RF9PRkZTRVRDQUwgMHgxQQorI2RlZmluZSBBRFMxMzFFMDhfQ01EX1JEQVRBQyAweDEwCisjZGVm
aW5lIEFEUzEzMUUwOF9DTURfU0RBVEFDIDB4MTEKKyNkZWZpbmUgQURTMTMxRTA4X0NNRF9SREFU
QSAweDEyCisjZGVmaW5lIEFEUzEzMUUwOF9DTURfUlJFRyhyKSAoQklUKDUpIHwgKHIgJiBHRU5N
QVNLKDQsIDApKSkKKyNkZWZpbmUgQURTMTMxRTA4X0NNRF9XUkVHKHIpIChCSVQoNikgfCAociAm
IEdFTk1BU0soNCwgMCkpKQogCiAvKiBSZWdpc3RlcnMgKi8KLSNkZWZpbmUgQURTMTMxRTA4X0FE
Ul9DRkcxUgkJMHgwMQotI2RlZmluZSBBRFMxMzFFMDhfQURSX0NGRzNSCQkweDAzCi0jZGVmaW5l
IEFEUzEzMUUwOF9BRFJfQ0gwUgkJMHgwNQorI2RlZmluZSBBRFMxMzFFMDhfQURSX0NGRzFSIDB4
MDEKKyNkZWZpbmUgQURTMTMxRTA4X0FEUl9DRkczUiAweDAzCisjZGVmaW5lIEFEUzEzMUUwOF9B
RFJfQ0gwUiAweDA1CiAKIC8qIENvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgMSAqLwotI2RlZmluZSBB
RFMxMzFFMDhfQ0ZHMVJfRFJfTUFTSwkJR0VOTUFTSygyLCAwKQorI2RlZmluZSBBRFMxMzFFMDhf
Q0ZHMVJfRFJfTUFTSyBHRU5NQVNLKDIsIDApCiAKIC8qIENvbmZpZ3VyYXRpb24gcmVnaXN0ZXIg
MyAqLwotI2RlZmluZSBBRFMxMzFFMDhfQ0ZHM1JfUERCX1JFRkJVRl9NQVNLCUJJVCg3KQotI2Rl
ZmluZSBBRFMxMzFFMDhfQ0ZHM1JfVlJFRl80Vl9NQVNLCUJJVCg1KQorI2RlZmluZSBBRFMxMzFF
MDhfQ0ZHM1JfUERCX1JFRkJVRl9NQVNLIEJJVCg3KQorI2RlZmluZSBBRFMxMzFFMDhfQ0ZHM1Jf
VlJFRl80Vl9NQVNLIEJJVCg1KQogCiAvKiBDaGFubmVsIHNldHRpbmdzIHJlZ2lzdGVyICovCi0j
ZGVmaW5lIEFEUzEzMUUwOF9DSFJfR0FJTl9NQVNLCQlHRU5NQVNLKDYsIDQpCi0jZGVmaW5lIEFE
UzEzMUUwOF9DSFJfTVVYX01BU0sJCUdFTk1BU0soMiwgMCkKLSNkZWZpbmUgQURTMTMxRTA4X0NI
Ul9QV0RfTUFTSwkJQklUKDcpCisjZGVmaW5lIEFEUzEzMUUwOF9DSFJfR0FJTl9NQVNLIEdFTk1B
U0soNiwgNCkKKyNkZWZpbmUgQURTMTMxRTA4X0NIUl9NVVhfTUFTSyBHRU5NQVNLKDIsIDApCisj
ZGVmaW5lIEFEUzEzMUUwOF9DSFJfUFdEX01BU0sgQklUKDcpCiAKIC8qIEFEQyAgbWlzYyAqLwot
I2RlZmluZSBBRFMxMzFFMDhfREVGQVVMVF9EQVRBX1JBVEUJMQotI2RlZmluZSBBRFMxMzFFMDhf
REVGQVVMVF9QR0FfR0FJTgkxCi0jZGVmaW5lIEFEUzEzMUUwOF9ERUZBVUxUX01VWAkJMAorI2Rl
ZmluZSBBRFMxMzFFMDhfREVGQVVMVF9EQVRBX1JBVEUgMQorI2RlZmluZSBBRFMxMzFFMDhfREVG
QVVMVF9QR0FfR0FJTiAxCisjZGVmaW5lIEFEUzEzMUUwOF9ERUZBVUxUX01VWCAwCiAKLSNkZWZp
bmUgQURTMTMxRTA4X1ZSRUZfMlY0X21WCQkyNDAwCi0jZGVmaW5lIEFEUzEzMUUwOF9WUkVGXzRW
X21WCQk0MDAwCisjZGVmaW5lIEFEUzEzMUUwOF9WUkVGXzJWNF9tViAyNDAwCisjZGVmaW5lIEFE
UzEzMUUwOF9WUkVGXzRWX21WIDQwMDAKIAotI2RlZmluZSBBRFMxMzFFMDhfV0FJVF9SRVNFVF9D
WUNMRVMJMTgKLSNkZWZpbmUgQURTMTMxRTA4X1dBSVRfU0RFQ09ERV9DWUNMRVMJNAotI2RlZmlu
ZSBBRFMxMzFFMDhfV0FJVF9PRkZTRVRDQUxfTVMJMTUzCi0jZGVmaW5lIEFEUzEzMUUwOF9NQVhf
U0VUVExJTkdfVElNRV9NUwk2CisjZGVmaW5lIEFEUzEzMUUwOF9XQUlUX1JFU0VUX0NZQ0xFUyAy
MAorI2RlZmluZSBBRFMxMzFFMDhfV0FJVF9TREVDT0RFX0NZQ0xFUyA2CisjZGVmaW5lIEFEUzEz
MUUwOF9XQUlUX09GRlNFVENBTF9NUyAyMDAKKyNkZWZpbmUgQURTMTMxRTA4X01BWF9TRVRUTElO
R19USU1FX01TIDYKIAotI2RlZmluZSBBRFMxMzFFMDhfTlVNX1NUQVRVU19CWVRFUwkzCi0jZGVm
aW5lIEFEUzEzMUUwOF9OVU1fREFUQV9CWVRFU19NQVgJMjQKLSNkZWZpbmUgQURTMTMxRTA4X05V
TV9EQVRBX0JZVEVTKGRyKQkoKChkcikgPj0gMzIpID8gMiA6IDMpCi0jZGVmaW5lIEFEUzEzMUUw
OF9OVU1fREFUQV9CSVRTKGRyKQkoQURTMTMxRTA4X05VTV9EQVRBX0JZVEVTKGRyKSAqIDgpCi0j
ZGVmaW5lIEFEUzEzMUUwOF9OVU1fU1RPUkFHRV9CWVRFUwk0CisjZGVmaW5lIEFEUzEzMUUwOF9O
VU1fT0ZfQ0hBTk5FTFNfTUFYIDgKKyNkZWZpbmUgQURTMTMxRTA4X05VTV9TVEFUVVNfQllURVMg
MworI2RlZmluZSBBRFMxMzFFMDhfTlVNX0RBVEFfQllURVNfTUFYIDI0CisjZGVmaW5lIEFEUzEz
MUUwOF9OVU1fREFUQV9CWVRFUyhkcikgKCgoZHIpID49IDMyKSA/IDIgOiAzKQorI2RlZmluZSBB
RFMxMzFFMDhfTlVNX0RBVEFfQklUUyhkcikgKEFEUzEzMUUwOF9OVU1fREFUQV9CWVRFUyhkcikg
KiA4KQorI2RlZmluZSBBRFMxMzFFMDhfTlVNX1NUT1JBR0VfQllURVMgNAogCiBlbnVtIGFkczEz
MWUwOF9pZHMgewogCWFkczEzMWUwNCwKQEAgLTkyLDI2ICs5NywyNSBAQCBzdHJ1Y3QgYWRzMTMx
ZTA4X3N0YXRlIHsKIAlzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpOwogCXN0cnVjdCBpaW9fdHJpZ2dl
ciAqdHJpZzsKIAlzdHJ1Y3QgY2xrICphZGNfY2xrOwotCXN0cnVjdCByZWd1bGF0b3IgKnZyZWZf
cmVnOwotCXN0cnVjdCBhZHMxMzFlMDhfY2hhbm5lbF9jb25maWcgKmNoYW5uZWxfY29uZmlnOwot
CXVuc2lnbmVkIGludCBkYXRhX3JhdGU7Ci0JdW5zaWduZWQgaW50IHZyZWZfbXY7CisJc3RydWN0
IGNvbXBsZXRpb24gY29tcGxldGlvbjsKIAl1bnNpZ25lZCBpbnQgc2RlY29kZV9kZWxheV91czsK
IAl1bnNpZ25lZCBpbnQgcmVzZXRfZGVsYXlfdXM7Ci0JdW5zaWduZWQgaW50IHJlYWRiYWNrX2xl
bjsKLQlzdHJ1Y3QgY29tcGxldGlvbiBjb21wbGV0aW9uOwotCXN0cnVjdCB7Ci0JCXU4IGRhdGFb
QURTMTMxRTA4X05VTV9EQVRBX0JZVEVTX01BWF07Ci0JCWFsaWduZWRfczY0IHRzOwotCX0gdG1w
X2J1ZjsKLQotCXU4IHR4X2J1ZlszXSBfX2FsaWduZWQoSUlPX0RNQV9NSU5BTElHTik7CisJc3Ry
dWN0IHJlZ3VsYXRvciAqdnJlZl9yZWc7CisJdW5zaWduZWQgaW50IHZyZWZfbXY7CisJc3RydWN0
IGFkczEzMWUwOF9jaGFubmVsX2NvbmZpZyAqY2hhbm5lbF9jb25maWc7CisJdTggZGF0YV9yYXRl
OworCXU4IHJlYWRiYWNrX2xlbjsKKwlib29sIHJkYXRhY19lbmFibGVkOworCXN0cnVjdCBzcGlf
dHJhbnNmZXIgeGZlcjsKKwlzdHJ1Y3Qgc3BpX21lc3NhZ2UgbXNnOwogCS8qCiAJICogQWRkIGV4
dHJhIG9uZSBwYWRkaW5nIGJ5dGUgdG8gYmUgYWJsZSB0byBhY2Nlc3MgdGhlIGxhc3QgY2hhbm5l
bAogCSAqIHZhbHVlIHVzaW5nIHUzMiBwb2ludGVyCiAJICovCi0JdTggcnhfYnVmW0FEUzEzMUUw
OF9OVU1fU1RBVFVTX0JZVEVTICsKLQkJQURTMTMxRTA4X05VTV9EQVRBX0JZVEVTX01BWCArIDFd
OworCXU4IHJ4X2J1ZltBRFMxMzFFMDhfTlVNX1NUQVRVU19CWVRFUyArIEFEUzEzMUUwOF9OVU1f
REFUQV9CWVRFU19NQVggKworCQkgIDFdIF9fYWxpZ25lZChJSU9fRE1BX01JTkFMSUdOKTsKKwl1
OCBkYXRhW0FEUzEzMUUwOF9OVU1fT0ZfQ0hBTk5FTFNfTUFYICoKKwkJQURTMTMxRTA4X05VTV9T
VE9SQUdFX0JZVEVTXSBfX2FsaWduZWQoSUlPX0RNQV9NSU5BTElHTik7CiB9OwogCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IGFkczEzMWUwOF9pbmZvIGFkczEzMWUwOF9pbmZvX3RibFtdID0gewpAQCAt
MTMwLDEyNSArMTM0LDIwNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFkczEzMWUwOF9pbmZvIGFk
czEzMWUwOF9pbmZvX3RibFtdID0gewogfTsKIAogc3RydWN0IGFkczEzMWUwOF9kYXRhX3JhdGVf
ZGVzYyB7Ci0JdW5zaWduZWQgaW50IHJhdGU7ICAvKiBkYXRhIHJhdGUgaW4ga1NQUyAqLwotCXU4
IHJlZzsgICAgICAgICAgICAgLyogcmVnIHZhbHVlICovCisJdW5zaWduZWQgaW50IHJhdGU7IC8q
IGRhdGEgcmF0ZSBpbiBrU1BTICovCisJdTggcmVnOyAvKiByZWcgdmFsdWUgKi8KIH07CiAKIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYWRzMTMxZTA4X2RhdGFfcmF0ZV9kZXNjIGFkczEzMWUwOF9kYXRh
X3JhdGVfdGJsW10gPSB7Ci0JeyAucmF0ZSA9IDY0LCAgIC5yZWcgPSAweDAwIH0sCi0JeyAucmF0
ZSA9IDMyLCAgIC5yZWcgPSAweDAxIH0sCi0JeyAucmF0ZSA9IDE2LCAgIC5yZWcgPSAweDAyIH0s
Ci0JeyAucmF0ZSA9IDgsICAgIC5yZWcgPSAweDAzIH0sCi0JeyAucmF0ZSA9IDQsICAgIC5yZWcg
PSAweDA0IH0sCi0JeyAucmF0ZSA9IDIsICAgIC5yZWcgPSAweDA1IH0sCi0JeyAucmF0ZSA9IDEs
ICAgIC5yZWcgPSAweDA2IH0sCisJeyAucmF0ZSA9IDY0LCAucmVnID0gMHgwMCB9LCB7IC5yYXRl
ID0gMzIsIC5yZWcgPSAweDAxIH0sCisJeyAucmF0ZSA9IDE2LCAucmVnID0gMHgwMiB9LCB7IC5y
YXRlID0gOCwgLnJlZyA9IDB4MDMgfSwKKwl7IC5yYXRlID0gNCwgLnJlZyA9IDB4MDQgfSwgIHsg
LnJhdGUgPSAyLCAucmVnID0gMHgwNSB9LAorCXsgLnJhdGUgPSAxLCAucmVnID0gMHgwNiB9LAog
fTsKIAogc3RydWN0IGFkczEzMWUwOF9wZ2FfZ2Fpbl9kZXNjIHsKLQl1bnNpZ25lZCBpbnQgZ2Fp
bjsgIC8qIFBHQSBnYWluIHZhbHVlICovCi0JdTggcmVnOyAgICAgICAgICAgICAvKiBmaWVsZCB2
YWx1ZSAqLworCXVuc2lnbmVkIGludCBnYWluOyAvKiBQR0EgZ2FpbiB2YWx1ZSAqLworCXU4IHJl
ZzsgLyogZmllbGQgdmFsdWUgKi8KIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRzMTMxZTA4
X3BnYV9nYWluX2Rlc2MgYWRzMTMxZTA4X3BnYV9nYWluX3RibFtdID0gewotCXsgLmdhaW4gPSAx
LCAgIC5yZWcgPSAweDAxIH0sCi0JeyAuZ2FpbiA9IDIsICAgLnJlZyA9IDB4MDIgfSwKLQl7IC5n
YWluID0gNCwgICAucmVnID0gMHgwNCB9LAotCXsgLmdhaW4gPSA4LCAgIC5yZWcgPSAweDA1IH0s
Ci0JeyAuZ2FpbiA9IDEyLCAgLnJlZyA9IDB4MDYgfSwKKwl7IC5nYWluID0gMSwgLnJlZyA9IDB4
MDEgfSwgIHsgLmdhaW4gPSAyLCAucmVnID0gMHgwMiB9LAorCXsgLmdhaW4gPSA0LCAucmVnID0g
MHgwNCB9LCAgeyAuZ2FpbiA9IDgsIC5yZWcgPSAweDA1IH0sCisJeyAuZ2FpbiA9IDEyLCAucmVn
ID0gMHgwNiB9LAogfTsKIAogc3RhdGljIGNvbnN0IHU4IGFkczEzMWUwOF92YWxpZF9jaGFubmVs
X211eF92YWx1ZXNbXSA9IHsgMCwgMSwgMywgNCB9OwogCi1zdGF0aWMgaW50IGFkczEzMWUwOF9l
eGVjX2NtZChzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCwgdTggY21kKQorc3RhdGljIGludCBh
ZHMxMzFlMDhfZXhlY19jbWQoc3RydWN0IGFkczEzMWUwOF9zdGF0ZSAqc3QsIHU4IGNtZCwKKwkJ
CSAgICAgIHVuc2lnbmVkIGxvbmcgZGVsYXlfdXMpCiB7CiAJaW50IHJldDsKKwl1OCB0eCA9IGNt
ZDsKIAotCXJldCA9IHNwaV93cml0ZV90aGVuX3JlYWQoc3QtPnNwaSwgJmNtZCwgMSwgTlVMTCwg
MCk7Ci0JaWYgKHJldCkKLQkJZGV2X2Vycigmc3QtPnNwaS0+ZGV2LCAiRXhlYyBjbWQoJTAyeCkg
ZmFpbGVkXG4iLCBjbWQpOworCXN0cnVjdCBzcGlfdHJhbnNmZXIgdHJhbnNmZXIgPSB7CisJCS50
eF9idWYgPSAmdHgsCisJCS5sZW4gPSAxLAorCQkuY3NfY2hhbmdlID0gMCwKKwkJLmRlbGF5ID0g
eyAudmFsdWUgPSBkZWxheV91cywgLnVuaXQgPSBTUElfREVMQVlfVU5JVF9VU0VDUyB9CisJfTsK
IAotCXJldHVybiByZXQ7CisJcmV0ID0gc3BpX3N5bmNfdHJhbnNmZXIoc3QtPnNwaSwgJnRyYW5z
ZmVyLCAxKTsKKwlpZiAocmV0KSB7CisJCWRldl9lcnIoJnN0LT5zcGktPmRldiwgIkV4ZWMgY21k
IDB4JTAyeCBmYWlsZWQ6ICVkXG4iLCBjbWQsCisJCQlyZXQpOworCQlyZXR1cm4gcmV0OworCX0K
KworCWRldl9pbmZvKCZzdC0+c3BpLT5kZXYsICJFeGVjIGNtZCAweCUwMnhcbiIsIGNtZCk7CisJ
cmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgYWRzMTMxZTA4X3JlYWRfcmVnKHN0cnVjdCBhZHMx
MzFlMDhfc3RhdGUgKnN0LCB1OCByZWcpCitzdGF0aWMgaW50IGFkczEzMWUwOF9yZWFkX3JlZyhz
dHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCwgdTggcmVnLCB1OCAqdmFsKQogewogCWludCByZXQ7
CisJdTggY21kMCA9IEFEUzEzMUUwOF9DTURfUlJFRyhyZWcpOworCXU4IGNtZDEgPSAweDAwOwor
CXU4IHJ4OworCiAJc3RydWN0IHNwaV90cmFuc2ZlciB0cmFuc2ZlcltdID0gewotCQl7Ci0JCQku
dHhfYnVmID0gJnN0LT50eF9idWYsCi0JCQkubGVuID0gMiwKLQkJCS5kZWxheSA9IHsKLQkJCQku
dmFsdWUgPSBzdC0+c2RlY29kZV9kZWxheV91cywKLQkJCQkudW5pdCA9IFNQSV9ERUxBWV9VTklU
X1VTRUNTLAotCQkJfSwKLQkJfSwgewotCQkJLnJ4X2J1ZiA9ICZzdC0+cnhfYnVmLAotCQkJLmxl
biA9IDEsCi0JCX0sCisJCXsgLnR4X2J1ZiA9ICZjbWQwLAorCQkgIC5sZW4gPSAxLAorCQkgIC5j
c19jaGFuZ2UgPSAwLAorCQkgIC5kZWxheSA9IHsgLnZhbHVlID0gc3QtPnNkZWNvZGVfZGVsYXlf
dXMsCisJCQkgICAgIC51bml0ID0gU1BJX0RFTEFZX1VOSVRfVVNFQ1MgfSB9LAorCQl7IC50eF9i
dWYgPSAmY21kMSwKKwkJICAubGVuID0gMSwKKwkJICAuY3NfY2hhbmdlID0gMCwKKwkJICAuZGVs
YXkgPSB7IC52YWx1ZSA9IHN0LT5zZGVjb2RlX2RlbGF5X3VzLAorCQkJICAgICAudW5pdCA9IFNQ
SV9ERUxBWV9VTklUX1VTRUNTIH0gfSwKKwkJeyAucnhfYnVmID0gJnJ4LCAubGVuID0gMSwgLmNz
X2NoYW5nZSA9IDAgfQogCX07CiAKLQlzdC0+dHhfYnVmWzBdID0gQURTMTMxRTA4X0NNRF9SUkVH
KHJlZyk7Ci0Jc3QtPnR4X2J1ZlsxXSA9IDA7Ci0KLQlyZXQgPSBzcGlfc3luY190cmFuc2Zlcihz
dC0+c3BpLCB0cmFuc2ZlciwgQVJSQVlfU0laRSh0cmFuc2ZlcikpOworCXJldCA9IHNwaV9zeW5j
X3RyYW5zZmVyKHN0LT5zcGksIHRyYW5zZmVyLCAzKTsKIAlpZiAocmV0KSB7Ci0JCWRldl9lcnIo
JnN0LT5zcGktPmRldiwgIlJlYWQgcmVnaXN0ZXIgZmFpbGVkXG4iKTsKKwkJZGV2X2Vycigmc3Qt
PnNwaS0+ZGV2LCAiUmVhZCByZWcgMHglMDJ4IGZhaWxlZDogJWRcbiIsIHJlZywKKwkJCXJldCk7
CiAJCXJldHVybiByZXQ7CiAJfQogCi0JcmV0dXJuIHN0LT5yeF9idWZbMF07CisJKnZhbCA9IHJ4
OworCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgYWRzMTMxZTA4X3dyaXRlX3JlZyhzdHJ1
Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCwgdTggcmVnLCB1OCB2YWx1ZSkKIHsKIAlpbnQgcmV0Owor
CXU4IGNtZDAgPSBBRFMxMzFFMDhfQ01EX1dSRUcocmVnKTsKKwl1OCBjbWQxID0gMHgwMDsKKwl1
OCBjbWQyID0gdmFsdWU7CisKIAlzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHRyYW5zZmVyW10gPSB7Ci0J
CXsKLQkJCS50eF9idWYgPSAmc3QtPnR4X2J1ZiwKLQkJCS5sZW4gPSAzLAotCQkJLmRlbGF5ID0g
ewotCQkJCS52YWx1ZSA9IHN0LT5zZGVjb2RlX2RlbGF5X3VzLAotCQkJCS51bml0ID0gU1BJX0RF
TEFZX1VOSVRfVVNFQ1MsCi0JCQl9LAotCQl9CisJCXsgLnR4X2J1ZiA9ICZjbWQwLAorCQkgIC5s
ZW4gPSAxLAorCQkgIC5jc19jaGFuZ2UgPSAwLAorCQkgIC5kZWxheSA9IHsgLnZhbHVlID0gc3Qt
PnNkZWNvZGVfZGVsYXlfdXMsCisJCQkgICAgIC51bml0ID0gU1BJX0RFTEFZX1VOSVRfVVNFQ1Mg
fSB9LAorCQl7IC50eF9idWYgPSAmY21kMSwKKwkJICAubGVuID0gMSwKKwkJICAuY3NfY2hhbmdl
ID0gMCwKKwkJICAuZGVsYXkgPSB7IC52YWx1ZSA9IHN0LT5zZGVjb2RlX2RlbGF5X3VzLAorCQkJ
ICAgICAudW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTIH0gfSwKKwkJeyAudHhfYnVmID0gJmNt
ZDIsCisJCSAgLmxlbiA9IDEsCisJCSAgLmNzX2NoYW5nZSA9IDAsCisJCSAgLmRlbGF5ID0geyAu
dmFsdWUgPSBzdC0+c2RlY29kZV9kZWxheV91cywKKwkJCSAgICAgLnVuaXQgPSBTUElfREVMQVlf
VU5JVF9VU0VDUyB9IH0KIAl9OwogCi0Jc3QtPnR4X2J1ZlswXSA9IEFEUzEzMUUwOF9DTURfV1JF
RyhyZWcpOwotCXN0LT50eF9idWZbMV0gPSAwOwotCXN0LT50eF9idWZbMl0gPSB2YWx1ZTsKKwly
ZXQgPSBzcGlfc3luY190cmFuc2ZlcihzdC0+c3BpLCB0cmFuc2ZlciwgMyk7CisJaWYgKHJldCkg
eworCQlkZXZfZXJyKCZzdC0+c3BpLT5kZXYsICJXcml0ZSByZWcgMHglMDJ4IGZhaWxlZDogJWRc
biIsIHJlZywKKwkJCXJldCk7CisJCXJldHVybiByZXQ7CisJfQogCi0JcmV0ID0gc3BpX3N5bmNf
dHJhbnNmZXIoc3QtPnNwaSwgdHJhbnNmZXIsIEFSUkFZX1NJWkUodHJhbnNmZXIpKTsKLQlpZiAo
cmV0KQotCQlkZXZfZXJyKCZzdC0+c3BpLT5kZXYsICJXcml0ZSByZWdpc3RlciBmYWlsZWRcbiIp
OworCWRldl9pbmZvKCZzdC0+c3BpLT5kZXYsICJXcml0dGVuIHRvIDB4JTAyeDogdmFsdWU9JTAy
eFxuIiwgY21kMCwgY21kMik7CiAKLQlyZXR1cm4gcmV0OworCXJldHVybiAwOwogfQogCi1zdGF0
aWMgaW50IGFkczEzMWUwOF9yZWFkX2RhdGEoc3RydWN0IGFkczEzMWUwOF9zdGF0ZSAqc3QsIGlu
dCByeF9sZW4pCitzdGF0aWMgaW50IGFkczEzMWUwOF9yZWFkX2RhdGEoc3RydWN0IGFkczEzMWUw
OF9zdGF0ZSAqc3QpCiB7CiAJaW50IHJldDsKKworCXU4IHR4ID0gQURTMTMxRTA4X0NNRF9SREFU
QTsKKwogCXN0cnVjdCBzcGlfdHJhbnNmZXIgdHJhbnNmZXJbXSA9IHsKLQkJewotCQkJLnR4X2J1
ZiA9ICZzdC0+dHhfYnVmLAotCQkJLmxlbiA9IDEsCi0JCX0sIHsKLQkJCS5yeF9idWYgPSAmc3Qt
PnJ4X2J1ZiwKLQkJCS5sZW4gPSByeF9sZW4sCi0JCX0sCisJCXsgLnR4X2J1ZiA9ICZ0eCwgLmxl
biA9IDEsIC5jc19jaGFuZ2UgPSAwIH0sCisJCXsgLnJ4X2J1ZiA9IHN0LT5yeF9idWYsIC5sZW4g
PSBzdC0+cmVhZGJhY2tfbGVuLCAuY3NfY2hhbmdlID0gMCB9CiAJfTsKIAotCXN0LT50eF9idWZb
MF0gPSBBRFMxMzFFMDhfQ01EX1JEQVRBOwotCi0JcmV0ID0gc3BpX3N5bmNfdHJhbnNmZXIoc3Qt
PnNwaSwgdHJhbnNmZXIsIEFSUkFZX1NJWkUodHJhbnNmZXIpKTsKKwlyZXQgPSBzcGlfc3luY190
cmFuc2ZlcihzdC0+c3BpLCB0cmFuc2ZlciwgMik7CiAJaWYgKHJldCkKIAkJZGV2X2Vycigmc3Qt
PnNwaS0+ZGV2LCAiUmVhZCBkYXRhIGZhaWxlZFxuIik7CiAKIAlyZXR1cm4gcmV0OwogfQogCitz
dGF0aWMgaW50IGFkczEzMWUwOF9zdG9wX3JlYWRfZGF0YV9jb250aW51b3VzKHN0cnVjdCBhZHMx
MzFlMDhfc3RhdGUgKnN0KQoreworCWludCByZXQ7CisJdTggbm9wID0gMHgwMDsKKworCXJldCA9
IGFkczEzMWUwOF9leGVjX2NtZChzdCwgQURTMTMxRTA4X0NNRF9TREFUQUMsCisJCQkJIHN0LT5z
ZGVjb2RlX2RlbGF5X3VzKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJcmV0ID0gc3Bp
X3dyaXRlKHN0LT5zcGksICZub3AsIDEpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwly
ZXQgPSBzcGlfcmVhZChzdC0+c3BpLCBzdC0+cnhfYnVmLCBzdC0+cmVhZGJhY2tfbGVuKTsKKwlp
ZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJcmV0ID0gc3BpX3dyaXRlKHN0LT5zcGksICZub3As
IDEpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGlj
IGludCBhZHMxMzFlMDhfY2hlY2tfc3RhdHVzKHN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0KQor
eworCXU4ICpidWYgPSBzdC0+cnhfYnVmOworCWludCBpOworCWludCByZXQgPSAwOworCisJdTMy
IHN0YXR1cyA9ICgodTMyKWJ1ZlswXSA8PCAxNikgfCAoKHUzMilidWZbMV0gPDwgOCkgfCAoKHUz
MilidWZbMl0pOworCisJLyogSGVhZGVyIGNoZWNrIChiaXRzIDIzOjIwKSBzaG91bGQgYmUgMGIx
MTAwICovCisJaWYgKCgoc3RhdHVzID4+IDIwKSAmIDB4RikgIT0gMHhDKSB7CisJCWRldl9kYmdf
cmF0ZWxpbWl0ZWQoJnN0LT5zcGktPmRldiwKKwkJCQkgICAgIlN0YXR1cyB3b3JkIGhlYWRlciBp
bnZhbGlkOiAweCUwNnhcbiIsCisJCQkJICAgIHN0YXR1cyk7CisJCXJldCA9IC1FSU87CisJfQor
CisJdTggcF9mYXVsdCA9IChzdGF0dXMgPj4gMTIpICYgMHhGRjsKKwl1OCBuX2ZhdWx0ID0gKHN0
YXR1cyA+PiA0KSAmIDB4RkY7CisKKwlmb3IgKGkgPSAwOyBpIDwgc3QtPmluZm8tPm1heF9jaGFu
bmVsczsgaSsrKSB7CisJCWlmIChwX2ZhdWx0ICYgQklUKGkpKQorCQkJZGV2X2RiZ19yYXRlbGlt
aXRlZCgKKwkJCQkmc3QtPnNwaS0+ZGV2LAorCQkJCSJQb3NpdGl2ZSBmYXVsdCBkZXRlY3RlZCBv
biBjaGFubmVsICVkXG4iLCBpKTsKKworCQlpZiAobl9mYXVsdCAmIEJJVChpKSkKKwkJCWRldl9k
YmdfcmF0ZWxpbWl0ZWQoCisJCQkJJnN0LT5zcGktPmRldiwKKwkJCQkiTmVnYXRpdmUgZmF1bHQg
ZGV0ZWN0ZWQgb24gY2hhbm5lbCAlZFxuIiwgaSk7CisJfQorCisJcmV0dXJuIHJldDsKK30KKwog
c3RhdGljIGludCBhZHMxMzFlMDhfc2V0X2RhdGFfcmF0ZShzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRl
ICpzdCwgaW50IGRhdGFfcmF0ZSkKIHsKLQlpbnQgaSwgcmVnLCByZXQ7CisJaW50IGksIHJldDsK
Kwl1OCByZWc7CiAKIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhZHMxMzFlMDhfZGF0YV9y
YXRlX3RibCk7IGkrKykgewogCQlpZiAoYWRzMTMxZTA4X2RhdGFfcmF0ZV90YmxbaV0ucmF0ZSA9
PSBkYXRhX3JhdGUpCkBAIC0yNjAsMjggKzM0NCwyOSBAQCBzdGF0aWMgaW50IGFkczEzMWUwOF9z
ZXRfZGF0YV9yYXRlKHN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0LCBpbnQgZGF0YV9yYXRlKQog
CQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKLQlyZWcgPSBhZHMxMzFlMDhfcmVhZF9yZWcoc3QsIEFE
UzEzMUUwOF9BRFJfQ0ZHMVIpOwotCWlmIChyZWcgPCAwKQotCQlyZXR1cm4gcmVnOworCXJldCA9
IGFkczEzMWUwOF9yZWFkX3JlZyhzdCwgQURTMTMxRTA4X0FEUl9DRkcxUiwgJnJlZyk7CisJaWYg
KHJldCkKKwkJcmV0dXJuIHJldDsKIAogCXJlZyAmPSB+QURTMTMxRTA4X0NGRzFSX0RSX01BU0s7
CiAJcmVnIHw9IEZJRUxEX1BSRVAoQURTMTMxRTA4X0NGRzFSX0RSX01BU0ssCi0JCWFkczEzMWUw
OF9kYXRhX3JhdGVfdGJsW2ldLnJlZyk7CisJCQkgIGFkczEzMWUwOF9kYXRhX3JhdGVfdGJsW2ld
LnJlZyk7CiAKIAlyZXQgPSBhZHMxMzFlMDhfd3JpdGVfcmVnKHN0LCBBRFMxMzFFMDhfQURSX0NG
RzFSLCByZWcpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKKwkvKiBVcGRhdGUgc3RhdGUg
Ki8KIAlzdC0+ZGF0YV9yYXRlID0gZGF0YV9yYXRlOwogCXN0LT5yZWFkYmFja19sZW4gPSBBRFMx
MzFFMDhfTlVNX1NUQVRVU19CWVRFUyArCi0JCUFEUzEzMUUwOF9OVU1fREFUQV9CWVRFUyhzdC0+
ZGF0YV9yYXRlKSAqCi0JCXN0LT5pbmZvLT5tYXhfY2hhbm5lbHM7CisJCQkgICBBRFMxMzFFMDhf
TlVNX0RBVEFfQllURVMoc3QtPmRhdGFfcmF0ZSkgKgorCQkJCSAgIHN0LT5pbmZvLT5tYXhfY2hh
bm5lbHM7CiAKIAlyZXR1cm4gMDsKIH0KIAogc3RhdGljIGludCBhZHMxMzFlMDhfcGdhX2dhaW5f
dG9fZmllbGRfdmFsdWUoc3RydWN0IGFkczEzMWUwOF9zdGF0ZSAqc3QsCi0JdW5zaWduZWQgaW50
IHBnYV9nYWluKQorCQkJCQkgICAgIHVuc2lnbmVkIGludCBwZ2FfZ2FpbikKIHsKIAlpbnQgaTsK
IApAQCAtMjk4LDI3ICszODMsOCBAQCBzdGF0aWMgaW50IGFkczEzMWUwOF9wZ2FfZ2Fpbl90b19m
aWVsZF92YWx1ZShzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCwKIAlyZXR1cm4gYWRzMTMxZTA4
X3BnYV9nYWluX3RibFtpXS5yZWc7CiB9CiAKLXN0YXRpYyBpbnQgYWRzMTMxZTA4X3NldF9wZ2Ff
Z2FpbihzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCwKLQl1bnNpZ25lZCBpbnQgY2hhbm5lbCwg
dW5zaWduZWQgaW50IHBnYV9nYWluKQotewotCWludCBmaWVsZF92YWx1ZSwgcmVnOwotCi0JZmll
bGRfdmFsdWUgPSBhZHMxMzFlMDhfcGdhX2dhaW5fdG9fZmllbGRfdmFsdWUoc3QsIHBnYV9nYWlu
KTsKLQlpZiAoZmllbGRfdmFsdWUgPCAwKQotCQlyZXR1cm4gZmllbGRfdmFsdWU7Ci0KLQlyZWcg
PSBhZHMxMzFlMDhfcmVhZF9yZWcoc3QsIEFEUzEzMUUwOF9BRFJfQ0gwUiArIGNoYW5uZWwpOwot
CWlmIChyZWcgPCAwKQotCQlyZXR1cm4gcmVnOwotCi0JcmVnICY9IH5BRFMxMzFFMDhfQ0hSX0dB
SU5fTUFTSzsKLQlyZWcgfD0gRklFTERfUFJFUChBRFMxMzFFMDhfQ0hSX0dBSU5fTUFTSywgZmll
bGRfdmFsdWUpOwotCi0JcmV0dXJuIGFkczEzMWUwOF93cml0ZV9yZWcoc3QsIEFEUzEzMUUwOF9B
RFJfQ0gwUiArIGNoYW5uZWwsIHJlZyk7Ci19Ci0KIHN0YXRpYyBpbnQgYWRzMTMxZTA4X3ZhbGlk
YXRlX2NoYW5uZWxfbXV4KHN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0LAotCXVuc2lnbmVkIGlu
dCBtdXgpCisJCQkJCSAgdW5zaWduZWQgaW50IG11eCkKIHsKIAlpbnQgaTsKIApAQCAtMzM1LDUw
ICs0MDEsNTQgQEAgc3RhdGljIGludCBhZHMxMzFlMDhfdmFsaWRhdGVfY2hhbm5lbF9tdXgoc3Ry
dWN0IGFkczEzMWUwOF9zdGF0ZSAqc3QsCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgYWRz
MTMxZTA4X3NldF9jaGFubmVsX211eChzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCwKLQl1bnNp
Z25lZCBpbnQgY2hhbm5lbCwgdW5zaWduZWQgaW50IG11eCkKK3N0YXRpYyBpbnQgYWRzMTMxZTA4
X3NldF9jaGFubmVsX2NvbmZpZyhzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCwKKwkJCQkJdW5z
aWduZWQgaW50IGNoYW5uZWwsCisJCQkJCXVuc2lnbmVkIGludCBwZ2FfZ2FpbiwgdW5zaWduZWQg
aW50IG11eCwKKwkJCQkJYm9vbCBwb3dlcl9kb3duKQogewotCWludCByZWc7Ci0KLQlyZWcgPSBh
ZHMxMzFlMDhfcmVhZF9yZWcoc3QsIEFEUzEzMUUwOF9BRFJfQ0gwUiArIGNoYW5uZWwpOwotCWlm
IChyZWcgPCAwKQotCQlyZXR1cm4gcmVnOworCWludCBnYWluLCByZXQ7CisJdTggcmVnOwogCi0J
cmVnICY9IH5BRFMxMzFFMDhfQ0hSX01VWF9NQVNLOwotCXJlZyB8PSBGSUVMRF9QUkVQKEFEUzEz
MUUwOF9DSFJfTVVYX01BU0ssIG11eCk7CisJLyogQ29udmVydCBnYWluIHRvIHJlZ2lzdGVyIGZp
ZWxkICovCisJZ2FpbiA9IGFkczEzMWUwOF9wZ2FfZ2Fpbl90b19maWVsZF92YWx1ZShzdCwgcGdh
X2dhaW4pOworCWlmIChnYWluIDwgMCkKKwkJcmV0dXJuIGdhaW47CiAKLQlyZXR1cm4gYWRzMTMx
ZTA4X3dyaXRlX3JlZyhzdCwgQURTMTMxRTA4X0FEUl9DSDBSICsgY2hhbm5lbCwgcmVnKTsKLX0K
KwkvKiBSZWFkIGN1cnJlbnQgY2hhbm5lbCByZWdpc3RlciAqLworCXJldCA9IGFkczEzMWUwOF9y
ZWFkX3JlZyhzdCwgQURTMTMxRTA4X0FEUl9DSDBSICsgY2hhbm5lbCwgJnJlZyk7CisJaWYgKHJl
dCkKKwkJcmV0dXJuIHJldDsKIAotc3RhdGljIGludCBhZHMxMzFlMDhfcG93ZXJfZG93bl9jaGFu
bmVsKHN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0LAotCXVuc2lnbmVkIGludCBjaGFubmVsLCBi
b29sIHZhbHVlKQotewotCWludCByZWc7CisJLyogVXBkYXRlIGdhaW4gKi8KKwlyZWcgJj0gfkFE
UzEzMUUwOF9DSFJfR0FJTl9NQVNLOworCXJlZyB8PSBGSUVMRF9QUkVQKEFEUzEzMUUwOF9DSFJf
R0FJTl9NQVNLLCBnYWluKTsKIAotCXJlZyA9IGFkczEzMWUwOF9yZWFkX3JlZyhzdCwgQURTMTMx
RTA4X0FEUl9DSDBSICsgY2hhbm5lbCk7Ci0JaWYgKHJlZyA8IDApCi0JCXJldHVybiByZWc7CisJ
LyogVXBkYXRlIG11eCAqLworCXJlZyAmPSB+QURTMTMxRTA4X0NIUl9NVVhfTUFTSzsKKwlyZWcg
fD0gRklFTERfUFJFUChBRFMxMzFFMDhfQ0hSX01VWF9NQVNLLCBtdXgpOwogCisJLyogVXBkYXRl
IHBvd2VyIGRvd24gKi8KIAlyZWcgJj0gfkFEUzEzMUUwOF9DSFJfUFdEX01BU0s7Ci0JcmVnIHw9
IEZJRUxEX1BSRVAoQURTMTMxRTA4X0NIUl9QV0RfTUFTSywgdmFsdWUpOworCXJlZyB8PSBGSUVM
RF9QUkVQKEFEUzEzMUUwOF9DSFJfUFdEX01BU0ssIHBvd2VyX2Rvd24pOwogCiAJcmV0dXJuIGFk
czEzMWUwOF93cml0ZV9yZWcoc3QsIEFEUzEzMUUwOF9BRFJfQ0gwUiArIGNoYW5uZWwsIHJlZyk7
CiB9CiAKIHN0YXRpYyBpbnQgYWRzMTMxZTA4X2NvbmZpZ19yZWZlcmVuY2Vfdm9sdGFnZShzdHJ1
Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCkKIHsKLQlpbnQgcmVnOworCWludCByZXQ7CisJdTggcmVn
OwogCi0JcmVnID0gYWRzMTMxZTA4X3JlYWRfcmVnKHN0LCBBRFMxMzFFMDhfQURSX0NGRzNSKTsK
LQlpZiAocmVnIDwgMCkKLQkJcmV0dXJuIHJlZzsKKwlyZXQgPSBhZHMxMzFlMDhfcmVhZF9yZWco
c3QsIEFEUzEzMUUwOF9BRFJfQ0ZHM1IsICZyZWcpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7
CiAKIAlyZWcgJj0gfkFEUzEzMUUwOF9DRkczUl9QREJfUkVGQlVGX01BU0s7CiAJaWYgKCFzdC0+
dnJlZl9yZWcpIHsKIAkJcmVnIHw9IEZJRUxEX1BSRVAoQURTMTMxRTA4X0NGRzNSX1BEQl9SRUZC
VUZfTUFTSywgMSk7CiAJCXJlZyAmPSB+QURTMTMxRTA4X0NGRzNSX1ZSRUZfNFZfTUFTSzsKIAkJ
cmVnIHw9IEZJRUxEX1BSRVAoQURTMTMxRTA4X0NGRzNSX1ZSRUZfNFZfTUFTSywKLQkJCXN0LT52
cmVmX212ID09IEFEUzEzMUUwOF9WUkVGXzRWX21WKTsKKwkJCQkgIHN0LT52cmVmX212ID09IEFE
UzEzMUUwOF9WUkVGXzRWX21WKTsKIAl9CiAKIAlyZXR1cm4gYWRzMTMxZTA4X3dyaXRlX3JlZyhz
dCwgQURTMTMxRTA4X0FEUl9DRkczUiwgcmVnKTsKQEAgLTM5MSwxNCArNDYxLDE2IEBAIHN0YXRp
YyBpbnQgYWRzMTMxZTA4X2luaXRpYWxfY29uZmlnKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYp
CiAJdW5zaWduZWQgbG9uZyBhY3RpdmVfY2hhbm5lbHMgPSAwOwogCWludCByZXQsIGk7CiAKLQly
ZXQgPSBhZHMxMzFlMDhfZXhlY19jbWQoc3QsIEFEUzEzMUUwOF9DTURfUkVTRVQpOworCS8qIERp
c2FibGUgcmVhZCBkYXRhIGluIGNvbnRpbnVvdXMgbW9kZSAoZW5hYmxlZCBieSBkZWZhdWx0KSAq
LworCXJldCA9IGFkczEzMWUwOF9zdG9wX3JlYWRfZGF0YV9jb250aW51b3VzKHN0KTsKIAlpZiAo
cmV0KQogCQlyZXR1cm4gcmV0OwogCi0JdWRlbGF5KHN0LT5yZXNldF9kZWxheV91cyk7CisJcmV0
ID0gYWRzMTMxZTA4X2V4ZWNfY21kKHN0LCBBRFMxMzFFMDhfQ01EX1JFU0VULCBzdC0+cmVzZXRf
ZGVsYXlfdXMpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CiAKLQkvKiBEaXNhYmxlIHJlYWQg
ZGF0YSBpbiBjb250aW51b3VzIG1vZGUgKGVuYWJsZWQgYnkgZGVmYXVsdCkgKi8KLQlyZXQgPSBh
ZHMxMzFlMDhfZXhlY19jbWQoc3QsIEFEUzEzMUUwOF9DTURfU0RBVEFDKTsKKwlyZXQgPSBhZHMx
MzFlMDhfc3RvcF9yZWFkX2RhdGFfY29udGludW91cyhzdCk7CiAJaWYgKHJldCkKIAkJcmV0dXJu
IHJldDsKIApAQCAtNDEwLDE0ICs0ODIsMTAgQEAgc3RhdGljIGludCBhZHMxMzFlMDhfaW5pdGlh
bF9jb25maWcoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikKIAlpZiAocmV0KQogCQlyZXR1cm4g
cmV0OwogCi0JZm9yIChpID0gMDsgIGkgPCBpbmRpb19kZXYtPm51bV9jaGFubmVsczsgaSsrKSB7
Ci0JCXJldCA9IGFkczEzMWUwOF9zZXRfcGdhX2dhaW4oc3QsIGNoYW5uZWwtPmNoYW5uZWwsCi0J
CQlzdC0+Y2hhbm5lbF9jb25maWdbaV0ucGdhX2dhaW4pOwotCQlpZiAocmV0KQotCQkJcmV0dXJu
IHJldDsKLQotCQlyZXQgPSBhZHMxMzFlMDhfc2V0X2NoYW5uZWxfbXV4KHN0LCBjaGFubmVsLT5j
aGFubmVsLAotCQkJc3QtPmNoYW5uZWxfY29uZmlnW2ldLm11eCk7CisJZm9yIChpID0gMDsgaSA8
IGluZGlvX2Rldi0+bnVtX2NoYW5uZWxzOyBpKyspIHsKKwkJcmV0ID0gYWRzMTMxZTA4X3NldF9j
aGFubmVsX2NvbmZpZygKKwkJCXN0LCBjaGFubmVsLT5jaGFubmVsLCBzdC0+Y2hhbm5lbF9jb25m
aWdbaV0ucGdhX2dhaW4sCisJCQlzdC0+Y2hhbm5lbF9jb25maWdbaV0ubXV4LCBmYWxzZSk7CiAJ
CWlmIChyZXQpCiAJCQlyZXR1cm4gcmV0OwogCkBAIC00MjcsMTMgKzQ5NSwxNiBAQCBzdGF0aWMg
aW50IGFkczEzMWUwOF9pbml0aWFsX2NvbmZpZyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQog
CiAJLyogUG93ZXIgZG93biB1bnVzZWQgY2hhbm5lbHMgKi8KIAlmb3JfZWFjaF9jbGVhcl9iaXQo
aSwgJmFjdGl2ZV9jaGFubmVscywgc3QtPmluZm8tPm1heF9jaGFubmVscykgewotCQlyZXQgPSBh
ZHMxMzFlMDhfcG93ZXJfZG93bl9jaGFubmVsKHN0LCBpLCB0cnVlKTsKKwkJcmV0ID0gYWRzMTMx
ZTA4X3NldF9jaGFubmVsX2NvbmZpZyhzdCwgaSwKKwkJCQkJCSAgIEFEUzEzMUUwOF9ERUZBVUxU
X1BHQV9HQUlOLAorCQkJCQkJICAgQURTMTMxRTA4X0RFRkFVTFRfTVVYLCB0cnVlKTsKIAkJaWYg
KHJldCkKIAkJCXJldHVybiByZXQ7CiAJfQogCiAJLyogUmVxdWVzdCBjaGFubmVsIG9mZnNldCBj
YWxpYnJhdGlvbiAqLwotCXJldCA9IGFkczEzMWUwOF9leGVjX2NtZChzdCwgQURTMTMxRTA4X0NN
RF9PRkZTRVRDQUwpOworCXJldCA9IGFkczEzMWUwOF9leGVjX2NtZChzdCwgQURTMTMxRTA4X0NN
RF9PRkZTRVRDQUwsCisJCQkJIHN0LT5zZGVjb2RlX2RlbGF5X3VzKTsKIAlpZiAocmV0KQogCQly
ZXR1cm4gcmV0OwogCkBAIC00NDQsNzIgKzUxNSw3OSBAQCBzdGF0aWMgaW50IGFkczEzMWUwOF9p
bml0aWFsX2NvbmZpZyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQogCSAqIHRpbWUgKGUuZy4g
Zmlyc3QgY2FsbCBvZiB0aGUgYWRzMTMxZTA4X3JlYWRfZGlyZWN0IG1ldGhvZCkuCiAJICogVG8g
YXZvaWQgdGhpcyBwcm9ibGVtIG9mZnNldCBjYWxpYnJhdGlvbiBpcyB0cmlnZ2VyZWQgaGVyZS4K
IAkgKi8KLQlyZXQgPSBhZHMxMzFlMDhfZXhlY19jbWQoc3QsIEFEUzEzMUUwOF9DTURfU1RBUlQp
OworCXJldCA9IGFkczEzMWUwOF9leGVjX2NtZChzdCwgQURTMTMxRTA4X0NNRF9TVEFSVCwKKwkJ
CQkgc3QtPnNkZWNvZGVfZGVsYXlfdXMgKworCQkJCQkgQURTMTMxRTA4X1dBSVRfT0ZGU0VUQ0FM
X01TICogMTAwMCk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAotCW1zbGVlcChBRFMxMzFF
MDhfV0FJVF9PRkZTRVRDQUxfTVMpOwotCi0JcmV0dXJuIGFkczEzMWUwOF9leGVjX2NtZChzdCwg
QURTMTMxRTA4X0NNRF9TVE9QKTsKKwlyZXR1cm4gYWRzMTMxZTA4X2V4ZWNfY21kKHN0LCBBRFMx
MzFFMDhfQ01EX1NUT1AsIHN0LT5zZGVjb2RlX2RlbGF5X3VzKTsKIH0KIAotc3RhdGljIGludCBh
ZHMxMzFlMDhfcG9vbF9kYXRhKHN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0KQorc3RhdGljIGlu
dCBhZHMxMzFlMDhfcG9sbF9kYXRhKHN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0KQogewotCXVu
c2lnbmVkIGxvbmcgdGltZW91dDsKIAlpbnQgcmV0OwogCiAJcmVpbml0X2NvbXBsZXRpb24oJnN0
LT5jb21wbGV0aW9uKTsKIAotCXJldCA9IGFkczEzMWUwOF9leGVjX2NtZChzdCwgQURTMTMxRTA4
X0NNRF9TVEFSVCk7CisJcmV0ID0gYWRzMTMxZTA4X2V4ZWNfY21kKHN0LCBBRFMxMzFFMDhfQ01E
X1NUQVJULCBzdC0+c2RlY29kZV9kZWxheV91cyk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsK
IAotCXRpbWVvdXQgPSBtc2Vjc190b19qaWZmaWVzKEFEUzEzMUUwOF9NQVhfU0VUVExJTkdfVElN
RV9NUyk7Ci0JcmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZzdC0+Y29tcGxldGlv
biwgdGltZW91dCk7CisJcmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KAorCQkmc3Qt
PmNvbXBsZXRpb24sCisJCW1zZWNzX3RvX2ppZmZpZXMoQURTMTMxRTA4X01BWF9TRVRUTElOR19U
SU1FX01TKSk7CiAJaWYgKCFyZXQpCiAJCXJldHVybiAtRVRJTUVET1VUOwogCi0JcmV0ID0gYWRz
MTMxZTA4X3JlYWRfZGF0YShzdCwgc3QtPnJlYWRiYWNrX2xlbik7CisJcmV0ID0gYWRzMTMxZTA4
X3JlYWRfZGF0YShzdCk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCXJldCA9IGFkczEz
MWUwOF9jaGVja19zdGF0dXMoc3QpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKLQlyZXR1
cm4gYWRzMTMxZTA4X2V4ZWNfY21kKHN0LCBBRFMxMzFFMDhfQ01EX1NUT1ApOworCXJldHVybiBh
ZHMxMzFlMDhfZXhlY19jbWQoc3QsIEFEUzEzMUUwOF9DTURfU1RPUCwgc3QtPnNkZWNvZGVfZGVs
YXlfdXMpOwogfQogCiBzdGF0aWMgaW50IGFkczEzMWUwOF9yZWFkX2RpcmVjdChzdHJ1Y3QgaWlv
X2RldiAqaW5kaW9fZGV2LAotCXN0cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFubmVsLCBp
bnQgKnZhbHVlKQorCQkJCSBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbm5lbCwKKwkJ
CQkgaW50ICp2YWx1ZSkKIHsKIAlzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCA9IGlpb19wcml2
KGluZGlvX2Rldik7CiAJdTggbnVtX2JpdHMsICpzcmM7CiAJaW50IHJldDsKIAotCXJldCA9IGFk
czEzMWUwOF9wb29sX2RhdGEoc3QpOworCXJldCA9IGFkczEzMWUwOF9wb2xsX2RhdGEoc3QpOwog
CWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKIAlzcmMgPSBzdC0+cnhfYnVmICsgQURTMTMxRTA4
X05VTV9TVEFUVVNfQllURVMgKwotCQljaGFubmVsLT5jaGFubmVsICogQURTMTMxRTA4X05VTV9E
QVRBX0JZVEVTKHN0LT5kYXRhX3JhdGUpOworCSAgICAgIGNoYW5uZWwtPmNoYW5uZWwgKiBBRFMx
MzFFMDhfTlVNX0RBVEFfQllURVMoc3QtPmRhdGFfcmF0ZSk7CiAKIAludW1fYml0cyA9IEFEUzEz
MUUwOF9OVU1fREFUQV9CSVRTKHN0LT5kYXRhX3JhdGUpOwotCSp2YWx1ZSA9IHNpZ25fZXh0ZW5k
MzIoZ2V0X3VuYWxpZ25lZF9iZTMyKHNyYykgPj4gKDMyIC0gbnVtX2JpdHMpLCBudW1fYml0cyAt
IDEpOworCSp2YWx1ZSA9IHNpZ25fZXh0ZW5kMzIoZ2V0X3VuYWxpZ25lZF9iZTMyKHNyYykgPj4g
KDMyIC0gbnVtX2JpdHMpLAorCQkJICAgICAgIG51bV9iaXRzIC0gMSk7CiAKIAlyZXR1cm4gMDsK
IH0KIAogc3RhdGljIGludCBhZHMxMzFlMDhfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldiwKLQlzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbm5lbCwgaW50ICp2YWx1ZSwK
LQlpbnQgKnZhbHVlMiwgbG9uZyBtYXNrKQorCQkJICAgICAgc3RydWN0IGlpb19jaGFuX3NwZWMg
Y29uc3QgKmNoYW5uZWwsIGludCAqdmFsdWUsCisJCQkgICAgICBpbnQgKnZhbHVlMiwgbG9uZyBt
YXNrKQogewogCXN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2
KTsKIAlpbnQgcmV0OwogCiAJc3dpdGNoIChtYXNrKSB7CiAJY2FzZSBJSU9fQ0hBTl9JTkZPX1JB
VzoKLQkJaWYgKCFpaW9fZGV2aWNlX2NsYWltX2RpcmVjdChpbmRpb19kZXYpKQotCQkJcmV0dXJu
IC1FQlVTWTsKKwkJcmV0ID0gaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9kZShpbmRpb19kZXYp
OworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKIAogCQlyZXQgPSBhZHMxMzFlMDhfcmVhZF9k
aXJlY3QoaW5kaW9fZGV2LCBjaGFubmVsLCB2YWx1ZSk7Ci0JCWlpb19kZXZpY2VfcmVsZWFzZV9k
aXJlY3QoaW5kaW9fZGV2KTsKKwkJaWlvX2RldmljZV9yZWxlYXNlX2RpcmVjdF9tb2RlKGluZGlv
X2Rldik7CiAJCWlmIChyZXQpCiAJCQlyZXR1cm4gcmV0OwogCkBAIC01NDIsMTkgKzYyMCwyMCBA
QCBzdGF0aWMgaW50IGFkczEzMWUwOF9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
LAogfQogCiBzdGF0aWMgaW50IGFkczEzMWUwOF93cml0ZV9yYXcoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldiwKLQlzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbm5lbCwgaW50IHZhbHVl
LAotCWludCB2YWx1ZTIsIGxvbmcgbWFzaykKKwkJCSAgICAgICBzdHJ1Y3QgaWlvX2NoYW5fc3Bl
YyBjb25zdCAqY2hhbm5lbCwgaW50IHZhbHVlLAorCQkJICAgICAgIGludCB2YWx1ZTIsIGxvbmcg
bWFzaykKIHsKIAlzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rl
dik7CiAJaW50IHJldDsKIAogCXN3aXRjaCAobWFzaykgewogCWNhc2UgSUlPX0NIQU5fSU5GT19T
QU1QX0ZSRVE6Ci0JCWlmICghaWlvX2RldmljZV9jbGFpbV9kaXJlY3QoaW5kaW9fZGV2KSkKLQkJ
CXJldHVybiAtRUJVU1k7CisJCXJldCA9IGlpb19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUoaW5k
aW9fZGV2KTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CiAKIAkJcmV0ID0gYWRzMTMxZTA4
X3NldF9kYXRhX3JhdGUoc3QsIHZhbHVlKTsKLQkJaWlvX2RldmljZV9yZWxlYXNlX2RpcmVjdChp
bmRpb19kZXYpOworCQlpaW9fZGV2aWNlX3JlbGVhc2VfZGlyZWN0X21vZGUoaW5kaW9fZGV2KTsK
IAkJcmV0dXJuIHJldDsKIAogCWRlZmF1bHQ6CkBAIC01NjUsOCArNjQ0LDcgQEAgc3RhdGljIGlu
dCBhZHMxMzFlMDhfd3JpdGVfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsCiBzdGF0aWMg
SUlPX0NPTlNUX0FUVFJfU0FNUF9GUkVRX0FWQUlMKCIxIDIgNCA4IDE2IDMyIDY0Iik7CiAKIHN0
YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICphZHMxMzFlMDhfYXR0cmlidXRlc1tdID0gewotCSZpaW9f
Y29uc3RfYXR0cl9zYW1wbGluZ19mcmVxdWVuY3lfYXZhaWxhYmxlLmRldl9hdHRyLmF0dHIsCi0J
TlVMTAorCSZpaW9fY29uc3RfYXR0cl9zYW1wbGluZ19mcmVxdWVuY3lfYXZhaWxhYmxlLmRldl9h
dHRyLmF0dHIsIE5VTEwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3Vw
IGFkczEzMWUwOF9hdHRyaWJ1dGVfZ3JvdXAgPSB7CkBAIC01NzQsMTcgKzY1MiwyOSBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBhZHMxMzFlMDhfYXR0cmlidXRlX2dyb3Vw
ID0gewogfTsKIAogc3RhdGljIGludCBhZHMxMzFlMDhfZGVidWdmc19yZWdfYWNjZXNzKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYsCi0JdW5zaWduZWQgaW50IHJlZywgdW5zaWduZWQgaW50IHdy
aXRldmFsLCB1bnNpZ25lZCBpbnQgKnJlYWR2YWwpCisJCQkJCXVuc2lnbmVkIGludCByZWcsIHVu
c2lnbmVkIGludCB3cml0ZXZhbCwKKwkJCQkJdW5zaWduZWQgaW50ICpyZWFkdmFsKQogewogCXN0
cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsKKwlpbnQgcmV0
OwogCi0JaWYgKHJlYWR2YWwpIHsKLQkJaW50IHJldCA9IGFkczEzMWUwOF9yZWFkX3JlZyhzdCwg
cmVnKTsKLQkJKnJlYWR2YWwgPSByZXQ7CisJcmV0ID0gaWlvX2RldmljZV9jbGFpbV9kaXJlY3Rf
bW9kZShpbmRpb19kZXYpOworCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CisKKwlpZiAocmVhZHZh
bCkgeworCQl1OCByZWdfdmFsdWU7CisKKwkJcmV0ID0gYWRzMTMxZTA4X3JlYWRfcmVnKHN0LCBy
ZWcsICZyZWdfdmFsdWUpOworCQkqcmVhZHZhbCA9IHJlZ192YWx1ZTsKKwkJZ290byBvdXQ7CiAJ
fQogCi0JcmV0dXJuIGFkczEzMWUwOF93cml0ZV9yZWcoc3QsIHJlZywgd3JpdGV2YWwpOworCXJl
dCA9IGFkczEzMWUwOF93cml0ZV9yZWcoc3QsIHJlZywgd3JpdGV2YWwpOworCitvdXQ6CisJaWlv
X2RldmljZV9yZWxlYXNlX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7CisJcmV0dXJuIHJldDsKIH0K
IAogc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9faW5mbyBhZHMxMzFlMDhfaWlvX2luZm8gPSB7CkBA
IC01OTQsMTggKzY4NCw1MiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19pbmZvIGFkczEzMWUw
OF9paW9faW5mbyA9IHsKIAkuZGVidWdmc19yZWdfYWNjZXNzID0gJmFkczEzMWUwOF9kZWJ1Z2Zz
X3JlZ19hY2Nlc3MsCiB9OwogCi1zdGF0aWMgaW50IGFkczEzMWUwOF9zZXRfdHJpZ2dlcl9zdGF0
ZShzdHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcsIGJvb2wgc3RhdGUpCitzdGF0aWMgaW50IGFkczEz
MWUwOF9idWZmZXJfcHJlZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpCiB7Ci0Jc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGlpb190cmlnZ2VyX2dldF9kcnZkYXRhKHRyaWcpOwog
CXN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsKLQl1OCBj
bWQgPSBzdGF0ZSA/IEFEUzEzMUUwOF9DTURfU1RBUlQgOiBBRFMxMzFFMDhfQ01EX1NUT1A7CisJ
aW50IHJldDsKKworCW1lbXNldCgmc3QtPnhmZXIsIDAsIHNpemVvZihzdC0+eGZlcikpOworCXN0
LT54ZmVyLnJ4X2J1ZiA9IHN0LT5yeF9idWY7CisJc3QtPnhmZXIubGVuID0gc3QtPnJlYWRiYWNr
X2xlbjsKKwlzdC0+eGZlci5jc19jaGFuZ2UgPSAwOworCXNwaV9tZXNzYWdlX2luaXQoJnN0LT5t
c2cpOworCXNwaV9tZXNzYWdlX2FkZF90YWlsKCZzdC0+eGZlciwgJnN0LT5tc2cpOworCisJcmV0
ID0gYWRzMTMxZTA4X2V4ZWNfY21kKHN0LCBBRFMxMzFFMDhfQ01EX1JEQVRBQywKKwkJCQkgc3Qt
PnNkZWNvZGVfZGVsYXlfdXMpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlyZXQgPSBh
ZHMxMzFlMDhfZXhlY19jbWQoc3QsIEFEUzEzMUUwOF9DTURfU1RBUlQsIHN0LT5zZGVjb2RlX2Rl
bGF5X3VzKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJc3QtPnJkYXRhY19lbmFibGVk
ID0gdHJ1ZTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBhZHMxMzFlMDhfYnVmZmVyX3Bv
c3RkaXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpCit7CisJc3RydWN0IGFkczEzMWUw
OF9zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOworCWludCByZXQ7CisKKwlyZXQgPSBh
ZHMxMzFlMDhfc3RvcF9yZWFkX2RhdGFfY29udGludW91cyhzdCk7CisJaWYgKHJldCkKKwkJcmV0
dXJuIHJldDsKKworCXJldCA9IGFkczEzMWUwOF9leGVjX2NtZChzdCwgQURTMTMxRTA4X0NNRF9T
VE9QLCBzdC0+c2RlY29kZV9kZWxheV91cyk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwor
CXN0LT5yZGF0YWNfZW5hYmxlZCA9IGZhbHNlOwogCi0JcmV0dXJuIGFkczEzMWUwOF9leGVjX2Nt
ZChzdCwgY21kKTsKKwlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fdHJp
Z2dlcl9vcHMgYWRzMTMxZTA4X3RyaWdnZXJfb3BzID0gewotCS5zZXRfdHJpZ2dlcl9zdGF0ZSA9
ICZhZHMxMzFlMDhfc2V0X3RyaWdnZXJfc3RhdGUsCi0JLnZhbGlkYXRlX2RldmljZSA9ICZpaW9f
dHJpZ2dlcl92YWxpZGF0ZV9vd25fZGV2aWNlLAorc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVm
ZmVyX3NldHVwX29wcyBhZHMxMzFlMDhfYnVmZmVyX29wcyA9IHsKKwkucHJlZW5hYmxlID0gYWRz
MTMxZTA4X2J1ZmZlcl9wcmVlbmFibGUsCisJLnBvc3RkaXNhYmxlID0gYWRzMTMxZTA4X2J1ZmZl
cl9wb3N0ZGlzYWJsZQogfTsKIAogc3RhdGljIGlycXJldHVybl90IGFkczEzMWUwOF90cmlnZ2Vy
X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqcHJpdmF0ZSkKQEAgLTYxNSw4ICs3MzksNiBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgYWRzMTMxZTA4X3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpw
cml2YXRlKQogCXN0cnVjdCBhZHMxMzFlMDhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2
KTsKIAl1bnNpZ25lZCBpbnQgY2huLCBpID0gMDsKIAl1OCAqc3JjLCAqZGVzdDsKLQlpbnQgcmV0
OwotCiAJLyoKIAkgKiBUaGUgbnVtYmVyIG9mIGRhdGEgYml0cyBwZXIgY2hhbm5lbCBkZXBlbmRz
IG9uIHRoZSBkYXRhIHJhdGUuCiAJICogRm9yIDMyIGFuZCA2NCBrc3BzIGRhdGEgcmF0ZXMsIG51
bWJlciBvZiBkYXRhIGJpdHMgcGVyIGNoYW5uZWwKQEAgLTYyNSwxOSArNzQ3LDIyIEBAIHN0YXRp
YyBpcnFyZXR1cm5fdCBhZHMxMzFlMDhfdHJpZ2dlcl9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnBy
aXZhdGUpCiAJICogMTYgYml0cyBvZiBkYXRhIGludG8gdGhlIGJ1ZmZlci4KIAkgKi8KIAl1bnNp
Z25lZCBpbnQgbnVtX2J5dGVzID0gQURTMTMxRTA4X05VTV9EQVRBX0JZVEVTKHN0LT5kYXRhX3Jh
dGUpOwotCXU4IHR3ZWVrX29mZnNldCA9IG51bV9ieXRlcyA9PSAyID8gMSA6IDA7CisJYm9vbCB0
d2Vla19vZmZzZXQgPSAobnVtX2J5dGVzID09IDIpOwogCi0JaWYgKGlpb190cmlnZ2VyX3VzaW5n
X293bihpbmRpb19kZXYpKQotCQlyZXQgPSBhZHMxMzFlMDhfcmVhZF9kYXRhKHN0LCBzdC0+cmVh
ZGJhY2tfbGVuKTsKLQllbHNlCi0JCXJldCA9IGFkczEzMWUwOF9wb29sX2RhdGEoc3QpOworCWlm
ICghc3QtPnJkYXRhY19lbmFibGVkKQorCQlnb3RvIG91dDsKIAotCWlmIChyZXQpCisJaWYgKHNw
aV9zeW5jKHN0LT5zcGksICZzdC0+bXNnKSkgeworCQlkZXZfd2Fybigmc3QtPnNwaS0+ZGV2LCAi
U1BJIHJlYWQgaW4gdGhyZWFkIGZhaWxlZFxuIik7CisJCWdvdG8gb3V0OworCX0KKworCWlmIChh
ZHMxMzFlMDhfY2hlY2tfc3RhdHVzKHN0KSkKIAkJZ290byBvdXQ7CiAKIAlpaW9fZm9yX2VhY2hf
YWN0aXZlX2NoYW5uZWwoaW5kaW9fZGV2LCBjaG4pIHsKIAkJc3JjID0gc3QtPnJ4X2J1ZiArIEFE
UzEzMUUwOF9OVU1fU1RBVFVTX0JZVEVTICsgY2huICogbnVtX2J5dGVzOwotCQlkZXN0ID0gc3Qt
PnRtcF9idWYuZGF0YSArIGkgKiBBRFMxMzFFMDhfTlVNX1NUT1JBR0VfQllURVM7CisJCWRlc3Qg
PSBzdC0+ZGF0YSArIGkgKiBBRFMxMzFFMDhfTlVNX1NUT1JBR0VfQllURVM7CiAKIAkJLyoKIAkJ
ICogVHdlZWsgb2Zmc2V0IGlzIDA6CkBAIC02NjQsMTIgKzc4OSwxMSBAQCBzdGF0aWMgaXJxcmV0
dXJuX3QgYWRzMTMxZTA4X3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpwcml2YXRlKQog
CQlpKys7CiAJfQogCi0JaWlvX3B1c2hfdG9fYnVmZmVyc193aXRoX3RzKGluZGlvX2RldiwgJnN0
LT50bXBfYnVmLCBzaXplb2Yoc3QtPnRtcF9idWYpLAotCQkJCSAgICBpaW9fZ2V0X3RpbWVfbnMo
aW5kaW9fZGV2KSk7CisJaWlvX3B1c2hfdG9fYnVmZmVyc193aXRoX3RpbWVzdGFtcChpbmRpb19k
ZXYsIHN0LT5kYXRhLAorCQkJCQkgICBpaW9fZ2V0X3RpbWVfbnMoaW5kaW9fZGV2KSk7CiAKIG91
dDoKIAlpaW9fdHJpZ2dlcl9ub3RpZnlfZG9uZShpbmRpb19kZXYtPnRyaWcpOwotCiAJcmV0dXJu
IElSUV9IQU5ETEVEOwogfQogCkBAIC02NzgsOCArODAyLDkgQEAgc3RhdGljIGlycXJldHVybl90
IGFkczEzMWUwOF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqcHJpdmF0ZSkKIAlzdHJ1Y3QgaWlv
X2RldiAqaW5kaW9fZGV2ID0gcHJpdmF0ZTsKIAlzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRlICpzdCA9
IGlpb19wcml2KGluZGlvX2Rldik7CiAKLQlpZiAoaWlvX2J1ZmZlcl9lbmFibGVkKGluZGlvX2Rl
dikgJiYgaWlvX3RyaWdnZXJfdXNpbmdfb3duKGluZGlvX2RldikpCisJaWYgKHN0LT5yZGF0YWNf
ZW5hYmxlZCkKIAkJaWlvX3RyaWdnZXJfcG9sbChzdC0+dHJpZyk7CisKIAllbHNlCiAJCWNvbXBs
ZXRlKCZzdC0+Y29tcGxldGlvbik7CiAKQEAgLTcxOCwxNyArODQzLDE4IEBAIHN0YXRpYyBpbnQg
YWRzMTMxZTA4X2FsbG9jX2NoYW5uZWxzKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpCiAJfQog
CiAJaWYgKG51bV9jaGFubmVscyA+IHN0LT5pbmZvLT5tYXhfY2hhbm5lbHMpIHsKLQkJZGV2X2Vy
cigmc3QtPnNwaS0+ZGV2LCAibnVtIG9mIGNoYW5uZWwgY2hpbGRyZW4gb3V0IG9mIHJhbmdlXG4i
KTsKKwkJZGV2X2Vycigmc3QtPnNwaS0+ZGV2LAorCQkJIm51bSBvZiBjaGFubmVsIGNoaWxkcmVu
IG91dCBvZiByYW5nZVxuIik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAotCWNoYW5uZWxzID0g
ZGV2bV9rY2FsbG9jKCZzdC0+c3BpLT5kZXYsIG51bV9jaGFubmVscywKLQkJc2l6ZW9mKCpjaGFu
bmVscyksIEdGUF9LRVJORUwpOworCWNoYW5uZWxzID0gZGV2bV9rY2FsbG9jKCZzdC0+c3BpLT5k
ZXYsIG51bV9jaGFubmVscywgc2l6ZW9mKCpjaGFubmVscyksCisJCQkJR0ZQX0tFUk5FTCk7CiAJ
aWYgKCFjaGFubmVscykKIAkJcmV0dXJuIC1FTk9NRU07CiAKIAljaGFubmVsX2NvbmZpZyA9IGRl
dm1fa2NhbGxvYygmc3QtPnNwaS0+ZGV2LCBudW1fY2hhbm5lbHMsCi0JCXNpemVvZigqY2hhbm5l
bF9jb25maWcpLCBHRlBfS0VSTkVMKTsKKwkJCQkgICAgICBzaXplb2YoKmNoYW5uZWxfY29uZmln
KSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFjaGFubmVsX2NvbmZpZykKIAkJcmV0dXJuIC1FTk9NRU07
CiAKQEAgLTc2NSw4ICs4OTEsOSBAQCBzdGF0aWMgaW50IGFkczEzMWUwOF9hbGxvY19jaGFubmVs
cyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQogCQljaGFubmVsc1tpXS5jaGFubmVsID0gY2hh
bm5lbDsKIAkJY2hhbm5lbHNbaV0uYWRkcmVzcyA9IGk7CiAJCWNoYW5uZWxzW2ldLmluZm9fbWFz
a19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykgfAotCQkJCQkJQklUKElJT19DSEFO
X0lORk9fU0NBTEUpOwotCQljaGFubmVsc1tpXS5pbmZvX21hc2tfc2hhcmVkX2J5X3R5cGUgPSBC
SVQoSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEpOworCQkJCQkJIEJJVChJSU9fQ0hBTl9JTkZPX1ND
QUxFKTsKKwkJY2hhbm5lbHNbaV0uaW5mb19tYXNrX3NoYXJlZF9ieV90eXBlID0KKwkJCUJJVChJ
SU9fQ0hBTl9JTkZPX1NBTVBfRlJFUSk7CiAJCWNoYW5uZWxzW2ldLnNjYW5faW5kZXggPSBjaGFu
bmVsOwogCQljaGFubmVsc1tpXS5zY2FuX3R5cGUuc2lnbiA9ICdzJzsKIAkJY2hhbm5lbHNbaV0u
c2Nhbl90eXBlLnJlYWxiaXRzID0gMjQ7CkBAIC03ODEsNyArOTA4LDYgQEAgc3RhdGljIGludCBh
ZHMxMzFlMDhfYWxsb2NfY2hhbm5lbHMoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikKIAlzdC0+
Y2hhbm5lbF9jb25maWcgPSBjaGFubmVsX2NvbmZpZzsKIAogCXJldHVybiAwOwotCiB9CiAKIHN0
YXRpYyB2b2lkIGFkczEzMWUwOF9yZWd1bGF0b3JfZGlzYWJsZSh2b2lkICpkYXRhKQpAQCAtODE1
LDYgKzk0MSw3IEBAIHN0YXRpYyBpbnQgYWRzMTMxZTA4X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNl
ICpzcGkpCiAJc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOwogCXN0LT5pbmZvID0gaW5mbzsKIAlz
dC0+c3BpID0gc3BpOworCXN0LT5yZGF0YWNfZW5hYmxlZCA9IGZhbHNlOwogCiAJcmV0ID0gYWRz
MTMxZTA4X2FsbG9jX2NoYW5uZWxzKGluZGlvX2Rldik7CiAJaWYgKHJldCkKQEAgLTgyMiwxNSAr
OTQ5LDE0IEBAIHN0YXRpYyBpbnQgYWRzMTMxZTA4X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpz
cGkpCiAKIAlpbmRpb19kZXYtPm5hbWUgPSBzdC0+aW5mby0+bmFtZTsKIAlpbmRpb19kZXYtPmlu
Zm8gPSAmYWRzMTMxZTA4X2lpb19pbmZvOwotCWluZGlvX2Rldi0+bW9kZXMgPSBJTkRJT19ESVJF
Q1RfTU9ERTsKKwlpbmRpb19kZXYtPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREUgfCBJTkRJT19C
VUZGRVJfVFJJR0dFUkVEOwogCiAJaW5pdF9jb21wbGV0aW9uKCZzdC0+Y29tcGxldGlvbik7CiAK
IAlpZiAoc3BpLT5pcnEpIHsKLQkJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmc3BpLT5kZXYsIHNw
aS0+aXJxLAotCQkJYWRzMTMxZTA4X2ludGVycnVwdCwKLQkJCUlSUUZfVFJJR0dFUl9GQUxMSU5H
IHwgSVJRRl9PTkVTSE9ULAotCQkJc3BpLT5kZXYuZHJpdmVyLT5uYW1lLCBpbmRpb19kZXYpOwor
CQlyZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZzcGktPmRldiwgc3BpLT5pcnEsIGFkczEzMWUwOF9p
bnRlcnJ1cHQsCisJCQkJICAgICAgIElSUUZfVFJJR0dFUl9GQUxMSU5HIHwgSVJRRl9PTkVTSE9U
LAorCQkJCSAgICAgICBkZXZfbmFtZSgmc3BpLT5kZXYpLCBpbmRpb19kZXYpOwogCQlpZiAocmV0
KQogCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnNwaS0+ZGV2LCByZXQsCiAJCQkJCSAgICAgInJl
cXVlc3QgaXJxIGZhaWxlZFxuIik7CkBAIC04NDAsMTMgKzk2NiwxMyBAQCBzdGF0aWMgaW50IGFk
czEzMWUwOF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQogCX0KIAogCXN0LT50cmlnID0g
ZGV2bV9paW9fdHJpZ2dlcl9hbGxvYygmc3BpLT5kZXYsICIlcy1kZXYlZCIsCi0JCWluZGlvX2Rl
di0+bmFtZSwgaWlvX2RldmljZV9pZChpbmRpb19kZXYpKTsKKwkJCQkJICBpbmRpb19kZXYtPm5h
bWUsCisJCQkJCSAgaWlvX2RldmljZV9pZChpbmRpb19kZXYpKTsKIAlpZiAoIXN0LT50cmlnKSB7
CiAJCWRldl9lcnIoJnNwaS0+ZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIElJTyB0cmlnZ2VyXG4i
KTsKIAkJcmV0dXJuIC1FTk9NRU07CiAJfQogCi0Jc3QtPnRyaWctPm9wcyA9ICZhZHMxMzFlMDhf
dHJpZ2dlcl9vcHM7CiAJc3QtPnRyaWctPmRldi5wYXJlbnQgPSAmc3BpLT5kZXY7CiAJaWlvX3Ry
aWdnZXJfc2V0X2RydmRhdGEoc3QtPnRyaWcsIGluZGlvX2Rldik7CiAJcmV0ID0gZGV2bV9paW9f
dHJpZ2dlcl9yZWdpc3Rlcigmc3BpLT5kZXYsIHN0LT50cmlnKTsKQEAgLTg1Nyw4ICs5ODMsOSBA
QCBzdGF0aWMgaW50IGFkczEzMWUwOF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQogCiAJ
aW5kaW9fZGV2LT50cmlnID0gaWlvX3RyaWdnZXJfZ2V0KHN0LT50cmlnKTsKIAotCXJldCA9IGRl
dm1faWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXAoJnNwaS0+ZGV2LCBpbmRpb19kZXYsCi0JCU5V
TEwsICZhZHMxMzFlMDhfdHJpZ2dlcl9oYW5kbGVyLCBOVUxMKTsKKwlyZXQgPSBkZXZtX2lpb190
cmlnZ2VyZWRfYnVmZmVyX3NldHVwKCZzcGktPmRldiwgaW5kaW9fZGV2LCBOVUxMLAorCQkJCQkg
ICAgICAmYWRzMTMxZTA4X3RyaWdnZXJfaGFuZGxlciwKKwkJCQkJICAgICAgJmFkczEzMWUwOF9i
dWZmZXJfb3BzKTsKIAlpZiAocmV0KSB7CiAJCWRldl9lcnIoJnNwaS0+ZGV2LCAiZmFpbGVkIHRv
IHNldHVwIElJTyBidWZmZXJcbiIpOwogCQlyZXR1cm4gcmV0OwpAQCAtODczLDcgKzEwMDAsOCBA
QCBzdGF0aWMgaW50IGFkczEzMWUwOF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQogCQkJ
cmV0dXJuIHJldDsKIAkJfQogCi0JCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgmc3Bp
LT5kZXYsIGFkczEzMWUwOF9yZWd1bGF0b3JfZGlzYWJsZSwgc3QpOworCQlyZXQgPSBkZXZtX2Fk
ZF9hY3Rpb25fb3JfcmVzZXQoJnNwaS0+ZGV2LAorCQkJCQkgICAgICAgYWRzMTMxZTA4X3JlZ3Vs
YXRvcl9kaXNhYmxlLCBzdCk7CiAJCWlmIChyZXQpCiAJCQlyZXR1cm4gcmV0OwogCX0gZWxzZSB7
CkBAIC04OTEsNyArMTAxOSw3IEBAIHN0YXRpYyBpbnQgYWRzMTMxZTA4X3Byb2JlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpCiAJYWRjX2Nsa19oeiA9IGNsa19nZXRfcmF0ZShzdC0+YWRjX2Nsayk7
CiAJaWYgKCFhZGNfY2xrX2h6KSB7CiAJCWRldl9lcnIoJnNwaS0+ZGV2LCAiZmFpbGVkIHRvIGdl
dCB0aGUgQURDIGNsb2NrIHJhdGVcbiIpOwotCQlyZXR1cm4gIC1FSU5WQUw7CisJCXJldHVybiAt
RUlOVkFMOwogCX0KIAogCWFkY19jbGtfbnMgPSBOU0VDX1BFUl9TRUMgLyBhZGNfY2xrX2h6OwpA
QCAtOTEwLDEzICsxMDM4LDE5IEBAIHN0YXRpYyBpbnQgYWRzMTMxZTA4X3Byb2JlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpCiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFk
czEzMWUwOF9vZl9tYXRjaFtdID0gewotCXsgLmNvbXBhdGlibGUgPSAidGksYWRzMTMxZTA0IiwK
LQkgIC5kYXRhID0gJmFkczEzMWUwOF9pbmZvX3RibFthZHMxMzFlMDRdLCB9LAotCXsgLmNvbXBh
dGlibGUgPSAidGksYWRzMTMxZTA2IiwKLQkgIC5kYXRhID0gJmFkczEzMWUwOF9pbmZvX3RibFth
ZHMxMzFlMDZdLCB9LAotCXsgLmNvbXBhdGlibGUgPSAidGksYWRzMTMxZTA4IiwKLQkgIC5kYXRh
ID0gJmFkczEzMWUwOF9pbmZvX3RibFthZHMxMzFlMDhdLCB9LAotCXsgfQorCXsKKwkJLmNvbXBh
dGlibGUgPSAidGksYWRzMTMxZTA0IiwKKwkJLmRhdGEgPSAmYWRzMTMxZTA4X2luZm9fdGJsW2Fk
czEzMWUwNF0sCisJfSwKKwl7CisJCS5jb21wYXRpYmxlID0gInRpLGFkczEzMWUwNiIsCisJCS5k
YXRhID0gJmFkczEzMWUwOF9pbmZvX3RibFthZHMxMzFlMDZdLAorCX0sCisJeworCQkuY29tcGF0
aWJsZSA9ICJ0aSxhZHMxMzFlMDgiLAorCQkuZGF0YSA9ICZhZHMxMzFlMDhfaW5mb190YmxbYWRz
MTMxZTA4XSwKKwl9LAorCXt9CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWRzMTMxZTA4
X29mX21hdGNoKTsKIApAQCAtOTI0LDcgKzEwNTgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNw
aV9kZXZpY2VfaWQgYWRzMTMxZTA4X2lkc1tdID0gewogCXsgImFkczEzMWUwNCIsIChrZXJuZWxf
dWxvbmdfdCkmYWRzMTMxZTA4X2luZm9fdGJsW2FkczEzMWUwNF0gfSwKIAl7ICJhZHMxMzFlMDYi
LCAoa2VybmVsX3Vsb25nX3QpJmFkczEzMWUwOF9pbmZvX3RibFthZHMxMzFlMDZdIH0sCiAJeyAi
YWRzMTMxZTA4IiwgKGtlcm5lbF91bG9uZ190KSZhZHMxMzFlMDhfaW5mb190YmxbYWRzMTMxZTA4
XSB9LAotCXsgfQorCXt9CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShzcGksIGFkczEzMWUwOF9p
ZHMpOwogCkBAIC05MzksNSArMTA3Myw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc3BpX2RyaXZlciBhZHMx
MzFlMDhfZHJpdmVyID0gewogbW9kdWxlX3NwaV9kcml2ZXIoYWRzMTMxZTA4X2RyaXZlcik7CiAK
IE1PRFVMRV9BVVRIT1IoIlRvbWlzbGF2IERlbmlzIDx0b21pc2xhdi5kZW5pc0BhdmwuY29tPiIp
OworTU9EVUxFX0FVVEhPUigiVmlrdG9yIEthcmFtYW5pcyA8dmlrdG9yLmthcmFtYW5pc0BvdXRs
b29rLmNvbT4iKTsKIE1PRFVMRV9ERVNDUklQVElPTigiRHJpdmVyIGZvciBBRFMxMzFFMHggQURD
IGZhbWlseSIpOwogTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwotLSAKMi40My4wCgo=

--_004_PA1PR08MB11670AA593D765D9F96A0053C8E89APA1PR08MB11670eu_--
