Return-Path: <SRS0=xy2a=X5=jic23.retrosnub.co.uk=jic23@kernel.org>
In-Reply-To: <CAMpxmJWw3wCE4ch8TVik+2b3BC8Lvxbi13HGd9GxruSRLu95Mg@mail.gmail.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com> <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com> <20161213192712.gbaw4t4awayybnta@rob-hp-laptop> <CAMpxmJWw3wCE4ch8TVik+2b3BC8Lvxbi13HGd9GxruSRLu95Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----7U42AO3652HE0ZAN1SZCME6YV2F370"
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power switches
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 14 Dec 2016 17:36:06 +0000
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>,Rob Herring <robh@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Mark Rutland <mark.rutland@arm.com>,linux-iio@vger.kernel.org,linux-devicetree <devicetree@vger.kernel.org>,LKML <linux-kernel@vger.kernel.org>,Kevin Hilman <khilman@baylibre.com>,Patrick Titiano <ptitiano@baylibre.com>,Neil Armstrong <narmstrong@baylibre.com>,Linus Walleij <linus.walleij@linaro.org>,Alexandre Courbot <gnurou@gmail.com>,linux-gpio <linux-gpio@vger.kernel.org>,Sebastian Reichel <sre@kernel.org>,linux-pm <linux-pm@vger.kernel.org>,Mark Brown <broonie@kernel.org>,Liam Girdwood <lgirdwood@gmail.com>
Message-ID: <54679B04-3A57-4F0E-8EE6-BB37785F8E10@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

------7U42AO3652HE0ZAN1SZCME6YV2F370
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8



On 14 December 2016 16:58:21 GMT+00:00, Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:
>2016-12-13 20:27 GMT+01:00 Rob Herring <robh@kernel.org>:
>> On Sun, Dec 11, 2016 at 11:21:44PM +0100, Bartosz Golaszewski wrote:
>>> Some boards are equipped with simple, GPIO-driven power load
>switches.
>>> An example of such ICs is the TI tps229* series.
>>
>> How is this different than a GPIO regulator? The input and output
>> voltages just happen to be the same. I could be convinced this is
>> different enough to have a different compatible, but it somewhat
>seems
>> you want to use this for IIO, so you are creating a different binding
>> for that usecase.
>>
>
>It's more of a fixed regulator I suppose. Do you mean adding a new
>compatible to the fixed-regulator binding (e.g. "gpio-power-switch" or
>"simple-power-switch") and then providing an iio driver for toggling
>the switch?

I am rather torn on whether the IIO interface makes any sense beyond that of convenience.

A bridge to a regulator in general might make sense to cover the case of a reg effectively
acting as a DAC at the edge of the known hardware.

Lars' point about perhaps adding support for the new gpio userspace stuff to libiio would in 
this case also be rather papering over the issue.
There is known hardware there so we should describe it!

I think we should be considering this as the general case of the Linux controlled power supply.
How do we want to represent that?
Ultimately does a general regulator userspace interface make sense?

Classic case of people cutting our hardware in half and making boundaries beyond which lie dragons.

I would love to see the general case covered.

Jonathan

>
>Thanks,
>Bartosz
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------7U42AO3652HE0ZAN1SZCME6YV2F370
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<br>
<br>
On 14 December 2016 16:58:21 GMT+00:00, Bartosz Golaszewski &lt;bgolaszewski@baylibre.com&gt; wrote:<br>
&gt;2016-12-13 20:27 GMT+01:00 Rob Herring &lt;robh@kernel.org&gt;:<br>
&gt;&gt; On Sun, Dec 11, 2016 at 11:21:44PM +0100, Bartosz Golaszewski wrote:<br>
&gt;&gt;&gt; Some boards are equipped with simple, GPIO-driven power load<br>
&gt;switches.<br>
&gt;&gt;&gt; An example of such ICs is the TI tps229* series.<br>
&gt;&gt;<br>
&gt;&gt; How is this different than a GPIO regulator? The input and output<br>
&gt;&gt; voltages just happen to be the same. I could be convinced this is<br>
&gt;&gt; different enough to have a different compatible, but it somewhat<br>
&gt;seems<br>
&gt;&gt; you want to use this for IIO, so you are creating a different binding<br>
&gt;&gt; for that usecase.<br>
&gt;&gt;<br>
&gt;<br>
&gt;It&#39;s more of a fixed regulator I suppose. Do you mean adding a new<br>
&gt;compatible to the fixed-regulator binding (e.g. &quot;gpio-power-switch&quot; or<br>
&gt;&quot;simple-power-switch&quot;) and then providing an iio driver for toggling<br>
&gt;the switch?<br>
<br>
I am rather torn on whether the IIO interface makes any sense beyond that of convenience.<br>
<br>
A bridge to a regulator in general might make sense to cover the case of a reg effectively<br>
acting as a DAC at the edge of the known hardware.<br>
<br>
Lars&#39; point about perhaps adding support for the new gpio userspace stuff to libiio would in <br>
this case also be rather papering over the issue.<br>
There is known hardware there so we should describe it!<br>
<br>
I think we should be considering this as the general case of the Linux controlled power supply.<br>
How do we want to represent that?<br>
Ultimately does a general regulator userspace interface make sense?<br>
<br>
Classic case of people cutting our hardware in half and making boundaries beyond which lie dragons.<br>
<br>
I would love to see the general case covered.<br>
<br>
Jonathan<br>
<br>
&gt;<br>
&gt;Thanks,<br>
&gt;Bartosz<br>
&gt;--<br>
&gt;To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&quot; in<br>
&gt;the body of a message to majordomo@vger.kernel.org<br>
&gt;More majordomo info at  <a href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
<br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------7U42AO3652HE0ZAN1SZCME6YV2F370--
