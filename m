Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496738AC68;
	Fri,  9 Oct 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561209; cv=fail; b=dI4BKqhp95vhjSVqEaJNHhyam8CF6QEi00uP0zKx3SbTL3cEyijCZmelRt1lWcwrxnXERammvNdMpO8qDfHFbxlll71L5UL8Ono58bI5sqbM5HjhZ/X8CwvNKTt/6o8SdBy83A8MpOrnNWhDpF71RbjKgkFZHJpfjy9iVHS47WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561209; c=relaxed/simple;
	bh=tG6TOq/MvPRFMP1vocsIhKZ7O/4mDiBanpbZGtSkaxc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NtfzWJRl9vFp7w5+JFC/pM7CsXzEbGOjrVYUFRgMMxfSNXnSzN1sxchnkso4O21mLshXYbYUGsUclsUesKqetftiZaS1VZMhzMJTr2VvAZcwPCiGD3+7cRXcuLHJNxV/ZXw91Trpaf8FADLRP3QIEAibznDv0Wquz142u2eRvxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=uW3+2WMC; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IGooiXxg; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="uW3+2WMC";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IGooiXxg"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DN9vS2289188;
	Fri, 9 Oct 2026 11:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=PmKU9umy0lrOx6TC10Namg2t+KbyI42LwG+0AG921MI=; b=uW3+2WM
	CaQ7ixlUiR7uPW4Qbv1TCqz8xDTJVXqOxc/xt4X8EmL27zgCC9dKPwo4MAnOZZX2
	qtkUGQqq6p6riwYaOQRkeevQzjB1aWZlDjwiGs5XJcf2ZaEK8MWx+ICR19veWLX9
	DVgNV3NnrLCgL5aQgMGGr4GCMdNS8d0xbK+wmcOjg162WqJIwhF4sb5ZQdcgOQwd
	fGOKqu1zP9FTjBGCLV0O3M6Yv4KL4SQ7MMuEcKMfNKmZEflV8VNNKjlrKvNJDS8y
	T5+4llf6jOP4CbROB0sKC7wuUeR18zEPotsjM9+J4+D3WlBqtqpcc9G8JFCpi0Vp
	xpneeyW1srjtkcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PmKU9
	umy0lrOx6TC10Namg2t+KbyI42LwG+0AG921MI=; b=IGooiXxg/kgrSGjDotf5s
	QgXIsUwDesDYKvOW0QGzymB8urt5uYZ49ri35tVjxzps91q0U/hr0Bb6cxVXVHpc
	ACLU0h3FgArcCyxdlNtSPuOnZG5y8LoDlkB+Xu3Tdlaod0Oi2+V1OJ4B0XwfwA6U
	YjDgwk2w0VoeYIl/dYveD5SnGMjuQPF4UpX5HAfQLtgeRnz/S49lMSNg0sK+qxMm
	YI6tBM6IdnNRjtQHk4fYCzvsL9DU9P4ZIZmuGrWYc/9X943q3bAh8zPsDlJyG5g5
	uc3Co7gYVe9xzoeelIb+4YUQf5OZclXnujapZv4rWX3LcYI4DMP8lRc1NQOZJixj
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h6kgmmvam-7
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:51:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7MR/rd/MjqGY2vnRrAFWYnkU+lg5sLg3II92h1feGLfAwc7KZ87hIZLqBu/kSknYPVVQWKKBwpWETzOPeMrMCqHjUCcOheLVJHdaJ5wThe7dnn2DJTJZYE66Clj4p235g4V8et2HxM3ZaEx5YptGqG4KHT75/mgvVhQmvDuQ3a9YNUuwrsZzNfU/POTAdG+m5QMuNhVW49Kr0YdhI2xQk31T1cvMxboqm+qM4eV4uBHtJdZRa6YFHG63sJIHsf6ApXsBB2slx6LrdgkwFyGtXFNoZ/3/LBPsGO5imp7PffPTF/x/AZ9fGkJVyLXcMe6s44eAZBQ71QChXTztXNNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmKU9umy0lrOx6TC10Namg2t+KbyI42LwG+0AG921MI=;
 b=wv01QmeXsqru8U3T+1O/7ZCpMPQ70YMPZiYp+9dBHc6rktrtOVaB87oEgsVKu+Pmv/cMziNJLVI0zoMj5DVEYsjOgCDmN/srao1hrs6cdXWaJ0s0YpsCIM2Mz77efdhBr2tv80ZpGVBLShRq99xQWSthVABoUhqn/GvIXOtVn+dGpozpW3CRCjBvjfAIP87TXZxNJxiMGWjg5LVjALhNPaINBMWI1nfcyGtjNy+isfA6qp48930QsE55Jl5OurT/0uDy18JnbdZ+SMoffKMo6SnMvxLX4e3eWpn5taMqmT+1LW7VqyuHWMrcGZscnAiuh4AHLkkarvlWx6Qo7ZxpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:51:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:51:50 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:52:56 +0100
