Return-Path: <SRS0=Fy6E=6X=gmail.com=eballetbo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170718091906.trvcaacdfrizjfks@dell>
References: <20170712101309.6045-1-enric.balletbo@collabora.com>
 <20170712101309.6045-2-enric.balletbo@collabora.com> <CAMHSBOUT2hpcXrSuvRrZfnEXWtN9QfNLqHvM4TCvHPKiokP0Ag@mail.gmail.com>
 <CAFqH_53O8UDPnhCq7BwS7tZ9814HD5GLXWGfbeYJ2PFFk06Uzg@mail.gmail.com> <20170718091906.trvcaacdfrizjfks@dell>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 20 Jul 2017 08:31:18 +0200
Message-ID: <CAFqH_52FwqJudZ9mYPotaX=GvA11JrpaYEKmZWwJJYWe=DZwMQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mfd: cros_ec: Get rid of cros_ec_check_features
 from cros_ec_dev.
To: Lee Jones <lee.jones@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>, Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>, Javier Martinez Canillas <martinez.javier@gmail.com>,
	Guenter Roeck <groeck@chromium.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Lee,

2017-07-18 11:19 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
> On Mon, 17 Jul 2017, Enric Balletbo Serra wrote:
>
>> Hi Gwendal,
>>
>> 2017-07-13 22:33 GMT+02:00 Gwendal Grignou <gwendal@chromium.org>:
>> > On Wed, Jul 12, 2017 at 3:13 AM, Enric Balletbo i Serra
>> > <enric.balletbo@collabora.com> wrote:
>> >> The cros_ec_dev driver should be used only to expose the Chrome OS Em=
bedded
>> >> Controller to user-space and should not be used to add MFD devices by
>> >> calling mfd_add_devices. This patch moves this logic to the MFD cros_=
ec
>> >> driver and removes the MFD bits from the character device driver. Als=
o
>> >> makes independent the IIO driver from the character device as also ha=
s no
>> >> sense.
>> >
>> > cros_ec_dev serves another purpose: it allows to represent an EC that
>> > does not have a cros_ec structure. It happens when there are several
>> > EC in a chromebook, and one EC is connected through another EC.
>> > One example is Samus (Pixel 2): where we have:
>> >
>> > (main SOC, Application Processor) AP --> (main Embedded Controller) EC
>> > ---> (Power Delivery [PD}) EC
>> >
>> > We  access to the PD EC via pass-through commands through the main EC.
>> > Each EC has a cros_ec_dev structure, but only the main EC as a
>> > cros_ec_device structure (I will forever regret the structure names).
>> >
>> > Now form the AP point of view, both ECs use the same protocol. That
>> > why the sensors and other devcies that are registered by looking at
>> > the feature fields are registered with cros_ec_dev as their parent.
>> > Other devices that are registered from the device tree, predating the
>> > feature field support, are registered with cros_ec_device as their
>> > parent.
>> >
>>
>> Interesting I didn't know that. So are you saying that this patch will
>> break support for devices like Pixel 2? I tested the patches on
>> various devices but not on Pixel 2 so could be.
>
> Does this affect the rest of the series?
>

Yes, because this patch moves cros_ec_check_features from char dev driver..=
.

> Or should I review/apply as usual?
>

Please, hold on while I figure out what's exactly the problem with
Samus. Sorry for the noise.

Cheers,
 Enric

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
