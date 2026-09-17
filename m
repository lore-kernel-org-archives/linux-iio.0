Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6C4E0209;
	Thu, 17 Sep 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658786; cv=fail; b=aQCmIGR4rLGRLUkYUCFpRVcH7JoX11CiDTT0UKrQtljZsX1LMsXUnhn1oQhD8LHPNPvZC69toM4ymKxr131RlIYBH8HcvMTrKm14rLeRYJ7wos/CNoaJIbfvdSwNLHSHV1bAND18EHFp/soCCIccypecGQDffwcP4djottDpGfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658786; c=relaxed/simple;
	bh=A7qSsk6S1fkWB8hya+jvhk77pXLiBaK2BUiJibhseIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WiYn/k4pO1/1HsZ6dF2sNaH58K7ZYDXcJdn2b/g8G7JXOqhgmlU8TXj4KnUJeUH0ApPpnYvEvtlDKpfsulBOg0lENwh6QQ1caAlV1E+qfq/jMsICyo4dth6AcZ1E9wzyn9TtkNN35ZGqjuhyue2GnzJTGObbYHnO/hTdoQ3HpVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Da1ii55j; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Da1ii55j"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDbrHd333305;
	Thu, 17 Sep 2026 11:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sRw03
	xrmTUektnQP7nBMwMC6IcziyarGu1NuQgAhWCc=; b=Da1ii55jtOubFA+R4wrs8
	pnUUoysLrgKPO4rpomsbQibKP1yxwQC3kEogjm0tJ6ew5y/TDkio8265wLSzznHe
	kFXPQocD33a03N0Fn0Ye4BA89/FX/5ITQccQaO6hObfQS2AvVPgyUV+rcRO1IpqK
	DjgBI9A1woL/tj5iT+jiZ0KpLALrb9VHdVlx+By2SNqOHd1tIJjLXV3idL1RLf8q
	Rde/c3ESzAekBCXtZgGCrARZnmCqB7bwcLghIJJ+6c42bGR9ehVxrIFZsQF5KmvD
	Pm23PQf4vS315E13uRQ+LTLCjMIAUPS91DNCIxs3O8q8kFyctoQT+pW3I5CAQG0i
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gr7paaj97-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 11:25:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx6z7y56msK6OZ4EgcCzsWtAAi4Qi7kongn4OmNxyDfuG1PgV3D27lqA2nWH12jSpPlNYm0DqKW7jDLYR8pQA2QIHCJXKKlJqWfH+3G1DviugIpPgShLspRWWnwjbGjQGVFGqOFtNT0ccKk2mvliiFhsHptquJva30qMIhO/kyI+4x3/1bAlAEKixYQATAIPcyRXR/Muu6y83esGEx2idViyUpN0vJ7dlpP7czTYwKkV1nn+snksVX2N/6EAhZ+wFmXAIrecCWt2CmZmndcEr3f10LgBIY85ij86+9gK+Q1pQsqzIKMjoXio7eZLer9YG7gxVJoFrKcgH8TDI8bh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRw03xrmTUektnQP7nBMwMC6IcziyarGu1NuQgAhWCc=;
 b=L5b0thakp2AvOljd0KuRGs5RPzKUv7/eR3glgCmGM7qTczfs7ylcGcbZxMvzOdBI/cVMW0RFqeR8HxZtOk7nCwoe3NG4FSm53M71PqWp+UhtC6AtlBAtggT5rW//fS95L/8LMQskY9aW3vF8cQKRwwtbJoJ9329NDWeaNo7g7rSkro0Zc9ITt0VNOMGAEjVY176Rx54zIiGnz+4uTCPjGj+nHavXbKw3yerjCB2NOXy2yINwi+UtDjHQsbv1CSUoOwx2d8XRUvrsgJypi8w8B+vzHqtVE/Ry/Vwr6O7GGccgkorqy5+Jkz7iJmCzCQz1RxdW21ZQbNCA5HfpXQ538A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSSPR03MB989190.namprd03.prod.outlook.com (2603:10b6:8:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 15:25:17 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 15:25:16 +0000
