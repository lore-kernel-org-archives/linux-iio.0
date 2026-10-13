Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D850EBE8;
	Tue, 13 Oct 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904120; cv=fail; b=sEnge4KsO6/9cULM+rzxI+h1ys5oZoVly3phOjV2EcZZul4YGAWQJm/MQsmGX1IUnwU2YJmbNzD+Xy3C9Umqqkgo+4cZox2NL9AJfATJ4SB0vvQ+KSrubbSxo9HjX1V7wAVUXZbnkk8U5JVcz+ZOjNCQ1FzZDqoPc9Pss0UvW5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904120; c=relaxed/simple;
	bh=KoO04kbefe3PPFDCnpVP220oWYq5lp0/Pyi/Vgtsl+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sj3gPJADG51gUtTRREAdvqGICBF/dk2PK4pro5aLlbG8K350ELGvyibzI/RC9Cgg07tA9e10ENmERHYXK4CRziRCK1e61VOoWHNFFDEkjbAR9xSuFORr/KfXsZeZk8aQOqvEMxjMTFoeb44lhjVngZUT3EHG5pIgA40yZkvmX54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=bLBZLNkI; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a5oYkjzm; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="bLBZLNkI";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a5oYkjzm"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE2YOI371491;
	Tue, 13 Oct 2026 11:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=PMNshSx37fz40lKGegkjbcDDOonp+VAsyDrLbcetprU=; b=bLBZLNk
	IkU7K0Smk48j4VMn8Nw74EcSaufRM+DK6SkyVMiSYP8GDmMHZ2ePrmSgjg0Hwwbq
	g65KqsVeQ0RQO8VTqwvG00jJPDTt1ZbNv8O7W+50iUrrw7XxQ1MFKhiikNQYwPyY
	Vv353wlmOp7uXIAuxy7JkVvg+gAUktvwFYGd9nCbPsaiFWVrfjnWfPU6OCCP9kpn
	E7nHn3eHm+ljnl+u19CsVIo8cS04Vbk9WvQ8CFZZ0xGR6g8N60whFVaGgtHOxbSa
	hTiWSwyO6hFnqzZ/0itqgPquHGv9iwn8J0ie7Gkwy0EE0u9tylOtTOX9zP1yjTgR
	jyCMTXY5aTuEdjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PMNsh
	Sx37fz40lKGegkjbcDDOonp+VAsyDrLbcetprU=; b=a5oYkjzmMdPWSE+Sqb2wj
	JKy66NywTed5ciXu8k0J55VMmWXy9nwwKNc/Xb2IrwlHZ65fGPGqMIa457M68hvz
	vDnDxm8Bk8SroZEibT9jABYLY2NUMFBQQG5RrQLdFB02dAco3Bm66eNNaJ5l78vW
	aBLzJo6+4D+N2Um0l0TM3eSbDSs6zTlN6E1aAIeRU107Kv7mlIhmeld+bzLZlhT1
	oclDa9ikt7j/HicBSnHmxhTEzngy8hwcxU8Mwa7Z5iNrCTJcc5Yv02ZSJYQAlqnO
	Z76aOrotbXJA5jsRvnDbIL77+k7olOHc8ueckRSFjak9LDnSut+GA8NAZUWKdUEm
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h95uwnveu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 11:08:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWly/84d0Iy+ItuJy9yIDl4P52n2/3MmPTSO5Hn1AcxhoA/usqfNb7A+ZagGdNICiborS0EtoAhxPi5BcDyGzrVkHu6rZ/urR/JQhTgUV4k0eftUnDzSc0nN9YuWMrsAvhJWTyN36001/BXNTJrH3XKszhBHTxJSBMsQ9kpOTTa3kth1R/TO4u1IdQa0FBjccYXB6Sr7k1zdwzx+Qvt8goadgHdp3JpM+Jwc8AACD/mAOZWy4262FkFxmB6Gznxffr1YTgZ9a2/R5GKzrCYje+0tmOSzIxBfbEe8yOOPeoVbC/3eEB1poDVhsx8syit4D80WooxNYcDlQKM3I+R9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMNshSx37fz40lKGegkjbcDDOonp+VAsyDrLbcetprU=;
 b=n1F3KzNvCnOFmz3nXAeDYYzCMg4hmFS68Rv5A34nbJImyTq7MQ1YdHn5K7lyVnSQRwzfC6RBL0yv1KUszBrWxwUYjBeEqGKATHLvZrOEf4+oB+SSEQdnuUC8ZPh6CqteWHTLW1IeMaU+jqFuK3AWbzbTZRcRSNWJ6bUIZSxV3P13R2hLyoSHcspDY5dyl8iH2GzNvcGvh0whfUNzPIxEKFYIuks1uloW9anqVRmkBiNV85Zk6O1aTxILiKPeOFigEHzZUJ4MZSvgae68jFO2h/3IQcWhrzvWLxIaR9N8c886vnQugdD67Vfz/3OYcp9h7qL7qUhomtLRXzpy12lfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by BY5PR03MB5062.namprd03.prod.outlook.com (2603:10b6:a03:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 15:08:30 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 15:08:29 +0000
Date: Tue, 13 Oct 2026 16:09:46 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrei Stancovici <andrei.stancovici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Message-ID: <as5IbgaDG3FWby3G@nsa>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
 <179189735509.1005940.16593087405634433360.b4-review@b4>
 <as45F3tHGzTc6lMk@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as45F3tHGzTc6lMk@ashevche-desk.local>
X-ClientProxiedBy: MA2P292CA0020.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::10)
 To BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|BY5PR03MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: a08b6fd8-f58c-4801-c103-08df293bd468
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|10067099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 u90sHs+QX6xC4985ZuY8DdpX6k3hXwrrWBWkZn9aD7ODGC8cTbpLLrla1qsQXyQukxd+MFL7n8ODEev1SspJa/iHODxtQz9qtnPu2Hb7V5oYe5vPv5v2l6QMn6jZ3nIOTvFGb1HE4fVAL2zNFUgF4fueS436Ww8YZrohQTZ9k1wT6UiZCLnqJCHG/KaIldzMTbkB5Hg9G0rpLaYfCJMhdwosmh+E5q2YZE5/RFoJYaUdBQxxiktCXZQJXL1t4L1T95eWGsXgk+eXthVQktd/HhylnCvN/pocVHZylJBWap+RdQRrzebP/2fa8etGdylQH838HTNvF4tt4EFkE1wzgmEnPka0PEuvY6pnMcrd1J7ExpE4SbGEcAO4Pb6HT5OG1dfC6UZChdYOuGfJ4DFqJm7ws773ranWhETq6GuJKCBTsQ0bqa5YKI81nK8vSgs3NOz8XdmuJJzkZBv+9DSLrsrCEEp9lwqXXBIAC7mZVg6e95HBO8BbQP1B/4hYlstjRAFlBsOHa/q/mWbgCcungiTsk30n6gKlq5UC1SymlU9uzAy0Krftt8l0QtNQkNZu61gI/qBpX2vDrA4qfGp29iVe5HIzSeZI0oeBCVmMGlKAdng2Bj79o3h0sJky8fDeUf4KHhXAU3J9LdU18LmXb0gAA9Md+VLBlPxq3TcTIBM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Qi9Cc0g4TndXYUVkWmxBTHQ5UHlhdCtabkdjRzY2Y2tpK2VYM2ZmR1FRUk8w?=
 =?utf-8?B?WkJuUy9GdC9wNXcxQ3B0dEpzNlhoQlNnbkNDSlBiaGNyU1J5aGJ1TXNpWnQv?=
 =?utf-8?B?TzJlRXBxOVFOem0yL2JrazRRYzlLSytEWGZhRjBXRE8rOHp3VEgzbjNPRHhl?=
 =?utf-8?B?L29mK3Y1N0dKZ0hiUWcvYURFSkd5Z3dFSlpmNUxPOGp1Rm5tTE5ZRWo3MmZu?=
 =?utf-8?B?TnlLeUZybnlBVTBvdDJjek0xTkNuYnRLRUZuY0szSGtMYkkrdTF5Ly9PcTNr?=
 =?utf-8?B?UG91L3g3NUFTb0RvYnJQZXBSODE1UXNWaW1HR293TVBzZlhib3lGa2lXYzV1?=
 =?utf-8?B?SFp2TUlKZ1AxU1VUQWZhQ0QvMWd0SWxGWjFWVUhISnJGQzAzaWRVOVpFZnAz?=
 =?utf-8?B?Zk83QVI3RU9ReGpCRmxpQ2ZPWUpUMnp2R2l6eHZCSzN3ejV0azJsMmdoZnJt?=
 =?utf-8?B?SXRzUHk4dC8vYzdyVzBLVklhRzF0OGlvcXVBQnpKS2hSZVBxSTh1TURiZVZW?=
 =?utf-8?B?N3JGY3FEV2FDOU90b0RHbk1jK2VuQUxxa2pZMFhKanpkSkdJQ3htL3JOSEF2?=
 =?utf-8?B?eU9NMVRpZlJBUlpuUzd2aDlCSUxDWDIxdGpMYyttZFAxODlMZHJ0SzhzRDZJ?=
 =?utf-8?B?TmFqanUreThnSHhRamcyNDRkcmM2ZlJvc1I5eXdxdjMySVNTWExrMFlXT1kx?=
 =?utf-8?B?S28xajdBOGVWcDRXcUEzSVlFSFZiZDJTMEJMS3ROdUhYQmtuNHY1ZW9jdVBw?=
 =?utf-8?B?U3JRMS84VlQzTXNHYUp2d2x4NFRSbm5GWm5uYnJGcGo0azg3ZWllT1Y5THZJ?=
 =?utf-8?B?SkMweExqUkxHSjFzVmd1R2NZa1E2K3V4SUEvWnBkSDRxd1pmWWR4RkdBb3dn?=
 =?utf-8?B?OXg5Q2pYNmRhTFEyTS8yYmsreWU2OHAvVWVMWTBJZTBGWjQrcFF5MjdrYU1j?=
 =?utf-8?B?SlJ1UFdwOUlHYTJqM1hyU1J6VDlHYTFEaGRIdnpCcGl2aGtZcWM3SGtTOGdM?=
 =?utf-8?B?dml5c0F6VGllZEZmRVJvckFjUXkzYWYzQUYzaEtFL2ZXWjYzZXhDRDRZYisx?=
 =?utf-8?B?NUU2aUM5V0xlcmJkcGtXOHQ4YnhQdzRQMUxHQ0VKdUJvaXVJR1kxRmZiM0RU?=
 =?utf-8?B?UkNhSUVOUWFkdWJxTXh1WHFUMlhnSUxFN1BrazZtM0RrWE0reE92NDhXaXVM?=
 =?utf-8?B?dTVCampaTmRsQWpTZG1ZMEdITU5qU1VDcTR6QTFqRHZyOUh4cFdVRUVNZmhq?=
 =?utf-8?B?WjE5eW5jYnhNRGcxT245ejVDQUJqUWUvenZYY0dXSTRjOXh4Mlg0WTVQUHRx?=
 =?utf-8?B?R0c5ZkZGTzBBR3NxcGhuM2FhQWhSNXd3Um0ySERobEJ0eWVhdlpTNDd4cFBP?=
 =?utf-8?B?eUlhOFViU3pJNVZTWGFwTmRpdWlKZGpSYTFEY3dDdG9GbGZYaFViYnhXcm15?=
 =?utf-8?B?WDc2NmFxNGR2ZjdxS0FtSmFyelJoNW11TXRQWkRQeHgyWVdGUGxJU2ZOQmxM?=
 =?utf-8?B?dzRmZ0JmSW5vUXpFd3pEaTNSQjdUR29zaW9QUHlvR3pjMjl3OHFyNVp2UGZi?=
 =?utf-8?B?Z0ZmKzhtU0twOXVlRVo3UnhSVkphSEQvaUQ5VDFndDBRYjJoL1dDa25KamR0?=
 =?utf-8?B?SjFlODRWa2l5am1FS3BZbXY3eFI2bmFqRmZmYkwzYWhCbzdGUEkxZHQvMVFH?=
 =?utf-8?B?UlFVWnJtTkNHVkFUK1Y2OTU4WGxiS1VZMmYrMGpUY0FiS1Bnelp4bXNRT3g3?=
 =?utf-8?B?UDRHOC9vd3hWeUZvQ2tUUHRxMFdNNmpBdnZFbi9STHU5RDBiRVRneDBuUTdl?=
 =?utf-8?B?L21ZTDRiOVB0dXZ1U1k0ZUd4NjE2bEw2NmpPVGV1RHQ3RERJc2IvSzNTdGRM?=
 =?utf-8?B?aUE0NmdieE1GZE9sL3J2Z2c5M0kwUnNja1ViUjNxMkYxdGtXU0h6UzlPN0ds?=
 =?utf-8?B?eWZubnVIZzJuTWlFRG1QVlQrR3JNZDViTFJ5T0VaYjJBcXAwNUVjNzR1ODI2?=
 =?utf-8?B?cHgxQy9ReFl5cnNOT1ArNmIyVHQyeWJsSWFIVnkzZEFTcWcyQ1dxNTh3SzhM?=
 =?utf-8?B?UEVteVM5ZXZjSXZMdVJ2b054WTBrZVJhV0dmYXh4eG9kVE5ha1k3cDN2R24v?=
 =?utf-8?B?OVd6Z25xUnF6MHp1QjV5eURKQlRuVlVWeXpxUWljY1lWbTJ2VkVMYWtUN1R3?=
 =?utf-8?B?U21HbGpkcWtPNzY3aVpRN05tY2VzaVl3MVFEcmlRYnRCdzJMQS85QUtsSmd1?=
 =?utf-8?B?dnNFZlBYNE5HbGxJZ2lOS1Qya3k5QU1lNkFoUlpWbVVUemZOY0FrdzR1M251?=
 =?utf-8?B?TlRmMmxjenNpRytrQmgvbkVUcFBLTDB3S0ZzQ053ekN1OFJCdmJHdz09?=
