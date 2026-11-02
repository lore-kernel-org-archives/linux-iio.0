Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617081;
	b=BbVY3x22b8DRsC1PyvG9T17Ii6GPjN8/QWR50i8/yk3nnJLpFsJJM8O5pn2iffETXBz0
	 X4MoxL5hKlNi/jw51Cn9Q5di3I4XxkXYCIozzx+zsWS6GhDJkUPP+UFifrrE22vRBRoKz
	 6Aq3by3ELKZAYJKDAlI6SyvHikhmpIJBHFVa5NKgLK0cbWgWaSanW39rHJf4vuiMspUYx
	 +vBtnfjs3Huzl1Vciq0MFRfCDx4lsi0SZ8Re8ye/S5+3P6AiGv6oE2sekaXm3quOMfrTR
	 tvoN/rV6Jk33e4tbrHHDH56G6t2FZwIMwJZ4p47A2Xc2ZnIrVLZrwYai/O2n7YuEVQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617081;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=V4WGAHoY3KXeccmYxyDBSYQl8eeEq9A0LufxzF5+VSI=;
	b=cQjA/ix/AtCTH2/dl1H4suyIMOPeF9Pkhl3Rt6/THJT1MtpIZcnky7EZHAkFnh1TCed9
	 6Qd3to9nqF8HeuOYSVKics34YMKjGJp+r3CFM29dGlPB1gX42rRvHMij0vrPuaWvKL6Wg
	 xLuwXQsakGSoT6J4rphh/Pzk/nChTWDI0Uo2dyTfcwRgBySE0F72XxF3GMy3cVF/TneWZ
	 2MhkY8dhQk+b03bvpIexXkmy0ghP69JS3S1PhrtfWzR5oQ+X9+mltIKfB+ON3MxR548CF
	 Q4YnRoZIDuXQSJltozkVK1qpDTgVrZ7R8GPbLxiLzphTfo53j+4FotvULJRR/n3wcpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rTeedFf8;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HUkvTFxi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44C606A327;
	Mon,  2 Nov 2026 10:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F44C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rTeedFf8;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HUkvTFxi
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29BO943273352;
	Mon, 2 Nov 2026 05:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=V4WGAHoY3KXeccmYxyDBSYQl8eeEq9A0LufxzF5+VSI=; b=rTeedFf
	8dBKxOOuvgv3X2uKERcxD1WIMAN+2TuO2xBmcEl2GGHRsFXwfBLEo2TFJlz7NC3U
	w2nnwt81UAJt9S8aegEQ3p1SxO6gJgD9I//PL/QqDU7tMeWEcQ/cTaEbyxYrNpQQ
	w62ny2yYwXx6TW8HCvTiI4E0hGmkhDIaO6j2VWbeBF4nqbg7+hO0HN2B0Rp61CzG
	5yjwEy3IFevotDWO+H59ibKOo4pWr9k8M0KmzUDmzFSWROHwft223uQdDDcoQ7UW
	cmdqGvWuC1aXCAQ8wIK2Bg1gZZbz/HfcHIy1Kq1KWEdRPgs4aRST8XYHup2ZNfOO
	VEDPPyabhC5S8SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V4WGA
	HoY3KXeccmYxyDBSYQl8eeEq9A0LufxzF5+VSI=; b=HUkvTFxiv8iNfbQBQkkwm
	s/ESUO2BmIpKX0ltPO0aH4xkbcTHZiLMzK2FJw//JDDBO5yNOiGnCYP17DUMuH9N
	EbpRm+GCV1Zh7LLrj7c/voqp4FGKROmmgnBRbt3dVZP/BUv8TMo7yxy4LBEm5hKu
	Y1dwIr5rk2lHMOX5ixixMGVR314WJRq5HFA3CRfwvnP9sqSmS5qe3CAg24AKMJ1A
	7d/I12B3qamSxIfy4muu+hSm7o5lbuski0sjFQ0qeBh+aK7+pZPTVp6aHOnpm8aY
	bYlAhVBCsIkVrS5xmoPLfZIBKPI1sHcoY2HexuTgZgRIts22/ZEFb2JuM5jlEPo0
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hpfnkaar4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 05:57:42 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk2lKxvkBJdh+FUISVOjFw0RJ2kfjqbriZfwPHf1Dxs9GANCtRiSZR1+O9wESNWl9ZBBtqoWdbGy8NO0UY3RudqxvVt0hDyJgZuiOyRXPZfDUsQOL3y3eP1eqLXlvQEngAF5O18e60EWTa4JBEigr1Q9IzjVuQwtJ/dW47F9oiJE7A5u8ewTjqQx1MfkYDH2IWH4MWYeeG69chsoRJcVih7WweM8dJhV9f8/afKDarNwvVGNnrDIJr4P0Kl//yK434wvAs8LsZ6WMONkkpg1Zq6WaYEKcL9fFFznRGvheY5CAdSgSHlz43M6f9H+uwvmRzJ5jw9DMLIKqIVdF7UNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4WGAHoY3KXeccmYxyDBSYQl8eeEq9A0LufxzF5+VSI=;
 b=bMhR0AtA8nfZ8Yqk/4Ku7D1YtWIdcMoObi5nJ4Zp/b9S7LuspQ6eu1m3ko/9oRnOP+dRYdBy5x2tOedwIjh8LoOG3phY2EOnvchTCcrFBbErYw2NdRxZLf0GLewO1MtwvACN9fRB3n0mxPD+n6hzFK4lnl1PW33BfmNfvQpxv1IZKZrkQsFBAyomyD39pziYLuuj10KyNkElDdH1RFEH0Y6ooB5so1MOT1Xntp4M6VTTCCIr7IAAfWY/XgrsfvnLse7JxdmZMMY8uP7JMkbPkjo/lVwerv0VTOPuVA6tkBjeeL7SaVAm0rXQcfDCj1M+SuDD0fpTuWyJB9OWvwU/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SN7PR03MB7086.namprd03.prod.outlook.com (2603:10b6:806:354::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:57:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:57:39 +0000
Date: Mon, 2 Nov 2026 10:59:02 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: "Sabau, Radu bogdan" <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux <linux@analog.com>
Subject: Re: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Message-ID: <auhszHAlMwT6WW2H@nsa>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
 <179336921877.155032.13465457472017394020.b4-review@b4>
 <LV9PR03MB8414E62A0A91DEF6FA4C6D80F76A2@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV9PR03MB8414E62A0A91DEF6FA4C6D80F76A2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-ClientProxiedBy: ZR2P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SN7PR03MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecf1b05-0dc3-4fb6-5993-08df38d01c9a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|4143699003|11063799006|5023799004|56012099006|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 InEu1SQg0eQkMRabHzxH398u2UykSMxv20HgJ7G2kwbQEnpedffpDKpKXtWjtkMwAgqKgzjRTHMC80EIRoOJGICA6v+YQNNkmyuINRdDULUphTLvQRdsuvy2oWibmXNmn96tnheB032gvJBOKvQkKgMRM6fb5IehtGq8BUjzOlHZrrDHLQYiZj3QRIhIeySoAhVRFVIE6s/c39VV2KTfZEIfTHz8p5IVWI9LwAS6XOJlAu1ltx2k78ify6zrLAiYwCJ6ONmMPT4ae0lMlcscDkTeDdlY5hSSfghe+nljltayfeE5Smg7T94SqiFFi34akwYspcWOE+T6WMQVyq6QDbG4BJzL5m105T8qML8jsHlROCXseqbpx1YXTqcri2vwscHO5MaSFTYVghAH7/uiPWtRlAYTaiySV4gIbdvU1j69EvZb5UUTvwuvDHVX/X31WU2kX9mNWyxcIae74ywID42JgJ8mtYxfYVNZDVe9ln21Nv7qREoEfKdM6M9bzffrxpakTuUCbRmREZP7zDQGjGicO0tFT9eFn7dKcumFVc1OIlqzcvQ0jkX/sNRY6pjPyCkNYy52shDaJtVFuutukQUlIAQrOzuS4lofAlPjJntGUFJGUnhF2yze8IWr7kwAi2c+H19wgja7KaaOnAhFIQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(5023799004)(56012099006)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WFNmaTc3VU45S2s1YVBvSkpsQm0yeDNiT0FBbWpZSEQ0cWVTN3RjVXNTcnZ0?=
 =?utf-8?B?U2UyRlVCZ2FVRS81RjJyS0ptemhXYTZ6cGJ2Ry9ORnFxaTc3b3N4cjRPN1Jj?=
 =?utf-8?B?TjNhdUZBQlhmMHRpWStzYXFkZGk0dG90US91ektwZTdNa25XcytjTmNKOG5Y?=
 =?utf-8?B?UjhtUXRaL0xBcmpEZWRNZjdZQi9FN0F5QVJDUzBMQ3F1bzFHcVBqRVBQUlQy?=
 =?utf-8?B?akVVMjA2YlRSY2ZpYWpzUUJEejNjNmkrZG03TnN4V1VDTFBzV3BCZGtZSm56?=
 =?utf-8?B?NXhOdVE3S0wyL2hnaGRncnBwVHJiU0dKVm1WZ3MvWXpFRTFPZzNhYU1oaXBj?=
 =?utf-8?B?QkJDYlBpNEU4b0dFT2J0cXZjbUdVY3FFNjVhVzBFU2tnektlay9xazJhRCsz?=
 =?utf-8?B?Z01HcHZXb1IyUVNacis0K2pubGZiZkVSUHgrYjlObjh6RDNDeEt0Ly81Qlp5?=
 =?utf-8?B?QW9qSUNQYit3K3Y5OWFqQjNac3pDVFZVWkl3UGdHUmtaYTAwMFI1YW9ITzlD?=
 =?utf-8?B?Q0FZTG5Hb1BraXduMGhVNEptQ2ZDUUdKaUJJanNKTDFNYVoxNnBnaDVqTTEy?=
 =?utf-8?B?ZWJPcHBxVE00ckFOY29UQ2dKdW5XeEhVT20yZEJEVkdyeE43UUkvRU1OUlp6?=
 =?utf-8?B?b0tvYUJsdEZORUtnT1A4bHF0NWtXaFU3aFY4NFZlbGxmWEVHOGxsMDlzUE4z?=
 =?utf-8?B?RTNnemNVNWtaWHhkcXZaL05BTDUxbVFqak9TNTcyL0xOVXBGVUwyUWZ5RVNH?=
 =?utf-8?B?dzhKbnY2Tmg0MWpZZ25OWUNtekt3VmNsQS94L3RQVEJUSHhaVERsMEVGK2Zr?=
 =?utf-8?B?QUhtVWxYelZIY3BKRW43ZWNUemtwOVp6ZUJRYlhuYTUvdCtreWZtcmNQSmRR?=
 =?utf-8?B?cTdVWGVpZVBsb09WWm5wQUZjRCs4RmZvQUtYaTA4NnpXSlBRWFMzT3VnOFkz?=
 =?utf-8?B?WEhKbUVzUi9VM1JvTmU4QytnenMrK2lPRmdwVTdoU2ZrS0c0NXZQRzZUenNp?=
 =?utf-8?B?akxreXVoZWl0NmFnU3FxQnBaS2tpblhPWUJoay9pOTEvQzkyNDk2c3pQT3p4?=
 =?utf-8?B?eVlxK2o4dWFWbFpWNGFLc3ZldjFlNlp6bkZuVXRmWDRGMmdFbjBtc1Y0OThG?=
 =?utf-8?B?aVFVa2lqbjJlVlVZSmQzaEZYajNoTEEzRVNTNjBRRnBLa0VzajRObjcxM3Bw?=
 =?utf-8?B?MDNNZkdHejNSN0FVb01VcExxbFBBbWtLUzc5MmE5UnFoK2JnOTdyOFV4SVkw?=
 =?utf-8?B?d28rOHZIcnFubFNtK0FWSndKT1A4R09tb24zbndnb1BWbEovTnFNRHJtZE94?=
 =?utf-8?B?R2lCZDM1bWsrN2dqOTJsNzlrRjZSbkdFWFdmbE9laXlZRWVuMlpWTEhIQ0NV?=
 =?utf-8?B?OEd3bTdnNTk4YXhPV1FLMDIvQzRKbDFaS2hOa0M3bmVPTFZDSHF3Q0IrTHNa?=
 =?utf-8?B?YkFqQktIS0k1T1REcE4wYlNWM3hUS3VzalplUy91eXpwZnM2dnliaWZmL0sr?=
 =?utf-8?B?dEt6aHJGTEh0MFcraHZNcDZvZW5hMWJEaU9HUHhZZUlBWjlpdFRGYTBiRDNt?=
 =?utf-8?B?cHNpaHlNNk5WWEFhTndjdzBVckcrZVZZaFZUM21vWEtjdXY5SDg4TjBHVlBy?=
 =?utf-8?B?UUhxMGVVT3Y1Rkw3UTNPcWU1L3pWcCtLUm9SVllpNWxvbTFrbndQd254VkM2?=
 =?utf-8?B?YTBsUEFFOEZ4eVhhanJkN3QwSXp0SVRaKzA0b292ZkcreFVqdVJuU0dOblhy?=
 =?utf-8?B?bTlaWVNadXJZQTVGUkJZMHg1MkQrQkY4cU40elQ3ZW9pWDZPM3llbURBYXR4?=
 =?utf-8?B?TEZPUTI5Z0tqaEhtTy9UYlZNOERYdlhYejl0c2xVSmc2dmp5SUpFcmxxcllN?=
 =?utf-8?B?VDlKOU5zdkZiZjlLbWNCaHE0TEN0Q0R5VlNMWjM2MWpzbENaSFJ3MmFqSUdB?=
 =?utf-8?B?STZGUS9IbjBnNFhUUHZBUTZPbHlMNVFiaEl0d0I2YWZaZGN2Z3ZFQW9sN2ZH?=
 =?utf-8?B?QnhZY1dTZ1dTcHhUcGNVVUxFSGZkQ0lieWF4SVRxVkRqYmt6MXZhaTVHUFRF?=
 =?utf-8?B?K0dDZnBud0J6b0ZqUUxRRjFzVUZlRjFtenVqeU5MWnNJNEJCbkxwL0o1TXhJ?=
 =?utf-8?B?eVd5OUlmc3V1NDBtajh6dGd5VW85WDMyUjgrYVhMMlE4TkwxckpNOUJYZkpv?=
 =?utf-8?B?WFJXM2JUUFJDY2U0VG1VZVdMVkJFaTdkR3B0YWxFR2xDNjNhV3hnaXdtalJU?=
 =?utf-8?B?RkZXV2N4dGd4TENrZ3dWUE1QcDFSRDRVVjJNc3RYVXoyWWZId0ZtUThSek1x?=
 =?utf-8?B?aU8yMTRJa2YrZUkvUitJWlBjTEsrMGlqTzllN2ZSdEtMbkFzTnNZUT09?=
X-Exchange-RoutingPolicyChecked:
	k2NslQzim4g8Uzrmrj3E+auaj7nOI82S1P6L7saZe79u0oFhjHkwvL+P5PzYaIMIrLLVYINEA1doSiPpGiao5n1u8CsKpteZRmkU1EofsBYZzY19XzNOC6GpWniXvyI/GD9icwQQBasTahAINRIAQFYaE8PXowoQMQNdzFDTpMtnRXArahdriYDpV88OqH5JtlniA9RPGCQ7HPca5u4zcX2Uqs8dHUrTSJ75C6dQjzmXHGhXhsIXQaCle9C8RtjngwsjYdGCuiO8u+OnYMRfmd+uvtS7ZnAZ/PpbNd3r5Jm64696PwzIRjbJyFXgLEyWMS0tTUVDe8vEJQFIuakKYg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecf1b05-0dc3-4fb6-5993-08df38d01c9a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:57:39.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1zXKAHUUbK0R0k0yQnGcW8okA9Hmn7YIPE98KU5y1pDsYujpNVrFKyuqMeGIuothXvwJT2wAfI8FigZEM7FnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7086
X-Proofpoint-GUID: 82T_G0Xo1wXUtRS1xK_QnJY_RD-BuKDj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfX+dnKsz+uKnf9
 FRYAQg2N8SBocWuHqzgz97DxdOChIberZovMhREuUv0U34Doqqe7JIo4G3HSePCtSqWi1r99JlW
 4emjkVIonQSoJOG03lXvDrSTAnkNIvixyZXmDFvVpI577tcX5YC8
X-Proofpoint-ORIG-GUID: 82T_G0Xo1wXUtRS1xK_QnJY_RD-BuKDj
X-Authority-Analysis: v=2.4 cv=a+ylZkSF c=1 sm=1 tr=0 ts=6ae86ca6 cx=c_pps
 a=I+0PaAUBL5uRonxG4DgGUw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=lHjRijAIFjpw8Oq--HMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfX4EArjJEuI8oq
 TJWOrivcw2446/aMKWRffTLPe7+qqmOczF3VWyHvKG56NF0aUbPgidfE/kh7hxu+/m/j8Q4OQaz
 JiGmq//gd3YGwCmw6AaHQcmwsX3fyOzK3FNyAXWp7jaXuH1OKdQX/RGmQ/qJMRO1f/GJJ0lLglo
 2VR4ceBM2f9eEgX5NY79LWWnEh/wsTt0xbbp+dlmqifPRqYbi3gT+45fbmqFdeAOnphF4Oa1sZh
 Y27gvXC5qQBucEOjX+lZsLUyZIgS5wRurQC0LKQiPGR0xkA6NC8tpVyA+AvOHRnPuopvhS69d9Y
 n9tdNKdINivjSqt6wwro1BsWNT4Dtz7EgJnJfz1wRWfnAvwVEOp2tmLaiI6Mj3XRv2ClGKutSiq
 dukNmft7oPhijS0xlRu6bBzf+orioTlgAJlZ3bWNLb5odUizfFf5kAszx5TOLS2ALxDG5giGe37
 z6+qoObBRoHODDWbmyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020043

On Mon, Nov 02, 2026 at 08:08:50AM +0000, Sabau, Radu bogdan wrote:
> > -----Original Message-----
> > From: Sa, Nuno <nuno.sa@analog.com>
> > Sent: Friday, October 30, 2026 4:07 PM
> 
> ...
> 
> > > +
> > > +/*
> > > + * Process a single FIFO sample and push to IIO buffer.
> > > + * FIFO data format differs from regular burst - no DIAG_STAT, data starts
> > immediately.
> > 
> > So FIFO is another command different from burst_mode? If so, is there
> > any constrain with using SPI full duplex and FIFO?
> > 
> 
> Burst Read Function can be used on two registers, DIAG_STAT and FIFO_DATA.
> On DIAG_STAT it returns a single set of the most recent samples directly
> from the sensor, bypassing the FIFO. 
> On FIFO_DATA each burst read pops one set of samples from the FIFO.
> Either way the whole set comes out in a single SPI transfer with CS held
> low. I used half-duplex because that is what gives access to the burst
> read: in full duplex, register reads are separate transfers with CS toggling
> between them, so a set can't be popped in one transfer.

I see! Thanks to clear that out (too lazy to go look at the datashee :))!

- Nuno Sá

> 
