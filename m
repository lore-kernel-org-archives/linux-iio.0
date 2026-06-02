Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022126.outbound.protection.outlook.com [52.101.43.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977B375AAB;
	Tue,  2 Jun 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396036; cv=fail; b=f/adewrQme5CR+KfhhAgVigHbyfIo/f4oEb9xTOI2g57tDq2yfNCty+Wsko1gYzmJ72qT1eODMB+/YKNIkUGUr9ZAvyQs2pYB0QXN36Ew3HKjgOa9yxCgcBrk+ewvtM8ZcAojyxML6vW+E0L3W20x4IV4tck0utD9+UGhnk7rEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396036; c=relaxed/simple;
	bh=cDwfFtDFP+OAt1Nlb0k3e3wseXxXS1gsrz5eDKUOqwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwh8K1OgA0WPm9y+s6LMqTFKUPCUew4ZLkJNRUZ+xDfb8C2XM2c27yW2MfzVKiSh6SrrXsyRVMrxPwnJbqypDiqqwr5Yx8bZVoDpop478Y9UuG/UNd1Y9d+IZsB8qGGUkP5tXLe15v+PhNgBkZub6dSiAzQGc0K1WuEUCLpiY2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=k7jSsSjR; arc=fail smtp.client-ip=52.101.43.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="k7jSsSjR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCsm2mEI+w0suO7f/1SalifgLTpn0Wi+14Q9s2PxhhBr6+Grn3sM3+BzgIb2QFMPNcJXfZOqCyFeQU1kNgUzBhnOvBpkXFQwzAj0wfeJ6UARiFnZd1kvJSODXiE9UvZJAo1tROsatIvE1KMXePGtftPriNVOUHgra8jnEi4H8hEJVEBQJmoa10kdhUzXOdeNIO1UK6BisZgcpvRQKH1/Fdg+p6PEalisgkZwFqXxkbxxcFOA6WJgrUlibd6cgq5PBLXOgcZ06QcY5F0/IDs24P80d1Bed6A6xnQjQNVkb9dwV95JQB6+kGz2J/SnDtEc2HNvYo9SUAzJ3T7sJvxNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdguZFnFxVrJ/I7An5VfsqTGe4mHIBy9brJGZG1OjZY=;
 b=G9z0/ofi3s/Tif3u40iUWcHLUJZqvSMtB4SY+iZ0EAlHxdgZMLjKUD0tHi+1P4Vyzuhx2btO6p8dZcrYK11WIERuUqnUwaR6rtwLI0u07/dIRG/cy3XnHhV4q3GM9bwGEBV6/RgT7ZkSl/kOPR4MzqhEH3m3qdN8dn84FkneRRjih1T1cyzs82AP8m4MeAFOMx7jOkxVq/zhNdmCM1qdNCOLdwp4ev1+2BwFKAOt+ABfcOv2ZHTs+SsBQ6CTPQZlYlzKFJwp3t94C5q3vsDPjjLDf26B6KR3aIINQdFLKhp3LohsuocSILamNeE2oy84vZFZKcPWoGNnXjfwf42jdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdguZFnFxVrJ/I7An5VfsqTGe4mHIBy9brJGZG1OjZY=;
 b=k7jSsSjRUJE5kGlQozP3nj3p5kxHqoUXrtCBeSzEBliSVa+6p5GlBYCifiyCWs/m0SrLtTZq1rh1gu8SSkAmjP1sQ3Him4cABxW84Nyv/ptZIeP9WZa+lrNsYeqArRaaCyb1QkBpeoWnFZ7Sab2Ouu42fEUa0s3s1WkjzGM4jW/59fnEr3pGKgMqqU6GijoFWsQ7O/ywRXRj5lsECOBFwCPS5fFvrLNejfJIDR3MmjQLH+kEMs3KnFtMXuitd/nfkzF5wox3bYyNdkY0i2KUamdgEEBc/u9Loh7mxy70HtKeH0gY0mDYw1bFe1vzqILwARgiknE0Jz/AOlvMugsKoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 DS4PPFDDCD8AADA.namprd18.prod.outlook.com (2603:10b6:f:fc00::ac4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:27:11 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 10:27:11 +0000
Message-ID: <0f5b141c-28a2-46e8-b99d-47cfc7632fc8@axiado.com>
Date: Tue, 2 Jun 2026 12:27:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: add Axiado SARADC driver
Content-Language: en-GB
To: Jonathan Cameron <jic23@kernel.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
 <20260528-axiado-ax3000-ax3005-saradc-v1-2-345dd5f6608a@axiado.com>
 <CALoEA-yfqYky=Un0r5K8QBc_H8DVziuiKuLap7ArAQOmaLKnZw@mail.gmail.com>
 <20260528104442.428cce3f@jic23-huawei>
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <20260528104442.428cce3f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::7) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|DS4PPFDDCD8AADA:EE_
X-MS-Office365-Filtering-Correlation-Id: d09eb76c-87a9-4ccf-b7bc-08dec0918175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3zhLyA06QvYBuzPG+tOb63OkmyCGYhSZRlUIRXq8LJqhv4kKZawoWuFPNsUgGfFGqr3/Wd5c3yoKPHeYJTxsFr4kFovIigmiIvGwp8VpyIlRrA08zOXRIqvthI9uC5ul24AeYvmiNy50gXgeExYCcExWReiK6bZxDb4qJ8Sgv3I9aq2VDabGCmFeN/Hh5N3P+5+x9xYsuyTfBrDXCKP+r9kHaIyURoA6dBlPnsM7MWzhhQkM7+B/CCxcqs3Nlsv1QxEaK2UHsay3bptaCvoBfM3wdrQXo5h/7sBGpDrUqnv27hHkHELXu7cyMRzXJngH6nmFQLn1ipIKY31fz6YirSKwdhG5HsV+5fifm97JWy2hEanh4KxYS6du02rs78KeCB+3TFwerh5WgMfBWdxCOywgjlVOyhjIaTE2lxUX3ESr7mx3D+IrptWcQWJSoWPl3gfAcWPqMkwwSsD+Q0SBW+TJ5QCHua1Nn8cPWhghZGaRQtYyUuWIqEBSa/OZ0OWx0xV91ntXQvfWRNXMGrL9bw10uOCX5QOBE+zNSECHG38Deh3VoIgqbo3AQ5fFTJu/sGCOIULIlopleDx/0Oi5dJii6p9Jn1v30XX0vreY4sVwya8R9nRhJIdWwNpoAe1BpD/TBtzPSSSeTGa4CWonaOqrDK0tvVLedQ5oJCzhIK0E3o5ORF/9yA85paXMEWol
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Smg0YjJmL0VpWmVNSlRZQ3lLQmUxeDhBWThsUDY1TnVCTGVUdXRwNEZFdHk3?=
 =?utf-8?B?U0JYdnFJcXR5NGg5dkRJTXFGanVtaTZCNXQrZFN2Wm5jcFN1cUVMOElIbitZ?=
 =?utf-8?B?YXgvVkp6a1JRaURZOEtNWG14SVBmb3dXSHhHY1NXem5Jc2FsS1R6YkhqNVVJ?=
 =?utf-8?B?ZVY2dVR5RVZhOEs5ajdNbmZtdEFHeGlMSEk1KzM1bUt4SEpyZFlJbFNTczdz?=
 =?utf-8?B?QmZXM3BtNHNqaWdrNERVQ3YxL3ZCeVUwdG5iL3FYMWY1Z1piaThuTks4b2Ix?=
 =?utf-8?B?cUFUclB0ak56N1Y0K2FtZmhkeTVtZ0FsRzA5bkpvMFV2Z25sUkVYMzhEN2I2?=
 =?utf-8?B?Q0d0MXdkSHRiTXJGYm44dlpTbTczUUl5VTZCVXJsbmJWbVIvdkFVdUxSQ0FE?=
 =?utf-8?B?T2hzSytBMkw3SkY5d2tGMW1mWHBPRnpseTZvNW9qd2tBRDMvdnoyRjJBQjJx?=
 =?utf-8?B?ZmhYUzVOL05VN1J2eUdXbVFpNzJ6ZkR6L2k3RUVIUHljQ0lFaXl4cTlaOHkr?=
 =?utf-8?B?NXk2dzEzUTd4eG1YbjZSNDltUzFLN1h5LzA5NGc2Q0VIMm4vRWI3YXNzbGIr?=
 =?utf-8?B?eG9EUysrNDlsdnVsYkkwS0o3R2N1RXkwSHJ5c2U2V281YXBpWE9YY1BxU3Zh?=
 =?utf-8?B?UkRDaWFORTV3SVh3dC80Ni9CcVgrY3NYTjdBVGc0eXc2S3ZicE96QTJFb3hV?=
 =?utf-8?B?NGJsajZNTDJFWC9ra0w2VUFvaE5JRHJ1MEh6eXlXbERqbEl4NHMzQXBKZDl4?=
 =?utf-8?B?NTBleVlzWlZGMWUvaU0vZzZ3VksyN1pJajRPQzlaOFdJTC92T3RUa1JNUndo?=
 =?utf-8?B?MzE3Qjd2UmFTdW5Od2p4eFNoQ3djc3BpZGFTUk9uR2RjUytDZS83bXNPWVRz?=
 =?utf-8?B?OGt3Qi9OWkVJMElYK1l2YWdBb3hZWUJLamgvLytLWUZxS1kvdUhVSDF1bm5s?=
 =?utf-8?B?ck5maE1UR2I2RWpEVGV0N3BOUCtvTTdSVXc5RlRNc3l0S1NwSW02YnAxNW9F?=
 =?utf-8?B?ME5seEdiOVNCSEZyYkFtMkd0VGZNZHYwQnhUZVAwYmtxTEMwbHlyLy9pUnV5?=
 =?utf-8?B?emZKNTcxNk1VdFB4YUtvSHdMb3QyTlBJUnpmUXVTaEpYNHFpSHByUTZxbGhk?=
 =?utf-8?B?RHR4LytRckhRU05PWDBtYnNHQlRhZ0FzNk03R3lNNEVSUnNMS3RjYjE5ZWF6?=
 =?utf-8?B?L3N2VUF5SzJtcGQrcG9XU3RiemJsR0dZblBNQWdERVdNTEtnYUNIRHhZSVhF?=
 =?utf-8?B?ZjNkTnVkZWp0RmZLMHY3QUZIZUM0NHE1cDFkbUxPY0VtNTBjcVlhT2xrRUMr?=
 =?utf-8?B?bmVkWEV4cTdsVnRjcUZOZTNtZGJnQURDTmlGdEhkZVdFQUpOOXo1djk3UDRP?=
 =?utf-8?B?MlRaVGh4aHRKb1o0Z0xFRTlVUm5mZlBWVlJlSnJtdThKZzg0aU9CdC93aHRS?=
 =?utf-8?B?N3pVQ0sxczE3aHRrOStsaUlOaXJlcTVsREp4eUw5ZHFaWEk3VDFOZjNTQUlK?=
 =?utf-8?B?ZC83UEFoU1RCbVB3b1Y3Ry90SEkyZmRmRXlBRkRCZ3pWN0JlK2xIWk1LMzZF?=
 =?utf-8?B?T09SS25SanZuQk14NWlab0VpVUI1cmt1Q09UalR5eTF5MjArOXF5STlDa2xr?=
 =?utf-8?B?MDJ4NTY4Tm9QamNDeWRNRGpwYXRQRTFwWVJTTXFVeGR5MTJXKytHRDJoL2ZY?=
 =?utf-8?B?TGgwSk8xbG5rcER0eldjTllBVnpqT1F5dHZrWlN1azRTbTVaV3dqWlczS3Yy?=
 =?utf-8?B?UlJ4TnM2YndITEJuYlV2dVgrRmMrTFR6Y0hvMURKc0s2NUJiMGc4MTl3RzJW?=
 =?utf-8?B?ZDFKSEh5RzhTc0pmdXlXSXVLeFdxTnBjVkpIQjVyTGozSHYwZ3Z4SlZKTVcv?=
 =?utf-8?B?MkE5Q3BKVUlpRGVVdjF0WVBjck40SkdKMkN0S21HbTdUR2pCb1NnT3R6Tjlq?=
 =?utf-8?B?dVZqU1BnYWxTdkFRMlBPeXVyRlhYeDhBVkxSRC9BL1hxanBaVWQyWUc2aW5D?=
 =?utf-8?B?UkNBQU9vbkJRMXFXNDZFZy9rL1Y2YXhtRTdia1d4NmFGNTN1R3k0b29kblp5?=
 =?utf-8?B?T05zUkhBWFNHVnRYRGdzZVlnY0tSc0YvYjR1S2laQlRjN3ErT0R2TmNPNERj?=
 =?utf-8?B?K1A4RDgxNWtpc0hxcGlRS3JUNlUyQTRYZE9hMzdLTkRlWlYyMWIyeWZ1cDBG?=
 =?utf-8?B?enRyUHhTbDlvenFPQTc0QVR4akdTcSs1djJ1MzFEUXNabnFBR0VGa09EZUhT?=
 =?utf-8?B?TlE1VUNaM2pjYzdzbWtXM3VUM3RxUDlBellURTdkVDJlMlNKNHhwOHEzcGpP?=
 =?utf-8?B?OHV5SUQ5cVhpUE94TjB6YUtTM2ZvK2pqdzFTY1ZiNXVCWE9SK1MzQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09eb76c-87a9-4ccf-b7bc-08dec0918175
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:27:11.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D71WEkstBO+xiqLCScSGko69U0/so/RFGL79uvtTaKAdmBlEw3zpkW1dHuDp5k398u2PNjA2lVP2pOqyhiqqTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDDCD8AADA

Hi Joshua, Jonathan,

Thanks for the review. I will address the comments in v2.

[inline replies below]

On 5/28/2026 11:44 AM, Jonathan Cameron wrote:
> On Thu, 28 May 2026 11:02:05 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
>> On Thu, 28 May 2026 at 10:11, Petar Stepanovic <pstepanovic@axiado.com> wrote:
>>> +       return 0;
>>> +}
>>> +
>> I don't see any kind of cleanup procedure, like a remove() function
>> or devm_add_action_or_reset callback, is this intentional?
Thanks for pointing this out.

Yes, this was intentional because the driver only enables the ADC during probe,
and all resources are devm-managed.

However, I agree it would be better to explicitly leave the hardware in a safe
state on driver unbind. I will add a devm_add_action_or_reset() callback in v2
to disable the ADC / put it back into power-down state.

Best regards,
Petar
