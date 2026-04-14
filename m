Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C527470;
	Tue, 14 Apr 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176810; cv=fail; b=h6RllHKwkOJpGUUEu7380YTThNqUoGqEDYOVbjGWk0tJmbaIY7IH3W9ChX0LmVCeFK6PfSo5+/CZRsfDyxDpGUaaC+ms6805CAU2D8QE6sWgyumdqo3atWOr7W3AR2d24HBtkZ9ixzQC23HzOhkPpI36Poqxkiy2zislc8GMXrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176810; c=relaxed/simple;
	bh=agr2K+32F6lcubnorsrVLaps+4FgTufXdyiY0nLrWUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PrWyNVxU67abn6vMqK2GFUOypKvUZVa+FN3cgmfsFKeTpyrBTjHRMruiecv3s4PkhQ7WuBkDTtWyEOJUPnsLtm4AAYpO6UQgj34mp2gU2jhEk5f9HxJ/oFd3BnSnTGmEjxMiD0HUlsNf8rAnGUk/aD2Qh4Kd/1QnUCVFG3Bckik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bS0XagSR; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bS0XagSR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqyGY82fkdkah+q/CN3LpMbWbJycU0JCHYsnOL6Q7G2P3UTy/0ncXfYKr56bkNs6ZNeVxMIu8ug1WDNZnbq72WO2VaXg4OrDyQhR3i9EwjNok5a8A5VAPVpC315ORCJw8jNfiwDegveYzfThljrFR2D5+fd+ZkY2C9HIchMk0522vTr/m7r1tE4riTbNdR8bTpWzmCqZ+zVpyeUuU9NCKpgFOPYjHCEPN4h/9ow1Pbuhc5D4uwcZuIiD/mbONwvBtPcCWQoWxIWZbY93pO/dDv5us1mi0VzSNl2YR0XMTRuDMa/dnX3KWAJ5mQubp1itYkF2Ldpl1e6XBw1poIuMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agr2K+32F6lcubnorsrVLaps+4FgTufXdyiY0nLrWUM=;
 b=nDXkBAZJSP52CopRt346JFQVb/tsnORP5SbABpkhapXk041HkBcDkr5vQhlUO26cpP8FOk1EB2rh3qZiPh7TYJLz+gkxSxGDhJXceOrUkxELI0j/xTB06EnOZcR4fLTdwDsRSaUGP5Qeyo6xinJ4Mv/OvwhJpzJGqRGnxhuxOGJKM3Wf02BeTKxZzJxYAVx99drpvl9u9SRlSyf9IszdFUTFjXrU/gJG5FXjKCkXYjO4gV2M8J23UOUDtRSI79chqsYlqqJkffa13OEHJqUjW4opZKApo3Kfl+o48lN3xgBWRtBH3U2tooWPMVW5ksjZMrT+QJCic9tq5ouPG+aT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agr2K+32F6lcubnorsrVLaps+4FgTufXdyiY0nLrWUM=;
 b=bS0XagSRHwhn4ogPUv0xj0CfX/sdTFzGJhrz07K3OUdlAHUdeMblmNPM6BqWP6z4r67s2S/BC7e51PHSnZBeFl8gwt1CvvRrgTJKJH/Ykj8ytJ8VSTqzY/A3L4F9i6s+APPtpQj+BtxnS32VEuF10248Y64jhldRIpOnvNF3LimFBvPYZLOiwxlJedhpOtlyesXLnrm32Hzh3K9NS0xp7wJxdG2OiQafsm6SgWxIgBTahJfcfXLkWp1aArOpMHjYXrjK7J9J0LJoKnIu8vy7BOKUI/Z+f0oek2acvUxvJrVDQ9mlg2OLo1AUxuXUCMhEtZgEuJ+8BlN2bbMmJmYEIQ==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 14:26:46 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 14:26:45 +0000
From: <Ariana.Lazar@microchip.com>
To: <andriy.shevchenko@intel.com>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<jic23@kernel.org>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>,
	<error27@gmail.com>
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no Vref1
 case
Thread-Topic: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no
 Vref1 case
Thread-Index: AQHczAsIhpPZdglS5Eqt/NVIwe31nrXegeuAgAAbb4A=
Date: Tue, 14 Apr 2026 14:26:45 +0000
Message-ID: <30022c5e780b2312e764c9e25399d67b2eed165c.camel@microchip.com>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
	 <ad43ofFZwzEkYifY@ashevche-desk.local>
