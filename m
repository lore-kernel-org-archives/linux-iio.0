Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793359419;
	b=iEgZU6zUxIzDqqllxm1vSZ8UfwPOYh/oizmLOIMxhavXfSHnLAVYkmRGQ8erB5Ae7u/J
	 njuTVFs0bKFuxzRwDJbjdS5l7MmCZn0GQYvYc+DYZPq8coJU7528sFB9FrAhl0JCJF0Se
	 Q3DOkxCU7aoSMZdE+R8APtL4eNI9DSQu6NPFjYyQ0DDyXQBS+9sZG5I+v9rJH086TQxyK
	 3fxRPGBkXwxk9EntTZIH5JUGetpzOLIsmj44DKqKmFrYY9d88618t8sZsE9hW1C8H2yhd
	 xt0OWIyI8m6zT4VkW07kfToXDjmQUt8o/GEjJGfE2kB5nxQMB+cHaTIV1AUvDdeMADQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359419;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DkSoi2gsLyzMwYzUvZ396Nz3YuM7+XrzkTyrmhfXkV0=;
	b=4dQCZ24qbsSuH3acEbvorK+wARIrwZ+Y39t89wwpPFzg4Iri4ivoMGkygPBWCKmYPxVP
	 StPNY2wonr+kAGL7PXA0ubv83iwo13BPX8VAQRcMlS4AakOr/1/EmnycVNr0tYTRT/9vo
	 8uA+dJWVEwHcLxZczJEG7VlB8Ps5XFbFvTXzZfJ1u4yLz9/T4WKelf5XsWCr6qJ/bflLA
	 qIYE4dhhp+v3M1rewuNHmN9/j9+LxbElrTw48CKmMCYO9v6yOoAc6J1Phc/29VKHVFRei
	 LQRLTEXSxwNFWtzIGewsSpI5/0o40ql+DYKLZXPoqLrVOP8CGtJPez89kdTzvB2tmhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="D43B/DaD";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=V546M0vn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E07606A31D;
	Fri, 30 Oct 2026 11:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E07606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=D43B/DaD;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=V546M0vn
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBIu8b3418823;
	Fri, 30 Oct 2026 07:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=DkSoi2gsLyzMwYzUvZ396Nz3YuM7+XrzkTyrmhfXkV0=; b=D43B/Da
	DTXyk9LaKYKyF3yTQPkAPYJnDmhV8J8PLQ/6SGJxg34F+2oi3ek1j61QkbBh0c0C
	x8X6w8DOAOxXD2pGgnCulUTcLYShfej/rzEQPFFEjCq/Oi3k/rTGWTboNZ1Kq4+f
	hLHd9znwF+WbrWQG97b+vbsxeVtA9romN9lO0PoDZtJiPKk7i4k/Otcg+sxLgTkN
	vXJ4xo6lKoFaz4WL8lN2S3wwOcYrWpREfT/NEQp0MhV1jhsvAKlzTyO1NMEPbRiI
	20DqDLmZ7sEMahr7T6JrR9YmPAX3JdqJGiAz8vot1bfDFClyz60P5vcLilcUVVxA
	lkg9fnoQOon7l+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DkSoi
	2gsLyzMwYzUvZ396Nz3YuM7+XrzkTyrmhfXkV0=; b=V546M0vnFtS0QegyX44lD
	EKIhhjg2d3Y9kJ2m1eDBGBw/6sTO07ya8PZh9z5/CU45kjtvxUJpR3jauHNSso0W
	V1jCXraoUH6z+QVE2nOqm+8LrvyeXDAsZuxy5/TsXXtmZztbVyHz2Et5kaD8BeWM
	bwk5MeG3rV3XCt2DxkyMRY1lBaJWJcxXLHQeFkrzPU9DbM1CBzfKNUBK4FJiTqfA
	o4CqmJaSw1l93m7jejmIT+n9fx52H0FJ1WOV9YZpE8Zq1OMz7byjlRtr639bcX2q
	EvL9p/CevRk6baus0FEfC/zLhAH1z5FrNBaKrfOJXOrSpk6HGgwBIHf1zZ1Bs+P4
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b3e7s-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 07:23:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1XOAQdCRAep23E8tOBCFl4V2qHIxXbEaPHaAyhxGETGj3PdU6vDZZAj8sZ85qff839s/TtCWQ3HxZHJOiCTF6CRTxOIPJ63G2j8JZRrQ9J/zp8UmJnCdolsQZ8D4/2Qwx91uW3BmJEcG61ak+E/OC0VrDl7MwisnPqxlY/yRApAAVdMqWbcnePEaqd4kz+9fzyaFwEvzZy9bHNTluHRyyBZuO/3N20hd/RHR9pBvRGXlkIN8Rqe8Xd0b6650mmLnem9kuscjHfD1s/L/97pZCjHWpyBL4U0r1jp9z3xTHG51EA7w+yfc3eO2Tz78SoXJBa4meWgBEFAy7IzrRFGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkSoi2gsLyzMwYzUvZ396Nz3YuM7+XrzkTyrmhfXkV0=;
 b=irpG8M4kJc80zCd60u0FbrlumhTC+LhUWdrL+Pr78Af/7bFch6ROEeogOn7ThDRk2Jv/5TJ9yvJkdmiQ4doohl8pwr+NnIk3H5x1RXgf9EIp2jTSL5ujKRrb5MNeAbYyhbgicrBrplWtWUMfZXR4oGsNkcOmhMwLUwQl8euD6fiOcFrc5kJDp4f9YJaZMG8+VbKshEIpwMgCWpFFtBWE2UFyb0cOSnYV5MssMiAEMUf3UvdAU4yEFeWogv38WIXJ+oAKDlRAGfvDsWbXq9EbP0krFPoNJN6FzuaokxjMhHcfACQp1EhzcO0AmY++SFNsq47XQdGSUy0TkKCW9DpE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB6382.namprd03.prod.outlook.com (2603:10b6:510:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:23:30 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:23:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 4/9] spi: restrict CS logical values to a contiguous
 sequence
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux@analog.com, broonie@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, Michael.Hennerich@analog.com,
        nuno.sa@analog.com, jic23@kernel.org, dlechner@baylibre.com,
        andriy.shevchenko@intel.com
