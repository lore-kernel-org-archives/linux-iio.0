Return-Path: <SRS0=sxJY=FG=gmail.com=himanshujha199640@kernel.org>
Date: Mon, 12 Feb 2018 20:05:22 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: 21cnbao@gmail.com, jic23@kernel.org, devel@driverdev.osuosl.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212143522.GA12142@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180212125312.cjo76spuu6agjawc@mwanda>
List-ID: <linux-iio@vger.kernel.org>

Hi Dan,

On Mon, Feb 12, 2018 at 03:53:12PM +0300, Dan Carpenter wrote:
> On Mon, Feb 12, 2018 at 05:24:57PM +0530, Himanshu Jha wrote:
> > Remove some unnecessary comments by giving appropriate name to macros.
> > Therefore, add _REG suffix for control registers. Also, align function
> > arguments to match open parentheses using tabs.
> > Group the control register and register field macros together.
> > 
> > Blank line before some returns improves code readability.
> > 
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> The most obvious response is that this needs to be broken up into
> multiple patches.
> 
> I think I liked almost all the comments...

Please note that all the changes are suggested by Joanathan in his TODO
https://marc.info/?l=linux-iio&m=151775804702998&w=2
I think it far more commenting as compared to other drivers in the
mainline IIO drivers. I grouped all the relevant control registers
together at one place with suitable comment.
For eg:

+/* Data Output Register Definitions */

The macro names are identical to the names in the datasheet if you can
look and one could easily refer to the datasheet easily. Also, I
grouped the control registers and their fields together make it more readable.
For eg:

+#define ADIS16201_MSC_CTRL_REG                 0x34
+#define ADIS16201_MSC_CTRL_SELF_TEST_EN                BIT(8)
+#define ADIS16201_MSC_CTRL_DATA_RDY_EN         BIT(2)


> > -/* Output, power supply */
> > -#define ADIS16201_SUPPLY_OUT     0x02
> > +#define ADIS16201_SUPPLY_OUT_REG		0x02
> 
> To me it seems useful to know that we're talking about the power supply.

For that purpose I already grouped data output register definitions.

> Adding _REG to the name seems not terribly useful and it makes the name
> longer so we're going to run into the 80 character limit.  I just
> checked and this patch does add some checkpatch warnings.

_REG prefix is used to differentiate between registers addresses and the
fields in the register as pointed in the above MSC_CTRL_REG and
MSC_CTRL_SELF_TEST_EN.

Yes by doing this it triggered 2 I think 80 character warning. For eg:

	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),

But you know with 81 characters so I neglected it because it looked more
readable without breaking into lines IMHO.

> But aligning the arguments is fine, deleting unused macros is fine,
> adding blank lines is fine.
> 
> >  static int adis16201_probe(struct spi_device *spi)
> >  {
> > -	int ret;
> > -	struct adis *st;
> >  	struct iio_dev *indio_dev;
> > +	struct adis *st;
> > +	int ret;
> 
> Making this reverse Christmas tree is fine.  But these things should all
> be done in separate patches.

I am sometimes confused in dividing the patches. As per your advice I
should make separate patch for :

1. remove unnecessary comments.
2. add suitable suffix.
3. add tabs instead of space.
4. reverse christmas tree.

But these should be done when we have *more* instances.

For eg: 
I added a tab space in function static int adis16201_read_raw() argument
to match open parentheses in this patch. But I also added tabs while
removing and adding suitable suffix to the macros. So, should it also be
done in a separate patch ? Since there was only one instance of adding tabs
therefore I did it here without framing another patch for that purpose
while saving my time to plan 'what to include/exclude in the patch ?'

Also, given the above queries I was clueless as what to do first! Since
sometimes it happens that the patch series doesn't apply cleanly because
of incorrect ordering for framing the patches.

Thanks for taking your time to review the patch series.

-- 
Thanks
Himanshu Jha
