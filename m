Return-Path: <SRS0=cMqV=ME=gmail.com=songqiang1304521@kernel.org>
Date: Sat, 22 Sep 2018 18:04:19 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Clean up redundant code.
Message-ID: <20180922100419.GA25620@Eros>
References: <20180920141321.15251-1-songqiang1304521@gmail.com>
 <201809211608.bVz8vg0N%fengguang.wu@intel.com>
 <20180921182616.GA2077@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921182616.GA2077@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 21, 2018 at 11:56:16PM +0530, Himanshu Jha wrote:
> Hi Song,
> 
> On Fri, Sep 21, 2018 at 04:10:16PM +0800, kbuild test robot wrote:
> > Hi Song,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on iio/togreg]
> > [also build test ERROR on v4.19-rc4 next-20180920]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Song-Qiang/iio-magnetometer-hmc5843-Clean-up-redundant-code/20180921-091239
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > config: x86_64-randconfig-u0-09211331 (attached as .config)
> > compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ERROR: "hmc5843_volatile_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> > >> ERROR: "hmc5843_readable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> > >> ERROR: "hmc5843_writable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> 
> You would need to export these above symbols using EXPORT_SYMBOL()
> to be used by i2c/spi modules.
> 
> But on the other hand, exporting too many symbols is a bad idea since
> it is only used for this driver and not at any other place in IIO.
> So, in my opinion drop this patch and leave the code as-is.
> 
> https://lkml.org/lkml/2018/7/16/566 --> worth reading
> 
> 
> Thanks
> -- 
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology

Hi Himanshu,

You're right, that's exactly what I was missing!
I saw the link you mentioned above and I also think that's a very good
idea to limit the scope of symbols. But I don't know when this work can
be applied to the kernel, as it seems like a not little change for the
build infrastructure.
I think this maybe a common problem for some drivers.
Divers for bmc150 in drivers/iio/accel/bmc-150-accel-core.c did the same
exporting stuff as I was prefered. So I think even if either exporting or
duplicating is not good enough, one must be choosed for now.

I think this is a topic that I have some ideas but not experienced
enough to say what should we do is better. I would like to hear Jonathan's
ideas about this. If this patched shouldn't be applied, then maybe bmc150
should be patched.

yours,
Song Qiang
