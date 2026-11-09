Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794222437;
	b=f4j+si5cppkhHWNx3NxLZwpNexQY5xRaXRHlTToUp0tV2ePolnvjgvqWlJaA0xPaWQiK
	 sAgBi0OjilwSLkqmK7fqEg0s0tTpmHLdIx4Md45uzJit/n8zDteFrmfHZLSCVfyJYEJEF
	 WCLrsb4eS1m8XnpNe1smvAJyb8odfFZ4A4GB6ogCN9lrKU0YRfXnfxG2kXesWptYtGKr2
	 vRkJIcnvdk+k+PMbmJiGMpy+Hxojt5ue2xtKhghwl0E28/RWBtdcOEJZRDIKKL7gQvuYo
	 04RaG7nnTQFZ2GA4o7D5ntECz1+CIAhVY7mmUY5i/BUNXhdJkCl05RYHYisSLDS0+qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222437;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:MIME-Version:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=K3mjvFh/P1U++NcOUlXx2N+qncL/AlA1lxa57F/c9u8=;
	b=Xn4ZKel9PJeFsNCBbtWY0wBFfNcICQyN+gGX49xyGrQdcD78+rG7jSjhd2SYyjT/oW8D
	 diFHy+joGpkEwrfXgOr16YSdKUWae6Fig7m+m7ptuK02qaafLDbt6nbYecryIgxLMsq+8
	 dUGzDgDG4CMumaENwK6YRCv9zxQtjOGOhuGQ2EkjEVITy6ZO4cWlL1sZCoBmsqeB3E6N6
	 UQ6mhEXKjhJXnBQepn/2uLiIOq2beGRs0UnrC0/mDqczpU3RGfEpLeA/kuwRYR6DWUFOC
	 wpPeLsF03JOqN4YBJ8vckHS6eiznTHiYCaBLYkeEtou4MpBg8Ky/9wcErGa99LnsJ5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=L7yBqV15;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BA606A31C;
	Mon,  9 Nov 2026 11:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=L7yBqV15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a86xGJhUpQnq3Ra/fpEgvTt615v14apWia+W9UlLwA/+atvN0ddDMx5ceMrGIfI1kW5+W/uKrWNXlEyLlhDYZ6geG/tm03JoxdQOJ3cHE7kLXuSsYvuSwQbbLUQcIQtVIYNRP2ICLFSgUQQHwJDgJNboASiyY7gDXoN80m3ZIJeFXwiyLHdhnVjZUNQa3fQ9/pYe5KK4uk6+sh2OBb9ffPl7doOL2l4NXTwj24ltet51tCbolNRgZF4dOwxQsqZQIfvsTINmZyQ4nqKtmLiqUzFopbR5IwgbdjMczNsxDoZpq7Wl6kxGqgZnHyuY+9tDEFv81leGrhJA3kZP3JGxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3mjvFh/P1U++NcOUlXx2N+qncL/AlA1lxa57F/c9u8=;
 b=uXTlZMsC31Z1+3Mdp6YOHz2behf52RliZp6xGYPM4YaQuv1k7IVe/Q9oa8m7wJPqOtO1QIvJ81U/PlopvmjSrPWXtiwDeySoYmvO/Zk+o6gJjg6Q/Me6BbXTemJ/JGyShabWc5/jj7virsycIR/7twG9+MajTf+nc9I9GVV5HQk8gpgP/dgyQIOVxGL1+ATH/YYuDBIeKLUbGkZBhErYsN80QgOAHf9QByHX+8iZmov84vp+nZeq1rhnE8veN7Ot2q8TSjaiBWQ5Vd4s1bsT6j78CulpaP2e4KKrqLxNUKykYMzD7JtXhVvnyQPCsqpjHCJmrQvgIhw5pWiM3fkqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3mjvFh/P1U++NcOUlXx2N+qncL/AlA1lxa57F/c9u8=;
 b=L7yBqV15ySoX7G1ROmNKDuqmB1ShehegKxkBokzT2awpAIBJzSHqW4zUtJIOhnVJZk1NCcemjw5tESUJPW8MUCPEHO0vwWeMxk+p/aGv3X1HlX661qpMcq+0P/zI8O8Iz3Eaj+iE7Fq5OrDCMvYb6kqk6HskLr3Kuy3OJ+LYuSw=
