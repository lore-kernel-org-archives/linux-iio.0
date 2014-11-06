Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57789 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbaKFNDA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Nov 2014 08:03:00 -0500
Date: Thu, 6 Nov 2014 15:02:54 +0200
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, IIO <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3]iio:pressure:bmp280: read compensation data only at
 init
Message-ID: <20141106130253.GD24473@vdogaru>
References: <5452E502.6060609@gmx.de>
 <20141031114709.GC24473@vdogaru>
 <5453E00B.7080703@gmx.de>
 <545A47F0.8040808@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <545A47F0.8040808@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 05, 2014 at 03:53:20PM +0000, Jonathan Cameron wrote:
> On 31/10/14 19:16, Hartmut Knaack wrote:
> > Vlad Dogaru schrieb am 31.10.2014 12:47:
> >> On Fri, Oct 31, 2014 at 02:25:22AM +0100, Hartmut Knaack wrote:
> >>> Compensation data is hard coded into the sensors, so it is sufficient to just
> >>> read it once during device initialization. Therefor struct bmp280_comp should be
> >>> part of bmp280_data (since the elements of bmp280_comp_temp and
> >>> bmp280_comp_press have distinct names, they could be merged into bmp280_comp).
> >>
> >> My first version of the patch did this, but Jonathan suggested [1] that,
> >> since we're using regmap, we can rely on it for caching the calibration
> >> parameters.  I have no preference for either approach.
> >>
> > Indeed, I missed to have a closer look at that version, as I discarded it when your second or third version came out.
> > So, one question remaining is, if your implementation was, what Jonathan had in mind when he gave the hint about using the regmap cache. I mainly see the disadvantage of copying to the buffer and from there to the variables (and depending on endianness even a conversion) for every single measurement.
> Gah.  Now I have to remember what I was thinking!
> 
> Anyhow, I just didn't much like the double cache of these values.
> The little endian conversions are pretty trivial...
> The code only ended up a little involved because of the
> structures to pass this data around.  Why not just have an enum saying what
> data is where and pass the buffer.  Then do the little endian on demand and
> let the compiler filter out the repeats?
> 
> So combine bmp280_read_compensation_press and bmp280_compensate_press
> to something like...
> enum {
> 	P1,
> 	P2,
> 	P3,
> 	P4,
> 	P5,
> 	P6,
> 	P7,
> 	P8,
> 	P9
> }; // a rare occasion where maybe all on one line would be good ;)
> 
> int bmp280_compensate_press(struct bmp280_data *data)
> {
> 	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
> 	s64 var1, var2, p;
> 
> 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
> 			       buf, BMP280_COMP_PRESS_REG_COUNT);
> 	if (ret < 0) {
> 		dev_err(&data->client->dev,
> 			"failed to read pressure calibration parameters\n");
> 		return ret;
> 	}
> 
> 	var1 = ((s64) data->t_fine) - 128000;
> 	var2 = var1 * var1 * (s64) le16_to_cpu(buf[P6]);
> 	var2 = var2 + ((var1 * (s64) le16_to_cpu(buf[P5])) << 17);
> 	var2 = var2 + (((s64) le16_to_cpu(buf[P4])) << 35);
> 	var1 = ((var1 * var1 * (s64) le16_to_cpu(buf[P3])) >> 8) +
> 		((var1 * (s64) le16_to_cpu(buf[P2])) << 12);
> 	var1 = (((((s64) 1) << 47) + var1)) * ((s64) le16_to_cpu(buf[P1])) >> 33;
> 
> 	if (var1 == 0)
> 		return 0;
> 
> 	p = ((((s64) 1048576 - adc_press) << 31) - var2) * 3125;
> 	p = div64_s64(p, var1);
> 	var1 = (((s64) le16_to_cpu(buf[P9]) * (p >> 13) * (p >> 13)) >> 25;
> 	var2 = (((s64) le16_to_cpu[buf[P8]) * p) >> 19;
> 	p = ((p + var1 + var2) >> 8) + (((s64) le16_to_cpu(buf[P7])) << 4);
> 
> 	return (u32) p;
> }
> 
> Just a thought.  I was never terribly fussed about this other than disliking
> data duplication!
> >> [1] http://www.spinics.net/lists/linux-iio/msg15099.html

I don't think the enum helps readability too much here.  At least it
doesn't help me :)

How about reading data straight to the (packed) calibration struct and
doing the endinanness conversions inline?  Something like this:

int bmp280_compensate_press(struct bmp280_data *data)
{
	struct bmp280_comp_press comp;
	s64 var1, var2, p;

	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
			       &comp, sizeof (comp));
	if (ret < 0) {
		dev_err(&data->client->dev,
			"failed to read pressure calibration parameters\n");
		return ret;
	}

	var1 = ((s64) data->t_fine) - 128000;
	var2 = var1 * var1 * (s64) le16_to_cpu(comp.dig_p6);
	var2 = var2 + ((var1 * (s64) le16_to_cpu(comp.dig_p5)) << 17);

	/* etc */

This saves us the extra copying of parameters from buffer to structure,
and is a bit more clear than indexing the buffer with enum members, IMO.

Thanks,
Vlad
