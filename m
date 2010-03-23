Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Tue, 23 Mar 2010 12:23:35 +0000
Subject: RE: [PATCH] iio_trigger_find_by_name: Skip trailing newline if
 available
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E5660F259@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D944F@LIMKCMBX1.ad.analog.com>
 <4BA7D50D.2080202@cam.ac.uk>
In-Reply-To: <4BA7D50D.2080202@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-03-22:
> On 03/08/10 09:31, Hennerich, Michael wrote:
>> Skip trailing newline if available.
>>
>> From: Michael Hennerich <Michael.Hennerich@analog.com>
>
> Dear Michael,
>
> Just found this one whilst trying to sort out a clean iio tree.
> (sorry I completely failed to reply originally)
>
> Anyhow, I agree with the principal that we should be ignoring the
> newline.  Actually we should be ignoring whitespace before and after
> the string we are actually after.

Well - in most cases people use #echo so there shouldn't be a problem with =
white space before and after.
However the newline is going to bug in case you don't use #echo -n.
I've seen many sysfs_set functions also stripping the '\n' from the string.

> Perhaps a cleaner approach is to
> use sscanf to pull out the string alone?

sscanf() is certainly a alternative here.

> I don't think we need to
> allow for whitespace in the trigger name (though obviously it should
> be documented if we do not).  Technically I believe (via the
> convenient lwn article last week on the topic) we should ignore white
> space but return -EINVAL if there is say one word, some white space
> and then another word...  Not sure if there is a particularly clean
> way to do that however.
>
> What do you think?

I agree - Don't allow whitespace in the trigger name.

Michael

>
> Jonathan
>>
>> Index: drivers/staging/iio/industrialio-trigger.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- drivers/staging/iio/industrialio-trigger.c  (revision 8368)
>> +++ drivers/staging/iio/industrialio-trigger.c  (working copy)
>> @@ -155,6 +155,9 @@
>>         struct iio_trigger *trig;
>>         bool found =3D false;
>> +       if (len && name[len - 1] =3D=3D '\n')
>> +               len--;
>> +
>>         mutex_lock(&iio_trigger_list_lock);
>>         list_for_each_entry(trig, &iio_trigger_list, list) {
>>                 if (strncmp(trig->name, name, len) =3D=3D 0) {
>> ------------------------------------------------------------------
>> ********* Analog Devices GmbH              Open Platform Solutions
>> **  *****
>> **     ** Wilhelm-Wagenfeld-Strasse 6
>> **  ***** D-80807 Munich
>> ********* Germany
>> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel=
,
>> William A. Martin, Margaret K. Seif
>>
>>
>>
Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
