Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <B676781F-1D3F-4C2D-A11E-EEC33F5BB34C@jic23.retrosnub.co.uk>
References: <1466169744-23214-1-git-send-email-linus.walleij@linaro.org> <B676781F-1D3F-4C2D-A11E-EEC33F5BB34C@jic23.retrosnub.co.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 Jun 2016 19:16:22 +0200
Message-ID: <CACRpkdbKd8+uOxiJGuxD-irrKb+z14cb=5upREcand3+ucpn3Q@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: kxsd9: fix the usage of spi_w8r8()
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 17, 2016 at 6:22 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:

> Where did you find one of these. I thought they were long obsoleted?

The original Qualcomm APQ8060 Dragonboard. I'm mainlining it as a test
target right now, mostly for GPIO work:
http://dflund.se/~triad/krad/dragonboard/dragonboard.jpg

It has the following on I2C on a special sensor board (totally undocumented
and no real mention in even the source code in the BSP for the board for
some of them, I guess they never got around to enable some of them):

- Kiorin KXSD9 accelerometer - this culprit

- Bosch BM085 pressure sensor/altimeter - works flawlessly with upstream
driver and a few patches (just sent).

- Capella CM3605 proximity and ambient light sensor (same as used on the
original Nexus One, yay) this require you to turn on a special IR LED for
the proximity sensor to work (!)

- AK8975 Compass/Magnetometer - just works nicely with the upstream
driver and a minor patch for an extra regulator

- Invensense MPU3050 Gyroscope
drivers/input/misc/mpu3050.c
Thinking about just moving this driver across if it's working as a starting
point, like I did with the BH1780 driver. Is this one of those who would need
a IIO <-> input bridge if we migrate it?

Yours,
Linus Walleij
