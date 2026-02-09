Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F4276028;
	Mon,  9 Feb 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647889; cv=fail; b=gkuKnPQeiAcou5mSgTONcSUDX91CKLfqN7g8yWVtbz8DbwxgJU5nhddtEPOdg9Mf0G2QgLSeiGwcx9SNvwtweCUUMRu9RbboAE2XUl+tuhSyE+hp0wf0JjQQ15AImmZgAJ/RBNdKOu1NCJ689A2UUBB17qzRJe/g/kUWHDT8j6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647889; c=relaxed/simple;
	bh=xYjVYut8yN3oLKKHqyOs5kp/vm3LzvnJngANep3uNAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J4jM2FADrfxSb9ln5IrJxbjoOMM5C6Jn4+vs627Tphs/ofR/sZKUDHa05Xm1vmrK6XtSx4RcWxfodPT8PB3F2v8XIQR1rd7v0YpWhxz6dw+KKNtOPmQIXDsQVveVUH6ZB9g41OMgiVlvJ+KgMtL/XDiwoJf6LyPYgy83e8ERK4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FOhgxj92; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FOhgxj92"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619E4RPg1828995;
	Mon, 9 Feb 2026 06:37:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WWTVV7+Z4z5ILoOrFu9SMkH+C82T/1DIfBkIa+vJ0rc=; b=FOhgxj92s8eU
	ugyO7VLhTUvp289RUqNQ/KemGkwtNbPoJ1SVms2q363zLrd/xbwEDjP5L1gZG6S7
	PtEDU4aJLFjgRNMf8FFU0x8uCE1XvbeCdMRdoPxHMF5EYBX3aVi+K83DuqmhLTGk
	aR5dp/ESVsOockLCcnNBRtgrGXT9wd+vKnSZFZ7jDXPwIC5vaJLOCnlcwO7BEED2
	7WbF+kiOAdOPCdqOH3RON0ZJ+0v5qV2F2PFj2Yie8zwOGXk9TWfBUr7l/vc+kPKy
	LPAoqOyQp/+APZrObg9cLQ5qxtC0fR4SMr6+ylFClPGoOABYattlSfiBePT94+en
	Vw3tAZlamg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c78fd43jp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 06:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyhcn+eWC9x+6thQg1N570j0tlSohHYym37ILvL+oHO/yM+XtVmPk455FaPLWZl/n+dMb8gOvSZSN/mRbA0lEi/POFCn8v3TP11+gFZ71ehv9LQ6W7c9zRwtHnD/6DMrfgWl28RqQejfYTVBlm8VHCEZMKNE1Mq00EQ7zPDO3B6v4I5etVXnMNarw+3PwUWUZD4HLvuQ3qQiuErK14K3Jlw4iblHZ8S9ffzXq6EpTR9yCArNTlHe5Bclbxj6im5DNsHBtET5Yu2Rs9T7KeW8Xy2eHC3plfaAAAqOZPcaOAAQ+cwqD9S5klJSnFXpJUe/56Xyh5qBvYoQnUlmfH8emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWTVV7+Z4z5ILoOrFu9SMkH+C82T/1DIfBkIa+vJ0rc=;
 b=w38g9+ageuRr8httDB38WfCx753NNpeInj1ox9N4VWEvvFxxg56Yjk+DcoRcj3HB+p5bMEF5UgqpnsjALQ4Xw9B2f8Iqk+Jv+GaMigazW90A+k0tyldLOKBgMYrYc3Hq+JYpFmH1bD1FpFxA5IQwij2uHHRHBGN59ijanAlVX8kr96R43c0lfm2aXNHPR+fcTuoZ0gK+Waw2Pk+k1G4UbfIJLiV5xBXKnaPljxGsmWMXrG5IUx5FAapLLuHAqK6q4HPLcjNyGLqEsxj0ApfQSjMntNpK7aNxWDEBclcO2jgj9qraIt4pAjXboga//9GucXtzlX4gsfs7EHzHembjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BL1PPFFE89DE15E.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 14:37:42 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:37:42 +0000
Message-ID: <86cb317f-1fdc-4250-bbf2-8ea670b34ca7@meta.com>
Date: Mon, 9 Feb 2026 09:37:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
To: Jonathan Cameron <jic23@kernel.org>, Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
 <20260208193034.7c780426@jic23-huawei>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <20260208193034.7c780426@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:208:23c::20) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BL1PPFFE89DE15E:EE_
