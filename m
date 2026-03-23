Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525233FE15;
	Mon, 23 Mar 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265520; cv=fail; b=sz6Q0qnDzbUGIEXcRhzhkqDzXqjPTrZDD6523zbdD/3EESK8bsfFmBo5mfU0Qh8IoJoDFPp8vizOk5AshI6J7GOTKw3RtrrxZzIFhc23T3F9tBFKLfDZrqlp0eDbmMTkZnShVEwUMNO/jMntGYXu1hpdiaQGzPdKPCitObcPZWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265520; c=relaxed/simple;
	bh=3fOg0RS3m6pj0qHTb/YuMCR3PzIQ0hTwCii3l2cpkXo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZT5DaPHL4yExpglqfrCEEZYFgb1EVyFaoz8fO75C1qxGv41fmR3nbF5rxituJKl01HLH+w9pdzheUhuNfj9doEAl15O8SD5WQMCoj5RYQanmzoZFFfyupRuuS0xArYlEhJ5SO0D1/EOW1CFZJ9YTSjODRs0etvavq/9O3ilysPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GjUiAJDS; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjUiAJDS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBC7ZKKCI+pZPs6mZVBlWVe+0qLFq1e7ND1ld5CmAYBcIQamr0HXqyC9KCe6iOwgAt81E8st38m8gbxyPBsReUL6iJR5JSU4iXFihBUYKbosvZL0/eSMYloTV2wM1MWpcEdd85fXGT6ql2uvcKSTNTJo7h4yyM93H4fvKbHIJxItWsYQ5GVf+9MOm9RT//lmh0S84ALMSJ4prYzWK5ze/Ec8ZUJWkMrb9qbMBJaNIAqJjJoiFCq9ACpXs6TNdQC0uqRS21ie6+rrmzahL8kqMMqn7ZdhEKDaOJuKFeYeyOXFQaia/HfQJJ+t6sSQZqRy23Uz/srzAkEXOQSSAwmUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwQxs4oXmQLhSeViZ8fAdCl+dL3kKoR/zcl6bLSQpPY=;
 b=rs0rbgrmXcqhtZc4FEnSM7mdiKgae8W7tYHEeLDH1pPfck6Mn/Wlko0YWswLmSzur+o6uesHCbZlwn7Bt5BAzpua4lnOPJ17hJtY6RAYOT56loUyZehPBPPH71o9nphHmBHA0ACDw/vP6UaZQO6TQKSe8SUraHHoPYHXW11/OSdTnesCttyUpggW8354uo5/wfP5OUy8pko+n+MIOZsAk/Wu/yCFFsFJTqdtrJLOQ+OtH4C7330YbmpBbaeHrewGi2VorhVSkPtXMTWDWDKu5LvUJeHfNp8+v7flhbtmtXv7AL/Q9O9Cn0oNMlFiTQdSDFwfXUHe3zA6v0iAl+h8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwQxs4oXmQLhSeViZ8fAdCl+dL3kKoR/zcl6bLSQpPY=;
 b=GjUiAJDSDJkzFhoHrqe+/gAlE6rufGnAA5TND3u3U66RBIdxvgaTKtuy0Wbw3eD/hCuwqrjnOlq98fWFuB1mz09WYxn7DJz6QDJeZyyraA5bcJVEIipHMas4niTxcLKIMvJHBtDPpNFtC5evAN7yAmGUM6O8LSZTIUaBcrT9qN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:31:53 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 11:31:53 +0000
