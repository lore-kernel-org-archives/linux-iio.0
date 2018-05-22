Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25620 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeEVH7o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 May 2018 03:59:44 -0400
Date: Tue, 22 May 2018 10:59:39 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/9] ACPI/i2c Enumerate several instances out of one
 fwnode
Message-ID: <20180522075939.GG10677@kuha.fi.intel.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
 <f9fc420005d926b2d35854331ec0288d3a98c925.camel@linux.intel.com>
 <336cb6d4-5797-8787-21dd-d816f994cce9@redhat.com>
 <81114e50a1e07763f1645201e42b80a6fc9f33a1.camel@linux.intel.com>
 <0459ced0-ab24-c58e-5d4a-b7b545232252@metafoo.de>
 <a5fdf323-c0af-dc7f-018b-eeec90c5b05e@redhat.com>
 <984e1cb2-d245-917e-cd18-48f8cabb80ee@redhat.com>
 <e9502e27-0124-08c1-e0d3-23cae84dab25@metafoo.de>
 <187792fc-8276-0eba-d486-24dab91e67ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <187792fc-8276-0eba-d486-24dab91e67ce@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 21, 2018 at 09:12:38PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 21-05-18 17:07, Lars-Peter Clausen wrote:
> > On 05/21/2018 03:44 PM, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 21-05-18 15:40, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 21-05-18 15:31, Lars-Peter Clausen wrote:
> > > > > On 05/21/2018 03:13 PM, Andy Shevchenko wrote:
> > > > > > On Mon, 2018-05-21 at 14:34 +0200, Hans de Goede wrote:
> > > > > > > On 21-05-18 11:19, Andy Shevchenko wrote:
> > > > > > 
> > > > > > > > > Patches 6-9 use the new functionality creating?? one i2c-client per
> > > > > > > > > I2cSerialBusV2 resource to make the sensor cluster on the HP X2
> > > > > > > > > work
> > > > > > > > > and
> > > > > > > > > are posted as part of this series to show how this functionality
> > > > > > > > > can
> > > > > > > > > be
> > > > > > > > > used.
> > > > > > > > 
> > > > > > > > I suppose it's better to do an "MFD" type of IIO driver for that
> > > > > > > > chip.
> > > > > > > > Check, for example, drivers/iio/imu/bmi160/bmi160_core.c
> > > > > > > 
> > > > > > > That seems to be a single chip listening on a single i2c address / spi
> > > > > > > chip-select.
> > > > > > 
> > > > > > Ooops, wrong reference.
> > > > > > 
> > > > > > > In the BSG1160 case the 3 sensors are listening on 3 different i2c
> > > > > > > addresses.
> > > > > > 
> > > > > > There is a Bosh magnetometer + accelerometer chip (BMC150). We have just
> > > > > > two independent drivers for them. Luckily for ACPI they have different
> > > > > > IDs (on the platforms where it's used like that).
> > > > > > 
> > > > > > So, my series targeting the series of same IPs under one device...
> > > > > > 
> > > > > > > We could use the drivers/mfd framework, but the we get platform
> > > > > > > devices
> > > > > > > and we would need to patch all 3 existing drivers to support platform
> > > > > > > bindings and get a regmap from there (converting them to regmap where
> > > > > > > necessary).
> > > > > > 
> > > > > > ...and in your case MFD sounds better. Though why do you need to have a
> > > > > > common regmap?
> > > > > 
> > > > > I'm not convinced MFD is the right place. You wouldn't really utilize
> > > > > anything of the MFD subsystem. And in a sense it is not a multi-function
> > > > > device. It's just multiple devices that are described by the same firmware
> > > > > description table entry.
> > > > > 
> > > > > But I think some kind of board driver might be useful here that translates
> > > > > the ACPI description into something more reasonable. I.e. bind to the ACPI
> > > > > ID and then instantiate the 3 child I2C devices on the same bus. Those do
> > > > > not have to be platform drivers and you do not have to use regmap.
> > > > > 
> > > > > The current approach adds board specific workarounds to each of the device
> > > > > drivers. It might be easier to have that managed in a central place.
> > > > 
> > > > Right, I considered that, and I'm actually doing pretty much that for
> > > > a somewhat similar ACPI case, see:
> > > > 
> > > > drivers/platform/x86/intel_cht_int33fe.c
> > > > 
> > > > But there things were more complicated and we also needed to attach
> > > > device-properties, while at the same time we were also somewhat lucky,
> > > > because there are 4 I2cSerialBusV2 resources in the single ACPI fwnode
> > > > and we only care about 2-4, so we can have an i2c-driver in
> > > > platform/drivers/x86 bind to the 1st resource and then have it
> > > > instantiate i2c clients for I2cSerialBusV2 resources 2-4.
> > > > 
> > > > The problem with the BSG1160 case is that we want to also have an
> > > > iio driver bind to the first i2c-client and that will not work
> > > > if an i2c-driver in platform/drivers/x86 binds to the first
> > > > i2c-client and the i2c-subsys will rightfully not let us create another
> > > > i2c-client at the same address.
> > > > 
> > > > About the "board specific workarounds for each of the drivers", I could
> > > > check if they are all checking an id register and if so if I could just
> > > > let all 3 of them try to bind without issues. This will likely still
> > > > require a change to log the id not matching add a less severe log-level.
> > > 
> > > p.s.
> > > 
> > > Also there seems to be a pattern here where this is happening more
> > > often, e.g. see also:
> > > 
> > > https://fedorapeople.org/~jwrdegoede/lenovo-yoga-11e-dstd.dsl
> > > Search for BOSC0200 to find a single Device() blurb describing
> > > 2 bma250 accelerometers at 2 different addresses.
> > > 
> > > And having to write a whole new driver each time this happens is
> > > going to become tedious pretty quick and also seems undesirable.
> > > 
> > > Just adding a HID to an id-table OTOH for each case seems like a
> > > better (less sucking) solution.
> > 
> > I'd use the same argument to argue for the opposite. The fact that is is a
> > common occurrence means it should not be handled in the device driver,
> > because it means you'll end up having to add quirks for each and every
> > vendor binding.
> > 
> > E.g. if you look at the example you provided there is also a mounting matrix
> > and calibration data for each of the two sensors. You need a way to map
> > those to the individual devices.
> > 
> > > 
> > > So I think we should not focus too much on the BSG1160 example
> > > and more try to come up with a generic solution for this as
> > > Andy has done.
> > 
> > I agree that a generic solution is the right approach, but I do not think
> > that adding lots of individual quirks to device drivers is a generic solution.
> > 
> > Maybe we can teach the I2C framework about these hub nodes, so that the
> > device for the hub itself does not prevent the children from binding to
> > their I2C addresses. You are already patching the I2C core anyway.
> 
> Ok, so thinking more about this I think that we indeed need to solve this
> differently. Another argument here is to also not pollute the i2c core
> with a whole bunch of extra code, just to handle these corner cases.
> 
> So my idea is to have an i2c-driver under platform/x86 which deals with
> these special cases where we want multiple i2c-clients instantiated
> from a single ACPI fwnode.
> 
> The idea is to have a bool no_address_busy_check in i2c_board_info,
> with a big fat comment that it is special and should be avoided,
> which disables the i2c_check_addr_busy() check in i2c_new_device().
> 
> This instantiation driver will use per ACPI-HID driver_data
> pointing to an array of:
> 
> struct give_my_type_a_proper_name {
> 	const char *type;
> 	int irq_index;
> }
> 
> The probe will then iterate over this array, stopping at a NULL type
> pointer and instantiate i2c_clients for each entry in the array
> using type as i2c_board_info.type and requesting an interrupt
> from the ACPI fwnode resources using irq_index, except when irq_index
> is -1 (and setting the special no_address_busy_check bool for the
> first instantiation).
> 
> The idea is that by having a generic instantiation loop for this
> driven by per ACPI-HID driver_data we have a generic solution,
> while at the same time having this isolated in a driver which
> can be modular and only loaded when one of the special ACPI HIDs
> is encountered.
> 
> So how does this sound ?  I will give you all some time to reply
> and assuming no one shoots this down try to implement this say
> next weekend.
> 
> Heikki, would this also work for your "INT3515" HID case?

I'm sure it will. I'll test it once you are done.


Thanks,

-- 
heikki
