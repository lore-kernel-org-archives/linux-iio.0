Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45240 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcEJIDT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2016 04:03:19 -0400
Date: Tue, 10 May 2016 11:03:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jic23@cam.ac.uk
Cc: linux-iio@vger.kernel.org
Subject: re: staging:iio:triggers introduce iio_trigger_ops to take const
 bits out of iio_trig_structure.
Message-ID: <20160510080304.GA5874@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan Cameron,

The patch d29f73db7910: "staging:iio:triggers introduce
iio_trigger_ops to take const bits out of iio_trig_structure." from
Aug 12, 2011, leads to the following static checker warning:

	drivers/iio/industrialio-trigger.c:376 iio_trigger_write_current()
	error: we previously assumed 'indio_dev->trig->ops' could be null (see line 367)

drivers/iio/industrialio-trigger.c
   360  
   361          if (trig && trig->ops && trig->ops->validate_device) {
                            ^^^^^^^^^
New check.

   362                  ret = trig->ops->validate_device(trig, indio_dev);
   363                  if (ret)
   364                          return ret;
   365          }
   366  
   367          indio_dev->trig = trig;
   368  
   369          if (oldtrig) {
   370                  if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
   371                          iio_trigger_detach_poll_func(oldtrig,
   372                                                       indio_dev->pollfunc_event);
   373                  iio_trigger_put(oldtrig);
   374          }
   375          if (indio_dev->trig) {
   376                  iio_trigger_get(indio_dev->trig);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Dereferenced inside the function without checking.

   377                  if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
   378                          iio_trigger_attach_poll_func(indio_dev->trig,
   379                                                       indio_dev->pollfunc_event);
   380          }

regards,
dan carpenter
