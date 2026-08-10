Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8C3B3BF5;
	Mon, 10 Aug 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374380; cv=fail; b=RFcWm06ku81MSmUyynnwNenp1lHsx99wvFbshqok7DAECRD6ZlEzfJdylTSQwC+K54meNYEIuBYDX1lNCoydUbLhQJsInMyaTZruJuxTIj2Ppwcaw/zzm7OtkD6hpl+MIQmH+sLD5CO7XNI2hdMdXepD7mgE8r/oHH5C5Egdk7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374380; c=relaxed/simple;
	bh=XyH8clEDv44gw/zS+uCTsWYJDuWWi3H0WWbQdEkNgeM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N1kDibpst450Dilnhr0j3ycOXHmnptUEoWYr6Z+aQ7VVqcY0aZF26qr92XsGJS5gO5LZoku42bYSQTLkeaILC+TQxHJgnGbOoNlBN+ZnaBJoT8nARCQzHQeJJX+uC4WuiuFCJ4AvsfqiKoPvLwQzBDdzvLQpa9/YoD3Uh5Y89t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wPPDsbX8; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wPPDsbX8"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsJC21464309;
	Mon, 10 Aug 2026 11:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sG5GD
	UGvPmc6DdTHCB4eeAQos730zgsX1YgW14aoH/8=; b=wPPDsbX8zNbWIUAUqpuKT
	Z1qPrkkBoZ23PRMBBruF7rSrgixdaVG5Jc+7AZM43lf2xPTOKUEqn7Sf5m7ldlKz
	yxqakYMSe9Dqse12a+8xbSPz49zwmP4/VTGD/tKLZBixO0QQ/++bUto/usPnkDx4
	S4NBlcmAc6mGBMIkNOmtJ/2d0zoSy3Zs5sWucQyqsuvO56kh9sJOfnZunWAQV9co
	f41i739ubKompIzx+1//kktuCan80NuH8qg/qGbzZOzBb7zrjklPGajsnjfMaJ+8
	1voj+siWIipbga0xjJBogw9F37FpWTFTVfduzVVYDZlu6YOoZbSUuBRyNGi97uu4
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxjse5ast-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:05:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW8o0JxZQbVhvtrNtHGBMubIxhSWZV2blBhSv1V/pckwKIrzzVzULkxh/GJtakNfpx+hRYD9xJy0zpuiuYYvYdRL+uh1U8b9546CuanuRDfJ4aev+ItjNqOyD6sWB8Lf547ojrpgzgmaYaOba9NtxbMtB4BUHaXqCfeNfC/PKV06/hAHz5KRSKBgGMNQTLLIW+Q4/tMAIQxRudMraFU9Lww8dPVC7DKPfLlvjs36AoQ9hlw37nzvvAAGKeHVweq80udHSPIVOa41X4ongmthdBYTM4Ojoa1quwdiFG+kFMf8zc0xJg6oHr1bwbT6736UmaxjWE0tsxgPvf6Yn/X0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG5GDUGvPmc6DdTHCB4eeAQos730zgsX1YgW14aoH/8=;
 b=MCUb+pxQyPfJrKvzMYYxahCkf1+QGnQ8M6qFOwr5yajwdQs7SBDXHihbiQ/c9obQZ+d5Xle35lw/w/AGT3kvVWYyIg2pLEOuO8F7dM9IxKyIUFzhZkrvslPE2YsR8SGVkq2mVMnyGMOmmET7H+URfExMxumoAxrfkuHO02aQkODtV4vR87Kxst5Qkyug9qwbIq3DyCrBaOTx4aWq3tz5Kj36t30n1lTGuIYQNOhuWQwr1bzSygDY/tCC4yg5rW+jSSaKICXPn2Uk2nDMv/L0uRG4YepGcOdwa0gIMCFRYTAu48xshOoj2FsYu3qTfk73k+jA9zI4GJa6mpH9IviCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:05:38 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:05:37 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:42 +0100
