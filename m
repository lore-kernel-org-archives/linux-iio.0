Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53760 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964922AbcJVR35 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:29:57 -0400
Subject: Re: [PATCH 6/7] iio: light: tsl2583: add locking to sysfs *_store()
 functions
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Brian Masney <masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-6-git-send-email-masneyb@onstation.org>
 <20161019113345.GJ4469@mwanda> <20161019113731.GF4418@mwanda>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f6a017a4-0fd6-9706-472b-7174a6bd4769@kernel.org>
Date: Sat, 22 Oct 2016 18:29:55 +0100
MIME-Version: 1.0
In-Reply-To: <20161019113731.GF4418@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 12:37, Dan Carpenter wrote:
> I appologize for laughing, but I am still secretly amused in my heart.
> 
> regards,
> dan carpenter
> 
Fewer beers or less caffeine for Dan!

Key take away here is keep things simple.  The gotos in my mind
would actually have made sense, but I wouldn't do the refactoring until
you need it. i.e. when you introduce the locking in this patch.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

