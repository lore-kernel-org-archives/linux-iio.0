Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8083D1711;
	Wed, 22 Apr 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863505; cv=fail; b=rTE6neQliOUiKppdsCLJKBgGeCGdPLd9uwPSoIs/EtiOoBYgflaGqOLqhRVfvjiM/5AVEmdWuDGfq11Y0ZRQe3sz8MqbOVXvdDze9hhe9q4gJAoW5LjIKOK8sTwg/98oidA20bvjmf75aB2uZvbnMnWRXxki9imuI/QTUn9Qlps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863505; c=relaxed/simple;
	bh=wRWRz5ixE8NiTjbd443AMRKPrZn6KbsBCMrfyJ73Ljs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kn+QTzCiIftQe5iigKrW8f7yf7akAgfdi6/mj+uVsFhyp1aQWHJ/Ops7sOdW2P3LXEeeZYrPEFtRf2ATywikDAbQ/YMDnwSidi3si8MlRfxfUQ6o3KXS6b6oxd+mpxdmz03IvvBINlbGTnj5aA2nPEbBXorheCB5hFWZ3PaW3iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OERoZZqx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OERoZZqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776863503; x=1808399503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wRWRz5ixE8NiTjbd443AMRKPrZn6KbsBCMrfyJ73Ljs=;
  b=OERoZZqxYkcVdBNGYI6i1a54NCWf64kiWWMbR/ggEdsaunOQrb4MZ7mf
   /44pq5Kdjwk1ZKZqbytthdte5iVasp5mDkwZLCDkfUSUqRXNJBag87RMr
   LKt+8AT5qHIvv+WNH7lSgjyKjBlW+2lYSdsU7arhQRHklt37srHJNdA8O
   SL2R7sGNO80Bbd7JdpNnvSnXMp8yJWXXMXgBC2HR1039bKv3RAtGn9OOl
   Umz8Ajn5ZvkLNo56nnTXmK75ZzlzHtCoou4MuPdtLEIHoUUsqxAhM0qNn
   dWGnA/iKRoIM7MVgt+wlIFGoWZB82B3oxW6JR6OFbu4dX0jbGZe3WTkVp
   Q==;
X-CSE-ConnectionGUID: 0IdZgVwcSeO3nK+ae/fkgA==
X-CSE-MsgGUID: iJGr4x9OS7ecYsgR1q89ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77727917"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77727917"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 06:11:42 -0700
X-CSE-ConnectionGUID: EWM4NFbCQ/6yWRX8SSE7+A==
X-CSE-MsgGUID: lF+qnnTZRsW8TvajQ3TGiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="262740167"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 06:11:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 06:11:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 06:11:41 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 06:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLYz5EgeXwujPIeYoLXg9ddvsONrGFsK6wXOu1vGi5eoW8Q3pnVKoViDWFqRsWHLmepmQLVINreAtCRaTjEvbGRXHSr6AzdHQSRZq/2QteD1hNjgPwtHtTZ6Kk/OBNBp9JZRcHfkCE+o5pCVsXxkFBK0vrbp6wFNAowuchn4x2Nni/LYcKZzhBA9qOlDlujl7KxYIcsFxzp2L8cvrsRTti+S4L0S4DOcsmewJ1tkv+C62alPBbQFdiw+19XJWUGF6ok7mIF5ycvHuezHLGlQ1+Y0CUyfbRJUj7H3eIbYatc9pb6/cKzm1Y7zwLDcD8d+zUVsX8sagA1XZbm5S6bVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRWRz5ixE8NiTjbd443AMRKPrZn6KbsBCMrfyJ73Ljs=;
 b=DPcTujrmYVpulkMO/LnZPHA6HENPSw0oZcBKGGe6HErizBp5tgdiOE/swLASjzcR93rJ7qX8ewWxGyzv9mYDkVqiTtFa5me5ahPZJ1flXkOwg9npHAPluZ7YOO0i7OqvHyOH5MpDuGcVR7hBnVUSih2on7qdhE2d2iUWhv8ugx4jRnpB6PaMHdR97EikA3We40T2GdpJXac5hBAy7sbcChheQgm8mtJpLF+veQb4UC4s2mPM7VwzVrBfE36lRRRKpKUj2TlDVW5qmMx+cPFswv2eCJjsHaMGSHwTdYiAjj6CKG/N0Aa6lGT0sa95ULR/wwb0QkIkN6nBjDYBzgnVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 SA1PR11MB8256.namprd11.prod.outlook.com (2603:10b6:806:253::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 13:11:36 +0000
Received: from DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610]) by DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610%2]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:11:36 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "Lechner, David" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, "gye976@gmail.com"
	<gye976@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [PATCH v5] iio: buffer: fix warning in requesting threaded irq
