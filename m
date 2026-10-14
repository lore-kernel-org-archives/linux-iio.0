Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D93ECBE3;
	Wed, 14 Oct 2026 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977641; cv=fail; b=rukvJnybfA9rZo8DNzt+oNBafXZkpBaSerChidtBLcACvi68Qx6KMHp74dKyFq1gtm6PmzOZBnVvkrVd0xbloQJiDYW3ESeEdZeJLT09hKjfRemhj/7/7Zqjrw4StJtQZGNCvmEhj+JiDEF2P8w9Zm1w9hDzR832YGBAIKbkLgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977641; c=relaxed/simple;
	bh=LGLXsOcWf0vShgIjiUDWrpwtCCaHaZx+qfSdSMMZWnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ext9X6tr90daJWq7xx+5qWzIH3aRz2VaGUkChibHj61xUMkjHklDT2Jv4dyJkNNVg9YL4yr2caI15sH9Bi1TVxL3M6Us3OEZ546fkiC5AFHXWQCxzE6HrVxn0Osc0TPH2E35HOq+jE5kvuoYuSVAC+nBe2jvM4lPB81nVjXAp94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=BVqnAIB1; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0fL8RcT7; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="BVqnAIB1";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0fL8RcT7"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBAKYh3358197;
	Wed, 14 Oct 2026 07:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=dXPsNBPOW+wKqFsFO0ZGqrWy2BOT33hapdRkR2vIU0g=; b=BVqnAIB
	1jJXY4OeUFNjs5u9Swpd5gJiciJBPu/vOutewgoy0BvSGmyek+Ydug5ozrHL2+bd
	ntG5wFSC2h5nNfUIdjbwwWzcg6F0zLYvMFsNFvBw2XR1WOKZNE5AVieGBp5NwTlU
	ewNflhAXnzmMKHxjJRwnIViwyZhTH5sQUm9W7KgUnLk161Dsine/fxhMFe8B6NvC
	IxWEOa730EABCnhN8F/tmzncwn9gWdlgd5mDBjDe3kUovxWmJFP4R1v2NrFhzq61
	tcjI5bfeoZG+VE4boKQqBWCCmAwn0d2u0/pV1xTmqFbZnkI4t/q/EnhGOJ3HrxRj
	2RNhY5HndcW+vaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dXPsN
	BPOW+wKqFsFO0ZGqrWy2BOT33hapdRkR2vIU0g=; b=0fL8RcT7sq3u6kjpT/2Hf
	j1iUhF6+/WSVyluQpld13rCYGMfPrLY/MpUlmW2pXVcEY/p2w3tChk4Sh+s0WyCT
	Rd2+BKwqSJXpeQMUDHIRiRTOeHwSNkkSTXu1MEMOowa0F9Sy8w88dG1gbQl4ia3W
	AEzXBxIwUXNaiRNI9ytZkOQWzPvB+Bx2CpA0XgKbgEXQuPXlGm8cF3G9keDfd7JG
	d3bYmjs2JRElykR26qy4TVHSli3iLYHCO8NdB0Yo3U1INKVnlUluzmEdnN4VuBok
	Z5kLxbdym9Ud9odPtZSV/JR/IomncdRjwUTFIn3k9hSmWq/M3jRCcZihEBJBooEu
	Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h9ryn553c-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 07:31:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhjDjDzo3AOkUYQnx1qJ7XgIKfKLl4PLshR5ljL+4sG76oa+NnqyfsSetignuJiojPlkkDmymFdBeX3igT1Ci/t/04+SVNMwvNoSVkwCNu58LoDH5BjCk2+j+wtF1dljlbueXG3AqmpvXYQhhMMO12GvdcjSoj2nS3C004h4JQdOcTvg6pzZK277gUxq6Hacss+bINTMsiLh/43uU4vPsqiJ+VP9FQklDJTzMfHRaVdkGJPhCwOS/YPCZnBVAhGZ6JJO5eQn/Esrg+vo7OBajk2CSQVTZSBncrx3dv/niIUWZAI046BxSDDuFdfDhA9NvDsyX+qS40Tw+rKc9MG1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXPsNBPOW+wKqFsFO0ZGqrWy2BOT33hapdRkR2vIU0g=;
 b=u+Aq2NPwmNbCJGXvyqKUDXlzaHLI1XNcByJd63yvELboIIqtCUO/9iAXO12r9Ugn1LcSDfJ9bY98316Nf/2rABIoRCbiGcq7wP9TU10b2N4FOW6oOTz1QR7I+7uBowo8sEq+TUSAWEvP9IXVPjMthtkWrYJev06C/8uky2s2CjsiOMuSs0jxvD+ckCgYKSC8xw95lEe039EH1S0rhOEDyAvGNkyILnYgFzuRmhLnYn2gvVRWN+NmVKPs8MMLfVea+N6SAqWlmoAbj13wbR7gux7xlmjL2W5xAaa9KpydlFO7E9kRTGI7+DBvkSpXmgIP0VM6p/TqS8pWQ1XMukvTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CO6PR03MB6211.namprd03.prod.outlook.com (2603:10b6:303:13b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 11:31:42 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 11:31:41 +0000
Date: Wed, 14 Oct 2026 12:32:55 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Eddie James <eajames@linux.ibm.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] iio: use designated initializers for acpi_device_id
Message-ID: <as9oRfB82C6ckr9p@nsa>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
X-ClientProxiedBy: MR1P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CO6PR03MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 863558a8-5079-44d9-fe6a-08df29e6b7d0
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|22082099003|18002099003|260925021911599003|260925022911599003|260925021311599003|11063799006|261009223327099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 gbItrWj8UxOXICrMHHZmbl+I3WrbgYyJdhjS8C0oe5ftAz6LcEuDOK8we12KsoQXWqKfit2FX4sbMtegi75mxcd5wbpVldf2630Cew2+eJkTo9aGWZDKUL9uRVdb3t9iKOSPKUD0GCwloFoxRj5+/bfRwnOsMP8sWr0T4M1ogKoeLrm6oB2SX8MuAZ7dbiOv1V8Dw3q8HCkw2VdEVfNBsVXpezNz8wIphdJ/JMp9EVRgntbaghBSluEd5BwChkB2nntJL3CME/EYh6265uOGSw93FMwtVaXB/uJchDPO6MJMWNQhYtitO5qrGZ8SZqSBpMw4U7jRux9iApeKWo0RlTJIWHQIJpdPk+E0ZvK5pvDoYLbC0i+FMnB82ccvcZfeAaNyAW1Isf/q1TWCuLfZ2JB+wOZdJ+ViMwmcHJWHjghbJxjWmKV0G0FAHqOteQxv14QF6OF0zpNKwXkMfScYuedxr91MYkRInYIvU2fexOxECIl3mKmLsxMoO62pLf9H1MpCxA+pDQSmlfxK1qBgQYQFVz0toFz8LUGuitKhN/5/Pex4LajoJFHQ0ulxaGKbDiIeRkXi3EPJYPs/5w5usZcjAGPhDjRPWNY1I1RCg6oCydkgM97TcpWOZ+c/RN1Z
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bFVhenlQdDNJZDhPb3hIUEl1OExrTGpiZU56YkRkTXJEd2dxUkVKMTV5RUtQ?=
 =?utf-8?B?NXo3cHVVWjRDRTF1dzFrZWc2QXJjWVkvZHlQdi9Nd0FRKzBmN2UyZEgvajN4?=
 =?utf-8?B?QjJaL0NpRkU3bG9GR2NiYUMvSktDaXBLa3dIckZkSWNENjhyVFpQSkNjYjdZ?=
 =?utf-8?B?WU5KRU5oWXo0Mkt1cDN2YjJtanljb1BmSWJQeHlJWXVQSW4vc251c3g2Vnd5?=
 =?utf-8?B?c1d1WmxCNjlFZS93UGJ1WFVoVkw1eExWMVhZbFNWK2RGNDRrWHJJZkR5SzNE?=
 =?utf-8?B?M0U1UzNxem84c2hRSFVzWjdqQStKbzZIdWVaZXlEVUF0U21YTkZQbi8zZjRD?=
 =?utf-8?B?cWFnUk1nWFVsbGtvYWY0NVY0TjcxbTYrWUVCa2xMVVVKOTJZNUJQdkpSSmF6?=
 =?utf-8?B?VTNYY1krdW1MaUFOenBrc3FNMktNbFprZjhFWlRod1YzVEU0Qm4yRGlYMTlq?=
 =?utf-8?B?UkhsUGxML0l0RDhndy9tY2VvU2IxS005TWVzU3V5dmNkOEcxWWJGdi9Va0Rw?=
 =?utf-8?B?SWk1enJzcEt5NnpyWEVCNzhTZk0rOUhJcEtLOVpvNzlMZXluTjJTOEFUcWJk?=
 =?utf-8?B?UmhybW9TYjlsWXRlTkJDQjNpandiODV4WWlabWtMMndYbkFqZm1jblBSVnIv?=
 =?utf-8?B?NVVkMDlML3NRRHd3T3VycEJxSW1CNTZvQnNkL29vU0F2MWpVclNPbXRhQ3Jx?=
 =?utf-8?B?MnVYSkxaSHpyYStMTFVka2l1aWVDVkw4T3h3b1NpQUtVQzB4dEVabU1ocmht?=
 =?utf-8?B?RStsVXlPekw2VGVrUmVta1M0TkZuYitpbFhJQ3VzTDUyeG5sRXprVmFEYWkr?=
 =?utf-8?B?SWdrZTQxYzhQMkJuWGFQcGVwS1hyRXkwLzB0SXhNYlhYdEVnK0tXcFpOcmVN?=
 =?utf-8?B?WGQyWjd0RXlpSFpBMGtZSmxlK1VwNllSRW9PRmlibzdzTm1aTTRlMlByeWda?=
 =?utf-8?B?NkxrN3gvMHpHLzBzUlRSb3F6bkkvMCtLY21Dd0hRK0IwU3RnSmVFY1I0T0E4?=
 =?utf-8?B?RGFkYlZUWmtkOSt2WTByOVROZ1RpZWJqajJUaHFYMzRyVFZmQW9jUnAwd1p6?=
 =?utf-8?B?TldTMHdOcWFXOE1vYXNDdjNRa0dobTN4RXl1U3Y4RmRCemFqT3U2aXVMWkI3?=
 =?utf-8?B?QzJmZ0hXaGkrb0xwZTRsN1lvMEh0UW9HYkFlYWV2UVpjWkVXWE1IWHlmN3hN?=
 =?utf-8?B?UjZkemtaU21QNmg1OXJCVk1rZHlwMkhmYjVicTRhQ2pBT0cyQXd0SXBGSE1Q?=
 =?utf-8?B?UHJzeXJxc00wMmFEMndpZmxzN05aeDdCUzdQZ1J6YWtSdVBLWXJSTU03dTdC?=
 =?utf-8?B?b21SWS96eWJPQWo2OFRRQXRIazY0ZE12dEZBRXZsb0hDZTZYQmxlbmhVeXhk?=
 =?utf-8?B?bHplQVJiM3JWWVlpSVp1YWtudVg3cXhOOHFxS3FHMU1BT1NkZWFFZ1hDZ1Rz?=
 =?utf-8?B?cjdyN0xGZzU2RWdLQStQcXNzbmpQUGJzV1MwM05TZXRGUnR2enZ1cmYvaVVo?=
 =?utf-8?B?QUo4bjBFemp4UE5SbHduRjRFSExSY21JWTdsUUlsYmtmYk1CZUZKRlpnNHNW?=
 =?utf-8?B?UENPd1M5b0hrTXFQclNGb1NvNjVsT1cvcHJuK1dYQXI5THh0VFBxcXJNdkF6?=
 =?utf-8?B?V0NveXU2WHFpMTZyenBuRGtyVXdhaGxOWGNIYzJYQW0ybHRTNlF5K1dhcmdn?=
 =?utf-8?B?ZUUxQ0daL3dGSWhKWStsaStVUFV3ajF0YURXWGR1aTdzNFkwd3V5dXNNeGt3?=
 =?utf-8?B?cXdTUy9VaGg0ZndLNnU4R2Znc1FPdTdhcWU5THNGbms5M25ZSjJJWWtQWWRt?=
 =?utf-8?B?bk9NeXJaeWpuWEs5K3JyNUJoSXVCbDhtUXBPSkVFQ2lWblIxRG5CSHk3NVRo?=
 =?utf-8?B?bVdlUFU5RjhEbVh2T2J4a1JoVm9yZVgwaGlxNThacFY4OWJaN2JyM3FlcUpO?=
 =?utf-8?B?UFFIRTBmb3Z4eU1PQ2JqdmZ0Q1ZyMGZGaThxYWRSRzdrRXNwNm9FYUxSbk0x?=
 =?utf-8?B?N2xidlM4UVoyak82WUp1ZmJnZWRxaFFXditRY2xtdlJqQ0U0OXpkSEh2ek50?=
 =?utf-8?B?Um4yOW5YaDNVTFcvMjV5ZWRqZGdySThRZzB0a3N0SzNieVhDQlRtQ05oQUpo?=
 =?utf-8?B?NFp2NjJGZXRTWVhBaUgvaXhVSGF6bzJzSlFIMVVzSU5WaEtaaHQ0MEJUMWRG?=
 =?utf-8?B?ZnFVQmJ3U2JiclVyV3FrN0M3TllOUmp6YjFuRHBSaUhyZkYydUFPZlhkV3Mr?=
 =?utf-8?B?a1U1cEV1OFFBdG85UFNFRlJNejNkdXBmcU1EMi9XUEVOQTZuT3V0QWE0R2Y3?=
 =?utf-8?B?SHpDNzMvQmhBa3AvaU9za0g4T3Nacm9YUU1rOTY2S1VJUkZlU29qQT09?=