Subject: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and above
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=12610;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XyH8clEDv44gw/zS+uCTsWYJDuWWi3H0WWbQdEkNgeM=;
 b=6capvIqUgBibCJyrW0h6JmtsBSyQfsKLpWKX26p9nHEsBsoipiG1vamtoFIsyzLxLM7bV2MpZ
 k8f6dc6mjYyBArKJNlwvfxzZAi3jRIB/dfntCQNN3euXjKaLxhEz4Hb
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0040.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 6088cb3b-3798-48ec-16d9-08def6f0d5ff
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 SG+0E3DXEAAxZEUpIYZIzBhSwM1VvNuHImmu1DMlngUSqjwNndDRrogctSUBJ5uzurgi4ge88Ut44401r0bbsV6JugCeN6sx/QZM19eiNBNrWuU/2Se9A34KKTGjXGRlD3tYvmTO9wcYLTX54E4OCaVC0RQ859ztvcd5MoH25znHqack7YtiVBtA7VKXBsVAi2PkCnB5q0r7zTO9rbFmXH1fvzElAGTjwv3go6W7TfCrnEUl5+o3XHiw7xVfcFN6QJ0xA7r35S8sFBqLCaeHuy9OeGP8s30O7/PFvS5/JG53CPDesnOS4hAPQ2qN6ClLVzsxJUi7E/UfUCyOz/Z+hb/Ix1EYKX+JQ3hKd/gX0nV5R1EIwb3Lz2PXtxm0ydAQ3nR+di2n9ioYCe3NyKtrDvYzGGBHKJmRZrt6tnCMo3ZMPGam+obmEyieYYrBO4m03XqEBXhfgXPpUXjcViSWzzdIMdvP036sWj8hzIOvZEL336uWJjb9rFRHjE4H9ecQ7sJtalftduXL98bQIW78FZytRJuKn+czboHRMgNnB+tiKnsa8j3BR4hdrZsRU/eXQNfPLHOcr1wE3KaMk7WkfwrDLn3hvhTu6ynSiNO4pFZFGc4ZwwmMc2GemTt+oKAMqTfMeYWcFvsNA9ZK6QBce/7qxHIaZTB/d3l84gyw2wg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dVF6bTVwTm5ibnF0cDJBMWNnYzRnQVBUaHgzRmFVSWhDdDhualF4SFFTNUNy?=
 =?utf-8?B?LzBFT3FjMEZ2dko4ODZoYWczVElYeDZwakp5NDBrU1VqOUN6UWRwcXYrUmw2?=
 =?utf-8?B?ME9RejhlUElPYWFSRmhEUzNYakFhcUpxcHU1bm14cHllUEZ3eERKSnhKekti?=
 =?utf-8?B?S2d0UUtLcGNqUE5vRHJVa2dHYU1SZzY5WmJ5bDRVMU45S0ZxV1d4TFpERW1T?=
 =?utf-8?B?ZHhYV29BV3ZpRzhxTGhSYXhSRkFvbWZxUkJKaUVWZVh3dTc4eDZBd2dXMEpz?=
 =?utf-8?B?UzYwdFhhQTRBWnovczRrYVpTKzR0YWE5bkpuOHYvZWVwTExtZUZsem1pK1Mx?=
 =?utf-8?B?dU9LQzBUTmRaaDlUeGxENXdxaHJqcXlnbjNSeXd4VTlHNkUxNFhIdXNLUkxx?=
 =?utf-8?B?d1pKL3RuVy9STXpiZks0RkJ0VVNZVUhVUGV0VitCeUdkTkQ0eWlNV3pYTkhM?=
 =?utf-8?B?WGQ5S25qSEVnSGNKbGJBYThqOUNCd1lOTlB1WHY3NDI2RkY0ejNBbTAvbW9W?=
 =?utf-8?B?b0Z3UzFmZ2tpNnRyYTlPSEU5cG5LemJ5dG00VWN5MnEzdVhqZ2loT2hNdFN3?=
 =?utf-8?B?YTZQb2VXa2ZMaCsrTG5HcnZjYktpWXdQbUt1OHl1WWtyTHJXVFE3eDBsR25L?=
 =?utf-8?B?eEpCSWZrSEJrQjhjOVc5eG8yMWtpallZclRCNEJrZFA4bGZkaXJzdEJvKzJo?=
 =?utf-8?B?OVVqY2w3eWtqc1JGeWQwNUtES0NzYjhPWmR6TjVTZm1jczBOdWJSMUdkcUh6?=
 =?utf-8?B?ZzdiclhOTy8zTjRyeENGcEZzRjNlSGZWU1RtMU16OWlaUGp1UWkrT2xKT1Vz?=
 =?utf-8?B?V3NrVXMrclQ2WGV1UjJqZytjd0xqUG91L3FEbm9GK0hkRmpmdDRUemZFd2ZW?=
 =?utf-8?B?cC9GK2ZUL0s1STlySzZnQ2lUcHZzTmpONzRMZSszNUxVck92b2R5UnVLZGc3?=
 =?utf-8?B?NjREM3JOdkxmQjlhMk4rSnNSdk4rQVY3TVo3cmVJUk5wa3R6M3lYa1BkWS9M?=
 =?utf-8?B?V0hrdlk4VUViaU9mSkt1VytYZGM3blE3Z3pmbldhZTloZU41TUIwSHB6bEZQ?=
 =?utf-8?B?bi9DamJZdjdVaTh0U09iOHhjTXdPMCsybUtIMU90MUxYZHV2MmdSTWdTbHli?=
 =?utf-8?B?OUJVNmV1TDVSRUhsY3dGTnhFaXpkM0ZVTER6ZFdCKzU3cU4yQ0lPaFV2U1l6?=
 =?utf-8?B?NzJzQk1DQ2tOa0NNZklEaUt5YmxYazVSdVRCVUYxMTVBSlA1cWZqVkt2dWVV?=
 =?utf-8?B?NFZYWGZiMjFzMmppWGw4MGZpWXB4R0FpKzIyb1JTNG10MDRGVDlUeUNqUDN1?=
 =?utf-8?B?Y2NOcUJ3SDM3NXlrQ3F0UkszVGZRMkdZVUFNOEc5ckJydS9hQlNhVzd4UlBO?=
 =?utf-8?B?dk9RTHZuNlFsbGRWWnhwSStxck1jbDZJenoxSFJBZHVFb09mQ29UZ2pEbkdw?=
 =?utf-8?B?d25zQ0NId2s4eE9KcXpGVDR3dmdSTXE5TDhDU3djQkdsSEFXNXJURFpXdm9J?=
 =?utf-8?B?Y2ZrUlA2RlY1d0xtanYwU2d1eUJQU3JoY2JUV29iYm9sQzh3dGZhaHVONHZr?=
 =?utf-8?B?MVkvSEU1OG10VWhidm5Iai82dUV2MFhFdEszM29meXVEbDR2UGNoOUwwZVkw?=
 =?utf-8?B?WWorLy9DTXNzcC9tOUxxTmdWdVlKcnZOZXNVT3FncWIrSC85ZVdHL2tzMDhE?=
 =?utf-8?B?TGhRa2t4bU9CYjk5bHc4KzBEWU1ZVHVQcEIwVGViYVhzNVk5UU12cGRyTW5l?=
 =?utf-8?B?Wm93bHg5UTlwTG5mMGgzZE84anUxMHpJbjE5TFpPS3FLdXFHeFhwM0V5WHBY?=
 =?utf-8?B?Q09QNk14bWxoREQ5bjY0WVAzZm1OWkQ3SzJIVVNHZ0VacG1wYlplMzlMaklR?=
 =?utf-8?B?UTU5NGdaZFhSci84b3h4MnFvd25ucmwwcU9zQkwvb3hLcEs4YjVLajZxMU1u?=
 =?utf-8?B?TlhQbnlMaGk0MjBpOVRqWDRTTlQvYzZIYUVSN3lFZUR1Zm9WNk54bjZkN2lS?=
 =?utf-8?B?WjBwd2tpSnBLQ0JPVkxscDRUZnpnRDNlMnI2aDFLT0J0TmV0SXg0TEVqRGxi?=
 =?utf-8?B?OHNqQUFJcnRkcVRjYkNoem12czNRSmhyNE5XbnhKZHFqeldKR01lOHdMamRF?=
 =?utf-8?B?Z3VTNysvV0k5RWJmNUdkbzBhZ3lXRjA1WExyVVJVSlZCUmc2dzViWnlRelZC?=
 =?utf-8?B?MFh5ak1WQm1IWkVxaktJQitveExkcllMdGlEZkVHRUF2MUIydGp5RlVMTHZr?=
 =?utf-8?B?aGo3M0VuK2ttdC9oTHpHUm1sOUhZcDBHMi9vVGpCTmt0Vmo5ZURBR21rQzR0?=
 =?utf-8?B?TVNibFczNFY5N2E1ZkZvT29rVFRjQTFyWUhBVmVNVWVjSUxWRU9vZz09?=
