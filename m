Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923446D0A2;
	Mon, 14 Sep 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400359; cv=fail; b=tFvtv8zpYx1T2I27rDDbfOVNuRlRROYo2cHSlVSlleUKbLfA+aYdFcrcjvzoqe7QVOrwa9TVagj4GhH1XmcCXaApEW7p0sRdoyYMIilrbjVZ4WR1lbCW+PO3oKAgCX4JvKf0344UDANl7aQM4Mp23fLuLaAfw0AXwLujzgj13HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400359; c=relaxed/simple;
	bh=eCdwzSZZjBAxAk9/XUPiVOsYZa9pTROtGT6neVQu53w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyYrOCwomRQkIutWRXiJhcjGirnHGkc+BQFYVXDNKpBRg9xXfh8u/sHFsrD8cJxcHTpvQTboKedninWuh1Z2Jnk1r3hXZCQ6OGwKEW8hUxX/tpzDJIS/Onl4z4Qg/Q0VpCmdghQfpDTozhY0TMbdFy3a+7SINkjcmLU/yayN1qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l2FC+FSG; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l2FC+FSG"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED3e4Z3175976;
	Mon, 14 Sep 2026 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Zj32T
	b0RA0Zus74Wz2dLlS7JmsQ6PHGAIlyyDswkJnI=; b=l2FC+FSG0PC/TQacfHF4F
	EVLTqD3/IcQwMI5V2w9LazbRKesLD42zgJisCwvMjZG/xmzlIjwbCRIxczoxdOl+
	eUXaR1Hd62v0ocF5GzCFgq1Ag7nKscgHNu+pCSNdQiSc1vUTYIB6FBWTamU/YKb5
	+KKAxNccj4BytL3DrDnB4fm4KQ8bloGzQ/pvkUI36p5rKR07WFETpncNxXYLIzCU
	FjuHeH6adHZLlYSW32fKmmeuJGkx0Ezbli4zg/iUBAsRqZuTkFB/SN6aP7odwcBZ
	SvZyx9a4paHf+PmlSlMBKEueYKfkgP7v7sgqL0UMZ+hRlxcKT89nR8SolX+0KgmR
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gnrsfm6sa-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 11:38:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEVuq6Xp5Ch1qzqUZHkKs5VqJk1G9kwwaL/5mqcovn8pLMPAdnXPRJPR3nNGdoXPDpXjSLg2fcMmsI5p1IkuqvtK5+oZw1L7bqg00D46uoQnaJEBlPV9USF0SZtWilrsH2pBF+61P58MAwmvxF1X85rqDYJV2tDMdrBmAh0plz5ZEcHYxfdk4STZ0L3mDc5zz1Qj+/SbRkuBuDLzms37SLSswwIaRyQPmIau+OdXBGbl9Iia0Ugt45nRhxgjgtsYQQZhRwzg1w6mRhobY//aAYEjAvNWc9auCvcvE8tiu5v1RIN0G63iIs1xwa83OE2aPQ3fssXQfZiZudqwL5373w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj32Tb0RA0Zus74Wz2dLlS7JmsQ6PHGAIlyyDswkJnI=;
 b=dHNhlMM+7ZIF/eSH5QPsYRVnVQ3Cqf3NjiZ1e5KFsRPjAPUh1M+muBgPEJ8+b+9L0U3bhtmPAak9AGZK1ps5F7t0rmTmMvM5ReGGfLEwzEkkJZiS5vXfXhFUtRx/3rfnFMnDssaP895RP5VYLagoQDijeLbm672PwQS0pIReuKyVj7G5Wr93L1ABjQKXB94nVMQEHLr8quwgbfyWhqWsv+6KArr4jpH6n9yZnqjatjewcBozt0F230xobX+BnhMfWY96FxWW/VtV3GqDMxZArLx7BJrVNC8EUVpxAEIy00jywiCSsJqAlMJZxWE3lk9ruNWwRDM26UIKECY7Zm2gRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5171.namprd03.prod.outlook.com (2603:10b6:a03:220::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:38:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:38:23 +0000
Date: Mon, 14 Sep 2026 16:39:38 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 08/10] ALSA: pcm_dmaengine: Use dma_slave_caps bus
 width helpers
Message-ID: <aqgUo4-r0-TIKZLl@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-8-72b8fd4cc78e@analog.com>
 <aqesWfdIsiR31sql@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqesWfdIsiR31sql@ashevche-desk.local>
