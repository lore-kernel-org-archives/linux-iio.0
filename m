Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EB46AA7A;
	Fri, 16 Oct 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142518; cv=fail; b=gGR37dYTtOpjGdN1fTbNy9jmEPufTzgcbNhsIS99sBaqonCmAZcpinA8G8Xvhw/YOBoqvmccAJV4w8azx8RrxuktUp1KFWxPuqjwlQUmr/mSb36ntiuJ7M0tpmc/AdKX6fe1zhKm8YYA/4hkA/c7iUsv5K/Iaz5NagzAPJNk7n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142518; c=relaxed/simple;
	bh=jO75x8qrWVyz+Qp8PUDte842UC2Gu130fPceHPYkbFg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=HUM03wtBIaF+JnMf7wkWYxKVIR8n1jHmLt+8b41N5RKcpGh5fajImwHenthcCY++N6J0b7Q/KIzmHyeR4h2yIKOuOL6jF35cVRGXE47qA1F/esc65xYMD1t1F5xoNbtp51xTw3Lu+KSPaAKbbpCT4Jvo+yA9z8covupj3/VRVto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=FpFMkCno; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SSbpZ3u7; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="FpFMkCno";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SSbpZ3u7"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8mcKH3231773;
	Fri, 16 Oct 2026 05:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=tFP4mPDDs4yCxxFsyciX7lCniJBoRUQ0erG5VwFYgvw=; b=FpFMkCn
	oBOtIsv+q5LbXheR7Z0XAxJoqO+KplFONqY7X0WCzKVFNbEuY7CoaEbuhHyMuNzd
	jwdWEvdA/hcGAn27Upv0/PDPl170jUDnRAJ2iebTSkemoioSgfqljaExm2NkDEAg
	LYZQBPBC1RFuuNUoq7fDXpDr9dZJ9IPuVM/VDY5PbSRD6D2Fc7uJ4bG4UiwsBsZX
	oLf6oK+9AuHRDZM79tTfCf96uB6uXH2BWAtgZgdcAgcjTh5yWKZhZBMt3jvh5/dV
	BbwaA6pttnCgxk6Bb0s8AemNZIPa3htW9M9kNh0M6iXilx/LWOF9bcxluHRpvpMg
	MMkV5Hq9zgX2b8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tFP4m
	PDDs4yCxxFsyciX7lCniJBoRUQ0erG5VwFYgvw=; b=SSbpZ3u7hwqhJak3jPLSe
	6ce1Uh7ddz0r92MxV8+YUdUYKtcg833MCMUZMEcuYdmpqhHEVoAAc+NfWbjxnBIy
	GrhX9EpqrHp0A5srHfStmclfr34B+gNJaifAt+N5NAGnHDvlKZKvXcpj2hp+g/fF
	l/31gdBOpRlShgDMZ17GNK0P4G+7mjRB5ijvSxI5gxv0/Tkka8CN4UC5guyVwkze
	SPGxelznO1H8rLQQydtw66ZvVDz+sQWyHpLtOKkDjFLm73IbVy5ibxYMtjx9zpgL
	vXgIubYupgC32WjdVB4b5uWHPxCxjMZ6KISfllspGAY8u5DtlXDkqi9AD6PNTUNs
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hb3xxksqf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 05:21:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGyYzBIUUWH+QJV4Kl5nm2KEEvKnWE4Pm+jCKnBABXnvHCUzVnjwJiAmgJGmnPl0f5QumuQ+D/QeR3E7A6RrvM/KwZJX2kiJBTgy0g1/TrPp8HQQlk8xuhSh8G19Us8CM5V0TB6fKueQsqVfVOvMgEFloiitBrVaMigKJJS9N8Hm57Gz4aCNDjG9mcoBbXvHsIu789fDKQV1VkBxN0AkPi11/MIbQhMf0ICzdyymJO0XkG2zTwDvh4yR7/2RXElkjquRqofHhLzwxnaNiiG2AV5qltBv5Xgu6tG8Vf+3u+AWwzRY6vtNNVpDRPsvVLTj+eVcTsFvpBbjh1Zfo9tUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFP4mPDDs4yCxxFsyciX7lCniJBoRUQ0erG5VwFYgvw=;
 b=yodEN1t+EcDZZY/NCfkKFScRVp1RD3mNf8sFFydXPriyczEFjBmGUTgqsvl9fzjSY7hNSeG3NUtff5hwAaUGJH4jwOqFqgcshRD7Jv0T5ux4h+LNnAuYfa9rKoZ0yH4Phe8A8Ufere63+pgWChwO/5BBLa/fSYp4EPIzD8BwxcKimmWfngvV9pGct4lV/U82IQG13Fx0uyYisI67cDKZ9kch5IDiXVmYgamLJHLIIAUTAWSlhWj6OXVKvq9ee5X8F3n0k0T+p28a3/3YkrRc4txb0QpX12vBOXt9f5oxVRXB7BiWrX+GTXtvK5a9BWAJjUTeyKRM2bjnOZ+BFtQ2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB8138.namprd03.prod.outlook.com (2603:10b6:408:296::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:21:35 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:21:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 07/10] iio: frequency: ad9910: support drctl control
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261015-ad9910-backend-support-v1-7-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-7-3c21648c8e26@analog.com>
Date: Fri, 16 Oct 2026 10:22:35 +0100
Message-Id: <179214255500.3322.10204543307921240458.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142556; l=631;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=jO75x8qrWVyz+Qp8PUDte842UC2Gu130fPceHPYkbFg=;
 b=Ymb5KMjTyfs7Jwr9w89XsOTkpnkqPpfTuKLR/IAlWgFkkxEsBy5hUv3Jjza2/SAiHPoJQOm0K
 rk9LkSiUMcaAsBqIzGul9MrEm9P6me2CIHXOUeTUZL+BG2OMEa19RXG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 425ada56-35db-412e-3dc3-08df2b66dfab
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 bYkIYs3e6s/q0v1wOaZc95SV9T3hj6Z0rNPf60D8WB9jb0zZyogKheB7REoedHaJLWoh8V1CNTzQWTs/gziZdfdY/BTZ5gsitlIyO1XPdjISGUq8Bdi2F/uJi/gntVLxOc8A9Cu9M3c0Hm/7LIkKU5GxPZIS7JIShPYi85QefZcoTb5WvA4Od65crAE1XuotEV9eDfhJjwSDZHbGaj0S18OqfUn8+7QDyDWSOBJKye5upUjV1TMIx5OQnfOI/WQZ4dU2h9LA/JP4r4LgPzvN4poNcc/tmFvV8DotMjo5+3rLCxnrMULICuAETDffUFx0jCr30vqBwdBzXrAr2biXrbSWaXNStBnT2QW8p3b7j8fuz2ThT79hFTqvwMWQMTIKnGpnbSNMVTOtNkiPzVATSRJych3KD7UWOOvzfA3jenM1S7Hvbp00e7BUceQMY9xSzq3Tx4e87eGccVbp0TZBJRVpnT+/mQTmwzbAPtHbRu3SRQCLdi9DcsNolhyrC6KFvEHUijugQHk/tmOXe84BsB70TXgbtPK8ADH/0fefJtanykf2qGeHk/glmWXO/iDOtq7W22nOxW5vZRWtofoUZdKDVy08aJbfl81d8OkGRKT+HFzpNcXe78WgYOBDQU5Y4AJu2efqTkLBX9rVLcJwAEudmZTm2gDi1Sj3ENrKYLo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U05CRlNyS1A5di85VlpZTThqRlRxQ0pqNzc0K3ppU2pIVU11ZUMwbmgvNnZP?=
 =?utf-8?B?MWdvNk1MZGpKTDQrbmJvUlF6ZGM3VXlYelljeVZVQkQxRjdGL3BFRmlDNlUr?=
 =?utf-8?B?bzQxOUhPMmgzWW5YbzMzNzVsVmV5eGF5RGpUaFhVNnhlS2dkTFhpRWNXWTFw?=
 =?utf-8?B?cURiZTltM0JyWHJrdTREZmtjbWpVcWJaeFBXdVZQZUdlazNMRDExWDJMcVky?=
 =?utf-8?B?TDYvbGpXQldHZTE1eG0xRVhkd1gxcXFsZ09ZTm9wTCtyNTA4K0dZVVB2aXZi?=
 =?utf-8?B?cnZRMEdST2RMejlpREg3RkpxUU1pczloU3VyUXJLSVlQZGl1aGZzYmtXd1RV?=
 =?utf-8?B?Qzk2MWdEcVM1RE1CeXVrTkNnUEd1MnRRWHE4Q0g4VnV0U0JKTnMxMjZFeTBN?=
 =?utf-8?B?eHUyaHZCcUdOTE5NcFZxRUhJNytuZ3FZTERVSFFWOFF5cGFQd2FpR3FtSTdD?=
 =?utf-8?B?OUpOVjVmd0RiRHR2TWZVRVhBbDMwQ0hKRUZxWFdNdWR1c2tObVp1aXREQ0wz?=
 =?utf-8?B?V3gwQzBjVm53NmdxamhaSTV4SnlKWTlLYkdHcnd5czhVWmxHa21sVmpGbUNJ?=
 =?utf-8?B?bk1iUmd5SXM0dGxpMTFRUGViZzVmUXFwdHNJRDVRcmZ1dVYrVzQzbU9iY2hU?=
 =?utf-8?B?RFJ2OWYyT01LZ1RWT1NRL2pvR21SQXk5ZnRBaTh4NW1KOUYvWWw1MzU5aFNk?=
 =?utf-8?B?K1I1a25wU1dsVXl1a1doZGZpRXJXYktLOEVTS3VVWEVrOU43bzdXYm5ETG1E?=
 =?utf-8?B?NHFVeWdzRGt4U2Q4TitwSmx2Y1RmWmdjWlFqQ3FJM25WTzlaUUdUNHIwWGla?=
 =?utf-8?B?SUJqOUEvaDhSN3pNeTJCQ2hVMmZ3emV4M2xiZEUvdWFvY1B3NDN4RlExN1Vk?=
 =?utf-8?B?M2hNU2pNeEFYRVhyL283MUpuNzBWdzFKK0hHUUxaVjBjU1hrUXkyaEx1QnJh?=
 =?utf-8?B?UUl0MlFqKzIyRWpjMGs0SmRMQ2htUjdnWGpJdnJUUlBvTTVQb3J4V2djbmJB?=
 =?utf-8?B?ME81eXNZZHQ4NTh5TGVuL3ZlZThUSVdURkQ4QXRqbTU4eGVTb1M2bHhyYm9L?=
 =?utf-8?B?ajNHTGZWc1BzWDJML25PWkFxTXIrV0NCMnJ4Y200RUxDQWhaNkhKa0hEbVdn?=
 =?utf-8?B?V3g1cWtzdk9sZ01kRkNvRXdodkxQWnQza0tjRmFxOTdDVk9rRmpuWitac0lU?=
 =?utf-8?B?amo1Wld1WWhZYTNmeUlHenVtSGFvUU9sc0d1WDJrTUdianhZYytxQlRKenli?=
 =?utf-8?B?QjNZazQ3RHNIb0FqdDJOWGNFa0lzNGw0SlBFejdUQlMyTldzclZ5Q1FwVTVs?=
 =?utf-8?B?OXVmOVRORFY0YjVsSFF0SGo3WHpDSGFTUnhhaEVnOEgxOVNwVkIwUWVuRWJK?=
 =?utf-8?B?dzJxQXVnV2Y4WHlYb0NBM0tnZ3RrVDBPWVFid2FIbWk0anB2b2hLVUxmZStZ?=
 =?utf-8?B?LzM0VmxBLzlWa1UxT1JBcnd3ME9yNUpEaUM0Z0Urd0JUQitOcjlSeXZoVjdN?=
 =?utf-8?B?cjNUR1FwN2NmYVd0U21QNVhWQkkyVUt3MG1iMEZvRkdudzM2bEl3RzhEMWt4?=
 =?utf-8?B?dHhDbkVISU0rMHRCNnRuYytCQ25JZE1vaENKRFVQdDhzNTkzc0pJaU5QZktP?=
 =?utf-8?B?YmJtRFBxSFU3RjBDVTl3aFZlUzA3Q2RuS1ZyZ2FKSWxWOGtIeU9PTUQrSmdm?=
 =?utf-8?B?cmg3dlU2MUhQRGMwdmVLOCtqVHhkRlFIT0ZWZWxneU1aVG1DekNlRjcrdTZG?=
 =?utf-8?B?Z0hKMGFhSUQ4enZlU3dySURHT0oxdW9UVlFRSmhpOW9yakMrOFJUUDRnZEZl?=
 =?utf-8?B?d0hkRFVMdE1YNkN1cjZsNW41MmNXLy9RVVozOUVETVhTdmk3UzNUUE5hUlZ3?=
 =?utf-8?B?T0hYazhuY2l6SFc5M2t0d2VLbllob2NNMTJFY2pjcFlDbU1IRWRBM0FyNXhh?=
 =?utf-8?B?aW1SSmR4SlZvU2lsUU9jcFZEbHZiaEU3dWlyQ1l4SkMyY21pOGhRSE9iWk1D?=
 =?utf-8?B?dHkybmNMZDh4YVB0VElLeEFLOGFnZUFDNml2L3BSc1haN0MxVms1SVd5U1gy?=
 =?utf-8?B?eFJKSWh1ZXFBdmUvSnpCOU1zQ054TUk2d0VaOWFYMnVZa0VjWjlEYThUblI0?=
 =?utf-8?B?UXRranFWaHAwcUNxRFhtNGEySDZzczN4V3I5WjRQTkRpOE1qMXhWd045UnRx?=
 =?utf-8?B?aDRtRS8rQlBrV09DaHpnOVZhSVJpZUgvRzU4TDNaM21hNTViSmViMEVhb3RQ?=
 =?utf-8?B?VStZVnJXSnlGcnBlMitIUnoyS2RYQTFxUFZsNUFMTDBVcWFNYTRiYS96dEtT?=
 =?utf-8?B?cUNnMnhhU1gvWFZSQVZEcUt6ZXFZbC9RNmdtWnZmeEJGZlo1dGVXZz09?=
