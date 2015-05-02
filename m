Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58595 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbEBLWD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 07:22:03 -0400
Message-ID: <5544B358.1060208@kernel.org>
Date: Sat, 02 May 2015 12:22:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	marxin.liska@gmail.com, marex@denx.de, rui.zhang@intel.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: acpi: Add ACPI0008 Ambient Light Sensor
References: <1430306845-7117-1-git-send-email-gabriele.mzt@gmail.com> <10033848.82LkUmdQLq@xps13>
In-Reply-To: <10033848.82LkUmdQLq@xps13>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/15 17:12, Gabriele Mazzotta wrote:
> Hi,
> 
> probably this is not completely related to this driver, but I
> noticed something while testing it.
> 
> When I load acpi-als, /sys/bus/iio/devices/iio:device0/buffer/enable
> is 0. If I try to set it to 1, I get the following error:
> "Buffer not started: buffer parameter update failed (-22)"
> 
> After I got the error, I can successfully toggle "enable".
> 
> What I found is that the first time iio_request_update_kfifo() is
> called, __iio_allocate_kfifo() gets called. Since bytes_per_datum
> is 0 (as set iio_compute_scan_bytes()), it returns -EINVAL and so
> does iio_request_update_kfifo(), causing the error above.
> 
> Subsequent calls of iio_request_update_kfifo() will return 0 as
> update_needed is false, so "enable" can be toggled with no errors.
> 
> Isn't there something wrong here?
Definitely looks like it!

Thanks for pointing this out.  Anyhow, the issue is exactly what you've
identified; the line below the __iio_allocate_kfifo clears the
update needed whether or not it succeeded.  Clearly it should not
be doing that if a failure has occurred.

Would you mind submitting a fix patch for this?
Simply checking ret before setting updateneeded to false
should do the job.

Thanks,

Jonathan

 
> 
> Regards,
> Gabriele
> 

