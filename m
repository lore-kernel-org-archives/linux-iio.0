Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF8466B75;
	Fri, 16 Oct 2026 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142510; cv=fail; b=kF9TijVpuQoZZpXfwNKkKgNyzRI/FtJaWV8K7FebNfk/zQjpaQKAdXQRZ0Tji18BEOuc3nPYrypoY+3fEax71rYJ/pnZlvsgZAfujnFXKpQhTOX4DnTkVdXSYdWox4PDOsC9YBdwjQ6ZyVtPQlnvMFAvniA6eLNMY8lCn8bg508=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142510; c=relaxed/simple;
	bh=K5CwkINRWfNVanGt3mS88CCZKOR8zjnimOY4EWnQdFY=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=rFVdq4CSALnEIBZBf6SjfIHS+UmKLZ0MXK3vuwd1j0KdtgtW37dDh3ojyKqhGodfkmRIjTydZOOUxf9qRGKhPO0Bg+Cklio0gealJTme92yb/mHIcocaNTRdul/rDHFLNs2PQr/UJ9+gzWfgkZO0NAQ+5MPFvWoeBtBvWg0xTbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=auXA21Lo; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tQK/r69S; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="auXA21Lo";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tQK/r69S"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G83mQR3639679;
	Fri, 16 Oct 2026 05:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=d+WRJAiT1O5YQ37JHPOzQgdR9BaUDyjW1PPkLjL9RVM=; b=auXA21L
	oPubIES7CkP23CFndxlao2/iAI0cx9F6j7G5fbyHQmdVSmmwTLH7jqXP3t97KsUI
	YnMmUmAkI5+ADdR5bI+oYJXsqfRmg7pJYshHKdPbl1SpDRpjU8k6z9sa0GXvkz7f
	CaLXegafj/2Vf/wImZHAN6Ic2RvJSFKHkp15Fr3uvpVSNoitl2SZCh9E9aQ9zAFH
	MpbILaMOlWZ5efwOl7f5EOLHI3NQTfSwT+/1x41AvEGvnv6xW+Hh3Oy0mYyG2PS1
	R3JG1ifp1MdXMasdDO6zvm2VBpRRMV0Vccp+NERxzH/sjNmJucL/qhOfBBmbLMhu
	Gj8oal4SrStvwRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d+WRJ
	AiT1O5YQ37JHPOzQgdR9BaUDyjW1PPkLjL9RVM=; b=tQK/r69SICSjf+YDgW9/Q
	B3MxguETS2uWZBr/ZVydEkT78/tQafUGOuYMxEeXZ8DxJrPgLzB7tICZxqQWOgbl
	Zjd+wSWLdTsDEpvczB/wbJe9WeyL8/Jm63Hbz+dMZoZrbp2A8ZMmGB3D5wKxxKIO
	9e5grr10FVeHHkmtnZfmbJ9bPUFkgQjOsaaqwP8vjKiu7twX7YORYFTqknD2xXCz
	S0GaNL9Y4S1Zs+I+cwxZywZftOmUX40JXkIN3Sdw5dGOiPBpZOWNw45GNpYa9vJR
	8bc7a9DM0UItv0J5txGd1UDqjR5Xmprim9XTEnzLFr66hLAVLldB0FWWXe6c+5G0
	w==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hbajk24bc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 05:21:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIVsimrSleA6pEu6qyALetdHgIViOE0loSs3UXsAbsJfYWkdO2dqfsT+q6CZ1p3821O5BcxK55MGwiGRKp9JUSQtYp4eSTw0xVnKiLNwTIxU2tXnGm2OTy5+iBVtpWTG7rvMLC82H7uxst8rW3RdoBujRMwRe9AGA0jMsVgNkhgZTtLHXKnlAWXNNd8DQSoNRU/C5IPgUPmJCkniC8V1w/O4TA+UhpsVo4BI+aVD/AyuBuD3EKKin0YTQPEQe4Z5CBA+C6FAO2yO89376Kg9VL/QgqtZSuWxzGdOBMTpnZvQ22ISg11VqYUsxWFUAwKdgVRIHxECu4P7zZ/jegWUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+WRJAiT1O5YQ37JHPOzQgdR9BaUDyjW1PPkLjL9RVM=;
 b=ImRk5fx+83HCVL6Ec/wglNkAoD0ZBfAuNbIN0QmOdscykraSPVGmvNL6Qjqs9T+bvtV65qvMI7lfEZ8Rv8l1VREgGuypX95urYqkdqSBGClbz5TJ2kGAIqAP8w1dWCAX5palpYdRfuFc3gnC5uHSkY+kqe1nHdRtQPnmfLPOp3/nZbunAbzQX3E92kpVEO+PhujlqXBjre3cWcFvxsdd1EwblTW5yWKZGPz8+L2Yh1EsF3hY48WL8/2hBHhXEqLpigzj8w+moibXfMmbsOxnNGgjsStwqDvwzykRsVVhzFwmco1xK7OiQp4VQaJYIhMVV4W/e4QMYW6ERhuiIxoVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB8138.namprd03.prod.outlook.com (2603:10b6:408:296::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:21:31 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:21:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 06/10] iio: frequency: ad9910: add axi backend driver
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261015-ad9910-backend-support-v1-6-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-6-3c21648c8e26@analog.com>
Date: Fri, 16 Oct 2026 10:22:34 +0100
Message-Id: <179214255498.3322.2151044744907920115.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142556; l=1173;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=K5CwkINRWfNVanGt3mS88CCZKOR8zjnimOY4EWnQdFY=;
 b=ipi0dx7CzFGYSbfGWhn61x7hbusHH8EQ+ebwYK3dF4ZTyFmKS0cb7KgPLD+GvVmQEnBsmesHh
 iJaxagMLe7gD4EsDt74H177R0U5bGP3rJkh/izwNYv606mv7fs59wDN
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: be66dc06-05b3-494a-3582-08df2b66dd61
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 JLzCy+go77WofniUY0XAIq6sjE6GcuTNlkDwsDVjRqAFspo3hTdTH802Qj6J6EFtIvdMB/6+526IqSOH75gR0Jbzte6bQkGRfv5mk44K4dNTVmBwC0NnB2Auqwx0l3nJLmHESfpQ5EkIb4aIdI5Nb2Zdd4Fe3NzrvzCy9cHDuBeru4ZrgFf/36tKveF3qCjfle/fi+6VJGYQZmUO/E8727P+L0EhreNG+FOQAtSPIIKouMAsRgoY/YXk/07PGz6hwu9yL9i9+XoK4qGpKf0I87RS8DQShp2LEOEMXSzIpR/lsZlFgulyjdVlsXyrIqehUZUphQgpeQVsiPb7VgwGiMGU7KdhiEpNdl0NTfhh3VtvRjnoqyB1Ica1VR1EjYeMF0DQrtnwa7DlAteRaRLt3w3JXkdOWBzkO80OJhtQeIOJccm+0yisNI1z0KxzKTcu5+DdDhZp4BzFq70zYpj3FtoR7BjEyQUSVM8IiX0XrGaCoX2/4dG+3vrg5J1s9fCrjII8VuL1cgRaf9w3VbVlmEphS7VGX/h2lCMEOKJPWfI07tAYKK/7y8H8Vn4/3QyVFUY0GOjJ/ZLb0LDMeIeCGKT9Bsu3eolnqve4NN10wEgyjVm4dYu6IEd5QGc1gdr9xHUkkWaRY0EBHeo+rzXVQoAZPMOp3cKjAcr/iGnSdgw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T1VMejBuOTdIWE1BOHBnVUpUTjVLU2tLaFlqZDFackU2Z1R6WklYQlU1UHhD?=
 =?utf-8?B?WjZwaXg2amZWZ21GM1VXekUxMkxyYVF0QUpxSW1SU0VhSmFtam8wUWpKbnFp?=
 =?utf-8?B?dUNJdi9GbTZaYWkxOFBQQjZHZlJHdERrWUtGZ2lHWEhtWm9lS2gvcy9zbk96?=
 =?utf-8?B?S2pqWGk3WjQzSXdmSVFMWkNzdEk1VkZhWERRRW92eWR3K0J2cXZmQ3MwMytB?=
 =?utf-8?B?UkZ4M2hZZ1UxWnZiSjVKbG9IVlIzOUN5d3h4ajdTNkV2QXdabVVYWEhjdVBr?=
 =?utf-8?B?M0E2S0VYY3R3SHpaZ0hVSUFvWGllV0hOWFBsb0Q0QllUcmdQakdndEh1RGdU?=
 =?utf-8?B?SjlrU1M2UDZJbjZEYm9XM3NVU2VGNTNNWmhnbS9qemI0K0xmRHJNVjVqa0I3?=
 =?utf-8?B?d2xjbko0L2c4ckZDcXpFUFBRWk1NVVduRnc5LytVR0o3WjR2SnlWSS9Zc3Nj?=
 =?utf-8?B?aFEvMkI5eXJXSlpPL0h3RHBQN2tTbExNbXJsWFFaOXNKVWo5S2EwYnlrZ1hZ?=
 =?utf-8?B?dVZGTEhvSlZlbDF3cm9SVTdSNzU5cFNvbU9rWkdROTdxczB2TnN3V0N5OUJS?=
 =?utf-8?B?YldOVzdjWTErTTRXaXpRK0FqM3d1YXZ4QzdRNkcvaXNQNWtsM3NZZTJia0Ux?=
 =?utf-8?B?ZlZMTWE4MzBzVzl6aGN0bUp0UFZDbWNtZzBOV2dGSkNyM1M0eTJVMDhBTWcw?=
 =?utf-8?B?amJRTlJuNkdQUTJJNjFRODlXZ0t1RjJUNWZ3dzEzbTVpR3AvbGlxVVNNd1lI?=
 =?utf-8?B?MG9reUttNzE2dllCK0JmdjdJdi9sRDloMXhWdEU1ZGI4NzlYQ2RrZ0NBd0NS?=
 =?utf-8?B?RExpa2ljbEVOc2dTN0NYbFdENU0ya0RHZFdyTmxOLzNmZ3Nyby95WVJYN3BH?=
 =?utf-8?B?TndjbXZubERqUmZUbEdsVHlRbnZobDl2MUZPT0Foampqb29KMlBaRmEwamI1?=
 =?utf-8?B?ZFQzc3JsOHR0ZkNQZjBBTWN1dnZ3RWNjaEFESC9scVFmMm9pWTQ3RzkzTGdt?=
 =?utf-8?B?bUdNRGZ1TTdGZklueEN1NUJpOEF4Z0lobXFoNTJ4Z1RseURQMWZLTUEvNG9B?=
 =?utf-8?B?Zk04WHkwWVZwY2FyRTFLZ2lnaCtQcXNwbWFSa09sb3RLRW9oVndNMitBWkRp?=
 =?utf-8?B?VThMVWw4aHJXTXJyb2FHWGpNOUxMSkJnaVNNVHV3Q0xDdVVNSUVFdTgrbFRu?=
 =?utf-8?B?L1J3QW5VM3djYzlMUGsreCswbUFHeVloYVVheHRxcloxWm1kUUVFbWxVTi8z?=
 =?utf-8?B?RTVIZ3dKYkM4RUpqSXBxRFJqT2pjU3BYTit6UFZKK0lWY3QvaURWQVdQSE5M?=
 =?utf-8?B?aHVnRktqYlhBTllsRWx0Zkw2NXVtWTMyVW5LWUF4YVVYU1p5WHpQYmgzUzVU?=
 =?utf-8?B?NGV5amt5ajVINHJ4aXBpaHZPalJ3a2ttaHgxV3ZLVm1mTEZ2ZFVzZ2NsZUQv?=
 =?utf-8?B?a1hKTDYvb2dSZnZKZUFyTEM2MkNKaXkwMEladVRhajVBTUxySEx3V0l6Yld5?=
 =?utf-8?B?NjdxS1hhNGI0MVJHMFpGT3dYbjNQR0dCbGttRGkrN1d4RGdZWFdFN05oVXFh?=
 =?utf-8?B?TTlVVmVsNjFUcTJxLzdoQ25EbS9MU3dma0IwUy9oM3Nmb1hpb3FxNk11STcz?=
 =?utf-8?B?OGpRQURRSHNhZ3hDdC9LTTV2RG4xNkh2YWl4b21WNHV4enJJVmJwRHNoZDEz?=
 =?utf-8?B?eUhZcnY1dEFLSEFvU2cvQ0twb2hrWGViUmZ5VGNsQ1VXckd4aUhDZHMwRllv?=
 =?utf-8?B?cDFaVnp2QVhIMWVkaUFVQmFyRmZNeDNZazRQRk1FRjJncGZaYlhFMG9seTVM?=
 =?utf-8?B?SWkzNFFjcnZQZEZYS2RZNi9RSVNOSDVERk42WGZ2T2IvYm9VMlFNS3o1UGtl?=
 =?utf-8?B?Yjhick9hbWVobE0remhQNG53ejl3eUcxUzlQOHF5ektFNCtzNFZsZG9ESHFC?=
 =?utf-8?B?aEVHcy90c2tKTUtKdTg4WlhiNElwMTJlcHg5dEhtY2xHTnJOcm9ub25XeE85?=
 =?utf-8?B?SnhhTFpqQnZlelp2N0ttQVg0a3Z5Qnl6ajVMV1h5cXR3MlZOZURrblp5SVI2?=
 =?utf-8?B?T1Y5QmdVN3liWWZIcW1jNytqNjBoU0JOVGxrczN5R2ZlTE1meTU0RnNLN05K?=
 =?utf-8?B?Z3RCMGNaVlVuSDdBbjZlRW1oelFvT25PVFlhbVJ1aVNIcjRWNkEyc2xCaWRQ?=
 =?utf-8?B?TmVIUDQ2SDNlTWpSbk9sT2loUlpCSFMvcDhBOWM0Ym9yTi9qUVUwM2t6V3Fr?=
 =?utf-8?B?YUlWRldVY09rOUhmYTB2UWQ5cDhqUFNtZWhaeTNSTFJxQ0JuVmYzWTVDbExR?=
 =?utf-8?B?ejBrMEFReVBFZy8wVWRWemUxWDZNQXpBbFdvNHVRdFFOSVRNSVp5QT09?=
