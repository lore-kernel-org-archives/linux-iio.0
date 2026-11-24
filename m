Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519300;
	b=NF8RWtj7UdaVkOHN5DJo6HPH51KKlj/PmXkHnQeQZZKfSfmHtYwjx/hN03juEXSGkLUb
	 wrSRBCi1FaPpJH8YshE3Ich1TYza9xgT/D3E7hFWnPEQ3neHURgZvH0KfgBBnuqWMJ/Hb
	 uN/VsVJOXoDptpEhrSaGfLxuyiPOUQdlgLXGn5tll644+ONodye3TeGV6BL5XAVFt0mTp
	 nFViEv33oQcv4s+t9uXFMbTPlRLz4bgCbrW2GU9dWb/NkUiGjMqRU8f0QdLvYezPaI/XS
	 9HMBUrgQihrbg5gyl2DzwPCvINv6GRHpbao6d8f4ht4TmuB5iqkYsLSD/IrXnoYQ2lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519300;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dg3qqf+h1cBQDVYdvragtbfQ7SuUMowdCidj5Hv8h5Y=;
	b=FKDiOldOejiMA5w9SFHdOEqnoYwEdJ1vSeK7dBA64F1vqxdWlgW0qIkUC5oO5Ug6uDoH
	 YrSeoZfTz6eYvs39AVLtA+5GriiOwAXkAroLid2B2IvrtANQ81zb6QDDVnC1nJLwPKPBx
	 iMX8mwP+/2tsxSQA6g/S3BPh1RvAoxrkrqw9ssY+fcD0JNndj8PqvVRRaS1bIwwDFVzmE
	 Lj0UiSNcTMVHIVDvHE5QHRwONUfS6D5xlw7OwHOJLtz2+Sh14EOkGiU0NfgPWgZbNSbcZ
	 jhyZYWhrZEQbublHfjRODxJtksKj4ZDYZakHSR9ZWE3eHE66iZxHV0yN+xzGm3cZvTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bQUXEOQR;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ckxDmnUr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F169606A68C;
	Tue, 24 Nov 2026 11:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F169606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bQUXEOQR;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ckxDmnUr
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvRGD592387;
	Tue, 24 Nov 2026 06:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=dg3qqf+h1cBQDVYdvragtbfQ7SuUMowdCidj5Hv8h5Y=; b=bQUXEOQ
	R7UBU+SdI9qtJt76qZu31oM762Y9I+rZSo/AwZiQex3kiAStN9KeUCb5PNfjLjTS
	rGI2VesdAIatLXoQPW4Qzg4iIuuUcW4De4oGtJ4E8fwY/1innPiqf1bL687i4Bcj
	1zm+Qse4dNt9Cm1PudCTO0I+GlWwGOTWTu59qrNWSsYzGjh3ukho6iT+epIwlF4V
	Yw+Xn9vwA46T/XmyS+K0Vrjd3p8g5tRVM29J4GPLhMbqqnQkQUJGbQ8GRV0J7AvZ
	1PQQKqkBz7BRpvgh2UBzfXAuiwacMJh9fw8EqPbagPPZyMKKSKl8e2cQRd/SRxsT
	+KghsIO+L0cs8jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dg3qq
	f+h1cBQDVYdvragtbfQ7SuUMowdCidj5Hv8h5Y=; b=ckxDmnUrZ+L+psfXmIgcz
	XypytIT1eOyTYuC4a2aeS92JLTXhBMzhafgK7bgN2UUev5Yw/O/w2DJYwQ4k4blC
	9r2hbkdzYmC5iFp4hc7lD/E7WNIFKLdir3IRo3s0zS7AHU5LxNHXvDeyRk0yID2m
	B4/h+K49WM/Rt9XY4rusI/Lhp5UCoB8maEqYmkVF3R25qF+PvZhe9lkMo5IL5z9S
	UBtEYT9P11keW8ny/X4PZQfaqPQs+qkq0Mv2e3Y/RTYUbtBqB9Q5XGVa25mv4lKP
	eU4ViaipRTY4uGUVjk19kzKPEKJqq33Nj1tNe9Hb+Ai1BXoCKMivhWnEl+4E3+lN
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h0raj-10
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:33 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqVPJRlkSE9MPCDUwr1v8Q1Edoqoq3iSh864aPsmWOOZbtDb1EdseU1qFWCLZyH1wkD6TAyiXp1UKYdZFK3ebyvDIlfGl9XDJnJoz/FrfguWdnydDm8EAgje5BPymLF6eUETDTasSkNnJNsoZ6Fj8YRxO5Rfhe9vaimRtsFGi+DjOfbPZjjdJAB3nC5mNySnpDP5+O3DMXxIWodr8CC0EqODHt3VDdCMNiPPglbpHf1x3g0SSAtDLgF5Oks1XMoPktS10d183PmdxG/6junQD+gx5H2Lr6y6Eg35O7cYJ8NdR1qLaHkJ0u2v88Y0yv/wu9ubZwCRrLsCaEOm9lWWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg3qqf+h1cBQDVYdvragtbfQ7SuUMowdCidj5Hv8h5Y=;
 b=S2m39i9K3Xd1c0VEU3/aiCgovhtyP3lA1+XWdIWpYRKuwrRi639onoffL96Uzh/GNbdMC+E1oeWVEfKq1uAbcrASC37aW49rb5IRpfg0vUY7OyqMA9lMKd9QxycF/zBCAoLZpt+fEQMAfb/1+NobCeSsqL1+eWQZ5mUy4bBKlOim4CfspwFCwi0e2jJ7ZVTQAkt4sf61QnmM6p4Uo2nn8vF0XC7PABzcnCAgDIuFcQy9tm33d1tHqkO4yOYCcqzNtL1coPtNg4ERrXllbMPHq09qpjHPlGe4LwD89H8RgNmWrzqTEql2nXKQ6rYv3RO859UTom60y5quM0xqVDgChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:30 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:30 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:46 +0000
