Return-Path: <SRS0=X1ZH=ED=google.com=gwendal@kernel.org>
MIME-Version: 1.0
Sender: gwendal@google.com
In-Reply-To: <008fa639-e955-943d-f2c0-ca60fd4f2385@collabora.com>
References: <20180105003242.11290-1-gwendal@chromium.org> <20180105003242.11290-2-gwendal@chromium.org>
 <008fa639-e955-943d-f2c0-ca60fd4f2385@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 8 Jan 2018 09:17:37 -0800
Message-ID: <CAMHSBOWLKt=sEMYnnYGheHAc-FW36E94O-9m33wrLUpG0BLLew@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: cros_ec: Add EC driver for Light and Proximity
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 5, 2018 at 1:04 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Hi Gwendal,
>
> On 05/01/18 01:32, Gwendal Grignou wrote:
>> Add driver for light and proximity sensors exposed by EC.
>>
>> Reviewed-on: https://chromium-review.googlesource.com/291360
>> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
>> [rebase44(groeck): Adjust for API changes]
>> [rebase414(gwendal): Adjust for API changes]
>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>> (cherry picked from commit 17e781c5f2747236ea1f9de6906e04aa92d383cb)
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> ---
>>  drivers/iio/common/cros_ec_sensors/Kconfig         |   9 +
>>  drivers/iio/common/cros_ec_sensors/Makefile        |   1 +
>>  .../common/cros_ec_sensors/cros_ec_light_prox.c    | 260 +++++++++++++++++++++
>
> Isn't this the driver that is already available in mainline at
> drivers/iio/light/cros_ec_light_prox.c ?
Yes it is, my patch is wrong, like the pressure sensor, the code is already in.

Thanks,
Gwendal.
>
> iirc the maintainer told me to move the driver to his iio sensor type directory
> when I posted this driver. I did a quick look at there are some few differences
> but essentially is the same driver so maybe what we need to do is sync the one
> is in mainline with the latest version in chromeos kernel.
>
>
> Best regards,
>  Enric
>
