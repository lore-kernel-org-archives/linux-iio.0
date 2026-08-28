Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F700279DB1
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914002; cv=fail; b=Xk8pZpEeuHJ3kYG/F8SC5xT41e+up52GBzgsIHIUYoscg69o68Y3Zrmv9gv1jTr/rKOaqIBt1EvKFVbodLbh7z8OlnAD9vM8Bj8atvT1OTBWwL8H9in64ua0hl9KJq2HsNr42fZlYoKWizvW31lY3WSCLUjY/PoZiTApXBabqi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914002; c=relaxed/simple;
	bh=U5TuEJjsWMVDMy6zBU+owOykUmpIJlsb/8/njaro3vU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f/EaTnRNH16PJ6oJlVrUxiAPF5FfivyKO1jJhTArjMusyB6W10a8fsjMOakcBG3xkWCSbey81bfYuluT87zgKaxxaUL2ozspf0w6X4yWJJ9408gIiKiaGuPo+g/7x1caRkaMusTAhgzw7Xex2H2T8w9K20pytWoRNUkI67fttUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1LAPYPDv; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1LAPYPDv"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA9wmo1569007;
	Fri, 28 Aug 2026 06:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t5sJ2
	ym0hdyzAwInpsNQcb5x3Jz71pTrr/pCDMywHQI=; b=1LAPYPDv2e6nalP0/VXkL
	w7Xy45qAwrHR/8uOSbVjRuUniJeD9bIziN4l+xJVNxQRqC4UueoGVEPd1vzx5olj
	hRQZ5LueGiLRi3h20rhib6zJG1B7uajadzsUVWVFWiIRqa0rpr5DyHm4Fjgz3r0E
	mTzJatdMzpg0+V2ywaNgBpU3kipT4Uj9ZM2obmNzFV/elxhHr6oIfMPUO3NATMXj
	A5Teg0/0iw61bK6Lmcx56BnjuOZoRwx3zqHPuYuhUYkxqmtt3zbsNyA8J3LKD84i
	QdGRTI/+y+tXUX1ySQU67Bz6t3LQQpKRuRLMdb1Z9y9OwpSXQ0P1gDnQdxQDkD+a
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ga1m12tcm-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 06:46:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrKnVncPOyhIec8G2Kx+ObYn/lJClZtN+2nCqx/BmN355yVdy1uwgZcEKCxVaSIQEvv+8uxX7a0zZ8d8McJ7v1ccKiFQdd5ISBNWphujnnTwjBnfpLAfG85sddscpHQFzDWG182agIGiCotFjcfkUdWeOVa9W5rCMqfPkKE8frqHLPtnc10mWc1VJMfaLR6YQHC31Jk1l/INSpEGE/hg2wCOwLzLJDaKQfGHSV6QNcbaqA3oatYn1cYAzvbA+OhVv5YEXT9IN/SF88nmXNT6E7UDR5b69B5IsBO3naStAj9GxLaxO0P8pm1Ohi+jG0u6vHlB7x0i6TcL8fMRdScTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5sJ2ym0hdyzAwInpsNQcb5x3Jz71pTrr/pCDMywHQI=;
 b=BKCNPaTebHLzV5S2bA3nyWrXuxtCVGwumE+9+r6yR/43GYU3z1jOFdqJBxEf+7cBnTGNrkTne/zrsG/eMBJIfTDwAFJacChuXWkhn31zlwjs4eFUhtFhWomBrKEGkZ/Do+wLCmzaXCLlAY2YPYAFM1tsqzewUdP4JQBP7qUoKnDNjaO8+nUzkNWTl7D4iUsXCivImNeoJ13kuQCJXTm11Q9Z7hg+EwbHk1LrUC/rVTMuFxhhCZCjkDzQuhTRhWJKsJmGokmu53Bf/U6x4cMiQtV5hxxc3CbnNLgOljKOtahwiCzDPafeU9p2uaQKkVghYngEE9NZzbQ5YfnX5aon1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by PH7PR03MB7267.namprd03.prod.outlook.com (2603:10b6:510:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 10:46:32 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%4]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 10:46:32 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 28 Aug 2026 11:46:55 +0100
