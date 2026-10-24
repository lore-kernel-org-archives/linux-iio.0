Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792800387;
	b=f1UEuj99zhEj0rVO3CSJp9xPrTopiGHudjmUrR+qEoTZNNnCjAOBeOrRJ+Mt9pCU6EVl
	 5jkvxM83gPCKCTTfi2n6EtWXuSLQVD84m/vBeO5qQh6aUxtmFSPnBtAJ/n9hQmv1Fn8e/
	 rk3U3yoJo9jF/bJzGjIShs0PV/teEANHkJxhqgzMRvQpAUhV4cNmtyhgjW1JEUih8o+0d
	 hx98onU+RJq8UWfAEOaOm+1g03glasiFk9gx7otpHalkV530nHx64VlCHUz0aol/SIeEl
	 K5Gxh+YcG67Xa0paMHLSSSJq0zB43Yz2ACRmYgnuU6u4JsYLjv8g3In90Q1oJv5KbDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800387;
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
	bh=pJLkM20fqxOHCRD7r1vSc9uENrBKh1P6QWiuy1xlBSQ=;
	b=Ie3NaGd6yAEr9tyB+bfKK8p6876dq/2EytgDyfiG+V6Uea1vMZ4F3t+N8qu+OHzdBP2e
	 FVuHILjeTMGnjvEJsFSubePDhzyDVsFTKMnRxsO/yWYEiNkdI7je03BVLDp/0T4kLkpZs
	 48Dibsss/PhR1c0zgM0Fdj8ms5V2u9A/gMeSSB68x7IHlyiQPrl2Y3CYUZTSqdjwv/Zz8
	 X702QKNhnzunr8ix7GU7jLQop6N2FGlXWL6klt8uNLo/XPRrgMKZW+rOLW6gmfvnX+awW
	 sYzL4nZIq6Ny6+RurRwD1r5AwgLAcl+VvqkUFBzpZPu1HJ/sxPr0mCG1LAVq0qPmWGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=bLOrKM6A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.1
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010001.outbound.protection.outlook.com [52.103.13.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD50606A31A;
	Sat, 24 Oct 2026 00:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD50606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=bLOrKM6A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgK/stLKcX5KBhMwv8+xnnvZU51wJrcDWKYT36Sjrwat15iMThw4Bqx/ci06Z7a8ukBscqbRLpPPQCI1v2NYoV3zizuwvYsmx5pWkjVA3lPKotmzCx5rw2rHpeWKxlGcOsKm4wsn9S2N9PGMEzqhAivEwmN+CUcOSCYrvZ0gYnoyl5uXC9TD31FzxrR+0rCdgOH840/OyvYclCpkWkVliWpVtlRR2GLjfHlJR8QNUJJc7dzrr4KqWM8hs7SW//jL3Oq5ifLuQO4KwxNFY9jTSTUb/lGyR0319fXZzfio8Y02QnmnV+f0F7GeUwE5lWClE1AQ+dzKs+z//CytIUC7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJLkM20fqxOHCRD7r1vSc9uENrBKh1P6QWiuy1xlBSQ=;
 b=rwZySJhpDTvFOoxLspBGJBsLkEUpWOS7BHk75CGXKMLKmYPo7BOdKFEfuc0MziZAfYucGQ5T069HNXJkSSqkbOCWsD3ZSY4XUX/2PgN8pW+3TyqAQ9uRyQr9eSAxHS6o4EdRwnUo+BLb/5RxshQYe6eV2mNBtbFvYzlHvJ3GAEZHOV3GonWut21PkT8cr8CHiuDujfNP39E3lyhiBn5rErJT8bGmwd/eLClIpHGTICAChob6rATXglcaYdM3wOv2EHXgPp9neE7th4noqv7EbeHuiPKMSH1L2vClgpZ/FSPufQLak/sRE2gN70zkoetXAZ5vMluRUHpOx89meOKPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJLkM20fqxOHCRD7r1vSc9uENrBKh1P6QWiuy1xlBSQ=;
 b=bLOrKM6A72gBycrb8uOQBkd8cxgfEn/x6HNvksp9m2aQhS207F0moc5bNwPXpWbRTAXttCznWYnUWkM9yUPZECTwjrhiwb0UJvYoEAn7rxS7IAhsp5Ntqr7dRRpxSkoNpoG/39Bdmmun1/ucBWNchRfaVzy+no/t1TDLTKTnCtG6jnIdAPsg5JpHPsOP9Zwo28c8eul4/U26G1xLtuu9Iq1yclVfu1j8Emw4vcwlrHzA6+zIQh3JRDoPSTEbgj8LSpCGA7RnZLNq3zrojBqdcJYMWNjwozqXUHhQfjoJXdbbc300oSe6XA5m0JcL2Dr4ghZlULPsSCq0EBkp+KHI6Q==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Sat, 24 Oct
 2026 00:05:26 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.012; Sat, 24 Oct 2026
 00:05:26 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Thread-Topic: [PATCH 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Thread-Index: AQHdYn7WUhVUIOKG9ky+b5jJGaFnRLcKtdOAgAESvYs=
Date: Sat, 24 Oct 2026 00:05:26 +0000
Message-ID:
 <SN1PR12MB252895FEB136DA236B70EA93A5642@SN1PR12MB2528.namprd12.prod.outlook.com>
References:
 <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
 <atsIGZswWCjXlNSX@ashevche-desk.local>
In-Reply-To: <atsIGZswWCjXlNSX@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2528:EE_|IA0PR12MB8352:EE_
x-ms-office365-filtering-correlation-id: e729483a-0af6-492f-35dc-08df316281b9
x-ms-exchange-slblob-mailprops:
 hnD4Fgoc1bPokEwHA1l2GYyEHUkO2myIrX8kMDhREvwIynrhwJ1dswpRd0vVlm7HIsviBpLe7GTegDrhdq2BOgNUepc5386Oo/7MCoqP2NhAHKg7m9N58L9WkQNtLLymzN0n1hQyiGO5gcR6SurNclpW0zY15AftDe7RJ+Z2rQ6Onj8inrky53/st9RDMMZ9C/0Azd/cnw+Qo/DrdOtKQQUtm47IGd8zhbxM/YD+Ofqr9Ny8L3duzLCBupwGcgJ9S0vl/zEEzwlzC3FDMZUwEgFhY5qnJUchNh2LkXky10GwnSTlKJPn6q2b1BTWjKUFHAcp/TtwjsT6sBAMrWiBaYgrLPsxmb24iopPAennVlqQmSM9qvghGiD+JwrGNyvCudIVHT7h1VsWHsRxZY3HlLofdVxJAlIiKOMjFpt8RLwtODom8gXKSI9zM86F8cgcfVIh5ohsbfRKFnNpyx9ajpsuYuPgpzPekpwT2SOLqghCXv22tX1pEYYRly6phGbnPDPV4LwpKD4SDtQ+JuzGkseq3zXnGRvyIEfREzIZo4JM4HRMsSOaVa3F0ngY+jpyn1IFsAAayj2bJPtF55ZMH/6JV9CwW1qfn/KTX2vYExNrcnp1f9Mll7eTf1v9a4tW
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|24021099003|8060799015|31061999003|25010399006|22091999003|51005399006|15030799006|15080799012|24121999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xlT0iv+VVsDh63tE/4hA59ijyz2WwauQtYyA+g62J0mbuB/yxB6b5YrstG?=
 =?iso-8859-1?Q?9OgqmRF6/0R1S2J4qXPiV/CpLz0INYT4zWa9BwAceJdTZdkCCPlTw7+VSr?=
 =?iso-8859-1?Q?TaYRvcU/9xWUKiYrM7UvVN3zAcjsgFvftdZnOSO62cfwR8lTTHvj3Ys1nM?=
 =?iso-8859-1?Q?WITxv+BWmzDdVlbfCteFNpI+w3y+fWPbxGeyWNgKte7cCIqe9PruKJapVl?=
 =?iso-8859-1?Q?zFrbyJQglecTXun6xh3O/ZO2SlpAKcnZ7eMe5l2GgqGdhOKZ++ZGFeSXqB?=
 =?iso-8859-1?Q?Gslh74IuS3IDHq/qlY0dNhvc3W/ElhVs+1i+KGTLGqXRR5mZrkS7ZekpX3?=
 =?iso-8859-1?Q?/jB17tqBp/mU7+pc7C/YB6dNWC8DLirh+Oukb77f/aJUGy6EV2dIjXIbYH?=
 =?iso-8859-1?Q?4Garfzh03uOhso7x+J6CXUFnc8hvS/1bBpLspka/Ccmga7fYYPVfHiIRLZ?=
 =?iso-8859-1?Q?NBsP8wzXAn/dzgrcOnFZWWvsigAiTDDwVlKWj46FEQrs4isgv8/1TSDsKt?=
 =?iso-8859-1?Q?KAtp7YziYR5fOlkdp1/uCOrJDAdh3G1axmPzXufCIlEBxgvsBlWC8u4zAi?=
 =?iso-8859-1?Q?NAn/SZxzO1LWRLUjHeqd23NJCaZ+yYmJPi24BZ5VhrVMw2lGzYI7NJ08ln?=
 =?iso-8859-1?Q?99rwqq1nH2rTXyXGAWHoGm16QSOPY9lsiezFsqMzzY1fKieOkaMLNWoNkx?=
 =?iso-8859-1?Q?lhc9/TwYxjhagUHg7s8bNxhlT6f0wWqdCM//IExdNr715jOTVUEFszzZSX?=
 =?iso-8859-1?Q?dIN8IgiuaNFR+gXVz+wQEyAw9D9+cAyFRDaGkdZ2iYNgYlQfLPuXEbKqSb?=
 =?iso-8859-1?Q?9UfBq//HenJAcutxhw2ddWRZ5LRH+wUbFAnH6RFiOXySbgENQl1WWYzKuX?=
 =?iso-8859-1?Q?v6B07jXgJ4ECuXvsLU0+RDEmF8CM8e3jHmD5jSR8MV0jwMzugQbvuHDm9Q?=
 =?iso-8859-1?Q?LSTDU99NttpLdTLFb90a5C/DEHPPk1LxBQn1r9YrCvqLkpn13fPPux5vup?=
 =?iso-8859-1?Q?Bz+H/iFcM2ycZDL9ui/JTJvowhuXdPumR4P8tDs52duehFg+nrKc6QA3cu?=
 =?iso-8859-1?Q?fbEEusyTvvt92y+T9MhrhAY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6N2NudlSdNMJWb4LRrlDjgQXoeKCDhjt5YZGcjloyNCEnxNQpr7/1o7pbp?=
 =?iso-8859-1?Q?26B/f/LLguLzXs8hxR1u2Ibs+gnAC44Ym4wuhzGbYpv5RnSPUMRdN0dWKi?=
 =?iso-8859-1?Q?Q8LlGFxf366uGW65HMAlGBIlHNzg1CfIziO1ycdAqSI5grWmphWFyUCm1k?=
 =?iso-8859-1?Q?X+JhkluQJ53ZWGO3U2qrSNG1nXp3Hn4y2QphmhNHVJYhLxC0qSLM2SxNR4?=
 =?iso-8859-1?Q?jeflayrfl22B55NQcaMgE3eCsbMVV2Cw8RYR9n4Gn5uX7SjZZr9YxP53eO?=
 =?iso-8859-1?Q?192uEfHgGDTYEEHkS8B423FWBuSzjAcduwIoYwC2Z38XLF80GQCYYZS/ao?=
 =?iso-8859-1?Q?Fsk0d9oOXLd7eNMbupTSL6lwMLwAyyThvoRZMMG79Lc1ySxeX8Y5xQOefh?=
 =?iso-8859-1?Q?15rbXsA3DekTohLbCzkZoZv4BGbwRPpWXXbmSCxQ8A06UymEN6qTwSS9LA?=
 =?iso-8859-1?Q?HRD2hlMbQyPkAGsNaaToPxAIV/TX06YQlUZE276ad2P/bvtRqFTTu5uQtP?=
 =?iso-8859-1?Q?nsf25mqmv6RTz8Htm7znjPEXdiER+fQIJWIk8C17GgG6QzfpEoZ6Vb9DmH?=
 =?iso-8859-1?Q?OMXSuSjNl6hk8NQD/l2kJJFkn8pcn0fo0NrMUi4Icaw7QomhQedPu+ZWPc?=
 =?iso-8859-1?Q?j6+vXGACGeitbDVt+b/ZiErfPEzCydI6HlaW3jS5hO6nxJ0MSNJhXQ+v9K?=
 =?iso-8859-1?Q?NR/p0qQVkW5N6nnaUYUFKQ8aB3Y4x3nisY6L/Uia1QtcqGd+5f+8xXAM7a?=
 =?iso-8859-1?Q?stsHF+KsAEP9Q9yygvXN/fOIzNhZSKvU4M/kzm2vJU+aEaDy544j8iKdKn?=
 =?iso-8859-1?Q?X4ziK9X22qBMF2BS7O25gfU56QTiDZmvlpmUtKor4ELjZGlFIkgVatNqBB?=
 =?iso-8859-1?Q?IWAsNW80A1LptEvjaH40xQYpuqDPQNlv6uefZEefIa+Nk2nVy/E0uEO7yU?=
 =?iso-8859-1?Q?JuPvpgTHQzTlZRocylngDD1JePcgNWhOKt5luTuvvIwa0vl9QXhuKquE3g?=
 =?iso-8859-1?Q?/L68x2cLOLDVMw9PY2GqFMfO6eeRQSMEf7JdwOS8vj7iSiofrAu8v3gST8?=
 =?iso-8859-1?Q?6Uqt+qS4n2KB55CGJ9PRkAdbc/8nbi1wGLdj9b5QCovpOFiJIZcbZ5SLt0?=
 =?iso-8859-1?Q?EcXciH/yalv4CHKJhPdqIuXqkbxpNI6g4GD/zIqsckZrQo38MV5EHYVKNX?=
 =?iso-8859-1?Q?rA/qoE3qGISCcY5m/SiiMND2tyjTkrlfgbm1QdhZlfNsdPpffHXcjtlJSi?=
 =?iso-8859-1?Q?J99DkdRAV2o73wp3xu2q5mvICBF/vKtqBzIebvQD+ejQq8cYvFzovgI94l?=
 =?iso-8859-1?Q?1cbK7L6SXYRikhCgeC0GPTDS9qEYCpmG85G/CFI1x44AiGhY5A5I+VB4/f?=
 =?iso-8859-1?Q?sFA7hYdtHcSnSlUY2ilRFx7oFsbqk3oNYV/OaAHgcWp0PDo2AH3BUxNGzM?=
 =?iso-8859-1?Q?utdjDFlPap87UWaNmdQT2FMKN52Ui/BB4ppoPA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e729483a-0af6-492f-35dc-08df316281b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2026 00:05:26.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

> Tell us more. Why do we need a brand new driver?=0A=
=0A=
Sure, I've made the cover letter more detailed in v2. I was a bit afraid of=
=0A=
repeating too much of what I wrote in the driver patch...=0A=
