Return-Path: <SRS0=FFsA=LD=gmail.com=himanshujha199640@kernel.org>
Date: Mon, 20 Aug 2018 23:25:22 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iio: chemical: bme680: use clamp macro
Message-ID: <20180820175522.GA8868@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
 <20180817190319.13119-2-dpfrey@gmail.com>
 <20180818110323.GB24920@himanshu-Vostro-3559>
 <20180819164706.4eab1634@archlinux>
 <8f7def1e-97d7-b8b4-bc5d-09d9478998f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8f7def1e-97d7-b8b4-bc5d-09d9478998f6@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 20, 2018 at 10:18:54AM -0700, David Frey wrote:
> On 8/19/2018 8:47 AM, Jonathan Cameron wrote:
> > On Sat, 18 Aug 2018 16:33:23 +0530
> > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> > 
> >> On Fri, Aug 17, 2018 at 12:03:13PM -0700, David Frey wrote:
> >>> Signed-off-by: David Frey <dpfrey@gmail.com>  
> >>
> >> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> >> Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.
> 
> Hi,
> 
> I'm trying to understand the linux-iio mailing list workflow a bit
> better.  I have
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git as my "iio"
> remote in my Linux kernel repository.  From that remote, I can see
> remotes/iio/togreg.  When I do a "git fetch", the togreg branch hasn't
> been updated.  Did Jonathan mean that he applied the patch to the togreg
> branch in his local repository, but hasn't yet pushed it to the one that
> I have listed above?  Are the "autobuilders" specific to IIO?  Is this
> infrastructure publicly accessible or is it only available to specific
> users?  If it's public, where can I view it/learn more about it?

The patches are currently in "testing" branch of iio.git repo.

The testing branch link is tracked by kbuild test robot at

0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Now, this testing service tracks *maintainers* trees and whenever they
push anything, the bot starts testing them in more than 200 different
kernel configuration and reports them with build reggression or success.
If there is a regression then the bot also bisects the bad commit and
sends it to the relevant people.

Also, apart from building/booting kernel it also tests through
sparse, smatch, coccinelle and others.

Smatch bugs are sent to Dan Carpenter(inventor of Smatch)
Coccinelle bugs are sent to Julia Lawall(inventor of Coccinelle)

AFAIK an year ago it used to do power management benchmarks and lots
of others but kernel community didn't want those. I got one of those
intimidating reports once with all those benchmarks.

Also, these services are *mostly* only available to maintainers since it
is most useful to them. Saves a lot of their time for compile testing and
you know how much would time it would take to do a `make allyesconfig'

I was luckly enough to get one of these services last year while working
with Luis R. Rodriguez.

But you can test on your own if you want, the code is freely available:
https://github.com/fengguang/lkp-tests

So, I expect Jonathan does the following:

1. apply and push patches to 'testing' branch.
2. As soon it is pushed, bot starts testing them and reports back.
3. If build success, then applies to 'togreg' branch.
4. If failure, then reports to the patch submitter.

Other than that I don't know what 'autobuilders' scripts he posses !?

See Fenggung Wu's reply:
https://lore.kernel.org/lkml/20180119014803.n75l5vrxlpifm3sc@wfg-t540p.sh.intel.com/

" Here are the complete list of 800+ trees we monitored:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/lkp-tests.git/tree/repo/linux "

Goddamn 800+ tress *__*

Sample report:
---------------------------------------------------------------------
Date: Sat, 18 Aug 2018 16:00:43 +0800
From: kbuild test robot <lkp@intel.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [himanshujha199640:20180817-dpfrey-cleanups-bme680] BUILD SUCCESS 5aad04740ef119704edf29f84714a7ae5b96f683
Message-ID: <5b77d22b.QBiWNTiXoXy+Kc/2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

tree/branch: https://github.com/himanshujha199640/linux-next  20180817-dpfrey-cleanups-bme680
branch HEAD: 5aad04740ef119704edf29f84714a7ae5b96f683  iio: chemical: bme680: simplify oversampling handling

elapsed time: 65m

configs tested: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
i386                   randconfig-x018-201832
i386                   randconfig-x017-201832
i386                   randconfig-x010-201832
i386                   randconfig-x016-201832
i386                   randconfig-x013-201832
i386                   randconfig-x011-201832
i386                   randconfig-x015-201832
i386                   randconfig-x019-201832
i386                   randconfig-x014-201832
i386                   randconfig-x012-201832
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-n0-201832
x86_64                 randconfig-x009-201832
x86_64                 randconfig-x000-201832
x86_64                 randconfig-x004-201832
x86_64                 randconfig-x001-201832
x86_64                 randconfig-x003-201832
x86_64                 randconfig-x007-201832
x86_64                 randconfig-x008-201832
x86_64                 randconfig-x005-201832
x86_64                 randconfig-x002-201832
x86_64                 randconfig-x006-201832
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-i0-201832
i386                     randconfig-i1-201832
i386                     randconfig-a0-201832
i386                     randconfig-a1-201832
x86_64                 randconfig-x019-201832
x86_64                 randconfig-x013-201832
x86_64                 randconfig-x017-201832
x86_64                 randconfig-x012-201832
x86_64                 randconfig-x018-201832
x86_64                 randconfig-x010-201832
x86_64                 randconfig-x014-201832
x86_64                 randconfig-x016-201832
x86_64                 randconfig-x011-201832
x86_64                 randconfig-x015-201832
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                     randconfig-s0-201832
i386                     randconfig-s1-201832
x86_64                           allmodconfig
i386                             allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201832
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                             allyesconfig
i386                   randconfig-x077-201832
i386                   randconfig-x076-201832
i386                   randconfig-x070-201832
i386                   randconfig-x075-201832
i386                   randconfig-x072-201832
i386                   randconfig-x074-201832
i386                   randconfig-x071-201832
i386                   randconfig-x078-201832
i386                   randconfig-x079-201832
i386                   randconfig-x073-201832
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x002-201832
i386                   randconfig-x003-201832
i386                   randconfig-x005-201832
i386                   randconfig-x008-201832
i386                   randconfig-x000-201832
i386                   randconfig-x007-201832
i386                   randconfig-x001-201832
i386                   randconfig-x004-201832
i386                   randconfig-x009-201832
i386                   randconfig-x006-201832
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
---------------------------------------------------------------------

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
