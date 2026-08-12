Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C989357CEA;
	Wed, 12 Aug 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541692; cv=fail; b=hc3fDw1w+NMAOrExtZwl5SbyloNPpmm96mqTf8TRE+0NCmpVr2bMlYsskEskOpV6TpRH+3SUpI3kJd/rH9BuJITUxT3A+oR6JSHa5+i8iG297ix/BZPaUkakFFtj9aAkJO04g1De2IhcsNewYfNU0kPFrIz9f3Oso4a7QzZ9bUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541692; c=relaxed/simple;
	bh=9GICNzNSCEfLBYF8CJs1sJpIz0+zuZ6I7UvXBqZ3yvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BsC/tvdrza3MZ2jAr4MOqziQc3RKJp05sJsIUbEobo/YAdxs1DfAyOuK0WMyoGR0XonQdniILmnHU/JQLBu0AgeejWa9TbWh0G5Di0uw8eg0C5HBmyjCB3sGKNxVD7ByucY5Hk+d33c1wAbQH2KL0lt3eFb52hxZtwxg8tdvq1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5f4pXlMR; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5f4pXlMR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M64r84ibIlhAd+kolldlfxdQ1JgXZfH2H5r2iTOJSVaFJ3TVc+78uuXeJBp2MnYe3sdprQGAhJoeVTKhOlJRu1z6rsk1U1bXGTwLfWiL2YigM76SbM9DuC9U+uyEtUAA9AWMcbqBK7tVonrJ4rL9k8x2MX8oeYGQ45KOesnmTU+2sbJ+tzzMnvG5smVMEGG6cJ8ZJvYeJ+fx/K9p2gg0ee0Fv/YfoDYpIDs5zzUXmHFucO07IjCcPaTKdfLCjONjbPioX4GfYk5m9k+c33Lq/1iAQOhYGZOdoTKujsA+eNw8p8frTCN5wuhetK99b4tNpsg30lRrLRjuwHNu/2U0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GICNzNSCEfLBYF8CJs1sJpIz0+zuZ6I7UvXBqZ3yvQ=;
 b=mhS3rVdFOwk+BE0Ativ/F+HOpXjYXQ+CvYIH4zs4i7YQct5l2Mt63gJ7m5/SDwEaNE3/5xC3HqlQNJveYuu8jJysn2lxLucsnXLL/JHaM2LrHu+b/3lZpM2vqSkWNROH5ojmIyguXse/lIyaKn/8xBBCuz8hh+uyNHR8/0PbLkTxJDnnK/rkIkXUSuV4chqtAqoW17hJB1gh3y/3LAxDUwf9T+EebNmc0kNZLKCQA2gNI2q3HKhSUmgdFYh9AW//9mTmILditWM5V4iq84I5tsLdVlI7s85rH31h30oQYeelE1EA+hVIUXskugm12QKTaKp3UgfGtTRkuVuElKUXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GICNzNSCEfLBYF8CJs1sJpIz0+zuZ6I7UvXBqZ3yvQ=;
 b=5f4pXlMR2/hCkkuZ6/ebeevPcxPaFofClJG6eOJVTW/f9CvRcjfZSDnzEg4nXGTSM8PLir21cDd7cx7vDzg//n0sJYnWdc7rC/2Y1D3pHvn5+I0gvR8S6YDoQtr+NA5A6ULOiQy9fj4WMg0u1evC+2gBrKtDzNkdiL0KlolOlD+U/Q/W9JSEYukuCid450upaVvUYaxXRqa4+DYaOcSf2H3Pf2a4v4O6tZYmj1qayXrozvyvjsgKLd8rQwmsvcsvB6xtrhHdPKJfzEGb9/wfNpn768qZ9iZE3lbYOW0E8gTO0dT6OtCGDq48NxQnQWI9DoIJcFltmFFY5tlm7s8G+w==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 12 Aug
 2026 13:34:47 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 13:34:47 +0000
From: <Ariana.Lazar@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <jic23@kernel.org>,
	<nuno.sa@analog.com>, <dlechner@baylibre.com>, <conor+dt@kernel.org>,
	<andy@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add support for PAC1711
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: add support for PAC1711
Thread-Index: AQHdHokykpsIeRyJJ0yHGE2xUNV1r7aJeeKAgBEHtwA=
Date: Wed, 12 Aug 2026 13:34:46 +0000
Message-ID: <0c0cc5addbb604187335cd534f68a9a7f8ce4ad4.camel@microchip.com>
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
	 <20260728-pac1711-v2-1-609bc026093c@microchip.com>
	 <a869acd6-9c77-4495-a581-232ca88ac9e2@baylibre.com>
