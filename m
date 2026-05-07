Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023117.outbound.protection.outlook.com [52.101.72.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B751B78F3;
	Thu,  7 May 2026 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131511; cv=fail; b=R6PRXcpsvCb1Qwrlbl2eSmQrSKdIiZexcH5VxTQf1sHnQmO/+6F8SEJusFDZabtz7fRPObKs8L1NefbCOXDXlKZvHsP5vor7VXtwoD7Gtm2BCr4MdLE/RRtbxXeRNWmaIOK1oFzTdLGpG1DFY6ZnSVwW0CnOZ5Ki3rW5pB+KzgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131511; c=relaxed/simple;
	bh=Rjwa0Qgh11UJefdvfvI+1S9wRVpfyIzfNzAWfj8Wk5I=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UFtCgjj4tPTiA0orDjtBski95dJsDeceRZb7hWYxpiDlWkqZIiJDra24OUqx6HmQnb09VhOX1eWAaHpNszUjZIQESvlTGJ65wkd0jgQ0YCjRSXH7u5IOCM4xoH0IEZC/x5WPXtlnaOxCE3hTNVDBjNEGBO74DBqa/eRQUN66EUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=ASZ9GaB6; arc=fail smtp.client-ip=52.101.72.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="ASZ9GaB6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIIp4Yk/569DZTUvtvi0oA2rA+t58ASnQExhtg/hM/pOXESRq3dtFhZNO5BVXjAV776w88eSjVMgDMYFPIi5oLtSu3FD+ewt8hQzqNfhZTlAmoiq3IAKSK8oQ4Pk21fGGjVsX9W42aQrK+rHrZGfEBN5NoQ/WL5QfmoIsc6m1bwS+r67OM/kUz16dm29bl3JH+hGcHN1AIQVmlW/41KLTwPf0juW8MLIakgmnEM/Xbc7IK7TSNbBbHpJy1Y0WvYVpnnfjaUWsaHbkhTBJ3I3efZkLHGtLztwaHHGpoApKxEcTlyk9k8zPxcrvBoWAzrVqVMJuLqujJO3TGFBgva2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVZeM1rqFa6WSac9SmktR4VdyjjDNozvshCW2U8TgmE=;
 b=b57uHwaS8vxyWAJy/lW613ZcIZVAhxT8Ia4rVARRNg5b/pIvK5ueYNVUxnphoQam1e8m3shT5PCjHsop4ar68rJdFZ877ZwqXFKhoneO7wTh8hEi+rYhe/D5HBWdklBvRNSUR2d3PBhd55515hmx52wvYBUmec9Oop3Qf+b0O0Se2V0t7q1gJbN2kv23JcGvlqahxAg3foDKaGTHYTUlzue97LmMCcg0yMMvKl1LnDgXEb+tJjYgjtRj7GACcqj4icZGmdnrXHvjHpOOE569JIsBt50VE+J+uTOT7shJCMaBIBQStakUNYIxHGvOBAsd9LkIdUZiFunEpApvHgD4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=gmail.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVZeM1rqFa6WSac9SmktR4VdyjjDNozvshCW2U8TgmE=;
 b=ASZ9GaB67bKQ+N3olk7QWGkhLl0HwfU/KH3/899CcDJ6iQ9YpbVlFskg5Np9YuwBRQbZHxuzNu+VuY5z2BrR1MqWmvnplmYK35LhGXtPRkXpcifPlmdF00arbe9/SHmGuA08pVmLmMN26yY9CzI43GQBP16OnGbsXlQUGK3fYA+dBnJSjyefLgEsPMw3vmN3eST1U9nMQrSbVIvHkw/9//v4eDR+Zy/qYlWGoZ3uvPHCjf/JjSDLHA27P9dap++OkiQkVLR8HzJ8UKnRwMJuZDRAcNKSK3UlZwyD+4qNvm95GxN1hiOpN2tevoMIODt28fUP1tbHex4GjXBI5Fe7Jg==
Received: from DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) by DBBPR04MB7819.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 05:25:05 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::2f) by DU7PR01CA0036.outlook.office365.com
 (2603:10a6:10:50e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 05:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 05:25:04 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.68) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 07 May 2026 05:25:04 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by DU4PR04MB10984.eurprd04.prod.outlook.com
 (2603:10a6:10:586::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 05:25:02 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%5]) with mapi id 15.20.9818.031; Thu, 7 May 2026
 05:25:02 +0000
