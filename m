Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601999;
	b=tOJS5tbnOC1sSrc0uiAIyqLLiTpF8vMtB10P59UFnsvP6/Xl2agyHBn1UngP5eALUGrL
	 4E74MZAlVsy/DK8oI2AeZEFDeBOFsI1h9tdQ5KH6/Fd9Z/1oSp8lHq2RE13zXerqw9zhr
	 L8ac+kGJRolRqruY3beDA47340TwytReJznSwFN4STtBEwrWIoNOPkai5sMohhcT6GfzK
	 61larC8igclbNltKcrQx7d6LdWHb+K4gP/8X+GTw7wB8Rnqj5qxq8l7TE0Fir5xOwW/vb
	 DXzOmPKIQv9N/zJYGo46oToOSGMR10dJogYVkNWp/qiFA2z0Z8itSu/ntMbbQoNt7qA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601999;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Jz/EyLQ0z6tUjAV3A6VQ92tu0XM+kr7WQY4zEUL8S4I=;
	b=DOpv+fYOnyPDezeklWnCaS6MOg+C6XdyOmsD1KIJR/Q21IuxItSQuunLJNap20RsUvXY
	 4R4MJYJ2rAYbxIlq4S1xGUCJa6PEMEv5S5gazruZyBbL2FF6Tmx9yQcLcPOIXjTdsfOGq
	 bPaEJmYOU+CIQfkZ0iUak9Vvk7WTJd/s9TkBXwhhlnbszEzonK2unx68P3ndeQ1x5/wgd
	 AMEIpK0AVBzr5fLESNpk7KdbKFra7fWLe0ZtUCEXcWdgzCZpDJibW9Z485Gax3nfPgOrI
	 gDyiYYAWTl9DPk89/KmH5JdXs0S6H2+277mkSN1G3O+1S2GlkpXA7vX2eXDnruPqrHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ljDQJipz;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=G7Acnu68;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9E606A686;
	Wed, 25 Nov 2026 10:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD9E606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ljDQJipz;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=G7Acnu68
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nn8A1789396;
	Wed, 25 Nov 2026 05:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Jz/EyLQ0z6tUjAV3A6VQ92tu0XM+kr7WQY4zEUL8S4I=; b=ljDQJip
	z6Xc1bi6L9JFCcoa4J5JEpTWemxzJi5pUYZ1oJe6wxnOvxzF26j0mx/L8oIGr9xl
	bdXawrV2rEEBhYzIMI2+Y94Eys4Kwu4R2XiAj4D0EkUoEl9w6slfccy6sPq+NKFo
	FyI8meXGMiLgKCYDeXYdRtn/IdcQA3Eh6Y8TUfo7C3EM2jQ2QN4Gi7QaeSjt5CKi
	xhyBKv3dF1w8pA3RvVRVnJ1gSi2iHUihgSVYp9KwbfDm4MNPlLJK8gVQP0a/C+Y7
	vrDdp4z0ahRcAqXc5gc5RRjrp7WGVqxFiBLkyy2PHxvmMJwYIwDjrGuHoXP0kkyl
	Ht+VniK0qg+yIgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Jz/Ey
	LQ0z6tUjAV3A6VQ92tu0XM+kr7WQY4zEUL8S4I=; b=G7Acnu68ZWRQn6WUkiMaH
	hEQHlcJr/2rup2uvWRUFg1jNdYIdpDNJF/CHhTp5hvP9qwO5W0R4/VaCxTB7/c3r
	oeBy6V30IVnSfBLDlD3v+XD60EWuHTHa3MUR8AWU+xPysygnqGJwQ7H+y3L8OIKI
	3fMMdktJyTuSxOAHCrlPpXlBpDLi6paV8wMprffpgK1l8YwY3abp5rpvYA0r6gys
	+ihVsKlPGA31JxlcPsc6E040D1US6CJsHqzy7cH/7q9Ry9d9OlMCn3pEqIGHsYAP
	EM5u/9oHe/aaqV172X/rPvYgg0GFPHaIy+feXSgrlYXoWtEqZSrnKHyOLde+ErHD
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5db6dfgf-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 05:19:42 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWUMyje1t9MF1TQFRYoAjuTfPwDU08bAU4pvG0CUgdg5tB7Vd8OdmGiuyRZERDwj79Oh8wQDWZ9lg+iJVZ38xUCIiBQqhy4azmtgNRT84e3lJwaSI6OXgjVBlM6tMnElLzhjnm0UHOh5gS9tKhcVb+7MW7szC0h/tkGyTyQChHUN8YEc5UbDod7rppVbVL7qZWaH2VCaDGiFPhNdJAO9yHLchme2NIzum+Q7WxYWRJQ/KYcuDbTLQAVizENL/ew34js+Svstbj73ETfb209xR7uqGYGQSIg3Iw1wbCseIHAMiNfb5tUafsQuw/GLvrBmveolGwAEXVHseKi2JQ86TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz/EyLQ0z6tUjAV3A6VQ92tu0XM+kr7WQY4zEUL8S4I=;
 b=iSa+Lx/GyczNdWvldbOL8nBr2bdZjgRrXLe1R5eazWycvkqBv4MzK3u3erVNpEMtpPpDe9aq1q/OH46FhiO3nPCatvkDFeZjUqwOlNvDUxV91QMHe4nB4ViHITZKniKvpsgNEzooZyuE1SqZRAR1ZE6cFv31QPz0xxZ2cyMxYyb/x1iJJTH10F80c+yYHPdAG08bV2oFJknV5RnVvxZP6XLGDdf2X2rTH8t51rniI2zID2hYmuvfIsQF+bnquZaZ5zgQxc5GZSZWqffrdtpLbx6XhbVmO3pEpDI+2/d3xyoTYY9zEuMEDYzGz/bISTdrt+/78tcP0ZosuoSQTR2vSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:19:32 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 10:19:32 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 25 Nov 2026 10:19:18 +0000
