Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35095 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752828AbdEJNHj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2017 09:07:39 -0400
Date: Wed, 10 May 2017 21:07:35 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345_core: Introduce set_mode and
 data_ready functions
Message-ID: <20170510130733.GA5456@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com>
 <652e2497-d091-9468-a4ee-983bcc626d6b@kernel.org>
 <20170502113902.GA3030@Socrates-UM>
 <07a80519-2f22-5974-b03a-8d8aff2f2f07@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07a80519-2f22-5974-b03a-8d8aff2f2f07@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 02, 2017 at 05:32:07PM +0100, Jonathan Cameron wrote:
> On 02/05/17 12:39, Eva Rachel Retuya wrote:
> > On Mon, May 01, 2017 at 01:22:52AM +0100, Jonathan Cameron wrote:
> > Hello Jonathan,
> > [...]
> >>> +static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
> >>> +{
> >>> +	struct device *dev = regmap_get_device(data->regmap);
> >>> +	int ret;
> >>> +
> >>> +	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL, mode);
> >>> +	if (ret < 0) {
> >>> +		dev_err(dev, "Failed to set power mode, %d\n", ret);
> >>> +		return ret;
> >> drop the return ret here and just return ret at the end of the function.
> >> One of the static checkers will probably moan about this otherwise.
> > 
> > OK.
> > 
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int adxl345_data_ready(struct adxl345_data *data)
> >>> +{
> >> So this is a polling the dataready bit.  Will ensure we always
> >> get fresh data when a read occurs.  Please add a comment to
> >> that effect as that's not always how devices work.
> > 
> > OK.
> > 
> >>> +	struct device *dev = regmap_get_device(data->regmap);
> >>> +	int tries = 5;
> >>> +	u32 val;
> >>> +	int ret;
> >>> +
> >>> +	do {
> >>> +		/*
> >>> +		 * 1/ODR + 1.1ms; 11.1ms at ODR of 0.10 Hz
> >>> +		 * Sensor currently operates at default ODR of 100 Hz
> >>> +		 */
> >>> +		usleep_range(1100, 11100);
> >> That's a huge range to allow... I'm not following the argument for why.
> >> Or do we have a stray 0?
> >>
> > 
> > Not a stray 0. Range is from 1.1ms to 11.1ms, this represents the
> > wake-up time when going to standby/other power saving modes ->
> > measurement mode. I'm going to clarify the comment on why it is needed
> > on the next revision.
> The point about a range sleep is to allow the kernel flexibility in scheduling
> so as to avoid waking the processor from lower power states when high precision is
> not needed.
> 
> If the thing you are talking about needs the maximum time sometimes then you
> should set the minimum value to that and add a bit to avoid unnecessary processor
> wake ups.

Thank you for explaining it. I will keep this in mind while working on
the 3rd revision.

Eva
