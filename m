Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:35466 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942002AbcJSO1c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Oct 2016 10:27:32 -0400
Date: Wed, 19 Oct 2016 09:08:30 -0400
From: Brian Masney <masneyb@onstation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 3/7] iio: light: tsl2583: use DEVICE_ATTR_{RO, RW, WO}
 macros
Message-ID: <20161019130830.GD6741@basecamp.onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-3-git-send-email-masneyb@onstation.org>
 <20161019112626.GI4469@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161019112626.GI4469@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 19, 2016 at 02:26:27PM +0300, Dan Carpenter wrote:
> What does illuminance0_ mean?  Can we remove that?

I left the names of the existing sysfs attributes intact to not break
any existing users of the driver. I'm not sure why the original author
named it that way.

Brian

