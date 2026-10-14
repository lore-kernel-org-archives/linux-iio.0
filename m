Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1255C1B2;
	Wed, 14 Oct 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996859; cv=fail; b=IXG4O/rAJO7uLkUpgLt88VWCoaXsd/vEYAyzDh6VHoIffef8RNS8awR9M+bVhy+15K9UZl6id36sZj1mWj7z11BsxfE+hBGZVguSbOtqFq9dhr/O34gYcNx+DGhH1kksvQ14jgH7vi7vKc8ddIH/y+HE3CCA77Cey1O0svorIcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996859; c=relaxed/simple;
	bh=Brq023FCIOXlCW3+EId1T1HX5MIUl6RyFsyTqxoQBoQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=lAAMbkKP+U/jNcYKu4aUzM8Abtb4XoCcMM+YU+AtKPOkOtyoAbYAkX/5t4mydPaAGg2tiwRF8BPzX0QHngNtMgs5oCEJUUYr4frnKMwP+dTvjQ6kyHX+pd8giCoJ0QLtE81V6Gz59+vxwU0TakrolhNIANr4MlokMyQ63MY+zgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=biFiYgkh; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hZOsnxEP; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="biFiYgkh";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hZOsnxEP"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEcdSu3558573;
	Wed, 14 Oct 2026 12:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=WfrJtFRPZnwrVHtQdyIUUU/BY2oQUBrrmEG1SzP7BjE=; b=biFiYgk
	hGTSaGvahTiMbrpz167EJzyfP7sH3VdmkiJgEkpUvpbiC9W3Z0zLH8A/2tbTv45g
	0XyjV1lRWZlI8D0limvChhgZ5cZTU1VkJPxf12txOkusfjhVwdM7iwhduV1W+RZ1
	ke9xuuAquBkvxaGWR1VXuy/Y9XBgTHkCxdIOMn9cGefm2XKuA/1Kuz86MOTiaddS
	4Cj4nH9af50PMUnnxXJTCj591/lkSyQGx7Lb3mt3730NIBL+Bd6HqsWa7SEvR2Qa
	PNNjgfJQxso9l0u4Rdn59DDlPlN5ysECIXVSV2xHMPd7a0+EDbbjX5mY/XvedELZ
	cxKUmLalyfHEhLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WfrJt
	FRPZnwrVHtQdyIUUU/BY2oQUBrrmEG1SzP7BjE=; b=hZOsnxEP3tZxSS2ruKgHx
	FneIApD/3M8KGrjvYviv3rfsK7cCr0cXWbUB+OtG7bW4BrwxeIR6OButbbQPsXjM
	GnL2pLnxG7J8pKXdGIW2qOFkM7GY3ZnXIOIFOryHo3VibAdUsY/Lu/DyeKL0vC52
	+dGa9WJf6DYaWfqVAclOMg9kwJA8g0leDYHpm1vM5aq3UfX7caFE3oH1+RNYbJuv
	tAM2ZhHkrPx7GC+aIbo+cLo7YkMgSNxsR5RJ2ujU+0Tl4TYtFNbqpn8yrREhKHJM
	0XBC1y/I2+u1L3fhKnLfoI+TsFN0E0WWvqnhW0p90k/m/TngjIcjtvFaPq2ap288
	Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9xnsd8m8-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSZc2D2tm+pEWg+tJbSW6qyb991cYn7wkbL/fBnxftmRaBSZWlXmjUwpcQsev/q/1C0GlHkuoZTMLsWLvmf3umD7jPOgev1CF+DSBH766TZEnFuvy68L+4NZLasX9Fvg7SEmpmUmRBy2RTZtQgl56IElBhc6HswYRyJ0JfmaUkEHVHgbE1RhbrpVMp1NiOTcjDMMSaSIaiTB+WVZUZguSUWhgYIC7GflEoaUOrlH8ZSIQkb8tWhfRRGOA9E9qx+FntLNGp9i2Z7DkMOoLZi7sE7jw3ahSQeiTb2Xo0R0Bx6fxonMcznFRxS4qWDemmzbYDSCAFGdQ8YZQt/M5VNS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfrJtFRPZnwrVHtQdyIUUU/BY2oQUBrrmEG1SzP7BjE=;
 b=S1VyZLOJZM196osZYQHX3F1fPpmXn67X9a5v3txBCXX+FpHkTnSLLwPIE9tnB4WMSbq8qKRtfVP+O4MbwiTkfPYkaMEtpOy8GBXtdAH4lLCY7T0Q66I6ucSQdTSqSE79IkIQxSJgSJv+uEs3aBrT+EDFK6VubL8vFbPxMfA/wpgYe4RXtELbTt/l25TEcY0Q+KP7YebwvUPwvlqOAdgFp5VKhwcoqvF4zyThacuIue8gmDol9U0vYYh27fy0cGqzTb5+395zS1/I0aPwPSTc/+pPfEBP+XFd2bv8mJKsAy+NtFXibhafzRXkiztgdfszEEqTqc7s2vGEtI5Wc4NJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 01/13] iio: adc: ad4134: Adjust register map range
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com
In-Reply-To: <5c03ec5e764a5fed7bbeb6ed625d5b044b76ad2b.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <5c03ec5e764a5fed7bbeb6ed625d5b044b76ad2b.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692809.658576.9949814537440545735.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=758;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Brq023FCIOXlCW3+EId1T1HX5MIUl6RyFsyTqxoQBoQ=;
 b=deCnyks+ENJaM6DRlCRD0UoN3FKHnfZO2yJNZgBYcxZB18tpJpmphfLQmVwmlZOA+gtNv45Fp
 ACmU7E0or+3BQOky8WKWrC2JGzZzUmSiRk6qxPOPynNRj7jb7Yv1WkP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8c93ba-df98-4d45-2f99-08df2a13c438
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 ObE9eLmnsDMe9nVolODQzrf+sClN4JQcW6f4SNkuMt0k9x2f2WvDpk8WgGqOVio8DpdfWkvftSjLXS+YvOvoY1p3ALv1Aftz/QPOfojwuElh5Q/U+bS1Afk3WSKI8ppEWfwZO7e6HdVSg4+C5QYMZ9a/Q/h/o6/BJrOXOx76y607578Nv7tSALTUEU8SPUPVZU0tMgRRfBrK7l3uT/bi0voTkEguYDpU7qfFzjBn5p59+B9tM/8zN0SDskLvPtAtI3cuTUncnKMVriXYVVxsQ+3r4bxn+PeK+1STchv2hR97Jnc/g84twUy5sMshCwM2ErVKxC3fz5CKRMcwR1DNuzT1ZDoSbfE2h+Aiq5KcvpB25tjxqQfLTcXZuahws+4T3MZ8Z4CMVR7QAFguwKvWw4/fPkmNbVhSui0vfnpGm4frzsTMVE3SKCcn4ynp7HSHBrw3oe5tHwIVhN1RaWUXOdICVDT4rv/3KDQLG2/+5qHqVTTS+wamWx4k9rwVgMseXV+FRqHbl69qjdSoYdSvyv2b7Y3kRZltDIPLtRJmeVGuKsrSLeJs9mK7ZChN46kPZrTvEU/mlKRqE0lstJAb7yPggZxN+Q7/yGHMnqypG8ex6OxwbjxzygGkHS//U97TUjesIE+a1NeyPkeWobx1G+bVNvxJr/LKT9FWcYxwnbk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZjkzNno2UDk1cnRWVGQyUndKdFY3c0FJQ3hPV2g2em9yazBVZHcxamFxanky?=
 =?utf-8?B?amtrb2s5RzFDZkMvVkZ4T2pnS0szK0wzUzJZSkhXWmsrZmFEZUdzTFNRVk9N?=
 =?utf-8?B?ZEdiV1huL0xPQnJyTWR5UWlkQ3VoQXRHbG9EY3lGWndwYmhGRUoxdVpEUDJx?=
 =?utf-8?B?T01BQnNjcTcvMHhFcWNEcDFxUTIzaXRkcVZSM2w1QkxIOVB3WW1Ud1BuZWRG?=
 =?utf-8?B?K3Q4UXJBbVhLSmxCL3FCQ3YyWm5RY1V3UXZCSmZDblkybDZSNmNOME42bTY1?=
 =?utf-8?B?bm9mckpUVXRxVklWV2lFN0JYOVVBUHpLRlZKaDdlRUdZbmdWak1JSWV6ckZh?=
 =?utf-8?B?YWxZbUNqQTNNOUpIR2hOWFRoTkRmTkd1Sm1LUmpyNTJYUHYxUWN3ZmRmYWFy?=
 =?utf-8?B?eUN0NTEzRURscStzQ2R0c25tTGZmaHZOSTdSaEhFOGRmaGpzUHprWm5LNlFQ?=
 =?utf-8?B?alZtY2U2ekc0QmZleU5HSWY3UitPVjgwSmZYQXRYZExOY3lqQ2ZiekdVV1Vr?=
 =?utf-8?B?SWo4WVlrR3ptcDFtN0pGdWJNY3doTzVJalhHcTZseDVKRTVaZFZ2eE1iNGFS?=
 =?utf-8?B?WGw4TkxuQyt3UFBYWS9DRWV6c3pIcHBLemhEdFZNL0YyVGl2UnFMWFV0U1FF?=
 =?utf-8?B?cDlCdkhPaUdtSE9HS1BpNDZTOFR5cDdjaHdadFVQL0hnaGlUSWFISXYyT2E2?=
 =?utf-8?B?bmFpMWJYUStmaXN5TldtRUEvUE9qdnkrM0dKeDZVUkNWemxnUGxlSEhmSjJv?=
 =?utf-8?B?azZQUUF4R2hOOHdWWTM2SVA3c3dYQ1FPRlVPeEJBMFZQNVphLzBZNXFySnJL?=
 =?utf-8?B?NERvRzVabUF5TlRwWnRPYWt1cnJGYTd2Y3pkblN4Z1lSSXBFTjFPSXN2SmRY?=
 =?utf-8?B?S3owV0xoMkV1V2FhWEdGakhKVjBWTVdVNU5wZ1VSK0d0c3NFTlpKODQ1OVVX?=
 =?utf-8?B?dG5RaWdVOHJJSnZoSUF5eHE2VXRTRGZHZUtlc1ZlcEs0dzVQclB1VnhNOUYz?=
 =?utf-8?B?alVIZU9pZk1pSE9TR000Nkx0bVh1TmNkY2piSlJId05ISWlGYTZzeU52a1JE?=
 =?utf-8?B?Q3Q0RnV6d2I5SXdta0p6UXFUUDZObDVkQk5ESGZzLzk5dXprK1Y2U2N2SGJZ?=
 =?utf-8?B?em0vLy9wbG9qQ2dPajJJcFFZWnV2d3c2Vm1OTVZwOWhMVVFHMEgwMkt6RStV?=
 =?utf-8?B?eFFCRlBoYUQ1U1MxT3E4d01sOXJwejlPNWFWVW1YWDBTaUgzU3FoY3FHOTNt?=
 =?utf-8?B?MmRpNVordjJLVUV1M0dOSWxBdk12SFJiczhhT1R2aVVHQVNWZ2ZIdmdqcUhD?=
 =?utf-8?B?Y1U3dFZWRFowVXMzWDZFTXpvK2VLQ3ovK1RvaTk4VUw2OSsvQWNHYnMzcGto?=
 =?utf-8?B?MTdscy9YVHVLWWgxY0JlMEtzd3g4TGZ1TGZBeDJKc2kxaDdEdkk0YXJpOW41?=
 =?utf-8?B?aWZ6T25ZNHRoT3VHeVZsS2ttcWxGKzY3ZlVwR2o0STBHR2JlcHNONkx4VVVo?=
 =?utf-8?B?cWk4dG5uRHR2d0p6dlFBdmx4djZ3WmpKUTU0OXRkT3Y2NlJ2S3A0a0FlL0hL?=
 =?utf-8?B?dVA3WUlVcEdaWHdqV0FBUmIvWGhHL09yYXhrY3d1aUpuU0dland2SHNHVDZy?=
 =?utf-8?B?WitWY1RXVTBrZVc4ZGF5TlF3NldKNWdITlk3Mktnd1UybkZHTUpBd1kwemdN?=
 =?utf-8?B?cTNqdmR1dlhmdXpDNUZGdWh1OG11WkJtenZUWWlkMjRJRkIxTnNlRXNBWVJN?=
 =?utf-8?B?dEpVNHNFSStWV3AxelNvVENVaWJDRmlqMmgxaHlodGY4OXJmSFc4alJ3TzBl?=
 =?utf-8?B?VnNTeUlPRGs4RFRYd3Q3TkhCclV3UkRqbXhjdkhlK0YzTWtQdko5bXNkTzVD?=
 =?utf-8?B?cFE0NnBGS09lWlc3c0lvR1Z1eGJOS2RXd1BjN1YvL3JpZ0R2L0pPZXhiL01o?=
 =?utf-8?B?c280NUJSa2lJakNQMExyNUhNSmpjVmZ1ajg4c1E1cWVueURnWFpWQ3pVYUU2?=
 =?utf-8?B?RlkxckpZcjREV3d3bzRwbHA2eFFXT2VSdXBZMWtRd2t6bjZlSUcwUFpDZU55?=
 =?utf-8?B?ZVhXbTZqbHUrSWk5RndSRm9HVk5VOTl1bXdYd2d4Q1FHMEV5WGJkT0d2MmdJ?=
 =?utf-8?B?YytGR3BQYzB0T2dMSmxaWVFRTDRISG1ITDdPdnRBMGxxSzlpU0JsUDY2UmNO?=
 =?utf-8?B?MkhPVmhSd0ltUndCTGpnRWpHekVpdm1nQTFyT2VyTnFaT29ucHc3aitDVTRY?=
 =?utf-8?B?cWhNZXMwOFhabm5EUFQ5SFoyb2k1VjNGSnQ2cjRWcUNJdExNU2Y2ektsLzQr?=
 =?utf-8?B?Z3djdG0rL1hZWFBuQzBmbjV2YWc4SGJBWjA5ZWY3cU9XSi8rVFZJUT09?=
