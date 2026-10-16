Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578645FFA3;
	Fri, 16 Oct 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142497; cv=fail; b=HYsrpH3gM9ykR/HgMCQ87TqA7YgLEI3au2a8CumgEj2I8C/3YARcar117HeXBvcTKREdtvIMrp2oGFjdsVG/354SJgVhTqNJx2imsKYmZPojcfD1Hnu4DnIDDCE4WObGUVFNb6NaQYO5yXKmqe1ZQptOAJAAaX+XYQlsqD9IHQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142497; c=relaxed/simple;
	bh=mo8JjhEmJvEezLEe/DijwZuUvfB1N3vBb3y7hO/g4Hw=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=C7g9D1U16j4LeQ4JMvVTPX7oqvHXqabjWVTwRmxTTzSwyNtQbR4lxn9BBuY0o4H/gJoxcPQqa22orDSknrJBkFzHcCBj+M4uDhZ2Tqzeit1CbSdSGVT9ygOastUi7KUKz5whJJ+mc/PP+NYPOR3vDST3/ImbZRJwFbVJrPRpsx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Rz7xda9J; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Lg8KxYG5; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Rz7xda9J";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Lg8KxYG5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G7W1ce2303887;
	Fri, 16 Oct 2026 05:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=o/vRhtTG5DUQ0u1O1oviZlb2R9bvsz/05Exv3W1Zh/Y=; b=Rz7xda9
	JopX4UDTjYgg48//yDUjgooh0I7/38STG+4fvPKEdzavrHpku45M9TG74zI6/kKh
	wtyiVlNtyhgHuDfB/hYsW7QxfXapGzcm4mmilNs7EM2zaG/ItR9p/C8k+ihJDTz9
	wWBpNokbgAGEtWyY4uXCXHWFmg8T5c2n7Niykj77ufRIHnJ3VBqByRFQWAIKgVp/
	QoUpuhjvQJvjrB87MRzygIzciPK+UIxpmYBI88rQtFsooorrL+xS10Kk61D+0cgC
	LZb1PY1ZoRjTKDl2CqO1/DR52ZIbcuwWjhyFpHkbdM1lKxyALR1+sG87kP+6a86Q
	mJUbRdjXYqUfrkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o/vRh
	tTG5DUQ0u1O1oviZlb2R9bvsz/05Exv3W1Zh/Y=; b=Lg8KxYG5FL9OXytH0FY0p
	wuVIssZaEP2eq8YXCGWK7skYLG8J5gnZnDV6q6ZTYxLtO8ykSJowjlz9kZ6+Pfk+
	g3M8OvhbdT2frQfDopO3ajdmBP+BwynXU2DoUUfJjsbfoos8swA1KfE4WHwsllf5
	KO36lARqUK6azUF+mRpz65PuOyulaNEv82BOnw1JzdEWMDcyoW8/AfrShKqIdg+U
	ygxX+WvoEFE0GVOmkRvc4+OSENIfHdTYuwTkSNd/jTUqVTauo1GNtQrpvY9Kf8XY
	DXSU0U2SJfIEdMeuwsrJU0u6JCMwt6Sg2JuvShwQQMzFDbmAOb7hqbSKeaYkoPgV
	A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hannd96we-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 05:21:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mkjy6UqKzIW6nR4rIEgm1Ex/pw5wuD8DWX+ZtOq5xEQ29fss69VNWvWD9OJSiZ5+SPrSKUkf1Fm8psYJ6JwlmcZpM9I5fTdsD+Tpe/FB9leigdUfyXJwgjY7r3utzLKwOHDpsHnFKfRVBaBRyHsfGr4HwY98qDSwQ5gLzrt2UxWjHHyhB7t/VXyJ0a0s0irfaVycoE9lGAi1E60EeoUi1oYVgZ/TuggT/4iOYLcAgwQee7+INS/HeHmEUeW2uUamb2e2fKoV3G5MPFEA3plV/HLtMpYnMi0cD3XhXe/gtno8yUgtHQj6UXLylHR3siFFkNmOJxOgwWMUonp1JxxzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/vRhtTG5DUQ0u1O1oviZlb2R9bvsz/05Exv3W1Zh/Y=;
 b=UBgtSylh86oCGjplo7SbdSXPPUlpHJB67qZW+VcN5goNku+3maRjzfqmN0wEKlz2aE+Q6rjYCwUCmvBANBfjj3JA9BxszPyAtvgdChUdbd2yQ+yZvnGQY14U1c8OVEBV9zxakr6s1UH2wsY5NLmMsEIQhNj5ItYkwUhFLSLMtI4z6GFk/Ss54dPDPhcLtvVEG2O2o9ew1L4wA7Z78DeJ5UEe6XkEECqiof0DK7xEtB2hs0tckEo/yBTAbjtrZaq8jK8kq74FnEAkR5+sQfg2ah+v7hmOfcUTMh9eH8StZkTSWvozNtBcAAdf26Swbesphr/xvmy6D1+/OIPg40IOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB8138.namprd03.prod.outlook.com (2603:10b6:408:296::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:21:16 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:21:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] iio: frequency: ad9910: powerdown fix
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
In-Reply-To: <20261015-ad9910-backend-support-v1-1-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-1-3c21648c8e26@analog.com>
Date: Fri, 16 Oct 2026 10:22:34 +0100
Message-Id: <179214255491.3322.7042554137039072452.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142556; l=556;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mo8JjhEmJvEezLEe/DijwZuUvfB1N3vBb3y7hO/g4Hw=;
 b=2S4UAloAzHvWtj4EjjtA9MqfTMtZKe01PcITuabIV4X560rAuhG0V7yp08ENjm4njqJxBWpu9
 Zw1AFoluViwAOooW75Djop19uQmOYjzl/L1k/mM0PfWP1hLMNxwKG4p
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR2P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef5eb79-2ae9-42b0-9601-08df2b66d487
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 IkpQa8nxaB1dozSs0s9qUqnyDS5vVL1x/DMLwSnpK0i+vZeuzP+9m2JmOYlgQ/XYRZ622ZBvdLmqJqiETqpeCXhlev2jmoGD+9eK/KWpVW8OVEEHg1n3ZXt0B7yCa5O6IaE88+mjBWfY80I3uQoT82fX/FB4DxO7QQuKVt0hhJEapqQTJFep9W2ktaWnWE5OX8hFXxqikamJAynjc2toCHIszNpvMa4bzprIDyshn157FVgCuaH83R02mAogK9L4gUer2cysdt4DOEiT6F+76SeSkVHc8ic4OFx7qIyj6KXOoxC6QMcadRdipYFkKL3CE83zpsakfQLu1f22YZSz083Q3w/hvsAoHHD0a3G5xlXh3S1W8eE0X4npifajY3xNDGtMfNqm/pjgt9+V7lB2ywkuYBtFgvUJtzmDTAqhGYfhJmxUIXteHhImXXdW+Po4BC0axGBs/uDUUYJS4nsY4Lj3HfpjW+4aAGjUFa63PhyKH65BFXPs9mDTpI3SUosCvrXoWOC5RIFkXqjtr+LCsD/sZzKprm4OHc8+quEUOKKjntt/u8MdgcJ1lc7J7ehPE31m5NTU9RXAWVx3Quxl+lZeJEQSuSuTJAlerQASz/h+s7pJktsKxffLuSNoia8PX37lSa3U6VDoxMFOlBZve8aZrY1pj0NdQ3hNHqYjNG8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VHVPYUJPRlhUcmRXQXZEY1NQeEVaeHdKZTVPR2pJVEh0VElna25abDRBMEpl?=
 =?utf-8?B?N1JwRS9lRjVUbWJtb1N6eDlGTkVJOUxVanpPRSs4aEVLVmcwK0l3OVBrcGJs?=
 =?utf-8?B?aHR4R0w3RW9CQ0NKZE85WWJFUDFKam1jZGVNT3c1Y3Z1K0thUmVzaG5qQ09W?=
 =?utf-8?B?aVZKallqaC9ROW9FVlEzUXBIRmR6MzdrbUltaUE3S2k3SXJHMTg3dml5bFYz?=
 =?utf-8?B?bSs4UDFRd0JhM1RtMmtldUVrbWh1cS9ROWRhRFFrMk12UldTSzFoOXpHRDBC?=
 =?utf-8?B?SXRRUlBJOTgvTWV4dTdsZkQreUpxQVVjRi8rRkhMZ2hiY0xtRVFlTmVkZ3da?=
 =?utf-8?B?dmdIbUhFd29vZ1pseXJqdStJSFNJaVE0c1UybXl2K294SkJNZGZ6VGFlcWh3?=
 =?utf-8?B?K1RZb2tWMjc3TTVpek9hWlBqVHIxZ3ljSnlRQ25RSUJuc1VIcG1xb2x5d3lO?=
 =?utf-8?B?SS9TeFEzR1U2UW4zM0owRE1Ua0p4VHA5eGFHendOcjJ2VStXeWIvbHl6T3p0?=
 =?utf-8?B?UHlHVVZrRnVBRFR3N2Zrd3QxaHVCaWdPMWk4bTU1Vk5IU1plSWFnUjVsWXYy?=
 =?utf-8?B?UERaWlJyaGpkOTVIY2V3TnFadTdGZjJEUVpPaWNoemRpZW1PVko3NnRiejZS?=
 =?utf-8?B?QVMzUVlwZ0toRURqNTBHL0kwZ1JFcGFncWZQeWRtbHRGK3F2NEIxaU9GMndD?=
 =?utf-8?B?TTFLTERld1RWc3ZRUjRyd3VPN2hQZEc5aE4zemVrbmcyQ1VhMXhTZVpjRGZw?=
 =?utf-8?B?SldMN2JvMmRTMkNIMEFGUXVqMGNEdGpjT3dMTFIvV29sQTRpOXhvQjlRV1lk?=
 =?utf-8?B?LzlNb2RJbnZ5VGRFeHVKdm1VQnhpSDlkQm02WnB0N0p4QUI2MFloUVJmOW0z?=
 =?utf-8?B?VkdzcXcwUkRtWnd2WWt3QmQ1eFdlTGFFU1B1WGxnb2lZM29YVytCaElDVEVB?=
 =?utf-8?B?UW5tZk5TNjQvNmptT1ByMWZJNkZ6c2N0b1B4eUFSUG5Zcmw2RTl0bXpmeXVx?=
 =?utf-8?B?cjlWVUJqSE9ERHRIN3JTdU1RMjdFY0E2L1pYWlFrWStVOWNYSWJwZmVlRE5P?=
 =?utf-8?B?OUFDMTM1NzNHWUpaRGxkbmlKMDdQS25WT2g1cHdKbThGd0daaiswQTRpOGVy?=
 =?utf-8?B?TlVLbVExVXk3dmJOZ3ZRZTZWT0RZNHFXV3diRnNmU0pPQVEzdVl0dERpNWxI?=
 =?utf-8?B?MzFWUjY1MlhvRm9Fak1CY3EzcVdhV0xhUDZ2dDJzR3dLaEJRREIyTk9uMVh0?=
 =?utf-8?B?U29hTW1RdldkNFRuclNNbUxtcGsxQjdjRVZKT0RtL1dpYXphMVBLN2ZjTzh5?=
 =?utf-8?B?NFU5WnM2M2s2VFBkMEwzelJBemUxTisrTFRQU1Z4WDhvbkJwc1hJRGg4MllY?=
 =?utf-8?B?R0lxN3k1Y0lDOGtJaVNTVXFYTm5zbXZMMTRCSHd6OU5kSkRqWktYQk9PM1NR?=
 =?utf-8?B?NG0vSEc1Y1Racm5jVlAwTjUxTGNzZHN3V3VHYzNHSHQxa3lJa1JRRjdDNmlZ?=
 =?utf-8?B?cFdrcDZwbGNzUTFuTUpLMk1NVlhHYURRYndyVUd1T1ZCVmZRemU2OHJva2Q3?=
 =?utf-8?B?c081TVp5NjdpM1g2ZmhhVWxodE54ZHFxT1duWGJQUDJUZTNGdTJWc2t2M2Vj?=
 =?utf-8?B?QTZBVVZjMUlDanU4aFpVbm5Id1FkK3hVNG9SUmtTZlc1OGlQdGsxYktsUkZ4?=
 =?utf-8?B?dFdCeEprWGc4VHd3cDJvOE1sZUhQNXE1blo0RXk5ZlRhMzlZaFBiTUZ6ZHN0?=
 =?utf-8?B?aTBDeTlhbWdKVFp2eURVUmZWR3U2UnI2a1d0aE1PT04wd0pnNm9LZ1lNUXNs?=
 =?utf-8?B?b1RINFE1ajRnSjU2a1B3TU9BYStZY2Jjb3YyZkI3ZENYNGtvV2FZSzBuTUNS?=
 =?utf-8?B?UUhLNGZpV2ViUmNLMlN5UVl1MXdPSG5YK2RsUmhWWGJyczk1RFRVT2dkazR6?=
 =?utf-8?B?TkVDOHl2NnZjR2xEOXkxeGhWRDRQUElHeUVaYjFlVTFkeG55QUhkdVdwRE50?=
 =?utf-8?B?bFByS2hObXhYU3pLVlB2L2dRZXdSUXJMM3gwMytqOWhUYnJwZVBsSmZBeE5E?=
 =?utf-8?B?YUEyVVdyV3FKOWFISytwbXRjeEw0UVJFUjBFc3VmazRGcDdQdUhROFVVNDFQ?=
 =?utf-8?B?UE9VMTVVa0xNcFdxdG9MSENDRm9EZmdnWnFzRExwTDF2cHdUMUF4b1Y1dkxy?=
 =?utf-8?B?SmhncXpXZGRHUUFMV3U2RlBiZ05Bcm9ka3pRMy92YUphS3puNElncDZsRVpN?=
 =?utf-8?B?L3lUYWNkSkNsRG15eFhFZHdvMnJCM2ZyZG45Sm1ManZaSEsrZXBTS0dxWTVz?=
 =?utf-8?B?ZTEreUdpSXJiUHkwdWNzS2NJa3hMM1Jad3FvS2lrU1RFb1FMQ0NtQT09?=
