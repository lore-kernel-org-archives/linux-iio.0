Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A74A99D6;
	Fri, 11 Sep 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147796; cv=fail; b=b4nXcGbTg7Y6FLHmwxSOMkxKXvrPeOhW43ZrGEjhCX/1dLv2h829GFpdNASFxcSzqJokv3afSTQbF+pl9KOhRRsDEzjeV5jh6EseK87td4SYolU6CvJCmQtbm4fNvf0Dhkr9O9IdUKdd4VZQiizArJL+8lxSLOK3AUYvuzyXVZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147796; c=relaxed/simple;
	bh=TYQ+zqHqTR341dv5f+SspWfAszVjoy8/4PJIlqe7PNs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RntLbyP40az+EFf+f57uqocMB3oDQ/jzMBysYJqe5AjlplRD6FA4zuEPcOQpAUcc705j94y2rSSWTVj/BcZ5Sz5qN33wDH0jfjy7/ZYVLgtIWpVOx39BxNnyd+hWqSTCZoX1d1nRKqTfsyjiqGr6TEcHjBOhRqun3vW7sol1Nz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p2dCFOe1; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p2dCFOe1"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEikV1685412;
	Fri, 11 Sep 2026 13:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mWRqj
	oiXWeTBGTqr2/LOLQNl6XHg8+lCbuq8hLExL2s=; b=p2dCFOe1O9fcHULs6nmr0
	468OiJgB7u/qd8sCKWjNxNIvupvFn7MtyGviFq3VToIwbZCVDepdwigg5lqn166x
	8yamAgmulktX1UqVNCyhsZitYq7BW+3zNpAtnjaWgzWT+ecmQfk7dyRJFka9Y4QP
	kiZPjG+pOTtNNBB3E5VCLvMAHkhZ4FEDiiP2ZUfOe+uURNuS09gdPS2pw918RWP+
	rRT4S+PHhoDEJIiT434PUuDOkPBepBhbINdvpBzjq82D9vg+V1NbgOf7niNxwaZr
	AcecLTxVRJ3uVSfaXYO5Ns9qg8IT5otDflWQN4m+svqe6JFtBkrH1ExgXz5oXwM6
	w==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx8rfvq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:29:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edM655tKDsfjHXLVaD/gY1Plhq5LKxpBw+uS/F789A6FaGjsJt8L43ipuuOhKVaCmjlyry79P6XlpsuyWAULp7cplnTgk6MfataM3unCxW5UFsWuW2ctB3EcLpNbZ1PwSxBRPSjSVgDYxiUSe1WtIViwseshyZ5L7kf3qOsm6bsaoajWRBZt4YquzlpiA1X7s2uhdo+9nbPY1uQkkphX1zo290+Mh8bHhjjrdaa/gFPgXp90Lu+HXzwapDJgikfrEvDvOuDK4MROjw/HJy15oQ+KWuS4UrWy73MnAy+7xm5x3LWE+oZAMMUOK7PztRgnxg7McOQiHw3ppmffL3duxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWRqjoiXWeTBGTqr2/LOLQNl6XHg8+lCbuq8hLExL2s=;
 b=A1JvTR6+sukY2T9Sjg+JiDtJWuevnUaf0uijZC/Had77vxKJHq+z1pO/UNwEOdg3RcvN3WABqnTdrOxNFwopApGUfR7DmRp5EsALkuDtquWpEiQUaNdf4qyi0CStgAZSL6BdVAR1hL0ijsgoNGTkwzOrKWUeWc9XB9kKYM3lbB5jtxzpjdc0pDjZocrowcdle4U8090eQgFgcOuj8a1cKS5G99Pqxdqdmi89/Rlpkgwf9/sM9+DWzDJHcqcClyi5C0Y9/9XWuB62BJ8jsX4LBRfJNJslwkxG0gjjn97CRaFMeuC2WJO4NBXegIj35/gJ7+EPYjqk01WRaWaMeM0fZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:29:19 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:29:19 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:44 +0100
