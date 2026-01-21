Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023100.outbound.protection.outlook.com [52.101.83.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1D314B76;
	Wed, 21 Jan 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997343; cv=fail; b=HflwpdF9Ycex6P9DVC1t3/XICMELfq75rvDthi3HdEryC1C2mCQxRc2RbbkPOJeAmqI2Xc2FC8esivUlnPyI1+E9QRoFuzfLcN6JqqcildzCY5gbMIwj66i/17sLg4bT6x5qZLOV4L+znNaHW1mRuGRmRDDMz5Bl7YAItEMBW4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997343; c=relaxed/simple;
	bh=ZJz/SKx403TgIgvAmVYbh4WiE9BREhZDm+AKXKTWSH4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZJByDwdoBzKwGMk8M9mXJOkSDDAPKKRtzupjEH0PFMfmL2bJIS+X4lEYDF7PVliBo+gJdvFJAb/2eQyF9EDypUSDMDpcJVi39U+vWFcfF/JbnbT8m51w3fJ/QdtJengcGUy2T6l5YfTaOpredPNNobGMYzTW2bSWGjJac54cFv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=hL7Ycyvo; arc=fail smtp.client-ip=52.101.83.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="hL7Ycyvo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra5jHsJ99RuBubk3XUoWCwjofRPjcR+fhkuH9oWIIkVVMZkRmDNDf9lJnlkqIQZPQIdsavWgMUjG6r2Ra9rXasMh2YA5YgGtiZcNh9PI1S1d12Yfvfd+/D5r+UY8S/OFUag6Pw4pDRxY3d1itnEGPuOBfh27lKGwKVNTDTeoYlYEM84Z5/ZYPJp0aGJJ+VSM/TnnBVGG8DW3TJorbn6rzEPGuHe5x5pXh7JNRDuoVmOXcscsD9Eo9PY7NPv8G5nblwOhJlbe9rCA6E2UeiUIygPmQFEUeRRyuxJGjeYlo04F8cx/lDpv/FZzRAMXZnnQWLsER9JUUNRZoiC16Ao72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYPDb4mSA4GuAORrYfrS6pcCv1e/syPtWMfx9XLR+84=;
 b=Mht8utHnAOoOZI9fWCPGYde30lVO3GcKsUI769GTdE8MTTMhxeCobhGj5YVAhAwqg29O5pZV1KEd3JsvfWWH0wsqPubABijE8Tss7z7n1GQlZ2fKbFD8VKuF/OS3i+eOoTpbv95eGCrQa1dNDhWWbOEWbk0ovc5cigE8RX6pF+YBmhH4FhGvphSmZaYnoiOdqrTRb1VI5JWeIRCi6SSS80saze6fCem/ngM9d3pf/qh1v0dvWONuRG3/okolvziwqCu614fhDhDvTeUoU0edow6cQt7roU4AGhIlwxyqeOHww3gP+06LgP4QLjQ+u5HVJP5lTLOjdPQDRPgpBoXLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYPDb4mSA4GuAORrYfrS6pcCv1e/syPtWMfx9XLR+84=;
 b=hL7Ycyvo1HkAYYZdVxmvyP4e/kxsdBdxHvmgKa+J5XpP3kKEFD2cWw6myDfSt25i09oyTP8+ljUtHqNqILMSs42w5BEgwdnQB169PViPc2KXlZ7bjUafAFcqJJ5bOG+H9oduJ0sWQW+rvrP69C2la6ClB75tnueqxdiKuSc/kFRKQXjKRJaOovWwatL+1DVgoJ35PbjhvzehvPd1FyTDVN/X5GBEj8HBysvY8HU+4/gEvxB3nYidh4sGkHqixhhrO5toRqjEPGmpLFhf/6jxj71md2RAR5f3mGjc4zKPqC2bdR5rI7rxFFJO1P1EVP4WKuH3y0kKLt7MY43gVgNi1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA4PR06MB8425.eurprd06.prod.outlook.com (2603:10a6:102:2a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 12:08:52 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:08:52 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 21 Jan 2026 12:08:33 +0000
Subject: [PATCH v4 4/4] iio: adc: ad9467: check for backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-ad9467-optional-backend-v4-4-18d2c0d450cc@vaisala.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768997329; l=4164;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=ZJz/SKx403TgIgvAmVYbh4WiE9BREhZDm+AKXKTWSH4=;
 b=tB5dyHArX7wqA/pH09wmiBu7T0yZgKLohzLQ9QpgwgLAdzQWVdajvjcM8gwax0kBs8jK2EsXA
 UigUm/AUFZQCsGIXX3y9mMu9+tGOvJ6L1fzSvYN99hg92J2J5O3q2aW
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E69.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::37) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA4PR06MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: b48da225-6129-41af-f482-08de58e5d7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9nYlFhYkJCTk9PMXlnZTFpTUZ1dXdId3VLRTVuMHZjek1EVmY4dUtlSzN1?=
 =?utf-8?B?S1FodVNuWVcxOG5UNGljVFQ5Y2tQWWxxTVREdkwrRE1YdCthcFVRMmZsOWZQ?=
 =?utf-8?B?VkMwM3A0cm9VYWZJTjhtdGR6Z0IvOXQzQzFHU0Y2TkZsQ2V5UFRISVhqSFlu?=
 =?utf-8?B?TFh3dHBpV3Q1dWhSY3RMRTYwdUZsQnd0S3hMa1BxKy9EZGtvNjFPQlNaYTlw?=
 =?utf-8?B?UExyY3kwYU9QWVdLYU9td1ZoSzVQSldqTVg5QVc1RkZBM1Q1dHRWYVBSTXhN?=
 =?utf-8?B?MjVpSWxBckdyYjgrMW8ycm11NFhocFVJcFBuN09seTM3Y1NuK2gwaGN6QXh4?=
 =?utf-8?B?SVVrbHVaYzQzQWgrS01vZ3JQVlFwak9tS2t1bmdwMisrb09Fcm9mS3VIWEsy?=
 =?utf-8?B?NVUzeGR6bHprQi94Mis2bkJpcnYwWXl6eTg2aW43NGhCdEY0UGFiWGZGTmls?=
 =?utf-8?B?aUV5djZXNlY3TmFWdWRsOGxvZ3dqMndKazVBOUErb1IyV3RnLzdJaTdvbDVB?=
 =?utf-8?B?NGFVWDZ0dkE3MnpqMzN5Uks0OWZJTTJBdytpTlBBWVZZeGsySU9PMzdZd3Bk?=
 =?utf-8?B?eGEra0lnU2hKYVdkTnNac2U4VGRwVnM0T3hkS1ZmalBvTkZvcHVjbklDcDhE?=
 =?utf-8?B?aHlyVGRnQmZZVnM2Wlc1L2ZuQTgrNGlMTlNSRHRHWTNJVDBjQjN3QXRkeXBl?=
 =?utf-8?B?bm1QblVVc2RBNnlBZGFqOUsxb28zS3h2OTBEQlNhM0JSdnA5elBpWkFSUlJm?=
 =?utf-8?B?dFJadFF6elBzYnoycS9Hd29yNUJoREJvb0EyU2dqbnF2T1BEclJsVXZTaVBJ?=
 =?utf-8?B?SmR5QjVmdHd5SGd5U1BRdi9rR0Q0bHpTcXJuT2JEY1Zzc241V0p0b3kzdDFE?=
 =?utf-8?B?cWE1UWFNVE9ycnk1WTFMM3l5b213a3lDK2dTV09qd1dEd2hHQTgyZ25GQ3pm?=
 =?utf-8?B?Tm9WOWZZajVONkZZeUJ2dzhHdmFMUk1YNFpLcWJRRlRQVjZ5S2JvZDYyRUp1?=
 =?utf-8?B?RlV2b01FUW5rR3o1UnMxaTNhSmVkenA0Y04wOTZaSU1NNmRpTmU4cUs1U1VV?=
 =?utf-8?B?Zk1ualF3aU5hdGdzN1ZEUkhJUXBKNVhFV3BXVXRueFFyS3pUdXVFbk1rZHhE?=
 =?utf-8?B?Y05JTm5ETVpoZFVhdXFkSkR6THAvQ2lxTVNkeXF4ZURKZVF2Tk9EWmU1L1lQ?=
 =?utf-8?B?YkdUQlVoTlU3SzhqLzZOVjFaTHNnOGJNbjFNdFdpakZraXZPY2oxTStybXk1?=
 =?utf-8?B?NWM2ZVpjWnFpVCtUSGtUTVhVQlRCdWZqeU5wQWFBS3pZb2kwOW5PcVVKSE5a?=
 =?utf-8?B?UHVvY24rblJVQmQ0aWNQV1hBcTE5OFZJR1VkeFcrSXVFaXV4cmZ5MzRpY2lW?=
 =?utf-8?B?RHFYWGRjTDlTeHM4SVZuNWRxSFVqL1BmNXBwakMzeWpMdzdMclhObXZLcTBl?=
 =?utf-8?B?T2p5cjNONUpHRGVBSkd0TjZPeHlGU1dXRkFMbHFHdk1obk9rSjFoRFFmUGdR?=
 =?utf-8?B?Q25DbGFaZkFDN0xoazYrNWFuay9yVHh3TzVydTlLczB3cGVRdzc1UkZQdTNw?=
 =?utf-8?B?YzlNVEkyUm5SRFhJK2JkdmgvWSsvRG9zemZLWHNCOVpFYTZYa3dPVmJwT2hj?=
 =?utf-8?B?VDFxUW9hRTQxVk1BNFE0cmFKRUN2b0Y2TkJSOFFNNFl0OUV1RllrRVV4ZDBK?=
 =?utf-8?B?dEZKOTZ2TmhNWW8rTWZQanRvcnRJWVVSZzUrRHFHSVlSSHlxSjUxSWZMTzky?=
 =?utf-8?B?RXRzelEyKzJ4V2hZL05XeFhDdFB4Mm5hVDFjckwwV004dWNUbEU5ZVFhenVS?=
 =?utf-8?B?Y3dGQStzbm03Q1ZXNEFVck9YTzRzb1NGZnJiUVdQNm9IVWR5eDU0ZHZYYjh2?=
 =?utf-8?B?OHIyL1FuNklzQlBZbHAzejQ3SVpwMTZmbjFNVktqUTZlVEZIV1ltM3EvVUVU?=
 =?utf-8?B?VHZGWjlYWllRNUI1Nm1SQ25QTDFOWHZzQ0ZMendDckJkU3c5NGZJanhzSE5V?=
 =?utf-8?B?U2NOemZQSk1PdkFrb285V21YOS9IajRhZnc2WUxyMGsvcGgxOTRwclVoZTdR?=
 =?utf-8?B?emh2aXFoZStEZnJuLzZmenJNYXNpeTBTYVNYclR1Q2NKOUhXb1NuSmJiSnpI?=
 =?utf-8?B?YnVheTZUVnp4cVZvdnFDWXZIUUppZUI1d2ZWaEgwUFlmMDQ2ajgvRTQyY0tn?=
 =?utf-8?Q?ujdyw+YuAyfCdkfgyrAUsPk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHhUUUUxeXA3RHgzTmJINXZOS1V3U3VJVmJNbTUyOTQzLzE0djAzTGVuSVNk?=
 =?utf-8?B?MmQxYlBES2xSVkY0REhHc29ETWs5YkkzMjhqQkZBZnJMV05wckVYZUV3THk3?=
 =?utf-8?B?RWpWbXY1NlJVK0N3bStkV3JGNSsrdHNWVEp0ck5EbWFNK0tuSCtnRUcwZG4z?=
 =?utf-8?B?VFdwNTFlTThuL0RDelBmcUNobE5DM1UwOVdwY3JRQUdiT3FUK0d3Q3hwaEdr?=
 =?utf-8?B?N3RrUmd5YlRQZHlhRWZzNDNRWlltRFhlQ090K3FoUmpseFNPWjd2NzNVLzBm?=
 =?utf-8?B?bzIvbjVFd0VWNlZoUnlSYVlvMGsxdnIxNEFnTE13enJWcFpORFh5ZWFhSmdn?=
 =?utf-8?B?SjJJRjkvV3k4OE5uMUhaMjN5anZuVUhyVHVMdURPY0lDRUNEVHpBb2VmVUtw?=
 =?utf-8?B?bVFOSUYxeUVaRnliUkx1dE8zNnFIbjdqcEthQ0ZmSGx1K05FZzdTQlVvR29Z?=
 =?utf-8?B?b0lzYnY5K0IvaWo5R2J1dENFS0RGS3pzSjFvckphRG5yeVNtYm95Wjdpc1Nv?=
 =?utf-8?B?U0p0UWhDQ01tcWtmd01zVDI5YldmVTdoRzNZZHB3YURsejZGc1NmT1hwcy95?=
 =?utf-8?B?NzVLUzBoYWZOTklQcUNkVllyTHlaWWU5S3AvZytoSWYvVDZGaHo2ZlVyQUp4?=
 =?utf-8?B?U2YydG5lMUdURjUzYUNrdWRLTUdka1hBVVJWZlVRUkxpVGdEUVIwQTNMSWsv?=
 =?utf-8?B?aTBWZTBhaUlIL2twTFNuK2h2eFN5STFYV05ZYXAwbjk5MENpZjdoa2pVUTB0?=
 =?utf-8?B?N2NHWlU3WlRmQ3hpclRQWUxlZWljam8zOS9KSk80TFVWVUt4TXVMUWZMM25j?=
 =?utf-8?B?b2VJbEJmU2J4aC9ORHBTSFdJdlVDT0MvSjJLcUlTR2NSL2ZMallwRTRia2hL?=
 =?utf-8?B?Vm13ZWN5bllNcWF6bldrOW80OG4vNUlrMFVsRFdzY2EwVEVEb3pwcGwrc0F3?=
 =?utf-8?B?WjFIYXBFN0dqQTJvamxGOHhCeXRvVUhrdFZPQXE1NU9yZm0xUERtdXBqeXlY?=
 =?utf-8?B?dCtzYmdFM28vQzFhUHQ3OEV6V2k0YjFIbHhUUC94UktQRVdWTU1BM2pFbnRp?=
 =?utf-8?B?UlpFOElQMTh4WjRVSHlmMnFlRHI2VFE1QlNBZjhHNTRSdjdjeHZHanJZNkQ3?=
 =?utf-8?B?TE43Mm90K2czZFJudGVhVDlNWXZXSnE0SjRsd01EaGhwVElhWElQTEdiYWh5?=
 =?utf-8?B?bUdNaHQxQTBRUkdPRGlXRTk0RmJvenMxaHlGNGFGSEdxaElPTUlWVFJGa2FN?=
 =?utf-8?B?bmY3dnFuNFRycnJ5bmxCL0dudldmNjE0dHR3czBxNEs2c0x3UzRvYnM4YTZw?=
 =?utf-8?B?MVBGaGJyeldUaGt3RGJ5eWZDUkRkbko3b0phcUtKZXBlRllpL2FHOXRjNFFt?=
 =?utf-8?B?b3B3U3JGejBqRFFxcTU3NUpRZjU1R1RwZzRMaHBFUUdlejB3K2xaL2k2aUhN?=
 =?utf-8?B?UmRNS0NsL1lLTmx4bXlhN1VjQmNDUEpvN1U3UlNFc0dLNHlIVnhUZnVrbzFU?=
 =?utf-8?B?NFUvcGdycS9Kd2NneUl0VHdRT2ZtMHVWbDJVRmxqWkxpUGdFV0V0U0c5bzcz?=
 =?utf-8?B?SWVWOEoyMEt6SzBnc2NrMUkrTkJPdGh0UFhZcUNMVFNWeGNaaC9adTFIZWFF?=
 =?utf-8?B?a0V2akdTN0sweXJOWTAxTGhNMWFBemQwVlRWdW1xYU94d0dOWHhUbEh3RGR3?=
 =?utf-8?B?bHJsclh0YjN6SXVpckQzSlExS01FWmU3b3M1NVAyd3d6RHNFVnpuOVFzREJQ?=
 =?utf-8?B?NHAvMlc3QVNFYW1RRGN4VDU4RENGMzV3dlZEVG1PNFdRcnN6R0dLU1lucDM0?=
 =?utf-8?B?QVc0MEg5QmJSR2xRM2svSTVFL0Q1OFowd3Jub3RPY3dGTWpMdHplN0h6QUgz?=
 =?utf-8?B?ZFZ2cFVhR2h0cnM1SjNjTEZZVWlZdTBpVDNKcnBNQ0dxODlHQnRLVmtPejF2?=
 =?utf-8?B?dERiY3RhZUFxMVFibzFLdVQ3TDF5TTV3QmJsZERtWVNHOHFDTDd5WUpYSVJD?=
 =?utf-8?B?ZnR0SGd3Z3lISW5DUFpMMVcyN1Q4OWsrVkQ0cXFBM2lxVDNud2xlZTdKZ0FZ?=
 =?utf-8?B?TVFYQmNlbU95M2x5SXpXZWw3OG9mN0dnNTBnenBubmhLcmN0MW5pZ3ZndENu?=
 =?utf-8?B?dDA2RUxvNjhWOHlDRFRsZ0J6aTA5VFEwdldHUGoxM0YvWmk2UWIxNFoxaDVC?=
 =?utf-8?B?RFhMNWJOMXZ6djZlVlMxL1NER1VwNXRsbWNPRDdrS0tDOTZwNXk0NGVxUEdz?=
 =?utf-8?B?RGJCaU4yOXBuR3JTWXV2QkdzK0VkQk1BYUhMSjhvMVVRWVNCSkZRNlR6VDZ5?=
 =?utf-8?B?UldWbUo5OUNQcnBuY1RHd3FLQWdDYnlLODZWT053WmwyaG84Wk1yYUhENXZh?=
 =?utf-8?Q?+yR8hOgJV+p7e9mA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48da225-6129-41af-f482-08de58e5d7ca
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:08:52.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAiQjrn/z03xkC+Cug/ultiiiFJlADAnLsbuO0HN78EMtvDoFIrh8QNmBSjlyXkjUMQDr2gs5OQzIFlD4ZcPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB8425

Add capability checks for operation with backends that do not necessarily
support full set of features, but are otherwise compatible with the device.
This ensures a fully functional device, but with limited capabilities.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 72 ++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 59c3fa3bcc9b0b8b36b78c3b54fd7977cae23496..eb57f72211430fc2c41baa9ed1a1e0ecf798ad57 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -912,8 +912,11 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
 	if (ret)
 		return ret;
 
-	guard(mutex)(&st->lock);
-	return ad9467_calibrate(st);
+	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
+		guard(mutex)(&st->lock);
+		return ad9467_calibrate(st);
+	}
+	return 0;
 }
 
 static int ad9467_write_raw(struct iio_dev *indio_dev,
@@ -1119,12 +1122,15 @@ static ssize_t ad9467_chan_test_mode_read(struct file *file,
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
@@ -1188,16 +1194,19 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
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
 
@@ -1263,8 +1272,10 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
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
@@ -1339,17 +1350,24 @@ static int ad9467_probe(struct spi_device *spi)
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

