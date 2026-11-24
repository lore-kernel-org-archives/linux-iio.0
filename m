Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519269;
	b=qTVk51haIb9ADNVNKjQ6Kyx++aWCshJDuUuff98POqST1vgXTCUhvea2T9UuqFdktkdr
	 lcCq6NngFFe0ENTq6JGf+9wQKn+iOIfVWMMiGVJRwRYmmIGle+BXePNSsw/AlleweK8CH
	 msxvz+UbyLqQylIM33kUARf7jAbuv03LsqrDpi/BNo10RVFPOn1k1m5oKc7V7igHrvaTg
	 UGJr4y5OADlyaGGDubu6sNwZAIWmLHA8U68JGTQvFn41PEI88zlNw2irp6+7IX7SWzcML
	 7Scw1WCwGrhg3/Ywk7hlBAeGsYYfVT4oOPJoPkKvnE7VhRIhJo9jrb3/N4k0XDlT3Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519269;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Fp14RXcfZEMvq9N4mjt2zBSTmcmaabGt3fF0s/xCP5E=;
	b=OUGF+Iz4GT9zHGl7Cs9p3z6g1sqIGQbU9TlDp/UBg34CQz/2PAitrnoaC8CaL9U5ATgM
	 bzmQlapHvKCbvr2k0RsLUlV/f4k2W7XWwriBIlR6KEeIrm5xyr5R9zVYXCfqNhiHie8m7
	 ZSM0QVTAwEFKRzBbEVo1nxYiTwvXlFOeNkmSAxBfK1xbHLVApf+Xlmutothvu8IXRGqoa
	 cPkvF8GVdJr5Iq9EuMP7FLeHdwqP4IPB+wI+2/ed6SEOjFt63odzQ0Oij19EjwnkXlDzx
	 fpYaw0iBVH1LBrBTKO24X32dcBFLbADrTw3Ai7Q/Nm1gu9DDqoqvNntoqr7cKD37u7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MqjyXebf;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=GjwAMVvz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BA606A31E;
	Tue, 24 Nov 2026 11:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MqjyXebf;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=GjwAMVvz
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAuKGX3436950;
	Tue, 24 Nov 2026 06:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Fp14RXcfZEMvq9N4mjt2zBSTmcmaabGt3fF0s/xCP5E=; b=MqjyXeb
	fModfweh3u55zNk7AQb3tO1xMYePcuxj3P5OU5lMXiHfE8momvOXr6v6YM9h6bM+
	i/buoB3cHnjPpmum6a0hMvLEwyp2jxhYIK1w4lU4mOvpOXyU16VAsfiUr4xXRWXb
	v1xs5tR0IVIKMrGX3wr6AEBfzVt+DHXAIJz72xOYIAN4dQK3r5SiSf5/SVimjUrt
	Xs043ANDZionmCCeMBhT3kybexsjtl2lJl9s32wvXrBzm1dxdP0S7sMVWZ+3IEkp
	RkOrO7YR/v978C24UEZkWHb0QjHdNBq+kdIHP4sVl+RJe+z/P1P4gdfKRPEpGE0A
	4AgQNq1pgou128w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Fp14R
	XcfZEMvq9N4mjt2zBSTmcmaabGt3fF0s/xCP5E=; b=GjwAMVvz8IFwKu82gjiWq
	CRffqC9SWegpi3x/ZFoiph/aAaAUZiS5aUIf8hAclHSNXjDAbe96SAZedd37lH6r
	hpJroXqSznO/ZqLrqKWpDY0iQ3ntp2ysmoNyjcqU36QsaqTloysffGf2xXfx6QM+
	2qRS6A8JuV5W312t0iw3617YuH1zP6nYSCA1YY5QTgJ26wAtQQvVXeiX+LF+iJys
	BPySsWEbQiuU25Gdm6PstFvNCwWjIZb2vosEuvpGygvdum/krBlH4QnLbHybE+ga
	ujyopJfCqOvwj15ZchXQxPruvJ6owi8SHnvBLkb6hRCrjSXMKApqimx4dxoCrvB+
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j4jc866n6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:10 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgIJEiD60+ayjw8LV6Vmg9kf770sDk+5jH2g+uY50Utn1SJfmwbf6NGuk9Lw/6TrdF7R/NILVLhEMYltMP3uJ+wRn2+ybHbNXt6Rlc4G0IJxm/GgkbXEb6pT76tMRgDJfB1uDC1YeZCzmtj8VwuZuRPa3qigpvQr5Y4/voU7i5WQr9RwY8B3VTZNjl1hj0PiCXmufi8A8OSF2Q37ap84KkeQUlHkgKiRwdpdLJcQDgAYUwjqkMw0nmOEu70gtcZRH2leLGSjwpMJfM5tv3qyFzCiA37DpnSgyJKoochXdOq4lZzEGPT4NeRCP6k1cdIOKYXgzcTHySJsSskd/r7zFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp14RXcfZEMvq9N4mjt2zBSTmcmaabGt3fF0s/xCP5E=;
 b=BOR3Zs7Yocbp043utYPC2SZhKyVuo4cSOI3spkjo8iPE86ZiU33XPd/47h2Up17OuLrcy/1NbAkvz9LuG3h/mrI5HOTVmfwrLAR7vEocld4vy3dZ/uTVsc07vrhCD+bD8/2e2V4w3c+XoM8Xnb/2MaL2SPf2q9QQSAEHrvx8UNp1d3bCdRwAEFQtjMGvanBo5EsYL7PTOQOKeoT6w++GUcMFJfiVci5LqcbU1yjtDeQlVK90h7eujWv/+RzbMKvD7mphmpu5c29bZbQVGRCHX9n4Z/RMpoJfoHMwDvDIAnpdf3zoobHx2s9DfBPQEf5bLHKEkg8cspKIkqLYZ2DgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:07 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:07 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:41 +0000
