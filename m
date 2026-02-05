Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023141.outbound.protection.outlook.com [40.107.159.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76093D3D14;
	Thu,  5 Feb 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294267; cv=fail; b=u01O5vnS7xG5vR5bnrXT9fdo9rCvYcSC8fCbiIvTiz6wTyuJNtyThW9OvbKQtrzC5Qztg7JJ4jOLPbcmzx70SRr8nvuYuYOY7+Qse5nUUvWys6PSgWMqL12f37zn/eW+5GZeYwAjWDSsF5Z8Q4Eiz7VHPdmpbypxNQrJj/vCV4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294267; c=relaxed/simple;
	bh=IHFAVPZH3dvdclj1WoOrvksUTjEaLI3aK/+j5f5l/EE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g+kPm/uGdwGWSOj+m5cQkWQEVzcrt1XJUXlutDBYu3n5P1NvZrEs5YKfin3HrgolRe6tlvwZ6litMaVNSsgxYJW4/rB+hvg8LXazv7TBfZ5XucVNCjjfgBxmbfNdK1h0AWvAEk5pDZAKl/A0di5eOotEz5FXSfoW3mKO4WYj++I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=paXEwUw7; arc=fail smtp.client-ip=40.107.159.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="paXEwUw7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw7wXVYYmAMyTDxjQr0h002ZyD/sNVullKMS6Gf1hX62eMkS9y5Y1S0giXR5Fx1uTBgMMWErIlVNfKEkUNr5OW5iRmVIte9kSERW4el4OAxC+4j06DSKQhIPUN02+9g808Xw7OlxIX3iWg0lY1CbETxVBA/5nmnTKUtAv9zkkAaIfqw+DDzZH0B7j61XgpY/XARSlaVfMD4TYqjTYWZh7Ri3kZaRkNzPt731KO1tGISlkQ4txPkw1Z6/vx4gXCPrE5FaNHRK6TK79QOZGBWkZEdNESjCXHM44B5MPrdLjy6OYTxq5BTQTdLoyseHh+JElDj3AY1ku/2ezgRudaKj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz9+dEwWLy8gEliqusMfRuPaydrmOq+RQHq2Bs00wHc=;
 b=Iq/DE9GJpQFzWtB6MoKykjMGzduqL/Snh3MB3l3Bc6oGOfJroOH2Rk8wyIiYZ4izTdMZTJNWNjteB/IRN6W7paCbNfKxovHFLQ2HRqAdwuI+A7jC+l9hy147yoHCs4NOXUVHe7iMxSJxlig8WWAFTtdPq88c132MxxSSiaOD+u4OBrEa7kjVmgI2PwsO9y01vmRyb4cXAwSXwDEsQmherv688w1Y20FU5wI7rT6nJCC9DJS9/5tDdzxz2420+71jUmzY25lI3mmWbqA4kWRUAHpWYd3crb0W1GMCntVK4h2/KeB6sq8+FrognAknw1lWo+IeThXpueYp3QwzR9+V6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz9+dEwWLy8gEliqusMfRuPaydrmOq+RQHq2Bs00wHc=;
 b=paXEwUw7rH1uwDRkg18sOvwr4qldwUJ58CSQcL/QbqHTKIwhY7g0YiPOASoCCzheKQO/miTl0BelptARVvT+nyCFINhMHsMLQ1UccOrrydaQs575YfIBKG2/FW7Gz5NWBOstvzGGTnSi2wzhi2N7SYjCKZAh9sUYTOKkVcApgEEhFjtLHV6PKDwZtXgIVVaZjv6Rffq377RDqe329myhRmdifVyd2JenNsQizC/0NLoHpxfTMaqOY3yxIwGMBXvxVURFL7PkrU0oTzg1GUxntM+64hl2mILvl9HOU2g0hB9a8rJTww8L7eil9Q0xZQZVs1PkhV6rtJ3GHCh5AQCs1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA1PR06MB9233.eurprd06.prod.outlook.com (2603:10a6:102:454::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 12:24:18 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:24:18 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Thu, 05 Feb 2026 12:24:10 +0000
Subject: [PATCH v6 4/5] iio: adc: sd_adc_modulator: define supported
 iio-backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-b4-ad9467-optional-backend-v6-4-7ca20c40c59a@vaisala.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770294252; l=714;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=IHFAVPZH3dvdclj1WoOrvksUTjEaLI3aK/+j5f5l/EE=;
 b=ypPW9mY3EqA79qnkh4GgFmL97LwvSBlyRCal9H+Kw5clUDVe7Q321NSuAHQTMu9tKA+Gw6vLE
 lbVyBEAmG7UDe69NbdHxP5qXGF5KamSPbjX/OTaeR/FuSNoS0h1QbBX
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF0001DBC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b2) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA1PR06MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ce63ce-5f48-455a-5a95-08de64b17a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE0zbVFwVk9KR284Z0tpcjhLTFdickZpMlpHV01PN3d5YlUxUDBJUmR3OU81?=
 =?utf-8?B?VVBqbEdNVkROR3IyeUFLU0d4MjF0Um9wcWNETlFiMTlzRC9VQkZsU1hIMWxz?=
 =?utf-8?B?eTBmQktMUW1wZjJDVWpSNVViMjlSUTB2OW5zMmpnUnkxOER1MHFTbjBJUTNS?=
 =?utf-8?B?UEhOMUFOMVlyZXp4ZjJJbmxMWW81cG1mZUtIZGt1VmVJRXp4ZHkxRTFtVElM?=
 =?utf-8?B?azljNERDbEVqN0dJY2tGUmlhVWZjTXlMVGt0QnhKMVkxQ0I4UUZNVDdjSTlv?=
 =?utf-8?B?bnViVlNiODBhKzNEN1ZuZlB1ZFhVZ3M2NmtDZzFMUm9WczBUdkhZQUg0UC8z?=
 =?utf-8?B?RWJwY0RQeS84UUlyY01tcUlVcXpKSGJJdmI3MktrbnNUMDlPazdMdmFsaGFZ?=
 =?utf-8?B?dEd6S1VXbjAwdXhMR1piZEMwMkp1MStOMkI0dUFIdGxGaW5rNXJZamhSVTFR?=
 =?utf-8?B?WHcrL2RoemVpcjYvQXpHNktsSTdUVUlhSlVGR2d6enRiY1RYKzcvS1ZRK3c5?=
 =?utf-8?B?dXZURDNQRWNiMG56S1NqWmZzZThXclJqL2JtY2pBVzhETEVlbmoyeVpHTHFx?=
 =?utf-8?B?a2RmVi9HV002V3VuUGxyeElGZ0R5SitON09qQys5eGFKQWx6dlZmcjRyYUt6?=
 =?utf-8?B?cE54NHI2OW1lRWVuaEJyTzYxckcwUzliOXRMYTNBUHRXTEkvSzlhcFYxOTlm?=
 =?utf-8?B?eGl0ZWFIN1RUOTlPU2lxeGtLUUh6OXp2MnllcVQ3ZTFUUlZmbjlxKzBUanZD?=
 =?utf-8?B?REdtYWxYaTVYMWVadGNRWjFsUmRGUDJLRjRJb0xYQ09pd05PaDhEb2dBWkdO?=
 =?utf-8?B?WUVTYnl0UzlaYlFkcCtOajZPUCtUbDg1SjIrRnF1TkxRWEpqSHdsOFZValcw?=
 =?utf-8?B?dTY2UFZsa3FxNzE2T0xZTGlTT251UENtWVVOM1lVVVc3cXpsZVRjS2RqMTQx?=
 =?utf-8?B?TGpvaEo0c2dOTUs2eDFCVGpJM0FqSVcvamtyRjByRnhtSFpseVBOVUxkL29z?=
 =?utf-8?B?TmV2ZjhBalpuK3IxYzY3bnlaNzhlUXBJWm84U2lIR3NObldkdERFOEtVM1pY?=
 =?utf-8?B?emxuREhlY0Z4czhOU1I2MXh4ckF4dVJtdWViVFp3OE9McXBIeGZsdlRmVnpl?=
 =?utf-8?B?bTMzMmErTHdNWDlpNHYwajhGMmRiKytLa3BvaGhKWVFIYStRaHlBRFFBd3JT?=
 =?utf-8?B?Vkl0SHA5dThOL0JyZ2lkU3lhRDZrWUorZThzanRoQTlrRnI4WFY0ZzU2R1Y2?=
 =?utf-8?B?VmpCQ3pwYW0vVGlUQ2dyeGFWVGNZRHd4UkNXVWZHRU1qMkMraVhwaXBVL2x3?=
 =?utf-8?B?OUhDVXQ2elJhUEdiUDMvUnhJemkzeUZ0L2tiSFIyYXVWTnNNK1M5VG40djly?=
 =?utf-8?B?MEVUOUN4ajJ3UHl1eHV2V2lDR3VJUFVreTU5bUtON3ZnTW1DOHlobXpkd2VX?=
 =?utf-8?B?THJMTHZ1YmVUYmV4NHdlNDU2R3FaeURYcyt6cU54bUhUU3U0WG1Obiszd3ZP?=
 =?utf-8?B?U1JoSU05QXJhMEttWitGMk9KWTBIY0d5TzlCWDNwMjJpR2Vnb3YvbTllMnVo?=
 =?utf-8?B?YkEwZjlFSmRDTEFXRFpwMTRYZVozSkZCUVhZT1k4YS9ZUEw2ZHpEVXJsMWhI?=
 =?utf-8?B?NWxBblZHZHZqN0lzSFJRL3hEZFVtVVlXR0NIL0VjdG9nWk9CNlFodGZMK2w1?=
 =?utf-8?B?ZjdBNW9PMmdEeUEwTVBCVjFLckJHNE5yemkrQmdOdndIeWNBYkpBSGZKYzZ6?=
 =?utf-8?B?cm5HQ0JubjVRQ1dCRDNmaDJCVVVmYW1PM2hlVmdGL1FQdjNybXROTVJjTVZ0?=
 =?utf-8?B?U2RyQURKTmZ3UUFpajZFbHlxazN2eDFGaG8xN0hUK0o4YXJoN0sxR2JVdTBR?=
 =?utf-8?B?dUJ5L2cyckMvczFNY29mdHRGN05CdWZ1U0dtamtDVGVyeXh3MENZV0phaU5C?=
 =?utf-8?B?aitXU1pVSWFzU3hPWjIxU3VOcVNMbTZIZG1PREl2Y0NpRlVWSkRLT1pxa0pM?=
 =?utf-8?B?TDNrak8wWEZYSGZwNWtNQ3hNKy94MVdqd09kdjN4cDJaOGE3RXJwL2F2Ymtr?=
 =?utf-8?B?YUUyTkN3bjlnWS8wMG9yYjBKd09UZWcvdDNYanZhWm9lc2RTTUU0Zldub0NF?=
 =?utf-8?Q?p+4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0pqZnBGZ0Q0YkxZZ00rWXE0TnhVZDhZRks4NmNMVFZJYy9GSzZIVEg0dnpq?=
 =?utf-8?B?bnJzdVFpYmM1Y3hZaUNLeHJFM1RwbklOWG5kV3NtOFVvczY0a2FaU2x1d0p3?=
 =?utf-8?B?cG90N3A2TjJrOHRMMlBTbjBFTnpZdUpKRXFvNnA4SmZFYzErRmloY1QvUmo1?=
 =?utf-8?B?YzRPd0ZVaURZWnA0WXJJUmJCa1l5V2pwc2tJVlkzRTkyTUNBekFvM2VqOVFJ?=
 =?utf-8?B?Y0grRjV0UnJPcW5IZHZaZ1UyckVSNXU2QXAwSHJtTG9sL0NlSVFtRTI1TmI0?=
 =?utf-8?B?Szg2eHZrZE5lR1c5bllrUWd1SWh4d09DV2d1NzkwKzRNdlZ4cTV5c3h4YkM5?=
 =?utf-8?B?MUVTQlZvbmRORDM1c2ZML09DSE1OZytTRFhQSGtTd21CU3BDdmdpTCtCenVz?=
 =?utf-8?B?c0NLS0ZDU3VTYVVsdzVmUmFrVnRPdFl2enUzYVBGanhIMklxR3hMd0U4azcw?=
 =?utf-8?B?bXdKOU1Rd3pXQks0R09mZ01rYkhTQ2NTZ1RDdG9uVm1kMHl6TnNrSm5PajZC?=
 =?utf-8?B?SjQ5Q3ZkMTdFUU90cnZFRnc2NUpia0czL2VOTFh2eUVVSElvekVGQWs4Zkk4?=
 =?utf-8?B?bEZ1OFBGeGFVeFBrV1J4Z2hDOXRYTDV1SFJuZ0xlY3FKNE1lUFV6M3lWN1lj?=
 =?utf-8?B?VWRXMUs1RWMzb2FTVE9kcTVNN0tMdFI0Tndpd1d3OElqZzhHZG5oV2V1Rmds?=
 =?utf-8?B?UitjbUtGMGxkTUY5RElqSXJkekpkd2VaWjFJVVQzSzFTZXgxclE0RGt0QVhu?=
 =?utf-8?B?eklicHBzZGxKQ0w4bFZGdGpxV2UyQm5KeUpSei81MElmWmh6eHcyeExXZkNQ?=
 =?utf-8?B?eWlnQVU2d0ZFT05SSm16Q0EyS29VT2UwWDdrQjRoWUZoRnl3T1JKSUp6U2hy?=
 =?utf-8?B?QTNZeWR3OWJ6OGV5S0VPV3dGSHp4ajlMR3lkbkVoRS85SWdWSVozWU1VcllY?=
 =?utf-8?B?R1pvbDBzTWtLamZzanBLTDVmTVhEc3dkYUdrVU8xYjAzZS9QMTBVNHp4NkV2?=
 =?utf-8?B?K0dwcjNPVDQ0TlR6RWk5SHBkaGo1SURQSVhWbGd3MVNwNDNzcW5WUEMyM21D?=
 =?utf-8?B?cGp4MTc1Vm9ic1RETHgvcnlVQ095ZU9DMFpzVlBzWjlsV3FvVlcwdm1sTGdp?=
 =?utf-8?B?cWxsVmpVd0NIeTZQYmIvMjJGUllra21sZmxrWGlsMlZqd2N6Z0d1c3FSQ1Zv?=
 =?utf-8?B?Z2RDZDhhOXZIZTZ2TUlKSFZVejBoQTArdlFISThoa1JUUm9TWDVySGFEUUIv?=
 =?utf-8?B?T0xPT2hXU1IvS0k3aTNTQ2M0dnRRT1I2dStrK1c0L1l3a0dERERsOTJBOFJr?=
 =?utf-8?B?ZkdKdUlDd1hud2pCUVg3RGpiNjFzeHVLdTd1UXRIUndTZVF4MmlBSnI3RWxj?=
 =?utf-8?B?cGdOTnpFd1dvZUJ3alBOUTVoZlhYNHNLNW9xazNEdDBYSkdYbm1DVGxXQU4v?=
 =?utf-8?B?WXRmOUlKaUtRbm96L0g2TmRONUlsZkpDK2VpZnMzQ1NaZ3RSMkgwR0tGZ3lh?=
 =?utf-8?B?MjNmenNHdGtJaFFWT2pMUHE1UVhXRjdlMzBiVjZZNFo3VmxWeFVEMHU3UFhQ?=
 =?utf-8?B?WE9UejJXL2hlQTI2WStQOWpIM051VDZKb0NQRXE3SlpYUWx0eVFTWVFjQ0h1?=
 =?utf-8?B?a0NtOEZqRGJ0cGViRGlGU2h5U3BLT0NrU1NxS1VHSmJhczUwcjEvVUd2Q2s0?=
 =?utf-8?B?cGZVQ00xbkxaWnBGY3B1YU1ESzM1OGZMR3FaSlNscFo2U1Y1N3Z5cHhlVzJH?=
 =?utf-8?B?R2hBM0xQU3hoL0xLVlJQbnllb2xDYkJxL3dKS3VBRWlWMTlRUzNRdFVmRXIw?=
 =?utf-8?B?VzZMK09ZVWsvWHBTVGdwazJKSG9pdW01VnhPR1gwNXpZUm9Ra2U4TDlmNkl1?=
 =?utf-8?B?TkxKVk9NN25BQW1BbjUxMWpqZ0pEdjdEYm90TXlqbFhFd0JtU1Fac1FXdDJz?=
 =?utf-8?B?bWxRbk96KzZZeFNrS2xrYm0xaU0zSkQ0Z0ZrR25VclJCYWp2TUVBMUw3dzlJ?=
 =?utf-8?B?U25vTzFmeU4rL0haSjA4WGNwc3NlaFJHNWwwWFc2d3lRVXRHWVBLTUxHZmpt?=
 =?utf-8?B?SDU0TVdCdlBQaWhucHJmVGw5aFNRaGRkV2hTSUpoN1pPamRvdlZ4Qldxa3gv?=
 =?utf-8?B?R2ZkK0krWFVMRGZFcUR2eVhKaXdkdzdWVFQzUW9KVWp1OVNmV1M5YlhpMGRK?=
 =?utf-8?B?VTZ4MldZRS9DNGlTL1JCZjdseUpMOWt4YlVHR3VCVjBJbUxselc1RmV0dnJX?=
 =?utf-8?B?SDFBUS9VQU9LSUxVY3k0ZDNwTnVjanFTTmZPek1sdlRNT3pWU3ZpZWdHSXdh?=
 =?utf-8?B?ZFN6TnFaQkw3L0p3YzhSRmt6VG9PN05Ha212cG9ISU1BOEdBQUM1K3JEcjN0?=
 =?utf-8?Q?v0dPNL+vBrF4f88s=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ce63ce-5f48-455a-5a95-08de64b17a6d
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:24:16.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONXiEV+eI5FWT5FOhsTmnJHrmCmWdg1iHEXZRwu4NW/8h68wbk9DjHtOfb/bM7+qm7f/3tmdbSHrdtTriY4tTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9233

This backend supports the added CAP_ENABLE capability.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/sd_adc_modulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 9f7a75168aac..218117c45ec8 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -77,6 +77,7 @@ static const struct iio_backend_ops sd_backend_ops = {
 static const struct iio_backend_info sd_backend_info = {
 	.name = "sd-modulator",
 	.ops = &sd_backend_ops,
+	.caps = IIO_BACKEND_CAP_ENABLE,
 };
 
 static int iio_sd_mod_register(struct platform_device *pdev)

-- 
2.47.3

