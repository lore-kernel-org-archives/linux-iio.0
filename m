Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792845113;
	b=iKP+6LZNQ11aCzdqZmv3n4brp8qu0uxJywDU3uMsnP9c041vG6uGxjb9MllHsB5pAMpF
	 zS7JYSTodbdnOob265vNlRZE6j5HmcqlZhNVohKktI8UHQLNLrgST5lf0quPIq0NkPcC5
	 yM6QulCOzEN4VVJyzYau+xlBErANo/HeFy/DJpd032yL7/uV6hU6hSblT7AxhNEKndi1i
	 GE+N4l1btQkGcz9CWf3Sod6xa6/3cAIMWVXYSp+OWUIJ7OapnjoYobCF0Zmrg2QEtbE4q
	 HxM6150Z42Xzqb6onWv67H/DzuEp+6iDZg3VFs2zWJ2OYngr5fhNVhWtXcHuQglxabA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792845113;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=REqOeJQ3a+44gOCJjCINozK9snB9Y4U/VRc74h6CImw=;
	b=k7dj1N6BgGAEp8OO/nmp9q+PDh9kkGCUUJJ/Aq3nwVm6iCcJ0vG5oPwg84IOSxHTy0qq
	 JgmwLF8CNlE6dvhEBQH//jTEQGR8fJrqbFj9Fan1cNpyV+5fw3+dQc7rBfqeiCScE/xxX
	 aNikjiVD9WUwOA0+ply7jyxUePeIXv7nTCW9N9dxDY6eMnq1TZ6JDyZU6qLdSX1pc37VP
	 QHKDSY5Kck7g+5oMz8djjOy+qned1enR1Z6EzUyFrzStTPWAIYP7utxNfThQ4hDbH3GNk
	 b0VRWG5nHW4/gRE4uTDW7LmLP7xCSEdpHXR3fb2dEm5hdZjq0tsvOMdRkV6F6ZEXrTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fjxMq268;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.30
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BC606A31A;
	Sat, 24 Oct 2026 12:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fjxMq268
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at3usBKs6kbrRI45Qq3WWIbPHuMTjb7RBjcggMJw2oi0CiI9DCYfSouBYCX8S+k5hSC3ZgRl5/rxB2ENsnka/9kGeANtzIxX6iw8/AE9fqGCJxSGWARUBfkLRb3KPNaXCXl1MKiypI2s5hnxufw1NGEU2n1bgUEFmJI5r/QhDb42ijsSHJye7AW1tHLn1q+nNWCUhpzKCSdHbCX37YhhAZJ/XEOQ7iHt2S2dr2bdKIgTDCT583LT80f50cNL9ut845Xv9Hf0XsNKi+5GWDNA0GpbzwZquYjSO9apXVS+gUunsiKIRDwJUftuigEI1BCYMJuQ3CG+bi2VCjerN9Vllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REqOeJQ3a+44gOCJjCINozK9snB9Y4U/VRc74h6CImw=;
 b=NmsaYC2al+jcM2IeownjD3BFTkFutTSOM8pf62dwSiiKqIMNDDxV8M6VThYxkZSBbbdqb4kOTUNnwFdg/vNvjm7aZ483wuh4Q7RxLwIK/mA0JT17yuZ65K8fS1CXKbMFrvbfk/0K1aBwrp4P9e9zCICi6rpXzMpK04fL/Qs/R4D06BL8mkNLtrSE8p5uBhOnRwpzUcaZtWIeBj9Y7Ev+9h0O5+P5JuTpD2aPT5AGtiafHOGQf4vLiivCZMbZbRKPeKpd9B5wyd3UoQkk6CACpirP93TssZXWiO63jSsPdX4jbJm6uAAzlu5fVI2/Avip/W0fO6o1H0auFk9huE5tDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REqOeJQ3a+44gOCJjCINozK9snB9Y4U/VRc74h6CImw=;
 b=fjxMq268ORT3QG5RsrMKqvPkIQv1bEMt0YV+C3p8M1PZq1DK8OM5vuICuw/hL08ICjH+Lkmt4AKcB2rt7dY+resZvoprqhWRXHtU1oBypm99bUAjw2F35ZMqM2lMvsF7Ri8+Cjh5s+vn7VwusvYnzBGmX1Ce7gw8JhhC+SN0iJY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Sat, 24 Oct
 2026 12:31:48 +0000
