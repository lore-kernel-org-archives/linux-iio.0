Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216582D5436;
	Wed, 22 Apr 2026 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821052; cv=fail; b=loJcdrGaghOvtJnf0t2IiwQrKcOZPEvKD54XLm4bMOHS4gukuINereTaCVVWfKGBHYmcqF8jn+BEJZ4ozGla4DwENTvUMUbaWLdzMuIybzKHkOSwG895b2dq3IaDDcMaL4ucl8wXbyvlG4i7lui27lRoGiBXgINNClbJCMMITUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821052; c=relaxed/simple;
	bh=a5GNreHlB6FW12oE7IaiaQycSOknKCx2t7r/thUn+Uk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPLZ2gFJWzhGFp8WqxNno1ZlfSf88Ui3Tj7oeLXY7ESO52KJpfYdMc9mAJfZ5ztQj9rlqdiNXb9XqypeNxoF+k6vT52pQSNiV6lKBljXEmKO+yBP++Y5/QxZecxudMuOYRERBoOIqaskQvHpz6KWfHVF7gAJAs1dWsD5VYbecks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TM8rgrM+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TM8rgrM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776821051; x=1808357051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5GNreHlB6FW12oE7IaiaQycSOknKCx2t7r/thUn+Uk=;
  b=TM8rgrM+kQ2JnN+7SqiH7nQYB+/KGxVpEZ8k7gJnDCFGRuohmXOvNihD
   GLslDev5itFkQe6Wi8hkUNevzNz1BIWiKuA9bRbL1PYx9eZSuF10vxtva
   sULlaqXsfuF4UE/OCyulT/jVay+Qm55993bSxHTosiFcNEqGykjdaI4yW
   dLM0yhejlNzLLwFho9B9L67l5h1RzQafXTlCV+R3LfXcqlPDzqtad8G4m
   5IhOATZMDljPKdd5g0MnfHeDzVK0TBIrIda1Qlu33lBXxSCG2PeFeniRP
   Ak8HyUCrNHjEHWGIMY6eDuaNOYkWK0gxBMHO1aC1/55Y0SYSfC9VEKMN4
   Q==;
X-CSE-ConnectionGUID: 9e1GgPmnQLqe9qZLkxO6dg==
X-CSE-MsgGUID: g9yzy1FGQ2ms8AKxGU+XKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77747668"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77747668"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:24:11 -0700
X-CSE-ConnectionGUID: IfXolGV+Tzatg2mMnMaS2w==
X-CSE-MsgGUID: CnFwqHjRS2OBd6YeE0vXMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232070005"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:24:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:24:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 18:24:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3iEpzyVjzxa/SZk1IyeLuzv9xI8LTSnDkZA6mmcTCAfm++AUP9Xd9D37ga5ZM9FAchGQdamQgIl15ZEFY9kR6HZ6cGJmcSO2Zp2B9ZP9HGcBE+6YkK1WuWnyhuh5nUFi2l5+PoBBYMIlgdby45fHdu2rCusvFrwypY1elcQS1AFUPvnAkvRdJuVBAoiarZy0zrxJogRPhkAQWB4M4Az+RfKUHfafvJoWNnyy+v4vblkh4vyRlndzsYNrpJ2BbQEyAOMVWyJqBYI20115xk0puf9vLT8DqOzCd9TsBbjBbhmo9Aa8dcSg5ZxVM1e4ieivwC1XzUPokeHdysmIASj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vslqqBiFqDNZOymJh8gmOQc1gAVmokPZ/TI8qEhOPh0=;
 b=Fwv+UuMYfbXRi7HGwBv4hK0gfynJ+oxYrihZ/NKbFAh5E/cHsdw+ICXyYrkwMWbeQELNTxnQmVQQ6Xz/j7AfzZamcBdlcDOqKuhO/YxtOAHDauGTRFhDzey8H+9iIXPNrB9Nb3Uh95+lDhki97HY+Zdlac8Ahn2kAXXFUzf+B4jyvEZtTSM9AUCRamhCz8WbjTRwbvUH5ft0FOHVo47j0XkCQCCSTU1HGr1+ZXzyLK1fdeEiXKMlfEBIPcdIXQ2+0gs6/K+5Lo1kowgzvEYHu4NxP3KMSZRgr+5UlcHXKiNBkrNM52fMh7E6wv9NJG5ESioWgXYXgIHiw4MpV1CTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 01:24:05 +0000
Received: from DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610]) by DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610%2]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 01:24:05 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "Lechner, David" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, "gye976@gmail.com"
	<gye976@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [PATCH] iio: buffer: fix warning in requesting threaded irq
