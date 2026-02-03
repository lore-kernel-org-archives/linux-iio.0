Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023086.outbound.protection.outlook.com [40.107.159.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CA392C57;
	Tue,  3 Feb 2026 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112262; cv=fail; b=ioD6aB36sdaEENlpzZihEC+cX22Kx0LOb91V31gfO/X8MtQ88tuMDexB3KnQwsx6mjECt4XUrPr2sh9Gj3tGWexj8t0G3Nx8s0wwPecKSs81pykwJQilxgHysFLLUb26r4qk7WNimXDzhQcSPT0eLdRyOqHezoOkuuM+l9+oMG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112262; c=relaxed/simple;
	bh=/XdV4egsLN0m1+BczwhxVZYlfd4FQDMA8zJnh7IRaeg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V0LG0GkDzP0AJW6HUu5uogPdlEJbTR53c7Sc1K+epcGNQIThVz1Ra5krfA+6/5i2XMSWAReFsLTCuCf6A2N0MyibaScipKlUi5iFX8c9OsrsQeNlAaKFHa2xbLyRLgbIhALdOReBEr0Eq4MF2gdliP1B/wWI6pL0XbsD9vXTUE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Qyerj1Si; arc=fail smtp.client-ip=40.107.159.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Qyerj1Si"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNuTmVq4M5AzIvKKTh6GbuDaJDmaGsBFUOX0UiCd2kaL/flpPn3mtGI1MLnxxk3dk2rSAeb/Dwdfqkfi4E0pCm24/hpH+f+QjiktVSsHklRreJk/LHZQeWAGXAc9QoABj7ZWjA4ji1Yy6dJhCzpEaW7/PTL4WenOl7IymrV06hd3vmoeH32Xd33PIzakGgk+1ispIFqnLbYZbTknfZbuAzERsIrH0RaG3vMAT15VNYPMISO7+MP+5wilTa6pYZ1bwbYRZ6T9utI9DxGtSSFnAfckj5kV0GG3XCBK6OYRbyG+GU8ZHfrXXbZijjJT0n9IYNqtHH6iIir2naufJkdiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24xOt37ifdEC9m2zfuHW4q3X8qQUa8GOPBzRgJPunrY=;
 b=dYuuwz6b3gNb7yqO+WFf7Vfxevz0eQQFHA2nEQLtJqTCXZ29XLE0qF6S1gc9jgplypvSVFVq2W8kC3PNOkIVDGWI6vyeFEIeSsNuo6epm3UdSn3DnyRS3akX901NIDO7Nho1aiXqhuLjMOeeQUWBX1N8YlvTY+GL6T9vv0/GCP6B+P/D/r+x72iXygLflS9+T1EohzkGwp/unW3j2E58tzbwyvB7HYHrdjpduevUfHybuhwDcILIXuCPwTaQ+/M3znni/OpvgfIOcZT0oYGFSxwQhb6y3USSIRBQvN8G3Eg3+8y1WvSltw30cFHRbOj1qvl8bFo2KLqIVk2GhdDXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24xOt37ifdEC9m2zfuHW4q3X8qQUa8GOPBzRgJPunrY=;
 b=Qyerj1Si7iAj3Oy54WkEw2oC6um2oA8VSw8EGIisfNJSFFmpGjsvJp6LVspTc/c7bhxIFIAi1hU6LlzwNCU73Aq5WjHmDYZ1Hly5PMLZQ1MMgCWDZcfwTbFMei+MzQwnxTaEUrPjqA07lLpiVp0RC5PR5RaL/wsXdphj4hWbDqlitaAMCMeqmvy66ZUbqZPnxCrqIWZQqR0OeAlK2d20fu2Nl6qSJdINdfwV7N33YZfROM0vQIu++7XA3iZ7kQxInDKP79c2QqMTRCxC6B/RaAtZnIdtx924fpPnd48SWBgosyefhPF1uMdeh3iLbm8xI36+INEOj+ZX1eh5eebqNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV2PR06MB9985.eurprd06.prod.outlook.com (2603:10a6:150:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:50:47 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 09:50:47 +0000
Message-ID: <e9f9e1b0-4cd7-4d6c-a7b9-25ea0e6e774a@vaisala.com>
Date: Tue, 3 Feb 2026 11:50:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
 <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
 <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
 <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
 <215cabfd-497b-4f22-ace2-ff8f6145d79f@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <215cabfd-497b-4f22-ace2-ff8f6145d79f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0005F718.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::39b) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV2PR06MB9985:EE_
X-MS-Office365-Filtering-Correlation-Id: 435805e5-5979-47a1-e683-08de6309b51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzVBa0l3NWlqM1dSSUROVmdrbVRHbkMwTUNLRjc1ekdBZEFnSUZkSCtRZno0?=
 =?utf-8?B?S3JvWDVLL3FuMG9OOFNONEV3NmtSVlZzZU1JT3JCZkpPSWpnZHNWL203TWJo?=
 =?utf-8?B?b1I0NVR2Vi9McjZ5NkNHTFFyZG5Vakk4U0RaUVZVUlVpNHBaN2liWWRLQ3BT?=
 =?utf-8?B?bGJINERQaFNTUFZ3MW5rOFgvd09KdGVldENIYVNTbUhXM2gzZUJEWTNENmNK?=
 =?utf-8?B?M29ZckszdEduN3huS0gwZ0hPQWRidUNLcWRJOEJxK3VqMWVJekRJTE43a1p0?=
 =?utf-8?B?dnhUMW93aUtjbEJLVlgxbEE0cWZNRHg0T0dVUzAva2RXR2o2dStEZUl3MTFF?=
 =?utf-8?B?R2xwQk5DemxtejJoR2xBS0RwT2dXR2FEMmExcFdNN05uY05XVHpDQzB0WDdH?=
 =?utf-8?B?SThPbjFpSzY1aFRFdEtISURPSmxUZkVGVm0xMHBtc2hHU3ZQeHlQeithd2t5?=
 =?utf-8?B?amcyQXAxMWt4bzBEV2FoU1RoTXYxUElzMmlaaEhRQVEvZmNSWmFaN1AvNlZJ?=
 =?utf-8?B?c3ZhZURMRjhRbG9ONWVnVWJKTWJqMEtjTWhvZklyRXppNmdhNTZJSC9CS0Y0?=
 =?utf-8?B?YXlyaTlieHVZZUJYVEw2TU1jVG5UQnA4bFFUaXpoay96NDZMazFVMnp2NUs1?=
 =?utf-8?B?bWhzakdrVTZWOXMxeGZtb1NCdmNCbzByOGpERVcxZ0ZKaXNUYm1MSEE0bUJS?=
 =?utf-8?B?dzYvajIxMzdtbmVySmFxZEJLdHZ2TWhkWHBlYTZGblVvRXp2Qm94azdCRkZy?=
 =?utf-8?B?cHpKMEIzTzM1a21yd1pNcnBVUHBQTGNGMFpyZm5nbTg0RlJFM0dDd1F0SUhS?=
 =?utf-8?B?NjJVTkRCQVUzT05FamZWdCtrZm4ydThYd2tQQVdwYm1nYzVVeldSY05CblBn?=
 =?utf-8?B?RDVDWDR1RUNuR2JhTk5meWJXQzdvdDZDbXZUQ0J2RktJTWQwTlYzN0FsVlVj?=
 =?utf-8?B?VVNyL29OUmN1SzhBTmYvbndqekZMSFZ1enBzaUhibDBTWEU2dThMVDFLYUtl?=
 =?utf-8?B?aGRRendHNndsdTBuWEJCZS9aaUdLa29CU29ra0JVa3QzWGxNWndaMnFqVHc2?=
 =?utf-8?B?NjBEcE1rYnFHbldGTzVEbEhkUlQ2c3ZIN1VmaHB4SWttRXV0czhPUUZxcmkz?=
 =?utf-8?B?UllJQWVTL0krT1lFUzltWUFodUg2WTZGUmdQRS8vYUt5WmNicU5VZU1QcHpJ?=
 =?utf-8?B?UUZxK3VRTFJTdnJkckRRS0xTQTg1dWZodnova3Y0M2Jpck4veXlEbXk1Si8v?=
 =?utf-8?B?NUdiSFMwVHFqc01hdU5iNllJQzBmMDh6SkNiVjlwVm5NUEE4RCtrSUQ1OU9T?=
 =?utf-8?B?ZnBwREJkcjR6bWRlRWxSWU5OSlNvNlBYaVkxbzBjSXQ1Q0JXQzNwV0RBc2t3?=
 =?utf-8?B?Z0ErUFNZUGp4dXBETXlnRldkNitoWVRwMEVVVDNZNkR4dXpmNmZ3UUVaQWo1?=
 =?utf-8?B?bzU0WThBRHhFNXhnSlVmUUk4WTlKbUZVVWg3eDNZdENjbGU3UEJ4QUl3QWlI?=
 =?utf-8?B?MXdkZVhEOGhWcm9ESG5SdXE4VkcvTm43UVF6NEY4Qm1pdHVhN2JXNHJSNU91?=
 =?utf-8?B?WUZ3VGZjOGtpVHhrZEdaY25SdjhEemdrd3lGbUpwL0QxbFpJWG9tTE5sNktK?=
 =?utf-8?B?SG5GeUM0d1NHYUlEeUdhWGhaaXBtM3dzdmR3Ni94Ly93NFlreEtCZzRzQjJw?=
 =?utf-8?B?Yi9qU0o1cnJROEUrMzU2azBYOGs4WFpzRGNqMmFwbTlSV1JNZHIyQ0lEMnlt?=
 =?utf-8?B?Wlc1VmpQcUphTk9oZnZHVDEzbVVoK0x3Ui9jcmVDNXRVL3c2dndoVXVUMldy?=
 =?utf-8?B?ZlZOdURxZUFUVkFFVUtVYnVsMFpvWTFxa1Y4UXlwdjF2dEVsM29NZDBacHZC?=
 =?utf-8?B?eTZmSUNVakgyQmlncFJDR01ORWNxSHVPTjBjRlpKT3FYck1wL21pSi9UbndT?=
 =?utf-8?B?d2NhL2dmSmwrRi82NFhCZmdwZDlnQk0rNnp3RkdjWGdlR2pmZlVQRzIrVk55?=
 =?utf-8?B?UEpmaFQxYnVXd2FCMk84K1NTRWx3Q2NEallKVVVjOVh4M1luU2p3Ujd2M05q?=
 =?utf-8?B?K0x5MytZRjE3dEVIZE4wRnRya2lMMnN0WUdaYzFxaEg3b3BBWTVCMXk5SnMx?=
 =?utf-8?Q?TE0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clVRd0NyU3I5K0dOZzRDNDhSRzlGWjQ2RndxT0J6eXIwYjdGVEZCR3ZGcEhs?=
 =?utf-8?B?MkJCQVdJNXdBbXUvWEZ2RVJ3YWQrVlp0My91bksvcWFSNHdyckQ2VkJOZytN?=
 =?utf-8?B?SGlKQ2R0ejdDdjlZM1lUWkVVSGZrSk1peCswSG1oR1dhVFhuRHg3R016ZVFR?=
 =?utf-8?B?SEo0K2JRbUI5RW1Ud1Q4Q004S0YwODRTSHJIaTJiWldnbG5XaTQwb2h2cUdI?=
 =?utf-8?B?c2NlaURRRXRZcE5JMnIzMm5nZmdGYk85bHhGOG12ellZOWRDcDdxRW9hd3cw?=
 =?utf-8?B?MUMwL095NVhzV1pXQzI4WXhMemJXTGZMVmJORGV2a2lWVzJRTkR2NTZ4ZDQx?=
 =?utf-8?B?YkRWQkRrOGdrOFlOS24yL0NDdFdlUktCZGRaQmMyOVZqc3g5VlVGRzgrYkZ2?=
 =?utf-8?B?NFhPbFM0cTEzTm05QlIwbW5RejFFSkJmQlNjSk9HekpQZlhkUzdyOE1SamtV?=
 =?utf-8?B?aDBPeUFqdDhYRHBTM2p4ckI2eU9lakdPbG8xdGxlUXp3bmV3WjFHUWxkamo3?=
 =?utf-8?B?U3B6TGd1WGxNWlo1NitIb0o4UG9OUVFDN1RSWUF5eWdJZG9WSWJOd0tqeGFZ?=
 =?utf-8?B?YkFXYU9JMU1NNzFhZ2tqUDFNT21YMFhlN2VhUnJaWWIzMHZqV2VpK0JIZCtB?=
 =?utf-8?B?d3JJOEFodjIyODNXalJXUnJjYlRJSmJMTkZSTnhjb3ZtV3FDczA0UHptQ0Vn?=
 =?utf-8?B?KzBzVU9ZS01zdWUzSnlUYnZobmhtd1RKQ1krS2NKVkdyYWIvbi90ZE9MTUp2?=
 =?utf-8?B?dkUwRlNCa0pMcWRZYUZ6M3ZVYVVXcWl3RlFQTXNtbC9lckNxSHUvOHRaL0ZT?=
 =?utf-8?B?cjFtYTRCeVN1T082TTNhdlBqYW5HV3dWZnRLN2Y5cDh6V2oxL0VZd3g3RmFE?=
 =?utf-8?B?RkJXSE5nMWcxc3crYnBRYjBheU54Qk5CZ2VnU3BLWGxxYnprZHNLM2xJZGlE?=
 =?utf-8?B?a3YwR0ZMcDExTkhpaFRyb1poeTNmOUtFa1FUd2d5R2VJNVMyUkY4eWVlNGhT?=
 =?utf-8?B?cXNTZWJQektOZmtmSGVidTViaFB1Q240SXNCN2pHSFkzelJ1cEpvUVFFNm93?=
 =?utf-8?B?UTVZbUFETGNSMkpSVnNpbjhCMXd1RTBEZHZ2c0hKYTREQ1FEcFNjV1JHZWVZ?=
 =?utf-8?B?di9QbGo3d1RxWWU1TlBWQTRkcklrTHhBRFNuZW0rZ0tBcERHZk4vbW9wc3pD?=
 =?utf-8?B?QlhwQlZsVFpyS2R5cXhCdWxrMDZ2VlJBRUpjNmVTbnlCWWhPenVxZ3NQeVRz?=
 =?utf-8?B?UkwyS2lVY2dqNHcyS21CWmFvTkdvV1FYT3BWMG11Y2FRalhneWNDVzFlYnRk?=
 =?utf-8?B?a1A4a0xWUnp5MWtkdjNzTWlyT21aQkthZy9zYzFoVWdxaDZmWjRKSURCamZp?=
 =?utf-8?B?ZGg1QWduaURBbUViMkQ3UXJZclNEQ0dSWFJGa1YyOE5tc3BqaXJDT05nUm5h?=
 =?utf-8?B?NWo3MDhvZ3I2UlZXbjZ4UFE1dHdyZCtKNXZWRms3bFh3SGxQM1NoaUZqUEox?=
 =?utf-8?B?QmRDS09GSUNZT1RidDRtMXEyUW8rbVZ2QktsSHVRci9UYlNiQUoyUzhXQXlI?=
 =?utf-8?B?R3kzU0I3MmkvVUw3aVVOTWhkS3c0TFErREhYRjJBTWN5M3NTZUUwTUFKanJ6?=
 =?utf-8?B?TW5SZ0JNcXhuUTd3NzBtOGxCMUIzeEhJd0o1aU9lVC8ya2dCamtjMVVlZGVL?=
 =?utf-8?B?bThpbWZ5UXFFK1dIRGF3YllvK3crTjZ2STBaT2RleEhJVGdtZVZaZzZkbzla?=
 =?utf-8?B?UW9iNit6SW5ROUU1Rk1SNlIwSXMybDJEK3dhWFlHMkZTWElOdlY3ZzBkL2Ra?=
 =?utf-8?B?eXV2cWovV1llemdUNlNpajVsTWFIWEgyQXk4UERVMENsbHBObXZyOWFrNFRz?=
 =?utf-8?B?U1ZDZ2g0VXFOT3ordyt1VWdWbU1vTzFSS2w2S2FweStkSmRqQkFYWWxtQXdF?=
 =?utf-8?B?ZTROeEYwUUtXVTBTUkZXNCs0bUZ4WGN0OVh4azNlb092OXFaNmptNE1yNmJ2?=
 =?utf-8?B?ckFoclBRUmFZbUI5ejEycWdVUnMrRVdpQ2JpNGo5dmZiVlE1RnZ4L1VCVWM5?=
 =?utf-8?B?OE0zaEdRemFHdUQ5N3FnNmhFUWowbmJUSGhLdkJ4bGVDL29qQmlWQlp0TUJO?=
 =?utf-8?B?SlR6NFNBQmdNcU5pSXRIQmZmUmVnNEpTYmtlYjR2RjZXL1k0cWxGcUl4d2ZU?=
 =?utf-8?B?RGVQVm9oVk9sWENLZHhZME1KanoyajBoblJBbWMrMGJoZGN5aGtXbTJmU0JY?=
 =?utf-8?B?VzVUUzRITU9xMnZVWmMySkJKb2Y3UVlPWGtSa3JHT2tDWS9lMkZyT1dIYUUr?=
 =?utf-8?B?OFM4ZitOWndPVXR6VmVOb3U5U0dHZ2RDQUJYSU1aclJKSUtXbXFKK3hFUUxp?=
 =?utf-8?Q?/9/UCWouM2w6SK0s=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435805e5-5979-47a1-e683-08de6309b51a
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 09:50:47.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuKOTY2d3oKqKOJ59Pbsahu6DL1amKpvZvzfIcb3bVB9CkvlzoGvFuepVAjMZI7fLSmcMiU6I9OAuDp+4Z65aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB9985

Hi,

On 02/02/2026 17:50, David Lechner wrote:
> On 2/2/26 7:04 AM, Tomas Melin wrote:
>> Hi,
>>
>> On 02/02/2026 14:40, Nuno Sá wrote:
>>> On Mon, 2026-02-02 at 13:08 +0200, Tomas Melin wrote:
>>>> Hi,
>>>>
>>>> On 02/02/2026 12:28, Nuno Sá wrote:
>>>>> On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
>>>>
>>>>>>
>>>>>> Do we actually need this one? Alternative could be, for example:
>>>>>>
>>>>>> int iio_backend_enable(struct iio_backend *back)
>>>>>> {
>>>>>> 	int ret;
>>>>>>
>>>>>> 	ret = iio_backend_op_call(back, enable);
>>>>>> 	
>>>>>> 	return ret == -EOPNOTSUPP ? 0 : ret;
>>>>>> }
>>>>>
>>>>> I would prefer not to assume we can ignore the backend not supporting
>>>>> the call. It opens up the question for other operations.
>>>>>
>>>>> My preferred way for this kind of fundamental operation (enabling/disabling)
>>>>> would be to check with DT maintainers if we could have some kind of fixed-backend
>>>>> (fixed in the sense the HW is present but not controlled by Linux) dummy device that
>>>>> with implement a no-OP enable/disable().
>>>>
>>>> There is also use cases for the always_on cap with a configurable
>>>> non-dummy backend. Some applications are such that the driver should
>>>> leave the enabling/disabling up to the user space consuming the data.
>>>> For this case it's great to have the frontend leave the backend enable
>>>> alone using this capability.
>>>>
>>>
>>> I would argue the above would be something to take care at the frontend level. The way
>>> I see it, the always_on cap is pretty much saying that we can't really control the on/off state
>>> of the backing device and we just assume it's on. 
>>>
>>> If we can control it but we need it always on (for some specific usecase), I would say that should
>>> be handled at the frontend and just enable the backend once. Also note that as of now, I think all
>>> of the users (or most at least) we have just enable the backend during probe and leave it on until
>>> we unbind the device.
>>
>> Yes, this is debatable. It's not necessarily always on, but should not
>> be enabled/touched by the frontend during probe.
>> But anyways, having a capability that says if the enable/disable feature
>> is available, is in any case useful and what I was planning on
>> leveraging in my use case.
>> Fundamentally, with the capabilites as now proposed, it is possible to
>> select what features of the ad9467 are available, in addition to the
>> basic requirements.
>>
>> The ALWAYS_ON capability could be inverted, like CAP_HAS_ENABLE_DISABLE,
>> but to me, the ALWAYS_ON naming still seems the better option.
>>
> 
> Ah, this is what Jonathan mentioned before about this really being a
> restriction rather than a capability.
> 
> Perhaps we should have a separate restrictions/quirks flag? If the flag
> means "do not enable during probe" then a better name would be
> *_DO_NOT_ENABLE_AT_PROBE.
> 
> And I agree with Nuno that if the backend can be enabled/disabled later
> (after probe), it should still be managed through the frontend driver.
> There should be no usespace access directly to the backend without going
> through the frontend.

Thanks for the input, that use case is slightly different from normal
usage, let's keep it in mind if actually required. For now, the option
to just leave the enable/disable alone is what would help to solve
smooth integration with this device for me.

ALWAYS_ON does not seem to get much votes here, but how about calling it
something like IIO_BACKEND_CAP_AUTO_ENABLE or
IIO_BACKEND_CAP_HAS_ENABLE_DISABLE?

br,
Tomas



> 
> In this case, I guess we could call it a capability still. But I would
> call it something like *_DEFERABLE_ENABLE or something like that. The
> logic would be something like:
> 
> int probe() {
> 	...
> 
> 	if (_DEFERABLE_ENABLE) {
> 		/* Basically equivalent to buffer enable, but there is no buffer. */
> 		register_userspace_enable_attribute();
> 	else
> 		iio_backend_enable(backend);
> 
> 	...
> }
> 
> 

