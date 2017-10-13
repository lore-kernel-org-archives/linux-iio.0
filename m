Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41206 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdJMQ3A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2017 12:29:00 -0400
Date: Fri, 13 Oct 2017 17:28:56 +0100
In-Reply-To: <CALieaef=jiHBJKrOY9KAr_PMHbrJhrjc9YQ=q+ukir+Ujg+opw@mail.gmail.com>
References: <CALieaef=jiHBJKrOY9KAr_PMHbrJhrjc9YQ=q+ukir+Ujg+opw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: max1363 driver not working with iio_generic_buffer tool
To: Dmitry Mastykin <mastichi@gmail.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <D13C741F-47D0-481A-9CFA-4929ED6D2192@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 13 October 2017 14:49:37 BST, Dmitry Mastykin <mastichi@gmail.com> wrote:
>Hello,
>(I'm sorry, the question may be too simple for this mailing list)
>I'm working with max1136 via max1363 driver.
>I can read raw values via sysfs.
>But I cannot use it with iio_generic_buffer.
>
>I enable a channel:
>  echo 1 | sudo tee
>/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage0_en
>
>and then:
>  sudo ./iio_generic_buffer -g -n max1136

No trigger on that device as I don't think it has an internal clock.  If a device provides its own
 trigger and you don't specify one, the demo code will figure it out.  Actually for extra confusion that ti part is an
 oddity. Because of the block nature of its dma transfers it doesn't use a trigger at all.

So you need to provide one from somewhere else. Various options but without hardware
 easiest would be a sysfs trigger or hrtimer trigger.

>From phone not sure I can write a set of instructions for creating one though. 

J
>
>returns:
>  Failed to enable buffer: Invalid argument
>
>whilst with TI-am335x-adc driver I can read values.
>Please suggest me what to try, or may be INDIO_DIRECT_MODE doesn't
>suppose work with the buffer?
>Thank you very much,
>Dmitry Mastykin
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