Thread-Topic: [PATCH v5] iio: buffer: fix warning in requesting threaded irq
Thread-Index: AQHc0fprMwQDQVGjoka/SUb1323Yv7Xq3E4AgAAsEtA=
Date: Wed, 22 Apr 2026 13:11:36 +0000
Message-ID: <DS0PR11MB8134CAD4786B7DB50723753AEC2D2@DS0PR11MB8134.namprd11.prod.outlook.com>
References: <20260423014426.1999735-1-junxiao.chang@intel.com>
 <20260422110940.261e9083@jic23-huawei>
In-Reply-To: <20260422110940.261e9083@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8134:EE_|SA1PR11MB8256:EE_
x-ms-office365-filtering-correlation-id: 522367a2-03b3-4f1c-37f1-08dea070aebf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ffs58ZnTJHcI2UiJYnXqMDybLqf+j/MToesOKegfHg1ZXKArQzK9PHfzt0fiV28vqcR/anlyEpnFuc1X+a7Pfoew7HFrVBP1XEfrOCKgDb5N7rI+jGS7tuwfJBhqisDLX4d7PdOL2vuJcsbsjmKIt+IwRvLvrZ9tCsG9bOGaBV7vip48yqQrq26MxQhqJ1+tEH7w/j50PTVAbxzo7Uuexg/JTvZ+wxLSfz5y0wf4Jtk2+CavoYF4GA8RRH5l7/4OmYfX/6+xOHVRi6318Yolz9YNp0xYC4PGRXi3+eBw0DkX+UuvDaERUpc51GgpTjyZlXconM6k5FO99pvflc6AFDs6RtHdIa3FTjj78ywGaMnDWdh2cbRCIX4NacyKVU86/C8zhlpmW/xJbEoHaKfXqto9OhO6bMVb1caMraY4f6V44gwS8baSo2C4rFE2AFEttPRcQd3ZUTwDxxI8c4ewY5IRCFzH/5zM3yOmepGoQAVUkFHs8+KxlVoe0Ba3jD0XqjBQ6mxNSmXORQM13YNCHU7WBGS0Apmym8MW/7+0AuOf2g9rOv/IOSHq/n1+KueI3SyxTst/QrYBpOn0yui8NXSSP84GP14sfhaXiFZ2RwJRv7rCiaSRyriPIg2q3xyriYAtETGxuyZRlkXXBQs/61Rsm0SVZQqx/enMSr6L+9FBvbv2Sqyo6TGxvQW8Kn1ho4hNGjpazNfTOvd+beDyaDlt4lxsKTzGjUqJSM1KSFSHVJpQa7FG1mbeiun/5vZCAg+TI+ekYFKBayWNX8wmsFwlcsTVuuuxzeSW7gwcH1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDdwWmtjRm5BMlJ2VkUwTDZaZ09aVHM2SWkwR2QzMDRUK3VTSXdacGtLbFdo?=
 =?utf-8?B?TFRlOUpINVV5OVh6djFVenRlV3ArbGhjb2ZJdHdvdlQyeUlMcnRkVmdtdmZT?=
 =?utf-8?B?cDNYQVYyMnFva2NNcmM3bUlqSTBDend0V2d6amQvc2hRVkNsc3grZTQ3M1NM?=
 =?utf-8?B?ME5jSlhEOHBSZlZsNnh2ajdiTVZCVzhOOXVrZ1MxZEQ3UDcwVzBLWjA1UnFu?=
 =?utf-8?B?eXAzQzc0d1hvcHR4ZlREK3BZMzNqaVBUZzBEUnE0N0dqNGFBU0owNUo0c0dD?=
 =?utf-8?B?M1kreFA4cEYreldkR3N1YlNHcDJQV2hkU2YvMmY0U2FtSFM3YUFRZEJITnBz?=
 =?utf-8?B?cHErVVg3UGptMjU1bG9WdUZxM0xaRlhkVWY4UGx2ekVHTW8xb2tNSm96QXgr?=
 =?utf-8?B?YnNjYno2bkZ4bWVqWEFLTzdtYWg2czMxbTQvbGwyYVByeEhYaUNtY1RwMjQ3?=
 =?utf-8?B?R050azBtTVJFZkZiaEw5WElibjZxdXkyTDRaSXo5VnlXaHlFa0hBVVc0UTVn?=
 =?utf-8?B?cnZJT25ReldjVUhkRXFPdVNKRUl2cTA4aGN0YUZDUzF4bWQwRkx5LzFvZ1dB?=
 =?utf-8?B?TldiWTR5OHlSZXAwbjgvOWtXazVaUkowVEo4UVpUV3dLUjhuUk41b1JDbzln?=
 =?utf-8?B?SUF4SXI0UTVKMkhGRG1RQUoyZVZMTEJMNTh3M011bmZOWHZjTXBBb0hHUUpM?=
 =?utf-8?B?ZFFRd09hRkhrR3VXY2JmQVNNTHAya2N0UHZVT3R3dTltTGIrNThqTjFrR2k0?=
 =?utf-8?B?cWtENnBOMHErbERacURsZUovbjh6WXQwSFBFVmU3UzkwMVVHVjBuQlcxUVV5?=
 =?utf-8?B?MElQNy9CY29tZ21GVzJSVldCZ0FEV2ppUWE2bU5lSnJ3ZWUwbHNlUG5QQzFl?=
 =?utf-8?B?cEdOdEpzbXY4NEUrNWNFeXh6MVJCd21Nb2hEaFRrWThLaXBSSjg4UDAzNmd3?=
 =?utf-8?B?T2JiZDU2b2ZPazZEbkcrMlFBRm03YThCNTZZMTNDaGdkRlZ2STA0TGZ0ZExr?=
 =?utf-8?B?QmpkaGhwaXJOTXVXQUlyZ0xoSW5rNGI5cTJEcDNMQUZFbEQyMjIzUkprVWN1?=
 =?utf-8?B?NVY2MStjSi9xYWFLTnVlSVhPOWhlYlhIb0JFYW9OYm5McTQ2VlRSUW0wbC9O?=
 =?utf-8?B?Uy9nZzliNTQvMGhQZ3FUd0ErL0JtTWNFaTg3MWdXQitiU0o3VUJzNHdtVWcw?=
 =?utf-8?B?TjFVRXIrbmtmVHlFTVRBS1NVczBRVnNvZ0V3MURSUmNGU2FJRHRCME5tZHph?=
 =?utf-8?B?L3hVOWg5NTlOTmo2eW9mNVB4Qkh4M2pOTlYvUHRhZWdjemV0b3llTHNuOC9O?=
 =?utf-8?B?Yy9SK3FTTStmZnc3enowTWErOS9HL1prOUNCUm1KSmZhMUtMOE93d1lmak1a?=
 =?utf-8?B?VDJrTm5kK2RPME5HZjZscmQxWnJNMGhLRTJ4cUQrR0crTnE0OGp6N3oxSHBp?=
 =?utf-8?B?d1VpWU85aHl1dXNGQTduSi9acVZIUXBLVVZQazQrUU5qekVta3FBVU9kNEZF?=
 =?utf-8?B?VURkbDQrY2tVNi9ITDltWFBhYm9xOERsUzU5NjY2ZWczMVdOM3RFYk5VeDlu?=
 =?utf-8?B?d0t3bEltOStDZ2xNNHVad3JBY1J1SG1SNktGVExBcnRrMHpHV2FPVHZRdVd0?=
 =?utf-8?B?bmVFUHpvaFFTSi8xQ3ZhOUEzUkxibkpJTG1RcHFZd0ZYQW9ZSWxaeUpEaW1n?=
 =?utf-8?B?L1JZVDE2YXpNNk5lalU0MVlDTWQrdmovOFB1dWwzbnBEZWp5L3pKcVVEL1h1?=
 =?utf-8?B?NUlmVXQ5aGRXRWNEZE1uQjRKcG1ueVVGQ0c1YkNRcUozdDdLWStqWmRsdmFi?=
 =?utf-8?B?ZWcvUG0yQitUbmtLTExFOHExN1NLRUhQWXlSY3lzOVFDMUxJdlU1SzRHck9l?=
 =?utf-8?B?akpSOURtblB0TDNGTzRBcllWdmdYaVhJVU5oTjdQNU8xRHhPTkRza1hkSWx3?=
 =?utf-8?B?bnlkNmNZNlJrNlQzVXBiSmtUdFZyeGkxS2RTSExyODNFSlVybzIwR0RwVXUz?=
 =?utf-8?B?NU5XbFdWdVhrWXdpbCszK1hUREtWSWtrN3J2MXRzU3FMWVZ2U0UvbEpXRnp3?=
 =?utf-8?B?dFVTZFAxdXJ6Tjlnd3BVQnJ1bWYzRDM0NjFReVRjWVh6a2tWaEw4ZWJnd0pN?=
 =?utf-8?B?a2ZTYlltVytnUUhEdUtIVU1WTVNwTjRIQnhQdkxZMCs0MDNDK1hRQzlvY2xq?=
 =?utf-8?B?VEtvb1pGREVHa1prQXdsOC8vbnZQTGhPY3ZrTmEzdlV6bHFKQWJTZDdEWFhG?=
 =?utf-8?B?UnpqY2FhZDZkcjQwQ0QvRlFuRWNlSTMwQ2s1S0hoakJ2bVkyVjVUTm5raWJw?=
 =?utf-8?B?NEE0VkVTWGdFbk5ZeGdObXFmdkVORUl1bGR0MVN2TS9ya0pFYS8xUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YgOg0R8R60aBZyqLcOGIj8n7kEG7+W4Hgo08xKciJ6uKO7K5pUDJRb/btINxl24v4aQOf+1uu666uviEtw2osgFu/ZXeGXsg7TKGOeZirdlHrq8/p0xe/ciklUTJbkMLESg32aFjrMJlJDg9lP1ayZejs3xSJK7OeRK5Weie1XJ6pI9osG2TsmLSuQuiKA4d3/+ZX3jwhzsi11jUAH5bNY/zKOSRv/4TSPOz09zFdSR/uTE9PdlgW1qYDMR1QvQaLBD/gnzLLrE94BpoE6grfJKPPvcs4MaEB1Ii42RNPktvVqEdinxmCGZAwq7MdkLKv01FE2IDEPzl6WkbTnQc7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522367a2-03b3-4f1c-37f1-08dea070aebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 13:11:36.1719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mq7BStL133FaIIeMF+49niQDd5YiKbB1BfgWxrc3/2VQDXxXJChP6MZySBXubDcYvCpnNQRXsPB4vewv4WxPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8256
