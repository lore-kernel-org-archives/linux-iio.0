Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9037202F70;
	Mon, 16 Feb 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248696; cv=fail; b=TfL7eCMW6+T1D0/+2JJvMwDk33qgimmZo4LJwRskH2VY8ig5DOZfx4lXixdPJUNjP1oXFbmqDcPfuKPIs2hJV21nLWjlFFmeAZg5dthVfbDVnkbpp5Kn4FmNOyVi0mtPZ2B+qv4JS8zx8Vy4C/Tk6G23T3Y7CFlFijwBtrWwMkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248696; c=relaxed/simple;
	bh=muZTiny571Ibxz+5cxXwgO3eQ/9JWgLZEzHUGNQKeeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HjC7SEQVU+ccAaqJwsyMtLwyptXM6nDhsqtqukMLA+nM1+Erxd1MSSA44bfjnsYeAY5prtIqji5WeCUQ6vzlgi1RlUvqASjTTEankgd5ODMztZX0zOohTo3wrd4+F7NjovLbOUdiZYII1UfI7K2mO8VuonMQCxZgSQRPp+8k8oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b0v6W8is; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b0v6W8is"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQoi3dH5cagyocxiqTSq86uMIzDAIKL50eraCjoxcmVokiUPlZ1NRkov3n6Wb8W/1BK3G3BC9+rjnas7iT25rHhqxInCI1hToWYkcv7xyqtT0wnaKkIIp23+aBAcf63oXjghxMLGlAYdrJQK7f2QIz5T6j6KVJBAztBd9utTm7yraNKKdG1Wi92ClGvxpZCIXBdGQr7Q9CXV1GYWKvDlSiLnGK4f1Je6mipQWT6P4jpO4hbhSr+cePPjGdYcOSei3TgMp/jhKmW4erk3mCM73G+UxloZXK3h3sk4cyvG9DFBWlUmt5FANiicW7Ap7+fHhQ+9ZiAH3ofzNaIyTXzCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muZTiny571Ibxz+5cxXwgO3eQ/9JWgLZEzHUGNQKeeU=;
 b=kMWvngv27jq6q4qNq5ojgEJU61LCCaf/MjgwKPAGwTXPP0v0y+5PNJ1A03vuOWRIqRs6PwFSO5q/dSK6DLbymmzoRvxsDfavZTndhWfLaHPjQ9urRD91LX+9fUD1fL8lXZpv8LASrPcfKUkX0vyRFcrY3ikIpZBvoEytD/MFzYoRa/PeMGG+Y7ksL7zsfSOjoCBAu6k1bjqc2XliAIf4nxfEeqBroVqvblrqrgZA13MpHeK7GUqbYFnIdT82WWN2oy2PP6CIcF5DG/a0ZteDxIuBqA5VRvllf/XulkarTErHltOx8RmUL/hw5qj5x5sN9gIiLAO1PAndEsQUuzzBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muZTiny571Ibxz+5cxXwgO3eQ/9JWgLZEzHUGNQKeeU=;
 b=b0v6W8isy1VnihxDhePjnMS7CfDYKE3vssIL6Cq29ChmlHWt/fjMdG5IeTuqqF3tT0tgTdjzMYxElODamDNoU7RirWp0NVYljwBgbHig7CiXNIlrFdKgej1P3px/B+6kvXNJ5jqWsbl30YGwI3xhTbt/xHQY9Y4C/Mhf4EIAX8PZRBnlm4OphPPC8OAWH1E0vVsoVu2Rfj7PzH2/psGiWfpVJ9fGRIeZLRXjiSF2P292w4ibmP4PYHcw0eZu99Hg26dZ0f0xoAHNhfXgqnP5+1syv1E0NtgQaWt8UUKtXthy3aKtaB/Kb//D3ZYQg/SZnC0JQ1FwHhK+t2mqvFpHOg==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 13:31:30 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 13:31:30 +0000
