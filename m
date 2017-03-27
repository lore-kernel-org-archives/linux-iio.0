Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36640 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdC0H41 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 03:56:27 -0400
Received: by mail-it0-f43.google.com with SMTP id e75so12134383itd.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2017 00:56:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170326045717.GB70446@Bjorns-MacBook-Pro-2.local>
References: <20170318133358.22314-1-linus.walleij@linaro.org> <20170326045717.GB70446@Bjorns-MacBook-Pro-2.local>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Mar 2017 09:56:03 +0200
Message-ID: <CACRpkdZwB9D_DrgKxTUUA-87qK7U4+tMPV+MCFM2zgVVO4t8ow@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: xoadc: augment DT bindings a bit
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 26, 2017 at 6:57 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Sat 18 Mar 06:33 PDT 2017, Linus Walleij wrote:
>

>> +adc-channel@0c {
>
> Shouldn't the @ be followed by the value of the first cell in "reg"?
> (Which will collide if we name them all "adc-channel").

I don't think we have a rule about these other than that they should
be unique. I renamed them so that it is unique using the combined
premux+amux number:

>> +     reg = <0x00 0x0c>;

So this becomes

adc-channel@000c {
    reg = <0x00 0x0c>;
};

>> +  On PM8058 the hardware only supports 16 channels, but we get the same
>> +  channels repeating with its input divided down by 1 or 3. Channels 00,
>> +  10, 20, ... f0 are the raw values, 04, 14, 24 .. f4 are "unity" channels
>> +  divided by 1, and 08, 18, 28 .. f8 are channels divided by 3. Bits 0
>> +  and 1 of the channel index should always be 0.
>> +
>> +  On PM8921 the hardware supports more than 16 channels through a complex
>> +  routing matrix using a premux, so 00, 10, 20 .. f0 are the basic raw
>> +  channels while another set of channels appear for 04, 14, 24 .. f4,
>> +  and again some of the same channels appear again divided down by 3
>> +  in 08, 18, 28 .. f8. Again bits 0 and 1 of the channel index should
>> +  always be 0.
>
> While I believe documenting this is a good thing I do not think it adds
> value to this binding document (other than showing Rob the absurdness of
> the addressing scheme). Please consider moving it to the driver (haven't
> checked how you commented it yet) and drop it from here.

Dropped it.

I'm sending this modified version as v2.

Yours,
Linus Walleij
