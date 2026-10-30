Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361878;
	b=F3bg/iOqCq8vkRyqkEX3oPq+9wb+GjmL+QYEREQxXiZtp5vikL8xFDI0Vww1aoRyyrWa
	 9lKbrdlQ99oi3DvFH5UrvSkIVctKXQ2O0Lr9acWr/ggdy6GeoO2yYO6WG0rtFu23qTzwP
	 6dHcNzwL+yMPBKX8qkOf2YWSPcbd57iJPeAur7B8w+RpeL11r2Q/LQV+kLegYV7Mi9q3Z
	 FEmgD8EFUAsyJbd2TmVGE9x3Op1+IYI4dOX/AFPvBJBeQmjFibGvaSPvbSLrTTj8Oz9Tr
	 Xgv9AbvGTaiKYHRkpJ6eqEuX0Q7Ll+UqKFOxkb7gt1rmtDYgIS25sJYMjxXVZiZ0NmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361878;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Content-Type:Content-Transfer-Encoding:Subject:From:
	 To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lAonCF+U4D313yDuzeso1tzxsEvl/DuBpiM/0SD5zG4=;
	b=LVOab0oMz7ezp3qy5NMyodD2YbZVN7QFYE27XwKgYPhoaFjThieHS1CDmDiJ+qqoHLbE
	 0uYPl02z5mo1h8yTN3Z76YDGCJbKntxZAM7NzZBEjjef3HWMsgWkTAjLh4+FjmUvLhzok
	 jlutH9YaiXDj/UNJ8uXRv6eFVVmCzj/GWVDb4X/4cRPvvycxsJ4lp222XXJAR+hlls+Gn
	 3r7hU6T1jIqsOYnQvFBTa80Zt7un0z27zeOgi+YXezonVq2wfCnh/O3/b7jpbEWK6RGjd
	 R8ig8bn2iwZEkgDD9KoSBrZhh7bqXbmYWZ1zNRg9tcPFtDgk9z/aqCZeR+2hS1K5oxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dnQPSjaa;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eD6z91Q8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEB606A31F;
	Fri, 30 Oct 2026 12:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFEB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dnQPSjaa;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eD6z91Q8
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBI9sD1436907;
	Fri, 30 Oct 2026 08:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=lAonCF+U4D313yDuzeso1tzxsEvl/DuBpiM/0SD5zG4=; b=dnQPSja
	aB/6jQKVaLd0wM6NJs0KTb7yGprh4FXME2dwDwOd9P1hi7kG1FwCnaa2vGIopMx2
	U/tUfvscZ8MWaKufNndc60nvJuoXp7U1NNQ1p1V26QGXnfpXanSW4tibbISMNHzL
	KJO0vBTJLYXrbQIaryhOXR1/8yDE9HLVmk5JNpGkBspEm8rRRZvNsrNKOTRR6BVX
	Dyv953s2PjdyghEfHxBTGq+h4ZCxuLc7dwGGVytQsy8xuxpz08IUUXwmqDQtd2i7
	H9stnZYVOIh43HFI73NqWFQaBaB2S7Bht+M2nO31sxJLZZBUaMbG1QNuK5tRvhf1
	438upkybL4kAqIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lAonC
	F+U4D313yDuzeso1tzxsEvl/DuBpiM/0SD5zG4=; b=eD6z91Q8NFQE9DlqDlclR
	5nHOh8L9X6uYugH8kbylSxkiO9XmiNIAS3e7McJsrGLDE5U3MCPL+kaVvB76YeWe
	Q31iHXOYZEE+Od9s+DTX6wR4SbCCIC/NxF7A/rfUuimrZA2H7XFgQhs+hN900k0a
	Q03uQYd5z8yPPJ7hLDEz8RthnpCvQYk3gfv+iGyX7vblfySSzCd6Y1wWYPj+emta
	6zcdv844+tew9Z1zgeS6vQ1qHRXxmPT0VetXhoIb4arRgdLuwWHIMRetwMTawMc0
	P0ya/DF6D0fSCjXsf8yS/VeowhrztGfLBLYOaUzRu68XdipHzFX66rZ/WhMCb5Jd
	Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7ac0b4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 08:04:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3pDk/vIBL6iHIi1xL4vrymmfNazzc0TLVdGtH/5IIAWkvzig/LFkAVuk/BJ6KIQjm2e23VJzWv4mx9U8BWv0rFNSr4IimiFV5oqrKA13ArAPn08KEIkLla1iQzKviIhlSh6SovN6ptEMXkezt2YtKw7akMOC8mOe2QB89Ikn/0mRHD8AyixwLKdDV9x9S1JxA5DQIdRVsBKokppE4Hci+TdXnAn7DS1BRR/A9ze1TbX63EdoH1YiiBocjC5Ajh/spFQfE3lVFe3W/MxDQli2C4F6aj+zs2/whBWFV0ba+wKv0l5N4eN3E0Y+fU9T19M4UOya/FsK5YDinIHkQ1zJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAonCF+U4D313yDuzeso1tzxsEvl/DuBpiM/0SD5zG4=;
 b=F96qo9lH22pYYWfhDpJ5RiHy0GN8kkO7SGQfXMXyNjhX9zub5NcJPbQt/Iz1xOipVOzG17yAv6i2DqoDRihJYwBfv7qAirAmdFbfa6y9J9f2xP37Ls8iUWkj4vPStpdVEeul4QQl7iFDWgYwKlFZV4Ppi9bgnIMpPOtiZX9Jhw0IYvsdhSgS7v7XpurMlOf5/LEk9a7P1m036U7/gfQUab13huqg5NN9nXgcWK5E3eHNoCS9xCAVuxqGyQhQaQ6x2eC4e24UeDoUYrGnc6csKtq9b8whI7Gj1WpGI2hhK8ctey/DGVqX40aqlKRQvviZDbvEIzq7al8FqM7PpJHmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8290.namprd03.prod.outlook.com (2603:10b6:8:258::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:04:24 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:04:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 08/10] iio: frequency: ad9910: support iio backend
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261022-ad9910-backend-support-v2-8-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-8-0ff7f0bff326@analog.com>
Date: Fri, 30 Oct 2026 12:05:42 +0000
Message-Id: <179336194286.155032.6904215305491470076.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793361944; l=991;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=9YPfQCspTwDEfqLGidyyTnlEoc4phFmT/gkQ9ZPznuQ=;
 b=Mz/IfQRG9x89yqeyH66Gnc32Er6BTsj+mtzXEF/F4hLtiwvFHlJMZS8Ntyj51cVmZZAr7wqLm
 6RNJNoewzOsD0Mz/oZJMDGdiZY+XvDMnZbvQkLdr9IWN5dnjLrT7DEf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0040.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caba70c-6ce4-487d-1d14-08df367df03a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|10067099003|261022075727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
 f/cD81FBVRxbF3EWQxgJEQ1pws3FTk4MFbojXg7wUEULtBGF6wkrnbpVbYSHcxwLsyNFtIMOh6QZddKLVCV6jQahV8o5N0uIhBy8QJ5l8wwZt2gJag4SFIVhNSXGM/S0aOCfV4xq4/u0kHYo9LMNJSv4WUx5gmW091F214BWYE8m6EmvruOS3AgMR6s6JQ+aJTxSqRCEjtCfvPfLS8w1C9mGsNRW6TlNnygKbgtdfeButkkyxeJwV7422EdVcl5od6QM/Bal3OwIVWsfJBv3CFjkk2MAih/hJIdQKHXN1X4R2laJuQDn8L9ZYlwiJB1baRLU1e4DCGiPflB43/Ha8RZPoreeiZ67CRUw8qN7yAjOX+IYii2XTCThD/cf/xsyNnEN2q6nkVD5gnjzVxPxT9rsGxheQgIY08alI6Hf51q8H3AiYTJNjDYrhjEfnMvdyHjjdLevus5HisX9lDxQqj8EWxcoQHrXv7id3iEY+MU31fBRW7siGq1s1/kYbDhXPnkTAG77KjAqsEMQ3r1pdA727pVFJXnqRGPeeQ9yIy/8x40/yJqJDKfM9eOTLmAVYCDce1VDXaw1BZD0Ifjj/izfdh4WUZGqu1eqUhEqhp9awSYLEVQgZVnbBoOB0wEscKbZ12dT8pYW4k39mX3z5kPPfCQUjXHYVwcdEGt/f/U=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WGZPL1JYdHZVUnY4Y0taOGtrV2JTMmxGVkxhTDYvSkI3bGdPbnVwR0ViT1JX?=
 =?utf-8?B?WCtRNFQvYWpaNXhteGE3Z2swY2pNMnloVSt1eEVTYjdrczZIcHczSGgxbEJT?=
 =?utf-8?B?UHk0YTJvREZKSnRla3p4ajl5ZThpWVd4V1lNYUc0VG5xSzJ3TzRWQVhUQ0x5?=
 =?utf-8?B?QTdpUVpncVVKUHd3OFBnaTlFck1xNEdRRWxOSUxuVlpHaGh5TVBva3g3WlRr?=
 =?utf-8?B?cXVqNHJQTEdpYTRyaUd1bSt3MGxhYzhuM1BPaGlaKzBzQnBQODBSUVhZQ1Br?=
 =?utf-8?B?c3huWm8xUDBMOVBLcC9FcGVsdmxsOUhBUXc1ZnozdTB3RGpVSzMyamdJYysy?=
 =?utf-8?B?Tnl0QVMwY2ZZWG1YaWpzRy9sOTRjdlJyMGEwamFidVdpUklkejUycEdENHBE?=
 =?utf-8?B?b2FGdVViS3l0dVFSaTlpZzdTdE5VL3JDREVyT0xpc01ZRFJEUjU5blhOR2Jz?=
 =?utf-8?B?QUlhY2RvaHpXY01iSTF3ZGJiWVV2bHBIWEJTRnNRRjJTTXYxS3A3S0hka2dN?=
 =?utf-8?B?RmlPbEphUXNTdG4yL1ZsYW5nckhPdkM2d3g0aEYxWXlDYnhUS0VTejdOTnFI?=
 =?utf-8?B?cjhJR0oyVHdCY2hQV3NKcVdOWTdzNnJ2SG5rZ0ZqSDBMejU3QXRwZm9XM2h3?=
 =?utf-8?B?Qm45VVRDc0N2N1RxU1lXRkxha3pRSmdOUEUwUVhvV1YzRzVuQW9nU0hZeXpa?=
 =?utf-8?B?bTU2aEkxWUNCWlNZZE5NTDJrdDFWUGIrNTJUT0FtbHN1VGJwZmFybjdBVnh1?=
 =?utf-8?B?RWhnV3lGTnF4SlV4Um43V2xHZFVFSGdMeFozWXFlUURBRWFPemowamE3SGkz?=
 =?utf-8?B?NHpTSVBwdE5WbVBxdHI1RGk3T0JlY0JrVEFCTXVVR1FTRTU1VWZHSmZydHg3?=
 =?utf-8?B?TjRPVVJ3Ymg4d3hERlY1a0paRm9uWE5RMURBMWZnOEx3Z0RTRGhLcUhBSHpW?=
 =?utf-8?B?ZW9aZ3pxcmZWZUN3VGNtbXF3REtSSnhkdHRBWTB3NmZDdE1LRWZnaVU4emcw?=
 =?utf-8?B?TzQzamNybHlQWEcyQklpMDlpTmN5OU9DQnRkNFBSWk1HbUptOEp3NFVLVW53?=
 =?utf-8?B?b3QrMy9aVUZHOFR5YWxvbE1tSk9TTEFHdUlNRVJiUmhnNVk4UjVkVng0YWZl?=
 =?utf-8?B?eXFGZ0phU2tnbjF5RzJTUS9wWmppSGpZRVhaZWpKa2RFQ3RWSnorejByT3Fi?=
 =?utf-8?B?cCtHaUljemRXTFpNTENqOGxkb0pYTklFekI4R3hiMS9zVVlnZHlpTDhOTS9h?=
 =?utf-8?B?VnpIMTV0ZExOUEE2bHlOMCt6Z1JjNXdrV3pXcGJBRlFZYnhaUUtDUGEzZ2U1?=
 =?utf-8?B?UmV1RzJjZ1E4OWFOOXMxS1VzeHZaYmgwZU5jQXpOQ1NHeVBFVjNtN2l1akk2?=
 =?utf-8?B?S3YzRmdsNGJpZVVEUGdLVERRbVlWT3Vta3E0NC8rWSsxRWhadUNoM3hQRWhm?=
 =?utf-8?B?N2JTTjBtZUI0c08vajBsNEs1WkVucUl4aDRkQVo2Z3JmR2NmMERkM0pSbTdh?=
 =?utf-8?B?VjNBbGhaN0pMenlDVW1wMHZSQkxVVmowR2diakFjSnYvc3Q1WEZHcm4zNzZB?=
 =?utf-8?B?eVdNcTcyNDVrcTEzaStqYkhpeFRXaDdXcUpqREsxanY0YjZqNFFKUVV6eW5N?=
 =?utf-8?B?YXZNdW1YYmhIVVpWSi9HTElpZ0ZXQkk4VkFWTHA2UGlXSDJVMEU3WUxPcnRC?=
 =?utf-8?B?TlVINS9BV0RvbksrSjJ3ajNEeXpETFUvb2cwb1lMV2pFdjE4dHNnYnVpL3Ju?=
 =?utf-8?B?SnZLSmdvd2Q5WmVLZ21VWFcvQVI1VmZRb1dkV0VCZVFadFhscVNmNUNsSG41?=
 =?utf-8?B?dG52Uk5McEl6SStrOWtVYTNVTGo0Z3A0NHQzdXpsY0YzMll0emtWbTd1Tkpi?=
 =?utf-8?B?cEtFZ3Jaa0JBUnVPR1U4TWhrVUtzR2IvVEZwcVYxd0tSOGtsSFpuRDFodmxo?=
 =?utf-8?B?d0VueWw3WGJZcVpacDVGNjZYSjU1ZVlQcDJxZXNsQktTOTFqZTB0RDcxbFlY?=
 =?utf-8?B?ZGFDYTl0Yk90MVVWd25URU1mNFJFMllNMkpTcU5TcFY5K2ZFZmVEV0Z2VWpG?=
 =?utf-8?B?TkdBTzUraWgwbDhBb282OHpRNmEwWkZsaXVzUHVBNU5SYU1CSjdkZ2Frc0xS?=
 =?utf-8?B?UEIyOVpEMW1tcnVveXdqQnZ0Z0RxOHZvT09zRkU0TTRwQWhJT2d2dEpGeGpR?=
 =?utf-8?B?cXZnWGRTL0lZeEFXazhDT1BCOEJhQ1pBUHl4WFpncDZESVpvOUF6c3FSUGZy?=
 =?utf-8?B?STVQdWtYZDRGVDlSbGJRT3VPQ3hZUDhkNngxcStjZGpUYmU2ZmNUZDlma21L?=
 =?utf-8?B?OFA2YXQ4MzNKN09mUGJCcUNMMGtPMm4vb0pEd1pXeHAxVFUvNjdadz09?=
