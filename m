Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46239 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeILX3m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Sep 2018 19:29:42 -0400
Date: Wed, 12 Sep 2018 23:53:50 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Afonso Bordado <afonsobordado@az8.co>
Cc: kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
Message-ID: <20180912182350.GA13032@himanshu-Vostro-3559>
References: <20180911150011.31964-4-afonsobordado@az8.co>
 <201809121715.5Babt1QC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201809121715.5Babt1QC%fengguang.wu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Afonso,

On Wed, Sep 12, 2018 at 05:26:01PM +0800, kbuild test robot wrote:
> Hi Afonso,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.19-rc3 next-20180912]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Afonso-Bordado/iio-gyro-add-support-for-fxas21002c/20180912-084443
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "__divdi3" [drivers/iio/gyro/fxas21002c.ko] undefined!
> >> ERROR: "__udivdi3" [drivers/iio/gyro/fxas21002c.ko] undefined!

Hmm. This is nasty error that had hit me back and occurs when you
do 64 bit arithmetic in your code and assume it will also build for
32 bit environment(i386).

https://lists.01.org/pipermail/kbuild-all/2018-July/050481.html

But looking at the code seems like there is no such 64 bit division
which is why 0-day didn't inform you the exact line of error unlike
my case in above link.

And I suspect it may be originating from your code snippet:

#define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500U >> (scale)))

and looking at the implementation:

include/linux/iio/iio.h
/**
 * IIO_DEGREE_TO_RAD() - Convert degree to rad
 * @deg: A value in degree
 *
 * Returns the given value converted from degree to rad
 */
#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000000ULL)

This '/' operator might be the culprit!

Just for checking that the error, remove the macro declaration `FXAS21002C_SCALE`
plus its usage and re-cross compile using `make ARCH=i386`.

In my case I used the `div64_s64` function handles builds for both 32/64
arch accordingly.


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
