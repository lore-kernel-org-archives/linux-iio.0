Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr00118.outbound.protection.outlook.com ([40.107.0.118]:55621
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751395AbdBAIJd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Feb 2017 03:09:33 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alison Schofield <amsfield22@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Ken Lin <ken.lin@advantech.com>, <linux-iio@vger.kernel.org>
Subject: [PATCH 1/2] iio: pressure: mpl3115: do not rely on structure field ordering
Date: Wed, 1 Feb 2017 09:09:26 +0100
Message-ID: <1485936567-3367-2-git-send-email-peda@axentia.se>
In-Reply-To: <1485936567-3367-1-git-send-email-peda@axentia.se>
References: <1485936567-3367-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes a regression triggered by a change in the layout of
struct iio_chan_spec, but the real bug is in the driver which assumed
a specific structure layout in the first place.

# cat /sys/bus/iio/devices/iio\:device1/in_pressure_scale_available
Segmentation fault

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = ecc3c000
[00000000] *pgd=87f91831
Internal error: Oops: 80000007 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 1051 Comm: cat Not tainted 4.10.0-rc5-00009-gffd8858-dirty #3
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: ed54ec00 task.stack: ee2bc000
PC is at 0x0
LR is at iio_read_channel_info_avail+0x40/0x280
pc : [<00000000>]    lr : [<c06fbc1c>]    psr: a0070013
sp : ee2bdda8  ip : 00000000  fp : ee2bddf4
r10: c0a53c74  r9 : ed79f000  r8 : ee8d1018
r7 : 00001000  r6 : 00000fff  r5 : ee8b9a00  r4 : ed79f000
r3 : ee2bddc4  r2 : ee2bddbc  r1 : c0a86dcc  r0 : ee8d1000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 3cc3c04a  DAC: 00000051
Process cat (pid: 1051, stack limit = 0xee2bc210)
Stack: (0xee2bdda8 to 0xee2be000)
dda0:                   ee2bddc0 00000002 c016d720 c016d394 ed54ec00 00000000
ddc0: 60070013 ed413780 00000001 edffd480 ee8b9a00 00000fff 00001000 ee8d1018
dde0: ed79f000 c0a53c74 ee2bde0c ee2bddf8 c0513c58 c06fbbe8 edffd480 edffd540
de00: ee2bde3c ee2bde10 c0293474 c0513c40 c02933e4 ee2bde60 00000001 ed413780
de20: 00000001 ed413780 00000000 edffd480 ee2bde4c ee2bde40 c0291d00 c02933f0
de40: ee2bde9c ee2bde50 c024679c c0291ce0 edffd4b0 b6e37000 00020000 ee2bdf78
de60: 00000000 00000000 ed54ec00 ed013200 00000817 c0a111fc edffd540 ed413780
de80: b6e37000 00020000 00020000 ee2bdf78 ee2bded4 ee2bdea0 c0292890 c0246604
dea0: c0117940 c016ba50 00000025 c0a111fc b6e37000 ed413780 ee2bdf78 00020000
dec0: ee2bc000 b6e37000 ee2bdf44 ee2bded8 c021d158 c0292770 c0117764 b6e36004
dee0: c0f0d7c4 ee2bdfb0 b6f89228 00021008 ee2bdfac ee2bdf00 c0101374 c0117770
df00: 00000000 00000000 ee2bc000 00000000 ee2bdf34 ee2bdf20 c016ba04 c0171080
df20: 00000000 00020000 ed413780 b6e37000 00000000 ee2bdf78 ee2bdf74 ee2bdf48
df40: c021e7a0 c021d130 c023e300 c023e280 ee2bdf74 00000000 00000000 ed413780
df60: ed413780 00020000 ee2bdfa4 ee2bdf78 c021e870 c021e71c 00000000 00000000
df80: 00020000 00020000 b6e37000 00000003 c0108084 00000000 00000000 ee2bdfa8
dfa0: c0107ee0 c021e838 00020000 00020000 00000003 b6e37000 00020000 0001a2b4
dfc0: 00020000 00020000 b6e37000 00000003 7fffe000 00000000 00000000 00020000
dfe0: 00000000 be98eb4c 0000c740 b6f1985c 60070010 00000003 00000000 00000000
Backtrace:
[<c06fbbdc>] (iio_read_channel_info_avail) from [<c0513c58>] (dev_attr_show+0x24/0x50)
 r10:c0a53c74 r9:ed79f000 r8:ee8d1018 r7:00001000 r6:00000fff r5:ee8b9a00
 r4:edffd480
[<c0513c34>] (dev_attr_show) from [<c0293474>] (sysfs_kf_seq_show+0x90/0x110)
 r5:edffd540 r4:edffd480
[<c02933e4>] (sysfs_kf_seq_show) from [<c0291d00>] (kernfs_seq_show+0x2c/0x30)
 r10:edffd480 r9:00000000 r8:ed413780 r7:00000001 r6:ed413780 r5:00000001
 r4:ee2bde60 r3:c02933e4
[<c0291cd4>] (kernfs_seq_show) from [<c024679c>] (seq_read+0x1a4/0x4e0)
[<c02465f8>] (seq_read) from [<c0292890>] (kernfs_fop_read+0x12c/0x1cc)
 r10:ee2bdf78 r9:00020000 r8:00020000 r7:b6e37000 r6:ed413780 r5:edffd540
 r4:c0a111fc
[<c0292764>] (kernfs_fop_read) from [<c021d158>] (__vfs_read+0x34/0x118)
 r10:b6e37000 r9:ee2bc000 r8:00020000 r7:ee2bdf78 r6:ed413780 r5:b6e37000
 r4:c0a111fc
[<c021d124>] (__vfs_read) from [<c021e7a0>] (vfs_read+0x90/0x11c)
 r8:ee2bdf78 r7:00000000 r6:b6e37000 r5:ed413780 r4:00020000
[<c021e710>] (vfs_read) from [<c021e870>] (SyS_read+0x44/0x90)
 r8:00020000 r7:ed413780 r6:ed413780 r5:00000000 r4:00000000
[<c021e82c>] (SyS_read) from [<c0107ee0>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r8:c0108084 r7:00000003 r6:b6e37000 r5:00020000 r4:00020000
Code: bad PC value
---[ end trace 9c4938ccd0389004 ]---

Fixes: cc26ad455f57 ("iio: Add Freescale MPL3115A2 pressure / temperature sensor driver")
Fixes: 51239600074b ("iio:core: add a callback to allow drivers to provide _available attributes")
Reported-by: Ken Lin <ken.lin@advantech.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/pressure/mpl3115.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index cc3f84139157..525644a7442d 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -190,7 +190,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -203,7 +203,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
-- 
2.1.4

