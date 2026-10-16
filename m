Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55446C4A3;
	Fri, 16 Oct 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142502; cv=fail; b=F0rWfOAg7PZMeNHl6nAZmBXsxmwStTRwnPr/B6e1aD4opM+rU9ESHsYTAbIWcSAhq4oeb4t+4yTdM2dgRZgRHp8XqqfuYI2ioAlosV1cQiaHXxlhqrUF1S8HWJUVdxLflLTD30OS19GNFnGnfFF0UOhrdqxsQ+9Ji1eAIIedtxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142502; c=relaxed/simple;
	bh=HUhMAx3lnjohwxYth4pIoszDtrmw7y1ua16tICiYeAk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=O1ze+e2wP3unjkMDr9yczjjSkBPkvd4Zffe/m6htCppkE6cka19OWS35+ci4Xj69ETyz+05DyUB8VBY21QDVsWQWABvPvwLpXegRxpgKon/k9OZFbgUtyKqbUPHldmbze0SvBZX68cvvZfuUgray+t2beGrvUy+Es3nb6idPBQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=WiKNXgmT; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1N5b0tV3; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="WiKNXgmT";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1N5b0tV3"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G9CBoC3955326;
	Fri, 16 Oct 2026 05:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=rB26lWLNg/s9w38WK0Gdaz3v40baKKnL8UaBabT3BpQ=; b=WiKNXgm
	Tvu3dDz++dZZr69cA3krD7Bturc5Il5+hbE1btUPoTDITdKHEus2w2gZSTfl4pk3
	aYqcwhACRbL/vdD1885+m4pKeEiS9dg/0RLs2INkDYPNymdAaHkMQvccT4Gb7iFr
	bsCkaLtkT5q0OeBds7ZlmCoCfX6gJ8KqCF7B3QhoS/W/+tlcaJE421vrU3ecwf3N
	IUZo85KP4aZyKJLk7YvAF5AVTjXdCejdpfxRQJz4D37ln2pLbgrzVsPEiAQHDwku
	CHn2TYqYFpiEW/49ibqXiZAb3vQVvcUcvZl8rVYk1ldXco0pZZltfkPKKIYz6xMe
	CnsYBQtS599WdDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rB26l
	WLNg/s9w38WK0Gdaz3v40baKKnL8UaBabT3BpQ=; b=1N5b0tV3HI9lci5He01s4
	xNYtJnKvjwvNgxcYS0055M2xEwwAL0hbMzyZdi88HbRt7/LuIxVcTYrLtAv7ZnHo
	wpDfQAvIxlt1PMeTVGVcM/gUU67SQ+9MmpMacFD811/RPh7srTYD+MKlmVYSZUgU
	d6yL7I6FfMCYjMbYaiyWmYuT/nVBzzmTrQDggzgz24P7m0+b06p8ShHdcQRUG7yC
	sIoqTR4IteqrQe9SipaOuZAOLp0Ua8+ePc82o0tb+C7cd07bRzEHkTS1kQtUfVXe
	M0kFvjxPEvsnVryveC3Ca7UbfyKIGKwv+mClgtp2FzHzN/lm5dckU59GfF6wz6do
	Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hb0545r74-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 05:21:29 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqEzFE+VwD2ghgZ1kFVSdYXm2e6RTOfv6igYukqjEmqFOeivJxCqtKzsIj+AGvsWLnxG0BG85Gs8DkF5Y3EpDuRmXIdd03a/oSgNX3ib53vNkhdNq3Z61sblE8sbFakYg/NGT/GU6yG2uGu+oF+OyAcBSPj/3M8PL4F/pC/cd4rU5iS5iwD69gprZEGubIdCcrV4ZOQItBBNwh+U89AIYCD9L2l9ft3AJHQeuJPOQ6AfhtZ38ACajuohkFRjh6JgGQJZrWOQ9o3GxYPH1azcVJxBVWHyqxmw3hTVSSLz8DiJZW5ZcmiQolJMarC8IC8qldLIQLPKlG2GcR6OoSO62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB26lWLNg/s9w38WK0Gdaz3v40baKKnL8UaBabT3BpQ=;
 b=gb7uoCjgz8szex91Iq30pUp2VfWgt5yqDoV2jYbVJa/CXrkJsfh/0Z8fjuQmSiExrfechiJk17xF8iJeD8Hc8OvLM80MSjSZplkJyTb6GQNKyJMs92Oa8e2+MG/zrME7fZ/dZI8xm37JA9upGQXXkNDll94AclhFGSIs8viiIgF2Ydfc9rI+zl0a7cad23PONGgRY1ngLvvgPvdRaVWt4ZgXoHEWeLwZSVqOtkmBMNr5AHWmmfMoEP0ZsZNTZQH2dUaGLE8B419Q8S7a76pCl6Q/KIUOucmuM6UiNbCT4Qf9kECDr/5kMmOQ1n0+/RmDhGhfjaBUHkrzMZWJGwRoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB8138.namprd03.prod.outlook.com (2603:10b6:408:296::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:21:26 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:21:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 05/10] iio: frequency: ad9910: move channel indexes
 into a shared header
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
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
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261015-ad9910-backend-support-v1-5-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-5-3c21648c8e26@analog.com>
Date: Fri, 16 Oct 2026 10:22:34 +0100
Message-Id: <179214255493.3322.5425554476369548910.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142556; l=530;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HUhMAx3lnjohwxYth4pIoszDtrmw7y1ua16tICiYeAk=;
 b=Pe9CJ4/A507JFfqvrtSZsTGqVwvTSTJMQI6bGo6BPP81g7KLDb/qwa7hho1ajUU0KqHIDLf/T
 w9aYXcODqeACzSdig0rpfk63pFrIB3PT/OH1CWeWCvz32N7gZUqOj66
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0195.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fbecce-e3a3-4f7b-a6e4-08df2b66da6d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 1AI5R0i0TQ7T4J1MWdtDEyoQBIGh8jNrxtArAvmQ4NDJPvmv7G0VdeztQ62p3Ma7FGL96BJLMzipKbtCQKpS+H5XmQ0B5L6dIBpaM2qTKEo3pEwjZ9YaEBMINR7i3uVM9q50blMnk7pryGeEW8CntMyINXTDuTWKiXOh3TmJ4Q/oFAePJdDfXoj0zbAYkINYdPyUxN48KvXBPtvgLCfxlmRaeB4tlaO1klmak1bzyC8QrpHr+c6vc5ONUc1ohfvbKIv02nCoTMrmGDL2xrgHkaM1OVeWdNTt7JppsAUKcbyXhPL+xogMQOJIfVJrXI/qimQ3BGogMuXLHa1F4SHj+Eli++clSyH2aMpqR9aHkFxjvRPkMBneuwPVJdI/iAK3V8t2kBFtOXJMXbFNtJtVnbFE7wsPfRlDqWn2hGDahVk/5PQ6VjTLrUCvF4bIS7OHPOQUjA/3QKnnneI8S3IIeBbVVix7hALxfjSRtR2MzCVXIrMm6f1lEOJV4H08Cru0A2H/8tL+0waZUUyEpy6PY8Jv9EHsyCKSvDeQ7Lz+itwJD8ihQsV6EtJGbjskWXUPbesM2UZp5okiQ6Xjk7N17Ze85xfsU3uwv27c0oNkJUq6ehu6/FgvIwueol9pFykyo4wIBk5uDSMA9lW4khwst7pXnbCW8fXpVhyfYuBH+zs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eHlKdUk5WXo1WEdiaVBTdXA2dS91N1Q1Q1BUZm8yUDM4bTJ3MkxYVlNZdnBK?=
 =?utf-8?B?QmJ5V25aWjZXckVmQTZwejFQZzh1ZE5TTWNtS09DK3dubGNPY0JqVUk5TE54?=
 =?utf-8?B?ZjBldVAySHZBOWsyRlZvMGExdEoxZkpvbTV4YVdrMDNXV1pxaVk0Qk5OaGZl?=
 =?utf-8?B?RmpJOTFkcXVpRnMxa0dsZGdxVEl5d0pob2ZhYkxHcWliZ2ZmYzhTZHZ2TWtN?=
 =?utf-8?B?cC9GM3Jna2xSR0hwbk54ODVUUnNwcFhNWGc0b0czaWZQeGwxRWMxbFhLM1FG?=
 =?utf-8?B?VmFheGNCbWlqeFI0TzREdVZobkpkQXp6S0x4Zkt0b1F6bGFLdERGNG1HbXdh?=
 =?utf-8?B?TE9KS3ovMEJTMFpuSllRWXNmbmZvSmdKVUxzR1FzaDRlc0pOYk1yRDdiQTAr?=
 =?utf-8?B?M2o2dW8zbXlvdWtVNFRNWkR6aVVENzRnVFRadUEyZGdkZnk4bUsyQ25YUkJF?=
 =?utf-8?B?N1hLemp0WWdJWFZnZkpkZ2ZaTDFHNXFrR1kzLzVxZmt3c0w1Z2dyY0FvSVM5?=
 =?utf-8?B?cWZNdjhJVGtwb2ZHNURaMnE0U0I3eHRMVDFQR0lSMEk3QUxXczRBbkdvMFlk?=
 =?utf-8?B?cXI3eVBRWGFyNUN1WlhwSVozZEFDNm1QaTJlN0xTb2pxaE9lT0JjY3pFYXpz?=
 =?utf-8?B?LzBuaWpuVnNNWE5RUHBJK0ZHWXhMR29MUjhVelYyTDVsUm0zY0tVODZDaEJH?=
 =?utf-8?B?cnBVZlZhd084Tjc4RUVoZnIvTGxoazA4UUNSS2c0VTRpclkvOWtVUERRVGN3?=
 =?utf-8?B?RGs2aUtkb3NBM2R3ZW9qM2Y0bmRWRVptY283UFRkdEtQbzljSDB3cVVCY1F0?=
 =?utf-8?B?aDhuUGw0Ujh1ZXd4RVVjclpUbUZzbVJPcVlQTVU4c0lXY0hyUkFDTUxQUHBL?=
 =?utf-8?B?L3c4VmY5cEtuRkRiOCtxRndLREZYV0F4T2VMOCswNTVUVXYwZm10M2VmRERU?=
 =?utf-8?B?cUxlWHNlNEJpcXBTRlBuTGxlRkd6MFlwTDQyNnl6MCtkWk9aRmpVeUhKZ3Ny?=
 =?utf-8?B?VmFUNWNEV2NSbXpuMytYaGVnMGhGSkhJNWdxazY1UXNJaDBubmVjcHpTcU81?=
 =?utf-8?B?YitweGF3QXVuaHJDUzQzUDlrbXdNNkJkRnI4cTh0cjZoaUQ4NzZ1QW55SS9I?=
 =?utf-8?B?Zno3Y3BvblhPZG1zS21jY2pIZ0JmUVV6MklsYUM5Q2RYTnk1YTJrcVdleE5h?=
 =?utf-8?B?akNBZ2xCUGwwZllUeVpjRlBkazdOUmtVTTg2ejUzeFZBY3ppZEdJRVVncXFk?=
 =?utf-8?B?azJveGJJNDFrTE5PRWRwWjRzWDNYR1NBd0ErL0pXcU14Y241OW1SelJza0Rn?=
 =?utf-8?B?Y2JDWC9rejlYdGF0RW9OWWY4WE9PL2dmeCs2ZnpXRW53UWFVc2dWcmxWM0Jz?=
 =?utf-8?B?clBPOGN4L2o5SGdyVmFtUHRmUFZhRHhtVk5RWlFsNFhzUGpjRFFWMCtXaGV6?=
 =?utf-8?B?aExraG4xVGc1U2gzQU5mV1NvU3FyWHQrN1g0RE9Jb01vV0xuVDZ6Smlmd0Za?=
 =?utf-8?B?S3QrRmJvVlNOM0pLWDRrVnc0eEd6RzBhMUV1VlFienMwNUxoYThYbG0ydkJF?=
 =?utf-8?B?VzV3MTJDVGdIeEJLOS9UT0R2VGNFUHR0WEhMeU4xMEI0SkUvQmhGaUdrMStt?=
 =?utf-8?B?cVUvVEJ3b3FGcEhCa1E3TmJoL2NmbzJwRUkvakorVDE1Yms2a09xbnlqdXNi?=
 =?utf-8?B?dGNHVTUxSSt5NDBxNGQxUDNpRVAyNzBZazdwU291WHNINUlpQ0NFY3FMeVlE?=
 =?utf-8?B?cW14RXRjODU4Sm5keHhPSmJBL2hoL0wzVy9jUDVBQmtGV2dOdTh5UVNKcXVV?=
 =?utf-8?B?OGJ6SkNjSTRZdmdIdUo1eUV0L256dkxHM2lqUlRJSzE2YnlZdktLYmFTSW0v?=
 =?utf-8?B?QUdHRm1BdDhKRHIwOHdFUGVSSUVpQVpHbkNZRERGVXNGbmQ0bG5nZngxMXRi?=
 =?utf-8?B?UlRMcnExS1FNZDFGeFZaVGxaU3dGVEp0TDAwOStGV1BVOThoL2dKUytWdzFo?=
 =?utf-8?B?MHpDdUIxL1h4YWRUdWI0MitFb2xUc0lVTWs2QXF4WHhsM1Q5S0Zhc2xQY2Yw?=
 =?utf-8?B?eHgzeitMOUNqSjQyd1BMQmd1bDNrM0V0OHU1SDR6SCtKa3FWT1AycE83N0lC?=
 =?utf-8?B?RkV3U25Ea09TWmhCVHQzNnV4UVFpWGpTbU52SmhKMkdjb1BTVlMrZFVCOTF3?=
 =?utf-8?B?SXY1ZHE1Z3FFTmYvVjhQYjdGRmhTZ0tNbHJxeDUyQkJyY0wxZXNLVkY3Vnhh?=
 =?utf-8?B?Wm1RRXhvdVY1cW5veWpBZUZRcmdWZ0Q4N0E4QTJWZGFqRUI2dWFtK1lJdzJp?=
 =?utf-8?B?Q2NQcmpzMG1rYVhuKzRlWTJnOWthSk9mY3RaL3JvQkdVOERRSmZ3dz09?=
