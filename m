Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C444AA1FA;
	Fri, 11 Sep 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147788; cv=fail; b=CbL7O8Dyo2p8iqHCarbOqsRyovVlJNYD+mN0O4cZDdO7g2lE3GdYT/2rcEdp7oxR8G6k/JrFCP2EdzBn9daauJi+MVnTUDKG16FTnXhnxm0886lzBAiTm5iK0oxknOOwdgU2xlBA1x2bXZTKeoFVUdVP/e7hCuSYFSpFaCo9vqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147788; c=relaxed/simple;
	bh=C1suLkDVyeodvS8GGrnNEkOU7Luo06K7ULH4fxxDN1M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pShOemhZa0fcEpNBW39zg2+EBX+HbjK1qW5or+gnEMXI7OMDJD5V7s4sTLO1puGklNrX1co87/VC8AZa/oyMwuJaNP0nUZy29SWtEvWyCviJ8yRKSY70Zwf4Fa74484nDLCIqP3MQs32EWM8+NoLs2V4v1dV4p2eHbaENDaG/CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R1MyhUEe; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R1MyhUEe"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEjjDA2377849;
	Fri, 11 Sep 2026 13:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/SewG
	vFrNnAacopnfB9NH4PMqMLk/0SSFZqobVAZwoQ=; b=R1MyhUEe6DSmVO5Y5bGmL
	hUb3Us+lqA0y5oM/0UI7X6UQoiIAsihTeLDXIs1GQPwSubPi3gIsMoOf1WNE4+lg
	q4l6ks04dDwuK70RUodEGkSSbtmCtYzPRGfCJ7FjTBvftB0SaILx8wo+tllZpPW+
	P/u19/N9KjjDoe3YfKtW7HFSO7KP9oIZCZiEvPrrWXogN86CGuoNNVhl8Avq4t69
	7IhAjvm7gwtjlED1Yo5zVT5juRECX7tIkrPT28zEDsuOyVGlLN/qh43rGjOm+JkC
	crIn3jECEn8t4a3qKTN4s/H6NCWFObTSxchatsGioQcPBMwONQgOiRj+cbofhzmG
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxaj671-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:29:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO5XsUWsprhX2Rz48FSnKH1DK1FPfVR6Vjplg0+4Z7/K/BPdshEcEp69LQRNuO+X1DWjXxujsCRNaF0oTf5NCKeKh3XA2LUmRhyDrWk2UeAHSmgDm1kTdUiO6MW/thkeM78gXnoPw1x7Ov5u4SB4OCwzDQY4MvLHpPZi4oSZEsnMW7LhfFWCQG6tLuVD15StoSBG3kIJj1TV7iGCBdOhoae2x+RiIBiTmVE+vYpBSOdWyxsdruGzQJvhS0uPfkQXJB72CmfvM4kAJwBQX4JdCk7of2G0YPnVtiZdNNPbl0JodVwVT/nem98eR3aZfVB1pS3TqDm/gS8tov1DKrA8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SewGvFrNnAacopnfB9NH4PMqMLk/0SSFZqobVAZwoQ=;
 b=N6GVb6vXSTAW70FCEFkA/TbEa+iXaEYdlVT4+jwAjmkZsqKweVD3J0ogoeyMD5WtzFkF7IJ3l/makRv+ZLZFeTX5PPaXtrnufYsQcePxvv99Q2HahBVAZs4tHOWALFiHjqhWC8QmK24GxgVI1Ica525foz8j0fZyM8Cm/oaMapA7+P3MUwSuCtVTmaepEemOsSddNpDpNTHu/erK+CtqTfXAYEdKjK8ZdSz1wHJgKdXdpSlMionFdkGBLjFJJIELENlWqsbNK2yd7yB3qYYc2NTws0Vn7HNIWqcnxh9e34cLyh5G+Uvr+1F/Z0zOpitfgs8btrDtj/uxKtsojJ5Umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV2PR03MB293829.namprd03.prod.outlook.com (2603:10b6:408:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:29:07 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:29:07 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:41 +0100
Subject: [PATCH v4 06/10] dmaengine: stm32-dma3: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-6-72b8fd4cc78e@analog.com>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=3976;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=C1suLkDVyeodvS8GGrnNEkOU7Luo06K7ULH4fxxDN1M=;
 b=ys9gr9XoZsyh4wl6f18XPUIcBk7bi0M9TwglApHZ6ZZtAnpKc1F1sTit5pDePPlMcrXgo8W5Z
 VS2TslpDx5jDxQjM9oSCJ5U2ASV9HphViw3Uw03aiIr+vox8bQ7KgTw
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0098.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV2PR03MB293829:EE_
X-MS-Office365-Filtering-Correlation-Id: d326c553-2518-4e6c-3fe5-08df102a2ee0
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 YHHfl85BqoBfJzcwbs/+I9+MLWBUKsbt7DFulK7IP4BuUGitKgVO1HXV374uhwk3GHMI444H4iB/q74ypoREQp5iiquLFzwt6+OZwMltF0CFKTQyvF56NBbzjucRqycXv5ANGX//3HQHeW7A/lpCgptlUZJHJ91CCO6tNZmRdQfYxjijnslNf6w1urB7wykSfXAdT+ew7ouGpWMIEOD9mIE9gc6rtXANWz0EpqBPeV+1FT32r71nrcdi6wVyiDpGtE4udxz0VES7ietqa1kTmIc6jOxX9mCrje1OFmlrhfnOnZ6qvelnCoQv82uH2wSiZoOH6xctMiYtY1S15RlOZoiwa93Ci0wRFrfxDOU4ycjItkMeC1LDKuWsaM57cWPKvaVFWC5IGzkI07PZnLF8sklpo6usZEyqniWHbTpN7Mfop/Vk/7IDBxFt49UX5UkfTkGv2RnMjFr2ksyN7lXLsKENZjgxycZ7dxOif/QTrNQzvWkYOo2t9ACsqPDC8TATZ0XVRcCZXTBIndrkCsJWuOt4qqgRDzm4RGhH89z8pyK26HGvna9C0FCSwn9Gc5BSzSr0yS3PvwwdwmzN+FdN4eLkhNrK8QZhIFDMBuAfxjTmZL1IRcVaa2hd3zs9kkx1XY7cCY+cxwQ8+hXE3CEl1cfb+G6KmtAKKezRjPOr5Y8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YmFiL3V4UkJvTUo0dy8wVEJUYmVRZ3dwaThndENsVUJTTHB5YjF5N000THdO?=
 =?utf-8?B?V2s1ZStocUh6YWRkSXhBK24xd3dJRGR2akdKTGMvNDdZODJ0M0NtdjY3WVhw?=
 =?utf-8?B?a0dTQnRneGlQVHZqUWdla1RPUHg4WWJxT1g1T0x3d3o3Z0NGSWdpektiTlVn?=
 =?utf-8?B?aWUyWUxVT2RjUDUwZGlIaU80TmlJTGd4RWFFaERvd1A5M21JWndLQUtOQlBE?=
 =?utf-8?B?YXltWUU1Z1l2WTkrTjRxYnZrb21OM0VBeDdnRXExTG5QSkNGdDc2NnZHS0JM?=
 =?utf-8?B?VWVKRVBVWWRtMHBzNitOL083MzFxd1d6NFZSallUc0NEblNOM0svVk1mMGc3?=
 =?utf-8?B?M21hcTlwNGpUQmhmcFFabkxUS3hra3hIOGdJczhkQnRBbEN0V1NnYnV2cnZl?=
 =?utf-8?B?djl0NHVBa2lia3dscDlMZjE3WmtzVFhWbVNzWjNiMnFRdnIvblp2VDQxOU00?=
 =?utf-8?B?NlhrZHFyTlVrT3A4cXUwMnpqZW92dXdvNGpxMjZYWXplS3Vzcm1GVjljM1o1?=
 =?utf-8?B?SkRwUzZaNjBpN3dqYit0RzhvUkg5MGxvNDRCVGNjYzZhMzhuVFJOZUtvWXRH?=
 =?utf-8?B?NDBMYXZHZEExbkljTlJmc3hycGVrdjI1enY4cVdrbTZDNk8ySURKN0RiRW0z?=
 =?utf-8?B?LzR1Z1dVcDFnblVFR0FkRnFPUTRJSFUrTTRJejVsbUtQL3hjTnBxQ3U5eENw?=
 =?utf-8?B?WGtkNWNuMW9lSFM2dTc0RjhFZEdvREJIeXFzVUhqWVgrb050d3NBNEVla0xa?=
 =?utf-8?B?b05nVlRLR1dFblo2dG9uSklJSGs5eEhvS1pId1RtcFRUUXhmRVZXT3pXQ3hu?=
 =?utf-8?B?ZFNDTmJBVUticFBoQmNIekRjVjMxd2p6VHhDV1I3SWVkTTBRbXU5ODZoeWUv?=
 =?utf-8?B?VkJpVTBNaVpPTFdsYkRUeTRaUkdtNnRMWjdYQ0QwYklzM2tJd2YyZ3gyWlRz?=
 =?utf-8?B?TitlL05lbkNJYlBwTXVQV1hldXd0ZDNYU29rWHZZQ3pnL2ZLNkRocWRENkpj?=
 =?utf-8?B?czJKVjRHYkV1d0VRaExDaWx5NldRQURvZlg0REhLMVN2WlBXZXNHZ3BkMk54?=
 =?utf-8?B?UUdWWlA3TlN6KzhHQUdkbzlWWGZacEZFRHd5emhLdktZb2JzZG0zUmxuOU5L?=
 =?utf-8?B?cldGRTU3NEN3SlFEbGZhaVVWbGREeHQ3OVczNGZSWmFlQ1NpM3I2cW0yUmRO?=
 =?utf-8?B?M0x0cmlvWDI2d0J0NVpxQ2YzZmlEdDg1VDhiaE1SVFJSMUkyYTAwRlBxRzZv?=
 =?utf-8?B?VEhuUVh1TEVZOVNkb2oxZmpXUlJFUEhWVy9FUXFUVjNIVkd3VGI2R1MwaXlU?=
 =?utf-8?B?bEU3TUdlekFYR3N2WEdYbENoUHQ1aEw0dXl5N3RxcGVPZ1lpL1Myc2lQVUV0?=
 =?utf-8?B?cUxsVFRxQnYwNEl1ZzkveXNaekQvZzdveUFiRVhpbEw0bENQZ1dybWNZRDBU?=
 =?utf-8?B?Ly9jeFZHREZpS1dJamcrS0hIY1JmL0Q2aEZBOXNSU0VhRWxFaDFsMVJlSktF?=
 =?utf-8?B?L0M2U0F2Q09vUUdWRDFyV0p6ZFBhN1g3Q0hYR1BoZkdzVHk5aWNMdXJheStu?=
 =?utf-8?B?SmV5aTI4OVl5TmFPVTI2emI2OER0K2dNY2xWTnkrMGpyZk9JTnVGTDhEckxx?=
 =?utf-8?B?WFZFUlBWQXF4bUNyb3dldkMrbVR5a0E5MlVuTzcvckt5aXBINkxneFd0ZEw2?=
 =?utf-8?B?Q0xmeHRSSzd2a1Z5NkNCeWRENWQxRWZub2ErRzdoWVFpYlJtZkRTOXJ3b3Nt?=
 =?utf-8?B?cU5icDVUSTNJbktuUjhhdlBDWWt2VDhUQWtpSGl3VDdnL1RrU3RTTHRodDlB?=
 =?utf-8?B?NVJtd3AxNmtlZzdCNmh1T093b1JtemlmRVVmeUt5WUphdTB6dkcvSysxS3V5?=
 =?utf-8?B?OUlBdjY1TnlabmRtblhKaWtCbVBmR09NMHUzRXZOUStLU05WV1FLTWFUeHRu?=
 =?utf-8?B?dTdkMGlndExPQ1RvNWxYV1h5clAvOFY5M2hzTVhNTHpCQ2gzZXZpaGlnYmpw?=
 =?utf-8?B?bnk2RXB6QnNYUlhEOHEzQmZoa2c3TXlVd1NzZVFjMGpnVkYyWUZ4LzF4OUlj?=
 =?utf-8?B?N0Vxby9TNnZTUXVHRWdlT0hFMGN3a2xVbXRmZmlaTHVDcnBLbjhCUTJ2a25K?=
 =?utf-8?B?aERkbmcrTFNlUFYxMVJKR2VDd09NbkdmZnhSYzRzNm1GRUF4MWVsdVdhbHN1?=
 =?utf-8?B?NXhocEVRMUxKalJOUjBWWWIveXNSRVN4dGw4enZ5cFFnOWJwNmVaT0l5aUlT?=
 =?utf-8?B?dHFuQUlxbUREaUVLRE9VYk55TUcrbnZ5VDZjREE3QXJHQi9LVnpEdnU4ZGJx?=
 =?utf-8?B?K1AwN1VDYVlGMWowR3ZlYXVSUWFpbm55eWRXV3dLcjV3R3lJWWQ5QT09?=
X-Exchange-RoutingPolicyChecked:
	qv8zM/+58QKaBRpIlL28XiGBbVKFiRmJsKqvrZ+S8WmB3kQjsY0ZyAJIcMo+bvFi/Ay1aGcbfUi8mX9Er250iX5ron1HDfWOjHDwP84kL8ZpuipEbX6Qk6PszuajYOZ+/+1+7h3sDNkiDUpcbTvKV117H3BQT2ojVf4pUQdOK3VBIkjY5LEsgVcNJ6wskVC5dBRgoxsyagYPUHk3wExV9Mgq6NW4HzzzD/nd0/8QiViVxFLRrBLenQyT8uzupdwEl40tqkhWDzjmS0jXSJ2DBbRNRBd8WoSyJQYJclmH2WVQ+4730MQd1rI03pStdxlSv5ow5iwaV85m0sOrfRjIXQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d326c553-2518-4e6c-3fe5-08df102a2ee0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:29:07.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTPNY/R8tY5Ml76ElUzxum1GwIdPUy4i+IEf9dly9Xykb9NQ0qEUYuZg07Y79GddakjaCkiLoMd3SMrz+VL5Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR03MB293829
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfXymD8Ipi1bB4T
 eE/9K+NK0yklIZZCki9YHOo0xLoQrh6x0Xunwq2patyWgjVKgBBX5bRHKs8l1Sp0cZ5oETtTdHQ
 jMaZ6spY8V3XiVgbSSNE6EJlJtTNC0wizX4yeizzlF+DrANzmb69
X-Authority-Analysis: v=2.4 cv=Ao17T+9P c=1 sm=1 tr=0 ts=6aa43a66 cx=c_pps
 a=vMZ8N8iCC09X6dpNzQs02g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=8AirrxEcAAAA:8 a=8b9GpE9nAAAA:8 a=gAnH3GRIAAAA:8 a=hoLHniV83FUdLTyWGJsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: hIdthm0y_x3Tqdw4BvHMYkX3unLWsPam
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX5IDmP66s1Ahs
 GCLtway7qRyqMv6UseX8zkVoBprO73zn8HsUqlEfs7msJ4nhpXCSyPH2WUyUQmysgZ+kQxMZbB6
 +4QJm1hMoeR56Vkg85QzTxf7G6yvdd+9mGd8byTdfaB5njOikZw3Vv/3eJoowFAECaHAlrKOeCB
 eu7ckSTbsouOiY5I95qHT8i2LHHws172aCbNw5FTqCBaD4E52npGrh7qaPWSQo7mgXyYPD4rgwh
 52OR3JoCbdZA1LL3U7nLMZWmLBK3V/8/tNPon7+kvAHNRWqdvyseK0snvS3X44IwjEMaPu8DOxQ
 abn89be3raoTexkAL1PjRKf3+dzlxS9nPPr6CWXatCR4vJwz0gvtp0h9WUPiM5AVgBQHmTyk8Hj
 mmXY6nvTDZ/oa+x/IRgzBtOGFsLjyP5iko8GHksxaH71c/AnfVkniAnGmmJw4KBkjGV6Q1CHjcE
 wCvpIlW6hKDg2XzGKXQ==
X-Proofpoint-ORIG-GUID: hIdthm0y_x3Tqdw4BvHMYkX3unLWsPam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

Advertise the controller-wide bus width capabilities through the new
dma_bus_width_set_many() helper and clear the per-channel unsupported
widths through dma_bus_width_clear().

While at it, validate the requested transfer bus widths against the new
capability mask instead of the legacy u32 one, so the driver does not
depend on the legacy field anymore.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
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

