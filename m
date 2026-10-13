Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00833905F0;
	Tue, 13 Oct 2026 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877383; cv=fail; b=OcXEFnPRVAt22/ODLoeq1Ln28RWLgvPETene60dSWk8nNT+PKTwMNut1lnXy+IFmtTLNVa+zcleWyt1GFICvOrk8g//MWM3RsBj+R/JKYHmkPyXgKVkcucX7zQLXrRQKu65mJ1FKolkOcZ/jJML3GWkaLZZL0CW8AYxr+8EA5nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877383; c=relaxed/simple;
	bh=Y4DmfLClCGIogxExyKsviSYorXIlkj/bDP6KGlAYbuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bFOCCoAZqHC8jKy4MqZ7Og2MJNVPgUCv8xe4jo2CRQewz6f1ygjhXM0FJGLCFAcnIN6cIsptPYC/9YFm8XwoDgGfaoNnFpfVz3V20gPpCe11KRNi18i7kOMiNApoML+0zYJpMhF1GeVdyfLWjdkdzxhw6/gPKA1mtjsloFEOkDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=p1YLIONz; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="p1YLIONz"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D23tc9294298;
	Tue, 13 Oct 2026 07:42:53 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010047.outbound.protection.outlook.com [52.101.169.47])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4h7bqv2dtj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 07:42:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVWe4tuDHhjh4O0Cf7QBR8aVyzq3+zDeIk3i5hL935OrZTQvYhtjU8HsibSKgFkFPs42GAk4JaMCkgBhrZfC3fa8kNtfQBUgI42qOi1wj2Y/ICnT8UKYFBpiHbk0xSUVvMT0qe8sn4ULiTlApyHDJ7cf+TSTzk1MF+maBlcDhXRU0erjenDe+dsRxLVztoIHr90r9LsiWF10Z+xCBVrlhaeuvqB5JQ0/PXz938Lyf6vk5I6bLwja+swOyP+R3Rw7hw46bi5n8aSEMRVCobWmshJr+quyXwBFAnYtmY4jXWFoU9F0FpXk7Izt83uWOx1Z6j+A7NCHJJfyjseCNFyXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4DmfLClCGIogxExyKsviSYorXIlkj/bDP6KGlAYbuw=;
 b=DfqQLVZZTxRWQ/by0ET1Vf91+mVoQVsMpCsqGNyzZXs0k7RDHvehxtvNcUTD41gflk+1Wdgb/Zts3ItwNVr/7XhvnYqYrfVdQXT+wmjvm5S7k+6rMHaXkV0URV2FE6EW60ZxATxMVy3HfP4s47BzoJsqgh7n6+VNhVvC+iCWWSdaOIAMpk1Uq23aEgT1YtQRYBwG9nTb22QXjqofbC0d7CeTPJMjciGDzosD5MciAlrQsoncXpfRwpQC9/J2xUTXM2BiLH7sCawFEfmRUjmjKAaLPxngYvLcGPa8AdF0HZ7egrp7fnw9YDnsTwNn0YwQq9raig4ZU7cnwJoZlW2TMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4DmfLClCGIogxExyKsviSYorXIlkj/bDP6KGlAYbuw=;
 b=p1YLIONzIf1/9M1Ct9YdqE96Z19bXGp2acRGoO/NEW4JWZ5NAJ1UEEUH4t60Qs4pLmoc85U5WBPx45qOrO5MLyeqtnMOKxM8pMLrGZggXVEj0UVDCDlIPqjI9Fk1STzbOHivLaNvt8Hw1C9+lM2zcXoHxJgenI3ddkcJSVS7li7odNgn4cJDPCVFZwzlkz/1sPzBwrBb/x+BskzSvb8uP86ImgdH4Bn5Vcu0SkfNXf/GSk6bm7bMZWzR+sZ7jb1/UtOhu4d8TLkNQ+X8pjkqt2LjABy9MHCGW1u8U4GfrZvD2UyWYVLakxHK2304B8PXUFYPUwC5zIYZiceA61LkOg==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR3P281MB3392.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 07:42:41 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:42:41 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Kanak Shilledar <Kanak.Shilledar@axis.com>,
        "andy@kernel.org"
	<andy@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, Kernel
	<Kernel@axis.com>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "joshua.crofts1@gmail.com"
	<joshua.crofts1@gmail.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "dlechner@baylibre.com"
	<dlechner@baylibre.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        Henrik Grimler <Henrik.Grimler@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Thread-Topic: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Thread-Index: AQHdV/ikjv2n8avdwkmZ+c18V9fkHrb5n9KAgAAdJoCAAAEEgIAAvSYAgACgjYk=
