Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:49329 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938647AbcJSOUS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 10:20:18 -0400
Date: Wed, 19 Oct 2016 16:11:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 3/7] iio: light: tsl2583: use DEVICE_ATTR_{RO, RW, WO}
 macros
Message-ID: <20161019131142.GG4418@mwanda>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-3-git-send-email-masneyb@onstation.org>
 <20161019112626.GI4469@mwanda>
 <20161019130830.GD6741@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161019130830.GD6741@basecamp.onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 19, 2016 at 09:08:30AM -0400, Brian Masney wrote:
> On Wed, Oct 19, 2016 at 02:26:27PM +0300, Dan Carpenter wrote:
> > What does illuminance0_ mean?  Can we remove that?
> 
> I left the names of the existing sysfs attributes intact to not break
> any existing users of the driver. I'm not sure why the original author
> named it that way.

Ah...  Then I defer to your judgement.

regards,
dan carpenter

