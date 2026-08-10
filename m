Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA993F44E7;
	Mon, 10 Aug 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374397; cv=fail; b=ItGuVYr0vaizZSU32vTMZWGbFCffih5dyzzlQCsPe7zOye2ffZ2Me/AilqHThyLejlrkFEnNa4AJRxVlmXY2/IWHq0qWCqz/jg6KTtqSX8iElH5UC8soPxYUTSBNhdgT+ipzeefJhTWD0OU9+C/Vgjude8X8yow+m7EI+kzpHMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374397; c=relaxed/simple;
	bh=1/er+tvdmiuCCLpXuDfo7B0iXSv7Ex0ENVuRkLZ5rAw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q9mj+ghgmJfgn9xxxGV13uuiy9QNJXuI/Wx9a7y/Tjoho7FNmUDJzeUfWKBICw2LpxWTDBj4kd5mpR8GjXwamPw0pbTc7bhESnVdK+RPtFIGVi/8w3Y9/rk58baa+tJrzmnl50W1qPLujEBtT8fwHeDucIPrJ3UWo6NW+A2RwMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pDoyOrVV; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pDoyOrVV"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsHLM3474289;
	Mon, 10 Aug 2026 11:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oTKFi
	0CdKWxcdpzMmkTJdh3U6s7eekk9uyrxXVVDfvY=; b=pDoyOrVV8mOqxl88afUBm
	2KV3Pzf8mg73bdl637Y73B3L/SzM7ljBbQ/vfLl6JnC/OAowDrnnhz3w+hQYMrdt
	M7il70oi8EmW8GQ0aadOswEXBYKzoE00j5hhi1EIY4/9t20fMQUvKVoXt/7cpd81
	oh6XXFyyhKq1XNtBfrz8n5aQKe3pFmXQV/n9l0kuZfDEiEZPKv4uB+hlTe6kEu+u
	atwLrumdbBhilwulu70AdPnPTG/1xRCZXT2YqPye/szKDOT0CgyH3pLXOKiR2Wfs
	0JQ0l0vgoQzQTnMi9231hSihuwlwO3T0QL4ph2St2BgAWGgxrcflQPZ3Tsuo6qwI
	A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbwfm-9
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:06:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZWsYOoX7KuoLCpRMdEs7UwHShJARiU9zAqdok7VSorMhzTJpOH9nEyej72QtWc0FaRmqv6NruNif+nPPQQqTnjLAx8HY882/yb2+Mxt5eK+1UboFCoQoImUTRGU1i5ree3PRnN/3GrKSDD8GmH5klY7gSY81/H6PpkzFU2iUN8Ziw9mIiTX6ntexolvIL6DVXPMMsPW0R7UxLCqsl4yJ6Mo5MeEcy4J4hZzr9UMqbcGE8GXXQTLPdxNkgIs/sQzz5SZil9Jw7FsBYc6DvUa+xSMKjLPNQbLmFXtBBUV2VrljvJxC7vhfC8LE5A2NT10DGvbBzx+cpbj2R2DdNHv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTKFi0CdKWxcdpzMmkTJdh3U6s7eekk9uyrxXVVDfvY=;
 b=VAZiMnWxCdto7BCQESznpXBzVORMwxoBJpPowpSJQDFnUNC6tKAeeLqZUPiaaWG4mJjUpLx4dgYahwLchtBrrkpNIKUB+ZFtl1pqhGPyWCEBPvAY3zSl/1B006v/4QnYFDf81EreSoxD+gZxHK0nAV62slCcMsnnOdV5yJ9Tws9Q9iJaSMFlmU2pIlCQMTixW4suvVECAIrYWE7cZa6tP2vGnGj9g7Fv+6KMEzFrLelRh1PwpyAdjHEs19bpCIB8XmcnOf05JMB3qn3fct7GoIJN82ymrabV14IpMxwk4Ly7WY8Cflpc8LvNMjXXxUUbWEHKpraGKt/9eCG5OEbecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:06:06 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:06:06 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:49 +0100
