Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1701EBA19;
	Tue, 17 Feb 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328296; cv=fail; b=uMSXXTxAhPbB+2bhrHZLl8IPemq1Qq6gOj7ZgFyah9zH61iKhAeCn9BjmEdUrSkI2QDKCIX4rycFMQfZ5h4jVaONeOfdPXtRfx3P6K0Cf7UIbuhfhUU/CEUgczKu4c/rMDky7wHkWAjvunLmx1Nl72JFI9Yda5RDGoNAJGj4W0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328296; c=relaxed/simple;
	bh=AwkWmkos0wjl135/pRyhJcsngrbvBEZ5X/19yvzEhLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0wybSKufTBXiakh/95trnekYL4LqwvZM3hwFqKk1nqDjgubePcPtro1gDAHTBWGJHzWtJB9stn1VKjk2BgZkvAy5vjIZ1GhNZO6wO5ZcosRxqaf/RF1fAStmY+HBXn+2bQucYSKkfU9Ch7DuJ2UVeagIWzP1JxQVUArNoq7uMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TGaBze4q; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TGaBze4q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEvTV8uqCYKSV2XygAlYl4+GsPA//4cbDoCuGkay2KkoRrLJJUYoXzV8YGL5fbILa09+YuU/WtlvNzt48QM17vPx69qFprW/nkjPRR6PDIFc7RpMfAUuHK9TGO2/VpDJGCPYkfcFTgzMXDpBVv15j9SWmC0Rw6pQZMvXQ54+mD+HUrWo/DJjOdlg5jX9jl07ZKk/rvpy7Yjtka3zrDtDLhpAqvIU63a672NXNjWb1iUcbdGDb9Nh91hx7PVrkTFOUHZcmLMApdAxmDp/brFnfud7fnqnmZNJPVIh+XCVwkq3seV0YqmQFAoiC3gAAkjBvcZtL+yXK77O0gjxT5iDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwkWmkos0wjl135/pRyhJcsngrbvBEZ5X/19yvzEhLM=;
 b=YMYC2r75YWoV56mj85YmRJDUKWZRcMrf/3Kw2jPbmy4O09rs6ycpXJX5mjYOMiEwkx3zytwFNCPq/7DR8yaYGAXQL82xBVDCC579jfGxf3ztI8lu6PbRvtp8gRb0slTiFcqltiF3PHWUPzljpmdOMf4y+o4Ct6eSIEpK6zKMl5SCheJOknPuBGZXfHrDXXdqfCIj4Rz5SwIrH8Ft0bbyA4zQm2wny5k+LQNR0hfH88N/S9HhF14v433WBfgi/XQ0Eb2AW3aPLLekq/rI9KtEuD1RachWEZIWY7omG+YOExPW2u2kEku4jXX9ZPjAsHcBeB0cKpwr+CpMy+IABFKHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwkWmkos0wjl135/pRyhJcsngrbvBEZ5X/19yvzEhLM=;
 b=TGaBze4qJTmScH/WBCsDungcNFxl5R0AxqBJ8iJks0Dgw0KzA2SLLnNF4JCUJNkos+cwdvZqm83wa0xTnTKnfh4jp5wV8SFt/FbEJ6nez/5xqKK+G8H8ejmT/vxMatatFIcrG8jSozJWFhLF8J6Q1bs1G9k6ui50Xp6524xVy+fRFObS7LFO63XZEltf9SwdSUC+LDTjYT48KXyGq6vnsC07eIP5ODrGy0kwgkGqGTB6M+3DewxJR4F8YtNcLi5rKyem4faXU62TLKupxy1/PjoBMCqMjgAFWc225tnz4ejZkGKAxDdzbhL6Eg6ogyaYLeJsXTjaPbbJsMgD5yStSw==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:38:10 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 11:38:10 +0000
