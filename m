Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8373AEF4C;
	Tue, 21 Jul 2026 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618301; cv=fail; b=Y5RH6o8ltPBVK9V6YsYK0zYsz9WZ+0DzlaaWWN8DklQTQqamS9fd9Iqmk4iHvpG36OZBDu6e1e8A3oeduG0k3ToJWMKjlSlLh3oNb9RzxF9JggUVZ4MWLFl6Vr9kiV8HQh2xPtj0ZsvtqOY8xSXIg0i8QVPlVD/1T2zP0VZH7mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618301; c=relaxed/simple;
	bh=pAhDjPIpwPKTK4mHe8dlEq30Ol++nh94TaQaEsCd2ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GZp90mROml2rFdP6HkxCiU8lUn3dl7ZHuIl3cxtnnxrZdgvIxhI4j0E47pPmTDY8amRXx27eYhfrI8keVSjvZpb+eayqfpKns32n1/i0E40Bn4hT23AszgMAzCu9x/IgwqHqykjA2H2rRGOwzf/uYRL7x/okAWZQpCJR/W7umzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=U4vdvypf; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="U4vdvypf"
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNGtIw2732264;
	Tue, 21 Jul 2026 07:18:09 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012071.outbound.protection.outlook.com [40.107.149.71])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4fg2uh227a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 07:18:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKeIYMZIEcP5Ntyvnd9mU+AhEbSuVoIsoYiHRiIfUZGoEUKwLCbcg0IaNjUPZUefrDe5jml+Xy+XgUhLtBmay326H/OOpRK/QY6R/tE+WMbFyYkOToTftuhQh99g/K8FMT1hcICJbcOh0dFIxAtqm9T1DrM62SYsyrYnuDLkgGCV8nlRgJS2/+v5mLl7L7f8zauxb3izJG4v+EIa7xn9k3uN+PqVpmENBoHiaegxdTxbMa0g+yAyXiDpHFIxICuI0NsUtJrIr5wGWEswJKgyVng8RFLDpqivA+ByqwdvNURhBIVGNHElm1nPtKbmz1iLQuY3sl8BXxLsyc6OrgfJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAhDjPIpwPKTK4mHe8dlEq30Ol++nh94TaQaEsCd2ak=;
 b=pf5OqaYTo+4Ga1k97PNPQnrvX4eSSbRl7SVKucE1n3ZPHbp9dTR38C84k0OqfSZMI/tgLat7smniimg/IfG+W2wxBDcM1MvUT+mHJCwNT902rgxcMFGpXZNO6waJ4mhLu87gUWADxptduhxTxNu5Z4OiGTf4istjX74j3iZM0jQ3dp2q6zl6N7qs6lDjFtwNR7CTOi+YOG5348d/mfjwNLSriOmO9GfjAuE6deMMf4ojEBNRgw9LrwXhsgtB8sXTUt2nhwtfFJInPrD49w/Cx21qOeI+/ueMWBMIsNiuTHQ9AJ98fxNa7TGxpirYp3UxNWLutPpE+Mfutxu3ONEBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAhDjPIpwPKTK4mHe8dlEq30Ol++nh94TaQaEsCd2ak=;
 b=U4vdvypfdOKcgMQDMJMNe/k5rxrG8QvuejnvVyCIm+JFDAKo1yMYs55UZmJk7ndiDCGYC0/x+Ufc9vJvlYwP+ZEIlG8copP8Jt7mD/cd9blYE72YlR2f84Q17fX/fj98jY8IBntryyM2qTNS88JRZpjnxFoP36Yn5jOssfJF+8B4num/mgOEPX43itX7KbY/goHAzpVT5wlzu9iVbl+fj56I8TrN31wZFwU9LVZJlitnEKQ5rV35Z9/TWALduy7sc0ysKFUjrHsjJx68AQqfbQN9FAQhg50mTxq1MtSDrmD7TH87yi3t5oWhUy/K+anZql32RLwRdq0JL6CHw1czrw==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR6P281MB3724.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:18:02 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 07:18:02 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Luca Weiss
	<luca.weiss@fairphone.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add support for icm42630
