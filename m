Return-Path: <svarbanov@mm-sol.com>
Message-ID: <5416F4B1.2020509@mm-sol.com>
Date: Mon, 15 Sep 2014 17:16:17 +0300
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Pawel Moll <pawel.moll@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Doug Anderson <dianders@chromium.org>,
 Fugang Duan <B38611@freescale.com>,
 Johannes Thumshirn <johannes.thumshirn@men.de>,
 Jean Delvare <jdelvare@suse.de>,
 Philippe Reynes <tremyfr@yahoo.fr>, Lee Jones <lee.jones@linaro.org>,
 Josh Cartwright <joshc@codeaurora.org>,
 Stephen Boyd <sboyd@codeaurora.org>,
 David Collins <collinsd@codeaurora.org>,
 "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v2 1/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
References: <1410448403-19402-1-git-send-email-svarbanov@mm-sol.com> <1410448403-19402-2-git-send-email-svarbanov@mm-sol.com> <54138151.8010902@gmx.de>
In-Reply-To: <54138151.8010902@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Thanks for the comments!

On 09/13/2014 02:27 AM, Hartmut Knaack wrote:
> Stanimir Varbanov schrieb, Am 11.09.2014 17:13:
>> The voltage ADC is peripheral of Qualcomm SPMI PMIC chips. It has
>> 15bits resolution and register space inside PMIC accessible across
>> SPMI bus.
>>
>> The vadc driver registers itself through IIO interface.
>>
> Looks already pretty good. Things you should consider in regard of common coding style are to use the variable name ret instead of rc, since it is used in almost all adc drivers and thus makes reviewing a bit easier. Besides that, you seem to use unsigned as well as unsigned int, so to be consistent, please stick to one of them. Other comments in line.

OK, I will take into account your comments.

<snip>


-- 
regards,
Stan
