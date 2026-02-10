Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021136.outbound.protection.outlook.com [52.101.65.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3D34C818;
	Tue, 10 Feb 2026 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720853; cv=fail; b=GoIk4bMhY7khxLEFx2UBACzmL/C1vjviLRN5Wm0jej0YD6i5/Dg1CN2TaR6mrZ2F6chtFuvB2Nx4a4AUElddNlhCLgpiYYhC3HujTFa6wXpG0QqGcxc7f9GnHxQrWk//uLccG/OEDbM6WozYiyQp6gmr37gllrJVEov/GoOn76E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720853; c=relaxed/simple;
	bh=6Dba+/yGv1qyGlp/7Tro2iHZWgk9Jy4hi6xMPG17sRk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PKfI2S/4hLVLNnRECAavRddUS+HNAR8d6tMbvwhGqp2KSk7ikxZ0KyDNF+OdbkEewAZQ1C06cmeidXFWLQ6PwPwsczYpwFc+VHVcVFBmsFIUr/bbhN0H7/lJMTfUZMgw2p5QaswJp4/cZ0+9ohQgbtIfn0E9uDSWS7LRja/ht5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=pVEFnM4M; arc=fail smtp.client-ip=52.101.65.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="pVEFnM4M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+bIj1Al67Rfzejq9CCyDlvtOYQWAY2lSaKgn994bJ69hmr6eteWAACmND4SOFLciNC0Eo/FS+kGvrX3Ul+5iEFOBhMkr8jpyoms7YF7fu1deknzlgjMVgMcdwOU0yJKEEV9xXBRCYD3Bc8q+hUZtl4nFHeSOXZG2BAM3DPjlgtHJcP2mUYbv68j/zDxUwupijlQsvcXIEsmO+uXh6gYI3/2mqPTqXTvzan+kY7OW0fIMfRR2I9K7hC4ToCANp3+dMLhQsuKnS/QWTj9SFOnl6vDD3eF6+XIPbuZenjA7oD8OwwWfeDwT9mO70Yxkh6U3sj5yUk+70KJiEk0MzRK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm1w1EXIKYhGcBzqsur09C7IZmiaOJOeWWOVZsiPGrQ=;
 b=VqQcwemAhLuG2DT7pG27ekiMnZ9IP+vB1d5ZwQYvqWRZexWx8kHUH0hCk0xsCuHS2wagviwWc33MCjv0pwFLOy/LdCJkazVXnhff2ew9koTEAqG7ZfOm28YbMvMiQLeK/n0XZbL/MABl+co46qS7mWhVP+oGGwq3hRsLwpNRiV60kjgQdntGbsnPYc796CzCwStkn35/oLMGdXZ5PGnpfAEWyaZnRD8vN43YeJY1n+JpeDKlaN3AKP4MpKsNnLYM7ChoPvTqkiItxjIe2tBcEemQK9jCGCiTpNrzLFFt0yU15oJy9GGaNBb5p/kn8bdOmDgpDfyxl+IsWiTfqlZ3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm1w1EXIKYhGcBzqsur09C7IZmiaOJOeWWOVZsiPGrQ=;
 b=pVEFnM4M3MCDnqIqOxzwgt6GAP1wCpv5neZGhAwZXXERY/HMUzC6dpt5kh2wr6UoqcPo3Iw8EJn8OI+HhFwTn8vWybcN7vWvbC2yR3NnCxOlOWRbHyIL3/iQE8Hdigkud7o02B7fnfe7QohIZUiQah3ylD+UDPBLt0N6q+8ciOVdAIY2LjSAltfLjzmgH5ifZXA/e1uauz6/IZleKvGEDwudZVRMYcSCQQb40h+Nh2E0pQ/zBH1UCBzKhwK8UJUbfJXa4FbFogYLSAeG9X8GOPeynJ24YRktjEmwDGf5Dj27PlDuQI8K8A881lGUmE/eiCzMQg53zJjVU4LY3FEACw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10) by DU4PR06MB10173.eurprd06.prod.outlook.com
 (2603:10a6:10:621::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 10:54:00 +0000
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee]) by VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:54:00 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 10 Feb 2026 10:53:35 +0000
Subject: [PATCH v7 2/6] iio: adc: adi-axi-adc: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260210-b4-ad9467-optional-backend-v7-2-7a590ffe02df@vaisala.com>
References: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770720837; l=1563;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=6Dba+/yGv1qyGlp/7Tro2iHZWgk9Jy4hi6xMPG17sRk=;
 b=yPQzH/Px1nB547tE3BbVpaLfQSwJtbJvXz8m8i1xLsu1T2Sf5d61g1CcbSupMpMAuHV6HpX57
 6FjoaRouQR+CuhIjQtFHX9pWNGlz0GUVkQRdMtzkaYEiKqO4nt0LRCm
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR06MB10639:EE_|DU4PR06MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: f2649d29-9dc6-4432-6336-08de6892b25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHZBNzhOV0J0cmhCNXhUQ0M4QytJWjIwQTkwNmZ0N0Nlck16dTdreitBTXlu?=
 =?utf-8?B?K0QvbCsxUmZHT0tLck56elAwVytMamhTc3QzTXNpYXBEL2dkVGp3WmF0bjdU?=
 =?utf-8?B?WlRyekgxN0Z0eXRJSlVKNHVJODNnT1FVb2ZVdzdyaTA2bmhwQzdqRFJFRzc3?=
 =?utf-8?B?aUg1cDNLT096SUpjZ2gzcVF0MGtlTUJsTWltWmxVNDVwNVEvQ2pndkZrbGda?=
 =?utf-8?B?ekFUeGxBaVlBVDVIVjBQUm4wZ3Vya1VUa3dnZFJSKzB5dzV2ZGN5SlBId2NT?=
 =?utf-8?B?Q1dXMnFZTnNiQXJUeWowS1MvazkxN2ZEd2tMVUlQRExtVVNhS3hzYjZjMjNV?=
 =?utf-8?B?Q1doM2xURUN6aHdlRENaRkYvOGlCNDJDUTVrZG9GaFd2MjRVRHNGM01jbjJG?=
 =?utf-8?B?TXZiWlBSYUtmSHhvSnZtcXRRcVYzVjNsY0p2RGU0R3FUYkxVYVFDNk1ZNEli?=
 =?utf-8?B?emRHSGI5SHdac2dZeG1WVEw1WXpEMjhLVzJtNGZ6dDdGN0tzSWJkVGVwdm00?=
 =?utf-8?B?aDJ3bHlpWGtIR0FEU3NNY1FsQWF0aENyZzNoMTNvc09hL0dpb0RHUE1sZkxO?=
 =?utf-8?B?M3FHZmt0WnJzU1did1dUREI1MkFBLzdaK3paU1RUNmRpZGhqVWZqWHJKTVhk?=
 =?utf-8?B?eUxXU1BMeVVIUEVydDBqTlpoZEpxUG9nTlpPajVWMHdkR0dnMENFbGgxQnVM?=
 =?utf-8?B?Z2xEcVQrTGNwamlYTzRNbGt1K09tUFNKS1RORktMMzhlcnUzNHVEZ2hxMnNO?=
 =?utf-8?B?SWt6cGhhWlQ2WDVHVVdJVEFYQnVQdmo3Y1JYV25kRWI0TFUzcG85Y2RFQkVO?=
 =?utf-8?B?b2FXQ3RwUW5uOFJjNjVLVlFWOXAxaFJjWnZQa3AxZ2hUbERTeTl6bHo3d0V4?=
 =?utf-8?B?cnk1b3NSQ3RUNW9COGUzck9iUzJkb2dFcmt2TE5MWnhjbm4vc3E0dkw1US9i?=
 =?utf-8?B?UCtKeFZFNDNSdXAweWV1MnFrOE00bDRQYVVpWUhQV1ZmMFZuSmZweXlaZUo0?=
 =?utf-8?B?ZmVFekFnbzM2YXRma2VERUtuVnJiQktZZUdoejllSS9QbVRmSHo2dmhSU2dw?=
 =?utf-8?B?SHlKOHN2SzJJM3ZCWGJIMFpubUNONjlaNVZnZUdWZzc2RXFONFM4MHlnbDRu?=
 =?utf-8?B?d0ZGOVB6TjRvSm5nUnFPSFlIZHJMUTVUMVV0anlBa240UE1EVzAwZXRlZjNj?=
 =?utf-8?B?LzlYRnNmY20xWDlJTXNlMmVkYzcwcENiTXBWZDZ3UC9hV09ySmtkclM2cUFh?=
 =?utf-8?B?NFRpRFdma21yTllnd2tNeEF1Sy9PVUpRSGRwOVRJRXFmMVRuS2FFampkb0ty?=
 =?utf-8?B?L3N1ZDJTN29oNTFBR2FsbVdteE9TaFBZbXVJdUczMnhScmlCei9rWGhmYzR5?=
 =?utf-8?B?eG1oNDlTbnRrbDBZN2tRSWlpRFhUbmZXcHRqWEpucEJhTDBFQ2YyZGJUUUE5?=
 =?utf-8?B?MlJQeGtRb3V2Z2hiY01wWXRSVyt5UTFlTlBHRG9ERXJTR28zUmZ5LzRSQ1dL?=
 =?utf-8?B?czIxTmpJeStkSGZOcXdza3ZaYjJlVmlFZ2NLcmIxbjV3RDNqQ2ZpUGxndG1B?=
 =?utf-8?B?Ky8remJuQUdHQ0NIc3FDTUt3elFjOFlwN0VOWjdrQkhmOFFVNG5DQU5GVHM5?=
 =?utf-8?B?d0ErWWNxcDNDT2w0NldjbkVrWk05cnZOOU40dlR0RGZCS0RHY2VUeUw1U0dq?=
 =?utf-8?B?WU1TOE1NZmxiZE5QRE1MSTNEck83YUJPNVZWUXJMYlFWSUwrWlowNWtReHdM?=
 =?utf-8?B?L3lta0Y1VmRMVVRFRG50RWxGbzBBUG4wazRXSkljVFVpZ3ZobWxHOHhTS2FX?=
 =?utf-8?B?YW5DSURidjc1RnVLQlRrUEsyTlpPZGRHcFI4dE1lMWZqTlVsNDJpcW5acUtU?=
 =?utf-8?B?bkJJZ3lzczQ5VFlISTZKKzVFVERLNUVqbnhuZC90MmRsNlRCTTQxU3VRanUz?=
 =?utf-8?B?OGpFYUVCMWRUS0xQaHlEZ3p6VmRuaFJRanlwMXp3MFB3UGFlOGdIcytuYjBU?=
 =?utf-8?B?eDQ2dFZpQW9GZ203QUVlSmZkVUVnTU5OWGRsM0hKRERJZ0VKSU42LzZkVXpG?=
 =?utf-8?B?UnI0S055QmRhQ1hmTkJnczhpaFpYU2RTdmxsbkFNUTQ1eGt3M1JjQnZ1WDVl?=
 =?utf-8?Q?UxDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0hlWGlIMlZSWWZOdGNPOU1NR0Jjdi90MUljOU8yNVJOeDFVcmhUUkorQzZM?=
 =?utf-8?B?V2R6eG9sMkYzVGowSGFUM0dSekhyZUlDY3pzaVc3a0JkK3dIM1NhVXRRTTRl?=
 =?utf-8?B?alVicWx1c3VRKzFRU2FlRVRLY0VBMGxuWk5jY0ZNUWY2RTRpV0I1OU51QTY2?=
 =?utf-8?B?Ky9ycWtZaEp0T3lqZTkxUDRwT1Vsb0VrVUZaYXV2SFJjVFcxeUZFSnMwV1E2?=
 =?utf-8?B?ckpZcGE4ajZTZlRqcGVYWTBJTkNNTGFSN091ZnVVR1NkeVZSQ3BIUENIMkp0?=
 =?utf-8?B?cEFFdFlPcDR4S1gvSzJDN3NBV2svcUNNWTJVUjdZODBnVFBiMklreFJLakVD?=
 =?utf-8?B?WmRJbUJGRUliUXZtKzV2QWZVb0FCQ05JS1kxeDBpVTFGRnUzMTlMWHpreTJ2?=
 =?utf-8?B?YjBwR21aaUZFaUsxKzdzajZCcVJHaWR4NEFWbnowemEycm80R3dZVUlEOU9t?=
 =?utf-8?B?QU1HU0NsQjc3WnRXbUgvWWVCYjdQSU9lQWh4bW5jNEdsY0Q1Z2dSU2lybEcx?=
 =?utf-8?B?dDNXU0x0enV3eU4wTXZ4VVNleHZCT3pkcC9haUxhSkU2eTNRUFUzcUhwTE10?=
 =?utf-8?B?b0gzRldCWXZjbXFyZ0lKUlFjK0tyNlovR2hLMWU1azVJQjBnc1BiaFdhTnIy?=
 =?utf-8?B?Zk10WmQydGJhUmoxZWpOc2Q0WjYvUUpCdmFDQzdOczBWRHl2UE82b042dVZN?=
 =?utf-8?B?YVJRcU9yYUd6Ym01SnZtRC92R1dMOXJPYzVsUlF4QVdRTVJWZ0VzdHFwRkdq?=
 =?utf-8?B?YWdaR24zazZXbWVhbmIvMGQ3S1NtSDdieXNRZjVHSVlFTHl6T2g0UkhsMzFL?=
 =?utf-8?B?djlBTEpzVTNhTlJXQ0U2MFJKbHFTWWpmUWNTbXN6WGdyOCtrTEZNRkVKMUtn?=
 =?utf-8?B?U1JZR0dSa24wZkpaR1k5MnVqemRzN2ZqV2NwWWl5T2w4UEk0d3FmVk5qalQ5?=
 =?utf-8?B?YXlkWERpUGhSY0VYQ0FiekhzMzRNYWFFSTB6K2hhTzZPMEF4TEtpVnFiemU0?=
 =?utf-8?B?YWpib2x3bTZqMTZFSmd3WmVkYm1wcjRXQm5PUEVSZmw2VDB5S0QrMElKT3ZH?=
 =?utf-8?B?YTJ4d2JHOXc5TGhNa3N0WHBodXpocHVKQXFsUGNHWWJwd2RvbWZoalVzZGZU?=
 =?utf-8?B?Z1VHM3pqMjdJWVdkZHFPZHpVT1MvQzJwSmZuRG9VUXpnTGN5QjNOOWVLNk9P?=
 =?utf-8?B?Y0FlRWIwYlBKbzlsdXg0R3F4Mm94N1FCdnZmYVpaOXp4YjN5dmFUcGViQ2VP?=
 =?utf-8?B?UEpRVTRJbEtyd2pwWXBqaEQ4bXdTZmVRbHU0T2JZTSs2UEpENEgxNHVJZGRZ?=
 =?utf-8?B?ejNCRTZLMU04dUVzVGwzWGpmL2VneWNWdGtmd2I5dnU2cmRnOXhjRFhsbW9E?=
 =?utf-8?B?WkVlek5DVjhhQ2R1UHdYWnlhQnNLTU1WZjU3U01McGtkVmFMNTN1K2xLblNa?=
 =?utf-8?B?ZEVEaWhxZU45ekVpMnErdXgycmh4bDdCZVJZR0paemU4ZWZYZ2hoaGFsNzVO?=
 =?utf-8?B?TjlzVm5nRXBTbEJaMXJQTEtPdGVaRGd3bTlBZjNFeEsySUdMN01XZ3NEUFNQ?=
 =?utf-8?B?dGoyTFQvRHBKMEJiNFJERFgvdHJ2QkdJcUgwSVBQc1NjeEhIREVhNGxhNkdY?=
 =?utf-8?B?MjNENjZaTnRpb2ZBTlBtY2xNUSsvcGd5SWxDOFd4b0o0WElhTWtIaHJxUXF5?=
 =?utf-8?B?cWtvSitjN1pJNGpSUHFPd3ZtdHNNd2NRUGx6djBMSWIwQmlXb1NnRWQxazFO?=
 =?utf-8?B?QzhOSEZ2empGQlFOdnRtUzQyTnRPSEdQVXdaSzVNY3ByZGVoU3VyRHJOWUFE?=
 =?utf-8?B?SG8yNjR3Ylh2NkYrR3N1c3JNVWJ4L0NGdUFKaFlvdjJjdXFvek5OZEt0Wmxv?=
 =?utf-8?B?cExKMVNPdWlsT0cvWlZVdVhFNTgzMXNXU3dLbmdZVHdNL0hjMG5weG44UlhJ?=
 =?utf-8?B?d0RPdUFCMHVsT3JtSkI2M3R5QmZocE5lYnVSbVoxUmdaRnIwMUtjNG9wY0ND?=
 =?utf-8?B?MjJEbnZxcnljWHl1Z0Zjc0lnczMvQkx1a1ZoQXorNDhlL1NoRTJDT29UVG1m?=
 =?utf-8?B?a1NFNlY0YUxIU1VXaGxmbVBheVpLYVFMb1RlWG1ZRGhjbkNIN1hEc0NNQk0w?=
 =?utf-8?B?T1Nxdm03ZGNmVWptclF6TVlaN1o0eTYxOC9CdnY1RXgyaE5ZRTdndFZsTHdY?=
 =?utf-8?B?eUd5S2htZEpjeG51Uk5GeFdVRFc1VW13N1Fvdmhkb0ZweE5RQmNzNk94ME1J?=
 =?utf-8?B?R1l5L1hnQW5nKzNMelFnV3VQVWJwb0JEOVpzdk9QYUVWb2JZOTg5N3dBOVVD?=
 =?utf-8?B?L1U3d3l5SW9pUWM4ek54bmExYmd5UzllS2dHS2JyTTY5dnFMclVtOXhvMHhp?=
 =?utf-8?Q?Up9WROuLup0RWTnU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2649d29-9dc6-4432-6336-08de6892b25c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:54:00.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ahVl9cW3BpdJuhq5v9tyIF+Qb94DFNvuCTwJIm3OmkSEIvWL1CCPydVlt1MapYxZMVbFbzmjp7g9g9cDFWVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10173

axi-adc and axi-ad485x backend variants provide calibration support,
whereas the axi-ad408x does not. Set accordingly.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/adi-axi-adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 14fa4238c2b9..a27745695b7f 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -626,6 +626,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 static const struct iio_backend_info adi_axi_adc_generic = {
 	.name = "axi-adc",
 	.ops = &adi_axi_adc_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFER |
+		IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct iio_backend_ops adi_ad485x_ops = {
@@ -650,6 +652,8 @@ static const struct iio_backend_ops adi_ad485x_ops = {
 static const struct iio_backend_info axi_ad485x = {
 	.name = "axi-ad485x",
 	.ops = &adi_ad485x_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFER |
+		IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct iio_backend_ops adi_ad408x_ops = {
@@ -670,6 +674,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 static const struct iio_backend_info axi_ad408x = {
 	.name = "axi-ad408x",
 	.ops = &adi_ad408x_ops,
+	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
 static int adi_axi_adc_probe(struct platform_device *pdev)

-- 
2.47.3

