Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4FD5D83E.3040504@metafoo.de>
References: <1339401064-5218-1-git-send-email-michael.hennerich@analog.com>
	<CAM=Q2ctNYnq9S9fr4K6sh+k3311nMON8Yho+-vAdd3dSdOXRHg@mail.gmail.com>
	<4FD5B743.7070500@analog.com>
	<CAM=Q2csVnSs_gicDyMdKZYPNf6qC8FYD1sOcBBJ+5tSEScpu8Q@mail.gmail.com>
	<4FD5D83E.3040504@metafoo.de>
Date: Mon, 11 Jun 2012 17:59:04 +0530
Message-ID: <CAM=Q2csxqNYuLzwig5f9MWc=k8thyM7EPsvc71yd395MURLtsQ@mail.gmail.com>
Subject: Re: [PATCH] iio: ad9523: Fix argument type mismatch
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: michael.hennerich@analog.com,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 11, 2012 at 5:06 PM, Lars-Peter Clausen <lars@metafoo.de> wrote=
:
> On 06/11/2012 01:17 PM, Shubhrajyoti Datta wrote:
>> Hi Michael,
>>
>> On Mon, Jun 11, 2012 at 2:45 PM, Michael Hennerich
>> <michael.hennerich@analog.com> wrote:
>> [..]
>>>>> =A0static int ad9523_vco_out_map(struct iio_dev *indio_dev,
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned ch=
, bool out)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned ch=
, unsigned out)
>>>>
>>>> Unsigned defaults to unsigned int right shouldnt it be a char?
>>>> Or am I missing something.
>>>>

>
> The code is fine as it is, the assignment does an implicit type cast.

Ok got is now . Apologies for the noise.
