Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE0372698;
	Fri, 15 May 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836086; cv=fail; b=aPhDuHX29nOmWN3sc/3BH4tEsAdjRRm/MPFkpBRTs4+oCQGb1VbUx9dTYOLzwUgDD0VOSJ5/XMoJ4YpPBFXFSsWZKKC9/JGX0NHmhtxKBZj81l8vhVU3zPimSPi9c8dsBptLX+P3LPciemOr0VbAvCvFx5enlzRC1d+j6mL/mTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836086; c=relaxed/simple;
	bh=14c3uFMaeh6geNiL16QC+u5+gf03fT69hYXQtkdNllI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbvmYryuXC36i5C8K7tVfgOh/hft6YYd7E+n8bX132jeUgtC6AJgFbMxps62dBxxJdyHKWE2Gsz8/Q0Kza2ov7CcvsEiFV4d72zvhtoxsz7fDzM+5reEOs3kWHQLqA+B605wFmzucjEs7zh/ZtSENTkPawuZI9yKHs7jLdR45aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vRAG+ZgY; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vRAG+ZgY"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F7YRCc2162093;
	Fri, 15 May 2026 05:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=14c3u
	FMaeh6geNiL16QC+u5+gf03fT69hYXQtkdNllI=; b=vRAG+ZgYPjciFVsnHtX/n
	arSqxVoakH1pQQXn1ogrigE7D+fzKGYHXgPBP3i66yUig1LUi0MhvSXneSIq8ZG/
	oj4wmRCOWV8tarwJiesvvtsCz1oYmEXD5/xz0gWnzNOxgdSkPCR/IEM6naWanpAH
	bL2sv8L1PWHW0xqjzjRgiQhWRlK4kOYegsQye+y9aB1qge7hwSHx88nF6lfN0TUV
	euvp3Ul9+0Jo2EmRLDLWNDL6KWnlX/d7HHJUWujreRgxDwbZCE50DD/lm6hlR0BQ
	1v9AFZ6oxi4c8Q+dh8MuDBd5FGK6tmDIY5mBhnUEUDA+d2I3xXRhB/a7kIHTX/gF
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e5m2xjdkt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 05:08:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WivnXh93T5RzWzww56GlDrDp2kvLwqHNv7dRg+W0W2BvmySRphJbC4lUBnqqs+4u9rYbOUQYVWlVQeOhlnW9FKVn9bYVfTo8qoCYZMiUXX7kr6vp7zUogHUVIzmf79Vexc7qVRJXfCmfyRt7abNoK7kFQvRNTXbYsqQoEkOsr0XMcCpQbuelTawEc76U5FVVDr7YnYMfiPZkdl5a8etzQrJftUeV5U4vhBYg6w3luFLu2HCiYhyHD2ZH472w/YcYwtfZyDyce8iq7vJDyxUBXFhZeiJILih5k55mCvt/ZlkbX74TFZd7DXS7auvMXcHZRMbJpKPQiFKiC4MmTvw2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14c3uFMaeh6geNiL16QC+u5+gf03fT69hYXQtkdNllI=;
 b=ITH32DuL9vaeq4kWAeaU6EIiMfq1QSXKR5g4x9hB7gm0BFiLpr5MUCiioe2QVrKYU84f+KUsIoGmNOqjMx4gbTTF8GsMPnZF3WIqLPiuDFoNNmm3NQrh8CaOTR0M6EbUZT6kjcWcv7GcL1nmDTA/m0EwYiE1lUda/haJ1aDzbMJSTnlBnWCe89n20pMKsWf3qoCYJtvBDj4ajNecM2FBU6WCYRfaTYNIO0vSVqEa6K182u6SFWzZKXuFR0DMsHcfuLY9C+FfVcPxD+A77Hp6ojIGdwvOeijnwFf7DhkYmGKr3KxyZtFXvV1WwtN/mhFXclsMIOyI1cIqByk3z90Ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by PH0PR03MB5896.namprd03.prod.outlook.com (2603:10b6:510:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 15 May
 2026 09:07:54 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%4]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 09:07:54 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Francesco Lavra <flavra@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miclaus,
 Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        linux <linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for
 ADT7604
