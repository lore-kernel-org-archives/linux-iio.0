Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39450 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941539AbdAGR51 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 12:57:27 -0500
Subject: Re: [PATCH v4] staging: iio: ad7606: replace range/range_available
 with corresponding scale
To: Lars-Peter Clausen <lars@metafoo.de>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <1483787423-7357-1-git-send-email-eraretuya@gmail.com>
 <3ebd18b1-f61a-ee99-f603-c24a419ea966@metafoo.de>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, daniel.baluta@gmail.com,
        amsfield22@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <97b8736f-7cfe-50d5-bdac-277c5e17805f@kernel.org>
Date: Sat, 7 Jan 2017 12:57:07 -0500
MIME-Version: 1.0
In-Reply-To: <3ebd18b1-f61a-ee99-f603-c24a419ea966@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/17 12:54, Lars-Peter Clausen wrote:
> On 01/07/2017 12:10 PM, Eva Rachel Retuya wrote:
>> Eliminate the non-standard attributes in_voltage_range and
>> in_voltage_range_available. Implement in_voltage_scale_available in place
>> of these attributes and update the SCALE accordingly. The array
>> scale_avail is introduced to hold the available scale values.
>>
>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied locally to my togreg branch. Will push out as testing when I get
some unfirewalled internet.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

