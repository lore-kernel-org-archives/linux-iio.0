Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49872 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753393AbcGDQ3v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 12:29:51 -0400
Date: Mon, 4 Jul 2016 18:29:49 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] input: adc-keys: add DT binding documentation
Message-ID: <20160704162949.GL20045@piout.net>
References: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/2016 at 14:43:56 +0100, Jonathan Cameron wrote :
> On 01/07/16 22:30, Alexandre Belloni wrote:
> > Add documentation for ADC keys
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Clean looking binding to me - one comment inline.
> 
> Jonathan
> > ---
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > 
> >  .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> > new file mode 100644
> > index 000000000000..873476bb4eab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> > @@ -0,0 +1,45 @@
> > +Allwinner sun4i low res adc attached tablet keys
> What is allwinner specific in here?  Looks pretty general purpose to me!

That's true, I forgot to change that after shamelessly copy pasting...

I was planning to use something like ADC attached resistor ladder
buttons, unless you have a better way to describe that.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
