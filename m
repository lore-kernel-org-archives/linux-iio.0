Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jun 2016 15:35:40 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] Second set of new device, new features and cleanups for
 IIO in the 4.8 cycle
Message-ID: <20160629223540.GA20281@kroah.com>
References: <37ca1a90-006f-8a58-e28d-401a3e13562f@kernel.org>
 <071b2c5d-5de4-48cf-81a8-b943084dce09@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <071b2c5d-5de4-48cf-81a8-b943084dce09@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 29, 2016 at 07:54:54PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> A few merge conflicts on this.  Two are the obvious choice.
> The third is in industrialio-trigger.c and you want the version that
> doesn't check for trig->ops (as it is no longer considered optional so
> must exist by that point).

Odd, I only had a conflict in a Kconfig and the .mailmap file.  Can you
check that I got this all right?

thanks,

greg k-h
