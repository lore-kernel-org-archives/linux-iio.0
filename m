Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DA3A7585;
	Thu,  7 May 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144035; cv=fail; b=ohLo0Hg8RTFPFdhI2XkckJQkXZ2Z6o0yztrH8zAzhHMP3Hd4eGqp6XDWytDcx9nPBjzXPtZP1L48/4+05MSvq4eXK5+OSSSwr5WXZzR29UN1LSU+c2gIBIMDZZ2FnN9ILC7ShkNYEE2LR1aJ9mQwGZAx30oUeqgEKNiq2KA0Tfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144035; c=relaxed/simple;
	bh=98qCMJedM6cAsR9tRyGTbRK9e7BV0pXuR4dUhM0uAsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eipZHPQ/lxpmNasNq6tK5l9/24QurP98yIKOayfotwJ8Et/ByVoNYkjbVwhpR5uLD55bTYnt7jfAl09ioXz8nmOhFJYu2BfObQaQiBFxhUmoHGgQbMweHblgEPDRWtPoSoMTE4XwA4hZ1luu1+l+B6g73j3APMbXhi/I4yb0nRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b7lIxlzO; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b7lIxlzO"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64782Ow11215987;
	Thu, 7 May 2026 04:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=98qCM
	JedM6cAsR9tRyGTbRK9e7BV0pXuR4dUhM0uAsg=; b=b7lIxlzO57/H5zus2qVAc
	4CsIK0g4s9133V82jTZHFTZ5jcQN/c88narTQ6gc+FRcT+eMNw//gdPJVtbVg7Xz
	eydkYxkx2ZXhzCn7eFuIADohjCXNwNRc5Zlqhn1c0p+tELH8fSr0d/cRIJfqk2jK
	ANnkGKwoviUKGBhL310nCany1vXFhgrdEz2BZ05PMUqo42DtVV6KUFQCGFXymxXR
	GFs14e0b4GQmGnmm9KyenHb0hdLv3ewKgvuteoNqM8/TN5gAJHeR6Zq0zjIQtEZA
	Mvrm9+5VZS8zymhTILzDCep0YBzIuJIo8D/NrPgZaetO7F+vi3VWKb3YVeiKNbn/
	g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e071d3bws-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 04:53:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMMv+KzQUYnzUTjy2fQTAse6ZEpO2n0uTIlmfsT4thnJP4EGlfmuvlmhtiCOzZWvzHGj+g79BuhNkdbx6KirigYS4WmpXbZTxz0oUfwQAoKtVILapkhnW+qIQn3AXGbQtKfUJYFrieyZIC0oJb8dmWvYc+Cfdo4NWk2tShlnvd3E+9Ux6lmR5lxKmFMwPFQl+KNrXUezRKfp/BVFU7lJmfm6ZxVF75xpuLmxly5OCv2iacwEwuQGomM341ClDRY/eoD7+V4aKo2vBQrFs9UWe9pee7GGOhwVDPaC3zZWnX30pdk7grhdZsiUiQN+w23xwTrt83sY4NQKYK7tsK8XVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98qCMJedM6cAsR9tRyGTbRK9e7BV0pXuR4dUhM0uAsg=;
 b=FcHa7abTEtIwBoSlVPj9zH4EBaBVH0NWEdq/XXPcOqUBQckxIlsCTHFUFNuAwDQhMB8RzRl8RAwMAZlqCYZk2SX5dNeI/ESVQxk/rAvJzrD6iKYWeIFXYSROL0LNc5vvEaEWln6og9/+eeXgW/xbSjr03lygu63xLgBKx/N/UBx2zcy4zPJcq4tC1EufO02zUKptZIWM5ibTtN0i+R0qVusey0fCuQJPWAcKsUa2FphZ1mirc8/7+LVFHK5ZJeKWiutyHPvmY8YGx8e5BPExXQTaFpOidy59PcfrZ5xpgqZwf+kbmM3Jr9+2f8iS2dkDuaABsr/GWzNVXfWeuxebaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by BY1PR03MB7873.namprd03.prod.outlook.com (2603:10b6:a03:5af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 08:53:31 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 08:53:31 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support to
 adi,ltc2983
Thread-Topic: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support
 to adi,ltc2983
Thread-Index: AQHc1knlqBPOAtVfc0qFKzHj3Vhl67XzTSaAgA2hoGCAAF+tAIAA+v5g
Date: Thu, 7 May 2026 08:53:31 +0000
Message-ID:
 <SA5PR03MB8377A40833DBE17374283A9FF63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-2-liviu.stan@analog.com>
 <20260427-epileptic-pendant-1df77a472793@spud>
 <SA5PR03MB83779FB7E2577AE0247D8669F63F2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260506-running-change-9d5f9d342452@spud>
In-Reply-To: <20260506-running-change-9d5f9d342452@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|BY1PR03MB7873:EE_
x-ms-office365-filtering-correlation-id: 42abbd5b-b81f-41aa-1e5c-08deac161d64
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 7JM0eLVyH7aMvySC5H+/eRJ/Inx8W6jEoe9YVitDj68vwYSd3yWyqjhmB9fpSdXxJ6Tj5x15Gt9W7aBr87YCBqmGY67huqoRyCX2dS9JXuTKkOmK1HwUD1eMRsPefUCW0gBn2hi3bbWpKysTx6qw2RedQvXIK0adeRb2bJQ3FKIvb5XPMRh8pk0ZbgwhTBwNgJ3kQ/VGaeZjBTBDBXuP8UJPLfuih36yQXEq9f02U4mUzrAUBF2a2Q3kkWPRWWrCs22IeAdV/ZFAo+X2Daw3bb7Vy7ZdtMFPW4Uqf38Jn1CLpv21qTMTvLczpCJG3EizMywgIkXtunJ5KZ1B8fqlQxFyv6vSfNxYPOTcJmeKnLD/TmU2SyWP17AftY6WsTYcpmJSahP+MzJHHLbTopdMU+QPV63BXl/XzUBK1qoWzVHwQ5Di6dBBCZrIT/wYuszWFm/IAUba1XtHrm3tbKbCpfEHJascm68eLXyjbgglMjU6cIVlRm7lT7SbsHjqkoQ8S6xpHkfyWPsz8W6awm3A2lg/WujwD7WjNIVqpz/rTnFozDr+ERGV9Ibu8WtMqB6PtGoQaIULoNDi1Fsblo9zvdUWNLyRmfTgOpRV6MI3mPVM09BRjumx/wG6EJk+ypVO5LkVtzsALZAeLCvghUVwIYHl9IMvHY2O2/GZfhVMrukYTS7PJF4PdeeJASzZYQg6NvuHtsfSTRUfP7fLByXMqLvRc3vQ69pi4WtEy2G/E7/4nMUTMjS/lexrHgvpau0L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWhTRHU1bDlHV3FVRjN1MnpvZk15ODJkZk5XbDNNMEV6MzNpVlowS1kvUmh2?=
 =?utf-8?B?UUFKMmFXaHhxa3BXTTRxNDNFNVk3MVc0MU5vYWt6VERSNWJOUTdjVXFwWDFB?=
 =?utf-8?B?R2hhSFZtOVp3VjJRZnBsUnVjNE85RWsySW1kZUpkU3lQbXRxdTVzNmtHVVB1?=
 =?utf-8?B?ZkpLd0N2NnNnZFhVdWJMWUdlTzVYTjF3OExsdGxUaXVvMk94QkFGQzdnTlRv?=
 =?utf-8?B?STFBT29LMnpqMHRYb3RjSWdlS2k0TUx5ZUhjM0hrWmpTc2pjaVlMK2VWMUFN?=
 =?utf-8?B?U3JKblNmdzZpUXJtcVNFYnY0RENTZmZsaXQ5eTQ5bk1BNVVkc3lrVTNsSUVD?=
 =?utf-8?B?WlpBT0lwR3lNelB0a05iYlNpam9lSWFTVS9WQXpBNUJ5N0xXUnhhTmdtZXNy?=
 =?utf-8?B?ekRsZC9GSnhVZ2RVYVh2bUh4ZWZnZXJyeldYbGk4NWhHWU5saXBRaGdRanRx?=
 =?utf-8?B?b2UxNG9YUjZBamFqWUViN0Y4Y0VaM2trL3N5bjhod2NBdkVEbmE5c2R2QjBO?=
 =?utf-8?B?Um5xeUpzMUdyQ3JrUWhMbks3bVlYWmpoak1kQTROU0w2Y3Y1L3paUG9YTG1L?=
 =?utf-8?B?TDZyQ2o3eXZZWDZhd3FFU3FuVUNHUzRKM2F5TnJNRWZRRnZTcWV6NlJGcUdr?=
 =?utf-8?B?OGNTM1FCVnB2RjNzRHZmQTNqd3BCWTJMcGVsaExkYmhvNDFscTZVdHpXZjlr?=
 =?utf-8?B?UGlaRDhlQ1ZNV0JYUlF0alhZdkZveHVCQk5EK0s5dlJCOEl0eFY2SW5JQjZa?=
 =?utf-8?B?a0lmNHNLcDQ5dTlwdElCL0E0OHdKRUI1akg3Zk5YUWxiNjQyMWprMWxmL1dp?=
 =?utf-8?B?WVlLTVBqWkgwQ3JMSUZ3WTFaM3ByOS80VEIwaXp3THV5OTdXQWRNRGJkcnJ1?=
 =?utf-8?B?VU4raytZbTVzVEpwdXB4NFhRNGdHN1VrYldmWllyamhCVllUakxCZFZVMmxX?=
 =?utf-8?B?emtTM0tteitQSlA4U2tYOUNVTWtIYm15cDNTRHYwYTAyNXBWYVVXN1ZxUWRU?=
 =?utf-8?B?N0QyTnA2WnRIL3lXNjFIek9nakQ5dXZwb2tCQzlYa2kyK1ZxK0Z0T2crWVlh?=
 =?utf-8?B?R3NWeXpsWmZVUWZ5MzZPTmptdWFGV1NjTitVdVJFejMyZU51d2x2YTNRMmdE?=
 =?utf-8?B?d244ck9nNEJQZWFXaTA4Y3dkZkRMR1J3MW9QYThPWHhkbkluTkQxWUdlRXdq?=
 =?utf-8?B?b0Qwc0w0VDRKSnVxaDFvclVMY2ZWNk94ZW44QlFMRU5NaUJIZHdESzdldFcx?=
 =?utf-8?B?WkROSnBSMWhKMCs5ei9xTDVUN1dudkJyTHdvdWtFS21KZy9kb3kwRitoazlD?=
 =?utf-8?B?byttNE1rV0p5ZitJZFBOL3J6QUlpRXBPdGY5ZFVGMmlaUjZMTWtMSzRxbnlW?=
 =?utf-8?B?eENUU0R0bGhnSjhXZmp3UUducUE3YVZNd0xQVTUwdjRnSDAyV1kxb1R1RWVB?=
 =?utf-8?B?Y2hkRlNWSldjdkc5UUxjdVkzNFlGclVTL0FQT3VlQXB6RVpwdnd3TytOenkr?=
 =?utf-8?B?b2p6Q2YrRjFYYVpuaVowQXhIN1NVZ05MNHZlWWhScXZDWjBOL2tHbmNaZnly?=
 =?utf-8?B?MlhQS3k0d1JmMG9Ndnd4VEdOTDRRL0VObVhxYWNwdjQ1Y3VqUHJCOFI3Nm5Z?=
 =?utf-8?B?SXcxckFSV0tLR3V3WFFJajlIL1JkV04xWkVqaURRR2Z6ZUxyZVpEQU5RTHQ2?=
 =?utf-8?B?SkJ4V2tXeEVFcUhRVjNDUU85Ym14aGJ2UmhCcVlBcGFrQk14WmROQitXOWN2?=
 =?utf-8?B?TmdBWUhXTEZGVWNlWWg5V1ZBZWphWnNmdUpwWW9Ua3hFVmlWN1JCa3VySTRu?=
 =?utf-8?B?SW9sc1JzdUo3MDhuMzJDK1hsQi93RTV5WXJyenRqRG1CTnkydE96NXpyeFRs?=
 =?utf-8?B?YnFDMTRseEdhdzlKQ3hnMG53WHkvMGNHZ09OcGZsdHJTeWU1Smd0N21MUXNS?=
 =?utf-8?B?VFdzYnZRR09SWG9zd2FRUncrUkRNNmsybjU2bVIyengvWDZyamF6a1lmcE9O?=
 =?utf-8?B?TjVKTC9vZFN2RFg2ZWRPVjl5TENMU3o4V25wUHZXNFEyTmR0SXZta0kzWkQv?=
 =?utf-8?B?bkMrbCtwbkpWc3lraUthQ2kxcEpISXpaSTM4SzhkNUpWT2owM3U4MXkwNXRB?=
 =?utf-8?B?UU4xVW1TVVBFbDB4aUQybWlwVFFFZ0xLTTVPSldReThCaE83V1JFMVJkdHBL?=
 =?utf-8?B?L1F5MTlLSkNNYmNQNjVpUDBKcy9aSjhFcjlKdU9JZndMVkZ0ekZHeG12ajY2?=
 =?utf-8?B?ZFJ1WnIvNFdiVVpySkR0SktXNUI1T1pPZm5acFphSG9kaVZMNE45N1JEK1or?=
 =?utf-8?B?Yk5qWVdqb0NnZ012Z0xYYzkxRk5kcWNHekoyYXNEM3ZiM21LZlFRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DGzFQyfS+IG18TZKEOKmYM+sbvrfed3Ckm+i9c7vH17dbaQnRsRcf5lSzQB671yZRMUWFqFv3W93NAlDoo2qNbKH4K1hctjU3uf0V0hwP5/yy8JShP0O+sPFgYI0eQp2KhYLDov7MgFo+ZtgLo/Hn+de6znM27T1IXvggBif/aJ8EhLmCpQeQdLyYrUm+O+RkeSEDDoCawaZydfmt7CBg71NTX53WiAYVqoCr2qd4PswOCAeu78ZEJJ2tKQohJkcP/MNbbz7laJrCUNNiSu8B4wjfzUXi7JQiqDa/Ex5YsW7UU/PSRuaY0pSDNovg3uFI+LM6GpnmyF//5vHvJmf+g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42abbd5b-b81f-41aa-1e5c-08deac161d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 08:53:31.5421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KU0vdUF5Y2JI81g8lEQyvdGjESoMFlfgWo6SDwp9GHe/J8XJtqaxWNetblMe+MmTvUVOjWiN/RJtBnoceseaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7873
X-Authority-Analysis: v=2.4 cv=ZM/nX37b c=1 sm=1 tr=0 ts=69fc530e cx=c_pps
 a=2HCcruDS7e3rZRcUQV6B1Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=uxyOXQnlQ_1t6RGPNtoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Mw6a9moMoFyRpTEk3VzFIgKUGZBhgwDh
X-Proofpoint-ORIG-GUID: Mw6a9moMoFyRpTEk3VzFIgKUGZBhgwDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4NyBTYWx0ZWRfX682UKvB62+Hi
 rCS35McuOay7tFrkkkiAsgki+wA8O13kU/csEugJyiMI2fYHrVPjh70JMH4wPbi1qwihZ2TMdnD
 HDeRysCd/0S/866Zfw/SJk/f/ZJj44c9PdGaoN/eREjAc5oOhhOQW6++aQAdyUL3+/fJqVlEPJC
 zbqDQ5cbVBybYw65DjcZXvll86tUjx/0UiGbko4Hx3DJTIfQD1Mks8tev4hEWDrzB1Ps63vW3Tt
 p/tWGG0PnHqWFFvqIk97ozfG6tmiU98h/LP0k5xClrpS8Ai1YcO88kIZJWURvJcX+NAJ21/vawO
 A2tEpmVMcw2jE3pZKRlzxFhbQZ7fI8vt5JSmB5JZfTS7j3hwReQLBldoCWeZLJO1JWxJdVayRmC
 iQoZLHauaIMY31434uyVIft5RKRQhck14tOOa9pj0q0L3O4fM8opjO86IOPnHMxq/Q8KgP9LY13
 23KLOhswb0wdWHOsEKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070087

T24gV2VkLCBNYXkgMDYsIDIwMjYsIENvbm9yIERvb2xleSB3cm90ZToNCj4gPiA+IEkgaGF2ZSB0
byB3b25kZXIgaWYgdGhpcyBpcyB0aGUgcmlnaHQgYXBwcm9hY2gsIGlmIGl0J3MgdGhlIHNhbWUg
ZGV2aWNlDQo+ID4gPiBqdXN0IHdpdGggYSBkaWZmZXJlbnQgbGFiZWwgYW5kIGFkdmVydGlzZWQg
cHVycG9zZS4NCj4gPg0KPiA+IENvdWxkIHlvdSBleHBhbmQgb24gdGhpcz8gQXJlIHlvdSBzdWdn
ZXN0aW5nIHRoZSBjb3BwZXItdHJhY2VAIGFuZA0KPiA+IGxlYWstZGV0ZWN0b3JAIG5vZGUgdHlw
ZXMgYXJlbid0IG5lZWRlZCwgb3Igc29tZXRoaW5nIGFib3V0IHRoZSBvdmVyYWxsDQo+ID4gYXBw
cm9hY2ggb2YgYWRkaW5nIEFEVDc2MDQgdG8gdGhlIGV4aXN0aW5nIGx0YzI5ODMgYmluZGluZz8g
SSB3YW50IHRvDQo+ID4gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgY29uY2Vybi4NCj4gDQo+
IFllYWgsIGlmIGl0IGlzIHRoZSBzYW1lIGRldmljZSwganVzdCB3aXRoIGRpZmZlcmVudCB1c2Vz
IGZvciB0aGUgc2FtZQ0KPiBwaW5zLCBJIHdhcyB3b25kZXJpbmcgd2hldGhlciB0aGUgY29ycmVj
dCBhcHByb2FjaCBpcyB0byByZXVzZSB0aGUNCj4gZXhpc3RpbmcgY2hpbGQgbm9kZXMsIHdpdGgg
c29tZSB3YXkgb2YgaW5kaWNhdGluZyB3aGF0IHRoZXkgYXJlDQo+IG1lYXN1cmluZyAoZS5nLiB1
c2UgdGhlIGNvbXBhdGlibGUgdG8gZGVjaWRlKS4gSSB0aGluayBKb25hdGhhbg0KPiBleHByZXNz
ZWQgYSBzaW1pbGFyIHNlbnRpbWVudC4NCg0KWWVzLCBhcyBJIHJlcGxpZWQgdG8gSm9uYXRoYW4s
IEkgdGhpbmsgdGhlIG9ubHkgYmlnZ2VyIGlzc3VlIHdvdWxkIGJlDQp0aGUgYWRpLGN1c3RvbS1y
dGQgYW5kIGFkaSxjdXN0b20tdGhlcm1pc3RvciBiZWluZyByZXF1aXJlZCBmb3Igc2Vuc29yIA0K
dHlwZSAxOCBhbmQgMjcgcmVzcGVjdGl2ZWx5LCBidXQgSSBhbSBoYXBweSB0byBnbyB3aGljaGV2
ZXIgd2F5IHlvdSBwcmVmZXIuDQoNCj4gPiA+IFBlZGFudHJ5IHBlcmhhcHMsIGJ1dCBpc24ndCB0
aGlzIGFuICJvaG1tZXRlciI/DQo+ID4NCj4gPiBGb3IgdGhlIG5hbWluZyBJIGZvbGxvd2VkIHRo
ZSBjb252ZW50aW9uIHVzZWQgaW4gdGhpcyBiaW5kaW5nOiBydGRALA0KPiA+IHRoZXJtb2NvdXBs
ZUAsIGRpb2RlQCBhcmUgbmFtZWQgYWZ0ZXIgd2hhdCB0aGV5IGFyZSwgbm90IHdoYXQNCj4gPiB0
aGV5IG1lYXN1cmUuIGNvcHBlci10cmFjZUAgbmFtZXMgdGhlIGNvbXBvbmVudCBiZWluZyBzZW5z
ZWQuDQo+IEpvbmF0aGFuDQo+IA0KPiBBbiAib2htbWV0ZXIiIGlzIHdoYXQgaXQgaXMsIG5vdCB3
aGF0IGl0IG1lYXN1cmVzLiBXaGF0IGl0IG1lYXN1cmVzDQo+IHdvdWxkIGJlICJvaG1zIi4NCg0K
WW91J3JlIHJpZ2h0LCBteSBtaXN0YWtlLiBJIHVzZWQgdGhlIHNlbnNvciB0eXBlIG5hbWVzIGlu
IHRoZSBkYXRhc2hlZXQuIEJ1dCBpZg0Kd2UgZW5kIHVwIHJldXNpbmcgcnRkQCBhbmQgdGhlcm1p
c3RvckAsIHRoZSBuYW1pbmcgcXVlc3Rpb24gcmVzb2x2ZXMgDQppdHNlbGYgYW55d2F5Lg0KDQo+
ID4gPiBBcmUgdGhlc2UgZXZlciBsaW5rZWQgaW4gYSBkaWZmZXJlbnQgd2F5Pw0KPiA+ID4gRGl0
dG8gaGVyZSBhbmQgaW4gdGhlIHJ0ZCBub2RlLiBBcmUgdGhlc2UgZml4ZWQgbGlua2FnZXMgb3Ig
YWN0dWFsbHkNCj4gPiA+IGR5bmFtaWM/DQo+IA0KPiBQbGVhc2UgZG9uJ3QgdHJpbSB0aGlzIGFn
Z3Jlc3NpdmVseSwgeW91J3ZlIHJlbW92ZWQgdGhlIGNvbnRleHQgZm9yIHdoYXQNCj4gdGhpcyBp
cyBhYm91dCwgYW5kIGl0IHdhcyAyIHdlZWtzIGFnbyBzbyB0aGVyZSdzIG5vIHdheSBJIHJlbWVt
YmVyIHdoYXQNCj4gaXQgd2FzLg0KDQpJJ20gc29ycnksIEknbGwga2VlcCBtb3JlIGNvbnRleHQg
aW4gZnV0dXJlIHJlcGxpZXMuDQoNCj4gPiBUaGUgbGlua2FnZSBpcyBib2FyZC1kZXBlbmRlbnQu
IEFueSByc2Vuc2Ugb24gY2hhbm5lbHMgMi0yMCBjYW4gYmUNCj4gPiBwYWlyZWQgd2l0aCBhbnkg
c2Vuc29yIGNoYW5uZWwgaW4gdGhhdCByYW5nZS4gVGhlIGV4YW1wbGUgdXNlcyB0d28NCj4gPiBz
ZXBhcmF0ZSBzZW5zZSByZXNpc3RvcnMgYmVjYXVzZSB0aGUgY29wcGVyIHRyYWNlIGFuZCBsZWFr
IGRldGVjdG9yDQo+ID4gY2hhbm5lbHMgbmVlZCBkaWZmZXJlbnQgdmFsdWVzICgxMDDOqSB2cyAx
MGvOqSwgdGhlc2UgYXJlIHRoZSByZWNvbW1lbmRlZA0KPiA+IHZhbHVlcyBpbiB0aGUgZGF0YXNo
ZWV0KS4NCj4gDQo+IFRoaXMgcXVlc3Rpb24gb2YgbWluZSBpcyBmYWlybHkgbW9vdCBhbnl3YXks
IGdpdmVuIHRoZSBleGlzdGluZyBjaGlsZA0KPiBub2RlcyBhbGwgaGF2ZSBoYXZlIGl0LCBlc3Bl
Y2lhbGx5IGlmIHRoZXJlIGVuZHMgdXAgYmVpbmcgcmV1c2Ugb2YgdGhlbSwNCj4gc28geW91IGNh
biBpZ25vcmUgdGhpcyBjb21tZW50Lg0KDQpOb3RlZCwgdGhhbmsgeW91Lg0KDQpUaGFua3MsDQpM
aXZpdQ0K
