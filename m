Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793095492;
	b=BzVoSuLW9OcMaZO7suWJzbgqkPgQW51wW4GePo4HXHu2GibeAIpNNNjIpgj/PoF0uv2A
	 ain4IMAMxKLWN/4JNqwOKcdV23sASz9tLuORlADFUciRl63PkDIDc3S1zykYWjbkUhCvB
	 BIlO12Met7jnU7bBOdaAOA5509VXAEZYX+kPtsf2wsciX+/QXaIjMkfau1CFzx94jAZm3
	 JjhXobdeGQt3DDXMzyRkHZmNdTW3+20+MCyxMdziJvr6CaDS2C7cHPnY1ZQ1fKZlgYICh
	 sa+QAWdu00HdzA8x35Ef6/FayueYSPkV6PgiGpXH8k36u+Tbtjxj2Ory84EZg2Q4Bow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095492;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6P6XX77GPlT9VMLg+ow/nFbvjpa26pAIEiOuUN1Ua6A=;
	b=nk1Onu6sScZkdiTQowczZZXqpahCKGGWLsRG5Sdtg12C93djUgQdtUNw9dCQ2AB7Fduh
	 vKEasKbFI/f+t0HBtnNXdgS0pDnEi25NzcayYCdhuzKUDBuwxEfVrIwOah6qNrr42tIWR
	 PZbz9mosLBTNPmzUNJxKZ9CKQ86Fu2yjzqhMV0vNtUKB2BjuUFMsSvJBZt0GXNr2yJVfF
	 lbsVRMGCr/KdgDfLS0wQVOiVXu51h3zzi0I+64jj7Xsd808R7qJdzAswRHZDVS2YZHvDi
	 X6BEIXb02e6yCkutHvGPIBgQ9IAzUMeGIJ23DIQISLgB7oTM2fm9jpRDhInQ17CUrSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sYBZDlUV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.31
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011031.outbound.protection.outlook.com [52.103.12.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253D606A332;
	Tue, 27 Oct 2026 10:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3253D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sYBZDlUV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnKR+Ko+pAIOkVgAioEWgq663N8s8FSyZLcv21TFw1N+I+8MRqhi5KGFXRnDetCR6CHzrroI2KxCnNg+B0vYQA9jsvu+CW4H12FiYOC6z9lkS4G3YvL2+/E7M6eN0I3u7ji3fSj5wBhyV53O7JQc8lQFzGTajeAs3JEiNK++HzCQpfbZeiCJUOC46RPQZtQQD5lpzWZWqCKs/gayjnwLNJTem5uhbDKF1mgIMPQ3AdJVWcV9q9J1jeEYUzCOlRahIFWxfXTZeGw0jP3GAklxQajTFQpVDw+mJSg5IzBMCI4w8ZijKPoVi90nuHx5FE0SlASCL/6G8U74z4jCjt7vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P6XX77GPlT9VMLg+ow/nFbvjpa26pAIEiOuUN1Ua6A=;
 b=ZfQRqUxpT7K6BOci9bEKrerlpw6cpYvA37MoyD23FkXIXethwrH+iBRQrXvrA51CL9XS56tCD96ND/OvjWsSxgE1WZwxx3mcnIv3gGtiGc5FHMn3wznHFvc/uS9/iZzeNGN2ho8CTyWthJRISxyNdILHHOePoABHC8G7olZwcFpB0OGqBUkQuaYUJ+wuUkFL89LjivNU1aKd9GICFfcg+rxJ0zqNGsJC9ML8V68MFHyvs2pORlcJrGIBJ59MgCbs6BgPCEAyI75K3MdsCjC1QLD/zJ7ji/foKCM30JYlOulBnwzVVmdfw42BJrbNIHfLeXumnu7EZTLpsjQMjV/3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P6XX77GPlT9VMLg+ow/nFbvjpa26pAIEiOuUN1Ua6A=;
 b=sYBZDlUV2IKujnY0G1mPn4Ra7Z+rcDs5MXG29RvfjR2UVuC25rHkOdNyx15RnozFqRq8oB6IcROerCGHrLTQtJEPnrtOt5Fbdck38VYv7lfKq1aB3jvBsO/723IzJyUbPztJbettU/x1c7bQu+RHWI5QM2UsFrd8x4maG6o4nqZHpT0mS3PEXwp3so6OpaMgter3tuY+3PIXccPcU3LhhD4BSl4rGRE9I6wVGZc6fr2oPulcjEsp/vWbSiIGWjbAJKUS5JIH0OinIWQ30ABvk6YcGcNgjo/3MwSt9ZscqBvpokya3sWtcPPBrNmRd0uzVFbWjO32ID2W94yrmgE9xw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:04:48 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:04:48 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Tue, 27 Oct 2026 05:04:38 -0500
Message-ID:
 <SN1PR12MB25286CE39CC09CDD0D07889BA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auBTxjakiTKn1LL_@ashevche-desk.local>
References: <auBTxjakiTKn1LL_@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:610:b3::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261027100438.176635-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 293e1998-4231-4f67-c4b4-08df3411bb8c
X-MS-Exchange-SLBlob-MailProps:
	CLk2x5OX5VamqICzye+315pYcDqahkiGydp5MQERJoWuqfTbO2AUpJnozFV9BP7pZ96e/xEHFCJNshe4w9b3pJhXvZgnpHNhzWPm/jXtec1HBWFhvJls7kjZKWjzbHwkC47fQ4gtbL6xsKvkPD9ElSEzBCSLUQX2oi5PWzPKgOu21RoGQoFAAqTcB3hEauL0l+aVJrE4bYWBaiOsLG2Yx/yIK94ALNSw0Ii/11sRoYSHZ7HTZi4QbLd8YVmEeBgfA5TOFWIT0T+5urzcLiDst5QTntRiVY9ZxxATwlWdomf3r+hLMIIjBk9THUjvFPWzozXYp43U+qrXUdVHAKz8wU6m00bg1BbVI4TXcyQI6Owl1iG2wn9bBS+sI4PDK/AUPGhuJP/BTzepN68kdCP7SbDxEqHyWKBGRlOt9VRGtGVgwP9ButZEWE5151RcchdDXpCW38e+p/7daUOKo6b0PlsaiLeYlh/G1Sg86w01Jer1owPV5uLzyThzd9ZxgY7qukpp1wWXLKvKRcY7TCw9VhTCHpBI7QgjcxUGtMzOFA8sbrGwyphSnnMZRO788GDLEwKuxugQfSN3XE5Jt0WeCxxw7YacmXDy6HVPRJDbeRjL2T4V4DSMPHH9+MMkpczoeoOGuYQcehCNms89nbsnMsqHseL1PwMzVB6A7RXc5VIt5UKhCYXxyBJcvAIM/FRP/THAxMosJFtlXfDnNAec1g==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|5072599009|15080799012|23021999003|39105399006|24071999003|260925184616899003|24021099003|41001999006|19110799012|8060799015|4140399003|20031999006|25010399006|440099028|3412199025|40105399003|261007181701699018|26121999007|11120399003|261005200801699003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcS1uKowJK6ZDbuPX5ps6l7edMSuDpdLTP9O1wj+y4V5KMzR3ehMatlI/U82?=
 =?us-ascii?Q?eW4DWZnYCKp2HOWemiQPsPUqrv9Crg1rgrwQfYDQv8OkPrvuNxzr1fk9yGNx?=
 =?us-ascii?Q?+HvsHnqLtS5xysANlXubYbmWboqoeppChshiytnrPj4Na8rVCjcwHKZRfZfQ?=
 =?us-ascii?Q?hjO7HiVWtchtW98wtl5Q5/dEbToJa5BWjw5o2Nc7/dXCAyDh6XI1qeT53JfI?=
 =?us-ascii?Q?ZxZf3+re141oVITQSWOq9jSvj/JG6MT9+fI+oo0bHZiE8IO9GpW8xQOLiH0z?=
 =?us-ascii?Q?2w7792v6i5qxZS0+hD4kVBRJCTRZgRjLRTeJX2m1RyGYkX32F/7Vd7E7XN6F?=
 =?us-ascii?Q?no8iu9jCIwyNfRQGLd+z+I/VDIan6DteP0hOLdSfm0UGIvrf1RXHpYsP0kAM?=
 =?us-ascii?Q?yQcKOo4ZPuvhV9Gj2G2dUYqYPfMQ2yFHxEnDid9X1gW5zU/cwIZfsgRH78NO?=
 =?us-ascii?Q?OQqcnMnNjOifHPFB0oC4ajMFGPnJ1TothDs1nuZZL47KaFu1iO4F/l4hB5H5?=
 =?us-ascii?Q?bgNet+xhLkeJCPCO9hPsUgDr+PjDI/gqkwKA7lA5fP1GhPCyWzR58LH/TkUQ?=
 =?us-ascii?Q?kir+r4je7Hiuc57H3wCu1SJPjlNLDb3Hwm+EZsJna+wD17/gja+BMnU+KaUW?=
 =?us-ascii?Q?kWF7nomNq6POjPP9hZnALuJH9IAit/z2/in0ehWhjvuzKpLoP+yYHJtVpayV?=
 =?us-ascii?Q?H0wBuJ0d+ETUp7H1XFN3C+XQqswvOIIW+Ds2Q3yhTZ9Jvd+Ze+HHwnltCxy9?=
 =?us-ascii?Q?+semSPiBCZy+KV/hQiyQJyIJX9+vaaD0kxqoz3BMpkGekl0Wq8V+FGjkAwBu?=
 =?us-ascii?Q?TkilS+CIIGtuVCsIJqQpBVQrVGBauqBPdeQZSgdu7KlyrRI4nNniBj3FCRXc?=
 =?us-ascii?Q?y19KBdFI9yofYQmJolLGQ7u/VOAjFc8kVMGGGaCuuPb34nes+zpO5HNRjy41?=
 =?us-ascii?Q?EoOunhKzkSOvkFnHQiG+L9mqoq7cWmWac2rlOUOEWxbdbXeesmhAhRgAEWs5?=
 =?us-ascii?Q?ySHw9URj9Xdcx5rpOsH3aOSxnYACnY051CIk4qOjsk2YiVD7N3uiLH6l06RG?=
 =?us-ascii?Q?SsJSFMVSmEf8XW24lEVI4CnYsPXphd2pgMhtFvo7Dg0mrahJ39XmPRzL9rsW?=
 =?us-ascii?Q?A8qMtVjB3qCNsX769FMUVX//YxK0Y4tS6LZz89bQYAV3ngCnzjK+E23HW2pC?=
 =?us-ascii?Q?WtWyk+17GfGBUTTfQmwQaC7mQfMwthrwa3XRBA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zumTszOqp83UUzjbRnpCHMnDJX088R58ewzwn1BiLP/Hu6yKGrApdIzNoz7?=
 =?us-ascii?Q?NyO3XIhF3zHLTHKa712qph6KsSbj2G7kGy82Sfg0exCorb8CVRxHJJ2JprCy?=
 =?us-ascii?Q?jiruK0v+B/SF5QBF08RT9b/U/EzejNxfu6CzxjRKCjjjL4HsFGKH8bIvsSIH?=
 =?us-ascii?Q?1hoXHxwbU3Tyw/RN9yfA06B/AxJSQ3lUKerIkar5YSoXxKfUgabFK6q4S8iQ?=
 =?us-ascii?Q?Af0kY6Xxckjq7T+pbyg5s1sKXljbe3DIjbO5E3zVFVUm5p4g3PtJCz4xxCH/?=
 =?us-ascii?Q?HFwrCui6AAABGHxvFtNp+khSmsS5yl2arixhZ1+xkTr/btTehR8morWsbasc?=
 =?us-ascii?Q?a59Bzj66TV5kRZyu1zmhnJb26mvTiTZ2clQ2mK0QA7X+Y3hyJD3cubcpLJY9?=
 =?us-ascii?Q?D3NayIuBaj30v+68CT1wjApXqpGe0yRy3sZdruY41TNQkjkfiXIrQRmzk9Vk?=
 =?us-ascii?Q?668aipjZVMh2yadV27Z6KgTuvo1wy6rYwFEAsBMdralHRdIWrY1dlvioVsS4?=
 =?us-ascii?Q?1fS3r8q8sc6M1/U/TthHoUPfmwHe07+hDDgx1oFX0NUV2qKWZVdKLUod9YgE?=
 =?us-ascii?Q?wD+se6FiWYleK2Oaw0kbHPi3VQq5zNGIfo7BLPHPdxprlcOX/rAhUEoCCqa3?=
 =?us-ascii?Q?IDqxxL0GkVfMA8dR1sb2kDdTUdpHS/knYkOxFvGMOtPIjOI/0Cxb84BA6De1?=
 =?us-ascii?Q?OK814uTYFW9c+4c9LiAO2QHbSCXnqlTyd676TG+7zctnhfEXDz0wmv2atdRH?=
 =?us-ascii?Q?mnlylVIAS+3nxk46xPSOcZ7bFoOci4ePIyc2I2/pBaVRrYuizzSCqr38LsKV?=
 =?us-ascii?Q?fD6ztluzbnmH+mOZYMjpDM/Fi+Em+D/Mxdc2exPCI3UoO3Qo+Q+eAifjq3c5?=
 =?us-ascii?Q?IXDyBLYJ2Fq6H9R61n+147ig1q8kiMA+dPEfDWHOULH3kZkKmYZTMGA1Ev6U?=
 =?us-ascii?Q?B6Oz1sT2vwAHjGLPGoNMRcAkpgacMUnYTzf7UCvpQQcREPyvsQaI7qLIsVgx?=
 =?us-ascii?Q?YZ2WS1jmyxErXg7Kszb/3FPzDpYD/mvHBAEqlJgiX5BphDf6V53/QLhXKLKo?=
 =?us-ascii?Q?1DUaCLrd7uOd3vcYO5LY+e1POMHGY1rRIz3xys0Zxr7y8VJM0s2LEYY8umye?=
 =?us-ascii?Q?OUio3fVycRaZEVbwsjpTqWd49/hlYG9A1bqdJHHRbRqpF7ni57fBvUToWRlD?=
 =?us-ascii?Q?YRQzFBcefjNcoZqSXqxOSwMDR1rpsQFkhEgBrxHCenSbSertV8G7jesC1mU5?=
 =?us-ascii?Q?Z17mFzLjpD/M9JD6L9Ji3uYXpwRqLPEeeejY048jvTx8FgU2vZEjyxFCcytZ?=
 =?us-ascii?Q?uanirAWZ+Ao+eyTuZZSNY+XE94fXnj4F62q7YfNuAqyt/qJ9G4WDVcMVUlhq?=
 =?us-ascii?Q?fxLFgrlHtutWZzUwSwIbDOAHsMgCrhchiutEbosvm7uErN6M/Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293e1998-4231-4f67-c4b4-08df3411bb8c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:04:47.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

> > I don't like the duplication either, but I think the real problem here is
> > that read_avail is just a somewhat awkward interface that doesn't allow me
> > to return s64 values directly. To me, having this separate decomposed table
> > just for read_avail and otherwise working with s64 values is the least bad
> > approach.
> 
> What about adding .read_avail64() (in a separate change)? Problem solved!

If Jonathan is open to such a new API, I could work on that! I think
if we're going to add it, instead of just changing the two int* parameters
to one s64*, we could add a union for the function to write into. That way,
not everything needs to be represented as raw s64's; we could introduce
a proper range type for example:

struct iio_range {
    s64 min;
    s64 step;
    s64 max;
};

struct iio_available_value {
    enum iio_available_type type; /* IIO_AVAIL_RANGE, etc. */
    union {
        const struct iio_range *range;
        struct {
            const s64 *vals;
            int num_vals;
        } list;
    };
};

/* Used like so: */

static const struct iio_range fdc1004_calibbias = {
	.min  = -0x8000 * 488281250UL,
	.step = +0x0001 * 488281250UL,
	.max  = +0x7FFF * 488281250UL,
};

static int fdc1004_read_avail_ext(struct iio_dev *indio_dev,
			                      const struct iio_chan_spec *chan,
			                      iio_available_value *out, long info)
{
	switch (info) {
	case IIO_CHAN_INFO_CALIBBIAS:
        out->range = &fdc1004_calibbias; /* No casts! */
        out->type = IIO_AVAIL_RANGE;
		return IIO_VAL_DECIMAL64_FEMTO;
    }
}
