Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39153 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCLT0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Mar 2018 15:26:13 -0400
Received: by mail-it0-f68.google.com with SMTP id l187-v6so13006959ith.4
        for <linux-iio@vger.kernel.org>; Mon, 12 Mar 2018 12:26:13 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Hern=C3=A1n_Gonzalez?= <hernan@vanguardiasur.com.ar>
Date: Mon, 12 Mar 2018 16:25:52 -0300
Message-ID: <CALfa3vGh4Ni36+ptCdnd0+mxPWDs8OQKe7-egpttgYBpuDTeqA@mail.gmail.com>
Subject: Plan to move cdc:ad7746 driver out of staging
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This is my plan for moving out the ad7746 driver out of staging. I
have some specific questions that would be really helpful if someone
can point me in the right direction to go.

1. Pick up on David's clean-up patch. Finish cleaning CHECKs from
checkpatch.pl if possible.

2. Reorder includes alphabetically.

3. Reorder some variable declarations in an inverse-pyramid scheme.

4. Fix sysfs attrs naming to comply with the ABI, e.g.:
in_capacitance0_calibbias_calibration -> in_capacitance0_calibbias

5. Add documentation to the {cap,vt}_filter_rate tables and to the
processed info read. There are some magic numbers out there, I will
read the datasheet and explain the math that I consider appropiate.

6. There are a few too many defines that are not used at all but they
do follow the datasheet. I don't know if there are plans to keep
adding functionalities to this driver or if I should just remove them.

8. EXCLVL is duplicated. There's a simple macro in ad7746.c and some
defines in ad7746.h. The latter are not used anywhere in the code.
Remove them.

7. Move the struct ad7746_platform_data to include/linux/iio.

As mentioned in earlier mails, I will avoid adding new features as I
have no access to the hardware and, therefore, could not test it.

I guess that'd be all. If I'm missing something I would be really
grateful if you can let me know or give me some pointers where to look
at.

Cheers,

Hern=C3=A1n
