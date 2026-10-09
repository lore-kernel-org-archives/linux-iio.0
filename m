Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D4238D3FD;
	Fri,  9 Oct 2026 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561208; cv=fail; b=JSK7fDgSSEz/W2L/UYFmeaID/pGmQgNweYLK2bkTPYlAbHybtGBXXsu1bR13fzDqw9Xh4R/JwvwBQtsMshgSZiFGefY4SAxV0AD7Fi7v9cRnSJI8S1UNYpD7e7+6hPKbgrf8EFT5QJM7ycsKyJRziYhSSuV7dCAp4Z07AQlCdfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561208; c=relaxed/simple;
	bh=0ud6O70oCURT/9SJBb0QMYtP3epTgEPwCUJSO32VD2s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NBbKBTC1qmbOnMR20Fyi1o4kOseX8hVzCFb4o6eZRTTdyzUMjMg+SFft0ZsNS7UnJQG6V3KZ506aSL9UUBxaSyUqWLgwysZfnuAh8PwJuHfL0L07mpTrCjT9BKzA6gwq2xJ1kOaxasyepSWUTroeoCXseyFAqz5xv/u3/o+972A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=VEhY29U1; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BEjJkHA2; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="VEhY29U1";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BEjJkHA2"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DN9vQ2289188;
	Fri, 9 Oct 2026 11:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Qs9wREzinXTXlh9+Hq9Cvjosd0aw+Ee0+DO/FSXXds4=; b=VEhY29U
	152BtmYKqzTFRcuELVSl4SidkNDPoJM/T9nEMoczC3tBpVZvNHab0/v8ZrzBZCNI
	hvZAyiM6mnIMezSG8LfD8hUnXAwf92D10Junuv3qXI56UyxAvnqTCRALQ24TTsJO
	meKYorw9QXfmsQFf47n3rQKButefoT1/OOfW70EEjWyL3QnTBKMYNcK9HCk3IuZE
	I3aCp5KMYkDpgeJBj7QqtTu+yEhU79Qe3epTWlqLjXRbK1cw2TENxJF9qkZPoOyn
	fvpN5D823II6rVPPpTHaxks37qHgcpHm7SW0C9fZNtJ6w2WIUDpPb+ML/rrZVKgd
	POUk75KfxOd/v6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Qs9wR
	EzinXTXlh9+Hq9Cvjosd0aw+Ee0+DO/FSXXds4=; b=BEjJkHA2Kma/OYvQWYV1p
	x+6Zt4RyvvM5ILH8xTDagiE+tqPDVk60mi1mx6pwP9Fxgffv+tNVJKGKV3V492xO
	x4jytk1+ufeZosSReYkZSBsG1DxH/PPA72JQWsjud5EhdtscjrzDlXFQ8cu+GOwU
	L/qQqQR4EqoUofUrbCoE5nR6CAOLrocMlkDdt5JeNO7uZs+SMl1dvUeiWMucfpVR
	iMOEmQO2X8M1TPrto2hs1c33qD720FgOczFFRC7OzkiPTjgT/OM3c75oF3OChMyP
	as0N5FKRd1PKTOfoXCWzzLZhOxpgrqaEigYEnpKsv3Nx+4ND0Sg8k94tLVu5b0qt
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h6kgmmvam-5
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:51:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwlXObVCHNooav7qSixg2U9P7ttRJ41G9XTA2EJYBlN+OLJ4MmuNUUKEw0uRpMqFLuhCW1EysaLj9XuCPXFusnzaTGsIKs1ihmNuXXGAM0TmZl9PJilC1Lm7igT8sWBwB+dJ/r9dV6LxXwzvePNMET5s/CAsuLUHJoN9wjLc27u9OpB0g28WNgFbNFccnSs5EBrSQ+ycPQkZLwQvoeWCQpQ/54OQHhuWdrx1tgJGxjK+FMVQg5sMfprSTynJATv6SAkynzv5oyk88LtXHqc+208R0iK2G2/C6IEK0ksSRjCzLTEH+RbgnGJmuPbCfr9vrj6EPDt6k/b4zGFkUFSeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs9wREzinXTXlh9+Hq9Cvjosd0aw+Ee0+DO/FSXXds4=;
 b=kZzS4PBn52Gap3qHgFlcPSkqdcu4aIw5xbEMlN4Xmd8CO7ekLBgAFtFVTXw4d7kOJBokENWpgdZquSNfPZGpXUIJSiCBeQsTuX48Pbl2b9oGISm4Z12CLC/bCu86KM3iEidz1puu2I2VeQw4S9jC7SdsqnxaIGOzWQ3kIYpG/sTFcaSi5h5qk+NStey5NrUi2ERtvN9zj90iFOY+ND4utYQIjppFuTntLWEe/wNvYYZm3po0D0w0ac4caoODUV7VAEDJejO8CoN7SfwNncNGJL4hzfvP4l1sDL0wOqXKohPyKiM/RA4uuvoEt7vgP9Teg1lsaacOLq+mlZ3l2JXITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:51:46 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:51:46 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:52:55 +0100
