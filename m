Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021083.outbound.protection.outlook.com [52.101.70.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3230BF69;
	Thu,  7 May 2026 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131210; cv=fail; b=HHIn6B/41Ci/vaqriBXfCo7lmhE5TsIGXwkLBE5AGBYemH6OAECVHfyAOkylp843tXkpoNHADu68tujHF9JDOavmCUIggDGN9QqcrR0+omg5W8S+6Bk1iJQaKpHGwbuKWBBsGs4Uj3SeaCf0I/iNrtgOf2IwL0JLO0oAPgU+828=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131210; c=relaxed/simple;
	bh=8e5/YhjLExzkCJDpSRELXJqicAfVHg0tmebbXVABsuo=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C5GxGe8HEI/s0e8JYS1st4UCtw29ZSLa+XqlBSYSxBol4Y1d4GA8tlISwqbSPcU7s7J2z56PFfw0Cw7QBOAdRKMWtcj4lCxyPt6SEFDoYzkZfkkRzUCH4PSFWT2Vftl+dQU5y8DE6LlXQxBQRIqLURIOfc2eAikjmmYoHFd21OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=z180kUnw; arc=fail smtp.client-ip=52.101.70.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="z180kUnw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op7a2IoXOIxu1gUxgFcTGez/gAPi4G/UB5mc4xldIkyxgC58fGSct+rNYJzH0goTBXmD4yiai1Ykq/nydszzPQr/eHv0oG3wH4mdmBPS6qgB0rDrHzQdQ8f+N8996IkYBvGkDgM56bS8X78XbmYRN4EFDddAiDqgadfFXjtRvK/PbUanZVgZwdKZj7zHKHOaIQ0kyo3Uw/eSYNAZCnk0lkgSQgEvwvDAdsf6aTn6YiEGxVBNgQlbuz0P+8TW0gwrj9e9ao9gj+No4xUOJ+X1zfTj9upRhjrdFeJCYFXSrf0M5OfYV9AIaX83dOo4VZmR8Wun9C8dXCyxJbb4utc9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMK6J2Y0q1zBlZLT63BM3u7Iazik9hSdOgEZAuO1+c=;
 b=VSqySKa9nZMBUDzMgpGGTMTVWmSVdRLM4qhIm6JcoWiAQ7FY7q84+4OuyKO3afbWthAZH3Kta8h8i3hQ2+NKXQmbGKqxIZJGPOmYV4p6WVyQycgwBcXRfcWQ7Osws+6O26RpsFxOf4tA2cHO6dCTHDaPg+wGIyslnYK693oOgPojgOKIlnxRQrSY+m+ne0XkeSjSfXU6uisQtmPnGSPhQS5zjzNJ8Pcf78ojqtg/zvj3sdNnm/tbEG4XIT8PW86dLjmHCwRdCNdnVC8b3xARCwOlz5ixcrnx24n2SScy4WVrfmeGB8GBHqx19l53qXIPbpG+tV8alf0CauPMAtEelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=gmail.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMK6J2Y0q1zBlZLT63BM3u7Iazik9hSdOgEZAuO1+c=;
 b=z180kUnwMEwJepr1rXACtt/tnKqQA4H7bXDFp4wtPrrpoXyXRs/013esQL4HSUDgyVw6mtZK8PzPv4ccP/mpw6NnuL6ERbIhZZ2hlx8aaZDI4Osx4SmK6HUVIYCtLLXZo0yTtPjyMbYp+7q7Ql5cXh4e16pfCsQvykpWL+sGURFGl8266o0BSkQiZfs4odKNCVVqT/ncJsjHcrPFltePV/Q8xRFvvoN66LAjzvysgLAJYO6AHCHXWttAWlo0kUdcb3P5wAFyo3NNZpPziKe9wSopgpID+ehig72i316BUpcft97zj1H61Snskai2YBbfkLOLaMnvJX1D+7r8YXFbhg==
Received: from DU7PR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::29) by VI1PR04MB9785.eurprd04.prod.outlook.com
 (2603:10a6:800:1dc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 05:20:02 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::32) by DU7PR01CA0046.outlook.office365.com
 (2603:10a6:10:50e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 05:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 7 May 2026 05:20:01 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.67) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 07 May 2026 05:20:01 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by AM9PR04MB8164.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 05:19:59 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%5]) with mapi id 15.20.9818.031; Thu, 7 May 2026
 05:19:59 +0000
