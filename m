Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00154B1DF;
	Wed, 14 Oct 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987610; cv=fail; b=W2Mb2b5xpVFAvXEuh2Cp5leyRQ1WSL3uLaC8ESqrveTuJNhRRH5WWH8k2Tr50xi/WqOLkYNzI4/7DsRcWXKmqaYGoQG5CQeUzMGCG0Gewo574Wdn20Ei5u9JEcWHtHJYqfLoje91r9+Vw9EieBkgKa1alVrVK7rwNvF6L8XoLDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987610; c=relaxed/simple;
	bh=ERCY1kTyAN/8u+Srq1WoTOZKg80x2x8brLfTCDxviHI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LlS/GuHTOcjfvobYWlV7ZAYGOEm8JXyVXjNJRcQCi/FIuAaqlVervC9EdvLrojUAzBkMNWlwgy3VG1aMXStNe49bssqVxjhYI4/gPNhsb2CBv5KKxxL3p/UEIFL07N1b1F6mI84UgDwVyWSGJ5bfheOFsVLGWcEIR/G2BUu5ZJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=CIR+6123; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zja4Ao1i; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="CIR+6123";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zja4Ao1i"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EE3sE14070820;
	Wed, 14 Oct 2026 10:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=RkSAXSzwkkizbDjzvuzm11ZJQCaeWJPpCXL+FVmOieU=; b=CIR+612
	3McmZHxO7xXDFBgJEoO1tnvB1Z+qlxb8LlPRREcMoZx3FpC/z7EoqPAGfEtfwwHx
	NTmCNGs4HrgEpzrpoV9v2WQVtl5gajiyjSrq4CsL0Ea6wlj4bWJq2sZhTH/8DNO1
	AnzcN6EWrTXneGSD7EQdgZdsAOGVokUpMW8qnLIr4SE85lt1cSgN2y66iXoc88gk
	5C6oJRz94khcu6IByH6OjuwNocXDr9StE6hE5yrUXEMrwgbQVAkGTrXP0aWy9Utg
	qgw6pF5wfcOxyKNMzFzpWlIwFj/5F/gVtaKf4e37LE1J/e9zEiMNF260drOicCz7
	r5AoFxuAgne6egg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RkSAX
	SzwkkizbDjzvuzm11ZJQCaeWJPpCXL+FVmOieU=; b=Zja4Ao1iOj4BIkIGXxn/+
	+RnWSpbyvvIaTIs7D3HBQGnZngKe9NuVWtN4roshvjsYQ7EoK4/ZiiAcopcZzJN/
	sq5vJxOulnSJeikIQ+nGxG1Ca7avfSNKEv7I6FxH3pLPt+32vSfTKZ1Ee9b5oiZ5
	bpkt1bBA7KJdKId0vIhIJpr5UW+t5uAJD3PZp622MYCUQO5rdA40oyOdwBXQjULw
	/4vnIbpMP+BmqU22h1CDHMEmT1bMU9WvLgK/7d6BYsxWgpccMVPFSy26bCPaDu1B
	2HwI6nuU0Y4Ph/ef7xDTnS9Fhp8ZX3hQUWlhDSq8I8Skp622Oh3V6syNZ5kdQvRS
	Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ha1pxu8qc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG/ImNd9eOOG19Ct8wZfvwk+ZeSn8itcBmqCz389ZQToZYO4DshVOLWx76P8JoKxMJlxPt7nAq6fzxZypRkI239I/fj9HGy8uYoMlegLhPe30ClVaUKzxrVX10L1cKoAKbXFONTMiS2Uk9B21i22I4uupU9l3JEaWiun5pkIXOtwNkxXl0VPmT321mCiZzbA9LxK8ioKBbZKt+fvWTcgmknsbWA9SOtqTgiGu8KfErdur6F2LpIEEkW4iy9XPbGXlYpXfRsbYHgQp58fTBX865bNeubHqzNSlDt2dGXBFrGFX7YcYt9/eQ6Z/KwcXMsefrb2VaaGKU9tb5ILO5E+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkSAXSzwkkizbDjzvuzm11ZJQCaeWJPpCXL+FVmOieU=;
 b=OmR242MLZQOejcXwBBZ+iXng160F7KKYlrUlc+rnO6fTkWijJ7DxQw8rxHZVPpygY52LqPxtYm/ZiEu9I0E8DM0iXngL6eLgcwYUWqmF609JIuEZMFh555FDDEZi8baYWBbVMyWRGsVcOABll5OpH1SHxmj8F6BvVumhPqkXxVQimWw5ijikDb9jTts6cEriszNQUJzOM0LSU4Kxf0ZTQSx3QNQgkPYSuynTYlIWBaPkDD3Y6MI8LXg4nLoZGj+qNHJvGTWOX/hjFrHYE4htb/JcpWYrqRPmKPvIdCJTdho9BpeYmlJR0V4+ETyMYXxOXorZFmmTWq0/VG29wLtnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:18:30 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:18:30 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:19 +0100
