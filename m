Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33967 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdCZSv5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 14:51:57 -0400
Received: by mail-vk0-f46.google.com with SMTP id z204so31559641vkd.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Mar 2017 11:51:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <846DA1B1-BDAB-4CA3-8132-AC5594CC7019@jic23.retrosnub.co.uk>
References: <CALrZqyPPCGE0zZwrEcwBbOX75d7ZnA8E1in=6nJfN9xCf4rTvA@mail.gmail.com>
 <846DA1B1-BDAB-4CA3-8132-AC5594CC7019@jic23.retrosnub.co.uk>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Mon, 27 Mar 2017 00:21:56 +0530
Message-ID: <CALrZqyMAmsxn9rFmaG_k0TmOrz5yG+=n-40AcchPdcZ9K_0A7w@mail.gmail.com>
Subject: Re: Problem in loading module of Software trigger
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 26, 2017 at 1:47 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> Insmod will not pick up dependencies in the same way modprobe will.
>
> Make sure to also insmod industrialio.ko and iio-sw-trigger.ko before the sw trigger module. I
>  think those are the only ones you will need.

Thanks

modprobe works for me as it's depended on industrialio-sw-trigger.ko

But now I am facing one more probem with iio_generic_buffer in tools/iio

I am trying to execute iio_generic_buffer:
as given I can use -N <num>  -t <trigger_name>

I create trigger with name trig-sample present in
/config/iio/triggers/trig-sample.

$./iio_generic_buffer -N iio_dummy_part_no
iio device number being used is 0
Failed to find the trigger my_dummy_device-trigger

Its giving me ^ this error:

What wrong I am doing?

I have loaded all the modules including iio_dummy_evgen, iio_dummy.

How I will be pass trig-sample as an argument to it?
and one more question how can I find Trigger-number of a trigger.

I am facing same problem with iio_event_monitor:-

$ ./iio_event_monitor /sys/bus/iio/devices/iio_evgen/poke_ev0

getting following error:-
Failed to retrieve event fd

Same with all other events.

This is working fine for me:
echo 1 > /sys/bus/iio/devices/iio_evgen/poke_ev0

Thanks
Simran

>
> J
>
>
>
> On 26 March 2017 08:02:05 BST, SIMRAN SINGHAL <singhalsimran0@gmail.com> wrote:
>>I read this documentation "Documentation/iio/iio_configfs.txt" for
>>creating software trigger.
>>
>>So, by following this I created the module with name iio-trig-sample.c
>>in drivers/iio/trigger/.
>>
>>iio-trigger-sample.c also compiled successfully.
>>
>>Now, when I tried to insert module:
>>
>>$ sudo insmod iio-trig-sample.ko
>>insmod: ERROR: could not insert module iio-trig-sample.ko: Unknown
>>symbol in module
>>
>>Ans in /var/log/kern.log:
>>I am getting following reason:-
>>iio_trig_sample: Unknown symbol iio_unregister_sw_trigger_type (err 0)
>>iio_trig_sample: Unknown symbol iio_register_sw_trigger_type (err 0)
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