Subject: [PATCH v4 09/10] spi: dw: Use dma_slave_caps bus width helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-9-72b8fd4cc78e@analog.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=2528;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=TYQ+zqHqTR341dv5f+SspWfAszVjoy8/4PJIlqe7PNs=;
 b=XRVoISB9BEHHHR82FRsN/hIi+nomkAfcZhpyllE2wSlIML6K5rUzRE37CnAfI1/Ie9nNeHRzo
 wOg+PwITJgcAzmwjYBwbrhojbEfsDFXyrriNNrbOb98KPAfXeT4R7Lf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::31) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a920b2-4162-4c6f-3c74-08df102a35c2
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 trrD5+JUpjz55lmb6E+k2znOGYl3mxKYH3e3ytmqRif0wyBvY2Ba/FOKdAPrtCaTSA+FlwKUucJ0b0NHSV3gj0lH7tGwpeGBwHcyfN8/zK+3pe0H6Y6zXbXnwFkZfq32r3/4xLu3c+VALb0OrRYH2DDwYzPscDMqIBe5OG+9vZ52Tcg88LVXenDg0+6rLGN0ssawMAMA2Xwhtc/q6NhkTcI/8r9tYUjmYQxA0+cncMRbC9hG6726AnExD5TUndNWs9vXia2gDVXgoZuAO7bja3OrLpaJXfRnvcsTZbYWwykWS7lYM/2rjDGS2QyRfjyQVoeXtcBnB4SJS4GLcJeXM628vcmgrr38M8mOTM2X1odVOblS4J5KKp/2pY/TSNpXvMNryDP9PgER0aeM06up3ryuxmU7qvkw3uk3tHZHpUtjm4R4J9D+KBVVW1kDtxbhWKXFEIEvN9WlEznyx69zkAT3KO45LmUzkEqwRXuxNIod/Mf3fZrsPSOHaPUepx2W3ptY2iJfU++5IZ12HnmsYyzsyn5idOhvh4st0I1FgS3Yi0K0vAbFW5pBGEZZWQVFTl5oA4bcS5Qxl/lXyipjMAwtfTjwG1j3ze7Y3TaKA9Ufjzs/P7GWcCyxbxR412KLcqAs2NncR6EUsM94uXe9RRizgrR7cOwZfP9ch7VSx9U=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R1RRd2hZaHYwTkxBWFhtN3dYa3UycEE0OFBvODNhR3NDaUVEM0QwQ3pWQm5V?=
 =?utf-8?B?Y2FqTVNXUVJEMVRuUk82bVRac2pDZlZycnViMHNkODBwM0xPYmdlQ1p0Y3hK?=
 =?utf-8?B?ZGFIeXJISkEzRjBaRU1JNlBBVkFxeUhGVmcxcEtIYjNjc0N0NmNGbEtrQW1U?=
 =?utf-8?B?YVhDVk13Q0ZvM1FkZmI4dXRLdjR0QUpyanRpTkpYUitvc1pZY3UzOTlocENB?=
 =?utf-8?B?MUQ0dCsvbWJCdk9ydE1ZeVAweHJsdVRDdjUvVFJXUEZtSHY2ajlmQWtvcjlv?=
 =?utf-8?B?QXdOK24vMTZBeXBDbEp1OE1kZm1lZXRCUlFlTnVBSjJyTnZRbXJmNUlWQzhV?=
 =?utf-8?B?MU1jQ1VGUFNBb3NWRWc0cng5NnFEUEhVbXFLS21SMy9rTlNkY0VBdEp3SGFN?=
 =?utf-8?B?OWpWQlFKSnlBbVFQOFc4L3c1bGgzTDliU2VZUk9kVkorUHR5TnFpakRWWWlm?=
 =?utf-8?B?eFIyVktUUU9abkxvNVhBc21DbjVaQjJhS3pGcGJ2cjZEL3orRW82Lzh0aktp?=
 =?utf-8?B?V0o0ckdNOSsvUEZNbXloYXh3bGdZbXh0UGdMUk5hMXcwa0xjUWxXVGhpTlU4?=
 =?utf-8?B?NjhBMy9pKzVCMFVtdGFORjN1cjZmWEl6R3dwODFqeFptRDh5dmM1U0JHcVpF?=
 =?utf-8?B?c3lzemErOFBhbjBJcmJLMW9SYjhZRk1wb3JuY2crTW9qcjFPb3pBM3VFRlRS?=
 =?utf-8?B?Sk5PNjdiYmR3ZGh2cWdKUE5yMjZ0TVVCbTBQL3JsQys3R1BlTEV2bi9sVUpm?=
 =?utf-8?B?MW82TVMyUjkzZE5yblExV3pnV1VPTmpRU3NCcmdXdm5iR0hoS3kyRGFFL0pj?=
 =?utf-8?B?dWkxYks0V1RXWWZWUmdjbU5KaVB2Q3ZzN2dHV1NpSlg1Q2FaelhjaHlKYmFO?=
 =?utf-8?B?MEt0ejZxMTl6aVlPSGhoUStsdEordHhmbVFXYXdHUWk4WElpUUx2S3ZxVkdM?=
 =?utf-8?B?dVhqTW1ZZnppVnpNRmJhZ2ZVS0trZHpMcFJvRHI4WndZSCs4YWkwSlVRejlX?=
 =?utf-8?B?N0czRkdZUkV5Uk15bHFzZDdkSVA2QTBYWkFqcEVWdVIraVNzODdJLzB5Qll1?=
 =?utf-8?B?cTdtVkY3NTdYY201NmpBcFdPTGNlTHVQVi9MS0dCS1p1UVNvazN3REpBWWRU?=
 =?utf-8?B?UmdNUzA4TjBySUZTcm5xeWp1NTJnRW1aUWZKRm0rakx0SWw1Q3RPaFlaNFls?=
 =?utf-8?B?MWlDclQ3QVRDNjJVQzZnblVFQ2hma0NiNVNlWHFnT1gyK3hWZ2hoSzhoenV1?=
 =?utf-8?B?dTMxN2JmYy9pZTZtK3FYNmtHNlJPN1hvSlNDTUh2THp3Rm0yTXNxOStSS0VW?=
 =?utf-8?B?b2NOMmFadm1EMWllSFFlUS8vaDk4TDFMMm4rN1Y0bFpmanFyWlNYYVFZU2RG?=
 =?utf-8?B?YU9rZGx6VjJvdGcvRDZibW5WS2tHQzJXam82YmxXL2ZMQVlOSFFWVTNmek1M?=
 =?utf-8?B?K3p2c2VhcjExZ1EyTGpYSjlVamQxRU5sbWtaREk3K1hPN09sSDRYMUQrUWcw?=
 =?utf-8?B?a05IWG1OM3dHU0lhMjJJUFhyOEQ5cWREQll2UmR0VnowVG5zbVkwRlhvQXJY?=
 =?utf-8?B?MHZHc1FiMFNKdndsaGZSUUJyM2Fqb3dXTHZWUG9ML2kraWlDcW9xT3V5Qlgr?=
 =?utf-8?B?bTBDRkJNVUtqaGRST2Z1dkRjL3VSanZncmZnc1VlOExrU2JjRkVxa0I5N2tX?=
 =?utf-8?B?OFRjNFF4WXI1TlNzc1Nqai9wKzh2QjBnRG13VTZ5VW5WUWVJbU9NVHBiR1ZJ?=
 =?utf-8?B?YUdNY2VSSHhqSGl1eURhUzFkcC82eHllVXVYL25TMXR4RExFdVUwRWxMcm5T?=
 =?utf-8?B?OTlJZi8ydmcxekNYeThYUkpzaVl2c1dQN3dPSUo0Z3NNOFVLZGFMcWtFRWZL?=
 =?utf-8?B?UmRXRWJ0LzFSTk5PeTlpbXlwbjVyakFXZ3NzUW5YUGNwWC9PRm5NQUR0WTVS?=
 =?utf-8?B?Zis0Z1RwZndHenR1ZHRYcGR3d2JkSlY0U1lWQTc5V2ZLU1FHWWNaOW5ycmlo?=
 =?utf-8?B?Rk9Hcm5rSWVxYTg0cHN5ZUxWR1FzNlUvWHBoWEUydGlMVmVQem13emxmQSt3?=
 =?utf-8?B?WEF2MGxhOGZBV2VYOVdrd0dSaThsZVo0aXc2N094MEF3WHhPVXdpRlhxNkZC?=
 =?utf-8?B?dDZ3NGxyYXFIeGE0ZlRLTXhGUGlIUnVZbWxYbmRGNlVXWVQ3Z09Ybm5WU2tj?=
 =?utf-8?B?MVhGKy9UWThPTjJqSWZFRlV4M29KUEtGVXdMRWNCL0JMYWVaa0JoMEpFQ0ZR?=
 =?utf-8?B?Smx4ZUFOdldSY1NWTU5BbFlrU0crSThKQVBvTEhjUkZuNHdjVE80WUtjOUFj?=
 =?utf-8?B?VDU2SUNaYjFRWVB3TzlwNms4ek8zSVVsdzdocU10Nk9nSTVEZTFYQT09?=
