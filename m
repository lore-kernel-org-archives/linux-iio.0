Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <20150719203343.GF5371@mwanda>
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <201507181738.21236.marex@denx.de> <55AB71B9.8070307@kernel.org> <20150719203343.GF5371@mwanda>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH V2 0/6] iio: mxs-lradc: Clean up and add datasheet names
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sun, 19 Jul 2015 22:08:32 +0100
To: Dan Carpenter <dan.carpenter@oracle.com>,Jonathan Cameron <jic23@kernel.org>
CC: Marek Vasut <marex@denx.de>,Stefan Wahren <stefan.wahren@i2se.com>,Fabio Estevam <fabio.estevam@freescale.com>,devel@driverdev.osuosl.org,Lars-Peter Clausen <lars@metafoo.de>,linux-iio@vger.kernel.org,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,Peter Meerwald <pmeerw@pmeerw.net>,Hartmut Knaack <knaack.h@gmx.de>
Message-ID: <23874360-AA01-4BBA-BEEC-2FA699399517@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 19 July 2015 21:33:43 BST, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>On Sun, Jul 19, 2015 at 10:45:29AM +0100, Jonathan Cameron wrote:
>> Thanks for looking through these. 
>> 
>> Just to let you know, there is currently a rather extended discussion
>going
>> on (as part of a suggested topic for the kernel summit) about when
>reviewed-by
>> tags are appropriate.
>> 
>> The general feeling is they must in someway indicate some substantial
>work.  Here
>> as a result I'd say it was appropriate for patch 6 whereas an
>Acked-by 
>> would be more appropriate for the cleanups (where there is nothing
>'interesting').
>> I've left these as reviewed by for this set though!
>> 
>> Note to all reviewers I may also start added reviewed by tags that
>you haven't sent if
>> I happen to feel you made a big contribution to review of a patch,
>but perhaps haven't
>> revisited later versions.  I'll probably send out an email about this
>outside
>> of this thread at some point to get possible wider circulation.
>> 
>
>I didn't necessarily read the thread that way, but the thread was
>long...  I think of Acked-by by as "I approve." which is different from
>I reviewed this carefully.  I seldom Ack anything since I'm not an
>official maintainer of anything so no one cares if I approve or not.
>Sometimes I really really approve something so I will Ack it even
>though
>maybe no one cares.
>
>I don't like the idea of someone adding my Reviewed-by tag because
>that's a quite serious tag for me and if it has bugs then I will feel
>responsible.
That is fair enough. Maybe I will just need to pester people more about taking a final
 look and giving tags if they want to or actively stating they don't mind not tagging a patch.

J
>
>regards,
>dan carpenter
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
