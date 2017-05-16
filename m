Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:40694 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbdEPQsk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 May 2017 12:48:40 -0400
Date: Tue, 16 May 2017 18:48:37 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Franziska Naepelt <franziska.naepelt@idt.com>
cc: linux-iio@vger.kernel.org
Subject: Re: Fwd: ltr501 register field mapping als/ps interrupt mode
 interchanged
In-Reply-To: <d8f18cdc-7aee-cf56-8045-f9bd2b4c7bfa@idt.com>
Message-ID: <alpine.DEB.2.20.1705161844270.3733@vps.pmeerw.net>
References: <6552089e-27f9-efb9-ae51-67f5f05cd9be@idt.com> <d8f18cdc-7aee-cf56-8045-f9bd2b4c7bfa@idt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Franziska,

> I just studied the ltr501 driver for reference and found the following:
> 
> The register mapping for the IIO driver for the Liteon Light and Proximity
> sensor LTR501 interrupt mode is interchanged (ALS/PS).
> 
> There is a register called INTERRUPT register (address 0x8F)
> Bit 0 represents PS measurement trigger.
> Bit 1 represents ALS measurement trigger.

yes, this seems to be mixed up; not tested, I do have this sensor on my 
heap of stuff

thanks for reporting, care to submit a formal patch?
otherwise I'll turn this into a patch propably tomorrow

regards, p.

 
> see datesheet:
> http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/S_110_LTR-501ALS-01_PrelimDS_ver1%5B1%5D.pdf
> - page 24
> 
> This two bit fields are interchanged within the driver:
> drivers/iio/light/ltr501.c.
> 
> I just refer to the datasheet because I don't have such kind of sensor to test
> it. The datasheet of the LTR559 which is covered by this driver as well
> has the same register mapping like LTR501.
> 
> Regards,
> Franziska
> 
> ./-ver_linux
> Linux raspberrypi 4.9.25-v7+ #1 SMP Thu May 11 15:56:46 CEST 2017 armv7l
> GNU/Linux
> 
> GNU C               	4.9.2
> GNU Make            	4.0
> Binutils            	2.25
> Util-linux          	2.25.2
> Mount               	2.25.2
> Module-init-tools   	18
> E2fsprogs           	1.42.12
> Nfs-utils           	1.2.8
> Linux C Library     	2.19
> Dynamic linker (ldd)	2.19
> Linux C++ Library   	6.0.20
> Procps              	3.3.9
> Net-tools           	1.60
> Kbd                 	1.15.5
> Console-tools       	1.15.5
> Sh-utils            	8.23
> Udev                	215
> Wireless-tools      	30
> Modules Loaded      	bcm2835_gpiomem bluetooth bnep brcmfmac brcmutil btbcm
> cfg80211 fixed hci_uart i2c_bcm2835 i2c_dev industrialio
> industrialio_triggered_buffer ipv6 kfifo_buf rfkill snd snd_bcm2835 snd_pcm
> snd_timer uio uio_pdrv_genirq
> 
> patch:
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 3afc53a..c298fd8 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -74,9 +74,9 @@
>  static const struct reg_field reg_field_it =
>                                 REG_FIELD(LTR501_ALS_MEAS_RATE, 3, 4);
>  static const struct reg_field reg_field_als_intr =
> -                               REG_FIELD(LTR501_INTR, 0, 0);
> -static const struct reg_field reg_field_ps_intr =
>                                 REG_FIELD(LTR501_INTR, 1, 1);
> +static const struct reg_field reg_field_ps_intr =
> +                               REG_FIELD(LTR501_INTR, 0, 0);
>  static const struct reg_field reg_field_als_rate =
>                                 REG_FIELD(LTR501_ALS_MEAS_RATE, 0, 2);
>  static const struct reg_field reg_field_ps_rate =
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
