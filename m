Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021142.outbound.protection.outlook.com [40.107.130.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51C23EA99;
	Mon,  2 Feb 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030033; cv=fail; b=HjyFOYFiy0R0ZvPmgdHp4A0mV1Ji2DdrxoCSBI9LHKWDyBPcdj7wy3C9RZ0Pi4bbV8PKZZzDlYC3k1f4uC4iQ4bFg9BS4F7jeGe68RNo8ukB+lxjiCidV8jvYHYZ1TthGtvxcoGj/pVt/4bPc70f7y79KO3uWBzfvys932zMxno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030033; c=relaxed/simple;
	bh=h0vn3HbfaaabfCI/3hZMwoiaz0VQF0JQIGxcRiGVOSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cRQ27sgY9Oicm8OZC3QeKSImRlsiO3p5M0LZgwsbKgIfKSEw0vAfojy+zcBLpCBRtuwXfuwiJMNkZjZINaRr7NzqYRkUm6pzqU1OqhDXpqjwdi14tOI/qR3VFSvBZY5Q9mUZw7w/krMadFg7+WGtHWNzQr4372FRehR165rKPNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=16KqvwON; arc=fail smtp.client-ip=40.107.130.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="16KqvwON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv7MMXcG+OwwXVPFL6U+oTSdxauwIpr3vBGugXS7SVm153hbNCFRfurscaSyaSMIYHp6Xe10NFPaUOL3csj808crLpBbjR8lK3nU6QddfxwLtZ1WO98N8vl0JaXt3i3Ggp2D9vBRuHlG6M5rSu2UwtXV9fcCnd14QMA93/fLTEpGsMrmkb9BFX7BdiVcQDiHMjs/Emf0det39SuwAYovLjWygBjVA1SyFRrYXOV8ttudM7SuaOg28mkxyEi6zrZSF0OVZ+Z8o0qHtoUnkt67LROc7DQ0SD5o716ViLfvp3+zwi0fZ8UhMwUcpk7IMSzfhfqxuBb27z11xnLjvjwLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExuIoO/Q3l1V/lmDhuRP1w1XWfzyuqkDTfDFHFATqDg=;
 b=rAGSj8trKwup+ejkkm3t1jlLThlQuTf01Hd+nUGIAWJ6pZg5R1wxZ3B3t4NeuRu+EXkswgW1OkgbSMOrO9aQYL8CBggWN84nyedF8vE0zLBguIpX2smVmiILIhTd4xv6gjq57l44R+zwUAccjBWyZRhS8BDtFMC/+Po5BqMgF3mSl9LnZV7J3UCCk5YrXu+/Q8AR5QowcCwjmaU2kab+8Rf19bav5jJJvM9qdec/QfAhPFpCAgZ8gdevWb0KRRijPWhc8/i8z31+peQgEq3Q61Peuzrdxw4k3OCQk0H3tnye3sDWJhlD/6rxS4OD8c2/K/2Xxyf7WCUSzYqfu1zOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExuIoO/Q3l1V/lmDhuRP1w1XWfzyuqkDTfDFHFATqDg=;
 b=16KqvwONP8sB2ciGHBm2vB07yp1z9e/WUPf6Bwxp4tixU+W802crFdtrXTQgLWpitFQc1grMDXNnoz9MV4XexCEiTd3uKfn3ojopoy/ILBNu0YZ40C/FUh3qOXiB4cyGzVcJCWnI7mnhG+TDdk+YDMIBRg6lUQM930Xt3C4OZ2oLFnvhb4xGd8F9wJKqKE3r5lbjAHiNHfn/hs+UlydyoeA3jIQse4yJSxIrcI80V9tWmi8EVN1JwkSj/E26O7IQplZ18g676CP2XHwTj5ZuznQCf6cOwb2018XoUS6TZs4u11qzks4qwszCzxAqnV1iDQJ3Hfx1BkJnFTvthBgbWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 11:00:22 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 11:00:22 +0000
Message-ID: <2b49eacb-c375-4b01-8cc1-325fb743daf6@vaisala.com>
Date: Mon, 2 Feb 2026 12:58:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00023A12.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::20a) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8a6c41-949b-4cdc-e8d3-08de624a42d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enJZOXNvOUJzWXh0dmFBZGsxV2ZDZU9VdHJYQnUrUDVITDFrbVZ1elpkYjI4?=
 =?utf-8?B?Y2NHR3RXYlZzSlEwcTNhZEozNllVV1AzcGx2dnNvcnVaNkVVazNNckRVMlA5?=
 =?utf-8?B?ejFNN3lTbGpHbmd3RzlUdEU5OUx1cnk3NG5ucysvdGZLTmI3dEdTUUtZRVR3?=
 =?utf-8?B?WU9ldTJDQm1VMW9TYVRxNHo3ZURoRkt1YnZoUlBYbVNSMUFaMExBSklsQ2NT?=
 =?utf-8?B?d3JwK2lqaXEyaWFnY3crbGEvOWlQN2xnazdTeUtKYitPajRuVnZCd3QxWG9F?=
 =?utf-8?B?MGp2Wk9GRjlaeEMwckJwNkIvSno2aytaQkNvQXE4TnZvWEdtWTljSzVsN2lW?=
 =?utf-8?B?ZUVmRFpXTC9PUFovUHlGMFo0K2J6Y2tuOGwwWnYrUEhBZ0l6TmU1b0VjNXFa?=
 =?utf-8?B?c1NnOWNxL1pKUTJqWXRmVVo4RWNWQ2NVbkVRWi8yWTM1Z0FmUWpKS2lENFR1?=
 =?utf-8?B?V1hJaVZoaU9QRUFjNHZFazZUUnFtZlFxdFZrOXMwbVVjZ2VEZ2tnaVd1TU9E?=
 =?utf-8?B?UlBlaGpPZjNGUHJtK2dJeTJWZEd3dUNtN2pabXpTTWZOZHh4VHBYb0tMMW55?=
 =?utf-8?B?YlZLQVBsSkQydzhXWjd6ZjVjWWdGWnJWVTQwSVR4VDdvYmc1cTJwZ2tkQWp2?=
 =?utf-8?B?aWQzeWlMZHViMUN6alBobk02eEFNazBTa0lwRTJrejI1bU5JM0pjajRadlQ2?=
 =?utf-8?B?MkV0NW1wRE41OWdOd0pNSFA0T0lPRGxIQTk1UkRYOWVqYmlZWUwzNG9ueEll?=
 =?utf-8?B?ek1sNTAxd1dIeTRlbCs1UE9iWHhDTE1kNk43K3FMNkJ1blMrV3phS0IvTWl2?=
 =?utf-8?B?OGYyQ0tUUXRHRHI4R3A1VlRVcXlReHQzSVBPN05ITERWK000WlVoMHpFSkhT?=
 =?utf-8?B?WlJWV2piTzZYRk16emx1WG9nWDJ4WTlxUjByU20yZEduZE5FeEZjSng5VmFm?=
 =?utf-8?B?aDVTUTc3Ymt2VlB0NGx0WmQzbEpGTkVNYTgwc3FQbGFIYVpRdENGdVJjS2xR?=
 =?utf-8?B?eHJNWUNNWUJvSHluMmJSODRLS1dsSVN5YTl1b0lZQ1BXZlQzYUQrdjIrM2tR?=
 =?utf-8?B?MnhKVzJJS1J4bnc0WWpFcW10bms0STVvWXViK1FEdlNYV0lKVStMb3U5Zkd6?=
 =?utf-8?B?a2Z0VnhqQUJKV0h1WnVTUHZxL1NoTnZTQW9oMVNWdVRwWm1QcVRrSjFEMmVh?=
 =?utf-8?B?L3I0cHNCWUlkalZ3cHhSaFQ5UVNBQnRZZXFjOTZNdFJJekhhVFJ6cWhJS3lX?=
 =?utf-8?B?MVkwUDZXZ1M0TWpQVVNZR0dmM002RVA4Y0lRbmtiMUJkRVJXblVGUmlPdlFO?=
 =?utf-8?B?RXBrWitIdlFqa2h3OGlPTW9EVEE3eHFLamorY3l1U3ppYnpPQUp0OFFSNTYw?=
 =?utf-8?B?eHhIcnBHaVd5ZWEvSG1iWTMxRlZoNHZ5b2tFa2N1WkQrZXV4Rm5pakdzUEtG?=
 =?utf-8?B?U2t3S1RVZFhkTDBTT0NWNW9iNEE0UEF6Q3ptKy9HVCs1czhvbEVwdExEc1JV?=
 =?utf-8?B?d2Z1MEY4V1FObnRlams5QllpQXg3dnQwUUVIZkJFWm1kWFdxcndvQkpzd21W?=
 =?utf-8?B?c3BDbTFCUVljWnRGL2h1eWtFMzZXSmJSTlFKdm5TN0FOWWNwejNiVjRaa0F0?=
 =?utf-8?B?WUNOSWgrcDZoWG9wd0YybG1na3NJTmVGd29NbTE3aE04OVFtbVN6enVNVVBX?=
 =?utf-8?B?RnZ3WjZwVFQxYURtUlN5WmRjbGdYU1hXeGE4cXBXSDUrUFZ6Y1VGeE9kcy9Q?=
 =?utf-8?B?R0t2a0wrOEJCZ0o0L3Vjd3ZKS2ljQXpJanN4ZURxektnMWt1RzB2WnZpUjZK?=
 =?utf-8?B?WWMxUlZkc2JNQ3BFQjE2RHl1VWRDNTZlazVzblo2OUF4a095cFdiUWZ1YThm?=
 =?utf-8?B?Q09ncXQwbGg3QVJwUVRjN3N3NEtIT3h1Z1U5K2xNUWNtcTRSN3cvVU1LVXk4?=
 =?utf-8?B?VEhXWlFVWDkvKzhKelg1aVVhVlVmMlJuYkpPeWk4eDZZWml0SisvYUdVWWlM?=
 =?utf-8?B?VzBkRlg5U05tLzMyM3VRRlJKM050bGFGaVBtMCtsMVhhaU1mODZVc2hwd25G?=
 =?utf-8?B?MTRBUi9nVVpLUjMwdmEzblNHaHBZdXVRMWNiN2cva1oxekliU01PY21tMDgv?=
 =?utf-8?Q?vG5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmNERVdpTk5kb05YUXJCWFRrZUJZSU1GNTVXeDRsZExWZE9lWVRrNG5Wckt4?=
 =?utf-8?B?MThzNDF3TnJsakZXUEtDdUV5Nmx3Wk9Cc1dkV00yZG0xSThnL0ZPekwvVll4?=
 =?utf-8?B?MER3V0FIZDRpdmxRYmV6ZTEwdU5kN3BJTEpwaHJMRlFwUXJZMG5nVjJ3ekQv?=
 =?utf-8?B?ajYzeTlvK1FPZEN0ci9ML013aC80YmlYcEdGekVhdWFQUnVQOWVXUk9Jbm9M?=
 =?utf-8?B?NXJyMytJR25hMk9NdGxRK2dYMElxNFl3LzFyRlVLUHlkUlgyS2hraDEzRlE2?=
 =?utf-8?B?YnpYeGpHTllhRWFhSGU4NDJPM3FjOEw4ZDNPWGFzVlgwWFBzcFk3UFpsY3hM?=
 =?utf-8?B?aENvcmg1T2NHMDN1aWI4NGx1VnNIbFU2K1B4cUNRTTEvSHJqNzRFdTN2OTNO?=
 =?utf-8?B?SndxdFgxNnlzWUpVbnNIbU1xMGFZRHpxeUJDdUVneHFvN3JHVWI0SkRlakNT?=
 =?utf-8?B?Q3Y1YWtwVmhZSWp2SjNOQkljVCtiMG03NjJQMlk5L2dpQmlsMWdES01RTWRh?=
 =?utf-8?B?cGhFSnpmK2o3SE5NRmZob3lnWXBVYytjcWFxbUZKOFY3UkVSZW11dnVlMVRi?=
 =?utf-8?B?citXTXBwUEVNdWVVRmNHY3hQUWpidGZvRFkwM2tuM2NLVzZnbWtjRHBOMi9x?=
 =?utf-8?B?WlY0UXN2TXhzajhhYWVWdElSbFdDYmVhVjYvY2hJcVExdkFoTXZpNU56dWdI?=
 =?utf-8?B?OEFmVm5vcGc4NHd1cXNEUmZGN1l1cmRJOC8rSzZ5Rnh4Z0VuWG9zSkJnbDFD?=
 =?utf-8?B?bEVTWTAySjNpWjRsdE5BSjY3WGJmak5sQzdPa3JYZHNQQzFHWHh4WmpiUWYv?=
 =?utf-8?B?R2VubEN4cFUzMFpNTVh2dURvQkxudzhnMUQ3YUg4cEdYQ1ErTXJHbzJaUHRD?=
 =?utf-8?B?eWRvaC84N2I5M05FdCtlWWNMRVZsSys3allMbWo3am5iU2xBZE1LLzRkQUdu?=
 =?utf-8?B?L0JLb055TnlySy9MeUZWM3FiUXdZZG5XZUFXanprQ3NIbCtoZmRCZlRRby9l?=
 =?utf-8?B?d256aW03eDh1Wk5GR01qYitEWGdqQjVuZ2FUSkJzNzF3SUNlWTRNMHEvNjJL?=
 =?utf-8?B?Y3lPSHFUR3hlckk5RTdtT01ReTlNZzZCLzZhekxUdGp3VkNBODdVbEpiMnJW?=
 =?utf-8?B?Q2wxWHlnbmxpQnpkbzFoTys2Q2dqRm1BVzNmemtkVlFKZHpVS3R5UXhXQzBR?=
 =?utf-8?B?aENOaTJ5MXVZT0NGSnNkWmgzdEdBS0JlRCswQWp2bTg3YTVmblBLRGpGelA1?=
 =?utf-8?B?M1F3ZE1iVEIzNUkrQXlSU1dXVzVFc05zaGxJR1BkbDFmRERka0orUjJtbFJB?=
 =?utf-8?B?QldVWkgwa1pnREJYY0xmcTZGWnFWWGgrU1lZY1drd3lxZlFGaGJuUjBvSmpi?=
 =?utf-8?B?bElBWndWSFg2RDFlZ1MrL3FGbEFLRm9mb255R2JVQVg2ZnB4bzJkelU4TzMx?=
 =?utf-8?B?V1dJQVpBVXFLUGRNcEtVOG9GN0ZtUERlNUtHU29ROGJWRmM5dmRCTkRBMEpR?=
 =?utf-8?B?eDJoOS9aUUd3VWk0ZkJKZG9RUXZZZ3dnczlEM2hmUWZVZmFCTXJhUUZucGRl?=
 =?utf-8?B?Mk9hUkhGYy9Bd2ZKbVhZaWRTWDZOZWc3Rk9kWFg4K002SnErQnloNW5jbS9p?=
 =?utf-8?B?cUtVYUE3SSs1c0N0RjEvMmQreGJKNUhCOTAzVUpiaExuT3UvQUM2NmNFcE5K?=
 =?utf-8?B?MElXS09GTXJTa2g2ekNHamtHSUpDRjk0QzJvc1Q4SHpCZjlLYkRDblpxRER6?=
 =?utf-8?B?OWtYODRTZFhjRWRoZzRvamc5dHRFYzY2bHNqeHhyK2JxWmpsVUgveWU2TnBm?=
 =?utf-8?B?VXJLcy9VZmNnYlV6TXg4cGl2OEVaZFdwa0NsSm9DYUZ0dk5zb2ZldUIyZ0tR?=
 =?utf-8?B?U1NmNkZtUTlkc0dYNmlOWERSd2Q4clFZbWw2YVA0YTR1RnZkOTBBL2cxWmly?=
 =?utf-8?B?dzhJK1FvS3lNZmFIMklsWHg0dDE1UGhUbWRSa3NaMk1qT0RKMXZrTVY4U09z?=
 =?utf-8?B?cElPVmF6dXhYeDZzZXJra2hWeHNxdGc1OGh2NHpkNkg4YVg0ZU5hc0N4UjhP?=
 =?utf-8?B?UmYzT2U3YTZKd1RFV2Zoczd0bW5YUCtqQk5nSGhydkpFZHFlMDZoMFVsb2d4?=
 =?utf-8?B?UjNaNGhxRnBCV1hOK1FnRmRTNEJGY2FKbU5sK1pYSjJueG8yY28xK0JsTyty?=
 =?utf-8?B?UjFvb21PM0I3WU9IYXpCekdwN09sK21XbWhwVGsyMEV5RzBCTVhGbmFrcU1t?=
 =?utf-8?B?TE9jRWs4TUtEMmp4SEJpRVlNaU51bjhZWkR0WVRzc2c1SUV3WS9hT1EvRVN0?=
 =?utf-8?B?VlFCbXN3b3dKZGp1V3lsZDJNZHFYVWdnaUM0SndVWVJNQllXTWlGTmhQalZl?=
 =?utf-8?Q?G27P7I8KP1HBpRVg=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8a6c41-949b-4cdc-e8d3-08de624a42d2
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 11:00:22.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8Yx7XQ5kp7jQC2Mo3lUdS4iLhIDnyUSwg/Mhhbdz29DjssHUYzK0UDww/v7+PacaDBFxfyN/AJ1WhEtmMF4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

