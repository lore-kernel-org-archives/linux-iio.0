Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:36441 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaIKJNZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Sep 2014 05:13:25 -0400
Received: by mail-oa0-f43.google.com with SMTP id m19so2704247oag.16
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2014 02:13:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53FB6205.5020704@kernel.org>
References: <1408815064-5763-1-git-send-email-linus.walleij@linaro.org>
	<53FB6205.5020704@kernel.org>
Date: Thu, 11 Sep 2014 11:13:24 +0200
Message-ID: <CACRpkdZuSsePVjPpmLV5bs5VOcbnH2_gK4-kOfbpBM1-7Q=zgQ@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: add support for lis3lv02d accelerometer
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 25, 2014 at 6:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 23/08/14 18:31, Linus Walleij wrote:
>> This adds support for the LIS3LV02 accelerometer found in the
>> ST Microelectronics Nomadik board series.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Denis CIOCCA <denis.ciocca@st.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> If anyone wants to look at what the misc driver supports that we still
> don't have in the IIO driver then that would be great!

I had a quick look at it:

- The misc driver has a bridge that optionally registers the
  accelerometer as a joystick in the input subsystem, so it
  can be used as a polled joystick. That looks like something
  we would want to be able to do for any accelerometer in a
  generic glue file in IIO I think?

- Ability to generate a "free-fall event" on a misc device
  if the device containing the sensor is dropped. A special
  interrupt can be enabled on the device for this. I can't quite
  see how userspace is supposed to react to it, because this
  miscdevice userspace ABI is sort of complex.

- Some driver-specific sysfs power management stuff

- Context save/restore registers for power-off handling.

- Trigger selftest from sysfs : I suspect this could be ported
  over to all the ST Micro devices, as they are similar in that
  way, same kind of test registers.

- Possible to enable high-pass filter from the DT config.
  (Should that not be dynamic?)

Apart from that it has a custom sysfs interface to read the
accelerometer, similar to the IIO interface. It seems to *only* support
raw values AFAICT  though, not sensitivity adjustment, so my patch
gives the ability to have better sensor handling in the kernel from an
IIO point of view.

Yours,
Linus Walleij
