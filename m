Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBE4AA034;
	Fri, 11 Sep 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147783; cv=fail; b=TPIEDdsCdthIGJBdT/Su4FuMuNio+ewL4rZNX8g2EeC+lP0vWE7D+HZpVa9i6cfBjK8MG9i2eGeaWzePFSM+Wry+mrn2hpmMVDN0NfrYpwpYXwWsFw+ePmbNXaNjvsPWHhftaxeEIPZEInDDWyu6A4x13V3eT9+x2E3RFHwakwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147783; c=relaxed/simple;
	bh=r/PWK1x68UPKUiyGEqI5poQQWFjrE60CfvC5TyS44NU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VykzBuuxFaq21OERYKd2I1Yo1LuYDsFR6FPnewDvvfKeNrVGLI+dnF9vRD8P7ty2EZA1vi343oPWDf+44RJE1F4y+w6HVvKsbu7IlC/cB8le8etRaXQyR8MWtAcmbZKfwpSoWC0lseS+Gw0N1NoN8rvm6Js2Sxb2H4Wn+cuPcMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HQm+Ra9v; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HQm+Ra9v"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEioAK3088364;
	Fri, 11 Sep 2026 13:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OWujc
	a/b+MNJzrwug9V4oxfe+SNCIjU4kHV9FhMRWPg=; b=HQm+Ra9vejaylktDE/gA8
	tJMeXQwBC7TzcnI/NFD8i8ug/8tU+rYb56XKbOLsBa1Kep1kTacFB/n3XXvSOXmn
	imMZDeRkedjBw7+7wA1p2XlexSJHZSaVUqzaLwquPAUDmWi3F8EnL9fUiaC9V8Fo
	4eBxOndUM9qmWUMBB62Eeox2Rvtb4qI4jqAOKzaDQe1cqdTfm+VwygFpTzrzCqes
	ojqQK2+u0wrQGRRUt8XhfnAwQlyWqjjyimv27qvYKSpq2D9zJyv2qN/kiSnSUmcD
	d59FRfR5WcXgem7senQCUgVR5w9Oh8uIidJaV0Cj6jU2jrHiRFNMRRsgvMuIOWX4
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx9a7qc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:29:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRX3vfVh4PvSkVmBWwA6TMRTY9zxSMXsX5k8Svtd7szWG40kqB3t+ttP7IM//12+6Hq+eyPlJuGpkF3nP0cOoeNw+x/FDzE+/GIlXyIfC5x9xJDaySy+zXTd/zSZq1JgzoPXe6Qet21GkvgKBcc6TsV/9QCKtWqZGHKI3QoxVKn/KReWsLZqyqYRMns9XC4JXjB6YLYEdZUMLuMHgdxfxGz67n/UDBffwvPJ0riMZW4fZN1QuVMoxUCZpl8Ee5kqLbZctgqcmLpvUgNQCvgYzDNr+Wk56NP11oTznMDEbUVmz2CWfHxiLCNr6ABj4ibXCgLSLT2ybTyaDwELeTTeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWujca/b+MNJzrwug9V4oxfe+SNCIjU4kHV9FhMRWPg=;
 b=llNOyFAFyH6t2x0scN5jmicH0y2RMRt1AmZBZEcBz/+ITLKnhiwTACZPbetn/m3cCDE6UAYJZM4gS+gWep6S4ILOj/HFzl56aXgtj2x7TtZ9eMcwXXoO2VxnXskifnfiORXinwpbmWgtkVlOB7X4XPyNAscSYIp87tuTX3oY8x+utt/lo4CmKzCt+QrK8W4vRzvFbYN7weun+fXCXCfrecJN1+ZQXNHglY/vci9+LpSFxkOTVoPUy2nV+EItjAGnqsSwQX1Di+wEwrPa3kYp3Gr0CzE4GZN2JjxWxiv2NolY4dxbJXzLorkR+0icyeUU46JTwkqLEKuQKS5BP616TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:28:58 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:28:58 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:39 +0100
