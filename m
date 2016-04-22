Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db3on0103.outbound.protection.outlook.com ([157.55.234.103]:8019
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752364AbcDVLQy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Apr 2016 07:16:54 -0400
From: Peter Rosin <peda@axentia.se>
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
Date: Fri, 22 Apr 2016 11:01:35 +0000
Message-ID: <AM4PR02MB12996F8CFFC48B32E64F5115BC6F0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Crestez Dan Leonard wrote:
> On 04/21/2016 04:56 PM, Peter Rosin wrote:
> > Crestez Dan Leonard wrote:
> >> On 04/20/2016 11:31 PM, Peter Rosin wrote:
> >>> Crestez Dan Leonard wrote:
> >>>> Changes since that version:
> >>>> * Nest the adapter in inv_mpu6050_state instead of making it static
> >>>> * Explicitly forward of_node "i2c-aux-master" to allow describing aux devices
> >>>> via devicetree.
> >>>>
> >>>> For bypass/mux mode devicetree works automatically. The forwarding is based on
> >>>> the "chan_id" parameter to i2c_add_mux_adapter and is implemented here:
> >>>>
> >>>> http://lxr.free-electrons.com/source/drivers/i2c/i2c-mux.c?v=4.5#L158
> >>>>
> >>>> Perhaps it might be better for devices handled via master mode to be described
> >>>> via i2c@1? This would work by scanning the mpu node's children for something
> >>>> with reg == 1.
> >>>
> >>> The 0 in i2c@0 (which is used by the mux mode) is the index of the mux slave
> >>> meaning that i2c@1 would be a second mux slave on the same mux, but this is
> >>> not a real mux as such, it is a gate which is piggybacking on the i2c mux infra.
> >>> So, this "mux" can't have a second slave which is why only 0 is valid.
> >>
> >> This behavior is automatic in i2c mux code and seems to assume that all
> >> the children of mux_dev are i2c muxes. This might be obviously correct
> >> and useful for dedicated i2c mux devices but in my case mux_dev is just
> >> the i2c_client for a sensor.
> >>
> >> From Documentation/devicetree/bindings/i2c/i2c-mux.txt:
> >>
> >>> An i2c bus multiplexer/switch will have several child busses that are
> >>> numbered uniquely in a device dependent manner.  The nodes for an i2c
> >>> bus multiplexer/switch will have one child node for each child bus.
> >>
> >> This seems to be written in a way that would allow me to define the
> >> "auxiliary i2c master" as bus "1". After all, the numbering is device
> >> dependent and it's not clear that all the child busses need to be
> >> accessible through muxing rather than indirect access through device
> >> registers.
> > 
> > You are correct that if you have devicetree children where reg does
> > not match the chan_id given to i2c_add_mux_adapter() those children
> > will be ignored by the i2c-mux code. So, the code would be happy with
> > a devicetree such as:
> > 
> > 	mpu6050@68 {
> > 		compatible = "...";
> > 		reg = <0x68>;
> > 		...
> > 		i2c-aux-mux@0 {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			reg = <0>;
> > 
> > 			foo@44 {
> > 				compatible = "bar";
> > 				reg = <0x44>;
> > 				...
> > 			}
> > 		}
> > 		i2c-aux-master@1 {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			reg = <1>;
> > 
> > 			gazonk@44 {
> > 				compatible = "baz";
> > 				reg = <0x44>;
> > 				...
> > 			}
> > 		}
> > 	}
> > 
> > as long as you do only call i2c_add_mux_adapter() with chan_id = 0. And that
> > is what you are doing. But I think it is a bit subtle...
> 
> This kind of stuff needs to be written up in
> Documentation/devicetree/bindings anyway.

Yes, but it helps if similar things are done in similar ways. I simply
don't know devicetree stuff well enough to know how issues like this
are resolved elsewhere. So, I don't really know, but it just seemed
subtle.

> >>> I think the naming could be i2c-master0, i2c-master1 etc if it, with
> >>> future work, would be possible to add more than one master (you talked about
> >>> 5 i2c slaves..).
> >>
> >> The device has 5 sets of registers for controlling i2c slaves but only
> >> one physical auxiliary i2c bus. As far as I can tell slaves 0-3 are
> >> intended to be used for gathering readings for slaved sensors
> >> periodically without external intervention. Slave 4 can generate an
> >> interrupt on completion and is more suitable for general-purpose
> >> communication with any number of devices.
> > 
> > Ah, ok, so all 5 sets of slave registers are about the same physical i2c
> > bus. So, you basically cannot sanely use this physical aux i2c bus as an
> > i2c-mux and an extra i2c adapter in the same hw design. Correct?
> 
> You can access devices on the auxiliary i2c bus either through mux-ing
> or the adapter added by this patch. I think mux mode works better (lower
> latency) but is not available when the primary connection is via SPI.
> You can use both but it doesn't particularly make sense.

Right, it wouldn't make sense to use i2c-master mode for some devices
and i2c-mux mode for some devices, when all the those devices sit on the
same bus.

> > In that case, couldn't you look at the names of any devicetree children
> > and use that to decide if you should even attempt to call
> > i2c_add_mux_adapter or i2c_add_adapter?
> 
> But the adapter should be added even if nothing is defined for it.
> Registering i2c clients by echoing in new_device is a valid usecase.

Oh, you misunderstand, I meant looking at the name of the children of
the mpu6050 node, not the grand-children. I.e. i2c-aux-mux vs.
i2c-aux-master in the above example.

> What could be done is only register the i2c mux in i2c mode and the i2c
> master in spi mode and make the bindings identical.

That is also possible of course, but if you allow i2c-master also
when connected with i2c, that can be used to resolve address
conflicts between the main i2c bus and the aux bus.

Cheers,
Peter