In-Reply-To: <dd50e45bff4b59ad656f94fffecca28a49f1d2d3.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <dd50e45bff4b59ad656f94fffecca28a49f1d2d3.1792435248.git.Jonathan.Santos@analog.com>
Date: Fri, 30 Oct 2026 11:24:50 +0000
Message-Id: <179335949099.155032.17183119723878761171.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793359493; l=1022;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=A8fdWwkrJuaa0Vpjo67+LmDZ035V48Mnkcq1CBSUP5E=;
 b=63ybWceQavHMcKkEa+rCimYUPS0OdBcpgvGCDpynu3k/BZD1vNkVIm/D7A0yw4QOYLMMVRVfH
 bbHvZS29gKxCKeIJxUIuNqYrvogCiETOzYubl/B9STwEMQ3CMFuIIWe
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA4P292CA0009.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: da0d2533-fb31-4001-7626-08df36783979
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
 zjAJl/4zt7CjoTDfwZ/TRMK47i94YA1FOXeamW92Tl9n6I/R56P3n+rASF0aCQ9StJ0Kt25f21Sc1IqhcV8iQwQHZIn1sVvv2SUrk9EHdhTa+qeVZ9cTdhJXDYgZ72zk0FG/hKTnxXBhntgBDBc7iRzM8NN0CzSIlLZ+iv/6XUvl2ZqDVSoH9UOD+Y9KsqVXv10E5wXCbV4BMZyyJnayY+F1HuWkiSrc/gU51x8a/EG2bAEZDA/lmcJWIVJSGu36CIj9WP7uNpr4r2AGYys3hkcKL1ifx7FiPAzDB8Jn4mOCRzG1AcBe7/8GG6OI9oKhkoo7t1F6KBOaiHf0Gml2ZZ+O/3l/ofxs2jwYhvh1uPMU7yh1XJx8SG+LWqMQ41DDzq1sgLqWdDZMrft+kTCXogXcZfL2GM8roLsVe6BjSegwlsAX3MmpQyxm2v0r96B/SmmfgKPh4pl6xeMbYgGE9rLpzsDDPViWC2rwfxVgJBbOGRE0rG/MtXxeOR+XoV1c1JlgLe+iW5SDSpwgyPhY2xTLQxo9SekxIcc240EuHB8ULxCpfJ1BPbSsU/Suhc0keZBLQ9CZKSThr+ZWcQ59aaRsFmHt0oy9BAYkHxiMMGy74DR7v2OcxNuwkNkv+IueAxLyJg7Y8/nbsPX/e6pNcvnG3yv+o77rG08NJPbT4Mo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?USsySkY3amQ1K1ZTZmcyZktpbGpnUE9XM1ZiSlZyZXM3cld5OFQvUlNraEZC?=
 =?utf-8?B?OFlwbG5zeEh4SDgycVZsZkdoNTIzN2ZvVU4yc1VLaGZsekw2ZzduMkZ3bisx?=
 =?utf-8?B?dEhoNzhnelp0MnVCRk9OMUpTYTZzQXNNb3NHNHR0cFJNczBLWmZjdTFsU3pO?=
 =?utf-8?B?Q2s4ZHNjNGhFT2E0azF5b2ZrU2xBZmxyNGp6d2kvSFpVREJ2bjE2dGo3K1o5?=
 =?utf-8?B?TTFGQmlDcS9Gd0NFdE1pSENlN3o1TzNNSDYrR3pZdEZjUTcreVROclQrL0xz?=
 =?utf-8?B?ZTZRdjhaY016STAvNldtL3doQXlMc1lCdEhBck44Z2ZqOWY1Y0gvdDcrZ3dY?=
 =?utf-8?B?cjVnWTBucGl1N1gvOTlvNVZzVlZtM0V6NVBMRTcweXBhYkVzeWxUaitCWGtV?=
 =?utf-8?B?YXFzdFRGZ1FZMTVGVkZjOVY2TFZCTFdXYlNxT2JDSGRJWVhmZEJjY0RsUzd5?=
 =?utf-8?B?S0dCbkdINVl6RjFhc2MydDhqSm5tNE9obEtzSEptUUQyMk9UaStUU0VmK0VU?=
 =?utf-8?B?ZFF2NVY0S3lOMlQwMmhnanB3bzF5eGdVWmpDV0VFdVI0cnRkNzhxOHB1ZjFx?=
 =?utf-8?B?NFpjcEZVS2h4bU5BZ0ZpM1FuM3BvUUNScUZXbXFTZmdHNUkxUEVTN0FTaHV2?=
 =?utf-8?B?ODVCZzIxd01ZQ0VSVUNDQjhER3Vsa21aVlB0NFI2V1VjVFRPcXBibDVnTHBR?=
 =?utf-8?B?NDNKdk5zTFd5TVVMZmY5WUF1K3NoaFBpRk02ZVZHZUlhblhoVy9WNmZyZ0xP?=
 =?utf-8?B?WFQ1a3N5VnZOUnZVVjRiMEJJdHR4T3JqWXorWUxaMDVtT1Y2YVJ3T1JUZjJL?=
 =?utf-8?B?azF2Z0VFNFFSVEFzTnoxUjhTNGdtcWdkR0ZQbFEwc0pEM1lRL2pETDM2Z0lF?=
 =?utf-8?B?UWhEaXd2NmNsS1dFNnBXTzlzc1YrQ0NqaHZ1RldTMksrN1ZtQS9kZmw3dmkr?=
 =?utf-8?B?T1QwRGpwc1c4SEZTOGpxaW8zcUlpeGhzNDZ6RmpmcDVXT1M3ZGxHR2xkZS9H?=
 =?utf-8?B?Z3Irajk5ZnhmS2hvVnozYVcrOS9WMWFJWWNIRXMwYXdJRGJkOTV4M1BiT0s4?=
 =?utf-8?B?Z0RYNCthTTFodlJ6YTRsekVyZTRjeUFBcnRaMWl6aGp0OUNvMHBnczRnRTE3?=
 =?utf-8?B?emVRb2dnSHZPSGthUGs4c2Y3VU1xeXB6N2hvVGRBU2NieU1VbDU0aVRsbjRl?=
 =?utf-8?B?U1pkRTNES1VIcWQ3a2dKUDNnWkszRzVhRU9DY3BWeVBvN3hhYlVHWWFHazRQ?=
 =?utf-8?B?eVltd3NOYUViTHdBRmZnOTE1ZGI3eXhBRFY4TDh4bnNOaDBYWVhaVjcrZjl3?=
 =?utf-8?B?MU9KdVVOaHA5cjRkQVhaaDM5VVdLaVFGR09BcWhMaXZTTDdmZGJlVDRkUzJN?=
 =?utf-8?B?aXNodmE5b044QUhvSWswNXFQMW9oUE9rKzFON3d5WjFLY1AyRnlBdkxvU3FN?=
 =?utf-8?B?MFNVMEJoSHJVUkZSNHZBcm1Ed3lwM0p0cGQyU1JFZTB5UnJ5aFI5aGFrNGph?=
 =?utf-8?B?bEs0TXRiY29lc3lKeG1CQm9vdEUzQWF3dVJIUjFKL1hIaDdWWDM1SnlSVGR6?=
 =?utf-8?B?U2hhajMxcWd2VVZLR25XaUN4NFE0TmwrVXgxSEM1QXlMZUdHckJXV21NanlH?=
 =?utf-8?B?NFd2eUJQS08yaUhyazRJbTAvTlBHa0ZyYUU5emVqVG84Nnoyc2JuL0Q0V29m?=
 =?utf-8?B?ejRDTU80ZHFLUlNRZXppaEIwUzhwR2JiUlVIZHN0ejA3enBGVmY4S3JlQUI1?=
 =?utf-8?B?ZTBrQktSZGFFZ2hXQ1VBSmd2YmQxazdFa2ZGRDlpaWVhVW9pTkxDUU1xRENE?=
 =?utf-8?B?TkdVNGlpRGpMRzQ5K3NCSmphbER2Y2FpRWR3NzJqL3BrNUxQTHNkTWVma1dV?=
 =?utf-8?B?alg1bkNWczN2SHQyUHZIdWxCVWQ5cThScmlQQ0FDMkdZUjFHUVdybDliMjRK?=
 =?utf-8?B?eHN6MUxULzlYTFlzU2ZiQm8yUlR6WlREdDlCaHJIRDVRUkdwMmNiSzdPSnU4?=
 =?utf-8?B?ZTdIbXBpcFAxVkNpRTBEZmVpbENuNkVWUUhYa3lFL2Rxdjg3MEZVaU5EU2Jk?=
 =?utf-8?B?TGozSkltbFcyS091cC9tb042VHRUMFRFNVBGOVdFL1RUbHowZFpNZTVTdlpG?=
 =?utf-8?B?OU9uczhHZDhjck91RFUrVWdtVTRXVS9PQWVKd2NFYytJaDZZZ1ZnM1QxTDJL?=
 =?utf-8?B?ZGJvM0xMcFErRXJkRkU0dW1FYm1CckhHWjhpZHhHK3ZEaDNLdVJTWGc5UVl0?=
 =?utf-8?B?UkN4NUp0dGpXdEYyUjRYN29oL0pzQjBrR0YwRU0xeXZYTHdMVTNEM1daVGs5?=
 =?utf-8?B?Vm81WE9JSXE0SWxSZFdPZUlGK0l6dE80Y2NlNXFnK0xvQUw4akxnUT09?=
