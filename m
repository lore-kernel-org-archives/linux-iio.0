Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAEnQRZD-xAAWWD7De6KfNWA6OTCxX3t1Pw2Mv5HozPehvUCWnw@mail.gmail.com>
References: <1443018383-16578-1-git-send-email-peda@lysator.liu.se> <1443018383-16578-3-git-send-email-peda@lysator.liu.se> <56081053.2080209@kernel.org> <5608F375.6030808@lysator.liu.se> <CAEnQRZD-xAAWWD7De6KfNWA6OTCxX3t1Pw2Mv5HozPehvUCWnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----T9RE91WU2IY1QJ1ZYXF4MUK5SPBY3U"
Subject: Re: [PATCH v6 2/2] iio: mcp4531: Driver for Microchip digital potentiometers
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 28 Sep 2015 10:01:23 +0100
To: Daniel Baluta <daniel.baluta@gmail.com>,Peter Rosin <peda@lysator.liu.se>
CC: Jonathan Cameron <jic23@kernel.org>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,Peter Rosin <peda@axentia.se>,Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <A33F263C-A366-4ED3-AA62-F464C02F4232@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

------T9RE91WU2IY1QJ1ZYXF4MUK5SPBY3U
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8



On 28 September 2015 09:11:09 BST, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>On Mon, Sep 28, 2015 at 10:59 AM, Peter Rosin <peda@lysator.liu.se>
>wrote:
>> On 2015-09-27 17:50, Jonathan Cameron wrote:
>>> On 23/09/15 15:26, Peter Rosin wrote:
>>>> From: Peter Rosin <peda@axentia.se>
>>>>
>>>> Add support for Microchip digital potentiometers and rheostats
>>>>      MCP4531, MCP4532, MCP4551, MCP4552
>>>>      MCP4631, MCP4632, MCP4651, MCP4652
>>>>
>>>> DEVICE   Wipers  Steps  Resistor Opts (kOhm)  i2c address
>>>> MCP4531  1       129    5, 10, 50, 100        010111x
>>>> MCP4532  1       129    5, 10, 50, 100        01011xx
>>>> MCP4551  1       257    5, 10, 50, 100        010111x
>>>> MCP4552  1       257    5, 10, 50, 100        01011xx
>>>> MCP4631  2       129    5, 10, 50, 100        0101xxx
>>>> MCP4632  2       129    5, 10, 50, 100        01011xx
>>>> MCP4651  2       257    5, 10, 50, 100        0101xxx
>>>> MCP4652  2       257    5, 10, 50, 100        01011xx
>>>>
>>>> Datasheet:
>http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf
>>> Applied to the togreg branch of iio.git - initially pushed out as
>>> testing for the autobuilders to play with it.
>>>
>>> If anyone wants to add reviewed-by / acked-by then as I'll be
>>> rebasing sometime in next few days anyway there is still time!
>>
>> Great, thanks,
>>
>> but I don't see this where I expected it[1]. So, the question is if
>I'm
>> too impatient, if am I looking in the wrong place or if you perhaps
>forgot
>> to actually push it out? Or if something went totally wrong and the
>patches
>> got lost...
>
>Make sure you look for the testing branch. Also, do not worry about
>this.
>
>Sometimes, Jonathan  pushes the patches locally to his setup and later
>syncs with the remote repo.

What Daniel is politely saying is sometimes I forget to push them out!
 Oops. Machine is at home and powered down so should push testing branch this
 evening if I remember.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------T9RE91WU2IY1QJ1ZYXF4MUK5SPBY3U
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><br><br><div class="gmail_quote">On 28 September 2015 09:11:09 BST, Daniel Baluta &lt;daniel.baluta@gmail.com&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">On Mon, Sep 28, 2015 at 10:59 AM, Peter Rosin &lt;peda@lysator.liu.se&gt; wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> On 2015-09-27 17:50, Jonathan Cameron wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"> On 23/09/15 15:26, Peter Rosin wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #8ae234; padding-left: 1ex;"> From: Peter Rosin &lt;peda@axentia.se&gt;<br /><br /> Add support for Microchip digital potentiometers and rheostats<br />      MCP4531, MCP4532, MCP4551, MCP4552<br />      MCP4631, MCP4632, MCP4651, MCP4652<br /><br /> DEVICE   Wipers  Steps  Resistor Opts (kOhm)  i2c address<br /> MCP4531  1       129    5, 10, 50, 100        010111x<br /> MCP4532  1       129    5, 10, 50, 100        01011xx<br /> MCP4551  1       257    5, 10
 , 50,
100        010111x<br /> MCP4552  1       257    5, 10, 50, 100        01011xx<br /> MCP4631  2       129    5, 10, 50, 100        0101xxx<br /> MCP4632  2       129    5, 10, 50, 100        01011xx<br /> MCP4651  2       257    5, 10, 50, 100        0101xxx<br /> MCP4652  2       257    5, 10, 50, 100        01011xx<br /><br /> Datasheet: <a href="http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf">http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf</a><br /></blockquote> Applied to the togreg branch of iio.git - initially pushed out as<br /> testing for the autobuilders to play with it.<br /><br /> If anyone wants to add reviewed-by / acked-by then as I'll be<br /> rebasing sometime in next few days anyway there is still time!<br /></blockquote><br /> Great, thanks,<br /><br /> but I don't see this where I expected it[1]. So, the question is if I'm<br /> too impatient, if am I looking in the wrong place or if you perhaps forgot<br /> to actually push it out? 
 Or if
something went totally wrong and the patches<br /> got lost...<br /></blockquote><br />Make sure you look for the testing branch. Also, do not worry about this.<br /><br />Sometimes, Jonathan  pushes the patches locally to his setup and later<br />syncs with the remote repo.<br /></pre></blockquote></div><br>
What Daniel is politely saying is sometimes I forget to push them out!<br>
 Oops. Machine is at home and powered down so should push testing branch this<br>
 evening if I remember.<br>
<br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.</body></html>
------T9RE91WU2IY1QJ1ZYXF4MUK5SPBY3U--
