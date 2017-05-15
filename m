Return-Path: <SRS0=LYB8=4V=fi.rohmeurope.com=prvs=0308c3f7bd=Mikko.Koivunen@kernel.org>
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] iio: light: rpr0521 disable sensor -bugfix
Date: Mon, 15 May 2017 10:25:58 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC70AB@WILL-MAIL002.REu.RohmEu.com>
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <CAEnQRZA=YwX4jP95JutzDkPmtTVCR4vbiYrQRr3aBRMpvT1+5w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On 5.5.2017 14:24, Daniel Baluta wrote:=0A=
> On Fri, May 5, 2017 at 2:19 PM, Mikko Koivunen=0A=
> <mikko.koivunen@fi.rohmeurope.com> wrote:=0A=
>> Sensor was marked enabled on each call even if the call was for disablin=
g=0A=
>> sensor.=0A=
>>=0A=
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>=0A=
>> ---=0A=
>> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.=0A=
>> Patch v2->v3 changes:=0A=
>> whitespace change.=0A=
>>=0A=
>>  drivers/iio/light/rpr0521.c |   10 ++++++++--=0A=
>>  1 file changed, 8 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c=
=0A=
>> index 7de0f39..03504f6 100644=0A=
>> --- a/drivers/iio/light/rpr0521.c=0A=
>> +++ b/drivers/iio/light/rpr0521.c=0A=
>> @@ -197,7 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *=
data, u8 status)=0A=
>>         if (ret < 0)=0A=
>>                 return ret;=0A=
>>=0A=
>> -       data->als_dev_en =3D true;=0A=
> How about:=0A=
>=0A=
> data->als_dev_en =3D !!(status & RPR0521_MODE_ALS_MASK);=0A=
>=0A=
> Thanks for fixing this!=0A=
>=0A=
I got the impression previously that we should prefer verbosity instead=0A=
of shortness when it helps understanding the code. Otherwise yes, that=0A=
could work too.=0A=
=0A=
-Mikko=0A=
=0A=
