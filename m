Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51208 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbcHULNZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 07:13:25 -0400
Subject: Re: [PATCH 1/2] iio: gyro: Add MPU-3050 device tree bindings
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <1471286275-25024-1-git-send-email-linus.walleij@linaro.org>
 <20160816142819.GA15545@rob-hp-laptop>
 <CACRpkdacvNPsQPY41odrqfPPbuxVJ8wWNR1yqBXi4inMuhEr3w@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <42334499-131e-eca7-1d8f-86fe2585f0cf@kernel.org>
Date: Sun, 21 Aug 2016 12:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdacvNPsQPY41odrqfPPbuxVJ8wWNR1yqBXi4inMuhEr3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 20:33, Linus Walleij wrote:
> On Tue, Aug 16, 2016 at 4:28 PM, Rob Herring <robh@kernel.org> wrote:
>> On Mon, Aug 15, 2016 at 08:37:55PM +0200, Linus Walleij wrote:
>>> This adds device tree bindings for the MPU-3050 gyroscope. Since it
>>> is the first set of bindings for a gyroscope, the folder for it
>>> is also created.
>>
>> Is this not similar to mpu-6050 and other Invsense devices:
>>
>> Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> 
> I guess it was a precursor.
> 
> The MPU-3050 is a pure gyroscope, the MPU-6050 combines
> the gyro with an accelerometer. That is why it is classified as
> an IMU rather than a gyro.
> 
I did wonder if the 3050 was a subset of the 6050 but the
register maps are clearly totally different. Hence any sort
of unified driver would be a mess on any OS.

Probably fair to keep the binding docs separate (though in
sync where it makes sense!)

Jonathan

