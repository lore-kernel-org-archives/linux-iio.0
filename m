Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36597 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdC0HqC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 03:46:02 -0400
Received: by mail-it0-f46.google.com with SMTP id e75so11910298itd.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2017 00:45:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALrZqyMAmsxn9rFmaG_k0TmOrz5yG+=n-40AcchPdcZ9K_0A7w@mail.gmail.com>
References: <CALrZqyPPCGE0zZwrEcwBbOX75d7ZnA8E1in=6nJfN9xCf4rTvA@mail.gmail.com>
 <846DA1B1-BDAB-4CA3-8132-AC5594CC7019@jic23.retrosnub.co.uk> <CALrZqyMAmsxn9rFmaG_k0TmOrz5yG+=n-40AcchPdcZ9K_0A7w@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 27 Mar 2017 10:38:17 +0300
Message-ID: <CAEnQRZAmF3K+FnqVsSUGnH6v6_CFXaX+2edYSz__esJVgDyzyg@mail.gmail.com>
Subject: Re: Problem in loading module of Software trigger
To: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Sun, Mar 26, 2017 at 9:51 PM, SIMRAN SINGHAL
<singhalsimran0@gmail.com> wrote:
> On Sun, Mar 26, 2017 at 1:47 PM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
>> Insmod will not pick up dependencies in the same way modprobe will.
>>
>> Make sure to also insmod industrialio.ko and iio-sw-trigger.ko before the sw trigger module. I
>>  think those are the only ones you will need.
>
> Thanks
>
> modprobe works for me as it's depended on industrialio-sw-trigger.ko
>
> But now I am facing one more probem with iio_generic_buffer in tools/iio
>
> I am trying to execute iio_generic_buffer:
> as given I can use -N <num>  -t <trigger_name>
>
> I create trigger with name trig-sample present in
> /config/iio/triggers/trig-sample.

How did you create the trigger here?

The trigger must be created according to its type. So far
we have only hrtimer trigger type, so creating a trigger
implies creating a directory in:

/config/iio/triggers/hrtimer

See:

http://lxr.free-electrons.com/source/Documentation/iio/iio_configfs.txt#L83
>
> $./iio_generic_buffer -N iio_dummy_part_no
> iio device number being used is 0
> Failed to find the trigger my_dummy_device-trigger
>
> Its giving me ^ this error:
>
> What wrong I am doing?
>
> I have loaded all the modules including iio_dummy_evgen, iio_dummy.
>
> How I will be pass trig-sample as an argument to it?
> and one more question how can I find Trigger-number of a trigger.
>
> I am facing same problem with iio_event_monitor:-
>
> $ ./iio_event_monitor /sys/bus/iio/devices/iio_evgen/poke_ev0
>
Here you should use the device node. It is usually /dev/iio:device0.

If there is not already created by a daemon there, create it using

mknod /dev/iio:device0 c major minor.

The major and minor can be found in /sys/bus/iio/devices/iio:device0/dev file/

> getting following error:-
> Failed to retrieve event fd
>
> Same with all other events.
>
> This is working fine for me:
> echo 1 > /sys/bus/iio/devices/iio_evgen/poke_ev0

thanks,
Daniel.
