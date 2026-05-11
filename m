Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021118.outbound.protection.outlook.com [52.101.70.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB52236E3;
	Mon, 11 May 2026 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476822; cv=fail; b=bnXgORMi9bQO9ngveESH8EZWcU+022OhuqdY3a0w1A1DW1RCMhILN4TAXKIZIWC6QkK+6pqSNWgUYl3D0/8JhCy0ATYIdbZTbu6XO11YUJMGXrUaRROZsRWHmNExRSqBRAtQN3ejd9OrVoIcWIZUWGBMzs8nikiPM8Xq2Z/PSEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476822; c=relaxed/simple;
	bh=uITvJnIbkF0B5roR6UNk/dznUwbgDxHzGUWbvULD+IM=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EzVH1r6pXGQRKelcegUUNy8uwsk+mnQb9/gXiiztJ8xu2O+MBDa12Z6zbmd3a1FdyB0/nl6YsX8niSTAGMq5GWiUH04lQC13POuGJVEt9P4qLDiE3RtKJDx3b4DMp2kA5+TVs7fjsfb63OG6sfj+ejIUeuna7p26tl2+cYPO/2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=vBfpwqwh; arc=fail smtp.client-ip=52.101.70.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="vBfpwqwh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bK+Aa5Dd6GuvVIuEb6HstpO0dSY1lwG23nYnhedCzxsQ2S+S5fUpk75KktKcIQiNUkwdsYlPshfJGA7+ib2S5KOFk6d+RDKpGFeAgGT3pLkhJJ9kqKotPdBI8wix0G6XIg0JNyEZ+6SaaduggB1Aqciie6yynb64CX2/rIXTK1QxfBdzhzYZRXORFN+zu+GvXJ7PQdoNC+Rx/gE1Iq0oLUU2aUTKa+WUwO2k0FYZCurCHAPV/e+izasd9a+0CDM9SxER+37lTWOvywtUBi2eIO0FP/dqloiGaxtIklOM8gd4HTaC4bgBXlpf+0pqeeOSbUsjdpEyI19En1HWYIsFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIAekw7Jtd51Mt0rtKCTThA1gr2f2s2n2DeAzbpEtfI=;
 b=KGGOe3poHBu0TKC2OP3+WJ2kTza2lJhy+e929LMhwUfF5metstnCMcIV8L/qSLm2rZkCD5Kl2enzoDvFdK7YXT3dA0wn2vbT/dKaCEaCCF575Oii7p8uPaEIPfc4mEx3+FxlWzdOhaasCy1YES7Jcr2HyMKpF4b7DcCj1eyb/JIYZc/YE3bhCgnhFHZ36nk5UnZHMt0LBwnn/gGV8IwHGucMSG5/QvR1dAtjYMMPvxv5/DPpfvm/GFMF4iyBZFZJtzscetK+5Ivu0NPiXYrVD9Kpb1RC8Vrav/b7jbFTXJjRNVKI6XzIt1CfnkCtNVwz4dTy+sSO/qrGDi0qGqOyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=intel.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIAekw7Jtd51Mt0rtKCTThA1gr2f2s2n2DeAzbpEtfI=;
 b=vBfpwqwhFnBRe2QOxeX4zzaxquJV+gOE7KB5nqrlBFmKGhhnvVAcugHxG7bxHU5KPsKH6iSHXj+6hP1NzXzvmIegKy6Dvr/FbjzYHKvC/Zd+2h2YY0LtUjU24LrO/jybM78H1yA53u9/rsuJS5g3z/YKQS9HnNhMYy2POM9muscVdD9k2Q7SSTZS+FPbcnFf769Naba0LX8ftpYqDPk8UWXf2UTMNHYHAorR+4BeIsf2pkKKoy6zinZnG3/Be7sPDGjevn6uJd1thCfZbvbE03Nb0COcWT3y93FI/NAnykIc3gWzxLWoiOe36/+m2FSZPGdf2zmC1VTYHqsujjg9pQ==
Received: from DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) by GVXPR04MB10850.eurprd04.prod.outlook.com
 (2603:10a6:150:216::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 05:20:09 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::e7) by DUZPR01CA0171.outlook.office365.com
 (2603:10a6:10:4b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 05:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Mon, 11 May 2026 05:20:09 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.67) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 11 May 2026 05:20:08 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by PAXPR04MB8318.eurprd04.prod.outlook.com
 (2603:10a6:102:1c0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 05:20:06 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%5]) with mapi id 15.20.9818.031; Mon, 11 May 2026
 05:20:05 +0000
