Return-Path: <peda@axentia.se>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Jonathan Cameron <jic23@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, <linux-iio@vger.kernel.org>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
CC: Nick Vaccaro <nvaccaro@google.com>, Ge Gao <ggao@invensense.com>, Anna Si
	<asi@invensense.com>, Nathan Royer <nroyer@invensense.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Crestez Dan Leonard <leonard.crestez@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>, Gregor Boirie
	<gregor.boirie@parrot.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
Date: Tue, 23 Aug 2016 10:37:34 +0200
MIME-Version: 1.0
In-Reply-To: <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-08-21 20:32, Jonathan Cameron wrote:
> On 15/08/16 19:38, Linus Walleij wrote:
>> Since the MPU-3050 has an outgoing I2C port it needs to act as
>> an I2C mux. This means that the device is switching I2C traffic
>> to devices beyond it. On my system this is the only way to reach
>> the accelerometer. The "sensor fusion" ability of the MPU-3050
>> to directly talk to the device on the outgoing I2C port is
>> currently not used by the driver, but it has code to allow I2C
>> traffic to pass through so that the Linux kernel can reach the
>> device on the other side with a kernel driver.
> Cc'd Peter Rosin as he's maintaining the i2c mux code now.

The i2c-mux handling looks sane, with the current code, but I had
an update in mind for the next merge window that affects this:

[PATCH v2 0/8] devicetree cleanup for i2c muxes/arbs/gates
https://lkml.org/lkml/2016/8/15/569

Specifically patch 3/8 is relevant

[PATCH v2 3/8] dt-bindings: i2c: add support for 'i2c-gate' subnode
https://lkml.org/lkml/2016/8/15/270

(implemented in 5/7)

The above is not in next (yet). I don't know how this situation is
best handled?

Cheers,
Peter
