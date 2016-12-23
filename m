Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:53228 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759318AbcLWLfY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2016 06:35:24 -0500
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de>
 <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de>
 <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com>
 <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de>
 <CAMuHMdX3u4cb2Yq2+VV_eDUaw2EqiOjN2TorW+F5-39Mm=mXmQ@mail.gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9609b56b-194c-9899-1142-ff2ee285c6bd@metafoo.de>
Date: Fri, 23 Dec 2016 12:35:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX3u4cb2Yq2+VV_eDUaw2EqiOjN2TorW+F5-39Mm=mXmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/23/2016 11:00 AM, Geert Uytterhoeven wrote:
> Hi Lars,
> 
> On Mon, Dec 12, 2016 at 6:15 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 12/06/2016 12:12 PM, Bartosz Golaszewski wrote:
>>> We're already using libiio to read the measured data from the power
>>> monitor, that's why we'd like to use the iio framework for
>>> power-cycling the devices as well. My question is: would bridging the
>>> regulator framework be the right solution? Should we look for
>>> something else? Bridge the GPIO framework instead?
>>
>> I wouldn't necessaries create bridge, but instead just use the GPIO
>> framework directly.
>>
>> We now have the GPIO chardev interface which meant to be used to support
>> application specific logic that control the GPIOs, but where you don't want
>> to write a kernel driver.
>>
>> My idea was to add GPIOs and GPIO chips as high level object inside libiio
>> that can be accessed through the same context as the IIO devices. Similar to
>> the current IIO API you have a API for gpios that allows to enumerate the
>> GPIO devices and their pins as well as modify the pin state.
> 
> That would mean libiio has access to all GPIOs, allowing a remote person
> to not only control through iiod the GPIOs for industrial control, but also the
> GPIOs not intended for export, right?

Well, it is a policy question. Who gets access to what. Right now it is all
or nothing, a privileged application gets access to all devices/GPIOs, a
unprivileged application gets access to nothing. Same for GPIOs as well as
IIO devices.

iiod at the moment does not have any access control at all, which in itself
is a problem. We need to add support for that at some point. I don't see an
issue with implementing a finer grained access scheme when we do so. E.g.
unprivileged applications only get access to certain pins.

> Having a separate GPIO switch driver avoids that, as DT (or some other means)
> can be used to specify and label the GPIOs for IIO use.

Sure, functionally this would be equivalent, but we have to ask whether this
is the right way to use the DT. Is access policy specification part of the
hardware description? In my opinion the answer is no. At the hardware
description level there is no operating system, there is no userspace or
kernelspace, there is are no access levels. Putting the distinction between
a switch/regulator that can be controlled from userspace or can only be
controlled from kernel space into the DT would be a layering violation. It
is analogous to why we don't have spidev DT bindings. This is an issue that
needs to be solved at a higher level. In my opinion this level is a
cooperation between kernel- and userspace. Kernelspace offering an interface
to export a device for userspace access and userspace making use of that
interface to request access to a device. In a similar way to how vfio is
structured.
