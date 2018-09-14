Return-Path: <SRS0=uYLp=L4=az8.co=afonsobordado@kernel.org>
Message-ID: <2cd9b1674ae88f153a5afe65c151cabf308e4fe7.camel@az8.co>
Subject: Re: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
From: Afonso Bordado <afonsobordado@az8.co>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
  devicetree@vger.kernel.org
Date: Fri, 14 Sep 2018 16:26:44 +0100
In-Reply-To: <20180912182350.GA13032@himanshu-Vostro-3559>
References: <20180911150011.31964-4-afonsobordado@az8.co>
	 <201809121715.5Babt1QC%fengguang.wu@intel.com>
	 <20180912182350.GA13032@himanshu-Vostro-3559>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi,

Thanks for your help with this.

> And I suspect it may be originating from your code snippet:
> 
> #define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500U >>
> (scale)))
> 
> and looking at the implementation:
> 
> include/linux/iio/iio.h
> /**
>  * IIO_DEGREE_TO_RAD() - Convert degree to rad
>  * @deg: A value in degree
>  *
>  * Returns the given value converted from degree to rad
>  */
> #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> 18000000ULL)
> 
> This '/' operator might be the culprit!
> 
> Just for checking that the error, remove the macro declaration
> `FXAS21002C_SCALE`
> plus its usage and re-cross compile using `make ARCH=i386`.
> 
> In my case I used the `div64_s64` function handles builds for both
> 32/64
> arch accordingly.

Yes, this is indeed the culprit. If `div64_s64` works the same way, I
wonder if the best option is to change the macro definition.

I can provide a patch for this along with changing the rest of the
definitions. However i would like some confirmation before starting
this.
