Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793359420;
	b=RzTu8rZ36DR/j5voAJBj6wfEu8xpPq/aMKirkqO/+DVWFjVo0KmDYpwLwTWLH3X+CHDt
	 HhSZu7KzK6mGycOBUDcUpFCG40ipfPnCu8+DSSqbXxjQyWhibOaMDihF2VjGC1WnzfkPH
	 bXXR0QMUCSDoa6Zqqo0Bx6QFXm1KQUuCbqNpac5F694BVO6zOMc/OYfxnY5ugmE7Hn0my
	 eQ1SLw0NDEG9evHYiqDK87u1BI0I9Wq7giFLM+oqqh13Xe4OLmLxQlP9L8n5KOplm+gnk
	 HAY2zpNxSGieV9zVTGIS7pzXzKVzXvQPxW0IlIhFRdCzY8BNxPLBX6FOEJYsVrxFr/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359420;
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZgqB3TOG6k5/omJcJjKc4JSiCF4XIed7zUAXH192uG8=;
	b=TUHogn0Ksz7PiHdi5f1efFCJMQmWpEsYKrC1jHkQI1zLnBokByIlUIuY8Xp0PWbsC9iE
	 SO8Ywngi9CpRci44BDfDEX85nCMP057FH+NvQirGFR2Ycau0apAj/VrGC/DRy4fGB6bIQ
	 rmLWSF4FNynd/hHqcWkTfNjoJL1rs/ZKpjKUkvuv3+1MVPYiqrj7/niE9h3tOdR9INCWA
	 kgWHATOdVQ47RGdcBC0maNdGlOqy7TDWHjMM1FZWV66BYxUzO8vTUh7jYtYLvSPlaRXAC
	 nYT40L70sEg8E0Oi1u41XkP7VDMhh3fcPASIO8CCPBwze4ULlUUH+LKB0jz/iqy9yGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NyXk7oji;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SRxyImxA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0F606A31C;
	Fri, 30 Oct 2026 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NyXk7oji;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SRxyImxA
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBHXHt969128;
	Fri, 30 Oct 2026 07:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ZgqB3TOG6k5/omJcJjKc4JSiCF4XIed7zUAXH192uG8=; b=NyXk7oj
	iHyJNPEER0Wzra0yiI/lLyhyqaroXviymquy1BKDkFU243GAr0JafQ3LlSMUIGZ7
	pX8FrTRyH2WlIgcJISDuiQ3pvUSDDImnixHP3VL4FLr+yMD0wfg2wIznKsH+c7AN
	9FM+YinLyiA+vGwrcySMBEUT9QD+Mo4vpa2nh4m8+RpsfYVUdKBTb+CSw84rx/iJ
	PFXl0uRUN62jXbsIEoVi5e+5yZ0NOCv1ekHDdxIQFBhhI8huJcyhPVeFGYrOC185
	y5RcI10GGgciGiWmjba2KyMHh8xTH9NEZHCgrraH5bisvQMxw7ynSQSwc9WWWY6k
	D2CoXzuYZBS8eTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZgqB3
	TOG6k5/omJcJjKc4JSiCF4XIed7zUAXH192uG8=; b=SRxyImxADtElMTjK4BRai
	Bz7GaeMd7V+EeNDEm32EuoU4tknmBs+CPHOq3IbXLyoBnDsP/ggGQckoFskruKEr
	Qu4U0Zst2PVbVCGB4rsuv7SLVEog46bZr3PRoUBHvozJGvy+0j8zembL3GKSP6qw
	aqUFueIZ6OY4uMtFos+HRoIZCVjYbWbRVfgTVc8HW6fHscoeKM/l+LLaSCz7kXBY
	l9Rwrcfo9MR8hFkpyCfW5JLmkfBlS/IPlgycuRYsaqrj/avT0WuQ/x1hU9z15hOB
	IUOAsyy1Hy6/QmDY69UK1ZP3gfpTufDys5O3cR89Mnfa8+H9cJisut/cz0YupM7x
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7d3r1p-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 07:23:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLNwepV8JOyQAu2XFpPVVhBO32LGv3Llv/VGwpbBKx+5pP91IEkARfP4GsHviZP15J1sOPfTgFmdtR9CWOpmHYTaB32IGaOEcFDaz4PsmDPZXeOkqXqIz/iDGlfNmpvtbnvIS3s0vTRt6rv/jsIBANT8ieYhBnxLZF32/ccm3Q4oJPzOk0GJMW7F82MhwHi1Fl/+K5zFSdS4bAoqOFNgW3QD8T+6DxJ+3wYz0BqBhQeYJ/+iVm2HaLEHYf/9wpiSXoo21iyf7bjR4wr4D6RQAqYuwyGuzr229k4PaEvVstmjaeyKFdepAvYsyu+FrU2w6Xoo4XSJZzc85LaOOHxLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgqB3TOG6k5/omJcJjKc4JSiCF4XIed7zUAXH192uG8=;
 b=EE1Qznh5g1bS6c8YWV+3IekEdvt+lWPcAKZNyBhDdYcTZob9uC22dSg4EsTDkkOMoANdGCgvNkB4QbR4bIXUYFtreoSy5cGmhWzlHZnSnQ9Ozv2f/ltdZ1pQCRlh87HLH1Ga975Rj2P4QByt70CufTL8T++hyhp6Nf9V6iP+0/xHbNrjhlw+5ONbZPVuXBq/ohrWC3qzrrn/B8d16KN8tWk2cXZTq172vIyzCIKLR6lB4JiFl7BV60ffS1aeyiAusc0v8+JcBmX6wDzxCqMQvTLPeG4E8mVYIfggM07ysWDUf7f+AaWuldZ0aT44/INSvpJI7/IepfLQMWuwjlbYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSVPR03MB989588.namprd03.prod.outlook.com (2603:10b6:8:41a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:23:34 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:23:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 9/9] iio: adc: ad7768-1: add support for multiple
 chip aggregation
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux@analog.com, broonie@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, Michael.Hennerich@analog.com,
        nuno.sa@analog.com, jic23@kernel.org, dlechner@baylibre.com,
        andriy.shevchenko@intel.com
