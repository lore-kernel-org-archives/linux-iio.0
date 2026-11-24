Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519299;
	b=CTiEMZafDU11F1UqYKCsBXZVoOAwnovyKDHpmICRn2b5ckeZDUKsN2AV++tQ7ER48C1n
	 3d5uAyKB23GU5i6++AW7+fJI8dQFAKMCzCbf8VU5kHFfopHl7cNLsEzjHQcwRSMpc48/H
	 SBXHWQq5jJ3Kbn/wOG0eTtMRtEv4s7ygtoOCwvYpGmEZEh32vJ6zdltY1DhXKLgMTm5c1
	 YhzXioBKyuvNW8Oz3utT6kFDfrb6WKMzN6U4mUUQVl9t1ecfbvoUixsFpauXRr8pnTN5n
	 gxadsuux6UuRRQjidyoHc/mOOh2hmf+VwEIdAxp1OZBOWWVW6s1dUkcnaeFIX7Oht7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519299;
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
	bh=OiLUIXmOveH7IhaQOEussFIz0JO4VPj/mfwKm22DbFg=;
	b=V/PoTHXL7II+kTs3rQ3z9bBHuCkdGQX24kbTaTsBINja/7Rvr4BAqvuQNKiwqs2kKGxr
	 rR4cUcifym49o0f1mpl5PMvEcwD3G2CdpltgtLBUqqe+aEERlE9TdeYnidWfaY42rlhjP
	 /ii2LVa8aVCqSb7Ip0d/TxgAZ/2Tz/+gr0/zfaS0lDLaWbrLkCp3CXLU9VX1jUKgdNpYd
	 q4zrCxFWX2018IY/Kk4BNhgInky2BAs7mbx3+UAR1FSO0TtCUm43e1HgYMX96aVIaE8HN
	 f6nwMYTj0zoKtxTgiFxA6bUz4AGEulPQEw6TNy+KjwpjkFW9rhxz/5SQtRMQTq6ueqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=keH9DmcP;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SbstMvCO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BA606A33F;
	Tue, 24 Nov 2026 11:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F0BA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=keH9DmcP;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SbstMvCO
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvRG9592387;
	Tue, 24 Nov 2026 06:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=OiLUIXmOveH7IhaQOEussFIz0JO4VPj/mfwKm22DbFg=; b=keH9Dmc
	PU8KevwtzchJFoaM0WMt6Xy3ruypI7zCmsZiZukwXVDn0BYNdjlmD3Y9CyBZHPVm
	kKMZ2ze6N+dTRznBjfNhAufE9DIwfpuLggLl0VILBgQQsDDRBowPQj2qRIiqhtgx
	Z1whn6ae98wkk9NIerxbNFbQN27cX8MQZElgCoR5LfVBFL7AAEiT3qm5hhDq8nta
	gQxJUXQKlvH8c036Cjxn7ytjQFS1rirKjoHi/DeHn9nl+0rRt+zFCYWIMA0Iwxh/
	7tLlZLW7/i21I80yKYJnDevOxYJmTYeQX3gpbESQOIdLD0drje23Vl7A0SEq0GbC
	ZsoVJ1l5Wgt3xrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OiLUI
	XmOveH7IhaQOEussFIz0JO4VPj/mfwKm22DbFg=; b=SbstMvCOgHqHwxLdDGUew
	I2otpe4CZuiMEffbfbfq1PNy7nCS5pvLUPfaTtjr0rxwmVstqAgAWcBoNMbcyGLj
	vKy5MV64UXV/wCiQRXbKBd95Ad5f+CoBZFhJUlz9H5Xq9wOiV5n2g3FDDT2q/xe3
	XETTDn00cWbhdpdVt4zLPINizIzqq4BxeFTY9pZeGmAR/Xq/if2VRkh1imWAp3Fj
	CDaI9FBUu3tXSB4Rvt0ioE+ACpPCQquJnoQ4FPYcbpE4E3UGG2NXgBNV3TRfzgjz
	c8uk60jFE3LB/u+SjLstMObTLENCzz3LkRLKnv6yjPgCQyC5f1rg9Q1tHuwMOaQZ
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h0raj-6
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:29 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5OkBnmJZtZ3UeqVYyoxGJk6OwJgtxpvn3HQfqeWCUOSTV5zpIvmiNhnCCsjCE0yvitqbpS1BR0V4MittuFRBKKuRhLUg/iAjn1zcmPqDe0tpZHHZckSeRIvV9qMijXCrUo5e3Ya5hKTCM4QIX+cwXprYHOnfTzJ4g+mypXTZjSz8W3v9VzP9uJiYB6DpHNctXABPDiSz7uwPO1lqJYT/4iKTQcqi8dlkURkVrdOvsuXZTeF3pxt+RmvwB7+w8o2/Cvw94SDClKc96KVrKL2kcLhgt7QqeDcWZm898tI0OYacup+kR4IH4gKO36ZwEKIAZFaNALn3gdS5j7zGhv4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiLUIXmOveH7IhaQOEussFIz0JO4VPj/mfwKm22DbFg=;
 b=DRnz88JHJQc03XMTTw2+saW+ju8cMnryOzIV32trxA2+bqZdvRzxNFsIMkvGlUfso5Di3GkcSIlOnu5AKkmXYH2kXQVTjph2AUlXHPpFKOwkpqnMdaO+ScOjCxxGbmjW7B85SZn24VVlNV4xc5tHa3Z5f79OLoVHwXn+TMixY+h6Ur36YaP+vI6wv306eqG/9DNhTvRjV8OGInbvrIN2P+6vXhDPXFBMXXjzbHSi8KXPZEAPbS52JpiyBNanK2+gzRtEi8jx+wI48vgerAKnjpB2hh8VjHoiCOpFx3O9y2lxoU6Xx+IDkjQdao60ahdm+g5Khdx6AzkXplfEug8iXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:21 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:21 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:44 +0000
