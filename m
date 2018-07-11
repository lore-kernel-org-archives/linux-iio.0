Return-Path: <SRS0=jkej=J3=onstation.org=masneyb@kernel.org>
Date: Wed, 11 Jul 2018 06:31:29 -0400
From: Brian Masney <masneyb@onstation.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
	andy.gross@linaro.org, david.brown@linaro.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, jonathan@marek.ca,
	jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
	bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180711103129.ql4txni63i2m7m4r@d08157822050>
References: <20180711010932.20313-1-masneyb@onstation.org>
 <20180711010932.20313-3-masneyb@onstation.org>
 <20180711100442.GA30019@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711100442.GA30019@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 11, 2018 at 03:34:43PM +0530, Himanshu Jha wrote:
> Hi Brain,
> 
> On Tue, Jul 10, 2018 at 09:09:31PM -0400, Brian Masney wrote:
> > This patch adds support for the regulator framework to the mpu6050
> > driver.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > ---
> >  }
> >  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
> >  
> > +int inv_mpu_core_remove(struct inv_mpu6050_state *st)
> > +{
> > +	return regulator_disable(st->vddio_supply);
> > +}
> EXPORT_SYMBOL_GPL(inv_mpu_core_remove); ?
> 
> This is causing 0-day test build failure perhaps.

You are right. It compiles if I have CONFIG_INV_MPU6050_IIO built into
the kernel, which is what I'm using to boot the board, but fails when
compiled as a module. Good catch 0-day!

The patch won't apply to Linus's current master branch and I assumed
that iio/togreg didn't have the required changes as well. Sorry about
the noise.

I'll send a v2 before the weekend.

Brian
