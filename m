Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519289;
	b=gzXJKd+P+ft3yXeBWi0T+BNwBkVy09FkpQDMbptTO2si2Gsi9aZ9c+qfz/NKEK2dtZ7c
	 iHgJY6OwJGcd6prVi4Qhwruoj0gB7f9v3rmetujBXcZ8RRQrF6QmTNaEAuqybcA1OeF60
	 C8GMeLUjHQybMBKb41RVBzI/4WlVrk+Rwt9DBkfddI5apo+K9ayc1lguXy+c6WsJEvCHC
	 NgP8xpObH3SPxXxcWVLJeAB/v098P4KTEc03S6RZTEIFactBaAIST0B6KDz2HSTWw/XzO
	 JgaZlzWbwHuMUolSAveqDkeOeUR9IW4qZAP+UQfSm4FM17iHoiduxcHRCTs/oTsuKvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519289;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ifJM/a4Ate6KBWHVKs08RDfmEwNcpRlie5PIePKROhs=;
	b=ojodIUum7GI3/+sEKXmPX9co02H4F7WAQ81V2V9ncBHwMNOZu/yA/jdQzWuHqmBPlKfE
	 zl/hL50yZnvqiYajV8D9wfiKB3VcZbTXd5aNfpM9WWoRRVplhuNPXCX4xJ/zPAcvm3Zsd
	 BqpTXkp3y4V1kec1YaQ/wkTf0T2QMnL4W9OpDE/E9dREbY3q5sWv/vuAm074hDR07Qc5w
	 oZJy16yjJSPWlgNKQNmqQDPfvUUofRO/qrnJ2beK5TZtqScxYzxcN4ZqSut9WvG8/liEa
	 9C4FIAiaLGco8zM4JLN5LgKf23gjqExoPpM/iVHK57tBFB/ZgtDz+BIOgdq8lQCMxnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Fp71BdsC;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=b+wUZH5J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AE606A321;
	Tue, 24 Nov 2026 11:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 229AE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Fp71BdsC;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=b+wUZH5J
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAuKeU3504122;
	Tue, 24 Nov 2026 06:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ifJM/a4Ate6KBWHVKs08RDfmEwNcpRlie5PIePKROhs=; b=Fp71Bds
	CWLznbMkGGX0frz++Z70XQUnqGDucDYZUejp8CQWg41HkCk2PbtGjQFvrm7ysWOs
	7S8b7/PTE3Q5bi0Dzrqhy+rK1AlyMt6/bA5pYw9nKKwniYLo2v7ZN1bUI7Wo2wJT
	xXJZ7qDao4DkCR2pNdMs2geIIYR8QVbWWlcUlo5Dqw8JPiiRdAQxCxiW9ygra8Az
	rzlHtwooCiwCfTf/GySo6X0/LtQkT4eHQEegiqwtH7/Ikke7CgYhhGS62hRQiZaY
	bxTaXm+O60C7qWN3RmG+15KnxHn8e1mMWO378WkeSWwsXXXYf9BTU68TpdPn/vDg
	XNT+BNdLubZhg5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ifJM/
	a4Ate6KBWHVKs08RDfmEwNcpRlie5PIePKROhs=; b=b+wUZH5J5J4y39gjLTGdg
	5W5sfav+EtApZuhx63nOcM4PTBNkAzMY8rFuYk29U9jLStTUIrtNxGrFxKQPOjZm
	ga8gWOAU1AhAyqpoHiTV2/Zjg0rP3pu+Ks9og9yxec/sSa20RMs0UkXeaLVQbhwI
	DYWaqnlIn0Gs4e9U4GYhi5rcZHKylTqb5HlxSgA1X+GpHbyxd+JrzZdU6ef341Nq
	PatthYD5z3mVBXF/5IgXKPQSr0UvnZ0EsCmHP1XiONr6n4YXIasxBWivudfY5O2k
	o7bllODuRQL1U6hAscZsFzYAiVLJUq/Dyvx7nrF1atMukb6CdhK3BQF08ns0bAv3
	g==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j4df4yep8-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:36 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwtPq8icdPXbiNvcDn7Q6dAPREr94bRMNFd+uXZOmXeS/BTb5jjIcPbpUadP4iLXRoPtVgpDFIveTW2Nj2+8QWAFraDGB6IZgUKgcyoduTuO4aarNdXi7qWgQOCXpbbTj0pmjBXVpwqOqt/JLGDdRzUc26stMiTUKrwoNr7+NQGx5O3PLbNEBKFU+7geOzmt5mPCeo8uZkDtZsDWP4Pcs3cpl/5xXCGWbSukBLtmoUvzzcHPdDtHDuFo0cr4pfk7ozUeAQ4unCrPxbAzwzwKDDt1HTzo02o6QyPHVfQNtwDeVUcKSPE0yGCCDlUiIcMoZ5AoCaU2eMazNOGCQYls9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifJM/a4Ate6KBWHVKs08RDfmEwNcpRlie5PIePKROhs=;
 b=KMcRdCEkPndFtzUICLKNGmvkul03tMUfA7NeTtvRJj6PIcgdBFSMdPjFnaXFWC4JfUeqDvOrCbVbiSMhby9Cb0je6prV00r5hEDjlGkLdCkaQeIlOycwedUTCt08jeEfC25PyyYEsgGUP2+U4Zd/Iw74MjQwcZ+bUMGO+E1nCSpfUBMszUSs7oCJc8I8ErTXJfDlxOcjMlU5Bb9i03leucIPaPwS+lsHVf7zyJ0sM/QHN7H7JVrqIBri1tHcZQ9kdhd1xOzI435Kgyo2R0Ll0EPBKKi5RePUPu34hc+Vef1LHmNGnEkGj/Wd4ALUg7G32QsMQ5vL4HaLERXnCPbgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:33 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:33 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:47 +0000
