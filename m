Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC753A3819;
	Tue, 17 Mar 2026 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741278; cv=fail; b=QuAkh2CAcwYTo//Ie7QSP4EOW3n59YqKDyMYaN6REpkVpOkb+DOd3SfwxedyXUXr5/8pdLzd17gGeP1yb2pe5HRlso4F8k3FM3U3qorcdO/2iH2tl27Cxp6RpIxmsc7x2UtuJPS4n4v6PeX/BcPM/xrS/hQeltju9A32IbInX9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741278; c=relaxed/simple;
	bh=LZmybCpHGIN/eLJSlwdEL/Z++kZ+c9o6mrXHwQwa+44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dj0GF3u9ikIbtJwQ5kCp51IMKzM7eOvUuQTOhb6vlhxnCYc7y0S3l7V6sIq77g4FMBLbwSn6TNdQL3mWACWJO/XZ38Z+2uGboziaHW+kWJrkRD7D8CfvVQVCmCwxT11mkAN4HRCoXEh0KOFgUMD6zQEv429r/BjnQjusxiH/7wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AN5VZEHa; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AN5VZEHa"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7IadH3759632;
	Tue, 17 Mar 2026 05:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OWj/5
	vqnG+V7uzqUH0hfXf7JYRkBOZdKcjoRBRyAlHU=; b=AN5VZEHauv5giGh77xF9l
	QW1A75mIbKzNHL4xgecli7ZO2qJJ0jBajhNEe4qVAEo+wZeX5npkVIx9iTU5mwzO
	8J1yAAI7ix05w/v2GIsUCuys0cAM3isVYp2YUR3wLWYkaLGdIwv1IFwwoyXVyhI1
	Eq3fszhv3hPNBKcV8x2pjHPMba3XcS8u/5MGFQVCbPl033ITLhcn1N0FWQ1x8YpH
	JQ0m5BGpLMmtD7IRBYWaPIsIo7+lMxMf5zL/UPghBRYpCyoPAPQgPutixOlDUNKD
	PL/euwYR6gTEH9rcHuvfWSRONoZbKJifeb7/az4R8ldrBb8c7Y9kypZjwi3GmHij
	A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cws0frmp5-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 05:54:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBECpsodHoFBY2bEAwbFxcReMsJatMYk9VrCK0iJdoWiyHf6+3Me8pIj3tYdl4i2Ny+9qrKPPaYQdPmNwha4ZhfW73zTWvCEUSvxwkVagekISQtb8Fod3eF8l8Lgh2+oK0tLZXEj7xAC7qyr39D8j9AvsZ/spOo/tbOiJf7t9dEgxvLfG/TeTBFjyGIqkfSp0zihjSORKFzQsg1AK2ZVaswc0am0yMzng9bGP+ZmKGmYw07suV07FaCY4DiT6/8kzl8eJfhSjD5VoIJsDawXloKaHd+lg4y1N2d438CJd5yz95Lkh1xoxrT9wNkD0kpc8mAnATI8Xigz+uVZ1kLIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWj/5vqnG+V7uzqUH0hfXf7JYRkBOZdKcjoRBRyAlHU=;
 b=DVolMKa45O1hh0q018/PAJdxbhAwSN+GZLHLQHu/5Ub3mY29WkYO31M7CMBd0TKncNoJdEWMITMjgG9rr/ZTWV2tMP2x7VS/t2rKDT3bnhSX9THwUTByM3FHj+Rqb60bvfcqHEV9ASgU89NuePPzuwHJdixLnM7piNNpi+Kn2eB/BVIN6fHo3l80Zi7M4wfdJbKuO2/y7PyS8vzyZiFayzkJ7bqArNOVtX3pXIby54g/JyjhgMK/HGFEKK8jWD/Rjb7osLuqEWt3V2I8xcaHPn1C0kBgzVRpzofNNvcHzuBtzLEtR/S/Z3OHG/TPFl91I2tmcTHuvvF5MX1mxZGA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com (2603:10b6:805:d::23)
 by DM4PR03MB6030.namprd03.prod.outlook.com (2603:10b6:5:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 09:54:13 +0000
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef]) by SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef%4]) with mapi id 15.20.9654.022; Tue, 17 Mar 2026
 09:54:13 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Topic: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Index:
 AQHcsuDicaoN1aZWTUK+A7wds+cMEbWshACAgAFqgwCAAwIhAIAAIhZQgAAth4CAAASQIIAABmuAgAE0sQA=