From: <Ariana.Lazar@microchip.com>
To: <conor@kernel.org>, <andriy.shevchenko@intel.com>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
Thread-Topic: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
Thread-Index: AQHcnB392ecUxV6iaEygr1LK1sJXJ7V/WpoAgAAi4oCABbsWgA==
Date: Mon, 16 Feb 2026 13:31:29 +0000
Message-ID: <a3bab395580cd83410c1c7364283285586c9b128.camel@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	 <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
	 <20260212-germless-favoring-c27ab4c53128@spud>
	 <aY4yaVP2TQFRI1E4@smile.fi.intel.com>
In-Reply-To: <aY4yaVP2TQFRI1E4@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|BL3PR11MB6409:EE_
x-ms-office365-filtering-correlation-id: f55d57ae-2335-4ee7-8181-08de6d5fb177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1RMWFZQS2dnNFVoMVlPSHNRY1J2cGsxVnB0a0JLYStqWjg4VFpLcjBSZWdK?=
 =?utf-8?B?UWU3NFRTWlNwb3BnWjg5SXhWNU83VGI1MXlETEl5Y1BkVkhxaVFNMHVIbjRz?=
 =?utf-8?B?aVQ5TjVMdkdjUTNzRDNXTmpVZDA0UlBIdURYRjNpMU1NZUYvaGMyQThRUngr?=
 =?utf-8?B?YVhxbzZMZmNRcVVlbGdNRFROYW1LaFpGZ0JreEVuVkZCdGlySEdFeEdJWWpJ?=
 =?utf-8?B?dmptYTZnelhDY3I3ZmtNTFQ1eXNMaHo1ZkVIQS8zOG02amV5RnoxbnRiaWlD?=
 =?utf-8?B?M1d0RUt1d1NhSEZQUFJFZVBTRTVBSGxES2YrWkpSQkVtSVl5ay92Z3N3OFpl?=
 =?utf-8?B?N2kwMlRqeTJYMWpLUUpjK0hic2xhWllMWXljQjNSNWNBNGVBUDVCOG5UdjFv?=
 =?utf-8?B?VnhZejh0TjZ3aXM2RTkyMkljQVh4cUxrTlA4Z2ZrM1BQWVA1LzNJRmpLSWFZ?=
 =?utf-8?B?aWt3QUxnd2paZjFLckhVcW8yWDhLSDJRcXJteUdFYnJiM214bW8zNjN5MVEy?=
 =?utf-8?B?ZEtxY1ZjYzdIbTRFN0trM3U0cWNrNGZ3MVpRb3Y4YmlCNDdFdmpQV0hDT0FO?=
 =?utf-8?B?NDRpRXduOWY5RVBvNG5ia3FWSDRKSHFEVllXYnkyY3B4bXg1c0pvaklzK3p5?=
 =?utf-8?B?OExSYllBL3VCUkp3bkIvMUlTdlFORDBmUno5MXBCWFpyNmVPOFBPWithZEJJ?=
 =?utf-8?B?cUdUbTIvTjMzM0dMSVhrak1ra2hGN21lQnpSd0VMME9ubkIxY0RTYVpybWJM?=
 =?utf-8?B?RkF2MG5JWTcwOUI2OVJsa1puTHdKbGdIaW12b3FtcmkzcXhyT3FQRWRMZHkr?=
 =?utf-8?B?cDBXd0FBeVZ2c25ZV2l4VFNxK0hqQXd0WlpCOFB5NUJTejdjdzdLTWFYYW9X?=
 =?utf-8?B?cXJpUGQyYWFKbUZOMDUxeVRuSVlYbkovRVdQSUVHV2dMVy82bmhwaGZtam03?=
 =?utf-8?B?OE5uWm0zamNuay9LOTZOc21sbm5JN2hjSEdyTDNWalVKb25hRHhGUmdIaE9V?=
 =?utf-8?B?MGtJR05jSkJtUkJXamd1RFVsb0RPSXJVbUFlYWt5V3VMUkJNMnExd0ZtVG9y?=
 =?utf-8?B?M1BNUXp3QzRPREpkUjV6T0h1eVhXMHdOY3ozWnVxVVJvVTMvK082Rnk2d2Jk?=
 =?utf-8?B?RFFLMWZ3bXlZNXlsTzlTeEMwR0Z6NUlyUGtMNzh1ektDa2hjNTdTY29oQVNE?=
 =?utf-8?B?dkJiUThpODNnSDk4ZHYxUHNEM2oxTWxYODlLQlRuSmhzRmVhQXVlU29LbFBL?=
 =?utf-8?B?cHQ1MFRCMkVxekI3MG1XWE9qd294c0RTWThDLzlRMm5aMnlZNkQ5UTFyUGlZ?=
 =?utf-8?B?Y2RPTDM4d2tneldzVjBsLytWWFpPd25uZkovbzJrN2V0dlN0Ky9ibStnNE8v?=
 =?utf-8?B?T2ZyMEZ4alNmN1hpam13RzNEaS85MmxDWW9YdGVGbTFUd01ON2RRb0k2WmFG?=
 =?utf-8?B?RGNEazBLNEpCUDJoN2Z2VzF2V2IzZ2dXWE93M05oQTlDVHZ1WGt5SU1ZWS9u?=
 =?utf-8?B?QldJNFNLTHB6djVkQUx6b1htQ0p2OXJZeElCNVBrc1NCY2VGQXlZMmFxd08x?=
 =?utf-8?B?UTVGRHJ4KzYwcGU2SmowaWg3NFhpK0tDOHBJYlBHV1dPQVJNZERNMEEvcitH?=
 =?utf-8?B?SGxuMWFUZExuTnpjcmpUb2pjMkVFQ3RncEorc0FHcnlNSjZ4cDk5V2NNMFlH?=
 =?utf-8?B?VUh0UjMvSlNPcFJabWlDUXJjMEdnZlpDcFNNczBpd2NWS3c2c2ZoRGQra0Ni?=
 =?utf-8?B?Ty8rZUtueDc2T1lwakV1MGU2dkVzWlpMcjZEL3c3aHo3NSs1Q1NNUmpLUnQ0?=
 =?utf-8?B?aFVDWW8vaW5TS3ljN0l2S1RROVlZcGxUdXlkTk5SajZpeVgyUTBUSTZsSjNX?=
 =?utf-8?B?RjZZRVlSUElxbFJ0L2p6bFlxN3dmck4rZnRqMUd3dmMrdVNyWmYxVE1BZzhT?=
 =?utf-8?B?WDNDam5MaVo3SmFyelZJTkw4SXdqNFNQSzRGbUFmUGxUUkhHZ0FnVVFab0Rj?=
 =?utf-8?B?czQxK3kwZ3lSbWZISVNMSGgyRjIvNjI2cDNVS1dKQ1VYMW9odUFTN2xZTWFp?=
 =?utf-8?B?SnhwRmZXOC9zNFJWcDNlNkpUU2JncHVZVHV4RjFjWWRYNVdQTVBPbWpmUDN2?=
 =?utf-8?B?WS9rdFkrVXh5UWpOTVlyWlNycU8rT0pTNHh4R0REVEhyNzMzeExEK3dCRlBN?=
 =?utf-8?Q?dAGtKngYw3eFX70gwlvv7Sc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHRDMnVMR3pWaGVHZDl0WjJUdEg4blZrZ3B5ZStTOHhNSVkrdXhjR1NEakEw?=
 =?utf-8?B?QU1LRm5BREVjNDkza0ViZGdCajhMMVl6RndIOEI4SjViczA0amtNUVl5VG1q?=
 =?utf-8?B?SDl2ajNjQWthbmNvUzVNTHdJZjhyUDh2OU5zYnRkZ2FNczc2cll6MlFiYzZy?=
 =?utf-8?B?ZUNRNWgrVnphYXNiQSthYUxubmtqVlptaXcxbG8xcUpUOHN5dU1EUzN1eG9X?=
 =?utf-8?B?RVRnUEp1VlNMSksvUkt6eVIyM2RrWDNHajZya0x3SEtqZEtHUWNHZDR3dXM3?=
 =?utf-8?B?Q2w2VHZ2U3pPdklGLytWMWVuTTNjcHN5d0dQdnk1dllrTVRvYmlMaXlsMnBz?=
 =?utf-8?B?L3VKeVU0L2VBZFpNMXpXNm9MYm5VOEtjcEJ1eWFwa0FMOFpibGtsc3hpeGdP?=
 =?utf-8?B?dG1sNjNoL0pjcEFjNG9VRFdvZDZRZmdpaTg2UHpPMlVZcFVPK2pGbjVCK2hz?=
 =?utf-8?B?Q2N0WVNza3NxVldiVVUyd25ENk8rb015ZHJicHNSU2FKOHVaZ3BnbnlJYTBK?=
 =?utf-8?B?Zzc1dy9mM29YOW1xcEFITG4xMUhiUy8xcUZrSTIvZTBIL0VTNk1wdTArNXFa?=
 =?utf-8?B?VkFWalJkUVp2THZJNE42VGJEaGVNRlNMZjAzcHRRYS9ja0M3WGZqbEc1NDZo?=
 =?utf-8?B?R3RTNWdIS1k0cGlwaVV0UVZ3OEw3bDU0Tml2M0F0ODZsUExjMEhmbWdrUG5V?=
 =?utf-8?B?dGtjTGJWYTFXTDdJd3VCdVBYblRVaHdzUThsc01TWlVOUkRVYlVVb21aWnFT?=
 =?utf-8?B?UnR4dnBKU0NQNnlCYXQwY2pXWThwejZGb0E1NzVjRVljeTR2U1FSNlNIQU04?=
 =?utf-8?B?ZVh5ZFZycm44S1U2Z1ZZREY5SGtJRUNhRytaeERaYk9TVFJVWHdHb2t3K0hz?=
 =?utf-8?B?c083VXVGUTVMcWtETVpRU3BOaUhmcW01VXllYTl2M1JGT2E4dG83RTk0b0Y0?=
 =?utf-8?B?RnBaSlhkRDZiSjhmclg5dURxYzVnRVVYVlVmcFlsQmlOTTNBWUwrL1FXekNP?=
 =?utf-8?B?THZiSFU3K2VGZXdrbXZERUdWdTVWL1ZneFRSdWF3YncrcXdoOUt2aWRDSmg4?=
 =?utf-8?B?YXdaamVZTmtsYzVFTHJDSnQwM250c0g5UFFFZjVhTEhyNHlEK3lMNlZGbVRI?=
 =?utf-8?B?RXp5WGUzQ2I3MmRnOVpyM2Y1dUl4cXdkM295clhNd1Q3T3IvalR4R0FLMTFU?=
 =?utf-8?B?WUtZZU5XSUlscXRNRVhtN1dYR1poSFVDYjh5Q3lwdzUxN2pjOE92MzRvTkFh?=
 =?utf-8?B?WFIzSkgzRXcvbkNMbVRrcVl0QkdoeTdZeGtnbHRZajVqWk9XZnREN1k5Mnov?=
 =?utf-8?B?RHlVaHQwaXdWd2NxTjdNZ05OZkJyRnhjNGIzUk80WFVnWkNOZnJOSm5zVlRl?=
 =?utf-8?B?K2lhNU5TakxTclAzR3ViVTFKNnBKMzBkOHhTRXhIUHJkeWVpWWNZWlpUSFRr?=
 =?utf-8?B?bnAzdkNacHl0c3Bia01KdFduU0RGWk9SNGR0SWZENGt1Z1ZvaEtaWERteWZl?=
 =?utf-8?B?NlMwWS9SMGNiNUdtZE5GaHcxT2pxSlFZS216YkVoZnQwaHpUNG94MThJTlBT?=
 =?utf-8?B?UFZDWWZUUEI1Rk5DS25iL2l1ZDhnbjBoYTZoQlBLcVlWNXVTRnY2S2t3anhn?=
 =?utf-8?B?L0lMeEgydCtPOWZWa1Z3eXdrSU50cTBZSmRMUzNnMWNxdTlZMUsxVG1ZQjdP?=
 =?utf-8?B?eEduVnhQWllWT25WQUxjZ1lrOWJhcGVBU1VGY2RkZiswNzFsbDFoLzlDWjV0?=
 =?utf-8?B?eWdMMGQ1TnVJM0hYZUFoU1hXRWhDQlB6bERkOXhlNnRXOEpzbXFFd0NndXdo?=
 =?utf-8?B?cGRWaG5tZ1ZpdkthWEdBMEdoOHVrcTF3V0hyeCt2Wi9mbnRjN1RDSUdmd2g3?=
 =?utf-8?B?WWlvNk5QUnF0TXpma2Y0SVJ5MVJSSzA4ZTZTMXV5UFkvZkR1SHpyQ1EvQVdy?=
 =?utf-8?B?SllhWWZQRURoc1FJaVU5ZUV1eW1pSmNVOG9IU1U2aFpBQ2w5SEE4WmRmQjVQ?=
 =?utf-8?B?TlIvKzZmYVhlelFBOEtwaVFkVGQrbU9QUU5Wc01ZY21iakNoOUM1YnZQUzJS?=
 =?utf-8?B?MEVNWVlIN2JaUkhYc1ZKaDg1aGlhR0VmcmNVL3czNnZaWDh0UEVqS2xNK0dC?=
 =?utf-8?B?ODExSnlnN0E5b1kwSkkyelFocit2dUZBSVpNQ1hlTjVrZ2NtbXV2M3RMN0V3?=
 =?utf-8?B?VlZZMU5oTTJaRkNaUCtUM0JWZm9udmRnMFpPdUJEVjZvYnVFM3pmRGJUUW5L?=
 =?utf-8?B?TVB1UStBVFRZb1hvWVovZElEMVF1QmJHZlZzVmNJZk9VM1Q2bVUyN2ZtQWFk?=
 =?utf-8?B?bmdnN0ZNZmlBQy9iNmQwNW1XNGdnWXAzaVFoM091MEt3eUgyZFpsR1pEMWVn?=
 =?utf-8?Q?MPYnRrRyin4RcFbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <236D1F1C7DD64A4AB04D71756FF5FC43@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f55d57ae-2335-4ee7-8181-08de6d5fb177
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 13:31:29.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKrMPtJywvMTs2t++Tfks98oJgWwteM79uVjOH3VamkJrHMWd9wXFLvYCvr+lWf1rcLXxyZG7xI7EkAFJqXUd/ELhkjWYahrAgopiNTX4K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409

SGkgYWxsLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3cy4NCg0KDQpPbiBUaHUsIDIwMjYt
MDItMTIgYXQgMjI6MDQgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UN
Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEZlYiAxMiwgMjAyNiBh
dCAwNjowMDowNlBNICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+ID4gT24gVGh1LCBGZWIg
MTIsIDIwMjYgYXQgMDI6NDg6MzRQTSArMDIwMCwgQXJpYW5hIExhemFyIHdyb3RlOg0KPiA+ID4g
VGhpcyBpcyB0aGUgZGV2aWNlIHRyZWUgc2NoZW1hIGZvciBpaW8gZHJpdmVyIGZvciBNaWNyb2No
aXANCj4gPiA+IE1DUDQ4RnhCeTEvMi80Lzggc2VyaWVzIG9mIGJ1ZmZlcmVkIHZvbHRhZ2Ugb3V0
cHV0IERpZ2l0YWwtdG8tDQo+ID4gPiBBbmFsb2cNCj4gPiA+IENvbnZlcnRlcnMgd2l0aCBub252
b2xhdGlsZSBvciB2b2xhdGlsZSBtZW1vcnkgYW5kIGFuIFNQSQ0KPiA+ID4gSW50ZXJmYWNlLg0K
PiA+ID4gDQo+ID4gPiBUaGUgZmFtaWxpZXMgc3VwcG9ydCB1cCB0byA4IG91dHB1dCBjaGFubmVs
cy4NCj4gPiA+IA0KPiA+ID4gVGhlIGRldmljZXMgY2FuIGJlIDgtYml0LCAxMC1iaXQgYW5kIDEy
LWJpdC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQXJpYW5hIExhemFyIDxhcmlhbmEu
bGF6YXJAbWljcm9jaGlwLmNvbT4NCj4gPiANCj4gPiBPdGhlciB0aGFuIHRoZSBpbnRlcmZhY2Us
IHdoYXQncyBhY3R1YWxseSBkaWZmZXJlbnQgYmV0d2VlbiB0aGlzDQo+ID4gYW5kIHRoZQ0KPiA+
IDQ3PyBDb3VsZCB0aGV5IHNoYXJlIHRoZSBzYW1lIGJpbmRpbmc/DQo+IA0KPiBJZiB0aGF0IGlz
IHRoZSBjYXNlLCBJIGRvbid0IHRoaW5rIHdlIGV2ZW4gbmVlZCBhIGJyYW5kIG5ldyBkcml2ZXIs
DQo+IHRoZQ0KPiBleGlzdGluZyBvbmUgc2hvdWxkIGJlIHJlZmFjdG9yZWQgdG8gYWRhcHQgU1BJ
IGludGVyZmFjZS4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZj
aGVua28NCj4gDQo+IA0KDQoNCkkgaGF2ZSBkZWNpZGVkIHRvIHN1Ym1pdCB0d28gc2VwYXJhdGUg
ZHJpdmVycywgZXZlbiB0aG91Z2ggdGhlIGNoaXBzDQpzaGFyZSBzaW1pbGFyIGZ1bmN0aW9uYWxp
dHksIGluIG9yZGVyIHRvIG1ha2UgaXQgZWFzaWVyIGZvciB0aGUgY2xpZW50DQp0byBpZGVudGlm
eSB0aGUgc3VwcG9ydGVkIGNoaXBzLg0KDQpGb3IgZXhhbXBsZSB0aGUgSTJDIGZhbWlseSBvZiBk
ZXZpY2VzIGhhczogMyBkaWZmZXJlbnQgcmVzb2x1dGlvbnMsDQp3aXRoIDQgZGlmZmVyZW50IGNo
YW5uZWwgbnVtYmVycyBhdmFpbGFibGUgZm9yIGEgcGFydGljdWxhciBwYXJ0IGFuZA0KbW9zdCBp
bXBvcnRhbnQgeW91IGNhbiBnZXQgdGhlIHNhbWUgcGFydCB3aXRoIG9yIHdpdGhvdXQgRUVQUk9N
Lg0KVGhhdCBtZWFucyB0aGUgSTJDIGRyaXZlciB3aWxsIGNvdmVyIDI0IGRpZmZlcmVudCBkZXZp
Y2VzLiBUaGUgU1BJDQpmYW1pbHkgZm9sbG93cyB0aGUgc2FtZSBwYXR0ZXJuLCBjb3ZlcmluZyBh
bm90aGVyIDI0IGRldmljZXMuDQoNCk1pY3JvY2hpcCBhbHNvIGhhcyBzb21lIGRldmljZXMgKEky
QyBhbmQgU1BJKSB3aXRoIE5vbnZvbGF0aWxlIE1lbW9yeQ0KKHNpbWlsYXIgdG8gRUVQUk9NIGJ1
dCBsaW1pdGVkIHRvIGZld2VyIHRoYW4gMzIgd3JpdGVzKSBhbmQgSSB3YW50IHRvDQphZGQgdGhl
c2UgZmFtaWxpZXMgdG8gdGhlIGV4aXN0aW5nIGRyaXZlcnMgd2hpbGUgbWFpbnRhaW5pbmcgdGhl
IHNwbGl0DQpieSBpbnRlcmZhY2UuDQoNClBsZWFzZSB0ZWxsIG1lIGlmIHlvdSBoYXZlIGFueXRo
aW5nIGFnYWluc3QgdGhpcyBhcHByb2FjaCAoaGF2aW5nIDINCmRpZmZlcmVudCBkcml2ZXJzIHNw
bGl0IGJhc2VkIG9uIGludGVyZmFjZSBhbmQgZWFjaCBvZiB0aGVtIHRvIHN1cHBvcnQNCmF0IGxl
YXN0IDI0IGRpZmZlcmVudCBwYXJ0IG51bWJlcnMpLg0KDQpCZXN0IHJlZ2FyZHMsDQpBcmlhbmEN
Cg==
