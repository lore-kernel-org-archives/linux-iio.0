Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794484645;
	b=HSqFPjNC0M+yHv/WJX9+p2O/KQYcSTDWc9r1qsezs5U9v9cS9SkUILaLcxzpepYZ4Z4o
	 wj0tdsUyvcNaADTqITRj85eqquAy2wA2qWgXVf1YYK8sXHO1/UrR64XJKXeGK6PEcDhfd
	 bCLNilCbpVMFnMKpHfLUi5GP5UFbMollvg6uZXnLu/lRbOSMrZVf8um3C9lqbSz67yj1q
	 OWi8O6MH/Wh0Il+8is7Znt9/o8Xb1AGc9gRqh0LiBOnhNFIfLnoZy6+Fq60fiuhfYH5Bl
	 i7kwCs6PJ9J879p7jWRq9wch9VTEdas27yHY7CsKN9t9AbCrRRPvnBN/9AI5eTtrxwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484645;
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
	bh=+t7gpxQKixYkz7O1p3CgJ0F7T8gKNm1kxpQi66OvOyk=;
	b=3Dbv5oivGFV38+baZ7G+a9IAKEy69zv2SKvCqqjvk+WJ4Vdl/i3hu2b65aLdFPbqSMpC
	 gFGk/7bbQlc4kmiEQtLvNffnGP27SBEuW/pKM1eg16jNFnLgGJ2UCDWMQz3ZG1bY51oEB
	 WtQJJsHevManDU1xOii378B8K0JVCk8kKGmCTivuy3yHOehIIFO90zxMJhJlD2kWdeUj/
	 XweC3Ag2GFCrxcT14YK0OEKUuuob8ekxbluc6yBZdoCPKTdD7/L9y814CCMWVExXRgWQJ
	 LKi1gutCmybM6wuThl9GZLdaVrcrWVEcY2YdQzY6LwxBtVr6L8TpUmC+KnE8g7W4T3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sMYEzeIv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.39
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F3606A31C;
	Thu, 12 Nov 2026 11:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 253F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sMYEzeIv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeSx2kgETzP7LOQwnX5FUdZ4brZxPnLQlbJfODiyUL95xwqQhWxTpCz/QxaNAoA+f56j82X+g1mcfRWcKFhO7Wwq3fOsUWKufqCaIek/qUUak4gX8hfusuEQ9BQlD4P6mu6VpUAc5Vp0QpqgotcPahCWNSkiYuxB0IoNwWi8jMi2LIs/Xv0VRgNftRiMuHJ56tN1qDsE1Wowj2aezTkRWsf2AEybO+cBix9mElJ1N7+RgxzsezA2MjghjrI/VdD6BXFU0W+YZYp3kevYUf8DlsYqdaIHoc8JasHgJ/PPGEucq4ZEQ9cBaywBy5JdpRkoikgDrrMzuqvrXS2ls62twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t7gpxQKixYkz7O1p3CgJ0F7T8gKNm1kxpQi66OvOyk=;
 b=F4mG9C4KbW3bweOqFwChT8B66Nzikby5Jez99WG4XkDFwmCJ3OX/+/w3vtcKWvwPFOlwDgxgSRy+jVSk1amTBqEPTA9o6XMGMKI27y32dG2NZ27O56bkqH0LtXZ9dFh5s4G8/nTsRksiOLMlqEtjKJLbtmskfGzrrNmAC0+5TD7XkEgyGfqwBQgUpB7qJuQrcEqdxbIKeXuiwNhJYgTYX3OoBZTcJ36IKOAUfPbvMoawwxwijS9Nn76NUpQNj82YcjrLBOBPZO0XFfixgNXmtH58w63pYVt6rYDTmdurozX1PJjZcwUE8KDTpI0M5ANSdAEsmBGdvO66HuBaEnY7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t7gpxQKixYkz7O1p3CgJ0F7T8gKNm1kxpQi66OvOyk=;
 b=sMYEzeIvJMaiOXLhUq6r7T8ViV5IL41zhI6vkfAofGMPci1YvP+gi40gX8k+AriiE9WngU9TkR6gtxUCRgXus4zgsRBFVcmyTcqRGUxUAe8UTiOpmIOV20cX1D5LLKv5hdMKYZezDUNmqV/j5Mc1r+BCD9XsiGIXSAi81wCxV7g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 11:57:17 +0000
