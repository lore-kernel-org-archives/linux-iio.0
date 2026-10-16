Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F82F60B2;
	Fri, 16 Oct 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140250; cv=fail; b=fHdCjXXMLCO09ZQXs77rOHJpAfP4urPWZUVOrgenvenHAtZlnTPN8VZJSs7joH6hnFwtUWZPKZWdph4zaiarlIf+nG4qdUbiHnDt7RolO3Di7hTgO5UB6mVnJF6oSTJqEuAl8qooWLyrMm7ghuN13ADFDve70ud9xDqcC2g02gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140250; c=relaxed/simple;
	bh=/YuLWCtVX9AUdQyTkNVs0hl5/S27zuUWoV2uvYslXkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XkxaTwk5EeRshZgOJPl/w3nbI0ue0IJqHuR80G8BiCJBr07U5e4lFCVEZJMuUeFZayAiyvfv4bfoFrJM+MagGpPCpqGgC/h44U7rwZd4Dm1/cJaVtF7TYz8xamB3D1UbvdibxautqEIVltL1m+zu4GivfeDz8pgkG0P0AqJmUAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=BJadn2on; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p39Us+Jh; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="BJadn2on";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p39Us+Jh"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8BZ6f2077197;
	Fri, 16 Oct 2026 04:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=PTEUbzwvs9jz1KBH7V553R+JQB7gA5g8Ql4nj+vt63w=; b=BJadn2o
	nBqeO1SnJpI4WbVYXM50m3nWYcEIWyh+i8Ry2OwfBA+s0ljdv9WB9kz4puzNVIl/
	5wN5VSQFw1Dlnf6QskaI2o8NBit74gqs5jo8kcv1rnrNVT567P6qnyx01O6raK+w
	hYWpxaFatxyICGfxhsv78oS9HjjNI/acotxclexxI8vRPo0P8wUjvFcxS9ldMZGI
	UnqqG5a+0+ZI1oM8+aD04v+TESkRzmS78B3HvQoSURMLwiGFXAzVipUyQ5vF3UMt
	T0mz6gHey9aZjcHnl8t+TpxIroOl7SOhEv6n0uGq8O2sQ4JPT16qcLbNt6AfmNu8
	hHU/yluYsoFBCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PTEUb
	zwvs9jz1KBH7V553R+JQB7gA5g8Ql4nj+vt63w=; b=p39Us+Jh0tBR5RFqzONBu
	w1UUDwkHATkVowzXc0Or49iGPbDz2m/pvBKkeKMShqbtAq9apwCTcAJyn6arTABX
	/+f90uhlHp9/vPMiHZ2HJIdNG2o1gIATjGYipoZoGa1uK0XtxpCr1rKnw0mrT90w
	Z83xW0rmyPdmB4upHGJL3biNrWbx86B+pG0tAXNXm7MD03paGH2wNP/GND/v+xGW
	d/4qvMLsxO1jbfwDv4W4qGBnVNLg35goEaK4U200fLvaN7s7PSv5jQixJdYr90gc
	bLkM9nJSe54+aZZfoDgLk0QCG4N3y3JNotHMuZS2UdzYyykGv/NTJdNQEmtcZFpS
	Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4havj3xb09-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 04:43:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brKtRCibJf3BgWGRIE3g3ktY9sPhENFH3WBhLBwtZG1qH63+zj92ELmg2x2LhNNddVlcRZZVlj23xnzgiqKsfHsKDefsHn8UnENhUlFzSYtZyRkRNwziATxrgBp+6tLL7IhUSMi/js1zIVI8HXyjKyKwxowb9m/Ti7dRneOW1/TPYpt6YnTuvifp4ROkNArxPVAwndlWFtgElNdGXi1E0jMwgmCsJ6lbCibT6UUYI0g0R7XlpwGAMsp9QzEZcnCvy0k24l88f0Pylvg9gB1szH0kM03KQLpLPhKpRMOrohWOs+IM6d0fCYy2YwoUxT9n8F36xgMfU6OQiP09Y14caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTEUbzwvs9jz1KBH7V553R+JQB7gA5g8Ql4nj+vt63w=;
 b=fXMyes4ZQCcxDCFavUNXaNJZRYHKKJrCPBOuZsp/veVSfPTC1cHNjTy/XDxAf/PadfE7hN4//w80gM1c6pFjrBwgI7oRMx+OGAjIDttTcpQFyiEgVEIS/ptPzZUTzdztXga++IUzGQY3Siw5oAOQOCCrHJ3yDKguU84ew7O1qAbiTXoz2iNYBTiU5iiKzy53YKYcEmEPFbkspM6KozBHYhUA7rZTzfFfiygLoajXgOj+CsNJ1jwxfLzsu43H/BJcDoIx/xUh0JVEtGYsGOA8zmwZpMC7YTYi629oLdvGgkrvjc9I2ZZUq/FKGL+8lwB+JWK11bCEzQEuikK63vZiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA1PR03MB6564.namprd03.prod.outlook.com (2603:10b6:806:1cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 08:43:40 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:43:40 +0000
