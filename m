Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35960 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbcDNIgy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2016 04:36:54 -0400
Received: by mail-ob0-f179.google.com with SMTP id j9so45269888obd.3
        for <linux-iio@vger.kernel.org>; Thu, 14 Apr 2016 01:36:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKudTxbK9goinYCQhGLK=Gd_+PHgQ+mnpkU=cz4pB0k2w@mail.gmail.com>
References: <1460466079-15392-1-git-send-email-linus.walleij@linaro.org>
	<CAL_JsqKudTxbK9goinYCQhGLK=Gd_+PHgQ+mnpkU=cz4pB0k2w@mail.gmail.com>
Date: Thu, 14 Apr 2016 10:36:53 +0200
Message-ID: <CACRpkdZs6g+UEOo+pEd1bS1tV7JpUhA1uJ9s6i=Jr39R=2RGfQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v4] iio: st_sensors: support open drain mode
From: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 13, 2016 at 10:52 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Apr 12, 2016 at 8:01 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Some types of ST Sensors can be connected to the same IRQ line
>> as other peripherals using open drain. Add a device tree binding
>> and a sensor data property to flip the right bit in the interrupt
>> control register to enable open drain mode on the INT line.
>>
>> If the line is set to be open drain, also tag on IRQF_SHARED
>> to the IRQ flags when requesting the interrupt, as the whole
>> point of using open drain interrupt lines is to share them with
>> more than one peripheral (wire-or).
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v3->v4:
>> - Rename DT bool property st,int-pin-open-drain to int-pin-open-drain
>> - Rob Herring ACKed st,int-pin-open-drain but not including his ACK
>>   on this even though it's close
>
> We already have st,irq-open-drain, gpio-open-drain, linux,open-drain
> and drive-open-drain (from pinctrl).
>
> If we want something common, then it should probably be part of
> interrupt bindings, not something common to IIO.

I could agree to use the pin control drive-open-drain;

It has very little to do with the interrupt bindings, there are
so many interrupt lines in the world, the fact that some of them
go over open drain rails doesn't matter to the interrupt-controller
devices, it needs to be below them.

I will resubmit using the pin control binding.

Yours,
Linus Walleij
