Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046E3E0C66;
	Mon, 31 Aug 2026 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176780; cv=fail; b=GsQiiE7JY8hTEF93zj9TcheiiB2i5jbUUTdr9G3Cuzb6cHgfkexgol/bTr5slMX0xK6ymwxyfTyYVb+iGrpd8ur0zLBr4rPTXDq1ZnHacu008jB+M2yG0JZdRdjOzmC7krNvmnGwgJrnRMN0pAw6G4EfeTNM80qt42slHT48TrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176780; c=relaxed/simple;
	bh=QV8NPkSt0MaDa6bdo2hwTwFsaHgT77kUEHyw2byobpk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=efhRZ8QasV97nQ6rcKYBbRhoAiOm8P6aD894lSpuTVKNI6xcDI8XEpmytwreasCjHBIMwPLbeREHezcqOud3RbqccXfT0HJzc8LL9PlZd4+U+/RlYCXivwqh+NLiYwVucxw6lu6csqjJ89Z2zFRrYn2Yi/1ymi/9VTKSM4u/nes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p2GukVHH; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p2GukVHH"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VB9nXl793172;
	Mon, 31 Aug 2026 07:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6KM0J
	xmWa38tVa7en1BEc+QdxeysuSy9Yw8mT5ndHdo=; b=p2GukVHHVRzC0xt27ET9/
	nQePeZTBlZq+iL87yU2XVJNfnV0eKlqKVzbtNkj9riXpjawTnkUtxbgfSFcjUhEv
	yxYEgu5+nqH99L8hz+sQTrSSA8eewtD7/UWVwKglvSLcNKPgULmcBRDzPLDDaQOR
	J3/xQmGndAGR7LsDnO6Kc3ra5C5eOuVjhGomgwyrEWaywU7etcXmg9EU1qBa60fI
	PpJexKCk7YywSZSItyvqjY0wkHAFrNLp+AOWAjcgq2eG5/VIkCq1N36ZNbkXFacn
	EvfbbgC7yWgOYbRBatxws2+XFUUtrR68LRhvmW77XLiBdvRMb/GYAcO2PA0WNhmQ
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcg1hu8q4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXMRRo2TKLzzIg/F6p8jL8kE8CP01eH2F3RbXv6zZJ9sNssi9Ec5DChoABsjI3MvwoSo3R+C7GCZPY7shV4raeRyg/hyEUoXF5Ufos9L13vx/HoF3tF5ylnXR956syxoQt+pa5xQCDFhuchMnivGcL3TcSaMg5G/jvHscMY7obRvlh3KHd8MopM6mC5i/Qc46OhvN1V1vVArdjlqmS3xdJ0ok0hB3pJPua9ZSidsGBXpxTOB+VC0OcVmmNzvJ73z3X27EoVPYzGeDmKGeNcalJvJ7gQkGgSxxnegYQapsFP+ANQUPgjarswF27Ka4dDXgRkfV7t/yXubUpNkctYYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KM0JxmWa38tVa7en1BEc+QdxeysuSy9Yw8mT5ndHdo=;
 b=oSU5AsYzBS2jWH21d+3t8M/DoBWKsVJBQJTMdoYeA+BYnRlc6Syl2bSj+IZmsE5kkDGsZY85rHljN2Rpo/CS03uLBTCjp07JFpVrrJpOyYaPGtAquUl5/R1SqHUUhE0lMjXiR9rfwlbhnE/kZJ6I78lXuNaW4pizut4UPNyYSFc++rpGxyDajtV7FzbdH26TPlYJv6swTyAgFZtjBh8JfBIWRX1wA25WddFVVvmTqj+RrA8NltU5R6m3Mzpr520w6IAMMElbY78222f786AAxDPaHhn9ktLedDPyqnnmFWiva9FzOV0yWq8FEoh8Mr7nJ/euHsrFSmpW4By8G3fkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:40 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:40 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:41 +0100
