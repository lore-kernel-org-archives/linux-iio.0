Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35080 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbbGaNsb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2015 09:48:31 -0400
MIME-Version: 1.0
In-Reply-To: <CAKv63usNYi6RRVRfG9BMLtTCkdVoefm2K2mMd+wchS0avZ6yXA@mail.gmail.com>
References: <1438094234-2894-1-git-send-email-daniel.baluta@intel.com>
	<1438094234-2894-2-git-send-email-daniel.baluta@intel.com>
	<CAKv63usNYi6RRVRfG9BMLtTCkdVoefm2K2mMd+wchS0avZ6yXA@mail.gmail.com>
Date: Fri, 31 Jul 2015 16:48:28 +0300
Message-ID: <CAEnQRZASTP2i=nGuUodXjeU44JK5pTuBSF4Y-zFw-nJsWLc_Kg@mail.gmail.com>
Subject: Re: [PATCH v3] DocBook: Add initial documentation for IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Crt Mori <cmo@melexis.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Johnathan Iain Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, smueller@chronox.de,
	mmarek@suse.cz, linux-doc@vger.kernel.org,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Thanks a lot for review.

<snip>

>> +      Hwmon is very much directed at low sample rate sensors used in
>> +      applications such as fan speed control and temperature measurement. Input
>> +      is, as its name suggests, focused on human interaction input devices
>> +      (keyboard, mouse, touchscreen). In some cases there is considerable
>> +      overlap between these and IIO.
>
> I would make this first sentence in last paragraph more in sense:
> Hwmon is directed at low sample rate sensors used to monitor and control the
> system itself, like fan speed control and temperature measurement.

Agree.

<snip>

>> +    Usually these sensors are connected via SPI or I2C. It is also a common
>> +    use case to have combo functionality (e.g. light plus proximity sensor).
>
> I would spell it out: A common use case of the IIO devices is to
> provide combined
> functionality (e.g. illuminance plus proximity sensor)

Agree.

<snip>

>> +    Here <emphasis> scan_index </emphasis> defines the relative order in which
>> +    the enabled channels are placed inside the buffer, a channel with a lower
> I would change this line to:
> +   the enabled channels are placed inside the buffer. Channel with a lower
>> +    scan_index will be placed before a channel with a higher index. Each
>> +    channels needs to have a unique scan_index.

Agree.

>> +    </para>
>> +    <para>
>> +    It is important to realize that the scan_index does not define the
>> +    absolution position in the buffer. E.g. a channel with the scan_index = 3
> absolute position in buffer.

Correct :).

<snip>

>> +    <sect2 id="iiotrigsysfs"> <title> IIO trigger sysfs interface </title>
>> +      There are two locations in sysfs related to triggers:
>> +      <itemizedlist>
>> +        <listitem><filename>/sys/bus/iio/devices/triggerX</filename>,
> I am missing in here the information that X corresponds to deviceX

Triggers can be independent of devices, but indeed I changed it to
triggerY in order
to avoid confusion.

<snip>

>> +    <listitem><function> iio_buffer_setup_ops</function>, the buffer setup
>> +    functions to be called at predefined points in buffer configuration
> functions should be called at predefined points in buffer configuration
>> +    sequence (e.g. before enable, after disable). If not specified, the
>> +    IIO core uses the default <type>iio_triggered_buffer_setup_ops</type>.
>> +    </listitem>

Well, I'm not sure if I understand. iio_buffer_setup_ops is a
structure with function pointers
to be called at certain points in the trigger setup phase (before
enable, after disable
etc).  So, I think the phrasing is correct.


>> +    <listitem><function>sensor_iio_pollfunc</function>, the function that
>> +    will be used as top half of poll function. It usually does little
> ... It should do as little processing as possible, because it runs in
> interrupt context.

Agree.

I will send v4 asap.

thanks,
Daniel.
