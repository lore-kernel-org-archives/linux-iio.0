Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022125.outbound.protection.outlook.com [52.101.66.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9323C1979;
	Tue, 20 Jan 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906988; cv=fail; b=nH2bUx0iSFMSz0UShAl0gzP2hA6h01vQ+XAeRhpEwleWyJ3MBqxAMDyc/W+nK9l+eeiflK1vUw1bmzXgp1uUwPv1urgqcKCEF6TcdFr8f+Br2cAKycQbd0RcIucRDNjfWSF7Z7JvTpEKYOZLl6hpAWY0bw2oqtpnrUx7UW0yRfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906988; c=relaxed/simple;
	bh=iGoTAZfr6U+2yzMrzyaKJE/hUUmzfTKnSJ0tQoTczhc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cyB+7sUn+1Gg53cWu+oue6Z7QQ5Qknc8ITx8+ud+iohmSt3zzNb6d1Z+dcL5vbHVB47PkCqF42EvSEF05nadDrYF5EJNivQG4Q/8MWeg6Pi131j2VDeQluipCTAd4c2b9DkOut4J/Euz86DWMmANCAKv6JoksHzyuVFePUtLFak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=r7VUEY/M; arc=fail smtp.client-ip=52.101.66.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="r7VUEY/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIvZ9amjZLaS2qo3rJ0ctzvzlK1RYiy0Th0YLLOadz9IOedarYxDBw3cJNmYN2vuPUQpgGaDdrLxjmoYRw8Lbv5IXPEDtyHaS1Et8qem7AOs7OZkA6lAPPnAfK0PGmRJiP1qOYBVFB5j+H9rRXeQO5tb/zyTkgAgynH4Y0ykG4zr1O4b9nUU1uQO6Yk6iQ80QK+fwJnD2jlvqNG6r8OB+8+oqdnBpAGYUy40cO+Pi7SZamj40ACPCoyImUEmR7szwaTPSZv4+198lHgaPxvIStqf09TBFM891lq3y44ntHCP36OdpAPLEUDhWv86tUB48Wb43iLBUrdrEnoG93m2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH3mLEo06uMX0atUFR5O7XZiAgbBv3tyh4MTjdL8Jps=;
 b=KYekcJjVGNxPyCRbjJMfOHeCk+bA3UiaJCvWBn+KpDhTM2pLf33AUpXLjjxQM+A0L7LHOYPqBOGxWY7kUsxlmV9LSAn18LNpUcgnNSJ38CE9TxJ2+4+ZM3Qgz2FUn9Oo7nliP09ZeHKMVsplC9BTEbCjtFeMzviqS8wDDvB9UCuTLye2nyx0rlLSFjWslxKPnt024eewm7PGnL4CxQUSGFfjQj6i/6b/cunUZdv0Feox3MERi/n6wZGTi998peRpTgaM1P3ZYNzBnjcbddHqhVJz77xHzjRw1E0sx1ecFdyK1qmx5EDJ5gz7dhHhC8bl4QQzyYdLsn05gZ9f5IYITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH3mLEo06uMX0atUFR5O7XZiAgbBv3tyh4MTjdL8Jps=;
 b=r7VUEY/MSyyItsonwj9oS5+FoaHyr+CnVZT4pl7j+BjWW/DLd48cYe/u2Q9p6V6+QIBxq6vSZvfYKFv+JGRhkpchPJLmf4LU0WmXu3SGLvYSw7ZUnDdproRexXbCHwgQzJMJvJXrFBpVYI7BPKPT+mUSLPHUgNlQR6xhheAEYYPQeR/KPRDkoQYiE7419fPnj1FOPBCx7xqKHWg8ICuQP3BnKzA0L++f4Q/EYoidQP9AdHZt+PxmzV6C0ilffsz9n2W86eQEn/1FJWFEliKaF4iL2FonnovtYOucpEPXKWsg2ObTJ0EgD1rzjA0u7kuoCdMtM3amSSsgduMKIWWqvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by MATPR06MB10680.eurprd06.prod.outlook.com (2603:10a6:250:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 11:01:47 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 11:01:47 +0000
Message-ID: <97468316-776b-4318-83af-b20a4e99a570@vaisala.com>
Date: Tue, 20 Jan 2026 13:01:45 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
 <7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
 <5896ab55e0d23d235908f9f592c8a7975428dc54.camel@gmail.com>
 <41cac06c-8db2-4a52-854f-659606d89121@vaisala.com>
 <931160a27cfcfbf55d75bf9662442988c266343f.camel@gmail.com>
 <20260116183724.18063cec@jic23-huawei>
 <acc10955a646b13da7ff191149b8f62181fbac5c.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <acc10955a646b13da7ff191149b8f62181fbac5c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::15) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|MATPR06MB10680:EE_
X-MS-Office365-Filtering-Correlation-Id: 47788e40-255d-4490-c6c7-08de58134e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2tPelhSMzROcTllSUNaVUtaMWM5K2xmY29Ma2s1Y09jbm8vTDNIc2E3TTEx?=
 =?utf-8?B?NFFrd0dXS2FXbkRSOXo1SXpmT1U4c1EzMk9pWkNhbnB3YVJUQjZrbmVXY3Fq?=
 =?utf-8?B?TUhIZ3RRTHE2Wkc5ZkJ1SEU3S1R6RnZDb3Q0aUpRMFREbTBkV1JPOFBieE1t?=
 =?utf-8?B?RVVZbXlBY3ZGWXhKbTltZ3l2QzJMbURqeCthdUxqM2NoaXlGYUNncnZuOERL?=
 =?utf-8?B?d2MwZE1sRHB4MUowUzZNdnM2ajJvZE1HM2xQNXdqSzBpVXdHU0dBZFo3OU5u?=
 =?utf-8?B?c0x6dW1yQytaSU9LMjljQiszRnRLb0tMamYxbjcwOUtldVJqOXhuSFRPeFZJ?=
 =?utf-8?B?OWMvbGpDdGFTejk2SzRwMWViRFNLZ09BdUtqdjdWREhlcHdtcWptUGNaSUJU?=
 =?utf-8?B?aHdVY2E2dlJIVEZPVUpsdnBMQ2lTamY2N0hKc283eVQyd2lMZDIvTktaNVBP?=
 =?utf-8?B?b2RidTVrekE1K3pxSE9wMGdSUU1pd1J6TitCd05qWXpGVVpmeHVmR3k1eVFL?=
 =?utf-8?B?bWlESS9VejRsWXI4ZW56a3ZPY0gyMElXWkNiRFQvaFkvdlB5T0VSSlM1WnlG?=
 =?utf-8?B?VldUMmUyY3ROTE1KTldyVjBzaSt6ZG8zV3dZbWM4THNwZ1VuS012RWg1cm4w?=
 =?utf-8?B?NXdETEVYd0J0UkZxTlJJVkkyRU9ZSXZtK0pVUklJQUpkMUR6WSswYlVuT1ZD?=
 =?utf-8?B?dzhTTFEzSVlZV1N3UWlSVUM5OFA3ZEE5ZCtHL3Z5bnArTWg5dFhwdURac2dG?=
 =?utf-8?B?WDdRWG40Qks5SlhhY1kxV0s4MlA5VitmOTI1ZElXdWsvdlJRazJFQ1I4T3N4?=
 =?utf-8?B?VmxBWThSbFh2aklNb1lyYXQzTE5kOUpzcWVCSzJzL3dnZXFmbDN0cXg2bW1j?=
 =?utf-8?B?ZnRjcE80ZEFYbzhTb1FxSEl3SG9nNmRFZjlzNHZOZWk4QjNHZGJCdURMWmlj?=
 =?utf-8?B?MzBXb3lhYVJnWnFNa3ZtWS9ZbGYxU0pDTTNOZ0FlNjA1OERoQU50ZmxPNUtq?=
 =?utf-8?B?NXpmV201OVZncU9LSnFVS1owL3czQUhuMGtKOHEwcWFJU2FUVWFJcEtwdDZX?=
 =?utf-8?B?U04zbmpFOFZ4dDVPOHprS0xxb09qQVUyKytwSVc4Q3dRcDBHTXBldTluMlhO?=
 =?utf-8?B?WUpuRUs2SUtieDFhb0lkT1RHQVJ1Rk95TVpzM2ZtMUJiRysrRmNibnJrbWx0?=
 =?utf-8?B?MHBvZVZHVU15WlB1dVhOSFFEVXZIQ2lKaHJrUHBUM3NsdTNQNURIdG9kenVu?=
 =?utf-8?B?aCswMjdLeUkrV3NCZXdsS2czZWY3MzVya0FxRndoSlAwV2tSZlpLaWRMcXll?=
 =?utf-8?B?RTIzWjVZdXNYR1UzS240K2VtZUtSZDNCQzVvTnQ4YkFtQWhJdzREV3orbDha?=
 =?utf-8?B?RzBhTEZOdExvdXNsem5PNHhDcm9CWklrNGJ0UWRGWU5UYTVwVlpibm02QTZt?=
 =?utf-8?B?cTZpUENDVFd1SitlY3NvYm9lZWVySGcwNjdZamQrRDBCMisyb0xwRGtJN0ha?=
 =?utf-8?B?S1g3MVF0TnVYVW50S0dIYWhCRWdFVktmWFYwQmZKeUZEMWVLdCtmejBzWlRk?=
 =?utf-8?B?YzhJZjcvVkRncmdrMno1VllMWFdReEgxeEhLMUdJVXNnTUF3R2YxZDE5SHho?=
 =?utf-8?B?TlhORjVGZnpnaDFBYys2bmwrQ09YcStEVisyRTlHQTVSZ3gwVkFXRHJZSWJX?=
 =?utf-8?B?UW9xQklTYTRQQi9lQXN1b0JYaXp3NGF0dUxzK2sycTJBUUtpK2pDUFRZTWk3?=
 =?utf-8?B?U1hBQTk5bE5XOG1BQkF2Zjk2ZERkRmRqaFFhZlJoRFdSajk3dzNBVjJvd0VH?=
 =?utf-8?B?cWlMMUx4b1RwZ0RaUSt5MFBxaEZUSGVPVWtuOWYzTG1EaE9BazVOQ3d3Qk03?=
 =?utf-8?B?a1RIYkt3WHBlc3RlWE51WFdKZXlXVytkYm0vc2VrMGNubTdZWjA3QmJpWGtj?=
 =?utf-8?B?V3RENElhS2NsYXV1R0hGQkZDcGlhcUo3UXBNazZYOUxzdUlISWp2VTJRQlZ0?=
 =?utf-8?B?a3UwWTJsd1Z6WHVmZ1ZwTjRqUThJcmJRUkl2Z2Z0QkJadGRLUEJhN2JxbHI0?=
 =?utf-8?B?L3FwL0xwZndXUHAvVW9DMmovMkdLSUJiSlVXanB0SGpKdFpiWVFrM2pEWU4v?=
 =?utf-8?Q?ygzk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXZLZXB6QlVQaDBZZVE3VlVXSUJzcnY2cmptdkdMQ1NvMllvYzBoeUdIakpt?=
 =?utf-8?B?RHM4eEdnUm9CT3IvajlDVFBzZ2d3WklCWFRBbllSd2lkYm8rcHU1TXgrZlB1?=
 =?utf-8?B?c3JodW5XNExSQ0RSWlYxYzF5eTJKd0RhUFZSZGxyQTkvTUE4KzRkbTNZZnN1?=
 =?utf-8?B?VEZkRjRtNFFGYmRRTGExU0szdFlVSnM0dVFrUUNCNWkrMEh1NzlSNGY4VzR3?=
 =?utf-8?B?b2syU09rdmVxNVZvemdUaE1sR0pGeHhtRVZaRDJJZXNLZUtBb04xVHVpOVNq?=
 =?utf-8?B?V2I2WFBraGNiRkpvTUxOMk1FcWxpWVErR1BORTNacmpFUkc2QTNIMkZrUUhJ?=
 =?utf-8?B?VTBPU0JIMEc4eTM0aDJiWDIrYkdDdXZFOGw3a3Z2VFIyMkUvNlNVQk1ncWlP?=
 =?utf-8?B?ZlRob0VCTHdFS0RHMFoycXNUdFE0Uy9oaXYzcWxZVjJra3p6QUN5SjJqaVFw?=
 =?utf-8?B?OXA0ZjVzOGJndk5KQndwcXFLb1N4OTh5Q2t3MFIrQkp5Yk81Wm1lUXAwVXFz?=
 =?utf-8?B?cVZqek1yV2JUOFZSSXhwMm1lWHNYV1pzbmE0NkZDalQ4VGN3VmVuMjZIcmcv?=
 =?utf-8?B?VUlWcVhZSmYzUS9pRHl5aU43cXRya29zaW5TY0JocXl6T2IrWktOMEs0bTRF?=
 =?utf-8?B?UjVPWmJBbWJMVk1hcmgwbEVJVmlUdjluVUt0NHFJb1FMbFNrNDlOTXYrU04v?=
 =?utf-8?B?MmVxZUNZaEdrclF6dW9IOWNhOUpIVTZ6VXZMUTZkcm9OejJJb0o0K0ZuT3lS?=
 =?utf-8?B?dVN4Y3dsYnlXeThIY045NFFpSnBXdTJDZFhlcnRib0Y2YklDeVFUN2VTcHZ4?=
 =?utf-8?B?MVZ3dDI1VnErdXhwQTR0ajR1czJ6bzhVOTIrWWlxYjkvaW8rT3ZUSHhXTWN3?=
 =?utf-8?B?QVB3Qi9ta2N5cnZadWJHMUw1eVhiRENQakx2QUlncXpPWGZyTzA2OVUwNGxy?=
 =?utf-8?B?OTJMMm1Jd0ZKZVl5RWpsMXowY2tkUUNrc3EzdmNmSHlvemh5NWs0L1RvOTN6?=
 =?utf-8?B?RC9Pd3JnOTQzdHRHa1I3a1VMSXFpSmpQWHF5ZGVrN3ZWMWsxcjFHM1VRQ2Jn?=
 =?utf-8?B?YlNPSjFROFg2UWlnS1p5TG9NUTVSdjB1ZEFPTWRCdVJTdmx3QnpQeDRBZkkx?=
 =?utf-8?B?R1dtMFJ1cEV1T21GZjlyeE1aVm92ZzJBSVdnTkVHc3ZvbDF0cE1BaThlL1Nt?=
 =?utf-8?B?aXNXcTRiQzlIaFRQTk01SWRRM1gxWGhjMWJqcGJUUE40bXg2VWRGcWl1VFVz?=
 =?utf-8?B?bXV4dlhQSXErZVd4NlhJVGhLU3NHdUd2OFpPZWwzeVUzSmQ3eWtCeHk1WXM4?=
 =?utf-8?B?Zm9MYWU2RmVTL2J2b2pKQmxtQms5VGp0QW5rYW5qRzgzd0M5OGEwL3BEMGVz?=
 =?utf-8?B?VWtNc3NodHhyVGpwWDhzS24zSi9WR3FRMk9FS2t3YkRyUTVZSmlObEJPZVcv?=
 =?utf-8?B?OWNadzVDempTQmsvZVhpYlBuSG4veUpSbi9iNURXQlliNklvZFpjN1lFTXhI?=
 =?utf-8?B?VmllQkdSK2prZ2NYczBUV3pJZVFVcmJRVmlna3pGUnRqci9HaUJ3Ny9md1RY?=
 =?utf-8?B?eURKNVFJV1F5aXF4cDdHZGVSVi9GWmVTVkJxeVhDOTV4WXJhN0lBZFFCTWky?=
 =?utf-8?B?a0tMZ1pLb0dNcDN2M2VpeHhIMHN3a1JvR3JPSWZoOXpGdHpCMjdKdTg2NTc4?=
 =?utf-8?B?ekRnajQ4SU1ValJPZ3VCM3BhYkV2MTNUS01lK3k2Q204MkM2aGRwRCtFT0l0?=
 =?utf-8?B?YUk5eEVObkE5NnNZUEhCNE1EUjNkQ3h0djRhSldwM0R0RUdmZVhWS2VNcmtW?=
 =?utf-8?B?WUlEbVFMUWNEeEVQWHlPTXNnaHgxOHRDZjZVUk9wOVI2OGM3TG9NbXJYODZT?=
 =?utf-8?B?UFRIV0FWN0NqWDBUZURYcGVuVThvRmxsbHhxaFYxK0huTTdwNmM3TXZ2MWF1?=
 =?utf-8?B?a2pYU1BBZ0JMSFlUaFlKTndLc2xDN2RXV1FaSStFMFRYWElDZzFNY1lWbHZS?=
 =?utf-8?B?U3U0T0N6b3lpMTZZaFRYSkJsaC9wZXVrb0s5dDNwcnpZV0FZTHpnL2x1UXZJ?=
 =?utf-8?B?d3YrM3gxUXFjei9IOVA4V0xDSGxMeEc5M1BQdXhqbEhtZTV5T2hTWmhLOC9v?=
 =?utf-8?B?b3I1eXROTmNSRUZ1R2xDTmxidHQ5Wmt2R0RUVDl2T05pS2h5K2FTdXVXVXpk?=
 =?utf-8?B?eTVpUnJnNFNGb1hVWTd3alUzakNjR1g4NGFqcEN3NitPZVJzSjgyUnNHdlVq?=
 =?utf-8?B?L3dsMXRkZ0ZZZ0M1RGdyZlhQMWtsWU1BeFhvSSs5WEFVY0lVOWh5RnA1TDZI?=
 =?utf-8?B?OXUzUnZyN2g3YTJxSlR2QXVBSnZYL0JwN09hZXJJWDYvVlhnVWU1YkJNbWoy?=
 =?utf-8?Q?fzLGx5oNFr2KF9Ck=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47788e40-255d-4490-c6c7-08de58134e1e
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:01:47.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIPYHpQsdN7wgUaj+k13279G+IApNJgBYsvyAq5m7ZMA/s45qY0F550IkVIwQ4jwwLr77LHfTzuw3TR81hLgCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MATPR06MB10680

Hi,

On 18/01/2026 11:21, Nuno Sá wrote:
> On Fri, 2026-01-16 at 18:37 +0000, Jonathan Cameron wrote:
>> On Fri, 16 Jan 2026 13:31:39 +0000
>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>
>>> On Thu, 2026-01-15 at 15:30 +0200, Tomas Melin wrote:

>>>>> What I have in mind would be really to do the same as regulators do. If you
>>>>> call
>>>>> regulator_get() then the consumer really assumes a regulator must exist. But
>>>>> if it
>>>>> is something the kernel does not control we get a dummy one with very limited
>>>>> functionality/stubs. If you call regulator_get_optional(), then the regulator
>>>>> is
>>>>> really optional and might not physically exist. Seems very similar to what
>>>>> you have.  
>>>>
>>>> There could perhaps be use for a backend like this too. Is the idea such
>>>> that one would still need to define a "iio-backend-simple" node or such
>>>> to device tree which would then provide the backend link and compatible?
>>>>   
>>>
>>> My idea would be to automatically define one if we fail to find it. Naturally if
>>> we
>>> ever add an optional() get the dummy could not be added. See how regulator_get()
>>> handles it. That's basically what I have in mind.
>>>
>> It's an interesting idea, but I'd like some input from DT folk on this.
>> The fake regulators thing is kind of legacy from lots of drivers gaining the
>> power handling later and it being boring / too late to add all the fixed regs
>> to DT.  This is a much less common case and I find it a little unlikely there
>> is nothing useful to know about where the data is going - so how useful
>> is an autocreated backend?
>>
> 
> Not really that useful. This was just something I thought of to have the full usecase
> supported in Linux. But, if we can add an explicit fixed/dummy (whatever name fits
> best) backend with a proper compatible that would be preferable, yes.

For now I think we should be okay without a dummy backend. Once the
capability feature is accepted this will be enough for current needs.
The capabilites will bring in a lot of flexibility as to what needs to
be implemented and not in the backend. In my case I can register a
backend from a driver that is not exactly that, but provides related
functionality.

BR,
Tomas


> 
> - Nuno Sá
> 