Subject: [PATCH v6 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-9-5b3ffdef8191@analog.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=4693;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ERCY1kTyAN/8u+Srq1WoTOZKg80x2x8brLfTCDxviHI=;
 b=u97sc2Bdu6jMF4NVXCSIUUqxGDE5fc31tgKBmV/raAvMYnZy9K/C0OATCir3d1jQs0agU08nN
 SNDyAUQDCtBCpyV4j1GpoIi3YOL4J8E7qh2gsYd/7PnXW5c9KHX7hoL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0050.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::22) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: f03b36b3-20ce-45d6-67da-08df29fe05b4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 +azEgo/RMpf/y+IBlNcHCIhtxs7/ZZHy/1bC8Mqb8JrNC7ckNnw+L6JsEB/Xr0H5/X3ka93LCMDdu98uE5bgzcJh6iKHYDho6Z+EGuFVZMW8eQgACCFDDvWsyHTO9TSPToOwYCp3hIhHJfYTDczeEneJfj2ZB0Lh2DcjkZqX6LgIBLSInw3mG3RznZR4VBPXLpm5Hdt+u2ofnKsYKPLFW7t0LbBFI/4tiTTGaYEhq6RSQhioBrOYc+3Gq0DFAEaS5ZhG4lGW+mnWaKdJXL3/0eP0akuXYOqKnhGWBm3+826jvaN15aMTsUB/SIuIatsuAUEJhgBNaU0aPzjkFb87oxAbA/yGh6cYW8I8i4web69xTfSUhYNyLpLXQAa1OaeeVmU96dQe2wgaTCYaKLOUIfKpYly3tiRsei52LWATFGcZGSaGJ23s1hsbhftxxwcAmc0rUNzcaiMkh4kOJGHDxnfmxNP1mxs81zCLOQqehK7XUeyoDUZzPycK+nxvCkjjvZaH9Y5ksHG5V7BBQlTZX3efrId+UmoSDjjMsqa26z1d9oiZyWZMs9Ndn3Ch/PF6WmDQDCWnyVcMctwmpFb4puKh3Ywoc1DP2HNQzYz61NUkwdL7iYY/P2WCG9QimJfn28v5TxbVfbghf8R8gf1hvGje0GptQPYSdVbKbOqmbSs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Qk9tdjFBSS9iK0lYN0lzNE5Cb3hXSFM3d09sa0NHUmsyeVd1NGVSc1JUbHVG?=
 =?utf-8?B?NG0xQzQxRlRXUDBoTEYvMzUzYldXYzVkR3BhMVBsSTgwVGZ5YkQzY2NzK2pV?=
 =?utf-8?B?UDczNmJXdk9iTkFheDU5cVNOem96Tkk2VzFMWDRqMmVGejlQUWIvSGNVN0tH?=
 =?utf-8?B?V0I2MXhxSXRvWTJGRi9KL2FGbmxqS1F1S1lid1VRSm9yZUxmT2t6UkJHZEtK?=
 =?utf-8?B?MHk2THpRaGVVTmdvQkhGOFlqUlRHdS9ib0NaQmRwNWhiQmIvN0dkRlh4R3VJ?=
 =?utf-8?B?SzZIMThqdE5hKzdNV21iWVhQRjNZY0lKZlBWMkx3UTRoYkw5YWVkckRyakEx?=
 =?utf-8?B?NVBVQzhseEpqdFJOaUw2ZlZ0NmVteDZNT016dHN5ODY0d2RDbGlLckx6aC9s?=
 =?utf-8?B?eEttdytXWm5YUjlYd1dyNk9TQ0JLOGYycWJlSFNab0hmbHF6NUR5YzVlUEpm?=
 =?utf-8?B?VGpjRE1wWmZhMU5rakxscnljTmRHWTEybW1QUFdaYnJ2Q3RpZEswSExjRzhV?=
 =?utf-8?B?VTdmTkxZSSttZ2dTcjR2WEZwZ3lzMUxyY1U3TW91QmFtOWlIR05XMWZGdjZP?=
 =?utf-8?B?NW1raXZoRmdCK1JmUWRYOXgzdnJHakNMWTE0dEFMY2tpUTg3em8yVWNNcW9R?=
 =?utf-8?B?cENCZ3lXbG5pTC9jSzJ4Y3lvRllNVng1YmpsRVVzVlVGNlcvQmxtQ0VrUkdj?=
 =?utf-8?B?TE56d1pIQ1dSYlZ4cy9oN0xROFY3Tng3N1h5bWtURlQ2L1hKVkY1TmcxVHpO?=
 =?utf-8?B?MTVqUFJmaHY0QUpVUjU4QnAwUDlIbWpZNG4xVUIrd29xNHYvZkh2OWFSZHZr?=
 =?utf-8?B?K0tnblhzUXVPUitQUXFtRDl2K2J2NnFXUkxLdG5tNWFrMTc1WjNobEV3M1V3?=
 =?utf-8?B?RmlSRlZNREtRV0hFT1N5cEdva0JTTXZNTExkNkp5bmFwZTFNSXVKQThib0tN?=
 =?utf-8?B?MVFnOXFGWDhrNU5wUFU0ck5jcVpJYmU3SDkwbjVzbFljeWxuVllMcWFFQTh6?=
 =?utf-8?B?dnF0SzlXd3lTNW9sVXp3dkhhT2lvWklrNHVxN3pMQTEvb2hSczJPSWYyZnc5?=
 =?utf-8?B?M2NmOXBkcVJRWXlWb3lVNkIzRDJBNktDY1dTTy96ZHV6eEN0N2lyeHU1UzNJ?=
 =?utf-8?B?Z2QvbGZ2eXFnTUFJY0xvUHA2NllMYlRURHExenYwQW03ZjlEN28wOVBZUUlK?=
 =?utf-8?B?NlI1WEhwUW9WWm1TYSt4SitBWmZ5STdZdXB4eXQvaUNTa28wc1AvekovaFJH?=
 =?utf-8?B?MGlSZGZmT25TMHJyRG9KVTFqVi9uYXJ4bGN0NjNrTkJCVzduQXhYdnMvNEs1?=
 =?utf-8?B?dXdZVnd1Yi9DbWVjZUhscW1tQlBablVsV3NPQXI2dElSdDdGZ3VUVDg0dDE5?=
 =?utf-8?B?Zlp3ZmtxMk1CY1czSk5saFNpRmNOMENTMlAxZDZFYnhTVW12RHVGcXY5eW9J?=
 =?utf-8?B?V3MrZlRGN1ZDNHp2NmUweVNGYUprcElNdTV0bmh3MmJuMllJWEV5ZE82Q3Fm?=
 =?utf-8?B?UnFCb2dnM3ROMnovcnhKcWlIampkYmNXbWhtUVhjcUtIV3ZxMGxPMXdGMGRr?=
 =?utf-8?B?ZmdLNWljeVJmcHplR0tZcmFDYjg1OXNsdEdabm1JNnIzdUJrWlE2RWRNVUQ2?=
 =?utf-8?B?ZGprajJ6RS9tK2ZKMDNVZWdjSTZ1RWlpMzZhUkhEQjF4cE85VTdRM01OdWsy?=
 =?utf-8?B?QmZ2eTJ4Skp4d2pWK2tmY09ON1JRL3ZGUVhJcXZPMHAyRkdFVjgvWmdoQ1ox?=
 =?utf-8?B?SkN6MmlrUTNVWk5senBrV0dzVkF4OXR5T3EycHRJYUhhUFZ0RGFzVEhFRmFv?=
 =?utf-8?B?SldKZDhXK1ZTRU91OE53RVdDNU9WTWdPMkh6Q3E1Vk9nMU1pZWpuSENvY3V3?=
 =?utf-8?B?MURUbjFocDNnZTYyc3NkQUtjL3I1TmJwU0ZzcVFaaytXU1BqN3hXRndQZndN?=
 =?utf-8?B?ZXlwMEs3di9DcEp1bG0xVFI0dFl5Z0swc1NYWlJwQlFjSndiOTFmcEt5bVdz?=
 =?utf-8?B?NGhrYXhHMG5BZzlHNHVjcklxMmxnUWpUcDJncmFueXoxRWtlakpYajcvRWRv?=
 =?utf-8?B?V3ppMWZ5dmdtb0R5c05ySW9uamt2dVpZRWpUWkpJRDRXcFowUDFreStENzRL?=
 =?utf-8?B?VHFXQUxaUVVlQ0tUU0ttVUlVZ3BlODVaY0dyWlZjSHNhdWdpcTBjR0NYSVBu?=
 =?utf-8?B?SnRwa1BLTStYRmFGQlRhcGV5c09ZUDFBc2R3SkJLcVA4cEIwVU9hMkRDbzJD?=
 =?utf-8?B?NXdrT1VUSXo0c1EzN3NTWXRWMlN0QkpoZTEzQVJXMlp6VXkwM2wvVitWdFVs?=
 =?utf-8?B?YVBGZk5IZlF3dm82T0F1SU5HZGxqbDhlTTZoZXYzcnJkUk9CTytzZz09?=
