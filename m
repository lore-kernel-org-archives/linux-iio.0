Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2C509EEE;
	Tue, 13 Oct 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897287; cv=fail; b=npCLTvI+moMKckdX5OU6gCwdOgMAGcXfFztje9u0cXb0ZKaDQvs78jmA6w1XEhTOQTxI6lFrrKqlRw40GYbF5qZx2R+iWaCR5URmoH7Bwpm0yPJsNpwZLHDl7lHYZ1L73ifcGeqWdkHQ5RVhACVWZCt/TqTZiTgaco3uQYSZN7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897287; c=relaxed/simple;
	bh=sX5B3Zz5jaLPtDYYbi3WmBbaLUaktfh939cAtGtA/ro=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=HZwSpUG9LaZiVQpNHwuk9lHJ4LOMConsskfOr+R/QHIh9vMRE8B5lKnJmTbXRpQNlcVfa2aRQ0J0VpBtighhzPppbCXOVIFI/BhKyF31VVXRdiS9/RsRFNNVE2MGILAa1PxbPP+HVIVrbLXoEUIyDcdsF+kjC9oionfNONNN6nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=U1vdN0aD; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J2k0fEPu; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="U1vdN0aD";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J2k0fEPu"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DBHD1t3856932;
	Tue, 13 Oct 2026 09:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=fEcht1aIKvu2li12wtImhy4EPwCUFju2Oq+f8wiq6Kc=; b=U1vdN0a
	DQ/0S4y6qh6irtNAdD6Atv+diuSpgJwcEM7zCKMQ+gXLFP303K0qXElXLyQ/7qCz
	IgC5bRHVSelJaI8oyf3nq9mjaGImL8HpsGeC5Dk5F66N+XQDu5gi/VhZgJV/6ynK
	l/ZEiikfYM8z8SPcSywTwrN3k9LIa8czjrw2Z5oJdoNoSkikVNjIahQigXP2M1Av
	nMw9NQ4nTRDZ+3Af8sFkxwDPOxj+gbKvThADNYlUsiUm3e23Q2yacTGXCWitr0a1
	+DoJ5zzSMK3T71jdn+lRn9e5Cqkjlinwi7xf0XTZxTuw8U4TDMm78gMyB20DaNkA
	DUFqCb4Y6WjH9BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fEcht
	1aIKvu2li12wtImhy4EPwCUFju2Oq+f8wiq6Kc=; b=J2k0fEPutYJkxTAhYq25m
	bfbdGrfOjRnR1KQa5kl81NXxGKGmcjEZN+xl8mkhoIovTgza+z2qm4rLGEsoIxpF
	vcumkOMZwIeETeH4qKerFkot2D8HoUMU4z2ku+k9efPcinnkyeAeh2oDbOBFtFqf
	k29c9Et7n7Qb+IozDK0Na1VNUDodtS2arrTeC6yP9r9nfeeu33H34BsAV4B3CHS6
	U4AuQdfC6OE4L1pWWKk9cMHRyHSBIM5XWaFawhwDiQTF8F09L5AJlxkSF1KMahgs
	6YGbVHC5RvQFYWD1ha3pmOp8oGnCBtaYs+NsuAOlYXFBRzX3h2isgki08zWMamaA
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h8r8msbmf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:14:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+VJ8oZRw/DNLNkRaEcJH5+fvReJXgksmBQc7KGAO4bfv2Lp3yfsGFJmxP82fEzrVwbrKl0BGeAQX3ucDmi21AO5AHJQGX6fiCaF6cpvfQJf8KwUA+MOACnSx4DLgwopXd9c909be9//Cc2Wf6OAq/4/UekY7ayjr+fFWP2hMUPog7xNtpTwuw6MjLvSj3tEsWcXjL1v3w7p2Bu8JqTL/h+XOtMu/uPHM71DqfJn4e+6x9YgWNxYg0EtyTJs0IEIMr1IHiew5PQ6US6Qtj7Q6IAXI21XsKNWTFN6ytKtC6cvKednW8lZGAnm7eBQoPfBHbf9fEUDo7EjeJ1Pc6zdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEcht1aIKvu2li12wtImhy4EPwCUFju2Oq+f8wiq6Kc=;
 b=zQtXgYFiXn9IWFTpz6nhrphINymTVAA9iLzRVNqhqAzL19UvFVr3AfSC3Vyjgpy3cfP14/Vdl+BhRjwpGnpQhLl14S0ErC7RogKJ1SXOxcLcczJvYLj0f9xNIxalCvjNleIEd5RqjfnhGUe3rbxLh5UvBIdSIsBgJwfHjHoPZr41eBCaAX0a55ElCFumbAnrSfaxw9gOjhveZgK53tsuSwzV0H+ZsixZfIY5u6fTfi2bEoii1F2KxMG/vrfdsiRKNpdF5ZcoXJudK/6Xn7ZIwm62NBJE8XgzkmReHnOkdNa8Y4iuR6ufLilwKRFn9kaq3iepeKSR9LjwMhvm79xIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by DS0PR03MB989571.namprd03.prod.outlook.com (2603:10b6:8:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:14:39 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 13:14:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/6] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
