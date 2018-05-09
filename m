Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54173 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755826AbeEIHVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2018 03:21:09 -0400
Received: by mail-wm0-f54.google.com with SMTP id a67so22545512wmf.3
        for <linux-iio@vger.kernel.org>; Wed, 09 May 2018 00:21:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180402170637.wlx5xru2wyahm42f@localhost.localdomain>
References: <20180402170637.wlx5xru2wyahm42f@localhost.localdomain>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 9 May 2018 10:21:08 +0300
Message-ID: <CAEnQRZDzKS_KXF9QRQPAtD6i3nwhknyx9K-YmrY_OFpb2RXisw@mail.gmail.com>
Subject: Re: Add IIO example to the kernelnewbies wiki
To: Gaston Gonzalez <gascoar@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sure, you can do that. Nice to see that you are using Diolan DLN-2 adapter.

thanks,
Daniel.

On Mon, Apr 2, 2018 at 8:06 PM, Gaston Gonzalez <gascoar@gmail.com> wrote:
> Hi,
>
> I'm testing an AD7746 eval board using a Diolan DLN-2 adapter. I wrote
> some basic notes about the installation an instanciation process for my
> own use. But then I thought it could be useful for someone else. So
> maybe I could put this in the kernel newbies page under the IIO section?
>
> If you think is worth it, I would be glad to add it to the wiki page.
>
> Best regards,
>
> Gaston
>
> Notes:
>
> The setup
> =========
>
>         AD7746-EVAL BOARD --> Diolan DLN-2 Adapter --> Thinkpad T430
>
> The connection between the AD7746 eval board and adapter is as detailed
> in [2] I2C Interface Configuration Options, External connection (pag 4).
>
> The connection between Diolan DLN-2 and the T430 is USB straighforward.
>
> Drivers
> =======
>
> Both in mainline kernel:
>
>  - Diolan DLN-2 driver: I2C_DLN2 (prompt Diolan DLN-2 USB I2C adapter)
>         Loc: drivers/i2c/busses/
>  - AD7746: AD7746
>         Loc: drivers/staging/iio/cdc/
>
> Bus of interest
> ===============
>
>  $  sudo i2cdetect -l
>
> We get something like:
>
>  ...
>  i2c-10  i2c             dln2-i2c-1-1.2:1.0-0                    I2C adapter
>  ...
>
> So our bus is the number 10.
>
> Getting the address
> ===================
>
>  $ sudo i2cdetect -y -r 10
>
> We get something like:
>
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>
> 3. Device instantiation:
>
>  # echo add7746 0x48 > /sys/bus/i2c/devices/i2c-10/new_device
>
> We must see something like:
>
> $ cd /sys/bus/i2c/devices/i2c-10/10-0048/
> $ ls
> driver  iio:device0  modalias  name  power  subsystem  uevent
>
> $ cd iio:device0
> $ ls
> dev                                      in_capacitance-capacitance_calibbias
> in_capacitance0_calibbias_calibration    in_capacitance-capacitance_sampling_frequency
> in_capacitance0_calibscale               in_capacitance-capacitance_scale
> in_capacitance0_calibscale_calibration   in_capacitance_sampling_frequency
> in_capacitance0-capacitance2_calibscale  in_capacitance_sampling_frequency_available
> in_capacitance0-capacitance2_offset      in_capacitance_scale
> in_capacitance0-capacitance2_raw         in_temp0_input
> in_capacitance0_offset                   in_temp1_input
> in_capacitance0_raw                      in_voltage0_calibscale_calibration
> in_capacitance1_calibbias_calibration    in_voltage0_raw
> in_capacitance1_calibscale               in_voltage1_supply_raw
> in_capacitance1_calibscale_calibration   in_voltage_sampling_frequency
> in_capacitance1-capacitance3_calibscale  in_voltage_sampling_frequency_available
> in_capacitance1-capacitance3_offset      in_voltage_scale
> in_capacitance1-capacitance3_raw         name
> in_capacitance1_offset                   power
> in_capacitance1_raw                      subsystem
> in_capacitance_calibbias                 uevent
>
> Checking the permits:
>
> $ ll
> -r--r--r-- 1 root root 4096 mar 31 09:57 dev
> --w------- 1 root root 4096 mar 31 09:57 in_capacitance0_calibbias_calibration
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0_calibscale
> --w------- 1 root root 4096 mar 31 09:57 in_capacitance0_calibscale_calibration
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0-capacitance2_calibscale
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0-capacitance2_offset
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0-capacitance2_raw
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0_offset
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance0_raw
> --w------- 1 root root 4096 mar 31 09:57 in_capacitance1_calibbias_calibration
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1_calibscale
> --w------- 1 root root 4096 mar 31 09:57 in_capacitance1_calibscale_calibration
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1-capacitance3_calibscale
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1-capacitance3_offset
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1-capacitance3_raw
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1_offset
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance1_raw
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_calibbias
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance-capacitance_calibbias
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance-capacitance_sampling_frequency
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance-capacitance_scale
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_sampling_frequency
> -r--r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_sampling_frequency_available
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_capacitance_scale
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_temp0_input
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_temp1_input
> --w------- 1 root root 4096 mar 31 09:57 in_voltage0_calibscale_calibration
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage0_raw
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage1_supply_raw
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage_sampling_frequency
> -r--r--r-- 1 root root 4096 mar 31 09:57 in_voltage_sampling_frequency_available
> -rw-r--r-- 1 root root 4096 mar 31 09:57 in_voltage_scale
> -r--r--r-- 1 root root 4096 mar 31 09:57 name
> drwxr-xr-x 2 root root    0 mar 31 09:57 power
> lrwxrwxrwx 1 root root    0 mar 31 09:57 subsystem -> ../../../../../../../../../../../bus/iio
> -rw-r--r-- 1 root root 4096 mar 31 09:57 uevent
>
> 4. Capacitance
>
> According to [2], the capacitive length sensor is connected to CIN2+ and
> CIN2-. In the driver, the values are mapped to capacitance0.
>
> Raw values vs sensor length:
>
> Note: (+) values means the sensor was moved to the left, (-) values
> means the sensor was moved to the right. I.e. +1 cm means the rule was
> moved 1 to the left, while -1 means the rule was moved 1 cm to the
> right.
>
> Note2: note the raw value for -10 is 8224733, while +10 is -8224726, the
> difference is because when the rule is moved 10 cm to the left, the is
> still 2 o 3 cm of dielectric between the plates. The design is obviously
> thought to move the rule to the right.
>
>
>         Length (cm) |   Raw Value Cap0
>         ------------------------------
>         -10             -8224733
>         -9              -8224730
>         -8              -8224728
>         -7              -8224725
>         -6              -8224724
>         -5              -8224722
>         -4              -8224720
>         -3              -8224718
>         -2              -8224716
>         -1              -8224714
>         +0              -8224711
>         +1              -8224711
>         +2              -8224711
>         +3              -8224711
>         +4              -8224713
>         +5              -8224715
>         +6              -8224717
>         +7              -8224719
>         +8              -8224721
>         +9              -8224723
>         +10             -8224726
>
>
> References
> ==========
>
> [1] http://www.analog.com/media/en/technical-documentation/data-sheets/AD7745_7746.pdf
> [2] http://www.analog.com/media/en/technical-documentation/evaluation-documentation/EVAL-AD7746EB.PDF
> [3] https://i2c.wiki.kernel.org/index.php/Main_Page
> [4] https://kernelsense.wordpress.com/2016/01/22/achievement-unlocked-first-iio-driver/
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
