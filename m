Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10171 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbcDPPyQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 11:54:16 -0400
Message-ID: <57125D7B.2060200@nvidia.com>
Date: Sat, 16 Apr 2016 21:12:51 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>
CC: Jonathan Corbet <corbet@lwn.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	<linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: core: Add devm_ APIs for iio_channel_{get,release}
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com> <CAEnQRZBtqDQjydDKywYy9oLecFtjntfWhgOtd2xekVyFrYkH3w@mail.gmail.com> <57052432.8070700@nvidia.com> <570A5DB3.3080805@kernel.org> <570A8ECE.8030007@nvidia.com> <57123D37.7020601@kernel.org>
In-Reply-To: <57123D37.7020601@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Saturday 16 April 2016 06:55 PM, Jonathan Cameron wrote:
> On 10/04/16 18:35, Laxman Dewangan wrote:
>>
>> Yaah, possibly race for very small time possible.
>>
>> The limitation of devm_ api usage is that, we can keep using this
>> till we have devm_ api continuous and if some resource are not there
>> for devm_ then we can not use further. Possibly, I need to wait for
>> the devm_iio_channel_get() to merge and available for all subsystem
>> to use (next release) and then only I can use
>> devm_thermal_zone_of_sensor_register().
>>
> The alternative would be to merge this devm_ support as a prerequisite for your thermal
> patches and have it go through that tree.  As it's self contained I have
> no particular problem with that if you'd prefer to do it that way.
>
> Otherwise, you will need to do as you say above (not use
> devm_thermal_zone_of_sensor_register) to make sure it isn't broken in the meantime.
>
>

I have recycled patch of thermal driver to not use devm_ for sensor 
registration.

I will post another patch in future once these changes will be available 
for all, most probably next release.

I think there is no further comment now on the series so you can 
consider for next step.

Thanks,
Laxman

