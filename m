Return-Path: <SRS0=oxEW=JP=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 29 Jun 2018 11:05:09 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de,
	knaack.h@gmx.de, pmeerw@pmeerw.net, mchehab@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, linus.walleij@linaro.org,
	rdunlap@infradead.org, lukas@wunner.de,
	Ismail.Kose@maximintegrated.com, vilhelm.gray@gmail.com,
	sean.nyekjaer@prevas.dk, pombredanne@nexb.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: dac: Add AD5758 support
Message-ID: <20180629053509.GA2647@himanshu-Vostro-3559>
References: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
 <20180628214818.GA3577@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180628214818.GA3577@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 29, 2018 at 03:18:18AM +0530, Himanshu Jha wrote:
> On Thu, Jun 28, 2018 at 03:13:32PM +0300, Stefan Popa wrote:
> > The AD5758 is a single channel DAC with 16-bit precision which uses the
> > SPI interface that operates at clock rates up to 50MHz.
> > 
> > The output can be configured as voltage or current and is available on a
> > single terminal.
> > 
> > Datasheet:
> > http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> [..]
> > +static const int ad5758_dc_dc_ilim[6] = {
> > +	150000, 200000, 250000, 300000, 350000, 400000
> > +};
> [..]
> > +int cmpfunc(const void *a, const void *b)
> > +{
> > +	return (*(int *)a - *(int *)b);
> > +}
> 
> Since Kbuild hit a Sparse error in this function, I would also like to
> add that the above implementation of cmpfunc() is not safe.
> 
> For eg: https://wandbox.org/permlink/MqGnA3nVg7eAN4I7
> 
> The following will be safer:
> 
> static int cmpfunc(const void *a, const void *b)
> {
> 	int arg1 = *(const int*)a;
> 	int arg2 = *(const int*)b;
> 	return (arg1 > arg2) - (arg1 < arg2);
> }
> 
> [..]
> > +		index = (int *) bsearch(&tmp, ad5758_dc_dc_ilim,
> > +					ARRAY_SIZE(ad5758_dc_dc_ilim),
> > +					sizeof(int), cmpfunc);

I somehow realized that my argument is useless since we would not have
large integer subtraction, which could lead to signed integer
overflow(UB) and hence cause problems(as evident in the eg link I posted).

Sorry Stefan :(

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
