Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38C3911B2;
	Fri,  9 Oct 2026 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561250; cv=fail; b=p7b781K6Ib6LSavo8OUYO8vz1Bhuo2nIBG7uECs397Z3L7/iAiPHOVlPtZm7GDXH49+rc8EeDVLI8+qkYY5QlVI01TC8uCJK/ItXtzzd+fV7jhYoO1xAGL/ezextiW5ev6p8W6/meKlfIruJiMJdxUZFTa3OSQGtjbu2NfTRf+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561250; c=relaxed/simple;
	bh=d++kcfTpb1omjkTZf2fsZddS2+Wd1XyrRFl5JRZHoiA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MwDgyrKgHKefWVvO6CV3mFegus8s9B6Gah2Xlyrxfut7elSrQ6YOBSnUqABnU4WlWt0SJ1EGef+uPZIVIZlXN3+sr+vMicxzXqoJct/igdN63ruEZJjyplQpKnZ+hjOgYVMVAQ3xtuqzWu+mtM53g1RLT7DQq3UluJXuRJMgce4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=mcmGvx1Z; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PDEHMgap; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="mcmGvx1Z";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PDEHMgap"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DfUwa2367337;
	Fri, 9 Oct 2026 11:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=cz01AeI6QPS9+iHD5eaBMRnrx/7DkXETraOf6qZiRDk=; b=mcmGvx1
	ZtuPYm+yPUER39dbAK33BKuo9MHdTdmkgd0I9XA4gTW9/ElkXNRSwC0l+l9qLlz6
	bdAltjkun0DAbTQadRO297yxScQxbtJXrcGG7UIGy0Ru4xSMymuHieh/W3dAWMaz
	cnjJZf3sjj5OQgbWgv4fpiEZTYAIR5Ccain0WHTdafxn8V+Z9Cui1vjhnRjI0ypH
	7Tm2jMeDKYbfGcq9zIQlYZRUuwvzhBOmYxcgMUVnyug9EG10+GzsJelB20uRhAgm
	83RwpHnbxjlpSBO+beNQ5jAL6kCgYrSg7pOJ33L/wRQrSBXW8YP43TyrGQNJOERx
	zcJZt3RPgFp0Eow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cz01A
	eI6QPS9+iHD5eaBMRnrx/7DkXETraOf6qZiRDk=; b=PDEHMgapSTG2sL3O3uwT9
	zfEQoLIPJB5FYMJDOHBtu3PtI1lxuEBvYj2bwS4bR5pUjrARCQdIqFLYnmYARULx
	EU8rNf3XIpSpKglZOJgLTqXK2vW+CjpLfVzxKo4EiU0Nyya1LGA5g+S5dKWe0oJU
	SRSFr7tz14N5uH+UD6Jyl45L/0+/pihBDEul79Pm/vHTqeuOo4qEIH8h8Y0lCp6z
	2KRS6flHm1Qu6gRWudJeiiHaZdPiifqFI2858Y5oRnJmghwG6lwx5g5tIuPaiXul
	lORjUZRUDYaExLaTAjSmuPLQf7tg2kvofI8/SbElyOld7O48SLSXkx6YmIZPQcyc
	w==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h71chrp2a-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:52:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiJb1aFq77AlXsXLakjtp5K3JQbcKks0K1XF1DSYWSpwRtFPh4wDBxfpysWhNhh9IcRsa1O/OcEvj1DVjvJ+766cQmveyfU4YnHhlMMTnLhcLKXieoMBv7W6Qz1ZPaf7/OuYjZ608pttk2kQIe9KyYV3fVLMliM6o56vZexPa407M8bSiLeBv/f+FNMjHtGJu9/n9yJMJRdderw8frpdHzOzCB+GeBAVtWbDDTPt+C/Zqhce5BcKJt5hTNTgJ8BuwBBxSW2hypo/vD17/KAcodsSB/YjbxkrGr8oAfd73lwAEOc2m91IiIfByFIpNe+mFoYzXG3JuPDZsaiVibWUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz01AeI6QPS9+iHD5eaBMRnrx/7DkXETraOf6qZiRDk=;
 b=uXEMxI5wMm2q5kXid8bL0Gbnt+4hDFv3E9ud9F4deha0B849OQdtU3l/6zRFwfJK0qD4/J6BOESwY+bueLvLxusOhgapR0HuZhE/3P49A+DxESSxOgJmiEiTFkVjKws8mS2SwuEotiPLhReU97JztifXqeU9B9PKcBuupsXMQvXGwjYWtWLvNT0oZ65yGyWL6lT2QVgihP8UY2qxqEnQNu8xx0XhTTDUk1EK+PHSCvDc0q8lTlYpRHBdFNf/ucEEoEXueRkTWnWdD6zLlOFt/lrnKmqDS9T1gYCy1OHHCIfP7v37Rx+WaiJXb0OMx7YLc8NXzIC8aP/3HTpzFWJN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:51:57 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:51:57 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:52:58 +0100
