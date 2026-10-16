Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E64AF9EC;
	Fri, 16 Oct 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155671; cv=fail; b=QhEB1YEXZ6OAcqSn3hBAwhnhBnTMf6ur7o3fHfSwPEEmccswtS9Babs2Z56mo+shrdxnFf3HfL/SWsyAdLF5TtilgF914cgaDZpnJPA9jwelvsP1Okmc4+pkYk8l5FC86GgN9emu3P3cLDYTzINIBuOsoQA4+VNMb5ckSKjNTGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155671; c=relaxed/simple;
	bh=16GurH2tYpM0kZrPsd2O8yEkXHy/Bm178dTXRgR5SKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1xoMcBTCVmuZYS12Fw2OvzybLNEG10Hlu66RglrWkalNlGv4hLbkodMc0L62690uCoj5xnHN12xTJhQWLohD6V4RJS1o++6m+d94+h1r1TmzOsOGiPxiOxcTd00k/xn+fmC9kAin7wDEqQGuhs37NfArtHgy2Z1tPvthb0PD9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=VtO4bmSH; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VxkZ11Aa; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="VtO4bmSH";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VxkZ11Aa"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAD15N1113446;
	Fri, 16 Oct 2026 09:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=vmKoySo9eMiMeTv5phPgY0sBuf21BNplL2HW7n9Mayw=; b=VtO4bmS
	HA8klduOGdCVK0MFuWqB7Ip90b7STf5gOgYYBRKQHhX5vHtBu5lTAVl4SvuR+VIJ
	O1LGkke9NheuCwKJwHnWXLqP0KqkiwlWoVX8g4T0QaR9hzSjvri3CP3g/jyABVJ0
	ddrU4vPgJjb5JtUJ5/DFjDhtPL4HAuSGe0frUYrg5Qr4ZLbUD8X1H43nCDHIqYIq
	VjlAHaqZ8Dwn3QzTdy97dAvRRtkexb1j1cTorqdlcw95OtLu0NYl3FQQIn8WBGOh
	FubghIM0Rkw5nwJIkb54M8VujBaH3y1NMlJZ0Y61KeVXPkihIHVC6XPSfN5gYAsW
	IcNGPRZlH9wXLOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vmKoy
	So9eMiMeTv5phPgY0sBuf21BNplL2HW7n9Mayw=; b=VxkZ11Aa4LOsC9w+ei2WC
	+ksdelQYSF3gzQomYV5BuR9718k1DZTARDpvkNxGRqazwn+olORBoi5d8TjIY7Fj
	lQhUn87uXaG8WceICfChJnY/3kVkdsGcEpG7mnupDp3YXganHok9IN6GHIHMHrMF
	FvgHlay7KgqgHTER+mIbzR8c4yOu8LjuCPOMzVXhvlfFsNsR3pXm1cNOiCV1A+ic
	cCs7H8/0PHChaLuPMCBqJrjnhxjJ+qZf34QW8YFMYMb01qXhQq8rho+yv7ll4r3L
	o9EE8sDRO9FsRaaRnuJhBhMlSM69S+IZqazBTPSa151Pn9toFYWtsSYY7CK4O73K
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hannda78n-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 09:00:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jB/HWWoZ+uMOopSJQOZyz74I1MalaC2orNRhs6h6SlRlzrh312raD+a+6elcgHASJHVb1gij79H/eG3y1TN20yxGRcd76HOeuGq5djHAECJMQzEx0+xyqmNLJwdzu1Obpom6/teR5PUoQGcF9jjZ5Hpo5Fs5esEppRApFeok20lXjStL5ajPv0qF++ZsP57pesIlyJiCSzmuv165VBu2LkrQgizG++NstqSLrx2EK3cvkpUoULkxvWPOxlRKRqpycuarMXrhD7wazH8h+xzroS3C1UmcipQLslpvZTvp6wllfHTMDdzRWa2NeZwm+wUYvYC+rIHmmiDhonxlrs4DkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmKoySo9eMiMeTv5phPgY0sBuf21BNplL2HW7n9Mayw=;
 b=xkZfZNqqvlAQfwwccPhMo+jO108BA3fBgozVtxVctDWH6Y7YU9q3ctLfS6toKapYAFw2walXhLGW5YJbQtyAVmPC3xl2zly/zWq6UKCi+gYeWgHTPgAcuagyYjWFkEd6V/9Z1pofpPj7LBzsIR58xgueu9tCaqR99o28QV4sGdwETn5B25ePs+RsgZ4MWqg2/Fr7uLpItlqMPGl/nLhJcotbzJRn3vp8cPlhV3lCVCvKE8rlo78YW9RohxKkjo1nkZoP2voWXn1JPvqubhtvfeejNSxIoVOfsAz2ljF3b69pH/kltFUCXPzn575/EIRBjujtSXuL2+3Mku+dEGamsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5648.namprd03.prod.outlook.com (2603:10b6:a03:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 13:00:42 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 13:00:38 +0000
Date: Fri, 16 Oct 2026 14:01:59 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/10] iio: backend: add devm_iio_backend_get_optional()
Message-ID: <atIeAJPYyWNfYU7T@nsa>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
 <atEeZPOLASHAcnjF@ashevche-desk.local>
 <atHjHqyxXj6jkObW@nsa>
 <w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