Date: Tue, 13 Oct 2026 07:42:41 +0000
Message-ID:
 <BE1P281MB142642474354814F0785CB97CE9E2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
 <20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>
 <20261012-adventurous-corgi-of-fury-01219b@quoll>
 <fd4181c7e2f48e3c64530340ae1a02adde1f342e.camel@axis.com>
 <da8b6047-419b-4c3d-8416-e5c871ea4dec@kernel.org>
 <as1ZPOocclBgYkko@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <as1ZPOocclBgYkko@debian-BULLSEYE-live-builder-AMD64>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR3P281MB3392:EE_
x-ms-office365-filtering-correlation-id: c9d60ccb-636e-42ae-b667-08df28fd8fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|23010399003|38070700021|56012099006|4143699003|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 pKZliTeAJmRWa58zmzPWkcj88cz2xtgY2jz1XZe2cwjsRueCTY7OuMnjT+NyZpx+cqiQfX1UuUd3h9qUP6/tCbG8WNPIo1sqbP0xvk6WsVA1uKvfKkCxGe1v8uG4/3bD9JYvRFgbbLIm5K8JjG4FuqidkIf+BCf6R73IWmMAKas+VjORfCpB6VPQ9YyHXjDo19qR2coY5KjPomrpkdCGtQ3y6TxiiHxsabnPaFqrHAsiu8o+zWgVDtjOCyd7ZVTC81Fwrm02Qgke/efwJNzFCyyGw4fYPxiWvpDbivrf3AsK5YUv2Q2Z+zoeK9lPKyCFg70uieqaeFaVeCahKVLy9PIUq4fgVtHNgQ0xtUY/q6pKzJxp5hgmQ29Uqy5nmj+utY+iacOq1ej1yytYfLVv3kc7yNzT0zToBolDsCErcyvRx/wfjwL3GDwtu5t5LlKD1T9jw0STrvODP/DktNkF9JNUQIwisvukj0jlm6ChJgSqjN9fUnqg80+quU2EpuoQvELqfTd+TEVCrOVmRf+XvU9TeGK16PWrcFIju0//pzYdo6zRDbhDX2XBuIRicevkk+wGSo1TtHjkxjiKXGvGrLqLQsnUO503x7Pci9q7AANLitUkhb7Uf+S5V0DLQan6ZEK9umG7Gbi0KyZHSOh6uu4qVzw4XdFIi4b66P7E5kBvUcM44h0rU59vvs96TJk1ncym8z2txKHKFRikL7s7PQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(23010399003)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXJreittZ0FHV0o1ckZXYXhJWXEyVEJmSGF0Vmg3cXBDQnhRZUd6cWQ0VWYr?=
 =?utf-8?B?K3I5MGtQL242cXZxY0FnSlpta0o4aFhvMmZTOGY3RVFmbGdjR1pEcTdFZHBL?=
 =?utf-8?B?QTlkT1pEU1pWaUd2NTFNaVB0THl3TmJVV0lNSXlFUFJOUFFyOGZHQTdqTlB0?=
 =?utf-8?B?dkRKejJvek4xRDBwRDYvL2ZuemJIVTdBaENlSmhIeHFDZ0ljVVNBYm5jRzZ0?=
 =?utf-8?B?WnJqQW5FLzYrSC9MUGUrTmtuV01USGFQUnYyVE1CTTlMYW9sTFQ5SEMzeHkw?=
 =?utf-8?B?cDk3TnFJNzJqdGhJdnFCMzVoOUV2NWdzZUVJUFZZdnNNbFVRcG5sVFhCQWRP?=
 =?utf-8?B?Vmk0RmFOdDlaSWNxa2ZJei95US9lVUpLdDVyMVROSVRMelFYbXplMFJYU0hW?=
 =?utf-8?B?aEZDTno3Z2JiYjE1ZDI1Z1o1TVZWQmhzUmNPcVRTWlExa1Q1UzNlUm5ROUcr?=
 =?utf-8?B?UTVwNkhvSzQ3RzJBdzl2TFFkSmZyV0tRUWh2MFlqaG5sdm5UZitMYmxua3Fz?=
 =?utf-8?B?Q3FyWXZLUVd1dWlpQU05aUQ1MVVsaXBtd2xOaDh6ODdRMkQySnJ4QXVxR20y?=
 =?utf-8?B?MGhtMDhzZ21XMFhYeVEybnBoVzVvdGlJR0pWV3hZVkxNMWJ4RHZucGhXS2Rn?=
 =?utf-8?B?dHNnNjFuaUhVcm9DcDgxTGRNZDg4S2l4T2w2dE4wTXhQKzRSOW5RMFlKSWxm?=
 =?utf-8?B?c1pJWWZJR0JyMFZlclRuVnZ5a3d5WEhtNWZVaGNzSmsyQTNXRzZzcGQxM2Vt?=
 =?utf-8?B?eFIydUljVTNVa05XK2hsMDBGSGcxS3dvRGIxSFZBWXQyb3NmY282Y3ZmTmFH?=
 =?utf-8?B?SGlZTG42cXZhT1Fhd1VjdDNLbU9uS0pMSlhRTklyZGd3Rkh1eXFpR2R3R1FU?=
 =?utf-8?B?N2xnNjViRGlkdnRnWThwa2dOODQ1TlJ3MlNWblFFMHVjTDh2NGtQUWVRVCsw?=
 =?utf-8?B?TzF5RG9zeWs3Q2V0Wm9mcHZaL2lkUXJaREhaU1pPM0diWld0RXUwMC9FK0wr?=
 =?utf-8?B?UG1DdDVYY2Y5ek0rVk5GQjRzaUV2eitUM2taRkxSWGhuUjMwZ3FMWVJXM2cy?=
 =?utf-8?B?VkVnWVhTbjlVYTNiMk1BMTVTMnc2S2hnZThmOWFtaTBNSmVmQmpzeHIyUkJ5?=
 =?utf-8?B?bm5JTHM0aFVLZmxVcEt5dmFoZ0oxbWRsem1QbmxhNmJISWlrUHZjV0hKMXo3?=
 =?utf-8?B?YVpEVUt5Qm0wZ3JEbGRMcDZRVG1vakwwbXdUNWV5L0YvSFljY0R3WExZYnl0?=
 =?utf-8?B?SU10c3BOU2tWdW5jdk8xcVRzRXlXZWFXcTRYRFRON2hLWmJjb2FUYU9uMnZm?=
 =?utf-8?B?eGlBVkFlMzdkVEFEWjluRDhNY2xic2Nob1U1Nndic1VqSXZrM0FRRHBBT3BK?=
 =?utf-8?B?UUxpWkV3dmpyTW8wR0lMWGtQNXMrNVlhR09CdDg2eWdCRmc0SVh4ZXB3SU9O?=
 =?utf-8?B?N2xWWmFGY2xncmtpRHNiUnVFdzNoUHZ2a1ZYeXNhNGd4dndjNVFxc3M2U0VY?=
 =?utf-8?B?Vjk2czFncnY4SkNiMUVnRWJGa05ZK0V1eVh1SlAyWkFCbklySWljRWo1NW8r?=
 =?utf-8?B?UElHNGVESE9MT2tRZ2hnVVFSR0NGUWFHUWtmLzJ2Y2JyU1FFOE82UTUrT1Qr?=
 =?utf-8?B?MWIrNnlSMG1Xb1g5MjNNSk5GakVmUWxHL0owYStobnZrYTU3bStXdWNiNUFw?=
 =?utf-8?B?dmJvMDVQL2E1ZDVPY0hEakxQeC9KL0J5Q0hxcEszbzYzTGl3dDlVVEZsc09I?=
 =?utf-8?B?eHMvZkNvcVFsMVV3S2s5ZldlQjlwRVNKZVpTQ3NkaTVvckNmd09mcm5rSlcr?=
 =?utf-8?B?eEtpeWpHUGdPZmFOZXp0STRjRld0NytOdHNyZ0dCaWdYazFMdVc5YzNzZ3lI?=
 =?utf-8?B?bThPYWVGQ3RCN3JPSmJtRjR4UUNXeUQvdmxsNGQrZzZNc0huUGlHNFdaa1pn?=
 =?utf-8?B?aE0wNm45VGk3YXpzaWhaRnU0WnZZdlMwTWoyME5reDVERzdwaW5vQXJ4eSsr?=
 =?utf-8?B?cmFZR29BMURHYStFTXBLMTBab2ZsWjFGWVUrN0hMdzdwZFNFZlFMZU8yZEpv?=
 =?utf-8?B?d0l1RWtaUkdmMENxNlRjS0hmOUJScU5aQXh0ZS8yYU1icVZmMmdQZ0liaXF6?=
 =?utf-8?B?M0RNajl6RHFTOG1rUkQ1WDN6UUFIeFBmRlpGRVRzLzVBZ0tRblZuaDBwTzd0?=
 =?utf-8?B?bUtmSUwzN3A3WFlsbmpwSDc3bEZPZllhaXJqY0F4U2gxTFVhTUM0Mm96dXhY?=
 =?utf-8?B?cGhaWHpVRHp0K3ZWOG5TMlBRcWZybGFmOGg1TUlOQnF0QXNMVzJJZnFVRXU0?=
 =?utf-8?B?MC8wLzEvbU1XMnN5UWIwbDFWaVpzSDZqdGR0NzFka05tV2I5Y0JHNHNZUE9R?=
 =?utf-8?Q?Tld2dRUWLI5CbJn0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZRGtMpimCMmJ8IIwhMZbsTr58KmI7bURCgFuQJbvrRstdCb+gDTauf4Sl41C8ohpyw5E9y7alOZRK0awcBqFcGj7GGXsnJqA27vsYZhw5yO+VLwVmfWfFVg12/UICSo4dtXstpERp24VSmjBYhCv7wRHR6Zsev9gHEdwlNrV1bUFdI2Iy9bLvHJRvop2Ju0DFK9GF4JuJh1aN/Tjbp76c41TOj5HNmegBoRNU2zffGM+lRIryflRYTiTNBvngOmkll+QJVu/IA561QulucR9w7a/3kxJzXkc2KlNApsLqQ/NKG3uWDmMfxz1I7eseAqcogiAAqWH21Y4lM8R2pB1jQ==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d60ccb-636e-42ae-b667-08df28fd8fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 07:42:41.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBQ/20rjhQTneYTLY6tYF42UOGzexKJ4z1OBJWBmD7+CN5JjgCDrzJe6mXUkmwlSIL19sjWgUG0YN50vDwegcJ4ubC/unS6Vqi3lMFgeBZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3392
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: PSxognYYVwkz5agc--cKi-3FWjW-Ygvq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMCBTYWx0ZWRfX2DWbqAEgSTKB
 7zvijUVJCbIR1gTSbYL2qR00sCmU1xOKwWhLIP6F5Nsnb+n7iGnhY+k7Hw4Nmd0VNMSgusjf+86
 4GcB9gJoixjrKevU7UBKuPxk3bin0t7g50bVy5nAbCfbzlSV+KH6