Subject: [PATCH v5 4/9] dmaengine: qcom: gpi: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-4-4c4e63a7a1af@analog.com>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=1409;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tG6TOq/MvPRFMP1vocsIhKZ7O/4mDiBanpbZGtSkaxc=;
 b=Nz1gbnOUyRzVhQdispbqpkWlSuStkqw9wTL1hXjilZBq6+i5zTZmHR610jap/KopkFfmV4drD
 Nqx5x4puQ3eClnY9e6EfYv52DVmgQaJlO36vVNg4fACEhtmHheGuRJA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0005.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::8)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 985ee8f5-0ac8-426a-ca3e-08df261d3b46
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 LKSy7APkqngmq1TVBj5kQHxfO7ndg6tThI6G1TBHHLJ7Vq5k1to8JXBLCaOHe5LiYuwJ+9HJmUYYzR8WP28cRBsVs1gtqhxzmghXaXT8eHfg4nUQafnmdPC2juCDohg74wXwU79VKMqDk+UeqWahjsQFZydG5+8yMnjsijlPnCne0wa71qPEnucvb4SJs9M80uXGqjyF6X2vDYvjGBZnuhCEnfJlikisHnZuzBFOPVIcwdEG0cDbdW+BSmwKhu8tlmCUlnKReE4yf8e1iYouL7WVvNh+bOf6R2Oiu2x+H/uxsAzGpOdUPZu+g0Nm8Tx0jI1BK7Wnsd3Id/fr7M8NA09YKTXuMImfKwUXs3eyGcWnPTzPgW3d76K3nE4n6D9640Lkf0VOTvCmWnpr7SynarAnRopW9HmpuWIDC1ZdLShlRvuDyb4ePxoag3R1kyzkF3u1LGd8wcG073HRNyLDWIRowaEbCI0UhNDCNgV9htmWtNApeOurjhrY8jqSRl1IiXdKxPHm9aEqDdG1JbyeULdSsytK1xTckgs1vVv2LDQ3QQFhU2cG5JmfXH22oQ90O2o8droS6nY6z2kaYfRBDPjdQI08xf8sczZU5auRXcdr+bKrtj3dQ6gGdegvcTziI4VmUY/tXF0DnT6Yx5eepl/M9sIFz4DUWumHY9bMr7k=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y2pZblgxcW5uSVE5bGVscFN6blhkblJoQ25keWNmTndGSENVOHZXL2liYkJ5?=
 =?utf-8?B?a21pMm5mZ3lCL09ROE1RcjN0OHRkS1JtajdEb1I1Z1Y2Zk9NN05xYUsvTXBF?=
 =?utf-8?B?eDRBQ2J0NXdmS0w4KzN0YmhmU2Q4NVFPREE5cTV4MHpjc01aeDQxYUpXaGRH?=
 =?utf-8?B?RkVsMytDSy9XaVVxUU0yZU1VUzdmTEhRb1pFTlA5dmhGbEU5WnR6RDJ3dTJz?=
 =?utf-8?B?MWhGazJsWTBGNWRxY2ZyOXhvWjNkeUtOdm4xNkIyNW1ZTWhBSTBQUGhDSkJV?=
 =?utf-8?B?ay9KcCtQMzZJS1R0VUNoRWFzVjB4NDVsNnJlT0UrV1lDRU1pbngyUGVzVU5W?=
 =?utf-8?B?OUFpRkEySkk3d09aeWdQOWpIeWtxOGpoVGU4YnlScE1iZ3hjOUs1OG93UDZh?=
 =?utf-8?B?eDhPN1NuUmg2UjJIUk9zWjlMRHN2a0xuRFhVVkN3eDNPTGFQRVRySkxERnBo?=
 =?utf-8?B?Y2ZoQkZqTWZaT1YyK2V0aEpBOFBOd1VWWG54Ump6Sm9wTWVVL2pDV3dEU0dv?=
 =?utf-8?B?Tkg2NXFPQjJWSVdNcTV0MFJlNjFkRkQ5V2VBOFlQNFdHS1l4RzdtNTVFSUVu?=
 =?utf-8?B?Z001V2RuZFVqVkpTSjJTa2F0TzUwellXcGk1N2FRQnFyREl4QzlwR3hoenJJ?=
 =?utf-8?B?WUlmOTB2emlLRXhQb3gvS05JUDZHUUhZTGV1dy9FblBEZ2tHRHlmMlZrN0V0?=
 =?utf-8?B?Y2gyN2ZqQnR0cmhINDJ6b1VHQURiTDVyeG4wUEliRXZreTdmTzhEQkE3S0dO?=
 =?utf-8?B?c3BlMThvSmk0OURTREVWajgyNDZIVjVqTHRqMFo3c2t5cmdiU3ZoemlwekhT?=
 =?utf-8?B?VEVLTGJBQnRncFBjbnprL3lSRU0wa08rL2JhdjFQaWMvMGNyVEFRay9sLzIx?=
 =?utf-8?B?ZFRSUmVOc3FtcnZQMGQvaUs3TTRsT3FoU1ZCenJPTnZkU1U1cjFjRjA0UGtC?=
 =?utf-8?B?emxxVWdtNXowZlpOZzV5Q0N2eUZMU2lqQVFaS2FkSDdHMkdTRGFGcExXTWh1?=
 =?utf-8?B?QU9yL0wxR204Z2thdjRvOGRJdTdGMnlXdFRuZ3lRekNkYk02Q1JSdzUrTnox?=
 =?utf-8?B?UEF1am00SmpNL0tEZU4yNCtBWkhkUi9nWEZsejZDZGNidm5mWWhQb1I4SFc4?=
 =?utf-8?B?UWtKcTBRMERYVnF1VkVidFMyTUVOMWV6eTFWazJOY05DemFicjRjZDZGVTFi?=
 =?utf-8?B?TU5SSy9Vc2hYT1pReHlJMytvNURNc1M5Z2R2QkRUdFZTUTRPeXFReE1oVmly?=
 =?utf-8?B?RTZuRzAyZmViT2x0bndoQkEvNFVJNUlyNkRFbzR1eWlxeFY2VGJSRENYc0N1?=
 =?utf-8?B?b2Z4S01FMi9nRkxicnR4ZmZTNFJiQlBPdnVPYVVIVlpZak5GOXZKYXVYUmwz?=
 =?utf-8?B?SHJlVUVlenZFbHQrakhxY2ZyQjhYUkpRNVFPNDFQdWY1Qy9oZ2Y2SENHZmRT?=
 =?utf-8?B?Vm8xekZSNGxFcmd5NVFWZGJSTkpsSVAyMjFrVlphUStUc3hZQk02SDN2ZEFB?=
 =?utf-8?B?SjAvYXNwbFA5SExWRmRxNU1aMmMzS0NkYVdYVUZpOHV0a3VnMVpVaEcrRmow?=
 =?utf-8?B?cUMrRGNJZ1ZJQW1ScElDeHRFa2pVVTBxcHBNK01zRUdwWWhFdHI0NmxLYlFT?=
 =?utf-8?B?QlRZcW1EUnpsNm1Idm1FVHdOSDBaNFJocDZaeHJJU2ExdUF5UWVoemFGeEI5?=
 =?utf-8?B?RUw1clRFeEYwdEoveEtCUkRTaWU4N2RxNmVqQlRsN29OVnRtTTdXV3ExV2pY?=
 =?utf-8?B?UDRTeFExTnRmeWRPUmphTVF2aWVpbnZJMnJ0NlpHWVlGMUZzUENFdUI0SXhF?=
 =?utf-8?B?Tlp1L1A0cTREZTM0UjBvM09zVzVwbVZFZkRnaURESlNGaXg5OXowNEdJSnNv?=
 =?utf-8?B?OGdBekNYcWJEK0ZsdmpMb2tIOHErVEJNY3ovcVBKMk1oMXNFcmVVT28zaExn?=
 =?utf-8?B?WWhZSWNveGhtZmlySzVmMWdkRmtmemdzYUYyQnNVZDNRVFFNRkl1bUNMOUJx?=
 =?utf-8?B?NWFUQXo1M21SWWxJZm1uZ1Zhcy9NQU80Zi96UmdnclJpcmgvM0hJQmNaNm9i?=
 =?utf-8?B?VHdKWnloSjMreitmVElETGo5Sk4yNHplR0JzaHZ2alJYN1QxUCt1NFY1d0VR?=
 =?utf-8?B?eWY3MmFlMGswU0lDK3ZDVldSMzltWFFRQmdibTBnRU5EcFNjUW00L1NhNkRJ?=
 =?utf-8?B?Ykt0Sk5uU2JQTnBHQnFUSEx3MmhKM3BnbHlPNlZxeXBwQ3dLVnZyNHJReVhL?=
 =?utf-8?B?WHo0UmpjMUp2Nk9EbzBPSSs3eE5IeWJ6dko5M0RsS3RRM1FxUE03SWthZ25K?=
 =?utf-8?B?V0xxbDRLaUNTQjBJb3JFTDV6TlZPVTlCT1ROdmRKV1BlNFlqOEpnUT09?=