X-Exchange-RoutingPolicyChecked:
	pLZpcmb9Lsz6Lp60Dviqm3V7/P/C0Tm0RG/nybt5Vvvc76Bp0kbK0M5N3ihs93C6J/OPwjdMp0ugtBIBcptEdHXa1sa4dmuxP1V3QgUQkIHuYDAodlYtwdM6Q4A3mCZc/G88GkE65pGdSNRrIJsZkj2Tfm1xYAqTP0hN47cznh4k9TT9d504ZmEBMmE2Hur8kH75CHKW/nTA/7H/dx0u790hjyFzZatgaYb1ThtAp4O4705/ai30GDlrOE4+pgSZfuhLubIXRyIL9BIOY/bRHy/7vxKdfuU0oyIrcwakYy0D5HzNFhLMkU979fGYQkQ9NvpA3rQukNiA51LFZXvVeg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a920b2-4162-4c6f-3c74-08df102a35c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:29:18.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qIn2gFPY6RPuZhu/vCfxJ1pAD94Fdm3ZhkMInPaLQr0IMghGXHUbncywYet8z1F5U+U/A1eHjJ2UaqBI5cLag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Proofpoint-GUID: mn_rDM3FSSUhmIy5LaqPe0_B90FLXlKS
X-Authority-Analysis: v=2.4 cv=JaApPkKV c=1 sm=1 tr=0 ts=6aa43a71 cx=c_pps
 a=yf4wneJBeBA4fm5+j3KMTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=vrfzlmHFqV6-XNZspV0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: mn_rDM3FSSUhmIy5LaqPe0_B90FLXlKS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfXxoUCon1sjYBN
 siJFjstVavm/Z7llYklhEkEMXyvd6Dlf5oIf5UiRrppLa0AOwvT0C3AjR7E2MjDmDQioRjn3nmg
 FQDqNpxX8B4trkDCQorXaGdNSO47xLKMKL1jRmb1YLjpxB6Nd2oj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX0TaZLHchVM3m
 ky2JBUo+Twdw5UO702yStjBmh5CXXU6kmZ5OACSIEZcNa/of2rbZvIVPPzTp67JnP5TIZQNPg5g
 Qzt5iBBvFqAJcp4A10teOWqt8DPEgogBziRYk/ZuaBZVLLfFJ5y86oAlpxdN1b9UexxupAP+Naz
 uv0OT+a/vqQs3VpOsO1Jzi5BjFqfmFpyQnjkkc8Nl+nxf+vKDhO74WEaVs7enq0RAK5NxtHrLem
 jaJHOobEJpeMfvRWz+qZEgXAqxf3D1U7jgIToJim5LZ+BRBvV5tK5fRHt7mHY1yIUiBHah5joan
 uSZ2gUqVL3HzYicuw1DmPb5URss0ZunYxS+ChLYDOHqGlPSidxHn7QMlzYeKm5K43D5GkPN1Vgk
 qY+EiHxC7mnAo3MLgZ3nEqOIAuNNwt5L91oMzH0q/etM5PI2KibpBgmMg47AapP0oA0NO30IZMK
 SLYQmErFOcrF5pSSLzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