Thread-Index: AQHc47EClIM3xYOGDkCh1l5fvldR27YOxRMAgAAGTRA=
Date: Fri, 15 May 2026 09:07:54 +0000
Message-ID:
 <SA5PR03MB8377BBAC8F179B0397A1C8F4F6042@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	 <20260514144712.64374-8-liviu.stan@analog.com>
 <fe013c5a2a1e62a9d1085a4ed16cfb08837a313a.camel@baylibre.com>
In-Reply-To: <fe013c5a2a1e62a9d1085a4ed16cfb08837a313a.camel@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|PH0PR03MB5896:EE_
x-ms-office365-filtering-correlation-id: eff11984-b193-403d-cdc0-08deb26172e6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|38070700021|22082099003|921020|11063799003|4143699003|18002099003;
x-microsoft-antispam-message-info:
 Z88q7AOXWP9Uz4vacDYggjldbE1IyGYCfuCaGoync5NKp1rH+0Kto5wDiDaGcgiQPgp3TvkQ1nn2C6acr4XZ4g1ER2gNREEYH6J72b42MoLMsrGM7l8tveDLbFHY++NUzHTQX3rnJFoVHSbvCoHS1VQjLGUGc1wLlUT1g7oEG8lZIGtDCifdLJYfChkSAu/0XnPyyJ2RAkWQQzwo5rYCj4EBlZJd5sWqmVg6dRhqM3HjGzoZYV564rSBI8DGoCLYKON+RK6H5XSz1YTrAdYARKvHDbYwMTZiBorzi3nFeoJt3xZHe6s+XeSeCMXlVAAJqsCSZpRUDdtzQ7L4T2PX0AS4+wRIPUd9q/wJwv70LYZfsSyMw252vm2TXHi0K9M18TS4Cd49MDAVkzaMfFjd8OurDAEHCeJJRr0rza6k6owj4B48MXnBRqMAo1/xs0X1If6LErTL8ueAup5S8qlRrKkYBa7LVPTQ8+C8eaMrBOCV4rergTJAdrVDNXQJC88K1C3ws29kZ1BCYZyO6v3vZ4ByfQR6hdJ4PDhEuNezjKpkgNjQ3IXmEw0/kLR99nPlge7MVY+/zfSuJttALg0vYz0s3tbQypfbFiNbvNp8z/dIv7Wqb+5g5UfQPgTpM0i0m7DUNSdk9VRztIdI8+SAB2mXR9gourF/LGguXQyOEei+Lx2HGFIdjUrIrr11VabAJoNjsUTPtPqyrlh0YEAPjioofQqiQyCAeLRP4CpvjOPHoAOaJeSYaAeCi2pwseDWHNKO2zNayceFUIHkEY3ypQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(38070700021)(22082099003)(921020)(11063799003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dE5wNDFRY25yL2NyK0tDRndvSGJuNGc3TnBKMVk0TkdJQjRSOSs0dGxxVUtt?=
 =?utf-8?B?RG9HTlFyL0RXbkNwSDNNdUpwQVhha2tJTmF6VDBJTzcwU3kzRWtPTmkySEtH?=
 =?utf-8?B?UTk5TkxBeVp0YkkwbDhITy8xNmh2Wm44ejhqbkNlbzk5YmZJTUYvT0Q5c0pW?=
 =?utf-8?B?NGx2elNFSFdRUENYRk44M1V1TXV2RWhDYlljTzB2Nlp6Wk1oQXNHblZYTGJE?=
 =?utf-8?B?NTdBd2tTL01Fdk9iYkxZcEJLSEJZTXFyMTUvZ2tUdWU4STJ4SDhrb3pJUmE1?=
 =?utf-8?B?Ry9jYUNJK3FTY2ZQL0MzLytzaFk1Tjg1OWhuTklsVm43anVHWWltczJlY3V6?=
 =?utf-8?B?WGxqNDJnVkNuSVJCWnRIRlRUdTc4b0lvYXJ0ek92VHdyV3dWVmFoYU1wRkN6?=
 =?utf-8?B?OFBnalM3eDQzVUFTZ1R3YW4vVC80RURXUVFNUk1aZTZjRWtqZ1dTOU55ODZT?=
 =?utf-8?B?WmJGTFN4RnE2ZGNJRDZHS3RJa0cvNUZrL3B1VEVTZnRlTzR3ZFRoM09yOUpo?=
 =?utf-8?B?d3RtdDBuamJGREhjSWlmbWdsTk04R0xwUFA0bmxmc3J0V09XUmVWY1Nnc1Rm?=
 =?utf-8?B?YXVHTGVPaHNYUEJyZ1NJeVZMNVJuaEdrdjg4ZjNGYW4wSER6TzJIc3ZOUGs4?=
 =?utf-8?B?MUhjUlJsam5WQXNrY3gxT1pXZkE5U1dLWFIzbnhqTVo5a3V3dXJRN05DaVVV?=
 =?utf-8?B?SzAzYVVLS21oU0Jna3UvUGZWcXpPMUJIR1pkUXV1aXlDL05wUHZYKzFVMmNK?=
 =?utf-8?B?Q0JXZ3BOK3BZRjJGR1lyQ3owdFlsNWFjRUVnWnpYQ052bVo3WmlpcGdmb0Vl?=
 =?utf-8?B?Mi96ZWNNYnNydUZpREdwRTZkQkFyRmU4ck9wODM1akN1R0FOWmFVeWI1RVpy?=
 =?utf-8?B?aWhGSjV6WWdxZE1iVFlYUThhV1ZTWXhKbHZ4cnAwaU9XRTVPYjFtUDZEd0Jq?=
 =?utf-8?B?NDBKYnNiVlpoNVUyRjlLNU8rZHpjaFUyUnJzTkQ1VDJsUnRMUWozMk5jQU9N?=
 =?utf-8?B?cVNLTlhpaDVydm9HOHVkSzJ5YUFaUjlFMUg1Qlh1SlVYR3FiaWhObmRZUkow?=
 =?utf-8?B?cW9SeUF3dDFLc2paei8yenR6dTl1NWlhY1NkdmgzTkFaNytLZ3hGK1o0Ty94?=
 =?utf-8?B?TGNXcUF3bnZ1Nm1kRFlnaHg0VkFaa0pxdFlpVkJQdktuTDN3RW9zdkFOZjNQ?=
 =?utf-8?B?L3hYSEtJd3BZTjlCTWVFSkNpTlhVWWZKR2N0WERITFRyVnFOcnVsSlJjbkk1?=
 =?utf-8?B?VTRSRVBoMlc0U0VuK2U4QVdqMlZiQWZVQW1FaG1yelVXcDNja21mcXJBcTVy?=
 =?utf-8?B?MXlKZWQvZVZnV3ZyRGdDUmtJQ3p3TStROENHZWc0ekMwT0RhaW5JL0ZVUzZs?=
 =?utf-8?B?QTBwWk85TEUvZDgzSGZxZ29ha2cwa09kcUloUm5kMHFGS3VDZ2NyWjV5N004?=
 =?utf-8?B?Q3NVUkpIVWNmOUNqNDBkRndSUS9FbElHcHZBZEpaQjJzSSs0MnR3YmJBUWF3?=
 =?utf-8?B?dm42Q3VaREM3d0YzeEovTmJSK2U1VXhFUW9TUnJSTFFIb0hUTmpHR0UwNUFR?=
 =?utf-8?B?Z3Y1VTl1UEZBSFdVbGRuK0FZVmtjZjZzUUNWUDVEM05UZkVQaWU0Ui9EOVRu?=
 =?utf-8?B?T3hWTmZ2NjVyVVhHQS9DQVp4ZkU0NnMrSWNRMzNkMUo4TWZkdW5XLzd0WXZX?=
 =?utf-8?B?TzRWOUtpVXJaQzBNV1dmUklleEFXeFY2RzRRRkFtbTlKVmlLM2huUU9NMnhT?=
 =?utf-8?B?RzJhMW5SSmJ1SXJRV0hWT3JRU0JJTXJmQzFQdy9PUjlPb0RUMlJGNVY2VzBm?=
 =?utf-8?B?Z0lQU28yMlZVa210OFdkdk5TVXY2TFJqbkE5bmI1bjJJLzc3cTIxM3lXVjJa?=
 =?utf-8?B?WHlEaTI2Q0hUelNJTHk3QnJsT0hCNlAydHY3SlB4TWRod0x3LzBCRndKS1Bz?=
 =?utf-8?B?M2FHemJIb093K3JSVXhEMXBCWGkxWmlHbzdkZTY5Ullic2R2N2t4T1BNWjZy?=
 =?utf-8?B?MWFPZEFpWjVnMzBGeUZ2VTFodTRIeVh5VDRmNWhjcUtJZmxEY2JDdEgwZkJk?=
 =?utf-8?B?Tjd2M1RTZ28zdW03eW1DS0hSa2ptbWZoRm1ZcnNCZ2VXblQ4QVFzMVBLSm1S?=
 =?utf-8?B?Z1pJOXk0bmQycjZxVkJ1a0NCQytIVC8rc2FjcXBlL1JLcGJTTmZzQThOUGhq?=
 =?utf-8?B?Mno1ZDB3QTJWVzhaRFRCV1JTNy9HclA0R0t2alhiVWp5dlZQeExLcW5lYUhT?=
 =?utf-8?B?emNhT3A1dUxNZnVCYXNtcXZYSzA2WTNtakl6cDNyZ294d2RkcU5HVTlMSS9D?=
 =?utf-8?B?ZWVxSXBQMk1UdG5aSkFTT0lneTRwNHlYalJmeHc1Qk9ITTIzamNNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Iji7Sk25kP6porztbJIwzTL5amxBqHXcAQwRW4u58Q2HiIxxpGH8jBvSv9VrDeu/qCeXesTmt4jclYXYhC2Trz/LIbt3433mEDrBAf8jRZ275/4PbfMxYiAkb6RY3truLwzvqO88DuZLDMSRYjsJ7JGZSaJf0iA5HNYy/eQSh0luvlb8P6i/e//Pk4RVQ0+y+t7lKD2WcVwEEZSmr7YJAQrkBGF4Eto/5cba9Ql5y40e/RWzsewyF669ZU2JmAH/SCYzkc6brm2eSptnfTI3ji5Rv+7V6T5jsnXU+1z6dktWXZSqETT1erveeELqmefonaatabTbI3gPKU9qkT0SIw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff11984-b193-403d-cdc0-08deb26172e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 09:07:54.2233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dDYRPITt7KRGMcngthqw4U5MwEkPPaqe1c2IG9ddNQtv/9NEhP1nPqA25uUSHZ67qg1VgtQ0aNwYwEs5sqoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5896
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA5MiBTYWx0ZWRfX9Nwj4QBRAqyz
 2uUyuRB20U7H4x+kMixqCu/jek3tknzXh7vKg0tKTupxLQRAukbKpwqGDXui3QQpFNJv8WccONQ
 tfEs+q63ltvyGRAYKGJkKB02n326NReeJz8Dn93iX+648cGRxPHX/5LX16EPEHamAw6Jd9OfKFK
 R00oF0xVqlj+nBKgOsWYjDBV4ip3g4t+8feliBVrj19v27Y2II3cy6R2E6zBxK60m6TMFRCQQVW
 1oEOzkZ6dNf9IL4cKv162m28M9OSdqg6v1fMOAsqxsbh6TFq693zeHsYE20Kt3OqtyndAd/3JD1
 1ur1ZSpwQLEyhC/8b1mao1aL9gf1yE2m47btJw8vvmjC6fVeNwQT6ggQVb2Um1Eb8DcwESJ5Euc
 xEiGp0NZGHokUipBMcUmRrmRQGWkxF8ny3gVl/ITkqPzF3fLE6JRDSDjX87KLtKlwyGH6QKKPZV
 AuiEDu7qe6WwG9YwrSw==
X-Proofpoint-GUID: GpwBXOKZix-LzZv9a6fVMvH-9LTpxtG-
X-Proofpoint-ORIG-GUID: GpwBXOKZix-LzZv9a6fVMvH-9LTpxtG-
X-Authority-Analysis: v=2.4 cv=N90Z0W9B c=1 sm=1 tr=0 ts=6a06e270 cx=c_pps
 a=w9jTARCbdo3hRO6w7Rsibg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=CscILIOLagS5JHHM7uQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150092

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBGcmksIE1heSAxNSwgMjAyNiwgRnJhbmNlc2Nv
IExhdnJhIHdyb3RlOg0KPiBPbiBUaHUsIDIwMjYtMDUtMTQgYXQgMTc6NDYgKzAzMDAsIExpdml1
IFN0YW4gd3JvdGU6DQo+ID4gQEAgLTEyNjksNiArMTU3OSwxNiBAQCBzdGF0aWMgaW50IGx0YzI5
ODNfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2LA0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIDJeMjEgKi8NCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqdmFsMiA9IDIw
OTcxNTI7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIElJT19WQUxfRlJBQ1RJT05BTDsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgY2FzZSBJSU9fUkVTSVNUQU5DRToNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIHZhbHVlIGluIG9obSwgMTAgZnJhY3Rpb25hbCBi
aXRzOiBkaXZpZGUgYnkNCj4gPiAyXjEwICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqdmFsID0gMTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCp2YWwyID0gMTAyNDsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJSU9fVkFMX0ZSQUNU
SU9OQUw7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgSUlPX0NPVkVS
QUdFX1BFUkNFTlQ6DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAvKiB2YWx1ZSBpbiBwZXJjZW50LCAxMCBmcmFjdGlvbmFsIGJpdHM6IGRpdmlkZQ0K
PiA+IGJ5IDJeMTAgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCp2YWwgPSAxOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgKnZhbDIgPSAxMDI0Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIElJT19WQUxfRlJBQ1RJT05BTDsNCj4gDQo+
IFRoZSBhYm92ZSB0d28gYnJhbmNoZXMgYXJlIGlkZW50aWNhbCwgeW91IG1pZ2h0IHdhbnQgdG8g
anVzdCBzdGFjayB0aGVpcg0KPiBsYWJlbHMuDQoNClVuZGVyc3Rvb2QsIHdpbGwgY2hhbmdlIGlu
IHYzLg0KDQo+IA0KPiANCj4gPiBAQCAtMTY1OCwyNSArMjAxOCwzNCBAQCBzdGF0aWMNCj4gREVG
SU5FX1NJTVBMRV9ERVZfUE1fT1BTKGx0YzI5ODNfcG1fb3BzLA0KPiA+IGx0YzI5ODNfc3VzcGVu
ZCwNCj4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgbHRjMjk4M19jaGlwX2luZm8gbHRjMjk4M19j
aGlwX2luZm9fZGF0YSA9IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAibHRjMjk4MyIs
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoC5tYXhfY2hhbm5lbHNfbnIgPSAyMCwNCj4gPiArwqDCoMKg
wqDCoMKgwqAuc3VwcG9ydGVkX3NlbnNvcnMgPSBMVEMyOTgzX0NPTU1PTl9TRU5TT1JTLA0KPiA+
IMKgfTsNCj4gPg0KPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBsdGMyOTgzX2NoaXBfaW5mbyBs
dGMyOTg0X2NoaXBfaW5mb19kYXRhID0gew0KPiA+IMKgwqDCoMKgwqDCoMKgwqAubmFtZSA9ICJs
dGMyOTg0IiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLm1heF9jaGFubmVsc19uciA9IDIwLA0KPiA+
ICvCoMKgwqDCoMKgwqDCoC5zdXBwb3J0ZWRfc2Vuc29ycyA9IExUQzI5ODNfQ09NTU9OX1NFTlNP
UlMsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoC5oYXNfZWVwcm9tID0gdHJ1ZSwNCj4gPiDCoH07DQo+
ID4NCj4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgbHRjMjk4M19jaGlwX2luZm8gbHRjMjk4Nl9j
aGlwX2luZm9fZGF0YSA9IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAibHRjMjk4NiIs
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoC5tYXhfY2hhbm5lbHNfbnIgPSAxMCwNCj4gPiAtwqDCoMKg
wqDCoMKgwqAuaGFzX3RlbXAgPSB0cnVlLA0KPiA+ICvCoMKgwqDCoMKgwqDCoC5zdXBwb3J0ZWRf
c2Vuc29ycyA9IExUQzI5ODNfQ09NTU9OX1NFTlNPUlMgfA0KPiA+IEJJVF9VTEwoTFRDMjk4M19T
RU5TT1JfQUNUSVZFX1RFTVApLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAuaGFzX2VlcHJvbSA9IHRy
dWUsDQo+ID4gwqB9Ow0KPiA+DQo+ID4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IGx0YzI5ODNfY2hp
cF9pbmZvIGx0bTI5ODVfY2hpcF9pbmZvX2RhdGEgPSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoC5u
YW1lID0gImx0bTI5ODUiLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAubWF4X2NoYW5uZWxzX25yID0g
MTAsDQo+ID4gLcKgwqDCoMKgwqDCoMKgLmhhc190ZW1wID0gdHJ1ZSwNCj4gPiArwqDCoMKgwqDC
oMKgwqAuc3VwcG9ydGVkX3NlbnNvcnMgPSBMVEMyOTgzX0NPTU1PTl9TRU5TT1JTIHwNCj4gPiBC
SVRfVUxMKExUQzI5ODNfU0VOU09SX0FDVElWRV9URU1QKSwNCj4gPiArwqDCoMKgwqDCoMKgwqAu
aGFzX2VlcHJvbSA9IHRydWUsDQo+IA0KPiBZb3UgYWxtb3N0IGNlcnRhaW5seSBkaWRuJ3QgbWVh
biB0byBhZGQgdGhpcyBsaW5lLg0KDQpUaGUgaGFzX2VlcHJvbSA9IHRydWUgZm9yIGx0bTI5ODUg
d2FzIGFscmVhZHkgcHJlc2VudCBiZWZvcmUgdGhlDQpwYXRjaC4gSXQgY2FuIGJlIHNlZW4gYXQg
dGhlIGVuZCBvZiBhZHQ3NjA0IGNoaXBfaW5mbyBzdHJ1Y3QgaW4gdGhlIGRpZmYuIA0KQnV0IEkg
Y2FuIGVkaXQgdGhlIGh1bmsgaW4gdjMgdG8gaGF2ZSBhZHQ3NjA0X2NoaXBfaW5mb19kYXRhIGFw
cGVhcg0KYXMgYSBjbGVhbiBuZXcgYmxvY2sgYW5kIG1ha2UgdGhlIGRpZmYgY2xlYXJlci4NCg0K
VGhhbmtzLA0KTGl2aXUNCg==