Thread-Topic: [PATCH 2/2] iio: imu: inv_icm42600: add support for icm42630
Thread-Index: AQHdGG4jHFeCjRjw3EeBpGne1WSz2bZ3kGNw
Date: Tue, 21 Jul 2026 07:18:02 +0000
Message-ID:
 <BE1P281MB142628222E8A8A94CDBB5693CEC22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
 <20260720173411.82979-3-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20260720173411.82979-3-jorijnvdgraaf@catcrafts.net>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR6P281MB3724:EE_
x-ms-office365-filtering-correlation-id: 164a9463-f155-4bc0-b401-08dee6f833a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|3613699012|3023799007|38070700021|56012099006|4143699003|11063799006|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Ndbb8EGyfFKd1m2Cr3Nb+9KkUKL29J1qXwRSTzizacJbcSMjUjbO+dgdCMfhKlCv0x57WSbDoAglTl6j2VO8MNU9HdoQmIGeLJs54gYN3Ca3assG/3IqzRC03vHpglic6wUTwMcE1RRPleEdXF6YLD/E+iLTHEt+0MBFny+aFneNfv6s/8BRG/bGyaDIwgYbkLja1PThdCdgmlO2+2P0jrMOR84GSvKW6WEnreIbKSAclXw1AMzU3fgdeqDZN/fZlzqAMo9ayhcnsrLF0u0rcpBuTZdDzd8p4wMKr0z6QymJrU7V9K9P1nhWnBFEb7KdIMrQYXhi9y4f0bBsoHVm0KPs9d5L7Q9KwCC3Uoy6YEwWdq53l2zXHGG3tiEiLIXdjY3h8ctgVxS4pH++Am1d1mDL9tALurK9PbCm+JOFCQipnAijULeeaBorNgTOBZXZGU8zEhfPKGeIydxaE70vvwXPwTT70MfC2uZ7YAqVWdQoPA+tfGPfp0Biu29ECfGRVgDxy6Sfgr1lC8i8S7hN0995tEAsKdsddbiRh9e/UhwwhFybv1X2emK6DvgfoU3emuK2hjK162PzdROXlpmJtv0P0/rCaPd9xH81HeYbbNyfmqd54X3Ty1vk9iH5FdYVsN0Z2dj9cnsyO5hmUObJp693hUdvlwrjWO4Y4SPx4N7Hrdo79CMI4FRcfulqSstWgb44SvS4lO0InG6N06AJ11mEL+sYAtYK5xgWMhYv2/aqn41IwoLrTOA80nP5rA0u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(3613699012)(3023799007)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0U5N0ppaEFRR0pLKzN6aVh5YXJSS0lOWUlMOWF3RC9DZTNqVSs0OTFBQXNZ?=
 =?utf-8?B?TkRJN1ROUkpsck5OZjFGcjRDeFRzZEM0ZTdXR2JzREZ6dmpBWitZcHc2cW5o?=
 =?utf-8?B?RzFvRVZWVVdQdjNlK3k5TFFuKzFFZ3R4T2l6NE9pU3ROQ2RYMHlSSzNXUUhB?=
 =?utf-8?B?azUwVzFsV09xcGVDZUZkMmZYL1I1ZzlodFVmdmVtQWFXTWdXTDFxcnZUdGd4?=
 =?utf-8?B?KytiOEF2MjZyMlVNZ2ZFdWhPUHVyU2NZb2EySUdTYjBkdmY2K1c5UEQ2SDV5?=
 =?utf-8?B?anpRK2hyMTlSejUrQlhzMy9xTmJtdHQ1bnkrbUlqclNtekxpUWkxNGZKQm9s?=
 =?utf-8?B?WmlETmVRUnZxRkRjeFdMRDJQcklibGhGQUVIMThjb1hOdzFza2ZRMlppcFhs?=
 =?utf-8?B?MTNiYjB2UWRwVXMzWCtFenNrMjF2cVA2ODNQVCtFMDFSaDdmNTdVU3RTOWFu?=
 =?utf-8?B?V0F2MXVWRzJpY2ttZ1hDY0UrZVVCZk1VK0Jya3pjNXFmdjEzR0s5ZjBLYVFM?=
 =?utf-8?B?bTlKOHFIRWJrMk1RbjY0SHZDckdTZVl4T2kvQStSanp5anQyRXZoekMrRWFy?=
 =?utf-8?B?NTl2V0FIWk5aYk9mSUFyNHlsL1JnYmNBOUtqakRrNDJDR25YZHJ4bHVvSy9L?=
 =?utf-8?B?RjRGTDU4M1IyRzNocnZZd29zZFhKUS80STVwK2hSTno0M3pEempGYzRXM3JT?=
 =?utf-8?B?UE5sRlFvTkJobloyakZMcTFSc0hBSkxTeWwxMzQ3Y3NEZ0s1eGE5R0o5akc1?=
 =?utf-8?B?RURSVGR4dzZaQ1dwZDcxaHBaemRkenFXaW5YWmMyY1MydXZXMlpvWTA4anAz?=
 =?utf-8?B?ZjdQRlVia1dZQm1LVm5IWUZyK1NiVnJPL1p3eHcrNkcxZVdGMlpSTHUrZUFY?=
 =?utf-8?B?dUxjVkltcGQ3N1JCLyt4MEplRkZLVU01QnJEeU5JbmRUS1BCTEQ2clVUQk9z?=
 =?utf-8?B?L2E0dGI2QlJLZllXeS84enM3aG9OaXBuOGdaUlU2bkhmN1RpMVNBZnhWWE14?=
 =?utf-8?B?aGs4anR0MEJET1g2TUE0a055QWoweVMvYWNvM3d1YTFNcjNadEFOUW9mUnVN?=
 =?utf-8?B?dnZmendncEJ6U0FCcEFjbittczhUQ2xuMVE2OWlWQzNHS2x5VE9LemVHbkZL?=
 =?utf-8?B?T1Q1WGptLzRJRWhLNnVJTnNFTStqWFlzQ0NXU0VTVVlUOXVtTGFmREpVYUJG?=
 =?utf-8?B?Qk82VGtnSy9sb2U4Z25iOW9wNFBXNXJuUk1YK1JCTWRDZ1h3VjhwWFJ6RUQ1?=
 =?utf-8?B?VkQrTm9MYkJqcVhmQi9pVlQ1eE0weGljcFNENys3bEtrclhYUElJSVEycENh?=
 =?utf-8?B?UUN2akZyQW5mTWtrR2F5QW50VUk4U2srSGh3UlVHcGo3bnhXMzh0SFlZOG9w?=
 =?utf-8?B?dHZpUzM0MjR0cnpBWUFxWjNTSkpaZ0llR29ZZldJZ2pyQUFxSDVVK0svOE43?=
 =?utf-8?B?ZE5SbjlUTlBRR2hmMmZsdk5Fc243dzBycFpqdWlDMHF6cFB4YjRmcGttdXBD?=
 =?utf-8?B?Z0dPK3lENXM2NFFCbHBxUloyb2g3VGZuSnBWSkFuRmRQck5FS01hRGZURENQ?=
 =?utf-8?B?NXZ3S2JTWjVBZWJ6UnFvUVpaS0IxYmVBd3hRNUtLTnBXR0toV29YNW9weUcw?=
 =?utf-8?B?OUtSbXBPaWlIRVp2eTBpSmRWWDdQRFpZRUg5aklCQ0ZXSWJBa3pxczQxbmRZ?=
 =?utf-8?B?a0NjN2NCVmptUWFNck9VL1FFai96UEhUOE9WaG5HNkl1N3l1bFl5aC9zVGta?=
 =?utf-8?B?aE1lc2dLaG9vZkpQbkp3bXVnbnZzUzlQV2ZUcHEzZnpwUi94MjFWMTlkTFBE?=
 =?utf-8?B?UFRHR0lZQk0yeC95cHVLaXl2M1lwQmY1VTk5V2prcUhKTWN2bjZ5d0pKVlhS?=
 =?utf-8?B?U2FjQjhTaGZEckRmcFoydWlqY2R6VlJEWm1kUEExZkJlWGUyOU5Kd3BHcUkv?=
 =?utf-8?B?Vnk5Zmw2Z0YvOUh5ckFqeW5IdGsrYWZBVkpxWFNYMnRkYk1CeDdKZnlocG9L?=
 =?utf-8?B?d0VaUEhEQzUxc1pMdnZzeWJTZm9jb3VVdU1Mem04VmFTWWpRUCsvaVdBWGlw?=
 =?utf-8?B?WmZ5bmpneVZxMG5GdHZHSHU5MGNDdWVjQXVDNEtYQU5zMnQyWS9YWEhiL3py?=
 =?utf-8?B?dFRQYVRYcEZheEQ1dFBqS3JtL0hWTFlGaUNEWmJicmhQdVFRVktncC8vRWhM?=
 =?utf-8?B?YVY4UDZ0c1hqMU85bFdsQlVnTzRBMFNnYmVFZjVUN0dhOFZ2Umh2MjlJMWJO?=
 =?utf-8?B?Rlc4MHZnS2JuNVhBRG00QjhCYlE0Nk1xTHloNktuRXg4WTBzSTljTXV0NVUr?=
 =?utf-8?B?elV2ZlBRamI2bnRCTFQ4QkFNdTdkL2tRR2pQa0hzT3haT0tIK0RnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	d+Vz8d8XCwTyHc81FFRjdSlOBD05wMoaITViSf6AKEvKFfb4XsKAYvoKMANw6K2DxP+12OtVpd0VaptCyf7wHYEsRGHj7lHuWLxYAPwAuosZ7c7f3OEKWq4AtUBa0eWVN0XF5SbXBY6wDXIKvXmUhqEXpC9SMXZoMPJ+v0n55OQzJqcHgeeddeqslyenQ8o1uz2JmNstAyxgKEajUrxkUjhcXPpYvMrvU0+q9bz2m10BLbond6cOesJgjMz6AREyUL9d8FgKucZKhS8fluRLfPaJ5Qb1WZ8YbnGLi8Ss7OL1pZo6KBAKQ7EVMeIp38ArvE/tH0mZYbx7udhNzRpntA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 164a9463-f155-4bc0-b401-08dee6f833a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 07:18:02.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIsc0W8OyBaJ2Ts3bmlzuHO6t0Y079vaBzcf++FLIHcfRk/ssWBiT33hHbo+fFKfWwUXCQrTa0b3FV1N9+JWKY3IpUTWRmd7Sfvv5On+nEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3724
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3NSBTYWx0ZWRfX9XO635vEjYw6
 q9IwBCmjW0OM85C6k4KPcpVumrK5EMIUR/+y1lwQRrV1Wkzi6PnBxzGlrj5hnaeir1uVP/80bjO
 ux+kUFyqoBlKb96IOfIW8tVoXiCrnWpFTwIKuB7AUL63aKGgKpH5jpqn5hy+L5hELXWtR8d1ba7
 9UWHLztU/i280br8fPoSaZqhdG+7eumSmW2KtKldE67rwgN6mFWN4aUM6kbpojlFsOrmj6Xkddp
 sH5SiTJYwdeiGOibXTRgn/l65rpd9Dz0vhJRP/AVFcxps0OW7jM65WfFXrwGlhCj4B8w3mSvu/8
 R4javj0Y1fwSVolVCTzxtrwgxXuAAl7+zwvDqMFyw5zfoxo1LQ/pL+ImIPSrb6Zt2uhr/mxpnEh
 rg3z6wdrc5g7rHeCsE4CXo40k4ztL9iUBUjYvcNhiOFss0jQlVS2J7yw++G0L42wdIlxoh9gqNl
 l1VDqGIdcsYN6kDOfUQ==
