Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A1560AA1;
	Wed, 14 Oct 2026 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996861; cv=fail; b=L+WB+1istzY6jco0IZuywuY53rQfhIBeNCeQZBVjb1NYbwBP5yWWyuagi27Wd16oymw+TK9ePYxeNSiwMAD07cvwqw0mm60AZ4+TA54ZGPwA7yE3iV/4x7YkqGAC9/VEytGFgMp42ugu3RFOPM28SJRIkTW8hyYNCSL78uvFnms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996861; c=relaxed/simple;
	bh=1StN2kcem68MQfFY54p+jtc1vIQG0Ti05wTvZsuZVN0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=LuHv4m5YVH70ibA83DUivvwW4p9/qmI1CU0U4hffAuBtD529KncibUuOpyvSnNOzaySXCAqoWpF4k1YGBoSbohwktPVyVstgzRMe08EmEepNZa28BtuasHc8mHcBOyiKJt31i2+di+7PE3ACKwVbzVZi1bHfyM8SLa6oF1Gu4rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=E6hm3wAa; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SnFtnzqk; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="E6hm3wAa";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SnFtnzqk"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEdufQ1109535;
	Wed, 14 Oct 2026 12:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=YAf0dxpEk9XIiwFcL/DScg7UaRred/b3eb2CdbKo7qQ=; b=E6hm3wA
	aHHHgCK843BvtTMYeR7IfiG0urJsnV7WXjsMpWx6zUB0C6SVhTzib3wzom59ich7
	61QY0ni5EFC0r7pPQ0zXjHTLbbutQehguTIauGPA6s/L25rnbaZHA0U20cQPANTF
	Wr2FiUx/ZjpMTcB1MQTm8eiXYHJ+5x96opZA3Npl904eG3VlD+0XuNvUmZkfLLOu
	gZbi5AqNEgJa6YqDcr/OkH3ns1lNiZG6iosChErEjTqW4zqnJZMZUusYdq11LTW2
	QdxjgTk2YFJCWpWZ/mK6AUqJNz2L9hzLikVn70y7BFlSyK50S79Bej+NnzpHmHJE
	DWk93IgC46LaIRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YAf0d
	xpEk9XIiwFcL/DScg7UaRred/b3eb2CdbKo7qQ=; b=SnFtnzqkzzd/QsZMUILVl
	OPJ0Stg4NuEr0vRLjoHu0r9mDvduVH6YRY75fC/fCxvoc86syuqZOgQy3nVCRmWP
	a8nI6hiK0lUI9egi+fHloRlOCMS2jhouwFah29lhMsYrm8zs/2qF0DLRuV3w+7O1
	h0ch+zup3WpXfgOZDIyhvNyQ3YWYNvAQKTYoE9Y2GqymSJZMKlfvS3oXGW0kEiNg
	C7tF4OjHjMFXVI4u8uOQhW01j5z9RCXNoS/OjTtW5TWeLpCgQIw234mQP05TDVH2
	0hIxLfENUWToXE7Y5S0sRTUlfGJeT5CKTCyiIuI8Gurp3y/SbC63oCN7fmAJnSw2
	g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ha0t3cj9v-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlUc2kStsq6XitWwWrYajj5PDIgeSSAE/IsxRouMpA7u3ZPxAnSBFxPdsmlz2UEygGLfS2j7QLZ0VlhZ92DWyI5cYqEf9HRzJl2/52gwGrtRPqhuIPQV1uZlgDkhhg3GjSbXfKLRd7+kLZsoAH58J4mQTy9TaaCzo1g96OXxKlkcAamL0XLC8jJP1qMl0AcrSHmCK2I07eVZaNWBPLdSNMj6vqY2xcyxgugDu9//Bs7aBvzyi4++yi0X2P4q8MOs2rf514f3YILpA6rclaKK4U7E6NstKT00l6mWZS29oVZJ1ckerqkG02y2802eUTCnxzGAtKTTeRbxBuk/paeWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAf0dxpEk9XIiwFcL/DScg7UaRred/b3eb2CdbKo7qQ=;
 b=rMVcAahDvJ80x6DY989GR93BnmMTVawncT9f472s+xkHw+tsr5DqPd8EOnclz/GG4yVoUrvyqGEdUech3Xac4zzTAw+HDUnYNplEfsoGSlaf9H39gjsJ+FRx4qIAOI80FYGOmAyxuKYLflAei5vrhkOtrKBsUDU4gtW1oJg77/VZeWyy+kcq5CDetLrUCEgXgnq71M3rmZr17wtMh3+6dKWmd34pbi6653cgaMua1XEE4UGRBd3KbOu33YRryEl1/F1nHEimOY0Sim0o7r93p9NiGTfu3sdpB3QvYqfRZ0lpaOuhOJmZgNLa7y42/7Rolt/QKeEN+CCjydSo5kBHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:13 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 02/13] iio: adc: ad4134: Sign extend sample data
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com, Joshua Crofts <joshua.crofts1@gmail.com>
In-Reply-To: <8f22f48cd830338d801342a52fb454607e8b06c0.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <8f22f48cd830338d801342a52fb454607e8b06c0.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692812.658576.17660231967258926317.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=483;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1StN2kcem68MQfFY54p+jtc1vIQG0Ti05wTvZsuZVN0=;
 b=cqUgbCek5ct3i9gYEJjDAuDMaS0AZlE24gHl4IMHaVErPUngaBBqqMfiayuTaBr3pKRhshqoG
 sNt39EuzseqCCLtKJN2BxlCaBpbnocqNTtFhEcMNhAMiZJMGNR0slJq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cae3f5f-0ae6-4ac9-ea24-08df2a13c65c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 Jyi82ua2yFQgwXJWsvwV+HxDlFGjIUXKboTXlT2psy7qB5xmKQQIrHsxdzjEJDoqKnW5Yv5aWUJZh6eyBfq0vSwJmirXI8kr8wY0tkOXWDjEyW2TZro58CSKbPDWHgjyp9Fj2FqDZ+/5GSFf0LK+AYfKldFHxxh5uwe+YWQLbc+P2wLN6MgF1NvRLmEI5lWs5awX2cPmzgFY7W7X/XZNpzCP48J8NLm+GFfL8Zbqm2Whg+MVD8x307xtQsq6SbjyzWt1O/a/S71XvzzMuAjrjpsZNO2ZvYcBBE6t4uecO+fjBC/KsuNgta3BJ6J2q9A4XS4FyrzKXvo6VxzW/E5zqY1g+C8VH01kmDHnhpBl72VJPm5oyKMSJzk8GZDDNKWUyou4jLc4pAa2t0sRMqe84glykEooHjnR/uBJA/ynWOMQ25LeD5Qc5yCYg5Ww7vI2okDfNT6IWF0PTA+qzOYB1KIeEV54q5Z+1m5hwdIvi7zCMP711oGjUrjxQPM2YLVZGV/PefDDZJmgR0aNMqzLT/q4o2qjE3G6ApHBv12g7V5dLXmBsxAbmeS9vq0DghSv7Na1fRGAIXf4jDofzSPUYhyoqbBPPXf9FY6j++Pjsufkc07w93xACWcRTt2haEquOaQ1+u6HPL9q3IKvxATkvAMsADqvGFLmX5jinC0fV5w=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YUhmb1Z4Ynk1bEcyVU1sSTFYdFp4d0VQVnJJcDZhQUFMckREbTBtNTdJOUtZ?=
 =?utf-8?B?Vk93em1tNzZSTnNkdkVGOFNUVVVsczNodWFwYS80cUoyclR6TDRCQkg1aGF6?=
 =?utf-8?B?cWtoNlpLdk90c0xyM0VQaWVRdGw0c3BHVU56TE81V3JNdDYwQ2E3bHE4b2pp?=
 =?utf-8?B?RkdUSUkxdDVLRjlnRUFzVURzSlZCMldXYXRUYUNiNWVRWG1BU01HY24rRzJk?=
 =?utf-8?B?dXJUcVJ6RFRUWC9DMXhlSCsxS2NxRlNMU2VzM0cvZmtvcDNhZUZNbTlob29B?=
 =?utf-8?B?dmdqQm5GYTJWYUdITHlLSyt1WmZOaUVLazlrNmJSdWp4YjNIZGozdElCU2pj?=
 =?utf-8?B?NE1GL2JMUHJjRjlSVUw2cHFXY2VLUUgvSjlSVTNJZWx2Tk5HWFBDT3BFMG9l?=
 =?utf-8?B?YXJOMGlBaGwvTzN6N2xZeXIxZDFWSlFGUFIzZ05Ia3NGbElxNmxFQXRvT3E1?=
 =?utf-8?B?WkIwTkE1eDkrZ1hqQXpJMHRHdlpiTVN0YnZvay8zZERRTFpoVGNFclkyMjRB?=
 =?utf-8?B?c1pEUTVRR2dLbzhTcXc1alRhZ0F5enVPOHpqSVBMZ0dOeVJEZ1B6NWpZakEx?=
 =?utf-8?B?aXRTdXJEM2d2Wmo2VGhUVEZ1SkJoTjVXcGNQNnVhUCt1VjF0S1RLVnYvcFJv?=
 =?utf-8?B?RytwdWwrU1NjNC9XaWJ2NUFkYkVNRzN2dDZxZWg1YlRNQ2VjaDFJQU04eXF2?=
 =?utf-8?B?ZHZUWWw5RG9BSUp6cWJpUnJUVkw0NFFXWFhXLzhqMGpQeUFORjg3b2U5eWU4?=
 =?utf-8?B?SE42SWRCWmhnbGtqSHQxUTdtbW9mdGhOd1YwTDMrNG1wTm5IV2dUNDJMdDJR?=
 =?utf-8?B?MVZ5K3FhUjRXQW1MTExhWnVPR1MwMEREb0tTZVoyaE9nbmlpbUUxWkhMUmM3?=
 =?utf-8?B?V1d6NWNlZXBIQ3MzcmpEQzRJZkVHWmlkd0ZzbGY4emxBeUpRKzdGZ2dUaFc0?=
 =?utf-8?B?bFpiTENkaCtqeThqSzNFYlVJKzA3dmJQakQ2NUZtN0pRalFLRkh5cXVNcEh3?=
 =?utf-8?B?YmZnV1E3MktHMjBNZVFFam5PcHVNYkw0UXdLa3FMTXdtVU52NiszUjJKRGhx?=
 =?utf-8?B?cE0xYTRPYjNTMXFxaEloRU5LckMvNXFtL2pyNndOSUhiQ2ZZKys5cG1LRGVJ?=
 =?utf-8?B?RjBtWFlMT3lpdzFWU2luMGVpTnJmVEI0cTAzQUxBTTJmdUNpSHcxZW5Gei9X?=
 =?utf-8?B?SUIzcWFGaExZaUtQQTN1UFFQOW05T29LZHNMOUpxeXZOZ3VidmMraEpiZGd1?=
 =?utf-8?B?QnMxT3Z0Z3R0bzRNdnc2V01zaTlWRHJKUzA5MjlndWxMQzVXMUt5WHVVRElX?=
 =?utf-8?B?dXE0aFljYW5Mcy9PQ3djeVNhRkNoaDhJb3RXQm90M0dob1Fxb3QySkFkZEJq?=
 =?utf-8?B?b2FJUlZEbld5M0E3R0pJQmFXbGhTQ3puZXB0NkhsSTl3aHVhOWpESTNyeXlH?=
 =?utf-8?B?RTdoTUg2VjlvRDdSU2hZa205YlQvZ3MyZkhCQ0ZLVXl0WjdZRXFnZHdDUm0y?=
 =?utf-8?B?YmZZMlp6TXJDUEtxWVhpakdGeHFkL0Z0VmYxaEtnVTZMRU91RHhEWnlsdFNl?=
 =?utf-8?B?SEp6dEczd0NhUnNPa3lPZWg3cEMvdy9yRm1IVGhsOEtKaCtScmlKaXFxaW5m?=
 =?utf-8?B?RnIvWi9vbTRKMVZqT1M4b29lTEJ0YUJEeXNkeUJpckdIbTBNYzNQbTVQS2N6?=
 =?utf-8?B?Y0h0b0RkZko4WVBvK1dqQUhrWU1Wa2N3VGQ4RlQyVStGclE2dGx3SGlnV3FD?=
 =?utf-8?B?Ykw2V3JWSjcvQkY1WWhpcFc0bmZES0UvTWpKbTJscHgrY0ZmdHgxRTFRdGV4?=
 =?utf-8?B?aTBDd0xNMkRiTDFhM0phOTNMaUVaMWd4TDlVdjE3WTVIMkJySlBBTjNPSGZj?=
 =?utf-8?B?NUw2TU9ZdjRzYm9Ib2k0NG1SQWhKbC9EOTRCbzZQb0NhNWxGRm01UzV6ZkpV?=
 =?utf-8?B?R1M3djRDSEs0TG8vbnFDZEMvTkFvRU4zNE5GNXRoN2c4Vnd4OFBoaGw0Z01u?=
 =?utf-8?B?ODl0UWlWQU56Mmg3TDZ0VUl4clpNdlZTMmJkQThJdWVtdVVQRmNxbUpwV3Vo?=
 =?utf-8?B?Wk1NbmV3dlorYkVuWXBUanBRUFVHUVNOV053YXFSZU1TQnhkTmZYVjVFNkFp?=
 =?utf-8?B?dksvTVo1dzc0UlpPSURzQm9PWnVVOHA4ZUY4aWo5TTllSUJTQVJuUEFuYU1R?=
 =?utf-8?B?T1kzbkdRNFBaeFhLV3hISmZud0NvZ2Z2aHZTMmRSanlRWnNBOUIwYlloNEFo?=
 =?utf-8?B?SnlWWVVuRFpHOUlSRERqL01TSHBYQWVqZDI1Z013am0zL3FnT2lybGt4aWNJ?=
 =?utf-8?B?QytCWUFOU3JMT0dFV3FpS2xubG4vK1llMldRUjNrMmh3Z0wvYnBkQT09?=