Message-ID: <4bb77b6b-8bc0-4970-acf4-6a6ebf9ceab4@topic.nl>
Date: Mon, 11 May 2026 07:20:04 +0200
User-Agent: Mozilla Thunderbird
From: <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 2/3] iio: adc: ti-ads1298: Fix incorrect timeout
 comment
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>
CC: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
References: <20260509151959.3475-1-shofiqtest@gmail.com>
 <20260509151959.3475-3-shofiqtest@gmail.com>
 <f6189816-a157-466d-80bc-3f338c13d69b@baylibre.com>
 <agAs4IqohFKFhbhk@ashevche-desk.local>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <agAs4IqohFKFhbhk@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::8) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR04MB12030:EE_|PAXPR04MB8318:EE_|DU2PEPF00028D03:EE_|GVXPR04MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa959f8-c160-4bd0-c825-08deaf1cf88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 VB0fpUIHY456PAE/F/cgaieUsyYZSeIVjrCT7WdQxM2VMR+x32/+05LUMhrAjaooReqFOM7x4x1pf/ZenAVDyGW93mee3SCogFSWsRuwGnQ/AI4ujpX/J85To2KOwja71vEPEVg0LKW0cpfQhIWupDCGQaCJBXWq6NPl/SQya28GDaqrqKReSZwCHwnD9WewLrgAO/fnAvZ2QtoY3fpDxmDAK0aUNcrApfxPbblfJ9NEb6tzLGgPDLG6eHjh0ZllAas/WT1eRALHVFkkLiC9hKcUSTqI0l44gyuWaa67TWtze4WX+hKhCnywaXf2YCANE5bj42IEIJydqUz9x7O77Xe/lwlzpZl5G29uzNHHuI7CIaV8pbBer5kEWuITjtkOMQUypd1y2YZs5qLWCBLda6bzVtiGEgsoPpy6Mfz8F01VfnbcWv11oStAsko5jWGDffVG8KSIuwLQAzr/LZP3SRgDDWlDqx+dflxfnIq/hG/LD478tQZp6q2z8iCTIuMlaFB4lKqCQHjnQ3AkLFgVyCANRm3g068rWWLA6UM6VXK4yqku9YhhqhSbrJv3BSqsmVUYs/gZ4rAm6W13SKqQ9pPce6t6QBWFJtQlm4rjwUQG34IS8ifbLg+wuLPBBe/27u19Jbiyb8FTebr6FqU9BVoKpJUKGOKJh5dSvjdHh4F1KDejk7PLf2eTUZ4bomx8K9tq2S5Ylz9nuLAW4NXT8A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: ekCRBT8HIErmQ3WagfTXwivalP/GMuasFG8OHjiomH/6MtIi8BoCmivrD5W+SeDv5/rM4dVH/e4YqVU6WWQc6UjXftW6Yq6Iqa+tH1dz6cyhn4qpyC+yS2Acdh18Iwc3TpeU9XLdM8NnOjtTKLhf09Orb6QqoEB82bCXpBCHTA2vdx1IiUHGelCD8b3WwReQkYLY5YzLW4HHI2rayyyBiwNaBPgj0aVh2Af0mO25cCE1J0DW2GfNe77kVKaR3kB7slngbawhnpF6xBdky3OFzvi7aZ4TT5Lc9YMeFPpLMv2j/eWB4Op660RVWwVXpNVuMGBKlz8nArf5jd5vVfofYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318