Subject: [PATCH v5 3/9] dmaengine: dw-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-3-4c4e63a7a1af@analog.com>
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
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=2791;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0ud6O70oCURT/9SJBb0QMYtP3epTgEPwCUJSO32VD2s=;
 b=qBn5ezg2wwobEKrWA8lbQf2L5urPsBGL5XANLfENsB0XmRDXE5K+zbX5x4shmon3ExbxyQNbx
 HStrSbJV209Can2D4cZodNmkr/sXmcDyQkwODChY3ElD/2z9xgZJmji
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0072.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c16cd91-d1bc-497c-a7ae-08df261d38d0
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 xDk8T7VBY2VZp/KAdWYgqHjdQKhklxeDRCvUBTqvaPVag2ack84+caKoCzatZcKT/XX7jnIefhtJXsnCYJgcI1KswRCkFHhx4D+Z14L211gzxwZ9nD9kPLy+KadOZy0hc16OJ05C8kOXOkXEowcaagxdjD6iZiC1vst93yQR/1c6nTQE+ZYDgzcON2bjfQi28qsmi/EeZ+h7jypJEbwYUC4dxaviYJqhK3VheSm4IEtmLQv3AkqKHCgyYwl8DrLsZJGqHGbfErTb9cucZhbJjhgG6AlqL0q7ecpr1nks9/7DZJHcLfdv4jPkT09Mqg/XleJ398LOfjNJjaWgVSo/7L98+8C26wtKVyC15V/Je5vHQD4Ib9arI5B27cnIp8JA8ZTT7xk+qymaQXVlr+J3rppapHnInsQT3uRLXDMLwid9q7s/iqIC1oLKx9ihw0Jdq3wHOSA63cRlwqgek4FfXbZYbZHgeGVUHcrN4u4pMcNXHoETmJZl8mGo77v5JXVDWnXFwa5b+HZ+pp7k4T/k6e7hTTJ/Gy0AGYM9z8bGNACrHsveoXkLmc/pY4cwq+hYOd4r7LnT5J3zCJAMknAg9a1NobyP69Sb6Vj6zTWGMipRpuCgTLVkDRaQ+ikQwJz0h4LzX2z2xxMKN8Azygj+81OZe+g3ySXz5bFEpo/U04s=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L3BFdnRDUW81QlpDWi9GWnFZUThnYnhKSUVSclRxUFVZQU5DNHEzMGRtNXB0?=
 =?utf-8?B?aCtrdThnUEYvai9yNHVNdVJiMW05L1o4cVFIZVBGVmhnS1BpWDZXTWZMUEhN?=
 =?utf-8?B?STV5RXBJNmNBU0RRU3FIcTdmWkwxOHdyRjVuMVVrYUJLZVNGcTNlb2JjQWoy?=
 =?utf-8?B?bzZMTTV6WDlZN3J4MVdJSi9LNFlzTFNtZ0xjNWxIV3NZTnNtcjAydXVVRUIx?=
 =?utf-8?B?bUFGM1dvaXRJUEdaU3MyS3BSYkZvRTh1VG5mdDBQUFJvdzdyVW5GdDI5SDhl?=
 =?utf-8?B?cUlMbmE4SDZ2VFB5ZWdaUE5taThONVBMenlyUXVkejdEbTE4TklZRnlEWEdL?=
 =?utf-8?B?WFJDSkxwNFZFZEJ4bVJFN2JnU1A2RjhIeCsrMG5KaEk4WThYS3dQc1JROEFR?=
 =?utf-8?B?czNFMTNaWU9WR01CWFI5SkM0TjN6SFlzYnJsSFZQaER0K3NxcDJyTmtkOXNa?=
 =?utf-8?B?SW1iNG8rYk1VNHlybTdKWlZQOVFUei9KMG9xZTBMQWxnV2FYYUczUjZzWXI4?=
 =?utf-8?B?bGkxYUF4NkpiZHhYUUtiOTIwT1dDbDZsYzRzZEM2TGFSbHRITE5DRVpEMVhr?=
 =?utf-8?B?L1A5NEJkazJkdngxbU5jR1duQms5Ykd3Q3B1elZjOWk3dmtNR2JEOHhrOHQ4?=
 =?utf-8?B?bW1LUXlrYzBaV2gyellXZnluTGk2elhZK2k5WkRKK2JXYzNLUDZlR1E5U1d3?=
 =?utf-8?B?SzFxcWFrYVY4MVVER0xQNitwd3M5c0x4YmErMDBTYnl6VXpCaytrOWxib0RH?=
 =?utf-8?B?RGhhZGF6RTBRRkdzSUwwM2JkeC82UHkxMUl5MXlkRnJva2NyenVKSk9SdDgy?=
 =?utf-8?B?RHV0eW53YlRuYXNFSlByUFhydHExcHdoVEhXSDBHNnhZQjBka0M1UEhiSUc5?=
 =?utf-8?B?M2p2ZE1oQk1mcHpCK1U5UlBYWm1wWUd6WDJLY2wrYUlnbmtjbXd4a05RUkVU?=
 =?utf-8?B?SU1iQnZmMjRHa2pZbm9VL3BrRm9NaDMwNE9raGN1T1RYa0VUSXdTN3MxN3dw?=
 =?utf-8?B?OWRVRHhNbi9OV1hKS25oQmJTNFVRRjRVQmFDTXBlNFh1S2lLazNPZXNwb054?=
 =?utf-8?B?ZmFubTZsYVJ5emJvcEdwLzhXMDFzNGdKTkZ3clJ0bGZ0UG1zVVFSbHJENzYw?=
 =?utf-8?B?YW1WQ0F3M3RSb04rSGE3dC8wc1lPN3pYS3FQb3VVS0EyL1YzWTh0ZjUxTnZX?=
 =?utf-8?B?aTMrOFk3MmREQmVQMjhlTHZCTHFsQkQzMFFCT2Jhc3MvaU1tRzFheC9KaGpr?=
 =?utf-8?B?WjVYSUpuTDM2WldZMmR4WkhtSG9VNk9KeWtzK1Bjczh1SzBGN0xzdERZakU0?=
 =?utf-8?B?ZTgvRU8zL0ljTmtRTVdSQU82eWRCWTNWQVBoOVVWNE90cVNLcmFYdGQ2YWxB?=
 =?utf-8?B?N0RLY1V1a1dseUlDVnFSSnI0dFVMVUsxRW0xcEpGU1M0eGdUSjhrcXFVQ2VQ?=
 =?utf-8?B?Mk9rcjlLR3ZBNUtNSTh0dHhRWk8rNURNNEl4NFArZVpoUGxuQ204b244cHVt?=
 =?utf-8?B?MHpwb3dpQlplYzhyMkV1WjJzbDBJWFZrOFI5emJDNnQ4b2RnYmxFaEw5SUFQ?=
 =?utf-8?B?a1Y0SlJSUUNIV1djN1Z3c01qZVBvQXpNa0I2VVFFMWZkbzlnUC9mcWdLcmJE?=
 =?utf-8?B?TWdVa2RBNzBzMENxQmMxN3pVdnl3cWkyUCtJU1kvOE51b2VtN2dDMnBoN21o?=
 =?utf-8?B?UG5aOHFNOHp3bGhucW5ROEdBYVVneEhkVnJYbU5tZ1FpN1NYRXcxSjRWUTN5?=
 =?utf-8?B?dGk4cTZ6YVZ2cS8xOW1CUkdRbUNuc2FSdHkvSjhjVzJIakY0N3QrU016YzJI?=
 =?utf-8?B?Z25pbEdyU0VPd3ZvTEFPcTlUT3llVTVjWXYyaFVjT1FlbVBnZjUzUGJEQ0F2?=
 =?utf-8?B?ME1BcjBBRUNucDUwQnhlcWtLL2hERzdlRnE1R3RMY1YyeFEyOG9RTDloMFQ2?=
 =?utf-8?B?TXFSVkI0dkduOHhhNytrUjkva0N3alZUSnI4NDhUYWpKSG9XajJNWGNlM1lV?=
 =?utf-8?B?ZTUyTzcvc2NYTmcrK0V1WWlIMmM1R01KVGkrYnY0MGhvc0ljbXlqR0dYclNH?=
 =?utf-8?B?aGQvRzc4OUNXdkJPOU9mKzBNdWNiZGRkYmsxc3dzVm01VGJ3VjYrLzBCZzZa?=
 =?utf-8?B?ZEE3VTU1clFMU3lYRXF0L2hqUmVoa0hzODBpb1A5cG4vdnlCemtiU2xWQzc4?=
 =?utf-8?B?ZXBiYnRQdTV6RHFxMzhLV0dGaHFtdENZQmEzdGhDajZnb1B1SXk2dDUrYk10?=
 =?utf-8?B?OE9KZWQyTkM5S2llTmUza2xxczZlNFRDRExDdGtKV2pHMnpRTDg4cnMzZ1hE?=
 =?utf-8?B?UTZSWmJyQllpc216R0hBYUdvMlcxWFMzSEYrRGxZa0NCVHo1M3N3QT09?=
