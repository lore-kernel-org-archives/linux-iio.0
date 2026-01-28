Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456021B9FD;
	Wed, 28 Jan 2026 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584542; cv=fail; b=K7E6dUeMuBBs6iP/ogEGtDM2wGGvZrk7CcQ7WkHMF+USZxGCwSrWdEKEmskspYNnHOoy0Ie4+23y6Ikt+NfoMUlNHx5jdISnsUWBl4QV6woWwXR0R6BKNPxko0G4DT1AV6CjMtrMThP/TIkr9suTrZfQUKjPAYPnHXrc9tOWkQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584542; c=relaxed/simple;
	bh=nWVOdKdVOKKHdHkkYrFmowqA3ZWlGJS86GjMM8shIzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALdz5KuW4gYL6zJWBTJH+5+Qgjr0C4u0CyZpRHVVSllwXZ5SbF5Z28ptTrScq9dJ6o056lIha3tbXdWjXwEtcMTAuSeOI4NE7XghnMmmKsZegVQzCd0ze7k6R6pMIXHNTwi5VIErG4ludETdUXJ27/Pgfov5AVE0wism/MYwLE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B9Pmq+zU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hSAy1RAt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9Pmq+zU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hSAy1RAt"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4CeLE1563560;
	Wed, 28 Jan 2026 07:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m/X5HghPGb3Oyz5f64inPrZYXBBTF1F0sVmv2/uco9k=; b=
	B9Pmq+zUe0hWBGt4sATZeHgtFER6ybL8p93w9u5cQBd0T8iO2zYwNcXn1uKik46o
	E0Mf3tOm4LhPZ2xpjN6oYm4I4iV6R7HAENf59lbKqBgmoYKPXH60uTwWdy2coJZX
	FcGw++NtLpGfwoIx/VaBP5guuY3Qd+ZmwAk2VWS+Xw2NLPrUmTRZoKN0eF+KxTkM
	VdFrvdgn91Pez70P+PFb3hiJ/ZElrehdHNHpDf6rDtBm5LZ9o+KXkMS8boefPbMw
	EeD2dFrkDE5n/kaUFhXiFypRoJ8/l0omrnJ3Qlz4VAQaMOlurhML4GTBa7DSBmkw
	2iQSSz3Wzn1ieGY/1QN0vQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vggw9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 07:15:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S7EhYt035129;
	Wed, 28 Jan 2026 07:15:21 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhahjk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 07:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SriT1psvkPl0nwMadDdsk2vMCpNG73KCpCAbpAurlgvN3WQOZG9cQrDl8h66lHXDiuiKhNMTBHfYqaN+1gEgoyie942xZT4Oa2cKa5707WyuVW1jrudicVM+WvcdbP8OvKnH7ERkWIT/VJCP2T48nX88DslXFeXPgAoguWIhi/yMa9y4wglhvjGcjsyWJN5nPUJhz3yCWcv8fvf+/IckjESUdvZsqusWT4gwHDAez+0D5ITanDJkw4LD8V2vhIKLdYXlJdchjt7oyBGt5EViORA64UNkcq5l8hL38u8XG5Bs4fZSw8B5dMypO4v3ZtG2pT7191r06A9B1QKgRVXgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/X5HghPGb3Oyz5f64inPrZYXBBTF1F0sVmv2/uco9k=;
 b=Rtd01poF+JkGkVlZRfa3zbK5jVBLzIwLO7JwehqXRx6NVPcNkt5dIBFnMaUnxrdLbpNLHlRZglQ3lQLLGpKlicKiwexl4E2FQXicvxpGtGXSPJe5tdEbWO7v+vgVHUIDfW84YBH0CyDSWAxnriRHL6Od5NSJIn2/Aafifje8GJ4yVFVU5/unmRWUY89wx1TOoLaokCz4AKkOj984SuYpgBoaHIhwf/tyLCGG/URucX/+pccABmlpGRu7NTZ2gTI3hO6IW6iu+zLWS/ILhUrDqsC0vq1kVJVD6B6khwgdkxGtF8QWtJeMsGoyuhoBkjhUS7Jlw6nF3Wdu4g9AkzsjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/X5HghPGb3Oyz5f64inPrZYXBBTF1F0sVmv2/uco9k=;
 b=hSAy1RAtceiKDv4Ggi18riOpFVBPmR7/4EaF68xRXuM6b/IwOAQUduY6ndh+ihQROEYgVLUC3/JQRzVrfhuDDVmlk1tHej9XFveRlXXMmAphMNljUVE+14Q8stTAV9+AG4rE7eGrVmYFz7iuI2xPqQO1c0+e3rHeShQZAlK0RD8=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by CY8PR10MB6801.namprd10.prod.outlook.com (2603:10b6:930:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 07:15:18 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 07:15:18 +0000
Message-ID: <3d75cb8e-456a-4de4-808d-7ca5196800ea@oracle.com>
Date: Wed, 28 Jan 2026 12:45:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: sca3000: Fix a resource leak in sca3000_probe()
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20260128064953.2952714-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260128064953.2952714-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|CY8PR10MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: e58cd78b-6748-43de-3530-08de5e3cfdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnBIdHZKT0FmNnJtVVI2WUtwRzJTK0h0cjhsUEoyYzlPdVNSVmh1OURxRkxD?=
 =?utf-8?B?OG9FRU5PQ3Jua1ZFaEJJZUlHcmwxc2xwN2x4TUgreWdaQkgrVEd3bmN6c2l6?=
 =?utf-8?B?bHlTMFIwUHZmMUVHRzAzbnN4Q3N1TGRscW5EMnpiVzBMeElXQWpjMUI4TFcx?=
 =?utf-8?B?UGVrR0w5NTg2cGExS1BBTkRIVmtoY2ZicXo4bFlORVdXcVIveFpQU21GQkxE?=
 =?utf-8?B?L1lEdkFlS3c3OHg1MlMrRFJpUWFNVmJZVDVlR1FXWmVXaUplUmdaKzlVMDlG?=
 =?utf-8?B?bWU5SGtmWWQ0SGltZG0rMVBFRjFQVFlRQmpScFRkSXVGT1Q5cTlKVTJuWStZ?=
 =?utf-8?B?a3Z5dTc0YWNwcmFMVnQwZWdVSWh1bTdnUkRXRTB1YWR5bFFSNkdxNnZMMG52?=
 =?utf-8?B?L1ZHOE5lRjdoWDNMc2hIaVRoaEJKaFluNlNrbjU5YTdHSHhtNTIrVk81UlVP?=
 =?utf-8?B?TDUzVnA4a0QrVGp2WjAyZTN1VVl2NGM5NEF4NURDU1JYaFk3UHhuSG9DR29u?=
 =?utf-8?B?RG5RNlJBdmZQSVZYR1E5TWdoREhUblYvWHd1azFqRzVObzJqSk9rMTkrblZp?=
 =?utf-8?B?QUJLa1hUS0tOb2ZjWjFIMW9XZ2Foa3RGNUcrWTF4SXJqTXZpSWZ4U0MrYWxx?=
 =?utf-8?B?WVlBK0pvNmowakh4ei96NFJseE04M1VGMkV0bjJnQUZJSFA3OEdvOWI5ejdp?=
 =?utf-8?B?bXFrR29JWHVuc20xYjFxc0NRRUl1cmc2WnJrVktJRmFWUUM3RVJSOU9NTlov?=
 =?utf-8?B?a3dqWXdrQXExcVYxL2RDeEp6djZxUHFXanFpTGFYSko0VDhhdkdiQytLbXNR?=
 =?utf-8?B?WmQ3aXpscG5JY1hrZHZqb3NCRnRHSVdBSGZINjVLZlZnMUUreGhxS3pSeUNr?=
 =?utf-8?B?SHo5NmVFbmpnN1Q5ZWV2bWJtdkI5TDdvdVpPcFR1eHlIWkdCejM1MHV6TjRs?=
 =?utf-8?B?OVpMVGRpUlNuNHQ2dzNrZkV4VXVrc25oVmRxdUcySGFGWnJhZ0p6c0EyR3I1?=
 =?utf-8?B?RlV0UWhkN2ZkVlFDWVlwcXRab1FNdzE2YS9ZOTJiL2JsdjdjVHJPUFpvb0JW?=
 =?utf-8?B?YzhXVDRxL3FzUGR4Y0J1bEZJZisrdEdtVXY4Q0w4ZzA3cnJXd3phZmxNbUhx?=
 =?utf-8?B?SjU5cWVrd29zZ1gxTG4zMzNJbkRxSzZrZFRRZVRxWm45dFI5N2N0R1pnc0la?=
 =?utf-8?B?dURCNldaYjdEUVp6em9kK2hxM0NkVlFVeVdkNjZOSUpxc2lXdWlMZWltUXZm?=
 =?utf-8?B?OHRMSkF4UGVNMmlqRDdhQjQxNGIwQWMvajNFQVJ6MGhFZ0pGWS9kSUVQcTQr?=
 =?utf-8?B?aEMweFNJc0Y3c2ZXRkRsUTdaSTViQnhGMGZDRnhIWGpoVm9RSUQ0S0FTWFNj?=
 =?utf-8?B?dVF0ekhlZWZWdnFNR2pUUmUvRTRveGhpVENwVlJKUkQwWndlNWw4ZHZjbENa?=
 =?utf-8?B?cU9HRklzd01OZnphdEJxOFpUaUVhWnFlb1BmL3U2d0djSlB0OFJpRE92eFlr?=
 =?utf-8?B?b3doMTBOYTBDWVl6WEVRVGMxN0FSYTZZUWhQWkR1SkdIQStIQUdtbHpWYysy?=
 =?utf-8?B?UWNpNlljSHlGQUUzRzI5SERRMmQxUXgrZWJlcEFXTFFjNUMzRk55YXpBclVF?=
 =?utf-8?B?OWVOelNqNkplWEwxZG1EQ201NjNmWDNIMm5mM3U2NjJNOVcxZ2VyYm1UU01t?=
 =?utf-8?B?TGQ3U1MyRGhobkV0dEZxU0pVczVHQW5rWjZOL2Y5OWJtUVdTMGh2QVo0blhi?=
 =?utf-8?B?N0o0OVlBd09TOER2MUhveEFLSlVVeDdhMkZ5UGZXYjlGLzUxaThwTCtGbkNL?=
 =?utf-8?B?NXo3b0ZmR0NvUkN2ZEF3L0x2Tk5naEdkdUZUV2xlMEh0c0FYZGpsZ0EwY3NM?=
 =?utf-8?B?MzFacDIzTk1aN04wdCtTUjZaK3FFVEczSUlUNXAzRWJIY0RMRXFGZzhYZEE2?=
 =?utf-8?B?RkswT1FkUDJDZWlZRHpzZmhmNGZ1MkNjeVlKbUpwb0FsZWhZVGRCVkxLM1gv?=
 =?utf-8?B?YmY2NDNtTDNTV1J6YU02NW4xNlB4dWRXZTZZZllPSlVHcU9seVVMcC9LNGZ6?=
 =?utf-8?B?dTNvV0pUdVNSNXIyTFdUSXg2VGkzc0wzdmhkMzg3REpOOXdBYlIwU2JxWEVp?=
 =?utf-8?Q?gNn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHRxWjZ4N0xvRFJRUHFCUzV6RzRac1VVU1RyamtrMDl5Szl6MDk2TmlwYXRP?=
 =?utf-8?B?MnVMV2dSdnp3bEYrYUhPSTZVSFdrekFBTEtDam5GUy90ZlE3TmphRnk4U2RG?=
 =?utf-8?B?a3hSenpZb2VxWFBJc2RGR1MxQmlzSW9DdlF2UjlLTnVXcTdEczlTaWhMZXZ2?=
 =?utf-8?B?R05nSUM0MFBRdnpKWENZT09Hd1Q3cmlZZVFzSzVyRGhQL3hETUlCeEVHQm8w?=
 =?utf-8?B?eUFseGtUbHVGczBYUmFnYzQyTHJCamJOQ21sZnpZT205ZFpZb0RpLzl4bGQr?=
 =?utf-8?B?K24yaXpjdTNkVFBFUGpnUnprdHRwcEsxMFVzVGNmNVJPV1pMd2xzemprUXlZ?=
 =?utf-8?B?SjFMN3MvaEdzeGJmVFpaR2hHRU93REJ0MGpxSHo0U3ZTMkZ2UDR4emdaVFRI?=
 =?utf-8?B?RGtSSkJHWm5hdGZET2RRWkp5N3NsaFNRS3hRbHpyWlZSVVRzcytqczlsU2F2?=
 =?utf-8?B?RHVlcXcwQitDbFhTVmQ3Rk16Vi8yRFFFT1djSVRwSURQQ0NYSjQ0NCszWFNO?=
 =?utf-8?B?L0VqL3VDK0JEVW5Va09xUElGcDlZcnhVR1QyQnBPWlhSaGJHU3NDTGpGK243?=
 =?utf-8?B?M1IxK2ZhTDJhOFE1SEN4T2dsbk1vTFdYUXZtdFBBUDRlVWt6MTFCNzZQclFW?=
 =?utf-8?B?b1JQWFplZWcrSjJGN1dkK2NXZG5tNlF2cVFiNGhlWEJsUUoySFM3SDd4UExt?=
 =?utf-8?B?OXVKUEdFMEFrNUVHTjZuYURRUnZaaVMyV2hEcW9ZYkx2QXJuK3ZPbXB5R2lU?=
 =?utf-8?B?YXZaVFpMamN2T1NMRnhYbExVYklyc1pZVjh6cVpuVnZWVmtZMzI3Z1gwbk4x?=
 =?utf-8?B?WENBc2l0TnFGeVloUVFZMnZNVVF2cVkraXd5eWV6S0NLUTV3bDRnY3l6OVVv?=
 =?utf-8?B?R1JwNkFIbzhGYUFXWHNRWDVOeHFzOGdkeVI5L1JXZjBuaTRtUHIvdHlpRldh?=
 =?utf-8?B?cERrajl1d2hkMUt3K0dESGxsYTFKNXVPcjNUYThqeCs0SGhnNloxNkd5NVNK?=
 =?utf-8?B?cDlJbUZURE1tblorV0hkS1QxcURvTjg3Rm56NzhUalBxcFlGZjdlQnZmamVv?=
 =?utf-8?B?eEVXK3h3RFFGNW5GYStNenVIMWdkNFhuYnJ1YXdRRnlTTjQ1RWpHcGFIeUV5?=
 =?utf-8?B?SnFMSU9idSszTi8zNER3dW9hbkg0SytYMVFrY0t4aFFwUCtjZk9oOTI0dzMw?=
 =?utf-8?B?M1l4ZDRibnRKL3hKUHRWN0I5dCt2SDl3Y2ZhK2NGdXE2ZWQ2VWVobkxjaVF6?=
 =?utf-8?B?TC9CaUVma2ozdXdtRWtNWXNFNHFGU1oyeG52SzFnWVdJOEVGNS9mOWtwdTh6?=
 =?utf-8?B?OHpjd2hsMXFDaWFZZU1GbkFVOVJwd0cwZU04MG1MTDdwUkNzbXpDZk9FN1FU?=
 =?utf-8?B?NlZWbk1yKzhoSlRacHFEclI2cm9QR1dtSVNGbXBmdkdidVVVYm04NFV5UDJW?=
 =?utf-8?B?andmTjdESmJVbVVYWkZuZC9aQ3I0YjlwNTVFZnVlT1kwSlJzRi82S3NrQ0Y2?=
 =?utf-8?B?TVM0SlpZV2lxNkNod1cyU3FsYWhCbGpSd1lyMkdqZW9Qd0IzUXBOc2p1SlR3?=
 =?utf-8?B?VUM0anVMYURUck5TRE11MDRyVUg3OGJKa2hyQjhWV3lXNzNYMzJqV3cwM3dp?=
 =?utf-8?B?aStveHhkbTNKZ1FQWDhoQ1ZDdjViRFBRQTJBRUIzRFlvSmZqaFhDTXJlTHFw?=
 =?utf-8?B?dTlSdEpxQWlZdnh6TmVWS05TdTVTQ2RFTFd0OUZLSFljWTRZQkg4WHFhcUZQ?=
 =?utf-8?B?bzFMMloyU25kMkg0SzltQWFLSDUxSlBtK2VOb3U4RzR0azRiYzlwUFpLMExm?=
 =?utf-8?B?N3FXN3FVajhIMTBNYnBwV2hjbkJDNXE1cTBwTzhZWTRod2ljTC84NTdZdEVv?=
 =?utf-8?B?dU9xWGdKQmxta2g1YVdrMndWSlVxSndyQWRiektYTjAzc3prWCs3TkpBS21x?=
 =?utf-8?B?WXR5eG9iLzVWeEdnckc2NThBaytBZGU5dEFaNm9aR3I2ZnU2NmNpN1JjRG1U?=
 =?utf-8?B?OFJZSEl0S0x6TUY3b0lqQU01azh0UEZQNkJWdmZYOHo2a2ZHZkNESStjSExJ?=
 =?utf-8?B?M2tFZjRVSTlQOWFwMTRHYkNFRER1eDBKd1NpVkwwSU1QT25KcFIrWC84dnho?=
 =?utf-8?B?KzBmZzk3V0RKalZWM08xZnRSc2JhWENpM0djVENWMkxNNTdQTlB0MkduWlVv?=
 =?utf-8?B?b3BqTUxvdHBWOHMxNGlCTnFrVm1Oc3lnek1sRGFIK3MrTUJmSTlGQlloZGhx?=
 =?utf-8?B?bHA0bGRGT2J6eU1ONXc5VHRXcStnUUlxVmpUVFB3QmtKYXJFbzI2RjVVSFlK?=
 =?utf-8?B?K0hsZVRhZzMyZ3lUajhNdnFFQVJvN1o2QWdJNHJ6SGJPUUVNU2p3SS9oOG90?=
 =?utf-8?Q?g1mday8B+tuTcvYgspn0sABNAM01LysJTDTrx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0e4++eiU0/J+GholqUA4QVoSV7iiImjZrWJDQEZkfGJu6SGFLtXkSAr/cKASN57IOyhfvuV2iJ4MmGmh0gcfHWbm7B31jw6g/tubCw8W7/bkVa/JZHn/YG4Fl1YC2K6SU4c5L4daLjVQgH/mmjIaIBUvTPtPH6fFCSpOedQ9N1u1y+i34zX6XBjiR2LIEeY5CoSNzG6O6gjIMNoLdfWleiA013R8zpCI7ldk9UJEC5Y3ccz2QYdGgwqPhPSEd5v+pqBjzC8WSmvUjjH+wsjAILu6/v4n2bB87Tm7h1ax3w3Mn8ge6EcmKSp5AuscZm4becfOo9VVyRGFKd24GZi86Ol21ujejHvQZyoYATh151oE4R21EOhMjugZeSyuBbJm7ZOG4HvvvGeyRrFfgXlKKIC/2gZ2WjvZ5T1W54aGpA3FVDLSbuOzjZYLJfxwxrXFk0H5iSXBBqXtmUnO60QGHImQ03D3XrR65xAfPXj4HFmJyAk0oDcwryjAQnvTWKp1sOedIpRYGVKc0wl/tJiHQ4VqVfy/qQlzQCj8byBljdB0fq5a5pSWzT5nLIPcJXfvUwmJk0Elyckzmy32GtI4XHIRvW34gAgtNPmOa6/SPls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58cd78b-6748-43de-3530-08de5e3cfdac
X-MS-Exchange-CrossTenant-AuthSource: CH5PR10MB997695.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 07:15:18.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JiVb88ytkXz4a7TmSxXz5fqcFwR08wMF6VAZvoxfUL8fBFetu2a0ixYGTZKt0Dlqfm8Hj1O10SjCDZKysKGC1rg7YW8gEERUTVpudIx0v5imXhCVr6i60M/8WrL8uKU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280057
X-Proofpoint-GUID: vOjNBdZKkKKSdZhNgeWIf_jNtiivRBwD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA1OCBTYWx0ZWRfX0pwcNgMfm0HM
 HtxgEpLGfH6adaLPxGi7FVoUczsWXV0ao3cZahRrWj4hnzIHbNyeUvxEwtqIIKLL3Cnr+4FgjMO
 w4blvOpqn0Dxlgyfv4U3xu1ebN6gwneWkNW7nUUp8wyQCKL1/qDE1kubtPbeVHBHU/sbGah3uP8
 Slls1CDnOoLO3ghrhLj7lNbCgHBTxz/DB5TW7RIW2mF8Sf8Fx1iqvZKLoEdqitGW6HBoGtG06aT
 C+vqnDAC1iC6po+qbqOYMhrKrN6DrhLgPG3H5uFCCjLd1ATYMgqX13lXg+Q3k6VFPHcjPe8s+Kp
 OMIXTz3hRyoZgYO/TkBIZXPhAVWO/rI8zbStWedpPR3sFRD7GKRyGUZBe5QG54Z1fiwi0k+VVw9
 sU47Zt+f3RzIvyYy1keQ/6yG+F8vCsopR+hod5Yl9TvYGqMCbTlCesHBGw8pkDXF+s8o2jlOSBG
 mCRQ7l4PwIKSsDYrqtw==
X-Proofpoint-ORIG-GUID: vOjNBdZKkKKSdZhNgeWIf_jNtiivRBwD
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=6979b78b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=DHSlhPdJ_UiVinv-nWsA:9 a=QEXdDO2ut3YA:10

Hi,
On 28/01/26 12:19, Harshit Mogalapalli wrote:
> spi->irq from request_threaded_irq() not released when
> iio_device_register() fails. Add an return value check and jump to a
> common error handler when iio_device_register() fails.
> 
> Fixes: 9a4936dc89a3 ("staging:iio:accel:sca3000 Tidy up probe order to avoid a race.")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

Missed informing about how it was found.

Only compile tested, found with smatch.

>   drivers/iio/accel/sca3000.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index bfa8a3f5a92f..9ef4d6e27466 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1489,7 +1489,11 @@ static int sca3000_probe(struct spi_device *spi)
>   	if (ret)
>   		goto error_free_irq;
>   
> -	return iio_device_register(indio_dev);
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_free_irq;
> +
> +	return 0;
>   
>   error_free_irq:
>   	if (spi->irq)