X-CodeTwo-MessageID: 9a7bb83a-daa3-444e-a1df-dbb6794f4c9c.20260511052008@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4674a24e-1740-4102-6495-08deaf1cf619
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|14060799003|35042699022|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WPW+lG7/Gy2SDtA8GZCs9K7wQfNu4gb/248v7agjaLp0iyqiJh0tQSs2QGgKkI8A8DSMaISZaYcWNu9SxSh2pxXWKUsuCNKw4g0T8zMQyQob+MblZRXyQesbF/Zi1ZJG8qdSygmRK6dVS5vW/Ce2sY4GK9gw6ZgVoN62/uuJmN3bpJPnV8l6k8uNhMCz5Ddgjw+JsDKTzybULCTfeWeTP9NxCEEGR6roq4YjG8wULwGAECQm/j3DQHtchb65rjnezGeCaI5uGzJMY6huWDpMAvDsqXuu8cN321ARYTy9PeUXmKODALveHBjPqaHLMfvQtCyndu5XP2n2t9lRM+sPM3RxbnMJAbDDKcSK+WamqhhwRIm1UAmOk4snS5vpycMWUeb92CAXLRcigxTpGswW2YPST/wENxzRLlmAxXUORrUFHE1Vt+lv/XnMGEZjKFSiaZRAAFJVTL1Grh3hDKRc2AmZLiXRpTCHLBSffL5TVHgHXzqlvbxNgpYwQNhO6AQ71bceMUQtt+mtP8WG2dc14yonb3/tIGHEb2ac8rQSPvhZRlUAl9paV1ABCpilFVVs/KaKdMStsNM+XGbTuquk3Yo71HBKqh6phO/TOQLRqjtuE5R0cU0Q0P4JQsz+lMnDi3va5fAT8EgWaJ29RRgyjNHgAtR05H7IhGK6OTGhO7pMyaGDOc9AsKjj6m7Z7n7b
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(14060799003)(35042699022)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IEyvPo9bx1p6h2tf7Y5xdhCXiogXr+CPs3V2ab+pY7Kw36Cr5y18zoqGcdKtNHL3Uq/aR4tTOpgxzAjKVVazxV/yWuO5TILdZHbEgAfKplOAP6r4/Bi2h/Q/nVWE2JpZlZdUny/1ANLa4CnaJVeCf1C042och8Cn945Bmu7qUkvuQUWMEZEtvXf5QrDmJPwU0UJ7fTgAIFjnW/OaF7FlH1C6UlmaDyiuDu2hLzUmn8WGRo3wablRd2XeRqrxFgvA5Hjb40/3nuL28SG7/QTB2sXx3DZlSEZ/bFMfuDGtgucB+ECWfV0d+jqU5Q5PS5mCqNZ/QmHHX38jwvfyfA6tq8SAp+/Hg4oIZMlB+M04E0Qli9UNqh0SzBLXUjkc52/6KWf1o8OJVzeB5xqD69iAfvcDydGmHQT/u6C1JqHy8mm72+SYAkqhpKVS7ub+Up6M
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 05:20:09.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa959f8-c160-4bd0-c825-08deaf1cf88e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10850

On 10-05-2026 08:59, Andy Shevchenko wrote:
> On Sat, May 09, 2026 at 03:27:35PM -0500, David Lechner wrote:
>> On 5/9/26 10:19 AM, Md Shofiqul Islam wrote:
>>> At the lowest supported data rate of 250Hz, one conversion period is
>>> 4ms, not 40ms. Fix the comment to correctly reflect the timing.
>>> The 50ms timeout value itself is correct as a conservative margin.
> ...
>
>>> -	/* Cannot take longer than 40ms (250Hz) */
>>> +	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
>>>   	ret =3D wait_for_completion_timeout(&priv->completion, msecs_to_jiff=
ies(50));
>> I would say "lowest sample rate" so we know which rate it is talking abo=
ut.
>>
>> However, there could be latency in the kernel delaying the interrupt fro=
m
>> firing. The kernel latency can be much larger (I've seen 100s of ms on o=
ld
>> single core ARM CPUs). So I think we should mention that in the comment =
as
>> well so that no one is tempted to set it to msecs_to_jiffies(5) (or 4). =
Even
>> if that works most of the time on a fast machine, we may need the longer
>> timeout on slower machines.
> Actually it's not about fast/slow machine, it's about scheduler and load.
> Even on the fast machine under heavy load the completion (if it's thread
> based) may take quite a significant time to be delivered. For the hard IR=
Q
> based completions it might be much better case, but nowadays it's more of
> a niche.

This particular driver uses hard IRQ for delivering the data. At the=20
common sampling rate of 500 Hz, it generates interrupts at 1 kHz (each=20
cycle needs one for the chip's data ready signal and one for the SPI=20
controller).

Although this particular case is the "single read", so there's indeed=20
more scheduling involved.

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



