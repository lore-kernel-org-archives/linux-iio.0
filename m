Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416849F137;
	Wed, 14 Oct 2026 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987597; cv=fail; b=VR4sXYMDgbNmKVlgHUSjnzrBztwC1iIpf7LEU4qgRQufqQ58o0OvesrUm5f9oJSiUyREO9XqjaTQ7WSgd/JXj73UqekPBkkIg1YZfcvA2BC/NPCqF8aYGE8LW+4ghu+gx9UDGpK1i4/eETamt/ggS8vo1ExGpmcNctxY/R/BCa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987597; c=relaxed/simple;
	bh=mRgb2AU+VzzduPJ4c3VC1YAbZwcO+kp+N95Dubbb02c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JZOMhpMcfQ9HcG5r7C9hRE7YvURo84sL4ujw7dy/i9K1lYHAKYRIUsGD0NYJCEB8NhpeuYk+lpgrgIJK4/nDFPWcqaGHML2eGqRLngbRVoKVOlBzC0lNBeKZVj1v+p9/kCyXXU7K3cNaNYAEn9chC6hWGwuRTSYd/4VMeSKyqys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=em1xgiGZ; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XOmSJ30/; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="em1xgiGZ";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XOmSJ30/"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EDrhlH281458;
	Wed, 14 Oct 2026 10:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=A85ptkRi7o0xlSHcesfYtHT78mJxaZdKmBZ9vMDpRsc=; b=em1xgiG
	Z7X2GMidzXeM/Td/l0fsCGgsMn1yupkhMzhxCxL0VZPB7Fw/s/90hhhWR4lla+jz
	Kzq/OIULUUhvZBExHUDBPrse6Snubeo7eODFa6Eosh3uzDqKCUGBXJwa8OzTf+34
	sYGl7Stj2Tac/zmKxG49cOcg4NEmlS/b0HOkcIbFZVwbnz1cpOXlNi9uN2dGyE+d
	VQFcUxi3Bb4AOzsre8p/pDDgV52dSuq2xjgVU31craTvi/48YfeMetdG4oCD1LDD
	LJTOAW5pKdsqCq1meAr1lzy8fjthnMuT6xmWIoYFC8rPw6TLhjhEkdVSWsdp3Cep
	Ps0AzP/aOLTxLCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A85pt
	kRi7o0xlSHcesfYtHT78mJxaZdKmBZ9vMDpRsc=; b=XOmSJ30/d681aT+ahD88v
	fEhRPok7TV/18/V1vKJP554KhyYoDMEVuUQv4BTjt9uMs1LYIJssy+P1MI2m1T9S
	49Yw9V+vL2uJF+3V+/0cW5LcKDBdxsBDwOcMbwjL0skHBOacNar26N1b3gA34ejh
	mmBZ96UNfdU+W2ocGpfRy+c2YkmKgGl7CbKAAc9JPyN52P2W/nQGH6qYcMMin6iE
	qH8tPB11dtWw16Eu+A8SzYxoWZrj5OqQnVDaBVQ/Abxp9raEEnZ2iQLPfAWoALs4
	pggLY0OvkFtAJ51i79LsVUGaAJc5e/qkujAoycpGFNcmfKyv06rNA7WcUK3PDo1x
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ha0t3bp36-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTl4KJw5NWCfxseSr7g0hFqPlRXgicKqI9uO4ZtA1hflHODJbMeXdJTUEgnRXFZcBUO43uEtU7qxC0SAE9wFpC0BGEGptgbs495BVi52sHugEIalD4Da819uqXDXCX84b76+tQZloS/COLUOiHm1Y/fK4zHOPbugV4gAd5pBQTaP33zc3Lnoa+kZHhPOAOzrDYgQdlrpvq4WhUBHgXzVrVR6NJHosnflG6/Bj1rRynOaOz9hmHwQRwFd6YjcUF30CqweBpGTKDDfMUW+4MocU29idDVooW3j2gwUlGI0OGl2qfT39uLNMMnk1PUMo8FeluRJrcdtyj9acSPvEOEFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A85ptkRi7o0xlSHcesfYtHT78mJxaZdKmBZ9vMDpRsc=;
 b=mDrYPSNd6y9Lot+pSkypvP2e0EhtcS3VWJ8ACA242FuaMMuamoLcQ/7eBvEeG/3S2XPT0IG5KkONi3UNuMte/0ilmz6PTFgHzR0TIOhBLbEFzz0I+FNL2a1wc/tHhYLYvGuH9RInPXOH5uQv2y5htNA5evEmW/FCs2Iw1VbO19NLWTjQrMnLHZZygMTkJWnBiXR+06rDJGMv+bsZQLl757cmYh/WhajdA2lMIc/1UBUdrYf2pu0smwKIK6HLGqbwUtskT0jhaV8Mx9sxpQyl6wKqfVjInk4aqEa40AaWaEu1gNi9FxY4Ixc4tjhqwYyiBsD5dTR7plQdw51u48MB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:18:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:18:09 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:14 +0100
