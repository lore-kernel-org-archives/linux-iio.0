Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21030375F9C;
	Mon, 20 Apr 2026 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776649865; cv=fail; b=jidHCmq/+94VAuDSiW/5Fm+3jz9YhvL4F8lzEIev3AT1mjSCYCsUDnILSDXoBgT3GQKrewD0oCbdQbGgtYwB0tvLlWLgo/m4x6UHBg5YPcx/Ia0CJbBmppHnv+ijZjkZ3ps2ZASaTeeESUCH37EVTkMyzwbvyWkoG5CpGJeNEGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776649865; c=relaxed/simple;
	bh=6RddNCt6V5nH9An82eYudvL3xZytf0XZCHnUGLYg5lk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGMWOciwsQktc4tUF9D361xsXViyiJ30KIourOdxfOMgQGEn7JLuCMJnrmoL+axoB2nym+vAqTa934DYIouTqW6Vj/2bNDqluO+HYiu4ErAuWLGIs2S+btBXlCVNS9mtHxu9wsjpUq9S/bp2Q/8+NG9f5mnrXtz+3jh1D9PPb94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3EM3Qok; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3EM3Qok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776649864; x=1808185864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6RddNCt6V5nH9An82eYudvL3xZytf0XZCHnUGLYg5lk=;
  b=O3EM3QokywcXtZ+BFlVSiNoKruID4YXbIAnzOQcf/4pcOuZHrpPtMEfx
   p66FKQ8Pajgr4Bd+7L+MUN4WSaHPmS2fC6Eww996FMfa89xuHir7viydD
   8jXh0j3hJe/yO7duQGeknGOjfmVjSWtbd7rwdeUtOPtegv5qczS04wJV+
   PBGgYn4QwGDmrM5uDyz9fgV6jUR4dsSF+lnWQKDrrdzKAYprhWyF/0968
   kvnpNm/f5gfwTs4u3zogwHdMgjhFN2j5OkZ+L9YZSGRh++vEFKB6qeLee
   hB9/N+9zAlwF+I949wrxKIIN9SEVomM5vdYURRUbGskfN6W8YjilIb640
   Q==;
X-CSE-ConnectionGUID: LkdQI9bYQYOWEkc+b2ZiTw==
X-CSE-MsgGUID: tRcrloiaTnKk6S//lxZa8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77430703"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77430703"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 18:51:03 -0700
X-CSE-ConnectionGUID: D6fP8Bt/S3edQRbb6IQZQA==
X-CSE-MsgGUID: IHv9CK1KTXmEdCB8b597iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="236574087"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 18:51:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 19 Apr 2026 18:51:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 19 Apr 2026 18:51:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 19 Apr 2026 18:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6GjW584rrXHEYZJuhqvdxzBHuxBkLq0foysqIDU7rrYEFSM9OhPAH3m+2OJ5qMMKw3MglQU4+uq5HpOhX7IU5UJFIoccQCy1CYDisCcJmKkgiTy/Lz/C8pzIlo5PQpTKrhDC2cp/RDEwGIQeDnNGZ9k3mGO8EvH45CU1Eo8RjXyRcFMdDUQzYKOnLO6PDaON7VFWyvor/WQzLeOejZgMQ3pZaMAPv+JvsnKRa5j06xmT1cMNnX9OlNhRlvBs0sOy8Chh60+IXNTtA4lkvRyyJEAjnmw5UjaD+XNOHVNLwgWOLJ4f3zlayG+kZkoXe8dhhJCtf1CeKT0o7A6J3rM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8RHfRYrvlaQhCm7QUl/7NvLFNJ6eQxR+VqZ2SoUsKQ=;
 b=ZqrCtEbhfY3kXmoBKwxmSCBUxCJBbo7n+83GuqFzvU2UFC28Jf14Bj+RP1VJRetpd3QZX46LgcCpheqsjnwp/UiLtSjB+YQeoa7yQAKGfSEi6PAv2ugynX6Tve6g+Vtv3I0WgEEoprs4pLdG1GHTAcsvknaU8iT3imrPVvOF5oXkCfhUCuTPTpyNTSHyZGhsaZuMFMvywEZI1IauQxgYeCeXZjIbUFVHDEZkcgsRSmZx4jmBdR1LMg3GJE2J0W4SagWWSDCfRDjrtfM9EMTpUg8mTaQW+vsVidlYvOgnNh/BscSMZdG6i2s9sfHRJw6+IwN8LIDIS4IKnpvlnJjtsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8)
 by IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 20 Apr
 2026 01:50:58 +0000
