Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9446EC79;
	Fri, 16 Oct 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142520; cv=fail; b=ofefxRSGTHf2pwvzyTd9tFBe2JdXLF92nM3yreJAHBBStq46e2gk06xRORIcHeXOD3wdRZ3AJSQuxF3KgYPAUmdKdGTrpSGGBQDJhSFDx7z6Oe5+BeKBFPu9C0MZDYR8VTU/nHK/jJCglce8IRGe+m75LNbUF0H1z16RTfv5qzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142520; c=relaxed/simple;
	bh=KDuNhCUtfaxmu0rLDLQn21rvt/r+xTfu/16p1Kx1yrc=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Vc6YRZldNMEqa4odDVtjR+vnb7CzD8K5dzvaeyNVzLVNoJQ2i5txjMbEKSWC+gWtj82+dwc46SkSjcr3EEMHAgpGmWASnMu+3h3UgzzI5IAimifSrkgo4vfB7Q2czlXhPhSDJo5a49gzMgdan3nRH/TP+pQaFTviYq+7EsUtV8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=s3AJf/wr; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yhilu8LJ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="s3AJf/wr";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yhilu8LJ"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G80TZn3639241;
	Fri, 16 Oct 2026 05:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=jlHLrLLkRQLUaMsNdmq0JbK3xWMKyJTOtvvCOcHXXEE=; b=s3AJf/w
	rTQBD+JVKJc0q2EsJNmITfC7yKYoW7EZNCb5wvPaoaDp/UxgLbGGLInhGBJWcWXI
	s5MivwhCl5CXaQfzc19wNIsjZy/BX3g32eACKpGql6b6O3JrG4CgH3y0KfR4AeHL
	NtLFlVLpT7rz9w59pi1bBniqTddqKPpTCBsMVQIJe8cM0jIAkuLAUMrQG6k3dJm3
	0nWmaA8AP7HX0nsHk46iKbTJm5hW9KeI9sQ85NJ9DkFzsH376+a9XbFAG9Pnux8N
	SZ/97cRpdnZnm2Gy3YfiRCTqOvdpXjr+6vF13R958Qbke86T/78qLuaTYkcesVPI
	GLDHb7q4RIdmvaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jlHLr
	LLkRQLUaMsNdmq0JbK3xWMKyJTOtvvCOcHXXEE=; b=yhilu8LJcsj245tuGWvth
	bK5OzL5PF27QpngTawhHy59BTPX7uK6SWJbU0cE+zplVBNBtSGKpojRtss2198Uk
	IbXDObNPmRxtoXBDbE9CNnyySCJeA/c5oktlkoGYkxHBh/dAtu38tTOwG4tvZxFi
	E/eBjhpZjMYN16bHd0N3QDQ6OtG1rvox7Gn7R4CV8gb8B5lJUe0YMS4ah7l/4crg
	NsVl0fdW18jpZ8A2jtUXI4ZEBj7U0UA6cCRszpWu26pLugqgdt4S/WFdb4wA0443
	+Sq6g+HXEny7T3xv1TGQncZjctt4/xbpTHNOjOia2Gh6BKLAFjHrvd0F4DmepTN5
	A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hbajk24cd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 05:21:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAl1K9B4/4TIcGWdDyRRHD079zs1wiwk0VmWjcVfovqCGG24KST4Kui6loLFX6cqhOMcBEbgipIyPFOPEDW4+BFR2Pa3ryDhxQk7JDytJNKAvtVgASEZ6ToC1nXYgiSH2z+f400CmF+x2w2iAnSdQ/28ooDCG+UPUFtUFXx2cjsFz8Ogn+WwxfgzFYCKS994Y6WZvE8ObpJ6sIo6eQwILZYwtHeS65rZX0/OFXnsGUac4TuuutxMOQzhWxmu7BHis/iq0iI802k8HUyHnOf7ev7w6XW58wcF+iJxnOQ5GVX1lLdOvm1oj8YI5FFnhvFBbTPNNcWJmrtgDWoG132UXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlHLrLLkRQLUaMsNdmq0JbK3xWMKyJTOtvvCOcHXXEE=;
 b=iZZjXRYhaj7cU34HDN9HQwDpNuKJ+IVbn1TRScTlOb429p8r2cJjr1eYIC2nbJ7eW1xiYwXC2uIQLUnTmzTs7LDKzyVD+oHY4tvWMZpc13A+xAND8ZQdEyW5TbfU23I3E96tGIWUYpXh7n1kKTCl3UyPlusw/4NQqY6DYczyXIDTIS6nUGZLXxfVWVpRxdw5bUrn6DXOg7fPxym0ux6SPls+4e19XcZViSL7KtmpySge8r5EFMhAp22GmsxmGiEWuAgZ+hOD53zI5zZjJczcU9r1Qyd1S3X4v6TP5nUp2vzHRIT4IwqKouwLu9znx+fFgo/lYe/jZiAVWjQheL/GCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB8138.namprd03.prod.outlook.com (2603:10b6:408:296::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:21:44 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:21:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 09/10] iio: ABI: add integration_time for output
 channels
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261015-ad9910-backend-support-v1-9-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-9-3c21648c8e26@analog.com>
Date: Fri, 16 Oct 2026 10:22:35 +0100
Message-Id: <179214255505.3322.16323794686488802474.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792142556; l=689;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KDuNhCUtfaxmu0rLDLQn21rvt/r+xTfu/16p1Kx1yrc=;
 b=i2mIIQLIFVTqdKvOUhKwCAZTte9w7W6uSWrhyg3WO1LvTnplnHrGTgWXQUyO0ENaq/Irfi7fZ
 ytG99vafUCgDrESPORyPRilMQ2p/3Gm5bOM4P/X+ktEpPS1OigVRAUV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR0P278CA0065.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f9f3ff-3346-42da-f846-08df2b66e4ef
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 OI2B2PDEvGJVzYCmPM5AjgIGN5+hnku/vrqcgPZqy8ldYFb74VGaf3zaq1XXKbgDcDWHjn+4hAfrFfLQtHlBXuGshCgVyJtf+coK6hNqy9d3U+PLeWTQHKoQQb4FbFYwoFTpFtt5Z9LWGdIJdF7Bt6dwjcH60f2Al4Dtz6P8PPHV1XwonHKKcPnsfSBYt6zOVZVE1UuO4msGPewnvz8Xeaj0wohfhWfa+WcXANo4VskjTPS9o+u6WCeH63i4wybRsSz9357gdBlp50smvDaS021xQ/Bf/hVT2Bg23xz03aU0Xa5VW0oHRFE9y7Vvyf4FO8x/9FUn5O8Ks4z460LoUfGxBlVRADe2LNpQoMeZpNz+R79mQiz6rvJppyH7CEl9+pdIbdyD/dVPGhgUhsWJPXNBlPSiaU+9ghb1pzJtzyaJSfnmMMkOeK905X0SMBcsmLNazatkTCjpDLNVx4+foBBzrvCEXs9U+O/syM9LxpViV2KyF9EdUMt/qgw5iYvHphTy8ZQYMK3LGYEtSf+lXXuO/JTgQJVaF6Poq0sP5i+rieftWckn5QWmX5aHcjynuM7D5lhOPc0A1a6WNQ1jyHROt7iZY+5rWOejWWKdO/ZBznlHQFiB1Ao5XyzDxnVGGYC6QtibrVteNDVEZJ8njUF/p3eMZI/7l/nvUtfdWo8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YlF6ODA3NC9sYUZMTTc4MW54T1BXSDFRM09zUWxDMDljME5iWnNxZzNveFZF?=
 =?utf-8?B?bkd0bS9KMnRIYTczelc5bDNBME50VEU1b2RhVVNseGNyQTM5LzBySU1VZzd0?=
 =?utf-8?B?WjlxdVNVYVEvQjdwSnRvdHV6cTZ0ODNHTlViR2lHaTYva0RUajZIbS9LQ0d6?=
 =?utf-8?B?QVNYNjFnMXo0NzgrOXdVL29XR3pDa1ZwUmVnSzAxOEtpcVBoSWt1QnNyaGtX?=
 =?utf-8?B?VERWV1NUY0ZpM25MZm4xQjJMeGVVcmJ0NjhOTmhuWXkxZHMwSGZBWURKa2FF?=
 =?utf-8?B?b0dQUTVEN2tQbW80TmRlbEVWT01ONU5jWmhkMEZCQ21TVytEOXRiSkRpei9I?=
 =?utf-8?B?RTUvVXMzaUhIeXBiRUtWVXR5dW1udlQ0dmlubWF5TWViQlVYZHhLQWI1ZytH?=
 =?utf-8?B?SE1BNlo4d0NqMlRPa2xmMXJGYndMdld6YUs4Nmp0cGhrWUpxWTFwMlcvdkxr?=
 =?utf-8?B?ZVdWUTJkbGV4MWpyQmhoV1ZudXRkQXMxM3dSUjNtc0xrUGlFT1RkMlRTWVMz?=
 =?utf-8?B?UGM0eC9paTF4UWExeEpqd1cyRUxhbHJkU0d4WTE5U2FkdkRBT0dMOCtuRFNW?=
 =?utf-8?B?ZkRYQm5Cb2tJTWpCeHllWWNGZDNCQ3hzQUgvL3lOMzNxSU9LNXM3Q1FLNlZ1?=
 =?utf-8?B?U3NiN0lPK29RZVpDMWU1K29xanc4QWhDNVpJSEViU1QrelFBOE9vc2Q0U0J5?=
 =?utf-8?B?VWVXelduSEZ1ODVFT29pM1Y0ZVlWN3NtT0xvQzFxWDlqK1IyTytCTEZSUmhT?=
 =?utf-8?B?UzhTL2Y2anVFNDFncDJXRUF0SkVXU0Y3T1VEMXdvR0ZRaDAwWlZLeFZUY0Vt?=
 =?utf-8?B?amdVVm1YMG96VDdsL2dmR3ZTZzRVS0V5eXVEcFNRR0RzRUQ0OWRwUjJ1cGtu?=
 =?utf-8?B?ZWRYeVNWSGNmbUFRQUx0eTY1bzVPTjJZcUVLdHdSMktlcTUyNUdNdzBSSVJG?=
 =?utf-8?B?Mzh6b05LNXp2OVBwQkxHMGZaRllHVS9aVU9va0RlazZCOEVCOS8zd3M3WVIy?=
 =?utf-8?B?UW5zeDVsaVRTMk1nU2ZzQXU0RkhJTkNnK1BXOEQrWnJtbzdrWnpVekUvam1a?=
 =?utf-8?B?eW1Uem5GaTVkYmJESHprazV5dTc1aHhlbFJqTG9QWThBMXpHL0JoWm1HNHY1?=
 =?utf-8?B?TWlUUUQ2ZkoydUxlWHp3TTNRblhVczJRNmV2Y1Z2L05JU2kyMDFwSEFsanRp?=
 =?utf-8?B?OXc3OWwxeU5rVTRSOHVBSXVmK0ZiQWw4WkZtcDBLeGpKVFliMVU1ckJ6Q0lx?=
 =?utf-8?B?MWcrU3hldGYxRjlkdm10UEgrQW5tSXk1VGNQTi9WdVl3YlkyZkRMcVIyMFVX?=
 =?utf-8?B?bnBDbGUxQUFmRENwczBJaE4yTTZxU1NBc1AwMDB5bmF3QWNVNG1XWkFVcTdV?=
 =?utf-8?B?eDZybW04U2p1ZXgrbkZYYi9jTk93WUl2TTluSERoZmpiNHB5ZGpRSThsZHFQ?=
 =?utf-8?B?RlpQa1d6YXh4dDRBZnlGS2lrUlBzb2p3UUtiWjJLbjhKMEw4VE9xTkM3MzNp?=
 =?utf-8?B?UmY4VlVvMEhwZi9ITlRRbmVTNlhLUDlTT0FyOGYrMnY0bjFiRWkxWXQ3Y2c0?=
 =?utf-8?B?Y0l1VHdtTW0za0RFdmNPcllIc1UzNzdDZHh2MDFvSk8reEpBMC94cW5WWjJK?=
 =?utf-8?B?MWdHRmpLWkVhNDh6WGRwTmVFTWI2VHA3eEdCZ2RTMk8rcXFSZVV5OWIrVEVP?=
 =?utf-8?B?b1Z0OVF4SndabzZQVVAvVXdTeHhoYXVjeUM0R1h6MzdCSlh3Uzl0NnRDUVBp?=
 =?utf-8?B?algrMG8rVm51UjRaaWtFdjlGVHlweWxhakZ2MUxwRlZXRU9INjNtTEoyYUlx?=
 =?utf-8?B?QkdwSlRlOWNBVU1WaDB0blcwRitjTjRtMy9jTWZrTmJPeVJxdCtLUDRqS00w?=
 =?utf-8?B?Q2NsdVBiSFQ1RXJsRDlKOVdPREpaZ3gzcmNiVE5EZDlHRGNkSHdkT2JaS1Zl?=
 =?utf-8?B?U2dPbkw0QUlONnVuQnR4aHI4eGVYYnJ3bGRueGJJV0F4THR3bjBNTlZ6SkdT?=
 =?utf-8?B?VGNCblRzSHUzbFczcUxrb0tLTk1wVzdNWXpvYnlocWRySEhqYmM1cURwTGdW?=
 =?utf-8?B?dTB3cUswelk0NXZVN3dLVEozaDBHWk1YaTZ3S0ltSHp3QmVvaHdWQnpOWjBv?=
 =?utf-8?B?NUgzMDJNYitBN0ZpeTBjM3hscFVkRzVsMExkTzh4Znp1bW5mWDFlMVMxU2F3?=
 =?utf-8?B?UlpiMXplaWFpaUFxc1pxTjJzemdVWlVuS1FYOGZkRFVGME5ZSEEvQ1VpOFE2?=
 =?utf-8?B?T1E3MU9vM0hwd3lncFV4SHhDVFB3UFRSWG15ZG4yWjN3Y3JXMEZqSzlaWUU5?=
 =?utf-8?B?NkdXaG9sbnlxY2pjVnJGMjFMM0ZiVy9ienZNUE12UjRJVUY1ZGFUZz09?=