Received: from AM0PR02MB5281.eurprd02.prod.outlook.com (2603:10a6:208:101::12)
 by DB9PR02MB6876.eurprd02.prod.outlook.com (2603:10a6:10:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 11:07:13 +0000
Received: from AM0PR02MB5281.eurprd02.prod.outlook.com
 ([fe80::bdd1:15c4:7979:b16f]) by AM0PR02MB5281.eurprd02.prod.outlook.com
 ([fe80::bdd1:15c4:7979:b16f%6]) with mapi id 15.21.0592.007; Mon, 9 Nov 2026
 11:07:10 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
	"krzysztof.kozlowski@oss.qualcomm.com"
	<krzysztof.kozlowski@oss.qualcomm.com>, Kernel <Kernel@axis.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "jean-baptiste.maneyrol@tdk.com"
	<jean-baptiste.maneyrol@tdk.com>, "crofts@kernel.org" <crofts@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jonathan.cameron@oss.qualcomm.com" <jonathan.cameron@oss.qualcomm.com>,
	Henrik Grimler <Henrik.Grimler@axis.com>
Subject: Re: [PATCH v8 6/7] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Topic: [PATCH v8 6/7] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Index: AQHdbT0za3s1DFnvYkyCu5dK79jxS7ch+00AgAOfDwA=
Date: Mon, 9 Nov 2026 11:07:09 +0000
Message-ID: <d5c6a85f8978eefd0b8f609107e0d2e4622c8ab4.camel@axis.com>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
	 <20261105-b4-inv_icm42370p-v8-6-b44eb96020b6@axis.com>
	 <20261107034846.429482a2@jic23-hlaptop>
In-Reply-To: <20261107034846.429482a2@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5281:EE_|DB9PR02MB6876:EE_
x-ms-office365-filtering-correlation-id: 761f76be-6bf6-40aa-b784-08df3e519997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|6049299003|23010399003|376014|7416014|18002099003|22082099003|10067099003|4053099003|38070700021|3613699012|4143699003|5023799004|11063799006|261026121527099003|261102123227099003|261022075727099003|261021121427099003|56012099006;
x-microsoft-antispam-message-info:
 /KGRfUF5EkaV07SlMdeZT3UaW6aKGje2QM1f7TidVEA5Zd7elpHiOxr1jC2WKb78ZkGD/A0VsdqiBPsOEPOp1Tfl3uj6MNCx9viIyhWr10UooU5d+UF+HGuSgyEqPOzc+UiB2C6EIyNjeNda1oIxRUaGgLZkML4gsGI7WPwukllNSFTSwtBDiK5IjtDo9Kuf/kQRKf26SmAuIX5OCUxSi2j7glOh/hbvFi1BRKloYrlH7SXkDWiOEDB3/DgBqiYpCymoO3RErUUyijkJ+QcPYVpxluy4iI5G8bTn9xyAHaYdr6zASqhs8oCla6psJ+ZKqLyQpq8PESmsSVYWk4jsQrsfuHhKY3d+FjSEOeLuqmgFmH+ukJFUeACutj/z7iIUp8OmFeonh4dKNVVIVorpwBMmYxtzeIulhRTTtNrCLWKhKb13Bo8UDw9PLFOyVgvpYkY5UFk+6oCsdpacnpv3P8/Cc9Aub8Jn9VVaUpbynJwOpu9+DHlcu+QqGn9qO2HcrrhbyjfiihRjvVrwLA7q7GA/PC+GeWHI7xjIuVGSkUCJ4pd0FqHXxv/Vi5m1banO0/Aw0kQrn3VflvmMUiq8IW5repf3dejyQpYLXCoCdmyW8r8G1IzFOGNdpWPEi0JVsZEoiuznZSJJ1kSg85Hr1HE3r3QHXC6oVrvei4yLLfmWrIlc3U5KTb3YXvAKktJTGzn1NABh6To5MyOzTgNY7OXC+tdiSVe6eQAgWORLMD+qnAMPtR4n+yBKYynOzFAj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5281.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(6049299003)(23010399003)(376014)(7416014)(18002099003)(22082099003)(10067099003)(4053099003)(38070700021)(3613699012)(4143699003)(5023799004)(11063799006)(261026121527099003)(261102123227099003)(261022075727099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFdJL3lDZElDZ0RZRmpVWmRSWlUyc1Z2Z0VZZSt6ZzYwL1dIODJCOHlNb2Q2?=
 =?utf-8?B?WjhlakNsbmtLU1p0ZkQ0bDhjSlh2aXBCMzdwRVArRjNtUjdrTzVlUnJldlhX?=
 =?utf-8?B?SVU3aWNGd0NJVW40QWtEOXlPdVpaZW5ucHRhMmk0VCt3SVdYRWd0UTluckhy?=
 =?utf-8?B?SEp0V1NDT05KTXNsUWZnbjIrOG9EL3BvRC85bHJXclNDV1h5RkhYTGNRWHBM?=
 =?utf-8?B?L0o5cjFpRTdBaUJZYkJzanJiV1FIZ2YyRmpvUHFnY1RmMUFnMVRPUE1zSGxM?=
 =?utf-8?B?UDBrMzJJT2dPZDErajE2d2Zpa0Y2WDlQR05rVjMxT3ZFaXNPbnV1NFVLMGtl?=
 =?utf-8?B?OUovbE85T1FWYW5UUnE3em5KRmlRLzVONmt4Z2lDS0dPeDdsV2RJU1kxM0I2?=
 =?utf-8?B?QkxwVW9qa3Y0akdUOS9vVk1LNUdZdDF1UkJ0bS9PYWRJSkZLUTRWdlU2R0lz?=
 =?utf-8?B?NS9XQWJJRm8yLzRFMUgzVCtPRTZnUVdkMm1BZkc0ZXRFTnY4cjdhMndLc2RV?=
 =?utf-8?B?dHdheUlXUi9sbkw5OFFsQWkyVnl2c3ZzUjFQR2JwTGN0eEZmQWxHbFNWMDhu?=
 =?utf-8?B?bVhBbFZFZUt0UjhaMDJDTUJDSU5xZUZkN0JkTmRYN1hGbmlEVlBMY2RLS2Vl?=
 =?utf-8?B?Ymw2OU42dDFhblB5S2hCUzM4dGZLSExUOWlQdUo5WWlXaWp5cTk2bS9raGh3?=
 =?utf-8?B?UzIxY08vTlFzblp1ZFRkNVJvR3pzRG1JSVpvZnVNVXJySFI5eDRIUjcrbUh5?=
 =?utf-8?B?WXVOT0VoVGJuWWlGd1hOMFFXOXdCTDNLdkdERGlvWHl3ZWgrejBNMzc1VGR1?=
 =?utf-8?B?QW1KWmRERmNkT1A1b0NDcHAveUhkeGxKd0Z0alJveHBRY2NDU1FSTCtwT2ZE?=
 =?utf-8?B?dU9QZnFKWEl5Z1A2SXR3RUgyTWFsQXJvNFhxMVprU0lzN0dkSWg3WnhtYnNZ?=
 =?utf-8?B?Y1RhR1NpN3E0WDVQeWZDdEp4SVF1ZE12bW5CeEpVV1RTcWdBKzJIWHZoUHVk?=
 =?utf-8?B?eHAwQW9YRTlKWGM0emlmTmpwVDArc2VMNUdnaTVyV3FhZk5JQ1VOVVlqMWxM?=
 =?utf-8?B?TW5SVFhTVDBjc3JtdHNnRmpaczQ5eXp3NFJnMTE5WDNSbG5vRSt4UWJTTTVV?=
 =?utf-8?B?eUhmZldHTVI5cG9YV2hqTVBqWVZYdEdxSmgwclpXTGxvNzk2MHk0Vk9PNXlj?=
 =?utf-8?B?SWF2QmNGN0doUXpSamNZS25CSkRUa2pRVDQrNUpiYW5Yb1E0YWVqb2ZLbTRq?=
 =?utf-8?B?L0FxWkZVNHpZelFYN2tJWFhSaGlNa2lxOUVDbTlzblRVNUNVZXJMdW5CZlB2?=
 =?utf-8?B?VFJ0YkZoOXFyWjIrUGdiaEVGYWQ0N09HT2owOTRUczI3bG5CSHBTNkN1Ui9Z?=
 =?utf-8?B?OWRnU0cvMXhtcVZ2R1RkTVp3dy8yLzJoMC9ObkxoSEwxYUt2b3FRV2FjU1lu?=
 =?utf-8?B?alV2UFhQWGcxV1Q0R29WeVdtemdzSjE0a2tUTW1vRXluVWJxelBHaFpWekt0?=
 =?utf-8?B?RVVYNVpxdmUxQU91aUlIZVgwUTNBN2hpb0NOOE1wVWRSTGpQUm5lK0cvMjho?=
 =?utf-8?B?REJZNW0wNFhDMXk0U0Z2UFFYRlU5WnZsY2pNQlNITnFwSmRYd1AxRE9FcXdC?=
 =?utf-8?B?MnJaUU5CeW5JL2JaQlZOY3hmR3pUNGVybGdGU2lrNGs2WHdoRDJlTlhod1lw?=
 =?utf-8?B?MmdRWjJqaHBMeEp5SWtHd0pwbFhSc1FFUE16S3lkZXRld1NERjRJaDNTSzBX?=
 =?utf-8?B?WnpyTk9PRTBoNzN3djI2WGJDMlM5NVZxTTVJV2tEN3BUT1diNzZBNHNUdlcx?=
 =?utf-8?B?Si80aUMxSW9qSlM2VFBiaVU5L2tVQ2RIdkFnVGxGdHJVRVRnWjQxdURoT1JY?=
 =?utf-8?B?T05CMTNxL0E1aVJEaWUzS3hnQU9hc0t4d0Qzb1A0aVVnUjEzZFJoQW4wZmRk?=
 =?utf-8?B?eGhtSmhxcmlPdkRSems1VFN6SGFLQWRULzFBMGhCaUp3a296c1QyNVZsSnFM?=
 =?utf-8?B?VkxmQlVVNGNoTG9BWlJ6aUJJeHlJcUp6c05ZOFJNb08rNFNBc2VmMlh4K3N2?=
 =?utf-8?B?OFo5NDVLeG40UkZ4NVAza0ZYWG5wMzBuZGVuczJMWUlheHlNcVRTeUMxbkhT?=
 =?utf-8?B?bU5zT1U0VDdIbFg2dDVjZ2ZTOFRNV0o0QnZxUmd4R1Z1c25kTytiOHNxcTJX?=
 =?utf-8?B?SEZGMStVQkpFSGVsdmFTamVoWTBWQ1F4Zi9ITlVGVnRzUzkvQ3BKckVFWFNQ?=
 =?utf-8?B?RGRwRUUxdVNGd05MZDBGSjFidVBRd3lVdXM3cXpUbm1mZTROWXlObWZLNnF3?=
 =?utf-8?B?QzNhNy93NWdoUWZxU3JMaDNRcHQwNlhQWWsyMmpUWGl1bFM0dnRyZz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-9f2+JuzNOYLY+4GvvrJa"
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5281.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761f76be-6bf6-40aa-b784-08df3e519997
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 11:07:09.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HakVwbJuWDcjeh0C07iT2a7r1F9hvfoI6AVU8cm4tjwkYfit/1L88L/q6Ig3gjvB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6876

--=-9f2+JuzNOYLY+4GvvrJa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,
On Sat, 2026-11-07 at 03:48 +0000, Jonathan Cameron wrote:
> On Thu, 5 Nov 2026 16:48:54 +0100
> Kanak Shilledar <kanak.shilledar@axis.com> wrote:
>=20
> > The device supports indirect register access to different banks. A
> > specific routine needs to be followed when accessing the registers
> > in
> > another bank as documented in the datasheet (section 13). This is
> > required for accessing registers configured via the user and
> > implementing buffer support. The implementation is inspired from
> > the
> > icm45600 driver.
> >=20
> > The banks are defined based on their initial bank access code which
> > are
> > written to the BLK_SEL_* regs. However, there is a variation for
> > MREG1
> > as User Bank 0 and MREG1 both share the same 0x00, so User Bank 1
> > has
> > 0x00 and MREG1 has 0x01. When MREG1 register is accessed, then
> > BLK_SEL_*
> > is written with 0x00 instead of 0x01. All the register access goes
> > through the 16 bit virtual regmap layered on top of the 8bit bus
> > regmap.
> > Bank id in the upper byte and the register address in the lower
> > byte.
> > Bank 0 accesses are forwarded to the bus regmap with the bank field
> > stripped, while MREG accesses are forwarded to bank switching
> > sequence.
> >=20
> > Due to the specific bank switching routine, it is not possible to
> > use
> > regmap-ranges. Only User Bank 0 supports bulk read/writes whereas
> > other
> > banks can only be accessed serially. Each time some data in the
> > other
> > bank needs to be accessed, it should go through the complete bank
> > switching sequence.
> Does turning off bulk accesses for user bank 0 have much impact on
> performance
> of existing features?=20

No, after setting use_single_write to true, doesn't have much
performance impact as the driver doesn't issue any bulk_writes in the
current implementation. But there are some bulk_reads for reading the
raw sensor data and those are not affected due to this.

>=20
> Otherwise looks fine to me,

Thanks and Regards,
Kanak Shilledar

--=-9f2+JuzNOYLY+4GvvrJa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCavGpSgAKCRDEY9j7t8Ka
Zw0/AP9O9bLrnmMa84CINHMY529DYlEr2bk7ntA1tjhgtNw3nQD/VxpJF+7CLQ5h
h39B+wz7IMS2g2mIOrDoy2bNy2VRvA4=
=aG1o
-----END PGP SIGNATURE-----

--=-9f2+JuzNOYLY+4GvvrJa--
