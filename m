Return-Path: <lars@metafoo.de>
Message-ID: <508E48D1.3000703@metafoo.de>
Date: Mon, 29 Oct 2012 10:13:53 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Denis Ciocca <denis.ciocca@gmail.com>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Pavel Machek <pavel@denx.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com> <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com>
In-Reply-To: <508E4492.8080000@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 10/29/2012 09:55 AM, Denis CIOCCA wrote:
> Hi Lars-Peter,
> 
> I have modified the source code to apply your code review, now I would 
> tell you if I attach the only new patch or the full code, as you wish.

There is no attachment attached to this mail.

> 
> Also I have some question for you:
> 
> 
>> There is no a generic macro for G to MS2 in iio called IIO_G_TO_M_S_2. I
>> think you can also do the conversion of G to m/s**2 at compile time when you
>> initilize the gain attributes of the st_accel_fullscale strutcs
>>
> I don't find IIO_G_TO_M_S_2 in the framework code, but I added this 
> macro in my source code. It is exatly?

It's in the latest IIO tree and also in staging/staging-next. The definition is

+#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) \
	/ 18000000ULL)

> 
> 
>> I don't think you need the fullscale attribute. This is just the same as the
>> scale attribute just in a different representation, as far as I can see.
>>
> I think this is more useful to user because if you want change the 
> fullscale you can see immediately the current fullscale without apply 
> conversion manually.
> 

I understand your reasoning and I also think that changing the scale factor
by entering the floating point lsb resolution is rather tedious and don't
like this. On the other hand having two attributes for the same information
and more importantly doing things different from every other driver in the
IIO framework is kind of a no-go. So we have two possible solutions, both
are far from optimal, but in my opinion the first one is the lesser of the
two evils.

And hopefully the user or end-user will not have to manually navigate sysfs
but will rather use some nice abstraction which hides these details.

> 
>> I still don't get why you need this. Can't you just power-up and down the
>> device on demand?
> The boot time is too different from one sensor to another, this 
> introduce much delay in the single read.

Ok, fair enough. But what power-up times are we talking about exactly. In
the order of ms or more in the order of up to seconds?

Secondly we have similar attributes for other drivers, primarily DACs. But
the attribute is called 'powerdown' instead of 'enable'. For consistency
within the IIO framework it would be good if you could use that name (and
its semantics) as well.

> 
> 
>> I still don't get why this has to be a pointer...
> I don't understand if your point is use a pointer or use a variable or 
> it is not necessary.
> 

A plain integer should be enough. But you could also get rid of it
completely since it is only used in the probe and remove callbacks, by
adding a parameter to these functions and pass client->irq from the I2C and
SPI probe and remove functions/

- Lars