X-Exchange-RoutingPolicyChecked:
	4GhdFKSe+lLAvaZ3T9Nbh2Ttfk+G6MJF2n2v+/bZtWeEStxyc/zNBRLdKNNXxI1O9J6zjNfo7n9KSalo/vs3BUzCT7z429sk2W1w5XyAmpnOdrWKU8CeQpo9Map3OzfYHOUQpJjG/g4RuDiVbS2tpv1Z2qDfEIQCaptRfqdwTrvCCvTVsxeeXyGSiYlHCSYgPhzxKC2DFFjPuBCo25/QASy3x+gcT6CXTsAE6BqN78Cp78fbLU4R4OglZo2qsPQqwk1lo8TogEa6i4YXjOsKkrAYRrxekEb4ZREl7VyLmI5oaY1jii3NzAI+BzGmMsEa3NmD44HL0YbNM/BtKYvYBw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caba70c-6ce4-487d-1d14-08df367df03a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:04:23.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiXl0WhZv6DJBN43yhfIcjJJODBtoRD5wH7Qqjpmrct67/dmz12BXYTl45Gnxi6AiS+z0VPOV0UrJKKskONcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8290
X-Authority-Analysis: v=2.4 cv=bcX+w+PB c=1 sm=1 tr=0 ts=6ae487ca cx=c_pps
 a=25083kmBgh9d5ln0vqlIEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=2kGwqCs-WwcHKN-ID98A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p9hq3oxX-QLfYnjQHGf4npPWI1hudHuT
