Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021076.outbound.protection.outlook.com [52.101.65.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721921AA7BF;
	Mon,  2 Feb 2026 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033850; cv=fail; b=YputhM6n3xIhaMcTgfDsFZagOEhVM9OGnFYzw/1PTlzzwKbTbnKpuW9grK0jyVsALJegea8eIc5s5zNGz7L7sKbw6N4WTA4v15XRjipfkuHYEqwxBvUl9F47NMFy4dqK+suZ+bAM/xSZ8/vx2VdKtiWfq0z5IEVVjCtMh9cbFH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033850; c=relaxed/simple;
	bh=8CR0lg5AONYV4LBng3YN+/msb0kyCA+nhxfOGjZyizw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b4BSkqHaxDmWoD3PiPVGyqdEl9+ar43ljyPVDEEnA2XZhGxxzxjJVVgccOz9eCs4Zgi63r1kg6Qr/0zoAare5o+atQf9QkYO/HvLwEArP8iPkpySTLTcMXIvBoHDsvNofefPtxkT1nKI35NESU+UkrFxi29yjL5vsNRURqx0pQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=KRw73suN; arc=fail smtp.client-ip=52.101.65.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="KRw73suN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPvqGgHTJHnqwAZaiarSkaTQqS5eERhoTQbaSpvpBRFHXXRUgHqa1y5cJLFtzkAHub63Zjvs4mVp33WseQjNEosSXEN4R5YYN4vJ7CechkrrkETwUhHWufMa/lJVjeWPVzYS4vvBd0/tgykrUrTx1sGQqG5c9tIIt0tUHpRl/Y3sM9F4pnn6sjuGls0bERYuvciK7uo5Vx3OlX5LYwFTS0e1GF1cOL2s6mUDCpH1OIRsAeVnMtHgBd2KN5pG9zV0IJt6LKdSaVWJ2bYsDHOeg2Yw0bjMN0jtl7m0XQpJDKScaaMRDGvhLMoJcTllR9zdL4f9Ijea8p5Ui04LhqUSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRzb7NJVuFoOeW9Qu9YRm85yCDpCm2eLaRasaHh9MpY=;
 b=a6mFcQS5thRpaprALOwP71EDvruHJXqOXsg47ebZET3QIAHkSmmkbn8y1HCm6/tFDFGdpT679tkthJFxuyfqvWAd+qsiIXhU+91a3JvbXpUdVNiJTpaY1R2gxzP7cuarq505CpG/jEk++cjMWawvvz/+ydLTwZHG2CzGzkBrnK+5PnES891v40Lcq3jozBSKhF5V6F46clARYkH/uBVJ7YTc7IsOYetmVTqpsqGA4Dsx2f4LHNQ/nepL2774tv5azLzOJR+asBXZY52mXxBaMO3pXE+p2Ts1Y4GG8iDRnA0+3Y91bPA9pjweqVOBMVAs9WegASXfBLTiWjWzZdm1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRzb7NJVuFoOeW9Qu9YRm85yCDpCm2eLaRasaHh9MpY=;
 b=KRw73suN60KHC8gQaglNaXjlwds2HCehgrea15VHgLPsd5eScLunBBG/9JrJ4EYwek/vOBGslBFkao9sFPT6maGc2rGM4FRdyd0BV4BUYwDmkis9SASKHIFkLlLNjSdv+nh3QcOu8hR/fMh3J86iSMKeETmw4+t+mwEbqsrkEDNA3j+Bh2DvEXI9qhwG1avlIprtx5/1tosQYbD/S2KDCMQkV6CIFZbNahcKlZGWKO4QU8Ebh1y3pdxo3CApo+RPySoiEnSNm/HucDBsjYUjOcKhvTLgxa4LWa70ygCAryCP18/8wldUBNvVErrai8yrq2+Eug0U30ch5qxXckaxPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI0PR06MB9748.eurprd06.prod.outlook.com (2603:10a6:800:231::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 12:03:59 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 12:03:59 +0000
Message-ID: <353d33f7-995d-459d-aaaf-64bf76df7e14@vaisala.com>
Date: Mon, 2 Feb 2026 14:03:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iio: adc: ad9467: check for backend capabilities
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
 <12b0fbc2f4c3a6be86089d9cab73cce1c3face0d.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <12b0fbc2f4c3a6be86089d9cab73cce1c3face0d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00023974.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::365) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VI0PR06MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b623e6d-e478-4ede-105c-08de625325bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk1VZWxUMHBoWmFGS2syMGNrQW1IcFdNVEJLMlBjT1pxazRvdTVSNmhJcGxl?=
 =?utf-8?B?R25sY2xkeVZuaVo3NlRIVlVJQ0NVSTVQZGhBNG5iS0RKcHd3M0gyR0VGVjI5?=
 =?utf-8?B?N2taNFNCcjJGREJobWVJME5XRU9OU1VYcXpsTEE2WUlQQVZoSjRrZzNnaUJI?=
 =?utf-8?B?Rlh6UFpzK0NxeFpuVnRMRXQvTmhSSERYRStUOWh0NHRCcW85YmdmSmJJT3lW?=
 =?utf-8?B?cDBVNXpxRlJtZUppUjIxVlBrWEZPV3lLc0xlM2tsK2c1K2dFTXNCWFIzTnIz?=
 =?utf-8?B?ZGpoQlBPWFZYbGh2eTBrNVAzOWJ6a0FxOFZicTNDL0VWTnEzVmJPWkZLOFNQ?=
 =?utf-8?B?RitldUxaamZ1RUtYaUlXVnVCdmRVLzU4OW1OOUltbHJXQ3ZtRTBMdWJGMEhF?=
 =?utf-8?B?Z1JRbGlSVjZOT1kyZ2p5YWpsdGpkRUlkUURGV05sSTBFMlduTzJtajNWU1Zp?=
 =?utf-8?B?cEJjeUVwaDBLRUZtT0hNcEQ5ZndQcjRFWUpHZ002TUR2VmN2YURtdU1hVGpV?=
 =?utf-8?B?NVIwNHMrbHRrcnc0Rkk3QXpzOWdKdUphUU4wTkEraVdDUllvRldmdExBUXRC?=
 =?utf-8?B?Ti93VWZBTXI0cGFNS083R0xsUFlKZnh5S1dsY2NtUlpsNGdZSTN5bkFIbjFX?=
 =?utf-8?B?NmtZMi9mSUg4Vm5rUjNLcEx4OWhlM1dhLzUvU2lENmpSM3YzbDUzUFpQS2Ro?=
 =?utf-8?B?dWRWZjJDTzhiaVdVOU1oclFFTUJaY1N2V0Y3bmFMbGo3L0Q0OUxHazl4MDNI?=
 =?utf-8?B?K0RKMjhuMDdzS3B4amJuTE0rNGNqMGtGOE9Xc1VmeEtreUUzb0xiMS80WUtX?=
 =?utf-8?B?OXBoNnZYQzB3ZnIxbFhseEVOa0lSWVNHRVRseU1DRGN5RlZoMU1SRFhqWFNC?=
 =?utf-8?B?akp6b0s3ZWVVMXllRDFnNndQTXpkdytnczFUQnNlYkdhckc2d3JrQ0xWRmRl?=
 =?utf-8?B?YkVEODNSclpOa2hQSnVEWDRXSTJUZ2hiU0xFL1VBaWRDTWpocFFodlREUHZ6?=
 =?utf-8?B?RmtsZGkwdS9OL0kzK3hXK3RYNDhsaGtRZ1RnYTcyRzlGVDN5dWtPb1VqcFNF?=
 =?utf-8?B?NTJIYmJVWnl3dXovUkM4ZE4wUDBxNTJuOFI4VGZ0Y05nVzFOTDRydkh4VFRP?=
 =?utf-8?B?U1M4OWlQMjlYNy91Z1dQU096QVlkdFp0bS9WM25RZHdhUUNYVWhLbnVJWDhs?=
 =?utf-8?B?T1RicUE3M01NOG1XU3c1NDdSaHB2d2EyVGFoNHUrVmxEc2NZZWsySHUyOEI5?=
 =?utf-8?B?TEtpMjZ2andMWHpadnlHOG0yZkN3Y3Z3SGx6ckZ5WmRtZUs3UFV1TWhxRjM5?=
 =?utf-8?B?N2FuMVBjWWszN0s0M2FKdDhzVGpqWXp0L25CTGtYWU5SbDBDakh6RVhKSUVQ?=
 =?utf-8?B?VnZRY0hhVFBEclpqSTI4aXRxbEFWay9mMUVGdmFUejVGd01MeUtobG9KVUVz?=
 =?utf-8?B?YUpsUHR0NW1rQTFOL1IvSUFENnJWaENDV1FENWYxMUxjUk0zNFBUc2x5SlhH?=
 =?utf-8?B?NUZMdUtQOGhiWTA5Tk4ydWgvd2tORXlqMW1WQlBZQ1RVUG5VWC9jZ29Jdk1j?=
 =?utf-8?B?aS9JSmtUNC9kWXR0TWVKa1F0cExjY1ZIL0dXVjQ1SGpIVWp0dmtuS3hqSSt5?=
 =?utf-8?B?MkxnVVF3Ny9sOStHQW56WjdTNnNPeFg1cTJ4OEJkN3YySE5nWjZlMVlGU01y?=
 =?utf-8?B?TGJST1FsQis3UGFwUHpERW52V1R3aEtJVE8rY0hYY1JJWHhzb3FSK0Z3N21W?=
 =?utf-8?B?bDJ3Y2E2ZjZGQzBxMzlLdHZLdnBnTWgvdTNlZElOSHBKbUtSdXhQbnF5QXdk?=
 =?utf-8?B?bDF0eFBCTEVGU2d5QlpHZzNYdFBoQTZxZUZFWUptTUF0NG0vbWVzWTNIY25t?=
 =?utf-8?B?MC9TUDdDRENydVJ5TFV4SWxPcjhOd2FrZmZObWN3d2hjSE03QmY2UTZ3dk94?=
 =?utf-8?B?SHlHZ1VTMG5pckRvZTFyVmxlSlJLYm1saHZRTXJLODlNNDdXYXhFZUIzZVhM?=
 =?utf-8?B?cGdhVkIyeG5HeGNzUkwrMzlnMWVDN2JaVWQySzk0dlpFSXRuRWszVm0yMEZp?=
 =?utf-8?B?VWpjVW1WUFFodXNVa2tYSVgwTGxkalBlT1NrOWEyeHRNUWFZYVg1M2hBcHFO?=
 =?utf-8?Q?2Iv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2kvMUlielRUTmduNjJIQ0x5VnhGQS9adEZ0Z2xVTVBHMjhtMnV4eDN5Zlhz?=
 =?utf-8?B?a1pMQ0JPQlJMMWhPWnRuQW9xWS9GOTNUd0s0aVNsOGgwVlR6TEhTejF0Zzgz?=
 =?utf-8?B?TURGSHJYK1ZkMkM4Rnp5MVlFeVVybDNtSkVYRk96UHh2Y3Y4ZWVScFhCVkx5?=
 =?utf-8?B?QUlVUW5ZM095dVcwQkVITjdBRW1xcHRZWFBGUmthc2tqSkRVK01PK1I5OVZ1?=
 =?utf-8?B?L1NEY0UyOEdxNEVrNFRRN2o1dkJoRHEwK2pxYVVYbVUxWkdwZDhQd0RSVjVo?=
 =?utf-8?B?K3gxeDFmMG5ZUGhxZVdZTnA4dkFnMXBDblo0THRkRGVaNzJNWUh5a3orL0Qz?=
 =?utf-8?B?TS93TUJIT3B2YkxpK0pRSllSNGFrd0JMd25ZRVBuN0JqOUJraENPcGtFZE5k?=
 =?utf-8?B?QS9Kc2hmS0RucFh2TFNUSDBYTHRCNnNFazVwWUEreTNWbVBtODBFTi8yc2Zs?=
 =?utf-8?B?NHZEOGpnOG85YndJY0J6UXZ1VWdHTDB6YnAxUTFRcTd4R0Fuc1A5SEM1c20v?=
 =?utf-8?B?cXppM3VEaThrd2RnUGtCOEhlVHlLZ3JFWFF5eE4xMFQxQjRad3g3SllxLzJV?=
 =?utf-8?B?VWVlVTJCYTVwQ1FOdXpYcE1nRXZlcFRENUJVcGI3S1lxYkZkNm83b2l1bXdm?=
 =?utf-8?B?cUJ1NU84MWkrOWtiWEN0K0JhTGdPT1FBUWdVelYwSFdxUmRwSDJNR2FOUTho?=
 =?utf-8?B?L2dyK1JNd1o3YytwTk13OUpPdkthYjNVd2FOeXhqd29HSFRmd0dVZGgyQ0Yx?=
 =?utf-8?B?MUR3cytpc0xvVm5UcSs5NWRmeUMweHdaaFA1S0RMekxZLzJoR1Y5QkVvTzcr?=
 =?utf-8?B?c01mekZUK2Y5ZFhzWmZ2b3JPZlN0N2JndTY0KzRmT3dhanJoS1BlODI1emcz?=
 =?utf-8?B?dS8zU0h2cmUrM1RQYVpXTHlDSzh1RmNqRytlSjlUb25UbnhWQm9INHR3cnh2?=
 =?utf-8?B?WmhpQ0FHbnoxbVFpU1d0QnRZRzJ3L3ZMcjZSVHNsb2QwOTZURXVWTGpQYU16?=
 =?utf-8?B?SFRJemw2Y2RlNzZYdFJhbjZReU92elVqTFJjdXRnSnZ2YzJGaVJEV1pWK1RF?=
 =?utf-8?B?MnF6VjF3QWV1VXhrZUErejVxS0h4RWltNXdQVmVWeDk3TnpVa0t5bVIvTDRU?=
 =?utf-8?B?NEkwcTNRdUhPci9GVThaQ25TNDBJaFQrNTM3YTBmT0QvL3FtY1pSSldEYlNC?=
 =?utf-8?B?NzRRV0xpR2E0R3RvM2cyeDl4bFlLVEgyeFoxVlRpLzhlVmNvbWpwUW5RRTMx?=
 =?utf-8?B?RHppVTFXcys4TThBUlpLblVCTUM5Y3J5dk9td29kZ1JDYld0ZGN6Tzh0SEVw?=
 =?utf-8?B?czBFV3BOYklFdVZzRUxvM3M0T2NMRzltdC9KcDFuSlZmTzNocmJrcTVOWWVE?=
 =?utf-8?B?bmpzZ1ZhaWdWdmlwMmNCL3JxV1JJOTdOSzAzN1dmLzU2bmJuWThhckw5V2VF?=
 =?utf-8?B?a1h4bzRXTmxCbE5Ud2txSXZSTDdQVW41RU41ZTVmSldtcUZiK3pHdmZmV3Z2?=
 =?utf-8?B?c3BUcTVyWVJVQzlQN0pIQXpFcjlwRG9VTkFyWWhhOGRzNVVYNWRoYnZXdkRu?=
 =?utf-8?B?alV1bk5qa0IyQXd3UjA2Tmc2YmYxRTNOV3JNbVZyZCtGMGVycXh5Y1hpdDJ1?=
 =?utf-8?B?MllZOS94Z21CaTlTd0NudE5hdC9OaGQ3WFI5MjI2REhSWDY3cTBvWDZKMXh6?=
 =?utf-8?B?cGw0Yk1KZ24vV3N3aGh6SzF0WEZyQXVyc20rOUViNnI5dVlNc3BIc25WeExn?=
 =?utf-8?B?OUF2MU81ajBLQWtJNlJ4dGQ4VTd0N1RyRjNkMmdWQnBZNHRrbkNVMlNIUjd3?=
 =?utf-8?B?UEVoQjhNVld4aUc1clFKdzVTN0xoMnNFMmtxT3Y4S0p1UEdiaXRZMk5NWVJN?=
 =?utf-8?B?WkpGaTVUc2o3WXlXVHlXMFY4R2ZjZHdyWnBpMGkveCs5cmtjZXpTQzAwd2lW?=
 =?utf-8?B?OSt2RDZ0MCtHMXNnRkh5NHJRaFo3Z1ExWUFMeXlRcXNiQ0VNN0xMTTNURXRr?=
 =?utf-8?B?VmpMbHRjS3JaY2dkWFNPUkxHME9xaVhzNk8wRmZTUHdsNG9ncXVrRlpWZnVw?=
 =?utf-8?B?Z1JnVkNtdHhPclptOHlaZTRuMVpUbWNDNjVNaVBvUXlvY0t4UmNXZ3JJTGR3?=
 =?utf-8?B?eC85YVJCOTMxSEdhNXdoODZoOHZLQkNyajBFU29wZ01zZy9QSkV2WWNLQ0Ri?=
 =?utf-8?B?Z0xINk53UjlIMURCNDArZm94TGV4Q3Z4TEtQblVZdEJZZlhJM3VSZ0lVeEc2?=
 =?utf-8?B?Y2p0SUxkMGNpL1QwekZaT3lzRXBzemRGZkFHcVpQeCtIR1ZHbkYrS29NbFJV?=
 =?utf-8?B?T0pWbU00eFMxZXJTV1hSRDN3V3BIN0dPK1hGVnpRYXVYZFE0c1M0MUNwVk9j?=
 =?utf-8?Q?YeeMR96fWqUUg8QQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b623e6d-e478-4ede-105c-08de625325bc
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:03:58.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhzwO5+CWLZLqsiMgshmZ+yRMuxpdrwMrCB/dPsDciHwUrur4ANliXImUXdOEy554maE8qKhdEXtHJhyE4Wa/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9748

Hi,

On 02/02/2026 12:42, Nuno Sá wrote:
> On Fri, 2026-01-30 at 09:17 +0000, Tomas Melin wrote:
>> Add capability checks for operation with backends that do not necessarily
>> support full set of features, but are otherwise compatible with the device.
>> This ensures a fully functional device, but with limited capabilities.
...
>>  
>> @@ -1263,8 +1271,10 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
>>  	if (!st->chan_test)
>>  		return;
>>  
>> -	debugfs_create_file("calibration_table_dump", 0400, d, st,
>> -			    &ad9467_calib_table_fops);
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
>> +		debugfs_create_file("calibration_table_dump", 0400, d, st,
>> +				    &ad9467_calib_table_fops);
>> +	}
>>  
>>  	for (chan = 0; chan < st->info->num_channels; chan++) {
>>  		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
> 
> Change the permissions for in_voltage%u_test_mode so that is WO in case we can't
> IIO_BACKEND_CAP_CALIBRATION. You can even reuse the above check to tweak the permissions
> accordingly. Then no need to check for the capability in ad9467_chan_test_mode_read()

This RO would be then only for cases PN9, PN23. For the other attributes
RW would still be applicable. But basically I think the test modes in
the device are still available even if the backend status does not exist?

IMHO the current approach is slightly cleaner, as all the test modes the
device supports are available and no need to think about which ones have
RW/RO inside this function. Please let me know, in case you insist on
this kind of approach.

Thanks,
Tomas

