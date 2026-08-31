Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039B3E0C5F;
	Mon, 31 Aug 2026 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176780; cv=fail; b=KyDfXqorhwPfbGpVObvgsqHrS6TaRI1gUUtsQZYkQTgWsi4oEH6/Slsd8ilSLxLAvIStcuPHyPgb151pl2Fv2RJOjFNr1hFwKwlydLUEW7Cdbv7Nqf/4PpA5gfYR7nuz3skKLxnMasF3cuKu9nMzNH6yWuj2YrngrxHEd5NTChE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176780; c=relaxed/simple;
	bh=q3CJUNsBSo1n6GXoGzOFCX9rWXYm3swN7H03Yuiu14s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=btVno7pWLpnvSKDnZnAZyvT3PbEstCrqjgDkbvKqtAiRcF54zMwJ7pUReLlASR6GFeQiO1R4EzmjZScN53gXlQY+bivnB6nfDlq3SPSkjf3QWSMZPiQKx11cu9cCLNAybfuOTF0w6VQ1L6eVZRMS1yZwzbcOXTpSnswsCdVXyTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VaCr5EIm; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VaCr5EIm"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VB9o7B238483;
	Mon, 31 Aug 2026 07:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DcZ2P
	m1dxPNF2LY62jR5/LCb34okoVFBcjgApNN4onE=; b=VaCr5EImH0jfZCCZ/3+F8
	0wYBOePKG2TmMH/fnQx30eF0I/GIvMnBsBP4lhWeTmWavu0P07c7moVf2o/3/Dcb
	JuiqKF/7k7EzBTtM44h0Z1Yge2Yp+91+FPOZ6mGEihBtmz7JrKiRr5mIxhcx0hmK
	pcIOmtsbrKqNcke9VNzoVcRDx1zlPKlQ4PWmDugig3qPTP/xFQP1uzLA98gC1gB0
	AkwOukZlkJLRXGh6eVtq1A2bF8g8u/wnrr3FAtpM/hPSR+AUX8taARP8X5vNPtQG
	5FH8LmRQssJfWM7uT0CrM9AIT8HgV3F2rdtNc0dgv2VbSjoX6OBI6S2DRxH0sxeQ
	g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gbs68e0cv-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7LJ7xcVpvrrGbh+iy5o1ugpmrRWGwyuXriT4xIJYR5yBdcMD2R3jnJCUHN3bkc28mEBKHALSu1UiUOAF0L+U6fmJT4JkJhJ1rKsjpmIFVRCp3IeHmm2QH1CbjOBQKun6xIMxnyWZJB2dL2cggkpWEA7iEZ4gB7UD2X98FXz3o18EjEdIqm7jMXmnQD6UMbOplMMOKBjS2EmbmyHMcMhIJTOCZLtTHUA9RBJ7lUoxbW4VA9IdHQNcKXbhL+/sg0Cb3YpXGD2VVJfaBB5eDzi392GtHEmNG9Qv5wgV23sA7ZPkGA4vFvZ7Y5pJ/Om/7kmpjWAE5tijulR9GA/nW4V3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcZ2Pm1dxPNF2LY62jR5/LCb34okoVFBcjgApNN4onE=;
 b=Ysu46K2oTpwdb60re/MhSw7wOVprDzvUNTIItq6Fi8Wt8156G12j0cNR+wP2Ux4iEpVgItlHfF3X2E7bx7rnDeSPe8frVxnxuHtYcSHVvv6UcQlCv3zUwyXV9MrP42C33R7R+Zinw1vFlCm8qtaVurD4eMLORicstvHw3gtGVf/KB0s3np5a+KqMyFGZAjzpwqn0/PEc/5rfdsdAoG9mn8EWlOFg33Jw0D/HPX8VS/WFw2MEonWk4GVXoxAhpBc5fhDXbJlxEfz8jkKhRLRsWtMs+HZJP3t4y52p6GotOZtiNrA4BhxCCG0fOzvWU56pmlYK/XpUJtlvv5VrweyzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by EA8PPFB3C90C3D5.namprd03.prod.outlook.com (2603:10b6:30f:fff5::855) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:33 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:33 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:39 +0100