X-ClientProxiedBy: MR1P264CA0060.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ef850a-4a91-4b06-4ff3-08df2b8579ba
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|22082099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 zbYW8qV19ia5wrDw7E2Na8HchsX/EX8A3FR+OaU6IHV2TyCMUFVRDugKbknGCwNgDO6FjDygQC4WVYG4F4xbTHYMWMygPcHGzoCWT9AzfSgr6Oq8d7+3kZzITGU+OAHhpHBZmVk7kD8DeN0SomrEFpGNWKm4UiUu9uO5WfAwHaYGPjkQZ+JfDOuR4T3KF8dtsAs+Fjaa8gJAA60SjrZtimKcfs/68c5BRVCDz7PwWLAxChN9NDtdJEPfOIDlk2DTiek/CssLZC6j88YNoqjQK2ihfN2jv3dHPYej3M2Ewp/ObRzt2gyk0CrF02hDTid1zZph5juJyCQwfSEWQLaa6V4SbP6/V2UQcii3LbaJoLbFogRuM+LZ/tC+xCPY8SmULXzaCBjzXV24b9WJgZLufYpz+KDw8I+x9tNceL4vumgk9AJICpp0faMhr3SDnkigFvSv48IvYHvdYFnlk3NubTCt6YPzwBSSr/6cB/WZTqX7QMD7fI+U1WkG/7r3q360pBd5OqWCuVpo6sVpORCqd2snke14rm//y0EeP8PhF6csPsFzP3B7+G8h2LUIJJhCE2pr6r/atzQJPv69iZ47jv+ZhvWMARuN8mYSXXzfu3fPzB1Oe1Dba/V+67hLXIT5wmVZSZfS7HBM8OX9yHsfVTZP6b57nIDHkFHDpiCVjJI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZFRWL1l3Ylg4U01nb2N3T1VrRm1Xc2RzRUdRNW9wM2lmUjc4ZE9LZXVrcVgy?=
 =?utf-8?B?VHljNjdidGFhdmIxNmtXZVI3UFZQSXZPYUxjMUVQdUhvK1hlRGxmQXJBMVhJ?=
 =?utf-8?B?Rno2ZHp3ZXRMcWFia1VVWElReDFkeGRVMmFuV3dUd2lwRDZOZmxxdlpQelo2?=
 =?utf-8?B?aXZaNWVCeHZDbk5UYW5wNUc1di96MXhXdVluNXJHbG9Xdi9jamh5RCtYMjIv?=
 =?utf-8?B?N3VLRFZJVzNERWFVYmIrc3piNms5WTJaT2JtYzlwM0ZKVmt0ZVZHc1g3TmVV?=
 =?utf-8?B?bDQ5eDFlY0VDbmZ6dSs1ZDhXMHhqYzhCbUtiVDFwNG9sUFQ4dUZwaUZ3bFgx?=
 =?utf-8?B?QTBVUTlhTFpKOTdIYjBOWGN6NEw5aU5XRTA5RDZOZllkc0MydU9pU2VsMDhj?=
 =?utf-8?B?cDBrNUNadGhvQ3VIQTN0MGxodGVlWUxra2J1SFFleWRGRXg5b3ljdUkzbEVq?=
 =?utf-8?B?OVNhTDYwVjc5YWRIWDg3K0habWhpYzVyWG8veFVPTXBIdGZadm00cG53bnFy?=
 =?utf-8?B?U2dXU2lBSE9wMldDRFYrRCtud3RneXpBR01yZ0g2OEpEOXZkVTMzdCs3bzlu?=
 =?utf-8?B?aG5XM1dQMWlCbWcxbm8rQkY1STVKMXV3bFh1WkNYZHNPWWxMVEdXWUd3VExw?=
 =?utf-8?B?WGNFejZRM1FXRlJHamY3NW5iMWFJR3lPM1RqU3dvSTVHd3dzZHA1K3hLbFZk?=
 =?utf-8?B?T0ZwWDgvQWNReG5yelVpb25NbSt3NHZQLzk3RkY5TEovU0t6Mk5JUGcxV09Y?=
 =?utf-8?B?S2g2RU1KRGl3VlE5d0NiczkxT3FQeUtsYnJBb1p1S1BQOHJ3UUs5WUpJcUN3?=
 =?utf-8?B?b1NoWmJrL2xLWnF3MEN4c3ZYeGkvQTg5Ym1rc3pzTStBdnZCazJuOFVHK3gv?=
 =?utf-8?B?NExGSVZnUmw1OE1tWENwUythRk05WWpzd29Mbk5CMWNadGp0RjNCTXNIazNO?=
 =?utf-8?B?eElzV2xUTzBXUmlmY1VMVVZueDdHbWEwRzRvRnFFNXkzNzUrbVorMnNvd2Ru?=
 =?utf-8?B?N0FSZ1RsMmdKREVjdWdwU2oyeGdja1NneWdnQkVncFd1TGVMdjdJb0hqS2dG?=
 =?utf-8?B?MEdmcEZZcXVRWE1lSktGTWF2QUFMMWRQMzdWUFhxMnUvcUw5c1ZnUHZockhh?=
 =?utf-8?B?YkIzQ3VXdjJZbm9ScG5nNlFxLzEyN0F4THFFMVR3ZXhLK01iZWJSby8xSXNa?=
 =?utf-8?B?d0Z2amUwNkdidklxbkNwa1JEM0loQjExRTR1QmprNUZpU3pmdDl4cTRQaU1U?=
 =?utf-8?B?S3h2MGhFZzFLZzAwOXBkVDBtYVhBWVJPM0dNM0FsdDI4V2JnTmRDUHliQkpO?=
 =?utf-8?B?TXFRZFFwckhncEF6ZzF6Y21YV0swSCtjZVYwQ2F3Tmx3aFlEZCtKeFRheTZT?=
 =?utf-8?B?V1ZVbHEzdmk4Y2VQWjYvU0R2T1ZpVGdBMTdKcmQvZ2ZRVFlCZlpNUkRyYlhL?=
 =?utf-8?B?VzVQakdjZklzbXZpQVhSNFVYSXJuNFk2WjgyQm9xaVlUSlpsRzM1SURCNlFU?=
 =?utf-8?B?SnYvRTNQcW1CdUZkVVFsTWJZTDRIcDVFN3Z4MDRnaDRlTjI3dXJHNWJBeVk5?=
 =?utf-8?B?S0xZRGRYVERLK1Uza3RPUkFrNmdKV01zN093NkhrMFdUak1OU0tBVGtVT0kz?=
 =?utf-8?B?WThZdTRsbFVudm9yWE1JUkJabVh5Qjc3bnpBbmZNMEhKd2tWdFJWd0tPRW9w?=
 =?utf-8?B?SE5BYWZGdkRIWE43RHVmUlhaREVSeFBRbldSeGt4V2JWTllMcjJrUVRlNDhh?=
 =?utf-8?B?WEw5YjByc2paMlgxZzJUSi84aWJsdWp2S3VEaWhIeTMxVXlHckE2MnhlMklS?=
 =?utf-8?B?WVZqREF6WXFzZkhPdkh1MG5VM0ZVdmNOZTRQT0tOUW9aWVQzdU54MzJBWDg4?=
 =?utf-8?B?QUs5SmV6d1ByTjRDdDZhRWRKc0NHMU1GeE8rZW5wWDY5QXpjbkJvZUkxd2ds?=
 =?utf-8?B?TkRWNkxaS3pNdFVUUmtvbk9ScWsrMXE0WVBoRVR4aG9pTGl1THVnRlZobTJM?=
 =?utf-8?B?anZMZmdXSkd5a2NFUy8yeWdNNis2Rm9TUStaVmdxdE96NjJsRlliOHo3SlBU?=
 =?utf-8?B?MUJrcGpsK0lFRmhuSnJvc25KNTBtWFI4eFVaekdsa1BFNVEzcmJnK3IwTEZ0?=
 =?utf-8?B?ZEdOZ28ySWFXZXMyeGlYaUhJTDJWeUxDMnZNUUdGRC9QZGNiTWRCZDdlQ2xM?=
 =?utf-8?B?MWwxWkI2SWtCQ3U5RGFzWUxmMW1Ua0dteUw3VnFBTGhaSU9qWnAxRWoyeDgz?=
 =?utf-8?B?VVNDM2pOT3MvTU1GWDlNanBtQVJXaWR6aDdEMCs2Zm9qSjdSOVlYc0oyYTFi?=
 =?utf-8?B?WS9mRTFHMVpLaHFPSDFrcEkrSGtkbTBSdVFFM2F1V2ZoRHVmNlZRdz09?=
