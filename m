Return-Path: <gregkh@suse.de>
Date: Fri, 4 Jun 2010 08:28:06 -0700
From: Greg KH <gregkh@suse.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] adis16300: fix some minor issues and clean-up
Message-ID: <20100604152806.GB25400@suse.de>
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com>
 <1275643194-25328-2-git-send-email-21cnbao@gmail.com>
 <4C08DBC5.1040206@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C08DBC5.1040206@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 04, 2010 at 11:56:05AM +0100, Jonathan Cameron wrote:
> On 06/04/10 10:19, Barry Song wrote:
> > 1. add delay between spi transfers
> > 2. move burst read to ring function
> > 3. clean-up
> I think I'm right in saying that, this lot will appear in the commit message.
> Comments like this should go below.

Yes, and that's good, it should be in the commit message, right?

thanks,

greg k-h