Subject: [PATCH v3 4/9] dmaengine: qcom: gpi: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-4-507d97496f2d@analog.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=1693;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=QV8NPkSt0MaDa6bdo2hwTwFsaHgT77kUEHyw2byobpk=;
 b=+Scs8BRjxgYPRb681gBlmF4eIG1X8/0vXZK9FIDzKxmX4lI6bDRAO5c+n0+cIn9Snji3yvNKI
 yXyaTy8ow89Cmtd/a9rJ4YBNxFaZLzgsvC2ECNxLWsBmxjvGwC1yZXq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA4P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: bc08db37-32c1-40e3-602b-08df075561de
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 cxjL9HMsfu6rMk2h2Iazjk+H/BxaFiJ9nUL4koIpZpRcbVwBbU7g0mrIdvGmHlxESluGjQoX8LWVCbUjlQxwu8NH7L5vRXgmp1laEXSwGZXYPCsxI+pEBecpvTp8PJ4pthU/tptf5BWD+mPkeRdNlT8XcDh78D1d6aSIj7Kp5YsxX1dsZbiXAv65K10mul+JR1RfgPiCJHFze2L7rH2qn8Q0rjDG4KIA+5oQ98jOReVTID7mdNR5GYMHJloIT48B8qPwZphiAH3XMdcBkD65bDIVbAIdOyohlkLHlAF6mcMwGN4d0qL89tSZbbFPlAGycnzx+eXHxjXDGXxVuMxuGTIzY9sIeBU+D5EpWEI6tKgdB1my0gWzZly5/yy9c72M8AGazZ2WO+h0ppEKAD+OF5AynrqFJyJ4SYhBpukXvGtITXR51PW1i5Pd/WyOq2LnNGEru7cMgU7aN07Tgi4RL6J2eVPKZZ2ZEVhLf3MMwZAvwTPOcPxlJyW3MjVXsyoz+p2OhhF2MfFOrJR8iaeuY6NLxkpBJt+YYmG7QM5dCsGAaCTaAyGnmv7++UmKVygc4xqbADNVsAsEHT03GABTperxPtzoZe6EQwgeMytlU/qV4waO7X1w15hLHwDcGZozGj/wDKCMTzUWsgm2ILo4mBBhXe7pVpD6dWcRDkZZoSA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z3REL3lHTXJtSVBnWXZVbnUyVVZIQmpZQ0RSK2VnZ2xNVDlHdGsycWVGZkRj?=
 =?utf-8?B?cXU3QmR6UFM1Z1dUdEtZODVQeDRzTlpBbEgvU0tJY1pXZWFkT0hTQnVqWjl4?=
 =?utf-8?B?QmxMSTJyTkcxcnFMR0JqVW9FUTFSaVZmbm9jczZvdWxnd2MrU2FzM2I3QUR2?=
 =?utf-8?B?ZlhVcDBVbGZRekdCR1ZtMXYvUVZ1a3VScEw3ZDd4TzlyZEhiVEM2VTZVcjZ6?=
 =?utf-8?B?YlNkSmtCU1lyaUZRTmJYTmhvVkpSdTczZFFvaEp6ZXNSM1pLdlkzVWRacTFD?=
 =?utf-8?B?SGNsZmlzQkNhQUlHSkRJcFdjSk9NcnhLZTcrQXo4VkcweVZjSXpjSEROR1hs?=
 =?utf-8?B?ZEVuWlI0bjVQTTdqcUJ5NmRUS2N2TlZoVytSaG5FejQ4SzNmVzVXa3NmZWhh?=
 =?utf-8?B?R3FmMElpMGRPL082K2p6d0pZVlZ4R2tDdEppTkRQdkJIZFJQTTBkK3FUM1J2?=
 =?utf-8?B?Q2FvdG9EODZtZlBQVFRLcmlRMGVod2JjU3YvUzdaK2V1bUd4SGVaL3hta2NC?=
 =?utf-8?B?Q09mV28wWldmUE85NTNTL1BhcEJhUm1qTjMvNzhLV1psTVVyR1daZ3I0THVy?=
 =?utf-8?B?a3o5dWZHZ2tsK2dKZWFlcFRqSXorcXJxYU1WMUs2dFZsK2FzWWlPdVRjeWt0?=
 =?utf-8?B?ZnhyWDJTY05JdzFnZ0R1SjQ5QkZRL1RjZmhocElzbkJjY1VVbVdiUU41R2ZN?=
 =?utf-8?B?ZURjK2cxNXZGSjRGb1lhYWRrTXlUV2J0dFZSbEFrUjVPMHg4WnFmdTVlb1FS?=
 =?utf-8?B?TVdibWRaWDlaVkVWL2lQamZ1U2xWaXAvelI2cThtSFo4dW8ycUFhZXI2VUVF?=
 =?utf-8?B?ZVhCZ2k0OFI0NTQ4eTQwbWZvYmpwa3lnbzRDa1ZLaDlqTXVHaTZ3RG50VzRa?=
 =?utf-8?B?VFlSekxsYzRiOW5IL21IVmtoT1VFM1BrOXZSQy9pbHcxWFpSd2tMRFNPMDR5?=
 =?utf-8?B?L1hpV1ZEL0tLOVRTSDdxSC9WNG40cWQ2N0wyM3hCTjFjQ1R0VTBDUDcyQVJh?=
 =?utf-8?B?ZnFLaUdmSVNZTW5QYVhFS29ZTDkrYTZ2UUNEalF1S3dnNDNKYVFVMUZ3MXo3?=
 =?utf-8?B?SG9OWWlrcmtHVkJPV0c3dEkxdXdINEEzYlB1V1BmUHA2S1BuOGtVOGVmZGNl?=
 =?utf-8?B?WVg3Rmt5bVUzajV1QUJMdjZYdS91NlR4bkZBTmlSdUF5VXNlVkR3d3RFZXY2?=
 =?utf-8?B?UHhuMlZnMkFaRVN3ZnFoVjJoWUN0aCtoRWk1Y2o4aEZNYWxUaTVSZTN4SW91?=
 =?utf-8?B?Q2o4czBFUHhGdWhiUlc0bitRUGVMNjdCSXQwT0lIeWwwMk9DbTBUQm5sTjJz?=
 =?utf-8?B?amtpellrQllzWG5oRVZyeVpFWVRzd2wxbVI4UGR5eGk0VEJsbHl3SkN3SkNH?=
 =?utf-8?B?OGVHWjVMZW1wTExCUDkyV25odGtjaEZvK3RTYklUTUNhdjBJeDhDcGo3aVBP?=
 =?utf-8?B?bU55cGJCWjJMakRqRXM0VWpxcHBFOXVKb3NTa2JXL1ZHY3oyZHNRb1I4UUNi?=
 =?utf-8?B?SzVkNm96cDQxTGUzZC9XZElsYUdQOE5NVjV5dEJJVnBDQzBGWkNZWklkT3Nn?=
 =?utf-8?B?S0dOR3NzcmNsUmRRZXlZaU1RZVpTWHR5Y0tUNmIxMmlaenF4VVdVbTdtZG1I?=
 =?utf-8?B?eHNuUUd6dlBEUUQzazB4YVZoaHJBUFREL1krMzhWR21ZTTVBNDVmOHgzN3BE?=
 =?utf-8?B?ZXM4eEFjMVVCSCtjcUxNUG53d085U0I1RVNHUDdvekF3S2YwcTJGaG1hTUJn?=
 =?utf-8?B?dG5xQWIvWWRQTVlhY1BGY1V3YWUxblpreVZ5V0dWZW9jY1RWWitIWDQwdUtS?=
 =?utf-8?B?NFlzbjZOeU5nZFQ5M1BsZXZ3TGlCRHNldzRUczJ4UjJEZnJId01OSXNscDQ5?=
 =?utf-8?B?RzBoZGdJTmZReHoxeXpidXUvOVpsdzMxdCtoeERnNTVEZnBnYW5PTmIzOVlE?=
 =?utf-8?B?eWt2QzBJQ1RScWJqcEIxSzJuMVBoancvM0hJYzZmb2Q1RFhiZjRnV1ZXWCty?=
 =?utf-8?B?S1N6bER2dVdTbUNGSy9jckxrMWJzQXFvZFlYL3AxK051SUJLV1VrS0JDRTZH?=
 =?utf-8?B?MzBrN2R2cDRGVkZQUEY1djZmSDNINGV3RG1FN2JLYU9LQm1SQzZpSUxhMVkr?=
 =?utf-8?B?c1N3SkE1V3FMQlZub2lJcjFIbzFnSGQ2djFENzg2SHRVampQRTZpZ3ZoYTc2?=
 =?utf-8?B?cDYxejdXM1dOTnA5emRpeEwwMFJkcU9qcE15M3MyMXV1Ulh0Sm02VGduTHJJ?=
 =?utf-8?B?ZjduajQvT1VHeUtueTE4ODBxRXlvVm9sMXpKSkRlNGJpc1RMRG1LVi9tMTB2?=
 =?utf-8?B?ZWlHODYxN3lHL2ZBSGI4Um5nc1hQdHFQV2xvSWwwbkY3SkZFdCtoUT09?=
