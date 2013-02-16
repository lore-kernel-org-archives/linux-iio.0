Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41941 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3BPMqc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Feb 2013 07:46:32 -0500
Message-ID: <511F7FA5.7060805@kernel.org>
Date: Sat, 16 Feb 2013 12:46:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Getz, Robin" <robin.getz@analog.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Lars-Peter Clausen <lars-peter.clausen@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Userspace libs
References: <201302131412.58742.robin.getz@analog.com>
In-Reply-To: <201302131412.58742.robin.getz@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/13/2013 07:12 PM, Getz, Robin wrote:
> Jonathan:
> 
> We made an "iio-scope" - a real time visualiser which runs natively on the 
> embedded hardware. The application supports plotting of the captured data in 
> three different modes (time domain, frequency domain and constatation).
> 
> Description (and screen shots) are at:
> http://wiki.analog.com/resources/eval/user-guides/ad-fmcomms1-ebz/software/linux/applications/iio_scope
> 
> Source is at:
> https://github.com/analogdevicesinc/iio-oscilloscope
> 
> As you can see, it includes some of your code:
> https://github.com/analogdevicesinc/iio-oscilloscope/blob/master/iio_utils.h
> Which (I think) is still in ./staging/iio/Documentation/ [1]
> 
> We build on some of that:
> https://github.com/analogdevicesinc/iio-oscilloscope/blob/master/iio_utils.c
> 
> Which really isn't specific to the scope, and could be pushed to where ever we 
> decide the .h file lives (this is a question/suggestion).
> 
> We also have a network stack for IIO.
> http://wiki.analog.com/resources/tools-software/linux-software/iio_cmdsrv
> 
> https://github.com/analogdevicesinc/iio-cmdsrv
> 
> I would like to re-write some of the existing iio-utils.h (so iio device 
> context is managed by the application), to become a little more thread 
> friendly, and also merge in some of the networking piece - so when using a 
> headless embedded device - userspace doesn't need to change/manage things 
> much.
All the above looks good and it is very nice to have some non trivial
userspace support. I'll be happy to see any updates/cleanups to iio-utils.h
but keep in mind that it is only really meant to be a trivial in kernel
tree example.  The original plan was to have a separately maintained
userspace library to do things 'properly'. I guess it depends on exactly
what changes you are thinking of.    The networking stuff in particular
might introduce some non kernel dependencies that may or may not be a
problem.

> 
> Is there a list of other things people want to see from userspace? [2]
> 
Nope.  Probably should be though. Well volunteered!
Right now we don't really have a clean list of what people want on the
kernel side, just a lot of randomly scattered mailing list threads.

> -Robin
> 
> [1] Which reminds me - is this planned on moving out 
> of ./drivres/staging/iio/Documentation  into ./Documentation/iio ?
err.  Yes.  Keep forgetting to do it.  Ah well next cycle ;)
Lots of stuff still to move in general.
> 
> [2] I have been going through:
>   - zio-dump   http://www.ohwr.org/projects/zio/wiki/Readme
>   - Comedilib  various
> ?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
