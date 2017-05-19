Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755621AbdESIUv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 04:20:51 -0400
Date: Fri, 19 May 2017 10:20:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: surenderpolsani@gmail.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregor.boirie@parrot.com,
        devel@driverdev.osuosl.org, eraretuya@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        maitysanchayan@gmail.com, singhalsimran0@gmail.com
Subject: Re: [PATCH v2] staging: iio: light: Replace symbolic permissions as
 per coding style
Message-ID: <20170519082041.GA18353@kroah.com>
References: <20170518090603.GA27644@kroah.com>
 <1495181575-30604-1-git-send-email-surenderpolsani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495181575-30604-1-git-send-email-surenderpolsani@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 19, 2017 at 01:42:55PM +0530, surenderpolsani@gmail.com wrote:
> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> -		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
> +static DEVICE_ATTR_RW(tsl2x7x_power_state);

You do realize you just renamed the sysfs file, changing the user/kernel
api?  That's generally not a good thing to ever do :(

thanks,

greg k-h
