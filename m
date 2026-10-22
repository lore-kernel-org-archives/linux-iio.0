Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792665085;
	b=M+emSjWUkBi/e2NUfFHQfYb4qLNTmHfxVaykt5C6icL1qO9ZxT54RGpSWpuIjlvHP6Cc
	 Np/ED0+GIWGgAh2fnIWX4wnTZE8vUsoyo1UYQir+9GHGSB180gaOih+p81A/r9ypMgpn6
	 +rjIoAdueUMnJXphwSUn+TN+uGaec9oA0mEK4FRETspCcoMceB2yTF3+/MMlm5bVsyz3D
	 d7g235XtCpAqj5BWkJPujDy3SxGSic/rD6jVFWm1PBD0qh2Hk96V7BVhlJoGVzKra+cVC
	 GQUu8Wf+JmMjBOM7TMjvGlzlydF/KeAPc+olaoDVC4EABuz0JS5YOxaU2rM//ixaskw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665085;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5mQzToeNdTA3vukxSmAFsM0CHMxsSlpWY4Cu6I9djLY=;
	b=uIYAFOpotVpfxjthIiO3UcqfipE7imXURJFQqxgbdvV5ieOsYBcgrcupVAR458hNUqcG
	 2n6e++ZnYNBe4HQT/k3Pf7+uf0NFC5jXIxsvRqkgA07RCIg9GRVTUsFPygbk8fOFOk+Cb
	 ur6tEi2kNTUUD+Sai0wM/eqCOn0E3YQ+9c7nDEnU09UoQNadTwPJzdP/WpG7bL7lMny4+
	 XkcaaJehPJTIYookHke2iPT0dOENKp7LjFdgyvfICDLTFk1AglIhvBJZKcVkPuye/rGAZ
	 f2rbEB/q4w7SQsVf4WjbVwtP9wNTszQspzt/DQHYOdQTDRI/JFxQQFc9yoAdoDGOYpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="b3OC/xKT";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ltZTUSOK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984F606A31D;
	Thu, 22 Oct 2026 10:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1984F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=b3OC/xKT;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ltZTUSOK
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1RUa941189;
	Thu, 22 Oct 2026 06:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=5mQzToeNdTA3vukxSmAFsM0CHMxsSlpWY4Cu6I9djLY=; b=b3OC/xK
	TksyMINxQUim9vsxvH2237iGh0YjgZxMrCwFevHQQnjJ4R5FHp2Sk4hifjT4wrK0
	Be9m++XJP5ZpOsNp1y5/Kd3RuR5q77k7GvcWNccKGaw5B131VhpE5iyXyuFSG+KI
	Szye3+w6bT/cN3X3rXfvsj/Yoe3NLQffa4WcVH5LIrAw1N8lmLsYN0lCMCZamDII
	99GWiqtUljB88rjAr1GP3nBS+cmSc37t6Fyes8sn6OHfh7ZD/+c4cz+T5PAcIsbm
	S0BqPXO3Z6f+2n2nso7jVGmcg7TgxmFdPa1tbSQu8a1RwGJuVbpr9qLDV0oewknZ
	8H5BUYo4YHlb7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5mQzT
	oeNdTA3vukxSmAFsM0CHMxsSlpWY4Cu6I9djLY=; b=ltZTUSOKzDmwch92+q5sO
	yxtFI5bf7Wcg6i7a1QSs2FD/IrcMNX04IBFDpafUPhvCn0wW76BJj89jQZalgDsr
	Iw9iBr87wULl8oPxlyAoVMOTD+m+WSwmaVRUOktGyKh7CF981LhMOubaunD8WSdQ
	lkIU9BQlo4CJEn9vhkXzWCDMjwjM6QxqvF/TeJEq1oDa3cy9AzkBNKZwTWYBBXKB
	9mUmUw1iokhxm6wf4KWrhqWgD/6Pr8txjCOuDojusyddXKDrvoDPl8d5y/JIgdLD
	wQyvQBjKQ6XNIu+nw/XUflTNRIsIC/bgQGB0C1TwXcxyV16F4x5WKDBiMtZcMiG5
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hf9f5tamj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 06:31:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWQ9bQiFtAIBStQqTGS9iKI3wb1tpa32POs6dxLeBUzoy76JjyHX3UVzMSsEBQJUBaAXXFDX+6SzZ5N9IWOjR8cLOTSk3o5KV26tbkiPikdnIWUNwjR3qZle7oHaVP0BEDgjkJbti34uc5jv9rGrFjB59xD3upCDiosn/VnE0tE87Xtt+m3rN+wAfsZx7dFLhSmlSh6wlTD2u6sDZGvcX/nNqI8VzB8ZN5VmMMbPl1CbS6zvrogxDaNCv6USctfl7torbUqia5W28tntHc9HwC1deIPRjdynYJkeY7m416U7cl5N3WV1od/MdxZx2Bnq2IKV2IunoQ7TnrUlI/cQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mQzToeNdTA3vukxSmAFsM0CHMxsSlpWY4Cu6I9djLY=;
 b=fG7bPjK7FCN15ua7A/mnbKi86or5zO/v2CKM2fggB01/Q4ZvQmWPWevsMI3ClwMpd9l+c9tCXs3EjzLVIR4XpQyO1m1tYMXxk5FphG0TIS+c6anCmFOFzu6E3Sow827n11xNRogvQuzfxJEnV2BdrwuBJ+AUA0PQP0SgPFTwgWNE5NEk3TdwBJB6aOp4DAZHJVfMehHM328WNvlXZPLfQ6aYgkNKwJkI0gJEDmI5TnW67XBcx3UVaElMIf/Rz3We8B72YIwxzaJMFqVfq1bx6xSP7k8DposcXdVe/ljfGMkWV5gf3uECaq2LiCQw05OQ7z2FOLsAdcUEsafb3g+LAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by CH3PR03MB7484.namprd03.prod.outlook.com (2603:10b6:610:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 10:31:18 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%5]) with mapi id 15.21.0522.016; Thu, 22 Oct 2026
 10:31:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/3] iio: adc: ltc2497: add LTC2493 support
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20261022-submission-ltc2493-support-v1-v2-3-391d908d2877@analog.com>
References: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
 <20261022-submission-ltc2493-support-v1-v2-3-391d908d2877@analog.com>
