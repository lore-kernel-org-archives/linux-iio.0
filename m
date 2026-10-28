Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793211183;
	b=0vmNGxzDvjP30K3lTm6MWixUb6C+2uN6uFpGVoX1sxcr4xCkZASskEvK0I9H+RkZoRVx
	 3wvJ/FlBiYTwZfnfWwV/uphlPX6s52Kl1vCRFKui8McEhLmmqFCOPcV3x1Wi69d3p0vQN
	 lBjHlqi3yvWqYXPr6RaOHbZqnULBPJh0b73nbZhjAgo0MRt9OjAcI2D/WPaYxwpIFgK29
	 VMhL21D0X0mstMzTpPfkwPAwoFlQ1RSD7cqgECkfNzNzYSM08Y0aDwcxMOIjArAaLLd22
	 JfxP+NoP8xtzqjUz+hsxpvPvgKejjocsNTj/KKLquaOU2PCImwvhcZt5kgFaEzqu74g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211183;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kJhqntduoIHNkU1QLC+pcaGdHQW6TVMEffZhvLoja1M=;
	b=Ex04OANuF0LT3AoJOK7iZa2RsyE8di6on28Znn0BrLsCuqZnfuCdRj072AOosYTmIIuK
	 SfoYeVRfnTaYHsMOnoouJ2VuXbD3sc/DtYfOn/tKehceqVixZgORwZX2DQHQtktaombXs
	 WGbUL9voyNbvKwDiyiHxV+jvDhF9YSxxhFcPSkxmwIqb8U+rFnDBE69cK9Ai3c1Cs1KhS
	 vxejIEXieZq05/Ri+fJcx3s6MNcBjgW9fEgATyv4HvJk6XNmbBOvYSH9j74IihNrQqInN
	 EbiXtZxQOBMpExKQDhzpG+LndQXeYxPu4c5qUUtgS0rq+/3c5QXg3DreLD6ib0lig0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QQeKPz8G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.54
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012054.outbound.protection.outlook.com [52.103.10.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683860A5BCC;
	Wed, 28 Oct 2026 18:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D683860A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=QQeKPz8G
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptVq6JDkKbc3VhB+FY3baZNmz5n+bJvXBLNqIrdrealKRKofHcP0YMWgOIzYrAGDvk5zkcH+H71xinbxfo1u0yn/LBX+tPIfvIynFmLrEk+MbLqaXT7RYIIhWOSs6o80XJZY6fbYwK4xKVMMfdx6TyZq4KX0V1suDc2KbHzuAPMHDZbQs8XQg9mHjmtbt6ry2dTb2III1hJw8MhRfCp0v7NNkmWkbXnppZXdFJ5wewcVUOf9TgchmK+BIbXZB7jegLovVzEyqfXb+7gPx/WSrFboNjhFyoCj40uLWdOmNgehLzU4y/AbgQfP+IYewOl9x3m8SE4LLnhM5VdGKpRh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJhqntduoIHNkU1QLC+pcaGdHQW6TVMEffZhvLoja1M=;
 b=w8LjABCgG2CLVQFWGUzXvulv+SzxEy+f1hX54xMqcd6r0JpRpSIjsPTl0K2x7qvhKYFAiJDZQuN16pOZZZFYSTXjHLNfX7qU5TYc3oSehXapIcC+QSLQskqClRcgGNot4apE6tC3GSe3Q/tFlNa9A53UnLuAQEdfAhv2N/p3g+5AFYtpRTHVil1MdFzBaC0IZO1uFUpeiPHVcugt4p4/WF9eVRFOJZf0IsX35T/JpXwjxq9iLyRJrhQqLxaGdObtNi34N3cKVhJBlnFGGTkdf2sd6yWlxhMmb8MR03YKXhaO/wiiBUe0OzApvbMC4JhC+gMCcNB4cLRDV/ZpQ2XFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJhqntduoIHNkU1QLC+pcaGdHQW6TVMEffZhvLoja1M=;
 b=QQeKPz8Grvxc+g6Q7fwJ1u+GN709dwQ5SuY/CDoV5o6tn1R7jujgcgTkSijudMEb3GRff2gpuiXjfQJAIiUsHVUM9d0r34wNkGzp6u4lXYibq7Bw/NGz9STvGF4paOSqJ1uLKB4wilmihO19AMHgWBt+VtdzP2fZJmxJLAovWHD7dVaQ088sY2tFV1HUg+KXBAoBh9v1ij7b5BApakoEcUNtDMyIGmgMcForzhcTaZVqvR/2wz+iljvB6oV1daZufYpapVmZD8GGEnI1q5eE0RnLXpWf7C2XuF0XfhJa64qdUXpxdeUTB6uzo2+AvrAmb0IQ8mvD+ilfHUx4hJU+OA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 18:12:58 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 18:12:57 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: neil.armstrong@linaro.org
Cc: Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: Re: [PATCH v4 3/3] iio: adc: add driver for the MAX34417 Four-Channel High Dynamic Range Power Accumulator
Date: Wed, 28 Oct 2026 13:12:40 -0500
Message-ID:
 <SN1PR12MB25286BDD49B0947AC40257D1A56F2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:8:23e::6) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261028181240.228334-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a1d7fb-bcf1-48c8-647e-08df351f177e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|12121999013|8060799015|260925184616899003|4140399003|25010399006|24021099003|24071999003|5072599009|15080799012|22091999003|39105399006|20031999006|24121999003|41001999006|23021999003|12091999003|40105399003|41105399003|26121999007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQ1kOS8Ds9hBcxhppdWKvYxOUcSP1dWUHKuhWGfDKJC0rSlm45r2+RZBwfRw?=
 =?us-ascii?Q?b4EECU8dCrGCQxF0zIyM5KJ9LBQ1XFnVgYFGe+HZZMZbX0k0eyQSIuktTquo?=
 =?us-ascii?Q?z722xAZZoTrKGkMfx1Sm33ZzF7D8baR+YYyWWsyOG8+stJQHTuv8zLIYZSJt?=
 =?us-ascii?Q?cSVFQNY8xA1zmqqhfGrv1ph5lkT4gAgWGUPsdw9/a9g5BTGRar+w3kyYEAKH?=
 =?us-ascii?Q?Dp+1HYO161/p2xhwBGX0k36movpFi2yCbpV5gGgrM8e7fTBHGhrT4bKgcdaR?=
 =?us-ascii?Q?DELDbD0e2mXBAucmGF1jZLUj/Uyst4HYo8JSMYOcQu+ZZoi2pZWunNC0STrG?=
 =?us-ascii?Q?wX46N5MN8WArSf3sl2SM8oC5kNqU9cuNlbuqZPGpobmj7IaY42dFKOQImyaQ?=
 =?us-ascii?Q?KRJvF8yL2csreVUKk9E+EiFPpDfL9ePBk1bqhMdKNRkkAnIFc2ob0Cvp5Gtw?=
 =?us-ascii?Q?qdf37A9vWmsj0Ibut4rvYF4QIDvTs+Lz1HYYbIrQCUwOAR84HiFZ8vRmpX2G?=
 =?us-ascii?Q?uZ2A/eX4UQFCBxMFvUtljjrnAxD/0Mwjeje9eX8CeVQSTywxzqQzZHAiAtGK?=
 =?us-ascii?Q?B9a1whmYMRJs64WOqEz7USyN/8VVkbpIqObVTficMSHDYFKzmNwc9XtYPo3x?=
 =?us-ascii?Q?jAaFarQVonypeDA6X8sMQHw4jafmQpGBZenHfJ0HEiR94J24o17g3SzPiIq0?=
 =?us-ascii?Q?PAbLB5uFVVhSkINxjLDqWhrahkE8JG/VOPHGeLp5zQzSD5fAKQu23MrLgZrG?=
 =?us-ascii?Q?S9AEHhG2W/I/ynzlr9JOtwf1tp9l1vT5qUxFkp9jqYZc5UxOLONgOORMPH7j?=
 =?us-ascii?Q?HftRD1Z1jlPKvHtkOeaqWby/OJMV1ZLA4Ypcs9+aIhG3dSWBOX/qIQy51E2e?=
 =?us-ascii?Q?7I0hkPGJdhbZxaPhZg2mf/7KErihcxFbD0dEfGZN4KwlSlbD4RQYw844Eysk?=
 =?us-ascii?Q?XqtbXLVbArNne2N8f1cFjX4tBTn9NoqIoQKo4sw3vaVUoZ5msfgS0cIxkTlv?=
 =?us-ascii?Q?PEK0QNDwZHqLxAU3/m8jELoYlfM3C1cZyXtki0NNuj1paqgZxWlxj/CFo2CV?=
 =?us-ascii?Q?8h4rItpEXKayPC9rGS3ZoO+Agb7Nz5odPMyPs+4S48VtRTAsNHzsabl2prmn?=
 =?us-ascii?Q?fw0gitue2JLTNReCHAVgpt8U8X4PkklF7xaUiFcWJUS+1Wihk1T75rEFc3Ad?=
 =?us-ascii?Q?Zd1//u+uIAQ2TL/MQ/wgC43MoZjgIxgEJXOqXYZnIHIwEq323p0fI4o2vBsS?=
 =?us-ascii?Q?eiUi9dIIk+K2p0+6LR6I?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WcE20bZURI5YikPJa+1FlH55qdprjWe/WHorixHs0C5NC70As1ZUE4BYQ+4a?=
 =?us-ascii?Q?tadvuFeb8F286zEl6tEjvultZV9nzjM9B8foUC5mhPqCXnyFbyC3sdyUHDdP?=
 =?us-ascii?Q?pbcvnkcKZQBzZr3BeO8CBTocL+DYF3NdUfuKa2S6wf0jruHUO6IE7spbYLAF?=
 =?us-ascii?Q?5bwkJFVl/UcmVJa/3ntmbekNddhEADh2cubllFXbBbqDrGC6a73M+QfYzB6N?=
 =?us-ascii?Q?VILpXBUCIuWjap3OqgCo2cqCusgFFMyWq8iE9xqMM7sLbw8xTJJf5HC79KTI?=
 =?us-ascii?Q?YENketK/5LIbi/jBU4uryLC248xORubP/HkE+iwitlkyCxDH8R6PpU+JMQ7Y?=
 =?us-ascii?Q?kRvlMXLMYz7ouWt8drh4HeMPus3g+tqKKloNeUGLZ7MC486cAaEtD37p1CRX?=
 =?us-ascii?Q?IAFhbq75TeB9vOdukvnIQmVGSVuyW1khF07GDOnOxwfVmchhWPAwPHQ2/vq+?=
 =?us-ascii?Q?gZWX6hglF+IOEJ3BIDNd/WSJhG3MxqT5H4tvRtM5yMCgE7U9Fh8UkGEVd0Sj?=
 =?us-ascii?Q?YgEkPtYju2mRja9eW0USU2aNMqUKgN5GPKC5R3KIMJbQFC+z3Stq38ACoOnp?=
 =?us-ascii?Q?mYodt48lIONKt2ARLylsIYLJ+90o/3SGpiFcgjsjimeb4daVUDU1uYaDGcEp?=
 =?us-ascii?Q?Jm4RF1Rc9i056YVslHr/3sSh59OVlqki2OWiR9W+K2nugDz9MtqT/XSNblro?=
 =?us-ascii?Q?ZnteABk4XY/j2tQ8vxTiE1bwBhL09tYrpmq5GdZ84N9Q4QYO5o3Cw6+m4Tfx?=
 =?us-ascii?Q?7GfzVzCa20zm4klDNCEWdXQPTw626T2ptOReXIngn6/tx7HrRs1sk06qnt7h?=
 =?us-ascii?Q?ucpUdY3N8vJuHTCQU5aFfG8vnTp8hooP/JerRvRzX6xgUkmrhpb13Dk8aKDK?=
 =?us-ascii?Q?tnMmwpWq5cGv4uHk4itUJaR1FBkQNz1ad20IooQBiKlRMSQYFquTjMykH+r7?=
 =?us-ascii?Q?kbxAfO4kO2yWRi7+fpK1goopHAkCcUnciM4I2zFYZGhBRoZ19uPoqrOzBAwY?=
 =?us-ascii?Q?1AfHH9DRfkQgs4P0bo/CUj5QYuOHX2p5byB8wgo6HtCGAX5vn6WsHVVo7BQF?=
 =?us-ascii?Q?ws3oETDG8JsnU103VLt45nYSt8DYpCzfWa7H6FSAjED3roJBRPWrViwxsivz?=
 =?us-ascii?Q?RR4qn2oywH1BVv9/Ti1CQ5aI2/bjf7g1Td8Vt6eUrhdrwulNc5bVfrwl7P3o?=
 =?us-ascii?Q?Nijz/szAbEeW0kh0XtFRb3bbeBGirEqg5j4jz2Vx+sHUX4vkqmRn+5KPT3lo?=
 =?us-ascii?Q?dSyNfAuAMb+THCsEfLMAQ533HJuWz0oc/sqdfpjlOPPbbTuQHs2kN65YdOPm?=
 =?us-ascii?Q?q/Y0fEIQFfsCsgD/3Fj1bw1emCeeo9f1sXaL6na6mYC3FV3YFBOuh5hFEmEa?=
 =?us-ascii?Q?8G3OnG7HIUMs5u8zfkj62YHc8TeouT9wOd9M6ArqTwDSCcTrMA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a1d7fb-bcf1-48c8-647e-08df351f177e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 18:12:57.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

