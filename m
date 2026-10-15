Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAA50C2A2;
	Thu, 15 Oct 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059597; cv=fail; b=nksgdlGpf+dXwjVxCsz6MOPSwjz5s4tE2yj8nmcgZF6K//5VbibvPCKQTZV1lNk123Tmf6N9fiW68mAW56s8kw0z8lX3TkHUc+lSzELLEnpAB9HL3VpmpM9GbWixzyc4i99I9/aaYGi9viVGiZsoCntpEi7IKKXPXsEPEFfTgZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059597; c=relaxed/simple;
	bh=PWVYAVs4yoMbjrWQFacloqFdgX5cdeUGeFvueCZjk+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kuK+oPR1klYE3IjdBHxRRmppZvopFM2ZDoABqpBiuXCgjFlaicIoevFPCDCDJYCPbvJ9O3foOmB9EfETBJJ2EHyyQ1qGvqO3NEr0S4ClvFglzqH8QdwhEbLikea3fncq95VuVvIwdFew9c4glbEneyPQU2WpGZuKmozmnNLyujQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=LWKl+UPD; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GNbU8anr; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="LWKl+UPD";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GNbU8anr"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kPrj2184039;
	Thu, 15 Oct 2026 06:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=XO+ndXgAZSj79rPLP32VvcnX096TBs3W7vYvo2Fr0TE=; b=LWKl+UP
	DtpRk68zXCOv7rOOLm/rujUrRAQ8tYbEvNaZbGvwFF0pwOZJay/PDcPqjHZeeR4f
	R/AlapZ5/2jlazLFmF0LVGI6vhohVzRy2YPJujtGjIRSvwoixDov4jZF51YzWf32
	v7NCdInAlRa+f7R3ZPDy43eZfj99WQDDp6K0JRGAjYLOh3s2tunC6H1IDY3QLbXZ
	czJ6IhLkDiLSOctPQa6zB1UK6wmnTyLLcNB4OhDpvedIjWeoxDYIdj2qZ2m7CW04
	z2CxcaJCvjak+ijMdCJ5JQlw8hsUcqQ0WPvP5drFhiCSgCVdGHoM5jv+pxLPktt4
	zM7XWbrcJmjNOMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XO+nd
	XgAZSj79rPLP32VvcnX096TBs3W7vYvo2Fr0TE=; b=GNbU8anrIbMhcpwd2L7yj
	1DvNPGTqGqcJmicwusVZVOTjOkA0nKHLlj4E8RJr9S7VfHqyVhLyduJ0+rneiaU8
	HkmRWRHi1sLEpKdmaSkIIEZOk1YJ+78gzZlPDNMfDc/VwNDhwG6jKYPyqu4fK44E
	Zo8RGHT2K5Q6JoKodqt6u68wYTRsUyTCVCwTeoj5LC9ZBWHdMFsg8Onw6CSdHALL
	8UJlBmU8VTuE6hYFncmXsQPZjtR3PU7PZY+NCawER7tFOpvDW6Ek+iD0IPkE6srB
	S5iNwaVAmC0XYCq6MaAEXNTQe6I02b9bb8X5Nes15CNyBb1Vte+fSbdyE3MBPg1+
	A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hamx4jgr9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 06:19:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB23V9SNKoZzfCihz1zvkzqbrYPSzfSULacm/uR2WNoG3nYRDzTCy0fR8Jk3BNIh+EMD5t05RmocAdk8CquyvISihhjFScJoO+9WB0Q0aO0FRc/eJQ3Z8Ot8rAT4g7edHKcXMHqTXohr2ioLaC+jgyxYN/H/b+ledoKC31gEDf7PNmzMg8GAXAGdXPS4PpagvnWLc5apMhXV8FXw7VUR+19/J3FsgGbdyRODoQur+WXwXoSOlU74xy5sKsXBUylkzdJAoSmpoRbNUBOkRPDTl8O98cjG9DTMtzLxOsxNr80hDzQq6IX4jlu8gLzkJMwDSYqGy0eZAhaSCq7vdX0DVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO+ndXgAZSj79rPLP32VvcnX096TBs3W7vYvo2Fr0TE=;
 b=wBCSJ3de7UpcJtnfDdGcR2DfqMYcXSgIP9N9jhytB5awRaa5jvbUlMbucwOfmB9uwSDP4o26jodey7ZuWkzFBbN8X1XMsTVMim1Yjfo4XWKL6zMK3fzKtJ1WZUVMnPWgvpIp3lTbgVUCnbWPvzl6lv6p1VB88SI/aMNTBixwBqUzygOz4YyTSYC7RKoFqlj1fA8IpH5ArLVuywr8KBjYi9x77rX59uTuBk8oQtOQ8tnwDML1TF5jXC2f+ZyXGjp8NXpQVKVOVmV6pAyKxFcNB8VNJussqQZk5K8Ed7jriR11VlxPqgtvJs0Z8VayYKCvAl81g2SWSeXGsC4NLqQ29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA6PR03MB7663.namprd03.prod.outlook.com (2603:10b6:806:436::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:19:48 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 10:19:46 +0000
Date: Thu, 15 Oct 2026 11:21:07 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, dlechner@baylibre.com,
        andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Message-ID: <atCoXDKG3XNYvP07@nsa>
References: <20260925110239.59320-1-shehryar.amd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925110239.59320-1-shehryar.amd@gmail.com>
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA6PR03MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b374458-f977-4ad6-f92c-08df2aa5d665
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 Rk0EJV/QjUPpNGAcC05i/8wUKRo2aGcdmb1xsogFwEuljAdL1mIFvFqFH9EunbuLKtcY6wVFJ6ZVnlZ+vJaeeWHo/81B7+5PrSwdxkvO1i/tqtMvbw/qlD/ASyE7vZrTya5szyHMESAdq7sYpB8zXISYgGIbUfbbJ45IC+7XLCsrD6pw/CdiSbAaC1FSNG9MfyjcprXCt8RpYeFqZ4/+pgLUXDcl9/jRCAU6+TMBTA2XucCo/t9rpI07qSAxP4GQd7439CLlDREvhIMDSIJG7p5m653ZqZZCPypi6wqqlrgd5UYdsWPNpeChObFHnJ5BnJFGJxrW2GsOCCE/xRjdYMBCGlN6ObhTiip9dEV5W6k3qdgVxBUT6BT4mZYp3zomVpQ/JMwrg6QISsjv6wUn0E/rFD0W7P+U7GJnDOmV1WxmWxZq1h+c2vvNnPrJir2/sblFll5jCo8WW0U6PXH1uFKI81R+Phy16nDZIzbZwvZ8TlaYV0I+oG7LtKODxMB5z+Mp+3l/1NAu0smgq/uATZfDYujCRG5i97GaR77FVxu/C9U4tdpv05edTyfX/OPr6S9qKXes2DtlBeWuPt9FPRWZkCdjaDZbohvn/cIDG3LR5fYI/FI8FIVLZzZZ6dO+
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YnVYb1gxUU1jVU1ELzdNM1Z3Y0N1dmI3RnBYZW90d05nNXBWR2F1RXZNbWxT?=
 =?utf-8?B?MFgwdzRoU0g2bkcyS2RNWndOa1FQTVAzRUY5STdCd0Fncys0RmlMS1M4QkQy?=
 =?utf-8?B?TldkUEFVZWdaUUZ6MWo4T3RTNmIwSERqZUpJK2VBZlMvYTZEajAwWDVHdURp?=
 =?utf-8?B?SFdtbGRSL0VCNm5WUU5jY3RIdEc2Z0ZhNytza2g2ekVScHdrcGVVY2taSW5D?=
 =?utf-8?B?WC9IYTV1ZXptUGNGR1RNSE1PZmp1RjdNNFFra0VzZlZaNDZYaEZHYTBWcFRZ?=
 =?utf-8?B?UzlxeW9mdUl6eHhzTlJ6Nko1NVhGTVgyMDA3NUFVVXAzVE93RE5wK1ZjekVN?=
 =?utf-8?B?OTF1L25CMGR3OWN3REdVMUtad0srNkdiRTBtOUlFcXZKMFBtRy83NFB3NGZt?=
 =?utf-8?B?Ym1zNlRGRjR4dXh3UHNtTVMvTWlmS0liV2RzRW9lQko4L2lYVUNCK2FocnFD?=
 =?utf-8?B?RDVQdGhsQTgwdnVoSitJd2lXazRKcGc1ZGpFSVNVNVNwUVVjaWxBcnk4Rmpz?=
 =?utf-8?B?N0poKzIwUHMwVmQ2cTN0OGREOGh4bnNiYU04VjkxRXBqa0g2UEtLVE4rREpa?=
 =?utf-8?B?RFhaRnYwOTVZKy9rMk1ackp1VGFoNnRZMTFoT1B6K3JKMjJSSWNkL1dKVWhW?=
 =?utf-8?B?a0x0K1czdXArY3NzaUh0WHFMd0k4L3pIMnNHZ28weVdxZjZtcVJtSlFpVVp4?=
 =?utf-8?B?QTZ3VmZFQ3hldEJHdnpGYTE2aStSSEpmVVVBODRwZ2VjSnRsSFZqREZuRkxZ?=
 =?utf-8?B?ODNOYUZDSFF5NUUxd1JKaUNXYTRKVXhtSGRQL0oyYmJUSzFPSjhGbXVZM1RX?=
 =?utf-8?B?ZW55eXFWV1pCVVlMTGRicHRqRXpJZUNnUDM2a3MvUmlVRXYxN2tOL3E3MGRu?=
 =?utf-8?B?T1RFU1JLalhXMXY2SkFrU3dRajAvdjY5elRCMUYwRWQ5UVhrdFZkYnJURkVD?=
 =?utf-8?B?ZVdOMDVvTFRZQml5ZHRFelpMcTBXZVVLTCtUZm04eEozbmE4Yi9pYlNLQ0kw?=
 =?utf-8?B?enY0ZmhhKzZoZUhsR2k3YzZoZG9sTHFSaEpWUnFOVGFET2FTMHNYSkVROFBK?=
 =?utf-8?B?amErcUR0V2dmMTVSODFqL20wYlVDS2xYVFFsK0VRZkp3cU5MSnBTN0gzL1JO?=
 =?utf-8?B?ZVg3WW04OFBkbmhhYTVzZWI2RDl5T20vd28vdnhZdEJsTEoxaTBtZExYSWNS?=
 =?utf-8?B?dTIwSzFna09CajRyQ1Z5VVBvZ3RwY2daakFjNGVnc0M0cGRSRHFYZCtsZVVT?=
 =?utf-8?B?VnR5UTlwazN1a1RjUk9PQlU4TmZic0I4ZW9hdHdsYWtGZHpnVzhYOFhxOU1y?=
 =?utf-8?B?NkEyMU9JdEVxcmVKVmsvQm5waTE5UnVyNDQ0dTdHaFZIMS9aMTYzTFMyeVoz?=
 =?utf-8?B?c3gxNWZnUTdsZGxJbW50NjhPOC9sb0RocVZPTW94VVVMSHVBeGVqVDVkaFdQ?=
 =?utf-8?B?ZlB0b1lQOFJNak5pK3lTK0hQUGpOa1dBYW9CejB3TTBjZU9QR1ZWT3dGTG5i?=
 =?utf-8?B?bXBqTTJudFpRWmFQcWIvcHpBT0JPenhvcWdVYW12WlZjUEtiaEh5cWhNTHVK?=
 =?utf-8?B?d0dUVFhuNFVkT0FPY0V5d3hFajRuQWY4TlJLSVBHQ1p1MUhVd2Nxd2VEZ3J0?=
 =?utf-8?B?Z1VjUEIzQmsvalpLckV4YjVBYkg0QkFzTWIwK1JkcFhwV09QUmRwU0M5Qk56?=
 =?utf-8?B?NXVpRjRxNXJLVS96ZDZuUUZjL1V2WnVBV05CSzhTQ1g3bGxuakVNTE5iSU95?=
 =?utf-8?B?NUJ0YjJoVzBjNm1kNGR0dFl2czVhampZR3Y4SU0zSU9yWlZZTVhWazVwUzFK?=
 =?utf-8?B?SXZEbWxrTloxUGdLcnFlVHZZYnJQcVphNy9oNkRHSHJFVkFrbjVoaVpYeDJ4?=
 =?utf-8?B?MjZoUi9rYkZmaTJtVmVFREJrQ3hBV01Nbi9icGt4anE1Y0JhV09Jb2s0SjNk?=
 =?utf-8?B?TTNHWnhqTG9OUmxRUlVjaTFhOEo1My9RaGRvODhRL0Y2d0RRUEU3VWFQUWtH?=
 =?utf-8?B?N29ucWdZOFRPMkM5R2t1UlRZZE4zRGY1RndUc2JhTlRUbnFlUW9VemtkcWdI?=
 =?utf-8?B?T1ZGNWRiYlJQdW03NHJXbXJxVGVtYjdHYVVWcm1zZ1VzemYra3R1ckl0SFI5?=
 =?utf-8?B?cGliNEFRaHcvRk5nZC9MS2tKWUF2ai8yZHE0TG5ERitCSzJHdW1GOWR0NVFu?=
 =?utf-8?B?UGZWZE5pc3hreTBqbUs2NjFiQVdTL1NiTFBPci94SnF0d283YzZqaVNZUDlH?=
 =?utf-8?B?b2xzMkFkeTYxWGl5YnBNQ21ld2hSSk52VTJldWh0K2UrQjlVTGhrbFJxUkFI?=
 =?utf-8?B?QkFzNWFRR2QrM3cxZVpha0VNNXVBN1g5eVlOVU1UR2dYQVhsZXNkUT09?=
X-Exchange-RoutingPolicyChecked:
	po15FPZ1M4ygSTA4bzeYeIm4YGHQZQVnU6FgsTrtD95ZAS6RuYJbz4SDJ5wpOQUkQKdrkmjHUmNKhJQkP/1gAhzTU6+Hv4UgB5VqakoyqnGHnL/WiZf2XqdQXmMODlx1a1oLBMY89DCGd0Gud+KKxw68uTrmgnVRiEId6v4zKlOsXuxHxttbO3lHEWeYnlD5uSJoKNhC/cEYyYpPsnqAvG2a8LeJF7O3a5T3NLHqNqXw9xOGZaTuj+7cddOb+17zBf3mwRjo8Muetl5aMcJm4yp7jpSEOOYdwrIDMNQazGaxeOlqPJos+dH8WmM/nCB13fJ/lIJ7pSaJx3NdWTl/7A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b374458-f977-4ad6-f92c-08df2aa5d665
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:19:46.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKnj3D/7YcMx1xGKM8rVId2TL/e3OwLcLwYy5KiKxMs73ui8C1pCZkxcv9msObBWPBTCdQbTKMh+bXURacD38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7663
X-Proofpoint-GUID: eqSedFBZkx23fR0eQRHUriAc5aG5rkEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX8EpBhtaBPq8R
 LRtHjUGmpRDdU/Of2pCg1AtR7Oqkk3nkXSzW3I35tXKXUtTHBPMiPpxpM0kJ6gTOa0E66cJ/qbQ
 6iB+4IqJuWNozYzcJqoBpnrXBrcyBDfY7RpGH99UB9e7U0Y8aWYCds15nojV05dwRogwK39i/up
 uplAoh9S9cY6Zi95YCFUZtKW3gt2/W9F1Pl0k/PDc6WPfkSEm//3ahwP6HPwpccIitSF07v8GcO
 Yb6+rrqwRc8VTj2vBQWWNH07W/LusjEfQP8Lk4risdYWTOAYaM+6cqLk7s0rIqDWju/vOCpp/Qz
 zu/Jq7bh4pWBB4cqjs5b583YdMIDD26qrebswe5WIygtbU3J3IaBf7lMUW/AqKubPfhDGB0snVk
 iRMqjxpNnaulqBD28QTDkC90wETDDtetxeOSp8KaMy39Vi757CLkaT8ss4CRST2QPDKLmNbMeyb
 wutjco3/NP56/RyIWXg==
X-Authority-Analysis: v=2.4 cv=Mf75KJ/f c=1 sm=1 tr=0 ts=6ad0a8c8 cx=c_pps
 a=VUNJaWZlx74G+l0QYBOIDQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=vf5BM6hEjHz_lw7nHawA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eqSedFBZkx23fR0eQRHUriAc5aG5rkEa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX4l5uhcpg4SSK
 RpeqaUKME29n3/GFInddAQnkJGn+GZaTmnIFbT5TZmgPFPtIPS7eUfjX74zq6E4PZSzL6Ex4bF1
 ZikVaeifoFeZLseABE0g3n9q9RgklLniul0bWfTNpDVt6qAtDgpo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150040

On Fri, Sep 25, 2026 at 04:02:39PM +0500, Shehryar Ahmad wrote:
> Hi Jonathan,
> 
> After issue raised by Sashiko in adis16203 graduation series [1], looking at
> other drivers if they might have same issue. It appears that the root
> cause is in adis_buffer.c itself. The library constructs the SPI
> transaction in channel array order while IIO core demultiplexes in
> scan_index order.
> 
> adis16209 and adis16260 have the same mismatched ordering that
> adis16201/16203 had.
> 
> Rather than reordering channel arrays in affected driver,
> would it be sensible to make adis_update_scan_mode() iterate
> in scan_index order instead of channel array order?
> 
> Would this be the right approach, or is there something I'm missing?
> 
> [1]: https://lore.kernel.org/all/20260914015321.7a660ab5@jic23-hlaptop/
> 
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 501da4eae..45200b753 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -110,10 +110,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
>  		spi_message_add_tail(&adis->xfer[j], &adis->msg);
>  	}
>  
> -	chan = indio_dev->channels;
> -	for (i = 0; i < indio_dev->num_channels; i++, chan++) {
> -		if (!test_bit(chan->scan_index, scan_mask))
> -			continue;
> +	for_each_set_bit(i, scan_mask, iio_get_masklength(indio_dev)) {

I guess it can be iio_for_each_active_channel()

- Nuno Sá

> +		chan = iio_find_channel_from_si(indio_dev, i);
> +		if (!chan)
> +			return -EINVAL;
>  		if (chan->scan_type.storagebits == 32)
>  			*tx++ = cpu_to_be16((chan->address + 2) << 8);
>  		*tx++ = cpu_to_be16(chan->address << 8);
> -- 
> 2.55.0
> 
