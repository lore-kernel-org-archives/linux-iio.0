Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35171 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbcL1NXN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 08:23:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id i88so19520095pfk.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 05:23:12 -0800 (PST)
Message-ID: <1482931381.8484.3.camel@researchut.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Wed, 28 Dec 2016 18:53:01 +0530
In-Reply-To: <1482925101.8484.1.camel@researchut.com>
References: <1482925101.8484.1.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Oh! That did not include my usb listing. Please find it below. If you need more
information, please tell me.

rrs@learner:~$ lsusb 
Bus 003 Device 002: ID 8087:8000 Intel Corp. 
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 006: ID 048d:8350 Integrated Technology Express, Inc. 
Bus 001 Device 005: ID 0bda:b728 Realtek Semiconductor Corp. 
Bus 001 Device 004: ID 04f2:b40f Chicony Electronics Co., Ltd 
Bus 001 Device 003: ID 04f3:0303 Elan Microelectronics Corp. 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
2016-12-28 / 18:51:08 ♒♒♒  ☺  


and

rrs@learner:~$ sudo lsusb  -v -d 048d:8350

Bus 001 Device 006: ID 048d:8350 Integrated Technology Express, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x048d Integrated Technology Express, Inc.
  idProduct          0x8350 
  bcdDevice           10.10
  iManufacturer           1 ITE Tech. Inc.
  iProduct                2 ITE Device(8350)
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength    2913
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)
2016-12-28 / 18:52:05 ♒♒♒  ☺  

On Wed, 2016-12-28 at 17:08 +0530, Ritesh Raj Sarraf wrote:
> Hello Srini,
> 
> Regarding: https://www.spinics.net/lists/linux-input/msg48540.html
> 
> This patch does not seem to fix the issue entirely. On my machine, where on
> previous kernels from 4.7 and 4.8 worked fine, this patch hasn't made much
> difference on 4.9.
> 
> rrs@learner:~$ lspci
> 00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT Integrated
> Graphics Controller (rev 0b)
> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev
> 0b)
> 00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev 04)
> 00:16.0 Communication controller: Intel Corporation 8 Series HECI #0 (rev 04)
> 00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev 04)
> 00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 4 (rev
> e4)
> 00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev 04)
> 00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev 04)
> 00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controller 1 [AHCI
> mode] (rev 04)
> 00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8723BE PCIe
> Wireless Network Adapter
> 2016-12-28 / 17:07:16 ♒♒♒  ☺  
> rrs@learner:~$ uname -a
> Linux learner 4.9.0+ #1 SMP Mon Dec 26 14:20:36 IST 2016 x86_64 GNU/Linux
> 2016-12-28 / 17:07:24 ♒♒♒  ☺  
> 
> 
> 
- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhjvLYACgkQpjpYo/Lh
dWlT+w//S9sfy8kxaCeM17XQLTmDgdcMS1ZFujBWqYgN/9Fo6OFYdbhytRfqOXPO
t14uZVTKiDZ+KU36sNhLC+J0aLcldhLog7p9LBrcd4xzc2d6+GbfsnZ9ORffNINx
tA9dsY0yeOhGwIgYjd4PpkuuHe2mHQrQ22eLfXgA2oDqXt1DidhK3z5IlK7FBJrg
Mcm2wDxRVioI6Gf6lRihOrmW7O1GE0Ch4Vwbgi0C9IMBhq3xEHGZYGkcMTN5P5hq
jai2a1kSMffGk4YeNeWLzsu0SSEo4OZCJ0eahbwCXa5/crkRB2DCeqvZ44TIyRr6
WKgt5lnLIGWqu9DZ+Rwzy4cT3rUEhAYrcyELn1Sz0EX7TRguioE3HjbJRwQ0qI+D
dMQnSBsDR/LaYhSpTvQDiveSjzZ7lEDQCGPHTlxWQyxp0aZoGi0lEiVxgLGqpxn3
ily1CaV93nynQ66yCp7/F1xZtRFJhQ/5hqxxCcXQObe6PYTHJHbVLXrMnxw7HBko
o6+fTvotFBCrbHgS3kH7sJUXRYMNCPi7tpia8pB1CcBQOUmhsuFklTkge0Q8CUJu
PCFH6+ZDM2jP3THFk3E4nhpYSgYcxeprnakoi/WlyJTaLfQEHCLWRbOGbPlbFWhy
TRgOZJ2cagtTkUhTueow8Lcu5Wk/nBAbPxC3uAvqoEYNb+fUahQ=
=GsDS
-----END PGP SIGNATURE-----

