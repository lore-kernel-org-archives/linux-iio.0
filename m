Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1A3491C8;
	Fri, 23 Jan 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152261; cv=fail; b=rxAh52Rzp/Vkn4/ZH315MavW1PSWBtT/NdcoOdctnI4ZvoUH1VBLrJmfga3ZlgTHmArqM4km/wx/FZfZVJVt0+hCIQ4v4/AD3QUQTTzGBnboIKZc0PgMOTIetYFXwOiFDTMM8QOul0/hCykfysn8TgvYUgC++dQSNyUrXf9hjT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152261; c=relaxed/simple;
	bh=9jHGkpRRQt3BGmZ5V29J7TOQcW7/fgNltEJmu/0MOqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fDpLG/m5UgXRpUd7t5XvenkswOmZIWViVOzgLPtTy2eT8xQpnJBzueP5B6rCcrGK1uInQhTxOD3wI0YbyfnHmm6YMlby6C2c6FCSfMn72a5rCD/DPo0JgTrfdgftPjUTSnexyPx4f8vWUEUlZD2aA/7EjdE2Y65kaBwzDhsdCRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=lWTI48sn; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="lWTI48sn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecLCQQpE5fPr1SsOtowkWPSWqQrT3YRkdQRWpnoo6bAZDvZrj+5thKb6kWYR4Dxpwx+TpX7JecNlNo6vRpe4IVYmPzb+Q1T2QhMQfjm3f4B4fHDTZ1ffBydRS8Z5i8Ic1YPoThfmAaQaKAXikdht4oSPcbEbTOhb58f+nIc7Q2+lUC7rcvyycdc6IhjtPDozO7IuorvcwQgpqdkFzWoTOsMJjIn7PYuqyD9atzm82P5nwimJ8FPYrlwR+pZOvqUGXyZwieZXc/EXyNTFS3Jvs3h0LaSYgXYncZGJ6VOIG+vyggtW++qBjGXNI7Q2Pnq4wgjEjz81JTDa5OaVnfKF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nqcg0uxMVw21iIXRirULvWGpLH2BH2S4XY7GPuHcn4=;
 b=Bs3gRqAvpfo7k9Vyr39apKLj1Mak1tnodsQjUeoYAKstY/mXay6gxZUw6KMTC7mz83XpW5tx33rUupbmHrbC8M7qKApx2R/pqmp7QRUNWHcSJtf1HwMCQtsi+7fZA1wFC4/55daOyXGHIuaFJTOqOYR8f+l2d9Cdf+OU1XvG5bgsKThUJ2N8wGcSC7gvAk/nXMauXjKhEN1bGEHyWovDdQM/1MtnWb0x47iaHdqDCqa/iwq08DhVq5Fsyn3QmJbO+TeWomcv1gwm9UgQfibP7/zyFzSTcKFa5326iCpPLfHrct1prw8qiv+E5960OPd4D2/S4EEEmLFWeTp28e/QCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nqcg0uxMVw21iIXRirULvWGpLH2BH2S4XY7GPuHcn4=;
 b=lWTI48snp38+4nlBQrp8ANIjWdMGyI9iTr6Tg0Belf2LPSQPTDrD1eY3OX7U6lJNdQTaIx1JfLFO3cBekWZhdBmonSDuN09kgBmbYmtu06xbyVkBU971gzB5xlFSn0rS46sEAgkVO55rQ84CXbHl7mm76RTWs9O1yC5kuwG1hDWjnJvQwhnzC7bs9BwvAEYvYp1xFvrAapeQpnojwGtlfwekd5Ul85x8IPc9qPdyImBVo3QosYTnoL2tXl7UHxDs8KvcKWDPlsxzYTBljdeZuYZkfXaJeq6Fwpk/J914J1m8syoNNBQEuH19VMxIfw9xy8OGvLaoDrt8te8ZWbYysg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by FRWPR06MB9835.eurprd06.prod.outlook.com (2603:10a6:d10:174::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 07:10:50 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 07:10:48 +0000
Message-ID: <24ab3315-8f83-4d52-b6be-abd31e58d0c8@vaisala.com>
Date: Fri, 23 Jan 2026 09:10:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] iio: adc: ad9467: check for backend capabilities
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
 <20260121-b4-ad9467-optional-backend-v4-4-18d2c0d450cc@vaisala.com>
 <aXDNZWSWpuDPzdwv@smile.fi.intel.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <aXDNZWSWpuDPzdwv@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBF4.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::312) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|FRWPR06MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 457f385f-32e0-4ac3-5e45-08de5a4e88de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3c1eU1pZTdvNUFyRWRmWkpZSU5ySU1JS0dCbnFXK1l6bm01R0ljZy9jd0Za?=
 =?utf-8?B?aFFTM0dJODdkU1BacmZGb1p3WFdrUjl6TzB3Nld5WFJmczhZKzZDbTZxaHpD?=
 =?utf-8?B?VnFZWWt0M2phNUlkRnZORkFyU213WEcvSjdONCtqUkZoMDEyaUdFLzltSjZF?=
 =?utf-8?B?UTJyaUpTSkV1YUwyQXZUMW00cWFwVGhUUG1QK285UmxtTVc5Sk00M3RuRGE5?=
 =?utf-8?B?dEcwT0hjdXV2aTRNMnNjakhnOC9vbmgxbUs4UXVVVTUvYk1PL0orYi9ZNWRH?=
 =?utf-8?B?bmJJL1dWZWUvQkdpc0Y0QnhkMVpZZTR0STMyTFdidGVLL2tpOEJLNC9uVFkv?=
 =?utf-8?B?ditjaE02SHhtZ05IM09VdWVWa3V2TTVXL3Y4OWNJdjdPRXNQL21xcGVqUFBj?=
 =?utf-8?B?aWo1dlYxL1ZPbjk3cGppU0dwa2VtOGd4bDhvYWNhWVNyWVVFVUhzYWIxNGdh?=
 =?utf-8?B?Wm0ycGVDM0Y4RVlhTkJzRmM5djREai9oSlJkZzQycEUwN0FDRUw1d2F0SzZr?=
 =?utf-8?B?WVV2T241UjhTMjdxMVk0RGQ2UTg4YlZCMkFLZmwzNVdJdTJSNEVSQ3lZR3pX?=
 =?utf-8?B?NU8wMTFYT2cvdXh1aHJnY08rNHRDQmFyTEgvWnRQeUxPYTduT0pkTktDakRS?=
 =?utf-8?B?aG1uV00xT2VpTlREN0tFWmVZM3R2dWNsN0VEN3VVRG1qRkN3U3hJSzBCQ1kx?=
 =?utf-8?B?ckt0OTdXZndpUjFTU0hqU0lpclhYUlczMFdZNE1FWk5remdqMUJtcnVkMnZH?=
 =?utf-8?B?ZlBVTXJXWUowRGpHV005KzBHRVRobGtnZERBY3d1eGlTY0RJOVc3a1RCejBR?=
 =?utf-8?B?OUdhdVNRQ3BxV08zWFBKWUZhRUFNT2w4MDI1WXRnNERnNS8rcnZkZXVYQU1T?=
 =?utf-8?B?WWxUSkdQT2U0UTc5Q0VuSzNUMC9taFRmcHUyVmpUOHUzUjVRK2JrdkFNWFVn?=
 =?utf-8?B?QS9EZ1NPS2JKSlpZdHhXdG5CS3FHQUNRNTlEODY4L1dPbGl0VExWdlRJTGdl?=
 =?utf-8?B?eFpDS1MyajF0SUZnN1phZUJ1Q1grZU9DdFZjdDRZQnBJMkVOejFqQVBnek9u?=
 =?utf-8?B?amlKNlBteCt1VnZCZy9HdXd0YUVyYTUzdEVhZzlXZjdSVnlBSGZkc1puSmpo?=
 =?utf-8?B?K0p5NGpocnRVNXVvMC80S2FsSDZUYm12WHJpMTFIRFpPcFlQQU00T1NSdlVy?=
 =?utf-8?B?UkNLVERVQi9Wb1c5bjExMEpmemhlQ0ZSbFdiRkd1bWl1Um1CTnZvaVh5Vzdh?=
 =?utf-8?B?dndMcmdNaCtqcHRwNWFqOW9qTE5Ma2M1UTRmV1NRb29ZSDlicE05OTZTK05s?=
 =?utf-8?B?T1NDNXQySDZzODJIS3dGbFNqMWFRTVlxWXJwRDRaZ1hpWlBQaFhIMEtEaTlH?=
 =?utf-8?B?VWpYL282OWIzYnRuMnE0LzFJOHRzOGdlTGFiY29na2RXNHYrOEdMUTYzUWEz?=
 =?utf-8?B?dXg4V3lHUU8rRTNMdXJiSFFXZ3VnUFVqei9sOEFxbVI5akZVN1RsOThzMlF1?=
 =?utf-8?B?SDludmlYNzZjNi9yR0kvS2lvVk1yN3FzeXhrZVRzVit3UE9RZVFrWTUxKzdq?=
 =?utf-8?B?TFM5OXA4TFMxVnlzdXExSHUvSk15MHo4bmhvbnBJbHFQZHVrM1l1T0RZMXFm?=
 =?utf-8?B?cHBmRU1ZZXpZNnNMSEFYeERSY2hpZUZkQ0J4U3BCRHhWOXNrYUs0SzBycS9T?=
 =?utf-8?B?eGRzeVZQQWJxMEN2ZjU4eXpNNmRxcStUSDlWSFJwYTIxODRLcXpJdmw0eU0z?=
 =?utf-8?B?cHpTRnNJbjg2b2Q5RS8wN3VSTDVpVUNNcGhmbzFwalZpc0pKRmJpSU9tZVVu?=
 =?utf-8?B?Rys1Tkw5dHpSblNwSlZwS2hSVnl5N2cySStQRVJhVjVNb203SjlzOG1FVlEv?=
 =?utf-8?B?SHdkTEJCUlB4NDh1K1NLVWRybkhDTUpob2lxdVlBd0NLRXRaSExMeVRKZGJX?=
 =?utf-8?B?d0lWdkR6T3VrZjVsVnV5NUgvUnhVdHRoYkNjRnVvaFNscmw3VkxkUFp1VUts?=
 =?utf-8?B?UHI5UXNUU083bkFyNVpmUWVwMTRDem5BK3c3WWJQbGFhUmYyejZsRFZQZG1h?=
 =?utf-8?B?ZG0vRTFIc3ZhaFFtSktlOFlKaW4rYUFQWmM4aHZKcDhybVJiY3ZBN05hMFRX?=
 =?utf-8?Q?Hx3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0c3Z2Jmc0wrVkM5OWc1SXVBNE1WUWJha0YveHJXekhOaXdrNHkzU0FtRDl4?=
 =?utf-8?B?OVZjZmx0MkZEbWdjVmJDUVhsTkZHM0p1Y3FnWVR1SGJaNS9JcVpLUGh0Nlo3?=
 =?utf-8?B?alhwQmw1Q3U0QlVVdEVhSGhKbkgvbzlMZEF0bDZPV2tZTXVTZGhyRlkvSEVn?=
 =?utf-8?B?MFRaTm9JL0V1MkJOcVRsSys2NDVGYWhGWVFuTWhSblk2TFZGNW11dXVqNmgv?=
 =?utf-8?B?eCtVWk42Q0xJVzR0aTQ0Y1dMVyt5N1p2M29HYkFPQXc2THVJZzdzWXNyeGdU?=
 =?utf-8?B?VXo4bEcvQXBGQXY5a3hPL2JNcW1MT3JtYnFkRDltQ2N6eEp4b3VPcDJPSVQv?=
 =?utf-8?B?SDgza3g2NVlDdUVrSVlRUlpWcjBrWlF0UXZKOFJCKzlVVERpVS9OOGVJVitq?=
 =?utf-8?B?VlZoaGp6U2U4UmVOOFVsRitjRTJOdmxxWVBRc1h0U1BtWkIvQS80SUZQWHh0?=
 =?utf-8?B?TnBWTEhUWS9qWXNxKy9WWHluWXd2ZTl4RUtJcHR6Q2x3ZFVmNUpMTWdleHBE?=
 =?utf-8?B?V0Y1Qm93a3dHbHhETUhFRUNRVlBrR2ZnSldFSHZlU2x0WmFYMWl6VjRpd0U4?=
 =?utf-8?B?K1FqZTZia1dza0xzTFNSWHF0MnJoZmFSTXZiZldpL0xSUVB3TkNRS1ROeHg1?=
 =?utf-8?B?TGM5Vm5ia0dZL0FUYzBlU1VzMnRDd3NwQXJSWHdJV0lVZEp3MlFLMnZLVTh1?=
 =?utf-8?B?Y2w4U1QwREMzVWhNMTA3Tmx2YXp0WGRWVlJpMURQR3pnQXRyb3FqeSs5NFow?=
 =?utf-8?B?cWZpUHh1cU4wRlIzZDlZN1Q3YTVWbGRCVU11L2VSMHFqN2NRSFhtbDZWclZ4?=
 =?utf-8?B?ZHk4V3ZDWlRSVWxRc0VUK1NWaEk3d1kyZGlseGtFMXc1V0paWkN5N3AydW9s?=
 =?utf-8?B?bHR5YTFidW5CUlR3dUJIN3ErVmwwMWQ1UC90VGRoaFZiOG1CVjFzWW8vZTFq?=
 =?utf-8?B?aGViRnM3cnFId3FwYWpxclhPWEJGcCs4NnBsa1ExT1VMK3NaRVBOVWVBbDRm?=
 =?utf-8?B?SmtxTEcrbU5LeHZ0cmdxbUxCSCtQLzZRcG1YWlNRaUlLTnpxeHNud01tZlYr?=
 =?utf-8?B?WHBrMTlPbnRDQXUrZTc4SEVrR2o3dEZqM2IyTHB1S29lOGNMM21GbUpMdWp0?=
 =?utf-8?B?TEluTmRSYXEremNLQmFIdzhHdGZCRGk2L0JHNXBqcHdGbGx5RWZROW9DTER5?=
 =?utf-8?B?Q2EvZ1Erc2IvK05VZVNZT04yREZERmhnYlNXNTB6ZDVtRkxRdHJXemJsbk52?=
 =?utf-8?B?U01qZU1WdUZVNWRaRzl2QUoxZlJBUzRVNTVXMW9pdTlnbXlPY0tJQ0RGUFN6?=
 =?utf-8?B?dWtNZ3BXRndId3BybVdudTRIbC9tMnFnaXFyRUt4QVVFSlFyVEtWOXlLa1RQ?=
 =?utf-8?B?M1hVTk1pbFI1bFpKNmRXSHg2ekltK09iVDRWVGhmTUxoR2FIMHc0RklZbHFo?=
 =?utf-8?B?MVRPZ2hIUjFNeGsrMGl0ZWlSNnp3TXozbllwY0N5SzBaOXZzVUxGaVVmRkNn?=
 =?utf-8?B?d3hZenRDbkR5L25nakszekozeUQ1SXRweTJac24wcEE2MFR1bkdPUVhPRzl0?=
 =?utf-8?B?N3hPUi9XYUpFOGJsSGxoU1QrYmFRbmNUS3M0aVdsMU43Y0d0cmNuWmpyOFVG?=
 =?utf-8?B?ajdzVmtUNVRhMHp3eE9VQ3hIYkFEUkdSNGZRVWRDYU5pR1Z6d29Yem5pTDQ4?=
 =?utf-8?B?SWh1OUJud2JSRHVwYjRKVWJHL05zdFZRd1hEYVlTeGMyUDgvYVUvL2IwcWtz?=
 =?utf-8?B?Z0FFZitXeDFoYnM0aWRpRW1yYXZPZ0l0dnZ6OUZOMzZUYTlTeHhYZldhbktV?=
 =?utf-8?B?ZS9GN3JtbWwyeFhkSFltTVRmSWlZMDBiNWRhR2dPeXdQNnp4YS9BUnQ0SWlr?=
 =?utf-8?B?SDBUYUNnT2hpV0RrR21CV1F2UUF0OWhrcG1QWmNmOEVrTjRzRWlMNlhiWDht?=
 =?utf-8?B?QnJ6bE9MdWNyZElLVFVZQUxMaWFQQmpOSlFGTUMvcUNCdmlIdS96VnE0a2lx?=
 =?utf-8?B?OGM5MGdxMFJZVXJGVjlKUlN6SmdwdHljRXJ6QnM3UVpnWG9xM3IwQXJBZWov?=
 =?utf-8?B?V3BwZUxCTXA5T21RWlZBZVFkak1iRmViT3UzS0p4bFVwVEJ3TEp6VUpOUGNn?=
 =?utf-8?B?OEpiWVRxckhmemRJR2djMnpqdm5Vd3dXUHZXSEtuWFBVbGRhVnZkeTFpREZB?=
 =?utf-8?B?VFZaRUhNeGsyN3lzV2dDYS9jRjVGMW9iMmtoeFFFTWlMZFJwUlNZRy9zRGYw?=
 =?utf-8?B?aHVXcHIvYStLZzJmb1VKUGpwamZPL0ZPNDVjRUZjRTQybHNobCtNeEEwT01h?=
 =?utf-8?B?cDFjR1FlczBRRHRlWjN3eGhrNGlaUDEvVC9Ick1EN1pvK0JzaU1Yd1Zmbnpy?=
 =?utf-8?Q?ll99A3II0oxo19gA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457f385f-32e0-4ac3-5e45-08de5a4e88de
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 07:10:48.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jp2FJrhVZbtbUJnUzUxMyOFL4n7VDxwYH4oTSh3pVRkzsEXlldiCZGhPsWf2TQRnWqU0sIEyp9fzBx4+BjG8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR06MB9835

Hi,

On 21/01/2026 14:58, Andy Shevchenko wrote:
> On Wed, Jan 21, 2026 at 12:08:33PM +0000, Tomas Melin wrote:
>> Add capability checks for operation with backends that do not necessarily
>> support full set of features, but are otherwise compatible with the device.
>> This ensures a fully functional device, but with limited capabilities.
> 
> ...
> 
>> static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
> 
>>  	if (ret)
>>  		return ret;
>>  
>> -	guard(mutex)(&st->lock);
> 
> I would leave this as is. Yes, practically we don't need to cover
> iio_backend_has_caps() with mutex to access the data, but it just makes code
> slightly more maintainable in my opinion. If anything appears here, it would
> probably mean some kind of if (...) do_blablabla(...); pattern that will need
> a mutex.

I have no strong opinion on this. Current option was chosen as it seemed
cleaner in the sense that it a) takes the mutex only when needed and b)
check for caps does not require the mutex to be held. Based on this I
still suggest keeping as is but will change if you insist.

Thanks,
Tomas


> 
>> -	return ad9467_calibrate(st);
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
>> +		guard(mutex)(&st->lock);
>> +		return ad9467_calibrate(st);
>> +	}
>> +	return 0;
>>  }
> 

