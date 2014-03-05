Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49957 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbaCER36 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Mar 2014 12:29:58 -0500
In-Reply-To: <53146822.5020602@analog.com>
References: <53146822.5020602@analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] LIBIIO
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 05 Mar 2014 17:29:45 +0000
To: Paul Cercueil <paul.cercueil@analog.com>, linux-iio@vger.kernel.org
Message-ID: <cb4c6767-3817-4d26-b397-cbfd36050abc@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Paul

Looks good. I will have a more detailed look at some point.

Just been browsing headers.  One trivial point...
Try to keep function naming consistent.
I would expect create functions to be named like

iio_context_xml_create etc rather than iio_create...

Your destroy etc are that way around. Note I actually had a similar mess in early kernel iio interfaces :)

I haven't look in detail but it would be nice to hide some of the complexity of attribute
 sharing so if someone queries sampling frequency for a channel, the fact it is
 specified for a device is hidden. This might involve one attr appearing in multiple places in your hierarchy. Is this something you
 would consider?  Write semantics are more complex though.
Also beware that according to the abi, any write to an attribute can change any other
 attribute (there are sanity restrictions though)

Just quick thoughts! Sorry for top posting:)

Jonathan


On March 3, 2014 11:31:46 AM GMT+00:00, Paul Cercueil <paul.cercueil@analog.com> wrote:
>Hi there,
>
>I would like to present the project I've been working on for the past 
>two weeks: libiio, a library for interfacing IIO devices.
>Available here: https://github.com/analogdevicesinc/libiio
>
>As it is still in its infancy, I would like to receive feedback about 
>the API, what is good, what would you change etc.
>
>The API provides a couple of top-level functions to create a context, 
>either bound to the local IIO devices through sysfs, to a XML 
>representation, or to a remote server. This context structure (struct 
>iio_context) contains a list of devices and the context-specific 
>low-level operations to interact with them.
>
> From the context structure it is possible to retrieve the structures 
>representing the devices (struct iio_device). Devices have an ID, a 
>name, attributes and channels.
>
>Attributes essentially correspond to files in sysfs. For instance, the 
>attribute "sampling_frequency" of the device with the ID "iio:device0" 
>matches the file "/sys/bus/iio/devices/iio:device0/sampling_frequency".
>The API provides functions to read or write attributes.
>
>Channels (struct iio_channel) represent a measure channel of a ADC or a
>
>control channel of an DAC. In the local context, the channels are 
>deduced from the filenames in sysfs. For example, the file 
>"out_voltage0_vccout_offset" translates to an output channel with ID 
>"voltage0", name "vccout" featuring an attribute named "offset".
>
>The following sysfs files, for instance, would create the following
>tree:
>
>root:/> ls -1 -p /sys/bus/iio/devices/iio:device0
>buffer/
>dev
>...
>in_magn_filter_low_pass_3db_frequency
>in_magn_scale
>in_magn_x_raw
>in_magn_y_raw
>in_magn_z_raw
>name
>power/
>sampling_frequency
>scan_elements/
>subsystem
>trigger/
>uevent
>
>---
>
>IIO context has 1 devices:
>	iio:device0: adis16488
>		11 channels found:
>			...
>			magn_x:  (input)
>			4 channel-specific attributes found:
>				attr 0: calibbias
>				attr 1: filter_low_pass_3db_frequency
>				attr 2: raw
>				attr 3: scale
>			magn_y:  (input)
>			4 channel-specific attributes found:
>				attr 0: calibbias
>				attr 1: filter_low_pass_3db_frequency
>				attr 2: raw
>				attr 3: scale
>			magn_z:  (input)
>			4 channel-specific attributes found:
>				attr 0: calibbias
>				attr 1: filter_low_pass_3db_frequency
>				attr 2: raw
>				attr 3: scale
>		1 device-specific attributes found:
>				attr 0: sampling_frequency
>
>---
>
>The API provides ways to read and write a stream of values. Either the 
>raw stream (basically reading/writing the dev node directly), or a 
>processed stream, corresponding to a single channel, with an optional 
>conversion step. In this case, the conversion is automatically deduced 
>from the attributes, notably the "scale" attribute.
>
>One recurring issue when working with IIO devices, is that only one 
>application can use an IIO device at a time. I intend to address that 
>issue by developping a network daemon (called iiod, that's original) 
>that would use the local backend of the libiio library, and stream the 
>data from/to a device from/to all of its connected clients. The clients
>
>would then just be applications compiled with the libiio library, and 
>using the network backend of the library (note that switching between 
>backends is just a matter of creating the iio_context structure with a 
>different function). Once that works, a specific daemon / libiio
>backend 
>couple could be designed using fast SHM mechanism for high-speed 
>concurrent local access to the devices.
>
>As I may be overseeing certain things or missing others, I would like
>to 
>know what is your opinion of the API and the library so far, and if you
>
>would use such a library. The feedback is important to me so that the 
>project moves in the right direction.
>
>Thanks,
>
>Paul
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
