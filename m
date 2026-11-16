Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794802792;
	b=jB18zjkHwG8gKrlUnT83Cvhr6nTTlnskSkn8G8Hxa0UMMjcsrU8j6D9UoG1hzkkPmeLC
	 GD7kSfJHAIghDhupHHUwKIz+8tjpCLkHeBJi5pVrRo3OQPdqik5uusXsbssZ7rjEyIxIk
	 zVbU7DZvc7xnrDik+Ms4v0UetwhLknYDO3ycGhl7uthjlOdzViQX/CaV/tLYZyu9KEc5W
	 U2632bAKTwqNMs8UQl86hXKzJj4feQQX2s+vaYZbRXESCE7J2goaN5hzNM8WBanh8BVFo
	 0/lBRarIWzibIdkg4QDzUADQDqt13IOrxzCemN6EZU3Ttu4LXbvQ2rcKJWdh1/yupMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794802792;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=j5ROke81fNTiqyIhGa3NeDrAJOClSD8rcXH1P9AmY0M=;
	b=pOdecrGzJLRpLmh/rvQgltYGc3REU23CMvbIq+OsCy7El4sTVev8WddUXSyWkc6JSKTB
	 /Sm12I/m7H8LYqiIdbFbAqkPFWPiiA4tJYmritLtem2SIL5mm8QUiIBotwUWzlMpgUPNK
	 eakEIBi6OHY4ukZNgXOwpDNR0FYE237wBT7zQ/+JzRqrUE8c7A4RTd8VYefcKlhFgF/7W
	 2XtWrXkHqWGlG1ibZwt5RYnCoR/zpe2wxuapCZPRcFCtd5RIlCvD3TfXoAoeDSZOk/50C
	 oqhCMcZvJ1oBbHtdT3nA6wMTJR9blaeJCVzxKEcvVJzOqrFeDFTxZh9P+Ce3al4BDVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ee66kmlp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.30
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A2606A880;
	Mon, 16 Nov 2026 04:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 086A2606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ee66kmlp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbzF7A+X6NmfvZWTwrWJt6q6mzgLfJSQt80fSNor5JNM3r2K4ACnqA3p1+QjHMrAxvRmtal6WTJkK1Pxx/l2ftpnecwoeN+G5pzvZzhJHHD1+qHn+evN59WRjIAkescxA35c2NS6iYNPJrqMykEUGq8+MB98ol4i2ceDKK5oaHSlFcUZZrA0roxWxKKblEocdldOUUkQPjZbdgo/WqxPLNOI0A1ZWHPLkVBlRyt9rcWwGgJRWdsZlhJ5nrfJKyvjfPOsmpBIHSKBIH08DhTp8muTlf4iCG5VPGilKZwfsPqOoqJXUpt8u1J05W6gcbV7cvjXOw49tKpq+yYeg4ZlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5ROke81fNTiqyIhGa3NeDrAJOClSD8rcXH1P9AmY0M=;
 b=f6JiUnPuIMG/foeXxxZf4pqzh1aztEME57oSXDJ4M0ke/FHaDVUlhqnaM11cHIa7bcziivSnCHGAMM/0pI3/yFE0wNvsg7B93fuXkrCqC/jwreb8YLRLnKGjjqIE/DTU7BHNuL4v4/sYbY8Cy9whYfxU+JPR7uPfJbR6Qn2LnxPR9GkGlWnerTm/GkovE0QTllSU6/O+3ic+tCuiD4AW6lF9qnFKAuE3wbrhYePiPTxLdj9NxaGsYP2D/r53tqWODG3Jnh/E8yb0Xbon2Ig+PawXgPpqkwY+0mXYC2+KW+RIZUwuftjTC0mR6uPrtI7jnfE/qdh5uDMGGw/335vrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5ROke81fNTiqyIhGa3NeDrAJOClSD8rcXH1P9AmY0M=;
 b=Ee66kmlpUgzXx8qHsMvmWEdhe7PKxV8KPtCYlyPGMHHom/RAwaGwhHIOlsgTCtSfK032Y5wig++h44PJ6xmPbrkVEt4BFAkN98pZIHhgjFg5hnrFTJJr8r6rSs4XTAGASdscEDWtKNS7hM9kUZ6QdH49phs2p3QPFgoXrpHzL3M=
Received: from DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 04:19:47 +0000
Received: from DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9]) by DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9%6]) with mapi id 15.21.0592.010; Mon, 16 Nov 2026
 04:19:47 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "Potthuri, Sai Krishna"
	<sai.krishna.potthuri@amd.com>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "amitrkcian2002@gmail.com"
	<amitrkcian2002@gmail.com>
Subject: RE: [PATCH 2/6] iio: adc: versal-sysmon: validate temperature
 hysteresis
Thread-Topic: [PATCH 2/6] iio: adc: versal-sysmon: validate temperature
 hysteresis
