Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D253A2546;
	Sat, 23 May 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779545740; cv=fail; b=VH6A5lZkfEBOIBV4a5z/NWX9WHV2lukK7yOufD/YwGH/4Fi+94Cc1EtX1ZI87sDYmraaix1ZQvEyaAw6Godtn10k3z3hwEmny1E0FoMaZP/02amCA4Y5X+8DUz956/3cJSumdMKkPPbjOfI0l2yiEHUjj3OK0CzqlHDY3BdK/R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779545740; c=relaxed/simple;
	bh=40vVY6I1K5KPwLo/nHydodxKdqths0Rp8slCPcrNt6I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUBahSJiWFFrSiSEh1aLBUYk15A39CeFm6M4lj1YyiFT0HkGyE2CgbsyV2rCgNHt7+wi4W1GXzdz7qIIj6gR5vUggAAc22gtYGQ28X+zOi1yXAwyzpEAkmoxs8WXXKvIsExxvMHJrcMpw9kgyIn7XIBvN4iFaxOGm847Q/zvTdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImzLcn4V; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImzLcn4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779545737; x=1811081737;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=40vVY6I1K5KPwLo/nHydodxKdqths0Rp8slCPcrNt6I=;
  b=ImzLcn4VkXmZsfXvip1sKbt3lwZ06gwDr0loiW7pwzxznN6B0nC6bavW
   opSEzLZH5hEKyIT22o0H789eNIcp8b//D3V0gsmUntOMPrxHdbSobQciu
   J5kJZxyL1FntjVCYX3pvu9opV5xo6lWpc5H7pF/GkI0DdXzx0L14BuAH1
   lS3nHX/nbVC43QUXka+zPZyy80MHEDMFnXddAv9IbfwCFqL2vjbS5qbye
   30/D3HcD8q7K3/kXshNUev4B7KnR+rDuxh1/hTFRKMHJJdAWkCRcjaTww
   /YlJZniHJ6M0aLjiYn7lc1evVQlcBLmRKaZIDToTINQjBudyFgluQWc+q
   w==;
X-CSE-ConnectionGUID: 8kFeDNitTc2WmRmwU+9OkQ==
X-CSE-MsgGUID: PFjgMdFeQr6P0B/U8lVwJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="84331263"
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="84331263"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 07:15:36 -0700
X-CSE-ConnectionGUID: VigecSWsTYaqReTxVuYyrg==
X-CSE-MsgGUID: D55YbD4qS12JZru36ZvTOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="246147479"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 07:15:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 23 May 2026 07:15:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 23 May 2026 07:15:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 23 May 2026 07:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bu6wuEvVD0g7oBu6MX6wLtMWqQmqrqGKxUh+OzdPHzO8UK1+0kbd0P4TBO1PLGIt3t9kH6D6UqvKvlk4TGQYtQR/+anqt1w4P5Ys2yI/SsbKy1x2ZX8Nq1TSBUwFpvTzqUMs/GLNEXkUXiNnFBbAmazRMfv55YtMcW6Bj/tX5VK2kL3dX95V+2KpRI3vYBGXo+grfkOftwZ56gWoX1O6HoM78Hjf1bNwn/8mng50Gzo5hOczWW0/4rwSQ2ocnea5sIb1RhBsD5QqqWMYfbSz35MY3x8PdSWqyHKD25j+oVBo57MrIaxIQw8EuHuFkXHR/vzndm1I+QCwmOde4VowuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSEE8d4H3GATT0SQwQ/nyKyGZEnjhRMDrHKZLN22KW8=;
 b=C79mmLGphReT2/aRfIy7tyfkbmMskIP7DmocdNXXitDxj8jPNspwrYWDGCQEAStt6ZFVii/bzExBDEI38L1OdvkiNqaxjrSaorlljFj1HCL+TGU8hUrpntSoPcUEj8OfbdHEc0yvGl1ymPi+x5+Bk0CVH/sJkWMWgpPFtL80k8LQVzUFVz7y8bWO9+07Alkq4IJfmIZXdc8ZXkI9XF9VzSg5zLV7u9EU9O22oc63VqTQ0KccBGxldccMEbhfmEW8+exNwfZJE2+geAHEFlmewtzThIg6VYAkL6euLuW32jDXJQUJ1rIlTtBq6XLbTKkyD3Ic8oW6OEPmOOBq9NMTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Sat, 23 May
 2026 14:13:53 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 14:13:53 +0000
