Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732E2045AD;
	Fri, 20 Feb 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587922; cv=fail; b=TcGwALTBbgQRQ3Zxw7E+5ONzLOPFmCUPyKdcEBTHLsA/d8ddgmMTV3Ut0P8NaEg1qJcvvszjXN5SGGc2X5uh7nILGMsPLm9oCmulZBR1rgyysEBxmmLueisNhmj935z2dXv47xhjw4Abp0sdgpT2UBZ3NOnhX/V2bonVObDkzcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587922; c=relaxed/simple;
	bh=JXJfEF++uy8Q5PTIbSDeti6aifDKJ8HL4FC6ux/tvxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SklBpVMuQFX54bxhNCW/vswpX2sFj2dSVcA3xldVH9HJUZUSclRfQH8nf1InhlFY/u9pcTmImneDjmGEWAnXLRz1LsxNEBY18FzGMee3i0uiiBQsrAtprybW47Blp5xDipvSqdAA5AaJs1xaEdDqLGnosugx1dP1jz56AjB9OlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L0ZjKepk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iXPXS4tb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L0ZjKepk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iXPXS4tb"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JLgAK72705737;
	Fri, 20 Feb 2026 11:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=coV0p9YV3s7W8gurDJGjTp1/D9uTqvmFjFzDhMPlGmg=; b=
	L0ZjKepkl9Y0bKkZif/2A7MkNHZk8oKwMzg4o2wqC97HieCeC8T8kD8DvXqHEekA
	GHuprh21hi4yol4TyFijw0ae/RAkXt8ENW/7r/EyxR7N0sScKic+8n3thHheuF+e
	GfrWAC7dpgvg3mtRWGjWhIxGsm6pbGtfPa68d3rcZAc340C3m21eUEwUqPPiI8OL
	kUK6cv0WRbj7A247CeZfNDqroKPAfJZeBcGwSWsKWOEYJTNjbsW7E5eUhXSOV2gl
	sz9HhLYkrjaL43Dvo3JWvLKeS/mRutRTzoSKyyXtoLLl2vINZGG1vGqXchOo7afr
	0VQbZi2cmoG/px3k59BlEw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj3t97nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 11:45:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61K98lH7017262;
	Fri, 20 Feb 2026 11:45:12 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ce4ay5vxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 11:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1rtsXGVXllMm/XuAoQUpqjKgm8D9efqPxQ4zZffY0FtmqfeAfcPF871sDfOsGveKrWwTM2GzDsxXSi9utNQNiG71UhnOjpXmBi0R+4DiZFViriu49W/qVjqnLLrVf1u47LDLZeGUcRuAYNvR2PA1bQyEPjhaPVeUrZqEBMbuDgUOVqF65VX2WeNWEUDbxF1clxv55X0hwL2f0+KRANAF/cfQANJsSqFLLvbu5imrxfG05Gt6Q2jNToZt0goSeOYZHInFz+DN2oQaNQHN4E/6T4jAl3C2M8qewJ65Qk2jDJH82XppZ5t137gl5sRwuT5P4UEcahiA6pxiipouEGH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coV0p9YV3s7W8gurDJGjTp1/D9uTqvmFjFzDhMPlGmg=;
 b=BrMoxwPZZt12pf1+mXMGeDz+EyOwvsWqvSqkOQG7Z3/71w5QH2YKntpMLwZP3Eo+8M3lo0J10uymQoJJrXBSyFtEO2XcGt3OGVQedq8QSsyuiAz7y/T6Wr/A4k/naxzRr+xMuaYI+3t9xS1KCB8QH3C6kBQh1/4XxKHnopYhb+WK5S+11ARr1ZKz+TdsiIOXj+psXOUgvobyJvHvIMoJd6bUfsIuQmhHCHHkvRhPBDNUk24/+KWjQ3blnCL7gHYjm/7gkPmfxVOZpfM1Osxwycj7uoV2sRC2zNj0dbOApCKMdxX9jS0kVDCSNU69r4nTWiAqHbm07WqQg1meCYOpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coV0p9YV3s7W8gurDJGjTp1/D9uTqvmFjFzDhMPlGmg=;
 b=iXPXS4tbOi1jlU2FnG5NLVDETZOs0hicqJoh306mdivwvE92cUZ5rjG4304rQS9N8rp5txebq+VtHBX5XE6lf9RHoDjS/R09aiBV9OHqQI1//lcaQnTs7BC7QzC5qC3UBFD6mP6mwqf9LKmlzHaCOkZfMSzmWwC12V8cVgzUq1U=
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6) by SN4PR10MB5591.namprd10.prod.outlook.com
 (2603:10b6:806:206::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 11:45:09 +0000
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83]) by CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83%3]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 11:45:09 +0000
Message-ID: <a85cc647-16ec-4b02-babf-0129e300a852@oracle.com>
Date: Fri, 20 Feb 2026 17:15:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2] iio: sca3000: simplify with
 spi_get_device_match_data()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260216102453.1063866-1-harshit.m.mogalapalli@oracle.com>
 <20260220105001.7fce6c3c@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260220105001.7fce6c3c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0135.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::14) To CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH5PR10MB997695:EE_|SN4PR10MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: cae6af9c-cfe4-4e22-596b-08de70758013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGNsUXBZYnV5Mm15aXFWb0drTE1aUkF2aXFlL3JKVlhPYjBTMmh0c0tyZUlr?=
 =?utf-8?B?UFFKUnFrRTg3ZTNlWkVUODZCZlBsbnpncE9vMlJqMThlNklwSHZDS2JmSENt?=
 =?utf-8?B?ZlBSbGpNMGk4M3RKTDNsdjRvZGpXR0V5ZE1FbGFaTDVXNXBWYWRPS1hqQloy?=
 =?utf-8?B?b0xWSDR1VHpBa2RzV2JCRzcvOWlQblJ3MTZhc0ZMbGJyaWRxakMvNXNKYXls?=
 =?utf-8?B?MGtrZU43b3ZKRnBMNG56emNZWm9ldFFaYnh2RHQrM1UvaXhDZVZDYWVRY0Vi?=
 =?utf-8?B?aWt4RmxwM0Z2NHVOYkR1bTlEaG5OVkFvSmVhaW9GTUpEUnErR2hJYktJckY0?=
 =?utf-8?B?UjFHK2lIcS85Ylh1cjFnMXBhQTJBN0s0TDdMTEF2aGE4VHpEQjUwcFVPNEhV?=
 =?utf-8?B?RlNQdlUrSjhia3lEYlpmT24wVGlSR05FdFNVL0JkOWEyZUxNNGcwOVFBVnlG?=
 =?utf-8?B?RGtweHIzemVKMGIyNkF0M0pvSnYvUCtBb2lmdGM0YjNxeXFhR3NTbDdEQm1X?=
 =?utf-8?B?bkRzZC92VXVyYzlJSHRpSHZTS3h3MVVYMXNsMFJibGlXOTNSS2IzVFBxWjUy?=
 =?utf-8?B?M0pubHoyZlp1b1I5VG5iYXdHYkx1OHpxSjJRUlViSjVuZWtQbGxaSVJVNmJq?=
 =?utf-8?B?YXErbmVaMmszZXNJVzAvRkpVQ2JVK0NBZm5WTUZCKzE5SWJzQXlabEc4NFph?=
 =?utf-8?B?b0p3NXFqSDdUdGpEV3pTYTg3a1JtNEFWb2srUzFlVWxoS1Vja2RKYlN2ak9D?=
 =?utf-8?B?T3ozY3ZoSHROUFhsN0pxR25ja0YzWWZ2bFBTWm9ENXpFcVFreWR0U2pEaDZ0?=
 =?utf-8?B?dG44ZVRObUN3d3RXdkxPNTRhU3dDWGRKb2Uva0ZxMjN2cml4L1ZEY2I5bHRk?=
 =?utf-8?B?eHUybFdJYVY0Q3FlTTdwMklpMDZTSTRMeVJWS2UxWFBZcktEclhwRUlabHhB?=
 =?utf-8?B?VkkvMjRheHRDQ2p1bFk3OUpVZHVVZnNMTGRrek5pejdPQk15bVNhaEpqYzdY?=
 =?utf-8?B?VlBiZ0pFbWM4NHprYTRMN0ZtMzhBQ3NLRlR5VUt4VDBEdzZhY00vQ21pQ01m?=
 =?utf-8?B?RnRHTEtFdUdXMTI0NGYyTDNmRFQ5TzZiRnZZUW9DQmtBdGlONWhBQzNLMmFp?=
 =?utf-8?B?VWNJUlZnYnlvS0FTY2xTUlB5a3JiV3RZbVpZQzhMbWZWdkpza1gvUzlaTktJ?=
 =?utf-8?B?aW52MHlWSWdERytDWmo3OGFzYXZiem45Y1ZQcnJiTE0vanNyQ2Q0VHczN2NK?=
 =?utf-8?B?RDlBdEVub3BUcDNoTEh0NktFaEUxbFFkMzBlOEJIbisrNDBsUmFTVDM3Y1Va?=
 =?utf-8?B?U09GRVRqMVBzYlNrTXRGckUwMFNqclZDbXFqUy96WHBrYVBqQTZCSlF1K3Fn?=
 =?utf-8?B?TG1QNjRlRU9TcEp4NWptYkt0YlE5QXBXMmcxVEcvYzMxODArZXNPMHoxUy9M?=
 =?utf-8?B?cEY5MXRoUUFRbzZFUjZyUlQrTGZTNnhua1Zya1NwT09jV0dONG9HSmN2aDZV?=
 =?utf-8?B?RVVxYXUwUDFaUlNKQURrQjN6RjNIc2Vld1RmSFhWMUpWaVBBc3N1UlFqa25S?=
 =?utf-8?B?YWI4Rm96RWJxRG9jdEE3ZDJVMVVNK2M3NHFTVmM4K3BBVmEwT1k3UElHUEl3?=
 =?utf-8?B?UlV5dFM1R0N3eDF1dnA5bENqeHl1N0FNUUVjVy82RW5OYlFMSnlOQkczU01l?=
 =?utf-8?B?ckRnMXVYZTBzZUpPQm1SanBPWmJ2OTlIVkV2VzRNc3c1LzByd0oxRGdTREkz?=
 =?utf-8?B?ajBObi8xcUZvdlhtbDJ6WEZLN0J6WVJrQUxTWWpsSG40ZkVFYW95ZGF2M1Fv?=
 =?utf-8?B?cEUwalJIa2NadnhlV1R3M1hqeTkxZUpvVlNlNzNHeDVzRnFkSW00OXhVa1Vl?=
 =?utf-8?B?RDczM0JhL0pzN1d5bmw3OVhyUVhEYVRndjh2VXBQWHc5UFN1OFdpOGhaMDVX?=
 =?utf-8?B?QzVjd2VFSXlIV2pBREhxZUluYm9Ra0x2eDVjMWxIZzdiMGRmMlFpMVNXY21a?=
 =?utf-8?B?bmZLMTZ0bnpKbWpIaUMxVGxHdGo2RFdtc1hLVk9TTDU2K0hqZmhQc0hJejN3?=
 =?utf-8?B?aVRUZTVPTjBiOWthOXNRWmpQMmF6OEFBNkh5akN2ZVF0YWhhTjRzbmp6Y0FE?=
 =?utf-8?Q?K0lnwaLpa5XGEta8i4Hs5rg8v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH5PR10MB997695.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEFLN2w4ZVVYbWhmcTZQUkN2V3V6cjRINUtsb1Z1UHU0K21Oc2dnN0ZWTWxV?=
 =?utf-8?B?djVGc29oVkM0TEhFc3h0TGVWclVRYklDei9VN1RQWnhJSHJycVN5QlNNQTlv?=
 =?utf-8?B?ZGJqMTQyOCtRWkdSQTYwRmt2NVFNczJZQnkwY3ZSVG02NVJHSGJhdW1rOEVk?=
 =?utf-8?B?RDg2NVpCcFJwZ3hXMGxIWURjb1ZLVnhDSDNlcUpjRTRUbSs5NE1BVWI5OFRI?=
 =?utf-8?B?Q0I5a0JDVkJBNm1qc09kME5WZXpsLzY1cDc1VUl2RUJrWHBHald2WkFITy83?=
 =?utf-8?B?OEFraGtsaWRaZm5ZRjJ6T1ZVWFUweVYwZmgxQWJBWEtFcllKcnVEbHVTYVk5?=
 =?utf-8?B?MTFMNnZyUHJ2ZHlKRDFLTlBQSTZKUTZQY1cwUE1CaWtnZDBqNXlQcTlsRlhQ?=
 =?utf-8?B?LzVwYzVpdGViK2RKdkRwUkVmV3VyUHB2ck1pVjlPdndWcjdVQTdFVVNJeEVJ?=
 =?utf-8?B?N1BYc2xWWjhaVFdjZDY2RHVoWEdEbVRJckJzYzkzSFZ2M0Z2Tm5QeDhKOFlP?=
 =?utf-8?B?L3JOYmNJUXRHYkIyQUlmNUN3aG1DbTRTMTVWQ2o5blB6THExOTJmc3ZwT1E4?=
 =?utf-8?B?RUdCSFZzdlVuMkd5enpCUjdkTjgyd3dEd24wdmF2RVFOMExuV3Fhc0gzbmZs?=
 =?utf-8?B?aFovYldLTlF1VElXMHI2Z1JNOVlPVkN6UDY3N1lnRU5rYnU2dm1wVWltWnVo?=
 =?utf-8?B?Skx3djhGR0RSRUVINzRSWGpaaFprOTlvNG02cit6RU1MMGlLUUxFbTNwdFl3?=
 =?utf-8?B?TTh6M1MrR2pYcFVPNVR6Tll2NWVnTThlSU9zcVE3SWtObi9YaFJsNXFqNHFF?=
 =?utf-8?B?ajFuQk4xcTUxU0FIanc3UFp3VmFrcEdLdWJkc2t1dVhYVUZHTUtLV1ZwWnZI?=
 =?utf-8?B?dGxQKzAyT1V3dmxucjBSQ3JGNGNFRFJSY0hzZk90VGhQZVZSYkdBUVl0cDMz?=
 =?utf-8?B?RXl1bG9VVzkydHhJQllScVJaWCtzVm5WVk5hV3BUL3Vmd1VIc3NwS0xvQXZz?=
 =?utf-8?B?cFlyWkh0K1NaSG9DcnRNdXNvOCtNNkdOeEdsQmVKRENBMWplbkVqR2J2bXR6?=
 =?utf-8?B?YzhmYUx3R1JlMytaaDZVZWVkaXdYRUtVa3JtWGcyQzZJL1ltSmNsekN5dGkv?=
 =?utf-8?B?TVBvQ1BnYlJGRGNQUzU1bnNIWEJLTjlzdVU5MjI5YzBlVVZKYWk5R2dBSG9K?=
 =?utf-8?B?ZlVHSytjYm5wZVJrR01KNTRvdGZFTW0yR1BLTHZZTTlueHIvT0lSRjZpYUR0?=
 =?utf-8?B?ZmtWeUdOVmc0WkJ0RWZFQ1BzSWs2OU53OEh6cFQwVEJnYm5ySUoyRVFweXd3?=
 =?utf-8?B?bnY1RFd5UjBiY1VJeGRCQU42b0JOS0JVK0tPMjg2RnRIQy9LS3k1YTdPR3p0?=
 =?utf-8?B?blZGa0dZT20zTkxQTUY5QkgyTWozL3BuTE5wdGEvRzBvTWZXekxUeWs4SVFW?=
 =?utf-8?B?bm9lQXRBaDM4SU9pU0I4angwaXREK3VQVHAvQSt0QVVZVzlPRzFQMkN4R0R4?=
 =?utf-8?B?SS82dmo0ME1yaEQ1T3ZPZi9nd2FObmxicVRNSkJCSGZ4U1BRZnByUkdkNldD?=
 =?utf-8?B?cjJEVmZWa2VtN1U5dkZVZ2oxRytaaVBTc3MxYmw4L3ZXTXlWY1loeStGZk80?=
 =?utf-8?B?Yy9Pei9yMWtENFpVN2pUU3VFRDJ0aXZyWmFEdy9maEtRZWNVM2dMWDRkTW53?=
 =?utf-8?B?c0pQWTcweGUyM1BLSVQ1M05JTmxzdE1nQU9rN2pETmo4YzNRd3QxTWJ5STRC?=
 =?utf-8?B?VHN5OWNFMDNSVU9FUUl5L25EU21rbCtSVGgrOGxRZlpSZnUyUitFVWhjZHhH?=
 =?utf-8?B?Y0hYek5YT255WVNwOEg2M0o3SStZb1FEdjQzaFJJSnRqRjFSdWYzM3NOWHNG?=
 =?utf-8?B?cTNXREFBZ2p1Njk3VFQ5NEtwb1dZNzl1RU1xcCtYcTZtSGxFT3RwMmxzcmdC?=
 =?utf-8?B?VlJoYnFmWHNJL21Mamlwd01iYkZJbTI2RzFrcWxWWGZUajhIRDNQREYrMTZX?=
 =?utf-8?B?TnBRc2gyY0ZQcFFNRysyUFdvVnBPcG9HclZIUFE5VDJheUpWbVR1TFR6dzJV?=
 =?utf-8?B?c0ZkOXJja2ViVytBaFpDRW1sQ25nTXlua1Q2bk9jR2hWZDhHbEwyNy9Ob1dl?=
 =?utf-8?B?ODVqdVlsekU2MGNMYXhlUDlhR2oxa21WZDZMVm5ZUll3NXdWR2lubjlJbVdY?=
 =?utf-8?B?M2dxSlBZSXdoVW1CbTFqeC9XYWltNUR3Q09LMUdwUysyUGJLWkhsc2d3SnFI?=
 =?utf-8?B?TVE3TUREeXEwdlVsNmR3N0VWcW9FT3RoTTZTYTJqVk4zSm1TMm1ERlI3cEt2?=
 =?utf-8?B?Q09DQlUyenJxaXVXUlN4YUNpanBWbXJDendiSGRKSklnbUJpbzR4TVltc1FR?=
 =?utf-8?Q?eomSHnvS2Y8kvGcpw+bIFsKQ9MGTKp+yMmvc2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cKbwHLjUmVhO4FkTMrwC8JDmvtGJOUXC1jFTgI1d3Wf29J6OmRew11kbQIyNXD3hmiOmQYglBt+cWi6l7F+IrmlEQdkv8gvTdKvEus44/Zh3AaViVwSKF44Ve0+2V8SqZVaWSXXcpGEIhmak9SfIMkuABXbEOGu+2bLLgm6EsDB5wzkW4+4dH2BVUzr/d4t+/O+kzByJUGm6dplrSShGtXUbzd4S6mdBVJRsqLdS0GWcgYc7yk9eeSjwfaoto/Hh07FHT3nLIp6bD4iXnzf5Agwjh3CgosiIN6drRQcWfI+knDI3IcxS8Ayw9pUqFVgb6Nqr631R70bFXHqAx16uCq10YqfftgK/cKPX7gapOrV1w7Zo777ibTOSSdpMkAAnnRR0rU7hrEf8dkBd/kwKH2Zk9xZjBSfZu9ZJ4ld1LqyiDx9Nmkb20KdD40IB3LfPhVaMWVqmimlBIjPRpspY00LUpijBbJX4ZH1uGLGMDw5OnVtsf3Ip8Dr1tnc1v6CL+vjg1SZlkTRLX6BuY+TLsAmn9g/+48+Uj4lO8uXl/l+GupN+eTH7REzfFRF5oncvihVqtKaByNqdglOYmiM4N/Y6uTm04CKNXTMfsrTVZ2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae6af9c-cfe4-4e22-596b-08de70758013
