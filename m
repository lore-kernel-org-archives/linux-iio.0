Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 20 Feb 2015 16:23:48 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
cc: "Tirdea, Irina" <irina.tirdea@intel.com>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "jic23@kernel.org" <jic23@kernel.org>,
    "Reus, Adriana" <adriana.reus@intel.com>,
    "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers in
 trigger handler
In-Reply-To: <1424444331.2916.2.camel@spandruv-mobl2>
Message-ID: <alpine.DEB.2.02.1502201621430.2739@pmeerw.net>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>  <1424110909-16878-3-git-send-email-irina.tirdea@intel.com>  <alpine.DEB.2.02.1502162014280.26763@pmeerw.net>  <1F3AC3675D538145B1661F571FE1805F19A20D9C@irsmsx105.ger.corp.intel.com>
 <1424444331.2916.2.camel@spandruv-mobl2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> > > > +
> > > > +		values[i] = data & 0xFF;
> > > > +		values[i+1] = data >> 8;
> > > 
> > > this is incorrect; it forces the data to be little endian, however, the
> > > endianness (as specified in the driver's .scan_type) is IIO_CPU -- the
> > > code breaks for big-endian CPUs
> > > 
> > > since _read_i2c_block_data() can't do endianness conversion (and the chip
> > > does i2c endianness, i.e. little-endian), the .scan_type should become
> > > IIO_LE and above code is correct again but still ugly :)
> > > 
> > > bottom line: change .scan_type to IIO_LE
> > > 
> > Good point. Changing the endianess to IIO_LE is correct for either kxcjk1013_read_block_data or i2c_smbus_read_i2c_block_data.
> > Will fix this in the next version. Thanks for catching this!
> > 
> I don't think changing to IIO_LE is good idea as when i2c_read_bock..
> then the scan type will be CPU. So better to fix endianness in this
> function.

the chip has little-endian data registers; i2c_read_block() just transfers 
the data (no endianness conversion), so the data will still be 
little-endian

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
