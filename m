Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795685613;
	b=Y1/KJ+QmD38nrQW1hZVms+stGoqlHlmZywC0lzMjbydcz8WN+9XHPxEgLOxpeBGyyMJn
	 SllHNoMVC3JIiY/3NDZwIsU2iL9iFyYZjayKXDOON8ZtOI1q5uslbOLJEEg3lPINCUKeh
	 ZPIh4uUNyMP3Gu6v4fMibxS1leowp40UmC4+1T9w3cdagoNCcvTm/VFXDRb9cOPkbUiWx
	 9FQ0XvySM1Vl3l70e02m/oELrIX2gxOamB6ALeboNjAsY/fIHaQs40qugMkLTFMbirHXl
	 62wXb4+XMIQGTttCk0m5nTxR8z0lTjEHhxgxNaKSk9LUZgkDrS4zWW6aRnTOf/Yp4KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685613;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xlNeuSBqivR8zqk5fB53tD13najAiR5tMZiYlbAs5DI=;
	b=uV0JBHdBdOV8tHKVq+me55V3aZUQf4lwLz3CfbKS3w/DkBgwGW3SOrcLX0SWIXKPGuBd
	 ZbLXYkmH32EJgTLMKOSYRxQzg7GZ+sJgwZvbwxmDUydM1TTdlQWmBRCdYEWnJZQbhNnyu
	 lkdTTJ9NzSk/CkoMLuqfaqM9sIT6Y+TG+R/JQTXkp7y92JOIz7tPZPQ8AuyvxVDaXQeph
	 w9p4Vjor6TiR63+ewtpl2/Hi/hae38RwWftoMzkxFNK9+qwHM6hKJl4k9jPo6SiCqcSWO
	 2BEa4h3TleE4UVcC0MrHAZnq3PLDuN+svHES3erXzYIJ5B75YH3OJcySNAPOXZBbs8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pDRIu9tF;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Eq5+uUN1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96A606A326;
	Thu, 26 Nov 2026 09:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A96A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pDRIu9tF;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Eq5+uUN1
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7EOSc131416;
	Thu, 26 Nov 2026 04:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=xlNeuSBqivR8zqk5fB53tD13najAiR5tMZiYlbAs5DI=; b=pDRIu9t
	FYyS7U4FFpbQkxSb8KSJ6JpkCsnQ5jmkBsYVVitgtHspzRunoLLCJ1lBhD1abV71
	GdzeP9kHR6BaCP9Omdn+zLJXAXPAn0Cvwub9nT3GBQd5zYTqumlt/lv6Hzyvm1rY
	m98y/GKHhRz822aTizYOT24j1gNOajhTCAd60Zg6uDbQzD7nC5haaOzzXgzC/TkZ
	EdqntoWYLuo7lXEhoIjN+KbtPPQrnv/KTwgw3weI3bBHJ3xbk9aClMFNJOH/SJcs
	kqVXapC5QUgaQBerk4DdQgbHtMtkvHEcO7Z/jen1as3A+aFTgP9PSr6k64noEJJ9
	i13mBpYlIBu5yjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xlNeu
	SBqivR8zqk5fB53tD13najAiR5tMZiYlbAs5DI=; b=Eq5+uUN1rbwTde6V240Qe
	yXfDMwKxUtnefKEDUqba+791h7gjSD4QOB4+zIgiLX58KcAowvwuEOIJdtSPd6zC
	1IsHLg+BYfiBtVsodYUUvZpT3p10Jzt1p1unrKlVAPIpAqSAI9w0q/FPGbXedzwX
	T6Y0+tAgrBFb02ATwDHp6yNkOv6+sxpG2GYlCh2W8/qCBA0Cgs78tUUAVF3dRLy/
	HaLN1pbN+MITpFeOhw+yKET0SEcqkqn9jqoiZnLlfUbBYHvKM4VJuSCP6849ckyw
	UaLuo4q7+A36xlf/+eGzNb+HNL+TQs+hXjJYAB02hx+FkQkn1r5z0STH7lP6HAHX
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j6a88a6x7-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 04:33:25 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPXzKoJzTPIqDTECHaGR92VWrNBqQO2luYAv9PJkSq8MNzbZ/HJbhG2fqsJmsz0w19ia3VGrlP5yw2bqrsao6YtPvxEcGAgkzXPfOxpMrnB57+YnzK1eGmIvHarQ2eJo30Wq7z4COVi2C388x20xO3hgUutal02Y6SkBYahCdqU7GM7tHTXiT4JzwcNdImoKhxSaP48iYg/M5ZjpXjk2MWDdG5w3FJAnfw4DhR25eACXQYk5WrWyd8lP2qv8ZHUfR+//l4la5I6lvmiyeJMgk7jCI5KD79BIkc2jWSQzob2gytAGfnV0b9Vh/s+X/JdBIuMuR/vqgsbua+sUvnXNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlNeuSBqivR8zqk5fB53tD13najAiR5tMZiYlbAs5DI=;
 b=UhUeej+MlDBMjloKNnodn9ELBhC5sEiFmqYFX+w6r4tMc93u+Xmt3YIhSw6BG3GhV3bSm5kUiphhvEhCaNgO/hSlx9eUcy2PBl05jOFUx/2FeoHJBnVotTVKxPfG8H5oMVI5ZID33gGH5X1vusjOa3C0dNT9FjNsXp5IwfFrWzyhM1L+xjLtRJDxkPN+Egf9oG9eGRWZea/SiRyRFZVNLXwYiP3G8kS2qj7WyKBXgER1FQ6NT8/LrWxq2UgewBvf2dnCxVdALK9DLP0nEI4FsjbtmOOW62/YJ1jQY6fmXs4GAs4YLDvw0mZtdu7qvkOFyTl4eC5jthaadd0WyIFGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by LV1PR03MB989680.namprd03.prod.outlook.com (2603:10b6:408:2cf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:33:23 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 09:33:23 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ramona Gradinariu
	<ramona.bolboaca13@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] iio: imu: adis: Add a kfifo buffer setup helper for
 FIFO devices