Received: from IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::4895:dd55:dbe9:73bf]) by IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::4895:dd55:dbe9:73bf%4]) with mapi id 15.20.9846.011; Mon, 20 Apr 2026
 01:50:57 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "Lechner, David"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, "gye976@gmail.com" <gye976@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [PATCH v2] iio: buffer: fix warning in requesting threaded irq
Thread-Topic: [PATCH v2] iio: buffer: fix warning in requesting threaded irq
Thread-Index: AQHczkhMDO4bWw6uKUK98eNyVWf4rLXjHomAgAAWggCAAymCgIAA0OZA
Date: Mon, 20 Apr 2026 01:50:57 +0000
Message-ID: <IA1PR11MB8152C04881083E147863F150EC2F2@IA1PR11MB8152.namprd11.prod.outlook.com>
References: <20260418002334.3643504-1-junxiao.chang@intel.com>
	<20260418085156.121947-1-junxiao.chang@intel.com>
	<aeIZw2gvbZGJEXy9@ashevche-desk.local>	<20260417135044.000037dd@huawei.com>
 <20260419140805.6abc77ce@jic23-huawei>
In-Reply-To: <20260419140805.6abc77ce@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB8152:EE_|IA1PR11MB7773:EE_
x-ms-office365-filtering-correlation-id: cb2dbd2a-8de9-4ff1-9449-08de9e7f445e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: xeKGe01Kdeos36m5XCxMhVSGIPKrScEqdIPASbV2vz0mnab2tFqsubonSlQmdWVcGeovxC1qq5mqh4TCntQ22tl+BcZ/H/NtABITg3O8zE/+OcKLXQlYu4EpPJrNjSREkUk6p5L9GYOrpEVfLT0MOIakg0TyF0CR8ePmKRGA4vRhM4XwcOtpgC0BrRMdrC/LVPayk8r1GS90ixcCEiwSEzmTrPTNYALc8SDzhoSt4Wj1mOD91l89d5fCMtpwZ3GX45ZoKX3eh5JfxoRHr7zzi1YYld7XXgQTED34XYhOjtz3fN3tDemo1sdFjg8JiGLJroV1pZwYovjvILX1PaIXw4kvzqj2ZHfWD2K2UepNS0Rwg1T28OUYuOOKZvRZ/RB3MX8cL0w7Acs4uHGDgomLw89nilbUoM995iMGpCW187xdrNk3Bp9m+mhxw51XHXbiMgsVYPPPtzHEEmtzf5TMGAEmW14sKiWaaYcdC7FmPbNSDpUIHpYv95jAmhBkEBfYUnnhBeHFdXpfnCwe/dgRgUhPv2rJZl9XebjcOVgt0/bpeC851EFiiL3dJZARXBBiQWjQ4Efl30tzk3wrWy97Hl6gI5P++ytZBQ5flGiMrrEuKNWqPaqz/CKMpzMhByMtla2W+FLzWyw6iDkc5R+AIaITzQXi+KesiP0wTZcC/whds2Ae4g1k3w4cpmmDPnPSpwQ/BOt7bPC1Y/Bzp/j515jrbSxhbcQiwKzDpBAyqRqzbnXfRT6rLjwgaicGvqn/pvLQA7ZfJpleEnVUI9wCSOhbtsk590k7QEN9IosN+B8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8152.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eqbZEb4/+sEg/JeTmsKEBNEj/btGruKLFWqJ5TAlp99ELiNB+nmMU+29KvHw?=
 =?us-ascii?Q?xzonASKPVsF/ZuBsHjC9FHpK5MGOTMPfLmIfUDmKSrFw7RPelie0rvbURs6v?=
 =?us-ascii?Q?cat45I3qgZCxsI1thJ/+Wog/vYZY4KJW0OI3rJ0D1XjcoIhlTkTmX9tMWNk5?=
 =?us-ascii?Q?DcSD1BqYZajIB68a1RS7bLRahlfvaIe1w8bCurPPV0dtZOGpO8HcRTfUH/iY?=
 =?us-ascii?Q?Xup/Wvo3waafvWqPQxKvYLZqjXsiou5VxnrMSfzYf8pRaXNy4vnIHQqtWw+s?=
 =?us-ascii?Q?CaHXaqVrbFV0HjsKbTvPfd7WxOtVoUp/mBpT3eILbzCxmSW7/rSvFVDPoa6W?=
 =?us-ascii?Q?GOqZMVpmGHN7u249l/o8jMwjZvbf8V5v/9AY1JwaFMDvSt4zlt0THhUaesuG?=
 =?us-ascii?Q?1ZIzST1NECxhYykujUur8HGUTb8mravWe/KbzsRO4wFtnbRmwCXCajhLzCQr?=
 =?us-ascii?Q?MFRZAkiYIA1oxIoNOyCMFSG8xPsWbqkUpHdbsgGGwCm1r7MDftgGNE4EKPPT?=
 =?us-ascii?Q?SeNDde9wyDaX9eTt4EI81xvqAn4n9Tzdwe2Z6lLESBtnzFQgGU3fyEHHkStv?=
 =?us-ascii?Q?QIQMftHmZ4MRW6Y6QAga3BWB6glf072DPDM2LREDMfSvdOOniT/69Jl/ed5/?=
 =?us-ascii?Q?X4g8GIZ41TP/1vxJo9TgBuhtvMtwr4jfamdXJYKl+MFlwMuTpo04AlSZcgXy?=
 =?us-ascii?Q?WAgbeOOdQRNy4pbMSBN32IJGzZ/TedXcB+w05xh4uKMhtaz23+Lk1flCg7IN?=
 =?us-ascii?Q?8J/INsYTKfozh7ZAi4Ao2t8JRqX13mc8AxAxZ+uV58fThsil7LH6y8gMTf0k?=
 =?us-ascii?Q?FtdJFAM6w8+Tf0OUSvKxTVIesc4Re0x7R1oSFxD5bgBL3gYAZDxw9EmfLo5d?=
 =?us-ascii?Q?jWN5t9Eah1IqVnICKKJmgTsdo0CP6Kew8/zNTRPjVFTk+wl405CZIjpRVNI7?=
 =?us-ascii?Q?QUrR2M/bYl/CiYLtxdhsuAChMnyNtlvvi19Gf8YPWu5vgAg5UH9wt01/L7iY?=
 =?us-ascii?Q?wZeSe53FT32/dvMVEXROqKE1VdbWf/rSJ+oUOQjU1zliOl/Gobn38h1fZuN+?=
 =?us-ascii?Q?5dMYpVSimNTwTGQTMkFF/ifkqG1iHia2j1Vlwg8asi9UkhJMUlDZXp0RK6Fq?=
 =?us-ascii?Q?lSBVH7539ToacYEyP4aU5FcZc0tozBEMxRv2tP8wHn5D6HfSeYAZPeN9SOtG?=
 =?us-ascii?Q?lc7hwFChXR7ZgEnKbXoE5s1RFvC/GGsh4xfNp5sBncSTpmyBzIIJ2fkHsvIX?=
 =?us-ascii?Q?CQ1A8wxHGWnXLBPEHDgo4Im+jBPVlmq2X6HrdN7C8M2+eSIJabjZhJK1mlK3?=
 =?us-ascii?Q?48jo8tOlLbWu8zRAQnMo8qYDtlX5SU7SBiJyGr4wnEQZdyB0h6JcRiNrj2Ay?=
 =?us-ascii?Q?eQJk2PgdzEOLXR/MmZW/1qCKDSa4z5kfjHHOWbjkD/LemxBf+Zo9Hogc8Gl7?=
 =?us-ascii?Q?k0oCHA/lCuZH72j16emQJAGgMFnemMgXnrJxyTzhy1VFygVGltgfRkA5jWuM?=
 =?us-ascii?Q?2Qq5axjkIeSgV9Tdm4j3N1KGqxEJ+efD4esIpu2fzX/oDW30wthSPwGtUJwa?=
 =?us-ascii?Q?V12kJS4k35P1IxPqcMtuM0oRkKa2A1rU8GriJSCxST/fJUO5qOhYI2pRAB8j?=
 =?us-ascii?Q?Pcp2O1RuXmU8Vc043CDAU4wxKKljr+nKm1sEC/f7+r8L623OMQTYFChblMUr?=
 =?us-ascii?Q?ywkNRWbetE3e9+JyLvb187BfO4XkPR0HpFFH13xs3a9shmJapAAVtFX12PqS?=
 =?us-ascii?Q?zuA4yixD2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Iqp9MJrGVOOcfd6rfrZ9yYthFhxFs5C08Q0o/9SI3K5POfSEBA6SQ1g0K4hmEH2Sldak4LzjWvkRx69EKDBAgnOYOb61pDqpYG3FZhJZgyf2xbrCS4RfjO4tzVPLyStm0FwnIH91eCDlK9OwhzaNcNKFNUd1IO5Gf6IWoTG9vqf/mZ2hd7nIXLkzj9M0nYwV+DacLX7wcie7fypk13OEtD+ZmJjh6BaO9J6/bmZI+xSlGmK67VDEnW14FlCEkpvTp6YYd7LG4Ez7/88CYl5x+rFUJs/zmF+yierwW9SDD8dH4+hC/4gS2ITsjPBnncYCJXVv/wFn72kYI4ZoLWYsGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8152.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2dbd2a-8de9-4ff1-9449-08de9e7f445e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 01:50:57.8191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HCNr3cDM8qAkJxCUOhs9gzmxP/KrSoh8xPC7htFcUD+ygfItKpjfBUasyzs3aw96WtIMs1hiRc/dAjCy4KaJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7773
