Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56554 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbaKVUVH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 22 Nov 2014 15:21:07 -0500
Message-ID: <1416687659.3744.28.camel@spandruv-hsb-test>
Subject: Re: [PATCH v1 1/2] iio: imu: inv_mpu6050: Add i2c mux for by pass
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>,
	Linux I2C <linux-i2c@vger.kernel.org>
Date: Sat, 22 Nov 2014 12:20:59 -0800
In-Reply-To: <20141122130818.GA2679@katana>
References: <1416333184-1367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1416333184-1367-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <54707A80.90809@kernel.org> <20141122130818.GA2679@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2014-11-22 at 14:08 +0100, Wolfram Sang wrote:
> On Sat, Nov 22, 2014 at 11:58:56AM +0000, Jonathan Cameron wrote:
> > On 18/11/14 17:53, Srinivas Pandruvada wrote:
> > > This chip has a mode in which this chipset can be i2c master. But
> 
> I don't think it is a master...
> 

Let me explain. The INV MPU65XX chipset provides an accelerometer and
gyroscope. But it allows one more sensor like AK8975 can be connected
directly to it. A INV MPU65XX device driver can access this AK8975 via
INV MPU65XX through its register interface. In this mode the AK8975
chipset is controlled by INV MPU chipset. So outside driver don't need
to worry about the chipset connected to it. The INV MPU chipset take
care of i2c communication to AK8975. You can't access AK8975 from main
processor's i2c bus. There is an analog switch in the MPU INV device
disconnects this client chipset from main processor i2c bus.

They provide a mode in which you can ask to connect the client chipset
like AK8975 to main processor i2c bus. This is called bypass mode. Once
you set MPU in bypass mode then AK8975 can be communicated like any i2c
client device from main processor i2c bus. Since MPU INV can go to sleep
mode deactivating analog switch, we have to make sure that each
transaction with AK8975 enable bypass mode.


> > > the current upstream driver doesn't support such mode as there is
> > > some limited support of clients, which can be connected.
> > > 
> > > To attach such clients to main i2c bus chip has to be set up in
> > > bypass mode. Creates an i2c mux, which will enable/disable this mode.
> > > This was discussed for a while in mailing list, this was the decision.
> 
> ... but more a by-pass? What is the advantage of putting slaves behind
> the by-pass instead of directly connecting it to the bus?
bypass by directly connecting to processor i2c bus.
> 
> > > This change also provides an API, which allows clients to be created for
> > > this mux adapter.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Still wants to go to Wolfram and linux-i2c, given we are adding an i2c mux
> > deep in an IIO driver.
> > 
> > Whilst Wolfram was happy (iirc) with the approach he might want to take
> > a look at the implementation (and I'd rather have his ack before taking this).
> 
> Thanks! Please notice my new email address.
> 
> > > +static struct i2c_adapter *inv_mux_adapter;
> 
> static??? And if I have multiple mpu6050 on the bus?
>  
I am not sure that you can connect two MPU devices as i2c address is
fixed at 0x68. But I can make part of mpu device instance structure
removing static.

> ...
> 
> > > +struct i2c_client *inv_mpu6050_add_mux_client(char *name, unsigned short addr,
> > > +					      int irq, void *plat_data)
> > > +{
> 
> Huh? Why do we need that? Why can't we use the instantiation methods we
> already have?
> 
Unfortunately no. These are Windows 8 tablets with assumption that INV
MPU6X driver is controlling AK8975, without any special driver for
AK8975 (Linux drivers doesn't have this capability). So the ACPI config
data will not have any entry for AK8975 as a device with i2c address. We
have to parse INV MPU6X ACPI configuration's private data in a DMI
specific x86 platform driver and find out AK8975 address and create a
client device for this i2c-mux. This configuration doesn't follow any
standard ACPI device with i2c configuration (Here only INV MPU6X is
shown as a i2c device in ACPI).


Thanks,
Srinivas







> Rest looks okay from a first glimpse.
> 
>    Wolfram
> 