X-ClientProxiedBy: MA3P292CA0046.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df69f20-fa39-4b2e-3619-08df127635ef
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 Nw8nKB9lWNsaAMks8+r8cliKW0f05/4EDWzvMJg5RS0tm6GnBcpFK+MRuFw6sXE8izXR2ZeP+WJ4434ymrhtOwDa3oXXr3+3y3bDBKFSBtosnxKmP875nUWeysM2IPh0i0w4DLOq+d8WWBd5bBoV+kbdGCCzdErpm5v/z1CKJtVh3LqadW+uUSiAt6uS041RSH+0M6GTtqmkbDGTY4MBpfh12+yATFy6SrvwyAggzXxyBD9mvY1jYM934UJ3uTHxu4UN/hXZUb9mKALljwCqefqVik2oq2iE6ZSQv5UiBF/lsh3M8e0zRcTksloMr9YdOtQlQYorphGz3r5HeFXxRk1yULQKqs/RR2ckFBZBvpDj+vhR2Ag/G1nfnlxcvBj1rcS1CrE5raHaNFwiJn3pUZI3cRGxL1XTjJn1DLsqra4JI9hi5nqzEnFPZZi1sd0SpUl4Hy1C8byxLcD00ubLjmOOjvXSFhUw3FAUho8Yre5mJJ3bmskyThOt+i1dWMybhjSrcorqRyorpnv6ozoy1F+PUOKkcrhaJ7tru1lpUYrp6EifhYu7aGHPan1uiI0DKk3zrYM9Zo/e1QHJeJzpCZJIivDwzTdzH8wMDWfn4Wtb1x3Jr/lwJr48zlpuLAe+zhBkUHAHwm1UATVDVv4Qb1Hurf3mBkGtIKky/FfBXB0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bnpKZGhHak1kT0UwTTBCa1JoaUtJd3FPOXpJL2dDU3ZJTEF2dmtlOWpiRXZN?=
 =?utf-8?B?RkNXVVVmSlZoNEg4SFJDaEFwaSswKzJzVld3bk03a2FIWGpvTVVhKytFUVA4?=
 =?utf-8?B?a0J0N0R2OFdvSWptN2JBT2VDYUZXY3F4ODF4QVltM3ZHSTNVdUdvcW9pbHg1?=
 =?utf-8?B?QmRPNmVIa0xzQVpKYnBQR1dmdXczNXI0Uy80OUNxeWhtcng0WURxeUdrNXVj?=
 =?utf-8?B?NEZYOHlPMUlKem8vMjh0UzNTREFINjNReDA3TUYrcnlaZnlDOWFYRWFpc29w?=
 =?utf-8?B?ZTFvbE1lcFVRQ2VheVQ5aitMZzdBRXE5SVlwMEozenJqc2ZBTFNVZmI0UTZO?=
 =?utf-8?B?MDJoMTdYT0czZDc0a0RuRWFlMG93MDByMHpOZy8vT2JDSnpHWTVvVC9JMnhM?=
 =?utf-8?B?K3M0eCtwSDNNMlVJQmN2enpaRTZiS2hrMlluV1BsMjVJSkZkc2VUd2xpRmh4?=
 =?utf-8?B?YmJqanJKbU45VWZxNmk5MmNNVitkbGZWT1c2VThSZ0ZYaC9rQ3Fvb2FpRjBS?=
 =?utf-8?B?YThIVjFJU0l6M0kzR3NJN2t1d3lJc2dJNWU4T2J3c0FlUHp3SFhMdnBZRTF3?=
 =?utf-8?B?NklrcjJpRWRjRHAyMjBLSmJMeFo4aUZoemM0UDRhNGExK3JSV0RDVXRUSWdM?=
 =?utf-8?B?dUs0Y2tiK2JlVlkwd3R4VUlFdjQrWFYvK0g4QVJZdHhQeXVCRDJuTzhRM1dy?=
 =?utf-8?B?blRWekliRUZ2NktOZkduR1NYZmFqTTN4UGlXRHUyVXRMaDFOZGZXeTB6QzZa?=
 =?utf-8?B?dUxabnRBQVFla0xNMzY1QWYzZkxMQ25qZG1HcHlDaWFzMFlqdm52OWFZNU1x?=
 =?utf-8?B?bGxrOExmM05kaWxndFVMYlpSYm1HZUwza3d1T01ZRjcvcm5wNVpDR3RtNFJt?=
 =?utf-8?B?elRCWG9kUytKQm05M1FpN016c1B6a1dMVml0RkVuK2t0Vm1naTlreERJNDNn?=
 =?utf-8?B?amQ3OEtYQVQrTmdYS1MyZU5KeEZsWHFNMXE3c3l5TTBBRmJ2aTE0cWFhRnhD?=
 =?utf-8?B?SEtHckVpRGdoS0tCeFdqTUlVVzhxcmxldDcrVWFwQzZlaU9GMUtXQUUyNmE0?=
 =?utf-8?B?VkdWOFdiTjlGM2FUMWFtL01rNkszNlQ0U0htd3kyc3RpdFJGU0FySkRLa2ty?=
 =?utf-8?B?L0h2UUFKaytrSEhUdXovUlhlRjNac3NHQU9rWnVPTjFvT25BZ1lSQkJBdk9i?=
 =?utf-8?B?UnF5T0k0SWdkb2tNdjR1Znl2M2lCYm81Tkcxd0dNOEgxLzNiVytqVE5vak16?=
 =?utf-8?B?clpjR2RRNWZWVnVpNUM1MU5ueFh4Rkw2T1k5UHNZZ1BOaVVFL0dkQ3gzaTUr?=
 =?utf-8?B?T0JVNGphbEJVbHNVTkdvdDdibk42R2UwUHF2N2F4REdWNUtGajNxcWEvYjkx?=
 =?utf-8?B?MlZxZjU4a2xUTEVuQXFTcnR6ZmpMYTVIU0V6dnpjZDlxRGlSZ1luSmprVFRh?=
 =?utf-8?B?RDJmSll4bWYvWmgxcGZSMXgxSkFtWEpBdmw1bEd5SVVRQ1RpYVFoanI0RllU?=
 =?utf-8?B?dnIzZVI4bkVMRy9oa3J5cHRRQzczWHhSSVlIUG5NeXh5c2JhVU4vbno4Z0k3?=
 =?utf-8?B?MURXWHhIdFpVcSt4dGg1VFZIajBnNGZ2eVcyOFVhTW1NWis3SHZQVmtkaURW?=
 =?utf-8?B?TEhpYWZHbnFxeS9IQWg3N3pYd2xqZmZOS2VJOTJueUs3Y1liOEQreTJQQzRG?=
 =?utf-8?B?N3FOZExlSFJ4N2dIQjRySHU2eHdSbUd1WE1ZODBVSVZOL0pYWkxiU0pUM0Qv?=
 =?utf-8?B?eVhLQUxBcU0vakFQNFlmbVpmbzFjNmpRWEMxM1ExbnkxWkt0R0tZRGVoeDFk?=
 =?utf-8?B?T1cwYWF3dkF0dzFLZTk3NDI0L1JWNXIrcm5JaCtXSTgzaTZnRzYrdy9CQjZ0?=
 =?utf-8?B?NEFLbEhFUlhiNys2WlR5aSt5Mkp5aWpzUHRiN3BvUzJ5c0xTaHlmY0NoYUNu?=
 =?utf-8?B?cXBqNEFjbDhIekVuQTdTZ0hub0t4aDhQempNTVlVQVhWWmtMb2lYQ0pUcEtv?=
 =?utf-8?B?dVV1QVhoWTFIa3R5T01EMXA0T2F1cjZxT2E0Wjg0UTFNVUFEVGFlV2IyTXhy?=
 =?utf-8?B?UVJISjNYU3dBa3ZzLzk0aGFSWU1jcXVzbFphVTNrV3VyY0RmM1lyRFE4aWJC?=
 =?utf-8?B?UWhEcUJNRUFaUkdBK0JQWnVOVlFtZld4Q0Rab2VNR0l5MlZQV3RpZnBpRSs2?=
 =?utf-8?B?TW44czZqa280RTFrU2J5RU5Tc0IzUHFpK2s0eTBUc1hSNW9mTlRBeUt1UWFF?=
 =?utf-8?B?blhxQXF3c0NJV0dZUWVmYnlRb2NnaVRJQmpjeDBFaGp0em5FbUZPU3AyU0tw?=
 =?utf-8?B?ZVFOWGxtQlVoR01kVWd2ZFA4WDZSSzNoUW03eSt0OWNCbUQ2RC94QT09?=
