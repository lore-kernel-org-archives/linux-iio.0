Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733303D969E;
	Tue,  6 Oct 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280123; cv=fail; b=IynttfdUb0GQ/xq4XxPgnSdS4ubSY9yJLNj+NYW0v9BrkchcSkfKjtHrov2OXT5aVEb2YX6ID1DR3rJaBhulUFX11jxKCC31HEc/iX96c+dxeeAsmF6l5UYwImlVo8XyjKB9VMrlz6qmyCk35iGxSq3+Co4NAV+IhBZQuubx4Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280123; c=relaxed/simple;
	bh=YNCAhYW3WvJJVGEIVCUi8BkOHpeFG0LkddrfYZohV8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gWQAj5HBAD8G/u+lnLLf8spStwNJQyk+QyB+QVi86cP2It8Z3LJLs4R/CBNZHcO0jlP/UTXEDfX1Bw21IqkigiHhq7SodrtMA+wcxdsSaGwIKjtaFxDIYL20Uz7lbZbWxum1EEA6qrzBPuFLs8iAhbFG/QbSsk4GoJjD9stwOZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=bccvL1LL; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=V30vn+Aq; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="bccvL1LL";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="V30vn+Aq"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966c0xD1226319;
	Tue, 6 Oct 2026 05:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ze+lLseWVs2mwn8i3mDvQRLYjEW/WOQvepaH7D4cZ5M=; b=bccvL1L
	Lz2J1wg+wDm/Xs1WMkrBzsumqUc2Q/vgzIGk5zMSO4TwCypVX1otAAqcsj0/aNHW
	hGAWaaTyXZpWNga/HRBO6PO9WA15GnPUxME1V78Wz92VaOhbKPijr+bV+58nBN9a
	EAUJvSMK6sRmZz7lJuR9nzZtlUq2V/iAYuamFsI+v2XVC4hrrZWq3LD0c0mW0Drc
	0iHUUB3LtcB0KJZZQea+WncrRLvBb9/3JDNBsAfKZCvnH3aeYgA/az+9Llb2AD2Z
	Hn8hg20U1/Wcu947FkR2Zcij6lQZwa7g8c4dVYVbPSfa2SZBj5ohI7Icwk6Y8J3R
	NH/EuWKAt48+JTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ze+lL
	seWVs2mwn8i3mDvQRLYjEW/WOQvepaH7D4cZ5M=; b=V30vn+AqEYWlabPvNYN10
	Wcjgsrul5OQkp0GPh9IQmoYy1XElK+7DPd+NvXqVMmgtfcnupcI5SC7qTVAzcH0C
	SGWwpU9kwMFv3ZdP4oaQdIXJ5wXQcBgyRdXVp4z7fk9CSoFkAo4dGp3kkxHR/wSZ
	sfXBO4Eq6Jh2chu9yyKz6DVLLxbCpLKbzrAvkBQeOsAhBzMKkP5Q/OxggzDVsOd7
	lqvfxqa5Z6UkCvBbHZ5tjJUbobjaQeYkobhQ9DJgcNhQjQSQGkatm50XFCk3bX42
	9Aa5G6J2VQ4FunPfyUr5i/ytteIiGlh5fbln+5imeQGLeINiHGS5Uet/1h/unKjK
	w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h4jvybgtw-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 05:47:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX8isepMjdVsEVX7YnEFRhMHW/w4WCFFeNEtw3CYuudz0QaWxEGYTU2F96niMBTKu4/qUq95cNewxfToWZUknr9Z/te2bMSklVC6V8bmAhaTwhBeY1Fk7gT/fGVtAbYEhRLArNd5BZEmwcXFOiHSmHLIDXMKNaeVkIATB+1+WeNlJbuZfcTvJK5Rw/YlbBBf+3hwioq9cF9IeOfvoX9HggUS6AUdYs6ErsSuzb8P0yXJMBvUYoD3BEDheww34ZkKBUvJJh2sGouLgBc9selHL3CSqTRz8N4IsWa3XpJakxxM8SdI7hwV3KU0lJMeYNDM2uRFMYpapiUtawDv+yk6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze+lLseWVs2mwn8i3mDvQRLYjEW/WOQvepaH7D4cZ5M=;
 b=HBjBJtohofD1nOCjNEsH3iw1sBg+7GdF2G1LVEKk9o1aiBK5fSrbdJgcNRWMeb0+ZYPoplMClJjWs/5/v3VtXgLN/7gJWFU1CXeUlFoJTSVLQRrV/rW1pDXkuDRGN0hb6khnNgc6ws3J3fyMuxoDXayqncROaQXtbDbJUOQ38tQNcQR5aokcJsgdG7kCUkF3NUqw8TEGyQqJ6/KSql8YTfdyW4tn7hZeShya3cRdbYPL1L6x9GSdQ+VYxLomN3nAO3NjFVv3Gvb+Y9DetOktZRjho4bQFf+sAKrBafgH3rgOjqypXXI7jzJJDVCZaZiNc1m0/DR0yktJFTJ2iCUHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5472.namprd03.prod.outlook.com (2603:10b6:a03:27a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 09:46:55 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 09:46:54 +0000
Date: Tue, 6 Oct 2026 10:47:57 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <asTDTxneqrpFlZi-@nsa>
References: <aqz1-OzFobOROuBw@nsa>
 <aq18_TMNs4EJzgZO@parshuram>
 <arDtEB0na9DxDWAS@nsa>
 <arFXc0LqEpgWSS6m@SMW015318>
 <ar-Il2qP_Qms3Qw1@nsa>
 <ar-13p3a7ENGfMOF@SMW015318>
 <asEWwIfO0LB27wj9@ashevche-desk.local>
 <asGk4fj_HQ5HupB4@SMW015318>
 <6f5dd1c1622adbaf0174a949ca91cb11872087ff.camel@gmail.com>
 <asSqVEHe8EjkbcwW@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asSqVEHe8EjkbcwW@SMW015318>
X-ClientProxiedBy: MA3P292CA0063.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: cec89b45-b31a-40bc-4a17-08df238ec047
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 WhyvkeHNcuG7zYJIcUiBKnzb8qe4howdt7oTDeSeD3SBI/83+SqVDOOwqKDyDU2yo2MfBNqabiBcIPbzuBwYtCi7l4IJ8U711Ktm5w5NwVaVarqV2erpvCLN6JQtOoREoLmhKV+962IUbWsZXAZemPv55D99FDLF4qLLq8b362apYs2OrAlvW64N+kV3KO6psRGjKLyp7QDh+0ElPPxAsEZuN6H+27YvVI5KHBujqcgRBu4lCfTcaIudugYP//+KgqoyG27bHB/hBmzLspWPn7wAz11gDNas81XDwEALOitny4pn9wYvHAyn0z1Vsi6cssyxv/AiVJvhdYEcmd6QjTzHfPULn7cje+Dyx78ANXmRIbKk6f1SHeW4O9H4Jcfx4jr7yL2gIjU/DjLzP+MnT+4traF5oL3oPx7u+ZYLWs+7Qf09jIxtLhpBn7wsB9kfH0xZ16jwuOwq3MFb/27NT1v3ihHAXMTK9WZMvpvatFpbU8fYqJzfdd9E7I1bLlGANWMDWQNSLZRwYFW30GhiXePranlDXfN6WxZMo5dUt5KRM4BXEdX/nRQd/LQqdYGUJ61zzZMFBknW/+DNNrUgIQavHK8Mn0u0uttrt/rx3LXxWVHZ8PhoN2y0CYL3UPh3DGGkEZdnosF6ghn73qf3RGzwuy3/EAslCVG9/pnUpqQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aWswQmprdTJvMG1RLzVLRTl3ekpDc3dKbmM3V2NYb3pXUzZuc0RnMXZod0Uv?=
 =?utf-8?B?cjZMYkl5eEZwY3hPOHFDY0M0blpDb21ZYmp3cmFSZjRoU2pkdGZUbG1LU0o1?=
 =?utf-8?B?bTEzdWhSakJ2bVphSTFGbnZvTk5SY0ZEbVZZWTFjWEY4U0JTblQ5UGpCMFNC?=
 =?utf-8?B?OFYrV1QwdklaQnEvUHNhVjNIOTlPTHExV0graGsxN1d5MGNyVTg2QTUrTmt3?=
 =?utf-8?B?Rm4yUWtPY0RjMjlkU3pKLzJGTS9zTk5LVEtoSWZneENOSmVVVUJiVk82bXNS?=
 =?utf-8?B?WW9MVjJFZjE4QUhubk84Z3dldGg4dnVJUWxQUzNCbi90V2FBUUUxc0pZWC9E?=
 =?utf-8?B?R0djMXJCTDlhd044QkJyTVhJOWFVZFpoZW5naVVDcmcvakVaNjhSci85WmZQ?=
 =?utf-8?B?UnVXYjRTTnMzblZ6S2VvVzVYWXdnTlJZYXVKempHb3A4M29IUE5sUGFxQy9s?=
 =?utf-8?B?ZzZ2ZXRFMGZFRjFJK2Y1cDRpTURxMTRzR0ZBeHkvb0FBV2JJbVowYk5JbXhQ?=
 =?utf-8?B?OEtDcUhLQ2VwaHA5a05UNVVla2tvRE00Q2pBRDh5eWQzeGZYSWszWkM4dnpy?=
 =?utf-8?B?akZscHZhRmFmdVV5Qk41N0ZOYXhhVms5Ukh0K3N3amdSWkxmRXhGa0ZEWm1v?=
 =?utf-8?B?cHBwQzluSGRnUmhJVytKRGJNVDdidytDek1jMUtFMURLd09qTWthaGJ2S1JI?=
 =?utf-8?B?NVpBM3RxcG1sVDBEak9SZGg3a2JMWUtxSGp0ZjNIMXBPTDJRUGR1Rk9wQW1H?=
 =?utf-8?B?bG5ZTkVPMG5ucFlsN3VSQXJ5NWpGeEpQdEZRUTU2amRiVUhqQUtRRWRhOTF5?=
 =?utf-8?B?R21QV3N5MDlhN2luQ285MDc0VEd4WENqc21GUkdRc0pPcGYzWGxlMU91Z2lW?=
 =?utf-8?B?N2dPTHJRT045OTZhMVBCNitVeEZjSlZtODkzVU5vOHJiQkZPeTZzVnh6U1ly?=
 =?utf-8?B?SVdJQTJkRkJoN2RCS1RHb1Z2ck9zMVVJMFVyNTVnbTZyYlJRSysxeUtNbk1k?=
 =?utf-8?B?WnJUVlplZDRzaFBlcklyNlFkY1QvL2k5MU0rWWY0OUROMnpzbVpXNCtRUFdN?=
 =?utf-8?B?anF4UmVBaldIR1h1cWRHV3VpQmRSZncrZUlnc3VFQXpHOEl5MXlRY3hlcjMz?=
 =?utf-8?B?UWRGa2w2N3IrNGxjMHZEZmhNK0NSUnY0STNMTjhOTEV2R1UvQmM5NDFzaHV6?=
 =?utf-8?B?QktqaXB3SktHQVM2TGZJM0RCek9OYUszR3VmNWZsN3daN2k0dmFocEQ3Q1Fl?=
 =?utf-8?B?dTJoSDdmV3BKL3NFZFZaS0llRFAvc2thOXNHTy84NDVFT2ZUVC9zUmJNazNC?=
 =?utf-8?B?Z3J4YUhzV3pTZzQ3dUVPbDdZaC84RVpzOHlaZXMwNktVTFAxQUNoZDdaY1hi?=
 =?utf-8?B?bnJ3NU00MmJEdXhiSllvVFgyM3ZVbU1Qemhhbjh2cmZ2N0RQOE81VkppL2Fx?=
 =?utf-8?B?TjBHR3dzNzRmZ05QSGlaZGx3RmFEUnoyRW5BZUJVUVl1Z1BrN1lVakkxL2hW?=
 =?utf-8?B?VTd5TUkxTWZqTzdTcGt0dEJGRXVFaTZGWHhnYUxqeVlRc3RnTTdyVlJQaTg0?=
 =?utf-8?B?NVdOT0lhQXRuZHZ0QmFRUCs4Z0w1cC94SEVDUW1FVU9EVjY1TGJlNjhiMkVa?=
 =?utf-8?B?MGlXSzNqbkNwYUJ1Umo0bFhxbkJHVkVrWnFIdXQzbmxrczY0dDdjck5NdlJy?=
 =?utf-8?B?aGpLeWt1VXZEUVd0U0xJZUhlaHFRVHBVL2VQZG5JdVJxOE9xdWZCUC94NTZ6?=
 =?utf-8?B?eE5IdDNLZGMzVjYrS2lvWmo0VlFVbm1CYk1jMjlORG1KblQxV2djUGVWRkly?=
 =?utf-8?B?aCtRSU9HcGVNSy90OVkwellhZjNrV2RMVTNRRXY4RGJsV0RWMlM0bnJnODlL?=
 =?utf-8?B?a3VCQXl2STYySm4xYTgzYnVhRHFJM2tDcUVoWkNwaDQ1Vk42RUVsUDkyMjM4?=
 =?utf-8?B?OEMyWWNqL0MzWWhoS1R0N2hkdHYzQ1J4b2tVbE1RUzIvWDNQUmw2RUFLY0ZC?=
 =?utf-8?B?ZWg5RU0raVY0SHhySDBYZzdySkhSd2J6M2J0bFUzQzQvVkJlRWZIVm9iZG02?=
 =?utf-8?B?UjU5U0U5MksvVkJhTTZZcXdCc0JWUFE5VmxXVGtUR1BzUVJqZU9JdlE4RnNv?=
 =?utf-8?B?b3huYk1oZ3NRZVNYbUY2YWVqSzVLYnJZYVhaL2tzLzRSWWVJdTZ5YVNzNHY0?=
 =?utf-8?B?RDBIVURQSk1CUDYzM2dMV2R5Z01jRmxCbjBzSnpEdEEySVcrQWN2SFAzelRY?=
 =?utf-8?B?aUhsWmJ2Sm1LRkdoTkNGZVdnSDhxWGdpelc5L0RNQnNnbTJoZWJ2YnlGbXAw?=
 =?utf-8?B?L2F5aTY4OW5kTDl1aEJydGtCcytqdFNRQ24zV1NUQXI1azZ0Z2RmQT09?=
X-Exchange-RoutingPolicyChecked:
	hJ57l0EgEWa5Rf/8rlNCCs0Ni/2SP6OQ/7q/Me2QCMNnLETGoW3hixhWnCaJIW/4XiU3c1kYJA++V4aUsfYg871VTAObQNS9w0zztwrCXL675jX1IjrPBxqvc3Pff9aRefPKcDhCrJJxuKngMQrtr5fQTUbg2gKbhUM9VE+x6gaI1jcIWI7xw1PshikP3jRVFsgX7PP+F7HvMflghKJ+FnCSagu73iaN2R87NDw76/pqXMESP6V+2oy3aexkAJOu9WJv33YZFya+E5EM8X25esSmYH9pW3GQMzEuShfNl1o6H4TxPVABeWcajIcJAWTnoMO56pHC53NEfl+xNqaTCg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec89b45-b31a-40bc-4a17-08df238ec047
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:46:54.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzlDt8JP4zKYNjo3IYAm5qSePgnDCXQkDf9eGRfd3iJbJmOYlhOCjaOJDDL55/+qYHgeA1nzklIB1qwE1xl37w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5472
X-Proofpoint-GUID: Cs_JP4ZhUCd4QQC_noe-Wls4AhDOcXb7
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6ac4c394 cx=c_pps
 a=EtrKi/+kAVY73poqiPL3VQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=lEG6OgNh-kvjCi_ktPIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Cs_JP4ZhUCd4QQC_noe-Wls4AhDOcXb7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfX4xq1xH/ZmVQA
 DAwwSpD++6mrpHFDyY+Ai82Sy2owe7mvo8Wi9XwnUmRiaaB7YiFhpW6TzEL8gu+BnSmWoJNUzvg
 IhRxhVp5VWMCEyTg0pYTXF1EZ1iVgcNdhRmIxs+mbuQsyc1UQa1YG0q6mPYRKG3heWASFwH1bkQ
 5c8hdyoL2aPAC0DnoU20FaBOPYYIMk5/wv8AChpIPVAqsTpc1bnhqIzTO8ahKBIGW8/9UqjickS
 QdrZ7N1wv0EKLZNIGNQIf0b9ZxVz24hj7iOf4xlqGgnHnwOiETiLTNu27KeLN0mU+HhvQiK7Nn1
 r+lacZ4LU7nBf0upIGzHBNLwiR/JpaXbhYZReI3Zc2sh4Dp8uchUPa9K3jgM/Qg3BFVD1RZBaQ0
 HJAuR+wnR019Y2mVmKV+KkoxFxBb60B2DUTJFo2WRjYhew2XFQOGqh9QKWiX4sZAkJwOfEBWTiS
 sd0k3UcsfNbDXVasRAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfX8rIshReY38Od
 lD3HlzvrsNrwcF3lSMihDXogq6DQrzFc+SF2tuw6n72oLIVVfaQ6myS0fv2iIhME+ik12RazM2s
 nDyEmwGEzGVYPh2z53t6lLs5C/kdsGcPSOxR9fps75ODX8LMYBW+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060038

On Tue, Oct 06, 2026 at 02:59:16AM -0500, Frank Li wrote:
> On Tue, Oct 06, 2026 at 07:36:06AM +0100, Nuno Sá wrote:
> > On Sat, 2026-10-03 at 19:59 -0500, Frank Li wrote:
> ...
> > >
> > > There are already include bitmap.h, and use
> > >
> > > typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;
> > >
> > > Suppose all DMA Engine consumer will use it to do some check. So I think
> > > needn't split it as indivial version.
> >
> > Are we sure all consumers are making use of dma_cap_mask?
> 
> Some legacy user check it. Supposed needn't check it after get channel.
> I am working new API to check it to avoid direct access it.
> 
> > In fact the only function
> > depending on bitmap.h is the one clearing the cap_mask. But stepping a bit back,
> > bitmap.h was the original proposal from Andy so the idea was to have the new
> > widthmask (this one indeed heavily uses bitmaps) already as a split. And with it,
> > came types.h given that the DMA enum needs to be used from both consumers and
> > providers.
> 
> Supposed provider is super set, which can include consume part.

Yes but also look the below note on the consumers.

> 
> > And note that consumers might want the header without actually needing the
> > bus width API so the separation kind of made sense to me.
> > Then, as a follow up the idea was to also split the cap_mask API into it's own header
> > with a backing include in the main consumer header.
> >
> > So if we all agree with the above, I guess the current series does not really has to
> > change. I see 3 ways:
> >
> > * Just go back some versions before and have all of it in dmaengine.h
> > * The current form
> > * s/engine/consumer on the current proposal include/linux/dma/engine/*
> 
> I think we can put include/linux/dmaengine.h now. The split/move need more
> work. I already sent some patches.
> 

Ok, to be sure we're 100% on the same side, plan for now is to add the
bus width API directly in include/linux/dmaengine.h?

- Nuno Sá

> Frank
> 
> >
> > - Nuno Sá
> >
> > >
> > > Frank
> > >
> > > > where it's indeed required. Besides bitmap.h there are might be more headers
> > > > that "include half of the world" which should be avoided in every header file.
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > >
> > > >
