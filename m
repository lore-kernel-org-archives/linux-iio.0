Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792908198;
	b=q/j5kE9jsLMjFkOg37qApWfHy4zNv8V9uZmjsMI6Lyn33UXIXPo3GjKlS2BcswqRvFqk
	 Q9YXF8cn+2rxZkYkuSA2gcTX/IJm55JblGVZxojAmuz3aOYrdT/qpzKdtZ1ZlvTi61n7g
	 v0IeXnL/LkYOXxsmJWqL/24Gft6K+8AxaRvwy9iSABgi2Igum8aweLu311RmOnwB6zNzt
	 R6j0Gq8Rsx29gJ6uMOt5UVyPnlMS+uW+pOF/Ef6KgfDSQfXQ1bGCJbcr0r4fItDKWEvdX
	 mR+24uGwCRXBdFN7CRyyFM/nDIk1m7vAoyS4Ki6pPbRUUDde9zSJEnyLTe8B8iilIig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792908198;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=p23Vn5AXitR+s0FJQWGgQZKIUg3bqsnyKcswYLs46fU=;
	b=SpTlxm4smsbb7JlppMVJt6LwCZaC9xMHQVgqpWgfjxm/mFGgL4f78D+5B+anN6ETHVYc
	 IA0BpaIB5hudW/NT1EEG187+N1cFfIWIkrfY7hFj+bg6bsKoiNh1Zl00AjsMzF8DV5PTK
	 BoPkF3rNjG8/uOkmRIWUMa0LTa2FD9OahvDypDOUO3yVNU2a5KxXpHGAuqQ4iQP/YcsWh
	 NqaAm86CNuqYquXET+M0iwj8ycZVqgynuWr+8JAvY93+Z2vukX5DQESxFOlS1mtjAZ/lc
	 RDPSmRcZncAHoDwjThCCQDdz+iTf/PtPoVDIcR5uZOhIwqtogiYaxMr/NYEQHRygskg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tXw5Fn6o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.31
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011031.outbound.protection.outlook.com [52.103.14.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA2606A31A;
	Sun, 25 Oct 2026 06:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEA2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tXw5Fn6o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj2/ysGbmaEGT2fJrNlsVzRbQ83X6DJDo0PpbWfop60JxiSaZBEkx7LK+4mxs/Ovi1CeDsm1h+M0FEUpMp/DvgeYduvOzg6IS6QYHjoVhxuFxcLSlo1Yi+kwD7tY27NWNjTXcA/CGACTodp4XQcVqBpT6R+1yqeQLiUgO4jP1dLhk8yFXSX9rgx3LWHN+xpMoQ1x2rlKFpWoDJc/kkyh+Qn+B8zL2afW2htNt5MQkt4bax0lPdbLLPPZ0V7NZodyLFCOninESSPA0S1zvTUEUc1O4/bV63oPU2ydM07rtEH6ggUJVmbd/dfMGxjq44Bv5GJFCIXEL0itTOPAoWbMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p23Vn5AXitR+s0FJQWGgQZKIUg3bqsnyKcswYLs46fU=;
 b=t+krTVpU3ar0babSYQLO/3/qVooNnGPG8hsufIrLKMOYKC7faZJkO68uEJsq7DJJJOqyY9HWmFsI9KucGNTxrNUYE0WtGEJyNGJvBJmuI1izJZdyQjW+P+6006WZqqR3yaswmaeVa2GQEAmPK8ICFcKLaMKyGix3M/Mg1h1+9yfP6Zocxys01KEa4os36pv7ikJzosTXs+6KdcMuVy0g3RCJwIf/FjJZ4qPUPLI0/azOIOHwgh9NKO4Uhc1yJBLXJ3kbYMukP31uzQ7HTvQpOlgWST4b0WqAYbXJJ7Sf1/c6ugBG6flG6p6L493GNCmQDkdLUJS567PzQwEZF4d+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p23Vn5AXitR+s0FJQWGgQZKIUg3bqsnyKcswYLs46fU=;
 b=tXw5Fn6oxvl3Rs5aLuVkZU20H4OStWpm6TT8E8x1t+/TgGBnnmq8czq8fFO7xn0IEDbFMtfTMMOyu78U5FXoZWq6Y8Ikir+6THSYK00KHNwSleXlSBfeejEHWWZTZTq/oLYLQznPgTWoqOt2+9IZ8ScAQMV1XMwaOnlYAxb/29ATRr6IoqrxUwRJfSg5T+pq5+qezMnnQoAa2MBlQpeAVVQIIbpVwqYfvnZIQ+GUxwEUrJMhJExgRCJZwvA9TU/IJrHylEAnGA8IlB2YmcXTj9GLLDbTlE2lIjZaqYF0XXnAXLqBAdgrupquoaeb2+w7SDE5Sm2IepCfJb8ity0DOA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 25 Oct
 2026 06:03:16 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 06:03:15 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	"David Lechner" <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun, 25 Oct 2026 01:03:01 -0500
Message-ID:
 <SN1PR12MB2528906DC8636A9B02A8EB21A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023040607.400f8420@jic23-hlaptop>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:610:74::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025060304.36511-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: c64cb853-5be2-4d38-8be8-08df325da881
X-MS-Exchange-SLBlob-MailProps:
	hnD4Fgoc1bPokEwHA1l2GYyEHUkO2myIrX8kMDhREvzhaYXbMUjRm9ytrqANXWyzW19VJdY7wImsSnoimOjCnnz1PT4+wNPaud2TMLdCc5FEIOORwrhtnGO2wQNavRu0/20mrbl2SsTpe8fZDmNWqez+CAhmiBK3ttlSe+ME7YpQwSHPtXgLI4BW83lVqxSih4E9O6r47P9jmgAFIiLzVFqZwCBX+T+PTU0CjGcAWzk9hlK9iWMrt+iOYCrQpGPGXw1zquRaXYi2vXEib537CR7fK4piPdxjc37dG2gyvGysvMD4bZ6d5pVSl13bTsjzTfwp5+BCDb2fMVue8mCfMYL29w/I3tzyh1wrn6sQxrOEJyLnev8F5t1HcpAbt6BYzTqxFhdQnO/Of7DQr+jQjh8jIkKA93/eSewu3D8Se40TpK6YnvmvJDioOot1l4SFRBJxafW5uChxOBfDD3Wm7IsdQLCkOo0FkYAZTQQptZX31ZRjo9vjgvbI6sgys7qtcdg2oZRW/QQ+5aDvFp4FF3PK3h6pxpZqTNks9sPcM3Zlf8RU53qLlF3HF07bLvVBD3Gknme/b6AcdLtBovGuX6DMVQEBtDyJXrwHy5g1dTOadluHIAsY6Vycw36kfdym
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|260925184616899003|51005399006|8060799015|22091999003|24021099003|25010399006|15080799012|24121999003|5072599009|23021999003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VP4Il7NHxAodj1HthZQ2MvD3FH9qxsCg45qORQMRqokbaW4hjrItIACgy/u5?=
 =?us-ascii?Q?NLII42I5r/vdwnRpCtt7u1XgLXJ7AGEmTCbGbD4rBaNIYt8kU0f7oVby4ZJr?=
 =?us-ascii?Q?yed7xQQvXrvK43fHZAamPYPqxMl7Ae+jQzQD8wiD7U9X6Y9pGs8ipJr9aszS?=
 =?us-ascii?Q?V+wz24buE855PfHY+kMOJww7nm05hIcDdYvloUG30INfE52Xp1ayIgJqFSd9?=
 =?us-ascii?Q?MF5B3XK7Wu/LKRi8diwbRltGwRLIW6EUCbLyR38Hc6yicaLrKbE0AjLVaqhb?=
 =?us-ascii?Q?j2bkbqisT4XjFMl3PH6PGDn2bHHzukiDbA9yjlJd6ZEi8B5vZf74hVTB1xog?=
 =?us-ascii?Q?yjVth0Ibv3l8rsGX7a8YDBkoCK+oL1XQm9ZfqIgdlYaON33FW+Xl47YwFdSR?=
 =?us-ascii?Q?J/hp3QrNQJgT4z0cOErIQceJU4I0hYFSNBlgqibY7+bkk4v2zIItWkfQCz6k?=
 =?us-ascii?Q?HJE2tRpAzDGIXYsk01tlGJkuIfYSK3IPnG/hHAaammPOToKFSVXBXvDlCR+i?=
 =?us-ascii?Q?wxR1SOxYetlNfWMXXaGozXrU6qa0RGMaCPD1iMPCzIFen9YcmPto5Rmu6G40?=
 =?us-ascii?Q?YM7kzEFB0+e8CLLlfoIJOtY3YlQu+5iAtXF7eF/FDeoUtVX6T1+0KWkApcrG?=
 =?us-ascii?Q?APsgQWJrejcW7f4Y+B24UrXkIOusB41RUdFC0yBYaEr1zv7vfVciOHcphLS1?=
 =?us-ascii?Q?mAXfnV6oxh+yc91XMdV6S6dV47x4bBnMcvxhVzVbo4s/EciXgamK+s1oDs9l?=
 =?us-ascii?Q?aGdxPPrh8Tlea2HvB6Z8TKze/bswS2ZG9DzQQz9HHGt2S/eCnlAEbWXqfiIM?=
 =?us-ascii?Q?Wbk/3WETLvzn0lxb5U2icKs3zJy02FJ+QaHL8Bz1LYKCHJjhMpwgtCMVnubv?=
 =?us-ascii?Q?NnskGsVK2317ispwI8NIJorQ97F8s1U1N4j5dgfcEXlWecKBWbyUMIAm3hrr?=
 =?us-ascii?Q?2ByqyU5ywbv1M+CR82IxlCPTWhW1HBx2rgxFemzD+y7YZl9jAeMdu5GizkJD?=
 =?us-ascii?Q?SKw+WAypQNG199M1I6ezp21m0Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Rac2XduxQ8OWK867wuq28r58uByRvGFnmp1r59i1UVmT3U7bKM6+tJSnMvG?=
 =?us-ascii?Q?yVa0k/40m0W2/bYGkNpcfZk9s7lH5CJ1QOp8zVyIeZpZmQVS71ayRFA/Nz/E?=
 =?us-ascii?Q?nO/y/moJrKHdfxa36v78Em4dAnpGe8XV7KQB8RSqv8uk888Id3GLAMt1xZNf?=
 =?us-ascii?Q?CnclnHXU9sP1hCd/O77dTmiLIIHt66TdzTzwEMsQn92qKlD3pTGpOQHa4vFl?=
 =?us-ascii?Q?LZegMXg8t/IeNjrbMU8wPWFAaqC+lLQA5JAUxsgEVg0LcWbrNZO8Kkk0p53o?=
 =?us-ascii?Q?kmp/2pTk6v1WLidGlsTJHF1TwDHgz3dgGzMADhtFiSA/CQFeRC8efI2LL9Qy?=
 =?us-ascii?Q?vxvsLtDkP8idYBwwc/ad9/fSJyjZ0/+G2VJmT9EZbIkHYvmPFrSGz5JlQDj/?=
 =?us-ascii?Q?jE71ikW9xUt33KYXzWVfesoRQv+tZfOHm6AbdOLPHp92vGCYbxrvx9iog9Qy?=
 =?us-ascii?Q?LlEGO1jNmuJtajjJ/opgitIMC1XexLtB4raqF/dPeWePBRKX02VtV8NdNZnr?=
 =?us-ascii?Q?jeF7U8SOmINR3iIZAhnAkJ1iGTQCiZf5gm247VeNWXZrCq7Gr67bfX9w4iX0?=
 =?us-ascii?Q?fUSoBk0k8Ij1ru2HFAo/Vl4FQgR7yLrY0roZS7XwZ8UuNfgQ4LXObYUMVkjZ?=
 =?us-ascii?Q?wye+XfMGn5XCA9lCT4clvrFiOTr7xLyde5Fb2tS4B1IiPEDeoxM0AE9BW0Nc?=
 =?us-ascii?Q?l+Z96UyDOxUE+W8gOay3LgSQWIdXUP3oNtQ+owA0kqBZ3GJwWRELpQWMX+Yf?=
 =?us-ascii?Q?DRV/l7LWsXiq+aq6TQrwjxzJuYCHn7O/eq9XauztwOcV8J+OKgMrzIRm+Bv5?=
 =?us-ascii?Q?s+nydQYDRcJYYnQgxs63srvu0tFX6GSFu9GFaKJjNgEnU0i/BXSZl6lkEh/2?=
 =?us-ascii?Q?bKiEMshX8vlg7d7JqGpQWMxjjPzpGF2kjaPT1tt4KHaLvbwZB4CLj8j7mRIp?=
 =?us-ascii?Q?wcxA1iKbtozraH7sFPXASMIhaaCuoLL61J/ZSG+ck4FNvBmBGv2CdgdFCNL/?=
 =?us-ascii?Q?8CHG3umi7ithV5oZIkwL9axXhzIjx5PP84dkIOCkuXZijDxxP153f4tWGqB7?=
 =?us-ascii?Q?pndS/UQ/AwQpsnIcjXEUeO7PgysmsHSUSOCvetdgqS1swuOEFnJn1zGu0Ax7?=
 =?us-ascii?Q?J79Pv4AuDvxfhKWU9vNpMss/+NG7c6vMXz6WHjVB5mYTOyt8Ej9yTsxdut17?=
 =?us-ascii?Q?ULoZyf0RUemdImduwW7KsJOSDLNUYG42oI75QS15HLmQyt7FZBJABO41SnyT?=
 =?us-ascii?Q?Aujmi65e/lJnkccv3zcnFxU7NVIndn87pgNqqf7heWUtxO1aK3xygTQxQ1JM?=
 =?us-ascii?Q?TxlY27+4R4tW1yFXJLr6/XyeUOFU/05TociTfk9owAA3ZXFeYxfKRtuuKlwM?=
 =?us-ascii?Q?97GYK5gpPOHWLoPTtkONWOmp4qWQyA0hmK8zYzBnoXS+cuyg+g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64cb853-5be2-4d38-8be8-08df325da881
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 06:03:15.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

> Seems we failed to update the test in drivers/iio/tests/iio-test-format.c for
> FEMTO. Please add that and a similar test for your new units.

Added in v2, along with a fix in iio_format_value, because as it turns out
these new values caused a bug there (it happened to not manifest with the
driver, but the tests caught it).
