Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD03EA97A;
	Tue, 13 Oct 2026 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885054; cv=fail; b=HT1JixUMJNwP4StWoXd78YO9JeGAqyp2rPv1TBGW+uF07/wK51BGXlzeKr6AVL2PSzG0sK0sjkEQPXeeVxMz0dp5YPk7uxxmwKxvGFMDiO89NN5N4jNTfcm5qB+T26WJHateI3kJsc4WdzE1PlFMUynRlx/T8RsGtbK/L2mDtyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885054; c=relaxed/simple;
	bh=xrs5i0EwM+2dR9viK8AwDroeUmj/vArYCIzQ3hsHJdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JsCNR45xITZb+XqI/GcC+eH3YWx42SFFuobCoFvhhwDl6T10uNxAPWkyYj6aO8igiqvbvgHXiyRg4zmE+YkxpeUKEc22cHrKtIUKibu0ufovTQ5IHFDal6+zQwxLiN/MQYHJ6zXq7WcTx9GVfd9gi9wTLOkshoTXkULSMuqIuSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=euJyqUmv; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jqsXg5E5; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="euJyqUmv";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jqsXg5E5"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8wCgR371506;
	Tue, 13 Oct 2026 05:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=gqosK9Sk5Ipk4op/Xbv+Z9VPwBuWiDu+zIoVhPoROgA=; b=euJyqUm
	v2vtxUV4VUDczAZLkxuStGGlOS3WDG/tghdw1sdYAUSQ741KOjs74tCYj2CQkdsE
	XM6f2ymUWemtEmjKfNfp7boGF8eBwOyLWpYjp+NXKDtdfMl5wejikun1KYNysv69
	Cjqh4j+Kk88hM7MhbeD/gh7SjW5nMc2bkGAaewVKGe0BCx/6X1m9AXfn2LVuiFG+
	1+dSluXRxWdGnjufa12if43ipVRaqiZ18gPQmJaeM4lx616Bi7t9fjPTucq4r515
	mpw2LOk8Js397DL26u9BLErst6vJIjP55xwtS8lHxuKj6BxfyHRsJgf5PV71v4J4
	iz6FSpk+vOg7U6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gqosK
	9Sk5Ipk4op/Xbv+Z9VPwBuWiDu+zIoVhPoROgA=; b=jqsXg5E5GN48oSXxOcyBx
	zI1qz2EnrqI0PqmHRsYKFrzPzKpb/n+MIMwDQzdqqVk9a6RBAhGgDsa6u0Q7C3vK
	RmQjGUmHTirN1iWcH1v8pb/9ijZsS5238eIkaG4lrJPHqUlrc15Ho5VUvJomb4C/
	zkhtJIvYTTt/SmH+8yvmncmTIRkURGayejWw8fZpFpcsh7bPezespSYHOaiJPRuM
	QHuWmk4tGyLOOd6PEgqHbQlTwGDA7LRYTNpGQ0LI1zL/6lHvCcpEP9KT9VN8iVtp
	0tKLQIC6bsLgwUHhQg4+pZzCznA+MxXKguW9OcU1pGkFGZS3LQUTaSpmmxftwkwb
	w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h95uwkvv4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 05:50:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS5zUDGD+deRBP99pwRgKxY/1h4agX7S30c0BrtwvA3NyWoBd+o2xwEIbuoe13cJViXsYvnplkdOIIxf2Io6u/eqzRRDq6jpisX7yZDN/vwyf4ixZQF1x46R5tvAUC40iwyDDEeoEgfzi5Z2MH0KM+nGveggaBtFSC4b+k7IuceOqqaS44WamAK6fmhh7Ryplfyl2oprXR/d4tc3vj7feKeLUHfZysbDEaGyZ2hKASVlqatsuCDxCtfUOpkF/wmmt9nTCAeAKyMNTcuAdGx8ypYlg0vKCGvxqoCnZxtCCUvmZVNqR91eVsv2+hFnJQUhahGCKLyO9UAyW32OiQVjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqosK9Sk5Ipk4op/Xbv+Z9VPwBuWiDu+zIoVhPoROgA=;
 b=Kky5sdUK9MWPZ8H+GoW3ZJ9J+80bYhTIUN/iLevQ3a4FSjdtj5wZQ3kLmBCRO9aCPqboLEa1yxfZWteOe5jQvz803C+j4z6CI0AM4XJOBIUXzBgthvMpoDfKVtKzLbd+0xujxMMPup3qzWiPkRvHfFIMV81HES01xSu3DfFV9eP1AXNIC6bjmZQETQ3TbIa6xEU1Ax9u3I4zxIy4aqYxCNMURlk+d2J83iDe/40E037/0veYwn8wTapBjqDEG/fLXi7sMPRy8omLXF4isZ8KIcEjwobUJymetwkoNaT30s0ydY6J43aS2eh3rjnuIZ3x1kTzN0fxSca0f53YfiMgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 09:50:33 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 09:50:33 +0000
