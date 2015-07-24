Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-122.synserver.de ([212.40.185.122]:1116 "EHLO
	smtp-out-122.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbGXO6g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 10:58:36 -0400
Message-ID: <55B25295.303@metafoo.de>
Date: Fri, 24 Jul 2015 16:58:29 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org,
	corbet@lwn.net, rdunlap@infradead.org
CC: pmeerw@pmeerw.net, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, herbert@gondor.apana.org.au,
	smueller@chronox.de, mmarek@suse.cz, linux-doc@vger.kernel.org,
	cristina.opriceana@gmail.com
Subject: Re: [PATCH v2] DocBook: Add initial documentation for IIO
References: <1437468216-12079-1-git-send-email-daniel.baluta@intel.com> <1437468216-12079-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1437468216-12079-2-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/21/2015 10:43 AM, Daniel Baluta wrote:
> This is intended to help developers faster find their way
> inside the Industrial I/O core and reduce time spent on IIO
> drivers development.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>

Thanks for doing this.

> diff --git a/Documentation/DocBook/iio.tmpl b/Documentation/DocBook/iio.tmpl
> new file mode 100644
> index 0000000..73b32b3
> --- /dev/null
> +++ b/Documentation/DocBook/iio.tmpl
> @@ -0,0 +1,680 @@
> +<?xml version="1.0" encoding="UTF-8"?>
> +<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
> +	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
> +
> +<book id="iioid">
> +  <bookinfo>
> +    <title>Industrial I/O driver developer's guide </title>
> +
> +    <authorgroup>
> +      <author>
> +        <firstname>Daniel</firstname>
> +        <surname>Baluta</surname>
> +        <affiliation>
> +          <address>
> +            <email>daniel.baluta@intel.com</email>
> +          </address>
> +        </affiliation>
> +      </author>
> +    </authorgroup>
> +
> +    <copyright>
> +      <year>2015</year>
> +      <holder>Intel Corporation</holder>
> +    </copyright>
> +
> +    <legalnotice>
> +      <para>
> +        This documentation is free software; you can redistribute
> +        it and/or modify it under the terms of the GNU General Public
> +        License version 2.
> +      </para>
> +    </legalnotice>
> +  </bookinfo>
> +
> +  <toc></toc>
> +
> +  <chapter id="intro">
> +    <title>Introduction</title>
> +    <para>
> +      The main purpose of the Industrial I/O subsystem (IIO) is to provide
> +      support for devices that in some sense are analog to digital converters
> +      (ADCs). As many actual devices combine some ADCs with digital to analog
> +      converters (DACs), that functionality is also supported.

I wouldn't necessarily treat DACs and ADCs differently here. Maybe something 
like:

   The main purpose of the Industrial I/O subsystem (IIO) is to provide
   support for devices that in some sense perform either analog-to-digital
   conversion (ADC) or digital-to-analog conversion (DAC) or both.

[...]
> +
> +  <sect1 id="iiobuffer"> <title> Industrial I/O buffers </title>
> +!Finclude/linux/iio/buffer.h iio_buffer
> +!Edrivers/iio/industrialio-buffer.c
> +
> +    <para>
> +    The Industrial I/O core offers a way for continuous data capture
> +    based on a trigger source. Multiple data channels can be read at once
> +    from <filename>/dev/iio:deviceX</filename> character device node,
> +    thus reducing the CPU load.
> +    </para>
> +
> +    <sect2 id="iiobuffersysfs">
> +    <title>IIO buffer sysfs interface </title>
> +    <para>
> +      An IIO buffer has an associated attributes directory under <filename>
> +      /sys/bus/iio/iio:deviceX/buffer/</filename>. Here are the existing
> +      attributes:
> +      <itemizedlist>
> +      <listitem>
> +      <emphasis>length</emphasis>, number of data samples contained by the
> +        buffer.
> +      </listitem>
> +      <listitem>
> +        <emphasis>enable</emphasis>, activate buffer capture.
> +      </listitem>
> +      </itemizedlist>
> +    </para>
> +    <para> In order to be useful, a buffer needs to have an associated
> +      trigger. Future chapters will add details about triggers and how
> +      drivers use triggers to start data capture, moving samples from device
> +      registers to buffer storage and then upward to user space applications.

Buffers don't have to have a trigger, only triggered buffers need them. 
Although admittedly most buffers will be triggered buffers. I think it's 
better to talk about buffers in general first and then discuss the different 
types of buffers and when to use them. In this context it should be 
mentioned that a triggered buffer needs a trigger to function.	

> +    </para>
> +    </sect2>
> +    <sect2 id="iiobuffersetup"> <title> IIO buffer setup </title>
> +      <para>The meta information associated with a channel reading
> +        placed in a buffer is called a <emphasis> scan element </emphasis>.
> +        The important bits configuring scan elements are exposed to
> +        userspace applications via the <filename>
> +        /sys/bus/iio/iio:deviceX/scan_elements/</filename> directory. This
> +        file contains attributes of the following form:
> +      <itemizedlist>
> +      <listitem><emphasis>enable</emphasis>, used for enabling a channel.
> +        If and only if its attribute is non zero, then a triggered capture
> +        will contain data samples for this channel.
> +      </listitem>
> +      <listitem><emphasis>type</emphasis>, description of the scan element
> +        data storage within the buffer and hence the form in which it is
> +        read from user space. Format is <emphasis>
> +        [be|le]:[s|u]bits/storagebits[>>shift] </emphasis>.
> +        <itemizedlist>
> +        <listitem> <emphasis>be</emphasis> or <emphasis>le</emphasis> specifies
> +          big or little endian.
> +        </listitem>
> +        <listitem>
> +        <emphasis>s </emphasis>or <emphasis>u</emphasis> specifies if
> +          signed (2's complement) or unsigned.
> +        </listitem>
> +        <listitem><emphasis>bits</emphasis> is the number of bits of data
> +        </listitem>
> +        <listitem><emphasis>storagebits</emphasis> is the space (after padding)
> +          that it occupies in the buffer.
> +        </listitem>
> +        <listitem>
> +        <emphasis>shift</emphasis> if specified, is the shift that needs
> +          to be a applied prior to masking out unused bits
> +        </listitem>
> +        </itemizedlist>

The scan type gained a repeat field a while ago.

> +      </listitem>
> +      </itemizedlist>
> +      For example, a driver for a 3-axis accelerometer with 12 bit
> +      resolution where data is stored in two 8-bits registers as
> +      follows:
> +      <programlisting>
> +        7   6   5   4   3   2   1   0
> +      +---+---+---+---+---+---+---+---+
> +      |D3 |D2 |D1 |D0 | X | X | X | X | (LOW byte, address 0x06)
> +      +---+---+---+---+---+---+---+---+
> +
> +        7   6   5   4   3   2   1   0
> +      +---+---+---+---+---+---+---+---+
> +      |D11|D10|D9 |D8 |D7 |D6 |D5 |D4 | (HIGH byte, address 0x07)
> +      +---+---+---+---+---+---+---+---+
> +      </programlisting>
> +
> +      will have the following scan element type for each axis:
> +      <programlisting>
> +      $ cat /sys/bus/iio/devices/iio:device0/scan_elements/in_accel_y_type
> +      le:s12/16>>4
> +      </programlisting>
> +      The userspace applications will interpret data samples read from buffer
> +      as two byte little endian signed data, that needs a 4 bits right
> +      shift before masking out the only 12 valid bits of real data.
> +    </para>
> +    <para>
> +      For implementing buffer support a driver should initialize the following
> +      fields in <type>iio_chan_spec</type> definition:
> +      <programlisting>
> +          struct iio_chan_spec {
> +              /* other members */
> +              int scan_index
> +              struct {
> +                  char sign;
> +                  u8 realbits;
> +                  u8 storagebits;
> +                  u8 shift;
> +                  enum iio_endian endianness;
> +              } scan_type;
> +          };
> +      </programlisting>
> +      The driver implementing the accelerometer described above will
> +      have the following channel definition:
> +      <programlisting>
> +      struct struct iio_chan_spec accel_channels[] = {
> +          {
> +            .type = IIO_ACCEL,
> +            .modified = 1,
> +            .channel2 = IIO_MOD_X,
> +            /* other stuff here */
> +            .scan_index = 0,
> +            .scan_type = {
> +              .sign = 's',
> +              .realbits = 12,
> +              .storgebits = 16,
> +              .shift = 4,
> +              .endianness = IIO_LE,
> +            },
> +        }
> +        /* similar for Y and  Z axis */
> +    }
> +    </programlisting>
> +    Here <emphasis> scan_index </emphasis> is used for ordering data samples
> +    (scans) when read from buffer.

A bit more:

   scan_index defines the relative order in which the enabled channels
   are placed inside the buffer, a channel with a lower scan_index will be
   placed before a channel with a higher index. Each channels needs to have
   a unique scan_index.

   It is important to realize that the scan_index does not define the
   absolution position in the buffer. E.g. a channel with the scan_index = 3
   will not be at offset 3 bytes or 3 words, but rather will be placed in
   the buffer after any channel with a scan_index lower than 3 and before
   any channel with a scan_index larger than 3.

   Furthermore the scan indices do not have to be consecutive. E.g. A
   channel spec array that defines 3 channels with the indices 1, 2 and 3 is
   just as valid as a channel spec that uses the indices 100, 200, 300. The
   relative order of the channels will be the same.

   Setting scan_index to -1 can be used to indicate that the specific
   channel does not support buffered capture. In this case no entries will
   be created for the channel in the scan_elements directory.


Otherwise looks good to me.

- Lars
