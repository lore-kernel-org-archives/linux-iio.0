Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2C3E0C5F;
	Mon, 31 Aug 2026 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176798; cv=fail; b=l0NyhF/D+Un7ckDs8EXMYW765Wa/HODkA9r+ZW6DFxFtomehQpSLaMmKcW68HsxAeV2x8ESUnrDN/sVuCGNXQlrvjM7cDPwzPmP8y0b+xM8hOd4Qg3gY0HX3cW4XRNbmQ9ke2QhuI6xGSeeiY5G4l3L36A/sQb73EsGaROHomWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176798; c=relaxed/simple;
	bh=2cpqhKL01CQQel22sErJzFhAnW+nHPJNhSgCItnG3ic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t+7S3gMMR7RdKPW8L+I6ds4jtvSzf6MVjjtvFFg7MSGwh65WZEo0ZCPbvTHTBBJkpxuY15F11HxcgJO8QFPM0CQstwiCbJWOiTFgzy4k0+5zCQa+wOEJOFf/nmI/azAYMikGGsFoPDWdnVtKTfPb421hgG0IkGEJ/wAdrIxw7RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zduDFOCW; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zduDFOCW"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBA6w11649890;
	Mon, 31 Aug 2026 07:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mrkRu
	nM0ha1bnzTQQKa/UPs/Ym/Zet1CWjMTr2h1l0U=; b=zduDFOCWZVnkXfMEEoYk7
	3Z4EFi211nlrj9kmnHPCEkF9XX7MVzPc9UNJTjulbqPRqSgD6lMBTMUHAgPHluTK
	GmcsOmevYWJWs6KmcBoyuo4ZQXY6/uuZxRYPIfe6iI6pXJU6dlTZb9DFN8zhVvD/
	IjA+N6pD7qP0+XcTdY9vzakAQM3EkfmDI26Tc6LltjQw47oyaXCsTiS/pweKJg1Z
	laTBe7vfMzbHeB6Xvjw/b/aYkPIvlqfVN1zNhBIPK7ZeNjGfwygWBlOJtjHFM1bO
	Mg795pj765vdsc76cjhDzXphH6PXXmrYDv3KtAQe4zfPqC7Ar5C86fB3qWPoBGXt
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbs90yqhf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG+PicJ/32x1iwWqYzdieeXuPPpjB7F/QLd3JMvl10vBYcGPcrGreKB8maP1DbT5TMAur8LHZynudZ3EYwQnQmTyRyknhppzTj5OA6whwRkb2+OjEJbZ8+eZCXV6YX8oTj0LGUTyJXzPJohMMF4Q0GJte9abky2eiq5T6Lf9ecOC2Jt0dJnZHKnXLQ2mPcwUkCDtxNUVbyS8NQt/7cfeh+76KUqBvklNNVE22YWbcnac4Apm1PWZWsBxPfEfDn8AgtD5BhOSStx0S0qVabTbbNwIc/is0Ny74FzdkdJBxq+hOGI4IDRefvjfi5RpX6jN9GPvR3pshTw2RcZEnFPetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrkRunM0ha1bnzTQQKa/UPs/Ym/Zet1CWjMTr2h1l0U=;
 b=oIAvE+us91afsxNXFToa1hn7QwoZHOANSMyqjTUj49rFreOULFLwMo2ndGZZP4M2Mc1tYowXtHNd57Bwyz2E2637RNWtXixTSWPeRcfsb8I3Rcm5m80N6DiN6EPaAnXWOnWAU4JNBtkRehiKRciGJSINJAquL/1IIxsHF4xwgUSvOisELAWCbwxlh9+YDJBAcz0cTh97u3Iknp0QvoQj4wmI0FXZiTLvKLgQuSxn125zMSHio+C8iEcu6VHpRwHh5C+Igne4aytDyWMVecDP4ZuzA5j6872iIKzQFYhHGEQLGtyNHci8b+3TUoQI/aOanRnRBDP8ZlB8T1D94QXUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:49 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:49 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:43 +0100