X-Exchange-RoutingPolicyChecked:
	dP8WhpjwIPqx+Cigo+9f01/dWmZrPNw9tkV0LmjWyoEb2g0MK3r8N4Mta/D9ThbJ1ht/ipNTTURAfocwvSYH+XS9JcEnP6SSe/017bSC09wkevUfDFhGN33EhMoePlqs0SbSdv8WOnyL/pPTRnOvn8uOG2VsDMyhlvaE2mu+Dw/elVbdSfRN67+Jc7F0Ax4JJ9PkchgAhzlDT9IsP7MkUg6CVlV1s9J35LXuo8ENH7e4Lr54LsGpYrzupuKx/uMhtFEMqUyK+EC0W9BY4Xx03zhwujTLPZHpTzcQeQYcOTXg5iasCA4qnvg2gZktzvmjlAX36wWHCJFlmfagxZijTg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425ada56-35db-412e-3dc3-08df2b66dfab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:21:35.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0u7ORoHxBmzF/08ppo7ltYqV71VVh2/7V/5LWXBuNwmEHhcpAD7pljlvraK+o2g40jakA3uQnPXj5TqfAbZjVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8138
X-Authority-Analysis: v=2.4 cv=ILKXmQvG c=1 sm=1 tr=0 ts=6ad1eca2 cx=c_pps
 a=WaebrhBVOVZn7IYqRlctMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=nbRYUArY0-DEW3ImSuQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lEIKsLY7z4VSropdf4xejZrVsnnYPMXq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX/ScQ2duRZWmq
 DLqPFzntLiAPwlFzp34Ab3eJZau28/V+9wEPTsgLE9vyzHEcqFCAv/i9doBd0DGHzquj56pVaHF
 853mNguRRn3ShUuI3km4OYct/SrqSHAvXc69r4KznaItCeOg6K7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfXyMu9Wmp6CaC7
 Ur8TRk1xoxT3MNoNHjP9D+2Joq3kvmdnvxjd811d5paEV5ID5qmD2orjyCktc8JaruEkU6sYuNb
 prSkBNTtyL8kPJGwDIgHshb8r6w+3/v0x56x+ZBxISa9Xc1iaKDLy2gLk28Ehia865KpwsPFVsT
 sxoa+44cGT8DL6v8DBapf9YmZ4ASObml58HQF1MhYQh5W6M88LqfioMaimdzE7Ox37P1iE2SQga
 E5CqSaSz3CQhHO9hy1RVhBWwJVHRMySEilji0jA0UhiT0UbnLWijBHaq9QekZgIpoRRKv4NC6mJ
 Hs6uD+C1RidfC95nSe0spaUQXcnsjXpSb1uIGOX3V7n3lcpLYiu7pn++Ng1IzZKe+DcZ27JFa+E
 vbCg7ldqL/fMjDWP/MC0eqIZbTi7x8oo3ilIdMH1Qa71A+Hm1x2lskpCu87x9QIxLo87UCF3uvi
 TXnWvvRO9+MzvJXe61Q==
X-Proofpoint-GUID: lEIKsLY7z4VSropdf4xejZrVsnnYPMXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160037

On Thu, 15 Oct 2026 13:49:47 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> [...]
> The PWM is disabled when the resulting period is zero. The applied state
> is read back, so that integration_time reports the intervals achieved
> by the PWM provider. Writing to integration_time fails with -EOPNOTSUPP
> when no DRCTL PWM is available.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

The bot is again making some compelling arguments. Tend to agree with
all tree (not sure how the pwm get_state one is relevant in practice but
it does make sense).

-- 
Nuno Sá <nuno.sa@analog.com>
