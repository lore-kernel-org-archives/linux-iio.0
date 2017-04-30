Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35060 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423981AbdD3RDi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 13:03:38 -0400
Subject: Re: [PATCH] iio: st_pressure: st_accel: Initialise sensor platform
 data properly
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi83@gmail.com, gregor.boirie@parrot.com,
        rob@kernel.org, linux-kernel@vger.kernel.org,
        m.niestroj@grinn-global.com
References: <20170419140500.7793-1-shrirang.bagul@canonical.com>
 <022dcd26-801b-5a5e-ee75-45791d9c5986@kernel.org>
 <1493352662.4172.1.camel@canonical.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <33e24c0c-9954-d662-adb9-01add66e7f5a@kernel.org>
Date: Sun, 30 Apr 2017 18:03:33 +0100
MIME-Version: 1.0
In-Reply-To: <1493352662.4172.1.camel@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/04/17 05:11, Shrirang Bagul wrote:
> On Wed, 2017-04-26 at 06:37 +0100, Jonathan Cameron wrote:
>> On 19/04/17 15:05, Shrirang Bagul wrote:
>>> This patch fixes the sensor platform data initialisation for st_pressure
>>> and st_accel device drivers. Without this patch, the driver fails to
>>> register the sensors when the user removes and re-loads the driver.
>>>
>>> 1. Unload the kernel modules for st_pressure
>>> $ sudo rmmod st_pressure_i2c
>>> $ sudo rmmod st_pressure
>>>
>>> 2. Re-load the driver
>>> $ sudo insmod st_pressure
>>> $ sudo insmod st_pressure_i2c
>>> --- OR ---
>>> $ sudo modprobe st_pressure_i2c
>>>
>>> dmesg errors:
>>>
>>> [ 160.935707] iio iio:device2: DRDY on pdata not valid.
>>> [ 160.941505] st-press-i2c: probe of i2c-SMO9210:00 failed with error -22
>>>
>>> The driver fails to register the pressure sensor device. Devices
>>> supported by st_accel driver also suffer from the same bug.
>>>
>>> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
>>
>> Unless I am missing something, the severity of this bug is fairly minor
>> so whilst I'm pleased to have it fixed, I'm not intending to mark this
>> for stable.
>>
>> If anyone has a cunning way of exploiting it then let me know!
> Stress testing st_pressure_i2c, st_pressure module load/unload does cause the kernel
> to panic.
That requires root access, and isn't something that is done under normal operation.
I assumed it would crash - question was whether the crash could be
exploited to do anything else. I'm thinking no, so it's low severity.

