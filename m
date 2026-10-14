Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDD53CA6D;
	Wed, 14 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987608; cv=fail; b=V1Vq6caX8bHma1cbQLBl9g6k+WiyNQVqDJy1/sytA9abwJOwdgxgsDNRAa3L6xrMhDB/+ClmkpmSm42YjIGa4y0i8xK9Pb/+JBl/DLdVhREF67jWauPoqD7xvyuWrxsROZfZLNVyy/4LNhdoTXfOb5fPIMLsSZ/2kGHtvmhTelQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987608; c=relaxed/simple;
	bh=puVB45X1RKgOkGpTWbzvEAr8GCtOcmexopLzrDDS+7I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WDK1EvO0eDlmtJOkuAUhE5eMNZQ2Wy5xXXQgXyoFpvH1ktAprANnauTpsBX5qQbSRt8oSnTI6SdEolpTPDK4Na4UVKyOkrUDACKF7m4mrM8zMo5nI+Xxnlql3P7BfE4+Q1+XjdQsdjr2J3aL1GW6a9Zb8qcCB3WpFAEuzfP9g6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=gtYQMFu+; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Iw3ZvsJp; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="gtYQMFu+";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Iw3ZvsJp"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ED6bxs3826863;
	Wed, 14 Oct 2026 10:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ifJM/a4Ate6KBWHVKs08RDfmEwNcpRlie5PIePKROhs=; b=gtYQMFu
	+ykLMt5CMH8QZ1IdhuyDJKzgCksmWsX8UAxPodDZDyRZeEfla4w7hLdokd8qhgrN
	WNrOh7nCkU3dpddQPxVuNPQOQHhpgllANTGNnz00BfVRIG6n4x/T1Xo7e+la/5Bl
	sEi0YIulmSbchptY+nz9p/wdRt3+TU60ivv2CNTAVi4BqbJuGtDrHHWUa6OboqUF
	W/dCNYYfZTRIwjeK3XhTali3Lmo8Rk1dg+8blU5Zkca43li7SnGF41ULaHnCQfvn
	EJi90YKrOvaCBqP0NBXfGYZVHgtUHUjzHy5f/zcvNR9ZgwMy6yUc2GLX95l8JJgj
	UNGMyKYnxs4JM6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ifJM/
	a4Ate6KBWHVKs08RDfmEwNcpRlie5PIePKROhs=; b=Iw3ZvsJp4S2eCy/8kETB3
	MqyKV4KNAf5VzYUHtIo6lD7oFKRU1HVs+bRE1SernQ9DeGECkD0FvSdXXYLIKrsv
	EQjQtPgCoQr3Y7a0pDL1O7EdqTPVZsgdPWVkYHmte/xuqKmTKRUx4qeb5GWPi7B6
	JOUn/cuB6Jqr074ylTBz9lBjEw/lfXNX8OJ3D+ZtVSpLOiONWcxdaMRnrIRnfo5H
	NVDGoux+R0bQdj+8HVtRv5vgVxy14z4AQFWNLR66CJeFXTQISCXZ6t/t+kZLnOhu
	9r99tl/mp9ayX1KcrR/X8nAy/16kRta/jcb9/WPi9VS1iudbuOZQWOkLKdRvM8PR
	w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haab60grt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvBVKqFVM3Bh6QkAAck5Qn6nHat4tJIxOzXIaPTZ6dvR+4RfL4i5bKnkWwAq3Z40DwhIHEfv9XN6dlYMlNZa5C3FXxLkqv9GLl/6f1NV6iVKyLMJXq5/uiSaMpb4PCD2Q+Qcgt4SGexRj02J8aCpw/OnFe4fa1MLhect/aFz2xXf496iRSnykQy/f9CL+3PfU+80OXtkrgvt66IRL5Nll/aPERr/js5oLEOsqHf9zt5gyOY+qatYY0QFSRU27M5/ju002wHsnE/bMijceGToWYhw2b9xkK/Z9hj5ab7Rd6eeAj4iGPAHzvB0DHpZ9VBGaAHqUIBhSTzeu+WBBpFqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifJM/a4Ate6KBWHVKs08RDfmEwNcpRlie5PIePKROhs=;
 b=oqNLu1JHDfwBTCgEmVw/vBut67x82qtTTMfvPB5YeoS+c/XtL8OSjUH8OMOAAKrHnma5xg9s/bbTGiUaaVyQa4QFi8r07Oaqm9mjVYKqwEsKsPtYGQosk4Nz1Dw30TZnulL+UeMWeA4s4jUimRTT4rXWiyLc8llDn4dHUpv4W94fC3JyAEl48WsnGF4oNXX8ssa+C2diFl35TwR9rjthBRBmu99Iu+9jEz4WmMyFp1IDA1ojwLQJJim9ZMPCe9uwzl7gp5nU/2b1rcptamBi3Rq5RwJC/VqZgJgzoRPD/TH8vDnyn4pEF97GaXkd0ZcFzSx/5XWSpT+AwN63uaqIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:18:22 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:18:21 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:17 +0100