Thread-Index: AQHdasS1tSYdaUNTakOTVjECb6koGbccIRWAgATNUJCABUHRAIAFvADw
Date: Mon, 16 Nov 2026 04:19:46 +0000
Message-ID:
 <DS7PR12MB95039DF1B995E46FFB63D404DC7C2@DS7PR12MB9503.namprd12.prod.outlook.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-3-amit.kumar-mahapatra@amd.com>
 <aumyreagvU6zewKI@ashevche-desk.local>
 <DS7PR12MB9503E787CBD5E9292B5637CEDC762@DS7PR12MB9503.namprd12.prod.outlook.com>
 <avIi2pDCcaKDx3Ro@ashevche-desk.local>
In-Reply-To: <avIi2pDCcaKDx3Ro@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-13T11:19:39.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9503:EE_|SJ0PR12MB6709:EE_
x-ms-office365-filtering-correlation-id: 711aed1f-86da-449b-e8ee-08df4398d948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 5lZOSqF8d/G09DIR2zJFB98LfxG5fe2/L/NPPzOnj77t6+GCYbU7SuDqcS4Wh15VOJLxDZPoShUc3GXK+sWiv5jcITWUpjCf5HMcaR1HHUdfMsjRBWb31E5c4I2F3HzNVCUwcI6Xvtwtkg9JVy4GF4Luin71quY2+yRBcxHpLIKOV1c3K28bcliTNUOZ4nbFI4wuKCxBA8yM3SNH1xQPDXA811d4qpgL8owdKKA42FPYdtI3NaH5KmHahbomCKziyezTzCn/X7ecjWUXvCbSQoRfQ9eYe3k1AXT2xCdEWEEG5cUVMYbu6hh/LgQMom6VJGchgSl7Q60/iB9pd+eVSeRqHnXq1nULPqVmLQivCiYpOzjfZDloV9d4g3373DgtNuflKbQkWYyEphFLEOo4r+sd/6w1U0G/1kT8yLVkf91fT2O7TIr8EuRWzgs/0Bf+HtpN4VqwrhhmdOFLV3cSuOauPaJyACgTPB6O8mJUs1tKGySkEdYB7AKdVpznIbccn+uNgQ9siiIUne8LstpX38k1jde314CuIoixCDlrbRwuDwxrMJgls6tOwDqdH4C5yg54EssyRDpHTI2uH4l/77wDnD/ZjhGPw1wUEhuW8teExXTLAlVGwv52mQGVFzscBuq+BZG37GLrSbrO6qRCQZHLBfsrTTabRxkzawk/40A5OCKylmzdpOBU0PytyvXXRamUwX2S7wi5svKCZdc6fFPcddVPvxtMH2M2atkT1xY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9503.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NvSATli6SG2tfe+1/90u4EUoASBQdSJJRpM9wJMMjd1vP0tZjdS4yJAYGc?=
 =?iso-8859-1?Q?v10Moub3duui5qAHpXtO+4Ljvp8FVtbowB3o54+KrqMzy93Aza52jyej6Z?=
 =?iso-8859-1?Q?LpEADypULXioLZTgQdUG8ChYlzCip87ZN9AfuYfu7w6UU+UGZOiI/xh/0Q?=
 =?iso-8859-1?Q?7Jr4i/3J7xeFWbw3dqP20pLkqx7PYnONEgo909HVV5w2uet6S2mU28EKDY?=
 =?iso-8859-1?Q?cAT6kJfs3yluGavW3Fqowma6FsXavBBftJ44n9qvPQFvth1EZtDbkAGJS1?=
 =?iso-8859-1?Q?aflev8pK+6yB33JaDa0FYFnIN4hKVFQuqRkFCZkgv/JyenhWYkdCb4WHJ4?=
 =?iso-8859-1?Q?U6lBD3qClRpN9RuDf9EWuqyS+KD3neAwxr3gDKAqFE/k6GYRA0bdVX8K+X?=
 =?iso-8859-1?Q?GdoE3t5VPUNiq9I/RoXM736h1hHZXz0Iozd3bosdWXOcWwlp8kRnfuxf87?=
 =?iso-8859-1?Q?YP3D+GkXnrPQWysZhY7D9rag9TxqkN35wB6qKv1hfPSAGN5hXp0mp4HJox?=
 =?iso-8859-1?Q?PMlbGLITyFQ0ZchmdgB0AXNsPGKDwYKdaOZdhaOHKgU9qYV0onejRXvtPU?=
 =?iso-8859-1?Q?3a+Qy21hOfEwpEzoA+rY/rmRloir7QXZHrG61sXGIBTq4QuwYg7v0QA9aA?=
 =?iso-8859-1?Q?/Ty0lXkvcnA1tzhVYjnrPEz82I91iMnn0n/MRekxTY524H4Z2KXxWhxAT8?=
 =?iso-8859-1?Q?QN/I7QJzJbTsaD/GN6mKR/r9a6CdOzr1Hekx7DTRC+kZTNjrEBDaRKrPW1?=
 =?iso-8859-1?Q?KgfHGz/azHPivrDrmW7TjEsimkB5lZIsdewKHuLRyiwPfkoixQPYMYEkCK?=
 =?iso-8859-1?Q?TweQQUHt5jPYdCZDP7Ls4zfBme4nD2Aa/C5HwrXP9KGXOtzKEg8P9MkjsS?=
 =?iso-8859-1?Q?J9Pv5vB+o3jtzZMV1IGIH5BX0Sz8uL0QWHvCJnLNaRpq2veQwSK/KdP0Ez?=
 =?iso-8859-1?Q?BKhPr2bxKAXpGcjhp/6QMmi/YRj8W/QMaVvbEAPHuyTxoP4naY8l004iU5?=
 =?iso-8859-1?Q?yh7VoZ/h/sIIvJlHg2zSBiKxO6RRQBj+ni4C+/Qrzqpi7QbvDm78GUGs+Y?=
 =?iso-8859-1?Q?n+4dhe06Th+3pOPQJxvuHkof6YKnjV6O4SGJk1UfujlEr3WQimG5f0amSZ?=
 =?iso-8859-1?Q?PfFeMsamMe++gnxEIeGMQwaw5/W8VPtpiOD9Cz7lZguVA4Zn882ADcn2qM?=
 =?iso-8859-1?Q?M34A6OpB9XnOj9fRs++R5ejTcv3IC7RktLQQscsS8jrlZGt5yROmN/TjiC?=
 =?iso-8859-1?Q?GqBYc7H8IxY5BRmW0zxI15nmOm0I6jhQlVO22YjjpDgVpxjCpBJGFQdqCt?=
 =?iso-8859-1?Q?wkqaBq9FT4hOqvgvfkJyawF6C1ok2yeTcSBDy3QEgbpbCiZaQ9gWiA8y6R?=
 =?iso-8859-1?Q?ub6xdU7PNUDB6FfQGgdbg4quVuHGeu1o5iznV7GGv5sSmJyBNcqArBom/+?=
 =?iso-8859-1?Q?aaAH/GuL5ZXb0JJsvM/ZMEcldWbxcl9uEYzclIiMLPSSfMqbUwPRpdTsrt?=
 =?iso-8859-1?Q?4OeHa4Sv6KO2YVJC0jQz5W1vX+Qvzxcd3m3yQZbC5dU1d/IUUDs0xM5+SV?=
 =?iso-8859-1?Q?ao88nJQhdtu65igH+FRjqNApS+kLXtNVoF8PNXhHHP9hfORW8M9oRCagSg?=
 =?iso-8859-1?Q?gxxkKKQWcVvtjwRyCMLVMZknEKdM/GzaEICfLJQakEwgEcIOzNCQ9LcpXq?=
 =?iso-8859-1?Q?AUSd04sxf/5ZKwHbAVuHMcu3Bi7AKyED9nMEjpun40r/t60UqhpXuVyQ7F?=
 =?iso-8859-1?Q?TAAvIx6ZErp/P6rzHOXBt9pkIbT9hJ8Qv/RZSQb33p80Lw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9503.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711aed1f-86da-449b-e8ee-08df4398d948
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 04:19:46.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gudbI1oI5IZmD5zwt/Uj6bKWX3E60gQLOUgnLCNrhuSg+TVHOHb8OqTCcxQ+JZ0jRDANUjDZZ2FhnAGMM8SUdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

