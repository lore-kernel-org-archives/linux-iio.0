Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:49602 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130AbaIWQpx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Sep 2014 12:45:53 -0400
Received: by mail-la0-f53.google.com with SMTP id ge10so8847735lab.26
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2014 09:45:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54219C05.704@st.com>
References: <CAB=+8u0_aX3bhK-fz41+XG9oEkceuB-+=vkFb4w48au43wrk9g@mail.gmail.com>
 <54219C05.704@st.com>
From: Branko Karaklajic <orpid.yu@gmail.com>
Date: Tue, 23 Sep 2014 18:45:11 +0200
Message-ID: <CAB=+8u2MFup0EuvTtH=cBL3Qgf=7X_Svd+qoOT=Hj527NnSwQg@mail.gmail.com>
Subject: Re: Trigger (drdy) on st-sensor lis331dlh - how to question
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Denis,

thanks for fast response. I forget to say that we tried with all
possible configurations on interrupt. So, no luck with any setting. No
bump on irq handler at all.

Branko
On 23 September 2014 18:12, Denis CIOCCA <denis.ciocca@st.com> wrote:
> Hi Branko,
>
> It seems the problem is related to the gpio configuration.
>
>> Sensor <data ready> output is connected to Port D, pin 21 of CPU, and
>> device tree looks like:
>>
>> spi1: spi@f8008000 {
>>    cs-gpios = <&pioC 25 0>;
>>    status = "okay";
>>
>>    lis331dlh@0 {
>>        compatible = "st,lis331dlh-accel";
>>        spi-max-frequency = <10000000>;
>>        reg = <0>;
>>        interrupt-parent = <&pioD>;
>>        interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> interrupts = <21 0x0>;
>
> The IRQ is used in RISING.
>>        st,drdy-int-pin = <1>;
>>      };
>> };
>
> BR,
> Denis
>
>
>
>> and on boot up we got these messages:
>>
>> st-accel-spi spi32765.0: st_sensors_of_spi_probe() - lis331dlh.
>> iio iio:device0: st_sensors_check_device_support() - lis331dlh.
>> iio iio:device0: st_sensors_init_sensor().
>> iio iio:device0: st_sensors_set_drdy_int_pin() - drdy_int_pin=1.
>> iio iio:device0: st_accel_allocate_ring()
>> iio iio:device0: st_accel_common_probe() - irq: 172.
>> iio iio:device0: registered accelerometer lis331dlh
>>
>> As you can see, accelerometer is succesfully registered, and we are
>> able to read raw data with:
>>
>>      $ cat /sys/bus/iio/devices/iio:device0/in_accel_x_raw
>>
>> this is how our directory looks like:
>>      $ ls -al /sys/bus/iio/devices/
>> lrwxrwxrwx    1 root     root             0 Jan  1 00:17 iio:device0
>> -> ../../../devices/ahb/ahb:apb/f8008000.spi/spi_master/spi32765/spi32765.0/iio:device0
>> lrwxrwxrwx    1 root     root             0 Jan  1 00:17 trigger0 ->
>> ../../../devices/ahb/ahb:apb/f8008000.spi/spi_master/spi32765/spi32765.0/trigger0
>>
>> So trigger is also registred with name lis331dlh-trigger.
>>
>> dmsg line:
>> ...
>> iio iio:device0: st_accel_common_probe() - irq: 172.
>> ...
>> indicates that irq 172 (which is IRQ for Port D, pin 21) is registered
>> (which is also checked in /proc/irq).
>>
>> So, with all this set, we are not successful to get data from buffer.
>> Our first guess is to use generic_buffer.c, which we successfully
>> tried on internal ADC, but there is no data in buffer.
>>
>> Steps we are using are:
>> Enable channel in_accel_x_en in iio:device0/scan_elements
>> Write <lis331dlh-trigger> in iio:device0/trigger/current_trigger
>> Write length of 16 in iio:device0/buffer/length
>> Write 1 in iio:device0/buffer/enable
>>
>> That should be enough to get data into buffer by driver and than to
>> read it from buffer. Is that true? Did we missed something.
>>
>>  From HW point of view, we could see transition on interrupt pin when
>> we enable buffer, but no reading of data.
>>
>> Our understanding is that function <irqreturn_t
>> st_sensors_trigger_handler(int irq, void *p)> from file
>> linux/drivers/iio/common/st_sensors/st_sensors_buffer.c should be
>> called when interrupt is generated. Is this assumption correct? In our
>> case it's never called.
>>
>> Thanks in advance
>> Branko
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
