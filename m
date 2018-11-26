Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46639 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeK0GTb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Nov 2018 01:19:31 -0500
MIME-Version: 1.0
References: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
 <1542884458.30645.22.camel@analog.com> <20181125110839.4a3aecf9@archlinux>
In-Reply-To: <20181125110839.4a3aecf9@archlinux>
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Mon, 26 Nov 2018 17:24:13 -0200
Message-ID: <CAG4RSAHcEYj5bUpxT8apwXZZpWkPowFJ333tZiTHhb9VVn4m7g@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
To: Jonathan Cameron <jic23@kernel.org>
Cc: StefanSerban.Popa@analog.com,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi, thank you for the review

> On Thu, 22 Nov 2018 11:01:00 +0000
> "Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:
> > I think that instead of setting the gain directly, we should use
> > the IIO_CHAN_INFO_SCALE attribute. At page 12 of the ad7780 datasheet t=
here
> > is a formula from which the output code can be calculated:
> > Code =3D 2^(N =E2=88=92 1)
> > =C3=97 [(AIN =C3=97 Gain /VREF) + 1]. So, by setting the scale from use=
r space, the
> > driver can calculate the correct gain by using the formula above. Also,=
 it
> > would be useful to introduce scale available.
> > Furthermore, there is a new
> > ad7124 adc driver which does this exact thing. Take a look here: https:=
//gi
> > thub.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/ad7124.c#L3=
37.

We have some questions about the code you provided to us:
  1-) What is exactly the inputs for the write_raw function?
  2-) Could you give more details about the math around lines 346-348?
Is it correct to assume that the multiplication at line 346 won't
overflow? (vref is an uint)

And regarding our code:
  1-) The val in our write_raw function should be, in case of GAIN, a
number that best approximate the actual gain value of 1 or 128? For
instance, if the user inputs 126, we should default to 128?
  2-) In the case of FILTER, is it the same? Is the user sending the
value in mHz (milihertz)?

Thank you