Subject: [PATCH v4 04/10] dmaengine: dw-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-4-72b8fd4cc78e@analog.com>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=3028;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=r/PWK1x68UPKUiyGEqI5poQQWFjrE60CfvC5TyS44NU=;
 b=7KsOdn+eN7wBKjVi3CQET77cevNyk00aXQt9u9B3xRYJo7nofoPhSyZxSBqsHvl5sfKYtnYni
 JNEH0h/91ghAXiqgM42Nrsb/XBIyOq7Ff1pKkFppOIAr2SmqfM1Ox5o
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA4P292CA0001.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7971c1-dc7b-4d5e-3afd-08df102a29c4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 jn725KuK/EjxyrtjGn6G+fr6BryaxxKCb2XT6FNzJ2Dl3QQ0dnYHFrxp3HvqrOyVGF0btN/us1wGoG1aGNTdjWikWhzGy7Tcjd+38sRXQIJKmn1yEazEjGmf0AvOt4Hy+MPh2jA/4utReLmIJ7r+3nEHd6RiLPrKz9H/QqxLieAWeEiQX/28UQ/t+D0j/BY5IAOUFmjvO/BCH/kbkt3IUHJKrykUMdXcRE+ymdiL650xbSmcrhdPomkmXdx2OshbvozqRgxTu3/sdr1OaDjhU1HMVQf7MTcV7BVO/hHoXKhV9zVCA5QQmIGqghUx4hM1r3GA9uSH6IRmJwwMy1PYqkggCiTGxcAXYvQNSc+N/qcrEFuQx72tuPocwMicey6rqOztcVvrZEzKuv550ADmzjJc23TXcZTsVlD0z1KflDoZeObfyIQzcG11k3aQmucd586hg9ExcrZF9e7iboNTKR9hb4aqEkYrIKoKNA9TjfkWz5iUwBAaPtqCtPthWqHOSShpVy7MqrQi0h6S4XGZUQ+NXoDpny/CcFK4+JGlGEmwlv8Cjd8RJ2q1EcFO1GpkLNwPJrwngVRNT6lFEvcTGnl1cKR+jsZcLP5iQYFIx9JT1YIfuTLe3eXiShJ56iFlVbPicmdRlAwrqCgi2t9VAfZRdGxOJztb9QtEPPLwSMs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QldsejR3RnlHR0VTZElzR2pVRGN1RERxSUt1SGRvc2tuVmVQTVlLNDhaMno0?=
 =?utf-8?B?NVltZXdIOHN3bnhHYWxBaVZLSVdXSlZTMEt4OUVVaXQ5QjBIbEI1MldtUjF4?=
 =?utf-8?B?YVBtQWhtZGZRWThIMkppdzZtMnJPNFJkZWtGa3RSK0MveVRtZnBXMnJRRVBp?=
 =?utf-8?B?T2hwUk0zMUt6ZUMzOUtJQllGa2M2a2V6WHZKV2ZnS2NWQjF4NXo3N3VuaWdC?=
 =?utf-8?B?TlM0VStmSDd1QU5OTjFSODAwOFo1TWFPbzlWSUlZajBZU0VwZk0zQkp6MDdY?=
 =?utf-8?B?U2w5ckR1Wk5KOUlsSDBGK21GeGJxSkNlcHhKZTRzdWxwaFY1bHUrWVZyV1N6?=
 =?utf-8?B?L1kwQVV2aEJUWll4N2xGYktMeDBpN1pkVE5GZU9KYXZUS0VGVDRVMlNZSFhM?=
 =?utf-8?B?QThuTUZpOUFXY3dUMzRKKy9xUFlMZTRGekZJUVdoSXl4Mm4xR3hsTm9MVEpw?=
 =?utf-8?B?eFBmajJmQWNoVDV4Z2RXbUo5WWI3TCtEYXlTQkdiYXRZa3lrZVVDamVhaHB3?=
 =?utf-8?B?RFRHZk1rdmxySDVvQTZyT1RGbTdpR1p3Rm9POTRWT0RQdWNIbHdiUThlZ1NE?=
 =?utf-8?B?Z251WWdOY1J2YXBNUUdBeXBPVGI3YjkvRE9ERE5LODR0QmZjdmpGaTIwZm5x?=
 =?utf-8?B?VXBWYm1tUEM5OVJjRC9UcFVuc0YzS3dKTEt0bFdwbFo3ekViL2ZKS0VmQ3Ey?=
 =?utf-8?B?ZFloc0pya2w4UENMcng3N0VUemtWdVlpSXg5bitRQTdZQUZTSEE2UE1qcHFD?=
 =?utf-8?B?aW50SWQ2dUFxc2lxVGUyY0E2aVhBbUtoMEZWVmxMeWRsZzdQbDVnOGFOWXA0?=
 =?utf-8?B?NHJPcnhuTXRzMWloR1N6UzI2cnFYNHp5SXE1UjFnSnl0MTFHbkhCbnZicUxP?=
 =?utf-8?B?R3JJeVVFdG5JUmsrOTl1WXhpQ3FycXowWDBHYVgwVW5MSjJwRC9pV01xNWdj?=
 =?utf-8?B?RWw4RXlpaW45SnFnTEc4dU9FTHZBcXcrcklQM0NHTmpEVWExenM5R1BRMW5h?=
 =?utf-8?B?Y0tJMzg0a2YvSkFsKzdML1llUmxRTGVpcDErNXB6aXNrOHgyVmF1Y2lJVERp?=
 =?utf-8?B?Si91OXFKOFJ1UTFIVmNwRkwvNGQzRXRzY1RXRENyL3hEdG9nbDZtQ01xUURR?=
 =?utf-8?B?L05wT1l2R3FPZzIvVTNDSnFFQis2VFVWSFBOa3A4bWRiS3pMbWtBN2wyMkNC?=
 =?utf-8?B?TkdhRkhsOWpicFRHZ1dJdFZ5aVpzS3VCTnNqcUVqSWNydkptL2hHU1BQbmEz?=
 =?utf-8?B?U2Z2MkRQNSs1SlRNVlZzWXdoSkh2OStuVStmS0s0YjcwY3laOFRabXN6QUhj?=
 =?utf-8?B?OFV3bnY3UmFUU2VSaHNISGk2QXFQWFpKVjVEWTJLZEtYMUgrbjJ2ejV2ajIx?=
 =?utf-8?B?SUdHbi9FZzlVejhHNTBOUG9xQWVISTA0RzBTM1B1aFRiYTVuTE0yWE5CbWRt?=
 =?utf-8?B?dGdXVlVXeU5sR0lOSzFGNUc3RXloamJvVWk2ZTgvNDVBQnlhdHIwMXp3VnVh?=
 =?utf-8?B?VnpOenVEdi9yL3FrUDNuMHNuU1RWS2JGaHc4NUlHVFQySWVVYjN1Ti9GU20y?=
 =?utf-8?B?Z2tWZlEvZnQ5aXg2amRUcmtENnB1bHNPMVBLRVBqQWxkQVkvbTRZN01KWkl2?=
 =?utf-8?B?bzg5bWVreXNjS1ArcW1EMWFHSmx4KzJBVGVXVVp4ZGMzMWZLK2pGOTIwWWRL?=
 =?utf-8?B?M2JDZTNuSWNMZi9yeVNUV25UVjVEUmxicEsvVVVLSngwNEM4V3VDem5IdDNw?=
 =?utf-8?B?NmhaZ09NZEI1L2VNYWJtRk9nMTJ4ZUhnVXRLcmxIbXV6V1I5Z1NocWNnYkZk?=
 =?utf-8?B?V0dBKzVtdzltUU9kNTc4YkVZdkhweTk2NWJHYlFsVllpWGdJSVc2QUdIejJ5?=
 =?utf-8?B?V0tDQnk3MXN2aDlwWXB0M0tUT2ZqbnBJZ3paV1piMGxKUmwydnBiZm90WkFE?=
 =?utf-8?B?dEk0RURmQmZFUTZLaVBwUnhZZHBYWFBsQUk1WXZhSUI5VW9SUjI3Z21QZERJ?=
 =?utf-8?B?d290YW1xcUFTbDd5RXdLdG1mRHFGeDdRWWhyTDE2QXgzbkNBTUJpSEI4SHBs?=
 =?utf-8?B?TzhRWENIZnBUWk1VMW9EUEpTdzl2VHhGbTkrMXU2eDdaSkoyUFJxdzNFVHp5?=
 =?utf-8?B?SU1SZWtROEJldmtVdXBteHovZFB3Z2lqNnVidE1JMmRqdHNvRFZIa2syWEZy?=
 =?utf-8?B?T3NyMXEzOCtOeVY3SEdqOFVKMEpaZmEreTJlZGtKcll2RFBJRFJDeGlSQkth?=
 =?utf-8?B?UjVlOTNjdUx5WWUreEtKWWlDeXhML3VjaHNiNWNtV2xDVko2aDdzNkZtWUFU?=
 =?utf-8?B?WlNKZVFvbGlNbHJIVDh2dkxWbS9LbjcyZEVoaFlCVWxIbUtqdTFDZz09?=