Date: Tue, 17 Mar 2026 09:54:13 +0000
Message-ID:
 <SN6SPR01MB00900C6A79A51852C73D6ECF9B41A@SN6SPR01MB0090.namprd03.prod.outlook.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
 <abQdvXq9MtIZ0EpZ@ashevche-desk.local> <20260314120022.56265de3@jic23-huawei>
 <abfT3qbFaM6PIDKx@ashevche-desk.local>
 <SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
 <abgWpzT_fcMqRHzf@ashevche-desk.local>
 <SN6SPR01MB00904D9E9C5008D32066E2029B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
 <abgf3TZTib9UrjSB@ashevche-desk.local>
In-Reply-To: <abgf3TZTib9UrjSB@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6SPR01MB0090:EE_|DM4PR03MB6030:EE_
x-ms-office365-filtering-correlation-id: e3edd91b-ae28-4ae8-20b2-08de840b2512
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 okFbwqjkuZeuBWGa1umyv9HwCAkhxTHUB2fBjA5iZY22k2S7nheLxtYZYuFGh5b4Z8LO0aGrsc4Hly+6/LQGsnVRqPNVbEnaXyF6Xiz1bAQfahcIva1vKBQH9v/vzVjXD8lcz7XMv6M22xTgKzOAjRmOVENbxG462mrdAUyG0VF7HI0bjIyusTW890N3IG3mdUnyVeZubDusAR7bkah0JiMgBWHxBCnhFhjiLyPkppgR8ufnMHFtv0J9j7O6W7v9IKtYgeynamjUJ92JyQwY72AJW0N7ww8SB+U87jRVd8pcmfnh3qqDwwC6+Km1dk6n7VTNE2mxuqMtUv4unpMLImAiFx50YRIQnov8kVN4lMs8YP8Yeb6yAU8XwgVeYrkKyok2qD97sTbST9Lb/G8XkPQr476NldBAkG30CD0GB3tVCeK630pHMepXW8Dk9LgKm3XI/VCL6rctiNT9SphrMkqPqyOmeDD26rq7KIDgiVcnlLRHVCk26N0p9gW3JSSKGLD2NhnFyGarrqZr6TY3Vthl4ibw2OVUxqOC87xQvhD/emwJtP9GpdcpjPEwe6pgbrgsZY3uI6sTiuiCnRIxQ5zyh5fH40rj/fG1PFUOeI1G0aXmsQ3K5QR9nI7nb+hcpcDl298nKqk+XkqpdUwizI7blNGbiB3nys8YXPtZc3pbpezqtyicPdn303lkMRx0HrJIZUbl9YISHl9e350qlemGOUfD2MWGumxA1l0CW5Jk8HHdwy9J/KbMj8Wl5Q7TU1eJ0GhuJKIHVScnfbzY57gonlOFVnjpf3MXm6sUSsg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6SPR01MB0090.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o96Co8Z/HZYfqq59Ya3oADPKS44w0okQykR9OpV+/UwrwW6Qo+ojIG2eZj?=
 =?iso-8859-1?Q?7XkwYmiwzDebpwtKwycnVQSn9N5HYXb7xO3Plr6ncWLN/26aBi++ghOmVl?=
 =?iso-8859-1?Q?YTBLTPhv3zXKSauJKuuQxpXFSQSZ/sSXLIdL0+kA4nz6k31Qi/x86cuJYf?=
 =?iso-8859-1?Q?zeD8ELCQnA2S8dDx2MsdcJCenNNDcYu0EUvjxwB5RcVWhJ4OmPxqIkiZnp?=
 =?iso-8859-1?Q?nwiQQ6UmVkIxi/DnzPY+mg97MEhJtQBs/2f1KVQQYX37W8ShlwTd/sWJh6?=
 =?iso-8859-1?Q?UWzEpwJ6XcOtGoRVP+ma0D2cvsZhmhGF+ym77l5E2ML4ArxTRnzHiIdFqp?=
 =?iso-8859-1?Q?lUg02Sbm03weV/twCRABFVN6D0B2z9reWGB+TxbxCqjdRBGy+hfJrjOjIR?=
 =?iso-8859-1?Q?h35LQkMapfkyILeXwRFIjmGBcYLDf2sUGYSVdoSzAsfIjvABTqI25REvCm?=
 =?iso-8859-1?Q?XXGEqJvEXORJVd27aKS+FMKFN2vRbfely9N1zjArfm69YvTVXEEUxiU3yb?=
 =?iso-8859-1?Q?DRsvuLCUQgAbde9BWJHvdjsKHgKFRFBUcDO2YXMOo+0O8yKAnXI5M6xMty?=
 =?iso-8859-1?Q?R5d1bhikQ0nIfLP684W3hv4XjM5D/Wwe07/yjfqFMSSA0H1q0lriqdwUrm?=
 =?iso-8859-1?Q?MF27Saeel6J3qLU88ek1HzSFc6Z+ChNHWYum64Ve/qtUleTppr7AroKtJF?=
 =?iso-8859-1?Q?GfvBnGTMeh2bC24sqO9W6tsZv83YifgXH1XC0cnGgoEMZYfl7lXtDFxw0o?=
 =?iso-8859-1?Q?ZKnGqPMpHdkJ6s672w8SELFnnyZMVh3DCFDr5BjywnhazJaVUFxa1PRQN8?=
 =?iso-8859-1?Q?LJVbi3HlMxCYkpZQt1/uQ5J+RVfwLk361AU/5og7znsVXyvs6vG60L7k6x?=
 =?iso-8859-1?Q?FA5prYZS6bKd1J8CnOdea8wSW7m9YVoz9IstFDpcOQie5QD49H106pXr58?=
 =?iso-8859-1?Q?KhmrMOTOXz4zE2z2UDeUf+7co1PdGprQ1O2WQd5Pnh9CTyc/lAKHIMqVrN?=
 =?iso-8859-1?Q?CxW26tNhJgfi002JUtc1UJErH9j7uxoREqvrLegm0S+HrkFiIMaIxo5OYl?=
 =?iso-8859-1?Q?+hwVuOww4MpWVz7hmKjtRddorl4/Q6q0OHEdRTaXW/6ytyb9RFVvNTXjnk?=
 =?iso-8859-1?Q?n145+0ksoQo6oaLync6MgLHlV5n3kFTobU82nfN1FWdOl2hH0GqeuZdqFC?=
 =?iso-8859-1?Q?UCGHyKbkM2bPGHuCHGRe3TbpBOOvtyWMdeuRbKLr71iCkOrKdTY5YnN8Ew?=
 =?iso-8859-1?Q?H6g8LHLqmFLe8eiXZ+Jzp9hmpTXt3Fs3y1LSYx1I73mAwHVvmWXrC7/5Io?=
 =?iso-8859-1?Q?+RNulMioVRVnZwrxF+kvo4SKSQ2/RU2kbHY5qSXFnrWMD3XcAXTKfMI7EJ?=
 =?iso-8859-1?Q?QxRwLMk+1570+TPRFBTipmauORScv5BbXw/JsBejGTea4FxUehkLujQwHK?=
 =?iso-8859-1?Q?RJjQZ7arvZj6MkhmyUqp1bVu1aXUv8PnQHtKso9UTGLZh9/qRhhBHNEfa0?=
 =?iso-8859-1?Q?LsossRZzJ/wtPzipkzmAtmq99RhmNaNgLMJe2gCcceZ/dQPtszsQcmjrJo?=
 =?iso-8859-1?Q?jSfJZUv1RpgWS3kHp51HZyjHfKrpqU6/axKIYqTUMy+/8IBCnIY2Te5QmN?=
 =?iso-8859-1?Q?teDoQDPlKNCrhR2HapeJziTG/frr6jejYirpLIwYASm1VPcn+7lu6T3rTf?=
 =?iso-8859-1?Q?epcumm61Sqyo8mEVRqUiHlCT6PERlFwLrYn8uJe5790NKWU1T32FPJgN4b?=
 =?iso-8859-1?Q?rusFOmZ/wwi/9LNJvnGlR8asy1wHALptWrgjuFOYxz/dLl4+IFvyZEGJNd?=
 =?iso-8859-1?Q?MXDKKoWQsw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UfNSLSu8mSaCT3TiDFajlPGBfQLCP1rlPaF4VIO6yfhRkjdfKs+VYVJHZjGH6bcRBFRV+VrUSiWtP7j66K7IkJEFwGOuWnkMTiRogNRh8LHWP56i4lekOgRFCTcnlr9H7nErQnXxniOOQen6/HNLkkrnQIZ5sHsRW4LSoxeC7EnBZMRLd8afYLLvf4PP19/cZlk+UHB7ei2p45VC4no1YgftvZfBSAW0J5fYUe7UyQ3VwIVt5pi9JPivrzo0J/iT66pJlbJWgByyMUOHIar+84rrEwNg4Upm8ySWXNNaNYWXiiCWhWw8rw50Tb4qbesveI/CK/xXNKHsDgCca7RZpw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6SPR01MB0090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3edd91b-ae28-4ae8-20b2-08de840b2512
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 09:54:13.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yApwfXi2CBdQu1GnyeORJO+gG+Mm7oPm6ryM8NUxFq/2j53+ejp/UxO+GgQsucXvLyD3sQ4HA0xxpolPmdcFg2gEkjo0pRdr+WEZS7U3QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6030
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4NyBTYWx0ZWRfXz5B6nmKu3VAs
 Chs4BhOTTQ7BongXAkNnBlxNvwBSP6RJtRy4dpqqRo+kMPtvePjNJkAvBDq4ryDSxnxeRO+Tdll
 XFui49mYngWVS4jrzg556liF6VSQq1g6LRJKhyH4wrDWJe8L1h0Vwsn7cdlwQ4UER7T/ROr5G20
 DNUSwiuwlKVggH5UlZIvGOIzbBybsadY0NILhsquKgJJUPW8oKnCJaDzHtQ0XXw3p1HpqSqzjz6
 6iPBULoWEU+/tJynBvlGO9CTtRaCU5VXIsMw6yRmqgYjOOvV3PwzXW83OAt9SHa7GfchkFt0UYF
 M/CLtUHqseZXVMgL+4eFWVB3EKH+dpNHxiPnw/1QRT2Fvn1qSNI3sncnZCa+Qp1sUf+hco6P70u
 R7J7nhig/fSuQeZt+PXk2z+7XoEAK4LF+wngYOf3gau4vr/Zg+BsBffaSwrvAj4dsszTZQ6LRU0
 qtD9kGBdoI1KdR7+cFw==
