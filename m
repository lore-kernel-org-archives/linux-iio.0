Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 9 Jul 2014 16:54:21 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Bastien Nocera <hadess@hadess.net>
cc: Jonathan Cameron <jic23@kernel.org>,
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
    Reyad Attiyat <reyad.attiyat@gmail.com>, linux-iio@vger.kernel.org,
    Benjamin Tissoires <benjamin.tissoires@redhat.com>,
    Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: User-space API for accelerometer(s)?
In-Reply-To: <1404916405.10032.3.camel@nuvo>
Message-ID: <alpine.DEB.2.01.1407091644570.15209@pmeerw.net>
References: <1403100542.30918.29.camel@nuvo>    <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>    <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>   <53A57414.8000104@kernel.org> <1404216616.7785.1.camel@nuvo>
 <53B59837.8080907@jic23.retrosnub.co.uk> <1404916405.10032.3.camel@nuvo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Bastian,

> > We did also have a uinput based approach at one point but it was fairly clunky.
> > That took data from iio buffers and pushed it back into the kernel via inputs
> > userspace driver support. Not particularly nice but I thought I'd best mention
> > it!
> 
> This is how I went in the end:
> https://github.com/hadess/iio-sensor-proxy/
> 
> It's still far too resource hungry compared to the amount of work it's
> doing (1 full percent of CPU!), and the rotation is too sensitive.

if I read the code correctly, prepare_output() configures the trigger, 
enables the buffer, then performs one read, before undoing everything FOR 
EACH SAMPLE

this is probably not the way it should be done; I'd suggest to set up the 
IIO buffer and then poll() or block on /dev/iio:deviceX -- however, this 
uses the IIO device exclusively (might be an issue)

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
