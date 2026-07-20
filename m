Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013048.outbound.protection.outlook.com [52.101.127.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3C3CB547;
	Mon, 20 Jul 2026 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533561; cv=fail; b=T9JqiqxpnlgsOoRoqc+9JRad6ClUdHIm0m+zjN+G/QYDnN2lZ5GhzDlQDJLhtMzSCy9Kr0+Ezj1KdfJsVloABC/DPmjcZSBYhAuitRf3Rc2FjFJfRetZBd8hogxIP9v74BcHI7XWLT0+Kz3h4r4EuybYT2kbvOryxA8sJ1c5kjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533561; c=relaxed/simple;
	bh=21eYVVo1P+ZPgRExrdlB1cZJCbD408vBBMBXcvs/woM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t3CnNqEm9LFCMCrP496vKu4U3CxPT2MxzLNLr5cvPcfBMLNL4CHd7FK6ectaLUZ5M+WRRY3BhKbWwcY6tUIfBxAuZhdGqoISFFlnjDom/T60F+70+0JIA8dJ3Kh2pPtrTzuuoc+GJY7tubnXWnIraWAQVZkfYtV7zvKz3IWsOTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E+TGWM1/; arc=fail smtp.client-ip=52.101.127.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E+TGWM1/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJtm+92e/9lvhXFk9gh2u6sGA+6ACu0DE0SjyJqUxUykOuA2VM4QqMTcrRyQ4HJotKQ9fhBR8Io3xJBbZlZkeOewpttC+B0WG2uO+s2vRLYbcrp/OxngaZaw6eAuLgN8FAgNvnzvMbT1ln8F2ieEnPZQFPQ0eFngDSiIeE/kNrhDZdD1/B33YO+JfRNmhLS2uJpppBSq38R7S6o90Aib4lAuv3PzJXj6KyoIaXuqjAXTS8ZGcoHuvYbvEmeLv8ye5cGxtZVC3o37YVwZdMIa+4FRsgRIH9o7P2zwj1ekwws03+4n1ui+tXoyNlarP2Bu7Kt8JOh5buD74uOjHlxW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf2j81NHkBD8ZkHkQc6P8a8hf/oRw0gk89ohZVbgKK8=;
 b=ebQMQxMbc6s16hGSrwFM6Sl2ltkAlVduBR+LKf/X8gpVmNZUkidHZDJne/f/ure0zlOrKE8AUgLnZLdLYyVef5+zu84kES7g0qpnYzWEAJvX8rcoDkpFoNiQhnkoXYJo81iSHfmmLC7E4gX4WQxgcqnk1TqMh0WxSkkV1C9CIlmJ8xeUs6N6axj/wdfHXuvnPvhR9qgsOi+AEiPFLHBo4XTrc+nyGlMGmiezArvpWmCBiMvVu62g3z82UKkGe5XrC81zZfnlm1aofJ9WY/N1135BqIHu2/m01UQDwnEMMQGtAYAy4MiWLFJ90H2G+rjOnB7KH9lO1MY73+gMNY2DjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf2j81NHkBD8ZkHkQc6P8a8hf/oRw0gk89ohZVbgKK8=;
 b=E+TGWM1/zgLzIV/efMCC2cJ9g9so9rF7qF2SKatd8ePcAV0FFCq+e+CF8o+aNvdpUQPNvW/c8tXtj+T2NuCyxQUSbXFz1d0YHx7xZE/dmMIWBA0i3fKkNy+LG0z99H41EVo3aQ/t/j/SjsUuQomGTWHRakKCnatfNqqeKHoEo3hHoa7/6sUiE/8VOr6piBQVCgFxM1DsodkHygFVv0Ennp/qGQtK2IKJu7w1A//RROPLQraIPBSASXA7bpThWywUQoPbsfz5Kstn8/eyw1x2nqrxn7uf3al2oOE4y3kY00iAwhEy3S2TfX9y7CMFtR/FDgI7r17IPr5S+M9TwWHtAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY0PR06MB5563.apcprd06.prod.outlook.com (2603:1096:400:328::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:45:55 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 07:45:54 +0000
From: Pan Chuang <panchuang@vivo.com>
To: m32285159@gmail.com,
	andy@kernel.org,
	jonathan.cameron@oss.qualcomm.com
Cc: dlechner@baylibre.com,
	email@sirat.me,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maxwell@maxwelld.cc,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	panchuang@vivo.com,
	tduszyns@gmail.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 03/13] iio: chemical: Remove redundant dev_err()/dev_err_probe()
