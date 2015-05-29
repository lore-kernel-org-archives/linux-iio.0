Return-Path: <rodriguez.twister@gmail.com>
Date: Fri, 29 May 2015 22:38:50 +0300
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	driverdev-devel@linuxdriverproject.org, pmeerw@pmeerw.net,
	knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH 2/2] staging: iio_simple_dummy: zero check param
Message-ID: <20150529193850.GA23320@gmail.com>
References: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
 <1432678798-22903-2-git-send-email-rodriguez.twister@gmail.com>
 <20150527082507.GO11588@mwanda>
 <20150527221240.GA23081@gmail.com>
 <20150528065934.GU11588@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528065934.GU11588@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 28, 2015 at 09:59:34AM +0300, Dan Carpenter wrote:
> On Thu, May 28, 2015 at 01:12:40AM +0300, Vladimirs Ambrosovs wrote:
> > On Wed, May 27, 2015 at 11:25:07AM +0300, Dan Carpenter wrote:
> > > On Wed, May 27, 2015 at 01:19:58AM +0300, Vladimirs Ambrosovs wrote:
> > > > Check for zero was added to the module parameter "instances" to
> > > > avoid the allocation of array of zero values. Although it is a valid call,
> > > > we don't want to allocate ZERO_SIZE_PTR, so need to disallow this case.
> > > > The type of variables which are compared to "instances" were also changed
> > > > to unsigned int so that no compiler complaints occur.
> > > 
> > > Which compiler is that?
> > > 
> > > You should get a different compiler if you compiler complains about
> > > stupid stuff like that.  Making everything unsigned int is a common
> > > cause of problems.  I fixed or reported several of those bugs yesterday.
> > > 
> > > "instances" should be unsigned int, though, you're correct about that.
> > > 
> > Mine is fine - not complaining ;). 
> > 
> > Got your point, although, in some cases, I think, these warnings not a
> > stupid stuff, and could get some junior out of trouble.
> > 
> > But anyway, will keep in mind to stay away from unsigned ints. 
> 
> It's not a matter of staying away from unsigned ints, it's that some
> people make everything unsigned by default.  That causes problems for
> two reasons.  1) The kernel uses negative error codes.  2) int is the
> default datatype when you want a "number" in C.  If you want a special
> number then you make it unsigned int, u32, or unsigned long or whatever.
> All those types mean something.  An unsigned int and a u32 are the same
> to a computer but to a human they mean something different.  People who
> use complicated datatypes all the time instead of just plain old int are
> making the code complicated.
> 
> 
Thanks for the explanation.

> > > > 
> > > > Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
> > > > ---
> > > >  drivers/staging/iio/iio_simple_dummy.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> > > > index 88fbb4f..2744a1b 100644
> > > > --- a/drivers/staging/iio/iio_simple_dummy.c
> > > > +++ b/drivers/staging/iio/iio_simple_dummy.c
> > > > @@ -30,7 +30,7 @@
> > > >   * dummy devices are registered.
> > > >   */
> > > >  static unsigned instances = 1;
> > > > -module_param(instances, int, 0);
> > > > +module_param(instances, uint, 0);
> > > >  
> > > >  /* Pointer array used to fake bus elements */
> > > >  static struct iio_dev **iio_dummy_devs;
> > > > @@ -706,9 +706,10 @@ static void iio_dummy_remove(int index)
> > > >   */
> > > >  static __init int iio_dummy_init(void)
> > > >  {
> > > > -	int i, ret;
> > > > +	unsigned int i;
> > > > +	int ret;
> > > 
> > > No.
> > > 
> > > >  
> > > > -	if (instances > 10) {
> > > > +	if (instances == 0 || instances > 10) {
> > > >  		instances = 1;
> > > >  		return -EINVAL;
> > > 
> > > Allocating zero size arrays is a totally valid thing the kernel and it
> > > doesn't cause a problem unless there are other existing serious bugs in
> > > the code.  In this case instances == 0 is fine.
> > > 
> > Sorry, got a bit confused - is it fine to be in the code, or the 0
> > value is valid, and shouldn't be checked for? The idea behind this
> > change was not the allocation of zero size array, but the
> > use of the module with 0 instances.
> 
> The changelog specifically mentioned a ZERO_SIZE_ARRAY.  If you had
> said, "It doesn't make sense to load a module with 0 instances" then I
> would have allowed the patch.  I don't care if you make this change or
> not, but the changelog had wrong motivation.
> 
Fair enough.

> regards,
> dan carpenter

BR,
Vladimirs
