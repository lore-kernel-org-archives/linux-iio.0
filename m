Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5293EDAAA;
	Wed, 21 Jan 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997343; cv=fail; b=l6AglAh3W9+I6pOU09iPbNw1mV3tzPQbkbJy2E417YNRgKdug+thx2xmxXhMc+nICdPml5f1Q/icR7HoqsJv+Pt0wYY13/z/d67E8cgH+n/hcclU3ytAKbUfHACES0fIEJgCOKvx0xS9zlFWozARiNU4kIsGYitm5azPxwQXLdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997343; c=relaxed/simple;
	bh=n34qtqy4qD8EnNx9+AdnPO3iSIqKXo8Wzp/Jq2TXGxM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=N+7OP1hPAevzkiyyyZ2MY44dgL1lycoLJSSmiIBEk+B0iNze8hqAsCsJOKBnZCFS62EE2Hgf2vzc1UI1YAd5vuvucym1q+gcfgAY9Q0fJ24nk6AD0rUi10jRr7Qs5FAluNTjMcv3rZzLvze0Uw/MocLmc5ZIA6jDj5vr7O7Z0PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=QKOgOKlr; arc=fail smtp.client-ip=52.101.70.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="QKOgOKlr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOnXm3naYKJrWAkjpARHSTgoZ8N87CcNEU9lmDbf8vB+cJjEj8gs2GfVdUx4qfpMgW1so1ZCn/h3YTlma4jFWcv7bG15M2ETX1nKH++n3B3otFLnDWLSXB0p/5jQRSeoEPT0a/P57TGgeMgyEDpZcZhAQKe6ZpMsFoRIFfLvKf98fzHnKeWjhf87QgrcqoLkPOhxRva0YMyRmNDkmAOYs6n59I2HVGRPBRZPw5nEMrTdrFRsjYFSnalYkP+7KVnrjld+mZG3JgIazCrQXqNicWITz3ql6GyWX0bc5464FMNJXHfX4KBa1lZY1tpEkiM2zSwVJvVi/YX5Anr/hQuexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtIdaE0MLZPWEuAIiuvxmwC9kTVKwW/pcfh2tnQOl5g=;
 b=RHUDsulqKH86WyI0VztmFsQxzCJtjiijd6NDiYDjQFmssIXszSPurdZPkq1CsgpmzH+UZsSLdqlk5IhORQzca30QTzZZbM4lQnzWtaMY7rcCKJeaDqKwJ0p3vzadcyfsG2PEu1/92Vreqv+qAChb+nrzWhI+oNGXS8gQ5N4I64HU9EYUzvscf9o3bVYTI6WVOkPyWvGvyWw3DG6fdM67HaaMW8kO79CEQWKJwrUW50FR4lDl50ku8FZvu+oy1EJef2QdvWcC3znGXDlXHfPxeIW1HcG3kp+Sl0gHcHNCGvHmOI+TsUVmnpRkAk4ZAWc9MznEaLgHE+UuPJ0cRbEBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtIdaE0MLZPWEuAIiuvxmwC9kTVKwW/pcfh2tnQOl5g=;
 b=QKOgOKlr5JrcsLpBtHv7YEr2y1E36ds3jdSTz876MLmNqu1j3FNFaNTRfH3/nH2Y6ghTyhKtsBL7Me57jIg9fwCVm2HEsUJ9c4EIMq1AcNySM5UPDKjXp4ttA2+J+xSEJ36gtLk6sh6Pssq4UXweE0ix/H2mvSIJd3TbRSggnPlu8V3/lKzGP90FKKp74U0VLnd25FruRDGTqySEnKm//YpW1o6G3lxCi65rKYqE0CFihKDaq+UzcEw7d8dAwbOXHM5bWoJe4pdeyXuLTUH/6vb2TpfqtgqaLIKAjsm/dwuQ+J3HlA955oJ9VAyYAZIOB6XJun5MJ2IZnZB7OUhlLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV1PR06MB9495.eurprd06.prod.outlook.com (2603:10a6:150:1a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:08:50 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:08:50 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v4 0/4] iio: adc: ad9467: Support alternative backends