In-Reply-To: <a869acd6-9c77-4495-a581-232ca88ac9e2@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SJ2PR11MB8347:EE_
x-ms-office365-filtering-correlation-id: c10583ff-e07f-4dbe-68e5-08def87679fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|7416014|3023799007|4143699003|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 a+5H5b4/mfxQ5CEgjkURXuxN+/bnwhlO0NEa447h6RW0eK60TC+zW7KVKWTp7BYIexg+bMiwoLRlDacn+q8jTywXp3fgepWViwFQp3EaWNcN3WxLYHViDVYq4PQGeoUle5XtZh2ZXf3gPxrCCwQkiridsqMzLyWFgH/aGO0+0QzD+6mOwWiI+DdbIUNf+HL392HrOf3AfoXzbq8lt4rB2CsaVmyAp+kMFXvzBede99/czJm5MGdcC5V8OMacx11TbSZI6beq50qcNkNw05PLKPhTXzBQa9jJt5+Ui6E5XgDOc9Etnh9zhhbLEJD7ADqt8xO5RLL3hYUM+AP2vZGPsIYWRvz+C0TGyvT1SG8a/InY4I0bPJM2u7roibMYuvP2IMDqqZy/2kxIpB43PajcPOyOPbk/VMTIa1tDr8ekjkRlX3Pr4YVqRZlogtIKe/I6ZTb5C8c9xN4w8wIO1ydJ5HYl8hJxABaysjOOrQCVKvfzrZ+w3fJ56/tAH7e7bnKv3L7Nq7g0ipaX87tm85dTRznRigcDRc8UA2zD8q59AIqw6a+lFKmdToCDVrzJlmW00Sm7bDcLEritgX4XQzkygy3kze26bmxqTnr64kpORzvAryXy4Xes8x1Wa9fQRDS5a9pmQOW+4pPtjqZ5YLq5dYaG9e7LjzbkXgcIeoWrsHqJwh1jUCcmqkhbONQ0uf0RaT2uGWjdL16KABoH9ijIku860JJXuIEeUys6OZmal8E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(3023799007)(4143699003)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amszNTV4cHZPRHlqNFBGTGVNR3lrYW0rZkIyVitaOGdBWVVFTDNOcWNvSER1?=
 =?utf-8?B?SGs4N1cyZERick5GdWJOMFlDeWlYeThjOTJOSXVqQ1pwWTdwVENsNWhkV3c0?=
 =?utf-8?B?QiszZlQvcWcyd0c3ZDBVbGI5Z2hqS3NMZmd6YllVVWNQS0ZzNVg3eGRWOU9N?=
 =?utf-8?B?WUlCanpRMzY3ZVpPM1pUMjVVMlhmeDVDOFF5ZVJWVzNNRmtMSEFnQUJlYmtC?=
 =?utf-8?B?ZHhCOXZDY2hFNndla09kRXVFTVB3VkJneDhEUlFVVXYzcEszZHBqTVYvRG80?=
 =?utf-8?B?U1FwRDFSalNmdTd1cTNLMG5wNXJIRnh1SWVxMDN0bVRWNWs5RXVNVU95UCtT?=
 =?utf-8?B?OGh0MTY1R1Z0YnJLWis4S3JxV2hnZkNBQWdtUUhneVpsRytabTdWZ3RQemtt?=
 =?utf-8?B?TmdjNytwZU1uWXdVS29mT3Y5U3l5WlBqSklGNzIyNzNLVXUvZ0txOEZyaTBM?=
 =?utf-8?B?bWZGMFBsKzd4MUxPS3BUdlpyMmRJM3ZsL1phbi9oMHV1QXRBc1lPYk5zMysy?=
 =?utf-8?B?Z25LbVAwRnU0ejNCZ3pYVTk1RUVaMFE4Z3h2V3V1ZW54Y3ZVR1FBVllDeFdx?=
 =?utf-8?B?M2xyT0E5TlhaWUs0R3JSc1VXY3ZVWXNFZ1JVTE5sWVFmY0xESCtSaVF6VEF0?=
 =?utf-8?B?a256cE9TMmg0VTVQUmNBSmtsWVphRnBQa1pudFRDb1JsM0M2ZDBlTldrMlVM?=
 =?utf-8?B?MzhhK0hibFNtSFhIcWZzRDlkNFVaeXhEb292ZGJsU3pEOE5EQzhUQjBYQUZa?=
 =?utf-8?B?RGVNZ0paTzhsTjAvTXloWmpnVXU1WjRCQksyNjBnbnFUTHE0eDFkbitCSXRw?=
 =?utf-8?B?QjBJN2dsa004RzArbzcrbXIrZGpwdVhqTjlwdk9pczhZOE03MG1EQnpJaTlt?=
 =?utf-8?B?STFQaUxZZGdwNmtxYXErY2M0MFBEbEJmbFhuSWF6NkFLQWd2N3o3UG1XU0dl?=
 =?utf-8?B?MWZmdFU0SnlxYVd0MVVLUExYbEVhRjQ3K1VBeklZb0FLQTNZa1lJWlMxR2lI?=
 =?utf-8?B?Q01rZGZ6eVVDVUF0SExmYkxmaHNJNU41bGNwSEdob1ZjNk10cmgzZjFKaktn?=
 =?utf-8?B?bkZIblR1Y1BzYlBkWVZSMis3MFZDUnJWVkY4d2tqTzZna1NuclVuNWpka3pT?=
 =?utf-8?B?Yklid3krcTFRNjNjWlRGeEN4azNqOU5GT1JHdFhHQ1NuSlJEUlNCYzhsVFZ3?=
 =?utf-8?B?UHdtYlVRdCtxWUlxSGliV2lNekRWcnpIN1p2V3pjSGFZRGkyVUcrSFJ5VnNz?=
 =?utf-8?B?dXNvTEZIVWlVblZuS1UwVEZVaGg2VmowSmxIakI1R05WLzkzRlBLZVluaDBF?=
 =?utf-8?B?aTR2UDhIWXEzcTJDejQ3eTNVNGlVQW1Dc1JHV0FGdHpJRGZsblhpc1YwaFd0?=
 =?utf-8?B?cWVKUDQ1MUcvaG4wV3NNSjQzZFhjSnY5alFNcjBiL1RjbnZmYmpHTzhCdUJy?=
 =?utf-8?B?NHYyN0FNUzFqYWhaa1M2Q0pSaWdyOUd0TlV1YS9GSFVnaW51c0dndDZJVS9a?=
 =?utf-8?B?bUd6ZEJndWswMUs2R1g2WGJ6eVUrdXdLWTZKN3BCRzVNN25ORjlWanBocmxQ?=
 =?utf-8?B?UU43NHJJZXZjMUNoem9GNXR1Qm9RMEV6S0RxTWNUVzZ3MGd0M0h4VjFVNjlP?=
 =?utf-8?B?b0VWa0o0SmRSUExUYXhDWmhZMUw4dHRZSDAyWExLaDNiVUlBODJPeXVSbGFx?=
 =?utf-8?B?NW9KK2IwWGxVSUltaUNhUW54TFNzR1JRK0Jvc3RSa0x5M3c3SVdNS2MwQ3dU?=
 =?utf-8?B?N3h3VndtUSt0Vjh0Zk1lWElacVpseVpiN1NzdkVDUjc4VmFQc29qU2VUNUVr?=
 =?utf-8?B?MDh6b3NpT0w0d1drOWZmVU8yWDQwY2h0SHc4eEN1Y2JHSkxlTi9hNVRWaHZz?=
 =?utf-8?B?aEVkaFlmMENhUiswUGxjbHcxSlFMdXZsb3N1RTJtVmNhcTI0bStzb0VnRjlP?=
 =?utf-8?B?MVplRFdLQ0dHSzJnUlVYUDJXcElDRVlCanVoQ3pxcWhOOCsvdmNoM0tpaTFD?=
 =?utf-8?B?Q1lDck1yWHIyVW90eU5TUGtqTVRFdWZLUmVrRVJFVUJCbTdDNG1UVG1VOUJS?=
 =?utf-8?B?MFFQd0xGLzkzM1FZTzdhcWNFYXdjTjNTMnBsRDRZTVBUOXFUbVJWS0FNSEhQ?=
 =?utf-8?B?S3c3VDlsdWJJMHlKYWlFZTF1UzhGdzV2bXNxQnJubUVWN2MxYWtlekNkWDJR?=
 =?utf-8?B?ZFlKVFE2aG9CdWJidVlqRDZ6ZFg2QURPZUFpVTZTSWlxOWpLb1ZKUlpWNXNG?=
 =?utf-8?B?Y0U3ZDBRVzFuM1NwSDJLU3lGaktJWkxvU0RuUXhhVE9ad1I3cXIxSGtxRFVk?=
 =?utf-8?B?cS8rVnhzUk9BTm1OOXlXMmxiMi9PY3VZd2pUWUhEWEZ1d0VzSGNPOVB1MFEv?=
 =?utf-8?Q?G8flgRXzVfu7ulrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9274BCDA97E4A547AA66404B7E70B684@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c10583ff-e07f-4dbe-68e5-08def87679fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 13:34:46.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMU5hMaTPP6clsdBFaGckM7nuV59F8IZGFQmpFQfysrlL+sGdUblb4hxuhLpkHX5aYzKFUn9xHItWj9rs3mQstczQlfxyHnLm1WohnIQn6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347