X-MS-Exchange-CrossTenant-AuthSource: CH5PR10MB997695.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 11:45:09.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XB3n0XkO2yp7dMP+TeJKdhwIxStL5DAKOR8v+QQw/tB/6hU7b0SxXT1O3N38yLqOjKkQsNrOEnlSwXHk5Ajq071Dxj+BUrpnkYJy4a+uvmRlsntvPCRNX3/V7PWat3c7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEwMiBTYWx0ZWRfXy+mT+27B2ovB
 nggOQDbHrB9WysIKDIwb/NkZWux0fC53wBokOG6NqfFMRy5CvPY1Na0aAnEhC5LN6/Ly29/E4on
 YmhM2vN6F9yMmYeYyJFmlhZT57pdtIxnb16xBxYXAprLPGTrJf0v2GAYKaO+l2zHAYe6jVu/K7p
 NJmnqfews7ap1037p28IYKF2huwJQDS0VgpzJ4ZZNaOjYXtwT1y4ssIe4MyDjzOaN6OUJNOuDUq
 kTF0xZgGnQl02ruMrMHo+b2G6vT9ocUhN3t2CkUu58LC5A82nt4D3sZx+b/K6K3nhhEIftraF90
 E3pAUzXsoGu/ceti5CK5m1uiW2vmLMFWAOl9ALzDQprUaxK9diuluP4Gy8JAZxsON3CjPdQ39ia
 vHEIcSjryAaoRDBDKgZozxhxa3c3Ae1mNpgrKVPkLuVAumxG1VyVkm2iHkSjSUwC4vluSTZJASS
 2tpTq5GPvi2De74H6uA==