Date: Tue, 13 Oct 2026 10:51:55 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: adc: ade9000: add support for ADE9039
Message-ID: <as3-vbbd2FKdMzP0@nsa>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012111342.48040-1-antoniu.miclaus@analog.com>
X-ClientProxiedBy: MA3P292CA0064.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::16) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|LV8PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbd88a5-469b-4c22-c609-08df290f6cab
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 NeFGjUlyzpCXJfQVYHyjHbaoAhQrmOxBxEDrS+i3nle0BtsSHBva+4CXHze/cAKhhqFb7W09Z9tEFjtaMs9ODjxP7sGdnkJ2Wy/jfsCE+2nHGLMm8GKSS/EtNz+ksOdTbdUc2eXtRzeuTr7Tnp1QiR182uXxPdjYhhL1uP8KHuQI/J3XvZ65OoUjOFfCVl6HTxzw5MTe+le+z+T/QBhFfsiLZRl3WzZeHOFLjIFG4uY+ndxydGAHU+w5mchenqkHZ37SaUWnNkVb1dg68V2wb2D6jnhEqqiNQ1qeXdttvxA2+JgzCu+aV6WmHN/o0Fjdo0WwGQMAiWS6WC71yTYY70vhhoM9OIDtg+z77oScIVuXQfOoFF5PPSZl5QxYQG5D5Fus9buczcZOjwxaERgv48Ttwoq4FQOlyY//OaaXgTWtAQ5DhABltU1dzWnil7saJxIXYCCt+RK52Ug1cD/5WKOi2MXWqAyvxAxEm5EUYbWM7lowqjIDcF+seDypRl2U8cqIkm7Wpw2xqKEdrP8FQRVmOCYkPK5w9qjv9B7tCnZXpKweCY/VponuvbpTXGnJ00tP0YBsXzPfXpyszJRRBq/lsegkB5SGUcDASm86QMgfdNo3pFzGMueI8j+DUa0ZRgNjtHgf9uRINwG/T615pqkTX5FXPA0tFfkCtwCBwtE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UHRMcWh3bFhxYk9tb1V6c0VkSEFnOXQwNm9HT29iVjM4UjNZc3VsM1MxclFw?=
 =?utf-8?B?d1V6a2hNQ29USnpoY09rYWNlSExqS1hFeUZkbGZsNkFxeWRZUkRpZXFGak1p?=
 =?utf-8?B?ZGp4ODlkQXFjRU96cnYrNzJUUVZmN2greTNabENOcTVrQy83VGZBQ2htZGNY?=
 =?utf-8?B?TEhMK3ArZFFBZGJQRlRsaGdySG1jd3lIajhPcExnWHp2eGhaajlPTjdYZjM2?=
 =?utf-8?B?WStreXN0ajJWY2ZBL2pUbnppZXl5aVJoNC9kTUEza2lnU2x5N2pvd0Rya0tZ?=
 =?utf-8?B?bVhLY3pGVEFHeUtRSFlXbjVTN041NUNpR1RtZmduMFQwL0VBaW5SL3BIRU5m?=
 =?utf-8?B?dXhSM2JMRHF2QTNWOHF0SkpHeFg0MUZCUzBodnpEQVZ2YTdMb0d5d0NFOSs1?=
 =?utf-8?B?RVMrbm5KMjByWExDbjRva1pwdER2OWtGVVNYanNIRW9Qakl5dkpocUkzcU9M?=
 =?utf-8?B?bll3MG5GZEJrMm9JKzlhdmdUakhGVk16MTN3VGs4WjF3ZGl4UjFJUmdDUFVr?=
 =?utf-8?B?QjFxTjVhOFlvdktpRk5aUTZwcjRsa2YrN2Q1dzN3S3JVY2czRHZDZGdRM2Rh?=
 =?utf-8?B?NFhmNHYyYVBzOTRyb3lkaDJkTDhxTEhndmlOV0JIYzB1YVRZRGR6S1I5N1Jq?=
 =?utf-8?B?c2U1QmhXeDFnS2ZPTFd2OUkrVEJHOFVYcVZqUUpyY1dEVWovLzFRVnJNalRZ?=
 =?utf-8?B?L0UxcFFpRmVMbUJuTjRaanBOc1o4QUhzZ2FNTEVWR252TjdiRjJtSFdvYVVw?=
 =?utf-8?B?Q2dLL3cvbEU4d1M3bFR1UHNyNkFsSXZvbG1iVHN2bXB5WS9rdTZuV2FZcHNU?=
 =?utf-8?B?dXF2MFc3UVJMMnA1QUZaNHRkV1MvcmxjMEgwNzNWRUptUnpQRmlWSlpMQ2xy?=
 =?utf-8?B?eXg1YjI2ZFNERGxIU0d3aThCckxHNld6anYxOFpMdHNOUjJlWHE0N29hczhQ?=
 =?utf-8?B?ak5wa0kvb2R2ekFvdjgvT1hENndLeVdwMWhBVzB2OU9tNG9neTBTSmlyN2Fq?=
 =?utf-8?B?cGxzN0Q1UWZTaHNlaTFGdDZPcnFoTENVNVRQV1ZVK1V3M2JkWmJJVDRrK2tY?=
 =?utf-8?B?bmJJajRNRTlvUlRGT3c0Mk0yYUJJaERwbU50V3ZneTMrWHFybXlkeGd4WUV2?=
 =?utf-8?B?Y3NzemphbTd4N0FWUWppcGNCNTBYblBVZXg4cDNXOVN5K3Vldi9BdHlNZldN?=
 =?utf-8?B?bGFMa1BDbjZmczV0bXBBbi9SVTI3Qms1Vm1yMDNQQzhYR05ySWluWjZDdTdu?=
 =?utf-8?B?VkVqSC9zSUZlUVJjTHQxRGxMVXBFQW4wWUNDYWZkNHhUV3F5RmZlbEJ2TElS?=
 =?utf-8?B?UEtPMnJaK1lFUmFuYmhzNy9CRCs3cHJsYjNNUnI0RjdzYXhKd0Vpb1ZLblJW?=
 =?utf-8?B?NWtkOWZoZ3MrS1huTUUvUzZrY3ZTNEw5dEgrNUVxcFRDZHhhNE1SRHluUi9p?=
 =?utf-8?B?dE1OU0xZZXpRZ3k2OGEyZW05TlpWMFVabmJYMEtBczFMTkJ6NlpnWTRFWS9s?=
 =?utf-8?B?QTI2SlQxNzh1dFhEQTh4SmxOdVMwVjZLS0txWU52bE1rdTJ0MGg5TDRyU1k4?=
 =?utf-8?B?QlcyTjUyL2kwWW1QajZ3KzZiZVpNcjJWMDE5akdkcDJFRlB2OTU1N2pBUG5Q?=
 =?utf-8?B?VkZrNEloem5LYnBZTjEvSGx0Nzdod1hQWjFTQ1RSQUd2NjFKRy8rY3dCM3JZ?=
 =?utf-8?B?c1A1cFBlU2tHZWhpR3pSOHRIRTJEU0k1Ti8wL0NKSWVxbDJYQlNpaS84QS9o?=
 =?utf-8?B?QWMyTkhtV1A1ZmdKSkhGNk5jOEFkcHUxTXNlbG8xcENCaWR2emNaUURkY0pQ?=
 =?utf-8?B?MENCOGdUMytPNTdsRElPRmQ3eXo2NXNPU2RNblA4Y3B2OEp3bFp1TGFoc1BL?=
 =?utf-8?B?Sjl1R2RCd1BkK0owMVQ3ZEJUQTFHTHRrVXVkVDlleTF4YmJPLys4ZWRBNGdZ?=
 =?utf-8?B?SDFhNUtucTBVOWpQdHRQUWFUdWJnNmhrNmVRd1IxcmJGWkNOcUx4Z3U5WWt5?=
 =?utf-8?B?ODVwOUZwSURjdFFWM3dvdDV1eENDc0xYV09DcTd5bTRDWXNwNXFGZU1LK0ZE?=
 =?utf-8?B?cDBjalRMWVIyanhoY01BYUxVWER2eDFuSGNhSDdJUXlvblJ5UHRCM3hwU1Rx?=
 =?utf-8?B?bE8vT1Y0V3ZGUjRFSkdraUFNVDJzUzN1QVdDZnlXZHNTdTRLVWdQSHoyVGtw?=
 =?utf-8?B?bXZtVDVXbkRCTG84QVJrME53SmNsQ2pnQzlrMVNJM2NJUTFpdzdkVkExNFp3?=
 =?utf-8?B?TjN1WW16QnJPVjdabUpYM09IVWY3eThURzM2RFQrQ0hYTmFWWk5NTDE0TFVy?=
 =?utf-8?B?N3lQT1NhWDZ6eGFRTGhDWG5pNGZnZjFqVXB0T3lMQkVaRzIwekp6dz09?=
