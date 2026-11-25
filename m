Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601999;
	b=ph+q/OMzWXQl3DwSeby0ecGvUhj19qO+l7gKjwZIEPJRPMt0J6gXZtKeXRdMSTONSz2j
	 eCCASZB42dw8lX7Okg3y2u/7RKC+K1BXj0DV+o6R8mXJX/LL50NrL2R05M3PL9WjQG1QF
	 AuNJDK6uXYWS5nCenAASsglOFGgD2rCVTAcPFPoPzaMmbGjmZLjcI9/44bg+jWwy4GRGb
	 OSIaG50yjkQiHBufHS4UN2nrF3+bXgN4hLK6oqndhKswru+DiArlgIIdGMNdAiTtGEO4i
	 /3yhLQxWLnACvq2pa50I68UpY9sVUyZSqn8c9xOBqZTSB9F+TxpuuArEeaFBooTkmKA==
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
	bh=9LK8wRsKldJz2I6uatPQWiN7+zHm/HcFJmMH1Ifa/pI=;
	b=BXi73xskYuGr8dazi3nOxLqICqPPswdur9sKXjfd5xxp60vQZflHgIudHDmmJHrQpy8o
	 tTjz/sw3MXOmjrKGfyBxaWu0hMGPLUTEmITapOdpAL4/petj6LVIbRxAj3JYlCVYTkJlN
	 uI6ozKi1I951+IXxp8yWOoLVl1RHudZy9XDXxz+0aX4tyUTadV7U3HH/54ROtYeKnZHjw
	 vKgsYtJu2p6EaFh5y/hNbFIXgii3q8n75eECdw/pgX38M7BYoN82IaMp+HZGQa9r9HzFi
	 rgJ2IvIcQdJvlKHwtLToLqq9Eq3cv0R9bgFyQ+Hw+XmdES7BCknrYrPZeHhgbjKX5yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NkvEtWdP;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Jysiz1fv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD72606A685;
	Wed, 25 Nov 2026 10:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD72606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NkvEtWdP;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Jysiz1fv
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nn8C1789396;
	Wed, 25 Nov 2026 05:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=9LK8wRsKldJz2I6uatPQWiN7+zHm/HcFJmMH1Ifa/pI=; b=NkvEtWd
	P/We5tpwHzWBpWCuPfShbfqokW6Lsn4yEJziWOdNyDX5QVhdzsLRdWIjRp8bwxi2
	kx40ZD3dAbw1k64lz1bfOiobmn4fNOs1SRVH7H5DLWDYH/Eyim/3pQyX6PVhlVjM
	IQ5BockO7Y3quFwW7QDM0/BOnh7+/w9cV+E20Yv9DxmAmXNq7EVe/sJqGAYsp5na
	qRsQJ8uqs49KcEIzhc8zmuAxrXGphz/lcDWOy14eoetfFgEhzZWJpVfAp4lG8jm/
	4wXgbtDXHbWLQ0c256iH6dp7csERVnXzpXe8VkPVyX0PiVtWcr3pW2M4qd9pbNrC
	avvnST9Q62gkGwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9LK8w
	RsKldJz2I6uatPQWiN7+zHm/HcFJmMH1Ifa/pI=; b=Jysiz1fv9ArXDqf5RjRn3
	GdjBgIjLuo9yL3l0EKyUCK5w5APQCMw1c9Xg2zWKCGQZxiyYLcGBs6ndFBjB219M
	uS3DFhAB0L3iMDDb5UjlErjdEzy7jdSAaApXLBN8QjX1TF0VWL6hjXZq4MSCbglN
	k9dY796NKiMRdry/uhkJnQGy0ps3WioIEfS4zokHi4PM4/jxxx38HdM26lcNGXOo
	uzbf9VIg1UVqwIU/0BI1w6bwA1xsgMxlf+SyvhUbd4fTMcqaX+oNllaWXZj4VYv7
	MDwHBYWiUf+/Pz6/0PRVd2MwVhJF79pIErXEwYH67GXbfADdSr+IsUgtU6j+Vary
	g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5db6dfgf-5
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 05:19:43 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKqEmJFG21kw9S1h5qGa6tsdqZQvuj4L7yHBhF8g31BbaDItoBr/9ThuNJZMI4gBPY2nraMa/heqoKH9XU5gXLC6O3kxCY51KkNWlx8Q5spzN8oOgOZGxdiEmvkkUXiFeQSAA2rcUcCU8w+4yoGyZiSPUW4aLwj7Ax7Bb0vmUMeZlO5srkKT/58K69gsAmKeRvek7k7n2P8vrYZRUV7Rzj5h6pAWCumvD/cwmvNE14hjtCb0JrQMUDQ+fLb63FJXGmZPAAN25S4pTuMe0Nq0o4LIMOxndML3HyStVPnd8pg5HJDrksLxVnU6wLdjvAJwXxcGpMJaDbjRB+1rpyx9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LK8wRsKldJz2I6uatPQWiN7+zHm/HcFJmMH1Ifa/pI=;
 b=kQdJ3bGsEVoqbOaBFT/PWid/HZPRuSDAC6DF9X6Hs322SB+n3HJy0jWYTDKNpGFScIPm4YaXPwC32YIFiPez0FPXgvPogxzUCyxyJBOhpXiDi4ocqRDaYCIxvCtRr2jrCGKl/zw2yN9Urtsk5+/DRtGa82+nNH/QNQ7aRfnvGx1pIhr+VCQlodQUENWow1vWtW6kXEtWRv5+ygR9Hn4dwzTxBtvoGD+Bfmqs/kGM5RCZP3z76bAgU+qt5gNWcTGbYBxLpQuMEeQd5nI5fPrhMpfvmdrohUdEuwJ1dSjMYx5Y9YKXQK3xZrDwPnr0ePswAjBWrbaMIDznl4vwGKhnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:19:37 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 10:19:37 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 25 Nov 2026 10:19:19 +0000
