Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2793E7173;
	Mon, 31 Aug 2026 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176789; cv=fail; b=IHEsZFI6HjgEpZrqiaolfqenT8arzEmofe/C/UCF56goH05T82jeYpLCJ0rO0qWNn6n3B0/hwfb7W5Z2W+x/YrAwaUC2AH3678Zl8MhGw8R6azmMhdTMBFVmWrEFUyfNghjTeGPcC0pTHlQfzOOAObxFDUYCkdska1qnt0wOyDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176789; c=relaxed/simple;
	bh=B4qIspk7szggfviYfr2lyKwbei+EPFBQu6X/mXFf4Pw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mgpCieMfrNQaH/kZGq4wqo5Xqs3g8mA0/bbPLdDW+jDROJXXlsl1xThUi5HrZWk82bcE8jlqhXG8SWNk8lBn2A+B5CEAGA2an5rSe8bkeVHdUIug71zbAn+fKW+2im07RsMAB3octfgAdLhb04l/1eaF1DNJIKhfIQdHqizvZRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=c/lp5YHL; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="c/lp5YHL"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBAAxL1650004;
	Mon, 31 Aug 2026 07:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dodhk
	XB32steEVXJ3q8Ho56drSv56nxGGINiCvOt6YM=; b=c/lp5YHL0XepGBZuV/h5b
	5JEBe9zlwpD0ypJeGjXqh8IYSPcDiee2GxpdetsyP71FNfeVejbTYfhMf5ZdTUR0
	9MT/N8NcwLP6edA7aq6zCqF7Wz9gZfl1rRRetJanLfeHqmMytisahcsEkeqS35h+
	lnAVeD988zxpu9rqjzutjwnCcrryOIuZ7ltL1218UAkl0dUcRBPCBpTT66Sx04Bu
	7ZkYUuz2H/4ahjr+nAddL9MOLh5eREX+GmtKDjK12T8t43xlx25jhkxHZ+UcrLDD
	N+Z9K5SjkFWXeEjMA3qHjpFxC49DQslrsAKP8M2zo/ZzDHovW+CrSxQQSs4ZpVQD
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbs90yqh4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHzPk5ear4IVwlycrZwZ1kyebwGe4HGHLpnmqJ05uv+0LqOjazhABGO4wMzfcATEU/5zwcWuRSKTRaIEPIm98oYxAP0eGRw5GmAyPzcIhuBcqysobJXgecF854Ww2AtAmO14jsGMnQD24EOW52178W8oN01v0Otd1ScwSh63GZHmmQJfvsqoyRZCUZeCGYL1s5LOo7tJyE6c3YKbjLsNQ4UPucYAigsxJkdgyEnkMKOxAnYDHJPho9OZv87rXARw2iVLbOspiG/cOJFWAqepNVoDqui8PcEtjd+ArI997toP7vyvwPniRDgVBNhfkqoWny74D5ah8fvzr6C7l9bNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dodhkXB32steEVXJ3q8Ho56drSv56nxGGINiCvOt6YM=;
 b=f9+E3JznsNrjxmQ4snPA7oQdZ6Qp5Nw/RNHXAyLu5cpv1fNqszDH7aG5hYzjD6x0mo2KNM7rGWH893wqTBQWXBEr+V040HLS/yOCIyVYfjwjZDPyu2wDQXDtT8o33LxhVu8eYSZtUhKx3PaQuoiv2idliiaxTpGU0+H0rQpTz6Y2frBFWGGKa6n5MB5I/CuyfVYd179Ud3IOYU1Y56dSM193XFCU+/PWYtw77HRGJt+UiUG87cxORBUjAd+KnTN8zaZagLjrJQdDoUWZTmmQX0TD7YuOxiyUbUhvu9Jx4GrnSePsHw77oDPraW+zLx6vkh7iYlAjxEq0ZxveX+IpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:44 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:44 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:42 +0100