Date: Fri, 16 Oct 2026 09:45:01 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/10] iio: backend: add devm_iio_backend_get_optional()
Message-ID: <atHjHqyxXj6jkObW@nsa>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
 <atEeZPOLASHAcnjF@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atEeZPOLASHAcnjF@ashevche-desk.local>
X-ClientProxiedBy: MR1P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::22) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA1PR03MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: d936b5b4-d446-434e-f232-08df2b6193b5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 q/chOf+kATjMs3zLzjcQqQzAQ3KKPMz4k80lzBrRIe59lU/FLtvVJWPq0CWY58kCKpf3MlnmpW8bwMpn+oHYk3G7G0XTd2e5ZzTPl8wcfCIAFehGNLPh1TyS22nGQNTljgWkHQUoAXEPIJ1epTtGM3dHwsaRbGy9I5eApzTd2unxqAuTEUKE7+j51J/5WZivB9DvcUeQIqaAiwNZJOdKTuC+aGOl9oXqAOmY0Dd+6lfoeHduwuKt+TeKaq5rhKa5zjdTKikMq5egTHqCo2uPYpAsMX14jsSAFWuuRlhCI5z7LlCK47i83jDxgsMjQXuuu/trA4ef9rCyPzJVVPR8RkB0a4QDJ3jqj/xQm8G7+gZGrrIP8j7Qc86H9dVhVw79PDQCgHNPQR3AKHBCN70tXgGujvraxYo2PL6Fpc7h1poOYCC3i6/1hhoUEvOC7vTcyhl5cDg4YEfvgHwkILZhOPQ+OG9Ln98vF5ss+x4TUKyrfOoc+Ws/SFy1lailv34Acuhol6cGE7tuE3NK1cu6B0+YzhiMDQH0FaAQld+9bV+URSWDeZeykCbY7g4HjFLEMP6UGOj8SSJ2qfR1WRZsNwJkOG6Z0fNoaWJoJ+UyeNHNadB/OUrUbX680bStJ1QX6fzaKU4VBDSXHP3mpYN8qNXBPjcibb720ukNE9jqY8k=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q1V4WWtrK0JXcm5KZk1LUEdSYVl0aVRRaTQ3NHhjTWtnVDZwZlBNZGJIM1U0?=
 =?utf-8?B?Ky9sc3A4VzZGcDNKL1F3elJIUWlkbzJPblBOVVVUb09JWmN3NmdhSVNpZEpD?=
 =?utf-8?B?djdCeTNmd3R6Uk9Fc1g4VHZ2MmRFRWNWa3pWdy8ySUkxMHYzTlRBSnZhWnR6?=
 =?utf-8?B?V3phSXhIYlBZemhScG5LK1B3d0hSenIreFBUbGNWYnFpdnU2NkE0NTJmTmVz?=
 =?utf-8?B?T05wajhYNFhtTjVRS0pBTjI4UXdiV1BwRWpTb1hqM0wzdktiRUltYkZhQU8x?=
 =?utf-8?B?ck5Famt3MXd0MFBXWVl4TkxRVldmRUFIRlZ4SE9JdGh4K0IxUWpxb1hJdERy?=
 =?utf-8?B?UEQ2UzhHMXQyakFnUUg4eGJaYXJNc2hCdll5OUlZZE5tdFprUldKYnk1UmQ3?=
 =?utf-8?B?bmluSldtdmx6RTdmRlluY1dGRnBwdEZoZXlqbXVDUjA3RlNjcHhZenJNU2Iv?=
 =?utf-8?B?dlpvYXZMWHFibU9XbGlabWpiaFdoUk53VjNId3NMeUFhb2xPa0VyNGw2cy8r?=
 =?utf-8?B?VDFpNlRoSmZIWXFHbHkwL29laXNjVVR3a1NqUEIvR2J0QWdpRVV4R25PdVFD?=
 =?utf-8?B?RnBqTlBidHRnYkczVWo3aXg4MmViaXpXVkxNd1ZmMGdPakxaYTlMbjJQQ21q?=
 =?utf-8?B?RVlxRUh1Q0VLaytvYk90NGpDelBSQW9kNFoxQXJXRVJ4UWtDTVo3eU1wUTdU?=
 =?utf-8?B?OStzeE43S0xRMm9SQTNIRThPUStsSU9sWlhtUFdKUUFndnJwZmp1WU92ZU9C?=
 =?utf-8?B?VGFnNERsbXJ6a3oySWo1QUhFM1lZYmZDRUM4S2tCZ3RuankxUThISnhFZExq?=
 =?utf-8?B?NzQxWXNrc1E0WWZyZERWNkRxcU9SRnphcXdLWWtPWHE4WFBSV0l6akE3eG9D?=
 =?utf-8?B?OW9NNjh4K2taaVhQNTk5QytvREFzb3RSaVhlNzJNYXpkL2lad0JCbTJwT09V?=
 =?utf-8?B?NlpHMFIrYlYxL3ZFdFVsWjMvTlFWVzdHRFV0c0ZWT1hiT0diYkRKY1l1UWNu?=
 =?utf-8?B?V0NVVU91M3MxQ3Y4K2ZwUE5GanMrOURnTllyZ2h4UFY5SDlXUEcza1Y0MDBR?=
 =?utf-8?B?Ym9IUDFkWFphT0dsYWplWDhkOTY4cVNHMlNlT09ib25SNmJiYWpVLzBTbWl5?=
 =?utf-8?B?OEJtRFZtVm95R00wM1pobWpKMWIwclRNUi9ySE1FaDVrOVJJRXZGV1pVR0tT?=
 =?utf-8?B?RTBCRlBySzk1aXJCWXQ5Y3I4VmVGekJGRlJ5NHE0bnFibUFjU0w4bTVEMzBs?=
 =?utf-8?B?MlF1REh1a0FMSFcxQjFnck90SFBibmZ2RGhGaVZTR3M5RG5QNjJTZ2JpZTFE?=
 =?utf-8?B?U29XK2o2MWppWGYyYm9zcncrZEhSa2lGVnhvZTN1Um9PWDAwMTd0c0F2Yjdu?=
 =?utf-8?B?aDNpUjlQYndDQS9zZG55NXBpWk1oL2NPVUVuYXdXV2hySUliSDZyZmJMVDFa?=
 =?utf-8?B?M1RvQUtOTzR5Q0JHQi9mcnZERjZIWWFuWnJLdTR2MDg4KzB3Rm9VSkQwSnpH?=
 =?utf-8?B?WnVyaGt0d1pNYzNlOEJGYm51KzlsSk5jSDZ1bXczMGd1WmlIOW1WdVVWWFBn?=
 =?utf-8?B?OHMrWE9iT3ZkdzJLak5makxaTXRTNmNJd1RxK0g5dldGYUtySjNRcEc4Rms2?=
 =?utf-8?B?aEpnNS9qcHlGeHg1RDVxTFVVRXcwRjd0RjVPUmo3UG9FcngzS0lRdmx2aWNN?=
 =?utf-8?B?UFpLSkV3eW1ET0cyS1U1MWpzMW5JV2o0dnhRVWVvbWt5bWVvY1BMUEpyb1gv?=
 =?utf-8?B?TXFFRFA2eUYrdkwxU0FVVGJ3RDhGZlR2YkhyZ1dLTGJjQ1lDaGVFSlBObGww?=
 =?utf-8?B?ZjFGeTJvSTVNT1FxaTEwM0g5eWtFSURCbjNhWnNybUxRWlVONUJzOHJCN2Yw?=
 =?utf-8?B?NEJTS05QcnVCOFZodFRKdG1nS3MrSDhrbFFIbEVqVmZ4RENmMEN1VHRTRm5F?=
 =?utf-8?B?bS9FWlY3R0J1TFc4dGhRejNxTXdaWjR3VmswSHV2R00xT2xQKzFrNWoyY2N4?=
 =?utf-8?B?SXRENks4VWxFZnV2bUphS2U3aURtZkhaT1ZNTFFsSjVtb3pVckNIaEY1MFl4?=
 =?utf-8?B?MnlsMk9RbGVndTdleWpybFZvWDVaM2dMa0ViN0VCUjNVV016TjdrMU8wdG05?=
 =?utf-8?B?eEhLVi90bUR2NkVML2lROW5qbC90bjlnNEx4WHBVMXVqZWMvNFA2MFloOE5D?=
 =?utf-8?B?Q2MzQWdLaFE2dzRwSlVWUlpnU1lleDB1L3FvUWZNRmJRMEJpQldnMS9MZEtH?=
 =?utf-8?B?MTQrNEJKK0NpMVBxbE95ZTFiYWt2QzNmWlBTRjdwL0M0S1hWWlJwSHUzcnRP?=
 =?utf-8?B?VlJEUXE2dEhxS0RyckFvU3ZrelZVV2ZHTzBWeERWQm0vZTVXYzIvZz09?=
