Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F73E49F5;
	Tue,  4 Aug 2026 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824686; cv=none; b=INozVsuUQUJp49xnkesjWKnEBU6ld6KjucuNbHUOZu+i1TndLIj5pkQ8yOXsaf7O4zZ/8pJ8K0N7HVpCIhGZI3rMpsHgMy463f1j5YFal+jOFxiQOdsKjnmHTMvQZCJMIw1Pllf5K0JHoYKGQ+ZXPcWYikfF8+nV2EtySxeMDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824686; c=relaxed/simple;
	bh=KKZFpNziv8p8HKPLsoOocbI9p7wTHRY7703zAFRVqFM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IXhQfnxSa1QOhlFnO25oUSOua9DFoYylz/mdevOKxpMKyrikiuX0V3VoDi5ihNN8sd+8adRulu5AnQ/zVs2SctfdF/kncn/hJK23Ke9MFdCFIpnW8TxhjRYNnwGEt26fIYPPIahMTAU53ORJ36PXV8aicOOXpGUJMgpZ73HOTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRBQuaXc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRBQuaXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785824684; x=1817360684;
  h=date:from:to:cc:subject:message-id;
  bh=KKZFpNziv8p8HKPLsoOocbI9p7wTHRY7703zAFRVqFM=;
  b=jRBQuaXcHv+jtggjffiFHpd3ZoKS+eeL32LLqLR/PCBlFs57zufmaasI
   4LaI7E0KWuWhaNhDA+Y21WU+vDMgp0rFCdOmscj+i40/QRZIAAqW2zAZ9
   T7RvT7OqHcSpIuUXj8S2Lf0GdHsn31BCVgCr6dSOkLZtTV/miHObWYx+k
   kC851gh4uDdkjTMOvZUUhWZDwgvmxTtS/YBZpcWytuzO3oDnR4oScmMiv
   pHIe9yclA3x9FAlTfMpiBjbfCNmOEvHrB969aKULKbf6A6EkpN/AV50ok
   FiI3tIwd05V3TrpaSQTbtGk484NzWc+H6XnnC1cJUI3dktlVHsXKRHECK
   Q==;
X-CSE-ConnectionGUID: vM8Fu5QqQGCOdzzRqWt9+g==
X-CSE-MsgGUID: D/6Qv+MyTmOGyGLc+rdinQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90179417"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90179417"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 23:24:42 -0700
X-CSE-ConnectionGUID: COFkYOwiRDeMNnPUy81RQg==
X-CSE-MsgGUID: WbO2gSoCTg+tnth5R6yU4Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Aug 2026 23:24:39 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr8Zp-0000000097p-0Ov6;
	Tue, 04 Aug 2026 06:24:37 +0000
Date: Tue, 04 Aug 2026 14:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD REGRESSION
 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec
Message-ID: <202608041404.bOHh2XuT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec  Add linux-next specific files for 20260803

Unverified Error/Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202608040800.45L57Mym-lkp@intel.com

    drivers/iio/magnetometer/qmc6308.c:402:7: error: call to '__compiletime_assert_472' declared with 'error' attribute: FIELD_PREP: value too large for the field
    drivers/net/ethernet/airoha/airoha_eth.c:3470:25: sparse: sparse: division by zero

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-r121-20260803
|   `-- drivers-net-ethernet-airoha-airoha_eth.c:sparse:sparse:division-by-zero
`-- um-randconfig-002-20260803
    `-- drivers-iio-magnetometer-qmc6308.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:FIELD_PREP:value-too-large-for-the-field

elapsed time: 726m

configs tested: 100
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260804    gcc-15.2.0
arc                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-001-20260804    gcc-10.5.0
arm                  randconfig-002-20260804    gcc-15.2.0
arm                  randconfig-003-20260804    clang-17
arm                  randconfig-004-20260804    gcc-8.5.0
arm64                randconfig-001-20260804    clang-24
arm64                randconfig-002-20260804    gcc-9.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-004-20260804    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260804    gcc-9.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
hexagon              randconfig-001-20260804    clang-24
hexagon              randconfig-002-20260804    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260804    clang-22
i386       buildonly-randconfig-002-20260804    clang-22
i386       buildonly-randconfig-003-20260804    clang-22
i386       buildonly-randconfig-004-20260804    gcc-12
i386       buildonly-randconfig-005-20260804    clang-22
i386       buildonly-randconfig-006-20260804    gcc-14
i386                 randconfig-001-20260804    gcc-14
i386                 randconfig-002-20260804    gcc-14
i386                 randconfig-003-20260804    gcc-14
i386                 randconfig-004-20260804    gcc-14
i386                 randconfig-005-20260804    gcc-14
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-007-20260804    gcc-14
i386                 randconfig-011-20260804    clang-22
i386                 randconfig-012-20260804    gcc-14
i386                 randconfig-013-20260804    clang-22
i386                 randconfig-014-20260804    gcc-14
i386                 randconfig-015-20260804    clang-22
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260804    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    clang-24
loongarch            randconfig-002-20260804    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-8.5.0
nios2                randconfig-002-20260804    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
powerpc                      eiger_defconfig    clang-24
powerpc              randconfig-001-20260804    clang-24
powerpc              randconfig-002-20260804    gcc-11.5.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
riscv                randconfig-002-20260804    gcc-13.4.0
s390                 randconfig-001-20260804    clang-21
s390                 randconfig-002-20260804    clang-18
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260804    gcc-16.1.0
sh                   randconfig-002-20260804    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260804    clang-24
sparc64              randconfig-002-20260804    clang-20
um                   randconfig-001-20260804    gcc-14
um                   randconfig-002-20260804    gcc-14
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260804    clang-22
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260804    clang-22
x86_64     buildonly-randconfig-006-20260804    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-002-20260804    gcc-13
x86_64               randconfig-003-20260804    clang-22
x86_64               randconfig-004-20260804    clang-22
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-006-20260804    clang-22
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-012-20260804    gcc-14
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-016-20260804    clang-22
x86_64               randconfig-071-20260804    gcc-14
x86_64               randconfig-072-20260804    gcc-14
x86_64               randconfig-073-20260804    gcc-14
x86_64               randconfig-074-20260804    gcc-12
x86_64               randconfig-075-20260804    gcc-14
x86_64               randconfig-076-20260804    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-8.5.0
xtensa               randconfig-002-20260804    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