X-Exchange-RoutingPolicyChecked:
	z7L+DasX+Ln7p/yAZTXyWV/VsT+Q4YHUKU2ZWmwwQDFZXJN1MJxhEQIusNHNGRu4o3E9BvEZaCh5iYOaEMULOpultGFhGkiF5bmWtClYMEXVhSTvjHqxcgff7E6zVMSuLQF4hMQZBvIh5iKiVmnV+zppB8588RHCaCSNJh5BDb9cqHZEnvT5docu4AbasiKc2fieH8Y3WyHLWCJVwc0Bu29dbGHcaJi1/kodOCiuHeILBVl6TPV8szxkHksBkqJoUOc7j8ykoHdu/MZDMdl7cHaOMggWiooWTKEbyl58Z+be9mOWFeOtaW44d/0KM/j1i0asBQRbu+A+yvw+jVfCng==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03b36b3-20ce-45d6-67da-08df29fe05b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:18:30.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf5Xox41b10u6sZMbbBqTcJvx7RptNMM5AquTT9vddnnWpUSBjJ938eZNTduQqDLyLKBOxY1GDnzwCFVb7WKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Authority-Analysis: v=2.4 cv=PfdqFShd c=1 sm=1 tr=0 ts=6acf8f39 cx=c_pps
 a=gE6CMw9pMCRGQsgsFAL45Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=CIoI50WrR_K_g9tIiWcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: Qlyax1v4b344A-xK7voLpQdVHmlHBFWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX/VDVMNTbzLdi
 zAmSd4VBBXrBiS8242/XeKJ7BexostzMxSmXIYgeoxFbB6iI0UpIN7cn9cquGS7clFnFeN51/lT
 yfs9JVO+PJEa6njGym6uiL3w1m81VfEPF24ATaNnynROdMFtYIDfjU1EaNVU2JjdENO7TzMed06
 17L7pkSffKqx/DeCwe+cycju8UTwrknqUC7DlMq80YIa2g6rTyV1f6Z4YVrg0q9YQTWO++wQ6z8
 DllBLM8OYkpyBPt5lQwzjoubNy2VD77/grunykPkyy4/tRptiFe4M91Z29oLzaRWueCssy9qi/c
 2w/1dxPnpZVl0u6q93o4VVMPw8aU3b9Grplw6QwK4hRBemb6ZBLi4k0kX/A1N3a69RVAAn/CpH8
 uPEjPX7F2EBEFF2fbHwkISZfkeQuQ0P2GaF2aaDfqvYlEKV8jc1DtOrq14DJNyAEORuQF5idvEb
 qaAY8beKqyCzN/VRYOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX2083PCJ6YcHY
 6ZOsJHEtW3IGPLq14I2Bs5ODwrYEs7KZmYdOw3ETDLacUkF6Dvnni8tS08YPINouiMrwP5/lhA8
 iHi/nt8+h6n4B2JB7SJdHZo0k3rBKjCxFOysw8ocfOO60j0TWyvr