X-Exchange-RoutingPolicyChecked:
	HhI2X5RiFvAHayKduh6X1CfbZwNv6+nQyVX+T8r0HhUy09mWIQMxkct6fzvcdCMzvb/Wl6+YU9L8/qYG158OuS88w2VOvZjj9O9qzgJ0B9Jjz2OqdKt1Kj0lZLfEifEQiKOwme0Gf2NLxr9YVp+zEUk+Rt0inMUzuT7/V+tPn8sia42u1QD806V1v4COGIswzmgbVBMd8Yi1hM1mbNw50TG0VitJeBIjN2dPq4Qur+6SS0bWmpaGO0EZIUCijS7pp7W/NfpR9SK6Zu+Zhxvb671OiafKYZXI1J4znRLmS0t4DvzM9tLvEMYctwZ9ZxDcmYKwYDVKXaZeThBP8sZOiQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863558a8-5079-44d9-fe6a-08df29e6b7d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:31:41.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWrMAFR9UxnEn+6f4otxAcNne4hfkmRN4Vna5e63sL/Cpn7ymKOIAz+Oj9rG9hvJJ+Z0cHpgKwg8M8Zjs9ky4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6211
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfX4jbxW2+H5l1D
 7oG26TcKSsY3DT9gYLwho6o5yWxtjqTTeuAn4i4hPqKwYSRWfwftdobD9ETODaIV/kWExanKh8/
 qaZI3/dDuaIbk5AUYrXx1AQxBTMCbCcsmeNn5BBMq/i61+oU5j2R7eifI9OAUp1xZaGSZ1j+uG6
 VuAkcZ8Kztk8lVqirZu0PHXkzpbmW+gbTE64gbSy20dkdMR9eRfUI2Tv8tPCyTGnwXVYvsnmXtG
 mASemBQ2zKLsV6tgGwwSpjwDy9KI7sW8zrqUTpbT13OfL3wlH4uHZhMSbrR/Lt3sO+sAgPGqkeQ
 yGI+EdsQXB5B39MklkHwvXJJ2COgh0NEzajMUcb1WJEWYXfj1BNJzERpea3IJ6kam+JD6g+JT1u
 VJDDRgDL0h0BRLZCF1uJhs2p7iEf7BfDHf3z38gb8Ip5DHeKNJpAJdWnZA4wX6p3PpC92T65pTG
 UQWKDI+JGZO4cy2oKew==
