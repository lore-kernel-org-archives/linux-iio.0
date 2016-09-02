Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34619 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755303AbcIBTPR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 15:15:17 -0400
Date: Fri, 2 Sep 2016 12:15:15 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ltc2485: add support for Linear Technology
 LTC2485 ADC
Message-ID: <20160902191513.GA13014@d830.WORKGROUP>
References: <20160825054829.GA15341@d830.WORKGROUP>
 <9e95a885-8078-fc00-6104-ead4684d9d4b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e95a885-8078-fc00-6104-ead4684d9d4b@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 29, 2016 at 05:01:14PM +0100, Jonathan Cameron wrote:
> On 25/08/16 06:48, Alison Schofield wrote:
> > Adds basic support for the LTC2485 ADC - a delta-sigma analog-to-digital
> > converter with an I2C interface that operates in single shot conversion
> > mode.
> > 
> > The driver supports an on board 5V reference and the power-on default
> > configuration which rejects both 50hz & 60hz line frequencies and
> > operates in 1x speed mode.
> > 
> > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > ---
> > Changes in v2:
> >   - changed the wait conversion time function to use monotonic rather than
> >     real time and to use milliseconds rather than nanoseconds.  
> >   - made conv time a constant int.
> > 
> > Same notes as in v1:
> > Reviewers: In addition to commenting on what is present, please comment
> > on what is absent and the priority in which you would like to see
> > additional features added to this driver, or needed in this first submittal.
> None of the below are needed for initially submital.
> All 'value' add features at the end of the day. Job one: get reading from
> ADC done :)
> 
> I made a few really small white space changes and applied this to the
> togreg branch of iio.git.  Will be initially pushed out as testing
> in a few minutes time to check the autobuilders can't find anything.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Not supported: 
> > 1. External Vref
> > 2. Additional Configuration Modes
> >         Temperature Sensor Mode: report temp data (not voltage).
> > 
> >         Line Frequency Rejection Mode: select to reject 50Hz or 60Hz
> > 	or both. (both is default)
> This is interesting... Will need some new ABI.  It's a filter so we probably
> want to try and fit it in with the existing filter ABI.  
> > 
> >         Speed Mode: Default speed mode (1x) performs two conversions each
> > 	cycle and combines the results.  2x speed mode only does one
> > 	conversion each cycle.
> Really simple case of oversampling.  So this one is easy ;)
> 
> > 3. Power management
> > 4. DT Bindings
> > 5. Triggered buffers
> Device is really slow, so no real rush on this one.  Nice to have for
> the convenience of using standard interfaces in libiio etc, but
> at 7sps reading sysfs will work fine for all usecases!
> 
> > 6. What else?
> Other power supply regulators..
> (allows complete power disabling if there is an appropriate controllable
> regulator on the board).
>
Thanks Jonathan!  
I need more direction on the power supply regulators. 

When you say power supply regulator, is that the same as reference
voltage?

The driver uses onboard vref now.  I see how I can add support for an
external vref.  But, it seems like maybe you are commenting that we can
have both, an external vref with an onboard vref as a fallback?  

Thanks,
alisons