X-Exchange-RoutingPolicyChecked:
	zecViF59bl19fKvyAa4nqqUCS0BcGwROwoMJq0dzGslnm2tZjfIxguMHjcxgITWhlC08fojmG9xLMmG0ISBDjvKxC00M1wCRrMiAG6snpISRaPpPvJjBM8W42nS1kr9CxF0RKYi29WGYODw/CxLeYO9/q1zsQGwGUamccMVKsrSRLkC7sToCe3t2XwMbBlz8yIvWvw97+AxwMpfmDZmCRM8xubr6d3QFerxALzgDIt6eLJbf6rNyxaOkcpiOqneutuLczMzEN6D/ezdVE2CitvHQk9c1AklIqpTNI32dOVie9JNrGvtZCftfNUiT2XiVFUnjHauruzI9tNR2dGeKgg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df69f20-fa39-4b2e-3619-08df127635ef
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:38:23.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1+spONs7n6909p5MIa1+yaSVmKkT73wtijeM0cQxVEppu6uhPSc/X+Oh3ou7YA6ci+xpEcFQvHIudkGTEKZfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5171
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfX5DqhGcZlJ5tk
 wy02ouEVIErLJOy2BlU2AjZDtOKPM+ARpwMKGM6phmbLLaWkoLx5Ok4pD7Ki/YYhIb6bse63dfN
 B3HzuH4mgqudylAUu4nwjBVC7GqjV+twCavrf7b/kaIsJCdgtFRw