X-Exchange-RoutingPolicyChecked:
	FppnNvPf9IEpLQsavVslcIQOyaXTgNoNVLrsTsSwT1ic7qtHOovQ1XTBhC/J+mOghftZEgjUasKvGcwOnSxjz3f7MnotX4YbBosUmmeShW4q9nneGtm+22UTZ0JcAA2KAB6IdWUze2hPVdkr+MK9Qbi89H8T61vTpUq2QOHsms4GS86WaCUoJvMwuf/uQOTDnPT6aM1Y7Rbozk4WUWHevmiNPrh125ZMiUN97fsVxqOVwBX4M/VwnEce4HTe9UbQeEO69MJGtnJv6DcqOODVVoIP5qFSw9sZW4HS/RwrXWqSwnMTjP0774y0IYdczfNaB1ILmrdsqUJ7mDwWrgmbLA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8c93ba-df98-4d45-2f99-08df2a13c438
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:09.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUGfQCHgB+mBWw1qOUvbG+SggJAa0XdUbu6pYsOqud8FX1t2B8K0Z9inGj+fzC05HtXPcGNUglw/PfO9L9MjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-GUID: l3zsuzR6g84rsSykycI5F-78Frmlnd_X
X-Authority-Analysis: v=2.4 cv=MIr1C8Zl c=1 sm=1 tr=0 ts=6acfb3b4 cx=c_pps
 a=Bsy78vmKOeQIAJqgrxlU3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=8NmX7xMoxXs7GY5_H-gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX4w5eZGPpwAJd
 t/7X6j3Evw0uSAefmFcfcFQ8DvXdgEDCcMk3gw3UNfLg6rgGRApXyChXrWuE8dCuZnmI7g2Va+H
 byafwKl8Zizt9clM2qWbB6wh+/v/RWfJMpccNPiQseKgSpszY6LB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXyGw/VblKyPHQ
 cAwP01d+PEUAERnTH2TSfbIBuH0nEL1Vh7M2eVnmQOK12IMAYi4Eg2z8KfMIZndUMupeIvGbxbz
 DlDndKuOrn9AOBXwHNCyfiNIolhTvlZe2x7zldAot7nADDCrBgG9hc/w8AUELWn7KKt9+AJt29R
 tBi+hZqn0PnVEl0B9d1O7P9zSrSMQt3tizq6pFCvWxpn5q5oN91aZKGfX/Jy+vHiX0E0HorAwj5
 QXfDaBALWrBCv8Z8HLUb06Q4gmldW+mEFaKC4PXp2Rw4D8Qw+PXBtfM49DRY2ivAunxJAbWw+sM
 FsfqzyhKhApg+syUrbEQAtW805MQcYLanH10PCi8x0VQxigBnWiDMsdBdnzGfhCwj6tPU4BqyF9
 5vdSJdosCBUfAHF4j9Lqzm/5zukgksQOr8YopVvrZGfxbiQBg3JW+nbq9WBeEZmYW7g4yRAcRtg
 TU1aE+QGkitYv4Kg2fQ==
X-Proofpoint-ORIG-GUID: l3zsuzR6g84rsSykycI5F-78Frmlnd_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067

On Tue, 06 Oct 2026 15:16:06 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 70f80bf1825f..e53c10b9a44a 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -244,7 +244,7 @@ static const struct regmap_config ad4134_regmap_config = {
>  	.reg_write = ad4134_reg_write,
>  	.rd_table = &ad4134_regmap_rd_table,
>  	.wr_table = &ad4134_regmap_wr_table,
> -	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
> +	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set) - 1),

Can't we just use AD4134_NUM_CHANNELS? sashiko seems to have a point in
the othe patch comment.

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