Subject: [PATCH v7 1/9] dmaengine: Support bus widths of 32 bytes and above
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-1-5d57df2c3ebd@analog.com>
References: <20261124-dmaengine-support-wider-dma-masks-v7-0-5d57df2c3ebd@analog.com>
In-Reply-To: <20261124-dmaengine-support-wider-dma-masks-v7-0-5d57df2c3ebd@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=13508;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8phTVIGSlbSJfdZJwre7FBemDlm3zKAlHBR0xtR6Wa8=;
 b=TIQxQc9dI2T4t/YqLwtSpUao1xeLiUQnMeVoA9QDyWWEyQcm6KeOYffRQWORCW3sbcQnxapxO
 VPZsQ16DuesCGb8J55M7mIMugFAfa7+WzrFNZaeEIB+vuJrOU1f+85w
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR1PEPF000077A6.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::434) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: 24949d01-75b6-4a53-7849-08df4a1ce53e
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|261022075727099003|261026121527099003|10067099003|261009223027099003|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261102130727099003|261028144727099003|5023799004|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
 hClfjaPRm6H0wPWNRfUHQ17TFW3k5uCDKVTWzXVJRIbct8QT19UjsMU0+j0XotWgXM4iSf0rJvvba6rKKiusjKsuqbaBWz/XqAIymNqBQiY/l/127SbW1PMAF+96rKLKYEKMNTejjstGP9Fbht9h7SVBKQ1oDkcMCoYYpDWzzBHr4ZcFiX/0KJOYxCwT5PJI1wN+eyPV9dXBlXE2tZ2wSsYRS2yhJPA3r6NeC3ZVFje+K3osMkzrvgmmx67st5Zevyv7DRLB/wvkBDMECGEXJ2OctSPHbXbDp8TdvfepXrNiu/Kal//x3VKaGwowcYG8D9p169TxHGLkJbmZNijT976T7yprLr3vx8QQ/8HgM6fp/P9ESk8CJvDl4VqfaagLTAE4tVmeevSw3hdsrs2s3RTDUL+D36zZievL9/mZ51NPYBVs3fn2IHQxmmuiixmxoldOgMptsJbE7rSutOF/d4UlacwsG4dqJ/+DmVNdzTH1sA0W8YCFLmrE2bL1nQpjkuZvNKvoTr8iQuzDLLQbUjS7RY38QV8VMjnWcfeDCOEq+WUivaDSvZV6Z1dQfEPLAP31b5cLXyRbuUI8Ehgu0VhpaOK2VLmq4+x0cdRuUbPPf9ouI9CoYtFgwbV/w7qhjW3P3Whm8DR8PbC+U/ZkUkw8q9fWjH26ceAENKYimi8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(261022075727099003)(261026121527099003)(10067099003)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261102130727099003)(261028144727099003)(5023799004)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Vkd4RFdDZXFMVDM3Q0g5ZHBBeHhTWjd0YUhXaGl4MTJuN3E0VHJlRlk0M1Iy?=
 =?utf-8?B?c0t0ZzNJTzk4TU4zYncxTy9FV1YrMi9sTGhMbWhPWlh2WW5CSXE3SGFlWlNR?=
 =?utf-8?B?TDcyV2RYUVNINEQ2OFpHWUR3TVJ0S1oxUDQ4Zjh6emtyV3R6MFEyZVN4alVy?=
 =?utf-8?B?dk9MMnNXemtlZ0VzdFBrd0MwWjZJdENvR1V0OXZLUnVNcGdVS2ZJcE9lcnN6?=
 =?utf-8?B?UjBHZGh4b092eERTQUNsWS9ZZWpBR0ZLK3ZHYkRMam55dThnUm1yNHlaOW5G?=
 =?utf-8?B?ZHVVRXQyV2l2NVRwd2RlRHhFdnFLZ1dtZ214N2hxdEVIOW9VWTc1c2hnVVZX?=
 =?utf-8?B?TWk5RVBIdTVDL2F0bDNXWElVMGY1ajdMQmhqMFluSXo4OUhnb2Q2MkZHS2Nu?=
 =?utf-8?B?TmJzbndhNUlWR05qbGdVdUhpUVpNSWw5T1VINXI1eUxZb0VMdldocUZDamhw?=
 =?utf-8?B?UkZqNVRpVVREZXQxbFpidUhDRGxXSmZQcmVuMEdOTVJJS3RQUHdvK3Byb2h6?=
 =?utf-8?B?OEZDWm8xODVjM2xLWEZDN1ZCRkNZQjArY2x6eHRudUlBZ2QwZlJ1M1ZhcVYv?=
 =?utf-8?B?bVBJeDI0YkJWV3JDaHBkNUQwekxSUWN0N3pKU3J6b1BweWpPV3JhZHJYT2JR?=
 =?utf-8?B?dTRvc05KMHdhTnl6TExKQldzTCtIWEs2cE9EMDlUMktlcjNQR2tUZk9ubVFJ?=
 =?utf-8?B?dFFmc2MyZjJLcWlSU0V2WWlCSjNqaTFHYkhTRXZiM2VLc3JhMU4zRlFjWmc0?=
 =?utf-8?B?eXFpT0tVa2lTbVRYNHk5cmR4bGRuMVFRSkczaU1PRzA1UTlVekNHZklvOE1B?=
 =?utf-8?B?RzlhMXF1TmFWb1NkbHdsOHpTRFRNUnF1S2ZjR0tRVHBqaUFYSzBjREkrUTFS?=
 =?utf-8?B?Q2tYZ2t4UFNiUktKQnc1aWdjZU1zWElpUFRhSGxtbE1qTldZQjQ4M1FTZEJ0?=
 =?utf-8?B?SGZMTmtQamgvSTlWbDNjZlBxL3llRE5MejdhZ0E3YnQxVUZ2ZzdxN21YY3F3?=
 =?utf-8?B?cjE4QmN3dnZFejk1bGtyNk5KcjNrNlprOXJ6bHdXQzBrajVUTHd5NlFrRFNN?=
 =?utf-8?B?bzFrb24vdEJLMm9oc0hxWEdXeXJBcmpGd3dQR1FDd0pWVGZhcWUxQVdyVFJC?=
 =?utf-8?B?bVVkdGhwMUlDN3BzK2xjenJsSGdwYTVocWY0Z1hKZjBsRXJpVFc0UGt6dGJs?=
 =?utf-8?B?eFpUbUE2WmxmMFh6MU4veFZ0dVNLbVVmQVpMOWJHenhjeStveUJvY0NXU2lu?=
 =?utf-8?B?alJnaW9JWm01ZUtpMFZBYWgrTTdldU1MNFNETEY0dnYvNEdrR1NHSlpSeXQw?=
 =?utf-8?B?bXg5VmpVUEtYZVI2R2NKSG51Vko0YkkyVjJpeGIxSXJieTFIZ2RlL3lMeHVj?=
 =?utf-8?B?YWx0ZjByZ2szakhSRFFNM3FXc3FWV1BxajFOdWVFSGRmemlLdWNkdXhTNVoz?=
 =?utf-8?B?UXFqdU1UL2xuTlc0aUZRQlQyOThzbDJOaWVEUm4rbDE1eW10MEgyYWdsL2xH?=
 =?utf-8?B?VE5Db3R1dFVhblluNExmRVQ5bThZaG1INHJvck9EUjlWbmdUcitwWVlySE9C?=
 =?utf-8?B?UTlBRXZUZzJHQ1lHWGdkbGhSQkg5eDhxVWZGZ3psNitiQW5UaGVoVCs3MzRm?=
 =?utf-8?B?VXdCWjBOQ2ZpYVpRam9UK0lwZWF3UXFGQ2ZnM0x1V2ZtQUpJbmV0VDNud3JO?=
 =?utf-8?B?dVJnb0RHYXVXV2FoV0J5K2gyNGNaQ3hQRGtzOGhsdGhPTjFyM09MVFRqL2lW?=
 =?utf-8?B?ZlZuRGZibCttRmxUUmpYc1R1LzA4dytiYUU0VkNEVzdYUkc3d2dWVmNKeWZ1?=
 =?utf-8?B?ZVI4TkhOMjMwT2JTNXQ3VFFtNUdLeElDaFRBbUZzTFk2UlF2TGl0YnNCcE1I?=
 =?utf-8?B?NFMxdk96VEkyTEN3bEk1aVB0WUZUdmVSUFRFaGFCdmtSNTArR1VwR0Z2bVlS?=
 =?utf-8?B?bGRXb2FvVmw3SmtXc0NwU1VUQ3FEUTRYR09DY3FFWkxJNi9GdU11Mk5GbzRH?=
 =?utf-8?B?ckV1TTB0ZVVsYmZlWWdrYkxDVFdSTkdva1lMYkYwT014Tk1iYm1yZTNZUFJp?=
 =?utf-8?B?U291eDRKRXVCY0dEbkdiV0txNXB2bWZqcHh6Uld0VFkxQ1oxeDIva0Rvb2h5?=
 =?utf-8?B?QWZSTzZBZUUzV3RyNnc0c2JrRys3QWhNS0x4Vm11ZW52K0Z3Nm12em1hV1F2?=
 =?utf-8?B?WFNhanRieU1mUE95YTF0K25BblRBWUd3OFdveUZlbzUxd0tOUXZ1QVJ0d1pa?=
 =?utf-8?B?bWZhVnV4RnhnMTgzZXR6ZjFGd1ZvRitsWjl2bk42c2pqZS9vTWlFZEhyYVJO?=
 =?utf-8?B?QzBxQm1rNFpiVENZRWNYWFlFWlloY0pPMWYzNkloVk8vOWhTcjJXdz09?=
