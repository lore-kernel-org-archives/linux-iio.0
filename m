Return-Path: <jbrenner@TAOSinc.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CD16AC.2A644C7B"
Subject: RE: tsl2x7x driver Sampling frequency
Date: Mon, 9 Apr 2012 18:54:55 -0500
Message-ID: <B4B07CCC7B7A084E989CF9386538EA1D012563C2@exchsrvr.taosinc.com>
In-Reply-To: <B4B07CCC7B7A084E989CF9386538EA1D36909A@exchsrvr.taosinc.com>
References: <B4B07CCC7B7A084E989CF9386538EA1D0120B9AB@exchsrvr.taosinc.com> <4F7C82A6.80706@cam.ac.uk> <B4B07CCC7B7A084E989CF9386538EA1D01255E9B@exchsrvr.taosinc.com> <4F7EC289.50405@cam.ac.uk> <B4B07CCC7B7A084E989CF9386538EA1D36909A@exchsrvr.taosinc.com>
From: "Jon Brenner" <jbrenner@TAOSinc.com>
To: "Jonathan Cameron" <jic23@cam.ac.uk>
Cc: <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CD16AC.2A644C7B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

Trying to add in the ALS and Prox _thresh_periods.

Pls - see last email questions.

=20

Also would like to use read/raw functions but there doesn't seem to be a
corresponding bit to use correct?

So need to have  'stand alone' _show & _store functions?

=20

Jon

From: Jon Brenner=20
Sent: Friday, April 06, 2012 11:53 AM
To: Jonathan Cameron
Cc: jic23@kernel.org; linux-iio@vger.kernel.org;
linux-kernel@vger.kernel.org; dg77.kim@samsung.com
Subject: RE: tsl2x7x driver Sampling frequency

=20

=20

=20

________________________________

From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
Sent: Fri 4/6/2012 5:16 AM
To: Jon Brenner
Cc: jic23@kernel.org; linux-iio@vger.kernel.org;
linux-kernel@vger.kernel.org; dg77.kim@samsung.com
Subject: Re: tsl2x7x driver Sampling frequency

On 04/05/2012 09:54 PM, Jon Brenner wrote:
> Jonathon,
> So are you saying that I should change (remove) the sampling_frequency
> ABI, and implement 2 new (to this driver) ABIs called:
> in_intensity0_thresh_period, and in_proximity0_thresh_period?
yes.

OK - will do.


>
> Since the minimum H/W filter time (based on an minimum ALS or Prox
> integration resolution) we're working with here is 2.7ms, and a
maximum
> filter time of  up to 162ms (60 out of range * 2.7), the value is
> adjusted in milliseconds  (Khz).
> Is this acceptable?
Nope, seconds with INT_PLUS_MICRO as the iio unit type (which effecively
means that you'll always have 0 in val and you ms value
* 1000 in the val2 parameter of the callback.

=20

Not quite sure I follow.  How would the user enter the amount of 'out of
value' counts (now thought of in terms of milliseconds  <  1000) - since
converting them to frequency only gives us 160ms in the 'best worse
case'?=20

What does the user think they are entering in terms of units?

Guess I don't understand INT_PLUS_MICRO enough.  It takes entered value
and automatically multiplies it by 1000 in sticks it in val2?


>
> What about _thresh_period_available?
>
> I guess I could simply use the simple computed value of [ X =3D Atime =
*
> Integration] and display the values from minimum up to [60 * X] - but
> that seems kind of silly.
> Could simply a min and a max period be presented?
We've never defined an interface for it, but it probably would be
useful... Usually when it gets non obvious like this we just drop the
available attribute entirely.

Above example of Atime * Integration is overly simplified.  There are
several other more complex factors which affect the timing.=20

Consider it dropped here too! :-}


>
> Caveat:  A or P integration times could be changed 'post' selection of
> the _thresh_period which would of course then impact the
_thresh_period.
Yes. Hence what you do is take any value that is written and cache it.
A read gives the current actual value. When the other parameters change
you work out what the new nearest value to that requested is and switch
to that one alongside the other parameter changing.  Thus if a true set
of possible parameters is possible you will always get it, otherwise you
will fall back to the best that can be done.