X-OriginatorOrg: intel.com

Sm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPiB3cm90ZTo+DQo+
SSdkIHNsaWdodGx5IHByZWZlciBvcHRpb24gMi4NCj4NCj5BbnkgaWRlYSB3aGF0IHRyaWdnZXIg
eW91ciB1c2Vyc3BhY2UgaXMgdHJ5aW5nIHRvIHVzZSB3aXRoIHRoaXMgZHJpdmVyPw0KV2UgcmVw
cm9kdWNlIHRoaXMgaXNzdWUgd2l0aCBrZXJuZWwgdjcuMC1yYzMsIGlzc3VlIHNob3VsZCBiZSBy
ZWxhdGVkIHdpdGggaGlkLXNlbnNvci4gV2UganVzdCB0cmllZCBsYXRlc3Qga2VybmVsKHY3LjAp
IHdoaWNoIGhhcyBpbnRlZ3JhdGVkIGhpZCBjaGFuZ2UgeW91IG1lbnRpb25lZCwgaXNzdWUgaXMg
Z29uZS4NCg0KPg0KPk5vIGlkZWEgaWYgeW91IGFyZSB1cCBmb3IgZml4aW5nIHRoaXMgLSBpZiBu
b3QgSSBjYW4gaGF2ZSBhIGdvIGJ1dCBoYXZlIG5vIG1lYW5zIHRvDQo+dGVzdCB0aGF0IHRoZSBk
cml2ZXIgaXNuJ3QgYnJva2VuLiAgSSBkb24ndCBoYXZlIHRpbWUgdG8gZW11bGF0ZSB0aGlzIGRl
dmljZSBqdXN0IG5vdy4NCg0KSSdkIGxpa2UgdG8gZml4IHRoaXMsIGJ1dCB3ZSBkb24ndCBoYXZl
IHJlYWwgaGFyZHdhcmUgZGV2aWNlKHZmNjEwKSBmb3IgdmFsaWRhdGlvbi4g4pi5DQoNCj5Ob3cg
dGhhdCdzIG5vdCB0byBzYXkgdGhlcmUgYXJlbid0IGRyaXZlcnMgZG9pbmcgd2hhdCBJIHdhcyBh
c3N1bWluZyB3YXMNCj5oYXBwZW5pbmcgaGVyZSAoaGF2aW5nIGZvb2xpc2hseSBub3QgY2hlY2tl
ZCB0aGUgcGFydGljdWxhciBkcml2ZXIpIGFuZA0KPnJlZ2lzdGVyaW5nIG9ubHkgYSBjdXN0b20g
dG9wIGhhbGYgaW4gdGhlIHBvbGwgZnVuYy4gIEZvciB0aG9zZSwgeW91ciBmaXggd291bGQgYmUN
Cj50aGUgY29ycmVjdCBvbmUuDQo+SSdtIGp1c3Qgbm90IHN1cmUgdGhleSBleGlzdC4gIE1heWJl
IHdlIGNhbiBtZXJnZSB0aGF0IGFueXdheSBvbiBiYXNpcyB0aGVyZSBpcyBhDQo+bGF0ZW50IGJ1
ZyB0aGF0IGZ1dHVyZSBkcml2ZXJzIG1pZ2h0IGhpdCwgYnV0IHdlIHNob3VsZCBhbHNvIGZpeCB0
aGUgdmY2MTAgcHJvcGVybHkuDQoNClNpbWlsYXIgaXNzdWUgZXhpc3RzIGluIHN0bTMyLWRmc2Rt
LWFkYy5jIGJlc2lkZSB2ZjYxMF9hZGMuDQo=
