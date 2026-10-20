Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500085;
	b=mDobXbHbmVERX0kn3sIxHkAHWtLJeKWzWFMzODJavL7iTYXGzaDeix8CWdaNtWdeRUIr
	 PZjEqCZYquc2YdcwrdHRs90XmLExvoXtT1w+cMBBhas/nQnJmbJBN6v2apR8l14z63aXd
	 FVi6iBeTe6U24OUsd7ty96Uac/t615JOCIKXIZwfyg+lyVnjMhTrB9uRxNN6K910is/NY
	 LJxg+qSLxiXtRq1Pea3OzUpnEH4A3/5sCUCPzh45SxGVIb9uunzhhTpRv2tWt7996T7pQ
	 7zBeME9GzobL3j6NmQsaY65Og1nHEe0rVH6zMhwlt4ukv57PoFcPrNCxqh6gqu/ElDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500085;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fSFPWGELKZoGG9QisbQXK69UZMamS4wJ5b1xI0pHIN0=;
	b=IfE8Psk6pMkt7wPPwWFBKnAQof5XEWd8HT52HJ6dNBx2FONA0/EdS7AzQsb7ur3JHuqF
	 QhvE+e3gxB9P7FOeSGijO+lrA8qD12fYYHuo00JVZuncoUyeCXxsd6bVyW5HTRavju4zo
	 vYH1Xl0qL4gC1adz4e8Lnh53DGM3NveucGIMwaisHipZ08l3Qamrb3j96mvkxxEdCBjHz
	 AAhbvw0Aw/Grf7k5ZfoTwUDfECLBb+M5T53rX4iEaFcJIwQvbsP2iD4xZiIh/9PvNtzqh
	 5NWgMShsvHgfBU69aB03rCkc5u2s4KWZa60IQZtSUMLSdulXGUcekoCIJlaKXElLb/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tdk.com;
	spf=pass smtp.mailfrom=tdk.com;
	dkim=pass header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=EmCPI9hq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5D606A319;
	Tue, 20 Oct 2026 12:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E5D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=EmCPI9hq
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAcs0d2843508;
	Tue, 20 Oct 2026 12:41:01 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012032.outbound.protection.outlook.com [40.107.149.32])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4hdw50grsy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 12:41:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdnGlM/0jRq1PTF1oMmr2pJ8F+yX3cdbPSUtKwv2jfrRIzCKkh695/jcu4yuZyQ2JUofZiTclHgovNcMr+NICU2xB84nc9j6FsQaOPBnh5pR3uyEatPi6/Rp17RJ3ICIpqQ4S1jVpaFDoGoFhW1IlRDnWOfLzckvdaX53nfqCo1a4p+bbPv17WvJOBDJleJFCuQ2AapPKwYj/7BZT9yqSYJopqx+ivZQ6qXWoP/aISk2gtufdqwkuj8XylJH1jvoylTPKKhdeAvInHcRkTj0SgCC2V2/WNtlnf83qdbYWHkAMa7pTwmUULc4k+M/mwFheTNbqqU4hBD6zy0Ed9HhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSFPWGELKZoGG9QisbQXK69UZMamS4wJ5b1xI0pHIN0=;
 b=mwDk4kXPQL6D1d6uoNrTVSnM0RTQKMWYBmSbiaYOWqfcoeaeNYWhMgIgazHxYvF+6AxgZ7Av8w4rMZXkZvJ+HPzJpvZkWb3FQyoQeXHAFMeQNxEcTcknQkWWbc6sDFSqW0Mmhsii+JzQQJRiEGhkN700OgMDHmhcZuubWpKEhoNUXe9IQZe614Pr2UbMHMpx6Rt4jAp2LBUypRdm2QJtzTFUXAAN8vGPoWzY7spG78vezo4AwS5XJUuS417VPPg0Z25gHnSsT7povdAyrt6SKYOH7QMA9Y3xuOSuzelgJaQ+1IVBtD8xi6koOHk3/hjcN1OKtINqUKpG9psbYGi/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSFPWGELKZoGG9QisbQXK69UZMamS4wJ5b1xI0pHIN0=;
 b=EmCPI9hqPRIQ2Gr4b30kR+mHyAl6e8o7ZKjqqICrggS2H4PX1sJFCDEiKs0JSdhJGrJSCnn0C9GKzMEZIZpzhREq33dqcnxX/DrcGCHZZi6BahWg3WPBIlSFqFfeZSjKxbkgxPGzo28Ie6otZcYv7KYcFAbNStQ0Hwe3PHxJuqtmDoxTZ5HRKURQtjGM7RK7mwAwCy8oZOCRrAXBcfzjQzdL1dSa14OhA76yCx0EImYIkxZvx/IMft/L4nBo1HkNmDcAj2/Hmg56lMV+nfQKUsZHhjvQ2Ol6J+HARabl06qj/B8Rfu1G5ZYpbgSNDsxcmGHxEros6BK5MLelQ7JjKA==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BENP281MB6328.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:40:57 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 12:40:57 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: update gyro start and stop delay
