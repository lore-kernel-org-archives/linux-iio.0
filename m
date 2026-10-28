Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180268;
	b=AQQuxgGyMgA9Ma+8Lwhh2kyBbCxU8E8Y8W1DWNESFuUp34KZC/q9BPNduyF3V31/9KIp
	 1kUC2I2sGewXxR047G1GnokGvmGL6Ea3sFFGmalZRs3fqxz3c85cpHsYFYEjTeqn8VLgE
	 1u+falIVw6/ex2XQ/x4mMb9wF5Vt2wAEqujhafDsu9QSbH7asaH8zkJXviF6iIEFDbViT
	 Gd+XPAUxNaZk+2PYQ/VEQrBxpH56BNJHl+veIP4YDMRp608cOtREbQlBv6NUb0XvdrNCv
	 TA5izl39g0ipeeadTKOdkKjoajcP/Ydt1Xm9/Vs+/b/rk6BZxKdUzfJBeD/vH63xm4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180268;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wzWwSsR95THZNUUOcSCbIAON0rb+f60dyaW4232cLvw=;
	b=5lX1ps9bRYxSyVpKwmB9JDHpQAZWMIT2BRgXXpsj6VGtWUMDyg/AAl5E8aKJ6Btu9neE
	 4C3K25xRWJC4U24emm6KhZM0ACeCyis9EXscSEvIXugi3PlpZ7Nj4msP5bHWuk8calL5v
	 ShqBBKIoKlO/orvjaN30jwAHhEtF0S7/8bux5zpRLPBc6zfupVJHCjn7ub4QCdOOyVfly
	 0Td+DbSZxeUipfZtRfl1nIEc9S4I1ErvvWs4R2Q0gdZR8IuMr3Tn9OryNg0MOzvFhsRTj
	 CPrUhqL9gNS+jKr7A4+jpGASEhaCL6XEhtRDG1io+nBZVTUt+Yy8Io2Iuh75v07poWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EoSmhyB4;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=GkD3lvDh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD0606A31D;
	Wed, 28 Oct 2026 09:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BD0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EoSmhyB4;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=GkD3lvDh
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8Gc951531535;
	Wed, 28 Oct 2026 05:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=wzWwSsR95THZNUUOcSCbIAON0rb+f60dyaW4232cLvw=; b=EoSmhyB
	4WlsFrNxlXwLLUpmfNupWgbQ8Och3BEj1uV14r2AD8/lmLbgJNQT5Sfu8lwaI9LX
	fmLOnOacxED7F64DhQFN2T2wXq7SXzT1iBUBTNxfDuosymWqfuSfswqV26KslP+A
	Ii+gHkMAOJnJX1u47IpKJVazsWevjgQAnAOLZqnUMIgGkngXZjDPIWt8W5bK1jVr
	XlFwfxu6nJjAKLflacrfrcvKTNuL0mUcB58eDFYm1dQRAWebhmjEvEZE5Vx+gMpn
	hn7+PO0VpCMCRa75rXmaObb/auiw9CsUNP1IOYxncLGj0ivqFmQxksSa21nDuR3Q
	Bju2W2VLEtzJOpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wzWwS
	sR95THZNUUOcSCbIAON0rb+f60dyaW4232cLvw=; b=GkD3lvDhtWFux9iOt3lsb
	ZkOZgFkDEtgydlAdDwxak+FEs57t6T/fBB4RcfquZjCKPwx+lxGElnFyT+1YjsjS
	adxz9btHYnKJq8EuG88ZietHC1ADIea+2NHCHpymK2SL+LXUwjCvHK5RpxWdpJQV
	3hvtMh5DV2H8LBRY7bWTHdDWM8HLhV6gbOtp90dNzN5x2+ugR5+XnXLEaKpH5YYn
	lndnVkXNqQjp34TN7xgMUhaYcdJvlCbEka95uKyit/JfelHerKUHkNIf4Gas/CnV
	NwXYvWj12ZAqiWsDVLj1isr2DRgX6y+e14zKgu4LCQ+26fPW8mQ+ddFyZBlpdHN2
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hkbu0gt12-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 05:37:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTLRp1JRT+Ur/pxY7+R/+xpWKCp7IPcL5RA7RZAZARnV5hsnWjy19q+GgWkZDUaOgCK7YOHeP3vh2L/JZbUgrYftUAq+sr6YjEFcYUkrwbdf4VBHjgJdu+ZvzLTyxTDNdksaMLmvZ3zLkn3GVy5Ctn/w0fwt1wB1Z+SsWYYC+GocxoSzpmwg0ZNOfDQiI3BcQCbIGQFURR3pujnf7tyK3do2I+HCFXKPp9TmuUm7yRRWBpVqUx6bSckBbLwacnZiQ859E/oqEgNXtuWw4Sv0WMn/AkaKf9vNrItBgYm5orumjLQenBaG8bjI8ceQqYiB+XrVqu5CQEeDQem4Pv1WtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzWwSsR95THZNUUOcSCbIAON0rb+f60dyaW4232cLvw=;
 b=LjW+Syu16JIM3zy74nyO1UNcJwlsdA67loPQJTqdk6kwqWXW9bkMURFntxZBeuT+RVc8onyuhla0CQY3F6tL1paTjzGUi9y6Ir90FNPG8ogw0oQRPb+s8ezH7E8L+/1HW9d1VLE99yOx8R59HdgiiGIrcvtOnmevk0WbIgGYBzSQxPw+fwL4pV/kueV00ADzYTCeyRBmjAGMNBE9ZMPVJiEX3h6f7GE8TvPOZ36/B+NfPtIgX9T2/NgiiZUpP2wxPoAaDD9HyYTo02alvHiUkCpnG2+nHWu3APFCeYMN7T/vNz3dj+7Kt4nY/kaNFsCgc2ZDDDNpQoKJ7QHayxDlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB5296.namprd03.prod.outlook.com (2603:10b6:208:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:37:34 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:37:34 +0000
Date: Wed, 28 Oct 2026 09:38:57 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Leonard Crestez <cdleonard@gmail.com>
Subject: Re: [PATCH 02/15] iio: trigger: fail the attach if no sub-IRQ is left
Message-ID: <auHCnFusqaw-CT7x@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-2-0d818334f6c7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-llm-char-misc-iio-v1-2-0d818334f6c7@linuxfoundation.org>
X-ClientProxiedBy: MR1P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::33) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN2PR03MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: b091978c-68fb-40fc-8177-08df34d7183c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|11063799006|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 hJaQv/rIoL9IuEFcC7vw4wP9fZq9HEa0zDI2oVJqBAAxl1HcOq3WaTHF3XfU0DafNQRaHny7m4gYjs7jYjXKCwhgOYTCw2t1RME3pScdCe7fPjRLN20qq8sEGCbSycLQn2MZ0KRH3ByNKnFcW7oVw7rjeDMrxpmXKJT9MRbVYitg3U1myrhrMGbFgXtI8f9en1ESM9QBQEM5Lwhmx8xs6VnEy0KqZ3kdSmHXlBOynch+cLtsj//fKJeWD9iAGKIwp65gUT7FzQ//y9uhc9lwNSHgD4fDjYp//ishn+vrYJLHD05gEY4WW2onZ3jeHacXGMxr2nA1a4zteImpmGx7lQDj7Pe+cS9Faw/9b/0u0w+1yAQuxSWr5xOH6OxtY2AgMyEFkmx6jjDCycwcZCy9XlNhIFCLtpYVxjuj1AGjninzD0DmfiDIr60TYIt3mzsmNQ1r+Im/BN+2WnplsuNkAVKpl1X0RCzt1QJHr2Hg3EnNqmfB7rR46FUNqqpsmJlE9tJ/9tisB+CxqoSVsGHvEMpuPGLGWEs+oIBypc5YKsbxLn6mTVDXAMFl6nkqv2h8X7hOUHPdWdhxafnunWe3H+CpFHlSkghpy5gOzDTA074S1LVgfjSf91qIIj+22Hr6HY16LVd7IiwDvaKuwLSarpiI64Jz6rM9MqDrMvg67lA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NXVUUmdVOVRJblVmVHFxcHlKQ1BDMXFEcm4vMURCUmRaSkZiTTAxYXQrbXNs?=
 =?utf-8?B?OTBrVTM4TWJwUTJvMHR2azdBNDIvT2MxUGhwRHFMcitUNkpKME9ZSzdDM0dX?=
 =?utf-8?B?WFF3SzVIV3F1U3A1cUltTVBQS01YT293Y2hxNVdZeWtEdTNmOERnK3BLRThX?=
 =?utf-8?B?WVlrenpPS0FEdjd0d3pNR2NScWFBbWdLaTBqbHV6Y3VLZE1tYy9QaTE3Y1lZ?=
 =?utf-8?B?WkRxT0VHOXp2ak5YRzZRZHpRSkNIMzBkdmRtYkdadExFZSt5K002dFFMRldt?=
 =?utf-8?B?MkVnRHl5ejBJS3NyblVlQTkwcEwvcDBCZVJDN0tjOEFnTHlEVmJQSjdwam5K?=
 =?utf-8?B?QjRRN2I1YW5xU2ZNYmJrcGRCUko2eGZVaUVyS2NSQVRyekk5ekJpQURmN2R0?=
 =?utf-8?B?VW5qZnozVU0yY2ZBMVJaNUtZYktHNzVMN1d1M3crMTFQQ1lCUm1GcVE1Qncy?=
 =?utf-8?B?SHljYUZyL2htTmFnTHRHWmdLYlRDcE14eGlpbFdQd294eTNMWFJjVkhobGw2?=
 =?utf-8?B?bkw5bjBqL2JocWxFWkVSMU02dDVYUHhUOVJ3T1RLSVVvTU01NWRRSUNZV2RC?=
 =?utf-8?B?L2N3V0wyeWdLTWE3T2NDMDBScnRlWUJEZDVSZi83OEh2NEZ3enhJZjRROWRw?=
 =?utf-8?B?R0lrRkFHNm1PR0lvY2EzS2tzcHAwYzFKSjllUC9BVUN5T3I3RWgwZUNiT2Yy?=
 =?utf-8?B?SUt5OTcvVkhmNmlYbFFSbXJoOVZOd0xnUDRiQ1hXOGEvbXhCSURoVlg1b1Bp?=
 =?utf-8?B?aTBFOFJnbGt1SDcrcUljeHJSSDl5MVdqVEp6bkJTeG84bWhIdVR0MjgraUZz?=
 =?utf-8?B?OWY2WWh3Tm4vMy9lRlhJQ0NTTXQ3cWQwdHlzMG5TbnhRcHpZWDJGczVWNUF5?=
 =?utf-8?B?c01zZCsxWmx5MzRtd0ExVE9uMU44Y29Gd1JocnB2VEVMOW9HR24vdUt3RkI1?=
 =?utf-8?B?VHd2alZoYjBSM1k2VFU2ZitGQWlEVXhKZTdUdUh1SWdxaUFaNFdRb2kzYW5k?=
 =?utf-8?B?cm9KeWNxalNSQS92TEIzcFZTMlBneHpzOXBubTZKNjI5NmJNRldqSDZYdlZ2?=
 =?utf-8?B?RGlBcmRzZnNsY3RRdFlqZTRHeXlrcmtFcStLeVdEVzZCTWVPYXYyR3VsTjFk?=
 =?utf-8?B?T0RBZDc4enVQaDZzMmlxVm9MMEx2M1dmT2hUN3FrWWkraEVSRVZHOUtBa2c1?=
 =?utf-8?B?TWtEU0FzOEJiVGpWQkxXZU5XNG9ZVVdHd3lTdUtVa0VRK0xmQ25YdGU5M1J5?=
 =?utf-8?B?aVBTSXdvbSs5Uy8wYngwdFBPeURwS1pMckR1ZGJRam85bHJ0Y3V3U0xISjNW?=
 =?utf-8?B?Slh1ZVV2NXdMNHdGTFliZXlGSGorOGg3YVB1RDdUU1FWVGdqMC9VUVkrTlhS?=
 =?utf-8?B?OGN2eXd4blZVWkhxMjBTT1EzSmc3QUNwcVpacXE1aTJOL1RWTm4zbkliT1hj?=
 =?utf-8?B?d3l5dGR4Y1JwODhReFZoaDFFbklXRzBFODFBVWliT1lGT0FuMFErUSs3eHgx?=
 =?utf-8?B?S3NMTHVXS3lPOHBxdWpQeTFiWWdyVmN5dHVkZGdxbzh1NTFOOTZaZnZvRnMz?=
 =?utf-8?B?TFBsNFVNRVlmNDFmVEZjcnA5UlRTUVVpMUlHa2tjNk5BaXN1YVZGOStvY1U4?=
 =?utf-8?B?aUZGNWdITlBkL3U0eFFKbmV5TnRIYWswT3N3UEJqQnZ3ZzZjY1I1SVlLN3NO?=
 =?utf-8?B?R0dEL2tYYW8vV2k2MVJkZmNBZEN4WHFWdnd3NFI2ZnQzSGR3YmdsNms3bjNS?=
 =?utf-8?B?LzJvZmRjMlZJdGFDVXdyNUJwWXhNTm1oRXZ3VWhCZmdYeVZaN2lFREhnaHFT?=
 =?utf-8?B?SDU4MForQUkrSXVkc2p1TjAvd3ByRExIdVFESjBRc0pQNmVYaDBIZXVSVkZO?=
 =?utf-8?B?cGhvZjBGZjB1WS9HL2tGZEtnRkJDSXl4TVJYaHRXbFljS0lhRERvMFNqd211?=
 =?utf-8?B?V0lHUFdEcTFBY1hQWlVtcUE4cE15ZG9ZbWp3TzhwdklVeWdlZHdOSnBFZDBs?=
 =?utf-8?B?VkxKOCtIT0F3R1gwUW95VW9lNmpnUmFXK1hrVitXeUhjbGlLTjdRQW9KZ25p?=
 =?utf-8?B?RTdFWTNDdzZXNzJmeDRnK0pjaE1mWG03dGZmTG52WjZ2WXBjS1FoVjNEbGtF?=
 =?utf-8?B?emVIM2tWQzMrWG5nMDRaS0RuR3lHU1cxNVlwMFdTbktLdmhwNk8wUWw4cFdX?=
 =?utf-8?B?YXk1UnZhSXRTeTF6bkJ5QjBPZjZXSHUvYWcxNzRVcTl4UmU5bmhQVU05MkFV?=
 =?utf-8?B?R1RRNjlkUjNoYmZBRk5aUlljUWFsT2ZzTCtFN0Z5TVduUTlOc2EwLzFFK3pu?=
 =?utf-8?B?dWNsVldSZTE2L2JvYXpQOVNNNHA4MDMraFdOL2lBb25EdTJFUFZwZz09?=
