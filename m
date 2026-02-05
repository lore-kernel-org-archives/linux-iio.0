Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023141.outbound.protection.outlook.com [40.107.159.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3073D349D;
	Thu,  5 Feb 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294273; cv=fail; b=makS4KQ9lyjrMGP1+tydWtPNEueO3YkcqHQghYm+6AZUf6eocBkx6DCL8ERrpUJq0onyz4j/0CohfSVAqO451C6Falm/Y77jQflFuQDXogq1yNSqUwnTpvJ0A1/rijOOBk25C/KnB/rqUdsvZN5+XOzAK+vXrApsBbU5z5a1JkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294273; c=relaxed/simple;
	bh=HE9TEMm/NLLlyR/JyRlCqGh1/o4Hep3/VlIHXDJhGCA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bpxd/JLipqxI6RFOothYZxghkLlCm14asTes++vwFClZhckhifcNsy2p7L8pX882z9m2Pj26VRqcTLruRW4wYrZGZ9CoESYp3fpldxral+yw5jxqxb4m+9djOqDKIufGfI+usNLi9GIURUnqxHmakWonCBGB1MszGlUxWc5CTTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=m+lV7bD2; arc=fail smtp.client-ip=40.107.159.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="m+lV7bD2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcD2FQ9bWEfWWsGKdDfSE71xAAdtOrgDszt36eslVYmBvehE9+EL6EI890e9DAJ8RUcqzhQNW0qC+3RCQZ8HuIJR26QD5epPQLVeGtcGvYAKNE6MnniLwyjqqbs95jf90ChNUM4crwsYcauKiS4PMvDON1S14nblBV4xTFTdldFmgzHUklNewAwcaq8NibAU5Zk/4hj7X5RmgGQT4Oatj/Is5xizGx7kiWND2n2vYIvyjiaki2Hg8siKF3gxaT13O2Lv2jqkrBxEVpQQ4oeo1JM/YLAevAeXzXZYCF8a0QtcdBZTCIto6enfCWSXtEOaS5NPnS/+CZRumdWOw9lVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5BDK+guMxuHrd0EH1uXl6BFw8tTsVTPA/CP7m+hvAE=;
 b=Yr27W2Czl56QVHvt03oHJh8qzMEd2XMwhIK8IQBei3cVUymA/LF7E+d9dw0HUJHAq2XQPW2CU2ulBvshT2Nw7Gc4/OocZ919cxoAVt2IrIeeZ8BmeZvAucv3LvA5n0+3zrOPeACsIBSvQyMrGCJA+SWtw1W9ndmc1eNJ3d0R07ASEcw7uOeD4xqcLsR0rEJ237nVKikAef1YCZyOd5NGPnoaz+udfJXSsfUoimBX3ebS7h/A4tTybF6HsSpue5BMr1/nZBGnZ/fJWXEUsK6ZKseoHAorV8SC/IlieLRICwJH9P9KwV65RI9xheltv+bWg5BhcNjE4rtYcDIfTQkBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5BDK+guMxuHrd0EH1uXl6BFw8tTsVTPA/CP7m+hvAE=;
 b=m+lV7bD2AEpVOTL3vKfWrkOm2JY/sJQWPe2liue5iH9XZWtDBFQQKEYBAeVQGM3Dc16WH7DqtlBrr7YyCTuOzuwlWwunyK0QFC8MBYTWATwmxdRSgtHmDaxHUrPyivlocS6YRs7TnQxH53eYenrCEYFit62bGEQM1Fc1BdFDT/IKQIdupgRDcfBASNZe1joYNLdtOKK9SGTOYco6eaAotWkzGkrOKnDjFPTJh3fpw6GA7uHo9AfS8c65WZ+D8xKWuPM493/LckOvQPuav6FjvNs6BZhELHif2QU0badrwgBfAOa571uP9/VwDmIYAF0lb4C97Hm4SYr6E6Ql2hTZ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA1PR06MB9233.eurprd06.prod.outlook.com (2603:10a6:102:454::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 12:24:19 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:24:19 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Thu, 05 Feb 2026 12:24:11 +0000
Subject: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770294252; l=4036;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=HE9TEMm/NLLlyR/JyRlCqGh1/o4Hep3/VlIHXDJhGCA=;
 b=VdUpv+NGuJZGtideylyrajbHMMg3lmVsN2lNIbDGb7judynQsiRrmork/YmjJ7b/U9UrE4/yW
 jrY/+12YhZ+AxiA+tQZPAgEZD7FKOS+k1Js7hmeXRiw3HvZhbRA9Wxh
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF0001DBC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b2) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA1PR06MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaa04d6-9d0f-4a88-9f94-08de64b17ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnBnTUxLbzlzaENhSTNGVnJqbndhc1ZIRFNiNGRCdGphSUgzNVRlOFJsbm01?=
 =?utf-8?B?RktNcy9STTJLdG96d1pMWTQvbngrTEF3aWJCdEE0NG9XZTlzL2tEVHRVQ0lo?=
 =?utf-8?B?U1ZtZ2swZUlHT0FWZkM2UTJmUnNHaG0xUWRwYzVWbVBTa0ZUaFk3L0djaDRC?=
 =?utf-8?B?cnN0THVoWko3cUdyOHdWY2h3OEw0cnNuRXhPYnB5V1lybTZsUjdMTkJIeXdU?=
 =?utf-8?B?aDdBbmZiNFc5VWhkWHlHRGczOEYxWVN4LzVZVUpmNW5tOXgraXFwN0NqUHlZ?=
 =?utf-8?B?cXlYMTJTODFScEdLZWZNWmJ1bEUyQ1hpcmN3TEFPejF3WklWNmhWTFYwaVZE?=
 =?utf-8?B?M1R0dE13Sm1FZFdUVEdBUzQ3R2Irb1hSMEpQRnFWR2lTb0tuSFVZcGswMlht?=
 =?utf-8?B?My9PYlBNaGxIaVo1MkJwSHRaUnZKRjNCQkYzRTFqRDJUVHVDYThOYlQyV2Zz?=
 =?utf-8?B?RlhaMEdBUGJhdGlRQVB2R00rbWNOdUVKcjRkWVNlaEk3VVowdFYrL3lNc3FP?=
 =?utf-8?B?T0dZYitoYlhueWg5SGJEcnlyUy92eHgxQ1U2cWsxa04rdnV5UWJZY3ZIRnlK?=
 =?utf-8?B?ZE9RV2VQckdrSWpkVFZKU01ueWN6S3UzbzNMekw3enNpU1Q1VTlad09JbzRn?=
 =?utf-8?B?bHVuT002Z1U5MlBxb2JKYXZYOEVPTnhvNWNKOFluM1lLYndyOWFOeHZmUmJI?=
 =?utf-8?B?TTJkRWFwKzd1ZVBXUmo4K1kySmlSMnFYeVRwQURMTm00WlNsZ3NkZ3FMRkl6?=
 =?utf-8?B?eHR1dzRXdjVSTHMvTjVXZVRHWTc2TjIyd2JrbVBXRVErRjF0MjBEVGU3MnVz?=
 =?utf-8?B?cFR5MmE5M00zWFZKWnRoUVB5bkdMV2FFRVAzeXdpaWhIelE5cDFhZVdLVUJx?=
 =?utf-8?B?cFc0MEFvQmVhbWxCbFg4bCtBQ0NqNGFzM2xqZVNKYU9hSWp1TDJ6eFV4RHEw?=
 =?utf-8?B?M3BlRi9ocGhPM1pBUDBCRU9Dd0lkR1lyUndOYng5S3ZMa0hFZ2NQREdETENG?=
 =?utf-8?B?amJVc2F1SWJDSS9TSlVMY2Y4SHl0b3RtZ0pHZWtmbG1ZQVRoNTVGUStueUgz?=
 =?utf-8?B?UGhlaXNNaWlwY0g5ZEUyR0FvM0NTbE40My9odmhVMjMrVHR0Zi9XdjNKbkU0?=
 =?utf-8?B?d0RYckZISTJiL2QwZ0VxVzh4eTRZd0hYdmxoTjFsV2lDbFVoZDJOSW5xYnBp?=
 =?utf-8?B?MGpBVEcvMUhaOU1TeVhoei9vVUw1dUZ0cVVtWHkzVDVYM2luL3l3cDdrczdo?=
 =?utf-8?B?Uzh5V0Njdkc4QVBNa244YisvVHhLdnJYblpTYm1SY0oxNFd5UVNUTHA4alN2?=
 =?utf-8?B?UDViUzF4eWJHeWNYYVZTd3lXeVE5K2RYN3V1Wm5aZzk0YlNhMVUwTGR6bWg5?=
 =?utf-8?B?N3MzQVIyRCtiL004R3F2YlZ1bitXNEVud1lINnVvanFPVXozWGNvZkxZYjVv?=
 =?utf-8?B?ZTVRdnA0QWY0bEZ0L3NmSXIvelUzaUlFamFnNTdmNGdHR0xPa0FXazhVYktz?=
 =?utf-8?B?RHpueXg0S1RZN2xlUzdMSTlESjE3SEtZR2NhaGdmWGduSVVnRUJsK24weVRa?=
 =?utf-8?B?WjZZLzR1Sk5yTzFLekNmcFlzRjJxa3VIaS90K3lPQUFtL0p3ekNtYng3dVJJ?=
 =?utf-8?B?Tnd3bVZkdHcwZExYdHpnTXBMRFNyTFNUKzUxNG9PSTJTVWpQUVNhK0dYeVVj?=
 =?utf-8?B?eStCdDBWNkNXMHZDUVo0cWNSa0h6NnlkS01BWUZLYVkwbVY0bTNkNjEreVBw?=
 =?utf-8?B?ekVFYXd5aGxTa0RodHpSSGt3K1JUMDhueWdwYUpHcUVXTy9RNEszMVJoMll1?=
 =?utf-8?B?TzRPa2NaOEdIY1Y4L1NLckZNZmVOUjV3WHZQRWFKWmN1aTRKS0FMK1ZYbDdQ?=
 =?utf-8?B?QUpqTFBZbEJ0L3o2UStucitqRElXN05OOThCZkxLTHQ1blFwU0JjZi9BZVhK?=
 =?utf-8?B?Rk5TT0xiL0lQTE51ZThzY3RTYXhwVHI5L1F6VzkzRlkzWUZVcnliUm9lSGhN?=
 =?utf-8?B?MmVVcnpSNXUzODVpa1ZLOEQ3QVVZNVJKSS9IYkpZYTE5S0JZSExkL2paQlpD?=
 =?utf-8?B?ZW9uMnZnenIzdzhUclBqL2RRKzczYzJQckduaytCQld1Zld0cDFWN3ZkbEpD?=
 =?utf-8?Q?/KfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2pRZHlPWDVESEdVcjI0NHVabDVFejgzcE13VkxTTmRWYlczOENNOHBlMnRu?=
 =?utf-8?B?MHdSUzdaNU14ZHphQ05ON3RvSUJBNExVQTN4Q1NsUTZ4TDhubVliakExS0Nv?=
 =?utf-8?B?SjJCd3g3OUxTZWFZNmRlaTdMVU02T2tFS0JkUUtCTm8zMGI3bjNjUkNBZVRs?=
 =?utf-8?B?eUNBbDdnYkppaFlrVDBteWVNV1QxdVF6cHhoSEtGbXQrVXN6ZzhHb3ZHcmtL?=
 =?utf-8?B?azU3OFUxVTVpOHU3ZFFjbExweElqc2l1eE5Eam1VNkZ3eExIKzd3azFFT1VM?=
 =?utf-8?B?MVBkcEhnM3pKNkRqVXNxUk1NblJTN3ZpMTl4ZEhVeFVhV2JxVXpXd3V6MlRh?=
 =?utf-8?B?Tmt3OEJtYUJDMUJzYVRzUzgyNnZHUllqTSt0WjBmUUp1c2FwRUN4TFFsa2cy?=
 =?utf-8?B?MzJQL2c0bHNYcGprNzRwUXhPWC9Mcm12VWJoelhRQkZyU2krU0VvUmljdWc2?=
 =?utf-8?B?QVl5NjNJanBRejRvUjBZUnpLb2NIbjFReXByUTZhUmwwcDRDZ0ZISmdSRmVE?=
 =?utf-8?B?MWkwRFpmcjRlS09hRVlyUUY0c2ZXdFh2eVhKWUFzNU13TFlsTkMyWU9SU1RB?=
 =?utf-8?B?V2ZpUHAwbC9LaVh6WWh4SEpURTIvYzlmNjhaU1h5a3NBcTEwRzNlWk0rMHJZ?=
 =?utf-8?B?UE52ZTg1MXo3RzBPd1Y5azA1T1hiQ0NvcEJjVTExajRrMzBlZm5WWFF5Sm9k?=
 =?utf-8?B?RkVrUzFVMXFNMGNOTmJRMkM0OUlldDZHL1hrVnF1bEhWeVVCTldndnRQanF5?=
 =?utf-8?B?THNPYTJFR3dCMDdGenRqR3ZxZEk4cXJXaWpkcXNUZEprRDdqU2hIKzk0TjFT?=
 =?utf-8?B?eXRLT0hvSW03UllDcGhkK1dIWjg4bUVDU0VmVHVVT1BRNjlqTHF4YVc3UTFU?=
 =?utf-8?B?N1M3dUJicTl2bXp2a2ZSa1ZlWEdaOXJqL0tPcnR2SE16ZEJpb3poYXFpU0Uy?=
 =?utf-8?B?UEs0Tmt6UXQ0VDFDS3VmeHlmSCtUZFdVbVg2bGQwODczTlkwU1JHRGVWR3pU?=
 =?utf-8?B?YktlYjZ3V0VTVzZWYmpaMW1wdTRRQWw1c2xHZjhCRG5oeXNmZ3pKOWVZWTZz?=
 =?utf-8?B?RUtYbVRpbGdaY0s0L0I3YVJadnJJY0tCTHBCejBCY0Fpa2RUSmlENkJweFM2?=
 =?utf-8?B?SlFKN0NHNUgxNGZWOVVhRHJ0SGxGZGUwVldSMm5Ma2NhcmNoYTVKWi9UVVVD?=
 =?utf-8?B?aVR0V2RtR0FrendBSFV4QzdsNnVFYkNPZkhSS2MxYS9OVnphS3IvUUdHT2xR?=
 =?utf-8?B?SURGcURRVVplaTlkSFh2Z3EzblJPckhpVDVrSlA1K1ZKNVFqSytYTGxDRmtF?=
 =?utf-8?B?ZUVMcjUxYlV6T21GbWZ3bUFML3JIRkt2NG1YYXdkdHRlbG40RmlnNUloeXhy?=
 =?utf-8?B?M1FWdWFWc1ZUdk1JMHNVNndoQk5lVU5BYTZxaFZLR21SNjBKOTBxV3J5YS9M?=
 =?utf-8?B?RnZUSS9CYSsyNEw4QnFaSWZtSXlDZ0FGRm85Q1UwanN5Z2lvWm52UFhhYlFr?=
 =?utf-8?B?Q2JWQzJGTWlYK1JQWEw0d3lycHA3MnFocGt1aUZZWFJweWluN2NzcWphbzdC?=
 =?utf-8?B?QlhaMWtZdlVZWWx0WnJHWXJFbE9pemZKQzlEdUlZZ3o4U2lxRlUrUmpBNmlV?=
 =?utf-8?B?OVlIL0J2NFJsSHJmblRtMzlzcVovTVlCVWFJWFVza3N0TGV6UUFVRmhWTFdB?=
 =?utf-8?B?bTRYSXNIb0hvcHJlM0FHRnc0WThnNGd0VExNcXpGczMzaHJTUERZdHIzRjBI?=
 =?utf-8?B?dmVxa3NpaENQNW1hYkllTWFhMnRTRHU1VXdqSExaMkZqeFNKdk0rOTNHNEww?=
 =?utf-8?B?Y2dIN215RmdSaEVuVlpicGFVckYzaGhrLzNKa01PNnpsc3ZoMmtrdHpjSzNW?=
 =?utf-8?B?aVU5VmpoV2ZuZU1nckwvbWhDeTRyQVNnekUyMjlWc1VwQjlJM0RMRnBZazBV?=
 =?utf-8?B?K3oyR1Npd2VRWG1kdi9HSTRoRDhQRk93bWc2dTlIMGYwMXBzbVBmampSelBO?=
 =?utf-8?B?Q05KZWkxYlJtWTMydEpqWlovT2NFbkIwY1pEb1Y5TkpOMWx2RVZjaTRGRUNk?=
 =?utf-8?B?cHVHc2UzWFZsaFBnMm80ME4vOFQxRGN1NzZQQlNYZ0hsbW4yV0M5dnVCSGd3?=
 =?utf-8?B?aFBzUGZEczdnYnhGQ3BFcnN6MTYwU3o1eGVQaHoyZnp5VW1rdDF4UFBsUkt2?=
 =?utf-8?B?aUUzTkZBdEQ2bDk5Z2s2YnBGYk1vcFJ2TEx0bWhxWk9SQktXTTUrdXpGNkFO?=
 =?utf-8?B?NWJSV0JZQThUbHFHREQvK2pFL2dydlJuMjhyV20vUkdEY1h5Z3Z4cjhkWEh0?=
 =?utf-8?B?ZU1XUDJ3VkZpV08xbjlsRy9lNW9sVXR0MlZsbExxYS9kTUdSQnh2R0JtM2F4?=
 =?utf-8?Q?dTAPcs9wsFjTrLgo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaa04d6-9d0f-4a88-9f94-08de64b17ae7
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:24:16.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Huht2ZUbhAgrmvOGt48A4C/ZSovTZik9XN3N+A+YyEs+cWi6ZFYW2C422PyMY6MXX1/b1ZSCJcKPbzxc1RIm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9233

Add capability checks for operation with backends that do not necessarily
support full set of features, but are otherwise compatible with the device.
This ensures a fully functional device, but with limited capabilities.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 67 +++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 59c3fa3bcc9b..7a3db36121b0 100644
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
@@ -1188,16 +1193,18 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
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
 
@@ -1263,8 +1270,9 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
 	if (!st->chan_test)
 		return;
 
-	debugfs_create_file("calibration_table_dump", 0400, d, st,
-			    &ad9467_calib_table_fops);
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		debugfs_create_file("calibration_table_dump", 0400, d, st,
+				    &ad9467_calib_table_fops);
 
 	for (chan = 0; chan < st->info->num_channels; chan++) {
 		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
@@ -1339,17 +1347,24 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
-	if (ret)
-		return ret;
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
+		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
+						      indio_dev);
+		if (ret)
+			return ret;
+	}
 
-	ret = devm_iio_backend_enable(&spi->dev, st->back);
-	if (ret)
-		return ret;
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_ENABLE)) {
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