Subject: [PATCH v7 7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-7-5d57df2c3ebd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=2752;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=puVB45X1RKgOkGpTWbzvEAr8GCtOcmexopLzrDDS+7I=;
 b=yp9LgHEQYGNY9fjOJjOuyt6UnCEA2AfdI6ZeSA0G6f1h4mKBVY8TYLSp4LlcistBzMsVs7QBk
 aJpJibxulH3B5L9LDs93IWq+cGU+wFImNRhDtaQJRVX920mT/DiZEGu
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0018.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 86e33eda-5145-4947-2cc7-08df4a1cf4e1
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|261022113327099003|11063799006|261022075727099003|261026121527099003|10067099003|261009223027099003|56012099006|261022105027099003|261026130827099003|261021135927099003|261021130227099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261022115727099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 LZE679MolhL/+T1OR1ykfAhTetQdu6xI8uzFEomwHMG3Iu14QUxmjcNNwJxd2kkgOTLt8CWFEksNf1lpp8NKWYLjYdekF3w2eVtOJGkkP0CaOOAyXVmSSWTMDZWXnZmi6cZWDaVu/Kur/RCwNcP2b8naQZv3olbnO838NIgOLKV6CIyRKt37BaUnPExA9kDh47vvEEeZVH21aJcHqijhcdKBBnn1OsAvrAKChq0dLtSZks+hRCVZ+XIcogRtfMyPBrZLcAYiyeykOj/LTJ/qozCL1TVa6ggRk1TirLdUlcl9LXSEeUOoUzctm6wOhMtFUnnYWTchetAQwgVS0JfbBrrN5Lim60T2gFtqX08BtRBwFgK8BFbiAT32whaEjRySCixODIg+O/AwviEd62Nb2bmZOS3HZrkS+TuoT0vQ57e8ASUlC0PYmpdjUldR9CzoWcQ9UJLBaiSTZ9JI/N0UV8MV4fK/GDlt7zoe64pS79vfT68kg67WPEsdua/A3WuxoPNyVo6MFC+ZcCitS9fNFWYV0cQ/oXpdpqIE/oim3Nz6kYry3eRbYNsCIlv1ZNO6c7zm14z9n57oXdszXxSjxmItg7RKT0Kf532+u+6oPJcVNzwkAhCx3TZqzssOrmroBWDS+tMQ4J0zv9qbjbkJwuyRFcm/hoEPCr4I9onrkxg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(261022113327099003)(11063799006)(261022075727099003)(261026121527099003)(10067099003)(261009223027099003)(56012099006)(261022105027099003)(261026130827099003)(261021135927099003)(261021130227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261022115727099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WjVBcHlVR0JKTUdCc2xPanZWS3VCcTZNUU5xcW9FK2Voc3FzWUR1NjJLekFY?=
 =?utf-8?B?OWt4SXdiZzlCaFJGczd2QWhTRnBOMmIxRG9JTVV2dC9mdXdJZmpnc2hXZ2FS?=
 =?utf-8?B?VEtzV0xVTWc2TjZzeGdaZHM5bkpDZXRGc1RQdnErM0hybjdiK3I3SE1FY05z?=
 =?utf-8?B?aEphV3g1cGR5b3ZHY0o4RExrTjB3alhsY1pDRkJKVm02eGVTZ0NwUVlNSXR2?=
 =?utf-8?B?Mlk0aXBQWGgxRllGdU90TXUrUDBSY1VSNk5TVkdYQ2F5MjJlUUluVmk5bUIw?=
 =?utf-8?B?UWZzUUdwZitibHRLT3M4TUZrR0E2SDF2Zi9FYTNTd2c1WTk3MnhBa0pJWlA5?=
 =?utf-8?B?bFFWVEc1V0FNc3hCS3VMMmFkNE1ic2xnZC9xMmlFeDBJMmswRjJYdTBPbWVi?=
 =?utf-8?B?cEhBR3lkSFNMOEFPbGRzMEFQcHBIWGNCeFB6dXFtUldFTHY4clMrZWt3d3Jq?=
 =?utf-8?B?V2x3Q0RhSUJGQ21rL0Z3NnlPOS84L3RDOG5WWmQ5YitUR1FDbTdRWjIrR1p1?=
 =?utf-8?B?T1BMVDJqa1Y0WmNOc0VjWS9WU0F0SmV3MW1uRmlTYitqWFZERUN6TXZxZUpS?=
 =?utf-8?B?eXpmMUptSjkyUGVFb3NGUUY2N3ZoNEJDbmxJWDI1QW0rbnNUbkhuZ2M2LzRt?=
 =?utf-8?B?UHd6cTE4VWlXNWF4d3o1L0hMRm5GTTNZdllvaXFYZjZYNjdaVXFXdURNNkdm?=
 =?utf-8?B?SzM3N0VMeWpuQW5oWWZrR0t1MXZrM0lxUmxJYmtoUlV3RTUweTNyLzFmY1R3?=
 =?utf-8?B?WE5saTFGQzFqWUIrOFlrUTUrSHF0TElrbEZrWDVBV0FZSmVYeTlQVjZpZWV4?=
 =?utf-8?B?MEtJNkR6ZzhxTGFqK1hVQk1SUUwvdlhvSUJBWTM1VnVlRTI4ZUxjVG44aHpP?=
 =?utf-8?B?dUo1VzR5YlBHRFR4amFTRzhoL1NBaGhPNVg3MjNIY0x0TlNrbVZVNllLQUZa?=
 =?utf-8?B?cG9iNXk0b09jZ1FXenU3TkFaWFl5M05idzlneWN5V011emdQOHAxQTQ2bURu?=
 =?utf-8?B?L2RYaU8xa0xoUUhQdFZwSE5KMTArbkE4dXBjcXZyMXlVS0JDS2ZMK3BSd0M1?=
 =?utf-8?B?enlxR3BqenNUektZZ1dqMlpQeGkyTTMyYU4xc20wUjR3emdvOHl1aERFS0pV?=
 =?utf-8?B?NllzQVVUSCtYcW84dmtkZVZFdlJTaWsrMG1xSmIzQUxkczRyeHpFem84WXZR?=
 =?utf-8?B?UWo3R1NQS1kyMUx4WW1vMXIrY2dLMEFabS8rVk83dVpVWnZNSi9VUURwSDNZ?=
 =?utf-8?B?cTdGekRoY2U2cnR4bm5VRUZCR1I3Z3dUVVBaZ3pOa214cXMxMmlSanNyUDVs?=
 =?utf-8?B?ZEdzNUQxT1M2V0NPeGhtVzlJTkJCdXRxSVdRWU1qQThCa2VsbWlzVkZ1cm1U?=
 =?utf-8?B?MHVmcHRMMnNXOWVoS3F6THBiTGlDTTFZdTdVSTNQazJCVWhDdHliZXFWcHNi?=
 =?utf-8?B?Z3hBUjRMb1BUZ3lJbTBteXRWaU1LNkN0WDJCc2JGZHFwM05mdWJ4Q1BWMU9O?=
 =?utf-8?B?dHFJaFl3VkRKam1PK0d0SFk3b3pMTERhZDdOOXlWNTBqQWxXZEtLWG5uaWY0?=
 =?utf-8?B?dVNBekM2WjUvNXZIYllHWkI2QkVIdlk5RkRkZU00dUNuWmUwQnlYZS8wRkVt?=
 =?utf-8?B?WmgvNnlkMzJVV01qVk55NFdNUlk4d3Z0VFVuaHE3ais0dm12VHJMc0g5aWhm?=
 =?utf-8?B?RUNaUVM3NkFuNFAzNkNmV2Z0UVBmdHpNaEFUTWVpVm9nVUVvSXBXNGd1WUxj?=
 =?utf-8?B?eFIvVVNqa0NNS2gxWkFaZThHNUFwZjM1SFFJTDZRMUZoaFQ2WitZU0lmZ1Yz?=
 =?utf-8?B?UitoQjZMWTg0NkovTzZBQUxqcEdrVlBBb3JrbFA4QWRldGpYNXJFVTRiakZL?=
 =?utf-8?B?eStYWkVGVzg0bW9Ea2Z2SG1VL3hKMi9XbnVPVHhYVUYrSnhPNzY1ZUNqK0Za?=
 =?utf-8?B?cWU1anBHcFQrMGgxa0JIQzlJbWU1SUY5ak0xUjBsSkVXRkRqVU9MMHcrZW43?=
 =?utf-8?B?VmwwRlVERlBOR09HeWtWODNvMStNcWszYmVCVHg4MENOMUFXSHBZRFVuUjRw?=
 =?utf-8?B?cDZYWDh3cCsrUE8wRjdRTjNYNTAvT1l3MEU0VEFaTFF3NUl3cHpnZGF2UjMx?=
 =?utf-8?B?M0lOZTBXUkoxSTQvbEJRWVp1bzRRZ0tJVDVRN2pmMDR1akhwaEVnajJLNi9E?=
 =?utf-8?B?ZW90OGR5SmN2OGJIWFVqc3RxRklpVjE0TnBxa3ZRZHdrUjNUTW1Cdm5rZyta?=
 =?utf-8?B?ZG5DN3FYOGhJWVJKTXVQZE84Qms3YnBuTGxqajdDam5WV0VrUzVhSC9Mb1dq?=
 =?utf-8?B?QURlS0lDdGh6YTFrL2c4OUJlOWNlK2Y5aG03SmlpMmF5RG5MQWRPUT09?=
X-Exchange-RoutingPolicyChecked:
	n8IXkbfdbp0PTr1tqbmz+Ev6lWI2aM16fm2pSbYRu1P1e57FSNUClqJR0FLsQQJR1EsN9tkbtT4P54+5Dckqqw3wTrIftMgq9WIKR27/cOXch5aSNj5c/YJHAuEMJBCX2Sg3L9i/NyEkatTfvYGkGWptFOVC3FYErL77YHNLKB3+AoglKS2yT9tccjJwo+6gBOaP8vWelm2LcQ7siNDSVX5FvWYMePqYIQDCIANUjFxDnMHpTmcBprNdIk9ScRuD6IyN0Uv42jejbm373RdkCf+y92tM5+eB4h4M3IiizFrgz8WgD2McqNd7ZZxqPC1u9tEVMA2FGVOp1HE6raD8yg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e33eda-5145-4947-2cc7-08df4a1cf4e1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:33.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHkOmkVNoBHKYUNvDdiNJjEU7lg17qjlJhLWfYqKCgT1iBodODAkIcJzq01nSDWcnTSHjp9clC3ujxNY5nkbZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX3SnhczX5MmhS
 b/uuV97ut0YCGOYM8zE91E7Y8Va+CD2kOxfPqqpyi7/BQ1ITAnHR6Kx3zK+CYuO+76Wqr97TDjU
 ivocX00A3v6GjIUqiBCBMMj+/sWe4abwHfTgYdiU6MW3o3g5LvV/
X-Proofpoint-ORIG-GUID: RzqIYwDZ8L0Dtv4GGNOIFiP3te2UVNZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX5blsRY7PGx72
 Tdb6OjdmWn/DsZoPSEKc8bJLTOLBUHNs/YQZPO+geHNglAndwpkYwp6DROi7Vgsj6OWlLe/Vwlb
 bzwDwTTdAh6fvVHsSzp4zA09OtrJ2o07CRB7qScyjHPtx7hXipVn5sy1fxANAQpZamKkqyZh5gn
 dRI+cXJOfcf7K1xNLz6njnBy4SlaPZ8OX1K4ST9FTaajhI6KQ7Hoq6GuNDVFGnH9GDBxc0VuhIm
 FbmJs1JZCwkR0Er97AUhjViOV6qoWTPFrw1uY3OLcVHNKA5T3E+3KRmJEF/TO8pZhSvUdzYj0iW
 rcpoqXlGIPzY5JrHmXDG2wdKG8tK8hEsovn1FfdZbyipS0fhUar94FQROHdNLT9axorEyiZB0sB
 tzpfq4hfHPmH8GAplLfwirju5e9UABPrP2hPDDkRsZerIoGVZ8rQ6g9vT078/HrrlZBlAi1tNTg
 dUJ2Y6APh0Q2ZBwPYCQ==
X-Proofpoint-GUID: RzqIYwDZ8L0Dtv4GGNOIFiP3te2UVNZi
X-Authority-Analysis: v=2.4 cv=YJIKWhGx c=1 sm=1 tr=0 ts=6b057304 cx=c_pps
 a=XDLC/QdwmM9eY7nDu63Q8Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=RbNyKOt0vjK77hBBhwsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

Use the dma_slave_caps bus width helpers instead of reading the legacy
src_addr_widths and dst_addr_widths masks directly.

Keep the existing default assumption of 1, 2 and 4 byte widths when the
DMA channel does not report slave capabilities.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---

Andy, I decided to not go with the implicit call to bitmap_zero() in
_set() and _set_many(). The reason is that almost all the users are dma
controllers where the bitmap is initialized (given it's part of the
dma_device struct) so it seems unnecessary churn just to make one caller
"happy". These APIs also follow bitmap (set_bit() included) semantics so
it makes sense to me to leave as-is. Added a note on the kernel doc
though.

And it's easier to add the implicit call in the future (if it proves
necessary). Removing it, not so easy...
---
 sound/core/pcm_dmaengine.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171..c859e98e944d 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -408,16 +408,24 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct snd_pcm_hardware *hw,
 	struct dma_chan *chan)
 {
+	enum dma_slave_buswidth default_widths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
 	struct dma_slave_caps dma_caps;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_buswidth_mask_t bus_widths = {};
 	snd_pcm_format_t i;
 	int ret = 0;
 
 	if (!hw || !chan || !dma_data)
 		return -EINVAL;
 
+	ret = dmaengine_bus_width_set_many(&bus_widths, default_widths,
+					   ARRAY_SIZE(default_widths));
+	if (ret)
+		return ret;
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
@@ -426,9 +434,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			hw->info |= SNDRV_PCM_INFO_BATCH;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
+			dmaengine_bus_width_copy(&bus_widths, &dma_caps.dst_bus_widths);
 		else
-			addr_widths = dma_caps.src_addr_widths;
+			dmaengine_bus_width_copy(&bus_widths, &dma_caps.src_bus_widths);
 	}
 
 	/*
@@ -460,7 +468,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			case 24:
 			case 32:
 			case 64:
-				if (addr_widths & (1 << (bits / 8)))
+				if (dmaengine_bus_width_test(&bus_widths, bits / 8))
 					hw->formats |= pcm_format_to_bits(i);
 				break;
 			default:

-- 
2.56.0

