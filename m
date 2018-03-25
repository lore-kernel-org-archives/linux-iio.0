Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeCYQoH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Mar 2018 12:44:07 -0400
Date: Sun, 25 Mar 2018 17:44:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Message-ID: <20180325174401.43310fc1@archlinux>
In-Reply-To: <21395383-9236-4312-AA1A-3378F4E5B0BC@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <20180307200730.08ed3c2f@archlinux>
        <20180309003733.aichruo53vqryafg@smtp.gmail.com>
        <20180310151045.4570e85d@archlinux>
        <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
        <20180317203037.1093cc11@archlinux>
        <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
        <20180318122312.0d395367@archlinux>
        <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
        <20180324151829.7d03ad15@archlinux>
        <21395383-9236-4312-AA1A-3378F4E5B0BC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 16:06:17 -0700
John Syne <john3909@gmail.com> wrote:

This thread is becoming unmanageable so I am cropping this down to just
the questions that remain open.

> >> Probably easier to copy and paste this table into a spreadsheet. Let me know if there is anything I got wrong. Thank you again for all your help.  
> > Yeah, we need to shrink this if we do it again.  
> I’ll send an updated copy after this e-mail. Can you accept a spreadsheet 
> attachment or a CSV file?
We need to keep the discussion visible on list so it needs to stay in
plain text.  Just need to drop any columns we aren't caring about to make
it easier to read.
> > 
...
> >> 0x439C	CVAROS	in_powerreactive0_phaseC_offset		in	powerreactive	0	phaseC	offset	R/W	24	32 ZPSE	S	0x000000	Phase C total reactive power offset adjust (ADE7858, ADE7868, and ADE7878).
> >> 0x439D	AFWGAIN	in_power0_phaseA_fundamental_scale		in	power	0	phaseA_fundamental	scale	R/W	24	32 ZPSE	S	0x000000	Phase A fundamental active power gain adjust. Location reserved for ADE7854, ADE7858, and ADE7868.  
> > Hmm. Fundamental needs to be represented using a separate channel index
> > and description of the frequency filters applied.  That should map it
> > a generic way.  
> How do I do this?
Define additional channels with different index and for them
use the the infomask elements
IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY
and provide suitable values from the read_raw callbacks for that
channel.

...
> >> 0x43C0	AIRMS	in_current0_phaseA_rms		in	current	0	phaseA_rms		R	24	32 ZP	S	N/A4	Phase A current rms value.  
> > in_current0_phaseA_rms_raw as otherwise we don't know we need to apply
> > in_current0_phaseA_rms_scale to it (or the shared value that maps to that).  
> Yeah, this is still confusion to me. This should read in_current0_phaseA_rms_gain 
> as it directly affects the value in_current0_phaseA_rms_raw. We still have to apply
> a scale value to turn this cryptic number into something meaningful. 
So I'm a little lost. We have variable gain fine.
Does it effect the necessary scale factor to go from raw to real value or not?
1) Yes it does - then roll it as appropriate into the _scale attribute. 
   It should not be separated.  This often requires some interesting maths
   but is a onetime thing as the value isn't changing dynamically.

2) No it doesn't - then it is calibgain as it represents a necessary
   parameter to change the incoming circuit to compensate for external effects.

It is possible you have a mixture of the two and hence need both but that
is normally only the case with devices where the calibgain is about fixing
the factory calibration.

...
