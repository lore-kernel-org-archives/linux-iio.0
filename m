Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D747D440;
	Thu, 15 Oct 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053826; cv=fail; b=YD1TJ3mOBB07iwPwahBLK4mJieALTN2xVu8lpT7IeA7a4drIyZqKwpnjQIkm+3MJkG5XZN+tSgej4OGoKZbAYzOb4+zlJyn55Lb//TLDJmRUCjm3YdM2o/zuQKiDl8V7UldyjfbTTCQqu0rliGUb916HX0lVnEw4WXRJ+bV/Ewk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053826; c=relaxed/simple;
	bh=iwlv4cYc/KpVZxYhIpplzyD/1s8agUt78/q5yqmZrAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OXCEgDb1TGObTiGnoCwy456WRo/Dc++r/vv6zENpN2Guhs+bKpXywt3AGFbFtA5qe2S25P3ZSClbhOgiAm+gBy8CXdSW+AjVOJ38OHo4o1iSHdtCbpnxCHSr69/TU5oeG6y5bt27N+BcpIoUstsa+7+7ykkVqCehaius24qx8rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=IMRljU7k; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Esn8WQhi; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="IMRljU7k";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Esn8WQhi"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F5MYsZ4024434;
	Thu, 15 Oct 2026 04:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=TpSGTItIgrHuHhNkLhoqkD5yPJDnwqmSANC05WVVr9s=; b=IMRljU7
	kRxJyaBm6MFNoq9OW+lgdsVzuzc2kmqdaWjrYzcZegKOHHPigS4c39r4SjIOxCbe
	iSN7gaROFh5OX+qmAPLYxT1/AtgtP2iUAfKsKEdfh25hjUAgIjFmZhM8+9d1o1hm
	BohbwVPI+rbJGXtWTwaeF/y7Ac6M8plhlIVF+ueTXuddvACSGQHmnh+2OJyaAcWg
	uFGvk7nsh6R+F/MGwsZm30ijtsQx6dUadVozmm8x54xuWy6Amyzzx5amywrX4I5d
	CssoxWu6wmuwzxSyUGzM4w+t2A72YQo3LhtBzqtS36A1Cq8WCZnLL2M1Sn0hMDpw
	nN8v8KjzFNe8VXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TpSGT
	ItIgrHuHhNkLhoqkD5yPJDnwqmSANC05WVVr9s=; b=Esn8WQhi1cMwJ69T9zWq5
	Gu05pvMfZAG7QDc4oSYqU/apUIrU6InFAkDfe5S+6gClDHAIkjm56OOoB+hcdhDL
	UJWuT2mjQxRr+m1NgdT7zcw+vmwdAVqjfoFbPcK7xVfDLasFNhFqWmAQVBIvpPgq
	WIiBeIdWsIfzhGg8u1MLSpPJmIe3otPb5D95mT4s8bCn9SUiW0B4bpeSsH7OQdSj
	vBt9rBuToPa5IPHvVqgm9DQuII7E8UNB+gK6UFj8q2aoOGgqETv35naFUSB8XwP/
	nItcxpVKOAdC1C7MnbR5BwkXBMBV0t1R7XSlFSLDuyl/lDsqZMZ8z2TiasqaNhly
	Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haab65qbf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 04:43:41 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izOjPYrPX061MoejGLuwa7dXYikp/x2GYWqaZgWmr/ntXFufFRcP+/sTqlROt6pIN17PQELecCCrmNymyIet8LVlSe+S5UjBWr/k6SJ0RQm7xyqx4u/Du0+eLuxK1yF0e/I6MbFrHzHjq8BY7FaEHCnjA6UygUfeM2iMC5l/cRcyTDa8is+w5VjXxJV2y7od8zlQxpfJ41HQH8rD7nj6N6Ouxbm37eYYDFG/HgMxuJLLEehFB9ALBZz1C0aaoxIy5BXs2C46r+81x3NBYNlbEZkGtj6gMMfYh/SXNA6LWbX5prO23jKsLfq7BYLii5CehR+dtfccTvd3bIWce6AWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpSGTItIgrHuHhNkLhoqkD5yPJDnwqmSANC05WVVr9s=;
 b=jtLzwzuXqRTutLEGgy2oIUfFGKP4JzC94fNsIPD/pjIHg753v/yXP2aZriIhWNCzETghAFvgibMeWDcNpDyMAZsRKbaIJZabC22UqlD1O4rzcmhErV/+q6B8kmH+GwoLHXr2KDL2qHTincAVILsYH3/Wqg2Fa84hoWjHU5ZQ+hFeTXF132+DPJpfRlVYcQie5GjRY6V8Ywxct3CewkDWoz6ArZp55pnAV5F5TrTN2eehBGlCnmIl/rMH6zWk11hwxxqfKFFo2NnOs/OJHdi9I78WM9NAT4NFZUBbCBqQkhfr0Yr3GVbOmQPvmUec4y7s2tmWCFJfFV423PXvW7guSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSM1PF470409B67.namprd03.prod.outlook.com (2603:10b6:f:fc02::54c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 08:43:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 08:43:39 +0000
Date: Thu, 15 Oct 2026 09:45:00 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Rodrigo Alencar <rodrigo.alencar@analog.com>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5686: fix channels member name in kernel-doc
Message-ID: <atCSevvIuyomufQ5@nsa>
References: <20261011045149.353929-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011045149.353929-1-kapoorarnav43@gmail.com>
X-ClientProxiedBy: MR1P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSM1PF470409B67:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ac804b-6d82-4322-65aa-08df2a9868b6
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 2bJ/M+dr3vVnIBxECMNXSMFe08MtROSJRbbaISGmohAMWllxJ7A3o4OCkYu+DUckxDbNN7jjsPE5ahDwNJ9MtvIjge6SXd9bAm6caXPwKeavlxYxDLEdaQkWeJO8rlq+/3pEWPDYw4UPZ6JiBs+RdStJAABxpwamIBxfU7u8EjgTnxcRr1i78p8Ee0deT4r12bO+dHiNyV+3VLy8YR3G2ZoI7SUz7UjQpd8GjgEJdh1yplidSr/jT51E6AnrxJi8Lr7XHz0+Q2UbdG7Ll+ucjSZwu0QDSl1biq8lT3jOSL/tNe9jw7Xl49hyRU/wMEyu8yW4wcp+7BUofyD553MY+xDZKk0zxpGZ61cEHSo0aG35Il0O4hfS+Vq0pxEJWpciOYs4BCr6s7a0UTq6xDbyqLnx/vTJ/bEYCtTjFPe/U7fpyfBBq5UFAot+a5KYeqqtWIdyaWf4hk7F+2UCpKHfJ+kt0p2qYngLgmVDoD6Y1Lila5Mzl7nVgakD6M2MQfweZNQ0EuxEVl9dQbEUBOVrmtOTiQXJzsXPSslEDSR7WcQ+plGjBkJu88jSuKDaVOIWYdLH5G4qGK04qfjXmVLRok7v1LTe19dSSTDz3z4Km6PN64Fpa+qDtScL+23LfOP3RueeI+34fzlw+6IM3R9L8wK3uB9sHXqWPMRsF6Mrfy8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MTd4TUs1eC91RVh5cEtuRVpqOVNtUXprL20xNHI1WlBlYnR3eDMzY1BYU3g0?=
 =?utf-8?B?L1VkcUs4UE95dWIreEFzYkJYMUtBVXk3V0ZVRTRCY0FxY0d2MjlyVFY4Zmc2?=
 =?utf-8?B?V2ZRekNmbWxJVWo5TE5wTjF5VldWZGgvRzMyTUtTUEJlVEFOMHhzOVRtamFG?=
 =?utf-8?B?QXFGdjdHTjVPcHRuUUlzZVpjUDZzRUVCMjYxTmFjem1pY3NIZ3pxV3lUZHFQ?=
 =?utf-8?B?SW9KYTdKU1JHRDFxb0RLZ1VObDBraTIyODdKWlF0RWVmQjFKdEFENGpQdzE0?=
 =?utf-8?B?QndEcER0TmhsaktsNmxldnF3bldaOWROV3BOYkNjV3pyVW1TWjh0Y2VuOUs5?=
 =?utf-8?B?NFd6dUZ6T1I2RWRkNTR4VUd3clhadTQrUmFpamVkaHZmV09ScFNwWit4TnJw?=
 =?utf-8?B?OFFkOStQWnMrYk9OMEFCVHBKVytONk11VzdjUEZOLzlJNDdLREtNa0hIZ2Jv?=
 =?utf-8?B?dUpmTXZZSkp0cStyUkJhUXh4MjA3cm9lVVNNaGRWWEF2OTc1aUVmUGsxKy9O?=
 =?utf-8?B?MUxESWVMcGdiUjF1ZGh5Rkh5VjczSG1DbFZqU1gwTHBuYzB3QUE4Z3l5c29m?=
 =?utf-8?B?OXRXMmtiMGtCb3J1NG50a2ZVVWs4ZU5CL1lJNTFkUlVrK1FBZHhpQTNYcWoy?=
 =?utf-8?B?cnpXNzZPeG55aWIwZnZHR21XdGI5ditvTldOUG1pL3ZmaUg0RUIyYTJFcUJJ?=
 =?utf-8?B?UXcwV2txcHU5am8xOFUwOTd0bjRSdnI0Z0Ywc240eWJBVzdsa3hreWFobU5s?=
 =?utf-8?B?LzVDK0ZGK1ZRZG53NXUrakkxaDkvdjVibHNzQmp0TzVMN2EwSldZeHpSZ1U5?=
 =?utf-8?B?cnhjYUN2alRkL0wyOENvbXVXbGU4UFhJQ0c2bG83MkJZWnIwV3J0YU0wZ05i?=
 =?utf-8?B?b0ZXelV2NDlvY1J3VXBNQ2xaUG5NY0xuL091ZmpIaDZJWTBDeWRJMC9vZWJv?=
 =?utf-8?B?TVZiY3ZOWm5UNkRidStJWU5FT2kxalNPcXlKcS9HVjI0cjdMTzdpb1VaNFRX?=
 =?utf-8?B?L1QzMGpMQmxUcC83S0tYcG4rMWppM3JBc2c1UG9RMmdkVE16YmV4RitJVjZW?=
 =?utf-8?B?YUFrbXR5WVRvWllaMkVEZXE3WmlBTUtIRmNUWG5vVTFYYVY5YVBTSW5YSjR1?=
 =?utf-8?B?S0VSTkJxUWRYbHdXS1pWSlg5YlZ3d284QUsySE1jeDgrUmNMMllCQkl6VWJY?=
 =?utf-8?B?Q3hWaHEwMGZrM1QxRjIybUJONlQ3VWJXb1BoTTR5bCtkZGw2VDdIRmVlT0sw?=
 =?utf-8?B?ZXpEUHlyanlJN1N6L3A0d240ckR3U3BlYUJkeE9XSU9aTjNsTS91aG14SEZR?=
 =?utf-8?B?YllSekxjaDhoNVV3bm5sblhyZlhxSlBJWEdhQmJURWFzZ24rWkNoWmhmRkxI?=
 =?utf-8?B?aWxLWnpxeHlLNHd6RGkwVlZ0YW56dkVoMnRiWkxoT1pnZGREbzlQUEZVcllP?=
 =?utf-8?B?UWJRNXpJc20yK1YzSHE2NG4wc0ZtUUlPVDNFczR5NFYxenVNYWNCa0VqbTJi?=
 =?utf-8?B?R0lGTlZOZENXbGsvSTVhdGNicjV3bEV3OUNlMzBTRU14NmZ4eFM3am9zN1Za?=
 =?utf-8?B?M0NKQUsvL3NsUkVOd3k3aFRSN2k4ZWFVbHhHZ1BLbTZJZUN1ak00TmRiVDc1?=
 =?utf-8?B?NGM5UTNqa3M5Y1M4ZlFJaStPZkRXVlhscHhMM2xINnJ0ZlhkVmZzdzNSSEJv?=
 =?utf-8?B?NEh3Zk1HTFZIRE9kZXdEaFowbGZ1bjZsZnUrQzlTSlR2MXVlaGJxa3NUTlFS?=
 =?utf-8?B?Y3M0L3k3NTF3WmRZb0tsaWxqM21CaHhkc09wM0orMlduZ2IwYWh1MzZDd3Br?=
 =?utf-8?B?VUFMeHlTdU5KNXpyd3VkVDJaMEQzTFQvSmUzaDNUQmlGTGdFdmUrdGk0VGlM?=
 =?utf-8?B?TzFyV3lBNHZ1RjBGd3N0bWlqWTA5clRaU003YkNaRUdSSTMxSElFV2tkVFF0?=
 =?utf-8?B?N2pZemJXMDRwWUd0U0FMNmFVTGRxTEFQcWJTVm5EaGdHU00vSTUwUS9KMG82?=
 =?utf-8?B?S3JqT0Q5SFdUenhIazIvQUNyaU5IYkpQYUFpdTFxOHZvaEtzUy9EOWtNTUNw?=
 =?utf-8?B?aVlqSVVQL0hxbGNQajZOeWxMTzM1d09LWVB1ZGVsNzgvTjkzWHR1UkcwK3Ba?=
 =?utf-8?B?UzNydTlYU1k2T3ZBWkZqMUFZQ0dJN2tzWUxlL3JLa1FwdlRLYW1IOUZ1TEZk?=
 =?utf-8?B?R1kvV3V1dlpNU21uNXlEYXZRWFdITVFWWjRpbFVUcXNDbk1IOUFjbWJQUmRI?=
 =?utf-8?B?b1hLNS9reWMvKzE1YUN5NVYyQXJ5czZtNks4UkJyUVo1UDFadElWNWo5aTRL?=
 =?utf-8?B?UzZybWFIUkZrbHpIZnVpQWFRUzV4RkpuWVhPYVcycW1vVzN0Q1I0QT09?=
X-Exchange-RoutingPolicyChecked:
	d19QeVG41uGve/Jhx1hZg7rbQhUKsV9pzhxrmTdScjdWdS9H3hrvUwozjqGg8zq0NmFvaLFQXo0SjWYOEAH8+8iSEs5zIH/arT6oGqgq5hcbT4kXGC8xGeDN/VwJzwFBoONjR0vjWUj4jnJJmJfts1jxVv+0dbuMw9vHfz52qaGCtwdoIwXFyA7GZqunEIS9RtLJBLl77KkAfc+s+RcHsF+z44ml05rPOdxLPWM8RHiLF1Q4qOafsRERVGHLtG3wavWbuJp9FeIsB3OSpNitGK1kDUSAm6cHTLpDVG0hzQOLipsdatdCOSmxy4UFuy29ND5WJY1kVb5BbuMrs/iJsQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ac804b-6d82-4322-65aa-08df2a9868b6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:43:39.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+ivv1c94FZwLSSp657xy6ki47moGgYSQFkPoZfNBSHhi4ph3KhIbYgIVc2jar7WoQf1jvUHZnvQD19h21Sezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF470409B67
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6ad0923d cx=c_pps
 a=Y5aTAp+79vj4S64KMabfRQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=wACKQ5AnvPAm6lK931gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: z6RRtkGj10g7OggDj-AHxT2VeQYZ2Grz
X-Proofpoint-ORIG-GUID: z6RRtkGj10g7OggDj-AHxT2VeQYZ2Grz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX1pV+AS6ySaeR
 TDVa0e8AT2gDSQzl2CefTU8ayAZcHvSk8CfB5dMLElmFh2wMu4rT7vLyPhBnUcKPjv7CkXRr0XF
 0w+v8GTUu2QFvELHU0asxDMIcV5vgP3bvDRJddwrPkjmqIq3GzkqLU9kx5dYPkaS2VVL4ANHhiD
 httU0f6nkjZ8ZnBaN03lv4mkkbLYgZY0XYUU38n3NFhpfw0KzBut75lLjukGkH002DsIynu3pqd
 lnJ6QpZnAZRYEwzaTcNHCKvYodPjFt2ZONBSpGAFFeVb9xMGPseDFWshE87+dPnxv1wnNc5RwJg
 W961bpufgVGYeY0HQxfECSr5vn+sp//a8RFc7Kl4Ypeth/ttDAd6+NuUh9T8lzfpAZAVeh//skP
 2xwh65odnSvRuk+KCcwy+eq3L3PBdrpJcHlav5M2Fc9GhVdB7BgbPi7nSQki6skc5dyYJMicyug
 fpvpqBn6g7BtA3oUnhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX+yGZ5BvSzUMj
 OlmRHTyW46L0M95RmJOrqppQD5z9JoCtPdBxppOhpw/SW0MEX0+dPatqaPZAWrD0elO2EaKLTES
 RDaXGnbcruKoCeu5NWa59tAo944BlmNvc7N/Jq2+1ir8/keuGZuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150034

On Sun, Oct 11, 2026 at 10:21:47AM +0530, Arnav Kapoor wrote:
> The kernel-doc for struct ad5686_chip_info describes a member called
> @channel, but the member is named channels. W=1 builds report:
> 
>   Warning: drivers/iio/dac/ad5686.h:95 struct member 'channels' not
>   described in 'ad5686_chip_info'
>   Warning: drivers/iio/dac/ad5686.h:95 Excess struct member 'channel'
>   description in 'ad5686_chip_info'
> 
> Rename the entry to match the struct member.
> 
> Fixes: 0357e488b825 ("iio:dac:ad5686: Refactor the driver")
> Assisted-by: LLM
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Comment-only change, checked with scripts/kernel-doc -Wall.
> 
>  drivers/iio/dac/ad5686.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 482bc70515f7..4f2ac1e96643 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -85,7 +85,7 @@ struct ad5686_bus_ops {
>   * struct ad5686_chip_info - chip specific information
>   * @int_vref_mv:	the internal reference voltage
>   * @num_channels:	number of channels
> - * @channel:		channel specification
> + * @channels:		channel specification
>   * @regmap_type:	register map layout variant
>   */
>  struct ad5686_chip_info {
> -- 
> 2.53.0
> 
