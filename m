Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B347ACE9
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071470; cv=fail; b=TeQFPFWL+i2yMvjxoKiCN6mzn3nlsRhxtF54HI6nLWFO21xJTw5q4WwN7twQxuGCBHE/zuoHOOqKHbQWYKdwrryFbpGbzegVIlZlFcyMKmQX2cfxgnvZsVl4a3zoFOdmD5EyYzhh2ovpAxtqDMendeSNG3D9APA1KiAeTf0tLkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071470; c=relaxed/simple;
	bh=y8FACTn1QMnQcaToQkQO6Psx7KNVMYQx9XlhsTKPzzM=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=q1d3509/KK2+QCyH758+Y1wAKDmL8lVbzy+NeXeLOicc4IUQRWLWODFrj/nFePqZv/AJTtKZFk8qjlqYXOJXtJ/RKtZp0tjWNlwSr6d6KTBNAL1/Opk+amf5I3lXndpVxCgFA8FzUZBOGA3CrgJOGtIsl1IyFhy9b/qbfD2dY8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ta4mKWSa; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ta4mKWSa"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDuZht3122117;
	Tue, 18 Aug 2026 12:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=M8rSe0COEUmRf9cKoD+7tClkRMJ
	KUb4ppLbUTsfadtE=; b=Ta4mKWSan+XdGRF1u2cXLc7r+pLCUCvvAFpdUyYADUg
	O30gczvZ6h1jny+UD4AGRoAXMl0UGepGWgNezBGwu789zhycEx+a/H3BZnUElmkj
	hBfr1SC/hT2AYSCv/hiElhEXUZ3IH1H5dnZ5yCvgP5yuFvaxo+P957zWbXr296hD
	YPftvAOIHQ1FwILv/iCYw8egKZaHntU0e9cAfUujtbckCY9qxyVXfcVhZ+gb4f08
	Ltin435Lg+4uu85VQqQ8qnkfxz4axExdN3hgHVmR24X6PKUuPD4QgN3LnizCQKsd
	9hb6BjHiWfKtVFFBzpim9d1qQ90+aCIQeJiG7MiGidg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4nr221gf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:44:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFrgj2+IqEkfciScjVPXzfqdG712s/FDaP1tH4wRFg/g81ZIN/Kx1okRW3EJqI3gh223s+q0vdmrAQ1r9PmsVzifT2dLfPXiDAj2y6cqkg+/SShseIgstWD2kiXRKxmYT+kyVfkrZgxX3IqBBgCwQ8hAUc7fDWW2ZG+5SIJB/fo85fSvo/AbfF7AziIANjWnjktmtpNb5TUkdUFKGGB4rde4D6twF8SaXbCT7CfJAowb/UT094G45e6aS8iH/H9rCe0O6pNZaUKk4Rdm728+hbxVLOw2ai41pM1mVeBdpATe1XDl1C396V3OgrGqSR315rKEO7yQ4wGDIznsjBpRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8rSe0COEUmRf9cKoD+7tClkRMJKUb4ppLbUTsfadtE=;
 b=F4Lfwz8yxc8VHL5QbAxHINu4JO9LECXHHw2eqK9iIRQa4zIUDLuBBArTrxWHDorLqZnBOyBAQtHwT4DYH7Rl/j2psW8O2rvIroQf9bwqy8Wsfbn+Qb99z4f9KWYBI2A1efGbURyFCfBUtJ84/fy2iYBXitdeegEDPjQob16H4aQqhXZZiILHMNF24uFsyd1gFT/0LY87oVH+VqddLV51CZ8QpqJBhFFEBVNhm7zvHjs4kKRdq/r0XdTfSj/vP3CddZmOiRbYyeQkaZt9wGuBhkdkac0frix65nrSfh6a2a6mnmxw44PNW78cOYeH8OrkMi/f6ZJSdE8loHvxRylM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH0PR03MB6131.namprd03.prod.outlook.com (2603:10b6:610:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 16:44:19 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:44:19 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 18 Aug 2026 17:45:29 +0100
Subject: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDvghCrBq5QukjhTR4gpSSMF8
 e5N291/m39A4axcYOoOyLxr0bQ10KWDsLjtwahzM5jejL0li6oJfRXhjHN0rVBTjBVFA5I3loQ
 GHtwV2uGZWfT9u9/uf5fqVw6v7xLO8wNOaENrfwAAAA==
X-Change-ID: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
To: linux-iio@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787071529; l=3689;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oZNadnV7r9fZvr13lVRBWDxWR2Twmeu+TE3/w+jeHU8=;
 b=AdHtaHRzrDzY4pXhcWGrkD+CnjaS4zydcOEpfKlx4LkKpyHoAs5u9QMNgjn9O9rAf9dPJjWVn
 CaAcSgBlCdDCxCnB8UQLLZME9EQgCnIAo+Go7gqlt2xJBvPNInRPuvc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0195.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH0PR03MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 07020270-a97d-4fba-8315-08defd47f2ab
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
 b8auG3n4jHCbjNHBh5QjrlJzcnl4/nx0itckY71v4RdX27bPIxNgESS0TuC7lIQMxRzfW3RUnwyJ+fLCG62WenSkq/X6RSt7o/NUdifkm4QPhx+VErAWGcCSYuJVrj5qFvBoDQzxEFJ+MhY45BSry7lE2Fwxa7bST/OnYruSMjo5HROCz3LesLyKE6yoXAvfQd79L3l/mLhm4gB3xSjHsqRIt4YVkLx7QTCEB+IJ6Oq+PA8JcBucbG/PBybpaVuEjGyf6/5KAbxHBvdg1Duip3g1glEhajxvtA0F6JxM37wSczqlMcibOutJB5vyNqsUnO4uE17bbyafQFdcbQOUELcozfaDa4DohsnJ7aoUTrTVRtavr6nY1aJkkQmNsiEWBmgNnON5faBZjF8oUZ/lCaYt8T5KxVPcBoVT4sQESp8CV/aSolc5NeYaJHBMFP4Zopmqs5Nq26Mgx10cb+Xq8owAugGuJQwRaqIRKPubuUfYy5/iKBaciHo44Gj38BZmZ5PsYBmpP/ZR2Mrdjco3q9amUnJFpuBl7dbkOfE4ikZob264022ty0E1iWjXefuWY8HI6apAknGK9ghh6itjvOqNfQp619jmyBuwSqRhiyDDrsNNP2m0ISbz84wfX71utftRMKgdlxItsHSmpxL8zuEfVCL7/fHkBgc769IFc/w=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SzdpalppZkU1QThTckNCZzNKaVNqMnVsWFMwQWYzYlIrNjBHNW1DdEJacFZI?=
 =?utf-8?B?Y2toeHUyZjhrU3FLbEViMDNYVkFSYlFmSG1acitzdm0rWm5jMDZ0dVB5NFFv?=
 =?utf-8?B?Q1RRdkJzQ05vbTRwUUkwempTaHIyeTljc3BEK2JmclFPM0ZydG5XVHp3NThx?=
 =?utf-8?B?NTRSNjBlQkxqVk1QNG13M1dpYUsybzc1a1lManFVbi8yemRTL0lINWEzQ0ly?=
 =?utf-8?B?aW9aREt5b203V3lLSVN1US9KWU9HZndVQTZMdlpvVTRUTHRVa0xrUUg5OUdm?=
 =?utf-8?B?MVRaZmg4WTBjMEJVc1gxcFZLKzhKVCsrbTBIcGdnT3MxZXBnbVB0SXJ6YjMv?=
 =?utf-8?B?b0ZvZjNKTkdGbTJuMjVwaCtURlhxaitQVlZlTENJWjM3RTFzWHNoNVdiN2I5?=
 =?utf-8?B?WGZ5WkdzQys2UDltbExjWE52ZThhakY3Zmx1SERqM3FZRFNlbmM2SktxU2g1?=
 =?utf-8?B?MEpaZUk3SWt1SlRxei8xZlpGcjBCWGgxTUtrbktqeVJjK2FuQzc1WE1HVkd1?=
 =?utf-8?B?S21PeHpkMGFzcWl4Q0NmTFdFSUliNWMzV3VOTFpaWkNIWHE5UWd4U3ZJai8r?=
 =?utf-8?B?bElkZnFUZERLVFRTK2JOcmlkeWZnaldYZ0RxMDgwdldKZTBCa0I0aEVFNkNi?=
 =?utf-8?B?N1R2NHFKTmw4dHFLUWJWOGhObTdqQytpQTNUNk9hTm4wMFZoNUI0TE5XS0V3?=
 =?utf-8?B?V1NwdWpBQzJMSTJYZCttTVdYc3dBWis5RFUwWitNbG5Rc3VQa3pncnhDUC9O?=
 =?utf-8?B?dEkrcTIrM3BzeFBJaU95TXpUYTBNM2NSYmFaZ3dCQ2sySFRuUzFvOUFIQXIz?=
 =?utf-8?B?dlp0Wno4RkNwbjZRQWJoa1AyQ2gzUkJIOXhWbG9oWGR5U3B1ekNicUtpOXJQ?=
 =?utf-8?B?UERrTGtTQWJOdjU3SGQvNlBMaCtNbzJ6M2wvN0E2WXB1bVdsOTBhNVhuRUQ2?=
 =?utf-8?B?Y0xnSzFzb1k5bkxKZnAxcGM2K3hLcitnRHRpYzNpeUU1SnZnamZjdTdOUHMv?=
 =?utf-8?B?ZjJLakw3aUtjT0tZRnc3TVlBcEsyZ2s0SVE1dlZCSTBBTjFrRzkvYWtLcmQ5?=
 =?utf-8?B?Q3FvenczcW1MYTk1S0tzWUJCTjRnaUpaMitHWk8yNjFKYk5uZ1pUcEp2ampk?=
 =?utf-8?B?MEJiZDVVcWpCQkVsVEo3bUZZYk9XTHcvWnBGV1hXWVBkVHZYSWUwUWQ0R2pN?=
 =?utf-8?B?NWllSGdRM3JHd3d2aUZHL2Y2SmdRQUFYS0ZDRmZLNWY4bkx6TTBPVnB4d0sv?=
 =?utf-8?B?ZUZuYmFZU3pqdXEyMlRvSFpyTGZCTmo2cDlmUTVjb0Nydk1EUFZOZGpZRDhU?=
 =?utf-8?B?dUVQK2tNQzV0TTFheENiM2FmcWU2RFdJTnQ0TmdXbkZSOFJMNTUvRFlyQWxR?=
 =?utf-8?B?YkdGc1NIemtaQ3pWMDk1NTgzQTZLSjU3SlkwVjI4UHFsbDU5SUFzNFNpSC9R?=
 =?utf-8?B?WmhSajYranJjcGJtYm9jcFByWFdBdHp5djduenROU2pra1pLWHVYcEpwMzdT?=
 =?utf-8?B?TWVnVEo4d0VkdWFmYWRsMDgzcG14clYxUVhvQzBXaDV1YURMd0JPaUxrRVNz?=
 =?utf-8?B?Vy9RRDB1ZU5Za2dxY09OVWpyampmTjEwbTlpamRudm5BNnEvU2k3ZzEwS3Ra?=
 =?utf-8?B?UU92OU5hekprY2JzWlNuWE9teGh2bW4zMkdlSUo4UEQxazFoQXZpelA3RGpZ?=
 =?utf-8?B?NTF1WW5hT1U1MWV5ZmVRV3phbVUzb3NXTVRWVjVvTmhqZEpodEZvVnU4S1N1?=
 =?utf-8?B?c0hVQ2hJa2w3NXh6bmQzMnZPNGtnRmVpVUJ3clRHd0dVY0kxK21FWTUyUlkr?=
 =?utf-8?B?K0FpM1FnaTE5TnN4Mk4zZUJUcS8zZzJvcGpEL3d1K05tR3dMb2lhVUw1MEQx?=
 =?utf-8?B?Zm9GOVJVUDdJc1Zxdk5hYzJPbzYyRG1lUmdLay9yZzhCS01hVzFEV3BaQVJ1?=
 =?utf-8?B?ek4rM2xUajBYQVVmRW5tbHN4YUxJRUM1QW9kNXp1ZlkwRXF5NDBFcGdYYzRG?=
 =?utf-8?B?ZFBnSURYN0FpSXQ1TGR1M3hySkRmdUdCdnYxUzc0M1BNaDNJTG1uVVdaOW02?=
 =?utf-8?B?T2RIRGxaeDdFcys0dnl6elBFNHFFdHZsMzluWVdkamxjL2tVOVBxSFg4bzhj?=
 =?utf-8?B?UGlVYnk5OW1RbmJIRUx0L2hKYlZLbCtzejlrU3hhV3ZEdGlZcmhyZGdtY0I3?=
 =?utf-8?B?M3FyWlY4TXljdUkzUVB2dVBENGNZMDRSdGxMLzFyZVZEenlQS0Z0bUlvUnN5?=
 =?utf-8?B?RXVwblpBZEhIakN0RWtHUHNaQ1pXY2l3RDhQRlhmNVR2bDV4bFp2ZVNQQ1VW?=
 =?utf-8?B?RjYrL1Rnb2Q0NVEyTmJCK3AxM21LTWRmRVBjWU55WEdyUGs0MzFhZz09?=
X-Exchange-RoutingPolicyChecked:
	oyO2iynQUuhzEAToIUzxi0UQ8ueoMxgQPzt1tC7EHw+nh44m6dJVgqMJmyjzeM8EYvLNNTH8Qr+A0PK/rCVit+NqI4fPUWIDW9hZzfZgBo5udxsp1sawBHDAh4tKuDOsy/zMxvba9GGW8v4clsg9MneDx0UDreY7D0++sF1ohDpt6UbFrrf9BuogIQjmqM/GmWAc+93w4d3ZfEzZHM2yiYW+amyy/yjE20c+DHNBT672F0bjU14r/DQI+I4PtJH6dbHdVrC2bjV7NXtALEXbeIgpKhnHYLL+3Q4ZSBWkkH2YSiJu3mCwNJwLMrHrBeu+dm0kqA/H1aqZjXub1VGVtg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07020270-a97d-4fba-8315-08defd47f2ab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:44:19.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pGPYucWialwgHNy3mvSuUme4PZhoKtIS1a01G+9QmI75nQSTEBD5Q1WYWaCug96+SGIzJYqrWUJmpvoSOyEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyMyBTYWx0ZWRfX2Q3oKwTXHfQ5
 D/b99uy1VcYwOJ/9TOdfh1eQdLlGpKLAO8/cXCF3yhyodLrhbKsKlg08Z5STNfpWDo0WX+VH3GM
 kzqeoViW+AblDwkj1peDWuxl4FDtiezNfQ7F3r8zCLiY+ptwrOLUXUoiPzRQU068md1WPXeKWSH
 DEr1crISmc3ZWHwULiBxHacLH648D7oU/gQSoFc90yBlcBI5QJOr61+OH/24YujO8qps/omQ8fB
 L52k1ViQKhWzOqsHccRtPvaV/EG2pu3mtjYccl65IU53gXyDSuNcwtzIV38t2t137EdXXr1ShEh
 D9rBqOTAVhgdRgI0IqqSGK86fZP0IrTcgoit19/LX8VgSYdPNRcaygsZ59edTVIOocPo0ldxahs
 T+6JGuiLRCYLNGYa648Q/Ju8idnKP/wfjKN4U7jA7OcgtloPtFVwIn6us/LJQqUKxl5yOD1QO3r
 73hAKibRocPZHesv44Q==
X-Proofpoint-GUID: xkd9ofoDOg_x42Malp2xQ5W4diLp79bo
X-Authority-Analysis: v=2.4 cv=B7CJFutM c=1 sm=1 tr=0 ts=6a848be6 cx=c_pps
 a=T1Ebi/dL4O4Qy7Yf5tf31Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=Ce2Is0pj2Y6IPfHFaBoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyMyBTYWx0ZWRfXyPDenTKAXZrJ
 1PnnwCS/u1akkOKQLn5GkULzKSTt7qSlf0Q8N7E7wRorinWLqfQi+EMIcuhzB5xeLzKibEmfuvF
 Jhkfm2Z/5fl/8jWSqNgklL1XAQdZF+T5lGs3T5IKr0pckOfKxf52
X-Proofpoint-ORIG-GUID: xkd9ofoDOg_x42Malp2xQ5W4diLp79bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180123

From: Michael Hennerich <michael.hennerich@analog.com>

iio_dmaengine_buffer_submit_block() counts scatterlist entries with
sg_nents_for_len(), which walks the CPU-side lengths (sg->length), but
then consumes the DMA-side fields (sg_dma_address()/sg_dma_len()).
After dma_map_sgtable() the two views may differ: an IOMMU can coalesce
the mapping so that only the first sgt->nents entries carry valid DMA
addresses, with nents < orig_nents.

On x86 with an IOMMU enabled, a DMABUF block backed by two 1 MiB
system-heap chunks maps to a single 2 MiB IOVA range. The CPU-side
count is 2, so the loop reads one entry past the mapped set and emits a
garbage vec ({addr = ~0, len = 0}). The DMA engine driver rejects the
vec array (prep returns NULL), the fence is signalled with -ENOMEM,
which a userspace poller cannot observe, and the block is left in
ACTIVE state so every further enqueue of it fails with -EBUSY. The
visible symptom is a stream of zero-filled blocks followed by a wedged
buffer.

Platforms without an IOMMU never hit this because nents == orig_nents.

Size the vec array with sg_nents_for_dma(), which walks the DMA-mapped
view and accounts for max-length splitting, and stop the fill loop once
bytes_used is covered - which is allowed to be smaller than the block
size - passing the reduced count to dmaengine_prep_peripheral_dma_vec().

Assisted-by: Claude:claude-fable-5
Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Note the Signed-off-by is just because I'm carrying Michael's patch!
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index ecc02a427b92..bece45381c8c 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -104,10 +104,16 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (block->sg_table) {
 		unsigned long flags;
 
+		/*
+		 * Use the DMA-mapped view of the sg_table: after mapping
+		 * (e.g. through an IOMMU) the DMA entries (sgt->nents) can be
+		 * fewer than the CPU entries, and sg_dma_address()/sg_dma_len()
+		 * are only valid for the first sgt->nents entries. Counting
+		 * with sg_nents_for_len() (CPU lengths) walks past them and
+		 * hands garbage vecs to the DMA engine.
+		 */
 		sgl = block->sg_table->sgl;
-		nents = sg_nents_for_len(sgl, block->bytes_used);
-		if (nents < 0)
-			return nents;
+		nents = sg_nents_for_dma(sgl, block->sg_table->nents, max_size);
 
 		vecs = kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
 		if (!vecs)
@@ -115,7 +121,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 
 		len_total = block->bytes_used;
 
-		for (i = 0; i < nents; i++) {
+		for (i = 0; i < nents && len_total; i++) {
 			vecs[i].addr = sg_dma_address(sgl);
 			vecs[i].len = min(sg_dma_len(sgl), len_total);
 			len_total -= vecs[i].len;
@@ -133,6 +139,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 		 * before it can run, so always set the EOT flag.
 		 */
 		flags |= DMA_PREP_LOAD_EOT;
+		nents = i;
+
 		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
 							 vecs, nents, dma_dir,
 							 flags);

---
base-commit: b756b143e5391151e577ae645b1378a43f93c2f5
change-id: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
--

Thanks!
- Nuno Sá