X-Proofpoint-ORIG-GUID: p9hq3oxX-QLfYnjQHGf4npPWI1hudHuT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX003ei8oB4SLe
 PZKFIIjnbMQeONE0qAGw7KiD6ONSTZ3/X7pHgULZpaLrv9iy9NToUjS+SwGIeo63FyvM9mxwQiE
 7AxroUUXjxfRjkXWoV0UlsBEj4KXtaVmsl0jOU6RtEI/1ncJ4VQb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX843r9TC52Khu
 ocHineLc02FgQS6nJuThU2hoB2nP61pLTdRrw53Yw7metrqtIyR4SF3xXJ0B57sD+cBsv1k/V4B
 5wV8iRJJgielMB72DrGEMXPfxnbVgS37cThk51JWlkdP8/KqMVGyBoN1WOT+wQdWXQOLOCrlRzK
 HWKG1EfwNWBDR23Sn9uclrr5+JrJKdWXjMPitq3mNW1fRMFsuIjZangc3fSSzNivEiuRQVyFqEf
 a0Sbj0kRIiQGwmHGzaImNDDf53LCya76TImGu2596IPudTf9d3kH7jTdt65tVjhVzKFXaPdVABH
 YFounN9tsQVCu+yQ3dRf7H5beEw3YgJsAqAzvFcCZtcFFUpPrC8oDkcBLn/ae7uSb2Ty1GttiGW
 ZLaF7oWiQBPq2pnU3OMprduN52KlF1V/IggmZLFJfgTAc251siOGs+Wf0Wjba/JLFDMM2rlJhv1
 TMrzfqA1V3Yw8Yjghfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300047

On Thu, 22 Oct 2026 12:19:06 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> The AD9910 parallel data port allows modulation of the DDS core parameters
> at up to the PDCLK rate, which requires a high-speed data source. Add
> support for an optional IIO backend that provides such interface, with
> data streamed into the device through an output buffer.
> 
> The parallel port channels get scan indexes and scan types according to
> the data destination: 14-bit amplitude, 16-bit phase, 16-bit frequency,
> or the 8-bit amplitude and phase pair for polar modulation. As only one
> destination can be active at a time, this is enforced by the available
> scan masks. On buffer enable, the destination is configured in the
> backend and the parallel data port is enabled. The sampling_frequency
> attribute of the parallel port channels controls the backend data rate.
> 
> [...]

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
