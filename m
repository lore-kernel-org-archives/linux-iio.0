Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20160816142819.GA15545@rob-hp-laptop>
References: <1471286275-25024-1-git-send-email-linus.walleij@linaro.org> <20160816142819.GA15545@rob-hp-laptop>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Aug 2016 21:33:42 +0200
Message-ID: <CACRpkdacvNPsQPY41odrqfPPbuxVJ8wWNR1yqBXi4inMuhEr3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: gyro: Add MPU-3050 device tree bindings
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 16, 2016 at 4:28 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Aug 15, 2016 at 08:37:55PM +0200, Linus Walleij wrote:
>> This adds device tree bindings for the MPU-3050 gyroscope. Since it
>> is the first set of bindings for a gyroscope, the folder for it
>> is also created.
>
> Is this not similar to mpu-6050 and other Invsense devices:
>
> Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt

I guess it was a precursor.

The MPU-3050 is a pure gyroscope, the MPU-6050 combines
the gyro with an accelerometer. That is why it is classified as
an IMU rather than a gyro.

Yours,
Linus Walleij