> +/**
> + * struct max34417_data - MAX34417 specific data.
> + * @indio_dev:  IIO Device.
> + * @regmap:	Device register map.
> + * @lock:	Lock for protecting access to device hardware registers, mostly
> + *		for reading common accumulator count and control register.
> + * @input_correction:	Correction based on the Rsense value from channel nodes.
> + * @input_label:	Channel label from channel nodes.
> + * @cam_mode:		State of the Continuous Accumulate Mode feature
> + * @acc_power:		Saved power accumulator for each channel when in CAM mode
> + * @acc_count:		Saved counter for each channel when in CAM mode
> + */

All the sentences should have periods at the end

> +static int max34417_check_ovf(struct max34417_data *max34417)
> +{
> +	u32 control;
> +	int rc;
> +
> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
> +	if (rc)
> +		return rc;
> +
> +	if (control & MAX34417_CONTROL_OVF) {
> +		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
> +				       MAX34417_CONTROL_OVF);
> +		if (rc)
> +			return rc;
> +
> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}

Up to you, but could reduce indentation here:

	if (!(control & MAX34417_CONTROL_OVF))
		return 0;

	rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
			       MAX34417_CONTROL_OVF);
	if (rc)
		return rc;

	return regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);


> +static int max34417_read_power(struct max34417_data *max34417,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2)
> +{
> +	u64 power;
> +	int rc;
> +
> +	/* In SMM mode, trigger a measurement cycle manually */
> +	if (!max34417->cam_mode) {
> +		rc = max34417_trigger_smm(max34417);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/*
> +	 * Move the new UPDATE data into the SMBus read registers.
> +	 * In CAM mode this will also reset the accumulators, returning
> +	 * the power accumulated since the last UPDATE.
> +	 */
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Only get the accumulator counter in CAM mode, in SMM mode
> +	 * we only accumulate only once, so the counter is 1
> +	 */

"only" is duplicated

> +	if (max34417->cam_mode) {
> +		u64 acc_count;
> +		u64 acc_power;
> +
> +		/* Retrieve all channels to avoid missing data for other channels */
> +		rc = max34417_save_accumulators(max34417);
> +		if (rc)
> +			return rc;
> +
> +		/* Get current channel power, counter and reset them */
> +		acc_power = max34417->acc_power[chan->channel];
> +		acc_count = max34417->acc_count[chan->channel];
> +		max34417->acc_power[chan->channel] = 0;
> +		max34417->acc_count[chan->channel] = 0;
> +
> +		if (acc_count == 0) {
> +			dev_warn_ratelimited(&max34417->indio_dev->dev,
> +					     "unexpected zero accumulator count\n");
> +
> +			*val = 0;
> +			*val2 = 0;
> +
> +			return IIO_VAL_INT_64;
> +		}
> +
> +		power = div64_u64(acc_power, acc_count);

Shorter and makes the branches more symmetrical:

	if (acc_count == 0) {
		dev_warn_ratelimited(&max34417->indio_dev->dev,
				     "unexpected zero accumulator count\n");

		power = 0;
	} else {
		power = div64_u64(acc_power, acc_count);
	}


> +	} else {
> +		rc = max34417_read_acc_power(max34417, chan->address, &power);
> +		if (rc)
> +			return rc;
> +
> +		rc = max34417_reset_smm(max34417);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	*val = lower_32_bits(power);
> +	*val2 = upper_32_bits(power);

iio_val_s64_decompose(power, val, val2)?

> +
> +	return IIO_VAL_INT_64;
> +}
> +
> +static int max34417_read_energy(struct max34417_data *max34417,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2)
> +{
> +	u64 acc_power;
> +	int rc;
> +
> +	/* Move the data to the SMBus registers */
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;
> +
> +	/* Retrieve all channels to avoid missing data for other channels */
> +	rc = max34417_save_accumulators(max34417);
> +	if (rc)
> +		return rc;
> +
> +	/* Get current channel power and reset them */
> +	acc_power = max34417->acc_power[chan->channel];
> +	max34417->acc_power[chan->channel] = 0;
> +	max34417->acc_count[chan->channel] = 0;
> +
> +	*val = lower_32_bits(acc_power);
> +	*val2 = upper_32_bits(acc_power);

ditto, iio_val_s64_decompose(acc_power, val, val2)?

> +
> +	return IIO_VAL_INT_64;
> +}
> +
> +static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
> +{
> +	int rc;
> +
> +	if (max34417->cam_mode && !val) {
> +		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
> +				       MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * If CAM mode must be set, the Control byte must be set to
> +		 * desired values with CAM = 0, then followed by an UPDATE
> +		 */
> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +	} else if (!max34417->cam_mode && val) {
> +		/*
> +		 * After this, the CAM mode bit can be set and another
> +		 * UPDATE must be sent.
> +		 */
> +		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
> +				       MAX34417_CONTROL_SMM);
> +		if (rc)
> +			return rc;
> +		rc = regmap_set_bits(max34417->regmap, MAX34417_CONTROL_REG,
> +				     MAX34417_CONTROL_CAM);
> +		if (rc)
> +			return rc;
> +

Can the regmap_clear_bits() and regmap_set_bits() calls be
merged into one regmap_update_bits()?

> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +
> +		/* Reset counters and accumulators */
> +		for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++) {
> +			max34417->acc_power[i] = 0;
> +			max34417->acc_count[i] = 0;
> +		}
> +	}
> +
> +	max34417->cam_mode = val;
> +
> +	return 0;
> +}
> +
> +static int max34417_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +
> +	guard(mutex)(&max34417->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return max34417_read_voltage(max34417, chan, val);
> +		case IIO_POWER:
> +			/* In default mode, we return a single measurement */
> +			if (max34417->cam_mode)
> +				return -EINVAL;
> +
> +			return max34417_read_power(max34417, chan, val, val2);
> +		case IIO_ENERGY:
> +			if (!max34417->cam_mode)
> +				return -EINVAL;
> +
> +			return max34417_read_energy(max34417, chan, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		if (chan->type != IIO_POWER)
> +			return -EINVAL;
> +
> +		/* In CAM mode, we return an average measurement */
> +		if (!max34417->cam_mode)
> +			return -EINVAL;
> +
> +		return max34417_read_power(max34417, chan, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLTAGE) {
> +			/* Scale to mV */
> +			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
> +			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else if (chan->type == IIO_POWER) {
> +			/*
> +			 * Scale to mW
> +			 * (1000 * (Power Accumulation / Counter) * Correction) / 2^30
> +			 */
> +			*val = max34417->input_correction[chan->channel] * MILLIWATT_PER_WATT;
> +			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else if (chan->type == IIO_ENERGY) {
> +			/*
> +			 * Scale to mJ
> +			 * P=(1000 * (Power Accumulation / Counter) * Correction) / 2^30
> +			 * t=(Counter / Samples per Second)
> +			 * E=(P * t)
> +			 * Can be simplified to:
> +			 * (1000 * Power Accumulation * Correction) / (2^30 * SPS)
> +			 * The denominator doesn't fit in 32bit so scale down both terms.
> +			 */
> +			*val = max34417->input_correction[chan->channel];
> +			*val2 = div_u64(BIT_ULL(MAX34417_PWR_AVG_FULL_SCALE_BITS) *
> +					MAX34417_FAST_SPS_CAM, MILLI);
> +
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
> +		return -EINVAL;

Maybe make this a switch instead of an if-chain?

> +	case IIO_CHAN_INFO_ENABLE:
> +		*val = max34417->cam_mode;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int max34417_read_label(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       char *label)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +	const char *input_label = max34417->input_label[chan->channel];
> +
> +	if (input_label) {
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return sysfs_emit(label, "%s-voltage\n", input_label);
> +		case IIO_POWER:
> +			return sysfs_emit(label, "%s-power\n", input_label);
> +		case IIO_ENERGY:
> +			return sysfs_emit(label, "%s-energy\n", input_label);
> +		default:
> +			return 0;
> +		}
> +	}
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
> +	case IIO_POWER:
> +		return sysfs_emit(label, "channel%d-power\n", chan->channel);
> +	case IIO_ENERGY:
> +		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
> +	default:
> +		return 0;
> +	}
> +}

Up to you if you prefer it, but an alternative to duplicating this switch
is to add the following near the start of max34417_probe():

max34417->input_label[0] = "channel0";
max34417->input_label[1] = "channel1";
max34417->input_label[2] = "channel2";
max34417->input_label[3] = "channel3";

> +
> +static const struct iio_info max34417_info = {
> +	.read_raw	= max34417_read_raw,
> +	.write_raw	= max34417_write_raw,
> +	.read_label	= max34417_read_label,
> +};
> +
> +static unsigned int max34417_calc_input_correction(u32 rsense_microOhm)

Spell the return type as u32, to match the parameter