Subject: [PATCH v2 1/2] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-iio-buffer-dmabuf-iommu-fic-v2-1-b4dd71827621@analog.com>
References: <20260828-iio-buffer-dmabuf-iommu-fic-v2-0-b4dd71827621@analog.com>
In-Reply-To: <20260828-iio-buffer-dmabuf-iommu-fic-v2-0-b4dd71827621@analog.com>
To: linux-iio@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787914052; l=3742;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vC5ROMTpuskYc/OUYCs8vvXSO1frW6B1UA2CPnkTlKQ=;
 b=/XI64ySYzuts1LXwFoFJoQvx22m5iYOgPPiwANPfUzrIVo8A4B6NWEwS4cnmaEQ3WdVfAdHR2
 L663Jfrha6YC5q4aO1L2fpUQDtmRsbSN1qA4cgbayb4qvMyAbKkrZuj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0030.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::13) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|PH7PR03MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5a1c6e-4dbf-4033-3cb0-08df04f19f08
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 otMCqtkktE/4zSv5lmVo3NJPDO0bfuJGZuM5vyBO668TdM1x2IIP+FxyuotGdFv3V2Qgm/Uous0b3dWiapKLtebLu9o8PNP7pFlJV4gDyHES1nnVle7MojXkomELsrh7u3Y15NHKXn9LC/JlEFpfKDooceQd65+fH6zsvS0b4OTrBzE3acHLCvaSnJUctXAgFSGyIzwiunUrZYBSnxBZ7GelUHYLhlYTFfr4qzGGr2Mm328QCylgWK0GGbHI22zWxUdzvvDFjIPho7W7Qm9Aty3Whlxn/O7VR0Dv5XOxa7Af1fG11PYHxy28IWv2Qc+GKSFUJi8LCtjgobf01tzJ8OtmvlOJNH4A+k+mappOvqUo2fY8o4roCWhSwBr3abF+sPjSvjsXdNnxJgKvbd/ErMQCw0flJSL/CJ0fndrYOzENWAYguNdJWB1DXkgZi7D6x9R9grqUZv/5FjxWS1tjBh6aFtxPQjzm8WwSf2oe5hFg6tBc6kWBGEQD5dccr9rihdn99/dbFyktkfyxvjK31cj9Fz860TziUgal6OPvTblK9gf5+FcDm/15P/M82NOoV67et+HwIq8YtiGdLLKKXDArx8MQFInb42BlNiaFNCCvhuvY2+Cd9J4TPIfHEnSSdNpgAs89hwh9FwnX7pE8NF3nka55cSpNwp9Aivvt2wQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZDFvdmVSZGZKd3VWTXZ5cXd2UXN6OCtOa1ZqVlZWUUlDTXFTbGJzZXYyMXEr?=
 =?utf-8?B?dm90QVhNYWYwbnhia1JMVS9KcU5LWVJCMkhUTVl4QWZNOFpJTzU1R2Vrb1pO?=
 =?utf-8?B?NDl3d2wwVVBhNjdQL3JiOE16RTI5OXk4ZW9MSFQwaHZPQnRMMVlEcUdFUTYz?=
 =?utf-8?B?RzZpdFpjZlZENTdrTWFraHFEOHYvYXQ4TldWRm5Sd2I5UndFUkQwMDdlZHpj?=
 =?utf-8?B?OUtIS2MrUVZSVXZtcEFibGhlazhBRjFJZC93ZGU1cXRRQnV4U2FoV29HeDBs?=
 =?utf-8?B?ZkhEVjB6WHhUZXRWYjZJNTN4WXNJYkJiSDkvdXhPdEpSQW16My91UFc1Um9I?=
 =?utf-8?B?ODkyQ2hOcDhiRDVtN0l5UmxDL0xBVno1TmxweExmbllCRlhXejBjK2hmcjZM?=
 =?utf-8?B?WDlWRzRCOSs1SzNScGh1NTNDTU93SUNlOURRa0t2eVkzWUlraS96QU5sMGhq?=
 =?utf-8?B?STdySmE0d1UxU1BVbkxmQmNqUk90UzI2UWg3SStNSmdhWCsxZTBaVWZUMm5w?=
 =?utf-8?B?UjRoREM0Rmg4aFp1ZSt2U1B5QklNVmhYR3lCR1J4TVhJNGQ3K0RjTzhWeFRH?=
 =?utf-8?B?WjBRQWdpYWVYRkh1L2g0RWc0ODhldGdTTWtXcnl6ZDVTQUtrVjhLUGJHUGJG?=
 =?utf-8?B?NEJOdHhrUzY4T2xxa21TSUpaaC9ORFF4L3E5T1VjcHlwUWUrODRYcytJbkpx?=
 =?utf-8?B?VmRzUDVoWkV2ejRmREhhOGJuS1Y1ZUZqdEw1OFFrUmpENEdiSmxwU2U2cG0x?=
 =?utf-8?B?YzdibDIvWVJncFZlKzVacllrUXRBcWZ5bXFjY3RBSS9KWlZueGVhYXpISXJs?=
 =?utf-8?B?UWpwN0lpUlRkK29DaXZud0RDZzZKTW9hVkU3M2c1ci9DdThKNGI1dWg0QjRF?=
 =?utf-8?B?bkxRcnB1UVUzSGRsT3gwS3E0MWp3UTZud2Q3UWRFNlBwbFM2UFQwbkFoblRU?=
 =?utf-8?B?TStqNkZTaHdHMmxYd1lOdGF3bnJnZG9nUTF5T0NEM0djSlVrZmViMlVMNDZS?=
 =?utf-8?B?MTBrMzk0c3pRT0dmeU5NcFdqRFlZcmM3b3NuMDhtZGFrbUtpenlLMUhEQVFG?=
 =?utf-8?B?RHJqM1U3TDFxM2EvSTBob05zc0Mwei8vOFZqT21PZVZuNEpuNFBnWms5UlRH?=
 =?utf-8?B?ZmhVTlBzRDd1Y3ZmWUVhMTZPS2Q3bEhuemlHbDNKN2praGpRMUI1S1huUXBN?=
 =?utf-8?B?aGdvTW5aeklyZFlFeU5yMFBUcVhrcExQT3d4UVFXRWdFek9xdjhSTW43WGsz?=
 =?utf-8?B?T2tTcUx1UmRnOFdBMXN1NFJjd1FJYjN3QVg2VStZY05RdnNmOElHSGVFZEhC?=
 =?utf-8?B?TDJZVWZSSStKbnpkRlB2M01QOGJRNXBiMVUrWm9MVndHOW9NU09QREFYTG9E?=
 =?utf-8?B?RDdZSDNmTzkvUmVhZVBBRzM2bWc0MTVzMHMrd0tXNFB3dTY0Q3kyWnhHUXE5?=
 =?utf-8?B?NStRZlNsRTZVU0pQMGxEQzFpVldoYWFEQURoZFg2clo0WjhmcTZ2d1hySlVR?=
 =?utf-8?B?TnlGT1FlSmZHTjNhSXlURUNpK0JLYWdOVGNFcENpM1FWRXVsRENtdGZIZFFx?=
 =?utf-8?B?cEg0NXc2MEdPOGpSOUFBSVZ1OVUxMFdnNmxxOUdjNE9tU09BOUhackVPV2pu?=
 =?utf-8?B?dnREVkZ5YzRUVFVaYzFOUVQ5QUZXNXdNMm9HWFh3dXpmbjRIamgyMlE2NURF?=
 =?utf-8?B?RGdLb0VFaVFtMmlmRWVvWEo2VXFFNWZ1OGdpUUQ4RzdGNm43cENGY1hRWUdK?=
 =?utf-8?B?ekVjUkxBYm9UZTBpY2M3TldKVTZrYjRLOWNlUEhYdzVRM0VmUkxmWVNiYlhs?=
 =?utf-8?B?bmoxemtDenRrM1hXeGxjZ1pHZkhpWXRlR0cvQklaOWE1aHZIVTJxdnozZWVu?=
 =?utf-8?B?WGF1L2tkQXIxQTkrMVBaZndPQmkrSExSQzI5a1RHV1VvU25XQ004THhuZzRG?=
 =?utf-8?B?ajFDalFKT0h0VlRJU2lkQThSb3l5WmpQWDU4Yld5a2tBSzJLeGs3UVoxcXlY?=
 =?utf-8?B?MFl6ZU0yRE02N21SbEZkcnl5bzZPejZ2bnNTL1RvQ0I1T2FDdVBENnZqQ2ha?=
 =?utf-8?B?R25XRWlvdkMrRVJPREZ6QlN0UVhQT3hIY0crcG4zQ3BMa05TM1lTb3R6ZGF3?=
 =?utf-8?B?NlZWYlVDQWgyYmZ2VFVVR2JLOUdNVXEyZUpLeEVzWXBjYmltRVJ5dS9IYXpu?=
 =?utf-8?B?dDdLTkVyT1crTm1mNlBOQ1F6QUVhemRiWW8wZGpFZ3FhK1NJbGFVZHYyZG9l?=
 =?utf-8?B?WHh2cXIzT3QwR0I5bVI4UzdLcStWbm1nK0VNRytxeUtnbkxLRk1Tb2VBZDBi?=
 =?utf-8?B?dWYzSnNic0hFbUVqeWVvY2pPR3czOWZuYzNmaTRDanhjMFIyb2RnZz09?=