Date: Wed, 21 Jan 2026 12:08:29 +0000
Message-Id: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7BcGkC/33NzQqDMAzA8VeRntfRpPWjO+09xg7Vxlm2qVgpG
 +K7rwrCxkBy+ofwy8Q8DY48OyUTGyg477o2hjokrGpMeyPubGyGAlNASHmpuLFaZTnv+jEemwc
 vTXWn1nKUNQitiZTNWQT6gWr3WvHLNXbj/NgN7/VXgGW7sdkeG4ALXkjKIJVAtbLnYJw3D3Osu
 idb4IAblgkAuYthxITBnOJgreAfk9+Y2sVkxCxWhdK5tgLELzbP8wdpnrVWYAEAAA==
X-Change-ID: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768997329; l=2840;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=n34qtqy4qD8EnNx9+AdnPO3iSIqKXo8Wzp/Jq2TXGxM=;
 b=w+kQN+eoikOhTLwa8u5U9nzGI2tQc5yfZey8AIF6r0aSAPonEZayGZhdGWgrEe3Hg+0B/BIcE
 aU7mhHir9UCDbYXvj7woNLYvYeVZkomRMlcB872likZnoAcOEmfB6gd
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
X-MS-Office365-Filtering-Correlation-Id: 2d680318-61c5-4331-5a9e-08de58e5d64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGlPTHNuU09zcHVTcU5JNkhLOVFXRWU0TGhXMGwxSkowWDVhQ1lIU1hrbEI1?=
 =?utf-8?B?R0R5a1JaMWxrNWw5RjBwQzRxQWZMa29YMEU1bHhTTkdoSUNTV2Z6NjVoeFRP?=
 =?utf-8?B?aEpTdUNWa29IdFVmOGV4c3hrNnBvZHdwYmdTSmoyaEgyc2FDT3ZMdUQwcGxE?=
 =?utf-8?B?d1kvNy9PWlQvWTR2TlVGS0I2UGw4YjVJQ3h4SzRDQWVaTGk1TTRKOTUwRlNj?=
 =?utf-8?B?cFR6d0htaWRnczgwcEN3SFRlT3JpQ2d0bVc0TzhmMmdVTUIxT3VGQjNFcDRJ?=
 =?utf-8?B?THZUOHJNRlluSGZqM2N3WEVyeGFVT2xLM3ZVMEVDc1JicU04YTVwbUdscXh3?=
 =?utf-8?B?dXdnZFZJdndsejdJTjFlaXNtcHJleUpYK1FSMGhhc3pURjg4NkI1N0dTWFFC?=
 =?utf-8?B?cXNjeitFOXZleFlsb1VQb2VoYzEzTW5vZjZhL2s1aENKOXpBK0xCV3lmUlpt?=
 =?utf-8?B?Yk81NlhUdGUrT1dmRGpXR0lSUlBRMlVmVldrWXVpS0ZPdktqYVdPN1FMNDdq?=
 =?utf-8?B?c0dhMmRHNHNUMldMRFRTU05uTTJEMWU5M1FxN0ZrQy8rMkpUeWNDYWdONGsz?=
 =?utf-8?B?bkdPTHZ0NDEwOTh1ZDJQV0crU1pRa1hHN3VJNU00TjRkSE9kNWZuS2xaNzdH?=
 =?utf-8?B?NDRObmRkY0JBdXMzdXJYMmcyZ1A4VzRDWGZleVl5UVkyMGI1YlBPNnVlN01L?=
 =?utf-8?B?UmNlT2QwOWI4WDBTVTd6MXNkamNTMW54RHlTbXBlbzhxMFp5YTZZa2RhTXd0?=
 =?utf-8?B?aHNHMEErbW1PY2oyOVZTYUZMa2M0OFVnaWg0NFc4M0dYRUlQdnEzTnZveXl0?=
 =?utf-8?B?L3M2UFlNOHlUcEgyMXcxZGNtNWgzbUZnUEErTHNhNjZRQWlaMXYyQlltb3Mr?=
 =?utf-8?B?UHJDUzlKQ0FEQ0F4WW5pNkQ1U1FxNS9uZXY3SGtqTlFPYitTMHlpN2cwdm82?=
 =?utf-8?B?WllKc0tMY1NPSllQU1I1WVRMU0lVTzM4Ym0wZW1HMU5FaEpoaWR5SlRBZDJw?=
 =?utf-8?B?M2hxam9zMXpLaUxwN3Y0ODFYcE1Mek1sL0FCMzlkb0htNWdwODRiczV0czB3?=
 =?utf-8?B?YW5aQTF6cUtuQXRJVUNUUk0xdllBR3E2M2t6ZjBpYUNXOWxha1VPM1lFS0NW?=
 =?utf-8?B?YTFQMWFjakhqZmlyR1VXU3k0eWhyYlBMaEZxeDl3cVIvY01zYzRWT1Q2U1Qw?=
 =?utf-8?B?YWJDZ1JnZXI1endmWHZwcG9KNVphVkVVWFFCSWxHRWYyWjRKOTRRRm5ZNHQ3?=
 =?utf-8?B?a1FaQmdRWDhiUlVFYURocVpNU3I5WEtTMURXeXo1WXROT2FHdmgyQk4wNFh0?=
 =?utf-8?B?bzZGSGtOUER0YlZWVWtnajh4cXRYdGxjWFNpU2p5Z3Iwc25iU1pkaTNLTzFZ?=
 =?utf-8?B?Z1hEZVNGL2NSN1dNaE9SR0JaREUwRThxbU1GSUdnQUc3Z2VxM1VBR0dYYkpl?=
 =?utf-8?B?Qk1FV2crWkJCeEQrOTNpdDhRYVI3ZkhjSGtLRlFHNzZyd2NtWFZRQkFweGkw?=
 =?utf-8?B?aXNHTk8xbEpQRUwrOFJCekVTc01hMW9rRW5RYmRSd3MrSWFZcXVwejVFdGFX?=
 =?utf-8?B?SDJmUG85a3N6T3hLMVFpMU5XRHA2QWhhV1BVdU1SUzhTUzIzTkdRcVRxL0g4?=
 =?utf-8?B?djA4MXg1c1hUNHo0ZFIwSVJVMmpuK3ZpYzM2Zk9QT0NUTk9yRkFzVFFTdlRj?=
 =?utf-8?B?eWxDZStvQ3psd21YbnE3L1VLY05KU1F3TlhIaXJHNlJsUUphSzM1anJwazMw?=
 =?utf-8?B?d1JsZXAxSG1DaHJOVzU1M1B0elRhWnhTTVY3T2dqVU9xZEhQUjFtVU1xbVFH?=
 =?utf-8?B?UXFIcDkwVm5NT2tKMXhINkJwYVBJU3dlT2RzNFpkS1RUY0VrV0ZmQlY2QlRv?=
 =?utf-8?B?cWlwdG5sQ0JRQ3J0WERROE5waDdsT3o5SmV2MWwyMXRaLytzV21DU3hNSGNo?=
 =?utf-8?B?YlEvQnZhTkl2SlYzekxlT0dtMFcxSTkvdnQzeUdicWY5VzV0alp6c09CUGpS?=
 =?utf-8?B?eGxGK0lyQXRIY1Y5dXVGenZwOWptc3gwdTdGOFhhRUwxNy9Lc3VJMUR1UTVt?=
 =?utf-8?B?N3NOc2UyWmR3bjNtc2ZhYnhnODBVTENLNGJiUEVDZlc2R0RuZW4yZ09ZRmZz?=
 =?utf-8?B?OWJleU9rWVM5S2I4ZkY0RnB2eEw0V0FURWV2MjVJQ2ZGd2t0ZDRTL21KRENZ?=
 =?utf-8?Q?++o5SXJ7uL6AAWmHT5FvYQg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVNxVjFCTzdialpTWkNhR2dXc00vemxPTHM0L09ZTlBDTHZNRVRlQ2RNWTZT?=
 =?utf-8?B?K3RFTjJDQmN5enc5SDNVTW01WHFXUEF2d0JjWU9aVXc1NkxnYzRYZk1Ra3dx?=
 =?utf-8?B?bG9lTE8rY0t3OFRNNE00QXJyYWN5QlpBNm9XZjZ4UGxXbEZuM01xNmVlUVBZ?=
 =?utf-8?B?bWV0NW1FcWZrZDBkbkxMaGZKZ1hmOUlmU2cvNUJSWnk0c2s3L1ErdmI0dWV2?=
 =?utf-8?B?U09Oa3ZTZ0N2VXA1cWFNR1QwcnJGR2J4SmRITnhmZUNBbFJGZGltRmJrQjdl?=
 =?utf-8?B?akh4U1RHM0w0aTQ1TklhelJybnF2amlOK0lNNUJ1bUV5NVpTdEt3UmVHZm5W?=
 =?utf-8?B?ZUVVTmtCekNYQXFFa1UzL3M3ZXV3a2h0Qk5ZMTNHUGFJZnNnNldJSWVJWklC?=
 =?utf-8?B?OUljTTBTWG5qeEViRVB1ZmxkbkxYVy95MEhZcnpaWmJaNS90OUVNTlRYUmFW?=
 =?utf-8?B?aVhVb1I5QXNjZldMV0F3VWtXdnVPVDlFMUxiVm53MlJmV2dwUC80c05NZE5i?=
 =?utf-8?B?NnF5OWpDQmYwV2Nlcmp2NVNJOWM4dDhwZURUQlIrZWwvcmdDS1F3KzhJU2hP?=
 =?utf-8?B?NXJDVysySGJQT1VPc1hsZDZneUFiQ1ZIc1NKdHE1VEFkdkkvLzhWYkxKdUxq?=
 =?utf-8?B?bCtVL3hpcklzQlhDU2dycjI1TUhGc1p4T0FiV0MvemNEUGxBSDc5OFZ1YUxm?=
 =?utf-8?B?REZYSWdZVzFrM1Y1MXlpZ1hISUZhS3I1S0xpVFdDaExRa3hJKzY5RjdlNVYw?=
 =?utf-8?B?RXNiZU5nVUp2c3hnQTU5YXpQT1JBSkRvbFBBd2c0YkVIWG15VTUwZWRnZ3cz?=
 =?utf-8?B?MGt2SkRlR01qQVVtY0oxK2VndXkvMnFYZ2d4TlZDVHI5V1Uzd01BWGEzSzlO?=
 =?utf-8?B?cXgzTVNsTXk4b2lvbXlDK1ZzYjR0RjYrd3Y5Q3BESlhla3hISnc2N25zQzJD?=
 =?utf-8?B?YkJxUkVZcERPb1AvMXk3dkowTzhZVVA3ZlU5azZqUjZmdUdQUkE1ZmhVeTRV?=
 =?utf-8?B?SXdNU3BsdG9nOWZWeVBtT3huSlBTOWJnUFd1YXcydU56cWs4SUNJQlBobVBD?=
 =?utf-8?B?KzE3M1VjcXFNQnVrTlBNQ01Sc2dtVi91WENDNkh6VUd0N2U4elZzWU10MHE2?=
 =?utf-8?B?VkxITXNJVk0rTWNuUjhrK0JXckRDWUhpQXpabHk3UG1NS3BubDB3c25ralhD?=
 =?utf-8?B?d1Q5SjVFbGRSdlprK3oxZEw1TnhGVXJTWFY4NThBbEhvVGxSaFVZSWREaGhD?=
 =?utf-8?B?d3pnWlk4bCtIWmdvWUFJa002NWMxemNRekhiRjY3K3l5cjNBRGIydExkTXRY?=
 =?utf-8?B?RHlSTFRLZWRFRW9jaWVZUDl1TU1wc0pUV051T3gvWkJTeDBvYlZ3N2RCWDBn?=
 =?utf-8?B?bzRBMDBBd2FNODc4U244T3RXUmhVbklQaHIwRU5DMm5Pck9WU3dXK0s1MGtM?=
 =?utf-8?B?eGx3cEdnSFFYWUJOWWZlWmcvQXBNYllqUGU3UDhvU3lPN2FmaHZtV0ZDUHg4?=
 =?utf-8?B?ZzdMOFVyY2NqeGJ4QUZBVlI5ZXFTRVhzQkthZlBxTFoxYS9STzArUFQ2eG1y?=
 =?utf-8?B?S3dPR0doWTY3YmNpK0ZIT2pHTlVNWHY4YlcvNVlaRE96NS9vNlc2RXZrRFA5?=
 =?utf-8?B?Q3BvUGVacnNTdWY0NFJpQnQxTEZPZTdJM21XbXRySkNpcmJJcllpWWQ5QnVl?=
 =?utf-8?B?WGdIbzNaUERTVFQ0VkRaYmpPMzdFZUNZYUk0YlcyOSt6Uk1NMnJvcFhXWDJn?=
 =?utf-8?B?d3NtVFprTzIxc3V4UGE5bE5KUUp1d3RIdUdxNTVwSk5mSnBJb05IeS85aXl4?=
 =?utf-8?B?SHJ6TVU2dElyR0NabTR6dDJabXd1TmNjbGIyTG4wS2lBV3A1ZTZwMVh6SnF5?=
 =?utf-8?B?WStJK2dNWW9MYVRXcmRXak1EWGNKZ0s3ZHlVWHp5VklxZTM0dEpZRXFORjR2?=
 =?utf-8?B?ZElOM3NCY0kveVh1cEg0UEQrMDRKKzk0ZHdPbmhvQlZualFSWjF6VXhVOCtn?=
 =?utf-8?B?UjVOMWhCUURNN3o2TFpCWG01eHZEcDU0SmVBdFBlbWpoSXV0L2VLZXRrdk1Y?=
 =?utf-8?B?c0hUQzhWa1B5aittUUpPdVMwSFE3QTVmaWNVdjBNUzgyWTVST294K2YxTlVR?=
 =?utf-8?B?RVgxa0IvL3lFQ2JMSGFIZTMySGx3NWlDZTZzYi9uSlJZZFd4RCtKYjZuTXg3?=
 =?utf-8?B?NWdkVDdMOHVnNjBiSjNjV2ozdGdsVjczZldpa1JqMkh6MjRlWGRkZGdzMlUw?=
 =?utf-8?B?Y2pBWVpvZW5GV2VydTZUQzVOdWh3NzFhaDl2TmlTb2xXQWZVeGEyamkraUZF?=
 =?utf-8?B?bUdtWkFWVmxhbjU4dW5VejFIS2dVQ2Z5RSszU1ppb0t4eGk0Y2VGL3BqMFFO?=
 =?utf-8?Q?lZtwD+LPxV3tfayo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d680318-61c5-4331-5a9e-08de58e5d64f
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:08:50.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRE8obrNqxqQ8JFhSPIO09wQWdoqPbZOZQ3WQkcsPMMtgSCHSBWBSiluuLPhqBhJEaHkt5ZegmgLe2h77hiTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9495