X-Authority-Analysis: v=2.4 cv=GaKCDgXL c=1 sm=1 tr=0 ts=6acde0fc cx=c_pps
 a=RNFkkOVA3H3DthV/4dsEeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=69EAbJreAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=jt6KbNtKC8lqyKUWmHoA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: BoAHfUQNCmENF5F7HJ6vxghzrd9qqkFM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMCBTYWx0ZWRfXz8HN6Yezwpm5
 99mgkg4QCXbaJQuUq7qIoGnZO91G9ISnZqNUaF0h5JZhorGmPMsce0il7oPjJhNEyz9xsFAQSH2
 6RHMG5kTliRyiKN9JoZ7XrhW9c9RncjfneB/pz1KIArhyPTibJwRPoQ7/S8hm2iFTeZhV/j1KdU
 ZPNmu04371mBWSKZbB7mMexzXDix0YcCda0W5m91M8/0jPBdFKeRogifDa2TNxMEBBgbznCGtNO
 NzBQL9NLNu+ca+0yMQDBZXBKWPbDe4sVyU0poGgrnLeBIcMAWR08Ez9rGmluqg857IIevJHoWyM
 xHPk3Treck31KonIL/+u7T+E7qnwsjQYFuUD5sM5T+9NbnLKMsOqsapgTFpVbNtpOpW2qa1qGSQ
 Ny5rKsDvtc/YdLRKxnRnTKFuKOTrn4dbM55RGUOzHq2b6qZE0GBQHen7pYoY15XqRJrAqNNzGBJ
 pFN/0WAlsCBkTC1oAvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130030

Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPkZyb206IE1hcmNlbG8g
U2NobWl0dCA8bWFyY2Vsby5zY2htaXR0MUBnbWFpbC5jb20+Cj5TZW50OiBUdWVzZGF5LCBPY3Rv
YmVyIDEzLCAyMDI2IDAwOjAzCj5UbzogS3J6eXN6dG9mIEtvemxvd3NraQo+Q2M6IEthbmFrIFNo
aWxsZWRhcjsgYW5keUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IEtlcm5lbDsgbWFjcm9t
b3JnYW5AaG90bWFpbC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNvbm9yK2R0
QGtlcm5lbC5vcmc7IGpvc2h1YS5jcm9mdHMxQGdtYWlsLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IEplYW4tQmFwdGlzdGUgTWFuZXlyb2w7IGRsZWNobmVyQGJheWxpYnJlLmNvbTsg
bnVuby5zYUBhbmFsb2cuY29tOyBrcnprK2R0QGtlcm5lbC5vcmc7IGppYzIzQGtlcm5lbC5vcmc7
IEhlbnJpayBHcmltbGVyOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnCj5TdWJqZWN0OiBSZTog
W1BBVENIIHY2IDEvNl0gZHQtYmluZGluZ3M6IGlpbzogaW11OiBpY200MjYwMDogQWRkIElDTS00
MjY3MC1QCj4KPkhpIEtyenlzenRvZiwgT24gMTAvMTIsIEtyenlzenRvZiBLb3psb3dza2kgd3Jv
dGU6ID4gT24gMTIvMTAvMjAyNiAxMjrigIo0MywgS2FuYWsgU2hpbGxlZGFyIHdyb3RlOiA+ID4g
SGkgS3J6eXN0enRvZiwgPiA+ID4gPiBPbiBNb24sIDIwMjYtMTAtMTIgYXQgMTA64oCKNTggKzAy
MDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6ID4gPj4gT24gRnJpLCBPY3QgMDksIDIwMjYK
PlpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJu
YWwgU2VuZGVyCj5UaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRp
b24uCj4KPlpqUWNtUVJZRnBmcHRCYW5uZXJFbmQKPgo+SGkgS3J6eXN6dG9mLAo+Cj5PbiAxMC8x
MiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKPj4gT24gMTIvMTAvMjAyNiAxMjo0MywgS2Fu
YWsgU2hpbGxlZGFyIHdyb3RlOgo+PiA+IEhpIEtyenlzdHp0b2YsCj4+ID4KPj4gPiBPbiBNb24s
IDIwMjYtMTAtMTIgYXQgMTA6NTggKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6Cj4+
ID4+IE9uIEZyaSwgT2N0IDA5LCAyMDI2IGF0IDA0OjEyOjA2UE0gKzAyMDAsIEthbmFrIFNoaWxs
ZWRhciB3cm90ZToKPj4gPj4+ICAgIEl0IGhhcyBhIGNvbmZpZ3VyYWJsZSBob3N0IGludGVyZmFj
ZSB0aGF0IHN1cHBvcnRzIEkzQywgSTJDIGFuZAo+PiA+Pj4gU1BJIHNlcmlhbAo+PiA+Pj4gLSAg
Y29tbXVuaWNhdGlvbiwgZmVhdHVyZXMgYSAya0IgRklGTyBhbmQgMiBwcm9ncmFtbWFibGUgaW50
ZXJydXB0cwo+PiA+Pj4gd2l0aAo+PiA+Pj4gKyAgY29tbXVuaWNhdGlvbiwgZmVhdHVyZXMgdXAg
dG8gMi4yNWtCIEZJRk8gYW5kIDIgcHJvZ3JhbW1hYmxlCj4+ID4+PiBpbnRlcnJ1cHRzIHdpdGgK
Pj4gPj4+ICAgIHVsdHJhLWxvdy1wb3dlciB3YWtlLW9uLW1vdGlvbiBzdXBwb3J0IHRvIG1pbmlt
aXplIHN5c3RlbSBwb3dlcgo+PiA+Pj4gY29uc3VtcHRpb24uCj4+ID4+Pgo+PiA+Pj4gICAgT3Ro
ZXIgaW5kdXN0cnktbGVhZGluZyBmZWF0dXJlcyBpbmNsdWRlIEludmVuU2Vuc2Ugb24tY2hpcCBB
UEVYCj4+ID4+PiBNb3Rpb24KPj4gPj4+IEBAIC0yOCw2ICsyOSw3IEBAIHByb3BlcnRpZXM6Cj4+
ID4+PiAgICBjb21wYXRpYmxlOgo+PiA+Pj4gICAgICBvbmVPZjoKPj4gPj4+ICAgICAgICAtIGVu
dW06Cj4+ID4+PiArICAgICAgICAgIC0gaW52ZW5zZW5zZSxpY200MjM3MHAKPj4gPj4+ICAgICAg
ICAgICAgLSBpbnZlbnNlbnNlLGljbTQyNjAwCj4+ID4+PiAgICAgICAgICAgIC0gaW52ZW5zZW5z
ZSxpY200MjYwMgo+PiA+Pj4gICAgICAgICAgICAtIGludmVuc2Vuc2UsaWNtNDI2MDUKPj4gPj4K
Pj4gPj4gV2h5IGFyZW4ndCB0aGUgaW50ZXJydXB0cyByZXF1aXJlZD8KPj4gPgo+PiA+IFRoZSBp
bnRlcnJ1cHRzIGFyZSBvbmx5IHJlcXVpcmVkIGlmIHVzaW5nIHRoZSBkZXZpY2UgaXMgdXNlZCBp
bgo+PiA+IGJ1ZmZlcmVkIG1vZGUuIFdoaWNoIHdpbGwgYmUgYWRkZWQgbGF0ZXIgYW5kIHRoZSBk
dC1iaW5kaW5nIHdpbGwgYmUKPj4gPiB1cGRhdGVkIHdoZW4gdGhlIGJ1ZmZlciBzdXBwb3J0IGlz
IGFkZGVkLiBDdXJyZW50bHksIHRoZSBkZXZpY2Ugd29ya3MKPj4gPiB3aXRob3V0IGFueSBpbnRl
cnJ1cHRzLgo+PiA+Cj4+Cj4+IFRoYXQncyBtaXNsZWFkaW5nIG9yIGNvbmZ1c2luZy4gRWl0aGVy
IHRoZSBkZXZpY2Ugd29ya3Mgb3IgZG9lcyBub3QKPj4gd2l0aG91dCBpbnRlcnJ1cHQgaG9va2Vk
IHVwLiBDb25zdWx0IGhhcmR3YXJlIGRhdGFzaGVldCBpZiBpbiBkb3VidHMuCj4+Cj4+IERyaXZl
ciBzdXBwb3J0IGlzIGRpZmZlcmVudCB0aGluZyBoZXJlIGFuZCB5b3UgY2Fubm90IG1ha2UgaXQg
cmVxdWlyZWQKPj4gbGF0ZXIsIGJlY2F1c2UgdGhhdCB3b3VsZCBiZSB1bmp1c3RpZmllZCBBQkkg
YnJlYWsuCj4KPkkgbG9va2VkIGludG8gaWNtNDI2MDUgZGF0YSBzaGVldCBhbmQgc2F3IG5vIGNs
ZWFyIHN0YXRlbWVudCBhYm91dCB0aGUgaW50ZXJydXB0cwo+YmVpbmcgcmVxdWlyZWQuIFRoZSB0
aW1pbmcgZGlhZ3JhbXMgb25seSBzaG93IHByb3RvY29sIHNwZWNpZmljIGxpbmVzIGFuZCBpdAo+
bG9va3MgbGlrZSB0aGUgaW50ZXJydXB0IHNvdXJjZXMgY2FuIGV2ZW4gYmUgZGlzYWJsZWQgKG5v
dCByb3V0ZWQgb3V0IHRvIGFueQo+aW50ZXJydXB0IHBpbikuIE1heWJlIEknbSBtaXNzaW5nIHNv
bWV0aGluZyBhbmQgdGhlIGludGVycnVwdHMgYXJlIHJlcXVpcmVkIGZvcgo+c29tZSBzb3J0IG9m
IHJlc2V0IGZ1bmN0aW9uIG9yIHNvPyBPdGhlcndpc2UsIEkgZG9uJ3Qgc2VlIGhvdyB0aGUgaW50
ZXJydXB0cyBhcmUKPnJlcXVpcmVkLgo+Cj5LYW5haywgZG8geW91IGhhdmUgYWNjZXNzIHRvIGFu
eSBvZiB0aG9zZSBvdGhlciBjaGlwcyB0byB0ZXN0IHdoZXRoZXIgdGhleSB3b3JrCj53aXRob3V0
IGludGVycnVwdHM/IElmIHBvc3NpYmxlLCBjYW4geW91IGFsc28gY2hlY2sgdGhlIGRhdGEgc2hl
ZXRzIGZvciB0aGUgb3RoZXIKPnBhcnRzIGJlc2lkZXMgaWNtNDIzNzBwIGFuZCBpY200MjYwNT8K
Pgo+TWF5YmUKPiAgLSBpZjoKPiAgICAgIHByb3BlcnRpZXM6Cj4gICAgICAgIGNvbXBhdGlibGU6
Cj4gICAgICAgICAgY29udGFpbnM6Cj4gICAgICAgICAgICBlbnVtOgo+ICAgICAgICAgICAgICAt
IGludmVuc2Vuc2UsaWNtNDI2MDAKPiAgICAgICAgICAgICAgLSBpbnZlbnNlbnNlLGljbTQyNjAy
Cj4gICAgICAgICAgICAgIC0gaW52ZW5zZW5zZSxpY200MjYwNQo+ICAgICAgICAgICAgICAtIGlu
dmVuc2Vuc2UsaWNtNDI2MjIKPiAgICAgICAgICAgICAgLSBpbnZlbnNlbnNlLGljbTQyNjMxCj4g
ICAgICAgICAgICAgIC0gaW52ZW5zZW5zZSxpY200MjY4Ngo+ICAgICAgICAgICAgICAtIGludmVu
c2Vuc2UsaWNtNDI2ODgKPiAgICB0aGVuOgo+ICAgICAgcmVxdWlyZWQ6Cj4gICAgICAgIC0gaW50
ZXJydXB0cwo+d2FzIGEgZG9jdW1lbnRhdGlvbiBtaXN0YWtlPwo+Cj5XaXRoIGJlc3QgcmVnYXJk
cywKPk1hcmNlbG8KPgo+CgpIZWxsbywKCkkgY2FuIGNvbmZpcm0gdGhhdCBhbGwgaWNtNDI2eHgg
Y2hpcHMgY2FuIHdvcmsgd2l0aG91dCBpbnRlcnJ1cHQgYnkganVzdCBwb2xsaW5nCnRoZSBkYXRh
LgoKSW50ZXJydXB0cyB3ZXJlIGRlY2xhcmVkIGFzIHJlcXVpcmVkIGF0IHRoZSB0aW1lIG9ubHkg
YmVjYXVzZSB0aGUgZHJpdmVyIGRvZXNuJ3QKd29yayB3aXRob3V0IGludGVycnVwdCAocHJvYmUg
d2lsbCBmYWlscykuCgpIYXJkd2FyZSBzcGVha2luZyBvbmx5LCB0aGlzIGlzIGluZGVlZCBhIGRv
Y3VtZW50YXRpb24gbWlzdGFrZS4KClRoYW5rcywKSkI=
