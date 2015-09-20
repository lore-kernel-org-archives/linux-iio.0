Return-Path: <cheako@mikemestnik.net>
MIME-Version: 1.0
In-Reply-To: <1442788960.1030.11.camel@hadess.net>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
	<CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
	<CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
	<55FF0433.6050900@kernel.org>
	<1442788960.1030.11.camel@hadess.net>
Date: Sun, 20 Sep 2015 17:55:18 -0500
Message-ID: <CAF8px56Nh2RcSipNoCuMvek4CyR0rJzrg13rWCNmraq4rEPZ0g@mail.gmail.com>
Subject: Re: [PATCH] Asus T300CHI.
From: Mike Mestnik <cheako@mikemestnik.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: multipart/alternative; boundary=001a113433d6b1e478052035a8d7
List-ID: <linux-iio@vger.kernel.org>

--001a113433d6b1e478052035a8d7
Content-Type: text/plain; charset=UTF-8

On Sep 20, 2015 5:42 PM, "Bastien Nocera" <hadess@hadess.net> wrote:
>
> On Sun, 2015-09-20 at 20:08 +0100, Jonathan Cameron wrote:
> > On 19/09/15 20:03, Mike Mestnik wrote:
> > > On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <
> > > daniel.baluta@gmail.com> wrote:
> > > > On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <
> > > > cheako@mikemestnik.net> wrote:
> > > > > Hello,
> > > > >   I'm looking to know the result of adding ACPI support for a
> > > > > new
> > > > > tablet, the existing support shouldn't work because of a
> > > > > misplaced
> > > > > __init that causes the function to be removed prior to being
> > > > > called.
> > > >
> > > > Are you sure about this? It seems that the existing support
> > > > doesn't work
> > > > because you have different product ids.
> > > >
> > > The driver worked much better prior to me adding the product ids.
> > >  The
> > > sensors were exposed to sysfs and all the data they collected
> > > seemed
> > > correct to me.  The big issue is that there is no software, even
> > > iio-sensor-proxy didn't know how to access the data.
> > Cc'd Bastien Nocera.
>
> iio-sensor-proxy not finding the sensor, and with it working otherwise,
> would be an iio-sensor-proxy bug. I have one of those already for the
> accelerometer in the WinBook TW100 that I haven't had time to root down
> though. See:
> https://github.com/hadess/iio-sensor-proxy/issues/39
>
> The main problem being that sensor types are already hard to detect,
> and the iio subsystem doesn't make it any easier to check whether
> there's buffered output available, or the application needs to poll.
>
> If anyone wants to fix that in the kernel, that would certainly make my
> life easier.
>
I only kind of understand the reasoning for iio, but for the case of
devices used for instructing application behaviour I can't help but think
this would be better served using/extending input events.

That would seam to cover the above issues, in exchange for having to add
support for a few new tricks.

1. An axis where max and min are actually one 'step' apart.
2. Double axis for xyz, 6 instead of 3.  Perhaps this can be handled with
extra event nodes, but then there may be sync issues.
3. Integrating iio data into input events.  I don't even understand what
this would mean.

> Cheers

--001a113433d6b1e478052035a8d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Sep 20, 2015 5:42 PM, &quot;Bastien Nocera&quot; &lt;<a href=3D"mailto:h=
adess@hadess.net">hadess@hadess.net</a>&gt; wrote:<br>
&gt;<br>
&gt; On Sun, 2015-09-20 at 20:08 +0100, Jonathan Cameron wrote:<br>
&gt; &gt; On 19/09/15 20:03, Mike Mestnik wrote:<br>
&gt; &gt; &gt; On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta &lt;<br>
&gt; &gt; &gt; <a href=3D"mailto:daniel.baluta@gmail.com">daniel.baluta@gma=
il.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik &lt;<br>
&gt; &gt; &gt; &gt; <a href=3D"mailto:cheako@mikemestnik.net">cheako@mikeme=
stnik.net</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; Hello,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0I&#39;m looking to know the result of =
adding ACPI support for a<br>
&gt; &gt; &gt; &gt; &gt; new<br>
&gt; &gt; &gt; &gt; &gt; tablet, the existing support shouldn&#39;t work be=
cause of a<br>
&gt; &gt; &gt; &gt; &gt; misplaced<br>
&gt; &gt; &gt; &gt; &gt; __init that causes the function to be removed prio=
r to being<br>
&gt; &gt; &gt; &gt; &gt; called.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Are you sure about this? It seems that the existing sup=
port<br>
&gt; &gt; &gt; &gt; doesn&#39;t work<br>
&gt; &gt; &gt; &gt; because you have different product ids.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; The driver worked much better prior to me adding the product=
 ids.<br>
&gt; &gt; &gt;=C2=A0 The<br>
&gt; &gt; &gt; sensors were exposed to sysfs and all the data they collecte=
d<br>
&gt; &gt; &gt; seemed<br>
&gt; &gt; &gt; correct to me.=C2=A0 The big issue is that there is no softw=
are, even<br>
&gt; &gt; &gt; iio-sensor-proxy didn&#39;t know how to access the data.<br>
&gt; &gt; Cc&#39;d Bastien Nocera.<br>
&gt;<br>
&gt; iio-sensor-proxy not finding the sensor, and with it working otherwise=
,<br>
&gt; would be an iio-sensor-proxy bug. I have one of those already for the<=
br>
&gt; accelerometer in the WinBook TW100 that I haven&#39;t had time to root=
 down<br>
&gt; though. See:<br>
&gt; <a href=3D"https://github.com/hadess/iio-sensor-proxy/issues/39">https=
://github.com/hadess/iio-sensor-proxy/issues/39</a><br>
&gt;<br>
&gt; The main problem being that sensor types are already hard to detect,<b=
r>
&gt; and the iio subsystem doesn&#39;t make it any easier to check whether<=
br>
&gt; there&#39;s buffered output available, or the application needs to pol=
l.<br>
&gt;<br>
&gt; If anyone wants to fix that in the kernel, that would certainly make m=
y<br>
&gt; life easier.<br>
&gt;<br>
I only kind of understand the reasoning for iio, but for the case of device=
s used for instructing application behaviour I can&#39;t help but think thi=
s would be better served using/extending input events.</p>
<p dir=3D"ltr">That would seam to cover the above issues, in exchange for h=
aving to add support for a few new tricks.</p>
<p dir=3D"ltr">1. An axis where max and min are actually one &#39;step&#39;=
 apart.<br>
2. Double axis for xyz, 6 instead of 3.=C2=A0 Perhaps this can be handled w=
ith extra event nodes, but then there may be sync issues.<br>
3. Integrating iio data into input events.=C2=A0 I don&#39;t even understan=
d what this would mean.</p>
<p dir=3D"ltr">&gt; Cheers<br>
</p>

--001a113433d6b1e478052035a8d7--
