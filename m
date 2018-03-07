Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:60904 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965002AbeCGUZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Mar 2018 15:25:26 -0500
Date: Wed, 7 Mar 2018 20:25:23 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Srishti Sharma <srishtishar@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Unknown symbols in module
Message-ID: <20180307202523.7b84fe6c@archlinux>
In-Reply-To: <CAB3L5ozYkWv0qO5LrKUHyfXXdRf2RCgAOorHp-DNiKCMzDof6Q@mail.gmail.com>
References: <CAB3L5ozYkWv0qO5LrKUHyfXXdRf2RCgAOorHp-DNiKCMzDof6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 5 Mar 2018 16:49:24 +0530
Srishti Sharma <srishtishar@gmail.com> wrote:

> Hello,
> I was trying to work with the iio dummy driver, and when I try to load
> the iio_dummy_evgen.ko module I am getting unknown symbols found in
> module error on running modprobe.
> 
> These variables are unknown
> iio_bus_type
> irq_sim_init
> irq_sim_fini
> irq_sim_fire
> irq_sim_fini
> 
> All of these variables are present in the Module.symvers file in the
> /lib/modules/<kernel version>/build directory. The kernel and the
> modules versions match. I ran make clean, make, and make
> modules_install before trying to load them. I am unable to figure out
> the problem. Where I might be going wrong any ideas ?
The required functions are built into the kernel - there is no option
to build them as a module. As such you'd need to also install the
kernel image in order to be able to probe the module.

The selected to be built when the dummy_evgen module is configured
to be built.

Jonathan

> 
> Thanks,
> Srishti
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

