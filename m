Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695897;
	b=pVHKd87P531l1hBEVMYvnA+wq0RN2IncDQEpw6rMwGoiPdMsBO4yFOEX19YbabJJTgOv
	 wUwHiuJnZTdn2e4FqTvuhr1uwK/9Kv5sj3hXzAM5w2IBfSJHxIbTt9bNvCBbSz6aYaUES
	 WkDl8EoDJgRYrGp69FPObakzJKQlZml+PqcxNb4HEIYxFWngC0MJplcFOwAJd1QIFxlF2
	 RcStFs2PE/SpWS+P0q6VFwtgq6k3WywoRIeWeFwcVT+FtMy/IPqbdZtEjLxV+6QVSZrwZ
	 mzcrt8JSO8PyjTtqDWnZYStQM8/V5H28yV21awjtxQFRQetr9PJzz42/41DVaC5P67Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695897;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DQIHEbE9ItlyHVg5fezp32wK4Z7EUc+dJ4oko6If9zU=;
	b=b0CwCM9g3PiD3q8pZ/ygE5SHpBR3G7J5jOL3Ip2mzkk7G3wxyLavZCUclOslQpJ8jcJo
	 NF46kvTacT2ri79PUrhE91sluLnm9Cp/KQF/vUEs/dPiz/IZgeKTqjxkGOCOaHSnIArq+
	 ObayE/0k2PEcSsdVAY+VcWrFYk0mHqQ89TAZlMVjWHcAX2+RJZRf/enLpj4Pf5TxZ5bND
	 9IgjBmfxTUTg4MPzUKtOixjkCSYprg0flKdvQyyruwsjPucV3T4i8jJ+Ejib3k2rJirPX
	 bEC+4JIc4kTuQoM5iqkXTK0mo+Qtk49FsnK3GSmO1dxSilZulmIhm47eN46a1dupFwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JOyKp83l;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="W/EiocAj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298F606A31C;
	Thu, 26 Nov 2026 12:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4298F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JOyKp83l;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=W/EiocAj
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBY0Wg745240;
	Thu, 26 Nov 2026 07:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=DQIHEbE9ItlyHVg5fezp32wK4Z7EUc+dJ4oko6If9zU=; b=JOyKp83
	lOE8iNaNQd9vBfyf8rKBmD2/SkA4eYvnB8VNlLzYA+iC5YYySFGfsY++SWRB6rfE
	Q+NGMxCb6jSNo8op70PgC0yEXJUT6RoTsP5bun0ewzanIWD21jqwGzQPKZrQLDZX
	82oGSWB1oUx3wTwxf/jXlh5pZBO9n0pwE3MO8pO1JpACibQerw4fITCmTaefSSxi
	Oz21dLIHm1g+rhlz+oriO6WJCLwdyQnLGSEwxoT1s3vgVEeSn7qH2EQGNdwwM7Fj
	KBnOINdd+WAF/WvBAFj0R1iMLh//NPJb7/3eak2o09Iqu3iRXz2wcOSHNN9ErQqL
	ixKgqVoW+h0gIHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DQIHE
	bE9ItlyHVg5fezp32wK4Z7EUc+dJ4oko6If9zU=; b=W/EiocAjFhqC3ARI8t5/N
	Y6kCgv0doty3Zma8X04gLO+ratWBl0+wIm7XQNsjuvDg81lA2UQ8pQNhz6vGuC8Q
	eCkHNIJ/Nz5SydYsvs70mGgaPBWitpncTACAfbmRofr1zvboNJI1IwpiVZ4blxwF
	qdxyjAskGL2ZgyWp+nYe8d0x9SOdAphbtNr305++xKbNoJWZdDulOjB4wDqo4lnT
	AexDTW5J3468vY8hrh1X1btX1EWX5TLlxcsx735rNOcR65nSmeGnGxF+dv+JP3gM
	XnPamOwP6JjHB2hk5gw71SWIjXICQ6eH3zQyZ4SLWQsCM5zfUZk87fRPw0pOlmO9
	w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j59pyv1u5-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 07:24:37 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUT10yO4UjZlYPGStOQNq8+OmIT4ALQJcAJM1/QpUXdeBA6khDaNPZVZlf/C1GS8tBZWfSozH+VE4KzpMttaydDB7fAZwsRxDh2IsQe/ybosYFmCLOBxK3v0G6gXfnO5gX8hV8N3f3gEjpAWCmUwkaoXO/jx0iQ5/DQE/taPVMabeFD1h5A5HI6nxWWw4CDVLVgSqgVDKDwWiSMfAKDS/Wr18b62JHP7uJI2OPA2NTFTglm8df0MV+0I8SYnXKuXWfJkXLmX+ExunYMCvhsu5OADLKCNBjKsioeA1bhAcxoKuDyryyH1qPK+X655TARWt7wUD7j6ksnYdxcdX3tOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQIHEbE9ItlyHVg5fezp32wK4Z7EUc+dJ4oko6If9zU=;
 b=gP4qWg4KaiDWc+TB2Ihn8SH4Oi8HO3YtkBJUboDouzrohJczEatySlP+DM6ZhhsozHmjS2n+gX8bYmCSqT7yeF9dUgXG8+be6TAdMyZ0wXzNGIKaCNmK6zgaIjWlyrnlDjAy9k3eO8Oy3cIcIjc2NnqXTOgXomtDKTiWJmVhqmr/2xSZULnL/WevMidlsKrsaJtZZFlLXSYC6sY0xTO2OzROrMr+TFdPnLMpctKwqWC3uK6R6HQ8/+lfm4fVTmFJySxcS27dIiCp1nT6JuRcUR2gh0UmDb0XymI5B+g7syfOkBop0saQFyEkgfn6xQ0v9qXolVPrSiFu9S5heHzrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB5366.namprd03.prod.outlook.com (2603:10b6:610:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 12:24:33 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 12:24:33 +0000
Date: Thu, 26 Nov 2026 12:24:28 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: add AD7793 and similar ADCs
Message-ID: <awgLBWt6MWIRK-cM@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-5-54e4c8830b57@analog.com>
 <20261125-whenever-spinning-36a6dc477a00@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125-whenever-spinning-36a6dc477a00@spud>
X-ClientProxiedBy: MA2P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 21584545-646a-40cd-a944-08df4bb839e9
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|22082099003|18002099003|13003099007|3023799007|11063799006|5023799004|56012099006|261028144727099003|261026121527099003|261022105027099003|4143699003|261102123227099003|261026140227099003|261022075727099003|261021123027099003|261009223027099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 F+Gr2r4j/5QzSALb+WjB7UBhgyE/LcUc+CtZNmmpDYucb0MRcndmvGXHwgzQLXcXySVkfARR1mVFaVjEIUgJpbPH5pm8a+fjZvVsE+5KpEYiF+pomnH6E59Ic+fVTcCXRwbZWcymLhmu8/WNo6heuaWkyEliusVdySGSnLZNJDtcYVd7LyiimqsbAS1CZWbrTw3L9KdEwSn644P9aGmR6oYJRXkpPobJPuSrUNi3ED25QtS0GNEi5ZTABaUty0m/aPN4a0AyN5AuZT9cGATnNvoR/bw2KD8pu4peo65kMKoogCFXNgefLk+O2hBYGsKPxHkHTRepJgDWJTnXV5LjYzyKIrT7Sr3TvooSAntZQDvvqLeaZJNftcX8ux2rvd43IIzsAAzKS5Abh3FB5bsfyqfwnu3fzjAAFOpUrA9SFtlmqCX1UEDAYsEzcwle7y3pIz4joKuypSEy+x09renyje3z7z9L2c/diR6iGrwpWkJ+58w/Nz6wOQLY2D2PS0dC2ODTCCm0wMLGKhiF9jzLXbH2hF3GAlX4ho+c3dVdUIvJWJMkbHUSHBYZsI2Q47FMpD9wST4ZjL2j0dOtC8ryB7WOMYzWnugzzt6vwukzj5Y=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(13003099007)(3023799007)(11063799006)(5023799004)(56012099006)(261028144727099003)(261026121527099003)(261022105027099003)(4143699003)(261102123227099003)(261026140227099003)(261022075727099003)(261021123027099003)(261009223027099003)(261021121427099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MytuenVVak85eUhyQlBCQ1g5ZkxmYzN4UHBDRGtWcXFFV0d6aGtreE9qY254?=
 =?utf-8?B?M1hUa1V6NjlFQ3lETEs2MzZ6RExaNVJZV3FVc1JsdTRUdlRud2g4U042a05t?=
 =?utf-8?B?a3lRb1ovNmhqUjRZMHdxbzlKeVJXbFg0d0d3dEpUREcvNnIxSjlaWnhxejBW?=
 =?utf-8?B?bTBFR2MwUHYwOVk1RTd4K2gxUTJGQVVaMXcwb0JNODJmcHhBdWx0TGtZcU5n?=
 =?utf-8?B?M0pnR01hL00wVHZxU2pCMTQ1SEtLWTlYQS9waVlXODhpZldXclhNWDFQMXBY?=
 =?utf-8?B?amRCNzY3SXEyamFkRkNVVG4ySE5OVzI5b0tSSlhKd2o4OVVzNXhqMGl5Nnlj?=
 =?utf-8?B?YmF3TzVLTWxzMWUvUEllbHhHY01hcGF5TC96akdERy8ycHZKNnlmc1RyVjBS?=
 =?utf-8?B?M2RWKzA5RngzTTg5bVpoa0hQclozdzloVVZBR2J4eHJ3SlhnSXZXbzNjNFRO?=
 =?utf-8?B?TjFrYmlmaUZGTzJKOWZ4TE00TVNUOUtOeFc3ZHBuSnA4alJUdXlkeE0zYjlB?=
 =?utf-8?B?VEJRZll4Sloza2N0bExta3dzaWpWRFZBUzZ1SWthaGNPTG1CaXlzMlg3eFg1?=
 =?utf-8?B?N3N1YXlIYnRxcElNbHBmSGc4aUpvZzhqUm1lbHNSdW5PYjVCWVBGU1M2MjNR?=
 =?utf-8?B?ZWs0L0hjVlZWQ1lHRkJrN0dENG80eGNxVG1YZXU0MUw0bDRSN3VDZzVuVzB3?=
 =?utf-8?B?RmVjbjBaMFFrMTE1WXBqdkZiVy9ibHNmSFpETmR3dUttMlRwbDZ0UDNod09z?=
 =?utf-8?B?OEx4LzJjQUdGbURFRlRTbWtUVkcrSEZva2pNeWxxcVZxc3A3dkNGMDNOVzFp?=
 =?utf-8?B?ZXVoLzFIczlHSnVjUndOK3pIZkdGN3J3ZlNjV3A0Vm44aXRvSDIwYmJzYzlW?=
 =?utf-8?B?SUVoOU9NeS8wRW1jcmF4OFNzU0tVeUNxbXhlY0xLTko4eWhmbnlVamdTS0t5?=
 =?utf-8?B?bGFNTmFZRkFuSjFxRVpjQVFibVE2LzJzQ1NNR1hlcURIcmFQZ2Z4VXR1aTFV?=
 =?utf-8?B?bjh1R2xLa3QxbEdLcFB3ejRkS2ViVE1hU01oQ21xVVpoZFpWM3V5engvdkFK?=
 =?utf-8?B?aHNtSmRES3dTNjlxTkxaRG9iRXliTWdId0RwZG12by9laFd1OUk1NVFWS3J6?=
 =?utf-8?B?anhwMXV2YzIvVFZ5VnNabnBWeGQyZGJUNnhIWEZ0VEp5M2hiZ2ZZaUVXQThX?=
 =?utf-8?B?NWZnWUlMcms2SWdoZXhsUDMzalpzMG1JK2dTbnQ1ZnFUVW5SaE5zc2k4bGIr?=
 =?utf-8?B?WlJBWGFtQkxEUU5iK2NxRlp6MGJCVGxYa3hEZllXNkg5TXlDMFJtWGF4SjJr?=
 =?utf-8?B?ZmpRbExlcDhSVjVLenIxRkkzRThEUEl2RjNzSkhhcVpPQlRDaFRMMTVEWXpX?=
 =?utf-8?B?bjM5VzFWQ0RxQ1VMeWZoODE1S1ZOV2lUeS9GQmtOMDFEcUx2REhyUGhUQ043?=
 =?utf-8?B?WEFaZTQ2NitJK3hPaWluQVRhNEdmWlpldkk2N2xNQjJtOFJ2QU1RcjFmNU8r?=
 =?utf-8?B?a0duTHl1SXNlUGx4dXpkQ3R6V200QkFySUNqcEpJcGh1WmdOLzF0UGpHODFi?=
 =?utf-8?B?TEphMkg2aGgxaTFVK1hlMEtmcE1BdnJHMzR0Z0N0THJWOWZ6KytpU21welZP?=
 =?utf-8?B?RWQ2VWlDYmFhdEdEdW9nZXBLM055V0RQd3UyeUI5Nm12UW5SVm1DVWI4UnZ6?=
 =?utf-8?B?WExCZ2xwQStsb01XQnJMN0tMbHRnM0lrYUN4MEV4TmR6d2xCVzVlUzI2TXYz?=
 =?utf-8?B?T1ppRHFSVFVNemNjOUFGVGpFNENvc09iVnkrR21DWlNESFpTbktaT2NrK0Fm?=
 =?utf-8?B?b0syR3JrMG1BMHJQdXRWSExhM3ozdUpUQWpMK0crbEJVSGdkOXFnRVBQejdh?=
 =?utf-8?B?R1phaWxUalRpM011V2RyYTZNOWRRZE9NT1lWYlo5QlhQYlZ2bmJqaGpWa2NR?=
 =?utf-8?B?WDBmc1lKRGsxU0ZubHhYVFozbnBrVVpOMC9HNnZ5T1BuSXBmOENxaUtDTi9a?=
 =?utf-8?B?SDFlNXN6WDllQzJudHZkaXNuLzFOMVV6UGpnN0RJTUhyV3Q5NEFYUmVTZ2hN?=
 =?utf-8?B?VURiQ3FMZFM0YUIvcG9HUEQzL1JheUs3eFJ1Z0hmakUzejBOdUthUHZ0cThU?=
 =?utf-8?B?aEs3dS9hVUZBVlVwbDRhc2FMcURZT3U5UndSa2hFQ0tCRHBxcGVqR2tDQ3RJ?=
 =?utf-8?B?bTJzRDUyNkQxZUozQXZkS2huK0UwOXJFU3RLNHZlTHE3NDV2T2Q4N2I0VXRJ?=
 =?utf-8?B?bjdtQkZzdTNVYXJlWGs2NytXRmIvd3BKSEpIZG9QVENMUS81Y05pY3BzRS9L?=
 =?utf-8?B?Ym9iMkF0MGNYTGNaQ3MwMmJ1SWx2N3pKaGtPUjZIdWdVVEtwWTFKQT09?=
X-Exchange-RoutingPolicyChecked:
	dZ+J47ux1eZCwhn3AgYveQeAmp0/Z8K2J0lT8k/4I6Iz0H4wM13RfP9vFKtW/rgXlarMXuiRdI2EwMbAkBfITELXaL/rhbTE4hM9QfeTiMMeRfEl5nJloxQWFabJN1rJRPEXbf/Th2W45Vng6Ha+f22U5tAw63BSDJfidimZJ2qwYqK8oIVta+ISOrsR4d13hnFdqTML+GBCUKS9tzzbBVnVE5m21tg1ZIgt/YaVxEXUR1EzOHSPb4MT+1ItS6InUXimajktde2hX1OjaF3LuRVNnEOdb+j6ykE/d2tWomoTb0oQ26bW/zW/pOD7+xauNib3mkEIaeScCYpDRvAvVw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21584545-646a-40cd-a944-08df4bb839e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 12:24:33.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv48ksZBBFueiGZ3P7CRnWMlzW3IgZtBZ4FvDJ8XuGCR03d9beOA44iwfcMm+duckeeBrwz7eJdzNC7IvmkPwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5366
X-Proofpoint-GUID: z2eIqJENCjYOEEcLYsW2jf5ltgXG9O6q
X-Authority-Analysis: v=2.4 cv=HbOB3SE8 c=1 sm=1 tr=0 ts=6b082505 cx=c_pps
 a=m7Xu73pz8xWBtfo2USfVfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8
 a=i5KNX0KUyoFHE_QSxm4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: z2eIqJENCjYOEEcLYsW2jf5ltgXG9O6q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0OCBTYWx0ZWRfX9jRo15uFU2+f
 0aTXiglHcBmZsb/3VXKMY0zKHDN6WnPBKWKBYqtn6pTX2DiULjpRr885ymqzTa6QBZF16Dibu87
 DqebJCVnAjgwtfbaDMazI2HtXWb9gUR5+6SthNImhxY5BDl6llH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0OCBTYWx0ZWRfX/g9CT0sBfgfN
 ocoXyYwm8SgtxSDW67tsggyNIuQCPfX5wto6taXWGFVWx8NwA8uR2G8jGyGzugt/nqBe82CMsYT
 +g3lfD2ROhhXRJbG0mZoo9SjqUr7soMQt2mwZSgVdwkOJ0Wwlq7QVuSb5QepB17BSdp9GSd+M3O
 M8Rs5Wojf2tiGiYf3YhvWyUYYHswTXaRuH55YkbVoB3Fa+D+y6kiBZyTH/RXfjK98y2Jg0hu74f
 JFhJ0qN38rXTvbRbQsqm9kSZMHAQ3dRYfLO1zRAjszr0mqhQCLhJA2AoYUWMAneYDeoam7Iv1U1
 X7fgBah2kJYJSx8NQI+VdsQZNHPvn7vWArzTqq6mw0uMPaVvs1uGzUz2XVAeqlQKOSaD12fokjP
 4HhsSvWW4fOu9XNtE7uQcy5VDXfcgI+8P4CJrgLtRJkIWG75J9kV7lrhdYjBgoZsL7YI0eYQrTM
 fWLJ5sMWHRwG2DRcvAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260048

On Wed, Nov 25, 2026 at 05:41:08PM +0000, Conor Dooley wrote:
> On Wed, Nov 25, 2026 at 10:19:21AM +0000, Nuno Sá wrote:
> > Add a binding for the AD7785, AD7792, AD7793, AD7794, AD7795, AD7796,
> > AD7797, AD7798 and AD7799 low power sigma-delta ADCs. The driver has
> > supported these parts for a long time, but only through platform data.
> > 
> > The ADC reference is described by which supplies are present: REFIN
> > (REFIN1 on the AD7794/AD7795), then REFIN2, and otherwise the internal
> > 1.17 V reference. In the same way, an external clock on the CLK pin is
> > used if one is given, and the internal 64 kHz clock otherwise.
> > 
> > The remaining properties describe how the analog front end is wired:
> > the input buffer (enabled by default, as it is at power-up), unipolar
> > or bipolar coding, the burnout current sources, the bias voltage
> > generator and the excitation current sources.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7793.yaml    | 236 +++++++++++++++++++++
> >  MAINTAINERS                                        |  10 +
> >  2 files changed, 246 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > new file mode 100644
> > index 000000000000..c4a0be06e5c0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > @@ -0,0 +1,236 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7793.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7793 and similar sigma-delta ADCs
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +  - Nuno Sá <nuno.sa@analog.com>
> > +
> > +description:
> > +  Low power, low noise sigma-delta ADCs with an SPI interface.
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7785.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7792_7793.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7794_7795.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7796_7797.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7798_7799.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7785
> > +      - adi,ad7792
> > +      - adi,ad7793
> > +      - adi,ad7794
> > +      - adi,ad7795
> > +      - adi,ad7796
> > +      - adi,ad7797
> > +      - adi,ad7798
> > +      - adi,ad7799
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpol: true
> > +
> > +  spi-cpha: true
> > +
> > +  interrupts:
> > +    description: Interrupt connected to the DOUT/RDY pin.
> > +    maxItems: 1
> > +
> > +  rdy-gpios:
> > +    description:
> > +      GPIO reading the DOUT/RDY line. DOUT/RDY also toggles during SPI
> > +      transfers, which usually triggers spurious interrupts. Reading this GPIO
> > +      allows to tell those apart from real conversion done events.
> > +    maxItems: 1
> > +
> > +  avdd-supply: true
> > +
> > +  dvdd-supply: true
> > +
> > +  refin-supply:
> > +    description:
> > +      External reference applied between REFIN(+) and REFIN(-), or between
> > +      REFIN1(+) and REFIN1(-) on the AD7794 and AD7795. If present, it is used
> > +      as the ADC reference. If neither refin-supply nor refin2-supply are
> > +      present, the internal 1.17 V reference is used.
> > +
> > +  refin2-supply:
> > +    description:
> > +      External reference applied between REFIN2(+) and REFIN2(-). Used as the
> > +      ADC reference if refin-supply is not present.
> > +
> > +  clocks:
> > +    description:
> > +      External clock connected to the CLK pin. Either 64 kHz, or 128 kHz in
> > +      which case it gets divided by 2 internally. If not present, the internal
> > +      64 kHz clock is used.
> > +    maxItems: 1
> > +
> > +  bipolar:
> > +    description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
> > +    type: boolean
> 
> This is odd, why not ref the file normally?

Yes, was not sure on this one but saw precedence in:

https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml#L106

Which might obviously be wrong! And I just noticed that in that one we
do have it again referenced in the channel properties. So it might be
just some legacy thing.

But in here the case is really this is a device wide (not per channel)
property. But I realize that can just do:

$ref: /schemas/iio/adc/adc.yaml#/properties/bipolar

right?

> 
> > +
> > +  adi,buffer-disable:
> > +    description:
> > +      Operate the analog inputs in unbuffered mode. Unbuffered mode allows the
> > +      inputs to go from 30 mV below GND to 30 mV above AVDD, while buffered
> > +      mode needs 100 mV of headroom to the supply rails but tolerates source
> > +      impedances in front of the inputs. Buffered mode is always used for gains
> > +      higher than 2.
> > +    type: boolean
> 
> What determines if the gain is higher than 2?

Userspace does, through the scale attribute. So this property only has an effect when the gain is 1 or 2.
For higher gains the buffer is always on

> 
> > +
> > +  adi,burnout-currents-enable:
> > +    description:
> > +      Enable the 100 nA burnout current sources in the signal path, which allow
> > +      to detect an open circuit on the selected analog input. They can only be
> > +      enabled when either the buffer or the in-amp is active.
> 
> The former should be somewhat enforceable with the binding, what
> determins this in-amp's setting?

Same deal. For gains >= 4, the in-amp becomes active in the path (and the buffer is forced on),
so there's no way we can enforce this at the binding level:

For gains 1 or 2, with adi,buffer-disable, adi,burnout-currents-enable is irrelevant, as the
datasheet onl allows the burnout currents with the buffer or in-amp active.

For gains >= 4 it's the other way around: adi,buffer-disable is irrelevant.

So it should be the driver to make sure all of it remains sane.

But I did take a look on the datasheet and this actually seems wrong to
be honest (the burnout stuff). Datasheet:

"These currents can be used to verify that an external transducer is still operational before
attempting to take measurements on that channel."
"For normal operation, these burnout currents are turned off by writing a 0 to the BO bit
in the configuration register."

So I'll just drop the burnout property and maybe have it as a debugfs
thing.

- Nuno Sá

> 
> > +    type: boolean
> > +
> > +  adi,vbias-pin:
> > +    description:
> > +      Negative analog input (AINx(-)) to bias to AVDD / 2 with the bias voltage
> > +      generator.
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ain1, ain2, ain3]
> > +
> > +  adi,vbias-boost-enable:
> > +    description:
> > +      Increase the current of the bias voltage generator, reducing its power-up
> > +      time.
> > +    type: boolean
> > +
> > +  adi,excitation-current-microamp:
> > +    description:
> > +      Enables the excitation current sources IEXC1 and IEXC2. Both are always
> > +      enabled together and set to this same value. Where each one is connected
> > +      is given by adi,excitation-pins.
> > +    enum: [10, 210, 1000]
> > +
> > +  adi,excitation-pins:
> > +    description:
> > +      Output pins the excitation current sources IEXC1 and IEXC2 are routed
> > +      to, in that order. The default routes IEXC1 to IOUT1 and IEXC2 to IOUT2.
> > +      Both sources can be routed to the same pin, which then outputs twice the
> > +      configured current. This is not allowed when
> > +      adi,excitation-current-microamp is 1000.
> > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > +    minItems: 2
> > +    maxItems: 2
> > +    items:
> > +      enum: [iout1, iout2]
> > +    default: [iout1, iout2]
> > +
> > +dependencies:
> > +  adi,vbias-boost-enable: [ 'adi,vbias-pin' ]
> > +  adi,excitation-pins: [ 'adi,excitation-current-microamp' ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - avdd-supply
> > +  - dvdd-supply
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - if:
> > +      properties:
> > +        adi,excitation-current-microamp:
> > +          const: 1000
> > +      required:
> > +        - adi,excitation-current-microamp
> > +    then:
> > +      properties:
> > +        adi,excitation-pins:
> > +          oneOf:
> > +            - items:
> > +                - const: iout1
> > +                - const: iout2
> > +            - items:
> > +                - const: iout2
> > +                - const: iout1
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7785
> > +              - adi,ad7792
> > +              - adi,ad7793
> > +    then:
> > +      properties:
> > +        refin2-supply: false
> > +        adi,vbias-pin:
> > +          enum: [ain1, ain2]
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7796
> > +              - adi,ad7797
> > +              - adi,ad7798
> > +              - adi,ad7799
> > +    then:
> > +      properties:
> > +        refin2-supply: false
> > +        adi,vbias-pin: false
> > +        adi,vbias-boost-enable: false
> > +        adi,excitation-current-microamp: false
> > +        adi,excitation-pins: false
> > +      required:
> > +        - refin-supply
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7796
> > +              - adi,ad7797
> > +    then:
> > +      properties:
> > +        adi,buffer-disable: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7798
> > +              - adi,ad7799
> > +    then:
> > +      properties:
> > +        clocks: false
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "adi,ad7793";
> > +            reg = <0>;
> > +            spi-max-frequency = <5000000>;
> > +            spi-cpol;
> > +            spi-cpha;
> > +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-parent = <&gpio>;
> > +            avdd-supply = <&avdd>;
> > +            dvdd-supply = <&dvdd>;
> > +            refin-supply = <&vref>;
> > +            adi,vbias-pin = "ain2";
> > +            adi,excitation-current-microamp = <210>;
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 658895c3b0fa..e55236f4accb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1731,6 +1731,16 @@ W:	https://ez.analog.com/linux-software-drivers
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >  F:	drivers/iio/adc/ad7780.c
> >  
> > +ANALOG DEVICES INC AD7793 DRIVER
> > +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > +M:	Nuno Sá <nuno.sa@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > +F:	drivers/iio/adc/ad7793.c
> > +F:	include/linux/platform_data/ad7793.h
> > +
> >  ANALOG DEVICES INC AD8366 DRIVER
> >  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> >  M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > -- 
> > 2.56.0
> > 


