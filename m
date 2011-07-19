Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:49991 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1GSOaG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2011 10:30:06 -0400
Message-ID: <4E2594EF.6050801@cam.ac.uk>
Date: Tue, 19 Jul 2011 15:30:07 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-iio@vger.kernel.org, manuel.stahl@iis.fraunhofer.de,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [RFC PATCH 0/7] IIO: Reduce to 1 the number of chrdevs per device
References: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk> <201107191627.20087.arnd@arndb.de>
In-Reply-To: <201107191627.20087.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/19/11 15:27, Arnd Bergmann wrote:
> On Monday 18 July 2011, Jonathan Cameron wrote:
>> 4 uses Arnd's suggestion of an annon_fd obtained via ioctl on the buffer
>> chrdev to get a file for easy use for reading events.  This is a very neat
>> solution that lets us keep the actual event system separate from the data
>> stream without two chrdevs.
> 
> IMHO, the series looks good overall, but you need to fix the iio_ioctl
> function to take a proper ioctl command: you check for 'cmd == 0', which is
> not allowed by convention.
> Please use the _IOR() macro to define a number and document the command
> range in Documentation/ioctl/ioctl-number.txt.
> 
> Also, you should have a .compat_ioctl file operation that points to
> the same function, to make sure that the interface works in 32 bit
> processes running on a 64 bit kernel.
> 
> 	Arnd
> 
Cool. Thanks for those pointers.  I hacked that bit in a bit fast without
really looking into it.. :)