In-Reply-To: <7afbafd67ad52b2342af30c278b8b001413221ee.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <7afbafd67ad52b2342af30c278b8b001413221ee.1792435248.git.Jonathan.Santos@analog.com>
Date: Fri, 30 Oct 2026 11:24:51 +0000
Message-Id: <179335949100.155032.10179249130274608755.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793359493; l=687;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Aqsn6JQrKy6NrQoTqgC7+m7S0vz55SLiIA8tGVjW0DA=;
 b=f6B9zj0gyL3j2SgGZeJS9cnSsh96J7ZO88MW5Zk/sc/oIs+KHTP8Dsto3ss9t/lOnHhGNdf4K
 t+lrtD+CTq+CLrE/H0fEvOUL9yYPjNn6hqhsXMZA/uTRS3fwuxjwjtb
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSVPR03MB989588:EE_
X-MS-Office365-Filtering-Correlation-Id: 13856145-637f-4890-fcfb-08df36783b85
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|10067099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 fGj8D4PnW6GqxqD7W/XMzMiY+YLKYRBavyt5tMQQmlO0NeHIuBO7D+r1Z4QXbA2+tOCVNf/FLXpmr6FzWH2rn169aiqQJDrnAF504HByCDEV9v7vLwFDjXAiSA9a2sLJ6NEUmmYaalhzi1/uSRMkzDjOwWaclb4OqxviKRzXoqEu5yYkEFULZ6iS9BJ93Zrfea+xgNEn6ob3dhBNTyUglpstlsoomO2NI5lA9IICrqfnKUFsZOzxmvX55qCBED79CfRPuvsQld/aOrGCHOVa1T2M3tXKmdpONKwzN/8N56joyDWokr+bizvHPkF6D7QM0fo4lypwl0O6LHqve00F2ggx2Sa5lyjSsImp9MbsB6/I7o7lLvuG2WEaQ6kje9jxEr9d4gqbW8ieJXzQMBNUIMb7uQB24a7+pWXRZsK/zCU98r2guKWxK0tGDJ8IOrglO7IXiIr1cRkzLeMwMdsHsI5BzTalJOA6E7jhZvSF2PUiYsKJukOQHf4WSngsLVIDSrIwpDUwAazZKLZnlCE/eDUWK+4n9fgXwO1tXf3kjGB59Q8dg0BeVXNLKC3IvWyNw/xUfC0TrsuTd2rHfpLo1iB44fRE3WG2F+UX5dfHwH4YMJHfULCyhJ/2e53N55WKrZPm5atNcPrFmyTlenhViz2OjXtQ0P5cGRPEHjZHRNE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WlRnZ3ovamJDUnNaVHRGa0Y5NlVrTVJkdUFLSVRmTTJjaXZESW15V2RLc0pQ?=
 =?utf-8?B?bWtiQTcvejNRZlpiQUtBNmpsNVkrVWl6bHBFd2h1dmVNNzU0c25FVERXUVdF?=
 =?utf-8?B?MkwvaW5pTHc3VTJNNnpIRXRTMkpGMUVBeHlVTUd3S1VidXZOZ1h0RjB6NjBN?=
 =?utf-8?B?TlFzWFJRT1pHcUJwLzlxTjVLdFUycFFKTEVzak0wdThpd2pEeHEwRFYyVE56?=
 =?utf-8?B?UWRFc3MyazBJY3RZeWJkcUZiY2VBOTcvemdpc0VtZGpRcXZEQWs1NEJzK0gz?=
 =?utf-8?B?b1FrbmlMa2NFMTF5d05zS1g1ams0L1psWXVrT09WUVovWENReXF5ZDl6YkZY?=
 =?utf-8?B?bnpNbUZPZS8wZkRDZnBKVUU1TU5LUjNZQWIzeFAwaVZpV3FBRERXT2ZKRFdV?=
 =?utf-8?B?MVZKUzJvVTRndGFFd203dy9tQ3NlTXEzakdLczZkbUNUNWFmKzlHL0hZeEhE?=
 =?utf-8?B?U1NaU1VNb3JKVUpOSWZTcE8vMnFsazF2ZkJGbFBValhIZVNIOGkrdjlSaVFh?=
 =?utf-8?B?ZkYvZjBXZTFkVSthT2loK0x1cW40d1JpQTQzZEhkOVB1WlBvUWRCSjVLaTA5?=
 =?utf-8?B?eXRwenJ2clJ4SXdQKzFmcnRZM2txSWVrV2RnZ1lhdjhkT3ZYQ3FCSEFDeGsr?=
 =?utf-8?B?cmVJTVVVNXRNaEliaDRhRkZRQmdyY0xGMFZqb2pKb1pFMUtRaFlQdU9GT2tS?=
 =?utf-8?B?MXcwYnBsL0dGNFZlc1RMSjErZXlCQVMvNitiT0ZhdHlhU0ltM3d2ZVA4UlNF?=
 =?utf-8?B?T0Z3Tko1ZGttSVQyZ0E4VENNOVJDM3BZMlJkNklNMmxhUDFDMndIOUxLbSs4?=
 =?utf-8?B?R0lZdXlVWFNqMmVLTDdmeHQybFptU2g0NzZIT2kzNjMzbWpUQWxiMXVPYkJi?=
 =?utf-8?B?dHBqcEZYbFFJR1NHR3ppZGtGR1ZLbE5hczhqdnFxWUtRMEZmQU84NWQwbnZ5?=
 =?utf-8?B?WWFsQTM2R1VtMDYzN2R2ZU9jL2ZtWmFaMVFMc1FpOTVsL29uNHpjZGg2dW5Z?=
 =?utf-8?B?ajhpaVQ4YitZYml5cnhRNm1Zcm5hYXo4UHBpZlZpdTB4TjNGKzZtaTFWU2Fo?=
 =?utf-8?B?NHpGZnRydzcrTElUNGNNbUtMMGRoa0lGaGJHVTBFNUkxbXpHZWg1Tjd0Vjl5?=
 =?utf-8?B?c0JaMWpQb0JpVnpBYnpleU5hMXRqbU9BTFExUjJ3d1BLUk81KzVpeTE3M3NG?=
 =?utf-8?B?UXFjVjBBaWV3QzB2QlYxazk5bGtzcEVkVC83Slp6NUVGaWhzMDBqUEFOSGVt?=
 =?utf-8?B?eFRDSnE2WHRzMXZtbGVHWWxtemlDQW5jWTY3czJEdVdwU1lOaUtaM2E0TDls?=
 =?utf-8?B?Yi81TGRqelpyV0EwU1RuZDZFS3RUaldzWWlsdHUyc3ZJQTBJMGN3dmxVMkVT?=
 =?utf-8?B?K3c3THFCRzBPbEZPeHJOSlBDZXNpYU55TWt5YWpFUjc4RnJJOXJSZW1SS3lB?=
 =?utf-8?B?K21ia0tLVEVQeXZoNE9Qb2JSczRsZlYvZXE2WFVYaWVLUnhOS2RSTDJ3b2Vy?=
 =?utf-8?B?Rm1qWHBBMitXb25qeExyWFh3SzhrQ0dRZVpUMS85c0VueUR0eFdOZHE3NDFS?=
 =?utf-8?B?dnhYSERnbTBGMnJEdVFPZTVoVnIzRHVCVzJNTWFkSWcwQmRwYTQvK1Q1WkFN?=
 =?utf-8?B?cDZ5YXRKSm90aUkrM0VsUFErVVFRY3BmNmRKWVErbWkxQklTQjdocWNaVVh5?=
 =?utf-8?B?aWp1azBkWHBUalhUSUliZmo3TnpQRTZGV1czOHVPd1p1dXVoTGg4Q1ZNL3lS?=
 =?utf-8?B?dEt2TFQ5dTIvQ2JKazI0R2ZYL0tYOU5HTnF2TFI5ZXdNNWZrQUdMVFQrendo?=
 =?utf-8?B?bWFSYmREZVVxM3lyc0w4WlJyWlJLRkZSUHZoQ0RrbTYvNFNsMm9GOHlxc2Ir?=
 =?utf-8?B?MitCWEhSWVpnNWwrWkZHWDdUbmpwZzIvZG9pNVd0WnJmd3NubWZaeWJCZ3hu?=
 =?utf-8?B?OVlhMTFrWUVYVFBtcDQrUTAzcDJhNm42ajNyU2FyaVJ2LzhDWjdZU1ZUT2xF?=
 =?utf-8?B?ekJQRnhEQVdzQUhaWW5LNUpabG5HZ25Yd3VJRmNJNDlrVVd2M0p6TkFjU1BI?=
 =?utf-8?B?ZWNWc1B4Z05QUXl4K2ZqcnhLSmszRzNDd3NTRERXTzZ1RGRwSFFpSGpDOVV5?=
 =?utf-8?B?d0IveEF3dWtKeTVuaDY4MDRLdmNvTXI5NjJFQXRoS0dXVWdOTVIwTlJTMUc2?=
 =?utf-8?B?YVNCYjQvVjVJUGtKSE8xZk9odFNKNTNHZ2IwNFpQU25qdzJGVzN0d1JEcUVY?=
 =?utf-8?B?aklUbVZxeGdKVjM2R2t0L1g0TE1jclArTy9zd09tcy8yOGFuM0hiOFdzcVIv?=
 =?utf-8?B?NTJnQWw0WFVMME96VTFUZGtmVHdVaTBoMm52S0pXNlA0U0p0SW9Wdz09?=
