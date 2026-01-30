Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022140.outbound.protection.outlook.com [52.101.66.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E6329C74;
	Fri, 30 Jan 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764649; cv=fail; b=olk7nuCo0dbFBoAAM0x44nTwFSDiak+Gq9yoC5mrwanQlCJ00Q4CBv3n7/uRaPX2Q81cSCkiPki89Xffe8OdE+rUKWIyq6tTgsWTGVaJ2GYvUn7EMLryXQpVTdTONbiZIfVx5ErfCMlOV1YSkoMDzA80D9P73BJ03M5UfrqGBq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764649; c=relaxed/simple;
	bh=qcsgnhM9x/2IeyYKal09yn9X4/vVSN1Ui/T+M0AFryc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CnXUF1IycF0ule3ono5C2Yss4Ma4Z4/x8qC3XRBtuW+5bITXSB2Okm2j9S5u/HArUwqqySN3DlsD3dTz3UTIm9Z4xEDMQKYSKZwWhHTZh+Z8PQZGXG0gRtNSdF0hhKs/F1SCJelj2n3edvt6HKLllwIzg6RXe4bdTDOnK90EVQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Uk9L+m+M; arc=fail smtp.client-ip=52.101.66.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Uk9L+m+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6OdiZhN8XLam22hn1R3uuVJUp3ILr7arS+tzuxXPXb+rZ6EVj0bW+qSs0kF/BsxPo8q3JxiSN+Nv33x7z3LPEsub5GS3qb4wbhPwmpTqwMIHiZJsOAboXmGv+UMOqpE/m3usZtu3bevMRUnwf6tfMdk5XgMMuDV1UXh0hlNhWOLbQO8H3XZK3mmArvw5GKmEioLB2tMReFg21FgwBFF4JIgeUrlTAmWdQrld7ypyL0irOSU7JrFu577V2B17V4uTKrmTEFWx+PszFI51R45c7h0TvE8lfyZU+Fkxx6N/UWjIYEbPq3eANetPWgwrZqcDG4n3c6ET8SA5YYdBAGQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRwpBj9Q3XqAgrmtR4XGa8GL01Z9u2ahR5hQNJBUQZM=;
 b=qENWe0ypWHQn+0/ftQbqCXFT6XizwriZk7JmAbiWSMCgzXjTzM42EIYiEmiX2Jy0yqwtCys1kN8cIPxGSj9dsVgygDDOVW645KBLcZtm/h+2UJugDXOjKPgYwWuAsiqfhf2fbTFt97yql5qAFJRG5jB/nFncLp65JKg9DZ49v988eqyWBYPddhXj07aPVqCAbh+sbG5R5fA/mBBl7QbtIEzbiFrZo8gPxb2rXoURDK/GewfeQFQXaMxxngUTVafXSOxnCTCqEYvCFYGHMDRr2K9E3WEYjgkGyCENRCseEaxjWPJ56d6B35rOwm0Q39WCVViPfi1gks/F6BaOoGyEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRwpBj9Q3XqAgrmtR4XGa8GL01Z9u2ahR5hQNJBUQZM=;
 b=Uk9L+m+Mnj2rVtiGRadG1yj2OAOzThz8MgulOFcrs+BMekO65ddtxaoDDCLeyY4rHewdAaVyTAsgbdeZgS8RwtlVoM/dfI2AVAFSCxGsc1OfRqZcvhACFoRJ9YJzxze0Z1Ygg1hVI17MEVAoWNzBgGxbH1KFkV58H9/yGEG96H8i0U4MIkl904NwW+8wS74wOrvjfn2PYZ1ZbiAcQELiPO59s34ZrlRxd1QwdsRr9mzS0FZbG05gjU7Ig14BBGgu00hEHzd6xw2qxnoOGwGkr0thIitqzILUhd8ua9JT9upqR46LIeLsLZvVq5ruaOTyrmJI4kn6dx9o7amCFCPkrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM8PR06MB7361.eurprd06.prod.outlook.com (2603:10a6:20b:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 09:17:11 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 09:17:11 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Fri, 30 Jan 2026 09:17:00 +0000
Subject: [PATCH v5 2/4] iio: adc: adi-axi-adc: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-ad9467-optional-backend-v5-2-7da803ba7326@vaisala.com>
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-91501
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769764629; l=1391;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=qcsgnhM9x/2IeyYKal09yn9X4/vVSN1Ui/T+M0AFryc=;
 b=PKo1d7+F9OsdG6jtf/va25YXkejjecCijqZORxtiKL3N0aq1w+ud662ROF6VV7fXJDIrADqKC
 yoT++zU167ICtJytfUfoxUivS+ItEJ4ErkiTs/Hky2fLK+sbBlVHYuc
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF000167F6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::667) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM8PR06MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: e7780a30-7acc-4b40-7c34-08de5fe0595c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFhwdTNsVGFtaXNtWHFvQzIvTktmTk5mVlRYTmo0ZFh4cHJkUHJwUXlHUllM?=
 =?utf-8?B?T1VTTm5rS3JGSGxPMEFoamlGYnJKb2x3aHRtMEwxdnozQ1VyNzAxQjgxZUdZ?=
 =?utf-8?B?UFlUYkl3Y1RMT0UxTmtiaVNxU1NxS28rZ0hqK1h0UVA2cHlrVVhvR2dKRHZS?=
 =?utf-8?B?enZjcGp5bGFKSlJXdjRUcWNpcUZvWlhwUHBCZGdkb3ozMk5FQm42SGlGSmJX?=
 =?utf-8?B?emc0MkxaMEQySzY0VDRTbmpFVGlSeUVmYy9UNFRxT3pRdHc3ajBDWTdiV2dW?=
 =?utf-8?B?NnVjYWdEVWJHVDFFcEFaR0FwRmI2Z2hWQ3RreTdLL0hXc2xkQ3lFZ01hbTJt?=
 =?utf-8?B?YTBUZ2JRTHpXblI5emw4RWcxeFdaUENQZWtwSTUzN01MNENHeE50N1NlNkx2?=
 =?utf-8?B?aDJ5UHg1YjVtM0dWcEMzelVDaG8zQ1poNzR1QzduVTA1MVk5Q3lQbmlrUS9m?=
 =?utf-8?B?QVNEZWdHTXJXcUllNU9sSVlibEJpVnJmS0oybHVxbW15aVNMVFMyMjQza0N0?=
 =?utf-8?B?Z1NkWGJPM2krZjVGRnpwY1R0MlBnS0d1NmJCYmxtOVZyKzlQQkJGdXpsMjYw?=
 =?utf-8?B?UFQ2MlM5d3kzdlJCT1lQUVRJR1k4TnBxK29lRzFjaUFlTnk5Q01Kay9NSGdm?=
 =?utf-8?B?aDZuRWNwWVZBekdZb3VxT0wxeDErRXR2Ri9GMWJNZFVwNzYrZ1FsTGJ5Qi9M?=
 =?utf-8?B?R3lpR0RsUEJFMDdYd0Y3aEVVbDBmY2ZsUThOVFR1dFc1YnVVajRidmMxdnpT?=
 =?utf-8?B?RUVHdEVLMkxwWVJ3TXNXRXJOSERiOTlnUjBHNWJuQ3JreWE3NWgxdkhrRkUr?=
 =?utf-8?B?UE9KQ1MvRzA1T0ZzcTU1ZXIyeVY0aXo5UktWbnYxWmZBR2I5cVhmbWMybDlJ?=
 =?utf-8?B?ZjEvMkovN2ZaUDJ6dmJsQkhaMzZqaFMrcnBhN05zUFo5RlhaWmxrS1JkNUx4?=
 =?utf-8?B?b3Iza2hrUFFXODJUMWZRV3V5SXV0NE9OSDJYY3BoZForWFFsR0pmZW1qaEJO?=
 =?utf-8?B?MXlvbllOb1U0bFIyUFhLUnAzVEQ3NmFwOFhIZXVLME1ocG9UOURCbk9FbGVW?=
 =?utf-8?B?MHlJTUw2M2ZrV1NzaWlqeGIveGlUdHJBdDJXS2dhNjdyK2Iyc0RHZDFNMmhI?=
 =?utf-8?B?a2trSFlpZGtvRnBlR2RkU3pCODN2dXlRQklOUjN3b3I4bkZKNVkzVEFUaHFW?=
 =?utf-8?B?WHNQV3hUdDVDa0xpbk5IRXRKcmYxNCt5ZVQweklRbTNPR0RFZUdaTk9FT3RF?=
 =?utf-8?B?anFSZWhGTTBUWVJZS3p2SzVrdlZna29GNVZQUW5teEVSemJvUUN4TTdhS2py?=
 =?utf-8?B?NW92UWJ2ZG5VcTFTRUhoNHp4WTUwOFVHTC83ZFdkTFZnVkNja1FCclRYbnVK?=
 =?utf-8?B?THgyTTRoNnplWWRlUWJsVjNxL1R2VXNTdHI2NnRQWHlqUWlMREVJSHh2aEZD?=
 =?utf-8?B?d3dYR0F2LzVQRGs5bW9td3VoZ1BWRHFsMWFKRjJJenRTRytMVEJzc3RoS1U2?=
 =?utf-8?B?TVdBckpPTXJycG50VWpvQm9BdWJHOW1VNmFrc2lOelJ0SW5IODZWTFJDTDRm?=
 =?utf-8?B?K05iZU5HOU1odkxFQnFNaEdTYTIwYnZ5NE02Z1RSNEZzTTZlVzdBU3I1NE5W?=
 =?utf-8?B?VTQxZU1VbElZcDl6RWpFb1BqRUNucDZBdmNob3NqY2ZNMWJBcVMvV29XdHJG?=
 =?utf-8?B?R3VBZGJCdEh4ek5VanFEbGZzNVhxY0tIUEszSU9xNFQ5ZXJlNXRPbWZFMitx?=
 =?utf-8?B?aytISndtelFhelk4dmxkcHNOZ0t0Q3FDM09FaGl6TTFmUGxBeVFuYWdXR1U3?=
 =?utf-8?B?TGlMbU5yZERWM3ZCemRLT0s5cTZYM2lkSE9QcmtveG45MFBRdStjRzFQcEE4?=
 =?utf-8?B?QjhHcDRQeGpDRXVYcWZlcXozczVmVlV4OUJVNUs2RGJzWUdyVXV6SGFOV1RM?=
 =?utf-8?B?dm15ZndWaEdDTnExQWtwcTV1TVlxL1JGRVFndE8yanVJS3RjTnBJdUo1ekpj?=
 =?utf-8?B?M0lYUlQ1aGNLZDFRNFgwSGxsMVRtZjlSRXZoZmYwaXVOY0QyVTQ3TVp4WWd1?=
 =?utf-8?B?RTBmWDJEV21oTmM3RUd5eVN3TlFZS2xpY29QM21rWkE4S09sMEw2UkVlK2hl?=
 =?utf-8?Q?3JbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SldGVnMveVY0Q3BXeTlEMXpHUkhUcDdDOW54bWNyKyt4ZHZJVnlzNDFyTXpX?=
 =?utf-8?B?MG9WblA1OGY0aHI5NWlXaVlSNE5JeWxVL25PRE8rRksrWC96V0hqWkw4TURa?=
 =?utf-8?B?YXpPeEFHRFpseE5tZmQzbjZrYldDb21pQ1ZHUmx5dXdQQ2pKcnpXdkpDVkov?=
 =?utf-8?B?L3RIdXRwdEtHMlVJVHU0TzB3bzlNOWZQSERrQlRPUVVVdEdvNEVXOFFhWWcx?=
 =?utf-8?B?aHpkaHJ0Z0ZJZ3duS3gzWG9PMzlzTy96Yk9ScFFJUC9pWERVZStUOVd5a1Qv?=
 =?utf-8?B?WXA1eVk4eVFFc2gzWlBhb3loaVc4RVVwVE5hUGhpZUVOdVViU0Frc1JiS0Nj?=
 =?utf-8?B?YWhJTUptM2FVeUhOMExBK25mZzV6MFNhaDk4YXlXYk9nZnd6cWxFcHIrZWxI?=
 =?utf-8?B?QTNzdjBSK08yY25HTzBZOTBZaG9IMXdXWXF5TUtpVE82bXVHYzRDdFlmem8y?=
 =?utf-8?B?NTRUVndhM2wvRHI1MDNaeFJZWGZ3cHIwNzlqNEJmQkJ3SzVLSG5paXF2QXFu?=
 =?utf-8?B?WEw5bnhTUHFyK0VQajAyM08vWU9qZEJhWitBeTRGcG9zRHNjQnQ2Z2FlYllw?=
 =?utf-8?B?WDluMDVnbGFqb2JiRzRMN3N1V1VRQy9hcUxDV3FKM2dHWFRzOVFHYjhndkg1?=
 =?utf-8?B?REc0QXVrQWJldWlYUlFlbEFUMVRJVXdDU1RqcjRMQVAwUjg3NVZROFAxUUJG?=
 =?utf-8?B?S1hxQmVRb0dYZjlMK1VWYUdjT3g4aTN2ZFNKc2c5bWY2VE12UGdia204emJN?=
 =?utf-8?B?K2xrdWxibkpDbFk0dnVwNFUxUldwaXFJRzBndUNVWkxIU1J4blV2aXFUc3Uy?=
 =?utf-8?B?cTZpUkVFeHcrd0ZpazNvMmdIS1VNRHJ1clRGVWFPOFE3NTdsSWVacXJQTTBn?=
 =?utf-8?B?QmJuNmQzRkFuTFNhK3ozRnE3U3d6VDBrQ3RJN1JBWjBvRXJVbjgzYlpmbjlJ?=
 =?utf-8?B?bVVkYkEzdmdjNDRqYXNvVnNNUWRoMEozL3JyMTlxakFhVnNwRk9qVU9TajhL?=
 =?utf-8?B?WCs2bVBTQXhiM2xmNG45S1VIcGtnSFR1dlVOeGs1RUVVeEJPOG9tbVpjNGlQ?=
 =?utf-8?B?TGsrQmd3d0puUVJXWnZtSjg0Y05HTUlhUzlkRHFuMk9WT0hnMVNNRExwazF6?=
 =?utf-8?B?dzhBMWNzMFM5czRrcHU3TGxmb0htN3FmY1gxZmovVHpSWmROcUNHVzRSUFVa?=
 =?utf-8?B?c29CVlFuNUZ3NC93eENDSGlDd0Y5T29HV0oxZm5YVnFvc3JMY2VPdGZNS2Vm?=
 =?utf-8?B?eE5RVjVaaXk4dzJVQnJGbFJIMWdUYkhVbHE4MnFqUC9TTlBaSzdJWUNSa1FD?=
 =?utf-8?B?VlhZQTF4SmNqVDY1Rno5QTJ1RXgvMitsTFhWams2Q0JMNVRHckFkSitlQUNL?=
 =?utf-8?B?cWlaMjU1bmgrbldqQUJiVjVrdCtXRG52NFFwZUFKYmVkWnFkMlM2VmtoVndr?=
 =?utf-8?B?L0lpaXRJdDZ2YjJqdjFXQmdNanBjRmxkK2w3MmxPWnltVTNlSnU1dnh3aUh4?=
 =?utf-8?B?c0RQY0tQaXFzYUM2ZmNkd3dnZEs2TXUyUEZwd29GT1djYkoyQkVJQjJXOTY4?=
 =?utf-8?B?RkZhZGJicjJtSVNrcVBiWDRXUUF6K1dXT1ZRZXQ0RHd2Z0lHTUZkTmw2NGdQ?=
 =?utf-8?B?WmZxSHFEVkt0SkRmR0pKdHp4aWdSY29NOFowNytFcVhGbGhTeTJNSjRNL0Vp?=
 =?utf-8?B?cGY5R2w1dXJSeW1uNmRySEFobGJBbGFXYU9TTXVyQTVXYlpZRWRCVUtBazF1?=
 =?utf-8?B?eS9PREY0TTJZRjNFT3pPZXBOOVZrVU8xWnBZbU9BeVZrdHhwa1c1Y01rdEJm?=
 =?utf-8?B?QkZIWlFPNXM5cTFwakdabEhzSVJaUmpSQnVMZEhaUklWbUdreGhXLzAzWXVT?=
 =?utf-8?B?b3ZkOWlzSngzRWg3Mmc5bTBlTFRhZTF2L3FrWjZ6aERvUzlQUXFxK3dzRzZk?=
 =?utf-8?B?M200TzNWTDc3UVJUQVk2NGxtc2YrVHZUdUxwRGZLcm5hWG1vTklVUDVWTXVo?=
 =?utf-8?B?NW41TVp2UytMVTJOd0toYWtwTUduUDNoTFRHTlBYSHVKT21aNm10Z21ybC9u?=
 =?utf-8?B?dGJLRHUwSWx5U2ZzVVVkdmsxQkR0WlNKMmRjbGltMGV0YjU1b2tnV2Ewak0r?=
 =?utf-8?B?T2p3NllDUjYwa0JyOHN1VDVSODdVWVBsaGU2NldLZHZ5WnlxQzVHYlpsYmlS?=
 =?utf-8?B?MEhueVdDSXpobEVnK2lKeEVIU2M2WHRwNTJLOVhFcmljOVFiQnY3WmRLdnls?=
 =?utf-8?B?NWJLQ2pJa0h6aGxYeUxSSW40N3ZVTDA4TUV0RWhzTktUbGFzNHpScHNsUG50?=
 =?utf-8?B?Nmo0cWM3ZWFuNGV3eGNIU29iNTNIWEFSSUJtZjY1TU9HbGdtZnhESmswdW1B?=
 =?utf-8?Q?+Ma5f6I20RhTtX6w=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7780a30-7acc-4b40-7c34-08de5fe0595c
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 09:17:11.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqVpwsucIeKn+f+wjofbG52ViFUYfiUfTqE1DqdLN+m3zWyBJaKPJM6flBuraTBfGF9UWChZJ5x1kJX5SUSAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361

axi-adc and axi-ad485x backend variants provide calibration support,
whereas the axi-ad408x does not. Set accordingly.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/adi-axi-adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 14fa4238c2b9..133aa6f43a38 100644
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

