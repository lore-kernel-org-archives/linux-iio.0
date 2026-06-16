Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022121.outbound.protection.outlook.com [52.101.53.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679834192FD;
	Tue, 16 Jun 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599513; cv=fail; b=dCnfFLt9ZtClQHL9kRtpimjP0DRIYE53zETY5itRzNtRbIjNabukiMLgOOFjMZHXvVPSQAV+cfsj+UfIC5aFBXfCa7NWxOZuvaANrJwc8/6pSDRTuX3Q0xHzvMVzRQNfWF3auynHqnh4r9CyMaykA0Lwq9ISvYJ+evbyG1TsnJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599513; c=relaxed/simple;
	bh=jNLN98ZWz0MKpNvdm4Zh13BdiUoUeIX09kWeAxzdEks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGT3ZDJ9ln500AsQ+uNKMELg2sZby8OxlGopjweUGmzYQ7gvyw8xeLKOTyvkhsDlB0hbuQ6tN15eDxzZ26e641zxQt3TXmq86RzZShS+lLSCUNU8DVg/E2YjsVdZ5HZy4SqzPtR6QLcuvFEiIsRbfdYN8xt216N8tNMShnTZwVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=QxBCqjZ4; arc=fail smtp.client-ip=52.101.53.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="QxBCqjZ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAzxIwVyboGzjfxvlaPePiy+BejuuB8c3L7mzL7rcDvofhKfoaUSz9TR5uJhUr0/4m8UKlareQLdbRKdwiPIQ2m9qAdzs26yy3KBE074my+01qVphGm5LDIx5t+WCqPzaJ8nopeDphKoV88E47mBsoDioyn7WedpXXbzF8hvGtc3/wXZ4ayC1+3LLHMk6jghO5EuTitlt3t8TDS+VT/DKrw+0cxFrRqFR830408+xTylN+OjeD6v3gAs+py5qukIVxHsd64Fkz41pMzo2XAQQfVBbLNx5QCQHEhID0h/ohf2VEIG7FW8nYnIk86uDq0ZKDyC0LddldtZVqnkce7JAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es2USX/kih+n6KKZQznVlM+DXbCsDIbVfN5izjO+HWk=;
 b=lvF+66v5HvWJmL2OhyWm/YsyYLc3UNP7AWA7MW7jvHzFH9+UtHwqTB+oZGzn4XWVUhdFQwZO7uZfrpL44zOmf9VINBwjhnCe1hRzytDoidcMURrRWG4H0Oe4Zln/VZAIXXUN6v5A0smI28FKSV8eU3CoYmRKxQMh1RA4iTwpd6+jUYml/Hj92PkkSXOJ2X7SAy7YiNqgF8Wc9zhBuBu3teegWet7zlbs+w71gOYOln0i+f9wqtrJ3olOw43tjZpaQoidxbHSxSGgLvQdox18YnwZtGyXHSPcDiRGxNjZgKP5gGj5ey3sPmZY8Z/4+hC1Ta0kvG2gP5rp1FDGoRvxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es2USX/kih+n6KKZQznVlM+DXbCsDIbVfN5izjO+HWk=;
 b=QxBCqjZ42QVEgqYzzUPaLiKgxunftGFLIXVNPFqkEbi9G5Rh+29x/uEDSYkQ9lMcb7j1gfq3XAovwzAajXte6ByE0UqUAmquJffHtiHTlVubZDlaBBoiHEnMKf41WoK5z+0Rxrgf6MRLqHbY3QOhilHRfwtPxf4EO1gFvdUBT14xOzn0cvPJsp0zjRAyqFrWni16IvmveK3fWHIzU8K1+TURMyGxbydJa5L3kImGhmAKooGojJ9g0En1Seb9qd0GXhKatCaraUWm8DH2/qQPQe7JULuMufmFQA2FKksLnTDEm2KMjTuOUpYDi6oLDOlJvnm/VK+7qUOKH+BadoLVqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 CH0PR18MB4305.namprd18.prod.outlook.com (2603:10b6:610:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 08:45:08 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 08:45:08 +0000
Message-ID: <df6b0d94-0817-4293-bf73-e8400f819ec6@axiado.com>
Date: Tue, 16 Jun 2026 10:45:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: add Axiado SARADC driver
Content-Language: en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260611-axiado-ax3000-ax3005-saradc-v2-0-913c9de7c64c@axiado.com>
 <20260611-axiado-ax3000-ax3005-saradc-v2-2-913c9de7c64c@axiado.com>
 <20260611110923.2f55d280@jic23-huawei>
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <20260611110923.2f55d280@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|CH0PR18MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 5432eaf7-1d55-43e7-82f1-08decb83922a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	YI7N4gIvcRxhASVWfrcVmpk+5KRTGHjkBzsDgMiSCz/qZJ2IqjJF1a/1RxFbG9t2ka9K8ph2RHMSiJawqa0X2HT1i7fqdQoO47BIgVlqeO4i38nBhPDBtDQwbX1dxW7HdXxmmPA6cuSVsMXgKqfK5JZFV2UWmZoBuySkxm+NrhhHBn99oIY2t8dk9swgctxLbKYUK75dR8xxK3VXbtXsr7gP4IcOD9OVtzNHmyPC0lPpMhucAZCB8ZCryFZmeVP4Tt3UpDv+Vt0z/yax1G48xc5x6fwY7nH+P1O+JvJkShybDEq5eQ9V9eKL+FW6rn7OsFRTZlUFYiq1BYEgQfBIWA0+VJO1Ko3sJu+bvQcEzhx67R8XpD1JzkKI2+C7NspclQqRVUDIQcqTs2DUV6qoowJN8G8W6jRgBBE8nQFZfVhEdAyVD5RX2K7mBWbCB4ytjohIFe4yN5TZptfao0/FlZo3/VRED/vjnnGHR5NYBRsdjvYjbbeBvseTj/XR8Ba+koskeG9wm+Celsz4tU0qN1h9WW2njLlz9TYfakS9uCcGgjRd4FK1YUKd1MX+KxCc6DUNiHH9gwjbHtPOs1tXjCkoaUNH35lqunpePIlTb55hPSvoyU3RWteysdyl8RaBTMs0+DgMxSRXYQzfF0l7oKoYXuuttOgAA71z9pJK/BHfDKm/sWW09RBbo4Uk93S2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FBM0lCdzFiakdMTXVYLzNFajVWNFFScTNUbHZQQ3YwYmhtd3RBb1dDOTNz?=
 =?utf-8?B?U0NLcUI1bldsV2dBZjdmaW1HYVYwVWdjd0lSNDFxSDJZeTNNN3lTOVd5Y0xQ?=
 =?utf-8?B?WnpyaGUxa2FORTB1ZDVkRWFBdVRyU0xNNFdQQStEMU9rdWVLZHZ3SmNsV3l1?=
 =?utf-8?B?L05Wcis0dVNtRjJlMnRFWUcwVjVhT3BYbDF4TjdFNjVnYTVyNzhyTGxOa3lW?=
 =?utf-8?B?K0M2QWZtaU1jcDhudmo3c1kzaUl5TjFxanVhSmFjUi96NmlXVXJKUXYyd1lu?=
 =?utf-8?B?clNzRkc5Q1ZoY08xUjdWeGVWMXVWenZ0bXM4M1NoUDF3YzdqNTkzM1N5SG9W?=
 =?utf-8?B?SnlCRVU2ZjZUYXo0L3IyemlGdUhBZkoyRVFsbWlBY0UzWXFsVFJkWm5ycks0?=
 =?utf-8?B?OTBxTVVLd2VtSlJSS3psVFlMeEw3Z1BjdnN5SlRNdjQzNHRpOGY5cFpXdTNM?=
 =?utf-8?B?Z2xIcVVVRDFVc20zT1dObWQvUEdNMmxscTBlL2RheEJjZmNRZzJHOCtlV2ZX?=
 =?utf-8?B?ZGJETmRxdHlySDcwdHE5K29YUGJCdGp0V0lIaDRRclFyTkpkUWhYSExGcDNs?=
 =?utf-8?B?bks1UnpnOUgxVXdPYTNFdFZHdjJFejFkQkswYmxPLy9BWDJSa01qMTA5cjly?=
 =?utf-8?B?MC9KR3l0dktqWUEvRzkrc0FvT2MyUlJhMHlHR1REbGV4WkUyNkNpWk51MUZI?=
 =?utf-8?B?aldoVVJjRk1aWlQ3Z0dlckh3eEFxOWtGY0tnSTA1eWJneUE5MjlRRUtZL0No?=
 =?utf-8?B?K0xtdVJlZDhhalJ3RmN0UFViZVp0OHh4OW9PRE9laG5Cam1UbjlrWFlMYnFv?=
 =?utf-8?B?c215QmtESkVTOE9GMjZZaEZRV3l0NWk5Tk5XUVlua290UDJxbzF2MVV2bkZp?=
 =?utf-8?B?a1VGRHl6SDk4eUJaU2J1K2VuVlhDVGl4bTBDZ0FmNEZUM1dKZ2tnQkpnOStJ?=
 =?utf-8?B?akhROWN4M2k3TmVlcE4rcFhEazhmekVQSmFpbXVIQkJSR3VaMmIxV1VKMnh0?=
 =?utf-8?B?SVJHM25wTjI0L2RTQkFYTllaV3FTeFh4VGFFcHFweDN6THY4K0dReWFYYVZ0?=
 =?utf-8?B?VlJwT3k5YzYwTWVHV3AxVnpydkJDNElRQm12cnU2eGoxQndOQzBKT044T3A4?=
 =?utf-8?B?RENXZUVobG1nUEJ6QmppK3A2cW9vSmFnSWhsUHNMNVpzNy9rL3VQMUlTbEhF?=
 =?utf-8?B?UUhEd3MySkFsbTNyT3hpZDBxS3hCYnhpa2dLT3FXb01sak1ld0lWTmttWm5s?=
 =?utf-8?B?UCtvNkp2cXNyMzhqdklXL0ZqbVZhZnRTMXdpaVQzMDcwc1hkMnpycUMwNFVO?=
 =?utf-8?B?c0Evak80Wjg2STlJbm9iNjJIYnZyeHlncldIWjNvRjNuR3VNSnZqSnN1QzM5?=
 =?utf-8?B?YVhJZzJSTTBlUXpveVdIQXBxRW5FYXVWNENvc1FuSzVQVGxvcmpkNXVCcXdK?=
 =?utf-8?B?TjhQOUtpeitxbkVDaW9HcmFwVHZUbzUvMXdYcTNNRHV0aUFKQXpQbXlEeUdU?=
 =?utf-8?B?THExaGhzV0ZPUWdqNHEyeGZrUk1UU0UzVEIzTEE0c2t5UUZteUlCSW54NzJn?=
 =?utf-8?B?b0Fqanc2YjNQdU0vdlNRVm13YjVGVVJnK0UvOHI1MFBZdjFFY1lYU1FLWnhD?=
 =?utf-8?B?dTZ5ZmJCb0xTeGw0S3VQVXhUWkFIVFlRem5xbXg2N0pPdUlmZ1VsR0ZlUWdL?=
 =?utf-8?B?NFFhb1A4V3RVT2xXZmFubE1CMnR1cU9GY1RPRFF4WWtseC9ya2lhMlZuVFFw?=
 =?utf-8?B?ckJoemt5cHVIMisrUXgxK0hLZVRRbjNIeUJUclMxNzdnQytsTnczb1VHUWJP?=
 =?utf-8?B?aVZHNDkxTm9rTlR6NGEvcHpoNlNHQnJFQjNIMC8rb29DVWZVQzBET0JmdTR2?=
 =?utf-8?B?TFVEMTBEZWtLQ1BjeTZMYWxSY00zaHVnRUQ5cmhwanZOZVh2NEt2Y1RkUVlW?=
 =?utf-8?B?d0M4d2lrU0pORUdwR0FDbHRLRk9ZUk1QeTNvRTdWanovYjNYT1NoQ1Y5am5j?=
 =?utf-8?B?bVEzUXB0WTViUXJ5c2hNdndiaGZIZkREck5zbGRZbGxGQldxVzNFaUl5R3c2?=
 =?utf-8?B?TmhYdUJPTU5sK01qYURWWStaaXM0ZVJLNVFHTlVlS2ZhdFF5clhTOElNaHZX?=
 =?utf-8?B?TVZjbEZ1MGUxcUtvL3VOZWUrbTE0dVpjN0I4SStJVllZNktSelA5UUVJc0ps?=
 =?utf-8?B?Y0dvcml4bS8zdTd6TURxQTY3QXpLaEpJcXNzSVArbmpMb1F0cFBESDU0QXR2?=
 =?utf-8?B?bUpKVXYzcWJXRk80UDd5Q3l6enpMZzI1NWpiSDhVSlg5SVFMcHRtdTR6ZEVW?=
 =?utf-8?B?TzJZZXNSN2lSb2NjVTgwQS8yMHp2cTZJdHZRcUxrZitlcXlVT1lsUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5432eaf7-1d55-43e7-82f1-08decb83922a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:45:08.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9B8IAhi2UTaQ3MkATnwfFNFxkd5v7HurZoxXGj9o+KYIRswTeebp06ESNBiMNKAxkrAsWHMjl9JAU3GPMuBMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4305


On 6/11/2026 12:09 PM, Jonathan Cameron wrote:
>> +
>> +#define AX_SARADC_MANUAL_CTRL_EN(ch)           \
>> +     (AX_SARADC_MANUAL_CTRL_ENABLE |          \
> Why tabs to place the \ above and spaces here?  I don't mind
> that much which you use, but aim for consistency.

Thanks, Jonathan.

The indentation issue was not intentional. It was probably my mistake while copying and adjusting that code, and it looks like my editor replaced some tabs with spaces during the copy.

I will address all of these comments in v3 and clean up the formatting consistently across the driver.

[...]

>> +
>> +     regval = FIELD_PREP(AX_SARADC_GLOBAL_CTRL_CH_EN_MASK,
>> +                      GENMASK(soc_data->num_channels - 1, 0)) |
> For readability that G should be under the a of the line above so it's
> obvious this line starts with a parameter of FIELD_PREP.
>
> The particular form of indentation you have here with an effective 8 spaces
> after the start of the function call seems to be something I'm commenting
> on a lot at the moment. Is some tool defaulting to that?

Yes, that was the same indentation issue. I will fix the |FIELD_PREP()|alignment in v3 and check the rest of the driver for the same pattern.

Regards,
Petar