Thread-Topic: [PATCH] iio: imu: inv_icm42600: update gyro start and stop delay
Thread-Index: AQHdYG7/Bt+d/fxZakagq8umvgRGPbcGIB4AgAA3f3c=
Date: Tue, 20 Oct 2026 12:40:57 +0000
Message-ID:
 <BE1P281MB142605780E1D5B1B051ED4A3CE672@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20261020-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com>
 <atcsENHqXSRvn7SU@ashevche-desk.local>
In-Reply-To: <atcsENHqXSRvn7SU@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BENP281MB6328:EE_
x-ms-office365-filtering-correlation-id: 6c14714d-dfb9-457c-5d7b-08df2ea76364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|10070799003|23010399003|376014|1800799024|6133799003|18002099003|22082099003|10067099003|3613699012|4143699003|261009223027099003|11063799006|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info:
 LKlStQqszHpC5UZE9M3xYij8SA5YPqt8Yn5pxdjOptfbatW22e39FY9uf95G/ZQ5hR4w39yGGQLL/cuYs4Iz9oPVBzAWR7XkKdySAiFjmihYnrZHXbfy2IbzUHVPb8zc/cqQ5HSuvkSsIgRj/DWJfDZOZF6JGI3gjjHtSaELZnxyyMS2+8pBMWn859eHm/4U0DuB0xGHakX8Ajyu0x/+Z31FEWwUbYk9EqrfqlZgYf62nI1KC0igX2TFAnhG2fxzaOCR/MBqW8fJv8wvUG6bzCpGjqiSFqVYFxMxTpOxqZ6ZqVjewCKfcaxOvGXNch9KAgOcm+fej4FMAY4qVyy9QMkaam7WuCh+IlmCstppMHRJderLxCucROkxfOLNZZA4/XmXSTthKu8Ke1AJUmgVYI2eV4gmCw589N4fapKeFHzUp0k2artXAnkRdxTHlCsBzR6g4iavUVC55VtbJ1bIRKPSnFWtkwgVwYXgeV0cNu7WJdyd4Qu4H3KcUGYld5NYIdDbRMR1Hq43lM2KNRHAEQ9prDhClTC5TE7CVouV9VMONlXOHluvXIWzjaCqW2RhhLBBaOqiPt7J7SFAnPiT+7gTmTbv0mHtwg4sWIbmYly0VNGTfOcEx+BRBDjL4KsG0jCiTo2oPrTvGEy060vad1gm+x8H1VICZGWY7TadCSJ7TkC5jZTqCrokDqq6ftnyl9x22R2qpBa+QuV2l2RYeoi9RMT2jHImsHy/VDu1HLOFUh4jVokG7fEyw7QxObVe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(3613699012)(4143699003)(261009223027099003)(11063799006)(5023799004)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3ZYU0tTQjNkNFFTWGp0SjlxUGVDeVV0SkFaQURXYkZFb2FPUi8vNVBHS2ty?=
 =?utf-8?B?VVV5NDRJa0RYSFBSSFdTTVo0cDZ2OWtueGR4NmIwbHpNNnhpeU1GSVJCMGdm?=
 =?utf-8?B?L1V2RGRkejEwUXNjdzVxUG96MXdid3pCRk1xNTNyZEF1SHV0SERLL0szck5P?=
 =?utf-8?B?QzlJN2gyZS9DVHZwc0lLekhNcVRnWDg0QUxMbXpSYkN6VHVYa2RiblJjeDF3?=
 =?utf-8?B?VFRtWThianBLSXRVVmV3VisvM1hKa2FMbjhyb05XRDgvRWxOLzZyR2RwSDRY?=
 =?utf-8?B?dnZpZHZsUlFHTzRiSVRYczVIQnlmUHZsQ1ZHQStQaDYxa1JBWjU3ZmREWk1o?=
 =?utf-8?B?UE1EQVhQTnhYWnh0dFhHNHA4bm05R1VCNWs4c1F4MGVlREc5enoxOTlhcmNs?=
 =?utf-8?B?TzlEY1N6UjJGTjIxN3o1Yk9FZWNIWkhqMHBFSjlGSXVvZHFncVFZYUpNSG1K?=
 =?utf-8?B?ZzcrSHlyU0FBMzN0M3VWeUV6SWpaUk4rZXJ1NW1IakwzQ0UvNVVFVjRNek5H?=
 =?utf-8?B?eitIRm9MTzFrS1QrOXhSd3NOTGVvb1VmUXVwZ2NxemZSeVBUdE9IVU1ncE5F?=
 =?utf-8?B?WHBLQzR3NXZCWHpPdkIxOEdmZittcEJGbS8yYmdHOXkyY2ZvU3RIYzFyUlNM?=
 =?utf-8?B?WkkxVW5iYTNXQVM5eG1CWnZnakJtaFlLT28rbEREZFh2RmJsa2ZiU3dBaXNs?=
 =?utf-8?B?cTFOYU82VncxSXFPd2U4LzZrTVpqN05Ra0xjL1dzN2dNWnpHMjNLMHFvdzFC?=
 =?utf-8?B?RWttU3V5S1hldHZKSW5sYTZwRHRvUWJkTWt3anRMdmNROGRRbFEwSDV5YWxO?=
 =?utf-8?B?Q0N1U3Y1OTgzZkdNVTRCRHp4YjhqWHJzR0dERVNadjR0OEhROS9PRnNvckNE?=
 =?utf-8?B?Z0hFemNwV1gvUktURUNDNjQvQ2pCa2xWNWFZR1JvemwzQTdLNTE0NXVYam4z?=
 =?utf-8?B?U3JPRFJRR045VTJpYnpIV2tTQTc5OUdSaDhlQTVoWVBPMDBwUjhVRmRpbkJq?=
 =?utf-8?B?MmthcWtuNGlPSDR1ZGNQWEMyMWZvMWxqNFMxajdaNW85dlVCQU9hd2NQM2Zx?=
 =?utf-8?B?Z1lDS1ZwblVxUUxaVyswU2Z4aHNMVC9rWDBpUElHQjU0SHFYeUNQN3RkUzBn?=
 =?utf-8?B?dkc1MzZoZm9wVytPMXBhRy9LRmhQTjJab21qZHoraWhzQ0g4c25GSGJVNGpv?=
 =?utf-8?B?M1lybXlqVFNRRzRpUHNjNTNNb0FKcTlxTkdYWld2MUxZaVdtSDNYUTc0K0dS?=
 =?utf-8?B?ZXFoNTlJVXRQcnhqME9KRG5yWkRiblNVZ2txVGhyRDVSYTJDcVlNZUFzeDVo?=
 =?utf-8?B?Ky8xRUpyVENaMzJMWHVNS2wxOUV2TzFhdGJndEhZZUlhcGtEdjc4dVNMeklW?=
 =?utf-8?B?Y0psZjd0U0R6dlVOY2dqWWwxeDZ0S05lZFpXSFFaWmp2T2NpVENVYmRJWk9P?=
 =?utf-8?B?a3RyU0pQMklXOFVDalF5SnB2Mm4wS0x4R3UwQ3htdHlSYVBRblV3aVo2MlhQ?=
 =?utf-8?B?UVpVMVlObnZ2MUZUZFVYcHVxSzhSb0NwSU9LZVg2bjlQNDdoZ1N2MzJIMEll?=
 =?utf-8?B?NUhWaWcyZDdMY05CUWlRdE0xVVVrNmpabXoyOGN0NDBlNnYydTc5YS9rN1I3?=
 =?utf-8?B?VXpoaGlXaTZUc3RLU05ZVVJvWmdHaTM4K2JuV0kyY0xzSVhFSXVHVHZYOC84?=
 =?utf-8?B?bjEwemRKQ25qNVhvckdjaWNla2NVbDRlYUJ0dmpjVEJ0cG5jemhRajBtUHB6?=
 =?utf-8?B?eTNKdUJBTVAyZGlxdGQzdHZzVGRSYUVlcS9nY3RteHdteDZQaWp6TWVIMGxU?=
 =?utf-8?B?T2lGb0NTMG9FMnFKVEYxRjRmeUZ3SWN2bFc3ME5KZXNPNTh5dytJaDFKOFll?=
 =?utf-8?B?TlMwWlRla0tGNm8vb1dHTEp1TnRaQUhCN2ZRWFF2UTltbzFzY2hLSUM5NGNi?=
 =?utf-8?B?Y2VNbXpYSTZWSEppeG5aNFo5dzlSSFJoR3VvNG9McXVzdkpYd3p0T3BkQ3RS?=
 =?utf-8?B?dyt1YmNKSWF6SHEyY043K1V6MElyVWpncm8zTUJlckwxRnArcTlIak1kTnYw?=
 =?utf-8?B?bHBoWmpiVzFUM1M2a2FXSkc3TkRabWxFN3pwcS9aZ09tY2dDbWVnM2Rvc2Vh?=
 =?utf-8?B?VTNvT0h3Mm9mR3g5VkZSc0Y1L2x5S2NJRUsrTGFyWWdScnFQVHZidFU3MXRW?=
 =?utf-8?B?YXZMbE9wUkFLZ0RTMEJHenZOeEdmdXYzYkJkV1JMVGI1YXYxanEvTWNzUzZl?=
 =?utf-8?B?aUNoQkk3QTFwaHgwRWxUUkVUeXM4Q0dwM1JxVWhrVUVqUXNtckpvY0ZxamZF?=
 =?utf-8?B?RXh5M2M2ckhaNzdXcVRUTDI1ckszTlJlc0h6bmd6QVpkK3dUWkRORGlPY1E5?=
 =?utf-8?Q?5d5e2HXf0S9XQa6j+l63dQKE/fYeq7/L7n/Vh2+V6Wdwj?=
