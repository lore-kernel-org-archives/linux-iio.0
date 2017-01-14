Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50824 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdANKsW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 05:48:22 -0500
Subject: Re: [PATCH v4] iio:temperature: Add support for TI TMP007 sensor
To: Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>
References: <20170109025526.GA9601@gmail.com>
 <20170110053603.n6ihrg3r6z4244g5@rob-hp-laptop>
Cc: pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e4e7129b-94b8-1f38-ee53-c447ab041b80@kernel.org>
Date: Sat, 14 Jan 2017 10:48:19 +0000
MIME-Version: 1.0
In-Reply-To: <20170110053603.n6ihrg3r6z4244g5@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/17 05:36, Rob Herring wrote:
> On Mon, Jan 09, 2017 at 08:25:26AM +0530, Manivannan Sadhasivam wrote:
>> This patch adds support for TI TMP007 - 16 bit IR thermopile sensor with integrated Math engine.
>> Sensor takes care of calculating the object temperature with the help of calibrated constants stored in non-volatile memory,
>> thereby reducing the calculation overhead.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
>> ---
>>
>> Changes since v3:
>>
>> 1. Removed caching of status register
>> 2. Modified comments for data validity
>> 3. Added possible address combinations in dTree bindings file
>>
>>  .../devicetree/bindings/iio/temperature/tmp007.txt |  27 ++
> 
> This could be documented under trivial-devices.txt, but doesn't hurt to 
> have it here.
> 
> Acked-by: Rob Herring <robh@kernel.org>
Thanks as ever Rob - I don't say that often enough!

Anyhow, nice little driver. Applied to the togreg branch of iio.git and
pushed out as testing for the autobuilders to see if they can find anything
we missed.

Was a bit messy going in with some fuzz, but superficially looks fine.

Thanks,

Jonathan
> 
>>  drivers/iio/temperature/Kconfig                    |  10 +
>>  drivers/iio/temperature/Makefile                   |   1 +
>>  drivers/iio/temperature/tmp007.c                   | 345 +++++++++++++++++++++
>>  4 files changed, 383 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp007.txt
>>  create mode 100644 drivers/iio/temperature/tmp007.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