X-Exchange-RoutingPolicyChecked:
	465XsQysWSCY4BRirXb9QCohG9Y8BUJf2+OBRie07anxker8J3T1RBZX2CNNW1vHqkoTRJVUWwMSo3+daoaxdlsWfq+gxORbqNSknUYT+ZDmONfOCJBo4In9GOUT3fFXqP+X7YMpLzJ/oeRmNcKLjOIuszm9J1ywzvYuxHWgzfA0OnO+nmJQc7ViI0flQxDoT1DSktOu4tdJ4UmAxHcDNmF+YGOm5tGCgWFGNjMxqlov4vcSYdmqyuUOawfh3YSPRg5l+iOBVGI1u6kjNBEA0khbgDEBanOjPg4yhonQ02aAoBk2Cn2DLeG8mUQK4IeGt7I/gVGNdyIIZ11qIrDcjQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b091978c-68fb-40fc-8177-08df34d7183c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:37:33.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0dkdYrjB7i07jt+Sww6BuNs8NjlVlyJe2RCNxvecbPpxKF8g/PSPs2jNRNFW4GJjjLsJvlskGTkPBG1GweIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5296
X-Proofpoint-GUID: uglzhl2g8jY9qlQXwMaArjrE5qtATk_p
X-Proofpoint-ORIG-GUID: uglzhl2g8jY9qlQXwMaArjrE5qtATk_p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX1UMeD7h9SYuR
 b3nQtXgSAAH+N/ZfEpv98O2b2tcjm5vLZzaM56ojKSz7l+lj5dxxM4id+k3tKBrZIQ4qyhCdKSJ
 5OSWh4llZDs8vj+RKzMaLqpLYytIgvA22BeWIT8udd5VJxO1++hL
