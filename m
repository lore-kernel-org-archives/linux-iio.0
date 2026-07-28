Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022143.outbound.protection.outlook.com [40.107.200.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5533C0625;
	Tue, 28 Jul 2026 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221904; cv=fail; b=Mw8NnvUm396OCGSmVwoNJOQE5DI80U1a7VqgipgHSfEVosDlCaRvvNxA4a8xhzmn/MTKSlTYwhQ2lzmQX+1+fA1cqdjtUdd8KJx9MG8cfY4xth8wol/KA+xs64lGeegcytujA3MlE5QOuib/mJL51HflEsLMYfdCe3ftGjoy360=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221904; c=relaxed/simple;
	bh=ZbEXitsu4qxXDk97Aa+qd4F6ZMmfIT17MT876Raf/CE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPEdQD10upmdcsuvZS01AxgWDa4RGjdH1VkYPWhHkancCEifFtVvOX4E7yB7Xz7soUDaIOBSL/Ni0Dhtk68GThY0dNTIYymT8XCDB1Ay6hovXwuSbX1adkpTHHHHWI5YSKkYMxFbA72Fo8XyoYCQWllzs4ol/XY2rGpsFQIGqyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=w6/Y+tGv; arc=fail smtp.client-ip=40.107.200.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="w6/Y+tGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pP6Gcj+z1lIGDaUNQPpxmGJmDhTymPn1citaG8nVYcXsO7bJaV85k48XUbE0rYtGlUpKIlBodsyMUrYrahY0CE3G4ksbHLEGmSe9ZvGCrOiSJsnBe5xyF+D/FKSqQWz8jHgjMt1oW6rjkvcg+APMo1MZ2OeLj6FZvznn9Csq7PM/bvSlrIX6mHN8NsQumSJTvGOcz9Xa0WQxL983yGsu5S8qb2VjsKcoNGSMqFnduJMl3GR7AMOHuR1ufMzFKRp0d6o0e9L1FjjKjHPGQ2jv28Cqxvk2RXS1NEoG0Q7KR+yqbWfNcmRbafaio1pz3jngQ4lfrs338+8iGp/nwEJNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30ejPXOUVHwPKjjpM5gDpczCuwJoIND9DzGalLxukRw=;
 b=cymlRXnKD9PuUQGSIaKkC+mZz3ACxt90D8wUGVxPCgBozl6/6ixHWul4YZEiKO+EvqBbOMODAHLVdUkawqQyP7hqIY3uAuZQL821KZXvaU8KBrVVJdQJBrTSh5JQRvrYYXfsqTSoJAjbLD0eL0EYhPpRh8I7z37SIMQrXVGrq9AP4x49Wq5ZFni4eTdGc9H0WetlXVhGeg8UolkW/Vpq80Tn3eEh2U5gKHQxtjtZVRyaOpjQcHayEEsGU3uP9kMJ1Hj1GasXLRcFokPHcR0MdI1s5dx/L/yLvHwoCxypKAckhhGeoOYy5U4oT/+FjVPJI0xtG+qes+xwZYvQ/as0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30ejPXOUVHwPKjjpM5gDpczCuwJoIND9DzGalLxukRw=;
 b=w6/Y+tGvHT6EoWPWj8wi8npc0YuIWa6mO/IZ6mF0aMIV5NP4ZTGAyinWATIxt7+10QzR18pSqkwXr933fJ8u2Ktf48JTh5ea7HT+0bJnDzliiFVA/8evu/TYSiDWp0tSNjhDHOB3eerxjG0hmzipmpG1v+Fj+RmK3tz1+i7ajYRU72Fxy22xp+IfUUihbkoZ89Ify6iCHtpL4VdSCPa19XGG5hlD6DiBWd5NXfhDIx4yZqdt6njgL4A3WmvR1p1WQxNzvxlxBCTcMTkBi+CbVCHRMLqqi3YJgOpJWdxfv3EAhJVTT4dzryJ3+Unjpu21q+U47IsWp4VBZ293PfBl9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 MN0PR18MB5943.namprd18.prod.outlook.com (2603:10b6:208:4a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 06:58:17 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 06:58:16 +0000
Message-ID: <de947dc3-6d02-43de-a9e5-7f1e950231b9@axiado.com>
Date: Tue, 28 Jul 2026 08:58:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
 <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
 <alnpMFK6_ZkdWlLi@ashevche-desk.local>
Content-Language: en-GB
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <alnpMFK6_ZkdWlLi@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::15) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|MN0PR18MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 34910efa-dc9a-40e7-6e99-08deec759945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hWR3ChUI+hb68kYPkrF0FW2DfLd+htedB0uDg+2Frfj2SiiAsUURm5/+YXHsWXevkUznd4cQFK2GNKGFRvWxlaPyfCzKmoN8UMsqqqHlOqI1rZdOsVQgF4UOqrburSuhnSYI7LtY0amUqpPpcvAxiHSjVUa3MSRX9r8AF9paqKYkBxP1r0fVlgn3V5ETdRZnlVbGs1PLS/miYLdkd1Vz+0NjhxZFOjUY1AibKwW5RW/oplqGg43XUGDzPiNAg+fP9iNKUxaPejF+GQjOV8UcxDioBt2p9H84o76hOGaGzYmiDjVyMPUulB9jUx6RjNJ5BqgLt0V/eyYv+HWYvFbwD/InAfvSkEefoHmACC67+OxnnYC4MBdNspajtWp500dRkUDyoxtSTSwnh9YQTchH8tEvbcG+3Trg/ADN5W4+1Sfx7m78RZTlPf5J7t1eBfDoTwrOqtd5R8NQ191+F/sLwC/0O9vpyd1KsNDau5FMAhgqmf8ykwaIiiBABmhxv+tmPOqDsEcPuQK9cdK3z7OQCdUAOL2fV87WFBQNOYhY6h4gHI4mg68WEcHek86P7Wlg4/IsYL8pVslrxTPqovXvTHUXQE73nYRdFisDKUhkzF7WYCpio08qazD7RV0RyKs+/NW2m6IQ6vutU9TWIaEw6QHZL01tN5ZkrNYDzrXib2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUZ2dWZCaW1SeXc0SlFhVnhSK2ZUWmZmeUEycnVpZnNKK2V1YWVPQXBFN1cw?=
 =?utf-8?B?L3B1QVdmUk0waGZKeEE4bWVjWjVRdFlOVC9wbTczMUNudWZBbFJ6Mmx3cDdo?=
 =?utf-8?B?Qi9aZktRQWd2dHN1NmxHRmxUL25UZEFiNXRxcDM4QXpHNlRmZnNGT3YzR2J2?=
 =?utf-8?B?K0dqMnlwUFQwdUhTbmplY1FpRzlWelU1MkJUUi9OVU1uZE1ONkZEN0dBdm1w?=
 =?utf-8?B?cUNqSjFZdnF4RFhPOC93SEJ2RkhHQklLZjdHa01oeXNKMENIRG5FMlhVY3VZ?=
 =?utf-8?B?a3hBQkpFUyt5U3ZFRFQyS2JQc2xpRHUxb1pWcDZyTitDcUt6UEFUeGFKeFNs?=
 =?utf-8?B?MnRCd3N1bHNUTlAwb0NvOXo4cjYrNHVHbXJ1dlJMYm8yVWY0VVEwYnI2Smx0?=
 =?utf-8?B?S0ZlbVBkSGp5aUNpTjNFMU9wVk1YOFVnRzgwOFNRMzR6L2I0Mmo3TkxjNUpT?=
 =?utf-8?B?cjcyaVhFZDFOeXc5dTdSNVVVZUJMcGd0SlRscTAxYWpwaXI0VkdMTlBSdEpi?=
 =?utf-8?B?cTNwclFORGNGSXJTeklMbVhDREt0OUtvZnpTRVFWVlZILzZHSTVVeHRENFlZ?=
 =?utf-8?B?TEtEUTdUcStTblVFdkRoRERVMlpNVUpEMHIvb1JtTzNYMENZd0RCUEdaVEZz?=
 =?utf-8?B?cXN2VXNKcFlDU3NDQ1pCNXI4Q2lON1ZWVXl1d0ZDVjNydGFuTE9JNUVVL1NW?=
 =?utf-8?B?VnBENlBkRVd0eFlvSUkySDN4dVFVNU5OWitEdmNFeFhwVkFZd3RnWnpMZFEx?=
 =?utf-8?B?dGk2alVxdGhlNGVaYjhrMjRrYm5jZWZlN25ZS2RZRU13Z1dBVGttWUlmRnY0?=
 =?utf-8?B?QVdKSXl6cUYyTU8xNlhub3dyWk13UzJYeHJZWWs2TzBmc09oNlBjdmJFSVBJ?=
 =?utf-8?B?UEo3SXNLcHppNzVMQVREV2JvQWdSSnRhbkpSc0p3d0hLaHV1TFA5SFNadjFI?=
 =?utf-8?B?Wml5Ymd6Z2JwbXhqMUU5Z2FJUHpBajFScmxDbzljVzZMcmkzR0Nac1BoMS96?=
 =?utf-8?B?TzhjNlBNMWl1cVRDL1JmSHc2WElmVWsrUXp2TFk1VzI2azBHN3Yva0tYSlZp?=
 =?utf-8?B?bmwxVERLVjZwYUx2NWpXSWd2YmFvVGdKcDE1eExIVmFtaUh3aStWb295b055?=
 =?utf-8?B?WVVGZTJJVDFZNHpjWkZ1cmQ0T2pmQ1N3ZW9DWWYvZXp2Wkl4SUVBbXVJKzlj?=
 =?utf-8?B?TXNFMmNpTGYzdVdncThZWG5hZEE4UUtjQmZRUHlLbTRNTzZ4ZjcyN0gzVVZ5?=
 =?utf-8?B?NVFUYUFnOGdjOUE3OHJlTGRlT2dJaDV2Y1RnRkUySDZ0a1M0RTBrdFhlRzFn?=
 =?utf-8?B?OWNxZnVIVEpJZTlsL2ZKeUE1WXdoQWNKUHdLd1RqV2ZzU1plbmdhRlJDMW00?=
 =?utf-8?B?T1VYWkpiODdXUmEzTzJNMWRyR3k0aHFibHFXZlozWXpaek1HdWZJcnNZdVor?=
 =?utf-8?B?T2dkeXZqTmtCdzlkNXBVRTA3WmtZRXhJQWFqVVFOMGp3amc0bHo2dVU0eVQz?=
 =?utf-8?B?OVBiYmgwd09GSWh5aEowWTNuMnA1a1MxdTBWL0tIbnNKRzNxZnVNZnJhSDkz?=
 =?utf-8?B?ZXNaMXF6dFN6b1RWUFZDMTNUbWM5SGxJM2FRdVJ4SDVobWZ5Skh3SFREK2Nq?=
 =?utf-8?B?T3dTL0xSSVFvMXU2WHl1ZHJCLzZIOWRoQkdPVDRkYkJKMmVSZDNJSVQ5NlNv?=
 =?utf-8?B?eG1KY3RZQ2hKSWVISXZnTjJDcS9YajV6cHdmci9NNHl6dzFBWG5EczFPSlll?=
 =?utf-8?B?TlVQWXFwdWw4NEFER05rSmNGTTRhRE9uWHRBMzcxbUhjVmV6TXdhSml1RFBV?=
 =?utf-8?B?U0F0Rm1NdVI0T2JFUEdZNzdrK0hVMzIxRGZjVThMTWpWYkF4VzYya2dXMG8y?=
 =?utf-8?B?ckVOOERyUE1DRVd0eTJRR3pZb0dXV0ZDTUNMRUZjZExuMG1pc1lCWnUybjhS?=
 =?utf-8?B?clcwRlB5Q0tram9oWFNMVXVyeW1McjFZT0VLMW5YZy9QSm9CVXVEbFBORHI2?=
 =?utf-8?B?dzZFN2xMQXF6R3VxVTVkemxvenJlbEhsMFBLZEdSa1AwUmI5dlpUcE53U1pL?=
 =?utf-8?B?Z2pNZHNCS2p4TGRjWjJYSkZoYTRwWnQ0RmxoWjEvQVZ6ekYzZWRoWEJEM2Y2?=
 =?utf-8?B?MVMycnNZNFp3cjNUcTNDbmVxeFZ4UGIxNGI2STJQWFYySXQ3bmdqR1pHVnhS?=
 =?utf-8?B?WG9xODdnV2lYaHViMTdRd1psdXl4a09xamJRNDF3ZXhWTWNNMW52WVM4eHRu?=
 =?utf-8?B?MS95VWh2cWdQUXpaSWR5blpCRzhHQjd2VGQvaE92UWtGcFdVQ0twcUpEMjRW?=
 =?utf-8?B?WlE0WGdaR0hvbHFsRHVJOXhJOFU3S0plaHVxVHdjeW9KZmtQQS8wdz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34910efa-dc9a-40e7-6e99-08deec759945
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:58:16.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJB0MDxF6QvnEPYxYsGHAhFpq2dCJhtMSPKnWpHua1QvR57DjMg289EUttAERcc/qDb5ZGwUz0htRniVEUW2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5943


On 7/17/2026 10:34 AM, Andy Shevchenko wrote:
> ...
>
>> +struct axiado_saradc {
>> +     struct regmap *regmap;
>> +     struct clk *clk;
> Makes no sense to keep it here, your code takes the rate and uses that,
> I do not see how clk is being used right now. Perhaps you have plans
> for power management? But then add it when it's needed and being used.

Hi Andy, thanks for review.
Agreed. The clock is only used during probe to obtain its rate and calculate the conversion delay, so there is no need to keep it in the device structure. I will make it a local probe variable and remove `clk` from `struct axiado_saradc`.

>> +     struct mutex lock; /* Serializes ADC conversions. */
>> +     unsigned long clk_rate;
>> +     int vref_uV;
>> +};
>> +
>> +static const struct regmap_config axiado_saradc_regmap_config = {
>> +     .reg_bits = 32,
>> +     .val_bits = 32,
>> +     .reg_stride = 4,
>> +     .max_register = AX_SARADC_DOUT_REG,
> No cache?

No cache is intentional. The registers represent transient control, status, and conversion data, so accesses should always go directly to the hardware. Since REGCACHE_NONE is the default, it is not specified explicitly.

> ...
>
>> +     ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
>> +
>> +     /* Stop manual conversion */
>> +     stop_ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG, 0);
>> +
>> +     if (ret)
>> +             return ret;
>> +     if (stop_ret)
>> +             return stop_ret;
> Why do we care about stop error? Isn't it the best effort we can do?

Agreed. Stopping the manual conversion is a best-effort cleanup operation, and there is no useful recovery action if it fails. I will drop |stop_ret| and preserve only the result of regmap_read().

>
>> +     *val = regval & GENMASK(AX_RESOLUTION_BITS - 1, 0);
> Is device responding always in native endianess?

The SARADC registers are little-endian. `regmap_read()` returns the register value in CPU endianness, so applying the mask directly is correct. I will explicitly set `.val_format_endian = REGMAP_ENDIAN_LITTLE` in the regmap configuration to document the hardware endianness.

Best regards,
Petar

