Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD14307B7;
	Wed, 12 Aug 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537079; cv=fail; b=HByH+YXDZK6YNI3kz4svdoIzO6A3j4ep6EfUyazERU0Op+XLRBa6A+rtJd9nBs8b2McNkLv/zESODm5zkPnwsWKjrrnKKk2oo62NClk2MIcN5wT4UgpyiR6Mhpye4JIwQvQ8YvdxD8IR/x6D0SU7SB7lFafbo0AqXz2nZOOmKT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537079; c=relaxed/simple;
	bh=oKe61e4YBqDAO+qa/9U8Fuknj6KXjdKXKrQxrev9Tg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dpA0R5Tf9bsDA97QSifrEDytrcGcBQGY3T2hw11/OWRZrQxRZQ+rhaIovFhqcgPCXLBlKeD3wjK7jB/z6zgAlZplcurMqJ6t9QohBbyOnbRl4wu2s0N2J+NFeqzHQ71RcShAwOwUvE3PeJwexzwsvJTsCkQce51sqcuyPTi6p+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D4akVckb; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D4akVckb"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB0I4L002982;
	Wed, 12 Aug 2026 08:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4khhF
	R95v5pu6pCS2aY4hXxSq0pz4MCiUdt56xp87Hw=; b=D4akVckbq3ABmH9V+pri0
	pU8iuanoaVors0nteqpMUpyioQ90RDq4bf+W94RhmwaLfvOpqpxrS2FsOUW9UuSa
	nF8qQWp9rWlmv65FBPETMiLminvRLPZ08X/KySjt8QUfXjJnDLObK8/21fHFHQ5l
	CJm60bqH/rL1vHTlC6UOsVioVf96UU0mE0UCgTSjq8uM97PfC1zMp5YbsUebWT+h
	dotwIpjr3G5B6j5ncRedSHVPRcaj2BAQkFJ6DdRk3bD7PaGdx7l/wC+27Y/yZhBN
	TdAVe4tD/u5yH0VUBrts0Mmy0CegufAdn0fKOChQsCr5v89s3TXMkd7CxeXl1CMD
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g0pt3gb2k-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:17:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUg1qd6DMT9ks5QU0tHspXX40hbJzykGaU2l9xRdzY7tHTBs0pbr1/TKZvUD0hb3jiLT9rcsOq/ngFtEibk7vo9aPC8GLEPnLvS59cJyifmIXZ6nyX67vKOaaLzQQXxM69ibUr5Rtn9wxhA4sMBH4gZwKCJHPPB6Qp5zn9btWUlOv7FcOCKSYMI+lNKGi6VM0WvS7jzjhPJHYYHK/tpIP2H6hdGpD0Qng2z+Kpr6GXVbQsuznesrI2bwW15w9sTnElWWR21XlI9fIIpMDnlV2G9htKV7Wu6FOMX/egDqxCDFqAB846rRpPk6QZAU3ehzuFrQhrL1ga/1CtLS+Ry11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4khhFR95v5pu6pCS2aY4hXxSq0pz4MCiUdt56xp87Hw=;
 b=Mx/XO/onN7KRaKh8HsEeyP4FGIrVdLJ9RsVfASXXLhPd+MsalMYi5DHtOO7IeCdVLPxn4ZySYIwp9YAH4LvCxDiBoqKx7PZN+Yw252IQFB9kEJySwGfc0HF2bZvrKTp9sW1Qz0IRrF34QCZTt/zXnODOTm9qeHAx8C+3jcvSOhxeH0tz7SPLzoTFC2W9i8Td1OCWbJ8AKI/K5KxBOovea8yC6yJylHMB40JagYpi+9fAWqSRgNu37bf6MBA6kY5g7Sp5FymXEmtQi5WyRA3vT+Nbox/ks1QADSy4OlG6eMb/rKEoVEBFDxiSgu4fS/6QNGYDk5UxZWS4My85Vdsuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5549.namprd03.prod.outlook.com (2603:10b6:a03:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 12:17:32 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:17:31 +0000
Date: Wed, 12 Aug 2026 13:18:41 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anxasgXZsSKzvxG9@nsa>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
 <anwwrvNLP2OujnWd@nsa>
 <anxBgJZH57acnOZr@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anxBgJZH57acnOZr@ashevche-desk.local>
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 540cf3e5-30c6-4f6c-c066-08def86baefe
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 lQ3pAHYJj5xcYiyMVw2qeD7bn0ntXcCFHPTArjoprLx0W+FxUwwjW6CJThJXxezd/nZJ7zrdUW1Gc+sIBDCMLzsXg1jGKDNizN/xhK5ESCLLbIh82h6+ZIgVXx7Iz6b2G1ydpoltBjO6le6oiU1O3KpmCx7EHTudAsPb+wsN4PDXRy84kBpOqFsnlSJUAcZWNdAwdzP5SQOGkRI0mxlyZKlumIRs8ax1YuYXqb6vgLuaVbPG70ON0AkneoKazkGjaWoYSOLhF4QJAXH8t2D88SERYbFO/PutIloaT/NdXaZIzo/8gdkw7/9nY9kTsGAWWs+808cDZfJAn9JKZ0eUWIHqk4sUYqKxp22djBkjCcVhat4OICAUrCzrRpjfRZt4aB19XK9UpL/KrTL0OLIwnbL1IhrBaAQFGPSA2t7+jvtiUjP1wIDfYFDrlXYK1jfZ9WEuAWk94AZzssiBsMwpDf4vU2cfv2g5hP1UWcv5tBUsd1mY+OznU6wVyYFfh3Lral7mbczjoFCiLiq8WuYeNwvYxMDywj8df20nLXPpKLpRwL66q84bvRRSCRLjeI1zW3df1Spd0iECWEYm/rbvvy1bIPv9C7vZBVOVXrRBTStdPBCraOEcx3iztihi8bKGNMFp06HsVeJIcgJK3RSo9A==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WFY4OWhtbmo3dTc5aWlvQitXencxekFicWRVcGpVWGo1ZlYvR25ZNFFTVjBy?=
 =?utf-8?B?Y2pyc3V5TkowcHhFZ2xQcmQwVXZNNEl5bk1ldmdaRmVTeFg0a1ZlUDhIK0R5?=
 =?utf-8?B?R281cWZLbndPcVZXQ29MaXR3dW02MnNER2phWkU0WE82NmQ5ZmJ5bnV0S01N?=
 =?utf-8?B?eFVXd1RBMFpiZXNUeUVBeHlBR2xnNi8vWnVDMXQ3VzV2OXBoUGwvTlZnMUcr?=
 =?utf-8?B?S09CdW9LNURjaHdQMFdFOXJQMWY2Vk9VdFk0R2wrQWJ2YTBZaEdieDNRendv?=
 =?utf-8?B?OUhVWTBhSXJRc1Q4Y21nK2pIL3R2a3hacTk5NXNkS1dKeEh5STIvNlNlRnRq?=
 =?utf-8?B?eENOTW1QOXB5Z2lXbWtyNEFuZzRheWRQRDBXZi9pQi91d3NhZ2RqSXBMWStW?=
 =?utf-8?B?dGx1SmNoQmlxcllzTFRYaVBYQ0l6cERRb1JtY2I1Vmd5Z0pzdGsrcDFoVE15?=
 =?utf-8?B?dlljdjVwdXVvekY4QmJNTnZYbGVnbjloYXROZzJWejVIb2J0MDBpNlU1OFRU?=
 =?utf-8?B?TmFTdUNnVDN0RkJ1THJ0Q0dJUFF5M0EwdHlaOW04U2doUXZqYzRFcVRnbzQx?=
 =?utf-8?B?YXdQbzhQS3BQcng4Z1EyaEJFS3BoS3ZSaGhFYlNIZElVMWRRVi9lTnYrYytH?=
 =?utf-8?B?aEJIN0tjRm4xR1hZY2laR2lkVjRrdFV2b0hiRUswZ0E5ZHBmQ1VieGV5bllC?=
 =?utf-8?B?WEtHSkFVdURUd3pYbnczMGJ0UDhDM2EyUHMvRTJmMU54Z2oyY1RybEdJQWJn?=
 =?utf-8?B?VzZVQkVHMGkxMitMTlBJdHdSaDIxdWdIZXVMc1Y3cW9udW1QZnFjTXhwMVhQ?=
 =?utf-8?B?NnF6aCt0Y0lSUTlwVnhUdi9rVndBM3AxTk5KRFZ0eXgwdTlpRFdXbDlhQ1JW?=
 =?utf-8?B?a2ZDaFBrMHpoNUxnZ2Vqa3djMDQ4eVhNR29hcGVtSXgvMmpMRUpTN01GK0c4?=
 =?utf-8?B?S0wvYm51TTVQNFBNOHZ2SDhyQXM5ZTNXckYrclpRRlY1VXFqNGliczQ5SzFN?=
 =?utf-8?B?WERkcjRqS0ZxUHZtQyt3cm5HNzFEaXVyN1YwaGo2SDYyR3J6Wjh3ODlYeURZ?=
 =?utf-8?B?dWNFWnhCMytxaEpqTGp2SEZManZVdFhIZ1dIMmJ0S0FsRGlja0pOaHRVWExR?=
 =?utf-8?B?UFE5dmYvQ0pYaVV6QUZodkNxZUpzeHpLUjV6TytOQWpncS9zY2xocS9xeTRT?=
 =?utf-8?B?T2ZsNFVHOTNkSi9obm9HRkRUVktBajE3MUtPV0JyTEo5T1RWckFrQVc0RUF2?=
 =?utf-8?B?NEpQUEhRdXh3OXdlc084SHJvWS9uZ1dXUkJxWDgzMkFrcjlmSy9WcndFMG54?=
 =?utf-8?B?bElSTkFNNnBkT1FJek42ZXpJazAzVndBVFgzU2FSdmxhdWcybVpicGU3QWt1?=
 =?utf-8?B?OGtJbm16OU9La0xTUUNHcGI3MHNOK1lzK1pFTXNBakRodDZ0NFVrY0NLUFFC?=
 =?utf-8?B?Tm1UUTY3QUJISGVIT2wzSEE0b3VZdE93T0ZEOHRBV0lCMHA2TUJ0eXB6Tml5?=
 =?utf-8?B?N3RTMjMyb3JHK0IvSU0ybStFUUJ1b1dGY3l3d3NpYjZHUjZJdnpFY01mQjRx?=
 =?utf-8?B?R3ErbHJjSktLS0xyNjliVW1NT2Q0Y3VJQW9KeHR2c01OMUFyL0paaTVlT2Ny?=
 =?utf-8?B?VjNOcFRNM01aNityL1Q3NE5ZOFNscVh6cHRLdVRYNGpmT1E1V2dmUWRXQ1Az?=
 =?utf-8?B?NU1JMXRoM3MxOXlBU0tweU11blpoTEh0L0lNU1UxaEt6ZG93THM4YzFqK0gy?=
 =?utf-8?B?MXlLMkt0c1dXcXliS01QTURLcElpU3BnRUNOOEl6T3Z2RFVrOUdCckZ0TjRS?=
 =?utf-8?B?bDY0WHI0cTRPaDh3ZUdqNEpRaFZ3NzRKajlCY2RHdkJWc2V4T1RzS1ZzKzlo?=
 =?utf-8?B?YklwblJBemdvWVFBcEUwbFU5aFczRHZZUG1iOEJzMHZpV0d3UmhkbGhXbWNz?=
 =?utf-8?B?QWpaYmVZc3RMUHJ5eUpKNnBnMHh6VXlPOUJHUjVnNHN5Zno5VU9zd1dPNGwz?=
 =?utf-8?B?K2tPeFg0bkhaVVBqOWZkdENqNjd2cGdqT1QwbnduZm5VWGgrUkVSUVVBMmxT?=
 =?utf-8?B?cTVnaERsb1NUNkVTaDBLNnRmWjkrL01KdFpCVWlJWERkd1U0RTRKUkJrM0xX?=
 =?utf-8?B?bXlvOVY5SkNpandXeWxKbmJveTZWK0k1elc4eXdEODdzMFBqa3psNk41MDlF?=
 =?utf-8?B?SWtYVjNXcmlEbVpKSzRiVUZLSlFzM094NjY1YU9CV0o4RnNDVnQxZXJEb2Jo?=
 =?utf-8?B?eWM0T0hQSXlVOHhuekMyRit1MWpLb25jTFFidzVRM0w4L2tSTkRRSmN4dE9J?=
 =?utf-8?B?NjBIdGtmNDFqWjZZVmRiUUgvTlVMSHRoS3Q2Z1MvT25uWjhmWjhBZz09?=
X-Exchange-RoutingPolicyChecked:
	Zj5hfz2MXocUePGtSlhrj22G6y0eFwngfagmmyFqltlWtDZNaGDSsmNqma7ZR1ycbaoh88k7LK055UkhgkHtqobRlJ8SQmvLiBVcJDGy6Ll4w0K5tO3x1bvEWBlj7a4EHy1Fd927KIW00S6qfjnLPXDvbNUBaQZZOTU2BbqlqMuYTb8ntLjbGzj5ewwxXC/PbPLYDpKKGUl2j4Xmapce+RbiTvbksRiYB8MVe6vvImVimHzbTEa6Y8hFVV/zboRgXEFKcDe9/SY/YdAYOzOy/T5S9Z8M3JbjKpPL3HoJXO+TYe1d3FMjdgUkc3FD2zkoAhT09yo1eDwrYmq1AOA+LQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540cf3e5-30c6-4f6c-c066-08def86baefe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:17:31.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vQkYcdCAN+ZLl3mP3qwEC82zEL9cN+58FgxwEo1sffD0AV4FR0n+QvtNQOF3aTA4SJxKL/eboff4sDkhycTIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5549
X-Authority-Analysis: v=2.4 cv=Wvcb99fv c=1 sm=1 tr=0 ts=6a7c645f cx=c_pps
 a=I1DPz4bLegk/AyvijR/I8w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=3FWGSONjQWDVaXQ9jTAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: F_TvXzerJ2LzX0STk4ibOOJn7Q36NZtb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX0Dp8Q9KsOhFI
 CXrOpMZU/v5VnS2/KN62BGEc1o0pRliYvMJLv9ZBhjMUQZIpGmbcVH+o1olSES3amLIEpxFSYUF
 Aw6Kq9nB1PI4U0xG6LT327hmqGFMW0oNUZjjuHhjNRmGoYRaXVLR7vA4s4DiLMS7zKZmkH50fRD
 97UJrPjxgrX5J91anNm27JLGIIui3oIyckWJAlXn1L7yrjLCdVRfW5aTQPUWdnNS5Us5/m2TvBl
 quGKhP9vKMQiTyaaJhMOaGG/vyD9DqxYusMCz6/HI7d6wqYljPi0iWDH1UUXfTz6MUtN6S/8+7N
 TeWa8tGFHDO+VGXnLBYV8iVZrbhMnLi8YC7LaeUs+E65sU4y8rkgQXnoTBSrYcoReS1w2t2pjG/
 MRqec9rGcwxvw+obfo10mg9ZmsuNXlIpMq4aTuBc6ywg4/ZACmz/tgnW2Dq4PV7lbFfnKVLBmGz
 aAsfoe7h69NsUeNSctQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX4kyR0dqgAKQs
 C3NQRhfMtSHqEti8MzBXXXPMBMYV+HPANc32Cz6L+rwNVqq6Ji0cY9VxfEGtyvUojmjw4euwxTG
 yWvkHP++2AvhV6Y01Cpr+DRmW0XirLe8lrDoAtgNRWla9s33bmaJ
X-Proofpoint-ORIG-GUID: F_TvXzerJ2LzX0STk4ibOOJn7Q36NZtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120099

On Wed, Aug 12, 2026 at 12:48:48PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 12, 2026 at 10:08:34AM +0100, Nuno Sá wrote:
> > On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:
> 
> ...
> 
> > Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
> > is because of __set/clear_bit().
> 
> Oh my gosh, true! bitmap.h implies all bit ops, so no need then a new header.
> Indeed the whole hell is due to dma_cap_zero(). So, while your patch won't
> change the current state, in lieu of the said previously I would like to have
> a split, but since dma_cap_zero() is used almost everywhere, perhaps make
> __dma_cap_zero() an exported function then? This, of course, can be done later
> but if we start from the more mess, it will be harder to untangle, so I still
> think the separate header is a way to go. And perhaps these capabilities also
> can be split to dmaengine-capmask.h (with a fallback inclusion in dmaengine.h)
> so in the future we can only include it when it's needed.

Yeps dmaengine-capmask.h would make sense to me but as I said, I really
don't have the bandwidth for that!

> 
> Looking into the structure of the include/linux/dma* I even would think of
> something like include/linux/dma/engine/*.h with include/linux/dmaengine.h
> to collect (for backward compatibility), where the first citizen may be
> your API, followed by split capmask.h.
> 

Ok. So what you have in mind is something like?

<include/linux/dma/engine/buswidth.h>
	#include <linux/bitmap.h>
	#include <linux/dmaengine.h>

And have all the inline helpers in there.

I can go with the above for v3, yes! But note one thing:

enum dma_slave_buswidth
DECLARE_DMA_BUS_WIDTHS()

will still be part of dmaengine.h and what I could do as follow up is to
move the above to something like

<include/linux/dma/engine/buswidth-types.h> or maybe just have a generic
<include/linux/dma/engine/types.h>

Generic might make more sense given that we move around 7 typedefs in
dmaengine.h but I'm not so sure about the enums.

Then, we can also do the split for capmask.h as you said. I can do the
dma part of things I can't just commit to change all users in the kernel
for the new headers :)

(Ok, moving the buswidth types into a new header might make sense in
this series - if we agree with that direction).

- Nuno Sá

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
