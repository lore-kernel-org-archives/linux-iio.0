Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792766842;
	b=kWviTNQVTmPMGbsUKymAYfX6MF0lbZKUUpp0b5yNoPMkcEnINrx7D1oHz0HS/3/JIgQ6
	 YLSifb1C5R5S7sPwoYkfdMbt+g8VNbUpD306SamrkKCM1b7B+RB6cAd8QTQ8PXslVl3b4
	 93EeK6V/6GVUKRf62BH6pkLwflUsLKYI1i/VsHgU5bfOCYRl/Fr12yutO5audL6EHwRtq
	 GBmAmLGj5OfpnJ9ritJRFP/N+cqlgyYuxj0kjdJYwdmMIUOhaPrRxm3XnupZiRRCSdIcq
	 p8ZAeOYsBTzIWZHUE/eWdDpj8chTBXKgtuLiwIq5qd+2nIifn910v6tQ9Zq32VKEZjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766842;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gP6SB+wBpWArtEHBzr6QS2Bdi/MhIwoohD2FLFtexD8=;
	b=q4X14vgK41wpnXtwSwGbflmOS2Kzg40+6EFixZ0oLUyGKIQMO92xAoQhAPM4ScJJWVGW
	 10XNsOi6+svPs4chpbZcxoTikTT6M9UJ8Y+lFIgXR3fdeCr8lPSdALz0QBmVWbWhuanLv
	 GR8n1LJV8ROzB45ijdOAIN9bW/no8Nq0c5zsNWrM5kINHLyjMSZu2lVbjQAIRt02Nj9WI
	 CnZvbr5pTb87Yq9v66nd+9qKCO+nN4cb4Ys/Jeyakd2xIxnWs5yoUQHVERnRT/4Txuzb2
	 ydaOIJK9bCSc21948fyu72TXWSEcqQVa1TP2/Q2zBSS/Lzyqh9o40Xsr+yvnYHeYM1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BfAxCmwD;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=nweWRnTS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A83606A31E;
	Fri, 23 Oct 2026 14:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A83606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BfAxCmwD;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=nweWRnTS
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE963V2064623;
	Fri, 23 Oct 2026 10:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=gP6SB+wBpWArtEHBzr6QS2Bdi/MhIwoohD2FLFtexD8=; b=BfAxCmw
	DzAuM56VoGLU2hvACjAC9FakvS1VjgOrprtK/vTJLd7jLe5lgkyq1FkOSnJRMJTp
	2hiq+y8tgMkErlk5elzolbRJTpSjG5BnQ/jIa6YL0VnF14CmI1dSzr97y2cMOvcp
	LhC/2yr+ljFEctYUqqL8mmoYNoyxZGb9kjC1udbAGdMrCaQCDUiDtbXs2cipBMwf
	VUrhNzrZGFPGNbluMdSDoOj8dRGRta07LjGrV9WHs6fhVczPltPvR12m6zEWdEvM
	vUHf0itoIewXQ+WzTyylberjvFl1XpKWiAa6tLTRfq8coejI/gJclbm17iQdeS/x
	eV34soUSJmWcvNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gP6SB
	+wBpWArtEHBzr6QS2Bdi/MhIwoohD2FLFtexD8=; b=nweWRnTSz/8MGk7gEdnI7
	5QV9Yqj9UUFoA8bhJyLNW/fu4Q/V33BjVw5rmgaZylO7/gTtETMBp4RpxzzEtUy2
	QBSpEoqInx5CVzkoJUp65CIx/XfXzMmKAYhVQELYYB7HtIkOS3PUIChAaOPcZwrN
	DKI2F9bNy0zOPcQMC8ro5dkZQquP1fXxVeq1PYPP90M0r645wcgco7WeYSSDzcHM
	l/iUvenVG8SzeSB47tXi2VFFRhcipMs82ymV0dPcVrMqa9NVCLHargciU2axHKrE
	6DzxRPPpvCSMF5oZIaAJ1t4OPBC53ZY4NUDPJktIb8Vf98JNpLbV7k3I2lnxD4oY
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg35725y8-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 10:46:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stnicT7B/gOoXQ9j856fwKyxmfT17kypWfaBi5kLC/SNrIDUlVSod1cPL28LWBeQLem08dXLaVcl/nnBAR76V+hQO9YEEgEU2Nyqwe6KUqk8Xny6EtBzOUx++ysnyo7/guIlK2wMT8doKa89HscjYAP0mGqio+4g7o2H9eDufVgmntLUxkFx3BJuaFKLFrR0GVan1kEOTubVYZCFHuJaKkVt1j5sFq6vRlGbuDVBXOve4DeIstPceZIcqA2QzAY83lTSfaKkvv2RuNQXoUmUOMXvEDxipmFx23Mc3OJNBjnPx1p/rj92B4FansXEOMjai9q9tt7GPNMBES9oiY8EFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP6SB+wBpWArtEHBzr6QS2Bdi/MhIwoohD2FLFtexD8=;
 b=fSK3sk1Z//lNdrj4DNiuoWEnrwG9L2jG3YDIOseWUikjYeerdDpgVOGHYTb1M6O2IAU2fIVmzmNm8TSAKFCM2KJgVKDjxYSKIfznfJjeKhMrH0cerALFjOOYDfl8ERGbC5mLTqPT4r0CrZXtKhKIofN8N6IhGUYtFJDvSfFV106idkYC7f3dXKmj1HYH+jj5crSfgpCYW6FBhFLMbHO/a27StpX8eyLfZEFQ+e25mIgs3EqjjJEbJyZTdX1rVTM6QDcTA+TZBaqTMxmrQDSVIXYfi4mWqbVddPtzvhKEOJteCMDN257mujP9V+5Dg8g4Fk8FIfwcEXizT/dKKRr1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5725.namprd03.prod.outlook.com (2603:10b6:a03:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 14:46:46 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 14:46:46 +0000
