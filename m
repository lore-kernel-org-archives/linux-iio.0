Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:60553 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbaFYFEY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jun 2014 01:04:24 -0400
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Wmi73S4c5TPUqnNyycQ5xX5SbYy_ES-cbbJF2Hr0tqvQ@mail.gmail.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
 <1403612356-23685-5-git-send-email-ch.naveen@samsung.com> <CAD=FV=Wmi73S4c5TPUqnNyycQ5xX5SbYy_ES-cbbJF2Hr0tqvQ@mail.gmail.com>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Wed, 25 Jun 2014 10:34:03 +0530
Message-ID: <CAHfPSqAAWFtCQQrKBhLFuE2OuO_fwmUOhcOX9zKk8eMRMNSVvg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: DTS: Add NTC thermistor nodes as child nodes to ADC
To: Doug Anderson <dianders@chromium.org>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"cpgs ." <cpgs@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Tushar Behera <tushar.b@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Doug,

On 25 June 2014 03:24, Doug Anderson <dianders@chromium.org> wrote:
> Naveen,
>
> On Tue, Jun 24, 2014 at 5:19 AM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
>> Exynos5420 based Peach PIT and Exynos5800 based PI boards have
>> 4 NTC thermistors to measure temperatures at various points on the
>> board.
>>
>> IIO based ADC becomes the parent and NTC thermistors are the childs,
>> via the HWMON interface.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Doug Anderson <dianders@chromium.org>
>> ---
>> This patch needs
>> 1. MAX77802 PMIC device tree nodes (for ldo9)
>>    https://www.mail-archive.com/devicetree@vger.kernel.org/msg31430.html
>> 2. Uses the DT documentation for NTC thermistors updated with vendor-prefix
>>
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   32 ++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>
> * You forgot: status="okay" for the ADC.  One might question how this
> patch was tested.

Will correct it.

>
> * Please also include this change for pi.

MAX77802 device node was not added for Peach_PI (exynos5800-peach-pi.dts).
I guess, Javier have a plan to send.

I will edit the commit message to remove Peach_PI for now.

Also, we have few similar nodes on Peach PI  and Peach PIT.
Any plans or discussion on merging the common nodes ?

>
> * We just got through the painful process of sorting this .dts file.
> Please sort "&adc" alphabetically.  Kukjin: please confirm that you
> will keep an eye on patches and make sure that they are sorted OK.
>
>
> Other than those problems this seems to work fine to me.
>
> -Doug

Thanks for the Review.


-- 
Shine bright,
(: Nav :)