Which makes my case for 'device needs to be turned off / on to implement
any all changes to operational parameters'.  Which then eleminates all
the messy mutex get/set/release that would be necessary if device was
cycled each parameter change - especially with so many changable
parameters such as these devices, (Also the delays and overhead involved
with device power cycling, internal state machine warm up etc.).  Which
is why we set it up this way from the beginning


>
> Oh what a tangled web..
Yup, common problem though with the various parameters!
>
> Jon
>
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>> Sent: Wednesday, April 04, 2012 12:20 PM
>> To: Jon Brenner
>> Cc: jic23@kernel.org; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org;
>> dg77.kim@samsung.com
>> Subject: Re: tsl2x7x driver Sampling frequency
>>
>> On 04/04/2012 05:40 PM, Jon Brenner wrote:
>>> Jonathon,
>>>
>>> You wrote;
>>> <snip>
>>> Units don't look right for sampling frequency.  Sorry, but that's an
>>> abi
>>>
>>> issue so even if it is
>>> fiddly to do the conversion to Hz it needs to be done.
>>> </snip>
>>>
>>> Need some help here.
>>> In the tsl2x7x driver sampling frequency is being used for setting
>>> "persistence register".
>>> It's actually a H/W filter.
>> Gah, you mentioned this before and I meant to look back at the
> previous times
>> we have hit this particular type of control (it's pretty common!)
>>
>>> Here is an abstract from the data sheet:
>>> --
>>> Persistence Register (0x0C)
>>> The persistence register controls the filtering interrupt
> capabilities
>>> of the device. Configurable filtering is provided to allow
> interrupts
>>> to be generated after each ADC integration cycle or if the ADC
>>> integration has produced a result that is outside of the values
>>> specified by threshold register for some specified amount of time.
>>> Separate filtering is provided for proximity and ALS functions. ALS
>>> interrupts are generated using C0DATA.
>>> --
>>> The value provided here by the ABI is actually the number of
>>> 'consecutive values out of range'.
>>>
>>> The H/W takes care of counting the consecutive values out of range
> and
>>> issues and interrupt when reached.
>>>
>>> The timing (or frequency) of these out of range values are based on
>>> the ALS or Prox integration time (determined by that respective
> setting).
>>> That being the case a fixed table of sampling "frequencies" cannot
> be
>>> reasonably defined - as the frequency can vary widely, based on
> other
>>> settings.
>>>
>>> So the register really is set to the desired number of 'values out
> of
>>> range'.
>>> To add another slight twist, the value (number of out of range)
>>> increases by 1 until 5, then by 5 until 60 - with the caveat that a
>>> value of 0 generates an interrupt every ALS or Prox integration
> cycle .
>>>
>>> Since the sysfs-bus-iio doc contained a close match with respect to
>>> the
>>> operation:
>>> Description:
>>>             Some devices have internal clocks.  This parameter sets
> the
>>>             resulting sampling frequency.  In many devices this
>>>             parameter has an effect on input filters etc rather than
>>>             simply controlling when the input is sampled.  As this
>>>             effects datardy triggers, hardware buffers and the sysfs
>>>             direct access interfaces, it may be found in any of the
>>>             relevant directories.  If it effects all of the above
>>>             then it is to be found in the base device directory.
>>>
>>> Thus we used "sampling_frequency" - but now I am wondering if it
>>> should be something else.
>>>
>>> If this is better suited for a different ABI please tell me what
> that
>>> would be.
>> I'd argue this should really be sampling frequency anyway.  It's
> actually a
>> common enough thing to see.
>> I was sure we'd hit this before and indeed we did with the
>> tmd277711 driver back in 2010 (hit the mailing list archives for that
> one).
>> Dongguen Kim was the author (cc'd).  Actually grep shows that my own
> sca3000
>> driver has this too (it's been a while!)
>>
>> It's actually made it through in the abi docs for all sorts of event
> types though I
>> think the only correct user is the sca3000 accelerometer.
>> Description is...
>>      Period of time (in seconds) for which the condition must be
>>      met before an event is generated. If direction is not
>>      specified then this period applies to both directions.
>>
>> I know it is annoying that this parameter in side the device is very
> heavily
>> dependent on other controls (often the case with this sort of
>> thing) but to have a remotely consistent interface we have to define
a
> standard
>> unit.  Hence the 'right' way to handle this is to have a cached value
> in seconds
>> and then work out the nearest possible setting when ever anything
else
> that
>> effects it is changed. Fiddly, but we are playing this game all over
> the place in
>> other drivers.
>>
>> So here you are going to have
>>
>> in_intensity0_thresh_period and in_proximity0_thresh_period
>>
>> Both probably taking values as INT_PLUS_MICRO.
>>
>> Note that we have other filters controls for events such as
hysterisis
> which is
>> common on raw adc's.
>>
>>
>> Jonathan
>>>
>>> Please help!
>>>
>>> Jon
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


------_=_NextPart_001_01CD16AC.2A644C7B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><!--[if !mso]><style>v\:* =
{behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><title>Re: tsl2x7x driver Sampling =
frequency</title><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Hello Jonathan,<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Trying to add in the ALS and Prox =
_<i>thresh</i>_periods.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Pls - see last email questions.<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Also would like to use read/raw functions but there doesn&#8217;t =
seem to be a corresponding bit to use correct?<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>So need to have &nbsp;&#8216;stand alone&#8217; _show &amp; _store =
functions?<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Jon<o:p></o:p></span></p><div style=3D'border:none;border-left:solid =
blue 1.5pt;padding:0in 0in 0in 4.0pt'><div><div =
style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in'><p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> =
Jon Brenner <br><b>Sent:</b> Friday, April 06, 2012 11:53 =
AM<br><b>To:</b> Jonathan Cameron<br><b>Cc:</b> jic23@kernel.org; =
linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; =
dg77.kim@samsung.com<br><b>Subject:</b> RE: tsl2x7x driver Sampling =
frequency<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div =
id=3DidOWAReplyText42523><div><p =
class=3DMsoNormal>&nbsp;<o:p></o:p></p></div></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div class=3DMsoNormal =
align=3Dcenter style=3D'text-align:center'><hr size=3D3 width=3D"100%" =
align=3Dcenter></div><p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> =
Jonathan Cameron <a =
href=3D"mailto:[mailto:jic23@cam.ac.uk]">[mailto:jic23@cam.ac.uk]</a><br>=
<b>Sent:</b> Fri 4/6/2012 5:16 AM<br><b>To:</b> Jon =
Brenner<br><b>Cc:</b> <a =
href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>; <a =
href=3D"mailto:linux-iio@vger.kernel.org">linux-iio@vger.kernel.org</a>; =
<a =
href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org=
</a>; <a =
href=3D"mailto:dg77.kim@samsung.com">dg77.kim@samsung.com</a><br><b>Subje=
ct:</b> Re: tsl2x7x driver Sampling =
frequency</span><o:p></o:p></p></div><div><p><span =
style=3D'font-size:10.0pt'>On 04/05/2012 09:54 PM, Jon Brenner =
wrote:<br>&gt; Jonathon,<br>&gt; So are you saying that I should change =
(remove) the sampling_frequency<br>&gt; ABI, and implement 2 new (to =
this driver) ABIs called:<br>&gt; in_intensity0_thresh_period, and =
in_proximity0_thresh_period?<br>yes.</span><o:p></o:p></p><p><span =
style=3D'font-size:10.0pt'>OK - will do.</span><o:p></o:p></p><p><span =
style=3D'font-size:10.0pt'><br>&gt;<br>&gt; Since the minimum H/W filter =
time (based on an minimum ALS or Prox<br>&gt; integration resolution) =
we're working with here is 2.7ms, and a maximum<br>&gt; filter time =
of&nbsp; up to 162ms (60 out of range * 2.7), the value is<br>&gt; =
adjusted in milliseconds&nbsp; (Khz).<br>&gt; Is this =
acceptable?<br>Nope, seconds with INT_PLUS_MICRO as the iio unit type =
(which effecively<br>means that you'll always have 0 in val and you ms =
value<br>* 1000 in the val2 parameter of the =
callback.</span><o:p></o:p></p></div><p>&nbsp;<o:p></o:p></p><p><span =
style=3D'font-size:10.0pt'>Not quite sure I follow.&nbsp; How would the =
user enter the amount of 'out of value' counts (now thought of in terms =
of milliseconds&nbsp; &lt;&nbsp; 1000)&nbsp;- since converting them to =
frequency only gives us 160ms in the 'best worse =
case'?&nbsp;<o:p></o:p></span></p><p><span =
style=3D'font-size:10.0pt'>What does the user think they are entering in =
terms of units?<o:p></o:p></span></p><p><span =
style=3D'font-size:10.0pt'>Guess I don't understand INT_PLUS_MICRO =
enough.&nbsp; It takes entered value and automatically multiplies it by =
1000 in sticks it in val2?<o:p></o:p></span></p><p><span =
style=3D'font-size:10.0pt'><br>&gt;<br>&gt; What about =
_thresh_period_available?<br>&gt;<br>&gt; I guess I could simply use the =
simple computed value of [ X =3D Atime *<br>&gt; Integration] and =
display the values from minimum up to [60 * X] - but<br>&gt; that seems =
kind of silly.<br>&gt; Could simply a min and a max period be =
presented?<br>We've never defined an interface for it, but it probably =
would be<br>useful... Usually when it gets non obvious like this we just =
drop the<br>available attribute entirely.<o:p></o:p></span></p><p><span =
style=3D'font-size:10.0pt'>Above example of Atime * Integration is =
overly simplified.&nbsp; There are several other more complex factors =
which affect the timing. <o:p></o:p></span></p><p><span =
style=3D'font-size:10.0pt'>Consider it dropped here too! =
:-}<o:p></o:p></span></p><p><span =
style=3D'font-size:10.0pt'><br>&gt;<br>&gt; Caveat:&nbsp; A or P =
integration times could be changed 'post' selection of<br>&gt; the =
_thresh_period which would of course then impact the =
_thresh_period.<br>Yes. Hence what you do is take any value that is =
written and cache it.<br>A read gives the current actual value. When the =
other parameters change<br>you work out what the new nearest value to =
that requested is and switch<br>to that one alongside the other =
parameter changing.&nbsp; Thus if a true set<br>of possible parameters =
is possible you will always get it, otherwise you<br>will fall back to =
the best that can be done.<o:p></o:p></span></p><p><span =
style=3D'font-size:10.0pt'>Which makes my case for 'device needs to be =
turned off&nbsp;/ on to implement any all changes to operational =
parameters'.&nbsp; Which then eleminates all the messy mutex =
get/set/release that would be necessary if device was cycled each =
parameter change - especially with so many changable parameters such as =
these devices, (Also&nbsp;the delays and overhead involved with device =
power cycling, internal state machine warm up etc.).&nbsp; Which is why =
we set it up this way from the beginning<o:p></o:p></span></p><p =
style=3D'margin-bottom:12.0pt'><span =
style=3D'font-size:10.0pt'><br>&gt;<br>&gt; Oh what a tangled =
web..<br>Yup, common problem though with the various =
parameters!<br>&gt;<br>&gt; Jon<br>&gt;<br>&gt;&gt; -----Original =
Message-----<br>&gt;&gt; From: Jonathan Cameron [<a =
href=3D"mailto:jic23@cam.ac.uk">mailto:jic23@cam.ac.uk</a>]<br>&gt;&gt; =
Sent: Wednesday, April 04, 2012 12:20 PM<br>&gt;&gt; To: Jon =
Brenner<br>&gt;&gt; Cc: <a =
href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>; <a =
href=3D"mailto:linux-iio@vger.kernel.org">linux-iio@vger.kernel.org</a>;<=
br>&gt; <a =
href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org=
</a>;<br>&gt;&gt; <a =
href=3D"mailto:dg77.kim@samsung.com">dg77.kim@samsung.com</a><br>&gt;&gt;=
 Subject: Re: tsl2x7x driver Sampling frequency<br>&gt;&gt;<br>&gt;&gt; =
On 04/04/2012 05:40 PM, Jon Brenner wrote:<br>&gt;&gt;&gt; =
Jonathon,<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; You wrote;<br>&gt;&gt;&gt; =
&lt;snip&gt;<br>&gt;&gt;&gt; Units don't look right for sampling =
frequency.&nbsp; Sorry, but that's an<br>&gt;&gt;&gt; =
abi<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; issue so even if it =
is<br>&gt;&gt;&gt; fiddly to do the conversion to Hz it needs to be =
done.<br>&gt;&gt;&gt; &lt;/snip&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Need =
some help here.<br>&gt;&gt;&gt; In the tsl2x7x driver sampling frequency =
is being used for setting<br>&gt;&gt;&gt; &quot;persistence =
register&quot;.<br>&gt;&gt;&gt; It's actually a H/W filter.<br>&gt;&gt; =
Gah, you mentioned this before and I meant to look back at the<br>&gt; =
previous times<br>&gt;&gt; we have hit this particular type of control =
(it's pretty common!)<br>&gt;&gt;<br>&gt;&gt;&gt; Here is an abstract =
from the data sheet:<br>&gt;&gt;&gt; --<br>&gt;&gt;&gt; Persistence =
Register (0x0C)<br>&gt;&gt;&gt; The persistence register controls the =
filtering interrupt<br>&gt; capabilities<br>&gt;&gt;&gt; of the device. =
Configurable filtering is provided to allow<br>&gt; =
interrupts<br>&gt;&gt;&gt; to be generated after each ADC integration =
cycle or if the ADC<br>&gt;&gt;&gt; integration has produced a result =
that is outside of the values<br>&gt;&gt;&gt; specified by threshold =
register for some specified amount of time.<br>&gt;&gt;&gt; Separate =
filtering is provided for proximity and ALS functions. =
ALS<br>&gt;&gt;&gt; interrupts are generated using =
C0DATA.<br>&gt;&gt;&gt; --<br>&gt;&gt;&gt; The value provided here by =
the ABI is actually the number of<br>&gt;&gt;&gt; 'consecutive values =
out of range'.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; The H/W takes care of =
counting the consecutive values out of range<br>&gt; and<br>&gt;&gt;&gt; =
issues and interrupt when reached.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; The =
timing (or frequency) of these out of range values are based =
on<br>&gt;&gt;&gt; the ALS or Prox integration time (determined by that =
respective<br>&gt; setting).<br>&gt;&gt;&gt; That being the case a fixed =
table of sampling &quot;frequencies&quot; cannot<br>&gt; =
be<br>&gt;&gt;&gt; reasonably defined - as the frequency can vary =
widely, based on<br>&gt; other<br>&gt;&gt;&gt; =
settings.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; So the register really is set =
to the desired number of 'values out<br>&gt; of<br>&gt;&gt;&gt; =
range'.<br>&gt;&gt;&gt; To add another slight twist, the value (number =
of out of range)<br>&gt;&gt;&gt; increases by 1 until 5, then by 5 until =
60 - with the caveat that a<br>&gt;&gt;&gt; value of 0 generates an =
interrupt every ALS or Prox integration<br>&gt; cycle =
.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Since the sysfs-bus-iio doc contained =
a close match with respect to<br>&gt;&gt;&gt; the<br>&gt;&gt;&gt; =
operation:<br>&gt;&gt;&gt; Description:<br>&gt;&gt;&gt; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Some =
devices have internal clocks.&nbsp; This parameter sets<br>&gt; =
the<br>&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resulting sampling =
frequency.&nbsp; In many devices this<br>&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parameter has an effect on =
input filters etc rather than<br>&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simply controlling when the =
input is sampled.&nbsp; As this<br>&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; effects datardy triggers, =
hardware buffers and the sysfs<br>&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; direct access interfaces, it =
may be found in any of the<br>&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; relevant directories.&nbsp; =
If it effects all of the above<br>&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; then it is to be found in the =
base device directory.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Thus we used =
&quot;sampling_frequency&quot; - but now I am wondering if =
it<br>&gt;&gt;&gt; should be something =
else.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; If this is better suited for a =
different ABI please tell me what<br>&gt; that<br>&gt;&gt;&gt; would =
be.<br>&gt;&gt; I'd argue this should really be sampling frequency =
anyway.&nbsp; It's<br>&gt; actually a<br>&gt;&gt; common enough thing to =
see.<br>&gt;&gt; I was sure we'd hit this before and indeed we did with =
the<br>&gt;&gt; tmd277711 driver back in 2010 (hit the mailing list =
archives for that<br>&gt; one).<br>&gt;&gt; Dongguen Kim was the author =
(cc'd).&nbsp; Actually grep shows that my own<br>&gt; =
sca3000<br>&gt;&gt; driver has this too (it's been a =
while!)<br>&gt;&gt;<br>&gt;&gt; It's actually made it through in the abi =
docs for all sorts of event<br>&gt; types though I<br>&gt;&gt; think the =
only correct user is the sca3000 accelerometer.<br>&gt;&gt; Description =
is...<br>&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; Period of time (in seconds) =
for which the condition must be<br>&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; met =
before an event is generated. If direction is not<br>&gt;&gt; =
&nbsp;&nbsp;&nbsp;&nbsp; specified then this period applies to both =
directions.<br>&gt;&gt;<br>&gt;&gt; I know it is annoying that this =
parameter in side the device is very<br>&gt; heavily<br>&gt;&gt; =
dependent on other controls (often the case with this sort =
of<br>&gt;&gt; thing) but to have a remotely consistent interface we =
have to define a<br>&gt; standard<br>&gt;&gt; unit.&nbsp; Hence the =
'right' way to handle this is to have a cached value<br>&gt; in =
seconds<br>&gt;&gt; and then work out the nearest possible setting when =
ever anything else<br>&gt; that<br>&gt;&gt; effects it is changed. =
Fiddly, but we are playing this game all over<br>&gt; the place =
in<br>&gt;&gt; other drivers.<br>&gt;&gt;<br>&gt;&gt; So here you are =
going to have<br>&gt;&gt;<br>&gt;&gt; in_intensity0_thresh_period and =
in_proximity0_thresh_period<br>&gt;&gt;<br>&gt;&gt; Both probably taking =
values as INT_PLUS_MICRO.<br>&gt;&gt;<br>&gt;&gt; Note that we have =
other filters controls for events such as hysterisis<br>&gt; which =
is<br>&gt;&gt; common on raw adc's.<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; =
Jonathan<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Please =
help!<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Jon<br>&gt;&gt;&gt; =
--<br>&gt;&gt;&gt; To unsubscribe from this list: send the line =
&quot;unsubscribe linux-iio&quot;<br>&gt;&gt;&gt; in the body of a =
message to <a =
href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a> =
More majordomo<br>&gt;&gt;&gt; info at&nbsp; <a =
href=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.or=
g/majordomo-info.html</a><br>&gt;<br>&gt; --<br>&gt; To unsubscribe from =
this list: send the line &quot;unsubscribe linux-iio&quot; in<br>&gt; =
the body of a message to <a =
href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a><b=
r>&gt; More majordomo info at&nbsp; <a =
href=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.or=
g/majordomo-info.html</a><o:p></o:p></span></p></div></div></body></html>
------_=_NextPart_001_01CD16AC.2A644C7B--