Date: Fri, 23 Oct 2026 15:48:08 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
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
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 07/10] iio: frequency: ad9910: support drctl control
Message-ID: <attyyTaW3IRJQ85r@nsa>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-7-0ff7f0bff326@analog.com>
 <pg7pcjaaxuu6vmi4qowgaefyo3mynrvmiu6iazzormyvc5kiat@4hiqrtwbw2gg>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pg7pcjaaxuu6vmi4qowgaefyo3mynrvmiu6iazzormyvc5kiat@4hiqrtwbw2gg>
X-ClientProxiedBy: MR1P264CA0199.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f706ef-d9b0-4b28-6bd7-08df31147654
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|261009223027099003|56012099006|11063799006|261021121427099003|4143699003|10067099003|18002099003|22082099003|6133799003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
 uf3YXd7Nq5PtvYQMpiX5LQbI6nOp0aK4QeezqCIazsESnsmGygigc08fFQo4cE/2jMoJyg9Ta2vz8ONZCpVhk/xfCSlrl9BOhkPaFmjUtMe6eDa/vMcTGRs81x37ge6s/gheQIX5sey2vF3mldGxaZ55AVnNl5xlGYIztRG/gzbLog0YJ06G5ShaPi5slMbyEDcH157TM4OgaPwct4oayWt0Dzs9UrFtgHTUAofmrgusBpa5U3Bko03rjiPskYTDUbKj2B0M3Tv28dgZf8zFTV+JCO3+xjWd2mk2kJ+Y+ChzpCuiB9Qz2/bJGnmEdiZatHkM4Adlmz+W1Si3xBGTSotDggzcmesUXBcy/wZwc2UsWMVGV3wJuwJv3uUwmvMNT/yPTf7qvNokdGYz5/MiurlOIRxCxHbj9zLGEle1tA3Ah76HcusmF7mPQlGma0Hda8rO5uGfAumKqB4Gy2c6vmZNBmMfIq2d9Ek/EOR56blvZBtZQfn0gmCD8gjt4BVFuS7KOvoCOrBas8zIDcG94d5xudBCcCnfQYMR2xpGTPg1/spw1jrAsBE9X9fm+VZ4ezaihMAJqLsvvxnUHVtMN6ebZrscop0IpX7523Vtl67MZJzktth93tm437gp9WMq0U3wVfHzrG8jApxXSNEDxyLbRQJ+4jVgLV1iHfW1gF0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(261009223027099003)(56012099006)(11063799006)(261021121427099003)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QUZIejA5UmRCNXh4ZkxmdHJ4ZGpZSDRzZnlySmNFRjRIYVRYTWRUQ0lTMmpE?=
 =?utf-8?B?aGkzV2VqRHh3aENzWUpidkczYnZpMVcvQWZnaURSZi9oTDNwMEl4M2RmMjhW?=
 =?utf-8?B?UmxZUWx2ZDZkK0t6SEhadEo0Y1ZZT1hERk5UMVI4TnpvbnlGTTAwMEYxYTVT?=
 =?utf-8?B?VmNJeXNCMDE0U1p1djc3WU9mbE5xazNGWjBFb2svWVdpRjQybGxjelBrdWRt?=
 =?utf-8?B?YzEvZWNwUGNWQ2w1ZzJ6aDBRUFplbEpzZk5nbFBNdVJMNDBaRzZlSW51OW5M?=
 =?utf-8?B?a3QyZ3ZOVVUyS2Nzb2JGdjJ4d2w4TXc2eVVrdVE0TTkyaHVzTGUwbXNKQ0hx?=
 =?utf-8?B?REVhQWNQUjZwb1ZPMWhRM1NoWDdRZFhsZHgzOFdRNktEM0V0eG1KblIvTk5x?=
 =?utf-8?B?ckxKM3JBa0FXNTlKSTZ0WGx5aVBsR0Q0a0UvN2M1SEphWFg3aDJDQkZUdUdE?=
 =?utf-8?B?eEg1aVFUQnJXcGV2azNLZ2pqeXV0bXVqNmkzTjR0U2FtYm5nU2hrT0dUMDJ6?=
 =?utf-8?B?QWRNeEdnNDhITm5NVDdRcDNHalRGdGdmZTNReVhOR0RHZkJnc3RkcTJXRlFs?=
 =?utf-8?B?QUo0QlJhN3dXYXFIWVpXUWlhbEdac0FUblducnNGeUVxM2tlVXEwNStzRDdq?=
 =?utf-8?B?dWFTd3NUZW11eldNQXlWdzFmK09RYmlRZlNyRG1rS2RDS2VPM3UvNEUxa05E?=
 =?utf-8?B?NDduYlg3bjMxZWNYekF2YmNMdnZCRXhiWjlub2UxYlE4eTgvQ0JVMXIwdUNN?=
 =?utf-8?B?OHczQXpGOFVVeUcwVldSZDNpZVIwMmIxVTd5ZlhPc3BjbVdsdWgvY1pSM2dF?=
 =?utf-8?B?a1dQUythZGxMSURQNFZKaUMrdUxZRVNJYTBuU2RRSHl4d3RJT1cvbEMwcXhB?=
 =?utf-8?B?Yi9BSXNQdkZDYjNHVnFMV1RsWlcySkdYT3lENG9DQUlMTUNvc3N3NXg2OHhn?=
 =?utf-8?B?THhYWFRPcXc0UWZnR0x4OVlhWlhzWjJqWHFJeklzdXZzY3VJWlNac3NybHVJ?=
 =?utf-8?B?NGdLc3IrRVJhUXlHRVIwdTA3SVN5SWVvRUJxdm1mTjdQc0lHVzZ5SmRlR1J4?=
 =?utf-8?B?ek81RjV1SDEwbm44M1ZoLzB2UUtVdlVROTFvazZmQnRERjJMUEZGUFFPdEhq?=
 =?utf-8?B?czVnTDR4bWpHZDcwSC9XYlExRU5lakdMeVVhbGtEQ3llN2xWUTRIdzBwYTN1?=
 =?utf-8?B?dnpqelhUUm9mc01qUXVDMmdhVEVHd2NCWTM5SVEybVhNK2c2UUxYWXJiNFZu?=
 =?utf-8?B?Z0VySmtZUzZrTGhJWFdveGtWYndGNzU4VW41NzNOZ2JHOXJxQUJnNTRJMHVq?=
 =?utf-8?B?cHlYUGdmOGpZMGVNNEpKaTVzaEZ1TVExcmNoTkdtU2RFRzdnYmZlZ2pMVW9M?=
 =?utf-8?B?azZXSGVpSXpRcWhPdWxhOE10SmR6VWpvaTl1bmd4VVBRZXNGdkhPUTdxWjJT?=
 =?utf-8?B?eDUyYlJYeWIycW5UVVJ3K0Y1UWVTR2MxSlRqVkdsbDRGZEtzMXdjOUU1TmJK?=
 =?utf-8?B?MzNOcEl1QzVqdmNzL0FnZWF0TSt0dFhmOW82RWV0a3JWZFV6QUgwOW5sYlNu?=
 =?utf-8?B?WFJkWmczRnpOSzgxNnJnTHBWK2tpQkxOMTlFWjRjeXpXV2dUVUxSNEFFdWhp?=
 =?utf-8?B?bTdXaTJBT3JnT0JHZGtTV0NUaVhBTmJSR29UZ1NHOFBNYnVoUUVhTURWZHJD?=
 =?utf-8?B?Mi93cXFoSEIxZkpUYjA0OXlJaE9TOGVVR0xTdkR0SldQWCtDRzhQQnRWU1F6?=
 =?utf-8?B?NzJDUVJodkhhUGFUdWFyQ0Z0UmprYlZkYVdra05YTnMvMkhydHRESEg2UUQ0?=
 =?utf-8?B?cldWN0N0TnVNd3dOY2xMU2IrK3VXU3o3dWtOM0RhMXhWN0lUZ0IvVjZjZ1ZL?=
 =?utf-8?B?UzVTQ2wwRTRxNDcrZm1pODBIalFSK3RuZVllL1FWR3hDQXRBT1I3c1NlZmlx?=
 =?utf-8?B?d1hFVnRjVVp3dEI3L2RRYmJQTXBPSTNoWms0UUozZ3VBL1QxSXU5eStTcUhk?=
 =?utf-8?B?Q1BmLzBrUWJJT1JqSzVsVWRCUGNwR3Y2SVcwalV1VlYxcWsvbk8zTDFSa0Iw?=
 =?utf-8?B?UmFOZ0xCZThkaEhCYlgrTmVsN05wQ0orUHdTOE9VaUc5cURkMm1HVHptdVRE?=
 =?utf-8?B?TENqLzlVN2kxcWhhQUtIbDhpUFlGcFBlb1NmaW1CdWRZRlZXVTJoVnpaNEI3?=
 =?utf-8?B?TW1CYkNHeUxYWmNJdXI5OVNkcEtHWlJ1bVFOYmZTdTFkK3NQV2QyTE5tOEVp?=
 =?utf-8?B?QUV5dnptWXgyaVFkOFlEdUo3MGpCSzloZ3owK3RtUmlHc1VEVFJoU0ZzK2M5?=
 =?utf-8?B?NXhPYk1GNnpoWG1iVlBKdlhDSkh3V0o2MUR4WG1uRkUwZGE2QU53UT09?=