X-Proofpoint-ORIG-GUID: BlGlB_Kiv84SfkinayTmqsTBR1EPPWuC
X-Proofpoint-GUID: BlGlB_Kiv84SfkinayTmqsTBR1EPPWuC
X-Authority-Analysis: v=2.4 cv=BbjVE7t2 c=1 sm=1 tr=0 ts=69b924c8 cx=c_pps
 a=MTA8SzjkfSP6DqtUeP+PaQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=qCAConlU09AeaAa10I8A:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170087

> On Mon, Mar 16, 2026 at 03:09:18PM +0000, Miclaus, Antoniu wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Sent: Monday, March 16, 2026 4:42 PM
> > > On Mon, Mar 16, 2026 at 12:31:09PM +0000, Miclaus, Antoniu wrote:
> > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > Sent: Monday, March 16, 2026 11:57 AM
> > > > > On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron
> wrote:
> > > > > > On Fri, 13 Mar 2026 16:22:53 +0200
> > > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > > > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus
> wrote:
>=20
> ...
>=20
> > > > > > > - What is special about channel 0?
> > > > > >
> > > > > > Nothing.
> > > > >
> > > > > Then why code does explicit access to regmap channel 0?
> > > > > We should have regmap[ch] in all cases in the code.
> > > > >
> > > >   There are three places that use channel 0 explicitly, none of whi=
ch
> > > >   imply channel 0 is functionally special from a hardware perspecti=
ve:
> > > >
> > > >   1. ad4080_reg_access() - the debugfs reg_access callback has no
> > > >   channel concept, it's a single (reg, val) interface. We have to
> > > >   pick one regmap, channel 0 is the default choice. I can improve
> > > >   the comment to make this clearer.
> > >
> > > Then it's simply wrong. You allow only one channel to be printed. The
> debugfs
> > > has to print two channels, no?
> >
> > The IIO debugfs_reg_access callback signature is fixed by the framework=
 -