In-Reply-To: <ad43ofFZwzEkYifY@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|CH3PR11MB8444:EE_
x-ms-office365-filtering-correlation-id: 5a8abc1c-629a-4662-0c8a-08de9a31db6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 kZzfSz6pfDXBzoM+UMQhc7O9fT77Lpqz3Av14oOwaLFh1SnTmvWaoRNCrV7IFKnH2aJ4b7KhOqfF8mT/4P4FTtZFV4wnMXOW+rlIFhBxWBFWbZfY8wS0eHxYIYPuQFd/XQGglkdp9qNgTN6Uldk+l4mC5EhkSfG6svtDilCPY47cdui418/Fp00R0LppA/wwkB9NDnAQ9kiYCy7j9qtOmcnkGBJoEGG+Dg1lulN6zu30CN/SxTjaMMKNVshw7FxWUYUjm21Z75wY6h8bdxmjvcl52zcsgeIAqr+miilFg8duFGbNh45v6roI4BKiNsGuV5Z3C9bzT5uiynxfVbAt6czEb6br4ideli3GybXMyNw8OmHghRvuiTD5MT3AYWfiLlpGk/Y0N9UwMgrJmpqWJJ+r0iYf6ZqtHXMf3DdUiaBVdIcca1KMurHz/kT08kseAALPHdwjxaQmXTEazgDa0GggjHAu16LHy7kewb9JFvwj7F+zDFosQ3JieNFM2G/YHW9G03c2Z6ELI2TMcMgiOcTr5f/p4ttgvNpA0iHMC4KIS+oLm0JH37G+1fnqRphm1m6V6w4nXP8ICouvJa/gUjTGtPimCmm0e5E/orOmiDUBKsgWLynBgXIWPCdtX6f+6dIjC2DduqOHNlZdwCEwHl8+iMLHJakF/HqgQhZtxheATc2rO2h4Bd0cyCKPHHrVLFqChoZJfuPdfhI3AkEyJ0Cpu72cfGspWLMaDF6PIKJ9gNt8GRedc9s01jj7Tq4Drg8ihWY9/CY/yxhG4jGuTh81nNdcLQCKqIW6nJ17C/o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3dodU9pNmJjRTBVdXg1NWVzUHRXbFIvZFpmRmlVUUhMNWpWNTg3NWJwWE5V?=
 =?utf-8?B?VGNUb281UFVGS1dCUXJ6VnVLRG5YbUNQZW9kQkFsODVQSkJRV0VGbTdCbjZq?=
 =?utf-8?B?RFo1UlpZU2JOa3kwVlpTQkRWTXNiTWZIUWJ5b2VvTGJJRzlnU3ZFUXZESDho?=
 =?utf-8?B?bS9sWjNtNFEyd2lQc3VHdjFVSXhlMEJ6RUFvaHB0U051VmxxeVBFbFZPbm5B?=
 =?utf-8?B?T1NzVDJlRmtzWWlIYytqN05uMmIzVytoQmdqQVhlK2RDckhGZG1KUFBvbHF3?=
 =?utf-8?B?SWpsT0g1aE1NV0FickZscTdyNzhVazY3RkVlSjRLNkhWd1l6ZVZRNVg5UTE1?=
 =?utf-8?B?bWVLMzVIc1J0WTBQSXEyVG1GUnpENi9Lckl0eDdlZm1TdlE0QUhpWTRWb3Ra?=
 =?utf-8?B?bndVVEFDTDlyMUVEMTNoRnFHRnBudGpoc3U5M0FpRnQwZDBuZmw0amQxVThK?=
 =?utf-8?B?Rk5ZTFhBNFAvRGJxVnFOU05QTmxqTjVzZDFRZDRLbGMwTEI0VllVMVhnZVNO?=
 =?utf-8?B?V2lTTS9wVkVnZjhRcmE3S0dzUnQ2bWtEWDJEZzQ0WFVYUmtWSVFJcjU5aDdG?=
 =?utf-8?B?bzZOOHVoVitwdk0zZ1h0MkEvVDZMYWdJTkhvMnlGeTkyejRYZEJxbFFzUW9T?=
 =?utf-8?B?NXQyU3ZmL3R0OWxJRUZQQmFYK0Rud2kzdkxkM2xLdXJBc1gwelFVYXFRdTdZ?=
 =?utf-8?B?Y3RGU1ZrSFNuZU10VWYvd0hERzVnZXZYaFFjVGxMZXVndHNvZGFkRmNodHV0?=
 =?utf-8?B?U2tOWFNGWUFqS2kyTzBnQlJQa1NqaGM2bm1JSnhnZ2luVGdRL3ZRdld0TERW?=
 =?utf-8?B?WHMwUERRLzIrOUE1WUxUUFhjOFJYeHFUOGVLeGpKTUpKOFpLeHRlN3h3UFp0?=
 =?utf-8?B?Umh5a2tmQ2ZGVTVNLzlTTmxmVjVsdmpYVjdqTlhqemtrZDJPZTNnSTkzcUkz?=
 =?utf-8?B?eWh2UFFRT3JOTUVQZjVuaS9UT2x2SDJsbzk4ejVEa1EvN00vN2hvUlcxejl0?=
 =?utf-8?B?Mjd5NkJFV0VPZnhDRjBuaExZbGdUUGRTdzBkcCs3amtPZmQ0WFRsajhWdzlN?=
 =?utf-8?B?WTZRdmtSUy9SVlFBSUpabEFabU5XNmhxeTgyK1ozK2ZDWUV3VGVTRUFJdTll?=
 =?utf-8?B?Tjc1Q0dBc0FqcWtWd1A0bStLSnIzTTU5T0tJM3YvN0M5VnhsT1RDNzdhRk1Q?=
 =?utf-8?B?cEpSZEc3emhhYjVMb3JGbGh3bzFhZmtTQm9JNW96bE9xeEhqaGlJT2hBaFl2?=
 =?utf-8?B?Z1E2SUFITThGdllkNWtoai80c0NZK2NsN2tZTDg3TmNSSlhmc3owbjNJVUdN?=
 =?utf-8?B?Y0QvdUlYaDVGeDh1Qkt4dkJhb0Q4UnNWZFExVE1zbUJxbk1GSDJhd0pLdmta?=
 =?utf-8?B?eERyQzRqODdueHprdkhKWHZhYVB5WGFTQ20zalZyS01lekY2WE05SzJBRkl6?=
 =?utf-8?B?akt2V3ZYMG91a1VvVlBTMGgrMkFwcGtWQlpZa0FLWWVvcVBBVHhoWEgxbHlP?=
 =?utf-8?B?Nm5ULzJlLzBoOHBsTHJORkZoeUVCTk1NUGhjT21iZmNsRXZpY1p3alBoTHRB?=
 =?utf-8?B?V01NeFlzdU9CQUllSnQyTGtmYnlzd25BT2NFSldUTkthUytMVUZ4dDV5S2ow?=
 =?utf-8?B?RnRiTjc1bzd3K1ZUd2RjNTNaL1o2d3NNMk0rVnUvQlJITDJFc0NiZEtPS0pM?=
 =?utf-8?B?dUtERHFrNFVxZ1l4UlU5bzhKa3dIck4vdVIrY2NNaHFlUnNseUR1a3NBZlFu?=
 =?utf-8?B?bzVteCs2V3VteUlkb2d1ajZoc2FnMTQrblNaRURNc2NKaUl4NG5GemdNRC9a?=
 =?utf-8?B?d2ZLSG5nWUE3M0JBM0ZJU2ZqMHBXeENXSzU0K2JqU2VEZ0pBT1FSeG0vckZO?=
 =?utf-8?B?OHdRUXlBUmNyL1d5SWZ1SzM1QkhyT2ZLeFhjQm5kYzVROTdMTGRkMDRZUEgv?=
 =?utf-8?B?UFdod052SU5yT2JJc2dlRjd5SE5kY2NHeERKWDh3QUZreFIyV2dDWnE5aVFL?=
 =?utf-8?B?SS85ZXZlZk5nWWlIc0t0OUtud0xwRWVmMmh3aCs2b2MzUnhQdWVpMEUxeFV6?=
 =?utf-8?B?RW53cVZYR1J2RFV2T3pZYXVWR2VlTFdtNk9nSEd3MURLd1JxNmxTR2U3dkVC?=
 =?utf-8?B?SHBRYkVpbDh3aThYWEVRbkV0aG05cXAxVWpmZlp4MVNmRzFrb3kxeFgxdit1?=
 =?utf-8?B?OXlsMm9EbWYxVStTTWVDelRLZXJxZFZWNSszTElVc2sxbXBjUllYakk2M3p2?=
 =?utf-8?B?cGIrZStpVXZ1bXlyRWdMNzVONTdNSUEwMnAzOGxvcnExbW9TYzAwS0V6Q09D?=
 =?utf-8?B?UkxIK3cyZ3B0YWlaWG1KY092VVhibDFiY055cnF6MGlHL2RaMVZZMUw2UUZJ?=
 =?utf-8?Q?uNSPiAVWrLEDjKZk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5773FE7289182740BC076FD62E8CCEFF@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8abc1c-629a-4662-0c8a-08de9a31db6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 14:26:45.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqrD8nDPh/YV1vvWF5DperT3aUTG+gx23p5OkQXZgnVXCO1CnzzfOLTxRxqqZxjiClGluEoLpog0PEqXqsCJOfiPkMLNrEM2m6JYeXvKpPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444