Date: Tue, 13 Oct 2026 14:15:55 +0100
Message-Id: <179189735509.1005940.16593087405634433360.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791897361; l=694;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=sX5B3Zz5jaLPtDYYbi3WmBbaLUaktfh939cAtGtA/ro=;
 b=SuUWgu/JwfJbNoanAzOMEQ/J/CU1rb1kfLY8JEcTOtkOqCLSZVn0mIiiDiKhbsu5+2nUYkVgz
 sMUXoljRFtIBJ6pTArkuos5VZ5gzCMJO9tcBWM/yuYwY/3wneVoAzJr
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0124.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::35) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|DS0PR03MB989571:EE_
X-MS-Office365-Filtering-Correlation-Id: 043a6069-5ee2-4ec7-8a1a-08df292befc8
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 bd7LHA1RRx3Dc9jcjzmxPsJPaeMgPlMkTIx5yQ2cu0Rqw7ASFdX7a1GCuheVDEyRE/MeCvT+R1tHb9pm3lIIwRxzahE9yGOlbKL23qgl2wLXwMCTdIpYQ5kSV/p9L4Xh++qWRM33coM/9QTSxisAInsHUzVhac4JjWmWCIHHKQypl/U9wpna2GdfqabZn1yPVdwxaDHYxLIa2MDYZFmt8fC0t3XmcmR/y0Z7+Djy9vRhF8HlI1+HE27E8mRqpmOj5a8lOSus2GJLgDR2RefYqcaOnM1PfnZjXC3kq9EvE9mqsXKY6TDPtqxdN2BowutmwDUmo3zfjbJsvzMrglO0s2ESxCY3jo8vvnaz3MhWoptZ4Y2R6mGMyPF6m/ct+6i1GlsIDEj3TZoRnm+vDiOWc2AgzYMFv6BxtiJcOjkXDIH5CaLlKDuulqUJHl1RKqOWJnmTZMsKDORVucs46B4zvY4csSmJNz/nMPB+Zo9ToqZfQ7c3kYOGakS9VimNNFMKvq3kNVdpu8IJFByyQzb3ZhefukvqKpVep0TDwem7nigr1pPrYBkm8p1F0Tvj3sZuG8WOPsFRjzeZfPi7xrbQJ3bPFpqMKtA/nZofGkZc3Ja7sI9bpmx+4DDCz5A2Y7wVohozin2KW4QZvSR46yRMHXVhTElEffPPQYf60Tf37EM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K0t5aEVGeGNyWUVTd2U4MEFSVkZpYnBFSU1NTC9kRnlrNERncVRFM29yRnZt?=
 =?utf-8?B?MjRia1dmU2puTmJEb1lJdURrTnppSFRtK0JNY2RiVVNlcTdaY1BLMjgvRVRF?=
 =?utf-8?B?K0hOVisrVm5pbFJxS2xwaHdXTDladUtsOVVCWFYwQlh6bUJ6emNyUFpQanlh?=
 =?utf-8?B?N3p2VmM1L2diOGdidXhyckt0VXluUnloOW1kQnVwbFU4R1RLeXNMbnRMZko2?=
 =?utf-8?B?WXFqVWIxSExTMHRTOVdZdHV6SGlhYm5HTXJ4VWRxc2NNTDdqdVYwK1owY3dW?=
 =?utf-8?B?WE5CZXp1VENBMG1NY1BrbzFISCtrVVJPNUVQdGpRcFJQTnoxd1dRQlBaTEgx?=
 =?utf-8?B?VWpjNU40a2VDTHFoRXArVXVnZzcyUVZrVWhRUlFUeFV2QThqSkZYY2k0Nkxn?=
 =?utf-8?B?b1BpUlR0ak9LbnlxV1FqOTdHZnJkZzRLNUdvSXIyc2g0TGphQzlQWDF5SWs3?=
 =?utf-8?B?NFVYemNzd014cFlQaVhZaVkrcS9CS3FXSEdSMWFhd2ZpVXhFS0k0SkdUVmdw?=
 =?utf-8?B?WlJ3djE0cXBDaGlZb0FFVmJCMHRCRVJyWUlUeFhOZUR1M2tkOXNEMVJrNVl6?=
 =?utf-8?B?VVdvNFdLTjJOQzRTMEdDRzVtT1pteSt1UTlUK3F1SmFxYUhpdTdud3hLbFJH?=
 =?utf-8?B?YklxeTlQdVJhUzZxSVcxc1UydG5ESlRCK2RiV0cwS08vcERmenJ5Z3FvKzBH?=
 =?utf-8?B?ZXVlcklNMjhBakRsSzBwSlQ0a3VNeElZd1FESU0xRmRoeklIQk1Ka3ZGQnlY?=
 =?utf-8?B?M2RGUmVCZjJ5UVpEcVVieWJXbVc1UGNZdTFycGVrN25IaFd5aER6Z1JZalRR?=
 =?utf-8?B?L3gxczZDY2RXcjNsTW9iSjhDV0ZlTUIxVDR0aU1LZmxhbUV3dkJTNVpaT3BL?=
 =?utf-8?B?czNkSkgwbGphRTNrZkwxZzJzTWhycVE5bE9MQkhvamRBZFlyZ2NXakVzVTFh?=
 =?utf-8?B?QmFVT2t2cEFjUytmUytpbEVQWHM3NStCUlNSRWQwSXppcFdza052QTlKbTFk?=
 =?utf-8?B?cjVLMk5wYjRJUkQvR1oxR1k0a2I4VnZOSXNtV2s1YTBNeXdXR1YrSHNNK1Vo?=
 =?utf-8?B?TUo3UGI5Z0dCSkN5clRCTDhxcXhzRFB0cTFKdVRIbzViemtia0toYTNhNFlS?=
 =?utf-8?B?MWJjbkl5ODlsTU1UM21YRHNaV2J6bDlFRStlRk4zVlc0T1ZQbWZTR2FCVU5N?=
 =?utf-8?B?eFgxNkdmNUlUTnQ2UWNoZmxwWW5vK3BpYlY1RGg0Rk1GS0ZaeXp6S29kWVBs?=
 =?utf-8?B?VW5VTTNhZUxFVFJEYXdRUmxLb28xOGVaeWljY2czb25UajdnRFFPcWRUelRF?=
 =?utf-8?B?dDBiaU9US0NTRjFoNXM1cDRuUURENi9UZ29KUlA5WGI3UWlmb0dEa1R4STI2?=
 =?utf-8?B?bDJFdzJtTmFoOVM5eGlWZzRXT05hWEhodTM2TkFUMTIwQUo5UCtMS1luMjJz?=
 =?utf-8?B?dHZVNUFOQTVLN0NieFpyVjBWWW5nWDBvZFB2RlRXRlBLUis0SDVRanF0QWZw?=
 =?utf-8?B?TFU0bzZONkRNeWVGZHBZV05xNmo1UWdvQXdTOHgzanRmZXllY1lPNHY4YXhw?=
 =?utf-8?B?ekpZaitZaWV1NHF6VGtkcFE5UGtWN2JHNnlhZ21GMk16My9xazZFMHJLQzBq?=
 =?utf-8?B?N0NkdkVZWllxK25QUzRieXptSzBDMHBWNURRRzFSb0lWMnE3V095bnpJRGZi?=
 =?utf-8?B?aS8yWlJ0SitnUmVYeWFLWGtBYnZ6djJVR3NPdy9ncEtLOFlYOUp1YUpjdjBY?=
 =?utf-8?B?dm9DMENXQXFTdGFnOTlWcVg2QVM5YkxDcnRsMjlWNTVSL0t4a1FmcjJOY3o1?=
 =?utf-8?B?YytrWG5BV2hTS1VYa3FkcmoyUzI0Znp0b3ZHR1RZOUtBOGwrM3p2eXBEL1cy?=
 =?utf-8?B?VnZOTVR0aHdvbk1QZ05HSHJBNm81TkV1dmgwcjJlOFR1ZkZWTncwS2dWUkY1?=
 =?utf-8?B?Tmc2bjBGUnY4c1Zpc3dpVzF1Vm5FTkx6NXQ2VzFoenEwdUUySjZldXFiN1Zp?=
 =?utf-8?B?d0d0T214QXN0WHphZ29xdERxVy9Cek8zT3BXVlZWZ3gxZjhrQUVvY3J2R2VL?=
 =?utf-8?B?VFgzdEpsR0pXYXlyRVNTVkkvams3eW1JbHlXU29PUGl0RXRCZ280ZlBPY0pv?=
 =?utf-8?B?OWQvK2dwWFVzTW5pYVNZTHpvZmdrUjM0cDRQbDFrZ3AwVmlRRTRsdHRmKzBO?=
 =?utf-8?B?TkRuWWF3Q0lXbVlUc2F5cm9ORE42S3N4STl5UEFvc1NiT1lPM0IvVlJCN3NU?=
 =?utf-8?B?ZldGdVBwemRJdHpLR2JNenlnNVFqTk9pbWhUTUtReUNIQjZ0OTBwUDJMU09P?=
 =?utf-8?B?b2NLS0ViSWFZTTlXVVdFL2l4NU8ySzJrY2tQeUxyTXZQTTY5aTJZZz09?=
