Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020075.outbound.protection.outlook.com [52.101.69.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C825450F2;
	Mon,  9 Feb 2026 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621432; cv=fail; b=m9KS/RwHi4oHMn9C4EwNJ4nTFqQZmwZ0LNPCslHEC83u9g2FQjeCFTo7H6kirFYrbVCxGI6xaYRMXmkXewshWBZkXlfQaF1qgqdvUp8MB9mUY2jf5REXJcJ69gx0wuuJHT1SoW96Tjjxzp8UlK2Zj74lLoIBx+Jd0YWT+JlogpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621432; c=relaxed/simple;
	bh=ih4oCVQGz/PXrMiIYbrcNs9taHwQ3bbjAa5u502sF+w=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oyYhyoG/9MKuicLxQwi93kN2B/1o2mXP1LffiNAc89jgrFJy6mopfubu76QU+xz+zsAeDPDZ+ZrlFK8wZNbBLT30Os93lc2JtrtLnskHyoKG5Rd/Up1AK61DxhwERfw/AbyZB/osr4lzRXrKunOW6yQzU3JIQAw6vR5Y4NRkUNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=BpJGGW2s; arc=fail smtp.client-ip=52.101.69.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="BpJGGW2s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd+UMk7ndgyqFpo/ISMW+ulC1gjaAi7eIIqyUxrVHj1Fh+yKUWm0ZQoNY310i/Mt5OWVY3x6Bol0GXXYUtTWXowElHxCJZFEMCzKo90n4noG9QiSXX2kDU10VAEi3/3Am7VPiQkMRQ9sPYwAoBMwZsFk4IqGKZv6dgANIx8hosm6YwhMaiytBknItCk7aO2EUYD3UbczU8gvGwtaSr9YU0o/KC2kltcP/fXMvWQp6vj3BQFladtSpABKjnX/hOnL/1TZFN+clkXpYpv+fRhjLrKkQDa0QYn5jcTj3v3P+CHT0KOoEWDytx0OrrI6Dax+TEqtMYTjk24NDfH5Wd5jUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t600iEi5G6yNw5U33QvLhhwso30MMZ2OMoWY7EcOks=;
 b=DMStdB/Cz7gfFJBgE1xWrKWakrqzV1IgCzGSAtkU7sFxcM0wBHyKgQXv6C3LRxuIYAP+LflUzpBS1xbCUvw77OtD8GVkXSdW+co7z/Pz9D3VEeoOkCybWBMbj9wivVSvljyMq2PeA82GF6Z/w4lkaIIqC98ZLJlyyNsGHeJf7hYTOUUk0dPJWbO4yCZrKOYn9LEvorqEBF+yXiaYxUL1rGDrNlsJP8/UcsGmiV7PQsJKAJxnjsmjcOvgGcRo5uk5cdPKfTche4jT0FytWbsKPzwPHCPlvUNlE/of497u1chpLr0H1MLfn9DHhf8GYJ9HLpAz2bQAuDGENnBn18O1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t600iEi5G6yNw5U33QvLhhwso30MMZ2OMoWY7EcOks=;
 b=BpJGGW2sIRCTZ9WZOyThOBVHeYdXHdsMII6woZqLYgf/Vf3WUVxhbb1DYVwqjHvFjwDQNGGnkTuoCmDkFQpx9GWBmVlKVJfAz/9FXjXw5Q633YQPgy4Nbkk5PN8mNifxxht1AUM/D/fSrCriHywcElTLbsr8IPiUW7tJbn4NYlFLwqc0kNW8dENzW5RcnkT0FrzzZQkXkXovQW1POHua01aYTK3k6ikP9EqFxGcVYRR+XUO6AS02juUGggaZ/yWCapyweg0jH/f8ttxMJiSoT5G5TjTUxufe7GGbY1tsBaQe6HocZA5ED5N5jgLqzRjjE07ruJomVCoy5oZu6kciWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB11022.eurprd06.prod.outlook.com (2603:10a6:150:30f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:17:03 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 07:17:03 +0000
Message-ID: <6faec58e-f8e3-4a16-b056-9aec1555537d@vaisala.com>
Date: Mon, 9 Feb 2026 09:17:00 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chris Mason <clm@meta.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
 <20260208193034.7c780426@jic23-huawei>
Content-Language: en-US
In-Reply-To: <20260208193034.7c780426@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: GV3PEPF00007A90.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GVXPR06MB11022:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9815fa-91df-4487-1860-08de67ab398b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTRCejQzZGlPaXA0NkFNV3JXTGdKRldhSmlUUWdpWGxFdFV5SVBKSWtZdXdD?=
 =?utf-8?B?aGZpeDVsMVNiTCsyVVJoVHVlOGVLSStvbTRSUFRySHd1Q29yYXp6L2RWVW83?=
 =?utf-8?B?T0JGYTVEMURjZDFhZW5zWHRZODVSQ28ydmhobE80Q2tZMmdRc01LUDFOSDdk?=
 =?utf-8?B?ckg3dU5uRTNwYTlJR0ZGSFh5R1pHTmljOFozMWZsUWs0OENxWGs5NHJNL05s?=
 =?utf-8?B?ZlNHR2Q4N0ZVN1ZZWmFjY2prYUZZQWxaWG0wNjJKbFdqOHVFNi9SdDkrZGpU?=
 =?utf-8?B?L1ZEMXZHVnBWVWJRakt4WW5vNEM3SVJXQlA0eVc2UE84RkJNQ2YwRlJLbFQ3?=
 =?utf-8?B?R0VlT3VTanl4cWlDUDF5Vm83Ri9qZ0dab0N5N0h6SUhRRGNkUWtCNEFQODg2?=
 =?utf-8?B?U0VDbFk0NkZ6QVlMWmxBSndkUXVxU1pXQzVYKzVxK1dyaTZxNHVDbWVyOEdw?=
 =?utf-8?B?ZzRBMWE1c2w5Qkp3a1d2QzNlVllZZXAxOWlpVWJadUZGSEdVZmFDeE5vdzRw?=
 =?utf-8?B?WmNycDZDd1hxYzZnYnNvSkdqMVlxN3FVNEl1bFpyTHd0T2NJWGVXR1RxRXIx?=
 =?utf-8?B?SnpoQzlLWktISVZ1VnNvcHNFOTZjOGtIbjFYREMzTDhKclJhSFd0aDZGZkFQ?=
 =?utf-8?B?WWtXejZlbGpOR1pONkhFS1N1V1VOTVI4RlAzQWUzZmZnR2IvMGJuQXZEZlho?=
 =?utf-8?B?cjBTZjBpWnFPckExcS9CVnVrY0pldEUwK2NsNWtQZm9NTjBTTjdmbkdZdmhl?=
 =?utf-8?B?RlNlUTNZK3RjNWplUlUwK0pqQ0QxREk5VERVaThRTUVuSGtZYWkvMXBkWW8w?=
 =?utf-8?B?TCt2bEw5M2NNbENOUks3d043WEpGSDFodUhuclVsck52VU9tcktYZXBRU2R4?=
 =?utf-8?B?YjFKUG9USUEySG5xTkNNc2I1Ui9hcC82MTMrNGEraCtEUWdIQ0VmREFvR1F0?=
 =?utf-8?B?V2w5Nm1CekJ3VWpyVytKMytOQ1orcHBZcUs0WlIyWEw5eHdQWGw2NXdnNk9n?=
 =?utf-8?B?S1NpbUpmb0drT3lUT3ZzMnFtSUpaQjNSTkNJd2xsUFZWZTRLMXVRWnBKYm9k?=
 =?utf-8?B?WFp6Sk5MeE0rNXhTeldIaW9JUXJwRXdRZzl3WG8ybUt5TXFyNldaeXJzMno1?=
 =?utf-8?B?Yk9PZjEwVHJLcGR5eGVhNTdCOHhiYkQ0VUZ1MlRlQWdHWVRMRzZoamdMSVR1?=
 =?utf-8?B?K0d0V0kxdWU5M1BvenN3Y2I3MXVhYVVUcWxocURpeXJrQXJtNWtEYWZIaldN?=
 =?utf-8?B?emRBN2dTdlJUZHF2My90dWlSU2R2WE5GRUdwNDRleGJJUUpVUGxqWUNvaEZM?=
 =?utf-8?B?S1dXbW5CTi9ock9YOFRZTW5nVWVEQ0VlYVI3VG9NUjlVSGpsd3RONHNCVHhl?=
 =?utf-8?B?a3I0b3JscERhR1ZZaHVBYndPNzhUNit5YzZrZDBDems2bjhZdU1Ta21ic0U4?=
 =?utf-8?B?bjZGY09DN2t4a2Q3RHhTT0NvRXY3cDVNOWRMOHdDOTliNTVST1pxWm8yTURD?=
 =?utf-8?B?TjIrbjZPK0RLcmgyQmIzOTVERE5uQkQ3dlB5c2VGVUtLNWxlNTdxVFBFRzV0?=
 =?utf-8?B?S2QxRWl1N21FMUhxTmRMZm96THNFZVdpaDJiQW4rTlVNUlVpQW03cWZlVjI2?=
 =?utf-8?B?enRlZ01sbWllanFxb3YxUVBmcHAxYTlLa25IZ1F1OHphYzVWQTRzdFFUZkJl?=
 =?utf-8?B?MVF2RmJ6N1BnUjZVYW5wcVdEVll5aW5HRTRLckJHejJmNForWWlYMCsrTC9s?=
 =?utf-8?B?ZkxZR1d0ZVBJN0E5ZTFiS3FOSzIyczlUMm95Z2VReUs0aEdINFZUU1VmTTE5?=
 =?utf-8?B?Tnd0TmhSYkkraUtyWmFmenNocEcyWVpuVHpySHl2NkJCaHhBSHVIL2FxRjY5?=
 =?utf-8?B?LzBFbjJ4Ukt6SzB3eHozbXJRMy9ZaFlSUmRnQmx6TGhCRUdOdXFXOWZOekZH?=
 =?utf-8?B?bzFodHhpMnhGQWU3MnNnQzN4SnVHSHZCS0VRZWE4Sk9uWDVqbWs1VlpjbmVN?=
 =?utf-8?B?QkRxaGVEVThFL296N1J4WGo0Q0lQSHpZazI5WWpUZjh4UkU1dlh2Zk1kS0lY?=
 =?utf-8?B?bENJWG5tSVQ1N1FhNzQzUVk5U2cvT0pjRVliTmhGL05WYVF2bFFpRTBpOHRO?=
 =?utf-8?Q?596s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SC9peXZTa1NrajBSVXEwdFQ1MkprOVdOaVhYK0RWUzlycnJsVFhmdFlYN3la?=
 =?utf-8?B?Qm9uL2xwNnYzcGkzTTNQQWg2eWZ4bkpwdDVob3REdkNJQ0RrNUlpdldiMm1M?=
 =?utf-8?B?cERLeXNycWZadlcwbW1Gci9ET3NNY1BRL3VzZ3NGQS9tMDVjOEJpdjdBTHhC?=
 =?utf-8?B?RmUwQzlmQlFYMVFSTnEwNzF1WVZlazhQTVRwSHRrTUxlekJRN3R0Q2Jhd2Vz?=
 =?utf-8?B?UFh0dzlnUWFWaGQ5RnVzdndEZS9idXRwaXVLNWJrR1M2TEZMcUpaMytMWks3?=
 =?utf-8?B?bkYyK0c3QkkwckxlbjdTTmFEVS9lZ3FTdk12dzRJd0J4U2NWQ0d6T2xzUWdQ?=
 =?utf-8?B?L3ZkcC91Y2gvYWM2c3Axa0xWWnllVDYybTNGSTNHR1RyRG1tZzgxeGJJNlhx?=
 =?utf-8?B?QThLTkl0VjBycjIzNVlyNWM4VXVWZFJ1L2loVytJTkZNUzY4TUhYeXRZV0xV?=
 =?utf-8?B?Z21RTm01VFBIcXVJWmo4WHNsY1RyUEEwd21QM1kzT0dSMzU5ZzVFN2N6dWtS?=
 =?utf-8?B?c08wYWJLRnlwN09OTTF5Qkk4V2pFL09wRXRRNGtuaEtXalZyTWprU0xGeUF6?=
 =?utf-8?B?UUVWL1NtcklqWXhXN2MvV1c5dVRTZFVoRDJSaWRQNEdVVmpoc05zMG1pamhI?=
 =?utf-8?B?OURLVlpEaW9xQlRrUG1SWGZzTHNueDRYRkg2OFJFd0M1VGVwRUVsNmJzQVVI?=
 =?utf-8?B?YlB4Rzc2QzdLbWhObkxkQitUb1piQ3ozdzZBMEdrK1VoQnhzNHZKK2dKejl0?=
 =?utf-8?B?d1BOYklTMFliRHBkYlQvb2JsZDhqMEp5ZlY4NHBCTHNuWENzaWNNYitxMUp6?=
 =?utf-8?B?Z091ZnBDbk5VdkYxakpvM3hqUDViRDZjVVpZMnNZbHlnYk5mTWlaWndYZW83?=
 =?utf-8?B?UUlTdE0zMkd0aDFzaVlmWSt1VTRKSWViVStXMXRKNmdnalB4V2pacHJDMkln?=
 =?utf-8?B?eUZGRU1heEYzSHNxVkdtMTJYRjlpQmlHN2xhWHdNbFFYT0g5MW5aOWpzS2c2?=
 =?utf-8?B?a0w2dmg4ZEpzTGhmbjE5M3lwczVyVEJQKzVpTGo0MDA2STh6Z0ZzcG15UmZy?=
 =?utf-8?B?MHVLcXFyVlF0NXdnSmYyY1BGTjFMTGVHbUlUZW94Zm5RWEUzWlVIZ3VSNkJv?=
 =?utf-8?B?MFdqQ2xENVM2TXZadlVsM1I0WkZlaDFlelhVbkxmYXp6c1FNWWtBSkR5SFg4?=
 =?utf-8?B?N2o4RGh4cU91YlVqODRNdXowcGVIUGRsRWVqYjZoZnJTUVZ2bFJtS2dHdWs4?=
 =?utf-8?B?aFVjaHcrTjF1UFRiMHFxeFFaZkUrZ0hGeXRsUHNaYURhR0xHbnpDRTYzVUtz?=
 =?utf-8?B?MGI5WXA2K2dlaWJacE5mZFJ4d2xVTU5aNy82V0JBTlU4L2hKMnVzS29UalVq?=
 =?utf-8?B?T3g1RTg1OVhrZy9zZDlSZllrSHhkVjRnS2R6b2Z6eXZISFJtd3paZWp6L1BR?=
 =?utf-8?B?Z0xjVGpnT0xzU204cDFkUkRyMDZSMksxYldNWW1EckVMMU9OWVg0VDlMbGs3?=
 =?utf-8?B?ak4zM3ZuT2czQkVyeXpoc1hydlJwNThFVmM3dTMxUXp0cnZ2TTkwVlJWVGtM?=
 =?utf-8?B?OUNsKy9HcGVrNzFOdXpoMmJVekZJbjBBZ2paQkFjMFFyQ0lmSmR3LzhyWXBq?=
 =?utf-8?B?VTNORzlJcDBESnROUEhXT21SVTRERWgrdFoxaEg3S2FHMk1vNVlONlhQUUhs?=
 =?utf-8?B?eUZGV0dPVFk3WmkxYW8vOFJrZzIyamdGellhQSttZCttM05rbWxuanFpTkw0?=
 =?utf-8?B?TjFITmNnUDh1Uis2ZWVneGM1dGVOT1VmQ2ZLMmt5cXZCOHRkRXFFNEpCOUVY?=
 =?utf-8?B?U1VVSmpCdm5valYrNUh4WkRpQm54SzVSL08vZXBvL29EVnFoVG1XM2ZnYVEx?=
 =?utf-8?B?MjlxbUh2YTVzSjE3MkR4V0tWczFqQ3pPZVpYL1d0ZFNTSytsN2pPNkZtNVUv?=
 =?utf-8?B?NnpRNjMzNHc5ckMwSUpXMFRPRG1FWFdlNDhNLzRCQytVUTV5N0VmZ2lPL3dp?=
 =?utf-8?B?aGdTVi9SUzdONTdiV3BCYS9SRTRqbFphVXA4YUE3dnltZWd2ekpES2lia1Ns?=
 =?utf-8?B?QXRRTTJINlZzc01XdzZDUkgvS3h6ZkVkMGxmTUhIM2ViS1RVK01ha21VU003?=
 =?utf-8?B?dmlxMVFjUW41dTduNUp4VUd6QjI0TWJIcTFzb3FnK3U2Q3d4eG1nTjAzNjZH?=
 =?utf-8?B?c3hycHdDTDNYVC9RcllvdE5yUVpGUzZ6TEI5Mms1aUgxYW9WeWI3djJORGdT?=
 =?utf-8?B?QTVlRmtQK1d4Z0tTSlV3ckZKM3BhVzJRdHFkUTl4N0tRK2pVNHJXeDRSc3ha?=
 =?utf-8?B?S05lMDRScWYxUFFlaTVwN2pZWGJrZFdPN1FFRXI0UXAzL2RiYkdRTXhLcUNE?=
 =?utf-8?Q?c/BTCBheY0g84XnU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9815fa-91df-4487-1860-08de67ab398b
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:17:03.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4jSKuH3Kxjfuf3brEuv77DQsHGSxQ+Cz4SvIW3RWly3XIU/SXuoPlB1DFoJkquWHuvHsN3deG1pocNmZgW3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB11022

Hi,

On 08/02/2026 21:30, Jonathan Cameron wrote:
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

The analysis does look correct. I think this has probably bubbled up in
the whirl of changes to call locations etc. Thanks, I will verify and
fix this.

br,
Tomas



> 
> So this might be the first bug in IIO that the LLM found and human's, including
> me, missed!  
> 
> Thanks Chris! I won't +CC you every time but wanted to acknowledge that your
> hard work taming these tools is very useful to me.
> 
> Jonathan
> 
> 
> 
> 
>> ---
>>  drivers/iio/adc/ad9467.c | 67 +++++++++++++++++++++++++++++-------------------
>>  1 file changed, 41 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
>> index 59c3fa3bcc9b..7a3db36121b0 100644
>> --- a/drivers/iio/adc/ad9467.c
>> +++ b/drivers/iio/adc/ad9467.c
>> @@ -913,7 +913,9 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
>>  		return ret;
>>  
>>  	guard(mutex)(&st->lock);
>> -	return ad9467_calibrate(st);
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
>> +		return ad9467_calibrate(st);
>> +	return 0;
>>  }
>>  
>>  static int ad9467_write_raw(struct iio_dev *indio_dev,
>> @@ -1119,12 +1121,15 @@ static ssize_t ad9467_chan_test_mode_read(struct file *file,
>>  		len = scnprintf(buf, sizeof(buf), "Running \"%s\" Test:\n\t",
>>  				ad9467_test_modes[chan->mode]);
>>  
>> -		ret = iio_backend_debugfs_print_chan_status(st->back, chan->idx,
>> -							    buf + len,
>> -							    sizeof(buf) - len);
>> -		if (ret < 0)
>> -			return ret;
>> -		len += ret;
>> +		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
>> +			ret = iio_backend_debugfs_print_chan_status(st->back,
>> +								    chan->idx,
>> +								    buf + len,
>> +								    sizeof(buf) - len);
>> +			if (ret < 0)
>> +				return ret;
>> +			len += ret;
>> +		}
>>  	} else if (chan->mode == AN877_ADC_TESTMODE_OFF) {
>>  		len = scnprintf(buf, sizeof(buf), "No test Running...\n");
>>  	} else {
>> @@ -1188,16 +1193,18 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
>>  			return ret;
>>  
>>  		/*  some patterns have a backend matching monitoring block */
>> -		if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
>> -			ret = ad9467_backend_testmode_on(st, chan->idx,
>> +		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
>> +			if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
>> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>>  							 IIO_BACKEND_ADI_PRBS_9A);
>> -			if (ret)
>> -				return ret;
>> -		} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
>> -			ret = ad9467_backend_testmode_on(st, chan->idx,
>> +				if (ret)
>> +					return ret;
>> +			} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
>> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>>  							 IIO_BACKEND_ADI_PRBS_23A);
>> -			if (ret)
>> -				return ret;
>> +				if (ret)
>> +					return ret;
>> +			}
>>  		}
>>  	}
>>  
>> @@ -1263,8 +1270,9 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
>>  	if (!st->chan_test)
>>  		return;
>>  
>> -	debugfs_create_file("calibration_table_dump", 0400, d, st,
>> -			    &ad9467_calib_table_fops);
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
>> +		debugfs_create_file("calibration_table_dump", 0400, d, st,
>> +				    &ad9467_calib_table_fops);
>>  
>>  	for (chan = 0; chan < st->info->num_channels; chan++) {
>>  		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
>> @@ -1339,17 +1347,24 @@ static int ad9467_probe(struct spi_device *spi)
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
>> -	if (ret)
>> -		return ret;
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
>> +		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
>> +						      indio_dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>> -	ret = devm_iio_backend_enable(&spi->dev, st->back);
>> -	if (ret)
>> -		return ret;
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_ENABLE)) {
>> +		ret = devm_iio_backend_enable(&spi->dev, st->back);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>> -	ret = ad9467_calibrate(st);
>> -	if (ret)
>> -		return ret;
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
>> +		ret = ad9467_calibrate(st);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>>  	ret = devm_iio_device_register(&spi->dev, indio_dev);
>>  	if (ret)
>>
> 