Date: Mon, 20 Jul 2026 15:45:43 +0800
Message-Id: <20260720074543.616062-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKqfh0HT3qxdPjw5s-5RrZUZmCyNbJbLDsQ9vaCYRXhj6X0KCA@mail.gmail.com>
References: <CAKqfh0HT3qxdPjw5s-5RrZUZmCyNbJbLDsQ9vaCYRXhj6X0KCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY0PR06MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2607e854-2053-4885-79df-08dee632ed95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|52116014|376014|7416014|6133799003|10067099003|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WOPvZKsJMvDP8NHQMB59+4oXBt2s5EDSrXrNWuKq32KTmY4lghM+v/pCiUX6xRcORwox35wJPjQdVfR0Jp6C/RTrOJQCHeCdsXqkR9oXo7Yk8oX1eMvdHLEv4XBDPM/uYLozpl4RBv4bTNjJAIevBnfq92fdoUdMmLkYefyYCw1brgCxYvs6ywNw8tNNic6pHt6F7sQvS1Ofp0tWvBnQvkWs3IN4us6LcfMLVxSgKcIK2wUS0mtIV3TssDSP7yrehJkUFpEXyFOXGkUGFx/nnY9agpfu0IJikyDmaqHjUBL/9Qp9rbf3Ia5r35e8Wu+xpo980efkPG3mURYhQzpXVscBRaf7rAaRyAzik21kNmsvOjyceHfanLWKExtP37/Qwh4iA2Rft+4dHCVfZ33F3BB5XxJBf65EbZiRKqHra/GPmNnjOswxMqSA6BHbSPM8Y9lXOe4Ct2mdtlbS5Kmzfq+MYFkD2K3USN1xohnoHFZcYiO1u26wfIX8VQSdhJgizwTuxdQrGwttUIw2F4f/rkxQYvThzZgJInQsgnNQiiK9G0LIxhOxMauv2jjRqpIj681wRmcxo6jqBX6+6p0W38sQnvH2MSU0n14dR3utQ34TyeqlyiCHPQuKT73XOMdhNelOA4m4lsbzoY1Vf2cE60G/9p2iT8COGxV+g3n2xrmHbDtTZWP6VQqePY+NFL1+Vvc7P6K3odq1QY5QqUKLP1mJFhjgNbOgOq1OGxfdPHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(52116014)(376014)(7416014)(6133799003)(10067099003)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGJ4MTJ3eUJWbU81bEtUUGZhOGJLVUpWT1plUWc4OTcxU1Jlby9xaEFobXdu?=
 =?utf-8?B?YXhzRnlmRnZFdnF2MU45WGd0dU8rSEsrZVdnYmN2dzN5MnIzeWd2RXhZVUtK?=
 =?utf-8?B?eUNOTnUyTVlEaUF2aWVnckpnVlA5QVBpR1BQZEJ6UDBEVFlTeG1yejZjQjlC?=
 =?utf-8?B?cnBHdFhGQi9CRFhlSmNrOGhON1VnQ1NJUDlBNUNjSm5OdjFhcGtzTDNRUmZQ?=
 =?utf-8?B?VS93bTVsVmlFTHZhVGFoaG1UdGZnV3p4SXNXTXlmWm5EcFBxb2dwRzdqMEwy?=
 =?utf-8?B?RXdOVjlJU05tdDNFbzBuS1lhdVdoa2hEMFljK2lzN2ZCZGhzL3hkNWFIWE5J?=
 =?utf-8?B?UVhsVVBqS3IwRWFaVlhacHh3VmZUOFNWV2Z6WXdGY1hWNW9RQVgwZ0FYZkE3?=
 =?utf-8?B?eUZPUVdJUWwrQ3c2eDRnNWdhd1NCWmhqR3RPUGRRVStVcHQvdldmTStIMWFx?=
 =?utf-8?B?ZGJTam8wWlZFc0lFaTVLTEJyUFhPR1FpaEszNWhZU2tLUktWQjRpZ3pyQUI5?=
 =?utf-8?B?Q2tNcVlMTmVKT2hXYjF2cHltcVJ5U1EzY0l1MlUvL2FqNWFYS3E4OUpScFhI?=
 =?utf-8?B?MnoyU3kwbkZKWlg4cXdOUEgvcXRpeXZHTytrV3VmajFwTE9LODNqQUVyMU81?=
 =?utf-8?B?US95d0Y0OTlmaHc4SDlraW5Nb09MTUZmNDF2QndROHgwQVl1T00zc0JOL2M5?=
 =?utf-8?B?TVJNVWJUbHl1QWpKWGRFZ0dhaFZtZkhvbzJ3Wmh3ZEQrRHBlT0JsbWVYaUVy?=
 =?utf-8?B?WHBOMXk3bWFIVjRYYi96MHBTeW10WnVkSGVLcXdPaXh6aUFDYUQ3VXhjRFI1?=
 =?utf-8?B?c1ZnSHhNRXlSZHpEeDJWa1VLVWVIMnJWb3lsYVBuS0l3cHZEMkw4d1lBQTJM?=
 =?utf-8?B?MEJNTkkycnVxU0NBUkxXdTdRcnNFeTltbHIvQU9DRUtxTEdVc09wbWpGUFhK?=
 =?utf-8?B?S0N2Y212VWk3VnBHSmwwVGtYb05QdUhhOXRReStibzZFWHQreEVJVlpiNFpz?=
 =?utf-8?B?MlprOEZrZ2N3ZDM4eXdQSWZTTUs4M045aUtOR1YxQTlXcjRNbU5iUGJGVXl5?=
 =?utf-8?B?MXliWVkzSVgyWWJLUFJWdkJrSElkQ3BHYU91VkNDaGtORSt3UDJSL0pqSnZF?=
 =?utf-8?B?UkJJYUpHeU9oSERJV2dpUmVQN1laQ21jblVKWmF0MFlQdDBXdnl1MUFsZ2FE?=
 =?utf-8?B?c1Bla3F5eVlydkNiblVIM1hpSnR6MFRBNGZhTFFWbU1NdW9TSlNlNDJKQWxX?=
 =?utf-8?B?bUtiMEViaXZJQmFJY1hHSFROQmw0QzRodUJ1dUMwL2U4T1N6c0ZhUVF1R1Er?=
 =?utf-8?B?bEo2TjFSTnNDQytuM2tJdjlNUzNoUDBGUFNvZEpIVnIxYU1vTnZzODRIV2pK?=
 =?utf-8?B?UmI2aGlIQzlJajB5bGdnalZUTjhpSmN4ZExpRW9pMWVnOThDcHhoZUhzMVlJ?=
 =?utf-8?B?UGRXTlc0ZSs5K1ZtZ2hDMjlTeXFiRkkvYlVCRlB5ZzQybzg0M1FKVXdXc3Av?=
 =?utf-8?B?a2NoUFF1OEcySm1LNS8wS2lFNFFON3VoOFZHZU16ZmZWRWhPMndiVXpZWEhG?=
 =?utf-8?B?VzZOSWxXZkx5WDFzb21NMTFMSUNTY3pjTHpEdzFDYzRCL1RDaTlxZEdxNGxy?=
 =?utf-8?B?RWt6Q2h1czd4MFFaL1l2S3AzUnNzZDFpS1krT001a1NPazR4eHpsZ0VHcmww?=
 =?utf-8?B?UERsOWJZbWZmZGtoeXNkZGsvZmNXcGpJRVBLU3NMcm5Ca1lIVmxSbGtvamhU?=
 =?utf-8?B?bDROZWY2LzJHYWNOQXNINC81NFJDRmdCTFhIRnpURXhWZ0tpVEFodHFxNDlh?=
 =?utf-8?B?YWVRZWRPWDhpQ2ZlQ0lYY1ZWR2hLbFl4ZFI0R1UycG5DUklYUFVmK0xEL3hx?=
 =?utf-8?B?UXZPVmcwL0dtOWR3OVdLNVdNcjgrN1FiSHFrSnM5YjVrQlFJcVJOLzNQNXJB?=
 =?utf-8?B?WWpGYk51ZWxkZTZ5VGdvdGRJMWhabVg0eGlJU01QL3RZUXVTQkJ5cFppdmtV?=
 =?utf-8?B?VHNwUUU2eUR2cS8rRHJ0MXJxNXB6N05GNkhtbkhFTU45ODRlTDhCUXZ0elQz?=
 =?utf-8?B?WjhTUDBBQ2lLRzBVOFlSbVZ2QWJMVjlpYlltSytwS3RkU29YeWM1YkwvdzNR?=
 =?utf-8?B?cEdrQis2MTBUaGY2eFVGUFlXQ1BtNmNucVMyTWQvMWs2dDdGLy9WV0VubWE3?=
 =?utf-8?B?cUlablA1bFV1RlQ3WkpFMU9vNWRpdnlkaWlMa1N4TGFwenZ4V2EvSkhyeG93?=
 =?utf-8?B?enZHVG9PeEx1d3JpNmxLZ1NkamlGK0dYQlBXWmJjUTFNSXdPb2NuaFo3YjNR?=
 =?utf-8?B?bk5CekdiOWt5VWJXWDZyM0RqZTA2dk8zSndibzVNSk5ubnNtQUN6Zz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2607e854-2053-4885-79df-08dee632ed95
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:45:54.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2CxU07cHofWIlhm3YgcCxA0tPnurpT7cQrceJljq0uRP/3g/t15mJci8JJnUpbNCSCMHwin+tpWsKX00DfKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5563


