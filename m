Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKzfze_t+D1sxP58EJeR284XbLHnrvaLOEpBgq_wdGGg2gW9XA@mail.gmail.com>
References: <CAKzfze_t+D1sxP58EJeR284XbLHnrvaLOEpBgq_wdGGg2gW9XA@mail.gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Fri, 4 Dec 2015 22:44:00 -0800
Message-ID: <CAKzfze_Ff8mWJR0kqo1v1mD_=mGCNBWPaZZ1Q+2aOzU9mzPp1A@mail.gmail.com>
Subject: Re: [RFC] pH sensors
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Dec 3, 2015 at 8:29 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> Hello et all,
>
> So currently planning on working a I2C based pH sensor and want to get
> some input on the iio_chan_type to use.
>
> There are two solutions  that can be thought of:
>
> 1) Use the current IIO_CONCENTRATION type and use the percentage of
> Hydronium (H3O+) in the solution to report to actual pH levels

I just remembered that pH is for example  -log(10**-7) = 7. so using
IIO_CONCENTRATION would require processing within the driver. So I
think option 2 is the only thing that makes sense since it would just
have a simple scaling value.

> 2) New IIO_PH type that is an typically an integer from 0 (acid) - 14 (base)
>
> Thanks,
>
> Matt
