Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34570 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdBAIDk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2017 03:03:40 -0500
MIME-Version: 1.0
In-Reply-To: <0EBAEA39-7B07-442E-8A08-0359AE00CCE0@jic23.retrosnub.co.uk>
References: <03B5A3CA1724CE4EAC32B27E39292A677FC7512D3A@AUSMAIL1.AUS.ADVANTECH.CORP>
 <WM!0e191e8021de721ce26bb7af83b55064556944dd1ba4a4c5ffd0cf5fa2a60dcb49d0a6722934d893c1817b0383068e28!@dgg.advantech.com>
 <273c851c-4623-652e-097b-5a3827205ebc@axentia.se> <WM!c988294410704f5fdb6034485f95e283ba8a11561dded8460b8f9f4c302e8d9d3b5dfd6fbd89ee21c83838f1af88f482!@dg.advantech.com>
 <03B5A3CA1724CE4EAC32B27E39292A677FC7512E85@AUSMAIL1.AUS.ADVANTECH.CORP>
 <WM!da6c96198354db7af9f225c848a09d5c6e064c622dbfcc6b4670fb1c3db17e0cc67ee54b34600a69dd8059b643e30774!@dg.advantech.com>
 <0EBAEA39-7B07-442E-8A08-0359AE00CCE0@jic23.retrosnub.co.uk>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 1 Feb 2017 10:03:33 +0200
Message-ID: <CAEnQRZCTKbLZ2XwUf8K2QVkWANv5t1ySqiin00=51sbi6+Ls8Q@mail.gmail.com>
Subject: Re: kernel 4.10-rcx iio helper question
To: "Ken.Lin" <ken.lin@advantech.com>
Cc: Peter Rosin <peda@axentia.se>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        "Peter.Stretz" <peter.stretz@advantech.com>,
        "Peter.Chiang" <peter.chiang@advantech.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Could you paste your drivers/iio/pressure/mpl3115.c code into pastebin.com
and send us the result?

thanks,
Daniel.