X-Exchange-RoutingPolicyChecked:
	YlbKh46FmzWqkBBuzz2zfJns2SYGSskee+Qf59UMpVfARtATvyiCXDucBIPwtgs8YXDipPtm8bFWJJ8wt/J2CqiqrqctuamPSYyNsJ7aN8/lcFvHx2kErgFTC03gcG7gOwebALZG/VBXr1N6koLm1eOYSUrQcsYWE/hY84yddI5yGwF3J9i1S1GUVFjv1JbLCxOdvzFFVBqHZidjQFqN+EM7o9RqN43sV1N850P7+KlQYFk1jjeJidZg9Y3dHasGs15BxOgadFX2n5C6z9N2W1RuSxN5JFWMMsYSnlQvkgoeREWurwCsZe3HbHgEf8bSs2FGdYLY3hwxvXw6HofPoA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6088cb3b-3798-48ec-16d9-08def6f0d5ff
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:05:37.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBF3fF6bgy+Yn+e076Q2NTlLjAP736sTAyashssHp8BJU+5GRNMvePA3wqQ3dwav0E4yqN35ZAxu9qwPRTuyeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: ALO7TzsxoH6KbEw1yU2pFrmDc2HIcldt
X-Proofpoint-GUID: ALO7TzsxoH6KbEw1yU2pFrmDc2HIcldt
X-Authority-Analysis: v=2.4 cv=MLBQXsZl c=1 sm=1 tr=0 ts=6a79e8cc cx=c_pps
 a=1PMvcOD3Mx+UKTR1GZf1Bw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=1fD2EcCrBUfel4lrjFMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX67ZuDENJNLrg
 nYisxCgNpVgzV2wbwZHDTVNPXnsVGUdU/8NsIbfVLjn9bvLPhPj6IMBe67PqW6+DnB6rNOAtPc2
 43p7ZfXQMMYfGjxGNk0QAlFVwhXhLUzfk0WOrxcgb/4UQzTZIEaUs3Y0GUFP2mmYnuR1Sow+S3S
 2R3AYO14Vuo4zvU5cu3Zl2DV45ldtXNCsS1xIah0qMmcka8gtT/hChe/w00heDO3nO5KOlcdKzK
 qMD4ta6ckktEYyWxXvPA8NYlqWYst7Ycl9LoFHDr/q9g17wMf1PSoFzQ0Qzivz6my4/iwsaWPjS
 55F6pQnAP1EVFVoFHc38OiOYRm7lq8cgC5nGyYwoHVmSUCg1Yqsq8yECNd0v9QkySrte6UfX70o
 UvKwaO/4Xr5VddInN9mMBx8mmY+j4X30g21POaj4RVSOt5G2DGl+ZRk8mlxv5hz5VdYKyzNfnQn
 9Y/HqmPxfguUgnGALaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX7lMCVADCegRA
 VAJr6lFkoEVvoN6jTWGxhtZL+2/qmNuaAdw0jMwOLfywlXlM4NJs5idDtjJ52DxW/FP+eTScGwJ
 QCYg9zHazBsJAh+QY7WuzbQ1xF7iWv8tGNW/Q/iRF7ECYIfIYynd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