Subject: [PATCH 3/6] iio: adc: ad7266: drop platform data support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-iio-adi-legacy-platdata-v1-3-54e4c8830b57@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795601958; l=5250;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vPAMQxhLicBW04s3kGeJs74+MdqdgmxvS6YyJY+GT5Y=;
 b=bICbFm4mWpfzv0H0XXbOUg76+BSFCIOfgcRsq6/Fr5AogkHk9JULL6e+rp18UjJolU6sgGgC9
 rVDchSLNR0sCqwKzX0TGeL6gPuGJcRa1bauyivuBehH5MtRsGscSudQ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 850dcced-ea64-4071-936e-08df4add9b98
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261022105027099003|261026121527099003|10067099003|261026140227099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 gHtn/tl4K2AXBYI2F2bOKEmsD/rHdjkDhly3LjEsTGPTDRIoKOMCGiXJMHta32ANhAM7tTkEw6gLg2ch5Usg7pPyVSGgQQTjdP5jHYG82/wzmxrofQyXygiitpS3HybVV4kdJfERSSlp6bz57XoHWf+slLwjjyVH7dum75nzhK5HeNTJhir0lp9NUVHv/NLeWSIyCGSqI5APvPgTlOmjfMq0YrO3T22clept5/Xg89DOqND1cLEgxqmY3mlZEtyC0QmBhoLvl3hEhUNJQkMMtsIu7NdTWi0Oj5Qw3kdsC7NT7dnXP+E+AeG7CfIK1PWUaFv14JzGQ+j6I28/QTJXd1fQtG9jPw11pS1YW4Pd4X5eIFKXurrZ7Kvxe3t6ewl9UwQWsTq/epKZ12A1Mf5T3VUZGEZjV0D9bXStPuYXFx8YWKqEdSbvoOhbi/mYBwBPk7T7B+u+Rqx9YgtqsudjR4FoCTy2/UJg2sJXhPfIsnIrhveZxFi6p6UjQWE/qPmSPjQjY+cqwe8xNdiAoyEjW3WOE8a1g1sFkAajpl4tNwkDG7bexe1O8KjktV82g8uI6xxGoGPM/CuxAUSHjBkLsckjbgatj4DB8g+m3iGKsah+6ewT/ZkNXpe4/LWfq6cFk1ybNG/yolo9SofKr1RBqcYzwHA0o6jVfx+ZkbT4df0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261022105027099003)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VHFjb3c5N2E0NjFKdk4rVzljVWlGZU9uelhBU00yVm40N1lGcUdjM2tOYkdj?=
 =?utf-8?B?ZitGUmpQaGpaRkZyUEt3bDJsZzZsaEJDMjZHSUVaMDdqNnduUmJqRGhJR2ov?=
 =?utf-8?B?bzkva2tPcXh5c1dHWHB0YjE0S1NQODJkYVFFKys1VTZvV0JNR25jUElOVzVJ?=
 =?utf-8?B?cDVPd1pSZk9aNkRrOTBvNW9mSjZVS1lJUXRKdU1VVnNPbkJGOU1HMU05bkNX?=
 =?utf-8?B?WUVRZ0ZwUXZPUlFuZzJSZmhTdjNhRkJFNHpvekN5K25oMy9iRG51M2FHblJ4?=
 =?utf-8?B?cEFiRmxvTE1hNy9wRm5ORWNUZDQ3N0UxOVIxS0pQV0VUOXFEZHVhRTB6TFVH?=
 =?utf-8?B?VlNzdWJXQ3BJZ3d4Z3RIQko2bjJZSXdzM0RML29RZnF6ek5JSU0vL3dJUFhm?=
 =?utf-8?B?Q2kzYlNablJsWEN3NUpLdEtNMGtOT3A3aUtsK085Qm5YSW53SFd6ejVjUW50?=
 =?utf-8?B?MmJrQ2NhclNJc3hTTkQ1QnM5a3ZDbGZPajJZZ0o0TXcrakFESmZRa09oZFJC?=
 =?utf-8?B?Q1Y1TTdsV3Q0ajEramRsaVMyRVhuUnZEUmNTS2h0SjV3RUZlZFR0OHl6bmh3?=
 =?utf-8?B?QzNucEZhajRSSlZFRHJHY0NUamFTZFkvbWdvOFpuV0h4dFhESGJBYkkvRWhE?=
 =?utf-8?B?NWpwVXJ4VHZCU0V0T2JiOVFUSWJjQ1VLeWY0K0pzbkppMHE2NXVBM0tuWW0w?=
 =?utf-8?B?VER3QW1scG44NWhzRW1xWkduREcwNUtRbUhtcWdFK1VEYWdEUXl5VlRTbzRK?=
 =?utf-8?B?N09pd0IzOG5RTmZUUklXeEUzeGVXT0R6UkRaUCtaVVg1ckN1VHRjRlk3Wm0r?=
 =?utf-8?B?cTNqTldMeXd4MWJYcGo1TjVMTEt1L050bXd0d2xqcXJiWmp2b1VNODdoZzVa?=
 =?utf-8?B?YWNTSDV4ejQ5TS9rYUxYWndtbXBFbmNhZWlyUUZITFRMMW5LbG1ONnNPOXVj?=
 =?utf-8?B?TE53WmVJeDBveENvaGgyd0NyckN0bXJaNEVZeTBMclpQM1RBQ0tLV3VHUG9T?=
 =?utf-8?B?ekFGaW5sSGI0OXBHYUJXRFdJa0FmaHE5Rk9Yd01Jc21iTlpPcDdPYzF6Rmg3?=
 =?utf-8?B?bkl4WVkzR2N0dExFeU0rVXBialdZRjlybFJzQ2RjQW1XcVFrM2NCSkdMYktM?=
 =?utf-8?B?bEh5UDRpQVVnTU1kNGxpakVnaXJleTBTTGZxYWhJK1AyVEl3djA0WGNtbGgy?=
 =?utf-8?B?YWw4QWRpMnpsa016Y0tPWnJmMEhxZWMvUUVHLzMrZlFrWWV1OXNlRitpMEZN?=
 =?utf-8?B?akdsWHlHUlpic2N5Q3Z0RlJNenVzN3kyQm5XYlpINXhGMVVVTjA3VWltNndq?=
 =?utf-8?B?TEd3eWtmUkFva0R2bjQ5V1htYkxwMVUxZlBWOHQ4b3A5Z1U0NkF1eUdZaHlp?=
 =?utf-8?B?eEJmUks1NW5iRTNyWWpaYTFFcEpscENDdzFJSk9RTHlVbFNlTjVQQzlUbVpY?=
 =?utf-8?B?Zm9yZEM0VzIyMlFrR1dxOHVKZi8rVHEvV244Q0x3bUV4QUtNa055dW5zaXZv?=
 =?utf-8?B?a0Nzb3Zld1dtc0pYUy9vWFAzK0NOUkNGem1qVG9QTkFmTmRJdGhJS3V3MUJ6?=
 =?utf-8?B?YzlSOXlhMmlTa010c3h0S09Ja2RraVk2WkdCTXFnbXZ4WkQydFBEeXh5Qksx?=
 =?utf-8?B?dmNLK1BsVlJ6UmN6bnBITjEvN244Z1FMdFhpVmMvTk9xekE4WnRscGdpT0xx?=
 =?utf-8?B?Q0lEa3JnYVNkMEJEaURNU1FwVk1mUzhkeExPZ0t2dkZlMHhiVnlDS25OdFlj?=
 =?utf-8?B?VHZva2F4cUFmcVNwSFlEalFRdG5PTzllaUxpVlVxa1U4bjdtdVV4UUFMY1Z2?=
 =?utf-8?B?TDJFdGJRckxJM3cwOE56TDZzK2Z6a2tiQ2NQTTI1cVlucWhtaTVaMkpXSjJw?=
 =?utf-8?B?MnIrZnJGTkc2RDN6TGJOdXhOTWtmUHVnNHVWNzhWZSt1V0o5WnBQYkVOWlpK?=
 =?utf-8?B?WWxySS9tZmM2eDlSVEltRWhIVkFlM0tGWi9XdWIxZWFQbWFIQ1Y3SXRoaXdn?=
 =?utf-8?B?TGxXSUYwTzRkdzVibXJxZnk3eUl5OGc5a3RtUlFxRXpWblBJSjRwM0JJU0lJ?=
 =?utf-8?B?Q25UUmZmOXJwczNiemlXQnB0WEtVR1ZJNnhlQTgrMDlodi8ybFoxVzlBSG1s?=
 =?utf-8?B?NVZZLzQ2Z0VOZ3A4U2RjOUVxZklXOUtzdUtOYTM0c3hoR3FmMVlKeFlCTGZu?=
 =?utf-8?B?cDdTOVlsQktaL3R3OXhtYUVuL1FtcDRGanRWUXgzL2ZVUG5qNkY0Q0JsV1k2?=
 =?utf-8?B?VlBPR1F6VmZKamNNT051ZFdvNXh3emZkSXFOVmpWU1pBN3ppbTR2bWJEdTZy?=
 =?utf-8?B?cCtuM2REUWRFZTN3eGpiY0tZc1MyYjdkQ1V6QkpGdGVndXBOemRMQT09?=
