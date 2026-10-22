Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679801;
	b=JMuaZCvB+d8kjRxaMu9JoUcOKX+Pzjg/L+hqMIjlUKyp6FEbvLGlWiXoL9S3iZtlbdFJ
	 BGIWlRD0YDCQGmG3fZa7hdgbi8Wejv7jwwxKouGgCK5mIjNXHLirNVWO/cWKP17UDLrZt
	 1q9+IWuWZwSaULRk6o4lTR13YtRcYlR0BSAxdRIJqbNtRy8QvNOttX1NFKRpWmk5sszy/
	 z2Uu/vHkS/GhstNjdSDlUQQHvkKPciEWYdums6CfRKriA/kuACAylfTxWiiACl4ZDib/v
	 fuAk0og4tcPT86twZNuXil7SnHYj1juY3AX2lDqrX1CZOjcK5iXcps0Q7s7NHKGCtpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679801;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Zc1VKipHpS0LAeYKQJc1O+WGCd9f+gQ9lwKNhIJOCq0=;
	b=MeYfuqxzAkS/0SY/wwEFiOggfLMHdm/KgBky6q4d8bcW0SGt2uUStfI/Y0MSXCR2OJog
	 g70j8V5xuTPussLaKSeIGG2iBT2ea+QT2UXXayaPsB3ZSc3B2KAlCQPIoiXTquPInIkAW
	 U9gObvcmQYkR81eP77IB3WTzu1o/K3KsXsOoxzIVJVo08mno1tP+CRUvgEZzm1s+ILnG/
	 90ROl7NiaN/NsKcOzlJdwV4UMJ3w5yj+/Z2rTp0wNiT2wN394vGHjLrlTIZpYGOhB2Ge1
	 CN2YV2Yp1gqNOjtCaAEuvQY9rxnbpWEFLhNCBw+NW4GobyVIepNq/XgtPYKbQTijbKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BE3EJjqE;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xzChKsgG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3493606A31F;
	Thu, 22 Oct 2026 14:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3493606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BE3EJjqE;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xzChKsgG
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MECgeI3325391;
	Thu, 22 Oct 2026 10:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Zc1VKipHpS0LAeYKQJc1O+WGCd9f+gQ9lwKNhIJOCq0=; b=BE3EJjq
	EC0DIFxoqAgREoB/HA1vvqpAW5FHf5vDkxcpYf77PKHjpKmiI2MNDn3yF2YkoahF
	m55bghhf58rAJozuOdhJUcfisjyYKg26BexMKa4+QOgKqDgVu7LZpRIqlRWCpyHn
	t8vzjIGv2or0S4+z6EOJmt6miD/+XZ4bz7UbIDdBiLcAN3d+mq+6NNaIpmzeFkuK
	B+wQJOtD+ohq9Xj263HDOGhqIOUsnIjAYADJlDguW2T2icpOwKB4ftfcnxkw9ZEo
	gvSgvx02IPwBuoL1h5RhpPnSVOwt0/ueS0xUn1aoVEOEGcTdcySzG8cKVwkK9D4T
	pUBbq2o4N02Mypg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Zc1VK
	ipHpS0LAeYKQJc1O+WGCd9f+gQ9lwKNhIJOCq0=; b=xzChKsgGaBpExg+0CRZoF
	j68DMC7it7vbNDhRxvJt3gBBqahG53BofejxkulDd6igbfw4L7b6kWGVd1pv3DE/
	dfgP0YlEQ5L2IvBJQgHzZ8Jwj8QBcrFyo6saPXVHfJ4LSJ4VCQah/8JjglyFrU/9
	Uz9FxSbK04q06vnrMkw8wZ+0hEtzMxbCk0H2cUFKXorsVHbsGbyWD02xS0jEH2SQ
	hSAdtBggOPG0bE6F3FyL8tyzl2uFM/0RxK0UVVaUreRNBQMnqsNBsJZvXFbH3o1S
	flo/7B9Pz7FS0aZwXyfjLtdkWyrBmNTpFVFtTct+OXGGnbFPIVgeTZlLx7PzrgrD
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927bsy7-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:36:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUInP2IpgZixXHWhNTSojlF0zcYtlilGW7op7rvO4BCTCeDk0lznwIvQ8Dtu52VYdjE7F2n9b14hlbYdHsat3e6q/WlbQtMvHOkvL1EGNOdMuGUFVLF/6+UR/p4qwImLl3iocCVUK6fpMg4nRRzz+uQUiYHoezrUglafjPKKuTSprmN+GZUSIdcsKZPxX8V8mID1c6lefxAADDK3trnx7q7hFAoq9iw9HnNkHmjuFq5GOOIxA67P463QuxVIlfS1h350KJp5y+qxh5nuWexOzUx++g/cjFS8TD4PDD4zp8u8C0Syn6amSmLjfjNq3WOy1f6iUfi36wHxeg2mPk6LFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc1VKipHpS0LAeYKQJc1O+WGCd9f+gQ9lwKNhIJOCq0=;
 b=t4+/lwTtLeFb+i6PqGF/9KPA2gFwZCAVAzMyRAspdEa+RYvd6nsbaecUOkCQoe9grJ2IQ2GxVpyFMJjllHFWxt5rETO6ug2TUFo+SoFD+/+eOhNoete2TQoKrd5lg9l5k2v1BuH5t83bz1ULao9rC9pglFw/cWd21hZBLmYMx7TYMum8oalJfzRbfomPTtBpkPls2sTKcfiaBYNT21DM8iZ9OFXu6CqM1wi7GMFeHMINawFL/S2q8LhFB703uyZINdnxIr+PVx6p+xyT6ZBKD6/TxHbEyJh6gyjvxv0OjLb+aI0ZQMqOx7SBSS19YlzVDHq6gdt8jCmD/MJfpIekSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5032.namprd03.prod.outlook.com (2603:10b6:a03:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:36:07 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 14:36:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/6] iio: imu: adis: Add optional self_test callback
 and fix custom reset dispatch
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261015-adis16607-v3-1-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
 <20261015-adis16607-v3-1-f972d4efee85@analog.com>