Subject: [PATCH v6 4/9] dmaengine: qcom: gpi: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-4-5b3ffdef8191@analog.com>
References: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
In-Reply-To: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=1441;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mRgb2AU+VzzduPJ4c3VC1YAbZwcO+kp+N95Dubbb02c=;
 b=X6tACFVEb5evGzzZtD1AXLqXKKYqOKbWezwREAK3yMza2o6Zn5w2dwtljCTc+V6+QLpgjYR4s
 /P+qKMCxzaLDEHDapcaYFfODXxNowrxRS9maGMnwwHr1ESFuRyePcAt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b998aa-554a-4930-561d-08df29fdf8e9
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 6LkM66K4FCBGXSVzYn8lnSQ/Q9BlRfYkTlRGxSvPgEBFbrALHJPH05l21ckrMpRhkbTcqQ31spY8qE+0b1SFtIGf1+iYH9PBPKpB6YpJCB6JcS+GN/dLONIiREH/sQxA9gAQBWCo61ZHSVIIZ54oxCi61uxaBedfWdRNwAm3+0vw6xs/GDBaJUVLmnKadCPOvlHv8VLtKXUwarU1L5i4FAqfEuUSMnhUD/T5HUZUb17+5Wpbith4MI2v8VGNbRJ4C0w8WuV1PWnHDb03YHkx+sHnX3QtdfnnrHGCIvHFilSABM2t1AwrVCS7o61oRusLhcxpyXKX+1jVVudFvtC7YVwXlT2abmb5G4VMk26BbDInZ3dXvkRyDJndw+Qf1FBh2xNCgwsL5TjawfcJ6kCJO3C5vSoOGUoC29IkNp16KiYGDsg0Hl4h1ygM4ofPMMiOD+qYKpFqC6i3iJdOeJxXgeZe2CKcgIXkLH83JihnL74xd6KvQzCWPqU8wgJ3oFoLtMSmd2HB607mI0Yk5QygeVSYLOGvjB+IEL145WkbskNZ146CfGpULZagbjnQNcQyAPEOmZBbqTuCjgMzBomRTRmYTxcaB2jBQY2pePcWGvje+TMnT0CtxsOpRuJ6DVpcJzsOLrVcUBvDRJD/gApiHZVGvTCmZ2kGeuzGTlO53JY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bENiNERGWnFPdWVoU0hIdDdGRUFYajYyVExrR244OGl0QzNFMjVYckU3YnZp?=
 =?utf-8?B?ZW9jVmNMVWtRb3k1dW80cE1FNHkxSDE1bEQyYU0yTGxFcTk4RnVNRlE3WFV0?=
 =?utf-8?B?VVlCRkhpOFpuUExMVDZBc01sY2U0bEIwaEp5cWNQcjlQZ0w2UlZSd0NzZmZu?=
 =?utf-8?B?RldxNWVxbXBMVFAyR0wweitvUTVqS0F0b0dtSlMwWFFsSGVwZWJnZmNCZW1y?=
 =?utf-8?B?d3pyZ3NrRlFaazkrWW1CdngwckxjcGtkdGVaTHFMbkRmU1ZmZTBOcmNRWWZw?=
 =?utf-8?B?VndMb1ZMVnA2TXRrZ1BGS0svZGhNQmxGaE9VaHoreDRIcERwRzdMbUp3bWVE?=
 =?utf-8?B?dGJPSEFDWnhjVGdYdVNlbUpvWkVmMnJOVWNZdTNPTDZOL3NMVXc4NWtTd1pu?=
 =?utf-8?B?dnRyQjQ5K1pIYld0ZlRxNDBsNURBMm93bEVPTXR3UXJsT2Myc0dvd3ZBcjN3?=
 =?utf-8?B?U3pSVENtYjNJSGZDNjVROFFwNE45blhWVjRwcUgzYVhIbmlKN3NPZE9zTEFS?=
 =?utf-8?B?dU1VRU02bFRyNjZiRzhsdHlCNlk5MmtsU2p1N3M4ajlBZUZ4RnIwVXhOcmZK?=
 =?utf-8?B?TFExUW93eGFPWHp6SWh0cENuSENlS24xVlBlTEZ6SnYyZksvMTlRY255bWhW?=
 =?utf-8?B?ZVNwd1hZbnA3WXpXbUdiNk9TWDFpVGxMY0VXaVduTWt5TDVObHJ2SXZjRXhL?=
 =?utf-8?B?Sk5ZaVJ2MGZrUTgybmdnZTJndzRXdlhLTzZkaURYaGR6NWVLbk5rV3J1T1R5?=
 =?utf-8?B?Tkh2RHBHZ0lKVjdIcmtTWDFOVWl0bi8zWUlhbm9uczdFeldhYXZoNFN0dGxz?=
 =?utf-8?B?ekxPRE01bFpjY0pNbVI1YXd1TFFoNDd5ZU9VSTdiNWNDdVRLMWhRV2tHV3k1?=
 =?utf-8?B?Z1ZscUpIcTdnMHNONGJ3cW5mUWFpakZSY3N6LzNtN3VDZ0w2RnhMVERLWk1j?=
 =?utf-8?B?NEdlTWdZTjhpVkQ2b2tUdExhMHBiZmZWeUhrckdad3BmcG5HUGNCbUJnd2lr?=
 =?utf-8?B?ckxuLzc1LzZXK3F3OEwzUDJ3cWxEa0pJWVVkWURtc3FRUlIvT0dRcDM1amtK?=
 =?utf-8?B?OWlKNGh5cUFsM1FDQS9UcVBKVVlFUERXZHpZL0JtSjJuRnE2bmovSWVvSXJj?=
 =?utf-8?B?eUZDU0t5OGFVR1ZFQjgyUlZMa1NxKzRCRDRUMHRuUTIzUVpMUHYxT2tFUmh1?=
 =?utf-8?B?cVhaNjlEaGNqRmdWRUZGbHZLWWpjSXlNQ3Z4K3lnT1NLS0hJRXc2Z0Y0d2JZ?=
 =?utf-8?B?eVZIVHptM1RlTkszdkdkOWhZSEV6MVpRSWN3cngrMHo2VXhTb3M4ZVlzaWdE?=
 =?utf-8?B?T01NUXhrMndlMlcxdWZSdy83RHJJckcrbG5yNkpCOUd5cDJFTUl0S2FoNlJ4?=
 =?utf-8?B?VlJKWlROd1BOaVczUW1ST2VSUFFrVElaV1U2MFRzY3NvWitWR2dtc1dXS0RW?=
 =?utf-8?B?SmRQL2Zsb1JFazVUYnhiQ0pta0kwWlo5cE9lRTFEUFpUR2tHdzV2M0FjczBj?=
 =?utf-8?B?cWh3UmVpa3FWV2RJOGhrOEw2bFV3TWN6eVo1T3Z1VEdoVCtOQk1HdG9rTEdR?=
 =?utf-8?B?cjRnY2N3WllEQ2IxOUZkYzRkdG1URldPUmdvWWErM3Q0T01LR0FBQVIwMTdT?=
 =?utf-8?B?S3BvZ0FnZU1KL0V3RGh2WXVnbUI5N1pLcHIxYVdXMFJzWktCMjVQY2ppT0Y5?=
 =?utf-8?B?OWJVb3lIQjVtNEdVM2lQR0ROS0ZoY1UxSnA0MXFacjdvanUvem96R1hlNFZz?=
 =?utf-8?B?aWpGQ2toSFhxRDdGWVhzRkRCNEZQQUJTWXFybUlFT3NpejdacFk1NzVxSHg2?=
 =?utf-8?B?U0llclJuSjhTK1hrb0J5bk1kL3dIQmkrVmlYNkhXaFBydjFHMTlEL1FDck4w?=
 =?utf-8?B?VktMWUgxcmVqbXVhNW1IeWpYdlg3N1JLS3h2VHVEN0lCdmZZN2xpSnJKWmJR?=
 =?utf-8?B?NW40WktuVEdKQkRnRzdTMCtxVVM0YlgyUGVjT2RmTFlKT2d0OGFVMGJSZmNm?=
 =?utf-8?B?eDNjV1JlQ1V5cjRDNjd1WGxHMXNMb0hHZkxKRjUzQ3lqSlRBcU5xU2RHV2Iy?=
 =?utf-8?B?dWhHSUNobU5YcHM5dnpDNi9HQjk0RW5NYXFHTjhGQ21VWittR0NoZHBpZnJR?=
 =?utf-8?B?VFpRVXdnTVNBOTlDLzdrT2NQRG9xWmVOanhMcjNKdmNKYVZFaHdvMFZvblJT?=
 =?utf-8?B?Um1pWVM1Z2RxNGkvQlVpWFBwekVXU0VKR24vOFIzZElVTGJrYVczeFlOL0lh?=
 =?utf-8?B?NWF5NmxzYStYdEdNenc1WHhGbDExeHh6Yjg4amZJTVFXMFFsOGNDeWdDTlZ6?=
 =?utf-8?B?aVYzRGtISjRBMlc3QUVldldWcER1K0xGQ2h0UmhEbkg5QkZDTWs2QT09?=
