Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <20150716042417.5d0ead50@lwn.net>
References: <1436357088-30743-1-git-send-email-daniel.baluta@intel.com> <1436357088-30743-2-git-send-email-daniel.baluta@intel.com> <20150716042417.5d0ead50@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] DocBook: Add initial documentation for IIO
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 16 Jul 2015 13:27:03 +0100
To: Jonathan Corbet <corbet@lwn.net>,Daniel Baluta <daniel.baluta@intel.com>
CC: jic23@kernel.org,pmeerw@pmeerw.net,knaack.h@gmx.de,lars@metafoo.de,linux-kernel@vger.kernel.org,linux-iio@vger.kernel.org
Message-ID: <9FA5531F-AF30-4BC6-BD66-3F117F41DA2E@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 16 July 2015 11:24:17 BST, Jonathan Corbet <corbet@lwn.net> wrote:
>On Wed,  8 Jul 2015 15:04:48 +0300
>Daniel Baluta <daniel.baluta@intel.com> wrote:
>
>> This is intended to help developers faster find their way
>> inside the Industrial I/O core and reduce time spent on IIO
>> drivers development.
>
>Seems like good stuff to have, sorry it's taken me so long to have a
>look
>at it.  Any other IIO folks want to send comments or an ack?
Will do. Bit of a backlog to catch up with.
 Probably Sunday before I get to this.. Or might review on phone later.