X-OriginatorOrg: intel.com

>
>On Fri, 17 Apr 2026 13:50:44 +0100
>Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>
>> Please provide details on which driver is in use to hit this corner case=
.
>>
>> That may help people identify if the bug applies to what they are
>> seeing and also provide some background on how urgent this is to get
>upstream + backported.
Our hardware platform: ARL-s(Ultra 9 285) desktop. OS: Ubuntu 24.04, kernel=
 v7.0-rc3. It could be reproduced every time.
With code review, some drivers don't have threaded IRQ handler in triggered=
 buffer setup. For example:
vf610_adc_probe in drivers/iio/adc/vf610_adc.c
hid_sensor_setup_trigger in drivers/iio/common/hid-sensors/hid-sensor-trigg=
er.c
This might introduce warning during boot.

>
>Another thing I just noticed related to upstream process.
>Please don't send a new version in reply to the older one.
>Send it as a new email thread.  It doesn't matter a massive amount in a si=
mple
>case like this but when things get more complex threads can become
>unmanageable if using this style.
>
>Another practical thing if you want to get code merged is many reviewers d=
o
>what I'm doing today and, when they have a massive backlog to review, star=
t
>with the latest emails that they see.  In this case your patch ends up fur=
ther
>back in history so is less likely to get reviews in the short term
Thank you for your suggestion! I will send updated patch as new thread.
