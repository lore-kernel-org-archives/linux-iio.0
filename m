Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:55841 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752157AbcF1JCO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 05:02:14 -0400
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Phil Reid <preid@electromag.com.au>
Subject: Question on shared attributes
Message-ID: <e87b35bc-36e9-dc1a-a87e-4e1c20db8d2e@electromag.com.au>
Date: Tue, 28 Jun 2016 16:55:28 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

G'day All,

Found something interesting.
For a new iio driver I have a shared attribute on direction.

.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ)

Which results in sysfs attribute name of:
in_sampling_frequency

Which results in iio_info giving the following output:
iio:device3: module0
         7 channels found:
                 voltage0:  (input)
                 6 channel-specific attributes found:
                         attr 0: scale value: 0.000149011
                         attr 1: raw value: 0
                         attr 2: hardwaregain value: 1
                         attr 3: index value: 0
                         attr 4: en value: 0
                         attr 5: type value: le:s24/32>>0
                 voltage1:  (input)
                 6 channel-specific attributes found:
                         attr 0: raw value: 0
                         attr 1: scale value: 0.000149011
                         attr 2: hardwaregain value: 1
                         attr 3: en value: 0
                         attr 4: index value: 1
                         attr 5: type value: le:s24/32>>0
                 voltage2:  (input)
                 6 channel-specific attributes found:
                         attr 0: raw value: 0
                         attr 1: scale value: 0.000149011
                         attr 2: hardwaregain value: 1
                         attr 3: en value: 0
                         attr 4: index value: 2
                         attr 5: type value: le:s24/32>>0
                 voltage3:  (input)
                 6 channel-specific attributes found:
                         attr 0: hardwaregain value: 1
                         attr 1: raw value: 0
                         attr 2: scale value: 0.000149011
                         attr 3: en value: 0
                         attr 4: type value: le:s24/32>>0
                         attr 5: index value: 3
                 voltage4:  (output)
                 2 channel-specific attributes found:
                         attr 0: raw value: 32768
                         attr 1: scale value: 2500000.000000000
                 voltage5:  (output)
                 2 channel-specific attributes found:
                         attr 0: raw value: 32768
                         attr 1: scale value: 2500000.000000000
                 sampling:  (input)
                 1 channel-specific attributes found:
                         attr 0: frequency value: 24000
         2 device-specific attributes found:
                         attr 0: freq value: 6144000
                         attr 1: out_en value: 0


Note that the sampling_frequency attr has been converted into an input channel.

Modify the definition in industrialio-core.c
	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
to
	[IIO_CHAN_INFO_SAMP_FREQ] = "samplingfrequency",

Results in the following output:
iio:device4: module0
         6 channels found:
                 voltage0:  (input)
                 6 channel-specific attributes found:
                         attr 0: scale value: 0.000149011
                         attr 1: raw value: 0
                         attr 2: hardwaregain value: 1
                         attr 3: index value: 0
                         attr 4: en value: 0
                         attr 5: type value: le:s24/32>>0
                 voltage1:  (input)
                 6 channel-specific attributes found:
                         attr 0: raw value: 0
                         attr 1: scale value: 0.000149011
                         attr 2: hardwaregain value: 1
                         attr 3: en value: 0
                         attr 4: index value: 1
                         attr 5: type value: le:s24/32>>0
                 voltage2:  (input)
                 6 channel-specific attributes found:
                         attr 0: raw value: 0
                         attr 1: scale value: 0.000149011
                         attr 2: hardwaregain value: 1
                         attr 3: en value: 0
                         attr 4: index value: 2
                         attr 5: type value: le:s24/32>>0
                 voltage3:  (input)
                 6 channel-specific attributes found:
                         attr 0: hardwaregain value: 1
                         attr 1: raw value: 0
                         attr 2: scale value: 0.000149011
                         attr 3: en value: 0
                         attr 4: type value: le:s24/32>>0
                         attr 5: index value: 3
                 voltage4:  (output)
                 2 channel-specific attributes found:
                         attr 0: raw value: 32768
                         attr 1: scale value: 2500000.000000000
                 voltage5:  (output)
                 2 channel-specific attributes found:
                         attr 0: raw value: 32768
                         attr 1: scale value: 2500000.000000000
         3 device-specific attributes found:
                         attr 0: freq value: 6144000
                         attr 1: in_samplingfrequency value: 24000
                         attr 2: out_en value: 0

Which makes more sense. So libiio is treating the name sampling as a channel name
in 'in_sampling_frequency' assuming that attributes never have an underscore in there name.

I'm guessing the same would be the case for out attributes as well.

A quick search of the drivers in the kernel to date indicate that IIO_CHAN_INFO_SAMP_FREQ is generally
shared by type or all. shared by dir occurs with the iio_simple_dummy, but can't see anything with a real device.
I'm using libiio from git://github.com/analogdevicesinc/libiio.git

So is this intended, or does libiio need to be smarter on identifying channels and shared attributes?
I'm guessing we cant change the kernel interface, which would be the easiest fix. :/


-- 
Regards
Phil Reid