Subject: [PATCH v3 2/9] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-2-507d97496f2d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=2075;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=q3CJUNsBSo1n6GXoGzOFCX9rWXYm3swN7H03Yuiu14s=;
 b=YLuRhZtRXulIBh8pk7+Dv5OolIinTrAr5YOIDlnGCTFvg6GmHpqzIk6AMrC/lPlEJXn5YQ5B4
 K5ryOw5ah/JBuidmygD3CwmJwpqMKmtsbuqqCG4vY+aO3oTvVF7Cz5w
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0036.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|EA8PPFB3C90C3D5:EE_
X-MS-Office365-Filtering-Correlation-Id: bed635d5-4090-452a-95c3-08df07555d8c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 d2J4ER5AEbwNnYoD+TNezvLUTPipALoQYId/k+SzytTSU5UAmCOznoWFP2bbiT9fGfBoifHXYW3V9T+mjYkP0FOMUz9dvJ8EVAs+0UnBQdxGKI9sg8cDMF1fkftmRla4SHbIMEnd5OvDp1mgdnJTFs3eifW0x7cs5jnNhXKHlU/c7awQxhhFgICoC3FPnkgdbHj5MnkjQvbTmG6xJg4cQmK+asIPK4OsVjVsfZrpogU6teBGvMRXlYymA+/idhf3SnmghbzU1RuG8kmNwuWkJoot29XS45b5Ht3kgMQrsJDbeQAb7sELKqemGAPJHDoKQFSdAIQIAzlLjqwVNSCqH1TuTOfyGnoG9V6NbJ3R2bTVVf9IXJldF/1iMJrEZfz318cslUtp+BhK50eVBsGH72gcUYqM4HAMA/c6OghJx9Z0PZApQfQkOx9ijTJpfujKYSovmZbOX5F4+O/XNGzh9QVsMH5OLX7ZNwhRuHiY20UYtFopZZWYZbSs0zyJqIzTquk7jWEl3MV+PA2l6hLihTemlh8hM7SX3d58sE9fVbTjANlaKMhtTf71sa5XEWlLyL0ZCtREUKGQLwO4fc2JZNl7sRYsmtmtalGwJ8Y0eYJvw7BWPsmQsUGpasDR6WwFom8An1R+h+xkox/ys/6IeJdvLl886CitFtha6vFfXps=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?alAwL1lISjRrR0ZRSW41ZHFyQVlFSmJ5RUJQRzJVYWdmNUZHSk1GamJEUGMw?=
 =?utf-8?B?Zk11Um9QOE9lM21ReDZ5cmxDOUFSYkl2T3ArYjBBeXI2a0ZGSUY5VG50OHFr?=
 =?utf-8?B?TzlYZnBwWlhkc25qSm8wUStGcDBOK1A4MC8vSlJON055Y1pocTdkSm5FSDNL?=
 =?utf-8?B?NjdQTXkyVEdKVFp3TVdIMTh5cEhnM3VCOVlkTDN3bURmZWNPdngrTjVLYzg0?=
 =?utf-8?B?TW5PK2k2Z0Y1WlVsSmtqMmZjNnozL3M0MzJOT0Z3NGx1NXFRQ1h5R3BDNWF5?=
 =?utf-8?B?QWNqeE50R21TalpxeEsyNWE5UDlQcW5DcktCNTVLK0Q0dDk1eitzaUdKK3Rz?=
 =?utf-8?B?RlZIYWtJenZvK21vWG5JTjJKZ3FBU1VldWlTaWk5ZnlGR2psbCt1M3lqSWlB?=
 =?utf-8?B?elF5N1FDK0dZclpQT0FOYXNKdkpvYnY1SDBGL3g3NEwxNG5ZS2NXZjFnc3FS?=
 =?utf-8?B?cTJwZmFOSzZldXdMVmRBVTR6NTU0R3hBcGIxZ2E3RG1WSzVuTmF2TEdKdjk0?=
 =?utf-8?B?UkFqMkpHVWkzZEo3c0c2NnRvR0dqSjBkNHlmN00rYnZiY29PcTdsNkI5TlVq?=
 =?utf-8?B?OE9kdmlweHJvdFY3Qmp2b0tpUmdRVWF6TFk5cjFhcjViWjN5MDBHRmI2M1dh?=
 =?utf-8?B?VmpiZ0ZUekNLR1VnbWJPTHE2dEZEdHBQb3k3WEYzN1B6TE5mdmlVd2ZvZVla?=
 =?utf-8?B?SGZYdFNiSkRocEpiWWJaM3BJVmo3MWJRSUpreUJneDFmMkkrSnVPOFoyekc2?=
 =?utf-8?B?RkN3cG1YazJZVTBQc244UjV2cU9xdG03V2xYdnlWYjMwbEdkYXV0MTJjR2Vq?=
 =?utf-8?B?S2tCVnhlTTJURGU4WmMwanZFRnRjY2cxOWYrSUpKalIrY0RvNi81VUcyb1Bp?=
 =?utf-8?B?ckI0WGpuUlRhdzJXd3dtQzBDYnFzaFFadjBvR0I0bFRINElPY0ZvZDV1QVZR?=
 =?utf-8?B?d2dyNmM5ZUtnUW1Fck5zQlU5MGkzWkpXY3BvSHlXeC9KMlowMUtRdi8rb2tk?=
 =?utf-8?B?VCtHeStHR1hPTVhhMENHajFSekVDT1hyQVIrZHRHaTdGNnE4eGFoY3U2SEti?=
 =?utf-8?B?NGtOOEROeXFvRXFYc3llbTRGRzZIYi9aaGh0VWlpRWxrSXJRVlJXSFBBMjJm?=
 =?utf-8?B?eGVOMkNyV2RKYVZtUHF4TnZZZ1BHWm9mUnVCUjI2YmV3RytMR01DOWlkZWxP?=
 =?utf-8?B?ZlFHamFYSmNnaStieUYxSUdMSmRDVXBQV2krVGJSZnlIN3E1TXRnSjJUSy8z?=
 =?utf-8?B?eW9lWVZWZFdTcUpuWS9NWGE5SXQvN2l4MnZ4KzRCS2UrcjJqdXFzWFd6Sm1G?=
 =?utf-8?B?SWdLZy9tYmtsTWp5OGRSejVYNVp4bjNWYm9XRm9RWHhVSHUyQ0Q4TzcwTjhG?=
 =?utf-8?B?WHdwaC9WUzVYTGRLbHRSeVhYcitzMm13L0h3dzdNWWU3dnVnUUJsNVlGanVM?=
 =?utf-8?B?Qi9MTVhEejRDd1ZILzZxNmE3aG1kM0tzaHAwNFBDNWRCRVdXdzRZbEZVcDd4?=
 =?utf-8?B?dzVZNEY4NSszMUxMVkVVRUxsQkNxSEJYK04xYm8xTkkzek5YWDh3NHNIR1JV?=
 =?utf-8?B?eDk3U3F5bVdKMENtMDNpY1lrWGorcnBkZVRwcTZpVDBNSFFkSzlIQ2Yxcm44?=
 =?utf-8?B?WHhsdjFjTUNucmQ0bEk0K0pvSXo2dHFOdHVsZXBwbTZscGNnbnd3QXhzdXVF?=
 =?utf-8?B?QWFaMmhGSjM4LzBOcUxUMEkzWTQ3dk15akxTZGErTHkyZ2JtcjNVOUVVaHBD?=
 =?utf-8?B?Y0NlUjlVVnlXMytvM1NtTHdveUswK3FSMXUzUlB5SllJRDBqbzVVRGoyNlZO?=
 =?utf-8?B?VndYZENMN1FocEVzNm9LSVpQQUVaWU9aTEw5SU5VT2p0VXE3eTVCNkNQY1Vv?=
 =?utf-8?B?UzdqSHlJc21jZFNRaG4wdVZRd240UkYrSE5GTC80NWhjVFN0WXpvb0hEbENu?=
 =?utf-8?B?ZnhMYW9EVGhRcDVmM1BKNzZkUDc1SmhleFQ4QkcyWHdqbXlJcDJRRVBraVVj?=
 =?utf-8?B?NjFnS3FUdDd4V1dDRXlub0pyRUNGV1NXa3pOaWQ1WVRMb1NtYnR6T0N4MHMw?=
 =?utf-8?B?MGZXNXdydDl6NkM0QWMrcmZWaTVyMHFkOHBEU1Z4SXVGQmJvMVNMdTJDWDVD?=
 =?utf-8?B?d2lGNFV4VFp6b3MzUjdGRTRHdGg5TWlQVFFBaHY2UzNDTVNkY25CTCtWcXdY?=
 =?utf-8?B?WFliTEp6Y3l3ZWF1V29QSG1Mdkk3azNlZklLY3N5aDZLeWxRZHNkRGhoS1lo?=
 =?utf-8?B?Yzd2SEF4enJiNE54b2t1NVE4MXlaUWhwYnlGN2oyUnphd3c1WGxaVFVQTmJK?=
 =?utf-8?B?NzRMSXBNYWlzazdvYkEveEw2NVM4OHhtakRJbWFCY3R6c0htVEx0QT09?=