X-Exchange-RoutingPolicyChecked:
	Yi0Fx+GCh5StdhEC0KErXDDagNEtgt8E7pcuIrz7LOP7lcK8qIT/bsV9ek3SZBZBerSBOda/8LpvceWikFVp/YURp+YDTZN6P/OhBcTVDkkSV/fCYFg919g02Sjf2KddZ2PrsK8ue1kAogfzwZq6KG6Y7+n/lWskuPs/ZaOs1bHQjeHIxoEV8X3wjommYG0me7YB/O8q9/pphOOAW3uEyJz/Gk3TGUZ7sODHFbTizYgyKVvAm3+zjCRvTax/c4rPRLthH7QPZ4SiaHVguM/Uqi5XtcJvFCSbE4aQbrOF1gCYetPsZk2ZuSZ4APBHAoW2EkEWmIuBGwOoW9RFAY0ufQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b998aa-554a-4930-561d-08df29fdf8e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:18:09.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE00EwMz6tDu43MX9dVpbIMKUWp+IpFIOUbrFe+MI82ZvA587qsRmjeLHAYyllzKwlpK9lrP1ly7MTzwZpypeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfXzOLCkDq3oAZ1
 NoLkz+Y52+zo8BJH/Xp13KvbOeW2NRH/Ozt30HkszjqhDIlgGxebA4AWyahd4j2hk59i0e7Iauu
 ds79x+yyecTj8ei8JDifJB0ti8oMDzu26jcWgeW/CndjygqpJ05zuV1NuPqWbftcSVRMksyMF/Z
 GvofDPHOFgaW5U3+yoP1zmooaOu/uuy21GYHXteHs3148gumZ7AhAvDlgsjeK29U/Azasltae9g
 Cdgi9kpFWF3jR0+/+/AR110J8lcsxATqvJp+tS2vAyYbQlaBgzdMfpmzQEH60he8/TH8/UJX+bq
 S4+ip/BZUrGXegNgnvi0GHIV5q8iSteSax1ZSic9AFpwnLyz1zno1nhEQAReRtUnk7A4jwjGtTr
 WUE9DY5iaYimw/x75YupL1WR6FZTJniwe6F30w5fg0NtewHPwU1PV/osz6XtwE6BVYjf6e+SJOc
 zoKOtwsBsEYe9eoaerg==
