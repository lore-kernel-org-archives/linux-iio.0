Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D195650F6;
	Wed, 14 Oct 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996874; cv=fail; b=nxbwi6mHymGlaPGIqUJR21NoHjGITNvIfYxemabzSV6Gu2YD+UKdGidHJLlGB+dyEd0SqHe8KQ6lJb3/qMCW2WnBBwdt2AmuLEqBXCyvqT6hwVYmyJvq3qmhC5DsNDaF+zXONZzWqPmGD5jyVLWqSsdkpukoQvTO/mZwL9eXrwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996874; c=relaxed/simple;
	bh=3tt8dtQeWvcwocrt7Yg2mbphTyIIMvmKvCWA6t36fW0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=e902CkDKfz8WEIMm++mtshjSBW0YFKbHuj1FaxuMJjM3A+D11pRK1sOwzZXN8ldfJ3ZhFFh2JsF7Edjfks4k2C6rW4MDyUG0oOYUuZD/NfNUsyCYwFEfNDpEpkDaW+uEtnSoYLNfWNFZt5QkJaIWZqS0IxgKHM/5lwxLAcs0SpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=tg9xzLiN; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mmXwG6+Q; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="tg9xzLiN";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mmXwG6+Q"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEdufU1109535;
	Wed, 14 Oct 2026 12:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=a4lZPeLIyaLxY8vvyFHbFjRYj7k//gGiXkM06DZj+J0=; b=tg9xzLi
	NBPcjTLcBULovuNHcdo+Fa8+I4l4sHePTeMqZ2GR0JddejWXsYH55YGEdAz1rBm4
	kiOpvn2FVOksa2wVx4J4BAdtyTVeIrmy9oGxQyCUnJj9dnzVwT7VXbka7DJ0St73
	9PXY4gbrcMPV0w1Vx2JkatXlQUm2VKQ71S1Vk3ErGSs8zmoE0CQ0aesQI9HaU0ch
	PxnD9mIuTDvBcZ8m4blFoftsz5iZBoxR1vTgGl0QHxMR3hcYoc7RgqhwuqcyRmLW
	aToPC2JGwskiyy7ZLBDJ7BDTDsNRa84Ipsvy6scALDHAnAqCl5h1JIqWxGK1IpPb
	URoyJN8SkhaajkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a4lZP
	eLIyaLxY8vvyFHbFjRYj7k//gGiXkM06DZj+J0=; b=mmXwG6+QYQZsWOufYrV80
	CRkfod2INxs+++gOt72INZu4U0F9Z6thpEw6y8Tat7UUBI0vdShYRqOb1a63BWaa
	q7DQWxiXwIGiLOcn06DEee2blOyp1HXrf7aiyLqrkIee/0wgxgGBxOKhyExaHd5j
	e0YNvXrNSENCQrV6DGtjPRqHQJor6WvErrPxoO0u/Un9p4eopnQvEpYrwmmuXRPw
	MYtG0HixjLsXxsvfodizCRopWPueP2C2MsIo1zhteBQPOrbtIG7QapLs/WyThNUl
	nnq8caFtJWR84fIPBDRnSHnoo9xvOdnkQlKrgBf7ymOhcKll2UG+XB0dfYbT0og5
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ha0t3cjam-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:29 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWa/A6nsaG35I0N2iDlJjmObnFu24+O7Qz0N0D5Jc4j2WyVdDgmcGZHyjpFMIzeeRH5FgsVNjgXys5oukvKtwCao4y9InTG03cfmwST8ojB74iURQbIsprP/wcztY/sjjYfkr/q2arHeIwkfmSSEu9oCrzf1n77Az6SwtYYY8KbpiWDbYL9yRzrhkex/aHIkVk8d0NqvAfoVkhV29jZ29cC3t8yhNQs1EmR0lDdC5xeJWV5erKxBz57x3xjSnX/w7ObYXfkKXZ8YvbJMd7OrW/3jmbvxkKA2gVZkMngPt0RmQLP8VSWiAGvdPcCMzshLGsQAUv0zYvscJzNXIl06pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4lZPeLIyaLxY8vvyFHbFjRYj7k//gGiXkM06DZj+J0=;
 b=piq9lOCO8Z+WY30/VcvzrEXQ1Ga1KwtzMyuhRNsTYsTd1vOsiyh4S9D/jo/DWIHfSVKo3bH+cIvcYSPiet9N+fIrggpWsYJl6pG/LR7jUggZOo5p3QN0Bq0pFPmE2oAzPW7SETfRqe6nCSsfLrhhA8wPQAHPVAxolI7jfP/61K9OiAGmoVJwt4tepnWwvswyzqze5kMxtho9qqxYloIJgMAXqrNnCjoQwh/CHgSIcWZSf29OjDMoB0gYc1W7hU+vqzIFgBwldOiEWFcqhfDA7vxv33jXIyJh7WZL/UPnviGBGNkTzC65c7yGL1zTm21pF2bYXkn/ZpiqzZ1XyPnCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:27 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 06/13] iio: adc: ad4134: Add support for digital
 filter type selection
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com
In-Reply-To: <34420a81caefbbcc589da506097571bb516e3eaf.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <34420a81caefbbcc589da506097571bb516e3eaf.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692823.658576.1219069284305538955.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=616;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3tt8dtQeWvcwocrt7Yg2mbphTyIIMvmKvCWA6t36fW0=;
 b=ff+Tv62tGww30utsmAt/n1wYpN2N1sUk6WfcMUAnfaYN61R6V2NQr+mk3bFuwZxmEO4P8VEaj
 g8qFpV91ua0Au9d6iCpETv9mrF/uSBuwFiWzYN0hLn9RbL2AKW9f+wU
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0023.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fac5df-c273-4e67-14da-08df2a13ced1
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 q530VsRTc2JScDmhMYomO/A5N8eTnJNm4HS9947iOfKtRn2/kwrB9BohEWTmuCb/3ngZPk3k9Ak6o2G8tDrfzHAMzEA8OiUsmMD7W6ttGaisP4c3Vp39tfPHrKZnUwu0Ulcmex5LSOh9/mWfGpyFJyDz0bLBfloPVm6geJby2+CShJVLFzRaaNk9UOdzmvtaV3cDWGDNRy4wxmcqy/wgy1kPUd0VTIVShUe1Gopiexonp8o9cXdCxaBGcn14iox5yGYbWJbP1nXV957cpVENQt0tSpO6YsGlma4UidubMwR69Fg5EA5hsws1jqgj6Z8VcIG7WpgL0nTFKVhJize9kbr/n+F4KMfFwfZSm8uyaFrmIatcwuMvBXRfQhmVSP7BuIcRUf/IHfPF14kD4D5nO4+0AFBrJZBTtMc6CIQMC6xjHeyk+EQE+x0aaVOXS/79jFigzWdX7aqOyh6d6MYSsifxH7BnfRJ90pXNF7qifK4qPBXkC8VGbm20DZQO7DKi2HVmyQ/Z2ltFAhExZjE0CfBmZtjf/0qCydzfCtO//MJu13k+5xEkIBpu6tBKykSdkaEUpbeXktvzNFY3AQepUfuI+uAd/AcjKnT1FJrz51NWIQWpDOEVDitqNP15ySkY9fjLnU0gRrKkSjniOr+SPiXeyckI0IqsDLuE+KJQMJg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eVY2M1B0Smh4SkxwdHpWUmNvSVRHTG5Xa2NrQXR3K08wQ1hCN1djMU1CaGYy?=
 =?utf-8?B?Q0lCWDJ4NFEzVFZ3OU1EV2hBT1Q3L01JMm8vbUxVMStRektsY1BhNGw4Rm1L?=
 =?utf-8?B?Z2JvRTNTZEhaMGt3cjdyZG83V3JpTzVyTUIyenZZUVhsNXpOVlIyMm0xRnRS?=
 =?utf-8?B?QjhBaStGZ2dQdFEzWVJVVHUwcHVVMHp0VTVWQUNOVE14YUcyMjNLMlBRcy9s?=
 =?utf-8?B?UFBYOFRxUFJKVU9uTFVRMUNCVnh4ZGRSL3RqTFI1Q3lOOFloYm1tZjc2STNL?=
 =?utf-8?B?MUVoakk0SjNxcXZVSWc1OVBWSkhEUDIrSDI4MHlaMkloazBzYmtPUDVHVDJO?=
 =?utf-8?B?WDRleFEzUHlZdVpNNmRxT25rMkdoK0pwRmVqeEhsWjIrM05kMnRnRDZMOEFa?=
 =?utf-8?B?aFdhZXR0NnNQR1lKRTdTZENDd2h2TTcya3F6VER3clMvUXZXaW1GSFJSSGMv?=
 =?utf-8?B?VW1ZVDNxR2w4aTVaYzVvM2w0Q0E1VmpNck4yYmhOaVNVMGFTcm4zbmxoRlZi?=
 =?utf-8?B?OTBjVVdyL2wyOFFoT0owdjlFQ1pGSHRkWXI5RENOcDNBMTZlcmV6ekFYZU1i?=
 =?utf-8?B?K1ZoSm51V1BHMHJFYTBqNU4ydkFNcy9LRndIc3hEVGNCSkI0UktBK1drV0Ri?=
 =?utf-8?B?ZkxESTBldkM2bkNhckRFeGYwQzlzVklZOW5BNGdiQjFTbERjNXd3RWhPR2tP?=
 =?utf-8?B?UkczcnNoQ3kwZUd4NkpuZUNSVTVGTUM5Vkwrc0tNVjVBeWp6d1lrWGwrM3hv?=
 =?utf-8?B?M09IZHhrYzR4NnVCWmVlcXR4VXFPekdWYUtFUHJSZkdHVnpBY0RDdVZtUStE?=
 =?utf-8?B?SFpGZml5T2R5ZFFOWmRqdjd6QSs3Vzk2TmdNdHRtT1NrMkQ3QzhXN0Nkb2RJ?=
 =?utf-8?B?MUVFUWhjcm96UGtZNHhtdm1tSUQ3QkRBUnFzckVmU0NDTG1QZTBQdDFEM0R4?=
 =?utf-8?B?VE1FeEhta0hIUTRESnZwSHQ5TWFMR0NlMmk5ZGI4MjdRNEtacWsrbGEweGh6?=
 =?utf-8?B?WW1DbE5oM2Z1Um1uc1BoR0sybWhFb0FDdWRETnNDd09DSlZ5Zm1QeS96dmUv?=
 =?utf-8?B?bmRiTVhybkk1TDJHdENFWVBrUFJRY2VLWXZGNFVBSkdjT2JpSlB1cGRjV3RN?=
 =?utf-8?B?SlBRSVB2eXp2WHJ4SXc4THQ0ejdkTXkvTE1nbWFlWTlIbmk4MlNDSDBLdHpC?=
 =?utf-8?B?MDE0cys1VGRrM0pOU3lUZEwyM20wWGRITUQ1L0pRc1FGUERLNkpwYWtvTWNZ?=
 =?utf-8?B?VHpDemt3dXo4Y0lITWlBdTQxWVlqV3J5WllQMVFRUXhZV2dCN0tXeDVqMy9k?=
 =?utf-8?B?TDFXS2gyRFZlNklkc2lhdVV4SCsxOGlIdzhOZmpHVy9zZGIwMXZud2VCeTVQ?=
 =?utf-8?B?elNDazI1K0w0K0NxUng2aExRU3dpYXpjbk1sUzRsVjA4cGU4dmdOK3MrUzND?=
 =?utf-8?B?L1B4bWRXZE9iVndOd0ZoaWk5ZTloMkRWNFBxT0R2aE1HOHVzMlhhYktLQWdY?=
 =?utf-8?B?Vk54cTZwb1FDQW5LQ2hSMUExNW9WU0JMSjVKd0JiamdaakRoZGZnTXphUE15?=
 =?utf-8?B?NUFvaS9RWENEZEYyVFBCV1J1TndpQVhTQUMvQ2FEaGJjMC9FOEZPbUh3Tkto?=
 =?utf-8?B?OUZUZVBzUStUWG00OVN1TW1XcDZBQ2M3SGJRRmVXdFpLd1NEUkxwSTFJRy9Q?=
 =?utf-8?B?dnY5djZvQWh2NnJ4VDk2aEtwT2J3YlorbnYrWDRVTVltQmJzN0pBNzN1RkZU?=
 =?utf-8?B?UldaclNhV1FWNXJpQ0p5WEZoVjhlOHo4SVRhNlp5dXlTSjR0MTlTRVNEZVVw?=
 =?utf-8?B?T25CUjJRNkZnTC9RTk1vdW5zT3cxVHlzbGVKeGlOZ1kyaSt6cEE5TDNlcS83?=
 =?utf-8?B?ZmZzamVKYjBnSmk0YmkwSHhVc0RWeE9wTWdtNUhJc0R4eTkzOVNqUktXNXBj?=
 =?utf-8?B?ZnpjT0YxNC9OaTN2SzI1WEg3bit2UTlsdlYxZVdyZGhyT2RHL2t4UU9qbFNk?=
 =?utf-8?B?M1ErNUR3cEtqTVdiengzTENTTTRRM3c4R0NZYnd3R0M0cUFaOHlGV09TRE53?=
 =?utf-8?B?WGw4Y0dzc1RYMXZLRmRIZm5IS0ZjaVI0NlFIZDdDaWNjVzBXM3NXY20vTGxL?=
 =?utf-8?B?a3NMR1V4UlBUaDU3ZWxwUWdyZE0rS3ByTzlCajZqS3BKblZiT0cvNmdmc1la?=
 =?utf-8?B?MEtyOUJpUDJHeFNwd3A3ZXVseWYrSkVtS1FTSG5TaWJrQzBDQ09yM0dUUS9q?=
 =?utf-8?B?ajg4NGtjQ0MxcUVob3llbkVwZ2U5MGcvS0ZoYWtLeEg4TzdxNG5UbXBzOUI5?=
 =?utf-8?B?NjIxdzBzMWt1SE9PQU9LYWM2Vk5hQzZmMDZLcTVZR1A4dkVaK2hidz09?=
