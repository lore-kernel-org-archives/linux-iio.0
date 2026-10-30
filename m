Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793369174;
	b=I5zdnCwKS8WTByvSQjB6DXu8O9XZUzCap7MhBTJJIAaoThrKvxy75qyDje1uZhdjjuxh
	 5EBW9IVBnJWXP3j2s5xJErRKqou/wawGE99/nGEXEh2wz3c7mrvcuenkTYNc4pL6U0InG
	 2GmfelOB7Z+TZQg9kCtHaHsN4TJv/2ykDBgBHC8imgWpfw8z92wNSNVy8h3yAPVbfrWKr
	 mMwd+q8ibRRhObEMZ06QVegmlQgM4tI3g2nTh8SXvNJ8pZkz1ChyevmcX9k14mk1BpS4Q
	 j3Ms7dccePm4RBQ31ngDkbAWqdYhQLZXWXNkIDFXg8mchci9C5iNoBtFMNVnzX3/3eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369174;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Content-Type:Content-Transfer-Encoding:Subject:From:
	 To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Sahq35JFfLVoNenSYrfx6Q89n0gw+U/EV0UsZ5xfmpg=;
	b=dwocNca7yniQ3jdci4NG35LNxgv9PZ5M0bmFKK6HfcioVWcyjkHQ241ps7ZLNl0U16ql
	 bMr0ia6Rg3EHIHxhh7nqrdM0d2Q2yHyeFLyG0MTu8UZUKScx23Y+QyZlco9LndFLqenr/
	 92GtLyL/4A8qQuWHa9NSwNt1h4aQLtzGzOwgqF1EbGZVymrTSNpidftYYtLdWMxY1lBA5
	 OJVmBFxYy7B5ZUU3P1cqr+5raT7+4M+urdlP4CdsbSWZLzCxSZ7sXw2aGoAtpUJ0BVT5I
	 22NamBzCkAuU/LTrOVMg31mrxtIR7VII+QI7R65H8CMsUISM0g0THshKpOy5Nh17k6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ro6Rm58g;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Zk5ANK8u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85E606A335;
	Fri, 30 Oct 2026 14:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C85E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ro6Rm58g;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Zk5ANK8u
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBHiuA3601524;
	Fri, 30 Oct 2026 10:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Sahq35JFfLVoNenSYrfx6Q89n0gw+U/EV0UsZ5xfmpg=; b=ro6Rm58
	g+jg0Y1kkyMErZztzVObcEBww3x347SDbdZmYavLYXLkhh2/DcMqA68yTMVwRs6F
	ue1gl3H6PypuHEsPfVqNZyVg59sqYUxbIA5B2dUu2R0N/yvuUE1GzXXQ6TVYX2AJ
	4SXKyLXU94ZMwQUiF+kjeGF9wgKHSWoXKZU9dftekiYn56QEwkzCpUJSYULewkrB
	l/CwvSHvPum5b8rBLXLf4xiced0+a8u3Sb6vfUk9aexrlqTGmuEcLmyy3eYQfE+I
	p5FhhX86XWQnaWRt/cjjrs+WhO9dFbzNVgRA68PAWMMK4qR4hDQysZPamuKSAXKc
	ZOAt3EkO23ll8xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Sahq3
	5JFfLVoNenSYrfx6Q89n0gw+U/EV0UsZ5xfmpg=; b=Zk5ANK8un5QeZ7qLN4/Wk
	DAMPpy7rwq7rne0ddiJDT01gOOzMS3t0HhCRZXFSWJTI6VPt+X4skqqIug3Qe7cM
	xD4cCcXgw1La7b43g5Mfc126LaVaLReXzS78Gq0C4sUsqIpRg7tJNxYTX3JKcLYX
	glGTsYrAdMfjK1zNNI62goJfsZnvW9JwQ4JHxXzm5txbGF19qcArwoDcE/JssnI1
	J7ve+vWMMLioPlh+fzNPKIn05itaT80uYharHTzr/m3zG9w3Kl+LRa6wf1U37cxH
	woyJ6NANXigqNHs4d45hOAz/+EuKEID1os4Wl0wrB2+3eBBuP6yrraXX5Nfgh8TT
	w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bmm3j-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:05:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bpgp8Im5RzExpgGSM8Qlvso6XLYYinllylC5xeKrG5YG56K2VKyB5nqyoRKs9d6Vs283v+SVAk3i8TTagbIjf3PQOzc9lEUuuqrpHxbg1h9+Elc2X2u0ej/L3QfX0AOWO9w1C3CYjmUecDbdjGccNMemCj1zWiGlBm3x3OmKJ3/90/8XHfVENr+5cZPvILbpzVWOcVspsusbu4S0x+fh6sktyMfr5+GKZS99Dec7EtZp1Teunr9GNtnLj+ejLTxt1LfxFjR+jIY4rsgVwyncv28QF99Mye1FexxGFse+Go7RTK1C7GQ+W/aCQrP7GhP/tZugZ87bkp9eBuY2pwXSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sahq35JFfLVoNenSYrfx6Q89n0gw+U/EV0UsZ5xfmpg=;
 b=hSDrNtlEb/TE/z81jxMp46vTKNz0r4SSVSWj2ZgYcVHlqDbqRL8AlLgpGuUdWKpTMJFBom3RbruP3qBLm8zYmNJ+TewnrlkaxCMKiOReEYKIbvVS2MwlYiJFrzeDQB2EkBqKrrIizikF+b+sXdxrhWU3m/ANoosR7K9bUWTNiLQIv0zFZEiabCuF1FAG/fXc/FrhN46h2T68LsdYSsw+xOWMd1eByn4DmGx6e0zamIpt7pqcX21uBkCkDOZZICtNfTn/yYTXoI9kIDC36UiAOr60DOmUISrhH80t7gUF7LvSp5rVnBSCavhoDkzGS5yZk848l1D6HP5stSquE7/NVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5243.namprd03.prod.outlook.com (2603:10b6:5:248::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:05:52 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:05:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@analog.com
In-Reply-To: <20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
Date: Fri, 30 Oct 2026 14:06:58 +0000
Message-Id: <179336921877.155032.13465457472017394020.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793369220; l=938;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rM8WGlK+1bDncEBqFkkT7W3w+oaz9GH9VcY6s5m0Dfw=;
 b=jl0TihhTCWRACZMULjQGj7qXnxNzbwMTJYgTWVVSfgToOlyfnWn9afMVYSDDs2Pvi1+YB2ejj
 xJ04x/vL8TDCSECtv00vR85O7LLhXd/lhRnYKweJo5Rna4Jw6LbBY2n
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe9c76d-7af2-4866-03a9-08df368ee770
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006|261026140227099003|261028144727099003|10067099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 c5dPuSVjXXUpl5pWcnqSJAuPzjven/r/VtqNp8ukOK7gRDFVSYJw+V48ZO9dldXBYGU38GMC+BBTTV+n+HeIkgceKZ0eO5G+YElOGdsaJkM6IJfN2/E9kCOFuySO9e1qdw8DRqGT9fGWOanVFAz7DLI5VderCjJ5b/PgSwadnOeaaZtv2qFt4QsPZSsyPryN2V3XAZs1BuPdMr5zkjZl6nmWAlsWWjdLA26Y+vK70izB3JtGerC7fvDsUGLuBT1jJH9z5iholMzoJGJIROkAWWse84yDCQhIg67v1XQpdRAcQxLIng0bmuHHep0kZNitwE3qaxMDV+OJO0vIy9i3xBQ03gc9fkKqsYCc5Vd3l4q8lhXLdl2+trZ8fU9jREjbKHsS0VR0M3JCjJ46CMhKkroVYqIoUKFuJOX7v5M1jrgbBIdRlNeo8xwAJLhX0uGfBjgqVgGdT5bREC4X94WmmV5MnYb7bDr0OLsj09OE0JsTQ0VHf2FCcoTWVPg4hTbXPWeDQ0dWQ5WlFM9CIxQDtqpJt9yc4k6fKzEuHfafKDL/iIsmva+ucbB96LzhnBUSsZVoFfEPseMTKrM/hucY+EQDmtizqrBkPj3T2UEKfDDacgOZQ5sza5jhbW3Eds8NaLmOr8QrtjpDjVnxWWij7A9Eh4ouBlYtkKEuKVAIS18=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U3dEOHlLK2s3UkFUbTd4NU1aV09xTXp0NlZ2cXJJbGN3ZTgwc1ZXNTV5NlRC?=
 =?utf-8?B?VkFnZ3o4MjBPN0krb3Bwczl5bjBxandISmpwSHUrQmRjMXhGRDVVU1hOUHRa?=
 =?utf-8?B?Zm5XR28wcUdBWG1vY1dhYmduYW9vK0F6V3p0MVp4WlZpR0RneXRieWRjdEI5?=
 =?utf-8?B?T1hka29HY2lVSUxGb1FXNkFkMVJDcEJsNmpuN2NVWG05Mi9nUjl1bSsyazAx?=
 =?utf-8?B?bzJVYlhZMXQra09Mdk9KWTZrc0VNSmZTUHFYbStsZklDaERlQUdOSGZMMVMz?=
 =?utf-8?B?STRwTGc3eDlBaWJaYnBQYjZnYk04WU1NYXlrcGJTd0tremREWHAzVS9TSytV?=
 =?utf-8?B?VEttbkUxQ0lQV0J6VTBESkVqM0JBTUtnQlMxWGcrSGZtQkhhejV6Zk8zS3hl?=
 =?utf-8?B?UDdCQ3V6amZyUnVCRU9iNDVGNGxFMmV6ZXRTZXZTdHRZV24vNUF2ZEd4WHV6?=
 =?utf-8?B?ZC80YUhrUGJHV0p3d3VEL1EwZDdybmhhWnZCbExKdGh6Mk04QUgwdTgwUGxv?=
 =?utf-8?B?VStjd1dETGk2ME84cWJWYmN1b2gvMlNqNndVUEl6TDFmeTl3aGZDaXQrYVpu?=
 =?utf-8?B?bk5BVHYrdlpkbWZWcXJSRDQwSDVOTTNXQjNNMEpQenNYRXBteTVZZTE5Ri9D?=
 =?utf-8?B?OTdPWVFQZnhEWG9keUlIb1p3djVFNlBtSDJGbjFydEl5OHBZVCtETjFkcml3?=
 =?utf-8?B?VHdET281Qzh0VEQyd3RkVndXTHA5eGhrblZOU2syaEpmY0FvOC9MYnhheEh5?=
 =?utf-8?B?ekVqZ05LbjJhVEUydHY4OExtUXYwbWtsV21KMW91WVZ2TFFZZ3BpT242SHVB?=
 =?utf-8?B?TzhFajJQTnE3S1JFQ2J2cWFldW40dERiaEoyeG5aZlV0OEw1WFJFZzh5OS84?=
 =?utf-8?B?S3VXYTVMVkIxc2JkYi9rbDg5QlNMcUVCbmNHOHZBQXB6Z0xsYzBtV3J1a1lN?=
 =?utf-8?B?RFdVS3Rxdm5ISkl0V2E1Y2UrUFZ4Z1ZweldERThxaUw2SjJQaWxMNGVjNjZk?=
 =?utf-8?B?OFJJdE5sOXdFL0lRajN5R3RkL1ByazY0YTFaMVlSb1ZVNE5qQWtxNEpJZjE1?=
 =?utf-8?B?cVZQcGVNcVU2bWtZMkh0MXpJTjdOWXlSNGcrdXFBQ1BNd0FDa05oWUcxRDcx?=
 =?utf-8?B?QVJBYnlIL1E2TlJJaXV1SFhjMURSbStmRXg5R1djSEtxaUo3QkowRkI1R05v?=
 =?utf-8?B?SXJXSHBWUlpoOEJETDZ4dkRhVllBSDlNSFk4bVpXYjNZSGFXMnBQRU0vQkZG?=
 =?utf-8?B?NmVJbW1sb0ZqdGJqQnZTY09kWGNUUTBLOTI0M2theHZpaXVqZms5a2drNHZt?=
 =?utf-8?B?QzZSOCtaRXprWGc4d2cybjJZVEVUaGh0M3IxSDVIc3Voc3JPd1FXN3JwbXNT?=
 =?utf-8?B?OXpWaVNlLzBKU2pURmFsckF5YVBDWXJZK0NaUnVPVFNyWExBOHNYWWtVTmxF?=
 =?utf-8?B?VmVmazNsQnpzdk1lTDQzMHE0QlhMV2d4NHFYdXAvV1pMQXFQZ2RIUDgxUVFv?=
 =?utf-8?B?WWJ6MGs2eVlabEVUODgwVUFsRGMzU3Y0UlhUUzZRTXI2VTdGTmtjZGVEd3FM?=
 =?utf-8?B?aS9hRXRlWUt5Wm5aSDljamtqOGp0cC9ySXBhdXBXbU1HMzBiWW9meXJKV0N3?=
 =?utf-8?B?c25jdnZUZkFTeFlFOVg0NUFWbldDaGJ2WVVyVjJQZ0FCeGZES2YwdjRNVEpT?=
 =?utf-8?B?OUQvUGdNYS9ubmJoSmwyVUJlT3F3M0pqQ2JSbmptVnNRcWk4bUJ3MkJLWkZz?=
 =?utf-8?B?UTZ1TTkrb3NuRTVMZmdGRmtmSWVPNWZtdzBBbnhqcUpIZGt5eGo4QUc2dkxr?=
 =?utf-8?B?RnllMis2U1lTYytIdTFlSUNBS1pyb0RQMWxhY0tiamxlVE9nZ3VxaExSK0gw?=
 =?utf-8?B?TWN1T2VGYTI2ZWVMK2lMcUhubHIxV3prenBScG15dVB6WXBoUTdLbGFLa1VY?=
 =?utf-8?B?bDE2QldBYmhBWnI2a3p4L2ZaTGRxMElpWjQyZEhFWUlqakQ5MUdtT2hiVTRJ?=
 =?utf-8?B?dFNoY2M0TExSbzlMalNPaUxaOW9DVzlEZ0M0VTF2M2s1Q1ptVFZOYTFkY1Uv?=
 =?utf-8?B?YysybkFNUFZUTTgyUmNNc0tKdDlIK2s3QTR0WXFYWHF0aFRBamFESWtFRzEx?=
 =?utf-8?B?RmttdWMrK2F6YVNvcE1mR2VWU1drQWxWTlRObXc1aVlxU1B3emQwaEt4c3RC?=
 =?utf-8?B?Z1Q1LzlJWDhTVWRPVDk2VkRWUGlpcS92UGpma0hGQWFGZzQ2d0FBWnlQc2l0?=
 =?utf-8?B?dWFuMW8xS0hnWkM0bWR0TzJNVEFXRnRSeDRjQmNtVGNxaWQ4bTJucGEvckhI?=
 =?utf-8?B?eTVtUnhHVStydENJZmZYS1ZGeFdybldGb2JrUnE2eUNjNlBjeWU0UT09?=
X-Exchange-RoutingPolicyChecked:
	efdlTXmFIH6WC0/+u8x3uQ4dax2G7qxPso9LIsB+roMZOCjeDcAeUVr49WmnZt8eYk7Rscf1sHxZYGd1al0HYIEvHK7KhG5utrb37TYjaIA0gn66U9XmSR5NhDOL3g4EF2VgdQis1dsxNdc+grxIm1IVNXobYKTp/guq7TaLm7jJz9ZOPH+3XaaNxjzZrrIfjrfgcWvtZoa+oyltdEpU/M81wlg2/SkvWUSfbWFZasy4rB2lelx74H/xXFQGnjeunNPjGSJnFfdSacEA0jed0qCj7VZzrcRR2MyLjChNypX1hajctqKWg1LItVTGC3HbpAZPrXSwW0yIE4g8zGVCzw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe9c76d-7af2-4866-03a9-08df368ee770
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:05:50.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ayuRifgg6Q1La8FIYO1rNOGfXsemp//XJiBVzW8OmL913ZeE+RiCg2UTToL1upMgG8TOXeYPMl2HUFzWYOoCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5243
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX3d4JQk/PUtmV
 gqmVB/0NqmQU+rPLzmSU8b3zMBzjmyDpmwdZC6Fq3A6cSKxc03rEYzMjPH9zPuabQjfWaixNSlN
 W6er35tc0CLPqHaXhv+7sB0z1PB2kyzTqf+lRb/3TCQHAO+S291qe4MqiKTVTuAChkCfivCDluW
 F/2eHRwsy89y/xNeZU1FgbVhzUJB2PrVKbn3EoBet61M1T6d6F/DPIxvbdHBDAx8r7J4imXwrR/
 guvg1IvO/Dpq2Ba/yWIvH4QYt0myROdSBnl5UorsL781iQJ2qS4GpA5M4vxOQlHN2+XWXVqo5+e
 Je0ZJiW7EuqXdH2cMMIz60/+fcDcbqYG4BDi47pidkZgytIdA+42F3UYSE0Up3SmpNlu/GWlVAV
 TjYtUSkC93qyLhIvmMoMOHYQmb+dfTHcil08YpCF30BFwuI/5nYCJcEFw6JJ2ayAhOPePRejMwN
 dwOI61Vmf1cxlVPdvhA==
X-Proofpoint-GUID: aFee8PfzfpJb7d82gW0aPLk7UJYFPi3B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfXzRUTdEDjix/5
 NiECRL6ZFkNAiiNZgK4e4W6WSQGv0h8SGFOUoJCXD/zS+uPmGRI6W4ylBkIn31Nuvh4vFuBgR0A
 DpDoUWKQFLHesTvZD4WDOh4Hnx+Vt2YbJr7uBwF9Gv5qkTvldaXZ
X-Authority-Analysis: v=2.4 cv=XfMcX455 c=1 sm=1 tr=0 ts=6ae4a443 cx=c_pps
 a=CM6yQ3ajfX3ct242QRRZiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=w9V-ZNOaCHwW2Kq9GhEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aFee8PfzfpJb7d82gW0aPLk7UJYFPi3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300055

On Fri, 23 Oct 2026 12:30:23 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> index 2dda306d7b54..b1f3667d8ce3 100644
> --- a/drivers/iio/imu/adis16607.c
> +++ b/drivers/iio/imu/adis16607.c
> @@ -215,6 +244,286 @@ static const struct adis_ops adis16607_ops = {
> [ ... skip 73 lines ... ]
> +	return 0;
> +}
> +
> +/*
> + * Process a single FIFO sample and push to IIO buffer.
> + * FIFO data format differs from regular burst - no DIAG_STAT, data starts immediately.

So FIFO is another command different from burst_mode? If so, is there
any constrain with using SPI full duplex and FIFO?

> [ ... skip 66 lines ... ]
> +	u8 fifo_sample[ADIS16607_FIFO_DATA_LEN];
> +	u16 diag_stat, word_cnt, sample_cnt;
> +	s64 timestamp;
> +	int ret, i;
> +
> +	mutex_lock(&st->adis.state_lock);

Use the helper.

-- 
Nuno Sá <nuno.sa@analog.com>