Subject: [PATCH v3 6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width
 accessors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-6-507d97496f2d@analog.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=1894;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2cpqhKL01CQQel22sErJzFhAnW+nHPJNhSgCItnG3ic=;
 b=jbMBmCEm5uJfiwa1ZDqEeE772oi9cLlh3ZPuxEDOYg3tBTnObcysXO1s1AVFpIZtC5l9IWhIu
 orENfP+6V9HAslyNDzokOwx1i5ScdGHerItMw1K73481e8opHwUWBz2
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0132.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: bc220e03-5106-4fd9-afcd-08df075566f2
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 va+1bNNjPhETQNCcgvAnFqAwjf7MsTRJ5FUmcMC3jGumj1yMYaNuWvgNMV9SBH8YbedjtzbvPs6bWFaQgD5X6heO14UNAg8uVE/k6Qfj/nqafIbNUBMMoNAazbfE2ZHoK+YIOPiFyN5Lr913XBnBa6zwih+4QTL/bNW/0ry1SteuL9i3/lh/9pjquxralYbjJvHwj4HhwTr9mcpsXtyb6WWWNX6HObI+02jCMhqKIZgoDgaJvKFq2wXTE+mgFmWBfAPQ5aHjJJKF9i6fuS9WRtvaYpYGCkGrGwqvqqacwe7wMnOiD5WMRDzYBemxil2XSBkhms/9DdPQpAWckM4dQV45ffuAESWYiMlFERndwGoed6Gnj9HUrJDZUiYcNhYWq65TK1ore42FG85mYHX2AnzHPP6lD6xXCS2OAXl9YH9YaIf9+AAV45DeElsW6b73xnRHvUU0wr1cKtdGHxXZYeBl0oNsEwbkJSaWe6UssSAvwqrOfwXm8ouWuA32UMUmVs+zixFe+7HkQwQAqbh2Sfk1lHnjpwxGIs+BJCdAX+PPxdr+rcp3vfZFVx1GnWXlY1T4YJEYhDPhsuj8Bzc7RNXmOx+pKN4nUoxQJA6bqtCoKuJ+ZvQRSaV/Eu2+O6lMpN7m8Z5EGum/u7K/syZy/+j2WFw1vWIq3Qx0qWssuwM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Snh1V2ZIdlgzNjd4OTVXTjhSMnFSQy9EY1paYlRoaERMOG9qU0p2WGY3Y21l?=
 =?utf-8?B?b1gzNFhaV1YwTVAwYzRzSVV3RG5pSUZHSFZNWmVPZWkwVEZjNEg4NnpldXdU?=
 =?utf-8?B?L0ZjdTJXQWI3UWRhZGRKaUdnU0MwUm5HOUFmQnlTVU0zMjFPbTNBbzZnYjBp?=
 =?utf-8?B?aTYvM3UwK25SYXNEK1R5WFdnOFVQSGo0TS9Bb2ZSMVRPU093d21jZ2p0TmdZ?=
 =?utf-8?B?SDdacUZGYmhWRlIxczVrcWU1dVpNb0NRbkw0RGxPQmFHOVhTb2FhUTN3YnFF?=
 =?utf-8?B?Z1JDbmhnbmY3clp1ZTRSSU8yNzFxdE44Qm94am1pd3RWSkF5ZkJ4Ymh2aFpX?=
 =?utf-8?B?TGh1cENUVGRUYUJjV0lXTDVHT2dtSURsWnZJUUFEZUFmSU9MT1pZSXROUy9T?=
 =?utf-8?B?M2tpaWd2U1JKbGZnOWNmSGFZQjJhRXFZckpEeWZnc21pa0JLWlFlcnRpNVZk?=
 =?utf-8?B?YmlwRmV0QWNSRTBremVDSlN1bStwaHAwKzA0ZUVxRTM3T1dFNHBya3RVdklh?=
 =?utf-8?B?NGlZZlFML093dFBUOThteGNVYVRSSWFkNmtrTStaQzBHei9VR2RkYWprdlkw?=
 =?utf-8?B?MFMrV1hHQ08wRGJXYkVDZ0tZeWhFcU1ZWGU0Z0dZOXZ1ck9mcWRLK0FuWkh6?=
 =?utf-8?B?WkdOQkYvZy8vT2cwM2d1S3BJcFpzdzhvZFhwNjA0SHA5SGRaUWFod1hZSnFw?=
 =?utf-8?B?L0plcGwrR3ZIdVlwVHN1S2pmaHlPVEk5U3BzUjRJK2pRTnAwWk1rMzRpanFY?=
 =?utf-8?B?dXZpdWtLZ3dEQnphd05ueFl4NFJrMjZoUXIrTkxCUk02MDFrN1o5eU5OWC9X?=
 =?utf-8?B?RHp6UG5JTExmYXhlblpyZFo0cTl3dUZyczNSUGJDaVY4cW1kaE92QSs3eXZQ?=
 =?utf-8?B?NUZnQjRXVDQ4WGRCRjhUS2JFM21iUWU5VjNVMnBlWFJWK3cxdDFUQlBGV3Z3?=
 =?utf-8?B?UHZTaVluZEhkK081cTN3dnF2d3pMK2tFSGY5a2gxT0ozYS9IYVY1TGJ6M2V2?=
 =?utf-8?B?cERWNnd0VC9OK2pJQ001dXVKR0d6N0hJTStZaC9kZk5IeVR0TXdrdjArLzdF?=
 =?utf-8?B?Sm95NjhxNVpQUE5QR2o5YTlMWXV1MmV2ZzFBOEk3MDZvZENwNmdYM0RhT21m?=
 =?utf-8?B?MGJyWFRmZ3AwU1dpR1ZDS05GYU5NY0NIZnRXNjlPYjBGaTVKSy81cTVqeVFB?=
 =?utf-8?B?UTNVdjVYZTNhdGhqMFRROGFLWDVWdVJTM0l3Tnd0TnhNYTNjK1VnQnQ4VFg3?=
 =?utf-8?B?aTJHTEc4Zm1qb2wwejB4YmpYVzFwV0ZOY0RMSTJvelZLdG8xakIyQ3FYMm1Q?=
 =?utf-8?B?UnA3SzNRMnNtUG5iZEhGRUVaTElpVXQzbnAxbWVCNU5IN01lZ0w0WEJoR2ZP?=
 =?utf-8?B?VnJxbmt4WGx6dVQ3Y2ZKWEtSaEZNOGhtMFoxUHdRRm1XL0tCR0xhSkhqV3hj?=
 =?utf-8?B?QXBjY2NWbG05dnRRMHcrbktEYWpvakpNclA0QTVTQ0ltdDhDV2NaWVJVK0xW?=
 =?utf-8?B?OTBxYWlVdk9ob2Y1c1N6a3Jad05yeC9UdVRMQkRwUWJVSlJGaEw0dXdTV3JN?=
 =?utf-8?B?bG5hYnNyYnpIWjZZMGlpMThqTVRtRFlIbFVEdDFRamNTOFMxakxweWpEaE5B?=
 =?utf-8?B?N2c5QUdLOXFGaGJlZjVNLzZXOWk3Y1ZOVDVldHh5SVJHZDUyZkc0RmFDRWpu?=
 =?utf-8?B?d01tc3lFUFFDQnAxZ3EwNUdqZ2hzWEExdis2dkRIdzFPVWRCUHZ1MThtQ2Zn?=
 =?utf-8?B?ZUoyTE1ZcHJPVXhkK09QbWhza003eTVoUk9pVDNuQVMvL1g5TlJkeFB5aGp4?=
 =?utf-8?B?VTRtS3ZxRFpPTG1KSnFxQkJGYTNhSjhna3N0c21yVDFaYjFCT3ZRanRvM0NL?=
 =?utf-8?B?UXpuQVpPcnBxNFVRSmZLMkV5T1NTYmc4WTRqdkorbWgvbkwxVE9BY0VJdVdH?=
 =?utf-8?B?cGxJSWlVNG94YnhEV25EY2I0WEI4cGI0emlEZVZJQ3BKUHF4WDBDTnJZMzlY?=
 =?utf-8?B?MTRleEV0MlRWdGZnQVVQbXNxSHZVaWpQYi9Yay9neU42c3Irbk5mKzZIWXZu?=
 =?utf-8?B?S2d4THJjZXFiblk5ck92SU41Uzg1RytPLzFyV1dCMDNvaDJFNFFXa2NtcDM3?=
 =?utf-8?B?d3VEQVovbU1yYTlGM2Uvcnd1blQvQmNRN2hJNXAvMHkxc050RE5rMXYzQUVi?=
 =?utf-8?B?UEd0ajZ5N2ZFd3RsNStXeWZKSEcwM0xSRUh3M2JxTzdmTkY5SXpRanFIMmxY?=
 =?utf-8?B?YUQrOHRITDBkL1NZOGZsSEpGK01NclRBRjJmMHZqaW9nN0NLMk9MZExTdito?=
 =?utf-8?B?bVVFNVVVU3RLenQwdWl6RmxWNExGMFRzVVJHaTRZRTVtbktldFlOQT09?=
X-Exchange-RoutingPolicyChecked:
	tD6LSVJykgi98WmpxQwtKPR08fe+09lMi7D5B89scqpl7LEfD5nbGcoPrRpsUkOBusi2VHauqoGBn7HL6TlZve70aZvdHwFd2yMJEqExN7rHloIzZi7xhvxo6yuHNEfA4JsQto3fCNcahfl2RzTubCHupZARitOC/0G9jNboHPNWDL/dlXn1XdK+rRTmtv9o1568BbuU5xHT9EZCL+ywyNSBBtnP8I/Ffjren+HhxMuFMoBUdCPgB2PikDRfEnSWGQiXNrZ9+EwQg1cT/ytMFR153AYmSPX2XHequ98hmkEgFBF1W1rDUKGT+eVsjhi/kMUwwr+oAJ51iF/SLoqm5Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc220e03-5106-4fd9-afcd-08df075566f2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:49.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWxC5SWWDiuRuvj08xUYszjoueQKfulyMrvKgHR5pVcvoAFGAHYBMwFdHgGCn0yGtdANC1uE5MEC12v0mRyWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX8jwzvutL72A0
 m3brL2/SBaBslNet5WXv3YlwCysLDJ+7PDdxAw60iwEmhNqwUu+aOKyB99/+bF6ZY8kR9KV2heh
 BXka7IxCJ57BRN8S+nJUxnrb0D7aIT5MVTk/rlptQal/e7VBJvGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfXzIdvogJ9gI6Q
 BPzq1E2AIB2fwRRwhcIRYOEIq9dbHk6hIwVbv7yGxBaXBiryYEuxx9iFsOa4qP85DoYDvadr5qx
 z7jA2l7BIi90r60g+1O6pyJSnHxpnT6ntQZ423c9Vo9JuwOlHwnKpWxF2W6mYNJ/PU5elErRXQq
 ocXc3tDo2kus1uccnrpbpEXlL+f9xaZ/wPtvIEYwTGtR3c5V9WbPzxPU0wiTGdazed9w19NcFXS
 WQFVAaItdvqZwr3ctFrzFdgppqXPd9f5PoCiANGfa/belJoUDzNH7apTCxPjcwTV/lmPxIWd9y2
 Y2Va/agoe0seK35uDaY+foBHJAv0hE8sT6Pr/D99N52s3GfIqStzPXOgqcxXPfi33NdXBe71liS
 YWZFxit3cfJkuMuhnSDVpScqn2FdcVwYy8V6mKrkmMIINfZbo2FcqJnCIywGkCzx4q6nRfs/wmx
 ZUW1xkVR5j0MZphlNug==
X-Proofpoint-GUID: xgwqJ_K1ES-A3tWz3dHuD2xNyNS6lKoL
X-Proofpoint-ORIG-GUID: xgwqJ_K1ES-A3tWz3dHuD2xNyNS6lKoL
X-Authority-Analysis: v=2.4 cv=c9Cbhx9l c=1 sm=1 tr=0 ts=6a95696f cx=c_pps
 a=RzNzSA3Xhmsnv5027CV2rw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=gAnH3GRIAAAA:8 a=PlQVE8PmvpCE9iZECF8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

Query the minimum supported source and destination bus widths through
the new dma_slave_caps_get_{src,dst}_width_min() helpers rather than
decoding the raw legacy u32 width masks. This keeps the buffer working
with DMA controllers that advertise bus widths via the new bitmap
representation.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 98acce909854..e1aea691b732 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/cleanup.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
@@ -229,14 +230,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 		return ERR_PTR(-ENOMEM);
 
 	/* Needs to be aligned to the maximum of the minimums */
-	if (caps.src_addr_widths)
-		src_width = __ffs(caps.src_addr_widths);
-	else
-		src_width = 1;
-	if (caps.dst_addr_widths)
-		dest_width = __ffs(caps.dst_addr_widths);
-	else
-		dest_width = 1;
+	src_width = dma_bus_width_min(caps.src_bus_widths);
+	if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dest_width = dma_bus_width_min(caps.dst_bus_widths);
+	if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	width = max(src_width, dest_width);
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);

-- 
2.55.0

