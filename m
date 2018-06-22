Return-Path: <SRS0=GMJS=JI=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 22 Jun 2018 19:54:35 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
	pmeerw@pmeerw.net, daniel.baluta@gmail.com
Subject: Re: [RFC 2/3] iio: imu: bme680: Add temperaure, pressure & humidity
 channels
Message-ID: <20180622142435.GB17901@himanshu-Vostro-3559>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
 <1529562877-9357-3-git-send-email-himanshujha199640@gmail.com>
 <20180622144243.000040b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622144243.000040b9@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 22, 2018 at 02:42:43PM +0100, Jonathan Cameron wrote:
> On Thu, 21 Jun 2018 12:04:36 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > Add temperature,pressure,humidity channel function definitions to read
> > raw values from the channels in bme680_read_*() and calibrate them
> > to get the required readings in bme680_compensate_*() using the
> > calibration parameters. These calibration parameters(read-only) are
> > stored in the chip's NVM memory at the time of production and are
> > used to get compensated readings for various channels.
> > 
> > The various channels' oversampling ratio and IIR filter configurations
> > are handled by bme680_chip_config().
> > 
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> There are some small readability suggestions inline and other comments
> on what has sneaked into this patch from the previous one.
> 
> Otherwise, the only larger comment is:
> 
>    Don't abstract for the sake of abstraction.  Right now this driver is
>    targetting one part.  Adding an abstraction to make it easier to target
>    multiple parts just leads to more complex code for no benefit.
> 
>    It is easy to rework to add that abstraction at the point where it is
>    needed.

Thanks for all the feedback and I will address all those nits in future
patches.

Now, I already had designed the driver using Bosch API but somehow due
to Licensing issues couldn't use it and was forced to remove all those
stuff.

Since now I am free to use their compensation functions so all those
"TODO" shall be complete functions.

With these feedback I came to know I am in the correct direction and
will not "abstract" more.

Sorry for those silly mistakes.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
