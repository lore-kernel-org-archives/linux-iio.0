Return-Path: <robherring2@gmail.com>
Date: Tue, 16 Aug 2016 09:28:19 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: gyro: Add MPU-3050 device tree bindings
Message-ID: <20160816142819.GA15545@rob-hp-laptop>
References: <1471286275-25024-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471286275-25024-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 15, 2016 at 08:37:55PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the MPU-3050 gyroscope. Since it
> is the first set of bindings for a gyroscope, the folder for it
> is also created.

Is this not similar to mpu-6050 and other Invsense devices:

Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt

Rob
