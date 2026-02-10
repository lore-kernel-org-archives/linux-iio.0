Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021136.outbound.protection.outlook.com [52.101.65.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001935E52C;
	Tue, 10 Feb 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720860; cv=fail; b=QGKv9o690S1oi5vaIyzvNDcN48V2jtR5O+Yz3U112NvNOiyIhViZY6mie7bN5QQlFmqe83YV2JcRpeZvoQd6D8ryje6KjsGYOA/jdDU9iyCdzi+iA6XtNPVNYW807H6/7iLSDthM1noyt/IMpOm2AqweWzkEuaV//kEUlW49/q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720860; c=relaxed/simple;
	bh=/O3t1wsojbgmRdatPQkUQRgEVhDAqT5AIJl8pxoIbMw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gD2jX2MRBQTglXbhADyhHNM6i26x4ukaZXfF/ucqebKXV2KPpEe4aTTs8tvCnjlSHPVD63uLvBMO0eQ/Nl9xOkFXsuEkXk1kYXm9TcPxYIFVWHPzLZhsNCLx+WaksyEvwOm5vuZmwjK+vfOICIbbcDPMJA7hfz42bsmm4p96K9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=IVCiIwPS; arc=fail smtp.client-ip=52.101.65.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="IVCiIwPS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp7psghmfHAfUHBBVZYBn2hLuwZogZkAYccKFk9mDXKVfc1Iowis9o+asNc/r5BQfuVaexLfokaRBf9ZVQAA13g23bUdFnedrEAEaY9mkpQu81QAxkdvYWlDBjUqAAlerZo+hOZbUSUzMl15l2rpgBUOoxJlTDh+t6/i6jWXXYTyUmLyMySFgLrZjYCJpgaaUdM+KPgrWL5I0nrClECz74VIMp6mqyzOPJEXR3u5+5Z+G6K98pWiIo50i/1wk3HAkDexK3+FvCaknuUNH15x2oWf9mY8qZd8KVdFyb/5+2+E2xPK0594Yxdsov/8R3PwmXrSNpsEjfcN6nCSX2fY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BdlNWfZzqIvV9fDv5bxKb/SSclOGtXF+DI4pdnCGcQ=;
 b=qFaHGf7+KS+K4/2EfVazbwh9bR4JIeDdrlXtIcIAqBqObv1tgCa6A+m7j2nO84XjZL4h1wB88IN7EgJJiZXFSuxFa+pi2bNzowAOHYuSB1vHuWmvQd6+j1eT0jz4ua9BrikV4oFyN9srj9mLnSwpbt3QJ7djvt0L+2xCFL5xLhPTueJ4bDDbo5KFY5+2X+1hs+gedescSrfSOgiDrLx0q6YdCRu74UUlE0z27cNcus1qlL1f2A5QqSSaAYoTEi4swJAISRh/PPkDlnkHAdRA6NstN/mUoqcvMvk0PY8GFzOhQZEBHh76knbd9BWQUa/WEMWtPdZlRkQsOQYlyrX8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BdlNWfZzqIvV9fDv5bxKb/SSclOGtXF+DI4pdnCGcQ=;
 b=IVCiIwPSFCRd3An6lqpg2SLCYsQJOg9oMNNRR3D/4Vb3Fg5CTPWA6N7br8WillwesCZvQRVscQI/eUblOveADwBti1ZlIIOGGJukEbRLBLThavlZmAVT+JcLSYIiynJaJZQXPqWZ7Hj2Yn1RcOFJsw2g1WqCiCqZvTT8tNR/WiYagbGSzOyDWUDm1Ae3Ox//AhKTGB64ZS8p4s4OkK90g2wSyIY5ngnd33gQPnvewhb7KZpxwnwYnNpQbxhBdfA2dZijLNUnBx3JT3TrEpP2BURjk521NG/N7mFWf2EvRVQXJTUz7ipmx3cooWRLdZjM/ZcbR30cWIkq5tmQXCF9VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10) by DU4PR06MB10173.eurprd06.prod.outlook.com
 (2603:10a6:10:621::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 10:54:03 +0000
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee]) by VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:54:03 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 10 Feb 2026 10:53:39 +0000
Subject: [PATCH v7 6/6] iio: adc: ad9467: check for backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260210-b4-ad9467-optional-backend-v7-6-7a590ffe02df@vaisala.com>
References: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770720837; l=4781;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=/O3t1wsojbgmRdatPQkUQRgEVhDAqT5AIJl8pxoIbMw=;
 b=IJPghQAldSVHY1LXXOEEC4Rp1xXVYI5nKLyK5bwIGEEsIEjysgBwo4pWM48VLDWN+3lOSR0vV
 yIOG5Gfu2mzDMnqI20EcwoACsmoVptf668toiKpeeAupzuOEhjGw8Lu
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR06MB10639:EE_|DU4PR06MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: aa047968-5b80-41a6-bd3c-08de6892b434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWp0Vjg2anhFdE5RNHZPQlhPQTk0M3FxMEp2aGgzSE93RFEzc056Q2ZRUVVa?=
 =?utf-8?B?UVE4bGt3b3c5UHNlZWdDNGRMclZHeGF3Tk9mZnF0TjdYVHp1Zm51NllPQVZV?=
 =?utf-8?B?QkduY2FOb3B2cUw1cWhCcUZJM3Q1WVh3N3dadUl0UWJxaUdTaTQ2cklma3pw?=
 =?utf-8?B?REtUZGFxeXFMU1hFZklpYmdLT3N3cWhxcCtEU1BOSmdSOTFVRjRmdlFQRlZ1?=
 =?utf-8?B?c0s3MlZxNU9kNmliRWRYaFRiNXgrTThhOFdKRFFrM2czREMwc2dRTEttakhY?=
 =?utf-8?B?cjJHQjlYbnEyYXBqckl6cktpeHQyY0dWUWxYTHI2RmdLVVI5K0FNRThUSWF5?=
 =?utf-8?B?eFJpbnMxWkZFR2taSGs0ZjlXbnBLcEVxTzRaUVUzZDVLdW1hRGtsYWhzT1lC?=
 =?utf-8?B?akI3SmVGRnlXbEkvUTBlU2Voa00vMDVOYmpQQ0pENXY0OS9ZVUxvb1V0T1d5?=
 =?utf-8?B?UWJoN0Q1L09GeVFhaHJraUFSN0dwbmI4OVdFd0Y4dlA5QjEzVkxLSUJJN0Vx?=
 =?utf-8?B?SWdrVDg3bDZXWHEvc1ovRXIzOW5XTFNCeWVBMVVQVG1mb29NdUo1NnB4ckI1?=
 =?utf-8?B?RytOQ2RDYUxOREZrdnFxc1hXU1FlM0MwNzZGSHJzcVQ3RUNaeGVDNW8xWXhs?=
 =?utf-8?B?UWFVRjZiME1UenB5U1FnWmMza3NEOFE1MWVzVjh3Mk5nM0xEQU44cUcxQ2FF?=
 =?utf-8?B?cjB4VERTdjlQTlkvOTFNWUlqQ2NPWkx5TFg4NmgrYlQ4TnFKR09mUHA2NTQ3?=
 =?utf-8?B?TUJFN2JhQ3ZldS9RSnVQZ091Y2p2dTZ6ZURLMmNjL1VzYWM0cmVMdVJJaUI1?=
 =?utf-8?B?TW4yU28za0ZnbEU5M0pNYnFNUjdTZlhUN2RuM3hydUE0MDNsdktSeWJGQWNw?=
 =?utf-8?B?QW9ySEw5NTJHcFE1QVpQWEVyOWNxemRRaGhtRDBmNU04UXE0RmUvUlo1SG1l?=
 =?utf-8?B?ejA0czdtQWwvYUtTQnIydFNSTjB2WTM2MXpqZnYzQlRPT0RWSDRWc1BqUGYx?=
 =?utf-8?B?Z0JLUDZubURXdTk0RXd3WEo1QS9FVVZ0eFlpTDRnTnE5N3F5Z0Y0djB2NHNZ?=
 =?utf-8?B?aG12SG4vSXdyQmMwMnFacnlXcWo5MDhrNXpvYkJ5VzdKNVpVNkxXSkZOeUNu?=
 =?utf-8?B?SDE4S3hSazZHQVpNQ2lHZDI2bDNzZVFacGRNcHJkRVVISHlKdGNiRysyYUVT?=
 =?utf-8?B?K1FvQnJGY2F0MzliOFk2R1k5WmFSSThnc1BobjIxdTVSUnlrT0JKT0JidHBF?=
 =?utf-8?B?OGZ5VXhwSXhUckZaTDlIL0tGZWFnZGVGSDJPbTRKWEZrazZyRlRNZi9JcXhw?=
 =?utf-8?B?WmZjVWtVNmNoQ3ZvVGdzNFJJSHFldm5hanowVHFnMG02cU1SNTBPZkpMN0ZU?=
 =?utf-8?B?bWlyMVJKZER4b1VrTE9Ib3ZiQkdsWko2Q21TT0NSY0dYcEdteWlJSHpuQzVv?=
 =?utf-8?B?U3BXd0lWK1lQYXZvOTFROVhtWTZ5aDVmNEFNZmxMdUVScjlPaFQxSTlzVFhN?=
 =?utf-8?B?NUFiblZDY04yMm04YkxWZ2cxeVA2NkFWYUxBaHJGOEphdVF2NU1LcjFpSXdx?=
 =?utf-8?B?RFFJUEdJbGFZdy81L2RvTmsxZXMzV2V2ZjVVeTk3bGtob3QyRXJWMVhJWVRF?=
 =?utf-8?B?b2g5NGdFV2VJQWRPUVkrcDRXR21ZcDBKQk8vWHdDNDQ4aFZxR3YrVWxTTXBT?=
 =?utf-8?B?aHh5S0tUZEx5cXVBQTJHbHBhNlRqdXp1MlYrN0N2bXRzb1hGQU5nQ1o5WFlF?=
 =?utf-8?B?UnRtUW0yK2lXYUEvNmpQVVlzN1dtWXVyYnpwdGs4Yys3aUs0RW9meEVRa2JK?=
 =?utf-8?B?eTJvc0thYzVJRytUYWVKOGZIRDNNUGtvSGYyUlgzYzd0VjJWcDFjekpwOG1G?=
 =?utf-8?B?YWtCMWNWUFhYWC9kVVlQVVJXalZSVkFGZHZaeGRTTUdwTm4wcmVZL3NHOUFk?=
 =?utf-8?B?YjN4SklycUh2dllvSnh4eXZlWlFKaEJuODQrdXB5Z3U0aUtsM3NIcklGbDk0?=
 =?utf-8?B?bGtwMkNFRmhmZGJoelZ6S01ZQVBld0JKNk9Xa3d1aXM5TWt3TmgwVGh0ZnND?=
 =?utf-8?B?SVNaYlZMSFJKRlB6WGppTVdpQ0p0WTM3UlNhcXl6U2FoRHhucTBRUmZPcEpD?=
 =?utf-8?Q?bl9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJJdnNMWlkwSFRXOExLWVQxSGtycWRoRmJQUDhWd0NXMlZnTEVjeEVKSFFv?=
 =?utf-8?B?aDViMktERTZPUFljcGlqdzJMNG1aNGtwZ0MwTkFvR25JUUVxdGJEeStuVWJ4?=
 =?utf-8?B?enRaZUZMMURRSXBTMEdFS3JHYTVHb3dqa2lvK1B6TGZTQ2tZdFM3aTQvOVdV?=
 =?utf-8?B?a2FpTkE5V05BclhNUWpWNXFVanVTZWFMdXAyYVF0bzZ6T1lycnhhR1Jhbm5z?=
 =?utf-8?B?STk0akpjYkE0S2FqeEJjNENOeGhUc1JyQVE4NmwvYlB3dW5MTFFhcVpObzlW?=
 =?utf-8?B?TWtRYjhQLzNTVnlOcVNRYnVSWUVqMldDTUNKL0dIS0ZNVU50RTE1eHh5NU5n?=
 =?utf-8?B?UW11YVdkUHh5c0U2VUxQdld6VzBPOWk0VThCY1dpdVRnVmtkNDJaRHZSenFo?=
 =?utf-8?B?aUNUc3BPZU5USlRnMm9Sc1gzRVJjeDc2ZzZuWEZEWFBUNFUweVl1dXN1eEly?=
 =?utf-8?B?UjJJenBza29rbzUxSHZNcGxNTVVBajRSR2NGSXR3VFMrdFFEV2hLR2dqd1A1?=
 =?utf-8?B?Y1FwazhtNGpYUDhUR2IwVm52ZUVuNUVPSmZmSFZ5QVFvUWNNUlg2MHhMOVVt?=
 =?utf-8?B?SncwK2xNMTY2NzFCeTFvV1JWK3VhUGZyOXAxS3ZVd1VYZFE4UnhBT0czNGpU?=
 =?utf-8?B?UGdLRmQxUWVZZXhiZzA5NUZ0UXd3REM3U2JzVExCTXBCbXJOUTQzSE9TdGpu?=
 =?utf-8?B?SERyK3owcGNwdXY5dDhBZENKckx3S2RjVmpoMUFpUnRZREVOUlVLRkNLYnFt?=
 =?utf-8?B?cHNXOGdCM0txcHlpQXhBVU1pVGNCRlVDVlhJUXpFRmpnR3V0VGZEOUlLY29a?=
 =?utf-8?B?V1EwWDFXNFJBcmVwODRlUXRuZzFQK2pOMi82S005YjlLMmZhM0Q3a1V4ay9R?=
 =?utf-8?B?QjdOd0xpdmZpengvZExmNk9WU0Jaa2ZubC8xckx4aW9GTk5kM283UXdXbWxH?=
 =?utf-8?B?ZlV1V1ZWT3NKZ29MbEpweGh3QVFGd1RFTkhCcktJWTdyakNreHpNK3RGd3R5?=
 =?utf-8?B?RitrdUVOMlAwZG45QUNrdEVuU1NFSk9QTEREazBQcGk1bXA2N3l4b1I4clZ6?=
 =?utf-8?B?dDY3UVZ5SVYybmdvcU15UTI4eWJ0eWM5ZHlTYlNYeW9wcjlQVmtoVVFyNXRa?=
 =?utf-8?B?cDFwNWZlMS9WZlo5cDBhQzZkZHN0WXo1b3FFZDFjNU5YSlBoSXErNjFrM2c2?=
 =?utf-8?B?RzcwNjk4Q0s1bHVJb0dYbXBhdjRYQjBLTVB1bHIvMVNuUjVXeTJQd0dYVG5q?=
 =?utf-8?B?NGF5SXpwTmhjcE5WUWFYOXZsRkNoRld3aTNHUG9TaTYyMlppaEx5czZNVXFC?=
 =?utf-8?B?aUw4V0NnTXJVRk9RZTBtN2Q5bWlqVnRPY3ZpZ1dQNlNsbEplZFJFTVVKbXdG?=
 =?utf-8?B?N2Z6M1RHZFM4alVQRjU3dkgvQXA2L1ZHSUdKN1ZhL3dqNXlReEl5d2VNM09B?=
 =?utf-8?B?NCt2Snh5ZytMUHBaeDZwOE9ycVFoL3hmSW9pWTREa25heldHcjlzaGFXWnRV?=
 =?utf-8?B?RjRlT1RXMXdtelJYR212UnVtSjJqSlFLM1NmOGhiSlpUUXNnMklQeCszZEph?=
 =?utf-8?B?QmhTcVpTWjdMQWpoendIR0NoZkNNN0x0UDlRTTdKNDk5aVQ5R3RNcEVKM1dx?=
 =?utf-8?B?Qm5pRU5Sb0tFRWtzS292RXdRS1dhT1BYMEhmcTl3eTBCcGs1S2xSanBWM1dW?=
 =?utf-8?B?RVdzajM3a0ZYZiszUkJOazA3M29CenpUODR0ekhQditnbEpWWmRiTi82VE51?=
 =?utf-8?B?QUpyQ2xZUTh5T3g0dTRsRkZVTlRvU3JBVC9qTHFPUm9uZE93bVpvYTVJQ2pw?=
 =?utf-8?B?dSt3KzU3eXdheWp0UzFORy82ZDJTN0U1bDgybVZ6K0FaczY0MDdObWFFQUlV?=
 =?utf-8?B?YkdMWUl6VDlhQlpWeTNoaDFwNFNvTFpWT3JuNXlFaE1uR25ENGxsU2g0Vmpp?=
 =?utf-8?B?V1FFSVl3R1U5VW1MNGVPQTJhUmw2c0ZzUDVaMFJxb2JRN1pjeGs2M3pnbS9O?=
 =?utf-8?B?RmJ2c1NIM3crSTNNNkhwMkpWSzY5OG1Mc2g1VGo3WWp5V2hEbDR3MzNuTEpr?=
 =?utf-8?B?YWRpUk9rSzNlRnZlUEs2bGpRWnRTTzVYQWF6RHp1UXVZZ24rdTl5Ly81Wi9y?=
 =?utf-8?B?WGxZWU1wR0ZSZFhtN08xT0ZIZk5hdEtUYjIzc2gzWHdZbWgvd0JHeWNlRE96?=
 =?utf-8?B?bVVsR1dJYWgvcTRhcm5BRmJFeHhyVmxKNjBWV0ZJZkhEZlB0MVRkQW5Zc1hq?=
 =?utf-8?B?dXpYcGQvSm1mTklEYTR6SytCTUdHNjBzMXp6ZEcrWkRtREtvVzVWWUpMS1Fz?=
 =?utf-8?B?enA5c0FjV2dndWk0bmJhcnRTZmxnZVRFMncxQ1kzTlkzaGRKR1huakhWNUNo?=
 =?utf-8?Q?iBB01Vjg0sHzmptw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa047968-5b80-41a6-bd3c-08de6892b434
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:54:03.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbHABcowlVttSORZApZ64u7o78LU6Zg8nRtTOfRFnlbtFX2mCweTTJFyAdc/4A833EjVwkK1+U8FeOjtuL5Srw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10173

