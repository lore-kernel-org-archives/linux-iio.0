Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:36718 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbcBIQar (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 11:30:47 -0500
Received: by mail-yk0-f196.google.com with SMTP id z13so4976366ykd.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Feb 2016 08:30:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160208071634.GA26438@deathstar>
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com> <20160208071634.GA26438@deathstar>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Tue, 9 Feb 2016 14:30:26 -0200
Message-ID: <CAKi4VALfjm6n48Mj4cMGqu8y6L4yAc1e+qf9TAno0tvqw1N-cg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
To: Michael Welling <mwelling@ieee.org>
Cc: Adriana Reus <adriana.reus@intel.com>, jic23@kernel.org,
	linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 8, 2016 at 5:16 AM, Michael Welling <mwelling@ieee.org> wrote:
> On Thu, Feb 04, 2016 at 11:20:24AM +0200, Adriana Reus wrote:
>> This series splits this driver into general and I2C/SPI specific functionality.
>> The first patch is a fix for a bug in the interrupt pin configuration.
>> The second patch changes all the I2C specific calls into regmap calls.
>> The third patch separated the remaining I2C specific part into a different component.
>> Finally the fourth patch adds SPI support for the MPU6000 chip.
>>
>> No changes since v1 for the first two patches.
>> Small changes since v1 to the last two patches
>>
>
> After fixing the compilation error, I was able to get the driver to run
> on the Dragonboard 410c. I tested it with a robotics mezzanine board that
> I designed. The driver appears to work with the MPU-9250 as it has the
> same core funtionality.

Yeah, but the register values for sample rate configuration is
different - MPU9250 supports higher sample rates.  It can also work with a few
changes to drive ICM-20608 as well. Most of the code can be shared indeed.

Lucas De Marchi
