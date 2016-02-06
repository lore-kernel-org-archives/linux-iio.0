Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41020 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcBFSMS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:12:18 -0500
Subject: Re: [PATCH v3] iio: adc: Add TI ADS1015 ADC driver support
To: Daniel Baluta <daniel.baluta@intel.com>,
	Michael Welling <mwelling@ieee.org>
References: <1454518796-10897-1-git-send-email-daniel.baluta@intel.com>
 <20160203181919.GD25464@deathstar>
 <CAEnQRZDOPYDVUUXBXc7OEmAo0QEryg0PvMLXUxA__Rxu8bS=0g@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	linux@roeck-us.net, eibach@gdsys.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B6377F.10807@kernel.org>
Date: Sat, 6 Feb 2016 18:12:15 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDOPYDVUUXBXc7OEmAo0QEryg0PvMLXUxA__Rxu8bS=0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/02/16 12:51, Daniel Baluta wrote:
>> Would it be more consistent to handle the mutex outside of the switch above similar
>> to how it is handled in ads1015_write_raw?
>>
>> Also the ads1015_set_power_state(data, false) is called either way so why not just
>> use one call?
>>
> 
> I don't have a strong preference for that. I think across IIO drivers
> we can find both coding practices.
Often we move it into the switch because in most driver some of the read_raw
elements don't need to query the hardware (scales are often fixed for example) so
we don't need to take the lock for them.  Here it makes sense to take the lock.

(Not that I care much either way!)
> 
> Indeed consistency with ads1015_write_raw is a good argument. Will fix it.
> 
> I will leave the code here for one more day and then send an updated version.
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

