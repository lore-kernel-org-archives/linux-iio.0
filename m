Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773446C4D0;
	Fri, 14 Aug 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710469; cv=fail; b=PXP+XQxPJ+H3RwWvU+P3GzjrShr8L737d2v5oGmsD8SADtCbb3VzEZh6fEhkv2Xu5PXZnWclX8RLbS0AuAwVx+3Rd1x74Wy7K2CiqFiYTs7jP315Xd95E+s2OpoqCLiTqAJdenOz0jkeVcG14+mK6tRObZtUAcjRAlYQXdTHdBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710469; c=relaxed/simple;
	bh=Bnf3doXNWv6rsWvtitZa3MlVGtEF+NTdJb91pq+wxfQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Lem2W2ik+Gh0ePWRDmewty2dN37fEzvMX26Fir2WsVEB3dKzWR4Iao9/lk8zWsZtAZsb+l8pdAsAf/cMSaydV+kjd/GnmWWzdFteRQAcVvBKMp4I2B/+S1I8fkGyLniLGpmA1PtlJaWw1698LL4jpINe5izC2Wx+fDusaHrX7vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eoyM8rvY; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eoyM8rvY"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAiLo0523852;
	Fri, 14 Aug 2026 08:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bWOG0
	luFqBBix8REOpj5Fpo/tEUVO2mXBy5JBZBzx2w=; b=eoyM8rvYFwuMykopvEPgs
	bqpT11Dqxx5shoBaYJ3WZ5n4CBiwi306w6pW6/v17f2VnFCaAFO4eIdWw5/ZBuaO
	jTjj2GqkxFews7Z+AbUCltqnWA3c/0TOALaD3N8CjanLcf1t7DbQLdRun71rtQcs
	4I5aOGfGrmyOChqaJRAH0maq1lPCIDbcB5jwM+mTRCdwmd0Ro17gkLROENSfJlp7
	1oCKqaynnlSOEV1bdrmDSmg7tqQRVpRqN8PDMaicfCaF2OjEr9fJ68QnxCW4335z
	D+JoBG0to5wst5OXg4n/LsvI58QGWASpif09sLjuugSfbspie3BA1c0cn/2MtyVd
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1fm5n866-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:27:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvf1M3IxT1ULT7z/Le9VrghrBI8ceBLayIM7Vk0PcveJx0Quejm7RQ76i+sL2FJV29FyEmxAxnKqIS4HrovZiDvQwEkBFfSzUV+fA6AZwYqahJxSZpBdjIdXFX0h2EQMWF6SP+i2XRhXDDOoNLbNcCPU+M8SlddUwlfj+BUvvpzykv29lh1TTjy50dloQVTHuavp8FiAWP7RhhOpd19zhe9agi/COd6DIU/oz3Dg5irxFA2NbSnW4zUldd9NPOnV4IF7obYr2l8gwPkraGoJJDKZFypVvJ/gO/5maT8gqEpNGJ5ydRDT+xwyvjSCMuhltba094Rw2MJfHVja8vMlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWOG0luFqBBix8REOpj5Fpo/tEUVO2mXBy5JBZBzx2w=;
 b=Ep3CADA4wbQH8kP2SLhXNx7F7o/KZp33VipaSrQELvlcnVSzuC8qRT/qQGmZAvPgL77Luktzv1rkYhtKpQ2rPxGjZApOBh6SCoju0YR3Qlpd8s3JOhS8NAww02rIpWALZ0ep1hH63ZEwU+gjyWDQ5f4CMoqWFd8v6P0w3PynuBySFl1buCpA1s0CAt4notMrCVp/vqHtD6/DwYTAVCmkOS8bD+jvZKeacsVER+dITepoQPjZoGq5UpB+PbKJUxzePuQBfeF81NbX6O1WsFlBhLpIZRttjBATFz9Vy0RUwawM50lEmqDoFr28pZBlY1/M8FY8khE+HJTqrYvVrKzn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5499.namprd03.prod.outlook.com (2603:10b6:806:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 12:27:35 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 12:27:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] iio: accel: adxl367: update maintainer entries
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux@analog.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260813081452.4289-2-antoniu.miclaus@analog.com>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
 <20260813081452.4289-2-antoniu.miclaus@analog.com>
