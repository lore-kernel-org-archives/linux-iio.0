Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792801120;
	b=SAWLncQPjMe+BI1ghlFwFcpnyfFhnFaDbNdm6bNOih6qVIUlzVMCdCUrwUKuan6Lhjm/
	 IOB9behugI8rbsOUHapk8Il25vS4+C8Zkj7oc1r3je7rYTfjR6pIJa6jT/R4xEEZyCJXd
	 38xndtNvkLhg+CPJ9LVU4qjTSjOeCMSCfGdrw1jS/BWFiIX1U1OxEx6vYcvAHl+G8YMUc
	 FhZRgHRwLI00Qdv6Z/G3qV1wktJUmLyjQElXH6cnpG75UJie93iEbdF6vqprGrcBjrviD
	 d7GZ9P8CU30XmHs0p8hiDtFuh6IVJlumBE20XUtIBMvH6K6WmO6fI3seFEep6AEDqFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801120;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-exchange-messagesentrepresentingtype:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3iAW3voHwPi1obHmDxhuaMvWGtZBl5HN/XAxwBv2YHM=;
	b=SfN9w7CHGvaRV/+W5wlJlJdZJnObwpN2ucQgiGFHSjr2UabC+ww0pxZ9lLCkuSb/OBFS
	 1xrrmJRuRRmG/H3WKhW6ZT+l6G8aMr2aQ5UKaNvcc+8KW2rEEr0B3qZFavk/wpTWGFkvz
	 XH82tdUqduu9PoYQuV3N6n7MGfAKIUqKmn3JoZwFROISiSt8Gv4OzddiODCIwVL9dxetG
	 ZFMzLDOFYcHmgLnqvwHRUGlTY4wpdm6BdbgSHNlx6WXxbIOVv3dzIq+4Ga/EsWniWizcc
	 vdB61PbTApHSJmTMg2j1KAzjQ8ABiiomzwEnNFRwqRCl6PqcOOr2oiYA99ugXuUQ5ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=syKyuBGL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.4
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010004.outbound.protection.outlook.com [52.103.12.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94507606A31A;
	Sat, 24 Oct 2026 00:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94507606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=syKyuBGL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTu/CbbFckI7NQj/6qAEn/YH4kOoKbUS1orPnGHpvtwi7GnSluPWfMevv2yWoGkEqgHBadX7ISuajjTDSBrslfmplBDBysouzfQUjdSIyWqljbUTOGO1+vgxKaItbbEp1b69/e87xsbA3v0K7aqHxEpH0sKZ9IlqopxI39jJKJiI984Lsnsuu4HjNzas9uQQgJ9YhH6SbMGE6LlGVu0gqCk4qoVMvL8Z5C6hkWxrqcMItjiT/lbQY/zOC+QqLHlfaaDesYtqIvQ+JuAy7MySkRowB0y9Eks8Jk0ykU9NcNKp4wsIRyH9sgOZPIeiI3MdoTPfCakUXEIqg6EEsrG9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iAW3voHwPi1obHmDxhuaMvWGtZBl5HN/XAxwBv2YHM=;
 b=BLWtUXx7F3csC0JLb5ZRYEYGBLPGtKS/EuLOevaELy5IbVa/APLN2rnmFh3bKsG2xwdhgPVBGgrWRFNFbubqW6BDUMbUhPLbouMpaA390mA3qDNVbAbE0K+CJaKe33E1fxjO9okDrRP7QQyI+h2QymP1bW6tj6HSryJepOMHygr8qxCMKLbZohcaFrCr78tKLQ0ghws0sU58Wz6wyZImY6sA8KbH71JjmGv+i9VcfETBEHs21FXt/FqOuUC5GUyIifR1ph3dYWjc9z8trC/1lcM0/vMFhDutIsJKGWShFj3dpXm2vqFoJBh9cfnrM8HLeEI8J09pjvnzx9sj2jFZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iAW3voHwPi1obHmDxhuaMvWGtZBl5HN/XAxwBv2YHM=;
 b=syKyuBGL5WzoNAy7T0BE2dMG2+nqGrTbGuvQ93/znDcIOvy2Bi5pEe79PqdzEOK3SrmzZq3Z3B1qHp2Msd7hSXtupyb02WVBKrh5KpVDuK3u26tQgJV5k3xHlUjO1omcwyAkuYLRladhkuWM5S7F91TLJwY8BeKcPPMcsxH2ndPprxnUeqoklyltbq/kBbfCNMAGWYFHIY9CMPANPoaDp49I3DWtIAYQoEeC6bE6IUblWxSzCozVJ7Ep0P1nAd9HnCfgvjpSHRwQ2aNu/vrw7vxtrb0sR8Q4lBMd+bQzGh1dNriiq9LF/RRHETDYAg91Ilcdty84PtsniLXLiQmpCw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 24 Oct
 2026 00:18:36 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Sat, 24 Oct 2026
 00:18:36 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Thread-Topic: [PATCH 2/3] dt-bindings: iio: cdc: add Texas Instruments FDC1004
Thread-Index: AQHdYn7dKJYSV9BhJUyAjoHZWWMCL7cKctWAgAFicII=
Date: Sat, 24 Oct 2026 00:18:36 +0000
Message-ID:
 <SN1PR12MB252890BA36E5A172F73CC4F5A5632@SN1PR12MB2528.namprd12.prod.outlook.com>
References:
 <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB25283751BF4A06FF790BC114A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <20261023040927.1f142eea@jic23-hlaptop>
In-Reply-To: <20261023040927.1f142eea@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2528:EE_|LV8PR12MB9231:EE_
x-ms-office365-filtering-correlation-id: deb5f451-7ade-41bf-ea89-08df316458b4
x-ms-exchange-slblob-mailprops:
 ZotS1sRCahcBEZ0FCgjzK+/qGozmRSbAxbyB4dUZkf0Fg+uqG/Pa/rxMamgsFiP9clTqVzI3zHrfZI5TqfcwJFWnjpqEbkCh1V7udPq1MrGwdnNPB/WkPEqgO83pkGOZK2qUk44CIaTonDCDROEgXqg/eR8iusdK/a+axhRuNdmbipDs0Mh+KouWTUApDDR1J4Agb7+ZHKGE0L+4qE1ToG26GPvE+awHGG3DpErLDSpKjtBZ9mmTuX7NCtYXVqDW8VNf2bHM+KUVQeOf7hPBMhjdjPJ2+Qk7dk4aURhbzGqBWTrhAwJPGZVKirjwZMeydX08zi9WdyHdawb9uGx1/LGanXUz9JNfVPzqHsF6PnDj6fheJ04tvhPErMZps9qzQ64R9Dvknp03xDuOWvoVhwSU6l9gcoFBxjfx7i3IoOHhT893FUn3vlV09nbbW6y+NRvZ5057v3yOZb6ksiG6gsaHPbd8ixuTyUrPLmf071+VpX1PgGRDAJIU+bMxaIaxpphp3bEsQ4w41WbUXWE6ELMAagRhxKNWPAeju1OJgjwZ3AfIW3DMyCF4AcoPbIi+Fwao0tpk3XWyfRudf/flaQ7lut6yK5cuCMa3sKAGIVddI8uTYV1E4z2u3ImBVNbky8lRgKo7Uj4nz71bkkYwyVj6uAH3vZKa
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|24021099003|31061999003|8060799015|25010399006|15030799006|15080799012|24121999003|51005399006|22091999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qFnxipCI0UIetDEefq4P1FsCfaVA0MHTCLlSxGpUxTfRyHC87aFMuk26dc?=
 =?iso-8859-1?Q?QqcQ8xwoEz3W8tbhiR1/10BLh7sm8bv7HgLRdyxxKxUrLzqrnfmBWqYi5S?=
 =?iso-8859-1?Q?TnKAcCtYrXUGrhJiqw5In7ypNFOnCMb26RfXeUE/XSPzJlW7un42VexcWA?=
 =?iso-8859-1?Q?BO3jJB1OZoi1CA5P3p0CYIcQ2KgsTmiwZAAbz955Ncfp7SJhioJkAztOl6?=
 =?iso-8859-1?Q?FTFvbVepbIfHHy8wik2X8SMtWYeVZn3wBj15KHQNQOQv3E+ZOZo2xPkseI?=
 =?iso-8859-1?Q?uh18kRILtsyPFewv9VqqEgFc6VLcuMsxGcfffUV6MV4YO19NpanMq32tqr?=
 =?iso-8859-1?Q?hvnZ6OTbk3mhNpBrELDqMkV+vrykvSD8V59vVE49qNW/SrxGxomlmbphjA?=
 =?iso-8859-1?Q?L/0xG5y+/yZe+pPUWL256amSfDmNoHlDspEzhIvK08NQc5j7LZ4KrArJr3?=
 =?iso-8859-1?Q?wku9zJt/+9dzFxbBMEKEdXpk45zWreQo75ORLRAgImWNya7PPWTUCIgEQ9?=
 =?iso-8859-1?Q?AjYmw33p0v7a0/WBonh/ids3PEpfC65LpOrji1JkxVOp6vVoJjxBGPdhgz?=
 =?iso-8859-1?Q?cTY94TtkO7dv+UKpwCtAai1+6VOqWE8b4twGpaHnoJmyHZUw4/q2zr8Ah1?=
 =?iso-8859-1?Q?pwYkoDYtWshE6Vi5SXpH1FBSGb3LaFtOY9OrVjJVfqEtcrozF3QUz1u4Ia?=
 =?iso-8859-1?Q?meB1w0q5bHj2lhxuCrYrGuVNEmUmYD2lTlJuQ+e1u3HZMjQeiJHKXTCV8f?=
 =?iso-8859-1?Q?bqfdNFpCRhZW6IHvDplmyeeO3rF89rdRJMaUkMP3kHJ/lixG2kLWTnTS73?=
 =?iso-8859-1?Q?i6UJatFNhgmNlz427WdlVbhyw4T3nnBAZFkDOJC/6SGHtkDx0vuDGtaupE?=
 =?iso-8859-1?Q?z2vZVRr0bDoQwyb/1+m0EtEmJiQw8Hx0T7NpPB4jAD8HikC6jBro6igDEj?=
 =?iso-8859-1?Q?/y9Xk/NP0vAFZ7NedcZ/U62Td9M0Hgf/6qiKxiJwqGvqSRjLUql2tVks7y?=
 =?iso-8859-1?Q?K2z0FUzXtDKbV9RPB/0WJ7ysYd5CwgWr0hsRUzTtC/54PuVIFbQEzjdqqS?=
 =?iso-8859-1?Q?NhInNH9bzhui1eC0EI7SFZM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qy7pc7biEL0S+5CNY3HvNAWM/f2qcy9ApZAYdJnTcsljp2+Akt1KNeIhxu?=
 =?iso-8859-1?Q?giG+MmU9fi6vmlmrqrzs8Z8epVIljJTQZywQMkzeg/Ls3Ba5AQw2ErpQD/?=
 =?iso-8859-1?Q?AZMA8U3d7z5l0yWS7CfIr4fdd3oKVZTYRaNQCkcXAqlamVqZ0kE8cit9vw?=
 =?iso-8859-1?Q?laT3SJ0FB95VMxAsLckSpS7cdGUikodJv93mi0TyziKMaaOmZvv1SHfcgE?=
 =?iso-8859-1?Q?J1CQOkY3xMZy1h7F4+xxtpLRBu/koTLOBWZU/tSxcp200Z1p6nycTiMbUF?=
 =?iso-8859-1?Q?4Dd3G24MoIH+T5BzLr5sXgtLs0lP4oKPPoCesxHlxUmcX3dHSlUVPDldyH?=
 =?iso-8859-1?Q?B7iWbilIaSc/CdGYCMraIPOHVoHMnYPzCfGVIJr7FylHfWm/lv6DDMusFq?=
 =?iso-8859-1?Q?x/Y69/fCi61BkACnWlAIW6AGBA1rR016mh+0IhFKn0SSCzznWGLhW/oLim?=
 =?iso-8859-1?Q?lPSmInQSlVq58Kpmx9RyWUHts5i8/udrlJr9qUvbFsHQHz7KNYJFCYTEY1?=
 =?iso-8859-1?Q?y/LcuRX9wFmZH3Ka0/EhxTM8kiEWKYlKpK61qczPRMg5UcU8aljpdROv33?=
 =?iso-8859-1?Q?dADS+sS9WE5dFwdy6Ger7apLC7ma6148TWyv2GKGCApuzHwLGEXl5nlVyG?=
 =?iso-8859-1?Q?omRrRe3uKve2LDeDmekmqONQWqNucIQ4BmnoKh1m421XgIyKucyxst5AzN?=
 =?iso-8859-1?Q?Mutgm7Ej5mC6f95D2OrN1hCgNsocBWggoLyVrxk+XO3Fl4k1qc+ctt9R5O?=
 =?iso-8859-1?Q?AwLFK2j9t7PRsVayzlwY2f0KMV5u/z5LCqQeGxp0zS8ZHMgcOl226bZjBU?=
 =?iso-8859-1?Q?xaiBZhBc/mVMPd0M+Wj88qmh//1g7M7U1k9q2Fq9xZrxkM1tv0AzMWbp+I?=
 =?iso-8859-1?Q?mWET1cAVA6jXSOZg6pCdyEd7+gqicEQpxi2LF6n2uznZBNmczOw21qYC5w?=
 =?iso-8859-1?Q?kiBebTJ0dCNceEOgYu6yireJPDE7aTIppoAPbZA5cCslDmsLBrakyMzcPd?=
 =?iso-8859-1?Q?UWj+TjQ514LTpcBtDYC2+QKR1vLwn6neFg9bw9U3BbR34ELvM1NJe0J4Yf?=
 =?iso-8859-1?Q?GAFJbHTZ7b0TROITYyBVS2ivqc/n0MtQGah1EsWkEyvkMXVqPiPO2D171G?=
 =?iso-8859-1?Q?iu1CEqFEI1w62y5NifFgYoRq7AgOcQIkPXLCQe4A6SiZp6biX0k/rsfuyb?=
 =?iso-8859-1?Q?96DLY0DtPWJuM/CcInC/0HwpA8Fs85acmh2/MIeXAmQ0faXfea/BFhGLZL?=
 =?iso-8859-1?Q?KdapOHLLddL5BVcLsGDmvsJbEyGcDejQWcFexCiI075qukchh5QbkbuT39?=
 =?iso-8859-1?Q?kXbwjuT450mu86T1Cv98UJrNoZpfsvG6QXEzqf+1aF0G83ppihcBwvQK15?=
 =?iso-8859-1?Q?nI6kjIwoWzUPZpFzbLFuomvb9crCsbeDi7H7/yL2ftyRToxqomXIi0QTjy?=
 =?iso-8859-1?Q?Mbvc+Y7w3W9L/hEnslH8zzm86YA67Bam9EXGPQ=3D=3D?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: deb5f451-7ade-41bf-ea89-08df316458b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2026 00:18:36.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

> Require the power supply.  The binding reflects that the sensor needs=0A=
> power to operate.=0A=
=0A=
Fixed in v2.=0A=
=0A=
> As I mention in the driver review, I think this sort of sensor is pretty=
=0A=
> much always wired up to specific external sensing elements. As such you=
=0A=
> may want to provide channel sub nodes in here to make it discoverable=0A=
> which channels are actually useful.=0A=
=0A=
Replied under that patch.=