X-MS-Office365-Filtering-Correlation-Id: d03f58ac-2e7e-4f5a-013a-08de67e8c82d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ViZTZJRmwyQi9JZDhPemtaZWxHM0dNMUZjWWNIRi84QmsycUM5cDBRYXpR?=
 =?utf-8?B?ZWRjQjl0N1hsOWxLWlNJRWt1UW9OVmFaTVdneXhXaFZCRDJKZDRqUE1sU2hF?=
 =?utf-8?B?bTUzU05pYVVvYTdWeDN1V2lFUUZGaW9TM0tIR1JTN09rckJHc3p3Vkdyay9i?=
 =?utf-8?B?b3NySWVRVGJHbmdpVDdWY201MGV5bHNDcXIwU05NOEpGcCtvdVRJWEpWMzM1?=
 =?utf-8?B?KzFtbUw2Uk40OUtGQWU5T0wvR3I2ZGI3UDFPTi9xK053VUpGdkRMbUpXcFJz?=
 =?utf-8?B?OXJQTTNRT0ZVMXlzUXpIUk9rcDBNTWprUEZNaWs5UXJhYXd3bm5uSDJaUDFR?=
 =?utf-8?B?aE9ZYzZrRmY2Ti9tRTVZdC9vZ3kvTHpJZ2tYUWJYQUJYbm5XZDNPWlNBbmZF?=
 =?utf-8?B?UFA4cEUvUUYyeDVWYXlTeGxxdm44a3ZGRnMweHdRcThYSlRBTlczL1N6eDNi?=
 =?utf-8?B?MW1Eb25rNlkvdGdGdHlubnpxc2tLOUVwSDB6eVZTcGgxN1lTWHFkb2twanBP?=
 =?utf-8?B?OEZyTERqaWJwZXBKdlBBbnlDNTZMV05walNsSTBwS0RIdDgvalgva01LNFly?=
 =?utf-8?B?Y1J2bzJkTUhDRzBuZ2FUenRuNlQ1TGFtZThDS1Z1TlpGMmZ2MXJEUzdjVnRy?=
 =?utf-8?B?TmZPVUhJNW1RN1d6ZGJhYUhDZ1JNZmxFbTBaUzBzM1lGd3JWdCtYdWNWZVd0?=
 =?utf-8?B?K3RSandTbXNzUDJTTWNaS3pkZVk0cFZIYXRYNTdMaHJUYWxxeUF1VmNPWG0z?=
 =?utf-8?B?Mmd0UFpqWXhKeFYyUVloUXN6cnVycEc2dGZHNUs4QmloU3ZobDdlcFRpd05Q?=
 =?utf-8?B?QXZQTGdLdi9ucTFPTWp4Q0ZlczhhU1RxaUR0Z3dyZ1hVc0gyZXQwL1pKUnN0?=
 =?utf-8?B?bWE5RlFJVWdZZENsYjcxekZ6V1orZEtXYm1JaXZvYVM0cEF5RktuN0NiRE1a?=
 =?utf-8?B?MkRiUUlUVGRQRTBwWGNUOGVxQk1SL1BGMlVvblBPeStjRWFoZ1dFN3QyOUFT?=
 =?utf-8?B?Z0RtTkVvU3pacUNtUG10TFVIMFEvUnJxSFU1UWk2U0dhemZjQVBROEsyc1p2?=
 =?utf-8?B?SnRQbzFlbEc0WmdNcUdOVTFrYlRTQUtDVmN0RFhPZm1MQUhyZ2xxV0NrZ05W?=
 =?utf-8?B?cDBYRE9raEdRcTZleGtDYWM4a20zdFZHZzlxUXRpUEluc1VGbng3djRJeE5D?=
 =?utf-8?B?TVUwZG9zc2ZwYVY3SGVueEdmdGQ5bEtIMzM0ZFV5V21FVlc2VXZ3YUJwV3Bp?=
 =?utf-8?B?L3VGWUhuam1DeVZSMFN6Y3lLMFdXL2ptckN1bzc2a2FaeU1lWHBHSkxlVGxB?=
 =?utf-8?B?RWdxbHcwZDluZmpSSFpCMHlRUFR3aXlNZFJzUFdHK3NteU1DdTg4VGRtd0VZ?=
 =?utf-8?B?aG9pYytBb1JhdzRnbHBXUkxHcVhtZjRPbmRiZUhtaGE1cHhvMWpFMThTS1pX?=
 =?utf-8?B?Y1Z0VkFlazBOWlhvQnZlR3hOS0NvZm53WGRFdjF1RXJSWU8vQkFLNFRVZFNi?=
 =?utf-8?B?WHlLMUVOSUJUMmF2MzRxell4Q1k5TG1OQ0F1dkp4cjN2OXhabnlIOWthN2p3?=
 =?utf-8?B?RkxtQ0d4RWwzVHBERHlzNG9Hb0JiUmdFTGVycExHZjUxQWtqQ0RFUElOcG1X?=
 =?utf-8?B?RGs4eStLUnZkQWh3WXdoK21ZaVVxaG9nMFJpSHZpNHV2UTYvQmpHb3NJRm1p?=
 =?utf-8?B?bG5xL2VtTkFBTkwzY21nZlc4cndCdTFwVkNEZW9BSnUreVF5d24xNHRRR2tm?=
 =?utf-8?B?VzFWMktaWmxCc2ZkRnRWRGhpdDVYUS9mRDZ5QWdKWlhqZEhXTlkvdnVUSTNO?=
 =?utf-8?B?dWx5bncwbVNNdXFxZE5sQmZKd0dXSnZMM3NPVENKZy9QY2VxaUVnandrK3ZD?=
 =?utf-8?B?eDdLdDNLSUFsWGpUeTZ3SzN3dzZITWJnUDBkY2VTM0NHN3JXSTRxOFpZSGxj?=
 =?utf-8?B?c2V1MkZDMDNRSTRCa2d5TzEyTDRhNmFvMVIzVzFqVnZsYTZ6LzhFa0tIdUxk?=
 =?utf-8?B?VlpESzF6VktheFpDM1lxMksrNlJBUVZGOFRiaXFyb0ZvcU82dTJ4UXVqS0cz?=
 =?utf-8?B?YWZLNm5QemtSMjRGUmhvYk9tYUZiR2tIajFHbHIvQ0tUeWdYVmVaWngrNWNw?=
 =?utf-8?Q?v6L0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2pwb3Voam5jZDNVYjBPSzBwWXVHenhybWlSRVd4ZHVJN2IzRk1kYm51dkhY?=
 =?utf-8?B?SXlBcE90YjJUWWROOFdtSWdOemVVV25CbHp2MStQa1lWYi9aRDQwb0JBRnlv?=
 =?utf-8?B?Zmd6aWhTMzZrUzJXaS8yczFtL3pCbkNGUldEQXlZYkJCbDJwbzVXS1A2cGpl?=
 =?utf-8?B?cTJrSUhZUndtUnJ2a2FWL00yb3NkZVlaUjBGS1hnWlU3RW4xRXI4clJPWm9u?=
 =?utf-8?B?OXZOSHZnR085eWk3ZHd6OVFEOE55SURoNDNpclVOOXdLZkkxaUQvUTY5a0w1?=
 =?utf-8?B?NUZvSS9zMEV1cGxWUlp6WU5DNEV5bU8yL0RxLzlSOU9Zc2RyVEdlRGUyYllt?=
 =?utf-8?B?c3QwUm1nclVhbkpVUUpCSWZqN04wZ2NXQmR6VlNhMjNOaGsrdDlHT094MXJN?=
 =?utf-8?B?Y1o1MTFXc29tTkNSeUwvUEE2OENDTERYdVZTV2Y5VmcvQXJuL0Rta29DcE1E?=
 =?utf-8?B?K0F4cGhSUTlZd0N5M2VRa3VKMWV4ZFJVd0dOTS9POXVQQlhmNTZqalBhbkQ1?=
 =?utf-8?B?Um4yUTRzV3JSOVp2MmxFck5pRjMyeDBoSDBGUEtJcmhURjZ4cGpNNFh4Tm8x?=
 =?utf-8?B?VDZuR3dWa3N4WW9hMVhnZDNTUjg3dUtqczBka01aN0ptZmZpSmIvNVlPaHR0?=
 =?utf-8?B?SjNHc2lCWi9JMHFwMGE5TUdVdEVzY2NWejZwTnk5VDBKTTMyMS9kUWpaOENY?=
 =?utf-8?B?VU5pWnRQeXZDNGpNMVZiTk1tL2dEVjB2R0lOZDVhdDdWNlcvR1VSRTZ0dVNv?=
 =?utf-8?B?M1BQWjl2UDd5dXdrLzdaZGFleERmSENUZEk2UllpaGtkL3BCNkZTMTRzMVRM?=
 =?utf-8?B?czZpditmQkQxSStINTBETUFFM3JYME44Yk9SalB3KzZBUnoxcFF6M2xpWStS?=
 =?utf-8?B?UDZSTFhGTStZOHNGZm9URDJjR0pUM1AvN3VSRzVtS3ovYXNyWkExU3lQZmk4?=
 =?utf-8?B?bDVndmNielUzOVNzTkoxL21GWVVEd3d0Smd5TWVycURaUWtJcXEwWkxhbWhu?=
 =?utf-8?B?YXpnYjVHM2NKNUxrQXZ0bHd2MDU4c2lGRytHSW5NMENTZ0srVjlFditDZEVS?=
 =?utf-8?B?Y1Y4SHQzZWpKTS8zQ3A3SFkxSU51UWpkVjNaOWtQc2pmSDdndk1BeERUVFJ5?=
 =?utf-8?B?RU1YMkMwc1pUMHVRSzFORmxIL0kzbzBIWHhqbHBTZWlmR2FmV3pHVWNZNTlZ?=
 =?utf-8?B?RlZHTFN5eXArWHB5MFJoTzlpU2t5bVovNmJJWXlNaWM4S0c3ZlkwZys4SUpD?=
 =?utf-8?B?SXlHR2dxTGlEaUxiUFdBcTR4SDJYKzRCbDJQd1NVSW43NXdrVjNpSlg2VENj?=
 =?utf-8?B?YnMwOXZDdnlsWEpkZ1MxVzBvWGt4TDFuZnlkNUkza3FPcFVlbm0zUFVFSE5Q?=
 =?utf-8?B?SGVDM3hISUo3YWNwY01KaDlkb2I4eW1VZVBXczR2WElGK29GYkJOakpDOERJ?=
 =?utf-8?B?OFFQRWR0Qm9SMzZTZVpBSXR2M0tsa3VGQXNEb05NVVJWcWNpVC9vbSs4NFBI?=
 =?utf-8?B?cUl6L2pxKzVMWCtUaWcrOVhmR0RRaStLdjNsREMwK2lxelJ2cDBHQVZmZ1Q5?=
 =?utf-8?B?bTN5Ni9hOTNFelNVeFQ4dXMwU3lGYzhXREdVa0ZlcnpGYWpZSGh6V3ZzQVF2?=
 =?utf-8?B?N3Ayd3pMYnNrTStVRUZtMDV1TmtSRU9YK3dudlozNnBZZEtOYmFNMUNXWGVU?=
 =?utf-8?B?RzlNdWQ0N3VldytGak9CQlFBTzhHRFpXcThFNlJmR2l4Z3RxQUw2cmp1SGZB?=
 =?utf-8?B?aG9TNTZ1c1lUbWdqeXAwNi90SjRKOE40RHZVY3duK1VHcWxOZ2ZTbWVlc2lO?=
 =?utf-8?B?bVZVREZRV0RrSlUzY2dHamhSSC9JSWhXUm9TZ2dERkF0UzJEZ05YeTgyNE84?=
 =?utf-8?B?YWdYWFY5LzZiRVhKK3ZSNnN6ZlJhLzNKYituWTBaOW42NEdBVGN0OEZSbHM5?=
 =?utf-8?B?UHM5SWN3YTVyZ0I4VE1KZVY5QUZJTC95SUJ3eDJxWHVMSkZkYkhhMFM2cVVK?=
 =?utf-8?B?ekJoWERBWGlhUHJnQlRHREc1aGZVT1orRG53Z24rYkN5QUFlUVVLRmZJT09T?=
 =?utf-8?B?Rk1OeVB1UGFFN2V2R3dQeXBscXI5TjFWbFFkK0ZpUTg2ckN6U25hcGlOMVdZ?=
 =?utf-8?B?aUpUcjA1NHpJa0s3aGRwc2lUeVI4SEtZaFVua1ZHNXY1MmZvTlQ1L1VucjRh?=
 =?utf-8?B?ZkV6NC9CNHZ2UGZCbS9EMmhRN2t1bTNvUWhsbkFUYnV6c2NOZWliVU96QThW?=
 =?utf-8?B?TGVkallqaHFWN2FJVXZTMzR6UGY1dHdyR2xNMGlNTktCV1lock9ERitLRzBY?=
 =?utf-8?Q?/QcDovOTp5DLC4r0Vb?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03f58ac-2e7e-4f5a-013a-08de67e8c82d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 14:37:42.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG+FMz4jrJu7+DnuMK9dbhnvIyv1rd8LsFzcgTYKWYBih/uGHahC8EgGQcN66SS+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFFE89DE15E
