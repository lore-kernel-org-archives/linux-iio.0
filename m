Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794573690;
	b=z8rfiy9dGDwGsyCq/wLYqXM6wUdXdX+Z2gsdmEYmA/gZup/JFlj2NwRkC++rQNGIPRaX
	 n5zmK3hu40Xn7uQzK80b/ZeWObIHaebRvLyQ1i+2qp2nhZkkIA+OHPD0GVAyxcJFcVLPr
	 8sokMYASM1W94f1rHFrbo3msK9gg9H7xqqK9XS0GA1uh+DJLrFY7ZnZrBrV5eBt96e28j
	 y6xycJK8y3Bbq0rgrpSv/+Ea4+8Hn+/0D2qRO+AQ2mCis4ZVtjFnvIzIKmMiohMK4tNgR
	 ScxrlZ+zeMjuKpjyLDQ4rXDPYe28h8Zfy5wIzHufDpqcYYKBRWhd0QDIeWrBB3jRWLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573690;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=z/TTxHf3+dxvBhtGDsdESV7FG4HrUfOe7yhJkN9n6+4=;
	b=Yipa1SIBTdTunRBV4/qySB2sc5wGKKEDMuKk4TTtHHbymNMRlvtS1U4KPE14rDLUanZ8
	 TeIYBIgtr6XFpmLKR4htXxuLKXO8Fkj+sWasf/eZdZCoID8KoalMDvA67RjT0MBEpjfTd
	 ElMuVcH/leHtXNM2u4AKAb/1OTPwuLCZCNwmhmlNGLXe1eZ1WEASCDhcFn77M0rDySN0l
	 Vykkg1gN6p4aAsRDDXjt4dWoHKTE63/0IHxXCkVeRx3d0LCT/4+aYeQwTCysCLKKxT5WZ
	 CDCRf4JICn02LyIKzFz1XH0ZefDCVhMl5kW84/HNyAMxvtZLnUgaSI1hd4NSSPHxpWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RfX8fCEh;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pTBCWGTX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70671606A323;
	Fri, 13 Nov 2026 12:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70671606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RfX8fCEh;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pTBCWGTX
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC2mNm3177804;
	Fri, 13 Nov 2026 07:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=z/TTxHf3+dxvBhtGDsdESV7FG4HrUfOe7yhJkN9n6+4=; b=RfX8fCE
	hXrcxFDBATAke9FUmhy5xXnOcMV4qdE++k/XYkoCW+7AKu5iN6su31zv9ASeUAzb
	nSrayYAYWMT2Dm+GJx79ZttcbkNM3rkzJbP7AU5Udi5/7OBnwklk62u46w2roSSs
	UExkbD5kfLYXk87mKrZWAGskphLXTFDkFR/8OnwPoCB6IOgLjAqnamYGfMeU4xCC
	4n9RAUDskkTHlU+e7VRBg3KERhFbtzXt6PnPLr2b6M6vKCg4a9t88POP0yacPIgV
	VyBtGyVeunvEwnM4USfa51LpQ864t2wIEUemvMaBA7Xw/V9Dg9d22LjokKtzJYpy
	IYFhlvT2jp8VX1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=z/TTx
	Hf3+dxvBhtGDsdESV7FG4HrUfOe7yhJkN9n6+4=; b=pTBCWGTXCIJrLD+9+dVRi
	dbdf4IjgSVs+eG20Cqb7VwIDE7duAfSo/6yvHptTAIM+HX+PJNiqipcyKGzFN39L
	ZaGNOUAMxSRsAbLOjd/3bHrFuAsP1xbo8Sszb8n++EEDMufoK1NeJelnwwfHtMMw
	bb+nZLtK+eEMk82OWPzOQ6kZ7VR81wDpxKcKwKW1rFFS7evWHs1Z7JvCpPm7aAfS
	icHSraBnBPK5R0FTEt3kCdzKfRpA1dmzo0pANoyjoawofBJUE3l9tf5YNMyPT5HE
	cnRAVupDpDWn1Fp6eNjMTvVUV41k5t6rI0vYFjbueGIBSju3OFC9Wq6d9zPgPeuL
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hwme4b5ue-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 07:41:10 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEGRBjZbcNjMwrOr+8iuqLKHP2w45hC6ytD7Rar0/TsfYt9juQg3JP/VKBKaHJwstxoAeZaFpq2CxprbxGLCnCxqYU6eI1bH+aJDGdmQwyltlJAjvAFvkGQ+WvHutK2//BZz/zmN3EX+YgCG4MGdCA1B2a7Wzz+Dp4Me+eUsp7zXWMud55P0LZU9cHxbyDgbNwAtDswfeCYd2RUF03AmeSJrC9PWXh97lps00iU12Zcl435d0xwL7TuJzjvfKyvQL6OUyxIKRdtmlvnz9fwEFs3MM9fzfMpTQlmdMkO2qbp4KIJcL5o6avYEmsv/ZgLkXwA/Ok/G4mqqXCRhQppcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/TTxHf3+dxvBhtGDsdESV7FG4HrUfOe7yhJkN9n6+4=;
 b=aXgj8HEeZUa25zDhH1pBejeMvUe7X1nxgemNmd0td85lJEXB0YrLFzR3QoQkGIznbAEOiVmJP4TV81scMCAkIbUAUzNkz3OFjGtGNFI8u1HqNU7FvKhPJmRAcEvKtyBOSUzyPT53ogM4fp6SLCl69eMrGEIcPJ57ONxJpf7cIKpR0gi7oEvn50n9W0c86Uy9TRDB/bxpC/jGQ5IV9rnRL18zjoMKvLowPlV7pdZR+SnWxLTwPy1lPwXuuqAs1qQnkYFgkbqNzA4SE/YD26V61VG+4irSdvar5NoPT5oxu6jAFp7tRNNEEKPDYVPeeOBcF2AnnCp1izRT28E2RSSXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by PH0PR03MB6956.namprd03.prod.outlook.com (2603:10b6:510:173::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:41:05 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:41:05 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru
 Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "Budai, Robert"
	<Robert.Budai@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Thread-Topic: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Thread-Index: AQHdc2s9Qg3RNVIBC0mRongyWaIGSbcr8J3g
Date: Fri, 13 Nov 2026 12:41:04 +0000
Message-ID:
 <LV9PR03MB84148ACD16DBA8896A81582DF77F2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
In-Reply-To: <20261113-adis16607-v6-0-3f678719942a@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|PH0PR03MB6956:EE_
x-ms-office365-filtering-correlation-id: 3a4a195e-e2ea-4f15-47bd-08df418361ff
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|18002099003|22082099003|6133799003|921020|11063799006|261102123227099003|261026121527099003|261022075727099003|261021121427099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info:
 jixc+5IDpcDzkt7ototUDK9V4p7vbh/yrkIiKHb152tXzAi+8T5wL6afdqSeHnMLG7b2x/+bcfyUTUwkGbQ5lLu5Na8afxozeXxyE0JpCp1BxndO348NoSSYEkH7qENpjZGwLl1ecE6JfDGudmpZsH7YAXE45b7ozXim0S6iiFyVBBlBtFIoYpfuQ5ZUOrAyd/zmU1E5tr0vM5QCp/0docoroDfsh6ES1le53+iPSdVnCnIATGJdECzXIv39a7Oc2oKMREq7I1GKxy3APhi1AkJ3JPDiicTKmB88bWCFAznKjdRfaPN8nPgNdx2ydKvVxeH6joRM2nOC95YDoZYZLIDlDMeyqPxJ1hFTphRvzh4YLJbb4c6PPbp8ebWZfb0iGkGMXw2ZoKyCUglx7J7UMJZifmlf+4AfthqA/EYwXt3xggwuQEnOuA1C3+Eafxn78qxDZKvwErW+t+5rgwkS8cmSASXzqFeQBI8hfTpUw1LeFzbnjNlcpQNcBDaYsO1dwzY25jJUJ4hnNEx66Y+anqS91FXf43/VUcwhfiutXa5D9+ByjqrZtsou6b4IOJpd+4M75sfGOJPTEGH2RpoHG3ReuIpJwXaAbXpSJvKhjYhqvw4w++yNAszKK4MmIsxXWQaP8VgAAjCJ6Dhim+f3cg7W2rRr/bk5SV3W103hxVb0+MdSdvWUzqikpQQZ7tkHyt9XxaH3ANO8U93UfROA/lZht0IARgjOYXgQvdjjBeTg6k1IJ6zXKXeQwCPnYUGk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(18002099003)(22082099003)(6133799003)(921020)(11063799006)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUtIOFRITnJTalBHMmdwKzZ1cDNkQmdWQkRnY1VCbUtOa2xTWSt4ZkF1dk5p?=
 =?utf-8?B?enpnUGVsc1FwV0oyNWZuNDVhMk5TLzJseWs2YlRWK0ZxV3pUY3RwNmpYZWZx?=
 =?utf-8?B?em5TSTdTM1doSkdLMlJKTmtzREJROW9XS1JGWm5CbUtpNWFPSmVHNzRtTXFV?=
 =?utf-8?B?NDlwUjQyN1F5bEVGV0pJeE9iUXluOXpjVFZVL3RHS1hBb2FNVXJndXlEUkRU?=
 =?utf-8?B?RFczdEtkNitLdGMxQjNNamF5ZzR2TEtIQWhpQmIzQlR2UFRNT1A2NXdLU2lX?=
 =?utf-8?B?dndlWkhIbXhsK20yeTRNY0REWm1JbkZtSElYZC83WEJFcVhuUC82bUhPc2kw?=
 =?utf-8?B?UzJ2QVZJcUo4OVlkdVRUcVA2d1lJdDdjTTNBN1IrajExMnJoRmJ5UUdyUUxp?=
 =?utf-8?B?RU9ZMUlMY2Q1RHpYWG1nV1IzcmZMc05QaFF3MjJ5VC95VXgwUGxlbW90ZllQ?=
 =?utf-8?B?dUV0eExQV0pKTjczNzVtYURaWUV3QmNtVUdmR3hyYktEc1habU5aQUxmc1dW?=
 =?utf-8?B?WWJONlUxRXdNNVVGYkxIbmc1dDBIKzRFRTNKWkVRTmlpd0x5cXdyazR0TDc2?=
 =?utf-8?B?L2RzYTlyYzhqL2JUMUNFb2YyUTJCTzZwODJRckhxbnVwYUd3UHE0VGF1Z1lY?=
 =?utf-8?B?WGh5VGFkYzVGUUliNGkvd0lNNGxJYXNyS3dLZWJ0MmQ0d1ZEWllzSDF0aU5z?=
 =?utf-8?B?a21yL205TVBZTS9oZEpaSSsxZkpEOXErMjRDZ1Q1OVpic2pYMzQxOThPRktj?=
 =?utf-8?B?NUlLZ2c3Skl0aWIvYld4aHBVYTVUNE01eDUxV201ZjNvSlhWdnd5djR4akxJ?=
 =?utf-8?B?WVZqZjNSVXUrakxyMnQwSmdCaXVqcGIydWVpS3U3dU9UVlJEYkozbUlBbU9I?=
 =?utf-8?B?a0RTTDNCMnZ2Yno5ZnhrbDZpQnNxU1RWYWRaOUxaaWpjdTZ4d1IvU0o0UmdS?=
 =?utf-8?B?WjhITzBTbzNEUXhjVHdRVHcrWmx0dmFBL0xPUGp5ZVlPUnVieU1XaUxFWVAz?=
 =?utf-8?B?aDREMTlEbFhrZmVTNGc5eE53aWh0bllXV1o2QkpSSnB1a1hWUlRGbjVQOUpN?=
 =?utf-8?B?MDlvdTdQNzFiOVJtYThucGhrd3JzOUlVbXNuK0lieWhGTGNOTlVCcFJRZG5U?=
 =?utf-8?B?RzVpa1NFV2tYaktDV0dRdWpiaHRYV3RNeCtYSUNmeEYzWitaUEVUNUhUbExq?=
 =?utf-8?B?MUszdUJkTVJWcVFEaXVueFVnQVZqWnAxWHpRUkltaEpWbFR3bnl2SDhpSFVl?=
 =?utf-8?B?UVlLVWZ2TjVzNVhNc0Z2M2ZBak9HMUNncm5iaVdmWUdzU1c2V0daczA0Uklh?=
 =?utf-8?B?WUhNS0JqR3NtWk9TR0R1S0xCMm15TC90dTZ2N2FwNTQ0UG5xZCs5T2lSNWZx?=
 =?utf-8?B?ekJSelhXTWtROFM3SkpiWnhVWXR1QUFPekI0ODFWa084SUJyKzIwdjIvWGtL?=
 =?utf-8?B?Z25INmkyMmgrMWNmNG1MejVkUDE4RS9Eb2xLcjFNSExaRGxaenNYOGZ5RVIz?=
 =?utf-8?B?SlFtUTlYaGNnSDhOWVlTNUtMcjNqWWhINm02V3hNUTlVTDcyU3dPUXZZc3Jo?=
 =?utf-8?B?UXFsemVKdkg2NEIxK1ZwQThZbGppdnBmaTZxc3VRNTBiWU1ocFlQSVoxTWxi?=
 =?utf-8?B?NHFhNFhNZnBpVEJTUGZUZGp0eHRPckpqQzFVNGl6a050S29LN09Xa3pNYjRW?=
 =?utf-8?B?TUtPOXNxSTAxa3h4bGFvcUZNcVdJTGw5dUxaNzdCcHB2NWYyTHRsTWd2Vm12?=
 =?utf-8?B?MDFoTnpsTFVIeDcxWnFkSTJ4dDNpUDBEWitlc3h2ZnM5Sm1JRzVpTW5vbHhZ?=
 =?utf-8?B?VjRCTzB5R1ZmbzIwY2JKTmpLMGovUDNMLzdpWjhiYzNtaWh4OGdKZXArWlVI?=
 =?utf-8?B?aGg5RUFUUGVHamNyRzBwbWl1ak5VU01SZjVadGFYSlpaN3NZSzlsTjN0bTk2?=
 =?utf-8?B?bnJrdVo0cyswU3EzTWxnNVprNWxQektncStuMC8zTk1obEFhRmFXVzJSUTNL?=
 =?utf-8?B?bDhEb2NRRWh1QUNDek1rdWllM2RCckNJRlY5a0NoY3piYnVSMCtOU2YzZVRZ?=
 =?utf-8?B?TW1XSVRxVzRWYTBPamtELzBKTlAxbmM1d0RvVmNrVWdOYldnMG5LZWhoNXp1?=
 =?utf-8?B?c3NialVUdXliOW1LYzFhVGVNdDduRXJJanBrNUM1RXZaSmc2UFpTQmNHcU5D?=
 =?utf-8?B?bWFyYTJsTUVWZkRMdkNNRXZsMy9ScEhzdlR2ZTFyZU5ScUF4MVlOazVtUytI?=
 =?utf-8?B?SnpWc3JJRUhqWi83MDZlQ1lCK1llUkRCSTRBNElYMGJsTVhRZk8vU3VDcThx?=
 =?utf-8?B?RGJvMTNTK04wOXU4TzlwQ2dKdjluYW9qNytGSUxOYTdlVGlaTTdWRG44N3hE?=
 =?utf-8?Q?NutfdgFa+YPLUqvuTRc1jynZsK0Ng5G64nXhbDGuxQ6bV?=
x-ms-exchange-antispam-messagedata-1: 2k3N4g+nXuvMiQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tAec8wNZS+PSTHN4Unm5+kpP0ZUhx8K6A7BZ1qLjhFWRWbJ3h/RikdxforEG6IjDIr6L06zcboAYmid/UV86qNzX+DfIUT0ik4R6WQN1m1ls1kKN1qLVRHwVfcmh37NAHWTV5sLevE9PTlEvmhZ/0y42zZwVwOp0AFY56Z74B7VP2xFmm4sAoD6sMW95EdmdtgRa7cqgetDpXLbJok2/n5Q/lZBNpCBtLywJdf2rwYayl/6GBsxo82SxRfUqNNu2IsX4QnUEyX8vnHIbAdYCP7dVxaPxXdWQTUWJy/S+anHevmfk7KxJ06gP7ccbGU06fR+N4VlmjzbNr8/9ntqCvQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4a195e-e2ea-4f15-47bd-08df418361ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:41:05.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAevDM3xQhQ6bZD4cZppVZvnkLjfTSco9BW6oQD9GC772ehqTEDC6CYc1ZmuGhMHmR2SIR6yQEHBz2XZE9jgfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6956
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MCBTYWx0ZWRfX6b8idFmmEsER
 KkflcGYQiuM4u8eEVY0SRdF6toAedbP0d3qCqu/5OvXQm/1S/ld0Jmn2s5OiJPciG3rMXunAU+Y
 +Xg8+RvJ561FsUK0UKeNNBxNVjs91X07mufcxmgaKYpIcilN81fZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MCBTYWx0ZWRfXyYcDFdEQA2gY
 6RcvHUMOL0BECAFrPv8B8/2+G4QAGcwLWOPCu9daPubnn33qzKIjC7034BCFJ2Q5FJgFHdPz27j
 adVlQogWDqQedxNBJVCuwVbo/K69v4z7QmRgSxpPNDH3gWvoA5eBK8uil93A6wL+0d68l04iYiK
 fZIFRiBhoBmEbhKINSYwLY4DS+2LFoICmw/fRWVqbjQlbLXguoEz86PKicom8NcGByYHQ5RfHP5
 /kXWO9yRxaEM48p6FhlL6l0LZnhe7DEI7ewZOozrkxtP1XR82/F32YXpazkujBfwq1oKEVwD4B7
 EU2EgK3zFVP0/MqA2ky0vH4NaZH1aOgX+PNLTcCwPTF2qOD4aBFibobTetNo4zG+b/tYv4z7Vvu
 Zbo3Cjjn5nTq0pF+TUF12ko8wO/DWmJQFtvzfTd/hnJLYE1RlM5CSeNEzOX94qqvP/EbPjMu0qD
 xzG7LOTfQsdPhcMpJkg==
X-Proofpoint-GUID: uZ8QGmWRSXZVsnlFr4nngjtkrvVKU_f3
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6af70566 cx=c_pps
 a=jCeAeT6ZWnoYcCLLvvbvuw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=vsJVfKZZMOGeL7vXrOQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uZ8QGmWRSXZVsnlFr4nngjtkrvVKU_f3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130050

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAxMywgMjAyNiAyOjM0IFBNDQoNCi4uLg0KIA0KPiBQYXRjaGVzIDUt
OCBhZGQgdGhlIGRyaXZlciBpbiBmdW5jdGlvbmFsIGdyb3VwaW5ncywgYXMgcmVxdWVzdGVkIGlu
DQo+IHYxIHJldmlldzoNCj4gIC0gUGF0Y2ggNTogYmFzZSBkcml2ZXIgLSBwcm9iZSwgcmF3IGNo
YW5uZWwgcmVhZHMsIGRlY2ltYXRpb24vc2FtcGxlDQo+ICAgIGZyZXF1ZW5jeSwgc3RhcnR1cCBh
bmQgc2VsZi10ZXN0IHZpYSBhZGlzbGliLCBkZWJ1Z2ZzIGlkZW50aXR5DQo+ICAgIGVudHJpZXMu
IE5vIGJ1ZmZlcmVkIGNhcHR1cmUgeWV0Lg0KPiAgLSBQYXRjaCA2OiBidWZmZXJlZCBjYXB0dXJl
IHZpYSB0aGUgZGV2aWNlJ3MgaGFyZHdhcmUgRklGTywgaW50byBhDQo+ICAgIGtmaWZvIGJ1ZmZl
ciBmaWxsZWQgZnJvbSBhIHRocmVhZGVkIGludGVycnVwdCAobm8gSUlPIHRyaWdnZXIpLg0KDQpO
b3RlOiB0aGlzIHNlcmllcyBpbXBsZW1lbnRzIHRoZSBGSUZPIGJ1ZmZlcmVkIGNhcHR1cmUgd2l0
aCBhIGtmaWZvDQpidWZmZXIgZm9yIHRoZSBhZGlzMTY2MDcgb25seSwgdXNpbmcgaXRzIG93biB0
aHJlYWRlZCBpbnRlcnJ1cHQgaW5zdGVhZA0Kb2YgYWRpc2xpYidzIGhhc19maWZvIHRyaWdnZXIg
cGF0aC4gSSB0ZXN0ZWQgaXQgb24gaGFyZHdhcmUgYW5kIGl0DQpiZWhhdmVzIGJldHRlciB0aGFu
IHRoZSB0cmlnZ2VyLWJhc2VkIHZlcnNpb24gaW4gdjU6IHRoZSBpbnRlcnJ1cHQgbm93DQpmaXJl
cyBvbmNlIHBlciB3YXRlcm1hcmsgYmF0Y2ggaW5zdGVhZCBvZiByb3VnaGx5IG9uY2UgcGVyIHNh
bXBsZSwgYW5kDQpjYXB0dXJlIHN0YXlzIGNsZWFuIGFjcm9zcyByZXBlYXRlZCBidWZmZXIgZW5h
YmxlL2Rpc2FibGUgY3ljbGVzLg0KDQpJIHBsYW4gYSBmb2xsb3ctdXAgc2VyaWVzIHRoYXQgdXBk
YXRlcyBhZGlzbGliIGFuZCB0aGUgb3RoZXIgYWZmZWN0ZWQNCmRldmljZXMgKHRoZSBhZGlzMTY0
NzUgRklGTyB2YXJpYW50cykgdG8gdXNlIGEga2ZpZm8gYnVmZmVyIGFzIHdlbGwsIGFuZA0KdGhl
biBjb252ZXJ0cyB0aGlzIGRyaXZlciB0byB1c2UgdGhlIGFkaXNsaWIgaGVscGVycy4NCg0KSWYg
eW91IHdvdWxkIHJhdGhlciBoYXZlIGl0IGhhbmRsZWQgaGVyZSwgSSBjYW4gaW5zdGVhZCBkbyB0
aGUgYWRpc2xpYg0KYW5kIGFkaXMxNjQ3NSBjaGFuZ2VzIGluIHRoaXMgc2VyaWVzLCBhcyBwYXRj
aGVzIGFoZWFkIG9mIHRoZSBkcml2ZXIuDQo=
