Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37732 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdEUOSR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 10:18:17 -0400
Subject: Re: [PATCH v2] iio: adc: sun4i-gpadc-iio: fix parent device being
 used in devm function
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        clabbe.montjoie@gmail.com, linux-iio@vger.kernel.org,
        thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20170518063607.11069-1-quentin.schulz@free-electrons.com>
 <20170518065100.bn2t7ef2pw4wfaia@flea.home>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <52a7fb4c-af4f-d9d1-4ed9-906a08eb41b3@kernel.org>
Date: Sun, 21 May 2017 15:18:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170518065100.bn2t7ef2pw4wfaia@flea.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/17 07:51, Maxime Ripard wrote:
> On Thu, May 18, 2017 at 08:36:07AM +0200, Quentin Schulz wrote:
>> For the sake of DT binding stability, this IIO driver is a child of an
>> MFD driver for Allwinner A10, A13 and A31 because there already exists a
>> DT binding for this IP. The MFD driver has a DT node but the IIO driver
>> does not.
>>
>> The IIO device registers the temperature sensor in the thermal framework
>> using the DT node of the parent, the MFD device, so the thermal
>> framework could match the phandle to the MFD device in the DT and the
>> struct device used to register in the thermal framework.
>>
>> devm_thermal_zone_of_sensor_register was previously used to register the
>> thermal sensor with the parent struct device of the IIO device,
>> representing the MFD device. By doing so, we registered actually the
>> parent in the devm routine and not the actual IIO device.
>>
>> This lead to the devm unregister function not being called when the IIO
>> module driver is removed. It resulted in the thermal framework still
>> polling the get_temp function of the IIO module while the device doesn't
>> exist anymore, thus generated a kernel panic.
>>
>> Use the non-devm function instead and do the unregister manually in the
>> remove function.
>>
>> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Maxime
> 
Thanks to all involved with tracking this one down.

Jonathan