X-Exchange-RoutingPolicyChecked:
	aLPC44b1R9foUZZDAjGwFjUd+2WMozhFlVletE9b1TtAyV8FdiP2qqHCvjkRIYP5BLTXxKejo8RMwlLiLfmT6O3kfr2obj8ldvYHSUDyrvnNVr0eTisGPADlh99+3VJbYOMPMjPw1cB8r+/XruWAE4120h1UoD/GOroFruh5i1CgXAphfbdmIckaBoPNHhQVFUF3K8iygUu70AzcfvZJa9alRs6KtF1kl/cgZqgOge66F7Ql/Ay1VAvQWICHvhTFZcAl9HhO3aIDjDVg5HtgJjOwP2RYtIstqlYoDY+KQfWntv1f0WG/7PojDZ39Z+okPIxlEXerY6QttbJmsjgvzA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850dcced-ea64-4071-936e-08df4add9b98
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:19:36.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONVkUzVkc4S4Qte5ZdobOvNIeLo2GnkaXOEFxCzHjAaYpp20wCNhsE4lFBp+6KTPGGLZiyTJAFknHf5LhXMsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573
X-Proofpoint-GUID: l3PlAb0bfZVwLdE5LL73lil7T8co1vIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX6zECa7TRjKvI
 hPAoEdkLMRLdL3YCqRsSawUT5ygC17cOCXtIYSWoCA91NU7HsRK/Vtk4nDXIfeRDCcx+ojBdIs+
 15PuXn8phf/J6FjTrIyxk/QH+7gjwuBCk7t1N81KURUYpy4yPXSo9Nd/IkSI4fJhDEbo/+bd2gN
 V/PjfIukFd9kGchqH0ScTHFRDBiz14b0qszQhloXy1Wq586Sd6rlutVBECeg5sHu2+EAhB1U+SE
 h3LsiWQGbItDl+mVf+gw9GYiSDB5fWS1KFQreyND+sBOZCPw0+8AqBWKsKgs+XHxxp/xVavfiqC
 OQGzrfsXet58YQ7X1oTiDwmjJc6/1FPe37QUemSGtZgfmSTR++cviEoriKuler+TrN+v7+u914W
 uFn+ucqRJVzQLisxW/Rnb79SvnSsuILjl8bU92vxC1cqeMr15WbHG7iZRbG1LgLptEZccg0laLl
 +eRyQTjc+mZYeEC35JQ==
