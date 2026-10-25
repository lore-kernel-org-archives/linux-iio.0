Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792964154;
	b=4IMhseh0OocQtqaFygASyqzY9OHXXj6HrM7idSBDmtQOXZNyR/fWadf4D+7XfOt2ckIw
	 Nf/AJdAqL4SdqF9eLIyPdTDVUhUj+nqQo6S5IO7FR55m/K66PhOn86biqEo7sq7opMuB9
	 BqWk/SDuyNOodA9bOHh2uhLLpXMXFAqTR6XQhyCEkPGLEe0LS4VIGMcAwToKSPPn/YH2S
	 wwgw1ZB0kA4goFGZdrufahcPjQVAJULW/mgpyw6V4ltQD5kNmSoJWYvk5Eq468xPV1DWl
	 wmIkQOV7UCZjeZE5GxJD7eW2M8rqmYucJFmuGDrDDYVomNl/6bS3djOks1vhWQivglw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964154;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tu5C6ICjThLNxpGp2fvFHElxFVE5D3XEJqCECz6gfv8=;
	b=Wbd7kSnMjO5cyIWsTMEEMI9ufYxKMHwd+Vsq3yt+eWf6gpLemjRyFB54UzaqbfPkekx7
	 zf9MLGjCc1UoaRuOMprTZRFBmgGuaxHzUHWGrrNNr20Rx3ZK+ZcpRAolE/0atuG57I9p/
	 ZZgyII6XVc2X2X9JYBR6q0dNMk3pe7r3mGlG/4rAS4xii4WwQ2EYg55ncznB+wrgeRLo8
	 9oSuIa8f/TdWutlHuH50c6oRoCKTmVsr8mAGhPjiqISqKFh3YdW3kYoQvKw23RqN6+3va
	 Q+mkCffxSsydi19sL8pPDBUYTBusR//0D1JvE03RTY8c+j3QyfHQlRYf2VsrCtJ4+rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=iEibY0wS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.3
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010003.outbound.protection.outlook.com [52.103.12.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF4606A31A;
	Sun, 25 Oct 2026 21:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DCF4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=iEibY0wS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLIRq82BPqEoLxha8a3ea6+TRlka5uEZaDFp2mxkg+wft0ONYR+A0VUEcJAhCqDMUNN6EfQ1Tj6861OVrCUd0aLSR9l3ezLEqm1rCbZZbTLPSdi76mdXDUVi36nnQG8DM7+I6KSS2ZGm+4pDrGa+Bsh970FWj4+IssAaVfUZBLA/ThS2WSA7LZUx83fO2mnBVQaUQrU9scNMjqXJgBzIz0mqMafzMgLit5na9bS0YMABxI3TfqBL8TlWQf17QbIJeHELWxoGvgXxCHCsURvdGqElxBXRkauoi6d+4IW1jsWkEykP3Ljsxk5SNkdatzSECTOrQO35yp46zf280dJnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu5C6ICjThLNxpGp2fvFHElxFVE5D3XEJqCECz6gfv8=;
 b=j0kfSEXh2oWQki7iWQ8wbbQy/p9a0ExIZSofHROy5fTV6SeLMVA3ZMEwwqJrUsR0KbNcOeg5rv+A3ZqIlDT2aI9j7z3YC17WxTkSHcEAw/G//fTfdiDW7iVNpKGrDoCixI4BIavkTc8FYUHsShZ7hw6saOio8ISML5C4AZ7fJqRzEAHwWjDyqz4Y189jvkAtG1VAQ6UYlWyF1jjAF11rO9Oa502uZTbL1D37tURSh1O+GJb3pQ7UQTNIsUf+9118sz6OfhubO5S8rj9m7myCSVhAIQ2c/lLNGcRLn8uQDo7tQsiUZmslde5yz/AXEFeeEin7g260lqA6NBSENjB01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu5C6ICjThLNxpGp2fvFHElxFVE5D3XEJqCECz6gfv8=;
 b=iEibY0wSn2hMcdaCHyx5HoR8WU34/OrxYfUhEAHgMMurBIhnVFGIhp46xv9zTDN49bAoBkr23OHRnsnAolMqg9VezSzqk/+hlkG2+COr9iBLga5YmmJHrYx15J87e50xyFFAxcgqzKDmW6U42cMbcu38/42qv69i3ya8DAzd2Hl1SKV/VKtCYOvX+15EA0QsK8MKghDUJhMyCXXcCKfTfJLY1AE6u67YMVmCEEmst9iJjK3+qOAOZfYk28D2IW8lNYd58yjnB9fFcC1J0Hs+xf9PNmcsSfW9Xir/QVdTJuhSePFDgcLDQE52nw/4o/3ELp9FHjLfhnqL4neniMSLAA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 21:35:50 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 21:35:49 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun, 25 Oct 2026 16:35:36 -0500
Message-ID:
 <SN1PR12MB2528B7C10FBE90A0B31BE375A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at5qzj89R8W4K5Zc@ashevche-desk.local>
References: <at5qzj89R8W4K5Zc@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:610:57::12) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025213536.51941-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b11e14-03cb-472f-378c-08df32dfef9d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|19110799012|8060799015|23021999003|15080799012|22091999003|8022599003|24121999003|24021099003|260925184616899003|3412199025|440099028|3071699003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7iQomKGjsh7Ehne6Jx7dneM7bhx3wxb1PDNYff2W+b4D/XcKu5Pwayv3oMP?=
 =?us-ascii?Q?eeYvc6b7jgJ0nHCCx7w6TUD0YuOQ32QEQNqznJnvx/jWChW+WQmJ1DpPdzmW?=
 =?us-ascii?Q?0pku5sGB3Siqb9ycErOOaDuz2Dgzje82xppLOcVoZvsy0fPd6eSj3Uc3TwZ4?=
 =?us-ascii?Q?fNRgrrGXOo5uHMyUHdLNYZUOCz2VJnNz7mQpbChJnG8RRn6n/DKoV2G0Y5Dj?=
 =?us-ascii?Q?uZkhZPe4pKeoEwmApADIq9LcxPlY7uj3lKQ2E5ibcpKInREFXcbWj1EPFJME?=
 =?us-ascii?Q?JHRez4byk2wcXfF8H9Cy8jz3TSOtlyaHTMqfXdf5QZwShNrxFtQNcFrNvUTa?=
 =?us-ascii?Q?37wsvxpSPImATNRg5in6h5NnCSH+CueRgByQxA/Jd2lTGv+1KVLFvEQpMgZf?=
 =?us-ascii?Q?pf3i91LMzQysL2OLj82/fpOtoHz8plRhRb7YYwyDvjyCHWO+ktnaqGgHnOqc?=
 =?us-ascii?Q?zUNnLdR70qt2Q0dcJv41I4iSJwFiVZXcSDqzoJqAiJBVZwVP1LDHcVgddG6M?=
 =?us-ascii?Q?+U3u97CP5wpy+9tni+UVkWTW3JnVtGjYNCHRjZSk26+z96UCJIzq3GTXvQMo?=
 =?us-ascii?Q?pfU/NX5ZNv1BsHL8DmEFCMD3/OtoPzem1xRYSr40ZxFVh8WIODTMfqQ+sKny?=
 =?us-ascii?Q?fT2jh2WCHoBZBBiZNYvouSLYhorWuRcA1RbpAjQY2jqd4xevHN9tcSm2/oSe?=
 =?us-ascii?Q?BsMzi+JtxbUbjBTRr4bga6djWSud2RyDsZIk2RSpKNdrjk3FuLgqpBMOzIGR?=
 =?us-ascii?Q?vjScn/UrugtgUjqbLinD0e6VmFXPP2iSmOw9/3jn9MdfxycgIN5eQxKCCHrv?=
 =?us-ascii?Q?xD25ONcJjYPHmRwavVQOdshdL+o+vt99FVH9j+vZwFz+rLts2nzGxRsdf54p?=
 =?us-ascii?Q?CeoGNC7ovo1H6R5v8gjNj8Xqgdy16L8d8H0TQ+0i9zKABNUd1LlqVj/loQT6?=
 =?us-ascii?Q?XqFBkT1Fsz/Pzy8BAreyoCG1WhaAP3kFFBpJqo8uvI8p5tRNyyT5cIZ77P3o?=
 =?us-ascii?Q?6xLIf8YAFCOxbmN2LS7Lm0I4DQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RCk2pvjnDKFDeeZgf8WGz9BegEtkOlyXt0GGv+GdDsb1zibHz+eT5hpZMfkB?=
 =?us-ascii?Q?DowzaG3hhAwYrWRCB/74N7NG2z17wlCbZXn+2Z99KDLYl5dzXffyJVzahLli?=
 =?us-ascii?Q?OnIdaPaY8I8UUApGcuw9gmVVS/S5ddZLN2XOAF8F9M63rorzcjd4B6aIWbql?=
 =?us-ascii?Q?slZrDA+BbJWV/gJtNJLon1Ges94r+vWWNlyiziyrGYc+hIQ0PwQZETOS15mK?=
 =?us-ascii?Q?+kRU8rrhvXdThDQfNmC/mauJXdfru73YuYMEw1JHBFHBOgFNJ+gcnLjXFJwS?=
 =?us-ascii?Q?gQljGJIeAf7l7rtSQQQD3st8zCXH1vr4RZzZJeAnNLA21acS9ECHyxrRhk0I?=
 =?us-ascii?Q?0gC0uN1JIucHvEFW/WPbzliaw1JRv96ickl257ysUTCXSXQPQaIg+pXJ3Qug?=
 =?us-ascii?Q?TbKNM7rElAmWjTl+usAUZW18Lq9Hx0zHn9wpncS80m0bn6YyM0yQM97zUHWj?=
 =?us-ascii?Q?o7+UcnSnPvzBm4vSZVwoMT+ASUU3gYJQa3FP3ZnPDSd7gtYE3CUMZSXya4Zy?=
 =?us-ascii?Q?0qpHKKMV6DJ4Cl2Gu5n+PdaP47BcmM7MbDX/Z/V9qzEt+hzNWsFT6o0kpS5r?=
 =?us-ascii?Q?2fVUShMqWtZO6lX453s3vUfv8D201J0SCNgwOJBXdz44Q4Kg6QRxmYwpYRoj?=
 =?us-ascii?Q?qnBGowQTZhTGoxaphPcNwNyhhJJiG6KXGU9X9RA2pPwBOWcvXuJ5GDKcohm3?=
 =?us-ascii?Q?2FYLJRsulu4O8J1myDNxu4kFeeFEJPgxyl6tKk/OAaexJthNrlKTLQPuHX1a?=
 =?us-ascii?Q?Nhn2XqOtgKQmviJ/o2/b5ktsSKfMCNpvzRV8OmBrq5RmFXy5WZloT0oBvBkM?=
 =?us-ascii?Q?KlRIDykpqL/zV8te0DjdoOLuXhCUYy5IjGqQDykP+8uX5PGcqUiJMnoG09lB?=
 =?us-ascii?Q?RoDkkfgN3Rf6CgIy9/cb6lY59eiegTCG8UZAmaE9sv3pDrWzEDnt1rJ09/Ie?=
 =?us-ascii?Q?7Yl0I4yNmTZjeGlyp124UaR4tEtNBbnPlcHXiOqkzgX02HTp0biyqQkDETmQ?=
 =?us-ascii?Q?aBAOO/8OXKABjJx6lQ1tOZv8iFV2jhZRYLLW5wG0Ob/GobNgThICBJryuvvF?=
 =?us-ascii?Q?otPgbmoB5BI8w8lmLGl16i7Y3jOYam/LzpSu/yY0vyHowHFVF4kR03mk60SP?=
 =?us-ascii?Q?92jmf3MmQcW/y+jeYX1YW32CmkD73MhR6Rt3//kRMO1FjuUu9jXb/TmZKavY?=
 =?us-ascii?Q?JHHG9RwybYSjmj63hA8p/ACo8Y4LXT0L/HlltTFdvDRk348+oM080t4BC6bd?=
 =?us-ascii?Q?5eu4P54Ts0JXYM9lkob34sJpdX+hyI6x/LOCTBPbdEYxZl0TJY8aEnS+cGHU?=
 =?us-ascii?Q?t+8NyfC6AqJxlYbag+CuDEeu3Bi6nzbv+mP57vL84cKUEx4zEBqJROFj5r/e?=
 =?us-ascii?Q?UBwgvhD7IX1jfexqF3K0IYuC7k+fFpSr/fguGQChli0rS0vN0w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b11e14-03cb-472f-378c-08df32dfef9d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 21:35:49.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

> > Changes in v2:
> > - Patch 1
> >   - Added tests
> 
> >   - Added a fix in iio_format_value
> 
> If it's about abs(), it should go  in a separate patch.

This is about both abs() and working around overflow when
computing 10^scale. To be clear, neither of these were problems before,
they're directly caused by the new units. You're saying they should still
go in a separate patch?