X-Exchange-RoutingPolicyChecked:
	R0FSSTclVK8x/be83rZXW2cXCWOuY74xhl+LhLI8FCdxfgJHTlNmVBBN2+2DtrEzKFYXPru9g6+XejD+e9HlQyDcQi9Am9rqevoyBvM7hAScrd0ohNibdr7n87RdeXDbpFXVfqxeCd7jdc4bCCHoYyzsGTcmbs0neR3ea1E2ytIekp20lNXrZl6ouOABqQpLcZarhgsYlRSxyP2BREuEfAh3NRn8J+J90RfSUl4kG6ZUGwSf05JbgsOPX5glnlEVRsG4WITiLrD/fbwADRV6ygyk00S5zgE2Jx9YAGDM/hvCoNH1puk3p42TxO1jGSkbykNpSB60berc2HTYqEsxHw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ef850a-4a91-4b06-4ff3-08df2b8579ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:00:38.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruB5lgNp+/wXoDiv9iVjFFH4TSBvRWuWC3JmYoJXtDmjPfJx/S66zY13WbpHWEZTqYTFlMOOqJjQdYtyAWovPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5648
X-Proofpoint-GUID: AR32TmjmJmkk8ps56o77-SF2x5pelqiz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX0+vcm4v1C+yd
 Ew8geMSqF4+Qk6vq1aeJfaycgrNAoVK/wEMFn9NYjxmZSwXu/mHVqhuInLISitvAH7XFfJl0fd/
 gAbuiQJyf+Ar2j7EI00rW+SGeoEeU6aC2SojudXLK/VfCfIJoPSh
