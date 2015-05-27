Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35599 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbE0WMs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2015 18:12:48 -0400
Received: by labko7 with SMTP id ko7so14368017lab.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2015 15:12:46 -0700 (PDT)
Date: Thu, 28 May 2015 01:12:40 +0300
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	driverdev-devel@linuxdriverproject.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio_simple_dummy: zero check param
Message-ID: <20150527221240.GA23081@gmail.com>
References: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
 <1432678798-22903-2-git-send-email-rodriguez.twister@gmail.com>
 <20150527082507.GO11588@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150527082507.GO11588@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 27, 2015 at 11:25:07AM +0300, Dan Carpenter wrote:
> On Wed, May 27, 2015 at 01:19:58AM +0300, Vladimirs Ambrosovs wrote:
> > Check for zero was added to the module parameter "instances" to
> > avoid the allocation of array of zero values. Although it is a valid call,
> > we don't want to allocate ZERO_SIZE_PTR, so need to disallow this case.
> > The type of variables which are compared to "instances" were also changed
> > to unsigned int so that no compiler complaints occur.
> 
> Which compiler is that?
> 
> You should get a different compiler if you compiler complains about
> stupid stuff like that.  Making everything unsigned int is a common
> cause of problems.  I fixed or reported several of those bugs yesterday.
> 
> "instances" should be unsigned int, though, you're correct about that.
> 
Mine is fine - not complaining ;). 

Got your point, although, in some cases, I think, these warnings not a
stupid stuff, and could get some junior out of trouble.

But anyway, will keep in mind to stay away from unsigned ints. 
> > 
> > Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
> > ---
> >  drivers/staging/iio/iio_simple_dummy.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> > index 88fbb4f..2744a1b 100644
> > --- a/drivers/staging/iio/iio_simple_dummy.c
> > +++ b/drivers/staging/iio/iio_simple_dummy.c
> > @@ -30,7 +30,7 @@
> >   * dummy devices are registered.
> >   */
> >  static unsigned instances = 1;
> > -module_param(instances, int, 0);
> > +module_param(instances, uint, 0);
> >  
> >  /* Pointer array used to fake bus elements */
> >  static struct iio_dev **iio_dummy_devs;
> > @@ -706,9 +706,10 @@ static void iio_dummy_remove(int index)
> >   */
> >  static __init int iio_dummy_init(void)
> >  {
> > -	int i, ret;
> > +	unsigned int i;
> > +	int ret;
> 
> No.
> 
> >  
> > -	if (instances > 10) {
> > +	if (instances == 0 || instances > 10) {
> >  		instances = 1;
> >  		return -EINVAL;
> 
> Allocating zero size arrays is a totally valid thing the kernel and it
> doesn't cause a problem unless there are other existing serious bugs in
> the code.  In this case instances == 0 is fine.
> 
Sorry, got a bit confused - is it fine to be in the code, or the 0
value is valid, and shouldn't be checked for? The idea behind this
change was not the allocation of zero size array, but the
use of the module with 0 instances. However, maybe that actually
addresses some usecase, so probably would be better to leave it as it
was before.

> Setting "instances = 1" is bogus though.
> 
> >  	}
> > @@ -742,7 +743,7 @@ module_init(iio_dummy_init);
> >   */
> >  static __exit void iio_dummy_exit(void)
> >  {
> > -	int i;
> > +	unsigned int i;
> 
> No.
> 
> regards,
> dan carpenter
> 

Thanks for all the comments. Will send out the updated patches soon.

BR,
Vladimirs
