Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792909171;
	b=up5iu0wwH0u9Ouu27luSc7VN1iNNo+a/JAGFVkWXeBibg7SsDT4qAbyxPYzeTjbRcjh7
	 c0VPOU31iHCe3xi+iScCgpthl5x3IDLwxcwwGTHEKZZL8p4orz0e2oy9joBRqZp1KgLNv
	 M4Lo4MvnHgq4y9fo3HWbRDIxj9b9Rs507U+CBlgoyMeWi8rF8XFqkHPQsPfapvydd2rWW
	 cPFgZNOodGS/22fp8YfhUNN7mvUsKlhNJ7Lnr0/3zvxOk9N+YF5G1xWASUKbBfTU5j62H
	 sKJH0+2bmyUIIF8rWjrTAl1KI8Jnb/6w/pAOWHN0E1zOMbUFMaL4DVsr1a7orGlIwYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792909171;
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
	bh=1B6Nyj9IYRYhdM+NiBICBYJ35cw7vaf6C+k5Xqh7TR4=;
	b=fGt6kn4Yz12kWUFaN7bcNXGMD9o4dEBx6clyxqh6bVKW60HjHeA7BQ5t87XhgRFsYGlt
	 0m3fMS/Hhj1CW6BS9veQ9HXPcm1o6EYY/8TFUhuf/oj37hIThbPYaEhKypNzDDL4vpGe8
	 +hIQl66l5e3lZp/WDV+9Z+nLEXp8yQcS26CVM2hu6tgeDc6/ZRdBUDbcU7nXwQt6iIVTc
	 yylgN92T3NBp7UK+0wQ0T/mb7SZu3WzfS4Hd2QckjfYQbAA68FZyDCGUcHc4rxAKWLxpD
	 esmb6GDTa0o83t9YYze37jBLDQgR9oTcXJi3jagyiIruBC7pqT+FG9vMBmOxRwswC6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pebC96Hm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.90
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011090.outbound.protection.outlook.com [52.103.23.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1B606A31A;
	Sun, 25 Oct 2026 06:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A1B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pebC96Hm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1y8osvXM1QZbv+C/Cr1MHdHuuntJf1y8RDUJ/uDkZ+iu1mczbc0x7+2RaU5JwKMYup4lhQjIRpNATSGAv9iuL60+crmenC2Zl1OOWfDrYNTO/+KOn+NClS2M9Go3VxDGsa0EAbXNqS5tnUdOol6gF12HSAvv1h53Qy6tnZYQlRceqblO6I2EunZ2GzZW7ZOKuRbQIST6QatudRpdDHS05bAISxy/9hR45sn0QJwJt3Qw4DS7Y/tCc6jfdZzkGrfTPikbS0Ae8mLKBPscCIeJWzQ1t/JQxuMaI4o2Q+sEJTn7YmMyb8sS0YecIJxEi/VbdC9WdbaD5QVYrUEfP4USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B6Nyj9IYRYhdM+NiBICBYJ35cw7vaf6C+k5Xqh7TR4=;
 b=sdNHEPcPx5fhYVHLNT2LiyYL6hAx6wL/Sz7KHEJ6FHt3HpBAifllzQTVDgSA/GLDj1llcOPyuEz2ox0T+e1XPZQG3eLsJSqA6CU07Jyt5MeBL0MZIqYIhI+ZPun1cWAfT0Jm85OtkmdetOTL30fLqi2FglGUvDw5iJqcTNj1JWwbb5exqQUF2upU2ciAGn2YTChqbxCfBcrh2hdDWTR8dv6wPz/Kib3d/op5Ai5y60nvm8v6GT+bWow3UzkJLeoSDuSVsHOko6yU2gZI+OlXPHreHQgWLSjSz8iUsPKGiGGaooLUjb2ZGugkaQxapTqodbTqogLkMPE6BVlPlP3gyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B6Nyj9IYRYhdM+NiBICBYJ35cw7vaf6C+k5Xqh7TR4=;
 b=pebC96HmtnMhmKGCRPOnpGiTDs0mlerkCYSfNRlw16ND5I4hgj1756OL3sqzyn1PeY7oMi19rJ+qaqyFY+UKpCDCe0gMjW/cCiOPMsRPKryZMbrDfeuKCvsPnshBf4UnuIhqXG3psWfAdpRwxBPl6Ao8cMO8/mhbylYFb3M+jmMIUxaFwBeezoFjRrCFLzPBJSsoYFQErsDzzGcw/vdLKSPEreUY49hwB2HyIH5MFS5KyBixkktSWXC0gdHE9uMM2YLT5hc6+L03zs8UT61iSWnYGlmAJ2fb6R+OTaK+iPX5MYXgKZluDM2kRhBiURZ8d9sTDulUkeLPbvI+1VuI7g==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sun, 25 Oct
 2026 06:19:28 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 06:19:27 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	"David Lechner" <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun, 25 Oct 2026 01:19:16 -0500
Message-ID:
 <SN1PR12MB2528D2A518D3FE8D08772798A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024032844.0d6210d9@jic23-hlaptop>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025061918.39030-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe53cfb-5b41-48db-5157-08df325febf2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|24021099003|51005399006|23021999003|24121999003|22091999003|25010399006|19110799012|8060799015|260925184616899003|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EzVvmnwYTHVKJ08TbpmZLHmJskRki5KOWO2SwmyQcZukHp3mZyKNEj+Af4i3?=
 =?us-ascii?Q?HPeI+MOoTMNMHoMWKSov5X4l9Ac7+foiVbJD6chQqaxucdUVhbweZ0oZ3pFK?=
 =?us-ascii?Q?qnH+hDbTO40ZzLBY9wSkzka6fOo+uNFPKxyPZ3CQ9aTGfuj4pK7JEG5n+3HZ?=
 =?us-ascii?Q?nONPzm5MxKsEg2hWlJwBWIOM701QRF/dNJeZVFYr8ktAkzHJdmaJH2cE6sxZ?=
 =?us-ascii?Q?fGepkTCX4NDuKXTzz/khsYzG3ZzIaj+vPg5M+9xLW6SHMuesUu544jXocGK3?=
 =?us-ascii?Q?a9uW5AYYFpl8z17Brejk23gpu4KafzzVOT2vvMDtX7q+Ay9AA+2wnH8kC+e5?=
 =?us-ascii?Q?g3TSUwFQbdTnOxEJGaVo5rJLJHvZoZ9UtQqgqfTb2KPGYHWN+T/qMFHgbG/5?=
 =?us-ascii?Q?Au6W5zIqh/unrTAZv5stvOjMDrkPZssrc+5Pfa/gPYvzAMlygZ+v8yKIFy4+?=
 =?us-ascii?Q?QSC2EMiNKuj5RbSPbw5jlimGTB27bW7snX3zPRGpWm0sYYooFx4E/Ag6kCwd?=
 =?us-ascii?Q?rYRFlG0uMlNLrMXiDL36ZiYli6lwuXxdTeB05X36d1fioVBlcMDGgmwnb22v?=
 =?us-ascii?Q?Rxt3chiK+CKGBqIOA+MOozpo+pFohRJZVVUM2IhEkAGbha5+6N6c5UN6r8qv?=
 =?us-ascii?Q?3vITJrl8fOSQIq7FfnEpI7GjO6CwsmNbuaiKhDwCUKad0oPnhTbw4hn8QyiU?=
 =?us-ascii?Q?y/X/qR2MwdTEb+3ddZS+NfzOsDe2omqcYilX29xhUZAo3RezzTn41eI3/AWf?=
 =?us-ascii?Q?l1clj6XZXjRFJvd0txdDHKmOAzA3yBF3FmipnXoogDOm0w1GleRiNNXK+zSG?=
 =?us-ascii?Q?U0F/OzrLbc7mJQlfnyHjyk+yZ1k1zrTzhI4Tpom4gvyjWLEcqciOY5aVOO8+?=
 =?us-ascii?Q?6o6lOnEcBowRNa9F7U04XpfiI2rUe9LCg6d5qE1tBf8qPhFxHTinfHZg2H9d?=
 =?us-ascii?Q?WmBhY4Cngnfzv/PkKjYh5gzKCix3QIuOTXtrBvPdJaTz5QqV7OvCl75Tg2d3?=
 =?us-ascii?Q?yyzcxx1MmcBzJ0N5FJxl1ornNA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0VFntwliykwyS0VOvOXIWOiyY2NzASjWX/6IGxwFHWHo2nsfOfCi4RhowUZ?=
 =?us-ascii?Q?wymeOs8TrIPhYpvxmLH+MqFgROj+p/tKBhA7PHtufVVvjgZN872f2lqtZPCc?=
 =?us-ascii?Q?OEUqy9l+m2w7FodVsjkTPbUdg7TlRPlKCksc74lL7AgRmee4n5V8LBbIR7Ho?=
 =?us-ascii?Q?FOjWyb4JafQ0J1vywehxgQRlZ3YuaVDRGIJNm4EX8otPJvKQPa70NIx7VFIu?=
 =?us-ascii?Q?H0dJtZNtQgPM9XgT3wnNQhjucRqJ9hZB3bglukLaENjXLQm5fpGEcdW5LFXy?=
 =?us-ascii?Q?a4/5MA0o6jL2CVkB+F9/wBJ/6RVmgg6AMAy0yIA/KTP++TI9tzWyzn3FO7ep?=
 =?us-ascii?Q?Dx7B7juW6v1tRaacYCEQT+b6yXIQaKdOM51thrsgKksOpCddMbk1UY2RjK0k?=
 =?us-ascii?Q?XWTLqmGIl8wWBSsHa5kBiu7VRsO5K4E1E0ManbK39Uxf6v/ndNGhNBKw5wtJ?=
 =?us-ascii?Q?p5r1dqyR2+cJyvgUXjp2BHA7sWg3zxDUa6jpAWbjP1Datbj9GYpl9W77XDN4?=
 =?us-ascii?Q?GE27Hg8t/n5D5Q0xIqxhgr0t+OXcEwvq6b3n9XCUCkO9oAXm5Gnkeh4OEzW4?=
 =?us-ascii?Q?35C/wG2/t7wDkbJ5rv8ieSvaK+xBCmRaxUJMR307wBlgYbyj8Drrs+dij69E?=
 =?us-ascii?Q?Ma5mOe1n0tejYyjChZcG3fQJpJjJXaUzrQbSdnUuZ4Ec/OXC4ysA4UZaL8pg?=
 =?us-ascii?Q?lZgZE8w3QJfPri2HzI964EYrY0EtXSBGB8ecT7y0n+XWbA0wNywLiNRrn6qI?=
 =?us-ascii?Q?/mN0oDZaLGOk2t+Dbu6Lv092C82zc1Mdh0IiGRPR+yttoYWxUuo4In5Z3mnp?=
 =?us-ascii?Q?/AxHOoqJlFpYAS7nQKOwdsITkQFwjBvzY4K0JCyfRTLiITZ1mqYvDd9DiDG3?=
 =?us-ascii?Q?qoF+PpEQJBI2/gAUWhjRRpZnPgFM8lU++jTw3zbo6XGA51v6ldzX3jhiqu1H?=
 =?us-ascii?Q?pgo+4qJsOLU0QICq7bnrHH5tQvI/qm2pY7rvBnWCLKuDrwtspolKJhalDoRv?=
 =?us-ascii?Q?Rc3NxBn1ryr+SSmq/rfVUzGdEI939Qiai6iyb79L07YSMuRCfVVN5jWQpc2F?=
 =?us-ascii?Q?MtmkUCXTgTsZOZn2/JJZuGbybdc8BxwB28qUCDaSuDYOZbBcuI+gCp5xfkN3?=
 =?us-ascii?Q?yrrczuwzTrQzysLODNdTky1Y1hKqhRlpBOK+fQU9ywCo4M7Y9ZSLL8enD0UI?=
 =?us-ascii?Q?qta4Pv958bxDQzpHS/obmZrswUvEF5D+/ihhgD9wiIstycvDOvClja1Y6EEO?=
 =?us-ascii?Q?CJQ1xX1a9Y8mD4Jz0vY0l4rbC4uvb9XGoFCjza/x+nJ9rHd8aYqr7dJQ1pSE?=
 =?us-ascii?Q?OgB7cMRQqI7oFnNQjdWFGuKBb8Vb278gQ0Ampszq9ndJ6WfQRdaPWO0x2xRX?=
 =?us-ascii?Q?DWROeK+huh8sS80+IhhSnHeUsDpL6I9OK+b4Yzx1hJH2SUdRZg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe53cfb-5b41-48db-5157-08df325febf2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 06:19:27.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816

> There are sensors with that sort of level of precision, I'm just not
> convinced they are ever going to get there for capacitance sensors.
>
> The burden ends up on whether userspace code runs into any problems
> with high numbers of digits. I don't mind them being long if not.

This is a guess, but I imagine userspace code generally reads these values
with something like strtod(), which can handle an arbitary number
of digits, so I think it shouldn't cause issues.


