Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181681;
	b=VW6dKja35lAkZ+fFeFaNY+hYwZmioE/cK7spLvpR2pfjxaIlWjM5PfYxsfWMYLEi48je
	 pRs5ognJEHwHF3XE7cDbPucY+fykRlFMZAiQYGQ98DWcwg8TXGbwdpIoBtYU6Mf3xsu/9
	 Tf/QhhpNoaSqQgFV9fXs1sRqJ1p2pJ5nRq+VWZJWRjnxudOWelbC/L3bnAIIfe4sdKljd
	 WCFgsWZAxPs2Fo0/Z961o2BrDssrC8fpekrTWfp6lkyO/BUe98WK4t/it91M0TFlSRkvI
	 A1Qk/davdCdOo2f+ATFhLM2K6NZpTlE4I55B+jxnisKtn6uV9m4vTYq7U+GgLF5rbkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181681;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=usfGLzLF69uRILzt64uQw5RbnmWcVKTZWPOv2b6TVM4=;
	b=BFJRJ4uMYGulwAVhH/RdFrLF5thBMe7YVUnhNDDQuQ8fnRdwfLhLiwvtbqyZ95lDEae2
	 hGHvzUoB7ZshM6skriWrK9SkFj8R/uWbGAgAJLNZr+dW/DRdK9aDi6yEOXGtNkihfYsD9
	 61lNh6bmjKntUtJ86LXQeKagbtxk78mcgvz70O8c5k+dvysSv1I6THPIPwGHIiKSU8gqh
	 TnSQbKCE1cSXKdbXZi+PtjX1te/A+HyqECbtMbjfiC7IabXXybiIamdFWmexC2kbc5tiT
	 18VaxVI8uIpPEV2OObyHLT2pNxI2LsJkiRniil7kAg5TYB77HQ1qbsJEGeiZxUiZUyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Y6puErQG;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VTOjfUii;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051AD606A322;
	Wed, 28 Oct 2026 10:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 051AD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Y6puErQG;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VTOjfUii
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8GlOP1152052;
	Wed, 28 Oct 2026 06:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=usfGLzLF69uRILzt64uQw5RbnmWcVKTZWPOv2b6TVM4=; b=Y6puErQ
	GVgCt8+sKCJ75nokcm2rErF0irVnxu5KZPs4MJPQ6v++RuTiirgjwUATz1o+nNd3
	C1WmQ0oZq5SCRUo/jc1xSpgX9xObCpKsnQ5nqp7HxiZrw0VQIKViwVWIWQIntmYy
	L5qKfCK1JLUp2r3VA127LuqZAZJJg+8Xqse6URglz8gAB6ZRVdPgYSPcjiK3gvz7
	2ICDdv0VOEmSLODVgQKlHdw/SGeiFc6e+yG9lBYTSM9EKjTu1ojx3LaDSpZzoTRz
	4EtgMNzt6i0d80gonXpcgw6q6n6c4GC6dWoOaGwX6/xRJ94EQKZnEH2Y8kuDY5nS
	Rn56LbRfNct5N8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=usfGL
	zLF69uRILzt64uQw5RbnmWcVKTZWPOv2b6TVM4=; b=VTOjfUiiHDXc5p7ddq/fk
	9QS7lCqGN0EBPGnBgeVKPC3skO+3ZJudpiyRw00vfdY1hF4TNLtjeqYkKH8rMwCC
	lFlrdhpldaJNbh/7Yngwtbftte1TpnRMY6gUMwxvmnULo4e+zwlAi9q+j3SQEa1P
	TWvrOXKYJ/potG0+LA2ZTKpcglxluTwVdvNoltsxQsX3J5mUAA8uAY+fcmPkUfvp
	Lm5qX66iYqYSu1O0wKKhT9ajGRLqsN2/8zp+we8B+AFgTBihTJuP/Bxo8qoSd4U6
	nt56w8bSNuQunTuHD7L9QF29e58MIX1TV11A0U56UimXakhcpMT+zAAFN4m+Xf3R
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hk3nck4da-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 06:01:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQrb6VNQKywpN+MF6DcUHaYZQnrQv9rLZfReeVD/ZJPcJ/4vP642DNGb+ZepAWUYgV6RuZN4aWN7NycXOLv2+27hdpAoaGi5TRXfrVL8DIcJMXFyg2YAsTICvE5ZGctizpxxB8oc33W5bJKChYNLOAVDbLbJl9DpB4S0Mg2w4b4zwaTrf/mN/29xn2r6A9kSd06VRR8qarH9tkRjbZYdjwdY3W2jQCakkCffqaF7qzsVwMlTHPeSWw6ZJSK78qHQ0i75vlWDslNC4au3fgVBIUGqo9Kmay5IyW0L3tTxQRZi551saJNtIRqpm5IPKLzvxhy55IcuawIz10rNdwluDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usfGLzLF69uRILzt64uQw5RbnmWcVKTZWPOv2b6TVM4=;
 b=Y8Wjx69yrP6dVmF2ifBBbPr/Ja8b6iI67zQkGmxivK6n4svYWKcfdimh+TPrfFQU2aEvsX+h70mmyDn2JfyqI6h+D5CN2fw6BDydGcPq1YG29DBTciMUi9TTO4PFhMdZJSAJLkorEOcrKRfqPvVHksXfqgtI4VusxZ3UiZWWibs9q6n3rg0L1/hlOTtmTPsTEHUY6Tt7C+lWohdnTj9sfrCI8D6nTzAtFh4123ppkDWDsNLeIIRyC/HcPKclCBQ4apebtBIvpKm6n5lMDug6e1EylAzckYSiuyBIiFT8RjTEuAy5OKpIPhlSRGLvjjaH7DZKcAAo+L/gV6FsCP8l0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB5238.namprd03.prod.outlook.com (2603:10b6:610:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 10:01:14 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 10:01:13 +0000
Date: Wed, 28 Oct 2026 10:02:36 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>,
        Ramona Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 04/15] iio: accel: adxl380: don't stay in standby on
 -EINVAL
