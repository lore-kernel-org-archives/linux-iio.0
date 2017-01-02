Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:45720 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932690AbdABSmw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 13:42:52 -0500
Subject: Re: [PATCH v3 1/2] staging: iio: ad7606: replace
 range/range_available with corresponding scale
To: Jonathan Cameron <jic23@kernel.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <cover.1481424136.git.eraretuya@gmail.com>
 <1165e7a84c82705ea10acecd712dec66fbbbc72f.1481424136.git.eraretuya@gmail.com>
 <0f9108e2-35c3-ab0c-4ce0-242bdaba06c9@kernel.org>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, daniel.baluta@gmail.com,
        amsfield22@gmail.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <708bad71-5496-d14f-caba-0df802582c88@metafoo.de>
Date: Mon, 2 Jan 2017 19:42:47 +0100
MIME-Version: 1.0
In-Reply-To: <0f9108e2-35c3-ab0c-4ce0-242bdaba06c9@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/30/2016 08:59 PM, Jonathan Cameron wrote:
> On 11/12/16 02:47, Eva Rachel Retuya wrote:
>> Eliminate the non-standard attributes in_voltage_range and
>> in_voltage_range_available. Implement in_voltage_scale_available in place
>> of these attributes and update the SCALE accordingly. The array
>> scale_avail is introduced to hold the available scale values.
>>
>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Looks good to me.
> 
> Lars, if you have a minute to look over this as well that would
> be great.

I think this is OK as is, since it is an improvement over the current
situation. But there is still the open issue that we don't know the scale
setting if pin is hardwired. I'd like to see that addressed before the
driver is moved out of staging. Similar for the oversampling ratio.

Consider this Acked-by: Lars-Peter Clausen <lars@metafoo.de>