X-Exchange-RoutingPolicyChecked:
	euGPteL/PUhLdVB59chLDjghiqI7EtHv/YinsRJubzGYMD4vDx/u5kkIpfAPR2G++YwCD6biDtOkz1zpYiGzXf1u85xRI+7vp1xyeck52D9mfO8+Xt1OwN3Va7xRZv0cv4EGggt0Y6DaX7J5xsvQnyfEij+z5xM9su97emo7yL7+nS4nxd2Prj674bZwc0zZ/GxAho3wnWR3I6ZCXpl8bvjm3cg+Ydohb2U4apQKUlLZFOWrCu7faayPDgyHGiulgcItdsG3X4B8vlVyKBLCpzF/o/59StTUNmrxIJzHacFia+Q5R/39PfuRL6jD0oPmSr91souWuKmHA9/69W8gOg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24949d01-75b6-4a53-7849-08df4a1ce53e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:07.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3SWDF0dGxKWmyKNNGLYNoKhDKcf+XELb76V+9DixMR1Dp2cU1NSptrFsMuEvVyv7NtsAnIkozqH1FlC3x+1Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX+UBdWeYubDuD
 fEebwjSNFdN3aWfCvs3Q6Qu0hh2djHbUoYqjbOl98teOJuNhgyNQE3z6FJ1stZrhLopWgCCFJ2w
 0TRtjWgBAnwbczG7kE7g5mm59D97HUPM49uy6jWyL7gvZsr1+0Sc
