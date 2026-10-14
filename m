Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE055304BF;
	Wed, 14 Oct 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987593; cv=fail; b=jZ3NXQ/Klpv89NBx3ze1fFGCUqA+q2el4QvKSTRRklkj8aIcUlBcBVu+docqKJ4LA3iaeEUzhvGYHPWa2BcYWG1wuNS7vChUgnqEpBM8YplaIk/PZ26IXQd3piMjomRKFxYpEDm80WbxYeDPhggBdekZwwPLbSaUQAS3Ky3n8Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987593; c=relaxed/simple;
	bh=rYpgx3KoYC5GyrGTGQEsBS0Gv0Jl5witI6DUGypDBJ4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=j0QcgQhy1W8Ewlar3DsHNgzkD3Tl1wbJ/WRIMPX5nWe71R3D0HfE8ODfZQA6pXD78Xui71I+M1lwBliIlazab9V2R/gSnZPZt2Fb9YjvWzVJlNumLU88QoqG/VQn9fYddZPDJ19DsFqUWhxj5BmUwweXcdDiEPC3RunMFhwsdjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Z3LqsIXe; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vMHDxfgH; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Z3LqsIXe";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vMHDxfgH"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EE2nXA2737287;
	Wed, 14 Oct 2026 10:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=MkcNJV1A/lXNCqQs
	hSu40i40yBNCXvh3sI48CSAcZzo=; b=Z3LqsIXejzJie1kyLAmQCiv47j3oFiq6
	7iqYdDUKidELgfLxEgNKiy++4Ec+QWqgSrfl4+4aIHScEmV3uvL4Oj26bqLWsflp
	feHR187tEY9G9v6r4xJz5FuoqN4Qe2pzw5kdBkll8N35G1E6SQ75GyROdHDqtlwd
	nz0ZJBN+xCWCZqSTTBdUwyz6yMOZsPlA+IK3AJ6MrkB6CDTgFAWsOA9eFwVoo1UD
	DDZtQL+2sq+HmVtE1UOJOkVVQQ7PtssFp8k3iE6Dw29L3GxlWhROEoG3KTXWjZDO
	BXHMCGhAnye3BcQ3dDQIdn2ZDj/IGogiF+oH6PtFEv5fSeFosqvhAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=MkcNJV1A/lXNCqQshSu40i40yBN
	CXvh3sI48CSAcZzo=; b=vMHDxfgH+pvUDZJaM9n9q/U4otOZ8FkEGqhBVECZ8EH
	4Jr/MBEwpjD8eSfbVPffbxem6TjKqzxG+7g+rjmcOSggVwCjC2ByBPg5Gkz+Jlb3
	Mpv18EBbYAlIJ4NgCkHXjHmrNZxm6jNOsMGNgMXKtqwXOcXbLzWAv7F6D7BYh+f0
	SwbViBv3OnPl+vJHq19WYhEPEHLXc4deUhkLdsRQQucie0zdiaYo0qFsvt5drAt4
	5f2lQ68P7o2GjANPj2Gvg/DY6nBw/CTQZs90iEYkvh8mPx+QUR6Lom2jpf2RqgD7
	6OJGWPJJDG9ZGqqcfY/S5hMIn1gcTWG4qk7StagwU9w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9xnsccyu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:17:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvn6dB9PxVWxx7cevI86d9G/+8etpeYfiG9MmD0SpuDAOgD8qu8G1EdXZAERnJTYlZtTbllgj16G9s0bZRuiA2Vsw/kvOlA6g1gHYecVoK1C/8+QXv1cr/SzNKikjuM/2qkWHv3SoFCDm1EBTN+hxBF7y6liTGtO66I7KiYiHUaGPNSfcWA56NlR5o8aA7vfYi0Qbk54qYgCN0WQGJDr6lEzcBw3Wsvy2C6rtutxn5cPRbaPRJKAD6JlZ3qwLaSJFTrCsONjWcAlsA9GpX8we6cd6mfHGS2xWICzein28I5MSCxAdQzMAeusk3wpH1PgSDTORSyJXY3u92pfr0YqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkcNJV1A/lXNCqQshSu40i40yBNCXvh3sI48CSAcZzo=;
 b=D3iGwfPeuj6+cWIl9YrcfDDUN2LxUV3fJydO971fT8xKp15YNBRxHop+nG/Vw10R4WpoUekdaUMk2oFwdL9IPWq289vd9cv1Hqqqw/T8wWHYkgl/PZONCtkaFwWO7lHVOByy+dJrj5pXmhGdSlCEAdGVnKMsUL0pXUjgpa5Gn8QXkiHkkmOEQj9UqD5zI9NiQE099FeZ+7rDg3owZh9H7d+tDwxvq1xlRecjT8MUtxGjE+MqGO4VLkWt+JA6VIVXpnwoaCrR++NUAp8JNhQdvNUEttzoU11bFAwCtxe0xifLF+Ae/oBZsDERhVHdXW4Cn+N0ZxONIxuCU0X4KsUF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:17:52 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:17:52 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v6 0/9] dmaengine: Support bus widths of 32 bytes and above
