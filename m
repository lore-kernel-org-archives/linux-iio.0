Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57694 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcACSAk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jan 2016 13:00:40 -0500
Subject: Re: [PATCH v2] iio: health: max30100: add config for LED current
To: Rob Herring <robh@kernel.org>, Matt Ranostay <mranostay@gmail.com>
References: <1451454288-9945-1-git-send-email-mranostay@gmail.com>
 <20151231221731.GA4445@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568961C7.1060503@kernel.org>
Date: Sun, 3 Jan 2016 18:00:39 +0000
MIME-Version: 1.0
In-Reply-To: <20151231221731.GA4445@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/12/15 22:17, Rob Herring wrote:
> On Tue, Dec 29, 2015 at 09:44:48PM -0800, Matt Ranostay wrote:
>> Allow the current for both RED and IR LEDs to be set via an device tree
>> property setting.
>>
>> This is an optional setting that is useful for applications that have a
>> known glass attenuation factor.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>> Changes from v2:
>> * change to use microamp property name from LED class
>> * updated documentation for new format
>> * added allowed current index map
>>
>> .../devicetree/bindings/iio/health/max30100.txt    |  8 +++
>>  drivers/iio/health/max30100.c                      | 81 ++++++++++++++++++++--
>>  2 files changed, 83 insertions(+), 6 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>
Looks good to me as well. Applied to the togreg branch of iio.git - initially
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

