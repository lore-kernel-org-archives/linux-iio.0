Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:46532 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750781AbdALDwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 22:52:33 -0500
Subject: Re: [PATCH v1 1/1] iio: adc: tlc4541: add support for TI tlc4541 adc
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1484117471-67082-1-git-send-email-preid@electromag.com.au>
 <5f800162-a404-09fa-ce1b-c95f5b73ac56@electromag.com.au>
 <alpine.DEB.2.02.1701111007240.12204@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Phil Reid <preid@electromag.com.au>
Message-ID: <86fa08f8-8c4f-8ca6-5880-02d4df937011@electromag.com.au>
Date: Thu, 12 Jan 2017 11:51:55 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1701111007240.12204@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/2017 17:17, Peter Meerwald-Stadler wrote:
> On Wed, 11 Jan 2017, Phil Reid wrote:
>
>> Oops, title should be PATCH V2.
>>
>> On 11/01/2017 14:51, Phil Reid wrote:
>>> This adds TI's tlc4541 16-bit ADC driver. Which is a single channel
>>> ADC. Supports raw and trigger buffer access.
>>> Also supports the tlc3541 14-bit device, which has not been tested.
>>> Implementation of the tlc3541 is fairly straight forward thou.
>
> comments below
>
>>
>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>> ---
>>>
>>> Notes:
>>>     Changes from v1:
>>>     - Add tlc3541 support and chan spec.
>>>     - remove fields that where already 0 from TLC4541_V_CHAN macro
>>>     - Increase rx_buf size in tlc4541_state to avoid copy in
>>> tlc4541_trigger_handle
>>>     - Remove erroneous be16_to_cpu in tlc4541_trigger_handle
>>>     - Docs/binding: spi -> SPI & add ti,tlc3541
>>>
>>>     I haven't add Rob's Ack due to adding a new compatible string.
>>>
>>>     I tried to ".index = 1" from the spec as suggested by Peter, but that
>>> didn't
>>>     seem to work. Perhaps remove of .channel was the intended target.
>
> the only between index = 0/1 should be that the channel is called
> in_voltage0_raw vs in_voltage_raw in sysfs -- maybe there is an issue in
> iio_readdev?
>

Did a little more testing and the problem looks to be in libiio.


Here's the output from iio and list of sysfs files when "indexed = 1"
         iio:device8: tlc4541 (buffer capable)
                 2 channels found:
                         voltage0:  (input, index: 0, format: be:U16/16>>0)
                         2 channel-specific attributes found:
                                 attr 0: raw value: 174
                                 attr 1: scale value: 0.076293945
                         timestamp:  (input, index: 1, format: le:S64/64>>0)
                 1 device-specific attributes found:
                                 attr 0: current_timestamp_clock value: realtime

root@cyclone5:~# ls /sys/bus/iio/devices/iio\:device8/*
/sys/bus/iio/devices/iio:device8/current_timestamp_clock  /sys/bus/iio/devices/iio:device8/in_voltage_scale
/sys/bus/iio/devices/iio:device8/dev                      /sys/bus/iio/devices/iio:device8/name
/sys/bus/iio/devices/iio:device8/in_voltage0_raw          /sys/bus/iio/devices/iio:device8/uevent

/sys/bus/iio/devices/iio:device8/buffer:
enable     length     watermark

/sys/bus/iio/devices/iio:device8/of_node:
#io-channel-cells  enable-dma         name               reg                spi-max-frequency
compatible         linux,phandle      phandle            spi-cpha           vref-supply

/sys/bus/iio/devices/iio:device8/power:
autosuspend_delay_ms    control                 runtime_active_time     runtime_status          runtime_suspended_time

/sys/bus/iio/devices/iio:device8/scan_elements:
in_timestamp_en     in_timestamp_index  in_timestamp_type   in_voltage0_en      in_voltage0_index   in_voltage0_type

/sys/bus/iio/devices/iio:device8/subsystem:
devices            drivers            drivers_autoprobe  drivers_probe      uevent

/sys/bus/iio/devices/iio:device8/trigger:
current_trigger

And the same when "indexed = 0"

         iio:device8: tlc4541 (buffer capable)
                 2 channels found:
                         voltage:  (input)
                         2 channel-specific attributes found:
                                 attr 0: raw value: 173
                                 attr 1: scale value: 0.076293945
                         timestamp:  (input, index: 1, format: le:S64/64>>0)
                 1 device-specific attributes found:
                                 attr 0: current_timestamp_clock value: realtime

root@cyclone5:~# ls /sys/bus/iio/devices/iio\:device8/*
/sys/bus/iio/devices/iio:device8/current_timestamp_clock  /sys/bus/iio/devices/iio:device8/in_voltage_scale
/sys/bus/iio/devices/iio:device8/dev                      /sys/bus/iio/devices/iio:device8/name
/sys/bus/iio/devices/iio:device8/in_voltage_raw           /sys/bus/iio/devices/iio:device8/uevent

/sys/bus/iio/devices/iio:device8/buffer:
enable     length     watermark

/sys/bus/iio/devices/iio:device8/of_node:
#io-channel-cells  enable-dma         name               reg                spi-max-frequency
compatible         linux,phandle      phandle            spi-cpha           vref-supply

/sys/bus/iio/devices/iio:device8/power:
autosuspend_delay_ms    control                 runtime_active_time     runtime_status          runtime_suspended_time

/sys/bus/iio/devices/iio:device8/scan_elements:
in_timestamp_en     in_timestamp_index  in_timestamp_type   in_voltage_en       in_voltage_index    in_voltage_type

/sys/bus/iio/devices/iio:device8/subsystem:
devices            drivers            drivers_autoprobe  drivers_probe      uevent

/sys/bus/iio/devices/iio:device8/trigger:
current_trigger

The iio scope application also does not allow the tlc4541 channel to be selected when "indexed = 0".

I've had a bit of play with some test apps but it looks like to me libiio is not parsing the
scan_elements folder correctly when the channels are not indexed.
Haven't located exactly where as yet.

So is the correct path here to fix libiio?

I'm using libiio from git build a few weeks ago, I'll try updating to see if it fixes anything.
Last commit was:
9838779 - Paul Cercueil       , 3 weeks ago  : Local backend: Return scan result even if 0 devices







-- 
Regards
Phil Reid