X-Exchange-RoutingPolicyChecked:
	T3UBGD0qoCMkUI7tZNgm6daSSIkJq/i03RRSve/1VAGuReswURJ1zqdjTz7pHLGrds0m0iE4e3ctmYP/Ix1yxsWemi8dNtUV/H+1kNoS5gkATyFu8I+uqC1ukIdM5n6laIAOCSDkxEd4ib+xFLDriygiHkH6vFUsDSvKbO+l5u+VT5mpgZFYamzcE/gISi91xSIEqN/9qZYmJKRkRkrQ6Dm5zjBBh4hjGcbwHFFNaSGsmV7uqYnTdygOPgdWm5bNHKjSQ1TkrhRITyVgERBZVWU7NKu2gKMivYzIFu++XPlV07hbyfBuEAc0g32OD2CUuemBbR2ucAwWs7H3mi7p1w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13856145-637f-4890-fcfb-08df36783b85
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:23:33.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAQ6+iHJRD1eIkqOu+8Q/Z+CqPsaxsi+sonRLBJsrDemFzoX/AIOcBsgNmOuTKaTN2QROKbzUtGjnmiS9XnB0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989588
X-Proofpoint-ORIG-GUID: LzsJ5CBAJY4b-kE5A1vIMipK6K5kXx5B
X-Authority-Analysis: v=2.4 cv=Yt2a1IYX c=1 sm=1 tr=0 ts=6ae47e39 cx=c_pps
 a=Za6wG3+qag5e9bFCWm8neg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=4QHOM5VpMxy0vlpL9_YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LzsJ5CBAJY4b-kE5A1vIMipK6K5kXx5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NCBTYWx0ZWRfXxmL+nqGub5eB
 AmglxiXUm2FFaQGXEmSt4H/QE2L9lWWcNnNUZEZlYZ6mRYMeqVbrpAxIrOfgkzHdFPosu6AzB3V
 vJk0zgESQeZ/KvteNlUmeSP83CzCBEwWs8bFzzA0T/+cp6ora3eXPElkwkaf3yML/dUM/fef1nc
 kW6uZOZYX51nd/iz3x6RTu3BCUCNEcin20VWhaYNlBWuYmFuhWWCbXh4yG5xTitceJGX9E0EL/D
 miktNx87L+ohA1sAHP6Dd8NtczJZJwgxQmFXO4nzRt0yQQhqD33+pQNFCsTT965hrKNkWvXofr8
 mRgT/4yeeiolpN/WRuP52KoLVeMDQcQVA/OIoOYe2HpCwC4zh4nG7rvpIurbSkCSwkkgd+JBpQm
 9y1WfN593F1QsDyTNpXXL3y1BDdSxm3mkBrDCAqDzVa0eBX82E9PcYvTQIq4FgQm+bpuI1BYU7F
 HC3TPmDauy9QuBFfXxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NCBTYWx0ZWRfX+E6TK9cEiqUw
 sUEkIyJhjGXAqyzBAGvzrT7hME2SF3y3X1+vRQo4TSDSLTw0xJIzhtYTK8txaztrNa/kBZZzPxC
 LS0nxkCh2N1TKZy9Z0gSUAwuRHZ0rfwcsTtUGSj6uymZ+wL+LjW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300044

On Tue, 20 Oct 2026 22:58:53 -0300, Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 3972821c295a..667c09326f92 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -1694,6 +1704,63 @@ static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
> [ ... skip 34 lines ... ]
> +	mask_longs = BITS_TO_LONGS(indio_dev->num_channels);
> +	masks = devm_bitmap_zalloc(dev, 2 * mask_longs * BITS_PER_LONG, GFP_KERNEL);
> +	if (!masks)
> +		return -ENOMEM;
> +
> +	bitmap_set(masks, 0, num_chans);

bitmap_fill()?

-- 
Nuno Sá <nuno.sa@analog.com>