X-Exchange-RoutingPolicyChecked:
	SP67voHqCUDWcPcdhlDzvqFq98DxvcEBg1QUYgWbq7JyRxHFhWRgNTdOhMbTbYwEeS19yzC6RELMpVWHQLCSvNXoeYbaf7kporu45/8yDzW7DLs/FTkeSMUvkwZzRsvT72csWdEXCb+GwEJdaJTpjqtJblFT7dGOQQbvCXsCGXD3xxhIOuTrlpiNI80pjv0mm/+Y65Idnp/VFWphPw6CNolXPA3GE1uvrxQP+aJBwWdk4Yg29bR+1hT9d0XWAEVT/KOOyZlzdkmO9VIuqY5tdm1ubp44WQjbsfH/G8NlIsf7vpstfTOiLDSmY6sh9r7eeFmYKzkSHExVUOjz3Ev1Zg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0d2533-fb31-4001-7626-08df36783979
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:23:30.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea+X7qyaDu04bz18MvGoJw2gZktRQc+/nxJ3IkiTwR89Cm8kJylBzcjGpWYe0H7sU6p3UJ184LGEqBkB0BnPwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6382
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NCBTYWx0ZWRfX5K5wjAGTpaJj
 3BlF2/DP34yAD/aISLtroE93y15E/DKEX9nIgPXhHcPEyL+wlqoHSK1ITZqhnAgBlpbdKb+H8dP
 0DTKFX07EoKAx2tCe4fOfr3ph7TwImiAhUSJpcUk/5UAEeri3RfbXXKH/Dvyv15RczTXxa87MVu
 HuYnIud93yJHZ2DigpFoisolt/BgUexEFM4whj9rCvObTf8rCJvf1jg6NRC46cLGSmYonOiG5Y0
 DeoIN31aEbg0oDhqiF4BQJwtXPlqU3v8dQs/nHjKkM+Z7sbgYIPIOEKDh4+hHeqjHEFYCGx9+mK
 v2vlKpdCy+8xjSKb8g7ZnjWTetUvGOZSqOPWNohlZ52VOs/iTbJA0a67IOp2QlSpH1chPxIR8Xk
 2CeqOFmUy4ZAq/TCVRZuakmQUrtppMoPWzy6D4KLjUc6BI+6wg3wABN9zJ0zrqfGmcnwG8Z+0PN
 mbBzlLL0/ElWOzSk8dA==
