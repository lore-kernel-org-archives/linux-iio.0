Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbdGOMvH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jul 2017 08:51:07 -0400
Date: Sat, 15 Jul 2017 13:51:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gaurav Gupta (gauragup)" <gauragup@cisco.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: core: Fix mapping of iio channels to entry numbers
Message-ID: <20170715135103.4b501824@kernel.org>
In-Reply-To: <39A26AA9-5143-454A-BF38-95D71BB9F757@cisco.com>
References: <20170627164601.GA30866@sjc-ads-988.cisco.com>
        <20170701184028.0a2f9511@kernel.org>
        <16e0d7e3-f381-12bb-b8fa-b96713105c1f@roeck-us.net>
        <39A26AA9-5143-454A-BF38-95D71BB9F757@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 14 Jul 2017 16:51:12 +0000
"Gaurav Gupta (gauragup)" <gauragup@cisco.com> wrote:

> Hi Jonathan,
> 
> Just wondering if you foresee any issues with this change or any further changes that need to happen as a side-effect of this?
This still makes me nervous so I'm going to take the cautious route of pushing it
out via the slow path of the next merge window.  If no one shouts for a month
or so after that, we can request a backport to stable.

So applied to the togreg branch of iio.git.

Jonathan
> 
> Thanks,
> Gaurav
> 
> On 7/1/17, 11:46 AM, "linux-iio-owner@vger.kernel.org on behalf of Guenter Roeck" <linux-iio-owner@vger.kernel.org on behalf of linux@roeck-us.net> wrote:
> 
>     On 07/01/2017 10:40 AM, Jonathan Cameron wrote:
>     > On Tue, 27 Jun 2017 09:46:01 -0700
>     > Gaurav Gupta <gauragup@cisco.com> wrote:
>     >   
>     >> When adding maps to the list, they were added using list_add, which adds
>     >> them in LIFO order. When parsing using iio_channel_get_all(), these
>     >> elements are hence returned in reverse order. As a result, the iio_hwmon
>     >> mapping maps the first entry to the last channel and so on.
>     >>
>     >> Signed-off-by: Gaurav Gupta <gauragup@cisco.com>  
>     > Gah.  This is one of those nasty cases where I clearly messed up a
>     > long time ago, but unfortunately it's become user space ABI.
>     > 
>     > So looking for general opinions on whether we can fix this one
>     > or not.  I can't immediately think of a clean way to tidy this up.
>     > 
>     > So do we think people will notice if we fix this?
>     >   
>     
>     I would just go for it.
>     
>     Guenter
>     
>     > Jonathan  
>     >> ---
>     >>   drivers/iio/inkern.c | 2 +-
>     >>   1 file changed, 1 insertion(+), 1 deletion(-)
>     >>
>     >> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>     >> index 7a13535..9b0715c 100644
>     >> --- a/drivers/iio/inkern.c
>     >> +++ b/drivers/iio/inkern.c
>     >> @@ -44,7 +44,7 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>     >>   		}
>     >>   		mapi->map = &maps[i];
>     >>   		mapi->indio_dev = indio_dev;
>     >> -		list_add(&mapi->l, &iio_map_list);
>     >> +		list_add_tail(&mapi->l, &iio_map_list);
>     >>   		i++;
>     >>   	}
>     >>   error_ret:  
>     > 
>     >   
>     
>     --
>     To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     
> 