Subject: [PATCH v2 8/9] spi: dw: Use dma_slave_caps bus width helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-8-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=2166;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1/er+tvdmiuCCLpXuDfo7B0iXSv7Ex0ENVuRkLZ5rAw=;
 b=OqvSWsaWwrpUa8YFKME/NOI4ffXpUoFFnqiaHOzaDYWegRuxxtBOM+IgAl+K++/eA5iK9TOuM
 bDfJvf12/2aCzKKzdAzvoIDuC4MnZhhdIQJ1Rp6VuJv152oQpJ6q3Br
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0052.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 232e2a50-ba3c-4062-ad63-08def6f0e701
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 KdcMJSeVyYB/QRq+3OukDhJjRZPJefwju//2UWcRjWlGD8Uabik7sPbNawp3qZ1UQQYO4BYm3DC/y4mESldIoSSaSWGRroakzv8dA7gibYU6rS3elaWK0uYeMlvartOueljq17nUz1GNXt/E+RmaELzbFwlGG4tuDglMXHkkguy4+Ux9HWeQPkclCVvW0dMhsnUwN5xb7G3xuw8dPhcWGyxbEi8/8qfxymF9N9WLIxlm9ieab4G3FpJebtgtmJsw0ex0TH2UPZDhqITIrMMZitbUMSIprKf/U+dqSiyYF9uOsAGCFmBETwf2Prl+Ogj/E6FjaLTpIDRgg2sVWFylt0nANRcNqc2p0h5/27Nt5OIuMo58gSM3cgp8ivtOxqT47xuY8NhCZG+q7KZeDS5bh73+cCV6cfraDQg8O+pByTH/8+6lqt66MSu2WFferLtKu5/tujgwENZTmZWbhY3HKUJfJ69IRAOZQoHOfmtDXJkXeeOymYyvfFD7Wtr0GTGMy3cGNhFsy8hW6udQiYdh/2C+TXSeHhgop2HOZ3vhPQL1t3dTy455GFsKSLL6wo7OpW8p9Vm2X1/DZQ0zb3CF/okno83gbve0Yh+cAgGPXJBfcIVhOBBWY1Xst5GvMHOMF7eh8Dkv8Cb7wc8IUZ127fEO5DtdSIDsOJqnhEyYfAE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?amJvUGxTZSs4MHdhNUU0K0MwMGxHczUzb2N0K0VZeCtXMy9Ic1krczFKdUZx?=
 =?utf-8?B?Sk0vMEprWGtTNWlzbEZ1QXhRTFhVVk9DRStaWjgrNzM1R0UyNWRzZlhEUlNi?=
 =?utf-8?B?Mk5ESnRoSlJtWDBUZ2VrS0l2UUIvelRueHZiaGF4eHNnSXR6Y3lPeUJOWTZV?=
 =?utf-8?B?L0hrR1B1K0ppNlJaR0dTMXM0NzNHUjRqSjU3Tm1jVlRRcUhEK3A5K1BzRi9O?=
 =?utf-8?B?T0NHQnpseVRoc1FxK3FQckNlWGNKaHVpeExsYW9wUFJxK3J4UHc1U2tpdDdY?=
 =?utf-8?B?dUZmOHVHZjllQkYzeDdHaFozK2EvK0pWSnljb0VwakVXMHlHWTkzblFneklt?=
 =?utf-8?B?M2Q0WnBqMmpMSWk4cmRJMjBCVEVEbjduVWdCZ3pFRXBkVi9HbmhGTVBSTi9P?=
 =?utf-8?B?dmREOEhjaEtaeHB4SXJGSlM2UWNLREdDYk9WSGtMOGZWMkFZK1ArZ0VoS1E2?=
 =?utf-8?B?RTR2THZFWWtPbnlkNXF5NWljNzIyVFJicHlCUXZSK1VmRkFDOTVienA4L1Zr?=
 =?utf-8?B?dXlyOWsrWXRBMm9yWS8yenZkLzVCQ2xoZk9uZDYyVWVDeUVGMUxFU0ROVndX?=
 =?utf-8?B?dTVSdFBTK0RRd285VXNYVmEvVVpIVWdGYkhQOFFYMUFmU1MrTmdlWGxqZUtt?=
 =?utf-8?B?dHRhS2NHZVM0ekVORUJGbEFlSUd3bVJrSmxVQzRrdHdwMUgrSXVFRjhyNHp1?=
 =?utf-8?B?N3NyRGFFQTZxZldpd2RCdUc4Z2l4T295eUdraDU3NVY4WVBlZithQlRrUG5P?=
 =?utf-8?B?WFNCbE95MXhsUkMvOWMrSXRyYnFaQkJjVno0YS96aVNXSGM5SnR0aHhGUGdt?=
 =?utf-8?B?eDFqVE1Db0xzcHVPK2ZYQlVkVk5mSm9aNGpuUVN0MUlSa0JhUzI2c3pqYi9h?=
 =?utf-8?B?bmR4OXFkcG9iRThyamM3cDZ6aDQ0V25ZRHp5RGUwVk9JSms3LytvL1dHOFVF?=
 =?utf-8?B?VFN0UmdROWhyNXpQa1FnRWQwTGFlV1BEeVN2eGNYK3lYS21wZXNFSktPc1JF?=
 =?utf-8?B?OWt3OXdFa1Jja0xEdFVOR0RTQXVudkw2OW4xK3A5eUVlVElHMlB2c0VaaS8z?=
 =?utf-8?B?NXlEYlZaVWNieisvSERldTE4K0RhZ0JpUEIwYklzbFByRlJwZ3gxR0RweSta?=
 =?utf-8?B?eGhTSlhBVG16WW1YUVVvNnhxc2luRUFFd29uRkVMT2xET2syNEw1MnlSQ0dV?=
 =?utf-8?B?SWpsZ0QydFduTVZjVTJKT3NVbkthR2NjVCtaVmlHVW9jMVk5OElneTc2cEJU?=
 =?utf-8?B?NHE2RUZLSXUyQjNTZkszb1ROVWFyUmNsM3NRci92SHUwVFlkVVFtYzlPa2Uz?=
 =?utf-8?B?OVp3emFxU0ZlQ25nVUNmTy85VzRPNXo5UVd1bG1YT2ZvNEErOUw5TFQ4T1VK?=
 =?utf-8?B?d05YckppZWxOQnZXSWUrNXUydnhqeW1HTmZNYkFoTG5ZK1llOFh3OUV4emtk?=
 =?utf-8?B?OEl1a3IvRmcwall0ZytoRDZqazlaaFpKQ2VianJ3R0QxOWVVdkQxQnRhWnNx?=
 =?utf-8?B?eGJzM1Q1NkNQT2RSRVk3TzFsS3IwTUNzUHJkTStlNHl6dTlqRTJsRTdGcHB0?=
 =?utf-8?B?b0NhcmttdTZUZk42Tm1BM3FFb0RFWEk3MmZvMG1WWk1ZanpJZmcrN0dsQTBu?=
 =?utf-8?B?U2ZmK3gzSiszTVNKNFFWZ2gyalVpclZhc29EWGt1czdCS1RhRzhlL0pIVFJF?=
 =?utf-8?B?cTUwNWIrTUljTjRSZzJRSHFZLzkweEVJcXVGbEpZZ0cvMHJLK0gwdk14N2pK?=
 =?utf-8?B?SkUvcUlJL0s1QzdrL3IrZkhNUzNRMU1jSXUwSE9DMytiaEROb3hCQ1ZxbzMy?=
 =?utf-8?B?Qk5UYzh0a3NwVWZ1Z3RYdXFGMEJMdXJpTlB0V09xQjFnV0tKVXhsdmVJTU9K?=
 =?utf-8?B?YVhPRGZBNkZ4b0U2eVJ3VEEyTldZNk5oelUyeldIdlgxOUJBaUpiNFJaSk5r?=
 =?utf-8?B?aXlzY1JiU0V1cUR6Q2pGbjNVL1U3anc3WUdEZ1ZIS05EcjN1WFpzSDAyZUZ1?=
 =?utf-8?B?bmJ6SWQwUW8xTkVySEdadnd2TGxhV0h0UTZFR3o2SUFJZDNOTndoVk9yRVMz?=
 =?utf-8?B?dUNZaEVzNGx2OVVyRllqT1JtT24yUTBhQVZLaC9zM1pJTVFYayt4Vi9zcWJY?=
 =?utf-8?B?VmVEYUc5MUlSbFhUWUNGaHpycGFFRURmTXJyc1J5aklSZTNrSUQ4T0hYYzNM?=
 =?utf-8?B?TG9rSXNNaW4xRHljd2djUUZlVmRrSkt1NXZEZUxWay9GWUJnanNjNmxBYkhp?=
 =?utf-8?B?bnpYSVB6cFRzbHh1cjE4MUJDVnRJU0pXemtkNWpkUlNra1JpbGZXM3I3Q0hs?=
 =?utf-8?B?dS9tWVB4ZTB6Z25QcGlKRXFLaktPZUF2eWRYeVVLNTNIck9yRkI4QT09?=
