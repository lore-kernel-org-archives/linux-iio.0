Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6D3CB552;
	Fri, 16 Oct 2026 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159563; cv=fail; b=drFf3oYjhtcUk25hOJOOtr2cUHnhAafAlaCwdRR7UUoaTQXBy4S8hr5UmZYYImffCciAMbZwIzE7sXrDAXHmtim3rGVtxkqBI03b2V1fMEblYMDHG2V3UssMFmpq2lpeDNwx4tVE2pxd0Fev2048Ki6Gj97MKLnWE24HjlBeAf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159563; c=relaxed/simple;
	bh=0gwCrCAL++irW4DOatP3PyVvBrDaW/kV5TQUUF+r/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fp0Us/PpVkniOFWpYt1VrodquOnm5FDhdrQLxxzWonx0uCY+jj8xIhwAY4c/KMtQAxpvb8ifrqTYqvYiKUfMbidaUxmtbewG8xHW4ZZ8oIWKydXIhhe+hfgEVSeZRnc4OtHiVFge7v7TV/nukwEh1755q4QQUW3x5QIMozbQdmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=XEmIF+3B; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DdZEIklT; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="XEmIF+3B";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DdZEIklT"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GDLPtd1496352;
	Fri, 16 Oct 2026 10:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=I4erE/3ArxFyqbGtEg42zrbZwjbsHNdFy1CChX84Khw=; b=XEmIF+3
	B6fKf4J/U6QIUsyCfnpcb0lgzGns7+VTKM9FpSQ23sy2lEYXCeHMYky/CLSHojpz
	n3mMBDfkfiavgp1vYMOIEn4+udpE/2nvehQPRB/Y2xffhKZKKV3hKabGZAy5qgKq
	fK85m+SC/BfZyS1uRtVSlvWBdarRLChM3HL7sfEOXomxkKqrqB+T7VNwGalZrtVB
	0kfiYQm1M8nm0BW5UA/ODn0ENp1dlfTE2yLTfYQyroyoQWerrUomY+n4oHFJgfzD
	a0xlkZxxs8RPZMws1k98teLwfraQ43Xh+rgi8vrE4E33f9PfHLqA1celuRfkD5NH
	9LZRnhO41XiG9yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=I4erE
	/3ArxFyqbGtEg42zrbZwjbsHNdFy1CChX84Khw=; b=DdZEIklTEF/iKsaBPnWuy
	m1XcZq8D+8zyYVumr7XdsEFE14lLaWvcg3bG0EnEJFPnZT9pfd4eE6W9AQwW3kJD
	dctt4FJMNtz1QUSYFEdEUYPwJae1QK1EEXihYPor9XyiBpV122AciQRumFNmLT3O
	2tWlDcJt/G5LRJatsRvZFLCigLN8oAOh6E8GLwAFvR7kzu8d7IluTajWE7EiPAbp
	mBFrKouncuI+VDmrhfLn7nP0+94Bw7CaWfkIhFha+yrEYVnZVpdUADMDLpGyjjI9
	XSOvDEbZLoy+eefojaT2Fak9nlZk35HQM66+smzJ2uZ5MBC9RIDTClwgNxN4tTXV
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4r949-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 10:05:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnfgovzVQquTHiy7UQQS78jgoC+1tdaHoxMYg+JqPfV046MNKAIc+895iQk7ibf0xC2jiqHpWHNL9gYrMjgynWSNy0a/l9bEaHz0YLxhTKnvoKxmOWK9RLHIlGB8gCXOqFwi49qXxq6PWnPyI26oA73TwVK4aW3SWDc9hz6+2WZnXzzpdYXb9qJXeh8CPOtV2ehaNvtzVk+vFG2PvMTDeRqHcJSXKDltdoz1Ijk6AVCQT2ip4aFJhRoRJzYkBivLrALOHV6QZUxFqXG4/wtaXMvvT74kQSQSrqXaT6ZoIa2+pVdbAR+AabUPLcJ0Ht3mX7BbhXIfmFkaHx8YdkasEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4erE/3ArxFyqbGtEg42zrbZwjbsHNdFy1CChX84Khw=;
 b=Oom3DutWqlqMwhPVeh3vlWtLqWAgA1Pac8JsWVpLbSkevA4iLP2ZTV/BSa68/dSctUM/jC2eRDdNtNRbAcvD1igZymQwn1UqfnoY3kbO1DsyF/sUVDF4hEKsPfkgOwGqmYck8hnkkqkpvSgEoAfBZqJ+2hGV11Y4eK0FTOgTfhEfD/2qgFGlc65fZc/BkHl5japM0XSqL2nHJwxdlCPu7mdmu0KwmhJBYdaDOCATKA5PYNJsR1m7lBVWL5ZWlXib3CJmFvex0ChDjQDqBz0FVPEw2eq1Ixrt5JwidsuXEwXraUs8Z+iOXotb10RkrE/4+4U1WylejlxUt7d8OK2wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SAWPR03MB989646.namprd03.prod.outlook.com (2603:10b6:806:563::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 14:05:42 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 14:05:41 +0000
Date: Fri, 16 Oct 2026 15:07:02 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, linux-iio@vger.kernel.org,
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
Message-ID: <atIt3eXNeTT7cqxH@nsa>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
 <atEeZPOLASHAcnjF@ashevche-desk.local>
 <atHjHqyxXj6jkObW@nsa>
 <w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
 <atIkZa0noHjcl13X@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atIkZa0noHjcl13X@ashevche-desk.local>
X-ClientProxiedBy: MR1P264CA0179.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SAWPR03MB989646:EE_
X-MS-Office365-Filtering-Correlation-Id: 266c95c4-a400-449d-367a-08df2b8e901a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 wSWZiJ6vB3NZnGXWkWLV6IlZI9046iaaFEFQZOteOlFdL61Q0y2SSw379MON84VdlOZGwNZBO0rAgjNViM+LyNCZ9YOYILSd9eWqfjt4WvYvI/tbGqTm4wPIJ3FepuU1k90WSNdIyX/V5hyJ0jTYYXTIYnXhwQsapKU6lKqiWGZF8F+5bh26GJZ7byxpg7ZlEEQPef0todpoL+oYuMghhTawFxhhbiacVIc6jDaaBr8eVLeCX9BuZG33Fvw10kkhR5hMaTj83mS53U7+U1z4Pwz90w4H1XcX5KcygZ5S0JK8Vjaq337Rr512Qy6kVf+tEnk+jOnd4Wh6ZnAX94/KYUMyCOCNP7mk4bGMalBmbXFRCbG3PoccrrSYtT5eTL+uUSgahF2+alTXbdpAdBBs1CT5TGCbM344dtobBe2FKmu0RlEonljvikv/WvKbg2oA2UyEtuAWGnyV1eL5jRerm0O7Sye08psl8jztrI5eSOSUqitOmygVrFY+Op92wwJCQhxsH+eE+epep3bkBx+hcx27z8jUipeS2LUQ6C83USLpppbPti0o8Qe9hq8c/F4aAKpcvFgLSjHlbZR+z88S8RBs5MAxQ+/pBErDQQkUmCsXU3frJumnugTIMp8nPA6MppqiWnfzPExFHs5ANzySxA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Rk0xK3d0ZVlKZng4cm4rNWdlYlpWaEE1c2FTNEtybGlYaEdCZzlkUEI3NTFs?=
 =?utf-8?B?eUt5NWdUVEQ2VlUrdlliWnA1eE93RlVpQUZoRVh3bHVkdXBlZHNkWFI3UlRH?=
 =?utf-8?B?ZlZmcnF6c1pwVmxsT3lQVGhGdjQ4ZTN2OEhURjQ2VUNIbDJOQjBmVTQySGhz?=
 =?utf-8?B?aWlXMkdTUTk4WW54ZG5SbEtpYk93a1duLzNVRWRrSHNLQkdmOFM4Y25uUDRr?=
 =?utf-8?B?TmVKOFdJeVk0dmlXQksxNUZlc2l4T2o5TWpHWkVIWEhUTGFmR2VITEJXemJU?=
 =?utf-8?B?VHBlTmtma0lIYUZpY0xPQ09PZ3JGbUtkaHB5R0NIdFJ0NWtHZEdzT1lTUmhz?=
 =?utf-8?B?N2lmMit4SjFjbHlKRkltOGtYUzVEaVJwb282UTM0RUFicHBGU04rK3V1Mlhp?=
 =?utf-8?B?RnQ4MVZhc3VVSG05MjVReS9EYXMyWUlBRDdoeDhGRWNDVjdjY0pPOG4zVFVI?=
 =?utf-8?B?T2RMbGsxRkpUL1o1WE5iVTNjYnBkUXFZQkJvUjZ2SkRQeWZUNU5GZ1d5Y1Mz?=
 =?utf-8?B?Rml2NjFNVy9RQXhxdG5LY1RVQmJrMUNTb2xzRUZNTDYxOVZmaDBNcWpuQ0VN?=
 =?utf-8?B?VkxacWJoMHNNRmZ3MkdMU0dyYktoQU44VEZNODJhb25jWHJ5My9iTzJubFpt?=
 =?utf-8?B?UWYwRHdVbWpkVndrUHdwWUZuVVhBL2lraFVwTjE1czcrZjNyZ3ZBdi9oSjQ2?=
 =?utf-8?B?Lys0d3czZ0tQanRyUlR6czR4WkJyM0h2YnpTa0R4V0ljdmlscVpVK2V1L1lK?=
 =?utf-8?B?cXordWlTRWNldmlkMEVReVBOeXFHT0ZTZXBoMjEvcER0YUl6eFh6d1BWSVJU?=
 =?utf-8?B?WXExZy94eDhpZlRWRkdoNHQ5eWlOQ0phUmJiUTFvMlM3cHgvOVZkY1h5RW1P?=
 =?utf-8?B?NTZOcmxCemkrckd5RThqZlFxTEQ5TVVHRnBObXdtcDdXTnV5Ty9MSTlaSHJw?=
 =?utf-8?B?WHVPUGRXZXNXVXBuR2dqTnhmWWgwbFgvbCtoMklid3pmZ3Y3NWpTT01rYmFV?=
 =?utf-8?B?Q3BXMnh1UktVYTNPa0pKZDRVSk9YNWdieTVCSEdMa1RiOTduWlZlRDJVUVNQ?=
 =?utf-8?B?cGdkdm9FbnlYMnBjOFJwZXpkeHZuSzkxUTBXdnhsWXBJejV4Y1BrcW9ua3BN?=
 =?utf-8?B?b3doUHlVL1Y2RGFLK2QySHFyVmplSS9Jb3RmMEszUGFJbmhBbEZHT1NvT0pZ?=
 =?utf-8?B?c2huUHN0cldNWWFhOTE1SWkxOFpuV2w2SUxISG55NVEyaDJWMVorK1FQVnpY?=
 =?utf-8?B?TjVQekR0YzYvMVo2dDBsVVowUmcwUUt6akNVMWRyUk5ZMHl3Rjh6bEtuTUVT?=
 =?utf-8?B?T2ltOW5kS0JuR2xJbWhGNTQ1RWFib0g5ajVrVUhvM3ZlcHJKQlNxWXo0UTRB?=
 =?utf-8?B?WkJCNUR3WkRuaThFSVlzTWEvYTZPVnFyOC85R1pjc2g4a2IzMC9kMG1vRlFv?=
 =?utf-8?B?dDl5V1lQQTd1WjBSczRobFVSL0dhY3VZcjN2RzR4RG9hMXhIV2k4RWU4MXhC?=
 =?utf-8?B?c0hOSWdoRXJKT20yaXl6OElBMDN3aldDeTdoUS9zVWNCU0V3OU50VUVKeFNW?=
 =?utf-8?B?YUl4Zkd0ZFFITWQ5OHV6bStPSDNVekQvallLNWFJSGY3Qm9uMjBXR0IxYm84?=
 =?utf-8?B?UGdYMmhEbWVBZmhSa0F4UDZDaEJQSUYwMjB5L2hOQW9aUzVkRnpBTlhJMENr?=
 =?utf-8?B?bjNVK2Q5bHAxME5jSGFad1d3bU5GNkhqV0tDV1UyWWdva3pyaXhOSFFFeERR?=
 =?utf-8?B?M1Q5aVlwVmdHbTJoSWNCN041QjNYK2lJZ2dEUWkyQUt3ZWE2OWF0RFpaY0Zy?=
 =?utf-8?B?WUN6S0FPczU5bEdVTVFQaUpReTFqNDZlbHhKaC9PeGNWVkRXMWNyanBWb2Y0?=
 =?utf-8?B?NWMyaUFXTlZUUlB2RCtDU1BHSERiTDhFNk1oME1UeW1FL1pWWC91bVZFMWhK?=
 =?utf-8?B?bDRoTG1FTUUwamQ3QURZcDZ5amhMODc2cjdTd0VCSHhRaWtYbzEzTUxqL1hU?=
 =?utf-8?B?SXVWZ2cvNW5jNTVOUzVFcmRORHJ5UHY1K25FeHJtTjJPYVp3TVl1T0FHOXBH?=
 =?utf-8?B?TkgwYmFtUUJYQkdzUmRiMTZuaWU5MVZYTXBWMnJSTzJYbnFiSHZqMzl0MXYw?=
 =?utf-8?B?NHJhUko4Wk1UbWpZRWhzOGJUb0IweUgxTU5xWlNhT01iakJBOHZ2c1V2QnFi?=
 =?utf-8?B?MHRBVmRZUFEyUVZFZkN3Tk1adW5ad2N5VU9Gd0VwQitwR0dqMGpMK1dSSFJx?=
 =?utf-8?B?Mnp1TmtzelRKbHQ1UVEvWWJUMmZMYXY1R1FBZjVpTDljNnZ1UzIrTFIyWDhP?=
 =?utf-8?B?ZkJJVGZWOG5RbDE5blkzQ0NINnNqNDdWMkF1aTBzUGVDZnNSQU1KZz09?=
X-Exchange-RoutingPolicyChecked:
	EtMghOSgxIPpHx9lqVyF87aM0NRHFqdFmGIGTjEIuPUlsO/cVv/BSDUhL/2VVXoRjka7NMbdy1nz9gba1agH5rgaY3uHjVYG9jCaH+bFhBakI95FXgkyxtcMFxDoy3eufeIL+IBh7+euzXQ0KUrlaCou3gwGWSYof88Yb+o1IzB4m+gdJZXTyFapBjz7P0SNkFSJ5NHqDcJ5drVZ6cIU4ucVZFLzpgYfYU09xKHLvqVP9mi1R0D3ZMEvds6zSo6iUDDmSyOdCHh95DuDGsgxWmQlmj5FAV/VGdtvsLRjZHHuyxznoFA1O0rHeWYETpK5dOv/xoVQeyGtonVobKD/iw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266c95c4-a400-449d-367a-08df2b8e901a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:05:41.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIxFloyXLvMlf2WU0aa3e01DCpgKsCueW9+Wt/nF7vUpgRL/rB2n+3wqus7XVcPi0wnCOJbSAjyQbtfFF1e6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989646
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfX164Yu+P1SnOV
 Spkl6rtn61MzgLCzDiMbIyGcXnMgOAeQt6gux4EWGHdeRNYy6XOYeE9EOpKAl5PIkagbmnp544q
 7XRwOFEMjdrYyNU3vDYtawl02Qn7Z4DqbuRS+oUTI7tZ5aWPx4o4TLKRcTzXr3V16lv/80d1mcX
 hp3EcS7xQ1VIfrgZEHoUv6DzRTs+ahnSJZ3aZ0GB/dvxSdiHemWEi+OKFs3xUHTbA6hYlasUU9v
 LXiqW+BW+yWRMQtqQwXuXL9pUMlSL5c+DIgiPSPOsbYBGbZjXzMv1p6JdJB4NgVjRxIhho/DNOB
 Q8f6/uCNFI5IDQTUBb8I8fM6nXkyIHc0dBsi61TCOu+vvF+Rk+HIsA2/SqQNXQ3xm0bpOXFmrWL
 HpWpoWYZdKvBYZXoxUAs30RdYNMlItmkR14NPoFYpB/2Frfx/nb1O0PCZLoeOK61lht0elyIuTG
 AgPwlJcH5Rx7fhsT0yg==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad22f38 cx=c_pps
 a=6zE/HbjXcl5L3wBq6eN3xQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=3uDZ8oAGO-rKZfTBdw4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y4DgyDhH0yUNiCaIOb9sL5ljzTIYqSUD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfX212kaGaYAUiH
 BjR1WfWyaq2bPAI4bdV0U3UIm7wd/vPEHYCDMpoIQ41sPUzXfHh0RDAL74ueP9IBES6of8rwNrY
 kf4NyQoTF3Z1zfGvcrxNm+jS8VmvWPJdA7EnFxe+tTVYweKwzJLs
X-Proofpoint-GUID: Y4DgyDhH0yUNiCaIOb9sL5ljzTIYqSUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160055

On Fri, Oct 16, 2026 at 04:19:33PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 16, 2026 at 08:18:08AM -0300, Rodrigo Alencar wrote:
> > On 16/10/26 09:45, Nuno Sá wrote:
> > > On Thu, Oct 15, 2026 at 09:41:40PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 Relay wrote:
> > > > 
> > > > > Frontend devices might not need a backend driver to rely on. An IIO device
> > > > > that supports backends can behave differently when they are not available
> > > > > and that should be acceptable. Such parts may provide basic functionality
> > > > > solely using the control interface (SPI for instance), being able to have
> > > > > extended features when a backend is present.
> > > > > 
> > > > > Add devm_iio_backend_get_optional(), which returns NULL when the backend
> > > > > is not described in firmware, i.e., when the io-backends property is not
> > > > > present or, for a named lookup, when the name is not listed in the
> > > > > io-backend-names property. Other errors, such as probe deferral, are
> > > > > still returned.
> > > > > 
> > > > > To make that possible, a named lookup that does not match any entry of
> > > > > io-backend-names now fails with -ENOENT, the same error returned when the
> > > > > io-backends reference is missing. Also, the missing reference is no longer
> > > > > logged as an error, leaving that to the caller.
> 
> ...
> 
> > > > >  		ret = device_property_match_string(dev, "io-backend-names", name);
> > > > > +		if (ret == -EINVAL || ret == -ENODATA)
> > > > > +			return ERR_PTR(-ENOENT);
> > > > 
> > > > No. Please, use device_property_present() instead.
> > > 
> > > Oh right! Totally forgot about that internally :). And it fits into my
> > > internal point where I don't agree much in treating -ENODATA the same
> > > way as property does not exist.
> 
> +1
> 
> > Say a frontend consumes multiple backends, but some of them are optional.
> > If we care only about the presence of the property we would fail when
> > trying to acquire the optional ones when the required ones are defined.
> > am I thinking correctly?
> 
> If there is an empty property for names, shouldn't we simply fail? I rather
> would consider the firmware table to be broken in such a case.

What Rodrigo is saying is that an IIO frontend driver can have multiple
backends. So in practice:

io-backend-names = "foo", "bar";

But we might want to have foo as optional while bar is mandatory so that

io-backend-names = "bar"

So if we treat all errors (after checking for presence) the same we will fail
in the optional one. Note -ENODATA also means match_string() failed.

As of now there's no such usecase in tree or oeven out of tree (that I'm
aware of) but to support it is also fairly simple that I don't mind to
have it now.

- Nuno Sá

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
