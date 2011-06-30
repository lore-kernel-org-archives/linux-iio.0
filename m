Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:35299 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab1F3OuI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2011 10:50:08 -0400
Message-ID: <4E0C8F01.1060707@cam.ac.uk>
Date: Thu, 30 Jun 2011 15:58:09 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Subject: Re: const members of struct iio_chan_spec?
References: <544AC56F16B56944AEC3BD4E3D5917713EA0BC56E5@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713EA0BC56E5@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/30/11 15:04, Hennerich, Michael wrote:
> Hi Jonathan,
> 
> static int ad7280_channel_init(struct ad7280_state *st)
> {
>         int dev, ch, cnt;
> 
>         st->channels = kzalloc(sizeof(*st->channels) *
>                         ((st->slave_num + 1) * 12 + 1), GFP_KERNEL);
>         if (st->channels == NULL)
>                 return -ENOMEM;
> 
>         for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
>                 for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6; ch++, cnt++) {
>                         st->channels[cnt].type = IIO_IN;
>                         st->channels[cnt].indexed = 1;
>                         st->channels[cnt].extend_name = NULL;
>                         st->channels[cnt].channel = cnt;
>                         st->channels[cnt].info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED);
>                         st->channels[cnt].address = dev << 8 | ch;
>                         st->channels[cnt].scan_index = cnt;
>                         st->channels[cnt].scan_type.sign = 'u';
>                         st->channels[cnt].scan_type.realbits = 12;
>                         st->channels[cnt].scan_type.storagebits = 32;
>                         st->channels[cnt].scan_type.shift = 0;
>                 }
>         return cnt;
> }
> 
> Trying to dynamically allocate and populate a channel spec.
> However some members are declared const. Do they really need to be const?
hmm.. technically no, although a large point in the purpose of moving to chan spec
based registration was to allow all this stuff to be constant static arrays.  I guess
there is no particular harm in taking them away from const though.  The functions
should all assume they are constant, but they don't really need to be before any are
called.

As to whether it is the right thing to do here, I guess it depends on how large slave num
can be. Google tells me the answer is really quite large (50)!  Hence I'm convinced you
have a very good reason.

I'll push back on any drivers doing dynamic just to handle small numbers of channels with
variants, but here I'm convinced you have a very good reason.

Please send the patch to make these elements non constant with your driver (as that will
clearly provide justification)

I'll admit I never conceived of anyone having the ability to chain this many sensors.
For smaller chained devices I'd just advise doing them as a big static array then setting
num_channels appropriately. (glad you brought this up as it just made me realise my bug in the
previous set I sent out!)

Jonathan

> 
> drivers/staging/iio/adc/ad7280a_core.c: In function 'ad7280_channel_init':
> drivers/staging/iio/adc/ad7280a_core.c:231: error: assignment of read-only member 'info_mask'
> 
> Regards,
> Michael
> 
> ------------------------------------------------------------------
> ********* Analog Devices GmbH
> **  *****
> **     ** Wilhelm-Wagenfeld-Strasse 6
> **  ***** D-80807 Munich
> ********* Germany
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer: Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

