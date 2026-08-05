Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2642E3FE;
	Wed,  5 Aug 2026 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890022; cv=none; b=MMbMz+w95l+Tr/b7zVX9CmPSGQr1EjxPJr1uMwJ3rPidKwpKjvdo4e+G3DSbIXdvmlOyXrXgz9i5tbSVDyZr+CgovTUsdyzz+YyfUnO4UJiLrHi7L6d93ot8kjQQ/XObFJUfim9rJ926St0LkIzS7apoDLtZ++raVvC5O6Mwznc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890022; c=relaxed/simple;
	bh=S/wEKZwN9oj83+4uNZtAximyr7S7iepImeaKpOEJdic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0cyjTwBn5UFdIs5qyyx7eZn45lgcYgMn2cm9DU1LFakV+IjsMHg9gt1SyPibmPzyYCLbAxEzgD41fkGS88iW6rZA972F7U7dbaVNVrhBECES5I1KbLstVJgx0qs64ZeDMAYSw002JvbJET+61IKAOogQWf+pWQ9Fd6lL+XTFKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsAE/KR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsAE/KR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8461F000E9;
	Wed,  5 Aug 2026 00:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890020;
	bh=jf/xVNbWPols23hslUUwD7fcUT/RrrsqrpMbZwK78iA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZsAE/KR5jsl+73ewpPJ90yFlmGYeO7a/wU07gbrHhMBmdf2F7ePh3+D6jz4/Yvg+N
	 675vAD3SbnXCak/e6mSmhMiirV3WDfNQEA2LDct1FWFIuqG+MNwHTbruXgTZbbWtc6
	 MjuMfKZ/wyvQ0Kd+VFExQUnJyMNZ31FnnYVilc6wfpN8Y6QapN+M/XcDG3My7JaY3S
	 f0NwSVZ50X7wH3OHI4nJI1uCw5K+6hRv/gDBJBV/KvkvspNC0xGWkbGohBhhbGBZQv
	 yXlRidHfTfUNxbqlME8YG9BJw8RxuHD6fKpCPpEJhRP3jfYi0XLE6MtCpYBITsXgTI
	 lxGgiv42yPQkQ==
Date: Wed, 5 Aug 2026 01:33:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec
Message-ID: <20260805013336.4bd8a298@jic23-huawei>
In-Reply-To: <202608041404.bOHh2XuT-lkp@intel.com>
References: <202608041404.bOHh2XuT-lkp@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Aug 2026 14:24:23 +0800
kernel test robot <lkp@intel.com> wrote:

> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec  Add linux-next specific files for 20260803
> 
> Unverified Error/Warning (likely false positive, kindly check if interested):
> 
>     https://lore.kernel.org/oe-kbuild/202608040800.45L57Mym-lkp@intel.com
> 
>     drivers/iio/magnetometer/qmc6308.c:402:7: error: call to '__compiletime_assert_472' declared with 'error' attribute: FIELD_PREP: value too large for the field

The line in question is setting a 2 bit field (GENMASK(3, 2)) to 0.
No idea what is triggering that warning.

