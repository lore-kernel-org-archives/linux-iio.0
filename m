Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbcIZH7b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2016 03:59:31 -0400
Date: Mon, 26 Sep 2016 09:59:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        jic23@kernel.org
Subject: Re: [PATCH v2 1/2] include: linux: iio: add IIO_ATTR_{RO, WO, RW}
 and IIO_DEVICE_ATTR_{RO, WO, RW} macros
Message-ID: <20160926075935.GA25938@kroah.com>
References: <20160925175852.GB13088@kroah.com>
 <1474831675-4201-1-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474831675-4201-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 25, 2016 at 03:27:54PM -0400, Brian Masney wrote:
> Add new macros: IIO_ATTR_RO, IIO_ATTR_WO, IIO_ATTR_RW,
> IIO_DEVICE_ATTR_RO, IIO_DEVICE_ATTR_WO and IIO_DEVICE_ATTR_RW to reduce
> the amount of boiler plate code that is needed for creating new
> attributes. This mimics the *_RO, *_WO, and *_RW macros that are found
> in include/linux/device.h and include/linux/sysfs.h.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  include/linux/iio/sysfs.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