Message-ID: <66c5335c-b4cb-448f-8ad5-9f80edb63273@topic.nl>
Date: Thu, 7 May 2026 07:19:58 +0200
User-Agent: Mozilla Thunderbird
From: <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/3] iio: adc: ti-ads1298: Fix incorrect timeout comment
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
References: <20260506181508.6813-1-shofiqtest@gmail.com>
 <20260506181508.6813-3-shofiqtest@gmail.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20260506181508.6813-3-shofiqtest@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0P309CA0021.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::30) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR04MB12030:EE_|AM9PR04MB8164:EE_|DU2PEPF00028CFE:EE_|VI1PR04MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: ad476864-8b98-4f0d-cee7-08deabf84a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 jXR/LQRa11t4K0HyrYxR+Q6PQqbnCtf14ROKixbdPM0XlriR+E1GAlZ8eas/AyvqEerUSzdJ4WFW5jGAghv4zr9RD2ZhKi9Db0YMNMxM/mS1PLdBj5lzsdzHr7n7+l09kjJTkNtoXD7IficuNebx3GDY3XQRaQc3oZPr/x09mtpSItKqOSLAAnh4LBzY+gi8CcH2l0EG6pX51lW6XzbXU1EImPSp0rnckP6pK/aqFLshlKeedv9zLW1m1GPEmZpMFTvPu3clzY0QG+BYzKfLZgCts2zQ2Jbonz+bbqgtVgVUPRwS7VleRJpzFebtWxVhBdiXtKTS6yyKv/RtlFE6yMKdUV/lGYQb6CRUGiAJNhSRx2EF5K+dM2691l03QNDvOyD4CGTgsU3ETXM9Bu1tvZgZ1k9FAD35ZymdZLpA+EzQwsDDn4YbVG9eWVpQEILKm5M805Spln2eUgQSAH+6FUolrW+ONA2LYuRNwLYDAHxnQ3P/wqNZpIF+jLScS6NWNl0xOPdAArA9OhQikxd3oJrJSStCbyqfts3s0uM5KOmyqRZVlQOtaaGTjzRkUdTQaTExB2qZSTR7OUaEnlhOr+rbRYZgLvnphxi8WDRu+irbo0r4a52Xq/sqxATYI6GJpLVGM9y4r7KBW2wE+5B0/Q==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: DVTzkUiJ6rihh228bhaX0JOEan8gVFp3IpMtaFkrcScyiikSyAsZwbpkQLGmCI4j8O40sDB052C32/Cx+/pcQyZ1flD8Z3E6FUtTZzmihGKDRPybnnUZvQERnGZOSSrHjrFLtCwsG+30ELkHQYn1qQBq2xJ0qM0fm7ZihkjWosG50VLoFl5TvmkiBePzOTCdCD07y8fz0VTcphq9ZrdeppkP0BYm4KzgXbSiZEX5CCoS/EQ/aTNhH1qk/nug9h1Kqia0u01LClTe2wczbJkMkCfahfeqYdHDbu92Tbw8Xz24tQGo6fS77VYcgKpu5jLMSa9l0XI9EBehQyeZgDvhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8164
