Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CD48822C;
	Thu, 15 Oct 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053671; cv=fail; b=PVCmR1NoqhopnQDFYGPmRFwhDuZttPaOUMxSwTFoe9vZ9SMwwV3z5I1XxXBxgW25qhMo5yAu7Z5sGuYfG6fPzq9Ev80JxFJ1FwkU1Lqaaq6Ahz3tYvAjSjXlBsIvBglmLB+bLCgQzzZatarkLSkFyL7o7zeVjHCJ/kQDlbozJP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053671; c=relaxed/simple;
	bh=r4Ftnpid1teHQlLdcMgY+3DasTxMCCMuUWi3qIgyMCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RM95AeIQ/OX9R16q/fWlBsI5PJDTclFxZydeTy09jBKVu/ObwpaddnDLJoIddUxLj+riUyy7WEzcUm8w6lNSaQwTEiFzHV7pOI7r+vcMCY+Nr9LBDyY/U5l9WTx5UvCI1Wu6nAz5syd9mJv6Frjfn3asBueozFS3tjGFtTjRE7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Sks1JMrK; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nEi5hU5Q; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Sks1JMrK";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nEi5hU5Q"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F7skOo1109413;
	Thu, 15 Oct 2026 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=UFk/FTQXNoIg4ZShQNXVHpE7H11YSAelJwBdOJgRT1Q=; b=Sks1JMr
	Kt+0pYkiLX6ZtQN9sIva9uyBVUq+6JeCFyBMB8+nW3Xo/o4S8OPkU7zkx+YSgMhS
	tMsxSVOw44hMzp4vB7HaXJwhZWFnWMBorAzjxLE3xiD25tufAG063nKikptcC+R2
	EIXn6Ew8mUi3eNF2sQGYWuX2xfZObdOKVdbkqsSqsqNVlWMQU8vAVtxBhozd/P/6
	dD/nMLQni5oaB3hHwsiUbEeQQgD5IaHVGOoEjQJYk42I8BKOYDDHrx07BtWDIEEm
	oWK+BEbXgHdw/KSSz6CDIdG+01vGVVNrAZ+tPwe9waz/G0pIOZ5g8NILfIBPfYTg
	Fa724+n5m2R2jvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UFk/F
	TQXNoIg4ZShQNXVHpE7H11YSAelJwBdOJgRT1Q=; b=nEi5hU5QC+s6OaYRY2F02
	s4HPr0Vx7PkgDN6eSKLm+8GYOZW5LOklvKYhGXG1gucA8Xg7fQ91s853mUuzjVmP
	OHAXan5LaNLV3ixj8bMSFl4OzB1sNdRtcr5heDUT+RMYb3OQDn+lc9DjfOvKSyGi
	Kc3kAZVt0NaiyG0PvYTEPI93MpoVSAKQj/2cQCnnD/6Vlql0XEPx+rWZkdTxNxpN
	Xtt60NqkZKNiJP799alQkEnDI0CbNnlNcyyeMZoEMYpgSmImmQk80OLf8GR5vxrb
	uCp/TRViYJ0aWkNx7aOMFERSGvLvDqPddCqk9dydNNKM3vmeD/7iUymHRiiMElpZ
	A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ha0t3h5ph-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 04:41:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBzckQJMuyqMtu/+0yK6Dt18HMN2dlYlOD01NTvIxQ1QrI73zDJbjQhFe3RftbXFTMfX9qrpYoE+/IK+06R0GtRQOXaEjVE/6o/65mhY8ZkGSIrBwYCTS2tXiHLzodx/NH1Pl6xNduKcrLr2EbOUHOcE1WJ3hxl8MQYLhZEJBYOGV3lZBjaaM0IGu5cZjcasWT1TuRi6EXvvOcXm1/rdhttYEKTgVaagRfAoF9KMNUZfKUPb6cmo7bLNdAQd2Q56qF2yFJvpErRWzycq9DyTALZk0lmXswR+BkTs5p6z8CgpM6knWfolIASeTcTK5Y3D1Pj0AdZQpBJan4FFd7khig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFk/FTQXNoIg4ZShQNXVHpE7H11YSAelJwBdOJgRT1Q=;
 b=eP2FlfG65QIfPK7bEMcK+S2mpecQxs4/rL7yHSJZHZRWoUbuEoY70+uGClFLm95uSv3LsXuBxjfwiQaeKhjMGBc3XQbNsCyCqK9YrXRocBgLHgHJzztzF3IcSQ2bdns4qQo6tsx0A5qiBUzMAGEcXU4gC9mwrqJbVzrTqte6U3el1sMKZT84HwD52BkmkE/sgwgdNzcf6J2XOFhIDSHRzKkFSRCyAQE3TY2/TA2io0oaxc6/vYx+bmdtUHU0npUxtuRUDXRxoHFWRBv02bEoTBDhaYIVKrdFjdt4GRuOfwAVCr14BAJpaFsksnRlCP7hlZ7C/sGyNBiyR2Uruw/jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSM1PF470409B67.namprd03.prod.outlook.com (2603:10b6:f:fc02::54c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 08:40:59 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 08:40:59 +0000
Date: Thu, 15 Oct 2026 09:42:12 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: =?utf-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl345: update period cache after
 successful write
Message-ID: <atCQ5GkLUV53ahDl@nsa>
References: <CAF2O-sPmL=eyUD=EndsOpDnJr2FvpXxhF2RD5S-4-9OgfCRqkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2O-sPmL=eyUD=EndsOpDnJr2FvpXxhF2RD5S-4-9OgfCRqkg@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSM1PF470409B67:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b651e24-5528-4c9a-94b5-08df2a980947
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|10067099003|18002099003|260925021911599003|6133799003|260925022911599003|260925021311599003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 B/UTGH+DOySt3xrAzXz182qrIOYAK6YC8p0zpIKYcUzpE/3hbiXRZC1lAwxyT0Fbx9OYiCjP1TvrzbQM+MLZe0mRcqmEg/nReduw5SHwONOWdqT2goEu7AjSeuTpyGrhk42UBAjtChIJBCt7umX3+Wa1p4lA7XPtfn+lJgoDoubAD1ax0LQTbV5EXdSNiK7kaXEacIuxc8cU6a2aK8KSkxa+d4xX7ZLySJU2vQy5LvF2ww7r79ozQHphTeYPKHYT2Nc5ZrGiSIkCcpe5f3k5LrJK26QpdiJFTGj1IJnA2ZY1SqgnkyZlfxH776GZSY+pw0n5RU9WZLfWFGvKEs/jukNZGOqBGbyrnPOzqYyONgvrqD5DHcDtBGxJsQTtEaiB2/PIEWBzuo4YOqUjzKTsTi0ozc49HzDLYTn2Ub48eQnYfQD4cqEWKBdGFcqxv+/aQD+o+H0hxGVj/Z1qJykbR5MTIl1ig6j5sPOdNwA8Z8TFPkHdD4HX15w67xFNI7WzZ37uSXBsu6bUdYp3YCYQuG2JegWin3sGYCdi7b9nfPtkGpFo1vOqdSU4Tl0Odr4GJoXY2JPBUboOTlblK/z5bev/Z8S+Kg/R99kbqSmGDaKGIiiGGF+f643FjRMz5e2SO568GtPH6RE+XbimMNEO9HcxJXtizoDcRIVUZOutUwY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(10067099003)(18002099003)(260925021911599003)(6133799003)(260925022911599003)(260925021311599003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WVVSQnA3UEZkMUJoT3RvMElEckN1Q05aMjhRYzk1SS90RVNISHFDTlFuSnpV?=
 =?utf-8?B?N3V0SFgrb3FIYkJYN09kTzYwaDRuaWg0L0pFN2xEdkhnTDBWYjd3d21rY1Nw?=
 =?utf-8?B?ZFErcm5xNWN0VTM5S1lienZoUk5TY3dPMHBxR1JndVJsTVR5QXErNXdCL2l5?=
 =?utf-8?B?M1hYZndxMEJPaW9HK25VS0MrMndaRGxFZnhrd29TQ2xwdGdsNGdPWXBNWWdk?=
 =?utf-8?B?aUY4M1BpZTgyNUZBUC93K3ZtNXd4M2gzN1hvMW1CSjF6Nzc3cXIyOHg3dG1z?=
 =?utf-8?B?Z2p6M3ZrV0N4N3ZsTG1IS3ZnYVFwdzVzY1pLNUJXL2VvTFB4ZXB4VUdWdmRF?=
 =?utf-8?B?TUxQK3p2TzQva1FDanBsa21idTUyRW9aWEhkc2R5VjV1QTJDQzFmR3ZOUEpw?=
 =?utf-8?B?cmQzazhNTlk3d2tvRHRKREV1ZW4yOVZwdEh1UWl6Ym0wUW9NbDQ1b2dTS3Rs?=
 =?utf-8?B?aEVLaW1iNDVCemVTU0pncGhhdnV3ay9tMk5qQW1SVHdzQmxHZ1VORXc3b1Ew?=
 =?utf-8?B?NFRJZlQxdjF2Wno4VFNXWmY2aXlpZmFEWXhjWmNmVHFQS3Y2bFBBTSt4SFpF?=
 =?utf-8?B?anliK2lzODZJU2FPOStORDJNMnVzdGQ3NmF3akNCZktlb0VSbE1XTE84cU0v?=
 =?utf-8?B?ZVhDR1M3Z0NGbEFpeDVOOVB1QjBEZ0lRSy9lUk5QSTR5dUJqTHlHMDVkTkNu?=
 =?utf-8?B?SHFsbzhnVksyN1M1bStYYjhSaFVTMnhqeVVsY01uRWdJdnhrdHFSd0M0bVpH?=
 =?utf-8?B?N0lhdmhIOTM5SmgrQ0xPNmM0SC8yTjFBbmorU1laYVVTSXZKYTFEd25BeEEr?=
 =?utf-8?B?d2ltQyt0Q20yL2VYT0xHMS9ZNFRyQWUvdjcrV0lNSHJ4T1FuZXozRGNTZUVQ?=
 =?utf-8?B?b0gxUDZmRnBKVnA0MDlGNFI2RkordmxpcmhpL3Z2T3JsQnBldWVqby9GWDdy?=
 =?utf-8?B?bDVNejEyNWplNlAvNWxqNit3QmJINU5LckFsVnNNL0hoNzhjSVdZVVQ4N2J2?=
 =?utf-8?B?MHIzSmJQb1RhYXNOUjhKM29VRklhdHJTSGpibHF5TkliWlFFUTNKSjNwZVZ6?=
 =?utf-8?B?WU5nNUtVTTVJNEF1SWg3STV0T0pWMEpuK0lkZ1F3NVhNaFlDSDRFdjVWTFV4?=
 =?utf-8?B?a1JmZkR1NUszUVorSHJ5S3dHeWxrWDUyNFo3RVB4ajNxa3V2UTh6UEd0dzlK?=
 =?utf-8?B?QnVWWThNYk5GbnhGdFQ5R1RzcjVVUi9ueldJRmtHYkpsSjRDQXJmOFRKYnpQ?=
 =?utf-8?B?d0czWkZ5Y0dvWW1VOHQxNmhGSFZPdXYzSVUwUmg3Ry9kalE2TzFjbi8wRFE3?=
 =?utf-8?B?eVlGUk91Mm94RFA2L2x0Y1lyNUNISkcybWkxMVVGaU5ET0pYMDlxb3hiMjVP?=
 =?utf-8?B?djBzazVBd1lNNzJOSnEzUWxhcE5tbXFLd0wzWFZjbTZhcHo3MHVRS1VpOXJL?=
 =?utf-8?B?dHAvaDlLVkpuWG8wL2o4MlVNTjhOQnpqODVyS0hPUmVhUVdScGM3REM0OS9h?=
 =?utf-8?B?MUwydStqTFFQWGo4QXdtYnRzRUxXWmdpVHZpUTRabjg4YjNCYTZpaXZvS3dU?=
 =?utf-8?B?NUJxOGtKSjdwUStobWJJRXdUbFhIeW1XaVUzaTBCeFQ4enlDd0puL0txQzhl?=
 =?utf-8?B?TWMwaWcrSTlCN2NZaU81NVBCZkpHWk1zSzNFRjk3WmliVll0VkJxdS9GMllw?=
 =?utf-8?B?UWx2UzhWNU95ZVU0eUIvWVZ3RTF4K2k5dDJ5UG42R1pnbTNDSWNYNlZlc3NX?=
 =?utf-8?B?NEl6Yk1NMDdXZE1SVjMvamNRY2ZFSkE3VEFoYTlsQThncFZJOElHN0FPR3F2?=
 =?utf-8?B?SXNHVW8ybGhuNi8zbzhvQjRoTFc3REJSZUhHM2wvdG43b3Y2QnpOMnF0MnN4?=
 =?utf-8?B?cm9HVmN1aWJBSENWY3FaaTVBdzI4N1hmZGEybFlxZlZsMWtMekluRThQRjdD?=
 =?utf-8?B?UDFVcys5b004OUcvM3J3bDFCb2lDOXYrbDNNeGVVM3lDRnRjWThJWDRtdCtQ?=
 =?utf-8?B?cG5FcXUydnVOajEvRG11cm1HakxtQnRieUhpc1ZmNk1HWmVhQ0dVL091KzF3?=
 =?utf-8?B?VEVuYjZWUkpURUp0WkRQb1B6T09vZlRHVXFkZXJwTGdwNm5rSEVOejZiUk1U?=
 =?utf-8?B?bDZlcTRXOGZ6VVdoRzAwOGxZR2VFNE5jRGJHM1JkaVFmM2xYcU4xRlBkM0lY?=
 =?utf-8?B?MmdFbVF3WkZIQTkyY0k0K1k3OGQxL1NraEVpSVpmTjFiMGVEYnZaVVFqeXQz?=
 =?utf-8?B?L0NOREZveXlqTnZKR0l5L2NIN3RTb1plZ1R2WEdmSUpDellkVnd4RWY1QXRL?=
 =?utf-8?B?ak8vbnNrOUNCdDlBZlBPQVVXenpaN0JGWnUzb3lNa3BWWUF2VUgwdz09?=
X-Exchange-RoutingPolicyChecked:
	sssoTjoxj7hTUQ662yBBnbmvG+HVrnZaC+8XZbPOZbpr+LCBA80dnJCBTVjidVme7Zx9OG2iYCfU3v9ov6GVFQP5VMtjL73/+P+BWBNZShu8jYwtVbvqnW20yW4RHL7CLbSVYQuvGbsaUyWui1ALxT2CJmfVpJ0lObfTi78Kt187uUguEPq7bp7dSylVpIYej4wWEzyKpUnixcpIQhcMEGYgzGdd5nc/ot9BWDtyT8Lx0PSbh5UzPK4oF40ki8JKR1XfFkuIUKu9jZ+XJjyff1fAbt/wp2viz/flkM0XrRjhJXcxGA4YrFatugFrSrp1Prlbs12ehgv8gAkSZIg3vQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b651e24-5528-4c9a-94b5-08df2a980947
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:40:59.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlAuSHXx2IBUcPJL0+e6ZYB487r1XKLQ4d7FgCNK4Qxw2Zq1jbd21L75L99VDQQN5Jnj0pzRTtoYm8sPVA5ZBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF470409B67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfXxYseTdTCaUMH
 kVf+CQ5VXUw/6g1rd6LLWlpnhubLq5Q5ry4kjEadPF4pyFYRHH/9Jy0hFNyZO1YSR4oFlhSwhv9
 s4UeAx2r1z9HwevYZmnFeUij/a3Hl4sVCyHspO0UYGVMCbFja/qm91CF/JYdqcovsJwGNolYStT
 k05wcqN9x0iU+r9AznW2ao+JoOU0cAWkBYk8L+gvk72c6s8K9IXJHLKlTW3I6FhDvJ1D3WMfm+B
 JV0gDGLBrboAd6BZMbQYkoY36YYsYUVut/HLIAY8JCnO0X3fXuA/NT+ZsrIK2gcTPfdkWoskOtR
 Vlp64cU3/hTqXQEXFNTON8puh7iYtFeje3Oni/jWeOToNkzAq/sQu/3CU1KfrU9iXsOPGFk4mRQ
 zs7+AuilVApY/ANlO4YEWofSQBVoQ1oDzxLjNL1EY/9dD+qISvd5lIvrzLLXaJSooarnjzrBMWC
 4uMdhT3ftRt9Q0PPWKw==
X-Proofpoint-GUID: vT-R1QAbjs7nutBAL0cLWPwdorSkkJtZ
X-Authority-Analysis: v=2.4 cv=S7RMU4sP c=1 sm=1 tr=0 ts=6ad0919d cx=c_pps
 a=EPZJxM4MYJNUcCtligPUUQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=pGLkceISAAAA:8 a=H6dSg_vpv02sZXePQ08A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vT-R1QAbjs7nutBAL0cLWPwdorSkkJtZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX4h60PIYl/wmj
 LUhiTJVZxiXTU8lzuzs5EqTPZGkE6dPEuOp/ZnMzy+Gpcp4N2j9c8p8ZJfaxGNeSS/FgIFhTvWg
 +7x1iAl98r5nGIndTskVm4o535SEDv7bE/zosM/RXZA4DXWPUGke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150034

On Sun, Oct 11, 2026 at 06:18:11AM -0400, 赵文强 wrote:
> The ADXL345 event-period read path returns st->inact_time_ms. The setters
> for inactivity, free-fall and the ODR-derived default currently update
> this cache before writing TIME_INACT or TIME_FF. If the regmap write
> fails, the sysfs write reports an error but a subsequent read returns
> the requested period even though it was not programmed.
> 
> Update the cached period only after the corresponding regmap write
> succeeds.
> 
> Fixes: 8a1536cc4a1c ("iio: accel: adxl345: add inactivity feature")
> Fixes: f6f22950d925 ("iio: accel: adxl345: extend inactivity time for
> less than 1s")

No line break

> Assisted-by: LLM
> Signed-off-by: 赵文强 <berringtoni36@gmail.com>

Not sure about the above non rendered characters on the name... Would
guess it's not ok.

> ---
> Validation:
> - A host harness extracted the production setter and period-read helpers
>   and injected -EIO at regmap_write(). The baseline failed all three
>   failure cases (3/6 passed); the patch passed all six cases, including
>   successful writes.
> - Compiled the full source to an x86_64 object with Apple clang 17 and
>   Debian Linux 6.1 headers plus upstream IIO/regmap headers and a cleanup
>   compatibility shim. This checks syntax and types with a mixed header
>   set; it is not a full current-tree Kbuild/modpost or target-board build.
> - No in-kernel KUnit or hardware test was performed.
> 
> AI assistance: Codex drafted the fix, changelog and fault-injection
> harness for a contribution related to an ADXL345 SPI/IIO project.

Seems like a lot of trouble for a simple fix :). The change makes sense but
incomplete. Looks to me that the driver is completely not safe in terms
of multiple userspace callers. Arguably a different issue though but
seems that a mutex is definitely needed.

- Nuno Sá

> 
>  drivers/iio/accel/adxl345_core.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 6c9080d..cd58304 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -391,30 +391,47 @@ static int adxl345_set_default_time(struct
> adxl345_state *st)
>  	odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
>  	val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
>  		    min_boundary, max_boundary);
> -	st->inact_time_ms = MILLI * val;
> 
>  	/* Inactivity time in s */
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	if (ret)
> +		return ret;
> +
> +	st->inact_time_ms = MILLI * val;
> +
> +	return 0;
>  }
> 
>  static int adxl345_set_inactivity_time(struct adxl345_state *st, u32 val_int)
>  {
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> +	if (ret)
> +		return ret;
> +
>  	st->inact_time_ms = MILLI * val_int;
> 
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> +	return 0;
>  }
> 
>  static int adxl345_set_freefall_time(struct adxl345_state *st, u32 val_fract)
>  {
> +	int ret;
> +
>  	/*
>  	 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
>  	 *
>  	 * Recommended values between 100ms and 350ms (0x14 to 0x46)
>  	 */
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> +			   DIV_ROUND_CLOSEST(val_fract, 5));
> +	if (ret)
> +		return ret;
> +
>  	st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
> 
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> -			    DIV_ROUND_CLOSEST(val_fract, 5));
> +	return 0;
>  }
> 
>  /**
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
> -- 
> 2.50.1 (Apple Git-155)