Received: from CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8]) by CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8%7]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 11:57:17 +0000
Message-ID: <920c0696-da90-49a1-bf70-6fdf645a1000@amd.com>
Date: Thu, 12 Nov 2026 17:27:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, sai.krishna.potthuri@amd.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, michal.simek@amd.com, pramod.nexgen@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20261107134955.1423727-1-dileepkumar.nagavarapu@amd.com>
 <20261107192618.6814da6a@jic23-hlaptop>
Content-Language: en-US
From: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
In-Reply-To: <20261107192618.6814da6a@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::12) To CY1PR12MB9559.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9559:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 536ac935-8121-4f16-65ff-08df40b418f7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yEIqBOvp9UxJ2utmmX7ebeqIqtQCvH/lYPbzamJ4SsRTqX+ZaOAvxyA3kzM2kS5gP3tLMm8eGduT7d4B23jfFIs3tHxxtIpceXQSIdsXvqFjmOIROWmbasV33CM1W/MXYcXEVzlQH+au7vEvjNosyLRK7S1c3ycedgK1Z/6mRQGtTawvsMMlWOiXBQpj6S285VrnIlczhmRd1ttYGTiLbYTPAafylByXNeq8J/S0xp3YCFFi1bKG/Ublu443A81nViAT0t2FjPAQT/26fKKKlLC61vdgXtVKnuZkEbATRQECcnsFR5IZZT0u03t2RbwipLbE9frfzjvs2h9rYhRAm8Xs6KHcmI9pM4dvOrhyq1XEenpza398SfloVklWIUBJxToUY+2nePRfCUyPPtIIzz02Hjl13oJ7EoyTLkacof1HFty56bIbAfABDj++HVuSh4UiAnrta2rqa7UNEszC/I+G3s8gXlTvmhCsmbw+6bead0RdqIL7Brow/88HmIHXLg8kKJ9Vv07pW0f3q2LtqRKL4kPRSl+WPyLOqXsjjwUw47Z6mFkcYpkGDJHi6WnsFoReVOsISPjSSovtw4FBLjoK0LOarvb+A/hTGxW1kkY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGNDRzVkU21USkd5V1RTRDBXZUNVSEZTdVVvRmVuSVJlc1NMaU5YSWtBK0JM?=
 =?utf-8?B?bUMyMld5ZGhXWWsyKzN0UkRhM1E4bmJ4RTNqV2ZaZ0IwalNVSm1vbkh0dmFy?=
 =?utf-8?B?WERxTkRYNFpFU2dMWWZVYTBVbXo4eGhudXdheHh4ZmphSVdaYlpnbFdKSXJZ?=
 =?utf-8?B?bjA2dUVTSnBjMno1SnlCS09OZnByVGZWSCtCMkFTTGhxSm8wL0xqSXpGYWND?=
 =?utf-8?B?U3VWWHlNaytJQTNPbzV2N2taMGxnV0tXbThpa3cyRWtGTldPQ00xRUJwaUFK?=
 =?utf-8?B?ajBZQjdkM0VDb2lmL2pHT2xsbnlnblJDSS82NFdiaytUK1hNZ3I0RUxweUNS?=
 =?utf-8?B?bUlPbDRudXMzM0UrNmpMMm9ENmNmWllHc09JSndraVFESU5wc1RnK2YremtH?=
 =?utf-8?B?YXJkaWRaaTl5Z0RreWJPZkMxTCtObUVMVWhER0xrU0U3K1U2cSt3bTlJR2Ni?=
 =?utf-8?B?VTFPeW80KzhKUSs2NVgyTlFFMVprYWo3OWJpSzVXaGZWZThBOTdVMzVoNk9E?=
 =?utf-8?B?ZTVjMjhKUHhoV1RpVUlBMUtSUG13KzJ2emF4OVg3R2gzQVRxNm5OdVNwckFY?=
 =?utf-8?B?QmNuekk3bEkrLzRsbzFnbFk4b2YyUCtUd1BiRG5qQWdqakZmYUJGdVlvaytH?=
 =?utf-8?B?bjdTNjVRT3BsU3dlQmNrazlJTXVYR3o1d0FtbXpqVnhzUzV0OUd3Ykp4UURV?=
 =?utf-8?B?dk5HY1lOOWI1MEgxTHRnTVpwelh0U3B1c1FJTTR1U2lQcXBsZlFJM2xwMXpY?=
 =?utf-8?B?TXBKSmczU1d0UnR6amJyOW1iVmVudVAwbVZyVW10MHpNTldxVkJKRmVTZWRi?=
 =?utf-8?B?MzZtTWJRUzRoZHBsZG9JYmlJUVFNVDdlSDBGRzlrNTU5c2RuZDRsQXgvTzg1?=
 =?utf-8?B?c0NtdWVUMHVDeDJuOUFZQndiQUs1ODlQYlFqTVAwVkFKRDVXTk1vMkxmOHVv?=
 =?utf-8?B?WFRqT1NVVXp0N3VkcGE4R3p4cmxZQ2JsclAxMVEyUEFWU0ZIVlJqbFNTYlQx?=
 =?utf-8?B?bzBNYWR2d1EvS0ZseEN5RStaRk90dlJBV2JXSXJNQnFXVjQ5cnFKSDZtVVI4?=
 =?utf-8?B?eUhQakg0cHh3TkppR2V4MDBLNy9RMVZINHBJZVovdExIU1RZTHoxNDdxRUxS?=
 =?utf-8?B?QkZiQmxpck82NjhUeFJJZC9EY2JEMkpCNS9iSmFoVWVLZ0ZCa1Z6a2NsRVZi?=
 =?utf-8?B?MjBQWVQ2ckY5T0ltWE5TY0NFRktIMysxVUxsOWJreTloSnh4KzIxSmQ0c0lS?=
 =?utf-8?B?ZXpMVGVCRFd0Y1JlTkMzcFFTUktnNG8vQ2VZTzh6Qlhra3ZxMmVzb2Fvb3Nm?=
 =?utf-8?B?cWw0WGFuRytjRDZJVEtBRnVHT1laVVNSdndYcGY2OEpQeWExckJWQTlPQmJQ?=
 =?utf-8?B?VytKY2Z4dkVCNkZVWHQzNERIWmoxdVFQN0VIVDBMUXhBeWJxMStpcStGNGJw?=
 =?utf-8?B?SlVtbDJjeFVzWHN2alltZ21rSjl2aytWUDRpZVNTeFYwK3M2RnFxZGhTMGZr?=
 =?utf-8?B?dnI1bmFsMU9Oc1NQbFVjVkhHVjFkRmZVM2hqRWZyazRod3JzR0pPWUllT1Z5?=
 =?utf-8?B?Q1ZJdFd1RzBEUjhOckg1a0FuUW9MMVFpUEdPWFA4aGprQ0g0U0VpSDdDaFBu?=
 =?utf-8?B?NitTTW9CODlKNjlZODJIb1ZxSFRyd3owQ29SQmczZzI3YVNGTHFYbjF3Zmlz?=
 =?utf-8?B?VzlCN3VXQjdHVEVqZnBGQllTN3gyTDV6Ky83cHdtUlFyTzlRZXRwd1RaV2tK?=
 =?utf-8?B?NzF2aWtEN2dBTVV2MmlUbjUrVmNJbjhCT1BIeStTVXArRjQrdlpsQkhLWVFu?=
 =?utf-8?B?YlVtQ2ZqbWdMenh3bzFITTFRdEc0anhnV29KOU40WmpCY3dNV2JLSmh1dUEr?=
 =?utf-8?B?czVPRjlrbGJYK0UvWHl1TVhqVWxUeitadFQ3NWNmMG9uL2NZYjBHK05lSFEw?=
 =?utf-8?B?Z1dGdStvby82aERTS3VQR1J2clR6RDhJSFBGVjRPN3Y1R0M3NFNJbGNISDRx?=
 =?utf-8?B?YXFHMCsreDlYbHRCaEdTMVlmdURFeThSOHZGbXVIK2ZlT3dyL2lwb1pyakpQ?=
 =?utf-8?B?VzhpRXJGZ3ZYWW1yOW1hOFBHblFDRFA1bUw5T21talB4dkU2ajhHRHpucWZa?=
 =?utf-8?B?WjQ1MTVsd3Z1cExNRjBKWll5d2p0dk9Ic1NLVG5VN1ppYmYzYy8yaklxcEUw?=
 =?utf-8?B?N2pYNlhUV1BRRDE4cjVySDlXQ0YrSElORytuWkUxUmRJeHFZRzNqL0tRcUw1?=
 =?utf-8?B?d2dJblM5RGdpUVdpNkVFbk9JdFBiV2VNUytjVGJiN2RCd2hhL0VzTCs5QUtC?=
 =?utf-8?B?bUFQeGg5c3RmVVJZTnNFNUJ4clEvVXlVNFhTNkhVdmRMbWJUV2pmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536ac935-8121-4f16-65ff-08df40b418f7
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:57:17.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BI8hCaMlHBaDaWwf1hR1f8AIa183wxyu21yiF6/000mo0ZnCC5kyDaXb9HNsxDh99E3w6ofx+NTqwMHfpzpp1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

