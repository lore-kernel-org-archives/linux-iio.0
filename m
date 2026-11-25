Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795602007;
	b=s+R3dcMuSCKwVz3BjQaENr2OHVMMAnT99xCgrG7CB7kzXbn0s83Bjqix6ny4XKyBroDi
	 F2F4e7tDDbFmk6Gy2VsrVq7fArDPZybeni0Lc7ZEQ17Fiq81bLXiEH8v0BbG7S6d+Ua/p
	 TVS69Lew8sU/48zD+ysjn3+7hRrQmXRShCbS9qUVXAApY6gfectf4UWce9e3VHEPEzaSv
	 thmkeiSZMD8s4IT0DzoY1f/YHVdrLVIFBu9Wha2hkUw2OmhrqYha5IolZAZ7MmUg2aext
	 jQh5RLlxparPskIMcQtwCqKRTeZTmrlKXU4WrnHMFDSJ/ZW8c4d2lMXovELqfJVHKSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602007;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xD7F0FS/dtOfqsfwc7JI9Wt7hP23KAkA3UPjTJVLbxo=;
	b=eYdpAU5agUvV2fhtUlS+OhwdYMxrdKGijd3ZDMmK7vjzmuF/xDY7NOHFlCbcoReI4d7p
	 oN7w/4iVhqkMJi5M0R/mEtUWqqSPYNSUghY/0pxgzns7+0erLJjXi32NLbAe9+YUQgQig
	 23sHbBoiCXLZXOlcElzUKcgl8t6iibchzESyyc6uAuAlf6gImVP8wgZCTfLn3DtXVFRsp
	 +x4VqPvt9jxzu64s192l34P19Ae0YJPZOXjzl/unZ6Rhs896G7FHAS/P1e+QEinvoFsny
	 tGROeWXSAn1alHMevN9HIPxbmZifHXxV79mt2hXGF2jcJhz/peCrShb/dGNlBGbuCww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RI0rm9Ir;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=vH5yIFHM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B708606A684;
	Wed, 25 Nov 2026 10:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B708606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RI0rm9Ir;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=vH5yIFHM
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mvXT2011045;
	Wed, 25 Nov 2026 05:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=xD7F0FS/dtOfqsfwc7JI9Wt7hP23KAkA3UPjTJVLbxo=; b=RI0rm9I
	rVUgWhOB/+RsDvyRfauIlwedAffiE1Fb0FPNsALuYE8t8fISTFKddsi4dwunO7wd
	/zN5ujYhNqwy7NGdg5qC3j834b8ZLfIHMPsTpI3zlegrL1VxNPuV+gvFnaUroW5b
	2D3i06xzYoajWeYXc0nG0HSAwXs2LkLsw6b5fXwsEBuTrb7i7eKbTmucJ+p63bC1
	1Ma606zC3N4hR4N7Lh8xYtbbJtgFQmAL+QQn8TFYKtqSORn1lyU7QqyN7gwsoN1D
	btOK4bOQbp03iId0LSJqyk8A/9ouELNoxGX8Od3QEhi4LNhzvdyc+UjTAYY9jl53
	uy/PZifYdXgH9Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xD7F0
	FS/dtOfqsfwc7JI9Wt7hP23KAkA3UPjTJVLbxo=; b=vH5yIFHM6sRZ8LCw/xYQx
	8aMAY7sDCwgyimXZdT6l7/T846fmBEAEywesK9UHEwUR7W8phbJxg0jsxoQYumMZ
	g+IY7ut3vk0kE846a+bPU5goPhC4vEBx92kwsTwWj1fExwkzZ9ngP+hUl5bi/Hdd
	fq55RyBe5D7DX9BmD1mNwseaTEMwt+ys4jQM7rGu1Dc5C45xXPRbuYUT3bKeejXq
	0TPbeKu6/pJR4eud/S4Wj4VBMtb2gitkEI8PjxFxdqQUL+kszb7ncDLT/nUUZCs5
	K9alAokrk9gIHCEV3lf4YAoSKR6RgvphLbmh72747UefNtDvUWWesgLs+zV7tZvJ
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j5epyca7j-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 05:19:49 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwdWRsoLbVX+DG1A5WZDCBhpWFv+8l5ZW1javzyu0CGnSd0JIsQgWpjp1wtKI7YC5Cdc5T72OIz1KxBOHuS3rCKckOR0F5PfDoZhrAtMrt4U1nI3J3n0W6sf066IeXExYn//hL+J5Rt9aQt+1KXnby7pOUVRoJvv7K+5Lv9eyM0qFiOOeG/cUjdvkafr2cCIjkdkGJR0ZU9276pNiL4sCobEvYK2p9qKEZyLoOIx7FoZ2SIUFQgeI1GJxe7ryeesX/Sruqlw+EtL+9wQP2W7toSctVPoL7q/biZPHhbiSIE9z4bme1kobiIPh6aewZoWep/TeY8sW1uB/cpT1RCQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD7F0FS/dtOfqsfwc7JI9Wt7hP23KAkA3UPjTJVLbxo=;
 b=Ir6LW0ibdvme5qZ3oUf3zzXKUDPI7FNhWvaoTpYo/UWPKKkMwQCHp/dGg0ZL2vl6t52mFB2Z5+QGef/UqUzh1qmF16J0UqJ33ywWLZntnM4F2r0TR8MPGNcnWpBudrul2wpgO9d3v1RyMU4W4Cb6ceter/kt+kKhCWUnRUwrnXw7Dx+Fy4nMa/BUrpUClUn7aI04TZlU4Fk0ZDaxq3VJpv4PC82JmgNDgBzqiblphi9qMaSrd/gGXfTExJRUgB/oqVgVbWWo9FdW1dPQHgVyDYM9UatizzBwkyDDOzYXl2AmpuWI+TWdn4w/lT3jylTsZrSyqgF6hQfDcCLlEZUcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6048.namprd03.prod.outlook.com (2603:10b6:5:393::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 10:19:46 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 10:19:46 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 25 Nov 2026 10:19:21 +0000
Subject: [PATCH 5/6] dt-bindings: iio: adc: add AD7793 and similar ADCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-iio-adi-legacy-platdata-v1-5-54e4c8830b57@analog.com>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795601958; l=9112;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YTpaMACEZA0aUnIazm5Q9tZRPs+gjxWZ87BW4Zu2Wo0=;
 b=1bBd+mLMjNTn6OKiYTegurPaph3OTnVrszA9SkokgckvduDyCTsjf6xJzSg10huSbV6KNtLoo
 XyAW/WrNiibDHH6nkBEnJupbHjSNSUSpzEWbD0ys/n/dIFPlx2RLZkO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0091.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 4738e210-39b7-48b9-3de0-08df4adda123
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|22082099003|18002099003|3023799007|13003099007|11063799006|5023799004|56012099006|261022075727099003|261028144727099003|261026121527099003|261102123227099003|261021121427099003|261021135927099003|261009223027099003|261026140227099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 6tHNinH0e+6+zWcLyExhvNJX7j0jDTPX2DUIEiQ/eLngd0nSf3ySF+IRSHcJPHu/21YUqbpxRoWNRaqv2sdBoaUkjuMeptT8F/wXEZTeJxN5s822gJARWKmFTAu3A/djXjMMmFH9nAhIC2LUhqbzrdtIK6JXrxw+vAfDX9geqKwrF+tMmGG4gPwlAHF4BWUSmSfdkTweVjT+YlVnNn3E4sei2jHm8ixbpaEEy3Hi0pyiBVkvb7J/f7hEngEHfWsnIZlEbebQfY8kT4TpSW0SJ2yd22sbt029fkQkT6loNR/qI42/dCYdWde5Aa0+n1Wzni4mudYlXgOemKDj2gTxbMy/9H42VU1BEWLDdpbZjeEupWulw5uNrUZUpJL8Tzkn7TF4iUyHuTpMg3miFO2YLe20MmRtbnWM/y+6R6LV5+mpUUYhxd13ske4mP4kZuyhoF5BHVgtAOG1FkTaomlN/UGXGSspo/YjM8RhLtfezD7VztE+0wjmsoX553ySR3PwFt3E2HY+wfQEuzQP9AtaEEDJsM/ajmBb7D5zrhqbn7gb8fhBgXyHWQ9XwiOcq5X4kx7vx8Cnz2djqJF3yIeMZmSmgPYkSXWHV/kiyAYVi78=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(13003099007)(11063799006)(5023799004)(56012099006)(261022075727099003)(261028144727099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021135927099003)(261009223027099003)(261026140227099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YkhUeTZKbzZtSUFKWU9KRlRXbGNsLzBiamUvSmo5eXpLWE1qN3V0RzZ6aG9D?=
 =?utf-8?B?cm9obUFyOVBTZ1BmUEd0emRtU1RzR25HTzFrU2pId1lWWTZTYXpqUytFcitO?=
 =?utf-8?B?UEZ6THlMeHRnVHh2MWZhTnJFWjJmTW5hZm51LzE2dEVGUk9YNkZVSlZ5eWRW?=
 =?utf-8?B?OTA2TStBUHZMSGVubEFtNmwyY28wV0VKWXdxV1YvcVV1dTM1NzV5anQwTnBG?=
 =?utf-8?B?MDk3WGVEL1M5dXlseXdYRktJb1czK2t4c3lBa25EUWRibjR4RXdpcGI5SDBT?=
 =?utf-8?B?WFF3bllVUG8veCtDWEJ3YVJ2S3Vvb2lWbHMwTTQvM2JMaFZCeXdEK3NWRU56?=
 =?utf-8?B?M1YvN2ZoV3ErZlRaN0ViKy9OV2ZBVXQ4ZWZSbGxtVWtjWEtPQ3NSNE1HY1kx?=
 =?utf-8?B?UzRDNHg1TWNrS1FIbTZuSXpIZEV6enZCRU00ZTZoV2Mzdzd1YTR1UmNneVhY?=
 =?utf-8?B?QkhQOGtVTmp1Tk5YT05sbnFnRFA0ZjBDYVJiRWh4VDFUdnI1TkxmSWx5UE1q?=
 =?utf-8?B?NFI0L2o3eDJyTDl3QnhXMXNDbzUwbitVQUtYelF6TWJsZWtiRTdyaldjbEg4?=
 =?utf-8?B?LzNEekVTQ0Y2RVRlbU1FVjRxRFQ2cTREcUdtVlFxdmRFYnRuRTVhUWRlV1do?=
 =?utf-8?B?V21jOXQ5SFhOMlJRa0hQL0w4OVlVaTJjeHRMVy9CU1Noa0x1OC9vd2prZTRC?=
 =?utf-8?B?SmhFZDdxMkVSQXdLNE0wUDU4NjV3bWNGMStuVkhLWFRjNHU1SEZpcVZlV0FM?=
 =?utf-8?B?alM5b1lEQk5rNVpkTDB0ZElrVmtwWjF6U3NPU2w1YTFrOU85TTgrSUVWdnJx?=
 =?utf-8?B?a3l5Z3lPWGREVUhBY2EvRllaTEZkWEpUZklBY1lUWEUxaFVudGtSNkdIaUxI?=
 =?utf-8?B?Z2Q2elJiUHhldTQyOUdGdmpzK2Y0WUZJM2VmWVFSS1RHeE94TGxvVlp1QWZ5?=
 =?utf-8?B?b3N3aVQ5Yy9TekZ6SlN0MVJCeE95YnA0SWhrNERML0lkUE1Kc095cW5xTEY4?=
 =?utf-8?B?bkkyTmZ1R1lqaTV5QlhRTzBnYkIzNkRNeC9CcjdwNFlnSjJjWnUwZFVGZTVF?=
 =?utf-8?B?WEFob09GRVl4OW9Id3MrUzgzNlUyUlJsRnRzaXBITGgvUXZkdGtob1k3akgv?=
 =?utf-8?B?cC82QThxR2FHTkdqenJGZCtxSzFVUVB2WWgrdEc0NnBYMWZFYWZrcWdPSzlN?=
 =?utf-8?B?alUxWElmOFZxejBOeUovd3E3dmJyVElseUhnVDZOL2FHZXU4QktQekJhN0ZZ?=
 =?utf-8?B?d25JYTk5cjdmdEdjZi96UUpLck5LeFJWdE9DbmpPZFdrMjBId2UwUHNsK1ps?=
 =?utf-8?B?WEZPTjNRK1FMUGxGTU1qZzJObmYwLzh2NGlXck1PU3huRW5jVklDME9wRk5S?=
 =?utf-8?B?Q1YrSEl5ZUJoenIvTHdTbDhNaGdzUThZbkhtdlFnN3VNZUs4L3R3YXIvSWFx?=
 =?utf-8?B?YVVhTWxrQ3ZDS2pYL01aNElycEh4cU82VkpFOGxzWFVYQjllRkRMNDNrOEpi?=
 =?utf-8?B?R1g3aDhwbkhXb0JEWjFCZytjT05rYTFmRmxyL2NEdTdEckF4QXJzQ2xwV09M?=
 =?utf-8?B?SlJJeEhSR085SUJHNEVxT0gzbXRFRFZaWDFGZkg5cWFxNVdybmlHOFkwT1la?=
 =?utf-8?B?Qng3ejE0ZFZHWkw1YW9Nb2J2d1U3SlVxMHE5aERBS1djUXJWTUVta21Kc0Zy?=
 =?utf-8?B?RStETjBtcnJLZ2V2L1cwZmcxcEFTMUVNb2VBUXhuRjlOYTBQdENYbXY2MXc2?=
 =?utf-8?B?djFoSklzS2JWVmFySjJzamZMeVpkTy9Ib2Q3Q0YxSGlrZnE4T0ltdnlyQVYy?=
 =?utf-8?B?VG1kNUxSVlJGeERxT0RQOS85enNSSEV4a1hKOEY4SXJsWHBBMXJuZTlrOWZj?=
 =?utf-8?B?eWNQUzgyRFhCZnhEekhqT05xWlZ4bXdPZkRTeUNTTFdaUHM4cGdzWkdEeUEw?=
 =?utf-8?B?SThNSWg0VUVxUXFYcjNyR0ZLRm9xdEw0RFB5MU1la3luR0gvdXI1ZTRyZWlO?=
 =?utf-8?B?cVNLYnNFazJXVjFlMVJhVllpOWtsdytwdUc2NUx0VTdCQzF4WnpMV252ajlj?=
 =?utf-8?B?MS9WY0JZMjJGMzg3SnluT2xJUWRjSkNUZ2xQWVBxalZHL0pyT1JCSXN1VWdC?=
 =?utf-8?B?OVFGOUc2enhhTnNDMHFQc29ZYW15b2E5MHR3NTZLZlZKRDlPYVc4SWlQRWgr?=
 =?utf-8?B?RGhWQmxnZCtRT0dvVjNxQUkzNkZaS2x2ZFBicHViOW1DMStPNWJydlFvTVZt?=
 =?utf-8?B?cE5odit3aTYwNy9TZC8xNFh1OEtFenNvc1BqK3l6aXp3V2dwUHVMNVdDNVo5?=
 =?utf-8?B?S25GdzA4ZE5XWDVMSHhpbTB1OFQyTW1rMUV4aU04eE0zaHJ5cmVZQT09?=
X-Exchange-RoutingPolicyChecked:
	iR+cxhe2MWFPhjqxzwnkv5OlOeCPYQ8/flF7oVP88PjZwk/kRSRtrKl2sYuA8Xhs8dsnauNrhgfXM68SvJbCC9VT09An6oxlUKUF8eeqKw+zEOr1Fnca6KaqlJlcOMpflL7iIllITr5lGo1MAHap06P/CFD08uWC8aufcWL3Ofh3FwyA0xbqJHUYLib9W9cuwhTzJHLrPM1vBjdWu6wuJhQPrlDn1w3mC8BT29MmRORcrrchPlXNqj2xEFU5eBC4SZCtYU+Z4IsLIeIKtfJ+e//tELSBqPLChoiFcNiZNWFsf/cCe1fuuxbHRMGLFU+nVO6JPHduVxhYTMx+tMGUvw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4738e210-39b7-48b9-3de0-08df4adda123
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:19:46.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4nBGdZua4E/ZL/Vp0oOaQ98t1OThh3/3rahqEr7AEnyWRu7hqBRgFZVdl9t1xx9Y7i7SfHq6BRgOOfrb0nPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6048
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXwn+l/uuGNXI9
 n8RVQdLj1rjMqUtS+e/wPbxVpyOzYqAkjzPZxR4w3bhUVfsixtZfS6WrAig0S+eOffxkseTPMR0
 4kCNy2ewR5ZEaFPrTsPFssOUzN0H86nMMK5jzQ4Aabfga+qyw4FTTDXQGBmCksNBYTZJJGbh3En
 h3WRO11IK6+ihgp2kDUeWicwj/qBR7fYjb3SpFa/Dhas1mUMd/BJaorhlseIiS1rXHBIlFJejdz
 l6p9URFJ3FD5tRT26kQcsCH+1csMNy6wBNFcc7PSUZzEOtISxjRCgxgwl4TrJkTaRiSYyjWAQnZ
 CQxe0LxKITq2MEqfQDMOxvf7FfrGxuhX2L+HjXgrYoV9yxVg+Zoy3qpIvXE738bsVnUGJmzPFFt
 tZ4hh9zz14j65fWbHZXc/nQGlPxRmEKhrzcjvt9Oz/iMJQU0dXCT7gCzfvkUrZwi11PXwtM7tNH
 MwW2NrNpzc0KdWxkH2A==
X-Proofpoint-GUID: uIU_GFFuiBk-5_De_U5TW3-VFGO0_izj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX25+Ft3q0X5bT
 3/l4/ywNYlWSgI2RSt9opb7KoLheyyzLAGZsOzVllwoLR6I5kVkd0iycbq5EZ6SvPIwDJuoD9RN
 OeFBb3WB/4Y5mw5B9oKBT/bKI8SwqD5I1O1wiAqDy5vk4FueJtsE
X-Proofpoint-ORIG-GUID: uIU_GFFuiBk-5_De_U5TW3-VFGO0_izj
X-Authority-Analysis: v=2.4 cv=G+WJgNk5 c=1 sm=1 tr=0 ts=6b06b645 cx=c_pps
 a=Y+Of8T+w2jezINbWzwznEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=iRHHsuLH0UZ76JoTv14A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250040

Add a binding for the AD7785, AD7792, AD7793, AD7794, AD7795, AD7796,
AD7797, AD7798 and AD7799 low power sigma-delta ADCs. The driver has
supported these parts for a long time, but only through platform data.

The ADC reference is described by which supplies are present: REFIN
(REFIN1 on the AD7794/AD7795), then REFIN2, and otherwise the internal
1.17 V reference. In the same way, an external clock on the CLK pin is
used if one is given, and the internal 64 kHz clock otherwise.

The remaining properties describe how the analog front end is wired:
the input buffer (enabled by default, as it is at power-up), unipolar
or bipolar coding, the burnout current sources, the bias voltage
generator and the excitation current sources.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7793.yaml    | 236 +++++++++++++++++++++
 MAINTAINERS                                        |  10 +
 2 files changed, 246 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
new file mode 100644
index 000000000000..c4a0be06e5c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
@@ -0,0 +1,236 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7793.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7793 and similar sigma-delta ADCs
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description:
+  Low power, low noise sigma-delta ADCs with an SPI interface.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7785.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7792_7793.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7794_7795.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7796_7797.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7798_7799.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7785
+      - adi,ad7792
+      - adi,ad7793
+      - adi,ad7794
+      - adi,ad7795
+      - adi,ad7796
+      - adi,ad7797
+      - adi,ad7798
+      - adi,ad7799
+
+  reg:
+    maxItems: 1
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  interrupts:
+    description: Interrupt connected to the DOUT/RDY pin.
+    maxItems: 1
+
+  rdy-gpios:
+    description:
+      GPIO reading the DOUT/RDY line. DOUT/RDY also toggles during SPI
+      transfers, which usually triggers spurious interrupts. Reading this GPIO
+      allows to tell those apart from real conversion done events.
+    maxItems: 1
+
+  avdd-supply: true
+
+  dvdd-supply: true
+
+  refin-supply:
+    description:
+      External reference applied between REFIN(+) and REFIN(-), or between
+      REFIN1(+) and REFIN1(-) on the AD7794 and AD7795. If present, it is used
+      as the ADC reference. If neither refin-supply nor refin2-supply are
+      present, the internal 1.17 V reference is used.
+
+  refin2-supply:
+    description:
+      External reference applied between REFIN2(+) and REFIN2(-). Used as the
+      ADC reference if refin-supply is not present.
+
+  clocks:
+    description:
+      External clock connected to the CLK pin. Either 64 kHz, or 128 kHz in
+      which case it gets divided by 2 internally. If not present, the internal
+      64 kHz clock is used.
+    maxItems: 1
+
+  bipolar:
+    description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
+    type: boolean
+
+  adi,buffer-disable:
+    description:
+      Operate the analog inputs in unbuffered mode. Unbuffered mode allows the
+      inputs to go from 30 mV below GND to 30 mV above AVDD, while buffered
+      mode needs 100 mV of headroom to the supply rails but tolerates source
+      impedances in front of the inputs. Buffered mode is always used for gains
+      higher than 2.
+    type: boolean
+
+  adi,burnout-currents-enable:
+    description:
+      Enable the 100 nA burnout current sources in the signal path, which allow
+      to detect an open circuit on the selected analog input. They can only be
+      enabled when either the buffer or the in-amp is active.
+    type: boolean
+
+  adi,vbias-pin:
+    description:
+      Negative analog input (AINx(-)) to bias to AVDD / 2 with the bias voltage
+      generator.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ain1, ain2, ain3]
+
+  adi,vbias-boost-enable:
+    description:
+      Increase the current of the bias voltage generator, reducing its power-up
+      time.
+    type: boolean
+
+  adi,excitation-current-microamp:
+    description:
+      Enables the excitation current sources IEXC1 and IEXC2. Both are always
+      enabled together and set to this same value. Where each one is connected
+      is given by adi,excitation-pins.
+    enum: [10, 210, 1000]
+
+  adi,excitation-pins:
+    description:
+      Output pins the excitation current sources IEXC1 and IEXC2 are routed
+      to, in that order. The default routes IEXC1 to IOUT1 and IEXC2 to IOUT2.
+      Both sources can be routed to the same pin, which then outputs twice the
+      configured current. This is not allowed when
+      adi,excitation-current-microamp is 1000.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    minItems: 2
+    maxItems: 2
+    items:
+      enum: [iout1, iout2]
+    default: [iout1, iout2]
+
+dependencies:
+  adi,vbias-boost-enable: [ 'adi,vbias-pin' ]
+  adi,excitation-pins: [ 'adi,excitation-current-microamp' ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - dvdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        adi,excitation-current-microamp:
+          const: 1000
+      required:
+        - adi,excitation-current-microamp
+    then:
+      properties:
+        adi,excitation-pins:
+          oneOf:
+            - items:
+                - const: iout1
+                - const: iout2
+            - items:
+                - const: iout2
+                - const: iout1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7785
+              - adi,ad7792
+              - adi,ad7793
+    then:
+      properties:
+        refin2-supply: false
+        adi,vbias-pin:
+          enum: [ain1, ain2]
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7796
+              - adi,ad7797
+              - adi,ad7798
+              - adi,ad7799
+    then:
+      properties:
+        refin2-supply: false
+        adi,vbias-pin: false
+        adi,vbias-boost-enable: false
+        adi,excitation-current-microamp: false
+        adi,excitation-pins: false
+      required:
+        - refin-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7796
+              - adi,ad7797
+    then:
+      properties:
+        adi,buffer-disable: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7798
+              - adi,ad7799
+    then:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7793";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            refin-supply = <&vref>;
+            adi,vbias-pin = "ain2";
+            adi,excitation-current-microamp = <210>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 658895c3b0fa..e55236f4accb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1731,6 +1731,16 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD7793 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
+F:	drivers/iio/adc/ad7793.c
+F:	include/linux/platform_data/ad7793.h
+
 ANALOG DEVICES INC AD8366 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Rodrigo Alencar <rodrigo.alencar@analog.com>

-- 
2.56.0

