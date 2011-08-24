Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54191 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1HXMI0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 08:08:26 -0400
Message-ID: <4E54EBA5.9040103@cam.ac.uk>
Date: Wed, 24 Aug 2011 13:16:37 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Sysfs group create for empty groups.
References: <1313576222-27743-1-git-send-email-jic23@cam.ac.uk> <4E4BEBFD.3040004@cam.ac.uk> <20110823003352.GA5982@kroah.com> <4E538896.3050006@cam.ac.uk> <4E53FEA9.3010408@cam.ac.uk> <20110823220311.GA15689@kroah.com>
In-Reply-To: <20110823220311.GA15689@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I've dropped lkml on this discussion seeing as it will now be all linux-iio
stuff.

Anyhow, I've put together a patch set that does this on top of iio-blue.git.

Unfortunately it requires changes in a lot of drivers.

Basically you have to do iio_device_register last - after all ring and trigger
registrations (previously it had to be first).

Has the nice side effect of removing the need for that nasty regdone trick
that quite a lot of drivers use.

Sorry all but this will break almost all drivers currently out of tree.

I wasn't too nasty to implement, though it does mean embedding attribute_group
structures in struct iio_dev, struct iio_ring_buffer and struct iio_event_interface
and dynamically allocating the struct attribute pointer arrays + remembering to
free them.  That's all in the core though so as long as I haven't messed up shouldn't
effect anyone.

+ now we should get all the right notifications for file creation.

Will post patches once I've done all the driver reorderings as stated above.

Jonathan

