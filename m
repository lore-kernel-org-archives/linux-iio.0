Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20163 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbcLEU4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 15:56:03 -0500
Date: Mon, 5 Dec 2016 23:55:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH v3 20/28] staging: iio: tsl2583: don't assume an unsigned
 int is 32 bits
Message-ID: <20161205205504.GE31243@mwanda>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-21-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478769964-7065-21-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 10, 2016 at 04:25:56AM -0500, Brian Masney wrote:
> in_illuminance_lux_table_store assumes that an unsigned int is 32 bits.

It's a totally safe assumption.  The only problem is that it's less
readable than sizeof().

regards,
dan carpenter

