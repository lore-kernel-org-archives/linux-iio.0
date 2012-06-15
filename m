Return-Path: <lars@metafoo.de>
Message-ID: <4FDB33CD.2090805@metafoo.de>
Date: Fri, 15 Jun 2012 15:08:29 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Bottom half trigger function never called when using the sysfs trigger
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

hi,

The sysfs trigger uses iio_trigger_poll_chained which calls
handle_nested_irq. The problem now is that for nested IRQs the primary
handler is not called. Which obviously breaks drivers which have a bottom
half trigger function.

This behaviour was introduced in commit 1f785681 ("staging:iio:trigger sysfs
userspace trigger rework."). The commit message says you are "awaiting
comments on using the nested_irq_trick", but not why it is necessary to use
nested IRQs. And honestly I don't get why it would be necessary either.
handle_nested_irq is supposed to be used with chained IRQs if we are already
running in a thread handler of parent. Neither seems to be true here.

- Lars