AMD General

Hello Andy,

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Tuesday, November 10, 2026 1:16 AM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Simek, Michal
> <michal.simek@amd.com>; Potthuri, Sai Krishna <sai.krishna.potthuri@amd.c=
om>;
> David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com>; An=
dy
> Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux=
-
> iio@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> amitrkcian2002@gmail.com
> Subject: Re: [PATCH 2/6] iio: adc: versal-sysmon: validate temperature hy=
steresis
>
> On Fri, Nov 06, 2026 at 11:35:00AM +0000, Mahapatra, Amit Kumar wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Sent: Tuesday, November 3, 2026 3:39 PM On Mon, Nov 02, 2026 at
> > > 05:51:08PM +0530, Amit Kumar Mahapatra wrote:
>
> ...
>
> > > >     sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> > > >     sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
> > > > -   *hysteresis =3D upper_mc - lower_mc;
> > > > +   *hysteresis =3D max(upper_mc - lower_mc, 0);
> > >
> > > But you can use abs_diff() and let it make the problem of the supplie=
r.
> >
> > I went with max() because an inverted pair (lower above upper) doesn't
> > really describe a hysteresis, so treating it as zero seemed the safest
> > reading. With abs_diff(), an inverted 80/90 pair would be read as
> > 10 degrees, and the next threshold write would then set the lower
> > threshold to 70.
>
> Bu where did it come from? HW or DT? If the latter, we may just reject th=
e wrong
> values at probe time, no?

It comes from the hardware, not DT. sysmon_init_hysteresis() reads the two
threshold registers. There is no DT property for them, so there's nothing t=
o reject
when parsing DT.

Regards,
Amit
>
> --
> With Best Regards,
> Andy Shevchenko
>