X-Proofpoint-ORIG-GUID: d8FlZNgpfRXQoU4TkGObkEzKLwadyK9E
X-Authority-Analysis: v=2.4 cv=b/S/I9Gx c=1 sm=1 tr=0 ts=69984949 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=IpJZQVW2AAAA:8 a=QyXUC8HyAAAA:8 a=ABrRVVKPhW7_X5BwGgYA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: d8FlZNgpfRXQoU4TkGObkEzKLwadyK9E

Hi Jonathan,

On 20/02/26 16:21, Jonathan Cameron wrote:
> On Mon, 16 Feb 2026 02:24:48 -0800
> Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> 
>> Refactor each sca3000 variant with it's own chip_info struct, update the
>> sca3000_probe() to use spi_get_device_match_data().
>>
>> Suggested-by: David Lechner <dlechner@baylibre.com>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> I made a couple of white space tweaks whilst applying.
> 
> Applied to the testing branch of iio.git.  There was quite
> a bit of fuzz (line changes) but was all straight forward.
> 

Oh, sorry for that. Maybe because these patches: 
https://lore.kernel.org/all/20260205195845.4e108117@jic23-huawei/ were 
not present ?

I don't see them here: 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/drivers/iio/accel/sca3000.c?h=testing 
, so asking.

This patch might have applied cleaner with the above series applied.