X-Exchange-RoutingPolicyChecked:
	c29Ab5t5P3Ew0Q617pKxzIYXz0/ZUDP3wehJLhxRSOGNAscCSZeKyGZOdSGnc8tOVPwtlWc+t2fa77NDg+aKunAXRHkjfOE70xRFP6wH116NPsuThjoehRR/tVpOqMYOLNrKzSzy7x5ol+5hsPnF6BThJIauCd5lZFWezKSlfLHblMx+Xh5anD7wLcf9/EHCjL1t+kOg8EQ67uR+Io39DXZ1QDYzfSch38sHxG8VG7APFupAIFiYVMgGm4vJqsmt67ITs4RJg2gewLTx1EJj4iCjfakKgH/iyj+NIjIZHGrIN7dwfwRM2eaJ+V1vWkvbEZBUzp38ar697Ax2fL4odw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d936b5b4-d446-434e-f232-08df2b6193b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:43:40.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiUcK2aheHbSdB5wTDuh1TWhjYSw1h0EIHbYxWfOUiEPlkvHyOJg4jzMsxPvMwfkjymRdf9OTqwhRPXcWc1ukQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6564
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX7MR9FWpOB6kP
 7Z4wmM26H6e17ChQ1KBNJYHIUa2kJOMT7+MsS7j9FHbtAt7raH+WhKXksBlotFWppBznSReLgxA
 dwGJe/cdnHa00sKN9tOQHGRgpQlRkd+A/1Th3QpXCii4rzLqOLwhl5cS37b0GJmU44cvc+mBfNX
 27FTW8EONHiBGf23OWgfIIwSfrPwUfKyve3E0qMmTxsIKSDalMFnpPn+FTZtwMvgPkr4xZIbXBs
 0EFdeu+zh+hMmHVpx6GYI01NdO0daccjm/9FD1pulAzL4wGU9Ld9zx3C8ujKmbqWtxn+ZvWMexJ
 77dqn1gRyLx1fPqbbAcYm5yKaWSzlKHAkfXhY2ZMchR1lJ+17avPsHeJpekcJ6ZWWO5w0RHj9up
 cNPHMTcs6ULsEBRl9poBWW6ofn1G3rsX88k6LE1QVtEpTxV9EO8Lqgh6t7SPwwMf7WrCgJV0acf
 i53FfMEsB0jVcRBxRdQ==
X-Proofpoint-GUID: 6bgBYAv-Plju12zxtwKtbcx2EZkT98c1
X-Authority-Analysis: v=2.4 cv=Wtu+otfv c=1 sm=1 tr=0 ts=6ad1e3bf cx=c_pps
 a=TqpEWdQu6X+pWU0GeT7YGQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=ld_VjaQ0FNuBJsBB_hkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6bgBYAv-Plju12zxtwKtbcx2EZkT98c1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfXwSHNJ7GOwCul
 xGJDBOfSs9XdW+Q/ATaPREBM3RYLmImisYncqfMzVl3cwMx7LrnCTVPKpDhoV+2FD138zk9UTO2
 ki34KF1NKQYk2/qBl4syA+0FD6HQ3DphtJwlmuovG1DCCrgBFzBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034

On Thu, Oct 15, 2026 at 09:41:40PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> > Frontend devices might not need a backend driver to rely on. An IIO device
> > that supports backends can behave differently when they are not available
> > and that should be acceptable. Such parts may provide basic functionality
> > solely using the control interface (SPI for instance), being able to have
> > extended features when a backend is present.
> > 
> > Add devm_iio_backend_get_optional(), which returns NULL when the backend
> > is not described in firmware, i.e., when the io-backends property is not
> > present or, for a named lookup, when the name is not listed in the
> > io-backend-names property. Other errors, such as probe deferral, are
> > still returned.
> > 
> > To make that possible, a named lookup that does not match any entry of
> > io-backend-names now fails with -ENOENT, the same error returned when the
> > io-backends reference is missing. Also, the missing reference is no longer
> > logged as an error, leaving that to the caller.
> 
> ...
> 
> >  	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
> >  		fwnode_find_reference(fwnode, "io-backends", index);
> > -	if (IS_ERR(fwnode_back))
> > +	if (IS_ERR(fwnode_back)) {
> > +		/* not described in firmware, let the caller decide what to do */
> > +		if (PTR_ERR(fwnode_back) == -ENOENT)
> > +			return ERR_CAST(fwnode_back);
> > +
> >  		return dev_err_cast_probe(dev, fwnode_back,
> >  					  "Cannot get Firmware reference\n");
> > +	}
> 
> Simpler to do is just to add
> 
> 	/* not described in firmware, let the caller decide what to do */
> 	if (PTR_ERR(fwnode_back) == -ENOENT)
> 		return ERR_CAST(fwnode_back);
> 
> just before IS_ERR() check.
> 
> ...
> 
> >  		ret = device_property_match_string(dev, "io-backend-names", name);
> > +		if (ret == -EINVAL || ret == -ENODATA)
> > +			return ERR_PTR(-ENOENT);
> 
> No. Please, use device_property_present() instead.

Oh right! Totally forgot about that internally :). And it fits into my
internal point where I don't agree much in treating -ENODATA the same
way as property does not exist.

- Nuno Sá

> 
> >  		if (ret < 0)
> >  			return ERR_PTR(ret);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
