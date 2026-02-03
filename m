Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2C831196C;
	Tue,  3 Feb 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134424; cv=fail; b=DwSVWvqfaFLHHxvb6MkbETc3PX4dezZv95oqlVRsFUVRFZQG9KUQmO1p/SBl8u0VhRemklxLlkFOTBHeO6VMa46TngHk/hJrkT4TZYuPmX7IotxDgzDKa6/h5KQo99nfWLFbE1xcR4ZpvS5CFAvwl+OZvY26WBTMRwlmI9HRtH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134424; c=relaxed/simple;
	bh=4gcM0S5jYluTfBPAcPUciu4zdTdUPyNgkRkjyGsCDD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oioQ314pPPeDJzBnnPY0Eic6JETV2Pnur0BpGh/7olpbBs+kpCU0R/crwqlqkKVXT3lsu0CDt75/3gBR0ETZ4sL06SokFwHj2BZb1TA2ns1bJZic0Ib86gTP4ccPyvy8J3Uw8dTxQlcQQ2arJ25jZuyGzQNLiTVlJhNQu01IWxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BCrBZXuu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nZh8XFPf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCrBZXuu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nZh8XFPf"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vUXp3817654;
	Tue, 3 Feb 2026 16:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=95hCLyAZGTc0RpIrIWGPl+dwqZ3PXBCjbfIXUG1rIHw=; b=
	BCrBZXuutvV/vHsvvfqeoaQ0Lf9kWVcZqoQHmnvc8A8dKHWGFlWhZPVCnoQBfiKA
	XThZcCPvgzI61UkiQkvUbYD8f21O5+bwHFpp3Y0/J3jG7E/4Za0STReTdXAsSFXs
	6SQyC0egXYasYV4WBnZIOrx0axI/1ULwmZzAiIkP32jDNUhqVrz6i/y7xIXszfDj
	IVqFmzfhbyybQ5sC9iDq5ZdIuF7es+zhSbJ4wJq+WCCnLv7p01eYOljI/4Ship+j
	YDrJaLhWWmNmuUiTG+yZGPnbGOBGKlR/JGkNt/sS3ts3Af92XbQkehlE+mkWAehF
	FkmJQiZROItaPiueWonp9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au64aw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 16:00:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613F4MY6018768;
	Tue, 3 Feb 2026 16:00:15 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186mhycf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 16:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t74mTWIouo6xoSwoyH3MeQsQCkwh2cU3W2oBwHFNpAKXBeyswD9HuJx18SP8ImMTeXbAZ3WgWKQlKzuXwT6s+vazePkyLTAX4TNZWRbZgflAxgdtXscLSIacWfanHtChtsZw5pQ3uPqs4q4dGeubcdzdaCB5jU3KhqyPi9oRM39fI+DUaXPsLbbyjVrgyIFEFxuKFaQBoN3H65OUZxkn6eyYZO407hVG8HKGvtsVrUyLdnijYytd6Y/BfSyhVgFIB2TUK3sUwhgqWJaEdh+7EPMkSZK9Si3pbh1nnzh6blIyRnD8tX0ZgkcOmGny5O2MUBNVuaNUL+4Q5GdlxhrQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95hCLyAZGTc0RpIrIWGPl+dwqZ3PXBCjbfIXUG1rIHw=;
 b=QdtMsrIkZtMyYdElKzg5GvkGQHfy0qp97hdOhJ4PytHPULM9KBknLCjWNEv0XZyO5WKV4EPclhhF5jiKLJKRXVjTVXy9CBU+Mvd3ujBuXQEQ24YHchIffcyeoEAXbaj1XJ+duY8Danm2P7db+Q8vquI2stX+rMLTsA/+0cwmMU+20t3swOiquYMBP9zGTpm6rXZastS0l3BE86oZGQM4t8Qf8YZJjBnbHjJ0CQ17b9KS+yr9crKbgQmlqx4y5Li8PlaYLj5Shx410Y70QsOJ3z3RLhhO0GhVhxAA8BUX6A+cYsmiAG3Rvhj2yRQj1q3s1nPNZuj4gPXluyRvU5opBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95hCLyAZGTc0RpIrIWGPl+dwqZ3PXBCjbfIXUG1rIHw=;
 b=nZh8XFPf7Y2eboz8HM0ha9j5yzbaawXPCKLBIgNw32EtiHImHWzTQowTjAyBpNZlhBVNXXUkc9cvpWbPAV242H4bKBZ/QmdM9f/7BXdWBlm0FjGNdqdma5FV4kO4eXZFw9tZUbAoOz0FMX3vdAqz9MQDBaORal85lrn5oR+i4Ik=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:00:02 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:00:02 +0000