Subject: [PATCH 2/6] iio: adc: ad7887: drop platform data support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-iio-adi-legacy-platdata-v1-2-54e4c8830b57@analog.com>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795601958; l=3274;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mKw//d4lCaCJ+RuVTEfv7yp2yNgt7EPrf324Zn8ZMlI=;
 b=CAa7s0ErmCyhg+zZP4NC7XEzuizoFtnDtnvTnCaTrnluCa3M9gVmI9gaOisfH7i4kVM4xUgFa
 L0wSR5OlT61D/TWAlT8hWXjpEm4Vz3a+MdQXRl7i5ZKu+Pd4M68Rm++
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN6PR03MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 50720290-9f69-40fc-df08-08df4add98a7
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261022105027099003|261026121527099003|10067099003|261026140227099003|261022075727099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 yC5oj4gR8uX4ejM054fXIUPMnxZ109IU7Ht+9p4Xf7zEi3iegzMGk7PGeczI6AK5gXa61c6oLu7YfkHHp4cFItLUn2WlmCwBwL/BxPIpHnV0ZhW1yFWGWug+EutaAOd40a3tTEpEIKtxG8uzgwsT5KgAzlQLchhzYMD2WZATd69RsGLzroUNQzLASXR8RM5yr1t9feCwTDQvhQbrbJ59arqR/d6n4GFfefSo/zhq6Btcuu+IxGJshSoWposSBhDN9A1GjcxaYzx2yIUi0xGAMbyyKNuLdreaNomWM0TJ+l+cCFGP5rpIfXfCJd2W1HxRlYzZtl/MpJ2ptAR6WB8gCtvI34IXR6gFMHM4fw/YNONlrr1SDWqVCeHhfa1eSh6BVFqNIQYYjDX1c0sK2IUM1/a5iqDPjY0FI6LJrXq1f3L2qNrRWSB3P0M20b/UtCaRGWfzcooRAjQOUDt2ZVIoMN6/CwRBjP5GTzMF6TDify1Exu/T0qrQLzm6kcv8HwGP7XM+WPE4wuaiaUkT6y7rM+thcZiEzwLfko+y/p7tbjPH9n72XuykjtXpLCsrN16prYCvelfmxPhYs19ufX/leV2PiKW0EuzjC78tSzyoPsirPO8t/MXsEDpLnuvtLeEwGjQIA0ZRyI+7oNimplWsSLENmNPgTES64yyED3YwCdE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261022105027099003)(261026121527099003)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dnFTdzNTU1JWcnZ6WVhSME5OYUh3Y2Y2bStvWUZDOWVwdC94bWFGemErSkhC?=
 =?utf-8?B?cENUbTlEUElpNVMzRGlKcU0vaytoY2ZNeE9GZ0dNR0FiR2pjSWk0eTdJUm1j?=
 =?utf-8?B?dC9JdHNzUWlIL2JncjV5eklDcFdLSE54WkMwbkpHZmduVGxQQnVEeVRRM01m?=
 =?utf-8?B?ZExvTnZOVVN0VElRcTBYWnU2NTZhWWFtT1E1VzFWQTM5aUZNU0J6KzFFTkFX?=
 =?utf-8?B?M2cvRDNGUEd5NTdKczNnVjZDMzRwNGpwcVhlamZHUDJDZmFScnBUWnc5Nm9a?=
 =?utf-8?B?K1NmQ0ZQMUFIalk1RG5XbGxud01lMzBpcFNtSitoUkRIRXZCV29BQzUyeXBh?=
 =?utf-8?B?bEJrMjg1Ly9kUlpGZzZrczVrTnlaQVdzZWl4eEMycWEyN0FtVjEySDUxYnlU?=
 =?utf-8?B?b1J6VTEvMkc2MHlFQnIvKzRnUE92ZWYyK0JsQ1dvSUY5UGRGWFh0SEVsalFw?=
 =?utf-8?B?cUtBZm4wZkEyTXRMY2FWaSs1U2JWMmM2L3plL0lDSnk4cjE5S1RTakJXMWJz?=
 =?utf-8?B?RmpwK2U2U3NGY252azRtQnF6dXVZcnBxdXBmaXRRNnVHRHNwMWw4TC94NGdq?=
 =?utf-8?B?U1IwUGx2N3VlRVlmYkZabUF5U3NzQm1qTW5pVFlyUzFyK1J5VUNMWjZOWnk1?=
 =?utf-8?B?VXAxOXlqQnNWclg3RmhBenhkSUUzbXRqamNlNnlhZjhwT05RSHpwSlpaQ2NF?=
 =?utf-8?B?Q2RyLzJmQkRqNWRmK2RhQVU2ZmtMY0Yvb2NJZ1pUdHdnZTdrRlpEZTlYNWZy?=
 =?utf-8?B?cjQvNE4vZk42em5mdEFLQ1piSjJNcG5IMHUzcUNiWEIydHBOWXJsWWlnMHJv?=
 =?utf-8?B?eGhTeEczbGNSOVB6NWxLZ2RXTWNkQWRZR1lPeFpTQXVXNG00NG0xMmlGSHhY?=
 =?utf-8?B?R21oZFpVTUNJZlFDL01ZQWJsSGs5SXd4WW80WkJHTnRhbUtQZGQxcjRTYmcw?=
 =?utf-8?B?d0tsdWhqeStJOXozdTRURHhQdGhsVHVRdStVK0RRQXpHeUp0VnA5UTlBOUVV?=
 =?utf-8?B?THVsQWdQU0g2OFMzeHRPTlVxM25aWWliRUJ5MVVUaWNIYnRoMlhpenNGUXB3?=
 =?utf-8?B?SWNJdzcxdVllWVFOVzF4YTFiUXpQbUNac2ZoSlV5blFFY0MxUmw1MDlUNmds?=
 =?utf-8?B?cW5jRXF2RXc2bzAwdFlENzZQWmZZVjhUL2N6WldIYlZyRVNxYTNnWDZnRzdI?=
 =?utf-8?B?VEVYNlNJNlpOR2JKTWVucDZMZzVTTTRJWHRyazdSMlBTdURaT2F6Y0YrdjE5?=
 =?utf-8?B?dVlob2hYMW9iemNRMGxrNjVyVlE3VlI5anVJMFkybDVjclNEZTQzanVQblZo?=
 =?utf-8?B?MnQvcjcybW5BNE9TeVE4TjVyeTBPS3NiYTJlR3RwejIyVzNRaG1HWnh6MC8y?=
 =?utf-8?B?WE95c1FjUGtydGtIdGZNM3JOZGZMdnpHak5ld2FGN3ZiVU00U1JOLzlnS1hP?=
 =?utf-8?B?akRDd1hWbWlmN21Qc2JQMW0wNFRlUi84czhiNTdFdldBaWZlY2FDdkc0bEFR?=
 =?utf-8?B?MWZ6dW80Y25oS0I0WGNPbTR0Wmh1WlBWeExxd2cyUE1EVlRYQWFlclJxY1Fi?=
 =?utf-8?B?L3ZRUU5uTDhmQm1jb256NFFiSUNxSHRoQmRDcHVMVXFuUitTRnRwR0E2aW5H?=
 =?utf-8?B?WFpzZlhzQ2x1cnU1R3ViMm5mTFFmK1RPT0ZQR3Z4VUxtcE5IWXJQNEJoY2FR?=
 =?utf-8?B?WlgxQUNab0lIaEw0UHBjc3BEWXFZQmE5dWd4L2NHQi9CSDFmYkhXY2Vja2tX?=
 =?utf-8?B?MUlrMEFBb0NqMzdYSFBNQy85Qy9HS25aRExWZkwxc2hRZDl4YXFyZmw3NGU1?=
 =?utf-8?B?Y2JyTDRPK1c1dHdzQjlSemczbEFFTkx4a3M0ZlRCSnlGSTFkUGRHQjErNk14?=
 =?utf-8?B?d0lCYVBHS0o5UDlRN1NGUmNNUlpaMWdCWHdCRUVpOTdDK1BuVjh0OERyZS9w?=
 =?utf-8?B?aGpRc0gxVHNhYTJoY2xJb0M1MXlDZ1NRbFBNZ2NmT2l4MDhQNEViZ1hKN29K?=
 =?utf-8?B?OWxHb0ZrTnQrYlB3bGdEaWFUaksyOGFwTzV4SGVQdXROczk5bm5XelFrd04v?=
 =?utf-8?B?MllzZVFqNkpMRkFTeFZ0cHpUWEtDNGFCcEhjMFpNRjhFS0E2dTIyYk9UUGdC?=
 =?utf-8?B?Sno2OW13dU83dXhlYVpyWTlCcHZnWStuQkh2N1VUeHVCMUMxb3c3ZTV5Rnd4?=
 =?utf-8?B?OCtwUFFqdlZxa3VTNnFEY0xEYlNJYldrMTlNQVJHZnoxdjAvazAzQlhNczRk?=
 =?utf-8?B?THBXQjBuYk9URGhyY001amtpMk9Td2F6Um9ibFRqdkNOS0pXcHhJUDlrT2RL?=
 =?utf-8?B?SG82RFQ3VkFaS2c1S2tuZkR1by9wL0V5ZjdyQTVLaWhZbXZYVXZ0Zz09?=
