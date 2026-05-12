Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB02F12DA;
	Tue, 12 May 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585174; cv=fail; b=eh77246zMmKkAB6hMcWsU7al+u0knuGMIIVd+chZhlgQ0osp7ruvpagp+nqzY2/BIV6cjxFCK+rXYrRL8Y5sW8GIvROkHsBYRwK63Yguo8VJO9KBnVvGiiBoreZegEUedmFqhejjgg96tDEntlqJcd+qK4outDH3BMFTsbgF8r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585174; c=relaxed/simple;
	bh=UArutIflGKgCTCaNTmlb4gIqy3Rh8Nl8B+j/6fz5PYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tvhueWdh+rMr0JFWRcLFQ/Qj63cMupnQ23ZsyqfabaRNK4wL0fxyWFbm710shSWonrv4gkUDmqCwzeeto1YU8/lzS/sonWPMAzgeI0AQLqjmxIOqCGA5QVlqBppzcghHVeoYZeyEX/ueir2ZnBZaMlsMbmP5gvhIOZCJy4GrxL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bZetpnVK; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bZetpnVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1xZ9dbRvG26ekoYOYpJpq4SIvJ2BMCvGCvOLJ9J7o74JdHjhwhV8Pq/BxJCobJe/muoG8Hh1MnD/9imIUFuCaKHlIEwN9d24y+NgWnsZ5EmFkipTx4axaX01zhwxgkyYKIiYw9ibn7j+ixH+ovCorMPb41cqZ0MPmeR6aS9pra1c5m1u85OF8eYIx0rfP7JM6jUrAW99jw6+KayHiaTXPMcFT+xAZL7dytFFB9cayRbZg+5G8phDLFTeNkUA3ss0X2HpC+NGQmqtoU1twNyK2jBau/45MH+CHMhQzOqN7EScu9YxhyZrjw6fZg9V+m67exsMmfX5TRGB+kLuWy6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UArutIflGKgCTCaNTmlb4gIqy3Rh8Nl8B+j/6fz5PYs=;
 b=oJpLf8Uhsd7lU2ycr6XspKUQQz98/iNe31J9Vta1EZa626eBuzAC8ham6j793gagUFAvDyG00NTAGcN87HXoMEqoOKqzSOZkqwHn1UbE0HHSEqcVLfVp3Iiu20yLY0ahFj2ScrggtsHvhodRm9JrIgJjAMEmdfcFvALUSb4246ktg2dvPGROTSS3R3qf9/fWs0MXVkRBuj/BfybJr0CGyl5j4kNd8ZclgxyVBIhyJzRMbJMUgTbaMbFLJN2KVyklXYjj8TZekEGR4W05rW5A0hnHOt0er3uhuXVEVXLtrqkogHB3nHoyS/sQD1qrWPllcFTeis2O9kzEyR754JG0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UArutIflGKgCTCaNTmlb4gIqy3Rh8Nl8B+j/6fz5PYs=;
 b=bZetpnVKVOCp3WWTTLGY3cWoG5j3VfXTXMPh15TQMfJMX1bNJm4ShnKidvsM99+8Wt5L3QyztIe11OZRD2oyiYRV/5KCrZJJ6GpfSk31RO/3ztEEcFiAG8C43lnTrlsGqFFh0wJEoDqCMsS5pIaol5pEuxeJ2FREKU6PZSNmNIo=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 11:26:10 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 11:26:10 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, Jonathan Cameron
	<jic23@kernel.org>
