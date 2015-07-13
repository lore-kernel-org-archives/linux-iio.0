Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58966 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbGMJX4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 05:23:56 -0400
In-Reply-To: <79826456.QduC5uXeBP@diego>
References: <8215730.uluDfnE1h7@diego> <55A1533A.2080507@kernel.org> <79826456.QduC5uXeBP@diego>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH RESEND] iio: adc: rockchip_saradc: add missing MODULE_* data
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 13 Jul 2015 10:23:49 +0100
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <9AE8F596-1594-4B92-B06E-C6F14527239D@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11 July 2015 19:59:31 BST, "Heiko Stübner" <heiko@sntech.de> wrote:
>Hi Jonathan,
>
>Am Samstag, 11. Juli 2015, 18:32:42 schrieb Jonathan Cameron:
>> On 08/07/15 15:17, Heiko Stuebner wrote:
>> > The module-data is currently missing. This includes the
>> > license-information
>> > which makes the driver taint the kernel and miss symbols when
>compiled as
>> > module.
>> > 
>> > Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> 
>> Sorry Heiko,
>> 
>> Not entirely sure why I haven't picked this up before.
>> 
>> Anyhow, now applied to the fixes-for-4.2 branch of iio.git
>> and marked for stable.  I need to catch up with a bit of a
>> backlog, but should get a pull request out to Greg sometime
>> early next week.
>
>really no problem. I track my patches and generally simply keep
>pestering 
>people for as long as it takes ;-)
>
Very sensible!
>Heiko

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