Subject: [PATCH v7 6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width
 accessors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-6-5d57df2c3ebd@analog.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=1714;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=qlss1fAjnOaPeQhNVcmVOyU5tBOwYMCdkKLn977fczo=;
 b=AM5P47qQvcmQXNoZgCiaButEHfOAnLHIOqrSx1XUpK5kw0OX8+Ogxg/P7gHDLdRE07+jxIl6x
 RskAkjSmK12DSlmn0yGuqkPfE8lyyVskVj/LTWA/V/+1316LvF7QAZI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA4P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: bd82c30d-18ff-48c5-b238-08df4a1cf29f
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|261022075727099003|10067099003|261009223027099003|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 f+MvgNod0R3H3xsSfpDisYy+ubv2U/QHN/tIhP1UlBVQBOm/xDGE2VLC4AL9LRNbjRBli9mKU1kb3Fqpey4lvNpNhOowOkIU/k5aJuIkyGp7aBG3ODG/iYvAhnQiIgHDXjSEnVbYxOFrPJvG0jIY86NObPbzvR5szA1M7d2CRkbqmHBHw1vJ0xSY94LwRVSEbzJoayXiT6liKMg0zjxI3nRYPkR1VMk6IRj+LsJQRLZW1SCkeO8O1RA6zX/m+RQEM3TnsD375Ef+IT5uhkyDcDc16d0neOxGXR5j4YWr1Lrlg+a6callJcXbGu0vGHPcsEXJWp/ogZg7LPAsjo0Ohcg1Kpl4JYAgk+ylKPY+ewaKP70RdGghgM06lrrpsQMVhd5gicMATqnLv13Fgi4snooudmVbbijI71rfRPt/OwYWO02ge3j51SyR7v3jDeXnA2uLPeYyrk8pH2w2gXTP28HHSmur3RueAkijlOcC87iVmR3UziCmw6SQda4K8YM8p88kPZrPCA9jxEYr4KysKnRxl82INu+uaDCdnlFhaWKYDDb3btsa3kFYnUI8GuRQYU8vMjd3LYb5eNu1OXvYADcUEZu8DlumvknUy1EQxJL3ZuyCru/cNFWIZWRVQja2Ggx8pU4jpvbc3n4KG/m9rQeZH0h0Z9XSQb2Vvz0OwCs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(261022075727099003)(10067099003)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cXQ2NGZnWmlDMmY1NWxQZ3huZTFWSkZuWktORnJiVVZsbjdBNEhQTDNFY0F3?=
 =?utf-8?B?ZFR2NWFwV3B1VUROUWZqb1ZxamtlZzgvQ2wrRkNBanNBcTZ2REJJbWh5cC9r?=
 =?utf-8?B?cFh5bndPSDFVK2N5d0cxc2c3T1psN2tzOG52cDN0YTRQbkUyRUdybjVYWUdV?=
 =?utf-8?B?bFpYbXczMlJBVGVmWTlzUHlwa1NVWi9DZ05oU1RoS2pTTmhYMXRWN3dIUmRm?=
 =?utf-8?B?Mm92MnlLOHR6czdoa2dzcitpYVBoanU5Tlpwc0t6WTVvK2hzdHVwZnhCMUlp?=
 =?utf-8?B?V0IvcXlLTUJaNk5CRzg4cjBId0RQMXdRM050VHorWnBSTE5aT1J3aU1MN0dR?=
 =?utf-8?B?cGFNWUJ0SWdYYjhnczA3d29lbXdaSS9lbjJNMW1BNFlBV1FkdWNMb3J2TVJ1?=
 =?utf-8?B?UFFYUGxHakhNaldCQ1RnbWhNS1lBTTgxVnBmNFIxeUFUdUpQNTBZTjlGNjYr?=
 =?utf-8?B?VzA4REtaRVdBYzhweGRyV3RBd0FKMldSTDlEemxpSVdiK1ZuRzlldERXZDc1?=
 =?utf-8?B?UU9BODBCR2orVDhLZDhFZHVFazVPRzRGQytJRlh0VjJmL0V3S1Z6MEhDWTc4?=
 =?utf-8?B?OGlLZjM3TXI4ak9keWxNa3ZVZzRRaHJHOXZTNDBsdHB6WXJXeVFGcjBVU3lB?=
 =?utf-8?B?cEE5eWJNNUdFRW1Rbk9Qd3FtWWhXNytUL0VvcUR1UWFsY1kxeDJxVDlCSDlT?=
 =?utf-8?B?N2FoT1BVNUJPbit1L3VDSFVmYk4wckEwdDlZSmxXTDdMZHM4bGZmZzRWRDc2?=
 =?utf-8?B?WTJheDhKcEljZWVWU3dUWCtCdDRmcnBUbXk3MVc5ckswMklGakFPUkFrZGNN?=
 =?utf-8?B?SVhhTTNNdWVPSGw5ZFg5SU1hczYxRkZhQ25BVTlUTkpLTldyeFFwT1o4Y3dB?=
 =?utf-8?B?eUpvRGx5ME1hRWdCQUZxSzhWQWJCUlJlN3lsWGhNNy9sQkYrQm5EVXd0Ynpl?=
 =?utf-8?B?aHdmUGVLdDlvd1lrQUhQZzFESVJMdDBUMEg3cldIVGYzY00vemxTci9xYVRM?=
 =?utf-8?B?cFovSEpoaWNEZkxRWUorcFVxekFXNFB2cDJMNUsrQVBraDQ2MXk5aTB1RWc3?=
 =?utf-8?B?djZhNGVnTlNEN1pOZjdmVXhhTHNjL2FuWUYwZWk3dUErSlJzV25CRmpkWVZU?=
 =?utf-8?B?NEhYdGxFZXA2eHYvNmE2NzZ3L1ltWDJEZ08wOWNMOG9HTzNuSmMwOW9sQlE2?=
 =?utf-8?B?cnBhQVlIdHJDRHJZb0NtSmRqRWVYclBkRGg1UUhTbDlHWmdLQjZrK3hOQ05W?=
 =?utf-8?B?RmN5S1JLUWxEbkJuN3JBNkllSllzOUNQOHR1MFVHdEt2eG43Y2pwWUVHYUhx?=
 =?utf-8?B?ck1rZ2xla21tVlRhOFMvazJIVEJISjljUDVzKzBjQWlLaWtnem9vSkVMVnJk?=
 =?utf-8?B?bG5OMEplNENTWm9CdzQ1QUlUaWo4VDlEdDRPNEtyWDg1V3hoQVJQYUZNelc4?=
 =?utf-8?B?V2NCcEVORHBjTWc3S01IUUhxNzMxdksrSGxxYnBoeVJLQWNZeDNvaGxHdS9V?=
 =?utf-8?B?eG5raThIQ0VzbGlXYnR0SGtuVHdwZ1pGZmE1TGx3d3NNZHhTVWxYVi9lbE1s?=
 =?utf-8?B?WFBIcUxONGRVSlJjWFBsVjdLMWNMU1FHZUJVM1ZBQ2tTbXdPb3NDMGhkaGJv?=
 =?utf-8?B?UW95WnJmUWlRd28xUDEwSURoZ2dQdWFKdmU2UWl2ZVl5YkFwdHZjcElRZSs5?=
 =?utf-8?B?WmY1ZExSZXhIRW9zVHNDMCt3a3BUNGh2MTdoR3FnWFJoUWNYaEI4SURCQ3hG?=
 =?utf-8?B?eGFjTFpmY3JlT2hncDZTV0dCb0d5bnBwWHd0T3VZSm9OWm5YNTBocy91dFBI?=
 =?utf-8?B?TVE3bHNiOFlJUkN1KzNmaWlSRzJlU1lTa2ZEUHI3akdNK2dsZXN4dVFXU1pG?=
 =?utf-8?B?NnJaZ2wwc0R1OVc3RUt3ZUVqWDNWYys3QnZaQ295Unl0RXJHNG8wT3piT2xX?=
 =?utf-8?B?MitSWTNQTmZjVzZtNHhCajM2T3FnanJHVzJZU3AzU2ozbkRaT0pvRnJFYVFk?=
 =?utf-8?B?d3RrakdXd3J1czRIM1p0RmJyYjhRdDZiREs0TXdESkZGa3gvdENyZEhYTU1R?=
 =?utf-8?B?MHBPODB1MjdTamZhRXUzb0phNkdmc2d0aGFOdUhveldsaS9nTjZFd3RSakww?=
 =?utf-8?B?ZHRxRld5YitxRzZuTW9LU1FYT0tDMEpZMnplV3JGK2MvNGxlVks5dmJOb1Bx?=
 =?utf-8?B?ZTd4S1hCU2Uxc0tPY1lmcm5rbnc4RmpZVEFZYnE0M0haZ05Ob2p5ck9DVlB4?=
 =?utf-8?B?MVhsUUxqUGtxUVhHQ3ZUSEhHbHhSQzVyMVRZcjVpV1F4ampUclVzZ3lSOGVE?=
 =?utf-8?B?RW1hS3htQk5iV0VGM1lrN3p5NmdINjNkVEUzRUExcXMxOVJlaDk3Zz09?=
X-Exchange-RoutingPolicyChecked:
	ePRuOwqAwAidPTz3EUxDDt8MgXs5d0v/y+0nBfPXxzAWrvTUR50TJGm6Rna2gIdvKqhpRZ0sJT/HblPn5GD6ZxhhXeu9cbnmA/dhaYLLxNNsqNqQFntSPmxDl1G8i9CegYmx3590X/yCkrBCwcPoZjxrf3avCMixvCzZw344gOKFa3rvK7vAAU/urfcfvLAxDCCE6w/1MKBcbpSKUkU+s1tU6jmF/52MHE27xm2gWz5QGAwCrHFGWMKunlEi3ezed1N3yy6S/uusAJ9TzDDkrED9RTtwLpLawT3UpMuTGytlJfpp9QbHlJq8MTxrGpqKgm95q0o+9Ah8qPADygfPsg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd82c30d-18ff-48c5-b238-08df4a1cf29f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:30.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8Ih+sKUUl7/7BWtvB4oaSEXdViXkcInIWjGisJZWvdd5ufAVbqs7GD4u/xe2426hGDhnxPs+kCzCAuUJltClg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX+5tmEP1HmSDW
 2A0Q4U5PZcV0psfxvN6wfXoqMqYqm67t84moFzhGZAS1cXmf2/UJyLk0YssBuQmJ/ZyddRKmuzV
 GQOHQu/hwAyx506FoIxsV1Pv+zV6N79kEPMRaAa8GhRSGkGR7978eDIJCZ61ycqnQmTOmP78X/6
 +1iRoxvRN+6i12RE1/Kz3GoCmeH9Vrymf/XUXuZp/8X8FCdVGawtltczExqk8VWZchJeHj2Arit
 U4fz42jBvJmJ0oy6YNme+TCbgHgc87pEThtMR+ukbIgG1AWgTFWq5x3JZQEKlLIVnJfuG7FjxJa
 G1J5mEmHC87dO0oZrRFkRDH0HYaL3sFZFxtY9cB/Kajmb9g87/XPrMw7Dgm+Y+e2J9cjgEMd3b6
 /6p/SkD7Rs9n7qMLAUKbidvzqy9OIhtm2RtKh/ZqG9v5IZawGvUW5rjsl4lL2hMAGf0IZyYjkLl
 QIPcDB/gG4JW6vEMrrw==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b057301 cx=c_pps
 a=foOfPl9YvWvIvXDtd8Rkbw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=PlQVE8PmvpCE9iZECF8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: CTdc0vmI9Lcs9gm0nPRAtortGaz7BEpx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX+rvnXG6bBZSV
 X7F2gds8YgWra1lolgv4r1SrLVSloa15SYrCXTy/I5DaKf5mtbF61PzfaCh0FB1q/vYu9j4krHB
 VCtlI66WSkb4kWjjcF/9IPifRg6EVg26MHAj1pIaCvT4oxLJtJsH
X-Proofpoint-ORIG-GUID: CTdc0vmI9Lcs9gm0nPRAtortGaz7BEpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

Query the minimum supported source and destination bus widths through
the new dmaengine_bus_width_min() helper rather than decoding the raw
legacy u32 width masks. This keeps the buffer working with DMA
controllers that advertise bus widths via the new bitmap representation.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b9f8b5b3aa6b..25e75cada4dc 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -269,14 +269,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 		return ERR_PTR(-ENOMEM);
 
 	/* Needs to be aligned to the maximum of the minimums */
-	if (caps.src_addr_widths)
-		src_width = __ffs(caps.src_addr_widths);
-	else
-		src_width = 1;
-	if (caps.dst_addr_widths)
-		dest_width = __ffs(caps.dst_addr_widths);
-	else
-		dest_width = 1;
+	src_width = dmaengine_bus_width_min(&caps.src_bus_widths);
+	if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dest_width = dmaengine_bus_width_min(&caps.dst_bus_widths);
+	if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	width = max(src_width, dest_width);
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);

-- 
2.56.0

