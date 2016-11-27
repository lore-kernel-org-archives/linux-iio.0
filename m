Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41420 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbcK0LuV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:50:21 -0500
Subject: Re: ACPI DSDT support for mount-matrix?
To: Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org
References: <1479811817.13456.18.camel@hadess.net>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
        faouaz.tenoutit@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9af16e31-c681-19ce-410c-0c75452eb16e@kernel.org>
Date: Sun, 27 Nov 2016 11:50:04 +0000
MIME-Version: 1.0
In-Reply-To: <1479811817.13456.18.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/11/16 10:50, Bastien Nocera wrote:
> Hey,
> 
> Gregor added support for exporting the mount matrix from the Device
> Tree to the IIO accelerometer:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=dfc57732ad38f93ae6232a3b4e64fd077383a0f1
> 
> And Faouaz wanted to add support for exporting the mount matrix from
> the ACPI DSDT to sysfs as well:
> http://www.spinics.net/lists/linux-acpi/msg51540.html
> 
> Would it be possible to rework that ACPI patch to export the mount
> matrix through IIO as is done for DeviceTree-based machines?
There is obviously a lot of other information in there.  Is it possible to access this via
interfaces within the kernel?  Obviously we could replicate parts of your patch set to
read them directly but it would be good to avoid any code duplication (not that it looks
like it would be that much!)

Jonathan
> 
> I'm adding mount-matrix support to iio-sensor-proxy, which currently
> means getting that information from the firmware through the IIO
> device, using udev as a way to override that, if the firmware doesn't
> contain that information. I'd like to avoid having 3 different sources
> for the value.
> 
> Cheers
> 
> PS: I'd also be interested in that _PLD information to export the
> information to webcams.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