X-Proofpoint-GUID: PnPDH0YMfMHr_0vcRZCc3iluagRoI4nF
X-Proofpoint-ORIG-GUID: PnPDH0YMfMHr_0vcRZCc3iluagRoI4nF
X-Authority-Analysis: v=2.4 cv=DYeCOftW c=1 sm=1 tr=0 ts=6acf6820 cx=c_pps
 a=1mmXF8F6+aLADKsbn3w/2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=uMr1uQFKAAAA:8 a=gAnH3GRIAAAA:8
 a=ihXmbTahW4TS7H5G568A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=mA13xv-6rAYGTomVCS-P:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfX49fnU1OLwkpE
 EQ2gdf+AcV3ufjBntkoLyjY9mEfXOOb+gbfkmiHPaEv5+CgDfiqYOmkPEjfako3opY3zrKTG1nk
 SL8/jlt7nFvVrTibQW444CGifXdH05JzuVzPOsPDAoZGKfHX5/K8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140045

On Mon, Oct 05, 2026 at 03:01:56PM +0100, Pawel Zalewski wrote:
> This series is converting lists that contain the acpi_device_id struct,
> which is defined in the include/linux/device-id/acpi.h to make use of named
> initializers (which they do not use currently). This work is part of the on
> going effort in the kernel associated with device-ids [1]
> 
> The plan is to convert acpi_device_id::driver_data to have an anonymous
> union, similarly to what was introduced for PCI and I2C device ID tables.
> The goal is to increase type-safety (most of the existing casts are gone),
> to improve readability and to make use intent a bit more clear:
> 
> ```
> union {
> 	kernel_ulong_t driver_data;
> 	const void *driver_data_ptr;
> }
> ```
> 
> But for that to work all lists containing the structs need to use named
> initializers first to avoid triggering -Wmissing-braces. I already have
> patches that implement this and touching a lot of kernel subsystmes that
> use the acpi_device_id struct and that list keeps on growing. Therefore,
> I have decided to split the series per every subsystem into:
> - pre-clean-ups that convert the lists to use named initializers
>   (which is this series)
> - actual implementations that make some of the modules use the new
>   driver_data_ptr member
> 
> That way the task can be fragmented into manageable and independent chunks
> of work and makes this effort easier to review.
> 
> Tested builds on x86-64 and a64 in Yocto using 7.3-rc6.
> 
> [1] https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> 
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Pawel Zalewski (12):
>       iio: accel: use named initializers for acpi_device_id
>       iio: adc: use named initializers for acpi_device_id
>       iio: dac: use named initializers for acpi_device_id
>       iio: gyro: bmg160_i2c: use named initializers for acpi_device_id
>       iio: humidity: use named initializers for acpi_device_id
>       iio: imu: use named initializers for acpi_device_id
>       iio: light: use named initializers for acpi_device_id
>       iio: magnetometer: use named initializers for acpi_device_id
>       iio: potentiometer: max5487: use named initializers for acpi_device_id
>       iio: pressure: use named initializers for acpi_device_id
>       iio: proximity: use named initializers for acpi_device_id
>       iio: temperature: max30208: use named initializers for acpi_device_id
> 
>  drivers/iio/accel/adxl345_i2c.c             |  2 +-
>  drivers/iio/accel/adxl345_spi.c             |  2 +-
>  drivers/iio/accel/bma220_spi.c              |  2 +-
>  drivers/iio/accel/bmc150-accel-i2c.c        | 24 ++++++++++++------------
>  drivers/iio/accel/bmc150-accel-spi.c        | 16 ++++++++--------
>  drivers/iio/accel/da280.c                   |  4 ++--
>  drivers/iio/accel/kxcjk-1013.c              | 22 +++++++++++-----------
>  drivers/iio/accel/mma7660.c                 |  2 +-
>  drivers/iio/accel/mma9551.c                 |  2 +-
>  drivers/iio/accel/mma9553.c                 |  2 +-
>  drivers/iio/accel/mxc4005.c                 |  6 +++---
>  drivers/iio/accel/mxc6255.c                 |  4 ++--
>  drivers/iio/accel/st_accel_i2c.c            |  4 ++--
>  drivers/iio/accel/stk8ba50.c                |  2 +-
>  drivers/iio/adc/ad7298.c                    |  2 +-
>  drivers/iio/adc/pac1921.c                   |  2 +-
>  drivers/iio/adc/pac1934.c                   |  2 +-
>  drivers/iio/adc/ti-adc081c.c                |  2 +-
>  drivers/iio/adc/ti-adc108s102.c             |  2 +-
>  drivers/iio/adc/ti-adc128s052.c             |  2 +-
>  drivers/iio/dac/ad5592r.c                   |  2 +-
>  drivers/iio/dac/ad5593r.c                   |  2 +-
>  drivers/iio/gyro/bmg160_i2c.c               |  2 +-
>  drivers/iio/humidity/hdc100x.c              |  2 +-
>  drivers/iio/humidity/hts221_i2c.c           |  2 +-
>  drivers/iio/imu/bmi160/bmi160_i2c.c         |  6 +++---
>  drivers/iio/imu/bmi160/bmi160_spi.c         |  4 ++--
>  drivers/iio/imu/bmi270/bmi270_i2c.c         |  4 ++--
>  drivers/iio/imu/bmi323/bmi323_i2c.c         |  2 +-
>  drivers/iio/imu/fxos8700_i2c.c              |  2 +-
>  drivers/iio/imu/fxos8700_spi.c              |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c   |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c   |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c |  4 ++--
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c |  2 +-
>  drivers/iio/light/acpi-als.c                |  2 +-
>  drivers/iio/light/al3320a.c                 |  2 +-
>  drivers/iio/light/apds9960.c                |  2 +-
>  drivers/iio/light/cm32181.c                 |  2 +-
>  drivers/iio/light/isl29018.c                |  6 +++---
>  drivers/iio/light/jsa1212.c                 |  2 +-
>  drivers/iio/light/ltr501.c                  |  4 ++--
>  drivers/iio/light/max44000.c                |  2 +-
>  drivers/iio/light/pa12203001.c              |  2 +-
>  drivers/iio/light/rpr0521.c                 |  2 +-
>  drivers/iio/light/stk3310.c                 |  6 +++---
>  drivers/iio/light/us5182d.c                 |  2 +-
>  drivers/iio/magnetometer/ak8975.c           | 14 +++++++-------
>  drivers/iio/magnetometer/mmc35240.c         |  2 +-
>  drivers/iio/potentiometer/max5487.c         |  6 +++---
>  drivers/iio/pressure/dps310.c               |  2 +-
>  drivers/iio/pressure/hp206c.c               |  2 +-
>  drivers/iio/pressure/st_pressure_i2c.c      |  2 +-
>  drivers/iio/proximity/sx9310.c              |  4 ++--
>  drivers/iio/proximity/sx9500.c              |  4 ++--
>  drivers/iio/temperature/max30208.c          |  2 +-
>  56 files changed, 109 insertions(+), 109 deletions(-)
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20260929-acpi-iio-0a8198cd3198
> 
> Best regards,
> --  
> Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> 
