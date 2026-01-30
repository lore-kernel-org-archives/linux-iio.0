Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022140.outbound.protection.outlook.com [52.101.66.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36E350D7D;
	Fri, 30 Jan 2026 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764657; cv=fail; b=r30u1KOxgjpUJgRlmJjc3ByAHIx1nCJYxqRrqc+d8vunknJDY+tKWQSyGb8H4dUXugUSbhLDcYywXBMUscJC2rFbKbB8LEnE0Cerl5l+2p2FwLBz9DPH9+67OxH6TKFitPoIpG6+xGl7Y2LizX236/hCtPz4ZEb3W1N9zxkFQaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764657; c=relaxed/simple;
	bh=AyH6UAL5LifplHS2h9DVQ90bgQ7V3na5tfsJ0zfRtCY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BsZXLmJpHAscM4kIK6MClUXcjBQ+4OGHWTtv0qOZK3rBxCWcJi9ORjcYo65cl2rLmAF/5BnEPKp7sVMxpNftd42/qV52rfi3NdkKe0jiiEW5SeVOAJjRZ6VNN36gGvQy6ZG396vpK773oJfC7BCn5SIEKj9wNgV2rwFfYrPT3gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=C5DK/SiE; arc=fail smtp.client-ip=52.101.66.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="C5DK/SiE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snRO5EOZuBsVhMT2Ods+rnwaR6zObrVsdd6xbWFojmBTAPuEeHsFVRs4aCUcBn/Ns9O40ssz//7wHB6YGu6k9fqrsNilGbDIAqjUY4pjh2DltxGZnfzVH8+rGuWgXgcifOl9DlL/O+6DHhU71fbcRop4RgWaSZbqNEdMDKTRHL0RC5REEGdOCN9F36lsvxoTVC7fcHcvv+UB6sKRcXSs2DWV2RSdlwBaAHyq7f6LBKSIp1pr3lThoUQUuTqAObbxLWqUCxkld5FnsDqBA7TnRWfMpVo3mLToQvsJKep5QLmz97DaOrI72dgBrAWK2NzEg2+Kuq/eTllm1jOwlkQ1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0mDtG1mjxPmADAaLW16nDzrEJfZnaRoFrQCKBl6rVI=;
 b=KS3anGUKxFmwjDG3VDqj3097RlNR/AsihLQ5qp9tmRvL6qXhh+xNXUD2nanEb9hs2AiQiGVOtjtoiFP5+FtHahuip6skLPebZ7mDSMOR2xOwvoEQx7RS3N9VM+GeXdXeMp45aZAJACplCTii4z2q5RxFAogXyoLCklDR0S/za1py0Lc4n/gNgiqx9cwMIBFvBUsYL5QRTLOqs2BXaMH/vD2FDoxB080rHZSV6rpBLWnx+//21KfttoUfFguBmVV9RrlIJ//Alg6TyxlqPLSDF0XlwbqyeSEBjXhdJQUIMKkto2BXx+OVcUGVgz20c/G/M4soIJtJ0mRMU3NdIDzdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0mDtG1mjxPmADAaLW16nDzrEJfZnaRoFrQCKBl6rVI=;
 b=C5DK/SiEidGXvCZ/5WfU8Fj5uJlXvg1ONExkqL10IP8GP/MirmkazIihVyezzNLofRFTnkWAbHo7wABhnIRRZpdLhPXSmGdI/4gkaxMMrZOqHpVj7Z0ldShkkjePXg4/PzNZTO/QXz2n9A+Ma9iz1EzOYFXf2Z6QyhgikYypBVg5u/tlx4FpU+M8RGqE8pr2DJedBKLjkHVAW3c1cW3DVVTOjHI8EppLZnbeKmDN4k0HqQAnyE3h9MT2WaTAk42NZD2DamuwNLUQ/ZCJEFjbSZqNMhp6wSJfX3REprdZohncAbTSBGtO6zJAOhQ/c1VdxgxOWTsh5AF7b58fPq8A7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM8PR06MB7361.eurprd06.prod.outlook.com (2603:10a6:20b:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 09:17:13 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 09:17:13 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Fri, 30 Jan 2026 09:17:02 +0000
Subject: [PATCH v5 4/4] iio: adc: ad9467: check for backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-91501
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769764629; l=4059;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=AyH6UAL5LifplHS2h9DVQ90bgQ7V3na5tfsJ0zfRtCY=;
 b=4x1sUVVVYPBfA/uuIfY9FHBCXKyby9svN4f1UKhT/cHJNXUYrb8eYC42kICb4XCJ87FPueHNZ
 t4FB3HH70w4B25l9I6S+YtLigWs+rhKPl05zM9BMXhmGO+DOCcI75Ik
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF000167F6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::667) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM8PR06MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea4f5a5-9827-41bb-01ff-08de5fe05a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RENFMXVkZDVFU0VESXpuQWNMTDk1TmpVdDByU3R2VGdFUXh1bWpFdWdiTVpU?=
 =?utf-8?B?L2F6TlltZlZ0V2RReEFRdnBlNEdiWHlHZ3lDQXpvdGt2a3RiMlJXSzRESUov?=
 =?utf-8?B?ZnFaSjdTVU8zMHY1SWZFaWo1WGhlSDhITmxjMUhVMVQ2eHBGWXlyV3RUdytz?=
 =?utf-8?B?MmJUdjI2T0h2VGFiRmx5U0hMSDNxV3ZqWU1lWmRZcWhUdi9ISmpZRmFEbmZT?=
 =?utf-8?B?ajlRcmF3N3loU1Yxei92OW5WSXdmM2J1cWpGNHhaNG5JTlpNcUtJUW8xS2tv?=
 =?utf-8?B?SnphL3kySHF5YXRiR1Q0WUdoWDE0ZHdhMEJZd3JyL2hSbW9wZTd0V280OUVv?=
 =?utf-8?B?NGhWR2FodVVPZzd6aEVXYnQxWkVudVdZZkMvYWh5Yk1GZ2c4S0h0Mm9DeVp5?=
 =?utf-8?B?ejVaU2xjdVJSUjNoNDVZM3Q5K3k4YnExcnIvVEFrNXVsT1lIdlhkbnBmejBE?=
 =?utf-8?B?M2lqSThINTFKNDB0dFpDQTc0TE15RUZ6cGtQdXpBL0JSRTUrYnoxZHFBU3gy?=
 =?utf-8?B?aEtYclZ3emQ1SWQvejd6VEloMjRaL2ZhWnFtb0o2U1JkV3NIMm91NGFlNlo3?=
 =?utf-8?B?WmlocWtOcHBUdFZsQjcwdjlNWVFWeUo2NmxQZlNnWC8weC91Z0h4anZKQklX?=
 =?utf-8?B?QTdGcnhnamNNcm1wem9kSEhpTnB4UXBpWFdoenE3T25uK2dLQnZoK3NQY21k?=
 =?utf-8?B?SFVXU1JSSzdFRVkzSFFlU21ETnhIclVCN1RucVRORnFrSWN2U21VdU1XQ0FY?=
 =?utf-8?B?dDc1MDJTNm91RDU1MTdDaFZ0eW1lTUI3QUhjK3VpcWRSMWhnYWNBbDh2OHFl?=
 =?utf-8?B?clNoMjZVSEdwVUtkeXZwbGROeGF0QmJFR0dpWDVxTE5tWGxUcXlrTFJCYS9q?=
 =?utf-8?B?N1B2Tm91bUFtMU8rcnJSMHdhVmRBek9BOEFyeVdOdE56TDNJcHMxMlZhZjdG?=
 =?utf-8?B?QVZGcENERVBjS3pib0R2dEpDNDFRZVJmcTBkQXpSWVFZeU5qZnBxK3cwTWla?=
 =?utf-8?B?SFJKWDMvakUxV1E5Y09abisyM3hEVWtjRTVHM1F0R200cGUvWldJZTh3cXJk?=
 =?utf-8?B?M0c5SEpJWWhYOTd6R0ZzK0JNVXVHMVdtQzNkRTM4SFF3OUxKUFlFNTd2OGtw?=
 =?utf-8?B?TXNTUGJmS3F6VlhqRXRYT2xBbGtvcWNEVlF5UVJ6QVRhc2dUTElTVEN2WVQ1?=
 =?utf-8?B?MG5PQUNoaUM2Rit1MkdOekFwWkZiamZTMG8wUlVGZGtxZHFDdWhHc3UwanFN?=
 =?utf-8?B?elZNNzcvM01xU012OEozQ0J3amdqSzdqWVQxMnErZDlUVlo4SW43bi9jeWZZ?=
 =?utf-8?B?N3Q1Z0pIRXFjMmxTTmM1Mlp4NUIwWlYxM0cvT1dBdFhnYTdNRkt6aUJLOSta?=
 =?utf-8?B?a2VxK3lrMDNpUzhRQ0dPdEM1Rjc4RXNrejQ2Q291YWNmTzlNZ09GUkFsMlhJ?=
 =?utf-8?B?VEtPY0NYR2JKME50TlI2OHhaRDNjZFh2Y29ENzhQUXZ3VytXaW9jOXBTVWVZ?=
 =?utf-8?B?azMzMTZqWFFCRGRScEFxWWFWSXJ2Yi9uUEFpek4vbEpvNXl4bGc5TWwrcDJm?=
 =?utf-8?B?SVphUjhYUUw5Yzd3MGtjMm56bGVScm02SERDdlJDU1FRZ1pXUGI1YnQ2U0d3?=
 =?utf-8?B?SHJqVTFib0FWdzJ3TThLSE44VGtES083M3pLQUZMR0NTQ0lFcFNFMHM5aTEv?=
 =?utf-8?B?TXMzcEZRcmdNZHovamVnaStWUFQwYTRXNGFGYy91ZFVzSHVOdU9GdS9tVlZs?=
 =?utf-8?B?UEZJSm11WFdtdUlSVUFYMkVVOUpKL0svK1NiQWZDNlMwR1lYUE9wSU90Mmh2?=
 =?utf-8?B?ZkhFRFo4SzBDQndBblJJS2xKbS81ZXJMNVpPemorTEJzaDQwMmpaV0hwU3Na?=
 =?utf-8?B?aXE5VmtYZCtLNlUzZzhRampvd2JBRU1nSWJKdXVNRmNCOTFuZzVMWHh6amdz?=
 =?utf-8?B?V3BFTWJNRXBFRVhXNThUcCtQK0NFUjN6UGkwamt6YjV4dWMyRDlyR3VTYUEy?=
 =?utf-8?B?MlVoWWtWVmxIMU9PWFFDOGxJT0dTbWVWSyt5bHg5eHdGQ3ZOdmk0Y0tyMkxT?=
 =?utf-8?B?RjZpaTZSd0lnUXpKU3d3VkJ2VEoxYzkxTUttejNOcTNaVC8rVG56TDM2MDF2?=
 =?utf-8?Q?c45E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZNNG1LWVg4R2VBbWtobkFlbm1KQWZXdTBRdnpKcml2a20zRloyRm1OK3Jh?=
 =?utf-8?B?K1VCUDdoYUNCSGRLUWlpRE9VbnVmOE5Cb0pNY2Z1MFB2RDhDcHJEeDU5SUps?=
 =?utf-8?B?WjVhaEZLemNWczhQVmZweEVHeXJkZDd4M1FJUUtKdXdQZTFqSTA2b3N5UEFo?=
 =?utf-8?B?b0hnQmdpYzRBbzF0eUFJY1M4TWFVK3NtSERIWXlEVUhjU2tmMXY0aDVoRnV4?=
 =?utf-8?B?cDZ5aGxXSTNtUXlxYVZFL3N6U2xJakx4cDgvSGZCWkRyMUY2RVpzWEFQZHFz?=
 =?utf-8?B?eVFpQk91S1pJQlNFUXZZVjJFQnNJUzNoOFpMSEQvYmtUWmJvaUJhRjdHOXpI?=
 =?utf-8?B?QVRpZGxSRmUrT0RmOHF5STZyYVhHSFBYN2lnYk1tejMzcXBUZnBpS25QRFh1?=
 =?utf-8?B?SmlFZEFGa1pTTjJsUWxIWGs0bHRlbWc2b0kvWTBBL3ZuMW41bnllaUpuOXFU?=
 =?utf-8?B?OCt1NDRyYUpwRnliU3FZSU52ZHpoSGhGajc5ZzdER1VRdm5HeEZ0NkN0SEZL?=
 =?utf-8?B?K3BpbW5CdHgxQ1hQL0UzOXphWnN5OUpCTnM0b2VqeXJvZ2xYNXlIUmQyYWZI?=
 =?utf-8?B?VUNSTks2eEJORHdYVDVjb3EwYUx1alJoOXNWUmFaU3Y1QlVFL3hTY2puUGR6?=
 =?utf-8?B?d0NiU0hjeURyZ0JzTllXc3BHT2ZkTWlRTmdLZ3VsWTEzMGkxT0tWN2Q1MXdx?=
 =?utf-8?B?YUlrcWpRT3U0MG10aHQ4eUFHenBJdlJIa2ZCUFFsUllMZlBCVWo4RUJNUjJu?=
 =?utf-8?B?dTJaOUovcEVPOXh5R0FmeWVsZTNBZzdXbUhydlIwRGNEVHlFRmVIOGVYZUpW?=
 =?utf-8?B?OUI0dHlRMUZxQjFOdEREcGZjU3V1Rm90UkFOTGwraWpGRGVwNWFXdFI5UkF1?=
 =?utf-8?B?STFTYldhRU9aSTF0cFJCVnRIS0tuanY5aUZWcEVUcXpKcDMyaVVwZHdmbWRa?=
 =?utf-8?B?R0JHQ0d1ZGpzblYyQWw0eXVuN3VkZTNYVDczVmxGOHVWbUpGRDR3NFJnV0g1?=
 =?utf-8?B?T1ZhWW1URGFicXlPVU1nTHRpTlNZWGhTZW90cHBucGV2Vk10RUhPOThyaS81?=
 =?utf-8?B?WHZnUG1kc2lSa0lydGpOOG5MQTRuTDVvVENZNEVDTklnaSs5UzdYYVZVT1Bl?=
 =?utf-8?B?WjROTGFqRzluS2dXUy82ejlodU1IcUxzbjdkemJ5VEhpaVI5ZU1FNkFiRUVB?=
 =?utf-8?B?NlFzOVRZSlErOTU2YzNTNzh1OWV3bXNVc1dET2p3NVZKY3ZjWHF4Z0RUTUU1?=
 =?utf-8?B?ZXZiV3VicmFJR2V2U1ZGU0FJZ2lPSWp0Y1RZZzFLZFlwcTVaNS95d3JZYW1C?=
 =?utf-8?B?VnVMdCtMRlJqakhnNDhRU1BHNEhVS0dZNUxMNlFIOTE1MC93dmJUWllEQis3?=
 =?utf-8?B?TjJsZklVaEF2aUIxSHNLMjlyNGlLMlNQNFN1YlBUdUFCdzF2c0dBZi84cnpx?=
 =?utf-8?B?UUp3Z1E0cmo2L0phZmZNRGZRN3NRbVNPOGsxUUF4R1dRZDF6N0s2SFN5Q0NB?=
 =?utf-8?B?SEpSTjVUSjdTT05aUjJhSjEySXhkazFXVElrN3dCNzhpUmJjUDZCUWFRYW0z?=
 =?utf-8?B?eHRnY1pXMHVoeHhyVnQvK1VzUlRPQkJiNmNpd25KOUhDdGJvUjRXU3VnMHJW?=
 =?utf-8?B?T2hhMEVIYXFBQWRwMnM1NjU1bWtjMlVxZmpnRGtySFVSQjJ2ZXNaS3VoY2RH?=
 =?utf-8?B?TDNUME12Tktha3l1dzlDMnoxZUtRZG04MnoyaGlqb2ZRUXl0OHd6MUYvWG5G?=
 =?utf-8?B?SzdGMTMveWNaaDlQZVhBcUp4REtweDNxWWsrd3VoM01lakJmOEVLa1pWVVda?=
 =?utf-8?B?UEg2dUxOTlFlTjVudFNpdStxbFN3bXVPUlk0V1hLYm5IL3lBSk0xNWdhcUJl?=
 =?utf-8?B?cnY5MWUrNkZJVkxQVFYrdzA0VGcrRGhFTmUxeWE2bExQeHpsYWFBclZNU0hZ?=
 =?utf-8?B?bDNyMGRHeXJac3Bpa2c1Q3NIL3VGaVB3c0xNRXJqTFpYdWZ4RHN6ZE9pMC81?=
 =?utf-8?B?c2hhYlp5K0dCcDhPWEl6QUpENHhXc2MxaC9ld08wVUpBcm8wRkZLcmozSUVK?=
 =?utf-8?B?WVROdVNkMkRSR2htRFNLT283aGZqYS9CN2NWY0FCdkd1QThCWi9hSkZ3K04z?=
 =?utf-8?B?Qm1Hd3NGejNmSHpZN1FpMzVyUGUyZkJURzRlaFYrci9NbXpyWUo5Q0UrcHo2?=
 =?utf-8?B?azVBUGtPQjdid0N1K2o3ZXJEbWoxZEdXMmtSMlFhMmNYbW5YTDZNT3Z6YjBr?=
 =?utf-8?B?T3pPclNUMHFsYmFxMEFPY205V2grY2VLYUdJOHJYQXhVUE1GQ0NWa1hIb2tR?=
 =?utf-8?B?YVFmNTdjUkFDT0J4cWtrYUV2bS9ZSzZFZ0pXaUJXaWptUjkxUHVDTUhVT0Nu?=
 =?utf-8?Q?oJ04iNlY61RZcXnA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea4f5a5-9827-41bb-01ff-08de5fe05a17
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 09:17:12.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KDugUmaMp5MtSPEroqDvpujd6mj2XCE9vn8CTJZkuUEOOt6jVptORYUBPEwrhtajcUA9MAnRQLA+LWil2lpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361

Add capability checks for operation with backends that do not necessarily
support full set of features, but are otherwise compatible with the device.
This ensures a fully functional device, but with limited capabilities.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 69 ++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 59c3fa3bcc9b..d768f7bf2a1c 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -913,7 +913,9 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
 		return ret;
 
 	guard(mutex)(&st->lock);
-	return ad9467_calibrate(st);
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		return ad9467_calibrate(st);
+	return 0;
 }
 
 static int ad9467_write_raw(struct iio_dev *indio_dev,
@@ -1119,12 +1121,15 @@ static ssize_t ad9467_chan_test_mode_read(struct file *file,
 		len = scnprintf(buf, sizeof(buf), "Running \"%s\" Test:\n\t",
 				ad9467_test_modes[chan->mode]);
 
-		ret = iio_backend_debugfs_print_chan_status(st->back, chan->idx,
-							    buf + len,
-							    sizeof(buf) - len);
-		if (ret < 0)
-			return ret;
-		len += ret;
+		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
+			ret = iio_backend_debugfs_print_chan_status(st->back,
+								    chan->idx,
+								    buf + len,
+								    sizeof(buf) - len);
+			if (ret < 0)
+				return ret;
+			len += ret;
+		}
 	} else if (chan->mode == AN877_ADC_TESTMODE_OFF) {
 		len = scnprintf(buf, sizeof(buf), "No test Running...\n");
 	} else {
@@ -1188,16 +1193,19 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
 			return ret;
 
 		/*  some patterns have a backend matching monitoring block */
-		if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
-			ret = ad9467_backend_testmode_on(st, chan->idx,
+		if (iio_backend_has_caps(st->back,
+					 IIO_BACKEND_CAP_CALIBRATION)) {
+			if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
+				ret = ad9467_backend_testmode_on(st, chan->idx,
 							 IIO_BACKEND_ADI_PRBS_9A);
-			if (ret)
-				return ret;
-		} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
-			ret = ad9467_backend_testmode_on(st, chan->idx,
+				if (ret)
+					return ret;
+			} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
+				ret = ad9467_backend_testmode_on(st, chan->idx,
 							 IIO_BACKEND_ADI_PRBS_23A);
-			if (ret)
-				return ret;
+				if (ret)
+					return ret;
+			}
 		}
 	}
 
@@ -1263,8 +1271,10 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
 	if (!st->chan_test)
 		return;
 
-	debugfs_create_file("calibration_table_dump", 0400, d, st,
-			    &ad9467_calib_table_fops);
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
+		debugfs_create_file("calibration_table_dump", 0400, d, st,
+				    &ad9467_calib_table_fops);
+	}
 
 	for (chan = 0; chan < st->info->num_channels; chan++) {
 		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
@@ -1339,17 +1349,24 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
-	if (ret)
-		return ret;
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFERING)) {
+		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
+						      indio_dev);
+		if (ret)
+			return ret;
+	}
 
-	ret = devm_iio_backend_enable(&spi->dev, st->back);
-	if (ret)
-		return ret;
+	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_ALWAYS_ON)) {
+		ret = devm_iio_backend_enable(&spi->dev, st->back);
+		if (ret)
+			return ret;
+	}
 
-	ret = ad9467_calibrate(st);
-	if (ret)
-		return ret;
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
+		ret = ad9467_calibrate(st);
+		if (ret)
+			return ret;
+	}
 
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)

-- 
2.47.3