X-Exchange-RoutingPolicyChecked:
	jtOWbNYF5v9RwgGfk/AuSVFU2K2SV3Ktn0FaDu5jdUxDal0eRh1pBvQq1I9X3oLYs2t52REKtizqhzIIAcsMJKrDRgOWTDdaPdppuAFH0X+XXudFhT4B2dS31bIzwtpGU0cFA45Ml26YuPC5Q864SIwoW+svnATcFyC4YBKcHHtmv6DS+LLoY7av/LgdBjp9ozAx8JunIo3WKHJA8orRbmV2XTQdhb7s2eIK2Y1ROXkT53CGYk6gjRFH+dZ6eV7LjqmG/J4ZyI46GeqZaR4neIdh6R5iIBzPRyuWtd28Bb/nI2dxKUDeGaHcW2A2xBR8ajccLwWFJtt8PGiX9pQlTw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08b6fd8-f58c-4801-c103-08df293bd468
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:08:29.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSoPIBUgI8JC+c8rnfa+ffPVKBG6McRFLv4cqdw54XA63VIS5w+ST0CwYj9kvsDv47TaAzgaPeRySY1hmL4aMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5062
X-Proofpoint-GUID: 18wEWUCRSdslJOT8HdUebKhYTPiFzOMv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfXxyVdL7PKgir/
 YbeURaViADB88qjO6TteOo+yIowUTvQnEtKUWGmn/MMDRJUyeMMMwfuN3kDYmUWakhSI62l0NHI
 5/uVg5rqQBZyoteWAw6Ki4acfXZFRLnF554uSxWB6qcuVo7HKfF2