X-Exchange-RoutingPolicyChecked:
	eziY3l7qDllImR5aWqHvkrrWyG+rWR4AU5/VIV1X5Ar50GUrIYeymW3DzUkKlZAh9Scv9bgsFbD/5Z2LS069X8gTpbcFB2AvD4AMALSgjOQ8lo5RqMxNNdKFEWekewyT0O6bPp/n6nyUpw5NHUE1s0JEyUlcX82d6NgGTGL6aJrOtlqIfZRU6MDIBgYJiY1cvTXMFf7x4lMrwKBIkmf4CpXGsP/3T4rcyWd0BuE1VnNfuBqxCIL2NFFbTCHOuK44XLRThmAU0xkl+i1U1AHs78Jf0yxPFSG79xvfVVqeVNA8wtFIAzFqh4yrBv4W8yBEcn8S0vDJTHMCMh32ANQlwg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fbecce-e3a3-4f7b-a6e4-08df2b66da6d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:21:26.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hckuVrsAk+YTpL73Dxl9awpE0tQk7pVX5nttES/8ttgMFDZErVuC9Lqfo6h+XxovlS+eHFqO1tS5YGfIvI8Kkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8138
X-Authority-Analysis: v=2.4 cv=Z/F5j3RA c=1 sm=1 tr=0 ts=6ad1ec99 cx=c_pps
 a=vqIpJ22NDJOYTIB/W/KhXg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=0s2_7evNjul7huNlJNsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfXxE6PhtjRWWHc
 EBfeY0kSACgTh09/9Yw7XGS/OsG2fu/m8kuqe28Ac9Z0hizg6cetCjAOPQ2/npzPw5JLHg48q7i
 Z9rM8t6s+DH6qEnKu2R3ZSnxBL+jhFVr899lZHaOVwP+FrZzL+XyHES3tPSPEvcOWPKdd66C0HV
 hhH8pdo0aae3eWv6cGkwz1LgtVBvWabWwDZEZx/8G+zpfuhxFGGfmC0t5m1Jb42rnSIHmYxxRha
 SwJL0g0T8n5pCn0dO4gwNqxVbpzMIRM7spd9m2elc2PoO9mAsQeoQbLXWwD4hhsb96wIgSZxo10
 Ggy2/yIq/cWmnRy/GIByXIYbXaVRY3urs/4tnJK/lhONbZBmpxuOJ1sbeoW00mI++aE4ixXE03s
 EPYqCidwnoecIuRYL1BG+BJ8uyskqmGOg22jiuXML0+6KxfY60g4ooXIn00YXoxk9aWGs2KNACh
 H07h/ypvfS2zOngswOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfXy/X8k0FNwR2m
 dwD/rpnEk8mKV+3dl/y6wOY6OE8vwV+EWfsqucVUQoFqteFyMk78kaTnQW3Z+vxBZE5uVzRbLbm
 OdGRct5VNk3Iq3Kwhk7zwR6aK7jv6aP/sKagcN2Ro2gHy6KPmLmb
X-Proofpoint-ORIG-GUID: hps3m6hTST26mvJcjyt9iMiqgkeOVaz4
X-Proofpoint-GUID: hps3m6hTST26mvJcjyt9iMiqgkeOVaz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160037

On Thu, 15 Oct 2026 13:49:45 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> The channel indexes are used as channel identifiers in IIO backend
> operations, such as enabling a parallel data port destination or
> selecting a profile. Move them, along with the data destination
> definitions, into a shared header, so that the frontend and backend
> drivers agree on those identifiers.
> 
> No functional change.
> 
> [...]

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
