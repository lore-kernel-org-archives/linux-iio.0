Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:22300 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753575AbaCCLcl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Mar 2014 06:32:41 -0500
Received: from mail11-tx2 (localhost [127.0.0.1])	by mail11-tx2-R.bigfish.com
 (Postfix) with ESMTP id AD6F61A04CC	for <linux-iio@vger.kernel.org>; Mon,  3
 Mar 2014 11:32:39 +0000 (UTC)
Received: from TX2EHSMHS011.bigfish.com (unknown [10.9.14.248])	by
 mail11-tx2.bigfish.com (Postfix) with ESMTP id 100DF3000F9	for
 <linux-iio@vger.kernel.org>; Mon,  3 Mar 2014 11:32:38 +0000 (UTC)
Received: from NWD2HUBCAS5.ad.analog.com (nwd2hubcas5.ad.analog.com
 [10.64.72.161])	by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id
 s23DoANw028126	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-iio@vger.kernel.org>; Mon, 3 Mar 2014 08:50:11 -0500
Received: from [10.44.2.173] ([10.44.2.173])	by zeus.spd.analog.com
 (8.14.6/8.14.6) with ESMTP id s23BVkME017381	for <linux-iio@vger.kernel.org>;
 Mon, 3 Mar 2014 06:31:47 -0500
Message-ID: <53146822.5020602@analog.com>
Date: Mon, 3 Mar 2014 12:31:46 +0100
From: Paul Cercueil <paul.cercueil@analog.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>
Subject: [RFC] LIBIIO
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi there,

I would like to present the project I've been working on for the past 
two weeks: libiio, a library for interfacing IIO devices.
Available here: https://github.com/analogdevicesinc/libiio

As it is still in its infancy, I would like to receive feedback about 
the API, what is good, what would you change etc.

The API provides a couple of top-level functions to create a context, 
either bound to the local IIO devices through sysfs, to a XML 
representation, or to a remote server. This context structure (struct 
iio_context) contains a list of devices and the context-specific 
low-level operations to interact with them.

 From the context structure it is possible to retrieve the structures 
representing the devices (struct iio_device). Devices have an ID, a 
name, attributes and channels.

Attributes essentially correspond to files in sysfs. For instance, the 
attribute "sampling_frequency" of the device with the ID "iio:device0" 
matches the file "/sys/bus/iio/devices/iio:device0/sampling_frequency".
The API provides functions to read or write attributes.

Channels (struct iio_channel) represent a measure channel of a ADC or a 
control channel of an DAC. In the local context, the channels are 
deduced from the filenames in sysfs. For example, the file 
"out_voltage0_vccout_offset" translates to an output channel with ID 
"voltage0", name "vccout" featuring an attribute named "offset".

The following sysfs files, for instance, would create the following tree:

root:/> ls -1 -p /sys/bus/iio/devices/iio:device0
buffer/
dev
...
in_magn_filter_low_pass_3db_frequency
in_magn_scale
in_magn_x_raw
in_magn_y_raw
in_magn_z_raw
name
power/
sampling_frequency
scan_elements/
subsystem
trigger/
uevent

---

IIO context has 1 devices:
	iio:device0: adis16488
		11 channels found:
			...
			magn_x:  (input)
			4 channel-specific attributes found:
				attr 0: calibbias
				attr 1: filter_low_pass_3db_frequency
				attr 2: raw
				attr 3: scale
			magn_y:  (input)
			4 channel-specific attributes found:
				attr 0: calibbias
				attr 1: filter_low_pass_3db_frequency
				attr 2: raw
				attr 3: scale
			magn_z:  (input)
			4 channel-specific attributes found:
				attr 0: calibbias
				attr 1: filter_low_pass_3db_frequency
				attr 2: raw
				attr 3: scale
		1 device-specific attributes found:
				attr 0: sampling_frequency

---

The API provides ways to read and write a stream of values. Either the 
raw stream (basically reading/writing the dev node directly), or a 
processed stream, corresponding to a single channel, with an optional 
conversion step. In this case, the conversion is automatically deduced 
from the attributes, notably the "scale" attribute.

One recurring issue when working with IIO devices, is that only one 
application can use an IIO device at a time. I intend to address that 
issue by developping a network daemon (called iiod, that's original) 
that would use the local backend of the libiio library, and stream the 
data from/to a device from/to all of its connected clients. The clients 
would then just be applications compiled with the libiio library, and 
using the network backend of the library (note that switching between 
backends is just a matter of creating the iio_context structure with a 
different function). Once that works, a specific daemon / libiio backend 
couple could be designed using fast SHM mechanism for high-speed 
concurrent local access to the devices.

As I may be overseeing certain things or missing others, I would like to 
know what is your opinion of the API and the library so far, and if you 
would use such a library. The feedback is important to me so that the 
project moves in the right direction.

Thanks,

Paul