X-Exchange-RoutingPolicyChecked:
	VVtP2a4xPtxLt0lbwuAaCWeXlKRS78zdMV3lGLpeXgC+lMbrjTKJj4WDMygQiI+d4wieeVpYvivfX756HMileqtnWiqI6ApoNU6DtqdQvTdRqhZS6V1qcMZYvzirC4SLppfId+cyk9HCupBIfc8j4KHZ/uYpvN7CGEq1rPiwxLFF75+V9eUyU/LxWb/KEag6RyZhMDjxQV6oR4iVC7HgXddH1ataXw66IpguT8cqJ2TtwthkdheiJ1sPaaRMdo4io6SLx0AQysyNiooMQdAoPU3igdDz6rOFAvAFHN1IbA5ZGR8eEQmmQMGp6g9W8CEkWc5D9v151tNtYim5/BzZ4A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f706ef-d9b0-4b28-6bd7-08df31147654
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:46:46.6082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvpuNW2PWCGx5WOwFj40hkMdeXZQ8XKgHjKS4t62yxqkQRWG1YZYGjuSZ5oXJXRtnSTsi8vut3b5UpvpHZSKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5725
X-Proofpoint-ORIG-GUID: XrzuyfDdRUKWnLRCybtl11cUObacRd2H
X-Proofpoint-GUID: XrzuyfDdRUKWnLRCybtl11cUObacRd2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX9C5pSxGc4hoC
 HN0eQAqpRPVQZ1jlMuPMmraQfZBD1bRPA2w+/8pVyvFbnRZ+HzTUFhywP792N3fObKmRFYsZxIi
 5IPTPzAKlaA2pYO+C91pI+hAL3o/dPtKR+xp7qxn5QoXYKpjPmBpn6ef09sC6M5a9vtw+yku6JL
 AE2e8OvgGcTcOsE0ewKuxKzsXyi9s6pep6ojPmeUSkpTmmMMhT/0LWAS4Rct+oQip7C1YSizfz6
 ecSVpAmS8fqfXLWUxGvSR42CC0ewLzktxspIAvIYLyMzifqG+Z8cM5NW2QO3vkLv4CH/lKSZoUY
 ewQrvkYq4TARSsiTCy+aREHnzrp23S16pmYZCNqS+q05BkfwDAB6pMKdCgfl3mzaob6qYj/KSpM
 C+4oJT8oS8KDpLTRNl0hDQtMEXg3yZFiNygcLRRRsnT2nJt1cHRRqZhltV6lf1xsuFKhZKypSUG
 MgrSAep7CHq3/QLlOWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX+/trd+IvUavy
 1XhGY6t1YaruslMrGdZpxyZz6PwzCabq1FiMiWM4awb9vQDB0DSs/7vndky4Dg545odHjsEIA+5
 Oor9tZwDfvoAOkrLl2fDT3ewE748b0NMS6fL/EVqFHwIOQ/0OuTf
