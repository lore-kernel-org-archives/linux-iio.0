Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60098 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbC1MpX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 08:45:23 -0400
Message-ID: <5516A261.3030000@kernel.org>
Date: Sat, 28 Mar 2015 12:45:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbQ==?=
	 =?UTF-8?B?ZW50IGRlIFNhaW50LU1hcmNx?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH v2 4/7] iio: core: Introduce IIO_CHAN_INFO_EMISSIVITY
References: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com> <1427212459-31585-5-git-send-email-vianney.leclement@essensium.com> <55118A93.5050202@metafoo.de>
In-Reply-To: <55118A93.5050202@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/15 16:02, Lars-Peter Clausen wrote:
> On 03/24/2015 04:54 PM, Vianney le Clément de Saint-Marcq wrote:
>> Contact-less IR temperature sensors measure the temperature of an object
>> by using its thermal radiation.  Surfaces with different emissivity
>> ratios emit different amounts of energy at the same temperature.
>>
>> IIO_CHAN_INFO_EMISSIVITY allows the user to inform the sensor of the
>> emissivity of the object in front of it, in order to effectively measure
>> its temperature.
> 

> All the other attributes that need to be setup according to the
> object being measured start with the calib prefix. So maybe call this
> calibemissivity.
Agreed. It's an internally applied calibration parameter (be it one that
is likely to change more than the average calibration!) so should have
the calib prefix.

Thanks,

Jonathan
> - Lars
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

