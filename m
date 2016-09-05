Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58057 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964883AbcIEUK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 16:10:28 -0400
Subject: Re: [PATCH v2 2/2] iio: devm_regulator_get_optional never returns
 NULL
To: Lars-Peter Clausen <lars@metafoo.de>, Crt Mori <cmo@melexis.com>,
        linux-iio@vger.kernel.org
References: <20160905091449.12297-1-cmo@melexis.com>
 <20160905091449.12297-2-cmo@melexis.com>
 <e7fbc8a9-3a97-5712-f7f3-6346137282eb@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Markus Pargmann <mpa@pengutronix.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <63e36d57-74ff-c7a2-092c-47614b9301f1@kernel.org>
Date: Mon, 5 Sep 2016 21:10:27 +0100
MIME-Version: 1.0
In-Reply-To: <e7fbc8a9-3a97-5712-f7f3-6346137282eb@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/16 11:33, Lars-Peter Clausen wrote:
> On 09/05/2016 11:14 AM, Crt Mori wrote:
>> This patch is inspired by a comment of Jonathan Cameron on patch of
>> Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio:
>> st_sensors: fetch and enable regulators unconditionally"). Because
>> changes made in this patch are actually reference generators they should
>> be using devm_regulator_get_optional, but if they do not explicitly set
>> the reference to NULL they should not be using IS_ERR_OR_NULL, but
>> simple IS_ERR check.
>>
>> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Crt Mori <cmo@melexis.com>
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