X-Proofpoint-ORIG-GUID: p4IJ8XQfS-IoqTOmQSrX9EO0AXkv1JCy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfXzke9KTrdzCMr
 wa5WnM/TGx4vmbU8N1tB8cTYevUz1c94WKb+eMlGOYuKLvIQZuetf6FrxEexz6obvOPOb0e8cmp
 M280wbQ52uUbpv4PPqBu7I2tztc4yv0jKvoAgGnPk+t5nEpitgn2uzFdawsTJTiMCC+qe10gqTm
 6xHEDFWGKyvV/ycgVVvKm4A7xY1EnYPat/9KjmhWmsVObVXdDqeIIbv8kONMXaj86CnppxeBHLM
 MNc7P2rXYHNH0oaLUFi0HrdDqV+xgck+QShYZodWiASraDb/3PF6gvOBx8ubJIle+XC+eyXxvdO
 I1+b7mcfN1hGAWNspQ9ULW1FGnWF0OLiV3EsznZkYg/LMHWFsCNZhxkWN4Iz8w7Hs6UpwBTqwtx
 aTRbYG3/ecdpKZx/RF7d69kCbYN9yCDe+QTrxesS2BLO/DcXtIwfrGZaYJrQsaybjRNCrBT7ZsT
 Rdj603NRGBOdbpz2+8A==