X-Exchange-RoutingPolicyChecked:
	rKSX7ZB6i2acetei7E8OvH0Au2/sRMHrsk0+r46tz6GG0itpPrWDG0R1GmaFKP4q4CKMT3SZGBsgj0Ooi/whnogGTUcGdtcm0TqCUDEtM96/rRXbTwRTlWbqbPstght6VQtNy8yPt8EIKuBU2CuE5TZQiKbLDqK1njtyhM63EKZ6tvg+r3M14N/czAw65gqvzJx5ONIA0mUT//83kMOQ1LaTGG3O4DkpweslL4aFRTyYBF9NsMQ9II1CS+D+qX28dwGFBRuH2PHTvMd4niKFKMP5MsBBEShxBRmgF8IpZfOAblgzwvLaWdxbPqKOgc/sTNlsZxNSu2nHYAlxpK0JwQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232e2a50-ba3c-4062-ad63-08def6f0e701
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:06:06.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUKjcMVtlfOqI930Yq8dy7O9csNjjF/FDqwp3JjJeMEdbSByE3Ekcv8WiNPjohZTYiXcu0fSNGrd+CD7b39crQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: GMIxGruLtqkD7P__QR6TUnsbmuMl8CL6
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79e8e9 cx=c_pps
 a=94FLU6K3oGZrB1XHaeOsDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=wuRESdjZ-U6RjE8KBWAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX1CXYKNBP4Q5Z
 c9CqSFTuE5Nma44P6tzaD14G0W26UQXlQTleT7h4ddMhAXeiKnA3FcYs+fpZZcupmcefZ3NUelm
 IIQeZ3IcLY5NBD8WBl6FsvJN33GFAuebxqOfAiGZxpn4d8SwBFd4UKkIM/nhKhCC397MqY/27j7
 ffmzBSvLI/H/9LGzNYzbSQilO7URXEbVywtaAdWMsFbCP59JPK9b+yvrIdOP9E4GmLVi2lkLSzs
 dbUwWgX4nI7YE2V+GNSVpAa/fpNoq+kjVn39ddC9jxqWWki+TS2ALKLstbF/wz6cRNILRynZszq
 U62kfJ1ix00GnBvky3cZ/qArRSnRO4JrZhB9jeed94XklmbUuoWvcnjSYDcLIOwyqt8ohJ83Jpt
 Q9iQEDspLUzB+EPKVK/IUmcIHfUmrTd8yIJgG3OyTQztpNwzxYM+cFynu77Dz2XGe7g1Vgx4ANq
 7pSwGeOpXq/JAAhlZvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX6w3di4WHVWaG
 dCzqmKgq6k9qmmnBLt7z38/A+x7Md3PgvxEg1iwjwXoBUQq7kSyzwIyShpMaHmaw07L2E2oLj8G
 4fghVDZ6HRa8++mu+V5zu3PKq34xYCoVk30HL/V7RrxfwvMe/yP3
