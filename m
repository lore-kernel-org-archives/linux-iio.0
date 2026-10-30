Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793377975;
	b=p59i3OqOawcKe3ZKsCHGs7ZmTNB2YQx1Qs6d6/8J0eKg8P+XcJNEXTYMNS/oD6VNGv7n
	 Yop1Grl383LHnYjCwpeXsn6muRqd5cdYCZNCnqeVfshv1S15hSrlgFo5IawhMghaYfLtw
	 5TnTXvcsiPwUCmNnxLQR5vFyR1ms0knkLOP83/w6Jt3I13nR3U4Z8/H99zkaiq7hAnbIS
	 G5UQyxM3rXkzGHmBS5BfXT25+GPMZboqq2dCNwmBbU+ZnTpIqhv0iSFFdE2/RpjmKvev9
	 lsXHz0/5xVIgKE4lCr10bevQWQ3vNcS/5eDVbHfawx+WxrNE2qo0mghQjU5Hu+jqFyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377975;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=c4V2Fi5uWyuQFVpbi/jniLsT3Ad6TcJvLX3MWytjfhE=;
	b=QtvLRu5l3SLI/E7lNz9dNnadlhiGekRozXPRV7PFvD52lMPp1FAdjK3uxGEfJ1q2WGKk
	 Gx/kU3CXuG9xnez54QjrNCwIbW6KgCZDEH+EZr02QZMF4VBnwxGRwb/IpJ+eUi2tuwAwz
	 PJn2yU3sTe71qZdL2kjyz2jf6BCcw/9eOQZnQxOSPoQ5huTuZ8zWCzV9jWs4pVxiQQkUo
	 RM4cI3aPgEI0DOwxW95fAPTfujcrXelSp38woLjVymWxn4YUJD3/Haf1any+IN5ZxNgeZ
	 8gf4HwHBa72rvj9gI2oF6mhyhLl0tz4W0QzUdHkEx0gI/WIEnNd/aIR87X8okFv3AZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=pab6C4Rg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.7
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2960A2613;
	Fri, 30 Oct 2026 16:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC2960A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=pab6C4Rg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nalg6xNWVOTt6T4pTV5ogiXo6BLU2gzqI1V0qJpLQCp3/pWG0yi/OUnAipwerf85qpsVfdOV81A0Hrt4ANQgLbdgIXhrDKH2/OhHT5STFsmTmh+czt5B5+dwH1zkyZ6vgKSiQDUhCAuCJG3UXSuI967xPLAuiLTaZ8E9gAkt11WAc8J3VNvu84Y0vxWWSK62Mn14Sd/n60c5VlA/B0kW7TZ4U+WiyvszO8D4hYkd93erj30XLwFCCGnNorNl0tS+pmzkIOGFLkB+PSdYLWN6vmbejHg2/tSJu/h+0t9/EH3wYgfRDSQ63Bj8Yk5HTY4hSOFYLSC9MhV8WnAMY4Ic7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4V2Fi5uWyuQFVpbi/jniLsT3Ad6TcJvLX3MWytjfhE=;
 b=f7wJDeXWNTLxqj1q+sDatLpK8PMoPJrWYlmJity8W1SQ+cRjL78wn51ZjxDgsjuOHgkXkQAGOEX5jGK9lht5Kw/RK/dPPwlBf0nkLyb3wXQTiWZ5Fhk9YEmVgxWA9v5VotGVNh9TAWDUYAG05cUq2tBq729z+zkXnFjjaJ962ATcyyI5MIo1THU4H3UmSnwTfayNht1YDVwDEzS+dUEgzy1UI9nWixSXjDQRL6FuAb2JTc//LUWacYjyn/0GURtJZyGIQEmlpAMgtnqBO7p0iWiFkXWpSMfymo9D1txISbITo2XFdHUPXHF08ELb0+9zksVTYVaD6nB8auJHgC4Hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4V2Fi5uWyuQFVpbi/jniLsT3Ad6TcJvLX3MWytjfhE=;
 b=pab6C4Rg2qPhph3LvGxHliBxzONdOoilxn0XciEGR2lKkP4cENkCPU5mN8pJr8sL0VNTWl4BU5mevub3smQ/HpiD0uWVZSFlr7RA9BBF0iZOXBTv1Vl78NEBdgFqsU88Z7KpLaoxfMM+GNRxmHBdnGvr7EN786NKSxSJ/Yf4k8jPZr9muTOdNZfJcA9hGkBmmqAHFO2ZJCR/mIxcIVExlSD3aPtVpCogBP7Q1cTErr2bteDrwKxFj0PQ/P48trfEMDLE9Fq1Vve10TsXzWqiOxqWH8ksMUf7S5VSJ6jjROsCAjQxCrXKsQqKTPyYxUEdqrvzNKZT2s6VioHQjVRIag==
