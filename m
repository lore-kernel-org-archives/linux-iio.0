Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792712494;
	b=gJSRn3CtiPdt10WWWb3kIKEABfQpjEvTCdat9cLo9hGiZJx9NYi86cYfXN0QpHcl2FL9
	 iUdd1PGOgdqBhoQb1zpdmTDtXo54mD80iY5qMeJV1189yA9ZNe+XckHzDhKJcsga81u+1
	 x8N+lUzbAnC6lwo0dhU9FVHK/7GtSWU2ENENH6EXkknsga+Nx+LJrfdPULcvCngRXdlqy
	 j9LH3G3WokONgFOvqiliKM9FSxkAZGgKvkzu1qOHk7iHKKgQwaBrkCajYuQZAnXvqXldE
	 ++qykI9yvpDY3a7upG0qFYF79UATtXS/m/pD/iU9tI6T1b2RNn+slHxpgKrDCCpWJwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712494;
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
	bh=9OrVBx8z4M9GKQu9/jBErHJXcPktJnNF6MEDSNMZv8Y=;
	b=tjBe77gezN+xxEzrBzPkJHbY1M86qDRTyQIaT6ZvjtExzbkHX4srVZowCqVA9r13sOu+
	 KACF6f4OWUNhFhaM96+nvzZoepvuCE9kxEcjKef/nk97fk4TdEPgEGUJKqSN2357RiAGb
	 ZTs9K/zdK74oR+Y5WdXBy85jet3IV92NrIciWnF35abmhX+itisYER+BexLvcEfRbT/iB
	 L3ksqVQ2ZKWZDYvI/VBrnpEqnYn8VjEhHv2chelzypgYXph+57riXwp/qvN5orDYWkGHV
	 fk2lKLqoGBY3QJFcHGSolvYQiOZW8x6AcgYRs66Xeap1REIcxeP0dei4a3MXTDJ7Yew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="aF/3zU4q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.8
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012008.outbound.protection.outlook.com [52.103.23.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615B606A32A;
	Thu, 22 Oct 2026 23:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E615B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=aF/3zU4q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9SgVRSEg3lXTACNuuL732b6MEA1XfeX/lLFPI40GqYDycaEU2UslnUVItRG+F6r13G7SF5zCjSshSNHJROnf+2djJGzEjHBSQN5GaRLc6VIb8ZOfsLqRGTyvZfc+o7KAZsvMpAoA801VeigFEJJ7wWVVNkYuGqu4NOIAcbcQV4g081JYSRKeAoWEOTl0ssswkgx8wDdvDXp+HJHnnwswKZySdwphcW0uP0vZ9jEuoDksk1jPu6WGJxs761YnIHHWnTAYAzMOw4q+pWFmzJQvl8I0ZTVOXt4ooTqniUIdgfESg2AUEtSSf4qjq+ldWckjK6suykLAt4mCZgwacFUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OrVBx8z4M9GKQu9/jBErHJXcPktJnNF6MEDSNMZv8Y=;
 b=Xvb4Ff2xvwYV+LsXp4bm/9U4uxmLQAr85S7lF9sPcUruIaFOUhJUw1XjIt2QJ5BFdyCp/XeEbuGnc7Tn+bXdR3W75UW3GKnwa+4764wajO90+N5t0UzMDsvCNM5/aYnww8Dp4sg83m3N84nX7f6BYz868CcfbIHAQGr+W9N48oGb0ZiGtvpQOGpr6Ie7DWjS+WKBxXmfK2R0BtPnN+iuTkIB516gKj7vCjdVz0JjpwMz5XA9SaZoeaZlxb/XOMs6t8Pbt3VokeSjuDo2RiswSeTalY28AAYN0hmyQmVXwByw8rCiSSiYlzUpYbCi5yG+47LPvljTuQczK3+jWePV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OrVBx8z4M9GKQu9/jBErHJXcPktJnNF6MEDSNMZv8Y=;
 b=aF/3zU4quvk//gyhW6xoZF+8fFcn0Ykh/GotYlkVe3oxU68COAOk5Yox+PiDgwWi3T6Dwysj3+QwXGVjNkKlobM2ox2kgs/goAa0hqKOIdJ0zp1132+E7ZBr5to0WQwyY94NSNwCYOm2Sl+yqAiZm1TJ3T2gnJA+ACHtJyCqkWjpQA0tcnv+PWwj0u7Wt6retD2n8o6k1oqxOATYwfUYs/cJii99QMuJpNfM7QLI6UEBRxmAaezFz+xa98PaNLCKf/WZvsFkjjgBuF0ehJloKdltKz+UdAirmaGhGwUd7LkXxMbYid9S/mvKtsB81+Gh2YOmoxXgmiUla1Aw3hgguA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 23:41:31 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 23:41:31 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Thu, 22 Oct 2026 18:40:32 -0500
Message-ID:
 <SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261022234041.61995-4-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9463c440-7f4b-4b00-fc2f-08df30960012
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRFJgj3AbNzQ9zvdCHfDO/udo98bg3mrSQwsSmqNsISp5jomRQJK19INZDj94iw7uQ6I3pReT6CoFXHntXg4Z1iJXDlMtxLchmomHoyLp2kY2Z0mAVsR8U5Wdio0sTCdOH47URfBB6rOg54O4/R24wVja3kAZqFuFgCh0ZQyQLndWUK4XoqMBhPm2+z4GbV46HQGleUropGEnjPZ3dRwBkaKvQsu4i2BxhVCM0oxE/MRQfglCMRAikhYe+nzPpbdN7/hTkfmkjCCzjyXC959K2SwCO6NMDK31EK17dlLhSjdDvPogJE/ur+CvPTP5xgM2pi9LZsnc6+7fGFgR7wwqRKUGGBNKetn+1gtY1YDljKzURRurCu8ZXLfu0F9pAArxZIbCyF1Ar/uPjibKdgFI5+mSJofVCJLe9thRbxibzjXGT5B0ZJqsJms7qoQZnsj1zksK7zzwH/o5CHCT1V0LKFekTWIxJDbgt/NV/myaib/sK8EIYhIiX/GcCuQGGQ1G57O9W+rLc79qQ3DVJy8FPSuAjnEKXhXqf5UFYmgeUePSBchJX44kV4Qhv8ktz2RKPIapb9gGpvVo9jhZ3Mcolkcm0Va23gHbtNxx93a9+xh/w/HKmj/ywDBMPmbn66pk6FqFNGT187jFExP41rOI2rjJGvGVJp01t/cyS2kTRxpPujEvQtOavrpeFJbtx7DghdCpyH7DAYFmHaDK5jzXiW67yL5Ym6zY/AAvfzgHd5fw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|24021099003|22091999003|5072599009|23021999003|51005399006|24121999003|19110799012|12121999013|8060799015|260925184616899003|41001999006|25010399006|440099028|3412199025|10035399007|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J2zIYp8iNEm5fitRlAgrzUp9bOkwfD1KJh1oEypoEnxbrcmcAX5mAAHhFdfW?=
 =?us-ascii?Q?JLk6WA9QNZSHVcZ557VGD+8s3/QlcKlR1SowesFG4tBF/5tX5jDz3K6Hf30o?=
 =?us-ascii?Q?qtiNedm/RtzTTuSGrAZv88Vp2GR328CZe0Ki6Fa+mGrr6bWvRVQqQnJ7VhHo?=
 =?us-ascii?Q?0PGBlYytQgwRI8SHflp5i4IRUTeC/cXPjQ3gnLnOGztfDmadFAkjIYAfG6/L?=
 =?us-ascii?Q?3JVf8U1kvY8DQWI0VPBqc3BZUu7gEVjWQYfN3l6x/9O/XyQ0SJls4l+yQlGK?=
 =?us-ascii?Q?8/IR/gVsQkGvkw2RRL+JLNDvyukW91rQj1X+qRs/rBTkdroTYdbiZVl2mHfA?=
 =?us-ascii?Q?sAOuAwkMRQ0J2CTtHnsN7r/RVUPTYO76F3pIlBjqjauzz2l2BQ4C2PNBO4Gx?=
 =?us-ascii?Q?b7nXp4fhN0a1iN/vPlGP+tQkZW2fOaEmmewBgZpL1ZMuqNIlWqqCQmLfWPfI?=
 =?us-ascii?Q?YCumcXGd3O26kgcivR+XtpC8jfGZGEZDuXUgcKGjlKcl/FYntbTEj+S/4DrT?=
 =?us-ascii?Q?shdl4WcfOmOVHz/lOoEpZ1c7wmV2T+QJaido2pFY8CBRS1+EqCNn04Q9JZNY?=
 =?us-ascii?Q?ybTTXGeeHvviv1vLMUvtAjSLEVcxNiEXQi1A4uX5mNyDjPlpqfLBQ6Y357qH?=
 =?us-ascii?Q?OVKX0pbZxUPeUxwGfp6iMz8uYY65AEuGNC86/J0dO/vmlcx08yScUX4dcEp2?=
 =?us-ascii?Q?DiyQbOr854NH9PaGkOmpE+hd5RvR+26YXASYfBMgyL3q1PCk1uPXmyyp4FGI?=
 =?us-ascii?Q?wFPujV/wTQGkxfCBKPc+ggkd6idDfvvZOKbsv07AlqW3L1fLiOC8KrVYxi6l?=
 =?us-ascii?Q?aqigoIzMyDmZLUv+snx7lo6/pyT6DqVsjbpoMERSJT0VwPLfD2rRXXY00oFF?=
 =?us-ascii?Q?jmscGTRvjmoxXOfDucXFkzUPU/VJcGpMTaEXSTN0xynkfe2+o32C3lKA2+8x?=
 =?us-ascii?Q?Cf6XkNnR0Fc5gGmmL682mPjyhAJy3aFQJ8qucjb9VeqDjEOB9XRJAP6qNrFg?=
 =?us-ascii?Q?S72ckBwCJActp6ZI2wVJGhTH/DF5OpUfu6f8qnyqAnjj+XIvfhECkvLbccFe?=
 =?us-ascii?Q?aF9Gl3wwuowzaawUiqkfr4XdQVo6tDWCHoiRh69ZgW3c4cYMOoi8QFhGIxgV?=
 =?us-ascii?Q?axMzP8BPiMFq?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uxQJkA+YvzsJVbpz2ZTHYg763T4h4lpgAE6RZSr7rvQlsQbgLM7oJf19vQ6d?=
 =?us-ascii?Q?qYwLdiOP50kenUyBsaVvR1jYKBf0KrFsJfZoaAedImeqyOoO2RDvs9PTKnGe?=
 =?us-ascii?Q?3Uhk4EUSI1+BRF6uxMHp1QykHBtBErEX2ZFQjyipP8EEW9WyNKLHo9WVjGeo?=
 =?us-ascii?Q?hq3CqzExnDnqZgDc9igxygZrI44OGycLrx1VSnZVmeAdWla/JTQZBWvCEEi8?=
 =?us-ascii?Q?X9ravimosQPzioVveIFWTyUc8/tHzudNbK0fAEBPs+cYt8/Hwepi1VZ+qW1F?=
 =?us-ascii?Q?7FgNrZ1pSRwCnop0Xqt7VrpIHgM1p8snmUwWIQimZa7jVl2+GeLWJ21BSRGu?=
 =?us-ascii?Q?qzIxmfPGNKevroF77rYbqMp6sCuGY7Lwk+9Vp/XbClSIGKHzzgZetShp129+?=
 =?us-ascii?Q?kJ+Ejb49ydLE6OXvl43Amw2WtDwg9LzV7WDvxXSZXT3R8ubtE8LffC231eu1?=
 =?us-ascii?Q?88B9DkzAWre/N5jdR8iPq0wNfKrrBRvhayaio0i2ejS/qdKLYgnjYy5L3dUm?=
 =?us-ascii?Q?p2xE6qVRP768IvDu5NSJKvN1Glv2iL2zHTBwTvLlO8aQmR2jW647r557te6J?=
 =?us-ascii?Q?wnwNcTMhQ290GKWps6p/wroLjfTw0sL40vIIdXEeZdxPxsPMSvFqjnVTPQxY?=
 =?us-ascii?Q?1nqBIMtAg7d2DOU+gDK99PMrnijFSVOATmkFDaYt4g7X1eSZXQ+rtOit0CoC?=
 =?us-ascii?Q?akymiLgTA+FqAOYCKkCwb1QuvXqgfKQN7JIiF36VrGHvN6bAkIuC+IJsxgf8?=
 =?us-ascii?Q?Sb/MxtPruRh3AUC7AiW1wR/CxEotoPr+KS0jZzf97hElb/Xaqgra74fsB5yc?=
 =?us-ascii?Q?+MY1TsPZeLJLPVoM2aQ082ibpJlKwRULsJ5MooRljoDl44Ojoy8R0YEzSK33?=
 =?us-ascii?Q?U9jKTDltDv9dD5m7owwjZe8f7mYGkcsiF9GdqwXVOjFVcqqSPRhC8ROg47g2?=
 =?us-ascii?Q?HxYevzGabuZ1jEsaR/TdwUbVZGrUnvuwtt7khEye5Z2oTOHUUGXfRJ86h6K8?=
 =?us-ascii?Q?tAv7NCaDiFtIGiqTjGTqVkKKP2tLUZzsHv2J3U7WXmAOFtlhY3IUGxG+tO8a?=
 =?us-ascii?Q?j4yrGvrY2Fw9GtzSdm6aAEsCyCurEHFnx5rFkg42a+R9KBaHGDmFbeIAZBnh?=
 =?us-ascii?Q?nlzZJNK3n24b81XflLYYPC2C61EBw1imaYv0tEuKftAqILUaO6VrroPAxjMv?=
 =?us-ascii?Q?jcmUzAz+r0shhlpEKmXgVMexx5MwPan0PK2mz8JhDvDJvCYtQCf4QTXVmwDD?=
 =?us-ascii?Q?OpHPjb1TCIk3yTCuFUXEIynw1UmgQtXD3NflmxM+ukhYw3vShdJ5XaJgRjfh?=
 =?us-ascii?Q?98gEkYo4uKmsZ38l8DKKi9oBwP0euROxPraCSfOFch/wD2l7emj4zOwR19vy?=
 =?us-ascii?Q?KfpJLXxN4TFosibNDwsQljkBX7ElZXz5i8Bb2ikTAVKmCs84qw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9463c440-7f4b-4b00-fc2f-08df30960012
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 23:41:31.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

The FDC1004 is a high-precision 4-channel capacitive sensor that talks
over I2C. It can report the values of each of its 4 channels individually,
as well as the difference between any two of them.

This initial driver allows performing single reads and configuring
the sensor's various settings (sample frequency, calibration
gain/offset, etc.). It could be extended with support for triggered
buffers, repeated measurement mode, and/or power management.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/cdc/Kconfig   |  10 +
 drivers/iio/cdc/Makefile  |   1 +
 drivers/iio/cdc/fdc1004.c | 460 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 472 insertions(+)
 create mode 100644 drivers/iio/cdc/fdc1004.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 69c23ae21016..4d926c47ad8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27392,6 +27392,7 @@ TI FDC1004 DRIVER
 M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
