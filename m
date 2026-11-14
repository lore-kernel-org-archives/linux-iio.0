Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794695361;
	b=25A0DoxklnmULVBi9gex5IDW05Tszg8uGvYacCIF5M6nqG2WLVUG8Slbf6SRVdTS2DU3
	 aP6fyopWOZD+rTlv2zkcmxbi1Nv9iFkuQfLfr/zLlsNpl8nFo38vZ64vnvbPIOctlPjom
	 pmPKvBC4agf4tYg7LRBynlXkZRhj+yJatXS+VgHpbHq2HnMSOopbVICFJtFcQf3Fp3JvN
	 XwD+4dCsxY3QvG2TFNd/KI3/aV7ZKodeZqwKif9hcm6fWCT6r6SEhayDCsNV1zsCmL3Kp
	 wtF3rRQQqAQR/NHSscSAdQX+1sZoVgYni6R8HEUuSmuoVgQdW0PVdfLcW8Pcdsi+skA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794695361;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZPXB7t2xw9rOmZRkSpx8maUjoR/FUjNHzOnPnJFOfKY=;
	b=QxC6Nv9ckp1jBe/AhIHOm//8BrJ8zHMn6FmXQbt9guGVNIMcBy8rS2Z5xKuKhq0hyw3Z
	 J2avHcU0KszDnLooyxuz1X/amWUrbRaHj73QJPNRQ0MS2LSRpWf84qhMgph1cOfZzg4Va
	 TYsAAY0IBbFtofnb3Yfu9XAMNq17wP6lxpo3KUuDODTRmOV+dtvPaOxQjQUHQfBvy4AIZ
	 Hrjhxh6axeVHPegx8mixFvuLLsSz0VzdoDM15s27fcnuQ/Kzd8KuspTEYIE5CXOl/DbyV
	 OWfShExU5q5SKHzmGz3M4Ngcggc2fwPDklNHdOfvD10UE3CvdtvnzIVIYgzUcrHk33g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Nt8f5eCc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.81
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012081.outbound.protection.outlook.com [52.103.20.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA4606A327;
	Sat, 14 Nov 2026 22:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9BA4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Nt8f5eCc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvwIixkG+e012mlGe8DfnH5YnUljaIYzOHc/6eLHD/6wDn3gv2PmWCigJjWvOxpa3cMW6ViOJue/cxNwjylbVZhdQ3/mhGJq9cIf44x6DwT6ejpvwOl29Jx35o4qRym3UzPj2ZvurLNVtX+aFrUm3BB4L1VjaVpkgcKgrzN2sg4QvRsNgWwSKuHQUaiHIBVPJeBpgFFApORfmF+Npg2O4rfn7COX05VeY0I2gQDW2zTFwSt8bFXrhFBYJKT4zFv6xvuDS+oGh/0/XNWFOsTzmAzDoF8nN6sAum8lNaz4kjJsqNHGg07c4YNG4gDPDBAkWOFvX4lM03xa0RInCTFSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPXB7t2xw9rOmZRkSpx8maUjoR/FUjNHzOnPnJFOfKY=;
 b=rDpkSOIQjEPAfDxM7CXaAWW6X2mNOlc1UODJpeZaHQ5URhHhgJVxe4M74VqeyDItBPNmoMfsTntkXBiNfCIC8KWlSdJoS3zQ9wQ4RnMGCmkBUS368vqUmosJyJUmhZe/j0EPskICI/FPLIikqP6T04i/AJ8gV0upz+Kh9XxDyvqEjTK0huufJcxFSEDgOiz0djarHiY+isHrXtPxSKHgsGWiRuo83xrrh7E/2tP00xzq2I85R2BHnzK7dICWIhZ1JVJeO4mzBxpPTx1KbZkN8uoqf7nrOwlb1yYO9zIWQoUqyppQcZDSLXOVXBJJJ+W8JL+m4Cw9vlfIdk5TJ70YQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPXB7t2xw9rOmZRkSpx8maUjoR/FUjNHzOnPnJFOfKY=;
 b=Nt8f5eCcnwlMoIi4poC9lUBpxO/KrJTfRdCsEI1cBfsNVqk8RqEGvwdhW99rJxiS/rZcbzgSGV7n+kqBRFjOLL20yuITeUkZMbDy1M0fqj9vkBfPiodhRBaZXrm1/zPxp6Jzm+rcoyPEoMhLuOdFGrNlv48HhTWejxCFYFGQwWX/W7oqAkAmtwHh1N5OAVbcgMWCXcHUffOxm8tSJRjqY3VH5m/nJjMC60wyS3iPgb154IDqloTg3lvaP6B0SdT44r42fEEyfgwUB0591kxvjzFkEJg90dqNRwbqAE1QpiZM1Hk85k5eR/1MTqVdeJPhzZNe++XE9WedGeU4Vi9nyA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sat, 14 Nov
 2026 22:29:17 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 22:29:17 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	bhelgaas@google.com,
	broonie@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	panchuang@vivo.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [RFC PATCH v2 2/2] iio: accel: msa311: use regmap_reg_field_* functions
Date: Sat, 14 Nov 2026 16:29:07 -0600
Message-ID:
 <SN1PR12MB252859C7CB493DBD2A9F9AECA57E2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114015302.2d8390e2@jic23-hlaptop>
References: <20261114015302.2d8390e2@jic23-hlaptop>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:5:333::22) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261114222907.877339-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: fb78c4ee-be81-47c7-1ee4-08df429eb7ab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|39105399006|25010399006|4140399003|24021099003|8060799015|22141099003|19110799012|15080799012|23021999003|24121999003|5072599009|22091999003|40105399003|26121999007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uWg5H+IOboZrjTz/xtPcpGNoiL/4PQy+E+EIHTe434vWvLbfCfI/o1sH/54N?=
 =?us-ascii?Q?Ne4mjZiUT1s6MY50/FJMFryKC5ceDepNd/7TKEywa9SdyjBtWZIfVADpZoix?=
 =?us-ascii?Q?tg63xoqhPiELN9FkszsjCWvrpHhTsnOg53BR6SuPBDFKXgpK03ZjasZ58Ual?=
 =?us-ascii?Q?OaNcXwp2ELpQU41VJP87P6/mqoVMDnycKOzZ0bSAl6oLrG6iw4zAAs94bmAe?=
 =?us-ascii?Q?jNmtI4jfxujoD6TodeOnsnsSyKBsMVbrW4LCHl+9otSCuGamp4SNAS+z9T1p?=
 =?us-ascii?Q?5HUtAmQqiTPMOQnnUUsTn5UcghU2Vbq5J5S0k8YFM0gTb4l2OjgNWmHlcA+u?=
 =?us-ascii?Q?N/JTVre4HFR3e+68IGrgtCqJexZ9sx8fJ4fdyyq529BQtRK/eOXe3S3Fh7o4?=
 =?us-ascii?Q?1WBmaarAukuACGKfZqLDAU34KU1rA7dkwX6UpbSVP8njOE6wKfKGf48+h9aw?=
 =?us-ascii?Q?fp19ga7z5Ra/nsrp8mxfAsncIsze3oHkefJgooULAjEg4Pc6kdgFin+THfsx?=
 =?us-ascii?Q?tP+5uv3XLPdUEPlzEbnkIosIsznKnjFLrcivSEypas0LD+u1PbFvsdNk6CVT?=
 =?us-ascii?Q?QpmSbiZz7lDg8kI6XpODSPOng7azngjpb5aQ7G6yPN7f51FAYyXPXdfj5krs?=
 =?us-ascii?Q?ozxTwCiuQKmZ+a2pBKexZuu0kt5R2Ix1W7vhO0wsV8IdP4+xkUxYb0NOPhvA?=
 =?us-ascii?Q?LjEOZZFOCfwwD9aCK9Cx8441rm285sNpFXeGuvomUButhFfnmSEFVrT/T8W4?=
 =?us-ascii?Q?NWyDtbbQB8CIio0gznuMi8g+71+SiGKIiPmNa6AZGGbtiqe5pC06XziVAE5/?=
 =?us-ascii?Q?kEL+3OwoNLFDsGZuiPEJ1qwUuP5V8zlbABpTy/A5GnqG25sHxuBOiz7BzQDg?=
 =?us-ascii?Q?o1+mZEuu9o4NzhatuOjPxPmwXhFAVRMvmeoTWXsOtWjPVRIvzah2FAEaPfoo?=
 =?us-ascii?Q?4/tPVpqHgCOFFx9+25PVg2jmOgkTGeNB6Zn+QdZeEQoUKZE/PrglhE93RvJQ?=
 =?us-ascii?Q?nWuuLXpLeX3vEGI+dtrgHobjHmLsethVGwjyXCsWg9jk8nYsnIgmkM7JU/we?=
 =?us-ascii?Q?G88pfWBIwbWJRxz0hfnnM/ZrdZCaoj/7dig8dp6WDUqT/VTqxa4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3fsXLGsTk9t7xqT07s+gBf6unT1sTqkCx48Do5HbMSq5IF4VuVqnMZDh5JK?=
 =?us-ascii?Q?2QYOHJIl/rVukZ6oB8sPOux3TF60wklBfy02l/1ddAPSwRDXq9yhmL6OK77S?=
 =?us-ascii?Q?ifG4+kvpQXLxpuopBZe93UVBayTHB0XN8YgPx8wFO/dE0+9khR9C6PRnKXnp?=
 =?us-ascii?Q?2YzxA+nXyWM4tP7Y5sZ+SZpp/iT98bzjO2/7Vz/+pnIJB+iU1pxxlhaapBgl?=
 =?us-ascii?Q?fIsAUrQKPQl5Uuvz1ccdqtLgeVwEZClM1a7m3gHosFf1zaFvqgi+0EKJM833?=
 =?us-ascii?Q?Q1JKsfKUMlJusR48OvjoxmtMiq9CMCqeFZ8OYY7b7jU4c4F7qB64mC9mVBoo?=
 =?us-ascii?Q?ua+HOZVj3jFCHuKWPflyuQIt4KeCe8wKAMK1kiXCSX7nW2u3z3oAzQC/cxWo?=
 =?us-ascii?Q?nx/La2zpiTuMEqs+w45t7tNdVoHU2iS5440CCvubuYa2kSaRsuIDjwrP4gjI?=
 =?us-ascii?Q?hcJkcOzjg0VJ5dOcIzcY8qcyGhJzbbLkadGyDOAJFmsm/sr5LUcZ2Ulj6KgG?=
 =?us-ascii?Q?4lp4hmbJdYWfwnlieJgOaFSreywm3smrwoVfWasIt9i954xiWh++Ma5exU7G?=
 =?us-ascii?Q?8QofXGXUtJq3u0A8+u+GWZkNk5u1pJorkz9CMzo5OlULqj4ULsdGSCEkdHQo?=
 =?us-ascii?Q?IC1ztT3/EL6YJze0t4BPo4KZtVyjQeJ1+50uWjDQWtC0h+Ss/WADRR8l6XUS?=
 =?us-ascii?Q?FtUXVfuxj2xnJ8K7WlAZl0rmr7R0+48eW6ZVnlhshhv+8OUW1R5YAe19Dj4Z?=
 =?us-ascii?Q?cMSHFd+RjJaVinwKN4BhRKY1clpqOlHSV6dr0AJ3sqET3ecPqKhzEzV9wzQ8?=
 =?us-ascii?Q?GAVsbuFPUTGa5CqbDEqNf8XjRROjh2tMMsBLnrSSdBSDUwp6YvFHR2vZzmUT?=
 =?us-ascii?Q?GuYkf9hjXyB3Tm3xa/Ek+ll/F8IBCW8qxpXYaEIOR591YbHEGhA+Ds+sj24e?=
 =?us-ascii?Q?ijtPHJ/QvPioPuk3ELVYEpTr5bucth7pj25zj3rY8CEQGlrq3m16jjFP5sn9?=
 =?us-ascii?Q?jhVlVBsLTRXKKc+4I0HTmksmWniB+mlkuZk9pnj7hvbYnIeS+QeoLGveSymL?=
 =?us-ascii?Q?XDa2kymnF7tnRkm4HVyQJj1FQcR/r2AiViFiJGx0KHmeXPT+YM7y8uN1FJaI?=
 =?us-ascii?Q?ru8Qw1+vIsqQG2O+LVcoVspo4mqV7H7jMdBC/UYoD2keluHJu2bjhUZQGJUo?=
 =?us-ascii?Q?N+CM+si9CyXNCVgLQ+pkT6QsfxCe31oOH7ZouqSQ8S1MC+Gc/D60HF6Jbsf/?=
 =?us-ascii?Q?oAlcVqX6LXcB9aj1bbCRey6OfQ/mWOGP18U+5G222PS1/BuPaaxCaCqeNrgc?=
 =?us-ascii?Q?VRGop73L9Kp2KNkyeYevITYSIhub76bUhwRKzoPkr9WLt/V00fXp0Qhm4csq?=
 =?us-ascii?Q?CpmC4IMnw0kxp6D2LGKAwQ2O9WKXQFsgkYPjhtA4gcdrgaEP8G3J+eiPJlJC?=
 =?us-ascii?Q?c6G11iFUd7q/w3NmnA0FEpAtflOB/RT7N8RZCdUbl3KA5976txwZZw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb78c4ee-be81-47c7-1ee4-08df429eb7ab
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 22:29:17.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521

> When sending a small series, just send the whole lot to the list
> and all people on the thread.  I had to go find the context
> to understand why this was an RFC.

I think I was overly worried about spamming people, that's my bad.
Will do with v3, along with your other comments.