X-Exchange-RoutingPolicyChecked:
	iyga8wq672sQJ3luri9/3MFzv8kCMVz4mIdP1xBJJw/uHMcjZHy2lS8oLdiAkUrNx5ifK1/5xzyLbu5y9TmIOjUb3Z0c2SUOc1WrBuIPnAH3MI2cceEdnmKnLNhAkR2k13NJ11h5MWd0x2P+3oH7rp/G65Sc4I3/Qt3FeJtjFASJSQ/cqyQNC6VvoV6I8SFAgoQfIw4qVg/ELJFdW/eHnfxycUjO+cSnjNYNTOyIoT2ol4rtLFdZhTC9qNhPkjNYtKhsKblrgILOfUf2auzv96HMudCb/GDnx0E89xSBsUgU+D9PlgyQJbsW8QfDuZagco0O0jEnGEaBtOdkGMbrSA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043a6069-5ee2-4ec7-8a1a-08df292befc8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:14:39.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/QrOA2tJZhD8gt09t3UwKet/w78h5/vqw2rsDWs62x35ObfzU/c4VuqEInwbP1vWuA5h25ZGIZ6t0Gwe3TETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989571
X-Authority-Analysis: v=2.4 cv=XudvqlF9 c=1 sm=1 tr=0 ts=6ace2ec3 cx=c_pps
 a=jJxBgQE0Gv9vBhouG1T1Tg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=p_9xqc9CGpcP1yIoJqIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3zKF6Bjxxmzf3QTTTOPvTloOXlzXkJyd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfXy0Xgstn6Z9wN
 ZPed12iiEvJKcDJhcEHcRzux9O7Au6eGiAkHLBc5eZFeA1rOjIS33owOaqbJ6GDsvKa22oTzE62
 elELzfgUAhX7Trjr7zHjeVhNnwAYOFf0+2e1Ko2+KDZ17eHfxQHw