X-Exchange-RoutingPolicyChecked:
	iJGs7zsTHtUDlqx1KPbwFdX8PsDAZUY/68/1s9tbZ9pz6iDU50Kg8cNHeY6oKSQt7V8eeJjpIpylCoghcXHuqHDhRYhFPUgW+mUJBzhvjyzEIw3lStqxWNxJw5MvbBQY8Vsw0Leqzgq6TkGSyjWneQQOYbbB3zcZx4/lkHDcqkGxODGR08pYL5zcEhmClicoFR7el74HFtGbog8hmmsdqUl4GIicUaVLi81ojBMDqZ2sULPfFYS53kVWBHwj0OuDBoDB9alkCKWRKHlyY4g9f/mulHY05oqtYeplVoxJTYJynvE4FLO3wUZia7HrxxtwjhTk3dOLa1IOGJQJgLm8nA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f9f3ff-3346-42da-f846-08df2b66e4ef
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:21:43.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4JvfqylnarfBKAGb+bP2RRS6Fu8hlCiRB6QwrafAh6BtBEXbA81VekDHpJ/K1eLTagIw7agFi2oh8uaqlyQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8138
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX/wlNotHUCm7M
 Cp/Bd3fdX2/IVqhOhR3eWCdcWJeFYjosWj7xFadpxHx1+SJng2irUfKMOcfjxZuWTMBgjsr+2FR
 MeIFGOSDTOmXcocmBKT6SxARyb6auR+n58f8tXg/PJ1Xri6bnJyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX423c2hYC2nDx
 WvYd/Z8lXnfnhHcnDMiS9pgZjaDmJ+JR5trex23POGkNXmcEo6wMt136LunOr4JYap/RvnUXw6y
 CLj7262z7CBVYPYd9fni9PxpAF5pd4x6mFlJRYtOO6oeEMOeSXZtUQHg+XlRtYEpdZywLsBXSu7
 rayRqlyLpldsXwS6x4IvQ8Wb6Y2cezIFBjWbCRw+4U8ZBWP5PetNCOjofiO5it6HGtdLp5sPowz
 6sff+MadSq0cAmu8QjOAaIvsLwPBAUukk4CqMuCKYAx0cbCw52ZAQhVNVxCFPAUr4DKYrnv5Q4r
 HpfuRd9vqP4OD/IuvUHmU9kWtMuZasT1aN++2uWx5b4QcS1z/Z3lxKIfHNeBndyoTCxCZPY3/Ss
 wInvaQWGRQa3Nkdfzi/NcH05CVya8eMO2zdxPSOPI5tmLBzCH0t2N7M+83Qkq2RPMR58yWPVzcB
 MvIizskG08Et+e3h7EA==
X-Proofpoint-GUID: PGRRoX74kw3hGtZbbyVR47DK93R4c9ag
X-Proofpoint-ORIG-GUID: PGRRoX74kw3hGtZbbyVR47DK93R4c9ag
X-Authority-Analysis: v=2.4 cv=eLqGH3p1 c=1 sm=1 tr=0 ts=6ad1ecab cx=c_pps
 a=NeHo0b9PnFRHZsaa1SN7PQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=QeTJlRhm2XaCXXULJ0MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160037

On Thu, 15 Oct 2026 13:49:49 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> Document the integration_time attribute for output channels, which is
> the time interval during which the output is generated by integrating
> a quantity, such as its rate of change. It is the output counterpart of
> the integration_time already defined for input channels.
> Add entries for the altcurrent, frequency and phase channel types, which
> are going to be used by the AD9910 DDS driver.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

With the minor change pointed by Andy,

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