From: <Ariana.Lazar@microchip.com>
To: <andriy.shevchenko@intel.com>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Topic: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Index: AQHcnB4CEkxJgPuKSkiQaY7LrEYHMrV/I3aAgAYlLQCAAURWAIAAKA2A
Date: Tue, 17 Feb 2026 11:38:10 +0000
Message-ID: <d910218942390c6cbb9be403b6ff6261b84260d3.camel@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	 <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
	 <aY3m5V05FOH5sut6@smile.fi.intel.com>
	 <f8e45b0ef7af336dbde04ce53d117c6e47d2190d.camel@microchip.com>
	 <aZQepHXptVvBsQuL@smile.fi.intel.com>
In-Reply-To: <aZQepHXptVvBsQuL@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SJ1PR11MB6275:EE_
x-ms-office365-filtering-correlation-id: 8d027aa1-66b2-4cea-f095-08de6e190730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlRaQW8xNW1BVEZjcWVqSTU2aTdpMXovRE5hSTF0VkF1cHFsYnhPTno2bTli?=
 =?utf-8?B?OWh6cjhxcjZIMHZFYW0zSmNLSEZvRW44ME1DVms5TC9Ea256ejdoL09tS3Jr?=
 =?utf-8?B?YUFLWExNb2FKdEpuUExuTDBEMVF1ZTdYUEtoTHVlZGU1R2kxS2hmSjU4Q01s?=
 =?utf-8?B?eHZVTHlSRGxsNmNNVDdBVjc1SEI4elgybXg2em9IUy9aSWxPZ1dGcUJjNTlF?=
 =?utf-8?B?bFRUeG9MRW5Sc3NHb2o5VjFJQ2pod214RWVzTkR4R2xLWUhzc2lGSU9OQkhO?=
 =?utf-8?B?Rm5NUlFwdU0zM3VJODAybDZ3cmtTd2ZSZU5kbE16bGNpYnNBa09meW9RZVZo?=
 =?utf-8?B?NVpKVkUrNStodGFNUzJJS1Mxb0lRVFNONkxsWnowWStWb1VGV1plYjcySGJN?=
 =?utf-8?B?aERwdmt2VEdWSHU2UTk2UjFUS0EvY2IxeEd5blp0SUNQcG1EeEJaa0trelJl?=
 =?utf-8?B?NGlyenVLOXpkRldYY0EwTlV5QW5obFdaeU52aDlFSndoNXlndi9CSEVzZTNC?=
 =?utf-8?B?YVFzSm1vR0MzQmVvWmRKQ0JXZTI1Ukd3ODRnVXdzRGxKcXVYZTBUdUljUytx?=
 =?utf-8?B?aW9JN3huSWNuUlV6TkNOL25tcFdIdkl1ZG83SktzZFE3Z0tqYko3MnpPVUxX?=
 =?utf-8?B?SXNxSHdYZHNKNmpCVlpwY0tBVjhFS1BjQ0hhUnp4eEFXREZjYXZ3WEwzZVFs?=
 =?utf-8?B?ZmxKU0pkSXZKOEd2MzNUT1FOWUJaYTlKenZsUlpCbjJSYW9td2pjb0NLNk5G?=
 =?utf-8?B?dTJLQUs2NGdUMy9EUHBjM1ZXMmZrL0pEYzRpQm4vMnFQMWJhVVpqTm8rdFVn?=
 =?utf-8?B?TjhUTmhuOVU2eU03dlIrNXc2Z2FCWGloaVdEQlhZQlZScXllZjZUTTViRzg4?=
 =?utf-8?B?VHdIWTZaNWljalAzNkVnek5WenZBK0FaS1N0bkxTdnhJcEtsd1dsMVdZVDky?=
 =?utf-8?B?ZGprc3NLUTRvQ3ljVWxYSFBvRnVpTWl4NS9ueDkzckNCMDkycjN6N0oyeUhi?=
 =?utf-8?B?RlhDZlhLb1d4SWY0cnFhUTRVMDBuaVlkeG03N0pmbjlWQ1Z0NHBIL0ZuRVhM?=
 =?utf-8?B?a2psYXJPYlllQjF2SlF0cGgzNUhTT2syN0dodHJDb2V3OFVXUzFzUnBhbU1n?=
 =?utf-8?B?S2FPRkEzQnZ4OXBOQll2UnVCaGVGSTlCMS9HbGgzak9qeGhrK1d2RzJuNzFZ?=
 =?utf-8?B?TWRyUG9lOG1sbStSNjFUU05WUi9nYmV5Y2NscXROTUl4S291ZnkzRDR1SldO?=
 =?utf-8?B?OVdHRS9Sc2JnM3dreFRjQUlmKzJhR2N3Y0MxUjMvVDd4L0RUcnZGRDZma2xy?=
 =?utf-8?B?WGptZDN0eEtiMnU3a3JUYVV3dEFRZnJBekcxOVR0Qzg5VTY2bjhTNHpmbVc5?=
 =?utf-8?B?NzhUdTNDWktSalRNbFh5NG5KTGVHckJvVlVIYVJEMU9ONTNnM1lTWFphM1BX?=
 =?utf-8?B?S2l5Rk15cHFGelBLcWF0OHVveUlVTi95S2JjNUV1ZmlCK3dSOXhVMWd2WFFD?=
 =?utf-8?B?REFDY2JobHRNTk8rMkJSQUtMMTVEUjdOdFozU2FUYzhTTXRCaWNvTW12VGJL?=
 =?utf-8?B?VG9iWkVHd1VVNHFWYlFvajBkY3VpemZBR3VyWVRFY1pFVjNCdkRrekZXcEdw?=
 =?utf-8?B?by9oNGxJU3UwNGkyaTVsNXBXUGVuUEh3RGlUbTJQSlVIM20rQ2RFTU9pQVZJ?=
 =?utf-8?B?UHVvaFZJT2hvT0NkSjh6a2NkQWEzM2NzNFVxVDVDZWE1d3F4OEt5SUZwN3dM?=
 =?utf-8?B?UXYwZmIrbTJhYjBUZlVOaUx3aDMwMlJMT3QrWkMwbE56MW9wc1B2bE1xVGx3?=
 =?utf-8?B?a0sxNW1lOWNjMHRZc204Y3Ztd1ExU29HK21iSmNKRXRwVFhIa2FNbnU4MEZ5?=
 =?utf-8?B?WWFMcGRlTC9uM014Z2tKM2lLME56VzFpRGZBNktyTjZLWVJKUTFlZnhuZElY?=
 =?utf-8?B?aGJrRThZT1RoTFQwcHNPVGp6eFc5LzloYUpIVFlnbFp3SGdtU2ZER012SDJT?=
 =?utf-8?B?L3RSdnVDdlQ3R1pnSTl3dExKRFUrZlFrZk96dXorRm13VUZ2WHg3akVtc3hu?=
 =?utf-8?B?T05MVVRFa0RCZ0d0Sk45bk92QWd6cmsxdjZhLzVUeW5DWUp4TmJ1bnh5T1Nt?=
 =?utf-8?B?VVRIaVVqSVlkSTRyMWk3dXR6cVZ2L05JZi9yblVmdGNUeEtIRmhqcWU4cEV1?=
 =?utf-8?Q?MOMfePM/quz5skLTFv5/CSc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVdiekZnb0FjMHRHYlBRaGMrWlBVS2pXMzNNZXZ3T2RVUEZ0dFh0dGZKMVZz?=
 =?utf-8?B?NWx2dVV5OXpZclo1Tkp2SEpqdFIzUFRwaWxFTzROc0IzN0JUZXBiejVCNnVW?=
 =?utf-8?B?Sk0vRVVIUkxvVFdtMHZkdjM5VDF2eDFENm9FWHYwcFFkSHJmb2lnaGIyaSty?=
 =?utf-8?B?TVdXbE5JS2JpdWUxZjBXbG9wRlV6OUVaQnl5cGZIQzRvVzVBNlFicFB0a2pJ?=
 =?utf-8?B?TmNJd2ZGd0N4VVNQSDJGK3dwZjQ0SCtnWkk2b0dQMUwrMU4zY0RwTGlEMkQy?=
 =?utf-8?B?UURYYkFJTEFKTWJxVm9hVVFmZ3FyQmVwaGlqMWNaaVF1Z0Z6cnl2aXNZVFVF?=
 =?utf-8?B?OHIwVEo3emg3UWp6Tk9rdWhiMmxldGk3cDByczlxd2ZzbEZ2azlQUHVTWGI2?=
 =?utf-8?B?Nyt0cnRnd29jWUJoUnREd3hMWCtJbHRRUVQydnU4SGN1VW53d0NkVENtNG5y?=
 =?utf-8?B?cmRyWTMrNEhmVDVWdVNtWHlzMkRjbjA4NjlFcXRlWnVDZjFHSVNQcEV6azF3?=
 =?utf-8?B?SmNoL0Y3Znk1WGUxUkZGM0N4WjREdWtZbkw5RlhpSzVoSUQxUG5YMmMxR1BP?=
 =?utf-8?B?QWRnK2kvVWE4YUFOYmkrdlRWalMyaG5wUUtsRk1ITDduZ2JSckZYWks1YTVO?=
 =?utf-8?B?MVJIUjRpY3pKK1MrdmRoZnZDS1lHRlA0a1lhSkphRXRab3J6MnZ3YmVNemxu?=
 =?utf-8?B?TEtFZ3V6SDVGcVZQM0k0NUlLOEpmejFWdi8yZlRkaENTMCtsTWNFY3BnSVNp?=
 =?utf-8?B?NHIzZ0U3S3hEMTN0S3p3YUZDVkt3aS9BalV5eENBQ25sUXYrMis2Z1BEd25i?=
 =?utf-8?B?ZjJkbUNLSDRmTFdsYmgzSkV6cXBPMmhkbWZDLzdZd1NUbnBXQ2JjeTk0M1VW?=
 =?utf-8?B?ZDE2VUdNVWtTVzY0d2tRRXhSMG1iVzBCQitobmp1eGc4ZThnUzJzY3RLOXlQ?=
 =?utf-8?B?dFZ5d2tVS1lvNjg3azFwbWx3cWxUeHQ4WkI3U2wzQlZ0cUFHbzB5YWtIK2s2?=
 =?utf-8?B?Y01OcVpzcDk1Ri9pSHZzb2xhVzlXaGxLT2Q5T1htcjNWdFUzUFFoUDQ1ekJB?=
 =?utf-8?B?cTZEVU0wTThkeTArdTV6M1c2aVNlbU9sR29zTU5GTUgrcWVUaEpNU2sxUndI?=
 =?utf-8?B?TS9FSzVhYSt2WkZaV244bXRVZFIyeVJUYmd5czR6N29MRHBVblBIM21xYTBr?=
 =?utf-8?B?ZEk0QktObUY0aHR1RjgrR1lCWllUTzFMSDVtcmZUNWRDSDJJeUhid2pEcjJF?=
 =?utf-8?B?ZHhyNUhaK2IraGZnTFVDVUIvNTFQMDJCREd1eHFMMldvUStndUo3Q1BHcWg3?=
 =?utf-8?B?MnJlclZTK0lVbUwyM1M5K2xxQmdrWkRPYTEzNGJRVU5saFRWZXBXQ3NHSUVW?=
 =?utf-8?B?OHozU1l5MGl6anh3dHB4c0dqS0FzTmhXWWpabUtSaFU4V0RCV2dVeTlYQ2xH?=
 =?utf-8?B?ejFLUFNhWm9vRDFKYlI3QTlpRldOdVRhVUd6bGFycW9zNkk3UjFYQWRWTW5n?=
 =?utf-8?B?OFMzSC9hYjQvanZibEtIdExQa2Vod2NCaWZZbGk3N0x5TXNkNC9YWW1jUGVV?=
 =?utf-8?B?UXVtTzgyaHU2NnlRbkZ5L1I4NnNqOFM3cEZTbmNuU290TlRKdnM1bk11K25n?=
 =?utf-8?B?M2lWOGxCRlU5U0JJclozRnA5T1R2cGZGRnptKy9zM3dIai80T1ZzMU9ybkE4?=
 =?utf-8?B?amdBTjNBVmRvRHFHMDR1bFd3dG1FN3ErbVFLZittakNUSlB3aFNmaG9weHlZ?=
 =?utf-8?B?UGNtL1p3RGVqOUlCOHdqNkJMS0QxUmtiRUViV1JSZndjUU9vOFoxSEFJdDhB?=
 =?utf-8?B?Z1FyNjVnVDA4WHgyUGVsZ3FuTmNhR0FwcGxuN0d3YzRuNTU4MHpzV0U2dnBt?=
 =?utf-8?B?cmRweElpZ0VSdldiWlJoSzR4SUt2dnIxRHo1SHd6YTFkd3BOdGd2UXFEYWkz?=
 =?utf-8?B?Q29zR0F3U2FvWFdRVEJUUVRVbllTWkhhMUZCWllubG00cXZvRnZ4RVpkM0xQ?=
 =?utf-8?B?Qnc0T3BtbmxObW1qaXIyZFVabFB6dWZlZys2M0R2VlhObXgrK2RJTjdGdDJN?=
 =?utf-8?B?d1dOWWYwRFV5WnA1ekxyZFRaMWl3bDFqd0ZEc3JWSnllcUxRTmprUEhGTmpL?=
 =?utf-8?B?RGlKQ3lLZkQwcm5EMGdDVit2a1I3ZXdLN0M3VFpldGdMRm9qSGIvQkZQNDBR?=
 =?utf-8?B?ZWN0YWdSMkxMaVZGaDJyYUkvSy8zdGFmRjlsemo1d29paC9md3Zma3p0VElr?=
 =?utf-8?B?U0k4bUpuMXRrZlltRGk3cCtrNDRBTHpwNWpKMXdhbGtIN29XTk5OalFFa0lv?=
 =?utf-8?B?RDA0YlM1U2RBV25zRW1QTWorQVFFRmE1bVVycDVITU1sSTB4NEYzSWN0YnZQ?=
 =?utf-8?Q?ddwkdpJC0E+01erc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CEAB2D987772D4A8ED64EF6D5C8E1E7@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d027aa1-66b2-4cea-f095-08de6e190730
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 11:38:10.6698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3r+nPT4mnag07MBbox0jtkSQ6d7z8xrzaBJkgHnGaplCGxPk18DythMEwYr05b6oWgGdQ6LEZz9/i4C1UCoTcJzQWCVhWLFdnylbAbmPKD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275

