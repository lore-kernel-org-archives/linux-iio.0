Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36510 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734AbbHDJEz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 05:04:55 -0400
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCkRUzOjD-bBo8chpz4_6Aq-Jsaa36Coxbe00uwujSupA@mail.gmail.com>
References: <1438351461-19948-1-git-send-email-daniel.baluta@intel.com>
	<1438351461-19948-2-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1508031035001.9767@pmeerw.net>
	<CAEnQRZCkRUzOjD-bBo8chpz4_6Aq-Jsaa36Coxbe00uwujSupA@mail.gmail.com>
Date: Tue, 4 Aug 2015 12:04:53 +0300
Message-ID: <CAEnQRZC7cs03B6g-cbj8b-T2vjuETu50ZKUgVPPF_o8cWoJ5_A@mail.gmail.com>
Subject: Re: [PATCH v4] DocBook: Add initial documentation for IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry, hit send by mistake :)


>>> +      An IIO buffer has an associated attributes directory under <filename>
>>> +      /sys/bus/iio/iio:deviceX/buffer/</filename>. Here are the existing
>>> +      attributes:
>>> +      <itemizedlist>
>>> +      <listitem>
>>> +      <emphasis>length</emphasis>, number of data samples contained by the
>>> +        buffer.
>>
>> wording is not very clean; length is is the buffer length/capacity, not
>> the number of samples currently in the buffer
>
> Oh, I see. The same wording is in the ABI file:

http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L975

<snip>

>>> +        </listitem>
>>> +        <listitem><emphasis>bits</emphasis> is the number of bits of data
>>
>> number of data bits

Ok.

>>
>>> +        </listitem>
>>> +        <listitem><emphasis>storagebits</emphasis> is the space (after padding)
>>> +          that it occupies in the buffer.
>>
>> is the number of bits (after padding) that...

Ok.

>>
>>> +        </listitem>
>>> +        <listitem>
>>> +        <emphasis>shift</emphasis> if specified, is the shift that needs
>>> +          to be a applied prior to masking out unused bits
>>
>> that needs to be applied -- delete a

Ok.

>>
>>> +        </listitem>
>>> +        <listitem>
>>> +        <emphasis>repeat</emphasis>, specifies the number of real/storage bits
>>
>> what is real? -- undefined at this point;
>> "real/storage" doesn't make it clear if the padded or unpadded data bits
>> are repeated -- I think the later
>> maybe: "specifies the number of unpadded data repetitions"

Will fix.

>>
>>> +        repetitions. When the repeat element is 0 or 1, then the repeat
>>> +        value is omitted.
>>> +        </listitem>
>>> +        </itemizedlist>
>>> +      </listitem>
>>> +      </itemizedlist>
>>> +      For example, a driver for a 3-axis accelerometer with 12 bit
>>> +      resolution where data is stored in two 8-bits registers as
>>> +      follows:
>>> +      <programlisting>
>>> +        7   6   5   4   3   2   1   0
>>> +      +---+---+---+---+---+---+---+---+
>>> +      |D3 |D2 |D1 |D0 | X | X | X | X | (LOW byte, address 0x06)
>>> +      +---+---+---+---+---+---+---+---+
>>> +
>>> +        7   6   5   4   3   2   1   0
>>> +      +---+---+---+---+---+---+---+---+
>>> +      |D11|D10|D9 |D8 |D7 |D6 |D5 |D4 | (HIGH byte, address 0x07)
>>> +      +---+---+---+---+---+---+---+---+
>>> +      </programlisting>
>>> +
>>> +      will have the following scan element type for each axis:
>>> +      <programlisting>
>>> +      $ cat /sys/bus/iio/devices/iio:device0/scan_elements/in_accel_y_type
>>> +      le:s12/16>>4
>>> +      </programlisting>
>>> +      The userspace applications will interpret data samples read from buffer
>>
>> user space -- inconsistent
>> maybe "A user space application will..."
>> the buffer -- the
>>
>>> +      as two byte little endian signed data, that needs a 4 bits right
>>> +      shift before masking out the only 12 valid bits of real data.
>>
>> masking out the 12 valid bits of data

Agree.

