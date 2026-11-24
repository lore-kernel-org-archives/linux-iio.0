Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795518253;
	b=w30WN2iTy8W20ZHdXh1Cf37giR6ZwtZDw7hz3MVsbNsN7n73BVyhiewbWEBT7Umn7ubR
	 V9KSduHamI4EF3GHKJBgWOzfoO8Hrq/He3zXkPM270vmXN1x4H0+ibkMDMKq2hHVvShFa
	 f8cKq86NmXhA1KOh7AJe/JQNwFjaDMLAFaYvSh0v+6Rbb9ijQ9TY2juRxag8ZdjKGHPpD
	 lYpMVHPzQ18HmqW4l6LH90je9T6p5nw/QLramL2gExkqhbpnLeBLZDSIkg2giTjKUxfPH
	 t0ztSoW+AeKissp1w5scrZhu4/H8ifrXwJSKbde4gbDGTmuzvHSTOoMvjFs8K9JJ8ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518253;
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
	bh=KvJFu8m8aDGTqEnUAA7yuvFMMj/rjLlhcr7uNiD2V7s=;
	b=1jwJ201Hu3BArlIgwAIKwnhrzlvKkXhlbzhMVDwInibfWrCRBc57EW9caMzadWbXiv78
	 Vj9CxWfPhy2BtI2Syj5ZSjaEO922w+8UW2xv7NRuPF7kqjhv4QhzNUT+Ws+lkKM//C80R
	 XhWFypKV29AddQ8pSKBqQB9OathBB4TjZVt166OmcOW3evrpdvHcn1iVNDfvlwdM58UxA
	 w4aOXDVdqOflRNWNtT2i2Q4WqLU5xLknw93ExhTxL/WNCl70n3R3h5GrGIj0b7jStpgjX
	 QoglBgnB0Nn1zotoJq1UhYcD1RZv0ZO1TUJLbtM0478aF9oFvk4rdLaj0C2UPFLln1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Asf5qw0h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.26
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E05606A31E;
	Tue, 24 Nov 2026 11:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E05606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Asf5qw0h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBCsyPJFwrpfhScnK712o1n/co5ijmkP8vSDC7Vl5OU839YOq+lz1IZlEZF5OPtITW4hhu15pBbEZUkKvu0zKDRVyqy2Sy3jPAPnYNYSkk6LGWECnFiY/myk4n7ioP7rwKh9r4viovbz4a74Ui62IeK8sucDNEpJykr9D/WjvTA8Xs1Ndo+/z8G4mCMTe0q7oIB0ubOE9meWi8yu3nbEFGzBFF3B/EbLd9op8qBDmN3c4AU9ourQKNX69Lz6xYbqmonYpk+NHC3dSTHUbecqWs2EODn2XL+cj2+ka0JaPw8U8Mfnqsb+wm8nKyGXpgrXgmZc4er+O+RSNEIx+wVnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvJFu8m8aDGTqEnUAA7yuvFMMj/rjLlhcr7uNiD2V7s=;
 b=HeZYd+uTuPWjP0y386HQZfYsfsC2AlXfyl+1pfddfZ34K45RQ9OP8WA1EuZVO3gfSFdyDWxAN/eW8Xlt3mrgENuCEBzsfrfPUWcA1Z/c7GRlVdhuvrOhCQsrcx12ctDSJD/UVI8y5vIo2Heb/sgk4HrAU/RYJbyBkpBeyjM8T1ucuVddFk2R1xqN/7q/0t/6GJCGh6+J7T/WZ/IyQFq4jckl2A7nWvGQRtD0zGN3A9isvxaCIHk3B1Doc6Bo1prRy7l0g/70F/eToPjO+GTv8bB2e6XnK/mspStboMHwlxs19UHPMIk2BnYZ8PfhJgOmxC5+YFQWW+jd0jqvz23npQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvJFu8m8aDGTqEnUAA7yuvFMMj/rjLlhcr7uNiD2V7s=;
 b=Asf5qw0h/c/C0DnyHOIzbnjNiPrer3H3OdP+XkAifpGF5SnLJ9UtaEfRHyOqrQlZCwPgpCyr+ylXwtXPpuZw6tkDuSW6BiHu4aojEXPSXWvRWmfagulo/Bp76Icoh/ajOoEtzl3Jln8xm8Gw4k0ijOZCLLXNvxrcVcKnWj4iZNI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 11:04:08 +0000