X-Exchange-RoutingPolicyChecked:
	FbJ37RJklaoSquK4YRP8hIRHbYa+rQ8RYxXozg1jwwIV39HkmuHuIC4S3WiKT/yxysT4MCkIoab+0QnlzM7MOIeOoN0Kdut0CPyDCs0/c1+ow0h8MkHhNAoVljp06NUj2/ulXdaCpG4JSG96eRIp52G0Z91QOv+NFgqzSlarDvdTVfuZZvURd0FAo540euemxQRutPO+J9hWj/8zecJ3XDq5NTrpKmJWDsQEpK/UvHMjQBBuhZd02O97SFxHNPZhhRxfPBsp1N/KFs9yRkd+mmW9g7+HDmj/rhzHQ6tuMzl4Kd9hdSXm3K0qNGQo/v/n/nGSNbbzi48SjhfHEsgngA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cae3f5f-0ae6-4ac9-ea24-08df2a13c65c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:13.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs9nKqFvcZF5XVCCuXKXxkqc2vWY9j+A+vyZ9omfzzlaVgP3Jzw8JvadBQXlkFIEBQngbVeRfJuPRWV79Bx7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX3uGgERFO3uzH
 71qeJG/hFtB6hZOiyhjTA0RfjCjXlH+WHk1BrpRyQjQ4oTMCT7jjP72eWAOhiFh1XyAL0XaMGMn
 bCEvB3e/BHayNFUX/RhV3C2yPwtkoe+RNmvuZciShgq90KTAOsz0zNDWb48sntHGxITh6sL7oRn
 axtrfRMS7oi/TjLWzeLfl/zzubUexr8t1Cx3dSwMc4QoIJgnS4VL3qhAQQmBBAHSfFy2VfJyrnz
 fOX2Mg6dEFV1rdtlVcxIHpVB2nyaTbgyy8KeJBF8p6HqnyQhEfNPf7O6daj8z+X6l1Zn2ydulLs
 HK+HzeTWl0ltbAawF/Myuk4Ul1RDdwfqsB1NxyvmE99kOEaswYtTcW7pAP45HLxoYgbvCl5HW9N
 7uktdblFbjHrzZZXN9b6+Vr1uMP3FZxR1ar1gLP7fLix/a6Whd84Nuzd+2DZEXMF6JBrljnJCMw
 ltKGbJ433B/w3rlKBig==
X-Proofpoint-GUID: gKtKGkMCExE2lQKjfAwlQvVVzKDyY2FN
X-Authority-Analysis: v=2.4 cv=S7RMU4sP c=1 sm=1 tr=0 ts=6acfb3b7 cx=c_pps
 a=0imTBu3/wk/XLaKPibPjKw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=VhD-dJNoDiZK_D7JZIsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gKtKGkMCExE2lQKjfAwlQvVVzKDyY2FN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX6nKXGf5U3VDU
 wjoGfiYjGqhGIRFEEqdeDxSgk730GFIsKv6Qt2q4fZpha1D0vyE6wwa3MLDuJMl5Q6dJX96IsFE
 kxyFWAUE7h2VMcZ0qoSBEkcaR5sp/LE/kGryZvuDpNCrKxmPkUn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067

On Tue, 06 Oct 2026 15:16:24 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> Sign extend ADC sample data for correct delivery of negative ADC input
> difference.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

With sashiko issue addressed:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
