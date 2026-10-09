Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5938D3F2;
	Fri,  9 Oct 2026 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561208; cv=fail; b=IxBY63LOPIqXhwq3QSg4WMcytUSyPIN4Ndh+MUbiELZ8PlPKLlA2H5BXOZ8ppLDnG4Gg1IlCf/dkDpsv7jN37CEwckoReC2VI4pax0LpaQeiT8yC1tMoponRJpyevmKfuuOCGB6eD3KYsvHFPdmXgOHGo0hLQOiwhDsUs/l+f5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561208; c=relaxed/simple;
	bh=/n+WDBx20QO4Er70+RT2lKRRRDLHoVsdYcArq3LYv/c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mUpDjZ474AzPDXTDZsssqnX+Ss1yLC3Jd0s5gxQpIWVpNBvbu5Qmj4lJy1iXWlSkE2AFEtZHFFyqQzTUw670CSzR/giHrtzlGzroWptSAwTLzALtVDH6Jri1YInMWVcM26Xaa7n6U6sV91TxNPA9Lg6AZgIzbWcnoghnZYlmDfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=WKHOJ4IO; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eNGlxcDW; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="WKHOJ4IO";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eNGlxcDW"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DN9vO2289188;
	Fri, 9 Oct 2026 11:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=LeGvOrKxZvr0Zc6p6AXZjMdb0buoI2wB8hod3dT8OUI=; b=WKHOJ4I
	O4k0VeseWmCP+mLSTDMe9xT1k6t2SMOkeRLiy+Fu2uLgmRA+UNN5M8B7sxv16ovi
	FU/dMcArW3jwUgld26sO9C3ljI22SRlIMY7KXxU99T+qtun7NEptV+BAwKXOaNBf
	E6JWZcdH8qO/rtVCkK9VZNIbCoRBENtGVPsQZUXOsAtF34My5sRTRhMusPogJ8u1
	4geBVB8rOX4FoES9E5x+04i04qu55YPCh96EZGxYUQy/RArqzuT4LZJH/QvFxtkX
	ztSZFGl9L9+8mLvfWIZ62n8t6gJBePgTHqOWYuMhvclLKKOm7tRxo3iL5goXqig6
	e5bQk2FdzXoKETA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LeGvO
	rKxZvr0Zc6p6AXZjMdb0buoI2wB8hod3dT8OUI=; b=eNGlxcDW2AKtXo9Ra7/fH
	miRZ/kvVd1ZgoIt603An/4wN+aXaGmFzBvyauuxibMoIkbhqiS3JZEugeyifRCCL
	v9fAC/VUgN1Bw2uqhtFoH1sbp0ipgAfZpq6nFyKVfPTK3THa8vdL39PtLPBQUV8+
	7B5Vxokazky6/jt6kdfUH3hOCbmv6HgNH1dYBGnh49N1IBO0zpfAHtlPgr90C4MJ
	gny8AKaWS0+fKRjzcgtTbPv/6QNvsVu9+pp5RzZzrc4mIiMEWGr6ZBwbIICACmpH
	XBz2+DIcIIx5wxNf+2MsqzxbgI0Kj2VdMTUMSpYj32qqnrDIEP0frCtg2zchkeid
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h6kgmmvam-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:51:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhgsP874buw0DRM0vRjb+8W7SMOJIyXcFjnOBzeBmnAPbZRBsSTAR1zKaNp1hPUgtq2LvjcazK6pStkYzkPs+ZTKm5OPcAVtcxCeQAcpoVe/oQY+Iogovh8A2HE8pH1NLMHAiQwcbS4SKVhzi0MFgixoW7vU3TomMwPTVMomtT4+n+ylwdLwcIbrb/s4RLOuhD7UNhiKMrMgXlQa++CzjsEcP0BTlBJsHQlsy09J17nF1MDW0bM8RuTDYe0celCA5vzhZaRaZBgQNcu+pgPUJ5MGtxsvOWeuSUCHMZxVz42cS777s25WQXma8jMji+VSHcHi0QE33AclH4zwGY0mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeGvOrKxZvr0Zc6p6AXZjMdb0buoI2wB8hod3dT8OUI=;
 b=R/ND+2nqXMbvQsFJDLSA3AJtwxUuyOUrl5KRW2+xs8lwNj6AylgMayKUKG/W9i1WE95xXL7vkpr9dhpGQGZCgc8nyd2HSIkQLXBGc1acsUrAhhk8xf4OEls+2EVCibEzi/mV0r4TDm6Mb/Y/RshDwZPhhuZ6EuLujxyzanC29R4SCWFm4xp9Bfm5wR/NICJb3GCDPafZhk0U+nObkrbuPzjjUfLhgXCa2bw2LcY/yynyw+bK4uuUbc1+ScqXo9SY8mV7IG+p8iygfCPVTs5OKkx0Tu381RsJbJkH6fbfGRYNwMPjSeGZMX6blB9Hya89mWyt7XJV7Id5/42ABGPvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM6PR03MB5051.namprd03.prod.outlook.com (2603:10b6:5:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:51:41 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:51:41 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 09 Oct 2026 16:52:54 +0100
Subject: [PATCH v5 2/9] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-dmaengine-support-wider-dma-masks-v5-2-4c4e63a7a1af@analog.com>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561175; l=1830;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/n+WDBx20QO4Er70+RT2lKRRRDLHoVsdYcArq3LYv/c=;
 b=hhE6wbwzwgzivdIzVAxjjnJuNSmdvwgu47HJ2o8YyhXWisfvJH2rXEhvR/KAK7RGdFT0HSMPE
 8kaRz6+U8YpBz3xRy/cp868Fssl3QlnyjeWyJqNmC0c+1pvAz4mIhOR
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0012.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM6PR03MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 401a3d79-3f2f-4e3f-646f-08df261d362e
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 LPsWrMq9uDjRDvJsQ4b6pL3r/rHGYiStPS/93nFrm0pCSCXJKzxnPxrqMCUtPdBBi2XgCYXRRGtn9mOuR8Q+cjMcy8dUXJs8Gz6KW9UAiCxBNTLv0ptGtpyakYQY5KP8Jc8dZ/XCWx+Nb3oS23UC4U5rB7496qB1grUT0lAWUkF6D2I3t6vAR9KLUmruoyopKOGgcpYPmKa9xOyDzg1c/zE/Y/kpWJqPao6FoHfK5hQf+ZBWvey4YC0u4gpsB6xtDoN3Ap7pa9FHjFmxcV7hD4cL26kJd95Mkhy20T5nCyNt2J/BdXNjg/vApXD3Jm4O74slpsfIt/dp59+SLtpDvtpwKrlVjnbK79s6dXZbncXvLlFMDK3XFOYjs8Kupxdc/xE9sRNjmdCku39enzK/pTdadGyUq8F7kPYHHmmCN9/0Uuew7GIRdIU0mdxLrvmekQGiyQuKC0sNgFmGx0/UIS1fNscc6Yq202bwymc7T+hEd9R/agXzo3HgGjsT0hqkZOJTkxLGxvXSOVedJxaCbBuwUYCSY8XtvZfxwf5SevFbj/7ToI4fuULYBh6ApqL4dePlby0rrbsdTxuP0k93ckfjuW1vY0BOQmmoQw/ikwbFuOJpLyus7cE2dakhkld/LlaFiZfbDthCWwfKvEl5PEqrjyWdF+OoB5h0PZPy1eQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aEVqemJ4NG0zcUY0V0tOY3JlVmw3eXQvNElFeER3YUZ3bUo4NDBZTVpZdXdX?=
 =?utf-8?B?eTVld2xXclBhWFd3WTNkMXkyWmNmWGpJWkd4TXBkZXhMalpVVHV6OVcyekFw?=
 =?utf-8?B?S09qMHpuRWhTbk9uSEZIaU00cENuMDJYdXMxRjNVQjlIMUV1dmRoeGE4c25h?=
 =?utf-8?B?alpLcVNXcGtnb0dnM2J1eEswTUJrQUY5cXFpNUxNOWNyNXhZMnEySXdadjBZ?=
 =?utf-8?B?QzIydk41MEhjTHpJdkRPcDFvTUU2anBiOE44OTJic3FraWJKem9wTGYxZmk2?=
 =?utf-8?B?NnNGWThFT0Y4S1htM1ZxS0FMY2pJMmREcHBNbHdyTHZoa1k3UDZ5Unl2N1B3?=
 =?utf-8?B?cmtBeXJJWFNwTVR6QTdoNGg0T0h1Z1hzTksrZk5VRzFFdEtjRGNQRXYySzVV?=
 =?utf-8?B?LzEyUGtQZXVuSmFTRzlyMEdUMWplSUxZTUFiR3ZBOXVaZ2hoR1pwZGUzclVp?=
 =?utf-8?B?TG5GNTVVT2dpQ0NRSmpxa1IxYmZlTXNDQnNQSEE4K3N4d2U1aFdqcXFHVnQw?=
 =?utf-8?B?ZlNBM2ljOHRhOGpQRjNRc2FIRWhza2w2S2VFeGVSdGtvSlB6cllhWWNuWnRO?=
 =?utf-8?B?TjFNK3QvK0l1dzNDNnNlcTNBSEtIK0dPQ29zRVltaURCTlk4TWgwdHBYb2lT?=
 =?utf-8?B?WUVaaHFzdkswdXFGYVBteEw1Y1A5WkpNYVZpdW1GMTF0S01UKzk4QVJML2NK?=
 =?utf-8?B?azNqVy8ydDZwZU51WTRVUDVzbGphZVBEeTU3U2FiWlRVa01lWWV5M1ZxZnJi?=
 =?utf-8?B?SnhIMWF6Yk9jd1BjY3ZRV2NYTUtVR1VIZHIyOEVHbElQNldwdEx1dVdaQ29D?=
 =?utf-8?B?K09GRVZnTThJekYvQXU0Mk5pNWhKQWV4b25sSGlXNTJQdzJoTDFuaE04amgz?=
 =?utf-8?B?YUh2b2F3SFFIcVlleDVyazB1L0hiSzZmNlE1Qk9YMTB3QjNmbUFCS1BENjhV?=
 =?utf-8?B?Z3p1bzBHZzV1ODNhY0JDb3lRVUZyd3JKaDdBL05Nd2cwbU5HRHVQdmcvZk9z?=
 =?utf-8?B?UW51TnlEVlhZbno1K2RTSTRPbUw0bktnZm1wNURJczUrdUVlYWRUSExETlQ1?=
 =?utf-8?B?eXErU3pHWUU4R0JGS2VYemJKSVpGaEpNZ1AwSEZRL3NJSjNTdjJvMWNLU2hB?=
 =?utf-8?B?WVFtR0t1NEYxL2d2ZjdoUFgyRno2SkRFZzRNUS9TNHozR3ZLMjZadk1RS3Jt?=
 =?utf-8?B?Q0M2OHUwVkNFM3IxMDRkR0lxaktUNExKVXM2YTVtUDdDSEs5bDRSRHpqamJ6?=
 =?utf-8?B?SFZIZEFlamJ0ZVMyMG9tazEzZFNRWURYaHlMUXdVeWNvRmw3dnRoSlJnL0Jr?=
 =?utf-8?B?ekcyc1dTQVQxSTNOVlB1YzFVaFZJdjlXSTF6K2o2UkZOOGkwbWhERVptbURH?=
 =?utf-8?B?REdBb2lQa1pwQ1hlT1N3Z2I0UHlSR1NYNmxRa3J3UkVISE5GQyt1NjNZKys0?=
 =?utf-8?B?aXpEeHdhbUZybHRZSjBvUDFlbkJGdi84Q3FWam9aSHZvK1dCZjNpTkFrbHBs?=
 =?utf-8?B?RUZieS9IV0JjVHI3alhOTG1CUWVpUngxbENzV0l2T25BZzcyRlZNVDBMNFN0?=
 =?utf-8?B?d1YwaUZXdTJGeGpnV21EZm15MmlTZEV1a0JYSG5YMnpQRDAvVmRCN0c4enAv?=
 =?utf-8?B?ZFdZQmJtZUNCMzZibE11dkNOckRzRU85OEpzUk4ybDFoMkEvQ1JEKzM1QVg2?=
 =?utf-8?B?bncxaVNLVm1jOVdQVlJ3Wm92amZSWkJSdUZ6VTM4QjE2Tzc4bmZNZlV3QmVX?=
 =?utf-8?B?OFEzVVRxdzIzNkFzRGlRVTlEWEVzdEhScmw5YitlTUZQV2VRcGE0SVk3b0h0?=
 =?utf-8?B?TEFjVXltZmVhUUMrUUlZczhIeXI3eGlwL21lRmJab3hGOWJNa1c1ZjJXOHhF?=
 =?utf-8?B?dVFXMkZGZWhHWkR2aWlmbDBXazVKbkdPWkt2Ujg5NVlLT0pKNG54akc5YWNr?=
 =?utf-8?B?VjBhcENsQnRlNG0vVlVGWjZsaXIwTHhWSEs1NmFhamJiS0FaUkQvbHh0TXlk?=
 =?utf-8?B?SnFTWW4xdTc5V2xWTDJKaW1xVzZDN3NoanNDdDJjRkJyNU1xQ2tRcnNXbG1o?=
 =?utf-8?B?akVOa2IxNzRtUDBZSjdzak9JTmlsSzRSb3N5KzJjcFFKNHNFaUN2cW5OaHkx?=
 =?utf-8?B?WU4xSmFqZVM5MVNsVEtxeEVYTXJLdVlrSkRaVTBvRUgzOUEzcWd1K3EyUm1U?=
 =?utf-8?B?RlpaQlFZd0pjTldyNUh6T2daSmVJM3oxTGkxdzZCdmd1ZW5CZlJUazBDV2dq?=
 =?utf-8?B?enU2QldPYkpDd1ErTXJ1Mm9aRTJFZzIxelJRcjlESjJNVVhCOU5qcGFzSGtn?=
 =?utf-8?B?STFHOG5MeFlsTGplWGF5OE83dVVPYmhUUWY3aXRvbTNmRUF2QXJxdz09?=
X-Exchange-RoutingPolicyChecked:
	s482BO4eGv6qSCf14LhBFOexCS9hmepeffIO97oq4GJ6emP0/pcGx6p4jthUycpiofhzZD5PVwWdmq/RJ77CzqSZEzA1YyIe0mEdfInh9SxWSV+5pJ+z/xN+ZJgOfG6/4H7Elq8aeyQkXUGise+V+AmmkO/T+v91+Jaydm60QpAELTXCxkfdHQTOr5M2wvg0VqF2kba07+XNt6XFTYauOI/cnWggeFw5C6A2abn723m/QI4aD1oM37mxntiBMKezs1LGW6m+kuqpRYNgFVTvCwk18JIOoQMOTmNxLocXmkI/isilvtPwqPPpys3mjF69Exk2+B2rlz157Lvqcvk+rw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a3d79-3f2f-4e3f-646f-08df261d362e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:51:41.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo59i0Kszyfv6H54WyamPKLlYZWISkHXqg0LtREUpEK78UYbSPJ/JSc7rObs9Unh5ptEFWLxNDS4AnncyrtzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5051
X-Proofpoint-GUID: FxOLe02iRBVyje7RqNl-lfM4_lPtceIy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfXxJzU1ubFD7/X
 VM+qZHItRdI6UaY1v4bHUmTnZo9TgPiXVaWR+aDmc73thgMGTm33dBIazsXsQ/+6tBomujv1mMx
 THQn18GS6tmLtBtfh4hbqDsSy20Ib6sqRt4N5smcPeUOBnAWvZf5
X-Authority-Analysis: v=2.4 cv=Avx7T+9P c=1 sm=1 tr=0 ts=6ac90d99 cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=VO7gjKh9a35wxgc9tPQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: FxOLe02iRBVyje7RqNl-lfM4_lPtceIy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MyBTYWx0ZWRfX3FkVPkRAOl3Y
 ax6PbLoRDUd7wNPq3t6j2WzeM16XciVD0Bmbc76gmQg9Pndo6p+5tzP00D7nNPDHNTtCdkl/3zk
 RYzJWr3Uxp9o+/+b1Mgr3Zj/g1wDcuW1JSHNHoNFd6q/IV/k0eWg7ohJNIP5rhb/OcdYuke6FxA
 Wo5cYiOx3zV9AVZC315GbuSD0fRkml3AaBR2zKCY2wejSu4+hlvs3qLrBa5yxcJwxDp6RiGN8Zu
 rktkI9vX56Ibysipqvp8a0kMP4x/oTPUHLZkV/+DxI/6NO7dqcjloVn/45oLIzR48XBYJLoFxkR
 PkhqPb8WRERZE51RX8RNFfbTvOL0KEK9d5it5kRqu7jnqdR/GSYc6qAJaismGlpIuhNUsm/92If
 LlFncWK8SPmk2H71hFc9nasjSNexU1LrKcV50JpqiiEYOjjy1UIcSnguJNtF6bgT4jLf9BxiDxl
 0dz2gOv4eiEvHhf06TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090063

Advertise the source and destination bus widths through the new
dma_bus_width_set() helper instead of open-coding the legacy
BIT() mask. This moves the driver onto the representation that can
express widths of 32 bytes and above while keeping the legacy u32 fields
populated during the transition.

While at it, give the channel width members their proper
enum dma_slave_buswidth type.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d47ff27e1408..ca9cf1e0c5e4 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -152,8 +152,8 @@ struct axi_dmac_chan {
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
-	unsigned int src_width;
-	unsigned int dest_width;
+	enum dma_slave_buswidth src_width;
+	enum dma_slave_buswidth dest_width;
 	unsigned int src_type;
 	unsigned int dest_type;
 
@@ -1262,8 +1262,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	ret = dma_bus_width_set(dma_dev->src_bus_widths, dmac->chan.src_width);
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set(dma_dev->dst_bus_widths, dmac->chan.dest_width);
+	if (ret)
+		return ret;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
2.56.0

