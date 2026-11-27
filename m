Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795771869;
	b=xUP8ywKoKcvglr6wDv64qHkH/lzTmvebFyT7/SV6mtU/rP1cH0KIscKrrx6syHAlHCR7
	 t/tx/KK1pZHpxhX4kXJUFMtiz9eH0MdTouJA8E8nV3IpoNMLivtrdjz+tvei0uZMMSbAm
	 GveVP/MB27L6FHME1Jq630KN9IGn7mPx9QPk5P8HCVC3YqWiGqSwOTNw1MYwKHUtaw0nB
	 huI901UPkqH3YkAQqqh8IXNuixjENj44AuKZgJBwmjChGrzYbhuidrX5NEdu6jirvFgdd
	 K0L18vXyH4T1CauqLL7gQLiD4aUP2xNEhreb/tSvWXx+GNbDLYdCminkguUL2ZTNscA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771869;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ujxj5LRbrUhmRHXV3WRrDzaDicffrAs+o4m++Rj2RPU=;
	b=gcmOyqVEMbKdqFfWA0jQ2JyeQ4sfsxtY6zW45tJtxuKWmr+522yTiWnUj+hLNFhCxD/L
	 mnIdBs+/wxgO+6wY/bH/H/7VKAkOV6xd4S8ZQZEfJ3/aqAA/ubFRFj6vHLQg27CqKIpbf
	 1foVasP1ydl0qprdgDBKvuz1Aaa4OHse9wIhiyz8H2YzFsOYX2FFXrfqYneT5EzxHhfHd
	 JgBe4lYek2rDkfLmwtc0APaWDCPQ4ZiyWXoygAgC3Q3/1G2XS9GHQy66ZeFVIagDL5VON
	 s4XeqfAcJBFZLMDjtDv+PqIl3MWQyWJQ8d7Rl90CBSTz9bTIkZX/84iy/aRgw6nEcDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=eQRjTP4f;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=0KVVww7w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92F606A329;
	Fri, 27 Nov 2026 09:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E92F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=eQRjTP4f;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=0KVVww7w
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7M5jp2319110;
	Fri, 27 Nov 2026 04:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Ujxj5LRbrUhmRHXV3WRrDzaDicffrAs+o4m++Rj2RPU=; b=eQRjTP4
	fDAQK4qBNZiNcpdE6XjRDKOgnthIU1NmRD0tbGDmfJCbJBYzPOWkcdZIjlbTz5/t
	YNQ71C/jm3xunvTSWSfPg+AcHtI00w/kuGpAjtZ50saZ6bpnEGWjhMRWTGc3PdAQ
	WrrzNDxrqIvM2zCY9izIXpnU375DBzgSWgl9BYJimC0CkEiUlogE6L7kLKml/vAK
	UFatHIyfUX8jtS3g7rmvARc9wZRAzsfbrv9KO2Gapdr1lfg1O1xMtt+uRe+lguk7
	o3BERlKTLZl/c8hvTBhgRtB2VrsWpxpSN1fxLNGNeaHRzWHv0jvmhTaR1JWRkg8y
	6/TgTvrFgtNqAwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ujxj5
	LRbrUhmRHXV3WRrDzaDicffrAs+o4m++Rj2RPU=; b=0KVVww7w3JbzbfmlqqWTn
	E5ndMPb2nb0zCofIE3JyhVbu1/fDu1EQiSn1Z9PTVteOFgXsdw4ovsA88IHUQOjT
	eH1eAn4xQU/CmoOHcHVofAQtcwNWavADP0+vQf+cqKQY1E0eax53vzE5LNuxbDEr
	H+3D66sSO4BDIFo7Q7yCXHOGhOFsbsIljQp0ZeYdKA4MrLGxIIqh7N3NK8ALbGoS
	C3LWo9eCY8s3fU6pvqw3QvJ01Fkhxwi+p27G51B0fhzAP/6waN5PvS/G2IATmJP5
	C8tNvO85DAStEPUKMnLfGNHCwvrBS101+k+CxJ/LgK83Assk2uoT0AXUsNf1U0Db
	w==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j6byk6bnt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 04:30:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFrC9sATHPC601VVRWpMiJ93yygQ44IxB4vGzo/mYZXM7NsYPb17t0oNHISK5pt3Q4YTDAI754jLC/EEQQFB+K8C+h/QwnmnRiA8vZtWKnEP1ALQ5LPJ8ORLwpMe9X/GHjewi+Ka6LJ10sMK9ZUhJg1kqKLNDpE3JFFFsJv3W7htsMf/TAq07cQKOBGosJTYrSeHQI+Xi+h3AsAzOqWf1/rsisyBxIdunFvTkB2fkx7PHLiCfnkYQt0/Fw15gtXsmJgIEelmKW+2Z2+KwBegAqWB0ZM/8r2iF7kVnnRArxA1mTLzOGg8a3ZOtKk/9Hllk+5iU22cvAXkCI5+hgaxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ujxj5LRbrUhmRHXV3WRrDzaDicffrAs+o4m++Rj2RPU=;
 b=O14WnFDw+dkYeDVaZhrQCW+4UMI0AHKdkim1HkDZuHqDu4YxX2u8uGRwrHvg12/5heN8x+2RsQgVSXpPmftQ8HzyGYU+nXO4OylRFu182pDEjl/jwjEKN1ZgjDKWQZpjmV4ODKrPdwoliyNerpWPrGll1vQLbTS3t0ckjCe27d/gka07Vq/XytFw1rbB0LIWH2QmgkKSZOvTWg5ASaqZllbPw/nXUoSJgR19mwzZiM5Oz3BQftUktZgT6Oz4b8DWfUNQEak9ohTzI3X0ZSbrPwF98gH4PlvakzOgxltrvAkZJrAP7QqprA2bYPwxP0mUVTK3BHo5scYVjTzjFwbpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSVPR03MB989242.namprd03.prod.outlook.com (2603:10b6:8:3ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 09:30:55 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 09:30:54 +0000
Date: Fri, 27 Nov 2026 09:30:42 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Ilia Snezhkov <iasnezhkov@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Arnav Kapoor <kapoorarnav43@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: inkern: guard fwnode_xlate with info_exist_lock
Message-ID: <awlNryt52pNwhhO8@nsa>
References: <20261127031038.12685-1-iasnezhkov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261127031038.12685-1-iasnezhkov@gmail.com>
X-ClientProxiedBy: MR1P264CA0213.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSVPR03MB989242:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e88f0b-f844-4dbd-30b3-08df4c69229a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|6133799003|5023799004|261009223027099003|18002099003|22082099003|56012099006|10067099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
 wMd/JgUai6iqCAtKYXs+sn8z+WF27d/MCAROe7xmTpVDpaDU0yAsSRI6HHfUsbUXYruojlnRNJbS3paaj90avojxEeDgq8yuXTb2vj0b1jIAQJlVwxu+oHLeFFddNWOtOigjeXlayc3F/yZZi+hoqDhknTz+zSQk3JyJqO44OVhGzDfcgekJOcnsDU+87eg+fLXREWW6bwg9oJvoW8Jw1r8Jo2aLLgSnVSinx+PYliS3BMLHs59iBLudaajyRGoJwnA9atpkOYeoBVWId49bMnRKS2ObmqFFwSJ6kG4hCRNKU9YjHoNc/jtA1+jMD/eAMUVc1ywI7l7JGpTuIWBQLQ6LOtqPoznjYUDvAt2o9NGv4SY/F7mvOx4EW67SCpgzRII4CzwtkAjVSOoq4YSCa0W3XOhsxb0Z/bsOdcLHeS0ZqZnJy3/VSTKjEniMu0taw2Q3/hi9z/7HBr45fKujfrv4Yx07t7wY31r8DpK5o0L0DYEApvYSxpkxNUH7qgp0nvQyA2qcZNcuvAYsZKL3HXm1bCwcAPOfemag6EO0FpK8aQQX9PxxszG74QWYVfFQNF221ohPRrkGLYIGG6+8MhhJfDGe7QLg4A5mXVUQ9Mq8pddh527Id29UEdH0KD8B
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(6133799003)(5023799004)(261009223027099003)(18002099003)(22082099003)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cW5LdVJhYnNjRlQyd3FjRUNZbm85Qm9EQ1Z5VHc3M0oxbDBybUs4YWRUQm13?=
 =?utf-8?B?V056WHVUNm4vSCttSzBCWlM2YjhVc1A5bTRrcFovTkFacUtrYjQwdjlaSjhK?=
 =?utf-8?B?elF3N3NTdDRPVUx2ZVVDbS96QXlCWXNIaWU1aERHaGNwTlhmbktkNnhrbTk5?=
 =?utf-8?B?aWl5RHdxcCtQeFpiVjFkY29JeW9UajJBSWRJVEdrczYwZGlKMERmc3M0NDJD?=
 =?utf-8?B?R1hNTHM2L0Z3MEh6VlZad1NoeTc5VS9oZkdtRmlGNXZ5NkEyQUhwMnZzSnJk?=
 =?utf-8?B?amF4bUV3TjVyYXQ5WUJYMHl5UWJ5aDNIUEIrdmxRYkV1cVJETnFtczEvdnRo?=
 =?utf-8?B?MFZLU2FKMmZFNDRLckUvT3A2YVozd0w2aHZkMFRDeUZBNDV1ei9EbldkUUw3?=
 =?utf-8?B?N0RjZnFnRDRGTlVMQ0tjcUVKZVlYVUZXWFZIeFlLblJxNkYrS2pHNDNrL2tC?=
 =?utf-8?B?YkxzYVJpQjI4RmhyTjZLb2daNUl2RTdNbjJnSmlBZGN2T2hSVzlVcVI2eWQz?=
 =?utf-8?B?T2ViUTFVVmF3MEZTc0hFc0FVd1pWSXArSnVNdjd6Qm9ldjhFNy9WdWdCdEFX?=
 =?utf-8?B?dGJyVDRPVTJRMGlzWlBVVnhPd09HUnA3bGl4VGl5bk5FUXRURnp0cVk5aUE5?=
 =?utf-8?B?bVRpU2Z3aW9EakpoMm1pOFlibnBxbDQrUEhOUHJMZzNGYzhkUGMzMDFNUmNP?=
 =?utf-8?B?QUtVUmxLK2Zjdm5rSFFtb1NYMUdPOGlJeDZnSjZLSUNXTVoyVWxVVlZaWTNE?=
 =?utf-8?B?WENVWk5yUTdBZmlocWlVMEsyU2xva0hxZU1EMHg3ZWs2TUF0blB2S2xWTENO?=
 =?utf-8?B?Y3h5VENqMDJpN0ZJQk82KzNmVXVha3NaTjhZTXcrbG9MeVI4T05Fb3RBSFNQ?=
 =?utf-8?B?cy9OMlA4REZydnVqSnQ4QWo4ZUpVVkpuL0h6Zm9VRklxeHR1WEQxaXVOSHhJ?=
 =?utf-8?B?cU51YXRqZUJ0SXBhemVKNzRoOGdQb1VrT05kOGxFSTEwMEFnWFNza1VGMG13?=
 =?utf-8?B?cDlWZ29uR2cwUExDZVpWYTBKZVF6NnRSa2NLNzV0L2Zxeng4aXdta0pWRzRk?=
 =?utf-8?B?Sk5yU0MxSlZMQmtVeGFIclZBbFJ6eS9yclQ3OTVOTGZHWHFMRThIUGZkRlZh?=
 =?utf-8?B?QURNL3hDSEFtQjF4Yzk5Q1BiTGRNemZTNlZlZW1FZ2V3Tm9Xa3R4Z0UvVnRK?=
 =?utf-8?B?ZDZVcjNPQjlNNmtUdWZ6Z3g0NXQ0a3FsNzhhaU54L0N0Z2RYeDFCckVOUnBS?=
 =?utf-8?B?RWt0b1RkdVFxYTlINkhSUVk2bE5CZnZvZGoyeEpJblhpRWk0STJCRnFFUWhW?=
 =?utf-8?B?aWFqQ2REc2JERFNkWjQ4Y0Vldmw2bm91Y0hJYVFpaUJ6QlhoNzlyU3NMRVZv?=
 =?utf-8?B?c2t5dzh4QUxPQkp5eUE0VS95YmR1eUU0SWJVR3d2N015cDNyL0FnbTQ3R1Vr?=
 =?utf-8?B?Tk1VVnRrMGJYVUNHK0kvTWxITlVhbUttM0hoYmVWNnBtNnFrYitOMEEza2Mr?=
 =?utf-8?B?aVJkUitqOHFGM1kzM0dhMkRRdTFJbjBCYTlUU3pNTnRxMDBTL3BpRDBaSjZz?=
 =?utf-8?B?eGxzUzhIbERaQ0VJWnBaNmQyMDFQU0hyb21uSkpiUTJRN3lXNjF1M0R0MHJO?=
 =?utf-8?B?ZDFsRzVlWVZvL1VUbDdXRGZkMzlnUUFXSkZyZEszOUwwcVRXQUFUcmhraGFs?=
 =?utf-8?B?TWxTdzZ3SUxHRDdBdHZPdmNHUE80M1JidS9xbUU2dFNnSmRLcWx3bnp2TDJt?=
 =?utf-8?B?YTFySm5FcnJRY3lqVWVwL1RMWWVEOHM4dnFoY0FxalZjUlRISEYyelYyL0RS?=
 =?utf-8?B?UHVnVWRQK0tvM2l5bmZxZDg2cDYxc2lMdWtrSU1iM0pSbWtCb2VWTGFhcGM2?=
 =?utf-8?B?MVVoejR0dktReEtzN1VGZVVwWVZBTEtHMTkxZm1UeTdDUDBSZkpLL0N0OXRv?=
 =?utf-8?B?N2ZhdWVqOVZrMWp3SDZpM1BsNGZ0d0Y5RlpoWkowRnlra2VGTWZtZ1NjMzc1?=
 =?utf-8?B?bmVEUUR0YVlsbndTRmhTZ21yeGlYVDhJdWp6NGh5ZzgxdzA2aDMxVGM4MGor?=
 =?utf-8?B?NXV3eWhXSlJKVTczdmJhK1JrcjlYK3FRdEMxa0JQcnZ1NDA1bGYzRCtaSDlR?=
 =?utf-8?B?ZzBxQXRkVnBqNXVZRGZVaU1IWTF1WnRHWGw1S1VNdEY0azZjR1NXSEpPYmhP?=
 =?utf-8?B?dGhrY1hqdkloeEhoeERvWk5kRkVzenJ2bCtiZ29kdjk4MWtxUTg5NlJtU2ky?=
 =?utf-8?B?K0VDeDNicHdrRTE2Rkk1UnVjTFF1T1hSV3UwQWgwTGxxOG1EckRVajFySlhH?=
 =?utf-8?B?d1lVbzVqQkZFY3VqWE1kVUlDM1NkT3p6MXhGVDZCeGQrUnA2K2UxQT09?=
X-Exchange-RoutingPolicyChecked:
	YD6HlheGzEm+kyg0kXCHRV64CZ67FTngl+v6gJJK76+6zUzfgpkvX8POMseLMszvsndlNmcM1d0RvIMJZSrLpCF/kS0GaFg4M31wQB7ArbdJHwpmAwbXa1pOMFVbMe9ywBjoSaY5GSoD+R4aXLSCdWjziep9r/X/XC/98fe1IYVhKC6+oBNvna9rCIYjfv3v9/7k/7vC+jEAUFGSwMdFvTGN15QclLfabmLMuNVgPlEPXwYytY6lLN8TkSfjVzLtrIQddCTCu1N4c7PYVAfgYSJReGKqtURHB0JR2zumYHlAlaEJbxIfnMgp1dqIcLQnkU3un1oW3+JAJkY6MWkdgA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e88f0b-f844-4dbd-30b3-08df4c69229a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:30:54.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFyinrKPCi1KNBNfx9W0j4BLW1K63PjTImONjP00k9RbMmcYF0N7ozK2q6NE7Ak4qtSFEcD3oE81IILU2MqDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989242
X-Authority-Analysis: v=2.4 cv=BoYIUoX5 c=1 sm=1 tr=0 ts=6b094dd1 cx=c_pps
 a=+3f3g5PcVU0WeXiSVbezXg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=B0ALgKKSllJMJ3MGM3QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNyBTYWx0ZWRfXw5eDK5KfgSyB
 FUjC5qQ04Q1RNUq9d9uXaRHMGMeykvnUbmJWwXOkBa4egDS8Rpi9VZ+uCL1McrCbqARyY8jH5x+
 LOboSeHld2H46/Ujf2eDymdcMFjApuR3wZ0s4jdWovoTm1mkBGR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNyBTYWx0ZWRfXyXU8gn9+atDe
 fLFyYtXxOLq58YFv7H4T9kKasAr3eQefxkHksF/TttwaONo3fjNhLpJ8RwcBjXcAcvJbfrwDuOI
 LN/dHbcKtZO6xF6kCla7UH44ZZAnzYNzFKBt6JQSmLwyZsQcxYrKRuosNSgOCbpwW780kxv+QAD
 sca3YrZHCA9HKo2IJh9ABI01QaHr6riRudf13fb2BDDiyBe1HMWocxc12I0CXInlJTt1GA/yqFK
 LS8JvCeu7AvLufYu05nZ0H1S4KneplLOPLWs2PZvvf46P2zNlyGN3BYC7J8nCQ3IHEMifQmkjgo
 3R4XFVfxdwWHqRy1/hWHL3iqGeYQEJq0kXN8HOJWJMO7Y9XVcuOhGvLfyX9uuQZQlbIhQiNisOr
 TxTMS/ZI7WmxTqbIVU9ckXGt3Lkb/dLqqnq20w3Ylz/W8JhoyDhktvZw58BnuvhG3YOqCEstke1
 d8MV6ORdtb5jOqvi74w==
X-Proofpoint-GUID: cjAv9MxyUcaHS6TNTgjQmLgVBYe26T2y
X-Proofpoint-ORIG-GUID: cjAv9MxyUcaHS6TNTgjQmLgVBYe26T2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270037

On Fri, Nov 27, 2026 at 03:10:38AM +0000, Ilia Snezhkov wrote:
> __fwnode_iio_channel_get() dereferences indio_dev->info->fwnode_xlate
> and invokes it without holding info_exist_lock. Concurrent
> iio_device_unregister() clears indio_dev->info under info_exist_lock,
> allowing a NULL dereference or callback execution during provider
> teardown.
> 
> Hold iio_dev_opaque->info_exist_lock with scoped_guard(mutex, ...)
> matching the rest of inkern.c, and return -EPROBE_DEFER if
> indio_dev->info is NULL. Since iio_device_unregister() calls
> cdev_device_del() before clearing indio_dev->info, seeing a NULL info
> pointer corresponds to racing right before device removal from
> iio_bus_type, where !idev already returns -EPROBE_DEFER. Using
> -EPROBE_DEFER also avoids colliding with the -ENODEV sentinel used by
> callers to continue parent or map-list lookups and avoids the named
> lookup -EINVAL fallback in __fwnode_iio_channel_get_by_name().
> 
> Fixes: acd8256723f2 ("iio: inkern: Add of_xlate function to struct iio_info")
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
> ---
> Changes in v3:
> - Place `struct iio_dev_opaque *iio_dev_opaque;` in reverse xmas tree
>   order (Andy Shevchenko).
> - Move `iio_dev_opaque = to_iio_dev_opaque(indio_dev);` right after
>   `channel->indio_dev = indio_dev;` immediately before scoped_guard()
>   (Andy Shevchenko).
> - Carry Reviewed-by from Arnav Kapoor.
> 
> Changes in v2:
> - Return -EPROBE_DEFER instead of -ENODEV when indio_dev->info is NULL
>   so callers do not treat it as the "no channel on this node, keep
>   looking" sentinel and named lookups do not overwrite it to -EINVAL
>   (Arnav Kapoor).
> - Drop the unrelated indio_dev->num_channels bounds check from this
>   locking fix (Arnav Kapoor).
> - Move the AI coding assistant note below the --- separator.
> 
> Link: https://lore.kernel.org/r/20261126060615.63790-1-iasnezhkov@gmail.com
> Found and drafted with an AI coding assistant.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> 
>  drivers/iio/inkern.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 1f22275..92b6679 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -145,6 +145,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
>  				    struct fwnode_handle *fwnode, int index)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque;
>  	struct fwnode_reference_args iiospec;
>  	struct device *idev;
>  	struct iio_dev *indio_dev;
>  	int err;
> @@ -162,10 +163,15 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
>  	}
>  
>  	indio_dev = dev_to_iio_dev(idev);
>  	channel->indio_dev = indio_dev;
> -	if (indio_dev->info->fwnode_xlate)
> -		index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
> -	else
> -		index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
> +	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
> +		if (!indio_dev->info)
> +			index = -EPROBE_DEFER;
> +		else if (indio_dev->info->fwnode_xlate)
> +			index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
> +		else
> +			index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
> +	}
>  	fwnode_handle_put(iiospec.fwnode);
>  	if (index < 0)
>  		goto err_put;
> -- 
> 2.54.0 (Apple Git-157)
> 
