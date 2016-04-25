Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35071 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcDYHic (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 03:38:32 -0400
MIME-Version: 1.0
In-Reply-To: <a7957593-1a18-39fc-a12f-2e60019f8908@kernel.org>
References: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
	<a7957593-1a18-39fc-a12f-2e60019f8908@kernel.org>
Date: Mon, 25 Apr 2016 10:38:30 +0300
Message-ID: <CAEnQRZDKV2K6f0peVnJX-Q2Gcuq_2hER6G1cvCbUhrBkomotmQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce support for creating IIO devices via configfs
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 24, 2016 at 2:28 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/04/16 16:45, Daniel Baluta wrote:
>> For testing purposes is nice to have a quick way of creating IIO devices.
>> This patch series introduces support for creating IIO devices via configs
>> (patch 1), allowing users to register "device types". For the moment we
>> support "dummy" device type (patch 2).
>>
>> This is just a RFC in order to see if the interface is acceptable. We also
>> need a way to create IIO devices with configurable number of channels.
>>
>> Patch 3 introduces configfs entries documentation for easier review.
>>
>> Daniel Baluta (3):
>>   iio: Add support for creating IIO devices via configfs
>>   iio: dummy: Convert IIO dummy to configfs
>>   Documentation: iio: Add IIO software devices docs
>>
>>  Documentation/ABI/testing/configfs-iio |  13 +++
>>  drivers/iio/Kconfig                    |   9 ++
>>  drivers/iio/Makefile                   |   1 +
>>  drivers/iio/dummy/iio_simple_dummy.c   |  98 ++++++------------
>>  drivers/iio/industrialio-sw-device.c   | 181 +++++++++++++++++++++++++++++++++
>>  include/linux/iio/sw_device.h          |  70 +++++++++++++
>>  6 files changed, 307 insertions(+), 65 deletions(-)
>>  create mode 100644 drivers/iio/industrialio-sw-device.c
>>  create mode 100644 include/linux/iio/sw_device.h
>>
> Sorry, I was a muppet and delete patch one due to a misstap on my phone...
> Anyhow, pasting it in here to review...
>
>> This is similar with support for creating triggers via configfs.
>> Devices will be hosted under:
>>       * /config/iio/devices
>>
>> We allow users to register "device types" under:
>>       * /config/iio/devices/<device_types>/
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> As you observed, there is room in here to share some code with the sw-trigger
> support.  Looks like we are going to have an iio-configfs helper library
> or perhaps just move them into the industrialio-configfs module...
>
> However, I'm not sure it's actually a good idea.  Seems to me that the amount
> of fiddly indirection needed would outway the advantages in reduced code
> replication.
>
> Other than a few nitpicks this looks good to me - though that's not surprising
> as it's a find and replace job on the trigger version!

Yes, I think we can live with the code as it is now.

I'm now thinking of a more flexibly interface, that will allow us creating an
IIO devices with configurable number and types of IIO channels.

This will be later useful in evaluating the choices for sensor hubs with lots
of sensors attached:

Single IIO device for all sensors VS One IIO device per sensor type.

Daniel.
