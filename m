Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49229 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab2KLJEV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Nov 2012 04:04:21 -0500
Message-ID: <50A0BB98.2020802@jic23.retrosnub.co.uk>
Date: Mon, 12 Nov 2012 09:04:24 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL V2] IIO fixes for v3.7-rc1 set 2 (tiny fixes and regressions
 only)
References: <50969678.6020700@kernel.org> <20121112023031.GB17405@kroah.com>
In-Reply-To: <20121112023031.GB17405@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/12 02:30, Greg KH wrote:
> On Sun, Nov 04, 2012 at 04:23:20PM +0000, Jonathan Cameron wrote:
>> Axel Lin (2):
>>        iio: hid-sensor: Use __devexit annotation for remove()
>
> This one, while maybe nice, sure isn't necessary as CONFIG_HOTPLUG can't
> be turned off anymore.  So it's not needed for 3.7, right?
>
Sorry that patch title doesn't mention why this is done. I should have
cleaned it up before merging (or poked Axel to do so)

Right now they are completely incorrectly marked as __devinit rather 
than __devexit.

Hence if any platform is being clever about ditching init.text after
module insertion it's not going to be there on removal.

If this was simply a case of adding __devexit I'd agree.

If this annotation still doesn't actually matter I've definitely missed
something.

Thanks as ever for continued handling of the IIO tree!

Jonathan