Date: Sat, 23 May 2026 22:13:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <driver-core@lists.linux.dev>,
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?us-ascii?B?PT9VVEYtOD9xP051bm89MjBTPUMzPUExPz0=?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/4] driver core: allow certain drivers prohibit
 override via sysfs
Message-ID: <202605231602.b6990b2a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508095224.1275645-2-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM4PR11MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f197f4a-56ef-4a05-8361-08deb8d584ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|3023799007|56012099003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: Utdt3U1o4EpUT9V94+YmkxqoeuKH18OG863DBXBRhcwPM8yJbeJCUNSi7ij0Yd1UpxIcn1vXnT1F/BpXsD0iw5IbKtRaruBckxYmo8RaARAOV9M/wCRp/I6i5nqjSqJrNsWh1wZzAvDfcZYwpSEEgji9LpJmk2RS+Tx3gXHKyUEbMfsOtUcajbwkkhZHM2fLb41a7vHH0TpMbd8CwzlfEnXmn4AwnHdMglpfDTp6GV9QMGVwOtjDc25QmbEasR8kIWmTbJvflOAKwlpCZpN8OY4tjg6MkhoPmxKzmAWXhOeS2IkOmDwMfZ86ewD6UEjlJSmWlkrG1OKYxN2KuHbHH/iDx+/CSevUBxmtQFN2zixEYA3BNf1wR20BpvxR+SsEs9ALyBb5tH4ffbofECdLw0Uflyu/P0pS1cdIEZ/lVpgnMYMWNDQ7VSMYhYkU34snOynV47OKZZ2WNRHb79d0MfSkrJ5xmCGdbp9Z1HYPDW22dlDP8UAG82JDgEAJ1A9vsGpPatffcvL9Hz04BVpTuh5FEobc1UNi6qgynSMVKLdmTjdfCHUigdBqgPZS41r7O/K1iVJ2O2gBEzZsnUu77vW66g6/hlzX17ma+UjA/AhtSR7JPpLPcwH5t14dWyiv0/xC51CKH3DWV5EFLliD1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(3023799007)(56012099003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9CT55bhntmmUMKs224PUyyOeXThWgRc7tV0M9d5tASTWktQrWicaZVJ+5eUu?=
 =?us-ascii?Q?nbhNPRFUrJe8ILwe58b+dfQcgnnrqOvHiCDL10vMJEnTaQeJIma4IfvFYLt5?=
 =?us-ascii?Q?tDmACB1bTTrTZdprI6Jce3K7Hr7HTNKKrpZi68ujnqG67CotljTkCxlpKMex?=
 =?us-ascii?Q?jI9APkS51nK1CEALe3Vx5Zf6Q5dgtR7d1/uFAyTCiGW2SHEpVfwvNIkm8iXm?=
 =?us-ascii?Q?JiZDohARVkvjD3ors0mg3H0twqVuF/HJlOiD5GHZo+JMfejeFvqe9L+AiYj5?=
 =?us-ascii?Q?ecXxYMgs1e2xDRSFI6pgz/fsy9LmWTJzg1yLZXhkTUEmvj4bjNEh5rKZx+r3?=
 =?us-ascii?Q?e+s3b8wLggE6RSkWcB8idi8IRFwBhjKCUkuxhQhd0WaGbs8/rZcx8uWsCb3b?=
 =?us-ascii?Q?Ug9rKaPeuxSHQ1mVNvlXxXwHibbprX+f8G7+Zc6ixMYuqRZ3u8c7o1vuFCY2?=
 =?us-ascii?Q?PnOxZp21U5eS61QaHK7VsV5TlTVP6ww+mfJFjKpfl4USaZCwYBTuMqno8c+V?=
 =?us-ascii?Q?YQa6pMecRdv32GjcpgY/8kZxTn0aBAExn88H79/L4K8Ni90Fvfty7C2MZp0q?=
 =?us-ascii?Q?42oyOn+Qz44U8zH/jOmygPNiQ6mVuwffqzvV6D9Pz/S/FOTkE6lz3YxaBNIQ?=
 =?us-ascii?Q?L9/Pxxv9VTmjjdmpmy3J0gVVfrV2KyqzPzdu7/SIr/pJdbsbxpIwn6Dfkqda?=
 =?us-ascii?Q?B7wpi3MgSazs7Z6TUOpPyFtlANs4UqptuIJrTKbcyPcGx0ZA1IxTrp0vK3hW?=
 =?us-ascii?Q?/O12+gWXeoo5pvDv3Zd79twpz6NE4eOLP47/O3ou07C+U/oVohIqBQaIUjZ4?=
 =?us-ascii?Q?zw0QV7SfYmEJgZ2ul5CKQiUXZl5ofhpS+/V8qwgCUY28XdQy0Jmubt6ih8SE?=
 =?us-ascii?Q?+MYs5cW1xQJ+FS9Jz54xjJ6ts+GVeO39QVXHcLfw5Bet7UjA8oyrE73+Nbhx?=
 =?us-ascii?Q?rsheNPl6eZYkTTQvFU5PvVocF7opCFp5BHs+ri4gmx/8Z5gzzZ/SrdoqB7b6?=
 =?us-ascii?Q?+g8HwIxZ3FctQd7DVOOZxYAMBENo40GbwlydZRiLbzCEvuR1MixBDydw3sTY?=
 =?us-ascii?Q?VL4xDb4QTTwbWDRsjybAKZaUJ8XkxgCkwy9Bivp6DC6EmAUjBTBKgT9fPjxp?=
 =?us-ascii?Q?qIj6qDVPMlRfi5xCiJJ6Ae66wG7gqzBg0vHCjNSw68iaC8awiHnXfyKZpgsd?=
 =?us-ascii?Q?Ute5LyY6Li9Uc2ho+fiy0uuYJlCkUNQ5PSdK3AbhbSZO2y0mJwpcSiNg7tfs?=
 =?us-ascii?Q?X3D8ZnL6XfyTyjL9w5XlrIdwrQCwXPnLjfZiujsea5sgWELF5vIJLRURIbXW?=
 =?us-ascii?Q?ghXD+tcyqMigYbQEYDcRUkANzj8dHeDi3+sqWN+tCYJnKWuVA1aLJWnMiwtO?=
 =?us-ascii?Q?PUzOSPSLojF7ETgjZrssEZ/DGQS0V6gtk7g4mU97R7jHt/68g6LMZOuU8nG7?=
 =?us-ascii?Q?l2QegkRXakwIBfQk+84bpYfiKIZeuAa13prOde8HautLrVFuRxntvOk69lo4?=
 =?us-ascii?Q?75uUGY6Ywyj3ZM/4Rdh5hkOAitaVKKGIjz7uQRBhWQrw31ukFNYjaOHGp5QD?=
 =?us-ascii?Q?LTURnE1LRcDI3AzsTEkTLmNU42bk6vCMsVCOw6PcC1KepaNyB7MykZl89/ie?=
 =?us-ascii?Q?7c7D3aLN5N1qqP3zNWn1rcwe7hS1TRCaJ/2H34nhhU+GQMXg+dTy/jsIVKuK?=
 =?us-ascii?Q?OWqLfwdcohtaMYnJpEd132eBeqeYzT/rPBZwEsXAWBnxpjxp1fxyCKISKj7m?=
 =?us-ascii?Q?jlboGhYivA=3D=3D?=
X-Exchange-RoutingPolicyChecked: sTVdrtYYanBZEYBOZiRgiCUgPr/LfMM58gvNx5H1cHObYvs8m8YISRQ2E0blP3bTJvDONS7wcN27DXT3dV2LQfkGCJT1Xp0g7cB/JE/U1kGqHlcm3+dyglnEfR4eEg7NisVGgazZh5w5W18I17gzRZ5Yo5kfw2GXjDttKuK8JIKC+bwyXXHgrCb4uGpZhzcFNSix7LWSqaXUG07mFuaYNuMQyaUdI6QzsGsTih6W+m5BFF8fxpjo13M+jldJ7N6Og5JhW4QfhmOWe1ni9Is7cg+COp54tBx1J5ORiBhH6rUtnnSrF06E2baxSmWjr2lF6vQKvs41fQmyRFYAXFiEzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f197f4a-56ef-4a05-8361-08deb8d584ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 14:13:53.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgxoM9gcFMTVz1kxQpU74m1XmSlOlugIDh1AUh9JESuUQk1JAlVvAT7kFelBrofv385jq0xkULp75NIt4Ef0Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI" on:

commit: f93c013feebc74afe81ce1ffd045c1625b86c4ce ("[PATCH v1 1/4] driver core: allow certain drivers prohibit override via sysfs")
url: https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/driver-core-allow-certain-drivers-prohibit-override-via-sysfs/20260513-124947
patch link: https://lore.kernel.org/all/20260508095224.1275645-2-andriy.shevchenko@linux.intel.com/
patch subject: [PATCH v1 1/4] driver core: allow certain drivers prohibit override via sysfs

in testcase: boot

config: x86_64-rhel-9.4-kunit
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605231602.b6990b2a-lkp@intel.com



[   98.674811][ T2697] ppdev: user-space parallel port driver
[   98.682051][ T2693] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[   98.749342][ T2701] Error: Driver 'pcspkr' is already registered, aborting...
[   98.754059][ T2699] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   98.754984][ T2699] cdrom: Uniform CD-ROM driver Revision: 3.20
[   98.756646][ T2690] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
[   98.757883][ T2690] KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
[   98.758816][ T2690] CPU: 1 UID: 0 PID: 2690 Comm: udevd Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
[   98.759772][ T2690] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   98.760884][ T2690] RIP: 0010:bus_remove_device (kbuild/src/drivers/base/bus.c:656 (discriminator 1))
[   98.761606][ T2690] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 dc 01 00 00 48 ba 00 00 00 00 00 fc ff df 48 8b 43 68 48 8d 78 21 48 89 f9 48 c1 e9 03 <0f> b6 14 11 48 89 f9 83 e1 07 38 ca 7f 08 84 d2 0f 85 84 01 00 00
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 dc 01 00 00    	jne    0x1ed
  11:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  18:	fc ff df 
  1b:	48 8b 43 68          	mov    0x68(%rbx),%rax
  1f:	48 8d 78 21          	lea    0x21(%rax),%rdi
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
  2a:*	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx		<-- trapping instruction
  2e:	48 89 f9             	mov    %rdi,%rcx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	38 ca                	cmp    %cl,%dl
  36:	7f 08                	jg     0x40
  38:	84 d2                	test   %dl,%dl
  3a:	0f 85 84 01 00 00    	jne    0x1c4