Hi,

On 31/01/2026 22:30, David Lechner wrote:
> On 1/30/26 3:16 AM, Tomas Melin wrote:
>> Not all backends support the full set of capabilities provided by the
>> industrialio-backend framework. Capability bits can be used in frontends
>> and backends for checking for a certain feature set, or if using
>> related functions can be expected to fail.
>>
>> Capability bits should be set by a compatible backend and provided when
>> registering the backend.
>>
> 
> ...
> 
>> +/**
>> + * enum iio_backend_capabilities - Backend capabilities
>> + * Backend capabilities can be used by frontends to check if a given
>> + * functionality is supported by the backend. This is useful for frontend
>> + * devices which are expected to work with alternative backend
>> + * implementations. Capabilities are loosely coupled with operations,
>> + * meaning that a capability requires certain operations to be implemented
>> + * by the backend. A capability might be mapped to a single operation or
>> + * multiple operations.
> 
> It would be helpful to list these operations explicitly for each
> enum member.

This has been discussed, the mapping might depend on the use case, i.e.
the combination of backend-frontend. For example the calibration might
be implemented in several ways depending on the device. Writing out the
mapping here would create problems for that kind of situations.
> 
>> + *
>> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
>> + * calibration. Calibration procedure is device specific.
>> + * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.
> 
> I assume this means it supports devm_iio_backend_request_buffer()?
> 
> In IIO, we usually say "buffer" and rarely "buffering" so this name and
> description is a bit confusing to me.

Sure, would this mean that name and comment should be?
IIO_BACKEND_CAP_BUFFER: Backend has support for buffers

> 
>> + * @IIO_BACKEND_CAP_ALWAYS_ON: Backend does not need to be explicitly
>> + * enabled/disabled. It is always on.
> 
> Do we actually need this one? Alternative could be, for example:
> 
> int iio_backend_enable(struct iio_backend *back)
> {
> 	int ret;
> 
> 	ret = iio_backend_op_call(back, enable);
> 	
> 	return ret == -EOPNOTSUPP ? 0 : ret;
> }
> 
> Or make a iio_backend_optional_op_call() macro.
> 
> Or if there is some other nuance where this capability makes a
> difference, it should be explained in more detail.
One version in this series had that kind of approach where a single
capability mapping instead was shorted to check for EOPNOTSUPP, but it
was deemed better to have capability for everything needed and not in a
mixed fashion.


Thanks,
Tomas

> 
> 
>> + */
>> +enum iio_backend_capabilities {
> 
> Documenting members like this works too (saves a bit of cross-referencing).
> 
> 	/** @IIO_BACKEND_CAP_CALIBRATION: ... */
>> +	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
>> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
>> +	IIO_BACKEND_CAP_ALWAYS_ON = BIT(2),
>> +};

