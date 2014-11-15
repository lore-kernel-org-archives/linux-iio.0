Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42818 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbaKOQGj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Nov 2014 11:06:39 -0500
Message-ID: <54677A0D.2090604@kernel.org>
Date: Sat, 15 Nov 2014 16:06:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>
CC: IIO <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3]iio:pressure:bmp280: read compensation data only at
 init
References: <5452E502.6060609@gmx.de> <20141031114709.GC24473@vdogaru> <5453E00B.7080703@gmx.de> <545A47F0.8040808@kernel.org> <20141106130253.GD24473@vdogaru> <5461462F.5040500@gmx.de>
In-Reply-To: <5461462F.5040500@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/14 23:11, Hartmut Knaack wrote:
> Vlad Dogaru schrieb am 06.11.2014 14:02:
>> On Wed, Nov 05, 2014 at 03:53:20PM +0000, Jonathan Cameron wrote:
>>> On 31/10/14 19:16, Hartmut Knaack wrote:
>>>> Vlad Dogaru schrieb am 31.10.2014 12:47:
>>>>> On Fri, Oct 31, 2014 at 02:25:22AM +0100, Hartmut Knaack wrote:
>>>>>> Compensation data is hard coded into the sensors, so it is sufficient to just
>>>>>> read it once during device initialization. Therefor struct bmp280_comp should be
>>>>>> part of bmp280_data (since the elements of bmp280_comp_temp and
>>>>>> bmp280_comp_press have distinct names, they could be merged into bmp280_comp).
>>>>>
>>>>> My first version of the patch did this, but Jonathan suggested [1] that,
>>>>> since we're using regmap, we can rely on it for caching the calibration
>>>>> parameters.  I have no preference for either approach.
>>>>>
>>>> Indeed, I missed to have a closer look at that version, as I discarded it when your second or third version came out.
>>>> So, one question remaining is, if your implementation was, what Jonathan had in mind when he gave the hint about using the regmap cache. I mainly see the disadvantage of copying to the buffer and from there to the variables (and depending on endianness even a conversion) for every single measurement.
>>> Gah.  Now I have to remember what I was thinking!
>>>
>>> Anyhow, I just didn't much like the double cache of these values.
>>> The little endian conversions are pretty trivial...
>>> The code only ended up a little involved because of the
>>> structures to pass this data around.  Why not just have an enum saying what
>>> data is where and pass the buffer.  Then do the little endian on demand and
>>> let the compiler filter out the repeats?
>>>
>>> So combine bmp280_read_compensation_press and bmp280_compensate_press
>>> to something like...
>>> enum {
>>> 	P1,
>>> 	P2,
>>> 	P3,
>>> 	P4,
>>> 	P5,
>>> 	P6,
>>> 	P7,
>>> 	P8,
>>> 	P9
>>> }; // a rare occasion where maybe all on one line would be good ;)
>>>
>>> int bmp280_compensate_press(struct bmp280_data *data)
>>> {
>>> 	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
>>> 	s64 var1, var2, p;
>>>
>>> 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
>>> 			       buf, BMP280_COMP_PRESS_REG_COUNT);
>>> 	if (ret < 0) {
>>> 		dev_err(&data->client->dev,
>>> 			"failed to read pressure calibration parameters\n");
>>> 		return ret;
>>> 	}
>>>
>>> 	var1 = ((s64) data->t_fine) - 128000;
>>> 	var2 = var1 * var1 * (s64) le16_to_cpu(buf[P6]);
>>> 	var2 = var2 + ((var1 * (s64) le16_to_cpu(buf[P5])) << 17);
>>> 	var2 = var2 + (((s64) le16_to_cpu(buf[P4])) << 35);
>>> 	var1 = ((var1 * var1 * (s64) le16_to_cpu(buf[P3])) >> 8) +
>>> 		((var1 * (s64) le16_to_cpu(buf[P2])) << 12);
>>> 	var1 = (((((s64) 1) << 47) + var1)) * ((s64) le16_to_cpu(buf[P1])) >> 33;
>>>
>>> 	if (var1 == 0)
>>> 		return 0;
>>>
>>> 	p = ((((s64) 1048576 - adc_press) << 31) - var2) * 3125;
>>> 	p = div64_s64(p, var1);
>>> 	var1 = (((s64) le16_to_cpu(buf[P9]) * (p >> 13) * (p >> 13)) >> 25;
>>> 	var2 = (((s64) le16_to_cpu[buf[P8]) * p) >> 19;
>>> 	p = ((p + var1 + var2) >> 8) + (((s64) le16_to_cpu(buf[P7])) << 4);
>>>
>>> 	return (u32) p;
>>> }
>>>
>>> Just a thought.  I was never terribly fussed about this other than disliking
>>> data duplication!
>>>>> [1] http://www.spinics.net/lists/linux-iio/msg15099.html
>>
>> I don't think the enum helps readability too much here.  At least it
>> doesn't help me :)
>>
>> How about reading data straight to the (packed) calibration struct and
>> doing the endinanness conversions inline?  Something like this:
>>
>> int bmp280_compensate_press(struct bmp280_data *data)
>> {
>> 	struct bmp280_comp_press comp;
>> 	s64 var1, var2, p;
>>
>> 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
>> 			       &comp, sizeof (comp));
>> 	if (ret < 0) {
>> 		dev_err(&data->client->dev,
>> 			"failed to read pressure calibration parameters\n");
>> 		return ret;
>> 	}
>>
>> 	var1 = ((s64) data->t_fine) - 128000;
>> 	var2 = var1 * var1 * (s64) le16_to_cpu(comp.dig_p6);
>> 	var2 = var2 + ((var1 * (s64) le16_to_cpu(comp.dig_p5)) << 17);
>>
>> 	/* etc */
>>
>> This saves us the extra copying of parameters from buffer to structure,
>> and is a bit more clear than indexing the buffer with enum members, IMO.
>>
>> Thanks,
>> Vlad
> I compile tested several solutions, and Jonathans' resulted in the lowest module size. Downside of course are the increased complexity of the equations introduced by the endianness conversion and that copying from regmap cache to buf costs some resources.
> But I think that memory footprint has a higher importance, so I slightly favor Jonathans solution.
> 
> Jonathan, do you like to send a patch with your solution?
Err. not really :) Bit snowed under so whilst I'll probably get to it one
day it might not be anytime soon.

Anyone else who happens to want to do it then feel free ;)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