X-Proofpoint-GUID: KhTYlhfOJz0Om9kq_3MHFPWkfash4F2C
X-Proofpoint-ORIG-GUID: KhTYlhfOJz0Om9kq_3MHFPWkfash4F2C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfX570jj0Bbly6K
 s6HCfPtWP8R0UJKwuU+dIf1EjAk5u/gH++c14yVB1s80BDKvli1NEQVUTJi9G1iypN5E17WPgJN
 FUec0NPWMa1ahAdNH3cx3Br6YueCeU4qT5I8Dsgj8pMr0wo3E5KaT1LfyApXXryHMlPrSqfHO5+
 qWGhYxMv5aMqTc8ut9AOBO/HeBCMf4XntWgoTVdhDLLtO+Y0ZNODXgYtpTQ3mV+qYn/TV9KRMg+
 zOJ6NT+o+aHQZkgeHk5e231Ah19ZXDKRYQqLTVqSF5fV53i7jfHC1hhUHwYgMtfnrS2oI59lHUq
 zZZblDJwEfSt2jKDhh6KiC61yIdox4xSdIgKd3CpAmmb1pwjRJmw6b2d74dwnCtntT960cCb0zY
 1UsYPRKMgnH/KgEUH9t+2OAs67bgeN7kJse75EqgzRxotHQE2cU+dd5GSkuT2uSLE3S3F5s1Lnm
 R2JKeYbpxun42S0UYLg==
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6aa814f5 cx=c_pps
 a=UC1wTn8whqDYkpYF2DSMwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=Mf61f-HALDbWcgiI77IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140225

On Mon, Sep 14, 2026 at 11:12:09AM +0300, Andy Shevchenko wrote:
> On Fri, Sep 11, 2026 at 06:25:43PM +0100, Nuno Sá wrote:
> > Use the dma_slave_caps bus width helpers instead of reading the legacy
> > src_addr_widths and dst_addr_widths masks directly.
> > 
> > Keep the existing default assumption of 1, 2 and 4 byte widths when the
> > DMA channel does not report slave capabilities.
> 
> ...
> 
> > int snd_dmaengine_pcm_refine_runtime_hwparams(
> >  	struct snd_pcm_hardware *hw,
> >  	struct dma_chan *chan)
> >  {
> > +	enum dma_slave_buswidth default_widths[] = {
> > +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> > +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> > +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> > +	};
> >  	struct dma_slave_caps dma_caps;
> > -	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > -			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > -			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> 
> > +	dma_buswidth_mask_t bus_widths = {};
> 
> Do you really need the zeroing?

I think so. dma_bus_width_set_many() just does __set_bit() under the
hood so if we do not zero initialize I think we could be left with some
random bits in the mask. Unless I'm missing something.

- Nuno Sá

> 
> >  	snd_pcm_format_t i;
> >  	int ret = 0;
> 
> >  	if (!hw || !chan || !dma_data)
> >  		return -EINVAL;
> >  
> > +	ret = dma_bus_width_set_many(bus_widths, default_widths,
> > +				     ARRAY_SIZE(default_widths));
> > +	if (ret)
> > +		return ret;
> 
> I assume that if ret == 0, bus_widths should be set accordingly.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
