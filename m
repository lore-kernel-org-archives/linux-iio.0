Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021106.outbound.protection.outlook.com [52.101.52.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979E280CD2;
	Tue,  9 Jun 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996182; cv=fail; b=Hbd5paDnb9xOSfhQVXsB/GH1F49zdv714aWf5f3ersL11wxtwkEnRAVZli7a3AYAOKmZSBOMKdr48b8JyQXUn+/hqvKWYwCHEv8kcRFSw5vhg1h1O4wm9HAFOHXUkS0EI9B5j9nITspNPvABswb9dOMRJVQLoYJxhOUp3+7p5ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996182; c=relaxed/simple;
	bh=f5e09wKPBR6XT3cn+AthDPFbmHJtkDqgr9mSEeoRUMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2GKjc+MEF849kPxcGQZFsBw03t/lyYPN1wTwAJXQbS5TR4sf7ip+xWmr3tsNrtwmPpkslYJJyFmmfGkHd0KgegYicV6+9rfMRlz9XLDBZ3bwlddtG0MdfKolrDhfkS1psfiLBdl3HMmERVdqpsbHSzmnpDZ6IoXhUUJ3e2FNUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=XpggA+AO; arc=fail smtp.client-ip=52.101.52.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="XpggA+AO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz69Ef7W6abt44Lo9jDsPuMUzQaHJ3Sm3hp0uoPDrWecNMsgzDKV2fKmyPf85/JY/RYNwWnIyvjoWwQdQEMmbnlF3ShQoZuHoWUP2ILZ+wCHes35fd1m9RyBPHuImIWZGG2eA33NxQ8pACla3O9URCSF1YqIrcTtdgNsQlLvO3b3vNNOt0YEpon7bc8tSkNRaLdeQoheH+uX0qKj88o68TT5M1qN5onQMXEMm94M6FD+oc7zp1JUz77PMumeJLQbg71F7cCbqDesbg6LlsJba1rihjPcjomgAf0DAOZ2NonB54bv7vfBexxSQ+XN7OH2H9e86TfSKAVldj5TvyfZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIfuJY36VRo0geaOvG9+vTuLOvd/H4OFZf6OiqznxMg=;
 b=AnxbVNKP/FsMIHa0dRm8sq+cDT/ue3DvGcACRQT/5yxeaTspWUsm8rIiKwXUtXVDD5q8IszXGvbXU7QK9TMxc+35JTmJ+sasA4Tq5ryRjATsKIKD1lQD3cKFniiULyRN9/YMoh4uvtGznZ2nX6H3vtZ485xWoUwi3j1ftGwRL5eU56wy1R7KE/YQZTDunEbJxTGKqI66WewFA2oXfkec0U3BTsajGYvoP04ko2KL1GmpRt/ICCmILId+/XDRAmKT6b0+5TyDaFtF+RYIjkPWWo2sM2stixI/5adu6l3ICfbmTrJhww8fm/VNW9PMg3bpIUjD97eewaYN50MIht31Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfuJY36VRo0geaOvG9+vTuLOvd/H4OFZf6OiqznxMg=;
 b=XpggA+AOUYmC8Q97sZCrmMd29zBKxI+TvhfnL2ptrclrQnZD7kaulGrIhKqhYXlX21N1UDsvQJuhLmSsri7gBd8K8T2xv9t+e79TnlPS5DYzS0kHrpKhFBi4CgSI199twS8H3uR13nUqU7qVG3XQJmY4xuzNxSOqEsLcTcKjoiQFpDqFYyzsAa1AqlP5zqhay7ht0Yq7C4dbDreDVCEfse4dw4nzYx6LcA7W9qGzD/YcKU+PKVI2ybQshEtMVRBUoZMaj4UQkNEoBQ4Q/eYCpseU4SP7fsUrnvhFCsYPi7kMomSuCHRCjsYxZDnNoIwHMRRSci80CeUTLa41BY/hIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 CH4PR18MB6165.namprd18.prod.outlook.com (2603:10b6:610:22e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 09:09:37 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:09:37 +0000
Message-ID: <1e2f4756-e944-473a-b4d7-a5692f2b609f@axiado.com>
Date: Tue, 9 Jun 2026 11:09:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: add Axiado SARADC driver
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
 <20260528-axiado-ax3000-ax3005-saradc-v1-2-345dd5f6608a@axiado.com>
 <aiMU2bOFgKT9NrNQ@ashevche-desk.local>
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <aiMU2bOFgKT9NrNQ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|CH4PR18MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8320d4-1bf0-4769-4a29-08dec606d4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099006|4143699003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fXzMRMbykgYzMNLMWj03wC1bCDDoR4njq+e5pYVXXRTTu5533JPiyoMsv+xiOGfg5B14aPXOjzqrRkrkcuZ3VzhJd3QgJloqnXRi8wjifhNF/dbrICh2VY2x2aCa2Mizve8oRMUa2lnaWpwZglyfDV2K01eXiOn/E0jmSSPrU+GHV4MAEmcqFabSMLTAerXifdjGsG+tg0Ly0RHbByetDTHUQNT2y2u6sUV6iiRJViMK4SXSt5UxzwfCPdTbab5bnhdxoD6UrqbiQ3ZAL5DIA0hKzsBofqDw9RmNsurxpuAFAG8VZli1YCjMPQ1yRp9qqMtA9JhRpD1eRDngDN8vbqTeMrjeoW3gnuGJpRL4491LxA93HFOcRtIq7kTCKawA2xb0jxnjS9Pxb/xLdMKWRTnyGtH9NCD1hr6yaxjnk+0JG003VjABm01EiIYSIYBhWt8eOOXwyS/+heTOKIY7lQfxUZIlZZoDJ2HbHZEM/dag33w1okfAVU/PEdtrCWy17/yejrMJkdgm81PGISHZGnkFR/2z9pQlMobx9Hgy7rJq0iL3kG/64bWRcZuPQBTfnTC/miv9yC76AlW2Pvj5CU9s+sKo73NqeTwysTYj0BShSngmCw15il06cOmthYyDNyCwQkFq79m7HaI/QysC+N22+oiWFrwhItu380j4IAJqHJ39tJvUSkfonWzvxnxJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099006)(4143699003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDVxTXVuSzVCQ3h1NXFhM1R5ckduYi83eVRZTjFwNjNZS0I2dERZZlJtd044?=
 =?utf-8?B?cC9KeTBRYXhQUENOVmVBTkR5b2lFOWxxMlBBYytMdFB4ZS9sWVU2WWt1VzZT?=
 =?utf-8?B?aTBlMmQ1NWlkdDRyL3MxaWJNS21rc2VoaENueTFWbUpPa1hrRWNFdm16RHJ1?=
 =?utf-8?B?Um84dzF6M21OMXh3aS8xa05wVGJobU1vYkdYOCtYT3dkRTJHdWM1UjNpUXdq?=
 =?utf-8?B?NFZxdjdiWEhQTnBkcU1jaHVMcWw4UXA3UzdTZDhSWDdQdk1NNWYyREF3NzV6?=
 =?utf-8?B?YmY1MmlPT1IxakFKMzh2cEpkUTNhN2hzSnpGa1h3ZEFhcVZTcVlIMFA1RFNY?=
 =?utf-8?B?MWlYVSt3ZkowWFVLWCtaSmNxTnhzcThhbzVDRzZrWUFDbXNiTEVEdGFhOGdC?=
 =?utf-8?B?akt4NHZQWm02Y2hyRWdtL0pzd2tCRDgzZHV1VDAwQ3VtU2FBb2lpV3gzRDk3?=
 =?utf-8?B?cGk0VHM0SG1EZGtHaENyaEx4SHREREF0aVJIRFZ5ZjQ2ZVl5Mks3RzBWWGcv?=
 =?utf-8?B?ZSt2ZU1YZVJZTkl0ZGRVaSttcnJQN25RTEJEK0JKV0YxMWpSTUVNd2E2NEp6?=
 =?utf-8?B?Z1RuK1R5YlVMNzBiVDNJL1FIUWQwNlhmdmplRFVJRENqUWl0dFBnQW1LMUhE?=
 =?utf-8?B?U0RoakRMODFGQUlrQVV3anJIZTBZaXJ6M2ovK0VlZWhvbVhQT3M3MTQ0OXpX?=
 =?utf-8?B?U0xha1V0bEl4RFBsbURPYkNXb2FxWGhhY0FBNm9MaGhSU296S013RVV1SFJk?=
 =?utf-8?B?RHhjN0Y2VG81L0szcHlxYmRyS1FJZURzZlhDYnR3OUl6ZVRSVlJOT2ZBbE1q?=
 =?utf-8?B?V0IvSG5hSXQ3VXJsMGYrUDRzR2FQMVltYi9FWUVIbnQwSkhsSStPQ0NFQmNB?=
 =?utf-8?B?ZmpxYW41b0xQaExGTFJEYU84UG5icjEwOTlnNUJDbkNXdGhneVMydlRVQzgx?=
 =?utf-8?B?NEtDVStGaHg2anc2UlJ1aWtWanZvQjZoSVJEdm9zdHFqVTk1YldTY1kvaGkr?=
 =?utf-8?B?UzVsR0JHTy9KN3JTWUMrV24rcjc2STR2V0ovZjB1S3lWdjNDZWdWcUQveC84?=
 =?utf-8?B?RWhJRDVDakxoMFJ3VGdWaTZYalJVN2oySFNYVjlIY1VxdXVzTk11djlLcDIx?=
 =?utf-8?B?T0liZENWNm5aaHZKVXVSZG5iSXQ5NG1LemNFU1RkY1FrS25UTTdCdk5rbEhS?=
 =?utf-8?B?MGYxdzRNc1dPSHJrNHpIMm9aT2F2bmpmU0M3d25TZEpiU2tRaFBCdUh5OTY3?=
 =?utf-8?B?QWVpdDNCNXJuVEg4SnJaRVdzMVNNR2xZYlc2MzlTczNXelJpc1FnM1ovYW54?=
 =?utf-8?B?V3pDRHNVY0lZNFc4Sk52UjA1ZHF2VWVhWlBGbFNrODcrTzh6V0JKeXJMVjlv?=
 =?utf-8?B?SXNxKzRjMmY2RDRrMlVROXREb2tsbHJldXpQYzQyYktOdE5TQzBkUDJqTFFH?=
 =?utf-8?B?d2lTclNZaVIxZ1NOd1ZQVVpYMW9yUk12OGlObHVwZ0JWdXhSbHQxSTgvT1p3?=
 =?utf-8?B?eitFbWR3YlZ6TldVNGtad3czTSsyd3JKQzB2Nld0R1M0cFFnYWdQbkM3VnZU?=
 =?utf-8?B?M2RWbUZiZjRpZGFXUThWTE9ZSzVRU1RLR3ROamEyaHh6N1hwUFprcCsyNSt2?=
 =?utf-8?B?dFJaeHlOdHA2YnBvQmVzWFAxRDBoSFVPY1paSnN3aStSdHU2NnpqK2RMbXp2?=
 =?utf-8?B?cTluSlBOQXF3eGx0QW5kKzFZSFNuWnBMNkxrS1JzbTlOcW9pQ2hieTFRTXEv?=
 =?utf-8?B?RllTTkdDUnp1UjMrRGhQZU1ZZURmaHIvK3g3aERsUHhRY3ZZcFRueERuejd4?=
 =?utf-8?B?MXBVWjNTU1RuUGY2NzJjMGJ4Z0ZzUTNZVVE5RjVSdGhJYXFMRHNjSFQwVlpm?=
 =?utf-8?B?ajh3NW02b2tzazNIOTBlTDZBOVY1TkVISVN2WkwzdGw3ak9RNGJZbG9CZTVz?=
 =?utf-8?B?Q0tmSmRqai82NU1QWEhxVU9KaXg1U3RKODc2K1ViaHc4UkNLYUJoVDRoTGF5?=
 =?utf-8?B?MmtmVEo4NlRGWkFwYnhtWE9QejBDckJBWHpwS0ZQSjZ2U0RQV2xZeVlVKzVt?=
 =?utf-8?B?dWhnY2RyWllCcERFVzJFK2l0UXQzSUpic0FPZm4yb0twbjFPd0FLN2tNWGF3?=
 =?utf-8?B?OTMrcmdUM1NSTXdaRU1xdk5tOExjL1dydTdPZTNRck56bC8zYjdHdlpzeHpv?=
 =?utf-8?B?T1plSGJtelBsWkg1cFJwS0FKSEpDa21KZzVaak92VFdhV21YUWhtR3ZRTUMx?=
 =?utf-8?B?djF3SEkxZEFXdjRqMlhsRVhSTGxlMHFLWlloUmQ5dGV3UndKT1M1NUFYS1JG?=
 =?utf-8?B?YUFoWGFIME5aM1BBVzZGcGc2TFRyV2lHUlRFSEkvZkNkY1BWQWpydz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8320d4-1bf0-4769-4a29-08dec606d4b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:09:37.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSXAZnW70o56++wwFhL5cwz9Sk1WNtG0bT5XwlzI+XfuU0YiFKS6n6NY8AP6HY5XPtuHQN+P3exlOg4ylZ+7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6165


On 6/5/2026 8:26 PM, Andy Shevchenko wrote:
>> +config AXIADO_SARADC
>> +     tristate "Axiado SARADC driver"
>> +     depends on ARCH_AXIADO || COMPILE_TEST
>> +     depends on OF
> No, in IIO we want a good justification on non-agnostic requirements.
> Why can't this device driver be agnostic?
>
Hi Andy,

Thanks for the review. I will address the comments in v2.

You are right. The driver does not have a hard dependency on OF.
It only uses the OF match table for Device Tree based probing, but the
driver itself can use generic device APIs and does not need to be limited
to OF-only systems.

I will drop the `depends on OF` dependency and use generic match-data
handling where applicable.

...

>> +     iowrite32(AX_SARADC_MANUAL_CTRL_EN(chan->channel),
>> +               info->regs + AX_SARADC_MANUAL_CTRL);
> Why not writel()?

There is no special reason to use iowrite32() here. This is a normal
MMIO resource, so I will switch the driver to readl()/writel().

...

>> +static int axiado_saradc_probe(struct platform_device *pdev)
>> +{
>> +     struct axiado_saradc *info;
>> +     const struct axiado_saradc_soc_data *soc_data;
>> +     struct iio_dev *indio_dev;
>> +     int ret;
>> +     u32 reg;
>> +
>> +     indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>> +     if (!indio_dev)
>> +             return -ENOMEM;
>> +
>> +     info = iio_priv(indio_dev);
>> +
>> +     info->regs = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(info->regs))
>> +             return PTR_ERR(info->regs);
>> +
>> +     info->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> Why no name? It will make harder for the next generations of HW in case they
> want more than one clock to be used.

This IP block currently has only one clock input, so I used the unnamed clock.
Since there is no ambiguity for the current hardware, I would prefer to keep
the binding simple unless a named clock is required.

...

>> +     reg = FIELD_PREP(AX_SARADC_CH_EN_MASK,
>> +                      GENMASK(soc_data->num_channels - 1, 0)) |
>> +           AX_SARADC_SAMPLE_16 | AX_SARADC_MODE | AX_SARADC_ENABLE;
> FIELD_PREP_CONST() ?

FIELD_PREP_CONST() cannot be used here because the channel-enable value is
derived from soc_data->num_channels, which is runtime match data.


Best regards,
Petar

