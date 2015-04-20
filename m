Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-074.synserver.de ([212.40.185.74]:1027 "EHLO
	smtp-out-074.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbbDTPGm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2015 11:06:42 -0400
Message-ID: <55351604.4000808@metafoo.de>
Date: Mon, 20 Apr 2015 17:06:44 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Module get needed for iio_channel_get and friends
References: <552EC350.2000506@imgtec.com>
In-Reply-To: <552EC350.2000506@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/15/2015 10:00 PM, Ezequiel Garcia wrote:
> Jonathan, Lars:
>
> I've noticed that iio_channel_{get, get_all} don't call try_module_get
> on the module associated to the indio_dev.
>
> This means that an IIO driver can be removed while having a consumer for
> any of its channels.

The device can still be unbound from the driver, even if you pin the module. 
E.g. device hot-unplug.

>
> If each channel can have a completely different indio_dev, this means we
> need to increase the refcount of the module on each indio_dev, right?
>

I think we already handle this correctly. The device ref-count is 
incremented when a channel is requested. This means even when the device is 
unbound from the driver it will stay around until the channel is freed and 
the final reference is dropped. At the same time we set the info field of 
the IIO device to NULL when the driver is unbound from the driver and in 
iio_write_channel_raw() return -ENODEV when the info field is NULL.

- Lars
