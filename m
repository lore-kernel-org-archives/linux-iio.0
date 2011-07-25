Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:33435 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1GYQOi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 12:14:38 -0400
Message-ID: <4E2D9673.3040602@cam.ac.uk>
Date: Mon, 25 Jul 2011 17:14:43 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
CC: linux-iio@vger.kernel.org, Greg KH <greg@kroah.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] staging: (iio) restore macro IIO_ATTR_2
References: <1311373619-19188-1-git-send-email-vivien.didelot@savoirfairelinux.com>	<4E2D53E1.90305@cam.ac.uk> <20110725115125.199f8f11@v0nbox>
In-Reply-To: <20110725115125.199f8f11@v0nbox>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/25/11 16:51, Vivien Didelot wrote:
> On Mon, 25 Jul 2011 12:30:41 +0100,
> Jonathan Cameron <jic23@cam.ac.uk> wrote:
> 
>> On 07/22/11 23:26, Vivien Didelot wrote:
>>> For some reason, IIO_ATTR_2 has been deleted by commit
>>> 99e5dc45b854b4b661044e807905152911ed3fdb but it is still used by
>>> the macro IIO_DEVICE_ATTR_2. This patch restores it.
>>> Please ignore it if it shouldn't exist anymore. If so, this would
>>> need to remove IIO_DEVICE_ATTR_2 as well. Obviously it seems to be
>>> useful as the struct iio_dev_attr has a val2 member.
>> Good spot.  Do you have a user for the two parameter version?  If not
>> I'd prefer to just scrap the IIO_DEVICE_ATTR_2 until we actually need
>> it. That also means we can scrap val2 from struct iio_dev_attr which
>> is a nice little clean up.  How about the following?
> 
> I'm actually using the second member, as I'm trying to move the TS-5500
> ADC driver from HWMON to IIO (you can see the HWMON patch here:
> https://lkml.org/lkml/diff/2011/7/19/223/1). It is used in the
> ts5500_adc_show_range() function (nr is the equivalent of val2).
Encode whether we have a min or a max in the single value along with
the channel. Or just have a separate function as it'll only cost you
a couple of lines.  ts5500_adc_range is a misleadingly named trivial
wrapper so I'd squash that into a ts5500_show_range_min and ts5500_show_range_max.

I guess we'll need to have a rethink on supporting range
directly in the iio_chan_spec structures.  People are remarkably keen on
it.  (the reason this is controversial is that it interacts with scale
which is a necessary parameter for interpreting raw values anyway.)
We let it into the abi so should probably make it easy to use.. hmm.

> 
> But I've found the ad7291.c driver which is 8 channels as well. 
> It might offer a solution that avoids using this second parameter. Is
> it a good driver to refer to in this case?
> 
> Regards,
> Vivien.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
No.  Look at any of max1363, ad799x, ad7887 and indeed pretty much any
of the others that have undergone chan_spec conversion.

Usual principal with drivers is find one that has a lot of active development
to copy.

Michael is the ad7291 on your cleanup list? It's on another planet abi wise...

Sorry Vivien if you wasted any time copying stuff from there.
We decided just the other day to start maintaining broken out TODO files for
the drivers. Sorry we didn't have those in place already or it might have saved
you time.

Jonathan




