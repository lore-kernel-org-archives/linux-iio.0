Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Correctness of acpi-als channel mask
Date: Mon, 21 Dec 2015 15:45:00 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
References: <CABFtUbQw0nH5LXf_+D5_mSBqEdAsKEbbLCmrD=VDfgosqcWq1w@mail.gmail.com> <201512210033.32862.marex@denx.de> <CABFtUbTggGGs7s0QtA=FeZx_ejwFHTBuxyhD8H_gmo9=R-HjwA@mail.gmail.com>
In-Reply-To: <CABFtUbTggGGs7s0QtA=FeZx_ejwFHTBuxyhD8H_gmo9=R-HjwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201512211545.00537.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Monday, December 21, 2015 at 11:08:55 AM, Gabriele Mazzotta wrote:
> 2015-12-21 0:33 GMT+01:00 Marek Vasut <marex@denx.de>:
> > On Saturday, December 19, 2015 at 05:09:33 PM, Jonathan Cameron wrote:
> >> On 17/12/15 20:32, Gabriele Mazzotta wrote:
> >> > Hi,
> >> > 
> >> > I have a question regarding the acpi-als driver.
> >> > 
> >> > Currently acpi-als uses IIO_CHAN_INFO_RAW to report the data coming
> >> > from the sensor. However, as per the ACPI specification [1] (section
> >> > 9.2.2), these values represent the ambient light illuminance expressed
> >> > in lux. Wouldn't IIO_CHAN_INFO_PROCESSED be more appropriate in this
> >> > case as the data are in theory pre-processed by the firmware of the
> >> > platform?
> >> 
> >> Looks like it to me as well.  Cc'd Marek and Martin.
> > 
> > Gotta say, I haven't looked at ACPI for a while now. My impression is
> > that these data are RAW and the system software can adjust them based on
> > the values in _ALR table. The result of that would be _PROCESSED I
> > think. But I might be entirely wrong.
> 
> I'm not sure of this. _ALR returns an ambient light illuminance to
> display luminance mapping that suggests how to adjust the screen
> backlight. There are then _ALC and _ALT which report the ambient light
> color chromaticity and the ambient light color temperature respectively.

ALC and ALT are optional I believe (at least I recall my crappy old hardware
on which I first implemented this didn't have them at all). Thanks for 
clarifying what the ALR means, I never really understood how that was supposed 
to work in the first place .

> So I don't think there are adjustments we can perform.

If you think _PROCESSED is more appropriate, I will not oppose it. At this 
point, you are the bigger expert on ALS :)

> >> > [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
> >> > 
> >> > Regards,
> >> > Gabriele
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-iio"
> >> > in the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
