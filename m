Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f195.google.com ([209.85.192.195]:51070 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab3EVHtZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 03:49:25 -0400
Received: by mail-pd0-f195.google.com with SMTP id 10so626216pdi.2
        for <linux-iio@vger.kernel.org>; Wed, 22 May 2013 00:49:25 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 22 May 2013 09:49:25 +0200
Message-ID: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com>
Subject: Why is only one int returned in iio_read_channel_processed?
From: Guillaume Ballet <gballetwork@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

The read_raw operation in iio_info has a signature that takes two
integer as in/out parameters. This lets the driver return values with
micro- or nano-unit precision.

However, the high-level iio_read_channel_raw and
iio_read_channel_processed functions' signature only has one integer
in/out parameter. That makes sense in the context of _raw because the
value isn't yet processed.

However, as the scale is a number encoded over two ints, the
_processed value should also span two ints. Is there a reason why it's
still only one int?

Thanks,
Guillaume
