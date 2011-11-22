Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-157.synserver.de ([212.40.185.157]:1048 "HELO
	smtp-out-153.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1754493Ab1KVNBv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2011 08:01:51 -0500
Message-ID: <4ECB9D6F.4070303@metafoo.de>
Date: Tue, 22 Nov 2011 14:02:39 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: RFC: Rename iio_{allocate,free}_device to iio_device_{alloc,free}
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently we have two pairs of functions which respectively are used to
allocate/register and unregister/free a iio devices. The first pair is
iio_allocate_device, iio_device_register and the second pair is
iio_device_unregister, iio_free_device. So what can be seen is, that there
is a bit of inconsistency here as to where to put the "device" in the
function name.

So in order to streamline the API I propose to rename iio_free_device to
iio_device_free and iio_allocate_device to iio_device_alloc (alloc instead
of allocate to be more in sync with other in kernel APIs e.g.
platform_device_alloc).

If nobody sees any problems or has any objections I'll send a patch.

- Lars
