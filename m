Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1063 "HELO
	smtp-out-087.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1752586Ab1JUHVJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 03:21:09 -0400
Message-ID: <4EA11D7D.80202@metafoo.de>
Date: Fri, 21 Oct 2011 09:21:33 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Userspace event handling and header files
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

I tried to write a small userspace iio event monitor in the style of evtest.
Right now we have four header files for iio: iio_core.h iio.h chrdev.h and
sysfs.h. To be able to receive and probably decode events in userspace we
need three of theses headers: chrdev.h for ioctls and the iio_event_data
struct, sysfs.h for the different iio_event enums and associated macros,
iio.h for the iio_chan_type and iio_modifier enums.

Since we probably don't want to export the sysfs.h and chrdev.h headers to
userspace I propose that we move everything which is needed for external API
into a common header for example iio.h and move all internal API, which is
only required to write a IIO driver for by the core itself, from the iio.h
header to a different header like iio_core.h.

What is your opinion on this?

- Lars