X-Exchange-RoutingPolicyChecked:
	QovvqfxGiL51EMEg3CtYr/GgsqTBB+U2IRAM87cHgnRAEFm+Q9pmN5ASET5wVkC4fqpReNeD43P5gUAwzcHw0X4rZgWT0RpZZ520rHZEe2BZDg3X3jrJn6IkznVZGm07jzzWOh63V/4J3X9u1/eJKxPHjUhvZZGGXhAQ05bH9L395gwSGEAodI9MwjvZmfrcX7ch1Nl/AOQGKKoO46Jbdb4ghfA7bwmA2n/O9A+dWKqxT2/LcAyxnUgcMxLcV5wRd3JHMhMl9UtOuOhuSInIEilgeXtNCQO4f0+ikC8HvllkGk89LzoELnxaeBYwnTCO4a+KmO8VSPZi1MjuvlyxQw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef5eb79-2ae9-42b0-9601-08df2b66d487
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:21:16.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+3NnAnjIc55OPoupeoUQgBLatK1Ps0v2Cy8+OrE7roZsjf0UZylVRjfA4lwkjU2E15iiFgOzwPz/3imw2YJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8138
X-Proofpoint-GUID: JPTmMwUkzyny4oCIanng8yHHVIebBUWy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfXyvJxbaYNfULg
 z0y+4HK0a12MBtt+xjJaZJjcCFOxIjztGq9BCZvUX1zqXdZv+h8iPvccFmKRKo37HATUapTO/QL
 VNZ6dLto9UCySsFTxtHYZ2CSCqL0Vt47oPRbj1essysuRzx2te1b
