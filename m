Return-Path: <SRS0=9jsu=4R=onstation.org=masneyb@kernel.org>
Date: Thu, 11 May 2017 08:28:20 -0400
From: Brian Masney <masneyb@onstation.org>
To: Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH] iio: humidity: hts221: add power management support
Message-ID: <20170511122820.GA23072@607924cbbc93>
References: <20170510204005.2576-1-lorenzo.bianconi@st.com>
 <20170510205717.GA18948@607924cbbc93>
 <20170511093512.GA4932@ctocxl0005.oa.cto.st.com>
 <20170511105503.GA22606@607924cbbc93>
 <20170511111031.GB4932@ctocxl0005.oa.cto.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170511111031.GB4932@ctocxl0005.oa.cto.st.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 11, 2017 at 11:10:31AM +0000, Lorenzo BIANCONI wrote:
> On May 11, Brian Masney wrote:
> > On Thu, May 11, 2017 at 09:35:12AM +0000, Lorenzo BIANCONI wrote:
> > > > If desired, one way to get rid of the enabled flag would be to
> > > > add support for runtime power management to automatically shutdown
> > > > the chip after a period of inactivity. See
> > > > https://lkml.org/lkml/2017/4/25/101 for an example.
> > > > 
> > > 
> > > I am not a pm_runtime expert but according to the documentation runtime_suspend
> > > callback is called when device's usage counter and counter of 'active' children
> > > of the device are equal to 0. Moreover device possible states are 'disabled'
> > > (HTS221_REG_CNTRL1_ADDR register set to 0) or 'active' (HTS221_REG_CNTRL1_ADDR
> > > register configured with a given sample rate). In the first condition
> > > runtime_suspend() will not take any effect whereas in the latter one the
> > > callback will not be called since device's usage counter is grater than 0.
> > > Moreover implement system-wide pm support through runtime pm support just to
> > > avoid a boolean flag seems a little bit overkill to me. What do you think?
> > > Is my understanding correct?
> 
> Hi Brian,
> 
> > 
> > Sorry, I should have also said that I didn't think that runtime PM was
> > absolutely required. I also agree adding runtime PM just to remove the
> > flag is overkill. Runtime PM is nice to have if this sensor is hooked
> > up to something that may run off a battery (such as a weather station)
> > to help conserve power. The flag removal is a by product of this. :)
> > 
> > As for the runtime PM reference count, when your driver is initialized,
> > keep the device off so that the device usage count is initially zero.
> > Wrap your _write_raw() and _read_raw() functions with the runtime PM
> > calls and the device will power on and off as needed.
> 
> I mean ->runtime_suspend()/->runtime_resume() are never called by the PM core
> when the sensor is active since usage count is always grater than 0.
> On the contrary when usage count is equal to 0 the sensor is already disabled,
> so the ODR configuration does not make any difference.

Ohh, I see. That makes sense. Thanks for clarifying.

Brian