Date: Thu, 22 Oct 2026 15:37:18 +0100
Message-Id: <179267983872.3584.17378735813565830201.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679840; l=1073;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pYAtwGkUuStOW5YLZr99Jx3VYTUNkQjpu/Y5OxApXPU=;
 b=/dqcAFH3nTQefc35q2XDdReDRYmRQ4PA4M8jiIM/C/nM1DF2+ZU/6xTDXTXiB453FGYfYXntp
 MgdI0mcb64HA1STbl2UuMkNDRbNXcZZN0pIEIZCYi2wKYbuzjHh973o
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0200.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: ba25a9f7-33e7-434b-8e70-08df3049ce5a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|10067099003|261021121427099003|22082099003|4143699003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 gCe0U1LaYrQV7aII7gSOoiyU+3X6vXZ68hox3MYBx91J6DbFTSLyxZTctpf+3amy/wpgenu3msDeHc8V3Vbz5rc8s2a3g2yePQYiGnbvgGjPse6E6yzIyP1gYA8Q+21oe8905mpsr/MZHc8fmuCIr4nGGezlUDZlC0W1L7/IqLf+k8fMo+7SDj+HYTGIrc9wLm/YiSn7JKtZmJOwbO5mo6cdI+AmMg8i2GpkHcRjnFZcftRTiKWBVMIs/F42OIsTfFr0n8uEfREFoviMh/WXMDMjUplzUsy581WZWfN+/9ytdV9dVtoVnYK3TLXdZawtqsu6EJXTgMLfFM8QQWu/bmBDpq/sYKOUqrSrV0czHaxcA86KLcKonTL0oJzGO4uNMRgdoRefJcpwWTv9fdx5c7Dhihl6pWU4dgrRNMAzDupByBLGSxZhcfRjcmdaQwt203oWvUcq1iMiTCSNGOdqC1m/GdxTlvxqGmufwx+DT3bK5UR9xniIIF19Cenj0+DeMT6EcnX5lHxjk+/ciJgCrc4UDMvv60xPWPIyVWzUa2UgRonL2vDxGmj3GoI1F/iar1Mav/BmsG7jcUl1yPn0D5/4Zn2Rm0+G2O+6PHYPWtZG8X8ksT19a/Xz5C+bmrZ3z25lnZNfJEnZC9tWPcRZpfvxVfSvcDEdD7Ft/NnYpbs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(10067099003)(261021121427099003)(22082099003)(4143699003)(11063799006)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b1hxdWxQU0pObzI2K0pJc2NpOHJvSStCMSt5T1cxd3JpQ3BsTkhha0xQVFZh?=
 =?utf-8?B?a05UNlFhSUNTLzF5d3ZLVjV6dkwzVDJ2Q292MmdWbTJFZExJSWlGbmdJN3ZM?=
 =?utf-8?B?MTJWb3lXOE43Nzhic2RVVTRtcnB6Slh6Z01Gcm9wSGI4S2NFajBuSUdpN0U1?=
 =?utf-8?B?cERUN1VucFZIdjBtQXBrRFpqNU1FTEdlaWVsYko5VWQydmhZZnBtcHcrSjBn?=
 =?utf-8?B?bnJGVytqYkloc0VYVlJMOTd4aExqdi8wUGlmVzRxMldUbVBqN1cwMS9XYnZ5?=
 =?utf-8?B?ZkdYQ3dMNW44disveHBFZzEvdUVXQ0t3dGJDSnVLeitlK3dabXNUdm9BMmY1?=
 =?utf-8?B?WTkwTS9WVkpFWWxpVHRHV2NHVFdnbDZyUi9uK2NRbXgvNS8rNGNORDc2TS85?=
 =?utf-8?B?SjRoNi9KTGRvUnVXajJSQ3p1d1I0VlMwZXloeFl6Rm9IcklJc29zbkszLzBU?=
 =?utf-8?B?L0lnMDFaTUR3aTBuUi9nRml1MjM0dTRjVGJhcWMvRzlMWjhSOFBROEo3SEpq?=
 =?utf-8?B?UzN3Z1B2dXFXc3c5KzNsZmdCUXRCc0JBb1BKdUNJWFg3dDNSWU9EQVp6RWMy?=
 =?utf-8?B?NW9idHNWc2p6QjNsdkxNaVUwblRZamtKSlRveld6WXppdDNEQVViN3dZSmhX?=
 =?utf-8?B?cU53d01zVFdmcGRwTGJTWXdJZnFQNzdwS2owYjloZHNvTG53alNVZVhkNHJ3?=
 =?utf-8?B?SzhQU3d0eHo0YnUyYW4rWDhxSVVKQ0FMbERORHVJNGFXMm5iajlCdmczcFBQ?=
 =?utf-8?B?cDFEVEJIc3ZMTHg4ZXppS3I3WE9RUTU4MWJqdEdGRmNqNnEzaGRoUFFFVVJI?=
 =?utf-8?B?cUErLzA3My9SSW8xQml5K08rY211ZHR4K3hBY2VSUHRoWVllVHZEUHE3SUFJ?=
 =?utf-8?B?K2o4Qzk3cUxQZDMwZW9qNVJYSXFSYnJCaWlwcmROVnNuSG1RT2VkSFUzOFZM?=
 =?utf-8?B?ZkI2MGM2Nmk1UUNjRkFqbUZqdXZpTDk3K2wwek1YSGY1bmtjSXFTRzJ0dUdj?=
 =?utf-8?B?QU92MkNJNmVYYmFETzdmbnZKMVVwNzFjOWtBRUljeGtZZ1hNbXNWRURkZlBD?=
 =?utf-8?B?cTh1VSsrUlZhSk5SUkdUNld4MGNRNkNmUWROT0plM2ZNWXZLU3RPVkMwbnYr?=
 =?utf-8?B?akRYR3FZT3IxaVZmNjFWbFoxTlE2UC82SVg4T3Q5bkE0Q1lLL2poQjhOZTl1?=
 =?utf-8?B?QTlhSlZlendJcmVUNWpXYUdXREVFSmE0cFJ4eHNGZXQvUldpV2F1b1pHbm9C?=
 =?utf-8?B?UTBGUjFUVGl6a0pEZkVGMDFycUE3K3BEU1J3Y0JJMW5kNGM0MDY5dUs1Ry93?=
 =?utf-8?B?SlpGR3R1QVB3YmJvVlhKWmFCeDI0QTlQUVYrUWN0MS8wQnpIcVZzbTJMOU5q?=
 =?utf-8?B?UnhUSVVLQ09CYjdJWXBabkd2M3NTeWdjZ1V3WkNpZlFITDJ3dDFSZ2VadWRJ?=
 =?utf-8?B?TDhBZVd5WjYveEJKL3R3eXpZRTdSTW1UM28wZVFUNTRwK0diNVVURWwvZkE0?=
 =?utf-8?B?ZUxEZm1RQi9HSnVPZFV6THFwaHFRcy9sRC9tY2QzdzVHeEc2WTJBTHJZbDZO?=
 =?utf-8?B?THRjK2dwNXY2MEJiQ05KL2xPWjVPWHFsV0tWdStlY3J0enFlcHJVdDZocFZM?=
 =?utf-8?B?STVSQ29LZFhFR3YzZ0RrY0E4WDZ6RUp2bW9rRGd1dTVpZ0w5RTlFRG52RVps?=
 =?utf-8?B?Ni9wZFFKUjRjcUo5RjBNRG1VanY4Tyt0YlUyNmYzdXR1eU9ZK29wekhvL1lt?=
 =?utf-8?B?TTVNWDU4YnVGNVhJUjlrSENFcXRKMXAzUHM2VEdQRklkYnZpdm1jNUtzbzdz?=
 =?utf-8?B?T0NtM3dtTmVSWG9FM0xkTm94QXJxSnB5L2l2azNsOTNiNW9FNjBWYWdoTzFm?=
 =?utf-8?B?NkVSVVRGRHQ3dzNSNXlOekFZRHF6OW5NaS9kbFBIZnhSZHk1UURNZVp4RFUw?=
 =?utf-8?B?R1NESk1VUWt6SHM3UDhoZjFNRExnL2dxVVQ5T1BrTEtNTUJoQWd2a1BGZHdV?=
 =?utf-8?B?d2tmazVHOU9JTkZ4RXJBeTVMczlMWFNkQXd3QjdCRERrSy80VWozTVpFbmRW?=
 =?utf-8?B?MTlNVVc0Q2NzelNCcnFxcSs2UitLemxFbGdkWm5xc2xyLzAzSUhUZ2YxNGlv?=
 =?utf-8?B?bW8xUmNpRE80cGowUldpSGo5V2pSTXRDUkxKRHEyUGlSQTJEQzV6WEdzTldI?=
 =?utf-8?B?R0VNVzVmNEVYanJxbXQva0lUVmN5Q0JrTTRjbktmcGtsRnhJTE5ld1FtbXJH?=
 =?utf-8?B?dVdHNjVvQ280Q3gvTVpNYVcwbUxPczV5VUZObzllc3daN0RHMXg5Y0RsSkRZ?=
 =?utf-8?B?NzFRaUFWbVhkcjBRVnNDL2R0K2lBSWx1WDZrcG5sU1dJQlZJd0VRZz09?=