X-Authority-Analysis: v=2.4 cv=JdYpPkKV c=1 sm=1 tr=0 ts=6ae1c261 cx=c_pps
 a=8DpcgsHgAViCMqsLoRaOsQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=zsgU9imimr7uiJ0zbdMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfXxtVCVb6JGCYS
 dkwLoQKiEU9e6CFpr0G0S6xWFxWPA6o/eR+i5McTnmFLCvvNtzrzPBlB5U/bq+5OpQWWy57h44r
 gvdA+YuT4sYLsRNtIm0jtzm1JCjK28XcLf52mgl6ZVaBe2JNdzgbclv9E5kWBiuv+hzIRW3O0OU
 AG3L00imtMScqsCAqygwP5/H0V9uLc2z4gyb7y8aA/02GCEYizIrFQvCW+hEPSpURcwVMQ8j39n
 GDn+5C2fNqtXqyoZJc2uUK2nsWrh+9nQB5lIAms46N7SQJAZ0c5x+Zzlwc07a9ru8qvXDSx5UIJ
 gQ4JAGZtmFaEMZPFGn5xrG6od17RoY3I+jqKMxLQB3Cab+/MvDwl3n/V+2zJFakRF7nmVBfKfzB
 Ul9gXBSPu2QMFTMhe6f9Cikcp/xAOEQwyOgNHrgRjOlxa5nXmpvOljuaNRl+k6G1u51SA8y9dWf
 cglM168kDlCt4XjHPGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280038