X-Exchange-RoutingPolicyChecked:
	pj/HTBuzGvHOU1zLhCDFQkWr6rTHlKQHF28VtFqWUVqy3OVGx72fb+ReT5ZUGaWW8kOm8oTeJ3NsG4no11UEcYRg2wdwWO7tJGroW9dXIkcV1R1k6Sq3289Sc5zLXgSGfyQkunxfRFbFSKyxwtsf0VtVkRwU80FD3x/hvtkGdUqh/jkGwPZoivNQGT3BnnwY5+4wJyxpYVbtfHeIrCHIzwmlJtxt37sp3Wsbgf4xpxP18350DHac4zZu9R1nRFxLwHPEz/fbbbAdkocybhAChZLz1MnU667jVoL274lpzsqL4sC8GP0ROis7JibFac9AbSXMAyVLyKtTiAXUZldFaA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be66dc06-05b3-494a-3582-08df2b66dd61
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:21:31.2171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzpvqxZex/h9t5xxM8MAfIZO82xZ+3LDJhK0QKDqsBpmJ8mDGa4nPYu6fQG1RKcMkkfG2HPSIreL+H4bYEIqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8138
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX3pxHmz7uy2ZL
 amoOz5d38cnrpy7mOgwGzCC3atrVVWQV69zfLS6uAZdHgS5LgVgMQhJFu5viA6ZW7maBErZrPnw
 +6BdKroB490fp96jN8+1P6VAIaAU292ceVJ2cxo9HTxzibNjdnJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX2DDlze5zlkfY
 1n60kDsIhB+tea8BSCebrYUsoVnNCAi4pco47aT6Co+tHhtwZJqeEOkphlgrIipsqzNDOarKIg+
 jA+GVvlKYnice/FwhSBkAec4/Zm6V73bjy65ah8YlGZyVbIN/SjFTNzAceGqAl+mF+tRMTJHHs4
 VcNo9sPefZVZ6/ZpnhfRuUCIIhCFrL7HDIJ8/I3iZPh3ZRGqdUeLYu8WPi1zmo1Z15M/nK4lUJz
 pqzGBYE4kMwpo2q1w8pp3YoHKWLHW6wyzPi5g1wdxv75aFoMi0lYMcoVnoutiEuco/+md35tnT+
 OELQ9FQvdu9qQnBsaA/v9nZqFA5STNmKTPkKrC6yXO87v3acVAQQcVq+jF1geSerysS48wSBRHU
 yi+oCmaXZ0fUu5/a5NvtulerlNH4QIyFOgW3XuXPgaF/CW+xifrURVArVOZ6OksLrQ0tW+kgUog
 C1Tka9ajYR3pHfxPngw==
