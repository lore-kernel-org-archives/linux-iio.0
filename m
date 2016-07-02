Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbcGBTqt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 2 Jul 2016 15:46:49 -0400
Subject: Re: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
 <20160702133528.GC20045@piout.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b23bd147-0d68-a6a6-14c0-5047af35e6b7@redhat.com>
Date: Sat, 2 Jul 2016 21:46:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160702133528.GC20045@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 02-07-16 15:35, Alexandre Belloni wrote:
> On 02/07/2016 at 17:12:55 +0800, Chen-Yu Tsai wrote :
>> Hi,
>>
>> On Sat, Jul 2, 2016 at 5:00 AM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>>> Document the bindings for the Allwinner LRADC.
>>
>> We already have Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>> and I'm pretty sure Hans (CC-ed) argued that this is not a generic ADC
>> block.
>>
>> Any plans to reconcile the different bindings?
>>
>
> Yes, I already submitted an adc-keys driver that can work with any ADC:
> https://lkml.org/lkml/2016/7/1/670
>
> I agree that because it is not yet handling interrupts and is polling
> the ADC, it is not as good as sun4i-lradc-keys yet. My plan is to solve
> that but it require significant work in iio.

And it also seems to break dt compatibility. Note I'm not against
making an exception for this and breaking the dt compat, but until
the polling is fixed we should not replace sun4i-lradc-keys.

If I understand you correctly then you want to use a new generic
"sun4i-lradc" compatible. If you do that then we can just build both
drivers for now and use the right compatible depending on how the
board uses the lradc for now.

Regards,

Hans