X-Exchange-RoutingPolicyChecked:
	V3hWXKavYmmGspjIqzTjSfDurECK6fze1bLFF8TPW+BqcQ3sqmaaKHWCcQtC62gQ9+dt/f7hoeBuY+qFt1qLgX/o4J0negQ5ZypuXTJvkcjmS8O19laMpGYZRtfE14YKzuEodqmpTo4N0bzY/3qyFsddKrEXuIXFSe7ERUhcios+0QmjfMaU5EBPVfFlR7Mwhcrj963GknLIguaoMOgx9xS0o8dBywuge4/pLZ4tbW5fIRoKsK91NPvuaQPoVNPHGLhhD8P+ZNi+Go0IWFlV0YHZkYNvQjgAfE1XGocLrJADjxzXPluEvuvRs9ppP3IYfuWPl3+/lbthBnDKAOuOvA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbd88a5-469b-4c22-c609-08df290f6cab
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:50:33.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zwfLEvAWusnjVIlSCLXUg1+reCt1bOSHti86ruEkZoTWv2zD8dFoqVXaYVOGPNIp3pHmA+gzXbcRLjMhOsOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
X-Proofpoint-GUID: OzMWrevUZnbrZ7mFOS1q84czjj1tmO7f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOCBTYWx0ZWRfX1hOhVgRTVPi9
 V+39zmpcsXXGcUguPtew50BuuxD/ap2Wtk1go0JGAqBfCqtWaLODhvOsUFGVAV5tQiwe6+PqaMP
 XQFSNKl19+XoYLj6RGrFT3tKyUoh0n8ZDzFZkLkPIZB/h2s2MpqY
