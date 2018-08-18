Return-Path: <SRS0=Z3Ke=LB=gmail.com=himanshujha199640@kernel.org>
Date: Sat, 18 Aug 2018 16:47:50 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 7/7] iio: chemical: bme680: simplify oversampling
 handling
Message-ID: <20180818111750.GH24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
 <20180817190319.13119-8-dpfrey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817190319.13119-8-dpfrey@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 17, 2018 at 12:03:19PM -0700, David Frey wrote:
> Temperature, pressure and humidity all expose and oversampling setting
> that works in the same way.  Provide common handling for the
> oversampling sysfs attributes.
> 
> Signed-off-by: David Frey <dpfrey@gmail.com>

Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
Tested-by: Himanshu Jha <himanshujha199640@gmail.com>

Also, 0-day tested with build success!

Thanks

With this I don't think my patch:
https://lore.kernel.org/lkml/20180811102636.6171-1-himanshujha199640@gmail.com/
is useful any more since bme680_is_valid_oversampling()
does the work pehaps.

The best part of this patch is supplying direct values and removes
the amiguity around ilog2(), especially at probe, when supplying
default values.

Thanks David for the series.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