Jonathan
> 
> Apr 27 18:11:21 caracalla kernel: [ 8417.756968] BUG: unable to handle kernel paging
> request at ffffffffc0377c48
> Apr 27 18:11:21 caracalla kernel: [ 8417.764869] IP: [<ffffffffc03319a6>]
> st_sensors_init_sensor+0x26/0x1f0 [st_sensors]
> Apr 27 18:11:21 caracalla kernel: [ 8417.773550] PGD 2e0d067 PUD 2e0f067 PMD 3792b067
> PTE 0
> Apr 27 18:11:21 caracalla kernel: [ 8417.779382] Oops: 0000 [#1] SMP
> Apr 27 18:11:21 caracalla kernel: [ 8417.783045] Modules linked in:
> st_pressure_i2c(+) st_pressure hts221_i2c msr cmac algif_hash algif_skcipher af_alg
> hci_vhci rfcomm bnep arc4 iTCO_wdt iTCO_vendor_support snd_soc_sst_bytcr_rt5660
> dell_wmi sparse_keymap ven_rsi_sdio ven_rsi_91x intel_soc_dts_iosf bluetooth
> intel_powerclamp coretemp kvm_intel kvm dcdbas mac80211 irqbypass punit_atom_debug
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 cfg80211 lrw
> gf128mul glue_helper ablk_helper input_leds cryptd psmouse serio_raw cdc_mbim cdc_wdm
> cdc_ncm uas r8169 usbnet cdc_acm lpc_ich mii mei_txe mei snd_intel_sst_acpi shpchp
> snd_intel_sst_core snd_soc_rt5660 snd_soc_sst_mfld_platform snd_soc_rl6231
> snd_soc_core 8250_fintek fjes st_accel_i2c st_accel st_sensors_i2c hts221 i2c_hid
> st_sensors snd_compress ad5593r ac97_bus hid industrialio_triggered_buffer kfifo_buf
> ad5592r_base industrialio snd_pcm_dmaengine snd_pcm tpm_crb snd_timer dw_dmac snd
> dw_dmac_core soundcore rfkill_gpio mac_hid spi_pxa2xx_platform
> i2c_designware_platform i2c_designware_core pwm_lpss_platform snd_soc_sst_acpi
> 8250_dw pwm_lpss iptable_filter ip_tables ip6table_filter ip6_tables x_tables autofs4
> sdhci_pci virtio_scsi ahci libahci mmc_block i915 i2c_algo_bit drm_kms_helper
> syscopyarea sysfillrect sysimgblt fb_sys_fops usb_storage drm wmi video sdhci_acpi
> sdhci [last unloaded: st_pressure]
> Apr 27 18:11:21 caracalla kernel: [ 8417.917926] CPU: 0 PID: 15523 Comm: modprobe Not
> tainted 4.4.0-77-generic #98-Ubuntu
> Apr 27 18:11:21 caracalla kernel: [ 8417.926686] Hardware name: Dell Inc. Edge
> Gateway 3003/ , BIOS 00.00.28 03/23/2017
> Apr 27 18:11:21 caracalla kernel: [ 8417.935739] task: ffff88007521a640 ti:
> ffff88007639c000 task.ti: ffff88007639c000
> Apr 27 18:11:21 caracalla kernel: [ 8417.944202] RIP: 0010:[<ffffffffc03319a6>]
> [<ffffffffc03319a6>] st_sensors_init_sensor+0x26/0x1f0 [st_sensors]
> Apr 27 18:11:21 caracalla kernel: [ 8417.955627] RSP: 0018:ffff88007639fac8 EFLAGS:
> 00010206
> Apr 27 18:11:21 caracalla kernel: [ 8417.961632] RAX: ffffffffc0328640 RBX:
> ffff880076832800 RCX: 0000000000000003
> Apr 27 18:11:21 caracalla kernel: [ 8417.969702] RDX: ffff8800371c9820 RSI:
> ffffffffc0377c48 RDI: ffff880076832800
> Apr 27 18:11:21 caracalla kernel: [ 8417.977772] RBP: ffff88007639fad0 R08:
> ffff88007639c000 R09: 0000000000000000
> Apr 27 18:11:21 caracalla kernel: [ 8417.985841] R10: 00000000000000b6 R11:
> 0000000000000000 R12: 0000000000000000
> Apr 27 18:11:21 caracalla kernel: [ 8417.993911] R13: 0000000000000003 R14:
> ffff880076832cc0 R15: ffffffffc03730a0
> Apr 27 18:11:21 caracalla kernel: [ 8418.001982] FS: 00007f71faa83700(0000)
> GS:ffff880070a00000(0000) knlGS:0000000000000000
> Apr 27 18:11:21 caracalla kernel: [ 8418.011133] CS: 0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Apr 27 18:11:21 caracalla kernel: [ 8418.017629] CR2: ffffffffc0377c48 CR3:
> 0000000074d7d000 CR4: 00000000001006f0
> Apr 27 18:11:21 caracalla kernel: [ 8418.025698] Stack:
> Apr 27 18:11:21 caracalla kernel: [ 8418.027967] ffff880076832800 ffff88007639faf8
> ffffffffc03270ea ffff880076832800
> Apr 27 18:11:21 caracalla kernel: [ 8418.036363] ffff8800371c9800 ffff8800371c9820
> ffff88007639fb30 ffffffffc037207d
> Apr 27 18:11:21 caracalla kernel: [ 8418.044757] ffffffffc03730a0 ffff8800371c9820
> ffff8800371c9800 ffffffffc0372020
> Apr 27 18:11:21 caracalla kernel: [ 8418.053152] Call Trace:
> Apr 27 18:11:21 caracalla kernel: [ 8418.055920] [<ffffffffc03270ea>]
> st_press_common_probe+0xea/0x1a0 [st_pressure]
> Apr 27 18:11:21 caracalla kernel: [ 8418.064292] [<ffffffffc037207d>]
> st_press_i2c_probe+0x5d/0xdc [st_pressure_i2c]
> Apr 27 18:11:21 caracalla kernel: [ 8418.072660] [<ffffffffc0372020>] ?
> st_press_i2c_remove+0x20/0x20 [st_pressure_i2c]
> Apr 27 18:11:21 caracalla kernel: [ 8418.081325] [<ffffffff8168bff0>]
> i2c_device_probe+0x100/0x1b0
> Apr 27 18:11:21 caracalla kernel: [ 8418.087925] [<ffffffff8155d962>]
> driver_probe_device+0x222/0x4a0
> Apr 27 18:11:21 caracalla kernel: [ 8418.094819] [<ffffffff8155dc64>]
> __driver_attach+0x84/0x90
> Apr 27 18:11:21 caracalla kernel: [ 8418.101122] [<ffffffff8155dbe0>] ?
> driver_probe_device+0x4a0/0x4a0
> Apr 27 18:11:21 caracalla kernel: [ 8418.108212] [<ffffffff8155b58c>]
> bus_for_each_dev+0x6c/0xc0
> Apr 27 18:11:21 caracalla kernel: [ 8418.114614] [<ffffffff8155d11e>]
> driver_attach+0x1e/0x20
> Apr 27 18:11:21 caracalla kernel: [ 8418.120720] [<ffffffff8155cc5b>]
> bus_add_driver+0x1eb/0x280
> Apr 27 18:11:21 caracalla kernel: [ 8418.127121] [<ffffffffc00c5000>] ?
> 0xffffffffc00c5000
> Apr 27 18:11:21 caracalla kernel: [ 8418.132933] [<ffffffff8155e570>]
> driver_register+0x60/0xe0
> Apr 27 18:11:21 caracalla kernel: [ 8418.143014] [<ffffffff8168cbb1>]
> i2c_register_driver+0x41/0xa0
> Apr 27 18:11:21 caracalla kernel: [ 8418.153492] [<ffffffffc00c5017>]
> st_press_driver_init+0x17/0x1000 [st_pressure_i2c]
> Apr 27 18:11:21 caracalla kernel: [ 8418.166063] [<ffffffff81002123>]
> do_one_initcall+0xb3/0x200
> Apr 27 18:11:21 caracalla kernel: [ 8418.176244] [<ffffffff81837a48>] ?
> preempt_schedule_common+0x18/0x30
> Apr 27 18:11:21 caracalla kernel: [ 8418.187259] [<ffffffff81837a7c>] ?
> _cond_resched+0x1c/0x30
> Apr 27 18:11:21 caracalla kernel: [ 8418.197250] [<ffffffff811ed1a3>] ?
> kmem_cache_alloc_trace+0x183/0x1f0
> Apr 27 18:11:21 caracalla kernel: [ 8418.208323] [<ffffffff8118da83>]
> do_init_module+0x5f/0x1cf
> Apr 27 18:11:21 caracalla kernel: [ 8418.218242] [<ffffffff8110a9af>]
> load_module+0x166f/0x1c10
> Apr 27 18:11:21 caracalla kernel: [ 8418.228065] [<ffffffff81106f50>] ?
> __symbol_put+0x60/0x60
> Apr 27 18:11:21 caracalla kernel: [ 8418.237698] [<ffffffff81214e20>] ?
> kernel_read+0x50/0x80
> Apr 27 18:11:21 caracalla kernel: [ 8418.247133] [<ffffffff8110b194>]
> SYSC_finit_module+0xb4/0xe0
> Apr 27 18:11:21 caracalla kernel: [ 8418.256869] [<ffffffff8110b1de>]
> SyS_finit_module+0xe/0x10
> Apr 27 18:11:21 caracalla kernel: [ 8418.266311] [<ffffffff8183b972>]
> entry_SYSCALL_64_fastpath+0x16/0x71
> Apr 27 18:11:21 caracalla kernel: [ 8418.276651] Code: 0f 1f 44 00 00 0f 1f 44 00 00
> 55 48 85 f6 48 89 e5 53 48 89 fb 74 57 48 8b 87 d0 04 00 00 80 b8 8e 01 00 00 00 0f
> 84 04 01 00 00 <0f> b6 16 80 fa 01 0f 84 30 01 00 00 80 fa 02 0f 85 0f 01 00 00
> Apr 27 18:11:21 caracalla kernel: [ 8418.304581] RIP [<ffffffffc03319a6>]
> st_sensors_init_sensor+0x26/0x1f0 [st_sensors]
> Apr 27 18:11:21 caracalla kernel: [ 8418.316345] RSP <ffff88007639fac8>
> Apr 27 18:11:21 caracalla kernel: [ 8418.323222] CR2: ffffffffc0377c48
> Apr 27 18:11:21 caracalla kernel: [ 8418.336671] ---[ end trace 7d11c35270e28483 ]---
> 
> Thanks,
> Shrirang
>>
>> Applied to the togreg branch of iio.git and pushed out as testing for the
>> autobuilders to play with it.
>>
>> Thanks,
>>
>> Jonathan
>>> ---
>>>  drivers/iio/accel/st_accel_core.c       | 7 ++++---
>>>  drivers/iio/pressure/st_pressure_core.c | 8 ++++----
>>>  2 files changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/st_accel_core.c
>>> b/drivers/iio/accel/st_accel_core.c
>>> index 784670e2736b..07d1489cd457 100644
>>> --- a/drivers/iio/accel/st_accel_core.c
>>> +++ b/drivers/iio/accel/st_accel_core.c
>>> @@ -710,6 +710,8 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>>>  int st_accel_common_probe(struct iio_dev *indio_dev)
>>>  {
>>>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>>> +	struct st_sensors_platform_data *pdata =
>>> +		(struct st_sensors_platform_data *)adata->dev->platform_data;
>>>  	int irq = adata->get_irq_data_ready(indio_dev);
>>>  	int err;
>>>  
>>> @@ -736,9 +738,8 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>>>  					&adata->sensor_settings->fs.fs_avl[0];
>>>  	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
>>>  
>>> -	if (!adata->dev->platform_data)
>>> -		adata->dev->platform_data =
>>> -			(struct st_sensors_platform_data *)&default_accel_pdata;
>>> +	if (!pdata)
>>> +		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
>>>  
>>>  	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
>>>  	if (err < 0)
>>> diff --git a/drivers/iio/pressure/st_pressure_core.c
>>> b/drivers/iio/pressure/st_pressure_core.c
>>> index 5f2680855552..0d8d5665769a 100644
>>> --- a/drivers/iio/pressure/st_pressure_core.c
>>> +++ b/drivers/iio/pressure/st_pressure_core.c
>>> @@ -567,6 +567,8 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
>>>  int st_press_common_probe(struct iio_dev *indio_dev)
>>>  {
>>>  	struct st_sensor_data *press_data = iio_priv(indio_dev);
>>> +	struct st_sensors_platform_data *pdata =
>>> +		(struct st_sensors_platform_data *)press_data->dev-
>>>> platform_data;
>>>  	int irq = press_data->get_irq_data_ready(indio_dev);
>>>  	int err;
>>>  
>>> @@ -602,10 +604,8 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>>>  	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
>>>  
>>>  	/* Some devices don't support a data ready pin. */
>>> -	if (!press_data->dev->platform_data &&
>>> -				press_data->sensor_settings->drdy_irq.addr)
>>> -		press_data->dev->platform_data =
>>> -			(struct st_sensors_platform_data *)&default_press_pdata;
>>> +	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
>>> +		pdata =	(struct st_sensors_platform_data
>>> *)&default_press_pdata;
>>>  
>>>  	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
>>>  	if (err < 0)
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

