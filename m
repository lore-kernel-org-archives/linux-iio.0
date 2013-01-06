Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55811 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab3AFLcX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Jan 2013 06:32:23 -0500
Message-ID: <50E960C4.80208@kernel.org>
Date: Sun, 06 Jan 2013 11:32:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: James Peverill <arsenix@gmail.com>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: IIO for soft realtime control?
References: <loom.20130106T050717-736@post.gmane.org>
In-Reply-To: <loom.20130106T050717-736@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/06/2013 04:31 AM, James Peverill wrote:
> 
> I have been working on realtime robotics under Linux, and just learned about
> iio. It seems like many great hardware drivers are being written (some of which
> I had started working on in parallel), and it would be great if I could
> integrate what I am working on with iio. It seems mostly targeted at streaming
> data acquisition and output, but also includes triggering and event support. Has
> there been any thought to running realtime control loops using the iio
> subsystem? For this application I would be reading from sensors (i2c interface
> accelerometers etc) in the 10's of hz (ideally at least 50) and then updating
> actuator outputs.
> 
> Any thoughts on the feasibility? I would probably accomplish this by writing a
> kernel driver to glue the input iio devices to the output. I'm not sure what
> type of latency and jitter would result from this configuration, but this could
> limit the applications.
> 
I don't know of anyone else doing this with IIO at the moment (though someone may
well shout out in the near future!)

So based on 5 mins of thinking about it the situation at the moment is...

We handle streaming inputs reasonably well and the just merged in kernel 'buffer'
interfaces (which are really just hooks to get the stream of data from a device)
should allow a kernel module to get hold of this data fairly efficiently (certainly
50Hz shouldn't be a problem!).  We don't currently have interfaces for getting hold
of events in kernel though (threshold etc) but that should be fairly trivial to
add.

Unfortunately streaming support on the output side is not currently there.  Right now
you can set individual DAC outputs from other kernel drivers (though some nice
but trivial util functions might be missing) but buffered writing support isn't
there yet.  There is a lot of interest in adding this, but from what I recall there
are some 'interesting' issues with actually supporting precisely timed writes to
DAC chips (usually there is some dma involved).
Some spi implementations are capable of doing this I believe but there isn't any
kernel support for it as far as I know.
I'm guessing some DAC chips have hardware fifos (right now I can only find a TI
technote on a separate fifo for this purpose).

I've cc'd Lars and Michael because I know this sort of support is of interest to them
and they will doubtlessly be able to give some more informed comments!

If the buffered output were present then using IIO for real time control should
be straight forward.
>From the level of interest I've seen in this functionality support will definitely
occur at some point though this will happen faster obviously if someone
(no hints at all :) takes on implementing such support!

In the meantime, using IIO for your input drivers may make sense even if they
more involved actuator side comes later.  Or possibliy the slow current dac
interface will be 'good enough' timing wise for your application?

If you are able to, I'd love to hear more about your project, both in terms
of what you are doing (google gives me a fair idea as there aren't
many James Peverill's in the world ;) and in terms of the
control you are doing in kernel.

Jonathan