SGkgRGF2aWQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4gUGxlYXNlIHNlZSBteSBjb21t
ZW50cyBiZWxvdy4NCg0KPiA+ICsNCj4gPiArwqAgbWljcm9jaGlwLGFjY3VtdWxhdGlvbi1tb2Rl
Og0KPiA+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvc3Ry
aW5nDQo+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjogfA0KPiA+ICvCoMKgwqDCoMKgIFRoZSBIYXJk
d2FyZSBBY2N1bXVsYXRvciBtYXkgYmUgdXNlZCB0byBhY2N1bXVsYXRlIFZQT1dFUiBvcg0KPiA+
IFZTRU5TRSB2YWx1ZXMNCj4gPiArwqDCoMKgwqDCoCBmb3IgYW55IGNoYW5uZWwuIEJ5IHNldHRp
bmcgdGhlIGFjY3VtdWxhdG9yIGZvciBhIGNoYW5uZWwgdG8NCj4gPiBhY2N1bXVsYXRlDQo+ID4g
K8KgwqDCoMKgwqAgdGhlIFZQT1dFUiB2YWx1ZXMgZ2l2ZXMgYSBtZWFzdXJlIG9mIGFjY3VtdWxh
dGVkIHBvd2VyIG92ZXINCj4gPiBhIHRpbWUgcGVyaW9kLA0KPiA+ICvCoMKgwqDCoMKgIHdoaWNo
IGlzIGVxdWl2YWxlbnQgdG8gZW5lcmd5LiBTZXR0aW5nIHRoZSBhY2N1bXVsYXRvciBmb3IgYQ0K
PiA+IGNoYW5uZWwgdG8NCj4gPiArwqDCoMKgwqDCoCBhY2N1bXVsYXRlIFZTRU5TRSB2YWx1ZXMg
Z2l2ZXMgYSBtZWFzdXJlIG9mIGFjY3VtdWxhdGVkDQo+ID4gY3VycmVudCwgd2hpY2ggaXMNCj4g
PiArwqDCoMKgwqDCoCBlcXVpdmFsZW50IHRvIGNoYXJnZS4NCj4gPiArDQo+ID4gK8KgwqDCoMKg
wqAgVGhlIEhhcmR3YXJlIEFjY3VtdWxhdG9yIGNvdWxkIGJlIGNvbmZpZ3VyZWQgYXM6DQo+ID4g
K8KgwqDCoMKgwqDCoCAidnBvd2VyIiAtIEFjY3VtdWxhdG9yIGFjY3VtdWxhdGVzIFZQT1dFUiAo
ZW5lcmd5KQ0KPiA+ICvCoMKgwqDCoMKgwqAgInZzZW5zZSIgLSBBY2N1bXVsYXRvciBhY2N1bXVs
YXRlcyBWU0VOU0UgKENvdWxvbWIgQ291bnRlcikNCj4gPiArwqDCoMKgIGVudW06IFt2cG93ZXIs
IHZzZW5zZV0NCj4gPiArwqDCoMKgIGRlZmF1bHQ6IHZwb3dlcg0KPiANCj4gV2h5IGRvZXMgdGhp
cyBvbmUgaGF2ZSB0byBiZSBhIERUIHByb3BlcnR5PyBDYW4gaXQgbm90IGJlIHN3aXRjaGVkDQo+
IGF0IHJ1bnRpbWUgdG8gYWNjdW11bGF0ZSBvbmUgb3IgdGhlIG90aGVyIGF0IGRpZmZlcmVudCB0
aW1lcz8NCg0KVGhpcyBwcm9wZXJ0eSBhaW1zIHRvIHNwZWNpZnkgd2hhdCBraW5kIG9mIGhhcmR3
YXJlIGlzIGludGVuZGVkIHRvIGJlDQp1c2VkL2F2YWlsYWJsZSBmb3IgdGhlIHVzZXIuDQoNClRo
ZXJlIGFyZSB0d28gbWFpbiBjYXNlcyBoZXJlOg0KLSB0aGUgdXNlciB3YW50cyB0byBtZWFzdXJl
IGFsc28gdGhlIGN1cnJlbnQvcG93ZXIgY29uc3VtZWQgYmVmb3JlIHRoZQ0KZHJpdmVyIGluc2Vy
dGlvbiAoZS5nLiBmcm9tIHRoZSBib290IHRvIHVzZXIgY29udHJvbCkgYW5kIGlmIHRoaXMgaXMg
YQ0KcnVudGltZSBzZXR0aW5nLCB0aGUgaGFyZHdhcmUgYWNjdW11bGF0b3Igd2lsbCBiZSByZXNl
dCBieSB0aGUgZGVmYXVsdA0KY29uZmlndXJhdGlvbiB0aGUgZHJpdmVyIHN0YXJ0cyB3aXRoLg0K
LSB0aGUgZHJpdmVyIGRvZXMgbm90IGtub3cgd2hhdCB0eXBlIG9mIGhhcmR3YXJlIGl0J3MgZGVh
bGluZyB3aXRoLiBJbg0KY2FzZSB0aGUgcGFydCBpcyBtb25pdG9yaW5nIHRoZSBjaGFyZ2UvZGlz
Y2hhcmdlIGN1cnJlbnQgaXQgZG9lcyBub3QNCm1ha2Ugc2Vuc2UgaW4gdXNlci1zcGFjZSB0byBj
aGFuZ2UgdGhlIGFjY3VtdWxhdG9yIHRvIGNhbGN1bGF0ZSBlbmVyZ3kuDQpTYW1lIGlmIHRoZSBo
YXJkd2FyZSBpcyBpbnRlbmRlZCB0byBjYWxjdWxhdGUgZW5lcmd5IGl0IGRvZXMgbm90IG1ha2UN
CnNlbnNlIGluIHVzZXItc3BhY2UgdG8gY2hhbmdlIHRvIENvdWxvbWIgY291bnRlci4gQ2hhbmdp
bmcgdGhlIHNldHRpbmcNCmZyb20gb25lIG1vZGUgdG8gYW5vdGhlciB3aWxsIHJlc2V0IHRoZSBo
YXJkd2FyZSBhY2N1bXVsYXRvciBpbnNpZGUgdGhlDQpjaGlwLiANCg0KPiANCj4gQWxzbyBkYXRh
aHNlZXQgc2F5cyBpdCBjYW4gYWNjdW11bGF0ZSB2YnVzIG1lYXN1cmVtZW50cy4NCj4gDQo+ID4g
Kw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArwqAgLSBjb21wYXRpYmxlDQo+ID4gK8KgIC0gcmVnDQo+
ID4gK8KgIC0gdmRkLXN1cHBseQ0KPiA+ICvCoCAtIHNodW50LXJlc2lzdG9yLW1pY3JvLW9obXMN
Cj4gPiArDQoNCkluIHRoZSBwcmV2aW91cyB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggc2VyaWVzIGl0
IHdhcyByZWNvbW1lbmRlZCB0byBkcm9wDQpWQlVTIGFjY3VtdWxhdGlvbiBvcHRpb24gZnJvbSB0
aGUgc3VwcG9ydGVkIGZ1bmN0aW9uYWxpdGllcyBiZWNhdXNlIGl0DQpoYXMgbm8gcHJhY3RpY2Fs
IHVzZWNhc2UgKG90aGVyIHRoZW4gbWF5YmUgbG9uZyB0ZXJtIGF2ZXJhZ2UpIGFzDQpKb25hdGhh
biBzdWdnZXN0ZWQgaW4gdGhlIHJldmlldyBmb3IgdmVyc2lvbiAxOg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjUxMDE1LXBhYzE3MTEtdjEtMi05NzY5NDllMzYzNjdAbWljcm9jaGlw
LmNvbS8NCg0KSSB3aWxsIHJlYWRkIGl0IGlmIGl0IGlzIG5lZWRlZC4NCg0KQmVzdCByZWdhcmRz
LA0KQXJpYW5hDQoNCg==
