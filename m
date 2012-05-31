Return-Path: <leed.aguilar@ti.com>
MIME-Version: 1.0
In-Reply-To: <4FC73C71.9000006@cam.ac.uk>
References: <1338437446-12829-1-git-send-email-leed.aguilar@ti.com>
	<4FC71DAC.3080802@kernel.org>
	<4FC735DF.4050507@nvidia.com>
	<4FC73C71.9000006@cam.ac.uk>
Date: Thu, 31 May 2012 08:51:42 -0500
Message-ID: <CAK+n9+bOGjqVyjuLSy3hHH7u_kq4HTpC1oHD8uVvh5ZcN0TokQ@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:magnetometer:ak8975: fix the sensor enable logic
From: "Aguilar, Leed" <leed.aguilar@ti.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=90e6ba308ef21b52e204c1555e3e
List-ID: <linux-iio@vger.kernel.org>

--90e6ba308ef21b52e204c1555e3e
Content-Type: text/plain; charset=ISO-8859-1

On Thu, May 31, 2012 at 4:40 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:

> On 5/31/2012 10:11 AM, Laxman Dewangan wrote:
>
>> On Thursday 31 May 2012 12:58 PM, Jonathan Cameron wrote:
>>
>>> Also cc'd Laxman for comments.
>>>
>>>> Allow the magn sensor raw attributes to be available only
>>>> when enable is true.
>>>>
>>>> The single measurement mode change to power-down mode
>>>> automatically once the sensor data is measured, so there
>>>> is no need to enable this mode to allow the data reading
>>>> process (ak8975_read_axis) to begin, which internally is
>>>> setting the single measurement mode to take a sample.
>>>>
>>> Hmm. I'm not terribly keen on this as it's just changed from one non
>>> abi compliant attribute to a different one.
>>>
>>> We need to take another look at how to handle low power modes etc.
>>> We could add some heuristics in driver on when to disable the device,
>>> but that is obviously not that flexible.
>>>
>>> Otherwise I'd much prefer a kernel wide view on manual disables
>>> of indivual devices to adhoc bits of code liek this...
>>>
>>> The underlying change to do with not explicitly setting power down
>>> modes is fine, but I'd like Laxman's comment on this as I don't have
>>> one.
>>>
>>
>> The measurement is done in ONCE mode and once conversion completes the
>> device automatically goes into the power down mode. Hence we need not to
>> set the power-down mode explictly.
>> However, do we really require this "enable" sysfs? I think we can get
>> rid of this sysfs as it just does the flag setting now and so we really
>> dont need as per lots of improvement done in staging driver recently.
>>
>> I will go with getting rid of this sysfs (enable or old name " mode").
>>
>>  Now that's a solution I like!
>
> Thanks, Laxman. Leed, does this work for you?
>


Yes, I considered the same idea before sending this patch.

-- 
Leed Aguilar

--90e6ba308ef21b52e204c1555e3e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Thu, May 31, 2012 at 4:40 AM, Jonathan Ca=
meron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@cam.ac.uk" target=3D"_b=
lank">jic23@cam.ac.uk</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<div class=3D"HOEnZb"><div class=3D"h5">On 5/31/2012 10:11 AM, Laxman Dewan=
gan wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Thursday 31 May 2012 12:58 PM, Jonathan Cameron wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Also cc&#39;d Laxman for comments.<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Allow the magn sensor raw attributes to be available only<br>
when enable is true.<br>
<br>
The single measurement mode change to power-down mode<br>
automatically once the sensor data is measured, so there<br>
is no need to enable this mode to allow the data reading<br>
process (ak8975_read_axis) to begin, which internally is<br>
setting the single measurement mode to take a sample.<br>
</blockquote>
Hmm. I&#39;m not terribly keen on this as it&#39;s just changed from one no=
n<br>
abi compliant attribute to a different one.<br>
<br>
We need to take another look at how to handle low power modes etc.<br>
We could add some heuristics in driver on when to disable the device,<br>
but that is obviously not that flexible.<br>
<br>
Otherwise I&#39;d much prefer a kernel wide view on manual disables<br>
of indivual devices to adhoc bits of code liek this...<br>
<br>
The underlying change to do with not explicitly setting power down<br>
modes is fine, but I&#39;d like Laxman&#39;s comment on this as I don&#39;t=
 have<br>
one.<br>
</blockquote>
<br>
The measurement is done in ONCE mode and once conversion completes the<br>
device automatically goes into the power down mode. Hence we need not to<br=
>
set the power-down mode explictly.<br>
However, do we really require this &quot;enable&quot; sysfs? I think we can=
 get<br>
rid of this sysfs as it just does the flag setting now and so we really<br>
dont need as per lots of improvement done in staging driver recently.<br>
<br>
I will go with getting rid of this sysfs (enable or old name &quot; mode&qu=
ot;).<br>
<br>
</blockquote></div></div>
Now that&#39;s a solution I like!<br>
<br>
Thanks, Laxman. Leed, does this work for you?<br>
</blockquote></div><br><br>Yes, I considered the same idea before sending t=
his patch.<br clear=3D"all"><div><br></div>-- <br>Leed Aguilar<br>

--90e6ba308ef21b52e204c1555e3e--
