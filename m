Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8638AC78;
	Fri,  9 Oct 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561194; cv=fail; b=mBwMPCJHGmntsS8OhbbNPNcdI6c+U6moKSL80bcJAoS72T9VHb3Qp71kag7k/+X2U5MOLpnWFi9/tmTXwyfgny41FtvO9CLbOHcNDvET3URIRpg6v43TUqXEKlrMc4y2YRWCYR2sfpPf7yZSKg6cyE4eaPY92FyeNlfIoyeX+dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561194; c=relaxed/simple;
	bh=53zF5UbsM+jfi/rPcYipkiAJQYtt5gYnsR52IyZ0a24=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=p8CJL5+/uPGYs41LWmvJ04ReqCfKkGah0BaHWg/lMlWnEx3OyLvp5jKj7h0SmjO51YbHuKZw1GEJ/OOlox03ZK8IED7znelNzfxBJnpGeBZjUlFqAQ5hz92MrKuP9yfY2a9MhdaIC+zmI6ct9YgsTAH7o6+00C4MaknIuUOk8BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=D5Ut2IMM; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LLqLDBFi; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="D5Ut2IMM";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LLqLDBFi"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699FUjvJ2822101;
	Fri, 9 Oct 2026 11:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=Zak14qqVsNzea/dV
	1FqtWabUuWEEGjwFITyeerxFjTw=; b=D5Ut2IMMLxuLrMTQ+laon6gEXqPoDl6C
	9lQjJcLT+nXp+vSDt/kBD3wIHs33VwGsChYIYpUdemAI5ztvYEU2lDsitt4MZAcq
	BZEEjsuTuo8X/L+OzV9ea8QDQJk91o92c1645jcg6c23P6JszfQ7FY9NOEATksrM
	Se0s6vF+CdOC1vI2ApYqDYzetcpAs7Z2EsL39ual8djIMlJaNRWt5lcL8cBkQ1QD
	GzdRPw0BTxpun8305mGrteBVG7LutW3LcGhZGc/LMEsFMCw6HMJ9Djq0cOmLYCR2
	3X8T7BDeIhVcFCLRJqIUdIp277DiHU1bDV+0ObK0ziXHmc1UgSrXsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Zak14qqVsNzea/dV1FqtWabUuWE
	EGjwFITyeerxFjTw=; b=LLqLDBFi+T5fTEtfh+MAHV3OyUTdI3MO5dTGBceNMgH
	PFLIs/BG5+9joUYY7AJzchIUp0ctuGeghyEelSgMqG3hAPebC+QdgjhaGpKTP5n4
	P18gpx3Jqxqhn1M9CCM8zDlpmEuGEqIQcH2qQkCeOJngOFvDDF+BuIGqpl1/ZKcD
	FiNnlwM23fBYxA+lj/suvjD+L3Pf7/lOii+snMhna5b0ngv4LBYXAFxWkqpZPzFa
	CCaZa2Sy0KOuN8qPgH2Jb3rK/6QSoLiurI4n4LBwVGkmPyBYBN/tv1N2sV4URD3g
	Q6UJ9j7Uxk4/Zbt1rbN1TxIklFQEfAJUOS1c7oTz7cQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h6dvw79f4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:51:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1QUKnZSiltga+NNrN2rvmG+2rcLlDxUMdYK9eDbJHx3CA+Mwkgws7DoPVglIp9iQwrT1ixcG8lJGcfmK1Eze26t+YicjUEXFnLmXDSF2Sn97AFv/+m5/X4JO+apMjg1Iew+nKU1PpVIh5m38N/ANVlMMtkVyef2b4+O95pUN/iEqNxKVTIfoJAUbfc1VlkOwy8tf3iWAq+OSNWlguT355Ihihvftqfu/BvGQv0vG/8xiQ02/wG0ocm48f2Xgkf2+TcIBK/g41O9pep7+Hl3d0rR4WRp2n3iNXRU1GKRMHbl+EsgDcm2+JElzlVOU5MFOR0OJ5pWxJ3mV4oVBl1XQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zak14qqVsNzea/dV1FqtWabUuWEEGjwFITyeerxFjTw=;
 b=JpDNTfVmlxYQ5a0egRL3g9PHSh4tPkb9a4wCy8dE6vYsCB8tB7T+S0ewQgU3ZTO9EUDvn46ZCrM7RVQrAhVcd6syA3+6ueQv/sVecS9YGVOP+Pgz9MPUWMArZXwFsRmQurCqykD8rr7fmyHb2l1sqgsv/Heft/kCB+YqOYJgXHF7+lnxGEOYLiR/9Acp4+vrggq0dM2VSmHnQyH2/8zDckpQ7/x8hSTrNWkYHRyJbyJ0ObAEGf+6puLi8r3BmYBBdjU/8J/Kxa6WkFc9XtvmENC7FsLvhSJJhMSiRRpsgqGO2drCOw3pknMpB+LOalgjPEOzk9sz3iRHuAoW8+lzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:51:34 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:51:34 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v5 0/9] dmaengine: Support bus widths of 32 bytes and above