Subject: [PATCH v3 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-5-507d97496f2d@analog.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=4011;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=B4qIspk7szggfviYfr2lyKwbei+EPFBQu6X/mXFf4Pw=;
 b=eBgr4UuECbj77OmQtOX7zLDG3Wn8CMUfP8bvUZhJ6Cmfg0TiQV9tt8kVCyduibkGMnOD7zDjg
 4W+5GfMVZeWB8FhZQzZmm/c1VdMwQD6EKOw7Rmfpy39wOzNr6UNaFEu
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4872bd94-2435-4165-e672-08df07556455
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 2uvhs/RDcYuQIYVuG0n6N9PJo2UTbFvZxTYUi897ZSOlPVxaF91r9/uHaeRn3/16dMcR3p8rhCu/ovsEadbcQUh6Yc8g2wOF5mIUNKcCsmdURx5dakp3kMdWb/j2DduFMV09z9RUyu2HTnaBm7nYBHydGhlNAKrOPwdhkQIS8A8VXb/wmFXNy9MiC8fjPn9pBKsK8tpWAknRa4mM/pgg8EC9yxVez+Q9A6iW6CHx2yLkb7vbxFUx2vqJ117Zf0SBZ9zK/jivW7OUF+d3RgPsGowr/bpFGaxQ/beOYfDmP1459gtX2LnnP7ngo5+IEDQ9cOnDAaHF/hUJmltdjorubLfwE+0Hlv8lQbqm5791slRZPZvv2EW8Fr+IzdKsdwDBoH+f/RH1xPYithHtUdwpItXc5JOsP+F8IBz+Na00NRQURkPYHUB6tzPDl/NONLJfPLMm7K3q461Xa8iHjLw5DEvC4xYwjJ/KUo4kmTdpVY3tKdIfx+c0YFvtZY6cB7Jok4YyOGbBo29MzENU1b/JfThncEs4JfZ6Eu7wAfJFNZeFP1ZV+2+52CRySLxhHnQCpQ6WTV65Cv5s6a9mOEU3lvzqqa2yOOiGTZYyAttxMJyUwhQCJwPxktF1u9k9ggOCWW9cDIUyyoNG3xUNrpIqU9SsuE1FlCvNrCpcPDldN3w=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MzY1ZGxHSmxTcTlkTitsSDZRMVNUR2E0MnUrbHdJbkZuNUwyNStpNzZUcTFT?=
 =?utf-8?B?T2d0MHhnRWhLdTlTQllwVkpoeFZCTkZlcFlNR003MkpnVlFjektXdVpobjY2?=
 =?utf-8?B?eWVxdi9ZSC9XTUQ0ekJiSHVrZHE0UUdxODJkWEJjQy83TGQ0TXB6QWV3NjQ4?=
 =?utf-8?B?ckRlSXloWXFqdFMvUkRyK0txc3BINXN5M3B6dDI1cFVwaURidDBla2gwOS9q?=
 =?utf-8?B?U2JsZDlrZHBnWEdCTGZwaDd1VG1FeS91cGkyV2VnUUpOdVZZU2tvNmxtQk9k?=
 =?utf-8?B?eVZGOWl0bWR4K1lKR2IrV2RYeFZOaXVkbDEydXJvTW9vTGhhZFJHWDI4cHlI?=
 =?utf-8?B?Rjk0dE1vSXFjYzFCT3JZSU55bzVRUlRGNHdJbHJJNlRhdFFGL3YzYlB5Si9N?=
 =?utf-8?B?Q1hrRXpuU0tsRjN3OXZhLzB1ZUxPQ05RYjgrT3lWSWNnR2R6NkFOQ2RVVk9B?=
 =?utf-8?B?NjJta2ZqbCtwWlZHU0lPcFExQ3hWZ3JJZlYxS2RBbytKVlI3TXJLR3cydUlr?=
 =?utf-8?B?aGNvc1c2VUNNS2drUW15aXZaN3FqQUhaRzJsKzBJeWcxQ0pDQnUwZTBaUFJs?=
 =?utf-8?B?bHZTbW1Gbmc2dmFUNUN2M3dwUzNvU1BpUTM2QVJLaEVldFRPa2RObUpVSytp?=
 =?utf-8?B?SFJkZmlDNjQyYkNmNzUvNFY4dDVQUTVkdG8vdk00aU1TVklINUZzcURIaENr?=
 =?utf-8?B?OGNMMUZ2SG8yS3lRQjJ3N25YUVkrUHZ5Z2xVTWRMNWgwRUN5Nm1Bd3daeS94?=
 =?utf-8?B?WGtUNDVNaTZqT1ZoYzV1bGR1VFJRc1RXbXl4NU15UkpTWGY5ZnRScllGUXJo?=
 =?utf-8?B?SCsyUFI0NWM2T0dSc0k0eFpMNHBmT2p1SWVNbkdtQnRkRjQrYkJVYmlhS2g0?=
 =?utf-8?B?RldIMzNQclFsS3ptbzJnc3lxMGR2cFl2Mkg3ZDdMaW50akkzaGJ4Qzd3bFQr?=
 =?utf-8?B?U3BOclVudTlyVC82cHMvMVZ4QlNVMUl6SHQ4UllVbzRHNGE1YnpRNFgxM0ZZ?=
 =?utf-8?B?a2xvczVqTWpFN1V0UmtUTWQydzgvQ0d4UURmb1lJdW1vTy9lcEdXdU9YaWFE?=
 =?utf-8?B?dzcyMW9RZEkxQ1lxcnc2RzJvSUNUcEd6R2pYMkNLL0ZjMG5TL0JoSnBvcTBu?=
 =?utf-8?B?SERGWUJ6OU5vb2V0czYzZkg3K0dXUzkwQWZJQnZkdjl2WTgzaGRiZkRCRWFn?=
 =?utf-8?B?c2NpRGoycVhOVS91bGN1aDZmQW1VTjYrcjc3UVlFa3ZwdlJGMGM4Zm1nQU1q?=
 =?utf-8?B?and4V3hvMVRCN3FRUUkzbmhTSHpNSzBkaG0xTzNjL0hUS2hmMlp6R2VBQUxx?=
 =?utf-8?B?eHRMcjZrRCt1OHBRNGFhWW1hV3N2TVNENGNTdmVjYkdKWGx2Uy9uMkRVZ040?=
 =?utf-8?B?S3BONXp3WjBsakVxbXRMTjRLYkhmOWxTS1ZWamZIMjJSQWlaSzhPSys4YUFj?=
 =?utf-8?B?K21FWjlXUTZWRUNSZ3p5Z2tMMmp5M0VGaCt4OERvSit4RUdYTURJWHdBclp0?=
 =?utf-8?B?V2RpNnVHdytwVHdRa2pPUVhaVFN3UEZsTFpnamlNeUtGQkJzVzcxRmk0VG5l?=
 =?utf-8?B?UmhxWlJvWXJ2TkNYSUJ5WmUwK3lzeHl5enlndXAveTZMS24vb0N3cmU1dmp6?=
 =?utf-8?B?ODlTa3ozbEwzaUJBMWJWNzVJdzdNTktMRWRNYnhqZHE1eTRwRG82VytDVnhh?=
 =?utf-8?B?WFJqMC9FdlN3c1ZlMmZQZWFEeEpnalFZeUlxeGZGeWJ0RnY4NkpjR2hPL1FM?=
 =?utf-8?B?RUlESWx3eHc0cGxvQ3FFVG5EYTZvdk5LL0o5QmNjTmhzUkNNRC9VbkRuamZN?=
 =?utf-8?B?WEhvWWhJVDZEMkhMclpkcHREb3d6cWN1dGZ3aUNSVWgvZW5lY21yRkhDM0xm?=
 =?utf-8?B?STF3YTA0ZHNZMEljZk14MVg1T3BFeUliMEJWSDJHOUNDdnlzZkR4MVRHbmRK?=
 =?utf-8?B?amJJWEhWZGVNWnhEWFpwZzRZNldUTUN2d3cvT2NOSjI3VEIwOFdUVVlCTk0x?=
 =?utf-8?B?SkhZZnNWVURmWG9USXQzY3ExV1QvOCtOY0QxTk50MjFtMi9YMUh0YUdvd3JG?=
 =?utf-8?B?SVZSOE01RmxtL0RPcmtZdTBuZnJNWVNhem0yS1lvazJmWG5mY1lFbTliajli?=
 =?utf-8?B?amVrVkdCY2Y3djhYN2tGRm1hRlRDWDVKUmtFTkF2cjF2c3g3TlZvMGtaako0?=
 =?utf-8?B?ZnVlc291aUFpaFRsRUFoLzNsN24vYkp4UU02K0ROczYyc0Z2emlBSGxLOXE1?=
 =?utf-8?B?UHFwdmhhN2kzdUo0UW5MT3JWZVo2VFFPaTRySWJ2YVpWeStTWDhYWUU4N09l?=
 =?utf-8?B?T0F1em1BZzNaWkZKS1lkdmx4U1dmL3hHVzR3bXFhNnBmNFJ6R3NCQT09?=
X-Exchange-RoutingPolicyChecked:
	2N+MzRGVDnipIj8MIJJ6gsTVL2HTeFSz5Nkd0G+eZ2edDrJkmyEnjShTJlYoEfT+By80y/bpAcBySBpEmI2DOSqMuTF+zxqoMYrylFFWt1fnHdRMyCDZ5P5o0DbPv80c0f2B2oAVo+FzCW/ZuLeJuF1idPoC3VCZ0QPZlG5IaNSx2UhlZhkZ0BuSsJcktSP5K+tihVLOr37WueezxmgAUfP/XypBs4XgiS/2C/BlN8eE5s9HaCwxfYFPPEsR5QQ8E1ZlnWfQk/BikJT1FqdSThT/jKed3knfQs1u58AoSi560/soPa5xjO/DSGFS7n4iVHudo/MmpgUYKoJZZEYiBQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4872bd94-2435-4165-e672-08df07556455
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:44.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWrydvjlwJtxEnLLgqtCfA4fJAHH4BdnKRJCx9LeIBUOAo4B30m5FohqQb/cUl8gK6WhuZkz0JV1fe5z6C77Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX/LQhl8zSq1kb
 C9A3+0vNgljXdp0yE6KYrJBPY5EvgH5S3aB1IblgV2L5zxdhK26DuhHBZLiVQoDfaNVA7/rIEuv
 ic5kvuXQqEnON0wSlaVVRV87+0kvSdKoNDnuE+PzdqsfK31HJ1Op
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX671plQOCxUGt
 8MgP3sK76p6q57LzFmD5WV6RHRrf4alLNF+uevqHOFxWM9hakQEy/MojSOEnM+I6wk/4z4CEQZV
 D368KCjpslbaGwXIJm+ZgD6BZsoRRzUK2msOf0A+MTIEf/QZLv6B44qRu8QR5zypaxbMHs2y1Xg
 K3jDm/IbcbPnkss3hF6lJdq6Sei4eJYUEzHT8+GlEjXqWVFGorNwSFc4ycmU0qlngHXU8g6EmXL
 JNJnRRXhs6gwSw0UzwE+9Fd4sLRutPTjh+8J6T4OUEsCWiRkT4wnfiwjbWrb6Q+RRlmOfDCRWY/
 +aiWMM64uL0yOG8fmB0l9pfboxDcdEajRVMTXdX84wsHYxLTxQvwMhQ5PKv4vIHbuuWSWB4TKxB
 1BvPvksFSA1NtICg4q3IOhNzZmm1F7I8lwKgeLdvgC1kEABlQ1sgrjlYYSdHBSro8Oyj38NKwZJ
 VqksgUrNAPNIu82/FuA==
X-Proofpoint-GUID: _5iAB-eGafAszVl8CWrpVHHxOQOQgj8-
X-Proofpoint-ORIG-GUID: _5iAB-eGafAszVl8CWrpVHHxOQOQgj8-
X-Authority-Analysis: v=2.4 cv=c9Cbhx9l c=1 sm=1 tr=0 ts=6a95696b cx=c_pps
 a=jKN40M1qUjEArv1iOeQWeA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=E3Qj7MYm3CVYKzQ9U5cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

Advertise the controller-wide bus width capabilities through the new
dma_bus_width_set_many() helper and clear the per-channel unsupported
widths through dma_bus_width_clear().

While at it, validate the requested transfer bus widths against the new
capability mask instead of the legacy u32 one. Besides not depending on
the legacy field anymore, this also stops BIT() from being fed a bus
width coming from the device tree without any bound check.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/stm32/stm32-dma3.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4724e7fa0008..0689aeb7cff5 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/init.h>
@@ -588,7 +589,8 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 	dbl_max = chan->dma_config.dst_maxburst ? : 1;
 
 	/* Following conditions would raise User Setting Error interrupt */
-	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
+	if (!dma_bus_width_test(dma_device.src_bus_widths, sdw) ||
+	    !dma_bus_width_test(dma_device.dst_bus_widths, ddw)) {
 		dev_err(chan2dev(chan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
 		return -EINVAL;
 	}
@@ -1469,14 +1471,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
 
 	if (!chan->fifo_size) {
 		caps->max_burst = 0;
-		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
 	} else {
 		/* Burst transfer should not exceed half of the fifo size */
 		caps->max_burst = chan->max_burst;
 		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
-			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
 		}
 	}
 }
@@ -1734,6 +1736,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	struct reset_control *reset;
 	struct stm32_dma3_chan *chan;
 	struct dma_device *dma_dev;
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+	};
 	u32 master_ports, chan_reserved, i, verr;
 	u64 hwcfgr;
 	int ret;
@@ -1775,14 +1783,14 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	 * channel, and can only access address at even boundaries, multiple of the buswidth.
 	 */
 	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
-	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	ret = dma_bus_width_set_many(dma_dev->src_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
+	ret = dma_bus_width_set_many(dma_dev->dst_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
 	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
 
 	dma_dev->descriptor_reuse = true;

-- 
2.55.0