X-Exchange-RoutingPolicyChecked:
	sqo858qwCPJj+RM5UbglRTrw+gppcvS2XI6UX4hh9ai9dMAzJeH3Lk0aEFlnamyO98rlrpvfES1Ins4/T8IPTSRoQWkv/g/ylpizKhBkVWg/6S0SqLNZM9S6pJo9fjqXLHCXNlL6RVqy94P2j3dSNHGXZsxVjomtICPZRUBc7YuEpvcuiRoafaqMI3W7wMntgHfj7E3dH/zRDRCjCAw9a3gX+Dp2ybzQ0E/CnnXNYCTtEy6afuE/dBAmSSDVCQ9KlfvBw832NGg8qfm99otjlsI5mfiwiVQzXmc1nwKtfmvJAwPCwYYWC1JlCEI8R9/Qvvz2jB/x22DKL30RGVIk4g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba25a9f7-33e7-434b-8e70-08df3049ce5a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:36:06.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMGn3uqI89MDUoDp0M2z3KYtIhZBDXBqmxzacKycwUvMKsze8V4yRLxGrRVegTfvG6G9Gob7E/9peJgPYFiYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5032
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfXx+7EO0gVyDoD
 qo3kWCVb3/2CeHreQ6dysyea+nu3dDOdmff+Wes3Q094aoj3SiU9PCV4KgUQbSbdTFcewbvX5+W
 zPROWK/2obsjDL0ZMbvquiYp15nukutIKGGiVeu3jIvrxF/TZTA5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfX68yEB+Np9B5z
 CDowQAMCjprO1VMo6PM/dnWPIqRzUSXgpYRUTu4Cwr3UaYg8Bgw6tU/UqsSmU16i+2DI/T0VxWA
 /h4KAefzmvTgNGo5woawtiW9YAwK4D5Ivb6TrfjshlP6zyK9Hu2B/fLsz2jaxD+I+aeeTBzzTdz
 CvIzsbWP5GqOISza889r8mzj8Z6LIEbtn27vlcRw3aUKZTJXo1rJ3LhswQFIdC56Rg5qrkrOW5X
 ++fHPQuksjEyqIlZybwB6jDeNZK/yu5W3tWb9KAKTxRiNIj6Yd2vbZQEhNsmvhTZs9X8ekWGBCe
 vTgcH+SjIfFSdpDTgwTdZql2wQpOUzFq+9DLM+M5Y8Bk4jqLuw1Nvfb6rNl+IdvFMyVrjc5dfAh
 d/HpL/FlT1kE9IIQ5U7TP29BYmRz7PXjpwYDYoaCasD+SlwkKA8vxSClTZJnvI2H7rdtiWdI3Zh
 cjwEMzX4FMD/2qajjmw==