>     drivers/net/ethernet/airoha/airoha_eth.c:3470:25: sparse: sparse: division by zero
> 
> Error/Warning ids grouped by kconfigs:
> 
> recent_errors
> |-- arm-randconfig-r121-20260803
> |   `-- drivers-net-ethernet-airoha-airoha_eth.c:sparse:sparse:division-by-zero
> `-- um-randconfig-002-20260803
>     `-- drivers-iio-magnetometer-qmc6308.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:FIELD_PREP:value-too-large-for-the-field
> 
> elapsed time: 726m
> 
> configs tested: 100
> configs skipped: 1
> 
> tested configs:
> alpha                            allnoconfig    gcc-16.1.0
> alpha                           allyesconfig    gcc-16.1.0
> alpha                              defconfig    gcc-16.1.0
> arc                             allmodconfig    gcc-16.1.0
> arc                             allyesconfig    gcc-16.1.0
> arc                  randconfig-001-20260804    gcc-15.2.0
> arc                  randconfig-002-20260804    gcc-8.5.0
> arm                  randconfig-001-20260804    gcc-10.5.0
> arm                  randconfig-002-20260804    gcc-15.2.0
> arm                  randconfig-003-20260804    clang-17
> arm                  randconfig-004-20260804    gcc-8.5.0
> arm64                randconfig-001-20260804    clang-24
> arm64                randconfig-002-20260804    gcc-9.5.0
> arm64                randconfig-003-20260804    gcc-11.5.0
> arm64                randconfig-004-20260804    gcc-9.5.0
> csky                            allmodconfig    gcc-16.1.0
> csky                 randconfig-001-20260804    gcc-9.5.0
> csky                 randconfig-002-20260804    gcc-11.5.0
> hexagon              randconfig-001-20260804    clang-24
> hexagon              randconfig-002-20260804    clang-24
> i386                            allmodconfig    gcc-14
> i386                buildonly-randconfig-001    gcc-14
> i386       buildonly-randconfig-001-20260804    clang-22
> i386       buildonly-randconfig-002-20260804    clang-22
> i386       buildonly-randconfig-003-20260804    clang-22
> i386       buildonly-randconfig-004-20260804    gcc-12
> i386       buildonly-randconfig-005-20260804    clang-22
> i386       buildonly-randconfig-006-20260804    gcc-14
> i386                 randconfig-001-20260804    gcc-14
> i386                 randconfig-002-20260804    gcc-14
> i386                 randconfig-003-20260804    gcc-14
> i386                 randconfig-004-20260804    gcc-14
> i386                 randconfig-005-20260804    gcc-14
> i386                 randconfig-006-20260804    clang-22
> i386                 randconfig-007-20260804    gcc-14
> i386                 randconfig-011-20260804    clang-22
> i386                 randconfig-012-20260804    gcc-14
> i386                 randconfig-013-20260804    clang-22
> i386                 randconfig-014-20260804    gcc-14
> i386                 randconfig-015-20260804    clang-22
> i386                 randconfig-016-20260804    gcc-13
> i386                 randconfig-017-20260804    clang-22
> loongarch                          defconfig    clang-24
> loongarch            randconfig-001-20260804    clang-24
> loongarch            randconfig-002-20260804    gcc-16.1.0
> nios2                           allmodconfig    gcc-11.5.0
> nios2                            allnoconfig    gcc-11.5.0
> nios2                randconfig-001-20260804    gcc-8.5.0
> nios2                randconfig-002-20260804    gcc-11.5.0
> parisc                          allmodconfig    gcc-16.1.0
> parisc                          allyesconfig    gcc-16.1.0
> parisc                             defconfig    gcc-16.1.0
> parisc               randconfig-001-20260804    gcc-8.5.0
> parisc               randconfig-002-20260804    gcc-8.5.0
> powerpc                      eiger_defconfig    clang-24
> powerpc              randconfig-001-20260804    clang-24
> powerpc              randconfig-002-20260804    gcc-11.5.0
> powerpc64            randconfig-001-20260804    gcc-8.5.0
> powerpc64            randconfig-002-20260804    gcc-8.5.0
> riscv                randconfig-002-20260804    gcc-13.4.0
> s390                 randconfig-001-20260804    clang-21
> s390                 randconfig-002-20260804    clang-18
> sh                                 defconfig    gcc-16.1.0
> sh                   randconfig-001-20260804    gcc-16.1.0
> sh                   randconfig-002-20260804    gcc-16.1.0
> sparc                randconfig-001-20260804    gcc-16.1.0
> sparc                randconfig-002-20260804    gcc-16.1.0
> sparc64              randconfig-001-20260804    clang-24
> sparc64              randconfig-002-20260804    clang-20
> um                   randconfig-001-20260804    gcc-14
> um                   randconfig-002-20260804    gcc-14
> x86_64              buildonly-randconfig-001    gcc-12
> x86_64     buildonly-randconfig-001-20260804    gcc-14
> x86_64     buildonly-randconfig-002-20260804    clang-22
> x86_64     buildonly-randconfig-003-20260804    gcc-14
> x86_64     buildonly-randconfig-004-20260804    gcc-14
> x86_64     buildonly-randconfig-005-20260804    clang-22
> x86_64     buildonly-randconfig-006-20260804    clang-22
> x86_64                                 kexec    clang-22
> x86_64               randconfig-001-20260804    gcc-14
> x86_64               randconfig-002-20260804    gcc-13
> x86_64               randconfig-003-20260804    clang-22
> x86_64               randconfig-004-20260804    clang-22
> x86_64               randconfig-005-20260804    gcc-14
> x86_64               randconfig-006-20260804    clang-22
> x86_64               randconfig-011-20260804    clang-22
> x86_64               randconfig-012-20260804    gcc-14
> x86_64               randconfig-013-20260804    clang-22
> x86_64               randconfig-014-20260804    clang-22
> x86_64               randconfig-015-20260804    clang-22
> x86_64               randconfig-016-20260804    clang-22
> x86_64               randconfig-071-20260804    gcc-14
> x86_64               randconfig-072-20260804    gcc-14
> x86_64               randconfig-073-20260804    gcc-14
> x86_64               randconfig-074-20260804    gcc-12
> x86_64               randconfig-075-20260804    gcc-14
> x86_64               randconfig-076-20260804    clang-22
> x86_64                          rhel-9.4-bpf    gcc-14
> xtensa               randconfig-001-20260804    gcc-8.5.0
> xtensa               randconfig-002-20260804    gcc-14.3.0
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

