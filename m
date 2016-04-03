Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48801 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcDCJdc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 05:33:32 -0400
Subject: Re: [PATCH 4/4] iio: st_sensors: support open drain mode
To: Linus Walleij <linus.walleij@linaro.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-4-git-send-email-linus.walleij@linaro.org>
 <56F8F592.9010807@kernel.org>
 <CACRpkdZ37dpKsHr01M0+waXgP4xZJjxxFrNQW13Zxi1a9H+-Rg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700E36A.6080608@kernel.org>
Date: Sun, 3 Apr 2016 10:33:30 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ37dpKsHr01M0+waXgP4xZJjxxFrNQW13Zxi1a9H+-Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/16 09:15, Linus Walleij wrote:
> On Mon, Mar 28, 2016 at 11:12 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 24/03/16 13:18, Linus Walleij wrote:
> 
>>> +- st,int-pin-open-drain: the interrupt/data ready line will be configured
>>> +  as open drain, which is useful if several sensors share the same
>>> +  interrupt line.
>>
>> Really feels like this one ought to be more generic.. Mind you so does
>> drdy-int-pin!
> 
> Sorry about drdy-int-pin, it wasn't me ;)
> 
> That one is a mux kind of thing: interrupt goes out on IRQ line
> INT1 or INT2, select one...
> 
>> Hmm. Looks like most open drain controls are chip specific - other than
>> your pinctrl ones and that doesn't really map to here I guess.
> 
> Both the muxing and the OD setting can be done with pin control,
> it's just that it is like swatting a fly with a skyscraper - vast overkill
> for two interrupt lines.
> 
> I came to the conclusion that with small chips or IP blocks just
> randomly doing some muxing or biasing of a few pins isn't necessarily
> worth all the trouble of implementing pin control, the latter was
> conceived for real big arrays of pins really. There are already a
> few of these all over the kernel, e.g. the ST Multi-Purpose expander
> drivers/mfd/stmpe.c - could be pin control muxed but it'd be overkill.
> 
> So as pin control maintainer when this kind of hardware comes up
> I usually just "think it over" and then "OK then".
I can indeed see the advantages of that flexibility, but from an IIO point
of view, we are going to have a number of very similar bindings.  I can't
see a reason not to generalize the form of the binding away from a single
driver.

So lets drop the vendor prefix from this one and have
int-pin-open-drain (and drdy-int-pin ideally).
> 
>>> +     if (sdata->int_pin_open_drain) {
>>> +             dev_info(&indio_dev->dev,
>>> +                      "set interrupt line to open drain mode\n");
>>
>> Hmm. Curriously I have a board with an lis3l02dq on it where the interrupt
>> is shared, but doesn't explicitly support open drain. In that case it
>> is done with some external circuitry.
> 
> That should run fine with just the status read patch from earlier
> in the series I guess?
I'll go with a 'probably'.  Getting that part to run at all is 'interesting'
as it's minimum rate is 440Hz and my board can't keep up.
> 
>> Anyhow - I guess when I actually add support for that I'll just add a sanity
>> check in here that addr_od and mask_od are specified :)
> 
> Hm, yeah. Otherwise just patch out my enforcement of the
> OD flag for a shared line and add a comment in.
Will figure it out when / if I ever actually do those patches...

J
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