Received: from CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8]) by CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8%6]) with mapi id 15.21.0546.012; Sat, 24 Oct 2026
 12:31:48 +0000
Message-ID: <a90324cc-6d37-4cd2-b910-32a286e89d36@amd.com>
Date: Sat, 24 Oct 2026 18:01:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] iio: adc: xilinx-xadc: Add I2C interface support
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Conall O'Griofa
 <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
 <20261005094205.1045874-16-dileepkumar.nagavarapu@amd.com>
 <20261019003537.617423a8@jic23-hlaptop>
Content-Language: en-US
From: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
In-Reply-To: <20261019003537.617423a8@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0239.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::15) To CY1PR12MB9559.namprd12.prod.outlook.com
 (2603:10b6:930:fd::14)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9559:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: dc905872-dd0d-41e6-a8dc-08df31cac5c3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261022075727099003|261022105027099003|261021121427099003|261009223027099003|56012099006|4143699003|3023799007|10067099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PhCDLISTOiARjltQ26w9/h4nJ2P5pWzwXODvAarmdt+8jbSG2E/PKMeW5Iyd6D2NU3f+BtQUSCdkdmeuUk0oECBGxxeqb59BzRMJRoFehS3yXan6v36lLmXMtWKueMhQkyykuUmBxpwAGOHD3PGPr66Jh/YYIIBaZmSOuJW3nsK6k4lFHkvc7L57aRcQXKS7kKGrwVYpFBjFm9kWkEMmK8J8A0d53vhnfd5mc+lcmLa+rbU/m57ndvN7JwqNSygoWjJE6AsbtDICzthfrjqtljX1WD6ofUftJo/N3BT3j82UBDFUcp79GAzSM5ZqHdRIXPxqEYTzqsua50GxQ4zTyCHzZdRLt5nyeKIXAr5QI8tbLpdn8dBN+NP/uPFR1djjuLw9ZS4HvHcCVqUDpl5wUaWmiuLBNg7OVqjUg0O5EV+TETHKxXlQtgFplRzsG0zx9rEhVU9mrLzIBXjgNHK9FGK88PuHcTxVZEPOwuJv/BPOVVlVJCRs/5GLiT+b7vRNLcTrprEYq0YftV78CwLLHkgG8eadUWrs2g41bprvaPPUfLm427mbnd5VKdu59qoG2xFcFSMNYvDMYKRCDEz9Xgl7++/8Qxksrp/evCms8kxk+/y2+yji2MMO2lxK15Erq6Gd1ln6m6ajaGiR71UX6GO17lDvRbv547FKuedlwak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261022075727099003)(261022105027099003)(261021121427099003)(261009223027099003)(56012099006)(4143699003)(3023799007)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXEreWhjeW9vbGR0eU54bk5CeW9qdk5ER0hzeDhvUHlZUnI1VE9RNHdGMWc2?=
 =?utf-8?B?NUpUOG83d3NGVmZOblhWWjBvL1ZqdUV5YUYybkpnd20zRDBubGdkZEhOaEhY?=
 =?utf-8?B?NE5wQ0JPN1lXOHpSMThGeXgvb2ZUdmFESmx4dGo1OXFkTEhsbFBCQkdJVmZQ?=
 =?utf-8?B?MmxpMU5oWERrRVd3OVluUTQ4eXBPQU5XcHJDZUd1ZXRHUE5QNkFTRXMzMXRX?=
 =?utf-8?B?Zk8xL3E5N1VJbm1NTVlMejVQejMyT0F1bGsvdndsdjZmNlVsc1R0VVFnaVR2?=
 =?utf-8?B?Zzg2OWpscXl5ZWNuTGs5QlRTc3lVcllYeitCcDJGODZweUN1cFJkSUFSTGdZ?=
 =?utf-8?B?YTFxTzhUdHJ6MkZYQzR6MFRqQXV2dEduMmx4YUovS0JTdHgvSTF6cHVsZlBu?=
 =?utf-8?B?YUZhUmI5YW5MSlZubnpkTEdIenB6RlFVbGlNYmtLUnFBb2Z1N21nNWZpeDhU?=
 =?utf-8?B?RS9CTjZGTVdGQzRRSUkya3pYdnFTMXFhcmdRL29TKy9LUm9qU0hPVFQrRzFt?=
 =?utf-8?B?VmZrUzhtRnNweW4xcDgwejZWSE03TkNlY1NNWTdsUExQTkFYY3U4cUgvMjFS?=
 =?utf-8?B?WWZZbmFRVXV0NDAvRnBNYldpdG1XbFZycjF2M2FXS1c4MEowL2lZNmMvU3pp?=
 =?utf-8?B?VjdtT294V3FicmcxekZXUTlzS1NaOHNXMDA2WkhGOHJzbFlPbERrVXI2NmtP?=
 =?utf-8?B?WTJ1Si8ySGtFY0F0TjVCYlltelhSR3EwcGxLZDNub2lQbU5Ra1hKUGRNOEdK?=
 =?utf-8?B?S2gvbGlvK0FkUzNzbVBGZDgzRXZsbXFGZGEySVBZTFc3TDlIYU1pSm01YUFo?=
 =?utf-8?B?dWFHdHZIa2paQlY1TXJsLzZyL0xpVmNTMTlaVGFYZ2lSK0hCNm5NdG5OdHI3?=
 =?utf-8?B?VjIzTUdrOUtqZ3dIRkRWQ0c2NGJsK2hJMkZxbnJPUVlDdWlKbnRmcmpzbW4y?=
 =?utf-8?B?YnhHT0phYU9rTk5jZ2xBbGhraHpJcWxYMUdJL0E5T3BqT3pEbWF4TnRreno4?=
 =?utf-8?B?dVhlZklhbXVuS1BRcnNWNlFsYnd5ekc2c1RvMWhuWDhNV2JGUjd4NWVjdVlQ?=
 =?utf-8?B?bjVMYXR1bmFmOWVDWG1ha2NUNkRqTkV3SGJSNnpNNW1xazBSWXJ4OTdPUXNw?=
 =?utf-8?B?Ym9Da20xSTN1NFk5a2thWGcwSTQvMGhKL3p2c1dzaXZiSkhyRmpXNjFtb28z?=
 =?utf-8?B?SnlyU3QwaU5XTG1KU1krSU1WL3k1TVA4R25QYW9udlJ1MFVzaEk3MlZKVWNn?=
 =?utf-8?B?MjQra1dmSk9Ldm5RWHdJSEtTVXpHTHZ5Z1dzeEZ6RnpMVjFUQitiejBEOEk3?=
 =?utf-8?B?Z3ZjWUtpc2QxemNTU09oMkxwa0czUE13c2ZSdThHU3dBUHRCM29DeloyYjZH?=
 =?utf-8?B?UHk0YkpyNndzSVVTS0hxN0hJT3ozQlpKZUwzTi9IeHJiem9QUjRPcFEyN1pE?=
 =?utf-8?B?SVJtV2N6WDZQeFpnb2lpd2dFZVhyOVZVVFNnZGFMR28yK2UxUURBeTkxL3lh?=
 =?utf-8?B?amVHRmJackE1ZmZueXI4cmQ3NjhtYUtLZkFUelRvSlhXSE1YdmpoWE1hTXY5?=
 =?utf-8?B?eWZET2J1SGpMMjRlQVRXanN3YzNxZm5NTnVBUytnQlk0WnF2QmhhOGsvaEVU?=
 =?utf-8?B?N2FXeWo2dXJQdGpETEJGazR1WlZWQUhGczhjTlN1UUtJMnZjb2hWK1lxNGdB?=
 =?utf-8?B?T0RUQUhUQjY2Wi9TWFJqamVaTlJ4QWI5YUNqbjBkSERIWGZTNkxzMk5TYjgv?=
 =?utf-8?B?cFh3b1lFZW9wckJtVk1vS1NkWXFJRFhDa29aMUM0cE1CK1FQZ1lvM2ZNT3du?=
 =?utf-8?B?R0NKcWZXRnBxblEyUjJwalRKdjZVZ1FhVGhFa1JpQ3N3Q1FYV2xmVkZZQXdL?=
 =?utf-8?B?ZlVWa0NNQ1VDMHVkWElYUzAwRGxsOGJtZlVLTitod2laZlo4aUVDcklrU05q?=
 =?utf-8?B?c3p3Q0xBcEs4c2pBYlZRdU1WNFgyczM5TDFZUUFaRWNzV0p0VkxHYzVSc1ZN?=
 =?utf-8?B?OURmY0dxV1hOOEtkcWE5Q2dYdzlTVnJxdmljQnllVkNVcXpUaFBtZTZjbjFn?=
 =?utf-8?B?MFdvRmVDL2E1QkdQRjBGV3JZK2drN3o1TWtUS0NwMHNINjFnZTZ2bGlnTFgr?=
 =?utf-8?B?d2kwblVoczZBL3pMUXNPQW1saE5pUW1HbWxGY1A0b0x0UzNpZ0NTQzVLbzI5?=
 =?utf-8?B?TUI4ZitLUWJYeWhtaDVXYUplUkJZZ2RURXhkclQyTzl1eDliSVNwclU0QXkv?=
 =?utf-8?B?czlWb0FwKzZDTnNlYmQyVzJva0Zxcm1tamRyRUFQRlN6NGRwcjdjYWJYcEg4?=
 =?utf-8?B?Y0NYOVlUNFp2WWRZblRkM205NFRySUl2bUhHUFRyVjNrYW1tbkFVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc905872-dd0d-41e6-a8dc-08df31cac5c3
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 12:31:48.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DTU7Qo1grPneSZ+uHX88Mnon6sM0Lphxn/v5bDyfl+J9CS3QSxYFOgQaYMiexkGL60vJPoWEwJYyajv3bbZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003