Store the common TX destination and RX source bus widths in a
driver-owned DMA bus width bitmap and populate it through the
dma_slave_caps helper.

This avoids depending on the legacy src_addr_widths and dst_addr_widths
masks returned by dma_get_slave_caps().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-dw-dma.c | 8 +++++---
 drivers/spi/spi-dw.h     | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index fe726b9b1780..bbd7ee884d0e 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -7,6 +7,7 @@
 
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/irqreturn.h>
 #include <linux/jiffies.h>
@@ -100,10 +101,11 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 
 	/*
 	 * Assuming both channels belong to the same DMA controller hence the
-	 * peripheral side address width capabilities most likely would be
+	 * peripheral side bus width capabilities most likely would be
 	 * the same.
 	 */
-	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+	dma_bus_width_and(dws->dma_bus_widths, tx.dst_bus_widths,
+			  rx.src_bus_widths);
 
 	return 0;
 }
@@ -253,7 +255,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 
 	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return dma_bus_width_test(dws->dma_bus_widths, dma_bus_width);
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2f2debc64e73..c27533ecbde9 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
+#include <linux/dma/engine/types.h>
 #include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
@@ -190,7 +191,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
-	u32			dma_addr_widths;
+	dma_buswidth_mask_t	dma_bus_widths;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;

-- 
2.55.0

