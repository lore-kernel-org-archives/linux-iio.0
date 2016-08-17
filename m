Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33611 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbcHQHSi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2016 03:18:38 -0400
Received: by mail-oi0-f54.google.com with SMTP id c15so128859256oig.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Aug 2016 00:18:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1608161549530.21709@pmeerw.net>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-4-git-send-email-linus.walleij@linaro.org> <alpine.DEB.2.02.1608161549530.21709@pmeerw.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Aug 2016 09:18:37 +0200
Message-ID: <CACRpkdZEsMTkP9Fo9QgzKvwfPukAoL=jUi+MOF1AQeBFJiHhBQ@mail.gmail.com>
Subject: Re: [PATCH 03/17] iio: accel: kxsd9: Split out transport mechanism
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 16, 2016 at 3:53 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:

>> +/**
>> + * struct kxsd9_transport - transport adapter for SPI or I2C
>> + * @trdev: transport device such as SPI or I2C
>> + * @write1(): function to write a byte to the device
>> + * @write2(): function to write two consecutive bytes to the device
>> + * @readval(): function to read a 16bit value from the device
>> + * @rx: cache aligned read buffer
>> + * @tx: cache aligned write buffer
>
> tx doesn't seem to be cachline_aligned?

Haha no, comment carried over when moving the code.
I remove it later in the patch series.

>> +     void *trdev;
>> +     int (*write1) (struct kxsd9_transport *tr, u8 byte);
>> +     int (*write2) (struct kxsd9_transport *tr, u8 b1, u8 b2);
>> +     int (*readval) (struct kxsd9_transport *tr, u8 address);
>> +     u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
>> +     u8 tx[KXSD9_STATE_TX_SIZE];
>> +};
>> +
>>  /**
>>   * struct kxsd9_state - device related storage
>
> should add transport and remove us, rx, tx

Yeah. I remove  it later in the patch series when switching the
transport to regmap (IIRC) and this doesn't really cause any issues
to have left until that point.

But if you think it's worth it, I can respin it to make a cleaner
patch.

Yours,
Linus Walleij
