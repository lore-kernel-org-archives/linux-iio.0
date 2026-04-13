Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54C1624C5;
	Mon, 13 Apr 2026 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044201; cv=fail; b=Kas3b42nzulZvh5PYNzxFTV3nyGuQCsqtuMoAjJ9t+n+OnTSpQqOvwxTp5uVXu7BMv+H/7YLxQfJhNKjj8nbSRhfalTgGGYnwqCUck5ZNHYolEMs5Ocz+UrUgMaXY0OI8n1mERhB6Oi6vy68JaRv5DUXZdYBfUTP+2MhGJKxz2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044201; c=relaxed/simple;
	bh=WnoNF2ilnPv9s0vhiJyLGwlqUZTHssQqd+GMWENG1eo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K3WDnaL6hE99vd5UhAPEeS2wTJPgy8rYiBzV2EMk2KPy/SYDH93aPZm8AH9mecbAqb15dyWM5nyDMVlARws9dd4eL5vuDtTBuEFJeyITO2iNYDWvXBcwc7BmV2cyM3ekeJZylg4U5P61bz3XwDtGv2Ezj42UfWqwrgY9H7iUr9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QYihvRda; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QYihvRda"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CMxui21570608;
	Sun, 12 Apr 2026 21:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WnoNF
	2ilnPv9s0vhiJyLGwlqUZTHssQqd+GMWENG1eo=; b=QYihvRdaW6jvEec2pkawk
	DfZ3f+7qGwWLN5WBp0l1bw/gVZwdv8tktKuoAdKGNqfcgek6Lv9afkHKvHdvyiE0
	Sjh88nzZE47HtPHHxVQ1OHlvYUJcOnQJ3URadtWfLnpISJuTroMUAXvz2eYIURxJ
	rMzqcAxZTI6FbbOO2DwHTRonangeA3/ZRq2p93dOicA7vbz/F/GBykIDLRH5q2/g
	mnY/K3/rZBWEkjiHVU7uV0bUrVCkoquT4H85xTnWbZ6i3ORnav47tOLi4UES6Ldy
	z3VKOgLwgRDUx0jiwSIYVvZ4LTHg6sm9y1YCl5vx1lvb/3srvGJr8jrK2dA5QINP
	Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dfmuhgpqa-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 21:36:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ycw7nY3EB5o0LamvieXAnMna9+GuYgsAkUqm1SvdCeThgd7saXo1393taeK/fHGXSZmAFgm8GV5IeWrwKxxTK/V/UoWspRjKszi1EXEG4zOdCQYBSPWtqhp65IHhxfZ3e21+sr57uPHbF/KpxSx7NQHhUKk7vcYxWGZmwnqUrpUfUpdlCArZKhU5XQDW1MZQnk6Lv+jFv3xC/zFRtDlgFLigM4uOFxKt3WA20ojc1SoyLMLNvCu1yF/p1SAs1R4f85JchwITbzNWngN8uznyhmjGLpsOR02zOSlb7nslFkfqa9oJNGWe+kFw3Cf/trXVuIKP7LkUFhDmDb4KIMzWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnoNF2ilnPv9s0vhiJyLGwlqUZTHssQqd+GMWENG1eo=;
 b=pkm/UE1HQXWQAc2vxLPYyjQlHhqh0MhCnWo4fBhCkDfxr6EsYPQlOA9nwWdsrXY/7lVhFZiSbqr9OnC+tyWgCmLJiLOTOMOUdMpYNGUuSxzbikXofKZG15r3hXrominlmDYe/hid84bRAo+ApHAt42fJyg84f64bpmHsaoQtKgm3JdErd+OoO2mKqwaXWBjrJV0isRpn6OIc5psFcJ9LdcHbPpV2Oep7RSLpx6GAxPWagkU876M/15P17QrLrdCzIjb4fzbC99rxGela/d/wfNTYD153s9K2kHvGrdR4a+1pDa+1Usaj9HijOWQ5+ZNxTGKO/4g1Q+voyioAaguhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by BY5PR03MB5112.namprd03.prod.outlook.com (2603:10b6:a03:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 01:36:32 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 01:36:31 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: Andy Shevchenko <andy@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>,
        "Marques, Jorge" <Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy
 Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
Thread-Topic: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
Thread-Index: AQHcwNxRJwUQZKu0kkSMq3Lfs7+OFLXZMQIAgAEUu4CAAWB7gIAAnebQ
Date: Mon, 13 Apr 2026 01:36:30 +0000
Message-ID:
 <SJ0PR03MB585430BD5A6D056CA785D8E3F4242@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
	<CAHp75VfkdmebYjBdOnkqrT87Sm9PR8OehYvPSwwxiY9zq9hfbw@mail.gmail.com>
	<SJ0PR03MB5854F9BE63C740C8EDB18E24F4262@SJ0PR03MB5854.namprd03.prod.outlook.com>
	<4c34f4f3-f3c0-403e-bf14-29403ce263b8@baylibre.com>
 <20260412164939.068cbe9a@jic23-huawei>
In-Reply-To: <20260412164939.068cbe9a@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|BY5PR03MB5112:EE_
x-ms-office365-filtering-correlation-id: 60996817-36cc-4da4-884e-08de98fd16e8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 Esf3m/OQ8O5YNCYS28zZUXZj7H1P8UfYU5nps7H0s8tyI/jTz/kbWk8NnJq5zK+iSewvB4O7OGxdaI3jREk0GUq+0jlt4GgKHbtD5TuEslDRFj89do4nhsUcJpkSEZVsCAkCknJLJLA8wAzCG91o+PIT+s7wpDZjwtn8283pUHFzIPt9hUEnSaIMXuDkg0BN+NGRseAm+kJExtK1XFHtJsO1o1tyYzHk2mBPh8hMTvYX7K6XxTa9kJYgs5SzyUNGs66l3QdgQl7H1BNuv6Q8Fe0DQZ8rnhcKLZr0KupkCKd4AK4DXA4QY/OH1tGgI4wnF4W7eY1Ss2TztazQzXVJxU+qog/iOPsrUhuKGnR8NcUZxGYaIiP0uDw37/Y4k1yjKK0kBJ5shzlj1rL1NR2qSQ3qJGIdVjL8Gvjham+a1x+WabX1q27Pz/PG8ZXLPC/cg60OQZ9i9wUC9DFs9rX/+DEf1dMN+LA4H8Jhz+5U7TfJjkNYrf3tyOLTSBwwN5HEhyHcGYxnx9K16X4cNsJC6Qj4+oJDweeEuRmGHbAlS5qghOPxAgutgjbm4uBfpE2t9KlJeKWO6D3Jnl37DfSrQxXJR8s/ifCOFu8QQva/5mwSdpsXVz1Cwb+FAbdAa9On04Ob5xiQJiMNHOy1vpQks0Re9rvjtsAEVCh2JvevKuY0fItgTQxvjVVTBXudlgaN0z+ARuY2NxkKSNEyPx43kP3VMCsLVlD8gCo6T7JBGgd+IHu/GdesXxrQdPE9TCPR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDNsVXQwUEduaHk0VVdiaURlTVdJUGltZ0pCRTVWVkVHNVZPVUNTU0VnQldL?=
 =?utf-8?B?NVl2Zi8yRUl1STZuOUJlblk3aTd0YXh0d0Y5QzZ1c0ZCL0s4M2cvTVE0VDNW?=
 =?utf-8?B?cUJCZkRwWWhucWQxeXRVVlF4aVJwSmx5QUVnd1IzZnNkZUZ0eDFrcVJCL1gr?=
 =?utf-8?B?UW1EYU5oeDhDbXozaTh6OUNjTlFHL3VZL3Z2MGhTOVM4ZTk3TW1PWUhJa1J1?=
 =?utf-8?B?UElKaHlYb2FsR2c2OWhBNE5wQzZGMVFHaGxCUHM3YWVwNmptMVQyekFpVHI4?=
 =?utf-8?B?NUZtcytiQStLTExTM3NQcVNMSkhYUFN1dlNZVEtVQ1cvQnA4d1ovKzRjM010?=
 =?utf-8?B?RnAvUkZxTmVZbEZPTng3dzIxTklUNXliRG1ZNzVwK1YzYW5POVpQVFd3MHBo?=
 =?utf-8?B?cEh5U1NsRldlVm5KVUZTVEVNL1ZNV21mcVdIT09BbVhLREs0c0RaRWt2Vi9Q?=
 =?utf-8?B?UjBVbktHRkRib0VyTURpTFZPU0RZOUg5ZG9RTWM0VHcvMVc2ZUlpeVJINXRL?=
 =?utf-8?B?VEROeUNKdVQ3Y2kwVHJUWElydThMdTBlYVQwUFdNaFI1MVNnNzJEWEJtbWVo?=
 =?utf-8?B?TzBjOThLMUJkWkI4V1lKUHF2ZzJRQmU3dzN4MnRxcjJEWTJwZVZlZnVRa0E0?=
 =?utf-8?B?WHdOSUhoREZFRERackZ4TGhuT0ZvMzg1cFVzTGFWdTFMeW1PK2s0Yy9kMjZK?=
 =?utf-8?B?MFFJQm0wdCs3d1dRL3czYjF4UXpNTEU5bUpNTkloRTZVNSt2UjU4SFR1RzJ0?=
 =?utf-8?B?Mzcydys2bEcrME1WYVdMSTJxVU9JZ3lXVGw5UFhoTFo3eFdCZ2plUzB1YWR6?=
 =?utf-8?B?ZUNldjFmei8rUUFkQWc1TFdNeWcxd3o5RkFONU82bTBpMXZmWnBrb0VtdjRE?=
 =?utf-8?B?WHJaWk5pZTh2WDBlUmlhVzFyT0xYaFd2NWIycUF1R3NhVmVwbW1rZUhWQnZ4?=
 =?utf-8?B?YVRDc3Y5SGhmQ0MxVmU3UkN2WXh4M3c0ZTUxcXg2NUsvT2xPNVkwRVQ4SmtT?=
 =?utf-8?B?eGx0ZUt2L3lQRHV4R1prUzdja2x2UVprbWN1bXFLQVowRFVOdko4d0o5RzVJ?=
 =?utf-8?B?SVRGUDQ0TUtpdiswS090cURlWjhWQTlpei9Od1BKdWR4ZTk0SnVWUXRtU1k5?=
 =?utf-8?B?MWRBRlVjV1oyMVFXMVN5Qmc3cnNsVnJkc3NKU0hjczJoblN6dkpXenV4ZnRM?=
 =?utf-8?B?QWhUSytVNEZ0R0I5czBDZUZpcHY1bVFpc2czcUpLOG9JdGRuck5MdENCT1RH?=
 =?utf-8?B?OGRWQVIvUzI2V3FVS1d6WEtCRW9vVy82ODNWNVltV3BQbGloejVyRjRSUHho?=
 =?utf-8?B?bHNmQ0J6MWhrMCtuWUx3RHk0NEVLVUR5T1JaU29ac0xyT3UxajVaTUtSSjFX?=
 =?utf-8?B?ZHVDaHVjcUlKNmdFeEtBNkNHbVhLWTVDR3ZxdGl5VnRIMWtUUkNMa2xBdUJk?=
 =?utf-8?B?SVVySkFsT05GaEFVdHZTYysyeDhiVThXNXY4V0VJQ0JKaFVDejZaS3FVeC9p?=
 =?utf-8?B?c3dhYi9sSjJHWEs2SXg2M2pXMis2V3FLVGlHWUNMSFBDNE16Z3NxWlNSWHMv?=
 =?utf-8?B?NDdlNEJaYkNVRWNldm13QnoxRWF3Y0I1VU9MVXB0bllseVB4OTRIQjZsNkhV?=
 =?utf-8?B?blZ3NXJsRjBOV0JzSnMrdjlGc21rVXQ4bnFqYm96RmRlY0hvTEpjVGtCTnN5?=
 =?utf-8?B?bmtGbENNMTVlRVM4cE0yOEl4aWowTTlma0R0WVZETWlCVzdTTERYQWo4YVZR?=
 =?utf-8?B?akVuOWxuM05wYWE2SXYvMlBab0FseERTNE5ya01OaU1hcG83QWJiOHFJUmdh?=
 =?utf-8?B?MEVycFRFQjNscVBOYXBsV2N2SGZIZFRDKzFSREpOUjExeFBJS1I2cFVPaC9k?=
 =?utf-8?B?QW5OaTZMb1FvdVlmNDdVM0duMDF6eDcvcDdXcUE1VzNRRlhFeG1TTEJHU0t5?=
 =?utf-8?B?NThkWlFYTW5kWlpBUjY1QzNlcGNETUljVXlNdG5vaU1uUGFqVkhUYWprV1R1?=
 =?utf-8?B?RjdDNlNvMnExRzArdzNnZWEvYWhsQ3hoeXFONlJWUVFta0NTOFJhMk44RS9D?=
 =?utf-8?B?cDQ3bjI3MXNSRWpTeVE5NGxBU1VtTHp1Uzh4ZmNycHgra0w1Rk5sMi9tRUZk?=
 =?utf-8?B?YmZjOHgyWFB3U3lTUit5dk54RGY1bnBKNXZQODY4a1dNaW5ZQ3FCK0NxcEM0?=
 =?utf-8?B?aXVIdkcwTVV5TWFLckhkVmlDa3pZTWpvalo5T08wZUk3SDQyVTZZMDJ2Ly80?=
 =?utf-8?B?QXZ4SkRYTVRNSDdCcUxTOGl2WDhYakEyVk9mYWd3TXJ4ZE8rbDFncjQ1VFdY?=
 =?utf-8?B?cHlpckZ1ZFZBc2tVeWY1RnVPTThEYWdEdThweitYck12d2NKb3pOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GOxTYFRWYgSFRGMNNQaxsC97HyZJNkLaZ2ihQuic0wAip73CLOLq4b+lL/mbm7tjG3HYEC4WLyCE5fCuqYcow6RF9Qe813jc2lXmrIUhkFWtqKM7ZdjHaBBLJA2Tuv68GLnkO0Z/t/g1ZWYTrC9srRyYySsI8OOBBv47dGDt9akooiqfdkYfLemaYMLu9gvpFG79riCrGSS1BhSnzkBjQSWwqQOfbuKHftcgG+GCWdlxZJw2erNFoyN0DiMwbpnH8PAik+0aDS6ZpKYkUFVJcT8TZMlcP+CQy86RruT4JmesqMfX5sZwnWmbpVFHtiCkoCZEEs2Nl/PCUsbL2LglAw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60996817-36cc-4da4-884e-08de98fd16e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 01:36:31.1594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ayi57Qt5lp9dyyxiSqe4XwaGxQSHfXklgVt/Ze1U6M8BugLB4JiFS+CYvFn7RZDLlcUNyj6kg+ONWsyG6C7WgpWMYi4k3/uAc2tBhihLSho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5112
X-Authority-Analysis: v=2.4 cv=U+miy+ru c=1 sm=1 tr=0 ts=69dc48a4 cx=c_pps
 a=bIHOvEVewOWTfzx0yc51bg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=MCRHifz-s8oK_jZMvfoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: flG5SH77xwpLeB7JtMj-4xLPakeMlMrA
X-Proofpoint-ORIG-GUID: flG5SH77xwpLeB7JtMj-4xLPakeMlMrA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDAxMiBTYWx0ZWRfXwPKebcuo9UIF
 iwFfb/Y8tfrUk6HbBpUCRP6Q/YMYobwy/hqflPWA55vghdPIZFpG54dySbh/mYtEXxT8t6m9CmK
 GC9us68CTmJ4Xua2AKuQ9MQXiPZ0YAlQLQo8XB8wAoFpO0b+3z8CvWK+bJIXisafWfF72PdvrBL
 fgXCyde6T1CWbePyIHRAEhzOOnZJjrd1XF8dcM13iFK//2BJmm3hfHykVjqplfaJUURd/9LNHVe
 No5uLT/iuU39n5w6SDTNu9oL0DL4qnAaWaRyBmVysHgsy5R+pw2XiohSxjNvyHXaTg6la2TPx+b
 9qAC95S/EF/XDiux1TO9dDxflUa5KUmnCxWGJjP31Nz1PY24qGOBHidJX9a6ZTH5+Yh+HAVD4ng
 JdXeHotYF7gRkXvzAZDRgie45pM+7IMLWBdnHvPYzqYxhMij+AJUyx7EEgF7hpBXu2L08/mPbkF
 Yei3qzR5O4D6w7cZgRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130012

PiA+ID4NCj4gPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldywgQW5keSBhbmQgTnVuby4NCj4g
PiA+DQo+ID4gPiBIaSBKb25hdGhhbiwNCj4gPiA+DQo+ID4gPiBKdXN0IGEgZ2VudGxlIHBpbmcg
b24gdGhpcyBzZXJpZXMsIGl0IGhhcyByZWNlaXZlZCByZXZpZXdzIGZyb20gQW5keSBhbmQNCj4g
TnVuby4NCj4gPiA+IExldCBtZSBrbm93IGlmIHRoZXJl4oCZcyBhbnl0aGluZyBlbHNlIG5lZWRl
ZCBmcm9tIG15IHNpZGUuDQo+ID4gPg0KPiA+ID4gS2luZCByZWdhcmRzLA0KPiA+ID4gQ2FybG9z
DQo+ID4NCj4gPiBGWUksIEpvbmF0aGFuIHVzZXMgcGF0Y2h3b3JrLCBzbyB5b3UgY2FuIHNlZSB0
aGUgc3RhdHVzIG9mIHRoZSBwYXRjaA0KPiA+IGF0DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtDQo+IGlpby9s
aXN0L19fOyEhQTNOaThDUzB5MlkhNGlYOW5MWXJEdnh5NHBjVG8wWmRfSEk3ZERFVEdGcWItDQo+
IDNPcW40bUJQbWdZOF80VWkxYTRlQnhrQk1VTGZGUXB5WHlpeXJXdWFGM2pRS0tFYkEkIC4NCj4g
Pg0KPiA+IElmIGl0IHN0aWxsIHNheXMgIk5ldyIsIHRoZW4gaXQgaXMgc3RpbGwgaW4gdGhlIHF1
ZXVlIGFuZCBoYXNuJ3QgYmVlbg0KPiA+IGZvcmdvdHRlbi4gVGhlcmUgaXMgdXN1YWxseSBhIGx1
bGwgYWZ0ZXIgdGhlIC1yYzYgcmVsZWFzZSB1bnRpbCB0aGUNCj4gPiBuZXh0IC1yYzEgcmVsZWFz
ZS4gVGhlbiB0aGluZ3Mgc3RhcnQgbW92aW5nIGF0IGEgbm9ybWFsIHBhY2UgYWdhaW4uIFNvDQo+
ID4gaXQgc3RpbGwgbWlnaHQgYSBiZSBhIGZldyB3ZWVrcyBiZWZvcmUgdGhpcyBnZXRzIHBpY2tl
ZCB1cC4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGxpbmsgdG8gY2hlY2sgdGhlIHBhdGNoLCBEYXZp
ZC4gTXVjaCBhcHByZWNpYXRlZC4NCg0KPiArIG92ZXIgMiB3ZWVrcyBpcyBjb252ZW50aW9uIGJl
Zm9yZSByZW1pbmRlcnMuLi4gTGlmZSBnZXRzIGJ1c3kgc29tZXRpbWVzLg0KPiBPbiB0aGlzIG9j
Y2FzaW9uIEkgd2FzIG9uIGhvbGlkYXkgLSBibGFtZSBEZWx0YSBjYW5jZWxsaW5nIG15IGZsaWdo
dCBiYWNrIGZvcg0KPiBtYWtpbmcgaXQgYSBzbGlnaHRseSBsb25nZXIgaG9saWRheSB0aGFuIHBs
YW5uZWQhDQo+IA0KPiBNYXkgdGFrZSBtZSBhIHdlZWsgb3Igc28gdG8gZ2V0IGJhY2sgb24gdG9w
IG9mIHRoaW5ncy4NCj4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNjAzMjMxMTI3MjkuMA0KPiAwMDAzNzE1QGh1YXdlaS5jb20v
X187ISFBM05pOENTMHkyWSE0aVg5bkxZckR2eHk0cGNUbzBaZF9ISTdkREVUDQo+IEdGcWItM09x
bjRtQlBtZ1k4XzRVaTFhNGVCeGtCTVVMZkZRcHlYeWl5cld1YUYxSkxjRmpfZyQNCj4gDQo+IEFz
IG5vdGVkIHdlIGFyZSB2ZXJ5IGNsb3NlIHRvIHRoZSBtZXJnZSB3aW5kb3cgYW55d2F5IHNvIEkn
bSBvbmx5IHF1ZXVpbmcNCj4gdXAgZm9yIG5leHQgY3ljbGUgbm93IGFuZCBub3RoaW5nIHdpbGwg
aGl0IGxpbnV4LW5leHQgdW50aWwgYWZ0ZXIgcmMxLg0KPiANCj4gQXBwbGllZCB0byB0aGUgdGVz
dGluZyBicmFuY2ggb2YgaWlvLmdpdC4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+
IA0KDQpUaGFua3MgSm9uYXRoYW4sIG11Y2ggYXBwcmVjaWF0ZWQuDQoNClN0aWxsIGdldHRpbmcg
dXNlZCB0byB0aGUgZW1haWzigJFiYXNlZCB3b3JrZmxvdywgc28gdGhhbmtzIGZvciB0aGUgcGF0
aWVuY2UuDQpHbGFkIHRvIGhlYXIgaXTigJlzIGFwcGxpZWQgdG8gdGhlIHRlc3RpbmcgYnJhbmNo
Lg0KDQpCZXN0IHJlZ2FyZHMsDQpDYXJsb3MNCg==
