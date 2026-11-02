Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793626196;
	b=VVNX0clonqBA/khhTGyQEfv3zMjLm9C8RfdppzXUjs66uS3+9qH2+wVraRUwmnbZxNx6
	 BifxrHBCqRuoFyVKrFw7Ep/fi0C7u4l3QdskdDaeIRBFtMUPUlI4vXrX2gWXcOrec2ygA
	 AYCAUaQOCVsyP+Nb+QRw3GBBvtntwoC+FEIs1evuAhIzxLTziSSyeFBXDj+4F1HJySGfQ
	 Ueuqs62EuAFvPEC4XGBHLALqUfdqfjgdy96Q7NbxkMCxhcl6TjnPf4xrfQy1Ph8JQlEAz
	 hMBKiCRHqa95Wm8sElhrum6+uPcjV0zOicnijwfSG6Nqqh8BXNIovRk8uebVwOUHzXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626196;
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
	bh=mVGkEPXgW7TveilOTUuRiT+FhAzVYBEkYgifM3slqKQ=;
	b=3+ETNdwGiEH59gbgVBO9q6Q4KxibTC1sum5WRE1lvP3npQjRmA5Ei7MhU8Hp/ZX03gwy
	 mHLR3aCNc5BuQnwCdHM1O6yDhhM55CHOwOxv25saJmf9rJPvWf1bNQkW+xgRBtR0trlhJ
	 cy3jnOJHlygsD2d20wwU0g3/yOogh8PMzL3qv8MAl7C9+klGVIhpof1FvhUBLpyK9xCCQ
	 q4Jm16O6haUXp9HOpNJ99R7mIx5UGvE7Y5GwJwBOlh/kTSrWiX7FbcHECHrd1d+Xah0IL
	 HdOnHCYlPXY/zuqmcthOprTCtBV2TqTAIGIU1cSPqQLA3rLQyaQl6y/IZ1kTzxhDXYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RMlcfZMH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.31
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011031.outbound.protection.outlook.com [52.103.12.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E10606A329;
	Mon,  2 Nov 2026 13:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09E10606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RMlcfZMH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVi7Al+5nEevQbpuktmLhDQoAI/HFForq3oFHD9Dy76sDT1hm4+w/0w6HGcugeOBxRTCmZ5I/wQ0XbptbMIAJFQirPMqCC86HYYJ432o66y9x6BhOnpIQPC+/yvlpC64mIP/IeEiL39sfaI8+ZcAMoxJzuGyWvypfsFU4HN89LGH++3EESPa4BRfMC+9dOfM8ZJbcF0iS8k9BpVNkKphQ82gwSCyJM7vWTu6Q/DXPI5U+MT5ru5cQriZ4bFY0MSQQQ/E5KJszaNq2BKDVal2ONQtO1bhzeIPELvJx/ALUE/ODS48VkA6NxhZTiAahFPrs5Qxx1hxHHLpO4pFYuNeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVGkEPXgW7TveilOTUuRiT+FhAzVYBEkYgifM3slqKQ=;
 b=cFgjxz0hIQgRnl7q8m1lw4rnG2c5pBGsSIfkl7CA9rtv0fP634PAbB3eILPfoSbX9uA2EUqG6/HrTm3tOHhyk9EVR65U8MNpiMMabm8YgXCSs1/ZrlNoPhpDuvorhdrbC4nfekDpkE9ovRLAHPhQZbLdWSc8Pb2pz0JRI/jJvxW7fozjT8oTC4iwtm76/0vvm+L5zVM6hhqVAkpf+80MDEunUnAAy74chI5L2UtH8VIjFvzlaxDDKDJMW8Kw6TjAn+G1pnm93aPtlQW3pNa1wK9PKVKRxLXqrcaxwC3KeujMv0HLusDN6A5PlwESVyMdT+2xiHVasFQPKsc80pcUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVGkEPXgW7TveilOTUuRiT+FhAzVYBEkYgifM3slqKQ=;
 b=RMlcfZMH4+8+7rA+4YKZo5mzvnfidAbYa6/qice7M78LwLT+26/3O7CnwkP4rP8T9TFSx3qqnHxIiuW3S5CzxidyW+DviBe8rzsoKb3ckL1GjCATu20NLOtFqMKF1RhIdUNK+BBDbbt36JdOKfRBwnDw9B/oGXr4shUorsON9jSR6ACTfbUp6jUsQhdkpaWUt5AyTxk+kWT2CXRCWlM3+XczAwmM51cybteZLgIfgtQXKBnFvsea4xDQOkcNjoEsGFn1yNVtC29SakDPeuOnHrNnZr83h/o5S129gYi/dJnYpexI96cw0gJY56B92CIG6I5b6hCl80OOisDm1w0vSA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:29:50 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:29:50 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: lkp@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Mon,  2 Nov 2026 07:29:38 -0600
Message-ID:
 <SN1PR12MB2528E19FDEA32D72F1070D75A56A2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <202611021049.CWQj3jvL-lkp@intel.com>
References: <202611021049.CWQj3jvL-lkp@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261102132938.221533-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b91a13-5d71-4fbf-f505-08df38e55cf1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|15080799012|24121999003|24021099003|22091999003|16041099003|8060799015|19110799012|4140399003|25010399006|260925184616899003|3412199025|440099028|26121999007|53005399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LntuOgoDQ7oF9FPrWgK2CIG5Bi43hlcAYbOoOJZlkbpdbfEK1xwT4DySCCxs?=
 =?us-ascii?Q?PbcNl/gQXR6KsHFrbWL2ovtyRlvJtNqgaPbJEC60+sXPC/o1lUAOxEGdCCA1?=
 =?us-ascii?Q?LgRlZs9To5z9Kp3+Kcq2S2z25nbSXd9l4+kp/Bq8Kp105BK/1bHLjaxMzUYU?=
 =?us-ascii?Q?ubLIP+tWzZAc/UrMlx6gKPZa+UCsXl3+BHZvctXogIYxIbfu4PyAtEminWRy?=
 =?us-ascii?Q?f1TdqqcE7eOIpqg35BpVh76dkOvzhvYoLldcL1zv0xGBxX5STK3tY0dG8Y4W?=
 =?us-ascii?Q?IWTMhu/7RuS0KIXG4/FIG1r4gn/FL+rz8UosyBKXgpi29JULjpMOe0qZt8ux?=
 =?us-ascii?Q?BiOCjvDbRhLs9VflqXK6A6u7FwmUDuaQ2C0hHCZuuaStcXAa/4i0AUzFEXYP?=
 =?us-ascii?Q?i6SVi2hOzrq39MhUus6IR1xk4L9TEsQ6eND+KyhVFAiSwIGoU2yRZTnShcEO?=
 =?us-ascii?Q?2cp9kZ9ANh10erLYCvu3UzXvkPjkwd8wEbofTQ6KBaw33vHApxsVQ4KYy8lQ?=
 =?us-ascii?Q?Q7c+2xepUsNb6sItXL0RNn7LuVqIkiQYeBiBN/GDHZo2dDRQFSwuYhKwC14/?=
 =?us-ascii?Q?SNh28WaMDhCNX1PV8wGAfcCCFS5uAcTo86RGDAipE7NsDxigOVE3DmJGGY2k?=
 =?us-ascii?Q?PNrjK1EnORJqNlejWI+XRQ2pXkFGB1jncD3HE0Xm/IH5/19D+MIwana7BmJH?=
 =?us-ascii?Q?DkodrDzxZdi1+YbOW1m7RpHTOkL1Uzw3Ny7OGHttORKBuzqlADsFEBglX5Bb?=
 =?us-ascii?Q?D+l8ZRULJiNySG+s2utdGdkIVEufmvO3+1mPp+bFwvMIHchINgritLhnibzb?=
 =?us-ascii?Q?qoIYsrlyIXKsPrrPCAUdfZqd5WxD3liTIzp9p69YDBWZi1KqqXlW6XeuUV1B?=
 =?us-ascii?Q?OFLnlZTYrwqrkfc+8GY4EdIAPFCxDWRGRVLXpK0cy6DnSz7sdYy55Y4nwQAf?=
 =?us-ascii?Q?o6ZbW38fBzEp9Ajtw8Ugzarow0iUqlY2G+L5UZ8IRdZo+8ZzF7Ykq2CQgKYO?=
 =?us-ascii?Q?3htO2x4E+7xFxegqysOQxfibJcpOXrNq65Kop8K0ddgc2KjZFXC2g0naoJ+N?=
 =?us-ascii?Q?cuXIDsL8FVdf55vIlqZQBNoYUxLmUXeQR6Tlr1PkQuH4A1SXWes=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+3ZMRyav3GYggzpcC5FQKO660U+DjiK7ZgFn3xBOOF/9ccsjXhM+lBLixS2m?=
 =?us-ascii?Q?XVmjPENXLgRl8DlvsxCu1fMbAu8RCkVObqz1Yd+W8evi/y/IurNarHUXNy/U?=
 =?us-ascii?Q?2YWXfPykZryiizAPI+SLwuUYHRW6FJPARlnuqliBxlUpZQnaZ0DJ2Qj+O+/e?=
 =?us-ascii?Q?S2ZtHbi6oosIqUCTWf4F2XJYOa/EJ08SH8gA7kxuy1HM6kmQ4qxnVMEWoJ3m?=
 =?us-ascii?Q?lGAf0UPKqs0g4vXtWqyXHT7rnuPhet17eFo7+PX6etyRWH24G0ECpPHKDwXo?=
 =?us-ascii?Q?9p+n0TjBwr1FwKnZxcODw09ee/KemoT/TgWsjc4JAJkouhigCvRoO2pfCvXn?=
 =?us-ascii?Q?s3cKG9mk6gRlI0BKvxZ+DLzB3EVce5j2qH7rPYsmhbxdFPHP1/1lRngPbxcL?=
 =?us-ascii?Q?N+HZRiIDW1TS5k/aO6EeewJssZufCorCCh+jJO4x3vB4kZ34CktSIZ1vxdzz?=
 =?us-ascii?Q?krUG+nLW+FhJrA086pICZu0urWUWbQ/WhTKMEQKiGfhQ18WBHY54zMK31OXm?=
 =?us-ascii?Q?1Gts18dwAlI+BCsYAl18uBhJfipRdTplt2rJdM/HDniHdO+p4wJWjskwNy3C?=
 =?us-ascii?Q?hhOQmvhImo2OXbuKuX94RaJ/Bi3NNcuI6YnDy/S6VWCrfEnr1r5U/qrf1Jj5?=
 =?us-ascii?Q?ChoK+dKv2ZXxGCRomsdbWSwRJXzr/R8cqMg6gTOKdHEXX25R6Jyoi74IdoAS?=
 =?us-ascii?Q?ATg3YbzFBEEj6dfJt4/iCm6tTQdemzvLMti53pBjQRrBnqNRkYSQEH7QWeMf?=
 =?us-ascii?Q?m2DIN2VpjrVpG0Zg3SxznqPS9MkHOgMo7FDbDgSFw67KBI2q71poxmyKAH+x?=
 =?us-ascii?Q?yQ23ENPG7p8S/V5ZfTtioxJF2EtIaE+52fk/shsGb3EW+fzQSsLi2ULQkVTm?=
 =?us-ascii?Q?ms1QILYOR9XWuaLsdQ6RXUFQfUS1kZ9AA+pO3GZZqVfik+lYCpWUzetNTagW?=
 =?us-ascii?Q?50V72PPmbilOSI8roVk2blkV83wxTPGPyZQ+paOphf7fu8O369hqtUOWsNsA?=
 =?us-ascii?Q?V7HZ/9gxux3Qy1M3IKP7bA2zJks8B3QKx3TONClX+lttj2TLAw1yn+2G+GM/?=
 =?us-ascii?Q?Nj7N4XUp16H0geeNL2G/3fbVcvszFa2z5E1UnF83FlftN/5ZYfID0jBpG05S?=
 =?us-ascii?Q?woWqYwzfkyEqh1BoVJmkmJNeNb4COuBErNrmAKc6ogKjQ+cvZW/ce42Xahyg?=
 =?us-ascii?Q?w2JSjJ8g4b2O5BUJ/TENAMJVH5XHTxiLG9bFUe/WhBaMHQphsjeJ2PimG4B5?=
 =?us-ascii?Q?hTIIlwkDA4VjpCwSk91qmh5BSwAicEhWJJ8OnZNF/ZePBUDP3aBIZ+FT4fbu?=
 =?us-ascii?Q?tum/eBAPQZWWipUwML00Vu7b+jI5GjpjH4q/MPP24zCrwL5mXJbD4WllryIs?=
 =?us-ascii?Q?aUB0XUor6yz/BIHmOQwplVkgrMMwpuZcsa60Jf4dhd2Y/RXEaA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b91a13-5d71-4fbf-f505-08df38e55cf1
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:29:50.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013

> >> ERROR: modpost: drivers/iio/cdc/fdc1004.ko: symbol '__udivdi3' undefined!
> >> ERROR: modpost: drivers/iio/cdc/fdc1004.ko: symbol '__divdi3' undefined!

math64.h to the rescue...