Message-ID: <21c1ae56-a3c6-427f-a85b-9e9c33062e10@oracle.com>
Date: Tue, 3 Feb 2026 21:29:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 next 4/6] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, David Lechner <dlechner@baylibe.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-5-harshit.m.mogalapalli@oracle.com>
 <aYITRNfRgK475ck-@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYITRNfRgK475ck-@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 8234ff62-45fc-4d2f-36fe-08de633d4a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDE1N0hJemo2NmlFRHl6V0kxWld1VzMrM0N5YXJJM3JnSGZZM2ZpT2l1cXZl?=
 =?utf-8?B?aHU2cG9NdDNhT29QcTg3bk56QjZtTkZ4NmJ5Q2NQUitGc1p4bDNGRXB3eDdr?=
 =?utf-8?B?TDZmWWQ3cnlWMUpNMHFCSU5WT3RBaGpCazFqOXV6SjEzblR0b3RtMXlHR04x?=
 =?utf-8?B?eTVDWWtrYzBJZ2U5eVpzcEhIV01zSVhjdS9xZUZJYzFrRUxSaWZiZTRvRWhQ?=
 =?utf-8?B?RVpxWVl4L3hRelVsakV1ME1QeGRTMW5kbG5GTmhVZWVKdUtIMDRqUDlUdGJW?=
 =?utf-8?B?TFNnUi9GbWhRekZTL0drYkQ5d0dEOU1uV0V6ZjRnc2dVclRCWmM1MDJUUTNG?=
 =?utf-8?B?eXFQTUZJeHpVZkh3bnd6QU9YcURVVFd3Y1VodWpKWkRLOWRaSFZFcXFXL1Vx?=
 =?utf-8?B?alFoN2tnQlYxQ0ZOMkd4UFY3ejYvdWw4NFZTcWsvZGpScWFiVlFuUGNyVFhQ?=
 =?utf-8?B?UGlJeEsrdUc2bzQ2bjdPeGt6NE0rSUZNZ0phQ0pnT0FDdDd0U3lJVE5RWnBk?=
 =?utf-8?B?Um1WNTNoR25iNnJVc3IwL1ArWWFuY0MxRFhCWWVNcmRkZFIxSGJucjdXUHl5?=
 =?utf-8?B?Skc4U0lycHR3K0RXUnBsSmRlN2J4dCtGOTdGS2YwMjAwbnVRUEdHYm5xSHhy?=
 =?utf-8?B?anoyVDNCR2FtVXkwVmdxSDVyd29EWW5TVXpJVGI2citvd2hqWEEranJiV1E3?=
 =?utf-8?B?YkxJa0tDUng5ekRPcnhiUCtvZGhQMDhJSDZnTkRBUmM0elAyVlRjbHZ3NlZm?=
 =?utf-8?B?K3FmYjl6dFQ5SSsrZkdKSnNLSFdKeG9QSlpxRnBocllhbmpKdi93YlNlcks1?=
 =?utf-8?B?ME82ZlQ0VU1qNmhWb3UrdmlCaWlIbHBsVG4vdi9DbFhEcW9PT2Z5VHdhem9S?=
 =?utf-8?B?MlRoQnZOYXdpY2RiZnlTeUhtUHU5S2ladTg0V2VYcWh1dGczLzVQZWJNOUpz?=
 =?utf-8?B?UFRQYmpmeDVhaGo1MHV3UFN3UVNnZUl0YlorWGNRR3hZbTdKdDBEUU1zdXdY?=
 =?utf-8?B?M1J1QlhkRTNsaHdTZEFsSEF5K0E1VEM3QkJUOVhXcWtjQjFISklyMDJtMDA2?=
 =?utf-8?B?bXFPMTRTWUJOU2EwMzI5ZDlJUUFaS0p1dzdwRkVETTNGOXNzUVpTRDlJUTBs?=
 =?utf-8?B?Q2JmZTN3U2NPVXJIVmRiY2p4R3c0VnJ3OUlQR1REalB5b2VJODJiRXYyU0Yz?=
 =?utf-8?B?bGVlcU1FeGhVSjBLT2x5TURoUHRkWStnQm9LbTNOQ05FdUZ6dmMzQWNMeXpP?=
 =?utf-8?B?UnJkbDAvVTFGdCt4QURXMDBJTmx6dVlETzM2Vy9GL0FZRUJJc21DMDdlQ1dS?=
 =?utf-8?B?UitWamVOL3NOZ3FzS3dtTzJLY0xPR2FRTkg1aEJVTFgyNitEMEtVay9QTVY1?=
 =?utf-8?B?NFh4eUUrb05SK1lDV2FDUWZhTVdQZzlBbkE3T2RqeUc5L1RnbWNrV1RLd2Nj?=
 =?utf-8?B?dVBEajdyeGRiTkkzR1NmRXdnUFBXMXI2WUd1QzV0RHBPOXNITFI1T0ZtRmxu?=
 =?utf-8?B?RmxrYVZPSzREV2pYeEhHQk9jMjJmREpiLzVocHlEUEN3alIwNy8ybkJNdFVN?=
 =?utf-8?B?VVdIdVUySmFNS3pzU2M2TGsvSm9WaUFuUFVaZGQ0KysvNlF4WEVEMmtjR1NW?=
 =?utf-8?B?MWVJTDFjMHJKa3BGTlB0R2QrQWZWTWJ4QlNzV1dMTTd2VHdXeUUwTUFZWXNL?=
 =?utf-8?B?MkN4M0lZTUE4SXJzN2JSY2VEbkdsVlQ0WEV1RnNQaWZ6Z2lOdnpzQnF2dVQ0?=
 =?utf-8?B?bXdQUnZva3NTVWVJV3hYRHNGRVc5RjNCTTJwenllaktTSXNNWC90S2dBV3lO?=
 =?utf-8?B?SkJ3NEdyY2VrUnVRY0xDZlFycGxLNzhSRmI5a0NPQkorbWZseUxwK1AzeE0z?=
 =?utf-8?B?bWZOaW5jUnJ5SmErQSsxVEYxdXM2WkhhL2dlbDdWbHlJdjZKTXlwcHQ3TEYx?=
 =?utf-8?B?SnM5c1NUQVo3SEd4UUhqVkxaNHcxeHNMQkhXelp6aHNwUDdPZFFkUWdNSVJS?=
 =?utf-8?B?Z3R5ckp1elBHaW1acENpWm1tSXNLNHJtQnZoL2JJaS82VUxVdFNBYVRWVDNh?=
 =?utf-8?B?WjUvdHJoa3FHODJ5S2liMjZUbnpINGY2bitPU1RIUXFZSGY1bVFMSURnRzlN?=
 =?utf-8?Q?k5Dw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tzc5eG1NQUZZdms3VjBCcjhISGJNUmlUQ0VoZmU2QjlRYlZPZ2Q5MTJBQWk3?=
 =?utf-8?B?R0ZOTzNSMGFuczBnYlpiTVpWRmNmVTFkWmpVV013elJyYWN5VGxEcVJNSW9v?=
 =?utf-8?B?TFV3cVFMRGpsc09YdHpaVnNOb2dndndlb1lhUnVjaTM1eVJ1YkhSMXFOZHA5?=
 =?utf-8?B?cndhRmM4RmdtRGRVdUtRcC92MTRaNk4va1NlNy92bWI1WXhzaFh6Wmt1T0F3?=
 =?utf-8?B?OHl5clhiOTl0Rzc3c0ZKaUMrbEtSQ2tETlZkQ1FqU3BCOWZXTkhCRG96M0Zh?=
 =?utf-8?B?SVJySGdqWmExbFFleWJtaWwzOURzR1NPUWx0RnV5Q1ZkZVdHcFJVdmVQWHN1?=
 =?utf-8?B?dDlhQWJFRzlaSDJieFQrUTM2NVcvU2VNK0tuc083WUF0eTRzcG15UERmUlJQ?=
 =?utf-8?B?TEw5b1FGUUxDSVBtbGlZc1k5b2x2QU1nNHJaSjVFTnpGb0dUOFRyNWdtL3Vr?=
 =?utf-8?B?MlRVUnc4Z0RWUUxheHBGRzJ5amZ6dCsyVStvS2w2c1FCU3gxVnpHMDRMaTQ5?=
 =?utf-8?B?amlIbTJCdTlOQUtGWTRWbGFGV0VSeWpFQ0lDQzB2M253OS9FWk1Fd3E5Z2JE?=
 =?utf-8?B?bkIvZ2o2N1kvZ2pxSHZzZnZZK2dGTWUvcXZmNnJKSHoxcnowU2hYMzFqY1do?=
 =?utf-8?B?WXhRSHkxMG5vUUhTMnlhMmxxdHFxbDRtZWdIU3dmU2RaWWVBN1FlUGpiYnhV?=
 =?utf-8?B?dUJSOC9MVHNpVng2K28wZUVQalUwMHZ5T1BnZllINm53T0RMQXdIYXVjRWh5?=
 =?utf-8?B?QS9YT1JCZUVReUphVFNjY1l4Tlk3OWFnaWhSZDJQazh3K0Y0V2RKM2Y3ZEdk?=
 =?utf-8?B?WU12UVNvaFNtNWV2aUZoTm1EbVR4UEh2Ym1FTFVDQ1FYU0VoMlVuTGNwRFRM?=
 =?utf-8?B?NUlQMTZaYXNvMjhod1VHWmwzeG4zTVFJUkxwQkhjRWpHTFQ2L3FWa1VtRTVT?=
 =?utf-8?B?bTF2YXc5V1pGTzhVMUxSRnFjSVlkOXFJLzZhQ2Q3TUsvWi8xQUFIb01xL1dB?=
 =?utf-8?B?eGZzb0YwZ2xEaWVOWFZzbk9sQko1c1NQSUpBM2FvV0p4aWV3d1JBdk9PZU1z?=
 =?utf-8?B?NTFKYW9qNGRMa3VNVFp2K3ZSOTk3QTEyV3dtSWlIY2pHMW5seGhjV01ncW9J?=
 =?utf-8?B?aWt3TFphTEhsN2xGYkRHRnhNS0tFTit4NzkrUEZTanE5TjcxZkxWaEFKT1Q3?=
 =?utf-8?B?Tm5tSFd6NEd4djZ6U0hzNHpvYjdDbm8yN1ZMSlVPUERUUzhYd2JacnN3di9V?=
 =?utf-8?B?d2RHcXRZc1QveXJ4ajB3Z0llejNwYTc0VEpLMXNRNWdkcHp2QjVCZ1FMblFu?=
 =?utf-8?B?RWU0bHBkenBMd1lUZW03M05TMUZTbzFoRlNwWkY5SWNZaS9aWjlyMXRCOG1U?=
 =?utf-8?B?emoyeEovdmpJNWJOR2VBSnVSb0oyaGxyc0FpTXo1akVhTE55MitSYUVYa2pW?=
 =?utf-8?B?TEhpMVdaRk02dDZhOXV2V2RySHRRbm9vQys0OERCTGJsdkQ1U0wvQ1NXdWtD?=
 =?utf-8?B?OWZJNjM2L2lmOWVZRWZ1YnJqTExldVdGekFJK3p2SWhNRWtmSzN2Z1IxZ0lK?=
 =?utf-8?B?aFFsTSs4K1dCUEJoeFVVVVgrSHc2bmVienR5ZDJlTFFBR2JQcFBDZnkvdUJt?=
 =?utf-8?B?aDU3M1FWNDIxMG1HK0NtR1l0cEVieEhQTmRlZzVjVTBjOEVidEpHcUpSZ3Fr?=
 =?utf-8?B?NTU1K3Z3My9VZzNQQmJMSVBCWjV4LzFHU24yZE1iemFubEtxMHJibXRtSzV4?=
 =?utf-8?B?ZGo1Rm9MemJTRUhZdE5waklZSzVrS3h4dFM3SjV6MDZaaXZmdUZKMnJmUUxw?=
 =?utf-8?B?MlM1MXNuV3RzVlpidDM0MzBldVhDeHlRV0lyWWhwOVU1eW10ZE1Bcm1PSmdZ?=
 =?utf-8?B?TTlhSW11R3M4Q2UyYWwyc0d1MTB4dTl3Q3AwTzlrNWJPTU5xZjlnKzBNY0U0?=
 =?utf-8?B?aEtWaFMvV1UwRWR1SWEzUkdqeVNudzRZeUI1Y3ZSc1YyNlFMMkw3M2tobjV4?=
 =?utf-8?B?eStJWlA5SHlXNFRnbGdqWWJGSUpXN2lvSHNtWEN6MElFRDY0MWQ2Y0JVTmdM?=
 =?utf-8?B?RUFOaWUrYU9XREZabUo1K0w1bkg5aXR3MzRtQllEbGJQOVZZSlBCdHg1QThX?=
 =?utf-8?B?OXZnYVp4MnZHa0hTSlJZaTBEaW53VGJVMmhFMmVMVWpQWVdkSmt4NGF5ZElB?=
 =?utf-8?B?bi8vakVJOUhmVERKWFRQc2ZxWmZ5Q2tsTXdENmErSlRkK29YdFhCUDVQV3BG?=
 =?utf-8?B?YjYzNy9RY05kb2RrbmwzbGJGdURmL3djOGpDc3hTOFlSaEZkdUxvclB1Y1Bz?=
 =?utf-8?B?M1I1LytYZmg5TEltZGhOdlZQaENlUWwrMlVMRGgrWTYzdmZkTmU4aXVhbjhD?=
 =?utf-8?Q?ASgOoikJdD0Qcii+dB2Qf684aFZRdkVyF2dMJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D450YgJc+kH/3ofFrZCrwrQz09+SpbLgY5Us+inP88RtZZPzWy9ePZv/I49rj0QDPfUpih7W1JY3X1JYdqDmHiZNR180iYTJdLTK44+p4imNkWNY1SqHkB4qa4zr6Nb6odh4n2USPduJ46i8WH2tu3PeX4zYvkVjhgqMfYsb6U4ZO2xB+dmjIHhA9us3HAZjaxSyB1UUutjN5xHP1q0jY6N4K3CI9bIGXTqT+nqeR7OP0BKNjRn535sLCURcwD7mH7Cga2eQE5NgKBYoTvJ0Oc6fqgV35/K+cpt3aFhNYYSMidZ+gtxBGrOLEyvcMvmtfrPXB19q0TJzBf7wl1TSQX3A3XhGxx+7VV5tZg92LkEhH2plnI2u65GVfmPGglJ9fMYa2B+Hic7V5++TM2U+LltBvGEAwxvzdTSzr7ZRrNCbkt1GB+TG7oYXLIXrzK+rfjxcld4UAkD3uelZDKf+0aglFBSyq9Y0sIqiUUNkWDw0ApFEIfnP6HGvXuDFIPkYHaONjLKRyQh1QTmmAstf0aATcGU2ScdHHBZPmgiObVhWvCdYMtLEMOZYInrSPAP78gd+CB3D1yQfYKz/eRsEC6FEg1L9QO5KTzYDnnn9jYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8234ff62-45fc-4d2f-36fe-08de633d4a26
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:00:02.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTU6UPPaLTT77YFTZ+KRjxXx1dXSW32M/LqFSBBavRXK25pLW5ptPce19232NTzpbJcuq27n4AAMJ9E8Ait+j2yj2GBnNJbOWnt86uHRluAzMsFdnGUkqowxdrapvKeP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030127
X-Proofpoint-GUID: jve1VkeRm-0modxZEV5jq5iS4G2vfUKq
X-Proofpoint-ORIG-GUID: jve1VkeRm-0modxZEV5jq5iS4G2vfUKq
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=69821b90 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wlHQtlIAlEDjt6UE0qoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNyBTYWx0ZWRfX2G5eh0RQ9jp4
 qYv6lMHPehCL64BORAQx/1H6A51scJn1cX4hX3hHTuXOWlees8ClLVPF8xBfxl+XwkQKN9tRXhc
 nmmLguDjOS5Llg0jWtzCyvD/QmNGbrtM7mKNTEnNFCmn0VvM3t1I7exvR3XM3m4J+6w8CW2o01T
 1/sdeLz7+QXiWptb43gJtggfm9q1Nqo0JPrNpqIooikIaSAlLKQoLq3/yrKGv58GNqPGtl4Nrvd
 gGPHugWynqbTl4G0ZBeNRbRqLHeojTX35kM3xLdaKWIwujNyWvOBuO971fJS0u4sD6dmRqivOmO
 SuvL0nVqDFtkmRqFDI2XKyM3enrYxJSS3MSMPKgEqxcCsCuk4TMYYDrau3U6+hU4oBEZuvUOYp9
 x1nhzcDEuF1cRVHd/TEql/dKPvwkdaOBPGMNKMr8nWetMa/LOuqsb9wvbOPBakyGpJXmwXthO9n
 jd5W1QDCRcGskC6ow/i3hEDTBtkIUwI71GQ+ou+U=

Hi Andy,

On 03/02/26 20:54, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 04:20:48AM -0800, Harshit Mogalapalli wrote:
>> sca3000_stop_all_interrupts() is moved above the probe routine so the
>> new function sca3000_disable_interrupts() used in probe can directly
>> call it without additional declaration.
>>
>> Used devm_add_action_or_reset() for shutting down the interrupts.
>> Make sca3000_stop_all_interrupts() return void now that it always hooks
>> into devm cleanup.
>>
>> No functional change intended.
> 
> ...
> 
>> +	mutex_lock(&st->lock);
> 
>> +out_unlock:
>> +	mutex_unlock(&st->lock);
> 
> You copy the code that is going to be removed. It means the conversion to
> guard()() should be done before this patch.
> 

Sure will reorder the patches that way in my next version, thanks for 
the suggestion.


Regards,
Harshit
