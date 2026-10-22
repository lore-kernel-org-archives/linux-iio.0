Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792665083;
	b=JrwBE3RO2/+SUaYSArPLxPBuLUC5CSUguff0qJiOuNa715HmH2Qy5wfg/ybE7c8GxukE
	 JLjSTx9+Se3XPBvxLW+QFuEA4/F7pOquADhWTwhcbmSGIeIyS7tYKLzBKIjsjeorfl4fL
	 qPpSqz/emDa9UOdw3tUgc9QyZKKziYp+nVSzgfFu+JbmSMmS+VVBWYSzb1mEkLV6YQiwG
	 mFnfoW9NrmGQQjRLLOQJ7nVORAjfvFqdH1Y+13eKxMzBoqujDxwmZO7OR5sBOeFue1lvm
	 4bV597HJ1bS/wq9e+nPogP7+MnvEPw6cFvsG93O0Wm4UZf4U5aXQIJdtUfNc3mrQAJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665083;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Content-Type:Content-Transfer-Encoding:Subject:From:
	 To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=h7Rwi9jf8sbeTQfsZhp8F0e+C/+WuGKW9/vAzgQjFQI=;
	b=W+dTSPtrjOHy7jg03IKiXZdY1cqNsVR2uxsBh/jPMzF7vza3nd9bDkHIn5NcPHGkD4q7
	 p9h/v7hnW+ldtqhB+va2FuJA6zeBPyymWDygIFIk3GDbu7b4rCqsabp472u4Q7spRSqbY
	 ylpWH4ywIN7tP6knu8ZZvUPtAzUWRaZ0601uzXK/w3WRWkjkOpTdPqf6sajpHwLnOqGtB
	 T0osw0lMNvwa2i+dojX+ixsrchcDZKRxT/fjMRCtCRXe7uLB57mb1b/8vyMACfuCWVRV1
	 z7Lcp+sv1B5qTj4hNN0rV17HZ3zNnnsmEry/gUIH66U9QinIZMwWISEDQppb++OR+pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="EPL0V1V/";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RbjRBwph;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2A606A320;
	Thu, 22 Oct 2026 10:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB2A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EPL0V1V/;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RbjRBwph
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1KLt961731;
	Thu, 22 Oct 2026 06:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=h7Rwi9jf8sbeTQfsZhp8F0e+C/+WuGKW9/vAzgQjFQI=; b=EPL0V1V
	/MwuIlQALAyoHROc/lUSNtaDDEBB+nWYRxQ7QKw9OaizLbXlnL13G3jdxjWb4sX3
	1Rt5Gzi0oeF2BPUUdRO8iBPE2BlvxSuuUhytDlfIR4hJiaECFdy72xGqT484FIZO
	NldzRFafaNVB+z3LV2ZZ14+V5lGpQiuo6YtDq2xCg0DKqFh7/chzOGX5k+IscZB9
	hQH8SiUueiov52Y0MBN0ZSkkk4dy2b7IoKznxChd5WWpipyYM69cZJ+KAWIr+VsG
	c9e/OTQbTtAtrdB9qJY1THlgXO6cDrcm6XBHdAxuNMSPiClxRKlkMUqmaJPcG7xU
	suoj8QgoKBIXP9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h7Rwi
	9jf8sbeTQfsZhp8F0e+C/+WuGKW9/vAzgQjFQI=; b=RbjRBwphdjp5wwjzg9fwJ
	KB3c6B0fk5mNsjHqFOsawySAZlZbrnj9Jc61+Z7L8Aw1jrs5vp5jwh22MDU7BTmM
	pkUzgwPY4JZUzTR/PC16LJDDn7rmUtytaBND9ztu6qp3bQHYVmCCtIAYHrHzbQ6C
	XSQRbjOgXI6TnNO8My1RpfCu/Rd/PbljZ54dNUnAdDmffwsU3+o2eM97qlSV+nSe
	GiQOjMvW9ZrmvLX91OX5VCCFfExAiH1cc23AuYdnhjjTzU/F+Ek7ZjqVVO+ovlg2
	+iGJ1mRTHg+gwnxbKVUr0zYQzffsboAvYJEwUa6Fh1soGSqvw+M6KuInNlnUYy4r
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hf9f6t46d-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 06:31:18 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEmApETngsxzbCUPG2TKfl8+uROXSALYuTD+Rj/1Hfu0xwpG16yJ5f+tuUGepep2uNvhookhiUK4koIbWphEKmsyvQiS7nGgDHf6xiKLm8BGMDmq4MdbtyWvRSllwyxINALKjPUtpWaZoFyK30lpqUwidOC/RAVR9AXZTCDzlqpvNmfEDAtTuedrOMaXH13LrveYgEohNaTDwmROR93SZBvMVoi9lDVc+wptPxV4UkSAgY0RiSkuRLI9rh5tu3E0yesEYuFvYMg4xfGIdw11o+it3c7dxJBgCyQJQPvYucslYdznt8R4yYB23NZsFbnNC0Dd41/wWeUH4b8S9Csq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Rwi9jf8sbeTQfsZhp8F0e+C/+WuGKW9/vAzgQjFQI=;
 b=rTi7F2Jc+wF1vjhSrZHvAHg0slvZpcP4U33i9ZSZ6FwxwbJ45jrHmXhOSNhs/XygEbNoiECLNXEVvndPBYNm+p1SvVB9BUXwwpPJWj/lyf2AxmqrJhJJrZZqRd0mTrPPAH38VQ1Eeeedd0WRavk2FdP7LCLWLkU5GfpE+4V+sqIi4QsnHvtSKdFM0tCB+n2LFKJloT2OovBJ/6Wk6scmRUNrE+6WaMyAX1CJzLN1AALXB/WRWUbPGlVLy5WcAft6UapvhFKsil6V/wjXq/8C+a9gKuseMcOIQpPBX1umNbRuYClArUDT8AJkmdwUC+Er44IowVDYF28tSRfkH3/TmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by CH3PR03MB7484.namprd03.prod.outlook.com (2603:10b6:610:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 10:31:12 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%5]) with mapi id 15.21.0522.016; Thu, 22 Oct 2026
 10:31:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/3] iio: adc: ltc2497: add FA/FB line-frequency
 rejection selection
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20261022-submission-ltc2493-support-v1-v2-2-391d908d2877@analog.com>
References: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
 <20261022-submission-ltc2493-support-v1-v2-2-391d908d2877@analog.com>