X-Proofpoint-ORIG-GUID: JPTmMwUkzyny4oCIanng8yHHVIebBUWy
X-Authority-Analysis: v=2.4 cv=YfkodARf c=1 sm=1 tr=0 ts=6ad1ec91 cx=c_pps
 a=SpR4UuZ//oCsNj7RudjQzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=k4BKyfu2QfQjGJzlpiwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX95EhOq2eZDdP
 WDE93N6dc5xEL4ytcRqSPp2odoJcbyOmGGy+M/k4DxlQ/Io+mKdAwWFeEqapXDfBC8L1Xa0F5gs
 YUPVzRTGrb9N6cb8oLz2sqmGY1dX7c2UYHvswaVKbykVwo6iM0tOdBuBC0W7Jpn3WCBfWJ3MyWq
 sU1K05Wm7E9dOiCddj8kh3k+2fW5rXlq9Bv7WmHtdRzF6aWThubybuc7957iOZQ5cFYRNlRyZXA
 xVKyvS4icSTg7OEnu92Hw31wZtJsoNDxxiUwVb1oaOp4JENH012VxW1xSZ61AfnTovT+pgT/Ci/
 7Q+5Jkarj8HTsdVflFZZkjdyQhTcz8b3wtmWg8/M8N8yDN+ImD/wLHPpF8BA5/GUkwGlNqPzc8h
 o27yWrk1iu0OWzPn7e6qYG1gb4ucaUHeodPetB4Xfd28Gi7zLnFIM/p3qTEtbwO/Ih6yuaX0RUK
 iUqoDmwslc53Ed7gK3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160037

On Thu, 15 Oct 2026 13:49:41 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> Enable the software powerdown on all the applicable CFR1 register bits at
> once with an IO update.
> 
> It turns out that DIGITAL and REFCLK_INPUT powerdown do need an IO update
> when enabling the powerdown, but that is not the case when powering it up
> again. It is an asymmetric behavior, which was observed while profiling
> power consumption in the lab.
> 
> [...]

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