>>
>>> +    </para>
>>> +    <para>
>>> +      For implementing buffer support a driver should initialize the following
>>> +      fields in <type>iio_chan_spec</type> definition:
>>> +      <programlisting>
>>> +          struct iio_chan_spec {
>>> +              /* other members */
>>> +              int scan_index
>>> +              struct {
>>> +                  char sign;
>>> +                  u8 realbits;
>>> +                  u8 storagebits;
>>> +                  u8 shift;
>>> +                  u8 repeat;
>>> +                  enum iio_endian endianness;
>>> +              } scan_type;
>>> +          };
>>> +      </programlisting>
>>> +      The driver implementing the accelerometer described above will
>>> +      have the following channel definition:
>>> +      <programlisting>
>>> +      struct struct iio_chan_spec accel_channels[] = {
>>> +          {
>>> +            .type = IIO_ACCEL,
>>> +            .modified = 1,
>>> +            .channel2 = IIO_MOD_X,
>>> +            /* other stuff here */
>>> +            .scan_index = 0,
>>> +            .scan_type = {
>>> +              .sign = 's',
>>> +              .realbits = 12,
>>> +              .storgebits = 16,
>>> +              .shift = 4,
>>> +              .endianness = IIO_LE,
>>> +            },
>>> +        }
>>> +        /* similar for Y and  Z axis */
>>
>> two spaces before Z
>> maybe: "similar for Y (with channel2 = IIO_MOD_Y, scan_index = 1) and Z
>> (with channel2 = IIO_MOD_Z, scan_index=2) axis"

Ok.

>>
>>> +    }
>>> +    </programlisting>
>>> +    </para>
>>> +    <para>
>>> +    Here <emphasis> scan_index </emphasis> defines the relative order in which
>>
>> why relative?
>> it is simply the order
>>
>>> +    the enabled channels are placed inside the buffer. Channels with a lower
>>> +    scan_index will be placed before channels with a higher index. Each
>>> +    channel needs to have a unique scan_index.
>>> +    </para>
>>> +    <para>
>>> +    It is important to realize that the scan_index does not define the
>>> +    absolute position in the buffer. E.g. a channel with the scan_index = 3
>>> +    will not be at offset 3 bytes or 3 words, but rather will be placed in the
>>> +    buffer after any channel with a scan_index lower than 3 and before
>>> +    any channel with a scan_index larger than 3.
>>
>> I'd drop the paragraph above, this is just confusing; better mention that
>> there are padding rules (e.g. for the timestamp channel) and it follows
>> that the scan_index is not a byte offset into the buffer

Will try to add a better wording for this, although it looks clear enough to me.

>>
>>> +    Furthermore the scan indices do not have to be consecutive. E.g. A
>>> +    channel spec array that defines 3 channels with the indices 1, 2 and 3 is
>>> +    just as valid as a channel spec that uses the indices 100, 200, 300. The
>>> +    relative order of the channels will be the same.
>>> +    </para>
>>> +    <para>
>>> +    Setting scan_index to -1 can be used to indicate that the specific
>>> +    channel does not support buffered capture. In this case no entries will
>>> +    be created for the channel in the scan_elements directory.
>>> +    </para>
>>> +    </sect2>
>>> +  </sect1>
>>> +
>>> +  <sect1 id="iiotrigger"> <title> Industrial I/O triggers  </title>
>>> +!Finclude/linux/iio/trigger.h iio_trigger
>>> +!Edrivers/iio/industrialio-trigger.c
>>> +    <para>
>>> +      In many situations it is useful for a driver to be able to
>>> +      capture data based on some external event (trigger) as opposed
>>> +      to periodically polling for data. An IIO trigger can be provided
>>> +      by a device driver that also has an IIO device based on hardware
>>> +      generated events (e.g. data ready or threshold exceeded) or
>>> +      provided by a separate driver from an independent interrupt
>>> +      source (e.g. GPIO line connected to some external system, timer
>>> +      interrupt or user space reading a specific file in sysfs). A
>>
>> writing a specific file
Ok.

>>
>>> +      trigger may initialize data capture for a number of sensors and
>>
>> initiate -- not initialize

:)

>>
>>> +      also it may be completely unrelated to the sensor itself.
>>> +    </para>
>>> +
>>> +    <sect2 id="iiotrigsysfs"> <title> IIO trigger sysfs interface </title>
>>> +      There are two locations in sysfs related to triggers:
>>> +      <itemizedlist>
>>> +        <listitem><filename>/sys/bus/iio/devices/triggerY</filename>,
>>> +          this file is created once an IIO triggered is registered with
>>
>> an IIO trigger

Ok.

>>
>>> +          the IIO core and corresponds to trigger with index Y. Because
>>> +          triggers can be very different depending on type there are few
>>> +          standard attributes that we can describe here:
>>> +          <itemizedlist>
>>> +            <listitem>
>>> +              <emphasis>name</emphasis>, trigger name that can be later
>>> +                used to for association with a device.
>>
>> used for association

:), ok.