X-Exchange-RoutingPolicyChecked:
	Ki28w13qOWqvZOwDHwLRf8NMPeshLvXve09wP3hFGUNWJn9k8sUhXbKJj0XyjwX0Fu+coB51d767nWDa+4JD1nkp607SU38+XT76TnVx6hbhlwPKV0Y5+1c3JvFUBIrBO/JFwbjo1ueHvLTRemJ4lbSDkxH/c6eXrDxwteziMHFkEka+qiGYoeZ84352U4Bci/XWHhr+gjzNDUpIHBw1r4qAJz8sSsF0m+zV6k7HZlKnG2+ycb5m+oaHt8kHTmt8W2cjJsZcP15a+ygckVz8mbkQDYPUhAhUHdsswrMQSbra++8ba+UeclloTewYFKTxN2JiewCHrUC+xohSFZWIrA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5a1c6e-4dbf-4033-3cb0-08df04f19f08
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:46:32.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GF639hjWxtV+MYjGsg6d8Uq6yVarQP8I/Vwm9rIyPRYCvWa1+mNc7/DBpX247+J04bEB18pHTtsKsxoeNcUnTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7267
X-Proofpoint-GUID: lNU-O3c5UDtsrnVpdDvW1N6-fEO6oUuk
X-Authority-Analysis: v=2.4 cv=NtLhtcdJ c=1 sm=1 tr=0 ts=6a91670c cx=c_pps
 a=e4reWzpetjGbn3OykFohnA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=Ce2Is0pj2Y6IPfHFaBoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lNU-O3c5UDtsrnVpdDvW1N6-fEO6oUuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5MiBTYWx0ZWRfXx/LBlKZeioay
 6V9qPjrs+x/7xmJ8w+HBhKJEzqldQ6Xf38eh1f7e3aFXroDAXchksJvRP4I8lnTXlngSq4pFbv3
 E3SPZ8ayWUWVvC5MZ30kJatShHQAXNsg/Bgv0SaajvXXnIMxJSrTWMfxLDznROXmR/3lZS74OjP
 yDCddc3Z7S5nWKUjSMYW7zScNPYtGVDxNQsCN9gV0CHrQAhRj1ezYu4h9BXES9whgZCFLRUZIWG
 0lU7WtzuAonvOVJN7dJo5Rnvlqrg7boAl0OC6YBGt5ydHf3QYqPf7qkfjbTwiPv9y5SgZNiLsVi
 yuOpveDdaP8aiE+94Cyn5p66/oW/+/fDeqlHbN9tkEeS2BWM09sxstC6BVFzWbpr65iU4EF0GDE
 ExP6aHVRwt0B9E3o3f05Q4M/uBDaEh+o22GA29z+uwYggFvIyNdM7ZMbF0+7+srnQ5A8sZDfeNm
 qcRFxyy7Aumie28KaEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5MiBTYWx0ZWRfXz52AeXPPn+Dc
 gmu1MYZxreZr1UGPM6n+Axs7xEmNGTWv3HP0/Du73BrLjXxTFHi50sdlKCbbgMgUOI3rCt6H20Y
 znA29fEgPi2wxSEH2kN9zBglElhC2rFLbn3JAaD5pNssJLZ8IssI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280092