Date: Thu, 17 Sep 2026 16:26:32 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqwFdMbS6xZQsaA3@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlYOHIFU_dB72I3@SMW015318>
 <aqvFFg5Uh1cXln0y@nsa>
 <aqv7V0E5GObzw9l0@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqv7V0E5GObzw9l0@SMW015318>
X-ClientProxiedBy: MA3P292CA0062.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSSPR03MB989190:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a32dd86-699e-49ef-df87-08df14cfe075
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 Jucif6mZe7+v7J4rpeeUBIkInBiWagFRw9KIg/huNgMhntvx25eFZStJIpJIFeTKvaw+6vmbp4UfG5XAqQTEpihTLxFcu1PHUET8LoDm8iOGhQRJQVDWnPMW7/hO8CXno1M//6budwinVKxEd/dqRX0WPMF2J5O/SRvBtOcmezFtZzRpPcGzBxQMe7HEWbuWUH8LLyN0kX+JmYZebI7dFe7r66iob06eEZ2bS5LEtIXPwP9mKFVlBat0eOm/Qf6nPmtGEf8D4heW12ezGwMUmWN0lbzhyhFqX8kzdQRrG3Fp11t9QNbHb/rz8H0rxRGU85TtcfV/qjHt6E8E6oebmvSs5E9XvVDl8D5UjXhw0sHGYvEFoQ0+BEn9eLMx3TbxREiTBXgHOSCamPTB8sePznWSW5KWHg8BjkIG9iP6EcTpXHpPp+3pjkvvRI1/m0HibQtmZylwmDWnsTec2GfHeEWNQzNo/korVJoLnUmNit3ZV1qGwCyUSuHTRJTNcTSaC0NlEtLABPJwW0X3Zl687oClNxd5TX0CYu80qa8bq+hZOULCc0jOKbWzZBnj/iA/tjOz5zB+oxPGgBjSItRhRAl0XkLTWzW/AqSVAxm9rbfOtDrapQ8U627zlf5jxPGw5ylZpIP09I45bngQiY8r+GAlsbjrNJMkeEd+w292Fyw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RDRMNEtsUVdFQUpYcFVuQ0RKMzkzaGFCWllIaDhzSjdnSy9yMENlUjNCUGxj?=
 =?utf-8?B?bTluTTREMHBQdzRiM05uNEF2OXBreHhMUHczdlh6QnB5UTVxN0ZnL01MaWJu?=
 =?utf-8?B?bWdsV2lRYlFPTUgwOE9WbVFRZG5qVzFzendKbmhBdHNkbmVqMW1BNGNDZUR2?=
 =?utf-8?B?UFg2L2QzUkFGWVl0Q0hPdWw4cjdHN1NvbjBMMTFOd1M0a1ZNQjBseXZWRjFH?=
 =?utf-8?B?dURLc0xJQjV6L3I5YjlJVjdsK2hhVGdSTUphQTlzK21LUVorWWhoUkd3YWNr?=
 =?utf-8?B?RXRDWUVCckpNN1A0YURWendEazlueHdnMitHWDd2OEFDVnZzYlZtcytsZTYw?=
 =?utf-8?B?bDhqUkpKMFZDUUdiNFNiQlZESzZDQ2F1bUF3RllsZGs1UkxrTS9nSHpOakt5?=
 =?utf-8?B?RVpEVTZJQWxSQTBCci9maFhnRXBHTHQvbitPVkRyQWpMTlFpd0JkcUJCQ2dk?=
 =?utf-8?B?cDZ4aHJyRlAvb1lnaWg5ek8wV3pkZVJrV3FUdmtVbE50cnBaRFpwTXcybWxS?=
 =?utf-8?B?RmN1VUdreG15UzUvR3ZlVnBmSWZZaDFiVjZQcll6Y0xWa2hERjZxN1V0QVYz?=
 =?utf-8?B?WlV5Z3BYTjYwWVhXQVdPb1g3cVBqWUxLRTBacVIyQ2xmZGtMM0daWk5WeTVV?=
 =?utf-8?B?Y3VaWmFUMmlnZnZCK1lJNWo5cGI5cGJWYXljRG50Q3U5bVM1L2h3R2d1cWNH?=
 =?utf-8?B?OVVHMlg5STRTUG1FbDZxV3JuNDVVeXBkSnpXUTludVdkWnlDdHh1cmdWSTBS?=
 =?utf-8?B?ZWo0c1hJUDNRNXBYaWlneXBzMDBPWGthSWlwM1QzQWVLcDFzTSsrR1ZmUkYv?=
 =?utf-8?B?SkYwVC9aSGZaaFJRd2N5MElqR1ExTG1jNGxtY2tmbmE4ZCtBRnE1VjVuUWxN?=
 =?utf-8?B?TEdMVmdTcyt5MXVIWHY4MEF2eVY2N3YrZzVwQXBET2R2aWl0ZHUrazVjTkdH?=
 =?utf-8?B?Njh5ZXhlSHhKQXdnOVExUnN2K0ZIZmNhbDE5aGFXSG5iVW1kTk9vM21ETXE3?=
 =?utf-8?B?citkaTl5UUZ6QVJaM0x6c0dtYUg0MGNFVW5ueDkzb3VBK2VuNXZkelZvSnpl?=
 =?utf-8?B?YmJuQmZ5UWdBQm9GRzNmbUp1K0dmMlhxT3V6MktFdDZWOG01S3J5Qm1KbklQ?=
 =?utf-8?B?WG81cmFqZlc4TldPVE9jSk5sK3ZvVUtGRkhnK1pQbDhoUjBTSGdvV0d0czdx?=
 =?utf-8?B?cVdkOGlNMnBRYkZlSW5PWVVCOTk0VjNWcXJZeDFYZDZwTEdNVlMveG4wbVMy?=
 =?utf-8?B?N2NBbmZDaVp0TmFrci9heTMxVzJoa0tPallmOVk0UXVIWkdMcFkyNkROT3Yr?=
 =?utf-8?B?eUd0QUpwQStMVmNNTEtyQmFtY0hUaFh5aU9Na21PN3dTQXBHZWJ3YitIWUV0?=
 =?utf-8?B?NGFmamtQZzRaV295U1BCNmIwVUxJNzRWRG9KdVlyNlFON3lWK0MwaVdqeTFu?=
 =?utf-8?B?OWQ0TlJFai8zNHhUZjdIclZpRWl1MThnRWRqcEZuV1lINDNTRXplK3JKazVr?=
 =?utf-8?B?Skw2M1VFU0Vhanh6VEFuZ0pVUVpLbDJkUVNqSFppU3NJeFdiT01ZQm9xcGNl?=
 =?utf-8?B?elVlQ29Gc0tOWXFlNFJvRUZGNEUrTFQ5Mms4ZXRFbUc0ODd4ZDdtdkE4MVBY?=
 =?utf-8?B?SjJ1TUVFRWRDdktXSjViZlRIblhVeGZpUDBSRGVZOEZaRUdHeGd2L2c1NFRC?=
 =?utf-8?B?UTRGeWRVaUp2Wit5Y3MwVlBQdGx3aCs1NHUzT09TK3psajZ1MzBnUWt5ZUFH?=
 =?utf-8?B?NGJMZlNDQ2w1NFlYT3NLaDZldzhLM0NtZlFGa29yeU5UV1lYZFlkS2FWUjk5?=
 =?utf-8?B?K0dDdDkvZFFkdElKa0VlSCtrSUxpSkVEeG1xWDFkV3MxTUQ3MzNidTJBYzQx?=
 =?utf-8?B?SjFLSGtTUU5tZEFJajVJL1drdnhDdm1PRTh3RzJBWW9FMVZjd2ZCbHZiKzlm?=
 =?utf-8?B?VWMwd0xTREozaGJxM2FNZjQ2eGJrZjMwZVRMdS9hUjlndnpEalhJZzFkNlJy?=
 =?utf-8?B?eFBRRU93MnRRUi8xU1dDR1lVdEI3ZURoS0RSV1R6MEwvRUhwSWV2bTdING5P?=
 =?utf-8?B?WEEwTDZTcFB5bWsrNWYyVFd1Y1JyaDY3ZUxVN3BQWVhPMXh1UWszSmxhMnVV?=
 =?utf-8?B?NHAvOFdmcnY4OFZhMXMzdzIvQWpoeTFDSHBFTG50aFZ0UkxPdTB3ME9LNElk?=
 =?utf-8?B?ekxIaGJWS2NzenR4U2c3Mkdqb2RXbXVWRXVlaTFhRWRGbXplL3VFdys5dnB4?=
 =?utf-8?B?MnkzUzZ1T1JVc0ZUSmUrS0w4S3VLdXBQZ3BKSjcrUWkxcjEzQkJzd2NBbnpM?=
 =?utf-8?B?SWtmV3p0QWJJU0NkRWhtMnNxMmxqaUVNKzJacmdVcXFpZmxOcHFKZz09?=