X-Proofpoint-ORIG-GUID: l3PlAb0bfZVwLdE5LL73lil7T8co1vIs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXy0t3qi3vdH95
 s4yZRcgYkafKP5NPuwckbDG0NjpB5XER6iqEYMQtT65J6Q8XIMnWmpryNaCvjEl5MRx3RQMulf+
 uAPL8ij+dqZq+PCphv9bOkVunGDt7a82Pn012Oq6OWYOWPO6yXdo
X-Authority-Analysis: v=2.4 cv=H99OUOYi c=1 sm=1 tr=0 ts=6b06b63f cx=c_pps
 a=6KPqUB2zuHFFswelnWAHBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=BiqbcqF4i7yEQ6-3qHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

There are no in-tree users of struct ad7266_platform_data. Without it,
the driver already falls back to a fixed address, differential mode
and the 0V - VREF input range.

Drop the platform data header and move the range and mode enums into
the driver. The code for the address GPIOs, the pseudo differential and
single-ended modes and the 0V - 2VREF range is kept so it can be
enabled again should someone need it and add firmware properties for
it.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7266.c             | 58 +++++++++++++++++++++++++-----------
 include/linux/platform_data/ad7266.h | 50 -------------------------------
 2 files changed, 41 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 594a070c3745..2eba5d05d9b4 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -21,10 +21,35 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/platform_data/ad7266.h>