X-Authority-Analysis: v=2.4 cv=ZPxCCn7b c=1 sm=1 tr=0 ts=6acdfeed cx=c_pps
 a=4d7Nl6fXTlayLABBLko2Iw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=zfN6dG8wn1Vqx3tpmBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OzMWrevUZnbrZ7mFOS1q84czjj1tmO7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOCBTYWx0ZWRfX9IwFSKTh6eO/
 t7rj8MaiA4keZc/1dFw17wLsiM6HVqsOsKd6VXJkHc9wC1ZfQnze45D20HagFRou25l3rpIbYrv
 cG5QR0a50hy88iakY9uvDf0ldgxsl2Ck14Ljm3zG6f+dG59/aRJLdnWJHcJBQUPWG8FCxXu6ikA
 sw5hb5T/AUdoQI9ZExP/PLGd7Dv9piY5EyjLyJOBYG8QsX/DV18kxpVL93JdjxICjrGvt2PEhP0
 rPmRfr9/yjDR0VMcXig+QWvETIm2YHu4ujgsOIEOUGidoCeC8eBKnE/H99Fv4rOqw1IgtvYglqj
 sUM23UvdmqOctjyikI3TkzHO5Lu7kzDfyaSM1hVVrCjTJ73ScvNCEXR0frrFBh9xCT4kuwGzpf0
 zZ88UiehqNUNzAPMrzKaivmN/GRCn0FVT4Levh5GlY+7DsEf6KDVoKYVh7fHUkv/2ORXrE2PHLC
 FgHTxvb0fYAuGxuphVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130038

