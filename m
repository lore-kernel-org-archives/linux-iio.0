Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A862395AF8;
	Wed, 14 Oct 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993534; cv=fail; b=pVe/Cs4+3ODzqVNEnqqOFC6/SS9nCAufxsvaw3otTRmxLYUs9LMsNXJGNHNKvJf0JAes3Q5o9bm0iphjthA/nzijF7TE16Hq0PcyNgkHPJS7dZLv6iH4zmjJ3fTzRBacwvYu7RcpfgwKsiICF7GlxIPZTQcrBlFBJc4TiIvCCjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993534; c=relaxed/simple;
	bh=gsqIxIW8VpVGcFbVfW2o/8FfMyJgiAxdnAPKuJB/OsE=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=poEW2cE1M3A54W3JG/pgFpKFk+PLSdP2j1NKyapeSZohUyA6ASPOa2hCZeFDhDlqr1F96/FMsJcWg58jcaZoAQTJFjZmtwtr6nyB8LNmvMJrJgR1RuMaF0VZ/mBlYVuLuaAywNt3Nfpqnuv1QCaV1ubl1IKowSIxmntAAYQQYUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=aNomIKsb; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MZ2W13/O; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="aNomIKsb";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MZ2W13/O"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEkele4015289;
	Wed, 14 Oct 2026 11:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=p4aLbQ81ji9wDYkNahZNCv0CDVRuwxHfTVLluXfgpi4=; b=aNomIKs
	bbRiXGQZ7UBpMAkUUrTdNIs/IxUXRjLnj+rCa6SbcWlDtXb0YTAts8yxDVzdFIKf
	0W4teYOQEAP/rKiRImyIRqasBGR+fhq76one1AB9UJlAtqdzk84LcPvP7unwI12W
	02WvsOCwibHBchmGUBrQN3mqe+vy/1o0Xoa/ZS3rAnBR1vtxgRPVDDRA7FD76SI2
	NkyZw3DI5G8eznfudNGzYISW7KR5c3UcWBinImQqvjY5X9okF6J7XCMarBfYQQnZ
	Z9CQz22D+YAjVal8XNCF+Z82dXqz+JHE/xIQ37m4w5jwPyyvFSZV88jsyebc/zDN
	Soe1ibIta+LXF8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=p4aLb
	Q81ji9wDYkNahZNCv0CDVRuwxHfTVLluXfgpi4=; b=MZ2W13/OspMUhSqlBCe8D
	IOwB/WVcYJWqjpee/9j1Zt9UaFaNEYoYWVP8AqLywnlKS2+SVqbUKyO8eogsI/k7
	7dVrRbcHUBN+PA2OXCcJSoHpQnKs5C2oQkvOLnORVMsR86D+TgvYmIcSZuz6Vt76
	yO0dpZD2auZH5mbY94YpFRdnR1o6IL8VA4Ow3DHmOxqMWj8kiYUy/Uhtk7Md051q
	N5kvvtDskiy3ded10xDzlfxRTBr/vyAF3e56gdvrx4Mz0I4xJetOOIl/0GpY3/jm
	6FxFINUIcsVhYLi7QYF8x/6UAI/tW2Zh/tQzfOdf4IhEk/DVFwbrP+g4FH4yV6Zr
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4habt3gbuk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 11:58:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPB+yyqXIlTLMGFgxPPItMIRCo/bgNmJ62j0fFUw221pcsjE/fmLwPmeAU8n++6W6B6WJHpIAmnvwQIsJwCreGH6vpLlhrWe0XZ4yOvaGj4sOgIm5+hIhB+Pl6l9ByPBS3EDaXTLOIxNZtgkG7bxyc7oaO0AgKMiyQps57ug2O/ZHve2FAEavxlLGZToRPtrwOSvX4bLQ9n/sKesZj0+mMYQapcTXJ3ZO4vNh50MByedsvMWfjIc21e2saU3Dd5sjInJ7tnijBGOeRizrYTDK2mYKUK4W21dyXr6UQ0+meyYL3iZtWF2uc4yZAy/UlW87exwJVFCn/pj5jgAS1Errw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4aLbQ81ji9wDYkNahZNCv0CDVRuwxHfTVLluXfgpi4=;
 b=LtHRvHK2/d0287rafKLYq6SXMNMp0ajs3hL+ehPvdlF5/RBNyoxo9sjLkPHS+31bpAaPyG5rGDyZKtgE8i0yEqsfnTtPVzqBYUjbj7HUU3TTOVdssiHNUe9NlsWQKkgN1qH9ZW0D6zX0BfUK7QiletLtkfa/nmiDrkP3HqNUiKqRqxzBs9M6VDOQCOLXNSAeN8n2UkB7IyLpU2sRF7DCmnZVcv4MYJ0wH11iTOipG0IIWTOT1B47NLl0bREL5TulycWLE4RpbTFXq05r9YwKeWiYnc6i3FG2nJPYYK/7CUb6Hjy54CgVhzb6yeETAgGlocGk9FzhRmKCJGTnq64qkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5563.namprd03.prod.outlook.com (2603:10b6:806:b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 15:58:45 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 15:58:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 05/13] iio: adc: ad4134: Run shorter transfers when
 CRC is disabled
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
        conor+dt@kernel.org
