Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020143.outbound.protection.outlook.com [52.101.84.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122881B983F;
	Mon,  2 Feb 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037492; cv=fail; b=nB4Orf9KLNkdHDIBvUuMEm+/7epa+zUIiMx7GYhHcd1ktpShty01/Z/aOdjpkLr9sH2OL5ko3ZnhBt9p7h69NfWXYd+NTLY3gOancA2pS6/wD2BULI+zvi2lTXX4bD4BwrMm4BVfpeyNbMjIFdBB1cHMqUTbv+3J945Ye0g6Kso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037492; c=relaxed/simple;
	bh=74c+O9F5GEJMy2p5B2TDRUBCt3bA2E8wxhqYEava4C0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UsKn9DO37rlKr1kKn9aAeR3Gyt0Fhx/SzOcSpL9fEmHRgueikYtH/1QB8+X9zrAHWIYEIZgTsCW88IoFqMsBVP/QYfxGXrZ4jGYMEXRz5q76jJ7trcT90bHXetWMog8aTJuO07cv1vPX6QrNuLgfjrVPadpBNo/Ix/53dUCnJZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ud0N2IKx; arc=fail smtp.client-ip=52.101.84.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ud0N2IKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpEL0OQQEws1g5NkTQ2zVXV7x5NmE30aEQu4RIsLPdq66F9d1/6fJC7DxHohtxN9FeOdMRQPiTqBNlc6ettYiPV6iHuAoRfDYaMfg0goarDGuBh9nq3abhdCwqI3UnVO0x1FU//Fb0WRIuuj56yrujJqSRkEe7gOIZL31Z8XLZO+rUfc2aXBqv5S19Vg0oZ9tV7KheniCnNvH7+pFYxMBiRha9AO+HtKF6r8Cfx87UeG8mWA6LWojO5e6SVj2h260RWP/zutZJTeHn8Zoiq4uYlSbIH3960U/yt/nm76ENM0NAEpnXpjOOr1ChpXnm5JJMneBK18HX6hR/hCMdfC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKYMPN4NqOcqci7yh8wQgRt/IEWNdhodivlbjFFkwqw=;
 b=Ernhgh2P5ZTUlH61WNC9p7PXTPc55MsLgiMw7tY2hvtzr0Wnjypei94ml9k4sUAxnrTW82p8bZAS4smEXa76NT3I4Wn4GbGRUVu7P57OlgPvjK52c2/XtvxoGUiY/v2OLoj9rvkIXPKJiJRuLo2WAaQWRhzPFgX35hZSX96xhPZn8zONcriN7i/cVVc6M4QBTFkp1FzkDxxN2BE5B3x2dSCFH9+9FzHuA+WYY6xZaiu0yY55sYgBrXOCwNbX4a6xQ8TxiTPdqhkOeoQiR4E7BtiocOAM/wMhecY4m2aY52P+Eoa2QYyxWN7OCGA+fOiwM5LmCYcUBv+PO8iEuoa2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKYMPN4NqOcqci7yh8wQgRt/IEWNdhodivlbjFFkwqw=;
 b=ud0N2IKxJWfAaQi1fh6GbN2nJd3HejH3k50xha0KSwmmG2SA3L61JfNNPfnXdHYnvi2EhI9t3wv1m/migo+SHUSjIsbsqqRDO8iZyOXpKifHYSYr1TviuJSEJ2MopHw6CtNL0FsQ+Wq2xZLv/Z4E2GnDW6WC4ha9sgL+tMgleYftuIj9l13iI4iUTpCNNtWwzhByABB5y6QVLGI039lT8Uf4nT0yPsUkU1zfnvGvzj2lZ7NSO/AgszG4FMLLJByE6eF4/0SFTZe+NF1tIx2PQxfo6Bg0X6+B08mmO6wZRY0Z2Kfe5GiX92MqgEpgYXARYR9mGV2DlKkiJkgDGpKx8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB8839.eurprd06.prod.outlook.com (2603:10a6:20b:680::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 13:04:40 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:04:40 +0000
Message-ID: <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
Date: Mon, 2 Feb 2026 15:04:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
 <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
 <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0002394B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::34a) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS5PR06MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: d00b418c-b82b-4706-307c-08de625ba043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUhBZmpzVFJ6bUdrR3lmUXZxUTZEeVl4YnZjaHhzNXcwR2FqaE5kYThJUlFC?=
 =?utf-8?B?Vnl4Wm4wc1kxOUYyZFBHeklKaFNJaU9yU3VXRTdVclorY2hsbXdaT3JVK1l0?=
 =?utf-8?B?RmNnZmRSM21wd0I2VWtJRzNCaCtLNEprdW9PNE1LVGc5c2hPQktzdDduMnlu?=
 =?utf-8?B?YW83TVpYQmJwQjFJUCttWGNVZ1NwaFBxT2FrSDV3QnBYSzhMWjYyeld4L09a?=
 =?utf-8?B?WUZ4RFArM2lEUjRvUXNNQUNhNGdKc3ZJaDZYaThRdzEzb0NGcHZKTEtxS0Vt?=
 =?utf-8?B?NmNtVC9LK1NWSHNzSENvby9ZZ09aUk0rOWdxanl3VHRqOUhsY1ZrblY0NUN5?=
 =?utf-8?B?VldKWVNIYWJ3UDRkN05wUzJ5Y3NRZTQyTnpUMDlxQ1R3TkJXUSt0OE1LRy9P?=
 =?utf-8?B?VGFOSUQ1ZGV4c1hZNkZSdFMrNUtVdTBqMkg0QzBNNnZuWS9nTDdPY3VZNmpR?=
 =?utf-8?B?WC9mOERzdE52WFI3MUc4ZEpvVUJwZlQ3MmF0L09JZTVBVEdwdnYyTlFkOEZI?=
 =?utf-8?B?S2loekFHemgyQmp5ZmtEUk9PN1lMUlVIbWQySGtxcUlMVFlPVTVSQzdLQWt0?=
 =?utf-8?B?SGdqTEprYTU0VUxBdkZ2Zkk4QlJycjVDNEJ5b2xDT25haHlxb2tOVUh6V1Bi?=
 =?utf-8?B?aE0xZllyME5paTYwbDNuVHVPSlROKzBUc1FaVGR1Z1NibDF3K1U0UnFQTTJx?=
 =?utf-8?B?allJZUt6SEltdStXcnlCd3lSSmcyMTBzMmpmNHo4TExwYWtPTVhOVlBPTGFr?=
 =?utf-8?B?ZHVVY0dsYXZ4Rlh6TU5vQ1hPWjNzQ29KdlJHRURQcW41NFRNTVViVk9XOTRK?=
 =?utf-8?B?NUxIRW9BME0yVnZUWHZmVTFidVpTaDBMamJlQ3BIaWg3UWo0ZzFTMUNya01D?=
 =?utf-8?B?ZWpFa0dDdzYwNHlyTjI4ZE12L3d5RTNxdVFOKzBnSUp0YjJTMTE1ZHduT2Vp?=
 =?utf-8?B?dGJxSkZJRnhiWlk2dE1TVUdTcyt3N25raWxTUkViMDFmaUd6RG5OZTZzUERO?=
 =?utf-8?B?ajZLWnU4MFBUdHJMZG5FSWdwdkNKSlVhVUxZazZGUFZzMVdNN2VqUUtiUEs0?=
 =?utf-8?B?Z1orcHhEczVzSVI1NzNjQUxVZHBCWFJNMjQ5djlMdGtqTVdBcTdQbHAweUMv?=
 =?utf-8?B?ck8zbWxvRlVzK1ZFbksrbWhINUhCMXdwMi9yVFlXZVZsWjF2QUVJVW01NElH?=
 =?utf-8?B?ZmpHclp0WHd4bHh6RmZPYlJ5VXkrWUtGWVl6eldiN1ZEYzlRKy9qenlHVEY5?=
 =?utf-8?B?Y2NabjFacVNwTjd1VDFxQjRLYWM0a0pnMWZhd29qS1ZpakhkVVJZbysrMFQy?=
 =?utf-8?B?QXFJUWZHYUdvNVVtaGR5RWh0VTR2TENRZG5TT0doZkRGOGdwSUlMekhLTU41?=
 =?utf-8?B?UTFaeGVjTkZFbGxuRUlEQnVzUGhGbmFwY0gzSTZWb1ZVRXpEMitSSzZKNGYr?=
 =?utf-8?B?Z3RwdXVwTjVGb0hHRFE1V1lVK1BLdFQwVU8rWFVOUkNhaXVLYTZEVUZGT0lO?=
 =?utf-8?B?UWZiNW5IMnFYTHJHTElnNVdjU2FzalkvVjIreUYvVGhzcXVYSDVjUy9tSGFE?=
 =?utf-8?B?SmtvSVVqQk9HMmplelF6MzVKU3ZKYUVGQlJrRWNsOTJwUC8zYlZ6WU91UGJk?=
 =?utf-8?B?cUtKalh4dnZxQjIySkI0WldSWkVmNmNVY3dnaG82eFkrb1ovQXVnOHJGbHlh?=
 =?utf-8?B?ZGVvSjdEaHdiR1NZMWlaUjFQdlFYWmJFUG1LNVpSTEdNZzM1VXBDVXhvWnZD?=
 =?utf-8?B?NGwydVVMVjkwZnp2ZW55UkxDR1RZUTdQQ0hXQUFtbjJncnprNnh5amdIcStO?=
 =?utf-8?B?MVJ6dU9kVFRkK29pRUk3THh3L0Fnb2RHcnhmcmNZcU9Vb2h4REhjYjdlUzZr?=
 =?utf-8?B?WWVVdTNGVjRHTWVtZmluN2RJZGdxa2gzV3pGbTFFOENKdkZLQmMzT3dUWk5T?=
 =?utf-8?B?RFhaZGpvK1c1UzFINUZFcTRYUWJkR3d2RGI4NTlFcEpId2dKQytSbEJtRUJ1?=
 =?utf-8?B?eHhtaW1Wb1RoZ0Y1eXdwdmx5dFp6THpqdHZzb2didmRqNVZOOHlEbkdFb21P?=
 =?utf-8?B?UTRLNzhhN096bGhHZDR4eDluTk8wTW5tVEhFT0Uyc0o0ZmdNSmpicnlkVGFk?=
 =?utf-8?Q?LF+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGd0QmtENnJwbDlwdG15T1BBYm56VURhNEVCaDEzdHVqZTk4bTRsb05OUGtw?=
 =?utf-8?B?bzY1a1AyckE5U3M5eWpaYk4xZzhaNnJsS1pCeW5zbFcvbEFCVVZoSXQrakVm?=
 =?utf-8?B?aDZzOHhBWnMzVlRvQ0h4blhZZWE2eCtOampya1JvTXRhQm9JYU94NExNbUxH?=
 =?utf-8?B?TmptUW10K3MzUGRHTkp0a2xDZElQMXVFTXBBL3dnd3pWU0MvU1QwaHY0aWFU?=
 =?utf-8?B?WVZtbzQ3WVJzTWhyczdtTmJqaDUySzJEWjZSSkcwaUkwR3YrQndXNWFkZURa?=
 =?utf-8?B?cVhBa0ZyWFNCR2RMRmswVk1kVmZJOHZnQkw2Rnk2dGszYUR1QlRmUENhQm1l?=
 =?utf-8?B?Mlk3dmNpUm1LS2twR2Q5eVpTOGYrSnlqK0JGRks2RmNScFYySHZSSTI3TGty?=
 =?utf-8?B?MUlIN2IwbWcxOW5FdEpiYmJoYzZYdkh6NHVWZjZqQ0VnZkx1TC93dWRFUUFl?=
 =?utf-8?B?OGdXV2VmUldUV0NtSEpCczN2SldaczFGZHJ3QUlkNG02RHl6NW9QVzl6N0xV?=
 =?utf-8?B?eGxmL3huSjNUektrTmQ4VVhJTkVXWDBhWTVRVzZnNUpySk5wMVRaNlNCYXRP?=
 =?utf-8?B?eHk5T0ZTcjd5Q3RXZ2JtalZvb3I3QkRrenhDNkd3M0t2V3lBN1pqdkVGcHo3?=
 =?utf-8?B?Q1RwYVQwL2ZRdmhtQ0NpZVkvRjh0N2hyem5EVWl2TVMxbmExa2hEZzRRMjYx?=
 =?utf-8?B?RnlSQ3dtZTY4YXoyWUNpTkFjVitQMjZhem1SdW1ESHhCanVJOVZlUTJFa0JY?=
 =?utf-8?B?ekpxZnhOakxBcVltcHN1cE53NjhnN3phc0NKVm0yNzJENzFqOXRBOWxOUUow?=
 =?utf-8?B?Rmk0MzQ5QWJZQ3d6bHcwNFFMT0UyNVJ4MzErRGxRaTdPaEZhMy9UMnlqL0o0?=
 =?utf-8?B?QW54WkVXRi95UFFUdzJ4cVd6TXlKRnpLaXo4NE5HT0QvdG9Cd2FJRWtXWUFY?=
 =?utf-8?B?MTJSQmNza0dkM0ovai84Rk4wS0QxNWJnSEFEci9WT1JqU0w4RWdnNHJYbjdX?=
 =?utf-8?B?N2VyaTRUWXVTNmJLZUh1RHo1ZnB4MkdLakZ1RXA1dnVKdnNucHFCcXdIeDJv?=
 =?utf-8?B?R0diNWFBV05Zeis0WUxSeldOYmllTmRiRFFIQ2E0ZjlSZmhCZSsrTk41YTZr?=
 =?utf-8?B?SFQwUVFxMElmVUh6Smc3bXN5aUIwaytXQjBHQm5aUkx4eTU0Q1VNakhmTVF0?=
 =?utf-8?B?L1ViYkptYnhYTyszTzhMWXRoOXZXRzdTNzE3SlFtZGxrMDU3aGVLMmpSeDA4?=
 =?utf-8?B?VitGTitKYzlHcldSVGh1emZhNXpUekxsUDhNQ1dJMkdub3pLS3FIcWt5SEor?=
 =?utf-8?B?NHRvU05tbmRMWXA3cExiMFN3Q2FWUEs0Q05qOFdhTzhuYWhZU3drOXFmRHNR?=
 =?utf-8?B?UGllMEpDUDBIS3NmeU9FZlM1MzIvdG1PQndXcWFzVFg2YjNRZXpLdTZCemlz?=
 =?utf-8?B?bEJWc0RrOWlVMzR0UGVOSjlMVFNLWUVmVExYVHBBQW5JM1daOENJYW9MQUE3?=
 =?utf-8?B?RHYreE9INzBVcG9aQlJjd3M5UkEyWWY2OTNlMjVoN2JMaVBKUEFGS1cxMHp4?=
 =?utf-8?B?anpDckxqbXEvSFpQWHUvRmpCb09sNXZlRTFMMFZrdi84aldMSkVOaVJmdU92?=
 =?utf-8?B?cmJVeUR3dzhaakwvVEdHaG9UWnpWTVdCOU9uOW5nY2JocEcrazlTUDhtTElm?=
 =?utf-8?B?Ky9OYlN5M3lnZmdMcTdidW02TE0vYTNBQ3dHaStpWGdEWTkwa3dpWFV3cVBH?=
 =?utf-8?B?NlJNY0ZyV0dRS29WUGlFbDlsVFJhd29yL0JwcUcyc0l1ajF6YjBTVDhEUVlB?=
 =?utf-8?B?UEZRNjE1UHZBZVhUQXNmMm1qdFRZaGV0aFRjTmVseSttOXJwdFFoOXgwNHl1?=
 =?utf-8?B?UVduaU1CUitwdGg5U2RyNWtUYW1XQkNFTHZGWG83Rk5qQUdYSG9SeU9YYnJs?=
 =?utf-8?B?S2lTMmVLWW5ZcGZXaFIrRWkraUNPYXlUaUNZRXVxSjMwK1JBZ2ZnaWVvdFUw?=
 =?utf-8?B?M0ttTVVpMHp0V002ZG8zZHU0YURlT1NVYlRwS0dzdjRmY04rZmdqOWZSSXdU?=
 =?utf-8?B?R1E4dTFzWWhkS2V0LzNlY3ZOam5kVUlXNWpEbjY2WDB5MEpxZG5VU3dKZlB3?=
 =?utf-8?B?MGtEOGVIYW54c3BuOTlydHkyMHFMUG5FWFZ4RUpOdG5MRk0yS1JPeGdURjB0?=
 =?utf-8?B?UVl1WnkxVXd2aXpmWEVOWElrQXpxUmZDSE0zMSt2VHZKbWFxZHhIZ2xvellD?=
 =?utf-8?B?dnRzN0k3QksybDJxUER3SnJoSkZ1dzlKWVZiY3UzY0FwaWl0d283aXg2bldx?=
 =?utf-8?B?YzY1S0pTbHZUUDBhS0VmL3FDd2U2SExvelRadTNOczlzR0FYNDRJSFNJNjBp?=
 =?utf-8?Q?Jju9yPUW9Cj/tuMQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00b418c-b82b-4706-307c-08de625ba043
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:04:40.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja+9XRa/wEGXp87KIZYSLye3pozBmn/KPUGSVaoxOitP9DIMvo7nUO/ok0F4hiPm+BuLaw28Y0xfxnD7fnpEZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8839

Hi,

On 02/02/2026 14:40, Nuno Sá wrote:
> On Mon, 2026-02-02 at 13:08 +0200, Tomas Melin wrote:
>> Hi,
>>
>> On 02/02/2026 12:28, Nuno Sá wrote:
>>> On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
>>
>>>>
>>>> Do we actually need this one? Alternative could be, for example:
>>>>
>>>> int iio_backend_enable(struct iio_backend *back)
>>>> {
>>>> 	int ret;
>>>>
>>>> 	ret = iio_backend_op_call(back, enable);
>>>> 	
>>>> 	return ret == -EOPNOTSUPP ? 0 : ret;
>>>> }
>>>
>>> I would prefer not to assume we can ignore the backend not supporting
>>> the call. It opens up the question for other operations.
>>>
>>> My preferred way for this kind of fundamental operation (enabling/disabling)
>>> would be to check with DT maintainers if we could have some kind of fixed-backend
>>> (fixed in the sense the HW is present but not controlled by Linux) dummy device that
>>> with implement a no-OP enable/disable().
>>
>> There is also use cases for the always_on cap with a configurable
>> non-dummy backend. Some applications are such that the driver should
>> leave the enabling/disabling up to the user space consuming the data.
>> For this case it's great to have the frontend leave the backend enable
>> alone using this capability.
>>
> 
> I would argue the above would be something to take care at the frontend level. The way
> I see it, the always_on cap is pretty much saying that we can't really control the on/off state
> of the backing device and we just assume it's on. 
> 
> If we can control it but we need it always on (for some specific usecase), I would say that should
> be handled at the frontend and just enable the backend once. Also note that as of now, I think all
> of the users (or most at least) we have just enable the backend during probe and leave it on until
> we unbind the device.

Yes, this is debatable. It's not necessarily always on, but should not
be enabled/touched by the frontend during probe.
But anyways, having a capability that says if the enable/disable feature
is available, is in any case useful and what I was planning on
leveraging in my use case.
Fundamentally, with the capabilites as now proposed, it is possible to
select what features of the ad9467 are available, in addition to the
basic requirements.

The ALWAYS_ON capability could be inverted, like CAP_HAS_ENABLE_DISABLE,
but to me, the ALWAYS_ON naming still seems the better option.

Thanks,
Tomas


> 
> - Nuno Sá
> 
> 

