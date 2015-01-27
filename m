Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <54C79E65.6030706@gmail.com>
References: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com> <201501251947.17832.marex@denx.de> <54C6AB2B.9040709@kernel.org> <54C79E65.6030706@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----FCY2KQ3Q14S9KCEFGEZ7TB0WTM32HP"
Subject: Re: [PATCH v2 0/4] iio: mxs-lradc: fix interactions between the touchscreen and the ADC
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 27 Jan 2015 17:17:08 +0000
To: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,Jonathan Cameron <jic23@kernel.org>,Marek Vasut <marex@denx.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald <pmeerw@pmeerw.net>,Juergen Beisert <jbe@pengutronix.de>,Alexandre Belloni <alexandre.belloni@free-electrons.com>,Fabio Estevam <fabio.estevam@freescale.com>,Stefan Wahren <stefan.wahren@i2se.com>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-iio@vger.kernel.org,devel@driverdev.osuosl.org
Message-ID: <2E6734EA-AB09-474C-9D58-371ABBF6381B@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

------FCY2KQ3Q14S9KCEFGEZ7TB0WTM32HP
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8



On 27 January 2015 14:19:17 GMT+00:00, "Kristina Martšenko" <kristina.martsenko@gmail.com> wrote:
>On 26/01/15 23:01, Jonathan Cameron wrote:
>> On 25/01/15 18:47, Marek Vasut wrote:
>>> On Sunday, January 25, 2015 at 05:28:18 PM, Kristina Martšenko
>wrote:
>>>> These patches fix some issues with using the touchscreen and
>reading
>>>> other ADC channels at the same time.
>>>
>>> Entire series
>>>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>
>Thanks again!
>
>> All 4 applied to the fixes-togreg branch of iio.git and cc'd to
>> stable.
>
>Thanks, Jonathan! I'm not entirely sure if these are critical enough to
>go in stable, but alright.
>
>Kristina

It's broken and the fix doesn't effect anyone without the hardware so definitely
stable material! 
Chances are someone will release hardware based on an old kernel so best
 to drive these fixes backwards.

J

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------FCY2KQ3Q14S9KCEFGEZ7TB0WTM32HP
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><br><br><div class="gmail_quote">On 27 January 2015 14:19:17 GMT+00:00, &quot;Kristina Martšenko&quot; &lt;kristina.martsenko@gmail.com&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">On 26/01/15 23:01, Jonathan Cameron wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> On 25/01/15 18:47, Marek Vasut wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"> On Sunday, January 25, 2015 at 05:28:18 PM, Kristina Martšenko wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #8ae234; padding-left: 1ex;"> These patches fix some issues with using the touchscreen and reading<br /> other ADC channels at the same time.<br /></blockquote><br /> Entire series<br /><br /> Reviewed-by: Marek Vasut &lt;marex@denx.de&gt;<br /></blockquote></blockquote><br />Thanks again!<br /><br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> All 4 applied to the fixes-togreg branch of iio.git and
  cc'd
to<br /> stable.<br /></blockquote><br />Thanks, Jonathan! I'm not entirely sure if these are critical enough to<br />go in stable, but alright.<br /><br />Kristina<br /></pre></blockquote></div><br>
It&#39;s broken and the fix doesn&#39;t effect anyone without the hardware so definitely<br>
stable material! <br>
Chances are someone will release hardware based on an old kernel so best<br>
 to drive these fixes backwards.<br>
<br>
J<br>
<br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.</body></html>
------FCY2KQ3Q14S9KCEFGEZ7TB0WTM32HP--