X-Authority-Analysis: v=2.4 cv=GJ+dgeNK c=1 sm=1 tr=0 ts=6b0572ea cx=c_pps
 a=6brTJxCCefizds7ERwDNzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=bbKM_mjVB8olCydZLLoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: p4IJ8XQfS-IoqTOmQSrX9EO0AXkv1JCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

The src_addr_widths and dst_addr_widths capability masks encode each
supported width as a bit whose position equals the corresponding
enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
4). As these masks are plain u32, widths of 32 bytes and above
(DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
be represented at all.

Introduce bitmap-based bus width capabilities that span the full enum
range, through a new dma_buswidth_mask_t type modeled after
dma_cap_mask_t. To allow DMA controller drivers to be converted
incrementally, the legacy dma_device u32 fields are kept alongside the
new masks and the core folds a legacy-only driver's u32 into the mask
when the device is registered, so consumers only ever have to look at
the mask.

The fold is bidirectional while both representations coexist. A driver
that only fills in the legacy u32 gets its mask derived from it, so the
consumers already converted see it. A driver that only fills in the mask
gets its legacy u32 derived from the mask, so the consumers not
converted yet, which read the legacy dma_slave_caps fields, keep working.

On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
masks from the new ones when a device_caps() callback adjusted them, so
that a converted controller narrowing its per-channel capabilities is
still seen by the consumers not converted yet, while a driver adjusting
the legacy masks directly keeps working.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Andy, did not take your tag given that you're the one asking for the
split and since we ended up not doing it, not sure if the tag is
to be kept :)
---
 drivers/dma/dmaengine.c   |  50 +++++++++++-
 include/linux/dmaengine.h | 197 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 234 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 7eb8d53b4863..f81efcc75985 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -34,6 +34,7 @@
 #include <linux/acpi.h>
 #include <linux/acpi_dma.h>
 #include <linux/dcache.h>
+#include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -620,6 +621,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	if (!device->directions)
 		return -ENXIO;
 
+	dmaengine_bus_width_copy(&caps->src_bus_widths, &device->src_bus_widths);
+	dmaengine_bus_width_copy(&caps->dst_bus_widths, &device->dst_bus_widths);
 	caps->src_addr_widths = device->src_addr_widths;
 	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
@@ -639,9 +642,31 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
 	 */