X-Proofpoint-GUID: FbZIRc5xL-QoG1ONhklMKVGzW1R5z88x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEyMyBTYWx0ZWRfX5Aqv3pZGNs7I
 j0Hu+NCOL+CULZ4P66paQTiAzmY74WkKQvqjyQFADxxLiRc0X+STlYbeW+NLO3wGFjl7yFXxxFG
 V22xFLafLhKSprfIW/hf8Hbuq9KxgA2zSdQgM/H4mu3vL+stfreGXlbaB27Aw+xty8BHgqlF67C
 xZfJ1TpKvSLRQ4Xvf2VsEK16ZTobrm2N18uV9yR5VaK9Zz2dz+VpH4HNt3atLBb81vWiluW4r7Y
 mcOJ3pV7JNwrntwx3qLqiIzQMLaKDe5TEBTAnjB2d7Uzs6S99KzEucuRuSt4B0vLQNT5xVsPFw/
 ixp40iKCGCSosQYLIwTYwLTtzfShuDjkSFk2kUzKWdue2kZnBPnnkp226dwRpYfGSwH/vC85UFj
 sAlsr0G+s9Gblq9V3SsI9zGLIpdZyKHqJisStudJCjFxyHKmnHAqNfrasXphJB20Bkd3WNhIBNh
 w0Fa3hPGKhR5XUCyyzg==