In-Reply-To: <as6a9WRxHHav-Nq6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <e46fd2f9b11ff2b690483bc2ea6489b6d145c773.1791309733.git.marcelo.schmitt@analog.com>
 <sashiko-outbox-162348@kernel.org>
 <as6a9WRxHHav-Nq6@debian-BULLSEYE-live-builder-AMD64>
Date: Wed, 14 Oct 2026 17:00:06 +0100
Message-Id: <179199360607.658576.10891641148019999891.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791993606; l=2535;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gsqIxIW8VpVGcFbVfW2o/8FfMyJgiAxdnAPKuJB/OsE=;
 b=x7oum991Lvg2aewteldQqC91DnZ1HYtOXPlB/9DgRp/zmHMbh95TVUvSYoOG1427zyjGtGB7k
 MG7GLbowS82CZb5V3W1kZI91ncYNeXlTiUwvacvl0VuPsXy/C+61Eny
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0140.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3126b6-7e0a-49db-c729-08df2a0c06c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	pq4PUqja9M6rfSPs9DzWrZZd+AKgrdXryzR06xX2m0+HXszBYELFbQzOa9UUymy5RWDxQNEhfC1CxRJvaiLIJBiaJat90jNxNltPqeZcch4Ty8kzHRAwuQh3Qvfb6Amjrg+FpIQZadiXwBtpsJ/v7DLBST0m06Fth1PXIbyTdTlb6XQP33ymBWFqRCA9tVCJwFBdeYdIujTCi2x8CDoRAx1zpcy7qrB3LNC9wWHBiiuGw7Y3lPlxvhIl+72lYtGTxPTMBvWufRXp5a2tju57p093femIfk6vpW/nZaSj9qWjy0S0Mz0zyN5+SeWTAEnLYVW8B+Dv/QXNblKhlcrKKpRGB4JW1k0PzxeK1M1ii6E5pn6+3oVWbRqHBiAvh3mE4RhxX0+HeulcCmt1GwTa7vwXb3QXAO9q0ejBato8qhnECZ+iyvPXGYDVz02LFgMrWiWJ8j/7PNM61ppec5JmOmjqdiG80AsUS34KN6IDUvwSnULWaKwhlpAmNjEeKwOMbdZH8imq4LJlLrw4wnUWMjcrGENL6xqvZvxEsj8ijegc7+SnvnPdLYALc0PdX1k1LfB7XArvCNpyqrVGapv5hBhleQds75trtKO5f5LmqaHnUMXyJ1znxJrSy7qiyjzloEvg4kEFsjlsOe/EArwvTrMG5jky6AkzSjIrRFcWK1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJtOTN6SUVXbitTL1NnaDhEYkVOeHprbWdIV09nZ29iQXlzQUxCZHNseUhi?=
 =?utf-8?B?VXkrRnU3WEpsb0M3R1JHZjBZQlNBS1BHNmlvd0UvSVpkWWtHTWV4MDVUcWU3?=
 =?utf-8?B?cFd1Ymx0K2hNbXpnUGxiUENyeEdrSFV1NTJvZ1EvZUtkRzRKV2JQcFFqOVdt?=
 =?utf-8?B?VXFmbENZWWFPODNETmd0cEd1UGUveGVTNG5rU0cxYlE2M3NXR09Ic2ZHNDZC?=
 =?utf-8?B?cGdheGVXRnVhM2JUKytOQUJwOHZJTGd6alpoRlJkT2NYRW5SbDNsbVBadFMy?=
 =?utf-8?B?MWFxbUZuemRQYW1JVnlzemFXQXFzbTFIdmVacEh6b2lkT09VZzNqWG9zdllC?=
 =?utf-8?B?aythUzRDSWR4enNaUURoYXVIM0tlSmlML2REM1pONUxDWERZZWpQalVhby9P?=
 =?utf-8?B?c2pCR040RjVxcC9Kb0VrbVZUWEZuN2lVZFEvK3Y5QXVtSTcxL0I3djJMUnhH?=
 =?utf-8?B?NWpOT2M2cmttMTVxSkZGcjlRSDMrakNBQlM2R0N2dER3Zm5NbGEwOVZoY1pW?=
 =?utf-8?B?UEN0TmxWVjZETUlKNlAwMnNGZjNxb2hyaVZYb3JiSTVKcDN5L3FwL0dXTzVS?=
 =?utf-8?B?WGpWL201ckZqVjJVanNrYzNUcExiZGpJTFkxbHFtcGREYk16WnU4Z25aYjdi?=
 =?utf-8?B?ZVAwK1NYVEFKUXJ2R1dmTDIvMkdzekJHYTNGdzlqckhJL0QvTVFkb2NBQmxM?=
 =?utf-8?B?YStjNVViSFpRN1lob09YTTE1emdTd2VaSjYxUE5jRU84NHIrQVIwOUx4TjU4?=
 =?utf-8?B?SFBVWURGWllJQmJ4Q0V6YWFjamJOTGsrdHV2amIvTTZuekwwZ0hTMTgxV0Fn?=
 =?utf-8?B?Wm5zbVcraC8yeENENE9sMEZtYk9mWnFJSlQ5b2g2cWlPUVgwUjFSVnZ5eFBw?=
 =?utf-8?B?cnN2Y0RiNzRtYXBueTNUelNFRkJHNGMzaWtIbG1KNklTcXFCbTdFait6SHZQ?=
 =?utf-8?B?QXdqM2ZrTDlQczc0V0hlcURwRko5dUtVQjlYUWFnQ3pwZCtwZU5rSlB6a2RX?=
 =?utf-8?B?YzYxUVZPTFZaQTlMb1hWdW1DMlh2Mkt0Q2ZXY0duSmFKVWJsREVnT3FpYnRr?=
 =?utf-8?B?VCttRXFnMm1zWDZoT2FXdWlRbGVuVVNpQk5qdWxrcTZTMnNhRDJ2RDNDMWtN?=
 =?utf-8?B?Y3RXS2hjYUlBY0I2K25UeTRNTUpDUno5OElRQnN6QlQ3c29mVStGWVYzd0NQ?=
 =?utf-8?B?UEVnS0J2L2QzVnJUQ21qQ0Y0SnduSXBQSjZ1eDlIYk9JeHJQNG1acGpWSXFk?=
 =?utf-8?B?NCt5MEdUVUFpN2NIMy9RMXRXNUo2WjZaV0ZzanhadTRkZkRMaFVNWnNqYklM?=
 =?utf-8?B?c1kwemJ1K2lJSWJIUjJBaXpoLy9jaFp3dmJuU0pBSXlBWVk0ckJTOVZhWXBF?=
 =?utf-8?B?bG9MU2IwMlppMjlwSzdMemtZbmtNVkJkMjhZN3VGZjRZRUxWbW1LTWdFbXRR?=
 =?utf-8?B?eW1WTGJGVThwZUVuUHRCM01TWENBU0EyTUlObCtJaXVIajdwMmZ2encyZUJh?=
 =?utf-8?B?WFdKclpxcGxMZlNkM1JML2Z6YmFFdFdQMkdadE1lakIvajVqditNUXp0a1NF?=
 =?utf-8?B?Smkzb1pGeXh6RHl2eXFJeE1FbDFYL1FPNkV2dzhLcmV3OEc2cFdWWmJJWE12?=
 =?utf-8?B?cCsrN0JGNGxlRnJFWTRCNUxXT01XM2EySHd1N0pjblZZL2RjUWt5WHlrV21v?=
 =?utf-8?B?WjRaVUVXbDUySlVsYTdvOW81RmhKcnpPNW1ZQVcvMG0vY3JBanNYRWRBbDl5?=
 =?utf-8?B?d0U4S25uNmMzUXB3NG44ZG9Kd3liTms4ZkNxcFRMWUJNelN0RnNLb0VCc1px?=
 =?utf-8?B?bE0rdkFQaURmQndxZGFVNU53QkNmU21ESzVBckJPLzl2d3BjcjlEOGRNZldV?=
 =?utf-8?B?S0trWlZmYkFndjZwTStnZi91U2dnSlRpZ2dNUitPZDVWUGczeUh1elp4aExP?=
 =?utf-8?B?OHZzMGRKQWN2NnRLcGhSTkM5NldQTnBVRExGYkdIRnNFb09waUZpVTJNRFlC?=
 =?utf-8?B?MEI5UVNvblRtZCt1NnlYKzFpeGNJYmN0NkcvbjFDYmd1bEdqUEI1Wmxvc09h?=
 =?utf-8?B?cFIvTTdMbUtIQzFwQ0k3bDZVWHgvTEsxME4xdW5MNklCRTJvVHhFM2VNTThL?=
 =?utf-8?B?cER5WTZzd2dYMm5ydTN0a1crOU4xUDI4RHZGWkVCTWF5cDRtOUxlRC93bzdS?=
 =?utf-8?B?U1hHWUIxbWZxT3pIWW9RemhqRll6TisrTnRHTDZMNmJ0VlpEdjFEa0F1bDRN?=
 =?utf-8?B?QUJjbk1Bamp1MmVpVjBsSWlSNU1wR0RVYkRuNHVySG5wMHg0bWVGcDNUcmJC?=
 =?utf-8?B?RTFlTG5oNHgyMGI5ekVLL1k4UC9zcTdMVlhwckRvYTUzSWZpRkszZz09?=