To facilitate backends with different set of features, add support
for defining capabilites provided by the backend. These capabilites
typically extend beyond a single operation and are therefore not
directly linked to if a single function call is implemented or not.
Furthermore, the capabilites determine if a certain set of operations
should be attempted, or skipped by the frontend. This way
the frontend driver can work with a minimalistic set of features and
still have the device in fully functional state.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v4:
- Readd CAP_BUFFERING and also add CAP_ALWAYS_ON to support backends
  that do not need explicit enable/disable
- Don't mix checks for eopnotsupp and caps. Prefer capability checking
  also for caps that map to single operation
- Move capability checking to top of call stack
- Revise iio_backend_has_caps to use bool signature and fixup semantics
- Amend documentation texts
- Add capability checks for axi-dac
- Drop two's complement patch from this series, already applied
- Link to v3: https://lore.kernel.org/r/20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com

Changes in v3:
- Reduce set of capabilities to only include calibration. The other
  ones propsed in V2 can be seen as subset of calibration, or single
  operation failing with opnotsupported
- Rename backends checking function
- Relocate caps field inside backend struct (pahole)
- Add kernel-docs
- Add capabilites for exisiting backend variants
- Link to v2: https://lore.kernel.org/r/20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com

Changes in v2:
- Added industrialio-backend capabilities feature
- Removed acceptance for fully optional backend, instead require atleast
  minimalistic backend to exist
- Switched to FIELD_MODIFY()
- Fixed kernel test robot reported failure for missing bitfield.h
- Link to v1: https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com

---
Tomas Melin (4):
      iio: industrialio-backend: support backend capabilities
      iio: adc: adi-axi-adc: define supported iio-backend capabilities
      iio: adc: adi-axi-dac: define supported iio-backend capabilities
      iio: adc: ad9467: check for backend capabilities

 drivers/iio/adc/ad9467.c           | 72 ++++++++++++++++++++++++--------------
 drivers/iio/adc/adi-axi-adc.c      |  3 ++
 drivers/iio/dac/adi-axi-dac.c      |  2 ++
 drivers/iio/industrialio-backend.c | 16 +++++++++
 include/linux/iio/backend.h        | 25 +++++++++++++
 5 files changed, 91 insertions(+), 27 deletions(-)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>