Date: Wed, 14 Oct 2026 15:19:10 +0100
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PyU7DMBQF0F+pssbIs+Ou+A/E4sVDaiCD7DSAq
 vw7dhC0qBsvr/V07vWlSS4Gl5rj4dJEt4YUpjEH+XBozAnG3qFgc24ophJLIpAdwI19GB1K53m
 e4oI+gnWxvKMB0ltCAsAQyrVyVDXZmaPz4XPveH75yencvTqzFLhcnEJapvi1j1hJufvtkxV9K
 0EYWaAMWms6JeQTjPA+9Y9mGoq+U4rhWoopRj3x2moDt1TZvtLrupZUkTSTxKtO6dZiJvwdyW5
 IRmpIlkmBldWKa+mpvSP5ldSkiuSZVLRrveXGqNbdkeKPJBjrGlJkkhvuJAMFBP5/fNu2b6dQ8
 CV8AgAA
X-Change-ID: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
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
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=3238;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rYpgx3KoYC5GyrGTGQEsBS0Gv0Jl5witI6DUGypDBJ4=;
 b=a4Ddd81/qqGfKpRLiI9gwWBuJXIHp8oAnJ3/PoVTxxcmCtxz/R/mt28xiOkKKBzFRJg9e19Cy
 Imj8yvpzRkpAbY51elg5boVkbe3Y6cf76AX6xbjPOolgSjvAaPSlPXS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0072.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4fa7bb-23ba-4200-0096-08df29fdeef0
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|18002099003|10067099003|11063799006|261009223027099003|261009221227099003|261009220027099003|261009223327099003|261009221727099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 54HpsqKoSfy75ftTDu7KDIwjXPlVWirFP0ZAdg9X9f1eaF/PnCm7CVYobKyOjvi+ZDih4JfC/tFu6SZ+OEA+EXuOqHb8e/6sLImET5Q6zfNAk9PvpoUU7XchKrSiZZUtxwpRtuyFy9BCs44NfOzIS+flyIeo69DIZ2UXNfrElpZE8Z4Ph/CsMbg58S0WdmMM28muVvp91B5nMu/SZMb53rHBtgy8gvQypMuHNv3Nx/ogWdNrlQG7bzH/zJTiH1ovbH/nW6c+N8Hc6Qth/Tsi+0gspG6+ce6lZaMmKft/hvEMysqJvxJNfKnAU+AE7bHYtSCEM3rWyCGaf1XUKGdmMg5Exp94MXu6F09VzXU9V+PwEIqLRQOScICY8EMPHRb86rt+fQ2ThjaPHiLyS0TOCmGoCJThEEh7V0kQ/jVirq4X+ohK23DHwYlSmOBdS+Lgtz0nQFHlsZa95O/loi42ONlpmYhSzCnaMy3W4/dlB9yV0m+z+CHdgaC2EoYEoU3sbcPJ9LyE1xqMhrej45dKZFHKax1jfQSrWNc9ibCviT38Gg9e2DWjDA/fzzFwW+Zsg6BbvwD6TYaPqJpEiqXksnPiZqnoUa5pN4iLNBh2mNk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(11063799006)(261009223027099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009221727099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WExncnhmYVYrOVFiN2ZoZHR1clFwR1RXd1kyQytjOWJSN1UxbWRJYmJONjky?=
 =?utf-8?B?YTZFdlk1SHZLM2hUc05OdzU4bkticmtMdSt1SWdneEpQVUxxZTR4WTU5bXZ6?=
 =?utf-8?B?d2RMMHNvYXg4WkNzMW1aSEZ1Q1hYbjhuY2hUYmo5ZVJ0TGRqZjZNMmZHSVEv?=
 =?utf-8?B?SE1sQVp0cGJnZHh4RDl5RkwrQkcrc0VJUFFVZFJ4OHBTa2Zobk9CS2dsd3p5?=
 =?utf-8?B?d1JyUXNycGFaczVFcGpZQ0hMeGNDcmY2dTdrSUZ5SVRZc1BKMkoydHVnUzZX?=
 =?utf-8?B?cHJKdmpZdHRJSzBwLzRQWjhuS2FTZ081bGl2c1l0cnJZUVU1aWpYcXN5Mm5i?=
 =?utf-8?B?NVl4cytMREtBU2tqY1hDQzNaMnZwMVk1MzlZd3p0U1laQUE2YzV6dCtlZUFZ?=
 =?utf-8?B?WGs2ZzE1cUtQeWplYy9NbDk4NVFGc2IxcEdKR24zQ1MwR3RVR29DaHRLaFdC?=
 =?utf-8?B?VHRHdmx6TU90d3h3QmZ1UjdJajhBUTZoUEsxcjZRVCtFaXo4bTNRZG5LNUVC?=
 =?utf-8?B?Q0k1cHNUWlVhY01Qc2IwM2t2WllocWhoS1ByZ3dVOUlCRUdQYWtLeFRpb2Zj?=
 =?utf-8?B?MUN1M2owWlFhUG1LNWw2ejVWUFQ3di9XbmNwSnppRVBuTUJLaCtXY0t5VVNo?=
 =?utf-8?B?dGoyTy9Zd1RBaDB0QTVlZHJNUkVMT2Q1aW5JZFRzMTZCQThRdTUvcEVEYW9t?=
 =?utf-8?B?OVBRMElGUU1sN3RVT0lCeW9vRGJWYUhOWWg3WUJrVCtQc3Zrek5rMVNmajhP?=
 =?utf-8?B?YklBU2NqWUYyNFU1Rzd0VTJvZEZjcDI5Q0NHQ3ZaUlZPUW1EQkR2OFlIVU9J?=
 =?utf-8?B?d3R0QnpNL1BmTXE2VTJzem43OTAxY3YrelhCRUI2SW1XR3pTZkoweXVFdG13?=
 =?utf-8?B?Y1ZwMVZjQW04eEhTWURyS2FXWTQydHZpdFFIcFd6dEpSb1I5YVAzYnY4eWg0?=
 =?utf-8?B?WFV1eUE5Y3hmaE85bWp0b0lNTGU3eVBnbVBsQzdYZ0ExZVBBNCtPYUFCVDA4?=
 =?utf-8?B?NW5oeUFvaEUrdXU2M3pKT1Z5SWdRVUpuQWJPRGwyV3djdCtrTkVhVFdadWpC?=
 =?utf-8?B?Q3c2OHJMd2ZPRXpEMWhHNVhxWEFIK1ZJbmhpbDI2VjBtZ3ZqVis3b0pacDZa?=
 =?utf-8?B?NWUxWFdOZlpPQVNFbDBYTm5LS3ZWT05aZlZWemthdVlnR0lVcFMwU1B6NFNX?=
 =?utf-8?B?ZGQ2Zm50bmJXSmpucVcyUFZCS0lOQXM5aFl3U0piaDlBQ1h0WUxrTFFRNWlB?=
 =?utf-8?B?aHQvc2dMb1UrMkplTzZiRUNsSVh5U3R1SjdJdkVzOE1MUVhiT1crQWgySElo?=
 =?utf-8?B?VFFTbHNqSlpmcUhXNVFFZE5LQVN0M1c3cTVXa1N6bGxGbTd0RHNtWjY4SldL?=
 =?utf-8?B?TVZFSzFkUXRuS21LWloxMnlObW15WHhkWTJ4MjExUHZiVndmbGY2ZmlTNmxl?=
 =?utf-8?B?d1hjc2pNRGx1bjc4ZTgyY3B4S1dQVE1HVG1ydThDVSsxRkNVTk5aem9DSmtP?=
 =?utf-8?B?N2hBbm44UTBwd0RrN253NkVDRFFZcjNQNExmWnFJT2UvMGNjcVhwN1hBNmlX?=
 =?utf-8?B?KzM4c29FbjZ4eUp5MCtFVUVuY1Q2T3ltWWtXSXA2Y0kzNCtSMzZRRHJRSG1K?=
 =?utf-8?B?Tjl4d0JsRXY2ODdrUE0wNnVkL2ZCSW1aKzZFOUl5blE2SWlaODdyK3FRUlc1?=
 =?utf-8?B?ckQvTUMzcS80MUlST1ozbHZNMEJJMlp0dXFrNjJKdjBhZFhUenVwQVR1TWVv?=
 =?utf-8?B?V2ZhY0hvUVh1U2pudGVUNjN3YnJSZVNNd3F3V25nMDRDUVNIRkhYMVBlNTRp?=
 =?utf-8?B?T2t3K21VeE51UXkrd2FZWEdNN1V5QlY3MFZhSmt1amVOeEF0UTdYcVdMUmZs?=
 =?utf-8?B?SkVQTDd0WFc0eHEwQmJkQTcvb0dlSHU1NzRTWHl4Sk9adDQ1WFRJYjc1Zlov?=
 =?utf-8?B?QnlGSEZGd0IrVUdRdmMzN3RsSXBnL3AzeG5vV3BMUXk4ZUlkaXZwYTFsOXB4?=
 =?utf-8?B?MzAvV2ZvR2lrc1A1MVFMaGI4RFp6RjN3d3JoRFExY2JGM0dRNFF3dms0bmVw?=
 =?utf-8?B?aVZIQThmQUw4Ty9TOUcrU01BNHNtODN4SEF0TXVLKzFub0l6L2NYOEhRMW5r?=
 =?utf-8?B?eXFFOHpmTTZYWHZuRXNWUUdKNy9uV0J0TmNidTFvR21WOE93eDdVYThWQ0JO?=
 =?utf-8?B?WVFzdHh4UkhuM3Mxb25NN1VhNExWeElLdnlBS0g0ZEJ1SkhqdU1SdW1HZkls?=
 =?utf-8?B?ZFFmNGVjNkIzSGdGNXQrTVNWV0ZwWlh0ay91aTlXM1dwTW5MM1owZHZlWDU2?=
 =?utf-8?B?Y0lITnB4UmFVUFpHbXU1YlRVZHh5QmxQUGZiRHRic2tOUU0vdCtFZz09?=
X-Exchange-RoutingPolicyChecked:
	RemvYkkMES45nPiDI9tb91CdTzAbWYOjvPE0tm6pRBeweBaBvBULB0FD19mgi+IRUjgi1HJIjUc+tMdOU+Wqifw0GgslPFhks56pRXruPaW6TlP3+mzUKZrCOhX8msATqrP7td/+QQtlg8zlZEggP0UjDC19f58YF5NkUFPAoUx6yfgEcCgraWvZiPyx4LhJTEW0hvd8Mz2+jRap9Xd5X8zkTf4UldkUe4vBt+awZ9a9LMBz35PGi9dIgNhM+4IvQlW2pFi8Ew2YGwZHp4mRM8HINTRW+W3YONu9YoD0cHvald2A7xnH7GaTmHou9/2TWKH42ug9ZX9eMbQifHqwVQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4fa7bb-23ba-4200-0096-08df29fdeef0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:17:52.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9J0aU03sJMUIvoGgg7MpSrBQOSaFVgB2O6Z69RA24ohhEmcKQKJQSZIG9Z+hzHmQt0SUiNyuXh1itGEmfkduA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Proofpoint-GUID: WW_OmG4R4eiFz5lSlElerIzIVT6Gfu_i
X-Authority-Analysis: v=2.4 cv=MIr1C8Zl c=1 sm=1 tr=0 ts=6acf8f16 cx=c_pps
 a=qCFiEXCgs887QpJba4awmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=LA5vrRYEtGaYHk84EFoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX44YeRHF46Tig
 2Cx4ZuMnUMywFR9OtESBcJ+k3w7kb9KMj6yaqwcYjzilgugOdFI2Se+Fxzneam+w04hi8f5mVGQ
 d+CnB1fR45PJ6vaEjsqDHHfvhn3zUJq8zqeSfTtGml3dMuo/IrF0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX2ShRkQrih9CQ
 yIa8+EsMKYUUWi5XuZrsEJBw44NEpt253Irl5he/YJJLlOmEJ/qBisK4PikQwVxwtAi2wWo4apS
 QYpKYGe9OACLFfu/g7p+SFL5ydxCy4v1P9If00chuMW+mcb9XsP/THAnbAF5ymplcMqFO+gvhqz
 dk6yalu3IPQG9PV20yCEL49H1x0Ryn9vdNJ2EpOOXWOKP/osnEGHeuEImBeAAQ1if9qZcjJSsk0
 5gU6o1PYZLtdixfY6Nx0oNitDdStdaHqqF5+q7SZWBtIY8eM0YWP1JFF2ioxL+NbvUTI1ZtXgU7
 J/BQk/Zl85XajfJBT9FTXHV+RVyptT/leFN5dxnN5Is4ZxSevKqWCxgizZR7uBY43XzruNKNLYG
 gm/q/y8Mc4mscdFHz3OcC5TxQcGKZuP6kxWuYXOienMIy2TJmGGEvQchQ0Ocq7gD9RsIRG7qNfm
 8jnz7d4D3gqCGL99QCw==
X-Proofpoint-ORIG-GUID: WW_OmG4R4eiFz5lSlElerIzIVT6Gfu_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

The DMA engine slave capabilities advertise the supported source and
destination bus widths through src_addr_widths / dst_addr_widths. These
are plain u32 bitmasks where a set bit's position equals the
corresponding enum dma_slave_buswidth value, e.g.
DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.

The consequence is that widths of 32 bytes and above cannot be
represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
32, 64 and 128, which do not fit in a u32. Hardware with wider data
paths is becoming common, so add a representation that can express these
widths while still using enum dma_slave_buswidth.

This series switches consumers and a small set of producers to the new
bus width capabilities, represented by a dma_buswidth_mask_t modeled
after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
so the remaining DMA controller drivers can be converted incrementally:
dma_async_device_register() folds a legacy-only producer's u32 into the
mask, so consumers only ever have to look at the mask.

Once the remaining producers are converted, the legacy dma_device
src/dst_addr_widths fields can be removed as a final cleanup.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

Changes in v6:
- Patch 1:
  - Prefix the bus width helpers with dmaengine_ (Frank).
  - Drop the wrapper macros taking the address of their mask arguments.
    The helpers are now static inline functions taking a
    dma_buswidth_mask_t pointer (Frank).
  - Drop a stray blank line in dma_get_slave_caps() (Frank).
- Patch 2-8:
  - Use the renamed helpers, passing the masks by pointer.
- Link to v5: https://patch.msgid.link/20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com

---
Nuno Sá (9):
      dmaengine: Support bus widths of 32 bytes and above
      dmaengine: dma-axi-dmac: Use bus width capability helpers
      dmaengine: dw-axi-dmac: Use bus width capability helpers
      dmaengine: qcom: gpi: Use bus width capability helpers
      dmaengine: stm32-dma3: Use bus width capability helpers
      iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
      ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
      spi: dw: Use dma_slave_caps bus width helpers
      dmaengine: Drop legacy bus width fields from dma_slave_caps

 drivers/dma/dma-axi-dmac.c                         |  13 +-
 drivers/dma/dmaengine.c                            |  23 ++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 +++--
 drivers/dma/qcom/gpi.c                             |  11 +-
 drivers/dma/stm32/stm32-dma3.c                     |  37 ++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
 drivers/spi/spi-dw-dma.c                           |   7 +-
 drivers/spi/spi-dw.h                               |   3 +-
 include/linux/dmaengine.h                          | 188 +++++++++++++++++++--
 sound/core/pcm_dmaengine.c                         |  20 ++-
 10 files changed, 289 insertions(+), 67 deletions(-)
---
base-commit: 42c31fec1ca76b8b5f7759def122d418dff2cd4b
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá

