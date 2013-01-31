Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [217.64.175.212] ([217.64.175.212]:37142 "EHLO
	mx-relay12-muc.antispameurope.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752877Ab3AaShf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 13:37:35 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH V3] iio: gyro: Add itg3200
Date: Thu, 31 Jan 2013 19:37:10 +0100
Cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
References: <201301311254.49626.manuel.stahl@iis.fraunhofer.de> <1359634652-25868-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <510A8BF6.2070701@metafoo.de>
In-Reply-To: <510A8BF6.2070701@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301311937.10124.manuel.stahl@iis.fraunhofer.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am Donnerstag, 31. Januar 2013, 16:21:26 schrieb Lars-Peter Clausen:
> On 01/31/2013 01:17 PM, Manuel Stahl wrote:
> > Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> 
> Having at least a short commit message wouldn't hurt. E.g. something along
> the lines of: "This patch adds support for the InvenSense itg3200. The
> itg3200 is a three-axis gyro and ..."

OK, no problem.
 
> I get one build warning:
> 	CC      drivers/iio/gyro/itg3200_core.o
> 	drivers/iio/gyro/itg3200_core.c:302: warning: initialization from
> 	incompatible pointer type

[...]

> > +static ssize_t itg3200_read_raw(struct iio_dev *indio_dev,
> 
> This triggers the build warning, the return type should be int.
> 
> > +		const struct iio_chan_spec *chan,
> > +		int *val, int *val2, long info)
> > +{
> > +	ssize_t ret = 0;
> 
> What I meant with the comment in my previous mail was make ret int.

Sorry, I should do more exhaustive tests...

[...]

> > +static int itg3200_probe(struct i2c_client *client,
> > +		const struct i2c_device_id *id)
> > +{
> > +	int ret;
> > +	struct itg3200 *st;
> > +	struct iio_dev *indio_dev;
> > +	const unsigned long avail_scan_masks[] = { 0xffffffff, 0x0 };
> 
> This needs to be static. Right now it is on the stack and well gone after
> probe has been run.

Is it OK to make it static inside itg3200_probe() or should it be global?


-- 
Regards,
Manuel Stahl
