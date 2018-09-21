Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44643 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391176AbeIVAQa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Sep 2018 20:16:30 -0400
Date: Fri, 21 Sep 2018 23:56:16 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: songqiang1304521@gmail.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Clean up redundant code.
Message-ID: <20180921182616.GA2077@himanshu-Vostro-3559>
References: <20180920141321.15251-1-songqiang1304521@gmail.com>
 <201809211608.bVz8vg0N%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201809211608.bVz8vg0N%fengguang.wu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Song,

On Fri, Sep 21, 2018 at 04:10:16PM +0800, kbuild test robot wrote:
> Hi Song,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.19-rc4 next-20180920]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Song-Qiang/iio-magnetometer-hmc5843-Clean-up-redundant-code/20180921-091239
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-randconfig-u0-09211331 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "hmc5843_volatile_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> >> ERROR: "hmc5843_readable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> >> ERROR: "hmc5843_writable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!

You would need to export these above symbols using EXPORT_SYMBOL()
to be used by i2c/spi modules.

But on the other hand, exporting too many symbols is a bad idea since
it is only used for this driver and not at any other place in IIO.
So, in my opinion drop this patch and leave the code as-is.

https://lkml.org/lkml/2018/7/16/566 --> worth reading


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