X-Proofpoint-GUID: 3zKF6Bjxxmzf3QTTTOPvTloOXlzXkJyd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX60GUI1QoNyhK
 W91HZFEtEOgpsjRg0dbJ2Ir1vSuqO9VqTUap0VvSfsUmY6V2tF4W+8beUeUvHRMicfG5uJPvhqo
 XTmXuvXm6wIcBGP4cV4l3AW8GOR5WZbQdZGYGF0vCqZBgzjxGYV4Hk2hvg8XSiG6njlvRANL5ob
 p2dm450yPbGl85UZzNf1uyAVrPznDUJ6z4k34c8uQWKg5T3ahm65NB878cq03LKCo5Lyr3PWpEK
 TejMXSiS6V8NhLFFccQ3oSt/WYcKKZcld4ngQM4dVQumFhDsrVdFv0ml8xg6QKwyJQAk252IGw9
 pTpSKh/fyBj1CohnjAQSkeunZbHHVIr0iZCUwvJKD3pGpKYscdNBcOLCgRdsbsDOo18kpSdzO7p
 hcfJNRtxq5PAcb9IK2K76kE1IK+SOLDQ+gWIsrNJFy2hV5lPypFXZnRlFEpU5ixCPFyt0Diiy9o
 wEdURQ+7gFmOOmxR7jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130052

On Fri, 09 Oct 2026 11:43:33 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> [...]
> - pyadi-iio hardware test suites: 41/41 on the LTC2493, 36/36 on the
>   LTC2499.
> 
> The series was rebased onto the base commit below after those runs. The
> rebase left all four touched files byte-identical, so the code posted
> here is the code that was tested.

Hi Andrei,

Not sure I agree with how you split the series. To me, patch 2, 3, 4 and
6 could be very well just one (adding support for the new chip). Patch 5
becomes preliminary patch which is adding a new feature the new chip
will also take advantage on. 

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