X-Proofpoint-GUID: RH9A2TEZzf8vbidZo_fQXwiRhneE2Fol
X-Authority-Analysis: v=2.4 cv=S7RMU4sP c=1 sm=1 tr=0 ts=6acf8f26 cx=c_pps
 a=i69ZgmgbQZPDBD2C4G6j1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=11eJKpf74FRv4loUduQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: RH9A2TEZzf8vbidZo_fQXwiRhneE2Fol
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX7bppvVU8NlI4
 FvZ8z5HxtrJa9hazxivL04m+QTRUU+7ZsrtPm3CgpVFWutHe4l28aYz3VxZUO6bYIC8bY+r6DIN
 yI8Goz3wT8vbFYnQmrpo9dAIQUbZku22dELxehBEcOTWGBSnOwow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

Advertise the single supported source and destination bus width through
the new dmaengine_bus_width_set() helper instead of assigning the legacy
u32 fields directly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/qcom/gpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index c41bfac65ddf..bb5dd6d1179f 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2270,8 +2270,15 @@ static int gpi_probe(struct platform_device *pdev)
 	/* configure dmaengine apis */
 	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
-	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	ret = dmaengine_bus_width_set(&gpi_dev->dma_device.src_bus_widths,
+				      DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
+
+	ret = dmaengine_bus_width_set(&gpi_dev->dma_device.dst_bus_widths,
+				      DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
 	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
 	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
 	gpi_dev->dma_device.device_tx_status = dma_cookie_status;

-- 
2.56.0

