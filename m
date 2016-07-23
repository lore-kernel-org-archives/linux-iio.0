Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAHNg1SorRwoDQowDa=+wdrEfmNg+9esw-Jbfxm1nO+0DZWBtBA@mail.gmail.com>
References: <CAHNg1Spjoao_fndWBP7mzE=ORMGK=vSUsVmN+EPvwv912-0KqA@mail.gmail.com> <CB140955-28B8-41F1-BEEA-2F20F833267D@jic23.retrosnub.co.uk> <CAHNg1SorRwoDQowDa=+wdrEfmNg+9esw-Jbfxm1nO+0DZWBtBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----KJ0K2NZY7B0S7OY0SDZ5PXH4766JYD"
Subject: Re: How to support multiple chips in single driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 23 Jul 2016 18:24:41 +0100
To: Pratik Prajapati <pratik.prajapati12@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,linux-hwmon@vger.kernel.org,Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Message-ID: <ABB9F1BE-B585-4C76-B0AE-76DEB71909E7@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

------KJ0K2NZY7B0S7OY0SDZ5PXH4766JYD
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8



On 23 July 2016 17:38:07 BST, Pratik Prajapati <pratik.prajapati12@gmail.com> wrote:
>On Sat, Jul 23, 2016 at 8:37 PM, Jonathan Cameron
><jic23@jic23.retrosnub.co.uk> wrote:
>>
>>
>> On 23 July 2016 14:36:39 BST, Pratik Prajapati
><pratik.prajapati12@gmail.com> wrote:
>>>Hi,
>>>
>>>I want to add the threshold, event handling and interrupts support in
>>>vcnl4000 driver but those functionalities are not supported in
>>>vcnl4000, but supported in vcnl4010 .
>>>
>>>Do we have an example (IIO driver) of supporting multiple chips in a
>>>single driver?
>> Lots. E.g. adc\max1636.
>I couldn't found max1636
>https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/adc?h=testing
>and https://github.com/torvalds/linux/tree/master/drivers/iio/adc
>Or is that adc/max1363?
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------KJ0K2NZY7B0S7OY0SDZ5PXH4766JYD
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><br><br><div class="gmail_quote">On 23 July 2016 17:38:07 BST, Pratik Prajapati &lt;pratik.prajapati12@gmail.com&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">On Sat, Jul 23, 2016 at 8:37 PM, Jonathan Cameron<br />&lt;jic23@jic23.retrosnub.co.uk&gt; wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"><br /><br /> On 23 July 2016 14:36:39 BST, Pratik Prajapati &lt;pratik.prajapati12@gmail.com&gt; wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;">Hi,<br /><br />I want to add the threshold, event handling and interrupts support in<br />vcnl4000 driver but those functionalities are not supported in<br />vcnl4000, but supported in vcnl4010 .<br /><br />Do we have an example (IIO driver) of supporting multiple chips in a<br />single driver?<br /></blockquote> Lots. E.g. adc\max1636.<br /></blockquote>I couldn't found max1636<br /><a
href="https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/adc?h=testing">https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/adc?h=testing</a><br />and <a href="https://github.com/torvalds/linux/tree/master/drivers/iio/adc">https://github.com/torvalds/linux/tree/master/drivers/iio/adc</a><br />Or is that adc/max1363?<br />--<br />To unsubscribe from this list: send the line "unsubscribe linux-iio" in<br />the body of a message to majordomo@vger.kernel.org<br />More majordomo info at  <a href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br /></pre></blockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.</body></html>
------KJ0K2NZY7B0S7OY0SDZ5PXH4766JYD--