Date: Fri, 09 Oct 2026 16:52:52 +0100
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Oy27DIBAF0F+JWJeKh/GYrvofVRcYBoe2fggcJ
 1Xkfy+4qpIqGy/vaHTuvZKEMWAiL4cribiEFMYhB/V0IPZohg5pcDkTwUTNaq6o6w0OXRiQptM
 0jXGm5+AwljvtTfpMVBljuag0oACSnSmiD5et4+39N6dT+4F2LnD5OIY0j/F7G7Hw8vfXV+/oW
 zhl1BkhTeNsC6p+NYP5GrtnO/ZF3yiQbC8lQQrPvXbamnuqbF/EbV3Dd5Eik9xDC7pxTCr/QMo
 7UvI9pMykYuA0VLr2wj2Q1Y3UfBdZZRJE23hXWQsN/iPXdf0BB/HRLCkCAAA=
X-Change-ID: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
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
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=3617;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=53zF5UbsM+jfi/rPcYipkiAJQYtt5gYnsR52IyZ0a24=;
 b=uk0jd+6IOD+eeOJf2d5JmaT0ikChBf8jEH7Pjx6iMKA9Chmq6NEkpYV5TQBBqX6lSHF1EgMq1
 wF5Q34CGTw4AraUU4OzMV/t89X7UJxI/xMazl4INkYk7KPAveX3p+sU
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0043.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: fd873bf4-4fcf-41c3-f60f-08df261d31f1
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 b0DoLD9uuwKFXdhPnt1AvH/hJvPEYzcLVyKfKfE2zoerep3NmvjMUJ2g/n/erFYdOp7jCG16MdsjWbeMRRNv59JMeEIjM9NixmiAz3XxdgwmNBI2Sx8T6pe6kH1mOou0XFyuogMI8oUI9ULq89yDj/e3F7UQ8VWOQ+wXMooJTAsX/s+Vtb611i0Zs/COV1egLMmPl7VQG/rqiSsgQbCfmp8YiWytJsgXIzi1n55CTHe6GOY5FsLItgyoKNNDl8Hx28n4rsuLUZ20+UWVcN9U5oB/fpJDWc6dFc8Iz4iTINo/1eMOgImoFSiJsncyYJlJodC6vk+26s1Zf+O45a7wfJ8lmrQ2qetODB1YU0enCYwKVbAsD5MSP0+7Y8Ldx90g/Vgy4LrMj/0TtZ6XW19kRzk1j+NwrZG3AdaYBSQOrbo8X9y9Vf11BbFYc9ERHPoYI2ujAwdOuj2/dlCqh355TbsuT30YyKp76b3LpUXbqNOO+njj6HPAzsQl7TdO0PkQLIdbDueDbQQ0ll2cfvBfCZTlI9hAOMvAl1s+wyLGgXdhTWeX4wMgamMGPiIs18D9JKR6d8dAMbnx98s7Q1Rain97r/wV9rHg1LiZ0qlW9VnZTr2nlEcRlckz9ZiQcrAq
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?enZudWRWOURsWTgxbC9yMG9iUThvR3h1K3pmMDZQNVp5QlpwbzVmQm5aNVlQ?=
 =?utf-8?B?MU5XNUZ1MWQ0R3p0R1UxMTZDTEtBcDB3S3FkSTNtQjUzQWN2Q3E3cU9FWWlu?=
 =?utf-8?B?WnZMTWVQd3pvZkVHMDBCdU93ajJRSG13Wm5DTjNKNXV4QU9UZDU5QkNSenZw?=
 =?utf-8?B?ZWtpVGJRZDA4TnZYdXRrTXFTc0dyWU4vcm84WGd4dHpDVEtpQTQ4bHBpaStL?=
 =?utf-8?B?NTFiSXRJdnRPVUVaWnBMTWxnUTZSNDJLNGRRSHk3V1FXMFMyazZvRG54UGVO?=
 =?utf-8?B?ZE5RcjVEQlFleUVVcVJvN1g5ckVNTjV0Q00zcVhvbkZiWDRPSENNeUZyZUlX?=
 =?utf-8?B?STgwTUdON3QrVFNWNkhuaE1BU0VKem1RL1VNSWhvQm5uUit1TktROHNtbGR2?=
 =?utf-8?B?bUlweXZFKzNHWEZONFozalV1STZ4QTJsMjJ2N016OE9YaTlISVpDVHNFY2Uz?=
 =?utf-8?B?RVdla3ErSFRlSGNpb3JuTzBGZFRaZVZRUFRMekpza0FUdTFxZ3Fkb3BXcm02?=
 =?utf-8?B?N2ZYUEtLbDh0SzFBN1Q1a29adjcrN2syNEdyRmxIaGxocFZSUDZrQlJ3aHZW?=
 =?utf-8?B?RVByTVpsY3dPbzQzdW0xcVZVT1hVOXp6TDFNemZ5aFB6MnN1N1FTNFF5QUtT?=
 =?utf-8?B?Zmo1cVVhbHBCR01IK1FtRkxtUG9aN3BydW5aKzI3WFp1QXRlbHg5UXZYdTN5?=
 =?utf-8?B?RDZuOVV2dFFyQ3l4bHhIZVIwOG12b2lyQU10eHh4ak9zTmFDanpNMHFMUE9x?=
 =?utf-8?B?VFdPMkdrRjVBMEk3eFJSYUk1NzZ0cVlIUHFvMkxaN2Y2eGpVcGVvYXVhYkZw?=
 =?utf-8?B?RVZWcC9kS0dkY0FUVS9LYm9tZzcrY2QxS0dMRGRFUzVmdFI4Q3AzN2hWVjJp?=
 =?utf-8?B?TkJZRUY1dUxocEZiaFhhdm1kS0llSDJlUVNKa3hBN2k2UTgvYmFRUk9rTDdm?=
 =?utf-8?B?NnNzNEZadnkvOEFPUE1BSUNoQzVUMnZDK3BDTnRuR1ZHZi9NeDZvbVdUYlBX?=
 =?utf-8?B?b2JMdTNvVkxjQVlMNjdSaFFJVUtGa2VpR3cxTGpkVFZFNVpnK1BjZkhpbHNi?=
 =?utf-8?B?bkVzOUxYUDZaS1dPOGl2ZnVBV1BoenhzeUd0Y2JaanFvVGFkSXdTK2dKRzdp?=
 =?utf-8?B?blJ0QUpGYnhQSmdEeFNjanVoQmhFOGRnRERodFRvOHVSSlBFODF0dVA0ekIr?=
 =?utf-8?B?eUdxVU9YV0t3NTMrZlJxZlhraXd4SUJ4VTBVRG9BbFRzSzlTYVlqbzhLWWpw?=
 =?utf-8?B?MjN3M1RhN0o5QkRncjYzT3FqeFNtRXdYY2lQaW5HRUtTMlBFeWxFOWVtbmMx?=
 =?utf-8?B?ZUNla2dtaTNBODZLVE5aUmkwRlNQb1JrSG9Rb3p4UVhDdFlmUnBoL3NhM3JL?=
 =?utf-8?B?TzVTeUk4c1ZPa241Vnh5eGJZaGVXNjlLWTE2Zkl6R0xGL3ByMkpLK2dYNWhh?=
 =?utf-8?B?ZkNKZHNOYUFlc3hwV2dkZGJnYkFhYXhIQzg2WXdteTNxMDAzc0IxTjBobVBx?=
 =?utf-8?B?N2RINGFHOUlqMWJzM0NySkp4dUtWeXJCUll2akR6bkJrY0xnZ1VycGpSUnhy?=
 =?utf-8?B?MEFGUjdJNE8rckJ6SnBEdWNYanc5cVhqem96cUJHenFER29jTzg0cDJQYTFr?=
 =?utf-8?B?b0V6dGVpSzNnY3J3RmNNTklrRS9sUHRjRW1xYTUwL3VFSks0ZmNiejM1UDQ1?=
 =?utf-8?B?OVVSOFNkS3N5UlVwUmFsUkltMTBMcW5KV3FZMjZrcmVWNUsvOFpSL01GQ3Vs?=
 =?utf-8?B?SUtmZ1g0QjBURGhTYjVrTHlTZlNGbWs2QU01V3ozTGFIekxOSjhjUDFyS1lq?=
 =?utf-8?B?UjRJdlpabnBDMnBSMzlCdklzS3VVT3Y5K1BwbHYwNzM2US9wTHp2eHorQ0ZH?=
 =?utf-8?B?WGxzMFQza2poMFhHU3N4dTl6eVYrdW5IcmlOUWc3UEdSYW02NnRIR0ZseWZj?=
 =?utf-8?B?YnVRV2loVW55K0p0U2s0S0diZXFlNWJKWStNZThpOVpaSWFERFRqNVgyQWdF?=
 =?utf-8?B?RjBOdmg3aVBFUk90SDY0R2lubUVoQThTc3ppd3JQRk4wY3lRYW9FNTFkNHh0?=
 =?utf-8?B?NVIySkhmUkdLRmMwZS9DR3pGWnp2U3B6VWJTejNLYUhsTC9FOXA3aE02OG81?=
 =?utf-8?B?SEpudkxHZHZpOWg4S1VaeWlrZFhQN2p5eURSNVMvQWdHRFdzemRvV0VodXVV?=
 =?utf-8?B?N050QlhyUTVpeWZnVStmSzlUNlVPcHlSV3FwdkZzSUpQMk14R0ZWbEJhZ3Jq?=
 =?utf-8?B?TTFOaGVPNXp6REdFMThIeG90YkgwZWJmNk43MXhrWWtEVWV6NW1KQ0JoM2pa?=
 =?utf-8?B?THBtTDJTa2I2Y3RrOVNZNmxwNGVZUWsrYkhUYnkxVUlMWFRpQ3EyZz09?=
