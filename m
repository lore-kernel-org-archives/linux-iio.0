Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34419 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbcCAQCM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2016 11:02:12 -0500
Date: Tue, 1 Mar 2016 10:02:00 -0600
From: Michael Welling <mwelling@ieee.org>
To: jic23@jic23.retrosnub.co.uk
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de,
	linux-iio-owner@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160301160159.GB5484@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <20160301005032.GA15476@deathstar>
 <CAKi4VAKBOge=-DcT9S7+uZWUte3EFNQ95u-fHCudRXZHqYuE1w@mail.gmail.com>
 <20160301024217.GA12912@deathstar>
 <9d1f2caa068a7ad5d3fe3b3a5bc6af1e@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d1f2caa068a7ad5d3fe3b3a5bc6af1e@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 01, 2016 at 08:35:01AM +0000, jic23@jic23.retrosnub.co.uk wrote:
> On 01.03.2016 02:42, Michael Welling wrote:
> >On Mon, Feb 29, 2016 at 10:09:10PM -0300, Lucas De Marchi wrote:
> >>On Mon, Feb 29, 2016 at 9:50 PM, Michael Welling <mwelling@ieee.org>
> >>wrote:
> >>> On Fri, Feb 05, 2016 at 03:17:18PM +0200, Daniel Baluta wrote:
> >>>> The driver has sysfs readings with runtime PM support for power saving.
> >>>> It also offers buffer support that can be used together with IIO software
> >>>> triggers.
> >>>>
> >>>
> >>> Daniel,
> >>>
> >>> So I noticed something yesterday while testing new boards.
> >>> The channels are occassionally swapping when accessing data from multiple channels.
> >>>
> >>> I wrote a simple bash script to demonstrate.
> >>
> >>This happened to me in a previous version of the patch. I remember it
> >>being fixed in the last version (or at least I could not reproduce).
> >>I'll test again tomorrow with your script.
> >>
> >
> >Here is what I believe is happening.
> >
> >The request for a conversion on a new channel comes in while the
> >conversion
> >for the previous channel is still converting. The driver waits
> >approximately
> >one conversion cycle. The previous channel completes within this timeframe
> >and the MUX is changed and the new sample is started. The new sample is
> >still
> >converting and the driver returns the value from the previous conversion.
> >
> >For a test I multiplied the conv_time value by 2 in the
> >ads1015_get_adc_result
> >function. This allows time for the current sample flush out and always
> >returns
> >the appropriate channel's value.
> >
> >Looking at the buffered mode it appears that only one channel is being
> >accessed
> >at any time. This being the first one in the active_scan_mask found by
> >find_first_bit. So the MUX would never change is buffered mode as far I
> >can
> >tell.
> >
> >Don't we typically want to read all of enabled channels in buffered mode?
> In some devices that is effectively impossible (fifo's that fill only from
> the currently
> selected channel). That is what the onehot validation callback is about.
> In this particular case it looks like doing a multichannel read is fair bit
> more time
> consuming than a single channel read and so will result in a considerable
> reduction in
> throughput.  This is of course why many parts include a simple sequencer!

Yes the sampling rate would effectively be divided by the number of channels
enabled.

> 
> Anyhow, supporting multi channel buffered reads could be done (probably) but
> you
> would want to fall back to the single channel case as it is now.

Understood.

> 
> Jonathan
> >>Lucas De Marchi
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