On 2026/7/18 17:11, Maxwell Doose wrote:
> On Fri, Jul 17, 2026 at 6:24 PM Jonathan Cameron
> <jonathan.cameron@oss.qualcomm.com> wrote:
>>
>> On Fri, 17 Jul 2026 17:05:22 -0500
>> "Maxwell Doose" <maxwell@maxwelld.cc> wrote:
>>
>>> Hi Pan,
>>>
>>> On Fri Jul 17, 2026 at 4:42 AM CDT
>>> Pan Chuang <panchuang@vivo.com> wrote:
>>>
>>>> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
>>>> devm_request_*_irq()"),
>>>> devm_request_irq() and devm_request_threaded_irq() automatically log
>>>> detailed error messages on failure. Remove the now-redundant
>>>> driver-specific dev_err() and dev_err_probe() calls.
>>>>
>>>> Signed-off-by: Pan Chuang <panchuang@vivo.com>
>>>> ---
>>>>  drivers/iio/chemical/ccs811.c      | 4 +---
>>>>  drivers/iio/chemical/ens160_core.c | 2 +-
>>>>  drivers/iio/chemical/scd30_core.c  | 2 +-
>>>>  3 files changed, 3 insertions(+), 5 deletions(-)
>>>>
>>> ...
>>>>
>>>> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
>>>> index f85cdd8bd84f..770571c21521 100644
>>>> --- a/drivers/iio/chemical/scd30_core.c
>>>> +++ b/drivers/iio/chemical/scd30_core.c
>>>> @@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
>>>>                                     IRQF_NO_AUTOEN,
>>>>                                     indio_dev->name, indio_dev);
>>>>     if (ret)
>>>> -           return dev_err_probe(dev, ret, "failed to request irq\n");
>>>> +           return ret;
>>>>
>>>>     return 0;
>>>>  }
>>>
>>> Please split per driver and resubmit and feel free to add
>>
>> For large and simple repeat actions like this it's a trade off between
>> the noise of a lot of patches vs easy handling of any future conflicts in
>> backports.  Given there are 60ish patches if this is broken up, it is a
>> bit marginal for which approach is preferable.
>>
>> For more complex changes I would entirely agree that one patch per driver.
>>
>> So I think I'm fine either way for this particular series.  One patch
>> per directory, or one patch per driver.
>
> Just personal preference given multiple drivers and multiple
> maintainers. I suppose either is fine but I would prefer it split for
> this one.

Hi Jonathan, Maxwell, and  Andy,

Thank you for the feedback. I completely understand the trade-off, and
I've been struggling with the same question myself: whether to split by
driver or submit as a larger series.

My primary goal is to make the patches as easy to merge and as maintainable
as possible in the long run. I know that different subsystems have different
preferences on this.

Therefore, I would like to ask for your guidance specifically for the IIO
subsystem: would you prefer one patch per driver, or one patch per directory?

Also, for directories with many changes, like light, would it be better to
submit them separately in a follow-up series to keep the initial series 
more focused?

Additionally, I will also adopt all the other suggestions from this patchset
and resubmit in v2.

Looking forward to your reply.


Best Regards,

PanChuang