X-Exchange-RoutingPolicyChecked:
	sW5018KLhtrNe1Cwv+vGwOEvbiaWpGAEbPMSLaJRkuEFlYdO3JLUQTovqdRtv/8UbeGBGldyDhCuAvCCfBXnwTRlwvWHUlB/Gzb4elmG2YW+FTx9U7/vMYNXqFaq5N5qPWZ8snYOrT5QtfPvxuRWKnie949rHHWn6YepIQlAe74OuKMo1sw9PmunuYsAWWLLNALd62RFvpn1K66WSOptYsNTkp/30ex9bzvaST+zabiBH35md8PSNn/lGPiVcCLaXFsxiZaMeplhJuAENlsNsM/HNWH1w4ggXjqxEtuz+4YiTMGalUHqZtkomr4oBIzYm3pA9IHbKQupWrtO3QmOaA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a32dd86-699e-49ef-df87-08df14cfe075
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:25:16.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNFjvpnbTRuqxq4/JLx4H6bNK6a+rQUUYAeN1l7KTdSNrsb8feClRar+Z9otokWW0FnYeFsMeNe3uNszwFKTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR03MB989190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfX7rJCzngEMqUa
 59cXrhYebL7wvjIA1ctn3Q6HZuIPVUG0gi/pNzTjMW5o+W5ibUkvyPcdfPQOmbVAIz0CsamY/kS
 xuzTSYQ2YpXrDvphJclszYtMT8J0UVQQbCVVFyWpA4SpyLSXabk0byz8Henwr4DmcsTfeIAznrQ
 NwZKsDgWA9tAbPfqgFfDZFhwu8x7Kz7I3vrVmVBRn1/bqCs1JB7SQXuh3Yie7r1F7ZV9ftWcJg2
 w+P5MDBiBbk0vJYLH9g/Qk7aK1cGeuj41YrZuAJS0bsEpBzFu7YKXBJ+oXctvltCr8jPQMQ+SVL
 DA1tRrv0gC5F2IS8Hrzh+M2q9s7G5MjgvoOcl6qW064VlJF+Bcx+gyMduxCbEjYfTElYr3rjuAF
 yereMCK6GNoJv79JGo0YKRl1kpxd1Qmdk00AchCrpDiosaLjZLL/8yOt/YX3lnac43rc1YGpM6O
 +7ru+0fv7/hyLhY+JmQ==