Hi Jonathan,

On 11/8/2026 12:56 AM, Jonathan Cameron wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sat, 7 Nov 2026 19:19:55 +0530
> Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:
> 
>> From: Pramod Maurya <pramod.nexgen@gmail.com>
>>
>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>> from the legacy plain-text format to a YAML.
>>
>> The new binding covers the same hardware and compatible strings:
>>    - xlnx,zynq-xadc-1.00.a (ZYNQ hardblock)
>>    - xlnx,axi-xadc-1.00.a  (AXI softblock)
>>    - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>
>> The xlnx,channels subnode retains its legacy name (including the comma)
>> for backwards compatibility with existing device trees.
>>
>> Move xlnx,channels under properties, as dt-schema now allows node names
>> containing a comma for long-established bindings.Constrain the reg
> 
> Space after .
> 
>> property of the channel subnodes to the valid channel range of 0 to
>> 16 with minimum and maximum.
>>
>> Drop the redundant "type: boolean" from xlnx,bipolar, since its $ref to
>> the flag type already implies it.
>>
>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
>> Co-developed-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
>> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> 
> Hi Dileep,
> 
> Given the legacy nature of the binding this looks fine to me.
> I noted a few things on how I think it would look today, but not
> expecting any changes to this doc based on those.
> 
> I do want an Ack from Lars-Peter Clausen though if we are going
> to more formally list him as maintainer.  No idea if he has time
> to keep an eye on this one!