X-Exchange-RoutingPolicyChecked:
	jHN4mrdFXWzsTjuc2jRKEL1Lb0on2IfhHoCPmYlOoFC+yUK/MM5akeIY3K6yE/OrKGDu7PtpwuJ0puGSgb6wEdNzJQ9vj+pIOLqT2PAPt1d7m+DjEgU+eqxjZIJIEuTuxA/fzjD2yNWZMSiTWmFO5V0981NdL+Ye/Cb8Fb/euT8xGcwE7KdSamozAAxhhwtLbrWh8lfirH3NRuyuqpGDRMXVHl8FdLJdrJt/umraaFVWhtyhG+GMVhIirJNS0dMdUrHjYb44hcp4R9MNb+yYd7CClyvoB2WJTJLGcDJ8rAX/w8OYIDNgpd6a7Sne8fz5jxQqUq1NCpRnIkgP0VjTdw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c16cd91-d1bc-497c-a7ae-08df261d38d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:51:46.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsaXRrRTAOSx/HJTMyhyyPwX87kb9Fci8y85av7mTTSKdMxosd3vu3ZPwArWiCSTm069aaE233GKk4+0FXjvVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-GUID: _CK_vVRM1nhBNn0y4CQncSdJW4Jt0u7l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX9HFjLYsZLqcP
 dkJX4TFHgE1uslgbqjZZYYfhnhxUGldX9/SE0y2PxyyvZbyqluuRYkdtiVPaZu7Lckw2zrooBZO
 0bGUzZFe7fbKotVMK6xsAHexh6a4cTdaJH8WfG3ZxHEnrutkyAik