X-Authority-Analysis: v=2.4 cv=Zr7d7d7G c=1 sm=1 tr=0 ts=6a5f1d31 cx=c_pps
 a=B2cilY5VD9L5wy5swUF0cg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=GYSh3LzNAAAA:8
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=nB8ElLmQJyTU4s9uYegA:9 a=QEXdDO2ut3YA:10
 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-ORIG-GUID: forAYxpQi2b7bx2rMAoKIA5AKAF1K24P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3NSBTYWx0ZWRfXxuxcPdH0Cleo
 VUhsYoH8erlCQiS7wDlO5PJJpJwdcoofYUZ88tqQvsFkLPfzime6Y7IyPsrGJnMiETPWGd0a8fP
 YSTGYFOe6cPXRkCLZNEiYEbTVY0xG7XmC0zONr5ynmn0vgh37SLi
X-Proofpoint-GUID: arZsdNwfJ1OlZhnhKQ5_RhpypXDQ3BAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210075

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTogSm9yaWpu
IHZhbiBkZXIgR3JhYWYgPGpvcmlqbnZkZ3JhYWZAY2F0Y3JhZnRzLm5ldD4KPlNlbnQ6IE1vbmRh
eSwgSnVseSAyMCwgMjAyNiAxOTozNAo+VG86IEpvbmF0aGFuIENhbWVyb247IEplYW4tQmFwdGlz
dGUgTWFuZXlyb2wKPkNjOiBKb3Jpam4gdmFuIGRlciBHcmFhZjsgRGF2aWQgTGVjaG5lcjsgTnVu
byBTw6E7IEFuZHkgU2hldmNoZW5rbzsgUm9iIEhlcnJpbmc7IEtyenlzenRvZiBLb3psb3dza2k7
IENvbm9yIERvb2xleTsgQ2hyaXMgTW9yZ2FuOyBMdWNhIFdlaXNzOyBsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZwo+U3ViamVjdDogW1BBVENIIDIvMl0gaWlvOiBpbXU6IGludl9pY200MjYwMDog
YWRkIHN1cHBvcnQgZm9yIGljbTQyNjMwCj4KPlRoZSBUREsgSW52ZW5TZW5zZSBJQ00tNDI2MzAg
aXMgYSA2LWF4aXMgSU1VIG9mIHRoZSBJQ00tNDI2MDAgZmFtaWx5LCBmb3VuZCBlLuKAimcuIGlu
IHRoZSBGYWlycGhvbmUgNi4gSXQgaXMgcmVnaXN0ZXItY29tcGF0aWJsZSB3aXRoIGl0cyBzaWJs
aW5ncyAodGhlIGV4aXN0aW5nIGRyaXZlciB3b3JrcyBvbiBpdCB1bm1vZGlmaWVkKSBhbmQgcmVw
b3J0cyBXSE9BTUkgdmFsdWUgMHgwQy4gVGhlIHBhcnQgYXBwZWFycyB0bwo+WmpRY21RUllGcGZw
dEJhbm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIKPlRo
aXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4KPgo+WmpRY21R
UllGcGZwdEJhbm5lckVuZAo+Cj5UaGUgVERLIEludmVuU2Vuc2UgSUNNLTQyNjMwIGlzIGEgNi1h
eGlzIElNVSBvZiB0aGUgSUNNLTQyNjAwIGZhbWlseSwKPmZvdW5kIGUuZy4gaW4gdGhlIEZhaXJw
aG9uZSA2LiBJdCBpcyByZWdpc3Rlci1jb21wYXRpYmxlIHdpdGggaXRzCj5zaWJsaW5ncyAodGhl
IGV4aXN0aW5nIGRyaXZlciB3b3JrcyBvbiBpdCB1bm1vZGlmaWVkKSBhbmQgcmVwb3J0cwo+V0hP
QU1JIHZhbHVlIDB4MEMuCj4KPlRoZSBwYXJ0IGFwcGVhcnMgdG8gYmUgYSBtb2JpbGUgU0tVIGFu
ZCBoYXMgbm8gcHVibGljIGRhdGFzaGVldDogdGhlCj5pZGVudGl0eSBjb21lcyBmcm9tIHRoZSBG
YWlycGhvbmUgNiBwbGF0Zm9ybSBkb2N1bWVudGF0aW9uIGFuZAo+c2NoZW1hdGljcyBuYW1pbmcg
dGhlIHBhcnQsIGFuZCB0aGUgV0hPQU1JIHZhbHVlIHdhcyByZWFkIGZyb20gdGhlCj5oYXJkd2Fy
ZSwgd2hvc2UgYmFuayAwIHJlZ2lzdGVyIGRlZmF1bHRzIG1hdGNoIHRoZSBJQ00tNDI2MDAgZmFt
aWx5Cj5sYXlvdXQuCj4KPkFkZCB0aGUgY2hpcCBpZCwgV0hPQU1JIHZhbHVlIGFuZCBJMkMvU1BJ
IG1hdGNoIGVudHJpZXMsIHVzaW5nIHRoZQo+ZmFtaWx5IGRlZmF1bHQgY29uZmlndXJhdGlvbiBs
aWtlIHRoZSBJQ00tNDI2MzEuCj4KPlRlc3RlZCBvbiB0aGUgRmFpcnBob25lIDYgdmlhIGEgYmFj
a3BvcnQgb2YgdGhpcyBjaGFuZ2UgdG8gdGhlCj5kZXZpY2UncyA3LjEtYmFzZWQga2VybmVsIChv
bmx5IHRoZSBpZC10YWJsZSBzdHlsZSBhZGp1c3RlZCB0byB0aGF0Cj5iYXNlKSwgb24gYSBiaXQt
YmFuZ2VkIFNQSSBidXMgd2l0aCBJTlQxIHdpcmVkIHRvIHRoZSBTb0M6IHByb2JlLAo+YWNjZWxl
cm9tZXRlciwgZ3lyb3Njb3BlIGFuZCB0ZW1wZXJhdHVyZSByYXcgcmVhZHMsIGFsbCBmdWxsLXNj
YWxlCj5yYW5nZXMsIG11bHRpcGxlIHNhbXBsaW5nIGZyZXF1ZW5jaWVzLCBhbmQgd2F0ZXJtYXJr
LXBhY2VkIEZJRk8gcmVhZHMKPnRocm91Z2ggdGhlIElOVDEgaW50ZXJydXB0Lgo+Cj5Bc3Npc3Rl
ZC1ieTogQ2xhdWRlOmNsYXVkZS1mYWJsZS01Cj5TaWduZWQtb2ZmLWJ5OiBKb3Jpam4gdmFuIGRl
ciBHcmFhZiA8am9yaWpudmRncmFhZkBjYXRjcmFmdHMubmV0Pgo+LS0tCj4gZHJpdmVycy9paW8v
aW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDAuaCAgICAgIHwgMiArKwo+IGRyaXZlcnMvaWlv
L2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2NvcmUuYyB8IDUgKysrKysKPiBkcml2ZXJz
L2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9pMmMuYyAgfCA0ICsrKysKPiBkcml2
ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9zcGkuYyAgfCA0ICsrKysKPiA0
IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwLmggYi9kcml2ZXJzL2lpby9pbXUvaW52
X2ljbTQyNjAwL2ludl9pY200MjYwMC5oCj5pbmRleCBiNTVkOTkzZjAyNjQuLjM0OWRlNTQ1ODU4
MSAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAw
LmgKPisrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwLmgKPkBA
IC0yOCw2ICsyOCw3IEBAIGVudW0gaW52X2ljbTQyNjAwX2NoaXAgewo+ICAgICAgICBJTlZfQ0hJ
UF9JQ000MjYyMiwKPiAgICAgICAgSU5WX0NISVBfSUNNNDI2ODgsCj4gICAgICAgIElOVl9DSElQ
X0lDTTQyNjMxLAo+KyAgICAgICBJTlZfQ0hJUF9JQ000MjYzMCwKPiAgICAgICAgSU5WX0NISVBf
TkIsCj4gfTsKPgo+QEAgLTM4Niw2ICszODcsNyBAQCBzdHJ1Y3QgaW52X2ljbTQyNjAwX3NlbnNv
cl9zdGF0ZSB7Cj4gI2RlZmluZSBJTlZfSUNNNDI2MDBfV0hPQU1JX0lDTTQyNjIyICAgICAgICAg
ICAgICAgICAgIDB4NDYKPiAjZGVmaW5lIElOVl9JQ000MjYwMF9XSE9BTUlfSUNNNDI2ODggICAg
ICAgICAgICAgICAgICAgMHg0Nwo+ICNkZWZpbmUgSU5WX0lDTTQyNjAwX1dIT0FNSV9JQ000MjYz
MSAgICAgICAgICAgICAgICAgICAweDVDCj4rI2RlZmluZSBJTlZfSUNNNDI2MDBfV0hPQU1JX0lD
TTQyNjMwICAgICAgICAgICAgICAgICAgIDB4MEMKPgo+IC8qIFVzZXIgYmFuayAxIChNU0IgMHgx
MCkgKi8KPiAjZGVmaW5lIElOVl9JQ000MjYwMF9SRUdfU0VOU09SX0NPTkZJRzAgICAgICAgICAg
ICAgICAgICAgICAgICAweDEwMDMKPmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X2lj
bTQyNjAwL2ludl9pY200MjYwMF9jb3JlLmMgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAw
L2ludl9pY200MjYwMF9jb3JlLmMKPmluZGV4IGRjOTdkOGEyNzRlMy4uOWEzMWNhMzYxNWIzIDEw
MDY0NAo+LS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfY29y
ZS5jCj4rKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9jb3Jl
LmMKPkBAIC0xNzcsNiArMTc3LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW52X2ljbTQyNjAw
X2h3IGludl9pY200MjYwMF9od1tJTlZfQ0hJUF9OQl0gPSB7Cj4gICAgICAgICAgICAgICAgLm5h
bWUgPSAiaWNtNDI2MzEiLAo+ICAgICAgICAgICAgICAgIC5jb25mID0gJmludl9pY200MjYwMF9k
ZWZhdWx0X2NvbmYsCj4gICAgICAgIH0sCj4rICAgICAgIFtJTlZfQ0hJUF9JQ000MjYzMF0gPSB7
Cj4rICAgICAgICAgICAgICAgLndob2FtaSA9IElOVl9JQ000MjYwMF9XSE9BTUlfSUNNNDI2MzAs
Cj4rICAgICAgICAgICAgICAgLm5hbWUgPSAiaWNtNDI2MzAiLAo+KyAgICAgICAgICAgICAgIC5j
b25mID0gJmludl9pY200MjYwMF9kZWZhdWx0X2NvbmYsCj4rICAgICAgIH0sCj4gfTsKPgo+IGNv
bnN0IHN0cnVjdCBpaW9fbW91bnRfbWF0cml4ICoKPmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9p
bXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9pMmMuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZf
aWNtNDI2MDAvaW52X2ljbTQyNjAwX2kyYy5jCj5pbmRleCAyODU1MmQyZGI5MWQuLmM0MTM5MDRj
ODY4MCAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQy
NjAwX2kyYy5jCj4rKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYw
MF9pMmMuYwo+QEAgLTgxLDYgKzgxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNl
X2lkIGludl9pY200MjYwMF9pZFtdID0gewo+ICAgICAgICB7IC5uYW1lID0gImljbTQyNjIyIiwg
LmRyaXZlcl9kYXRhID0gSU5WX0NISVBfSUNNNDI2MjIgfSwKPiAgICAgICAgeyAubmFtZSA9ICJp
Y200MjY4OCIsIC5kcml2ZXJfZGF0YSA9IElOVl9DSElQX0lDTTQyNjg4IH0sCj4gICAgICAgIHsg
Lm5hbWUgPSAiaWNtNDI2MzEiLCAuZHJpdmVyX2RhdGEgPSBJTlZfQ0hJUF9JQ000MjYzMSB9LAo+
KyAgICAgICB7IC5uYW1lID0gImljbTQyNjMwIiwgLmRyaXZlcl9kYXRhID0gSU5WX0NISVBfSUNN
NDI2MzAgfSwKPiAgICAgICAgeyB9Cj4gfTsKPiBNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgaW52
X2ljbTQyNjAwX2lkKTsKPkBAIC0xMDcsNiArMTA4LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgaW52X2ljbTQyNjAwX29mX21hdGNoZXNbXSA9IHsKPiAgICAgICAgfSwgewo+
ICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDI2MzEiLAo+ICAg
ICAgICAgICAgICAgIC5kYXRhID0gKHZvaWQgKilJTlZfQ0hJUF9JQ000MjYzMSwKPisgICAgICAg
fSwgewo+KyAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDI2MzAi
LAo+KyAgICAgICAgICAgICAgIC5kYXRhID0gKHZvaWQgKilJTlZfQ0hJUF9JQ000MjYzMCwKPiAg
ICAgICAgfSwKPiAgICAgICAgeyB9Cj4gfTsKPmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUv
aW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9zcGkuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNt
NDI2MDAvaW52X2ljbTQyNjAwX3NwaS5jCj5pbmRleCBmYWY3NDNiYzY0NDQuLmExZDEyY2UzYmY4
NyAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAw
X3NwaS5jCj4rKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9z
cGkuYwo+QEAgLTc4LDYgKzc4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lk
IGludl9pY200MjYwMF9pZFtdID0gewo+ICAgICAgICB7IC5uYW1lID0gImljbTQyNjIyIiwgLmRy
aXZlcl9kYXRhID0gSU5WX0NISVBfSUNNNDI2MjIgfSwKPiAgICAgICAgeyAubmFtZSA9ICJpY200
MjY4OCIsIC5kcml2ZXJfZGF0YSA9IElOVl9DSElQX0lDTTQyNjg4IH0sCj4gICAgICAgIHsgLm5h
bWUgPSAiaWNtNDI2MzEiLCAuZHJpdmVyX2RhdGEgPSBJTlZfQ0hJUF9JQ000MjYzMSB9LAo+KyAg
ICAgICB7IC5uYW1lID0gImljbTQyNjMwIiwgLmRyaXZlcl9kYXRhID0gSU5WX0NISVBfSUNNNDI2
MzAgfSwKPiAgICAgICAgeyB9Cj4gfTsKPiBNT0RVTEVfREVWSUNFX1RBQkxFKHNwaSwgaW52X2lj
bTQyNjAwX2lkKTsKPkBAIC0xMDQsNiArMTA1LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgaW52X2ljbTQyNjAwX29mX21hdGNoZXNbXSA9IHsKPiAgICAgICAgfSwgewo+ICAg
ICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDI2MzEiLAo+ICAgICAg
ICAgICAgICAgIC5kYXRhID0gKHZvaWQgKilJTlZfQ0hJUF9JQ000MjYzMSwKPisgICAgICAgfSwg
ewo+KyAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDI2MzAiLAo+
KyAgICAgICAgICAgICAgIC5kYXRhID0gKHZvaWQgKilJTlZfQ0hJUF9JQ000MjYzMCwKPiAgICAg
ICAgfSwKPiAgICAgICAgeyB9Cj4gfTsKPi0tCj4yLjU1LjAKPgoKSGVsbG8gSm9yaWpuLAoKaXQg
aXMgT0sgZm9yIG1lLCB0aGFua3MgZm9yIHRoZSBwYXRjaC4KCkFja2VkLWJ5OiBKZWFuLUJhcHRp
c3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+CgpUaGFua3MsCkpC