X-Proofpoint-ORIG-GUID: sDK65TtHw3yM45YN5be-kYSHSC3sVG07
X-Authority-Analysis: v=2.4 cv=WYKZ+EhX c=1 sm=1 tr=0 ts=6ada1f5c cx=c_pps
 a=i69ZgmgbQZPDBD2C4G6j1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=zVcmg-SJWKA8--WDBWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sDK65TtHw3yM45YN5be-kYSHSC3sVG07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220058

On Thu, 15 Oct 2026 12:32:58 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index a2bc1d14ed91..448046fd2ada 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -413,7 +422,20 @@ int __adis_initial_startup(struct adis *adis)
>  		gpiod_set_value_cansleep(gpio, 0);
>  		msleep(timeouts->reset_ms);
>  	} else {
> -		ret = __adis_reset(adis);
> +		ret = adis->ops->reset(adis);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * __adis_reset() already sleeps the settle time internally.
> +		 * Custom reset ops are documented (struct adis_ops::reset)
> +		 * not to, so sleep here for them.
> +		 */
> +		if (adis->ops->reset != __adis_reset)
> +			msleep(timeouts->sw_reset_ms);

Agree with Andy. Don't really like the above. Maybe we just have the one
explicit msleep() call in here (actually out of the if () else block)
and remove it from the internal __adis_reset(). Hence we can just call
the sleep() in adis_reset().

-- 
Nuno Sá <nuno.sa@analog.com>
