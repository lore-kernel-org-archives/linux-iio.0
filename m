Return-Path: <Ezequiel.Garcia@imgtec.com>
Message-ID: <552EC350.2000506@imgtec.com>
Date: Wed, 15 Apr 2015 17:00:16 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Module get needed for iio_channel_get and friends
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Jonathan, Lars:

I've noticed that iio_channel_{get, get_all} don't call try_module_get
on the module associated to the indio_dev.

This means that an IIO driver can be removed while having a consumer for
any of its channels.

If each channel can have a completely different indio_dev, this means we
need to increase the refcount of the module on each indio_dev, right?

-- 
Ezequiel
