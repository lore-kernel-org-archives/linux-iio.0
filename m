Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:48764 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeE0I7K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 May 2018 04:59:10 -0400
Date: Sun, 27 May 2018 09:59:07 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: isl29501 and multiple calibration registers
Message-ID: <20180527095907.5aa173b0@archlinux>
In-Reply-To: <87a7snd8r7.fsf@gmail.com>
References: <87a7snd8r7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 25 May 2018 18:01:48 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Hello,
> 
> I'm currently working on a driver for the ISL29501 Time of Flight
> sensor[1] that I hope to publish soon. This sensor has many calibration
> and corrections registers (crosstalk_i, crosstalk_q, crosstalk_gain,
> phase_temp_correction ...).
> 
> I would like to make all those registers accessible from userspace but
> iio_chan_info_enum has no matching elements for most of those registers
> which are very specific to this sensor.
> 
> Any idea how could I proceed to make those registers accessible?

First game is to try and match up with existing ABI defined for similar
parts.  If that fails, it's worth thinking about whether any of them are
likely to apply to a reasonably large number of parts in the near future.
There are always chip specific values though so somethings just need
a custom interface.   The key thing to remember is that they will effectively
not exist for generic userspace code.

Anyhow, you can either implement them as sysfs attributes, or take the
preferred route of iio_chan_spec_ext_info as that allows in kernel users
to access them rather than just userspace.

The challenge is really to work out how to fit these device specific
variables into the overall 'framework' of the ABI that is already defined.
The first step is often ABI definition document for
Documentation/ABI/testing/sysfs-bus-iio-isl29501 as it can be easier
to talk about an ABI doc than work it out from the code.

Thanks,

Jonathan
> 
> Thanks in advance,
> 
> Mathieu
> 
> [1]: https://www.intersil.com/content/dam/intersil/documents/isl2/isl29501.pdf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