-	if (device->device_caps)
+	if (device->device_caps) {
 		device->device_caps(chan, caps);
 
+		/*
+		 * A driver already converted to the bus width interface
+		 * adjusts the masks, so derive the legacy capabilities from
+		 * them for the consumers not converted yet. Drivers not
+		 * converted adjust the legacy capabilities directly, in which
+		 * case there is nothing to do.
+		 *
+		 * Goes away with the legacy dma_slave_caps fields.
+		 */
+		if (!bitmap_equal(caps->src_bus_widths.bits,
+				  device->src_bus_widths.bits,
+				  DMA_SLAVE_BUSWIDTH_MAX))
+			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
+							    0, 32);
+
+		if (!bitmap_equal(caps->dst_bus_widths.bits,
+				  device->dst_bus_widths.bits,
+				  DMA_SLAVE_BUSWIDTH_MAX))
+			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
+							    0, 32);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
@@ -1201,6 +1226,27 @@ void dma_async_device_channel_unregister(struct dma_device *device,
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 
+/*
+ * DMA controller drivers not converted to the bus width helpers only fill in
+ * the legacy u32 masks, which cannot hold widths of 32 bytes and above. Fold
+ * them into the mask so that consumers only ever have to look at the mask.
+ *
+ * Goes away with the legacy dma_device fields.
+ */
+static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
+{
+	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
+		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
+	/* consumers not converted yet still read the legacy caps */
+	else if (!device->src_addr_widths)
+		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
+
+	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
+		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
+	else if (!device->dst_addr_widths)
+		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device:	pointer to &struct dma_device
@@ -1262,6 +1308,8 @@ int dma_async_device_register(struct dma_device *device)
 		dev_dbg(device->dev,
 			 "WARN: Device release is not defined so it is not safe to unbind this driver while in use\n");
 
+	dma_device_fold_legacy_bus_widths(device);
+
 	kref_init(&device->ref);
 
 	/* note: this only matters in the
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 805668fbe437..8f07eac6a877 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -427,8 +427,168 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
 	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
+	DMA_SLAVE_BUSWIDTH_MAX
 };
 
+/**
+ * typedef dma_buswidth_mask_t - bus width capabilities bitmap modeled after
+ * dma_cap_mask_t.
+ *
+ * Each supported bus width is represented by the bit whose position equals the
+ * corresponding enum dma_slave_buswidth value, e.g. a device supporting a bus
+ * width of 4 bytes has bit 4 set.
+ */
+typedef struct {
+	DECLARE_BITMAP(bits, DMA_SLAVE_BUSWIDTH_MAX);
+} dma_buswidth_mask_t;
+
+/**
+ * dmaengine_bus_width_valid - test if a bus width is a valid one
+ * @width: bus width to validate
+ *
+ * Return: true if @width is a valid &enum dma_slave_buswidth, false otherwise.
+ */
+static inline bool dmaengine_bus_width_valid(enum dma_slave_buswidth width)
+{
+	switch (width) {
+	case DMA_SLAVE_BUSWIDTH_UNDEFINED:
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+	case DMA_SLAVE_BUSWIDTH_3_BYTES:
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+	case DMA_SLAVE_BUSWIDTH_16_BYTES:
+	case DMA_SLAVE_BUSWIDTH_32_BYTES:
+	case DMA_SLAVE_BUSWIDTH_64_BYTES:
+	case DMA_SLAVE_BUSWIDTH_128_BYTES:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * dmaengine_bus_width_set_many - set the supported bus widths
+ * @mask: bus width mask
+ * @widths: array of supported bus widths
+ * @n_widths: number of entries in @widths
+ *
+ * Like __set_bit(), the widths are added to @mask and the bits already set in it
+ * are left untouched, so @mask must be initialized by the caller.
+ *
+ * Return: 0 on success, -EINVAL if @widths contains an invalid bus width. Note
+ * that the bus widths validated before the failing one are still set.
+ */
+static inline int dmaengine_bus_width_set_many(dma_buswidth_mask_t *mask,
+					       const enum dma_slave_buswidth *widths,
+					       unsigned int n_widths)
+{
+	for (unsigned int i = 0; i < n_widths; i++) {
+		if (!dmaengine_bus_width_valid(widths[i]))
+			return -EINVAL;
+
+		__set_bit(widths[i], mask->bits);
+	}
+
+	return 0;
+}
+
+/**
+ * dmaengine_bus_width_set - set a single supported bus width
+ * @mask: bus width mask
+ * @width: supported bus width
+ *
+ * Like __set_bit(), @width is added to @mask and the bits already set in it are
+ * left untouched, so @mask must be initialized by the caller.
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+static inline int dmaengine_bus_width_set(dma_buswidth_mask_t *mask,
+					  enum dma_slave_buswidth width)
+{
+	return dmaengine_bus_width_set_many(mask, &width, 1);
+}
+
+/**
+ * dmaengine_bus_width_clear - remove a bus width from a bus width mask
+ * @mask: bus width mask
+ * @width: bus width to clear
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+static inline int dmaengine_bus_width_clear(dma_buswidth_mask_t *mask,
+					    enum dma_slave_buswidth width)
+{
+	if (!dmaengine_bus_width_valid(width))
+		return -EINVAL;
+
+	__clear_bit(width, mask->bits);
+
+	return 0;
+}
+
+/**
+ * dmaengine_bus_width_test - test if a bus width is part of a bus width mask
+ * @mask: bus width mask
+ * @width: bus width to test
+ *
+ * Return: true if @width is set in @mask, false otherwise.
+ */
+static inline bool dmaengine_bus_width_test(const dma_buswidth_mask_t *mask,
+					    enum dma_slave_buswidth width)
+{
+	if (!dmaengine_bus_width_valid(width))
+		return false;
+
+	return test_bit(width, mask->bits);
+}
+
+/**
+ * dmaengine_bus_width_min - get the smallest bus width of a bus width mask
+ * @mask: bus width mask
+ *
+ * Return: the smallest bus width set in @mask, or
+ * %DMA_SLAVE_BUSWIDTH_UNDEFINED if @mask is empty.
+ */
+static inline enum dma_slave_buswidth
+dmaengine_bus_width_min(const dma_buswidth_mask_t *mask)
+{
+	enum dma_slave_buswidth width;
+
+	width = find_first_bit(mask->bits, DMA_SLAVE_BUSWIDTH_MAX);
+	if (width == DMA_SLAVE_BUSWIDTH_MAX)
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+
+	return width;
+}
+
+/**
+ * dmaengine_bus_width_copy - copy a bus width mask
+ * @dst: bus width mask to copy to
+ * @src: bus width mask to copy from
+ */
+static inline void dmaengine_bus_width_copy(dma_buswidth_mask_t *dst,
+					    const dma_buswidth_mask_t *src)
+{
+	bitmap_copy(dst->bits, src->bits, DMA_SLAVE_BUSWIDTH_MAX);
+}
+
+/**
+ * dmaengine_bus_width_and - intersect two bus width masks
+ * @dst: bus width mask to store the result in
+ * @src1: first bus width mask
+ * @src2: second bus width mask
+ *
+ * Return: true if @dst has at least one bus width set, false otherwise.
+ */
+static inline bool dmaengine_bus_width_and(dma_buswidth_mask_t *dst,
+					   const dma_buswidth_mask_t *src1,
+					   const dma_buswidth_mask_t *src2)
+{
+	return bitmap_and(dst->bits, src1->bits, src2->bits,
+			  DMA_SLAVE_BUSWIDTH_MAX);
+}
+
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
@@ -523,10 +683,11 @@ enum dma_residue_granularity {
 
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
- * @src_addr_widths: bit mask of src addr widths the channel supports.
- *	Width is specified in bytes, e.g. for a channel supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the channel supports
+ * @src_bus_widths: mask of source bus widths the channel supports.
+ * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
+ * @dst_bus_widths: mask of destination bus widths the channel supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the channel
+ *	supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -545,8 +706,14 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		dma_buswidth_mask_t src_bus_widths;
+		u32 src_addr_widths;
+	};
+	struct {
+		dma_buswidth_mask_t dst_bus_widths;
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -839,10 +1006,10 @@ struct dma_filter {
  * @dev: struct device reference for dma mapping api
  * @owner: owner module (automatically set based on the provided dev)
  * @chan_ida: unique channel ID
- * @src_addr_widths: bit mask of src addr widths the device supports
- *	Width is specified in bytes, e.g. for a device supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the device supports
+ * @src_bus_widths: mask of source bus widths the device supports.
+ * @src_addr_widths: legacy bit mask of source bus widths the device supports.
+ * @dst_bus_widths: mask of destination bus widths the device supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the device supports.
  * @directions: bit mask of slave directions the device supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -924,8 +1091,14 @@ struct dma_device {
 	struct module *owner;
 	struct ida chan_ida;
 
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		dma_buswidth_mask_t src_bus_widths;
+		u32 src_addr_widths;
+	};
+	struct {
+		dma_buswidth_mask_t dst_bus_widths;
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;

-- 
2.56.0