-
 #define AD7266_INTERNAL_REF_MV	2500
 
+/**
+ * enum ad7266_range - AD7266 reference voltage range
+ * @AD7266_RANGE_VREF: Device is configured for input range 0V - VREF
+ *			(RANGE pin set to low)
+ * @AD7266_RANGE_2VREF: Device is configured for input range 0V - 2VREF
+ *			(RANGE pin set to high)
+ */
+enum ad7266_range {
+	AD7266_RANGE_VREF,
+	AD7266_RANGE_2VREF,
+};
+
+/**
+ * enum ad7266_mode - AD7266 sample mode
+ * @AD7266_MODE_DIFF: Device is configured for full differential mode
+ *				(SGL/DIFF pin set to low, AD0 pin set to low)
+ * @AD7266_MODE_PSEUDO_DIFF: Device is configured for pseudo differential mode
+ *				(SGL/DIFF pin set to low, AD0 pin set to high)
+ * @AD7266_MODE_SINGLE_ENDED: Device is configured for single-ended mode
+ *				(SGL/DIFF pin set to high)
+ */
+enum ad7266_mode {
+	AD7266_MODE_DIFF,
+	AD7266_MODE_PSEUDO_DIFF,
+	AD7266_MODE_SINGLE_ENDED,
+};
+
 struct ad7266_state {
 	struct spi_device	*spi;
 	unsigned long		vref_mv;
@@ -381,7 +406,6 @@ static const char * const ad7266_gpio_labels[] = {
 
 static int ad7266_probe(struct spi_device *spi)
 {
-	const struct ad7266_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad7266_state *st;
 	unsigned int i;
@@ -399,24 +423,24 @@ static int ad7266_probe(struct spi_device *spi)
 
 	st->vref_mv = ret == -ENODEV ? AD7266_INTERNAL_REF_MV : ret / 1000;
 
-	if (pdata) {
-		st->fixed_addr = pdata->fixed_addr;
-		st->mode = pdata->mode;
-		st->range = pdata->range;
+	/*
+	 * The address GPIOs, the other sample modes and the 0V - 2VREF range
+	 * could only be selected through platform data, which had no users.
+	 * Keep the support around in case someone needs it and adds firmware
+	 * properties for it.
+	 */
+	st->fixed_addr = true;
+	st->range = AD7266_RANGE_VREF;
+	st->mode = AD7266_MODE_DIFF;
 
-		if (!st->fixed_addr) {
-			for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
-				st->gpios[i] = devm_gpiod_get(&spi->dev,
+	if (!st->fixed_addr) {
+		for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
+			st->gpios[i] = devm_gpiod_get(&spi->dev,
 						      ad7266_gpio_labels[i],
 						      GPIOD_OUT_LOW);
-				if (IS_ERR(st->gpios[i]))
-					return PTR_ERR(st->gpios[i]);
-			}
+			if (IS_ERR(st->gpios[i]))
+				return PTR_ERR(st->gpios[i]);
 		}
-	} else {
-		st->fixed_addr = true;
-		st->range = AD7266_RANGE_VREF;
-		st->mode = AD7266_MODE_DIFF;
 	}
 
 	st->spi = spi;
diff --git a/include/linux/platform_data/ad7266.h b/include/linux/platform_data/ad7266.h
deleted file mode 100644
index f0652567afba..000000000000
--- a/include/linux/platform_data/ad7266.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AD7266/65 SPI ADC driver
- *
- * Copyright 2012 Analog Devices Inc.
- */
-
-#ifndef __IIO_ADC_AD7266_H__
-#define __IIO_ADC_AD7266_H__
-
-/**
- * enum ad7266_range - AD7266 reference voltage range
- * @AD7266_RANGE_VREF: Device is configured for input range 0V - VREF
- *			(RANGE pin set to low)
- * @AD7266_RANGE_2VREF: Device is configured for input range 0V - 2VREF
- *			(RANGE pin set to high)
- */
-enum ad7266_range {
-	AD7266_RANGE_VREF,
-	AD7266_RANGE_2VREF,
-};
-
-/**
- * enum ad7266_mode - AD7266 sample mode
- * @AD7266_MODE_DIFF: Device is configured for full differential mode
- *				(SGL/DIFF pin set to low, AD0 pin set to low)
- * @AD7266_MODE_PSEUDO_DIFF: Device is configured for pseudo differential mode
- *				(SGL/DIFF pin set to low, AD0 pin set to high)
- * @AD7266_MODE_SINGLE_ENDED: Device is configured for single-ended mode
- *				(SGL/DIFF pin set to high)
- */
-enum ad7266_mode {
-	AD7266_MODE_DIFF,
-	AD7266_MODE_PSEUDO_DIFF,
-	AD7266_MODE_SINGLE_ENDED,
-};
-
-/**
- * struct ad7266_platform_data - Platform data for the AD7266 driver
- * @range: Reference voltage range the device is configured for
- * @mode: Sample mode the device is configured for
- * @fixed_addr: Whether the address pins are hard-wired
- */
-struct ad7266_platform_data {
-	enum ad7266_range range;
-	enum ad7266_mode mode;
-	bool fixed_addr;
-};
-
-#endif

-- 
2.56.0

