Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Date: Fri, 17 May 2013 13:28:36 +0200
Subject: Re: Use buffer without trigger
Message-ID: <2076388.y5Y0d24KYt@ctocwl0124>
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com>
 <CAEE_umq7aC5=HWAW_2N=XsLJ0y6YqBojjN0Awm3BuGmqHSzrsw@mail.gmail.com>
 <51927AEF.6080107@metafoo.de>
In-Reply-To: <51927AEF.6080107@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

I've tried to register a buffer on one iio device, but when I try to enable=
 it=20
the error massage is about the no trigger available.
I don't want a trigger for this device, I want use only one trigger of anot=
her=20
iio device for all. It is possible?
Thanks,

Denis


On Tuesday, May 14, 2013 07:57:03 PM Lars-Peter Clausen wrote:
> On 05/14/2013 06:18 PM, Denis Ciocca wrote:
> > Hi all,
> >=20
> > I have one question about iio device. I want create with only one physi=
cal
> > device a lot of iio devices because I want to activate each 'sensor'
> > without stop the buffer and reactivate with more channels.
> > But, I want to use only one trigger, for example of the major iio devic=
e.
> > It is possible to register only a buffer of one device and use the trig=
ger
> > of another one?
>=20
> Simple answer: yes.
>=20
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=