X-Authority-Analysis: v=2.4 cv=ZPxCCn7b c=1 sm=1 tr=0 ts=6ace4972 cx=c_pps
 a=Wb2dZV0zRm8mlnqfvkE3cw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=IcDte4WQ8Gvv46dHiTsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 18wEWUCRSdslJOT8HdUebKhYTPiFzOMv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX1TbLwOYtIIcX
 qS4RkpzpJRlQ8WxdTnKn2Q5RQlS15hvJNuo9SzXQRJitJF2/3nU36zIKflKJV1L4IbbrF1VMGv4
 vAhFxMr8vx2YdRpRkaObACl+MQo3AZs5pYbuvUILRFMudVCT3SyE39imUtr+/LO5iBcM3tJypUY
 8uPied+3UuDsMmp2uXsbvebiUJZbVPNQfzkiFXfI8fRzD1fv4kwS8M6mdSxNVx2eeI8bna8htIl
 sDet5427xELKOL4y02RFjljH0PUyRV/qRmCOC8WG2XwpJP0cxOc8B+gqiS/K6tgYPdQcW/K5kql
 W+/3rJuyN6w3IGjZuaCAQp/AXgoiU3hCAINZMdCKIQA7vKDipAGe+iN9h/3ooYRj9kk4nlF6IUW
 uDu0DYsl91y5p6a5ltOoi6lhU0RGJiwT2ZWOM7stPHMvhsyZlo9S9WM4aik09lw2TQp8VXQBXfp
 sxxz/CW+W7JZ4Xtte/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

On Tue, Oct 13, 2026 at 04:58:47PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 13, 2026 at 02:15:55PM +0100, Nuno Sá wrote:
> > On Fri, 09 Oct 2026 11:43:33 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> 
> [...]
> 
> > > - pyadi-iio hardware test suites: 41/41 on the LTC2493, 36/36 on the
> > >   LTC2499.
> > > 
> > > The series was rebased onto the base commit below after those runs. The
> > > rebase left all four touched files byte-identical, so the code posted
> > > here is the code that was tested.
> > 
> > Not sure I agree with how you split the series. To me, patch 2, 3, 4 and
> > 6 could be very well just one (adding support for the new chip). Patch 5
> > becomes preliminary patch which is adding a new feature the new chip
> > will also take advantage on.
> 
> But they are sound like a good feature-wise split. I would leave that as is
> currently.

Yeah but all of those features are things already supported in the
driver. I would agree if we needed substantial changes for the new chip
being added. But that's not the case, just a few lines (or even one
liner in one IIRC). To me it really makes no sense adding a new chip to
a driver and in a following patch on the same series just setting one
more chip_info boolean to true.

Have no strong feelings though but not how things are usually done.

- Nuno Sá

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