On Tue, Oct 27, 2026 at 05:19:06PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A trigger can serve CONFIG_IIO_CONSUMERS_PER_TRIGGER devices, two by
> default.  When one more device is attached, iio_trigger_get_irq() returns
> -ENOMEM.  iio_trigger_attach_poll_func() prints an error, drops the module
> reference and jumps to its exit, but ret is still 0 there, so it reports
> success.
> 
> iio_enable_buffers() goes on as if the poll function were attached.  The
> write to buffer/enable succeeds, but no sample ever arrives.  When the
> buffer is disabled again, iio_trigger_detach_poll_func() undoes an attach
> which has not taken place, with -ENOMEM in pf->irq:
> 
>  - iio_trigger_put_irq() calls clear_bit() with the bit number
>    -ENOMEM - trig->subirq_base, which clears a bit in whatever lies in
>    front of trig->pool;
>  - if only one of the real consumers is left, the trigger is switched off
>    under it;
>  - module_put() drops a reference to the driver module which has been
>    dropped already.
> 
> All it takes is to set the same trigger as current_trigger of three
> devices and to enable their buffers.
> 
> Return the error.
> 
> Fixes: 995438233579 ("iio: Fix error handling in iio_trigger_attach_poll_func")
> Cc: stable <stable@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Leonard Crestez <cdleonard@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/industrialio-trigger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 76926fee0f84..fc4651490d42 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -293,6 +293,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	if (pf->irq < 0) {
>  		pr_err("Could not find an available irq for trigger %s, CONFIG_IIO_CONSUMERS_PER_TRIGGER=%d limit might be exceeded\n",
>  			trig->name, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> +		ret = pf->irq;
>  		goto out_put_module;
>  	}
>  
> 
> -- 
> 2.56.0
> 