The src_addr_widths and dst_addr_widths capability masks encode each
supported width as a bit whose position equals the corresponding
enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
4). As these masks are plain u32, widths of 32 bytes and above
(DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
be represented at all.

Introduce bitmap-based bus width capabilities that span the full enum
range. To allow DMA controller producers to be converted incrementally,
keep the legacy dma_device u32 fields alongside the new bitmaps:
producers using the new helpers populate the bitmap and mirror the low
32 bits back into the legacy field, while dma_get_slave_caps() folds a
legacy-only producer's u32 into the returned bitmap.

Add helpers for producers and consumers so users do not need to depend
on the bitmap layout directly. Once the remaining producers are
converted, the legacy dma_device u32 fields can be dropped.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   |  18 ++++
 include/linux/dmaengine.h | 246 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 254 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154..a80a84cf87eb 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -593,7 +593,25 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 		return -ENXIO;
 
 	caps->src_addr_widths = device->src_addr_widths;
+	if (bitmap_empty(device->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
+		bitmap_zero(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
+		bitmap_from_arr32(caps->src_bus_widths,
+				  &device->src_addr_widths, 32);
+	} else {
+		bitmap_copy(caps->src_bus_widths, device->src_bus_widths,
+			    DMA_SLAVE_BUSWIDTH_MAX);
+	}
+
 	caps->dst_addr_widths = device->dst_addr_widths;
+	if (bitmap_empty(device->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
+		bitmap_zero(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
+		bitmap_from_arr32(caps->dst_bus_widths,
+				  &device->dst_addr_widths, 32);
+	} else {
+		bitmap_copy(caps->dst_bus_widths, device->dst_bus_widths,
+			    DMA_SLAVE_BUSWIDTH_MAX);
+	}
+
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index fe33a20abc61..8697583e2ed3 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -5,6 +5,7 @@
 #ifndef LINUX_DMAENGINE_H
 #define LINUX_DMAENGINE_H
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/uio.h>
@@ -399,8 +400,12 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
 	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
+	DMA_SLAVE_BUSWIDTH_MAX
 };
 
+#define DECLARE_DMA_BUS_WIDTHS(name) \
+	DECLARE_BITMAP(name, DMA_SLAVE_BUSWIDTH_MAX)
+
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
@@ -495,10 +500,12 @@ enum dma_residue_granularity {
 
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
- * @src_addr_widths: bit mask of src addr widths the channel supports.
+ * @src_bus_widths: bitmap of source bus widths the channel supports.
  *	Width is specified in bytes, e.g. for a channel supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the channel supports
+ *	a width of 4 the bitmap should have bit 4 set.
+ * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
+ * @dst_bus_widths: bitmap of destination bus widths the channel supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the channel supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -517,8 +524,14 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
+		u32 src_addr_widths;
+	};
+	struct {
+		DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -811,10 +824,12 @@ struct dma_filter {
  * @dev: struct device reference for dma mapping api
  * @owner: owner module (automatically set based on the provided dev)
  * @chan_ida: unique channel ID
- * @src_addr_widths: bit mask of src addr widths the device supports
+ * @src_bus_widths: bitmap of source bus widths the device supports.
  *	Width is specified in bytes, e.g. for a device supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the device supports
+ *	a width of 4 the bitmap should have bit 4 set.
+ * @src_addr_widths: legacy bit mask of source bus widths the device supports.
+ * @dst_bus_widths: bitmap of destination bus widths the device supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the device supports.
  * @directions: bit mask of slave directions the device supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -896,8 +911,14 @@ struct dma_device {
 	struct module *owner;
 	struct ida chan_ida;
 
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
+		u32 src_addr_widths;
+	};
+	struct {
+		DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -1811,4 +1832,209 @@ static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
 	return chan->device->dev;
 }
 
+static inline enum dma_slave_buswidth
+__dma_slave_caps_get_width_min(const unsigned long *bus_widths)
+{
+	enum dma_slave_buswidth width = find_first_bit(bus_widths,
+						       DMA_SLAVE_BUSWIDTH_MAX);
+
+	if (width == DMA_SLAVE_BUSWIDTH_MAX)
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+
+	return width;
+}
+
+/**
+ * dma_slave_caps_get_src_width_min - get the minimum source bus width
+ * @caps: DMA slave capabilities
+ *
+ * Return: the minimum supported source bus width, or
+ * %DMA_SLAVE_BUSWIDTH_UNDEFINED if no source bus width is advertised.
+ */
+static inline enum dma_slave_buswidth
+dma_slave_caps_get_src_width_min(const struct dma_slave_caps *caps)
+{
+	return __dma_slave_caps_get_width_min(caps->src_bus_widths);
+}
+
+/**
+ * dma_slave_caps_get_dst_width_min - get the minimum destination bus width
+ * @caps: DMA slave capabilities
+ *
+ * Return: the minimum supported destination bus width, or
+ * %DMA_SLAVE_BUSWIDTH_UNDEFINED if no destination bus width is advertised.
+ */
+static inline enum dma_slave_buswidth
+dma_slave_caps_get_dst_width_min(const struct dma_slave_caps *caps)
+{
+	return __dma_slave_caps_get_width_min(caps->dst_bus_widths);
+}
+
+/**
+ * dma_slave_caps_copy_src_widths - copy source bus width capabilities
+ * @caps: DMA slave capabilities
+ * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
+ */
+static inline void
+dma_slave_caps_copy_src_widths(const struct dma_slave_caps *caps,
+			       unsigned long *bus_widths)
+{
+	bitmap_copy(bus_widths, caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
+}
+
+/**
+ * dma_slave_caps_copy_dst_widths - copy destination bus width capabilities
+ * @caps: DMA slave capabilities
+ * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
+ */
+static inline void
+dma_slave_caps_copy_dst_widths(const struct dma_slave_caps *caps,
+			       unsigned long *bus_widths)
+{
+	bitmap_copy(bus_widths, caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
+}
+
+/**
+ * dma_slave_caps_intersect_widths - intersect destination and source widths
+ * @dst_caps: DMA slave capabilities providing destination bus widths
+ * @src_caps: DMA slave capabilities providing source bus widths
+ * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
+ *
+ * Return: true if the resulting bitmap contains at least one common bus width,
+ * false otherwise.
+ */
+static inline bool
+dma_slave_caps_intersect_widths(const struct dma_slave_caps *dst_caps,
+				const struct dma_slave_caps *src_caps,
+				unsigned long *bus_widths)
+{
+	return bitmap_and(bus_widths, dst_caps->dst_bus_widths,
+			  src_caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
+}
+
+/**
+ * dma_slave_caps_clear_src_width - clear a source bus width capability
+ * @caps: DMA slave capabilities
+ * @width: source bus width to clear
+ */
+static inline void
+dma_slave_caps_clear_src_width(struct dma_slave_caps *caps,
+			       enum dma_slave_buswidth width)
+{
+	__clear_bit(width, caps->src_bus_widths);
+	if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
+		caps->src_addr_widths &= ~BIT(width);
+}
+
+/**
+ * dma_slave_caps_clear_dst_width - clear a destination bus width capability
+ * @caps: DMA slave capabilities
+ * @width: destination bus width to clear
+ */
+static inline void
+dma_slave_caps_clear_dst_width(struct dma_slave_caps *caps,
+			       enum dma_slave_buswidth width)
+{
+	__clear_bit(width, caps->dst_bus_widths);
+	if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
+		caps->dst_addr_widths &= ~BIT(width);
+}
+
+static inline int __dma_set_bus_widths(unsigned long *bus_widths,
+				       const enum dma_slave_buswidth *widths,
+				       unsigned int n_widths)
+{
+	for (unsigned int i = 0; i < n_widths; i++) {
+		switch (widths[i]) {
+		case DMA_SLAVE_BUSWIDTH_UNDEFINED:
+		case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		case DMA_SLAVE_BUSWIDTH_3_BYTES:
+		case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		case DMA_SLAVE_BUSWIDTH_16_BYTES:
+		case DMA_SLAVE_BUSWIDTH_32_BYTES:
+		case DMA_SLAVE_BUSWIDTH_64_BYTES:
+		case DMA_SLAVE_BUSWIDTH_128_BYTES:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		__set_bit(widths[i], bus_widths);
+	}
+
+	return 0;
+}
+
+/**
+ * dma_set_src_bus_widths - set supported source bus widths for a DMA device
+ * @device: DMA device
+ * @widths: array of supported source bus widths
+ * @n_widths: number of entries in @widths
+ *
+ * Return: 0 on success, -EINVAL if @widths contains an invalid bus width.
+ */
+static inline int dma_set_src_bus_widths(struct dma_device *device,
+					 const enum dma_slave_buswidth *widths,
+					 unsigned int n_widths)
+{
+	int ret;
+
+	ret = __dma_set_bus_widths(device->src_bus_widths, widths, n_widths);
+	if (ret)
+		return ret;
+
+	device->src_addr_widths = bitmap_read(device->src_bus_widths, 0, 32);
+	return 0;
+}
+
+/**
+ * dma_set_dst_bus_widths - set supported destination bus widths for a DMA device
+ * @device: DMA device
+ * @widths: array of supported destination bus widths
+ * @n_widths: number of entries in @widths
+ *
+ * Return: 0 on success, -EINVAL if @widths contains an invalid bus width.
+ */
+static inline int dma_set_dst_bus_widths(struct dma_device *device,
+					 const enum dma_slave_buswidth *widths,
+					 unsigned int n_widths)
+{
+	int ret;
+
+	ret = __dma_set_bus_widths(device->dst_bus_widths, widths, n_widths);
+	if (ret)
+		return ret;
+
+	device->dst_addr_widths = bitmap_read(device->dst_bus_widths, 0, 32);
+	return 0;
+}
+
+/**
+ * dma_set_src_bus_width - set a single supported source bus width
+ * @device: DMA device
+ * @width: supported source bus width
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+static inline int dma_set_src_bus_width(struct dma_device *device,
+					enum dma_slave_buswidth width)
+{
+	return dma_set_src_bus_widths(device, &width, 1);
+}
+
+/**
+ * dma_set_dst_bus_width - set a single supported destination bus width
+ * @device: DMA device
+ * @width: supported destination bus width
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+static inline int dma_set_dst_bus_width(struct dma_device *device,
+					enum dma_slave_buswidth width)
+{
+	return dma_set_dst_bus_widths(device, &width, 1);
+}
+
 #endif /* DMAENGINE_H */

-- 
2.55.0