X-Exchange-RoutingPolicyChecked:
	zRBe6xaPOhziWLQVx7LibZFt5ji/yFgJMXtQxHKZxKwig/5vhFVTrvVqI+ftylS3d6RrZxjmXkgrZkmk5cf6zouPTUjwVM2xMJ96zPhetcDm3Z9UeeNw8Hy6OlMV9+gu0vdtHbI77ElWMxy86HGyEM8Xm9qM3opviUgEWqht4XdrXtjc8CXSbSGipCDv5lkk5HPy1Vi8U0pVh970Jn2ae0AmoN2aFmYIMff+Mv+clWtuJQ9VqK3pSTuNMlYnwxItlUkpZ2MsLXsGY+T0wVMZwIGnI0AznOJJYcFw8nf4/1UiYxBgAjYBZkHIwHCXuud3AGjHQUeufQIGgvN7vX6QBw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd873bf4-4fcf-41c3-f60f-08df261d31f1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:51:34.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKNNsWPXSx5+sEU6yLV8w0j1VtmlkoF8nq6rgzJJGJp5SpVaHDV8Rs2g44TJqSWqU5G7PWGwcSUIj0h995h9Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXw2IOKFyDuVOW
 oVkAGV8iT6Uexd4+JLxx/nXVyX/QzOa/lzXP5A1idnaQhmkaY/hLjIOkMfJUABPQY2Ql1RuD98a
 jfNZajZKo1fHsx3tdEqeaM47PuON95Yi6He7Y1CPwsWnw8yHaFJS