Subject: [PATCH v6 7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-7-5b3ffdef8191@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=2752;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=puVB45X1RKgOkGpTWbzvEAr8GCtOcmexopLzrDDS+7I=;
 b=FBCxZMrg3XTKOR6ph6uzdN5lm0ygqRNBmIcm4Na4hs0BgE9v+/mb/at0oGeyNraqHzzsj2Zqs
 /LcjuaMmFcgDKMmYHmKb0WxVjXyoLV1LvpHmekjEm+nFAZHjoAGy/Ng
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 743d5f5d-112b-4794-b7f5-08df29fe0060
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 rWo7JaoX103e/NbmFEq/WjG1uNoz66SQHIGWMexjA/IkyJinGf9+T5N2rVoRlItcKv88HDSX5S8X/7Xb/ZXcf8VeWntz6V9wfH2ZewJMnXTA0DR+TvtraQD6F49a3hNwf/iVfMvi+ijBFBxAX95cMNkb8BLUZYfa3lfmunAC19zzNcHZei5vDnsoBvFP/l8TNTz4Ky+cI1AiCuhAeKXRv/2cWXFQwNC1pX0rME6dYsocP1OTViWtQlV/Fp0/G2wYr37+Si7jpy6SjcAB197hE58T+VWMwqttPhoTTOSF4w/9DV8R0ep7p3BiBAyD5eVAx0w84p8bf5yFXN/rxATv2BppV7npaheK+QTd40kYutN0MRILqQOOEuJtM4b8aOZdqKnNxivfRSFqi1MNZFQzDwvFZXx8QVg9Y6Cwh3LRbke6tBZl/dUrfS873i+c5XKKuEopD7hrhGbdgJNs+LP0SfFLSaSIRXWFBJhpXpTL7oIxvJHwCfDgYwCH0Ty48JfiSf0bymoGle7JaDcs/y4laNC2Dzy5yXbLsS2/dW7odROqb7xvMddUnkwel2K1HAfMKMw70pOopkhBqOCIOUfTU6rIONsu663dlzuEMSH4UveqrRzi9suq1+nkdJsmJMGYWqsSfkOXemGzkYLNLH0BVHLPmVeN6PERCFnE4XYcuzM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RCsxL3EvbEd6Z2JrblY2eTNjT2xLTWNxOTRFdkVkd1BUSUZvNlQ1Yit6b0Vh?=
 =?utf-8?B?djd5azY3WDRBUWJjTDhVZ3Z1N04zTy92NGF3UWhnVDA5WmFibU1ZNk12UXR3?=
 =?utf-8?B?RjhBSEZhZ2lqTGN0YXB4NGJ4N3IrTkYrczluWG9pRWtvUGJ5bE83UXBZSHd3?=
 =?utf-8?B?MDVrdlJjR0hLemtubEY3T2s3L1N1cy9McWxTSExLNlNwbDdrTnRuM2R2TWJv?=
 =?utf-8?B?SVg2TmxFUjcwd1pnK2FkUVJkdy9wSDZDK09Sc2Z1Q3Nyei9uekpLYlFneERx?=
 =?utf-8?B?V0xsUlhTOU95b0t4UGhab1l6VGMrdWE2ZGFUL05Tb2VPOWpTbTBNSXJJUk9Y?=
 =?utf-8?B?cnFLR2M3Y1Q5Y2xPNklDZFU1SkdMaklLRzNZc2xOR2wyRmJsQjM2NTFNWWhV?=
 =?utf-8?B?SVdIYWsydTRXNVVyejVGMkZUNGRZUVNLZmNLTUZrK1dydHhhd3A3ejlPKzQ5?=
 =?utf-8?B?dEwzYlVwaysvL2R3QWxJYS9VZUJsT0pXTHpIUXdxZzJzdmVNY2hrSTlKa0pl?=
 =?utf-8?B?QXRPWWdEVklRRlpqdjlwMW1tOWdxREhaeThIZm8zVFB3SkVaRGp6RHppS2dB?=
 =?utf-8?B?VmZHc1UrQ0dSNTF3RWptZ00veUF5NHlEYzR0Unh3bUFTSDRocEE4b251a2Rz?=
 =?utf-8?B?NTZidzBHKzl2VXJlOHF4bW93eG9UTEF6ZWVRa3l0VHQ2aFdnaHJpV2FvL2o4?=
 =?utf-8?B?Z2d3TDRhR2xKUGxtengyUXkxQ1VsZGJCL2Z1bW5MUmNjQ0RtZlFoZWxJOUZt?=
 =?utf-8?B?KzVhOUdDcm40YUFTL2hobmlicmlMd1RyMHBPWEQ4R29USklzTGJMdGkxT3FG?=
 =?utf-8?B?K2t0M1J5SzY4MkdWVVgvN3NNTm4yZFJYbHFHczlyTGVqN2lGQnVHZlo2a3Yr?=
 =?utf-8?B?WDhMcGVaTzJNSTZxTHZQcHNLSmhueXg4UExYeWZYc0s0cllUL2VWVmpEZnI4?=
 =?utf-8?B?RVJ0VXNPWEw5eEowZFJPMENZdVREdlI1SmNxYmZ1WVdoM1o5TGNHeW1ObGF5?=
 =?utf-8?B?VDhFOWllNnV1L1czUWMzK21qdmN4b3Avc1RDWHZGTzhRc25sUzVWZm1IM2lT?=
 =?utf-8?B?aTk3WVA4ay9wbmRXa0czSjBEdGI3ZldRSnBwSmp6M0MzVStUYjQ1Rmo5cEdU?=
 =?utf-8?B?VHlZTDRiQWNwM0ROUlFWZlZPVXJWbU1nVk42UE1PQ0dZYnA2d2ZEQTlnaDZL?=
 =?utf-8?B?TisrVkh3OGxkTVhIUjlEV3hvNXBLL2RJSEwxUmFTWWZBNDl2QVo3RGgvd3Iz?=
 =?utf-8?B?a2JFUHQwdUJ0ZndrQllmMkp6UVJBdHhiZ05idjQwczR1TEdsQ2JyZDFhS0pi?=
 =?utf-8?B?NWVmRzNNeUhORm1tUGcrV2FUcTB2blpXaXNKQzhSYVBtLzBrelNRcVRGTXpG?=
 =?utf-8?B?bEp0c1JqbzI5a0lJM1N1TkNPS1RsdHNFQ0xId1NTbVEyZXlrY0VJWmIzd1Bl?=
 =?utf-8?B?cGpLL0ErYk9abWdESk53a0xxZDk1dHByNUtuUVJzZWZ2Z1dCMGlzM21aZ09i?=
 =?utf-8?B?angwRWJWc2gwaTZkdkFtK3lqYmJXdktEdWF0bWRabDlhYk5ZbkFNc0Q5NWk3?=
 =?utf-8?B?OEc5L0lZbHE3K1BYcjJLMGN3QnFPOU41eXhtKzhrTjNaOC8zZDY2TzU0MmZV?=
 =?utf-8?B?bVFKNmhTT0RyUVlMYUlEZ2d3VUlONno5cllvSDF2MkppUU5QU1p3a2FoaEoy?=
 =?utf-8?B?b0lPYWZuQkQ5MjZ3WVhkN29kZTAzTnR2SEQ4QlIzajZYWm80YWQ2RU1JUmZI?=
 =?utf-8?B?N0Era0Rna2l0Z2NHdTJNWTFiVHc5SG05Q2lKR1ZJcnNNQ1MzaTl3bTBrZGVY?=
 =?utf-8?B?OGE0NmRFQUNWTlhRNkRmeEZySTU5eitLL1BVVlB3eXdCRWM4ZXFJS1BNRG9F?=
 =?utf-8?B?Mk9TeUlrT2pGSVphaytOTWpqWG5lVmZ5OFd1UEZ0cFBrVHRzL2hLZEJXMzFF?=
 =?utf-8?B?aGhkSUVFMFlDV3hlRDBDdkUvWENGT3dMU0hrdkhRQU5NTmhIVWt2eUI5RmpN?=
 =?utf-8?B?WHpIc0h4eDJkYU0xL0Uvd3ZlbXJldyttMGJVTWhuYXFiRzhxMWdCT0ViaTVs?=
 =?utf-8?B?Z0RDdnNlS3ZNZS95K3g2aGFQNzQ2b2sraC9sQ2RTQnJ2ZURKSFRFUE5obW5Y?=
 =?utf-8?B?aHI2d2c2cGhxMnhVSXQvalEwWCtuTlF3UTBkZ3A2N3h4VFUyZE1GZkt5UnZP?=
 =?utf-8?B?U3EzR2h1b3pWL2o0TWNlTTRZOGNQSk5zMVBGRnRTbTc2ZVFvNnhXRlR2eURx?=
 =?utf-8?B?NmlFVkJTaC8zRXVOTnFlSDNnRFpGbEdwc01pSVpaaDkwYVJBVnoydUVhczdG?=
 =?utf-8?B?NVI2bTNTK1dDL2doNnpsa0hlS2FVZ3FXSU1OWGt2RStOOWc5TUFMQT09?=
X-Exchange-RoutingPolicyChecked:
	e6Fypf6JQTDSrj7qxH2k0MUxedVywWJbr1m4xedDzY0TomYpO2iI/kn78z8U08//upwa2kBy3Zv4nYBKbFKD/O514KHEi4pUDmYieGIhlrXLt2DGL7ri8Wjr4z9Pf9WIGFLyv1bNm+jjDTByn5qWsDUwEH1iit+BGM2oHBsNu6H3s7zqcMt+jQUnh7TBDgboFc9/FZzcr5OLNVWJokSwl9bz19eRDkYFFwdiJazJHhO6J5bn6/EtBxPhsyLh4I4GNcL2ydjV2PijGqLOo5tWrRjLO266DThAfjD1AHKMoBS7zucb+iftfPGoLFZTOlsOmcPJOdKP77lCOwQVFkVosQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743d5f5d-112b-4794-b7f5-08df29fe0060
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:18:21.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOEZCTYNLk8kG93khtABeTc3xqlspoj7U4jgakO2iMqqOQ9QjZggfqdV0/Ue/qFf0aQGrNG/gEhObtjxJ9qaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6acf8f31 cx=c_pps
 a=0XF06BAwF4INxAelKEegqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=RbNyKOt0vjK77hBBhwsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: AIWNBj4HPvTN30nWfQaNKNvdYGQB0NI1
X-Proofpoint-ORIG-GUID: AIWNBj4HPvTN30nWfQaNKNvdYGQB0NI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfXzoCP5aS6NFig
 Vtcik51x+WEWeOPD6Yn7n8+MyShuhUlnaEMxaEnrc5Q//CJ4zu21em3JOYcUlUJdcxyN7GxI00v
 0QHRubw4AOr9imyO1DQyKUe3lrt7JuD1Rlg17nBlPDCZr7+ygsdRK/aqoOzyIiv1wdZmJEzKVK0
 LEUyxcTrox8b1Y7RO0rifaEMLKXHmpwO2p5MI/rJ+v3ltTVsR2XcI2UOMjvyKtsYSxeqrn5oXqT
 2sbFAzMqjyYpbDxTLNPofXx8H03InW3gVXqU7YuUBmT+HHxhNFJHOT/Qu53d/bfXl0DMNe4I+L4
 Js9Be3SXEcTTz/VQQ4CFOUpKqNzQahv8SQATMIUhptMNorJXIm6eC+EGySwFClY0FI3NXs/iO/g
 N1sWM6ttNgbkB+fGxyxhm3JcSB/HnN63hyC2qoqfxeU3Qxc5HWxVVdzVh3AvUKv3GDinWpD4dEr
 Ms0ctMV/QZ4New7yhLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX+1+EkKTbTtWX
 uTx5RAZaR67feLoLthooPsth4y4Mq1nokiN76mYiM4z9E9otrRg0uU36hRThiMq4at6jC2Otbkz
 OeHjNGx4ScbCISPDXcWJkf47U9QOJMiW1VkftAVCz02W8IxHFnDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140056

Use the dma_slave_caps bus width helpers instead of reading the legacy
src_addr_widths and dst_addr_widths masks directly.

Keep the existing default assumption of 1, 2 and 4 byte widths when the
DMA channel does not report slave capabilities.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---

Andy, I decided to not go with the implicit call to bitmap_zero() in
_set() and _set_many(). The reason is that almost all the users are dma
controllers where the bitmap is initialized (given it's part of the
dma_device struct) so it seems unnecessary churn just to make one caller
"happy". These APIs also follow bitmap (set_bit() included) semantics so
it makes sense to me to leave as-is. Added a note on the kernel doc
though.

And it's easier to add the implicit call in the future (if it proves
necessary). Removing it, not so easy...
---
 sound/core/pcm_dmaengine.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171..c859e98e944d 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -408,16 +408,24 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct snd_pcm_hardware *hw,
 	struct dma_chan *chan)
 {
+	enum dma_slave_buswidth default_widths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
 	struct dma_slave_caps dma_caps;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_buswidth_mask_t bus_widths = {};
 	snd_pcm_format_t i;
 	int ret = 0;
 
 	if (!hw || !chan || !dma_data)
 		return -EINVAL;
 
+	ret = dmaengine_bus_width_set_many(&bus_widths, default_widths,
+					   ARRAY_SIZE(default_widths));
+	if (ret)
+		return ret;
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
@@ -426,9 +434,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			hw->info |= SNDRV_PCM_INFO_BATCH;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
+			dmaengine_bus_width_copy(&bus_widths, &dma_caps.dst_bus_widths);
 		else
-			addr_widths = dma_caps.src_addr_widths;
+			dmaengine_bus_width_copy(&bus_widths, &dma_caps.src_bus_widths);
 	}
 
 	/*
@@ -460,7 +468,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			case 24:
 			case 32:
 			case 64:
-				if (addr_widths & (1 << (bits / 8)))
+				if (dmaengine_bus_width_test(&bus_widths, bits / 8))
 					hw->formats |= pcm_format_to_bits(i);
 				break;
 			default:

-- 
2.56.0

