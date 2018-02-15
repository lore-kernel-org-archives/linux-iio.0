Return-Path: <steve@pressers.name>
MIME-Version: 1.0
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name> <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
 <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name> <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
 <CAHp75VfPBP0TVt-==0wjcK6Oxg1kVN4mQf5Ji50RBy=SXf6yFw@mail.gmail.com>
 <eed11463-a2f6-0b4d-6138-f5082f97dd5e@pressers.name> <CAHp75Ve=B_=s5cHqcPqaAnQ3bPj+4aHpudwsfX89YqS0-M37xw@mail.gmail.com>
In-Reply-To: <CAHp75Ve=B_=s5cHqcPqaAnQ3bPj+4aHpudwsfX89YqS0-M37xw@mail.gmail.com>
From: Steve Presser <steve@pressers.name>
Date: Thu, 15 Feb 2018 18:06:41 +0000
Message-ID: <CADXBfmsJPv9Q6W+j=RdzUAHJ9Ya-6zrV9Ns7KMNBHOAnn_BZuA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Jeremy Cline <jeremy@jcline.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Lars Kellogg-Stedman <lars@oddbit.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c06b396a79e1e05654417ae"
List-ID: <linux-iio@vger.kernel.org>

--94eb2c06b396a79e1e05654417ae
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

No good news. It looks like the vanilla 4.15 series doesn't boot on this
system. Still working on tracking down why/when it broke/if this is due to
a Debian patch.

Would it still be an effective test if I backported the changes to 4.12 (or
4.12-debian)? I know that series boots.

Steve

On Thu, Feb 15, 2018, 7:50 AM Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Sun, Feb 4, 2018 at 8:25 PM, Steven Presser <steve@pressers.name>
> wrote:
>
> > The information is in kernel bug 198671.
>
> Steve, any news on testing?
> Shall I submit the series for official review?
>
> >> Here [1] is the branch with another approach. Can you test it and tell
> >> if it fixes the issue?
> >>
> >> [1]: https://bitbucket.org/andy-shev/linux/branch/topic/iio-acpi
> >> It's based on linux-next + compiletest branch of IIO subsystem.
>
> --
> With Best Regards,
> Andy Shevchenko
>

--94eb2c06b396a79e1e05654417ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,<div><br></div><div>No good news. It looks like the vanilla 4.15 se=
ries doesn&#39;t boot on this system. Still working on tracking down why/wh=
en it broke/if this is due to a Debian patch.</div><div><br></div><div>Woul=
d it still be an effective test if I backported the changes to 4.12 (or 4.1=
2-debian)? I know that series boots.</div><div><br></div><div>Steve<br><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Feb 15, 2018, 7:50 AM A=
ndy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.com">andy.shevch=
enko@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Su=
n, Feb 4, 2018 at 8:25 PM, Steven Presser &lt;<a href=3D"mailto:steve@press=
ers.name" target=3D"_blank">steve@pressers.name</a>&gt; wrote:<br>
<br>
&gt; The information is in kernel bug 198671.<br>
<br>
Steve, any news on testing?<br>
Shall I submit the series for official review?<br>
<br>
&gt;&gt; Here [1] is the branch with another approach. Can you test it and =
tell<br>
&gt;&gt; if it fixes the issue?<br>
&gt;&gt;<br>
&gt;&gt; [1]: <a href=3D"https://bitbucket.org/andy-shev/linux/branch/topic=
/iio-acpi" rel=3D"noreferrer" target=3D"_blank">https://bitbucket.org/andy-=
shev/linux/branch/topic/iio-acpi</a><br>
&gt;&gt; It&#39;s based on linux-next + compiletest branch of IIO subsystem=
.<br>
<br>
--<br>
With Best Regards,<br>
Andy Shevchenko<br>
</blockquote></div></div>

--94eb2c06b396a79e1e05654417ae--