From: Michael Hennerich <michael.hennerich@analog.com>

iio_dmaengine_buffer_submit_block() counts scatterlist entries with
sg_nents_for_len(), which walks the CPU-side lengths (sg->length), but
then consumes the DMA-side fields (sg_dma_address()/sg_dma_len()).
After dma_map_sgtable() the two views may differ: an IOMMU can coalesce
the mapping so that only the first sgt->nents entries carry valid DMA
addresses, with nents < orig_nents.

On x86 with an IOMMU enabled, a DMABUF block backed by two 1 MiB
system-heap chunks maps to a single 2 MiB IOVA range. The CPU-side
count is 2, so the loop reads one entry past the mapped set and emits a
garbage vec ({addr = ~0, len = 0}). The DMA engine driver rejects the
vec array (prep returns NULL), the fence is signalled with -ENOMEM,
which a userspace poller cannot observe, and the block is left in
ACTIVE state so every further enqueue of it fails with -EBUSY. The
visible symptom is a stream of zero-filled blocks followed by a wedged
buffer.

Platforms without an IOMMU never hit this because nents == orig_nents.

Size the vec array with sgt->nents, i.e. the DMA-mapped view, and stop
the fill loop once bytes_used is covered - which is allowed to be
smaller than the block size - passing the number of vecs actually
filled to dmaengine_prep_peripheral_dma_vec().

