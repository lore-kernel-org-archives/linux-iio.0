Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55840 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbAAM1T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:27:19 -0500
Message-ID: <54A53D22.4060903@kernel.org>
Date: Thu, 01 Jan 2015 12:27:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: inv_mpu6050: Added adapter class
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1418678363-22437-3-git-send-email-srinivas.pandruvada@linux.intel.com> <549D5690.1070104@kernel.org> <20141231102554.GC1461@katana>
In-Reply-To: <20141231102554.GC1461@katana>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/12/14 10:25, Wolfram Sang wrote:
> On Fri, Dec 26, 2014 at 12:37:36PM +0000, Jonathan Cameron wrote:
>> On 15/12/14 21:19, Srinivas Pandruvada wrote:
>>> To use i2c auto detect to work we need to have a non zero class.
>>> The closest class is I2C_CLASS_HWMON, as it defined to be used
>>> with all hw monitoring drivers.
>>>
>>> Also this class is already used by some iio driver, hid drivers, led
>>> and misc drivers. So this is not new that this is used outside
>>> hwmon drivers.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Been meaning to sort this out for a while.  We really shouldn't be camping
>> on the HWMON class (nor should anyone else).
>>
>> Wolfram, do you mind new classes being added?
> 
> In general, I wouldn't mind but I wonder if it makes sense here. DDC and
> SPD are very special I2C uses where access should be limited, so a
> seperate class makes sense IMO. HWMON has a specific name, but really
> became "everything what people could hook to their I2C bus" these days.
> So, if anything, we could think about renaming I2C_CLASS_HWMON to
> I2C_CLASS_STANDARD or something (or at least add a comment about that in
> i2c.h)? I'd think IIO devices fall into the default category. Please say
> if you think different. If we'd add the IIO class, most drivers will
> need patches to support IIO devices which would have worked otherwise,
> so this change should be justified.
The I2C_CLASS_STANDARD option sounds sensible - though perhaps the comment
would be quicker ;)
> 
> @Jean: Do you have anything to add?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