X-Exchange-RoutingPolicyChecked:
	jT+bHHQnn2GSMePfJwEKBVvzX3Tv1slmXFGzuWY6yKaK/sQ5z30MItq61oMpS/X9BB6VQaDEC9bhpV7yE/+SE9tf+lhrPniqEpcro7F3TuBqRSGK5YhAmVavZ3DhSAVK7Nyxexn2voI+tyhlsdI2eKJuYMDxaHOgVNXpU9JRLfHyePklBsiicGUW7PdHWsoN54sCkGAbiATGsFUyYkz5marHDapWGLSHAWpae//JRrmHq2oJHC7iW0DsnB+yrknKwyb0n4v3iwAX6VoAEYjrBAlxRPbNtyPilhRsSEORgPH2oAsOGyywJ5B+MYeazbkIleJyNmH94ILk6DO9c8n3rw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7971c1-dc7b-4d5e-3afd-08df102a29c4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:28:58.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuJe4jkzPyELjPTevO6tnwVq9Mn8W3nLVB5S2KjHpPYIDhVN/TCgp+SHP5Tq4g8nXFxdwHa1BVn5kbInS9XQvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX+VSSDHyGpFFd
 TiA3SHSYg/rUWa7RRrtIiTPpgWNsq7gmfayFPvVtIT7zzJ+Y/lMeDI2Q8B7QURSBGf8CZe2dPvZ
 CwBLerhQmI5oCdOWs0/lio9UEDd9Yt+3dLwMNfS4eJxo2IFfmMLp
