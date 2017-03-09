Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:35964 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932247AbdCIPmU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2017 10:42:20 -0500
Received: by mail-it0-f46.google.com with SMTP id h10so130671300ith.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Mar 2017 07:41:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170309143421.GA4623@miguel-Z170X-UD5-TH>
References: <20170309143421.GA4623@miguel-Z170X-UD5-TH>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 9 Mar 2017 17:41:38 +0200
Message-ID: <CAEnQRZAO0X9hW=kykM5wZrweO6Xukts-XUWWyQNJM0D3fJXh4Q@mail.gmail.com>
Subject: Re: PROBLEM: iio: dummy: Oops after mkdir
To: Miguel Robles <miguel.robles@farole.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 9, 2017 at 4:34 PM, Miguel Robles <miguel.robles@farole.net> wrote:
> Hello all,
>
> I am beginning with Linux Kernel development. So I am trying to make
> the IIO tasks posted on kernelnewbies DOT org.
> But I got stuck with this problem that I am describing you hereafter
> hoping that someone could bring me any feedback.
>
> Many thanks,
> Miguel ROBLES
>
> ----------
> DESCRIPTION
> -----------
>
> After loading the corresponding IIO modules and mountig the configfs filesystem
> I can not create an instance device with mkdir using the command:
>
> $ sudo mkdir /config/iio/devices/dummy/my_dummy_device
> Killed
>
> I get the "Killed" message and looking at my syslog file, I got the warning
> "refcount_t: increment on 0; use-after-free" followed by an "Oops" message.
> When trying to execute the command one more time, the execution never finishes.
>
>
> ------
> CONTEXT
> -------
>
> - Tried on 2 linux kernel releases:
>       - kernel: 4.10 (commit: 4977ab6)
>       - Kernel: 4.11 (commit: ec3b93a)
>
> - Compiled with config file including the following options for IIO:
>
> #
> # IIO dummy driver
> #
> CONFIG_IIO_DUMMY_EVGEN=m
> CONFIG_IIO_SIMPLE_DUMMY=m
> CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
> CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
>
> CONFIG_IIO_CONFIGFS=m

Do you also have CONFIG_IIO_SW_DEVICE right?

Will try to have a look at this asap.


thanks,
Daniel.
