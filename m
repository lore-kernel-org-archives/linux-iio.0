Return-Path: <otavio.salvador@gmail.com>
MIME-Version: 1.0
Sender: otavio.salvador@gmail.com
In-Reply-To: <877ggd2fkl.fsf@parenteses.org>
References: <877ggd2fkl.fsf@parenteses.org>
Date: Tue, 30 Jul 2013 19:46:51 -0300
Message-ID: <CAP9ODKqt35M833c990JhGeYvQJgK77_my01qdFwahF4xF-iEQw@mail.gmail.com>
Subject: Re: RFC: driver for TI ADS124x ADC series
From: Otavio Salvador <otavio@ossystems.com.br>
To: Mario Domenech Goulart <mario@ossystems.com.br>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 26, 2013 at 6:10 PM, Mario Domenech Goulart
<mario@ossystems.com.br> wrote:
> Hi,
>
> We are working on a driver for TI ADS124x ADC series (ADS1246,
> ADS1247 and ADS1248.  Datasheet: http://www.ti.com/litv/pdf/sbas426g)
>
> The attached patch is what we have so far.  It is by no means
> finished.  We are actually submitting it in the hope you can
> review it and provide feedback.
>
> Some observations and questions in advance:
>
> * we've set the chip to only convert on-demand.  I.e., it is not
>   constantly converting.  Conversions are only performed when
>   requested via sysfs.  We are not sure about the best approach
>   with regard to that behavior.  Should it be constantly
>   converting?
>
> * we've set the device as IIO_TEMP, although what is currently
>   exposed in sysfs is voltage. The chip is targeted to
>   temperature sensors, but the actual output of the ADC is
>   voltage, so we don't know exactly what to use as type.
>
> * we are aware of some ugly hacks like wait_for_drdy. :-) What's
>   the best approach to wait for the data ready signal?
>
> * in fact we've been mostly working with ADS1247 and haven't
>   concentrated on supporting ADS1246 and ADS1248 for now, but we
>   intend to do so.

Could someone give us some feedback on this?

We are really looking for some initial review on this patch so we can
clean it up and do the need changes to send it for official review
later.

Thanks in advance,

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