X-Exchange-RoutingPolicyChecked:
	lzqZ0vk4lHOg+nL3xpFhZkSoUEGGG5/bC+wshtLPg/wEy8+Zi67FZ+fT9dt/0Pm/GS111qV5eTQ+CvziovFaDx3N27HbKBrTkC8qYyRi5ExjhngYc+pWJ8cHpJh+5stsPN/kJktTb+DaRgK7wKGRyj+6t3NR+dTBcXgdVdGhvNrgSKfUmTq7ci/RuXyN41b1/SLUM3fO9bDATqDVXvXVbM5NBNNBR9qvMKNXH6dGyKX1sDwCE8JpLWXNaBGbWO1ol3ZVbeFAJwvO25EV5LIWOIpCvJ8OgsDDT3L3pp/mbmCXdlvOgLZnFFN/SQiH/ZmMNTlg3BMuduIm4ffbXLaieQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc08db37-32c1-40e3-602b-08df075561de
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:40.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eINACEL27PnZg/EUE5AqUt5FVBfQNZIoUugTLyExJiuapPpz+BUs6BSds5jD1uNFC4DvhtqfoPO1AjfJqExoHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfXwWaOI3WBy3kA
 ULi5L/23c6zDzmgc4PbDC6j3ikA0MpPtgjpDY3Cnf8ZUc6fQmwKtMX8BN1f9BfKA5wXZhLeiWu9
 cQkg6XGZM6vNnmwow0SU+HoeLjX0HP+a2RgZLEAJcxijKF2fP0wvCrfJDhB/9R+M9lQ342Ww7zH
 EP0aYcd3NbE5xmlnjOnU92/bcaxvjv/gjaiefgk+NSUNaabra7L3bG7uyiB3xAhJuQtE7bRnipq
 Zy/w4bw9TnHVN+TJIcjb9L1pnQbskBL460k40PQEqglAFRmHjVrFzxtFpSba0H0J1xCH+/Aev8L
 h9mfuHIrkCD9dzz8IZChLYEn+dGQjwSTIysjSEulYq1zmIMaizIfAiZ/BSOvReu3ESxVullYusS
 NTIBc+YkWr3REEq0touxEFO/FGRA7KPaVsnLEw7ioDI08RcKtYbj/Q6irGVBitzXAJAJd4XA14/
 L587K3hlketIoIwygMA==