Message-ID: <8c8fa211-6244-43d3-9350-856301075e2b@amd.com>
Date: Mon, 23 Mar 2026 17:01:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: adc: xilinx-xadc: Add I2C interface support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
 <20260323074505.3853353-4-sai.krishna.potthuri@amd.com>
 <acEbZ0O3HKrGx0u1@ashevche-desk.local>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <acEbZ0O3HKrGx0u1@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::14) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: c7083e4b-18ae-4ef0-38eb-08de88cfc80e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5uOvckwc3y0aPZMM0ZXjoxGPf+3ymiwzZ8df96jvP/eyW5Sq+XFDtjFiiKcFf92lXDhmAciqLS4ubHUHO0K6ZPNkVOPdM1Z1MJdEBUsaW7ORFbyNYUB6JtM6dvutVisYHKK5T/7D2HqEd0aB7+Sb5WNerdxnd6v3/K0ti7voxIt1Dv7l1EaEghWdEyevDp0DgDwBm4u3RKseKQvJyNsyA+Wf9a3BKD1PBcoa+FNfqUgfK33nbRrJ7EcPqaK+DsBqrlfbL8lCXz1LI2sO7h1QQrQ8duC4pTyuB6Zat4NIjPPDuJKXKz1SQNiqwJ0Q5HxFYbd2ZavcM9z8HpTEDaqbAKiV/Mhbz+Zau4UCWsxRU76brIbsguMNjpUY0EBffIzMXVUCq65EBTLKMXzSWtgUtj16ybYeAnDDvtOrLD/gKpSvj6lY7C1GJcLBdJhQSiwZGquX6h0nRqz3oltKcqE+dRNyjhU+x8J2oi63Q+AbytQm8XG14RpqAepwgPFrL5E5gkGy+lm8NkvTfNdA2jFkcmLNchqOwwXcDTEzUVN6X+25JPoivohIagYaK0q49VOK2NlF49EXygSkNsgUjtdBX3KZMCC9nbiLgWSAcsFfvybz8VdL93vnOFEsY4IzaM9Q7/q1iiZRmZllLkvfrowzcq19OOcNCG+Bl6Xt/IsoOEpi2j2D5XgtBLtf4Iodq8ItHfYjHknCVya/gXra/NrfxQZQaqv57F4iIqNxv/vbbe4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTltZmsyK1FhbWRGN2dRczdRTXJFQ2pwNGQ2VzdWZUNFdFM0Qmdtb3ROamhU?=
 =?utf-8?B?Z09HNVc3cTZRbTM2anBhNUdsRHllaks1NHpsS3VHOWhnK3UrYUZ5WWZ0UzBL?=
 =?utf-8?B?UFhsK2djaHpkbE9xWkdSRkpueE1XTlIyTlNFQUQ3K2UxQkZzSm9HbTh4bEpK?=
 =?utf-8?B?c1lzUkFJL01pNUlZZktzMGdMUU5vMHBubHhvekh0ZVN6dWFGS0lwcnpMeTVm?=
 =?utf-8?B?MlpObVdkV0ZVaEpkOGE0Wi91eXZNU1N4YTdxT3p4QzM1ZWlmdzI5RTRxalZN?=
 =?utf-8?B?Z2xJRkFXOTBNekswWnpFazNISmcyajEzNnJScDFTdWRuK3JWT0NmRld1UEdP?=
 =?utf-8?B?R1FqVGMrZlJLOGRwS0NkR3kxbUdqaGpKSzBxaDA5Y0IrdE1XaU02U29wUVp4?=
 =?utf-8?B?N1RLbGc3bXUyVkVsY0c3WTIyWnk1cDdwU0dvb0FpZU5DZ3dpVmZ1WUVVWDJo?=
 =?utf-8?B?WU8rcmxENlJJb1hFWDdrQTFzOEQ0MzNSUTBhUzhIWVZHZC9VQ3NFT2M0Z09J?=
 =?utf-8?B?TjJHTTNscWJBcldxY3Jza1dRc3JaSEUvR2h6T0NOakIzblM2bENzMWVuMUZa?=
 =?utf-8?B?Y0YvN0V5RkwwTjBleTVjamhLVHNHNGYwSXI5bDdBdVdoN3Yvdi9qNjJHTTFQ?=
 =?utf-8?B?SHF0NXBlR3lZODJSbXlaYkFyOFpTcTlnQXBFRVFKR1pPMzduWXpJTGNndmNy?=
 =?utf-8?B?bjZsdEJIVFBvczdST1F0cHViK0toSjF4NjBnK1ZsRkhzSU9kY3FaR2V0Sk9F?=
 =?utf-8?B?bk4vaG94TmdlUENlb1hGVmFnVUVOSDltbS9LcXh0ODF2S2NIYkJoZ2VDd0Er?=
 =?utf-8?B?bHJYTjloYWY1bDFxaEErOVlJQ3k4T3Q5YjNXbkJvb2lRSCtBRzhsb0paQ3Fo?=
 =?utf-8?B?ZHVXVlpoZFovYlI1ODRyZ3ozVFZBWStHWjdzZEFlQjFWRk5XZ0FjSW44dktJ?=
 =?utf-8?B?WHJLZkR5Z01Memg2MHZjdUtHZ1dzU1FKTUNpaTUzb0JkNlBJT2NndVY5WitD?=
 =?utf-8?B?YUtXaTRmRHdxYVZXRmtXT2txUXFMZTJOelZnYTNTdml4NDgzbDBvOTNYdFVo?=
 =?utf-8?B?M3YvZ1d3UlZWbkhvMDBDMUxORExRSmVlNUhyeVZaRWNtZDZManZrWjdYK0J5?=
 =?utf-8?B?Vi9nMzQzYktmaHlHRHFZSURoM0tTQ2l6Ym85V2lxU01na0tKMDJpOVdVbTFJ?=
 =?utf-8?B?Y2pzaXo3Y2hhRElaenNMaHVIdFNKOWFQQXRCTzJhNmlmYWJwU2xPdVVUN012?=
 =?utf-8?B?a1JoSkdycUw0d3Y5ZHdJTEFad0RuUys3MlArMUVLdTUvcnVZT0NYdVI3OGJh?=
 =?utf-8?B?REZiVFdydVJraldIakFNYlE3ODF1QmtzL00ycHArb1VGd3lsY0ZlZDVWa0I4?=
 =?utf-8?B?dFdRNnFpUlplYUZ0Q3dwbHNQbkRhMXo4SlJLN0ViczI1QUVKTjViUDRBQXV6?=
 =?utf-8?B?alpQZFFKd1dqTlpSUXRYOFI4TFhzMloxY2Y3RWNuNXBCaEJwTWFreVp6RTBT?=
 =?utf-8?B?ZnptZW1tNkhrSU80VEEzRkpnck5vRGt6Sk9ZNURTdEtWVFpRZWYvQVhYTEM0?=
 =?utf-8?B?M2lKNjlYb3lCQlY3STdCaGVzTVI0T2JVdzlhYy96ZFBaZDJDWlUzQ2pzSmxt?=
 =?utf-8?B?dmJBV2wyY2VNZTh1bTRoMFpFalFsY3lpQ1VkN1puWGJFSkFQanRocWZNMmsy?=
 =?utf-8?B?ZHUwQzZYY1RnQ1pKOUNzMEZqQTkyd3BqclVKNGQzQmJjejJLVkQ4WGhQLzBQ?=
 =?utf-8?B?eXp1dXRGNUIydFhwQ3ZZMWg2QVRXaDlNZXRaOTduUFhyZkN5dXk0OUN0bVJ4?=
 =?utf-8?B?Y0Z0MjB3OTNWQU56S0NlbVF5TS84aEZIdDN1VzhIZ3F3U2UzR1ptNTA0aEt5?=
 =?utf-8?B?MG9LVVoxZWNoOWlqRHRyaENKaU5TdWQ0eC93cDR1OG9JdWgvUENyWEs1V3hZ?=
 =?utf-8?B?S0NTYnRadE92NFBocWsvVENYT0dQa1kxSDMvTFlXeEROSWhkYTNpVkNNMDUz?=
 =?utf-8?B?Y285c0J0RmpxTldabTFhUGxPdmV0VUJNTnJya2RhQjV5bDV0dDAwbW05QUdm?=
 =?utf-8?B?Rmh5cDBiQ0dlZ2EvRW5lQm1NbHMzQ0xqZnBNbjJPZXBoV1J2aTJibmNtSXV1?=
 =?utf-8?B?MXQzTThHYThxYnl4eXpxVWw2anRHNlN2ZlpTWlJtK0Fmb0JyV3d0OGxhQTNZ?=
 =?utf-8?B?ZE5PQ3dMSlU3djBEYjBsTm5uS01NeS8xbGdySUpPYk0xeDVSeVZwYXNVQmND?=
 =?utf-8?B?RGxqZHdEdnpGeWlxWDEzSDJTbGhoNHVoSFZDVVZDYXF6YWQvOGtpc1AvOEs2?=
 =?utf-8?B?dzgyVWlOb0RTcXJzUzl5cVVXRmRRZndkbjBjZzdZWDRyd1dwektvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7083e4b-18ae-4ef0-38eb-08de88cfc80e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:31:53.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqcX2NqzeiZTQ0+zBcI5SXMh26AxWJfZ2+YCMydltLRGiB/PS70Axf4wT6b28OWip2jnyTFy9WfN4ZKNNH4aIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

