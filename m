Return-Path: <gregkh@suse.de>
Date: Fri, 4 Jun 2010 08:28:32 -0700
From: Greg KH <gregkh@suse.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] adis16400: fix some minor issues and clean-up
Message-ID: <20100604152832.GC25400@suse.de>
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com>
 <1275643194-25328-2-git-send-email-21cnbao@gmail.com>
 <1275643194-25328-3-git-send-email-21cnbao@gmail.com>
 <4C08DC46.8010907@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C08DC46.8010907@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 04, 2010 at 11:58:14AM +0100, Jonathan Cameron wrote:
> On 06/04/10 10:19, Barry Song wrote:
> > 1. move adis16400_spi_read_burst() to adis16400_ring.c since it is only
> >    called there
> > 2. add the lost calling to adis16400_self_test()
> > 3. codes cleanup
> > 
> Same issue with commit comment location

Same confusion on my part, what's wrong with this?  This is what should
be in the changelog, right?

thanks,

greg k-h
