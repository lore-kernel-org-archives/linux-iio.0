Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32881 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbbHGL2D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2015 07:28:03 -0400
Date: Fri, 7 Aug 2015 14:27:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: =?iso-8859-1?Q?ayb=FCke_=F6zdemir?= <aybuke.147@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: staging: iio: accel: Use __be16 instead of u16
Message-ID: <20150807112733.GI5096@mwanda>
References: <20150715193650.GA28245@mwanda>
 <CAEnQRZC6-4n7ZUi0PPiQ2bG-c1P3fADn6CmyYLmHa2NbWVeaJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZC6-4n7ZUi0PPiQ2bG-c1P3fADn6CmyYLmHa2NbWVeaJg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 07, 2015 at 01:59:40PM +0300, Daniel Baluta wrote:
> >    119          for (i = 0; i < num_read; i++)
> >    120                  *(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
> >                           ^^^^^^^^^^^^^^^
> >
> > We're writing beyond the end of the array here because of the pointer
> > math issue.  The fix is probably to say:
> >
> >                 for (i = 0; i < num_read / sizeof(u16); i++)
> >                         *(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
> >
> >    121
> >    122          if (copy_to_user(buf, rx, num_read))
> >    123                  ret = -EFAULT;
> 
> Looks good to me. Please send a formal patch.

It's weird that no one has noticed this bug in testing because we end
up corrupting memory every time this function is called.

regards,
dan carpenter