>
>A few comments of mine below...
>
>[...]
>> diff --git a/Documentation/DocBook/iio.tmpl
>b/Documentation/DocBook/iio.tmpl
>> new file mode 100644
>> index 0000000..417bb26
>> --- /dev/null
>> +++ b/Documentation/DocBook/iio.tmpl
>> @@ -0,0 +1,593 @@
>> +<?xml version="1.0" encoding="UTF-8"?>
>> +<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
>> +	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
>> +
>> +<book id="iioid">
>> +  <bookinfo>
>> +    <title>Industrial I/O driver developer's guide </title>
>> +
>> +    <authorgroup>
>> +      <author>
>> +        <firstname>Daniel</firstname>
>> +        <surname>Baluta</surname>
>> +        <affiliation>
>> +          <address>
>> +            <email>daniel.baluta@intel.com</email>
>> +          </address>
>> +        </affiliation>
>> +      </author>
>> +    </authorgroup>
>> +
>> +    <copyright>
>> +      <year>2015</year>
>> +      <holder>Intel Corporation</holder>
>> +    </copyright>
>> +
>> +    <legalnotice>
>> +      <para>
>> +        This documentation is free software; you can redistribute
>> +        it and/or modify it under the terms of the GNU General
>Public
>> +        License version 2.
>> +      </para>
>> +
>> +      <para>
>> +        This program is distributed in the hope that it will be
>> +        useful, but WITHOUT ANY WARRANTY; without even the implied
>> +        warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
>PURPOSE.
>> +        For more details see the file COPYING in the source
>> +        distribution of Linux.
>
>Do we really need this paragraph?  It's not even a "program" by some
>views,
>at least.
>
>> +      </para>
>> +    </legalnotice>
>> +  </bookinfo>
>> +
>> +  <toc></toc>
>> +
>> +  <chapter id="intro">
>> +    <title>Introduction</title>
>> +    <para>
>> +      The main purpose of the Industrial I/O subsystem (IIO) is to
>provide
>> +      support for devices that in some sense are analog to digital
>converts
>
>s/converts/converters/
>
>[...]
>> +    <sect2 id="iioattr"> <title> IIO device sysfs interface </title>
>> +      <para>
>> +        Attributes are sysfs files used to expose chip info and also
>allowing
>> +        applications to set various configuration parameters. Common
>> +        attributes are:
>> +        <itemizedlist>
>> +         
><listitem><filename>/sys/bus/iio/iio:deviceX/name</filename>,
>> +          description of the physical chip for device X.
>> +          </listitem>
>> +         
><listitem><filename>/sys/bus/iio/iio:deviceX/dev</filename>,
>> +            shows the major:minor pair associated with
>> +            /dev/iio:deviceX node.
>> +          </listitem>
>> +         
><listitem><filename>/sys/bus/iio:deviceX/sampling_frequency_available
>> +          </filename> available discrete set of sampling frequency
>values
>> +          for device X.
>> +          </listitem>
>> +      </itemizedlist>
>
>This list might be easier to read by proving the directory name once at
>the
>top, then just putting the attribute names here.
>
>> +      Available standard attributes for IIO devices are described in
>the
>> +      <filename>Documentation/ABI/testing/sysfs-bus-iio </filename>
>file
>> +      in the Linux kernel sources.
>
>Should that move out of testing at some point?
>
>[...]
>
>> +      An IIO channel is described by the <type> struct iio_chan_spec
>> +      </type>. A thermometer driver for the temperature sensor in
>the
>> +      example above would have to describe its channel as follows:
>> +      <programlisting>
>> +      static const struct iio_chan_spec temp_channel[] = {
>> +          {
>> +              .type = IIO_TEMP,
>> +              .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +          },
>> +      };
>> +      </programlisting>
>
>It seems we're skipping over the contents of .info_mask_separate?  IIO
>developers will need to know about that, right?
>
>> +      When there are multiple channels per device we need to set the
><type>
>> +      .modified </type> field of <type>iio_chan_spec</type> to 1.
>For example,
>> +      a light sensor can have two channels one, for infrared light
>and one for
>> +      both infrared and visible light.
>
>That seems really opaque.  What does ".modified" actually indicate?
>Clearly not the number of channels...
>
>> +      <programlisting>
>> +      static const struct iio_chan_spec light_channels[] = {
>> +          {
>> +              .type = IIO_INTENSITY,
>> +              .modified = 1,
>> +              .channel2 = IIO_MOD_LIGHT_IR,
>
>It seems like the contents of this field would be good to document too.
>
>[...]
>
>> +    <para> In order to be useful, a buffer needs to have an
>associated
>> +      trigger. Future chapters will add details about triggers and
>how
>> +      drivers use triggers to start data capture, moving samples
>from device
>> +      registers to buffer storage and then upward to user space
>applications.
>
>I'm gonna hold you to that! :)
>
>> +    </para>
>> +    </sect2>
>> +    <sect2 id="iiobuffersetup"> <title> IIO buffer setup </title>
>> +      <para>The important bits for selecting data channels
>> +      configuration are exposed to userspace applications via the
><filename>
>
>s/channels/channel/.  Even better would be "data-channel".
>
>> +      /sys/bus/iio/iio:deviceX/scan_elements/</filename> directory.
>This
>> +      file contains attributes of the following form:
>> +      <itemizedlist>
>> +      <listitem><emphasis>enable</emphasis>, used for enabling a
>channel.
>> +        If and only if his attribute is non zero, thena triggered
>capture
>
>s/his/its/; also fix "thena"
>
>> +        will contain data sample for this channel.
>
>sample*s*
>
>> +      </listitem>
>> +      <listitem><emphasis>type</emphasis>,  description of the scan
>element
>> +        data storage within the buffer and hence the form in which
>it is
>> +        read from user space. Format is <emphasis>
>> +        [be|le]:[s|u]bits/storagebits[>>shift] </emphasis>.
>
>OK, I'm slow, but this is not telling me much.  What's "scan element"?
>
>> +        <itemizedlist>
>> +        <listitem> <emphasis>be</emphasis> or
><emphasis>le</emphasis> specifies
>> +          big or little endian.
>> +        </listitem>
>> +        <listitem>
>> +        <emphasis>s </emphasis>or <emphasis>u</emphasis> specifies
>if
>> +        signed (2's complement) or unsigned.
>> +        </listitem>
>> +        <listitem>bits is the number of bits of data
>> +        </listitem>
>> +        <listitem>storagebits is the space (after padding) that it
>occupies in the
>> +          buffer.
>> +        </listitem>
>> +        <listitem>
>> +        <emphasis>shift</emphasis> if specified, is the shift that
>needs
>> +          to be a applied prior to masking out unused bits
>> +        </listitem>
>> +        </itemizedlist>
>> +      </listitem>
>> +      </itemizedlist>
>
>An example or two would be helpful here.
>
>> +      For implementing buffer support a driver should initialize the
>following
>> +      fields in <type>iio_chan_spec</type> definition:
>> +
>> +      <programlisting>
>> +      struct iio_chan_spec {
>> +          /* other members */
>> +          int scan_index
>> +          struct {
>> +              u8 realbits;
>> +              u8 storagebits;
>> +              u8 shift;
>> +              enum iio_endian endianness;
>> +          } scan_type;
>> +      }
>> +      </programlisting>
>> +      Here is what a 3-axis, 12 bits accelerometer channels
>definition
>> +      looks like with buffer support:
>
>channel.  (or maybe "channel's").
>
>> +      <programlisting>
>> +      struct struct iio_chan_spec accel_channels[] = {
>> +          {
>> +            .type = IIO_ACCEL,
>> +            .modified = 1,
>> +            .channel2 = IIO_MOD_X,
>> +            /* other stuff here */
>> +            .scan_index = 0,
>> +            .scan_type = {
>> +              .sign = 's',
>
>You didn't mention .sign above.  Why 's'?
>
>[...]
>> +    <listitem><function> iio_buffer_setup_ops</function>, buffer
>setup
>> +    functions to be called at predefined points in buffer
>configuration
>> +    sequence (e.g. before enable, after disable). If not specified,
>IIO
>> +    core uses default <type>iio_triggered_buffer_setup_ops</type>.
>
>*the* IIO core uses *the* default...
>
>> +    </listitem>
>> +    <listitem><function>sensor_iio_pollfunc</function>, function
>that
>
>*the* function...
>
>> +    will be used as top half of poll function. It usually does
>little
>> +    processing (as it runs in interrupt context). Most common
>operation
>
>*The* most common...  [starting a new theme here, it seems]
>
>> +    is recording of the current timestamp and for this reason one
>can
>> +    use the IIO core defined
><function>iio_pollfunc_store_time</function>
>> +    function.
>> +    </listitem>
>> +    <listitem><function>sensor_trigger_handler</function>, function
>that
>> +    will be used as bottom half of poll function. Here all the
>
>A couple more the's here, please
>
>> +    processing takes place. It usually reads data from the device
>and
>> +    stores it in the internal buffer together with the timestamp
>> +    recorded in the top half.
>> +    </listitem>
>> +    </itemizedlist>
>> +    </sect2>
>> +  </sect1>
>> +  </chapter>
>> +  <chapter id='iioresources'>
>> +    <title> Resources </title>
>> +      IIO core may change during time so the best documentation to
>read is the
>> +      source code. There are several locations where you should
>look:
>
>*The* IIO core.  So you say we're wasting our time with this file? :)
>
>> +      <itemizedlist>
>> +        <listitem>
>> +          <filename>drivers/iio/</filename>, contains the IIO core
>plus
>> +          and directories for each sensor type (e.g. accel,
>magnetometer,
>> +          etc.)
>> +        </listitem>
>> +        <listitem>
>> +          <filename>include/linux/iio/</filename>, contains the
>header
>> +          files, nice to read for the internal kernel interfaces.
>> +        </listitem>
>> +        <listitem>
>> +        <filename>include/uapi/linux/iio/</filename>, contains file
>to be
>
>file*s*
>
>> +          used by user space applications.
>
>Thanks,
>
>jon

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
