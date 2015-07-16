Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1437031541-27249-1-git-send-email-ludovic.tancerel@maplehightech.com>
References: <1437031541-27249-1-git-send-email-ludovic.tancerel@maplehightech.com>
Date: Thu, 16 Jul 2015 10:54:45 +0300
Message-ID: <CAEnQRZCE5A0L_yqGOvC0-ZZG2L+JQTb1MOEKASANZgLBZu-2Jw@mail.gmail.com>
Subject: Re: [PATCH] iio: TSYS01, TSYS02D, HTU21, MS5637, MS8607 Measurement
 Specialties driver development
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	William Markezana <William.Markezana@meas-spec.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 16, 2015 at 10:25 AM, Ludovic Tancerel
<ludovic.tancerel@maplehightech.com> wrote:
> Hello all,
> this patch contains 5 drivers, including ms5637 that was proposed on a previous
> patch, but reworked for following reasons.
> As previously discussed with Jonathan, common part have been written to avoid
> code duplication. I hope the approach followed will please you.
> I tried to apply all previous feedback so hopefully, you will not have too
> much formatting problems to comment on.
>
> Few notes on the content.
> - HTU21 is already present in hwmon, however all the features wished by
> Meas-Spec and the reuse between other HW makes that I have added a new one in
> iio. Should the hwmon be removed in that case ?
> - There are things that can be commonalized with drivers ms5611/ms5607 pushed
> by Thomas. The proposal is to have this done once this patch is approved.
> - The HW resolution when configurable can be modified using SAMPLE_FREQ channel
> as requested to avoid private ABI.
> - Summary on HW :
> TSYS01 : I2C / SPI - Temp sensor (only I2C supported in this patch)
> TSYS02D : I2C only - Temp sensor
> HTU21 : I2C only - Temp & Humidity (T part common with TSYS02D)
> MS5637 : I2C only - Temp & Pressure
> MS8607 : I2C only - Temp, Pressure & Humidity sensor (T&P part comon with MS563$

Hi Ludovic,

Please split this in smaller patches.

One patch for the common part plus one patch per each new sensor.

Then you can send them as a patch series with a cover letter.

The cover letter [PATCH 0/N] should have a short summary of what this
is all about,
then [PATCH 1/N] should be the common part patch and finally [PATCH
2..N/N] should
contain the implementation for each new sensor.

Thus would be easier for us to review your patches.

thanks,
Daniel.