SGVsbG8gQW5keSwNCg0KDQo+IEkgdGhpbmsgc29tZXRoaW5nIGxpa2UgYSBzZWNvbmQgdmFyaWFu
dC4gQnV0IGFzIGl0IHNlZW1zIGdvaW5nIHRvIGJlDQo+IGFuDQo+IGFncmVlbWVudCB0aGF0IHRo
aXMgZHJpdmVyIGlzIG5vdCBuZWVkZWQgYW5kIHJhdGhlciB3ZSBuZWVkIHRvDQo+IHJlZmFjdG9y
DQo+IGV4aXN0aW5nIG9uZSB0byBhZGQgdGhlIHN1cHBvcnQgZm9yIFNQSSBjaGlwcywgdGhlc2Ug
Y29tbWVudHMgd29uJ3QNCj4gbWFrZQ0KPiBtdWNoIHZhbHVlLg0KPiANCj4gLS0NClRoYW5rIHlv
dSBmbyB0aGUgcmV2aWV3LiBJIHRoaW5rIHRoZXNlIGNvbW1lbnRzIGFyZSByZXZlbGVudCBiZWNh
dXNlDQp0aGF0IGNvZGUgaXMgY29tbW9uIGZvciBib3RoIGRyaXZlcnMsIHRoZSBTUEkgYW5kIEky
Qy4NCkkgd2lsbCByZWZhY3RvciBib3RoIGRyaXZlcnMgdG8gYmUgbWVyZ2VkIGludG8gYSBzaW5n
bGUgb25lIGFuZCBpbg0Kb3JkZXIgdG8gYXZvaWQgbXVsdGlwbGUgY29kZSByZWZhY3RvcmluZywg
aWYgeW91IGFncmVlLCBJIHdpbGwNCmltcGxlbWVudCB0aG9zZSBjaGFuZ2VzIGFzIHdlbGwuDQoN
CkJlc3QgcmVnYXJkcywNCkFyaWFuYQ0KDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCj4gDQoNCg==