Received: from DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) by
 SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.10; Fri, 30 Oct 2026 16:32:51 +0000
Received: from DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990]) by DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 16:32:51 +0000
From: <Marius.Cristea@microchip.com>
To: <tristmd@gmail.com>, <jic23@kernel.org>
CC: <tristan@talencesecurity.com>, <nuno.sa@analog.com>,
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <andy@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Thread-Topic: [PATCH v5] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Thread-Index: AQHdaGsqyC8xEUJL90CVn3Ptg8tFfrcWR8UA
Date: Fri, 30 Oct 2026 16:32:51 +0000
Message-ID: <6eb7177ec4730be9307a3f4d29a53a952a7f7bbd.camel@microchip.com>
References: <20261030123528.606107-1-tristmd@gmail.com>
In-Reply-To: <20261030123528.606107-1-tristmd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7624:EE_|SA1PR11MB5825:EE_
x-ms-office365-filtering-correlation-id: a9dd938a-1aee-4520-536c-08df36a3713b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261026121527099003|10067099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 LLE9OAoUdj5es7AkWPD93goth3/CQbh8Vq++Bhzr4yhBFkJwUUEPbVBZkU5NqpaWmCqBlikLb0vM1vrqYrVVcu8xoCKPs2tKLr0HO4ABkxGEUjUs59ji/uO2GOfVpG0EH4kd3EF8PRiVGmV4Bq6VdybhCg8/JTYXia2/riA8rx/WnLnzUFTmXomxWclW7+5Ej6qcF0lM3ogz2DPVQNKxmtIjCSn7xkjBVZ9F6euK+v4TfJfBfKkMiYKUr6tBAFOPqRd0Jzbz+GegIITijVf1ZZh1tpuNoOK+koNX214OGHw8J8LmiWKyWbLe/QqUQcokCof5jXzbCXd0UMYGHmWfPQF9qDIwgs1E3HT7a5VhlVDlgM06JurmPdgj+DBuLm8HqmU0l6D9FuWvTvqxbfJQZl3eWusRMixnnvWiwLdiRWrvNaiu7rU/UA5G91qsZ3XqvzlPSLFUh3kKL9XRwQTKC3Uec4YHnhdWV/45QgUnYsnV6Hu9s6AWcZivOePTaKT2GKFGz5ZxeyO5Fh+vcPKLFvAl2HMQVkxA9wJBFtH6Krv4jPk+NIfsXIrhjNuR2DPKwXYlh9BMkpHjHa7JgcvabXU1oG5WrccwEx0Hdmsuq2LITT73YXRGgHfPZcwi3nxbB98YpBqvUpBNs1gT4SLG6OZqRnRiS3+coQemkZApKSi5NZHguiM74jy7po2TxKhOGfUJVuYqqOw78d7noSQOfP5ols9nYXqRC1uBs6l6QJg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDVMWFJMZ0NVYVhWczJDYXU0ajYrSWsyTXZuRlVGRVFOWTZSaUFwS2FNMFRh?=
 =?utf-8?B?S0psclVPZHVZT29ZMmxwQ2NOUVNTREF6eW9ZbXRYSHgzcU9DN21vc1N3Z2Ew?=
 =?utf-8?B?UHJUbUtOVXUxQm9nVjdVM0tDbzRwMXpBRVJqUG5UMkk1Tm93azhoRVpVWjBD?=
 =?utf-8?B?RWh1azhCRDRvTnV0em0xb0RFZVp5TUVyMkt1Qmx6dXVIbXNpT2dPcmVOYTRj?=
 =?utf-8?B?QTZDRU1seGk4MFNZV0M5d1hMVVpSTTlnMVRsVDNnQk1odXFqZ2dsRVB4MEQ5?=
 =?utf-8?B?bENtQUk1VDZKTmJrd1ppck5kM3RHTHpQRDcxeDRTc0dOdTEzaHQ1TFBIdmV3?=
 =?utf-8?B?TERHOE5jZER6blFiTERVZVJEdHkrUUgydEpaQU9lSWhQUlpvVTRXcUlqMzN6?=
 =?utf-8?B?YTY0S0orZEJDbjNjeEkzSW4vYk9MZE1KSmN5RlptR1ZMa0FSMmZvSm1FUUta?=
 =?utf-8?B?UmNSajExSGNNeE5kWUQ2U0prY3JJNGhySWdGVXJkNmFaNE9YR3E5R3IzcEFh?=
 =?utf-8?B?NVJiQ1orNVl3U0RRaHN6dWtqZzFsZjA2Z2VFRUo3cjhrdEFrNzBMcHFvdzg0?=
 =?utf-8?B?VVQ3K0gvRldwanFyTm1MTWhGVjhNUG5uTmVnNllFbGJnUVNqR2dpSDJJVUtC?=
 =?utf-8?B?OU9hdVpXaDlzdDYzVHBjRENaREw3MkRQWmUzMFdJUEs1SklQblBxcXhJdklH?=
 =?utf-8?B?TmtTeWpSalROam4zY0NxWlFKemVRMG1iZCtHRkdEOWZIVlRKM01LSHhLSlJt?=
 =?utf-8?B?aitMTlIrbmNKbWo3U0RZM1h2a1Y1VGlvKzhaWHNJTzN0eVpIZFFTNnllZndD?=
 =?utf-8?B?OFY5T3FpWUZEQy9KM1RWeWE1YmtqYTNDbnIrV3YyaTNNdWUxcmFiN1ZBMnhs?=
 =?utf-8?B?Q1cxcmpNRFh5dmRBSGZHNGF0dTFublROb1NHSm9USlErY0JmeGpNRGkwUkNr?=
 =?utf-8?B?SGdyblc3TE1HUFcwQkZhcTZFbFJrK2thVjd0cVYxY1lNOFo1Q2NvNEFNYnl1?=
 =?utf-8?B?STZ2QzZGY0UyUjJCWVVTRkR0Y2dhdjJpTTBnc3ZkUFlMR3NQOWxKU2hOS0tQ?=
 =?utf-8?B?R09OeGJVZW9ydnV4aElZMnBHbEhZOHFQbmgwVU8vT2NMSStNK25jS2VZVHFn?=
 =?utf-8?B?cm9TR1NKR2xnRmp2TmhtM3FKZjBhMmtvbENFTXIyWDY0RE0xM2pSVUZwMGE2?=
 =?utf-8?B?cjJVTXV4TkVjMC9kRnArdUR4T1dnUkFQM2lWMjVrYVhWc2JyNEZHYSs0M3R5?=
 =?utf-8?B?UWR5bTFFa1I2MklndmFlZjU1TUlmTnVGNytkMDRKa2dNVDhlRDlqUTJzcUZo?=
 =?utf-8?B?cEZlTC9pNm52MzhRSjllMUQrelg5V1hnNy9ncTQ4dDF4S1FVN2J6Y3N5WDRh?=
 =?utf-8?B?MnNLc0h2VkZPZ2V5SU13UmhPTS9PZWcyMjI3OEdIWU5FbkcyNWhReXFaYzlL?=
 =?utf-8?B?MUdZVUc1R0x2cWRUT2xUSVlocWJ3U3RobHpucEttb3hCaU8zdGl5MnYvb1NO?=
 =?utf-8?B?QmY0TkdLblYrdWtGSWFEWTZYY3lIRk5Id1A3WU5MU0xVbXVBdVIweFFjWHBU?=
 =?utf-8?B?ZmNrcS9yWGoxMDhLZmtENW1aNHVISy9hMG53UnVXTktLUGdlWkhSVUVPOHlO?=
 =?utf-8?B?US9WMzJnd25kY09lSG5WMTZLODh6WlNOV3NpakhzNENzWmRub1FnU2VLNVc3?=
 =?utf-8?B?TWdRb1IrL2hKTDJXWEJoN0hQRHN3R2lmM1lJSnRrc200ZlMrMGtCUHJ0L285?=
 =?utf-8?B?bVh4ZnVtMlJIMkZncHp1YjRVaUtLNDgzNTE5cWNRNVRpczhhcmt5clpHZEt6?=
 =?utf-8?B?Wko2QUZWU1gxQlh4ak14S2tOS3FoNFBiUVhSOEYzTmpicFBHaGxJU3BUa0di?=
 =?utf-8?B?V3VGemtzUjI1Q3B1d0dvL0RVU0RVWlBYcGJHbGhMTlcrWU9oQVBUMUNTNjZv?=
 =?utf-8?B?NW4yUXd5M3l4aWgrMjJON2pyS3pXZjUrYjNQWDVwYkVZWDZkdnBvOGt3UUV3?=
 =?utf-8?B?UHhRc3FqMjI3RnF2SUptTXQrK3NYQUlyV3RITENVZDlpRE5aSHZBZjhoejVZ?=
 =?utf-8?B?Tis1aWdUSUhXcGVxOWtVL04vdE1zN1ZmcHNQZnBZZzZHTjhDUGpla2lmR29R?=
 =?utf-8?B?L2F4bU1jNUl4SXUzNldwN1VaL3BiSUlmTkJ2WXo4bi9NOEttcWZlOTZqZmhQ?=
 =?utf-8?B?VitZUHhxTzVVSHhhU2V3cmIvemhzSHNKRzlpOXl5VWFuc095L21iOE5NeENq?=
 =?utf-8?B?U3pEVFZWUFZ6Uml1TFBKY0VhNjJ0MEJuclFaaWdob0V4dmZIRldaSllxS3c1?=
 =?utf-8?B?UzJlZWpFMGtTbEFoTURoeXhWVXpDb3NTVUZ3aFk0KzVUTk8zdzIzOW1XQlNq?=
 =?utf-8?Q?C/cUnYCiOz3lt71c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B61C59DB6D123C49BB78BDBCB5AFD75D@namprd11.prod.outlook.com>
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
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dd938a-1aee-4520-536c-08df36a3713b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 16:32:51.7044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m11L5L7S3LbN6YYmoL0z5PzxU13J44TSwGV8JfXY0YweYnU82pTrcwZRZnOw0mPQ8bnNDx292fcE2rLHZJPb/j+7f9I1sB0ti7QNx8MS9u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5825