Hi Andy Shevchenko,

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Monday, March 23, 2026 4:22 PM
> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Nuno Sa <nuno.sa@analog.com>; Andy
> Shevchenko <andy@kernel.org>; Simek, Michal <michal.simek@amd.com>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; saikrishna12468@gmail.com; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH v2 3/4] iio: adc: xilinx-xadc: Add I2C interface support
> 
> On Mon, Mar 23, 2026 at 01:15:04PM +0530, Sai Krishna Potthuri wrote:
> > Add I2C interface support for Xilinx System Management Wizard IP along
> > with the existing AXI memory-mapped interface. This support enables
> > monitoring the voltage and temperature on UltraScale+ devices where
> > the System Management Wizard is connected via I2C.
> >
> > Key changes:
> > - Implement 32-bit DRP(Dynamic Reconfiguration Port) packet format as per
> >   Xilinx PG185 specification.
> > - Add separate I2C probe with xadc_i2c_of_match_table to handle same
> >   compatible string("xlnx,system-management-wiz-1.3") on I2C bus.
> > - Implement delayed version of hardware initialization for I2C interface
> >   to handle the case where System Management Wizard IP is not ready
> during
> >   the I2C probe.
> > - Add NULL checks for get_dclk_rate callback function in sampling rate
> >   functions to support interfaces without clock control
> > - Create separate iio_info structure(xadc_i2c_info) without event
> >   callbacks for I2C devices
> > - Add xadc_i2c_transaction() function to handle I2C read/write
> > operations
> > - Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI
> 
> ...
> 
> > -	if (xadc->ops->type == XADC_TYPE_US)
> > +	if (xadc->ops->type == XADC_TYPE_US ||
> > +	    xadc->ops->type == XADC_TYPE_US_I2C)
> 
> Can be one line.
> 
> >  		return 0;
> 
> ...
> 
> >  	/* UltraScale has only one ADC and supports only continuous mode
> */
> > -	if (xadc->ops->type == XADC_TYPE_US)
> > +	if (xadc->ops->type == XADC_TYPE_US ||
> > +	    xadc->ops->type == XADC_TYPE_US_I2C)
> 
> 
> Ditto.
> 
> >  		return XADC_CONF1_SEQ_CONTINUOUS;
> 
> ...
> 
> >  int xadc_write_samplerate(struct xadc *xadc, int val)  {
> > -	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
> > +	unsigned long clk_rate;
> >  	unsigned int div;
> >
> > +	if (!xadc->ops->get_dclk_rate)
> > +		return -EOPNOTSUPP;
> 
> > +	clk_rate = xadc_get_dclk_rate(xadc);
> > +
> 
> Unneeded blank line.
> 
> Also, don't you asked for options?
This callback is defined for all other platforms except I2C.
Currently for I2c interface we are not supporting any configuration, it
is used only to read the channels.

> 
> >  	if (!clk_rate)
> >  		return -EINVAL;
> 
> ...
> 
> > +	i2c_set_clientdata(client, indio_dev);
> 
> Is it used?
No, will remove this one.

Regards
Sai Krishna