Message-ID: <auHIJRLqIm97GrEG@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-4-0d818334f6c7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-llm-char-misc-iio-v1-4-0d818334f6c7@linuxfoundation.org>
X-ClientProxiedBy: MR1P264CA0142.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: af6a9276-e4e8-4094-e5f0-08df34da667a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261009223027099003|261022105027099003|56012099006|261021121427099003|261021123027099003|10067099003|22082099003|18002099003|11063799006|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 1ImS5EPx8yxCNtdAarQI1wfCAw4mYxhDQhdBIDjEEgFKiBLEWU0Vw48xLrDnTKXvHCJ3egsJzbyVEH24OxDzfiE6GBZuLBH3tw7V51KhHuULQaZtCdgYS4r+48uAoeQ0QKMnOjnV3xRY3CXc42cuo/7ZERSIMQ3QsS0LM0xUXWL8J1Qp2LVFPCXYhChsEITq3j17D4eeEKC9WpYGjSZTzTdzi7Cop91jSyKVb+fI4FIVl1yqMv8W1wJMSF/RwaR3vrs96VO6m6WIlmAFrdAEoHaYcXRNmg3n8ch8YwDSvk7xgJCgwuGsUpD0jWj3aYIj76HVFyDPOsY3pr6gvyE1aqDhX8Z0nd0DebZbLXrTIbCemsx+qxCqNtZP6VtwHxmM6Hq1HgHkNVDaONUgACIgAH0YI91a7w0S2PgAqXhRJzjum6m/ppH3cx9UExWS+wL31lFf3sbpqBF3gLAWXlUbQDb4uonRhxQ9dLZcVhwbPjDhpcp/nBI/2DQ0yrY2XArvo8iwEWdAGWIocBZLjr2YnuECp47QFwZhgFtfGP6u/jMwzS9c7wawNq1EwLzK/JmGiAcSxB69cJtnXRRys+XRrqHOFXI6e3fKfeI/euNlp0KO5l9HUT+hLzf90KVEu9LYRpxHmpBBykAn9Po6rUhR1QsDKT4jGS65F+QTfj0g4xQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261009223027099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UzhiRHNpNkYySlJLYnRxdEppa2ozODJGeGg0UllGSzBZVmtSOGxyeC95c0lS?=
 =?utf-8?B?eTJ6Tk5FOFdPUy9pbFZLQUJHN3lkcEw4ZUd3dHpaQWVKVjVsMm1iZHg2YnNS?=
 =?utf-8?B?L0x1bXppRncvZ3hFTUIvN0RVZnF5TGs0ZHd3VVZCcUhVNmllaUhDNXRZTVhT?=
 =?utf-8?B?cEpFTlZiNWlCTDRiOXJGY3FPSERkVFRHdkdCRjB6TkEwN29NVmlVYWRYWWdZ?=
 =?utf-8?B?OUZXVzdwRTRCOFFzeUF5WEV6MWIwMWJnclBYYy9KRnpXd3BsZjZ4Kzc4Lyt3?=
 =?utf-8?B?NDR6aVRSMEovSWlZM2lQWHNWVnBrVHBleWxCLzVrRjBDajBmMHBFYWxtY3Q2?=
 =?utf-8?B?NUFpS2dNZTF4SHRiSG13UEg4SzdQVXRsNTljNnhaWW0zR1AwSXI4eXM1YWFJ?=
 =?utf-8?B?bjgzZGNVckJWQ0Rhd0lEbG45OWJaejJGUEpBUys5aTVvSy9hRUNTQ1pNOS81?=
 =?utf-8?B?YkJieHBJN2VQaVZNOE9PampPd3VMMzkyRkhnNjFZZjBvM2JBcWRvaGJMNG1w?=
 =?utf-8?B?NzhPVHJ6N2Nhalo2TnBaOXFzZlJISjFPUmdtRTJaQTA1M0dEaDRGaHI2YmFF?=
 =?utf-8?B?TEE4QkVzNjA4bzlqNUFSclZ2QkZBUDZ0K2FsSktnRXlPS01QTHBzQkdkckln?=
 =?utf-8?B?Q3ExVzV3SlJoRUVEYTRCdDZQclhpN1ZPYTBnUGRBSEpUU0M5eEIxSTdraG13?=
 =?utf-8?B?RmxLSmhwUEF3c29GY2MzMG40Mk1yMXgxWmMxMHV1NmVBZkFHbTZJQk5tQVM5?=
 =?utf-8?B?S3ArSEdaTCt3NDh5eklzNUZRVHRpN0dFSWhkT1NLNGd2eWM2bHVFOE51Z0Jv?=
 =?utf-8?B?cVVZa1JyVy92OUtqR2xlWUxoN2RMWTBFb1VZZUsyYS9DOUZsZ2M4d1ovR0I0?=
 =?utf-8?B?ei9pV1FDNU5iOVJZaGdyUDA3SFZuK0ROQ0dYWjVsV3ZHZXpHeFdWb3MzYjgy?=
 =?utf-8?B?dkV3RWp6bG1qL3k4N0xQQnRua0lJTmRwTEZMVFh4US9YQ05MZmRZeFhOS2N2?=
 =?utf-8?B?a2xsZHU1bm90SlhIZ0FYU1VBdGlIZk11b1UrenJUSEhsZ3hUWUxCbktlRVJ6?=
 =?utf-8?B?YkdsL0J0NTJtcXRsM1gyUVI3ckJnUFQ3YnJXeFNzQXd6cnBZSEJjUFcvY1cy?=
 =?utf-8?B?OW92eGhQd2lBZG1TNXRYVGFFcHNoZTR6VExtdHpxeVo2Szd3NkFiTHJFTklL?=
 =?utf-8?B?V1plUllMUEhkd0NvRlNUSU1TLzVxc3hzT0ZZbWJMV2RWWVZDMGJqRGFYUUVj?=
 =?utf-8?B?MCtsL1F2b1FGeGFIUnVocnlMRWFSSjdBOEprS28wQzlXeGlPQ1lKK1psVURo?=
 =?utf-8?B?WVNTMHRCWCtIeWpOU2UwcXJKR3p3eStuTk9YOHJQUHVHck0rT2Q5L0R6TVd1?=
 =?utf-8?B?TmdhbGd5RTZCdkdCSlEwMHhsRDdVL2FkT09kQ3BhZW8wSkN2OHl0VE04ZEEy?=
 =?utf-8?B?b09ISDdBQnZ4clVYZHpOcEFvNjV3d0hKTXBRUlNtWUQwbjVaY01MekFYeTZX?=
 =?utf-8?B?QjQ2Q29ZRkxSZUM0UUxyaHRleHB1SW1NaWx4QkF1YlVhMkV0dzE0S3lEMVYv?=
 =?utf-8?B?OHB0REZGTGp6RzU4UnU3dTVqUGZaTU5VNHFRQVZzZ0t6Y3BNRDdRVHRiKzZn?=
 =?utf-8?B?RWxKYnFqSFh2U29jRWZWRTRMOGFTUnRiVHNqSTAwVnBUNkhpZFRqaHNGalZJ?=
 =?utf-8?B?UFBORmdTdmFoL1RQOVNmRWYzR3FUa2VWL1l5UGF3bWVIZjZueHpwMEVlVUpm?=
 =?utf-8?B?aFdIbS9LVDErK0lPTEM0NzdhVmowMHJDM2svVktEMVRSSVpjRm5GVDcyeHNt?=
 =?utf-8?B?SjVralVsdHllZnJycFl4cUhoZ1djbTVyeHdnRmx2NjRsSkt2RzFXbDk3WlFQ?=
 =?utf-8?B?TFdyTGp6K0NwM1VNVTMwVm1ZK202a05Gam5kZ21QSUVxSnFyQUd2VTBVbGVl?=
 =?utf-8?B?L2lCNEdJSEVySks3T0JCZGRtUkhSY2cyUStwT0VFUzBMYWZTeGFrRjdrdUdM?=
 =?utf-8?B?Rmlaa05tYlErL2Zlek9ZSUREUWxsRTM1UUlxVU0rVjFhTGw3UFNESVU0M2FU?=
 =?utf-8?B?dWU3VVVRdERoRi9GVEhJK2RDcW1FeTNWekc2c3MxTmpVU2FkamlnNTBhYlVV?=
 =?utf-8?B?RkltOGI5QmRBaGYwNmVYanR2Y25PeW5hcUh0SHp4WG1mSWljNHl0YXVsK3Jv?=
 =?utf-8?B?NGdoanpFVFFGNEQyYkZDempncVhuS1RBV3ZSVUd4elZ2MlZscVlzVmEzRmwx?=
 =?utf-8?B?WEpLN2FpNEZSUW9McW1rMVBZdWZ5eEJMQ3RTM1FzNytnM2NsU3JONmxIM05U?=
 =?utf-8?B?VGFzaFFxTzR2UmlKb2dlNFJkbGxlTEt0RHMxbUIvZlpoMXFsYk4wUT09?=