X-Proofpoint-GUID: or0NjK1GknwZapmkyTeBiqQV0g9_NOK9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX/W/iciyad9N4
 KPKKVN+7wUa4yBNlxElDxivB96xgSsT7imom3aODKO+aqmwCJgGknTytLXFx90x1mPDCs7PEJb9
 JRKhY/FYYy0TWvSs2Z5Q2DOBAJaFzXuJZFzLIb50AGoDFrAaanYhXBzOr8rsKXhGDfdjmLWkf1L
 85QS355zTQqZZ5W7KRoK/VprTcXTxshOf8AmxehDvf/VOWwXn2wa3MwCkbDokvjgShSBOyHLcYQ
 iyze1dRJmJZQMeSJRo0KwWsIA7UvMzeVkui3CoS1th5JTt4NvcsfW7mUrRa6or9zgwan9NMxUP6
 quyrVAmZImqW/8oi1ZOIZaFhjyMJhJwcO/2S9iGWDwCMlaT0eQw2rIILQoos8pXaoA9HxhBzMl3
 q2+JhMPLO3+SFEjzVriHj3lKFJY+bsAIBIJwSNFIjBCFs7cPtOhKDXS8lpLAQjSTgugOBxmeXoM
 cynk8qb/NGSvXJAr0HA==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa43a5e cx=c_pps
 a=FmVrivm6CVS+kYk2MGmjxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=y_OmukUNvUlgtTeSwsgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: or0NjK1GknwZapmkyTeBiqQV0g9_NOK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

Advertise the supported bus widths through dma_bus_width_set_many()
instead of assigning the legacy u32 masks directly. This keeps the
driver using the new bitmap representation while preserving legacy
fields during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 38 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index eebed2474210..ca0ab8dc5f59 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
@@ -33,20 +34,6 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-/*
- * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
- * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configuration.
- */
-#define AXI_DMA_BUSWIDTHS		  \
-	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
-	DMA_SLAVE_BUSWIDTH_2_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_4_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_8_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_16_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_64_BYTES)
-
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
@@ -1482,6 +1469,20 @@ static int dw_probe(struct platform_device *pdev)
 	unsigned int flags;
 	u32 i;
 	int ret;
+	/*
+	 * The set of bus widths supported by the DMA controller. DW AXI DMAC
+	 * supports master data bus width up to 512 bits (for both AXI master
+	 * interfaces), but it depends on IP block configuration.
+	 */
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+		DMA_SLAVE_BUSWIDTH_16_BYTES,
+		DMA_SLAVE_BUSWIDTH_32_BYTES,
+		DMA_SLAVE_BUSWIDTH_64_BYTES,
+	};
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -1565,8 +1566,13 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
-	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
-	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
+	ret = dma_bus_width_set_many(dw->dma.src_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set_many(dw->dma.dst_bus_widths, buswidths, ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
 	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

-- 
2.55.0