X-Exchange-RoutingPolicyChecked:
	Ik0D0aHyyEGNfOQUdgnidOlteHE6gOkSAP0t8uFTB6F4EfEMSIBcrJzMQWre8lCQ8JxkBbExv3wcx15xAYpA1TN1Sn4rd4kHmse366/psngotjhLe2Fmh3ahmmH/iWqIl256AoVzjkSUrNoGijjKpR8p7/M9VE/hDwPQiCfD39NYw2VWw2wsMtKtuoy1uXzw4ttd3kmTS4zNcYMPbEARM/CziDQd5WGHUQ0cd20fMCWLLOQK1274z3Q1brzsOfd7Hzx7brM638uze4DSoQoOObny3biOePU3aoDxAwTSfGrXzmT9B23EI9dl5JKgCH4LRpMhlhUbAb4W21axVPB98A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3126b6-7e0a-49db-c729-08df2a0c06c4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:58:45.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm9K7NHhdZfcf8y8TZa22EoUgJK08ylDljbUo6LtDCN4TTu+FA6WQUXhDD+/cxB664oDyE2F6YC79LwRgMKEDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5563
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2MyBTYWx0ZWRfX86bIhE/WdNsc
 oTBkj/Ia9CL9d303DCqsQA/P6fcaoEB3Pw8BtSTF0LJ7fzZ5SYy2FRMeXMuWtARZK4SjxJtd8Dp
 NarZBQKxKtF7yyhZXp4nhjffFGoup+f+cu6f3Qd6rohnFQ6payvJ+Pt8rg50hZxsYaZ128YDNoC
 tjZ77y628U2KRZ+/TEiWGce0eb2TXLwXX4cBwjgf/07ANNqgFWM0bTcUYRxUX1+1RqAYnlaLcp7
 H79J0Jb5xuLTi7jq1BF6Ye8wN4I9Jqg2TDc6xmzvDGHOrUlv7f4MvBXYvMDkw9/uRu4Sncdy5F5
 evZOknxcI3Kqd4QVZzUpIlMROgUlj1QwLQPBD6F9MB2cbTQDfENfMVm1TmnCAlmAxoKxPqJs/3m
 FYHJJMfnZT4KGbJQ3Qk3xUczSIdnzb7pPgM2uC7DUAulMKnylO8L/nneNUJjThh4vWY2EjYSaIL
 uklhT3zR0O8okZt4LxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2MyBTYWx0ZWRfX+iFz4EExoaB7
 9Jx9kiJuCADnjzTaY0Yu/8QCU9K0Rio19P9ynidDweNpwPPV9PqPQCe4FFQ3WffvbFa4QY7+0U+
 qFmPZbVbE+v0utZ4J5JUjEVuP72VK4sCgVANW0bmExCikj3Ieu2o
