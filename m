Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43583 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbaKEQGH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 11:06:07 -0500
Message-ID: <545A4AE8.6070402@kernel.org>
Date: Wed, 05 Nov 2014 16:06:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] iio: iadc: Qualcomm SPMI PMIC current ADC driver
References: <1413987213-22218-1-git-send-email-iivanov@mm-sol.com>	 <5453ED55.2000003@gmx.de> <alpine.DEB.2.02.1410312128100.18476@pmeerw.net> <1415004303.407.11.camel@mm-sol.com>
In-Reply-To: <1415004303.407.11.camel@mm-sol.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/14 08:45, Ivan T. Ivanov wrote:
> 
> On Fri, 2014-10-31 at 21:48 +0100, Peter Meerwald wrote:
>>> Ivan T. Ivanov schrieb am 22.10.2014 16:13:
>>>> The current ADC is peripheral of Qualcomm SPMI PMIC chips. It has
>>>> 16 bits resolution and register space inside PMIC accessible across
>>>> SPMI bus.
>>>>
>>>> The driver registers itself through IIO interface.
>>> Pretty much there, just one question I would like to double-check: The CPU of these chips is 
>> Little Endian, right?
>>> Annoyingly, you introduced a small typo in this revision, but that alone doesn't qualify for a 
>> new revision. A separate patch fixing it would probably be best. See inline.
>>
>> some minor comments below
> 
> Thanks, will fix them. IIO maintainers, what do you
> prefer, new version or fallow-up patch?
> 

Follow up please.
> Regards,
> Ivan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
