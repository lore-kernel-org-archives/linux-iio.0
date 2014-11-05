Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43525 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471AbaKEP5F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 10:57:05 -0500
Message-ID: <545A48D0.5070408@kernel.org>
Date: Wed, 05 Nov 2014 15:57:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: IIO <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3]iio:pressure:bmp280: fix pressure calculation
References: <5452E454.8040607@gmx.de> <20141031114311.GA24473@vdogaru>
In-Reply-To: <20141031114311.GA24473@vdogaru>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/14 11:43, Vlad Dogaru wrote:
> On Fri, Oct 31, 2014 at 02:22:28AM +0100, Hartmut Knaack wrote:
>> According to the datasheet and as defined in struct bmp280_comp_press, dig_p1 is
>> of type u16, while dig_p2 to dig_p9 are of type s16. In
>> bmp280_read_compensation_press(), values read from the device were treated as
>> the wrong type.
>> In bmp280_read_press() the fractional part of the measured pressure is
>> calculated wrong. A better way is to use *val for the raw pressure and *val2 for
>> the quotient and let the core do the proper conversion using IIO_VAL_FRACTIONAL.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Acked-by: Vlad Dogaru <vlad.dogaru@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
