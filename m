Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793369175;
	b=lwmbvoJKP5nmegnFyPdd51z7GlSduY8oDvMHfwM14EV3V8W3lQweBmD9Q3xfg4VOKJrp
	 KhaoNk9oS/Ta3aDD785BmA/ud2Pzhm3G5F2nh0NWH+lU+nwp0vUoH/tZcfXRrfOQoX4tq
	 lGOxjsMp10JSUrMvSh1Tb67LCWGmr48m25F9f7UCIgj5qeNmYUEXYe2v1AuVsDbLlOQta
	 VlLzO39/GDT7dwfj8KW5xL3XBuVmgxjnDT93tTeESJwz/+KyTgU39Lxh48mJou7MAm1Iz
	 iRdhrQuNXBUWVWoSBt/QhBuFGUiyNHgWY6cUGek87BougwpZvqKIGeZVuBhLohT2/wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369175;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=c6CbRpoRysLtU+vMvJqEMnQt7em3lLx5fR8JRXLb+/Q=;
	b=ZO8O8aRHBxLewcLXFLph2HgulgWBVv/4Ov8A+vgDavBe0TUJPbo8ByhVtA/TbPduXcSb
	 QAv7GF+QtJIyq8e5A8L3LWeZqFi/v4iOI3HIvMMYzD042zkexXNUDLsb1vDme3O3h0BG6
	 kkYMyl77mFYH+mVPv7oG5z1LJZmXfNa8c712HMUUcc5VjDTmjAQf6IazHgP0wbGsvukxp
	 iT73n1ApIxSd4Yz2fjnVbR1Z6uhzppf+hxzCiJTpqozbY/o4QBMDojCYDvpp1ShQOyTHj
	 B4o4tbZpPKZ/VlrclVdykjiu2snYRMOcLS0PHKaI5JYm4apQJHn4T9L9uwrtAZcgCmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UNBX8Tu7;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Fg9985Td;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F74606A332;
	Fri, 30 Oct 2026 14:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F74606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UNBX8Tu7;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Fg9985Td
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBI9K33522105;
	Fri, 30 Oct 2026 10:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=c6CbRpoRysLtU+vMvJqEMnQt7em3lLx5fR8JRXLb+/Q=; b=UNBX8Tu
	7BNcpIpLNZNaMXxspx5WXEaOlxTnKqu0nvtAhcp6NWBEE5mvDLhQufRcoFgnjNEl
	d3CDLJNzDeblnabPg+FHbQIEwHpRA7GoC698FpZ7dH4YGeG1O4st2Z9/r9oY5xXd
	Ci62Ck+7MV3B/e6Z7DW6iQLgXnNw4Dp3pHgw+oqYfRwnUzF4QL56Oi1moY7cB+vL
	LuAkRU72mGQOOCiHzGVgDC80Wsji1vRibm96aX3Cjk3EoJ4JhA+JcAKjm/CDDK8L
	TNXsoRck9FxBvZuNxWVql3itvvTewj5tIOYP5LBcX21zMbmOd+od3xuudPzIo5oP
	Qkn2XK6NMiJj7XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c6CbR
	poRysLtU+vMvJqEMnQt7em3lLx5fR8JRXLb+/Q=; b=Fg9985Tdiu9sy4Mm3CkY/
	9hc2lsI7OVEESMvJmfPLrTKl+VqSdaWL9hviD9kqMcWyp7Uhn7e7hS6TwAvA1xWE
	xVJ9BdVMYIJzRygvCtpl9+harWo0TRSPQVFeho+qcKg/XAOZmQcK9yZSC7oT6JB7
	11XQF3vCSsOPt9/IeBFcnMh6v598Lb8PkN/2DX/Jue+Gr1zNXM1aCPwhC42MJ4NZ
	gBIeigPMJJ47zQS236RtkVbdu3iayIBJX7Snp9B8HT7wmM4+qiXUn3e5ki9CpGCi
	Ov8QzVefBGwIPVZX5xhnmkfLpMBgMnoa0auZk3s7RPxTZsbnWGaTZWZ/G5pz/401
	Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bv9b8-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:05:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEmaFEPwMUrEvqdtvR0HDtcwMHgeBSVwjAZscXCT6ZoUtFQ2zk8mJycqKK6Fc/TbElpyMS3kuQj4GPyirHlKfqnT09KAx1qmiWYD6ATq/U6I8aNVgGXk09U0AcocuDKbQ/IHLJRye8UCJkz4Fcu2tuZO1AQ5/tkjUQAcp2/IycB9bkSKeXnTUSLf4zEDl0Pura9M6xEx1Rm+jLpWQSjvbjeV2V+q1kb0JFTq5ECzgJxoFDjU+OcTSbQswIPAC5CMH2sNyP3rEEJFbgyjLt3RDqWh9tPpGqrD3gZIgTCm5fs0e+uVzSlH0FMDNmnsYEwEiXVvVAM+wps68JDb467O/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6CbRpoRysLtU+vMvJqEMnQt7em3lLx5fR8JRXLb+/Q=;
 b=BT/Xzh8D/nBR5e/mhEK6VyDSV7JxCHhePzehJVsN4sUIraiTSq+2idwvPkCiIUudepN30kgCmDfkJAQ63ZqMRydCPA7aNOGHiNdXXC89+FVF8LwN+ENCFUYKc+rq72q9QwtpDFl9wwNinqrXLSl6ZOEFgzBk37WpY3qNQnSFdWNfVziXmijhk5xpj+KF3ljTBpZaBoykW+GF9ggIMsE3z1OGFGcOLmwClZxCkIuOKl0xa7Zm+hxHgd4Q5pViedzskH7g3l43LciHwtXD5pdxE5UuRUEc4kJI3TKBthioqoGBQRnWXfnl/wAn9O9Gh3YLZGOn+JVbEfvcAUeCMHkKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5743.namprd03.prod.outlook.com (2603:10b6:a03:2d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:05:55 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:05:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 7/8] iio: imu: adis16607: Add external clock sync
 support
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@analog.com
In-Reply-To: <20261023-adis16607-v4-7-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-7-a4d541ebfd13@analog.com>
Date: Fri, 30 Oct 2026 14:06:58 +0000
Message-Id: <179336921880.155032.1399087627173819276.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793369220; l=1608;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=to+SAOM6TyMU9oF1B/Ny0ccX5iCDVgyuSY8vsuZYzdg=;
 b=QEL7A5c93eoswSZM1Db9wg1SilzKWdFmlbXWbDNyCK/ddl1zF6yqXLB7D7dwoIcJI3yuyuvuH
 fpo2TlL/DZ3DBJtpGkNCzhezZhpCxitoG0qjhVsi+dJbZ+UMt8j9SVH
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0180.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 5703d060-f6af-4010-7b8a-08df368ee9e5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|261026121527099003|10067099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 K3yZVmS/LPpGi3QCU4OaG8h0AwUd9w2wgS8+/L/dF6jxcqJ1nkJQgie4lFX6qolvFuAAjjqwi1mKfuzYnV2DJEb0G+eWbjY3bR+FzgG5WteuJmqAQbo4YpUg2MfhhOl1Z57Aly/cOrSIvokiZSE6AAUZekMPGrywD2O0k78pLia0i+jdWGtm89NmvzlNUyCLXz59G059qUYrEAwHXHrgRpdOF0OuENUqCsUd4KygXMiAkVujFFkWaPX1mD3cZJG9Si3S6rJvUP97iPnCNTo/QTWg4si2Hp7IfXWWBkYa0W7B7n2NLCy+ey0GygVRZHdY84VyUqFyhx7OQ+QDrruIsbLc9yKdMPgiSq55NeZaW8v4G1/oPCXkGwmg8pAcbCYLrDJh6t+EH7xcI2Yj5dmH8wx1NMtNDhRrUheGH94JDLU6FamR3ZoLKBWPhq0teAmdc74Y8kA6V3H5TXy5c2obHnICctTQByvjuvDTEC8NKTOUABoUFADO6mcQJbr6orvr6jWtLV62NJV2AsegG8I8xXazU9seIiAJHn3LAzCw+lvufgj1GJtFo0Lxxx2XHqwQncsTdFhTvd4tNxitNA7/Lamlk3IsgPRwk8dWfhlHykv/bCkcc8sZMkjOVCmbYfA3
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(10067099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MnhFdzZNUHNxMDZDV05NbkxuMGVqRmFQUFoxaHBtRCtrTmozdCtxOFNrSFpY?=
 =?utf-8?B?c05mdmU0ZFNOZzR1eEEwM3phSkxaSWVjY0RzK2ltdXJTVWpSeEdja3JpVDdH?=
 =?utf-8?B?U0lMK29iS0duTTczd21GY0lJMGFndjNoNTBqZDM1VjgrOC9CZlpZRGdWcEdh?=
 =?utf-8?B?b1RRcVgxZWlUVTlTNEE3czZSdWUzczBxQXQ0MlpsZnFmVDc4VmFmVzEvRDFt?=
 =?utf-8?B?dDFnMXYzR0kxTHZVTGpKSkI0UlEwWTFWL1VZMVdIQ2p5VHhLRDI5ck5MTzJW?=
 =?utf-8?B?YmtiazdnVHgzSmc4cnY3NTlRbDltQk5RWVBPRzU3SDBDb01Pd2lqTmx1STB6?=
 =?utf-8?B?V1UvTnhuSDJWaTVvbEFaK1I4QmROWmVmNUlNSWI4QUxTeEg5WGJ6cXZhWmxm?=
 =?utf-8?B?ZjRVc3BzSzBlVjJLd0FUdmhOVFRSSG1veXNUOXBBTWpxWnlkU2Z2WnZmYUR2?=
 =?utf-8?B?Q3p1QmV4SXRtblA1MmxhSHdpWUM3RFg1Z2J2ZzNqWDZzdlhZclJrakVBQk83?=
 =?utf-8?B?MDhKRDQwbnovWnlFRDVUeldmazEzTzEyWllOazZudzQ0ZWtIS2VJNnZ5ZXNC?=
 =?utf-8?B?UkpxeGpDL2M2eHpTYSs2N2F5bkR6MFp1UHpFRGJZcGlkdUJ1MnVrbFJIY1dz?=
 =?utf-8?B?YlBialErZDhMemtja3V4MlhyUFBRb1FXaUR1M3FTczFEM3FJLzJRaU1FZDNn?=
 =?utf-8?B?dFp4WDJJQzRWUGFpWVpwVitaT2pBZWFsTDBjd1dRVFR0TXJKNTR4RXJXaEMz?=
 =?utf-8?B?ejIwdlR3WWlSelB1OE1JUytoYjFuUUEvZjJwRklpd3F1WVRHbnFsWVozMGlJ?=
 =?utf-8?B?dmh0WEpnWHhFcHdqL0xrVXo5aDRQaXZiRVl5SlhqdFQ2VC9NeDNtVDFjMUZP?=
 =?utf-8?B?NTdsNDZUMDZsaDJNNGNsdUc2WVlHZmMxbjU0OWlYMjgwamJ1OVZBSXBaaFJz?=
 =?utf-8?B?aHZhRkFQL1FEdllZQUVEd3VlU3lHVGZLRzJ4UXN0aWpFeXBtY0QzemhaVCty?=
 =?utf-8?B?WXB0S1NqeWFveVg5bE92aW00RmtxVHIralNhQXQ1dFQrRTJuWWoxUmxqb0d4?=
 =?utf-8?B?cEtHdkNsMUNYbm9WN1VQR0diUFdESU50YUsvN3FSZEZxcTY0blpEMEdnb3RV?=
 =?utf-8?B?aWhzUXVyOGpHbkFQT1Ezc3pNaHlxWCs1QUkySElGZng1STZhblVDOCtjT3d1?=
 =?utf-8?B?a3hkalllbGI5OXdzNC9VdFQ5Q3NNV1JOcy9Vc3kvTFdQMXg3aXVBSU1kNFZy?=
 =?utf-8?B?UUpPR1hnaFdXUzlNS2FwSGNkaHh1Q1EramZuaDJtaWtPdWMvQWNUTWRNdm9C?=
 =?utf-8?B?L3JmcFJ3Mm9HQjF0TGs2YmRZNll5SlB1NEdQdm9CdGI5SEVudlBTcmJ6Njlz?=
 =?utf-8?B?Q3BMbVVjMjNiRnNRaHZSVi9NMGM0M0pmMCtGbWN5QkRnL2NVazYvR0M3d3Ex?=
 =?utf-8?B?WjNBaU5TaDQzanFUVmZFWFEwTllHVGt4R2RRb2RxZ0phK2ptN3NLc20vVGx1?=
 =?utf-8?B?Q2REYXQ5Wk5MY0NYcU5vWWRGNGtIRzgvVDMzOURjY0lrTWhzVWRZcVBXdnBx?=
 =?utf-8?B?MXlvSUQrSStLcjRVcU9kOTVFRzExY2tXcU1HVFNwdUZUeGI4cVFpVU1Ia0hC?=
 =?utf-8?B?VnBYSWN2LzcyeUtLL0VxQWtpVHlSUkJEZmFJSEduUTVJOUQ2R3Q3a1A4c3FO?=
 =?utf-8?B?L0RNelhUQmVIUTY2N3RwK2hRRHNPNDNZTGp2UVdEazhHWGc1aFhVMElEZUM0?=
 =?utf-8?B?UzlWNEczUTNqTDRRVXJnT29maWNZR3U1Tk55Sk5DcllRcEpkWnZHMmhUN096?=
 =?utf-8?B?MlprOHpMQzUxMkQ4TFZiK1VZdnhiWWxhV1RrOFpiMzAxVmVVTm45T1d0RFE2?=
 =?utf-8?B?RmxZV2RUYW9CQ0h1QldOR3AxVGFFK1lyVjcyS2F6ZGZkUTd4RlhtWlNoZnR2?=
 =?utf-8?B?NXdhakxMRWhVeGJvTkZtd0N6UDZjWFJWdytkcDMydkt2UUE5blQydjZ0RzZr?=
 =?utf-8?B?a29VR1ZxSVJYbUVYaXBZbTFmcXpYWmhwYXBsTVlrb2pzK203REZNR2ZTSXRy?=
 =?utf-8?B?N0xPenNEZVRIMEcyKzg4dzBOVUgyK0FWZ3YvQ0NSWDRYRlVRUHVIWC9oNnVI?=
 =?utf-8?B?R21XUUdGV2h5WS9iQ21JcU5CelRsV240alp2M1NUODNEbVZmQ3JEMDYxTjNt?=
 =?utf-8?B?djhPSThwWVJPby9nUmJ6c1RoR2g0cEQxeEtZZmZOdVpuVk83R1JBUER4NTA1?=
 =?utf-8?B?a2VnWVV3UlBPYnlONHFWYm1vQUQ2ZWR4VStYdm5MMzZrZE9NVUdDbXMwTmRs?=
 =?utf-8?B?azZmb2I2dFVoUjhORE1iMDRLRTVac2VoUUswdjF6aXljc1ExZkRoZz09?=
X-Exchange-RoutingPolicyChecked:
	5p387c2OUYBab6Y8n3XEru5Nh+qCcyZuYxQDcGkfXnac75uIFNpSziGS2N1Ucs+0+/MGeSO7nOAK2pFatg5LplzBx6PKpzu6H4/pcDqyylCbVNbiTnGe9kqxug8ElmNutUMsQvox9voicrtt0dHGTop0OHCyaAOwEp4wrC3+6d+ImDA2alX8klGZZ4Hp2rgNYgskPaY6dqbeMFzxozs+TXxTr3/wDHGOxK+A3rZQYE6IUXp927gOqycFAa1vWGqeTGaRg4h1qVoNNOarEZ4iNyenFPMhPAUbJuWSsMXQZGakabSRrAkart0BNNYpG6zAe6wVCqAGdDvR4Gya3sUGqg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5703d060-f6af-4010-7b8a-08df368ee9e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:05:54.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 480p3a5m/sHVZQTJdAaKMS3DwlL6FHCsU7Hhibc4ABkICu+YlkwxGoH/SwxFTDr65Ia1dzutR4r0uBys/MXnsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5743
X-Proofpoint-GUID: QUbt5IHSiMpDG1RygtY444YcDk82GMDf
X-Authority-Analysis: v=2.4 cv=Sc5i5fRu c=1 sm=1 tr=0 ts=6ae4a445 cx=c_pps
 a=n4Rd88MCvJemCXT3WVAnXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=P-IC7800AAAA:8 a=gAnH3GRIAAAA:8 a=QEDcSeZYy39fNLjGhY4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: QUbt5IHSiMpDG1RygtY444YcDk82GMDf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfXyg9febtaYKdI
 rVzoURwq/iVWwQv3I+UhW7vGWh7mOY2psOR1Yw4sVoCjcqT+HzP1PNcyC8+6UUdUXtGLbC0Wx6/
 yud4txH02KKwuJ6AVTLzO3C42KtM1K2/64EONFc8JLChd3O74276
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfXxdJN/rNbk6v+
 8GSvoxoFGT72gGCT1OgDqm+IZHJVqreqImmr3ZUbKIou04MYDoqU+L2P3k0ECiEpFbo2JxOeRFH
 GOtoK2xyFj3CwBnPemBFvGpkci5Y3OhAU6aH2CVM0TQR3C+O1Kqb2trt4Bvj3jFvad1cA4uJEZU
 dr2gpVzz4inKiCyBDW6/uTI5jjp2SBhT9mVuPQr71HLOZtWvkl1Yw/an+zBKn1GvQu+6XLA5oRD
 NzTft7Fh+9lmV6dSrWCzy22txBKySjmTlDMpZOLMEtb1BCBmjDwvcoPkAVLudZtKg5rxM5Vzc6b
 Rd8dCKDL7VTkoULuAZGuJGcnIPk7XIUEfdXzgKIro/u+JdImFortOvUJVjSOGIMjX74PYufqIM9
 DAYwxP4OT3QkDh+iBhF45sGhSL9622mbp0/y71FP7QsXIBtZoTZdqp+tEiPFilkD3LDEt97gXU9
 aEInLg69rdVSxiprgJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300055

On Fri, 23 Oct 2026 12:30:24 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> index b1f3667d8ce3..3c5b59820be1 100644
> --- a/drivers/iio/imu/adis16607.c
> +++ b/drivers/iio/imu/adis16607.c
> @@ -1063,17 +1091,96 @@ static const struct adis16607_chip_info adis16607_3_chip_info = {
> [ ... skip 24 lines ... ]
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	if (clk) {
> +		ext_clk_hz = clk_get_rate(clk);

The notifier might just be a lot of complication for something that I
dunno we'll hit in practice. So, I would very much request exlusive rate
for the clock if we want to care about this and deal with something more
complex if we ever need.

FWIW, I guess you need to handle things on PRE_RATE_CHANGE. For
example, if buffering is enabled we should deny the request!

> [ ... skip 47 lines ... ]
> +		 * sync_scale is a rounded integer, so the hardware's actual
> +		 * effective rate is ext_clk_hz * sync_scale, not necessarily
> +		 * int_clk_hz - use the real value here so sample_period_ns (and
> +		 * therefore FIFO sample timestamps) don't drift from it.
> +		 */
> +		st->clk_freq_mhz = (unsigned long)ext_clk_hz * sync_scale * 1000;

On other devices, we actually control the scale when adjusting ODR. Here
it looks like we keep it constant. Any reason for that? It does not give
so much flexibility. See:

https://elixir.bootlin.com/linux/v7.3/source/drivers/iio/imu/adis16475.c#L336

-- 
Nuno Sá <nuno.sa@analog.com>