X-CodeTwo-MessageID: 38c8dd64-cce7-42f8-84ca-d6509faf84b1.20260507052001@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d4c92e30-d3df-4387-e52c-08deabf848be
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|36860700016|82310400026|1800799024|35042699022|22082099003|56012099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	nHXW61oNQS0O0UsMXru6OI0ONgDgQrUACsMPkGoG8jfPPYNzdDz2FKSLz2nD5zS5y7sW6oD83aqrPe2hZ1/hWrZbBYXl0KABfItOm/EOWDhzHrfKC0Xyh1fRWMqnaaOVgb0LrsDiIDMPJcnHwTHkDWP4ObYApFomBzME7gQQbJY3uAM7TFoiSJJVhTy+K+2ZiTQFVBvMDkTSpNnfmPzfXOLvPj2sVIaAR8BQO41mwfHSffMPg1Z38FGXC/Fq+STgxRkx5jbdUKQgEyPa+BdibjGvlANX6T5i8awQZK26zmLY5LVDE6LjyEw1whdFsAxA4I/v47guhD403XmDmQ7IxzArAd1dSkpwrI5LF6zXmxbEGO5dN0k/ZBqudCb18WoVK1fShkCzfSkrJDW22X+7iEJkpw/QMqQ1V6NYGxGeOYSAy1Vzg431AmuYvUNBP2vwgL6m/J9UuC51m0I4q8Y4XNbhuysU5hmwkrY6roWAeIKjtzoMjdoYSelJGzSj76z2pX7I7ReihYWcA+G7lAkCWtgWy25ycE73pcySR6umWDW1Lytncz3MGZEHkDVbv5ZlfG4ESIFTgEms3OSvL2n1YtSg8Gbsw5RSlrIaYCSUaF0ZNgC1KUsoGhNd9sgEez9LIs5eWVr2dUZJ7m/k7p5tLt2OylibG1MwI92jmLr+mOg3xfqyel3u4QL8yYQbnKDO
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(14060799003)(36860700016)(82310400026)(1800799024)(35042699022)(22082099003)(56012099003)(13003099007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JdG1q62EXjNE4CAwnWPxxefmTj0WPJDRQIUtwthF2dUjkeS9wVHZ5WQL+lhI1sqCkmOiUeiZNVCSjZz7Kc3x8YKTnwv7CVoDoXePmYRHvS359cQa2uj6gAf60xKKDcTFzS6nRmkvQZ1a0wHrPMWjb5h0jrvZdXUSyt1+iyQJkzTr7wKlEBkAiWsXHw4PJ7pvXXyrgvj3pKj72Y5+8/BbhWC7p+j342rnzhcUTsd3GWcgDT6+E9BbmkT64lPAI/+xAOEn+PNHbAQbCjI4IKnizxSIYUHSZxOABDfCcip4be3On6vIfq6V72b+IqSKAhI4eNTxL8N5Pnznua2FKHbnIZKAPPFXbopNKIEZ5yeZae7hmL8ZsA5bIKsLTVQYoNRFkFPCI/XZ+rfBQwK04mjeZcjPbE807t7F9a7spvLJJQnAKoz6nscF+inPqV9ubLJr
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 05:20:01.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad476864-8b98-4f0d-cee7-08deabf84a51
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9785

On 5/6/26 20:15, Md Shofiqul Islam wrote:
> At the lowest supported data rate of 250Hz, one conversion period is
> 4ms, not 40ms. Fix the comment to correctly reflect the timing.
> The 50ms timeout value itself is correct as a conservative margin.

The 50ms value is also wrong then, change it to 5. That's already more than=
=20
enough margin.


>
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>   drivers/iio/adc/ti-ads1298.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index cf5f954206..186bda3087 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -210,7 +210,7 @@ static int ads1298_read_one(struct ads1298_private *p=
riv, int chan_index)
>   		return ret;
>   	}
>  =20
> -	/* Cannot take longer than 40ms (250Hz) */
> +	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
>   	ret =3D wait_for_completion_timeout(&priv->completion, msecs_to_jiffie=
s(50));
>   	if (!ret)
>   		return -ETIMEDOUT;


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



