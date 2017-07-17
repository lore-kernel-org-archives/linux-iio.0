Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:30645 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751318AbdGQVoV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2017 17:44:21 -0400
From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: Documentation: Add ina2xx shunt_resistor
 attribute documentation
Date: Mon, 17 Jul 2017 21:44:19 +0000
Message-ID: <10350930.kllyJhgabW@sbruens-linux>
References: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
 <2351a045a0564f5bb2af6c652d1fa5e3@rwthex-w2-b.rwth-ad.de>
 <20170717215357.6452f0f5@kernel.org>
In-Reply-To: <20170717215357.6452f0f5@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Montag, 17. Juli 2017 22:53:57 CEST Jonathan Cameron wrote:
> On Mon, 17 Jul 2017 01:34:10 +0200
> 
> Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:
> > The ina2xx driver appeared in the Linux kernel version 4.5, but provided
> > no documentation. Contrary to other uses of resistance in IIO, ina2xx uses
> > microohms instead of ohms in the sysfs attribute.
> > 
> > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> 
> This has me confused.  The documentation is already
> there and lists it as being in ohms.

Which obviously, from reading the source code, is wrong - it uses microohms.

Also, the current Description contains IMHO irrelevant stuff:
"The value of the shunt resistor may be known only at runtime fom an
 eeprom content read by a client application."

> Ah, subtle filename difference.  Docs in are
> Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc

Well spotted ...

> This attribute effectively exists for other parts
> as well now.

My grep foo failed me here, the only parts I could find are the MAX9611 (which 
specifies and uses ohms) and the INA2xx.

adc/qcom-spmi-iadc.c allows to read the RSENSE value from device tree 
(specified in microohms), but does not expose it via sysfs.

Can you point me to other devices?

Slightly off-topic: Some attributes in iio are read from device-tree (e.g. 
shunt resistor values), should the iio documentation point to the dt bindings? 
Currently, only mount_matrix in sysfs-bus-iio vaguely mentions device-tree.

Kind regards,

Stefan

> > ---
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> > b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc new file mode
> > 100644
> > index 000000000000..9525098f6822
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> > @@ -0,0 +1,7 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
> > +Date:		December 2015
> > +KernelVersion:	4.5
> > +Contact:	linux-iio@vger.kernel.org
> > +Description: 	The value of the shunt resistor connected to the V_IN+ 
and
> > V_IN- +		inputs, used to compute the current flowing through the shunt
> > and +		the corresponding power. In microohms.