X-Authority-Analysis: v=2.4 cv=HOJWhYtv c=1 sm=1 tr=0 ts=6aac065f cx=c_pps
 a=MXKEcm+r4KK8PT7sjGsI9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=n7xCCBwkr_L_Z0TVEDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfXx6gFIxTacnmm
 SfcmKhmJPTu/EsFu8u1Db9D1X/T3IczvRLj6MqQZ9L4o+eIAqu343cCo3Vw/GjWT2ZigFJT+zg0
 t/U1E8Fe7MbREknajHc5/X4znDw+pBXkrGZkGTJGBdZfDwwJ1AHe
X-Proofpoint-GUID: UIDjAjDmS3rC56rVGpu6XFGuslcF3kNB
X-Proofpoint-ORIG-GUID: UIDjAjDmS3rC56rVGpu6XFGuslcF3kNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170218

On Thu, Sep 17, 2026 at 09:38:15AM -0500, Frank Li wrote:
> On Thu, Sep 17, 2026 at 11:49:46AM +0100, Nuno Sá wrote:
> > On Tue, Sep 15, 2026 at 09:37:44AM -0500, Frank Li wrote:
> > > On Tue, Sep 15, 2026 at 10:29:03AM +0300, Andy Shevchenko wrote:
> > > > On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > > > > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > > > > In preparation for the bitmap based bus width capabilities, move
> > > > > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > > > > include/linux/dma/engine/types.h.
> > > > > >
> > > > > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > > > > new interface would make every one of its users pay for it. Keeping the
> > > > > > basic types in a separate header lets the new interface live next to it
> > > > > > without that cost. linux/dmaengine.h includes the new header, so its
> > > > > > users are unaffected.
> > > > > >
> > > > > > While at it, add the missing kernel-doc for the enum members. The block
> > > > > > already opened with /**, so kernel-doc expected every member to be
> > > > > > described and warned about each one of them. Describe the UNDEFINED case
> > > > > > in particular, as its meaning depends on where the value is used.
> > > >
> > > > ...
> > > >
> > > > > >  include/linux/dmaengine.h        | 20 +++-----------------
> > > > >
> > > > > I think it is good to split dmengine consumer and provider header files to
> > > > > hidden dmaengine's detail.
> > > >
> > > > It's indeed desirable change. but isn't it a bit out of scope of the series?
> > > > I suggest to do one step at a time. Would it work for you?
> > >
> > > Yes, but I hope the file name is finial expected file name. it is okay
> > > just move enum dma_slave_buswidth to there now.
> >
> > Hi Frank, if I understood you, you mean to have an engine.h as kind of a
> > consumer and have enum dma_slave_buswidth on it?
> 
> yes,
> 
> >
> > If so, note that enum is used both by consumers and providers so having
> > them in types kind of header makes sense to me. Kind of the same as with
> > the new widthmask header. It's used by both.
> 
> Yes, generally, provider include consumer's header files.
> 
> suppose detail dmaengine implement should be hidden in provider header
> files.
> 
> consumer is just subset by use provide APIs. It takes time to implement it
> but can start work from enum dma_slave_buswidth.

So widthmask.h remains as include/linux/engine/widthmask.h?
> 
> Just choose good filenames now, avoid rename letter.
> 
> ideally, As vnod said include/linux/dmaengine.h is consumer header file.
> drivers/dma/dmaegine.h as providers.
> 
> but some dmaengine driver outside drivers/dma/ directory.
> 
> Maybe we use
> 
> include/linux/dmaengine_consumer.h as start.  wait for vnod to comments.
> 

If the answer to the above is yes, then widthmask having to include
consumer.h for the enum does not make much sense to me.

So I feel like the more appropriate question is whether  enum
dma_slave_buswidth makes sense to be in a consumer.h file or in types.h
kind of file?

- Nuno Sá

> Frank
> 
> >
> > - Nuno Sá
> >
> > >
> > > Frank
> > >
> > > >
> > > > > suggest name
> > > > > 	dma/engine.h
> > > > >
> > > > > so we can start move more API to this files.
> > > > >
> > > > > after all user include this consumer header file,  old
> > > > > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > > > > which only include by dmaengine drivers.
> > > >
> > > > Traditional naming would be
> > > > dma/engine/provider.h
> > > > dma/engine/consumer.h
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > >
> > > >
