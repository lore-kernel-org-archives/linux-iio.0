Return-Path: <vilhelm.gray@gmail.com>
Date: Thu, 15 Sep 2016 10:03:43 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Implement counter channel type and info
 constants
Message-ID: <20160915140343.GA19015@sophia>
References: <bd7044c5088c8f0d445d236581de9b19c806bbfc.1473877757.git.vilhelm.gray@gmail.com>
 <201609152127.xNcZs3aX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <201609152127.xNcZs3aX%fengguang.wu@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 15, 2016 at 09:35:57PM +0800, kbuild test robot wrote:
>Hi William,
>
>[auto build test ERROR on iio/togreg]
>[also build test ERROR on v4.8-rc6 next-20160915]
>[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
>[Check https://git-scm.com/docs/git-format-patch for more information]
>
>url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Add-IIO-support-for-counter-devices/20160915-032651
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
>config: x86_64-randconfig-s1-09151924 (attached as .config)
>compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
>reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=x86_64 
>
>Note: the linux-review/William-Breathitt-Gray/Add-IIO-support-for-counter-devices/20160915-032651 HEAD 9dfaeb5dd7e5fffaedaaaa34c80c7790ed346b72 builds fine.
>      It only hurts bisectibility.
>
>All errors (new ones prefixed by >>):
>
>>> ld: cannot find drivers/iio/counter/built-in.o: No such file or directory
>
>---
>0-DAY kernel test infrastructure                Open Source Technology Center
>https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

I moved the creation of the "counter" subdirectory to this first patch,
but the 104-QUAD-8 driver is only added in the subsequent patch;
effectively, the non-populated Makefile in this patch leads to the
error.

I'll submit version 3 of this patchset with the "counter" subdirectory
introduced in the same patch as the 104-QUAD-8 driver. That should
resolve this issue.

William Breathitt Gray