T24gRnJpLCAyMDI2LTEwLTMwIGF0IDEyOjM1ICswMDAwLCBUcmlzdGFuIE1hZGFuaSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBUcmlz
dGFuIE1hZGFuaSA8dHJpc3RhbkB0YWxlbmNlc2VjdXJpdHkuY29tPg0KPiANCj4gcGFjMTkzNF9h
Y3BpX3BhcnNlX2NoYW5uZWxfY29uZmlnKCkgY2FsbHMgYWNwaV9ldmFsdWF0ZV9kc20oKSBmb3Vy
DQo+IHRpbWVzIHRvIHJlYWQgY2hhbm5lbCBjb25maWd1cmF0aW9uIGJ1dCBkb2VzIG5vdCB2YWxp
ZGF0ZSB0aGUNCj4gcmV0dXJuZWQNCj4gb2JqZWN0IHR5cGUgb3IgYXJyYXkgYm91bmRzOg0KPiAN
Cj4gwqAgMS4gTm8gY2hlY2sgdGhhdCB0aGUgcmV0dXJuZWQgb2JqZWN0IGlzIEFDUElfVFlQRV9Q
QUNLQUdFLsKgIElmDQo+IMKgwqDCoMKgIGZpcm13YXJlIHJldHVybnMgYSBkaWZmZXJlbnQgdHlw
ZSwgYWNjZXNzaW5nIHJlei0+cGFja2FnZS5jb3VudA0KPiDCoMKgwqDCoCBhbmQgcmV6LT5wYWNr
YWdlLmVsZW1lbnRzIG9uIGEgbm9uLXBhY2thZ2Ugb2JqZWN0IHByb2R1Y2VzDQo+IMKgwqDCoMKg
IHVucHJlZGljdGFibGUgdmFsdWVzLg0KPiANCj4gwqAgMi4gVGhlIGxvb3AgYm91bmRzIHVzZSBy
ZXotPnBhY2thZ2UuY291bnQgZGlyZWN0bHkgd2l0aG91dCBjYXBwaW5nDQo+IMKgwqDCoMKgIHRv
IFBBQzE5MzRfTUFYX05VTV9DSEFOTkVMUyAoNCkuwqAgQSBwYWNrYWdlIHdpdGggbW9yZSBlbGVt
ZW50cw0KPiDCoMKgwqDCoCB0aGFuIGV4cGVjdGVkIGNhdXNlcyB3cml0ZXMgcGFzdCB0aGUgZml4
ZWQtc2l6ZSBsYWJlbHNbXSwNCj4gwqDCoMKgwqAgc2h1bnRzW10sIGFuZCBhY3RpdmVfY2hhbm5l
bHNbXSBhcnJheXMuDQo+IA0KPiDCoCAzLiBUaGUgYmlwb2xhciBhbmQgc2FtcGxlIHJhdGUgRFNN
IGNhbGxzIGFjY2VzcyBlbGVtZW50c1swXSB3aXRob3V0DQo+IMKgwqDCoMKgIHZlcmlmeWluZyBw
YWNrYWdlLmNvdW50ID49IDEuDQo+IA0KPiBVc2UgYWNwaV9ldmFsdWF0ZV9kc21fdHlwZWQoKSB3
aXRoIEFDUElfVFlQRV9QQUNLQUdFIHRvIHZhbGlkYXRlIHRoZQ0KPiByZXR1cm4gdHlwZSBhdCBl
dmFsdWF0aW9uIHRpbWUuwqAgQ2FwIGxvb3AgaXRlcmF0aW9ucyB0bw0KPiBQQUMxOTM0X01BWF9O
VU1fQ0hBTk5FTFMsIGFuZCB2ZXJpZnkgcGFja2FnZSBjb3VudCA+PSAxIGJlZm9yZQ0KPiBhY2Nl
c3NpbmcgZWxlbWVudHNbMF0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUcmlzdGFuIE1hZGFuaSA8
dHJpc3RhbkB0YWxlbmNlc2VjdXJpdHkuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2NToNCj4g
LSBLZWVwIGV4aXN0aW5nIGRlY2xhcmF0aW9uIG9yZGVyLCBvbmx5IGFkZCBuZXcgJ2NvdW50JyB2
YXJpYWJsZSwgcGVyDQo+IMKgIEFuZHkgU2hldmNoZW5rbw0KPiAtIFJlcGxhY2UgKGNvdW50ICYg
fjF1KSB3aXRoIG1pbl90KCkgY2FwIGFuZCBpICsgMSA8IGNvdW50IGxvb3AgYm91bmQNCj4gwqAg
dG8gYXZvaWQgdW5zaWduZWQgbGl0ZXJhbCBxdWVzdGlvbiwgcGVyIEFuZHkgU2hldmNoZW5rbw0K
PiANCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBSZW9yZGVyIHZhcmlhYmxlIGRlY2xhcmF0aW9ucyB0
byByZXZlcnNlIHhtYXMgdHJlZSwgcGVyIEFuZHkNCj4gU2hldmNoZW5rbw0KPiAtIERyb3AgY2Fz
dHMgZnJvbSBtaW4oKSBwYXJhbWV0ZXJzLCBwZXIgQW5keSBTaGV2Y2hlbmtvDQo+IA0KPiBDaGFu
Z2VzIGluIHYzOg0KPiAtIFVzZSBhY3BpX2V2YWx1YXRlX2RzbV90eXBlZCgpIGluc3RlYWQgb2Yg
bWFudWFsIHR5cGUgY2hlY2tzLCBwZXINCj4gwqAgQW5keSBTaGV2Y2hlbmtvDQo+IC0gVXNlIChj
b3VudCAmIH4xdSkgZm9yIHRoZSBuYW1lK21vaG0gbG9vcCBib3VuZCB0byBlbnN1cmUgcGFpcnMN
Cj4gwqAgYXJlIGNvbXBsZXRlLCBwZXIgQW5keSBTaGV2Y2hlbmtvDQo+IC0gRHJvcCBGaXhlczog
YW5kIENjOiBzdGFibGUgdGFncyBzaW5jZSB0aGlzIGlzIGhhcmRlbmluZyByYXRoZXINCj4gwqAg
dGhhbiBhIGZpeCBmb3IgYSBzcGVjaWZpYyByZWdyZXNzaW9uLCBwZXIgSm9uYXRoYW4gQ2FtZXJv
bg0KPiDCoGRyaXZlcnMvaWlvL2FkYy9wYWMxOTM0LmMgfCAzMyArKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gDQoNCg0KUmV2aWV3ZWQtYnk6IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMu
Y3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0K
