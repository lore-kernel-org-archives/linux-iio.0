Return-Path: <amsfield22@gmail.com>
Date: Sun, 18 Jun 2017 10:37:33 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Franziska Naepelt <franziska.naepelt@googlemail.com>,
	linux-iio@vger.kernel.org
Subject: Re: iio dummy device doesn't appear in /sys/bus/iio/devices/
Message-ID: <20170618173731.GA23925@d830.WORKGROUP>
References: <B51FF1E9-D555-4B6E-92E8-4529C999CF5A@googlemail.com>
 <0B29CB0B-3360-4CD2-AC58-F3AE71EFD69F@googlemail.com>
 <70C5ED34-E2A6-4AB4-AED6-25215227E03F@jic23.retrosnub.co.uk>
 <00FCE47C-4460-42A4-949C-01581B1403F2@googlemail.com>
 <20170611145631.63f3a110@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170611145631.63f3a110@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 11, 2017 at 02:56:31PM +0100, Jonathan Cameron wrote:
> On Tue, 6 Jun 2017 20:03:59 +0200
> Franziska Naepelt <franziska.naepelt@googlemail.com> wrote:
> 
> > Thank you very much Jonathan :)
> > This works now.
> > 
> > I tried it before and failed to make my own dummy directory because I missed 
> > mount -t configfs none /config
> > 
> > A few days before I followed this instructions:
> > 
> > https://kernelnewbies.org/IIO_tasks
> > 
> > and it didn’t work. That was because of the missing mount command.
> > 
> > Thanks,
> > Franziska
> Alison, worth adding a note about mounting configfs to that page?

It's in the directions, just not explicitly. We like a little hunting ;)
 >> Mount the configfs filesystem: read Documentation/iio/iio_configfs.txt
alisons