One vec per mapped entry is enough since coalescing can only ever
reduce the number of entries. A single mapped entry longer than the
device's maximum segment size would need more than one, but the DMA API
already assumes no single segment exceeds it [1], and splitting a vec
down to the hardware descriptor size is the DMA engine driver's job -
which both current .device_prep_peripheral_dma_vec() implementations
do.

[1]: commit ab2cbeb0ed30 ("iommu/dma: Handle SG length overflow better")

Assisted-by: Claude:claude-fable-5
Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---

Note the Signed-off-by is just because I'm carrying Michael's patch!
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index ecc02a427b92..376486be3f55 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -104,10 +104,13 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (block->sg_table) {
 		unsigned long flags;
 
-		sgl = block->sg_table->sgl;
-		nents = sg_nents_for_len(sgl, block->bytes_used);
-		if (nents < 0)
-			return nents;
+		/*
+		 * Only the first sgt->nents entries carry a valid
+		 * sg_dma_address()/sg_dma_len() pair as mapping the table may
+		 * have coalesced entries, in which case nents is smaller than
+		 * orig_nents.
+		 */
+		nents = block->sg_table->nents;
 
 		vecs = kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
 		if (!vecs)
@@ -115,7 +118,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 
 		len_total = block->bytes_used;
 
-		for (i = 0; i < nents; i++) {
+		sgl = block->sg_table->sgl;
+		for (i = 0; i < nents && len_total; i++) {
 			vecs[i].addr = sg_dma_address(sgl);
 			vecs[i].len = min(sg_dma_len(sgl), len_total);
 			len_total -= vecs[i].len;
@@ -123,6 +127,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 			sgl = sg_next(sgl);
 		}
 
+		nents = i;
+
 		if (block->cyclic)
 			flags = DMA_PREP_REPEAT;
 		else

-- 
2.55.0