On Wed, Feb 1, 2017 at 8:50 AM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 1 February 2017 00:42:31 GMT+00:00, "Ken.Lin" <ken.lin@advantech.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: Peter Rosin [mailto:peda@axentia.se]
>>> Sent: Tuesday, January 31, 2017 1:10 PM
>>> To: Ken.Lin; jic23@kernel.org
>>> Cc: knaack.h@gmx.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org;
>>linux-
>>> kernel@vger.kernel.org; Akshay Bhat; Peter.Stretz; Peter.Chiang
>>> Subject: Re: kernel 4.10-rcx iio helper question
>>>
>>> On 2017-01-31 19:19, Ken.Lin wrote:
>>> > Hi,
>>> >
>>> > I find the latest kernel introduces new iio sys attributes.
>>> > https://patchwork.kernel.org/patch/9391771/
>>> > https://patchwork.kernel.org/patch/9391259/
>>> >
>>> > Is there anyone has some ideas about how the new iio sys attribute
>>-
>>> in_pressure_scale_available works?
>>> > I'm not sure if it's the regression issue or it's just the usage
>>issue or something
>>> when I tried to read in_pressure_scale_available attribute.
>>>
>>> > # cat /sys/bus/iio/devices/iio\:device1/in_pressure_scale_available
>>> > Segmentation fault
>>>
>>> What driver is providing iio:device1?
>>>
>>> > [ 3785.077014] Unable to handle kernel NULL pointer dereference at
>>> > virtual address 00000000 [ 3785.085138] pgd = ecc3c000 [
>>3785.087929]
>>> > [00000000] *pgd=87f91831 [ 3785.091563] Internal error: Oops:
>>80000007
>>> > [#1] SMP ARM [ 3785.096806] Modules linked in:
>>> > [ 3785.099892] CPU: 1 PID: 1051 Comm: cat Not tainted
>>> > 4.10.0-rc5-00009-gffd8858-dirty #3
>>>
>>> Looks like you have a couple of local changes? What are those?
>>>
>>
>>I didn't make any changes to the iio drivers locally and MPL3115A2
>>pressure/temperature sensor driver (drivers/iio/pressure/mpl3115.c) is
>>the driver which provides iio:device1.
>>
>>> My WAG is that you added the IIO_CHAN_INFO_SCALE bit to one of the
>>> .info_mask_*_available fields in the channel spec but failed to
>>provide a
>>> .read_avail operation in the driver. Am I close?
>>>
>>
>>I could read iio:device0/in_accel_scale and device0/in_accel_available,
>>which are provided by NXP 3-axis accelerometers driver
>>(drivers/iio/accel/mma8452.c).
>>The attribute iio:/device1/in_pressure_scale is missing unless I
>>reverted the commits.
>>https://patchwork.kernel.org/patch/9391771/
>>https://patchwork.kernel.org/patch/9391259/
>
> Getting weird. Any possibility you have a mix of modules with and without those patches?
>
> Would probably be mpl3115 without and industrialio with.  The structure gained some
> bitmasks between previous masks.
>
> But if so I am little surprised it isn't causing worse issues.
>
>>
>>Cheers,
>>Ken Lin
>>
>>> Cheers,
>>> peda
>>>
>>> > [ 3785.107740] Hardware name: Freescale i.MX6 Quad/DualLite (Device
>>> > Tree) [ 3785.114285] task: ed54ec00 task.stack: ee2bc000 [
>>> > 3785.118834] PC is at 0x0 [ 3785.121397] LR is at
>>> > iio_read_channel_info_avail+0x40/0x280
>>> > [ 3785.126992] pc : [<00000000>]    lr : [<c06fbc1c>]    psr:
>>a0070013
>>> > [ 3785.126992] sp : ee2bdda8  ip : 00000000  fp : ee2bddf4 [
>>> > 3785.138490] r10: c0a53c74  r9 : ed79f000  r8 : ee8d1018 [
>>> > 3785.143733] r7 : 00001000  r6 : 00000fff  r5 : ee8b9a00  r4 :
>>> > ed79f000 [ 3785.150276] r3 : ee2bddc4  r2 : ee2bddbc  r1 : c0a86dcc
>>> > r0 : ee8d1000 [ 3785.156820] Flags: NzCv  IRQs on  FIQs on  Mode
>>> > SVC_32  ISA ARM  Segment none [ 3785.163971] Control: 10c5387d
>>Table:
>>> > 3cc3c04a  DAC: 00000051 [ 3785.169734] Process cat (pid: 1051,
>>stack
>>> > limit = 0xee2bc210) [ 3785.175497] Stack: (0xee2bdda8 to
>>0xee2be000)
>>> > [ 3785.179880] dda0:                   ee2bddc0 00000002 c016d720
>>c016d394
>>> ed54ec00 00000000
>>> > [ 3785.188084] ddc0: 60070013 ed413780 00000001 edffd480 ee8b9a00
>>> > 00000fff 00001000 ee8d1018 [ 3785.196286] dde0: ed79f000 c0a53c74
>>> > ee2bde0c ee2bddf8 c0513c58 c06fbbe8 edffd480 edffd540 [
>>3785.204488]
>>> > de00: ee2bde3c ee2bde10 c0293474 c0513c40 c02933e4 ee2bde60
>>00000001
>>> > ed413780 [ 3785.212688] de20: 00000001 ed413780 00000000 edffd480
>>> > ee2bde4c ee2bde40 c0291d00 c02933f0 [ 3785.220889] de40: ee2bde9c
>>> > ee2bde50 c024679c c0291ce0 edffd4b0 b6e37000 00020000 ee2bdf78 [
>>> > 3785.229089] de60: 00000000 00000000 ed54ec00 ed013200 00000817
>>> > c0a111fc edffd540 ed413780 [ 3785.237289] de80: b6e37000 00020000
>>> > 00020000 ee2bdf78 ee2bded4 ee2bdea0 c0292890 c0246604 [
>>3785.245491]
>>> > dea0: c0117940 c016ba50 00000025 c0a111fc b6e37000 ed413780
>>ee2bdf78
>>> > 00020000 [ 3785.253691] dec0: ee2bc000 b6e37000 ee2bdf44 ee2bded8
>>> > c021d158 c0292770 c0117764 b6e36004 [ 3785.261893] dee0: c0f0d7c4
>>> > ee2bdfb0 b6f89228 00021008 ee2bdfac ee2bdf00 c0101374 c0117770 [
>>> > 3785.270093] df00: 00000000 00000000 ee2bc000 00000000 ee2bdf34
>>> > ee2bdf20 c016ba04 c0171080 [ 3785.278292] df20: 00000000 00020000
>>> > ed413780 b6e37000 00000000 ee2bdf78 ee2bdf74 ee2bdf48 [
>>3785.286493]
>>> > df40: c021e7a0 c021d130 c023e300 c023e280 ee2bdf74 00000000
>>00000000
>>> > ed413780 [ 3785.294693] df60: ed413780 00020000 ee2bdfa4 ee2bdf78
>>> c021e870 c021e71c 00000000 00000000 [ 3785.302892] df80: 00020000
>>> 00020000 b6e37000 00000003 c0108084 00000000 00000000 ee2bdfa8 [
>>> 3785.311092] dfa0: c0107ee0 c021e838 00020000 00020000 00000003
>>> b6e37000 00020000 0001a2b4 [ 3785.319292] dfc0: 00020000 00020000
>>> b6e37000 00000003 7fffe000 00000000 00000000 00020000 [ 3785.327492]
>>> dfe0: 00000000 be98eb4c 0000c740 b6f1985c 60070010 00000003 00000000
>>> 00000000 [ 3785.335679] Backtrace:
>>> > [ 3785.338175] [<c06fbbdc>] (iio_read_channel_info_avail) from
>>> > [<c0513c58>] (dev_attr_show+0x24/0x50) [ 3785.347162]  r10:c0a53c74
>>> > r9:ed79f000 r8:ee8d1018 r7:00001000 r6:00000fff r5:ee8b9a00 [
>>> > 3785.355005]  r4:edffd480 [ 3785.357571] [<c0513c34>]
>>(dev_attr_show)
>>> > from [<c0293474>] (sysfs_kf_seq_show+0x90/0x110) [ 3785.365764]
>>> > r5:edffd540 r4:edffd480 [ 3785.369365] [<c02933e4>]
>>> > (sysfs_kf_seq_show) from [<c0291d00>] (kernfs_seq_show+0x2c/0x30) [
>>> > 3785.377652]  r10:edffd480 r9:00000000 r8:ed413780 r7:00000001
>>> > r6:ed413780 r5:00000001 [ 3785.385498]  r4:ee2bde60 r3:c02933e4 [
>>> > 3785.389101] [<c0291cd4>] (kernfs_seq_show) from [<c024679c>]
>>> > (seq_read+0x1a4/0x4e0) [ 3785.396780] [<c02465f8>] (seq_read) from
>>> > [<c0292890>] (kernfs_fop_read+0x12c/0x1cc) [ 3785.404460]
>>> > r10:ee2bdf78 r9:00020000 r8:00020000 r7:b6e37000 r6:ed413780
>>> > r5:edffd540 [ 3785.412303]  r4:c0a111fc [ 3785.414862] [<c0292764>]
>>> > (kernfs_fop_read) from [<c021d158>] (__vfs_read+0x34/0x118) [
>>> > 3785.422627]  r10:b6e37000 r9:ee2bc000 r8:00020000 r7:ee2bdf78
>>> > r6:ed413780 r5:b6e37000 [ 3785.430470]  r4:c0a111fc [ 3785.433029]
>>> > [<c021d124>] (__vfs_read) from [<c021e7a0>] (vfs_read+0x90/0x11c) [
>>> > 3785.440185]  r8:ee2bdf78 r7:00000000 r6:b6e37000 r5:ed413780
>>> > r4:00020000 [ 3785.446909] [<c021e710>] (vfs_read) from
>>[<c021e870>]
>>> > (SyS_read+0x44/0x90) [ 3785.453804]  r8:00020000 r7:ed413780
>>> > r6:ed413780 r5:00000000 r4:00000000 [ 3785.460537] [<c021e82c>]
>>> > (SyS_read) from [<c0107ee0>] (ret_fast_syscall+0x0/0x1c) [
>>> > 3785.468042]  r10:00000000 r8:c0108084 r7:00000003 r6:b6e37000
>>> > r5:00020000 r4:00020000 [ 3785.476238] Code: bad PC value [
>>> > 3785.490358] ---[ end trace 9c4938ccd0389004 ]---
>>> >
>>> > Thank you
>>> >
>>> > Cheers,
>>> > Ken Lin
>>> >
>>>
>>>
>>> --
>>> This message has been scanned for viruses and dangerous content by
>>> MailScanner, and is believed to be clean.
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