X-Exchange-RoutingPolicyChecked:
	yUGeFwYUAXQzNnCDxJ4h3S3zXEytsoPdsHdtT7lSayOEGo+2gmByqB6yFJPgCRL/pYZN04sdO/b+EzHIlOH/yfPwPwoIZSpTSeZMMWkTdmiPT9QrbyjV7aI0aks5dl+tn5EKefzicQqbxM1vCyklOvNbALy2P094jJJSpFIcpfJeUa9zSxYqZHKA0YmWbgv01MwAEkULx5/WnqCrn0GBLXiyEdBgp1DQgQiW+u0yKvmo6CnbSvNsqqKiGOWA0Jvj48wMQN5JT8p2bm8UT3QHQssGWL4dLbJQhk+vO6Zv+/lGwphVZEfT+xUKhcAUm9wrun65kC5tkccvnwi0P3J+nA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fac5df-c273-4e67-14da-08df2a13ced1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:27.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UhMRo5fGn10G9S/JpFRAjYM5L9vWUrEwfhOrR7ws/Tmszj+bpMSfj1p6+te1UL0oB5DaSq19N0iH3dtlQJ/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX9rIgwP+5GJMu
 tXVF9uvrkykAQqte/YhiQKHJRzfpkY5bF9GuUJutE9Hsr7YbIcTlDs6ELaRPePlEUcuGWcztQiU
 vdHosMYJp1jBgGro3JjIu/13FVWfttqVCMFeHHQXs95jlSxzOpzvTxOAltusRSSlkWxyNxuhKND
 TEA32xY1UxTf8j7IWipOB4oz8WrsksGquM1rwggRrn9crs9/g4DW0GQAJCWQwl9WjbWHIMHIkGu
 pn3PTLsRYmqp0951aSZha9dmJuww16GxhmZCuaxQajqxHlsE/cIdkXxCRn9gf3cmRs8QZ24QVI2
 RT2w9rafOGyZ9f/k5kPZJD0wMxEAs5LYYSGxgDA8ABNIwsulehEXMtkUTzikWEdgc9qg9EkJiJ8
 QvoDY3qFsRdyQuyrqIfxr56d7vY97+YTYsJ0KooFF6HXdyfDTXDGqORNvBsnvW4dZOKfXt9lhjj
 GJcO7ohwqTeu80Qhujg==
X-Proofpoint-GUID: paPlQpL09Hhn1z71mY5QQbpmv23qMquo
X-Authority-Analysis: v=2.4 cv=S7RMU4sP c=1 sm=1 tr=0 ts=6acfb3c5 cx=c_pps
 a=98eAHdF884nMI2WayFaxAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=8NmX7xMoxXs7GY5_H-gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: paPlQpL09Hhn1z71mY5QQbpmv23qMquo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX8T7dbrgLtZ73
 kwLjcr+yEDoF+n33JoymY44riM3KKUkgooP5zepun8HZjk8un/9eS/njkkTZJYieIKzu54HRT6K
 Z1X5kDYvzZ4IDCSQQNYQqdvaHwePbWGRCjvoGjP8ybkes0cNBWlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067

On Tue, 06 Oct 2026 15:17:37 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 85fa16321d74..3048e61a3cb1 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -80,12 +83,47 @@
> [ ... skip 18 lines ... ]
> +				  struct iio_chan_spec const *chan);
> +
> +static int ad4134_set_filter_type(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  unsigned int val);
> +

Please don't do the above. Arrange the code properly instead.

-- 
Nuno Sá <nuno.sa@analog.com>
