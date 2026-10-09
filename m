Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC83939B0;
	Fri,  9 Oct 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561237; cv=fail; b=IUH/A7Xsf1V8c6Kyink3oZ8BAYwXMA9XDzfLomyXZpU0dIOJd8ONxlAhMxnQOLThsKd31dZV1tDFs6+1KiP6a2QbXq2EkqAMVOo45oI7l9A9+M6ZQSZ9/uNqr/wS43sHSSzJbUVteN8kjPUjhnkQqfycUUccuBENaiQuLTzioqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561237; c=relaxed/simple;
	bh=2wAwlKov0hlOFOwLvCBfP7NUtqHef71raL0y0UBThkY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uUhnKwvCP8wfK56QHMOUQ/30iX2iH6e8OcuUKZt54LI8DL91aT1pp99X26ryHV2aWBT8bK4FIt4yLljq0IOIeol+vOZBcTjIBuUDFqJIT6NaHMUK3lxc3KbPmMckbGpkFVCAA9QKRQbnIomaRGOpNrfaR3IuWcvWBmuSSHfKWSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=bYXJzlhS; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lb4Td31+; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="bYXJzlhS";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lb4Td31+"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699FHi4g2589140;
	Fri, 9 Oct 2026 11:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ldHoMYo2gyllYWnAXhf6KUWiSQ18YDxONwAEajRMMs8=; b=bYXJzlh
	SxkAN4bnjYbUtnHisAvora0/km4n77uLrG2HtgAY8sbWZWmDcx2kmucGGScs7y7s
	8vFRjySiVQ8Q0muSZcsbJXkPTyVCECbhP6cJQ4+z185x/Ts7/nmaFXhDHLij+8Y+
	fFT3zIYeCYW9QL1LNVg/gL8KHI09TIBgPUhsZ8OYUMYrf0B6aIxRS5nmGEw0jPFN
	eUJXMMAEELYYibyNxWpJJEAVVbFlv9PESJMYJBueGNTvuGTya+Fh57Vi3LxEcegh
	k1TUt8XHd9Z94bau+TutBziPFI7YON8BoX2Z2h3flQOQ7xeteyYDiR/akIQYAnZE
	zepreFLbj4U6ltw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ldHoM
	Yo2gyllYWnAXhf6KUWiSQ18YDxONwAEajRMMs8=; b=lb4Td31+oNC4ky55iqXC6
	bziK0TrOY4VMYSqgmnyVcALdjbxnGNBJcgJl+XLhFyQyex8A3ktV6yA6Oh0by8/P
	TGdMF6ia1AtDi4jkIc1GX4pYWtdLxV2Go3tLki1pphyROjNoHDCK231FWYxfFtRh
	nYJ54PFa+F7uYqAQR5fxzvscywEcYgAttQtj6SEjQhnNIAcaLCz6ro5CE5rGjDnk
	lKbqD5l6sJJQSjqxQjngAIccIEhMnIN9MiHokGy9QTu9zxiyQ+hbR3gUi6GbwvDH
	uv600IMIfVYjBk3NOc09BIaSJJRw2ek2CBBn4IW9pWkX5TMEyFNHNyFG1uHs0J60
	A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h6gs35pw3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:52:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyImq4+cIkuwnysIcma+iL5S1emPrBfr13sIuK0i+/oOiXfb6fgzts1uYDwUk4StH/wZ+UxHUh4umWIpmJ+75wozE6wgDgOavP+0gQGw6SsHk5z/+514Hjc7zspoAoxdV6RswGUAt1Ze1tY6Mfq5GWvYZj133RuvFWVlitA6oPdI6R6VyDhda4emsFltmMwULaY2s1Za+XZrX1Miw+8gIfbksN4koS4lyYBNg+DmBcwP0AUgbBoE7tzyxZ9CbxavsMYeEJ1M20UJwaTIagC8KHE3deJ5ZrYSPtblAyFu/bhU62qP0N1+Pw3p2gQdOTwvzQYl7BCcBJsBrP4An4A/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldHoMYo2gyllYWnAXhf6KUWiSQ18YDxONwAEajRMMs8=;
 b=iHPXUewsKxdgmTEFQEB+C4IDCeuHECB3kRW/3zRAmuGH4TIMA1DaiIB+31m5PNZMcSYsWB7eBbBIU3yE0rLx6sOa2AgiuKA6lxLxbDo4lzRW4KXYLYrd5M5EftntXkQv93ezjqnfmz469yq0Bpnzv6W3z0PBBi0iMfYzAk3MNpHh/Do8Pv/2LmI62B0spJxEtHlErABONHjVDfGp7b3PrsnPZjXbdI/PA46w5M59YPWW42ecFtAZvd231uxVUNjRZ4zKO0IP0cTeQYeZIy135dV3uIB3W8U4itGicZulVuQoNkxU4/o3GI9QifUu4OpZp+k67hEFA8AnTI0h/RFioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB5496.namprd03.prod.outlook.com (2603:10b6:5:2c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:52:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:52:09 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:53:01 +0100
Subject: [PATCH v5 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-9-4c4e63a7a1af@analog.com>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=4640;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2wAwlKov0hlOFOwLvCBfP7NUtqHef71raL0y0UBThkY=;
 b=y8Oj2yIJ59Gt1AYd62btKlI+e7b0Dod/K6xTqb6QFaZ09ojdpM56yJA8eau1I/z6AeFsn/nPa
 tNCbobQKwqSDkFG/WOnRjaL6u1dEx/DHblQzUpiVeGeV2RSA6HxRMoi
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0041.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::33) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 548743f1-f49a-493b-a0a2-08df261d46ae
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
 03OBq87dVMvvn49Qpeh5gHmW332VVspgXkhz+6GAZ+fUCdFMerjBpFqAXA4j40lh57q3FyqBjr+ZUl6LPX6uJ/A7R5KPota7m//k+P6+uUgMssADlhElN8MEv0ZJX2dzuGhxhYqazcm2zlbGUFBWBEJ1uumUNFAZYcychZ44a6ffl+VX8f7touBq+kPu8593otukUA7h33pIOF/biQjy/qchjB5yDifPqVz3Mayoju5zkcfVCFocgVUy1LTr6rVMHtjzmjW9asP+47dWvHfh3GYzTVjiqYC9zkxmsOpHwnduB4xF8V1bp/FZy/t5F55efC5EToOKiPgfP0g2xvtAGc09zdnOM1DPUoO/W2i8Xcs920P17woSV2LvObvwitlzrNdL2dgIsziSo8pa9DEoGiQer9RM/8yrqQsMlzFYbBn83YoonxqgS7iCgieIJNAeVI5rSSn0Q1a9x2SUlluH9V1/ZC2/Woz3nXMKt9ygVDoWEyZdaJwucIT83P7EMjBHPff4OKs4TvnPxVhhs29Gwm2EYmxzigp6aB0SklFmfECiQGkaYUPcpZxJg8XbVghPA8RermhmCMdv+fC9txouDdfzhWVMt08P0So6heVPXPAzDxZLbTCMMMu2ezPL64ivw4fY0VNn87SknvuQDT8ZHHojXa+Rr1ouoSuRwZJyf2U=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b1IrdG16REx4cWtLRzQ5eE1xVWdZQ3RRU1NRcDIvSDN4SW1ZSjlDNHNEQVhp?=
 =?utf-8?B?MDl2dDB4SGJWN2JncXE3OTRjYzd2aU5GVnhTVGNkWEtuTUY4UStPZUxVWlFC?=
 =?utf-8?B?QzRGY0FMQjFmR0ZwZ3hSTUZxYVY3aW45WE1TYUVGKzMxWlQ3aVBldWtrZkEv?=
 =?utf-8?B?YVBjTFdPYVA4Y2g1VzlJVUt2aWVTTzVwNUFVU0FRdE0xbG1tWkEvMSszd2ND?=
 =?utf-8?B?RnV3VGk0UzlLSkExQWNTVVNXanpmK1VaeXRmZysxUHE5eTNPV1FLQnF0RFVk?=
 =?utf-8?B?cTR6d0M0U3h1dHpTanZ3V280K1RTejhvdW44b0xUR2pCMVBhY3g5ZkJPNHBJ?=
 =?utf-8?B?aWpUaEM1WGJkTXRNYzBrazJWYWdtVDdsN29UdnpETEdQL1hsT1grNW90ckZ3?=
 =?utf-8?B?Z1ZnL2V4eWVucTBac0NGcXFURE9wNGQ2VmtXY1pCR2Y1eHArNGJjVGJTeGRP?=
 =?utf-8?B?dEVSSUhiaUVEdkNTUml4ZEIyV0NrMUVyYTZ4M2pTS3FTSFFkMEIyQ2NMVDFn?=
 =?utf-8?B?TWRyZ3VqM2I3ZnN0ZzFnR05GZUdhejZtV0lwTnd2Zy9LRFpmWlZWeXN1RTRl?=
 =?utf-8?B?NUJhVjF4TjYxQzVuV2NnREFkWkFhVWRFRVFVblRuVXgyNUxTQ3B4Q0VCNlA3?=
 =?utf-8?B?R0xyZlVtUG9aQjIzRithMFMreWFJb25DL0o4ZTBsQXREdU0yM1BTNE02enRD?=
 =?utf-8?B?N25NOWV4eHRBRVgrTjhleDdwV1JFekVORUlHNlVoM3ZnNHRtbGs3LzMxRkZS?=
 =?utf-8?B?eVhjTzVzWC91YlJZTlZMdjdjeEovM3ovQ2FsamxHQVZJVHJlTnVZYUN0RS83?=
 =?utf-8?B?bm9obExESm4rTVJ2NlhYS0wycTU4RUpEUTVCR2xYYUIxTG1hc1FrcXhSWXNt?=
 =?utf-8?B?MkNYRlJwRW01OXNtaFBuak83OEltTHo2RlAwSHBTWW1jZmE1K2RvaWlFczlj?=
 =?utf-8?B?ME02L3FxZE8zRE8vdktGT3NHbHpUOHp6U01ZVitTczIrdVA3eXdnUE84ZTdn?=
 =?utf-8?B?cE1MMXFrK0NwcnFFT2dOS2M0T2tUN3dzL0FmMmRPZ2FKdUZJMDhuOGJ0S0VB?=
 =?utf-8?B?OFNRZjEwNHkzTkRuZ01BMnBTeW1wd0JaVHVwUWVPd2k4S0NwMUNXUVpNQndJ?=
 =?utf-8?B?anBhUE1QVGdaRVVWRTVLYXIxekhlTEh2d056em9BK0ZUOHlvNWNjeFk1RTVY?=
 =?utf-8?B?aGIxVTd1WlBDL2hCVFFXRUlvR2t2T1VvSVJDWFF4OXZVRlhPQThlb0NrWVhH?=
 =?utf-8?B?aEwvTUpVWkNFYnVLZkxFK0Z5aHJnK3l2R1NkSXdDRU9BNCtYSWdTNkVVTTUw?=
 =?utf-8?B?T3plZktoNHhOb3Z6dmFwdFdGSmtWSVI1cGZkN1hhSk8zY3FwSWpKMU1RUUZ2?=
 =?utf-8?B?cU1lVzVZYWNDWFlXaTdzLzA2RVQvamtXSUZMR1RYbnA0cEpyekN6SzJEVXFQ?=
 =?utf-8?B?eStDZmtVWDU5TUIxUGV2Ukx5UzJlTnN6Y1lwSUZ5bUVLaE9MSkdvVkFuejc0?=
 =?utf-8?B?Wm84K09SdFNXK0tZTjFVSXFBaWFma0xnK0MxdGJpY2hjYUhFbGlZRktIYTl3?=
 =?utf-8?B?RElUeU1KUmpLQzlLRHFZMUtXRnY0K0QxejhUaGF4a3RpZVJQQVcwcjMrZmJm?=
 =?utf-8?B?WWtUN1FPWWhsWXp0a1FaTVh1dVFkclRQMExIZGRENkFlZlVDcUhjWStoUWVy?=
 =?utf-8?B?Nmp2WkhFOFRjWlVyeU1EdjRuWUk4Q0dOWnV5aTlQaDFidnJrdThiOVBFM3ZH?=
 =?utf-8?B?cW1RTlMvenE5dkNqSGx5S3UzY01jSUlnS3h6WFVjVnpPZUM4UGdneStWYUZB?=
 =?utf-8?B?ak41RThDODZ2eWk0S3Z3NmRzVUNjbGgwN2F5alUwWnkzY3QvWUJpTXpYL1BY?=
 =?utf-8?B?UjZYTSs0K3FNZmx4M0ZzTFZGaVRRWWhNZy9pL2tPSWRFenU4aTBpdDBmWDR4?=
 =?utf-8?B?akxCNXpxVWM2ZUE1WVozTVdScGE2MTdpTFNZY0lkVDlrSTI2ZHNFbjlNQWtw?=
 =?utf-8?B?Q29pRCtDRnlxMHNJaUNoWERlTGVraE8rTElraW9jMmsvc1hvWWNrOFpIY0JT?=
 =?utf-8?B?K1lpUjYxazVOMlQ2ejVxMEoxNGVSclFXMjFLWG5LTXlqUE5NOWRHVWgraXRE?=
 =?utf-8?B?Mkp6SGNXbFY5aTE0a2QydnpsbEFpWGVIZkJ6S3dnaVoyaU4rcjhic3hvdUtx?=
 =?utf-8?B?NGV6UDJIdnA1bndkUUxGV1J1VjlnY09URTZEeVBKT2JFUTRmLzdiV0ZXQkNw?=
 =?utf-8?B?WnJ3VXcwOUZ2b2JteExrRmpvdmJhdXZrbEI1V1kvdXNpNlozODBJbUtDanZP?=
 =?utf-8?B?ZCsvRlN3SGFQdU9mNnFiWjFjQis0clFlTFJ2ODh3bjdUS3E1eVdpUT09?=
X-Exchange-RoutingPolicyChecked:
	SDb3vojLCCMmDFM8H7tRQJ33wbuGgGSRsj9loyeI4ItIpe+UrhQzeg6t3IBMJ+r3efHJ4W/Q+CrOY3tRuCM4wVZKPtFWDQtsGkijF2LYcsopB53QZwTBpZLvUQolktsVGilIbVvA3s10TEZr0FvgeH+7onAqCVg+WkLKSeEuhBqP6tlC4FgMS0FrWOg2XB7mgVrCooPmC+ZQ9ipVA5uDUTeAksK3CU2X7T+yuKBa+KRFXxlb1FYBlUilNtRh6bsk5ggr37lzdxAcsxKNuFHIIvw1jDqJ67Nt67qNnDvmuG5Kkih4sE0WzEzlA0B3P5f3fGRFJqbZZjpnucFZyqAk8w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548743f1-f49a-493b-a0a2-08df261d46ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:52:09.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/QVi6TwsgNcW/n3OmqtOAo6XibNhyI9TekVLOIM0wgXQGh8H5PwmV53/N/pkQo3BCHP4grKSJGxoRu5DWzuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5496
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX7PwKq1TBAkAp
 Ba/PfrH62R3ZOm6OpT8nvsAgEBaAdGkkC+zvGptur+sNftfVNWSb+NmEtgnkLV3JT2uQdIqg3SM
 9KwZV19rO1thV6vPn9l6QxUJoWyrJxhD0H3MIjog8oliamqpH7LoLwxpxDhJsVSN2/d/M+aVT9G
 SePd62Flmp2CutRut4f1qpU/IySYhwviqwN5QP8XplVyIis5714uhYf92hUa5ARWDBDmheqCHVx
 plSaCDvWFd8c79B74YoOAr/33Vnfhs0iUJQkZ8hYQv6ZohlxcOb1+dsy60Hh2OmCO9YJrKQRvww
 1gTWa8/AdM7Q2kWEp4izVo4aJDqLikkxEoM8EZ7npMzqb6mDn2dKEVxedE8mqGZVMnkUMvV/C6r
 7Ew53CgbW9GOfGNt6V16BwZm9n2u+c5zXVwMHHqtMEO0nFvU3yQ9bAlASNVs9zMwgcC34czAWZh
 cNQZ8qDIFtmtBZDXg9A==
X-Authority-Analysis: v=2.4 cv=KvvYSmWN c=1 sm=1 tr=0 ts=6ac90dab cx=c_pps
 a=ASIy48nXBLRhVdclknX/jA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=CIoI50WrR_K_g9tIiWcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: jXileHefGK9uf747txhocCuftTjqcgkC
X-Proofpoint-GUID: jXileHefGK9uf747txhocCuftTjqcgkC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX3PHdU3uh0MR9
 jHJmeUNXj3yBcDzEcSdDgKHBMLnJTT1lX5DfPoAco03bNVJHkyckJYNNkGUQ+dJVhM5vRqJIpKW
 wXE0940wEq6zM+whwbYoF0KM4Rj26mfPD28cKUqPqNeLBv1ZiUoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090063

All users of dma_get_slave_caps() that inspect bus width capabilities now
use the bitmap helpers.

Hence, remove the legacy u32 src_addr_widths and dst_addr_widths fields
from struct dma_slave_caps and stop copying the dma_device masks into
them.

Note the legacy u32 src_addr_widths and dst_addr_widths fields in struct
dma_device are kept for now as every DMA controller driver setting them
still has to be converted to the new helpers. dma_get_slave_caps() keeps
folding those masks into the bitmaps it returns so unconverted producers
continue to work during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   | 31 +------------------------------
 include/linux/dmaengine.h | 13 ++-----------
 2 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4ba9d6c7448a..51f706dadc7a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -595,8 +595,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 
 	dma_bus_width_copy(caps->src_bus_widths, device->src_bus_widths);
 	dma_bus_width_copy(caps->dst_bus_widths, device->dst_bus_widths);
-	caps->src_addr_widths = device->src_addr_widths;
-	caps->dst_addr_widths = device->dst_addr_widths;
 
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
@@ -615,31 +613,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
 	 */
-	if (device->device_caps) {
+	if (device->device_caps)
 		device->device_caps(chan, caps);
 
-		/*
-		 * A driver already converted to the bus width interface
-		 * adjusts the masks, so derive the legacy capabilities from
-		 * them for the consumers not converted yet. Drivers not
-		 * converted adjust the legacy capabilities directly, in which
-		 * case there is nothing to do.
-		 *
-		 * Goes away with the legacy dma_slave_caps fields.
-		 */
-		if (!bitmap_equal(caps->src_bus_widths.bits,
-				  device->src_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
-							    0, 32);
-
-		if (!bitmap_equal(caps->dst_bus_widths.bits,
-				  device->dst_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
-							    0, 32);
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
@@ -1210,14 +1186,9 @@ static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
 {
 	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
-	/* consumers not converted yet still read the legacy caps */
-	else if (!device->src_addr_widths)
-		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
 
 	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
-	else if (!device->dst_addr_widths)
-		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
 }
 
 /**
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index eb68eea840b5..0b79bc4c5f74 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -695,10 +695,7 @@ enum dma_residue_granularity {
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
  * @src_bus_widths: mask of source bus widths the channel supports.
- * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
  * @dst_bus_widths: mask of destination bus widths the channel supports.
- * @dst_addr_widths: legacy bit mask of destination bus widths the channel
- *	supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -717,14 +714,8 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	struct {
-		dma_buswidth_mask_t src_bus_widths;
-		u32 src_addr_widths;
-	};
-	struct {
-		dma_buswidth_mask_t dst_bus_widths;
-		u32 dst_addr_widths;
-	};
+	dma_buswidth_mask_t src_bus_widths;
+	dma_buswidth_mask_t dst_bus_widths;
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;

-- 
2.56.0