X-Exchange-RoutingPolicyChecked:
	JlMzzLAjGXaMoBUwMNVBycU57vGrRJVve2+93QE7uYPmkFaaL1YfZenz7zqPWcs1qo3K0UWM0IH0G3cEIBTWfkSQkV7a8w6VvEaiOQ9NB3UQqN/zgdpkvuikRY0/b9a3pA3IP6sICrvkh3WCdRng4lQswoxlzupExe49ykFum59MmnefZ9AFCX6t1B/Pporv5nIhUG7xMCMENxeS1t13+rpjM/b1YA3sGSAELL1DAnO52L4ObuZQQVrhSklqd8hj8b8dx+YmDr+uD2ae8d2h9jPV9mjyOTqrBPFtATHKL45Dapo7PpuqVAbA+qGQAqHn0bxgalxjaRL4lY4HK078cQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985ee8f5-0ac8-426a-ca3e-08df261d3b46
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:51:50.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J249toJXK5SYrY7OleqgK+EFcGzf99MRWbqGqEffuC+Ek9PTmf2lBv+dbxrSnE+A0lSmAesRkwP8WOw1YcwImg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-GUID: 9oBZ74QBqfX7_3bcOZeLne4clT7eU47e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXz4mNc18Us4wf
 3aiNg6AADitvNB8XFZ2Qq8wAGziDIpdCeOOAO3csgXnFzb04d4h7mzPyKVij6MZCf46XHgNcEfX
 dABPblXvMp38CBsvYmkJTzfzXcLHi2qrc+5m7eYphfWHHgWcDV2B