X-Authority-Analysis: v=2.4 cv=V5PoQuni c=1 sm=1 tr=0 ts=6adb735b cx=c_pps
 a=0FlYyfQadWprtAtRvkXThA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=Z5eeMhe7xFRBnsWxBVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230057

On Fri, Oct 23, 2026 at 07:40:32AM -0300, Rodrigo Alencar wrote:
> On 22/10/26 12:19, Rodrigo Alencar wrote:
> > The DRCTL pin controls the slope direction of the AD9910 digital ramp
> > generator (DRG). When dwell is enabled at a ramp limit, the DRG holds
> > that limit until the next DRCTL transition, so the sweep pattern is
> > defined by the waveform applied to that pin, which can be generated by
> > a PWM.
> > 
> > Get the optional "drctl" PWM and expose the integration_time attribute
> > in the DRG ramp up and ramp down channels, which sets the time interval
> > assigned to each ramp direction while the sweep parameter is accumulating.
> 
> ...
> 
> > +	st->drctl_pwm = devm_pwm_get(dev, "drctl");
> > +	if (IS_ERR(st->drctl_pwm)) {
> > +		ret = PTR_ERR(st->drctl_pwm);
> > +		if (ret != -ENOENT && ret != -ENODEV)
> 
> Sashiko points out the problem with passing a non-nul con_id to devm_pwm_get(),
> which would get us EINVAL or ENODATA from of_property_match_string(), and that
> would break the intent here for an optional pwm. Similar to what we tried to
> achieve with an optional IIO backend. I wonder what is the best strategy here
> (ascending order of complexity):
> 
> * Use con_id = NULL as DRCTL is the only pwm signal being considered at this point.

Likely the best option for now. If you really envision having other PWM
sources I think the most important place to actually define the name is
in bindings because then we need to care about backward compatibility
(typically case for clocks when we need to grow the number of needed
clocks).

> * Local workaround by checking for EINVAL and ENODATA too

Don't love the above

> * Convert error codes from of_property_match_string() in of_pwm_get()
>   implementation and create a devm_pwm_get_optional(), which would only check
>   for ENODEV and ENOENT.

I guess we would need more users but those should not be hard to find in
tree (But up to Uwe I would say)

- Nuno Sá

> 
> The pwm is optional as the digital ramp generator is one of the possible modes
> to be used.
> 
> > +			return dev_err_probe(dev, PTR_ERR(st->drctl_pwm),
> > +					     "failed to get drctl pwm\n");
> > +		st->drctl_pwm = NULL;
> > +	} else {
> > +		ret = devm_add_action_or_reset(dev, ad9910_drctl_disable_action,
> > +					       st->drctl_pwm);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "failed to add drctl disable action\n");
> > +	}
> 
> -- 
> Kind regards,
> 
> Rodrigo Alencar
