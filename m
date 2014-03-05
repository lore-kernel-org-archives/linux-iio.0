Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-163.synserver.de ([212.40.185.163]:1031 "EHLO
	smtp-out-014.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753090AbaCEObP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Mar 2014 09:31:15 -0500
Message-ID: <5317354E.9050803@metafoo.de>
Date: Wed, 05 Mar 2014 15:31:42 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: Paul Cercueil <paul.cercueil@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [RFC] LIBIIO
References: <53146822.5020602@analog.com> <201403051112.51519.manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <201403051112.51519.manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/2014 11:12 AM, Manuel Stahl wrote:
> Hi Paul,
>
> I didn't read all of your text (will do later), but would like to point out that there is alreay a project going on here:
> http://sourceforge.net/projects/iioutils/

Well, the iioutils lib is extremely low level. It is basically just a bunch 
of fprintfs and fscanfs. The libiio has a more high level abstraction build 
in. The basic structure of the libiio is the iio_context, it is a (to the 
user transparent) struct that is used for all operations (E.g. like 
get_devices()). If an application wants to do something it first allocates a 
context, there can be multiple contexts per application and each contexts 
tracks is own state, so there is no globally shared state. Each context has 
a backed. One backend is the local backend that performs all operations on 
device the application is running on. But there is also a network backend 
that connects to a sever running on a different device. This allows to run 
the same application on local and remote the devices without the application 
having to have any special code for supporting this.

There is also a IIO daemon that can sit between the application and the IIO 
sysfs. This daemon allows for multiple applications accessing the same 
device without trampling over each others feet and also allows to run the 
application without root rights.

My hopes are that the libiio can eventually replace the iio-utils lib.

- Lars

>
> You're very welcome to contribute.
>
> Regards,
> Manuel Stahl
>
> Am Montag, 3. März 2014, 12:31:46 schrieb Paul Cercueil:
>> Hi there,
>>
>> I would like to present the project I've been working on for the past
>> two weeks: libiio, a library for interfacing IIO devices.
>> Available here: https://github.com/analogdevicesinc/libiio
>>
>> As it is still in its infancy, I would like to receive feedback about
>> the API, what is good, what would you change etc.
>>
>> The API provides a couple of top-level functions to create a context,
>> either bound to the local IIO devices through sysfs, to a XML
>> representation, or to a remote server. This context structure (struct
>> iio_context) contains a list of devices and the context-specific
>> low-level operations to interact with them.
>>
>>   From the context structure it is possible to retrieve the structures
>> representing the devices (struct iio_device). Devices have an ID, a
>> name, attributes and channels.
>>
>> Attributes essentially correspond to files in sysfs. For instance, the
>> attribute "sampling_frequency" of the device with the ID "iio:device0"
>> matches the file "/sys/bus/iio/devices/iio:device0/sampling_frequency".
>> The API provides functions to read or write attributes.
>>
>> Channels (struct iio_channel) represent a measure channel of a ADC or a
>> control channel of an DAC. In the local context, the channels are
>> deduced from the filenames in sysfs. For example, the file
>> "out_voltage0_vccout_offset" translates to an output channel with ID
>> "voltage0", name "vccout" featuring an attribute named "offset".
>>
>> The following sysfs files, for instance, would create the following tree:
>>
>> root:/> ls -1 -p /sys/bus/iio/devices/iio:device0
>> buffer/
>> dev
>> ...
>> in_magn_filter_low_pass_3db_frequency
>> in_magn_scale
>> in_magn_x_raw
>> in_magn_y_raw
>> in_magn_z_raw
>> name
>> power/
>> sampling_frequency
>> scan_elements/
>> subsystem
>> trigger/
>> uevent
>>
>> ---
>>
>> IIO context has 1 devices:
>> 	iio:device0: adis16488
>> 		11 channels found:
>> 			...
>> 			magn_x:  (input)
>> 			4 channel-specific attributes found:
>> 				attr 0: calibbias
>> 				attr 1: filter_low_pass_3db_frequency
>> 				attr 2: raw
>> 				attr 3: scale
>> 			magn_y:  (input)
>> 			4 channel-specific attributes found:
>> 				attr 0: calibbias
>> 				attr 1: filter_low_pass_3db_frequency
>> 				attr 2: raw
>> 				attr 3: scale
>> 			magn_z:  (input)
>> 			4 channel-specific attributes found:
>> 				attr 0: calibbias
>> 				attr 1: filter_low_pass_3db_frequency
>> 				attr 2: raw
>> 				attr 3: scale
>> 		1 device-specific attributes found:
>> 				attr 0: sampling_frequency
>>
>> ---
>>
>> The API provides ways to read and write a stream of values. Either the
>> raw stream (basically reading/writing the dev node directly), or a
>> processed stream, corresponding to a single channel, with an optional
>> conversion step. In this case, the conversion is automatically deduced
>> from the attributes, notably the "scale" attribute.
>>
>> One recurring issue when working with IIO devices, is that only one
>> application can use an IIO device at a time. I intend to address that
>> issue by developping a network daemon (called iiod, that's original)
>> that would use the local backend of the libiio library, and stream the
>> data from/to a device from/to all of its connected clients. The clients
>> would then just be applications compiled with the libiio library, and
>> using the network backend of the library (note that switching between
>> backends is just a matter of creating the iio_context structure with a
>> different function). Once that works, a specific daemon / libiio backend
>> couple could be designed using fast SHM mechanism for high-speed
>> concurrent local access to the devices.
>>
>> As I may be overseeing certain things or missing others, I would like to
>> know what is your opinion of the API and the library so far, and if you
>> would use such a library. The feedback is important to me so that the
>> project moves in the right direction.
>>
>> Thanks,
>>
>> Paul
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

