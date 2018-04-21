Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbeDUOkW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 10:40:22 -0400
Date: Sat, 21 Apr 2018 15:40:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>,
        <knaack.h@gmx.de>, <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
Message-ID: <20180421154013.3e9c3c3e@archlinux>
In-Reply-To: <20180418103948.00004b93@huawei.com>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
        <20180415160550.4705667e@archlinux>
        <CALfa3vFgh7jtb=B6doOu-y2Bm77wu4zVdLE1LuxbruTTKjLU=A@mail.gmail.com>
        <20180418103948.00004b93@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Apr 2018 10:39:48 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Apr 2018 11:47:05 -0300
> Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> 
> > On Sun, Apr 15, 2018 at 12:05 PM, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Fri, 13 Apr 2018 13:36:40 -0300
> > > Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> > >    
> > >> Also remove unnecessary parenthesis    
> > > I am probably missing something.  I'm not sure what you mean
> > > by fix bound checking?   There are superfluous brackets, but
> > > I don't see any functional change to indicate there was anything
> > > wrong with the original checks.
> > >    
> > 
> > Maybe I'm wrong but | is a bitwise operator while || is a logical one.
> > There are no functional changes as you said but, from K&R, "One must
> > distinguish the bitwise operators & and | from the logical operators
> > && and II, which imply left-to-right evaluation of a truth value. For
> > example, if x is 1 and y is 2, then x & y is zero while x && y is one"
> > so it'd be slightly faster if the first condition is true, and it
> > would be the "correct" operator to use in this case, even though it
> > doesn't affect the result.  
> Got you, I missed the operator change entirely. Doh.
> 
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> Jonathan
> 
> >   
> > >>
> > >> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> > >> ---
> > >>  drivers/staging/iio/cdc/ad7746.c | 4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > >> index 516aa93..d793785 100644
> > >> --- a/drivers/staging/iio/cdc/ad7746.c
> > >> +++ b/drivers/staging/iio/cdc/ad7746.c
> > >> @@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
> > >>               ret = 0;
> > >>               break;
> > >>       case IIO_CHAN_INFO_CALIBBIAS:
> > >> -             if ((val < 0) | (val > 0xFFFF)) {
> > >> +             if (val < 0 || val > 0xFFFF) {
> > >>                       ret = -EINVAL;
> > >>                       goto out;
> > >>               }
> > >> @@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
> > >>               ret = 0;
> > >>               break;
> > >>       case IIO_CHAN_INFO_OFFSET:
> > >> -             if ((val < 0) | (val > 43008000)) { /* 21pF */
> > >> +             if (val < 0 || val > 43008000) { /* 21pF */
> > >>                       ret = -EINVAL;
> > >>                       goto out;
> > >>               }    
> > >    
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

