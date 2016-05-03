Return-Path: <leonard.crestez@intel.com>
Subject: Re: [was iio: tmp006: Set correct iio name] how to support multiple
 instances of same device type
To: Gregor Boirie <gregor.boirie@parrot.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
 <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com>
 <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org>
 <571F49B0.4060407@metafoo.de>
 <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
 <571F588D.3010800@metafoo.de>
 <CADO9-peqytsYKxVCsEbYt_fLKH3CaiAeQzfgvA+4CsP6u2yJOQ@mail.gmail.com>
 <CAEnQRZCkcwDUPZHpEOTzcHxQ23xgq429fJQg63s5TUi0w69iWw@mail.gmail.com>
 <5720EFAA.3040407@intel.com> <5721C904.3010505@metafoo.de>
 <20160428142458.09e498e2@lxorguk.ukuu.org.uk>
 <alpine.DEB.2.02.1604281527010.10610@pmeerw.net>
 <57221BF5.6000001@metafoo.de>
 <31d08cee-7ab8-d1e7-b15e-001cb6ea1c7c@kernel.org>
 <572872B8.8060000@parrot.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Yong Li <sdliyong@gmail.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Matt Ranostaj <mranostay@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <572892EA.2060902@intel.com>
Date: Tue, 3 May 2016 15:00:42 +0300
MIME-Version: 1.0
In-Reply-To: <572872B8.8060000@parrot.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 05/03/2016 12:43 PM, Gregor Boirie wrote:
> Just to let you know that I'm facing a problem to support multiple
> instances of
> the ms5607 barometer onto the same board.
> 
> Referencing (i2c) id->name from indio_dev->name is not suitable in this
> case as
> libiio and kernel iio tools such as generic_buffer all rely upon a
> unique iio
> name to distinguish devices. Here is why.
> 
> generic_buffer expects a device name passed as argument to -n option
> to get a reference to a device. In this case, it is not possible to
> distinguish between devices holding the same name.
> 
> When libiio based apps use iio_context_find_device() to get a reference
> to a device (by name), names should be unique across devices as above.
> When retrieving a device reference by index through
> iio_context_get_device()
> it is not possible to uniquely identify devices in a consistent way either.
> Indeed, as indices assignment is automatically done at boot time, it is
> highly
> dependent on module / driver loading ordering, devices / daughter board
> presence,
> etc...
> As a result, apps cannot assume indices are persistent across reboots.
> 
> Hence, using dev_name(&client->dev) to name a device is most certainly
> an acceptable
> option despites inconsistencies it introduces with i2c name space.
> 
> I re-use device tree names to do the job. However, it will not work if
> not compiled
> in (and needs patching). What would be a robust and generic naming
> solution then ?
> 
Identifying iio devices by numeric ID seems to be the correct solution.
These are also the minor device numbers, right? Perhaps you can create
devices nodes with pretty names through udev rules. In particular
OF_FULLNAME seems to be available as a property. Example:

# ssh -t local2222 udevadm info /sys/bus/iio/devices/iio:device0
DEVNAME=/dev/iio:device0
DEVTYPE=iio_device
MAJOR=250
MINOR=0
OF_COMPATIBLE_0=inv,mpu6500
OF_COMPATIBLE_N=1
OF_FULLNAME=/spi/mpu6500@0
OF_NAME=mpu6500
SUBSYSTEM=iio

-- 
Regards
Leonard