Subject: [PATCH v7 4/9] dmaengine: qcom: gpi: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-4-5d57df2c3ebd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=1441;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gnaOfCgeGY7vbEmCX/QZ0hyT3dCWWIcWC1Dh5yWOS6Y=;
 b=5Cgleu5+vFJwsHTPuz+KhIB9RT+a22FhE/WQhJp26mZtte3DTOeDD7xtCbcN/vBl1reMcVTon
 /zVBlMyWpSnAuC4SdxQTKnADY8LB7BA31D2V5AJ/0dsX2cKYqMHmakv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 80ea5dc2-cd6c-4c23-d27e-08df4a1cedb5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|261022113327099003|11063799006|261022075727099003|261026121527099003|10067099003|261009223027099003|56012099006|261022105027099003|261026130827099003|261021135927099003|261021130227099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261022115727099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 Z5vvzam387akBNmDm2jFgZ5qdPldGF35K983hqr+d+ixErk5e+wn79KXMkxQD7Y6UE3ayM9pG2nJQgEuQwi18weTec6lE/SElf98p1/rey1g7dZO+XkFm2NdSmB9afuMa8GIi3XMIkNLGj+hIAGxijiYtuRtswoABLuRtej746VIVYs7f4DDtj04sXhf55MDNrp3KCsjpMw/xQ+B0bcXOZX0TPZj5QvMDzroJ+f19EqLSphZkyIpg+xqDqidBkG6Ib4qNhpqrObxL+5NA1l8zwmvHiPZVjC/zOvIGIhtnNUaheZBYl+XnYElr17uDpvv7mfLXKFa6gqsaqIbr9Yehlwl7lAlEmVmK5ANW96X6IH+uv7b1o3VP0MdGK42r+fN/073qKOYxtUeKSnv+xkDQFy5k+7ACa9nOkVfV5nQYd/vX3NKV3+LjBytvDAvi9wJ08Yede2t9EhiMnrnUasB2Of6cVceprkxAzoEWnIxPOJZ5pyZi/jSXaF1gKMYWAKw38r8lcQT11htk/BPcpzx05zNc6UtvpLXP7UmxM1FWzusnabj8+v4RxBP5OCO/AhEzlHUHrel5eYv7HPJWFbECT/Oo6Tmj+jfAM/1f0pCHDLlIr7cuZNA7Smg3IsCDTIyy9cGx5BUEGig2Ng7kB1YXGDmXbJ2DgUWdwOhl4Q+g8w=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(261022113327099003)(11063799006)(261022075727099003)(261026121527099003)(10067099003)(261009223027099003)(56012099006)(261022105027099003)(261026130827099003)(261021135927099003)(261021130227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261022115727099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bWZFYkxmRU96dlNRVTIrUTI1aXhqNklRM2V2SkZKWnZPOVQ5SGg1UWdYT0hv?=
 =?utf-8?B?bmNlRzVoS0RPWnlXaGNaMDExSURxbnRtaDNCdU5QUUdTS0pQUE1FTEhGNVBW?=
 =?utf-8?B?dGVtNUc0QmtSNU0rcDZDT2w0eGJobmJXZXRwVzlad05YcWZVZ01rZy9VK01o?=
 =?utf-8?B?M2tJNzRKejAwenNXc0pCR2lBdnhKTGNwVTlXLzNkdnhjR2ZGQ3BXNHhINVhW?=
 =?utf-8?B?SzNDbytlbTVIUWlwZ29TeWRUNExZODl4ZzRjZFNZdVBvQ1VCa0RuUkFBR0hO?=
 =?utf-8?B?RXJtQUJONnlTMG1MVlFoQ1hiRXhUL1MrUmwyRVZoeGdqLzJhVzlneFIrd3dB?=
 =?utf-8?B?S2hLdEIwTXBpWDdYSy9YVVlXc1NvQVl5Z1RpR3JOTFlIV0dBZ08rTzEvVjB2?=
 =?utf-8?B?MzM2QmxMbnJOWk9IcGE1Q29nWkZGd1ozTytBc25EekFrOGphaFh3dDZnRVU5?=
 =?utf-8?B?ZzJMMzhFTXFoQ2NnejBMcHl4Zm80U2NOMVNuaXVCelNBZjN6cVRyWmF3aXR6?=
 =?utf-8?B?TmhiejQ4TnlTeDFsK1IzY0JPcDV2RURKWTk5a0w5UnJJRDJGTkhuWk4rUXZT?=
 =?utf-8?B?cFh5V25wb3FydWZLbmdKM0wzSXVMMUdVT2NqTG5STFZOZEVUaE5GL2JxQWh0?=
 =?utf-8?B?M2E4RHJNZEZUSHBCUXVpS2YwT1U3WWhEZVVSeTBlNlFJbGpGWFMyRUEyODZo?=
 =?utf-8?B?aEh0WnVCa0s5eDZlU0JaSlZKWTUrNzg5RU1KRWljVU01TFcwMTc4QWlSM2ZI?=
 =?utf-8?B?RVZ6ZVVPQnVqSDNmR05OZHRIbnlUM3gwVmI2aEJqMGVPZVlCNWVPMHZlNUQ0?=
 =?utf-8?B?dHZrWStka29zVXR4VVVzQzBQMXFPWUl6TzBJYVpqK1NtY3EvVmVGZjdWTE1G?=
 =?utf-8?B?bnVYbGVLVC82NDNNUmd5V3MyTzgvRDc5b2Q2ODlvRzRMUzVsTkNPbHJ2RlJs?=
 =?utf-8?B?L0NpUE5Ga3J5MzMvQitiZEVtNVBxVzlvbGl1bDB3QTdpTG50QXdqbHRxQXZQ?=
 =?utf-8?B?N253eFhNclB2TFNZV2tBNkxpWnJueWVRYXZQaHRIYmhNUmdWajhJa2s2djRY?=
 =?utf-8?B?NXMxclBjSVpXQjl6YlpnMXhoK1RHM0VMMEtNSHV6M1VlZzlMZkJzMXp1K2Y0?=
 =?utf-8?B?ditKQ3NuQmNjVTZla3BKZ1Q4S291bWcvUFVjRzYzckFrTS9tZjZKOWt2ckRk?=
 =?utf-8?B?Z3dLNVFVSUNoWnVWOWZsL1dIQWJpeWxpZHlYN0xmSjlma2hqTkhrZm1oRUlC?=
 =?utf-8?B?aWw2VjlWVjhmaHdqQnZpeldqNmJTRHcrTVlDdG5idlh2M1FDaENwdWpFQlpn?=
 =?utf-8?B?eENaWDAxck9neVZRcWdBVnpFY1NhWXdxRXVxMDdzaUZ1NU1CdW9IMEdvZVMw?=
 =?utf-8?B?TllzeFFSakJZbTJsYUJ5c3hKTWJWTXpzNjlQWG42R0ltRVg5UWhWczByRCto?=
 =?utf-8?B?WnBydi9Edjk1RStGek9TSlNxRXRMMnQzSEhSWW9lcElKQ0dUcTNDaXdTbVFx?=
 =?utf-8?B?NFBQR2t4N041MXVYMVFNb2REZ21SWk1MaFE3YU9vbzVGdXJJang1RE1xUnFI?=
 =?utf-8?B?V3hIZjBKbGd1eEs5ZVR2eFJ5RFlmVW1qRW03aWR5czVtdko5b0NGQ0Z0bXVS?=
 =?utf-8?B?bkhqckc3cFpjSEhQMkdWTzZwQUNRRHM4MUtZTFhvQjN6Mks2Y3h1MlM3YkJl?=
 =?utf-8?B?RTMzajJydEV1SU03a2FFbnkweUdoOWx0eGdCZlorM0xYTWp2aUV4K1ZVVXVN?=
 =?utf-8?B?aE16UjV1MjNEb3lod0FTclF3eE9Ud25hMldSS2cvRWxUZ2RMMjVlWHFRZ0gw?=
 =?utf-8?B?SDNLOW1QWTZ4WkQ5YWZCbGJYcVZtKzliZkZnWFIvRHBwckJLY0drNkN0eU1E?=
 =?utf-8?B?QnhKbCtPMWVBTmd5Si9VanBYTUFpWVplNC96QmkrWTdVUnNZMjRxSXU2Z2h3?=
 =?utf-8?B?VXNWTDU4TE9wczlncXNLcmkzQVNXTGR5Q1hvMTJGK3VXYmE1N0gwaTlNY2dI?=
 =?utf-8?B?UWdCM0lWdGoyWFZtS2l5Mjlvdjh3a0hOT1FyZ0U4MEs1N25kZnY3NGtUMURV?=
 =?utf-8?B?YVZxSnBKanArb1NzRnVwOHFDNEpTd0xFSUxlRGoxSFpIRDhoUlg4OGM0Zm4w?=
 =?utf-8?B?TnpMd25ia3Q5bHVYOERiTkRGYXZ0YVVudHNEUWtacjhjdndJV04xQ0k3VC9E?=
 =?utf-8?B?RUtOeXRVT3kyaWdMdk9JSXJ4NFh1RzhIOXhtQUhBYThCUGc4Sis2ZzE5Sk4x?=
 =?utf-8?B?dlkyMjR2aUdFMnRLeW9FTXNIV0N2YStESHpWZnMxeFljc2hydmdZcnlYeVlz?=
 =?utf-8?B?Q1NVa3lCSmdqbjJrejJ0TVlNSkxtaVRHMWxPTzlsaGlDSjk1YnJzdz09?=
X-Exchange-RoutingPolicyChecked:
	eAADqXzCWixPC6JVjdWCGAfFCmspyCIkIhFiNLbaVEylMQuvrkX9AwDMrENHUkI3FDxGPOCdqwyQ8BF80b96r2cThAtfIM2Zx93F7YVgJFDES4Mdfh1KI94+OkJNiuwkVYeC4+LV6IDCIa/XKOfl2Qw7ujwFFr1MEEExKfTktZdADH2vRi/tT/j6mZ+HdcxckNGq/qN7iAqluUV1n6xtJe1Ys6UkVCLimQXnxus3F0294OYFA3vXV0Bt4VJbr5loUDvUSUYaxqoCj7jQP81IUsfP+U2D8Trcysjp2xfV4fBudMhk9I3zixU6o9qtv8mS4Yb+Yf+Ht/MBFRpBPDr5Ew==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ea5dc2-cd6c-4c23-d27e-08df4a1cedb5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:21.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uy1Ai8FyPhaBIZBR3BrQlx93ByhQxT38qJLt6fJoTBSm/iFPbVdfoUe+LC5PWdmGjKwdlgYFdckKDu0QtpYfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX/KoYqQLRnB8w
 KnOMgQzh5JIm3sr+86JU5BJaBLwZZO2i2IYgu5NM8Tsn3AWVwfqd6cuQ2wdOy3rfLGuLQgaphkL
 tEkIq9bz/NFV7yOGqbZCiHBroB9Q1rUOLBvXPmUaDwWkUU8oO3Ci3zT6FOv1lW2A3px7f20HRRr
 t3hAF6nGTu2vCh3iHGDzgh9J8TEiJcavpkFL2AGENxHZRjRU5s4+WmkZXIgctCHTsIjpPbeVjhH
 4ayc/lwAn7VxpyihBpwMeD3huY0JQNJQA0h07PxBmSZbuQyurYS0O1uN31EpafvidxrCK1czSHQ
 WcRqDEQMfdqRU/gTyxz7i9tgh4uoirwb9QVifjeF1VKe82g1uEQ1Gr7FLnQJG0hlsOLUaIlpe9B
 FCNLfWBLkG/3H/RKWJYhuNPRGebi9aribLXc/vLRIydR73KA2gwTVqDfTg7XaBATPqDVLYxkN9W
 98+i9GtcHOx9uUVe9Fg==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b0572fd cx=c_pps
 a=foOfPl9YvWvIvXDtd8Rkbw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=11eJKpf74FRv4loUduQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: 93Do2QyRz0U6fUej2M9PpaV8VnlvUsdy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfXykJwykgdBWkS
 Dh/ZjyMEorQUAEfGtsl2ykUBp8GlvdFCcF1rTRupY14PLs5XOOhzAew4z+pi9EgbrcF04Z+2TbG
 DbSOjKvEIJhhwkxFthy77IA3QBov+XXK4owXxrStwZbRbxlQow30
X-Proofpoint-ORIG-GUID: 93Do2QyRz0U6fUej2M9PpaV8VnlvUsdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

Advertise the single supported source and destination bus width through
the new dmaengine_bus_width_set() helper instead of assigning the legacy
u32 fields directly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/qcom/gpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 665d8a0bbaf8..51dd8f0f950f 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2279,8 +2279,15 @@ static int gpi_probe(struct platform_device *pdev)
 	/* configure dmaengine apis */
 	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
-	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	ret = dmaengine_bus_width_set(&gpi_dev->dma_device.src_bus_widths,
+				      DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
+
+	ret = dmaengine_bus_width_set(&gpi_dev->dma_device.dst_bus_widths,
+				      DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
 	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
 	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
 	gpi_dev->dma_device.device_tx_status = dma_cookie_status;

-- 
2.56.0