X-Proofpoint-GUID: ZZZVqRv3GNv-TmVdD2zL2hwP1A4DFGRU
X-Proofpoint-ORIG-GUID: ZZZVqRv3GNv-TmVdD2zL2hwP1A4DFGRU
X-Authority-Analysis: v=2.4 cv=eLqGH3p1 c=1 sm=1 tr=0 ts=6ad1ec9e cx=c_pps
 a=fm8IUWXzr0h7QqFIpCBYEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=6XD2Kfg3uNA0JmreDz0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160037

On Thu, 15 Oct 2026 13:49:46 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> Add the driver for the AD9910 AXI backend IP core, which interfaces with
> the data and control pins of the AD9910 DDS. It registers as an IIO
> backend that provides:
> 
> - a DMA output buffer that streams data into the parallel data port;
> - the parallel data destination (F[1:0] pins) and data rate, derived
>   from the PDCLK frequency;
> - the PROFILE[2:0] pins control, through profile channel enables.
> 
> It also registers a PWM chip with a single output driving the DRCTL
> pin, which the AD9910 driver uses to control the digital ramp generator
> direction. PWM period and duty cycle are programmed in PDCLK cycles.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

I think all sashiko findings are sensible! For the division by 0 does it
make sense to start with some default rate (so we do not have to care on
the read side)? Or maybe we're already guaranteed the core has some non
zero default value (but in that case not sure if we should trust the HW
- at least a comment would be useful).

-- 
Nuno Sá <nuno.sa@analog.com>