X-Exchange-RoutingPolicyChecked:
	liE5FDEaZgfv87A7CSYoNcN0sTxjrIBKbGEHe7oejnqEXWSSd9xpg+9dfp8jvPDFo3KV6kAEtPuASSPcvKjnYSA/GISxRJkltCUt76+5ocqc2rJeAj7jU0Dv8hJdpDx4Qlcuw9ecbpqQdEXAW2/1WqBBKQ1dlkdb9g/cE5QF7BGCG//8fhDTz6FlLl88HfcRx+0lRSp0PXhKngLeHpuByvhZUgXPcwGCftO6pomnUDSOoCLJsqlgmob7MPJXDxdOevQS3iGQHhxIPJVd1d9mV1V94Sm6T0H7oT1vkM+oU2+kzmAdw50x21l36xtWc1AS9PpgYMgE3uoto5XzrGARRg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50720290-9f69-40fc-df08-08df4add98a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:19:32.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBTDYVGRU5M3MBOnw480xahNMG2GwA80Xwdu7m2Ca3P2tq7/uUOkQYjtIclyr0DWxbEF1fD+oLsdeeOGfl6tvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573
X-Proofpoint-GUID: S_0flMzdD9AINKR_OuJYIyTWUX7PFzfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX2H6E1GTYPMkw
 sMUvVEaNfrvxcBnHvJMh4iUVI8njTMBum5fwNx2ELotvQk133d9MfAdI1UPFT6/AvUtE9t3yWyy
 3gIVX/p5IBhnAW9EQVBvU7RHYO6PD+qrwHiONAMWzll9HnvpIMUXEt5U556fVm60Z6pwLfdl5YQ
 6NnWTUcJDhdC1sJpCCR2zpycQaBMKa8QmSTPERhbiPEvHG2HJKYVzyVX9p3nu5wWheSZW1lwyjH
 +HroiMxUwnlJDPVqiZMGKqv7sfbB365iY4XICOVmRUHFX4i8yvHDAWkYZCL7+MeSCIWSPp6xxyR
 AYtlOvtcyfUgseu6+En1ibx2U2tYZ0c4bw7Gh0Xic/Wk1EvpOtg6ENnRZfMpn4bDnpIvv1GgSGm
 lV2Mq3FdqB/RITVOItDiAQZybBfN0AFQ20fLnJbYLhUbJdwp/JiJE+W8jiT7tii26rDiAR3Mvsd
 q63u+wktCzlVPrLLMLQ==