> thanks,
> 
> Jonathan
> 
>> ---
>> Only compile tested.
>>
>> v1->v2: Andy suggested we drop a NULL check on
>> spi_get_device_match_data() failure. Also added Andy's RB.
>> ---
>>   drivers/iio/accel/sca3000.c | 127 +++++++++++++++++-------------------
>>   1 file changed, 59 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
>> index d4c117f54a07..eeb313056259 100644
>> --- a/drivers/iio/accel/sca3000.c
>> +++ b/drivers/iio/accel/sca3000.c
>> @@ -172,6 +172,7 @@ struct sca3000_state {
>>   
...
>>   
>>   static const struct spi_device_id sca3000_id[] = {
>> -	{"sca3000_d01", d01},
>> -	{"sca3000_e02", e02},
>> -	{"sca3000_e04", e04},
>> -	{"sca3000_e05", e05},
>> +	{"sca3000_d01", (kernel_ulong_t)&sca3000_chip_info_d01},
>> +	{"sca3000_e02", (kernel_ulong_t)&sca3000_chip_info_e02},
>> +	{"sca3000_e04", (kernel_ulong_t)&sca3000_chip_info_e04},
>> +	{"sca3000_e05", (kernel_ulong_t)&sca3000_chip_info_e05},
> Similarly let's add some spaces to these.
> 

I didn't add the space mostly because there were not there before. Will 
check for other similar drivers next time, thanks a lot for dealing with 
them by yourself.


Thanks,
Harshit

>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(spi, sca3000_id);
> 

