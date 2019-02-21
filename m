Return-Path: <SRS0=ELbO=Q4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA38C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 18:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C447A2077B
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 18:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS7sLLZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfBUS46 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:56:58 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:37170 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUS45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Feb 2019 13:56:57 -0500
Received: by mail-qt1-f170.google.com with SMTP id a48so32759817qtb.4
        for <linux-iio@vger.kernel.org>; Thu, 21 Feb 2019 10:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NL8oKw5x/XaZ7dg0adafVC8nvdReBlDu/pZR22Rs5Ds=;
        b=qS7sLLZEs4ll51bmkEZv31caZXaGw7Mk+daaBdvOP2LzkqP5uuoRA4hqXT2DVMNFOR
         qIA+yx1gk9gr0AbLVwdf7hE8e1aWhayZDVTQ3gAqG4YH3pJRmHTSVm1A6zTwEmysHIHO
         pdRWCO7Zrsd5BdcHw8Zwj5C+4i1moAtGPP0pjVokbRkZ7kkBKxHFJPJAvrSbADitOqMp
         b8Pd5bovU/Tfh9l8PE1cLgvN4r0KpZjUNI46HRXbQPK2tXbrJ/9SB8UBxG0Xz4xJlMdi
         524kstUGB3qLSDJNjupoPWmgUB4IfdGNlRLpjhEya+/xhX8ePqZlqtCtcp183aeRWN9i
         QqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NL8oKw5x/XaZ7dg0adafVC8nvdReBlDu/pZR22Rs5Ds=;
        b=ng8PXWGFq4ASCJhOJdllLJQfrKNntT4dIPOgBwAsirFaX0SKxp2r2jXJTYt39qnpXL
         /TzBQ0jlmXIsGg2uGhY9DIJPV9LR4xZl0OJdpklxqUEIqYxvmcw0/IJLSfxN3tnwwnsG
         ZkYex1hopN1jlcO0lwQsH8bMr6dEhnRNmMwYYaN+Pr1ibAL1WwVU7le1osaF1SXu7fw+
         Fdmoh4QmCt0YPP9GpfKQW2d/2J4q6flJWSjslbU3fybsJw+vSf6w88em57bN1gv6/hCa
         fJ0QhSn3/Iku34OG9yfare/NPGz2IQDQjHXZF4VrElbviUX30iPWHnRLDY8aAubV8oku
         Dxrg==
X-Gm-Message-State: AHQUAua6sH6JPJaFN7WEUXRaUHxuAW5jujLiqvopBA+34zQ+edU2HFkg
        CYiLaOXZX3bnEISKY4+ffbw=
X-Google-Smtp-Source: AHgI3IZAk0V5SMPRzpPJGyVKDQW0Ew4Un6x+D5XvZjfbFa0FKkBmkHF9EaPV9UmeUMPYmpUDLzxGDg==
X-Received: by 2002:a0c:932a:: with SMTP id d39mr20549379qvd.85.1550775416207;
        Thu, 21 Feb 2019 10:56:56 -0800 (PST)
Received: from localhost.localdomain (167-4-17-190.fibertel.com.ar. [190.17.4.167])
        by smtp.gmail.com with ESMTPSA id m12sm14474313qke.17.2019.02.21.10.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 10:56:55 -0800 (PST)
Date:   Thu, 21 Feb 2019 15:56:37 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        gascoar@gmail.com
Subject: Re: Add IIO example to the kernelnewbies wiki
Message-ID: <20190221185637.GA1462@localhost.localdomain>
References: <20180402170637.wlx5xru2wyahm42f@localhost.localdomain>
 <CAEnQRZDzKS_KXF9QRQPAtD6i3nwhknyx9K-YmrY_OFpb2RXisw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZDzKS_KXF9QRQPAtD6i3nwhknyx9K-YmrY_OFpb2RXisw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 09, 2018 at 10:21:08AM +0300, Daniel Baluta wrote:
