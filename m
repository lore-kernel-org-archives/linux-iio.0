Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794557616;
	b=N5g4ZZagem1Y4fEOqgjwWKcYB9+NKURPSUlwXLGqMWywY7SNoCY8vbw96p22PmM8gZOy
	 AcsQkq2McJV8/3v3uDv+MtH/HQ89WgOCb834NFDb7Efrmclaau6xP8mf3mS7WSNefu8aq
	 pRe3LfvjIMq7+Fi+CGZHH8I9y17p+cshZ2pmyfcoBsWuQAAb1gnfIpIxlDG176UPojmmG
	 FjZaVHvadi90a2TcewHdvsX/8MdlDUSUvOB+kF93ah2SYQQSsdqP6xIgh3p25IG2gIokE
	 OrAQ4DW2bfaGnHYwNL/TSBetOmP6H4io4xMqsmwuEr1gJOE/jvEM3N5okvesckbZdKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557616;
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
	bh=m8G836VI/dk1eVvayFUXGnreEQmOrJrOh2J4p4RxXsI=;
	b=Z8R8J8DMa9NRi95riZChM5MvFaFpe7TAlKvxkblbZ8hU3ixzDsydHRh8JXTwdJlhGyZc
	 4hT50hDAcaFsH5R1GJso4b8S110R9TXfmEc7ivHoLPcTUGWBuUpQsaehMsNCHIthKuNzf
	 TlhZbPI1FKnPfePds609/+ureLyqeUuxPIsSnzaPYyFJWAElk2U9uekJcVf49SZqzjoyF
	 wzVpmFsrV0bsS2hse6u5c7hA7F61t4S9aWnxfKq4KdcH9swm19hcdLVFkscubeN+WnTs1
	 yEe4jqGHjHAOHYsvQuJFUIj3OAOp/pnSa7UZATkdxCNPGE6a9lV7CBZIFTfL0Z+GR7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=oUeTsQuQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.90
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013090.outbound.protection.outlook.com [52.103.20.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4F606A321;
	Fri, 13 Nov 2026 08:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD4F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=oUeTsQuQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORzdWYblLwNpH/Hu58kggvI7B2I2MpS+sFjwD5gTFG5o+cXCogfgYT+6FQkqLiYvhOqIGRdpA7vp3cYjON/OO2FmnX1cDzns/bBQHPRNeeU54otrdZgdMUC+PLfP3yxdeg5m9PSoUH2SwAbT00MYk4Vajn4K3Z/3R9PDzVGY5gS+qWy3APftolovhweKjfTFUnP2rGALeT809qJcLYkpfv9Dxm2v7Tv4KHtM8IFXk/cL9wV0YICPm7NhOHfK1rak0UYZ8cEaLFdRzb7ZG1P3MZa+rA3mL1CWwrfFI+cE3oL5MIu1+FGOPFAXs1l2nkHqOfJMZZwpmFB0FyD29z5vOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8G836VI/dk1eVvayFUXGnreEQmOrJrOh2J4p4RxXsI=;
 b=bMo/vpxSb11WVp2HRznRo61tn0YcP43LQnMmMq2bk3l0q0yKHTAexTCCaXFCI24ai3GhLN2HXqJsu6mJhJiJHpaL53zWeIpcmQvik9jfgfTElT1KNLZMoKKN9d/M4+5W7FAFqQY41/sQg07ZX6AwIMybUrhqv72OqpcrIwjN2341gb3689AIZt7DFUv2s5OwopxAAG7JMQuIfSF4YD65DWWeouIn95Wd0bl/AKcvj0Nzbsj/blBCTvf0q9lJv+zzRl0GgwZI4jGShKqVWDubR2Pr3xZUqpxg8gUqyZq4dmcuRmF/3M+/aqpO4KjKbqK4iEyNvXSJmzpSibn9H+0QaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8G836VI/dk1eVvayFUXGnreEQmOrJrOh2J4p4RxXsI=;
 b=oUeTsQuQm4dGbcPqGgAXB4ZX8+u0MgQ36sE9jY4r78FvnXMRFzW6A0/mKrQoQimCT2nmgUoZ9qswHjxYgkNFs6pmQ38nxcZtb+jbVWiiKUYVpY0oVuJB5ULwZvth8rIO4eX2fM4JGAIMmWbxCTZcss6J5i9v1FjNFTxsbRDWSor5e/X4iledLc+30Hbm27HBFkaKFhXIu5NB1x3L/KEUIbLpnjC4cYxFWegecc0QynapG0Nqqv8yvgN0KnboUSAvCaQ2rSoPdcJjLBa3FGBtXuCONSrcKDFuqDt/G1JYdKTs9FwL80gKJc3QgN768VCAsPD/T5G6wFTwzlb7nSO6iQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 08:10:11 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 08:10:11 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	o-takashi@sakamocchi.jp,
	panchuang@vivo.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [RFC PATCH 2/2] iio: accel: msa311: use regmap_reg_field_* functions
Date: Fri, 13 Nov 2026 02:09:58 -0600
Message-ID:
 <SN1PR12MB25283CCC55A35005B3B9C003A57F2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auxcM5rKxI0Aigs1@ashevche-desk.local>
References: <auxcM5rKxI0Aigs1@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:303:8c::9) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261113080958.810429-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d0598d-2f4c-4810-5774-08df415d89a0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|23021999003|24121999003|22091999003|15080799012|5072599009|22141099003|260925184616899003|8060799015|19110799012|4140399003|39105399006|25010399006|440099028|3412199025|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKBxOFwv0AceHXhgP2cGr1rz7mwlla4MMRlZ2Fnb1ii7xOSH836M6liLfUA0?=
 =?us-ascii?Q?dAsjvqFIUbtNlpiu2GM+FS9aF7CfdwvlB/AQT08I17iGmO+j4kNHWh3/gF9W?=
 =?us-ascii?Q?RvF8p70deVnDR9hB/l45zYMogKMPABzvvTotMPfaGkXn4X5RPGMMlt8TsX7k?=
 =?us-ascii?Q?tbzaa6ORttp5wIw8nCmJWYQ8XCgpV8sygOfRsodTHYFd1APhGV9H1mZ0uvPx?=
 =?us-ascii?Q?fNsLxv7HXoBSsbZZkcICoGVsUC19ZY64UvUoyXhOy1yTRvFBJ31ExhUKTWB3?=
 =?us-ascii?Q?Kj0rZFV6rDsDN1cVJiiHC8lIZvCnHyP7o30juLTEtbwWP2nK7wti1uGAq2Lj?=
 =?us-ascii?Q?Cs5x44KJZaA71EEW3kwdKaxteBK3lpYRxzDhjUo6sumTWVL4rYHFofE0Q7sy?=
 =?us-ascii?Q?5GeF9qBfrtJ/D4g+AOhC0pFlAQQDgWR/q6SeXNvUFxmBaFOyoC4CS0HnLhh0?=
 =?us-ascii?Q?2sp7nhAu7Sqj6/nFUS8bSW2Xuw7VhTPaUasy9OsVGriVu+TNd+yWnqnNJqOb?=
 =?us-ascii?Q?UYSP1cEnb6fEuyy7LReKXZxOLsIaJutamxqZuWdsutjmEpV7TejkyWhqDg8W?=
 =?us-ascii?Q?5jaEQJod0vNGIlslVavr7fwS9PIHbMi2BfgHLsZU/ZhaaXGywypycyBLP5au?=
 =?us-ascii?Q?v3Sw7q16iZ3BccUxVRluXBaJhbrERb0jvm5EcB6/06S2I/QN3p7RzA5FLIaK?=
 =?us-ascii?Q?3CQw71aU16n/VBtGccJxXT7K/VexS7gRAIzoehrPWehDg3b02Q5zPTWmrzeL?=
 =?us-ascii?Q?B+kzAsPVHoDSh+KmFu35d1npLPF0+Ne/zLVZX672RbRTvywk2778fCXodp4m?=
 =?us-ascii?Q?1TcMogeVL1CSwKszjQAwiNvFx1kODq5IJ7id6VJrIXN8esI6Uk/B2V9KA3Hd?=
 =?us-ascii?Q?MFy1wytNVNBuXYNI8hLFfmWFaMfSMXHSKokvzLpWO9sR9blVU4Mb3LofKDy0?=
 =?us-ascii?Q?qdtRYgsf98LO5bb1Hy2jFeaGyhEHQqUNxrMGmtpqsiGDyKYLNgC5PT6o1UVl?=
 =?us-ascii?Q?ou1bV0K6vPaJazIpNY9p0fd1fOqjCIgRW1ud+tQVB9ZaBgHL0r9F/chA4gCV?=
 =?us-ascii?Q?ddFHXwz6wIhngXYCS+k1tCqCQDD8JAz2svxVZYH7T9PTkCzdkoE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwhjuuNVPuhVWgLFrJPyx6htl8pu6oRnG7J//LSUAkGQlmVAA6OUnSQix74W?=
 =?us-ascii?Q?j2JYwuWVmQLzb5hADrai0CV2mpx2ubzrEkkbyrjQNaioAV7xXdqAbkm4NvC8?=
 =?us-ascii?Q?Tw3eOy6y47ZC1qwdZKo3HnWgtFpiicqJoRG8fPQO9M3Q94TkN+RRN0XSqKr7?=
 =?us-ascii?Q?J8juzSJXIVGfpPKFpdR2qStbGVwvJ0y4QNvfMvxw4egUHvmE6YQPnR+6Gxpj?=
 =?us-ascii?Q?zWGCMD3mjCGSlJ+7AoJRgMYyRC9KHOhIOR3sNzJ5lVK8ZykT/5vK6b1TNBaM?=
 =?us-ascii?Q?0Bgge7XACI5aHOuAVZ16meu8wTsLgMtvQkgjf1KVeKliK77MqznoVD8ctwve?=
 =?us-ascii?Q?dQS/ysZuO6+vxRun2EHoesQeGBwIFNojmexAYWhNCFQWhBpUJp4wfSbIT/hw?=
 =?us-ascii?Q?WWvjVEfC8PIYkyOvV0lURnGXisKXmJY8ZvXxZVQ1Snin0hE292AIjyz/mOqV?=
 =?us-ascii?Q?S7yLVBWnBZ9KlBwHtqhtz3vIEI5+0p2VywMHSKH2Qok8P5tHOWIINuMBmTWN?=
 =?us-ascii?Q?He/mHQfk8dMMskc8O9F1ue7yd1mvFDu8tjK5IXOQ3+m9CnElnSwIZ2mYeTiC?=
 =?us-ascii?Q?tcy+Nj9S20g3Xcg4crxN23p9y3w3mPfAZPV73+SdtubPAbVaod8zP29Vke9V?=
 =?us-ascii?Q?e4ljdOT9j7WFyZjdf5UxN5ZwTUdUHXAWPKmOTsI4oVEgJtQf1CIY6B/V6N5E?=
 =?us-ascii?Q?GzRxYSfrScG86JX+z6EKd/OAo2oTnemcpONPYd8NNItSPcg/SHLvqiSfsC2I?=
 =?us-ascii?Q?XbHiR3DLXgfY3GfHY9WpeoL76xBmv2VBhwkQPvO8JEQYiWoxLkRfd64ZCKzJ?=
 =?us-ascii?Q?sZtv7La4KP+Lg8bGYGbJplwh7KWCTkwYM5J/5Z/eNS2RGWT2AQUnuPSwI4HW?=
 =?us-ascii?Q?bMlp7ed8kFzyVh9Cg8p+M4hT3VvZ61fWUjljB/GPpk+3E0lQ34ckQVEEz1Ss?=
 =?us-ascii?Q?i4ohjTXDc5v2N8mh//ExEWZibvJCns4WJXuUD7dVO1rBFcveVzPH+cLiwapm?=
 =?us-ascii?Q?ZRcIFzV/9w3F6DkepMJh/uIpvPTAuUjIIyGg2z+xkjNnFb7zhQL+scimdN1I?=
 =?us-ascii?Q?3RtC6dlONTqzrhydjyBLIQ4T6rKqA56DdsHgZKMMMsYpWpnEfO6kapVxcDu4?=
 =?us-ascii?Q?oAs7g2Lva+4MvW4wHZ3iJAqTrwBh00l6Rl6fkErphUfbf+jkOEpkU7OgYXYz?=
 =?us-ascii?Q?I0YtEpi7cXuXt3J88Pd6MBfY9H5WQxAOr0V4rMkUF4v5Hf2iXsMjIqQ2INoL?=
 =?us-ascii?Q?/mTmoXqMTAIyqqjKdG6SFBfXoqemTGXTuhNUPFMGUJrnJdOC4zb/iSHE8S7Q?=
 =?us-ascii?Q?gs1vdmmb/Akq5KAxgK63HvXRQa3UjOHBXGsJyCTbwrwQLL8o8QoRxskCa8cN?=
 =?us-ascii?Q?c8avIMtmY1mNr2TmzG938WYIxime6zvVZOhfbVdjFpOUr9Sa4A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d0598d-2f4c-4810-5774-08df415d89a0
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 08:10:11.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481

> > Simplify the driver by using the new regmap_reg_field_* functions.
> > regmap_reg_field_FOO is equivalent to regmap_field_FOO, but takes
> > a reg_field directly instead of a regmap_field.
> 
> I have just proposed REG_FIELD_GENMASK() macro, this change may rely on it
> 20261105103533.1426533-1-andriy.shevchenko@linux.intel.com if it comes through.

Now used in v2.