X-Proofpoint-ORIG-GUID: AR32TmjmJmkk8ps56o77-SF2x5pelqiz
X-Authority-Analysis: v=2.4 cv=YfkodARf c=1 sm=1 tr=0 ts=6ad22000 cx=c_pps
 a=m6tRWrYHdetyOVyhMCHtWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=Dvw26PApm-w0b8KNnNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX6Kg7ybvhkOtU
 yzGH4KQYvKApMbRHrDWBjFVP+Jbph5nCKkmMZhufKPcnVph7DeZJESECZbQSu5isN2tMNfaRY6p
 H5JmvIGnShUytp/P6b/13iM+rG37sfFgJmDlZuaigWCViUfp9c1a31L6RuplspfWERjweH617xl
 tOfuTMV/33zVR9ksvAwKufNYUOcEglGP7TPaEkrxrkHglp4wo9bzYHiKBzyD21XRAwr6GotlLCx
 wsz77zF0hoc+RpmF2FQZoRdy47MjsI/2/jAGoysqgLF33KrOIAEOn3rauaUhkHVBFX4IW/FoPAX
 2qrxKJfy7WBxuAy4lG2Tm13U+vgXNL2f+rXBpH/PZ48LQGL/EWA5tohpvUT/iWXnY6PSmghVlR4
 ncE2Up5AFOd1V823NYz/BsCLUhqJ1ND+RkZiSi5NicE4GrAJx3X6p2oYryGnJ5sunXP3Mg/KkrI
 ktbhzETF4SMFlIy+a+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160051