X-Proofpoint-ORIG-GUID: S_0flMzdD9AINKR_OuJYIyTWUX7PFzfR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX4JETte12Kppv
 RzE1TmD0C/EM0/naPui8ibD395klcZR/HDtAlgs2/jRaG8oMh9oRhC6bc+mF/T8bbBst7smf1bo
 xztXjtKPFyRekVNQpyXuHT+92qQwV/S4w/HZ3s19+a0+vyqsk6EI
X-Authority-Analysis: v=2.4 cv=H99OUOYi c=1 sm=1 tr=0 ts=6b06b63e cx=c_pps
 a=6KPqUB2zuHFFswelnWAHBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=Ww8NwTx-x8-eAu1ZIqwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

There are no in-tree users of struct ad7887_platform_data, and the
driver works fine without it. Its only knob, en_dual, selects dual
channel mode, where the AIN1/VREF pin is used as a second input.

Drop the platform data header and default to single channel mode, which
is what the driver does when no platform data is given. The dual
channel code is kept so it can be enabled again should someone need it
and add a firmware property for it.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---
As stated in the cover, I'm glad to drop dead code if no one sees value
in keeping it for possible future changes (which are unlikely tbh).
---
 drivers/iio/adc/ad7887.c             | 13 ++++++++-----
 include/linux/platform_data/ad7887.h | 21 ---------------------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 980e6a303047..32097b387d53 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -25,8 +25,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/platform_data/ad7887.h>