> > it provides (reg, writeval, readval) with no channel parameter.
> >
> > For v7 I can drop debugfs_reg_access. But doesn't hurt if we have at le=
ast
> half
> > access to the debugfs for it.
>=20
> This will confuse the users. Either do not print or print it all.

Agreed, will drop it in v7.

>=20
> > > >   2. ad4080_properties_parse() - uses regmap_get_device(st-
> >regmap[0])
> > > >   solely to obtain the struct device * for reading DT properties.
> > > >   The device tree properties live on the parent SPI node, which is
> > > >   channel 0's device. This isn't "channel 0 is special", it's just
> > > >   "DT properties belong to the primary SPI device."
> > >
> > > Can we simply pass the struct device to that function?
> > Yes, can do that in v7 if you think it is absolutely necessary.
>=20
> Yes, please.

Will do.

> ...
>=20
> > > >   All register configuration (setup, filter, decimation) already us=
es
> > > >   regmap[ch] throughout.
> > > >
> > > > > > > - Is it okay to communicate with different channels simultane=
ously?
> > > > > >
> > > > > > Yes. They are entirely parallel bits of silicon. Own state mach=
ines
> > > > > > and everything.
> > > > > > The configuration registers section of the datasheet says:
> > > > > > "Each channel has it's own independent configuration memory
> > > > > > accessible through it's separate configuration SPI interface."
> > > > > >
> > > > > > >   Wouldn't be a nasty race with HW IO?
> > > > > >
> > > > > > Nope. You are talking to different devices (more or less).
> > > > >
> > > > > If it's a twins in the package, why do we have a special handling=
 and not
