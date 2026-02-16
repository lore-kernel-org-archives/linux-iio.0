Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C75310774;
	Mon, 16 Feb 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252163; cv=fail; b=VOvqq9SmtH6yc25fij4M5hdCesMkrGtpc3E7v/v5Epc+iePOF7dw2dcbjMRFuTz7dBxlF0WCP5rSJCnx5Ubw8nfQt84LbfB126ilinSgLFz6ws+wHr/bOByyjbYDEd8nXosjUGoG6L7WnALkZL7tHzTWMZ5rPDfZTVcgGvGU2JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252163; c=relaxed/simple;
	bh=HZQm41rQP2ddoUJK2tGFaH1uCRfrxiDO2l1j6JnNk/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2a7WJ0Y7A23QNfef/EFXBNMpXBWa/eYpwjARiwP6swkWRWXXpLAm80nUTUtjJlpDbij1Ee7l6IIASPaHBzNro/bIUeRB+mz24+mM3gnXdRhlvRM+f86HkSbJPkep88FtZU/KZ7S28wlpqnU1780P2Plo+rk+0jqdZUe+zjEEB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v5bPksnT; arc=fail smtp.client-ip=40.107.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v5bPksnT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf76TWHETdaQDL9w/eo+rp8q3AKiJM4YA7NicLDGM56TK4Ihiyg1a0rojY1PEFusMI9mqazy4bN52lsbEEIEzI6b2VWQblZOH+U46ReDPKCFT8VNxJOTK14zsQuKwqxsMpKJZ8/P2u4cOboHvthsptrE/341YSKBHPdmqwyCigFmJ5D+o1PJz/CrVtidTjZ/p1FNpVXrwrLvBS+WpeWaTxmBOWEAiYzsYrwcoz3Oe+x+K/8FnvHwZu6sdi59fmnejvZ65pg6+GWcAty6nEOp8jBmKpo2rBQWyN7XL9iEtN7iRH5xI1GOBzEJDqFW7kQyilo2ZruacbVkI4dEJduSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZQm41rQP2ddoUJK2tGFaH1uCRfrxiDO2l1j6JnNk/M=;
 b=sKwKSVTh08rexxuo7Sf26n2eg/21LQSL49X6MYfsJq6SVfQpWJTo5gzP5pjYOxfkIurAhJN5nmMr6T3KxDZU4XOcgHY33y+a92t3FC4M1RGOuHPAYTGHo4EMhytVNOP5/sCMgGQZfUCjbm7xBYPo0NLkgyAXos44+iEuAGH0Fyguwb71/SLZARLhWJ8pHJE8SPbezogPYO6SW6KH8ZEjL1sVHiE+ZBKswVkXp+O8NC+jhz9eXCSafG0Mn6u7ljWhykXVj+IunHUUirnCZOsyroOQpWR3i7ZG/lDFjdslkR+qVHvC1cF2hv9j3gyz6baHvFFbLMu0yT3obm99yMgWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZQm41rQP2ddoUJK2tGFaH1uCRfrxiDO2l1j6JnNk/M=;
 b=v5bPksnTIHe6xuQ+kmb7ZHqHAwA5DuVp3wCe5EPclQ0ivnyPAgpksf/rTRKb9buTizWGLdRZ/pFsV/qjlIaHOLu8/wxoJcyeR8s037jft5Q7LY4Ok5gft90Osy9lV7NBiRfEFwgHieVzPOKHk7uYpMd+i+3bdfMJP4UiTOOKburxFOP9E8/qhEUrMYd9dnO1t8KvXBS3mrZ4X1/O+0vj1jSeNOdgkLO9buisI0dfswme5JQgvz1H8VewpLSPibicxtYo0UU7s+NFtzBDLtcJ4djJe/DtlYM8WaUBtJECD/qex0tdXgk3JE8eWLTL1lIsd15R+cTyuM8ITTI7SPYJZw==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SA1PR11MB8809.namprd11.prod.outlook.com (2603:10b6:806:46a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 14:29:19 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 14:29:19 +0000
From: <Ariana.Lazar@microchip.com>
To: <andriy.shevchenko@intel.com>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Topic: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Index: AQHcnB4CEkxJgPuKSkiQaY7LrEYHMrV/I3aAgAYlLQA=
Date: Mon, 16 Feb 2026 14:29:19 +0000
Message-ID: <f8e45b0ef7af336dbde04ce53d117c6e47d2190d.camel@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	 <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
	 <aY3m5V05FOH5sut6@smile.fi.intel.com>
In-Reply-To: <aY3m5V05FOH5sut6@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SA1PR11MB8809:EE_
x-ms-office365-filtering-correlation-id: 9ddc0d78-0def-4434-eeee-08de6d67c566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2wvS0c0VlVZa3hPL0dhdjVoQmtSbGJFKzJUZ3BRZDB1QllCcE51MkoyODNQ?=
 =?utf-8?B?TVY5ZFRWc1p6ZnF2R0xXLzZsbEp4bmpiUjJialRnY25KRWFCMDF2MXA0RHdq?=
 =?utf-8?B?WjBra2tJMkQ5MDUrck1sQUZwbEl2UzIxWVYrL3FQT2VrSlRkclkyYjRYSTRF?=
 =?utf-8?B?Um40aXhVWTg4RFV1UVRFdDNwRzRPU3JkU0FqbGNaMnZ6dmZjenVyMmRxWENR?=
 =?utf-8?B?VW5NbGtWTG9DUUFDRXJXM1lzcWZQcDlEdzI1ZGFHakpuREZjWDlrbVdYMEtP?=
 =?utf-8?B?VXRxbGxIbG5sZlF3MEJTQlJoU0dOY3Z5Sk8rMjJkZXVyZGk4c1BLcmJINTIx?=
 =?utf-8?B?NGhXNXlPaUxuRHFBYWdzSmZ2d1lnTWNodTgvMlZ4TGg5eHdZL0U5Z0F3VG5j?=
 =?utf-8?B?NGNMRzVxdUF0d3dVbisrQjFnTzlMcDZqTHpCUDlZME9mNit4K2ZpUWxGWTlT?=
 =?utf-8?B?SE8yZnpUaHh6Z2FEcFE4aHd1M09GcG9BeFZvQTFHUCs2WUg5RW1USlZUODdP?=
 =?utf-8?B?NnNrK3V6WG5WL3RLTkdoWFoxRERxZFlKbWlwQjYxaDZZNElPOGVzNWtxdGdZ?=
 =?utf-8?B?eVlCRWVidzRuRXZYeThtTlY3WDNMdm91L1B0TWNlRWVpOTlURHQ5YXpTMXdD?=
 =?utf-8?B?M1k1TU9rNXBZbThybVRxT0RETjJzdENwNHRPdEx0bDB3MmZaRit0WWd5bjQ3?=
 =?utf-8?B?U1k2RXU4bkRMeWRyWUU0YkZudkREblB4d0tzMEJUUnhkWk1LN3ZGMDZNREtF?=
 =?utf-8?B?NWZLT3VYTUt3cldSUkdVbFhUeVZsdFFGY0xEQ3I4dkk0Wjk3azNTVWMrYTh2?=
 =?utf-8?B?dFRMZ29wbFRTTjJwSDlwRSs0TnFMam5GRHk2Q0tpbVA2aDVjTEpaSEJqbEdK?=
 =?utf-8?B?UGxnMCtUOVArQnBSVzBsZVdsY0NVVWFkU0NFZ2hsR3pUV0s4WU1sdFBSMDkr?=
 =?utf-8?B?VVVZTHJtVytndUxpbE1iVnV0UGE0STRkbmRqcFlPZWZ1NWZENldYY0ZiR3pX?=
 =?utf-8?B?RUV2ZzVoTkRySENNcEZCeGJKanR3dWZlS1pUYnpPQ0pjbTg5ck8wZ2ZzNGFm?=
 =?utf-8?B?ZkZpYnhhbVJVMmViVy9EbDZJcFkxV1dvaFJpVzNob3I4ditjUlZYN0dXZmJ1?=
 =?utf-8?B?RnREcXA2Rlo0TFF3cFIzb0tYMVJDTlh1akhHMmg4L1U0KzJqcTU1T09vMlB1?=
 =?utf-8?B?VUw5MFdtbndIa2FYYTg3RHBEM0VhbVdIQU9INVh0S054NHBJZnBRSTBhNEFC?=
 =?utf-8?B?UWVVVVpKV0o5OHN1TXJ4RHdTLy8wNmw5eHJuTXY5RjhjLzR2Tm04S3FNeG16?=
 =?utf-8?B?N2dYZXFidnczdHhjWG9QbFg2ekx6TWk4bDk3N1h6c3RmWjlEOXhZM1Zvam9T?=
 =?utf-8?B?ZFhSVHNmZ2hwcEwzb1gyZThQNWFBcWprMUYrSFZOL1hJQzVxeVpwaXFLaExj?=
 =?utf-8?B?Q0grM1RZcmpveGNMbUd5MnVPQVBqSmFsdmZDRFdUZDBwWWhFT0wzWjl2Lzh4?=
 =?utf-8?B?MUFLS05tZWF5YUd6LzNmSFV5QndOMnZKQ3RuRTRvSDNRc1IzNnRoSXFyRnQ3?=
 =?utf-8?B?YjNVZXIwMkp5R29YSmVNSWNmWE9FT2RnWW0xV2FXaTJOcC9VaTk4ZTFxN3dJ?=
 =?utf-8?B?QVBYREZTWkQxOVpYY0RRWDN5S0pLSzQwTTYrUytEOUdsaGxoSjdnTXhVaVFy?=
 =?utf-8?B?M0taL1lJWGJnR1VtTGh3V1VVN1dWWUgyRkFTbWVEZUgwYWlRNHJDUVFnZ1RX?=
 =?utf-8?B?VFZkVEhpTk5xaDh3MFl0QWhoSFlTNkxoOWV3WXp5czVrd1RIVlZtRE90Ym8z?=
 =?utf-8?B?UEljdEJPeDJDVXhZdGxUVk9VSEdZU1M4eTExd3hxbDVlbldlMHpyRnA3eDF6?=
 =?utf-8?B?UmZVOVlRNEl6WGg3YWMwTEszR3ZtbEZHY3NzT3AxWkd5dEpDT1dEc1B5cWFi?=
 =?utf-8?B?cVM5aEFLV01yUUkxelVwY1ZEYmk2YkN5dG9NTW82RnJiZEsweStuMzRlWjFm?=
 =?utf-8?B?ckFOMDZpNjM5ZEpXU3c2RDhEZUhWVmRDeFNTU0REQk1uNXJlWHpxMHBSb25F?=
 =?utf-8?B?c1NIU0Viak83OTY0dXdrZHpoWEtveHRHUW51R3E0WXhDeHMvQzZnaUFibTUy?=
 =?utf-8?B?TU1iQW1FQ1p2cGhKVFBIMDhndEMvbVNmR29IalF6ZVpEcjJNNVpEUjQ0aEhv?=
 =?utf-8?Q?OhDXlYawMVJTnwMTUtjm+nM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NG5qTDhtSUZBWVE5Ti9KdGQ2aU10aDdXZ0wvSzJla2JFaUp1anQyRVp1Rzl1?=
 =?utf-8?B?ektmV29oMEJIRmdHOWxLb211ajRub0NnOFl3Y056N0lPdkZub0ROd0VNYWF2?=
 =?utf-8?B?NjZLOUg2OUVtUC9RSVplSExWVm5JRXVrU295eVpsL1ZIbmt5VlptTDMrU1BW?=
 =?utf-8?B?QU0wNDl4cTNOMFVPVzlvVG8rL0t4TXJ5eXVpNHBubk5OMnhvQUtKalFqOEJQ?=
 =?utf-8?B?ME5MdjNLUUxxSFdYWkpTNGdDSlQvZUlnUWlWaW5VdElKYUJ5TFdJSkVkSE1J?=
 =?utf-8?B?SDIyU3RNT0VkR1puc0s0Smljc29wL29CeVdHSENHVXJWQitocFBxSU9lVlAx?=
 =?utf-8?B?OTUrQndGakswR0FLUmJLOFg4OUUzSGlIWVBEYnI4RFQxUHF2NnljdmlGMnR2?=
 =?utf-8?B?NkpxYmExdUpSMUJhak1aSC92ZFppREsyMmJXQVlDd3lIcEVNdmUrKzRZRG1S?=
 =?utf-8?B?VWpuL3pIc0tTYUlxazI1TEN6K3BUSkFSNFZZR3duSG1jaHRPWWtxWEZqbG41?=
 =?utf-8?B?NW1SVXVxR1RSRkc0Q2ZEZkdEUlpRNU1zczBlajdNbEVPTFNYaUMvSjNsOXM3?=
 =?utf-8?B?RVQ1cFY5QjJERm5mdEJRa1hsK2JlbjdNRWlJL0hvOXh4MjRodWdJMFppamZU?=
 =?utf-8?B?R2NUVmxGUWNoSjZWWGJhUHFnNzBDZ2ZBenowWmh4c0diSWxCajZTZms4N1hN?=
 =?utf-8?B?SVhCRmNHcDFIUEVPUENXTDlsT25xNWlET0dvWmppZ2ZxQm5qejZPS0NVdXJv?=
 =?utf-8?B?OVorMmQ1Y1F6U0VCdE5EWUFQclFmcHhnZHRxMGorYmxhT0VWWktZallHV21J?=
 =?utf-8?B?SmFDVGsrS2g0WGwvak42bDBwUmtJV3FpSXVjOTVOcHRGN1RJMUUwWjl1T1BI?=
 =?utf-8?B?YkgzTitlM1dwekprR2hkcVBwVTdodVNYaDh5UkhEdXJXTXJReXJYaGNJUXA4?=
 =?utf-8?B?NmNqZmZmRFlEbVhydWNsV0tYaVpwUklSOHRnekRKbDJOWTd0Vy9nSkRsUmow?=
 =?utf-8?B?T0QyQ0NYV1NMTWJNZFQ3Ulg1YUN1Z3VjM0oyMG13RFdhZFcxRjNJRVdXcklx?=
 =?utf-8?B?bngvUEp0NWQvVnU3NUR5UWtzbWVlSDZUWFdBT1E3MCtqcVFiQUJ5eWhvb3JS?=
 =?utf-8?B?cjFCeGtTOXYrRkJCMXhXRENFWUJCUDRxN2QrTFJTbmdxcDA3RWJJZTdDcHRJ?=
 =?utf-8?B?WmxkTlo3RWwzZkNIeU10MVlJTGwwY2hvdWdOU2dic2g3aE9jM1R3c2RsSDBt?=
 =?utf-8?B?c3BGb3hVUHhJS1o5M2M3SGVzem1mRVlQNWNoejZHbHZkNlNNZU1Ucld2VUNJ?=
 =?utf-8?B?TGkxRkhxWHZGWFZCRFMyRUhHTUxpY2NSUjNMVENsY0tuR3Rad1dTMk5VenBm?=
 =?utf-8?B?UVEzN3hKUjUxS040MVIyQzE3Wjg5SUJkRXcyZ0h2RHNTd21McGNZMWh5RC9i?=
 =?utf-8?B?cEhOSHNoYUJsTmNkZjNKa0hZOU1CdnBVdnhMdmxtVlIzd0VWb29Cc1BVYStM?=
 =?utf-8?B?b3BVNUtMRG9paVZwc2Yvd1VBMWdTRlUxcFNhQTYwdVNybkV2c25iQ2xTWEt0?=
 =?utf-8?B?T0pIOThCelJVUnpFNjFDMHZvNlZJWVNvYUVoNVBEZmtKU1l5STBHbU1adXd4?=
 =?utf-8?B?ZThobjU3MjRvWVpHWW5hQ0V3S0MyQ1E3THF1WXRnRk9KdE10dUpPTG43WHZp?=
 =?utf-8?B?dW1uaE9sK0RjMGFYVHovL1c5ZElyeEFLbDdWNCtwTUo3b1JYc1FnN1d2MGZV?=
 =?utf-8?B?QWRMUUlIVEFORmowYzl1YnRNQU00RHpLTzN5dmlaTjJSM2lZZlkvbGh5UWhM?=
 =?utf-8?B?VlIxY2FKSmd6ckI1aWpCd0FHemZ1R3VUTnUxbEQ4QXdYbmZra05FeVMxSGVq?=
 =?utf-8?B?Rm9XQ2RUVXhJM1gvQVFWSDMyL1FmZ3JWY0gyai9xT0wxNUZMUHp2V1g1ZGFn?=
 =?utf-8?B?U0ZndzdKOXlHRTJoMXM5ZHMySi9KNmpYTVZDS0hLNVF0SG9sTzhVTFpJUGNu?=
 =?utf-8?B?ai9USHhza2wyTTNBeEJYWFExdU5rd1JJWEVDRzhrZG13eE9vSHVOMnlVOXlh?=
 =?utf-8?B?RTk1bXBNSDRTeWxvM1dUMExUT0UzcHI0UmxRTXhkMEpuNTRHZ2duU1ZJMkYr?=
 =?utf-8?B?RTdwRXNpdmZRMjRJdC9IVXRZMm5pZ0ZRNHczWlpLYytvTktnWUFPNFJHUTJ2?=
 =?utf-8?B?eDhaTS9oVHpIblpQenpYLytnNnBUM2NoVUNSREhIaHJQOFd6elZqMmlyTjhR?=
 =?utf-8?B?Ky8zTk1xSVVyOHlZUWo2QUsrZ2c1cHdqbzR0ZmxEcmZxeWl6VjdBcGRVdVZG?=
 =?utf-8?B?MDFCeUtiajVuVWphSzM5elhLMThsekxzUm8rQ3BtdlVsNVV4cjQ5UGJ4RWEr?=
 =?utf-8?Q?/4QNe9CcqSGeCxXw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1005B24F7E77194CBF747ABF23D039BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddc0d78-0def-4434-eeee-08de6d67c566
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 14:29:19.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Keu8JVCTW6wP7RMa9Zwvc2poSDIeXaOKDnStMnsrl701zWKzGqpf4cB44LKANBZkD/Efr3gfLdRCViAVB6DlNuZEKPl3e6EimuAxEa2D2oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8809

SGVsbG8gQW5keSwKCnBsZWFzZSBzZWUgbXkgY29tbWVudHMgYmVsb3cKCgo+IAo+ID4gK3N0YXRp
YyBpbnQgbWNwNDhmZWIwMl9yZWFkX2F2YWlsKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHN0
cnVjdAo+ID4gaWlvX2NoYW5fc3BlYyBjb25zdCAqY2gsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBpbnQgKip2YWxz
LCBpbnQgKnR5cGUsIGludAo+ID4gKmxlbmd0aCwgbG9uZyBpbmZvKQo+ID4gK3sKPiA+ICvCoMKg
wqDCoCBzdHJ1Y3QgbWNwNDhmZWIwMl9kYXRhICpkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsK
PiA+ICsKPiA+ICvCoMKgwqDCoCBzd2l0Y2ggKGluZm8pIHsKPiA+ICvCoMKgwqDCoCBjYXNlIElJ
T19DSEFOX0lORk9fU0NBTEU6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAo
Y2gtPnR5cGUpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBJSU9fVk9MVEFH
RToKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkYXRh
LT5waHlzX2NoYW5uZWxzID49IDQgJiYgKGNoLT5hZGRyZXNzCj4gPiAlIDIpKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICp2YWxz
ID0gZGF0YS0+c2NhbGVfMTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVsc2UKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqdmFscyA9IGRhdGEtPnNjYWxlOwo+IAo+IEFjdHVhbGx5LCBpZiB5
b3UgcHV0IHRoZSBzY2FsZXMgYXMKPiAKPiDCoMKgwqDCoMKgwqDCoCBpbnQgc2NhbGVzWzJdWzIg
KiBNQ1A0OEZFQjAyX01BWF9TQ0FMRVNfQ0hdOwo+IAo+IHRoaXMgd2lsbCBiZWNvbWUgYXMgc2lt
cGxlIGFzCj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoZGF0YS0+cGh5c19jaGFubmVscyA+PSA0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICp2YWxzID0gZGF0YS0+c2Nh
bGVzW2NoLT5hZGRyZXNzXTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVsc2UKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqdmFscyA9IGRhdGEtPnNjYWxlc1swXTsKPiAKPiBPVE9I
LCBJIGFtIG5vdCBzdXJlIGlmIGl0IGNhbiBiZSBhbHdheXMgYXMKPiAKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICp2YWxzID0gZGF0YS0+c2NhbGVzW2No
LT5hZGRyZXNzXTsKPiAKPiB3aGljaCB3b3VsZCBiZSB0aGUgYmVzdCBhcHByb2FjaC4KPiAKPiAK
PiAKCj4gCkkgYW0gbm90IHF1aXRlIHN1cmUgSSBoYXZlIHVuZGVyc3Rvb2QgeW91ciBwb2ludCBv
ZiB2aWV3LiBJbiBvcmRlciB0bwpyZW1vdmUgdGhlIGNoYW5uZWwgcGFyaXR5IGNoZWNrLCBJIHdv
dWxkIGhhdmUgdG8gZGVjbGFyZSBpbnQKc2NhbGVzW01DUDQ4RkVCMDJfTUFYX0NIXVsyICogTUNQ
NDhGRUIwMl9NQVhfU0NBTEVTX0NIXSAoaW50CnNjYWxlc1s4XVs2XSkKcmVnYXJkbGVzcyBvZiBk
ZXZpY2UncyBudW1iZXIgb2YgY2hhbm5lbHMgYW5kIG51bWJlciBvZiB2b2x0YWdlCnJlZmVyZW5j
ZXMuIFRoaXMgd2lsbCBiZSBxdWl0ZSBhIGxvdCB1bm5lY2Vzc2FyeSBzcGFjZSBhbGxvY2F0ZWQK
Y29tcGFyZWQgdG8gdXNpbmcgb25seSB0d28gYXJyYXlzIG9mIFsyICogTUNQNDhGRUIwMl9NQVhf
U0NBTEVTX0NIXS4KCkFub3RoZXIgd2F5IHRvIGF2b2lkIHRoZXNlIGNoZWNrcyBpcyB0byB1c2Ug
YSBkeW5hbWljYWxseSBhbGxvY2F0ZWQKYXJyYXkgb2Ygc2NhbGVzLiBFYWNoIG1lbWJlciBwb2lu
dHMgdG8gYW4gYXJyYXkgb2YgWzIgKgpNQ1A0OEZFQjAyX01BWF9TQ0FMRVNfQ0hdCmFuZCBzdG9y
ZXMgY29ycmVzcG9uZGluZyBzY2FsZSB2YWx1ZXMgZm9yIGVhY2ggY2hhbm5lbCwgd2hpbGUgYWxs
b3dpbmcKdG8gYWxsb2NhdGUgdGhlIGFjdHVhbCBudW1iZXIgb2YgY2hhbm5lbHMgdGhlIGRldmlj
ZSBoYXMgcmF0aGVyIHRoYW4KdGhlIG1heGltdW0uCgpQbGVhc2UgdGVsbCBtZSB3aGljaCB2ZXJz
aW9uIHlvdSBwcmVmZXIuCgpCZXN0IHJlZ2FyZHMsCkFyaWFuYQo=