X-Authority-Analysis: v=2.4 cv=XbGEDY55 c=1 sm=1 tr=0 ts=6989f138 cx=c_pps
 a=ouBVT1c3MJkzDXWVqRnxag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=eWRtdWc1AAAA:8 a=HpjocXjqEpMV3nmGl8AA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22 a=fQEa9puXOWAy-YWvlEz7:22
X-Proofpoint-ORIG-GUID: FbZIRc5xL-QoG1ONhklMKVGzW1R5z88x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01

On 2/8/26 2:30 PM, Jonathan Cameron wrote:
> On Thu, 05 Feb 2026 12:24:11 +0000
> Tomas Melin <tomas.melin@vaisala.com> wrote:
> 
>> Add capability checks for operation with backends that do not necessarily
>> support full set of features, but are otherwise compatible with the device.
>> This ensures a fully functional device, but with limited capabilities.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> I've mentioned before that I've started messing around with Chris Mason's
> set of Claude Code prompts and today I was trying out the new stuff mentioned in:
> https://lore.kernel.org/all/b187e0c1-1df8-4529-bfe4-0a1d65221adc@meta.com/ 
> 
> 
> Given this patch set is pretty much ready to merge I asked it to take a look
> and it came up with something that certainly merited me taking a look.
> 
>  Issue: In ad9467_chan_test_mode_write(), the testmode_on path is guarded
>   by IIO_BACKEND_CAP_CALIBRATION but the matching testmode_off path is not.
>   On backends without that capability, entering PN test mode succeeds but
>   exiting fails with -EOPNOTSUPP, leaving the ADC stuck in test mode.
> 
> I may be missing some protection path, but I think it is right and if you
> were to set up the test modes with a backend that doesn't support the
> relevant functionality you would indeed be able to turn them on but never
> off again.
> 
> So this might be the first bug in IIO that the LLM found and human's, including
> me, missed!  
> 
> Thanks Chris! I won't +CC you every time but wanted to acknowledge that your
> hard work taming these tools is very useful to me.

I'm really glad the AI reviews are helpful, please don't hesitate to
reach out with feature requests or buggy reviews.

Also, if you're using the prompts in CI, I try to keep the breaking
changes to a minimum, but I'll be refactoring things over the next few
weeks.  The entry points (kernel/review-core.md and kernel/agent/orc.md)
shouldn't change, but some of the other files might move around.

Please don't be shy if we're adding regressions for you, my goal is to
make these easy to consume.

-chris

