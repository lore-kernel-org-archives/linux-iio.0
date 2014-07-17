Return-Path: <himangi774@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53C65E8F.2080708@metafoo.de>
References: <CAB78YHwneVuVBPujeKE=rEygvtyn=VvtLtd75+pvwqxPxYcB6g@mail.gmail.com>
	<53C5656F.9030200@kernel.org>
	<53C65E8F.2080708@metafoo.de>
Date: Thu, 17 Jul 2014 23:40:04 +0530
Message-ID: <CAB78YHzEPZf-8m0zwFz5PZWkqMuX9m5W01f2JGQ+7MbAkTACPg@mail.gmail.com>
Subject: Re: question regarding drivers/staging/iio/adc/ad7280a.c
From: Himangi Saraogi <himangi774@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Content-Type: multipart/alternative; boundary=f46d044480fbcf19a204fe678c32
List-ID: <linux-iio@vger.kernel.org>

--f46d044480fbcf19a204fe678c32
Content-Type: text/plain; charset=UTF-8

Hi,

I have sent in a patch for adding devm_kasprintf
https://lkml.org/lkml/2014/7/16/667.
I will be updating this file and send in a patch once it is accepted. Was
it the right thing
to do to send the devm_kasprintf patch separately from the patch on the
file to use it for,
because the person applying the later may not see the dependency?

Thanks
Himangi


On 16 July 2014 16:44, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 07/15/2014 07:31 PM, Jonathan Cameron wrote:
>
>> On 14/07/14 21:31, Himangi Saraogi wrote:
>>
>>> Hi,
>>>
>>> The code seems to have a memory leak. The function ad7280_attr_init
>>> calls kasprintf a number of times, which calls kmalloc (or more
>>> precisely kmalloc_track_caller), but this data does not ever seem to
>>> be freed. I propose to introduce a devm_  version of kasprintf, which
>>> will be useful for other files also. I am not very sure that will it
>>> be useful to introduce a bunch of kfrees, just to remove the memory
>>> leaks immediately, but I think it would be safer just to devm
>>> everything, so then one is sure that everything is freed as it should
>>> be, in the right order.
>>>
>>>  The question here is whether such a memory leak squashing would be
>> worth applying to stable.  Personally I'd go with no. In which case
>> feel free to fix it via the introduction of a devm version.
>>
>
> devm is probably fine here.
>
> The long term fix should be to switch the driver to use
> iio_chan_spec_ext_info infrastructure which will handle the allocation and
> freeing internally in the IIO framework.
>
> - Lars
>
>

--f46d044480fbcf19a204fe678c32
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I have sent in a patch for=
 adding devm_kasprintf <a href=3D"https://lkml.org/lkml/2014/7/16/667">http=
s://lkml.org/lkml/2014/7/16/667</a>.<br>I will be updating this file and se=
nd in a patch once it is accepted. Was it the right thing<br>
to do to send the devm_kasprintf patch separately from the patch on the fil=
e to use it for,<br>because the person applying the later may not see the d=
ependency?<br><br></div>Thanks<br></div>Himangi<br> </div><div class=3D"gma=
il_extra">
<br><br><div class=3D"gmail_quote">On 16 July 2014 16:44, Lars-Peter Clause=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:lars@metafoo.de" target=3D"_blank=
">lars@metafoo.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 07/15/2014 07:31 PM, Jonathan Ca=
meron wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 14/07/14 21:31, Himangi Saraogi wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
The code seems to have a memory leak. The function ad7280_attr_init<br>
calls kasprintf a number of times, which calls kmalloc (or more<br>
precisely kmalloc_track_caller), but this data does not ever seem to<br>
be freed. I propose to introduce a devm_ =C2=A0version of kasprintf, which<=
br>
will be useful for other files also. I am not very sure that will it<br>
be useful to introduce a bunch of kfrees, just to remove the memory<br>
leaks immediately, but I think it would be safer just to devm<br>
everything, so then one is sure that everything is freed as it should<br>
be, in the right order.<br>
<br>
</blockquote>
The question here is whether such a memory leak squashing would be<br>
worth applying to stable. =C2=A0Personally I&#39;d go with no. In which cas=
e<br>
feel free to fix it via the introduction of a devm version.<br>
</blockquote>
<br></div></div>
devm is probably fine here.<br>
<br>
The long term fix should be to switch the driver to use iio_chan_spec_ext_i=
nfo infrastructure which will handle the allocation and freeing internally =
in the IIO framework.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
- Lars<br>
<br>
</font></span></blockquote></div><br></div>

--f46d044480fbcf19a204fe678c32--
