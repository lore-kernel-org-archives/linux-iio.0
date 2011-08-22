Return-Path: <maxin.john@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E523F8D.8080902@cam.ac.uk>
References: <20110822100824.GA6671@maxin>
	<4E523F8D.8080902@cam.ac.uk>
Date: Mon, 22 Aug 2011 14:44:20 +0300
Message-ID: <CAMhs6YxhF5nhb=JMSVKWOVjiZXOehFZDESeYcrVvmU21fnrhdw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: industrialio-core: Fix compiler warning
From: Maxin B John <maxin.john@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Michael Hennerich <michael.hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>, Bryan Freed <bfreed@chromium.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 22, 2011 at 2:37 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 08/22/11 11:08, Maxin B. John wrote:
>> drivers/staging/iio/industrialio-core.c: In function
>> 'iio_device_add_event_sysfs':
>> drivers/staging/iio/industrialio-core.c:914: warning: 'mask' may be
>> used uninitialized in this function
> Thanks for the patch. =A0It's actually a driver bug if this occurs.
> We could have had a WARN_ON to let userspace know about the bug and
> indeed taken the error route you suggest but
> the relevant code has actually undergone a rewrite anyway so the
> bit you are fixing doesn't exist any more anyway.

 Yes, That makes more sense.

> See http://git.kernel.org/?p=3Dlinux/kernel/git/jic23/iio-blue.git;a=3Dsu=
mmary
> For our current dev tree (eats babies and includes all sorts of stuff
> that hasn't been reviewed yet - so beware).

Thanks for sharing  this (scary) info :)

Best Regards,
Maxin