Date: Thu, 22 Oct 2026 11:32:19 +0100
Message-Id: <179266513954.3528.10769377279330567506.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792665141; l=1638;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HEr+k5HL2hlrlBNu+mWeb43q5iKp1wI9Jnu96uE0UH8=;
 b=CXzqpy/7mhe9B/Fhv25I2niLOvjawp1mxpzVMXfJInurXiun0XwvvRvjOA4CZxMHSQ1DFBVWG
 ou9cTX2Vu2WCImUEaW4dt+7Fg/IiWdkHC6m7Ch+0zY7Gsn5WwUuWk31
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0081.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|CH3PR03MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: c5791f25-8f28-4946-376d-08df30279b96
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|261021121427099003|18002099003|22082099003|4143699003|261009223027099003|11063799006|10067099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
 mHBVD1F7LbwTH8Q9gr1p1CftGhJbWuLJvHYA7T07rlUGpQN/kfD0ynAP779JUzibZPJQXuNNtXXzfHQ5goah7EwqdOhJpVBeV458d9fhEZJC4DaczvP8SKc+sBzAnlwJEnDDWkBIPU7dz3dZ4QEjpSFt/zU+2AW/9Q9Ngu16m2OI+DK9MSzbDSqiXCC5c7Fu1AHsktMbO10x3wBJbDrfHQ5SL5900RFhcBmTkwSua17Ca0WEMY3aRIYEXLgrrZx8WrHmniji5pco9y/XrLh3KSHkgQBlWDXtV5/t1ZzQWNTGjURyqAy+e79gZFN7U2fWUAPhQ3mJ4j3NB0f+kqqHLcSZvkl78pEiAU00FaP/c6HB3K/TaQnEJDCPew1CNHBil1KYRwqalkfuiKk0Z1ChOxcgvenfjojvB6QJofjkUBoWlafx3vlXp2wBCQ7vXbtOrI3QvXguSY5eWS0yUewH+9fnvxHP6AcYqJqcI9FA0Pv/qPYbGxLOUnfDISsXzJgAp5qOh0i3p+97FMIsGlbG1G3NkgJqcN3xOMECRG7sPgLy4jqikUxYrX46a8DnX0YDwN+Ts/+CtB8X4Y2hld/yMsxC6Oa2CxPtojOFQBTGnzW02Fm6jWiy4GX9AzA4GliJqmL0Kbyn4neg78rISA8ZDnNtSmonscegKYu6p9bV2XE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(261021121427099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(10067099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?czMvSkE4M09rZ0t5UHBFcjVVeDhaQzlSVEh4ZUxyU0lybGoyODBaSkV5OFVC?=
 =?utf-8?B?aFdGRklMakVQZWk5K0xnc2FiV1p3bCtPKzdiaDFHanRTdEo2by9JckxPSGMr?=
 =?utf-8?B?YkVzRGNqK0p5T1hKVDFCNWsvQUVmT1dmYTM3ZnR2YmZ3cGlLSVRqdVQ1Z0gr?=
 =?utf-8?B?dVpOdkswdVFoNW05Unppdnc2SDdXRzNBaVVZWmxGL0tBVFF5bkhrVk9ZRG5R?=
 =?utf-8?B?SmJsOXJRbXVySm9oVDRndDA2UXYzRFpkdDltWktPbU5adTlycTM3Z1pEaVVz?=
 =?utf-8?B?NzllM3ByZEE1enc3TnM4VmtmL0cxOGZGV1JWUVRhbzkwa3ovQ200d3QxbmRk?=
 =?utf-8?B?S3ZoNkxMT0hGcWpWUndFcWc4K1FXYjQ3QmJGQ3NGck9lSUtwUFgwSEtKYzBG?=
 =?utf-8?B?eWRNRHhhYTRYTEROcmtxZ0NpQTZMNDB2WVg1OVZ0UHRpcDlSWGd5OFhMRXNk?=
 =?utf-8?B?dlNheWdwOFN0ZDVoekNtY09xd0hsanR1aTFjOHdBMUlFYzZqT2xaNGdHSFly?=
 =?utf-8?B?NTNqUlp4NkRPWlpwcFQ2UWJFVVhMRmFJRzNIbmF2cTg5d2tvWWk2bi9Id3JE?=
 =?utf-8?B?S1kxNkhwTWlNbjlhMFdRWTk4MUoza2ozSGhMTFVlVzQxdG1rQkxHZWJXS0Rv?=
 =?utf-8?B?OHRqbnVUeWIwSFhVdkpXZ1Y3cm5JdHY1Z2lOTEl5aEdsaG4ra2xaYTRXSjBm?=
 =?utf-8?B?cUpIRTJNSlN0MjJia1pmTEc1d3JjSHRhdkxudzE5QjF0TVFWWlJYbHBCZkcv?=
 =?utf-8?B?Y0EwRk95aEhtZkhqTkFFTERyT3hyZzhLYmxqcXN1VUYvSXhocldCSXkyeXBl?=
 =?utf-8?B?Q0x2bVBUanNvd2VsUzBVeXZobEw1OEJnNXgwZjAyS0F5ajBnRitZbVA1OTRK?=
 =?utf-8?B?WDZKb29RZXZFaTUrY2x0QVhlVGdKVGl5Z2FwTXozZUtSeVpjSHVobzA5MEFj?=
 =?utf-8?B?cy9IWkVabUc3L3pkWWpTRUVJdVc4eThTRnZhL2tmTFRQaU5zSGJMdFU2QlU3?=
 =?utf-8?B?Sk5IenNpR09peDBJdzhUdmdzQjkvVmFiZDFLUzJvTFowZGZBMk9TeVNqSUc4?=
 =?utf-8?B?OUJSaEtBMjh3emM1YkhDR2tYT28vWUVvaHZZTXIxeXZSRUJxWG5nZjFRbjU3?=
 =?utf-8?B?N3dleWIyck1tMXVXdnFFSGdVd0cySTNjeWlWV2NpZ0pNbWlKbzltVEpoaUdq?=
 =?utf-8?B?VHM5Y3oyVkpJNUNoUGJvSjN4UFpTa2p5MDl4T21VYmZ6ZmNmU0V3eHNyQUo3?=
 =?utf-8?B?OHVVUUlEb3RnaVRoK2pPZlFzK1FPMzZXOVllejNLcG9HWWV5Q2M4V21nSk5l?=
 =?utf-8?B?OHlWRkk0K1JOSWtoM0hsSnd3OENHdmpWa0JWbURWMjY3U1FSSXVsT1NYcFVZ?=
 =?utf-8?B?SFlNRk5ZQWZpY3hDZnZObXErVk9OeDRROXR0MG4wM0xJanpTRVliTENGMzk5?=
 =?utf-8?B?SCtpK25rWENVV0E3L1BsSzQyQ25NK1lYMG5Bc0JSZWlkRHhRM056ZFJXSnNE?=
 =?utf-8?B?UjdxMzM4dDF0KzhJeWJpK0hIQlV5S2J6UnJraWlXRktiVlh2ZE9TbmRsWnI0?=
 =?utf-8?B?ZmZJa1EzYzJSSmdBdHZIWlRZY3FuQjUyeUwxN2JvNFJVaS9LWjVOVlJkcXRW?=
 =?utf-8?B?aGlIZWpHMEhZVDIwcjFMRFlicVQvMkpiWC9HWks4ZFQ2eWpDV0lBQkxSOUda?=
 =?utf-8?B?dVIvb2N3ZlhxWHJONU45Z0V5K0VCS0FkYkxQYWwvOWpscmc0T0tnelhNQ21l?=
 =?utf-8?B?YWN3ZzVTYW9scWRsRWpwVWVZQjl0a0kvcmh0eXZMT2N6MkFyWjZkaDZKbXhF?=
 =?utf-8?B?VVlyN2hhRmNncHdON2UrRThFZ3ByM1JiVUdYMEIrRWdvUzVvNmdRczU5Q21Z?=
 =?utf-8?B?UDhWaGNGOEo4aVY5OFhKZitrczRiQkNVcm5EUXFVM3lKa1RMc2VjV1N3ekV5?=
 =?utf-8?B?Yi9HUlovN2QrNHNLZXl4dWxacjFJU2NQRXZZU1ByYWN6N2ZLZmJTRG8yZWpD?=
 =?utf-8?B?TkV6Nm9UM1lRL2hDTFkzcWJBOVF6V2lQdCtxUjhpYVg1ZDg3TnVqQW5yb2tu?=
 =?utf-8?B?aHpXdzZZZkZ0dXY1dVFlaS9DU3J5dmJnZ3V1MmMrREdZdjFRamo0TGxQMWRM?=
 =?utf-8?B?MjNQK2VtV1p0NkZZL0ZDdkV0UUpoRHlqdmd3aWhEdWFzTUNXdVl0dFNDZURr?=
 =?utf-8?B?YUsvMzlBREg2S3ZsNGIwZGtBU2dJcGJIK2VkQit0Y0FmN2l1a21NcUMrUUdl?=
 =?utf-8?B?SWpEdXRQVEF4VlBmTXhEdzU1NlNDcGZ1eEJvZDdWWCtBdU5pcVZ6SnlGUER3?=
 =?utf-8?B?UjRSL05Ca0grOWFQcXc5SVFUdDlQVWh1ZnNoYkFrRnpRa1Q1Nlc3QT09?=
X-Exchange-RoutingPolicyChecked:
	CzQ3TL0ur2hjFkgGxpNjcMCCJM/Y9ryEnIDvxJ9ZfY6V/oioqvvVs0vMDqClb/aw0zu4xr8OMtTuT+zmhvhj0Sniu/FSqsTDldv+ambaJmO6ZDWXmr1xZFvZuY0NoEaErPliLACeAAwkS9nEOGYCYR/Htaja+Bzq/Dsm9yhG6lREcKBP1kZ2ej8IMfs+kUfym/oWnVeelo/vsTvwZRBxhXUHBaeJkeFADuInxnmg5Tt+KOf8UKpYJHohUeHPxIuLkZ5+y1tAzIQeB0XPuzYe0M95rI+UIs2ZWT47driSxNcZDVtNAAa2wQ+9j598gdNkBsO1bYlJX72wzhNALItQrQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5791f25-8f28-4946-376d-08df30279b96
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:31:18.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1J9x/psdi8lD2Q1AqTbUCW/N+NoFhn9QlGB4U1PsiDYK5PcGr+C12a5Dh7crcCQUXHDNn2GKESyU3I2NWjWkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7484
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfXxfzJr8+tl3FX
 E47udxmTcQVRmBahTBDbJDud6pqCgj6FV3wHp6AzCyI8ToQQfMQWGJElrGLwh2NZSoPzGupqbuD
 Kp8uxabbCRq3ophNT4qBM/tHEyjvYUZGrHtwgRGzH0Bf6Z3MOR0Z
X-Proofpoint-ORIG-GUID: kZXyaSJuHdPvGBMA9J7PdGknbs_m9zen
X-Authority-Analysis: v=2.4 cv=C5V8WgP+ c=1 sm=1 tr=0 ts=6ad9e5fa cx=c_pps
 a=ButkoIHTjR5vDxq5MUTXqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=cAwBvNyS8PidHXqXQCwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX5yE7f/+x82Vy
 DDtaTgezai25feGe8t4SPBYGcGOfx/BBdCqf4upzV4TZvcSyp9wpPvO8QDvQjklL8+omvVctCXi
 vjM5ZRWEa8oVLnghikiJHFZJ8/ua2TkARRUM3ZeN0aR2j79CebC3dKOR16tR6s2f9UXCX2Pjecz
 +B8QpGjD6O0rGORTQLeGynLMoqVKcMCTNUckoBzEu6ElEr8vIsUnPRZ14Ru5jr4vdq2AhlW5/Fl
 AfsTpqmur2WY6Y0bCLNFwi3yktAMhGe3uA8nwLHy8gjEomq97rcMOWp9eu5efDXt5UOTSjVsQ6a
 nb4H1uRIuVTQMEw7rbWpEAwrXVvFd4AFCgVLodCojOPhrqDwPCQcjzl4oFsBtV/8s6FD4ZCSi+E
 sWM8Jyk/H5+n3qTrB/tOk40SuYKGGp4NB6yHeV5VuIuV2rg5AJvBTd+fVdbOvWQHlGTLOVGmYjt
 /Z9YGSEA5xrwgWMMlgQ==
X-Proofpoint-GUID: kZXyaSJuHdPvGBMA9J7PdGknbs_m9zen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220041

On Thu, 22 Oct 2026 12:58:20 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index c218d87d3a62..9346a39968d0 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -420,6 +420,49 @@ static const struct iio_chan_spec _name[] = {                           \
> [ ... skip 39 lines ... ]
> +		.num_inputs		= 16,
> +		.num_channels		= ARRAY_SIZE(ltc2497core_channel),
> +		.channels		= ltc2497core_channel,
> +		.channels_samp_freq	= ltc2497core_channel_samp_freq,
> +	},
> +};

Instead of an array, make this a per supported device variable and see
below.

> @@ -441,17 +485,25 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>  	else
>  		indio_dev->name = dev_name(dev);
>  
> +	for (unsigned int i = 0; i < ARRAY_SIZE(ltc2497core_channel_sets); i++) {
> +		if (ltc2497core_channel_sets[i].num_inputs ==
> +		    ddata->chip_info->num_inputs) {
> +			set = &ltc2497core_channel_sets[i];
> +			break;
> +		}
> +	}

Instead of this lookup why not assigning a channel_set pointer directly
to chip_info? This also looks a very fragile on future additions.

And note that in this case, adding this channel_set mecahism can very
well be a preparatory patch making room for the new device being
supported. Otherwise  it's a bit weird having changes in the other
devices chip entries on the patch supporting the new one.

Then, the patch for the new device will be trivial if I'm not missing
nothing.

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
