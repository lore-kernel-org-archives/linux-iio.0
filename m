Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821341C309;
	Wed, 21 Jan 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997346; cv=fail; b=E8qqjhTBlFSi//Qmh23cHDhDcS+PkS/d0raZuw3bLSpMRDHD+iYNdfyyD3PLQ9fqLgSLTbb1PAzml0ADUgYsaSnDHUOQWvQlxPUfuQaLu0Pio7tq26XpFpPZuCjhqqM4oPgRTSC3WwICfjqFWBjX7pJe/SXhM5PlADeOitCHLRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997346; c=relaxed/simple;
	bh=y+oY3W41VdH/ir1dDuba72M2P53ti/KQMS05e7INjCk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jwz4A4yPA4EuEXUbxJdwPhrA1lS2GI1Uc+M4N2xyJHKun6GgH7k/7acXBBEYscKaExTPlZOMnsI0rUl8NH1jAfVqJ3DjO+crQp1Mufp6b40aDt2/eGkRh//w5fHJDPumiUe3uyJiV//qyS+R08oEgjKTasVumJaKGVTKPvqdo2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Wl9qUFF8; arc=fail smtp.client-ip=52.101.70.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Wl9qUFF8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzcRbuHMCESdMIVe2gKSDJlmvj08ehz46Pq5EIHsX7KwE6hySor1jpRa9AjvnHl4JZdeRYOr0yVoCHwsAtXWzbXOAXdG/QqEy2qrwhkB/WN5XstlO9iCqMiUpVyvhwWtcy1tI7Q3sRaa6K29bq48WxkADSl6x61aZ9bJnM1OCAoz6OfI94wZR/XnZuTlyzaYPCZ3J/uLTIKuqCQCKBIMIft2NacvHAZJthx3mPMCiAqhOPGIQvkbx1WemXLVO8eJmrtvm7eMkQ3SgHX8OQnfES2d0oNKdN5dTkg1FKt7jEhr2WtX4epu0M+YK3WCODJFXB1Wu8t4HU/EBqUC3Ua+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bC4ZfCcyh/k2zvC9/ktkDPD0Bd8yjcrCc7YI55sv/U=;
 b=I7S7U2BVp1pxL6PgFg7DbqNAn5XkzvJFkYnU/9M0x4b6+Qhyzra8c8BbsenkVKQYsM5MSybfrr8tWemA12jabN135cI0VhhMO5cvimf6lEI0T60/A6R2zNPrezZ4lONhRBD+nvKWP/zLfjMe2lNhO+nXwrofG4SPNyYMm3iiPvytr/ig4fC4haf4pGmWjX2MX2mcAyrrWG2XmEIifznZs7OvkqB57aFTkUR77hkiLKI+VkB0Sb9lBbww2giGCQp0ZJmoYISEP43bbr+3fuxZ/F42C19U+C2+LXUzagKyFOPqNhAhFzNOjxJ48UCpqzZZRq3u9GIVdkOCSqH1AzPHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bC4ZfCcyh/k2zvC9/ktkDPD0Bd8yjcrCc7YI55sv/U=;
 b=Wl9qUFF8MV/eOVZ19m2qUXrc8G9Y40vNt7X1/H6zTrBUPGEJ8vdo733rHPhjKRYDpEamYnjzavHnFyEb3Lw/XtjzQ/opzXhrKXXj8e3dmBymentRReMdINE4x4ZtjtBaXXWt3IxBKZhYhOel424VazJoWdwgp7tLrpxS3vOHLCq/ygLLrzJasdxfa1jFiY3zl6cAfebTt6TWsMtZxgG7reRIbfbvTWL8cJtZmwWhdPcQGk3OEZTUxq2P/7O9pGbrnqlnHh+J0IXhIoAm92MSqeiSr55oGI5w11tBsTha4NR60FtbUNBZZ9ci2RZTjX3I3CYWFpceQflNfcriVu1Ysg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV1PR06MB9495.eurprd06.prod.outlook.com (2603:10a6:150:1a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:08:51 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:08:51 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 21 Jan 2026 12:08:31 +0000
Subject: [PATCH v4 2/4] iio: adc: adi-axi-adc: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-ad9467-optional-backend-v4-2-18d2c0d450cc@vaisala.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768997329; l=1447;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=y+oY3W41VdH/ir1dDuba72M2P53ti/KQMS05e7INjCk=;
 b=I1155ajYza9abuv40KydWEhP4+/AJGgfJOVxqEzn+N7Hbqk+rrJV07JiQYAZ1GCyEoxrXVB2h
 FZ/gTpizj+mCpFaK0EmP3piHVSoDWeKY8XVRkMFqWtJe5McVPgRdZd6
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E69.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::37) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV1PR06MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 014c77d4-a1df-4714-f7aa-08de58e5d70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHdSQlB4VWNCdlNlYjZqNDRwcVZmZ0V1NnVncE5Nb0pjL3VYNHdxaEd5ZGtM?=
 =?utf-8?B?N0JWRlJOQlg1L3lLaFVUSVg3My9sengwWUszYi9UbUJBVjZWRzVtZGNJQzY0?=
 =?utf-8?B?V1FyTHBtbDJRRE1yZVExcGY0b0tNQlFXRURycWU2OGRZTmpjQyt4UFAyNnFV?=
 =?utf-8?B?TC9yTDNscHpaTXk3alVhTjJ5ZXJMVHo4NHVaZnhqRTNXbWUrdG9VeFMwaCtm?=
 =?utf-8?B?NUoxTXJ0cDNzRGcwRGcydmI3MlFXanhWNk5nNDFxck1IR3crblk0S2NUZGdH?=
 =?utf-8?B?dVdycjc3TW12MUV2MVlmTnF4QXpEdmhTV1FQMllkSVltWm5HNUpub2hUZG5r?=
 =?utf-8?B?NDhMTU9ETGFNVHZGRkRaQkVUbmg0OWtDMCtlODZ6M3EzbGhQNkJrWWNSQXZ5?=
 =?utf-8?B?S3RoRTRNRkJ4dnlCNytJYWt1VVAxS3ZycW0zR1UrNGt6OGtkc1RWZ2YrU2J6?=
 =?utf-8?B?MEIyaUorblpjcUVvT1VLMWhWNGdsb3phRmExRlRXMmE1dElFcGpRQk9uUHU0?=
 =?utf-8?B?bTNtVnhyazBSVXhQR3h2SGUxS2JHeHRXWWIzSCs0dGorRGN0YW5GZ2h5Q0ZU?=
 =?utf-8?B?SnhWT2E2VXZCbUFkZzBaZUdteXhyY0Z4VlBQSzEwR3FmRjRmQjZTK3NlMFFM?=
 =?utf-8?B?b3FYMGZNaXFBK09KbklmQ0hPaEF2TTB1ZHkyNGFFRFZ6WXRoZ0NRSE41Qy9K?=
 =?utf-8?B?czJHWWRJK08rMWpVdnFUT3dmZnBLeTV6SWtLZEllaE1pdUMvZDc2QzUxYldG?=
 =?utf-8?B?eW1odWZsZC9xeVNTUHJuS0ZsN0FkQlM2NFJEZzZDN0ppeFJlejJqdjl3dHV6?=
 =?utf-8?B?dTNpclpyRG0rMnZ4VERlcjdMN1dOWm8vSWZWdStheGtIaUFRaExUU2lzUDdH?=
 =?utf-8?B?R05RZWp0V2FNYU5HODZkeEJ5Tzh0MlB5azdCcjlmeUFRUklLM2tCaXFPUHk5?=
 =?utf-8?B?RmpWbWZoaDJsdWNpNjgySHFyUDFuaStGdk84NEp2cEMwbk15MEhJQmJRTm9t?=
 =?utf-8?B?TVE4eU1heGl6c1dldGZ5RC9ibTRxTlVvSllsdVczQVV4QUtJWHkvRVNrek94?=
 =?utf-8?B?VThod2VnOEpXTTlHZWlQQU1qZzBzTktLMnJaSXYrL2NtUnFvc1VjU1lNMmVl?=
 =?utf-8?B?Y3RFWGpZcjZzYzFQWVlzbkl3L3ZRcE9ENWY4dXZQU0huclpyam5pZE5RdDRx?=
 =?utf-8?B?bmU1WXByOHcyMmNkVTVKVEJISmxvQnF4THhMazJJMVZVZkpoNW5scjk3TnB2?=
 =?utf-8?B?a1lDTUJYZ1dWQmdLSHhHMVd3VzUzYzB1aVg5a3d6WkM0RGtIWmNuRlRlYjBV?=
 =?utf-8?B?b2lEU1JrMEh1M3YvdWFTaEg0a2JHVW1ldkxVN3dnZWhvd0RVTDdTYWtkMHlL?=
 =?utf-8?B?bjVoM3FvbHVhd0p5UERsbEF1bUtiRStSNkVvV3NodWx3QVRnTVZJZkhFVk56?=
 =?utf-8?B?bnp1K3VubE1jaVJhdUNjbjRGWUNtdTJCUDdGejZpU3FwRCtCUEJ5YTRRMElo?=
 =?utf-8?B?Mjk5QytlblRQUTJsVjB3LzBxVkFiSGV4RDdhc29SZk1BQUhQRHhLd0xhNndp?=
 =?utf-8?B?ZVU4RDFhYTBsSFFHc2tJT0NWMVFOTGZmRWhIclJrbmljcm5zWm9MTUVWRSsv?=
 =?utf-8?B?aGt5L1hvaW9jYjJHelQzNkd2MW52YXArWGpUZFVSbDJyOUVkYXFIUUdQQU9J?=
 =?utf-8?B?cUtxOU1QS2dJVXg5M2pDMklBNkZoUGx5Nm5oQnVmdmNoeUNuTzY5am5udFZw?=
 =?utf-8?B?OHpjR1lONE1rS041RlZKVHJzMzJoUjVQR2NkSEN3aE5KY3FUcnpNYk9GZWpm?=
 =?utf-8?B?SVlXcDNBN21lMnpkc3VxZnNHNXRTZFR5VFdRbGN1aHZhY1M1NlBBY2tkTzZG?=
 =?utf-8?B?ZWJHWXR3ZHdSWGR0ZGt0WGdTK010SmRQT09MeU04REplOGxhL3lCbmljbmM4?=
 =?utf-8?B?Uy9zUjBOTDNFUDJYSFQrZFFhWFdla3hTTTVkdlNRUjh4eDVDeVQxM0w3bnFu?=
 =?utf-8?B?a1lRYml6VGlJaG1wU0dsYkthbEk2Y0Y5VlNDazBzQWpqSU1kQUp6VExFVFov?=
 =?utf-8?B?YVlDOExsL1MzdWxYMFl4STdoNHA0TVpacTZVazBQZkpGdzhZR1M0K2h4NE5n?=
 =?utf-8?B?VlByblYwbzErTHVxc3IrTVBoL3VVSGNMdGZ6WXdWT2ZaWUJHUWJpRytma2Nm?=
 =?utf-8?Q?oEuTzG6NXIRql11xhPB+NbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXNYNWRpUjJpUWt1VHBZSHUyZE5KREpsTnFuYk5yek5WY0YrUjBJZUtzVzFF?=
 =?utf-8?B?SjB4WkkwUTcxMjI0WktPN2NEazFPUkVUYzQvWVoreDAxRmVnUzRzaE45Si9w?=
 =?utf-8?B?OEJoYzNob1ZlODV3Y3JianlvcTRqSnBiU0NxUE55WWxzVmRLKzQxWUduQjRw?=
 =?utf-8?B?clJ4Z0hUMEE1anNFR1dBS3ViWndJTHRvSkVJdkV6MnlPbmtLdXhySGIraVJE?=
 =?utf-8?B?QVhpOGJBSlVSeXdqcWdpSGwxaHdNbm95U1BpNWVOV2tLTDlFaUJzdThOQVhS?=
 =?utf-8?B?RmM0MndZRko1SjlENmVwQ2t6RXBjTWNZNS9UVTk3MnVQcTY3dE9uTkhjdWpv?=
 =?utf-8?B?WUVMaFNlcFN5N1N3ZnNNWC94K2xrRFVIZjZyWW9kSmEvcjNGbnRlamdMeE9Q?=
 =?utf-8?B?eU5aYlZnTjhlS1haVlpSaVBXOEJGcStDL3VoSW1WbTlSVXdzQmlFT1luaVFD?=
 =?utf-8?B?amc4QURkZnhaUFVCSkE3MGtLZDRNNGhXaGZCZEtscTM5N1pJNW41MVQ4VDNw?=
 =?utf-8?B?dTE5aEZpMitmYStIbDNGQW5VT241djlZd0UwWDNkRDArb0pXdHJ4RHFXTytk?=
 =?utf-8?B?MnVWQUNObXM3UHd2dnRjSHA1bVRqdjRGTHBaV2ljYW4yM0xtdUIzeVF6UmdW?=
 =?utf-8?B?V0dLMnFqN3crczZPb1NsZDZEQUFJcVJlQ2x6WVl6bURySk1ndjc4K013VFFE?=
 =?utf-8?B?SjFPejltNDBUaHJ5dVVNY2tobFl4RjVQK2NCWU0zeDhsM3g3aDFGbS9ueVVI?=
 =?utf-8?B?ZDhRNGd4Q1ZWSWdZK2Q1Yy9ubWZwYUt4eURtcDBBSnpvVngwUGtNVnR5dHhX?=
 =?utf-8?B?OUZ0N3FCZ3g1Vmx1amZSMXM3NDIwVEoydTRmenBQMktZYW5LQzZsNi92b2dp?=
 =?utf-8?B?TWYva3pQVXRCV3FzNVBOZlF5elQ1Qm9VSk5DWmZKY1VBZW5hdThuSXFoYkxH?=
 =?utf-8?B?SjFab2xnQ0crL2R2Q3ppUFRWOHlLc1E5RTlCVVpNbytoeHZJakluRHhicTVJ?=
 =?utf-8?B?ZG1aUmdyUGRIcWpKWlJ1aXdvYXU1UjhkamQ1bXlCVTZkREg1d20vMU95SVc1?=
 =?utf-8?B?OXZubHZsV01hNUZJcHZzOEFCRWN0alNFeTRUbTMvanROdEh3YlpTeFhja2xV?=
 =?utf-8?B?ZWkwUXNEekh1WFNqSkJxQ1djdDl6YmlKT3R3dHhnbkdBOHZJRnprL1R0UDRz?=
 =?utf-8?B?ckNVZDRNYW1OTFZNQ29jZnBNOUNST0RjcFdaejAvTUxzcHluUXRxem1yQ044?=
 =?utf-8?B?SXZoZmJjamsyRXZIRlI3WStaNExBTms3K1NGcmFhaFNpcDdTU1VjeEw1NVJy?=
 =?utf-8?B?MWdMQ01HTzFUMHBPMy8zd3VRR1AwcEZHR0ltOGtadEw3Z2h0NnlIVUI4VmF1?=
 =?utf-8?B?T1VTZlFQeENwdS9UR1V0ZzBiR3lzRGpRWFR0S2V1WVA3ckNMVndPYzBsRVk2?=
 =?utf-8?B?cGtGNW9MWmZ5QWZvMm9FeFBhd05QQnFHQ2FJWGY3MThDVkw1WHlMV1hjK1Uw?=
 =?utf-8?B?RzBtYjJzczR4Y1NER3UvR25WT2NOOFI1KzdzSlVzaFJGSzZ0VDhMdFRGcHp5?=
 =?utf-8?B?Z3RRT3JMbDM1NGpZZjZHU2U1SGZ1emNmVGhXdDBBVHVXSDdCTXdqVFNycjFx?=
 =?utf-8?B?QlpySHVXR1VkbWtqRGxoOWE2KzdmN21od1dobHYxK2xDeElyWjlpUDQ5RDBj?=
 =?utf-8?B?c2EzNWYrWVZUSjZqdXhWUnlnYlVOMytHU1JOVkpHdkRjMktZSzhOM2dRRFo5?=
 =?utf-8?B?T2RLaVFrSFZNUlZwWlBWbHRWZ0k4dHNBYkp6aklReElHMHRnNE1leStxaG45?=
 =?utf-8?B?dVJxQWFodHlFekVtYjJHWXpnTWpSWnlNUUV1cGcyV3NKUzdkSzNzNU5RWDNG?=
 =?utf-8?B?ZjRnTk9FTVVaditiVmQybmhTeVYwZnJqdVh4dHpDZVdSeVVUNHdSdU5mY0pI?=
 =?utf-8?B?OW9KY1BjaWw4ck91clVQT2J3czhVeUpBOVJUT0RnSVJpQjkwY1VFWTRBZmR5?=
 =?utf-8?B?NmpDRmh1MlhrdGJWRlRPZXhVUGxMYXpCWEhQS0ZjLzBFalNlb3BqOUs5cmxu?=
 =?utf-8?B?bkZjSnB5RnhDMDE1MzJVVFE4cEZOaDQ4V1E1OVRsc1gyZXFwSWl3SHVieWor?=
 =?utf-8?B?YlluUlR4ZmJWZXlUdzRaZ3FZeDM0bXJmWXRNMXllNFBWeGdTcVVkTTZJTysv?=
 =?utf-8?B?Mkg0anF1RFZ5Tk9YdDBobWpSOFdQeld1VkxhM3B3RmQ2UHZDckgva0tkRGtn?=
 =?utf-8?B?b2c2UXFDRjNPWmlSbEJDVzNGWlhINURuK1dqSUpVQzlaZzJMdHIyK1VvNm92?=
 =?utf-8?B?VllLY1ZlSHNLWE9Da0JwK25xdnlSOUpDdXFZQlIydTVVOGpvU1ZvUEY2TjhS?=
 =?utf-8?Q?sRUpKOTpQoGxUvlM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014c77d4-a1df-4714-f7aa-08de58e5d70b
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:08:51.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx/Zhf6RIcphsJ4zN3vMlN0SJ1msBBr3z2ZvDfOnIj/JecowWLPzp5wEU7jLiQAcvypYRElMaUUxABFrx2461Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9495

axi-adc and axi-ad485x backend variants provide calibration support,
whereas the axi-ad408x does not. Set accordingly.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/adi-axi-adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 14fa4238c2b96b1ac722d537bc49ed4ca8e36925..133aa6f43a3854e8365ac1ad26331ccf9caa7873 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -626,6 +626,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 static const struct iio_backend_info adi_axi_adc_generic = {
 	.name = "axi-adc",
 	.ops = &adi_axi_adc_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFERING,
 };
 
 static const struct iio_backend_ops adi_ad485x_ops = {
@@ -650,6 +651,7 @@ static const struct iio_backend_ops adi_ad485x_ops = {
 static const struct iio_backend_info axi_ad485x = {
 	.name = "axi-ad485x",
 	.ops = &adi_ad485x_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFERING,
 };
 
 static const struct iio_backend_ops adi_ad408x_ops = {
@@ -670,6 +672,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 static const struct iio_backend_info axi_ad408x = {
 	.name = "axi-ad408x",
 	.ops = &adi_ad408x_ops,
+	.caps = IIO_BACKEND_CAP_BUFFERING,
 };
 
 static int adi_axi_adc_probe(struct platform_device *pdev)

-- 
2.47.3