Date: Fri, 14 Aug 2026 13:28:29 +0100
Message-Id: <178671050966.21598.13832070985589248635.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786710511; l=491;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Bnf3doXNWv6rsWvtitZa3MlVGtEF+NTdJb91pq+wxfQ=;
 b=XMYSaI5f7csPltab6VWiACcMmleAgpJmjslcP3F9EMfCgXFJ48eIaeMZ5WHI9tVDdNDPbtnS2
 KAVzXw0L00KABcAaZj4oMbumKrdeGd50pieGBLpj2tDskayWgACQawT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0129.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: a29bdd58-3c35-4e88-89e4-08def9ff6868
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 tfU8fkkt8sBCy7QHPqdU/nA2rXEBLkmh/CmcbooHBbpnuYpITtsQ5OIXPaI557zdM+QUJnVmNybGzwYIRz6B85J9zmzeeD8jE6NYkp5TZUb625PSdF03xokHTjjpdGVsApC+BW9Ee944y4KBelsd8wzH0runX/TxXkIEp0skB/6Ve9HHWenEyDkFw2kYQreOHFehknw50W8uoBpBSjFvvph4Bof47UK+/sX68OMIjZBXEHU6jrysUWP6YNCPAUqiFdST8RT3PAJ3PSjVNJBFy77peDGWLB+ZeiThTQBDOBaaL+/imTP7n8+kSgcw7WmOzSf1EyZXjkbacjKwXyMdZkOGwcQvS9gLhr/pO4gfjNGOuECiWzN4enbUiY22fwg0BQhDmpqEuaSHF8i9ZIdigD8++pRxFv+WLofluJosf4ctfwnCCMSjsxsep+ucai74E0O4LsjOdvcTdOT/q/V7jwkt/QzggvTNypLad01z0WRZ7+MdnMXnr9/4nzLbA3TP9L5arfjY2AqrWbRXx1cQRww1eaGV5LTB5d7E887tkCapocIwxEMryrMqT3IMMr5Lh2h4O9GTVZqqdXcVdCN4DX6VIg2tNjiKxEosEeJtF0Yrq4DGlYslGPybT0Rw/yL/VtmhkqAAVflqH5xgEcNAGdetunMQMSSuUnNl+oGKG/0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WDBXMHFLNGNScEZPLzczdy91QTBNd01oSzM3ZndMa3FpZ01kWDJEYTBFTms5?=
 =?utf-8?B?M0RQd1lBRUpZUHQ5VWlhbWZyN3MxMU1hazA2MlNZaUhkNHNnNE1HRW1ybU1Y?=
 =?utf-8?B?WVJVbmlqaktsY2FDZkhUcmJ4UTBTaEVuT0E5ZCtLMXNIbTN0Y0phZTJtOWFV?=
 =?utf-8?B?c1FEcXBEcTJlUVp4ckV5KzhlciszWkczS2x3TC80WGRuRTBDT2RHWFlyeURL?=
 =?utf-8?B?dklveXZYQWliVTVCZDVlTEpySHZYVFBwaFFnbjREbk4ranNFeUdiS3J5dVVv?=
 =?utf-8?B?eUxaS2IycTlDUXczZVI3VDdVYlcrRWxFTS9RMUh2S2ZXeE1sSUk4VlFKSjZj?=
 =?utf-8?B?L0U2N0x1MnFEdXlMcXVzOFRKcmJYR2J4akxDOHVrRUhsdE1WTUhncUZ4RUdT?=
 =?utf-8?B?RGhTR3RFRGpJdVRYTzYvMm9uanNvOUNJamcrQnNnbS8yUW10bzZRUktuNkJI?=
 =?utf-8?B?cm1LVkhMRzBPY3dPWmQ0cnFtUUNDZGgwWCszWngwYnh5Z0FwYlBsOFNzYlIr?=
 =?utf-8?B?cXBZdHZMZkZ6RCtzMzc1UlE2ejV3N2pydEg1Zk1mSVFNSFBmcWk5WTRUUmgr?=
 =?utf-8?B?UEpKcW14ME16THo2Uk1FL2tzRFpoK3d4V05UeS9KZ0tOSnBoZTN0ZnN4Q0s3?=
 =?utf-8?B?SzBUYkRkYzQxYU42c1E5WEo2UzR4emRTUnhha1p3emVoaXc5bHUzT0ZGQWMx?=
 =?utf-8?B?b09UaEtjTHBNLzlQbVFOeTRkck41ZUF1WUNIWU5KK2Y0TW5OQlBsTHJBelF3?=
 =?utf-8?B?bXRhbS8ybWMzd2E3d3RrQmhhbnUyRERzN3VnUkxnTXNEVHdFa3JRd2orRStI?=
 =?utf-8?B?MCtSWCtvYk1OSmpJUXVGWE5rYWFYbkU5L1Q1L0VKcm4yZkpYQWRydlhiRnI0?=
 =?utf-8?B?ZEdsWFBYZ0p4aDV2eTZUZ05ianZJVVZTNEhMd2RTcjFTODRVaWNGMVdIUENI?=
 =?utf-8?B?a3lKa2lhazNDdkl1eHhnS25QQjUra1dWejYwTEpxL1VDVDk4RXN3R2hWVFFN?=
 =?utf-8?B?cTFUckJRaEhtL0oyMTRjOHNacjFqblBYR2lqWkV6OEI1Zm1QSHJhQlEwN0Fm?=
 =?utf-8?B?Y3M2TGNHY0hiQUthS2c3MWpLdGlCMXFnU2daL3JESlVxdktxbHRCY3J6QmtJ?=
 =?utf-8?B?T0NoS0FWY3ZpOSt4TFBsR0pJRERJQ0xURzY4TkhNKzJFNGFrdjhWdUpWbmVo?=
 =?utf-8?B?MGdhUVYxMzFlUm9jTVlvZG5JcjBxRnZIQkFKSG9pMUZxT1pYY0p5SkhDejRF?=
 =?utf-8?B?cFRXOHpUL1FvMkt3NFUyakVPdTBEV3lLVUVGVVFJREFSb1dIaXo1N2dySDE2?=
 =?utf-8?B?Zm9OcE4ybW9seGNXaWlWUGo4bXovcisvYUFwVFZvWUs5SjVlUGNXRVNpK0hB?=
 =?utf-8?B?dzhxT3NGY3V6eGR6U1FQNGo4R0JjMlNwem5vVjVYTHRzVjUrZWFmeDhTakFV?=
 =?utf-8?B?a2NHOC95NlNBSUM5TzdaallqRkVQQVV0L3YvbCtrbjQ5V0JoUDFMQm9zUDl1?=
 =?utf-8?B?amFqRGRuTzgvcWJSVXYrM2NGQ3ZPOHE2ZVJteFZYSVRJRW5KQVdCMTJ3eHJE?=
 =?utf-8?B?T2g0Tks5clU4VUdReHVic0xGN2VsNzhEckZmb2xOU3JtY3d4SzJnTW8rd21C?=
 =?utf-8?B?K1pRSXNsZkR5RGs2UEN4V25YKy8wNklOYW9UenQ0czQ4Y0VYcjJib1Vmb0Rx?=
 =?utf-8?B?WFdKQVB5VmxxZTFqa3lVWTE4dHZGcWFjaEMrdlU5VEY3ZXNScm5BcWFITFE0?=
 =?utf-8?B?dTh3bFNnYmtwdGdWdVpnaGdxVXRrMytSZUd0NnhIcHErbEZ3eHhDYm5HdSsr?=
 =?utf-8?B?RWw2dFZHK2hSNlk1TnNpa2VGZnFKak83bUh2NW5WK0VJYVJhdVlNMStlMkFU?=
 =?utf-8?B?TWJCUWdlNXBkbjlUWC9ZWnZOc1FFK1RwMEZPNEg4ZzZHSFhpWnQ2T3dBVld4?=
 =?utf-8?B?WjhDeTNyRFFIamZqM09pd0VPVk9HTE9JdmxNSFY0ZUptbTRTMms4UjM5Q0RS?=
 =?utf-8?B?b25JM3Q4SEpUMWcxemxXNUprQ0ExZWFHQzNFdCtwazNicFpWUGs5M1J0c0dW?=
 =?utf-8?B?VEc5NmwvUWQ5dDlNbVRWWDZJQzc0QWRMWUxBUFUvWTZrTkViYzdXNHZXUVBl?=
 =?utf-8?B?amRMWDlndFd4Q3hNTXhWSHhEQUhuSTJaeTVwMXJ2cmhldVorWWVoMG1IMzBw?=
 =?utf-8?B?SzVzNDUrOVhhclEzeFdDY0k0RW5KdmQwczZCOFpwSWY3YVBJelFySGZQbmdo?=
 =?utf-8?B?ZGt2R3BEZVJTZjFGRkZTU2U4UEhDbENkTEowbmtGbWtIOW5memVuYzVubWhM?=
 =?utf-8?B?Z1NXeW5oRk5JL01HcEc4dkFCNE9kNUdXQ2lYMlVwWldWYUxydGxXQT09?=
