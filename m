Return-Path: <SRS0=YG8K=KT=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180804065506.GB1727@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
 <CAHp75Vf8kMLsoFN_EK150yW_FvH8XfgjiETYAtvW63et5NNurw@mail.gmail.com>
 <20180803230922.22d628fc@archlinux> <20180804065506.GB1727@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 4 Aug 2018 23:56:17 +0300
Message-ID: <CAHp75VeDy=9o84K-PnASOMNXrNc9B1v9azWkx-wb4uLcomj_Vw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: adc: add support for mcp3911
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Kent Gustavsson <kent@minoris.se>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio <linux-iio@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sat, Aug 4, 2018 at 9:55 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> On Fri, Aug 03, 2018 at 11:09:22PM +0100, Jonathan Cameron wrote:
>> On Thu, 2 Aug 2018 22:52:00 +0300
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> > On Thu, Aug 2, 2018 at 10:15 PM, Marcus Folkesson
>> > <marcus.folkesson@gmail.com> wrote:
>> > > MCP3911 is a dual channel Analog Front End (AFE) containing two
>> > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
>> > >
>> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> >
>> > > Signed-off-by: Kent Gustavsson <kent@minoris.se>
>> >
>> > What is this? Why it's here (presense and location in the message)?
>> To clarify... If Kent wrote the patch and you are simply acting
>> as gatekeeper / upstreamer you should set the mail to be from Kent
>> and put your own Signed-off after his to basically act as a submaintainer
>> certifying you believe his sign off and all that entails.

Yep. And here the ordering is incorrect, right?

>> If it is a bit of a joint effort then that's fine but for copyright
>> purposes there should be some indication of the split.
>
> First, thank you Andy for noticing.
>
> I actually intended to use Co-Developed-by (a pretty new tag)
> in combination with Signed-off-by.
> But the tag must have disappeared in some preparation stage..
>
> From Documentation/process/submitting-patches.rst ::
>
>         A Co-Developed-by: states that the patch was also created by another developer
>         along with the original author.  This is useful at times when multiple people
>         work on a single patch.  Note, this person also needs to have a Signed-off-by:
>         line in the patch as well.
>
> I will switch order and add the Co-Developed-by-tag.
> Is this correct?
>
> Co-Developed-by: Kent Gustavsson <kent@minoris.se>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Yep, this looks good!

>> > > +       of_property_read_u32(of_node, "device-addr", &adc->dev_addr);

>> > Isn't what we called CS (chip select)?
>> Nope. We went around this in an earlier revision. It's an address transmitted
>> in the control byte to allow you to 'share' a chip select line between multiple
>> chips (crazy but true).

OK.

-- 
With Best Regards,
Andy Shevchenko