On Mon, Oct 12, 2026 at 02:13:36PM +0300, Antoniu Miclaus wrote:
> Add support for the ADE9039, a polyphase energy monitoring device in the
> ADE9000 family. It is register compatible with the ADE9000 for every
> register the driver touches. The differences that matter here are:
> 
>  - full-scale codes match the ADE9078, not the ADE9000;
>  - dip/swell detection and the digital integrator are both present;
>  - there is no total reactive power: no AVAR at 0x211, no AVAROS at
>    0x010, only the fundamental AFVAR and AFVAROS;
>  - maximum SPI clock is 10 MHz, as on the ADE9078.
> 
> It is the first part needing dip/swell present together with total
> reactive power absent, which the channel-array macro could not express.
> Patch 1 adds a second selector argument for the reactive power entry; it
> is a no-op for the existing parts, with the preprocessed ade9000_channels
> and ade9078_channels tables byte identical before and after.
> 
> The missing total reactive power channel is omitted rather than
> repointed at AFVAR, which would make in_power[0-2]_reactive_raw mean
> total power on the ADE9000 and fundamental power on the ADE9039 with no
> IIO modifier to tell them apart. The fundamental reactive energy
> channels are unaffected.
> 
> Patch 4 also clears three stray characters left in the ade9000.rst
> introduction by the ADE9430 merge resolution. Happy to split that out.
> 
> Antoniu Miclaus (4):
>   iio: adc: ade9000: parameterise the reactive power channel
>   dt-bindings: iio: adc: adi,ade9000: add adi,ade9039 compatible
>   iio: adc: ade9000: add support for ADE9039
>   docs: iio: ade9000: document ADE9039 support
> 
>  .../bindings/iio/adc/adi,ade9000.yaml         | 29 ++++++++------
>  Documentation/iio/ade9000.rst                 | 24 +++++++-----
>  drivers/iio/adc/Kconfig                       |  1 +
>  drivers/iio/adc/ade9000.c                     | 39 ++++++++++++++++---
>  4 files changed, 66 insertions(+), 27 deletions(-)
> 
> 
> base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> -- 
> 2.43.0
> 

Don't love the power_reactive handling in terms of readability but
fine...

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