X-Exchange-RoutingPolicyChecked:
	MNUqz5SDZEaAJfvvGXMOinP/jD5KNSQCa+wwWwgx7tWsrrKTD7RRQ8qHYW8PGY8otywEfwm6JistFBE/QYYQRYwHytt1gM3SY7/nEdtHsrDT5TmVg4pPMTiJQmeevZepZASXLkJdoWbE6lpFIq3DAC+gQT8prE+wKEZJwhLaByoGuWZiRI21xvIPt43R/lAqqyaJNnhXQPWegKOjq26jdINlo46IoKOPdw7E5udu/y1n+SejFLkNv3qy/VhYQRvbmETwuBQVeOmS+V2sJUMEPaCHxD27mX+PmPS5/T6sEZU+0Qpw7iQjF00AW0ZeVrfoxQXnlf6pWnMIwtrrEntohg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed635d5-4090-452a-95c3-08df07555d8c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:33.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMVGQLxvD7xUXhs0+sxwoB5DrwRKh9MjIN4ArXTHViEvpFsuDI1NzyMVvbFVXNHRGuMTvgf97X3pTt5vRSH62w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPFB3C90C3D5
X-Proofpoint-ORIG-GUID: g_Y0uqRNAJgWmz4AodCYEibnVdeM7PWo
X-Proofpoint-GUID: g_Y0uqRNAJgWmz4AodCYEibnVdeM7PWo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX2GdDjcpAilQu
 Xe+xDgbbnHtU+qU4aG8BVAvmpwA6w6mOzTJIV4wmM7PfD6dl3mP4JqjCvJ/KTqCnX66Ai1QmbSx
 7VBD4pbNUwZ89poGl/Dwf+SkL1mEHclOiaX8dVuxNMoCCW5eyLGqvbgipjKy52LVyRCCNk2eMH2
 7KBa2jROKOoRb/4jRfVL4/31Ngv+/n/1WIXJUOSGk78B07nbRMxbF3X4dJoEI1LKqnIJJv0VUxl
 uI4UM+rKkK21teivc5OgAHUjlXYy4k9HkOGELJrYOwoOXlof50BOjwvqL9bX5DieKvPjgnTvtnC
 Niic7s9RI/lzAHB62xCH9fgYlHWpejQb1WrVSmKzjEIBp5Xbp81/mt8/cyvkZRe+nXy9j4wzYFx
 nA4oygnGSUyBPjqmHCmkLlbsbUTikZ48vBG89Uoir+b9pQP574v8BiwNOCrU+wZ7PfZr8imL/QY
 jO9B3HDIvTMA1cVd2HQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX1tCM+UUJ7ydt
 bKnpkaelW65u5KUsu4RMA5CebiSmgyLIByGBUF48Kyv9ctB9+sdPc7GMeNC+IKaOMUrLAQsJ/JA
 uFx8pdP5Io+Yi7sItORVgIKUMZjcqxKpal2exmyDKf5yiPNw32V7
X-Authority-Analysis: v=2.4 cv=Xcq5Co55 c=1 sm=1 tr=0 ts=6a95695f cx=c_pps
 a=TIoD7Y9874wd1wHQAFcRHg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=Qd3EMPMlLGY8qSusABcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

Advertise the source and destination bus widths through the new
dma_set_{src,dst}_bus_width() helpers instead of open-coding the legacy
BIT() mask. This moves the driver onto the representation that can
express widths of 32 bytes and above while keeping the legacy u32 fields
populated during the transition.

While at it, give the channel width members their proper
enum dma_slave_buswidth type.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d47ff27e1408..dc56178cafe0 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/err.h>
@@ -152,8 +153,8 @@ struct axi_dmac_chan {
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
-	unsigned int src_width;
-	unsigned int dest_width;
+	enum dma_slave_buswidth src_width;
+	enum dma_slave_buswidth dest_width;
 	unsigned int src_type;
 	unsigned int dest_type;
 
@@ -1262,8 +1263,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	ret = dma_bus_width_set(dma_dev->src_bus_widths, dmac->chan.src_width);
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set(dma_dev->dst_bus_widths, dmac->chan.dest_width);
+	if (ret)
+		return ret;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
2.55.0

