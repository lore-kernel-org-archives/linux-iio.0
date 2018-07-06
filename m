Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:51847 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932709AbeGFR1u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Jul 2018 13:27:50 -0400
Date: Fri, 6 Jul 2018 18:27:37 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>
Subject: Re: [PATCH v2] iio: light: introduce si1133
Message-ID: <20180706182737.0000099d@huawei.com>
In-Reply-To: <20180703165329.ytueuawxlwqlh4pq@mbedesk.sonatest.net>
References: <20180626170109.13437-1-maxime.roussinbelanger@gmail.com>
        <20180630181854.1de97eec@archlinux>
        <20180703165329.ytueuawxlwqlh4pq@mbedesk.sonatest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 3 Jul 2018 12:53:30 -0400
Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com> wrote:

> On Sat, Jun 30, 2018 at 06:18:54PM +0100, Jonathan Cameron wrote:
> > On Tue, 26 Jun 2018 13:01:09 -0400
> > Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com> wrote:
> > 
> > Hi Maxime
> > 
> > Coming together nicely though a few minor things inline to add to Peter's
> > review.
> > 
> > It would make the device a lot more useful if we could provide a lux
> > measurement.  There is code out there to do this from the IR and ambient  + IR
> > channels, but licensing is going to be a potential issue. See inline.
> > 
> > Jonathan
> >   
> > > Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
> > > Reviewed-by: Jean-Francois Dagenais <dagenaisj@sonatest.com>
> > > ---
> > > Changes in v2:
> > > 	- Add ABI documentation
> > > 	- Drop part abstraction
> > > 	- Clean up error handling style
> > > 
> > >  .../ABI/testing/sysfs-bus-iio-light-si1133    |  57 ++
> > >  drivers/iio/light/Kconfig                     |  11 +
> > >  drivers/iio/light/Makefile                    |   1 +
> > >  drivers/iio/light/si1133.c                    | 809 ++++++++++++++++++
> > >  4 files changed, 878 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > >  create mode 100644 drivers/iio/light/si1133.c
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-si1133 b/Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > new file mode 100644
> > > index 000000000000..4533b5699c87
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > @@ -0,0 +1,57 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity0_ir_small_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Unit-less infrared intensity. The intensity is measured from 1
> > > +		dark photodiode. "small" indicate the surface area capturing
> > > +		infrared.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity1_ir_med_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Unit-less infrared intensity. The intensity is measured from 2
> > > +		dark photodiode. "med" indicate the surface area capturing
> > > +		infrared.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity2_ir_large_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Unit-less infrared intensity. The intensity is measured from 4
> > > +		dark photodiode. "large" indicate the surface area capturing
> > > +		infrared.  
> > 
> > I'll admit I'm lost.  Why would we use the different numbers of photodiodes?
> > I get that the device supports them, but if there is a combination that is 
> > normally right, I'd like that one to be the one we don't use an extended name
> > for (so generic code might look at it)
> >   
> 
> I have no idea which one is the "right" one. Someone with more "light" background 
> could help me here.
> 
> I can try to figure out which one seems like the "normal" one with some testing.

That would be great.

> 
...
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_uvindex25_deep_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		UV light intensity index measuring the human skin's response to
> > > +		deep ultraviolet (DUV) wavelength of sunlight weighted according
> > > +		to the standardised CIE Erythemal Action Spectrum.  
> > 
> > I think we need a new modifier for this one.  Please propose something suitable.
> > I doubt it'll be the last time we see a sensor measuring this!
> >   
> 
> I think something around "IIO_MOD_LIGHT_DUV" seems appropriate. It looks like a 
> lot of papers are using that acronym.
> 

Sounds good to me.