Message-ID: <ad8e2ad0-8d20-4b96-a7e1-a23a4bb9cc72@topic.nl>
Date: Thu, 7 May 2026 07:25:01 +0200
User-Agent: Mozilla Thunderbird
From: <mike.looijmans@topic.nl>
Subject: Re: [PATCH 3/3] iio: adc: ti-ads1298: Don't enable internal test
 signal during init
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
References: <20260506181508.6813-1-shofiqtest@gmail.com>
 <20260506181508.6813-4-shofiqtest@gmail.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20260506181508.6813-4-shofiqtest@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM5PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:206:1::23) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR04MB12030:EE_|DU4PR04MB10984:EE_|DB5PEPF00014B8A:EE_|DBBPR04MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 909e6fda-de17-4d91-1b02-08deabf8fef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 H5kYZlXKVC3HIVRZvBylqmTb6nYWq4MEWxEFq37q4+APDv/8vAqu4dkke42CPE5S6KQCXvG0n+YpEL6wMD3D/809wmZqrsvDWuowSlozeIh062dopf/gqoDn2urKh4WTLMq3xAG3F0uyNUQXX8kKXhUqG9CYltjiayoLOYmvmHBpO1fUBap0ruS+j9fgqc3WUpIj2OsaDJ5vehzT9RI+l9Qhz6fCWTaQHIeKTUZ1YNuQr18JN+RLsq/+QH+7OFKEQjMmePKVraZNSMLXBdROvLUW2dgCUixAMBUYsG4o2ZYZsBzmjiwhsSsVikaPNMQGHZekGyrArnzcqFa+CLixOY1aEfNDbHv8C27swvi3AaR0It4Z9zesY/l+0wf7fUH23ww2OSDoS2wRAK2nvxYWRb/nfEAC9LQ+JWq2deECn8Hb2i3/h8GJFki0GyMJ1FkyUl9WIj1gUX5cyEuVp6Dm+8VPUn1tPMIS00U9TFmXodd/EnbqGMYzaj3WJIRNLI+AZXz1DiHV9nAZp66lxqBi7iM6ADEAktzoZN6IhZsWeagk3YjTfeRXReJL7OtcpMIY3L+tJeMV6QXZOcLEJVRBar8jlIqmmiNDnjSUW9sa0dOaAxEYoLNgi0XdWoCyOvnqINl6tTqPyshqH2aw4SA8/A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: Y+5Z2m9NU2KieV3pEsolV1s79Br9vjd4KSIUpUmNlUkugR8xaVXjYs9qzgj+0J97jxGuzh+Vmbk3jhUn9gwSFLomUUrlW0EvNklnE7HBzGnW/k76C3nBNBHefkeIsM5Y9Fj/IvjpWq6D/CpIGIQhIcAbyR6sDamBb49AVWqIrQq5F7hDXv9Ofhmk4UwQn+CK1k8GDSg4mnKWQ2zrm0LMYRihi8ojsHpN0J+nrINHs6NYGuZG3Ule24veMz3lA/k0SxyHXO6fcDmjZiglTmlU8QTkuhxYtcWGbnpVsoUzwWmAbbnAKNidR7WluFCMJ/XM/n6XXAp7m3cCLHa8NVAf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10984