+F:	drivers/iio/cdc/fdc1004.c
 
 TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
diff --git a/drivers/iio/cdc/Kconfig b/drivers/iio/cdc/Kconfig
index e0a5ce66a984..6b9ea2cd37bd 100644
--- a/drivers/iio/cdc/Kconfig
+++ b/drivers/iio/cdc/Kconfig
@@ -24,4 +24,14 @@ config AD7746
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7746.
 
+config FDC1004
+	tristate "Texas Instruments FDC1004 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the Texas Instruments FDC1004
+	  capacitive sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called fdc1004.
+
 endmenu
diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
index 41db756d8020..88253f33c5a7 100644
--- a/drivers/iio/cdc/Makefile
+++ b/drivers/iio/cdc/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_AD7150) += ad7150.o
 obj-$(CONFIG_AD7746) += ad7746.o
+obj-$(CONFIG_FDC1004) += fdc1004.o
diff --git a/drivers/iio/cdc/fdc1004.c b/drivers/iio/cdc/fdc1004.c
new file mode 100644
index 000000000000..852a3723e200
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments FDC1004 capacitive sensor driver
+ *
+ * Copyright (c) 2026 Victor Chernyakin <chernyakin.victor.j@outlook.com>
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/FDC1004
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iopoll.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define FDC1004_REG_MEASn_MSB(n) (2 * (n))
+#define FDC1004_REG_MEASn_LSB(n) (2 * (n) + 1)
+#define FDC1004_REG_CONF_MEASn(n) (0x08 + (n))
+#define FDC1004_REG_FDC_CONF 0x0C
+#define FDC1004_REG_OFFSET_CAL_CINn(n) (0x0D + (n))
+#define FDC1004_REG_GAIN_CAL_CINn(n) (0x11 + (n))
+
+#define FDC1004_CONF_MEAS_CHA_MASK GENMASK(15, 13)
+#define FDC1004_CONF_MEAS_CHB_MASK GENMASK(12, 10)
+#define FDC1004_CONF_MEAS_CHB_CAPDAC 0b100
+#define FDC1004_CONF_MEAS_CAPDAC_MASK GENMASK(9, 5)
+
+#define FDC1004_FDC_CONF_DONE_n_MASK(n) BIT(3 - (n))
+#define FDC1004_FDC_CONF_MEAS_n_MASK(n) BIT(7 - (n))
+#define FDC1004_FDC_CONF_RATE_MASK GENMASK(11, 10)
+#define FDC1004_FDC_CONF_RST_MASK BIT(15)
+
+static const int fdc1004_samp_freqs[] = { 100, 200, 400 };
+
+/*
+ * MEASn_{MSB,LSB}: 24 bits, signed. Format: IIO_VAL_DECIMAL64_YOCTO.
+ * 1 step = 1/(2^19) pF = 1/(1000 * 2^19) nF = 0.000000001907348632812500 nF.
+ */
+static const s64 fdc1004_scale = 1907348632812500;
+
+/*
+ * CAPDAC field: 5 bits, unsigned. Format: IIO_VAL_INT.
+ * 1 step = 3.125 pF = 100/(2^5) pF.
+ */
+static const int fdc1004_offset[] = {
+	0x00 * (100 << (19 - 5)), /* min */
+	0x01 * (100 << (19 - 5)), /* step */
+	0x1F * (100 << (19 - 5)), /* max */
+};
+
+/*
+ * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
+ */
+static const s64 fdc1004_calibbias[] = {
+	-0x8000 * 488281250UL, /* min */
+	+0x0001 * 488281250UL, /* step */
+	+0x7FFF * 488281250UL, /* max */
+};
+
+/*
+ * GAIN_CAL_CINn: 16 bits, unsigned. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^14) pF/pF = 0.000061035156250 pF/pF.
+ */
+static const s64 fdc1004_calibscale[] = {
+	0x0000 * 61035156250UL, /* min */
+	0x0001 * 61035156250UL, /* step */
+	0xFFFF * 61035156250UL, /* max */
+};
+
+struct fdc1004_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u8 samp_freq_index;
+	u8 offsets[4];
+};
+
+static int fdc1004_soft_reset(struct i2c_client *client)
+{
+	int ret;
+
+	ret = i2c_smbus_write_word_swapped(client, FDC1004_REG_FDC_CONF,
+					   FDC1004_FDC_CONF_RST_MASK);
+	if (ret)
+		return ret;
+
+	return poll_timeout_us(
+		{
+			ret = i2c_smbus_read_word_swapped(client,
+							  FDC1004_REG_FDC_CONF);
+			if (ret < 0)
+				return ret;
+		},
+		!(ret & FDC1004_FDC_CONF_RST_MASK), USEC_PER_MSEC,
+		200 * USEC_PER_MSEC, false);
+}
+
+static int fdc1004_wait_until_measurement_is_ready(struct i2c_client *client,
+						   int meas)
+{
+	int ret;
+
+	/*
+	 * The slowest sampling frequency the chip supports is 100 SPS,
+	 * i.e. 1 sample every 10 ms, so our timeout can't be shorter than
+	 * that. Go with 40 ms to be safe.
+	 */
+	return poll_timeout_us(
+		{
+			ret = i2c_smbus_read_word_swapped(client,
+							  FDC1004_REG_FDC_CONF);
+			if (ret < 0)
+				return ret;
+		},
+		ret & FDC1004_FDC_CONF_DONE_n_MASK(meas), USEC_PER_MSEC,
+		40 * USEC_PER_MSEC, false);
+}
+
+static int fdc1004_read_measurement(struct i2c_client *client, int meas,
+				    int *out)
+{
+	int ret;
+
+	/* The datasheet says to read MSB first, LSB second. */
+	ret = i2c_smbus_read_word_swapped(client, FDC1004_REG_MEASn_MSB(meas));
+	if (ret < 0)
+		return ret;
+
+	*out = sign_extend32(ret, 15) << 8;
+
+	ret = i2c_smbus_read_word_swapped(client, FDC1004_REG_MEASn_LSB(meas));
+	if (ret < 0)
+		return ret;
+
+	*out |= ret >> 8;
+
+	return 0;
+}
+
+static int fdc1004_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int *val,
+			    int *val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		iio_val_s64_decompose(fdc1004_scale, val, val2);
+		return IIO_VAL_DECIMAL64_YOCTO;
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
+
+		/* Configure the measurement we want. */
+		ret = i2c_smbus_write_word_swapped(
+			client, FDC1004_REG_CONF_MEASn(0),
+			chan->address |
+				FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
+					   data->offsets[chan->channel]));
+		if (ret)
+			return ret;
+
+		/* Start the measurement. */
+		ret = i2c_smbus_write_word_swapped(
+			client, FDC1004_REG_FDC_CONF,
+			FDC1004_FDC_CONF_MEAS_n_MASK(0) |
+				/* "+ 1" because the chip wants a 1-indexed value. */
+				FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
+					   data->samp_freq_index + 1));
+		if (ret)
+			return ret;
+
+		ret = fdc1004_wait_until_measurement_is_ready(client, 0);
+		if (ret)
+			return ret;
+
+		ret = fdc1004_read_measurement(client, 0, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&data->lock);
+		*val = fdc1004_samp_freqs[data->samp_freq_index];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_OFFSET: {
+		guard(mutex)(&data->lock);
+		*val = data->offsets[chan->channel] * fdc1004_offset[1];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = i2c_smbus_read_word_swapped(
+			client, FDC1004_REG_OFFSET_CAL_CINn(chan->channel));
+		if (ret < 0)
+			return ret;
+
+		iio_val_s64_decompose(
+			sign_extend64(ret, 15) * fdc1004_calibbias[1],
+			val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = i2c_smbus_read_word_swapped(
+			client, FDC1004_REG_GAIN_CAL_CINn(chan->channel));
+		if (ret < 0)
+			return ret;
+
+		iio_val_s64_decompose(ret * fdc1004_calibscale[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const int fdc1004_calibbias_decomposed[] = {
+	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
+	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
+	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
+};
+
+static const int fdc1004_calibscale_decomposed[] = {
+	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
+	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
+	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
+};
+
+static int fdc1004_read_avail(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = fdc1004_samp_freqs;
+		*length = ARRAY_SIZE(fdc1004_samp_freqs);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = fdc1004_offset;
+		*length = ARRAY_SIZE(fdc1004_offset);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = fdc1004_calibbias_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibbias_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*vals = fdc1004_calibscale_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibscale_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_OFFSET:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan, int val,
+			     int val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	s64 val64 = iio_val_s64_compose(val, val2);
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(fdc1004_samp_freqs); ++i) {
+			if (fdc1004_samp_freqs[i] == val) {
+				guard(mutex)(&data->lock);
+				data->samp_freq_index = i;
+				return 0;
+			}
+		}
+
+		return -EINVAL;
+	case IIO_CHAN_INFO_OFFSET: {
+		if (val < fdc1004_offset[0] || val > fdc1004_offset[2] ||
+		    val % fdc1004_offset[1])
+			return -EINVAL;
+
+		guard(mutex)(&data->lock);
+		data->offsets[chan->channel] = val / fdc1004_offset[1];
+		return 0;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
+			return -EINVAL;
+
+		return i2c_smbus_write_word_swapped(
+			client, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+			DIV_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
+			return -EINVAL;
+
+		return i2c_smbus_write_word_swapped(
+			client, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+			DIV_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
+	default:
+		return -EINVAL;
+	}
+}
+
+#define FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(_index, _channel)         \
+	{                                                                  \
+		.type = IIO_CAPACITANCE,                                   \
+		.indexed = true,                                           \
+		.channel = _channel,                                       \
+		.address = FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHA_MASK,    \
+					    _channel) |                    \
+			   FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHB_MASK,    \
+					    FDC1004_CONF_MEAS_CHB_CAPDAC), \
+		.scan_index = _index,                                      \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |             \
+				      BIT(IIO_CHAN_INFO_OFFSET) |          \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |       \
+				      BIT(IIO_CHAN_INFO_CALIBSCALE),       \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),      \
+		.info_mask_shared_by_type_available =                      \
+			BIT(IIO_CHAN_INFO_OFFSET) |                        \
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |                     \
+			BIT(IIO_CHAN_INFO_CALIBSCALE),                     \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
+		.info_mask_shared_by_all_available =                       \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),                      \
+	}
+
+#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_index, _chan1, _chan2)       \
+	{                                                                      \
+		.type = IIO_CAPACITANCE,                                       \
+		.indexed = true,                                               \
+		.differential = true,                                          \
+		.channel = _chan1,                                             \
+		.channel2 = _chan2,                                            \
+		.address =                                                     \
+			FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHA_MASK, _chan1) | \
+			FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHB_MASK, _chan2),  \
+		.scan_index = _index,                                          \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                  \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),          \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
+		.info_mask_shared_by_all_available =                           \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),                          \
+	}
+
+static const struct iio_chan_spec fdc1004_channels[] = {
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(0, 0),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(1, 1),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(2, 2),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(3, 3),
+
+	/* The sensor only supports differential measurements where CHA < CHB. */
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(4, 0, 1),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(5, 0, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(6, 0, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(7, 1, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(8, 1, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(9, 2, 3),
+};
+
+static const struct iio_info fdc1004_info = {
+	.read_raw = fdc1004_read_raw,
+	.read_avail = fdc1004_read_avail,
+	.write_raw = fdc1004_write_raw,
+	.write_raw_get_fmt = fdc1004_write_raw_get_fmt,
+};
+
+static int fdc1004_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct fdc1004_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return ret;
+
+	ret = fdc1004_soft_reset(client);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "fdc1004";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &fdc1004_info;
+	indio_dev->channels = fdc1004_channels;
+	indio_dev->num_channels = ARRAY_SIZE(fdc1004_channels);
+
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+}
+
+static const struct i2c_device_id fdc1004_id[] = {
+	{ "fdc1004" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, fdc1004_id);
+
+static const struct of_device_id fdc1004_of_match[] = {
+	{ "ti,fdc1004" },
+	{ }
+};
+
+static struct i2c_driver fdc1004_driver = {
+	.driver = {
+		.name = "fdc1004",
+		.of_match_table = fdc1004_of_match,
+	},
+	.probe = fdc1004_probe,
+	.id_table = fdc1004_id,
+};
+module_i2c_driver(fdc1004_driver);
+
+MODULE_AUTHOR("Victor Chernyakin <chernyakin.victor.j@outlook.com>");
+MODULE_DESCRIPTION("Texas Instruments FDC1004 capacitive sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