X-Authority-Analysis: v=2.4 cv=LcKpeTfi c=1 sm=1 tr=0 ts=6ac90d89 cx=c_pps
 a=IxQEmK7OG+ZB3KQxmUR4Jg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=LA5vrRYEtGaYHk84EFoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX4haLWqU849P0
 pj2M8fZKXwvN0VZ/7UbvqQSEeof81yKJkbjc1um0qJo2mTNsFk5XJ34HVJgU59tMkgCUJ2IBExf
 YlF0t383KU5tE7gTxXcdADClnZOV/QXOTtbjNjLr6jV8UtCmn6rQPmjx+Pdt8ZK6V13gytqSF51
 ljmtUjMbwjSHqZZniTVRNF2MhtTANvxjewquWK4pVEb6805WPK0ALf3SfbTqeYzclAM/8f0lZoe
 e8dkEHvQQnzDxpWKBTIpexg9stqqm+lmufkLc97DYsWvDpQ27/ARZQIelx5aNWtUPIypW5ZLzvJ
 1aDqtOd+0Ygjp87CzdT+d3/zFNTl6FkR6AE08GnNNpoUBjURRLMN1nIC1c1c8oOiKrDmGa0tYvX
 9aPx27hP6H5K2ctSLQXnbNHiPMmHP+57lv2sIoFMEy9nSONZT7IPkG2Kdj4KJLlcCPsccODpsdF
 ZES+XSZyRgUU66JSEXg==