X-Exchange-RoutingPolicyChecked:
	RCJlOh1cTA/gVu7SfnYg7Eo0w26hs2Edf7gyXc/RL9VbUFPt03Okj94Ix0ereON2kPhtTdONbiryIBYkVRyiPy4Kc6SG1QvXXDBl7ruwrjOFY30FJT6LtTpeQaR2v3kcBDg6kj0RupzyNjgeSM0EA6kOwSA1qWBduvdOAnYxq2ZXKgQENQfq4Z7+Pm1e++0CpWqVfdcwbzYdPMj0+TZQBTCdHGEdq7Ksr3Bq3nFQuxJBzT3NXBS5MgaalAWAqPLTIqimZER1anVlYQrsX23k4bjg4q9QHR8xY1XWs8bNeBzeQ9XuejkelTe3EDRKukQF66FaVmhSdOiti/biyXALOg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6a9276-e4e8-4094-e5f0-08df34da667a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:01:13.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptpvyK2C/bCMZtGiTEROKrkd3MWhGlz/hkQdcI5w7c5xrSSXGmn9d1BZ7oJyUEs+mharGgbanRtgloiy+pyfXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5238
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfX1AOY5MCZD3dy
 TxY0B2UX6sxS2UuX/6g2gjlXpBwSOvisz5x/C/B/ffHsmlGnxu3cBtinf83JFl71LL90jsG6HK6
 nRzOQZr6kKO13i1nkZjKZHv5buDSimsHsWdbLpez1i0N3q7z2eqT