Thread-Topic: [PATCH 2/7] iio: imu: adis: Add a kfifo buffer setup helper for
 FIFO devices
Thread-Index: AQHde04nvmE5V/P0c0yVDjci1gTNfLdAFp2g
Date: Thu, 26 Nov 2026 09:33:23 +0000
Message-ID:
 <LV9PR03MB8414E99CD9D6FC9B0661E808F7422@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
 <20261123-adis-fifo-v1-2-f6ad9e493e19@analog.com>
In-Reply-To: <20261123-adis-fifo-v1-2-f6ad9e493e19@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|LV1PR03MB989680:EE_
x-ms-office365-filtering-correlation-id: 07089106-bc0e-4454-d5a1-08df4ba050be
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|4143699003|18002099003|261009223027099003|22082099003|921020|56012099006|11063799006|10067099003|261026121527099003|261102123227099003|261022075727099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info:
 WhPVPUOnXBy5YYY5I/HVHucl4X7Mk5DCdCxHagV5mstDy8N8fLxUY76Qr3hsjRswBrYNbwylESZVbQubeetU3rgRRwN7SHVTJg5PvjdOpqwcwxhAh57iSq+f96qo+5oWJhf5Gqvvnul4LMakfLdtH5Emc2mPNFYNdLL1+8fIiI0+dLD4CjfrBTVs6Nx61lgz25fyIVplhimoFTqO9GF2jz0mvH9hbL8C2j4lAdkJd9ezTrQafb38dExQE3Lne5kLoG7usvuosJ7DV/F/gNSmCejxv2soLElhxu+fzues0TEEo3Pd0+iGTgl7krixNRE7wuVVUanoqMfmMbIzdBJiGUUM8mg8Wkh74Yf8A8crjLFAFPptLpPzf09Oq7ysRUke/nMILg+nWjr2WzelAJd47HNIDc0DhscQo+HIipEDkJ2BZtU5Ul8vYFnTJiDUfDXA1d5J8zKgiKDwlDAaDry8fnwcsbPySFZZwB5YRHzatBJdyOmkt8sCNjryw7q22Wn8o5OwsJfZuX4bAsQo3nT96mwbLdG4tsMnus2BDn4fq2VH4z9p/zp+NEUWuux2EjM2NEDTq4z3Ob8qTydEIIOjPlZn4YkCZLye9AcqeufVp42Hb8UxN5/+2sozI5xfgWENMlhBmutc49wGtUXfrMjGx1RO0GSzPw54pw2seCGcUnHMahE5SGbXzsddYNjmEXjt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(4143699003)(18002099003)(261009223027099003)(22082099003)(921020)(56012099006)(11063799006)(10067099003)(261026121527099003)(261102123227099003)(261022075727099003)(261021121427099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXgzZFFsRUk1aXAyK3J4cy9CamJMMnVwbi9wY2dWTWhtY3d4cjhXMm5WQ3Yr?=
 =?utf-8?B?VHlqaWh0N29Zc052cW1SYmFOY3MybUhVQ1VabFJhMUxRQ1hjZHNmdE05eU5n?=
 =?utf-8?B?WlJmUmxXQUducUJYNGd6a1kwWkpvSlFkYi9OZmREK25PcVdNTFR1MFhhdDlH?=
 =?utf-8?B?ZHovaHNtSkk5d2FINXdQcVJDOFk3SkRRVEpZV3dmYytRMUlDQmtlNGNxd1JH?=
 =?utf-8?B?VWFZdFJDOGgwcjhUTWdGWFBKTSszUGg0YVZuNXVnOTAzNC9DK0JvcnlCYmds?=
 =?utf-8?B?TEIrOU1BUU4zMmt2azB3N09ZdmxDWkZ2OEUyWmlVSGpSMktxWXMzYXhKU253?=
 =?utf-8?B?LzB5Z05zcVZGZENTUU02eEx1Tm9ZKzMrak1qNVN4ZjgzemdRc0tzeG56alpz?=
 =?utf-8?B?RGpsWnZwR09EL1lmYncwWGtsOTNsdUYrVTVGdzZ2enJ3d0d0Q2g4SlorSkF3?=
 =?utf-8?B?MmdmajZsVXBrcVpXUWNOcEVsa3llcXY1VE5WRk5QM2JwSnlBUk1FcFljMXB2?=
 =?utf-8?B?YWtQUEYyWGJ3K0hJK242RU8xVzR3KzJIVnBaWThSd1pHTmJHM2hGT1FqdFA1?=
 =?utf-8?B?VFZMcERHc3loQTcrR0JVdlFBeWhaU1NDNEJhU3FTSnZpdDBLTHh6R2djTDJY?=
 =?utf-8?B?YmR3WHdsUWNGNE55Q2ZoQ3RnUzJKVGpkZSthSmg1TGIyT1lxVW04VTJSMFJW?=
 =?utf-8?B?c1Q0WkZFWC9vazJGSC9YVkY1WUhBazRncEs1M0VocG1BeWcyamRzSXBFNTJo?=
 =?utf-8?B?dFJlcW9GZlg1cUVDT0xIbGNBSXBZRzQvVWlXb0Z5TnRPc0p2VnBJUzNjQ2N3?=
 =?utf-8?B?L2NVRjRSSFRaQ2J2WXllWk8yVUlYRlJiczdqY0xpZUNaZndiMU9FNEFEUzEz?=
 =?utf-8?B?c3d2U3FadllXeXk0T2dxUnY5N1E0QjVnQm93azN3M3lYL3ZFUGY5ekE2ZWd0?=
 =?utf-8?B?V1phRy9ZemEvRDJwZjF0NUsyZS9EU0thZFBEaEhSQjY1ZC9hQ2tyazYvbVRB?=
 =?utf-8?B?cXN3cmszRjQ2ZTJVQUVjcXA3VzJUdUhLQTY2TWZ3WlVXUUVESHAxVkZTU0py?=
 =?utf-8?B?MnFna1BOcGppMVNJSU92TmpJc2pERGR3MHpVdG1mZnJyY2JHaVgvRFFsdlpE?=
 =?utf-8?B?bWJWbUxMaDg2c2h0cGdjczJHZVkzZE0xcmo4Mm14TmpDNStkTHlrdGFsYWZB?=
 =?utf-8?B?YkkxY2pZM0dSaTFYUUIrQnNsd0R0R1gvencrZTdTRDFhelFxSHptNk5aQUFI?=
 =?utf-8?B?c3FubkZnc2tNTGpubjVabERNSmZ4NDRZZlUzSDk0TlFYa2lMMlJlMzJlSThz?=
 =?utf-8?B?eS9vT1EwUzRRcUJxQW9xNHRiUjArbUw4YUV6TjVvTmlkb0VVOXJsYUNmWGk0?=
 =?utf-8?B?VjNuMnpKM0dCcHVyN3hiay91TTFqNzJSOWxHdGZYZjYyOW5MMlhLTWl4S08x?=
 =?utf-8?B?OGVadkNjTTdTRE5RY0IyeTFZaEU5cnVKQ0dOa25zK2R2ZTgra1dWbmtiVXN6?=
 =?utf-8?B?ajQyZ3dHbUJNcnd4MVRWSFh2OU1mblhMeXNRSURDTHAyeGEyemVOZWpPTnU2?=
 =?utf-8?B?M3BvRS9PZUJUSmZsc0xtN2hkL2JUN29GTW9MclpKd2cwVHVDdHcyZzdrZm1E?=
 =?utf-8?B?eWNvNlNGYWIxbHZnRFZJc1NzbkdIbGc3OHFZMjJSeStlakdjOHVBZFJ1cGZm?=
 =?utf-8?B?eXpuODE5Q08vaytvcHc3N0VvR1pEanB0ckFOamdSMW5Kb0ZnaTlkMGVJM05G?=
 =?utf-8?B?cjVmeC9LYWxadW5zcDViSEtaNFpPRmhnajFMUGFPbHQ1MUkvVXlvVlNscUZY?=
 =?utf-8?B?MWNxYmZHenYxS0IycUl5NVZmcnlZdFYvV3laaXcwSzNiSzh4akxjZE9lN2FY?=
 =?utf-8?B?WHFDTUVRb1VEMFZDd2lwQTNVL3VZRm5lNXIvYUJ2aVh3clFNUzVSMGRiS1JY?=
 =?utf-8?B?RXgrUEJFdzI5QXZ4enVhbFI4ZlFRMmZXV3J2Y0tXdm51STF4bkRleVhRTWUw?=
 =?utf-8?B?UlV1eStvdnlzL1E4aDcvbUx3UXlsMm16aUgvVnBESGRZaVdsSVZvL2VUUHNU?=
 =?utf-8?B?eUFnSXVmUXVMSFhZRGJhMk04QlJ6T2ZjNUxQczRyMnpxbXpmcmNEWGlBMGhV?=
 =?utf-8?B?VmF0MkRJMjdXVjJra0VQcDVvM1JteXdQUHNCZHhEY0N6amNjYXdTRnJ1Y2JM?=
 =?utf-8?B?a2xiYUdCMmdqVXZNNDlBM2laeUdvaEVUOXhpUWhyTXFvU2VQaWdQTU1JQlZS?=
 =?utf-8?B?QktIM1JxNW9wQ21qUVRSMDNLQ3d6R2ZYWENMMDJKRlBIVTFqUUVlMHdTeElB?=
 =?utf-8?B?bUZoRFRwOFdOTEw2YmRZOVdiM0RreW1FY2tWbkdPWTlnSkpkVC9OZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KLcr3n9BP0ZtqaYOzqcLiGXtOL9L/ZkyAj1Z/sCC+uDjMNlXHcTpek356eNiHvlSOsuH4OUQKgSIy4XW+b/GiTQrzl0nZkQzMYqVahGVDaXvLUNFnQsQMvh0OtfiP7EpnBrrUrAwSWa7UcODAVcN3FwZ5Q8P7pojC6UE7C/Wdr9q83QUfpMCsognRLja4yi7wAR7nlipDdxiowP64rFDYRN0ne0+MXc2Tyl53Qwf1rjzvISpPDg75evOH/djSeqxFWbzWsdjBYlHdDLSbcuhpFAfbQeliVN+3FBUTtwZ4g6DnVNjrLD7Fo2xpGLcWqrC4dN76AqUYfmFv4qW+4rM5Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07089106-bc0e-4454-d5a1-08df4ba050be
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 09:33:23.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZXrgsQJBJmu3qrRYsiu60jKfeRc1OcyIPD/q7MLaEdG9ZouwOtJTpqbLka7JhYy/OCMJObYT+1taHQPfleEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR03MB989680
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNiBTYWx0ZWRfXzmSMkR4a9T7j
 Tor37bjQuCe7FwKb2wPTAEi4bgUfI7O9IUOxwnBEl6870NVBPk3vLCePUN3aKXF2Qw5F7T4bATa
 S9697UwO3CqViK05sDKkP5yLYi5LiACp6sb8h8wpBfcU0vKuVbTiSIcDOAxGFuKBPBqCkfl55o5
 26tKMaseD1gzhshYgKUdCOU+OM5kaTCsr6AfBeGcYL2Xjrw3nvMLtERYpKOyLO4JX8r9fS48Tfo
 gWqHjDdJuwko09SSXciZWVDDUzSutqJuAgQ8vyNXBTZldFZhPnaurk4O4vZ7Uh/l/ZN0oXYn6Wd
 mqdCwDwx2SN/rF4o/oXhpANbGecq+Oz4tqnK2y4x0eyIw0tTJYO7qhjy2Bkc1NAwsSfLkzqjjD0
 pdyl+IdkalknM/aYcKh00/F73VsNfgglQPlH+mQzoqhtsZ3G6McfRscF0DPUEGhk7NzkVhu1kNn
 PUNzTy4/43cAPGVZgrQ==
X-Authority-Analysis: v=2.4 cv=Dp/Da2/+ c=1 sm=1 tr=0 ts=6b07fce5 cx=c_pps
 a=m+Y8nsmXU8Fd5URmI4pqsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=iWsGfve4EsDoUcpbHpIA:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 8eKwF2p2YuuwRpZeEeg_eDdV0OAMWrty
X-Proofpoint-GUID: 8eKwF2p2YuuwRpZeEeg_eDdV0OAMWrty
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNiBTYWx0ZWRfX7AvnZ2CPZ02O
 +B+Od29zmBlMdYv7wXAAcm7ZuAuJYeFroQYwgwbdek2axKTnvUhUcYgtFZ5+rLLfGX2kVUKWQcY
 FeIjZqNANrffHMiPxhRXbE7chQtcxlEZCcU5og0RAeTPnoRtb0uL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260036

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
TW9uZGF5LCBOb3ZlbWJlciAyMywgMjAyNiAzOjI1IFBNDQoNCi4uLg0KDQo+ICtpbnQgZGV2bV9h
ZGlzX3NldHVwX2tmaWZvX2J1ZmZlcihzdHJ1Y3QgYWRpcyAqYWRpcywgc3RydWN0IGlpb19kZXYg
KmluZGlvX2RldiwNCj4gKwkJCQkgaXJxX2hhbmRsZXJfdCB0aHJlYWRfZm4sDQo+ICsJCQkJIGNv
bnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29wcyAqb3BzLA0KPiArCQkJCSBjb25zdCBzdHJ1
Y3QgaWlvX2Rldl9hdHRyICoqYnVmZmVyX2F0dHJzKQ0KPiArew0KPiArCWludCByZXQ7DQo+ICsN
Cj4gKwlyZXQgPSBkZXZtX2lpb19rZmlmb19idWZmZXJfc2V0dXBfZXh0KCZhZGlzLT5zcGktPmRl
diwgaW5kaW9fZGV2LA0KPiBvcHMsDQo+ICsJCQkJCSAgICAgIGJ1ZmZlcl9hdHRycyk7DQo+ICsJ
aWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCWlmIChhZGlzLT5zcGktPmlycSkg
ew0KPiArCQlyZXQgPSBkZXZtX2FkaXNfcmVxdWVzdF9maWZvX2lycShhZGlzLCBpbmRpb19kZXYs
IHRocmVhZF9mbik7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4g
Kw0KPiArCXJldHVybiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoJmFkaXMtPnNwaS0+ZGV2LA0K
PiBhZGlzX2J1ZmZlcl9jbGVhbnVwLA0KPiArCQkJCQlhZGlzKTsNCg0KU2FzaGlrbyB3cm90ZToN
Cj4gVGhpcyBwcm9ibGVtIHdhc24ndCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBjYW4N
Cj4gYWRpc19idWZmZXJfY2xlYW51cCgpIGRvdWJsZSBmcmVlIGFkaXMtPmJ1ZmZlciBbMV0/DQo+
IFsuLi5dDQo+IFsxXSBodHRwczovL3Nhc2hpa28uZGV2LyMvYnVnL2xpbnV4LTk2NmYwY2Q0LTQ4
OGEtNGQ2OS1iOGE1LTQ0OWM3NTEzNjVkMg0KDQpJdCBpcyBhbHJlYWR5IGFkZHJlc3NlZCBieSBM
ZWUgSm9uZXMnIHBhdGNoLCB3aGljaCBjbGVhcnMgYm90aCBwb2ludGVycw0KYWZ0ZXIgZnJlZWlu
ZyB0aGVtOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvTFY5UFIwM01CODQxNDM2MzlF
Mzc0MDhCMjlCOEExOTM1Rjc0NTJATFY5UFIwM01CODQxNC5uYW1wcmQwMy5wcm9kLm91dGxvb2su
Y29tLw0KDQoNCg==