X-CodeTwo-MessageID: 0264f456-891e-453c-987e-651645f4cf38.20260507052504@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cae692e6-5788-44cd-7414-08deabf8fd2e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|14060799003|376014|35042699022|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4qmAdIy/zmfWNwECc0gn5kEF6sA7I69syALZzSAp/vMQmgN5dkNJFeiQG22J8wqdCIkZOM61+AGoKZmcrC2lNmRzO+05wMOmcV3B0MNi2vd9nBC/3jm/M9j7HjOOgLBYQOHAoWhQ/zz8OABfsQfw6OR/nWStNj0PzrVEWKdwqC+GLiuJh5cE+nNZ5T37D77cTs8AuzcaB+UxdCY1/9EYK4ZdMJAUEXiLlXLnj8Xlt+BSNqRspdecYdJfroUIKa9ThUR8nbc2coDv6/AWiD50dU31h+TSA3cnEbrtlZirl3Zyp23stAg2jNN3g93vo9t0xWYUDQlwl1qo5Un4xYHB801V/+g3PHr5IPkE7QgUt1XIyXv9XezLCRSw1/0zzmTdPobimkKEerlHdiILOO7FeKwLJyS36Qd9/z3HM0YrHM2/Np3/3h7mrBgeEkpuwS5H2IZSjIqMJOX0Zbn3tySBqPEM442n3Y7M+8kxjFoWy7wQhgN1oJwILLDkjRo3HCWqyVPAO0A4TK1NgbCD0xOVsuN1SnyfsNtzyrCNTnDF2Kq7dUYo5ERu2loudpVljVzW2j4EDE/cq7B/xOUdCEsfZ9H/Pq9WcPR+PqjKxE581EmA/ZM5ISGp4cCQuTqG9gwgvIv9KZLM2n4Y8UEwgiLxfonhTGS4yrF0Qt1qKZYdU/CGdFegl655N/zdKjsCnTGd
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(14060799003)(376014)(35042699022)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qFeqoyyf5uu1PRU0QhTIC0LVenO2Yzpg9C0d8mv6oXms48ITw0auzMlEhDWGm99Xj4LL3gZpaFeIzRv6UzncpMOAmIEbRWR6cTjyhWT+gb0uVKnIQvO3dpVjp2RJVS/eNj5sB//H4BA4Au3HhYP3Cs43EFy/UUpNJxdvfp1T7jjMVBunaaE4J+svUHUmdASpU+OwLgP/OvfXjNAzso5Wc3kcc6CCsRA5qOUI9K8vLN6CNaODJ+Im6pWquQv9LuWupbwKnJdBt6CdTsreK6d0KH+6VcoR0Ng5XxdVndDTTj0gG04/2t53wG7fTatSqoBa14bKEhTu6nMKj+lCveJwJikTUSzD077Lz43ZGW/TSis3fgdpzcLVwyhbovJuB9Zs3ZgBo0cwWgBQ1wg5IwXvh2PcyEik4bPrsrukEh1sXrHaaVBNxlyVnj0WFAMZ/946
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 05:25:04.9769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909e6fda-de17-4d91-1b02-08deabf8fef8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819

On 5/6/26 20:15, Md Shofiqul Islam wrote:
> The driver was enabling the internal test signal (INT_TEST), double
> amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
> CONFIG2 during initialization. These bits activate an internal square
> wave generator intended for device testing and calibration, not normal
> ECG operation.
>
> While the test signal does not affect channel measurements unless the
> channel MUX is explicitly set to route it (MUX =3D 101), enabling the
> test signal generator unnecessarily increases power consumption and is
> inappropriate for a medical ADC driver in normal operation.
>
> Keep only the RESERVED bit which the datasheet requires to always be
> written as 1.

This boils down to just leaving the register at its default value. In that=
=20
case, I'd suggest removing this completely.

>
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>   drivers/iio/adc/ti-ads1298.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 186bda3087..360dfd2fc8 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -615,12 +615,9 @@ static int ads1298_init(struct iio_dev *indio_dev)
>   	if (!indio_dev->name)
>   		return -ENOMEM;
>  =20
> -	/* Enable internal test signal, double amplitude, double frequency */
> +	/* CONFIG2: reserved bit must always be written as 1 per datasheet */
>   	ret =3D regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
> -			   ADS1298_MASK_CONFIG2_RESERVED |
> -			   ADS1298_MASK_CONFIG2_INT_TEST |
> -			   ADS1298_MASK_CONFIG2_TEST_AMP |
> -			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
> +			   ADS1298_MASK_CONFIG2_RESERVED);
>   	if (ret)
>   		return ret;
>  =20


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