As I understand, Lars-Peter is no longer active, so I’ll remove him from 
the maintainers list for now and continue to CC him on future versions.

> 
> Jonathan
> 
>> ---
>>   .../bindings/iio/adc/xilinx-xadc.txt          | 141 ---------------
>>   .../bindings/iio/adc/xlnx,xadc.yaml           | 165 ++++++++++++++++++
>>   MAINTAINERS                                   |   9 +
>>   3 files changed, 174 insertions(+), 141 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>> deleted file mode 100644
>> index f42e18078376..000000000000
>> --- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>> +++ /dev/null
> 
>> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>> new file mode 100644
>> index 000000000000..2cbc3b82a26f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>> @@ -0,0 +1,165 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx XADC and UltraScale System Monitor
>> +
>> +maintainers:
>> +  - Lars-Peter Clausen <lars@metafoo.de>
> 
> As below. Need an Ack from Lars-Peter.
> 
>> +  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> +  - Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
>> +
>> +description: |
>> +  The Xilinx XADC is an ADC found in the Series 7 FPGAs. It has a DRP
>> +  (Dynamic Reconfiguration Port) interface for communication. Two different
>> +  frontends for the DRP interface are supported:
>> +
>> +    - ZYNQ hardblock: available only on the ZYNQ family as a hardblock in
>> +      the SoC portion of the ZYNQ device.
>> +    - AXI softblock: available on all Series 7 platforms as a softblock
>> +      with an AXI interface (PG019).
>> +
>> +  The Xilinx System Monitor is an ADC found in UltraScale and UltraScale+
>> +  FPGAs. It is accessed through the Xilinx System Management Wizard IP core
>> +  via an AXI interface in the FPGA fabric.
>> +
>> +  The xlnx,channels subnode name contains a comma as part of the legacy
>> +  device tree binding that has been in use for over a decade. This name is
>> +  retained for backwards compatibility with existing device trees.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,zynq-xadc-1.00.a
>> +      - xlnx,axi-xadc-1.00.a
>> +      - xlnx,system-management-wiz-1.3
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  xlnx,external-mux:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Selects the external multiplexer mode.
>> +    enum:
>> +      - none
>> +      - single
>> +      - dual
>> +    default: none
>> +
>> +  xlnx,external-mux-channel:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Configures which pair of pins is used to sample data in external
>> +      multiplexer mode. Required when xlnx,external-mux is "single" or
>> +      "dual".
> 
> I guess this is a legacy binding, but if we were doing this today we'd
> put an explicit mux consumer in front of it that makes use of the
> channel via the io-channels consumer mapping stuff.
> My guess is that stuff all came in well after this driver!
> 
> This is also rather inflexible as why can't we have a 4
> channel mux that is therefore in front of 4 ADC channels?
> 
>> +
>> +      Valid values for single external multiplexer mode:
>> +        0: VP/VN
>> +        1: VAUXP[0]/VAUXN[0]
>> +        2: VAUXP[1]/VAUXN[1]
>> +        ...
>> +        16: VAUXP[15]/VAUXN[15]
>> +
>> +      Valid values for dual external multiplexer mode:
>> +        1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
>> +        2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
>> +        ...
>> +        8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
>> +    minimum: 0
>> +    maximum: 16
>> +
>> +  xlnx,channels:
>> +    type: object
>> +    description:
>> +      List of external channels connected to the ADC. If this node is
>> +      absent, no external channels are assumed to be connected.
>> +
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^channel@([0-9a-f]|10)$":
>> +        type: object
>> +        description:
>> +          Represents an external channel connected to the ADC.
>> +
>> +        properties:
>> +          reg:
>> +            description: |
>> +              Pair of pins the channel is connected to.
>> +                0: VP/VN
>> +                1: VAUXP[0]/VAUXN[0]
>> +                2: VAUXP[1]/VAUXN[1]
>> +                ...
>> +                16: VAUXP[15]/VAUXN[15]
> 
> Another legacy one which is fine.  If we were doing this today
> we'd use diff-channels rather than reg to specify this I think.
> 
>> +            minimum: 0
>> +            maximum: 16
>> +
>> +          xlnx,bipolar:
>> +            $ref: /schemas/types.yaml#/definitions/flag
>> +            description:
>> +              If set, the channel is used in bipolar mode.
>> +
>> +        required:
>> +          - reg
>> +
>> +        additionalProperties: false
>> +
>> +    required:
>> +      - '#address-cells'
>> +      - '#size-cells'
>> +
>> +    additionalProperties: false
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        xlnx,external-mux:
>> +          enum:
>> +            - single
>> +            - dual
>> +      required:
>> +        - xlnx,external-mux
>> +    then:
>> +      required:
>> +        - xlnx,external-mux-channel
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    xadc@43200000 {
>> +        compatible = "xlnx,axi-xadc-1.00.a";
>> +        reg = <0x43200000 0x1000>;
>> +        interrupts = <0 53 4>;
>> +        interrupt-parent = <&gic>;
>> +        clocks = <&fpga1_clk>;
>> +
>> +        xlnx,channels {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            channel@0 {
>> +                reg = <0>;
>> +                xlnx,bipolar;
>> +            };
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 745d8d0169b2..2d7e9c9ca659 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -29996,6 +29996,15 @@ F:   Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
>>   F:   drivers/watchdog/of_xilinx_wdt.c
>>   F:   drivers/watchdog/xilinx_wwdt.c
>>
>> +XILINX XADC DRIVER
>> +M:   Lars-Peter Clausen <lars@metafoo.de>
> 
> I'll need an Ack from Lars-Peter for that.   Whilst sometimes about
> Lars isn't anywhere near as active as he once was.
> 
>> +M:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> +M:   Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
>> +L:   linux-iio@vger.kernel.org
>> +S:   Maintained
>> +F:   Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>> +F:   drivers/iio/adc/xilinx-xadc*
> 

Thanks,
Dileep