>>
>>> +            </listitem>
>>> +            <listitem>
>>> +            <emphasis>sampling_frequency</emphasis>, some timer based
>>> +              triggers use this attribute to specify the frequency for
>>> +              trigger calls.
>>> +            </listitem>
>>> +          </itemizedlist>
>>> +        </listitem>
>>> +        <listitem>
>>> +          <filename>/sys/bus/iio/devices/iio:deviceX/trigger/</filename>, this
>>> +          directory is created once the device supports a triggered
>>> +          buffer. We can associate a trigger with our device by writing
>>> +            trigger's name in the<filename>current_trigger</filename> file.
>>
>> the trigger's name -- the
>> the <filename> -- add space before tag
>>
>>> +        </listitem>
>>> +      </itemizedlist>
>>> +    </sect2>
>>> +
>>> +    <sect2 id="iiotrigattr"> <title> IIO trigger setup</title>
>>> +
>>> +    <para>
>>> +      Let's see a simple example of how to setup a trigger to be used
>>> +      by a driver.
>>> +
>>> +      <programlisting>
>>> +      struct iio_trigger_ops trigger_ops = {
>>> +          .set_trigger_state = sample_trigger_state,
>>> +          .validate_device = sample_validate_device,
>>> +      }
>>> +
>>> +      struct iio_trigger *trig;
>>> +
>>> +      /* first, allocate memory for our trigger */
>>> +      trig = iio_trigger_alloc(dev, "trig-%s-%d", name, idx);
>>> +
>>> +      /* setup trigger operations field */
>>> +      trig->ops = &amp;trigger_ops;
>>> +
>>> +      /* now register the trigger with the IIO core */
>>> +      iio_trigger_register(trig);
>>> +      </programlisting>
>>> +    </para>
>>> +    </sect2>
>>> +
>>> +    <sect2 id="iiotrigsetup"> <title> IIO trigger ops</title>
>>> +!Finclude/linux/iio/trigger.h iio_trigger_ops
>>> +     <para>
>>> +        Notice that a trigger has a set of operations attached:
>>> +        <itemizedlist>
>>> +        <listitem>
>>> +          <function>set_trigger_state</function>, switch the trigger on/off
>>> +          on demand.
>>> +        </listitem>
>>> +        <listitem>
>>> +          <function>validate_device</function>, function to validate the
>>> +          device when the current trigger gets changed.
>>> +        </listitem>
>>> +        </itemizedlist>
>>> +      </para>
>>> +    </sect2>
>>> +  </sect1>
>>> +  <sect1 id="iiotriggered_buffer">
>>> +    <title> Industrial I/O triggered buffers </title>
>>> +    <para>
>>> +    Now that we know what buffers and triggers are let's see how they
>>> +    work together.
>>> +    </para>
>>> +    <sect2 id="iiotrigbufsetup"> <title> IIO triggered buffer setup</title>
>>> +!Edrivers/iio/industrialio-triggered-buffer.c
>>> +!Finclude/linux/iio/iio.h iio_buffer_setup_ops
>>> +
>>> +
>>> +    <para>
>>> +    A typical triggered buffer setup looks like this:
>>> +    <programlisting>
>>> +    const struct iio_buffer_setup_ops sensor_buffer_setup_ops = {
>>> +      .preenable    = sensor_buffer_preenable,
>>> +      .postenable   = sensor_buffer_postenable,
>>> +      .postdisable  = sensor_buffer_postdisable,
>>> +      .predisable   = sensor_buffer_predisable,
>>> +    };
>>> +
>>> +    irqreturn_t sensor_iio_pollfunc(int irq, void *p)
>>> +    {
>>> +        pf->timestamp = iio_get_time_ns();
>>> +        return IRQ_WAKE_THREAD;
>>> +    }
>>> +
>>> +    irqreturn_t sensor_trigger_handler(int irq, void *p)
>>> +    {
>>> +        u16 buf[8];
>>
>> int i = 0;
>>
>>> +
>>> +        /* read data for each active channel */
>>> +        for_each_set_bit(bit, active_scan_mask, masklength)
>>> +            buf[i++] = sensor_get_data(bit)
>>> +
>>> +        iio_push_to_buffers_with_timestamp(indio_dev, buffer, timestamp);
>>
>> buf -- not buffer
ok.

>>
>>> +
>>> +        iio_trigger_notify_done(trigger);
>>
>> return IRQ_HANDLED;

ok.

>>
>>> +    }
>>> +
>>> +    /* setup triggered buffer, usually in probe function */
>>> +    iio_triggered_buffer_setup(indio_dev, sensor_iio_polfunc,
>>> +                               sensor_trigger_handler,
>>> +                               sensor_buffer_setup_ops);
>>> +    </programlisting>
>>> +    </para>
>>> +    The important things to notice here are:
>>> +    <itemizedlist>
>>> +    <listitem><function> iio_buffer_setup_ops</function>, the buffer setup
>>> +    functions to be called at predefined points in buffer configuration
>>
>> the buffer configuration -- the

ok.
