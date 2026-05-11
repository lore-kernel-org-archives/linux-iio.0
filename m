Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023090.outbound.protection.outlook.com [40.107.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA563FE35F;
	Mon, 11 May 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522400; cv=fail; b=kWGG2uGsYeiQM1UzDKVo6Z1S0o4JIWH7iIFkoJYdGo6grNR4LcX+VnxlumJ+eZoEXyG0wfF4RzlNyrC9SvGWvV3pri54vodQW/rDtSMfSFwJYxqrZ1Mxd7b0Z8VWEQVVF5MV+diVajJQynvNXUTg0MZP4jQ8BxkCb9BBEPshjQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522400; c=relaxed/simple;
	bh=pXLEfbm47kxkbZQ5b344QedfTPnHsXO93xq4p7i5uDE=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FVPUehJ5WA5QD+KP95UHelwjXP4h4IdM5ZNva5qZt/mL9uc5+f7KU65EMP7uAoohN5pH4zVmdmHm+CkCaITjFfQp3BmA7iI7kGnbsFMOCdBVHgwBnc5v8FvKwd9ep0dLjRFTynIjc6+QeNLPCcuqTFoAiFCUi5i+6dngUq1yGB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=cPy4wnFc; arc=fail smtp.client-ip=40.107.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="cPy4wnFc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaGKJB531dA1+NnFPJ00+KeCadcyn5Q/HGx4W0pO5s6+cs//uDC6wGHDA/Y1b3OAXohz5O+8jNGR62sE9quxbhb50J1kS4l6qdhIdoraIsAmO0qwdg+9WHWMK7IRrrvx7jll6V4d5TfA2EoSIkQtnL9IJY1kRYAOxbvYgB+md21MQbHXZ4I157lgwPiZ54RCS897sFxFBb0TTJvZC3FlZhDmPkzwTjcgP1b8SOVjWXVnf+sj+lOxKtoi0viQdYxSi2d73tJ7DpF+ofnKJDefR2BvzSVXZFx/uZvcXQeH0xs1AtNUA5lsh1ADneL2QSmG95QS61WRItx2Fld9ROxHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOE7Hk3cnhkPEZRKZVHLS4nVxPL7lQKzn9HSMc8vUok=;
 b=yxk2OKNIEvzoWNLsLul0zc5OS5i9nN0D2TluCM4RCg0+8pqBIefqVzZLT9l744iPccco9HiqwcVMBhRA/jhpNAxVhVqZAWcZePw8U32bBsuxwg+LYVyeCoMdm+34LgBICIceenKUwvLOLGJTitgC1ReriVzWM5V24uq3E3TJOI2By4pj2sVtgZSmqgsE8xwx5fGA+5aBdnDG2wvy3tlc3l0zrFOrqZqFNsbjc4TZNl/jnYFfW0HiRE4YtJjkksEYfWHAHutXC8qPSnX72CbKQ5IHKTFGOqQ1pZFY/NNEqzqJCRzFHl8sIIv9uSJqozbOn567dymP7ibn8UbAI280hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOE7Hk3cnhkPEZRKZVHLS4nVxPL7lQKzn9HSMc8vUok=;
 b=cPy4wnFc7MAiY9PV1h+2hSTP+b/ZC9o2sRAFyg1Hq5WGels/s79ZNntVGbbYOHnbtHhn14DH+jug643HF7/CkGOBVD/0E//WalVY0b3jeAckwassvkBA6etw6WjefBKGNeYT3nDpqduFkMvX55Lt1lvoL98n9cQc3xAgKxeIZoYUJeU/21EMhy+fmDKh33vDPbZh8Sl3Un9XzeC2Fig8ijCARMsodrhGeNXTIN7qi+l3p81HE/zUtycV4OMxNNh5jqDhvNtkpUfdhphc2qwug2a3miA6JBuXF/wnirztFhOps2l1YrZG9zYVxsh97rxT+6d9z40wwrz159Hgpz6+gw==
Received: from DU2PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:10:3b::26)
 by PA2PR04MB10409.eurprd04.prod.outlook.com (2603:10a6:102:415::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:59:51 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::c2) by DU2PR04CA0021.outlook.office365.com
 (2603:10a6:10:3b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 17:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 17:59:50 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.64) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 11 May 2026 17:59:50 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by PA6PR04MB11735.eurprd04.prod.outlook.com
 (2603:10a6:102:522::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Mon, 11 May
 2026 17:59:46 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%5]) with mapi id 15.20.9818.031; Mon, 11 May 2026
 17:59:46 +0000
