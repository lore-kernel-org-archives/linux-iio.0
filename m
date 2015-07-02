Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33408 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbbGBL4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jul 2015 07:56:52 -0400
Received: by lbcui10 with SMTP id ui10so30340356lbc.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2015 04:56:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALwa49sQwCd6+fqfFwD4eqoh8fRGrD-i9CEVWtz0Eq1NciTKTw@mail.gmail.com>
References: <CALwa49tK0sfmkVb1uRT6C9-BPDD5f6CJCDqyVRK1vA=G3sjuEA@mail.gmail.com>
	<CAEnQRZCNatGCdfhzV83yvWXJ_oWUwLa=Zvd8LLsD-ftvyZ5ikA@mail.gmail.com>
	<CALwa49sQwCd6+fqfFwD4eqoh8fRGrD-i9CEVWtz0Eq1NciTKTw@mail.gmail.com>
Date: Thu, 2 Jul 2015 14:56:50 +0300
Message-ID: <CAEnQRZCGZ_5aZm6Pytc6p4KUYtDEz3FT8vbpSmD41HJMHUOz6Q@mail.gmail.com>
Subject: Re: Unit in which generic_buffer.c application gives data for sensors.
From: Daniel Baluta <daniel.baluta@gmail.com>
To: "s.rawat" <imsaurabhrawat@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 2, 2015 at 2:53 PM, s.rawat <imsaurabhrawat@gmail.com> wrote:
> On Thu, Jul 2, 2015 at 4:13 PM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>
>> * accel - m/s^2
>> * gyro - rad/s
>> * magneto - Gaus
>
> I get the data as below :
>
> in_accel_x 71000 71000.0 in_accel_y -45000 -45000.0 in_accel_z
> -1003000 -1003000.0
>
> This seems correct except I think the data from the device is
> definitely not in m/s2 , seems like it is in  "μg".What would be
> correct -> telling the  device firmware writer to change the fw to
> send data in m/s2 or I convert this data to m/s^2 at host end?


What driver is this? generic_buffer application reads the data
from device buffer than applies the offset and the scale.

Perhaps, your driver doesn't correctly expose the scale?

thanks,
Daniel.