> Sure, you can do that. Nice to see that you are using Diolan DLN-2 adapter.
> 
> thanks,
> Daniel.
> 
> On Mon, Apr 2, 2018 at 8:06 PM, Gaston Gonzalez <gascoar@gmail.com> wrote:
> > Hi,
> >
> > I'm testing an AD7746 eval board using a Diolan DLN-2 adapter. I wrote
> > some basic notes about the installation an instanciation process for my
> > own use. But then I thought it could be useful for someone else. So
> > maybe I could put this in the kernel newbies page under the IIO section?
> >
> > If you think is worth it, I would be glad to add it to the wiki page.
> >
> > Best regards,
> >
> > Gaston
> >
> > Notes:
> >
> > The setup
> > =========
> >
> >         AD7746-EVAL BOARD --> Diolan DLN-2 Adapter --> Thinkpad T430
> >
> > The connection between the AD7746 eval board and adapter is as detailed
> > in [2] I2C Interface Configuration Options, External connection (pag 4).
> >
> > The connection between Diolan DLN-2 and the T430 is USB straighforward.
> >
> > Drivers
> > =======
> >
> > Both in mainline kernel:
> >
> >  - Diolan DLN-2 driver: I2C_DLN2 (prompt Diolan DLN-2 USB I2C adapter)
> >         Loc: drivers/i2c/busses/
> >  - AD7746: AD7746
> >         Loc: drivers/staging/iio/cdc/
> >
> > Bus of interest
> > ===============
> >
> >  $  sudo i2cdetect -l
> >
> > We get something like:
> >
> >  ...
> >  i2c-10  i2c             dln2-i2c-1-1.2:1.0-0                    I2C adapter
> >  ...
> >
> > So our bus is the number 10.
> >
> > Getting the address
> > ===================
> >
> >  $ sudo i2cdetect -y -r 10
> >
> > We get something like:
> >
> >       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
> > 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 70: -- -- -- -- -- -- -- --
> >
> > 3. Device instantiation:
> >
> >  # echo add7746 0x48 > /sys/bus/i2c/devices/i2c-10/new_device
> >
> > We must see something like:
> >
> > $ cd /sys/bus/i2c/devices/i2c-10/10-0048/
> > $ ls
> > driver  iio:device0  modalias  name  power  subsystem  uevent
> >
> > $ cd iio:device0
> > $ ls
> > dev                                      in_capacitance-capacitance_calibbias
> > in_capacitance0_calibbias_calibration    in_capacitance-capacitance_sampling_frequency
> > in_capacitance0_calibscale               in_capacitance-capacitance_scale
> > in_capacitance0_calibscale_calibration   in_capacitance_sampling_frequency
> > in_capacitance0-capacitance2_calibscale  in_capacitance_sampling_frequency_available
> > in_capacitance0-capacitance2_offset      in_capacitance_scale
> > in_capacitance0-capacitance2_raw         in_temp0_input
> > in_capacitance0_offset                   in_temp1_input
> > in_capacitance0_raw                      in_voltage0_calibscale_calibration
> > in_capacitance1_calibbias_calibration    in_voltage0_raw
> > in_capacitance1_calibscale               in_voltage1_supply_raw
> > in_capacitance1_calibscale_calibration   in_voltage_sampling_frequency
> > in_capacitance1-capacitance3_calibscale  in_voltage_sampling_frequency_available
> > in_capacitance1-capacitance3_offset      in_voltage_scale
> > in_capacitance1-capacitance3_raw         name
> > in_capacitance1_offset                   power
> > in_capacitance1_raw                      subsystem
> > in_capacitance_calibbias                 uevent
> >
> > Checking the permits:
> >
> > $ ll
> > -r--r--r-- 1 root root 4096 mar 31 09:57 dev
> > --w------- 1 root root 4096 mar 31 09:57 in_capacitance0_calibbias_calibration
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0_calibscale
> > --w------- 1 root root 4096 mar 31 09:57 in_capacitance0_calibscale_calibration
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0-capacitance2_calibscale
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0-capacitance2_offset
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0-capacitance2_raw
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0_offset
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0_raw
> > --w------- 1 root root 4096 mar 31 09:57 in_capacitance1_calibbias_calibration
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1_calibscale
> > --w------- 1 root root 4096 mar 31 09:57 in_capacitance1_calibscale_calibration
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1-capacitance3_calibscale
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1-capacitance3_offset
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1-capacitance3_raw
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1_offset
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1_raw
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_calibbias
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance-capacitance_calibbias
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance-capacitance_sampling_frequency
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance-capacitance_scale
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_sampling_frequency
> > -r--r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_sampling_frequency_available
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_scale
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_temp0_input
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_temp1_input
> > --w------- 1 root root 4096 mar 31 09:57 in_voltage0_calibscale_calibration
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage0_raw
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage1_supply_raw
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage_sampling_frequency
> > -r--r--r-- 1 root root 4096 mar 31 09:57 in_voltage_sampling_frequency_available
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage_scale
> > -r--r--r-- 1 root root 4096 mar 31 09:57 name
> > drwxr-xr-x 2 root root    0 mar 31 09:57 power
> > lrwxrwxrwx 1 root root    0 mar 31 09:57 subsystem -> ../../../../../../../../../../../bus/iio
> > -rw-r--r-- 1 root root 4096 mar 31 09:57 uevent
> >
> > 4. Capacitance
> >
> > According to [2], the capacitive length sensor is connected to CIN2+ and
> > CIN2-. In the driver, the values are mapped to capacitance0.
> >
> > Raw values vs sensor length:
> >
> > Note: (+) values means the sensor was moved to the left, (-) values
> > means the sensor was moved to the right. I.e. +1 cm means the rule was
> > moved 1 to the left, while -1 means the rule was moved 1 cm to the
> > right.
> >
> > Note2: note the raw value for -10 is 8224733, while +10 is -8224726, the
> > difference is because when the rule is moved 10 cm to the left, the is
> > still 2 o 3 cm of dielectric between the plates. The design is obviously
> > thought to move the rule to the right.
> >
> >
> >         Length (cm) |   Raw Value Cap0
> >         ------------------------------
> >         -10             -8224733
> >         -9              -8224730
> >         -8              -8224728
> >         -7              -8224725
> >         -6              -8224724
> >         -5              -8224722
> >         -4              -8224720
> >         -3              -8224718
> >         -2              -8224716
> >         -1              -8224714
> >         +0              -8224711
> >         +1              -8224711
> >         +2              -8224711
> >         +3              -8224711
> >         +4              -8224713
> >         +5              -8224715
> >         +6              -8224717
> >         +7              -8224719
> >         +8              -8224721
> >         +9              -8224723
> >         +10             -8224726
> >
> >
> > References
> > ==========
> >
> > [1] http://www.analog.com/media/en/technical-documentation/data-sheets/AD7745_7746.pdf
> > [2] http://www.analog.com/media/en/technical-documentation/evaluation-documentation/EVAL-AD7746EB.PDF
> > [3] https://i2c.wiki.kernel.org/index.php/Main_Page
> > [4] https://kernelsense.wordpress.com/2016/01/22/achievement-unlocked-first-iio-driver/
> >
> > _______________________________________________
> > Kernelnewbies mailing list
> > Kernelnewbies@kernelnewbies.org
> > https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

Hi,

(Sorry for the 'little' late reply)

If still possible, please add me to the editor list so I can edit the page.
My user is 'Gaston Gonzalez'

Thanks !

Gaston
