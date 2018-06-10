Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753624AbeFJNo6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jun 2018 09:44:58 -0400
Date: Sun, 10 Jun 2018 14:44:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: allow infinite looping
Message-ID: <20180610144453.07310b29@archlinux>
In-Reply-To: <6cf189db-adba-a731-f0cf-523e1d2970d7@xevo.com>
References: <20180607083110.gjfmdfuzw2my6sl5@kili.mountain>
        <6cf189db-adba-a731-f0cf-523e1d2970d7@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 7 Jun 2018 09:31:06 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> On 06/07/2018 01:31 AM, Dan Carpenter wrote:
> > I think the num_loops variable was intended to be signed so that we
> > could set it to -1 and it would loop forever.  Right now it just loops
> > for a very long time.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> > index 3040830d7797..84545666a09c 100644
> > --- a/tools/iio/iio_generic_buffer.c
> > +++ b/tools/iio/iio_generic_buffer.c
> > @@ -330,7 +330,7 @@ static const struct option longopts[] = {
> >   
> >   int main(int argc, char **argv)
> >   {
> > -	unsigned long long num_loops = 2;
> > +	long long num_loops = 2;
> >   	unsigned long timedelay = 1000000;
> >   	unsigned long buf_len = 128;
> >     
> 
> Good catch, thanks.
> 
> Reviewed-by: Martin Kelly <mkelly@xevo.com>
Applied.  I'm not going to rush this one as that is a very
long time so we are unlikely to get lots of problems with it ;)
Will wait for the next cycle.

Thanks,

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

