Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44054 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbcEELvz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 May 2016 07:51:55 -0400
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: IIO trigger names are not actually unique
Message-ID: <55b99ca2-21c2-cfc6-b42d-904edb6b217d@intel.com>
Date: Thu, 5 May 2016 14:52:00 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I've been looking at trigger code and it seems to me that trigger->name
is not guaranteed to be unique. This is despite the fact that it's
documented as "@name: [DRIVER] unique name" on top of struct
iio_trigger. Just like indio_dev->name it seems to be a mostly cosmetic
label.

You can easily create a software trigger with a duplicate name if you
enable CONFIG_IIO_HRTIMER_TRIGGER:

mkdir /sys/kernel/config/iio/triggers/hrtimer/`cat
/sys/bus/iio/devices/trigger0/name`

It seems that trigger names are set at allocation time, mostly through
some variant of:

    iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);

indio_dev->name is not guaranteed to be unique but indio_dev->id is. The
are some exceptions, including st_sensors which does:

    iio_trigger_alloc("%s-trigger", indio_dev->name);

Since indio_dev->name is just the model name it seems that attaching two
identical st_sensors devices will create two triggers with the same name.

The "current_trigger" for an iio_device is identified by name. If you
have two triggers with the same name then the "first one" will be picked
up, probably in registration order.

One solution would be to refuse to register triggers with duplicate
names but that might cause probe errors in some cases.

Another option would be to just warn on duplicate names and provide a
separate current_trigger_id which identifies the current trigger by
numeric ID. In general it seems to me that it's better to identify
entities by numbers rather than strings.

-- 
Regards,
Leonard
