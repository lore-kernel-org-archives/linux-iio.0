Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55355 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbcHaT3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2016 15:29:35 -0400
Subject: Re: [PATCH 03/17] iio: accel: kxsd9: Split out transport mechanism
To: Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-4-git-send-email-linus.walleij@linaro.org>
 <alpine.DEB.2.02.1608161549530.21709@pmeerw.net>
 <CACRpkdZEsMTkP9Fo9QgzKvwfPukAoL=jUi+MOF1AQeBFJiHhBQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c5c3bb7-6919-5eb7-2ea7-91b4fb149485@kernel.org>
Date: Wed, 31 Aug 2016 20:29:29 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdZEsMTkP9Fo9QgzKvwfPukAoL=jUi+MOF1AQeBFJiHhBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/08/16 08:18, Linus Walleij wrote:
> On Tue, Aug 16, 2016 at 3:53 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> 
>>> +/**
>>> + * struct kxsd9_transport - transport adapter for SPI or I2C
>>> + * @trdev: transport device such as SPI or I2C
>>> + * @write1(): function to write a byte to the device
>>> + * @write2(): function to write two consecutive bytes to the device
>>> + * @readval(): function to read a 16bit value from the device
>>> + * @rx: cache aligned read buffer
>>> + * @tx: cache aligned write buffer
>>
>> tx doesn't seem to be cachline_aligned?
> 
> Haha no, comment carried over when moving the code.
> I remove it later in the patch series.
> 
>>> +     void *trdev;
>>> +     int (*write1) (struct kxsd9_transport *tr, u8 byte);
>>> +     int (*write2) (struct kxsd9_transport *tr, u8 b1, u8 b2);
>>> +     int (*readval) (struct kxsd9_transport *tr, u8 address);
>>> +     u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
>>> +     u8 tx[KXSD9_STATE_TX_SIZE];
>>> +};
>>> +
>>>  /**
>>>   * struct kxsd9_state - device related storage
>>
>> should add transport and remove us, rx, tx
> 
> Yeah. I remove  it later in the patch series when switching the
> transport to regmap (IIRC) and this doesn't really cause any issues
> to have left until that point.
> 
> But if you think it's worth it, I can respin it to make a cleaner
> patch.
If we are being fussy:
drivers/iio/accel/kxsd9.c:255:5: warning: symbol 'kxsd9_spi_write1' was not declared. Should it be static?
drivers/iio/accel/kxsd9.c:262:5: warning: symbol 'kxsd9_spi_write2' was not declared. Should it be static?
drivers/iio/accel/kxsd9.c:271:5: warning: symbol 'kxsd9_spi_readval' was not declared. Should it be static?

On the plus side:
Tested-by: Jonathan Cameron <jic23@kernel.org>

Amazing how many ways one can miss specify how a device is connected to an spi bus..
Took me rather longer to get this working that it should have done!

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