X-Authority-Analysis: v=2.4 cv=a/ClZkSF c=1 sm=1 tr=0 ts=6ae1c7ec cx=c_pps
 a=0FlYyfQadWprtAtRvkXThA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=ag1SF4gXAAAA:8 a=a0ROUVOLAVCJIK8jbScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: 7x1ramhP5l_bdrDR_TcFlgmHcyY27KEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfXxe7t+tQmgssA
 5clreRRz97jldmbne/dpU3n6fRPryhGeWdKjN1eCjblWhgsGV6B36gEgj4j7wXzD+N8LPhLzMaZ
 doMGNIUzLQlsrav0mUwyq4o5zvZMGDbSM8usNElVl5YtFg6LAp9L7YieUncEw/REPG/+LOReDEx
 DS8W6swCCLp/wd5ZLmwcgW6S9YLcD5PDa6ODt/wfD4djp2Blkl6n28ldV71LzXE2uAydFlIlxsX
 l7rGC3sYBz3Jhyp/jIbcdUmMGK2y5Wo09IGOtDVUPyRIvRA/ibL73LupFV6MBKqiIKvQfF4J+b+
 P0l7pbvhE+X23dXTWcrPZbTv9ugePcfIqdW2Z7UL9klWOx7jBkSzYeNNVObs1vcbds2GdUQWzo8
 Luzq5KzFzAPOaoZaMJEXR7e48H9LbRGSjehgHbMu5nHSEJrUdqvf2u4wdya0sA9uZcFyPixrtDc
 SbX2+BRCYCtVM5+E01w==
