Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57079 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934508AbdC3S0x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2017 14:26:53 -0400
Subject: Re: [PATCHv3] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
To: Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>
References: <20170324033842.12541-1-tony@atomide.com>
 <20170329212637.syluvxy5cp2qub3h@rob-hp-laptop>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3837adac-5dec-c645-1aeb-9425c0e73076@kernel.org>
Date: Thu, 30 Mar 2017 19:26:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170329212637.syluvxy5cp2qub3h@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/03/17 22:26, Rob Herring wrote:
> On Thu, Mar 23, 2017 at 08:38:42PM -0700, Tony Lindgren wrote:
>> On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
>> has ADCs that are used for battery charging and USB PHY VBUS and ID pin
>> detection.
>>
>> Unfortunately the only documentation for this ADC seems to be the
>> Motorola mapphone Linux kernel tree. I have tested that reading raw and
>> scaled values works, but I have not used the timed sampling that the ADC
>> seems to support.
>>
>> Let's add a minimal support for it so we can eventually provide IIO
>> channels for the related battery charging and USB PHY drivers.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Marcel Partap <mpartap@gmx.net>
>> Cc: Michael Scott <michael.scott@linaro.org>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>
>> Changes since v2:
>>
>> - Simplify things further by using channel based indexing and
>>   remove more drivers specific enumerations
>>
>> Changes since v1:
>>
>> - Fix numerous issues pointed out by Peter Meerwald-Stadler
>>   <pmeerw@pmeerw.net> and Jonathan Cameron <jic23@kernel.org>
>>
>> - Simplify things further by limiting read functions to a
>>   single channel instead of a bank and got rid of the driver
>>   specific cpcap_adc_conv_type in favor of IIO generic types
>>
>> ---
>>  .../devicetree/bindings/iio/adc/cpcap-adc.txt      |   18 +
> 
> Acked-by: Rob Herring <robh@kernel.org>
Been long enough now that I'm happy to take this.
Thanks for looking at the bindings Rob!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Jonathan
> 
>>  drivers/iio/adc/Kconfig                            |   11 +
>>  drivers/iio/adc/Makefile                           |    1 +
>>  drivers/iio/adc/cpcap-adc.c                        | 1007 ++++++++++++++++++++
>>  4 files changed, 1037 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
>>  create mode 100644 drivers/iio/adc/cpcap-adc.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

