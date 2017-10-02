Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36751 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdJBNad (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Oct 2017 09:30:33 -0400
Received: by mail-pg0-f67.google.com with SMTP id 124so1433528pgi.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Oct 2017 06:30:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170930183235.24bf30c5@archlinux>
References: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
 <1501427575-31045-12-git-send-email-akinobu.mita@gmail.com>
 <20170730175806.0f2bc39a@kernel.org> <20170930183235.24bf30c5@archlinux>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 2 Oct 2017 22:30:12 +0900
Message-ID: <CAC5umyigoKSJC8vehFRfc1_21G4PWnroDrQa48yYeGw9U1D=JQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] iio: adc: ti-ads1015: add threshold event support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-10-01 2:32 GMT+09:00 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:
> On Sun, 30 Jul 2017 17:58:06 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Mon, 31 Jul 2017 00:12:55 +0900
>> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>>
>> > The ADS1015 device provides programmable comparator that can issue an
>> > interrupt on the ALERT pin.  This change adds the iio threshold event
>> > support for that feature.
>> >
>> > The ADS1015 device only have a single config register which contains an
>> > input multiplexer selection, comparator settings, and etc.  So only a
>> > single event channel can be enabled at a time.  Also enabling both buffer
>> > and event are prohibited for simplicity.
>> >
>> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> > Cc: Jonathan Cameron <jic23@kernel.org>
>> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Very nice.  I pretty much assumed there would be a locking problem in here
>> but as far as I can see you got it spot on!
>>
>> This will obviously be waiting on the fixes to work their way through the
>> fixes tree.
>>
>> I'm also happy with the rest of the series before this.
>>
>> Please give me a bump if it looks like I've lost this
>> somehow (it's been known to happen if the cycle of getting
>> changes back from the fixes tree takes too long)
>
> I've just been revisiting my patches to apply set and discovered I actually
> took v2 of many if not all of these patches a week before this set was posted.
> Could you sanity check the results currently in tree?

I've already realized and sent an patch that was not included in v2.
You have already added it to the fixes-togreg-post-rc1 branch of iio.git :)
Please take a look at the email thread "[PATCH v2 11/11] iio: adc:
ti-ads1015: add threshold event support".

The patch "iio: adc: ti-ads1015: fix comparator polarity setting" is
now added to Greg's staging-linus branch.  So if the patch will be merged,
everything will be fine.