X-Proofpoint-GUID: C83Wi9OiPW20qQLraF3npP1P9zIujW3o
X-Authority-Analysis: v=2.4 cv=IsCL47/g c=1 sm=1 tr=0 ts=6acfa6b7 cx=c_pps
 a=n2iMVF0J/Egc90AivcUAPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=mQYB4POxZAP9Mk8HQQAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C83Wi9OiPW20qQLraF3npP1P9zIujW3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140063

On 2026-10-13 17:56:21-03:00, Marcelo Schmitt wrote:
> On 10/06, sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Medium] iio: adc: ad4134: broken SPI read CRC calculation and ignored failures
> > - [Medium] iio: adc: missing delay after reset deassertion in probe
> > --
> > 
> > commit 5284b96efc125640c497213951d3fabe580894ec
> > Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > 
> > iio: adc: ad4134: Run shorter transfers when CRC is disabled
> > 
> > This commit conditionally reduces the SPI transfer length when the AD4134
> > CRC feature is disabled. It introduces a crc_en flag in the driver state
> > to skip the CRC validation check and send fewer bytes when CRC is inactive.
> > 
> > [ ... ]
> > 
> > [Severity: Medium]
> > Does this CRC validation logic reliably verify the read data?
> 
> It would require mid-transfer data CRC calculation to properly implement AD4134
> CRC feature. That would probably require changes to the SPI core or even more
> unusual hacks. Fixing the CRC is not part of this series and I don't want to
> extend it further.
> 
> ...
> 
> > > @@ -313,6 +314,7 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
> > 
> > [Severity: Medium]
> > Does the AD4134 device require a stabilization delay before interacting with it
> > over SPI?
> > 
> > In ad4134_probe(), devm_reset_control_get_optional_exclusive_deasserted() is
> > called to deassert the reset line. Execution then proceeds directly to regmap
> > initialization and SPI transfers without any hardware stabilization delay:
> > 
> > 	rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> > 	if (IS_ERR(rst))
> > 		return dev_err_probe(dev, PTR_ERR(rst),
> > 				     "failed to get and deassert reset\n");
> > 
> > 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
> > 
> > 	ret = devm_mutex_init(dev, &st->sync_lock);
> > 	if (ret)
> > 		return ret;
> > 
> > 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
> > 
> > Without a delay, could the first SPI transactions during probe drop or return
> > invalid data, causing initialization to fail?
> 
> Has never been an issue during tests. Though, I guess it's easier to add
> fsleep(AD4134_RESET_TIME_US) than to keep replying to bots.

If the datasheet has any specification about this, then it make sense to
have it. But as another patch (could even be a fix).