X-Proofpoint-ORIG-GUID: aL8FTYWitqFhYtNcCKfiRk0Bt3hXBOpy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX2bJmFpLltMSQ
 AQUb5u4A1DqwDhjUPce9UlRYjvsY38MXeWu51flFhlRgwy3UxSrCmQUX0EjSiLmCo5saj9HOosC
 /ORU6sYIczd+Qtf+9Nvwv8fJVf8pAs9ZppVWsGlLBARHZDf9ksDN
X-Proofpoint-GUID: aL8FTYWitqFhYtNcCKfiRk0Bt3hXBOpy
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a956967 cx=c_pps
 a=EaWthEyNNaJ7GkMLLYePaw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=11eJKpf74FRv4loUduQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

Advertise the single supported source and destination bus width through
the new dma_set_src_bus_width() and dma_set_dst_bus_width() helpers
instead of assigning the legacy u32 fields directly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/qcom/gpi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..3a35bf4c3397 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -7,6 +7,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of_dma.h>
@@ -2265,8 +2266,15 @@ static int gpi_probe(struct platform_device *pdev)
 	/* configure dmaengine apis */
 	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
-	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	ret = dma_bus_width_set(gpi_dev->dma_device.src_bus_widths,
+				DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set(gpi_dev->dma_device.dst_bus_widths,
+				DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
 	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
 	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
 	gpi_dev->dma_device.device_tx_status = dma_cookie_status;

-- 
2.55.0