> > > just
> > > > > describing two independent devices in the DT/fw?
> > > >
> > > > Because they are not fully independent - they share:
> > > > - Power supplies and voltage reference
> > > > - The CNV clock (conversion trigger)
> > >
> > > Okay, then why not having a core part and a glue driver that register=
s as
> many
> > > devices as you wish and provides just a common stuff?
>=20
> > Because the AD4880 is not two independent ADCs sharing a package - it i=
s
> > a single device with a single interleaved data output. Splitting into
> > separate IIO devices would make synchronized dual-channel capture
> > impossible from userspace, which is the primary use case for this part.
>=20
> Sounds to me like you need, probably, a virtual device for that.
> Maybe even on IIO level. Do we expect more devices like this to
> be enabled in the future (or maybe already in tree, but lacking this
> feature)?
>

 The AD4880 is a fairly unique part - having separate SPI config
 interfaces per channel with a shared interleaved data output is not
 a common pattern, and the chances of another device like this being
 upstreamed are low. Given that Jonathan has already reviewed and
 approved a previous version of this series, and the patch has
 collected multiple Reviewed-by tags, I'd prefer to keep the current
 approach.

> > The shared resources (supplies, CNV clock, interleaved data stream) are
> > not just "glue" - they define the device's operating model.
>=20
> Sure, like any other resource for MFD (HW speaking).

MFD models a single device exposing multiple functionally distinct
sub-devices. The AD4880 channels are not distinct sub-devices - they share =
a
single interleaved data stream, and splitting them would break
synchronized capture.

>=20
> > The per-channel SPI interfaces exist only for register configuration; t=
he
> > actual data path is a single stream handled entirely by the backend.
> >
> > > We have similar (to some extend) cases with SPI/I=B2C where
> > > drivers/platform/x86/serial-multi-instantiate.c services as "MFD" for=
 that
> > > type of busses.
> > >
> > > > - A single interleaved data output stream
> > >
> > > How does it work in non-racy way?
> >
> > The data path has no software involvement at runtime. The CNV clock
> >  triggers both channels to sample simultaneously, and the device output=
s
> >  the conversion results as a single interleaved bitstream on the data
> >  lane(s). The FPGA backend captures this stream directly - no SPI
> >  register reads are involved in the data path. The only SPI traffic is
> >  for configuration, and each channel has its own independent SPI
> >  interface and regmap, so there is no shared bus contention.
>=20
> Okay, so it's in a way more complex (like a camera sensor in terms of
> data/configuration paths) device. It's now even more looking that the
> current approach is a quick hack rather than a solution to make this
> properly fit Linux device model.
>

The driver uses spi_new_ancillary_device() for the config path and
 the IIO backend for the data path - both existing kernel
 infrastructure used as intended. No custom abstractions are added.

> > > > Describing them as two independent DT nodes would mean duplicating
> > > > all the shared resources, and more importantly, the data interface
> > > > is a single interleaved stream feeding into one IIO buffer. Having
> > > > two separate IIO devices would make synchronized capture impossible
> > > > from userspace.
>=20
> > > > This is exactly the use case spi_new_ancillary_device() was designe=
d
> > > > for - a multi-die device sharing a bus with separate chip selects f=
or
> > > > configuration but common data/clock/power infrastructure.
>=20
> This... It doesn't fit the data path as far as I read from the above.

Right, spi_new_ancillary_device() covers only the config path.
The data path is handled entirely by the IIO backend with no SPI
involvement at runtime.

>=20
> > > See above.
> > >
> > > > > TO me is either something special about channel 0, then we have t=
o
> > > > > synchronise
> > > > > accesses, or there is no point to have this patch at all, just ma=
ke devices
> to
> > > > > be the same under the hood and describe as independent pair.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

