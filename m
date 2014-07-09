Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51989 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbaGIWQU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jul 2014 18:16:20 -0400
Message-ID: <1404944174.3519.1.camel@nuvo>
Subject: Re: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Reyad Attiyat <reyad.attiyat@gmail.com>,
	linux-iio@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 10 Jul 2014 00:16:14 +0200
In-Reply-To: <alpine.DEB.2.01.1407091644570.15209@pmeerw.net>
References: <1403100542.30918.29.camel@nuvo>
	    <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
	    <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>
	   <53A57414.8000104@kernel.org> <1404216616.7785.1.camel@nuvo>
	  <53B59837.8080907@jic23.retrosnub.co.uk> <1404916405.10032.3.camel@nuvo>
	 <alpine.DEB.2.01.1407091644570.15209@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey Peter,

On Wed, 2014-07-09 at 16:54 +0200, Peter Meerwald wrote:
> Hello Bastian,
> 
> > > We did also have a uinput based approach at one point but it was fairly clunky.
> > > That took data from iio buffers and pushed it back into the kernel via inputs
> > > userspace driver support. Not particularly nice but I thought I'd best mention
> > > it!
> > 
> > This is how I went in the end:
> > https://github.com/hadess/iio-sensor-proxy/
> > 
> > It's still far too resource hungry compared to the amount of work it's
> > doing (1 full percent of CPU!), and the rotation is too sensitive.
> 
> if I read the code correctly, prepare_output() configures the trigger, 
> enables the buffer, then performs one read, before undoing everything FOR 
> EACH SAMPLE

I based that code off Peter F. Patel-Schneider, and his yoga utilities,
and he probably got the idea from the generic_buffer.c example. It's not
clear what needs to be done there.

> this is probably not the way it should be done; I'd suggest to set up the 
> IIO buffer and then poll() or block on /dev/iio:deviceX -- however, this 
> uses the IIO device exclusively (might be an issue)

I've now pushed a version that will do the setup once, and open/close
the iio device when needed, in the timeout.
 The daemon still shows up in top, but I couldn't make it register
enough activity to show up in sysprof, so I'm guessing that top just
isn't measuring the CPU usage accurately.

I still have to fix the overeagerness to switch orientations, and I'll
be done for now I think.

Cheers