X-Authority-Analysis: v=2.4 cv=UMJIjyfy c=1 sm=1 tr=0 ts=6ae47e35 cx=c_pps
 a=eebb4ZtE0r8msBY2xobl+w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=qK50Lz8zXp42IJRm3-EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NCBTYWx0ZWRfXxR3fcQe9nksR
 rnGlZVqx3vV9mh6pDYZRay8hWdawxXegb3jO42wdeEBP3N9S9OCWqukX2sSy3+QkpWlTpq7Mkqp
 H8b9BOxT0CEKdCOva7VbAoO9At4gr+FW0YsLhvftYwAnzPXRw+H4
X-Proofpoint-ORIG-GUID: vwVKB0mM8srXxuPsqs0_ZOrsRqG4AXdD
X-Proofpoint-GUID: vwVKB0mM8srXxuPsqs0_ZOrsRqG4AXdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300044

On Tue, 20 Oct 2026 22:57:28 -0300, Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 7a0406ec200e..2b2eeaa4c15d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -902,6 +902,16 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
>  	for (idx = spi->num_chipselect; idx < SPI_DEVICE_CS_CNT_MAX; idx++)
>  		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
>  
> +	/* Restrict CS logical values to a contiguous sequence */
> +	for (idx = 1; idx < spi->num_chipselect; idx++) {
> +		if (spi_get_chipselect(spi, idx) != spi_get_chipselect(spi, idx - 1) + 1) {
> +			dev_err(dev, "cs%d is not consecutive with cs%d\n",
> +				spi_get_chipselect(spi, idx),
> +				spi_get_chipselect(spi, idx - 1));
> +			return -EINVAL;
> +		}
> +	}
> +

Can't this break existing users? Not sure of any strong reason to
enforce it as it was nerver enforced AFAIK.

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