Date: Thu, 22 Oct 2026 11:32:19 +0100
Message-Id: <179266513951.3528.6277637511257028016.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792665141; l=1881;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Bn5JDQye95ilOEcwHPhrEm5wKPUcBocJblXeMN9wVBA=;
 b=f45b73KT1mXRsvMh22SQIC80kAv9Kbtg0Dhnl29fr9Xod8TUWdea0J9sOqFmAYZRoNPQFcXBr
 T4WfTDGG/6kA5SFQ2Qt3Pw8OI/VhYZCx6ORtgmL6r2xj8ECkiKtCQ+i
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0030.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|CH3PR03MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1c6cb2-ce9c-4b1f-62c6-08df302797b8
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|261021121427099003|6133799003|18002099003|22082099003|261021135927099003|3023799007|4143699003|261009223027099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 v3qP2NGqbaQyMup1lSQrNENDJssD+JiyPWPiIJYrxcTDNe/R8TSvIJLB0b+TaHpfQULHlYXZdlS/X6pRxJWQGaCfZ/oLmuaONRxo3kvjBc9kyZzc1LRBfHWcTkRQPOn00nFM5s6IyuDllqN9qomeKOiJILhT2JMGdvBzOhPMEuAxpqeaId71TlxVdnZQyTogQd9G0kN+OfsouGS3HybCNwVfGqXr8QBDBA+DvZ3qJ5sin8OteEng3KVpQYe26s6MW8jDXG8bMnh68uwQ+KgnKhrz55BRdRJL/PzoV2vQ8nAHVrSo6ddMzpgVL9RaOBALivpwoqaewJJFkUcau4l87Z8QsJHHzh8CZaullFIv2sSs7TzKd1wQNzgwbfJSVZeHkn46ssdMVqEunWYyt8gTQbcT/Ie0gj8mWOtPToHVOztC3JfzE1pa6LrzNvEIbwdJO23T/e4Ktwh4q6L7Sn+qAhMZADt+/F/Fs6ZILVXG6fsr67pZhtJi+8ya+ztVBADlPbW2gOEE6Ksy2FvyVxkbs+XQh53v7s5P/u9iImUxSB52+YQZQRTESA0GtSa4/aYKljHSykLGL6WmaUYBEngz0Mfg5JX8H7emVux8IhYViW8MIyuwPWchnfGjNwTM2iB4TgtxSPSqhN00UlhvxRQ561t/JHHvoi6htIsvClxGkrM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(261021121427099003)(6133799003)(18002099003)(22082099003)(261021135927099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MzlHVWZPUS9Xekc1SzNPTklWOVM1NU10RExXaFpVNkVOV29xUGxldkt6b0l4?=
 =?utf-8?B?KzQwUEVnMXliOHRMTGl4WGRlc0NzNlk1Uk43a0FKNTJyZUdzd1BzSHA1R2dr?=
 =?utf-8?B?Sno2b0VNS1k3RE9vdzE1cC9Jc3JHUHVYN1R0NTRuQmVyOFljRDlzTnhXMGhx?=
 =?utf-8?B?TWRERmV3Z21oVEZObkc1bjd4Z0JwVUUxYVhtQVVLU01NTVNUM2VOTmNkNDdT?=
 =?utf-8?B?c1B0NUpZUGt1TFhLekl3UkluT2FjWkVSMW1uQ0EwRklzckpONSsweUt0WlNG?=
 =?utf-8?B?bHhOVlRYU2t3TC9LbFEzM1hpNHhBbnFiTlJxbFZWSEVHTDZDcXBpbG9CSksx?=
 =?utf-8?B?UWFUZGRhSDVicUNzUXVVQkhRTERVT0FtZEprUzJZK2MzbHBqRXNCaUk2c3FK?=
 =?utf-8?B?ZGx5ZDZhNzlpZ3RzMFhpMEpXVnM4U1k3cHk0S2xoVm9mazRnR2U2bmNKdU1i?=
 =?utf-8?B?OEkvVlN3V2tEZWtkOHBQOFJOVUtrbVAxQ0RHYWo3MHpQTHdKanJIT1Yybk1C?=
 =?utf-8?B?b1NWWlpJa1piTDREUW9ZUTVheVZjRGRzUWp4bWJQWmU4bVFuV09xNE5JaENa?=
 =?utf-8?B?OTRKcEdXTDJHeEo3aEN2OUVxQWdjQzJzN213NzlmMzRQajk0N0NrdXFvdHpC?=
 =?utf-8?B?bXZIbFlxVHJJeU0zdE5yak9YUytmSit1UEpQV3BpakF6WFZHU2lTMjQ5UGVZ?=
 =?utf-8?B?Y0xDeFJrcEJONTdVN2J4Sk44L016aVF5QU1ZbEIzWFhodzd6ZHE2cVdDeVZP?=
 =?utf-8?B?V2NRRXRaTnlZNDhhOEZlSEM0ZDF6TmZXczBMOHNINHB6YnZRQ2FPVUEwZ0ZL?=
 =?utf-8?B?ZzY5TERoMFZpaTdzc2pnLzhQQWU3THAvM3JxN1F6VSszTkVycnYxT3gvdGZT?=
 =?utf-8?B?SDNwZFV3cjZ5NUtvWDFtR2VUVnBiY1JsNlc5VXdCRlluSXRZWVhCUmY5MVZK?=
 =?utf-8?B?bDhUVE4zakFZaTlQSy9LOEkwZkp4M2d5b01VR3RqMHE3THR4UktjTlU5a0pi?=
 =?utf-8?B?Q3VBU3hvMnZlcnZIVS9vWm5VeWQ1b2NjdUpJRFM5bDBUOEJxczhzYm4rU1N2?=
 =?utf-8?B?QjJoNUQ2SjRHMC9URXJxRmVCVWN3QXlGeXpLYWN0Q0V0QmI0Z1N2QkJGUVZo?=
 =?utf-8?B?WnZkSktyK2w1ejhOd2UzSE5KR3RsdTJSNy9tYUJwa0ZvWm5md0pQeXhFZ1pM?=
 =?utf-8?B?dXIvNGxUTXkyaHZFa1BtUFpGZ3dJdE9tdEh3WUw1TGorYTlDVnNPc1R2TS9Y?=
 =?utf-8?B?ODVnUXpjUGQvSFAraWtOQk11L1pyQmxQRWgzMGVBVWdsaHdLTXVrdmsvbHRi?=
 =?utf-8?B?eWMrSldXZ21uSnZydGQzUHNBZmZDTVdka2Q1c3J2bWFKS0FuMzlueEJKKzZ0?=
 =?utf-8?B?Y2kxUGpCZ3RYdDhrNm9wMkVKUlUzclRobWtkV0ZTT1pvbU1KL3k1bEU4WE10?=
 =?utf-8?B?Vm1hSHVZL01Ed0cvbHBLN3ljMWZjdHJxa2JBTGJNd1pjOUFNL2x2VytsSmI2?=
 =?utf-8?B?YWllSEhpQitCcitienlhbVl2ZmgzdXhnUXNZMjBPcW1JUFFDZzdyb0FXTWh6?=
 =?utf-8?B?QWxtdm9VdnJ0bUJZVUozZ3QwVWlOREVoSDlzMG1wSDdLeC9HZjUvZVNDMzVG?=
 =?utf-8?B?NGh0d0JsMmRHSE5PMmdOd3I2WlpsNURSVTVnZUpWRW54QnJpK2M1MzE1OFQv?=
 =?utf-8?B?UDhMTGgrV3pRWWdzSkMvcFBibEVlcXplYmlTdXhReERlYmNBV0NuS2tDNXJv?=
 =?utf-8?B?UXcwZnNQRklKdjBMWHRJa1RQUTVtb254STltNzQ3Zkd1WDFXUU9SS1lDdDlJ?=
 =?utf-8?B?ZjJ0enBoNDRYdW9uN2tEWGFQSnM5OFVucFIrZDRtSG9iZUl5Z1BvOWtBVWNF?=
 =?utf-8?B?RTI1V2JCTlQ2ajh6UXF1TExhc1NnNlhpMkZ4TjYyT1MxYnY5U08rUi9idmhR?=
 =?utf-8?B?aWY0QXFNUlV2SVcxdlpOTVZ0eVR4ckZ3VnBpbjJxMk9YbXlwdEt0SjFrMlhi?=
 =?utf-8?B?Y1ZkTmZVaVlnNmtqSXE3WFBDSzlpRW02Z2VWejF4VUNmRHNDem95d0ZZQm92?=
 =?utf-8?B?eHIrWWZDTGtpMWZGWTJ1SmFnVW1teW4rUGZHU3ZMTFoxM0VnMWVYZFZuVjFH?=
 =?utf-8?B?dFVweHBKMExBU1ZKa0IrV2p5OUpUMVBiTHk2TlRUaWhWRmN1THhXZTJGYmt4?=
 =?utf-8?B?OFFxbUU5WTB4VUtxQkM0c1R6WWtBSURyWTRxWlFlQzBML0RiU1F1enNQcnBa?=
 =?utf-8?B?Z2Mwb20zWDJZUm5iQUFkZEVvdnR2OTVYUmUyZVBHZEg1SGFabEx5UExhSENT?=
 =?utf-8?B?VHUwSGw4TURNVnAvZXdtMDhBbVZOUVVvbmxtV2ZJeTRieUQ2bnpGZz09?=
X-Exchange-RoutingPolicyChecked:
	k6ILDX7TM1gG5I6uOOLAcaJX7P+XTf6J5+MIDpq76WT+V8/DFvkRIbRJ9om8ZCHPXtlJOxPQbdET5hJtBm0wM9sRbonkp5BvL0JzYrNfISMCtzyrDbkusGdpAliHpYhbPW/DOdTjXXYVmXz0m9+j9TSFt0/Sahtd5xXHkwvHIf+nomZciisxQ1rUQWzcZiBrSF1IL6iuKNw1GZYsX+NBMByXM1W+Fl0/p7Yb1q7LPRi4Rg0BjvvO2OwqSuSi0gzHQnShIi/n9PTSRq5y3LIeiOXzoJDHRqU3/1YFsf6J/OukT/IB6C7nCfTVTJFE6KRSB52YjmQ+WHPmoe/yWc9HGA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1c6cb2-ce9c-4b1f-62c6-08df302797b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:31:12.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZASTumqknqdpEPW9PjgvVgN6lidVWrobp9SHavovafvgZnlwSQKAeeTuBsDLqyf8SG4otzRRACL5F8O0YE49xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7484
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX4kpLrYa74kX5
 +syMzL+zGChl6U3E9XQywd0FxXOauCZPc95fWlBIFixHq7W1AasJYz4ua3XCGCF5CBZ3uRawNGa
 YRi3YWEsw8JZ+Fz0e/HYdqdcFuIuYJBgBZlWLE+QZfwPefR/ZNi4
X-Authority-Analysis: v=2.4 cv=QsrLTlyd c=1 sm=1 tr=0 ts=6ad9e5f6 cx=c_pps
 a=3V5Erj4uy8rJXAE3nhxHpg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=O2HJKgaMeWOQaJELe0AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BaT2yO0r3LlJDRtbQfcW8atxlcgJYB4D
X-Proofpoint-GUID: BaT2yO0r3LlJDRtbQfcW8atxlcgJYB4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX1MPt8c2ghw2q
 IDObNO6asfE4CyaQ7BoFhDCIfGPIc+e0JOJypUehqh76CemkR8cpWXmGm3HeSqjs9Ljb61xjFI6
 JaAOcWFJ/nU/+eWgZdMX4nxVy24NJPL86Z/8FbVomlfTUITzXfg2/118FYaxhmWVqd4+L4zoNMj
 gpa/bJDmAX1eU1XwVNz96WwDu6+KtODNBYY6rqp81XKC/4wI0LS5e7F/SfTLQ6wzaZ6eGSiU7+c
 SXEVljoHYu/HBucBmSBUEsTZDyKiwPbT6IgL5NTAg+B/2ASuEhuuwPb+XHEllFWAA1d65MYMdEX
 7YocVcwqMjAIWX7BIS4NfQioShHJGtf301FpdhfTdlmceKdcNUg04wMmSuQRVXtaeoimXPsWTCH
 NLoAw339HcgsXtNRd19RjXhjosDb8B4Q69MNMExA3zCqHtyGq5OgnJ8raeYy8yzg7wIJeXp29r9
 ONx9e7RXC3yscU7kW4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220041

On Thu, 22 Oct 2026 12:58:19 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> The LTC2499 can suppress mains interference at 50Hz, 60Hz, or
> simultaneously at both, which is the power-up default. Expose the
> selection through filter_mode and filter_mode_available. It applies to
> voltage and temperature conversions alike, so the attribute is
> device-wide.
> 
> The rejection mode also sets the conversion time and the output rate, so
> both are now tracked per mode. 50Hz-only rejection takes up to 163.5 ms
> at 1x, which the previous 150 ms budget did not cover; a read in that
> mode could reprogram the device mid-conversion and fail with -EIO.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fa.pdf
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>

Just one small thing/nit (see below).

>
>
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index a6e34da83b81..c218d87d3a62 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -211,13 +220,17 @@ static int ltc2497core_read_avail(struct iio_dev *indio_dev,
>  				  const int **vals, int *type, int *length,
>  				  long mask)
>  {
> -	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*vals = ltc2497core_samp_freq_avail;
> -		*type = IIO_VAL_INT_PLUS_MICRO;
> -		*length = ARRAY_SIZE(ltc2497core_samp_freq_avail);
> -		return IIO_AVAIL_LIST;
> +	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
>  
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		guard(mutex)(&ddata->lock);
> +

Now we have a mix of cleanup with mutex_lock() right? Would be nice if
you have a follow up patch bringing some consistency :). But anyways:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
