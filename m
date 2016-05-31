Return-Path: <luisbg@osg.samsung.com>
Message-ID: <574DF9C3.5040405@osg.samsung.com>
Date: Tue, 31 May 2016 21:53:23 +0100
From: Luis de Bethencourt <luisbg@osg.samsung.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
CC: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
 ciorneiioana@gmail.com, janani.rvchndrn@gmail.com, afd@ti.com,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: iio: accel: remove impossible condition
References: <1464724070-20123-1-git-send-email-luisbg@osg.samsung.com> <40EDFB63-D09B-4933-8935-9540119FC00C@kernel.org>
In-Reply-To: <40EDFB63-D09B-4933-8935-9540119FC00C@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 31/05/16 21:23, Jonathan Cameron wrote:
> 
> 
> On 31 May 2016 20:47:50 BST, Luis de Bethencourt <luisbg@osg.samsung.com> wrote:
>> val is set to the value of ret right after ret is checked. If ret is
>> not
>> zero it goes to error_ret. So only value ret can have is zero, which
>> makes
>> the switch (val & 0x03) only match the case 0x00. Removing the switch
>> and
>> since val is only used for this, removing val as well.
> There is clearly an issue here. However it looks like it is that if(ret) which is wrong.
> 
> The code as it stands clearly doesn't work as intended. Fixing the bug would be
> 
>  more useful than removing code that 'should' be accessible.
> 
> I happen to fire the relevant hardware up yesterday for the first time in a while so
> 
> can easily verify the operation of a fix if you want to take another look.
> 
> Jonathan

Jonathan and Andrew are right.

sca3000_read_ctrl_reg() returns a negative number on failure.

So line 597 should be: if (ret < 0)

If everything goes well in sca3000_read_ctrl_reg() it returns st->rx[0], which explains
the switch case.

I am going to send a new patch with this fix.

Thanks so much for the review and sorry for the initial confusion,
Luis