X-Proofpoint-ORIG-GUID: 7x1ramhP5l_bdrDR_TcFlgmHcyY27KEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280039

On Tue, Oct 27, 2026 at 05:19:08PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> adxl380_set_act_inact_threshold() puts the sensor into standby, writes the
> threshold and switches the measurement on again.  A threshold above 8191 is
> refused in between, and the sensor stays in standby: no samples and no
> events until the next write that succeeds.
> 
> adxl380_set_range() has the same problem and a worse one.  It rescales both
> thresholds for the new range.  If one no longer fits it returns -EINVAL
> with the sensor in standby, the new range in the chip, the old one in
> st->range and rescaled thresholds in the driver's state: from the next
> successful write on the samples are reported with the wrong scale.
> 
> Switch the measurement on again if the threshold is refused.  In
> adxl380_set_range() see whether the thresholds fit before anything is
> changed.
> 
> Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> Cc: stable <stable@kernel.org>
> Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/accel/adxl380.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 8518ee23e114..03b140303520 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -334,8 +334,11 @@ static int adxl380_set_act_inact_threshold(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	ret = adxl380_write_act_inact_threshold(st, act, th);
> -	if (ret)
> +	if (ret) {
> +		/* Leave standby also if the value was refused */
> +		adxl380_set_measure_en(st, true);
>  		return ret;
> +	}
>  
>  	return adxl380_set_measure_en(st, true);
>  }
> @@ -698,6 +701,12 @@ static int adxl380_set_range(struct adxl380_state *st, u8 range)
>  
>  	guard(mutex)(&st->lock);
>  
> +	/* The thresholds are rescaled: see that they fit before any change */
> +	if (mult_frac(max(st->act_threshold, st->inact_threshold),
> +		      adxl380_range_scale_factor_tbl[st->range],
> +		      adxl380_range_scale_factor_tbl[range]) > ADXL380_THRESH_MAX)
> +		return -EINVAL;
> +
>  	ret = adxl380_set_measure_en(st, false);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.56.0
> 