-
 #define AD7887_REF_DIS		BIT(5)	/* on-chip reference disable */
 #define AD7887_DUAL		BIT(4)	/* dual-channel mode */
 #define AD7887_CH_AIN1		BIT(3)	/* convert on channel 1, DUAL=1 */
@@ -229,7 +227,12 @@ static void ad7887_reg_disable(void *data)
 
 static int ad7887_probe(struct spi_device *spi)
 {
-	const struct ad7887_platform_data *pdata = dev_get_platdata(&spi->dev);
+	/*
+	 * Dual channel mode could only be enabled through platform data, which
+	 * had no users. Keep the support around in case someone needs it and
+	 * adds a firmware property for it.
+	 */
+	bool en_dual = false;
 	struct ad7887_state *st;
 	struct iio_dev *indio_dev;
 	uint8_t mode;
@@ -273,7 +276,7 @@ static int ad7887_probe(struct spi_device *spi)
 	mode = AD7887_PM_MODE4;
 	if (st->reg)
 		mode |= AD7887_REF_DIS;
-	if (pdata && pdata->en_dual)
+	if (en_dual)
 		mode |= AD7887_DUAL;
 
 	st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
@@ -285,7 +288,7 @@ static int ad7887_probe(struct spi_device *spi)
 	spi_message_init(&st->msg[AD7887_CH0]);
 	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
 
-	if (pdata && pdata->en_dual) {
+	if (en_dual) {
 		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
 
 		st->xfer[1].rx_buf = &st->data[0];
diff --git a/include/linux/platform_data/ad7887.h b/include/linux/platform_data/ad7887.h
deleted file mode 100644
index 9b4dca6ae70b..000000000000
--- a/include/linux/platform_data/ad7887.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * AD7887 SPI ADC driver
- *
- * Copyright 2010 Analog Devices Inc.
- */
-#ifndef IIO_ADC_AD7887_H_
-#define IIO_ADC_AD7887_H_
-
-/**
- * struct ad7887_platform_data - AD7887 ADC driver platform data
- * @en_dual: Whether to use dual channel mode. If set to true AIN1 becomes the
- *	second input channel, and Vref is internally connected to Vdd. If set to
- *	false the device is used in single channel mode and AIN1/Vref is used as
- *	VREF input.
- */
-struct ad7887_platform_data {
-	bool en_dual;
-};
-
-#endif /* IIO_ADC_AD7887_H_ */

-- 
2.56.0

