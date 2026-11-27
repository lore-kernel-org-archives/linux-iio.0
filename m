Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795777503;
	b=PkbU10WSN57wAjo+eHOu37MENTQ75xp+MYCUzi7P32sK4YEmoieeU3mSYiIfmWgBkSqL
	 CT98FmNBH6o8HzJBN2rqP3RTqM6HuYcilDZELXw4avOJjB0WX0UKLGJsiEp71c9gGKOh6
	 fiQE7plCLwlcZqCj6sF7HDKBhP63f4AeScCB+C2vS0A4b5/1R3FLsUtwKXBAPDpBYSi1Z
	 gU6fNglGXptD1mo7bf/vL4rEI685QcK1A8cdTh+67XOpS7Qb4erg2jh6VnkciErPssvj5
	 +0aVysfYr7EfNjF0GAMSyyyRIcql8M5ypw6X1f2ph6+yScwQte+Wx9lWuXeSCf6U2Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777503;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HHZMo0QpA/xKu7+xi5ZSvLVpDd0Jd6PwUiREeo6h3XQ=;
	b=ej8c30fI+aAidCTsXeOubW+wbYVzBCXTzDVeUzMXr45rGR3dXk2n/VorwMSgBlpviWOg
	 vfU2vo+lqNbOu/VLkIdtrX1KqHJcAdyEFG9qEc4KyvfIYLOXjAs562zI8OjulAze+Dqii
	 WhinnaZ2gwmBzPdYhpq/rrRL/baa01Tlb4cS1DK6fLhk8RtDAo3hnwIKcgNiUjX9KrAb4
	 ygiY07osJOdhybWB723jLVIfu8947Aut+GyMSG3wMRByH8lzo71jH0h/66U/NsgLYyO3U
	 AoHyhAxS370J99CDkzxde5woSjpi/kBLD0I0SFd2dU8k6K05vVJO4waXVm+28or3AhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=aYJVrOPV;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SpXdwNGd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BC606A31E;
	Fri, 27 Nov 2026 11:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 622BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=aYJVrOPV;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SpXdwNGd
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAnxXI3363257;
	Fri, 27 Nov 2026 06:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=HHZMo0QpA/xKu7+xi5ZSvLVpDd0Jd6PwUiREeo6h3XQ=; b=aYJVrOP
	VR5SenmGjlhWAgiETZHx7D8j5ty3LQZghaDn4i57RagK/Wku7b2hEciezpnzCjeJ
	lievJhfgHDpMN8dQt9ADCirqtRDFIBCELM8eDCONj0o5M5wsXNM6lM0SirnPDjRS
	gGzPeaQutFmPoae3vJgqhlCx1QNIc0sjg89uxOyAOd8sGrrO/aAf4yYTwWAZ8bfm
	GMeivNglmaZYuNJAhPcIuftwuzcL8SabY8KkifuE1+MtEkDckSrKX5elTLkhihVm
	9O1O3ky5OwDdb6KY5mDkN+glbA17sYHvuPo4h5mxDeTXyeBmq5adgCpVym1iIrBC
	u+uYOOXQS4D28GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HHZMo
	0QpA/xKu7+xi5ZSvLVpDd0Jd6PwUiREeo6h3XQ=; b=SpXdwNGdai1/AIlRFLAUd
	ec2qI9iGhcbPcxm7oUTglsQPVBDmoEZbtZ/zdh5NvGa+mW9m/2rV3Y2RZUlVbN9a
	2SC8sxwjBYcb+87UMmq2mpNs8y1of/5zKxzg7dVVY2aIa+Dq92TI6EN6Uwrs26Gx
	TFkSBRWeeOP/1dJ8frAxqDSV7vW1msUsUv56x12Ja0TPVz/+jY5SWF1nswc+bGOG
	ZYDB6J6BoESmPZKekgL/KwEduhwa2UCqckCSa6oIjEwfH2ScJeWytzie+Y18t3tP
	ydoTWmYeA8uQqEMKNE90hww/9q9yD9aCXUNvEIZ6dnJLLKdKMxcEOhW4xlgZZ0WK
	Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j6a88ftej-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 06:04:45 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWdG3cc4A1tXefl99TDxZ8zsh8JZIJaOKV6gQqjRCQzTzxZKr5aw9T5QRRlbckhXlyKpdATqx9LcLtAgxV3kMV1IkhSrpqKlB/SFxl/OPEWez6sUuckj0M7BFkFCbp4TAUcH6vhwzA/gJ6wNqU5WLFJ4vWYjRHE7CzrAw1BUML1BDLQpCub1SFle2NjZmwC35k/ckqQRX/143Vq+T4UnF1ayqtLT/if2IgEqzeCYeSCYG4vAnQsFzQqtjHgPEF7LUWmZJLNO3bfYe43XCsaQmYuXCE9sb6sLp+V8NfFnBPaW9c7LXXeU5gLqHJvdF+mS+a3p7wqk4O1t9HtPdcCokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHZMo0QpA/xKu7+xi5ZSvLVpDd0Jd6PwUiREeo6h3XQ=;
 b=BKYjEqRFErZMBUY6GPp2nV8oAk8sSMpebQpuk4Z40tMdmykGEPEq5bUvTbQ1wkT0cl8bzE1O3jWnGj98naFTCr22DBb95D6h82YoK8DroMifVZM12HMWe0pgCivZCDa5oaQEnHRojNO8UcQ0hUETGKtI2+Zvi+8Ub+nRy1ZVkn7coqrkTg99mKnv73Dm1iW50cLvj98JcsXztauRaU2DNK9CRxMVYsBHbEOFOCnQnQM4As9CcBtLQewd4EKZ07ejO6r7O5Mzd15IB7Hb2uTwaVOh9vYyT0fBzZPQsGFc3E/8PRqi8KtxgrzC5kzhXrEW2T/scfTIGbKBfG/YjcgX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CC6PR03MB085531.namprd03.prod.outlook.com (2603:10b6:170:204::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:04:42 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 11:04:42 +0000
Date: Fri, 27 Nov 2026 11:04:36 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: add AD7793 and similar ADCs
Message-ID: <awlg_vzuEmw95dQM@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-5-54e4c8830b57@analog.com>
 <20261125-whenever-spinning-36a6dc477a00@spud>
 <awgLBWt6MWIRK-cM@nsa>
 <20261126-hunter-catatonic-12f9c835f94e@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126-hunter-catatonic-12f9c835f94e@spud>
X-ClientProxiedBy: ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::26) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CC6PR03MB085531:EE_
X-MS-Office365-Filtering-Correlation-Id: 84404c3b-78a1-4721-26cb-08df4c763c9f
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|261021135927099003|261021123027099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|5023799004|4143699003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
 HjwKNb5M4zZdaFDi5u3/ofBpqKhUGc6u99CSWjHIyHWdVO67yRFaf+MmqudbEvFoY611L8Gs/RSOc1SzIUWaDT/ln480p2U4YenIg/EqdFVXiMhwke+769XtC2CRTj36PIYJKNfbUXqfXuzT2Z64EfDMEu7Y7N2xgOphATIZXSpWYM6mCICTqLjVE3N+FrkFRkL44P22Obuf9hdPUcH4gtYCdU5t6gYzksv/GSXprEPVnjFAuLbywSErtC3GyfyfdQTGYHBnSwMi/uIcVbkom0BLlx9uf8SeGBjgdpM+4sMWzkKZGrRLVuUoAWoAh0JeHsPA4B9jaQcmvcwmelD/oY3v+bV8Ph/uReiiSYC1vqgVOSCauFABDrKS5IM4ZD3qozvEgIQNCBOZmn5RXpuT90yfbUp912YYKXzcuCPCnGQbQG1YDXhv/8UWZk8z4fL5NaB/FJSD7x7KVOS36phlQRGyga3kZabBkjzNfmAHZJE9JfjZMWtiR8m53HU9ISYRoXRusCQi8atBVS1DkrzD1nc82PblnMxZTtWCELVsejfvKZgsyWm6f3Gri5BTXiVPoBapD6W1SuSgo580J1o/7luxSsWOl1wFZeH9FhP8fBg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021135927099003)(261021123027099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Zmd3bDliVW5Bd0lkQnB1YmxVYkVoRmp6SmJFOEtIY1ozMlUzYUJnUTZOcWxZ?=
 =?utf-8?B?QlROSS9FSDJsUDF1NkpubWRBNWxmbUFpOUFiWlp6YmJGSDAveTBHN05LbDJE?=
 =?utf-8?B?NGtqUHl1aE9QTExUc0ErYzVCaURTOTFjVXFqeGVJZzRDU1NoVkN4cUVSU3hV?=
 =?utf-8?B?bEMvSHIzZHFmNU1OUFpUQSs3ZFd1TGx2a0pIclBBNGRRMndPZXhCWDJYWWlo?=
 =?utf-8?B?ZCtOWkxydTRzemZQdFJJdHBIenVRZmZGSVF5QUZsUFdhZXQ1amszMnp5eXhZ?=
 =?utf-8?B?RG04T2NVZEo3QjNYN0JYUU80cng3S0dPMmRJTkhUanhrdGJzQ25uUlZXeDhl?=
 =?utf-8?B?U1VvaU4zYit6aHVtc2hsVzlSeW1WbTgxRFYydTBBY3Bob3p6K3paSDZCNkdr?=
 =?utf-8?B?UTF6U3hpSnRXRFQrSVd1Z1hWZExLc3ZlWGZob09lWC8zQzlidzlkWXJianF0?=
 =?utf-8?B?VFlNZldYWDZOY01ubmRMV1dOT0RUZ1dtY3NUVU5QeWc5c3VlK2ZNRHBkRnZs?=
 =?utf-8?B?SHU5U2REc21MbUdwcm9hQ2xZcXhrWUpxMTNNM3l4NG9iT1NheGg5Mkh3MEdq?=
 =?utf-8?B?bVBmcGphaSs1enMvN2dpaWQyYUhPKzBMaGdaUDlVSDUrbDE2bE1NSHBqRUZP?=
 =?utf-8?B?anZ4MW1BMGJFOXJXNXErd1pnTWIyV3gzNHZOcjEzSUE3bmUrSjdkeFhZTFBF?=
 =?utf-8?B?OWdqY29LNFBjSTlEeklUckR3dG83SjU3NUhkLzhQM3IyUTlvUGkzdWNsTDVU?=
 =?utf-8?B?VnoxL3Jad2pYVXhWUSswdUQ0bkZQZHNHeFNxOEkrSkhYbmJzajJHSGdBOFha?=
 =?utf-8?B?Rlc0K3RaOEorL3JBcUVWZmVoSkZBZXF1T1NKQ2hybnRhTkltSGpVNFBsY3o3?=
 =?utf-8?B?Z0NrWEo2YndjREZncXAraHNjSHV5eU5ocDRRdlVxZWttaWFHTktaY2oyNmVp?=
 =?utf-8?B?YXZSNG1YUG5BcEZLYnlOVjlJQXRNV2pIQWswQ1p2SFNqYzVNWGhJbFlpaHEr?=
 =?utf-8?B?UTkycFJQc0ZGMTFyOHYweEo1VnZXRXZQbVRMSnJmY2dKU3MzK1IxMXB3OG5L?=
 =?utf-8?B?RmdRMFhLSWRjdDJ0bTJJZUJTWkRFb3dGK3IvTFdvSHZQMmZNaDVQU0t1QVE1?=
 =?utf-8?B?SGlUczRKekxXdE8zek9IR2lLQzFNNFhOQi85alYvR0JXemE5V3BVUnlIT0dB?=
 =?utf-8?B?R1JDYloydXplTE9mME9heWRqSmZaREFPZmpSUlh2U2t6NEt4WEdobkszTCtC?=
 =?utf-8?B?SExpRndTd3YrN3hqV2trWUtzcmxUeGtIcWZLV2xRdElGMnlQMVVPN3BtbkhR?=
 =?utf-8?B?eVovTlIvTnRUdTVSTlpoNkRYWGhlUVh3eFRXbThqUTI0QWFCOFAvbE1URWtT?=
 =?utf-8?B?dmNRZjJISmFwS2hsZHVyUUxUSlZFYi9zRU5YM3JxUXVCRWVMTlU1UFFJK0Nr?=
 =?utf-8?B?bE5MUEUvcDZIUC85RTRRRmJIS1JKTm52blhBZFB5djIyb2ZLLzZKallsZ0s0?=
 =?utf-8?B?VVlwSTZXbUoxVHc2TTBCOU5jejdPdVFPNExoMVp0SVNqS2VCWWdxQmpPamhJ?=
 =?utf-8?B?RXBlU2xsUTgvcjJqVGI5b0xveWVBZ2x6RnF2RjB5WHoweGV0Z3ZNcnJTVkNZ?=
 =?utf-8?B?S1dxZkt3K0JXajRrRHF3OTZKaTR3cU5ldlRFdzhaUjUzS1hyeFFvaVphRjY0?=
 =?utf-8?B?dm8vb01YRExydWtLdlNlTmFkdy9mZ2Zlc1RnbkxWc2RCVWQyZThiSkRJalNa?=
 =?utf-8?B?NGlKbEVpSVl0MkJBcXIwMU1vSU9zK2pWYkhoUVpCSFl1ajBWODgyUmxoR2c3?=
 =?utf-8?B?aHV5aGwrcUJhaERkSlJZbUloOUY0M3llRjZXaStLUGVrTW81QThja2pEekRY?=
 =?utf-8?B?SmxRNWlGTjB0R1Zyd21CUmFUeDhOcUp3cUtxalQyVHk4OWh4d2N5cmZwclho?=
 =?utf-8?B?cjNxVU9iSnlXSXNVVXVXdmRGR0N4Nmh2OEVjM2tlRVV0Z1BlNGlEcUNBNjdF?=
 =?utf-8?B?ckxCdmRRckh2blptVlBvekVzR1hTaFN0aVVFRkN5K2psWmFYd2crdUdoNmMy?=
 =?utf-8?B?b1k5dnFBWStZV1NGcDd6ejFoVm1ySEhwMnFnT0FsbXZHUDBlTkRNMkNpT3c4?=
 =?utf-8?B?MVlVSU53ejlEVW1jN0xBaEJtczlRckFWR2F3d0RDclk5ZGRsY3FUb1NxM013?=
 =?utf-8?B?cnREWE1wMnFRVXBGbnlrKzJsaTE1ZFBUbVNpaXA4OC9jcGdnL2dqYWpicG9G?=
 =?utf-8?B?WUk5Vm1aTWFhcVdZSEltQkw4Sk5ieEdYUUw5WWFBVlY2ZmRDaEdYby90QzF6?=
 =?utf-8?B?RUoxM29ZYksyTGdoOHpLdmFMRjlRdWpEbStZVkNFd0hwTlVueHI1UT09?=
X-Exchange-RoutingPolicyChecked:
	FdEAk2rDKM9HtLmNE71uYJp3YlSpSscqsWKiUpKBxDzS5h8o3llqs1RsbcwlN1R6WDmx9qnZi7jYT5OrH3x8H/vxnit5hbwB9Ul7DwQ+RoPc/N80zNGQHZFiOpsLH0ADfwuD4A0KfB8cy/SH9ux9k1Rddqw2uyVpARpZD883v14cyc8m7GIzjLCA0udYX27k5yfDnfGEyRxTfEGg1yvg+hSmolj57Z3+cqPfg3mz6LbIHrZTn8Sm35KMLDzhs15QpaoP+FDHU/EXjDxQ7HaqypfBCO7k3ZkVXm9M3PRmm75A/+NzTkrpk7eGY86ppjnOMo05zDupEoztxK4zyqN62A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84404c3b-78a1-4721-26cb-08df4c763c9f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:04:42.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlQNaWIQ8sf/FHh/PlKZdIg5m/0gkHDW0iJmjyoXjrIJADJcWMVtZOiB2+a3/LexXoyKuhCvXanGnTUVkLbOkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR03MB085531
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NCBTYWx0ZWRfX/veAqVQyPN5J
 /6phcUYjyd7ec2PMnfE9wIRRaJpt7fs3gSygnSi5i/FzpsTb3uab6oZqmfbOTgdzLu1puXzeJMu
 vtHuCQX7yTgRpAkfo3fRoP4bU93kpONC1PRa3qQ7SGx5Oe+uCKQ5N1wyGV9K8BwAweF2KL+jq2b
 wixVtkSO5sB/qfKbyLg99zWaPfVZzWtAlCutKYuMAWeOsMh2SqgzEh0DuQzSblm78cdN1R4fxjg
 z5E81W9CnWfOyGXTbOny4hKYIM4LRRRNYvxiDglK3+YxPS4MmoxLebbqkCYrnWdTR2d02sPOxgi
 s6VwYaF/mqCbhjw6SLxl94pBOeZsrk9p6b09K0AWzRac+JTC7rTVk6+qZ5uBSyS4hKBR548Hho5
 8HvoYaOuuESjXbAT5Ja7t8zqbCdl8z1xMrKZFt6thvtjM2xzraMyQy2Nd5+leTLIQ0KZ+CscoSp
 3V40q47kGHha3bCJe/w==
X-Authority-Analysis: v=2.4 cv=Dp/Da2/+ c=1 sm=1 tr=0 ts=6b0963cd cx=c_pps
 a=Ie8oki5xhBv/1/1SVvCQdA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8
 a=lGrM5QUWcQ9DAXPR9JcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: zG0jyXY6ysyrU0UEkyLAB1TNgqJtEyV3
X-Proofpoint-GUID: zG0jyXY6ysyrU0UEkyLAB1TNgqJtEyV3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NCBTYWx0ZWRfXxDKQLV26L4i3
 GUhqlCeerNOvM77Hm7hOT30u/R8zNUnGhu+vZd8nDJqMpK9mLmbpao3EMADDdR9KbISBujA2Sap
 gRMQgalsocZhwPkOFqmAZ6cpeF3VUgDa1WBUsDWKzF/N8aHJ7Xrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270044

On Thu, Nov 26, 2026 at 06:25:13PM +0000, Conor Dooley wrote:
> On Thu, Nov 26, 2026 at 12:24:28PM +0000, Nuno Sá wrote:
> > On Wed, Nov 25, 2026 at 05:41:08PM +0000, Conor Dooley wrote:
> > > On Wed, Nov 25, 2026 at 10:19:21AM +0000, Nuno Sá wrote:
> > > > Add a binding for the AD7785, AD7792, AD7793, AD7794, AD7795, AD7796,
> > > > AD7797, AD7798 and AD7799 low power sigma-delta ADCs. The driver has
> > > > supported these parts for a long time, but only through platform data.
> > > > 
> > > > The ADC reference is described by which supplies are present: REFIN
> > > > (REFIN1 on the AD7794/AD7795), then REFIN2, and otherwise the internal
> > > > 1.17 V reference. In the same way, an external clock on the CLK pin is
> > > > used if one is given, and the internal 64 kHz clock otherwise.
> > > > 
> > > > The remaining properties describe how the analog front end is wired:
> > > > the input buffer (enabled by default, as it is at power-up), unipolar
> > > > or bipolar coding, the burnout current sources, the bias voltage
> > > > generator and the excitation current sources.
> > > > 
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/adc/adi,ad7793.yaml    | 236 +++++++++++++++++++++
> > > >  MAINTAINERS                                        |  10 +
> > > >  2 files changed, 246 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > > new file mode 100644
> > > > index 000000000000..c4a0be06e5c0
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > > @@ -0,0 +1,236 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7793.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices AD7793 and similar sigma-delta ADCs
> > > > +
> > > > +maintainers:
> > > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > > +  - Nuno Sá <nuno.sa@analog.com>
> > > > +
> > > > +description:
> > > > +  Low power, low noise sigma-delta ADCs with an SPI interface.
> > > > +
> > > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7785.pdf
> > > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7792_7793.pdf
> > > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7794_7795.pdf
> > > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7796_7797.pdf
> > > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7798_7799.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,ad7785
> > > > +      - adi,ad7792
> > > > +      - adi,ad7793
> > > > +      - adi,ad7794
> > > > +      - adi,ad7795
> > > > +      - adi,ad7796
> > > > +      - adi,ad7797
> > > > +      - adi,ad7798
> > > > +      - adi,ad7799
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  spi-cpol: true
> > > > +
> > > > +  spi-cpha: true
> > > > +
> > > > +  interrupts:
> > > > +    description: Interrupt connected to the DOUT/RDY pin.
> > > > +    maxItems: 1
> > > > +
> > > > +  rdy-gpios:
> > > > +    description:
> > > > +      GPIO reading the DOUT/RDY line. DOUT/RDY also toggles during SPI
> > > > +      transfers, which usually triggers spurious interrupts. Reading this GPIO
> > > > +      allows to tell those apart from real conversion done events.
> > > > +    maxItems: 1
> > > > +
> > > > +  avdd-supply: true
> > > > +
> > > > +  dvdd-supply: true
> > > > +
> > > > +  refin-supply:
> > > > +    description:
> > > > +      External reference applied between REFIN(+) and REFIN(-), or between
> > > > +      REFIN1(+) and REFIN1(-) on the AD7794 and AD7795. If present, it is used
> > > > +      as the ADC reference. If neither refin-supply nor refin2-supply are
> > > > +      present, the internal 1.17 V reference is used.
> > > > +
> > > > +  refin2-supply:
> > > > +    description:
> > > > +      External reference applied between REFIN2(+) and REFIN2(-). Used as the
> > > > +      ADC reference if refin-supply is not present.
> > > > +
> > > > +  clocks:
> > > > +    description:
> > > > +      External clock connected to the CLK pin. Either 64 kHz, or 128 kHz in
> > > > +      which case it gets divided by 2 internally. If not present, the internal
> > > > +      64 kHz clock is used.
> > > > +    maxItems: 1
> > > > +
> > > > +  bipolar:
> > > > +    description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
> > > > +    type: boolean
> > > 
> > > This is odd, why not ref the file normally?
> > 
> > Yes, was not sure on this one but saw precedence in:
> > 
> > https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml#L106
> > 
> > Which might obviously be wrong! And I just noticed that in that one we
> > do have it again referenced in the channel properties. So it might be
> > just some legacy thing.
> 
> Ah right of course, adc.yaml is for channels...
> 
> > 
> > But in here the case is really this is a device wide (not per channel)
> > property. But I realize that can just do:
> > 
> > $ref: /schemas/iio/adc/adc.yaml#/properties/bipolar
> > 
> > right?
> 
> Happens a good bit for ports, I don't see why not here either.

Will do.

> 
> > 
> > > 
> > > > +
> > > > +  adi,buffer-disable:
> > > > +    description:
> > > > +      Operate the analog inputs in unbuffered mode. Unbuffered mode allows the
> > > > +      inputs to go from 30 mV below GND to 30 mV above AVDD, while buffered
> > > > +      mode needs 100 mV of headroom to the supply rails but tolerates source
> > > > +      impedances in front of the inputs. Buffered mode is always used for gains
> > > > +      higher than 2.
> > > > +    type: boolean
> > > 
> > > What determines if the gain is higher than 2?
> > 
> > Userspace does, through the scale attribute. So this property only has an effect when the gain is 1 or 2.
> > For higher gains the buffer is always on
> > 
> > > 
> > > > +
> > > > +  adi,burnout-currents-enable:
> > > > +    description:
> > > > +      Enable the 100 nA burnout current sources in the signal path, which allow
> > > > +      to detect an open circuit on the selected analog input. They can only be
> > > > +      enabled when either the buffer or the in-amp is active.
> > > 
> > > The former should be somewhat enforceable with the binding, what
> > > determins this in-amp's setting?
> > 
> > Same deal. For gains >= 4, the in-amp becomes active in the path (and the buffer is forced on),
> > so there's no way we can enforce this at the binding level:
> > 
> > For gains 1 or 2, with adi,buffer-disable, adi,burnout-currents-enable is irrelevant, as the
> > datasheet onl allows the burnout currents with the buffer or in-amp active.
> > 
> > For gains >= 4 it's the other way around: adi,buffer-disable is irrelevant.
> > 
> > So it should be the driver to make sure all of it remains sane.
> > 
> > But I did take a look on the datasheet and this actually seems wrong to
> > be honest (the burnout stuff). Datasheet:
> > 
> > "These currents can be used to verify that an external transducer is still operational before
> > attempting to take measurements on that channel."
> > "For normal operation, these burnout currents are turned off by writing a 0 to the BO bit
> > in the configuration register."
> > 
> > So I'll just drop the burnout property and maybe have it as a debugfs
> > thing.
> 
> For both of these properties, I think meaning assigned to them should
> change (if kept). e.g. buffer-disable should not be a property that
> disables the buffer, but instead tells software that the conditions for
> disabling the buffer have been met by the hardware, and it is up to the
> software to disable it if the gain is suitable. I assume that the buffer

Maybe adi,low-source-impedance then? Disabling the input buffer is
basically handy when the source impedance is low enough so that we can
disable the buffer and have no gain errors which allows for less power
consumption and extend the input range by 30mV.

As for the burnout stuff, I'll drop it.

> doesn't auto turn off when the gain drops below 2 and the driver has to
> intentionally deactivate it?

Exactly. The buffer only enables automatically for gains bigger >= 2.
For the other way around we need the dt flag to configure the HW
accordingly (by default the buffer is never disabled).

- Nuno Sá

> 
> Conor.
> 
> > 
> > - Nuno Sá
> > 
> > > 
> > > > +    type: boolean
> > > > +
> > > > +  adi,vbias-pin:
> > > > +    description:
> > > > +      Negative analog input (AINx(-)) to bias to AVDD / 2 with the bias voltage
> > > > +      generator.
> > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > +    enum: [ain1, ain2, ain3]
> > > > +
> > > > +  adi,vbias-boost-enable:
> > > > +    description:
> > > > +      Increase the current of the bias voltage generator, reducing its power-up
> > > > +      time.
> > > > +    type: boolean
> > > > +
> > > > +  adi,excitation-current-microamp:
> > > > +    description:
> > > > +      Enables the excitation current sources IEXC1 and IEXC2. Both are always
> > > > +      enabled together and set to this same value. Where each one is connected
> > > > +      is given by adi,excitation-pins.
> > > > +    enum: [10, 210, 1000]
> > > > +
> > > > +  adi,excitation-pins:
> > > > +    description:
> > > > +      Output pins the excitation current sources IEXC1 and IEXC2 are routed
> > > > +      to, in that order. The default routes IEXC1 to IOUT1 and IEXC2 to IOUT2.
> > > > +      Both sources can be routed to the same pin, which then outputs twice the
> > > > +      configured current. This is not allowed when
> > > > +      adi,excitation-current-microamp is 1000.
> > > > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > > > +    minItems: 2
> > > > +    maxItems: 2
> > > > +    items:
> > > > +      enum: [iout1, iout2]
> > > > +    default: [iout1, iout2]
> > > > +
> > > > +dependencies:
> > > > +  adi,vbias-boost-enable: [ 'adi,vbias-pin' ]
> > > > +  adi,excitation-pins: [ 'adi,excitation-current-microamp' ]
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - avdd-supply
> > > > +  - dvdd-supply
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > +  - if:
> > > > +      properties:
> > > > +        adi,excitation-current-microamp:
> > > > +          const: 1000
> > > > +      required:
> > > > +        - adi,excitation-current-microamp
> > > > +    then:
> > > > +      properties:
> > > > +        adi,excitation-pins:
> > > > +          oneOf:
> > > > +            - items:
> > > > +                - const: iout1
> > > > +                - const: iout2
> > > > +            - items:
> > > > +                - const: iout2
> > > > +                - const: iout1
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - adi,ad7785
> > > > +              - adi,ad7792
> > > > +              - adi,ad7793
> > > > +    then:
> > > > +      properties:
> > > > +        refin2-supply: false
> > > > +        adi,vbias-pin:
> > > > +          enum: [ain1, ain2]
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - adi,ad7796
> > > > +              - adi,ad7797
> > > > +              - adi,ad7798
> > > > +              - adi,ad7799
> > > > +    then:
> > > > +      properties:
> > > > +        refin2-supply: false
> > > > +        adi,vbias-pin: false
> > > > +        adi,vbias-boost-enable: false
> > > > +        adi,excitation-current-microamp: false
> > > > +        adi,excitation-pins: false
> > > > +      required:
> > > > +        - refin-supply
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - adi,ad7796
> > > > +              - adi,ad7797
> > > > +    then:
> > > > +      properties:
> > > > +        adi,buffer-disable: false
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - adi,ad7798
> > > > +              - adi,ad7799
> > > > +    then:
> > > > +      properties:
> > > > +        clocks: false
> > > > +
> > > > +unevaluatedProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > +
> > > > +    spi {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        adc@0 {
> > > > +            compatible = "adi,ad7793";
> > > > +            reg = <0>;
> > > > +            spi-max-frequency = <5000000>;
> > > > +            spi-cpol;
> > > > +            spi-cpha;
> > > > +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> > > > +            interrupt-parent = <&gpio>;
> > > > +            avdd-supply = <&avdd>;
> > > > +            dvdd-supply = <&dvdd>;
> > > > +            refin-supply = <&vref>;
> > > > +            adi,vbias-pin = "ain2";
> > > > +            adi,excitation-current-microamp = <210>;
> > > > +        };
> > > > +    };
> > > > +...
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 658895c3b0fa..e55236f4accb 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1731,6 +1731,16 @@ W:	https://ez.analog.com/linux-software-drivers
> > > >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > > >  F:	drivers/iio/adc/ad7780.c
> > > >  
> > > > +ANALOG DEVICES INC AD7793 DRIVER
> > > > +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > > > +M:	Nuno Sá <nuno.sa@analog.com>
> > > > +L:	linux-iio@vger.kernel.org
> > > > +S:	Supported
> > > > +W:	https://ez.analog.com/linux-software-drivers
> > > > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > > +F:	drivers/iio/adc/ad7793.c
> > > > +F:	include/linux/platform_data/ad7793.h
> > > > +
> > > >  ANALOG DEVICES INC AD8366 DRIVER
> > > >  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > > >  M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > -- 
> > > > 2.56.0
> > > > 
> > 
> > 


