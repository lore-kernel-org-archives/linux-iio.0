Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63968 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbcDUMBg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 21 Apr 2016 08:01:36 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <AM4PR02MB129981BAE6A4E893DDD38173BC6D0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Message-ID: <5718C11A.6010001@intel.com>
Date: Thu, 21 Apr 2016 15:01:30 +0300
MIME-Version: 1.0
In-Reply-To: <AM4PR02MB129981BAE6A4E893DDD38173BC6D0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/20/2016 11:31 PM, Peter Rosin wrote:
> Crestez Dan Leonard wrote:
>> Changes since that version:
>> * Nest the adapter in inv_mpu6050_state instead of making it static
>> * Explicitly forward of_node "i2c-aux-master" to allow describing aux devices
>> via devicetree.
>>
>> For bypass/mux mode devicetree works automatically. The forwarding is based on
>> the "chan_id" parameter to i2c_add_mux_adapter and is implemented here:
>>
>> http://lxr.free-electrons.com/source/drivers/i2c/i2c-mux.c?v=4.5#L158
>>
>> Perhaps it might be better for devices handled via master mode to be described
>> via i2c@1? This would work by scanning the mpu node's children for something
>> with reg == 1.
> 
> The 0 in i2c@0 (which is used by the mux mode) is the index of the mux slave
> meaning that i2c@1 would be a second mux slave on the same mux, but this is
> not a real mux as such, it is a gate which is piggybacking on the i2c mux infra.
> So, this "mux" can't have a second slave which is why only 0 is valid.

This behavior is automatic in i2c mux code and seems to assume that all
the children of mux_dev are i2c muxes. This might be obviously correct
and useful for dedicated i2c mux devices but in my case mux_dev is just
the i2c_client for a sensor.

>From Documentation/devicetree/bindings/i2c/i2c-mux.txt:

> An i2c bus multiplexer/switch will have several child busses that are
> numbered uniquely in a device dependent manner.  The nodes for an i2c
> bus multiplexer/switch will have one child node for each child bus.

This seems to be written in a way that would allow me to define the
"auxiliary i2c master" as bus "1". After all, the numbering is device
dependent and it's not clear that all the child busses need to be
accessible through muxing rather than indirect access through device
registers.

>> Or maybe the two busses should be called i2c-aux-master and i2c-aux-mux? Not
>> sure how to deal with that on the mux side.
> 
> Changing i2c to i2c-aux-mux would break existing device trees, that seems
> like a bad thing, no?

That support was not documented in mpu6050's bindings and might not be
actually used.

>> It is not clear how to properly handle this and suggestions are welcome. The
>> way it currently works with this patch is documented immediately below.
> 
> I think the naming could be i2c-master0, i2c-master1 etc if it, with
> future work, would be possible to add more than one master (you talked about
> 5 i2c slaves..).

The device has 5 sets of registers for controlling i2c slaves but only
one physical auxiliary i2c bus. As far as I can tell slaves 0-3 are
intended to be used for gathering readings for slaved sensors
periodically without external intervention. Slave 4 can generate an
interrupt on completion and is more suitable for general-purpose
communication with any number of devices.