Message-ID: <2457ddad-a44a-4563-a51c-7d8d1da72b95@topic.nl>
Date: Mon, 11 May 2026 19:59:45 +0200
User-Agent: Mozilla Thunderbird
From: <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads1298: Remove unnecessary CONFIG2
 write during init
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com
References: <20260509151959.3475-1-shofiqtest@gmail.com>
 <20260509151959.3475-4-shofiqtest@gmail.com>
 <7ff89e1f-f5ef-461c-83af-18360ad5dab0@baylibre.com>
 <20260511170635.4dd3fdc9@jic23-huawei>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20260511170635.4dd3fdc9@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0044.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::8) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR04MB12030:EE_|PA6PR04MB11735:EE_|DB5PEPF00014B9C:EE_|PA2PR04MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f061f0d-76b4-41f0-1abf-08deaf871907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|52116014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 UX9EiIUq3Q2lHls754R6v1VmYHhRM0Q4HsGU2y4rQ8L5u7Iwun34b3xdR8eCVUDkFUWsbiGfpuRf0EeiSiPDZBdqf1tWBScKElqxWZB2/uTGO0uvWs+eYhhSPNEQk19qDcOmA2qNS0I7S+HrTyfhfIhq2uDYpWu0b9jzkeR8UIIAccCghDNBUY69ljfXXpH33r+3MkEQP8HqxGf5YWR7WBTdmHKoTLxWc/uEgJG/1Y+LhMvtPRynFU9VBR0vaASJ5qhiFFpqSpKwycN7KswgwG8K8Z0pwYcETuvbVVYhDHUx7ea9YuWsxeMCwNkEogv2ticyRD3BVTIBpYviLvkgAvRqtiVc7k08mpPeYK7j2PymZID5/RrwljgAdUQRNrrgMVnxF10cAo/YTh3BsJb9CDOWXvAVB5vh4jobdXfp7haG/VYLtihUrQeleiTQZTSgYxMOi1xxwkuQOGaoSqMz8+x4onHaNAedT2YMs+q9c1g5p0ATSVYBv1PeOsuU1l8SqPQLUb0GYei5B3Dc2gXa2kKb7h1ypnQ/SkzN6Iyfv2I4gMVezO7w6ZhGfY9f2XpxTtOXNbjJ1mWTae34Eq3U2dRIzU4MFUYxwGhcsJW8ivO75ZWh2niztC46ttunyKD/+lTBAO4thtlpljUDIEdcrQtqubr1fvT8h7XxHUjeN29GaDhWbiuy95wtXOznRvvz
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: VFQu95LzeozMuvGeRoAXrljJrarPdPe0wjIVMWPpKUSltt5ZmfAcQWd1KG169us8Oof9PKl4W4aNzF4vMMvnBnot1O8r7IvVgGBNApLJJOu/K1aEyeC9dUz3n+eT6GjtkW4d4bS5CMDQC6jnZz/gnwJwAbzOXY5rEO3T1GlTp+iCqgQE9AZyDQx6Abx835RXiebgHU3ULOQxvCN8Hkma8nczPiZxGaLvDMsdxdm6A0axiQQjc9ECGyNexa8gs9TW7Zdvhy9w86PuddtzZ/fwE5J+s7+u+RlrvxU3PCNioXPJ6cDzkj+558zto7H01BnrnAEB3DPa+cR3eRUuikZFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11735
X-CodeTwo-MessageID: c319a288-8bb3-44f0-b730-a7cdb6bae71f.20260511175950@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ecd47999-4a7c-4efd-e360-08deaf871681
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700016|82310400026|35042699022|376014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9zXCmGvwFl+ihTiHKY5JJWTsMsXTJKBm9kVPE0mAHbP7onR12Gwje4ElaiQ/5i+knwh6TWoNvhUEmKFKL8QAmn1HxruAYJEfKP5J8nhJ4i8rhetf/WnKbA3MCsEZdovuV+qq0tBZ5W5DVOqX0rLDBY+Q8YhTPchp5qSVlT0k7wLddKAlM1QCN0Qod/TcY4o2ukVyiW2pNwgTqQkxTehmZ5HypCAD1qMdHROOs6F4/3AZ3iD1uhNiPMcbTC+0M/QttbBGI2tiXPCgZvMqCgOcWIdLONK4UGau0FjNK67KWeYNQaYj7LVg8U3hUaO7OoYCHeofrCr6Bo/xDhFArub2CeBCWO+ARdAShLocCyCAY3jX+CT3L5Cip1an4FQ3fGcBpKmg1rJ3ooel2GsXy6EtHni47aInPi+fsAyQx1Ni32jeJHy6sb5ym2Wf1gKVuTfccn9JudLTGjLwCoy2IH103ZpZq3SSO8mCrj7EG+BXm0GjvSWzX09d6XiJHBx9wI/jvucqfRU9LB7KA4HcgZuJ07daYmdMruuuMrhHBPd9FltqlxsBG/70OhtipShb/TNZangyvVazSLcFPvOw3tFrRATHZ2e1BJGKhqghS0Mmwyk5AWx1tKY3ffINkiz7zRdOZUAmaLHh9GThHLlxoVV9qcBVHwjwmg0UXwdOil8qubQIjQa1RE2aQr2lcVl99blN
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700016)(82310400026)(35042699022)(376014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QPYVI0CI/cC76lZFjZMcSe7DSMdrwOMrMSCFF47JSL/4IWkFOm4Lr0LHVvFFpdsqNrs3FPgQy75hj3SNYc+IBIFADaXFAi6Zn/VY+qzE/17k/NRTsG2kFalEBjEv8uyLZmopCnHcthTsAoA7sx3ri9ueUQtRQb5j925QE4jzreOvk97SsRrrAlJJI4SZyWWRnEXTyr+Tl57tQis1RyiOXFFsrnMIl/V7tBfrCOPdukOVLLK/B3Dfy5UUVIyzrujvYGTQ3gDBSXT0+BjH77nkl7wzDxsCyJuGC0q3ijqCblLtfjKCZ5XT0nRV97h3zHC1+Z5EszoNkV6E8179kCYa3UmAwSUoMMnj7x8GlCnno1i67m+fGdEOI1KCYRlewUcwU8r63ks0Q5QrEkWA2+4DT5aUoFbAxMJ73piBBZoOHeNTrAk+NXHHz3PuFNYIpVPp
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:59:50.7031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f061f0d-76b4-41f0-1abf-08deaf871907
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10409

On 11-05-2026 18:06, Jonathan Cameron wrote:
> On Sat, 9 May 2026 15:36:19 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 5/9/26 10:19 AM, Md Shofiqul Islam wrote:
>>> The driver was enabling the internal test signal (INT_TEST), double
>>> amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
>>> CONFIG2 during initialization. These bits activate an internal square
>>> wave generator intended for device testing and calibration, not normal
>>> ECG operation.
>>>
>>> CONFIG2 defaults to having only the RESERVED bit set after reset, which
>>> is the correct value for normal operation. Remove the write entirely
>>> since it would just be writing the reset default value.
>>>
>>> Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
>>> ---
>>>   drivers/iio/adc/ti-ads1298.c | 9 ---------
>>>   1 file changed, 9 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.=
c
>>> index 186bda3087..8957e873e1 100644
>>> --- a/drivers/iio/adc/ti-ads1298.c
>>> +++ b/drivers/iio/adc/ti-ads1298.c
>>> @@ -615,15 +615,6 @@ static int ads1298_init(struct iio_dev *indio_dev)
>>>   	if (!indio_dev->name)
>>>   		return -ENOMEM;
>>>  =20
>>> -	/* Enable internal test signal, double amplitude, double frequency */
>> This is why comments should say why and not what. If the original author
>> had a plan for this, we don't know what it was.
>>
> Mike, any recollection?
>
> Anyhow I'm going to apply it anyway given Mike suggested it and fairly
> sure it was Mikes' code ;)

I think the idea was to have "some" test signal when setting the mux=20
into "test" mode.

But indeed, never actually used and as it raises questions, it's better=20
to leave it out. Hence my suggestion.


>
> Applied.
>> I look at the datasheet and the driver. Seems OK since the test signals
>> aren't used anywhere in the driver right now.
>>
>>> -	ret =3D regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
>>> -			   ADS1298_MASK_CONFIG2_RESERVED |
>>> -			   ADS1298_MASK_CONFIG2_INT_TEST |
>>> -			   ADS1298_MASK_CONFIG2_TEST_AMP |
>>> -			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>   	val =3D ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
>>>   	if (!priv->reg_vref) {
>>>   		/* Enable internal reference */


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