Subject: [PATCH v5 6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width
 accessors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-6-4c4e63a7a1af@analog.com>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=1695;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=d++kcfTpb1omjkTZf2fsZddS2+Wd1XyrRFl5JRZHoiA=;
 b=TENuuhvDE1wt/cBao7XWBt1m5gtwPcnGPTozHUaSZ4ITpJqOp6wuBIMZ7tsBi5FeHScf7de2K
 6C67JiUXjjtCyw74O6iPzH7Bc6rs3y6YRdvwqLxBxlpRHTZC3VO6OWq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0032.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: f333add7-ee32-4956-cae8-08df261d3fb7
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 C31cqHyQI5/i4E36nIYgk6qzTzbTmKsX2u/wf1R1thpMUhRdoVCwV7dFp6PwS8cCTQJfEVD55DE+Q0BjTyYWYhO1YPBmEwNFCcUXd/jYSGsLWWuM2JDhzlKGm6DKo8RywduFcHJwR6PGUX6wxzkKZ+NJt3+jJppnx7CRoh/qjkaeeREaflGZ0fhH+BbDzeDlIEeUo1+Wwa2jBcSsRieJDat+3teLwcR8xVBJ1SdmaKKAhCsMtpPDFeqaglxInicHOLkovdKDI7ZwGDembbg0CSiHfWrvk4r8gcmdzaADyfBWN7IgIhY8DOotMeafaH9vLvIzAGQICpH387XMIxZDXp8ds4iZwHeVG+r+L5qEfk2xNeAoxbAcrXQgbZw4lve85wacbJ3B+d1I295EFktI3dq5KWqFXwPVkFuVVhCtkms2Qyn2oeIH2/AOycKIVJTdbllqKSbRuFzQ5UPCW7IaecEviprEwHtFEV+v2ez5Xrp52fSux4+CcLUZAXhgCwMveCCXjmkQ8PZKTb3sjdxX2khbHhRvuAnxPaMB9+BCG8hMt0NLsShvei/Uqxn1ZqNVTP4arZEFTmvlrZqUGmJcZKoS+XPOf2f07C0ZkM6H7zBmzs2jy88B68uimYPs/39HG0ZblBpv0fXZwh5bl1fWfiQOYy/Wl9Qy7ZzK40nyRsk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YnBJdUkzRXlVQWNCV3pnZUNDaTBDUElWNzlkaG9mb1M2aW92RG9mNlVENVRK?=
 =?utf-8?B?SzJ5dktWSnVMdWI3eStGQ3locW8wem54ZVVtODZrOXp1dXdDVUtHVFMrZ1hK?=
 =?utf-8?B?S1pOTFhTSEZGQ1FBcDZ5WEVrdEd0OFFaaW5nQUJzU1RGMnMwRnR1dmV1NHh3?=
 =?utf-8?B?Z3BHcXpsZXlMLzEwMnNxZVpmcWxteXA1MGhlN2RtK092TkViY0NpZ3llNHhl?=
 =?utf-8?B?aWc1dUZFZytpYUsvWUpSckhocWdmaDcvbHIvZE4vRXZoVnYxemQ2dHM4L1hh?=
 =?utf-8?B?bUtYSjVVbE1HcFBtQkdsOGhtNFErazBKUXVZQlliRlFHNHFlTXBiRHpiVmNK?=
 =?utf-8?B?R1BoSW02SXNZTWxJWk05Q1ZmSU1xV05JdmtFK2IveEJuVEEwR01UWFFPbTU3?=
 =?utf-8?B?SEVLV205a2tGVnZaVlBmUmZvVzZ4alZ1SEllNUxMTmlXOExsYklJWWVJdldM?=
 =?utf-8?B?SnorbHp3dGRkTnhsOHdaOE9vVlVrS3RjTEZiVVNFOCs1ZUx5WGZIaFNnTm1Y?=
 =?utf-8?B?ZFFGeElic21la1dueWNpYTdNUWc1Z0ZaOStMYTR5dEkzU2x1YzNiT3B0SVFZ?=
 =?utf-8?B?SlFvQU1HTkRnT3A2Q2VFbklSRmw2TXNNT3NTamtwOElYWGVWZlhRU2pIKzgw?=
 =?utf-8?B?NzBoZ1NBdkM5V0JGLy9XV1BMOHBocFNZY0d6dmRkbHo0YXdBM0p3dWl6TEZX?=
 =?utf-8?B?TmIwN3VhZkxSZHA0S3JMb1VkZU5iY1BkVGppRU40TDVTT3dSV0gyYUtvck8x?=
 =?utf-8?B?dG1oV3FYMzR2L28zaGttR21MNG43ZG5mMW5ha1ZwY1QvZ2tnekovWDJ5MVlR?=
 =?utf-8?B?bDZzZjczZWhrQ2Q4L1NrUFFTNlBHeVFRTGw0U0tvV3JkWkhMN1VpZGcvK2dW?=
 =?utf-8?B?L2lxeUNKU0tYV1FXamJnZWVUZ290N01MWjJTNDhETW1ZbUhiNTZVOHFySTdV?=
 =?utf-8?B?aHlIaWdacmhKNW40TWFoMkFCVkZyT1lqb3JPbUU3VXBhdUJIRUJSM0ZrNGZt?=
 =?utf-8?B?QjlSKzlBNHNJU3RZQlRQa1ErclBkSU5mYkJBbVlrWjArei9BWFNoTitGK256?=
 =?utf-8?B?QXVDdFpLUGRtVEp0UVNvTDBRby83ZlBtdXlUQ1NaRngrOHJYRENrSURDU01v?=
 =?utf-8?B?ZDhXNU9vbStITG9rZFdtN3hMdklvVVRpd2s0THFqV1NRSmU0eGpmdUc4c0p6?=
 =?utf-8?B?N1NYNllxeEJ4Ymg4WHpTNGZlN0FNRWtoMFNFOUp0TURKME9PbWlYUnhoYjc4?=
 =?utf-8?B?T21pcE93eDAxYnlWWHlQa1pNcFNaT05RTmZ1a2pQNDFOcm5CaDRDNHk3UEI0?=
 =?utf-8?B?dURnY0x0YWRHdlh5RzdDeGkrY2RYbEYzTE9xZ1JwSXZOQUFwcmsvWExhc0RS?=
 =?utf-8?B?bDVwanErQUxhaVNZeTduZlZoRjEvVHRia3JZc3hPZ1NjMmZwOUMvbVh0VkJm?=
 =?utf-8?B?Y3BFNUV1VEZhWHVyK2xiS1k1TElmSitIZUhsZlB4bEtTZnFjNHJiWXdLZldo?=
 =?utf-8?B?d3pxUm9QeGxPNTFyWTNxSTNHajFxWERWTmRBeTZmdHhRdi9ubnNHNmlYWi9G?=
 =?utf-8?B?QVBqY2t1RWJwV25rSHozc2JYeThoWi9NN0RKSHhXS3dLOGRORVo0dlNxUVZP?=
 =?utf-8?B?Y3VQb2VmMk5hWjd2a2tGYjcvOE1QZWdGQUZ1MUpEZFVrZDlLVEdtd1JBdlpZ?=
 =?utf-8?B?eTNNcWtpcTVxREJER1NGZXg3VC91eFd3L1VQc1p6MnNFWk1MRlRKMHZsZ3lm?=
 =?utf-8?B?R255NlB1K21sYlNJbjFFUDNxMmtUS3U1cEFEY3h2K3h0VFlQK0QyaFVhVm5w?=
 =?utf-8?B?NkhGZExqb1BSMW5QaEVLSCtvRWV2OVJERDR0Mk0wbXp1MWhTY1dMazM4MHhw?=
 =?utf-8?B?UTNmYVEzU0dDY1o5R2liNHBEMFpnMnV3N2FQQ2F6STBFb3FicmlKaDh0bkg2?=
 =?utf-8?B?MnU4N3dDZklMc09tVm1BTm5XMlRaMUZIOGlEQTVLY1lYdXEydGdQYlhpWGQx?=
 =?utf-8?B?MytSd3VoendmT0VCbkd2UXgwQXJuRU9XeDIxVUhueXFaaExydi85b3RLc1Ba?=
 =?utf-8?B?b0ZERjlWKzFiaXVuSUNjN3RHOGx2NmFQVTJNb0gxWFp0K0ZWUy9RcEhZQzZ0?=
 =?utf-8?B?RFdmck8zQlhkb1VZclBieUtSOWR6R09lZE14SkQrRG9BaEdQNXdMTXpvdVdz?=
 =?utf-8?B?OW5lRGVSaTROTEM5MHYxKzlRRzFhNll5cFZyREtCa1ZyelQyRE5pZTc4S3gv?=
 =?utf-8?B?OXYrU01FaHJ6ZXZRZEllWWtjOUZGbzBwQW5XMEU2ZnVPNkJWMEZEcitqWGND?=
 =?utf-8?B?S2hIRUZxQUVaQUptdlZrRGJGakJ5ZXpEU1o5VWhBWE1PYlQxbWhKZz09?=
X-Exchange-RoutingPolicyChecked:
	ThWynPj73crXo+HkUJr4WSYiRb4t2XTjVzGj6wMQTgqhJRu1bQLMwb3d7isw0E03B3jYvXGKJ1a3LGyenzU+c4MB1npqzBs3kvYfKwq8Z32IfFJqC8t50oB1lKqsoa8EiSYTp7GrC8qpwOLysNCAaXErJY6p3nYy7Twz6jgYa1iVyOOPh+rRuOJmNV+jBBKKQkjEgPdJAkx7njzwUcXxkwB/dH1dkY3E0qsMXs0NilqllZ246A+04KxLeT+fqPSFhdkdihwGU3D3gCHea5m7B2RiEEZ+HhN0KIZD5FcIM7hO+aHR2f8mAWzBtNsTeZlZTIoAcL+ESmnZLHgmZIacfQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f333add7-ee32-4956-cae8-08df261d3fb7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:51:57.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ir/I1ay7ldP2/HMtsvzXAKlmco+n3TS7oEkpIi6jfA7CJ8+j/trCdKJ9cY+qEfMaLuX+j9vwATGeHgSAWnezcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX4JiGXHll/roE
 Z+BfavsAKRK0AIpzyOFrHkP2tZZ99ehyZQIX8JnTfngmsvDHtPC73a4WysgxoimkX62aJxZEWl7
 Wc57TfKrJAR9zX1kTXIZmpboXa4UgixR4BF1pUrOtVyDxAG7kcq+
X-Proofpoint-GUID: Mie2ihIhDhxlF9BmUGYziDLZGa18N7pM
X-Authority-Analysis: v=2.4 cv=cpgOAF4i c=1 sm=1 tr=0 ts=6ac90dc3 cx=c_pps
 a=q3M5bEXgJc9IxHNyMLvWsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=PlQVE8PmvpCE9iZECF8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: Mie2ihIhDhxlF9BmUGYziDLZGa18N7pM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXwj5Tl49odgm0
 93PCAK3ekJypmkPHMNxheJ1MRT013cEWq4fiiB6R9MQb0X6pD1sTj+9eLSZ3BmQjXoXYOXwOQft
 VPGU9QuxjD3R7qmEAtv9+6A6Y33SGWfySfe3RLtAZnqQb/0v2iSnYVs7N8d1aAYOu/juuiwzRxr
 2qOUtqCT5bCJsdNO173AX5/SZgniIT7sFFPBYW3MxtLGj5LfFBSL2jqFiZcx2AQuUk+JLozrVgh
 Xi9i/L9TR2q3zjF6OC70ImaWOGscr/CHuT+TS2xPwoTxMkPvl2W5ulSh0T2JO1QYT9w3TH8S5Zo
 cpX45IEHmnBdZDn13RpTz0K9W4QJ7Vwkd7x5iWwcrMFpJGzgMHcT7AztRcm8CS2KbzA2kiQXGbt
 KDd08NXXFLwPfDAGFaAO4v8nhApSzmrxk5R7hJrMxoZABfXOSh9SPo/Nt+UoRH1mtMAq/Y7Gago
 jn1VYWigOI41ZHMaU3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090063

Query the minimum supported source and destination bus widths through
the new dma_bus_width_min() helper rather than decoding the raw legacy
u32 width masks. This keeps the buffer working
with DMA controllers that advertise bus widths via the new bitmap
representation.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index ecc02a427b92..df78c1f811e0 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -265,14 +265,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
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
+	src_width = dma_bus_width_min(caps.src_bus_widths);
+	if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dest_width = dma_bus_width_min(caps.dst_bus_widths);
+	if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	width = max(src_width, dest_width);
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);

-- 
2.56.0