> 
> Thanks,
> 
> Jonathan
> > 
> > 
> > > Am 05.06.2017 um 21:46 schrieb Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:
> > > 
> > > Hi Francis
> > > 
> > > Change was made from just creating one dummy instance, to providing a configfs entry to 
> > > create them on demand.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/drivers/iio/dummy/iio_simple_dummy.c?h=testing&id=3d85fb6f81046b51e4428e14fb9643ea75648630
> > > 
> > > The commit log talks about how to create them.
> > > You will need configfs mounted though if it is not already.
> > > 
> > > mount -t configfs none /config
> > > 
> > > Putting back old code would have gone back to old creation method.
> > > 
> > > Jonathan
> > > 
> > > 
> > > 
> > > 
> > > On 5 June 2017 18:41:39 BST, "Franziska Näpelt" <franziska.naepelt@googlemail.com> wrote:  
> > >> I just tried to use the kernel 4.4 iio dummy module and compiled it
> > >> against kernel 4.9.
> > >> This works and creates an entry in sysfs.
> > >> 
> > >> To prevent dependencies I made an 
> > >> #undef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
> > >>   
> > >>> Am 05.06.2017 um 16:33 schrieb Franziska Näpelt  
> > >> <franziska.naepelt@googlemail.com>:  
> > >>> 
> > >>> Hi,
> > >>> 
> > >>> I’m just playing around with iio dummy drivers and couldn’t get it  
> > >> work with kernel 4.9 while everything was fine with   
> > >>> kernel 4.4.
> > >>> 
> > >>> Steps for kernel 4.4:
> > >>> * edit Kconfig to create IIO_SIMPLE_DUMMY module
> > >>> * build and install kernel
> > >>> * edit /etc/modules to load iio_dummy
> > >>> * after reboot there is an iio_dummy module loaded and the device  
> > >> appears in sysfs  
> > >>> 
> > >>> Steps for kernel 4.9:
> > >>> * edit Kconfig to create IIO_SW_DEVICE, IIO_SIMPLE_DUMMY,  
> > >> IIO_SIMPLE_DUMMY_BUFFER modules  
> > >>> * build and install kernel
> > >>> * edit /etc/modules to load iio_dummy
> > >>> * after reboot there is an iio_dummy module loaded but doesn’t appear  
> > >> in sysfs  
> > >>> 
> > >>> Is there something wrong with the order, loading modules or do I miss  
> > >> some dependencies?  
> > >>> 
> > >>> Thanks,
> > >>> Franziska
> > >>> 
> > >>> Here are some more detailed information, as first kernel 4.4, then  
> > >> 4.9:  
> > >>> 
> > >>> Linux raspberrypi-3 4.4.50-v7+ #1 SMP Fri Jun 2 00:19:42 CEST 2017  
> > >> armv7l GNU/Linux  
> > >>> ---
> > >>> pi@raspberrypi-3:~/projects $ cat /etc/modules
> > >>> # /etc/modules: kernel modules to load at boot time.
> > >>> #
> > >>> # This file contains the names of kernel modules that should be  
> > >> loaded  
> > >>> # at boot time, one per line. Lines beginning with "#" are ignored.
> > >>> 
> > >>> iio_dummy
> > >>> ---
> > >>> pi@raspberrypi-3:~/projects/raspi-linux $ git diff  
> > >> drivers/staging/iio/Kconfig  
> > >>> diff --git a/drivers/staging/iio/Kconfig  
> > >> b/drivers/staging/iio/Kconfig  
> > >>> index 9d7f000..42d03a3 100644
> > >>> --- a/drivers/staging/iio/Kconfig
> > >>> +++ b/drivers/staging/iio/Kconfig
> > >>> @@ -23,6 +23,7 @@ config IIO_DUMMY_EVGEN
> > >>> 
> > >>> config IIO_SIMPLE_DUMMY
> > >>>       tristate "An example driver with no hardware requirements"
> > >>> +          default y
> > >>>       help
> > >>>        Driver intended mainly as documentation for how to write
> > >>>        a driver. May also be useful for testing userspace code
> > >>> ---
> > >>> pi@raspberrypi-3:~/projects $ lsmod 
> > >>> Module                  Size  Used by
> > >>> bnep                   10340  2 
> > >>> hci_uart               17943  1 
> > >>> btbcm                   5929  1 hci_uart
> > >>> bluetooth             326067  22 bnep,btbcm,hci_uart
> > >>> brcmfmac              186282  0 
> > >>> brcmutil                5661  1 brcmfmac
> > >>> cfg80211              428833  1 brcmfmac
> > >>> rfkill                 16018  4 cfg80211,bluetooth
> > >>> snd_bcm2835            20447  0 
> > >>> snd_pcm                75890  1 snd_bcm2835
> > >>> snd_timer              19288  1 snd_pcm
> > >>> bcm2835_gpiomem         2976  0 
> > >>> snd                    51908  3 snd_bcm2835,snd_timer,snd_pcm
> > >>> bcm2835_wdt             3225  0 
> > >>> uio_pdrv_genirq         3164  0 
> > >>> uio                     8000  1 uio_pdrv_genirq
> > >>> iio_dummy               3072  0 
> > >>> industrialio           33826  1 iio_dummy
> > >>> ipv6                  347563  32 
> > >>> ---
> > >>> pi@raspberrypi-3:/sys/bus/iio/devices/iio:device0 $ ll
> > >>> insgesamt 0
> > >>> drwxr-xr-x  3 root root    0 Jun  4 13:42 .
> > >>> drwxr-xr-x 10 root root    0 Jun  4 13:42 ..
> > >>> -r--r--r--  1 root root 4,0K Jun  4 13:42 dev
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_accel_x_calibbias
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_accel_x_calibscale
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_accel_x_raw
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_activity_running_input
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_activity_walking_input
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_sampling_frequency
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_steps_calibheight
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_steps_en
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_steps_input
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_voltage0_offset
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_voltage0_raw
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_voltage0_scale
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_voltage1-voltage2_raw
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_voltage3-voltage4_raw
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 in_voltage-voltage_scale
> > >>> -r--r--r--  1 root root 4,0K Jun  4 13:42 name
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 out_voltage0_raw
> > >>> drwxr-xr-x  2 root root    0 Jun  4 13:42 power
> > >>> lrwxrwxrwx  1 root root    0 Jun  4 13:42 subsystem -> ../../bus/iio
> > >>> -rw-r--r--  1 root root 4,0K Jun  4 13:42 uevent
> > >>>   
> > >> -------------------------------------------------------------------------------------------------------------------------  
> > >>> Linux raspberrypi-3 4.9.30-v7+ #1 SMP Sun Jun 4 21:07:31 CEST 2017  
> > >> armv7l GNU/Linux  
> > >>> ---
> > >>> /etc/modules -> is the same
> > >>> --- 
> > >>> pi@raspberrypi-3:~/projects/raspi-linux $ git diff  
> > >> drivers/iio/Kconfig   
> > >>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > >>> index 6743b18..e804f63 100644
> > >>> --- a/drivers/iio/Kconfig
> > >>> +++ b/drivers/iio/Kconfig
> > >>> @@ -49,6 +49,7 @@ config IIO_CONSUMERS_PER_TRIGGER
> > >>> config IIO_SW_DEVICE
> > >>>       tristate "Enable software IIO device support"
> > >>>       select IIO_CONFIGFS
> > >>> +       default y
> > >>>       help
> > >>>        Provides IIO core support for software devices. A software
> > >>>        device can be created via configfs or directly by a driver
> > >>> ---
> > >>> pi@raspberrypi-3:~/projects/raspi-linux $ git diff  
> > >> drivers/iio/dummy/Kconfig  
> > >>> diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
> > >>> index aa5824d..1eb7991 100644
> > >>> --- a/drivers/iio/dummy/Kconfig
> > >>> +++ b/drivers/iio/dummy/Kconfig
> > >>> @@ -11,6 +11,7 @@ config IIO_DUMMY_EVGEN
> > >>> config IIO_SIMPLE_DUMMY
> > >>>       tristate "An example driver with no hardware requirements"
> > >>>       depends on IIO_SW_DEVICE
> > >>> +          default y
> > >>>       help
> > >>>        Driver intended mainly as documentation for how to write
> > >>>        a driver. May also be useful for testing userspace code
> > >>> @@ -29,6 +30,7 @@ config IIO_SIMPLE_DUMMY_BUFFER
> > >>>       select IIO_BUFFER
> > >>>       select IIO_TRIGGER
> > >>>       select IIO_KFIFO_BUF
> > >>> +       default y
> > >>>       help
> > >>>         Add buffered data capture to the simple dummy driver.
> > >>> ---
> > >>> pi@raspberrypi-3:~/projects/raspi-linux $ lsmod 
> > >>> Module                  Size  Used by
> > >>> bnep                   12051  2 
> > >>> hci_uart               20020  1 
> > >>> btbcm                   7916  1 hci_uart
> > >>> bluetooth             365473  22 hci_uart,bnep,btbcm
> > >>> brcmfmac              222798  0 
> > >>> brcmutil                9092  1 brcmfmac
> > >>> cfg80211              542989  1 brcmfmac
> > >>> rfkill                 20832  4 bluetooth,cfg80211
> > >>> snd_bcm2835            24427  0 
> > >>> snd_pcm                98565  1 snd_bcm2835
> > >>> snd_timer              23904  1 snd_pcm
> > >>> bcm2835_gpiomem         3940  0 
> > >>> snd                    70032  3 snd_timer,snd_bcm2835,snd_pcm
> > >>> uio_pdrv_genirq         3923  0 
> > >>> fixed                   3285  0 
> > >>> uio                    10268  1 uio_pdrv_genirq
> > >>> iio_dummy               4984  0 
> > >>> industrialio_sw_device     3691  1 iio_dummy
> > >>> industrialio_configfs     1370  1 industrialio_sw_device
> > >>> kfifo_buf               3668  1 iio_dummy
> > >>> industrialio           62929  2 iio_dummy,kfifo_buf
> > >>> ipv6                  408530  32 
> > >>> ---
> > >>> pi@raspberrypi-3:/sys/bus/iio/devices $ ll
> > >>> insgesamt 0
> > >>> drwxr-xr-x 2 root root 0 Jun  5 15:33 .
> > >>> drwxr-xr-x 4 root root 0 Jun  5 15:33 ..
> > >>> 
> > >>> 
> > >>> 
> > >>>   
> > >> 
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> > > 
> > > -- 
> > > Sent from my Android device with K-9 Mail. Please excuse my brevity.  
> > 
> 