Code starting with the faulting instruction
===========================================
   0:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   4:	48 89 f9             	mov    %rdi,%rcx
   7:	83 e1 07             	and    $0x7,%ecx
   a:	38 ca                	cmp    %cl,%dl
   c:	7f 08                	jg     0x16
   e:	84 d2                	test   %dl,%dl
  10:	0f 85 84 01 00 00    	jne    0x19a
[   98.763619][ T2690] RSP: 0018:ffffc9000075efd0 EFLAGS: 00010202
[   98.764294][ T2690] RAX: 0000000000000000 RBX: ffff8881d0677010 RCX: 0000000000000004
[   98.765179][ T2690] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000021
[   98.766066][ T2690] RBP: ffff888100348c00 R08: 0000000000000001 R09: ffffed1020060f55
[   98.766979][ T2690] R10: ffff888100307aaf R11: fffffffface0012b R12: ffffffffb0964be0
[   98.767842][ T2690] R13: 1ffff920000ebdfc R14: ffff888100348c58 R15: ffff8881d0677060
[   98.768702][ T2690] FS:  00007fb9b77bc300(0000) GS:ffff88876b59b000(0000) knlGS:0000000000000000
[   98.769674][ T2690] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   98.770377][ T2690] CR2: 00007fb9b77898e0 CR3: 000000023c500000 CR4: 00000000000406f0
[   98.771294][ T2690] Call Trace:
[   98.771694][ T2690]  <TASK>
[   98.772063][ T2690]  ? __pfx_bus_remove_device (kbuild/src/drivers/base/bus.c:623)
[   98.772686][ T2690]  ? __pfx_device_remove_attrs (kbuild/src/drivers/base/core.c:3073)
[   98.773297][ T2690]  device_del (kbuild/src/drivers/base/core.c:3891)
[   98.773787][ T2690]  ? __pfx_device_del (kbuild/src/include/linux/kobject.h:89)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260523/202605231602.b6990b2a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