X-Proofpoint-GUID: GMIxGruLtqkD7P__QR6TUnsbmuMl8CL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

Store the common TX destination and RX source bus widths in a
driver-owned DMA bus width bitmap and populate it through the
dma_slave_caps helper.

This avoids depending on the legacy src_addr_widths and dst_addr_widths
masks returned by dma_get_slave_caps().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-dw-dma.c | 6 +++---
 drivers/spi/spi-dw.h     | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index fe726b9b1780..2e23ead4a94f 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -100,10 +100,10 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 
 	/*
 	 * Assuming both channels belong to the same DMA controller hence the
-	 * peripheral side address width capabilities most likely would be
+	 * peripheral side bus width capabilities most likely would be
 	 * the same.
 	 */
-	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+	dma_slave_caps_intersect_widths(&tx, &rx, dws->dma_bus_widths);
 
 	return 0;
 }
@@ -253,7 +253,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 
 	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return test_bit(dma_bus_width, dws->dma_bus_widths);
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2f2debc64e73..2c3aac4360b5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -10,6 +10,7 @@
 #include <linux/scatterlist.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
+#include <linux/dmaengine.h>
 
 /* Synopsys DW SSI IP-core virtual IDs */
 #define DW_PSSI_ID			0
@@ -190,7 +191,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
-	u32			dma_addr_widths;
+	DECLARE_DMA_BUS_WIDTHS(dma_bus_widths);
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;

-- 
2.55.0

