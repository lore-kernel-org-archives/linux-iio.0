Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793369166;
	b=zERPL1XRTw0Lm3LCZGyFD5AisX38PKnFuTlJyf59wyUKDGXB8V513PU1v+GwFwPRBov9
	 6xo2/bStjnyXSy2hw5FsIHmded3cOFibZ9730gJrkFp00ul5Ro0JpOV7TZInh9VsViVuq
	 C+AxDIA4LKqa4J6IfQX8/9ju4fnFdn3csxbquGWgWhAuiDG720SP+4cdLQEfVDi0MHpFu
	 3UzBT8tOycltqdmvTNhVr7XbkciRGQXAViOddJ5R1jltgRbIxIFIhMZjRs7pOuXTA/b/6
	 WmRty7DeBfhmUZchcrS0LJpPx5usos8BTjgXmGHdf9QkZnLksr0JnXCbJnijirHqzWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369166;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=r+oCEi3vtydIH4mWTgJVf+yCkD3kXqrrf8IaokQttjQ=;
	b=vwkqFhHpSEJlnce9Up7CTUeM0Doj+YkkDy84WgtGCcBrCeS6N1PEbpRAI3RIKSKv+rqI
	 orUoyCHv+JLRWqYXvtUAVS9bSQkXnaIi4FAptFZ6Jc29MO1RSXkCP+tmZiyawBn6bpLaa
	 Yn09VKN+W3RMLorAL0Rhai/rdVVS0PhT8ChKFaWRq3MTvoHrPhBkcyKBAsiSbky4470LD
	 AN3nU5Udml3CYJSYgYiFGsXczh0yJuPs+pXSw0KtZGt/v4CipyxeYM5Z6E3NlLjUjg2Tk
	 YyCOXgGJrF4ARjfB2mjWobmf6LgJRJMYw4/QYV7OCSMQIcMnZ58QmnwB/A4BmdbuVpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MKdmEBYl;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ztR1aCiY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94B606A31A;
	Fri, 30 Oct 2026 14:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D94B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MKdmEBYl;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ztR1aCiY
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UE1uST3093241;
	Fri, 30 Oct 2026 10:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=r+oCEi3vtydIH4mWTgJVf+yCkD3kXqrrf8IaokQttjQ=; b=MKdmEBY
	l/3+gLc0KlU7z9MfS8ivzRV2hfAKbGLGxtENgjiuGZ+4lzbL4Z/USzC+VtynS1tG
	jSWeDRhHH94z4Yhf7HCSFzMCT8MsVSQ1Ul0/WGf8FzUQewfk8eUgLgN2Y/w1i/sk
	tU0nQ0zW392CD38ob1ix9pzSFzaged7eNfVYWdzAqt1ZKUMczgU4pgaMVTmozJhj
	cmqnvD66dR0fYAFHZC+nb1OtoqMH2CxVBWcR2PQ5KduEgEzY0C2zjCwt9O7utLHy
	RiL57ce37GPLF45cBMP43UcpMGu1hzMrtyWDpm29oVjMie/gmI1hPrgKS0K6NLTL
	ayc4KgKoTPRJgrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r+oCE
	i3vtydIH4mWTgJVf+yCkD3kXqrrf8IaokQttjQ=; b=ztR1aCiYt8VPjz8FHlq+b
	ihDODsF9PaTIEnJZksehDq8DxbmJUEqtu+Ou740d5Jp7VD/nfaMuHFDaLVCrjmmr
	qap/Ay2YJ9eT0oiDF6nvImgoKPHDYYJrqpX6H5+6KV2pzPEV5Mg4sWVtN1v3BCOo
	vpOU99dlka7iyBI1ToJ/bVGxQ5q58nPQzn39hiqxaszLFjEwMZUs+uoSg2x+YtgX
	BStwcFuPlLlfCixm3ovj6nOMxNzVUtjB0wYDxO/G0R/YTeKFxEjsAmB7TY2x3vFw
	zB5F99RnJeXBttUshYffG/Qk+42jALY6W6GKNdAj+J26Xgj9d84JQaD5c1BF0mcc
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bvab6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:05:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRMREqUaKxIvN8dtHmO2YMoznT7j0MJxY7AqWlZ6nVPIs9HqNOI/2zalMBT0IHdLfObLc3+YFCbMe3SFTTk4WskkKBBCg8ydgxjsOtYKZVfuXhULBlxeNrdH9Gf80m/jzJiVc9bO55PtemCq158NP4o6mj9e02MwBxA9eLaCILmUGNd+4fGNUNSmT/WZzE6BSvt9ipwwDyuNU5FWoUfVcBellTUENDHlMcDGhtLt3xpYTmqql4IxSaexvBpxSZ1R21HETAfl+k8d13LDqGPQ4Vb45k3b69OIJOmWAlYiBb8tTLDhest07nDSUw+bsPCJIT1jP3bqNU0FNw8GAe0nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+oCEi3vtydIH4mWTgJVf+yCkD3kXqrrf8IaokQttjQ=;
 b=QrEcIEnSj/IgZI8nbnTcIUtg9tQjCsx4pHTQoaCf2Q8hg+iSW+Zh52bZ/jenV805AtfQpnbnoLQ5EAdrkEABRrqbpgNjNjYFwMJOnWXlL8qM2WexTdM4bpx25j9U19xTo333EyySX++NgGxOdA9piFEUJ1d3C/QV8XvdMONqG7w/D/OHYIjHCD8phLwE5sSfjDKnu8RFRVKJ3hCnys3uheNjIfnKjFqXNnjCgYGuEMQPWPkv4ZfoRTEdbz+/lA5amUemN8oRvhZea0QZp7WAPNs/uEKHSrdEgC05S63dqgim1xdqpqRPYeS72AdaVrujKGPLEXJWc7apA+By05OJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS0PR03MB8319.namprd03.prod.outlook.com (2603:10b6:8:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:05:41 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:05:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/8] iio: imu: adis: Add optional self_test callback
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@analog.com
In-Reply-To: <20261023-adis16607-v4-1-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-1-a4d541ebfd13@analog.com>
Date: Fri, 30 Oct 2026 14:06:58 +0000
Message-Id: <179336921869.155032.1362846813612296234.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793369220; l=532;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FFfSTBEQnzdDNDDQ0V5mlnZemWpDbdPSYEp+5oE1VUo=;
 b=7RQZ9+eSbGYc1gaR3q0SeeeeSYo4P5Aat7ibD/T43o9QlrSL4Bh7tb3DhGZbD3pd44gjhmQq7
 Bl+DHWcjYLlAqCuRRLBrrCtY8hsWr0Zag4yShmHR8iBzTeox65G6jAL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0022.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::11)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS0PR03MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc80ebc-f8ea-46a2-d115-08df368edf2c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|261022075727099003|261009223027099003|261026121527099003|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 6AayWYBLZ9wmx/YA78yAFbghhSlNnMYbdr6w2CyHRihdZAHLFhhCOXSUwa/AhZSorq+QAmvF4BHqre9CnRKjumn/joGqClZohgUaAav+PKSsgJ/5BmMtdRX/QoDmP70naCsVVVE5hPwFLJOpkqvjHVuIyBTVXHQfA8OT52KIJtudgwFYhJuJWZdKxghXH1mYOd7Muk55/ujGi5lEL66RFOHQhw8roLUYg0YnxE+blLTdvN6bVGECc4+a77T5dUIBhpDFq0boJ2HWvXuHUMIvmVihv0Krh6fGXN/RSDP+r9nz6XIDb+TOgwLkoOUozRpiEQ5XW1rqerwSFSNNl47sfGjblpwpmKh1snhypYUOS567dc2H5waBy/Pcn4Wf6w9on0Is47ZxsJtRhpLTb6iWDz3ELBGAqKmUYSHV7MgmwpIioAbexXYNjeJHs5ufwn+JfoP+YPMJBVFjug18OD+rqOqoSiSYXWcrTVIzGZIBV4GEjej2YxXEBcETqOXEsujigIgtBYpdkNZ0ViNVvDM4vWg2E2lmE+MM3vgxSuWjvly1/x1Uq8GgZn0WT/T2fEW1I43x51bRk6w8WOROWdsQD4DIKQ7vP97i2ZlFmM2M5D8nC+KURFzfCm0x+KuWcc3+UX7290t7xAHvmG6s2THkIBAK+duVFitPAo0poWMT8dE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(261022075727099003)(261009223027099003)(261026121527099003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S0dUYUhEbTlad2VhMVRma3B3RnpGUXh3QmxTbmlGVEthN1JYS0lQdUhxcnUw?=
 =?utf-8?B?SWFSN29YOWNmV3hOQkcyVDdsamcwdkRneExFcGR2NU9xandSRCs4S0ROdVVP?=
 =?utf-8?B?L2hLM2FHeGxSUjczeFh0dW82Tjk5b0VLL2RwbjdQQ1ZVbXorbzZZQmE5MElx?=
 =?utf-8?B?WDM5QWN6Wjd5eWlmYysvRjZ5OWpLVHRncUdIa0RrSGtnM3ptWmNBcVdiU29E?=
 =?utf-8?B?VXpYbzlVMXdwdTBnME1YeDFmTU40aWFtaS80cG9qOGcyb1lBN1EzandKTFhD?=
 =?utf-8?B?cy90bFNvOEQyMnRoZXNMN1JadXdpZkRhUlpPaEt2d29WTzZucFJUdUppVlBa?=
 =?utf-8?B?SnB2WVAreE45eGhLZngrbllxYUhYbFlENkVRWXZTdWlSdVdDajJ3WDU1OEFZ?=
 =?utf-8?B?Slp1SXRTUVVTT2xHczlLODYxd2pjOVJEL2haTzdXMFBuSDk3eFAyek85YzVa?=
 =?utf-8?B?Smd5K2NqbStZQXJST0NEVEhwSDE2NmdWWk9UOUEzOU96S3hxRWU0Q2ZGZUtl?=
 =?utf-8?B?aHlUd3dCanZsaHVMUGdXN1I4VDNWeUxFT1JySzFuenlQZENMWlk5dGhVMC83?=
 =?utf-8?B?bGZjenVUZnVmSDZheWV3d2JUM054RzU3ZXFqZE9wWFhURHVVamNRckZuYlBn?=
 =?utf-8?B?bG03YlczVTB5bG9HcDUzbTMvYVBFQkZiTTMyajd1YUZrR0VxUDdZSjhOZDBC?=
 =?utf-8?B?Z1lnUW04MXVscFdvNmh2alNTWmZpRXU2S05xOEczWUptU2c1OGZlZTNyM2JS?=
 =?utf-8?B?SGdCMk5iQnkyenUxcTFhaGpvV3A5clR6OVVndTR6NFRsRXZ0Qi9UQjdaU2Yz?=
 =?utf-8?B?ek0wWlVkVmlRSVR0Zzc5b25oRjNvaTRPVUZUUktqRmVzcERqWHZJMW9aZE5Q?=
 =?utf-8?B?cDZKOTZhL204TzFqVDQxc05sL3BvODRZWmZHb2FKaFhGOExGVXl0ckt6Nms1?=
 =?utf-8?B?aElBSzJ5L0tVa3poekg1VjFDUXFtaklJRVUxRnlnbGdoV0IwZnA2eEtJN0ZU?=
 =?utf-8?B?OTJtWFlYYlh4a2MxOGtqaGM5K3dBZEdtb2UxamJiS1BHQmhuQVNRR1JLYmRp?=
 =?utf-8?B?NnNIa0F1VzVhSzEwekJna0tZb2RKQkVoVVRGRmhqVjdFYkhqNHJRQlJTVGJq?=
 =?utf-8?B?VU9nUnp3RGZ1SDVLUDI0OHZsTTNsQ3kyaUF0aHFHKzI2KzFSaHR4Q1ozMmEv?=
 =?utf-8?B?ejN6aVVud1NQNTBEUkdHOStMVWgxZUt3VWJMQkRRUWw2MEx3dC9uREhsL1lm?=
 =?utf-8?B?TVlFU3ErVmVaSmJOOEdSQVVPVHNWaUpxeXhiMmlDbGtZWjVtYkRUZUVhajEv?=
 =?utf-8?B?ODNBbEp5VTZKd2QxbkQ3WW5TbmJTanBwUUhmd0dwN3NoVzZXeG5lUUhicXdS?=
 =?utf-8?B?WmRtNDZhWGV5WWR0c20rdmFhQWlGdUJLUFd5VlBpTEhNZUNyK3FMd2N2YTlI?=
 =?utf-8?B?VHEwVkVOT3FqTnVhajRHZ3I3bStJMllwS1pYNHR3d0JiZTVSMUZTemdOM0I3?=
 =?utf-8?B?ODNudlhkUFVHWXcxck1na0VLd3ZpbVh5N3pobUtmTWpMNVM5Yk1LQ0sva0x1?=
 =?utf-8?B?UzV0bWJ6UExuNVdRc1pHNlhQOFl0aWNQaGNHZ3BTR2tyVlNJSHZEdzF3V2RU?=
 =?utf-8?B?b3FKNTZnbHlsNzN4ei90cDBtbGVwQ2J0RGtrUGxOaDBLWDg2V3A5UXhJUXRk?=
 =?utf-8?B?U1VWakIrZTI4RFRIVUxaVllNNDNJcXB3LzRTNXhWWURsTFpOUUxacjV5OUxT?=
 =?utf-8?B?N01Mbi82RndGUjdaK0doNXNhRTZGMWdvNnMxYmdZV3ZiU3BSb2JyNTdHL0Yy?=
 =?utf-8?B?cFZSeFlkZTFZdmZuc3BOd254cE5WcDlobExWck5QT2ZOT1VOaklNanpTQytj?=
 =?utf-8?B?VEI5V3JORWtYd1VKMmpKTkZkRmt4VWV4T3Q4ZkFIM2tyNXJURkJ1VmZRcHpv?=
 =?utf-8?B?bWlBUFlJUk1zb2hCSGQ2NmtONWl1NERyM1RuUEpQdlFxNEtmeDVwS1FsSVMv?=
 =?utf-8?B?RDZNMnJqVDN1VFVNdXhBZkNmWWRnUjN1ZEhFOGsxNVVWVmF6RGdoZzJLOGxG?=
 =?utf-8?B?Y3o4bjJ6WWtYdGJiQUhmV3VGdmVzLzJPYVVKcGR3SUNyejcrL1hLVXFCWVpv?=
 =?utf-8?B?WFNHTDU0cFJncVJGQVFrbXNSRm40a2tYQU8yNlcwaTNrQzR0cVpsR21Nd3JD?=
 =?utf-8?B?VVYweEFISUtISm9IVVVPem5ianp3WHhDcEJxVnlzUzcreEgyTXY5clVxMEpW?=
 =?utf-8?B?Q0duZzZIVWMxcGVEYUdOQ0liQkt6aElBTHloZlRzYUxtQ0pLLzd5NjZpWjBC?=
 =?utf-8?B?N25YMUZ5bjJ5Sm9wRTJnSmFnUEpUaDQ2ME5ZaDBmRmNIMVVzMklWQT09?=
X-Exchange-RoutingPolicyChecked:
	Ut5V2+PvDqWe+yzRabRWedOdgJZJryZ4bE78kJRf77bUKG6D+vqBgs8ePNpCNFRkyMI2/wI0D6SJCzaHho84Q2u3wzdUPUxShRj8s3QmNXbM9NxRWFWJGWnY++CJFzqp4Bc9cytH4wzmxN0vG/+LQD5ozfkMkFyBg6CcB1+6w53sPR1A1W3+lmwO9ZtnqWdduXx0nDpySnL5r1bT5BwEqLfJhh16F0l7WxkAh9xcyFW5PsSDzbo5YG8uOjnMGCLQBQEUzLT2GiLIST1eXvDiGVYiUAaaoNROZj/Ejs6e1I5Fhgrqv+43jfbMfsyZYMav5tGM4l87P53fRmBP8xL32w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc80ebc-f8ea-46a2-d115-08df368edf2c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:05:37.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0fv934PWKO2vQXGN3q0R1OQ8SyUOUkPK9jCYxLz6IcpdexSSycwfrzgpa3tEl7NDbkL3sGfZFXLCrix1jaAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8319
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfXz4Lu4oz0EtSG
 LOazfVaGevrQJ1/PfWzkp7TzuFCaBZLjNkBc0rBK6yxH0mAwo8avB7rO79wddvoO1bcfJs3rfKe
 9rH+gskS1CJtUhiOFj7bxDvyDJB18LTL+aiRkOJXLINupjrkxtCo5qxlxEaVzjrOPq0GwshWz+P
 RnwM42Y/gCxpsGO5vNyTEISozPW6LBB4qae5Fsb5ZoVW3GKOi8sFlu5qkN7ORV4RYvnW9qOs8JL
 riD7VsuvAFA/bSFsfyTwxoNdjLCbeVCIA7GKBPN0gAORM24uB12sYw/labIrM6ch+l+rbO2c066
 wgx/y4AefnGaCDRXBXeYh0ZnU4zzPyq2f0yQwCS3nG2h2bub0Hk1o3hFEWejI1gKycSQ/r5zvjV
 lL5as6OQp7DLL2qGpEIi6VqpMSkWPdv+BpXF4/wNIeDdI5seukYhNAQR/isBcux6jWqPIYwIzR+
 PZMpSKLbde/lsdw4sFA==
X-Proofpoint-ORIG-GUID: TR1zTxYERz19GKmDabOsKtwNGjUBPR-5
X-Authority-Analysis: v=2.4 cv=ZP5CCn7b c=1 sm=1 tr=0 ts=6ae4a43a cx=c_pps
 a=3wiUqt7F461DME2/dPg5UA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=hEChm0odkyj1NFB2_3sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX5DhRPpDNQeNv
 qtuXjWrffa8lQv1orD3/14PB3fAXqd1v3g9d/wOPV1UVq/oDwSw8kS+rsSkSnqnR7d/9lIe/GXF
 WOUWKGcrQ2xzwTWTCfjNxOFRZtgbb0lJXsV7icUMPBu2/8GWneBY
X-Proofpoint-GUID: TR1zTxYERz19GKmDabOsKtwNGjUBPR-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300055

On Fri, 23 Oct 2026 12:30:18 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> Add an optional self_test callback to struct adis_data, for devices
> whose self-test doesn't fit the generic mask-write/sleep/check-status
> sequence. Purely additive: defaults to NULL, no change for existing
> drivers.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

I would say that the fix patch should come first than this one. Other
than that:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
