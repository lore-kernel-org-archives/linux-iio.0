Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0A33F8B3;
	Tue, 10 Feb 2026 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719171; cv=fail; b=PooYXSGlKx2cxW7l0DKIsLtKXN02zKyY3GO6c2mP10B2pO1vzx7IF48i4W30VhTCeqWLylViuxrPKfOCFfaOE1SizttwB/N7QOoqbKqTDjqFvhY4zUqKIKkHMZt145TIOBiXwO6PUnEo3QVLQzsuC/n7IwGPi8Aw1v0O+arBMD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719171; c=relaxed/simple;
	bh=qhS5d6dGjMBPs5ex9Xcl5bv8XPJjy86FwNK62/lFL98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQ9egxQapB5T/hPdTFI/p/gPSFMNFV0d9mNQBTcwo9CE+dQyYFPGUiZjmUVA9mxQfmm2WDxGkMjrvjUlo+7pcJmxPl8jAcfNkcy5zpKSSRG54HnTxemqqjftNIwV5RlpheKIxsiFAK2yhL+8eNq+lNDq0sQZC2n6Zj/89eAG8hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CEbV+74R; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CEbV+74R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8fBdp9/qFTjG4QFpyaHwjWp90x5x0aidWtr/+/qWVL4TkgCvoIJHBwwywG6CfJHudNT0TAKG3MBucyAIqXLhkd0iLPPDS2fGiwHiIsV6MtLqil3FkmDzuEBhUxtkbogM2No5XOjD5KxLJAwqnvxYgd25r48uqXPII6an3B7FympCQef36KXd0i0mSbcDHBV2skZbIQh2iUagcOXl3XEIYnG72W4JkXJNQZu+/74+CqqLDR56pRNDWw153HoSFEEWtOCPorJZ91cRX0CWe3+1nLDX/v15oRF3bhqwvdYq8hdD7npBp7z4NfarqB+FG/X5pjnrvCC2tvNCPpD1ndpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhS5d6dGjMBPs5ex9Xcl5bv8XPJjy86FwNK62/lFL98=;
 b=Zu2/+Wmw41YsLAhibisvEFFUgRUZNsT+ZIdyAVRcEfpUvbDRlLZlAOdxrszLzX3P7AaXmtO0OthzkbM/3gy1jn0MlGMw9PK9X1QlhZ7Qo4lpnpTpOCw8VmtB8aVU4JVzkUuOSJIClTBNYXcTrNaFw+REWW04Pp9elDOJ5KjbuOIcSvgzwhIGUW7A6z4TbWmCkNCWshrpgCrXVVk/Z12OW3kyK1k5PP/4dcmOEvdLjceNq6AJKIZADRXJzUpwMZ+w7QAk9t7sgZUE+Re8T6rXvz28ZBPQ3CK8EOTm0FUsjImljXpuIYWUkG64ed3FqS6klRi8IowdFZFvR0T4Uqpncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhS5d6dGjMBPs5ex9Xcl5bv8XPJjy86FwNK62/lFL98=;
 b=CEbV+74RUvEtNkNCGRz9l8pcEUVkRJP2UMeu30sgUwCMgqWBc1YT6vUH2zSjcV5Cx2IxD29pttP7Lt+epvZEsC2Kqg9WnZ/bnJxhiKFwJRzbrFiYNRuhHNNz0eAboZ+PxXSQjVPUqaqUPVQPIFmwuJ8clH06YfQAFeeaHKaFrC2zwYCxpeB3UjK2vknXYy+y83r14dJMMDYxPRb7SdPLsuTCDZdGCOEt/45yA1HOsSIe/knF732oLd6j/wyygVbNVR6gDxwtjScodPIiyIpEXEyWDrBr3Wjo7PiGsZFHODhzFh4NETpkv9DxlA4qd631lDDQgeAK8wRMa4u4kq1F+Q==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SJ2PR11MB7425.namprd11.prod.outlook.com (2603:10b6:a03:4c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 10:26:05 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:26:05 +0000
From: <Ariana.Lazar@microchip.com>
To: <andy.shevchenko@gmail.com>, <dan.carpenter@linaro.org>
CC: <andriy.shevchenko@intel.com>, <nuno.sa@analog.com>,
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <andy@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Thread-Topic: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Thread-Index:
 AQHcl24xxWmzSZRfwUiLfa7mzfu6B7V1tA6AgAAIMQCAAAuUgIAABMyAgAAHCgCABezEgA==
Date: Tue, 10 Feb 2026 10:26:05 +0000
Message-ID: <16614d1f875aa1e9923375dd3de0897de17791f5.camel@microchip.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
	 <aYXvP5FLA5BvkoVX@stanley.mountain> <aYX016NlTNkJzGdT@smile.fi.intel.com>
	 <aYX7tlJ593KBDGW0@stanley.mountain> <aYYFba5-ZV8VuZHM@smile.fi.intel.com>
	 <aYYJc2d5AwJbc_vV@stanley.mountain>
	 <CAHp75VdhTEKu2tKC+UKJLs1DcE7079KEbPV0NTFfUAjADBEg_g@mail.gmail.com>
In-Reply-To:
 <CAHp75VdhTEKu2tKC+UKJLs1DcE7079KEbPV0NTFfUAjADBEg_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SJ2PR11MB7425:EE_
x-ms-office365-filtering-correlation-id: 05753a41-eaa7-427a-70c9-08de688ecc49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWJSQXdZWUUzVEpBOFhOQ2pmQ1gzRE9xZ0ZTZkpoclFGL2ZaNG1IMWdTWlF0?=
 =?utf-8?B?T0pES2FqZGxBWFB5M3MxUXh1MGgwS3VraHJYM0ZCR25rS1JYV1VkMmZwS1Jr?=
 =?utf-8?B?YkhBdzdZSFExb3BKaDY3QUtPUTdqOHdjVGtRZFN5YU96RndYNjFNc2h2SkZ6?=
 =?utf-8?B?aGhyamxiRkNYekxUOEl3ZVRBZWNWeGN2dDh0MDRaSFJBNmxCbVZtMmtERFps?=
 =?utf-8?B?ei9Td2NKS1R3TCtPcWgvWEtReUVMWXZKSHV1clhtZno5UDg1K25OdmRjQ0RR?=
 =?utf-8?B?SGkwUDJLQ2IyeEdCYVlLSXBFS2ZtM2FqdDRUbVVTQ3ovbUpQVWJwU0dXb2Yz?=
 =?utf-8?B?aUtLNG1PbHppK1IwZ3lVQ3lDNy9Id3lBa2dUc2RYZHpUYUo1a2VtRDdpRTFw?=
 =?utf-8?B?Q01pMzM2cFY5cS9VQ0E5dmh2bDZra0RHbWVzdUJwaUtVUS9lOTdMd28rM2dE?=
 =?utf-8?B?OHpZNmZBT1paWVlzR25QcWFVOGk4VE1ZRXZwa21veHp6Q3ovQVRnMWRNZlF6?=
 =?utf-8?B?UTRPMFZKd0FRZUVZcXVWM05CMmJtZ3VyVkkyMEtpd1hDVXl5ZDJ1RDhYb0RR?=
 =?utf-8?B?M1JVb3g3NWFEeElmdi9kZHlKa1JDM3RPbXl5QVNJVHpXOTNxWCtBQkY3dkFH?=
 =?utf-8?B?OUxyNTlQNmNsNityWFQzeDZSbGR0eXFnbUl5R3ZTTzRXZzZvVXR4a1FQUHY0?=
 =?utf-8?B?c0tlUzZpaGdWbTdVS3I2RWxQNllyYmlCaGZGYlRUUFNweFdoK2ZGeU1xRDB3?=
 =?utf-8?B?dko1NDB4TEsrMm5ZaUpHUWJZSjQ5OXVaSTFFRzZ4NE1EblZpQzlSZmVsYlZr?=
 =?utf-8?B?TDlBVG10eHRMbldzbEtXWjc0OXFJbVdmTjhNS0xWTWZHYWVZSnNobVZDdGxy?=
 =?utf-8?B?VVZxU1RTbm5qTTE5bEp0ZGUvVnYyNG5TUzgxMXhRNUZSQVFBazk0OVIyL3Qr?=
 =?utf-8?B?SUxWWXRwQ3Q1Rmt0OUVTR1V5QUpZM3RFSUY2SzZsemxVdHl6SERoS2p3V3pw?=
 =?utf-8?B?MWF4VGsrdmc3eTVQVnhQWi8raC9tNkNPS3pIUTA5bDUrOHJtSmo5M0xRQXpL?=
 =?utf-8?B?S1ZPd0Ztd1YrN1oxVEpzUktSU2dPSVpuSURlclV3NjRtZXYzSzNvUDZxaUR4?=
 =?utf-8?B?NmVQdkgwekxYQVBNamlpSklxOW1Qc09HWE5JTVVIUGpnbUFzQlhTNCtnVEFp?=
 =?utf-8?B?ZndUd1VJUUZFeXlPRHRKbk9YM0JVUU1EZXhKUW54NEZpclQ3WTdPaVQ2UFc5?=
 =?utf-8?B?RXI3bnlqZitNK0k2bjJVZ2FKQm5aWDFscmcvaWxmRUJpcjZ4YW1qZFlEbUNB?=
 =?utf-8?B?OGJlbWYrWi9xdUVNL2UwR1laL2NIcHB1WlIxUU9aZDlsQnlJQ1FoQ215UnlL?=
 =?utf-8?B?bnA2cHB3K2xhYm04dW5ObEJsYmU3K2dmNjZkZzlVaWRnb1VDNnlhdjJ0WU5j?=
 =?utf-8?B?ZXBINCtlVG9oVWRzVm1LMTZTb25IWkg2K3V6VmpTMWpaTm5nWXpPNjlSUmR5?=
 =?utf-8?B?OHlwMitUcWNJeUVYUXU2bTVmWmRpYTdyaDNiUEFSOURiVHRibzk0N09mdXBL?=
 =?utf-8?B?WEdNbndsY1Z4c2pKeGhnTFVySnZmUHFJVCtsWDhUUmJJOCs5MHR4TS9rK053?=
 =?utf-8?B?TnJNdGFDclZVbEZpcng0RDFDRU1pcExOU0Mxb1lROWdXU0Vvak9xM2pVdVlo?=
 =?utf-8?B?MDBsQXduQnptRjZHNUpUckJyVlRQVi9XUVlFUDJZRk9zbUd0Y1gvakxMd3lC?=
 =?utf-8?B?TU1IT0dxTVR0cjVGbXBtWGFPSFBGaDZYSU43QWpLTmFXUldvQ2l0eDh0NmVH?=
 =?utf-8?B?eExPa1EzQm5yWTRMaVNrVENwWDV2ZVpiaG1ZRitMbFJibXlBK1JKemQ1ajJK?=
 =?utf-8?B?RnUyeWxDeXB0Z2dIQzJVVU16N2RpNDc1SU9YdVpwcGlyWmtlb09xSVN5bGpU?=
 =?utf-8?B?M1lhbnE0MzRCd3ZpRURKZjJSZWlMT25GSnRQb01LYlZ0SU5DZGdTcFNNemJ1?=
 =?utf-8?B?V2lEQ1A5MkNhNVM4TklLSDBRb1ZUQ0UxaVVOZGNIcGNxNDRVUUl6WFlRbWhj?=
 =?utf-8?B?U1k1VDVvOFZSVWtWZlA0UTNTZVZieXdBRXF0N1ZCZU1pUy9HelNNcW5WRXpS?=
 =?utf-8?B?UUw5SE5QaVlTL215Vk5qOHp6SnhYMm16OGp3Sm5BQ0tiaURDbC93Ti9yOUFo?=
 =?utf-8?Q?363tnOaX22FiIiT34dd3InQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTcvdzFVVUNXdktJbHlkeVZubmYyb2ZDZVYxWktsSjNFWHFJdVZPKytUUjVN?=
 =?utf-8?B?bEhJTVVFK1dTOW81MnFxaXAxUXFjckZqekVSaHhNYmdkWjFhVkZDSkh5VFBZ?=
 =?utf-8?B?c1FTTnRmMFFDVWc1dktITDNUeFd3ekpRUkJEK3R0MlhTUGlWbkxEaTRHbzMz?=
 =?utf-8?B?Qld0M3A2NUc0UkZzaG1zRWhvc2U3NEs5anRFeU5MbFNvc2xGZnV0WXNKMUor?=
 =?utf-8?B?N2VQaUtyM0J1UlhDRkp5dTRkYWFLbVFRVzJjK3ptaGxQUHIyNHE4amhpQmRw?=
 =?utf-8?B?VmVmUTNEWDVxZFgxbm9CWFIyNnlETHZROXBHUlZGWW5OWFZoeXVWcEQ5RkUv?=
 =?utf-8?B?ZmNaYlhCNkhyL0tMa091MUR5Yi85ZjIya3NvRnpFVDlMN1pYbzJ1dFByckZ6?=
 =?utf-8?B?MzFXaDI5YzBlaU1vN0hsdGhWZnA0QVA5clZJbXZNUEkvL2NPb291Tmhmdk5W?=
 =?utf-8?B?Q01vWnlESmhKbHFEMmVwMnR4cGRKUWdJeEpDWDhlMW9wcE44dkJXK0Rqc1l4?=
 =?utf-8?B?YlNhdWJpS2ZDbXlHYkdkY2M1eWhoSWNUZU1Ga1dTV1hGam5qaXFGK3FtMHFa?=
 =?utf-8?B?bk14NkJtalhpVkF4L2RNTmk2SGhrQzQ5SU9zaUNwU0s2ZnhiNWJHK1ArRldp?=
 =?utf-8?B?QXVOMlh2V2RReVgzZmNDcE5TVzVrYTBhdHJYdXpUbTg1YllkbG9NeTIzYmg4?=
 =?utf-8?B?VVphbmxyT1hNdDIxWSsvREV1elZyeWVKZkRGbU0yWFpNaDJ0T28wS2ordWxY?=
 =?utf-8?B?dnJVajBZSWVBMEp1WGIrT09ieHhkamZZWUs0OEp5T0xnZ0h3bUo5SWRwTzNq?=
 =?utf-8?B?TEptQXM3ODBzSEVneFhBZXlEQ2hvVzhkdyt1VFZiNW9rNnFTNHZYR2lBZjJP?=
 =?utf-8?B?ckpuTEx5UUZRclZKbDJkY3BYZ3pDTzBIbFo5c0p0RmFFaE1zMzRneVNJZTF4?=
 =?utf-8?B?N0g3cGdaUW1SZXVuTVVqS2tIbE14WTRuZVExTlh5WVh1Wldja0JzbG43bmRU?=
 =?utf-8?B?ek15WUJTREVMSUhsSTZ6Sk41TnFzaVVUZ3Y3eWFNUFd2Ujd2blFOallObVA4?=
 =?utf-8?B?bC9aY1UvUG9kMnVYYWpPbXpwcTh1Z0tkTmhHdi96RlpDODdLN3Y1MTBTN1Vw?=
 =?utf-8?B?eFg0NUtWSTFRR0VUYzVQMHdHdFNzc2xWYzNpNkltTGhKUXZnR2x0QjRMOG9w?=
 =?utf-8?B?TFBDdjgzYXBpbFZNajZMUm5xdDBVSi94TnVOTXlHMFFtWHZRSk52Vkg5cW1o?=
 =?utf-8?B?NzdITmlENnY5L3hqNEk3WTUyclNzc00vTG9LSVFybkFyRjNGMUlqb0RJYWtJ?=
 =?utf-8?B?MmtpSU01T2JQcnJ0VUVmMXFqdFAzdlRKSTFKbXVIQjBuVUNrZnFiZzIrcTFl?=
 =?utf-8?B?OGZnOXlpK2lDMHRZOFROT3AwWmFsa29KellxZ1hWSldFQkRDL2tnem1WOFBv?=
 =?utf-8?B?SG56Mmd4ancxNVhyUytibGVLTUZ3T2ZaMEVwLzdlSEhzSDc1V01zOU1ZV3dv?=
 =?utf-8?B?MVZ6MlhGWFBLSzZZYXVTeWZ0OVlWZXBVZTBPeUszYlNrWUdOV0FobWQ4Y09U?=
 =?utf-8?B?V1B5dWRockdHNzEyaDVxcWx3cm1HcklvZ0Z1RUZUcTdYTWUzZStWU0xvNHlx?=
 =?utf-8?B?emNtYUc1V09qajJMRWNSK1VzWmduK0RNWlBnZ3I4V3haVEVnMFM2Z092V2Rt?=
 =?utf-8?B?MWhxbFpETy9OQy9ZTGlBelBZQjlwbnFjT2hkQktzenNFY0ZZSE1rRWMzTVNR?=
 =?utf-8?B?enlIaXBpd1M0bUN6ZTFQZUs3ZTFBSnA0NWJkZDZBUDRWZkhRVXExZE13QnZa?=
 =?utf-8?B?L1BmeklUb3hwWFpSS29HN2RidjdoZjN4V0VXVW5yd05TNWFBTE9ZT3JlSTBx?=
 =?utf-8?B?TFk5MHU4M1NLb0xUNE1LcE5pbmVOdHhVQm1rVUhReTIrM2NYMHhNaEdrQU9N?=
 =?utf-8?B?R0VnRFNHWXh5eUdXd1hPeElkL1pLZ3VMM2YxeGpncmhJelp6UTFmTlBCWHRU?=
 =?utf-8?B?ZEpvN21QZFRvNStldXZXL3YxQ2M5Z2lnN3lyS1AybTh5Vm4vVWkra3lwRnFu?=
 =?utf-8?B?c2dsaC9zRUtDOUN1enNZdEV5bFY2dFdpc3BZTEg5Y2I2VVd1YmFOT0JYUU9L?=
 =?utf-8?B?aWRrOTI4UTV1TDhybktIZ01DeFZkS3g5ZG1NbEFkSHVQVldmU2h2cmF5NWwr?=
 =?utf-8?B?MU8rY09kaUFwVGtjRWk5aVN2UDlDU1NBWU1HdXhmYjZhWCtvZVNRQlZnU3Zk?=
 =?utf-8?B?SHJNMWF0b0RRZUk0aEdJTlhDeDVJNGNHUnFXdHZuM3BFNjJlTHpZYlZQNzQv?=
 =?utf-8?B?TjFiVW9MRmFubUErTENiaHBwak5iOUJYeTV6bldFclVhbDVFOENSMHlFZi9v?=
 =?utf-8?Q?5uX5BRvOk/ee/M9A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA685816D3384841ACE689AD088CCE86@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05753a41-eaa7-427a-70c9-08de688ecc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 10:26:05.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3z6XPCEuINI99jOYvb5+3d4BDFxWTATH0Vgh66aN22qw3cJUhj2jp35/Dbs+seDT5CO+/zo3yCy0fGo2BsdVOCVNGumq8bIZJxqSkWD71jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425

T24gRnJpLCAyMDI2LTAyLTA2IGF0IDE3OjU3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UKPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUKPiAKPiBPbiBGcmksIEZlYiA2
LCAyMDI2IGF0IDU6MzLigK9QTSBEYW4gQ2FycGVudGVyCj4gPGRhbi5jYXJwZW50ZXJAbGluYXJv
Lm9yZz4gd3JvdGU6Cj4gPiBPbiBGcmksIEZlYiAwNiwgMjAyNiBhdCAwNToxNDo1M1BNICswMjAw
LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gPiA+IE9uIEZyaSwgRmViIDA2LCAyMDI2IGF0IDA1
OjMzOjI2UE0gKzAzMDAsIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4gPiA+ID4gT24gRnJpLCBGZWIg
MDYsIDIwMjYgYXQgMDQ6MDQ6MDdQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvCj4gPiA+ID4gd3Jv
dGU6Cj4gPiA+ID4gPiA+IGRyaXZlcnMvaWlvL2RhYy9tY3A0N2ZlYjAyLmMKPiA+ID4gPiA+ID4g
wqDCoMKgIDcxMiBzdGF0aWMgaW50IG1jcDQ3ZmViMDJfaW5pdF9zY2FsZXNfYXZhaWwoc3RydWN0
Cj4gPiA+ID4gPiA+IG1jcDQ3ZmViMDJfZGF0YSAqZGF0YSwgaW50IHZkZF9tViwKPiA+ID4gPiA+
ID4gwqDCoMKgIDcxM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludAo+ID4gPiA+ID4gPiB2cmVm
X21WLCBpbnQgdnJlZjFfbVYpCj4gPiA+ID4gPiA+IMKgwqDCoCA3MTQgewo+ID4gPiA+ID4gPiDC
oMKgwqAgNzE1wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpkZXYgPQo+ID4gPiA+ID4g
PiByZWdtYXBfZ2V0X2RldmljZShkYXRhLT5yZWdtYXApOwo+ID4gPiA+ID4gPiDCoMKgwqAgNzE2
wqDCoMKgwqDCoMKgwqDCoCBpbnQgdG1wX3ZyZWY7Cj4gPiA+ID4gPiA+IMKgwqDCoCA3MTcKPiA+
ID4gPiA+ID4gwqDCoMKgIDcxOMKgwqDCoMKgwqDCoMKgwqAgbWNwNDdmZWIwMl9pbml0X3NjYWxl
KGRhdGEsCj4gPiA+ID4gPiA+IE1DUDQ3RkVCMDJfU0NBTEVfVkRELCB2ZGRfbVYsIGRhdGEtPnNj
YWxlKTsKPiA+ID4gPiA+ID4gwqDCoMKgIDcxOQo+ID4gPiA+ID4gPiDCoMKgwqAgNzIwwqDCoMKg
wqDCoMKgwqDCoCBpZiAoZGF0YS0+dXNlX3ZyZWYpCj4gPiA+ID4gPiA+IMKgwqDCoCA3MjHCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0bXBfdnJlZiA9IHZyZWZfbVY7Cj4gPiA+ID4g
PiA+IMKgwqDCoCA3MjLCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPiA+ID4gPiA+ID4gwqDCoMKgIDcy
M8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRtcF92cmVmID0KPiA+ID4gPiA+ID4g
TUNQNDdGRUIwMl9JTlRFUk5BTF9CQU5EX0dBUF9tVjsKPiA+ID4gPiA+ID4gwqDCoMKgIDcyNAo+
ID4gPiA+ID4gPiDCoMKgwqAgNzI1wqDCoMKgwqDCoMKgwqDCoCBtY3A0N2ZlYjAyX2luaXRfc2Nh
bGUoZGF0YSwKPiA+ID4gPiA+ID4gTUNQNDdGRUIwMl9TQ0FMRV9HQUlOX1gxLCB0bXBfdnJlZiwg
ZGF0YS0+c2NhbGUpOwo+ID4gPiA+ID4gPiDCoMKgwqAgNzI2wqDCoMKgwqDCoMKgwqDCoCBtY3A0
N2ZlYjAyX2luaXRfc2NhbGUoZGF0YSwKPiA+ID4gPiA+ID4gTUNQNDdGRUIwMl9TQ0FMRV9HQUlO
X1gyLCB0bXBfdnJlZiAqIDIsIGRhdGEtPnNjYWxlKTsKPiA+ID4gPiA+ID4gwqDCoMKgIDcyNwo+
ID4gPiA+ID4gPiDCoMKgwqAgNzI4wqDCoMKgwqDCoMKgwqDCoCBpZiAoZGF0YS0+cGh5c19jaGFu
bmVscyA+PSA0KSB7Cj4gPiA+ID4gPiA+IMKgwqDCoCA3MjnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtY3A0N2ZlYjAyX2luaXRfc2NhbGUoZGF0YSwKPiA+ID4gPiA+ID4gTUNQNDdG
RUIwMl9TQ0FMRV9WREQsIHZkZF9tViwgZGF0YS0+c2NhbGVfMSk7Cj4gPiA+ID4gPiA+IMKgwqDC
oCA3MzAKPiA+ID4gPiA+ID4gwqDCoMKgIDczMcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChkYXRhLT51c2VfdnJlZjEgJiYgdnJlZjFfbVYgPD0KPiA+ID4gPiA+ID4gMCkKPiA+
ID4gPiA+ID4gLS0+IDczMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsCj4gPiA+ID4gPiA+IHZyZWYxX21WLCAi
SW52YWxpZCB2b2x0YWdlIGZvciBWcmVmMVxuIik7Cj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+ID4gPiBe
Xl5eXl5eXgo+ID4gPiA+ID4gPiB2cmVmMV9tViBpcyBub3QgYSB2YWxpZCBlcnJvciBjb2RlLgo+
ID4gPiA+ID4gCj4gPiA+ID4gPiBXaHkgbm90PyBXaGVuIGl0J3MgbmVnYXRpdmUgSSBiZWxpZXZl
IHRoZSBhYm92ZSBzdGF0ZW1lbnQgaXMKPiA+ID4gPiA+IG5vdCB0cnVlLgo+ID4gPiA+IAo+ID4g
PiA+IEkgc2F3IHRoaXMgYXMganVzdCBzYW5pdHkgY2hlY2tpbmcgdGhlIGlucHV0LsKgIHZyZWYx
X21WIGlzCj4gPiA+ID4gbmV2ZXIKPiA+ID4gPiBhY3R1YWxseSBuZWdhdGl2ZS7CoCBJIGRvbid0
IGtub3cgaWYKPiA+ID4gPiBkZXZtX3JlZ3VsYXRvcl9nZXRfZW5hYmxlX3JlYWRfdm9sdGFnZSgp
Cj4gPiA+ID4gY2FuIHJldHVybiBsZXNzIHRoYW4gb25lIG1pbGxpdm9sdC4KPiA+ID4gCj4gPiA+
IMKgKiBJbiBjYXNlcyB3aGVyZSB0aGUgc3VwcGx5IGlzIG5vdCBzdHJpY3RseSByZXF1aXJlZCwg
Y2FsbGVycwo+ID4gPiBjYW4gY2hlY2sgZm9yCj4gPiA+IMKgKiAtRU5PREVWIGVycm9yIGFuZCBo
YW5kbGUgaXQgYWNjb3JkaW5nbHkuCj4gPiA+IMKgKgo+ID4gPiDCoCogUmV0dXJuczogdm9sdGFn
ZSBpbiBtaWNyb3ZvbHRzIG9uIHN1Y2Nlc3MsIG9yIGFuIG5lZ2F0aXZlCj4gPiA+IGVycm9yIG51
bWJlciBvbiBmYWlsdXJlLgo+ID4gPiAKPiA+ID4gV2hhdCBkaWQgSSBtaXNzPwo+ID4gPiAKPiA+
IAo+ID4gZHJpdmVycy9paW8vZGFjL21jcDQ3ZmViMDIuYwo+ID4gwqAgMTE1N8KgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoY2hpcF9mZWF0dXJlcy0+aGF2ZV9leHRfdnJlZjEpIHsKPiA+IMKgIDExNTjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9Cj4gPiBkZXZtX3JlZ3VsYXRv
cl9nZXRfZW5hYmxlX3JlYWRfdm9sdGFnZShkZXYsICJ2cmVmMSIpOwo+ID4gwqAgMTE1OcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA+IDApIHsKPiA+IMKgIDExNjDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2cmVmMV9t
ViA9IHJldCAvIE1JTExJOwo+ID4gCj4gPiBQb3RlbnRpYWxseSwgaWYgcmV0IGlzIGluIHRoZSAx
LTk5OSByYW5nZSB0aGVuIHZyZWYxX21WIGNvdWxkIGJlCj4gPiB6ZXJvLAo+ID4gYnV0IGl0IGNh
bid0IGJlIG5lZ2F0aXZlLgo+IAo+IEkgc2VlLCB0aGFua3MhCj4gCj4gU28sIGl0IG1lYW5zIHRo
YXQgdGhlIHZhbGlkYXRpb24gc2hvdWxkIGJlIG1vdmVkIGhlcmUgb24gcmV0IDwgMCBhbmQKPiBy
ZXQgPCAxMDAwIChpZiBwb3NpdGl2ZSkuCj4gCj4gPiDCoCAxMTYxwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+dXNlX3ZyZWYxID0gdHJ1ZTsK
PiA+IMKgIDExNjLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4g
PiDCoCAxMTYzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2RiZyhkZXYsICJ1c2luZyBpbnRlcm5hbCBiYW5kCj4gPiBnYXAgYXMgdm9sdGFnZSBy
ZWZlcmVuY2UgMS5cbiIpOwo+ID4gwqAgMTE2NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9kYmcoZGV2LCAiVnJlZjEgaXMKPiA+IHVuYXZhaWxh
YmxlLlxuIik7Cj4gCj4gQnV0Li4uIHJldCA8IDDCoCBpcyBjaGVja2VkIGhlcmUuCj4gSGVuY2Ug
dGhlIG9ubHkgb25lIGxlZnQgaXMgdGhlIHJhbmdlIFswLi45OTldLgo+IAo+ID4gwqAgMTE2NcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gwqAgMTE2NsKgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gPiDCoCAxMTY3Cj4gPiDCoCAxMTY4wqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IG1jcDQ3ZmViMDJfaW5pdF9jdHJsX3JlZ3MoZGF0YSk7Cj4gPiDCoCAxMTY5wqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChyZXQpCj4gPiDCoCAxMTcwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkVycm9yCj4gPiBpbml0aWFsaXNp
bmcgdnJlZiByZWdpc3RlclxuIik7Cj4gPiDCoCAxMTcxCj4gPiDCoCAxMTcywqDCoMKgwqDCoMKg
wqDCoMKgIHJldCA9IG1jcDQ3ZmViMDJfaW5pdF9jaF9zY2FsZXMoZGF0YSwgdmRkX21WLAo+ID4g
dnJlZl9tViwgdnJlZjFfbVYpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgwqDCoCBe
Xl5eXl5eXgo+ID4gCj4gPiDCoCAxMTczwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4gPiDC
oCAxMTc0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+IAo+
IAo+IC0tCj4gV2l0aCBCZXN0IFJlZ2FyZHMsCj4gQW5keSBTaGV2Y2hlbmtvCgoKSGVsbG8gRGFu
IGFuZCBBbmR5LAoKVGhhbmsgeW91IGZvciBicmluZ2luZyB0byBteSBhdHRlbnRpb24gdGhpcyBi
dWcuIEkgZml4ZWQgaXQgYnkgc3RvcmluZwp2b2x0YWdlcwppbiBtaWNyb3ZvbHRzIGluc3RlYWQg
b2YgbWlsbGl2b2x0cyBpbiBvcmRlciB0byBhdm9pZCB0aGUgWzEsIDk5OV0KY2FzZS4KSSByZW1v
dmVkIGRpdmlkaW5nIGJ5IE1JTExJIGZyb20gdGhlIHByb2JlIGZ1bmN0aW9uIGFuZCBrZXB0IHRo
ZQpjb21wdXRhdGlvbiBvZgp0aGUgc2NhbGUgdmFsdWVzIG9ubHkgaW4gaW5pdF9zY2FsZSBmdW5j
dGlvbi4KCkkgd2lsbCBzZW5kIGEgZm9sbG93IG9uIHBhdGNoLgoKQmVzdCByZWdhcmRzLApBcmlh
bmEKCg==