X-Proofpoint-ORIG-GUID: Qlyax1v4b344A-xK7voLpQdVHmlHBFWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

All users of dma_get_slave_caps() that inspect bus width capabilities now
use the bitmap helpers.

Hence, remove the legacy u32 src_addr_widths and dst_addr_widths fields
from struct dma_slave_caps and stop copying the dma_device masks into
them.

Note the legacy u32 src_addr_widths and dst_addr_widths fields in struct
dma_device are kept for now as every DMA controller driver setting them
still has to be converted to the new helpers. dma_get_slave_caps() keeps
folding those masks into the bitmaps it returns so unconverted producers
continue to work during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   | 31 +------------------------------
 include/linux/dmaengine.h | 13 ++-----------
 2 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index b47008595332..0614f9ffbbe2 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -595,8 +595,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 
 	dmaengine_bus_width_copy(&caps->src_bus_widths, &device->src_bus_widths);
 	dmaengine_bus_width_copy(&caps->dst_bus_widths, &device->dst_bus_widths);
-	caps->src_addr_widths = device->src_addr_widths;
-	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
@@ -614,31 +612,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
 	 */
-	if (device->device_caps) {
+	if (device->device_caps)
 		device->device_caps(chan, caps);
 
-		/*
-		 * A driver already converted to the bus width interface
-		 * adjusts the masks, so derive the legacy capabilities from
-		 * them for the consumers not converted yet. Drivers not
-		 * converted adjust the legacy capabilities directly, in which
-		 * case there is nothing to do.
-		 *
-		 * Goes away with the legacy dma_slave_caps fields.
-		 */
-		if (!bitmap_equal(caps->src_bus_widths.bits,
-				  device->src_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
-							    0, 32);
-
-		if (!bitmap_equal(caps->dst_bus_widths.bits,
-				  device->dst_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
-							    0, 32);
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
@@ -1209,14 +1185,9 @@ static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
 {
 	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
-	/* consumers not converted yet still read the legacy caps */
-	else if (!device->src_addr_widths)
-		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
 
 	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
-	else if (!device->dst_addr_widths)
-		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
 }
 
 /**
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b190bfb42df3..225e9edb7949 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -684,10 +684,7 @@ enum dma_residue_granularity {
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
  * @src_bus_widths: mask of source bus widths the channel supports.
- * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
  * @dst_bus_widths: mask of destination bus widths the channel supports.
- * @dst_addr_widths: legacy bit mask of destination bus widths the channel
- *	supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -706,14 +703,8 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	struct {
-		dma_buswidth_mask_t src_bus_widths;
-		u32 src_addr_widths;
-	};
-	struct {
-		dma_buswidth_mask_t dst_bus_widths;
-		u32 dst_addr_widths;
-	};
+	dma_buswidth_mask_t src_bus_widths;
+	dma_buswidth_mask_t dst_bus_widths;
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;

-- 
2.56.0