x-ms-exchange-antispam-messagedata-1: F4fb4j3hw6jmAqKHu3aGn7ACpE7lOPBpS/w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LZctT4hRnUW/JJIaGJ6WSURMRED23H2k1lWICyyExaj1NLaszy7QldHiVqXF/8VrdfS2a6GIigDFwmSInZomSGOJlU3pq8dnUHNfGksIl5m2YxiSvz0hlj/Fjy7cUgrrnqouKJC7RID8KuIvYR4pvhXjC13Z+zWTCmj0A/gtdM9Bdo3IAzAsM/LIRh2RZJ1qTvgR9Sq1WDEcb8Xg3x5B27PW/8qvec4rqNoM0jokreVInXCs9qLzkUu8N104MBGGkBjemoD9e8m4eoxHIO37cXYFQRKmi9/qx93N/cLnWN9hrsk7x2OsKWNUPuEn2nUP726OY+/xUNyo2Ao7b+CDoA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c14714d-dfb9-457c-5d7b-08df2ea76364
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 12:40:57.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTyQ5LKjVxv1G3du6VY/QVNeE4/q80lhqZKQoaWqY92QCSHj4byfl4hZqMlMlm6kMzGaq/cy0ovrPzaPEHuy6ZbGjjI5/ws3e+2Zd6B6ZzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BENP281MB6328
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX1qBxl55syFSb
 Sd/YD5NRVoKcGgDhJjBVI53C9GK/HeoHfQYrizNmEs75W+QJEqUJkjxYVwkGR5SMho714PlMm4P
 JIaJg/1tohHSfYntRvAcYmb8eajJzoyK2HJM10/+M5R9MMJBF4QK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX1HGjp6jGSzWL
 QQ/4N7lIYPDUj9i4TgW4CrXiSHwS9Fef1mS0cMUFQCItFr1O5wy915TDH8AryHnyi/GNUrih9uE
 Rlx2NzjAzFDfIPinNx5fJTf3q0PXSHQnNU7gTP2zwbK8oBY3Y3nB2e3HTZe361CRM4ebqA4SH6i
 CwHs/xYRk5uoLFCbJctD8KOAWozCvWDSsSbT+63tuv5/3rN07MxxoY4rZyeRW7f307us+V3eeqe
 QAnLdGPUKeji0LVV8TySbqLwmSTcRIwzCxsYI384Y59ODhfotigGjGAO0LljxELSy0X6rmlnQbT
 C8bSZQvagb+0rajTOkzUyfkmqkqyBxkMfoLBpO7NV7vLNdbvluhwNE4vz80AqYZrHbz8AebKLXx
 r0QS3T24Wzn9MfLao6lMtcbUI2Ztcl66cwISx/lodu53OfwdPDcJAD524kbVULIxD8UTCmezHdp
 9dtbc+s0xNm0Fwlu6CA==
X-Proofpoint-GUID: wt5mXFqxASlvGdJzRdkQeDAC-3gK9V01
X-Proofpoint-ORIG-GUID: wt5mXFqxASlvGdJzRdkQeDAC-3gK9V01
X-Authority-Analysis: v=2.4 cv=Zb6IpcVA c=1 sm=1 tr=0 ts=6ad7615d cx=c_pps
 a=2XmeY+fgDybwNESE/WdNKw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=uT1ErlhNRyOjhpPCFEkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200050

Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPkZyb206IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPgo+U2VudDogVHVlc2RheSwgT2N0
b2JlciAyMCwgMjAyNiAxMDo1Mwo+VG86IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wKPkNjOiBKb25h
dGhhbiBDYW1lcm9uOyBEYXZpZCBMZWNobmVyOyBOdW5vIFPDoTsgQW5keSBTaGV2Y2hlbmtvOyBs
aW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj5T
dWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGltdTogaW52X2ljbTQyNjAwOiB1cGRhdGUgZ3lybyBz
dGFydCBhbmQgc3RvcCBkZWxheQo+Cj5PbiBUdWUsIE9jdCAyMCwgMjAyNiBhdCAxMDrigIo0Mjri
gIozMEFNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSB3cm90ZTog
PiBGb2xsb3dpbmcgZGF0YXNoZWV0IGd5cm9zY29wZSBzcGVjaWZpY2F0aW9ucywgdGhlIG1heGlt
dW0gc3RhcnQgdGltZSBXaGF0IGRhdGFzaGVldD8gV2hhdCBzcGVjaWZpY2F0aW9ucz8gUGxlYXNl
LCBiZSBtb3JlIHByZWNpc2UgdG8gcmVmZXIgdGhlIERhdGFzaGVldAo+WmpRY21RUllGcGZwdEJh
bm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIKPlRoaXMg
bWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4KPgo+WmpRY21RUllG
cGZwdEJhbm5lckVuZAo+Cj5PbiBUdWUsIE9jdCAyMCwgMjAyNiBhdCAxMDo0MjozMEFNICswMjAw
LCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSB3cm90ZToKPgo+PiBGb2xsb3dp
bmcgZGF0YXNoZWV0IGd5cm9zY29wZSBzcGVjaWZpY2F0aW9ucywgdGhlIG1heGltdW0gc3RhcnQg
dGltZQo+Cj5XaGF0IGRhdGFzaGVldD8gV2hhdCBzcGVjaWZpY2F0aW9ucz8gUGxlYXNlLCBiZSBt
b3JlIHByZWNpc2UgdG8gcmVmZXIgdGhlCj5EYXRhc2hlZXQgbmFtZSwgdmVyc2lvbiwgY2hhcHRl
ciwgc2VjdGlvbiwgZXQgY2V0ZXJhLgoKSGVsbG8gQW5keSwKCkkgd2lsbCBhZGQgdGhlIHJlZmVy
ZW5jZS4KCj4KPj4gZm9yIGd5cm9zY29wZSBpcyA0NW1zLiBTdG9wIHRpbWUgaXMgcmVxdWlyZWQg
Zm9yIGxldHRpbmcgZ3lyb3Njb3BlCj4+IG1lY2hhbmljYWwgc3RydWN0dXJlIHNldHRsZSBkb3du
IGJlZm9yZSBlbmFibGluZyBpdCBiYWNrLiA1MG1zIGlzIGEKPj4gc3VmZmljaWVudCB2YWx1ZSBm
b3IgdGhhdC4KPj4KPj4gVXBkYXRlIHZhbHVlcyB0byB0aGVzZSBudW1iZXJzLgo+Cj5EbyB3ZSBu
ZWVkIGEgRml4ZXMgdGFnPwoKSSBkb24ndCB0aGluayBzbywgc2luY2UgaXQgaXMgbm90IGEgYnVn
IGZpeCBidXQgYW4gZW5oYW5jZW1lbnQuIEl0IHdhcwp3b3JraW5nIGNvcnJlY3RseSBiZWZvcmUs
IGV2ZW4gaWYgaXQgd2FzIHdhaXRpbmcgdG9vIG11Y2ggZm9yIG5vdGhpbmcuCgo+Cj4tLQo+V2l0
aCBCZXN0IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVua28KPgoKVGhhbmtzLApKQg==