CC: "O'Griofa, Conall" <conall.ogriofa@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
Thread-Topic: [PATCH v3 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
Thread-Index: AQHczGAQ5HoWrLVb40ivgNF1Nkobj7Xv+VqAgBpq2QCAAAIPkA==
Date: Tue, 12 May 2026 11:26:10 +0000
Message-ID:
 <IA1PR12MB7736B569A2F230F80D8E08839F392@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
 <20260425163449.547b7ed9@jic23-huawei>
 <CAJgF-xv2SpaOu+6K6k3CzFVNfWTx8LyeGJMZjLheCSETOR3Yzg@mail.gmail.com>
In-Reply-To:
 <CAJgF-xv2SpaOu+6K6k3CzFVNfWTx8LyeGJMZjLheCSETOR3Yzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_ActionId=76b16c4f-c962-4947-bb5e-f9f99b4a6bf6;MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_ContentBits=0;MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Enabled=true;MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Method=Privileged;MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Name=Non-Business
 v26;MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_SetDate=2026-05-12T11:07:35Z;MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|LV5PR12MB9754:EE_
x-ms-office365-filtering-correlation-id: 71aec5d5-7c46-4897-19e5-08deb0194480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|38070700021|11063799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 2qEwH5v/n/51KO8JjZ3aToSqmxqp9tSmXn7obvfSUwbyGzc8+p2OLS0TMN7q0QbtnUxBGKP+W0FBi+TCEZa8+niqyegP2FzrkTcSRJsMRLwGwLDYS+1ZI45hC/PHEDonHxkAcocpFrK29a04WuziVa9kzVB6VW7zD1YYLDHD/vtn0AFw9qMozckxJDvSD5KXuN8YsR8rcoGEh7vTfyzcYCtRdXQhXukKepuSKbwRfSPaaAdxUz+hYBHMc8ltCpNE6l9xNbp0uAYzPf8rIqP/0AZaebofoqAhx+AeqD8gvzS3+N1YRhbEno65LuA8KLRle6/WnyNMD5Y5HWCukDzWacLmJliliFVjMLBX6WTyjbNHbFpskqM6HVDodSczeZxo/XTEj6lalgdrM0EYQWQ+7S+xVxhkS1DNb26ASAwv/nh8qDiJxaC1jdGd1pUVUE8+7o8pgTaFGnQVHRR+sbjHlTiizu4tnGEQhkXdCP7LTeKKfVRLMY+9nPGLNlnggLjkkAJbcuqSmysBPoDSl0Htulnw39fMmWbGa7Qi9Rse7PTnZyLcLskxQDfs8e4UX4gfiaSa7v0UFfvmkfWdy8mXzOq3Qr6NILNzyBaOKRk+dfg+98bOtux3n74S+Wr6Me2LHS8X4EiugAQWCQaFBg8az67dIW+AewGBcErCyuDbErx0Y9s0NroA7kGcKvTuV0MdLnCW0xt4oVXF0EfxTrGWJXuFp4FyTK5mauxlGlAhr5QfJWUSs/AgUGeTytJrOZwy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(38070700021)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enpuaU1iNzFYRjRlRmlLbGpRMlkzbWVRY0Iwc2taaGF6S0MycWpCK1g2am9x?=
 =?utf-8?B?ZksyL2w2VU5xWmhBdVJ5dEVvQ2FEUEt3TWovTzZOSDUxd0tuaUN4a0VRb2Vk?=
 =?utf-8?B?Z2ZOUjh3b29lM2N2SDVmZnh2RkVUSElSK2xsY2pTNHpqcUtJam5EZUxxUkdK?=
 =?utf-8?B?VjNVeDVnTnZTbmg2dDRkcXZCQ09zU2NzenliNmRyekNMQkxWQzM5Zkh5KzdO?=
 =?utf-8?B?V1BnemJVUTA2RENieHhzWnlSaEsyT2pYZk96UDQ3eXJNRUl6ckhRZjhYbXFF?=
 =?utf-8?B?ZnV3ZGcwTXR0SzVqKzdncUZZL3QyMUZzbGJSemhCTGZDNDJpMTRHbkRDTUUv?=
 =?utf-8?B?VDZGVThXcGlrZjdpeElLVEFXaUZVUUlBZEVybEdnbUpzaDVYZ0NoTmJWNTRZ?=
 =?utf-8?B?T0FjUTdyTC9ST1FoZndodUIrR0ljM2Z2MFB2QWRwZDJQZUFFSlY3Z0xyNzBm?=
 =?utf-8?B?UlBIQVAySmxYNHBIMFlrYzdVS2svdHoyeEY5K29kRnNSSnpMSE1JWjE5TmZV?=
 =?utf-8?B?VE96UEtIRXhKZHFLcWpBUW44S1Iwa2RNMDU0SENzSXAzQnZVcUREdEJNdDM0?=
 =?utf-8?B?NWtjN1lVdzR2NE82MWpMeERTSmd0cnNybi9mOWwrdnBId1NiY29XN1N1eG0w?=
 =?utf-8?B?eEJTWTZHM0ZScjlzTTQySHM3RU81WDFHczBXUmtiQURBblBMT0dQWld5czha?=
 =?utf-8?B?WWx1OW9FeUhjOExtalpQNXZTNE1CdS93S2xLNjBxWTgrWW1nQ1ZaaVFZQkRQ?=
 =?utf-8?B?WEVEUi9saTFtOWhsZks5eW0wbGRPVmlFcXJEbWR1aUtFRFJSRnlCYzZOdEpV?=
 =?utf-8?B?cncyRFkvSzJLNWZ6dE94MmVoZVhRMEFZc0dlNEQwWnNrZ2JOYUgyTTh2dUMz?=
 =?utf-8?B?dlN0R0U0MWpmWDlEeEVJVEdvT0dQaThIbXpZS0wzaFBWN05nU041V3hTZVpY?=
 =?utf-8?B?bEZBY3BHM24wWFg4eG1lbFZ3anhKVUZFM3d6ZW81eXhUTVAwV04xUXRhRFMr?=
 =?utf-8?B?bjJUR2lMaCtRRHJwYTBXZ3JDdkR4ZnhyNUkzZmRWamQ0cTAyb2pPQkphd0Iv?=
 =?utf-8?B?eFo1dXVSSDhwb1dKM040TTcwRXJRYStnclkrWTk5SDF3UkkyendITXhnekVC?=
 =?utf-8?B?VmtjSDVCS1ZiNTNyNlVDbU82SzFTeG04TWdvOWJnSGpKcFdmbVExbjdXOXlJ?=
 =?utf-8?B?SkxHV3BzanZDZEY0YnZUUVF3a0Z4eVlTMU0zRE12LzhpSHZQbVlWbGZTMDYv?=
 =?utf-8?B?Sy9Fdk9hN3FHTGFoayt2Y1F1ckhFamlHcE95ZHZUL0g5YVUrOUt1UFlXajNU?=
 =?utf-8?B?OGRsYUJhR2hETUt0V2tTZ3FZdXkzcWJIQUJjc0ZMR3ZTaVNQYnIrRGZnVmxa?=
 =?utf-8?B?ckMvbEJ1RWIreTVnM09pRytmcU9ZK3k0S08zRWVCaE40ZjlnU25TYmQ3b0tY?=
 =?utf-8?B?enFPMCs0cWlCNHV1OHkzdGFEbUlId3FXcnhjYXk1ZHZmTE9CVTVHWjRNNHhx?=
 =?utf-8?B?dEVEak0rYkFvdEtNYkliVFJ0ZXZnd3QwNkF6MlpEUmhGemxtL1lJTk1JRzJ5?=
 =?utf-8?B?QU43RzZYemRvK1FoY1RWNGszazdBWko4L2sxcGJaekE4ZWxxd0RKRVpNZE0v?=
 =?utf-8?B?VnRyR0YvRmVOSnl5TlVrdnd1SVllMzVnaktRd2diMnB5Rmp4cVgycGc1cnJx?=
 =?utf-8?B?K2svYjc3ZUdQYzFMUUlUMFFEemZ1eVUzZSsrM3FQMXp6aS81UmdDRGVUcVQw?=
 =?utf-8?B?UnV0dHg1SnJTMU9sNWFGUVZzSFpjeWtyZFMrL2t5cTh6bmdPMVBmSkJUaysv?=
 =?utf-8?B?QjlRYjZaa3lla0p6cEhNem5iaEdGU0hMRmRHeWtFY0ExU29oT2hiTTRnb0h1?=
 =?utf-8?B?MjZHd2kzallqVnI1V1pHRW9OeHE5RFlvWHZHN2VvWjdnSkcxbGVEcGpydVJI?=
 =?utf-8?B?NVBvS1ZNK0ZaWkZ5SDZzeEhsanRaa2crVGZHSW5VUjMrdXQvMm93VUszVWVn?=
 =?utf-8?B?NytvWWUzN1ZTS3hhMjNsTzVocW43UWtZK0x0akRpeGNWZkVld3NvVUJpeVlk?=
 =?utf-8?B?ckZqNXlTTWxxemRHVC9zVHh4ZkVnMFpRczdoV3BpT0FMT01Ib1dTdmpDM3Ni?=
 =?utf-8?B?MCtETERhelhaNVpDcVVnQWlsUi9HWnBkUlFIZEZ4OUJjMXc3bmVlTDhGUFY5?=
 =?utf-8?B?Q2tWV1QwSDU2YUtoS1R5MG5VNFprQmVMUDh6Yk5SVU5Lb0NtK3RQQjRERFA4?=
 =?utf-8?B?OVlrbXJHamRtR0hvdGpLNEFrUTdDUU5hUVF2ZkI4VTlZaFAzd2ZVL3c0YXJq?=
 =?utf-8?Q?pGxvkXO0//hU9TjEmJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aec5d5-7c46-4897-19e5-08deb0194480
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 11:26:10.2520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixYw6509VQ5ncyljWNPFkxpuoN0GbMUdCNi1XkMOkNXHzYgmYfB52JpSour/kEVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754

SGkgR3VpbGhlcm1lLA0KDQo+IA0KPiA+IFRoaXMgc2VyaWVzIGxvb2tzIGZpbmUgdG8gbWUuDQo+
ID4NCj4gPiBHaXZlbiB0aGUgQU1EIFhpbGlueCBmb2xrIGFyZSBmYWlybHkgYWN0aXZlIHJldmll
d2VycyBJJ20ganVzdCB3YWl0aW5nDQo+ID4gb24gdGhlbSB0YWtpbmcgYSBsb29rLg0KPiBIaSwg
anVzdCBjaGVja2luZyBpbiBvbiB0aGlzIHNlcmllcyBzaW5jZSBpdOKAmXMgYmVlbiBzb21lIHRp
bWUuDQo+IEFueSB1cGRhdGVzIGZyb20gQU1EIFhpbGlueCByZXZpZXcgb3IgYW55dGhpbmcgZWxz
ZSBuZWVkZWQgZnJvbSBteSBzaWRlPw0KDQpObywgbm90IG5lZWRlZCwgSSBhbSByZXZpZXdpbmcg
YW5kIHdpbGwgdGVzdCBpdC4NCg0KPiANCj4gLS0NCj4gVGhhbmtzLA0KPiBHdWlsaGVybWUgSXZv
DQoNClNhbGloLg0K
