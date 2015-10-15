Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35997 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbbJOQDP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2015 12:03:15 -0400
Received: by lbcao8 with SMTP id ao8so74316635lbc.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2015 09:03:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCHh96gHnTVPpLi=my4DeqzFQAyXo3whYONXsVKyKrqBg@mail.gmail.com>
References: <CAF8px55G9aLXWcRKvhfAb7W=GUSbGn9TKdr_wnPyYiiTg-qG6w@mail.gmail.com>
	<CAEnQRZCHh96gHnTVPpLi=my4DeqzFQAyXo3whYONXsVKyKrqBg@mail.gmail.com>
Date: Thu, 15 Oct 2015 11:03:12 -0500
Message-ID: <CAF8px56JHR+L-oStFTWcBbzCaer5LakaiBGHu08QaeO2ogW=hQ@mail.gmail.com>
Subject: Re: iio: inv_mpu6050: client: Erratic data.
From: Mike Mestnik <cheako@mikemestnik.net>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

selective dmsg logs grep -e inv -e INV -e i2c -e I2C:
[    4.056572] i2c_hid i2c-INVN6500:00: unexpected HID descriptor
bcdVersion (0x0f9c)
[    4.205929] i2c i2c-5: Added multiplexed i2c bus 6
[ 2968.831450]  rfkill mei_me snd intel_soc_dts_iosf lpc_ich crc16
i2c_i801 mfd_core mei shpchp soundcore iosf_mbi int3403_thermal
battery dw_dmac dw_dmac_core snd_soc_sst_acpi i2c_designware_platform
i2c_designware_core int3402_thermal evdev ac acpi_pad
int340x_thermal_zone int3400_thermal processor acpi_thermal_rel
inv_mpu6050 industrialio_triggered_buffer kfifo_buf industrialio
i2c_mux coretemp fuse parport_pc ppdev lp parport efivarfs autofs4
btrfs xor raid6_pq dm_mod sg sd_mod usbhid uas usb_storage ahci
libahci i915 crc32c_intel i2c_algo_bit xhci_pci libata xhci_hcd
drm_kms_helper scsi_mod usbcore drm usb_common fan thermal wmi
sdhci_acpi sdhci video i2c_hid thermal_sys hid mmc_core button

On Thu, Oct 15, 2015 at 3:55 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> On Wed, Oct 14, 2015 at 11:13 PM, Mike Mestnik <cheako@mikemestnik.net> wrote:
>> This was taken with the tablet as still as I could without resorting
>> to using a vice and clamps.
>>
>> How to know if this is kernel or app?
>
> Looking at the message format it seems to be an user space app log.
>
> You can also send us the 'dmesg' command output.
>
> thanks,
> Daniel.