On 10/19/2026 5:05 AM, Jonathan Cameron wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, 5 Oct 2026 15:12:05 +0530
> Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:
> 
>> Add I2C interface support for Xilinx System Management Wizard IP along
>> with the existing AXI memory-mapped interface. This support enables
>> monitoring the voltage and temperature on UltraScale+ devices where the
>> System Management Wizard is connected via I2C.
>>
>> Key changes:
>> - Implement 32-bit DRP (Dynamic Reconfiguration Port) packet format
>>    as per Xilinx PG185 specification.
>> - Add separate I2C probe with xadc_i2c_of_match_table to handle same
>>    compatible string ("xlnx,system-management-wiz-1.3") on I2C bus.
>> - Add NULL checks for get_dclk_rate callback function in sampling rate
>>    functions to support interfaces without clock control
>> - Create separate iio_info structure(xadc_i2c_info) without event
>>    callbacks for I2C devices
>> - Add xadc_i2c_transaction() function to handle I2C read/write operations
>> - Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI
>> - Defer XADC hardware initialization until first device access, since the
>>    I2C path reaches the PL SysMon indirectly through a platform controller
>>    DRP bridge that may not yet be operational at probe() time. Initializing
>>    on first read/write instead avoids probe failures caused by transient
>>    unavailability of that downstream path.
>>
>> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> Hi Dileep,
> 
> Various comments inline - mostly stuff where we can make things
> a little more readable or extensible.
> 
> Jonathan
> 
>> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>> index 2addb61cf5b1..80199c4ddf69 100644
>> --- a/drivers/iio/adc/xilinx-xadc-core.c
>> +++ b/drivers/iio/adc/xilinx-xadc-core.c
>> @@ -227,7 +227,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
>>         * non-existing ADC-B powers down the main ADC, so just return and don't
>>         * do anything.
>>         */
>> -     if (xadc->ops->type == XADC_TYPE_US)
>> +     if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
>>                return 0;
> Maybe add what ever this is similar to below. If it's in the ops structure
> we avoid having to add new types like this.
> 
>>
>>        /* Powerdown the ADC-B when it is not needed. */
>> @@ -249,7 +249,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
>>        unsigned int aux_scan_mode = scan_mode >> 16;
>>
>>        /* UltraScale has only one ADC and supports only continuous mode */
>> -     if (xadc->ops->type == XADC_TYPE_US)
>> +     if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
>>                return XADC_CONF1_SEQ_CONTINUOUS;
> 
> Perhaps add this to the ops structure as well as a field called something like
> bool continuous_only;
> 
>>
>>        if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
> 
>>
>>   struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops)
>> @@ -784,7 +797,11 @@ struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xad
>>                return ERR_PTR(-ENOMEM);
>>
>>        indio_dev->name = xadc_type_names[(*ops)->type];
>> -     indio_dev->info = &xadc_info;
>> +     if ((*ops)->type == XADC_TYPE_US_I2C)
> 
> Why not put the info in the ops structure?  Then you can set it
> unconditionally here.  Generally matching a 'type' ends up
> messier than just adding more stuff to the type specific structure.
> 
>> +             indio_dev->info = &xadc_i2c_info;
>> +     else
>> +             indio_dev->info = &xadc_info;
> 
>> diff --git a/drivers/iio/adc/xilinx-xadc-i2c.c b/drivers/iio/adc/xilinx-xadc-i2c.c
>> new file mode 100644
>> index 000000000000..cee2f7b3f9bd
>> --- /dev/null
>> +++ b/drivers/iio/adc/xilinx-xadc-i2c.c
> 
>> +
>> +#include <linux/iio/iio.h>
>> +
>> +#include "xilinx-xadc.h"
>> +
>> +#define XADC_I2C_READ_DATA_SIZE              2
>> +#define XADC_I2C_WRITE_DATA_SIZE     4       /* 32-bit DRP packet */
> Hmm. Put this as a terminating entry in an enum with the DRP elements
> below. The it becomes clear how they are associated with each other.
> 
>> +#define XADC_I2C_INSTR_READ          BIT(2)
>> +#define XADC_I2C_INSTR_WRITE         BIT(3)
>> +
>> +#define XADC_I2C_DRP_DATA0_MASK              GENMASK(7, 0)
>> +#define XADC_I2C_DRP_DATA1_MASK              GENMASK(15, 8)
>> +#define XADC_I2C_DRP_ADDR_MASK               GENMASK(7, 0)
> All of these seem unnecessary. See below
>> +
>> +/* Byte offsets within the 32-bit DRP packet, per Xilinx PG185 */
>> +#define XADC_I2C_DRP_DATA_LOW                0
>> +#define XADC_I2C_DRP_DATA_HIGH               1
>> +#define XADC_I2C_DRP_ADDR            2
>> +#define XADC_I2C_DRP_INSTR           3
> 
>> +
>> +static int xadc_i2c_read_transaction(struct xadc *xadc, unsigned int reg, u16 *val)
>> +{
>> +     struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
>> +     u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE] = { 0 };
> 
> Might as well set the values you have below here rather than init to 0 and then
> override.
> 
>> +     struct i2c_client *client = xadc_i2c->client;
>> +     u8 read_buffer[XADC_I2C_READ_DATA_SIZE];
>> +     int ret;
>> +
>> +     write_buffer[XADC_I2C_DRP_ADDR] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
> As below. Not seeing much value in this FIELD_PREP as the reg should always fit
> 
> I think?
> 
>> +     write_buffer[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_READ;
>> +
>> +     ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     ret = i2c_master_recv(client, read_buffer, XADC_I2C_READ_DATA_SIZE);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     *val = FIELD_PREP(XADC_I2C_DRP_DATA0_MASK, read_buffer[XADC_I2C_DRP_DATA_LOW]) |
>> +            FIELD_PREP(XADC_I2C_DRP_DATA1_MASK, read_buffer[XADC_I2C_DRP_DATA_HIGH]);
>          *val = get_unaligned_le16(&read_buffer[XADC_I2C_DRP_DATA_LOW]);
> 
>> +
>> +     return 0;
>> +}
>> +
>> +static int xadc_i2c_write_transaction(struct xadc *xadc, unsigned int reg, u16 val)
>> +{
>> +     struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
>> +     struct i2c_client *client = xadc_i2c->client;
>> +     u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE];
>> +     int ret;
>> +
>> +     /* low byte of the 16-bit DRP data value */
>> +     write_buffer[XADC_I2C_DRP_DATA_LOW] = FIELD_GET(XADC_I2C_DRP_DATA0_MASK, val);
>> +     /* high byte of the 16-bit DRP data value */
>> +     write_buffer[XADC_I2C_DRP_DATA_HIGH] = FIELD_GET(XADC_I2C_DRP_DATA1_MASK, val);
> 
>          put_unaligned_le16(val, &write_buffer[XADC_I2C_DRP_DATA_LOW]);
> and no comments needed.
> 
>> +     write_buffer[XADC_I2C_DRP_ADDR] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
> 
> Given this is just a clamp to size of something that I assume always fits,
> I'd drop the FIELD_PREP as providing no value.
> 
>> +     write_buffer[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_WRITE;
>> +
>> +     ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
> 
> I guess in this particular case we know what the i2c master is so can assume
> this never runs short?  (in practice they never do but I think the interface
> allows for that case).
> 

Yes, I'll add a check for ret != XADC_I2C_WRITE_DATA_SIZE and return 
-EIO for a short write

>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return 0;
>> +}
> 
> 
> 
>> +
>> +static int xadc_i2c_probe(struct i2c_client *client)
>> +{
>> +     struct device *dev = &client->dev;
>> +     unsigned int conf0, bipolar_mask;
>> +     const struct xadc_ops *ops;
>> +     struct iio_dev *indio_dev;
>> +     struct xadc_i2c *xadc_i2c;
>> +     struct xadc *xadc;
>> +     int ret;
>> +
>> +     indio_dev = xadc_device_setup(dev, sizeof(*xadc_i2c), &ops);
>> +     if (IS_ERR(indio_dev))
>> +             return PTR_ERR(indio_dev);
>> +
>> +     xadc_i2c = iio_priv(indio_dev);
>> +     xadc_i2c->client = client;
>> +     xadc = &xadc_i2c->xadc;
> 
> It might be worth a little helper for here...
> 
>> +     xadc->ops = ops;
>> +
>> +     ret = devm_mutex_init(dev, &xadc->mutex);
>> +     if (ret)
>> +             return ret;
>> +
>> +     spin_lock_init(&xadc->lock);
> 
> to here to initialize the xadc structure as I don't think
> the individual drivers should really know about xadc->lock etc.
> 
> 
>> +
>> +     ret = xadc_device_configure(indio_dev, 0, &conf0, &bipolar_mask);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "Failed to setup the device\n");
>> +
>> +     xadc_i2c->conf0 = conf0;
>> +     xadc_i2c->bipolar_mask = bipolar_mask;
>> +     xadc_i2c->hw_initialized = false;
>> +
>> +     return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static const struct of_device_id xadc_i2c_of_match_table[] = {
>> +     {
>> +             .compatible = "xlnx,system-management-wiz-1.3",
>> +             .data = &xadc_system_mgmt_wiz_i2c_ops,
>> +     },
>> +     {}
> Trivial but local IIO preference is
>          { }
> 
> I wanted to standardise these on something, and happened to pick
> that a few years back.
> 
>> +};
>> +MODULE_DEVICE_TABLE(of, xadc_i2c_of_match_table);
> 

Thanks
Dileep