Received: from CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8]) by CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8%7]) with mapi id 15.21.0639.010; Tue, 24 Nov 2026
 11:04:08 +0000
Message-ID: <42949fe9-b336-40e7-8a8e-43f6d24da9bc@amd.com>
Date: Tue, 24 Nov 2026 16:33:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] iio: adc: xilinx-xadc: Split driver into core
 and platform files
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
 <avNGcpcemoeE3J7O@ashevche-desk.local>
Content-Language: en-US
From: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
In-Reply-To: <avNGcpcemoeE3J7O@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0118.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::11) To CY1PR12MB9559.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9559:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bc6a67-5b0f-4fbc-d673-08df4a1aa90e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|261021123027099003|56012099006|4143699003|11063799006|261026140227099003|261021121427099003|10067099003|261028144727099003|261102123227099003|261022105027099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xKxsgAu4DglU5UZu7qZSBKzw38Q5hY9haPegJOHkTQwVeiBDch3k/ntv6H/Ybt5PJuIDnQnF/h6gEun31ySPXurz4J3N7TBtnVeAE7puSs2xjIsfNYMXzI4eOPhPpaHNt2S1j3TTr6wl4BO38GJsWX13Z6WeCg6XPdVlDNzKObBtwAhkyARD6X9WwJdooOvU+gBDUczMd5Aw5lBPK2AGvR2D13HdNSt5ajSd3r7x/UGG09s+j/ZUSBML27auJ9pTf4CNC4tzt/IA3Ut+ACjUtLhB5M34eVTmnhlvbOz7Lul5yLTswXtu3QDwF41edrxyV6BN593DFd4ctNitciQxPQ97dtWxSHURmlKgxnJGTewY6+8QA/eFFEKCX/tfUV2F+c/PEa0L8EXBRJvz42/u8dFRCm7ArnU1j4hy8If56J4qVbNXxQhMMTPaEMSFcmkY6NnytTOXtkju12ATMJY6tmvQeVd4HJ62TNN1/HenCppuym0r1Ikiap0sSEPKwMixeEIExmgHHILimWrrVsitaQ1ORzTMQSKFb2ucgUZdYr/6GY1HUO5wRY3Jx3S+vbKwNwRGYCj0SvbNmNEOEwaLCFViKlJ5ZSirOtdr6HH4vxpH3l7hFYpG6JCjltMmYfRyOt1djf+kbnap0pULpZwFDjxK/0lNxzwP6pVxavOY9tY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(261021123027099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261021121427099003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ppN2ZpeW1zUjFtWWhHck1EM1VFc21aamxhM2lrU0cyNEwwQVcrVmxtTjdM?=
 =?utf-8?B?KzlDSm5JRlhPL1gxL01ERnppYityeXNVYnZScGk4NEcwRmRra01MaW50bytW?=
 =?utf-8?B?Z1ZUbk5sU1pzNFRtclkzMmc4ZDJ5MEZXZTNpMUhSNWZoZXJWV3JDZllKZGZk?=
 =?utf-8?B?akVtaWY3cnkzVUFJaW9IK2dHbEhTUVZ3aXVEc2tOSnJ5MnZveEViWHJCTmZB?=
 =?utf-8?B?c3FWdDU4SVhxd2lBZzlTZDByVUFTRHcrdVprQjNkdFd5NHk2ZnNVLzhkeWZh?=
 =?utf-8?B?RDByUk5lTVpoeFkwUzUzV3QrdHhzK290TkVTL2YwajVXOXhMOWNMVWw1bW1a?=
 =?utf-8?B?N3k4Rldldzl3cTNKbU81UDZSWnp6U0pvR0VOTU14T1Bac0RROWJqWDB4YVZF?=
 =?utf-8?B?UlJ5dUN5dk1LY1QraUk4UitFQnlxWEY5NnRiamNWUFFOWUFrbXFvWDk4QkFD?=
 =?utf-8?B?a0VIbmFmNWFoc3VjdmhITENxdlROckFwQmRBK1h5dXhjM2JySkx4M2hFK0VX?=
 =?utf-8?B?OE54NitYUlU2Q2dIYUVNMzVibTl3QWVyQlBQN0JYbjlpZWdSVHdHOWJ1VUg3?=
 =?utf-8?B?emgvTno2aGpzekdMSVhBbjlseWdaaDIvVXByalpZdm90SWZNTzFSQ0hVTURC?=
 =?utf-8?B?ejVSWkUrVHlwZ2dVcFJVU2VQcENkTXMzeHIyRjB1anZrT1Y3TTlNVHlBR05N?=
 =?utf-8?B?a2N2ZTFtOVdaYW5yTHlVTzgwVEVkaVY4QVZTb0VKVHluN1prVzJlTSs5U2cy?=
 =?utf-8?B?cXV4dDJILzJ1aW8rOW01R1BYS0lNczkxaWNOdG50K3NnWjlsQmQwbVFEdTBa?=
 =?utf-8?B?emNqekpoZUJhYzBPa3V4Y1RhWEhiQjBXMnllbHJEV3FCWWR0S2FFNHpVZHBO?=
 =?utf-8?B?Qy9JbHpXWlZQUmt6SFBTVFhUdmFMMzd2WFpoS1huTkdLRnRLc0ZReFZQM1Z4?=
 =?utf-8?B?T01nTGJuVWdETFFnRjdNVGRLTXNuenQ3RGMyY0U2RHhqZWtMaDd3Tm1SMGpv?=
 =?utf-8?B?MEtHcTFKM2NjUk9SRU1ObmVXaEROV1dKTGxtQ3piSHA1alFMZGIxd3pZRzU5?=
 =?utf-8?B?VzVHbGNobXl0cHNDN0phYU5Jd255MU8rMUxHbU5mQXRDcGFQVUZabmVidXln?=
 =?utf-8?B?TjFYeC9jaVFSeVFnc1Z4QThCdXhmRmo3VUR1MHVZRG5YWG1SMGp5M3QxTHM4?=
 =?utf-8?B?azZ5RHU3THBxYzZkQXpVL3djN0FoN2MxRys2eXBVcFdnSmQ3TkRYMExNaUov?=
 =?utf-8?B?OEQwQjZtMlRsYVJuR1JiTkxGUVNYVEFUczlTKzdRK3VkZG1pMzd3aS80N1JN?=
 =?utf-8?B?L0w5b3IzbGRvR0RtNmo5VVozcnd3RS9CSk5GK0NOT25DbFczMDlqNktjNFRa?=
 =?utf-8?B?RnJhZE1Wd1owYUVqbjlMK1NHRHVjTTVycGczZmRraDRMUDhKUjNneW1Wdjlx?=
 =?utf-8?B?R2xmS0NBQ2grNzF5UnRWd3hSN2VmQk4vRE5SRGsyYzR4QjRvWktRSTVqUzk1?=
 =?utf-8?B?cHpBTlkwaEZaQTFqMlg0dVl4SURONkc4TEZiZCszQUVKRUh0amc4d0NKV3Ni?=
 =?utf-8?B?NkpQY2hucHAyZDdTOVd4SHJyL2N4TVpaMklITmRGQUMxcVBJY203aU9IbTlm?=
 =?utf-8?B?Mjlud29sZVJxWWttb1N1UDVTZDBxQTVHM1dJU2lyb0J3OThvM21LRWhROHpR?=
 =?utf-8?B?aFptbzRxVTZ6M0FPTjhXdDROYjhJZ3hIR3hpWHdTYXBhVHZrUThyeWVvQXJw?=
 =?utf-8?B?L0JYK2FPb2c1YTNoc2hGQitWYVU0SDh3V2VGdDlHbU1Pa2I1bG00anFmRnZ0?=
 =?utf-8?B?SVludU40TkdUeTRYUGZXNk1DZmZic3I4aUtmRjhnOHBXQTh1dzFHdk1PdWVZ?=
 =?utf-8?B?V1NQVW9NZ25wY2hsYTIxekJwSjA2bTR5ZUVzSEErdkRKT2JRcE1qZGdIeHo4?=
 =?utf-8?B?dGdCcmd0cWt3UGJuL0Y0cFZuamtFWUoxNzJkV3BkODEzNTV2RXNhUnVvcmE4?=
 =?utf-8?B?Z2JjQlR1QUI0aGE1L3Z4VldNNVQrcythWjllQkxTTGhkcWRoaXh6S2RtVmxL?=
 =?utf-8?B?VHNTaTcwcm9rVXpxaGFUNzk5NmtRSDBUR2JRL1hpWEx2aFJ5Ti9qOEFSd1h3?=
 =?utf-8?B?U3pyWk16dDhoaGc3UUREdFFLSCtWWWRGeEd2S1R5TjZXR2E3cnVqUXJJQjVU?=
 =?utf-8?B?NjBNMWZtcUltT3JCZzQrTEE3Q05RMHJ2SWxwT1hSa3VqeTBIV2QraFBBQ0k4?=
 =?utf-8?B?Nkh5Nk15QUVPUnh6WUFraUp6MkdEVUF3cDRlcktiZms5bVhiY0pRNXJMdktL?=
 =?utf-8?B?dFdHOWsyQUhvUkxiRGtVWUw0TGg1djU0NlRyVm5QTkRsUFNldmNGUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bc6a67-5b0f-4fbc-d673-08df4a1aa90e
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:04:07.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1ggpwRXkWINtrIwXoYISPIbKu9fOSdGO4hJxPRTg7A0IJ3RZnyPsu3YaU4UFJTWIbnJvUnEL30NppUsffVTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

Hi Andy,

On 11/10/2026 9:59 PM, Andy Shevchenko wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Nov 10, 2026 at 10:31:59AM +0530, Dileep Kumar Nagavarapu wrote:
>> Split the xilinx-xadc-core.c into separate core and platform specific
>> files to prepare for I2C interface support.
>>
>> xilinx-xadc-core.c is reorganized as follows:
>> xilinx-xadc-core.c:
>>    - Platform-independent IIO/ADC operations
>>    - Channel definitions and management
>>    - Buffer and trigger management
>>    - Device tree parsing
>>
>> xilinx-xadc-platform.c:
>>    - ZYNQ platform (FIFO-based) register access and interrupt handling
>>    - AXI platform (memory-mapped) register access and interrupt handling
>>    - Platform-specific setup and configuration
>>    - Platform device probe function
>>
>> Update Kconfig to introduce XILINX_XADC_CORE as a helper module selected
>> by XILINX_XADC and update Makefile to build the split modules:
>>    - xilinx-xadc-common.o (core + events)
>>    - xilinx-xadc-platform.o (platform-specific)
>>
>> Reorganize the code with no behavioral changes.
>>
>> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
>> ---
>>   drivers/iio/adc/Kconfig                       |   8 +-
>>   drivers/iio/adc/Makefile                      |   5 +-
>>   drivers/iio/adc/xilinx-xadc-core.c            | 690 +--------------
>>   drivers/iio/adc/xilinx-xadc-events.c          |   1 +
>>   ...inx-xadc-core.c => xilinx-xadc-platform.c} | 818 +-----------------
>>   drivers/iio/adc/xilinx-xadc.h                 |  27 +
>>   6 files changed, 72 insertions(+), 1477 deletions(-)
> 
> This is weird statistics... I think it's a bug in Git. What it did, it copies
> -core.c twice and uses statistics on each file after that without duplicating
> the *original* amount of lines.
> 

I generated the patches using the following command: "git format-patch \
    -M \
    -C10% \
    --histogram \
    --base=origin/togreg \
    --cover-letter \
    --subject-prefix="PATCH v5" \
    origin/togreg..HEAD"

If I remove the 10% similarity threshold from the command, 
xilinx-xadc-platform.c is no longer detected as a copy of the original 
xilinx-xadc-core.c, which is not the expected output.
Is there a better command or approach that would allow Git to recognize 
xilinx-xadc-platform.c as being split from the original file while also 
producing meaningful diff statistics?

> --
> With Best Regards,
> Andy Shevchenko

Thanks,
Dileep

