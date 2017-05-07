Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57611 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbdEGWVB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:21:01 -0400
Subject: Re: [BUG] crash when removing sun4i_gpadc_iio module
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
        quentin.schulz@free-electrons.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20170502064643.GA8231@Red>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a249d374-34db-974e-baf1-7088265bd576@kernel.org>
Date: Sun, 7 May 2017 16:14:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170502064643.GA8231@Red>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/17 07:46, Corentin Labbe wrote:
> Hello

Beyond picking up in a quick code inspection I'm afraid.  Quentin
can you take a look at this?  I guess its triggering as a result
of the call to read the temperature failing, but beyond that - no
idea!

Jonathan
> 
> When inserting sun4i_gpadc_iio I got the following error in dmesg:
> [79961.039826] thermal thermal_zone0: failed to read out thermal zone (-110)
> 
> Then removing the module cause an oops:
> [80105.370937] Unable to handle kernel paging request at virtual address bf0ad1d0
> [80105.370958] pgd = c0004000
> [80105.370968] [bf0ad1d0] *pgd=6e470811, *pte=00000000, *ppte=00000000
> [80105.371009] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
> [80105.376940] Modules linked in: algif_aead ccm gcm algif_rng crypto_user algif_skcipher algif_hash af_alg ghash_generic aes_arm_bs axp20x_ac_power axp20x_usb_power axp20x_adc gpio_axp209 nvmem_sunxi_sid sun4i_ss sun4i_dma virt_dma [last unloaded: sun4i_gpadc_iio]
> [80105.400199] CPU: 0 PID: 14663 Comm: kworker/0:0 Tainted: G        W       4.11.0-rc8-next-20170428+ #96
> [80105.409581] Hardware name: Allwinner sun7i (A20) Family
> [80105.414821] Workqueue: events_freezable thermal_zone_device_check
> [80105.420915] task: ee7d2880 task.stack: ea4fa000
> [80105.425447] PC is at 0xbf0ad1d0
> [80105.428594] LR is at arch_timer_read_counter_long+0x14/0x18
> [80105.434166] pc : [<bf0ad1d0>]    lr : [<c010eab8>]    psr: 60070013
>                sp : ea4fbea8  ip : ee7d2e00  fp : 00000001
> [80105.445630] r10: ea4fbed4  r9 : 0000007b  r8 : 00000000
> [80105.450852] r7 : ee7ffc14  r6 : ee7ff800  r5 : c09e2260  r4 : 0000005a
> [80105.457373] r3 : c058e3d4  r2 : fac81000  r1 : 000001bf  r0 : 00005dbf
> [80105.463897] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [80105.471025] Control: 10c5387d  Table: 66c9c06a  DAC: 00000051
> [80105.476766] Process kworker/0:0 (pid: 14663, stack limit = 0xea4fa210)
> [80105.483288] Stack: (0xea4fbea8 to 0xea4fc000)
> [80105.487648] bea0:                   00000001 00000010 ee7ffbc0 ea4fbefc ef26dad4 ef7c2500
> [80105.495821] bec0: ea4fbf28 00000000 00000000 bf0ad7e0 00000001 c070e80c c055d600 ef26d800
> [80105.503994] bee0: ea4fbefc c055d614 00000000 ef26d800 ef7bef00 c055b040 ea4fbf28 ef26db20
> [80105.512167] bf00: ef26db20 edf65680 ef7bef00 c013b374 00000001 00000000 c013b304 c013b798
> [80105.520340] bf20: 00000000 00000000 c12624a4 c0dcdf20 00000000 c09c0e10 c0c04900 ef7bef00
> [80105.528512] bf40: edf65698 00000008 c0c04900 ef7bef34 ea4fa000 ef7bef00 edf65680 c013b6f8
> [80105.536685] bf60: ef7bf09c 00000000 edf65680 edf65380 00000000 e6c90700 edf65680 c013b6c0
> [80105.544858] bf80: edf653b8 edf91e84 00000000 c01415c0 e6c90700 c0141484 00000000 00000000
> [80105.553030] bfa0: 00000000 00000000 00000000 c01079b8 00000000 00000000 00000000 00000000
> [80105.561202] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [80105.569374] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 6fffd861 6fffdc61
> [80105.577558] [<c010eab8>] (arch_timer_read_counter_long) from [<00000010>] (0x10)
> [80105.584952] Code: bad PC value
> [80105.588283] ---[ end trace ff84d9d449c6a5b5 ]---
> 
> Regards
> Corentin Labbe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

