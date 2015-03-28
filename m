Return-Path: <jic23@jic23.retrosnub.co.uk>
Message-ID: <5516B838.2040004@jic23.retrosnub.co.uk>
Date: Sat, 28 Mar 2015 14:18:32 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: kbuild test robot <fengguang.wu@intel.com>,
 Octavian Purdila <octavian.purdila@intel.com>
CC: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [iio:testing 10/10] ERROR: "__divdi3" [drivers/iio/accel/bmc150-accel.ko]
 undefined!
References: <201503282121.NkeMOw9e%fengguang.wu@intel.com>
In-Reply-To: <201503282121.NkeMOw9e%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 28/03/15 13:02, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   5e02849a682600c1663a333f95f0388d1c536108
> commit: 5e02849a682600c1663a333f95f0388d1c536108 [10/10] iio: bmc150_accel: add support for hardware fifo
> config: m68k-allmodconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 5e02849a682600c1663a333f95f0388d1c536108
>   # save the attached .config to linux build tree
>   make.cross ARCH=m68k 
> 
> All error/warnings:
> 
>>> ERROR: "__divdi3" [drivers/iio/accel/bmc150-accel.ko] undefined!
Oops, missed that.  I think we can use a simple do_div for computing the sample_period
(which included 64bit / 8 bit).

Will push out a patch to the testing branch to see if they autobuilders are
happy with it then fix up the driver properly if they are.

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index c639489671bb..d5e103b208ba 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -1002,7 +1002,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
         * To avoid this issue we compute the actual sample period ourselves
         * based on the timestamp delta between the last two flush operations.
         */
-       sample_period = (data->timestamp - data->old_timestamp) / count;
+       sample_period = (data->timestamp - data->old_timestamp);
+       do_div(sample_period, count);
        tstamp = data->timestamp - (count - 1) * sample_period;
 
        if (samples && count > samples)



> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
> 