Add capability checks for operation with backends that do not necessarily
support full set of features, but are otherwise compatible with the device.
This ensures a fully functional device, but with limited capabilities.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 80 +++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index ae9139290c22..fbdacdc2c823 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -913,7 +913,11 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
 		return ret;
 
 	guard(mutex)(&st->lock);
-	return ad9467_calibrate(st);
+
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		return ad9467_calibrate(st);
+
+	return 0;
 }
 
 static int ad9467_write_raw(struct iio_dev *indio_dev,
@@ -1119,12 +1123,15 @@ static ssize_t ad9467_chan_test_mode_read(struct file *file,
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
@@ -1163,11 +1170,13 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
 	if (mode == AN877_ADC_TESTMODE_OFF) {
 		unsigned int out_mode;
 
-		if (chan->mode == AN877_ADC_TESTMODE_PN9_SEQ ||
-		    chan->mode == AN877_ADC_TESTMODE_PN23_SEQ) {
-			ret = ad9467_backend_testmode_off(st, chan->idx);
-			if (ret)
-				return ret;
+		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
+			if (chan->mode == AN877_ADC_TESTMODE_PN9_SEQ ||
+			    chan->mode == AN877_ADC_TESTMODE_PN23_SEQ) {
+				ret = ad9467_backend_testmode_off(st, chan->idx);
+				if (ret)
+					return ret;
+			}
 		}
 
 		ret = ad9467_testmode_set(st, chan->idx, mode);
@@ -1188,16 +1197,18 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
 			return ret;
 
 		/*  some patterns have a backend matching monitoring block */
-		if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
-			ret = ad9467_backend_testmode_on(st, chan->idx,
+		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
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
 
@@ -1263,8 +1274,9 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
 	if (!st->chan_test)
 		return;
 
-	debugfs_create_file("calibration_table_dump", 0400, d, st,
-			    &ad9467_calib_table_fops);
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		debugfs_create_file("calibration_table_dump", 0400, d, st,
+				    &ad9467_calib_table_fops);
 
 	for (chan = 0; chan < st->info->num_channels; chan++) {
 		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
@@ -1340,17 +1352,23 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
-	if (ret)
-		return ret;
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
+		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+		if (ret)
+			return ret;
+	}
 
-	ret = devm_iio_backend_enable(dev, st->back);
-	if (ret)
-		return ret;
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_ENABLE)) {
+		ret = devm_iio_backend_enable(dev, st->back);
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
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)

-- 
2.47.3

