Return-Path: <SRS0=X1ZH=ED=google.com=gwendal@kernel.org>
MIME-Version: 1.0
Sender: gwendal@google.com
In-Reply-To: <17116989-54d9-8fa0-1d7c-ae2a99b1e528@collabora.com>
References: <20180105003242.11290-1-gwendal@chromium.org> <20180105003242.11290-3-gwendal@chromium.org>
 <17116989-54d9-8fa0-1d7c-ae2a99b1e528@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 8 Jan 2018 09:16:33 -0800
Message-ID: <CAMHSBOVGqCQZZoHVQcNG1BO+O7e3VsFjo2-EDc-CKrw4ZRjUfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: cros_ec: add barometer driver
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 5, 2018 at 1:06 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Hi Gwendal,
>
> On 05/01/18 01:32, Gwendal Grignou wrote:
>> Add a driver when EC presents a barometer.
>>
>> BUG=chrome-os-partner:57111
>> TEST=Check the values returned by the EC
>> cat scale
>> 0.040000000
>> cat in_pressure_raw
>> 24097
>> scale * in_pressure_raw --> 963.88 hPa
>>
>> Reviewed-on: https://chromium-review.googlesource.com/382832
>> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
>> (cherry picked from commit 686988372cdc ("CHROMIUM: iio: cros_ec:
>> add cros_ec barometer driver"))
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> ---
>>  drivers/iio/common/cros_ec_sensors/Kconfig        |   7 +
>>  drivers/iio/common/cros_ec_sensors/Makefile       |   1 +
>>  drivers/iio/common/cros_ec_sensors/cros_ec_baro.c | 213 ++++++++++++++++++++++
>
> Isn't this the driver that is already available in mainline at
> drivers/iio/pressure/cros_ec_baro.c ?
Yes it is, my patch is wrong, the code is already in.

Thanks,
Gwendal.
>
> iirc the maintainer told me to move the driver to his iio sensor type directory
> when I posted this driver. I did a quick look at there are some few differences
> but essentially is the same driver so maybe what we need to do is sync the one
> is in mainline with the latest version in chromeos kernel.
>
> Best regards,
>  Enric
>
