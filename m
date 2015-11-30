Return-Path: <ranjit.waghmode@xilinx.com>
Subject: Re: [LINUX PATCH] iio: xadc: fix for extended name remains same issue
To: Lars-Peter Clausen <lars@metafoo.de>, Ranjit Waghmode
	<ranjit.waghmode@xilinx.com>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<pmeerw@pmeerw.net>, <michal.simek@xilinx.com>, <soren.brinkmann@xilinx.com>
References: <1448345847-15051-1-git-send-email-ranjit.waghmode@xilinx.com>
 <56541566.80604@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <sbhatta@xilinx.com>, <punnaia@xilinx.com>
From: Ranjit Abhimanyu Waghmode <ranjit.waghmode@xilinx.com>
Message-ID: <565C280F.4030407@xilinx.com>
Date: Mon, 30 Nov 2015 16:12:23 +0530
MIME-Version: 1.0
In-Reply-To: <56541566.80604@metafoo.de>
Content-Type: multipart/alternative;
	boundary="------------070501030904050007020704"
List-ID: <linux-iio@vger.kernel.org>

--------------070501030904050007020704
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable



On 11/24/2015 1:14 PM, Lars-Peter Clausen wrote:
> On 11/24/2015 07:17 AM, Ranjit Waghmode wrote: >> If we read channel deta=
ils based on the device tree entry; channel=E2=80=99s scan_index >> and cha=
nnel=E2=80=99s address were overwritten by scan_index and address of channe=
l >> based on device tree. But extended name were remaining same because of=
 which >> sysfs entry names were continuous. > > I don't understand this pa=
rt. Those channels don't have a extended name, > they are always NULL. Thos=
e are added as part of this patch as well, but the > patch description make=
s it sound like it is a fix for a existing issue. > >

Sorry about the confusing description.

Actually when we try to enable the external channels in XADC by adding
entries in dts, we can see that the channel numbers are not considered
and they are taken as entries.

For e.g if we have entries in device tree like below:

xlnx,channels {
    #address-cells =3D <1>;
    #size-cells =3D <0>;

    channel@3 {
        reg =3D <3>;
    };
    channel@1 {
        reg =3D <1>;
    };
    channel@4 {
        reg =3D <4>;
    };
    channel@5 {
        reg =3D <5>;
    };
    channel@7 {
        reg =3D <7>;
    };
    channel@8 {
        reg =3D <8>;
    };
    channel@9 {
        reg =3D <9>;
    };
};


Then here observed that channel's scan_index and channel's address are
getting overwritten by scan_index of channel based on the device tree
entry. But the extended name remains same that is why it shows names are
continuous. It seems difficult to follow the VPVN and AUX channel
entries in sysfs entries.

>> >> So this patch takes care of the above issue by updating 'channels' st=
ructure >> inside xadc_parse_dt() function with the help of 'xadc_channels'=
 structure >> so that every channel's parameters will be updated properly. =
Also for the >> sake of simplicity this patch updates default values for ex=
tend_name. > > We can't really do that, that would break existing applicati=
ons. And to be > honest I don't think regular channels should have a extend=
ed name. >

So based on the above description of problem I tried to update the code.
But if you feel that it is not the ideal way of doing then can you please
help me in understanding how could I overcome this issue.

Regards,
Ranjit


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


--------------070501030904050007020704
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
</head>
<body bgcolor=3D"#FFFFFF" text=3D"#000000">
<br>
<br>
On 11/24/2015 1:14 PM, Lars-Peter Clausen wrote:<br>
<span style=3D"white-space: pre;">&gt; On 11/24/2015 07:17 AM, Ranjit Waghm=
ode wrote: &gt;&gt; If we read channel details based on the device tree ent=
ry; channel=E2=80=99s scan_index &gt;&gt; and channel=E2=80=99s address wer=
e overwritten by scan_index and address of channel &gt;&gt; based on device
 tree. But extended name were remaining same because of which &gt;&gt; sysf=
s entry names were continuous. &gt; &gt; I don't understand this part. Thos=
e channels don't have a extended name, &gt; they are always NULL. Those are=
 added as part of this patch as well, but the &gt;
 patch description makes it sound like it is a fix for a existing issue. &g=
t; &gt;</span><br>
<br>
Sorry about the confusing description.<br>
<br>
Actually when we try to enable the external channels in XADC by adding<br>
entries in dts, we can see that the channel numbers are not considered<br>
and they are taken as entries.<br>
<br>
For e.g if we have entries in device tree like below:<br>
&nbsp;<br>
xlnx,channels {<br>
&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; <br>
<br>
&nbsp;&nbsp;&nbsp; channel@3 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;3&gt;;<br>
&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; channel@1 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; channel@4 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;4&gt;;<br>
&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; channel@5 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;5&gt;;<br>
&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; channel@7 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;7&gt;;<br>
&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; channel@8 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;8&gt;;<br>
&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; channel@9 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;9&gt;;<br>
&nbsp;&nbsp;&nbsp; };<br>
};<br>
&nbsp;<br>
<br>
Then here observed that channel's scan_index and channel's address are<br>
getting overwritten by scan_index of channel based on the device tree<br>
entry. But the extended name remains same that is why it shows names are<br=
>
continuous. It seems difficult to follow the VPVN and AUX channel<br>
entries in sysfs entries.<br>
<br>
<span style=3D"white-space: pre;">&gt;&gt; &gt;&gt; So this patch takes car=
e of the above issue by updating 'channels' structure &gt;&gt; inside xadc_=
parse_dt() function with the help of 'xadc_channels' structure &gt;&gt; so =
that every channel's parameters will be updated properly.
 Also for the &gt;&gt; sake of simplicity this patch updates default values=
 for extend_name. &gt; &gt; We can't really do that, that would break exist=
ing applications. And to be &gt; honest I don't think regular channels shou=
ld have a extended name. &gt;</span><br>
<br>
So based on the above description of problem I tried to update the code.<br=
>
But if you feel that it is not the ideal way of doing then can you please<b=
r>
help me in understanding how could I overcome this issue.<br>
<br>
Regards,<br>
Ranjit<br>
<br>
<br>
This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy,
 or forward this email message or any attachments. Delete this email messag=
e and any attachments immediately.
<br>
<br>
</body>
</html>

--------------070501030904050007020704--
