Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.245]:17609 "EHLO
	DVREDG01.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751995Ab3JHDpp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 23:45:45 -0400
Message-ID: <52537FA3.10205@atmel.com>
Date: Tue, 8 Oct 2013 11:44:35 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <thomas.petazzoni@free-electrons.com>,
	<mark.rutland@arm.com>, <b.brezillon@overkiz.com>
Subject: Re: [PATCH v3 4/6] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com> <1377602932-1899-5-git-send-email-josh.wu@atmel.com> <20130828090354.GP2695@lukather> <521FB660.8010607@kernel.org> <524A96C8.7010707@kernel.org>
In-Reply-To: <524A96C8.7010707@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi, Jonathan

On 10/1/2013 5:32 PM, Jonathan Cameron wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 08/29/13 22:00, Jonathan Cameron wrote:
>> On 08/28/13 10:03, Maxime Ripard wrote:
>>> Hi Josh,
>>>
>>> On Tue, Aug 27, 2013 at 07:28:50PM +0800, Josh Wu wrote:
>>>> Since in at91sam9x5, sama5d3x chip. the start up time calucation is changed. This patch can choose different
>>>> start up time calculation formula for different chips.
>>>>
>>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>
>> Unfortunately this one has a dependency on the fix patch which is going in through my fixes branch so will have to
>> wait until that hits my upstream.
>>
>> I'd like 5 and 6 to sit a while longer anyway (and 6 needs Dmitry's sign off before I take that.)
>>
> Hi All,
>
> This patch no longer applies unfortunately. Josh, could you bring
> it up to date and repost the last 3 patches of this series?

Sorry for the later reply since I just come back from the holiday.
I will send the last 3 patches of this series (include this one) base on 
the mainline Linux. Thanks.

Best Regards,
Josh Wu

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.21 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iQIcBAEBAgAGBQJSSpbIAAoJEFSFNJnE9BaIi48QALwC0aVUQNU94RpUBRBqFVkF
> H8AB2pLBLYV4JlLD1kg9/ksltZh9+xegd/mM/C/lqZoHaokbSSF0bcAPSV2E3lXN
> MJ3sRx0ubmGAMNWOYI22pqD1BQwEWMdjmS/BaZ2FxkOdJyIV/jkR8NpA3BrvL7e2
> iOv9k7nBkOI1B//0K/xr4B0MWotnbmq45KeHTR1VnItqGWHDG7gyB+sbnymyf53M
> XY99HUpkLggBJrbp05PYmp9RTvyV7NYlMvgMtwUWcM6VaA0YrSRR349P+UsIcmwV
> 60yXRDRZCM5Vu3HDAVnbGDtumGjSFYsXXVkJQoN8izCBn0ZsbdSzc4bJyGzn90WK
> vpt5rpd4k+ne/TTuJSiIiz8g/7aZvlWWSQ17j2Qb+IOfh2yROHuA+yyikfFV8N4e
> 8jkd5HSMMRoL1Bv1vsf8eOJVlIMTOkG/2Wa7rXJOiWwzmc09Fxp13SoOIOxEMqJY
> lCj8In1fYLryMBCjxR2C/ysnullAbTwBv9HtudPm3Lu80eR8GL7lB4VrrhJyHILP
> ROvJE4ETYpYQTxQZMJKgVAQBFUAhBmckdc1A/SXMcDJgZKraP9aFvJPYbFR4OlFz
> UfjWWS6TzHFgFe2r804DzT+A7fpdZNFrbxyM40ttg7kJ81DgT9aQncEM96dEmiWh
> nXz0iA/maOXKkqJluLWl
> =HbYR
> -----END PGP SIGNATURE-----

