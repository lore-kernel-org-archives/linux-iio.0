Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48469 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdCZIRp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 04:17:45 -0400
Date: Sun, 26 Mar 2017 09:17:38 +0100
In-Reply-To: <CALrZqyPPCGE0zZwrEcwBbOX75d7ZnA8E1in=6nJfN9xCf4rTvA@mail.gmail.com>
References: <CALrZqyPPCGE0zZwrEcwBbOX75d7ZnA8E1in=6nJfN9xCf4rTvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: Problem in loading module of Software trigger
To: SIMRAN SINGHAL <singhalsimran0@gmail.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <846DA1B1-BDAB-4CA3-8132-AC5594CC7019@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Insmod will not pick up dependencies in the same way modprobe will.

Make sure to also insmod industrialio.ko and iio-sw-trigger.ko before the sw trigger module. I
 think those are the only ones you will need.

J



On 26 March 2017 08:02:05 BST, SIMRAN SINGHAL <singhalsimran0@gmail.com> wrote:
>I read this documentation "Documentation/iio/iio_configfs.txt" for
>creating software trigger.
>
>So, by following this I created the module with name iio-trig-sample.c
>in drivers/iio/trigger/.
>
>iio-trigger-sample.c also compiled successfully.
>
>Now, when I tried to insert module:
>
>$ sudo insmod iio-trig-sample.ko
>insmod: ERROR: could not insert module iio-trig-sample.ko: Unknown
>symbol in module
>
>Ans in /var/log/kern.log:
>I am getting following reason:-
>iio_trig_sample: Unknown symbol iio_unregister_sw_trigger_type (err 0)
>iio_trig_sample: Unknown symbol iio_register_sw_trigger_type (err 0)
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
