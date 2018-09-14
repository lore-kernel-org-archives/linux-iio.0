Return-Path: <SRS0=SnZD=L4=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 14 Sep 2018 23:00:58 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Afonso Bordado <afonsobordado@az8.co>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
Message-ID: <20180914173058.GA8405@himanshu-Vostro-3559>
References: <20180911150011.31964-4-afonsobordado@az8.co>
 <201809121715.5Babt1QC%fengguang.wu@intel.com>
 <20180912182350.GA13032@himanshu-Vostro-3559>
 <2cd9b1674ae88f153a5afe65c151cabf308e4fe7.camel@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2cd9b1674ae88f153a5afe65c151cabf308e4fe7.camel@az8.co>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 14, 2018 at 04:26:44PM +0100, Afonso Bordado wrote:
> Hi,
> 
> Thanks for your help with this.
> 
> > And I suspect it may be originating from your code snippet:
> > 
> > #define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500U >>
> > (scale)))
> > 
> > and looking at the implementation:
> > 
> > include/linux/iio/iio.h
> > /**
> >  * IIO_DEGREE_TO_RAD() - Convert degree to rad
> >  * @deg: A value in degree
> >  *
> >  * Returns the given value converted from degree to rad
> >  */
> > #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> > 18000000ULL)
> > 
> > This '/' operator might be the culprit!
> > 
> > Just for checking that the error, remove the macro declaration
> > `FXAS21002C_SCALE`
> > plus its usage and re-cross compile using `make ARCH=i386`.
> > 
> > In my case I used the `div64_s64` function handles builds for both
> > 32/64
> > arch accordingly.
> 
> Yes, this is indeed the culprit. If `div64_s64` works the same way, I
> wonder if the best option is to change the macro definition.

"....works the same way" ?

Let us assume that the problem arises due to the 64 bit division, in
which gcc places the __divdi3() runtime function to promote the
"freestanding" environment implementation. And then linking fails
due to unavailability of definitions/declarations of the aforementioned
function.

With `div64_s64` usgae the linker binds the definition present at lib/div64.c
and the build completes successfully whether building for 32/64 bit
environment.

But then why didn't this error showed up in the past, in the rest 
of the drivers ?

I see its wide usage in IIO without bug reports:

himanshu@himanshu-Vostro-3559:~/linux-next$ git grep -w "IIO_DEGREE_TO_RAD" drivers/iio/ | wc -l
34

And that concludes, that there is some problem within your code!

In the meantime, you can try to look the disassembly of the function
where this macro is actually used and search for __divdi3/__udivdi3
function referenced in the plt.

I might be wrong though...

Wait a while for the experts to join in!

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
