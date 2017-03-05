Return-Path: <SRS0=bBBI=2O=gmail.com=amsfield22@kernel.org>
Date: Sun, 5 Mar 2017 10:58:29 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 0/2] staging: iio: accel: Group
 similar macros into enums
Message-ID: <20170305185828.GA3380@d830.WORKGROUP>
References: <cover.1488730643.git.narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1488730643.git.narcisaanamaria12@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 05, 2017 at 06:26:03PM +0200, Narcisa Ana Maria Vasile wrote:
> Group related macros into enums, for clarity.

Hi Narcisa,

Is this enum then used in a type declaration?

BTW - I can see Jonathan is following right along and sweeping these up,
but for future reference, this patch depended on a previous patch sent hours
earlier, that was not yet in staging-testing.  When this happens, one option
is to give a note below the --- (as you would for version comments) stating the
dependency.  This way someone reviewing the patch doesn't simply reject
it as not applying to my tree.

alisons

> Narcisa Ana Maria Vasile (2):
>   staging: iio: adis16209: Group similar macros into enums
>   staging: iio: adis16240: Group similar macros into enums
> 
>  drivers/staging/iio/accel/adis16209.c | 18 ++++++++++--------
>  drivers/staging/iio/accel/adis16240.c | 14 ++++++++------
>  2 files changed, 18 insertions(+), 14 deletions(-)
> 
> -- 
> 1.9.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1488730643.git.narcisaanamaria12%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
