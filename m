Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F3468C23
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982839; cv=fail; b=R3MtmoTAGRJZQ9Mi1gRjlHdzlapq3dRZ66tcWBT5IkTNrFMJtBP1JrFE7K0UfUoA5bASi1dspwPsuMpJKj7ZcKBFEVKwFQTv8Py10M3VFN0naA2U71C4KbpAIXjVhMq5ndX88h9OyJMIITGNcwwNT0XAARbu/Rnyoe1zaawROsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982839; c=relaxed/simple;
	bh=3pxh4XHJiF9E14Ux255owyzwDaSdSQW7LxZ16cnTXD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hbfHzAZP13k4MuTcu9tSu469MQ5wxsYC1hRQMuuFKDluLIzQLK+PfQlBb3sK+wVzko6521lx2i9iaR07zuJE1fY5nlmJfGmG0MuUNX0A2MHNNct6V5pPQuxPWOkeKsa4/bapoh8LUh5o0y4qJqxT1ta3erjx785nj6Zu9Fxu9uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=E5N6RdVH; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="E5N6RdVH"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79ZoT1735419;
	Mon, 21 Sep 2026 05:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2pXU+
	AzIca+4HUELWgykjLyREMNSQ9NhoS8kYYkwSd4=; b=E5N6RdVHS8uCl3yKcxEaW
	xu/KREUolgye3jRbXG2ojsxrt+DdnqsLi1UIQnP3R+LW2CrcF0r8YfhAeWUX7Zmx
	wgzAgMQvSXQnmcI3SFT4wv6x7dvY9W+seqbtEIzVtssM8lk5SfgUOB3XDyWEqql6
	h2IvszAdHNraf8/wkWLQFTG0xWt8AwNfbbD3FF07F5G7NxCeOLXpEeMBskboQcVA
	irapHvjDm5t98XcShfoYC2efK3jaAqAJ1ie8RGS9DPM/bccpi0WSaNqMjAsPMcaq
	Rofzmd3m3B81ItU/aXv3oORc3vXpXHNVTwkV5EcURDHFEbipdPi7RtZ5xzEBMVw0
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gtb0hk7ck-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 05:27:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF2A3P1PwVCC1G1GWQKlQz3QLq9YK3zo7j+rKE/oSlmZJ6alyS2MXD0gS0+G2D+oaBRQA5DchH8hpjvjtp/U65UG0AkX6p+fGrJETNEqS6hG+RSlk6uOS5YOi9f72ThDv03AtGx5BepMhAcEb3Dvb5Hr/a64rylP7vSNBYBp5xarZXZY0q1NGQDn9SGVVMjkO1EDJFnSlwZ2qAVmERc66LPu5KHFmlp1l22WT+JPN5rtVkNhIZrnO3/6Dit/PgHCyPDw596UgsJeQTpO/+T5BH2tpN+IDStji0IQjPU8Cy1EahleJt9O+74UDqe6aY+mUjsMRz+G05IRYq/XpDVq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pXU+AzIca+4HUELWgykjLyREMNSQ9NhoS8kYYkwSd4=;
 b=sdYCq91nvoqTH5b3plLTJOyow900DJ4KOnmVaad2rYpMsXlAROKufVg6NdzBPxZdcTdZ57Xf4K8vz87AVR/UFJQ2kk71AlNVedq+pAplwlInIK4SUGktGN1vmrWzsvhn5BZPYGxr5yF3m12mm03Jfq3AlpahYZd0J4If/N3ImxiXbQx7t4JPUiaR2JgwPOF+6/wJwVHYdm6j7xPTF05QfoD+nLE7BiDx8Q/xwtOKTwDT4ONDeYxUAtgkkhXW5u9VqquwRnaXinlRd4DM7JHZA1ThZAoDG9UV7eLc9XrpXm3JY6TtMrL7AcE2xz1akZiNywQJplZNs7AlBmbpAtUcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY1PR03MB7262.namprd03.prod.outlook.com (2603:10b6:a03:522::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:27:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:27:09 +0000
Date: Mon, 21 Sep 2026 10:28:24 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        jic23@kernel.org, andy@kernel.org
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <arD2UjzKu2k8elgM@nsa>
References: <20260817111825.000063f6@gmail.com>
 <cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
 <20260818090652.000020bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818090652.000020bc@gmail.com>
X-ClientProxiedBy: MA3P292CA0054.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY1PR03MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: e85660fe-c159-416d-8b2c-08df17c28178
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|5023799004|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 1/1+uB3U74odsMN8WlElVC/Zi3PqaREQSk3aV8M8g7xeXUfJwIJ+5dPuMFSsuHylbIIwXxGJecays2/iXYX7FijohCunDDepA3YPdGD5B+w5Ks9vDv/WQuWbtlwP4ebXunksSVix6FL9QULtJvQX59PKwGtMS55Xy2/abyyAJZ8LrwKNInI9RrNutZk4/6LYvQZS5NwCHayr3xIfPwgLECpJHgTy4RhoFCYCJGqzPMCrtoGbgkRHkEDCKuODffdSsiZvfknJIE66Ie5TzPrCRqgvk7Md6xZaxOZR7YsbSRraALZKlbsAHPwajj38C3veYp9MD+Dl1GglLjFJGjcFi/msIPzcpoBnWoBhfHyrq9okTIcvs5hruBntSdEaOg60W1mwzTu7hhXMMmk9FxgDBLv7//b5tLFcCWq0650IqN6UBlr2F0AW/fM83XUBjlaG+g/g1zaSyzyQ0oyP0z959NxAE4sthiywRNG4E0Umd9P89JOy3ilCusUdQzl87RZwX2PAmscZfoDbW96FqEc2ymQEgLIbBCvhWnpYEG4lGA3bRhPwl/5oFavUBVHUR1KxnpOWZfnR2E1K16q0uPF8GFDcXAqnxM7W48Yq1mpVL2BxtQiEIYbzL/FHQMO8Yodz
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(5023799004)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MG1FbEJkYkFyRXNpV0VONG0wTFFCOHorcHJuUGRGMUFEZXNtTG1rVDNNSE9i?=
 =?utf-8?B?eTI2U1RKejExaFlIVDVWMGs4OGZ3VlA0WkdIeFI3aFl3aUtwSXFpWnRiRzhE?=
 =?utf-8?B?UEhueUJaUE5oeW1wQ2RMMi8xQitYMlExSk8yYTNSZzBTOTVXMzlpSXBQZUc1?=
 =?utf-8?B?NDRLN1RWak55VHNzRjY0N0F0Ymo1TWpXKzZCTWdTdWIvUDFuV1lkMVBZMzVH?=
 =?utf-8?B?SEZRVTJDaGlVWFFpTmtTSGg2OEY3dGlsTWpESVFJK3hvbDluVkZDZDV0dkI1?=
 =?utf-8?B?eVhXYTgxWUx4c0RtSVo4WEZodS8rc216TjNqR3FBMTlRZnljWXZWTFBYa1Jv?=
 =?utf-8?B?MmRhUnhCb2pNSCt1dkU1a2c2SWUrcFB1V3JoVm9lQVVaaVR4d0dnVHhwMGR5?=
 =?utf-8?B?bVpibmYzL1cwU0JFdUswYzVldTFGNzFJajIyOWtLd01Hais0NjkxM3RJVlNw?=
 =?utf-8?B?SDZ4WHRZNkVYa0NiTmlXYndBbFZPOWo0bDdlTFFOYjkvRThsaGVudFdwN1dz?=
 =?utf-8?B?WmhNVjRRNDM2MUVSaWxlemNIYXVxSXBhb25pRzhTbzdSb2trRmlzY1lzR2pj?=
 =?utf-8?B?ZFdNN0FSMDJVZUtycWZTUTczMjM0T3pZY2x1RjJFem1uQ0pNdis3b0FBT3pK?=
 =?utf-8?B?Tzdnakp2TlJzVjI2TG5RTThBMk43ZTZubUNHVHZnbzJGKzMxM3czUWNQek5z?=
 =?utf-8?B?SGdsMzlhbWhRNUlDMWlSV09pNU5TQ1d2MDBiM01FTVozcEMvNk5walQ2a2ly?=
 =?utf-8?B?ejU4UUdWbi9ROWNjaDBzanhaY3BEaTVZZlA4MnF1VWhMVWpUNERDalZ1RWNj?=
 =?utf-8?B?ZmxFTUo4ZTZSTnN3UENTOXZxZzZlN3pWSVpvMlFvZWtDRVNwSVRObGhxd1Ri?=
 =?utf-8?B?WkNFTUFnZDdXdTZOb3hUaThMc2xPQVRNU2Q2OGRBaFdtZXRYWkQ1d2pZaXJ1?=
 =?utf-8?B?eG5HOTY0ZUV2QWN5OFhLSXlGNUhCN0g5bzZydGtOMXBUQWtzeC81VU5iS1V4?=
 =?utf-8?B?b3ZIaW1LS3EwMDQxU3BRRzFTWDJBazlsT1ZQRDBWSHJtbkk0dlFNUlVZQ2VY?=
 =?utf-8?B?d2ZJSzhrVjFtZDVyai9RZ0JsZDVCV0JjUWpFWHlqbGtKNGtYc0JqRFo3T1FT?=
 =?utf-8?B?azVHQmJmT1gxZFJDeGQ3SUZJa1E0eUwza3lMYjhxeXAxanBaaWNHV1Z0OHk5?=
 =?utf-8?B?OXpLSERpZkduejlsbzJaU1hhbGxheEViSnU1NnNmdDlsY2JGbDQ4cjNGL01I?=
 =?utf-8?B?T2hxSk1UK3hKZm5DM3krN3BGaERCcWxadGIxRjd4UllhRWdkU1E3eVV1aTBs?=
 =?utf-8?B?TFRFTXRtVXE5S0ZGU1VJMk51RGNlZU5uRmlmYWt3Y2ZtdERzcEJNbmQ4T1lX?=
 =?utf-8?B?Q0ZwUCtFU1Rva3FZc1NxTm5LNTY4NnZ5dEU5UHNxdVdqR1dKZlZuSmFtS0lm?=
 =?utf-8?B?TWZFVzRhVVM4NmFoMnBBYjh5OUJZYmtFR1hJalphekVpeWRFVU8zQzFXeDBX?=
 =?utf-8?B?U3FyZVhxbmNZMzYrM0JtLzZoVE5XK0dyWTRQMER4aUR4TFRkSVlMWmRHOGNZ?=
 =?utf-8?B?bnZ6R2cwR09QdFNtL1RxUXN2TTB1RmV4d1ZPSTJOSStOdm9mQWczdko3Ny9V?=
 =?utf-8?B?amZVOWZrL2s1NGhvSlFwYWRMRTNBSTdqSW9sM20vMVlyeFVKQTNWeDMwWlN5?=
 =?utf-8?B?ZXVwT3J1cDNZNGwrNWpDek03NW9FbGF5eG12SDZyV1ZMTnMvaG4xVnBTR2tj?=
 =?utf-8?B?WXRVWW5CSDdMU2YrdDN5b0tKNUQzMkkxSThnalRrL2N4eTRGdmNmRnZTRVRJ?=
 =?utf-8?B?TmFtNU5OY1ZoRzZPVHd1SHd3OFlUbkhGQ2Z5UkQxc04zbDRnN21kSmtPTjho?=
 =?utf-8?B?cHZQdS9LZEpWOUlXQVRrSWhxOURoanVRZ1dhY25TM0dDNnluL2NmQ0orR0pm?=
 =?utf-8?B?T0RsV1ZETGY1MXJPeGo2TU1tM21EYllKb05ud0E0QnBDVGU2U0Eyby9Rd0xL?=
 =?utf-8?B?ZlcxUmhCall2Q1U2cFFvQSt0bGEzbDRmeVJxNkVQWTNBRHdqSGQ5QUpJMFN2?=
 =?utf-8?B?NXZPSXRlbGZ5dDJlcFpFMUtjK2FnNWpZWXJvTmhMQzNDdnVGa29pWktDeXlX?=
 =?utf-8?B?OE1CczlvdmlsN1lYZ3kyM3ROU1ZIVHgwRmFBN0VpOEhNY0M4SUdhNTdkdEFB?=
 =?utf-8?B?ZnhSazRzQ25DOGNSUjlHQlVCWlkrMUVMallJc1hKZmJTSDZlc3BnU2xIY1d3?=
 =?utf-8?B?NkdWL0diYnl6TUFxNy8zcmZ0VHRKUmJpR0dhMnVhYzdSS3RhVjBYWjlzd2VW?=
 =?utf-8?B?L1N4ZFRBRWMvWnplUHR1Q2NRYUwwUHFPWU9JRDczUk4zeFMwMjd0Zz09?=
X-Exchange-RoutingPolicyChecked:
	WnwMIruvoFq8JcurgtMNorkctaBVWm3mB7RIkyCKQF7hO2ZcavGaR5Q2UKy8T44YBbt2roP1yZoxP01V/D3Pop+kYX2LXFo+NrXLyfkT6HwVWDlncGbRdTfzj/6Aa1F1iMZjncq6Vy8xnQ4KR+vlF1+nCWH1E6eRALERhU5fLrr9OUzNNNCqbU1TuTtEPrX/RFzEMiztiQmfsx5SIFQ1xBld8tgLcf+2a9TbTx9QRzuf0aA4FjIfSTfWXORRahyzYgXmbtV9tSbszxgYXpuGlV2dhBRKt16gaIX+qPrcOTQZ5leDo4rvK7AVNaA74H5GH8VS8uzJvP+xZewKnF2zEQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85660fe-c159-416d-8b2c-08df17c28178
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:27:09.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YU24XaPfDvbIyF7Rjv4dSwpR70r6/MNTxseAKKuOrzsYdqfIIV8fpIs1Il9M2dt04360DmzG8vvZffVKSZR0CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7262
X-Authority-Analysis: v=2.4 cv=BJomP1QG c=1 sm=1 tr=0 ts=6ab0f871 cx=c_pps
 a=JAvUoUKTMhMV/AtIpjtZgQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=NEAV23lmAAAA:8 a=IpJZQVW2AAAA:8 a=HtJ6usEcWkVFUjQNf9wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: RiCRE4WQZiNPaOMKY595NChaNDbfKpdt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNSBTYWx0ZWRfX4viO3nNQFOnh
 xSohkijubyqI9aXXEiEpzVtd4g1xClpYrQ7Sb4kJfrxtifaLqixis7Lr40lc3pzeSa+AQFyv117
 a+52tXEm6nHS/zH8SQrd8ggjlbGfTbUnWuTq4bWi02gXlctfsGNh
X-Proofpoint-GUID: RiCRE4WQZiNPaOMKY595NChaNDbfKpdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNSBTYWx0ZWRfXyj84CHFJQNMv
 cdYocKrUwKERIPXYLjCVCATxzg4xPfbTjVzhMuv7jISTuCBRqbOIL3rkhe8lkDvb8m1kcl3r6nN
 VbhKks0EKlSffwppX0LAqgyZQJnSuiJpnulzESOez+70ivAnu7lkAMuwS34YYmAP5fS2PHIBEm8
 uU1Q92PmNojUIrCPAm7/1v1eFvhwIrYhxyuc6MYEY3ZjbhB+xzztoDw/NmYqtYszO4lufHOGvtT
 BPlvDTAY2hCsDq47rSYna9xWVotzeK59b3RyhilkFbQwFWQk/BXKfzRyfkNo+CwGjH1pIMZuk4a
 maEt9MxjQM4La3+eRZX38pHcOpLx/Owo2yMhjqi1QEDNEUJE/BuEmb88mEHXA5ne5W94Ht27Srx
 ATQ7NOQF4m/5CatI5eOhEfanturF3JIjrZMg7IKzsG8fGAlEsJPWFB9hTe0LQPpSfMcJf0YqnWD
 DverZ1roBxreiEq0g0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210135

On Tue, Aug 18, 2026 at 09:06:52AM +0200, Joshua Crofts wrote:
> On Mon, 17 Aug 2026 19:31:45 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 8/17/26 4:18 AM, Joshua Crofts wrote:
> > > Hi all,
> > > 
> > > I was browsing lore and checked out the ksummit mailing list, where the
> > > topic about guiding new contributors arose [1]. New contributors tend to
> > > make the same mistakes when sending patches, causing reviewers to point
> > > these out all the time over and over again. For IIO, this is definitely the
> > > case (I myself send an email telling people not to send a v2 in reply to a
> > > v1 several times a week). Other subsystems have a "Maintainer entry profile"
> > > that contains subsystem-specific process info (DAMON for example [2]) and 
> > > (sometimes even [3]) a document describing the code style of the subsystem
> > > (this would be a great place where to mention things like not using
> > > kernel.h in new drivers etc.). I'm happy to create both of the documents
> > > but it's always great to hear other people's ideas!   
> > 
> > I think there are plenty of new contributor (to the kernel) guides out there.
> > People just don't read them. So I don't think we need another. Nothing wrong
> > with trying to make the existing guides more clear/easy to understand though.
> > 
> > A subsystem doc that has our code style quirks and idioms would be helpful
> > though as I don't think that has every been written down in a single place.
> > Especially useful now since AI reviewers will read it even if humans don't.
> 
> Yes, but it shouldn't be limited to code style quirks - I highly doubt new
> contributors develop against the togreg tree of iio.git for example.
> 
> I'd propose 2 documents:
> - entry profile - documenting the review cycle, patchwork, point people over to
>   Sashiko, relevant git tree etc.
> - code style - the TODO is fine for existing problems in the subsystem but doesn't
>   point out idioms we have in IIO, i.e. not using (the awful) kernel.h, preferring
>   devm_* functions, not failing on a mismatched ID to ensure fallback etc. This is
>   stuff that appears a lot in patches.

Personally I do think we have some things (not just coding style)  that are very
specific to IIO. But maybe another docs file is not the question. Or at least one
for humans to read :)?! Have you evaluate just having an IIO entry for
sashiko? That way, hopefully the bot would take care about the subsystem
specifics and preferences.

I wanted to do this myself at some point but I'm always pulled for
something else so if this is feels like something you agree and would
like to get done, please go ahead :)

[1]: https://github.com/masoncl/review-prompts/tree/main/kernel/subsystem

My 2 cents!
- Nuno Sá

> 
> Whether new contributors read these is up to them (from my experience if you write
> decent docs people still won't read them and ask pointless questions), nevertheless
> if we suspect someone is new we can just point them to these documents instead of
> reiterating the same over and over again.
> 
> -- 
> Kind regards,
> Joshua Crofts
