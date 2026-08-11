Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADEC359A6D;
	Tue, 11 Aug 2026 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437930; cv=fail; b=juXkyGeEemT56gvuP+ysJnbs1xOCMx7f1d8CxG5qM7uh/1ObnZ12tzPFrbrvVX3/LkdU+h0Bxc+rw/2DaHTd+1qD1xvCGfdgE/Gz936ZhJNb2DQy1ENACP317fgnf9cl0bG0LRFV8BJgowSwrBTsxlATES7sA3Gzy7fYoLko2/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437930; c=relaxed/simple;
	bh=bPZTlYnReMQHAY9ObmzRAkPk2XhsbiYrxLh2NwEIERw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ny5ScXYCIoP1fEqJBSG+TqGo/09Jr+DeidjbHqPvB4oVf3IPxE8MTfBFTyzGkyMKW4uFkaCpCCzgZDsSxZxkw9k4vU3OVl3dzGdo+TOvfqu96wn7Tk8hb5uv/E7uCEf/O7beJ9ipZZesBR875fIKTtc01dkuUi+ugestMvjy+tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NtHrBZaB; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NtHrBZaB"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B4WHkQ3410059;
	Tue, 11 Aug 2026 04:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=I8/dj
	Bbx8xiIGxwz+PSKAVi+Afxi6dZsgVWE7XvqLIo=; b=NtHrBZaBeIqX4mEwBQ00C
	+x0dPFlHT2V9HItx0Ui+4r4G+wHmgP0eQuxyw9wBxx06Pu5REEGhWbLcPq9PXdYD
	dlhvf6UIuG6xxZee4w520EJeAg+GnDb3+fJTkT7rfFy1FCVZ+8tD5rSba2QjjhPo
	UckWFpgfEz8r+hEyzu0Lcsl5aGeVOJVo707a4uKkuBflFefJW1QL+gODtGqt8I3y
	/Y3zgcFSCBo52hBxFzRMu5DZ5qtbMDJs/A3zlfdfi3M4qiKQfDu+W6wrp9NCZ2XB
	ssdzmzKncrHw/isovSahEh6ovflozisqphof/Md05zjt20W++Aamji4xRlgGc3tR
	Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fycsdmumy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 04:45:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qofZvA1AKGygTzle9mgVd1rUWnISvBO9X4ByJKEVESUz9gOUBPKcLfqaR5F6D9SNUI9iux0Q/9i0sOKgS8KqxoA9yXFJBm6rTfqYUXnFFcv8OAs4L2Ga18SOCpz72+jX2t2O0MArfbT1Hu7V1LDJ4IcmJkc2P33PVVvRe4kq828KlMObesMLzmT5HYAtt0xEFXZnaPubGxRgszWQlqYaBuYafS+N/ii9jdhpAze5OcaaTBZ15kMpfxTNtdslF3uzFq4BbxLpvcSQbG8tKJrUKqbGnLjHKLoiIt9JYx372rGUySKf2RLtdDWfvqpdw63xoGSldlL3+w1zTEQxlv5WSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8/djBbx8xiIGxwz+PSKAVi+Afxi6dZsgVWE7XvqLIo=;
 b=xcZriRvQsT4uMpulvXMAiCSp25dvhzYdLHfUfC+sK68KGuXELh8TEQRXPs8B7whbbNtGKk2HnDA+/taGCK/FmmwFAcdXs7klfJQpZwSBrW9WsXUzQhMehyz9keis9AhpeSIRA5/4jJ3qp7e1+4TdewAio+jevbBYpEaY8RE0JluPLVuqairlG+mlMtu8By9KLdc/Xmq4DrbWU1vd6fP2ZkpnJroYl2AleXNgd0rTIIcBZths4pX5ZpokyNrf4J3v1yhi2EvQJU8yOo7D7W6K3FraNEubL8wzYAufej2cXuBOI+Oa/TW9Vek6EnM1XpgPYdRxIngbiHgmYNEJgQCCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH7PR03MB7929.namprd03.prod.outlook.com (2603:10b6:610:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 08:45:04 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 08:45:04 +0000
Date: Tue, 11 Aug 2026 09:46:04 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anrgDskNdV7PG-T-@nsa>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anoHMANpRU744hPp@ashevche-desk.local>
X-ClientProxiedBy: MR1P264CA0010.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH7PR03MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: a22cf479-f0cf-4d3e-4151-08def784d65d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|4143699003|5023799004|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 8AuZzQZbj/pVAT7DQU5Bx9L/6yod+flE9GwxDq1YvFlSO/sryv6/d3w+8iYi9njnwlb/yX7IXOWAVvGwbplB1Mptx6QvelRLDvDaLhPZZ2o9NO01r5gh2iklJASsGT/7iH4agqNPdZYFaFy1yFpfWNNDHeu7Roi1ALDCiaQC1vKdwom3yGi/0cVtmU8hunfkNsxhjCIiKTb6k4EPeWnmAnBNry0J5wR9Lsof5NK+K1+ej1U3HbCXfuUK6BTCwSfGiBslyTeIUZ67JGcxnTeXvLegC660XyN23NHX4iqse68XCLfAG7T5s7bUd5x/Gk5Cj+2pNp8RQZolj/zdF5OKfrLzxxJ6/1KT/hG61LK+gPqZ83dKChlO1KkMSmRbBo35i6v8JXveG78amV8wVSPTBde1Wf2tLaLzAsC4ZO7ARaagyU5XtJiXQFvwh1jWghhwjqurq6W/TiFxXhezHtqWMQPLxPPil47nDYs+OGyQSoGm6iv6+WPfWsD5Ret4Bg/tuM/e8n9iekhAPodGidKhF33qvrFaxZj5xDY5VFQyyoTVnPafr6OGeoOXDPXmFAQ+E+XmKHJhpFdQGqjAx1gixx4FvIbxMWWkG40Prq+2Ryzt4vp4q0dlqn2F0QoNDbxsT/13hEEpKv6QtCBKnx3ge0Anv9EoAugLCXYDXP+oLdg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VGZHczRHZHE0eWF0OVFWQnVramNtTzZ3WmRXZi8rMk1EZnUwVkk0aUt1aUdP?=
 =?utf-8?B?SHpTWE9iNVh2OVIxM1pzby9NZmFWWVQzZ01LZWJJVThCQVhIcmplNkx3Z0NN?=
 =?utf-8?B?NzdTajl3Q3ZFbGNWT0hxcVlKWFVTTm0rQzVtbEI4Y0FPSFJCM1pCYjlKOERH?=
 =?utf-8?B?eFNZVit3TThDTHFRN0hhbVJrVnYrTUtDRWhaTERvR2tObTV0TTcxSVhkK2cw?=
 =?utf-8?B?d2hWazVjSWs1QmozZDFpa2Zzb1FYaTZkQWlpQXhoRS9YTkFjblVJa1FSeHVu?=
 =?utf-8?B?bFlYMENMZWx5Zy80Rmx6ZzFsWFd3d0tSaW8zZVJDWmF3NHkwbEJ4SkVsdHJi?=
 =?utf-8?B?TFQ2Q1ZvbEppNEw3MHJFN1lvUVFqZE40Z0VFY1ZaRVRZQU9Jb2c5S3N6ejE3?=
 =?utf-8?B?UzFvRzUvTzE1dXBINXh6cXY5QUk4UVp1d2xNV21ZVEpTTUZmemFWVjNYVW5z?=
 =?utf-8?B?MGtDbW1tYjB3Y3pVVHBmZ0JyL2R6aG9ncnpUdFhwUDBnK3NyY3BoY0tZNmdK?=
 =?utf-8?B?cm5rSWV5ZW03REY5L1JvU0tNU1ZyUCtLak5XZm9qU29wd3F0alpJdGFZQlZr?=
 =?utf-8?B?WjBNVWVIWVVLV1lsdXd4YzBQN3FrT1dPVmdOSUxOZXJNQ2MrZFdkV21MZUpV?=
 =?utf-8?B?eTNkZ1F3SjFwSG5nQm5YT3VhZzJsbHJxbWttNmo1cUk2UGtGbXlIUVp0a2ty?=
 =?utf-8?B?ZCs4VGNleUJHSVRpeWVGOW5hamJuWUlTbGhOWTlPL2MvSmtzOUhPTGVBTzZF?=
 =?utf-8?B?Y1lIc250TGdnckVGZ1BjS3hrWVV2c2taUUswci8zZVowbUVRZWlDQWJLb0JD?=
 =?utf-8?B?VnNYTHdEb2J0b3ViakdrcHNRb3JlMTFra3dFWjVMYWR1Uk9Nck5nY2NqcHNi?=
 =?utf-8?B?RGlyRFNsdWwwYkJvTFZjM1k3THA5MVFwa2RlYkYxM29NU2l4YTdpZ09sRW9S?=
 =?utf-8?B?eXp2U3Q0c05DVjR3WEFodms5S0wxUkVyb0IvTzcvUllHNVg5S2s3bVBnL01j?=
 =?utf-8?B?bTI0ZGdiYTJzUGlpZ0FCVVFvYmZrUytYZmU5K1duNFgrckkzTzBsSVVaRmww?=
 =?utf-8?B?K3dNcFVVdWVTUXlwYTB2cCtTa1JVbDEzcHZINXdNdmoySW5KdUhJWmdRR0Ey?=
 =?utf-8?B?Szc1NENublR3aVphVUY3d1RLdTZvVGxkdlRNb053M2ZlekNCbTlaKzc4YWFK?=
 =?utf-8?B?amN6bXJIVysrOVRjRWU0NzlLQktJNGc3cXA0OW00UEdkaWd0RHdvQzAyRDda?=
 =?utf-8?B?M1puZUk3K0RibjlXNGJLNWtGbUNZbUprL0dscEVKTWRYZzJoc21pbmFzcHY5?=
 =?utf-8?B?NkxjazRLUlJWYWlFOHVieTYvVTBQSkg2R2VnRElZNG40Q25NcUlUN0xyOWdv?=
 =?utf-8?B?RHVEUWw1VTdTQXJGL0xxVnNpRllBQ2NDU3A4L2ZBT1h2M0h1MFdraGNvWE50?=
 =?utf-8?B?UUVSVXlQdExOQUF1VGNiaDVDWUtpSkVjbXZ5WUlvSVV4WWlwRFAwdHdDMG9x?=
 =?utf-8?B?VFh4MnY1dm9XZDZiWGphOER6NFQxSXFubnVuOTlzaURDQ2N3eU5TbHlrL2lZ?=
 =?utf-8?B?N0RVbjc3eExyMnFJcFpDYzJKWlZzalZrUnpZZG5JZlo5NjloblpuOERYaSty?=
 =?utf-8?B?QUVOU3hpb3FiTVE0bFpDN1VYK015SFRNdGZsQWRmYVlDbnRlTTVKOVl1YytY?=
 =?utf-8?B?dmtlWi9mTXA4L2cxRFJKbUhMbnhGcGtzOHpBcWJaeUZMRjh2a01TSnFWNXc5?=
 =?utf-8?B?UTV2dEdPTThIaXcvV0F4T3hjVVc0VGRSTWhqUFU3YzNYL0NELzcvUCt2RnVl?=
 =?utf-8?B?ZVN3ZGdWUVB6Y2dGekozRjQ0MUFmY01EcDBLVUtUV2ZkaFZnSyt3RUVYdjhL?=
 =?utf-8?B?NE9GWjRxVXBrK24zSnMwTUdTS3NTb3VIekxFclJKZkdIZmhaNnVxUnhMMUww?=
 =?utf-8?B?eWxzRU9jK0hCN2xzdzBTYk9SNE1NR0xyc2RnVEIyZ1owSmtRNzNJL0swTmhS?=
 =?utf-8?B?U2VSdHFFdE82bjlIRWVVakFjRXRrOGZSZHVEOFZ5QkxOanpTMHkvc1dsV1li?=
 =?utf-8?B?TVJXcXZKcEYvazJlY0xQelNXS1psZ08vUWU3bVdZSHJCSWhnMTZ2MWxtWWg2?=
 =?utf-8?B?MGYzMGU0c1YrNlZRT2lEeW1LYmJqVkMwdG1hdUIzYVQya1g5USs3bXBYZ0Qx?=
 =?utf-8?B?YlBTck4wa0UrL0hUeGkyb1ZXRGtoU0lqT0NRYW1JMFhPS0pjN1BmMmZ6T05Q?=
 =?utf-8?B?aFNoRkN6b3JDM1lGbFMzNVo5N0RHMDVHSSsyVEt6c1N5dVlvVzVsbks5UG9D?=
 =?utf-8?B?WmRza3EvZjNiME1Pajl3TlpYYmpqRG1Ta2lzenF0OU1GMXM3dDdrdz09?=
X-Exchange-RoutingPolicyChecked:
	dLe7InvmGAlIWZbjviLwHnmp6XYnmMlmnAKRNUsV/Rnq7zKe5im5J4rC3SZOXnoYDjOzNE9ZtOC789h3d87TffzwnCRKKr9sAa4Xcp42awkeIRy1oeO/gWc+bzpq6o9WEpNibc+Ox0Q2/MnllVgGuvGvmMwXbwFBqpjNCcuqF6aO6GErN57uxYNWBb/6ZqhcTbZQIc1L21jqWvyUpEPMuCcPACVMp3E0SNHdqKJ51TOe0pD8KfNnPOaSZm9u6WE3+3/QPtYAOzof9ob30/F35x6U1yYmz+BsXQVdYfrjIZFjcqFRwe5cDUG2UeHqEPY9XdobYqx9J42hSNkI/BmFhw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22cf479-f0cf-4d3e-4151-08def784d65d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 08:45:04.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeuzQM2I2qAtz9xiOTBzxdBrgeTNIo2JYdNNAWLQe4B50ZdyR88gWUJCxBYkQmAgpNI+wdj6Hruzq84ileS96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7929
X-Proofpoint-GUID: 2F-6xlGsI6A2VVS76xeAWfrha_q0KPdr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfXwGUVa8kR5UTc
 WnQrx5w4EkjisbsZhCrV4xLROOHK5ZYpbLGgczqgWvUj7mMZn53E1+l9Vtvb4I5vost/0YGa+Yf
 1EMK/nwWGKZOQPzWupxLvqfAnXGp8+uleRtdc/82NOVMwXkZuJIx
X-Authority-Analysis: v=2.4 cv=MbhcfZ/f c=1 sm=1 tr=0 ts=6a7ae112 cx=c_pps
 a=TVJYqPbIpBJCeYGeirASbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=wb_W5cQHMrGZnfS-nDMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfX3rH5VA4UwG94
 0Eme2G3HudXrkqPwsdAufCRltlh63+XxPRW9kHiZ85qON7EKdZdOdUqmKWDURoy6j8NdJJ217dU
 Q83TBL8/Ly5QykrVDSHBzOBUde+Ys4f56wCXAum3tfI0HZBlv3Kxo4ldCTAdRtEIMNXVIl/wnd0
 bqfkWArG+/oDYWTJmPw/E3UJzNXdTvmvP/IQtK+OuhO5/heAuspjkwG/mM8Vr7d0uY2DQic6OT8
 ylhIeuqT2xFv1OM6eoXgMHJIqvSzqIUsvz2WG42DfsSTrt5tnFBqdTcoasnYOVcHjU9nt8/vAR/
 GmatX6LhwVBOZf/m38SVILCr2eZO6O8FWvJpDuNnGLsXokPUN95fI920WlBrnltIHgldfn3gR8C
 ZwVY2f7XnnAqlREzlO/F72wp44Fz4jpkhjHS/0mmi5lDT2w0TzkTVBWuTUNW8LHic/epABGMpS5
 MV8BnCe0SiY591o655g==
X-Proofpoint-ORIG-GUID: 2F-6xlGsI6A2VVS76xeAWfrha_q0KPdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110072

On Mon, Aug 10, 2026 at 08:15:28PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 04:06:42PM +0100, Nuno Sá wrote:
> > The src_addr_widths and dst_addr_widths capability masks encode each
> > supported width as a bit whose position equals the corresponding
> > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > 4). As these masks are plain u32, widths of 32 bytes and above
> > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > be represented at all.
> > 
> > Introduce bitmap-based bus width capabilities that span the full enum
> > range. To allow DMA controller producers to be converted incrementally,
> > keep the legacy dma_device u32 fields alongside the new bitmaps:
> > producers using the new helpers populate the bitmap and mirror the low
> > 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> > legacy-only producer's u32 into the returned bitmap.
> > 
> > Add helpers for producers and consumers so users do not need to depend
> > on the bitmap layout directly. Once the remaining producers are
> > converted, the legacy dma_device u32 fields can be dropped.
> 
> ...
> 
> > +++ b/include/linux/dmaengine.h
> 
> >  #ifndef LINUX_DMAENGINE_H
> >  #define LINUX_DMAENGINE_H
> >  
> > +#include <linux/bitops.h>
> 
> Ah, this is unfortunate, this is a wrong header, the correct one is bitmap.h
> and I think we may not include it here (see below on why).
> 
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/uio.h>
> 
> ...
> 
> > +static inline enum dma_slave_buswidth
> > +__dma_slave_caps_get_width_min(const unsigned long *bus_widths)
> > +{
> > +	enum dma_slave_buswidth width = find_first_bit(bus_widths,
> > +						       DMA_SLAVE_BUSWIDTH_MAX);
> 
> This is from find.h which is internals of bitmap.h.
> 
> > +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > +
> > +	return width;
> > +}
> 
> The (big) problem is quite a header dependencies hell we have. All my cleanup
> work of kernel.h I started on the simplest thing I wanted, id est to make
> bitmap_zalloc() and similar to be static inlines. But it's impossible to achieve
> (and I think that no one, except may be Ingo, see his 2000+ patch series a few
>  years back, is capable of fix that at once). That's why having bitmap.h in the
> kernel wide public _header_ is bad, bad idea (at least at the current state of
> affairs). So, make it exported function instead and keep bitmap.h in dmaengine.c.
> 
> ...
> 
> > +/**
> > + * dma_slave_caps_copy_src_widths - copy source bus width capabilities
> > + * @caps: DMA slave capabilities
> > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > + */
> > +static inline void
> > +dma_slave_caps_copy_src_widths(const struct dma_slave_caps *caps,
> > +			       unsigned long *bus_widths)
> > +{
> > +	bitmap_copy(bus_widths, caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > +}
> 
> > +/**
> > + * dma_slave_caps_copy_dst_widths - copy destination bus width capabilities
> > + * @caps: DMA slave capabilities
> > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > + */
> > +static inline void
> > +dma_slave_caps_copy_dst_widths(const struct dma_slave_caps *caps,
> > +			       unsigned long *bus_widths)
> > +{
> > +	bitmap_copy(bus_widths, caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > +}
> 
> As per above.
> 
> ...
> 
> Another (compromise approach) is to split the header that includes bitmap.h to
> something like dmaengine-width.h, but I don't know how spread this use is. Do
> we have all the users of the current dmaengine.h to use these APIs? If not,
> split, if yes, then comment on this in the cover letter and perhaps that will
> justify including bitmap.h in the dmaengine.h (but personally I am fully
> against that).
> 

Hmm I don't think all dmaengine.h will use this API. Maybe on the
producer side but even in that case I don't think so. These are all tiny
wrappers that make sense to be inlined but OTOH, I don't think any of
these needs to be called in any fastpath. And I do understand the header
pain in here but honestly, no strong feelings. So, I'll pretty much
defer this to Frank or Vinod.

Frank, Vinod any preference?

- Nuno Sá

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