X-Authority-Analysis: v=2.4 cv=Avx7T+9P c=1 sm=1 tr=0 ts=6ac90d9c cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=11eJKpf74FRv4loUduQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: 9oBZ74QBqfX7_3bcOZeLne4clT7eU47e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX3SdnqJmA9OFi
 8JRt6VmuZTGv5mTf7qTfagN9sn26Gsi+0vvWmN0hw3XR6FhA4uY+mwV7T69LSMY4TSRU12lGlNe
 nxULL1creS2Stut0J5ScQNpsCyiSXhButxYGSDQ+FrIq/gxzqcf/ND+aA6mzyD8gnFs3EcIARjB
 2+7SxlZXmzX6lTrPG95CVZlCEvsRJKo5huRqDI1CwE2z4dVTXO6vhuXQqAjtyAShqYvLE/HxWx6
 PlH1aL5x4GMZt6K9Qi44VOdIiv/aQT6f1rowpowbcSj82OcKf/xUekjS3/avMaY/+Qr8vhJKc7O
 MKDiPdWsdCrQdEEvMhtsOKRX0l6do2scuaOktYwjz7KGEsL0PuFCVMDPlygYLlGj48HwV7pmmqw
 TDh4J6AHwhlK2hgc+ArBlAxDgoEmzWOZVey009AFnQtQsAzHa9o8uWXDWz8g0XKIsCtBI18c5e3
 51wUbxZnqnra/ta98TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090063

Advertise the single supported source and destination bus width through
the new dma_bus_width_set() helper
instead of assigning the legacy u32 fields directly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/qcom/gpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index c41bfac65ddf..1959ff8d1b3c 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2270,8 +2270,15 @@ static int gpi_probe(struct platform_device *pdev)
 	/* configure dmaengine apis */
 	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
-	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	ret = dma_bus_width_set(gpi_dev->dma_device.src_bus_widths,
+				DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set(gpi_dev->dma_device.dst_bus_widths,
+				DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
 	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
 	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
 	gpi_dev->dma_device.device_tx_status = dma_cookie_status;

-- 
2.56.0

