Return-Path: <greg@kroah.com>
Date: Tue, 23 Aug 2011 13:39:00 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: stufever@gmail.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, gregkh@suse.de,
	michael.hennerich@analog.com,
	Wang Shaoyan <wangshaoyan.pt@taobao.com>
Subject: Re: [PATCH] staging: IIO: DAC: Delete useless label error_ret in
 ad5791.c
Message-ID: <20110823203900.GL25977@kroah.com>
References: <1312654158-28057-1-git-send-email-wangshaoyan.pt@taobao.com>
 <4E44E99E.3070302@cam.ac.uk>
 <4E4536FE.40502@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E4536FE.40502@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 12, 2011 at 03:21:50PM +0100, Jonathan Cameron wrote:
> On 08/12/11 09:51, Jonathan Cameron wrote:
> > On 08/06/11 19:09, stufever@gmail.com wrote:
> >> From: Wang Shaoyan <wangshaoyan.pt@taobao.com>
> >>
> >>   drivers/staging/iio/dac/ad5791.c: In function 'ad5791_probe':
> >>   drivers/staging/iio/dac/ad5791.c:384: warning: label 'error_ret' defined but not used
> >>
> >> The label error_ret is defined, but never used, so delete it to avoid annoying warning.
> > As with other one, this is fixed in iio-blue.git, but I'm happy to see either version merge.
> I'm dozing.  This is the third fix for this one.  Greg, pick up which ever one you want!

It's now resolved in my tree.