X-Exchange-RoutingPolicyChecked:
	Vx6oRNeBhiFUNEOI/qShvDkbUDp1KQ0Clbg6uJQcVaaqXoXMaH/4CZI+qoiA5H16NswQqpFpJYKV1xv326vtVK8m759GIhkzEmAr/Ljl6oGV1gwpptjirkNEmy1ylY9Nmw7wGgFbxPvzR6gAaTG7WJNdKoG9iu3g0lE8My6ocfjkLOMa6mwdOtK7aSFmY3ED4nLIuEYzO+8QU8IM4F/bokAxqmDCS6anSuDlxFkkzi7NbEpHJVSB/Y5y0YYANd9XZ4JvfZG9eIn5/cNhf6nGCT1mrvnsUlNYlfPQwFRqoD0swEVzsO4XvjiWBL4ZqkrFqVpku0JTxnvr3H5lzKk8hw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29bdd58-3c35-4e88-89e4-08def9ff6868
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:27:34.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHvjPOnHIJPosWqLF422sjkBh5eEpWdmjUQZnTi9dYaEiuLg+EHe5lyzytW/aEwXb8m0T3Xt6ukMsvir5JFt1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5499
X-Proofpoint-GUID: AHnJ1E4-EgwNLxB2wp9tfumqQNKNA_ha
X-Authority-Analysis: v=2.4 cv=bMwm5v+Z c=1 sm=1 tr=0 ts=6a7f09ba cx=c_pps
 a=ijphbjn0GKEIB6My7LrvAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=vKRWLZJ7VJhq9iSo_ukA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5NCBTYWx0ZWRfXxbzfpxtEw6g+
 tT7VFhwkxkPh2p47FaKx+fXcHxtjpPRiO01PL8b9dz8vLDFx09xMNDdrp8Vrt58TYe8GgEqDXAX
 5Tay6Qiev6Cvsp5qOUv/O7mLoyqKJGj5KBW81JKAKAUMLKIj5Pm4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5NCBTYWx0ZWRfXwnbwOLV2QIc4
 GKSNUi3y/75IhG8pNpUIhuHqzO6tM0gIOb7lV91fFMwrDfX3Ne2VR4ovVMYNJt1mNOrGSiZQJ67
 P4lvvSVS8mAW43KukKpwMcCRZB3UwglAswe8sztYp+0xh8RfjL4FdF1eCBW3J6220sZXEXVrOvv
 tBSh8Uut7Sr/3MKyHv9nFBAhOT4WrtWeQeHZ/87rtmGVtojfYSp+fdy3C5wdVdnkLJ/Cx2t2rfe
 NUGgvhWt/10ycIic/BMIaJu3Am+UZC3Lq0kyz84GdDI9dpWgDKAOzJsGEZRQRzUtaxVRyfRK58P
 wfLsfK9/uFpo9s913JV3Anqr1yBttmqj+Tm5mPlBX/EU+e+94r1IHXQFKbh72BIxkeAkgRyDdGk
 dviN+FdJz86EIJwf9DeUDNBrmkilg87Qe7yJ97QRfv3OSgmLyH+JUfTE4L/LUloZV8zYOJIMEn9
 hk3f3rUQSqBKfy/D1MQ==
X-Proofpoint-ORIG-GUID: AHnJ1E4-EgwNLxB2wp9tfumqQNKNA_ha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140094

On Thu, 13 Aug 2026 11:14:50 +0300, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> Cosmin's Analog Devices address is no longer valid, leaving the ADXL367
> binding without a reachable maintainer. Take over maintainership of the
> binding and add myself to the MAINTAINERS entry alongside Marcelo.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

With the other ones updated

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