SGkgQW5keSwKCk9uIFR1ZSwgMjAyNi0wNC0xNCBhdCAxNTo0OCArMDMwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOgo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCj4gT24g
VHVlLCBBcHIgMTQsIDIwMjYgYXQgMDM6MzM6MzhQTSArMDMwMCwgQXJpYW5hIExhemFyIHdyb3Rl
Ogo+ID4gSW5pdGlhbGl6ZSB2cmVmMV91ViB2YXJpYWJsZSB0byAwIGJlZm9yZSBjYWxsaW5nCj4g
PiBtY3A0N2ZlYjAyX2luaXRfY2hfc2NhbGVzKCkgaW4gbWNwNDdmZWIwMl9wcm9iZSgpIHRvIGF2
b2lkIHBhc3NpbmcKPiA+IGFuCj4gPiB1bmluaXRpYWxpemVkIHZhbHVlIHdoZW4gaGF2ZV9leHRf
dnJlZjEgaXMgZmFsc2UuCj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqAgdnJlZjFfdVYgPSAwOwo+
ID4gwqDCoMKgwqDCoCBpZiAoY2hpcF9mZWF0dXJlcy0+aGF2ZV9leHRfdnJlZjEpIHsKPiAKPiBJ
J20gd29uZGVyaW5nIHdoYXQgd2lsbCBoYXBwZW4gaWYgd2UgZG8gdGhlIGJlbG93IHVuY29uZGl0
aW9uYWxseT8KPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGRldm1fcmVn
dWxhdG9yX2dldF9lbmFibGVfcmVhZF92b2x0YWdlKGRldiwKPiA+ICJ2cmVmMSIpOwo+IAo+IElm
IHdlIGhhdmUgbm8gcmVndWxhdG9yLCB3ZSBnZXQgYSBkdW1teSBvbmUsIHJpZ2h0PyBXaGF0IGlz
IHRoZQo+IHZvbHRhZ2Ugd2lsbAo+IGJlPyAwPwo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKHJldCA+IDApIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB2cmVmMV91ViA9IHJldDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkYXRhLT51c2VfdnJlZjEgPSB0cnVlOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHZyZWYxX3VWID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkZXZfZGJnKGRldiwgInVzaW5nIGludGVybmFsIGJhbmQgZ2FwIGFz
Cj4gPiB2b2x0YWdlIHJlZmVyZW5jZSAxLlxuIik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2RiZyhkZXYsICJWcmVmMSBpcyB1bmF2YWlsYWJsZS5c
biIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQoKVGhhbmsgeW91IGZvciB0aGUg
cmV2aWV3LgoKVGhpcyBpcyBhIHNhZmV0eSBjaGVjayB0byBlbnN1cmUgdGhlIGRldmljZXRyZWUg
bWF0Y2hlcyB0aGUgYXZhaWxhYmxlCmhhcmR3YXJlLiBJZiBWcmVmMSB3YXMgc2VsZWN0ZWQgaW4g
ZGV2aWNldHJlZSBidXQgdW5hdmFpbGFibGUgaW4KaGFyZHdhcmUsIHRoZSBzY2FsZXMgTUNQNDdG
RUIwMl9TQ0FMRV9HQUlOX1gxIGFuZApNQ1A0N0ZFQjAyX1NDQUxFX0dBSU5fWDIgYW5kIGFsc28g
dm9sdGFnZSByZWFkaW5ncyB3b3VsZCBiZSBpbmNvcnJlY3QKZm9yIHRoZSBjaGFubmVscyB0aGF0
IHVzZSBWcmVmMS4KCkkgZGlkIHNvbWV0aGluZyBzaW1pbGlhciB0byB3aGF0IHlvdSBoYXZlIHN1
Z2dlc3RlZCBpbiB0aGUgZmlyc3QgcGF0Y2gKSSBoYXZlIHN1Ym1pdHRlZCBmb3IgdGhpcyBkcml2
ZXIgYW5kIGNoZWNraW5nIGZpcnN0IHdhcyByZWNvbW1lbmRlZC4KCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI1MDkyNzE4NTMyNC4yZjllODA2MUBqaWMyMy1odWF3ZWkvCgpCZXN0IHJl
Z2FyZHMsCkFyaWFuYQo=