X-Authority-Analysis: v=2.4 cv=Avx7T+9P c=1 sm=1 tr=0 ts=6ac90d9b cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=y_OmukUNvUlgtTeSwsgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: _CK_vVRM1nhBNn0y4CQncSdJW4Jt0u7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXxZIPr2xCKFF3
 5+j1zCnV+aP+OsNjgRJnrCpfvHXY0q8RjROXnuHXRbcBFSgmMNAU55XEgRqxxiRlekKoWCR8LWH
 nW7lIZ+9h+BIzNrN+mnde8VXbPoxuHhP7wXgL6KMRxIx/y16ASW8NF3I8hP0fCihgeBS1wYFDwc
 ZqxZNymSSiETbkJYnWwQTsRNOlSs/R0GJDMKhLZLZAT+J6wkQgskSlghl943URjcRJCOx+hELX8
 P3aV+lX5rRbz3lIqa4Jsk7zrH8pGL0w6LzoecJ8H2fBuwd68W9MYaHHHZXCOpij5bhiEnFKa7Gr
 6A9vJ3zimFqAJrnhZzT/yGZ++FpCKZMLHH5yz4JY8ZXbYS5EO0JFugxp8ta1h4M+OFrqO0oh+Vt
 gHMlf2bGp8djOlnQ1RBNvqGON4mi3dHX6dlkpF3XJNody35BPj3KpJo7sOcjidstWdpjdRao8UN
 HuWjCLQm9OQhQTnhgbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090063

Advertise the supported bus widths through dma_bus_width_set_many()
instead of assigning the legacy u32 masks directly. This keeps the
driver using the new bitmap representation while preserving legacy
fields during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 37 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f55cc..7b745459f6ed 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -34,20 +34,6 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-/*
- * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
- * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configuration.
- */
-#define AXI_DMA_BUSWIDTHS		  \
-	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
-	DMA_SLAVE_BUSWIDTH_2_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_4_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_8_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_16_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_64_BYTES)
-
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
@@ -1476,6 +1462,20 @@ static int dw_probe(struct platform_device *pdev)
 	unsigned int flags;
 	u32 i;
 	int ret;
+	/*
+	 * The set of bus widths supported by the DMA controller. DW AXI DMAC
+	 * supports master data bus width up to 512 bits (for both AXI master
+	 * interfaces), but it depends on IP block configuration.
+	 */
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+		DMA_SLAVE_BUSWIDTH_16_BYTES,
+		DMA_SLAVE_BUSWIDTH_32_BYTES,
+		DMA_SLAVE_BUSWIDTH_64_BYTES,
+	};
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -1557,8 +1557,13 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
-	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
-	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
+	ret = dma_bus_width_set_many(dw->dma.src_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set_many(dw->dma.dst_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
 	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

-- 
2.56.0