On Fri, Oct 16, 2026 at 08:18:08AM -0300, Rodrigo Alencar wrote:
> On 16/10/26 09:45, Nuno Sá wrote:
> > On Thu, Oct 15, 2026 at 09:41:40PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 Relay wrote:
> > > 
> > > > Frontend devices might not need a backend driver to rely on. An IIO device
> > > > that supports backends can behave differently when they are not available
> > > > and that should be acceptable. Such parts may provide basic functionality
> > > > solely using the control interface (SPI for instance), being able to have
> > > > extended features when a backend is present.
> > > > 
> > > > Add devm_iio_backend_get_optional(), which returns NULL when the backend
> > > > is not described in firmware, i.e., when the io-backends property is not
> > > > present or, for a named lookup, when the name is not listed in the
> > > > io-backend-names property. Other errors, such as probe deferral, are
> > > > still returned.
> > > > 
> > > > To make that possible, a named lookup that does not match any entry of
> > > > io-backend-names now fails with -ENOENT, the same error returned when the
> > > > io-backends reference is missing. Also, the missing reference is no longer
> > > > logged as an error, leaving that to the caller.
> 
> ...
> 
> > > >  		ret = device_property_match_string(dev, "io-backend-names", name);
> > > > +		if (ret == -EINVAL || ret == -ENODATA)
> > > > +			return ERR_PTR(-ENOENT);
> > > 
> > > No. Please, use device_property_present() instead.
> > 
> > Oh right! Totally forgot about that internally :). And it fits into my
> > internal point where I don't agree much in treating -ENODATA the same
> > way as property does not exist.
> 
> Say a frontend consumes multiple backends, but some of them are optional.
> If we care only about the presence of the property we would fail when
> trying to acquire the optional ones when the required ones are defined.
> am I thinking correctly?

Hmm not sure that makes much sense (I mean having optional and non
optional backends for a frontend). At least I'm not aware of any
possible usecase we might have internally. That said, you're thinking
correctly and it's fairly simple to accommodate for that today. But
Andy might still prefer something like:

if (!device_property_present())
	return return ERR_PTR(-ENOENT);
/* A comment here would make sense given it's not that clear what are we
 * trying to get with the below check */
ret = device_property_match_string();
if (ret == -ENODATA)
	return ERR_PTR(-ENOENT);
...

Personally, I'm fine either way

- Nuno Sá
> 
> -- 
> Kind regards,
> 
> Rodrigo Alencar