X-Proofpoint-ORIG-GUID: wF63ZV2Dnee5NdebqGCo6Ht_DOlhYqd-
X-Proofpoint-GUID: wF63ZV2Dnee5NdebqGCo6Ht_DOlhYqd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090063

The DMA engine slave capabilities advertise the supported source and
destination bus widths through src_addr_widths / dst_addr_widths. These
are plain u32 bitmasks where a set bit's position equals the
corresponding enum dma_slave_buswidth value, e.g.
DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.

The consequence is that widths of 32 bytes and above cannot be
represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
32, 64 and 128, which do not fit in a u32. Hardware with wider data
paths is becoming common, so add a representation that can express these
widths while still using enum dma_slave_buswidth.

This series switches consumers and a small set of producers to the new
bus width capabilities, represented by a dma_buswidth_mask_t modeled
after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
so the remaining DMA controller drivers can be converted incrementally:
dma_async_device_register() folds a legacy-only producer's u32 into the
mask, so consumers only ever have to look at the mask.

Once the remaining producers are converted, the legacy dma_device
src/dst_addr_widths fields can be removed as a final cleanup.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

Changes in v5:
- Drop the "Move enum dma_slave_buswidth to a new header" patch and the
  include/linux/dma/engine/{types,widthmask}.h split. The bus width
  type and helpers now live in linux/dmaengine.h, next to
  enum dma_slave_buswidth, as both consumers and providers use them
  (Vinod, Frank).
- Patch 1:
  - Move dma_buswidth_mask_t and the bus width helpers into
    linux/dmaengine.h and drop the linux/bitops.h include.
  - Document that dma_bus_width_set{,_many}() add to the mask, like
    __set_bit(), so the caller initializes it (Andy).
  - Drop Andy's Acked-by given the header rework.
- Patch 2-8:
  - Drop the linux/dma/engine/widthmask.h include.
- Patch 8:
  - Include linux/dmaengine.h in spi-dw.h instead of
    linux/dma/engine/types.h.
- Link to v4: https://patch.msgid.link/20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com

---
Nuno Sá (9):
      dmaengine: Support bus widths of 32 bytes and above
      dmaengine: dma-axi-dmac: Use bus width capability helpers
      dmaengine: dw-axi-dmac: Use bus width capability helpers
      dmaengine: qcom: gpi: Use bus width capability helpers
      dmaengine: stm32-dma3: Use bus width capability helpers
      iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
      ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
      spi: dw: Use dma_slave_caps bus width helpers
      dmaengine: Drop legacy bus width fields from dma_slave_caps

 drivers/dma/dma-axi-dmac.c                         |  13 +-
 drivers/dma/dmaengine.c                            |  24 ++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  37 ++--
 drivers/dma/qcom/gpi.c                             |  11 +-
 drivers/dma/stm32/stm32-dma3.c                     |  33 ++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
 drivers/spi/spi-dw-dma.c                           |   7 +-
 drivers/spi/spi-dw.h                               |   3 +-
 include/linux/dmaengine.h                          | 199 +++++++++++++++++++--
 sound/core/pcm_dmaengine.c                         |  20 ++-
 10 files changed, 295 insertions(+), 67 deletions(-)
---
base-commit: 511afae96d89847f753fcab6b3a597f0281be9d5
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá

