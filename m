Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdESHQK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 03:16:10 -0400
Date: Fri, 19 May 2017 09:15:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: surenderpolsani@gmail.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregor.boirie@parrot.com,
        singhalsimran0@gmail.com, maitysanchayan@gmail.com,
        eraretuya@gmail.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: light: Replace symbolic permissions as
 per coding style
Message-ID: <20170519071558.GA12545@kroah.com>
References: <20170518090603.GA27644@kroah.com>
 <1495177391-29670-1-git-send-email-surenderpolsani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495177391-29670-1-git-send-email-surenderpolsani@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 19, 2017 at 12:33:11PM +0530, surenderpolsani@gmail.com wrote:
> From: Surender Polsani <surenderpolsani@gmail.com>
> 
> Fixed the following checkpatch.pl warnings:
> octal permissions are more preferable than symbolic permissions
> 
> Replaced DEVICE_ATTR family macros with DEVICE_ATTR_RW family
> as suggested by Greg K-H. Changed attributes and function
> names where ever required to satisfy internal macro definitions
> like __ATTR__RW().

No you did not:

> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(power_state, 0644,
>  		tsl2x7x_power_state_show, tsl2x7x_power_state_store);

???

Wrong patch?

