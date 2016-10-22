Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53737 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964841AbcJVRZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:25:54 -0400
Subject: Re: [PATCH 3/7] iio: light: tsl2583: use DEVICE_ATTR_{RO, RW, WO}
 macros
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Brian Masney <masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-3-git-send-email-masneyb@onstation.org>
 <20161019112626.GI4469@mwanda> <20161019130830.GD6741@basecamp.onstation.org>
 <20161019131142.GG4418@mwanda>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5eb4cd2f-0e44-475c-cdaf-62f5d16b9f27@kernel.org>
Date: Sat, 22 Oct 2016 18:25:51 +0100
MIME-Version: 1.0
In-Reply-To: <20161019131142.GG4418@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 14:11, Dan Carpenter wrote:
> On Wed, Oct 19, 2016 at 09:08:30AM -0400, Brian Masney wrote:
>> On Wed, Oct 19, 2016 at 02:26:27PM +0300, Dan Carpenter wrote:
>>> What does illuminance0_ mean?  Can we remove that?
>>
>> I left the names of the existing sysfs attributes intact to not break
>> any existing users of the driver. I'm not sure why the original author
>> named it that way.
> 
> Ah...  Then I defer to your judgement.
Will normally be constructed as this via the info_mask stuff.
Needed to ensure it's obvious which channel we are referring to in
multichannel devices.  Convention usually means we use this when
something is very channel specific even if it's the only channel.
(feels odd otherwise ;)

Looks ugly here because of the rather contrived nature of the
macros.  I'm not keen on that side of them, but then we should
hardly ever need to use them anyway so I'm not that bothered!

Jonathan
> 
> regards,
> dan carpenter
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