Thread-Topic: [PATCH] iio: buffer: fix warning in requesting threaded irq
Thread-Index: AQHc0Sm+6dWGCxMIHEeTS5BhDCpL27XpQsqAgAEHYtA=
Date: Wed, 22 Apr 2026 01:24:05 +0000
Message-ID: <DS0PR11MB81349523FB47FEC75EB3EBA9EC2D2@DS0PR11MB8134.namprd11.prod.outlook.com>
References: <20260422005038.1600632-1-junxiao.chang@intel.com>
 <20260421103807.7ca935e9@jic23-huawei>
In-Reply-To: <20260421103807.7ca935e9@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8134:EE_|PH8PR11MB8063:EE_
x-ms-office365-filtering-correlation-id: 7b31a1e3-9b4d-4de9-a3fd-08dea00dd80c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: EVQdelgFrCq99siU/eTGIrtv0nKy6vypMoEVFGHD6HzEeIFjZJuWOVqmLaLepQ+9bg3RgJWzrxlW7V71zxn42R4O/9OIiFvpl8FOny1jIk0WSSf2oksPNkN36OIG0XIMMfFdTRcoXWAQBy+seo8GONR+abu+XpZ4D4xxAW/iF6SRZvMt9t8ku++bCALxzZLsNaY9slwq/NX5hN+Ot9IjEboqM134Huv/Tw9iUQgeO5U/P5CX9hBGUTyvWVj0IxOao7lzlwnwmovrVeS0A6zENqX/3BVDBsGnzLWUyBOlSKJinDk6AZkywiB+IQHkUGYf5w28uFf6X2aVLONcNsn9uB918inPrKz1fBPlVYmdblJVcBn8UrqB4YRHPkhAvIjj9fPzaaHaC3XT2Tgd8sF9yST5O/Xg2gpmJYlw5Gt8OH8CkAudh17gqn//LVvl2VsAqgM3daPqIzV/gCUhJ1WjDk1h5k4XlMBlryKIIpeWHupu52GiYW3q270uMi+YnsMF/8jDuyaToxaxWMzi+4ljVBGBzbvkZTVw1vd0g/N+1WNjS0vLqPLA3frfAn0AoTGSKAupexVadxlelXfBk0bz+ibLEDFubhQB3PxXqVkvIZb4J4TCeKYT4Fcua9L7QgrWZAefroqZXAw2KJ1BsAk+3+U/x86ocihw1WgN9d9RiH4CaYLs4u/dvD7d2RGKn0obt60ak1FiNIWrFVfoUgDgDbKAdJdVT1G67V4ahxK+pGZ/etE7o1wruFnP8jQcU1BgxGXiK++6AR/pQQtDMwWujvdV6wBZVQTC2c72u/l5BOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxV3rUUUrUUa9u/EvEpZsLCOKP5GLdiED6BUiMzSzSs/uakEOirF1IV5dYRW?=
 =?us-ascii?Q?wd1Y6rrDfYAQSxY3zVOpxRlYcVqRAloRSgD+TUEMPLbZVJcKBlhTlDJ6XLOr?=
 =?us-ascii?Q?jgeD47v9XKmfyYgAyObgNpOajni9aSnel1MyBXf9bRHQrwZQibEXdnpysx2X?=
 =?us-ascii?Q?PVZO2wbBOGzYjE9hkPivN5kLAEhpx7bMF0C+w83kkrkV5ffsS2v5JC7H96de?=
 =?us-ascii?Q?ISnTfrCHS5GwYZ8cpJwNV7s0xjiVrvcF1qtxUyGekDJHhRaC7Tn5UkafyW8E?=
 =?us-ascii?Q?y+lfpvfQMPTBnGOgObTp4+eLtKuGyDoMTldqaTns3IbmRHyfTSXQw+KZytUv?=
 =?us-ascii?Q?byD79QIWOcU4tMhil6/0aZUgkDII7P+LDq5H3sSklu+jPi8AjK4WRQ34hJ95?=
 =?us-ascii?Q?mktMt5bw/TGbvJZ/un61CpIfPRDRpkvAdyAcE3J2JMXiTX+W9KgFn9N1MAlY?=
 =?us-ascii?Q?O6LE130fipFD3d++LxX6c0FCdTbCCDejuE0v9riim6Z3va8znvD8/2dhl8ah?=
 =?us-ascii?Q?SvsFUSJETWSno4z0+sBC9I/JiJqOELo/WzTQuMSSL5Qt/uRIIy/1kFm7AMqt?=
 =?us-ascii?Q?+dG7OwRiTmwnoEadoN3DLNBhPLvFGs1LFf6TPUYM2P5ULz1+SnhkQ5intVxb?=
 =?us-ascii?Q?8TaYGpP8kXSbQYaBut32DDsrbiROaHOcBCB9HSzv71LEWXjE9z4BI/E9lUTX?=
 =?us-ascii?Q?ELk2luXkSIau6znRwifnfrdt6fQGY1MSk8e4UHxQYQQVsny5AjWY/qPJUvO4?=
 =?us-ascii?Q?Z2Edn56bsqc/TmqzmNFkChS5v0ukRRRt2j13/PBr8Mrcv1QUcedazrLBQ3QZ?=
 =?us-ascii?Q?F43/8AvgNp70Z5FWDavx56HDlhsVoTGK1+tdp3M8yYUjf3cR0rSzrHbwu6HD?=
 =?us-ascii?Q?QFX7ngNoxazOU6MOdmLygxGJhVrZer+1hO/OI9W9x/iX0fbJKArx2/G2k8BQ?=
 =?us-ascii?Q?KkxfVGR+cF0IPoSVOJvjqIlhHa5JHNzwUisrxZsLKgYgwcYMbvqpo8UnwK5V?=
 =?us-ascii?Q?J4FqgiFdoJt8eqJo7cIP3ToyZJh6AyyThkISG5XNIFom07LmPks6WxAC5KUi?=
 =?us-ascii?Q?TIZSxJy9wwPdnd8dIkKGtJ2jegAt7hB7IX7ZpLnUSv5NBHvofU9Ij0N1EL95?=
 =?us-ascii?Q?20edpYDmFFTBntZKzyDMhXdffN3ONoooU7zmgoeLXPKCjPiwguVp1GYqJK2g?=
 =?us-ascii?Q?9KbH3yNofuracTzlcA/o/qLkA1guOvYjEFcCdJVj9EvExtlw6lipkGlSur14?=
 =?us-ascii?Q?hT5Vt2fFWUl/sIwpV63z/6Auco66JW/93JgIGvsKHqQCZGdtRXhL4lxNsA73?=
 =?us-ascii?Q?WfyFdZ9EzXKiHYHEItkhUYQhD7S4pY/zEBkDSge+7t9rt1WmwNyikWUNwAdG?=
 =?us-ascii?Q?JHKdNDk8UBZT+86wNVwkF5/VNwX16dDk1qGzytYR7kAGGAyQCALxHcLjEn/6?=
 =?us-ascii?Q?SlsXQM+D7VJSVIBOePqof7DF/giuHRP/9i7uCIvxNsNtGyZCa7Ue1AWUXD37?=
 =?us-ascii?Q?HcVj/scPPO9qKQGj4hEsPnRg9KvtnSogx026KUc0IVCbYKL96zIg1c0IQ8cd?=
 =?us-ascii?Q?nEgGmRRrs1/tG0lzt7UwAHpK7MpjkVzaP2DO13MStMYZZWtjlt0pamK0gxQ0?=
 =?us-ascii?Q?Ops1UPnZAmpVQYK9ug6oU+ERZuWD3mMAAcyDzwgZq93mumXHTIF1DUpEKgpa?=
 =?us-ascii?Q?AWsqjyQfd3wZ9BZ1E9sXqsDXbMJg+vkvc7gBjkzZCbRXZgPGCSLOio4f7UAx?=
 =?us-ascii?Q?R9wa5mZmrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fv/Oxl1PND3X4+FpW9Lxf03ANOyAMTLrKeto8T8bB0nhFyFHiRUHUVQeMfve28wdQRTRD9XgcfPa0L3RdYfZT1ImRWDWcFyFby4bwT8dbSdKcQNEGar+HOJKH1Avg0I4YcWpEJ3CnMGvxwkDmBtg5X8qADeBgd+62jIseLPSM/lK30BDx2wzES4ikx780ZKY/2b9OwvFzWaOG8Uzx47XWo326rDMfke0BzqCJYsJ5L43pyJO6JWyIvZ4SlOUOA+HV1Ze/A4NTv5FIHC9VVUp00LHfDu9ZRmT5Rsr+GbLPMCBzpaAs1+k7n8wxb9Bwz4LKui12sOA2wT4kbNxPqX96g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b31a1e3-9b4d-4de9-a3fd-08dea00dd80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 01:24:05.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWgbIb0Ur1l9o/3etFf1wSZSNmTdV/JFB7mynA7IFlX4a7lPKRBhssKGKjgd23AySxYVPz1FfFGw6JhMUF1tlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com

>Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>See the guidance in
>https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
>on how to mark new versions and do change logs etc as this isn't even clos=
e
>which makes it very hard to track.  As such I'll not merge this version. P=
lease
>send a v4 (?) Maybe it's gone past that already with all the rules about c=
hange
>logs and patch titles followed.
>
I will append change log at the end of commit message according to guidance=
 you shared.

>This is a complex fix to tag as until recently it was harmless.
>All we actually have is a warning that says the combination in non sensica=
l that
>was added recently.
>
I see, I will remove "Fixed" tag and send updated patch soon, thank you!
